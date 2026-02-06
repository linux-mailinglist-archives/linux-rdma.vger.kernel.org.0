Return-Path: <linux-rdma+bounces-16628-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFbTJLOKhWlVDQQAu9opvQ
	(envelope-from <linux-rdma+bounces-16628-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 07:31:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CECFAAFA
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 07:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5115302E7D9
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 06:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A694304976;
	Fri,  6 Feb 2026 06:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HRndPdT/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03A52E5B32
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 06:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770359471; cv=pass; b=donR+dZnL5MPNUL/xns+4fKS2yJnFQoEj8VVwqW7GO/4eAJOyKhEIchGL+F12sYtlYsrEoP+8dAt1a0BH8vg/zbzlCVaaDtiMKg9SR9LAJo+j4yY2oknBEeGm468gwJnLcxVOJb5RxtxKCsP7BwhNqAwJ1t8uWxzNzCUsSp3DUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770359471; c=relaxed/simple;
	bh=EIIKhyUooX3r/PdbexoCYcF38HhO9Z8ryf5x/gXXUYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7MCDUS2kJd0FWgr5NWNacSs9e+iivf7BiVQVjXjlKymXMuD6Z4BR+jImqWuwYd2L7WqJLaVTgUaQZugorujfyyzsRjUhRcKCQPwP27Ux4gmBK4xl8w+hPjhtqk3rniDmUlxvHO/WNU/nzwLHXaGJU+7Ii97S/o0r4Xpjrc4hCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HRndPdT/; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-385cfc572f1so18051181fa.3
        for <linux-rdma@vger.kernel.org>; Thu, 05 Feb 2026 22:31:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770359469; cv=none;
        d=google.com; s=arc-20240605;
        b=aKIFnGyjTalVs87UeOJvsxbroO/lYhLfS9FFwwg/KfxZioIvPM8A44AhFJNr/P/+jR
         N1OztpctpI7nUh/piKI6e39HpOn9ZJyO2/txqhwV9scAxykzFx9kMCPMI8bZvGc7l8kl
         307qZY5BJQ4Kmg+/SXSH/CuEnb152zBYZReV37tpYcLWPOeQsZFMu5hYoszZ3g1e0rhH
         YSMGEs9MiQ9AZZ0h38Yi6H/lnIWpJ+WbQSOdO69yBAVE783Xb/QQSJ+4On3yc0UeBOcc
         h6BD+7iSVvIW+aZxTiwY7HdOrqHkHhbm8k1Dpz9cwq8707AhhGMB6PaZUepCTsKloLvT
         fdaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Y7YKNjA07d2mDbxaHmncYluZfOIRQwuYJydAZEyrOgc=;
        fh=X5c+Xkbkphrq3mU7ubchHT3sTEBf+cHgGCpgcF1eiAQ=;
        b=B0w8F1GmQpwRLojY8CbI8BuKa/xr5j41oZ2uCOsJpXqcgZG8uVKTLrRo8YoNzgOoAm
         4Y6ZOC/gRIzt9hct+bqL6jD3Sj/rLtLTtCVmO9E4q4rbCqvXeTvqLhBkLOp1CPuLTppX
         yTd6IZe3zZq19Nx94xn2yxVJOaZA4wx6j0BE9TMXSOVKhTQsfJfrsu21g95QLzmutVXF
         CxONxvxmvc2U66KvEhcXzdmBOJ6/laRCFs+eWORUBl+MJU7jpprxcouWh/sZ5XqmREXQ
         gEIQotCyfF1IbbArPYi6L9/BDFKvEuI290qmz/NzEkh7ulVlG92/+lq4Y+zMWH3q66oi
         vGtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770359469; x=1770964269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7YKNjA07d2mDbxaHmncYluZfOIRQwuYJydAZEyrOgc=;
        b=HRndPdT/yY6VRrBN5PXD3P4wuaqssnUl87jc9dQt3iGhs0FpRHEt6h4Ty+QL/77Qzm
         IMkAUJRIVwCFJpjmE49NT6/QPuLdLhN3WB+hR0k5fN1RJrOUxWN0Yp2iqCV+LquRSw37
         k9uXig1ZRFdekOnLZUNMfn2A9EcJCvkvcK7pJ12cFiW4VbDtdWWvK92aZTuv3IPrIlId
         b5HcY3Z1onQUPMnF+VWYomzl0ZoHrigJA58TJVutBhZL9+dVhZHB4nH18r4309g0U1V8
         naEqxZqNMjnb0uQJKYUu93FT7pulyywUY7wOieWFjaINgq4MNXxuhcx+sthOCZDVmLH4
         34rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770359469; x=1770964269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7YKNjA07d2mDbxaHmncYluZfOIRQwuYJydAZEyrOgc=;
        b=BqZGKczw/zyJYS12kbmczRH7SsZTtfuZPPhTmuBmuOZkQMW66JKNryzynMwHXOaPqH
         +SF+hyZyyk1PzM1GKhQDjEWxfQ0rB2irlBltDfAquy2qLlLYLi3SonNPfYC44JAJXTM+
         eanmmpIp+Mv1eK4NM/+4MXl9vy7mwQS8RGKZFu6XrhGdt8fNSX6dp/oRtJa5UjbR62Ee
         xI9SWCkIAEplD3eANwaM1fWKysZD2/woYPoFvQQaulbTZGUesveFxuwV3MtjgEjzItMU
         MCSb028D8hvzkZw4btN5yIGkORmbkgZt8CFr7TjSFOww3qBpqzN11NPXpHvVe5C7Y3Sd
         kogw==
X-Forwarded-Encrypted: i=1; AJvYcCXVDm2gNrwGjwLONPsEFnbH5Rzr6a8tY2wbmWLSq+EGkZKiy8C57meRdaKREEomTjYrhgbA6PIpGjhS@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2GUyr5fLryNREk8AVH3+EOVWOb39KmXEOopf6WWUha79VIRL1
	o9eHS2d26BFqZrzHt6qJQA4yJqRkJCzf0geyqCNpRdmyJJiIvQ1DQia96NulvgR83azVFqWCgUx
	XrMHZf+C+tWDrvGBOzDqOQKu+tBybmJvkngPL5Xz3
X-Gm-Gg: AZuq6aJ+gaPpJ08UEMf2+6rt3twOi3HS0W22fnov+N3nTCNT0inyuOM1j2z9OFHTRjk
	Lp5YIzYzxXVjSs3pYz2HUUzTx+ysuBpr6tXkTDbRmVGBi4AtHbBDILK0RBoZQejWXqIDk675a52
	mE2LWgqMdw2MX3o2cBWMwzpNhC6tf6+vR7cvnbvaQrCVfj4pHRH2QARh5B5ljnGFezeZeeN1U1h
	2uPesfV7BKgLhq3fiJm49MX4pRedKAOsGYugyuUqjmDMrfHUVSeGUhDL5fAs/le7/BvHgzKu7Q1
	2c2Q015gZQImOZqLBa0sG+p0Sy5M
X-Received: by 2002:a2e:a54e:0:b0:385:c10f:122 with SMTP id
 38308e7fff4ca-386b4ecab71mr6195491fa.3.1770359468625; Thu, 05 Feb 2026
 22:31:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69858738.050a0220.3b3015.002e.GAE@google.com>
In-Reply-To: <69858738.050a0220.3b3015.002e.GAE@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 6 Feb 2026 07:30:57 +0100
X-Gm-Features: AZwV_QigtRwHzRcz_qBwbEDZvHBUNHfkbq78REtw9jaCSitdZoy6tbcP7YfM-7s
Message-ID: <CACT4Y+ZQh5AQo7UuAKUNdJWZMBjKi9VA8aNFnT21sq=3yyeGjg@mail.gmail.com>
Subject: Re: [syzbot] [smc?] KCSAN: data-race in smc_switch_to_fallback /
 sock_poll (2)
To: syzbot <syzbot+198c20fde37cb9f6b0ac@syzkaller.appspotmail.com>
Cc: alibuda@linux.alibaba.com, davem@davemloft.net, dust.li@linux.alibaba.com, 
	edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, mjambigi@linux.ibm.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sidraya@linux.ibm.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8e27f4588a0f2183];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16628-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,syzkaller.appspot.com:url,appspotmail.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dvyukov@google.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,198c20fde37cb9f6b0ac];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 07CECFAAFA
