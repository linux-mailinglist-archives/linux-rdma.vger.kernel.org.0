Return-Path: <linux-rdma+bounces-16478-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HvUEUQzgmlTQgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16478-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 18:41:24 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB234DCF83
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 18:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88288303FB63
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 17:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C635326923;
	Tue,  3 Feb 2026 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewS0He+J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4775931B123
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140277; cv=pass; b=GY8EJg33GH8yPBcY3V+ETQ/6BzWoWZCJk/4/gSCPUIX1o5mCBbheThSI9eoe/CuLLsEXaRQQwfEDXoT2xI69EqHteWgg6Bo7FdA0dJsf1+bVgUI2xPm2yW/dyrkYHuOWb2YGPQU1Wwk6RzZ6NcOXfGYA7HUUzpJBqw3HczQ2lHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140277; c=relaxed/simple;
	bh=KOEfPnZTeETnF2DAaZeqI+37eY6oAZZsxEicbRAXUAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKaAiW2h555DJoXxuPvcNE7fa0eIMouRsaSB3QkHSXTIhB3DiHYiCkIQd7u+c8hoPaAFejWnaMoB2bF6juXl50QeNloFgDiaouOF0HtRMbtWMRgLkN6DpFcIW2hAZA+TFlPUdixRDIJu2IExNLYaYS+2dcsiJxr1ZNOmmoPLrVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewS0He+J; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8947ddce09fso48551086d6.3
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 09:37:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770140275; cv=none;
        d=google.com; s=arc-20240605;
        b=I0WPjyIvVNHhbCu7iJt54A0z32GQGy9SsTEJlGzLTpcuoPHuSzagcRJXEcMTvhAdut
         zAjrGoOYhjh+Wd0dHotVYrwcouM2D/ueVSPYEvnNSiS8cTjkWT0P/h9FUr0C6E8XhjGp
         fQdi1C+bTHrzpdKJ8CCJUI4hBEfidQOVQhllH6y1j6dp9b5k4aoXie2cY+lFh7jqU8Ju
         mDPxKlAe+YYrz631tYmhbETC/knUawDXOYqJWoO8yZ6r3t251OTKeXYJb6iaQhlUPlHF
         p1qnr2ALJ/rHkb89UbnaR2Hx3p/vKypC7WgqBVKNdhTm461zO7WeNu8c1GZ8siduyI1N
         hFHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sCet8w2fzClT+BjAferTRcrOmf4nu4ygw7S0ICHDOaM=;
        fh=UyX03oUOQyB95C832SmbMan/sIhS6/9XfNq9pWkjvgE=;
        b=jUdEUR6Zql7ukf+wt6YVH8Dal9Zk1TWO04y6xJzmsUc5pGJxWPEwWHuFCsvKMfq8QP
         iSr+DFEEvYsbmkHWZ0bXnf+IKU4827GQK/JXXNKA1bCfQRGntcIB4il+1pzf3cTqRpsh
         eJea99CDhzRQ45xzV0clzb0/rNQiQrOqoLDBvV525t/bWBuG1xs69Bl0uUbY4t3hv2jJ
         GtksIbRu6suAMYT5XK5XMm8vpUfXU+bKkh2+/FDrGDSlBkuVCg45ClNDNJJxClc5uYL5
         7K9plQhElYLEMbcLqzkJ0UGqV5IivbDZfEFblupVLKOBSgLWxTGpEsN1N8ZoQInfhF1J
         Oc0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770140275; x=1770745075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCet8w2fzClT+BjAferTRcrOmf4nu4ygw7S0ICHDOaM=;
        b=ewS0He+JE/HGZkP1DkihKJJAPsyxXq4wq1wbt18YFbRA4a9Gwqru7bhY4IQKH14LfW
         01U/JQnnxgIVVQVOh57L//HTHE5mdvCa4hznAsKuvkGF8cobE0TWY1PL4+ctUHGAMDI/
         dRsfUF+uNZo5w/6pfNDA7LSqCd8yClpyZSOZAZOieF3wrERd7qmHqwaczrDFg+ASuMKJ
         ywRi6PymRjVRjMYUrDGGu8cCerN0g1Pa/iMjcDUyqlrB3vRX7ZAft9r3xEmscwKsRRzr
         qn8fsRf1W0r4A9BjGqDyfD28p2I25mHrxCFuQZo9pkVtZHq0WPS+u2O+eqM98bBsuhEt
         J6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770140275; x=1770745075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sCet8w2fzClT+BjAferTRcrOmf4nu4ygw7S0ICHDOaM=;
        b=GdaflVXHNooFXLdiSwR5jnzD3TQJ81qTGBNNbSgN4LDdOuiabJeJG7fl7Mv3NPpol7
         j7wo+Xgth3UMK6ZiwNjEi8xo/cEHKaqZGHVN+NEYPE6app0Ne9ne/K+53HsER0+KiNCG
         QLgf6fTguQbRhkM0e7CSw3HnV0oxnjD5/t+WDfygkM5eA1i6z3EgEuBWh/P3gWavzhcm
         h7lNY+i5Iaf0iO8QcZTUORTfNCD6KRSP670Z8By2jONfWk/lVghjhyFdNXN/kPAv7e2B
         yjm+ubhxQQA9j7i9TIbciv3W+M/o6SteAf6Rsf5jR5G9McQEluey04pO8Pgs8fFbGmEF
         OAag==
