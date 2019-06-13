Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C91D543AB9
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 17:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbfFMPXP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 11:23:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:38797 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731891AbfFMMaj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Jun 2019 08:30:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 05:30:38 -0700
X-ExtLoop1: 1
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jun 2019 05:30:37 -0700
Received: from awdrv-06.aw.intel.com (awdrv-06.aw.intel.com [10.228.212.220])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x5DCUaxc009834;
        Thu, 13 Jun 2019 05:30:36 -0700
Received: from awdrv-06.aw.intel.com (localhost [127.0.0.1])
        by awdrv-06.aw.intel.com (8.14.7/8.14.7) with ESMTP id x5DCUYuE005337;
        Thu, 13 Jun 2019 08:30:34 -0400
Subject: [RESEND PATCH v2 0/2] Completion rework
To:     jgg@ziepe.ca, dledford@redhat.com
From:   Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Thu, 13 Jun 2019 08:30:34 -0400
Message-ID: <20190613123013.5297.32797.stgit@awdrv-06.aw.intel.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This two patch patch series is resend of:
- https://marc.info/?l=linux-rdma&m=155499222312346&w=2
- https://marc.info/?l=linux-rdma&m=155499221212340&w=2

Jason raised issues in:
- https://marc.info/?l=linux-rdma&m=155611789008362&w=2

And Andrea and others surfaced issues with the post send
side API use in:
- https://marc.info/?a=152205460700001&r=1&w=2

These patches address those issues.

Thanks,
Mike
---

Mike Marciniszyn (2):
      IB/rdmavt: Add new completion inline
      IB/{rdmavt, qib, hfi1}: Convert to new completion API


 drivers/infiniband/hw/hfi1/rc.c    |   26 +--------
 drivers/infiniband/hw/qib/qib_rc.c |   26 +--------
 drivers/infiniband/sw/rdmavt/qp.c  |   31 +++-------
 include/rdma/rdmavt_qp.h           |  108 ++++++++++++++++++++++++------------
 4 files changed, 89 insertions(+), 102 deletions(-)
