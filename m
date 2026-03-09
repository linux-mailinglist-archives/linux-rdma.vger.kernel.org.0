Return-Path: <linux-rdma+bounces-17748-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOADKR15rmmPFAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17748-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 08:39:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E0E234E0F
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 08:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8F8C3055C54
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 07:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E790B366DD9;
	Mon,  9 Mar 2026 07:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nsK0VKvM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B0B36683D
	for <linux-rdma@vger.kernel.org>; Mon,  9 Mar 2026 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773041781; cv=pass; b=dwF1kO9yR0aymAwT+X5kWKBmiCTy7Q2DXeIMUWcQrz690+1T8OdHZl/q+30rHMzjOX5kGB0bh9XabwCaMClEhVAfgRasN4ZGPePJIG5JRc3gN0vqjX2EkFHbquG6ODGnzdTbYDYaGVTCh/CTTei9iFbyTqFhXS/AgoITw5ghTco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773041781; c=relaxed/simple;
	bh=gLdR85XoXK1+V6PspFbqCeowMRNNlR6JeEo4Cy/vyS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sntKhzx/CaZwChVQ4PVSf7cyFOGmCXilnVBZgt8dVNSmiaQyrJi4Wz/KPuXRWv0M0ZV8BU/JjlC+XwHW6XNhpKVnsbBKNiw5T73uWoTh48ZGj9n7xtOhyAPDorFHs8vP/gaNjO/jhhd3Dn7MkHHOGbUHjscEZ1EoSNsm711irok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nsK0VKvM; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-89a133cdd4aso73180856d6.0
        for <linux-rdma@vger.kernel.org>; Mon, 09 Mar 2026 00:36:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773041779; cv=none;
        d=google.com; s=arc-20240605;
        b=CWCmqJjw2wk1RKoIgJLbht9vupHG+clAs15rtwA8hM0pWtNQB7mcs6moR9bjjyYSs+
         es/4YAGDdTll8goK67YYOWZt9A549aZlFP8n7wVYC9A1c3wr8bG/RyA6wPFueNctb5F/
         j3UBiNQZNuSjMeA/ZYMCC06IDAJu6AWa67fze8LnFGlvRnQaMf68iCfbcxrJyuZoVFXu
         OzSIPVrQ0BPXAzXidYQr/CvqGjljUu0kGTyUHuEbn+WNI8ycDGd0BPc/J+t6eC51m+xf
         4D805rIXhtrRtklJ8tnrixQjchb0ovp8cVOwnWBXCCq59puSAlsneNnvFnJu7GAeItGt
         ntUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FStRxtJV9pnniib6nEIUXEXFXS20x8+8nz4KKWUw55Q=;
        fh=ulA9P7bXfo6Mk2BzULf9BmDfUaD0coy9CR9Dy+2nxfA=;
        b=HurOaSwAmt6TfxRnSQR/K/2cHKC7k2cixxDTmxtuZIhArUZ4fLEkQFSyFajqfQUEkd
         Owj0Pvx+MrJDWjHjkzJJxdHxhJ8rvUCAnPDfz5WnlquRppDy1ZcUi8Krjl6XgznzlsdQ
         b5JIXgXxvO43TSd31d06fy+bmVOh3FcCh4JiNSojNfYSOQmzBWqZUntdOeG29edW2AXe
         IJefC5VXQhTCHfYqjVmLpAyNj+N/Nnu13oMhGZK03xA+GRgA1AFsb8RLqWgfmm5bo70F
         Bu1QLFUdtRKyLHg+QxNxyKt1+pSS0xB+IExa8dkXoDweSWa0gMDqQKo93mQ3Ldla6+EW
         f2SQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773041779; x=1773646579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FStRxtJV9pnniib6nEIUXEXFXS20x8+8nz4KKWUw55Q=;
        b=nsK0VKvMACI4TCX1POcFNh6R4NWzEFM39Q9WSt9KMNHe4TpGkGVMY2NaWa3VaxrJXj
         +qHbtG5Og4+iHhUmLHb47u0Vcv7RWKJo9DvXRY6GutrBPFmqjzr2EcvynzySCrLE4PoD
         TbpJY2ifvRX0KTq4bV/R6rvModr1rtvczgMfL2LPblEBhI4qy8zJfK/ehW99m8MaBhmm
         OH2RK2VBvLJcS5jxYrJZwJApB0Ka/38HN3hBYbdZu+j4XhlAT8DX0hA6zH7bDcWyadUz
         UXPOzKBBxXlGOfgy/binhHlKDRRgdnCFq4igrQsqXma4+LZLoSjmGb4o0aWl4UHEHoV/
         L7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773041779; x=1773646579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FStRxtJV9pnniib6nEIUXEXFXS20x8+8nz4KKWUw55Q=;
        b=vbssp+k+l8s+nmS7v5fcQQM4ppkgAcGIgCAJtj4X1dPU8gpv3OpmrqMwO4KryXrNN7
         hQCpLW2glTer7N3RJT3M8qe4X0Fe3tb2Z38lPQiQW8QtekGQUHy0cFcPvGKSJvIJT/+B
         lHt+P4Zf9/QOW/bikDrcHOqnZcWAW9mjFqDEWfOYTOzfrX/D/A6RNTO6cvp7xrHlI34b
         BZBJYmKmgRISgoVs2m22t7Sq9hwfPCRAEnE6zb7PfwId9LvPANCAe1FrID5DvnRV27u4
         vQFtU+RBUTfjfrZNUoXsgAWoW54bytM3x6R/U06AZoSbuA1TbJKWNFcYkcXfWuXFIidm
         NR8g==
