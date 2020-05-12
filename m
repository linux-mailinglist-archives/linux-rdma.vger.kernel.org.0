Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0811CF8FD
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 17:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgELPWh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 11:22:37 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:36765 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgELPWg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 May 2020 11:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589296956; x=1620832956;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6AZvmrFZnxGesxy1v+6YEQBK8AbJeKJH9ECJi3So/5I=;
  b=Vvi3lRB1flsfqVrdcCq32I81lfwnDWiuK3WMPaYRfZIyq4hOjRwUtQ9y
   8FGHq2tA4ADKHjxX5HJRUkpUnCu/8xNeRkxREg5S4b4lNiafOlZDI4bDx
   U7ZGHC9ExxZ3nynPVCtFpYiD2FIaRMqXVePY4HE2oiw4u6sAZXqdxhfou
   M=;
IronPort-SDR: R5txopOGzA/Vu8cVZk2zT3XjzFZumWrTS5n12tH9tCSEkFEwJH11Bk4E5pV0VZ+FeZPoVKIJTv
 6mSgCX1GTHig==
X-IronPort-AV: E=Sophos;i="5.73,384,1583193600"; 
   d="scan'208";a="30056172"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 12 May 2020 15:22:11 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id 33C6EA1FAB;
        Tue, 12 May 2020 15:22:09 +0000 (UTC)
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 12 May 2020 15:22:09 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 12 May 2020 15:22:08 +0000
Received: from 8c85908914bf.ant.amazon.com (10.85.94.2) by
 mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 12 May 2020 15:22:06 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next v2 0/2] EFA host information
Date:   Tue, 12 May 2020 18:22:02 +0300
Message-ID: <20200512152204.93091-1-galpress@amazon.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

This submission adds support for host information report to the EFA
device. The feature allows the driver to inform the EFA device firmware
with system configuration used for debugging and troubleshooting
purposes.

Changelog -
v1->v2: https://lore.kernel.org/linux-rdma/20200510115918.46246-1-galpress@amazon.com/
* Added #include <linux/version.h> (reported by kbuild test robot)
* Remove unused values per Leon's request
* Explicitly set all fields in the host info buffer

Gal Pressman (2):
  RDMA/efa: Fix setting of wrong bit in get/set_feature commands
  RDMA/efa: Report host information to the device

 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 63 ++++++++++++++++++-
 drivers/infiniband/hw/efa/efa_com_cmd.c       | 18 +++---
 drivers/infiniband/hw/efa/efa_com_cmd.h       | 11 +++-
 drivers/infiniband/hw/efa/efa_main.c          | 52 ++++++++++++++-
 4 files changed, 132 insertions(+), 12 deletions(-)

-- 
2.26.2

