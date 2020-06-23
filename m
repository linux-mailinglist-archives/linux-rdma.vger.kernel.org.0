Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6BE20617C
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 23:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392507AbgFWUnT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 16:43:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:34980 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392502AbgFWUnR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jun 2020 16:43:17 -0400
IronPort-SDR: wclqWmdRSVEiK1vUi95p6X9mGUavg/Kx/weRSnpQctD6UFNlQaY8A55TZisum0MSkToKvKELVt
 fqIwPoFQdJJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="144243691"
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="144243691"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 13:43:18 -0700
IronPort-SDR: bhsK2xfAv8GHlWYXYVGIIufY2ta031+VYUZYSxtanx7L1kNAAswULKwJ2BBEVHBZyOvZnf4wKl
 Mx0qcYi8vW5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="279240974"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga006.jf.intel.com with ESMTP; 23 Jun 2020 13:43:18 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 05NKhHsc057771;
        Tue, 23 Jun 2020 13:43:17 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 05NKhGcx108163;
        Tue, 23 Jun 2020 16:43:16 -0400
Subject: [PATCH for-rc 0/2] AIP fixes
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 23 Jun 2020 16:43:16 -0400
Message-ID: <20200623204237.108092.33229.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Two fixes for AIP which was accepted this cycle.
---

Mike Marciniszyn (2):
      IB/hfi1: Correct -EBUSY handling in tx code
      IB/hfi1: Add atomic triggered sleep/wakeup


 drivers/infiniband/hw/hfi1/ipoib.h    |    6 ++
 drivers/infiniband/hw/hfi1/ipoib_tx.c |  102 +++++++++++++++++++++------------
 2 files changed, 71 insertions(+), 37 deletions(-)

--
-Denny