X-Rspamd-Action: no action

On Fri, 6 Feb 2026 at 07:16, syzbot
<syzbot+198c20fde37cb9f6b0ac@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    5fd0a1df5d05 Merge tag 'v6.19rc8-smb3-client-fixes' of git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1070aa5a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8e27f4588a0f2183
> dashboard link: https://syzkaller.appspot.com/bug?extid=198c20fde37cb9f6b0ac
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a09cd69509c3/disk-5fd0a1df.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f218ec1eb157/vmlinux-5fd0a1df.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8549229eee91/bzImage-5fd0a1df.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+198c20fde37cb9f6b0ac@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in smc_switch_to_fallback / sock_poll
>
> write to 0xffff888127398c18 of 8 bytes by task 14369 on cpu 1:
>  smc_switch_to_fallback+0x4ea/0x7e0 net/smc/af_smc.c:933
>  smc_sendmsg+0xce/0x2f0 net/smc/af_smc.c:2797
>  sock_sendmsg_nosec net/socket.c:727 [inline]
>  __sock_sendmsg net/socket.c:742 [inline]
>  ____sys_sendmsg+0x5af/0x600 net/socket.c:2592
>  ___sys_sendmsg+0x195/0x1e0 net/socket.c:2646
>  __sys_sendmsg net/socket.c:2678 [inline]
>  __do_sys_sendmsg net/socket.c:2683 [inline]
>  __se_sys_sendmsg net/socket.c:2681 [inline]
>  __x64_sys_sendmsg+0xd4/0x160 net/socket.c:2681
>  x64_sys_call+0x17ba/0x3000 arch/x86/include/generated/asm/syscalls_64.h:47
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff888127398c18 of 8 bytes by task 14367 on cpu 0:
>  sock_poll+0x27/0x240 net/socket.c:1427
>  vfs_poll include/linux/poll.h:82 [inline]
>  __io_arm_poll_handler+0x1ee/0xb80 io_uring/poll.c:581
>  io_poll_add+0x69/0xf0 io_uring/poll.c:899
>  __io_issue_sqe+0xfd/0x2d0 io_uring/io_uring.c:1793
>  io_issue_sqe+0x20b/0xc20 io_uring/io_uring.c:1816
>  io_queue_sqe io_uring/io_uring.c:2043 [inline]
>  io_submit_sqe io_uring/io_uring.c:2321 [inline]
>  io_submit_sqes+0x78a/0x11b0 io_uring/io_uring.c:2435
>  __do_sys_io_uring_enter io_uring/io_uring.c:3285 [inline]
>  __se_sys_io_uring_enter+0x1bf/0x1c70 io_uring/io_uring.c:3224
>  __x64_sys_io_uring_enter+0x78/0x90 io_uring/io_uring.c:3224
>  x64_sys_call+0x27e4/0x3000 arch/x86/include/generated/asm/syscalls_64.h:427
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0xffff88811a6056c0 -> 0xffff88811a606080
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 14367 Comm: syz.8.3658 Not tainted syzkaller #0 PREEMPT(voluntary)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> ==================================================================

