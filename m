Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16693139E6C
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2020 01:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgANAlr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Jan 2020 19:41:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41174 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbgANAlr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Jan 2020 19:41:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E0d6d2101644;
        Tue, 14 Jan 2020 00:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=dbOTCt1Jy/5ixH1+zM/4jFaSoET4MFpcc6Ziu6cX3kI=;
 b=m9wqUdYP0zqcgh7R1HUt2GTLRmrs1z8mH+1+K0qTKkrVFtEG3lmczT1YssEuwapmmP24
 22ZRxvRZ4IzhbZYOqtiUzjZydtq1wEUBWDld5Npvgbv+Z8ya6s9aYFj6YtJQSRdHYNo2
 BOEboORTtBSrccw5Z+m4SaQcc4qpNqm72FdYHkud0Q4+Roa7KuNcxb8sBAsPV/Fjvmw9
 lU++4IEdjQlW76bpLEW6Op7pMOsRxE+cVQh4trkncxTlgPikxY25aK0KMytUFZvJroDm
 1pxrlEFMR/nMxvMEeEN1xKolyrrliV80A589b/MlpSkd7tIHW1KnZAEvT9Rn5fsaJYrk Sg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xf74s2h35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 00:41:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E0d7eT057238;
        Tue, 14 Jan 2020 00:41:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 2xfrgjmaet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Jan 2020 00:41:38 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id 00E0fbfj067024;
        Tue, 14 Jan 2020 00:41:38 GMT
Received: from ca-dev107.us.oracle.com (ca-dev107.us.oracle.com [10.129.135.36])
        by userp3020.oracle.com with ESMTP id 2xfrgjmae0-2;
        Tue, 14 Jan 2020 00:41:38 +0000
From:   rao Shoaib <rao.shoaib@oracle.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, monis@mellanox.com, dledford@redhat.com,
        sean.hefty@intel.com, hal.rosenstock@gmail.com,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>
Subject: [PATCH v3 1/2] Introduce maximum WQE size to check limits
Date:   Mon, 13 Jan 2020 16:41:19 -0800
Message-Id: <1578962480-17814-2-git-send-email-rao.shoaib@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578962480-17814-1-git-send-email-rao.shoaib@oracle.com>
References: <1578962480-17814-1-git-send-email-rao.shoaib@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=945 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001140003
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Rao Shoaib <rao.shoaib@oracle.com>

Introduce maximum WQE size to impose limits on max SGE's and inline data

Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 1b596fb..a0e4075 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -34,6 +34,8 @@
 #ifndef RXE_PARAM_H
 #define RXE_PARAM_H
 
+#include <uapi/rdma/rdma_user_rxe.h>
+
 static inline enum ib_mtu rxe_mtu_int_to_enum(int mtu)
 {
 	if (mtu < 256)
@@ -68,7 +70,6 @@ enum rxe_device_param {
 	RXE_HW_VER			= 0,
 	RXE_MAX_QP			= 0x10000,
 	RXE_MAX_QP_WR			= 0x4000,
-	RXE_MAX_INLINE_DATA		= 400,
 	RXE_DEVICE_CAP_FLAGS		= IB_DEVICE_BAD_PKEY_CNTR
 					| IB_DEVICE_BAD_QKEY_CNTR
 					| IB_DEVICE_AUTO_PATH_MIG
@@ -80,6 +81,10 @@ enum rxe_device_param {
 					| IB_DEVICE_SRQ_RESIZE
 					| IB_DEVICE_MEM_MGT_EXTENSIONS,
 	RXE_MAX_SGE			= 32,
+	RXE_MAX_WQE_SIZE		= sizeof(struct rxe_send_wqe) +
+					  sizeof(struct ib_sge) * RXE_MAX_SGE,
+	RXE_MAX_INLINE_DATA		= RXE_MAX_WQE_SIZE -
+					  sizeof(struct rxe_send_wqe),
 	RXE_MAX_SGE_RD			= 32,
 	RXE_MAX_CQ			= 16384,
 	RXE_MAX_LOG_CQE			= 15,
-- 
1.8.3.1

