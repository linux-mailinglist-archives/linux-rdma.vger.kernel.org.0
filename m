Return-Path: <linux-rdma+bounces-17957-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBpRG0c0sWm0rwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17957-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 10:22:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8FE2603F2
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 10:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69B8F30067BF
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 09:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54463C7DF3;
	Wed, 11 Mar 2026 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0cJQp38M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF9B34DB54
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220660; cv=pass; b=k2q8nN81Bvl/Mh2nOCnRa9zUNTYCY8IiNzkZMaGKE2FvCCW25RmfyZeIyae9wIDlX5ZuBeSsgpJT0uc7+HEdAZcnp4NW9Lzelg6rEpzpki6CZAc6BjVl2FPmaLeDKn71Cr9/eMlO7JLlADJ56Rk1zgML7Eef3xqYw4mKSJMF+LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220660; c=relaxed/simple;
	bh=OxP+oxlWMBqbtwfC/PQBmjuD1E0cI/hvZs3XVNyH0+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4gtzVXjvO+TJzNGZFF/k+ee1lVG97Hm5KMBC5qEz9iK3QsPR2owpMFCq9Tq+rvNETKkPM3FGeBMRW2md1xCMR+teVTBwiV6/n9UxRQnXQaXfvoVr2LF3mQTp8lOQyqhV70q5IHXVU8mTFug+1ke3oiLaxPS/87Qi1JeKUIUEEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0cJQp38M; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-509149ab7d7so31243011cf.2
        for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 02:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773220652; cv=none;
        d=google.com; s=arc-20240605;
        b=LeQEaCgaTi2EqptEVZnug0cabVnOyztcTp9eCK3BO/krszDjw+CAydTFdMsCXYTPiq
         ZW2eBZU4in1ekR1OADBwIA/3U5igDAEPi42UVwliWMSUv9byp9cZ9At/e5gmYh9V3Fxc
         arWoLSCCCRQnY1xDSNyT1rGViRY+w9diPUiBZ8koArc2L5c2KWwAixYHs7Q1kyTmRn7a
         60T/tPcx4ePBr8DdK4TjQkmfTpdoduE2tk2wgfosbIsZ07gYcbb6m5ywa752boltS5m3
         TaNS8a7IVaaM3D1WCEvWuzk3KM2itKQEGhuAqefNAc0tnkny9Dp9i2mTKTMxzLO+1qSS
         Hz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=34kAm3z124TDQNJNDxrj8wJyj1zVsoVCIkxuIHo91/g=;
        fh=Dg22nlK+2VzrOr9zj1BFJiP7KS2seVpZvOor45mlB+M=;
        b=Sd8h8R6LAMbmMkY93daVDh6rNxcuIma6vipgH7YA4NW2GO+u5iJRCojUU7T/BG2k8t
         IDsII/3XCGXZWRMV3pwZ2rZRY7vbOkQzKcVYj7LHOD1fnwUb4QHfdy9Il8YXL3+evGwr
         MMjxK59j98+SUdikBwExY7NIwvjOQKC88+p7buKxxGBVe1hjDdQwLVif8oMZfVwtsfYB
         2G1tbDa9gPucjh/IoDWdcrNUaXF/NIwNQvkFij6vHGuyjj2b7ycdSQHQaKChJgheVDmo
         6I2yfl440RI26Fz1x5OAgrsiZ7pLiYjqRIWyhZysSwLrOmgJGELQwULdR8dq6zdG2ZsY
         PVNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773220652; x=1773825452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34kAm3z124TDQNJNDxrj8wJyj1zVsoVCIkxuIHo91/g=;
        b=0cJQp38MAggzovUIISEwDjOMceCuoLNdTrcgauUMi9wfvxyw4OM/5Ipd7VMVX/E6XW
         zRxT6TVNYXk+Zkoi9fq55HDdRtoS+xXjxKaZbNV1VO/WnqVeXOAVQLK4mDEx8NJxhP9U
         HweUodg0iKD+xPYPsTnIvHnH7St0pbWHrlgKW2qvSnAqDYbYZEC0ZiJ+CpZGnR+NTjCd
         ++zxUjoUWHh3MiQbYJjog8VfbWKVKwLfCLxuxXpLyzu0ScNsYuQPYPZLnaLvMGKpWIH6
         jIDgZQEYz8qWwh/PStzOfQ/lEhl6yolU37GfRaIhwLKn0SqJ8ywx+5ZqLJF8ReaCInaF
         s6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773220652; x=1773825452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=34kAm3z124TDQNJNDxrj8wJyj1zVsoVCIkxuIHo91/g=;
        b=l/i5XopXaJzDZjt7toQV7XqQNSi22MZ9nIAfswGe2E0c3LpRpNehB+ILBdIMxQyg4w
         vCt1KqE/nKYfQl7IFR56URsh4LSgqGmcDluZ+UlsHSY2FnnmC2lvIofnZjpG8yesEHbK
         NxhSFv40uu82tOKMXdJAaqK5+Hp7jMBKB9OL0n15VICJfAdDwV8Yufes0pJq0pe8LAY+
         TVOM6kHwvTjTr7ubBBGiPQx15s1AO6sHcQYZAxt5RGUDZSEBp9UI3uoMy8uw0zgYjJ5p
         KRagwBPi4nVyzm1jt3GUPiW0OItqCZ8Jo++KRk3757APJ7yRUVErCMQs6dA+T641Klqp
         nVxg==
