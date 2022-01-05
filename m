Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FCB484500
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 16:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiADPoq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 10:44:46 -0500
Received: from mga18.intel.com ([134.134.136.126]:35449 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234946AbiADPoi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jan 2022 10:44:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="229062509"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="229062509"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 07:44:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="526089383"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga008.jf.intel.com with ESMTP; 04 Jan 2022 07:44:35 -0800
From:   yanjun.zhu@linux.dev
To:     liangwenpeng@huawei.com, liweihang@huawei.com, jgg@ziepe.ca,
        mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev
Subject: [PATCH 0/4] Generate UDP src port with flow label or lqpn/rqpn
Date:   Wed,  5 Jan 2022 03:07:23 -0500
Message-Id: <20220105080727.2143737-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Follow the advice from Leon Romanovsky, rdma_get_udp_sport is moved to
ib_verbs.h. several drivers generate udp source port with this function.

Zhu Yanjun (4):
  RDMA/core: Calculate UDP source port based on flow label or lqpn/rqpn
  RDMA/hns: Replace get_udp_sport with rdma_get_udp_sport
  RDMA/irdma: Make the source udp port vary
  RDMA/rxe: Use the standard method to produce udp source port

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 12 ++----------
 drivers/infiniband/hw/irdma/verbs.c        |  5 +++++
 drivers/infiniband/sw/rxe/rxe_verbs.c      | 10 ++++++++++
 include/rdma/ib_verbs.h                    | 17 +++++++++++++++++
 4 files changed, 34 insertions(+), 10 deletions(-)

-- 
2.27.0

