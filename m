Return-Path: <linux-rdma+bounces-17746-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M8bBj12rmk2FAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17746-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 08:26:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 714C3234C6C
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 08:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27A8E3019901
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 07:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC5A366DD9;
	Mon,  9 Mar 2026 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZHZB1qIA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B5928002B
	for <linux-rdma@vger.kernel.org>; Mon,  9 Mar 2026 07:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773041186; cv=pass; b=gZU6MRHVyl4bZ23grg9uETwox2s9cI2H0CW80ynHI8YbPQWzaP0zaQ61sRqluKKel9vEaVJ2FI/LfrtyagqwA9SQBE3ypnmL1ve37sdu4a7Z0tlK6eHy9zfe8C3/oFZc/kxd2QB9F657bb4PHmORD0LJj+LZ0qqhpv+TnBLMIhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773041186; c=relaxed/simple;
	bh=M0URNz+sYkeBXVx2U9Q0KCsD6TVHTuFPnbncyRSfgHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rClcuLEeBQsNgq/aGUAFs85d5i3s/oDodB638QyGngVhwqtDIJOvVKi/1d9t5gVz/A151BlIHhfAwHVjRBkvlio4ly4TseiU1v7YnotWPgUNPGN73r06Lf259zqZkVXZny0p0Xz2I6hmjqjLV20te4Wa/mudJMm16SPqBl6uIjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZHZB1qIA; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-899f79df682so83195116d6.2
        for <linux-rdma@vger.kernel.org>; Mon, 09 Mar 2026 00:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773041182; cv=none;
        d=google.com; s=arc-20240605;
        b=PQ6cokKL66dc8McwOzLoTEGL+7O92gv4yjBarGASLtCPlIbTbT5q4OjD/pahFOG8JU
         KybongZbD0ButRpKIbf5e1LsibGHgdVkQhU4G5U5HgiIXqSDIEGxO0CnEvweAYgMe1UN
         x2eUI7Xzf0r3Kx9bVNKtm/73P1OznJiDUlEmyW+Az/M2cEbUH+vPTF/k1E7yzqrSWLRJ
         t255PX1kgjjv2mBD56dmxZmF0lU0VQv6VbueelGJWDcLaIDcJr0r/fw02GMLTyU4kWQZ
         ODRbPdslN1RqMMSbhEpRmgq/Eb96+Ptkx/s/yQvhCRUpI3giURvxnbQAICmZR04Yly93
         3t9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u1ty6hSqFnrzRB3XG88cC/iwZTRE0lCfD8hBQNLJnIs=;
        fh=U7dMNVT9Q/doVCzGe9IunbP2eDyKCKRJDDrI2MB366E=;
        b=jEMofNPvOzxE5PrKaoSqUzxs26SyXu8PdetjBVJNSpGbnFCQmac0VG05PFJ3GdF2RT
         OxrTG+zOsZ7F2kf18NYpIptIY/G6nYymE7hCmN0NKn8nxp7U71A/ClAtcyvzw6tPARJL
         WMEKj91a6HkhkFX+gx0AYdnuWl6ztFjt5QCjZu3kCSC0dDfCJIkZzxS9YZ45xjG5nVbO
         6bqGrlQnQ75wrSdZxZlDa28PWWJosZboj1YIJJ0WUgSMz5ljMW9Jt/XW1FN9otdppiP1
         3skl8c8VXsbUlkLJcPRCvqdAods9PJq2vh2NHUyX5oKGAWxsDKvbJ5VAdSyxRlugGoBY
         sSQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773041182; x=1773645982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1ty6hSqFnrzRB3XG88cC/iwZTRE0lCfD8hBQNLJnIs=;
        b=ZHZB1qIAjvc7NDW1QKQfWAlhqCRmmK3AdTdZQzCwOl3/PS8BKHlsehjCIO9PbRIQs0
         WULkjQefHCRJirGnPPtM5/mxB28xuPgdmH9WL1WivQwL9QDOLE67/aUID/7xH+locDfX
         qtr0lLPNci9AGyID3Z2d70paBjZKe/TfNWj5ldnjBWeK/UGlesFZyFuQXrfeouCm+xOa
         nZ2mQ/psarGdaTm/g2OrV4CcCTWqjIQSOiNov7UasGG6nXahX/W2FXinRLysDCfVs+et
         obIr1NFVmX+Xo9i5C5OGCfuqIyj9YhJ053eYYh9TUU4B18U569MQt/kdH9/0HLGbdliv
         uiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773041182; x=1773645982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u1ty6hSqFnrzRB3XG88cC/iwZTRE0lCfD8hBQNLJnIs=;
        b=vFoBcekG8i+FXKZZk+A4r7bFjICMgLrl9bpqA3ZPPQjJeS1YiNaz9eFWwf4bk+zxcG
         RTjEANWrPdJCd0fcQ9VHy8BtckoY2kHnPOT1qoRSMisiXTcIhCrd2UZkWhDMCnh8xmIc
         iYp2V7aK53PS9uZnqI/SzVWXLvpywYftp9cDHY87PrhfGQwN2A2fPmqbz1ID+kOloPZu
         dMIRVIphvrNQivqCXC+p7Bs/p57sl/5ILfAXUNS/cXLWCWkYOx+ihHEn3lNdMyS9HBFa
         1WJa47K687pkiBl2rcee64kOKqg5ljtHzroHV6P54jT9lbalHCBO69MKrB42E2hA9xml
         zCUg==
