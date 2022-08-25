Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECE25A1880
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Aug 2022 20:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243261AbiHYSMx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Aug 2022 14:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243206AbiHYSMu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Aug 2022 14:12:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6F5BD172
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 11:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661451162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KiSNPKBlPRcccx1lRe0Q2eNIt6M0VYiwkWljd6A0lLc=;
        b=Ta3W0kHVfFZFRQ4OU1HaxBhNOLVnBsqa001E9/PTBg6tpa4Qo6fF420lxogg52zuVOlhyp
        UnM5hSadHivO6CNvePbIkfwyXCEm7LJMYq6UpJgD9JyiUWGbdkh56oBPFubTA+8h05sLYp
        Lv6Obr7DZnLiXTfjXWwh3vGrQKBjGL0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-621-UqAg0k2VPSKR-tpSEd0uGA-1; Thu, 25 Aug 2022 14:12:40 -0400
X-MC-Unique: UqAg0k2VPSKR-tpSEd0uGA-1
Received: by mail-wm1-f72.google.com with SMTP id c64-20020a1c3543000000b003a61987ffb3so11233771wma.6
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 11:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=KiSNPKBlPRcccx1lRe0Q2eNIt6M0VYiwkWljd6A0lLc=;
        b=fzZsJ++C3I0wFT9NhIG+/axyan8wnyBBsQBLdrWskSaR+tHbcOOACJaEuQp7PBPw6X
         3WOZhCVCN9pzvG9OROVddb7xu+jxIMaHoJ3Ar0glsmHzAtk3CzS246Ok6GLnuCDw3oC3
         BE0SWs6mKFQwGSGGtr6YjNANQ9Z3UF4EnxknKFfzywJVoJi3vXtS0G0JjqzyTFaTZR6R
         6Gt1KbMfltY9dpCM4mKijCpDGsM19nfPe9X4XQVO2oLvI+8ZNUkHoXXGhTYWFdDKhYzd
         FmWFKBoIv0tckEeITENVOadnAdHeiuBir2NtI3LDxbVh2WryUA8taMWwHubtdXgcM0WF
         ZExg==
X-Gm-Message-State: ACgBeo1kZ/JN5hnjP7PDHY9orHO+BWfiVi15ilYoaqSzUqL4UxC6VbDz
        AT2GcgNbiSpqqtXDLytbpvzyPygOIDnXHyHMdIx7q86xWnPscAzvb3qF9L7T3kmiA5SJ6pyZr9x
        BZbJNk19hfIfd47jm3C+fmg==
X-Received: by 2002:a05:6000:1f19:b0:225:6e25:aa01 with SMTP id bv25-20020a0560001f1900b002256e25aa01mr2885508wrb.236.1661451159111;
        Thu, 25 Aug 2022 11:12:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5/VNF/YtNl2382koJzD84Jd7vQmcSTDh7XnUSh9pQOvX49DkPEm+3sX79ZyFI9hYG7dU+Mbg==
X-Received: by 2002:a05:6000:1f19:b0:225:6e25:aa01 with SMTP id bv25-20020a0560001f1900b002256e25aa01mr2885493wrb.236.1661451158813;
        Thu, 25 Aug 2022 11:12:38 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id w1-20020a05600018c100b00225250f2d1bsm20371622wrq.94.2022.08.25.11.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:12:38 -0700 (PDT)
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
Subject: [PATCH v3 0/9] sched, net: NUMA-aware CPU spreading interface
Date:   Thu, 25 Aug 2022 19:12:01 +0100
Message-Id: <20220825181210.284283-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
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

Hi folks,

Tariq pointed out in [1] that drivers allocating IRQ vectors would benefit
from having smarter NUMA-awareness (cpumask_local_spread() doesn't quite cut
it).

The proposed interface involved an array of CPUs and a temporary cpumask, and
being my difficult self what I'm proposing here is an interface that doesn't
require any temporary storage other than some stack variables (at the cost of
one wild macro).

