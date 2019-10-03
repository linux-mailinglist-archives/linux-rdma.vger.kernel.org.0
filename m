Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94C32C9E04
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 14:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfJCMGP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 08:06:15 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:4864 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726523AbfJCMGP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Oct 2019 08:06:15 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x93BoUYP024255;
        Thu, 3 Oct 2019 05:06:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=M2xdveTo+piTvTxt8XyiViy4EYvUc2Em2gsF7LVH/PY=;
 b=pKBCrXbr2FlGzl1dAiJ0Axh66/oy+N5lAS3D+tfu21Q76yeBoTKEIC6nt/y0Khu6LI1D
 +XsdPqdezZJOSKRkNTuxIxadV/GiQfViwHaviUEOb7Eoqidy3IkDf2oLM8HtmUaeZCmj
 V1EKalBbFyFzzJDaBmmrz2wCsaxUAN/tlTsp+dOe/jOADKUA+LgoUEquIZowxv3+VwDz
 wHhJrC+s55FcnrOQwtBfjug+/tKl5bLmiZd/A6oEcbpxWwj9/y1TkV8VGzwI+/6h/X1z
 4Knv9YtH3iK4dh0Seyg6z0slDz3978oFZemYJjug5Vtd5gEi7XXfjHz4DihtU9A78spK xg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vd0ya36t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 03 Oct 2019 05:06:06 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 3 Oct
 2019 05:06:04 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 3 Oct 2019 05:06:04 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id E965D3F7043;
        Thu,  3 Oct 2019 05:06:02 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <michal.kalderon@marvell.com>, <aelior@marvell.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 0/2] RDMA/qedr: Fix memory leaks and synchronization
Date:   Thu, 3 Oct 2019 15:03:40 +0300
Message-ID: <20191003120342.16926-1-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-03_05:2019-10-03,2019-10-03 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Several leaks and issues were found when running iWARP with kmemleak.
some apply to RoCE as well.

This series fixes some memory leaks and some wrong methods of
synchronization which were used to wait for iWARP CM related events.

Michal Kalderon (2):
  RDMA/qedr: Fix synchronization methods and memory leaks in qedr
  RDMA/qedr: Fix memory leak in user qp and mr

 drivers/infiniband/hw/qedr/qedr.h       |  23 ++++--
 drivers/infiniband/hw/qedr/qedr_iw_cm.c | 120 +++++++++++++++++++++-----------
 drivers/infiniband/hw/qedr/verbs.c      |  54 +++++++-------
 3 files changed, 128 insertions(+), 69 deletions(-)

-- 
2.14.5

