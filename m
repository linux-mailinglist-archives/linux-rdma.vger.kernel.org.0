Return-Path: <linux-rdma+bounces-18834-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIW2FI2Py2kuIwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18834-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 11:10:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A21A366C06
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 11:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51FD3303E490
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 09:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E194E3DCDA4;
	Tue, 31 Mar 2026 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gqdiPtGa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7285136AB6B;
	Tue, 31 Mar 2026 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948132; cv=none; b=iuFqNR+UXwyEewq/slAFCDLp9eovG0SSdbGOdFS2pdNNMHTAEK/rnWTwSgChzdKqDwBjgeh3ug95uHTrwgV7sNh5cSsuYN1Skh6bW1agmXdj884JNXo8rQWtggQeG3Qk05Bmqp2VCvfuJA77zI9t/4Jv2H7Tu0fdjYYWg6L3pDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948132; c=relaxed/simple;
	bh=ZOaAwbD5+8fTnGtwKB1xR4voJUtp4ih044ndqsoxNAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gTNWsaalAT3DupD69shihSYhpkzKiLZ2YxISzjCeQGIbHRrpAOqk4vW3Q8szCQotrQhnBuoJkjl2suVbzv23+O1C+2f6RGbX751ZVBFw0wCQn1xq+n2SdlkYZlgjrgyVszb1m/Ip+HWGmMaYxaUyS9N2F6nO7qbo6+NUh4dCYWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gqdiPtGa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id 9797120B6F0C; Tue, 31 Mar 2026 02:08:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9797120B6F0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774948131;
	bh=Uc0l5Jgo9c2T29mSNUb64opvlq7rwpxOGyBJaGX9Db8=;
	h=From:To:Cc:Subject:Date:From;
	b=gqdiPtGa/BwJ9cOFywXzrSwtoCwBx9WcL/PVImZ9Dpc1SEVQiDJZce2H6YCYaaee1
	 LgspgL8/DeXgb0SUs/6R22fd9OFsvBL1k9YiOIdIVIwcLZURiHom4NIncVTB81/IxF
	 0XWjJctvhDfOfKQSpyfz3v9FSrAJW4ekpru0TYPs=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v3 1/1] RDMA/mana_ib: memory windows
Date: Tue, 31 Mar 2026 02:08:51 -0700
Message-ID: <20260331090851.2276205-1-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[kotaranov@linux.microsoft.com,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-18834-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9A21A366C06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Konstantin Taranov <kotaranov@microsoft.com>

Implement .alloc_mw() and .dealloc_mw() for mana device.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
---
v3: Use v2 request
v2: fixed comments. Cleaned up the use of mana_gd_send_request()
 drivers/infiniband/hw/mana/device.c  |  3 ++
 drivers/infiniband/hw/mana/mana_ib.h |  8 +++++
 drivers/infiniband/hw/mana/mr.c      | 54 +++++++++++++++++++++++++++-
 include/net/mana/gdma.h              |  5 +++
 4 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index ccc2279ca..9811570ab 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -17,6 +17,7 @@ static const struct ib_device_ops mana_ib_dev_ops = {
 	.uverbs_abi_ver = MANA_IB_UVERBS_ABI_VERSION,
 
 	.add_gid = mana_ib_gd_add_gid,
+	.alloc_mw = mana_ib_alloc_mw,
 	.alloc_pd = mana_ib_alloc_pd,
 	.alloc_ucontext = mana_ib_alloc_ucontext,
 	.create_ah = mana_ib_create_ah,
@@ -24,6 +25,7 @@ static const struct ib_device_ops mana_ib_dev_ops = {
 	.create_qp = mana_ib_create_qp,
 	.create_rwq_ind_table = mana_ib_create_rwq_ind_table,
 	.create_wq = mana_ib_create_wq,
+	.dealloc_mw = mana_ib_dealloc_mw,
 	.dealloc_pd = mana_ib_dealloc_pd,
 	.dealloc_ucontext = mana_ib_dealloc_ucontext,
 	.del_gid = mana_ib_gd_del_gid,
@@ -53,6 +55,7 @@ static const struct ib_device_ops mana_ib_dev_ops = {
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, mana_ib_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, mana_ib_cq, ibcq),
+	INIT_RDMA_OBJ_SIZE(ib_mw, mana_ib_mw, ibmw),
 	INIT_RDMA_OBJ_SIZE(ib_pd, mana_ib_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_qp, mana_ib_qp, ibqp),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, mana_ib_ucontext, ibucontext),
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index a7c8c0fd7..c9c94e86a 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -125,6 +125,11 @@ struct mana_ib_ah {
 	dma_addr_t dma_handle;
 };
 
+struct mana_ib_mw {
+	struct ib_mw ibmw;
+	mana_handle_t mw_handle;
+};
+
 struct mana_ib_mr {
 	struct ib_mr ibmr;
 	struct ib_umem *umem;
@@ -736,6 +741,9 @@ void mana_drain_gsi_sqs(struct mana_ib_dev *mdev);
 int mana_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
 int mana_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
 
+int mana_ib_alloc_mw(struct ib_mw *mw, struct ib_udata *udata);
+int mana_ib_dealloc_mw(struct ib_mw *mw);
+
 struct ib_mr *mana_ib_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start, u64 length,
 					 u64 iova, int fd, int mr_access_flags,
 					 struct ib_dmah *dmah,
diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index 9bae99c8e..8092a7bb7 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -6,7 +6,7 @@
 #include "mana_ib.h"
 
 #define VALID_MR_FLAGS (IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_READ |\
-			IB_ACCESS_REMOTE_ATOMIC | IB_ZERO_BASED)
+			IB_ACCESS_REMOTE_ATOMIC | IB_ACCESS_MW_BIND | IB_ZERO_BASED)
 
 #define VALID_DMA_MR_FLAGS (IB_ACCESS_LOCAL_WRITE)
 
@@ -27,6 +27,9 @@ mana_ib_verbs_to_gdma_access_flags(int access_flags)
 	if (access_flags & IB_ACCESS_REMOTE_ATOMIC)
 		flags |= GDMA_ACCESS_FLAG_REMOTE_ATOMIC;
 
+	if (access_flags & IB_ACCESS_MW_BIND)
+		flags |= GDMA_ACCESS_FLAG_BIND_MW;
+
 	return flags;
 }
 
