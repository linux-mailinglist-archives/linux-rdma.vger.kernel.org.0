Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E50F0187470
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2020 22:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbgCPVEy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Mar 2020 17:04:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:14982 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732607AbgCPVEy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Mar 2020 17:04:54 -0400
IronPort-SDR: MnnnLKEkKs2p21kdbTSOTizHdt2fVuyaqRIGvoALD3q/Q4yHtPL5yrFUSwlgHoMKuUN2HnUGYZ
 zk6XaXGfiqnQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 14:04:53 -0700
IronPort-SDR: uQIxzUmaWtjgRjTbF9UOsAC0NtWOymj4H7XVOPzkyihBsoxRgdckXwxVZIxANpBiGZ3YvqeZc4
 Bdjscv3F3DIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,561,1574150400"; 
   d="scan'208";a="443502322"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga005.fm.intel.com with ESMTP; 16 Mar 2020 14:04:53 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 02GL4nvG017709;
        Mon, 16 Mar 2020 14:04:50 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 02GL4lxP007907;
        Mon, 16 Mar 2020 17:04:47 -0400
Subject: [PATCH for-next 0/3] Clean up and improvements for 5.7
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 16 Mar 2020 17:04:47 -0400
Message-ID: <20200316210246.7753.40221.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here are some clean up/improvement patches. Mike got rid of dead code and Kaike
took a stab at fixing the kobj and cdev complaints.  This serious should
go before the AIP posting. I'll be posting a v2 of the AIP code soon, and I
think I still owe a response on one issue. Coming up, but for now it's just
these 3.

---

Kaike Wan (2):
      IB/hfi1: Remove kobj from hfi1_devdata
      IB/hfi1: Use the ibdev in hfi1_devdata as the parent of cdev

Mike Marciniszyn (1):
      IB/rdmavt: Delete unused routine


 drivers/infiniband/hw/hfi1/device.c   |   23 ++++++++++++-----
 drivers/infiniband/hw/hfi1/file_ops.c |    9 ++-----
 drivers/infiniband/hw/hfi1/hfi.h      |    3 --
 drivers/infiniband/hw/hfi1/init.c     |   44 ++++++++++-----------------------
 drivers/infiniband/sw/rdmavt/vt.c     |    6 -----
 5 files changed, 32 insertions(+), 53 deletions(-)

--
-Denny
