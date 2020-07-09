Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA09F219AF3
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2020 10:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgGIIgt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jul 2020 04:36:49 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:49710 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgGIIgt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jul 2020 04:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594283808; x=1625819808;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n0DbkCP4pXkfzDC63yN38Qtng+T3XIeDQHrq4JJ9DEE=;
  b=ckK1YR8QDSwHf4ZkdGUCilu8gXZuyUzwC8yn9qM7tbdNQFTa+sND2mVb
   RPkG5f3GgrC2xCemyafJLVMdW5i0fBLD/nmwXizUAVK3hAlnR7uGPeEB8
   N45bZLv/AHCMNy77pC2MuEbDkrAL0F718m0RmuepIEULQRs4cLt5UwbqM
   c=;
IronPort-SDR: OyfPwV7Lmoydq0P2gYR988747vgjbvUe7stEeSr/ALTsuPmwH5dBGhedKkq4JICPJ+Nkk3hjSm
 CvSenVHbidfA==
X-IronPort-AV: E=Sophos;i="5.75,331,1589241600"; 
   d="scan'208";a="40903579"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 09 Jul 2020 08:36:47 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id 95EBCA04CB;
        Thu,  9 Jul 2020 08:36:46 +0000 (UTC)
Received: from EX13D02EUC004.ant.amazon.com (10.43.164.117) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 9 Jul 2020 08:36:46 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D02EUC004.ant.amazon.com (10.43.164.117) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 9 Jul 2020 08:36:44 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.213.15) by
 mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 9 Jul 2020 08:36:42 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 0/3] Add support for 0xefa1 device
Date:   Thu, 9 Jul 2020 11:36:27 +0300
Message-ID: <20200709083630.21377-1-galpress@amazon.com>
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

Regards,
Gal

Gal Pressman (3):
  RDMA/efa: Expose maximum TX doorbell batch
  RDMA/efa: Expose minimum SQ size
  RDMA/efa: Add EFA 0xefa1 PCI ID

 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 15 +++++++++++++--
 drivers/infiniband/hw/efa/efa_com_cmd.c         |  2 ++
 drivers/infiniband/hw/efa/efa_com_cmd.h         |  2 ++
 drivers/infiniband/hw/efa/efa_main.c            |  6 ++++--
 drivers/infiniband/hw/efa/efa_verbs.c           |  2 ++
 include/uapi/rdma/efa-abi.h                     |  5 ++++-
 6 files changed, 27 insertions(+), 5 deletions(-)


base-commit: d473f4dc2f95c8c856b1659ced3502802b7d2fbe
-- 
2.27.0

