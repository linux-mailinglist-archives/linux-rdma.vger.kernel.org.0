Return-Path: <linux-rdma+bounces-17622-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFDPGT8/q2lnbgEAu9opvQ
	(envelope-from <linux-rdma+bounces-17622-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 21:55:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F38227A6A
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 21:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D78CD305260A
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 20:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5666148165C;
	Fri,  6 Mar 2026 20:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SjvZB0lf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1565E371D13
	for <linux-rdma@vger.kernel.org>; Fri,  6 Mar 2026 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772830507; cv=none; b=M96IvhiohLbsq3/i4OfREgVuufSvx3gJNFZLmfDx55WKuW9wgE05IXUqdyuyJEW/Pl+awH0ndZD2P3YTiAsIMXZMmSnshFcAeZU5WG10YsaB6Io0yq0MO7B9wbLL+78UPhiNxILORGjikmZRHP2zVYXml6KfMeyQdpFT3aEUe18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772830507; c=relaxed/simple;
	bh=1GL/9IKYJEGXT9OiOarvbhmF8G4J6WrPnUY0rtLHCIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bACWJ4ly9aso/MfmFP9KaFQWIDIu1f+pPC67iyddUUwsHxUzrY9HWvzeoQD3Y/DmbRZ5+Fz0OTAumxqPPb2p/46PvRuxCZyTkHMFG7DzV5gq/8TKdWxlMSlL/JUcz834eiQoLM8qio7F9M/XCmhRftPCZONEMtGUIY9kKLv0oMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SjvZB0lf; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626K5TL22745338
	for <linux-rdma@vger.kernel.org>; Fri, 6 Mar 2026 12:55:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=vykdHEryC/vnlsJN6kswrApntHcjxaWoLxbNgiPI9Jc=; b=SjvZB0lfs+bT
	/H4oSo/hYHehvRpcqfIh5qvn4C5Sy32D1Xdz2jPX044BJGjlqqHJz02TNJAk7fh8
	/PZOZdFqEZaXIwizpWEYPlfNG68ZCeGMeEX22pgHuiDGnGQHEWbCf3zMm+KCeDDV
	YygV2FiVeEMoFfrHrgas3oUZN0qHsIblNmYgyLjIT2vl6Io6MU3vfEdNUJAEoci1
	nLAhcoq3EK10c2IK6ZQ+evp0gzRdP8reZgSvUQqXqWu4cQM+OtiDBTXrwJ+CEm+/
	sYYdScOCVs+rfxAjcOr6UJeXS8i3b3HfTxnLxnZoqVaeEisPYpQemE6j3tIWEMcF
	MZWTa5p46w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cqp7h1qcy-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Fri, 06 Mar 2026 12:55:05 -0800 (PST)
Received: from twshared108366.16.frc2.facebook.com (2620:10d:c085:208::7cb7)
 by mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 6 Mar 2026 20:54:54 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 9D02712CD8433; Fri,  6 Mar 2026 12:49:00 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Keith Busch <kbusch@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon
 Romanovsky <leon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, Yochai Cohen
	<yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, Zhiping Zhang
	<zhipingz@meta.com>
CC: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC 2/2] RMDA MLX5: get tph for p2p access when registering dmabuf mr
Date: Fri, 6 Mar 2026 12:48:49 -0800
Message-ID: <20260306204900.3800370-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260301175551.GT44359@ziepe.ca>
References: <20260301175551.GT44359@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Q5zfIo2a c=1 sm=1 tr=0 ts=69ab3f29 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=03ozwUkBphtHgyqjj1sw:22 a=RWlL41xuHJUQnbMF2CoA:9
X-Proofpoint-GUID: 3qmykDo5ubI6iJl-QIIoJgA7WsoxRvUW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE5NyBTYWx0ZWRfXy8yyFZ3TWbJo
 n8gGqZwe4Z6+dU3YXBrNLjFKDY+/822oSNqgZ1mMAIe+URQDWjla0+jRobfqlBvebkNpvQWipTp
 FkKr2Gk/Ljrsv8Fx7+0WSoGVbXgw2WXfLDnX13pAXHxPU+sRTnNqiF5n8Jq2hJwcR9pnzQghglr
 1iKLkNEL8CeXkudatK8dsy7rcFGR13JSuiMgTVueZucqS0Xb4Me5donby4vJdFW3TurP6CHfLn+
 UL5bH20p5Vn3Cf2SGoucoP3XfOmvuPM75G0oZHGYpTUklePF9NbxZpkBcvSgl4nEyJE0XVHsIgs
 7HECusUm6HfKULVnpS5oZ0U5C1aGBSq923XjIl/FGwd23XQ5ASJewjYGxsK2k4wrw2l5/TRZ7S8
 la4xzf0yYGQaB84Lyvcv2mQ7fMtEg68TEwQUrh9N0m+El5EDEj/5r3IChjQRHBXwviVQtu7X0P0
 CjjsEFUrx6StQB6V3Pg==
X-Proofpoint-ORIG-GUID: 3qmykDo5ubI6iJl-QIIoJgA7WsoxRvUW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Rspamd-Queue-Id: D4F38227A6A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17622-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Sun, 1 Mar 2026 13:55:51 -0400, Jason Gunthorpe wrote:

> On Thu, Feb 26, 2026 at 06:21:28PM -0700, Keith Busch wrote:
> > On Tue, Feb 10, 2026 at 11:39:55AM -0800, Zhiping Zhang wrote:
> > > +static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, int fd, u16=
 *st_index,
> > > +							  u8 *ph)
> > > +{
> > > +	int ret;
> > > +	struct dma_buf *dmabuf;
> > > +
> > > +	dmabuf =3D dma_buf_get(fd);
> > > +	if (IS_ERR(dmabuf))
> > > +		return;
> > > +
> > > +	if (!dif there's any implication mabuf->ops->get_tph)
> > > +		goto end_dbuf_put;
> > > +
> > > +	ret =3D dmabuf->ops->get_tph(dmabuf, st_index, ph);
> >=20
> > You defined the "get_tph" function to take a pointer to a raw steerin=
g
> > tag value, but you're passing in the steering index to it's table.
>
> Yeah that's weird, there should be one TPH for a DMABUF, not many.
>

Good catch, I'll fix it.

> > But in general, since you're letting the user put whatever they want =
in
> > the vfio private area, should there be some validation that it's in t=
he
> > valid range? I'm also not quite sure how user space comes to know wha=
t
> > steering tag to use, or what harm might happen if the wrong one is us=
ed.
>
> If the device is VFIO compatible then it needs to ensure that whatever
> it does with its steering tags fit the security model of VFIO. You
> can't harm the device - you can't reach outside the VFIO sandbox (eg
> into another VF or something) and so on.
>
> Under these conditions the kernel doesn't care what TPH is used, just
> let userspace specify the raw bits on the wire.
>
> Jason

thanks for clarification, that matches my understanding of how VFIO and=20
userspace drivers work.

Zhiping