Here is what LLM said re harmfull-ness of this data race.
It does not look totally bogus to me. At least the read of
file->private_data in sock_poll() needs to be done with READ_ONCE to
avoid the harmful scenario. I don't know if changing the fundamental
socket function because of this it's the best solution, though.

========

The data race occurs on the `file->private_data` field of a socket
file descriptor. This field is being updated in
`smc_switch_to_fallback()` (to point to the underlying TCP/CLC socket
instead of the SMC socket) while concurrently being read in
`sock_poll()`.

### Analysis of the Race

1.  **Nature of the Access**: `smc_switch_to_fallback()` is performing
a plain write to `file->private_data`, and `sock_poll()` is performing
a plain read. There is no mutual exclusion (like a lock) or memory
barrier protecting this transition.
2.  **Type Confusion Risk**: In `sock_poll()`, the code first reads
`file->private_data` into a local variable `sock`, then reads
`sock->ops`, and finally calls `ops->poll(file, sock, wait)`. If the
compiler reloads `sock` from `file->private_data` between these steps
(which is permitted under the C memory model for non-volatile
accesses), it could fetch the `ops` from the SMC socket but then call
that `ops->poll` function (i.e., `smc_poll`) passing the TCP socket as
the `sock` argument.
3.  **Consequences of Type Confusion**: `smc_poll()` casts the `struct
socket *sock` to a `struct smc_sock *`. A TCP socket (`struct
tcp_sock`) is not compatible with `struct smc_sock`. Accessing
SMC-specific fields (like `smc->use_fallback` or `smc->conn`) on a TCP
socket object would result in reading random memory, leading to
undefined behavior, logic errors, or a kernel crash.
4.  **Inconsistent State**: Even if the compiler does not reload the
pointer, the race between setting `smc->use_fallback = true` and
updating `file->private_data` means that `sock_poll()` might see an
inconsistent state where it enters `smc_poll()` but the fallback is
already partially complete, potentially accessing uninitialized or
transitioning connection state.
5.  **Violation of Invariants**: In the Linux kernel,
`file->private_data` for a socket is generally expected to be constant
for the lifetime of the `file` object. SMC's "fallback" mechanism
violates this invariant. While the mechanism is intended to be a
performance optimization, doing so without proper synchronization
(like `READ_ONCE`/`WRITE_ONCE` or a lock) makes it unsafe.

### Conclusion
This data race is **harmful** because it can lead to type confusion
and memory corruption. It is not a simple statistics counter or a
benign flag race; it involves the fundamental identity of the socket
object being operated on.

The fix for this would typically involve using `READ_ONCE` and
`WRITE_ONCE` to prevent compiler reloads and ensure atomicity, or
better yet, avoiding the mid-flight change of `file->private_data`
altogether.

