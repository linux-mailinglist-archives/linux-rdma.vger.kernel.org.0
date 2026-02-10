Return-Path: <linux-rdma+bounces-16740-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPrABWGLi2mkVwAAu9opvQ
	(envelope-from <linux-rdma+bounces-16740-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 20:47:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC38011EC9E
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 20:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5D55301871F
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 19:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E9F26E710;
	Tue, 10 Feb 2026 19:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DO9mt+Uy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5674B3254AC
	for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770752859; cv=none; b=DklcsNLnT3KAosmh0ING9vTgMM3Xl377OFy9bjL5OTZiaEZDtALATU0l4nnqf4XpL2YPevVFA8nzIcHu/u5P6poUPNPDXPld80B8EKo4Qh4T/l955Lssif+vQQdKCTIShEbt7g1HsxSi0ah/djaG4ER/K0AyZVB1Kgw50Sip6DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770752859; c=relaxed/simple;
	bh=EfVHrbdF8/yG09IBQ20HHyfnxAzay8Gf5YSnWq6tV7k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZmX1/3kRb5pZZcfBiwq9cwf8h9Hdmc4yYD4AT5VcCr5+rYclzr1uk8hbsgvYq91iXfQshef2hRWBYPzjqJBf/MCcY53ln4x1DXtd0tXHb3rnPmoyAzVyaNPFd+G8nFJCRwGyb9Q7w/+7cAB8DhOS249mm9EnVjcV97iYXj9AzUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DO9mt+Uy; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AH2JQ73309727
	for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 11:47:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=EfVHrbdF8/yG09IBQ2
	0HHyfnxAzay8Gf5YSnWq6tV7k=; b=DO9mt+Uy0AavnJKPFVpdQFeFx7wmTdy+q4
	9Zd4SKKQmT5Vxv/2WmpU1HS840cw6ba7ngN9cPfRzgPKdITOFHsdorYD8x6x+E4m
	1JXQPhMDSMeQz1TiJo6rLGQBRGPcwf2G6EZvZ/rF8Mb470XJw1z4qXOf3WytmD8o
	2v6WbvmjIRztxj9f2688BRhkKu6wbvK91YJAxi/+SvtOl9qZ9RloccAoR5iNuFfz
	OqmYtB9XrvDMETixsQRtZAvOAw0mIGENvnNHToGezVLrFU6uZx/fZg4Xiu1uXGYY
	9vhVznJJFygEAulULtYOW5eOVYweFnOQor9hPvNVDgKyDc3wOxIQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c88qnjd9q-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 11:47:37 -0800 (PST)
Received: from twshared41309.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 10 Feb 2026 19:47:34 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id DCAA7102666AF; Tue, 10 Feb 2026 11:40:15 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn
 Helgaas <bhelgaas@google.com>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, Keith Busch <kbusch@kernel.org>,
        Yochai
 Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Zhiping Zhang <zhipingz@meta.com>
Subject: [RFC 0/2] Retrieve tph from dmabuf for PCIe P2P memory access
Date: Tue, 10 Feb 2026 11:39:53 -0800
Message-ID: <20260210194014.2147481-1-zhipingz@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE2MyBTYWx0ZWRfXw1moQZ4RU0Cb
 ZnkTprzGaMh0z/WxJ289ZNvHZdOrMR3jU4c0R3XUbNpdwpRTp39jz908WUn7Igl1ocWJg5QyzW9
 9aoGErzQ1kOY+qFOiLlx5FdACuDYf8EI+ol5b5j1v/v0vRq2L+YuvvrLwkMhOzf4dzv+moAcS8Y
 nCjyZxjAKBg9thW8EIjAOYN9f60wo2P6U3avBC/ZBFEPGvzMjBMtL2Sbn9GCYI3UK7c9yg30VnS
 9cmHIBiEz/xc7w4hF9PXrF9hDBWQZhNkFKgp/u8LGnME6ux/TSE/tvGb3NHSj5Xj5wSQhdAq5Tf
 hAJ34RMOedy2MJdAwZk8TmqVmKQvoMgYyHZC8WXj8OPFycfw70IrvQkzk9NoQNp4JIri3gWVwA4
 uMZhKQni6L+FN9UNlroIj+5IfPHFZM39ZPjDpEIiJrWNPp+huQ9vu8maJqg52snpPefEalJlf7s
 IouOiRX9enDnlp/2MYQ==
X-Authority-Analysis: v=2.4 cv=POkCOPqC c=1 sm=1 tr=0 ts=698b8b59 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VabnemYjAAAA:8 a=yWaUcmrBNUFKcz5DFYsA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: GyVlbZvkTlo8NfvjfNtNUSoM3S0ZT9Cl
X-Proofpoint-GUID: GyVlbZvkTlo8NfvjfNtNUSoM3S0ZT9Cl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_02,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16740-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim,meta.com:email];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EC38011EC9E
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

