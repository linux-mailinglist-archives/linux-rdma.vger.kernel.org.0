Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B315A48072A
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Dec 2021 09:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbhL1ICX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Dec 2021 03:02:23 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47591 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235491AbhL1ICV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Dec 2021 03:02:21 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AH/QsvK+TKEYZjE2zE+AIDrUD3n+TJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUpz0jMCzzBKWjiOaarca2GhLd51bt609xlT6p6DxoAyQFdlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4Ef9WlTdhSMkj/jRHOCsULe?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt9Rw2tVMt525T?=
 =?us-ascii?q?y8nI6/NhP8AFRJfFkmSOIUfoe6ZfCfj6Jf7I0ruNiGEL+9VJFsuMIQC4eFxAXl?=
 =?us-ascii?q?D3fMdITEJKBuEgoqe0qO5WPhu3Jx7dOHkOYoevjdryjSxJfInSJbMXKjM/dJe0?=
 =?us-ascii?q?x8wm8lREPeYbM0cARJrbQvNYh1GPFg/CI83g+qpwHL4dlVwrF+So4I07nLVwQg?=
 =?us-ascii?q?316LiWPLcetWQQsNRtkCGp27H9iLyBRRyHNmVzT2O8lqqmO7DnCq9U4UXfJW89?=
 =?us-ascii?q?/h3kBiQy3YVBRk+S1S2u7+6h1S4VtYZLFYbkgIqrK4v5AmxQtz0dwO3rWTCvRM?=
 =?us-ascii?q?GXddUVeog52mlyKXbyxSYC3AJCDVIAOHKHudeqScCjwfPxo22Q2c09uD9dJ5Uz?=
 =?us-ascii?q?Z/MxRvaBMTfBTZSDcPccTY43g=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A6nAw1Kx30g05ZRlNMBjHKrPwyr1zdoMgy1kn?=
 =?us-ascii?q?xilNoRw8SK2lfqeV7Y0mPH7P+U4ssR4b6LO90cW7Lk80sKQFhbX5Xo3SOjUO2l?=
 =?us-ascii?q?HYTr2KhLGKq1aLdkHDH6xmpMBdmsNFaOEYY2IVsS+D2njcLz8/+qj6zImYwffZ?=
 =?us-ascii?q?02x2TRxnL4Vp7wJCAA6dFUFsLTM2f6YRJd6N4NZdvTq8dTAyZsS/PHMMWO/OvJ?=
 =?us-ascii?q?nlj5TjCCR2eiIP2U2fiy+y8r7mH1y91hcaaTlGxrAv6izkvmXCl96ej80=3D?=
X-IronPort-AV: E=Sophos;i="5.88,241,1635177600"; 
   d="scan'208";a="119657413"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Dec 2021 16:01:53 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 42F6E4D15A2A;
        Tue, 28 Dec 2021 16:01:52 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 28 Dec 2021 16:01:52 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 28 Dec 2021 16:01:51 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 28 Dec 2021 16:01:49 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liweihang@huawei.com>, <liangwenpeng@huawei.com>,
        <yangx.jy@cn.fujitsu.com>, <rpearsonhpe@gmail.com>,
        <y-goto@fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [RFC PATCH rdma-next 07/10] RDMA/rxe: Set BTH's SE to zero for FLUSH packet
Date:   Tue, 28 Dec 2021 16:07:14 +0800
Message-ID: <20211228080717.10666-8-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 42F6E4D15A2A.A000C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The SPEC said:
oA19-6: FLUSH BTH header field solicited event (SE) indication shall be
set to zero.

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index a3e9351873e2..082c5f76f29b 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -401,7 +401,9 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 			(pkt->mask & RXE_END_MASK) &&
 			((pkt->mask & (RXE_SEND_MASK)) ||
 			(pkt->mask & (RXE_WRITE_MASK | RXE_IMMDT_MASK)) ==
-			(RXE_WRITE_MASK | RXE_IMMDT_MASK));
+			(RXE_WRITE_MASK | RXE_IMMDT_MASK)) &&
+			/* oA19-6: always set SE to zero */
+			!(pkt->mask & RXE_FETH_MASK);
 
 	qp_num = (pkt->mask & RXE_DETH_MASK) ? ibwr->wr.ud.remote_qpn :
 					 qp->attr.dest_qp_num;
-- 
2.31.1



