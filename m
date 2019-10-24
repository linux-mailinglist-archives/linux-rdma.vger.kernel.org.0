Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE980E3A6F
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 19:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388235AbfJXRz3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 13:55:29 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:43332 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391414AbfJXRz3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Oct 2019 13:55:29 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9OHoEvD028330;
        Thu, 24 Oct 2019 10:55:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=TmqNdPhj2HOLkkAhtwNEIHm3J5ghB9SQz1+ZL95zfLA=;
 b=fXYYjZ1RAt431KKoHsXnKf32/eqh2sALKLJ1YdXcBLTdZz+ZKcMK1ZS3dg2bWRXSTUq8
 9Hbt49tNdr0nI50ecCIqsCoCRHqWCyGJQNmq8wHgoQXeV1ANMh8hz9Dg39kus2zkVBlG
 iizh2FK5C6mSANNLTdgcedaGCXICm8zSSmJQqBrEcHDS90uIJGfYylJxGSluR8l6ylFw
 IWXCNkiPzgImL9pvfs1ghxKrC4EC/YPt+PE3gfcwBdiGFy4HBHe1jsP0H4+AA9Fl30Ir
 2LSYEhKO1FwhC208XWoX/W3Q4IO5kB85yNcr4D+ISejrU75VjvFjrzuEdnkS/VZloL7+ uw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vt9ujrhh6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 24 Oct 2019 10:55:26 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 24 Oct
 2019 10:55:24 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 24 Oct 2019 10:55:24 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 03ED53F703F;
        Thu, 24 Oct 2019 10:55:22 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <michal.kalderon@marvell.com>, <aelior@marvell.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH v3 rdma-next 0/3] RDMA/qedr: Fix memory leaks and synchronization
Date:   Thu, 24 Oct 2019 20:52:50 +0300
Message-ID: <20191024175253.26816-1-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-24_10:2019-10-23,2019-10-24 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Several leaks and issues were found when running iWARP with kmemleak.
some apply to RoCE as well.

This series fixes some memory leaks and some wrong methods of
synchronization which were used to wait for iWARP CM related events.

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


Michal Kalderon (3):
  RDMA/qedr: Fix qpids xarray api used
  RDMA/qedr: Fix synchronization methods and memory leaks in qedr
  RDMA/qedr: Fix memory leak in user qp and mr

 drivers/infiniband/hw/qedr/main.c       |   1 -
 drivers/infiniband/hw/qedr/qedr.h       |  23 ++++-
 drivers/infiniband/hw/qedr/qedr_iw_cm.c | 148 +++++++++++++++++++++-----------
 drivers/infiniband/hw/qedr/verbs.c      |  76 ++++++++++------
 4 files changed, 169 insertions(+), 79 deletions(-)

-- 
2.14.5

