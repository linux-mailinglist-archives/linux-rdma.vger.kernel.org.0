Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 429A5A13FD
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2019 10:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfH2IpF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Aug 2019 04:45:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45100 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbfH2IpF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Aug 2019 04:45:05 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CC37427C6BF73E2F1F6D;
        Thu, 29 Aug 2019 16:45:00 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Thu, 29 Aug 2019 16:44:54 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 0/2] Fixes for hip08 driver
Date:   Thu, 29 Aug 2019 16:41:40 +0800
Message-ID: <1567068102-56919-1-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here optimizes some codes and removes some warnings by sparse tool
checking as well as fixes some defects.

Changelog:
v1->v2: Remove a redundant judgment in patch(1/2) as Leon Romanovsky
	suggested. Fix patch(2/2) as comments from Doug Ledford. Also
	some modifications on title and commit message.

Lijun Ou (1):
  RDMA/hns: Package operations of rq inline buffer into separate
    functions

Yixian Liu (1):
  RDMA/hns: Optimize cmd init and mode selection for hip08

 drivers/infiniband/hw/hns/hns_roce_cmd.c  | 10 +---
 drivers/infiniband/hw/hns/hns_roce_main.c |  8 +--
 drivers/infiniband/hw/hns/hns_roce_qp.c   | 95 ++++++++++++++++++-------------
 3 files changed, 61 insertions(+), 52 deletions(-)

-- 
2.8.1

