Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04FC581BA2
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jul 2022 23:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbiGZVWL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jul 2022 17:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiGZVWK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jul 2022 17:22:10 -0400
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267842E9F7
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jul 2022 14:22:07 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id q16so14205063pgq.6
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jul 2022 14:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gs2OT209NyQtDqc8F2HQ/9QNYr8maA1G1mU9Q+ZAuh4=;
        b=LP8WbpvIt7NGzfNRdaLRkTKK0eYuqd8uDWTEvIATaWPlHuAgq0ISKSCf+l2M58JcEi
         dOnguoXDnsGcbe8OMi6VubPQdZIMC0hPUiaK+22ozWUk9OU6Vmg+g6J5qNqNpSBAR2ro
         qiX9StWBQE+ZYdu3O5L8CyRI/evt7DN7rpLqQ3IqAHIrKS5GLug/IVouu2mkpmDbCI26
         4Z+Y06ymUL44cL/mi8uU7mDOfRlV8kzJx8IkBcYKcCng+Uk+T3iV1rImLeKomGcfsda7
         +xYxpdU5THDqiWoRO7MoMGHXZ01I9LkrcYgNZjiWxM2lSSCNIs59GqLeESSwmJSmTL4N
         ftHQ==
X-Gm-Message-State: AJIora/3Nhbon7Fv2Vm5x9HWT2LMhn3aXgZN9j5plnV79d/LT4sBGVHf
        Ai4lpJK0CaJLe7fn8hIL47M=
X-Google-Smtp-Source: AGRyM1sR/aXSvyuUnDszLXRVnuLjh8PeL2F2nkyJjt6OuDXJ0sLqahFIk753Dm08e7LVuuedCsFDfA==
X-Received: by 2002:a65:6850:0:b0:41a:7361:86ee with SMTP id q16-20020a656850000000b0041a736186eemr16082876pgt.486.1658870526625;
        Tue, 26 Jul 2022 14:22:06 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:34f4:7aa8:57:d456])
        by smtp.gmail.com with ESMTPSA id g5-20020aa796a5000000b00528999fba99sm12398983pfk.175.2022.07.26.14.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 14:22:05 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>,
        Hillf Danton <hdanton@sina.com>,
        Mike Christie <michael.christie@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/3] RDMA/srpt: Duplicate port name members
Date:   Tue, 26 Jul 2022 14:21:54 -0700
Message-Id: <20220726212156.1318010-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
In-Reply-To: <20220726212156.1318010-1-bvanassche@acm.org>
References: <20220726212156.1318010-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Prepare for decoupling the lifetimes of struct srpt_port and struct
srpt_port_id by duplicating the port name into struct srpt_port.

Cc: Li Zhijian <lizhijian@fujitsu.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c |  9 ++++++---
 drivers/infiniband/ulp/srpt/ib_srpt.h | 10 +++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index f86ee1c4b970..8253d55b9c26 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -566,14 +566,17 @@ static int srpt_refresh_port(struct srpt_port *sport)
 		return ret;
 
 	sport->port_guid_id.wwn.priv = sport;
-	srpt_format_guid(sport->port_guid_id.name,
-			 sizeof(sport->port_guid_id.name),
+	srpt_format_guid(sport->guid_name, ARRAY_SIZE(sport->guid_name),
 			 &sport->gid.global.interface_id);
+	memcpy(sport->port_guid_id.name, sport->guid_name,
+	       ARRAY_SIZE(sport->guid_name));
 	sport->port_gid_id.wwn.priv = sport;
-	snprintf(sport->port_gid_id.name, sizeof(sport->port_gid_id.name),
+	snprintf(sport->gid_name, ARRAY_SIZE(sport->gid_name),
 		 "0x%016llx%016llx",
 		 be64_to_cpu(sport->gid.global.subnet_prefix),
 		 be64_to_cpu(sport->gid.global.interface_id));
+	memcpy(sport->port_gid_id.name, sport->gid_name,
+	       ARRAY_SIZE(sport->gid_name));
 
 	if (rdma_protocol_iwarp(sport->sdev->device, sport->port))
 		return 0;
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/ulp/srpt/ib_srpt.h
index 76e66f630c17..3844a7058559 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.h
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
@@ -376,7 +376,7 @@ struct srpt_tpg {
 };
 
 /**
- * struct srpt_port_id - information about an RDMA port name
+ * struct srpt_port_id - LIO RDMA port information
  * @mutex:	Protects @tpg_list changes.
  * @tpg_list:	TPGs associated with the RDMA port name.
  * @wwn:	WWN associated with the RDMA port name.
@@ -402,8 +402,10 @@ struct srpt_port_id {
  * @lid:       cached value of the port's lid.
  * @gid:       cached value of the port's gid.
  * @work:      work structure for refreshing the aforementioned cached values.
- * @port_guid_id: target port GUID
- * @port_gid_id: target port GID
+ * @guid_name: port name in GUID format.
+ * @port_guid_id: LIO target port information for the port name in GUID format.
+ * @gid_name:  port name in GID format.
+ * @port_gid_id: LIO target port information for the port name in GID format.
  * @port_attrib:   Port attributes that can be accessed through configfs.
  * @refcount:	   Number of objects associated with this port.
  * @freed_channels: Completion that will be signaled once @refcount becomes 0.
@@ -419,7 +421,9 @@ struct srpt_port {
 	u32			lid;
 	union ib_gid		gid;
 	struct work_struct	work;
+	char			guid_name[64];
 	struct srpt_port_id	port_guid_id;
+	char			gid_name[64];
 	struct srpt_port_id	port_gid_id;
 	struct srpt_port_attrib port_attrib;
 	atomic_t		refcount;
