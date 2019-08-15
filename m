Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFD38F45A
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2019 21:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbfHOTUb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Aug 2019 15:20:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:39050 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbfHOTUb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Aug 2019 15:20:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 12:20:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="377186430"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga006.fm.intel.com with ESMTP; 15 Aug 2019 12:20:31 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x7FJKSwj038467;
        Thu, 15 Aug 2019 12:20:29 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x7FJKQDW105986;
        Thu, 15 Aug 2019 15:20:27 -0400
Subject: [PATCH for-rc 0/5] Fixes TID packet ordering issues
To:     jgg@ziepe.ca, dledford@redhat.com
From:   Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Thu, 15 Aug 2019 15:20:26 -0400
Message-ID: <20190815192013.105923.63792.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch patch series fixes a issues caused
by packet ordering when adaptive routing is in
use.

---
Kaike Wan (5):
      IB/hfi1: Drop stale TID RDMA packets
      IB/hfi1: Unsafe PSN checking for TID RDMA READ Resp packet
      IB/hfi1: Add additional checks when handling TID RDMA READ RESP packet
      IB/hfi1: Add additional checks when handling TID RDMA WRITE DATA packet
      IB/hfi1: Drop stale TID RDMA packets that cause TIDErr


 drivers/infiniband/hw/hfi1/tid_rdma.c |   76 ++++++++++++---------------------
 1 file changed, 27 insertions(+), 49 deletions(-)

-- 
Thanks,
Mike
