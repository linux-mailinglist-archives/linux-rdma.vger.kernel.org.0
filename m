Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D53DB45F9
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2019 05:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbfIQDYd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Sep 2019 23:24:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56180 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbfIQDYc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Sep 2019 23:24:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C8E33082E4E;
        Tue, 17 Sep 2019 03:24:32 +0000 (UTC)
Received: from dhcp-128-227.nay.redhat.com (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B69725D9DC;
        Tue, 17 Sep 2019 03:24:30 +0000 (UTC)
From:   Honggang LI <honli@redhat.com>
To:     bvanassche@acm.org, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, Honggang Li <honli@redhat.com>
Subject: [patch v2 1/2] IB/srp: Add parse function for maximum initiator to target IU size
Date:   Tue, 17 Sep 2019 11:24:20 +0800
Message-Id: <20190917032421.13000-1-honli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 17 Sep 2019 03:24:32 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Honggang Li <honli@redhat.com>

According to SRP specifications 'srp-r16a' and 'srp2r06',
IOControllerProfile attributes for SRP target port include
the maximum initiator to target IU size.

SRP connection daemons, such as srp_daemon, can get the value
from subnet manager. The SRP connection daemon can pass this
value to kernel.

This patch add parse function for it.

Upstream commit [1] enables the kernel parameter, 'use_imm_data',
by default. [1] also use (8 * 1024) as the default value for
kernel parameter 'max_imm_data'. With those default values, the
maximum initiator to target IU size will be 8260.

In case the SRPT modules, which include the in-tree 'ib_srpt.ko'
module, do not support SRP-2 'immediate data' feature, the default
maximum initiator to target IU size is significantly samller than
8260. For 'ib_srpt.ko' module, which built from source before
[2], the default maximum initiator to target IU is 2116.

[1] introduces a regression issue for old srp target with default
kernel parameters, as the connection will be reject because of
too large maximum initiator to target IU size.

[1] commit 882981f4a411 ("RDMA/srp: Add support for immediate data")
[2] commit 5dabcd0456d7 ("RDMA/srpt: Add support for immediate data")

Signed-off-by: Honggang Li <honli@redhat.com>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index b5960351bec0..2eadb038b257 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -75,6 +75,7 @@ static bool prefer_fr = true;
 static bool register_always = true;
 static bool never_register;
 static int topspin_workarounds = 1;
+static uint32_t srp_opt_max_it_iu_size;
 
 module_param(srp_sg_tablesize, uint, 0444);
 MODULE_PARM_DESC(srp_sg_tablesize, "Deprecated name for cmd_sg_entries");
@@ -3411,6 +3412,7 @@ enum {
 	SRP_OPT_IP_SRC		= 1 << 15,
 	SRP_OPT_IP_DEST		= 1 << 16,
 	SRP_OPT_TARGET_CAN_QUEUE= 1 << 17,
+	SRP_OPT_MAX_IT_IU_SIZE  = 1 << 18,
 };
 
 static unsigned int srp_opt_mandatory[] = {
@@ -3443,6 +3445,7 @@ static const match_table_t srp_opt_tokens = {
 	{ SRP_OPT_QUEUE_SIZE,		"queue_size=%d"		},
 	{ SRP_OPT_IP_SRC,		"src=%s"		},
 	{ SRP_OPT_IP_DEST,		"dest=%s"		},
+	{ SRP_OPT_MAX_IT_IU_SIZE,	"max_it_iu_size=%d"	},
 	{ SRP_OPT_ERR,			NULL 			}
 };
 
@@ -3736,6 +3739,14 @@ static int srp_parse_options(struct net *net, const char *buf,
 			target->tl_retry_count = token;
 			break;
 
+		case SRP_OPT_MAX_IT_IU_SIZE:
+			if (match_int(args, &token) || token < 0) {
+				pr_warn("bad maximum initiator to target IU size '%s'\n", p);
+				goto out;
+			}
+			srp_opt_max_it_iu_size = token;
+			break;
+
 		default:
 			pr_warn("unknown parameter or missing value '%s' in target creation request\n",
 				p);
-- 
2.21.0

