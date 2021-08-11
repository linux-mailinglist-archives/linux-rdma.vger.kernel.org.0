Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A7F3E9445
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Aug 2021 17:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhHKPM0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Aug 2021 11:12:26 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:32071 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbhHKPM0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Aug 2021 11:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1628694724; x=1660230724;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MKk1E/3xvyM/5aKKbQ1/0alMrDeoQi2iRQ46XVuzfps=;
  b=G5lsW3lg+IuGbKgPSH8Bhmaye/p0qCae08nPpautEWvHxountGAccy6R
   oXeJHFQQLR8wcwFnmjImIo9eqXr5qHP8ZZw5DI2KGqiFHufxJZSXahXEh
   0QaQc65a51Qu+honILIZK3j3ldds2/fYFaZPhKdYwks5lMSEjHNZQVgJi
   c=;
X-IronPort-AV: E=Sophos;i="5.84,313,1620691200"; 
   d="scan'208";a="141210525"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 11 Aug 2021 15:11:56 +0000
Received: from EX13D19EUA003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id A3476C033E;
        Wed, 11 Aug 2021 15:11:54 +0000 (UTC)
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D19EUA003.ant.amazon.com (10.43.165.175) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Wed, 11 Aug 2021 15:11:53 +0000
Received: from 8c85908914bf.ant.amazon.com.com (10.1.212.21) by
 mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1497.23 via Frontend Transport; Wed, 11 Aug 2021 15:11:51 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 0/4] EFA CQ notifications
Date:   Wed, 11 Aug 2021 18:11:27 +0300
Message-ID: <20210811151131.39138-1-galpress@amazon.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series adds support for CQ notifications through the verbs api
(ibv_req_notify_cq/ibv_get_cq_event).

In order to achieve that, a new event queue (EQ) object is introduced,
which is in charge of reporting completion events to the driver.

In addition, a new CQ doorbell is introduced that is mmapped to the
userspace provider in order to arm the CQ when requested by the user.

PR was sent:
https://github.com/linux-rdma/rdma-core/pull/1044

Thanks,
Gal

Gal Pressman (4):
  RDMA/efa: Free IRQ vectors on error flow
  RDMA/efa: Remove unused cpu field from irq struct
  RDMA/efa: Rename vector field in efa_irq struct to irqn
  RDMA/efa: CQ notifications

 drivers/infiniband/hw/efa/efa.h               |  19 +-
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 100 ++++++++-
 drivers/infiniband/hw/efa/efa_admin_defs.h    |  41 ++++
 drivers/infiniband/hw/efa/efa_com.c           | 171 +++++++++++++++
 drivers/infiniband/hw/efa/efa_com.h           |  38 +++-
 drivers/infiniband/hw/efa/efa_com_cmd.c       |  35 +++-
 drivers/infiniband/hw/efa/efa_com_cmd.h       |  10 +-
 drivers/infiniband/hw/efa/efa_main.c          | 196 +++++++++++++++---
 drivers/infiniband/hw/efa/efa_regs_defs.h     |   7 +-
 drivers/infiniband/hw/efa/efa_verbs.c         |  60 +++++-
 include/uapi/rdma/efa-abi.h                   |  18 +-
 11 files changed, 631 insertions(+), 64 deletions(-)

-- 
2.32.0

