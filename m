Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6140D16BFC2
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2020 12:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbgBYLkh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Feb 2020 06:40:37 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:11773 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbgBYLkh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Feb 2020 06:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582630838; x=1614166838;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3EQWcXNOkTDAl17VxoxKk2LaJbYaPqc3zLnpFXzIX88=;
  b=tgPxl0Aj4rxOwAgw9/HjfTsHQ71yIPQBB5yAvDLVJQwjNMTrD8V+sHhh
   eWT7Bp+dHTZo+iwJIhqEWBk9LHu5mLEMkBY1SfxcyEsFr9crflQiUIssZ
   VsPR0TOrs3qgNGdWOc1uqwf/HQfBwZ1KohRpPrlpnQUhZdjq8a9JDJYg1
   o=;
IronPort-SDR: 65kU7F+pNIyv9yfdZ6BEFFHPgjFZ4m5gkLDT/LUb2AJvrceElBECXasZh/2gz21BsKHoAEq/fQ
 qAOVTDUiKo1w==
X-IronPort-AV: E=Sophos;i="5.70,483,1574121600"; 
   d="scan'208";a="18765649"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 25 Feb 2020 11:40:25 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id 29B2BA267D;
        Tue, 25 Feb 2020 11:40:24 +0000 (UTC)
Received: from EX13D02EUB001.ant.amazon.com (10.43.166.150) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 25 Feb 2020 11:40:23 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D02EUB001.ant.amazon.com (10.43.166.150) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 25 Feb 2020 11:40:22 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.132) by
 mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1236.3 via Frontend Transport; Tue, 25 Feb 2020 11:40:20 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next v2 0/3] EFA updates 2020-02-25
Date:   Tue, 25 Feb 2020 13:40:07 +0200
Message-ID: <20200225114010.21790-1-galpress@amazon.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series contains various updates to the device definitions handling
and documentation.

The last patch is based on a discussion that came up during the recent
mmap machanism review on list:
https://lore.kernel.org/linux-rdma/20190920133817.GB7095@ziepe.ca/

We no longer delay the free_pages_exact call of mmaped DMA pages, as the
pages won't be freed in case they are still referenced by the vma.

Changelog -
v1->v2: https://lore.kernel.org/linux-rdma/20200114085706.82229-1-galpress@amazon.com/
* Use FIELD_GET and FIELD_PREP for EFA_GET/SET
* Make sure to mask (clear) the field before ORing it with a new value
* Clarify the commit message of the last patch
* Reorder the cleanup in the last commit, entry removal now happens
  first

Gal Pressman (3):
  RDMA/efa: Unified getters/setters for device structs bitmask access
  RDMA/efa: Properly document the interrupt mask register
  RDMA/efa: Do not delay freeing of DMA pages

 .../infiniband/hw/efa/efa_admin_cmds_defs.h   |   7 +-
 drivers/infiniband/hw/efa/efa_admin_defs.h    |   4 +-
 drivers/infiniband/hw/efa/efa_com.c           | 146 ++++++++----------
 drivers/infiniband/hw/efa/efa_com_cmd.c       |  29 ++--
 drivers/infiniband/hw/efa/efa_common_defs.h   |  13 +-
 drivers/infiniband/hw/efa/efa_regs_defs.h     |  25 +--
 drivers/infiniband/hw/efa/efa_verbs.c         |  44 +++---
 7 files changed, 119 insertions(+), 149 deletions(-)


base-commit: f03d9fadfe13a78ee28fec320d43f7b37574adcb
-- 
2.25.0

