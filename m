Return-Path: <linux-rdma+bounces-14476-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13162C5A36B
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 22:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDFF04FA8D5
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 21:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B145325719;
	Thu, 13 Nov 2025 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cMSuZA0s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FBD3254B1
	for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069852; cv=none; b=rXfmSJiateCU0SfdOINuBDNlxw8kQe3VkhoryYbPRLpx/aavYopJHLsUwtkouEyN5MQ7iAWQgY2CHcmTSmKNOQTyVQJ6QMLVKodEPEkSyLs0tU9K/28n+MaCG1ZMTUJrGmhHchbCQDS9bYOKuVWHFFvjMU12+2JSK3Z4nP3u/kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069852; c=relaxed/simple;
	bh=loya69d44IXJE8PQNMTjsG1xLUDERsBNLOxHzJIdCZs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ReOY2sR6ZViEGTOS6iu6x+ynBSszLMD6pHN9zBLQ46UbkVsxbVzR77K5ENfaOViEXr1mwY9XFXyuBoKjR65FXWeBE9KoeJIK3lDhgJndHFVkncwqlEC2A3Iys13hu75ZZWYec3fc4ZHjMop63pJcPLDT0QoXnxyKMiiFFwfzPns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cMSuZA0s; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 5ADH2Beo1169281
	for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 13:37:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=KO/2lK+ix1ILurlwUSKAZUnm1vmTuIBscsF+lma1CUk=; b=cMSuZA0s/DUh
	hOR03/8MGADHbxTINO2cMdgktNNm4V7qFuHaF+nB+1/Jdmh9lIhiqRNK3nNvAi4g
	iy0PtfjYy9RQHrfWMg6iOUKMLIgbtp7HsjpdEpnR+XpvL/ZKeHtuD/Unl1CXCXpe
	3mnhaJUrVYTRooD4qN3yk23v/G8OZlaa25lct8YwS7GdtQs6d30oIUM6t4OYigzN
	0V2aF62/Cbjnbk8BUycqv7AU7b2sIXE2r7RS6WBkfz5putdOxgsjlaQfVqvCDEYg
	cDTD7xCdTgQsJ3n2xDu4UC9T3pIF4LwJ27Qqa3Upu6Ik/Zqw/pc3Ka4d+OQBkGOY
	Yom0g0j+sw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4adjjru647-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 13:37:29 -0800 (PST)
Received: from twshared12874.03.snb2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Thu, 13 Nov 2025 21:37:27 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 0C77FC14674C; Thu, 13 Nov 2025 13:37:15 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn
 Helgaas <bhelgaas@google.com>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
        Keith Busch
	<kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas
	<yishaih@nvidia.com>
CC: Zhiping Zhang <zhipingz@meta.com>
Subject: [RFC 2/2] Set steering-tag directly for PCIe P2P memory access
Date: Thu, 13 Nov 2025 13:37:12 -0800
Message-ID: <20251113213712.776234-3-zhipingz@meta.com>
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
X-Authority-Analysis: v=2.4 cv=U4WfzOru c=1 sm=1 tr=0 ts=69164f9a cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8
 a=e89EMESlmW-4XGx9FsgA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE2OSBTYWx0ZWRfX5m/9+SYGI+jY
 /WfSwrcrSxcjFV2UoDbZpymVicS2dJqMF+6OQTXWV3gZiNX19zkX84JEzrCtwBY0P++cQ6AMuFt
 1X5l5/vuX1QC8XsiGhYPy9/LnHmKrBf7rIEDjiPdaQSftGPWmwTs92pWFUMWAexSPSFtEbtuThs
 F1qCLQi+DF9ZXceVLlvNJTgXfcneJLL3ZQLUhjogI5FHUxrH0yGrrd6BZ1NkZDrTUMCZ/HxmA1V
 qqPI6AU9D59yCuWWzcyBA2zJR9B32TA7uXd7z6MeM+AkOXvqUhdPRnIPT9YXxlnoYdhBLdrlGf7
 TOyLznyN6EBzCeRGcoPTDXNIfqArN+lyfmEVzN41r9GtMK4ODsb3nHTzMs1oOM2pPIHjZcx/Hb0
 jTVR4ylZ2uCbQwJsEXxhRcD7yFBeEQ==
X-Proofpoint-ORIG-GUID: h-98YK2KZbC_WeI9FNEIOSG7QwS5LfoO
X-Proofpoint-GUID: h-98YK2KZbC_WeI9FNEIOSG7QwS5LfoO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_05,2025-11-13_02,2025-10-01_01

