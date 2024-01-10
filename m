Return-Path: <linux-rdma+bounces-576-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F39828450
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jan 2024 11:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C661E1C23DAE
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jan 2024 10:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5BF381DE;
	Tue,  9 Jan 2024 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XiZAh96x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63B5374FE;
	Tue,  9 Jan 2024 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 5BF6820B3CC4; Tue,  9 Jan 2024 02:51:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5BF6820B3CC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704797494;
	bh=8KNJQqGWQfH/h7F1Q5rQO5g9we6YWyykhE+RQJsMV2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XiZAh96x0GrkVeksmPP/EDDkT/8ig5CE2RNqsmwIkJv+CUAn9TwCYK0Fk0oZ9yoIV
	 /YfUIVAK7/pDKml/bNYgCXIGxgVdYzScP1ZZS4SZgWg1IldxLz2iZWHXG4+4XtDUbL
	 dvCq1n0okooemTO+NW3v2Sq44ARD4sqXbKCno0ek=
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	longli@microsoft.com,
	yury.norov@gmail.com,
	leon@kernel.org,
	cai.huoqing@linux.dev,
	ssengar@linux.microsoft.com,
	vkuznets@redhat.com,
	tglx@linutronix.de,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: schakrabarti@microsoft.com,
	paulros@microsoft.com
Subject: [PATCH 3/4 net-next] net: mana: add a function to spread IRQs per CPUs
Date: Tue,  9 Jan 2024 02:51:17 -0800
Message-Id: <1704797478-32377-4-git-send-email-schakrabarti@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1704797478-32377-1-git-send-email-schakrabarti@linux.microsoft.com>
References: <1704797478-32377-1-git-send-email-schakrabarti@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Yury Norov <yury.norov@gmail.com>

Souradeep investigated that the driver performs faster if IRQs are
spread on CPUs with the following heuristics:

1. No more than one IRQ per CPU, if possible;
2. NUMA locality is the second priority;
3. Sibling dislocality is the last priority.

Let's consider this topology:

Node            0               1
Core        0       1       2       3
CPU       0   1   2   3   4   5   6   7

The most performant IRQ distribution based on the above topology
and heuristics may look like this:

IRQ     Nodes   Cores   CPUs
0       1       0       0-1
1       1       1       2-3
2       1       0       0-1
3       1       1       2-3
4       2       2       4-5
5       2       3       6-7
6       2       2       4-5
7       2       3       6-7

The irq_setup() routine introduced in this patch leverages the
for_each_numa_hop_mask() iterator and assigns IRQs to sibling groups
as described above.

According to [1], for NUMA-aware but sibling-ignorant IRQ distribution
based on cpumask_local_spread() performance test results look like this:

./ntttcp -r -m 16
NTTTCP for Linux 1.4.0
---------------------------------------------------------
08:05:20 INFO: 17 threads created
08:05:28 INFO: Network activity progressing...
08:06:28 INFO: Test run completed.
08:06:28 INFO: Test cycle finished.
08:06:28 INFO: #####  Totals:  #####
08:06:28 INFO: test duration    :60.00 seconds
08:06:28 INFO: total bytes      :630292053310
08:06:28 INFO:   throughput     :84.04Gbps
08:06:28 INFO:   retrans segs   :4
08:06:28 INFO: cpu cores        :192
08:06:28 INFO:   cpu speed      :3799.725MHz
08:06:28 INFO:   user           :0.05%
08:06:28 INFO:   system         :1.60%
08:06:28 INFO:   idle           :96.41%
08:06:28 INFO:   iowait         :0.00%
08:06:28 INFO:   softirq        :1.94%
08:06:28 INFO:   cycles/byte    :2.50
08:06:28 INFO: cpu busy (all)   :534.41%

For NUMA- and sibling-aware IRQ distribution, the same test works
15% faster:

./ntttcp -r -m 16
NTTTCP for Linux 1.4.0
---------------------------------------------------------
08:08:51 INFO: 17 threads created
08:08:56 INFO: Network activity progressing...
08:09:56 INFO: Test run completed.
08:09:56 INFO: Test cycle finished.
08:09:56 INFO: #####  Totals:  #####
08:09:56 INFO: test duration    :60.00 seconds
08:09:56 INFO: total bytes      :741966608384
08:09:56 INFO:   throughput     :98.93Gbps
08:09:56 INFO:   retrans segs   :6
08:09:56 INFO: cpu cores        :192
08:09:56 INFO:   cpu speed      :3799.791MHz
08:09:56 INFO:   user           :0.06%
08:09:56 INFO:   system         :1.81%
08:09:56 INFO:   idle           :96.18%
08:09:56 INFO:   iowait         :0.00%
08:09:56 INFO:   softirq        :1.95%
08:09:56 INFO:   cycles/byte    :2.25
08:09:56 INFO: cpu busy (all)   :569.22%

[1] https://lore.kernel.org/all/20231211063726.GA4977@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Co-developed-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 6367de0c2c2e..6a967d6be01e 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1243,6 +1243,35 @@ void mana_gd_free_res_map(struct gdma_resource *r)
 	r->size = 0;
 }
 
+static __maybe_unused int irq_setup(unsigned int *irqs, unsigned int len, int node)
+{
+	const struct cpumask *next, *prev = cpu_none_mask;
+	cpumask_var_t cpus __free(free_cpumask_var);
+	int cpu, weight;
+
+	if (!alloc_cpumask_var(&cpus, GFP_KERNEL))
+		return -ENOMEM;
+
+	rcu_read_lock();
+	for_each_numa_hop_mask(next, node) {
+		weight = cpumask_weight_andnot(next, prev);
+		while (weight > 0) {
+			cpumask_andnot(cpus, next, prev);
+			for_each_cpu(cpu, cpus) {
+				if (len-- == 0)
+					goto done;
+				irq_set_affinity_and_hint(*irqs++, topology_sibling_cpumask(cpu));
+				cpumask_andnot(cpus, cpus, topology_sibling_cpumask(cpu));
+				--weight;
+			}
+		}
+		prev = next;
+	}
+done:
+	rcu_read_unlock();
+	return 0;
+}
+
 static int mana_gd_setup_irqs(struct pci_dev *pdev)
 {
 	unsigned int max_queues_per_port = num_online_cpus();
-- 
2.34.1


