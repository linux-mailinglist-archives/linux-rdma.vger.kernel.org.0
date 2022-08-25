Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125945A1888
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Aug 2022 20:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243466AbiHYSNh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Aug 2022 14:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243328AbiHYSNJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Aug 2022 14:13:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FD4BD1F9
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 11:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661451171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qZr7gdCnQUFeKt5ugQdZLofQqTfC3GDipKWYJIctC0o=;
        b=gIGXxy7oQ72Y3zlWXm5CZkWWIh9/p15re4T3ok64cRYk3UdPYnkE+O2nVTFZJCFjEaFBE9
        0LgbHLBvb08Tj6M8ZVmSYrv4SjP88S1LFjIcEQmUSv+7njmJcoVcIBX7ol3r9R2gC7uRs4
        q6m3psxcWR29Hgxr3VcNJpzvANgyOh0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-573-7fKVF_5cOvavx56yygdIhA-1; Thu, 25 Aug 2022 14:12:50 -0400
X-MC-Unique: 7fKVF_5cOvavx56yygdIhA-1
Received: by mail-wm1-f69.google.com with SMTP id i7-20020a1c3b07000000b003a534ec2570so2767432wma.7
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 11:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=qZr7gdCnQUFeKt5ugQdZLofQqTfC3GDipKWYJIctC0o=;
        b=cLbHx8EJ50JrQCTWL7N9FwqYq1u68SsgT8kpmW6WSSVKjNsNrHq3WOA0IcyuOuhE2C
         IIThpWexfC2I5GGEtg/zH1hXlyhiC1hEZF7HUy1u68/Y7tak0XcKrph2S1f0SUDXiLuW
         b4HHRCiTVMdE4W6bvEMgZlt1Q2nV1e2Cef5hTnm5KjRXgg2cB1jxItDbqUwoSN3QmJsO
         zAVpTiFUTWiLaW9YNyYPcN2R1FvTacEoc3ms9VKlSTmrZjnCI9onEWXwa+T+fylow+/g
         qeRByED1JYOWrJQlcOPrOZunYPm0Ch4uj5h3qfDtbd7tnFpvpGPznOkiLF89lavN4Y+m
         xNSw==
X-Gm-Message-State: ACgBeo2EmLSsasH1ZnjAxs5DQG6IFbB/FIE4C9G7WLIQ+uTqfRODBQTv
        CGW2iYCTvxVniApLwGRyUJtGC1DbNXKA9w+kUJx+GyUhC3DgFXZef428N2wVNe12Lkjl1K6J62u
        nyy9xeadzAIWJBYCgRmtGsQ==
X-Received: by 2002:a5d:6245:0:b0:225:41ae:a930 with SMTP id m5-20020a5d6245000000b0022541aea930mr3070235wrv.342.1661451169013;
        Thu, 25 Aug 2022 11:12:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7RVH5PYnY8wcHITb/gSrWocUzm2ruacYsdzIWSRq+8UMK3z//2FcJywjqklUN6v6jsYge+9A==
X-Received: by 2002:a5d:6245:0:b0:225:41ae:a930 with SMTP id m5-20020a5d6245000000b0022541aea930mr3070223wrv.342.1661451168836;
        Thu, 25 Aug 2022 11:12:48 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id w1-20020a05600018c100b00225250f2d1bsm20371622wrq.94.2022.08.25.11.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:12:48 -0700 (PDT)
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
Subject: [PATCH v3 7/9] sched/topology: Introduce sched_numa_hop_mask()
Date:   Thu, 25 Aug 2022 19:12:08 +0100
Message-Id: <20220825181210.284283-8-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220825181210.284283-1-vschneid@redhat.com>
References: <20220825181210.284283-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Tariq has pointed out that drivers allocating IRQ vectors would benefit
from having smarter NUMA-awareness - cpumask_local_spread() only knows
about the local node and everything outside is in the same bucket.

sched_domains_numa_masks is pretty much what we want to hand out (a cpumask
of CPUs reachable within a given distance budget), introduce
sched_numa_hop_mask() to export those cpumasks.

Link: http://lore.kernel.org/r/20220728191203.4055-1-tariqt@nvidia.com
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/topology.h |  9 +++++++++
 kernel/sched/topology.c  | 28 ++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index 4564faafd0e1..13b82b83e547 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -245,5 +245,14 @@ static inline const struct cpumask *cpu_cpu_mask(int cpu)
 	return cpumask_of_node(cpu_to_node(cpu));
 }
 
+#ifdef CONFIG_NUMA
+extern const struct cpumask *sched_numa_hop_mask(int node, int hops);
+#else
+static inline const struct cpumask *sched_numa_hop_mask(int node, int hops)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+#endif	/* CONFIG_NUMA */
+
 
 #endif /* _LINUX_TOPOLOGY_H */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8739c2a5a54e..f0236a0ae65c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2067,6 +2067,34 @@ int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
 	return found;
 }
 
+/**
+ * sched_numa_hop_mask() - Get the cpumask of CPUs at most @hops hops away.
+ * @node: The node to count hops from.
+ * @hops: Include CPUs up to that many hops away. 0 means local node.
+ *
+ * Requires rcu_lock to be held. Returned cpumask is only valid within that
+ * read-side section, copy it if required beyond that.
+ *
+ * Note that not all hops are equal in size; see sched_init_numa() for how
+ * distances and masks are handled.
+ *
+ * Also note that this is a reflection of sched_domains_numa_masks, which may change
+ * during the lifetime of the system (offline nodes are taken out of the masks).
+ */
+const struct cpumask *sched_numa_hop_mask(int node, int hops)
+{
+	struct cpumask ***masks = rcu_dereference(sched_domains_numa_masks);
+
+	if (node >= nr_node_ids || hops >= sched_domains_numa_levels)
+		return ERR_PTR(-EINVAL);
+
+	if (!masks)
+		return NULL;
+
+	return masks[hops][node];
+}
+EXPORT_SYMBOL_GPL(sched_numa_hop_mask);
+
 #endif /* CONFIG_NUMA */
 
 static int __sdt_alloc(const struct cpumask *cpu_map)
-- 
2.31.1

