Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E70641D61F
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 11:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349294AbhI3JTQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 05:19:16 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:31245 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1349297AbhI3JTP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 05:19:15 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AUdj57q8u5z51fHIOz8mbDrUDYnyTJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUp31GMCymEZCGrTOKyONGanLo1xPdy/pkgG75DdyYcwTFdlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4EfwWlTdhSMkj/jQF+GkULe?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt8F4ztpd856hY?=
 =?us-ascii?q?Qk0PKzQg/lbWB5de817FfQfpeWdfybn66R/yGWDKRMA2c5GFlk7NJcD/eB3GWx?=
 =?us-ascii?q?m+vkRKTRLZReG78qk0bCpW+s23px7BMbuNYIb/HpnyFnxCfshR7jATr/M6Nse2?=
 =?us-ascii?q?y0/7uhMEvn2YdQYZTtmKh/HZnVnPlYRFYJ7huutj1HhfDBC7lGYv6w65y7U1gM?=
 =?us-ascii?q?Z7VRHGLI5YfTTHYMMwBne/TmAogzE7tghHIT34VK4HriE34cjRR/GZb8=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AxIiAOajV1moMRIEDEqZ3ZPeuu3BQXuYji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHLoB1/73LJYVkqNk3I5urrBEDtexLhHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekM0WKI+UyDJ8SRzI5g/JYlW61/Jfm1NlJikPv9iTPSL/8QhPWB74Ck7N2z?=
 =?us-ascii?q?80tQ?=
X-IronPort-AV: E=Sophos;i="5.85,335,1624291200"; 
   d="scan'208";a="115226602"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Sep 2021 17:17:32 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 311404D0DC84;
        Thu, 30 Sep 2021 17:17:30 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 30 Sep 2021 17:17:24 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 30 Sep 2021 17:17:22 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 30 Sep 2021 17:17:20 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>
CC:     <rpearsonhpe@gmail.com>, <zyjzyj2000@gmail.com>, <leon@kernel.org>,
        "Xiao Yang" <yangx.jy@fujitsu.com>
Subject: [PATCH v4 4/4] RDMA/rxe: Remove duplicate settings
Date:   Thu, 30 Sep 2021 17:48:13 +0800
Message-ID: <20210930094813.226888-5-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210930094813.226888-1-yangx.jy@fujitsu.com>
References: <20210930094813.226888-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 311404D0DC84.A58B1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove duplicate settings for vendor_err and qp_num.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 4af0dc95784a..e8f435fa6e4d 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -860,7 +860,6 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 		wc->opcode = (pkt->mask & RXE_IMMDT_MASK &&
 				pkt->mask & RXE_WRITE_MASK) ?
 					IB_WC_RECV_RDMA_WITH_IMM : IB_WC_RECV;
-		wc->vendor_err = 0;
 		wc->byte_len = (pkt->mask & RXE_IMMDT_MASK &&
 				pkt->mask & RXE_WRITE_MASK) ?
 					qp->resp.length : wqe->dma.length - wqe->dma.resid;
@@ -881,8 +880,6 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 				uwc->ex.invalidate_rkey = ieth_rkey(pkt);
 			}
 
-			uwc->qp_num		= qp->ibqp.qp_num;
-
 			if (pkt->mask & RXE_DETH_MASK)
 				uwc->src_qp = deth_sqp(pkt);
 
@@ -914,7 +911,6 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 			if (pkt->mask & RXE_DETH_MASK)
 				wc->src_qp = deth_sqp(pkt);
 
-			wc->qp			= &qp->ibqp;
 			wc->port_num		= qp->attr.port_num;
 		}
 	}
-- 
2.25.1



