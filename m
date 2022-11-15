Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F33629FF7
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 18:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiKORIQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 12:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiKORIJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 12:08:09 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6690F5AF
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 09:08:07 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFGakTM017872;
        Tue, 15 Nov 2022 17:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=rFaTyLlUDK+hq+GqIQ9w+ZkvjzMRjvglD4DR/v+r1/4=;
 b=fIkuMnXH+kV7fTekEB0cJtWCjD1DIzXC1SvYTnUMGyh3DHL7hahwQ8EIha0vwl8J4/Qx
 lhlWPsyPlhWFv07Ze/vjoK1cv1iof9Vq0QQj+nEP95Duv0WHRizmVuzK/Da7OPytaFve
 4NSB0A3Cnh4NlTraq384nLY3KIjhc1Iu/vgYML0qNtnir5U4ZAF9wZTPLrq/ShM7d9qz
 pYe6j6GlIS2igT6izZfBOxouGA45kAoB+a99rvmaSKw4Xnh8I/9H1biiG81A/IFolze4
 3QgOCAJmwjHnEWpnElg4kvNe+Kn3MOcgvo0Q05KbgO+9uNVccdtGjAE1TiBE0dbDZpXJ 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvdws1rfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 17:08:06 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AFGdT0v030278;
        Tue, 15 Nov 2022 17:08:05 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvdws1ret-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 17:08:05 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AFH67u4004655;
        Tue, 15 Nov 2022 17:08:03 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3kt348vnrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 17:08:03 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AFH22ND46137790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 17:02:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD727A405B;
        Tue, 15 Nov 2022 17:08:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A718AA4054;
        Tue, 15 Nov 2022 17:08:00 +0000 (GMT)
Received: from rims.zurich.ibm.com (unknown [9.4.69.56])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Nov 2022 17:08:00 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@nvidia.com, leonro@nvidia.com,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH] RDMA/siw: Set defined status for work completion with undefined status
Date:   Tue, 15 Nov 2022 18:07:47 +0100
Message-Id: <20221115170747.1263298-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gOwl6eAMI4DaI5UHdb6mSJaKKBHMy3Jw
X-Proofpoint-GUID: Aq8OuDUjiACq_UkpdgdWmFeqv9CSt4Ac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=652
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A malicious user may write undefined values into memory mapped completion
queue elements status or opcode. Undefined status or opcode values will
result in out-of-bounds access to an array mapping siw internal
representation of opcode and status to RDMA core representation when
reaping CQ elements. While siw detects those undefined values,
it did not correctly set completion status to a defined value, thus
defeating the whole purpose of the check.

This bug leads to the following Smatch static checker warning:

	drivers/infiniband/sw/siw/siw_cq.c:96 siw_reap_cqe()
	error: buffer overflow 'map_cqe_status' 10 <= 21

Fixes: bdf1da5df9da: ("RDMA/siw: Fix immediate work request flush to completion queue")
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw_cq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cq.c b/drivers/infiniband/sw/siw/siw_cq.c
index acc7bcd538b5..403029de6b92 100644
--- a/drivers/infiniband/sw/siw/siw_cq.c
+++ b/drivers/infiniband/sw/siw/siw_cq.c
@@ -88,9 +88,9 @@ int siw_reap_cqe(struct siw_cq *cq, struct ib_wc *wc)
 
 			if (opcode >= SIW_NUM_OPCODES) {
 				opcode = 0;
-				status = IB_WC_GENERAL_ERR;
+				status = SIW_WC_GENERAL_ERR;
 			} else if (status >= SIW_NUM_WC_STATUS) {
-				status = IB_WC_GENERAL_ERR;
+				status = SIW_WC_GENERAL_ERR;
 			}
 			wc->opcode = map_wc_opcode[opcode];
 			wc->status = map_cqe_status[status].ib;
-- 
2.32.0

