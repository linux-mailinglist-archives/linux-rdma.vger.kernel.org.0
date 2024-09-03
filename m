Return-Path: <linux-rdma+bounces-4723-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D60969C77
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 13:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81EBD1F244A3
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 11:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CCC1AD26D;
	Tue,  3 Sep 2024 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U/AzFszL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26031A42B8
	for <linux-rdma@vger.kernel.org>; Tue,  3 Sep 2024 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364311; cv=none; b=GTyGzaUJvsSlrzOam+4EIyQsdS3Azm8aYjecKdlOI97HDCzSAcVivZj16OQ/dHI2NFB2c1PfHeV8lOa9gbiRM++QCGCtvY8m4OxIkpOHCNovyzTHWcpnyzfVGmpOQhcGTv5puVyCdpZ8VDsqUXWxKc67Tp3dpgIQK5KoLoV5J3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364311; c=relaxed/simple;
	bh=cfT+VOv5OeO5xevYAj8dAdiIljAjgA0T+3ab3szelmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pt7hFukEWToASrCrvazAuDlyJ34YMyq3CDZR9rNFHtjYKttXJ/WdG5tgLlrOtYnb3RyhRjKNOFoIoDTeUOHb5+vXMQPfwuGx8zpVuI+9ZPzj/vfToa4mbAfWy2T26B7tuMYRbHy1Gv4jCcXQwcsonX5PFv264CKTCfKZbvwwRSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U/AzFszL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-204f52fe74dso45359815ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 03 Sep 2024 04:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725364309; x=1725969109; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lDexIicCZs7PthN0glhuhd1Taf3cZmLf+POTkhRzVMA=;
        b=U/AzFszLNwwvTbCxZ8tmqgL0flkwsSyqCNjcWig9ggY5n/aYc8+oXMRZwzvq08X86Q
         CgQpddFEis70mDteNSI/YdHp8Vf2fIZWYnWdCzf9KboxTtP+nx40+nwRznv8Pqk6mb86
         cv+INyYCMDXrd4dGV4BRE0BqA3dpaEfUTJQkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725364309; x=1725969109;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDexIicCZs7PthN0glhuhd1Taf3cZmLf+POTkhRzVMA=;
        b=W5j9tuPb7J1OCIIbzldEpEdV7w3ZkP11YKNy+gCQaNgBWCK30BnBdKahr/yh4fV5wu
         u4//SPdEhUoCL0OAzQqHr7CQIAq/w3HRa2keAbFy9oqGW7PAYXaG1eiDWCbcA4y3DP7x
         NngnwlTgeHXDrxwPLpySRukrZoD1VCE1lHSL9MTwekCsLEj92RNTk4ix9xUgLgdhtgQx
         v5S9UQm5o8HVC6Bn1FNSzOsiQ+vafilLOp9pvUJXFNLPTNK2VImMgwTqGdgqjwFXe6oc
         r8dw2jODjxl8AHJPDoHwc3U3hO4oAxUbQcBR590OaKHBCbRV9s25CkiWbTZYp0XQtoJp
         hfdg==
X-Gm-Message-State: AOJu0YxIzgZzXSLZ1Gu7VsPQ3ef//59xAUhCyZ2JL2SIwxmhVau4YwO0
	adToJF0R5Bwk6dykla4Wx7rW8pE2de5DiUCToTjrSVtAipB1uUSr81oevScsyQ==
X-Google-Smtp-Source: AGHT+IFg+0v8AWslyOdmWqU7hgJOIMkiq5AZGgEns7MrUe8z48nrkTN3JyZXJsvFvKrKDvTU4JiaNA==
X-Received: by 2002:a17:903:28f:b0:202:4d05:a245 with SMTP id d9443c01a7336-20546601577mr131179765ad.29.1725364308991;
        Tue, 03 Sep 2024 04:51:48 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20532b81016sm62077335ad.226.2024.09.03.04.51.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2024 04:51:48 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 3/4] RDMA/bnxt_re: Add support to handle DCB_CONFIG_CHANGE event
Date: Tue,  3 Sep 2024 04:30:50 -0700
Message-Id: <1725363051-19268-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1725363051-19268-1-git-send-email-selvin.xavier@broadcom.com>
References: <1725363051-19268-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

QP1 context in HW needs to be updated when there is a
change in the default DSCP values used for RoCE traffic.
Handle the event from FW and modify the dscp value used
by QP1.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |   1 +
 drivers/infiniband/hw/bnxt_re/main.c     | 105 +++++++++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.h |   2 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.h |   1 +
 4 files changed, 109 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 7149bd0..3f7ac20 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -200,6 +200,7 @@ struct bnxt_re_dev {
 	DECLARE_HASHTABLE(srq_hash, MAX_SRQ_HASH_BITS);
 	unsigned long			event_bitmap;
 	struct bnxt_qplib_cc_param	cc_param;
+	struct workqueue_struct		*dcb_wq;
 };
 
 #define to_bnxt_re_dev(ptr, member)	\
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 541b8f9..e13c0cc 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -300,9 +300,97 @@ static void bnxt_re_shutdown(struct auxiliary_device *adev)
 	bnxt_re_dev_uninit(rdev);
 }
 
