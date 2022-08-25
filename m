Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D2F5A187C
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Aug 2022 20:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243368AbiHYSNK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Aug 2022 14:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243250AbiHYSMx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Aug 2022 14:12:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A076FBD1FA
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 11:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661451166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aa7TgxIpu/jW/iqd5xTwDqe/1bK1e/1x+Xly3SMXIUI=;
        b=OFyQYRjopAcYdG8hOjN1YZkgCBhK2nxGPqps+s0ePB6oUX3GUsHaYiqmPH4TzW9Hu2VBdo
        MefyyVT9htOF+iT+Um5L5TA9P4CyLaIjK+nlf30K8IjXcRf8jEE9FichpPC/2hNVPAfePO
        Q1lFhHOES+qo39S/uoK6wiIGDiYCCYM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-609-5_EHFnEhMpWQHCjvPQv7pQ-1; Thu, 25 Aug 2022 14:12:43 -0400
X-MC-Unique: 5_EHFnEhMpWQHCjvPQv7pQ-1
Received: by mail-wr1-f71.google.com with SMTP id c6-20020adfa706000000b00222c3caa23eso3618216wrd.15
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 11:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=aa7TgxIpu/jW/iqd5xTwDqe/1bK1e/1x+Xly3SMXIUI=;
        b=Z0/fcBcBDejoGWPVAEXPZlzjdVK/Rza3eGqe3wmxSqtM8Ssn+cRYfx+/cKbzm21UGx
         vpBPB1fgj+BD5y5zFsChyxHVzoKEBmW9uvN54+uA6pFO4LNbcJmgbDoyhdkp9lpQQQuZ
         p9Ou34gO4rcwbsoq2bBEMP7FiJPalHSNWxqErN7DzIaZTjIlnQ0cre314F07Zy+HAkrr
         f7H98wdNkxZoKczQ32J+HOQljLEUM8zbJlXcaySgNNtrLpLSanL/UU9BszwuwxLmxV/A
         shvYvj6NHUq+krNhzlARQd8NvwDRdnTKXejbyNuLoItPDFZLlGCI4dmZfr0v+Mj6mNcq
         aKxg==
X-Gm-Message-State: ACgBeo236V0gFVwZEA0Q0OipE3/GrZ8ncBP3GeBOgsXVzHb5KP09r3qD
        g48H4Q/d0kx83CgcluyqLluRn9oM4Oze3ppK64dsHmq3XwcZV5wirdJIvutbpy0gFND1U549x7x
        z4TICBqjNV44DbNXbeGDO1A==
X-Received: by 2002:a05:6000:1f9b:b0:225:7694:3b36 with SMTP id bw27-20020a0560001f9b00b0022576943b36mr3024124wrb.310.1661451161925;
        Thu, 25 Aug 2022 11:12:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR48+XemZLeoI5/0hKjHm0hpojsmml99HpqQqzINgCYNPX/9v3T9th/wzQI0CY0AzciHT6w5pQ==
X-Received: by 2002:a05:6000:1f9b:b0:225:7694:3b36 with SMTP id bw27-20020a0560001f9b00b0022576943b36mr3024110wrb.310.1661451161782;
        Thu, 25 Aug 2022 11:12:41 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id w1-20020a05600018c100b00225250f2d1bsm20371622wrq.94.2022.08.25.11.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:12:41 -0700 (PDT)
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
Subject: [PATCH v3 2/9] lib/test_cpumask: Make test_cpumask_last check for nr_cpu_ids bits
Date:   Thu, 25 Aug 2022 19:12:03 +0100
Message-Id: <20220825181210.284283-3-vschneid@redhat.com>
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

test_cpumask_last() currently fails on a system with
  CONFIG_NR_CPUS=64
  CONFIG_CPUMASK_OFFSTACK=n
  nr_cpu_ids < NR_CPUS

  [   14.088853]     # test_cpumask_last: EXPECTATION FAILED at lib/test_cpumask.c:77
  [   14.088853]     Expected ((unsigned int)64) - 1 == cpumask_last(((const struct cpumask *)&__cpu_possible_mask)), but
  [   14.088853]         ((unsigned int)64) - 1 == 63
  [   14.088853]         cpumask_last(((const struct cpumask *)&__cpu_possible_mask)) == 3
  [   14.090435]     not ok 3 - test_cpumask_last

Per smp.c::setup_nr_cpu_ids(), nr_cpu_ids <= NR_CPUS, so we want
the test to use nr_cpu_ids rather than nr_cpumask_bits.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 lib/test_cpumask.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/test_cpumask.c b/lib/test_cpumask.c
index a31a1622f1f6..81b17563fcb3 100644
--- a/lib/test_cpumask.c
+++ b/lib/test_cpumask.c
@@ -73,8 +73,8 @@ static void test_cpumask_first(struct kunit *test)
 
 static void test_cpumask_last(struct kunit *test)
 {
-	KUNIT_EXPECT_LE(test, nr_cpumask_bits, cpumask_last(&mask_empty));
-	KUNIT_EXPECT_EQ(test, nr_cpumask_bits - 1, cpumask_last(cpu_possible_mask));
+	KUNIT_EXPECT_LE(test, nr_cpu_ids, cpumask_last(&mask_empty));
+	KUNIT_EXPECT_EQ(test, nr_cpu_ids - 1, cpumask_last(cpu_possible_mask));
 }
 
 static void test_cpumask_next(struct kunit *test)
-- 
2.31.1

