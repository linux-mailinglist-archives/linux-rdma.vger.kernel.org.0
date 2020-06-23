Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0243820625D
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 23:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393136AbgFWU7v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 16:59:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:40863 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389527AbgFWUko (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jun 2020 16:40:44 -0400
IronPort-SDR: hCeEus1bv+i2l4qNCRrsKj+Etn4stgJ4Rpi/TLXFWXVtwnofn8oS5F+/uGBT69RAExv0g+M7LV
 +axWDYmYSsIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="145710527"
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="145710527"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 13:40:44 -0700
IronPort-SDR: H6v2si+PROypudfv5vcPW2RS8tHHFFJJ1m4L6/NBIrSHA6O5YVlg6zTOKiEBZqAorrErFbdJx4
 eC8Ex7pPmg1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="263442587"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jun 2020 13:40:44 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 05NKeghs057563;
        Tue, 23 Jun 2020 13:40:43 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 05NKefLv107962;
        Tue, 23 Jun 2020 16:40:41 -0400
Subject: [PATCH for-rc v2 0/2] minor hfi1 fixes
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 23 Jun 2020 16:40:41 -0400
Message-ID: <20200623203524.107638.62465.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a follow up from [1] and contains the re-work Kaike did to address
feedback.

[1]
https://lore.kernel.org/linux-rdma/20200512030622.189865.65024.stgit@awfm-01.aw.intel.com/T/#t

---

Kaike Wan (2):
      IB/hfi1: Do not destroy hfi1_wq when the device is shut down
      IB/hfi1: Do not destroy link_wq when the device is shut down


 drivers/infiniband/hw/hfi1/init.c     |   37 +++++++++++++++++++++++++--------
 drivers/infiniband/hw/hfi1/qp.c       |    5 ++++
 drivers/infiniband/hw/hfi1/tid_rdma.c |    5 ++++
 3 files changed, 36 insertions(+), 11 deletions(-)

--
-Denny
