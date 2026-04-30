Return-Path: <linux-rdma+bounces-19798-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDFvJHm382mW6QEAu9opvQ
	(envelope-from <linux-rdma+bounces-19798-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 22:11:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7D94A79AE
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 22:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7C8B3012CAA
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 20:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A313538BF78;
	Thu, 30 Apr 2026 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="LPX2prnm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C623438A70A
	for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2026 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777579894; cv=none; b=Rq+sjPU6D1fkaVZW78av6KLzPIR07sMLj3lhgqb85lmM04Lc1PJSXCADhGvkTLq8sUkyrUaog1wKsAXNJ8ogtO8qwzvSXRH743+6F/eukBwh9hWz1uhRj4sjZHXKw8lRkUHOO5AsrhIAB3b7z50mkhu7XBCY1RCt1j+u6bydAGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777579894; c=relaxed/simple;
	bh=sEG6CpnajCwXTPpn070f/c13Ycchdthsl607A9hP6cs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=futReqrYZlfUcCsIYbuqRtnMl7sRhpADAmsjcnOaml7o0zvKonrxKVT/AzdQklnYp5F02KE+FvZ3vuQscKPINw8y+3CdsIlnFuDVQz/0XnQjP5zxQGV942zXRkp7hpxl5TqMJlqYFIhXDPK/YrRBK3cy6iNdBpvL84IGgKsc9r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=LPX2prnm; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UDB4Gt3246242
	for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2026 13:11:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=+CctzKmPD0mZYNaUqqbHQ9y/m7DXh0Zn+N73X9LhqfM=; b=LPX2prnm7kxp
	sIUSSBr8vUmzakv5GIA35ijPUajL0sKIpyMQ4PoTOjGkjbD1YTraAKUYHR9Ak4QJ
	kSdHd1hzQRl3NvJ8yF7+ZFZc1wod9xeyoZ+DA4uPKkYXT3DkpIfkz4gwJQBi2h1M
	fWQzHcjEC+LQZScAO2372RTrJyb09azlMcPE2g1UuXIGh806pxdtvoMbl6CKbS90
	NCwU3Umy+mdrQAkHrgu6/+/8BhQ+9D1JVW/4l+DJ4Ssn+RMMWYYNplputHuvISQ+
	QdkbFezdlY+SP+IioU6KUtyhT577zdO/5LGtHBxkriel60LP24iY6508GSiqmcpO
	eD7dCFVakQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4drua3ve34-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2026 13:11:32 -0700 (PDT)
Received: from twshared6963.04.snb3.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Thu, 30 Apr 2026 20:11:27 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 843451B9B4FD1; Thu, 30 Apr 2026 13:07:06 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon
 Romanovsky <leon@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, Keith Busch <kbusch@kernel.org>,
        Yochai
 Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
        Zhiping Zhang
	<zhipingz@meta.com>
Subject: [PATCH v2 2/2] RDMA/mlx5: get tph for p2p access when registering dma-buf mr
Date: Thu, 30 Apr 2026 13:06:57 -0700
Message-ID: <20260430200704.352228-3-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260430200704.352228-1-zhipingz@meta.com>
References: <20260430200704.352228-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: X0kVqJ3xkAKyWU-vetfQA0qrBySsiKH9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIwOCBTYWx0ZWRfXxX4boRjDvzvJ
 6koE8KLYyDNFAGmq9sqIIMDfRUxa+a9LTbQYboDCn3R6x+Ia9lWo9O1+QXABkBzRxwP8wLLPRki
 QtdMvmbI09N2PTh3/4j7s6zb31xTZP8j7RtKw7YBQgM3dIlg6942xzpnFfC80p8kE0Yeu9bFMya
 cW5OOtSdu3Qn6hSmbFO2KJUFitWVro/zF8rVAu9sdy4++fzVrVEk1FbWL5kN4sS9US+JbPZzLPO
 vd1YL0qiwlJaDnBxkRgrW4EEVL4u3NCHGBb6oz/kCFMGhkMtys+ctpAsibw3uhBW+pMjNroQf2I
 QELLXkxe+n/2e+EA5MKm8eTWd7FodsFvcXJnOHAOfSTuuIeI/BTRUVD3kUT094xUlr6k0nRUE6e
 x2EzGPMBiMK41R+wNa3q3gV/LwFMyGUOZk1Ctb6O3ER4rYQOa6nXmqkA+tfhRCqc+kbQNdayFqD
 dyA7ltpQn3Na1rP3E7g==
X-Proofpoint-ORIG-GUID: X0kVqJ3xkAKyWU-vetfQA0qrBySsiKH9
X-Authority-Analysis: v=2.4 cv=UYphjqSN c=1 sm=1 tr=0 ts=69f3b774 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VabnemYjAAAA:8 a=c4au4WjlRKfxtgWlyl4A:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_05,2026-04-30_02,2025-10-01_01
X-Rspamd-Queue-Id: 4F7D94A79AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19798-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:dkim,meta.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]

Query dma-buf TPH metadata when registering a dma-buf MR for peer to
peer access and translate the raw steering tag into an mlx5 steering tag
index. Factor mlx5_st_alloc_index() so callers that already have a raw
steering tag can allocate the corresponding mlx5 index directly. Keep the
DMAH path as the first priority and only fall back to dma-buf metadata wh=
en
no DMAH is supplied.

