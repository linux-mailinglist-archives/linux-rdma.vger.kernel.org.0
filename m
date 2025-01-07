Return-Path: <linux-rdma+bounces-6853-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD61A03587
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 03:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66243A445E
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 02:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7126D18C0C;
	Tue,  7 Jan 2025 02:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q6NAP8Ma"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F7118BBA8
	for <linux-rdma@vger.kernel.org>; Tue,  7 Jan 2025 02:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218421; cv=none; b=CkheOda/EQQmuDUboMtVwn0jzWPUNeidje9Vj/iA75kA10m53+eMj37f1wtspSjTSiyRyKBwdNHZHyY9EmIY638N9GIjOzMH9bxEcvSYCESDRXc4pgNDAJzE9D2G1JnYIZOcPsRvx/YwqVfFGJbnxvtZs9q1cKQrr5SJeyBbFPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218421; c=relaxed/simple;
	bh=/jdpKowQbeecU4ZKTJnc/PaYAmGYi6GU7xs6pmyxbSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2N20g6je+5tjYNwqvTnErA53mmb/2lpqUtSqZ8QVEBjRMrVYEHusRJBrPz/4ytW0UcLkE0aBIi+qVj4cHYj2euDNqNK+3OpvTHhhN+8yZb2oSQDaMuUE//Td2lDrVuF2jkvUmY85yPxx6X/n1V+ujjnbuUdCEfTJMP5yV2q6ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q6NAP8Ma; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2163b0c09afso216378325ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jan 2025 18:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736218419; x=1736823219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOUZfiRlh/PtntowGINQ9eAZtcLAQkVkBrFUI6FjAOo=;
        b=Q6NAP8MacSRlUQ/POLOoTvXBVlRpVbfo37C4z6KQF1Vtzl2S4bHxtrmez7ieHOVzIm
         AjQYrR+sVad32+8+AavvT3yzryGOa2OPNgs6SI4Dw1uSYhj7bi2kE4Y2/DoL9KFFnwWQ
         4beSbWDCNuspZoxeBmfs5DtO7+a0jYMqXT5oY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736218419; x=1736823219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOUZfiRlh/PtntowGINQ9eAZtcLAQkVkBrFUI6FjAOo=;
        b=SVCTt4jZtuDwgF2qY/e4yXKZa/JDlUZHgfN99UcAZwWZwANuLQbTs2bicfpasCUHZZ
         hQI5FUrcgsK2jxbS3/ZePncK2hl68kquhQMnq5H9TjY3L2eSNDYbT1sg7rMZmysMjEyL
         tS/59RQPQjHS1ty5QvlWhpszB4NyUo04tx6Gz5xqe96SRjDLzvPV5F8bp/i11dJrpIM7
         7W4RTQJaDZJ844SxQrjcNTSEXvWfxMQL1r7OY+d9kqAmHxtTXMJ6eSGnSLi2gAqZQl/o
         SvFOF1i/PSHqB8DbPg86semkYWnSwU2G3kjY9a/y527YyB4v6vVeKeVsX5hpnpz1rZsx
         TqSQ==
X-Gm-Message-State: AOJu0Yx3NtK0h5AWWIz9E1/sYlJSBV/I72VkMkh9VfDnNgBOERbRWnkv
	WSjeDKoCRxpTeqGalQuzYkWhCAn2mjBi9LZyKkIZt4XjrB1YX0hPVHtvIof/gg==
X-Gm-Gg: ASbGncuLBrIRWUFFTLUPlEdyLE+br3CjtpMx5CBzD0Jv7Vff2aKgZliGcJjma8d8cBk
	l1Quo4ZWITMoOXNlyfgOf/XSj3N9PSFWo3Lb2cSUrbRYdR+FgaEKG5ASupiPV2KZiHzO0mnfxtW
	UFbRtxCFjuwHPeP1U62VLwEkZ/MQk2o15TNdt7DNEAsTV+EsjDREC2qhfKM4dAyuQFlNVL6VNfN
	MjUO22lo+CS7D6R57JFomyr1SSI1546ujkFeCKxbag6fu+Ue2o2GWTUrHtVmCE3GweN8lS1vfbs
	py3OO6rpbi/HcXm9aXqQ6mIzKqzpGFvxTbg5HutrBdq+i1pKFtYEate/owo=
