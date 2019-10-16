Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EABED8DB6
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2019 12:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390413AbfJPKUK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Oct 2019 06:20:10 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:34008 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729634AbfJPKUJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Oct 2019 06:20:09 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9GAJZw5021110;
        Wed, 16 Oct 2019 03:19:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=Y+DgXwvWaCf+N3nYwMM3aJlPrBhdH9piOb3IEV26hGg=;
 b=S9lkO5pHu8Gtp2Hsz2yhnwYfFFRwXgU4pG6wa9OobdRYEU8iHl05CcHjLXSwS+wsRZ5C
 hPBAWVKqmS9o82G4h5KJxH1YKXdh2ZQW3ZtiClYFEW9WTU74XFxrBg31P0Kj/1+RplyC
 46U+8t/CoILyXOSy9MNn93WqpllmVFBafmZp+qNNpyBG6G8eUYlfkvqwgumfS1qU5k2r
 x942mbbj0RilTlDu0cu/CC9YwewWdXls5JRGaJnENN4IJh9K6QfGKZLDJjpSWPC/DvSm
 AurXv/4BlVanwn39VbXgmwH5yAg67/nQ90rXTlWNnHa704Qf3BYEPlWxdDob1AO0W6hg 0g== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vnpmbjch1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 03:19:55 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 16 Oct
 2019 03:19:54 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Wed, 16 Oct 2019 03:19:54 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 60C1F3F703F;
        Wed, 16 Oct 2019 03:19:52 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <michal.kalderon@marvell.com>, <ariel.elior@marvell.com>,
        <bharat@chelsio.com>, <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH] RDMA/core: Fix compatibility between driver and rdma-core
Date:   Wed, 16 Oct 2019 13:17:23 +0300
Message-ID: <20191016101723.8475-1-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_04:2019-10-16,2019-10-16 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit 30e0f6cf5acb39 ("RDMA/iw_cxgb3: Remove the iw_cxgb3 module from kernel")
deleted one of the entries in the rdma_driver_id enum. This
caused a mismatch between the driver-id of some drivers and rdma-core.

ib_uverbs_cmd_verbs: if (unlikely(hdr->driver_id != uapi->driver_id)

Added the entry back as deprecated to maintain compatibility between old/new
rdma-core and driver. For the same reason, entry should not be removed from
rdma-core, but modified to deprecated when cxgb3 is removed from rdma-core.

Fixes: 30e0f6cf5acb39 ("RDMA/iw_cxgb3: Remove the iw_cxgb3 module from kernel")
Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 include/uapi/rdma/rdma_user_ioctl_cmds.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/rdma/rdma_user_ioctl_cmds.h b/include/uapi/rdma/rdma_user_ioctl_cmds.h
index b2680051047a..07152a49374d 100644
--- a/include/uapi/rdma/rdma_user_ioctl_cmds.h
+++ b/include/uapi/rdma/rdma_user_ioctl_cmds.h
@@ -88,6 +88,7 @@ enum rdma_driver_id {
 	RDMA_DRIVER_UNKNOWN,
 	RDMA_DRIVER_MLX5,
 	RDMA_DRIVER_MLX4,
+	RDMA_DRIVER_CXGB3_DEPRECATED,
 	RDMA_DRIVER_CXGB4,
 	RDMA_DRIVER_MTHCA,
 	RDMA_DRIVER_BNXT_RE,
-- 
2.14.5

