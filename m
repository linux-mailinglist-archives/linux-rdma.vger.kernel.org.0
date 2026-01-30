Return-Path: <linux-rdma+bounces-16239-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNfbFSWSfGkQNwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16239-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 12:12:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C4DB9EAF
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 12:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7698303CC33
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 11:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C73B378D72;
	Fri, 30 Jan 2026 11:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CricIt6C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAD0378837
	for <linux-rdma@vger.kernel.org>; Fri, 30 Jan 2026 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771235; cv=pass; b=XlpA67k4D+rD+R+XvssquP29/on0Nw/s+XWd87Gx6HkxH/7dhLb2bS3TEYQt6GSnm8odsFKMOAnOe7QrYPAQLI1XvShv5ozTCx5o7Gfu1LdpOpJdUlBeZfTlNqpH/sP9tWjyCWVM1n25/gDqu3YzyVsrR6G6/n+vjvjvNkfBd9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771235; c=relaxed/simple;
	bh=j6eD4mqbfM9sp8yWTMh9QTN/xvebMy5z718cPcq1uF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfbSQ7sWjzofWaG5vn8IarnACev0OJjekQJzYzkdWTEQyVQ3DxWgpOljVn1Uv37u4ZIWzIUwLKiQrw0R7hsoQwGFrNpsyzpvIOO59m9e+AsVxhE8pgwLQkLbZ8qMcPvm2Ce0ZtJ4w3NtW2+ADJXX+lR+7iNoaEWc845l0275uSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CricIt6C; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8230f2140beso1677669b3a.1
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jan 2026 03:07:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769771234; cv=none;
        d=google.com; s=arc-20240605;
        b=bnyFK6kyc9/tJZ4oJM+xUTLM2hCiwGKVnY2UrwIMiednXnxRMGVRsXbTg3zdDsYyDv
         aR8+cgjESPdTT+ejEuHZQuKZcEKKq5Ne6ovaTOfq+UgxwxoKrnxJw6+C/oc/0tgtWKvg
         kp2MO5bu7H6uidCzFJ4yL7L38ed8LiKv6a+5j2BnMR1IsYTfWF2klVN7E8XnCEUreKOL
         WDK+YU+xqev3xcgT9h4MLkdRiAfyeRyqVcvul/1aG/y+orKIW2gTdfXVd9gVL1qX+6nc
         Q32ZS0Z6ibTFS2quN/7o4DC/EZW/9hIxDJS1NIJ3J0OLs9eeSlnLHCMiJ6Vu92pedqc6
         TYNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QUJZ+dKFSkMHy4heGPWqxikU1+6SvxbG2AZgX2l5DMk=;
        fh=h5eqfMEHXdad4doUwcRmotlDCBzQd2bcBwBDIlmmlUI=;
        b=i22gidpRtU+cK+GLECcbGidcHoaJM6wzIE/E2396EZqK+r/Fl/JgQJuYHCV7h8Jofz
         QvUZbWu4IvaV9HVrUE2grda9RqIAK7V5M23w/SOMTEGCbuNXbDxi11pZDW08x5VNQCAu
         jPwPw+24AWKOkuXwIUpN8AULrOXGCbGWCodcSfJo/66enARnikW8/3+9UvtrI18KQTF7
         eP2vpA7a5nBWin461Uqi2s3TxofiCluk3H2CL/2jzKJ2ASiESGm+CF3X9P0XC7FIzHcP
         GvBy4HkRWMU6pbYppBgSNGXLkM00wvfKy1wDsDaxm7lJfdcEEuCW5reVp3DEmCKu+lmn
         GEAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769771234; x=1770376034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUJZ+dKFSkMHy4heGPWqxikU1+6SvxbG2AZgX2l5DMk=;
        b=CricIt6CLWGd1BNAudpEPXawFAjw9pk69ZzmTthBocA8KhTuMhBy5kwg0EwTD80lHm
         B5Oz82b/sE/YS7/auQk6kJffe7YwUmN+tkfe5PhxOxkfMyTwTVcAp7rngDq2f2fBSYSk
         xI5JW2vrKIKnTDYz6602Fh9PS1mHTV8m2D8PH1Qfxap04diMK+g5sZXeg/GcDYjALkgq
         9Vev/fqweL6n7ZffQtvmhqKxr0nriopJHQhBFYcIKZZjoCtuADLFcF4Dv/aZa1C9/9pk
         DnNDpM837lFRhH1H4lEISwBtbk4F80MLoFKiYAf6nKcQqSSrpubfNhWAAUYatMxpFVZC
         bsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769771234; x=1770376034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QUJZ+dKFSkMHy4heGPWqxikU1+6SvxbG2AZgX2l5DMk=;
        b=fIFN7iqEieQex6CE+cOy1vpWETcxuR8wPYbYFcqcV0QAXX+U0LbPTF3rs0tEMOERlD
         O3IoypuJwsfJKrLfoXHATFEZLlKaeoItgqJM/7Ikvg75/TRPidf6by+gfK9ZmhlrlXjq
         Ei5XE4dgiH8MFRjU7nnneZZT19AGjuee6SHSE3fOU88Hl7oGDFylrs9HL0aKIZ7n7014
         v/D2rWM1SEExnLTgtsy8G+jg9VWevUP2uxNQyz3wjhNRWbdm3vGfmsvKrMKMGNcZ9mNZ
         Bldh/JneqmP5PCUXRCQgSyvZjR8oFYfypagI7JwfGDGIJEPsMcYRLPLP8LXFkLQqvbIG
         r15Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdvyip0uLaknLc+AqIRv60Pt6D1HbsoaFM2MQFCDaY5qNmaIfhO44QpwkjchTx1t5grUcWBiLR7HDh@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj4dCbanA3Pjp+Sa95LA/kaPc4RMYWqLRbhHO7yNtzjw4qUGWf
	z1nVvN8yjs43KMcn6FWPKaKF7EqeRdvpxszawXgeUQhGbbZQM4oREwHOKUZZ0hQbAQJOoAziJrI
	f15t9lqOKZVTWuVyP9JWtYmxuYlVKWAk=