X-Forwarded-Encrypted: i=1; AJvYcCXtj7CD3pfti1FWbzqEo0i9GpewdAF/zf2lRWrIErnM/F6TBH3qLO+8yCOO1Gy7KpX6ExHqlnykNjF7@vger.kernel.org
X-Gm-Message-State: AOJu0YxQDsfoABy5AefwMdwSjv/ZGeudJ6APX8nQQHv/H+N8uLqPTYiV
	nz5bksdbHgTUYn1QLWpPC5yUglloARt/7USk4stcBLGgYC8PH+k7aKM4MRDP6yiVSfyfPo8qfLy
	M5Xa6GaOg5FpHsV8L0op8YtxwOZwcViI=
X-Gm-Gg: AZuq6aLxl1koXAwZZ8Mfyblvwi5I63ucVyAGrK/tX6FXx5wXNyzz8d25Hpmb8qCD1Lg
	kGnhtjT/aAqxKVAYIDB+DxJHdi0rJdC8aaSTtnzvXVVlomvd7dJb2kMKmUIKgcu5oeogQTEc5Zg
	4+Ptb4MxqSLrozVtSZz0WqWcvr+qb4fTDNa++zUaz88NPXUUnOaBWTA/+PHBr4xM4JDBz5Rfcqp
	5nnbPl0v9nKTfnlRcGGGZMBvL5SrvLnSv7QUzDG6Qmstadlb23rTKg7cX3Y0fUH5gOUihD+nX4f
	yZs7X8GmsjSTcdUJCDBaNevN/rMzryAY92B+Sq3jOWbctQY9hw/yyqlZAs+Zw8QbivK1sxHF4UQ
	gvmX8qLCAzAQVJgVCuz5QvoCaDu1OEW/x/0NEQBKFWqkZk0ZH0uyOXCc1T0P+0Tmjq0e/gpJDaC
	eGfokHRhI6Lg==
X-Received: by 2002:a05:6214:e8e:b0:892:6681:a92b with SMTP id
 6a1803df08f44-89522233f1fmr2607526d6.49.1770140274833; Tue, 03 Feb 2026
 09:37:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769025321.git.metze@samba.org> <20260128141123.GG40916@unreal>
 <1f77a9a6-9020-4d65-a6b9-fe68d4f6e46f@samba.org>
