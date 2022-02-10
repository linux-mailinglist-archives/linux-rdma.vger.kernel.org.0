Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6B04B1A58
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Feb 2022 01:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242501AbiBKAW1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Feb 2022 19:22:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbiBKAW0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Feb 2022 19:22:26 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879E4E5C;
        Thu, 10 Feb 2022 16:22:26 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id p63so9488313iod.11;
        Thu, 10 Feb 2022 16:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=r+2Lxrqd+/2P51TipH+bP8eiwgKfuynFq8H8rT90BTo=;
        b=O0EsFj+PK5aIQhKNiYkuOp8pqc92sDAN2/x3yJmEPRLbP1QWwij1piX3OhbpRMP7Dn
         zvBAKgRCW7S4vtdIdFtO6h0HlIJ0xyT3Dx3wBGWanFtfISRLHpuR/+aeOrzyOwhAjtW3
         sC7Id1ezVuG2bIafzzAhUTZM1O/p4cAj+g7Dzoxeza1lFPPiy2nN+SAUZEWBhYylw/c6
         mp7diWtiWVmMLMo5OtmfD8saDNbBcUDtYLvynvdRaGzh5O+QbN8do6aWL5I4OSjlD1So
         I+a9hiJlmLU9BKl53nAQmdQhaPM7mkLekABzMmfZ9OrNNuprEKK6XzNz/7FNRqEKADQe
         Bn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r+2Lxrqd+/2P51TipH+bP8eiwgKfuynFq8H8rT90BTo=;
        b=P4Wzp9U7Ya0ItxFaKx+DL+ruimLeGJn/9pw1+QL7OycllASwlg9lmUXm25WPo+iH66
         FploEZ1D8IGNmHoNsVN8GJihHZaA9ImqM+2PLmbR8YeDRPcnEhWtddLs8Rv9SzOWkGxA
         R/Snis6bRHCj5+LBwA7MNApd0MnBTLHtytX7fmJ5EsgF9zNg9kmG7GbaH2NKCUnlUsu8
         wcaNv2NQJlhgBgPYjtPAqHKgQMI3Gck74rYmEY51CzR7OiTAMpe6HxFiviPXvIJcyvNm
         RRAcKsadeRc1PJXtXKf+J50CJFjneWM8ZQuOcXNZv6clBcKcQz3Mp+fJK+/ONII/Mkgv
         v/tQ==
X-Gm-Message-State: AOAM532w4uwV/EBE9pda9xIo/9hSPamo/Tlesp0IwE+fmuMK9wWZilti
        laW1ICRtflGWF44mzDUQ83I=
X-Google-Smtp-Source: ABdhPJwhX5j3SHuGJVMlF9z+AvEbLjcuC5tdzf4YVYtzgTeP+dHG6E9oAedcHzacHNV+YT4aqz1byA==
X-Received: by 2002:a05:6638:389c:: with SMTP id b28mr5326203jav.176.1644538945854;
        Thu, 10 Feb 2022 16:22:25 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id i9sm2610693ilm.74.2022.02.10.16.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:22:25 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 41/49] RDMA/hfi1: replace cpumask_weight with cpumask_weight_{eq, ...} where appropriate
