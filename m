Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382DD287ACD
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 19:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbgJHRSI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 13:18:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:43048 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728780AbgJHRSH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Oct 2020 13:18:07 -0400
IronPort-SDR: 66JQmYILR86tvKuPCKKwRYjoAnjUnysmrZ2HtUNHKVtdR4kQKWV/hhKrWL8ctRezk55veaUZs4
 Cb+9xVTQJA3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="161913390"
X-IronPort-AV: E=Sophos;i="5.77,351,1596524400"; 
   d="scan'208";a="161913390"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 10:18:07 -0700
IronPort-SDR: 5fHfkN4sDF0vmHtzirSyD7drsM6oLjc3bornOVMuQUB82IsCxgy9SfpzNC7X6B/4fxxI9BPBDm
 L1n7vieJgxEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,351,1596524400"; 
   d="scan'208";a="298158660"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga008.fm.intel.com with ESMTP; 08 Oct 2020 10:18:07 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 098HI5wK026807;
        Thu, 8 Oct 2020 10:18:05 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 098HI3XA189122;
        Thu, 8 Oct 2020 13:18:03 -0400
Subject: [PATCH for-next] IB/hfi,rdmavt,qib,opa_vnic: Update MAINTAINERS
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Date:   Thu, 08 Oct 2020 13:18:03 -0400
Message-ID: <20201008171803.189100.43448.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Intel has spun off the Omni-Path Architecture group which is now a new
company known as Cornelis Networks. Updating the MAINTAINERS file to
reflect this change and our new email addresses.

Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 MAINTAINERS |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f0068bc..ab7b69f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7726,8 +7726,8 @@ F:	include/linux/cciss*.h
 F:	include/uapi/linux/cciss*.h
 
 HFI1 DRIVER
-M:	Mike Marciniszyn <mike.marciniszyn@intel.com>
-M:	Dennis Dalessandro <dennis.dalessandro@intel.com>
+M:	Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
+M:	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 F:	drivers/infiniband/hw/hfi1
@@ -12861,8 +12861,8 @@ S:	Maintained
 F:	drivers/char/hw_random/optee-rng.c
 
 OPA-VNIC DRIVER
-M:	Dennis Dalessandro <dennis.dalessandro@intel.com>
-M:	Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
+M:	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
+M:	Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 F:	drivers/infiniband/ulp/opa_vnic
@@ -14154,8 +14154,8 @@ F:	drivers/firmware/qemu_fw_cfg.c
 F:	include/uapi/linux/qemu_fw_cfg.h
 
 QIB DRIVER
-M:	Dennis Dalessandro <dennis.dalessandro@intel.com>
-M:	Mike Marciniszyn <mike.marciniszyn@intel.com>
+M:	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
+M:	Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 F:	drivers/infiniband/hw/qib/
@@ -14577,8 +14577,8 @@ S:	Maintained
 F:	drivers/net/ethernet/rdc/r6040.c
 
 RDMAVT - RDMA verbs software
-M:	Dennis Dalessandro <dennis.dalessandro@intel.com>
-M:	Mike Marciniszyn <mike.marciniszyn@intel.com>
+M:	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
+M:	Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 F:	drivers/infiniband/sw/rdmavt

