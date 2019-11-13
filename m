Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C545FFB3CE
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2019 16:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfKMPh1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Nov 2019 10:37:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726335AbfKMPh1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Nov 2019 10:37:27 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADFbIYA082943
        for <linux-rdma@vger.kernel.org>; Wed, 13 Nov 2019 10:37:26 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w8m7vrthp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 13 Nov 2019 10:37:23 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Wed, 13 Nov 2019 15:34:21 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Nov 2019 15:34:19 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xADFYIQx49152136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 15:34:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C52CAE051;
        Wed, 13 Nov 2019 15:34:18 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE8C6AE059;
        Wed, 13 Nov 2019 15:34:17 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.152])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Nov 2019 15:34:17 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     michal.kalderon@marvell.com, jgg@ziepe.ca,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH for-next] RDMA/siw: Cleanup unused mmap structures.
Date:   Wed, 13 Nov 2019 16:34:04 +0100
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19111315-0016-0000-0000-000002C35629
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111315-0017-0000-0000-00003324F2F2
Message-Id: <20191113153404.7402-1-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-13_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=737 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911130142
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Removes obsolete driver specific mmap information after
generalization of RDMA driver mmap service. Also removes
useless forward declaration of struct siw_mr.

Fixes: 11f1a75567c4 ("RDMA/siw: Use the common mmap_xa helpers")
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw.h       | 11 -----------
 drivers/infiniband/sw/siw/siw_verbs.c |  2 --
 2 files changed, 13 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index f851afb5632e..b939f489cd46 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -99,18 +99,9 @@ struct siw_device {
 	struct work_struct netdev_down;
 };
 
-struct siw_uobj {
-	void *addr;
-	u32 size;
-};
-
 struct siw_ucontext {
 	struct ib_ucontext base_ucontext;
 	struct siw_device *sdev;
-
-	/* xarray of user mappable objects */
-	struct xarray xa;
-	u32 uobj_nextkey;
 };
 
 /*
@@ -150,8 +141,6 @@ struct siw_pbl {
 	struct siw_pble pbe[1];
 };
 
-struct siw_mr;
-
 /*
  * Generic memory representation for registered siw memory.
  * Memory lookup always via higher 24 bit of STag (STag index).
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 725985ed8af3..c992dd7299d9 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -87,8 +87,6 @@ int siw_alloc_ucontext(struct ib_ucontext *base_ctx, struct ib_udata *udata)
 		rv = -ENOMEM;
 		goto err_out;
 	}
-
-	ctx->uobj_nextkey = 0;
 	ctx->sdev = sdev;
 
 	uresp.dev_id = sdev->vendor_part_id;
-- 
2.17.2