X-Forwarded-Encrypted: i=1; AJvYcCWec4uFBJA8v8AansJSVoLoCVEasyD6/hEy9J4/rWqSgpeHBKo7TPxnc4oHyyGi3/qjnkJIr7caQg7l@vger.kernel.org
X-Gm-Message-State: AOJu0Yys08121j53s3cxkIJ3DTz2tCSl5bp/rWoZmYs1QsYSkd88GMVU
	OCpzxNJ4/q8sTimB2VMQawp16gos/5s34Nv2FJ9QvCtMYGFenku10WTduwduXqCgEZSkpUnYlIP
	r5gXENuGgLlPcCZpsIF6K5ySODDtaSuevrBiYJSG2
X-Gm-Gg: ATEYQzwGtP04XyZ9K5bAsFNrWYgCppBAphs3mTrWbM0//orHViP8hC0tketyMwcAkae
	GEHSc8XSCmZKuvFTMIbEMvX7Vw5/aCJnTtR2CW3njRl3YxyMvPlk5dQOmAxKQgU5z9Fbwz6vuJ8
	b+AChyC9WlXPgIZqZ/DhpLhf52+FYZHG0Su8MItv6ATeRLmF5q1uXsMPEfSXMBkLiAoZx6Ag0mm
	5hwIK6qL7cjkafmk7zXMah6eWAIVkAEr2eS8lzhdKnfQ6h+bvKWTAp9OIRdWgj0AkY9KTPdiLyC
	6TCowBY=
X-Received: by 2002:a05:6214:2aa2:b0:89a:1536:2520 with SMTP id
 6a1803df08f44-89a30a7d461mr142404526d6.26.1773041182131; Mon, 09 Mar 2026
 00:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309023846.18516-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260309023846.18516-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 08:26:11 +0100
X-Gm-Features: AaiRm50o_e6zoBfA91A7V-Gnt9-tGRqpQxxbgPA3vagSfMfB5nBzBMx_MrJn41o
Message-ID: <CANn89i+H1vuKLMrSy7M4o_=gEKroQLSz9S5pKB2DJYSdPc_BcQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, 
	syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 714C3234C6C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17746-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.980];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,827ae2bfb3a3529333e9];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email,linux.dev:email]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 3:38=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> Syzkaller reported a panic in smc_tcp_syn_recv_sock() [1].