Date:   Thu, 10 Feb 2022 14:49:25 -0800
Message-Id: <20220210224933.379149-42-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Infiniband code uses cpumask_weight() to compare the weight of cpumask
with a given number. We can do it more efficiently with
cpumask_weight_{eq, ...} because conditional cpumask_weight may stop
traversing the cpumask earlier, as soon as condition is (or can't be) met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/infiniband/hw/hfi1/affinity.c    | 9 ++++-----
 drivers/infiniband/hw/qib/qib_file_ops.c | 2 +-
 drivers/infiniband/hw/qib/qib_iba7322.c  | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
index 877f8e84a672..a9ad07808dea 100644
--- a/drivers/infiniband/hw/hfi1/affinity.c
+++ b/drivers/infiniband/hw/hfi1/affinity.c
@@ -506,7 +506,7 @@ static int _dev_comp_vect_cpu_mask_init(struct hfi1_devdata *dd,
 	 * available CPUs divide it by the number of devices in the
 	 * local NUMA node.
 	 */
-	if (cpumask_weight(&entry->comp_vect_mask) == 1) {
+	if (cpumask_weight_eq(&entry->comp_vect_mask, 1)) {
 		possible_cpus_comp_vect = 1;
 		dd_dev_warn(dd,
 			    "Number of kernel receive queues is too large for completion vector affinity to be effective\n");
@@ -592,7 +592,7 @@ int hfi1_dev_affinity_init(struct hfi1_devdata *dd)
 {
 	struct hfi1_affinity_node *entry;
 	const struct cpumask *local_mask;
-	int curr_cpu, possible, i, ret;
+	int curr_cpu, i, ret;
 	bool new_entry = false;
 
 	local_mask = cpumask_of_node(dd->node);
@@ -625,10 +625,9 @@ int hfi1_dev_affinity_init(struct hfi1_devdata *dd)
 			    local_mask);
 
 		/* fill in the receive list */
-		possible = cpumask_weight(&entry->def_intr.mask);
 		curr_cpu = cpumask_first(&entry->def_intr.mask);
 
-		if (possible == 1) {
+		if (cpumask_weight_eq(&entry->def_intr.mask, 1)) {
 			/* only one CPU, everyone will use it */
 			cpumask_set_cpu(curr_cpu, &entry->rcv_intr.mask);
 			cpumask_set_cpu(curr_cpu, &entry->general_intr_mask);
@@ -1016,7 +1015,7 @@ int hfi1_get_proc_affinity(int node)
 		cpu = cpumask_first(proc_mask);
 		cpumask_set_cpu(cpu, &set->used);
 		goto done;
-	} else if (current->nr_cpus_allowed < cpumask_weight(&set->mask)) {
+	} else if (cpumask_weight_gt(&set->mask, current->nr_cpus_allowed)) {
 		hfi1_cdbg(PROC, "PID %u %s affinity set to CPU set(s) %*pbl",
 			  current->pid, current->comm,
 			  cpumask_pr_args(proc_mask));
diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index aa290928cf96..add89bc21b0a 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -1151,7 +1151,7 @@ static void assign_ctxt_affinity(struct file *fp, struct qib_devdata *dd)
 	 * reserve a processor for it on the local NUMA node.
 	 */
 	if ((weight >= qib_cpulist_count) &&
-		(cpumask_weight(local_mask) <= qib_cpulist_count)) {
+		(cpumask_weight_le(local_mask, qib_cpulist_count))) {
 		for_each_cpu(local_cpu, local_mask)
 			if (!test_and_set_bit(local_cpu, qib_cpulist)) {
 				fd->rec_cpu_num = local_cpu;
diff --git a/drivers/infiniband/hw/qib/qib_iba7322.c b/drivers/infiniband/hw/qib/qib_iba7322.c
index ceed302cf6a0..b17f96509d2c 100644
--- a/drivers/infiniband/hw/qib/qib_iba7322.c
+++ b/drivers/infiniband/hw/qib/qib_iba7322.c
@@ -3405,7 +3405,7 @@ static void qib_setup_7322_interrupt(struct qib_devdata *dd, int clearpend)
 	local_mask = cpumask_of_pcibus(dd->pcidev->bus);
 	firstcpu = cpumask_first(local_mask);
 	if (firstcpu >= nr_cpu_ids ||
-			cpumask_weight(local_mask) == num_online_cpus()) {
+			cpumask_weight_eq(local_mask, num_online_cpus())) {
 		local_mask = topology_core_cpumask(0);
 		firstcpu = cpumask_first(local_mask);
 	}
-- 
2.32.0

