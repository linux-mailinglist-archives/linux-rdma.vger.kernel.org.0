Return-Path: <linux-rdma+bounces-22126-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4BtHJ8frKmrNzQMAu9opvQ
	(envelope-from <linux-rdma+bounces-22126-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 19:09:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AD9673DDC
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 19:09:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b="v+/EgHMG";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22126-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22126-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C866304F9C1
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 16:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969AA3E1234;
	Thu, 11 Jun 2026 16:46:13 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993B837DAB5
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 16:46:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196373; cv=none; b=IcJcJ0NUl0+sQh+dx22IFlT4wn5gdDKuWuvWYgP+uHBahA+F8ANcu7s3V/nv1Uhf/BelwfuAJthYAKLYBgRSDD3ZqgBDH6Bt2ZBogsPeQx+8kJ7+7/lSStyVGVHD3d3hxjP6SPlMREgdLJf/PvzG7lCd6r8cJEz5VRP57dZ0ZTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196373; c=relaxed/simple;
	bh=60J/swpt8hSXKkHXnXQ2XH60IYV90l/RAZy8zo4DPfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E1qgSDUGQbcl2aaT2dQVAwWpnLPjjsCg+TSN8kbAjQeajBvsD+D+aPZToZKFSyvBN8SkbIatjNVlYGrUyLtEzpIebLtG/m6NMntUjEeglvtMgWNv60UKYU9Z1jpIcTHogaYxvLMDF4ElnwbhasrqwWOZG4OUCqErGtP1YIfFqTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=v+/EgHMG; arc=none smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BEO71r1446923
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 09:46:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=OKtfjeKUos+le6rbGwLhae2ZwdVWKZcx+SvDveSqOBo=; b=v+/EgHMGpOA8
	OsP8MSJ/tgP54IawW8YER2C0nKCdDEHHJJxkm3VlG2cdLI/Fr5bjXxULnXjbxwhR
	8xeI9izSLO12Pr6MQQA5ckFyJcgkZQ+zdCpmlFqV9reOiy47Y+klzscEyup3t74I
	vGY+pxGjpONqQTAsy3oLtv9+s2i9HUX6+0Bs+0lSnAGSYYZxkAtdKX0CffwTBBDW
	Nj+WB4Nob6iA3F+dJEaCqVgpJTtY/eWDZhR7u5nC/Sk8ntusIyyfWuqNIcaHk5C4
	AIYGFkt3Uh8pKAUU92GhTbjWEGcyxRiSaC/4UQ8RiDw0S2HJND7vNFoAE2L0eMpm
	QO0NKOVqAQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe78essv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 09:46:10 -0700 (PDT)
Received: from twshared8664.02.snb3.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Thu, 11 Jun 2026 16:46:09 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 26C313DD37764; Thu, 11 Jun 2026 09:23:48 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: <netdev@vger.kernel.org>
CC: <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Zhiping Zhang
	<zhipingz@meta.com>
Subject: [PATCH v7 5/5] RDMA/mlx5: get tph for p2p access when registering dma-buf mr
Date: Thu, 11 Jun 2026 09:11:20 -0700
Message-ID: <20260611161546.4075580-6-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260611161546.4075580-1-zhipingz@meta.com>
References: <20260611161546.4075580-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: WHOVVj5wS5Qrv74RmFBdNh7w_N_xs3FL
X-Proofpoint-GUID: WHOVVj5wS5Qrv74RmFBdNh7w_N_xs3FL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE2OCBTYWx0ZWRfX6suVY5Vw9BfG
 hyT9FVxbIN5EigKtm5dG2bO7H2rk3Qz/r9gdjs6SDMuQcZU8uYvJxdQGnd0AxW8FyG1aOeCebwp
 Uc6zVtByGXV1mknoozNLoz2TNuw2kZmR792Zyj3qk3AgW9DP4AFps/rz5zcHIwxSv2QmDpZ4b0Q
 DesPmoXIc4VFTnhVy69GfVzCTMAW6hG+/2m7oW1Pb7joYOdtoFoB0q/2l2/NNxRWanTaadHMhMm
 Wk0rNYXiCnWl9jQ6FmDbeEbM/x1Hvf+2zveZX7pQKcloJR2oRTE0T7AyQXKM+KIz3UrMptn/fYT
 dQ36W0YY6l9xlQ30NYlhzsyGtLc/SKSsNJqHQp2E/SffPCeU7J7ASxSwPP3qUOoiOyj21ugTnHF
 cXNuFP5a93UdZdu1ooL6Ny8GIGgK15Cj0z5OOO+VsMFNgMfERwJSZZzg+i/lsynmQ9I3F2IbYiT
 Co+XHG01ZrU0gnsnVQw==
X-Authority-Analysis: v=2.4 cv=L98theT8 c=1 sm=1 tr=0 ts=6a2ae652 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VabnemYjAAAA:8 a=Ea2IVqN79ALhG3V46woA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE2OCBTYWx0ZWRfX4Q0JFtkvBzeJ
 G0TCnipuRe6KmZMO9ub1wATmWE2SQH7HB/WafUG6mgHgd/4SGAWp//5NxNQkQY9nzTCURQUHm+N
 7ybDiYHBWMaI4n7rRI2JEgJx5uUPvoQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22126-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:zhipingz@meta.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,meta.com:dkim,meta.com:email,meta.com:mid,meta.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94AD9673DDC

Query dma-buf TPH metadata when registering a dma-buf MR for peer-to-
peer access to a PCIe endpoint and use it to program requester-side TPH
on the outbound mkey. If the exporter has no metadata, fall back to the
existing no-TPH path.

For TPH-backed FRMRs, make the extra ST-table reference belong to the
hardware mkey handle rather than the transient MR object. Extend the
FRMR pool API so reuse and final destroy can transfer and drop that ref
at the handle lifetime boundaries, and add mlx5_st_get_index() to take
a ref on an already-known ST index.

Also decode PH from kernel_vendor_key when recreating pooled mkeys so
the requester hint matches the pool key.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/infiniband/core/frmr_pools.c          |  20 +++-
 drivers/infiniband/hw/mlx5/mr.c               | 111 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  49 ++++++--
 include/linux/mlx5/driver.h                   |  12 ++
 include/rdma/frmr_pools.h                     |   5 +-
 5 files changed, 178 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/co=
re/frmr_pools.c
index 5e992ff3d7cf..61a77847118e 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -92,7 +92,8 @@ static void destroy_all_handles_in_queue(struct ib_devi=
ce *device,
 	u32 count;
=20
 	while (pop_frmr_handles_page(pool, queue, &page, &count)) {
-		pools->pool_ops->destroy_frmrs(device, page->handles, count);
+		pools->pool_ops->destroy_frmrs(device, &pool->key,
+					       page->handles, count);
 		kfree(page);
 	}
 }
@@ -136,7 +137,8 @@ static bool age_pinned_pool(struct ib_device *device,=
 struct ib_frmr_pool *pool)
 	spin_unlock(&pool->lock);
=20
 	if (destroyed)
-		pools->pool_ops->destroy_frmrs(device, handles, destroyed);
+		pools->pool_ops->destroy_frmrs(device, &pool->key, handles,
+					       destroyed);
 	kfree(handles);
 	return has_work;
 }
