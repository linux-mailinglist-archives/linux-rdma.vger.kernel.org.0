Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20031D9CB6
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 18:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgESQb0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 12:31:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgESQb0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 May 2020 12:31:26 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40F85207D3;
        Tue, 19 May 2020 16:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589905885;
        bh=uASEKNWX2uIB0hJ0wokVFicq/nmlpU2jfEmWO9zmSQo=;
        h=Date:From:To:Cc:Subject:From;
        b=kuYBKgMixa56chL6YR3C8bnsP8+6t0kL1tZS2zyTTvHuAg+U+gB1qWU5ebGUrtVHy
         q5KANzEo1MPjM533m4a9Eqsb4ZZFmnQ/sB240uzA/l1sIp1bz18iXx4pWaDd2Tlc23
         8D1AC77nx1zgdy/cSYNeJGawKlh3T0F/pJxwiOfQ=
Date:   Tue, 19 May 2020 11:36:12 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] RDMA/rtrs: client: Fix function return on success
Message-ID: <20200519163612.GA6043@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove the if-statement and return the value contained in _err_,
unconditionally.

Addresses-Coverity-ID: 1493753 ("Identical code for different branches")
Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Return err, unconditionally. As suggested by Bart Van Assche.
   Thanks, Bart.

 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 468fdd0d8713c..568741aa7f596 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1591,9 +1591,6 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 	 * In case of error we do not bother to clean previous allocations,
 	 * since destroy_con_cq_qp() must be called.
 	 */
-
-	if (err)
-		return err;
 	return err;
 }
 
-- 
2.26.2

