Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281A91CF901
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 17:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgELPW7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 11:22:59 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:24811 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgELPW7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 May 2020 11:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589296979; x=1620832979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bJ6zDS8x71rLTQZsGHIH8XtAW/At1MWx3/vZ6rmMadY=;
  b=l2Kf1yN2jkxnkWnwmWYdvMHiC6aB0JbP7VliGJWJSSFnRqDgl1nSKN1u
   n3itQdKP+zFgY1YSLWRgMPJJKX+CHhosPLH6p89hVwmYUdZhfd+XJqfgm
   OreOMImX5igemN3ML31Ta78PNn2hBeujYrLhjDRy5pwuGRFib95T35Z7x
   0=;
IronPort-SDR: krFV9Pna34c+jNuhQpC3PVDfEL2sM5Zi9GIYReSgl0KzLYMHIhwPhiiIimdVt51hrJlP9+XzQ1
 AaX6d3SNelwA==
X-IronPort-AV: E=Sophos;i="5.73,384,1583193600"; 
   d="scan'208";a="31248335"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 12 May 2020 15:22:14 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id E9547A22C6;
        Tue, 12 May 2020 15:22:12 +0000 (UTC)
Received: from EX13D02EUB003.ant.amazon.com (10.43.166.172) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 12 May 2020 15:22:12 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D02EUB003.ant.amazon.com (10.43.166.172) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 12 May 2020 15:22:10 +0000
Received: from 8c85908914bf.ant.amazon.com (10.85.94.2) by
 mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 12 May 2020 15:22:09 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        "Yossi Leybovich" <sleybo@amazon.com>
Subject: [PATCH for-next v2 1/2] RDMA/efa: Fix setting of wrong bit in get/set_feature commands
Date:   Tue, 12 May 2020 18:22:03 +0300
Message-ID: <20200512152204.93091-2-galpress@amazon.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512152204.93091-1-galpress@amazon.com>
References: <20200512152204.93091-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When using a control buffer the ctrl_data bit should be set in order to
indicate the control buffer address is valid, not ctrl_data_indirect
which is used when the control buffer itself is indirect.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_com_cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index eea5574a62e8..69f842c92ff6 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -388,7 +388,7 @@ static int efa_com_get_feature_ex(struct efa_com_dev *edev,
 
 	if (control_buff_size)
 		EFA_SET(&get_cmd.aq_common_descriptor.flags,
-			EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA_INDIRECT, 1);
+			EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA, 1);
 
 	efa_com_set_dma_addr(control_buf_dma_addr,
 			     &get_cmd.control_buffer.address.mem_addr_high,
@@ -540,7 +540,7 @@ static int efa_com_set_feature_ex(struct efa_com_dev *edev,
 	if (control_buff_size) {
 		set_cmd->aq_common_descriptor.flags = 0;
 		EFA_SET(&set_cmd->aq_common_descriptor.flags,
-			EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA_INDIRECT, 1);
+			EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA, 1);
 		efa_com_set_dma_addr(control_buf_dma_addr,
 				     &set_cmd->control_buffer.address.mem_addr_high,
 				     &set_cmd->control_buffer.address.mem_addr_low);
-- 
2.26.2

