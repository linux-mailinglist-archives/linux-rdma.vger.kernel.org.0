Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55E31D8FD5
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2019 13:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbfJPLpQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Oct 2019 07:45:16 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:55040 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728342AbfJPLpQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Oct 2019 07:45:16 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9GBjBTB022516;
        Wed, 16 Oct 2019 04:45:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=gMCMZzL7JJZ/wCi89wehGGL4w5UIWa8zoGDO9C62HeQ=;
 b=IFULsBI+WXxZ5en1V/VLl1xsEfqOBfQANz4s417XMk46xulnNwcmCcHJGyve6TXTwA+Y
 RU9hZs5L5dh6WSAP3eZlIV5mPhUG65sgUQaBcSbf6jjCk2qBCymAUaq4FBA8x5yc4pbc
 UvHYHjXCcC94lnDHjrEt34kfc2ynL5H3sGCXC0yU42xR/ASIu2EfIVbXNrSzmGBqtLTc
 VsLqV+nUsrTt+iJWG0c1I3djA7+2RNup+l5CMacFQIx63row807fiZoaZUVk6sEO3ZPA
 00lG/3GT8tFON1yhzdS37hi6lPGtVOk7+GFPBj4FLcnMsjo35sIitgP7DPScSvwdGJ5p lQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vkebp6a24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 04:45:11 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 16 Oct
 2019 04:45:05 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Wed, 16 Oct 2019 04:45:05 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 1BE6C3F703F;
        Wed, 16 Oct 2019 04:45:03 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <michal.kalderon@marvell.com>, <aelior@marvell.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH v2 rdma-next 0/2] RDMA/qedr: Fix memory leaks and synchronization
Date:   Wed, 16 Oct 2019 14:42:40 +0300
Message-ID: <20191016114242.10736-1-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_04:2019-10-16,2019-10-16 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Several leaks and issues were found when running iWARP with kmemleak.
some apply to RoCE as well.

This series fixes some memory leaks and some wrong methods of
synchronization which were used to wait for iWARP CM related events.

Changes from v1
---------------
- When removing the qp from the xarray xa_erase should be used and
  not xa_erase_irq as this can't be called from irq context.

- Add xa_lock around loading a qp from the xarray and increase the
  refcnt only under the xa_lock and only if not zero. This is to make
  qedr more robust and not rely on the core/iwcm implementation to
  assure correctness.

- Complete the iwarp_cm_comp event only if the bit was turned on and
  the destroy qp flow will attempt to look at the completion.

Michal Kalderon (2):
  RDMA/qedr: Fix synchronization methods and memory leaks in qedr
  RDMA/qedr: Fix memory leak in user qp and mr

 drivers/infiniband/hw/qedr/qedr.h       |  23 ++++-
 drivers/infiniband/hw/qedr/qedr_iw_cm.c | 150 ++++++++++++++++++++++----------
 drivers/infiniband/hw/qedr/verbs.c      |  54 +++++++-----
 3 files changed, 151 insertions(+), 76 deletions(-)

-- 
2.14.5