>
> smc_tcp_syn_recv_sock() is called in the TCP receive path
> (softirq) via icsk_af_ops->syn_recv_sock on the clcsock (TCP
> listening socket). It reads sk_user_data to get the smc_sock
> pointer. However, when the SMC listen socket is being closed
> concurrently, smc_close_active() sets clcsock->sk_user_data
> to NULL under sk_callback_lock, and then the smc_sock itself
> can be freed via sock_put() in smc_release().
>
> This leads to two issues:
>
> 1) NULL pointer dereference: sk_user_data is NULL when
>    accessed.
> 2) Use-after-free: sk_user_data is read as non-NULL, but the
>    smc_sock is freed before its fields (e.g., queued_smc_hs,
>    ori_af_ops) are accessed.
>
> The race window looks like this:
>
>   CPU A (softirq)              CPU B (process ctx)
>
>   tcp_v4_rcv()
>     TCP_NEW_SYN_RECV:
>     sk =3D req->rsk_listener
>     sock_hold(sk)
>     /* No lock on listener */
>                                smc_close_active():
>                                  write_lock_bh(cb_lock)
>                                  sk_user_data =3D NULL
>                                  write_unlock_bh(cb_lock)
>                                  ...
>                                  smc_clcsock_release()
>                                  sock_put(smc->sk) x2
>                                    -> smc_sock freed!
>     tcp_check_req()
>       smc_tcp_syn_recv_sock():
>         smc =3D user_data(sk)
>           -> NULL or dangling
>         smc->queued_smc_hs
>           -> crash!
>
> Note that the clcsock and smc_sock are two independent objects
> with separate refcounts. TCP stack holds a reference on the
> clcsock, which keeps it alive, but this does NOT prevent the
> smc_sock from being freed.
>
> Fix this by using RCU and refcount_inc_not_zero() to safely
> access smc_sock. Since smc_tcp_syn_recv_sock() is called in
> the TCP three-way handshake path, taking read_lock_bh on
> sk_callback_lock is too heavy and would not survive a SYN
> flood attack. Using rcu_read_lock() is much more lightweight.
>
> - Set SOCK_RCU_FREE on the SMC listen socket so that
>   smc_sock freeing is deferred until after the RCU grace
>   period. This guarantees the memory is still valid when
>   accessed inside rcu_read_lock().
> - Use rcu_read_lock() to protect reading sk_user_data.
> - Use refcount_inc_not_zero(&smc->sk.sk_refcnt) to pin the
>   smc_sock. If the refcount has already reached zero (close
>   path completed), it returns false and we bail out safely.
>
> Note: smc_hs_congested() has a similar lockless read of
> sk_user_data without rcu_read_lock(), but it only checks for
> NULL and accesses the global smc_hs_wq, never dereferencing
> any smc_sock field, so it is not affected.
>
> Reproducer was verified with mdelay injection and smc_run,
> the issue no longer occurs with this patch applied.
>
> [1] https://syzkaller.appspot.com/bug?extid=3D827ae2bfb3a3529333e9
>
> Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")
> Reported-by: syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67eaf9b8.050a0220.3c3d88.004a.GAE@goo=
gle.com/T/
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
> v2:
> - Use rcu_read_lock() + refcount_inc_not_zero() instead of
>   read_lock_bh(sk_callback_lock) + sock_hold(), since this
>   is the TCP handshake hot path and read_lock_bh is too
>   expensive under SYN flood.
> - Set SOCK_RCU_FREE on SMC listen socket to ensure
>   RCU-deferred freeing.

This looks better, but please note there is something missing in your
RCU implementation.

You still need to ensure s->sk_user_data is read / written with
load/store tearing prevention.
Standard rcu_dereference()/rcu_assign() are dealing with this aspect.

For instance, the following helper is assuming a lock was held :

static inline struct smc_sock *smc_clcsock_user_data(const struct sock *clc=
sk)
{
return (struct smc_sock *)
       ((uintptr_t)clcsk->sk_user_data & ~SK_USER_DATA_NOCOPY);
}


One possible way is to use
rcu_dereference_sk_user_data()/rcu_assign_sk_user_data() or similar
helpers.


Thanks.

