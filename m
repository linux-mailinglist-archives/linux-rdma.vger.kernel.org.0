Return-Path: <linux-rdma+bounces-16688-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOuCF6sfimnLHQAAu9opvQ
	(envelope-from <linux-rdma+bounces-16688-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Feb 2026 18:55:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A75113451
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Feb 2026 18:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 508A9301CDB7
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Feb 2026 17:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6D237FF6A;
	Mon,  9 Feb 2026 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Bn8cJZzv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612DF2D5C97
	for <linux-rdma@vger.kernel.org>; Mon,  9 Feb 2026 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770659747; cv=none; b=kZMRD/6UTFkDssItJFwOga3gWnHioOIfgACyhsuNCVPBufpBkashWcCbRXuQ2y0e9JAi8D7bcPesbh4WAVZtgP0zB/q12J1Ogtlmm/rexcoBLSIE9J67n+Jpnnw7HL+1ISKXHUzxR4io02eSZ5gWK2u2BlJyvbq3yKrUzWlMUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770659747; c=relaxed/simple;
	bh=EfVHrbdF8/yG09IBQ20HHyfnxAzay8Gf5YSnWq6tV7k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pJ+hUkwLv9gAlQHo5xMrdh9wPrC+oMriJik8g3eMwQjfpVRLNMnrfECYZJmbzFVdIW3Tu08IiTWG42kEvLHVnsmm2Hb5kn7EArI67ODHgt6/wImFVktfGkWmtbULvN0WQwyFTrbdtEBfge96NuXOqDhUxZ+rXEfhtO2ZGpv/mJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Bn8cJZzv; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619HGiDv1007540
	for <linux-rdma@vger.kernel.org>; Mon, 9 Feb 2026 09:55:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=EfVHrbdF8/yG09IBQ2
	0HHyfnxAzay8Gf5YSnWq6tV7k=; b=Bn8cJZzvLW+ub4TphsBLMPLV5SKHguDedL
	Pmr/Hz0pmdWlvaYIizESDJUnX0Co831psKGBQQP41MVXquIaEmOjLuY72489pEX6
	uUkIYnTEbMesvCrCMfsz2ngkU+bK8akRc0WLolTjnE9uiHlyem7KOcinTdArb38n
	6h5krBnqhUPSD5MMnsZDiO6TNDmvrhzi/B2JOOXf7huOHvhMkRGOd/okchsUNbS7
	4p/zdTxoqlJnjamaY+JedKvDKb8qGUKL7jcxN/T5gte3S5yGJpI5XouIn5dwzkn7
	lsiQDkAZmgxTzp49aAvAQX9bEBMXpWHJLQhmz7c6/UzGA0Zp4nRg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c7f1vv68y-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Mon, 09 Feb 2026 09:55:46 -0800 (PST)
Received: from twshared25002.15.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 9 Feb 2026 17:55:42 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id A763A100D0418; Mon,  9 Feb 2026 09:53:18 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn
 Helgaas <bhelgaas@google.com>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
        Keith Busch
	<kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas
	<yishaih@nvidia.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Zhiping Zhang <zhipingz@meta.com>
Subject: [RFC 0/2] Retrieve tph from dmabuf for PCIe P2P memory access
Date: Mon, 9 Feb 2026 09:53:10 -0800
Message-ID: <20260209175317.1713406-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=dIGrWeZb c=1 sm=1 tr=0 ts=698a1fa2 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VabnemYjAAAA:8 a=yWaUcmrBNUFKcz5DFYsA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: WQCUAj_TaQ2gpyiK-lv-9pCmaZyks2iq
X-Proofpoint-GUID: WQCUAj_TaQ2gpyiK-lv-9pCmaZyks2iq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE1MSBTYWx0ZWRfX6NFgkq2OgjhS
 gvyhuPHhI9n4RJIEJqzLLvds/O84/t5oaXI0Qis+26vtxdXmfwYWFTj93buI+26E4RWl3xwx533
 TvCRTuRYVDjr2ig+UAIayTkkQcNP1rz3+n7gUAhYWKT5vd5RMSMXz8QmKU0i4ul61BYoAbnb06h
 y1/EPMrQtWCld7yHEDvW1D8P4uNf6/RzV66E1Jkt4xSDc1vJS/K2n1XbfEl3iurGhNmUnpayaW3
 K74yMhj8xSIgPrZQK9bH/PL+6WDTWl5WMSSrn7uAYd21GgH5O7hoprLZTtTwa5qX3d4U1211yfb
 dqZM6Y3rhJh813Dt3Tja6iCCKu4l+BpIlYRYFXmrj9tA7hfJY2LF2Zxf1O6ejw7Fe8olBQ7MHxC
 +QjK8bh+ashkwiPrOiP2o/I7TieKSRh72FK0EdhwMVOSlNolIZNwTBG5u/0K9uVG2SMx3T7npA7
 c0oFxkDBugTiyUX1MjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16688-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim,meta.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C9A75113451
X-Rspamd-Action: no action

Currently, the steering tag can be used for a CPU on the motherboard; the
ACPI check is in place to query and obtain the supported tph settings. He=
re
we intend to use the tph info to improve RDMA NIC memory access on a vfio=
-based
accelerator device via PCIe peer-to-peer. When an applicantion register a
RDMA memory region with DMABUF for the RDMA NIC to access the device memo=
ry,
the tph associated with the memory region can be retrieved and used to se=
t the
steering tag / process hint (ph). The tph contains additional instruction=
s
or hints to the GPU or accelerator device for advanced memory operations,
such as, read cache selection.

Note this RFC is for the discussion on the direction and is not intended =
to be
a complete implementation. Once the direction is agreed on, we will work =
on the
implementation or a real patch set.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

[RFC 1/2] Vfio: add callback to get tph info for dmabuf
[RFC 2/2] RMDA MLX5: get tph for p2p access when registering dmabuf

