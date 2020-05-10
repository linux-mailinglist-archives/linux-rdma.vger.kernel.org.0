Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804601CCAA6
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2020 13:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgEJL7k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 May 2020 07:59:40 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:49317 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbgEJL7k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 May 2020 07:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589111980; x=1620647980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bJ6zDS8x71rLTQZsGHIH8XtAW/At1MWx3/vZ6rmMadY=;
  b=uuVtI4sDWfTlrys3yDTCdLk23BMd/i0WJKF89Dl1MwqkmmVyB+cLmIFG
   pAY/EVGG7f91WtEjhutmUGc3DCndzRN347pb3lx2n6qGT7kUIDgbdSke3
   ziPOCV9wMd+jOOUl9faB0jpMa8wt7Hq2Fv5DOdyU6C2+g37mb7aYQ+/Lq
   0=;
IronPort-SDR: cgGXivronPa5eaMChYtmGN+kdWzpbJa4KmNSGqxoVgPgYza6BiAWG18d5oBtokvayIcEaX9BgC
 g1X9V9E86DqQ==
X-IronPort-AV: E=Sophos;i="5.73,375,1583193600"; 
   d="scan'208";a="29532637"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 10 May 2020 11:59:28 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id CF14AA2081;
        Sun, 10 May 2020 11:59:26 +0000 (UTC)
Received: from EX13D13EUB004.ant.amazon.com (10.43.166.84) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 11:59:26 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D13EUB004.ant.amazon.com (10.43.166.84) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 11:59:25 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.212.6) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sun, 10 May 2020 11:59:22 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        "Yossi Leybovich" <sleybo@amazon.com>
Subject: [PATCH for-next 1/2] RDMA/efa: Fix setting of wrong bit in get/set_feature commands
Date:   Sun, 10 May 2020 14:59:17 +0300
Message-ID: <20200510115918.46246-2-galpress@amazon.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200510115918.46246-1-galpress@amazon.com>
References: <20200510115918.46246-1-galpress@amazon.com>
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

