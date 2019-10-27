Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBA7CE653D
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 21:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfJ0UHU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 16:07:20 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:34406 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727235AbfJ0UHU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 16:07:20 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9RK5QqF011432;
        Sun, 27 Oct 2019 13:07:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=TywjLq3Dh86ugHIevW/DGZpGA0Z5UAprnBTXTiQyusU=;
 b=pjW/bhVQiK/5h9ZZpkgPHFctdJvgQL1z95sDpXrgXmAujZwQ6jPFzz/UC0oRfFoQSb5W
 98RjVKhfaDUjdFR2pTja/cGFCbFjKBkb9XoZU3pfJye6kZVIiKyyQ6h1Xfb6c1DMGWkW
 vUSuIn60+YzKtpsB6njeCuk56C81LXBJXuT1g4DUSSWhDGh1l5HMmdlfXrK5F58ChRtW
 sRblznYlo9+s0UJbxFh2wXTPd2nPOJjLl47e+yTzNhEfK7kUSo+9/ADnM+QCxIN6ZYsQ
 5rIJ0JzTSg8iCzYHnuGVnExG27WxgUWtT5pCvdvuKpyyhFD4c9Ddxb3TcXGpczaMWWzr pw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vvkgq3qc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 27 Oct 2019 13:07:16 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 27 Oct
 2019 13:07:15 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Sun, 27 Oct 2019 13:07:15 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 0F36A3F7040;
        Sun, 27 Oct 2019 13:07:13 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <michal.kalderon@marvell.com>, <ariel.elior@marvell.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH v4 rdma-next 0/4] RDMA/qedr: Fix memory leaks and synchronization
Date:   Sun, 27 Oct 2019 22:04:47 +0200
Message-ID: <20191027200451.28187-1-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-27_08:2019-10-25,2019-10-27 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Several leaks and issues were found when running iWARP with kmemleak.
some apply to RoCE as well.

This series fixes some memory leaks and some wrong methods of
synchronization which were used to wait for iWARP CM related events.

Changes from V3
---------------
- call xa_init for the qpids xarray.
- add another patch that calls xa_init_flags for srqs xarray.

Changes from V2
---------------
- Add a new separate patch that fixes the xarray api that was used
  for the qps xarray, there was no need to use the _irq version of
  the api.

- Move xa_erase of qp_id to be right before the qp resources are
  released. This fixes a race where the qp-id can be reassigned
  before removed from the xarray.

- Modify places that call kref_get_unless_zero to kref_get since we
  already hold a valid pointer.

- Comment about the usage of the same completion structure for two
  different completions.

- Add Fixes tag

Changes from v1
---------------
- When removing the qp from the xarray xa_erase should be used and
  not xa_erase_irq as this can't be called from irq context.

- Add xa_lock around loading a qp from the xarray and increase the
  refcnt only under the xa_lock and only if not zero. This is to make
  qedr more robust and not rely on the core/iwcm implementation to
  assure correctness.

- Complete the iwarp_cm_comp event only if the bit was turned on and
  the destroy qp flow will attempt to look at the completion


Michal Kalderon (4):
  RDMA/qedr: Fix srqs xarray initialization
  RDMA/qedr: Fix qpids xarray api used
  RDMA/qedr: Fix synchronization methods and memory leaks in qedr
  RDMA/qedr: Fix memory leak in user qp and mr

 drivers/infiniband/hw/qedr/main.c       |   3 +-
 drivers/infiniband/hw/qedr/qedr.h       |  23 ++++-
 drivers/infiniband/hw/qedr/qedr_iw_cm.c | 148 +++++++++++++++++++++-----------
 drivers/infiniband/hw/qedr/verbs.c      |  76 ++++++++++------
 4 files changed, 171 insertions(+), 79 deletions(-)

-- 
2.14.5

