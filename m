Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B522C194467
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2020 17:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgCZQiE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Mar 2020 12:38:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:25525 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727502AbgCZQiE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Mar 2020 12:38:04 -0400
IronPort-SDR: vT4bo/dV+dXhlb9/6pPb58Hnxv8jtcim+NOHnycHkKUYSnk9ePyi2O2lw1XK/x1/6RaVaMfTJU
 LN2DQBDa4JZw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 09:38:04 -0700
IronPort-SDR: U9FwR6GHmZIbWnpCViZcrJeCPcQlIFd7iVu35nKv9vtntRA0OTYy/xk1Z5EUhCs8Q0c3C1zgLf
 9G8+yG/joxOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,309,1580803200"; 
   d="scan'208";a="271234627"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga004.fm.intel.com with ESMTP; 26 Mar 2020 09:38:04 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 02QGc2sU004623;
        Thu, 26 Mar 2020 09:38:03 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 02QGbxIC021301;
        Thu, 26 Mar 2020 12:38:00 -0400
Subject: [PATCH for-rc 0/2] Pre-req for hfi1 cdev rework
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Thu, 26 Mar 2020 12:37:59 -0400
Message-ID: <20200326163619.21129.13002.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Kaike found a couple issues while working on the cdev stuff. Here are two fixes
that should probably precede those patches (which are yet to be posted)

---

Kaike Wan (2):
      IB/hfi1: Fix memory leaks in sysfs registration and unregistration
      IB/hfi1: Call kobject_put() when kobject_init_and_add() fails


 drivers/infiniband/hw/hfi1/sysfs.c |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

--
-Denny