@@ -453,9 +455,11 @@ int ib_frmr_pools_set_pinned(struct ib_device *devic=
e, struct ib_frmr_key *key,
 }
=20
 static int get_frmr_from_pool(struct ib_device *device,
-			      struct ib_frmr_pool *pool, struct ib_mr *mr)
+			      struct ib_frmr_pool *pool, struct ib_mr *mr,
+			      bool *reused)
 {
 	struct ib_frmr_pools *pools =3D device->frmr_pools;
+	bool local_reused =3D false;
 	u32 handle;
 	int err;
=20
@@ -464,6 +468,7 @@ static int get_frmr_from_pool(struct ib_device *devic=
e,
 		if (pool->inactive_queue.ci > 0) {
 			handle =3D pop_handle_from_queue_locked(
 				&pool->inactive_queue);
+			local_reused =3D true;
 		} else {
 			spin_unlock(&pool->lock);
 			err =3D pools->pool_ops->create_frmrs(device, &pool->key,
@@ -474,6 +479,7 @@ static int get_frmr_from_pool(struct ib_device *devic=
e,
 		}
 	} else {
 		handle =3D pop_handle_from_queue_locked(&pool->queue);
+		local_reused =3D true;
 	}
=20
 	pool->in_use++;
@@ -484,6 +490,8 @@ static int get_frmr_from_pool(struct ib_device *devic=
e,
=20
 	mr->frmr.pool =3D pool;
 	mr->frmr.handle =3D handle;
+	if (reused)
+		*reused =3D local_reused;
=20
 	return 0;
 }
@@ -493,10 +501,12 @@ static int get_frmr_from_pool(struct ib_device *dev=
ice,
  *
  * @device: The device to pop the FRMR handle from.
  * @mr: The MR to pop the FRMR handle from.
+ * @reused: Optional output that reports whether the returned handle was
+ *	    reused from the pool instead of freshly created.
  *
  * Returns 0 on success, negative error code on failure.
  */
-int ib_frmr_pool_pop(struct ib_device *device, struct ib_mr *mr)
+int ib_frmr_pool_pop(struct ib_device *device, struct ib_mr *mr, bool *r=
eused)
 {
 	struct ib_frmr_pools *pools =3D device->frmr_pools;
 	struct ib_frmr_pool *pool;
@@ -509,7 +519,7 @@ int ib_frmr_pool_pop(struct ib_device *device, struct=
 ib_mr *mr)
 			return PTR_ERR(pool);
 	}
=20
-	return get_frmr_from_pool(device, pool, mr);
+	return get_frmr_from_pool(device, pool, mr, reused);
 }
 EXPORT_SYMBOL(ib_frmr_pool_pop);
=20
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
index 3b6da45061a5..5697c2862615 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -38,6 +38,7 @@
 #include <linux/delay.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-resv.h>
+#include <linux/pci-tph.h>
 #include <rdma/frmr_pools.h>
 #include <rdma/ib_umem_odp.h>
 #include "dm.h"
@@ -167,12 +168,39 @@ static int get_unchangeable_access_flags(struct mlx=
5_ib_dev *dev,
 #define MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK 0xFF0000
 #define MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK 0xFFFF
=20
+static int mlx5_ib_get_frmr_st_handle_ref(struct mlx5_ib_dev *dev,
+					  u16 st_index)
+{
+	if (st_index =3D=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
+		return 0;
+
+	return mlx5_st_get_index(dev->mdev, st_index);
+}
+
+static void mlx5_ib_put_st_index_ref(struct mlx5_ib_dev *dev, u16 st_ind=
ex)
+{
+	if (st_index =3D=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
+		return;
+
+	mlx5_st_dealloc_index(dev->mdev, st_index);
+}
+
+static void mlx5_ib_put_frmr_st_handle_ref(struct mlx5_ib_dev *dev,
+					   u64 kernel_vendor_key)
+{
+	u16 st_index =3D kernel_vendor_key &
+		       MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK;
+
+	mlx5_ib_put_st_index_ref(dev, st_index);
+}
+
 static struct mlx5_ib_mr *
 _mlx5_frmr_pool_alloc(struct mlx5_ib_dev *dev, struct ib_umem *umem,
 		      int access_flags, int access_mode,
 		      unsigned long page_size, u16 st_index, u8 ph)
 {
 	struct mlx5_ib_mr *mr;
+	bool reused =3D false;
 	int err;
=20
 	mr =3D kzalloc_obj(*mr);
@@ -195,11 +223,14 @@ _mlx5_frmr_pool_alloc(struct mlx5_ib_dev *dev, stru=
ct ib_umem *umem,
=20
 	mr->ibmr.frmr.key.kernel_vendor_key =3D
 		st_index | (ph << MLX5_FRMR_POOLS_KERNEL_KEY_PH_SHIFT);
-	err =3D ib_frmr_pool_pop(&dev->ib_dev, &mr->ibmr);
+	err =3D ib_frmr_pool_pop(&dev->ib_dev, &mr->ibmr, &reused);
 	if (err) {
 		kfree(mr);
 		return ERR_PTR(err);
 	}
+	if (reused)
+		mlx5_ib_put_frmr_st_handle_ref(
+			dev, mr->ibmr.frmr.key.kernel_vendor_key);
 	mr->mmkey.key =3D mr->ibmr.frmr.handle;
 	init_waitqueue_head(&mr->mmkey.wait);
=20
@@ -229,7 +260,7 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib=
_dev *dev,
 	init_waitqueue_head(&mr->mmkey.wait);
=20
 	mr->ibmr.frmr.key =3D key;
-	ret =3D ib_frmr_pool_pop(&dev->ib_dev, &mr->ibmr);
+	ret =3D ib_frmr_pool_pop(&dev->ib_dev, &mr->ibmr, NULL);
 	if (ret) {
 		kfree(mr);
 		return ERR_PTR(ret);
@@ -273,7 +304,8 @@ static int mlx5r_create_mkeys(struct ib_device *devic=
e, struct ib_frmr_key *key,
=20
 	st_index =3D key->kernel_vendor_key &
 		   MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK;
-	ph =3D key->kernel_vendor_key & MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK;
+	ph =3D (key->kernel_vendor_key & MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK) >>
+	     MLX5_FRMR_POOLS_KERNEL_KEY_PH_SHIFT;
 	if (ph) {
 		/* Normalize ph: swap MLX5_IB_NO_PH for 0 */
 		if (ph =3D=3D MLX5_IB_NO_PH)
@@ -299,7 +331,8 @@ static int mlx5r_create_mkeys(struct ib_device *devic=
e, struct ib_frmr_key *key,
 	return err;
 }
=20
-static void mlx5r_destroy_mkeys(struct ib_device *device, u32 *handles,
+static void mlx5r_destroy_mkeys(struct ib_device *device,
+				const struct ib_frmr_key *key, u32 *handles,
 				unsigned int count)
 {
 	struct mlx5_ib_dev *dev =3D to_mdev(device);
@@ -311,6 +344,9 @@ static void mlx5r_destroy_mkeys(struct ib_device *dev=
ice, u32 *handles,
 			pr_warn_ratelimited(
 				"mlx5_ib: failed to destroy mkey %d: %d",
 				handles[i], err);
+		else
+			mlx5_ib_put_frmr_st_handle_ref(dev,
+						       key->kernel_vendor_key);
 	}
 }
=20
@@ -333,6 +369,7 @@ static int mlx5r_build_frmr_key(struct ib_device *dev=
ice,
 		get_unchangeable_access_flags(dev, in->access_flags);
 	out->vendor_key =3D in->vendor_key;
 	out->num_dma_blocks =3D in->num_dma_blocks;
+	out->kernel_vendor_key =3D in->kernel_vendor_key;
=20
 	return 0;
 }
@@ -753,6 +790,12 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd=
, struct ib_umem *umem,
=20
 	xlt_with_umr =3D mlx5r_umr_can_load_pas(dev, umem->length);
 	if (xlt_with_umr) {
+		err =3D mlx5_ib_get_frmr_st_handle_ref(dev, st_index);
+		if (err) {
+			ib_umem_release(umem);
+			return ERR_PTR(err);
+		}
+
 		mr =3D alloc_cacheable_mr(pd, umem, iova, access_flags,
 					MLX5_MKC_ACCESS_MODE_MTT,
 					st_index, ph);
@@ -767,6 +810,8 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd,=
 struct ib_umem *umem,
 		mutex_unlock(&dev->slow_path_mutex);
 	}
 	if (IS_ERR(mr)) {
+		if (xlt_with_umr)
+			mlx5_ib_put_st_index_ref(dev, st_index);
 		ib_umem_release(umem);
 		return ERR_CAST(mr);
 	}
@@ -899,6 +944,52 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_atta=
ch_ops =3D {
 	.invalidate_mappings =3D mlx5_ib_dmabuf_invalidate_cb,
 };
=20
+static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, struct dma_buf *d=
mabuf,
+			      u16 *st_index, u8 *ph)
+{
+	u16 local_st_index;
+	u16 steering_tag;
+	u8 local_ph;
+	bool extended;
+	int ret;
+
+	switch (pcie_tph_enabled_req_type(dev->mdev->pdev)) {
+	case PCI_TPH_REQ_TPH_ONLY:
+		extended =3D false;
+		break;
+	case PCI_TPH_REQ_EXT_TPH:
+		extended =3D true;
+		break;
+	default:
+		return;
+	}
+
+	dma_resv_lock(dmabuf->resv, NULL);
+	ret =3D dma_buf_get_tph(dmabuf, extended, &steering_tag, &local_ph);
+	dma_resv_unlock(dmabuf->resv);
+	if (ret) {
+		if (ret !=3D -EOPNOTSUPP)
+			mlx5_ib_dbg(dev, "get_tph failed (%d)\n", ret);
+		return;
+	}
+
+	ret =3D mlx5_st_alloc_index_by_tag(dev->mdev, steering_tag,
+					 &local_st_index);
+	if (ret) {
+		mlx5_ib_dbg(dev, "st_alloc_index_by_tag failed (%d)\n", ret);
+		return;
+	}
+
+	*st_index =3D local_st_index;
+	*ph =3D local_ph;
+}
+
+static void mlx5_ib_mr_put_frmr_st_handle_ref(struct mlx5_ib_mr *mr)
+{
+	mlx5_ib_put_frmr_st_handle_ref(mr_to_mdev(mr),
+				       mr->ibmr.frmr.key.kernel_vendor_key);
+}
+
 static struct ib_mr *
 reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
 		   u64 offset, u64 length, u64 virt_addr,
@@ -941,12 +1032,22 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device=
 *dma_device,
 		ph =3D dmah->ph;
 		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
 			st_index =3D mdmah->st_index;
+
+		err =3D mlx5_ib_get_frmr_st_handle_ref(dev, st_index);
+		if (err) {
+			ib_umem_release(&umem_dmabuf->umem);
+			return ERR_PTR(err);
+		}
+	} else {
+		get_tph_mr_dmabuf(dev, umem_dmabuf->attach->dmabuf,
+				  &st_index, &ph);
 	}
=20
 	mr =3D alloc_cacheable_mr(pd, &umem_dmabuf->umem, virt_addr,
 				access_flags, access_mode,
 				st_index, ph);
 	if (IS_ERR(mr)) {
+		mlx5_ib_put_st_index_ref(dev, st_index);
 		ib_umem_release(&umem_dmabuf->umem);
 		return ERR_CAST(mr);
 	}
@@ -1400,6 +1501,8 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_ib=
_mr *mr)
 		dma_resv_unlock(
 			to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv);
 	}
+	if (!ret)
+		mlx5_ib_mr_put_frmr_st_handle_ref(mr);
 	return ret;
 }
=20
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/lib/st.c
index 7cedc348790d..877b37b4e639 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
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
@@ -152,8 +147,46 @@ int mlx5_st_alloc_index(struct mlx5_core_dev *dev, e=
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
+int mlx5_st_get_index(struct mlx5_core_dev *dev, u16 st_index)
+{
+	struct mlx5_st_idx_data *idx_data;
+	struct mlx5_st *st =3D dev->st;
+	int ret =3D 0;
+
+	if (!st)
+		return -EOPNOTSUPP;
+
+	if (st->direct_mode)
+		return 0;
+
+	mutex_lock(&st->lock);
+	idx_data =3D xa_load(&st->idx_xa, st_index);
+	if (WARN_ON_ONCE(!idx_data))
+		ret =3D -EINVAL;
+	else
+		refcount_inc(&idx_data->usecount);
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mlx5_st_get_index);
+
 int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)
 {
 	struct mlx5_st_idx_data *idx_data;
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 04b96c5abb57..0480b5c4f189 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1166,10 +1166,22 @@ int mlx5_dm_sw_icm_dealloc(struct mlx5_core_dev *=
dev, enum mlx5_sw_icm_type type
 			   u64 length, u16 uid, phys_addr_t addr, u32 obj_id);
=20
 #ifdef CONFIG_PCIE_TPH
+int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev, u16 tag,
+			       u16 *st_index);
+int mlx5_st_get_index(struct mlx5_core_dev *dev, u16 st_index);
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
+static inline int mlx5_st_get_index(struct mlx5_core_dev *dev, u16 st_in=
dex)
+{
+	return -EOPNOTSUPP;
+}
 static inline int mlx5_st_alloc_index(struct mlx5_core_dev *dev,
 				      enum tph_mem_type mem_type,
 				      unsigned int cpu_uid, u16 *st_index)
diff --git a/include/rdma/frmr_pools.h b/include/rdma/frmr_pools.h
index af1b88801fa4..a08d2b2cf9f3 100644
--- a/include/rdma/frmr_pools.h
+++ b/include/rdma/frmr_pools.h
@@ -24,7 +24,8 @@ struct ib_frmr_key {
 struct ib_frmr_pool_ops {
 	int (*create_frmrs)(struct ib_device *device, struct ib_frmr_key *key,
 			    u32 *handles, u32 count);
-	void (*destroy_frmrs)(struct ib_device *device, u32 *handles,
+	void (*destroy_frmrs)(struct ib_device *device,
+			      const struct ib_frmr_key *key, u32 *handles,
 			      u32 count);
 	int (*build_key)(struct ib_device *device, const struct ib_frmr_key *in=
,
 			 struct ib_frmr_key *out);
@@ -33,7 +34,7 @@ struct ib_frmr_pool_ops {
 int ib_frmr_pools_init(struct ib_device *device,
 		       const struct ib_frmr_pool_ops *pool_ops);
 void ib_frmr_pools_cleanup(struct ib_device *device);
-int ib_frmr_pool_pop(struct ib_device *device, struct ib_mr *mr);
+int ib_frmr_pool_pop(struct ib_device *device, struct ib_mr *mr, bool *r=
eused);
 int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr);
=20
 #endif /* FRMR_POOLS_H */
--=20
2.53.0-Meta


