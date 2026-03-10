Return-Path: <linux-rdma+bounces-17867-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJzlL9wdsGlBgAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17867-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 14:34:20 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1232506DC
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 14:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E95F35C2CBA
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 12:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47923B47DA;
	Tue, 10 Mar 2026 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qf6uGOi7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB143B47CD
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144832; cv=pass; b=VVcX/N6Jf+REV7o6zcw4+uTWn+GZQ76PU/m1H4BpKhg7Ln3CoEm9SvoQmhcKPF9JhweM/KrUSAfcYtsUxfiCAUAzlDhfsZTH2o6s/E7gvBk4aec1nNq0qW234dAsXcHDNJs++opk+NrkwiGQ+tFrjB2eNzJggSJGgdaerniLSIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144832; c=relaxed/simple;
	bh=oBWHWl4oFG4ctqngCJNsL2W/w/X/y+8sHCgAIJblmFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdLK/acH2pGFi+sMzYUWAdOWEykCCpCD4PtWOT4z3DPQLPIE3Jl1VrfVwsQ2uC0U2ETs8vOqQ7TCTvSy11X+TRKZgFOev5uMIjrFZFzaBC0o7IXZ+1nBGU5Q1FBGFrcupuYjR+Higx76qUSjxdE8DpW62oTH08bBaD1Zk2rYVpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qf6uGOi7; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-899a9f445cbso156009736d6.0
        for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 05:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773144828; cv=none;
        d=google.com; s=arc-20240605;
        b=ed8vjZQyZStkb2Dzact4oqM16cSmRR/Oxd5rlV+c9P275unPk0No1SGGP6Xy41daXW
         os0pJzJrTe4MewohSQsdZQZMPbEfJ/el6+/KLZKiIWBktJpa+y9KULv8OIitZGRWntIL
         McIINJ91bYEMYFZ2WZOEQ+6KAEf4dBKltIhv0lR+XUpm8OnJhMuQ8k+jKDQqXMATxLod
         g89QViIkAGNeZO+qC9OsC7trxYvGL51Bo8QYzqdzMbJtMp7DPTYcqlxdrtl6x0S71gnp
         LCyc8qulp8nUgTB8kUbxwhKjA3Z7GcV/iPwehqGIUAfQVQld17zgPn0TsMzWGSTUzQKt
         oXVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aNlD1VnwwuWUuVdK0r+JEQho3gk9Img94yEEgNc2T2Y=;
        fh=QuwrdiyMntE9z4YfFzQfHPtVJtXKeV6qGhTTF7O8PTM=;
        b=DrvcY3zGMYbrypii1Uexb8ltvGwOqIx5Q0LaYjcVotNN+jyC4Muy5eZJNnbkX7r5TM
         dwJHiCfmjmQapydhJLv6G+7FaCNYu+uqih2PmJ4pAb3setLloZLcv9hxAcwadk/58zTO
         6K0nqZLhJ9Vbc6A5TetV0HObjenfF9FIkVCFFiJ4xyzpXQjXECVoSi0lb8w1255MaIEj
         Lw8XBKD+yTH5BH4Z+wEA6S/Z9wAxz5CtDyEAvE7cdztlBHp3UyIDEZKx+hor3kNM5Oy+
         oOv5wMRlFr3mIku2EVl2y/zeHbZKGoh/ecsJufVjBMZ4jCu/AJsl6o7v8yaGMKDiYz9o
         c0wA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773144828; x=1773749628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNlD1VnwwuWUuVdK0r+JEQho3gk9Img94yEEgNc2T2Y=;
        b=Qf6uGOi7YDhTAg2wqxZ2yfGHJ4hzAHx8ToJNEw3pxlLhDTBJbvjvysxSb7Z7xPwoko
         V12L0oqtIM23astGiRTGta2bljIhDOuSI15VR3mN0qN14HcAWhni34g6E09MApOPR5q7
         oAaaAMBDGNoYYMxAlZqPl1gRS6xl4isMN44PcNxmagXTeMC8jpNjYaXK3n/hnLthiTwE
         U+XACYDeQyVL/NypQuRjBhLmAUaWxeCmZmpoRAUT0gQYsIFsayo0jHH8OLt2Nzhg9/g9
         v4jIZwG1WKVlAStQWkO1QmpeCo3arE63uTEUoCV2eeag8nqtLbvyeiD6RQhOmL5XxUJQ
         HY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773144828; x=1773749628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aNlD1VnwwuWUuVdK0r+JEQho3gk9Img94yEEgNc2T2Y=;
        b=vYKTfPuIOA3j5Yt7Z5ICHTO88Hz4LrkgZBxrdd0Gj6mcbtVCm1+ZfpzE5MfH4r8tv4
         e4vMZw4zOHK6HOEw5vVOI1rtugwZjjCClEtqd1SAjJnu8ru4mITrfIYQRhQh7Y2EGniX
         CS0Lp2byQEMAx8cWA7Hz3KX06njlBWVEagtlV/ddmQAUvud2GaS/BmE1krPML4RmgSC5
         g9BHNg1J9Mg4teEUIhxtIrxRrKy+UKvQMLFGg3JIRfROx9EU6qNUTz4s6ynHMxIGJ2n9
         A4+94m54pMXPXOe6g1EbTbQ4TK56JrDx/TtBpg+7Dq62QD/sZwYMXGEzMrX1gQI5Bw/x
         S6lw==