Patch 9/9 is just there to showcase how the thing would be used. If this doesn't
get hated on, I'll let Tariq pick this up and push it with his networking driver
changes (with actual changelogs).

[1]: https://lore.kernel.org/all/20220728191203.4055-1-tariqt@nvidia.com/

A note on treewide use of for_each_cpu_andnot()
===============================================

I've used the below coccinelle script to find places that could be patched (I
couldn't figure out the valid syntax to patch from coccinelle itself):

,-----
@tmpandnot@
expression tmpmask;
iterator for_each_cpu;
position p;
statement S;
@@
cpumask_andnot(tmpmask, ...);

...

(
for_each_cpu@p(..., tmpmask, ...)
	S
|
for_each_cpu@p(..., tmpmask, ...)
{
	...
}
)

@script:python depends on tmpandnot@
p << tmpandnot.p;
@@
coccilib.report.print_report(p[0], "andnot loop here")
'-----

Which yields (against c40e8341e3b3):

.//arch/powerpc/kernel/smp.c:1587:1-13: andnot loop here
.//arch/powerpc/kernel/smp.c:1530:1-13: andnot loop here
.//arch/powerpc/kernel/smp.c:1440:1-13: andnot loop here
.//arch/powerpc/platforms/powernv/subcore.c:306:2-14: andnot loop here
.//arch/x86/kernel/apic/x2apic_cluster.c:62:1-13: andnot loop here
.//drivers/acpi/acpi_pad.c:110:1-13: andnot loop here
.//drivers/cpufreq/armada-8k-cpufreq.c:148:1-13: andnot loop here
.//drivers/cpufreq/powernv-cpufreq.c:931:1-13: andnot loop here
.//drivers/net/ethernet/sfc/efx_channels.c:73:1-13: andnot loop here
.//drivers/net/ethernet/sfc/siena/efx_channels.c:73:1-13: andnot loop here
.//kernel/sched/core.c:345:1-13: andnot loop here
.//kernel/sched/core.c:366:1-13: andnot loop here
.//net/core/dev.c:3058:1-13: andnot loop here

A lot of those are actually of the shape

  for_each_cpu(cpu, mask) {
      ...
      cpumask_andnot(mask, ...);
  }

I think *some* of the powerpc ones would be a match for for_each_cpu_andnot(),
but I decided to just stick to the one obvious one in __sched_core_flip().
  
Revisions
=========

v2 -> v3
++++++++

o Added for_each_cpu_and() and for_each_cpu_andnot() tests (Yury)
o New patches to fix issues raised by running the above

o New patch to use for_each_cpu_andnot() in sched/core.c (Yury)

v1 -> v2
++++++++

o Split _find_next_bit() @invert into @invert1 and @invert2 (Yury)
o Rebase onto v6.0-rc1

Cheers,
Valentin

Valentin Schneider (9):
  cpumask: Make cpumask_full() check for nr_cpu_ids bits
  lib/test_cpumask: Make test_cpumask_last check for nr_cpu_ids bits
  bitops: Introduce find_next_andnot_bit()
  cpumask: Introduce for_each_cpu_andnot()
  lib/test_cpumask: Add for_each_cpu_and(not) tests
  sched/core: Merge cpumask_andnot()+for_each_cpu() into
    for_each_cpu_andnot()
  sched/topology: Introduce sched_numa_hop_mask()
  sched/topology: Introduce for_each_numa_hop_cpu()
  SHOWCASE: net/mlx5e: Leverage for_each_numa_hop_cpu()

 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 12 ++++-
 include/linux/cpumask.h                      | 41 ++++++++++++++++-
 include/linux/find.h                         | 44 ++++++++++++++++---
 include/linux/topology.h                     | 46 ++++++++++++++++++++
 kernel/sched/core.c                          |  5 +--
 kernel/sched/topology.c                      | 28 ++++++++++++
 lib/find_bit.c                               | 23 +++++-----
 lib/test_cpumask.c                           | 23 +++++++++-
 8 files changed, 196 insertions(+), 26 deletions(-)

--
2.31.1

