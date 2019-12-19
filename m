Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B16C6126F9D
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2019 22:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfLSVTT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Dec 2019 16:19:19 -0500
Received: from mga05.intel.com ([192.55.52.43]:36839 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbfLSVTT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Dec 2019 16:19:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 13:19:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,333,1571727600"; 
   d="scan'208";a="241296903"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga004.fm.intel.com with ESMTP; 19 Dec 2019 13:19:19 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id xBJLJHhW002704;
        Thu, 19 Dec 2019 14:19:18 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id xBJLJFGB058604;
        Thu, 19 Dec 2019 16:19:15 -0500
Subject: [PATCH for-rc 0/4] Patches for 5.5 rc
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Thu, 19 Dec 2019 16:19:15 -0500
Message-ID: <20191219211609.58387.86077.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The first two patches I wouldn't ordinarily have sent for -rc but I noticed we
did this in the previous -rc post, add an API because we use it in the next fix.
That's what the first two patches here do. It's understandable if you are
skeptical that those are OK for -rc and in which case you can drop and we can
send for next.

---

Kaike Wan (1):
      IB/hfi1: Don't cancel unused work item

Michael J. Ruhl (1):
      IB/hfi1: List all receive contexts from debugfs

Mike Marciniszyn (2):
      IB/hfi1: Add accessor API routines to access context members
      IB/rdmavt: Correct comments in rdmavt_qp.h header


 drivers/infiniband/hw/hfi1/chip.c        |   27 ++----
 drivers/infiniband/hw/hfi1/common.h      |    3 +
 drivers/infiniband/hw/hfi1/debugfs.c     |    2 
 drivers/infiniband/hw/hfi1/driver.c      |   86 +++++++++-----------
 drivers/infiniband/hw/hfi1/file_ops.c    |   12 +--
 drivers/infiniband/hw/hfi1/hfi.h         |  129 ++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi1/init.c        |    6 +
 drivers/infiniband/hw/hfi1/iowait.c      |    4 +
 drivers/infiniband/hw/hfi1/trace_ctxts.h |    2 
 drivers/infiniband/hw/hfi1/trace_rx.h    |   13 +--
 drivers/infiniband/hw/hfi1/vnic_main.c   |    2 
 drivers/infiniband/sw/rdmavt/rc.c        |    9 ++
 include/rdma/rdmavt_qp.h                 |   22 -----
 13 files changed, 205 insertions(+), 112 deletions(-)

--
-Denny
