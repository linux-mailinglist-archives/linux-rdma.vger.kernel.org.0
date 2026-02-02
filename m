Return-Path: <linux-rdma+bounces-16322-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OWhG44+gGkY5QIAu9opvQ
	(envelope-from <linux-rdma+bounces-16322-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 07:05:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 900C5C8745
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 07:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DEA53001CDA
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 06:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1026E2F363B;
	Mon,  2 Feb 2026 06:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DygzPTvc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82516125A0
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 06:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770012295; cv=none; b=rEiK+Qfn3qpq3ZGcjod5KbDL98SsWQ0BteYVCHLbYoMYMjNa+9+yHCmL57+53Y7X12F+uIIXvNhLQzHErcizCOtq8uldDqFbUSzZ0jli0AHDMGmuyvJzs0GxUmUEoysYW3XGm6CWC+Z/DyT3xbTeTzaviAtlzKJ1KkoBsUe7t9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770012295; c=relaxed/simple;
	bh=GMeD70QarmTwXqRxDBxCNGZanOOroTolQwlcKSvui8s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPi6U+PRNwgIp6QfXdqLr/aGZITx2Q15dOjbJlzdHDkTwT6WflIMNImTh7D4fXd/qIy878HF6WrabMzxv5xDGhXoGr6BEBYab0HWR2yo7EE6qepOvK+ny5I9FtwsKCftixR8nS4QAiLZs5c0Ak/UYgmUTgv6TrmFLHfgNi35PBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DygzPTvc; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6120deZU2630485
	for <linux-rdma@vger.kernel.org>; Sun, 1 Feb 2026 22:04:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=zIFkVdfD9dwrVu/fbTRALogLFbeHpFWOAWDgm5lUUCo=; b=DygzPTvcLUyw
	cvcXSun4+AZi3YtxFyTcXLffMZlbsE+aW2uXf1oyB8ct2ePmWzrgLQl0Amqtu0Kh
	yycqWrX9caF1d3J03zKTCP0MwFlib666F70JxVAmNy6/MEwyB3KKWzxXqqfn4tnB
	I259tiUv/THemDLLFOKKEDWxsPmZZTjJZ0LufrErBf11x2bJ96Ps6qz6HHYACCnQ
	Dj2lpkIRBOlCUlGPa6o3nTyIIMRMtid7oFscQX26YwMeOStzRFTjFF/VTVZ66b9a
	KqM3ArpWheOmyIjqnEeRFPBvzq/Qxo0s7w+DMbuGBsni51A3GJITJ4RE/X3A2f6A
	GwdXq/59eQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c2hju1p30-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Sun, 01 Feb 2026 22:04:53 -0800 (PST)
Received: from twshared26871.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 2 Feb 2026 06:04:49 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 9A6BBF963038; Sun,  1 Feb 2026 22:04:33 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <netdev@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
        Yochai Cohen
	<yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
        Zhiping Zhang
	<zhipingz@meta.com>
Subject: Re: [RFC 2/2] Set steering-tag directly for PCIe P2P memory access
Date: Sun, 1 Feb 2026 22:04:30 -0800
Message-ID: <20260202060433.2341252-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128165739.GQ1641016@ziepe.ca>
References: <20260128165739.GQ1641016@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA1MSBTYWx0ZWRfX8xLKie91rXkQ
 YJuyNqod6ntEBPZYJosyM5fHlFZRfG434P4v91TCzAN2+J0U3PftYoUUaa6Wf2KiaVu1bCGN20w
 iP4vn5NIKYaOdFDAAOapuEJBi+hU/fq7uSyATl6dIwiAu67d234y30uIdYO0JTsh5Ol2aWpI95I
 jIff5neoOr/qo/xO7WtNYfPRBRYIZIwrPd4ed0+dNfHmD7kRzu6qn+32FTXL2tuISPjwC2zo2sa
 +z3id2jbjWlvFIExwOMawG0b3LH+8vo+IzjweL+UyW41sqI5uprPFfApqQSFdef2y1lDFNDV8h2
 1I9vR8AOKrOSN/Dbr8Ncva6NwnucgmP+1Z73gZN7FXRefJrams/xJP9OZ+Qc/u7RVG0xC/Spd+s
 9Cc/4r/Vcw0CiWuq/tpCXzEPnZrcIE+D1qcYCQjThoPvHtAZTBEZSdfijTl8b8ENiVLj4z1Gcgo
 5HKMWfxSA50egORKwYg==
X-Proofpoint-GUID: WX0RaZbXYdhXjIP2C7dbmILygG5gp7aj
X-Authority-Analysis: v=2.4 cv=F7Jat6hN c=1 sm=1 tr=0 ts=69803e85 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=2NG-zBdR4ynPUO4DN4oA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: WX0RaZbXYdhXjIP2C7dbmILygG5gp7aj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_02,2026-01-30_04,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[meta.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16322-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 900C5C8745
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 12:57:39 -0400, Jason Gunthorpe wrote:

> > Thanks Jason.
> >
> > We already have an end-to-end workflow around dmah (perftest =E2=86=92=
 rdma-core =E2=86=92 kernel)
> > to carry the TPH hint, across multiple patch sets. References:
> >  https://github.com/linux-rdma/perftest/commit/98bfb3679a1e71ec96df6a=
6d6c8124ac66ebce25
> >  https://github.com/linux-rdma/rdma-core/pull/1623/commits
> >  https://lore.kernel.org/all/cover.1752752567.git.leon@kernel.org/
> >
> > Given that, I=E2=80=99d like to minimize churn and use the existing d=
mah-based flow, while
> > addressing the CPU-memory protection concern you raised. Would you be=
 open to
> > reconsidering this approach?
>
> You would need to initialize the dmah from the dmabuf and then lock it
> to only be usable with that dmabuf. It doesn't avoid any dmabuf work,
> it just makes the whole flow more convoluted.
>
> Jason

Thanks, I see your point. I=E2=80=99ll send a new revision that doesn=E2=80=
=99t use dmah.

Zhiping

