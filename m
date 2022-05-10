Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB888521D7C
	for <lists+linux-rdma@lfdr.de>; Tue, 10 May 2022 17:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345528AbiEJPJY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 May 2022 11:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345538AbiEJPIw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 May 2022 11:08:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11126DF46
        for <linux-rdma@vger.kernel.org>; Tue, 10 May 2022 07:39:42 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AEC524019370;
        Tue, 10 May 2022 14:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=KRjcVxZL64kon+Y0BhFqclDXgOvZUcIbZp4XB9Q3hgM=;
 b=j6qirKRV+dU0xFnMrPhEblJRLDGMNKV2dJQ1G21rYGKQ8ETLmj5e1xjoBJ2XJYc5pSeg
 FoCIcBeuFlQAlAv3lHUpXJVGx4WRY4KKj3NEWSF1LRnX3UtKT8eEtzL9shTNoE+QCCsN
 rU1if9yQrET1e2LvOmaDmNCt/XMFGfhMmUy+kGjk1EsZ9eKeD1gXqIW0DWHd9rgfh4RZ
 vZTwQo7wUckxsJnRrjswv2Eb0npoIPzxQ6RL8aVHlVYQxWq8cTexrZFBFqRDCjGw0RhE
 kygabnMubcFo9EYTWshVozDcS4mJ/RzVTiB2q3Q8zr2CyzyeAvMStBmg0JHJ1hHqFYmO uw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fyskp0nxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 14:39:38 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24AEdWOH024488;
        Tue, 10 May 2022 14:39:36 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3fwgd8v7pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 14:39:36 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24AEdY2m49545642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 14:39:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3292011C058;
        Tue, 10 May 2022 14:39:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0232C11C054;
        Tue, 10 May 2022 14:39:34 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.21])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 May 2022 14:39:33 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     chuck.lever@oracle.com, jgg@nvidia.com, leonro@nvidia.com,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH] RDMA/siw: Enable siw on tunnel devices.
Date:   Tue, 10 May 2022 16:39:17 +0200
Message-Id: <20220510143917.23735-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: czYv5-DmJADrFVJZLnWo2IKBoEQKz8bz
X-Proofpoint-ORIG-GUID: czYv5-DmJADrFVJZLnWo2IKBoEQKz8bz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_03,2022-05-10_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 mlxlogscore=789 priorityscore=1501 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205100067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Enable siw to attach to tunnel devices,

Tested-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index e5c586913d0b..dacc174604bf 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -119,6 +119,7 @@ static int siw_dev_qualified(struct net_device *netdev)
 	 * <linux/if_arp.h> for type identifiers.
 	 */
 	if (netdev->type == ARPHRD_ETHER || netdev->type == ARPHRD_IEEE802 ||
+	    netdev->type == ARPHRD_NONE ||
 	    (netdev->type == ARPHRD_LOOPBACK && loopback_enabled))
 		return 1;
 
@@ -315,12 +316,12 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
 
 	sdev->netdev = netdev;
 
-	if (netdev->type != ARPHRD_LOOPBACK) {
+	if (netdev->type != ARPHRD_LOOPBACK && netdev->type != ARPHRD_NONE) {
 		addrconf_addr_eui48((unsigned char *)&base_dev->node_guid,
 				    netdev->dev_addr);
 	} else {
 		/*
-		 * The loopback device does not have a HW address,
+		 * This device does not have a HW address,
 		 * but connection mangagement lib expects gid != 0
 		 */
 		size_t len = min_t(size_t, strlen(base_dev->name), 6);
-- 
2.17.2

