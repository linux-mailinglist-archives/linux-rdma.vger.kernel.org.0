Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5D21A95EC
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 10:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635659AbgDOIOo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Apr 2020 04:14:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2324 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2635597AbgDOIOo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Apr 2020 04:14:44 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 229BE114408F65C19B54;
        Wed, 15 Apr 2020 16:14:41 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Wed, 15 Apr 2020 16:14:34 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 0/6] RDMA/hns: Codes optimization
Date:   Wed, 15 Apr 2020 16:14:29 +0800
Message-ID: <1586938475-37049-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series optimize some codes in hns drivers. The first two patches are
mainly to remove unnecessary memset(), and the others use map table to
simplify the conversion of values.

Previous version can be found at:
https://patchwork.kernel.org/cover/11485099/

Changes since v1:
- Fix comments from Jason that the arrays should be defined in type of
  "static const" in patch #3 ~ #6.

Lang Cheng (4):
  RDMA/hns: Simplify the qp state convert code
  RDMA/hns: Simplify the cqe code of poll cq
  RDMA/hns: Simplify the state judgment code of qp
  RDMA/hns: Simplify the status judgment code of hns_roce_v1_m_qp()

Lijun Ou (2):
  RDMA/hns: Optimize hns_roce_config_link_table()
  RDMA/hns: Optimize hns_roce_v2_set_mac()

 drivers/infiniband/hw/hns/hns_roce_hw_v1.c |  42 +++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 269 +++++++++++++----------------
 2 files changed, 150 insertions(+), 161 deletions(-)

-- 
2.8.1

