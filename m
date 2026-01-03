Return-Path: <linux-rdma+bounces-15274-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 52542CEFB57
	for <lists+linux-rdma@lfdr.de>; Sat, 03 Jan 2026 06:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1CB53005F1A
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Jan 2026 05:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE2E265CA8;
	Sat,  3 Jan 2026 05:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="KspRgSll"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825801E1E16
	for <linux-rdma@vger.kernel.org>; Sat,  3 Jan 2026 05:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767418745; cv=none; b=gmP5WOb2bKTeCuPrlZOWyiPG9sfHxp3Ast0w63ehK3MYpnzf5pWxgC7smLhYP/OyBWPHPFungO3HfpVpNiyKOSevf7+ifkmQTIefwMwlDVXGMbHtcUrZvA4wDfSObw39ftFU8OqnOwuyrdHdSRW6ZbzmMAjI6Px+BCRQvKWfYto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767418745; c=relaxed/simple;
	bh=zB7InRxdhbUfArUeoDkJEcjsUSyvb8a9oqQTv82r8uQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFw63GUjGh/3SRb+/ZpEBSFoQxI7uxB6yA4//oULS58A0LdHP+nLyN23ywOGnS908DjTAZ8Rux+N95OD54WrpditYMBRRiwwMl4XCx9/lWVVv8MqnaEUWpdK1OU1m5YTTivDPRg+7DemOMFr9OiEHDjFApu/UTLS5bBTX8VA63I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=KspRgSll; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6034abcs558689
	for <linux-rdma@vger.kernel.org>; Fri, 2 Jan 2026 21:39:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=dPZistrW42shSqONuISjFKYdIKC68QTLEs9Rb5vD9I0=; b=KspRgSllwdkK
	IhK21B6zhGAXdO7wsOGYpQj8wt8XNy+zWmzAN7bK0C3sI1Pww8ZCwJ+gaD29pxr5
	AD8eiVPiFpazgLPcOEtDiPB7ZFI0lz6BikvHbKmJ5RQQG8QN7CRqubXNHyiA1mIe
	lTLMw08nqKtZXBWvG8Uqjf12Ok2agLCuJlJ8a1dDGPFCUGfcoiuwt/nCDI5v8xah
	zDAv9U03P8VaId/DLVyeDBTh1MWKx4ze/yaUhG3BIfawrkxSgA3bbbOT5z3CR9P/
	hL6GLE9E8HAtIxm8BhX0e0lPlhBASyD7sOqgucXKcfTDiYusjyLtH9K2yoaPIicx
	eHLUZ0UNEA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bev80r4pe-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Fri, 02 Jan 2026 21:39:02 -0800 (PST)
Received: from twshared17475.04.snb3.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Sat, 3 Jan 2026 05:38:59 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id C9E25E3FFCE1; Fri,  2 Jan 2026 21:38:45 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <netdev@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
        Yochai Cohen
	<yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
        Zhiping Zhang
	<zhipingz@meta.com>
Subject: [RFC 2/2] [fix] mlx5: modifications for use cases other than CPU
Date: Fri, 2 Jan 2026 21:38:35 -0800
Message-ID: <20260103053842.984489-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113213712.776234-1-zhipingz@meta.com>
References: <20251113213712.776234-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: zKWsZ3ISXyh26i_DYxOtklsLljFhRIpE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAzMDA0OSBTYWx0ZWRfXyOyyT25cv9E/
 JVEsaW7RoV1EmaMKEOs55VvWZarZT9t/06/YAGmsjrk8fz/7uwRIE1903jffoUmtOw6iiuqjQLz
 nTSTHGKqEIHNRVRAJBrFgp8RpeL0q4VNHY05Kfix7zlK719lxLsAd5iyLUqvdMC7Yknjojmfjua
 k/WXfaA0AmCu5KYW9nlAAbmCTTmpcdY81lA+WLoTrkPGl8kQWaP2r7dx6DvVtn2idFFGQXq/3iM
 Fv+feFYArb/4QmvJxFkiB/FTcPsZN2CFuFNZyBggUon7yQlKNG+/kPH8jVcWyaMJ5+1NBnYboa5
 OPktH/me70Og2CUH0lEonIWFjTJeuRkrws4DG5TK+g6Dy9MUh63XwPFBcHV9ORXMN3GAoyZKD1m
 LD8h7XL604TqfIFsFksfQtCHb+J/jE+fdAE2saLNkQ4X3lqctUlTdik4sKuRZAFKgFZbrWXBOeR
 XFrBn4S+D1bIm7fRVOA==