X-Forwarded-Encrypted: i=1; AJvYcCXNSb8jqR44bG9/gwSyY/5jBQ7oRvnaHFHfiWPHWXZpsTVK/nXf5TfsULmYlJgRvm1DPf3ZzFyxFrwi@vger.kernel.org
X-Gm-Message-State: AOJu0YytX7iWpR1rxVDEYN2VGY2NgqMnNW9v0M2pOaA4Y3lBL3UHRvVJ
	32toonoVj/hw4zB5GoMiDHDN+msODZfG+aT+M7UNS4+DvUb1SvORZAN0nslsLvSuzl/3EbRZnL8
	8gPBawRIpIdtK2A5hbTar2UfbCHNkkKcAJvG2O6rW
X-Gm-Gg: ATEYQzxSr6HIX1Z5WoWvkvjFYRtPoFTWH4kc/8c8x4luWARpe+/vj9v3kXY8n8T3Ov1
	QD5ruhTj6qT/ztcc0igr9yAF36KUJ1/aJsaYsj0J5bRzi8meR3uKU6Ja24oAhUATx0/4G4lRsqS
	rtX4Wgp9w3mljRkEg/biHObJnGOefhsOYZRXdzUEmnB8lyPW6HtopBj7E92edF26QgfDx+Fh0Se
	gvkSZM04mxF3XsfRFnPP+pwcwrTCF3pOnRwh6b+EyAZsaCm8ZAm+Li9x6XtCVkwTMYJFm63Saqa
	LvD6TFI=
X-Received: by 2002:a05:6214:5096:b0:89a:9f9:246e with SMTP id
 6a1803df08f44-89a30af16d8mr149648356d6.45.1773041778736; Mon, 09 Mar 2026
 00:36:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309023846.18516-1-jiayuan.chen@linux.dev> <CANn89i+H1vuKLMrSy7M4o_=gEKroQLSz9S5pKB2DJYSdPc_BcQ@mail.gmail.com>
