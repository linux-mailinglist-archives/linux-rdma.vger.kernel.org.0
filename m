Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4EB52C6F3
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 14:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfE1Mr1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 08:47:27 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:38198 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfE1Mr1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 May 2019 08:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559047646; x=1590583646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GKnGrlF9lGI6LVWZ6ASXjPaRWw8zgYTyHg/JhCnUzW8=;
  b=G6X9wcmW4o3+Y+OuT8df/RLQrhSxrDQdjqsxGLfW8/N+6ZSORSRSeFfr
   JlIrOtv9DVtgrvFY8s3A7P+nO2L4pJl711c8pA1bmi1AaPD3iHYsKdM9Y
   tQAH9HMRztip6cBiVM52UxgkZ5oKxkOsMhAmlLmtUK1ogeoZRM6QUg8KL
   E=;
X-IronPort-AV: E=Sophos;i="5.60,523,1549929600"; 
   d="scan'208";a="802160346"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 May 2019 12:47:24 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x4SClJXs007163
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 28 May 2019 12:47:23 GMT
Received: from EX13D13EUA004.ant.amazon.com (10.43.165.22) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 May 2019 12:47:09 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D13EUA004.ant.amazon.com (10.43.165.22) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 May 2019 12:47:08 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.129) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 28 May 2019 12:47:05 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>,
        "Firas JahJah" <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-rc 6/6] RDMA/efa: Remove unused includes
Date:   Tue, 28 May 2019 15:46:18 +0300
Message-ID: <20190528124618.77918-7-galpress@amazon.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528124618.77918-1-galpress@amazon.com>
References: <20190528124618.77918-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove leftover includes that are no longer used from the driver.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa.h         | 2 --
 drivers/infiniband/hw/efa/efa_com_cmd.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 9e3cc3239c13..14a36546985b 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -7,10 +7,8 @@
 #define _EFA_H_
 
 #include <linux/bitops.h>
-#include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
-#include <linux/sched.h>
 
 #include <rdma/efa-abi.h>
 #include <rdma/ib_verbs.h>
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 14227725521c..91e7f2195802 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -3,7 +3,6 @@
  * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
-#include "efa.h"
 #include "efa_com.h"
 #include "efa_com_cmd.h"
 
-- 
2.21.0

