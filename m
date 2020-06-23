Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFD0205F5F
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 22:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391099AbgFWUcY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 16:32:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:33967 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391298AbgFWUcW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jun 2020 16:32:22 -0400
IronPort-SDR: Jhy3JpmmI0lq/omUOnLHaQIGse4VROB2SbD4EmbfN8LmridEjLcXYlk48F09CI04Qfk73HRpW7
 VFwi1P9h+VEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="144239996"
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="144239996"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 13:32:21 -0700
IronPort-SDR: i0mdhpz1Kj0v6XxVy+KcQSMhL+jFaUStPMmJdkOjw6Axk1sULqM98FwH3OlbKTZFLzsejirjXq
 vYE1yDWK+AyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="293319854"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga002.jf.intel.com with ESMTP; 23 Jun 2020 13:32:21 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 05NKWJmn056452;
        Tue, 23 Jun 2020 13:32:20 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 05NKWImb107402;
        Tue, 23 Jun 2020 16:32:18 -0400
Subject: [PATCH for-rc 0/2] Fixes for module unload
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 23 Jun 2020 16:32:18 -0400
Message-ID: <20200623202519.106975.94246.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Two fixes for unload path. One is where the module use count got messed up in a
previous fix, we missed hitting these paths. I missed hitting these paths. The
other patch is going back to kfree for the dummy netdev. We are currently
re-working how this dummy netdev stuff works and will send a series for-next
soon.

---

Dennis Dalessandro (2):
      IB/hfi1: Restore kfree in dummy_netdev cleanup
      IB/hfi1: Fix module use count flaw due to leftover module put calls


 drivers/infiniband/hw/hfi1/debugfs.c   |   19 ++-----------------
 drivers/infiniband/hw/hfi1/netdev_rx.c |    2 +-
 2 files changed, 3 insertions(+), 18 deletions(-)

--
-Denny
