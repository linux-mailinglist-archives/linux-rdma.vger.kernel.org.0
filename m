Return-Path: <linux-rdma+bounces-17215-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APa5BPhGoGkuhwQAu9opvQ
	(envelope-from <linux-rdma+bounces-17215-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 14:13:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6780D1A62CE
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 14:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFDDE303BB13
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 13:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4676230F53C;
	Thu, 26 Feb 2026 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbbaAzqn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0702C46BF;
	Thu, 26 Feb 2026 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111293; cv=none; b=f/qLcGrf7V+v5VADUes7IQBdtsi3bPtBAflURgF0NxqXMoCJ/drgGz1sTTlLrzezeRQpdgpc1ypefmj+B2xdX/ly5bst9XCu/yv+g9vTKYoiuE6TXulAeAgu2O58bFYrwiYfVoc6umcVRyreGyd2jsXVteWP7HteXH4RIuMLLNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111293; c=relaxed/simple;
	bh=SxjwwG4m5H677q3sX8f8Rn64hq1o4hotX4d75n19YL0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XZgpnmrqES4j335fQ9yzxEBXQ6DTAwhxzuWg2v0mybszbCnEVzQfqahTQcOdQCm3+3ZeavCLvoBrI7hirSdm0R9hEKswrFN1RhKDoqN+WUBcGm75WCDJEhzAOKngrKARPDvQGnQDiatao4H103ciy5hSWb/n7cA63sy/TQuwFik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbbaAzqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E91C116C6;
	Thu, 26 Feb 2026 13:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772111292;
	bh=SxjwwG4m5H677q3sX8f8Rn64hq1o4hotX4d75n19YL0=;
	h=From:To:Subject:Date:From;
	b=NbbaAzqnjF5wBa87MM+d+/z93sdOFNlkABQ4Lpt3o9Nz6Ead2vcO/3RuYDwDsfEL+
	 APAc1sMqiz12YKQxokqORKH9U1jqPlCXeNCcWzx+RkeTM4WJCk8d6zdEfQXnj3X38p
	 CyLb7vCrAWKo+yrDrvacYZjN7t7p2IKe5os21mnepUZ18sMktOiXlHL/Toc3SMnJJ2
	 zHwpK4Rj+0sDZ/B2EhW9Tr6clRsWVa6soxqfDEEr+tGIhwR4FZjawECRL69JgDlaTM
	 zwI69bO34+gqNUQdoDzazS51u1acZjMLh+AmJ0K+m/5GDKDPAK75cIW9VovzEFvF7a
	 jNdoCPSDJynZw==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH rdma-next] RDMA: Complete k[z|m|c]alloc-to-k[z|m]alloc_obj conversion
