Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB4E29B63
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 17:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389496AbfEXPog (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 11:44:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:25507 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389206AbfEXPog (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 May 2019 11:44:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 08:44:36 -0700
X-ExtLoop1: 1
Received: from sedona.ch.intel.com ([10.2.136.157])
  by FMSMGA003.fm.intel.com with ESMTP; 24 May 2019 08:44:36 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x4OFiYwG006130;
        Fri, 24 May 2019 08:44:34 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x4OFiWcF010658;
        Fri, 24 May 2019 11:44:32 -0400
Subject: [PATCH for-rc 0/5] Patches for 5.2 rc cycle
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Fri, 24 May 2019 11:44:32 -0400
Message-ID: <20190524154320.10588.44693.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix a couple bugs. One with pinning unaligned virtual addresses, rturn correct
value when user asks for it via verbs call and a day one issue with freeze
work. Also fix-up a checkpatch violation that resulted from another patch
removing lines.

---

Dennis Dalessandro (1):
      IB/hfi1: Fix checkpatch single line if

Kamenee Arumugam (1):
      IB/hfi1: Validate page aligned for a given virtual address

Mike Marciniszyn (3):
      IB/rdmavt: Fix alloc_qpn() WARN_ON()
      IB/hfi1: Insure freeze_work work_struct is canceled on shutdown
      IB/{qib, hfi1, rdmavt}: Correct ibv_devinfo max_mr value


 drivers/infiniband/hw/hfi1/chip.c         |    1 +
 drivers/infiniband/hw/hfi1/pio.c          |    3 +--
 drivers/infiniband/hw/hfi1/user_exp_rcv.c |    3 +++
 drivers/infiniband/hw/hfi1/verbs.c        |    2 --
 drivers/infiniband/hw/qib/qib_verbs.c     |    2 --
 drivers/infiniband/sw/rdmavt/mr.c         |    2 ++
 drivers/infiniband/sw/rdmavt/qp.c         |    3 ++-
 7 files changed, 9 insertions(+), 7 deletions(-)

--
-Denny
