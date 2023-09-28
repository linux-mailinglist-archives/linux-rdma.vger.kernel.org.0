Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAE57B1F06
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Sep 2023 15:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjI1N4M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Sep 2023 09:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjI1N4L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Sep 2023 09:56:11 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD42D19C;
        Thu, 28 Sep 2023 06:56:09 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SDdwE9011105;
        Thu, 28 Sep 2023 13:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : date : subject :
 content-type : message-id : to : cc : content-transfer-encoding :
 mime-version; s=pp1; bh=7YWFzEl6wImcRaco2nBjK1nY0Gsj359awacK8TSbAyA=;
 b=e6E4J1FpGW/MttKb29T1JSpGhF2ggZ9gQSDNloR+QlaIYWRNLkCq1Mq8rX1WVQ5qv5uy
 Ea3P0hXSTi/p2nRMrleT3un9rTne0tYHRvIj3ZGEboOy+BQDc9qE7mRlDiFMqtM7TpJW
 P1W7gma2L1YVXGF6nn9J7zgEy8dTAruHMgv9gIt/RPMUnx37DFGELF+gcR8axDh1Jimz
 UBQBTq/MRnXI/e2aBwk5pRTwX+l/Jbbu7VIRJdH14WGHSGeAnnlJcW2W+p+2W9ZmrOp9
 /OzMvUKJ25lNrj5CNV5g6q2B33OBTiVklpnETCJKy68Y21RYtihT4bXY9O57s2AEP0eg sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3td7p0dyjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 13:55:59 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38SDk8IP029613;
        Thu, 28 Sep 2023 13:55:58 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3td7p0dyhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 13:55:58 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38SCB6xK030392;
        Thu, 28 Sep 2023 13:55:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tad224ada-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 13:55:57 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38SDtsuJ23331528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 13:55:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC9BE20043;
        Thu, 28 Sep 2023 13:55:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 519AA20040;
        Thu, 28 Sep 2023 13:55:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 28 Sep 2023 13:55:54 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Date:   Thu, 28 Sep 2023 15:55:47 +0200
Subject: [PATCH net] net/mlx5: fix calling mlx5_cmd_init() before DMA mask
 is set
Content-Type: text/plain; charset="utf-8"
Message-Id: <20230928-mlx5_init_fix-v1-1-79749d45ce60@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAOKFFWUC/x2MWwqAIBAArxL7nVCava4SEWZbLZSFRgji3ZM+Z
 2AmgENL6KDPAlh8ydFlEpR5BnpXZkNGS2LgBRdFx1t2Hl5OZOiZVvJMV7WcpV6U4A2k5raY9P8
 bwOADY4wfaNspNGQAAAA=
To:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shay Drory <shayd@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3327;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=NA7Oh67Tj0uc/EsbJ3FQ2S/ba9LUghLw/dRgo0jeWNE=;
 b=owGbwMvMwCH2Wz534YHOJ2GMp9WSGFJFWx/Pza6bdlMq2PHDXJEflSIWKXwWCRc23EtJmsiuH
 Kj799XrjlIWBjEOBlkxRZZFXc5+6wqmmO4J6u+AmcPKBDKEgYtTACbieZ2R4VxtissJ/7V8/zaL
 MMxOVj8nq3x1S32d75En73+nXg/LVmL4Z/WX96/hpttTTP4qH+V/cv6KsfvSAKE4vaLpysxxOzO
 NeQA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BXkdPTVzkiYOcaO5cXp72ZMrpllRU6ip
X-Proofpoint-ORIG-GUID: leOd-UmwHl-uRqBXxwxdgs7m0aK8DaEw
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_13,2023-09-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1011
 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309280117
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since commit 06cd555f73ca ("net/mlx5: split mlx5_cmd_init() to probe and
reload routines") mlx5_cmd_init() is called in mlx5_mdev_init() which is
called in probe_one() before mlx5_pci_init(). This is a problem because
mlx5_pci_init() is where the DMA and coherent mask is set but
mlx5_cmd_init() already does a dma_alloc_coherent(). Thus a DMA
allocation is done during probe before the correct mask is set. This
causes probe to fail initialization of the cmdif SW structs on s390x
after that is converted to the common dma-iommu code. This is because on
s390x DMA addresses below 4 GiB are reserved on current machines and
unlike the old s390x specific DMA API implementation common code
enforces DMA masks. Fix this by switching the order of the
mlx5_mdev_init() and mlx5_pci_init() in probe_one().

Link: https://lore.kernel.org/linux-iommu/cfc9e9128ed5571d2e36421e347301057662a09e.camel@linux.ibm.com/
Fixes: 06cd555f73ca ("net/mlx5: split mlx5_cmd_init() to probe and reload routines")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Note: I ran into this while testing the linked series for converting
s390x to use dma-iommu. The existing s390x specific DMA API
implementation doesn't respect DMA masks and is thus not affected
despite of course also only supporting DMA addresses above 4 GiB.
That said ConnectX VFs are the primary users of native PCI on s390x and
we'd really like to get the DMA API conversion into v6.7 so this has
high priority for us.
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 15561965d2af..06744dedd928 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1908,10 +1908,6 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto adev_init_err;
 	}
 
-	err = mlx5_mdev_init(dev, prof_sel);
-	if (err)
-		goto mdev_init_err;
-
 	err = mlx5_pci_init(dev, pdev, id);
 	if (err) {
 		mlx5_core_err(dev, "mlx5_pci_init failed with error code %d\n",
@@ -1919,6 +1915,10 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto pci_init_err;
 	}
 
+	err = mlx5_mdev_init(dev, prof_sel);
+	if (err)
+		goto mdev_init_err;
+
 	err = mlx5_init_one(dev);
 	if (err) {
 		mlx5_core_err(dev, "mlx5_init_one failed with error code %d\n",
@@ -1939,10 +1939,10 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_init_one:
-	mlx5_pci_close(dev);
-pci_init_err:
 	mlx5_mdev_uninit(dev);
 mdev_init_err:
+	mlx5_pci_close(dev);
+pci_init_err:
 	mlx5_adev_idx_free(dev->priv.adev_idx);
 adev_init_err:
 	mlx5_devlink_free(devlink);

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230928-mlx5_init_fix-c465b5cda327

Best regards,
-- 
Niklas Schnelle
Linux on Z Development

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement - https://www.ibm.com/privacy 

