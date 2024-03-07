Return-Path: <linux-rdma+bounces-1311-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BDA874B4A
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 10:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24051F21E41
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 09:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5BC657DA;
	Thu,  7 Mar 2024 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0oxxQjbI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2A983A19
	for <linux-rdma@vger.kernel.org>; Thu,  7 Mar 2024 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805093; cv=none; b=KihJq/NNGytKnol1VmH/hyZ5Alu53KNkyvs57QqVlYCnk1dSbEBiPQLDheiOTnwWNMP8gHQaH1LRluTK3ODWj7imXJo4vBoP9usII+tfAt/LuYQ5XypluOJUp7PC4nxt0PUiBWBTpnFRuKmB/wgg0SsAPD5Zc0dqIhR6e/+bPN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805093; c=relaxed/simple;
	bh=OoLMlL8GsN655bDWMNp6yhnWBK0A5xqnAO8a4esVDYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8WvyaR880U8Daog76P0N6fPSire9GL9dTussIYNeNYy7NkGj7iewah+CTd/GviRyNexy9u8nMv6NpCGeqIv1ofY4MTFMS50NouuJPRlBc4nRWLh6+4KZQcv6FdkhBaPttkWEFqtDIPnldcAlwGpIvWi6QLnYq761eWba/x1iBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0oxxQjbI; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5681b7f338aso2139a12.0
        for <linux-rdma@vger.kernel.org>; Thu, 07 Mar 2024 01:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709805089; x=1710409889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+Pit7z1B8h/KOsLvU72CTirJvLWVseq9u0dIG76VEU=;
        b=0oxxQjbIsdI5GfGlWwOxcvsCva9szXNYmpYn7b3CxNsbpsScFg0EUXxiEMzQzj1C/m
         atzCIVNGvozcvwtLlf+H287wb5NXGfQyD5VNdaJ/A7tenFlD5jOiEdhOVT8mPFXXBD66
         MZvVrKEIUaEKPoBRsJuGSc0olbJ3CqvHmG3MspBNsUBB4734cYp5feUy1ZCp3aP5FE14
         GhwTBAigjlr6lZt10K5m7BdUV2mVq7OEFb1iXzzuEED5luhw2p1P9Plb8lpDiDikbr7o
         Lt6Lu38rjzOnOrwuOUMNQgAUp0omI6c4uJ/pUiXHV2Wf9uPzNPXOqClw4HXRmX7NWZhf
         bC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709805089; x=1710409889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+Pit7z1B8h/KOsLvU72CTirJvLWVseq9u0dIG76VEU=;
        b=dBfJ9bLX2KWujSDSmuL8K9VtrYrR1KNcoso5NfE4srKIqLnz8R1J+hpZ183RjUHO17
         jFN90rt6EzRi1GqP57WP4L93sAOD3gx4pqniK20wUj0j7gROw4UhnjdLA5PnPXQNmmUf
         HnZa5JDmDUwWsfkZCoERI7ZA1ekICAGQ3p8TzG5LTg1I5MbCFnEvMCPEzm+BrZocIcy2
         pstizMaCtB5qP07nqrv/uVjlA2JMqFES9LBA52mLB4Zx1PidQdQmfTsQc/kCScvpiPNA
         43OfIDnDKpsnwPHH+GjiILaXEs0P7j7q/1sf2ZvBlRhAwXokNRsRT3XkVUbE88ghno+/
         ZXoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU95df7+ggOnjLf3eA6GinywrjYByOCW19AMsdzrDPcIdgideOApEMqXn2SSCTtZ1kML7bd8UmJn5nZpkaRz/upUIy46TwvBSLinA==
X-Gm-Message-State: AOJu0YzdEzYYswu0zceGtPfBlRZzlND6+A3pSTZh3Pd0p0ijNMRgTFuc
	XE+SJ92sofc8cpye+lLmz38LbfVxN7NVMDCgHCZuJiT1MIc0nwhaSTO/DJCc4leQwUc2D2vKnwJ
	AWeEk96mtLXwmqjm/L8ElqtCFei3V2sIe5ZGh
X-Google-Smtp-Source: AGHT+IFIRuO5DdJR5+yPgLVnKS4APhUblc5xEtSHYVniiMNUNiTQYEYwJ9d84Get/vODXDJbL2wJTUjsiBh9e528y5I=
X-Received: by 2002:aa7:d053:0:b0:566:ec5f:891c with SMTP id
 n19-20020aa7d053000000b00566ec5f891cmr188145edo.6.1709805089307; Thu, 07 Mar
 2024 01:51:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306230458.28784-1-kuniyu@amazon.com> <20240306230458.28784-2-kuniyu@amazon.com>
In-Reply-To: <20240306230458.28784-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Mar 2024 10:51:15 +0100
Message-ID: <CANn89iJP8gy24JOhwvydsDeVieAQFBmL4evt00vtOvW8tPPb7g@mail.gmail.com>
Subject: Re: [PATCH v3 net 1/2] tcp: Restart iteration after removing reqsk in inet_twsk_purge().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Allison Henderson <allison.henderson@oracle.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 12:05=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Commit 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in
> inet_twsk_purge()") added changes in inet_twsk_purge() to purge
> reqsk in per-netns ehash during netns dismantle.
>
> inet_csk_reqsk_queue_drop_and_put() will remove reqsk from per-netns
> ehash, but the iteration uses sk_nulls_for_each_rcu(), which is not
> safe.
>
> After removing reqsk, we need to restart iteration.
>
> Note that we need not check net->ns.count here because per-netns
> ehash does not have reqsk in other live netns.  We will check
> net->ns.count in the following patch.
>
> Fixes: 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in inet_twsk_=
purge()")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv4/inet_timewait_sock.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.=
c
> index 5befa4de5b24..00cbebaa2c68 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -287,6 +287,8 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo, =
int family)
>                                         struct request_sock *req =3D inet=
_reqsk(sk);
>
>                                         inet_csk_reqsk_queue_drop_and_put=
(req->rsk_listener, req);
> +
> +                                       goto restart;
>                                 }
>
>                                 continue;

Note how the RCU rules that I followed for TCP_TIME_WAIT made
me to grab a reference on tw->tw_refcnt, using refcount_inc_not_zero()

I think your code had multiple bugs, because
inet_csk_reqsk_queue_drop_and_put() could cause UAF
if the timer already fired and refcount went to zero already.

We also could add sk_nulls_for_each_rcu_safe() to avoid these pesky
"goto restart;"

