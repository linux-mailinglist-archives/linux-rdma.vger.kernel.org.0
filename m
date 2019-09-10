Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E08CAEBC7
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2019 15:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbfIJNnU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Sep 2019 09:43:20 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:19205 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbfIJNnU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Sep 2019 09:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568122999; x=1599658999;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tvWoJ/MqN/esgDVcvyWdbSPdDh4L0OUAgXV9ErN39JI=;
  b=iiIJIW2ie4mF9KnnbLm88KONW/wUF1dlZ742X8CB26ME92LUgFRtvLxB
   OCwQThIWr9tSnMQd1r/FMwBs4nWah0rGeF6CYKSjHHSeJ8LkPeCLtX+hg
   Vr+c+lSKeQT+avjhMPLywYiRH/hWJdz8gX3oepA5d3D2JA400kMo0QUH8
   I=;
X-IronPort-AV: E=Sophos;i="5.64,489,1559520000"; 
   d="scan'208";a="420406728"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 10 Sep 2019 13:43:17 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (Postfix) with ESMTPS id B63F3A23EE;
        Tue, 10 Sep 2019 13:43:16 +0000 (UTC)
Received: from EX13D19EUA001.ant.amazon.com (10.43.165.74) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Sep 2019 13:43:16 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D19EUA001.ant.amazon.com (10.43.165.74) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Sep 2019 13:43:15 +0000
Received: from 8c85908914bf.ant.amazon.com (10.95.79.108) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 10 Sep 2019 13:43:11 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 0/4] EFA RDMA read support
Date:   Tue, 10 Sep 2019 14:42:57 +0100
Message-ID: <20190910134301.4194-1-galpress@amazon.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

The following series introduces RDMA read support and capabilities
reporting to the EFA driver.

The first two patches aren't directly related to RDMA read, but refactor
some bits in the device capabilities struct.

The last two patches add support for remote read access in MR
registration and expose the RDMA read related attributes to the
userspace library.

PR was sent:
https://github.com/linux-rdma/rdma-core/pull/576

Thanks,
Gal

Daniel Kranzdorf (2):
  RDMA/efa: Support remote read access in MR registration
  RDMA/efa: Expose RDMA read related attributes

Gal Pressman (2):
  RDMA/efa: Fix incorrect error print
  RDMA/efa: Store network attributes in device attributes

 drivers/infiniband/hw/efa/efa.h               |  2 -
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 29 +++++++++++--
 drivers/infiniband/hw/efa/efa_com_cmd.c       | 41 ++++++++-----------
 drivers/infiniband/hw/efa/efa_com_cmd.h       | 18 +++-----
 drivers/infiniband/hw/efa/efa_main.c          | 16 --------
 drivers/infiniband/hw/efa/efa_verbs.c         | 15 ++++---
 include/uapi/rdma/efa-abi.h                   |  3 ++
 7 files changed, 59 insertions(+), 65 deletions(-)

-- 
2.23.0

