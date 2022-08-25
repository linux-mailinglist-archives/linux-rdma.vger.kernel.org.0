Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E0F5A1898
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Aug 2022 20:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243323AbiHYSOF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Aug 2022 14:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243374AbiHYSNL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Aug 2022 14:13:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD890BD2AA
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 11:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661451175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ywTMuS9huvM7zHWOxR6GjSmCdhb3SJi0oS2399XlZwU=;
        b=L9pADQwVkbb1Nadfgo3qGCrunaiUMltbPPubfw9SXCkdUw05aCzTHjKxvjZi5d6L7xa/lT
        AeM58nCRd6Lhw8kEKcn26u0vMbYTLn0djwKUceXYvzpaozbTz2McQH+9UWaJRcMIRQrG/S
        4WYjG8/MuWM75CHv2ggN/WpCdbokGfo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-619-Lmgwz7erPMmjcl65SxRrdg-1; Thu, 25 Aug 2022 14:12:53 -0400
X-MC-Unique: Lmgwz7erPMmjcl65SxRrdg-1
Received: by mail-wr1-f71.google.com with SMTP id k20-20020adfb354000000b0022556a0b8cbso2407893wrd.5
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 11:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ywTMuS9huvM7zHWOxR6GjSmCdhb3SJi0oS2399XlZwU=;
        b=Qm7atQKGAVEnhKeOid75t8heOHGQojE5ydJGHB99JXodwvjRdTu54RGMh4e3Ufusmz
         5Cnk8mdDMS8eZHXHUNsXPUBv2fx3L5SEiJJs9SJsLWeZjbh4w99Kk0rzOZSUjWupUhyA
         0tITFGKd+LrDnwPTTj90OilriHN3o2X1DCYxarUA5FszJiEobyY7T6GHpzJKb6bW6qmf
         88C9/lZdmWRX02oUPtWjxK4S0o84NF3bUxH6VUERth1bWD/kAhcZAnqjT42LGkOl0yZl
         yrlvgQxzcPVLl1iD1e1KsbaYrnRAJW3l/lhf7XAaOeWzpju9FPN8QERYuOJqCJnPfNx6
         kY8w==
X-Gm-Message-State: ACgBeo3iOUqIWc02m9/VmnMCiJkSRPJLG4fRPpf8C1s8hnzQ5QKjzd96
        0RWUsJwd+iyUg/+yZUtD0imvN3eqMFOdWDeRoRcFx+AxkFimUxTzjtnBJIXxygxnhSFq7ueDhwT
        Elrndp1YyeS4faUkobdCCGQ==
X-Received: by 2002:a05:600c:4f04:b0:3a5:f380:69dc with SMTP id l4-20020a05600c4f0400b003a5f38069dcmr3147412wmq.103.1661451171996;
        Thu, 25 Aug 2022 11:12:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4fdktDFMuOCPYmE2jaQU9clFyb6AEUVJjx8ZtnEbzWQsDn4rUuPMq7JNqtJC4Fj4rAWF5AyQ==
X-Received: by 2002:a05:600c:4f04:b0:3a5:f380:69dc with SMTP id l4-20020a05600c4f0400b003a5f38069dcmr3147386wmq.103.1661451171834;
        Thu, 25 Aug 2022 11:12:51 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id w1-20020a05600018c100b00225250f2d1bsm20371622wrq.94.2022.08.25.11.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:12:51 -0700 (PDT)
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
Subject: [PATCH v3 9/9] SHOWCASE: net/mlx5e: Leverage for_each_numa_hop_cpu()
Date:   Thu, 25 Aug 2022 19:12:10 +0100
Message-Id: <20220825181210.284283-10-vschneid@redhat.com>
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

Not-signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 229728c80233..0a5432903edd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -812,6 +812,7 @@ static int comp_irqs_request(struct mlx5_core_dev *dev)
 	int ncomp_eqs = table->num_comp_eqs;
 	u16 *cpus;
 	int ret;
+	int cpu;
 	int i;
 
 	ncomp_eqs = table->num_comp_eqs;
@@ -830,8 +831,15 @@ static int comp_irqs_request(struct mlx5_core_dev *dev)
 		ret = -ENOMEM;
 		goto free_irqs;
 	}
-	for (i = 0; i < ncomp_eqs; i++)
-		cpus[i] = cpumask_local_spread(i, dev->priv.numa_node);
+
+	rcu_read_lock();
+	for_each_numa_hop_cpus(cpu, dev->priv.numa_node) {
+		cpus[i] = cpu;
+		if (++i == ncomp_eqs)
+			goto spread_done;
+	}
+spread_done:
+	rcu_read_unlock();
 	ret = mlx5_irqs_request_vectors(dev, cpus, ncomp_eqs, table->comp_irqs);
 	kfree(cpus);
 	if (ret < 0)
-- 
2.31.1