X-Forwarded-Encrypted: i=1; AJvYcCUVrGI6Nmm6xk5cU0eDZfZUCS0WCokmkSNfNkYkxQFFkTsflJwsbv2CyTuia6EfFNcchSL21QAlQwd9@vger.kernel.org
X-Gm-Message-State: AOJu0YwIiCokZwK108h2hDoZjuxyPEK/VgY7W9frj2Q0bHAl68EUfkGp
	LafkGTrMtJn42Oq1rSHGu77ZjR+bwh4imS5c2EFzmx24LWHna+yZGn5w+ZZsTros5JmYm4q3+hV
	GWenoZjo1tYCpbJVV3OSihapCIpluqG4XegsBL9Qa
X-Gm-Gg: ATEYQzxI4mCKa67uVQT5R/0srpQFh6ZzcR7AfY3gyJbt+fahEwjNh3TjAdUc/QDeiDt
	lKky9Wm8EPo2Qs/0N4D1LvQTqC4c2r9QsdL5MmjpN1LWwv1I5uSEJYWfFQFDKrOU9lxhgkmZKvr
	C3XNLMIvizUhVM0D3/Uzj+PJZFE53o2LzJMlwlolQ8PKQoAi48K/EJ26NmBK55wc9+rhoaKSg4Z
	oCsQSmvfhTVj6kF0nTYpOpi2nTSfj7Gpb8whLtDdPjNPE9WHqZEoS6gMFmQi8rWp0xw1A++ua3W
	wZkQgoxIA3+K6YKSeuk=
X-Received: by 2002:ac8:7f8b:0:b0:509:3025:ff4e with SMTP id
 d75a77b69052e-50939fac746mr21570951cf.27.1773220651404; Wed, 11 Mar 2026
 02:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311022451.395802-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260311022451.395802-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Mar 2026 10:17:20 +0100
X-Gm-Features: AaiRm52u0CMFFt7ORPlVWQokL8IgQ6iecZLTd-DHcIzSTX7a8MIK-b_1wmE7h9M
Message-ID: <CANn89iJpjgEnsOfVuF0k4uERc+P4mwy5Tpu-hpSfcx8RGtWEKA@mail.gmail.com>
Subject: Re: [PATCH net v4] net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
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
X-Rspamd-Queue-Id: 0F8FE2603F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17957-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,827ae2bfb3a3529333e9];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 3:25=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
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
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

