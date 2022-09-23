Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BAC5E7F0C
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Sep 2022 17:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiIWP4I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Sep 2022 11:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiIWP4G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Sep 2022 11:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F79147687
        for <linux-rdma@vger.kernel.org>; Fri, 23 Sep 2022 08:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663948563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vikRyGRx44R+pUt2VG/nhewaVPQwv7B4yL3TDMhKXBE=;
        b=YVVABy+4r8lcGN1XtNPSh7WJ4Dksxz0mD1VwqJf81oOIiMJDAe9+qNjO0as2I1MwX1ydYc
        amgyO9Ypo3M4sF4Ay8QJfEEcH0H0LxdSiUyduZMMbdlJxsUV3ahSGzmP63TEjyxzYlWoGd
        8EL73hatbuGLYNfWnfnwvdUKx6kBETU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-112-kg5ab3cMPmq_q4kQ-IeEHQ-1; Fri, 23 Sep 2022 11:56:01 -0400
X-MC-Unique: kg5ab3cMPmq_q4kQ-IeEHQ-1
Received: by mail-wr1-f72.google.com with SMTP id s5-20020adfa285000000b0022ad5c2771cso107109wra.18
        for <linux-rdma@vger.kernel.org>; Fri, 23 Sep 2022 08:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vikRyGRx44R+pUt2VG/nhewaVPQwv7B4yL3TDMhKXBE=;
        b=3A0fpKWO/abax9kK+fySGIMX3QhyuPXvQtPBDsKzuwMMznYuE5sZoUpHhLnepp2XT1
         50Eab15x8nYie+kozznD2jYbsFJNRRReXKJfU54HaWTXnmcNfK3tZNiWcXw6d/kRnO1R
         ZvyT7Ee+Wv4NfHK3A/RkFMrIUiRCkP04iqNKvYnpys1ERfGIqcF5MO3ZLn8t55aGFmbv
         qtxYoWVOZw4BFEkG3BYsVZtygu+it8ymRZatVjD5JslpK+M1YAuzKdUfB7hhFhl/2YET
         O7exzrVy0g7WwwhgTFZf+6FTXEPX2U78UxVnL3BkZivptOO+1XkQKJRm98MWLInJTWIi
         taPA==
X-Gm-Message-State: ACrzQf0nYCT5R+u5MDFuc3uJlBw+yIg95FGhSJr4sF1PfjQdfPhqu8zy
        BIlME5qTZ86UY77G3LP1sMtgFIXzHpKmsf4AoVylVE0yu2vFBtGCM+SwI+WaB8Mt4DqKTCd0NrB
        gYHR59nAuGVTAuFW+ZHsXWg==
X-Received: by 2002:a05:6000:101:b0:228:de40:8898 with SMTP id o1-20020a056000010100b00228de408898mr5638919wrx.106.1663948560658;
        Fri, 23 Sep 2022 08:56:00 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM47DzwiN5PM9fuuQwSaApTf51dVQD8qwTfh15JBMFf32iFHSPpJD0mu7a8+o3i7y45MFlP0iA==
X-Received: by 2002:a05:6000:101:b0:228:de40:8898 with SMTP id o1-20020a056000010100b00228de408898mr5638907wrx.106.1663948560504;
        Fri, 23 Sep 2022 08:56:00 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d5587000000b0021badf3cb26sm9055429wrv.63.2022.09.23.08.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 08:55:59 -0700 (PDT)
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
Subject: [PATCH v4 3/7] lib/test_cpumask: Add for_each_cpu_and(not) tests
Date:   Fri, 23 Sep 2022 16:55:38 +0100
Message-Id: <20220923155542.1212814-2-vschneid@redhat.com>
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

Following the recent introduction of for_each_andnot(), add some tests to
ensure for_each_cpu_and(not) results in the same as iterating over the
result of cpumask_and(not)().

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 lib/cpumask_kunit.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/cpumask_kunit.c b/lib/cpumask_kunit.c
index ecbeec72221e..d1fc6ece21f3 100644
--- a/lib/cpumask_kunit.c
+++ b/lib/cpumask_kunit.c
@@ -33,6 +33,19 @@
 		KUNIT_EXPECT_EQ_MSG((test), nr_cpu_ids - mask_weight, iter, MASK_MSG(mask));	\
 	} while (0)
 
+#define EXPECT_FOR_EACH_CPU_OP_EQ(test, op, mask1, mask2)			\
+	do {									\
+		const cpumask_t *m1 = (mask1);					\
+		const cpumask_t *m2 = (mask2);					\
+		int weight;                                                     \
+		int cpu, iter = 0;						\
+		cpumask_##op(&mask_tmp, m1, m2);                                \
+		weight = cpumask_weight(&mask_tmp);				\
+		for_each_cpu_##op(cpu, mask1, mask2)				\
+			iter++;							\
+		KUNIT_EXPECT_EQ((test), weight, iter);				\
+	} while (0)
+
 #define EXPECT_FOR_EACH_CPU_WRAP_EQ(test, mask)			\
 	do {							\
 		const cpumask_t *m = (mask);			\
@@ -54,6 +67,7 @@
 
 static cpumask_t mask_empty;
 static cpumask_t mask_all;
+static cpumask_t mask_tmp;
 
 static void test_cpumask_weight(struct kunit *test)
 {
@@ -101,10 +115,15 @@ static void test_cpumask_iterators(struct kunit *test)
 	EXPECT_FOR_EACH_CPU_EQ(test, &mask_empty);
 	EXPECT_FOR_EACH_CPU_NOT_EQ(test, &mask_empty);
 	EXPECT_FOR_EACH_CPU_WRAP_EQ(test, &mask_empty);
+	EXPECT_FOR_EACH_CPU_OP_EQ(test, and, &mask_empty, &mask_empty);
+	EXPECT_FOR_EACH_CPU_OP_EQ(test, and, cpu_possible_mask, &mask_empty);
+	EXPECT_FOR_EACH_CPU_OP_EQ(test, andnot, &mask_empty, &mask_empty);
 
 	EXPECT_FOR_EACH_CPU_EQ(test, cpu_possible_mask);
 	EXPECT_FOR_EACH_CPU_NOT_EQ(test, cpu_possible_mask);
 	EXPECT_FOR_EACH_CPU_WRAP_EQ(test, cpu_possible_mask);
+	EXPECT_FOR_EACH_CPU_OP_EQ(test, and, cpu_possible_mask, cpu_possible_mask);
+	EXPECT_FOR_EACH_CPU_OP_EQ(test, andnot, cpu_possible_mask, &mask_empty);
 }
 
 static void test_cpumask_iterators_builtin(struct kunit *test)
-- 
2.31.1

