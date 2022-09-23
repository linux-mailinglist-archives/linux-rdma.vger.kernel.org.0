Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B3B5E7F10
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Sep 2022 17:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiIWP4U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Sep 2022 11:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiIWP4H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Sep 2022 11:56:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16AF14768D
        for <linux-rdma@vger.kernel.org>; Fri, 23 Sep 2022 08:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663948564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9qKy0mrwb1ZaeVcnoJdtpT0vU2IyZpITeq2cNcv3elU=;
        b=LurPLWs6LsWsaRAZ2q62zl2TAJ78YCvwlgwJW4SxDxBp4BjVo0OV8NJK07TZrDjr5rbp3d
        e7yhlA/SsJ33l5OvrxlJxQ/UwYMq5qJHDmKAoI3+6BMjYUH0sGkFwF09Vt5x44kQcujYvi
        kizxAN4Wwya0m7BxQOLxEOpKxNFCEcw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-500-7IYWFg0tN1OHYEWZ3HT01g-1; Fri, 23 Sep 2022 11:56:03 -0400
X-MC-Unique: 7IYWFg0tN1OHYEWZ3HT01g-1
Received: by mail-wr1-f71.google.com with SMTP id l5-20020adfa385000000b0022a482f8285so119934wrb.5
        for <linux-rdma@vger.kernel.org>; Fri, 23 Sep 2022 08:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9qKy0mrwb1ZaeVcnoJdtpT0vU2IyZpITeq2cNcv3elU=;
        b=C4NEoS3xAFNtoW52Yp6jPRajncQ17vDEKso6frf4zkdBUTPsV2JZNP8JGZlq7gcYNj
         CJNp2UI2yEnWObTrvpuz8SjiHTuSpu/5WZVDhIzOyP6+wu5arJaMo0aj1GxvjLAtM2sk
         iXaKm5E5EARTNFMQnnWwjKLkYd+GOKhS2Ag8TBllCRrmvcCWxjFx+d+LJp5znLGm/xzz
         XB60m/qn+8qWv88R9VGelE51DuIuGDDCdadFUuYq7Ma8KNCcYpm1BMX6Bhw+RRaR9SEI
         LkV44jq6byx+16tyydIzCz6RaHg9BrPkWQorkZIumbgdj5tVmdSiEA1xp/t7YfU7IOK4
         rQkQ==
X-Gm-Message-State: ACrzQf3cWh4fNDRqDqihOQmaB098uFPsFjENdQ+ALyK2bpbXjYtdpUjL
        GpZmjHF1ezSMeBJe+N9uI/Sz92aBD/yLdILnPCqY4ygauvxbL5S/lW/WQa8f+UwOxHpBPVBcVJB
        9cKH3Nj1NVw0IbZO8RO10+Q==
X-Received: by 2002:a5d:62c8:0:b0:228:67d2:797b with SMTP id o8-20020a5d62c8000000b0022867d2797bmr5570910wrv.462.1663948562602;
        Fri, 23 Sep 2022 08:56:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4aPbc4vrsR5Vfq6YATZvPVX52Oz7CjIB9xYibgKcC2wNByVZXJ2pv9DnxuyPBkjc5vbnX2Bw==
X-Received: by 2002:a5d:62c8:0:b0:228:67d2:797b with SMTP id o8-20020a5d62c8000000b0022867d2797bmr5570899wrv.462.1663948562369;
        Fri, 23 Sep 2022 08:56:02 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d5587000000b0021badf3cb26sm9055429wrv.63.2022.09.23.08.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 08:56:01 -0700 (PDT)
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
Subject: [PATCH v4 4/7] sched/core: Merge cpumask_andnot()+for_each_cpu() into for_each_cpu_andnot()
Date:   Fri, 23 Sep 2022 16:55:39 +0100
Message-Id: <20220923155542.1212814-3-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220923132527.1001870-1-vschneid@redhat.com>
References: <20220923132527.1001870-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This removes the second use of the sched_core_mask temporary mask.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee28253c9ac0..b4c3112b0095 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -360,10 +360,7 @@ static void __sched_core_flip(bool enabled)
 	/*
 	 * Toggle the offline CPUs.
 	 */
-	cpumask_copy(&sched_core_mask, cpu_possible_mask);
-	cpumask_andnot(&sched_core_mask, &sched_core_mask, cpu_online_mask);
-
-	for_each_cpu(cpu, &sched_core_mask)
+	for_each_cpu_andnot(cpu, cpu_possible_mask, cpu_online_mask)
 		cpu_rq(cpu)->core_enabled = enabled;
 
 	cpus_read_unlock();
-- 
2.31.1

