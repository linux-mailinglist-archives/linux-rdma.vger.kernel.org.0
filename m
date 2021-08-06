Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D89C3E2F12
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Aug 2021 19:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242327AbhHFR7B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Aug 2021 13:59:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:25860 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230178AbhHFR7A (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 6 Aug 2021 13:59:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10068"; a="214446775"
X-IronPort-AV: E=Sophos;i="5.84,301,1620716400"; 
   d="scan'208";a="214446775"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 10:58:44 -0700
X-IronPort-AV: E=Sophos;i="5.84,301,1620716400"; 
   d="scan'208";a="523585469"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.212.71.43])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 10:58:43 -0700
From:   Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To:     jgg@nvidia.com, dledford@redhat.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [PATCH] irdma: Add ice and irdma to kernel-boot rules
Date:   Fri,  6 Aug 2021 12:58:08 -0500
Message-Id: <20210806175808.1463-1-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add ice and irdma to kernel-boot rules so that
these devices are recognized as iWARP and RoCE capable.

Otherwise the port mapper service which is only relevant
for iWARP devices may not start automatically after boot.

Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 kernel-boot/rdma-description.rules | 2 ++
 kernel-boot/rdma-hw-modules.rules  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/kernel-boot/rdma-description.rules b/kernel-boot/rdma-description.rules
index 48a7ced..f2f7b38 100644
--- a/kernel-boot/rdma-description.rules
+++ b/kernel-boot/rdma-description.rules
@@ -24,11 +24,13 @@ DRIVERS=="hfi1", ENV{ID_RDMA_OPA}="1"
 # Hardware that supports iWarp
 DRIVERS=="cxgb4", ENV{ID_RDMA_IWARP}="1"
 DRIVERS=="i40e", ENV{ID_RDMA_IWARP}="1"
+DRIVERS=="ice", ENV{ID_RDMA_IWARP}="1"
 
 # Hardware that supports RoCE
 DRIVERS=="be2net", ENV{ID_RDMA_ROCE}="1"
 DRIVERS=="bnxt_en", ENV{ID_RDMA_ROCE}="1"
 DRIVERS=="hns", ENV{ID_RDMA_ROCE}="1"
+DRIVERS=="ice", ENV{ID_RDMA_ROCE}="1"
 DRIVERS=="mlx4_core", ENV{ID_RDMA_ROCE}="1"
 DRIVERS=="mlx5_core", ENV{ID_RDMA_ROCE}="1"
 DRIVERS=="qede", ENV{ID_RDMA_ROCE}="1"
diff --git a/kernel-boot/rdma-hw-modules.rules b/kernel-boot/rdma-hw-modules.rules
index 95eaf72..040deb3 100644
--- a/kernel-boot/rdma-hw-modules.rules
+++ b/kernel-boot/rdma-hw-modules.rules
@@ -12,6 +12,7 @@ ENV{ID_NET_DRIVER}=="bnxt_en", RUN{builtin}+="kmod load bnxt_re"
 ENV{ID_NET_DRIVER}=="cxgb4", RUN{builtin}+="kmod load iw_cxgb4"
 ENV{ID_NET_DRIVER}=="hns", RUN{builtin}+="kmod load hns_roce"
 ENV{ID_NET_DRIVER}=="i40e", RUN{builtin}+="kmod load i40iw"
+ENV{ID_NET_DRIVER}=="ice", RUN{builtin}+="kmod load irdma"
 ENV{ID_NET_DRIVER}=="mlx4_en", RUN{builtin}+="kmod load mlx4_ib"
 ENV{ID_NET_DRIVER}=="mlx5_core", RUN{builtin}+="kmod load mlx5_ib"
 ENV{ID_NET_DRIVER}=="qede", RUN{builtin}+="kmod load qedr"
-- 
1.8.3.1

