Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9852299CF
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 16:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgGVOI6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 10:08:58 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:18178 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgGVOI6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 10:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595426938; x=1626962938;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zJM16J6+rY97ma9upB39CRCMXO2OvDXSopXeH4R3j1A=;
  b=QdYOTLocjCCrFRkwEqGsUho+mMKZfg1tDiAFNvy6TMdoHTel3IOz/pWr
   d5KtHvggXE4DEPO54P6UFFyyy45oCVJfJgu1kWhh3gIntrFYjtcIv1uUU
   x5gwbWnD2T7JYkUEEyaXMXO7PtWnKZo0ybirsyjTNzk8KKG3X7547dY4M
   g=;
IronPort-SDR: O0jW1Ap1iGJ2tx3V71K5drzTuwvRHDadR3EI8k00cv7PJ7TOVoV/QcNvdHmyuHlKXfN7Ti9YCN
 7bM1WdPuoKzA==
X-IronPort-AV: E=Sophos;i="5.75,383,1589241600"; 
   d="scan'208";a="60717674"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 22 Jul 2020 14:03:28 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (Postfix) with ESMTPS id 68CAAA292D;
        Wed, 22 Jul 2020 14:03:27 +0000 (UTC)
Received: from EX13D02EUC003.ant.amazon.com (10.43.164.10) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 22 Jul 2020 14:03:26 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D02EUC003.ant.amazon.com (10.43.164.10) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 22 Jul 2020 14:03:25 +0000
Received: from 8c85908914bf.ant.amazon.com (10.95.83.32) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 22 Jul 2020 14:03:22 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next v4 0/4] Add support for 0xefa1 device
Date:   Wed, 22 Jul 2020 17:03:08 +0300
Message-ID: <20200722140312.3651-1-galpress@amazon.com>
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
v3->v4: https://lore.kernel.org/linux-rdma/20200721133049.74349-1-galpress@amazon.com/
* Remove the user_comp_handshakes array and use the macros explicitly.
* Make efa_user_comp_handshake static.
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

 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 15 ++++++-
 drivers/infiniband/hw/efa/efa_com_cmd.c       |  2 +
 drivers/infiniband/hw/efa/efa_com_cmd.h       |  2 +
 drivers/infiniband/hw/efa/efa_main.c          |  6 ++-
 drivers/infiniband/hw/efa/efa_verbs.c         | 42 +++++++++++++++++++
 include/uapi/rdma/efa-abi.h                   | 15 ++++++-
 6 files changed, 77 insertions(+), 5 deletions(-)


base-commit: 8e7eafb816ab7e5047b74cb8eb1db2f8f14f7d7a
-- 
2.27.0

