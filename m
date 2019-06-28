Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E55B5A316
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 20:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfF1SEP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 14:04:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:27226 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfF1SEP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jun 2019 14:04:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 11:04:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,428,1557212400"; 
   d="scan'208";a="185714302"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jun 2019 11:04:14 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x5SI4DMt055082;
        Fri, 28 Jun 2019 11:04:13 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x5SI4Aow067637;
        Fri, 28 Jun 2019 14:04:11 -0400
Subject: [PATCH for-next v5 0/3] IB/hfi1: Clean up and refactor some CQ code
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Fri, 28 Jun 2019 14:04:10 -0400
Message-ID: <20190628180316.67586.73737.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Doug and Jason,

This is really a resubmit of some code clean up we floated a while back. The
main goal here is to clean up some of the stuff which should be in the uapi
directory vs in in the driver directory. Then to break the single lock for 
recv wqe processing.

The accompanying user bits should already be in a PR on GitHub.

Change log documented below each commit message.

This latest update is a rebase ontop of wip/for-testing also a small change
in the first patch to remove the open coded container_of in favor of the
helper routine.

---

Kamenee Arumugam (3):
      IB/hfi1: Move rvt_cq_wc struct into uapi directory
      IB/hfi1: Move receive work queue struct into uapi directory
      IB/rdmavt: Fracture single lock used for posting and processing RWQEs


 drivers/infiniband/hw/hfi1/qp.c    |    4 -
 drivers/infiniband/sw/rdmavt/cq.c  |  192 +++++++++++++++++++----------
 drivers/infiniband/sw/rdmavt/qp.c  |  239 +++++++++++++++++++++++++-----------
 drivers/infiniband/sw/rdmavt/qp.h  |    2 
 drivers/infiniband/sw/rdmavt/rc.c  |   41 ++++--
 drivers/infiniband/sw/rdmavt/srq.c |   69 ++++++----
 include/rdma/rdmavt_cq.h           |   22 ++-
 include/rdma/rdmavt_qp.h           |   91 +++++++++++---
 include/uapi/rdma/rvt-abi.h        |   61 +++++++++
 9 files changed, 503 insertions(+), 218 deletions(-)
 create mode 100644 include/uapi/rdma/rvt-abi.h

--
-Denny
