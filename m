Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8E31CCAA5
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2020 13:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgEJL71 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 May 2020 07:59:27 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:14167 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgEJL71 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 May 2020 07:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589111967; x=1620647967;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OEp+MRIzt0hcxN8N20JdFPxTmOYq2g9YK3ZFg2nHYWY=;
  b=I5/ssoIC8ciwzF8wGxgTd53+uvMOGX5ECgnuB60VyBifOpWl7Z/VEK1W
   kDypVJu6RLzec3KR8rt7/eIlBGrt8O1dxsegZ3p2mmFhXy7QoHAKJyUCZ
   qW3fZksPAFAd1j8exOPhMiOTBd3XAuxVbFPtL2DDYygH7mouybVHiXfcZ
   4=;
IronPort-SDR: IBT16mfJqtMvU9ZSmttZL+QgP8vkK7YS3oocYyZd0Orr4t//yczqPARMYYexQ2nOLVY4ZLES+p
 F5GTFDjMeLAg==
X-IronPort-AV: E=Sophos;i="5.73,375,1583193600"; 
   d="scan'208";a="34012548"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 10 May 2020 11:59:26 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id 266D41415F1;
        Sun, 10 May 2020 11:59:23 +0000 (UTC)
Received: from EX13D02EUC003.ant.amazon.com (10.43.164.10) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 11:59:23 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D02EUC003.ant.amazon.com (10.43.164.10) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 11:59:22 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.212.6) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sun, 10 May 2020 11:59:20 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 0/2] EFA host information
Date:   Sun, 10 May 2020 14:59:16 +0300
Message-ID: <20200510115918.46246-1-galpress@amazon.com>
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

Gal Pressman (2):
  RDMA/efa: Fix setting of wrong bit in get/set_feature commands
  RDMA/efa: Report host information to the device

 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 64 ++++++++++++++++++-
 drivers/infiniband/hw/efa/efa_com_cmd.c       | 18 +++---
 drivers/infiniband/hw/efa/efa_com_cmd.h       | 11 +++-
 drivers/infiniband/hw/efa/efa_main.c          | 46 ++++++++++++-
 4 files changed, 127 insertions(+), 12 deletions(-)


base-commit: a97bf49f824e357f1cc5d292e247d05271d32afe
-- 
2.26.2