In-Reply-To: <1f77a9a6-9020-4d65-a6b9-fe68d4f6e46f@samba.org>
From: Steve French <smfrench@gmail.com>
Date: Tue, 3 Feb 2026 11:37:42 -0600
X-Gm-Features: AZwV_Qg7No4iBiPwVQ2zXu54m187QppFn0sUrUinniPRJCmJMkuABKEBAHh9GZ4
Message-ID: <CAH2r5msoO_hY-U71_AHt5ns2Wf1y4Kry6g1gqFgzzXKNSA0i5g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] RDMA/smbdirect: introduce and use rdma_restrict_node_type()
To: Stefan Metzmacher <metze@samba.org>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, Jason Gunthorpe <jgg@ziepe.ca>, Tom Talpey <tom@talpey.com>, 
	Long Li <longli@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16478-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,samba.org:email]
X-Rspamd-Queue-Id: EB234DCF83
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 9:25=E2=80=AFAM Stefan Metzmacher <metze@samba.org> =
wrote:
>
> Am 28.01.26 um 15:11 schrieb Leon Romanovsky:
> > On Wed, Jan 21, 2026 at 09:07:10PM +0100, Stefan Metzmacher wrote:
> >> Hi,
> >>
> >> for smbdirect it required to use different ports depending
> >> on the RDMA protocol. E.g. for iWarp 5445 is needed
> >> (as tcp port 445 already used by the raw tcp transport for SMB),
> >> while InfiniBand, RoCEv1 and RoCEv2 use port 445, as they
> >> use an independent port range (even for RoCEv2, which uses udp
> >> port 4791 itself).
> >>
> >> Currently ksmbd is not able to function correctly at
> >> all if the system has iWarp (RDMA_NODE_RNIC) interface(s)
> >> and any InfiniBand, RoCEv1 and/or RoCEv2 interface(s)
> >> at the same time.
> >>
> >> And cifs.ko uses 5445 with a fallback to 445, which
> >> means depending on the available interfaces, it tries
> >> 5445 in the RoCE range or may tries iWarp with 445
> >> as a fallback. This leads to strange error messages
> >> and strange network captures.
> >>
> >> To avoid these problems they will be able to
> >> use rdma_restrict_node_type(RDMA_NODE_RNIC) before
> >> trying port 5445 and rdma_restrict_node_type(RDMA_NODE_IB_CA)
> >> before trying port 445. It means we'll get early
> >> -ENODEV early from rdma_resolve_addr() without any
> >> network traffic and timeouts.
> >>
> >> This is marked as RFC as I want to get feedback
> >> if the rdma_restrict_node_type() function is acceptable
> >> for the RDMA layer. And because the current form of
> >> the smb patches are not tested, I only tested the
> >> rdma part with my branch the prepares IPPROTO_SMBDIRECT
> >> sockets.
> >>
> >> I'm not sure if this would be acceptable for 6.19
> >> in order to avoid the smb layer problems, if the
> >> RDMA layer change is only acceptable for 7.0 that's
> >> also fine.
> >>
> >> This is based on the following fix applied:
> >> smb: server: reset smb_direct_port =3D SMB_DIRECT_PORT_INFINIBAND on i=
nit
> >> https://lore.kernel.org/linux-cifs/20251208154919.934760-1-metze@samba=
.org/
> >> It's not yet in Linus' tree, so if this gets ready
> >> before it's merged we can squash it.
> >>
> >> Stefan Metzmacher (3):
> >>    RDMA/core: introduce rdma_restrict_node_type()
> >>    smb: client: make use of rdma_restrict_node_type()
> >>    smb: server: make use of rdma_restrict_node_type()
> >
> > The approach looks reasonable.
>
> Thanks!
>
> > Do you want me to take it through RDMA
> > tree?
>
> As I also have other smb patches on top changing/using
> it I guess it would be easier if Steve would take them.
>
> Steve, Leon what do you think?

I am ok with taking it via the ksmbd tree (smb3-kernel ksmbd-for-next
branch), unless it is practical to merge the RDMA changes through the
RDMA tree in the first few days of the merge window and merge the
ksmbd-for-next branch a few days later (which sounds potentially
trickier)


--=20
Thanks,

Steve

