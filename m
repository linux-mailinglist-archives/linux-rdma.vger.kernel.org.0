Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0CB113F20C
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 19:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404885AbgAPScn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 13:32:43 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39086 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404304AbgAPSck (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 13:32:40 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GI8ZCg056130;
        Thu, 16 Jan 2020 18:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=Y7GYug0Y8XatejflsaiCwFHDIXRQgLFG06sMutgJGzc=;
 b=gAhyUALYvQYG/zDXlYZ3mvsab23rl3qGeP7/7OQVldBgergTPHSrMcEjEUFvIq4R7DEg
 3Gjuaacl3ZByuSErbpcdUm7WJhdj1ODv4cPtyclAoM9Y0Fc0cT3uJ11LyMZkrVmgllv2
 KyHHaEmtxuo0kd/JQnaQoN8sIBSjejjIuoa/a3SroS2ddygA+dHw1OaaT+1g2l/qvhdc
 8w+Hp/LSZzjahXtQjuYlmuz4QCr3bpBuTyE9si5CgUTfLusknBHAC/F7ZLhn/bs//Mgk
 dY9wJtjGnEFNqJmd6dJbsj1QfplvqlaPaSNoel6JFviqzSW1JFMKbTFy4RUigE5/VI2q mw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xf74sm9r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 18:32:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GI9PML124446;
        Thu, 16 Jan 2020 18:30:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 2xj1ptje07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Jan 2020 18:30:31 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id 00GIU9ew190457;
        Thu, 16 Jan 2020 18:30:30 GMT
Received: from ca-dev107.us.oracle.com (ca-dev107.us.oracle.com [10.129.135.36])
        by userp3020.oracle.com with ESMTP id 2xj1ptjdxt-2;
        Thu, 16 Jan 2020 18:30:30 +0000
From:   rao Shoaib <rao.shoaib@oracle.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, monis@mellanox.com, dledford@redhat.com,
        sean.hefty@intel.com, hal.rosenstock@gmail.com,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>
Subject: [PATCH v4 1/2] RDMA/rxe: use RXE_MAX_WQE_SIZE to enforce limits
Date:   Thu, 16 Jan 2020 10:30:11 -0800
Message-Id: <1579199412-15741-2-git-send-email-rao.shoaib@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579199412-15741-1-git-send-email-rao.shoaib@oracle.com>
References: <1579199412-15741-1-git-send-email-rao.shoaib@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=983 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001160147
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Rao Shoaib <rao.shoaib@oracle.com>

Introduce RXE_MAX_WQE_SIZE to impose limits on max SGE's and inline data
size

Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 353c666..f59616b 100644
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
@@ -64,7 +66,6 @@ enum rxe_device_param {
 	RXE_PAGE_SIZE_CAP		= 0xfffff000,
 	RXE_MAX_QP			= 0x10000,
 	RXE_MAX_QP_WR			= 0x4000,
-	RXE_MAX_INLINE_DATA		= 400,
 	RXE_DEVICE_CAP_FLAGS		= IB_DEVICE_BAD_PKEY_CNTR
 					| IB_DEVICE_BAD_QKEY_CNTR
 					| IB_DEVICE_AUTO_PATH_MIG
@@ -77,6 +78,10 @@ enum rxe_device_param {
 					| IB_DEVICE_MEM_MGT_EXTENSIONS
 					| IB_DEVICE_ALLOW_USER_UNREG,
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

