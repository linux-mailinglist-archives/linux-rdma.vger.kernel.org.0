Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFB913131D
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2020 14:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgAFNlm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jan 2020 08:41:42 -0500
Received: from mga01.intel.com ([192.55.52.88]:49768 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgAFNlm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jan 2020 08:41:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 05:41:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,402,1571727600"; 
   d="scan'208";a="302881073"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga001.jf.intel.com with ESMTP; 06 Jan 2020 05:41:41 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 006DfeWd037321;
        Mon, 6 Jan 2020 06:41:40 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 006Dfb0o119607;
        Mon, 6 Jan 2020 08:41:37 -0500
Subject: [PATCH for-next 0/9] Clean ups, refactror, additions
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 06 Jan 2020 08:41:37 -0500
Message-ID: <20200106133845.119356.20115.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These patches add some recactoring and code clean ups to make things more
organized. There is a performance optimization and new counter/debugging stats
added as well. The new "API" that is added is a driver internal API not an
actual "API" that is exposed to the outside.

---

Grzegorz Andrejczuk (3):
      IB/hfi1: Move common receive IRQ code to function
      IB/hfi1: Decouple IRQ name from type
      IB/hfi1: Return void in packet receiving functions

Mike Marciniszyn (6):
      IB/hfi1: Move chip specific functions to chip.c
      IB/hfi1: Add fast and slow handlers for receive context
      IB/hfi1: IB/hfi1: Add an API to handle special case drop
      IB/hfi1: Create API for auto activate
      IB/hfi1: Add software counter for ctxt0 seq drop
      IB/hfi1: Add RcvShortLengthErrCnt to hfi1stats


 drivers/infiniband/hw/hfi1/chip.c           |  171 ++++++++++++++++++++++-----
 drivers/infiniband/hw/hfi1/chip.h           |    8 +
 drivers/infiniband/hw/hfi1/chip_registers.h |    1 
 drivers/infiniband/hw/hfi1/driver.c         |  151 +++++++++---------------
 drivers/infiniband/hw/hfi1/hfi.h            |   66 ++++++++++
 drivers/infiniband/hw/hfi1/init.c           |   81 ++-----------
 drivers/infiniband/hw/hfi1/msix.c           |  106 +++++++++--------
 drivers/infiniband/hw/hfi1/msix.h           |    1 
 drivers/infiniband/hw/hfi1/trace_rx.h       |    6 -
 9 files changed, 337 insertions(+), 254 deletions(-)

--
-Denny
