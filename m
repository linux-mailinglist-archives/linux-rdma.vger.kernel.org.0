Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BA4685D80
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Feb 2023 03:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjBACtd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Jan 2023 21:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjBACtd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Jan 2023 21:49:33 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DA334336
        for <linux-rdma@vger.kernel.org>; Tue, 31 Jan 2023 18:49:31 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VIiNJv005645;
        Wed, 1 Feb 2023 02:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=esgEXmFFWt9FbN498o94pbB7QkM207D7d1kWGEz4JrA=;
 b=jp9rTA+VEmtTEgflIioByWTN11M1mFtZ2vjLKy6tvgCaYxAyYyLgRn6MsJdS1obkfZhZ
 in2alE3SIgqRN5WMIk5DecyC1Hwb/vkrgud3bQwMvrnYbdo5/sxYYafgXEK3nMCFt8pg
 xmsllOfj+9wB5ENpyZ8eXSuRi8Wauuply8rBbD96n7GPji3d9BPrQ4woSnjkV03Nni6Z
 +kEzRgiMBooHs7NC8/rsvSwjxAhkUMQAgL9IVcQdE5l6ZnQKJA1SOsZOs8kmwV6/fv23
 LpIhpKuyrUS/m0qtYcDfum6ARSwchf55D/19NNOPBRMz98wRks8PAxU/F9ci2460+zHD oQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvm179sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 02:49:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3110x1xg013006;
        Wed, 1 Feb 2023 02:49:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5dfarq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 02:49:29 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3112nSWw013273;
        Wed, 1 Feb 2023 02:49:28 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3nct5dfar6-1;
        Wed, 01 Feb 2023 02:49:28 +0000
From:   Jack Vogel <jack.vogel@oracle.com>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        linux-rdma@vger.kernel.org, linux_uek_grp@oracle.com
Subject: [PATCH] RDMA/irdma: Fix warning in utils.c build
Date:   Tue, 31 Jan 2023 18:49:21 -0800
Message-Id: <20230201024921.122711-1-jack.vogel@oracle.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302010021
X-Proofpoint-GUID: oHh-y3JyBOOmH1E1PPBoPkrFfGxlTJAI
X-Proofpoint-ORIG-GUID: oHh-y3JyBOOmH1E1PPBoPkrFfGxlTJAI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When defining CONFIG_INIT_STACK_ALL_ZERO a warning is emitted
due to this variable in the switch, moving it into the case 
solves the problem.

Signed-off-by: Jack Vogel <jack.vogel@oracle.com>
---
 drivers/infiniband/hw/irdma/utils.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 445e69e86409..fe6dd59fcf5b 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -1218,12 +1218,11 @@ int irdma_hw_modify_qp(struct irdma_device *iwdev, struct irdma_qp *iwqp,
 			return status;
 
 		switch (m_info->next_iwarp_state) {
-			struct irdma_gen_ae_info ae_info;
-
 		case IRDMA_QP_STATE_RTS:
 		case IRDMA_QP_STATE_IDLE:
 		case IRDMA_QP_STATE_TERMINATE:
-		case IRDMA_QP_STATE_CLOSING:
+		case IRDMA_QP_STATE_CLOSING: {
+			struct irdma_gen_ae_info ae_info;
 			if (info->curr_iwarp_state == IRDMA_QP_STATE_IDLE)
 				irdma_send_reset(iwqp->cm_node);
 			else
@@ -1250,7 +1249,7 @@ int irdma_hw_modify_qp(struct irdma_device *iwdev, struct irdma_qp *iwqp,
 				irdma_handle_cqp_op(rf, cqp_request);
 				irdma_put_cqp_request(&rf->cqp, cqp_request);
 			}
-			break;
+		} break;
 		case IRDMA_QP_STATE_ERROR:
 		default:
 			break;
-- 
2.39.1

