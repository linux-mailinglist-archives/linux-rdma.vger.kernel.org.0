Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46E7F109FC2
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2019 15:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfKZODN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Nov 2019 09:03:13 -0500
Received: from mga11.intel.com ([192.55.52.93]:55645 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727719AbfKZODN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 Nov 2019 09:03:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 06:03:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="408669898"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga005.fm.intel.com with ESMTP; 26 Nov 2019 06:03:13 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id xAQE3Brp038511;
        Tue, 26 Nov 2019 07:03:11 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id xAQE38w6057762;
        Tue, 26 Nov 2019 09:03:09 -0500
Subject: [PATCH for-next 00/11] rdmavt/hfi1 updates for next
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 26 Nov 2019 09:03:08 -0500
Message-ID: <20191126140020.57492.67772.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here are some refactoring and code reorg patches for the merge window. Nothing
too scary, no new features. This lays the ground work for stuff coming in
future merge cycles.

There is also one bug fix, from Kaike.

---

Grzegorz Andrejczuk (3):
      IB/hfi1: Move common receive IRQ code to function
      IB/hfi1: Decouple IRQ name from type
      IB/hfi1: Return void in packet receiving functions

Kaike Wan (1):
      IB/hfi1: Don't cancel unused work item

Michael J. Ruhl (1):
      IB/hfi1: List all receive contexts from debugfs

Mike Marciniszyn (6):
      IB/hfi1: Add accessor API routines to access context members
      IB/hfi1: Move chip specific functions to chip.c
      IB/hfi1: Add fast and slow handlers for receive context
      IB/hfi1: IB/hfi1: Add an API to handle special case drop
      IB/hfi1: Create API for auto activate
      IB/rdmavt: Correct comments in rdmavt_qp.h header


 drivers/infiniband/hw/hfi1/chip.c        |  187 ++++++++++++++++++------
 drivers/infiniband/hw/hfi1/chip.h        |    6 +
 drivers/infiniband/hw/hfi1/common.h      |    3 
 drivers/infiniband/hw/hfi1/debugfs.c     |    2 
 drivers/infiniband/hw/hfi1/driver.c      |  236 ++++++++++++------------------
 drivers/infiniband/hw/hfi1/file_ops.c    |   12 +-
 drivers/infiniband/hw/hfi1/hfi.h         |  193 ++++++++++++++++++++++++-
 drivers/infiniband/hw/hfi1/init.c        |   87 ++---------
 drivers/infiniband/hw/hfi1/iowait.c      |    4 -
 drivers/infiniband/hw/hfi1/msix.c        |  106 +++++++------
 drivers/infiniband/hw/hfi1/msix.h        |    1 
 drivers/infiniband/hw/hfi1/trace_ctxts.h |    2 
 drivers/infiniband/hw/hfi1/trace_rx.h    |   15 --
 drivers/infiniband/hw/hfi1/vnic_main.c   |    2 
 drivers/infiniband/sw/rdmavt/rc.c        |    9 +
 include/rdma/rdmavt_qp.h                 |   22 ---
 16 files changed, 523 insertions(+), 364 deletions(-)

--
-Denny
