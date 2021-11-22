Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECE7459367
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Nov 2021 17:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239736AbhKVQwF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Nov 2021 11:52:05 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58754 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238381AbhKVQwF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Nov 2021 11:52:05 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMGUNIu007646;
        Mon, 22 Nov 2021 16:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=kP+BdsCFC6A/kqdU5tYpFZ1Iw1wtbnEK3DTGxzFZeIg=;
 b=HSwMC2uy3zifMCM85LrwugOSCRcvtCWErTlbgkNz4j+AJQpBIXYtjW0uSbE2UE7OloJI
 NPPk+TrdaZ2xbePpwYTm6Den/fspHRR3ZTA7F1vxBKGek/VRJnVKCx8lbcSbIQCFl+HM
 jak/pnTy1s9ClTO586veJkg39PK6EAwQlYvTffGOfl9z9N0txKTQ/gGUEtaQX09uUBBo
 7224heyQTQIOjOH6fpSjrPSL65/glfwtpeLYfE2l0S6AYg5uJDjxXXxEPR9u749+wL7M
 dbY1YW8yIltHdl+ROxxVB/a05ZqjFm3zBJGsUNEqE7oOX1atvybr0XDhvfemWmfZKKfm Dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg461bba1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 16:48:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AMGkj61142675;
        Mon, 22 Nov 2021 16:48:55 GMT
Received: from lab02.no.oracle.com (lab02.no.oracle.com [10.172.144.56])
        by aserp3030.oracle.com with ESMTP id 3ceq2cvjnr-1;
        Mon, 22 Nov 2021 16:48:55 +0000
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH for-rc] RDMA/cma: Remove open coding for overflow in cma_connect_ib
Date:   Mon, 22 Nov 2021 17:48:53 +0100
Message-Id: <1637599733-11096-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10176 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111220085
X-Proofpoint-GUID: LtKnd9wgIt4Mocnu3dHW_HJhAXwMt8TW
X-Proofpoint-ORIG-GUID: LtKnd9wgIt4Mocnu3dHW_HJhAXwMt8TW
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The existing test is a little hard to comprehend. Use
check_add_overflow() instead.

Fixes: 04ded1672402 ("RDMA/cma: Verify private data length")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/cma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 835ac54..0435768 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4093,8 +4093,7 @@ static int cma_connect_ib(struct rdma_id_private *id_priv,
 
 	memset(&req, 0, sizeof req);
 	offset = cma_user_data_offset(id_priv);
-	req.private_data_len = offset + conn_param->private_data_len;
-	if (req.private_data_len < conn_param->private_data_len)
+	if (check_add_overflow(offset, conn_param->private_data_len, &req.private_data_len))
 		return -EINVAL;
 
 	if (req.private_data_len) {
-- 
1.8.3.1

