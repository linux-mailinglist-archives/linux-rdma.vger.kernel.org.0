Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C027E0D4
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 19:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbfHARPR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 13:15:17 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:54239 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfHARPR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Aug 2019 13:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564679715; x=1596215715;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mURuWpzoyWtJup8bvx+blXupMIL9jpSaarB8MFDmq9g=;
  b=q+28JX6Y/oBA901VKZrf1nxdnP0K/XV7suB2geqNBxbmDDtWamzPhEDN
   isw1xivd1JHQpIiWkWAsx5UGswWNMrcKdvEgDoYpEswo4L6/4JEOzbzW2
   h5M2JLFHyFwIbxgTC6ICJBxwciCjAqNLgl8B5FwNp3OA2ysdgkaRnlUtC
   s=;
X-IronPort-AV: E=Sophos;i="5.64,334,1559520000"; 
   d="scan'208";a="690027415"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 01 Aug 2019 17:15:04 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS id 46F40A2133;
        Thu,  1 Aug 2019 17:15:04 +0000 (UTC)
Received: from EX13D19EUA001.ant.amazon.com (10.43.165.74) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Aug 2019 17:15:03 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D19EUA001.ant.amazon.com (10.43.165.74) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Aug 2019 17:15:02 +0000
Received: from 8c85908914bf.ant.amazon.com (10.95.68.21) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 1 Aug 2019 17:14:59 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        "Leon Romanovsky" <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next v2 0/2] Ratelimited ibdev printk functions
Date:   Thu, 1 Aug 2019 20:14:45 +0300
Message-ID: <20190801171447.54440-1-galpress@amazon.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

This implements ratelimited ibdev printk functions, similar to their
dev_*_ratelimited counterparts.

I've submitted the first patch before [1] without usage, I'm now adding
the corresponding EFA patch as well.

cxgb4, hfi1, mlx4, vmw_pvrdma, rdmavt and rxe could also benefit from
this if they move to ibvdev prints:

