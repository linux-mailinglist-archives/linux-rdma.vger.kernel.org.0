Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4348B225992
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jul 2020 10:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgGTIBo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jul 2020 04:01:44 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:17210 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgGTIBo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jul 2020 04:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595232105; x=1626768105;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4JUwrNiSJZwSVwrsBeW/YCoDSq7HGL1IpIHRkIHroU8=;
  b=i/akHcUGhHdZF2gEVGXDi64e2gkQCvX7SrNw1mmAsTTyz8PtCFKhfWrY
   BkB9oP6+AyWC3aQcelKFMTXI3ESWrU6P2rHTc7/bQvP3b8MsURPfAH0Fu
   51655+5G/gw1edMfGCnkLSc2PVoRDXiAmFwEMCyIENqdjSrTl04ANyvN+
   o=;
IronPort-SDR: QNmgXJ4j9uurPHyIqy9b+UhiEaXjDXppQRpKcn9mvpJETYRFKk94M9OXMCjCLNaxGkB6kH+wtM
 /0iOaIuYWdGQ==
X-IronPort-AV: E=Sophos;i="5.75,374,1589241600"; 
   d="scan'208";a="52800276"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 20 Jul 2020 08:01:30 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id 5413DA30B1;
        Mon, 20 Jul 2020 08:01:28 +0000 (UTC)
Received: from EX13D02EUC004.ant.amazon.com (10.43.164.117) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 20 Jul 2020 08:01:27 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D02EUC004.ant.amazon.com (10.43.164.117) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 20 Jul 2020 08:01:26 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.212.12) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 20 Jul 2020 08:01:23 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next v2 0/4] Add support for 0xefa1 device
Date:   Mon, 20 Jul 2020 11:01:09 +0300
Message-ID: <20200720080113.13055-1-galpress@amazon.com>
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

 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 15 ++++-
 drivers/infiniband/hw/efa/efa_com_cmd.c       |  2 +
 drivers/infiniband/hw/efa/efa_com_cmd.h       |  2 +
 drivers/infiniband/hw/efa/efa_main.c          |  6 +-
 drivers/infiniband/hw/efa/efa_verbs.c         | 62 +++++++++++++++++++
 include/uapi/rdma/efa-abi.h                   | 15 ++++-
 6 files changed, 97 insertions(+), 5 deletions(-)


base-commit: 5f0b2a6093a4d9aab093964c65083fe801ef1e58
-- 
2.27.0

