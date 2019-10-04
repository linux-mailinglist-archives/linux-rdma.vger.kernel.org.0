Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF0ECC455
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 22:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbfJDUkd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 16:40:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:9074 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbfJDUkd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Oct 2019 16:40:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 13:40:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,257,1566889200"; 
   d="scan'208";a="276158717"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga001.jf.intel.com with ESMTP; 04 Oct 2019 13:40:32 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x94KeV13057928;
        Fri, 4 Oct 2019 13:40:31 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x94KePvx026608;
        Fri, 4 Oct 2019 16:40:26 -0400
Subject: [PATCH for-rc 0/2] Updates for 5.4 rc cycle
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Fri, 04 Oct 2019 16:40:25 -0400
Message-ID: <20191004203739.26542.57060.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here are two pretty straight forward fixes. The first from Kaike fixes a TID
RDMA bug and the other is for an issue raised on the list by Dan Carpenter: 

https://marc.info/?l=linux-rdma&m=157001856105835&w=2


---

Kaike Wan (1):
      IB/hfi1: Avoid excessive retry for TID RDMA READ request

Mike Marciniszyn (1):
      IB/hfi1: Use a common pad buffer for 9B and 16B packets


 drivers/infiniband/hw/hfi1/sdma.c     |    5 +++--
 drivers/infiniband/hw/hfi1/tid_rdma.c |    5 -----
 drivers/infiniband/hw/hfi1/verbs.c    |   10 ++++------
 3 files changed, 7 insertions(+), 13 deletions(-)

--
-Denny
