Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4790713A350
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2020 09:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgANI5U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jan 2020 03:57:20 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:4604 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgANI5U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jan 2020 03:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578992239; x=1610528239;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7P/QN+mE5uA2gC3RYx5bIwBMYDkch1X5kKWpc2yLi8E=;
  b=EtWFR7AQ1gullRgjO3BcUXzlD+lI5bYvlWUy2WO3VWkEFp0YUQjWmnjF
   FQAqWE5O4wdizHS8Kknqo6UoupHS2bFxnla6sd8QyM31h/yCWf+7uLxYY
   GBjBuWoWKD73Au2Yx0ePk6mB334y8xuDSChWpGGUamwXJH1bB1Vapf+nM
   g=;
IronPort-SDR: +TywuTKnzQZ4QPbs6XJ1y6aZ1wY0cFv81BnNHl9doV7yAYvAwBnfasU0M+LSJdo1nKk+VbQjdJ
 Dt75wT04oWdQ==
X-IronPort-AV: E=Sophos;i="5.69,432,1571702400"; 
   d="scan'208";a="12864385"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 14 Jan 2020 08:57:18 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id CB56CA1DE7;
        Tue, 14 Jan 2020 08:57:16 +0000 (UTC)
Received: from EX13D02EUB004.ant.amazon.com (10.43.166.221) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 14 Jan 2020 08:57:16 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D02EUB004.ant.amazon.com (10.43.166.221) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 14 Jan 2020 08:57:15 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.133) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 14 Jan 2020 08:57:12 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 0/6] EFA updates 2020-01-14
Date:   Tue, 14 Jan 2020 10:57:00 +0200
Message-ID: <20200114085706.82229-1-galpress@amazon.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series contains various updates to the device definitions handling
and documentation, and some cleanups to the recently introduced mmap
code.

The last patch is based on a discussion that came up during the recent
mmap machanism review on list:
https://lore.kernel.org/linux-rdma/20190920133817.GB7095@ziepe.ca/

We no longer delay the free_pages_exact call of mmaped DMA pages, as the
pages won't be freed in case they are still referenced by the vma.

Regards,
Gal

Gal Pressman (6):
  RDMA/efa: Unified getters/setters for device structs bitmask access
  RDMA/efa: Properly document the interrupt mask register
  RDMA/efa: Device definitions documentation updates
  RDMA/efa: Remove {} brackets from single statement if
  RDMA/efa: Remove unused ucontext parameter from
    efa_qp_user_mmap_entries_remove
  RDMA/efa: Do not delay freeing of DMA pages

 .../infiniband/hw/efa/efa_admin_cmds_defs.h   |  43 +++++--
 drivers/infiniband/hw/efa/efa_admin_defs.h    |   5 +
 drivers/infiniband/hw/efa/efa_com.c           | 119 ++++++++----------
 drivers/infiniband/hw/efa/efa_com_cmd.c       |  27 ++--
 drivers/infiniband/hw/efa/efa_common_defs.h   |   6 +
 drivers/infiniband/hw/efa/efa_regs_defs.h     |  13 ++
 drivers/infiniband/hw/efa/efa_verbs.c         |  27 ++--
 7 files changed, 128 insertions(+), 112 deletions(-)


base-commit: 74f75cda754eb69a77f910ceb5bc85f8e9ba56a5
-- 
2.24.1