RDMA: Set steering-tag value directly in DMAH struct for DMABUF MR

This patch enables construction of a dma handler (DMAH) with the P2P memo=
ry type
and a direct steering-tag value. It can be used to register a RDMA memory
region with DMABUF for the RDMA NIC to access the other device's memory v=
ia P2P.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 .../infiniband/core/uverbs_std_types_dmah.c   | 28 +++++++++++++++++++
 drivers/infiniband/core/uverbs_std_types_mr.c |  3 ++
 drivers/infiniband/hw/mlx5/dmah.c             |  5 ++--
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 12 +++++---
 include/linux/mlx5/driver.h                   |  4 +--
 include/rdma/ib_verbs.h                       |  2 ++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  1 +
 7 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_dmah.c b/drivers/in=
finiband/core/uverbs_std_types_dmah.c
index 453ce656c6f2..1ef400f96965 100644
--- a/drivers/infiniband/core/uverbs_std_types_dmah.c
+++ b/drivers/infiniband/core/uverbs_std_types_dmah.c
@@ -61,6 +61,27 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DMAH_ALLOC)(
 		dmah->valid_fields |=3D BIT(IB_DMAH_MEM_TYPE_EXISTS);
 	}
=20
+	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_ALLOC_DMAH_DIRECT_ST_VAL)) =
{
+		ret =3D uverbs_copy_from(&dmah->direct_st_val, attrs,
+				       UVERBS_ATTR_ALLOC_DMAH_DIRECT_ST_VAL);
+		if (ret)
+			goto err;
+
+		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS)) {
+			ret =3D -EINVAL;
+			goto err;
+		}
+		if ((dmah->valid_fields & BIT(IB_DMAH_MEM_TYPE_EXISTS)) =3D=3D 0) {
+			ret =3D -EINVAL;
+			goto err;
+		}
+		if (dmah->mem_type !=3D TPH_MEM_TYPE_P2P) {
+			ret =3D -EINVAL;
+			goto err;
+		}
+		dmah->valid_fields |=3D BIT(IB_DMAH_DIRECT_ST_VAL_EXISTS);
+	}
+
 	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_ALLOC_DMAH_PH)) {
 		ret =3D uverbs_copy_from(&dmah->ph, attrs,
 				       UVERBS_ATTR_ALLOC_DMAH_PH);
@@ -107,6 +128,10 @@ static const struct uverbs_attr_spec uverbs_dmah_mem=
_type[] =3D {
 		.type =3D UVERBS_ATTR_TYPE_PTR_IN,
 		UVERBS_ATTR_NO_DATA(),
 	},
+	[TPH_MEM_TYPE_P2P] =3D {
+		.type =3D UVERBS_ATTR_TYPE_PTR_IN,
+		UVERBS_ATTR_NO_DATA(),
+	},
 };
=20
 DECLARE_UVERBS_NAMED_METHOD(
@@ -123,6 +148,9 @@ DECLARE_UVERBS_NAMED_METHOD(
 			    UA_OPTIONAL),
 	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_ALLOC_DMAH_PH,
 			   UVERBS_ATTR_TYPE(u8),
+			   UA_OPTIONAL),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_ALLOC_DMAH_DIRECT_ST_VAL,
+			   UVERBS_ATTR_TYPE(u16),
 			   UA_OPTIONAL));
=20
 DECLARE_UVERBS_NAMED_METHOD_DESTROY(
diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infi=
niband/core/uverbs_std_types_mr.c
index 570b9656801d..10e47934898e 100644
--- a/drivers/infiniband/core/uverbs_std_types_mr.c
+++ b/drivers/infiniband/core/uverbs_std_types_mr.c
@@ -346,6 +346,9 @@ static int UVERBS_HANDLER(UVERBS_METHOD_REG_MR)(
 					   UVERBS_ATTR_REG_MR_DMA_HANDLE);
 		if (IS_ERR(dmah))
 			return PTR_ERR(dmah);
+		if (dmah->mem_type =3D=3D TPH_MEM_TYPE_P2P && has_fd =3D=3D false) {
+			return -EINVAL;
+		}
 	}
