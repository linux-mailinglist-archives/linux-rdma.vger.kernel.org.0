Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58049484DC9
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 06:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbiAEFtt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 00:49:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:27100 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236188AbiAEFtt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 00:49:49 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="305725896"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="305725896"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 21:49:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="760688600"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2022 21:49:46 -0800
From:   yanjun.zhu@linux.dev
To:     liangwenpeng@huawei.com, jgg@ziepe.ca, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev
Subject: [PATCHv2 0/5] Generate UDP src port with flow label or lqpn/rqpn
Date:   Wed,  5 Jan 2022 17:12:32 -0500
Message-Id: <20220105221237.2659462-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Follow the advice from Leon Romanovsky, rdma_get_udp_sport is moved to
ib_verbs.h. several drivers generate udp source port with this function.

---
v1->v2:Remove the local variables in commits "RDMA/irdma: Make the source
       udp port vary" and "RDMA/rxe: Use the standard method to produce
       udp source port". A new commit is added to remove the redundant
       randomization for UDP source port in RXE.
---

Zhu Yanjun (5):
  RDMA/core: Calculate UDP source port based on flow label or lqpn/rqpn
  RDMA/hns: Replace get_udp_sport with rdma_get_udp_sport
  RDMA/irdma: Make the source udp port vary
  RDMA/rxe: Use the standard method to produce udp source port
  RDMA/rxe: Remove the redundant randomization for UDP source port

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 12 ++----------
 drivers/infiniband/hw/irdma/verbs.c        |  4 ++++
 drivers/infiniband/sw/rxe/rxe_qp.c         | 10 ++--------
 drivers/infiniband/sw/rxe/rxe_verbs.c      |  6 ++++++
 include/rdma/ib_verbs.h                    | 17 +++++++++++++++++
 5 files changed, 31 insertions(+), 18 deletions(-)

-- 
2.27.0

