Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 028334642E
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 18:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfFNQcX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 12:32:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:4447 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfFNQcW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 12:32:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 09:32:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,373,1557212400"; 
   d="scan'208";a="185010235"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2019 09:32:21 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x5EGWLD1060954;
        Fri, 14 Jun 2019 09:32:21 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x5EGWJLS045008;
        Fri, 14 Jun 2019 12:32:20 -0400
Subject: [PATCH for-rc 0/7] IB/hfi1: Fix a stuck qp problem
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Fri, 14 Jun 2019 12:32:19 -0400
Message-ID: <20190614163146.44927.95985.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series fixes a problem we encountered with a QP getting stuck. It is a bit
bigger than we probably want for RC so I'm fine applying this to for-next
instead especially this late in the game for 5.2.
---

Mike Marciniszyn (7):
      IB/hfi1: Avoid hardlockup with flushlist_lock
      IB/hfi1: Silence txreq allocation warnings
      IB/hfi1: Create inline to get extended headers
      IB/hfi1: Use aborts to trigger RC throttling
      IB/hfi1: Wakeup QPs orphaned on wait list after flush
      IB/hfi1: Handle wakeup of orphaned QPs for pio
      IB/hfi1: Handle port down properly in pio


 drivers/infiniband/hw/hfi1/hfi.h         |   31 ++++++++++++++++++
 drivers/infiniband/hw/hfi1/pio.c         |   21 +++++++++++-
 drivers/infiniband/hw/hfi1/rc.c          |   53 ++++++++++++++++++------------
 drivers/infiniband/hw/hfi1/sdma.c        |   26 +++++++++++----
 drivers/infiniband/hw/hfi1/ud.c          |    4 +-
 drivers/infiniband/hw/hfi1/verbs.c       |   14 +++++---
 drivers/infiniband/hw/hfi1/verbs.h       |    1 +
 drivers/infiniband/hw/hfi1/verbs_txreq.c |    2 +
 drivers/infiniband/hw/hfi1/verbs_txreq.h |    3 +-
 9 files changed, 116 insertions(+), 39 deletions(-)

--
-Denny
