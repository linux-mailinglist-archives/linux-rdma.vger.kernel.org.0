Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9FAB463F8
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 18:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbfFNQZd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 12:25:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:18718 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfFNQZd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 12:25:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 09:25:32 -0700
X-ExtLoop1: 1
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jun 2019 09:25:31 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x5EGPUYK060530;
        Fri, 14 Jun 2019 09:25:31 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x5EGPS8u044673;
        Fri, 14 Jun 2019 12:25:28 -0400
Subject: [PATCH for-next v4 0/3] Clean up and refactor some CQ code
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Fri, 14 Jun 2019 12:25:28 -0400
Message-ID: <20190614162435.44620.72298.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is really a resubmit of some code clean up we floated a while back. The
main goal here is to clean up some of the stuff which should be in the uapi
directory vs in in the driver directory. Then to break the single lock for 
recv wqe processing.

The accompanying user bits should already be in a PR on GitHub.

Change log documented below each commit message.

---

Kamenee Arumugam (3):
      IB/hfi1: Move rvt_cq_wc struct into uapi directory
      IB/hfi1: Move receive work queue struct into uapi directory
      IB/rdmavt: Fracture single lock used for posting and processing RWQEs


 drivers/infiniband/hw/hfi1/qp.c    |    4 -
 drivers/infiniband/sw/rdmavt/cq.c  |  191 ++++++++++++++++++-----------
 drivers/infiniband/sw/rdmavt/qp.c  |  239 +++++++++++++++++++++++++-----------
 drivers/infiniband/sw/rdmavt/qp.h  |    2 
 drivers/infiniband/sw/rdmavt/rc.c  |   41 ++++--
 drivers/infiniband/sw/rdmavt/srq.c |   69 ++++++----
 include/rdma/rdmavt_cq.h           |   22 ++-
 include/rdma/rdmavt_qp.h           |   91 +++++++++++---
 include/uapi/rdma/rvt-abi.h        |   61 +++++++++
 9 files changed, 502 insertions(+), 218 deletions(-)
 create mode 100644 include/uapi/rdma/rvt-abi.h

--
-Denny
