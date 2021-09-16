Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8792340D997
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 14:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbhIPMQe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 08:16:34 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:30260 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239161AbhIPMQe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Sep 2021 08:16:34 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AxKB4WaM4+gi/dqPvrR1HlcFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQTq1TkhhjUCm2EaWTjSP/uCYmfwKIp3ao3ko0lSsZHcm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHiK0SiuFaOC79CEtjP/QHNIQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/mjyPkMA3ysRlu4GyS?=
 =?us-ascii?q?BsyI+vHn+F1vxxwSngiYPIcoOKcSZS4mYnJp6HcSFP22/hnFloxO40A9854BGh?=
 =?us-ascii?q?P8boTLzVlRgKShfCnwujjErFEicEqLc2tN4Qa0llkwDbfJfUrW5bOR+PN/9Aw9?=
 =?us-ascii?q?DU/iehIA/fSZsNfYj1qBDzEYhtSKhINBJc3tPmni2O5cDBCrl+R460t7ADuIKZ?=
 =?us-ascii?q?ZuFT2GIONPIXUGoMOxQDFzl8qNl/RWnkyXOFzAxLcmp50utLyoA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A+/35DaFd/+cAu70lpLqEjceALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKKSC9Hfb0qynDpp4mPHzP6Qr5OktOpTnoAsDpKk80naQFgrX5Vo3PYOCJgg?=
 =?us-ascii?q?WVEL0=3D?=
X-IronPort-AV: E=Sophos;i="5.85,298,1624291200"; 
   d="scan'208";a="114572053"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Sep 2021 20:15:12 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id E16664D0DC6E;
        Thu, 16 Sep 2021 20:15:11 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 16 Sep 2021 20:15:12 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 16 Sep 2021 20:15:11 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 16 Sep 2021 20:15:10 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>
CC:     <rpearsonhpe@gmail.com>, <zyjzyj2000@gmail.com>, <leon@kernel.org>,
        "Xiao Yang" <yangx.jy@fujitsu.com>
Subject: [PATCH v3 0/5] RDMA/rxe: Do some cleanup
Date:   Thu, 16 Sep 2021 20:46:47 +0800
Message-ID: <20210916124652.1304649-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: E16664D0DC6E.A6E98
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

V2->V3:
1) Rebase on the latest kernel
2) Drop the ternary expression

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
 drivers/infiniband/sw/rxe/rxe_verbs.c | 41 +++++----------------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  3 +-
 7 files changed, 49 insertions(+), 72 deletions(-)

-- 
2.25.1



