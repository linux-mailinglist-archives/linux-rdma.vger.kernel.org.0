Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAC5D7CC23
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 20:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbfGaSlH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 14:41:07 -0400
Received: from gateway36.websitewelcome.com ([192.185.198.13]:44787 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727579AbfGaSlH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 14:41:07 -0400
X-Greylist: delayed 1500 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Jul 2019 14:41:07 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id C3D1C400FFDD9
        for <linux-rdma@vger.kernel.org>; Wed, 31 Jul 2019 12:18:42 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sso1hJ4x52PzOsso1hOSXt; Wed, 31 Jul 2019 12:54:29 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SgzH7dQ1QhJtXNFRAKtAuhj9JJdZ2sxP9Z2fVINfjlc=; b=EXNnpFDTmY/QGMpJYfl+oxXKv4
        BOZCUaVvKLBwPGGy5IxDRghhn2C5dmdcnbaOeEarPRCbQK79pP6DC/p3cqMPZML9hzSP2YkkcRKQq
        7k+Ty4d4MQzU4uHY6tSNJHSxk2QFvKR3MJRRSZxXm1PslVQbm7bv5ASYUiOQEmN0vW+7xyK4keaSY
        MghG58yvwPIZN/cBdBmHDBfriqkDhH7Sd5TFqQfFUXsYvu65wNtpNF+3G51Ud7RGWuQZ+gjGcBKSK
        nALu2EWcZCvXK9pXW/M5KpoweWQ+pBhBNeRfwe1hqFbBM3YdtS4udh/ZH+Z2+B3T4wZWHYggt1ARq
        w9oHEUrA==;
Received: from [187.192.11.120] (port=36612 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hsso0-003QZf-S4; Wed, 31 Jul 2019 12:54:28 -0500
Date:   Wed, 31 Jul 2019 12:54:28 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Ira Weiny <ira.weiny@intel.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] IB/hfi1: Fix Spectre v1 vulnerability
Message-ID: <20190731175428.GA16736@embeddedor>
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
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hsso0-003QZf-S4
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:36612
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

sl is controlled by user-space, hence leading to a potential
exploitation of the Spectre variant 1 vulnerability.

Fix this by sanitizing sl before using it to index ibp->sl_to_sc.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://lore.kernel.org/lkml/20180423164740.GY17484@dhcp22.suse.cz/

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/infiniband/hw/hfi1/verbs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index f4ca436118ab..9f53f63b1453 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -54,6 +54,7 @@
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <rdma/opa_addr.h>
+#include <linux/nospec.h>
 
 #include "hfi.h"
 #include "common.h"
@@ -1537,6 +1538,7 @@ static int hfi1_check_ah(struct ib_device *ibdev, struct rdma_ah_attr *ah_attr)
 	sl = rdma_ah_get_sl(ah_attr);
 	if (sl >= ARRAY_SIZE(ibp->sl_to_sc))
 		return -EINVAL;
+	sl = array_index_nospec(sl, ARRAY_SIZE(ibp->sl_to_sc));
 
 	sc5 = ibp->sl_to_sc[sl];
 	if (sc_to_vlt(dd, sc5) > num_vls && sc_to_vlt(dd, sc5) != 0xf)
-- 
2.22.0

