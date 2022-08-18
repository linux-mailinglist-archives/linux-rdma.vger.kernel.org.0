Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EBA598930
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Aug 2022 18:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344930AbiHRQpp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Aug 2022 12:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344965AbiHRQpj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Aug 2022 12:45:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90B0BA9E7
        for <linux-rdma@vger.kernel.org>; Thu, 18 Aug 2022 09:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660841137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ygl4bsiGppbXjaR+QFxwzenbyEWvTTquS8G3MYyuF5k=;
        b=KHJ91UGZyodTKLUqmrJt3u6AjctN+Gh/QVXyKc+DzO6nv/uz1vwXgHaHuIoBbIVJSwCBB8
        x770RsdHInn8SCMNvEM/7pVZESB3wz/Bc8BJeJaTMHZbw8OJ2242ldZuIQOBrhTST+owgI
        M7hdiGxYRqlFVpprwj0tZrSdPC+h/I8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-486-J7YHRaiXOyqQj6qEXXj3hA-1; Thu, 18 Aug 2022 12:45:36 -0400
X-MC-Unique: J7YHRaiXOyqQj6qEXXj3hA-1
Received: by mail-wm1-f69.google.com with SMTP id f7-20020a1c6a07000000b003a60ede816cso832172wmc.0
        for <linux-rdma@vger.kernel.org>; Thu, 18 Aug 2022 09:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Ygl4bsiGppbXjaR+QFxwzenbyEWvTTquS8G3MYyuF5k=;
        b=G0xYLotlPc9aQc6Lr8bJ4R4IdaVRIWv36uNKykJtJJ49FB/MCECdgz8u/XhJ6b4bVh
         g/5XTJyNYocMa2+T8li4Aht/F8T2BsUFll4tddLDZHGGPBsg0ann+6t58SHtjT9HC1U5
         Poki1KApoXOlBsqEcWU/1STw3M4ILKC9rzEjqbZQxqwpBpjapKz1coe65pPE6/Suqe+Y
         I6UsHFbeCVjHbSw7Nd9WZnU1AASGctgBduJoSaS1/gChMv4kqRf67Xwwfis/O8Ech5c6
         SM2Jlxea/ascLOLCSgIi/iLlPo6jmTMp4n8aOGul6oj+E/xPkcthL50qgpbXH1tIKPrV
         BUpQ==
X-Gm-Message-State: ACgBeo3B/CclL/kQHHgW/TyiQSUTkJJSDZb7AWsu3UJdZdE0ENUwp9L0
        9f2sxkHnn5fEoAyvFYbkUcllz08R3jUv/SqV93MUnSV0OwlZdVqubAYHtLTtvp4FPOo3DE2M2OE
        eVXojA9zLiQ/LaWLp4xcURw==
X-Received: by 2002:a5d:63cb:0:b0:21e:b81d:8b0d with SMTP id c11-20020a5d63cb000000b0021eb81d8b0dmr2101101wrw.526.1660841135369;
        Thu, 18 Aug 2022 09:45:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7i0NVijGHDSaLCCQYtUON7K5y9O7pv4DOZf3cy/HYjnD2P0jXlg2O08mjKG+P/oEyOridfcQ==
X-Received: by 2002:a5d:63cb:0:b0:21e:b81d:8b0d with SMTP id c11-20020a5d63cb000000b0021eb81d8b0dmr2101084wrw.526.1660841135139;
        Thu, 18 Aug 2022 09:45:35 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id d7-20020a05600c3ac700b003a5ad7f6de2sm2465458wms.15.2022.08.18.09.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 09:45:34 -0700 (PDT)
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
        Barry Song <song.bao.hua@hisilicon.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH v2 4/5] sched/topology: Introduce for_each_numa_hop_cpu()
Date:   Thu, 18 Aug 2022 17:45:21 +0100
Message-Id: <20220818164522.1087673-2-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220818164522.1087673-1-vschneid@redhat.com>
References: <20220817175812.671843-1-vschneid@redhat.com>
 <20220818164522.1087673-1-vschneid@redhat.com>
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

