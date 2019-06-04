Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0230B34D84
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2019 18:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfFDQcE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jun 2019 12:32:04 -0400
Received: from gateway36.websitewelcome.com ([50.116.127.2]:42205 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727541AbfFDQcE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jun 2019 12:32:04 -0400
X-Greylist: delayed 1500 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jun 2019 12:32:04 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 3B07B400CB0A5
        for <linux-rdma@vger.kernel.org>; Tue,  4 Jun 2019 10:03:14 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YBZxhCirwiQerYBZxhm3zt; Tue, 04 Jun 2019 10:42:25 -0500
X-Authority-Reason: nr=8
Received: from [189.250.127.120] (port=60742 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hYBZv-000v52-W6; Tue, 04 Jun 2019 10:42:24 -0500
Date:   Tue, 4 Jun 2019 10:42:22 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] RDMA/ucma: Use struct_size() helper
Message-ID: <20190604154222.GA8938@embeddedor>
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
X-Source-IP: 189.250.127.120
X-Source-L: No
X-Exim-ID: 1hYBZv-000v52-W6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.120]:60742
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, replace the following form:

sizeof(*resp) + (i * sizeof(struct ib_path_rec_data))

with:

struct_size(resp, path_data, i)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/infiniband/core/ucma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 140a338a135f..cbe460076611 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -951,8 +951,7 @@ static ssize_t ucma_query_path(struct ucma_context *ctx,
 		}
 	}
 
-	if (copy_to_user(response, resp,
-			 sizeof(*resp) + (i * sizeof(struct ib_path_rec_data))))
+	if (copy_to_user(response, resp, struct_size(resp, path_data, i)))
 		ret = -EFAULT;
 
 	kfree(resp);
-- 
2.21.0

