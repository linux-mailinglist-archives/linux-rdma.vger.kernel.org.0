Return-Path: <linux-rdma+bounces-19440-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sExmHx505mnKwgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19440-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 20:44:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2213043304A
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 20:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41355300D1F8
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 18:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6068A3815F0;
	Mon, 20 Apr 2026 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="lmTLwZTJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28F23A5E75
	for <linux-rdma@vger.kernel.org>; Mon, 20 Apr 2026 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776710684; cv=none; b=EmnlbPqPz2W9Y60o5nAUz7M7TCcLTBUvYmWbdniDfJ+UzQkjhcBJhaTjKFW3dutSaYDddYQDdljRj64xL3sxLaVgWL3WhLkLzFaGcyxjHxGbCLEv7k/KlSsDr29azHVbofc/rfzVFJZDEHTd1XrNkP+hQY086/s5lX8R8ry/Zis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776710684; c=relaxed/simple;
	bh=r50orGBhNi8QT5mU3Y2eQHTwkyereZyiuejiji9RbTA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YMCsNajbmbVgg/mjImzkbiAgSIKQBm1d6AhDf2t3PWxKEzIxHAx1fECwhQ9KX/k1BRSjS/j/1/lHvbEgnthFuP7b0pXO9iJPrOHVxziQEsEdY3nNfcE1TNzausSCaTxAN4iIYqAmke60Mo2MP4OQj6wLXffjbuj+0N1l1POF/E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=lmTLwZTJ; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K4G7sD3312329
	for <linux-rdma@vger.kernel.org>; Mon, 20 Apr 2026 11:44:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=v1B/weXcqQ1lWLTVVV
	0vhTvXO65+/046zoF1VJqryV4=; b=lmTLwZTJjAs6lgOoHWNSrsl3aPUh3AG54U
	dTO4XGquprYR6q/ph4MhY0BSFDVGQkVWURiqlnvll08oow6VhceG+As1lhSU+j3D
	04nQCEfN2Nd+5ZnNAs//DCJFMIomdywVDMzZXujLuNBlYZM5uOMlWNUXrobAz4H5
	ImqMUODQ8YCv7+toj7lYSfAkqLdwgwbD50VP/SZEGkhOImzlaApHtJ7/TUaHSW2J
	RKZ22WLJniIdHy1TFWxJvzWcEMltloQqiGQB3AGpaigUKdQsxWE61Gt2uX+b6h5i
	95+fUbdAIH+J+wpTcNY4hr52T10FTqvgaZJLe7c/unPp5d7+3WNQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dmxjgpy51-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Mon, 20 Apr 2026 11:44:42 -0700 (PDT)
Received: from twshared22734.32.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Mon, 20 Apr 2026 18:44:39 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 7C0B6113AA911; Mon, 20 Apr 2026 11:39:20 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Stanislav Fomichev <sdf@meta.com>, Keith Busch <kbusch@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn
 Helgaas <helgaas@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai
 Hadas <yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v1 0/2] Retrieve TPH from dma-buf for PCIe P2P memory access
Date: Mon, 20 Apr 2026 11:39:14 -0700
Message-ID: <20260420183920.3626389-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3ifAKuximidgivl2dRevrr1OBYRDxQaP
X-Authority-Analysis: v=2.4 cv=WsIb99fv c=1 sm=1 tr=0 ts=69e6741a cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=XtSdSgJ7MZthVsN6br0A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 3ifAKuximidgivl2dRevrr1OBYRDxQaP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE4MiBTYWx0ZWRfX2maSlplycT/P
 Z3+lIgI0R7X3NJOoa9WRc6fNHX7/zqno+J0y2uzK4orMb6d14ISBEa+8siKMj6jiK5v4ptObfzA
 APpDGLIZBCxCZ2urhhKMoSp2gyQRMk2bndZQ57+NOwsWbxAuZ8fGR0LTcAbYg4YXh88AgkQHKO9
 iP1JbFai7LNyoQAj6kCcnhOsjmxB8a1j3LdxSelYXbGoX4ZopTzMQfzigl0U6wraMxgwkRULLSf
 jvW5GfhfIjsC+RtYeOrPXzzQQbgisLUVjMdncgmqPfU4z8dI8LRFExWHrmuLHc//XrAMup7NX/j
 vS4vdZbIZUZhOrUsiL3rjR+o7NcpoK1sSP07jY2VH+4+bOIuK5e/qryUfLFqSsmbjVvQDSr2JG7
 jFWJt67A/PhjTOkUq96Wi5j4xes7SxSCywYcENviNX8djSifIGjoFFGpu1/Bk+rHiaNIHhTACHO
 J6U2235gzKNxJd0GBzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19440-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:dkim,meta.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2213043304A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, TPH steering tags are derived for CPUs via ACPI. This series
extends the VFIO dma-buf path so a vfio-based accelerator can attach TPH
metadata to an exported dma-buf, and lets mlx5 consume that metadata
when registering a dma-buf MR for PCIe peer-to-peer access.

Patch 1 adds a dma-buf callback to retrieve raw TPH metadata and updates
VFIO_DEVICE_FEATURE_DMA_BUF to carry the optional steering tag and
processing hint in one extra trailing entries[] object without changing
the base uAPI layout. Patch 2 consumes the exported TPH metadata in mlx5
and converts the raw steering tag into an mlx5 steering-tag index.

Previous RFC link:
https://lore.kernel.org/linux-pci/20260324234615.3731237-1-zhipingz@meta.=
com/T/#u

Zhiping Zhang (2):
  vfio: add callback to get tph info for dma-buf
  RDMA/mlx5: get tph for p2p access when registering dma-buf mr

 drivers/infiniband/hw/mlx5/mr.c               | 38 ++++++++++++
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 25 +++++---
 drivers/vfio/pci/vfio_pci_dmabuf.c            | 62 ++++++++++++++-----
 include/linux/dma-buf.h                       | 17 +++++
 include/linux/mlx5/driver.h                   |  7 +++
 include/uapi/linux/vfio.h                     | 28 +++++++--
 6 files changed, 151 insertions(+), 26 deletions(-)

--=20
2.52.0