@@ -287,6 +290,55 @@ struct ib_mr *mana_ib_get_dma_mr(struct ib_pd *ibpd, int access_flags)
 	return ERR_PTR(err);
 }
 
+static int mana_ib_gd_create_mw(struct mana_ib_dev *dev, struct mana_ib_pd *pd, struct ib_mw *ibmw)
+{
+	struct mana_ib_mw *mw = container_of(ibmw, struct mana_ib_mw, ibmw);
+	struct gdma_context *gc = mdev_to_gc(dev);
+	struct gdma_create_mr_response resp = {};
+	struct gdma_create_mr_request req = {};
+	int err;
+
+	mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_MR, sizeof(req), sizeof(resp));
+	req.hdr.req.msg_version = GDMA_MESSAGE_V2;
+	req.pd_handle = pd->pd_handle;
+
+	switch (mw->ibmw.type) {
+	case IB_MW_TYPE_1:
+		req.mr_type = GDMA_MR_TYPE_MW1;
+		break;
+	case IB_MW_TYPE_2:
+		req.mr_type = GDMA_MR_TYPE_MW2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	if (err)
+		return err;
+
+	mw->ibmw.rkey = resp.rkey;
+	mw->mw_handle = resp.mr_handle;
+
+	return 0;
+}
+
+int mana_ib_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
+{
+	struct mana_ib_dev *mdev = container_of(ibmw->device, struct mana_ib_dev, ib_dev);
+	struct mana_ib_pd *pd = container_of(ibmw->pd, struct mana_ib_pd, ibpd);
+
+	return mana_ib_gd_create_mw(mdev, pd, ibmw);
+}
+
+int mana_ib_dealloc_mw(struct ib_mw *ibmw)
+{
+	struct mana_ib_dev *dev = container_of(ibmw->device, struct mana_ib_dev, ib_dev);
+	struct mana_ib_mw *mw = container_of(ibmw, struct mana_ib_mw, ibmw);
+
+	return mana_ib_gd_destroy_mr(dev, mw->mw_handle);
+}
+
 int mana_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
 	struct mana_ib_mr *mr = container_of(ibmr, struct mana_ib_mr, ibmr);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 766f4fb25..fc6468ac7 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -778,6 +778,7 @@ enum gdma_mr_access_flags {
 	GDMA_ACCESS_FLAG_REMOTE_READ = BIT_ULL(2),
 	GDMA_ACCESS_FLAG_REMOTE_WRITE = BIT_ULL(3),
 	GDMA_ACCESS_FLAG_REMOTE_ATOMIC = BIT_ULL(4),
+	GDMA_ACCESS_FLAG_BIND_MW = BIT_ULL(5),
 };
 
 /* GDMA_CREATE_DMA_REGION */
@@ -870,6 +871,10 @@ enum gdma_mr_type {
 	GDMA_MR_TYPE_ZBVA = 4,
 	/* Device address MRs */
 	GDMA_MR_TYPE_DM = 5,
+	/* Memory Window type 1 */
+	GDMA_MR_TYPE_MW1 = 6,
+	/* Memory Window type 2 */
+	GDMA_MR_TYPE_MW2 = 7,
 };
 
 struct gdma_create_mr_params {
-- 
2.43.0