Pass the device's supported ST width (8 or 16 bit, derived from
pdev->tph_req_type) to get_tph() so the exporter can reject tags that
exceed the consumer's capability. Initialize ret in mlx5_st_create() so t=
he
cached steering-tag path returns success cleanly under clang builds.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -46,6 +46,8 @@
 #include "data_direct.h"
 #include "dmah.h"
=20
+MODULE_IMPORT_NS("DMA_BUF");
+
 static int mkey_max_umr_order(struct mlx5_ib_dev *dev)
 {
 	if (MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
@@ -899,6 +901,40 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_atta=
ch_ops =3D {
 	.invalidate_mappings =3D mlx5_ib_dmabuf_invalidate_cb,
 };
=20
+static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, int fd, u16 *st_i=
ndex,
+			      u8 *ph)
+{
+	struct pci_dev *pdev =3D dev->mdev->pdev;
+	struct dma_buf *dmabuf;
+	u16 steering_tag;
+	u8 st_width;
+	int ret;
+
+	st_width =3D (pdev->tph_req_type =3D=3D PCI_TPH_REQ_EXT_TPH) ? 16 : 8;
+
+	dmabuf =3D dma_buf_get(fd);
+	if (IS_ERR(dmabuf))
+		return;
+
+	if (!dmabuf->ops->get_tph)
+		goto end_dbuf_put;
+
+	ret =3D dmabuf->ops->get_tph(dmabuf, &steering_tag, ph, st_width);
+	if (ret) {
+		mlx5_ib_dbg(dev, "get_tph failed (%d)\n", ret);
+		goto end_dbuf_put;
+	}
+
+	ret =3D mlx5_st_alloc_index_by_tag(dev->mdev, steering_tag, st_index);
+	if (ret) {
+		*ph =3D MLX5_IB_NO_PH;
+		mlx5_ib_dbg(dev, "st_alloc_index_by_tag failed (%d)\n", ret);
+	}
+
+end_dbuf_put:
+	dma_buf_put(dmabuf);
+}
+
 static struct ib_mr *
 reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
 		   u64 offset, u64 length, u64 virt_addr,
@@ -941,6 +977,8 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device *d=
ma_device,
 		ph =3D dmah->ph;
 		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
 			st_index =3D mdmah->st_index;
+	} else {
+		get_tph_mr_dmabuf(dev, fd, &st_index, &ph);
 	}
=20
 	mr =3D alloc_cacheable_mr(pd, &umem_dmabuf->umem, virt_addr,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/lib/st.c
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
@@ -29,7 +29,7 @@ struct mlx5_st *mlx5_st_create(struct mlx5_core_dev *de=
v)
 	u8 direct_mode =3D 0;
 	u16 num_entries;
 	u32 tbl_loc;
-	int ret;
+	int ret =3D 0;
=20
 	if (!MLX5_CAP_GEN(dev, mkey_pcie_tph))
 		return NULL;
@@ -92,23 +92,18 @@ void mlx5_st_destroy(struct mlx5_core_dev *dev)
 	kfree(st);
 }
=20
-int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem=
_type,
-			unsigned int cpu_uid, u16 *st_index)
+int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev, u16 tag,
+			       u16 *st_index)
 {
 	struct mlx5_st_idx_data *idx_data;
 	struct mlx5_st *st =3D dev->st;
 	unsigned long index;
 	u32 xa_id;
-	u16 tag;
-	int ret;
+	int ret =3D 0;
=20
 	if (!st)
 		return -EOPNOTSUPP;
=20
-	ret =3D pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
-	if (ret)
-		return ret;
-
 	if (st->direct_mode) {
 		*st_index =3D tag;
 		return 0;
@@ -152,6 +147,20 @@ int mlx5_st_alloc_index(struct mlx5_core_dev *dev, e=
num tph_mem_type mem_type,
 	mutex_unlock(&st->lock);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mlx5_st_alloc_index_by_tag);
+
+int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem=
_type,
+			unsigned int cpu_uid, u16 *st_index)
+{
+	u16 tag;
+	int ret;
+
+	ret =3D pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
+	if (ret)
+		return ret;
+
+	return mlx5_st_alloc_index_by_tag(dev, tag, st_index);
+}
 EXPORT_SYMBOL_GPL(mlx5_st_alloc_index);
=20
 int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1166,10 +1166,17 @@ int mlx5_dm_sw_icm_dealloc(struct mlx5_core_dev *=
dev, enum mlx5_sw_icm_type type
 			   u64 length, u16 uid, phys_addr_t addr, u32 obj_id);
=20
 #ifdef CONFIG_PCIE_TPH
+int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev, u16 tag,
+			       u16 *st_index);
 int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem=
_type,
 			unsigned int cpu_uid, u16 *st_index);
 int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index);
 #else
+static inline int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev,
+					     u16 tag, u16 *st_index)
+{
+	return -EOPNOTSUPP;
+}
 static inline int mlx5_st_alloc_index(struct mlx5_core_dev *dev,
 				      enum tph_mem_type mem_type,
 				      unsigned int cpu_uid, u16 *st_index)

