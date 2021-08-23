Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBA93F46E2
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 10:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhHWIvk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 04:51:40 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:49797 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235573AbhHWIvj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Aug 2021 04:51:39 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AvdH6/qg0zfwZ1F2zz77AOpu03XBQXjIji2hC?=
 =?us-ascii?q?6mlwRA09TySZ//rBoB19726RtN9xYgBGpTnuAsm9qB/nmaKdgrNhWItKPjOW21?=
 =?us-ascii?q?dARbsKheCJrgEIcBeeygcy78hdmtBFeb/N5EZB/L3HyTj9A9A928OG7aztoe/f?=
 =?us-ascii?q?yk1mRQZsZ7oI1XYBNi+rVl1xWBJdBYc0UL6V5s98rTKmfngNKuuhAH1tZZm6m/?=
 =?us-ascii?q?T70ILhfQUdBwMqrC2HjTaT4rb8FBSCmjcyOgk/p4sfzQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,344,1620662400"; 
   d="scan'208";a="113319342"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Aug 2021 16:50:55 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 2A6134D0F90C;
        Mon, 23 Aug 2021 16:50:55 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 23 Aug 2021 16:50:47 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 23 Aug 2021 16:50:44 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <rpearsonhpe@gmail.com>, <zyjzyj2000@gmail.com>, <jgg@nvidia.com>,
        <leon@kernel.org>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH 0/3] RDMA/rxe: Do some cleanup
Date:   Mon, 23 Aug 2021 17:22:53 +0800
Message-ID: <20210823092256.287154-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 2A6134D0F90C.A7C54
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Xiao Yang (3):
  RDMA/rxe: Remove unnecessary check for qp->is_user/cq->is_user
  RDMA/rxe: Remove the common is_user member of struct rxe_qp
  RDMA/rxe: Change the is_user member of struct rxe_cq to bool

 drivers/infiniband/sw/rxe/rxe_comp.c  |  6 ++--
 drivers/infiniband/sw/rxe/rxe_cq.c    |  3 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  5 ++--
 drivers/infiniband/sw/rxe/rxe_req.c   |  4 +--
 drivers/infiniband/sw/rxe/rxe_resp.c  | 10 +++----
 drivers/infiniband/sw/rxe/rxe_verbs.c | 42 +++++++--------------------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  3 +-
 7 files changed, 25 insertions(+), 48 deletions(-)

-- 
2.25.1



