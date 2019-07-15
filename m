Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 880466994D
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2019 18:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfGOQpT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Jul 2019 12:45:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:41346 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729941AbfGOQpT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 15 Jul 2019 12:45:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2019 09:45:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,493,1557212400"; 
   d="scan'208";a="178271001"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga002.jf.intel.com with ESMTP; 15 Jul 2019 09:45:18 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x6FGjGMd033140;
        Mon, 15 Jul 2019 09:45:17 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x6FGjEn3074245;
        Mon, 15 Jul 2019 12:45:14 -0400
Subject: [PATCH 0/6] More 5.3 patches
To:     jgg@ziepe.ca, dledford@redhat.com
From:   Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 15 Jul 2019 12:45:14 -0400
Message-ID: <20190715164423.74174.4994.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The following series contains fixes and a cleanup.

I noticed that 5.3 rc1 hasn't happened yet? So I'm not quite sure of
the destination here.

5 of the patches are stable, and should be held for the rc or pulled for 5.3.

Deleting the unused define can wait if necessary.

---

John Fleck (1):
      IB/hfi1: Check for error on call to alloc_rsm_map_table

Kaike Wan (4):
      IB/hfi1: Unreserve a flushed OPFN request
      IB/hfi1: Field not zero-ed when allocating TID flow memory
      IB/hfi1: Drop all TID RDMA READ RESP packets after r_next_psn
      IB/hfi1: Do not update hcrc for a KDETH packet during fault injection

Mike Marciniszyn (1):
      IB/hfi1: Remove unused define


 drivers/infiniband/hw/hfi1/chip.c      |   11 +++++++-
 drivers/infiniband/hw/hfi1/rc.c        |    2 -
 drivers/infiniband/hw/hfi1/tid_rdma.c  |   43 +-------------------------------
 drivers/infiniband/hw/hfi1/user_sdma.h |    6 ----
 drivers/infiniband/hw/hfi1/verbs.c     |   17 +++++++------
 include/rdma/rdmavt_qp.h               |    9 +++----
 6 files changed, 24 insertions(+), 64 deletions(-)

-- 
Mike
