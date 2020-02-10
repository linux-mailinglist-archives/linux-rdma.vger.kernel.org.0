Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73F061578CA
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 14:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgBJNK0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 08:10:26 -0500
Received: from mga17.intel.com ([192.55.52.151]:31214 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729359AbgBJNKY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Feb 2020 08:10:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 05:10:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="256126298"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga004.fm.intel.com with ESMTP; 10 Feb 2020 05:10:24 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 01ADAMP1007510;
        Mon, 10 Feb 2020 06:10:22 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 01ADAKXD087626;
        Mon, 10 Feb 2020 08:10:20 -0500
Subject: [PATCH for-rc 0/3] Series short description
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 10 Feb 2020 08:10:20 -0500
Message-ID: <20200210130712.87408.34564.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here are some fixes for the current rc cycle. The first fixes a potential data
corruption and involves adding a mutex lock around a missed criitcal section.
The other two patches are a bit more involved but they fix panics.

---

Kaike Wan (2):
      IB/hfi1: Acquire lock to release TID entries when user file is closed
      IB/rdmavt: Reset all QPs when the device is shut down

Mike Marciniszyn (1):
      IB/hfi1: Close window for pq and request coliding


 drivers/infiniband/hw/hfi1/file_ops.c     |   52 +++++++++++-------
 drivers/infiniband/hw/hfi1/hfi.h          |    5 +-
 drivers/infiniband/hw/hfi1/user_exp_rcv.c |    5 +-
 drivers/infiniband/hw/hfi1/user_sdma.c    |   17 ++++--
 drivers/infiniband/sw/rdmavt/qp.c         |   84 ++++++++++++++++++-----------
 5 files changed, 101 insertions(+), 62 deletions(-)

--
-Denny
