Return-Path: <linux-rdma+bounces-6833-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CCEA02261
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 11:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E483A2939
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 10:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46741DA112;
	Mon,  6 Jan 2025 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NAuvUito"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127501D9353
	for <linux-rdma@vger.kernel.org>; Mon,  6 Jan 2025 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736157687; cv=none; b=tHfxiGgrDTsLOlM/HSxCZeVFy5fnHes9QyC9ARAtjk79/y4xMOrrnoQKhLQf6rU8V4UvGGvznYstsIVFrQfxt4Iy2lIbkl4tFsQgUmUvkMSD+Rp6AwonoUZC5vsPWySQ2gUmF7uR7uAtSWeYXxeJgDp95E5IpsPUqVZPmtogO7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736157687; c=relaxed/simple;
	bh=/jdpKowQbeecU4ZKTJnc/PaYAmGYi6GU7xs6pmyxbSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MA34AxnPHKqMO8n1x//+hDjpO3lOErQWSk0drAUeeHisBEhXGwxAtCeGxHKxEfAzHXesuYf2Nuo+3ciKpLyCeqTotBXuR3q7jl4h84xX43y16vOtOKazPPpD9msq/NMvYpb5UPWQJItQ8zpu371QgE/BfGrn5t42uwz4XR82COg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NAuvUito; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2165448243fso2037875ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jan 2025 02:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736157684; x=1736762484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOUZfiRlh/PtntowGINQ9eAZtcLAQkVkBrFUI6FjAOo=;
        b=NAuvUito2TmgVDbq6jmtavnsL0odqEoUz9SRyYJzL9XYj+JNMCfqfgpII90Tu2phIh
         noNiHNW6KAormtrgSwSDB7TXMmIy+TRfMvEaDmjfIDs0vEc4BE/uw9Qj5sFwdce0k3DG
         bYI0U7Y3yG8BNQn043nMMvLLTHlRTuAvEqVpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736157684; x=1736762484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOUZfiRlh/PtntowGINQ9eAZtcLAQkVkBrFUI6FjAOo=;
        b=LhSlVZWCTi7in2TL9uuNjwu6TLjY/uJvtp0KD70PsBxw13acmzQliKh7321lfYa1xO
         jTJIpjrv5yTct8+Z1TH3DNI2EdofnfA3RzoaQJSIcnUf+uuBM15mmggcKLZFVotYYYYl
         SF8wMVDI2EmyieXCgiUnW9ssPVneE2jI7k4RUliqfGqXshobhHwa2czgk+1xKCybKfY2
         yWqkpsExbFRuzrajp1WLG3K5CJq3i2rTnO5CbubsZcVOFwZYpzkVwZ2QS4EeBVVcduvL
         rnJn7AA/noKkNoIwxmtFOZHtwRIk6kwSOsEcdmun19XWBaCesqtjGYWFGI64alokcK88
         0r3g==
X-Gm-Message-State: AOJu0YwsE4CkSeu7n0onGASliQmGgcKJ2gVbeAOzr7/nLu2Jou9G8x45
	5DpR5JnPTtDJbs8u6jPMHUYmJ8sCI/wuO008Hd7qsLc30TGbjL/fY4gDKUt8P+r18JHnY5aYUqM
	=
X-Gm-Gg: ASbGnctXVE8KyPm4E+J/vU61MjI5VyY535/lXX5ajf3rVexrIJoEnOYfopwZN8kyfLK
	3waRL1QC6v9NjdfNdc8To1iIAsA7Fe5SNf/VHtFowVv7Abg+TKiX1VpmaEWmLhBX4X5hskxdpx1
	54ESvgQOJxKgSkRtyoWuPGR6GQn40wda2rPN6sm/SDyjvPodXBVBF6GkH6UM2z84H25+oIYKdz7
	3fwsBDXeG1/jfu6xwzg5W4kLdaibRozqghbnqaRts1t/ngRHc9JPIHXHI5jTCwa/k4DDiJMmsHW
	FnO4Iri76QN3ErmkjRjfYh6Pu6cr92kUCRw+RgNBx9EcwLgCN34XjjpOhek=
X-Google-Smtp-Source: AGHT+IEFWdco1HSi3/9iW7ulh40MJVghaHH41gJkCTFU+2n/khkdk1Sphx/+sU3f8GaPw9N6X7WhOw==
X-Received: by 2002:a17:903:11c5:b0:216:69ca:770b with SMTP id d9443c01a7336-219e6e8bb28mr916202185ad.12.1736157684104;
        Mon, 06 Jan 2025 02:01:24 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d4c89sm282325265ad.124.2025.01.06.02.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 02:01:23 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH for-next v2 4/4] RDMA/bnxt_re: Add support to handle DCB_CONFIG_CHANGE event
Date: Mon,  6 Jan 2025 15:23:49 +0530
Message-ID: <20250106095349.2880446-5-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250106095349.2880446-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250106095349.2880446-1-kalesh-anakkur.purayil@broadcom.com>
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


