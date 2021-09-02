Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764A73FEA75
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 10:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbhIBIPt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 04:15:49 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:29095 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233427AbhIBIPt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Sep 2021 04:15:49 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A62DoYarZedc+oZNtcGmHgr8aV5rDeYIsimQD?=
 =?us-ascii?q?101hICG8cqSj+fxG+85rsSMc6QxhP03I9urhBEDtex/hHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekIh+bfKlbbehEWmNQz6U4ZSdkdNDTvNykAse/KpBm/D807wMSKtIShheLl?=
 =?us-ascii?q?xX9rSg1wApsQljtRO0KKFFFsXglaCd4cHJqY3MBOoD2tYjA5dcK+b0N1J9Trlp?=
 =?us-ascii?q?nako78ex4aC1oC4AmKtzmh77n3CFy5834lIlVy/Ys=3D?=
X-IronPort-AV: E=Sophos;i="5.84,371,1620662400"; 
   d="scan'208";a="113894782"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 02 Sep 2021 16:14:50 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 492C04D0D9DC;
        Thu,  2 Sep 2021 16:14:48 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 2 Sep 2021 16:14:42 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 2 Sep 2021 16:14:41 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <rpearsonhpe@gmail.com>, <zyjzyj2000@gmail.com>, <jgg@nvidia.com>,
        <leon@kernel.org>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v2 0/5] RDMA/rxe: Do some cleanup
Date:   Thu, 2 Sep 2021 16:46:35 +0800
Message-ID: <20210902084640.679744-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 492C04D0D9DC.A9990
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

V1->V2:
Add two patches.

Xiao Yang (5):
  RDMA/rxe: Remove unnecessary check for qp->is_user/cq->is_user
  RDMA/rxe: Remove the common is_user member of struct rxe_qp
  RDMA/rxe: Change the is_user member of struct rxe_cq to bool
  RDMA/rxe: Set partial attributes when completion status !=
    IBV_WC_SUCCESS
  RDMA/rxe: Remove duplicate settings

 drivers/infiniband/sw/rxe/rxe_comp.c  | 51 +++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_cq.c    |  3 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  5 +--
 drivers/infiniband/sw/rxe/rxe_req.c   |  4 +--
 drivers/infiniband/sw/rxe/rxe_resp.c  | 14 +++-----
 drivers/infiniband/sw/rxe/rxe_verbs.c | 42 ++++++----------------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  3 +-
 7 files changed, 50 insertions(+), 72 deletions(-)

-- 
2.23.0



