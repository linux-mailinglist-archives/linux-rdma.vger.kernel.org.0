Return-Path: <linux-rdma+bounces-1025-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7C7856269
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Feb 2024 13:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85C7EB2B00D
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Feb 2024 11:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C3012CD87;
	Thu, 15 Feb 2024 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZeRwhGNM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD4912B167;
	Thu, 15 Feb 2024 11:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998160; cv=none; b=JzP3m93y9kdxP/Bi0KBDFpAfwWlIxkZeHizXURr/3Qjgs8Jhp9D5B/4ACMocsPAHQ+YrtHLwQn02nHRjg0oHPN3ej3nC/4PBKuD9OGaR1IW48tG9cTaqMvZG2M8VwviGf2wamEVoTN0MVwKLs2NN1/uYW0FIojCyM+oJnGQ8CEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998160; c=relaxed/simple;
	bh=//cQOtBN0V7j51HQx8FZ9ZotpiIIad0J8ye4LiZogMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cgd0bcsn8HWaDq2ijwa50JY4O02Z2KuEElyE1aznyj61lFA5VSOkiuDezpbxf3XTjgo2bOouWkE10183OXq4V+RjfCGbcHf7oiRZbWjmZrP8OF//OPbeA/JziFZCI4IHp+5s0+3ku+nKLfGWqG+T6hHkYPiHAEuVl5bg1CBzhSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZeRwhGNM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FBMxbm024505;
	Thu, 15 Feb 2024 11:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=JQIyZwMesH5CFC5utWtjUqVuw91qgGFyn2rlfKPbq3w=;
 b=ZeRwhGNMRLCB1BITsxyxobIBp1U9nEFm08cgWrGaCxHSUjuVzQt01m8Cce2hp45IPedp
 1HG7HMRWSgAIkYMiRK57v8eMUkEnvr+rjulaVUKLhdustx8vsRuidya0vkabCdvbBcVi
 EybwPyaqyNze9yCI/Li94R46r5ja/O7U1jknbKSpIEsO2xP7/CSX4UZKCxUcy6binKkq
 oYnMxUFnbbRa+zUGORbNtvMgcQK0/L+RdMXwmJ0brVvhGfjavL7G6XiihjH4WJUA/A8l
 XVHSFoLC1LlIbl5hHv5ZvsqJHwa+7qfYjttnkG46bth/2qFDth0406qiCyNM0ofenyJr dg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9hpdgqxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 11:55:50 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41FBqvTE016495;
	Thu, 15 Feb 2024 11:55:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mymvcwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 11:55:49 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FBtjse24969942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 11:55:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9AD820040;
	Thu, 15 Feb 2024 11:55:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9E1320065;
	Thu, 15 Feb 2024 11:55:45 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.68.71])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Feb 2024 11:55:45 +0000 (GMT)
From: Bernard Metzler <bmt@zurich.ibm.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Bernard Metzler <bmt@zurich.ibm.com>,
        syzbot+e7c51d3be3a5ddfa0d7a@syzkaller.appspotmail.com
Subject: [PATCH] RDMA/siw: Fix handling netdev going down event
Date: Thu, 15 Feb 2024 12:55:24 +0100
Message-Id: <20240215115524.126477-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v4NgQi1OaHOJ0Hsh7DWgUK7XH1f27yZ1
X-Proofpoint-GUID: v4NgQi1OaHOJ0Hsh7DWgUK7XH1f27yZ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_10,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=958 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150093

siw uses the NETDEV_GOING_DOWN event to schedule work which
gracefully clears all related siw devices connections. This
fix avoids re-initiating and re-scheduling this work if still
pending from a previous invocation.

Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
Reported-by: syzbot+e7c51d3be3a5ddfa0d7a@syzkaller.appspotmail.com
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw_main.c | 56 ++++++++++++++--------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 723903bd30c5..6c61f62b322c 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -276,6 +276,31 @@ static const struct ib_device_ops siw_device_ops = {
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, siw_ucontext, base_ucontext),
 };
 
+/*
+ * Network link becomes unavailable. Mark all
+ * affected QP's accordingly.
+ */
+static void siw_netdev_down(struct work_struct *work)
+{
+	struct siw_device *sdev =
+		container_of(work, struct siw_device, netdev_down);
+
+	struct siw_qp_attrs qp_attrs;
+	struct list_head *pos, *tmp;
+
+	memset(&qp_attrs, 0, sizeof(qp_attrs));
+	qp_attrs.state = SIW_QP_STATE_ERROR;
+
+	list_for_each_safe(pos, tmp, &sdev->qp_list) {
+		struct siw_qp *qp = list_entry(pos, struct siw_qp, devq);
+
+		down_write(&qp->state_lock);
+		WARN_ON(siw_qp_modify(qp, &qp_attrs, SIW_QP_ATTR_STATE));
+		up_write(&qp->state_lock);
+	}
+	ib_device_put(&sdev->base_dev);
+}
+
 static struct siw_device *siw_device_create(struct net_device *netdev)
 {
 	struct siw_device *sdev;
@@ -319,6 +344,7 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
 	xa_init_flags(&sdev->mem_xa, XA_FLAGS_ALLOC1);
 
 	ib_set_device_ops(base_dev, &siw_device_ops);
+	INIT_WORK(&sdev->netdev_down, siw_netdev_down);
 	rv = ib_device_set_netdev(base_dev, netdev, 1);
 	if (rv)
 		goto error;
@@ -364,37 +390,11 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
 	return ERR_PTR(rv);
 }
 
-/*
- * Network link becomes unavailable. Mark all
- * affected QP's accordingly.
- */
-static void siw_netdev_down(struct work_struct *work)
-{
-	struct siw_device *sdev =
-		container_of(work, struct siw_device, netdev_down);
-
-	struct siw_qp_attrs qp_attrs;
-	struct list_head *pos, *tmp;
-
-	memset(&qp_attrs, 0, sizeof(qp_attrs));
-	qp_attrs.state = SIW_QP_STATE_ERROR;
-
-	list_for_each_safe(pos, tmp, &sdev->qp_list) {
-		struct siw_qp *qp = list_entry(pos, struct siw_qp, devq);
-
-		down_write(&qp->state_lock);
-		WARN_ON(siw_qp_modify(qp, &qp_attrs, SIW_QP_ATTR_STATE));
-		up_write(&qp->state_lock);
-	}
-	ib_device_put(&sdev->base_dev);
-}
-
 static void siw_device_goes_down(struct siw_device *sdev)
 {
-	if (ib_device_try_get(&sdev->base_dev)) {
-		INIT_WORK(&sdev->netdev_down, siw_netdev_down);
+	if (ib_device_try_get(&sdev->base_dev) &&
+	    !work_pending(&sdev->netdev_down))
 		schedule_work(&sdev->netdev_down);
-	}
 }
 
 static int siw_netdev_event(struct notifier_block *nb, unsigned long event,
-- 
2.38.1


