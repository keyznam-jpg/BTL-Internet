function startCountdown(target, seconds, onExpired) {
    const el = typeof target === 'string' ? document.getElementById(target) : target;
    if (!el) return;

    let remaining = seconds;

    const render = () => {
        const minutes = Math.floor(remaining / 60).toString().padStart(2, '0');
        const secs = (remaining % 60).toString().padStart(2, '0');
        el.textContent = `${minutes}:${secs}`;
        if (remaining <= 0) {
            el.classList.add('expired');
            if (typeof onExpired === 'function') {
                onExpired();
            }
        }
    };

    render();
    if (remaining <= 0) return;

    const timer = setInterval(() => {
        remaining -= 1;
        if (remaining <= 0) {
            remaining = 0;
            clearInterval(timer);
        }
        render();
    }, 1000);
}

function pollPaymentStatus(url, onCompleted, onExpired) {
    const poll = () => {
        fetch(url, { cache: 'no-store' })
            .then((res) => res.json())
            .then((data) => {
                if (data.status === 'completed') {
                    if (typeof onCompleted === 'function') {
                        onCompleted(data);
                    }
                } else if (data.status === 'expired') {
                    if (typeof onExpired === 'function') {
                        onExpired();
                    }
                } else if (data.status === 'invalid') {
                    if (typeof onExpired === 'function') {
                        onExpired('invalid');
                    }
                } else {
                    setTimeout(poll, 3000);
                }
            })
            .catch(() => {
                setTimeout(poll, 4000);
            });
    };
    poll();
}

function copyToClipboard(text, noticeElement) {
    if (!navigator.clipboard) {
        const textarea = document.createElement('textarea');
        textarea.value = text;
        document.body.appendChild(textarea);
        textarea.select();
        document.execCommand('copy');
        document.body.removeChild(textarea);
    } else {
        navigator.clipboard.writeText(text);
    }
    if (noticeElement) {
        noticeElement.classList.add('show');
        setTimeout(() => noticeElement.classList.remove('show'), 2500);
    }
}
