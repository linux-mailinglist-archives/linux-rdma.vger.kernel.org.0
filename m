Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B19D3DC01B
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 23:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhG3VKm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 17:10:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:12207 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhG3VKl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Jul 2021 17:10:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="213203321"
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="213203321"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 14:10:36 -0700
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="499752253"
Received: from sindhude-mobl.amr.corp.intel.com ([10.212.74.5])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 14:10:35 -0700
From:   Sindhu Devale <sindhu.devale@intel.com>
To:     jgg@nvidia.com, dledford@redhat.com, leon@kernel.org,
        tatyana.e.nikolova@intel.com
Cc:     linux-rdma@vger.kernel.org, shiraz.saleem@intel.com,
        mustafa.ismail@intel.com, Sindhu Devale <sindhu.devale@intel.com>
Subject: [PATCH rdma-core 0/2] iwpmd fixes
Date:   Fri, 30 Jul 2021 16:10:02 -0500
Message-Id: <20210730211004.1946-1-sindhu.devale@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a series of Portmapper fixes.

Tatyana Nikolova (2):
  iwpmd: Start the service if IPv4 or IPv6 is available
  iwpmd: Remove IP address checking per mapping

 iwpmd/iwarp_pm_common.c |  2 +-
 iwpmd/iwarp_pm_helper.c | 89 +----------------------------------------
 iwpmd/iwarp_pm_server.c | 82 +++++++++++++++++++++----------------
 3 files changed, 50 insertions(+), 123 deletions(-)

-- 
2.32.0

