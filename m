Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA831E1356
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 19:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391289AbgEYRW1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 13:22:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41898 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388230AbgEYRW1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 13:22:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id a13so7683424pls.8
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 10:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HhAPnQrHX3/PcCvPRKRSrGzu3ZqP3FWjJECBy4unszE=;
        b=Zv9MaHfozxH0woxWgyYMOIcN7cQ7xjmaCNAqGlIwrsBu2tj2z0lOj5WfOOcTY6hoff
         wvMHxiVY8a+n56I4kSefOlJmHX5Bdem3fcQuw1IVfclqwR8g5anT0+IxjHecbqL2JDg6
         13l/7ND0Rt4F2AXQYYq/ThoOaMLdwjqQ6GfR7oVTpcH8kLZGObnW+VFP7kPAUsXDnpZx
         YzvXye6Qow9QEHFdaZRbJXxvuEog8gsuGp0PX0iya3euznERidSEHZE2G6o+Jfz3V8ET
         RVTIkSx3YOL+lO/ju0wFrjFbACa1Te6Fp1hxD22QEXhMn9cpm1Dt6N9RyuPGEG0aHlZr
         Bj0Q==
X-Gm-Message-State: AOAM530eMairz4xWFF0nVuQFTEdloM9OQiuEsmCmzA3JmVQzgeVFS21K
        BR2OnrFnG/e09ImqQH4NZ3c=
X-Google-Smtp-Source: ABdhPJwYOooy6S7ZupH/K5HuJWJXofYBKBG8FAtgUXGcsS4HN3C5s8G1d3FEq9fG+KDt18+f0WZThQ==
X-Received: by 2002:a17:90a:8c8e:: with SMTP id b14mr20291852pjo.222.1590427346051;
        Mon, 25 May 2020 10:22:26 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:2590:9462:ff8a:101f])
        by smtp.gmail.com with ESMTPSA id p9sm3213238pff.71.2020.05.25.10.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 10:22:25 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Laurence Oberman <loberman@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH v2 1/4] RDMA/srp: Make the channel count configurable per target
Date:   Mon, 25 May 2020 10:22:09 -0700
Message-Id: <20200525172212.14413-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525172212.14413-1-bvanassche@acm.org>
References: <20200525172212.14413-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Increase the flexibility of the SRP initiator driver by making the channel
count configurable per target instead of only providing a kernel module
parameter for configuring the channel count.

Cc: Laurence Oberman <loberman@redhat.com>
Cc: Kamal Heib <kamalheib1@gmail.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 00b4f88b113e..4018c4abf2e2 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -3424,6 +3424,7 @@ enum {
 	SRP_OPT_IP_DEST		= 1 << 16,
 	SRP_OPT_TARGET_CAN_QUEUE= 1 << 17,
 	SRP_OPT_MAX_IT_IU_SIZE  = 1 << 18,
+	SRP_OPT_CH_COUNT	= 1 << 19,
 };
 
 static unsigned int srp_opt_mandatory[] = {
@@ -3457,6 +3458,7 @@ static const match_table_t srp_opt_tokens = {
 	{ SRP_OPT_IP_SRC,		"src=%s"		},
 	{ SRP_OPT_IP_DEST,		"dest=%s"		},
 	{ SRP_OPT_MAX_IT_IU_SIZE,	"max_it_iu_size=%d"	},
+	{ SRP_OPT_CH_COUNT,		"ch_count=%u",		},
 	{ SRP_OPT_ERR,			NULL 			}
 };
 
@@ -3758,6 +3760,14 @@ static int srp_parse_options(struct net *net, const char *buf,
 			target->max_it_iu_size = token;
 			break;
 
+		case SRP_OPT_CH_COUNT:
+			if (match_int(args, &token) || token < 1) {
+				pr_warn("bad channel count %s\n", p);
+				goto out;
+			}
+			target->ch_count = token;
+			break;
+
 		default:
 			pr_warn("unknown parameter or missing value '%s' in target creation request\n",
 				p);
@@ -3921,11 +3931,12 @@ static ssize_t srp_create_target(struct device *dev,
 		goto out;
 
 	ret = -ENOMEM;
-	target->ch_count = max_t(unsigned, num_online_nodes(),
-				 min(ch_count ? :
-				     min(4 * num_online_nodes(),
-					 ibdev->num_comp_vectors),
-				     num_online_cpus()));
+	if (target->ch_count == 0)
+		target->ch_count = max_t(unsigned, num_online_nodes(),
+					 min(ch_count ? :
+					     min(4 * num_online_nodes(),
+						 ibdev->num_comp_vectors),
+					     num_online_cpus()));
 	target->ch = kcalloc(target->ch_count, sizeof(*target->ch),
 			     GFP_KERNEL);
 	if (!target->ch)
