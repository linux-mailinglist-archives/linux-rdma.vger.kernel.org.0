Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5776F4B1989
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Feb 2022 00:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242420AbiBJXdv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Feb 2022 18:33:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiBJXdu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Feb 2022 18:33:50 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF07E83;
        Thu, 10 Feb 2022 15:33:50 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id h7so9454812iof.3;
        Thu, 10 Feb 2022 15:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=scQQOeGEKS1UtnSb4hDa2pMn49T7lX7tre18iE1yAHU=;
        b=RIBQ3M1+e7Un6Pm8klMv7JFRyzLD6R+Ak9wA8JMgVvjGGuFJshj+1pYyY0wdO/sViu
         r/Sy2qLBoQJw0gRyu/afxAsCIuXSI2sSFdu1izZtWcqnwuDs2ZTvAzbFVFezEXxG+raL
         rq/FBsjW8A6NSkaXInMpTgc7OsquM6YmI2Q63qt5QOeHsXoQ5u90pe3WWu3iprephA1b
         d0YrHC/kIfZUHXhzpfBTs1G6T6tsaKxLKbBCCmFVfbNLDUavDbYlK9LcgOLDw3KGs7S3
         wm2wh5bErKqLnwUFNL6fS5uN9xQAWwZpWzgQoRe4pwJHGyYuKaQt+yygbiUWOaPEYZjL
         3Pgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=scQQOeGEKS1UtnSb4hDa2pMn49T7lX7tre18iE1yAHU=;
        b=C8SmWh+6uKqhsdY9wcTHH1Q+8J6e+I/9iDDCevvC01JVMNcg65rGOADum2u3y5rAzE
         Qi0G8IKSiCJjVGgNeqSynxoUWX+IN//foBKNge5CAOLiOZ8BA3jV+TuQT4jbwlQth5rV
         Es83+JviYMHc6wmecRicKeJQfHYJ2JmPR+e4yga1zL7CBf+rSaksFFfZEi/tNLFtFWte
         dYdvAf7h4lxul/ScALTwVh65518WpeY5jDm57TBNkha5gumJpGLbJKiZ7m/C3rb6WjqM
         YAzwTUTkYGufW6ZEW4Pq3imslVDpk5VVMn8s8nKFH+kMiRzdkzw4piYnmoYYCjaPWzvY
         8cog==
X-Gm-Message-State: AOAM532wtBBhOsREiskDMFqhbov5p+WEcY0kEbuQ/4Pt010ds4zfat1B
        PNC9Tc1WvAtEG5zEssS9Ltg=
X-Google-Smtp-Source: ABdhPJwXeQ/bXUwb8aHBaOdNFbuQO4MW/NT2Fa7afUSNlrVEzUO80EGBGp2QuHnt22Zclxq0J+BZVg==
X-Received: by 2002:a05:6638:1607:: with SMTP id x7mr1605707jas.226.1644536029481;
        Thu, 10 Feb 2022 15:33:49 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id d80sm8376224iof.15.2022.02.10.15.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:33:49 -0800 (PST)
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
Cc:     Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH 19/49] RDMA/hfi: replace cpumask_weight with cpumask_empty where appropriate
Date:   Thu, 10 Feb 2022 14:49:03 -0800
Message-Id: <20220210224933.379149-20-yury.norov@gmail.com>
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

drivers/infiniband/hw/hfi1/affinity.c code calls cpumask_weight() to check
if any bit of a given cpumask is set. We can do it more efficiently with
cpumask_empty() because cpumask_empty() stops traversing the cpumask as
soon as it finds first set bit, while cpumask_weight() counts all bits
unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/hfi1/affinity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
index 706b3b659713..877f8e84a672 100644
--- a/drivers/infiniband/hw/hfi1/affinity.c
+++ b/drivers/infiniband/hw/hfi1/affinity.c
@@ -666,7 +666,7 @@ int hfi1_dev_affinity_init(struct hfi1_devdata *dd)
 			 * engines, use the same CPU cores as general/control
 			 * context.
 			 */
-			if (cpumask_weight(&entry->def_intr.mask) == 0)
+			if (cpumask_empty(&entry->def_intr.mask))
 				cpumask_copy(&entry->def_intr.mask,
 					     &entry->general_intr_mask);
 		}
@@ -686,7 +686,7 @@ int hfi1_dev_affinity_init(struct hfi1_devdata *dd)
 		 * vectors, use the same CPU core as the general/control
 		 * context.
 		 */
-		if (cpumask_weight(&entry->comp_vect_mask) == 0)
+		if (cpumask_empty(&entry->comp_vect_mask))
 			cpumask_copy(&entry->comp_vect_mask,
 				     &entry->general_intr_mask);
 	}
-- 
2.32.0