$ git grep ratelimited -- drivers/infiniband/[hs]w
drivers/infiniband/hw/cxgb4/mem.c:		pr_warn_ratelimited("%s: dma map failure (non fatal)\n",
drivers/infiniband/hw/cxgb4/resource.c:		pr_warn_ratelimited("%s: Out of RQT memory\n",
drivers/infiniband/hw/hfi1/chip.c:		dd_dev_info_ratelimited(dd, "DCC Error: fmconfig error: %s\n",
drivers/infiniband/hw/hfi1/chip.c:		dd_dev_info_ratelimited(dd, "DCC Error: PortRcv error: %s\n"
drivers/infiniband/hw/hfi1/chip.c:		dd_dev_info_ratelimited(dd, "8051 access to LCB blocked\n");
drivers/infiniband/hw/hfi1/chip.c:		dd_dev_info_ratelimited(dd, "host access to LCB blocked\n");
drivers/infiniband/hw/hfi1/chip.c:		dd_dev_info_ratelimited(dd, "DCC Error: %s\n",
drivers/infiniband/hw/hfi1/chip.c:		dd_dev_info_ratelimited(dd, "%s: PortErrorAction bounce\n",
drivers/infiniband/hw/hfi1/chip.c:		dd_dev_info_ratelimited(dd, "SDMA engine %u interrupt, but no status bits set\n",
drivers/infiniband/hw/hfi1/hfi.h:#define dd_dev_err_ratelimited(dd, fmt, ...) \
drivers/infiniband/hw/hfi1/hfi.h:	dev_err_ratelimited(&(dd)->pcidev->dev, "%s: " fmt, \
drivers/infiniband/hw/hfi1/hfi.h:#define dd_dev_warn_ratelimited(dd, fmt, ...) \
drivers/infiniband/hw/hfi1/hfi.h:	dev_warn_ratelimited(&(dd)->pcidev->dev, "%s: " fmt, \
drivers/infiniband/hw/hfi1/hfi.h:#define dd_dev_info_ratelimited(dd, fmt, ...) \
drivers/infiniband/hw/hfi1/hfi.h:	dev_info_ratelimited(&(dd)->pcidev->dev, "%s: " fmt, \
drivers/infiniband/hw/hfi1/mad.c:		pr_err_ratelimited("hfi1: Invalid trap 0x%0x dropped. Total dropped: %d\n",
drivers/infiniband/hw/hfi1/mad.c:			pr_warn_ratelimited("hfi1: Maximum trap limit reached for 0x%0x traps\n",
drivers/infiniband/hw/mlx4/qp.c:	pr_warn_ratelimited("Unexpected event type %d on WQ 0x%06x. Events are not supported for WQs\n",
drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c:			dev_warn_ratelimited(&dev->pdev->dev,
drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c:			dev_warn_ratelimited(&dev->pdev->dev,
drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c:			dev_warn_ratelimited(&dev->pdev->dev,
drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c:			dev_warn_ratelimited(&dev->pdev->dev,
drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c:				dev_warn_ratelimited(&dev->pdev->dev,
drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c:				dev_warn_ratelimited(&dev->pdev->dev,
drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c:					dev_warn_ratelimited(&dev->pdev->dev,
drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c:			dev_warn_ratelimited(&dev->pdev->dev,
drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c:			dev_warn_ratelimited(&dev->pdev->dev,
drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c:			dev_warn_ratelimited(&dev->pdev->dev,
drivers/infiniband/sw/rdmavt/cq.c:			rvt_pr_err_ratelimited(rdi, "CQ is full!\n");
drivers/infiniband/sw/rdmavt/vt.h:#define rvt_pr_err_ratelimited(rdi, fmt, ...) \
drivers/infiniband/sw/rdmavt/vt.h:	__rvt_pr_err_ratelimited((rdi)->driver_f.get_pci_dev(rdi), \
drivers/infiniband/sw/rdmavt/vt.h:#define __rvt_pr_err_ratelimited(pdev, name, fmt, ...) \
drivers/infiniband/sw/rdmavt/vt.h:	dev_err_ratelimited(&(pdev)->dev, "%s: " fmt, name, ##__VA_ARGS__)
drivers/infiniband/sw/rxe/rxe.h:		pr_warn_ratelimited("failed crc calculation, err: %d\n", err);
drivers/infiniband/sw/rxe/rxe_net.c:		pr_err_ratelimited("no route to %pI4\n", &daddr->s_addr);
drivers/infiniband/sw/rxe/rxe_net.c:		pr_err_ratelimited("no route to %pI6\n", daddr);
drivers/infiniband/sw/rxe/rxe_recv.c:			pr_warn_ratelimited("bad qp type\n");
drivers/infiniband/sw/rxe/rxe_recv.c:			pr_warn_ratelimited("bad qp type\n");
drivers/infiniband/sw/rxe/rxe_recv.c:			pr_warn_ratelimited("bad qp type\n");
drivers/infiniband/sw/rxe/rxe_recv.c:		pr_warn_ratelimited("unsupported qp type\n");
drivers/infiniband/sw/rxe/rxe_recv.c:			pr_warn_ratelimited("bad pkey = 0x%x\n", pkey);
drivers/infiniband/sw/rxe/rxe_recv.c:			pr_warn_ratelimited("bad pkey = 0x%0x\n", pkey);
drivers/infiniband/sw/rxe/rxe_recv.c:			pr_warn_ratelimited("bad qkey, got 0x%x expected 0x%x for qpn 0x%x\n",
drivers/infiniband/sw/rxe/rxe_recv.c:		pr_warn_ratelimited("port %d != qp port %d\n",
drivers/infiniband/sw/rxe/rxe_recv.c:			pr_warn_ratelimited("dst addr %pI4 != qp source addr %pI4\n",
drivers/infiniband/sw/rxe/rxe_recv.c:			pr_warn_ratelimited("source addr %pI4 != qp dst addr %pI4\n",
drivers/infiniband/sw/rxe/rxe_recv.c:			pr_warn_ratelimited("dst addr %pI6 != qp source addr %pI6\n",
drivers/infiniband/sw/rxe/rxe_recv.c:			pr_warn_ratelimited("source addr %pI6 != qp dst addr %pI6\n",
drivers/infiniband/sw/rxe/rxe_recv.c:		pr_warn_ratelimited("bad tver\n");
drivers/infiniband/sw/rxe/rxe_recv.c:			pr_warn_ratelimited("no qp matches qpn 0x%x\n", qpn);
drivers/infiniband/sw/rxe/rxe_recv.c:			pr_warn_ratelimited("no grh for mcast qpn\n");
drivers/infiniband/sw/rxe/rxe_recv.c:		pr_warn_ratelimited("failed matching dgid\n");
drivers/infiniband/sw/rxe/rxe_recv.c:			pr_warn_ratelimited("bad ICRC from %pI6c\n",
drivers/infiniband/sw/rxe/rxe_recv.c:			pr_warn_ratelimited("bad ICRC from %pI4\n",
drivers/infiniband/sw/rxe/rxe_recv.c:			pr_warn_ratelimited("bad ICRC from unknown\n");
drivers/infiniband/sw/rxe/rxe_resp.c:		pr_err_ratelimited("Failed sending ack\n");
drivers/infiniband/sw/rxe/rxe_resp.c:		pr_err_ratelimited("Failed sending ack\n");

[1] https://patchwork.kernel.org/patch/10926991/

Changelog:
v2:
* Remove the DEBUG part as requested by Leon

Thanks,
Gal

Gal Pressman (2):
  RDMA/core: Introduce ratelimited ibdev printk functions
  RDMA/efa: Rate limit admin queue error prints

 drivers/infiniband/hw/efa/efa_com.c     |  70 ++++++------
 drivers/infiniband/hw/efa/efa_com_cmd.c | 136 ++++++++++++++----------
 include/rdma/ib_verbs.h                 |  42 ++++++++
 3 files changed, 162 insertions(+), 86 deletions(-)

-- 
2.22.0

