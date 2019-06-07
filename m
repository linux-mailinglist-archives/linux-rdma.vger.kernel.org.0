Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3864338939
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 13:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfFGLjK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 07:39:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:63621 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbfFGLjK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jun 2019 07:39:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 04:39:09 -0700
X-ExtLoop1: 1
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga002.jf.intel.com with ESMTP; 07 Jun 2019 04:39:09 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x57Bd7GM054227;
        Fri, 7 Jun 2019 04:39:08 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x57Bd5cp157965;
        Fri, 7 Jun 2019 07:39:05 -0400
Subject: [PATCH for-rc 0/3] IB/hfi1: Fixes for 5.2 RC cycle
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Fri, 07 Jun 2019 07:39:05 -0400
Message-ID: <20190607113807.157915.48581.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We have a couple of fixes we'd like to try and get into the rc cycle. These 3
are all targeted to stable as well. One fixes an issue of not validating user
input that was reported by Dan C. We have a race condition that leads to a
hung SDMA engine as well as a fix for a problem when verbs and kdeth packets
get processed on different cpus for the same qp.

---

Kaike Wan (1):
      IB/hfi1: Validate fault injection opcode user input

Mike Marciniszyn (2):
      IB/hfi1: Close PSM sdma_progress sleep window
      IB/hfi1: Correct tid qp rcd to match verbs context


 drivers/infiniband/hw/hfi1/chip.c      |   13 +++++++++++++
 drivers/infiniband/hw/hfi1/chip.h      |    1 +
 drivers/infiniband/hw/hfi1/fault.c     |    5 +++++
 drivers/infiniband/hw/hfi1/fault.h     |    6 +++---
 drivers/infiniband/hw/hfi1/tid_rdma.c  |    5 ++---
 drivers/infiniband/hw/hfi1/user_sdma.c |   12 ++++--------
 drivers/infiniband/hw/hfi1/user_sdma.h |    1 -
 7 files changed, 28 insertions(+), 15 deletions(-)

--
-Denny
