Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A22F286CD1
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 04:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgJHCgh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Oct 2020 22:36:37 -0400
Received: from smtprelay0085.hostedemail.com ([216.40.44.85]:51392 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726400AbgJHCgh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Oct 2020 22:36:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 57877181D337B;
        Thu,  8 Oct 2020 02:36:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:973:988:989:1260:1311:1314:1345:1437:1515:1534:1542:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2903:3138:3139:3140:3141:3142:3353:3865:3867:3868:3871:3874:4250:4321:4559:4605:5007:6261:8603:8957:10004:10848:11026:11658:11914:12043:12048:12296:12297:12555:12679:12895:12986:13161:13229:13870:13894:14096:14394:14721:21080:21433:21451:21627:30054:30062,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: table34_1a085dd271d4
X-Filterd-Recvd-Size: 3500
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu,  8 Oct 2020 02:36:35 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, target-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH-next 0/4] RDMA: sprintf to sysfs_emit conversions
Date:   Wed,  7 Oct 2020 19:36:23 -0700
Message-Id: <cover.1602122879.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A recent commit added a sysfs_emit and sysfs_emit_at to allow various
sysfs show functions to ensure that the PAGE_SIZE buffer argument is
never overrun and always NUL terminated.

Convert the RDMA/InfiniBand subsystem to use these new functions.

The first 2 patches exclusively used coccinelle to convert uses.
The third and fourth patches were done manually.

Compiled allyesconfig and defconfig with all infiniband options selected
no warnings, but untested, no hardward

Overall object size is reduced

total size: allyesconfig x86-64
new: 8364003	1680968	 131520	10176491 9b47eb	(TOTALS)
old: 8365883	1681032	 131520	10178435 9b4f83	(TOTALS)

total size: defconfig x86-64 with all infiniband selected
new; 1359153	 131228	   1910  1492291 16c543	(TOTALS)
old: 1359422	 131228	   1910  1492560 16c650	(TOTALS)

Joe Perches (4):
  RDMA: Convert sysfs device * show functions to use sysfs_emit()
  RDMA: Convert sysfs kobject * show functions to use sysfs_emit()
  RDMA: manual changes for sysfs_emit and neatening
  RDMA: Convert various random sprintf sysfs _show uses to sysfs_emit

 drivers/infiniband/core/cm.c                  |   4 +-
 drivers/infiniband/core/cma_configfs.c        |   4 +-
 drivers/infiniband/core/sysfs.c               | 155 ++++++++++--------
 drivers/infiniband/core/ucma.c                |   2 +-
 drivers/infiniband/core/user_mad.c            |   6 +-
 drivers/infiniband/core/uverbs_main.c         |   4 +-
 drivers/infiniband/hw/bnxt_re/main.c          |   4 +-
 drivers/infiniband/hw/cxgb4/provider.c        |  13 +-
 drivers/infiniband/hw/hfi1/sysfs.c            |  62 ++++---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c     |   6 +-
 drivers/infiniband/hw/mlx4/main.c             |   9 +-
 drivers/infiniband/hw/mlx4/mcg.c              |  82 +++++----
 drivers/infiniband/hw/mlx4/sysfs.c            |  70 ++++----
 drivers/infiniband/hw/mlx5/main.c             |  13 +-
 drivers/infiniband/hw/mthca/mthca_provider.c  |  33 ++--
 drivers/infiniband/hw/ocrdma/ocrdma_main.c    |   4 +-
 drivers/infiniband/hw/qedr/main.c             |  10 +-
 drivers/infiniband/hw/qib/qib_sysfs.c         |  91 +++++-----
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c  | 104 +++++-------
 .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |   6 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c         |   2 +-
 drivers/infiniband/ulp/ipoib/ipoib_cm.c       |   4 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c     |   7 +-
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c     |   2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c  |  60 +++----
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c  |  20 +--
 drivers/infiniband/ulp/srp/ib_srp.c           |  49 +++---
 drivers/infiniband/ulp/srpt/ib_srpt.c         |  14 +-
 28 files changed, 423 insertions(+), 417 deletions(-)

-- 
2.26.0