+struct bnxt_re_dcb_work {
+	struct work_struct work;
+	struct bnxt_re_dev *rdev;
+	struct hwrm_async_event_cmpl cmpl;
+};
+
+static bool bnxt_re_is_qp1_qp(struct bnxt_re_qp *qp)
+{
+	return qp->ib_qp.qp_type == IB_QPT_GSI;
+}
+
+static struct bnxt_re_qp *bnxt_re_get_qp1_qp(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_re_qp *qp;
+
+	mutex_lock(&rdev->qp_lock);
+	list_for_each_entry(qp, &rdev->qp_list, list) {
+		if (bnxt_re_is_qp1_qp(qp)) {
+			mutex_unlock(&rdev->qp_lock);
+			return qp;
+		}
+	}
+	mutex_unlock(&rdev->qp_lock);
+	return NULL;
+}
+
+static int bnxt_re_update_qp1_tos_dscp(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_re_qp *qp;
+
+	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx))
+		return 0;
+
+	qp = bnxt_re_get_qp1_qp(rdev);
+	if (!qp)
+		return 0;
+
+	qp->qplib_qp.modify_flags = CMDQ_MODIFY_QP_MODIFY_MASK_TOS_DSCP;
+	qp->qplib_qp.tos_dscp = rdev->cc_param.qp1_tos_dscp;
+
+	return bnxt_qplib_modify_qp(&rdev->qplib_res, &qp->qplib_qp);
+}
+
+static void bnxt_re_init_dcb_wq(struct bnxt_re_dev *rdev)
+{
+	rdev->dcb_wq = create_singlethread_workqueue("bnxt_re_dcb_wq");
+}
+
+static void bnxt_re_uninit_dcb_wq(struct bnxt_re_dev *rdev)
+{
+	if (!rdev->dcb_wq)
+		return;
+	flush_workqueue(rdev->dcb_wq);
+	destroy_workqueue(rdev->dcb_wq);
+	rdev->dcb_wq = NULL;
+}
+
+static void bnxt_re_dcb_wq_task(struct work_struct *work)
+{
+	struct bnxt_re_dcb_work *dcb_work =
+		container_of(work, struct bnxt_re_dcb_work, work);
+	struct bnxt_re_dev *rdev = dcb_work->rdev;
+	struct bnxt_qplib_cc_param *cc_param;
+	int rc;
+
+	if (!rdev)
+		goto free_dcb;
+
+	cc_param = &rdev->cc_param;
+	rc = bnxt_qplib_query_cc_param(&rdev->qplib_res, cc_param);
+	if (rc) {
+		ibdev_err(&rdev->ibdev, "Failed to query ccparam rc:%d", rc);
+		goto free_dcb;
+	}
+	if (cc_param->qp1_tos_dscp != cc_param->tos_dscp) {
+		cc_param->qp1_tos_dscp = cc_param->tos_dscp;
+		rc = bnxt_re_update_qp1_tos_dscp(rdev);
+		if (rc) {
+			ibdev_err(&rdev->ibdev, "%s: Failed to modify QP1 rc:%d", __func__, rc);
+			goto free_dcb;
+		}
+	}
+
+free_dcb:
+	kfree(dcb_work);
+}
+
 static void bnxt_re_async_notifier(void *handle, struct hwrm_async_event_cmpl *cmpl)
 {
 	struct bnxt_re_dev *rdev = (struct bnxt_re_dev *)handle;
+	struct bnxt_re_dcb_work *dcb_work;
 	u32 data1, data2;
 	u16 event_id;
 
@@ -312,6 +400,21 @@ static void bnxt_re_async_notifier(void *handle, struct hwrm_async_event_cmpl *c
 
 	ibdev_dbg(&rdev->ibdev, "Async event_id = %d data1 = %d data2 = %d",
 		  event_id, data1, data2);
+
+	switch (event_id) {
+	case ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_CHANGE:
+		dcb_work = kzalloc(sizeof(*dcb_work), GFP_ATOMIC);
+		if (!dcb_work)
+			break;
+
+		dcb_work->rdev = rdev;
+		memcpy(&dcb_work->cmpl, cmpl, sizeof(*cmpl));
+		INIT_WORK(&dcb_work->work, bnxt_re_dcb_wq_task);
+		queue_work(rdev->dcb_wq, &dcb_work->work);
+		break;
+	default:
+		break;
+	}
 }
 
 static void bnxt_re_stop_irq(void *handle)
@@ -1624,6 +1727,7 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev)
 	int rc;
 
 	bnxt_re_net_unregister_async_event(rdev);
+	bnxt_re_uninit_dcb_wq(rdev);
 
 	if (test_and_clear_bit(BNXT_RE_FLAG_QOS_WORK_REG, &rdev->flags))
 		cancel_delayed_work_sync(&rdev->worker);
@@ -1826,6 +1930,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev)
 	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT)
 		hash_init(rdev->srq_hash);
 
+	bnxt_re_init_dcb_wq(rdev);
 	bnxt_re_net_register_async_event(rdev);
 
 	return 0;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index b62df87..f27d6dc 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -343,6 +343,8 @@ struct bnxt_qplib_qp {
 	u32				msn;
 	u32				msn_tbl_sz;
 	bool				is_host_msn_tbl;
+	/* ToS */
+	u8				tos_dscp;
 };
 
 #define BNXT_QPLIB_MAX_CQE_ENTRY_SIZE	sizeof(struct cq_base)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index 8cbbbeb..5934bcf 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -295,6 +295,7 @@ struct bnxt_qplib_cc_param_ext {
 
 struct bnxt_qplib_cc_param {
 	u8 alt_vlan_pcp;
+	u8 qp1_tos_dscp;
 	u16 alt_tos_dscp;
 	u8 cc_mode;
 	u8 enable;
-- 
2.5.5


