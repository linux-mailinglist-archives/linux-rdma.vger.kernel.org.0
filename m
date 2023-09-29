Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F20F7B3237
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Sep 2023 14:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjI2MQR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Sep 2023 08:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjI2MQQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Sep 2023 08:16:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D9F195;
        Fri, 29 Sep 2023 05:16:13 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TCF2TC028253;
        Fri, 29 Sep 2023 12:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : date : subject :
 content-type : message-id : to : cc : content-transfer-encoding :
 mime-version; s=pp1; bh=2IRrVsr0DBM7lCyy9w0jUUTswDVcoTvOjkfj0jpJkYk=;
 b=D4g/3HJ3p8CuXVNXmRFrDh7/RxiVpXrAGKkGxiYwqRIiUKvkTja1iuQy7dlwdUkKj8TN
 AuXMV+PQCahsVFD9yS5AKczhpdOlfS+Zp/Ls2MYWM5vFCMeQdj35ZqOS5zJwANhRHcXC
 PBmIuxb1uZf0EeufAYVWMke7ygJ0mvNxVHKHkgfAZzhmARvSdFeS1sRTtFm907993oJa
 MS1DN3HDStMVNDJyyw2RREQLr/eAi7nty7n1IUsJj865KQs4a1wWdjLI4lHFCcT7+a+c
 ZcKzZ8WBhwHwBcBV74bdsUXaqDSwfTmXwUhDHYa5Ebp1YwSJQEtnCYGZJvbQnX55CNMI SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdxdwg0ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 12:16:03 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38TCFtek029783;
        Fri, 29 Sep 2023 12:16:02 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdxdwg0a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 12:16:02 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38TC7an1008143;
        Fri, 29 Sep 2023 12:16:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3taar04qng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 12:16:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38TCFvcV19595776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 12:15:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B58020049;
        Fri, 29 Sep 2023 12:15:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FF0720040;
        Fri, 29 Sep 2023 12:15:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 29 Sep 2023 12:15:57 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Date:   Fri, 29 Sep 2023 14:15:49 +0200
Subject: [PATCH net v2] net/mlx5: fix calling mlx5_cmd_init() before DMA
 mask is set
Content-Type: text/plain; charset="utf-8"
Message-Id: <20230929-mlx5_init_fix-v2-1-51ed2094c9d8@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAPS/FmUC/3WNQQ6DIBREr2L+uhhB0NpV79EYo/Bbf6LQgDU2h
 ruXsO9y3mTenBDQEwa4FSd43CmQsymISwF6Hu0LGZmUQVSirjpxZetyqIEsbcOTDqZloyalzVi
 LFtLm7THh7HuAxQ36BGcKm/Pf/LHzXP3R7Zxx1nat7IxUGpvqvpD9HCVNa6ndCn2M8QfHhSkrs
 wAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4032;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=5PX7RQ4rZ7LlMi7ZlrKUxPE33H86Uqi+IiNl4ZDaUdE=;
 b=owGbwMvMwCH2Wz534YHOJ2GMp9WSGFLF9n/jXXbiZcbnfbsDj22W2nb3rPSOfP1e88MNbcK3O
 s7JWwQ4d5SyMIhxMMiKKbIs6nL2W1cwxXRPUH8HzBxWJpAhDFycAjCRgP8M/7QW2RybHuOqfZJN
 UC4zwZQ/56go/4TtR57d3v/c/tbVll2MDJP+rptjcYXDYaVrxJQPUgZTxOfEKQb8Ff5lLymx9KH
 DfCYA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NJICd51ebao6KTLOS6Bx8Xhrjqs8ALjT
X-Proofpoint-GUID: PhCP7YajQx6e9A1DV-mnWaG9_FLr3mlF
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_10,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290103
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
enforces DMA masks.

Fix this by moving set_dma_caps() out of mlx5_pci_init() and into
probe_one() before mlx5_mdev_init(). To match the overall naming scheme
rename it to mlx5_dma_init().

Link: https://lore.kernel.org/linux-iommu/cfc9e9128ed5571d2e36421e347301057662a09e.camel@linux.ibm.com/
Fixes: 06cd555f73ca ("net/mlx5: split mlx5_cmd_init() to probe and reload routines")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Note: I ran into this while testing the linked series for converting
s390x to use dma-iommu. The existing s390x specific DMA API
implementation doesn't respect DMA masks and is thus not affected
despite of course also only supporting DMA addresses above 4 GiB.
---
Changes in v2:
- Instead of moving the whole mlx5_pci_init() only move the
  set_dma_caps() call so as to keep pci_enable_device() after the FW
  command interface initialization (Leon)
- Link to v1: https://lore.kernel.org/r/20230928-mlx5_init_fix-v1-1-79749d45ce60@linux.ibm.com
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 15561965d2af..f251d233a16c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -250,7 +250,7 @@ static void mlx5_set_driver_version(struct mlx5_core_dev *dev)
 	mlx5_cmd_exec_in(dev, set_driver_version, in);
 }
 
-static int set_dma_caps(struct pci_dev *pdev)
+static int mlx5_dma_init(struct pci_dev *pdev)
 {
 	int err;
 
@@ -905,12 +905,6 @@ static int mlx5_pci_init(struct mlx5_core_dev *dev, struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	err = set_dma_caps(pdev);
-	if (err) {
-		mlx5_core_err(dev, "Failed setting DMA capabilities mask, aborting\n");
-		goto err_clr_master;
-	}
-
 	if (pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP32) &&
 	    pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP64) &&
 	    pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP128))
@@ -1908,9 +1902,15 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto adev_init_err;
 	}
 
+	err = mlx5_dma_init(pdev);
+	if (err) {
+		mlx5_core_err(dev, "Failed setting DMA capabilities mask, aborting\n");
+		goto dma_init_err;
+	}
+
 	err = mlx5_mdev_init(dev, prof_sel);
 	if (err)
-		goto mdev_init_err;
+		goto dma_init_err;
 
 	err = mlx5_pci_init(dev, pdev, id);
 	if (err) {
@@ -1942,7 +1942,7 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	mlx5_pci_close(dev);
 pci_init_err:
 	mlx5_mdev_uninit(dev);
-mdev_init_err:
+dma_init_err:
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

