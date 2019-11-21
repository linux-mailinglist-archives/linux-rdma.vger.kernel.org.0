Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3FA0105428
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 15:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfKUOPb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 09:15:31 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:29156 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfKUOPb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Nov 2019 09:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1574345731; x=1605881731;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KChwu6oA3qOJ3twdUWqxa+Xt4l0VqafubX92VAlUWZo=;
  b=Y1NN9/azYTrp9F0cflHHEmdTIO7VMYJoW242ddwsojC0qDpe+TD6s7lj
   xuWrniTxQfvCQRcqM6XqeNqQddJSYvYgLIU1Bwttx4KJ1lfiiF72SG3oB
   QAYdwhoXaHxD32+3mWXzyd6o92dZFt4PLktsWsVEGX6oSQviuElGBnovc
   M=;
IronPort-SDR: 7iWbSuhbn4rEmD8n/O24LvCEdZ3dN5rnlkipuPNpn8v7wcejnVOmjjkPVPLP/84HOL8L+VhmSD
 kAScLKqBe2fw==
X-IronPort-AV: E=Sophos;i="5.69,226,1571702400"; 
   d="scan'208";a="647604"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 21 Nov 2019 14:15:18 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id C9147A224F;
        Thu, 21 Nov 2019 14:15:17 +0000 (UTC)
Received: from EX13D19EUA002.ant.amazon.com (10.43.165.247) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 21 Nov 2019 14:15:17 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D19EUA002.ant.amazon.com (10.43.165.247) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 21 Nov 2019 14:15:16 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.146) by
 mail-relay.amazon.com (10.43.60.129) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 21 Nov 2019 14:15:14 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next v2 0/3] EFA RDMA read support
Date:   Thu, 21 Nov 2019 16:15:06 +0200
Message-ID: <20191121141509.59297-1-galpress@amazon.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello all,

The following series introduces RDMA read support and capabilities
reporting to the EFA driver.

RDMA read support, maximum transfer size and max SGEs per RDMA WR are
now being reported to the userspace library through the query device
verb.
In addition, remote read access is supported by the register MR verb.

PR was sent:
https://github.com/linux-rdma/rdma-core/pull/613

Changelog -
v1->v2: https://lore.kernel.org/linux-rdma/20191112091737.40204-1-galpress@amazon.com/
* Use max_sge_rd field in ib_device_attr struct instead of duplicating
  it in vendor specific ABI.

Thanks,
Gal

Daniel Kranzdorf (2):
  RDMA/efa: Support remote read access in MR registration
  RDMA/efa: Expose RDMA read related attributes

Gal Pressman (1):
  RDMA/efa: Store network attributes in device attributes

 drivers/infiniband/hw/efa/efa.h               |  2 -
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 29 ++++++++++++--
 drivers/infiniband/hw/efa/efa_com_cmd.c       | 40 ++++++++-----------
 drivers/infiniband/hw/efa/efa_com_cmd.h       | 19 +++------
 drivers/infiniband/hw/efa/efa_main.c          | 16 --------
 drivers/infiniband/hw/efa/efa_verbs.c         | 31 +++++++++-----
 include/uapi/rdma/efa-abi.h                   |  6 +++
 7 files changed, 76 insertions(+), 67 deletions(-)

-- 
2.24.0

