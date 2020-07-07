Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDF7216660
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 08:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgGGGbH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 02:31:07 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:63214 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726540AbgGGGbH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 02:31:07 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0676UidO029290;
        Mon, 6 Jul 2020 23:31:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=exRf3xJGb0LRuccceXLh+OGhnlV0+GwJczi1v0M3VLM=;
 b=DdLJ5l41V6yiPIz4FQyDCPrEPszkxSF3BWdCl15IUp8GUrX5MMPGDYi9eF+2Ac0hMY3H
 VVJ+p6EEttx4cYVyg+wlk4uBCVre6wThEHpJ++xeftVgN5rhcm4oq3GpDvmvxtXFni1q
 0+Hxb2s7JJXxXNE/3b4CV+URZxCU6OE9Q9YGO7id4CKv2t7nRsfHUq221xOewMVQs7+x
 l+qxOGMxYrGo0BAlPpAAHaBGsIdJzUbbzPo+r+hFc8w9Rl7BBFRl1R2yO/N/cllpygQN
 QA0s/ade5f6QZrnqokgo0MgGvwldigI0CL8tpjVBOBFVZ1QD33zAvjV/jo2wDI4HC5Pb RQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 322s9n9pmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 23:31:04 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 6 Jul
 2020 23:31:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 6 Jul 2020 23:31:03 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id A562B3F7040;
        Mon,  6 Jul 2020 23:31:01 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <jgg@ziepe.ca>, <dledford@redhat.com>, <aelior@marvell.com>,
        <ybason@marvell.com>, <mkalderon@marvell.com>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH v3 rdma-next 0/2] RDMA/qedr: Add EDPM kernel-user flags for feature compatibility
Date:   Tue, 7 Jul 2020 09:30:58 +0300
Message-ID: <20200707063100.3811-1-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_05:2020-07-07,2020-07-07 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The two patches in this series are related to the EDPM feature.
EDPM is a hw feature for improving latency under certain conditions.

Related rdma-core pull request #786
https://github.com/linux-rdma/rdma-core/pull/786

Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>

Changes from v2
Remove mis-use of !! when checking if a flag is set.

Changes from v1
Add explicit padding to struct qedr_alloc_ucontext_resp in qedr-abi.h

Michal Kalderon (2):
  RDMA/qedr: Add EDPM mode type for user-fw compatibility
  RDMA/qedr: Add EDPM max size to alloc ucontext response

 drivers/infiniband/hw/qedr/qedr.h  |  1 +
 drivers/infiniband/hw/qedr/verbs.c | 20 ++++++++++++++------
 include/uapi/rdma/qedr-abi.h       | 10 +++++++---
 3 files changed, 22 insertions(+), 9 deletions(-)

-- 
2.14.5

