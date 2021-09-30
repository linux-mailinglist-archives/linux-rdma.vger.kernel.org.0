Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EAA41D61C
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 11:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349295AbhI3JTK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 05:19:10 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:31245 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1349294AbhI3JTJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 05:19:09 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AOI559a7X4ejqYt5VkLJUzQxRtNrFchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENShDYFmzMfC2CHPKuNZGSkc48jb4Ww9hkEscCByoVnSVc5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9b9ANkVEmjfvRHuunULa?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hgwdNCpdqyW?=
 =?us-ascii?q?C8nI6/NhP8AFRJfFkmSOIUfoeKdeybi4JP7I0ruNiGEL+9VJFsuMIQC4eFxAXl?=
 =?us-ascii?q?D3fMdITEJKBuEgoqe0qO5WPhu3Jx7dOHkOYoevjdryjSxJfIrRpbrQKjQ49Jcm?=
 =?us-ascii?q?jAqiahmH/nRT8wHaDZuZVLLZBgnElMWDo8u2f2kg3DXbTJVshSWqLAx7myVyxZ?=
 =?us-ascii?q?+uIUBmvK9lseiHJ0TxxjH4DmduTmRP/3TD/THoRLtz55mrrancfvHZb8v?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ATwOAB64VW+bUzChHvQPXwPTXdLJyesId70hD?=
 =?us-ascii?q?6qkRc20wTiX8ra2TdZsguyMc9wx6ZJhNo7G90cq7MBbhHPxOkOos1N6ZNWGIhI?=
 =?us-ascii?q?LCFvAB0WKN+V3dMhy73utc+IMlSKJmFeD3ZGIQse/KpCW+DPYsqePqzJyV?=
X-IronPort-AV: E=Sophos;i="5.85,335,1624291200"; 
   d="scan'208";a="115226597"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Sep 2021 17:17:26 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 582A54D0DC81;
        Thu, 30 Sep 2021 17:17:24 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 30 Sep 2021 17:17:18 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 30 Sep 2021 17:17:18 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 30 Sep 2021 17:17:16 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>
CC:     <rpearsonhpe@gmail.com>, <zyjzyj2000@gmail.com>, <leon@kernel.org>,
        "Xiao Yang" <yangx.jy@fujitsu.com>
Subject: [PATCH v4 0/4] RDMA/rxe: Do some cleanup
Date:   Thu, 30 Sep 2021 17:48:09 +0800
Message-ID: <20210930094813.226888-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 582A54D0DC81.A7018
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

V3->V4:
1) Rebase on the latest for-next branch.
2) Remove [PATCH v3 1/5].
3) Update [PATCH v3 2/5] to remove the is_user members of
   struct rxe_sq/rxe_rq/rxe_srq.

Xiao Yang (4):
  RDMA/rxe: Remove the is_user members of struct rxe_sq/rxe_rq/rxe_srq
  RDMA/rxe: Change the is_user member of struct rxe_cq to bool
  RDMA/rxe: Set partial attributes when completion status !=
    IBV_WC_SUCCESS
  RDMA/rxe: Remove duplicate settings

 drivers/infiniband/sw/rxe/rxe_comp.c  | 45 +++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_cq.c    |  3 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  2 --
 drivers/infiniband/sw/rxe/rxe_resp.c  |  4 ---
 drivers/infiniband/sw/rxe/rxe_srq.c   |  1 -
 drivers/infiniband/sw/rxe/rxe_verbs.c |  3 --
 drivers/infiniband/sw/rxe/rxe_verbs.h |  5 +--
 7 files changed, 27 insertions(+), 36 deletions(-)

-- 
2.25.1