=20
 	ret =3D uverbs_get_flags32(&access_flags, attrs,
diff --git a/drivers/infiniband/hw/mlx5/dmah.c b/drivers/infiniband/hw/ml=
x5/dmah.c
index 362a88992ffa..98c8d3313653 100644
--- a/drivers/infiniband/hw/mlx5/dmah.c
+++ b/drivers/infiniband/hw/mlx5/dmah.c
@@ -15,8 +15,7 @@ static int mlx5_ib_alloc_dmah(struct ib_dmah *ibdmah,
 {
 	struct mlx5_core_dev *mdev =3D to_mdev(ibdmah->device)->mdev;
 	struct mlx5_ib_dmah *dmah =3D to_mdmah(ibdmah);
-	u16 st_bits =3D BIT(IB_DMAH_CPU_ID_EXISTS) |
-		      BIT(IB_DMAH_MEM_TYPE_EXISTS);
+	u16 st_bits =3D BIT(IB_DMAH_MEM_TYPE_EXISTS);
 	int err;
=20
 	/* PH is a must for TPH following PCIe spec 6.2-1.0 */
@@ -28,7 +27,7 @@ static int mlx5_ib_alloc_dmah(struct ib_dmah *ibdmah,
 		if ((ibdmah->valid_fields & st_bits) !=3D st_bits)
 			return -EINVAL;
 		err =3D mlx5_st_alloc_index(mdev, ibdmah->mem_type,
-					  ibdmah->cpu_id, &dmah->st_index);
+					  ibdmah->cpu_id, &dmah->st_index, ibdmah->direct_st_val);
 		if (err)
 			return err;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/lib/st.c
index 47fe215f66bf..690ad8536128 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
@@ -80,7 +80,7 @@ void mlx5_st_destroy(struct mlx5_core_dev *dev)
 }
=20
 int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem=
_type,
-			unsigned int cpu_uid, u16 *st_index)
+			unsigned int cpu_uid, u16 *st_index, u16 direct_st_val)
 {
 	struct mlx5_st_idx_data *idx_data;
 	struct mlx5_st *st =3D dev->st;
@@ -92,9 +92,13 @@ int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enu=
m tph_mem_type mem_type,
 	if (!st)
 		return -EOPNOTSUPP;
=20
-	ret =3D pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
-	if (ret)
-		return ret;
+	if (mem_type =3D=3D TPH_MEM_TYPE_P2P)
+		tag =3D direct_st_val;
+	else {
+		ret =3D pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
+		if (ret)
+			return ret;
+	}
=20
 	mutex_lock(&st->lock);
=20
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 1c8ba601e760..a58be1f2844b 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1170,12 +1170,12 @@ int mlx5_dm_sw_icm_dealloc(struct mlx5_core_dev *=
dev, enum mlx5_sw_icm_type type
=20
 #ifdef CONFIG_PCIE_TPH
 int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem=
_type,
-			unsigned int cpu_uid, u16 *st_index);
+			unsigned int cpu_uid, u16 *st_index, u16 direct_st_val);
 int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index);
 #else
 static inline int mlx5_st_alloc_index(struct mlx5_core_dev *dev,
 				      enum tph_mem_type mem_type,
-				      unsigned int cpu_uid, u16 *st_index)
+				      unsigned int cpu_uid, u16 *st_index, u16 direct_st_val)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 465b73d94f33..30a26b524f03 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1852,6 +1852,7 @@ enum {
 	IB_DMAH_CPU_ID_EXISTS,
 	IB_DMAH_MEM_TYPE_EXISTS,
 	IB_DMAH_PH_EXISTS,
+	IB_DMAH_DIRECT_ST_VAL_EXISTS,
 };
=20
 struct ib_dmah {
@@ -1866,6 +1867,7 @@ struct ib_dmah {
 	atomic_t usecnt;
 	u8 ph;
 	u8 valid_fields; /* use IB_DMAH_XXX_EXISTS */
+	u16 direct_st_val;
 };
=20
 struct ib_mr {
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/i=
b_user_ioctl_cmds.h
index 17f963014eca..42b3892b6761 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -242,6 +242,7 @@ enum uverbs_attrs_alloc_dmah_cmd_attr_ids {
 	UVERBS_ATTR_ALLOC_DMAH_CPU_ID,
 	UVERBS_ATTR_ALLOC_DMAH_TPH_MEM_TYPE,
 	UVERBS_ATTR_ALLOC_DMAH_PH,
+	UVERBS_ATTR_ALLOC_DMAH_DIRECT_ST_VAL,
 };
=20
 enum uverbs_attrs_free_dmah_cmd_attr_ids {
--=20
2.47.3


