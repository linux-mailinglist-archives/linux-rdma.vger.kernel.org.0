Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14822BB303
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Nov 2020 19:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbgKTS2p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Nov 2020 13:28:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:48986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728325AbgKTS2o (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Nov 2020 13:28:44 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B9BF2224C;
        Fri, 20 Nov 2020 18:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605896924;
        bh=m4NuGRolcK2byyi6/49birIW/p5/x8nrqJB0bv8iG7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W1lVC+TRSGss5xGqIA/k6rbFM2GdfCAMktbpdlv5+y6paAMKgq0EvvWOG2XLAWm7z
         aHvXbXALvrZOQPzOXt3tXJIGylICab5bB3K4NbwtPkVg+8XYoDuQyQevZ/JdhtrZbg
         n8kd7ZtFgUqp0Ez4s1kyTQa0w+r8l5pRxyl1uA6U=
Date:   Fri, 20 Nov 2020 12:28:49 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Yishai Hadas <yishaih@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 034/141] IB/mlx4: Fix fall-through warnings for Clang
Message-ID: <0153716933e01608d46155941c447d011c59c1e4.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of just letting the code
fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/infiniband/hw/mlx4/mad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
index 8bd16474708f..f3ace85552f3 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -1523,6 +1523,7 @@ static void mlx4_ib_multiplex_mad(struct mlx4_ib_demux_pv_ctx *ctx, struct ib_wc
 			return;
 		} else
 			*slave_id = slave;
+		break;
 	default:
 		/* nothing */;
 	}
-- 
2.27.0

