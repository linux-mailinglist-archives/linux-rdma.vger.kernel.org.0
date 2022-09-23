Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFF65E7F13
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Sep 2022 17:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiIWP4b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Sep 2022 11:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiIWP4I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Sep 2022 11:56:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A51146FBE
        for <linux-rdma@vger.kernel.org>; Fri, 23 Sep 2022 08:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663948567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kHBrvEPvwtrxok/newbrf2agVKLCITkG2Qf6CtamOLw=;
        b=TbcIWgCCgTefQjXAvmu4kZ46SwacUqEk+mk1jLiOOtE9UfbglZ+8FT6aMDukm6MrZDFsxI
        FCBSWP+4N5MM3LS+8js53z45fU6NPC1ZAhX1Ycz0VfXC/Yo4+oCkIXYW1FISH6Bx3MC7oP
        gGHt28PaR5m5ph4Dgal9LUDetQoE/y0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-232-qelISEC1MlO-kESRKZ-r9A-1; Fri, 23 Sep 2022 11:56:06 -0400
X-MC-Unique: qelISEC1MlO-kESRKZ-r9A-1
Received: by mail-wr1-f70.google.com with SMTP id a13-20020adfbc4d000000b00228631ddfafso117138wrh.9
        for <linux-rdma@vger.kernel.org>; Fri, 23 Sep 2022 08:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kHBrvEPvwtrxok/newbrf2agVKLCITkG2Qf6CtamOLw=;
        b=yPh2s6RkxVr76byF7o1daVIU5KvzNjpSKC5+LmAJz3ouFMYRUtM5Q5enLLykGNhHvd
         0wSYu2u0anh2Nrh5dj7HOi3kiGXeK7gob73r50ypAgfyfWcy8OhpeTr/gmyneMInhuxd
         dCk+IliRr60id9c8OyySpbiZnusENFG/e4SBkMD7S7anrbycoKmY2pXE7051YE1oq0Z7
         5+IvMMMVG4pnlpq05lQWXPNiv8d17u6KU/H4ociStwrbW+2RvmfpdLXmDmJQSYTAmkbh
         2VGrTZcQkOBzRJ27clwbqUVSCeDH3PH0jbSN7h5BbQ1hL/KSimpvFW2rdaYRMziol6E7
         bnkQ==
X-Gm-Message-State: ACrzQf2MuLWFfoXCA14UchtiwdEvVpNXXB7IRjGkvSacE+WZdqy2Rmuw
        964Lgm5MRnRZ0tq0tz1YoiUC6rMbhPUV0ojWoPhK3AufY0MyTwz1l5JRvF1t7mu2mZl2Set5pm2
        aYXlUSHjXEL0cjC+jMCOFdw==
X-Received: by 2002:a05:600c:1c22:b0:3b4:b2bc:15e4 with SMTP id j34-20020a05600c1c2200b003b4b2bc15e4mr6572332wms.69.1663948564543;
        Fri, 23 Sep 2022 08:56:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Cc+v1ZHKhGIhntGRkSRg5WAmD2mSxUj/B+KSYr9+DHgV96QzjwDqWCHxzt9g3noPgOYYFEA==
X-Received: by 2002:a05:600c:1c22:b0:3b4:b2bc:15e4 with SMTP id j34-20020a05600c1c2200b003b4b2bc15e4mr6572323wms.69.1663948564353;
        Fri, 23 Sep 2022 08:56:04 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d5587000000b0021badf3cb26sm9055429wrv.63.2022.09.23.08.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 08:56:03 -0700 (PDT)
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
Subject: [PATCH v4 5/7] sched/topology: Introduce sched_numa_hop_mask()
Date:   Fri, 23 Sep 2022 16:55:40 +0100
Message-Id: <20220923155542.1212814-4-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220923132527.1001870-1-vschneid@redhat.com>
References: <20220923132527.1001870-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 include/linux/topology.h | 12 ++++++++++++
 kernel/sched/topology.c  | 31 +++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index 4564faafd0e1..3e91ae6d0ad5 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -245,5 +245,17 @@ static inline const struct cpumask *cpu_cpu_mask(int cpu)
 	return cpumask_of_node(cpu_to_node(cpu));
 }
 
+#ifdef CONFIG_NUMA
+extern const struct cpumask *sched_numa_hop_mask(int node, int hops);
+#else
+static inline const struct cpumask *sched_numa_hop_mask(int node, int hops)
+{
+	if (node == NUMA_NO_NODE && !hops)
+		return cpu_online_mask;
+
+	return ERR_PTR(-EOPNOTSUPP);
+}
+#endif	/* CONFIG_NUMA */
+
 
 #endif /* _LINUX_TOPOLOGY_H */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8739c2a5a54e..ee77706603c0 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2067,6 +2067,37 @@ int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
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
+ * Note that not all hops are equal in distance; see sched_init_numa() for how
+ * distances and masks are handled.
+ *
+ * Also note that this is a reflection of sched_domains_numa_masks, which may change
+ * during the lifetime of the system (offline nodes are taken out of the masks).
+ */
+const struct cpumask *sched_numa_hop_mask(int node, int hops)
+{
+	struct cpumask ***masks = rcu_dereference(sched_domains_numa_masks);
+
+	if (node == NUMA_NO_NODE && !hops)
+		return cpu_online_mask;
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

