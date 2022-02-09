Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17814AF292
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Feb 2022 14:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiBINXI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Feb 2022 08:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiBINXH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Feb 2022 08:23:07 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4848CC0613C9;
        Wed,  9 Feb 2022 05:23:07 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219Cu4du012771;
        Wed, 9 Feb 2022 13:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=S4YYOkQ4fl0IMwCXm+ixjvF26D+n6s3iBtWeasMFIC8=;
 b=EDFPXeMJua5blaJgbeMbkRYd59PVcBWlMWJTvLMPiBLJRt0IYrRwhTx+3+hm5MJYqDYP
 t7LFwsNDfqF82Ve7uMYI5yOlpLWdvm44NISb7pQGUv79FNAiyiXywKG9HKgmuJoQmNzl
 6x0p0lju/+w6rjYQHc335u6lKjXgp3/ZUs1T5pR8RjtqX2gdxRow6lOJdJAkHqB/fz3L
 tefP+4sdzPXlMmQeKR890mm1MCKWcw4Karuy0Lo9LuPKWLeMV9lD41tfJB8qV9SsDs/R
 2utYp7IUAoaZAVxWBt87Lqyi+9YSVgtZWTA5TwFAwUopYdHLBk7L5uFpZIVguKT+kkeB kQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3fpgmq9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 13:23:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219DLrqH040268;
        Wed, 9 Feb 2022 13:23:03 GMT
Received: from lab02.no.oracle.com (lab02.no.oracle.com [10.172.144.56])
        by userp3030.oracle.com with ESMTP id 3e1ec2gjex-1;
        Wed, 09 Feb 2022 13:23:02 +0000
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH for-rc] IB/cma: Allow XRG INI QPs to set their local ACK timeout
Date:   Wed,  9 Feb 2022 14:23:00 +0100
Message-Id: <1644412980-28424-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10252 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090078
X-Proofpoint-GUID: 5943nysLV3fRhnn84zxkIHNi3HbfHIVC
X-Proofpoint-ORIG-GUID: 5943nysLV3fRhnn84zxkIHNi3HbfHIVC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

XRC INI QPs should be able to adjust their local ACK timeout.

Fixes: 2c1619edef61 ("IB/cma: Define option to set ack timeout and pack tos_set")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Suggested-by: Avneesh Pant <avneesh.pant@oracle.com>

---

To avoid excessive discussions around the *if (WARN_ON( ...*
construct, just saying that it has been sanctioned by Jason here:

https://lore.kernel.org/linux-rdma/20210413135120.GT7405@nvidia.com/
---
 drivers/infiniband/core/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 0f5f0d7..006ea9c 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2811,7 +2811,7 @@ int rdma_set_ack_timeout(struct rdma_cm_id *id, u8 timeout)
 {
 	struct rdma_id_private *id_priv;
 
-	if (id->qp_type != IB_QPT_RC)
+	if (WARN_ON(id->qp_type != IB_QPT_RC && id->qp_type != IB_QPT_XRC_INI))
 		return -EINVAL;
 
 	id_priv = container_of(id, struct rdma_id_private, id);
-- 
1.8.3.1

