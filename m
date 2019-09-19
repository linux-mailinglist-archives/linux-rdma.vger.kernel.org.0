Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 079E5B7202
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2019 05:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbfISDu4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Sep 2019 23:50:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730964AbfISDuz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Sep 2019 23:50:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30D7B3DE04;
        Thu, 19 Sep 2019 03:50:55 +0000 (UTC)
Received: from dhcp-128-227.nay.redhat.com (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 683191001B01;
        Thu, 19 Sep 2019 03:50:53 +0000 (UTC)
From:   Honggang LI <honli@redhat.com>
To:     bvanassche@acm.org, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, Honggang Li <honli@redhat.com>
Subject: [patch v3 1/2] RDMA/srp: Add parse function for maximum initiator to target IU size
Date:   Thu, 19 Sep 2019 11:50:31 +0800
Message-Id: <20190919035032.31373-1-honli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 19 Sep 2019 03:50:55 +0000 (UTC)
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
maximum initiator to target IU size is significantly smaller than
8260. For 'ib_srpt.ko' module, which built from source before
[2], the default maximum initiator to target IU is 2116.

[1] introduces a regression issue for old srp target with default
kernel parameters, as the connection will be reject because of
too large maximum initiator to target IU size.

[1] commit 882981f4a411 ("RDMA/srp: Add support for immediate data")
[2] commit 5dabcd0456d7 ("RDMA/srpt: Add support for immediate data")

Signed-off-by: Honggang Li <honli@redhat.com>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 10 ++++++++++
 drivers/infiniband/ulp/srp/ib_srp.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index b5960351bec0..b829dab0df77 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -3411,6 +3411,7 @@ enum {
 	SRP_OPT_IP_SRC		= 1 << 15,
 	SRP_OPT_IP_DEST		= 1 << 16,
 	SRP_OPT_TARGET_CAN_QUEUE= 1 << 17,
+	SRP_OPT_MAX_IT_IU_SIZE  = 1 << 18,
 };
 
 static unsigned int srp_opt_mandatory[] = {
@@ -3443,6 +3444,7 @@ static const match_table_t srp_opt_tokens = {
 	{ SRP_OPT_QUEUE_SIZE,		"queue_size=%d"		},
 	{ SRP_OPT_IP_SRC,		"src=%s"		},
 	{ SRP_OPT_IP_DEST,		"dest=%s"		},
+	{ SRP_OPT_MAX_IT_IU_SIZE,	"max_it_iu_size=%d"	},
 	{ SRP_OPT_ERR,			NULL 			}
 };
 
@@ -3736,6 +3738,14 @@ static int srp_parse_options(struct net *net, const char *buf,
 			target->tl_retry_count = token;
 			break;
 
+		case SRP_OPT_MAX_IT_IU_SIZE:
+			if (match_int(args, &token) || token < 0) {
+				pr_warn("bad maximum initiator to target IU size '%s'\n", p);
+				goto out;
+			}
+			target->max_it_iu_size = token;
+			break;
+
 		default:
 			pr_warn("unknown parameter or missing value '%s' in target creation request\n",
 				p);
diff --git a/drivers/infiniband/ulp/srp/ib_srp.h b/drivers/infiniband/ulp/srp/ib_srp.h
index b2861cd2087a..105b2bc6aa2f 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.h
+++ b/drivers/infiniband/ulp/srp/ib_srp.h
@@ -209,6 +209,7 @@ struct srp_target_port {
 	u32			ch_count;
 	u32			lkey;
 	enum srp_target_state	state;
+	uint32_t		max_it_iu_size;
 	unsigned int		cmd_sg_cnt;
 	unsigned int		indirect_size;
 	bool			allow_ext_sg;
-- 
2.21.0

