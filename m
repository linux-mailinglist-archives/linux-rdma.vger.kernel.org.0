Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE54AFB5D
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2019 13:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfIKLaj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Sep 2019 07:30:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:14614 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfIKLaj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Sep 2019 07:30:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2019 04:30:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="360109047"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga005.jf.intel.com with ESMTP; 11 Sep 2019 04:30:38 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x8BBUa0F065275;
        Wed, 11 Sep 2019 04:30:37 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x8BBUYQK126099;
        Wed, 11 Sep 2019 07:30:34 -0400
Subject: [PATCH for-next 0/3] hfi1 and rdmavt fixes for next cycle
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Wed, 11 Sep 2019 07:30:34 -0400
Message-ID: <20190911112912.126040.72184.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here are some small patches for the next merge window. The traces patch requires
one that is already in 5.3-rc4 and not yet in for-next. There will be a conflict
otherwise. Easy to resolve but will also conflict when merge with Linus. The 
pre-req patch is: IB/hfi1: Unsafe PSN checking for TID RDMA READ Resp packet [1]

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=35d5c8b82e2c32e8e29ca195bb4dac60ba7d97fc

---

Ira Weiny (1):
      IB/hfi1: Define variables as unsigned long to fix KASAN warning

Kaike Wan (2):
      IB/hfi1: Add traces for TID RDMA READ
      IB/{rdmavt, hfi1, qib}: Add a counter for credit waits


 drivers/infiniband/hw/hfi1/chip.c      |    2 +
 drivers/infiniband/hw/hfi1/chip.h      |    1 +
 drivers/infiniband/hw/hfi1/mad.c       |   45 ++++++++++++++------------------
 drivers/infiniband/hw/hfi1/rc.c        |   15 +++++------
 drivers/infiniband/hw/hfi1/tid_rdma.c  |    8 ++++++
 drivers/infiniband/hw/hfi1/trace_tid.h |   38 +++++++++++++++++++++++++++
 drivers/infiniband/hw/qib/qib_rc.c     |   10 +------
 drivers/infiniband/hw/qib/qib_sysfs.c  |    2 +
 include/rdma/rdma_vt.h                 |    1 +
 include/rdma/rdmavt_qp.h               |   35 +++++++++++++++++++++++++
 10 files changed, 115 insertions(+), 42 deletions(-)

--
-Denny