X-Gm-Gg: AZuq6aLtKwyQswWdsRu686keReFoWyJ+Y/QH2/XiN8Ikhe7rlyA5kwCdAjnOYgWARG1
	KoPf1iu/liUyxGPTXhradNPEg9gYWxkVZCq4ePbl5czzIgiCgFBR5ATtgzjx/ZOQRzecbu6JELT
	2AzkJMZGbznsiA1K5+fWjb/Av4zSu1HmmwwmWZ0aLLilbqrx3lGrEv0SDSv9TD5nGcYHDNwqbMb
	/EiZBOo3HGkSOkktmzZEJaDfdoEGc/bC9Qe7OjjkoUKahukRCbV1cDQ703DUNxS6KTmoPL/Ow==
X-Received: by 2002:a05:6a21:6f01:b0:366:1917:54cb with SMTP id
 adf61e73a8af0-392dfa92014mr2668738637.3.1769771233960; Fri, 30 Jan 2026
 03:07:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMX6_QHfPsyybbO_79u4RpbGY9H28xhpaVPHUD-wu2U+V5W=7w@mail.gmail.com>
 <20260130090945.2426003-1-ioerts@kookmin.ac.kr> <151277c7-c155-4b3a-94a5-fe8c9dd70f25@fujitsu.com>
In-Reply-To: <151277c7-c155-4b3a-94a5-fe8c9dd70f25@fujitsu.com>
From: yunje shin <yjshin0438@gmail.com>
Date: Fri, 30 Jan 2026 20:07:00 +0900
X-Gm-Features: AZwV_QiTWh5cIL9yCS5gK5hVI3OWjez50je5ZObnhJJTnDHetk9x-pLUyP08Vwg
Message-ID: <CAMX6_QGCQSDEHr6wp_MFWd+FKjDEBrwJnL_Oj8z=1CHJRvNQ+g@mail.gmail.com>
Subject: Re: [PATCH] RDMA/uverbs: Validate wqe_size in post_send
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Joonkyoo Jeong <joonkyoj@yonsei.ac.kr>, 
	"ioerts@kookmin.ac.kr" <ioerts@kookmin.ac.kr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16239-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yjshin0438@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fujitsu.com:email,aka.ms:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,kookmin.ac.kr:email]
X-Rspamd-Queue-Id: A5C4DB9EAF
X-Rspamd-Action: no action

Really appreciate the heads-up and the quick review.

Thanks
Yunje

On Fri, Jan 30, 2026 at 6:23=E2=80=AFPM Zhijian Li (Fujitsu)
<lizhijian@fujitsu.com> wrote:
>
>
> Nice work on finding this. It looks like a similar patch just landed in t=
he for-next tree a few days ago.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?id=
=3D1956f0a74ccf5dc9c3ef717f2985c3ed3400aab0
>
> Thanks
> Zhijian
>
>
> On 30/01/2026 17:09, YunJe Shin wrote:
> > [You don't often get email from yjshin0438@gmail.com. Learn why this is=
 important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > ib_uverbs_post_send() allocates and copies a user-provided wqe_size but
> > never validates that the size is large enough for struct ib_uverbs_send=
_wr.
> > A too-small wqe_size lets the kernel read past the allocation when acce=
ssing
> > user_wr fields, which is observable with KASAN.
> >
> > Example KASAN splat:
> > BUG: KASAN: slab-out-of-bounds in ib_uverbs_post_send+0x106b/0x1600
> > Read of size 4 at addr ffff888007df4748 by task repro_hybrid
> >
> > Add a minimum size check to reject undersized WQEs.
> >
> > Fixes: 67cdb40ca444 ("[IB] uverbs: Implement more commands")
> > Reported-by: YunJe Shin <ioerts@kookmin.ac.kr>
> > Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
> > ---
> >   drivers/infiniband/core/uverbs_cmd.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/=
core/uverbs_cmd.c
> > index ce16404cdfb8..a80b959482e9 100644
> > --- a/drivers/infiniband/core/uverbs_cmd.c
> > +++ b/drivers/infiniband/core/uverbs_cmd.c
> > @@ -2049,6 +2049,9 @@ static int ib_uverbs_post_send(struct uverbs_attr=
_bundle *attrs)
> >          if (ret)
> >                  return ret;
> >
> > +       if (cmd.wqe_size < sizeof(struct ib_uverbs_send_wr))
> > +               return -EINVAL;
> > +
> >          user_wr =3D kmalloc(cmd.wqe_size, GFP_KERNEL);
> >          if (!user_wr)
> >                  return -ENOMEM;
> > --
> > 2.43.0
> >
> >

