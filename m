Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D52C1DF149
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 23:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbgEVVdv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 17:33:51 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38405 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731033AbgEVVdv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 May 2020 17:33:51 -0400
Received: by mail-pj1-f65.google.com with SMTP id t8so3488924pju.3
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 14:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xcZXxuFmCrGCBtaA4BKkKSU9REt6gfh1XPUB7cdu8HU=;
        b=W6TvuHrgADdDFbQ9Ub6cAI4UyReBhY6OgECvGhAodVqGbXA77fUnToTEEdOVguAKTC
         W4f9b0YN2hI8KTr1lQ99bkZSwqAPOz9F2NDJOSbqrtTxnobuU0RdHh/Uc3vyyfoHJlix
         xSKSZXtlKVuMS7KHLhUHyCDIrniqdclgBvvO5QEaHDp181EeN2/fxuYvlbLW4tcpHSOi
         vG+hDA+agt4YqauyozTbclaMgXfYqh/0ViOT4hsorqtg5VeUVAsy0hDMEO2D+kAzLVm0
         8Cw7UqSDnDg9IVv0QjI6KqKdHNLt88je7MY3Qg+ohYfxkaWYapiaT20bVxkK7+8uzPRh
         J0SQ==
X-Gm-Message-State: AOAM532rNTj5mPEnyhICTWdO63zEBlomH1etjeLPUEfB+Daihv9LVCUZ
        8qJXMl/PYQTnldlW5cAAMw8=
X-Google-Smtp-Source: ABdhPJwsK0Krmpts479lx8JiktRDvTnyCGIS0HuEYlI4FQdJHc6WV4hrtPgGU4LepEhm4wVWvy/HZA==
X-Received: by 2002:a17:90a:20cf:: with SMTP id f73mr6962954pjg.86.1590183229662;
        Fri, 22 May 2020 14:33:49 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:b874:274b:7df6:e61b])
        by smtp.gmail.com with ESMTPSA id mn19sm7480755pjb.8.2020.05.22.14.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 14:33:48 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Laurence Oberman <loberman@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH 1/4] RDMA/srp: Make the channel count configurable per target
Date:   Fri, 22 May 2020 14:33:38 -0700
Message-Id: <20200522213341.16341-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522213341.16341-1-bvanassche@acm.org>
References: <20200522213341.16341-1-bvanassche@acm.org>
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
index 00b4f88b113e..d686c39710c0 100644
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
+	{ SRP_OPT_CH_COUNT,		"ch_count=%d",		},
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
