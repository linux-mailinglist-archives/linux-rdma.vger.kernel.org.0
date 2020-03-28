Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6518F196338
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2020 03:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgC1C4Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Mar 2020 22:56:24 -0400
Received: from gateway30.websitewelcome.com ([192.185.197.25]:28167 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726225AbgC1C4Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Mar 2020 22:56:24 -0400
X-Greylist: delayed 1453 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Mar 2020 22:56:23 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 6F777158F
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2020 21:32:05 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id I1GXjVgTRVQh0I1GXjjF4t; Fri, 27 Mar 2020 21:32:05 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=m7HVYDJnzCg+rsyE3gWKNJQWXD+U5W3Qjb0bzyPX+VI=; b=t6SDPlkPSAoKtD5BNbuwleOfsJ
        0b8wfUDWk7K18AWjlzSg9qn3FwLIJthiFBxX8z0bnwW/zI3v1yvUtHBlMOaZaSBIF/JTy8khKotJ3
        yPwA4dH6LU741d9pYYwAMoKuTfsbkVksa7uJii//UqC5YLv0FRmfPp10/uCEibs7FwwRCE6al+Lmd
        bhWyJQfEJQCGDPfIhtbkixrNs0gJa22KI4dOnwF6Q//i6RT3aF3TjgBQ3l/3iEs4ndkqL5oOaYq2K
        OQbIjfPUMbQcsgBRF2WcJx9QeOtvzRSrrVD9TAc/x1uhIcnhm9BzvW+QnbKhLgxrT9oK2ZNeRcahO
        Zu0vnJOw==;
Received: from cablelink-189-218-116-241.hosts.intercable.net ([189.218.116.241]:51192 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jI1GV-001EiJ-Ud; Fri, 27 Mar 2020 21:32:03 -0500
Date:   Fri, 27 Mar 2020 21:35:39 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Weihang Li <liweihang@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Xi Wang <wangxi11@huawei.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2][next] RDMA/hns: Fix uninitialized variable bug
Message-ID: <20200328023539.GA32016@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.218.116.241
X-Source-L: No
X-Exim-ID: 1jI1GV-001EiJ-Ud
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-189-218-116-241.hosts.intercable.net (embeddedor) [189.218.116.241]:51192
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is a potential execution path in which variable *ret* is returned
without being properly initialized, previously.

Fix this by initializing variable *ret* to 0.

Addresses-Coverity-ID: 1491917 ("Uninitialized scalar variable")
Fixes: 2f49de21f3e9 ("RDMA/hns: Optimize mhop get flow for multi-hop addressing")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Set ret to 0 instead of -ENODEV. Thanks Weihang Li, for the feedback.

 drivers/infiniband/hw/hns/hns_roce_hem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index c96378718f88..263338b90d7a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -603,7 +603,7 @@ static int set_mhop_hem(struct hns_roce_dev *hr_dev,
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	int step_idx;
-	int ret;
+	int ret = 0;
 
 	if (index->inited & HEM_INDEX_L0) {
 		ret = hr_dev->hw->set_hem(hr_dev, table, obj, 0);
-- 
2.26.0

