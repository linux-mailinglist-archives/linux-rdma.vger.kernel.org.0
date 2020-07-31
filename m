Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE95233EDE
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jul 2020 08:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbgGaGEp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jul 2020 02:04:45 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:59474 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730170AbgGaGEp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 Jul 2020 02:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596175484; x=1627711484;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yQqY3VyGLjGjZklM/QNDMbNhuzBqWQYUeypHj8GDXWQ=;
  b=UM8c48pYkjptBmrU1jz8LgIEVC8oFEYUB57J9lZXLaextD3nNkzYepxv
   WNLZGS6z5LEw6zRoIquUtqS47BY0z6iQ6iZV4oxAXGUCVvi7KzRJ30nbf
   2zBM5zFhIjKNrh73KNUELDyvCRR0Z2/wviaKoUCCJRBydpS6GeX30Zcm5
   k=;
IronPort-SDR: Fv1CrZPKHvgkc1X52Pwn9Xw04Zk/oB8dcS8DqH5N3lpycp76x4RxrEci6Kj8UoPj7HmLfTvW5q
 1pnuIjVzQyUg==
X-IronPort-AV: E=Sophos;i="5.75,417,1589241600"; 
   d="scan'208";a="45131785"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 31 Jul 2020 06:04:43 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id A4198A216E;
        Fri, 31 Jul 2020 06:04:42 +0000 (UTC)
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 31 Jul 2020 06:04:41 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 31 Jul 2020 06:04:40 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.212.6) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 31 Jul 2020 06:04:38 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 0/4] SRD RNR retry counter
Date:   Fri, 31 Jul 2020 09:04:16 +0300
Message-ID: <20200731060420.17053-1-galpress@amazon.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series adds support for RNR retry counter on SRD QPs through the
modify QP verb.

As the SRD QP state machine is no longer identical to the one of UD QPs,
an SRD state machine is added to the driver.

PR was sent:
https://github.com/linux-rdma/rdma-core/pull/799

Regards,
Gal

Gal Pressman (4):
  RDMA/efa: Add a generic capability check helper
  RDMA/efa: Be consistent with modify QP bitmask
  RDMA/efa: Introduce SRD QP state machine
  RDMA/efa: Introduce SRD RNR retry

 .../infiniband/hw/efa/efa_admin_cmds_defs.h   |  39 +++--
 drivers/infiniband/hw/efa/efa_com_cmd.c       |   2 +
 drivers/infiniband/hw/efa/efa_com_cmd.h       |   2 +
 drivers/infiniband/hw/efa/efa_verbs.c         | 161 ++++++++++++++++--
 include/uapi/rdma/efa-abi.h                   |   3 +-
 5 files changed, 175 insertions(+), 32 deletions(-)


base-commit: 8b603d0715a372f5827d3a6b19d9568bf854b687
-- 
2.27.0

