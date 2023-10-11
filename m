Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E677C4C6D
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Oct 2023 09:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjJKH6D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Oct 2023 03:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJKH6C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Oct 2023 03:58:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2873F91;
        Wed, 11 Oct 2023 00:58:01 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B7vZnq027168;
        Wed, 11 Oct 2023 07:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : date : subject :
 content-type : message-id : to : cc : content-transfer-encoding :
 mime-version; s=pp1; bh=+Nh+ttaIlUVnlNuQdKZMcQ5FWauLUpkU6fMAGytoJds=;
 b=j7DqAfo0xor59I2htFF3DcLs60Qnewu5gu7tytRoBYhTWRlbJ5Of0iA2mkgefCBMbVGj
 /qaO/NJUZZ4gDiTNq8TwnP4GeN87hQSScOPNUKxzkha5drEMUKL3MkTb01mM/84S5ygp
 Dat9fgdHsK0OWfESORHYxa2t6V0w4nPTyed+IFhWhtmGPlr3JPWOQPK5Kpc794Qohn5M
 kEx9uLjoz5Bf6D46RiVFIun4Q2h6+PufaW/PoST5MTfL7J4o6OE5Gh6kQdFLoXj+HdMC
 uqQhG1L2DrPCjGfc7SgibEOPtfISz26FwlgFYV07Ud1WYbvd9tYQcZ0V01AJAk5FBryt 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnqs40077-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 07:57:50 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39B7vZYj027159;
        Wed, 11 Oct 2023 07:57:50 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnqs4006v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 07:57:49 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39B7XOis024458;
        Wed, 11 Oct 2023 07:57:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkhnspwqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 07:57:48 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39B7vkYl44565194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 07:57:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE93E20043;
        Wed, 11 Oct 2023 07:57:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F5AB20040;
        Wed, 11 Oct 2023 07:57:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 11 Oct 2023 07:57:45 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Date:   Wed, 11 Oct 2023 09:57:38 +0200
Subject: [PATCH net v3] net/mlx5: fix calling mlx5_cmd_init() before DMA
 mask is set
Content-Type: text/plain; charset="utf-8"
Message-Id: <20231011-mlx5_init_fix-v3-1-787ffb9183c6@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAHFVJmUC/3XN0QqDIBQG4FcJr2eoaeWu9h5jROnZOrBsaJNG9
 O4Tr0awy/8//N/ZSACPEMi52IiHiAFnl0J1KogZe/cAijZlIpiomBYtnZ6r6tDh0t1xpUbWalD
 G9pVoSNq8PKQ6e1fiYCG3VI4Yltl/8o/I8+kPFznltNGN1FYqAzW7PNG91xKHqTTzlLUofgV9F
 EQSFAcrmJZG2/Yo7Pv+BbgqfYf1AAAA
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
        Jacob Keller <jacob.e.keller@intel.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Leon Romanovsky <leon@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3636;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=s4vuRbe1ctTn2sX8uQsBeRCDfvcgXhkrwsTDFdyTJEc=;
 b=owGbwMvMwCH2Wz534YHOJ2GMp9WSGFLVQotOqvYpbb5vnW8vZjv72Mb9Et7BRWwRXyY/fp/Zz
 iT999W8jlIWBjEOBlkxRZZFXc5+6wqmmO4J6u+AmcPKBDKEgYtTACby0Izhr0DtVN2L530+rM/a
 MPeRy23GvMZHH+S8v+v6Ca98vXvP+hkMfyWmPtDIyNzdznbn11vlzVr/jGTlTQUufJFJ+73wxL7
 0szwA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3JCCzQyui7zKBQUbndel4jsSrX-48M9N
X-Proofpoint-GUID: uvKxe_HwHqSYX_Vf6ALqULCM6UY1N_Bh
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_05,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110069
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
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Note: I ran into this while testing the linked series for converting
s390x to use dma-iommu. The existing s390x specific DMA API
implementation doesn't respect DMA masks and is thus not affected.
---
Changes in v3:
- Added R-b's from Leon R and Jacob K
- Link to v2: https://lore.kernel.org/r/20230929-mlx5_init_fix-v2-1-51ed2094c9d8@linux.ibm.com
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
base-commit: 94f6f0550c625fab1f373bb86a6669b45e9748b3
change-id: 20230928-mlx5_init_fix-c465b5cda327

Best regards,
-- 
Niklas Schnelle

