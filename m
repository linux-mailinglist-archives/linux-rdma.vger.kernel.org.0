Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA2DE2C559
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 13:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfE1LZC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 07:25:02 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:59054 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726476AbfE1LZB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 May 2019 07:25:01 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4SBOXVa027689;
        Tue, 28 May 2019 04:24:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=XkSfluNpVg4Ew5JlfUIU8GOOl1EJosBCNGV3lU+VbZw=;
 b=oKmE/MW1iAVZUh4cc/gFEs9B5YAC+f0lV9Cqka/XZfyfhNAKHZwL9UqhT9tZaUvfXbj3
 k67ol6sXqnPl+tJZv0CZhSQOMeXsmEnb72Bb4ZZuEbivBI8zlIs/Zb+5Ly1QBfIpECme
 FozHqBRn4lw3dU0P/k5cxRxQhf98QJ+uaTrhrKSwVGmvxceUjZ6M2U085eMRjwqIrgws
 pHs6pP4KYeswG/l5tgsIrmppjlgfnSF+DZjkUormwX5vJex62KXjUB9Ce1LeaezmJxv+
 uz1CyM3ASeAXIhQE4JVg6xOl08VUp1RNqzAufWmahFopPL5jCQl0FOSo6WGOHhnwCgQf +A== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2ss270ge5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 28 May 2019 04:24:55 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 28 May
 2019 04:24:54 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 28 May 2019 04:24:54 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 297DE3F703F;
        Tue, 28 May 2019 04:24:52 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <michal.kalderon@marvell.com>, <ariel.elior@marvell.com>,
        <jgg@zeipe.ca>, <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH v2 rdma-next 0/2] RDMA/qedr: Use the doorbell overflow recovery mechanism for RDMA
Date:   Tue, 28 May 2019 14:23:59 +0300
Message-ID: <20190528112401.14958-1-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_04:,,
 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch series used the doorbell overflow recovery mechanism
introduced in
commit 36907cd5cd72 ("qed: Add doorbell overflow recovery mechanism")
for rdma ( RoCE and iWARP )

rdma-core pull request #493

Changes from V1:
- call kmap to map virtual address into kernel space
- modify db_rec_delete to be void
- remove some cpu_to_le16 that were added to previous patch which are
  correct but not related to the overflow recovery mechanism. Will be
  submitted as part of a different patch


Michal Kalderon (2):
  RDMA/qedr: Add doorbell overflow recovery support
  RDMA/qedr: Add iWARP doorbell recovery support

 drivers/infiniband/hw/qedr/qedr.h  |  19 ++-
 drivers/infiniband/hw/qedr/verbs.c | 298 +++++++++++++++++++++++++++++++++----
 include/uapi/rdma/qedr-abi.h       |  15 ++
 3 files changed, 294 insertions(+), 38 deletions(-)

-- 
2.14.5

