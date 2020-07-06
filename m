Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55DE215D2D
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 19:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgGFR2e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 13:28:34 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:39244 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729620AbgGFR2e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 13:28:34 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 066H9wN3002224;
        Mon, 6 Jul 2020 10:28:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=DO8WMLmdU3FH5Lis2zQcrvBcibBhFbOqIi5bWCz1FpI=;
 b=PvJm9T8LMn/0uEs8XzkGuMKkgWPrJmJYl3yF1BHv6nHX+4/QOWHMzvlVJJpFKfUfFKUd
 8sANOVdhChKI/6O3NOZ+XRYN9QhVnqd82Xg7E7FZFFXiHdvY7FDbZeE9+a3dpF2V/ptS
 af896fC7wSL3CdyUrXkY4L3c7YDKnJLagMIZ4qE9ToZaUPP9afKJ7IfTAQ0+oy4sKbYi
 KQs/RTrDG1d7TIH/l2rwkWqK4C0ZXnERo9Ra8Nq0BnkCc1pNI+H87F4mQOU5JeLYaS+y
 B3CB0SoMi84aEkKLcEwLtcUZELiIdkPcIxeA6ru4iWA6I1nEVk7CzPrrHYVscIs8cKMD MA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 322q4pr24b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 10:28:32 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 6 Jul
 2020 10:28:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 6 Jul 2020 10:28:31 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id AE0523F703F;
        Mon,  6 Jul 2020 10:28:29 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <jgg@ziepe.ca>, <dledford@redhat.com>, <aelior@marvell.com>,
        <ybason@marvell.com>, <mkalderon@marvell.com>
CC:     <linux-rdma@vger.kernel.org>,
        Michal Kalderon <michal.kalderon@marvell.com>
Subject: [PATCH rdma-next 0/2] RDMA/qedr: Add EDPM kernel-user flags for feature compatibility
Date:   Mon, 6 Jul 2020 20:28:15 +0300
Message-ID: <20200706172817.14503-1-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_15:2020-07-06,2020-07-06 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The two patches in this series are related to the EDPM feature.
EDPM is a hw feature for improving latency under certain conditions.

Related rdma-core pull request #786
https://github.com/linux-rdma/rdma-core/pull/786

Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>

Michal Kalderon (2):
  RDMA/qedr: Add EDPM mode type for user-fw compatibility
  RDMA/qedr: Add EDPM max size to alloc ucontext response

 drivers/infiniband/hw/qedr/qedr.h  |  1 +
 drivers/infiniband/hw/qedr/verbs.c | 20 ++++++++++++++------
 include/uapi/rdma/qedr-abi.h       |  9 ++++++---
 3 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.14.5