X-Forwarded-Encrypted: i=1; AJvYcCWsmS1KrgJ1pA/WCSrxFl2/hfBbbMhDAHhvRABHV18NbjlgYo+nTGiR05baPnSFtA2U8plGzoiQhkRl@vger.kernel.org
X-Gm-Message-State: AOJu0YyKEZLgUBGx4nxeCLlNwyv99alH35zScQl0VxaupnBmyVIsdZGY
	kurSMfLyxmGlq+4pn47BpbSq8vieq720FpBmo+DJ+Ftd/ZkeH/jvDjlgtfSNbwrlBV9zVUrFenE
	EK04HIWrT7ygfBjeVDZTS9AGVY/nTHyGqiLJoA9dO
X-Gm-Gg: ATEYQzwTiO3RMNl8FG8C+xVCUl9wySCSAPj5Ay0zfg2pwyJi52v9102bxVhENK0EJPA
	VB1H3AcYRMAc0f5dXYaYl3muF8L7+7HjLu0a2k/CnTBVuCMFlFyaEF4EZZ/OSjQiWwCbeF7uyCG
	0cJsYdttWeMJPv+CsPKNRBFbK7XHQiwW8fYHqq98j7pDDZEFaI+qO7yYWeAtfMttzaZLmwyJhOj
	mklb0eVy7NBmYfEEARYopdHJE+F87n/w6JqY2uCX/jp8MTT02RXll7V1Qx5tGz0DZgHLr12fTXT
	LvQ7w04=
X-Received: by 2002:a05:6214:d08:b0:899:c803:ca2f with SMTP id
 6a1803df08f44-89a30ace932mr206169286d6.42.1773144827562; Tue, 10 Mar 2026
 05:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310120053.136594-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260310120053.136594-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 13:13:36 +0100
X-Gm-Features: AaiRm50qCXqay-aJR-sI5Vzv5JmvJjTgCTUtA-sXdrVxWvAsiISg39w7gsRzpcw
Message-ID: <CANn89iK-Kj7Gthff+Q8vSUDTYs9t6YZepm5uAv_2ZZJ4AkyxOw@mail.gmail.com>
Subject: Re: [PATCH net v3] net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()
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
X-Rspamd-Queue-Id: 3D1232506DC
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
	TAGGED_FROM(0.00)[bounces-17867-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,827ae2bfb3a3529333e9];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,shopee.com:email]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 1:01=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
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



> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index 9e6af72784ba..8b3eabcdb542 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -342,8 +342,7 @@ static inline void smc_init_saved_callbacks(struct sm=
c_sock *smc)
>
>  static inline struct smc_sock *smc_clcsock_user_data(const struct sock *=
clcsk)
>  {
> -       return (struct smc_sock *)
> -              ((uintptr_t)clcsk->sk_user_data & ~SK_USER_DATA_NOCOPY);
> +       return (struct smc_sock *)rcu_dereference_sk_user_data(clcsk);
>  }

Are you sure all smc_clcsock_user_data() callers  hold rcu_read_lock() ?
In order to avoid surprises, I would have added a new helper.

 static inline struct smc_sock *smc_clcsock_user_data_rcu(const struct
sock *clcsk)
...

to allow gradual conversion ?

Thanks !