X-Google-Smtp-Source: AGHT+IG2e3U+yq00pJ07uOrJQJq4qZec/jeqMdETuaYq7aa6SFhtt8sOzU7w/9iXWDO+Vjh4mpYaoA==
X-Received: by 2002:a17:902:f68b:b0:215:b18d:ef with SMTP id d9443c01a7336-219e6eb362amr741205275ad.25.1736218418765;
        Mon, 06 Jan 2025 18:53:38 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f692fsm300093285ad.216.2025.01.06.18.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 18:53:38 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next v2 RESEND 4/4] RDMA/bnxt_re: Add support to handle DCB_CONFIG_CHANGE event
Date: Tue,  7 Jan 2025 08:15:52 +0530
Message-ID: <20250107024553.2926983-5-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107024553.2926983-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250107024553.2926983-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QP1 context in HW needs to be updated when there is a
change in the default DSCP values used for RoCE traffic.
Handle the event from FW and modify the dscp value used
by QP1.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |   1 +
 drivers/infiniband/hw/bnxt_re/main.c     | 104 +++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.h |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.h |   1 +
 4 files changed, 107 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index f40aca550328..dc2b193af7e8 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -231,6 +231,7 @@ struct bnxt_re_dev {
 	struct dentry			*qp_debugfs;
 	unsigned long			event_bitmap;
 	struct bnxt_qplib_cc_param	cc_param;
+	struct workqueue_struct		*dcb_wq;
 };
 
 #define to_bnxt_re_dev(ptr, member)	\
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index aa08eb5bbb68..1988bf884445 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -295,9 +295,96 @@ static void bnxt_re_vf_res_config(struct bnxt_re_dev *rdev)
 				      &rdev->qplib_ctx);
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
+	destroy_workqueue(rdev->dcb_wq);
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
+		ibdev_dbg(&rdev->ibdev, "Failed to query ccparam rc:%d", rc);
+		goto free_dcb;
+	}
+	if (cc_param->qp1_tos_dscp != cc_param->tos_dscp) {
+		cc_param->qp1_tos_dscp = cc_param->tos_dscp;
+		rc = bnxt_re_update_qp1_tos_dscp(rdev);
+		if (rc) {
+			ibdev_dbg(&rdev->ibdev, "%s: Failed to modify QP1 rc:%d",
+				  __func__, rc);
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
 
@@ -307,6 +394,21 @@ static void bnxt_re_async_notifier(void *handle, struct hwrm_async_event_cmpl *c
 
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
@@ -1908,6 +2010,7 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 	bnxt_re_debugfs_rem_pdev(rdev);
 
 	bnxt_re_net_unregister_async_event(rdev);
+	bnxt_re_uninit_dcb_wq(rdev);
 
 	if (test_and_clear_bit(BNXT_RE_FLAG_QOS_WORK_REG, &rdev->flags))
 		cancel_delayed_work_sync(&rdev->worker);
@@ -2127,6 +2230,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 
 	bnxt_re_debugfs_add_pdev(rdev);
 
+	bnxt_re_init_dcb_wq(rdev);
 	bnxt_re_net_register_async_event(rdev);
 
 	return 0;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index ef3424c81345..264cf0c2c1ac 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -343,6 +343,7 @@ struct bnxt_qplib_qp {
 	u32				msn;
 	u32				msn_tbl_sz;
 	bool				is_host_msn_tbl;
+	u8				tos_dscp;
 };
 
 #define BNXT_QPLIB_MAX_CQE_ENTRY_SIZE	sizeof(struct cq_base)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index debb26080143..eafa0c1bc732 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -296,6 +296,7 @@ struct bnxt_qplib_cc_param_ext {
 
 struct bnxt_qplib_cc_param {
 	u8 alt_vlan_pcp;
+	u8 qp1_tos_dscp;
 	u16 alt_tos_dscp;
 	u8 cc_mode;
 	u8 enable;
-- 
2.43.5


