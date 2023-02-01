Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0743F685C9F
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Feb 2023 02:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjBAB2i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Jan 2023 20:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjBAB2h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Jan 2023 20:28:37 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE70A4A1D9
        for <linux-rdma@vger.kernel.org>; Tue, 31 Jan 2023 17:28:36 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VIiNgB032624;
        Wed, 1 Feb 2023 01:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=3zgQdXtEYFY90PBHhDzwG6O8OAqsHzvGOTj99f294rw=;
 b=sKO4IFcoBJmx6a0NcBssHxGya1K336WXH/W/IW9O7nHJqNGj2TqA7K7SMItKBWMcCaXv
 fIb73zusKemr0oo7AONKcMtiL/wtKo2gO5W37eEod8rMUpKYBPP8CLvyIHKcoRL6gf2l
 fWtisNtmkxxDWqSoDvLJAv8IrwYeCmWkYWjAmT+Ns7EBXiw2/CRKyeyCQQo+kMA/wS4b
 8RCluoQdkOHZQL7uGQBDaGi4qiEuvwlwK54eOxQ5HeznGd3vcoeuz2iAeWROqgX+ddQQ
 UH9qsW5ZGZd1PAy0IrLtQb9dk4+gmLcCfQ3gUMRCv8td0rhKKGz+fOAHHyQ34Wy0/K+l aA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvrjy42a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 01:28:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3111A6Qr012947;
        Wed, 1 Feb 2023 01:28:34 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3nct5dd9s3-1;
        Wed, 01 Feb 2023 01:28:33 +0000
From:   Jack Vogel <jack.vogel@oracle.com>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/irdma: Move variable into switch case
Date:   Tue, 31 Jan 2023 17:28:23 -0800
Message-Id: <20230201012823.105150-1-jack.vogel@oracle.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302010010
X-Proofpoint-GUID: RemI5pXMIKJugP4exlZfiHy94ZtmDPBo
X-Proofpoint-ORIG-GUID: RemI5pXMIKJugP4exlZfiHy94ZtmDPBo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix build warnings when CONFIG_INIT_STACK_ALL_ZERO is enabled.

Signed-off-by: Jack Vogel <jack.vogel@oracle.com>
---
 drivers/infiniband/hw/irdma/hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index ab246447520b..e3c639a0d920 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -272,8 +272,8 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 		}
 
 		switch (info->ae_id) {
+		case IRDMA_AE_LLP_CONNECTION_ESTABLISHED: {
 			struct irdma_cm_node *cm_node;
-		case IRDMA_AE_LLP_CONNECTION_ESTABLISHED:
 			cm_node = iwqp->cm_node;
 			if (cm_node->accept_pend) {
 				atomic_dec(&cm_node->listener->pend_accepts_cnt);
@@ -281,7 +281,7 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 			}
 			iwqp->rts_ae_rcvd = 1;
 			wake_up_interruptible(&iwqp->waitq);
-			break;
+		} break;
 		case IRDMA_AE_LLP_FIN_RECEIVED:
 		case IRDMA_AE_RDMAP_ROE_BAD_LLP_CLOSE:
 			if (qp->term_flags)
-- 
2.39.1

