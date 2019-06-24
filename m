Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1460550A1F
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 13:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfFXLuz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 07:50:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42382 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729420AbfFXLuz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Jun 2019 07:50:55 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BAAF32BE0E4A855DAD68;
        Mon, 24 Jun 2019 19:50:49 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 24 Jun 2019 19:50:40 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 0/8] Some fixes from hns
Date:   Mon, 24 Jun 2019 19:47:44 +0800
Message-ID: <1561376872-111496-1-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here are some bug fixes as well code optimization.

Lang Cheng (3):
  RDMA/hns: Set reset flag when hw resetting
  RDMA/hns: Use %pK format pointer print
  RDMA/hns: Clean up unnecessary variable initialization

Lijun Ou (1):
  RDMA/hns: Bugfix for cleaning mtr

Xi Wang (1):
  RDMA/hns: Fixs hw access invalid dma memory error

Yangyang Li (1):
  RDMA/hns: Modify ba page size for cqe

chenglang (1):
  RDMA/hns: Fixup qp release bug

o00290482 (1):
  RDMA/hns: Bugfix for calculating qp buffer size

 drivers/infiniband/hw/hns/hns_roce_cmd.c   |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c |  4 +++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  9 +++++----
 drivers/infiniband/hw/hns/hns_roce_main.c  |  2 +-
 drivers/infiniband/hw/hns/hns_roce_pd.c    |  2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c    | 13 ++++---------
 6 files changed, 15 insertions(+), 17 deletions(-)

-- 
1.9.1

