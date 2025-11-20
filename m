Return-Path: <linux-rdma+bounces-14652-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6726EC74AB9
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 15:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CDD1335C8BE
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 14:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57442F1FCB;
	Thu, 20 Nov 2025 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBTMZ+BU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A242266EFC;
	Thu, 20 Nov 2025 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650175; cv=none; b=SFJJqUAUNF3pRPxD18o+34OkFwYfejBEYQgYtPEsBEhNIXu70h6dN1KYHm+YU/8CdecUfAA24KrxXjjdqTsr2Zx4MAdl1VzaqzGDL2O5XWlRZyizijYXXFVrakueIQNx8ig88iCaH/YmKVGwYcU21y2fxXMjIc4jfBoSrZYxYcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650175; c=relaxed/simple;
	bh=brlOZ4qQsvv0b9NPc30tO5696xoN05KOIgVTU/7B7vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pS1ppPfCrmj0fm+8Y0FFlA5HxNz9Rm5FkxuHHR1bs/fkbff2rxGXvazA4BWE5M33OPlE67titbvP3VJWsgze+pyMq0KvdpFpAde8jx2wSrN6AsEQ3WdREOC6VM8YPErC7rR7wigV/XR/32RFtuPzFaI260D9C+qrcMylfJcyPXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBTMZ+BU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A908FC4CEF1;
	Thu, 20 Nov 2025 14:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763650175;
	bh=brlOZ4qQsvv0b9NPc30tO5696xoN05KOIgVTU/7B7vw=;
	h=From:To:Cc:Subject:Date:From;
	b=RBTMZ+BUleUAvpfUIQ0NQO4A9LYVGtT6T1St1WJXhR4qZN4bO+vUn7SsWfl5hMGRD
	 7tGwACQxJSpSSmdupDjKexNACDGx+ThwSoLpmIdEZH5UJUUoxKOjaRZO1LRSINoaMP
	 AdJz0y4sLjlqwoA4eoyCW4mkugNJlHG0nnz6hMfY2elV7mhsZL0KGatoMZRq4Y1yJP
	 u+jRD6HWpUSkCqZPiAUwBPXhi7eWT6Rfe5MeThFApk2+Mw9GbHhIGZm8CF0NJRVG7w
	 v05I12Ul4q7QLlj3dvc7PcSYjp8ZiIO7jfEXah5WcD4xkQCXKbs/g3AbYmMtNDLEMA
	 /pveQcpiqv3FA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>
Subject: [PATCH rdma-next] IB/mlx5: Reduce IMR KSM size when 5-level paging is enabled
Date: Thu, 20 Nov 2025 16:49:28 +0200
Message-ID: <20251120-reduce-ksm-v1-1-6864bfc814dc@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251103-reduce-ksm-a091ca606e8b
X-Mailer: b4 0.15-dev-a6db3
Content-Transfer-Encoding: quoted-printable

