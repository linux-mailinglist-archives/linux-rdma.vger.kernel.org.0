Return-Path: <linux-rdma+bounces-18909-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFi+NWZezWlncgYAu9opvQ
	(envelope-from <linux-rdma+bounces-18909-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:05:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F9837F01E
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ABD1300DE1B
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 17:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C460047AF5D;
	Wed,  1 Apr 2026 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A/bgVBGk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410D5402448
	for <linux-rdma@vger.kernel.org>; Wed,  1 Apr 2026 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775066156; cv=pass; b=PgS8uMlrKmuczGiDNdUr+J9hnjU6NxOGSCE8ldsogH3OMDtfpblcMrYdpIlg47aqva9j4N2fttZtV/b9lFhgbvg8cwu4OFIUiF8wj0ZQEkhxbWK0uqtF9eOhRJ49VUjTiQOpjcUU/vK1fjot04Kt60BouG11UFS5Z4TlO/94KD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775066156; c=relaxed/simple;
	bh=rI3zlSmlqLdQsi01tTAjvpOZwJXVUQW9hApKHGrcas4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdnDAh69CUJwiM/jhwXL1SAtut1fKsSUejj9vX9t1fhrTWa3PxR2eqNquvCE+3V8pXr2YPmWSpTECFO0goF6SReHkmVDbkQuL6HjLXM8KWZa1h+BDBj0ZLZy5RI6WIx7QBX/aDazNebnionWBaQdPIkAx8fxoNiprh91woRVtVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A/bgVBGk; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-509062d829dso43801cf.1
        for <linux-rdma@vger.kernel.org>; Wed, 01 Apr 2026 10:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775066154; cv=none;
        d=google.com; s=arc-20240605;
        b=HF6KjmLnaWd125EowcUAfQE4iYlzMeN8hVq6ERv0jNdm1cmOq7iSSHa37IdbASeOYb
         UvNx9HIFWfjEbGb0x9RF2zgnjUOXpZL7+KfBhNs7zW/ozvjbZTlSUNRG+lkZwYjotbnr
         +ge76ZiNF2NmcGEK4GX71BAgXTXOpR7xRnGWbDO/JZVy0NT4IXTvZlRM/RUOUf5Qoaje
         w8UHgRb9G0bjdOxyKy7WxlhXObO0KIJ11bGpkPT2qc66kXB1bzp00by/dyC3aRFEmlcO
         57xhBZnyEO7xtTLwao4NLMFSN5PZ/dnI70G4ul2CNYi5YnP4/oZ0nReYv5sXpEpcCx0y
         fu9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ReGvIRamQKTwLkNtBvdSUx11bFcxQAtxWsfgviw7Dlk=;
        fh=fLdTeE5HV9Rp+BTQuzdYd+IbiYFAidITK+nV6QUW6v0=;
        b=PIokOVmqt4H1i7uRc0wIV90dFCTtROZvIWiEhOkU3nMhjExvztdAtJ6qU0KFp83n6b
         2IbihxX5i5m++3vPfwPjETOVqQObvLHRD5ul9y5GeFmcLNINg3tSowTCQAVVUgiTAXtR
         9rA4dJ2LDeol7gMmZGGj0KY5DktmNQRvQHETMear1P10pVUpP+Qyw9GQtTr8I09YoXEX
         3E5/rjbitBDbt6XmkChB+xLU29/H9tBm8iw4cNqug63MhrVtezV4F4XrIZZu+FZWqICM
         9InTkngn8vnW6P4c34InrCtIWKOeKKtbHGD0VUnA8MUYf7QAEiQXjTS8TceRUedWeTcu
         KDsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775066154; x=1775670954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReGvIRamQKTwLkNtBvdSUx11bFcxQAtxWsfgviw7Dlk=;
        b=A/bgVBGk8MOL1Ckq16URNx5y+zleYxMZazSi3buKUcpoRTl5+WTHmJKbLi7O3t3FDq
         /8Mj0OXrOs8vxmxqpQQAldWRqV0EEhDrx5C+X15BmChWhkqPeBZd+NZm4D+r59DynHpY
         ySeRoHY/rIZOGhAkizy1n4XhfJnkER3DHby//BdYN0nKn9qfpSYQd3rmZ5pM6g8+FlhZ
         Gzs82kOnH/Np44K5OfRIG3a/uLtSj0ZzuBDMrB3sEgJfxI07pGeF44dv2IjMTWcLVjLd
         ld7TDLHn9aFVOVbYodtFdffenfT2W62Ycyu5gi0b2DH0P9k4wEG7YcygbejJkFb3A8kk
         F7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775066154; x=1775670954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ReGvIRamQKTwLkNtBvdSUx11bFcxQAtxWsfgviw7Dlk=;
        b=J8BnR6NvHUvVZD/f2Zus4ptvyxyfykiHyHE7yLkhkVQgdPPP8KTaPUhChHCl+la5tB
         CxYRmdshfDPk4TPW+7bgDmZm/8r+42/Qf8PsAHz2rChWua3xBbMJdb27RMLfrXocsxy8
         HWmeMKwOkOocLyiUtOxHE3mVDMuT0T1QlRIF+1yS8DJJaR3z8pwWIOE3K/6ElltnhH37
         yO/7S6eenNZdSehs5PrjvTma/l8lx3ODZ/eh/hvk22Lyqa7Qh9DvmvmZayCrhYcG5yx3
         G5jy9HVypp9Ha7rqpmz6YkLuUtI9yaV/6WUQuUBGm2fiC9aT4z1lAeNCf7+u1nmGA71H
         fRyw==
X-Forwarded-Encrypted: i=1; AJvYcCWJhPYsYHpuaGWhZDLM51Tjf5tp9/TgtD2UFPK7VHz3U9jUxXD49BBqkO0024mM7q4kR6IsvQc7Ky9z@vger.kernel.org
X-Gm-Message-State: AOJu0Yztz3RdWb3bnlu77Ai10GLuqmTzhlXLP6YUR8bvbVjeph6mGhlW
	3qTLfx3nBbByMHU6ki+zmyEJpvCZ02gCF0S6Z4toCxYllX50PG419DccJnZgc5wUaJzillUSxWP
	e9HzAUksFFg23rOWcuDrgw3dGf5WpIK1Y1JK+IOBUNzFVUm2NxhwkuMtO
X-Gm-Gg: ATEYQzy9qXUL54v5oYg3LwIfu9zOjfqrO0XC6o8zukMbgKPW1JDovyoqwT9+I4uTntD
	QDf91rAhx3J+6D+RBldnWwoV9FNky0ZFXXB7uA5H3HeRtOrq2qCVsr492BvqfedNLR6jPZ4ibGQ
	216CiTyaU+13EQ6wukelqXa+iG1CuKuxXuc0co5LulFpPSswPBAYDmnuRNwnj5pToUqxGP5l/DL
	QwOjR3X/Nn6HTM3CW7aAkR/CAVp0eHfh15XqpnpV51znzN4ra2WWVQo2d8W9EzJJuCXsZQUfH5Z
	YA8glGfxM6bG2RWzjsgEpwDG+2yoBq6jYS5QMWK3wA==
X-Received: by 2002:a05:622a:a984:20b0:508:fd42:fd05 with SMTP id
 d75a77b69052e-50d4cf74f96mr468201cf.15.1775066153808; Wed, 01 Apr 2026
 10:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401103441.1229964-1-shivajikant@google.com>
 <20260401141706.GA22165@lst.de> <ac1ZOgnpSjxo51WK@google.com>
In-Reply-To: <ac1ZOgnpSjxo51WK@google.com>
From: Shivaji Kant <shivajikant@google.com>
Date: Wed, 1 Apr 2026 23:25:42 +0530
X-Gm-Features: AQROBzBO3uwmhMnnY_FB_39FojpSluJnZxwak-mZYTWRmVQmxbW5MvZBvJOGUt8
Message-ID: <CAMEhMpk=hro9xWuxo6rYaatsjJvVPuLM1Wi-Y6zbzOxcpPFqCg@mail.gmail.com>
Subject: Re: [RFC PATCH] nvme: enable PCI P2PDMA support for RDMA transport
To: Pranjal Shrivastava <praan@google.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18909-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shivajikant@google.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 44F9837F01E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,
Thanks for the reviews.

On Wed, Apr 1, 2026 at 11:13=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Wed, Apr 01, 2026 at 04:17:06PM +0200, Christoph Hellwig wrote:
> > On Wed, Apr 01, 2026 at 10:34:41AM +0000, Shivaji Kant wrote:
> > > Enable BLK_FEAT_PCI_P2PDMA on the NVMe when the underlying
> > > RDMA controller supports it.
> > >
> > > blk_stack_limits() currently filters out this feature bit because it =
is
> > > absent from BLK_FEAT_INHERIT_MASK. Manually re-assert the capability
> > > in nvme_update_ns_info() after the stacking operation.
> >
> > This is really two different features/fixes and should be two patches.
> > Note that Chaitanya also has an outstanding patch about p2p on multipat=
h,
> > so please work with him.
> >
>
> Ack.
> Shivaji, I believe this [1] is the patch Christoph's referring to.

Ack. Let me work with this.

>
> > > Hardware reachability remains enforced by late-stage distance checks
> > > during DMA mapping.
> >
> > I don't know what this is supposed to mean.  Callers need to check the
> > reachability first before submitting P2P I/O.
> >
> > > +static bool nvme_rdma_supports_pci_p2pdma(struct nvme_ctrl *ctrl)
> > > +{
> > > +   struct nvme_rdma_ctrl *r_ctrl =3D to_rdma_ctrl(ctrl);
> > > +   bool supported =3D false;
> > > +
> > > +   if (r_ctrl && r_ctrl->device)
> >
> > to_rdma_ctrl is a wrapper around container_of, so r_ctrl can't be
> > NULL for a non-NULL ctrl.  ->device also should not NULL because it
> > is set up before namespaces are probed.
> >
> > > +           supported =3D ib_dma_pci_p2p_dma_supported(r_ctrl->device=
->dev);
> > > +
> > > +   dev_dbg(ctrl->device, "PCI P2PDMA support result: %s\n",
> > > +                   supported ? "PASSED" : "FAILED (HW/Driver restric=
tion)");
> >
> > Overly long line, and screaming isn't really something we do in our
> > messages.  We also don't do that debug message in PCI, so please just
> > drop it.  IF you think this is important enough add a tracepoint in the
> > core code in a separate patch.
> >
>
> +1, we should drop the log and add a TP if necessary.

Sure, sounds good. will incorporate these changes in v2. thanks.

>
> Thanks,
> Praan
>
> [1] https://lore.kernel.org/all/20260323234416.46944-3-kch@nvidia.com/

Regards
Shivaji

