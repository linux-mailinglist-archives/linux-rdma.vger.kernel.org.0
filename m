Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB0A5A1890
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Aug 2022 20:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbiHYSM4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Aug 2022 14:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbiHYSMw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Aug 2022 14:12:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C389BD1D2
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 11:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661451165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hRCkxRGTLmsrQqX09/lEo5/j9SdQgOT7KVWNp7Ie7zk=;
        b=Np4i0HfgmY2pkSbYaqjljpk0JKONL9AGVTW113C5hlGRvel+ZzngFg9qY9YUA1piJDkETC
        q5c27tvK69sanozxYkZTLHu7j5xiU7FXdCnGupWyMkqQrr6cbX82pmXF9UjEwFPoBB8Yye
        lq5zp25ffDqNUdYhQre0AdXntzoV/Go=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-398-gEllmcggPJmevNTo10ISag-1; Thu, 25 Aug 2022 14:12:41 -0400
X-MC-Unique: gEllmcggPJmevNTo10ISag-1
Received: by mail-wr1-f72.google.com with SMTP id i24-20020adfaad8000000b002251cb5e812so3646677wrc.14
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 11:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=hRCkxRGTLmsrQqX09/lEo5/j9SdQgOT7KVWNp7Ie7zk=;
        b=y1GIXKDRkULFEfgMkEkN4PdoHKRRwJ9tn7ivdDw32u/mK674PrLmy6G3nJJ93h1A2B
         Pis1cspacWnNRTGX9uoUSSaEW+IRq1tqjHtBn0I9KfKQJVd6XueaxSpJ7KC+lzjxOVuM
         QdAIUzl1usmHVbEiat5fm1PUtsO/uJz7gyAia+VOUwaUaENZb70DA4f7vgVfg2KmBCa7
         LF5468DBwk6kv4yuz4eluaiDukjOaSg/TCtuhd+VRBu9voYZSiQbKax2ZC37X9KF5/9p
         TWowB4WsXdGik70D2yR3uaX4E70/xfY3WjdbfglvJlS+EBe/t2/K6n/HFtWDpJBHi9dI
         jo5w==
X-Gm-Message-State: ACgBeo2yF8yEMADyit3UsSMHGOTbESh3tVydhFMqqhHTgC7rJJQ9VfT5
        ymWXQcYOoFUWgyEOM+iCdeu50KBWYsEKVlGjWYi9BfFRlqvmFyExt38grZ548B/S60COMNl7S3z
        OB4amBV6BfXeLDreVvgl5gw==
X-Received: by 2002:a5d:45c4:0:b0:225:4320:1401 with SMTP id b4-20020a5d45c4000000b0022543201401mr2994487wrs.474.1661451160646;
        Thu, 25 Aug 2022 11:12:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4fjN7hsvjTudH2itqlMcc3FAuj0f548hYAGxBnKB1bc1Mv3He53yWfXNTJ/JWMyImi2TUnJQ==
X-Received: by 2002:a5d:45c4:0:b0:225:4320:1401 with SMTP id b4-20020a5d45c4000000b0022543201401mr2994455wrs.474.1661451160399;
        Thu, 25 Aug 2022 11:12:40 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id w1-20020a05600018c100b00225250f2d1bsm20371622wrq.94.2022.08.25.11.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:12:39 -0700 (PDT)
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
Subject: [PATCH v3 1/9] cpumask: Make cpumask_full() check for nr_cpu_ids bits
Date:   Thu, 25 Aug 2022 19:12:02 +0100
Message-Id: <20220825181210.284283-2-vschneid@redhat.com>
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

Consider a system with 4 CPUs and:
  CONFIG_NR_CPUS=64
  CONFIG_CPUMASK_OFFSTACK=n

In this situation, we have:
  nr_cpumask_bits == NR_CPUS == 64
  nr_cpu_ids = 4

Per smp.c::setup_nr_cpu_ids(), nr_cpu_ids <= NR_CPUS, so we want
cpumask_full() to check for nr_cpu_ids bits set.

This issue is currently pointed out by the cpumask KUnit tests:

  [   14.072028]     # test_cpumask_weight: EXPECTATION FAILED at lib/test_cpumask.c:57
  [   14.072028]     Expected cpumask_full(((const struct cpumask *)&__cpu_possible_mask)) to be true, but is false
  [   14.079333]     not ok 1 - test_cpumask_weight

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/cpumask.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index bd047864c7ac..1414ce8cd003 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -574,7 +574,7 @@ static inline bool cpumask_empty(const struct cpumask *srcp)
  */
 static inline bool cpumask_full(const struct cpumask *srcp)
 {
-	return bitmap_full(cpumask_bits(srcp), nr_cpumask_bits);
+	return bitmap_full(cpumask_bits(srcp), nr_cpu_ids);
 }
 
 /**
-- 
2.31.1

