Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63392485E2F
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 02:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344423AbiAFBlQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 20:41:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:62225 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344417AbiAFBlO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 20:41:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="266855318"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="266855318"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 17:41:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="513226679"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga007.jf.intel.com with ESMTP; 05 Jan 2022 17:41:10 -0800
From:   yanjun.zhu@linux.dev
To:     jgg@ziepe.ca, mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, leonro@nvidia.com
Subject: [PATCH v3 0/4] Generate UDP src port with flow label or lqpn/rqpn
Date:   Thu,  6 Jan 2022 13:03:55 -0500
Message-Id: <20220106180359.2915060-1-yanjun.zhu@linux.dev>
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
v2->v3:Because in-subnet communications, GRH is optional. Without thei
       randomization for src_port done in rxe_qp_init_req, udp source
       port will be 0xC000 in that case.
v1->v2:Remove the local variables in commits "RDMA/irdma: Make the source
       udp port vary" and "RDMA/rxe: Use the standard method to produce
       udp source port". A new commit is added to remove the redundant
       randomization for UDP source port in RXE.
---



Zhu Yanjun (4):
  RDMA/core: Calculate UDP source port based on flow label or lqpn/rqpn
  RDMA/hns: Replace get_udp_sport with rdma_get_udp_sport
  RDMA/irdma: Make the source udp port vary
  RDMA/rxe: Use the standard method to produce udp source port

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 12 ++----------
 drivers/infiniband/hw/irdma/verbs.c        |  4 ++++
 drivers/infiniband/sw/rxe/rxe_verbs.c      |  6 ++++++
 include/rdma/ib_verbs.h                    | 17 +++++++++++++++++
 4 files changed, 29 insertions(+), 10 deletions(-)

-- 
2.27.0

