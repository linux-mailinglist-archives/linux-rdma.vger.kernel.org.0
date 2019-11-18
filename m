Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC7A100C6B
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2019 20:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfKRTyu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Nov 2019 14:54:50 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:32976 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfKRTyu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Nov 2019 14:54:50 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIJsRHK111105;
        Mon, 18 Nov 2019 19:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=i9k6F09e/NwAM4sqE62o2pyAq1jgtxKh08fnBqae6F0=;
 b=fuZT/kt1vY43fvcF5Zv3ma58bM5JzY5MnJPhxKV6JF8Ymx0FelbSdraFDgIvxmcpTDH5
 kyMb6SKoESx96n2N3yuwtNBaBFGES7KFZ/oyhHVP+eHQOf6z4LxvUXgmhblyz4z7fxXp
 FDvezvwkNi1HCpbW3PXO1MRChnTiO/cPWjbJz/4SOfvkJu+4NwkXqSU0AVq+KRsLEp8C
 bNYmBDGaANV2TyuNsH5Zl0LKzfmbIYkFyrF63Q664KdXEAS3XusObB96qZvuw2yEz20z
 99yig7sHEUoJAwRF7k94t1AL7Fw0h1KyYazs3zNzPUY78w2YgJJ4M2INKmzhSYTwNWjR vA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wa8htjk3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 19:54:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIJs5Gj147006;
        Mon, 18 Nov 2019 19:54:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 2wc09w4m10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Nov 2019 19:54:41 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xAIJsd7K149983;
        Mon, 18 Nov 2019 19:54:41 GMT
Received: from ca-dev107.us.oracle.com (ca-dev107.us.oracle.com [10.129.135.36])
        by userp3020.oracle.com with ESMTP id 2wc09w4kxp-2;
        Mon, 18 Nov 2019 19:54:41 +0000
From:   rao Shoaib <rao.shoaib@oracle.com>
To:     monis@mellanox.com, dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, rao.shoaib@oracle.com
Subject: [PATCH v2 1/2] Introduce maximum WQE size to check limits
Date:   Mon, 18 Nov 2019 11:54:38 -0800
Message-Id: <1574106879-19211-2-git-send-email-rao.shoaib@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574106879-19211-1-git-send-email-rao.shoaib@oracle.com>
References: <1574106879-19211-1-git-send-email-rao.shoaib@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=877 adultscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180170
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Rao Shoaib <rao.shoaib@oracle.com>

Introduce maximum WQE size to impose limits on max SGE's and inline data

Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 3 ++-
 drivers/infiniband/sw/rxe/rxe_qp.c    | 7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 1b596fb..31fb5c7 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -68,7 +68,6 @@ enum rxe_device_param {
 	RXE_HW_VER			= 0,
 	RXE_MAX_QP			= 0x10000,
 	RXE_MAX_QP_WR			= 0x4000,
-	RXE_MAX_INLINE_DATA		= 400,
 	RXE_DEVICE_CAP_FLAGS		= IB_DEVICE_BAD_PKEY_CNTR
 					| IB_DEVICE_BAD_QKEY_CNTR
 					| IB_DEVICE_AUTO_PATH_MIG
@@ -79,7 +78,9 @@ enum rxe_device_param {
 					| IB_DEVICE_RC_RNR_NAK_GEN
 					| IB_DEVICE_SRQ_RESIZE
 					| IB_DEVICE_MEM_MGT_EXTENSIONS,
+	RXE_MAX_WQE_SIZE		= 0x2d0, /* For RXE_MAX_SGE */
 	RXE_MAX_SGE			= 32,
+	RXE_MAX_INLINE_DATA		= RXE_MAX_WQE_SIZE,
 	RXE_MAX_SGE_RD			= 32,
 	RXE_MAX_CQ			= 16384,
 	RXE_MAX_LOG_CQE			= 15,
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index aeea994..323e43d 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -78,9 +78,12 @@ static int rxe_qp_chk_cap(struct rxe_dev *rxe, struct ib_qp_cap *cap,
 		}
 	}
 
-	if (cap->max_inline_data > rxe->max_inline_data) {
+	if (cap->max_inline_data >
+	    rxe->max_inline_data - sizeof(struct rxe_send_wqe)) {
 		pr_warn("invalid max inline data = %d > %d\n",
-			cap->max_inline_data, rxe->max_inline_data);
+			cap->max_inline_data,
+			rxe->max_inline_data -
+			    (u32)sizeof(struct rxe_send_wqe));
 		goto err1;
 	}
 
-- 
1.8.3.1

