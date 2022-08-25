Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1015A1892
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Aug 2022 20:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243474AbiHYSNl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Aug 2022 14:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243342AbiHYSNJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Aug 2022 14:13:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33F774CD8
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 11:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661451172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ygl4bsiGppbXjaR+QFxwzenbyEWvTTquS8G3MYyuF5k=;
        b=gjZO7aIVARYnOyfIL8a9EN9KO2fTaxR3kUnPE2HeIvu546LCw4dBbTAyxdQkkNVyXCg4QR
        saVshhGoFmq3B5YOnXw4WPU1Qdv5aOlY/w31F/V/0voikw5khIkxgttemJBv+6ne83qlCk
        /EXxI75PcPUilpK0u/sgRjRpUg3Sfvg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-630-vIG-fyezNeyN_jW_lrZgBw-1; Thu, 25 Aug 2022 14:12:51 -0400
X-MC-Unique: vIG-fyezNeyN_jW_lrZgBw-1
Received: by mail-wr1-f70.google.com with SMTP id r23-20020adfa157000000b00225660d47b7so1748867wrr.6
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 11:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Ygl4bsiGppbXjaR+QFxwzenbyEWvTTquS8G3MYyuF5k=;
        b=oPVkdQCpPtYo/zpQ3JU9uuSbXzcVgtTgMfUNkAerHUbGVDBKmOOvHa2/hQ8//XzXEn
         WweBnvP6yJxTqyDGKgM1Nw/QJIh4+w82UjmVU6lcB0bTaqnqaR33o14oGlzDLuDsg6FQ
         /N+p1AuZ5bz1ik5YDT5r6Dcx7zPn2RIXiXsg2lDXCcm8jQZbhXOSUfZk1uPrT0HcVDgk
         wxylgq02XrJuVqJAv4YXGmWaQy2VPnpQkHWVsJTVw6y0sD5SUK2D4R673A3kLpr3E2Dw
         7cMsxovSmZSHvKesDqPIm1gkeCC/HwhAngoLLKWZyxoKXJx5UpqVfJSOEnfffWH1HWHL
         v+Vg==
X-Gm-Message-State: ACgBeo1N0F8FTtNXV2xr1y8lfAjFUoPZvUYmWOpB7oU4gNdGIyHMyULj
        zTwz+YgmBy1Yb7YdYSDvRhjpK95m0MhK5bm9Fe1C7BX+xzyuELbcqCUcJKcFKb/TXFRE/G6QkJg
        q8EA17TDj6g/LLCcEH38gLg==
X-Received: by 2002:adf:e10c:0:b0:225:3168:c261 with SMTP id t12-20020adfe10c000000b002253168c261mr2960603wrz.159.1661451170433;
        Thu, 25 Aug 2022 11:12:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4//RuHGtg2u96JYQmBT7E0pgZs/8dFZK5QKRpNIHW/sFCkTDIUkVmKlpjbmKJGB+DoHbT1ig==
X-Received: by 2002:adf:e10c:0:b0:225:3168:c261 with SMTP id t12-20020adfe10c000000b002253168c261mr2960588wrz.159.1661451170194;
        Thu, 25 Aug 2022 11:12:50 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id w1-20020a05600018c100b00225250f2d1bsm20371622wrq.94.2022.08.25.11.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:12:49 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
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
Subject: [PATCH v3 8/9] sched/topology: Introduce for_each_numa_hop_cpu()
Date:   Thu, 25 Aug 2022 19:12:09 +0100
Message-Id: <20220825181210.284283-9-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220825181210.284283-1-vschneid@redhat.com>
References: <20220825181210.284283-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The recently introduced sched_numa_hop_mask() exposes cpumasks of CPUs
reachable within a given distance budget, but this means each successive
cpumask is a superset of the previous one.

Code wanting to allocate one item per CPU (e.g. IRQs) at increasing
distances would thus need to allocate a temporary cpumask to note which
CPUs have already been visited. This can be prevented by leveraging
for_each_cpu_andnot() - package all that logic into one ugl^D fancy macro.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/topology.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index 13b82b83e547..6c671dc3252c 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -254,5 +254,42 @@ static inline const struct cpumask *sched_numa_hop_mask(int node, int hops)
 }
 #endif	/* CONFIG_NUMA */
 
+/**
+ * for_each_numa_hop_cpu - iterate over CPUs by increasing NUMA distance,
+ *                         starting from a given node.
+ * @cpu: the iteration variable.
+ * @node: the NUMA node to start the search from.
+ *
+ * Requires rcu_lock to be held.
+ * Careful: this is a double loop, 'break' won't work as expected.
+ *
+ *
+ * Implementation notes:
+ *
+ * Providing it is valid, the mask returned by
+ *  sched_numa_hop_mask(node, hops+1)
+ * is a superset of the one returned by
+ *   sched_numa_hop_mask(node, hops)
+ * which may not be that useful for drivers that try to spread things out and
+ * want to visit a CPU not more than once.
+ *
+ * To accommodate for that, we use for_each_cpu_andnot() to iterate over the cpus
+ * of sched_numa_hop_mask(node, hops+1) with the CPUs of
+ * sched_numa_hop_mask(node, hops) removed, IOW we only iterate over CPUs
+ * a given distance away (rather than *up to* a given distance).
+ *
+ * hops=0 forces us to play silly games: we pass cpu_none_mask to
+ * for_each_cpu_andnot(), which turns it into for_each_cpu().
+ */
+#define for_each_numa_hop_cpu(cpu, node)				       \
+	for (struct { const struct cpumask *curr, *prev; int hops; } __v =     \
+		     { sched_numa_hop_mask(node, 0), NULL, 0 };		       \
+	     !IS_ERR_OR_NULL(__v.curr);					       \
+	     __v.hops++,                                                       \
+	     __v.prev = __v.curr,					       \
+	     __v.curr = sched_numa_hop_mask(node, __v.hops))                   \
+		for_each_cpu_andnot(cpu,				       \
+				    __v.curr,				       \
+				    __v.hops ? __v.prev : cpu_none_mask)
 
 #endif /* _LINUX_TOPOLOGY_H */
-- 
2.31.1