Date: Thu, 26 Feb 2026 15:07:50 +0200
Message-ID: <20260226-complete-alloc-conversion-v1-1-ebf1df1c2518@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260226-complete-alloc-conversion-324aa50d51d0
X-Mailer: b4 0.15-dev-47773
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17215-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6780D1A62CE
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>=0D
=0D
Commits bf4afc53b77a ("Convert 'alloc_obj' family to use the new default=0D
GFP_KERNEL argument") and 69050f8d6d07 ("treewide: Replace kmalloc with=0D
kmalloc_obj for non-scalar types") updated various k[z|m|c]alloc calls to t=
heir=0D
k[z|m]alloc_obj counterparts.=0D
=0D
This commit finalizes that transition within the RDMA subsystem.=0D
=0D
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>=0D
---=0D
 drivers/infiniband/hw/bnxt_re/qplib_res.c      |  2 +-=0D
 drivers/infiniband/hw/hfi1/user_exp_rcv.c      |  9 ++++-----=0D
 drivers/infiniband/hw/hns/hns_roce_hem.c       |  7 ++-----=0D
 drivers/infiniband/hw/hns/hns_roce_qp.c        | 13 ++++---------=0D
 drivers/infiniband/hw/irdma/hw.c               |  4 ++--=0D
 drivers/infiniband/hw/mlx4/main.c              |  2 +-=0D
 drivers/infiniband/hw/mlx5/devx.c              |  6 +++---=0D
 drivers/infiniband/hw/mlx5/dm.c                |  2 +-=0D
 drivers/infiniband/hw/mlx5/fs.c                |  6 +++---=0D
 drivers/infiniband/hw/mlx5/main.c              |  8 +++-----=0D
 drivers/infiniband/hw/mlx5/qos.c               |  2 +-=0D
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c    | 15 +++++++--------=0D
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_misc.c |  3 +--=0D
 13 files changed, 33 insertions(+), 46 deletions(-)=0D
=0D
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband=
/hw/bnxt_re/qplib_res.c=0D
index 41ad8c2018fd..fa6b8cd137e5 100644=0D
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c=0D
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c=0D
@@ -790,7 +790,7 @@ static int bnxt_qplib_alloc_dpi_tbl(struct bnxt_qplib_r=
es *res,=0D
 	if (dev_attr->max_dpi)=0D
 		dpit->max =3D min_t(u32, dpit->max, dev_attr->max_dpi);=0D
 =0D
-	dpit->app_tbl =3D kcalloc(dpit->max,  sizeof(void *), GFP_KERNEL);=0D
+	dpit->app_tbl =3D kzalloc_objs(void *, dpit->max);=0D
 	if (!dpit->app_tbl)=0D
 		return -ENOMEM;=0D
 =0D
diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband=
/hw/hfi1/user_exp_rcv.c=0D
index 5b01070ed66f..a916fe0118b1 100644=0D
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c=0D
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c=0D
@@ -257,7 +257,7 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,=0D
 	if (tinfo->length =3D=3D 0)=0D
 		return -EINVAL;=0D
 =0D
-	tidbuf =3D kzalloc(sizeof(*tidbuf), GFP_KERNEL);=0D
+	tidbuf =3D kzalloc_obj(*tidbuf);=0D
 	if (!tidbuf)=0D
 		return -ENOMEM;=0D
 =0D
@@ -265,8 +265,7 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,=0D
 	tidbuf->vaddr =3D tinfo->vaddr;=0D
 	tidbuf->length =3D tinfo->length;=0D
 	tidbuf->npages =3D num_user_pages(tidbuf->vaddr, tidbuf->length);=0D
-	tidbuf->psets =3D kcalloc(uctxt->expected_count, sizeof(*tidbuf->psets),=
=0D
-				GFP_KERNEL);=0D
+	tidbuf->psets =3D kzalloc_objs(*tidbuf->psets, uctxt->expected_count);=0D
 	if (!tidbuf->psets) {=0D
 		ret =3D -ENOMEM;=0D
 		goto fail_release_mem;=0D
@@ -306,7 +305,7 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,=0D
 	}=0D
 =0D
 	ngroups =3D pageset_count / dd->rcv_entries.group_size;=0D
-	tidlist =3D kcalloc(pageset_count, sizeof(*tidlist), GFP_KERNEL);=0D
+	tidlist =3D kzalloc_objs(*tidlist, pageset_count);=0D
 	if (!tidlist) {=0D
 		ret =3D -ENOMEM;=0D
 		goto fail_unreserve;=0D
@@ -527,7 +526,7 @@ int hfi1_user_exp_rcv_invalid(struct hfi1_filedata *fd,=
=0D
 	 * for a long time.=0D
 	 * Copy the data to a local buffer so we can release the lock.=0D
 	 */=0D
-	array =3D kcalloc(uctxt->expected_count, sizeof(*array), GFP_KERNEL);=0D
+	array =3D kzalloc_objs(*array, uctxt->expected_count);=0D
 	if (!array)=0D
 		return -EFAULT;=0D
 =0D
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/=
hw/hns/hns_roce_hem.c=0D
index 4eaaedcc7652..e7c9e30ad2d8 100644=0D
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c=0D
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c=0D
@@ -771,9 +771,7 @@ int hns_roce_init_hem_table(struct hns_roce_dev *hr_dev=
,=0D
 			unsigned long num_bt_l1;=0D
 =0D
 			num_bt_l1 =3D DIV_ROUND_UP(num_hem, bt_chunk_num);=0D
-			table->bt_l1 =3D kcalloc(num_bt_l1,=0D
-					       sizeof(*table->bt_l1),=0D
-					       GFP_KERNEL);=0D
+			table->bt_l1 =3D kzalloc_objs(*table->bt_l1, num_bt_l1);=0D
 			if (!table->bt_l1)=0D
 				goto err_kcalloc_bt_l1;=0D
 =0D
@@ -786,8 +784,7 @@ int hns_roce_init_hem_table(struct hns_roce_dev *hr_dev=
,=0D
 =0D
 		if (check_whether_bt_num_2(type, hop_num) ||=0D
 			check_whether_bt_num_3(type, hop_num)) {=0D
-			table->bt_l0 =3D kcalloc(num_bt_l0, sizeof(*table->bt_l0),=0D
-					       GFP_KERNEL);=0D
+			table->bt_l0 =3D kzalloc_objs(*table->bt_l0, num_bt_l0);=0D
 			if (!table->bt_l0)=0D
 				goto err_kcalloc_bt_l0;=0D
 =0D
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/h=
w/hns/hns_roce_qp.c=0D
index 5f7ea6c16644..6a2dff4bd2d0 100644=0D
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c=0D
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c=0D
@@ -1023,21 +1023,16 @@ static void free_qp_db(struct hns_roce_dev *hr_dev,=
 struct hns_roce_qp *hr_qp,=0D
 static int alloc_kernel_wrid(struct hns_roce_dev *hr_dev,=0D
 			     struct hns_roce_qp *hr_qp)=0D
 {=0D
-	struct ib_device *ibdev =3D &hr_dev->ib_dev;=0D
-	u64 *sq_wrid =3D NULL;=0D
-	u64 *rq_wrid =3D NULL;=0D
+	u64 *sq_wrid, *rq_wrid =3D NULL;=0D
 	int ret;=0D
 =0D
-	sq_wrid =3D kcalloc(hr_qp->sq.wqe_cnt, sizeof(u64), GFP_KERNEL);=0D
-	if (!sq_wrid) {=0D
-		ibdev_err(ibdev, "failed to alloc SQ wrid.\n");=0D
+	sq_wrid =3D kzalloc_objs(*sq_wrid, hr_qp->sq.wqe_cnt);=0D
+	if (!sq_wrid)=0D
 		return -ENOMEM;=0D
-	}=0D
 =0D
 	if (hr_qp->rq.wqe_cnt) {=0D
-		rq_wrid =3D kcalloc(hr_qp->rq.wqe_cnt, sizeof(u64), GFP_KERNEL);=0D
+		rq_wrid =3D kzalloc_objs(*rq_wrid, hr_qp->rq.wqe_cnt);=0D
 		if (!rq_wrid) {=0D
-			ibdev_err(ibdev, "failed to alloc RQ wrid.\n");=0D
 			ret =3D -ENOMEM;=0D
 			goto err_sq;=0D
 		}=0D
diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma=
/hw.c=0D
index f4ae530f56db..6e0466ce83d1 100644=0D
--- a/drivers/infiniband/hw/irdma/hw.c=0D
+++ b/drivers/infiniband/hw/irdma/hw.c=0D
@@ -1033,7 +1033,7 @@ static int irdma_create_cqp(struct irdma_pci_f *rf)=0D
 	if (!cqp->cqp_requests)=0D
 		return -ENOMEM;=0D
 =0D
-	cqp->scratch_array =3D kcalloc(sqsize, sizeof(*cqp->scratch_array), GFP_K=
ERNEL);=0D
+	cqp->scratch_array =3D kzalloc_objs(*cqp->scratch_array, sqsize);=0D
 	if (!cqp->scratch_array) {=0D
 		status =3D -ENOMEM;=0D
 		goto err_scratch;=0D
@@ -1942,7 +1942,7 @@ int irdma_rt_init_hw(struct irdma_device *iwdev,=0D
 	if (status)=0D
 		return status;=0D
 =0D
-	stats_info.pestat =3D kzalloc(sizeof(*stats_info.pestat), GFP_KERNEL);=0D
+	stats_info.pestat =3D kzalloc_obj(*stats_info.pestat);=0D
 	if (!stats_info.pestat) {=0D
 		irdma_cleanup_cm_core(&iwdev->cm_core);=0D
 		return -ENOMEM;=0D
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4=
/main.c=0D
index 64f961e41e1a..73e17b4339eb 100644=0D
--- a/drivers/infiniband/hw/mlx4/main.c=0D
+++ b/drivers/infiniband/hw/mlx4/main.c=0D
@@ -2161,7 +2161,7 @@ static int __mlx4_ib_alloc_diag_counters(struct mlx4_=
ib_dev *ibdev,=0D
 	if (!*pdescs)=0D
 		return -ENOMEM;=0D
 =0D
-	*offset =3D kcalloc(num_counters, sizeof(**offset), GFP_KERNEL);=0D
+	*offset =3D kzalloc_objs(**offset, num_counters);=0D
 	if (!*offset)=0D
 		goto err;=0D
 =0D
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5=
/devx.c=0D
index 0066b2738ac8..645ebcc0832d 100644=0D
--- a/drivers/infiniband/hw/mlx5/devx.c=0D
+++ b/drivers/infiniband/hw/mlx5/devx.c=0D
@@ -1557,7 +1557,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_CRE=
ATE)(=0D
 	if (IS_ERR(cmd_out))=0D
 		return PTR_ERR(cmd_out);=0D
 =0D
-	obj =3D kzalloc(sizeof(struct devx_obj), GFP_KERNEL);=0D
+	obj =3D kzalloc_obj(*obj);=0D
 	if (!obj)=0D
 		return -ENOMEM;=0D
 =0D
@@ -2158,7 +2158,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_SUBSCRI=
BE_EVENT)(=0D
 		if (err)=0D
 			goto err;=0D
 =0D
-		event_sub =3D kzalloc(sizeof(*event_sub), GFP_KERNEL);=0D
+		event_sub =3D kzalloc_obj(*event_sub);=0D
 		if (!event_sub) {=0D
 			err =3D -ENOMEM;=0D
 			goto err;=0D
@@ -2398,7 +2398,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_UMEM_RE=
G)(=0D
 	if (err)=0D
 		return err;=0D
 =0D
-	obj =3D kzalloc(sizeof(struct devx_umem), GFP_KERNEL);=0D
+	obj =3D kzalloc_obj(*obj);=0D
 	if (!obj)=0D
 		return -ENOMEM;=0D
 =0D
diff --git a/drivers/infiniband/hw/mlx5/dm.c b/drivers/infiniband/hw/mlx5/d=
m.c=0D
index 9972f38ba88a..7a6fe4fea3e2 100644=0D
--- a/drivers/infiniband/hw/mlx5/dm.c=0D
+++ b/drivers/infiniband/hw/mlx5/dm.c=0D
@@ -228,7 +228,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DM_MAP_OP_ADDR=
)(=0D
 	if (!err || err !=3D -ENOENT)=0D
 		goto err_unlock;=0D
 =0D
-	op_entry =3D kzalloc(sizeof(*op_entry), GFP_KERNEL);=0D
+	op_entry =3D kzalloc_obj(*op_entry);=0D
 	if (!op_entry)=0D
 		goto err_unlock;=0D
 =0D
diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/f=
s.c=0D
index cbccb0b9ac10..b155baee0017 100644=0D
--- a/drivers/infiniband/hw/mlx5/fs.c=0D
+++ b/drivers/infiniband/hw/mlx5/fs.c=0D
@@ -2917,7 +2917,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_FLOW_MATCHER=
_CREATE)(=0D
 	struct mlx5_ib_flow_matcher *obj;=0D
 	int err;=0D
 =0D
-	obj =3D kzalloc(sizeof(struct mlx5_ib_flow_matcher), GFP_KERNEL);=0D
+	obj =3D kzalloc_obj(*obj);=0D
 	if (!obj)=0D
 		return -ENOMEM;=0D
 =0D
@@ -3017,7 +3017,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_STEERING_ANC=
HOR_CREATE)(=0D
 	if (err)=0D
 		return err;=0D
 =0D
-	obj =3D kzalloc(sizeof(*obj), GFP_KERNEL);=0D
+	obj =3D kzalloc_obj(*obj);=0D
 	if (!obj)=0D
 		return -ENOMEM;=0D
 =0D
@@ -3259,7 +3259,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_FLOW_ACTION_=
CREATE_PACKET_REFORMAT)(=0D
 	if (!mlx5_ib_flow_action_packet_reformat_valid(mdev, dv_prt, ft_type))=0D
 		return -EOPNOTSUPP;=0D
 =0D
-	maction =3D kzalloc(sizeof(*maction), GFP_KERNEL);=0D
+	maction =3D kzalloc_obj(*maction);=0D
 	if (!maction)=0D
 		return -ENOMEM;=0D
 =0D
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5=
/main.c=0D
index 26ee8e763d5e..7528f0d75802 100644=0D
--- a/drivers/infiniband/hw/mlx5/main.c=0D
+++ b/drivers/infiniband/hw/mlx5/main.c=0D
@@ -2244,16 +2244,14 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontex=
t *uctx,=0D
 =0D
 	mutex_init(&bfregi->lock);=0D
 	bfregi->lib_uar_4k =3D lib_uar_4k;=0D
-	bfregi->count =3D kcalloc(bfregi->total_num_bfregs, sizeof(*bfregi->count=
),=0D
-				GFP_KERNEL);=0D
+	bfregi->count =3D kzalloc_objs(*bfregi->count, bfregi->total_num_bfregs);=
=0D
 	if (!bfregi->count) {=0D
 		err =3D -ENOMEM;=0D
 		goto out_ucap;=0D
 	}=0D
 =0D
-	bfregi->sys_pages =3D kcalloc(bfregi->num_sys_pages,=0D
-				    sizeof(*bfregi->sys_pages),=0D
-				    GFP_KERNEL);=0D
+	bfregi->sys_pages =3D=0D
+		kzalloc_objs(*bfregi->sys_pages, bfregi->num_sys_pages);=0D
 	if (!bfregi->sys_pages) {=0D
 		err =3D -ENOMEM;=0D
 		goto out_count;=0D
diff --git a/drivers/infiniband/hw/mlx5/qos.c b/drivers/infiniband/hw/mlx5/=
qos.c=0D
index dce92554142a..ab7f5db18c93 100644=0D
--- a/drivers/infiniband/hw/mlx5/qos.c=0D
+++ b/drivers/infiniband/hw/mlx5/qos.c=0D
@@ -45,7 +45,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_PP_OBJ_ALLOC)(=0D
 		return -EINVAL;=0D
 =0D
 	dev =3D to_mdev(c->ibucontext.device);=0D
-	pp_entry =3D kzalloc(sizeof(*pp_entry), GFP_KERNEL);=0D
+	pp_entry =3D kzalloc_obj(*pp_entry);=0D
 	if (!pp_entry)=0D
 		return -ENOMEM;=0D
 =0D
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniba=
nd/hw/ocrdma/ocrdma_verbs.c=0D
index c73d4bbee71f..7383b67e1723 100644=0D
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c=0D
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c=0D
@@ -794,7 +794,7 @@ static int ocrdma_build_pbl_tbl(struct ocrdma_dev *dev,=
 struct ocrdma_hw_mr *mr)=0D
 	void *va;=0D
 	dma_addr_t pa;=0D
 =0D
-	mr->pbl_table =3D kzalloc_objs(struct ocrdma_pbl, mr->num_pbls);=0D
+	mr->pbl_table =3D kzalloc_objs(*mr->pbl_table, mr->num_pbls);=0D
 =0D
 	if (!mr->pbl_table)=0D
 		return -ENOMEM;=0D
@@ -1253,12 +1253,11 @@ static void ocrdma_set_qp_db(struct ocrdma_dev *dev=
, struct ocrdma_qp *qp,=0D
 =0D
 static int ocrdma_alloc_wr_id_tbl(struct ocrdma_qp *qp)=0D
 {=0D
-	qp->wqe_wr_id_tbl =3D=0D
-	    kzalloc_objs(*(qp->wqe_wr_id_tbl), qp->sq.max_cnt);=0D
+	qp->wqe_wr_id_tbl =3D kzalloc_objs(*qp->wqe_wr_id_tbl, qp->sq.max_cnt);=0D
 	if (qp->wqe_wr_id_tbl =3D=3D NULL)=0D
 		return -ENOMEM;=0D
-	qp->rqe_wr_id_tbl =3D=0D
-	    kcalloc(qp->rq.max_cnt, sizeof(u64), GFP_KERNEL);=0D
+=0D
+	qp->rqe_wr_id_tbl =3D kzalloc_objs(*qp->rqe_wr_id_tbl, qp->rq.max_cnt);=0D
 	if (qp->rqe_wr_id_tbl =3D=3D NULL)=0D
 		return -ENOMEM;=0D
 =0D
@@ -1788,8 +1787,8 @@ int ocrdma_create_srq(struct ib_srq *ibsrq, struct ib=
_srq_init_attr *init_attr,=0D
 		return status;=0D
 =0D
 	if (!udata) {=0D
-		srq->rqe_wr_id_tbl =3D kcalloc(srq->rq.max_cnt, sizeof(u64),=0D
-					     GFP_KERNEL);=0D
+		srq->rqe_wr_id_tbl =3D=0D
+			kzalloc_objs(*srq->rqe_wr_id_tbl, srq->rq.max_cnt);=0D
 		if (!srq->rqe_wr_id_tbl) {=0D
 			status =3D -ENOMEM;=0D
 			goto arm_err;=0D
@@ -2913,7 +2912,7 @@ struct ib_mr *ocrdma_alloc_mr(struct ib_pd *ibpd, enu=
m ib_mr_type mr_type,=0D
 	if (!mr)=0D
 		return ERR_PTR(-ENOMEM);=0D
 =0D
-	mr->pages =3D kcalloc(max_num_sg, sizeof(u64), GFP_KERNEL);=0D
+	mr->pages =3D kzalloc_objs(*mr->pages, max_num_sg);=0D
 	if (!mr->pages) {=0D
 		status =3D -ENOMEM;=0D
 		goto pl_err;=0D
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_misc.c b/drivers/infin=
iband/hw/vmw_pvrdma/pvrdma_misc.c=0D
index 0864ad25b9d2..64ce5cf5fb96 100644=0D
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_misc.c=0D
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_misc.c=0D
@@ -65,8 +65,7 @@ int pvrdma_page_dir_init(struct pvrdma_dev *dev, struct p=
vrdma_page_dir *pdir,=0D
 		goto err;=0D
 =0D
 	pdir->ntables =3D PVRDMA_PAGE_DIR_TABLE(npages - 1) + 1;=0D
-	pdir->tables =3D kcalloc(pdir->ntables, sizeof(*pdir->tables),=0D
-			       GFP_KERNEL);=0D
+	pdir->tables =3D kzalloc_objs(*pdir->tables, pdir->ntables);=0D
 	if (!pdir->tables)=0D
 		goto err;=0D
 =0D
=0D
---=0D
base-commit: 4c97e6bb1f2311be3146d5f999702392fc17f91f=0D
change-id: 20260226-complete-alloc-conversion-324aa50d51d0=0D
=0D
Best regards,=0D
--  =0D
Leon Romanovsky <leonro@nvidia.com>=0D
=0D

