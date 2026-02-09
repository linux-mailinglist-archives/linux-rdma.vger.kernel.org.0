Return-Path: <linux-rdma+bounces-16689-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFdSFsgfimnLHQAAu9opvQ
	(envelope-from <linux-rdma+bounces-16689-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Feb 2026 18:56:24 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3970113475
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Feb 2026 18:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A78E9302962D
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Feb 2026 17:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D155F314D2F;
	Mon,  9 Feb 2026 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cGnT0mkM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7009F3803ED
	for <linux-rdma@vger.kernel.org>; Mon,  9 Feb 2026 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770659753; cv=none; b=llgsynzSQWFIe5+iqnK0LtW/wOgHJ0u5QW4LrCzUoHY7y/tWyV752fumFa1GNzM8j1LxCKULgubYmGoMj/K0deCbRa5j1v/wzOb1nBYd9IoYaxx51PMWbTgTyjA0x736g3vhWGQMiM04ZUOpiExCZH3lf/wpdQsghhgs0tjYLHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770659753; c=relaxed/simple;
	bh=r8dHtmr7XkLs5zrX+fWH/e/Ev+/xaGbxbjTk8UBoH9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ni2U90MTmyTVfHRWfEnerRqqmRXRDl2/9rn3DKnEwJfavsiHhnTDS8l37ncD28Q5kCqbn4PiTupBy2uEwzSHrEy0VD/aWBCBZWs5d8KWWW9EGmixjBy8h1oKKPW2hlURneDiW/YY9VZzGC+IMImbrbqGECRvB5X/L9QpYLXGBfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cGnT0mkM; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619H8FX3951966
	for <linux-rdma@vger.kernel.org>; Mon, 9 Feb 2026 09:55:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=oHoiNKIypFbd1xk38f8sYTCN3qwAX1/eZnwAo4QjQEc=; b=cGnT0mkMA/sb
	uhciBRHevOTVw0VjJBMabZsSRL0Z/P5fLnNx/u3kFruDyyVqFUFWUWEv3e6YkhwN
	Z8WOenMM8H0uFNeESpuMEYo+imnuc3G00emBep85inmTNqDXP8m2PTSaBt7iCeaW
	awIxBjCZoiwAAt7NC7G4U0PLHWiPBUUe6FIQZS/7X9ezCpTRJHx5qIJ2upIz4SPu
	IKGoE07SRmK1Gei/HgbeiKkQagYOKgGmPowoVY5W7jy0/Q6LLvzLf0y4oKn1szNM
	2sWgxX1l/KCqLBHUOKHCeJGlNS8oIcdFgYP+Fiqqq6qrazvloUmY8lhv4Aob+SzZ
	98Sitlna9g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c7f1wm5dg-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Mon, 09 Feb 2026 09:55:52 -0800 (PST)
Received: from twshared25002.15.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 9 Feb 2026 17:55:43 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 2328A100D0428; Mon,  9 Feb 2026 09:53:20 -0800 (PST)
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
Subject: [RFC 2/2] RMDA MLX5: get tph for p2p access when registering dmabuf mr
Date: Mon, 9 Feb 2026 09:53:12 -0800
Message-ID: <20260209175317.1713406-3-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260209175317.1713406-1-zhipingz@meta.com>
References: <20260209175317.1713406-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=OMcqHCaB c=1 sm=1 tr=0 ts=698a1fa8 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VabnemYjAAAA:8 a=tOZ8yR1yUuKf9aCP_icA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: bs8Nf5NmnzTIo7KTGpxCpvX1TH9FiG1_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE1MSBTYWx0ZWRfX+8AgYxFphQH+
 IJ1qUJyhzABBdPw7ELZlozmqad58FWbZBJb1TxX82p9tVi0HGpbMPfwa51du7S5vAlsXafUdvQy
 Fiho/xmwAuofunoOVwCrDOtxs1P8hHK1c6xVJfXMQ3oxrNKTVD1YNyrBlhP5ozvsjZthkLsUxF/
 fZYlVGCeikIpm4t2Q7G+kRlKtgECokuUHCQv3ORE6A9KK6BGXs/iU4y/NpjZAXDJh1alStTOKxn
 Wl1LmqtoKlVCgVdAOLLCA/x9IhCV67QW9rmj1QLjESeepNdk+Wq4WRRyLbMzzG64fiGEZD73Tff
 Qqql+MGMZH+gDhILQwDdUu38IirvlXBLnJZphVe6qJYDh4a1JrmNX8r083c8+LVEe9h7m4mq3w9
 Vv2Q2a1OIZRmj84zXKIMoxNlNMcWpa8F98/KhUtNvlNsmle7NHgGZAiPoAT6dqf2QW3cZKHMvxZ
 /F/fhtczAEoz23A/K0w==
X-Proofpoint-GUID: bs8Nf5NmnzTIo7KTGpxCpvX1TH9FiG1_
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
	TAGGED_FROM(0.00)[bounces-16689-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: E3970113475
X-Rspamd-Action: no action

The patch adds a local function to check and get tph info when available =
during
dmabuf mr registration. Note the DMAH workflow for CPU still takes preced=
ence in
the process. Currently, it only works with the direct st_mode. Compatibil=
ity
with other st_modes will be added in the forma patch set.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
index 325fa04cbe8a..c3eb5b24ef29 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -46,6 +46,8 @@
 #include "data_direct.h"
 #include "dmah.h"
=20
+MODULE_IMPORT_NS("DMA_BUF");
+
 enum {
 	MAX_PENDING_REG_MR =3D 8,
 };
@@ -1623,6 +1625,32 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_at=
tach_ops =3D {
 	.move_notify =3D mlx5_ib_dmabuf_invalidate_cb,
 };
=20
+static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, int fd, u16 *st_i=
ndex,
+							  u8 *ph)
+{
+	int ret;
+	struct dma_buf *dmabuf;
+	struct mlx5_core_dev *mdev =3D dev->mdev;
+
+	dmabuf =3D dma_buf_get(fd);
+	if (IS_ERR(dmabuf))
+		return;
+
+	if (!dmabuf->ops->get_tph)
+		goto end_dbuf_put;
+
+	ret =3D dmabuf->ops->get_tph(dmabuf, st_index, ph);
+	if (ret) {
+		*st_index =3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX;
+		*ph =3D MLX5_IB_NO_PH;
+		mlx5_ib_dbg(dev, "get_tph failed (%d)\n", ret);
+		goto end_dbuf_put;
+	}
+
+end_dbuf_put:
+	dma_buf_put(dmabuf);
+};
+
 static struct ib_mr *
 reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
 		   u64 offset, u64 length, u64 virt_addr,
@@ -1662,6 +1690,8 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device =
*dma_device,
 		ph =3D dmah->ph;
 		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
 			st_index =3D mdmah->st_index;
+	} else {
+		get_tph_mr_dmabuf(dev, fd, &st_index, &ph);
 	}
=20
 	mr =3D alloc_cacheable_mr(pd, &umem_dmabuf->umem, virt_addr,
--=20
2.47.3


