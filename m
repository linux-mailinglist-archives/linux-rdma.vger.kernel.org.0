Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146842280F3
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jul 2020 15:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgGUNbU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jul 2020 09:31:20 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:59424 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgGUNbU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jul 2020 09:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595338280; x=1626874280;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m8VS41Y1hVbmtgcBUUDiF3YmhyRZM/CsrGMXl88qWrM=;
  b=vFpgNKGuseM84gRdGzDejsmS8EWAl8whgt6dZdJdWijzU9JovxE/adBB
   bPClEq5eoSq6SH3av9QUcm11ssfEe3244IMhWaNHw7OrSNYBqHcxfNU64
   DVZUFzHYsbXpspSpHP/KL9oJZCsz7e//E8IMzrFBK6qrzNtWOXBNcSLZq
   A=;
IronPort-SDR: HJ9nxVp9Jj8dm2Z4d+pnGSqiyN4ZVAbQMpSOl3xIJ3gedfrQ39tyDjif0rLGCAICgX3+2heLmK
 HWtrbrFopBKg==
X-IronPort-AV: E=Sophos;i="5.75,378,1589241600"; 
   d="scan'208";a="53364008"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 21 Jul 2020 13:31:17 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id 105CAA49C0;
        Tue, 21 Jul 2020 13:31:16 +0000 (UTC)
Received: from EX13D02EUC003.ant.amazon.com (10.43.164.10) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 21 Jul 2020 13:31:16 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D02EUC003.ant.amazon.com (10.43.164.10) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 21 Jul 2020 13:31:07 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.213.11) by
 mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 21 Jul 2020 13:31:03 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next v3 0/4] Add support for 0xefa1 device
Date:   Tue, 21 Jul 2020 16:30:45 +0300
Message-ID: <20200721133049.74349-1-galpress@amazon.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

The following submission adds the needed functionality in order to
support 0xefa1 devices, and adds it to the driver pci table.

PR was sent:
https://github.com/linux-rdma/rdma-core/pull/789

Changelog -
v2->v3: https://lore.kernel.org/linux-rdma/20200720080113.13055-1-galpress@amazon.com/
* Remove gcc specific stuff to fix clang compilation.
v1->v2: https://lore.kernel.org/linux-rdma/20200709083630.21377-1-galpress@amazon.com/
* Add handshake with userspace provider to verify required features
  support.

Regards,
Gal

Gal Pressman (4):
  RDMA/efa: Expose maximum TX doorbell batch
  RDMA/efa: Expose minimum SQ size
  RDMA/efa: User/kernel compatibility handshake mechanism
  RDMA/efa: Add EFA 0xefa1 PCI ID

 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 15 +++++-
 drivers/infiniband/hw/efa/efa_com_cmd.c       |  2 +
 drivers/infiniband/hw/efa/efa_com_cmd.h       |  2 +
 drivers/infiniband/hw/efa/efa_main.c          |  6 ++-
 drivers/infiniband/hw/efa/efa_verbs.c         | 51 +++++++++++++++++++
 include/uapi/rdma/efa-abi.h                   | 15 +++++-
 6 files changed, 86 insertions(+), 5 deletions(-)


base-commit: 5f0b2a6093a4d9aab093964c65083fe801ef1e58
-- 
2.27.0

