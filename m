Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F2856A544
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Jul 2022 16:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbiGGOWB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jul 2022 10:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbiGGOWB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Jul 2022 10:22:01 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55AD1C136
        for <linux-rdma@vger.kernel.org>; Thu,  7 Jul 2022 07:21:59 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sb34so32655808ejc.11
        for <linux-rdma@vger.kernel.org>; Thu, 07 Jul 2022 07:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hTjG8PXY+YuIS3N2xNViy8w3A7zlBpO3NbxQK2TYjxI=;
        b=Kej0GfDI+pIZuWocUYYEpOyhl5KXAEn2YKsB7EFTc8ry3QU4XqeakyUDC8Vhcibaew
         /wAT9k05JhZ6TaNrTPmiwZp9GeDnTwWb1SaDv7iZiMcSvFxIKptdo7+PRqvebVZlSYAX
         8YdnSWNQXnARi0HEYumXdNgjEwP9ZdxMlKRTx/zdNGw8EJWYvBaB0jsThsrOiGCCemTh
         FzmKjJoTb+xJQX4xu8ZPJ1v2OZZEWegHeEB8sF8SB2b+1yVJGxSOP7yRQ2O57epb9Qrg
         9A68zXQki83c2/D9fI00Q5PBb9YjvJ7bPqi4X2LiID0KqnxY3CZN3TSZY8F0mKZPsXPF
         I7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hTjG8PXY+YuIS3N2xNViy8w3A7zlBpO3NbxQK2TYjxI=;
        b=u6NUsMfU/Hx3kwDwqWWito9jATuaJLz3vWCX6SdK2LZ1KG38PNEROkvEmhQRBfgjYe
         hxoiSPa/KFoJ4foJJbmQnlpm3RCVzDWQ+x+lCgTQu2kJSMb9aCZE62unewyw0hK9IC3K
         gHkbAYciGiNmsBCVElXpl3jfEHXgwwC3me9XDNKw7g5ei4Xikj5eIP/TayYsv4inYk6J
         umIFCbZ7qYBk/HeD4IbkWYyOBkQuVgLdh8uECPTqc3wtqwbyXeh9XmrwB4LE++U6DAjS
         K1I7jv5Vq5SWpmaw+I6CuO5QzimDLSOFdTqwc/GNaQk/dgzXkC8KmqqxDhzeMfl0Tte8
         bzDg==
X-Gm-Message-State: AJIora+pf0JE1BeD8/7JR3jDjXOXuIji/47nKG7ttHPKoQyctJ/HtC0q
        LlVux4b6GxsReEPYpMUfE7IrS9p+rGyjmg==
X-Google-Smtp-Source: AGRyM1uKtja/w1lKGVB4KQHad6mwbgioQp0nGyjqzGO79dx9xiufo2zSmN7J/0sg+dgm+8fzD5ccZg==
X-Received: by 2002:a17:906:a245:b0:708:ce69:e38b with SMTP id bi5-20020a170906a24500b00708ce69e38bmr45468498ejb.100.1657203718295;
        Thu, 07 Jul 2022 07:21:58 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906200200b0072b13fa5e4csm693807ejo.58.2022.07.07.07.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 07:21:57 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com,
        Santosh Kumar Pradhan <santosh.pradhan@ionos.com>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH for-next 2/5] RDMA/rtrs-clt: Use this_cpu_ API for stats
Date:   Thu,  7 Jul 2022 16:21:41 +0200
Message-Id: <20220707142144.459751-3-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707142144.459751-1-haris.iqbal@ionos.com>
References: <20220707142144.459751-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Santosh Kumar Pradhan <santosh.pradhan@ionos.com>

Use this_cpu_x() for increasing/adding a percpu counter through a
percpu pointer without the need to disable/enable preemption.

Suggested-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Santosh Kumar Pradhan <santosh.pradhan@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
index 385a19846c24..1e6ffafa2db3 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
@@ -32,11 +32,7 @@ void rtrs_clt_update_wc_stats(struct rtrs_clt_con *con)
 
 void rtrs_clt_inc_failover_cnt(struct rtrs_clt_stats *stats)
 {
-	struct rtrs_clt_stats_pcpu *s;
-
-	s = get_cpu_ptr(stats->pcpu_stats);
-	s->rdma.failover_cnt++;
-	put_cpu_ptr(stats->pcpu_stats);
+	this_cpu_inc(stats->pcpu_stats->rdma.failover_cnt);
 }
 
 int rtrs_clt_stats_migration_from_cnt_to_str(struct rtrs_clt_stats *stats, char *buf)
@@ -169,12 +165,8 @@ int rtrs_clt_reset_all_stats(struct rtrs_clt_stats *s, bool enable)
 static inline void rtrs_clt_update_rdma_stats(struct rtrs_clt_stats *stats,
 					       size_t size, int d)
 {
-	struct rtrs_clt_stats_pcpu *s;
-
-	s = get_cpu_ptr(stats->pcpu_stats);
-	s->rdma.dir[d].cnt++;
-	s->rdma.dir[d].size_total += size;
-	put_cpu_ptr(stats->pcpu_stats);
+	this_cpu_inc(stats->pcpu_stats->rdma.dir[d].cnt);
+	this_cpu_add(stats->pcpu_stats->rdma.dir[d].size_total, size);
 }
 
 void rtrs_clt_update_all_stats(struct rtrs_clt_io_req *req, int dir)
-- 
2.25.1

