Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAFDB30C80
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2019 12:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfEaKZD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 May 2019 06:25:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51478 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726330AbfEaKZD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 31 May 2019 06:25:03 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B0D8BA8224E209A71AEB;
        Fri, 31 May 2019 18:25:00 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Fri, 31 May 2019 18:24:50 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 0/2] Two srq bugfixes
Date:   Fri, 31 May 2019 18:28:02 +0800
Message-ID: <1559298484-63548-1-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here are fix two bugs for srq.

Lijun Ou (2):
  RDMA/hns: Bugfix for filling the sge of srq
  RDMA/hns: Consider the bitmap full situation

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
1.9.1

