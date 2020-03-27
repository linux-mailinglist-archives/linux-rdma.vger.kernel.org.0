Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90B52195E9E
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2020 20:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgC0T2H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Mar 2020 15:28:07 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.68]:43132 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727423AbgC0T2H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Mar 2020 15:28:07 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 8B92D2C7E90
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2020 14:28:06 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id HueEjDDb6Sl8qHueEjk7Un; Fri, 27 Mar 2020 14:28:06 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Buqi6OLghYZwwzbP5D9+pYan+g0L6EIsYgrXmMspPF0=; b=mNjug9fnBO0RNjDFqB25HutLRA
        pdoV97bGFsrtxdD6c4cv0QDOYKWDw3SlNAEGuGvoLSDPmNFuDnqGKEnqQ4IL4ZlHs+3gdeFtt78Tn
        br8ERDh1FLCl7DGv0CfZHMqPUL+iwqYX6kNZ47qNx3h3nvAyh2G82J0YtCSJ+JzdDbZoqh1/t8Gqw
        Em4+5auxJtZMOW//BiBwt7TAcHbJxsTptKbMIUjNKBa39hsvSSHVDDwz8iwKYLY174GbWCCPE+H08
        SD5eGpOKkjyUrWh7EuhThX2KQITdXVIkWrIUgTM34OggWv4HkEk3Mk4boPPT7nZZA6ij1KIfClzdV
        x4dkxwCw==;
Received: from cablelink-189-218-116-241.hosts.intercable.net ([189.218.116.241]:45216 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jHueD-002Ixm-1D; Fri, 27 Mar 2020 14:28:05 -0500
Date:   Fri, 27 Mar 2020 14:31:42 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Weihang Li <liweihang@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Xi Wang <wangxi11@huawei.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] RDMA/hns: Fix uninitialized variable bug
Message-ID: <20200327193142.GA32547@embeddedor>
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
X-Exim-ID: 1jHueD-002Ixm-1D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-189-218-116-241.hosts.intercable.net (embeddedor) [189.218.116.241]:45216
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is a potential execution path in which variable *ret* is returned
without being properly initialized, previously.

Fix this by initializing variable *ret* to -ENODEV.

Addresses-Coverity-ID: 1491917 ("Uninitialized scalar variable")
Fixes: 2f49de21f3e9 ("RDMA/hns: Optimize mhop get flow for multi-hop addressing")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index c96378718f88..3fd8100c2b56 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -603,7 +603,7 @@ static int set_mhop_hem(struct hns_roce_dev *hr_dev,
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	int step_idx;
-	int ret;
+	int ret = -ENODEV;
 
 	if (index->inited & HEM_INDEX_L0) {
 		ret = hr_dev->hw->set_hem(hr_dev, table, obj, 0);
-- 
2.26.0

