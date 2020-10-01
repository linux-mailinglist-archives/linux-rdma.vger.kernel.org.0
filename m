Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A086B27FCFA
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 12:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbgJAKLR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 06:11:17 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:52638 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726992AbgJAKLR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Oct 2020 06:11:17 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 091A5EGW027050;
        Thu, 1 Oct 2020 03:11:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=5WRmCkqRn2ohXJeMVv1pO1koOqxu6gbCJ60vYqd1c28=;
 b=f3BSl7uLV5mEuDzoWxi2z8UF6OBsAbqdGOc8JdZLHw9/EBnSJKvRe7HyUWr+G65N1YwF
 m7SQGFWm073FxkeWW6RDy6ntOAwEEiOvVw4yV3cpmygvXTZGhUTnHALUI5eZwOJGiKJx
 xXSPydzpvmzP3CNqdZm8/1Nj61+KXIRY2hAD+3hH97vWk75VWEv0CnsAuODNg1/u80vo
 PyKT1FVkKDAanK1ycOoHLTmklaWLRaCkheRbKR0G1mcb0nB8uwKRcI1xZPumgTjUnpY+
 drHj+SBa9EpAiG0oU6rFXj9YAG8V0pi2DjKqeMSkzhltO3VNU0r+xZkSbfYam2YWD7pv jg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 33t55pdyvx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 01 Oct 2020 03:11:15 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 1 Oct
 2020 03:11:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 1 Oct 2020 03:11:13 -0700
Received: from alpha-dell-r720.punelab.qlogic.com032qlogic.org032qlogic.com032mv.qlogic.com032av.na (unknown [10.30.45.91])
        by maili.marvell.com (Postfix) with ESMTP id A4F6B3F7040;
        Thu,  1 Oct 2020 03:11:11 -0700 (PDT)
From:   Alok Prasad <palok@marvell.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <palok@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Michal Kalderon <mkalderon@marvell.com>
Subject: [PATCH rdma-next] RDMA/qedr: endianness warnings cleanup
Date:   Thu, 1 Oct 2020 10:09:59 +0000
Message-ID: <20201001100959.19940-1-palok@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_03:2020-10-01,2020-10-01 signatures=0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Making a change to fix following sparse warnings
reported by kbuild bot.

 CHECK   drivers/infiniband/hw/qedr/verbs.c

drivers/infiniband/hw/qedr/verbs.c:3872:59: warning: incorrect type in assignment (different base types)
drivers/infiniband/hw/qedr/verbs.c:3872:59:    expected restricted __le32 [usertype] sge_prod
drivers/infiniband/hw/qedr/verbs.c:3872:59:    got unsigned int [usertype] sge_prod
drivers/infiniband/hw/qedr/verbs.c:3875:59: warning: incorrect type in assignment (different base types)
drivers/infiniband/hw/qedr/verbs.c:3875:59:    expected restricted __le32 [usertype] wqe_prod
drivers/infiniband/hw/qedr/verbs.c:3875:59:    got unsigned int [usertype] wqe_prod

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: acca72e2b031 ("RDMA/qedr: SRQ's bug fixes")
Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Alok Prasad <palok@marvell.com>
---
 drivers/infiniband/hw/qedr/verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index da42cc70e372..2fd498002188 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -3869,10 +3869,10 @@ int qedr_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 		 * in first 4 bytes and need to update WQE producer in
 		 * next 4 bytes.
 		 */
-		srq->hw_srq.virt_prod_pair_addr->sge_prod = hw_srq->sge_prod;
+		srq->hw_srq.virt_prod_pair_addr->sge_prod = cpu_to_le32(hw_srq->sge_prod);
 		/* Make sure sge producer is updated first */
 		dma_wmb();
-		srq->hw_srq.virt_prod_pair_addr->wqe_prod = hw_srq->wqe_prod;
+		srq->hw_srq.virt_prod_pair_addr->wqe_prod = cpu_to_le32(hw_srq->wqe_prod);
 
 		wr = wr->next;
 	}
-- 
2.17.1