X-Authority-Analysis: v=2.4 cv=Bc7VE7t2 c=1 sm=1 tr=0 ts=6958ab76 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8
 a=dY4F4hLoAaLEDHvlMMEA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: zKWsZ3ISXyh26i_DYxOtklsLljFhRIpE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_04,2025-12-31_01,2025-10-01_01

In order to set the tag value properly besides the CPU use case, we need
to also fix and modify the few checks on CPU_ID in mlx5 RDMA code.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

> [RFC 2/2] RDMA: Set steering-tag value directly for P2P memory access
>
> Currently, the steering tag can be used for a CPU on the motherboard; t=
he
> ACPI check is in place to query and obtain the supported steering tag. =
This
> same check is not possible for the accelerator devices because they are
> designed to be plug-and-play to and ownership can not be always confirm=
ed.
>
> We intend to use the steering tag to improve RDMA NIC memory access on =
a GPU
> or accelerator device via PCIe peer-to-peer. An application can constru=
ct a
> dma handler (DMAH) with the device memory type and a direct steering-ta=
g
> value, and this DMAH can be used to register a RDMA memory region with =
DMABUF
> for the RDMA NIC to access the device memory. The steering tag contains
> additional instructions or hints to the GPU or accelerator device for
> advanced memory operations, such as, read cache selection.
>
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/infiniband/hw/mlx5/dmah.c | 3 ++-
 drivers/infiniband/hw/mlx5/mr.c   | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/dmah.c b/drivers/infiniband/hw/ml=
x5/dmah.c
index 98c8d3313653..c0d8532f94ac 100644
--- a/drivers/infiniband/hw/mlx5/dmah.c
+++ b/drivers/infiniband/hw/mlx5/dmah.c
@@ -41,7 +41,8 @@ static int mlx5_ib_dealloc_dmah(struct ib_dmah *ibdmah,
 	struct mlx5_ib_dmah *dmah =3D to_mdmah(ibdmah);
 	struct mlx5_core_dev *mdev =3D to_mdev(ibdmah->device)->mdev;
=20
-	if (ibdmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
+	if (ibdmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS) ||
+	    ibdmah->valid_fields & BIT(IB_DMAH_DIRECT_ST_VAL_EXISTS))
 		return mlx5_st_dealloc_index(mdev, dmah->st_index);
=20
 	return 0;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
index d4917d5c2efa..fb0e0c5826c2 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1470,7 +1470,8 @@ static struct ib_mr *create_real_mr(struct ib_pd *p=
d, struct ib_umem *umem,
 		struct mlx5_ib_dmah *mdmah =3D to_mdmah(dmah);
=20
 		ph =3D dmah->ph;
-		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
+		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS) ||
+			dmah->valid_fields & BIT(IB_DMAH_DIRECT_ST_VAL_EXISTS))
 			st_index =3D mdmah->st_index;
 	}
=20
@@ -1660,7 +1661,8 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device =
*dma_device,
 		struct mlx5_ib_dmah *mdmah =3D to_mdmah(dmah);
=20
 		ph =3D dmah->ph;
-		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
+		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS) ||
+			dmah->valid_fields & BIT(IB_DMAH_DIRECT_ST_VAL_EXISTS))
 			st_index =3D mdmah->st_index;
 	}
=20
--=20
2.47.3


