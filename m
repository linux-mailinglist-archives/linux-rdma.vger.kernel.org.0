Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 410DF1A6327
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 08:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgDMGk5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 02:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgDMGk5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Apr 2020 02:40:57 -0400
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DA5C008678
        for <linux-rdma@vger.kernel.org>; Sun, 12 Apr 2020 23:40:56 -0700 (PDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 61C96ECC34ED64DCCF28;
        Mon, 13 Apr 2020 14:40:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 13 Apr 2020 14:40:41 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 0/6] RDMA/hns: Codes optimization
Date:   Mon, 13 Apr 2020 14:40:36 +0800
Message-ID: <1586760042-40516-1-git-send-email-liweihang@huawei.com>
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