In-Reply-To: <CANn89i+H1vuKLMrSy7M4o_=gEKroQLSz9S5pKB2DJYSdPc_BcQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 08:36:07 +0100
X-Gm-Features: AaiRm50tYUA2hHcgBtFj8-LfrpmhaFVmNtJKvZNcOrXthEiN65UptVLRtBVFszs
Message-ID: <CANn89iJawS4rcitF77D=YXAw8SY8TrPtKz6xVfwm_xZ5sBHPcw@mail.gmail.com>
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
X-Rspamd-Queue-Id: 04E0E234E0F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17748-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.982];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,827ae2bfb3a3529333e9];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,appspotmail.com:email,syzkaller.appspot.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,davemloft.net:email]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 8:26=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Mon, Mar 9, 2026 at 3:38=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
> >
> > Syzkaller reported a panic in smc_tcp_syn_recv_sock() [1].
> >
> > smc_tcp_syn_recv_sock() is called in the TCP receive path
> > (softirq) via icsk_af_ops->syn_recv_sock on the clcsock (TCP
> > listening socket). It reads sk_user_data to get the smc_sock
> > pointer. However, when the SMC listen socket is being closed
> > concurrently, smc_close_active() sets clcsock->sk_user_data
> > to NULL under sk_callback_lock, and then the smc_sock itself
> > can be freed via sock_put() in smc_release().
> >
> > This leads to two issues:
> >
> > 1) NULL pointer dereference: sk_user_data is NULL when
> >    accessed.
> > 2) Use-after-free: sk_user_data is read as non-NULL, but the
> >    smc_sock is freed before its fields (e.g., queued_smc_hs,
> >    ori_af_ops) are accessed.
> >
> > The race window looks like this:
> >
> >   CPU A (softirq)              CPU B (process ctx)
> >
> >   tcp_v4_rcv()
> >     TCP_NEW_SYN_RECV:
> >     sk =3D req->rsk_listener
> >     sock_hold(sk)
> >     /* No lock on listener */
> >                                smc_close_active():
> >                                  write_lock_bh(cb_lock)
> >                                  sk_user_data =3D NULL
> >                                  write_unlock_bh(cb_lock)
> >                                  ...
> >                                  smc_clcsock_release()
> >                                  sock_put(smc->sk) x2
> >                                    -> smc_sock freed!
> >     tcp_check_req()
> >       smc_tcp_syn_recv_sock():
> >         smc =3D user_data(sk)
> >           -> NULL or dangling
> >         smc->queued_smc_hs
> >           -> crash!
> >
> > Note that the clcsock and smc_sock are two independent objects
> > with separate refcounts. TCP stack holds a reference on the
> > clcsock, which keeps it alive, but this does NOT prevent the
> > smc_sock from being freed.
> >
> > Fix this by using RCU and refcount_inc_not_zero() to safely
> > access smc_sock. Since smc_tcp_syn_recv_sock() is called in
> > the TCP three-way handshake path, taking read_lock_bh on
> > sk_callback_lock is too heavy and would not survive a SYN
> > flood attack. Using rcu_read_lock() is much more lightweight.
> >
> > - Set SOCK_RCU_FREE on the SMC listen socket so that
> >   smc_sock freeing is deferred until after the RCU grace
> >   period. This guarantees the memory is still valid when
> >   accessed inside rcu_read_lock().
> > - Use rcu_read_lock() to protect reading sk_user_data.
> > - Use refcount_inc_not_zero(&smc->sk.sk_refcnt) to pin the
> >   smc_sock. If the refcount has already reached zero (close
> >   path completed), it returns false and we bail out safely.
> >
> > Note: smc_hs_congested() has a similar lockless read of
> > sk_user_data without rcu_read_lock(), but it only checks for
> > NULL and accesses the global smc_hs_wq, never dereferencing
> > any smc_sock field, so it is not affected.
> >
> > Reproducer was verified with mdelay injection and smc_run,
> > the issue no longer occurs with this patch applied.
> >
> > [1] https://syzkaller.appspot.com/bug?extid=3D827ae2bfb3a3529333e9
> >
> > Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")
> > Reported-by: syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/67eaf9b8.050a0220.3c3d88.004a.GAE@g=
oogle.com/T/
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> > ---
> > v2:
> > - Use rcu_read_lock() + refcount_inc_not_zero() instead of
> >   read_lock_bh(sk_callback_lock) + sock_hold(), since this
> >   is the TCP handshake hot path and read_lock_bh is too
> >   expensive under SYN flood.
> > - Set SOCK_RCU_FREE on SMC listen socket to ensure
> >   RCU-deferred freeing.
>
> This looks better, but please note there is something missing in your
> RCU implementation.
>
> You still need to ensure s->sk_user_data is read / written with
> load/store tearing prevention.
> Standard rcu_dereference()/rcu_assign() are dealing with this aspect.
>
> For instance, the following helper is assuming a lock was held :
>
> static inline struct smc_sock *smc_clcsock_user_data(const struct sock *c=
lcsk)
> {
> return (struct smc_sock *)
>        ((uintptr_t)clcsk->sk_user_data & ~SK_USER_DATA_NOCOPY);
> }
>
>
> One possible way is to use
> rcu_dereference_sk_user_data()/rcu_assign_sk_user_data() or similar
> helpers.
>

More context in this old commit

commit 559835ea7292e2f09304d81eda16f4209433245e
Author: Pravin B Shelar <pshelar@nicira.com>
Date:   Tue Sep 24 10:25:40 2013 -0700

    vxlan: Use RCU apis to access sk_user_data.

    Use of RCU api makes vxlan code easier to understand.  It also
    fixes bug due to missing ACCESS_ONCE() on sk_user_data dereference.
    In rare case without ACCESS_ONCE() compiler might omit vs on
    sk_user_data dereference.
    Compiler can use vs as alias for sk->sk_user_data, resulting in
    multiple sk_user_data dereference in rcu read context which
    could change.

    CC: Jesse Gross <jesse@nicira.com>
    Signed-off-by: Pravin B Shelar <pshelar@nicira.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

