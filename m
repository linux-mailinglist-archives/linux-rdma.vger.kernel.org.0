Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4235961185D
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 18:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiJ1Q42 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 12:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiJ1Qzk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 12:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0FD27FC9
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666976091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VdcDk47USY1AAs2NC9Jgcp38nSNmzzXOjaUWiRf+Iv4=;
        b=KH7drlWJnj5KrS09vL0g4AOeYopwLSJLQ1zul0J+tSFFhVPZbxtdTo9x3/LW3LD40gC0PH
        hjWJms79o9dC5mZlkFLSwh/Zrv4K9r+K1MLQvheSKGBs7QKVgzMKxbKGzTDpMQElq9evpD
        R1mU19LnDDW0LJ8IxH4MuuBLoYIQlZw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-311-MZYNBMIGPreQ_etbO_5e8w-1; Fri, 28 Oct 2022 12:54:50 -0400
X-MC-Unique: MZYNBMIGPreQ_etbO_5e8w-1
Received: by mail-wm1-f71.google.com with SMTP id r187-20020a1c44c4000000b003c41e9ae97dso1228961wma.6
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 09:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdcDk47USY1AAs2NC9Jgcp38nSNmzzXOjaUWiRf+Iv4=;
        b=fh/NWLFZbibWXP0KDyKGxpmqES7f3WgsQM4l/n5X+yFp0Zd1gJBjSX6uNhxcV0l5P6
         gG9kdJ/53p4HRgQ1Pkl+Cd5yCxPhTvkaa92IVUfs0S6C1X1bDlAONGL52tui9q1RvExq
         +sZ8utAQiue+NOBXKY2XGNzKVcJcV5LjjLyt2Z0TpTBRAFXyJmSNPMVWdlzsBmHhYOzA
         wyMFqn41rd9AaiCB/nR7e4WXd7ijLUwNcITkN3QZEokDu5HoPAWuMmWBOZgMaqlGQfqO
         +N0M3IoP5+zUZxJF4yx7Wm6qmoKGYJbwhktbWr7zr2AeLgIkxggtbvg2z8zJlJS8ij+G
         tb5w==
X-Gm-Message-State: ACrzQf0SY0X2sTNaI2oI9UF4Tr0Qc2rVGZvgiT+Hru3dGxcp737c+rWC
        Vg8kWBFiY2RxvD0RWZeEcN6zqgKV+pXU4aVmToyYUv+gLp8HOBMxHpgraLZBZN74wiqNBQz9II7
        y+57Z3P0eTn2bBZ41md6AuA==
X-Received: by 2002:a05:600c:5252:b0:3c6:f478:96db with SMTP id fc18-20020a05600c525200b003c6f47896dbmr129953wmb.116.1666976087566;
        Fri, 28 Oct 2022 09:54:47 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7f0szCZRq/AyWSF4FAbMLi4c+VZ61awGxbMQMux0B+kV44EN3ui369YGc5WFbD9TcBb6f5Wg==
X-Received: by 2002:a05:600c:5252:b0:3c6:f478:96db with SMTP id fc18-20020a05600c525200b003c6f47896dbmr129938wmb.116.1666976087392;
        Fri, 28 Oct 2022 09:54:47 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id l2-20020a7bc342000000b003c6c182bef9sm9239733wmj.36.2022.10.28.09.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:54:46 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH v6 2/3] sched/topology: Introduce for_each_numa_hop_mask()
Date:   Fri, 28 Oct 2022 17:54:28 +0100
Message-Id: <20221028165429.1368452-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221028164959.1367250-1-vschneid@redhat.com>
References: <20221028164959.1367250-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The recently introduced sched_numa_hop_mask() exposes cpumasks of CPUs
reachable within a given distance budget, wrap the logic for iterating over
all (distance, mask) values inside an iterator macro.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/topology.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index 64199545d7cf6..2223c987a1383 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -255,5 +255,22 @@ sched_numa_hop_mask(unsigned int node, unsigned int hops)
 }
 #endif	/* CONFIG_NUMA */
 
+/**
+ * for_each_numa_hop_mask - iterate over cpumasks of increasing NUMA distance
+ *                          from a given node.
+ * @mask: the iteration variable.
+ * @node: the NUMA node to start the search from.
+ *
+ * Requires rcu_lock to be held.
+ *
+ * Yields cpu_online_mask for @node == NUMA_NO_NODE.
+ */
+#define for_each_numa_hop_mask(mask, node)				       \
+	for (unsigned int __hops = 0;					       \
+	     mask = (node != NUMA_NO_NODE || __hops) ?			       \
+		     sched_numa_hop_mask(node, __hops) :		       \
+		     cpu_online_mask,					       \
+	     !IS_ERR_OR_NULL(mask);					       \
+	     __hops++)
 
 #endif /* _LINUX_TOPOLOGY_H */
-- 
2.31.1

