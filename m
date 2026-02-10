Return-Path: <linux-rdma+bounces-16739-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBB7G2OLi2mkVwAAu9opvQ
	(envelope-from <linux-rdma+bounces-16739-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 20:47:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8E411ECA6
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 20:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8822304D929
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 19:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6101932693E;
	Tue, 10 Feb 2026 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="e+1BrbQE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1934C148850
	for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770752858; cv=none; b=mDVLWT7YdXuF30a0jkCUsx6xEp30HE1x/c9TSui3oAepQggJbcIIbZgyZTbAiNxIxGPOX6jmNJLKownySV5bkoPYEV9hXP11JgMVtEJfsxRxDeaf1/vPFk7TMX41P8Pd8OSMxovuO7ihaqufMVB9EEIea9s52tMqLEGuHZLGooM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770752858; c=relaxed/simple;
	bh=Zy44/LIpSi3+agiLDUKcDMJV1qfWV/Mh2KHyfM8qNUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TyxdEABzVGrf+A0LMp9r7dRTnl2cOxQgLPagT0GkXyopIGWrxdq7X7LByGMcrTEIwggz5/BSzwksjZYotsdHzT7cjDGM0uC9wd5rOaBKdM9XimV+NoP6/pebWgCEBYTA3S/Hi/iM4t/fEv8E3kNjwzbnDcXP0Az9cKrWiKlbU8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=e+1BrbQE; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AH2JQ43309727
	for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 11:47:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=POD6O1akvG97jkADnL5riRKuih17v4b7P7apRIwKvXg=; b=e+1BrbQEKn4p
	+nxrVKU91fkzolnJY7veJA/CMebQB+CtL30K3XQ2x21O39oodqDWLGmiPQmt5N+S
	5CpQsdAnIRvjJq0Vtp6z4ocoOJ2TB4xq5N4JH96dwMpQwkYr7eLxd02EsUtfhcKC
	eyIpt8UtZ1VSOGgRy6W4p+IdEHE8jgkthU/O6VP3mmdbS+gYQPKj0XG7pDGvwuMM
	kM5k2kEmmqjTDQPuOGChaUJHi8LhJC3HdNeUnP/GGD290ncImwrxbaafydX+2BZO
	mQTh88utZh++8VUbANF0v8lAXWkEB+msRHvEc/0jbNs1JHsu9Y1wTWOPm7fKrKmN
	5IaxLgz72Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c88qnjd9q-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 11:47:36 -0800 (PST)
Received: from twshared13080.31.frc3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 10 Feb 2026 19:47:33 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id C69F5102666F6; Tue, 10 Feb 2026 11:40:20 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn
 Helgaas <bhelgaas@google.com>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, Keith Busch <kbusch@kernel.org>,
        Yochai
 Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Zhiping Zhang <zhipingz@meta.com>
Subject: [RFC 2/2] RMDA MLX5: get tph for p2p access when registering dmabuf mr
Date: Tue, 10 Feb 2026 11:39:55 -0800
Message-ID: <20260210194014.2147481-3-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210194014.2147481-1-zhipingz@meta.com>
References: <20260210194014.2147481-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE2MyBTYWx0ZWRfX5FXMG50Zm9ep
 a+MpSHU+3tmSXj5LP/NJB9Mmq4vXK1I3OVq83Kqu5VIRbJhzeyrP61+wg5J5gf+0lhTdxmDTvM+
 nNOjbucf29r7ad6HyI+svl54kYaKByZalKVXIUvqvRHPN5Gt7HO/031UzT8n/U5ygeQKRp0RjG8
 TAfD0gWN6b2oZcyFfAghDiOdDvFgp/kNsBjN5L3p6GHf7yqn0Cx+V15j5pHzC8xQezirKyWJ4IL
 tWxDsOlNm9pTEcRp5eYSqNfZWHWQTkK5rtH0H7usS6deltS/6LNajF32KCLr/ryoxAkfN0ib5Ab
 knfgWVlvUlQdsOHws7g9jjug0MIUDf6yyAo98yMMkI420KToMkIuElENK9CFJEKuy5yZ6QnTtXs
 4A+Eytn6xiyk727hozuqvsaOWftNGpq/0HQZoPbbkkIphEe26csFp9A/NLjphuVYOsoUPXPvF5F
 l+RSflBmSK1GnNjRX6w==
X-Authority-Analysis: v=2.4 cv=POkCOPqC c=1 sm=1 tr=0 ts=698b8b58 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VabnemYjAAAA:8 a=tOZ8yR1yUuKf9aCP_icA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: SDLE3epd3BPg3F-ZRbmiBOsSb59LaGs6
X-Proofpoint-GUID: SDLE3epd3BPg3F-ZRbmiBOsSb59LaGs6
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16739-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim,meta.com:email];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1D8E411ECA6
X-Rspamd-Action: no action

The patch adds a local function to check and get tph info when available =
during
dmabuf mr registration. Note the DMAH workflow for CPU still takes preced=
ence in
the process. Currently, it only works with the direct st_mode. Compatibil=
ity
with other st_modes will be added in the formal patch set.

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
+
+	dmabuf =3D dma_buf_get(fd);
+	if (IS_ERR(dmabuf))
+		return;
+
+	if (!dmabuf->ops->get_tph)
+		goto end_dbuf_put;
+
+	ret =3D dmabuf->ops->get_tph(dmabuf, st_index, ph);
+
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