From: Yishai Hadas <yishaih@nvidia.com>=0D
=0D
Enabling 5-level paging (LA57) increases TASK_SIZE on x86_64 from 2^47=0D
to 2^56. This affects implicit ODP, which uses TASK_SIZE to calculate=0D
the number of IMR KSM entries.=0D
=0D
As a result, the number of entries and the memory usage for KSM mkeys=0D
increase drastically:=0D
=0D
- With 2^47 TASK_SIZE: 0x20000 entries (~2MB)=0D
- With 2^56 TASK_SIZE: 0x4000000 entries (~1GB)=0D
=0D
This issue could happen previously on systems with LA57 manually=0D
enabled, but now commit 7212b58d6d71 ("x86/mm/64: Make 5-level paging=0D
support unconditional") enables LA57 by default on all supported=0D
systems. This makes the issue impact widespread.=0D
=0D
To mitigate this, increase the size each MTT entry maps from 1GB to 16GB=0D
when 5-level paging is enabled. This reduces the number of KSM entries=0D
and lowers the memory usage on LA57 systems from 1GB to 64MB per IMR.=0D
=0D
As now 'mlx5_imr_mtt_size' is larger than 32 bits, we move to use u64=0D
instead of int as part of populate_klm() to prevent overflow of the=0D
'step' variable.=0D
=0D
In addition, as populate_klm() actually handles KSM and not KLM, as it's=0D
used only by implicit ODP, we renamed its signature and the internal=0D
structures accordingly while dropping the byte_count handling which is=0D
not relevant in KSM. The page size in KSM is fixed for all the entries=0D
and come from the log_page_size of the mkey.=0D
=0D
Note:=0D
On platforms where the calculated value for 'mlx5_imr_ksm_page_shift' is=0D
higher than the max firmware cap to be changed over UMR, or that the=0D
calculated value for 'log_va_pages' is higher than what we may expect,=0D
the implicit ODP cap will be simply turned off.=0D
=0D
Co-developed-by: Or Har-Toov <ohartoov@nvidia.com>=0D
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>=0D
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>=0D
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>=0D
Signed-off-by: Edward Srouji <edwards@nvidia.com>=0D
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>=0D
---=0D
 drivers/infiniband/hw/mlx5/odp.c | 89 +++++++++++++++++++++++-------------=
----=0D
 1 file changed, 51 insertions(+), 38 deletions(-)=0D
=0D
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/=
odp.c=0D
index 6441abdf1f3b..e71ee3d52eb0 100644=0D
--- a/drivers/infiniband/hw/mlx5/odp.c=0D
+++ b/drivers/infiniband/hw/mlx5/odp.c=0D
@@ -97,33 +97,28 @@ struct mlx5_pagefault {=0D
  * a pagefault. */=0D
 #define MMU_NOTIFIER_TIMEOUT 1000=0D
 =0D
-#define MLX5_IMR_MTT_BITS (30 - PAGE_SHIFT)=0D
-#define MLX5_IMR_MTT_SHIFT (MLX5_IMR_MTT_BITS + PAGE_SHIFT)=0D
-#define MLX5_IMR_MTT_ENTRIES BIT_ULL(MLX5_IMR_MTT_BITS)=0D
-#define MLX5_IMR_MTT_SIZE BIT_ULL(MLX5_IMR_MTT_SHIFT)=0D
-#define MLX5_IMR_MTT_MASK (~(MLX5_IMR_MTT_SIZE - 1))=0D
-=0D
-#define MLX5_KSM_PAGE_SHIFT MLX5_IMR_MTT_SHIFT=0D
-=0D
 static u64 mlx5_imr_ksm_entries;=0D
+static u64 mlx5_imr_mtt_entries;=0D
+static u64 mlx5_imr_mtt_size;=0D
+static u8 mlx5_imr_mtt_shift;=0D
+static u8 mlx5_imr_ksm_page_shift;=0D
 =0D
-static void populate_klm(struct mlx5_klm *pklm, size_t idx, size_t nentrie=
s,=0D
+static void populate_ksm(struct mlx5_ksm *pksm, size_t idx, size_t nentrie=
s,=0D
 			struct mlx5_ib_mr *imr, int flags)=0D
 {=0D
 	struct mlx5_core_dev *dev =3D mr_to_mdev(imr)->mdev;=0D
-	struct mlx5_klm *end =3D pklm + nentries;=0D
-	int step =3D MLX5_CAP_ODP(dev, mem_page_fault) ? MLX5_IMR_MTT_SIZE : 0;=0D
+	struct mlx5_ksm *end =3D pksm + nentries;=0D
+	u64 step =3D MLX5_CAP_ODP(dev, mem_page_fault) ? mlx5_imr_mtt_size : 0;=0D
 	__be32 key =3D MLX5_CAP_ODP(dev, mem_page_fault) ?=0D
 			     cpu_to_be32(imr->null_mmkey.key) :=0D
 			     mr_to_mdev(imr)->mkeys.null_mkey;=0D
 	u64 va =3D=0D
-		MLX5_CAP_ODP(dev, mem_page_fault) ? idx * MLX5_IMR_MTT_SIZE : 0;=0D
+		MLX5_CAP_ODP(dev, mem_page_fault) ? idx * mlx5_imr_mtt_size : 0;=0D
 =0D
 	if (flags & MLX5_IB_UPD_XLT_ZAP) {=0D
-		for (; pklm !=3D end; pklm++, idx++, va +=3D step) {=0D
-			pklm->bcount =3D cpu_to_be32(MLX5_IMR_MTT_SIZE);=0D
-			pklm->key =3D key;=0D
-			pklm->va =3D cpu_to_be64(va);=0D
+		for (; pksm !=3D end; pksm++, idx++, va +=3D step) {=0D
+			pksm->key =3D key;=0D
+			pksm->va =3D cpu_to_be64(va);=0D
 		}=0D
 		return;=0D
 	}=0D
@@ -147,16 +142,15 @@ static void populate_klm(struct mlx5_klm *pklm, size_=
t idx, size_t nentries,=0D
 	 */=0D
 	lockdep_assert_held(&to_ib_umem_odp(imr->umem)->umem_mutex);=0D
 =0D
-	for (; pklm !=3D end; pklm++, idx++, va +=3D step) {=0D
+	for (; pksm !=3D end; pksm++, idx++, va +=3D step) {=0D
 		struct mlx5_ib_mr *mtt =3D xa_load(&imr->implicit_children, idx);=0D
 =0D
-		pklm->bcount =3D cpu_to_be32(MLX5_IMR_MTT_SIZE);=0D
 		if (mtt) {=0D
-			pklm->key =3D cpu_to_be32(mtt->ibmr.lkey);=0D
-			pklm->va =3D cpu_to_be64(idx * MLX5_IMR_MTT_SIZE);=0D
+			pksm->key =3D cpu_to_be32(mtt->ibmr.lkey);=0D
+			pksm->va =3D cpu_to_be64(idx * mlx5_imr_mtt_size);=0D
 		} else {=0D
-			pklm->key =3D key;=0D
-			pklm->va =3D cpu_to_be64(va);=0D
+			pksm->key =3D key;=0D
+			pksm->va =3D cpu_to_be64(va);=0D
 		}=0D
 	}=0D
 }=0D
@@ -201,7 +195,7 @@ int mlx5_odp_populate_xlt(void *xlt, size_t idx, size_t=
 nentries,=0D
 			  struct mlx5_ib_mr *mr, int flags)=0D
 {=0D
 	if (flags & MLX5_IB_UPD_XLT_INDIRECT) {=0D
-		populate_klm(xlt, idx, nentries, mr, flags);=0D
+		populate_ksm(xlt, idx, nentries, mr, flags);=0D
 		return 0;=0D
 	} else {=0D
 		return populate_mtt(xlt, idx, nentries, mr, flags);=0D
@@ -226,7 +220,7 @@ static void free_implicit_child_mr_work(struct work_str=
uct *work)=0D
 =0D
 	mutex_lock(&odp_imr->umem_mutex);=0D
 	mlx5r_umr_update_xlt(mr->parent,=0D
-			     ib_umem_start(odp) >> MLX5_IMR_MTT_SHIFT, 1, 0,=0D
+			     ib_umem_start(odp) >> mlx5_imr_mtt_shift, 1, 0,=0D
 			     MLX5_IB_UPD_XLT_INDIRECT | MLX5_IB_UPD_XLT_ATOMIC);=0D
 	mutex_unlock(&odp_imr->umem_mutex);=0D
 	mlx5_ib_dereg_mr(&mr->ibmr, NULL);=0D
@@ -237,7 +231,7 @@ static void free_implicit_child_mr_work(struct work_str=
uct *work)=0D
 static void destroy_unused_implicit_child_mr(struct mlx5_ib_mr *mr)=0D
 {=0D
 	struct ib_umem_odp *odp =3D to_ib_umem_odp(mr->umem);=0D
-	unsigned long idx =3D ib_umem_start(odp) >> MLX5_IMR_MTT_SHIFT;=0D
+	unsigned long idx =3D ib_umem_start(odp) >> mlx5_imr_mtt_shift;=0D
 	struct mlx5_ib_mr *imr =3D mr->parent;=0D
 =0D
 	/*=0D
@@ -425,7 +419,10 @@ static void internal_fill_odp_caps(struct mlx5_ib_dev =
*dev)=0D
 	if (MLX5_CAP_GEN(dev->mdev, fixed_buffer_size) &&=0D
 	    MLX5_CAP_GEN(dev->mdev, null_mkey) &&=0D
 	    MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset) &&=0D
-	    !MLX5_CAP_GEN(dev->mdev, umr_indirect_mkey_disabled))=0D
+	    !MLX5_CAP_GEN(dev->mdev, umr_indirect_mkey_disabled) &&=0D
+	    mlx5_imr_ksm_entries !=3D 0 &&=0D
+	    !(mlx5_imr_ksm_page_shift >=0D
+	      get_max_log_entity_size_cap(dev, MLX5_MKC_ACCESS_MODE_KSM)))=0D
 		caps->general_caps |=3D IB_ODP_SUPPORT_IMPLICIT;=0D
 }=0D
 =0D
@@ -476,14 +473,14 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struc=
t mlx5_ib_mr *imr,=0D
 	int err;=0D
 =0D
 	odp =3D ib_umem_odp_alloc_child(to_ib_umem_odp(imr->umem),=0D
-				      idx * MLX5_IMR_MTT_SIZE,=0D
-				      MLX5_IMR_MTT_SIZE, &mlx5_mn_ops);=0D
+				      idx * mlx5_imr_mtt_size,=0D
+				      mlx5_imr_mtt_size, &mlx5_mn_ops);=0D
 	if (IS_ERR(odp))=0D
 		return ERR_CAST(odp);=0D
 =0D
 	mr =3D mlx5_mr_cache_alloc(dev, imr->access_flags,=0D
 				 MLX5_MKC_ACCESS_MODE_MTT,=0D
-				 MLX5_IMR_MTT_ENTRIES);=0D
+				 mlx5_imr_mtt_entries);=0D
 	if (IS_ERR(mr)) {=0D
 		ib_umem_odp_release(odp);=0D
 		return mr;=0D
@@ -495,7 +492,7 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct =
mlx5_ib_mr *imr,=0D
 	mr->umem =3D &odp->umem;=0D
 	mr->ibmr.lkey =3D mr->mmkey.key;=0D
 	mr->ibmr.rkey =3D mr->mmkey.key;=0D
-	mr->ibmr.iova =3D idx * MLX5_IMR_MTT_SIZE;=0D
+	mr->ibmr.iova =3D idx * mlx5_imr_mtt_size;=0D
 	mr->parent =3D imr;=0D
 	odp->private =3D mr;=0D
 =0D
@@ -506,7 +503,7 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct =
mlx5_ib_mr *imr,=0D
 	refcount_set(&mr->mmkey.usecount, 2);=0D
 =0D
 	err =3D mlx5r_umr_update_xlt(mr, 0,=0D
-				   MLX5_IMR_MTT_ENTRIES,=0D
+				   mlx5_imr_mtt_entries,=0D
 				   PAGE_SHIFT,=0D
 				   MLX5_IB_UPD_XLT_ZAP |=0D
 				   MLX5_IB_UPD_XLT_ENABLE);=0D
@@ -611,7 +608,7 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx=
5_ib_pd *pd,=0D
 	struct mlx5_ib_mr *imr;=0D
 	int err;=0D
 =0D
-	if (!mlx5r_umr_can_load_pas(dev, MLX5_IMR_MTT_ENTRIES * PAGE_SIZE))=0D
+	if (!mlx5r_umr_can_load_pas(dev, mlx5_imr_mtt_entries * PAGE_SIZE))=0D
 		return ERR_PTR(-EOPNOTSUPP);=0D
 =0D
 	umem_odp =3D ib_umem_odp_alloc_implicit(&dev->ib_dev, access_flags);=0D
@@ -647,7 +644,7 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx=
5_ib_pd *pd,=0D
 =0D
 	err =3D mlx5r_umr_update_xlt(imr, 0,=0D
 				   mlx5_imr_ksm_entries,=0D
-				   MLX5_KSM_PAGE_SHIFT,=0D
+				   mlx5_imr_ksm_page_shift,=0D
 				   MLX5_IB_UPD_XLT_INDIRECT |=0D
 				   MLX5_IB_UPD_XLT_ZAP |=0D
 				   MLX5_IB_UPD_XLT_ENABLE);=0D
@@ -750,20 +747,20 @@ static int pagefault_implicit_mr(struct mlx5_ib_mr *i=
mr,=0D
 				 struct ib_umem_odp *odp_imr, u64 user_va,=0D
 				 size_t bcnt, u32 *bytes_mapped, u32 flags)=0D
 {=0D
-	unsigned long end_idx =3D (user_va + bcnt - 1) >> MLX5_IMR_MTT_SHIFT;=0D
+	unsigned long end_idx =3D (user_va + bcnt - 1) >> mlx5_imr_mtt_shift;=0D
 	unsigned long upd_start_idx =3D end_idx + 1;=0D
 	unsigned long upd_len =3D 0;=0D
 	unsigned long npages =3D 0;=0D
 	int err;=0D
 	int ret;=0D
 =0D
-	if (unlikely(user_va >=3D mlx5_imr_ksm_entries * MLX5_IMR_MTT_SIZE ||=0D
-		     mlx5_imr_ksm_entries * MLX5_IMR_MTT_SIZE - user_va < bcnt))=0D
+	if (unlikely(user_va >=3D mlx5_imr_ksm_entries * mlx5_imr_mtt_size ||=0D
+		     mlx5_imr_ksm_entries * mlx5_imr_mtt_size - user_va < bcnt))=0D
 		return -EFAULT;=0D
 =0D
 	/* Fault each child mr that intersects with our interval. */=0D
 	while (bcnt) {=0D
-		unsigned long idx =3D user_va >> MLX5_IMR_MTT_SHIFT;=0D
+		unsigned long idx =3D user_va >> mlx5_imr_mtt_shift;=0D
 		struct ib_umem_odp *umem_odp;=0D
 		struct mlx5_ib_mr *mtt;=0D
 		u64 len;=0D
@@ -1924,9 +1921,25 @@ void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *dev=
)=0D
 =0D
 int mlx5_ib_odp_init(void)=0D
 {=0D
+	u32 log_va_pages =3D ilog2(TASK_SIZE) - PAGE_SHIFT;=0D
+	u8 mlx5_imr_mtt_bits;=0D
+=0D
+	/* 48 is default ARM64 VA space and covers X86 4-level paging which is 47=
 */=0D
+	if (log_va_pages <=3D 48 - PAGE_SHIFT)=0D
+		mlx5_imr_mtt_shift =3D 30;=0D
+	/* 56 is x86-64, 5-level paging */=0D
+	else if (log_va_pages <=3D 56 - PAGE_SHIFT)=0D
+		mlx5_imr_mtt_shift =3D 34;=0D
+	else=0D
+		return 0;=0D
+=0D
+	mlx5_imr_mtt_size =3D BIT_ULL(mlx5_imr_mtt_shift);=0D
+	mlx5_imr_mtt_bits =3D mlx5_imr_mtt_shift - PAGE_SHIFT;=0D
+	mlx5_imr_mtt_entries =3D BIT_ULL(mlx5_imr_mtt_bits);=0D
 	mlx5_imr_ksm_entries =3D BIT_ULL(get_order(TASK_SIZE) -=0D
-				       MLX5_IMR_MTT_BITS);=0D
+				       mlx5_imr_mtt_bits);=0D
 =0D
+	mlx5_imr_ksm_page_shift =3D mlx5_imr_mtt_shift;=0D
 	return 0;=0D
 }=0D
 =0D
=0D
---=0D
base-commit: d056bc45b62b5981ebcd18c4303a915490b8ebe9=0D
change-id: 20251103-reduce-ksm-a091ca606e8b=0D
=0D
Best regards,=0D
--  =0D
Leon Romanovsky <leon@kernel.org>=0D
=0D

