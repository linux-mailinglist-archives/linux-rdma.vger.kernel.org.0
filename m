Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0462EA912
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jan 2021 11:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbhAEKoc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jan 2021 05:44:32 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:61361 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbhAEKoc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jan 2021 05:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1609843472; x=1641379472;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iP/MX3finb2nrCTJ16wt9m9js/cgSZP5uiyhnHEJGaU=;
  b=Tnss6UbP5hrUW1wLLc7BH/h9jKKBNbWSu2gcyq2IIStHoP7ZV0dFX81E
   XiIGg2uvyWYUp1i/WDZzb9K774ifmsOWBA8s7AyM7qe4BlQC0iFh6J7eo
   8GF1XGCntrNkPeKIFNohf+wuVtdwIq7J01aaQgGB6II2SYgCZthwH/3Pk
   Y=;
X-IronPort-AV: E=Sophos;i="5.78,476,1599523200"; 
   d="scan'208";a="108304748"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 05 Jan 2021 10:43:45 +0000
Received: from EX13D19EUB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id A44D1A1F3B;
        Tue,  5 Jan 2021 10:43:44 +0000 (UTC)
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 5 Jan 2021 10:43:43 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.212.6) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 5 Jan 2021 10:43:39 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 0/2] Host information userspace version
Date:   Tue, 5 Jan 2021 12:43:24 +0200
Message-ID: <20210105104326.67895-1-galpress@amazon.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The following two patches add the userspace version to the host
information struct reported to the device, used for debugging and
troubleshooting purposes.

PR was sent:
https://github.com/linux-rdma/rdma-core/pull/918

Thanks,
Gal

Gal Pressman (2):
  RDMA/efa: Move host info set to first ucontext allocation
  RDMA/efa: Report userspace version in host info

 drivers/infiniband/hw/efa/efa.h                 | 7 +++++++
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 3 +++
 drivers/infiniband/hw/efa/efa_main.c            | 6 +++---
 drivers/infiniband/hw/efa/efa_verbs.c           | 3 +++
 include/uapi/rdma/efa-abi.h                     | 3 ++-
 5 files changed, 18 insertions(+), 4 deletions(-)


base-commit: e246b7c035d74abfb3507fa10082d0c42cc016c3
-- 
2.30.0

