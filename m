Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CA4497488
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jan 2022 19:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239773AbiAWSlP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jan 2022 13:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239801AbiAWSkw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jan 2022 13:40:52 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E54C061756;
        Sun, 23 Jan 2022 10:40:45 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id d15-20020a17090a110f00b001b4e7d27474so14268037pja.2;
        Sun, 23 Jan 2022 10:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=geJcDF7eG8EOHs97ZbucxlWSNBb9ica7os3IO5WyQsk=;
        b=HZ5wFq5vKklf9YkTPPXH/lZMPEpCXNyoVqeQMYs5eSx898mpi8WLmcz/f0KpKVFBeW
         csCQYfbmltl4T3oVDVfzDu4v5mpUC6d+uWCx1BKMIrwjNVXkvy/oBKMa98kAw6vNd+BZ
         RVKXg0LetIuDEYO2OW3Zzx9ar3qZzetE1p3RxXMGVGXPU+PsDMqz8DRwZ2tm9YMbZWAw
         TH//sNAOe6+1oHsRcVNo4paHLUKJNoRfSdoRzqdFGgQdIrkpmbhkoc0NqiMsDUwRRfIN
         9iVDq8wrBejuUjKzUcXbb6RDNssoqskWFcbdbeYQfLdz3jJqRtd/vRp/SMnfQdvMBYi2
         BWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=geJcDF7eG8EOHs97ZbucxlWSNBb9ica7os3IO5WyQsk=;
        b=IcQ5DbsQJojZ9y2Bi/8zowQtHIoYnv9ZvokUd4Cn0jvHFJrqAkkwMAycXH1mZP9+b8
         NzclidjnMtKCepNLrTHHkXIEP0Df8iJJ+qoB0/LVusltKDmyn4Cj1KdXxSSmdeG1o2nF
         RoXxzvOpDKapslS/X+8YB+E1O5MuvSvXcbbumJOlfP3N3TkYhrlqdS9w57xaPYypKBer
         2Nl2u+cUODwPM+uPCQhpN2CKeFVzqs24Wnsu/NpuJFsJgmio43U7/Gd986FYSJZvZYKl
         KIZqWEr2VHxljqBwSK4BIy9pp9B3jo/2ueIEmiskyw0jB4Lvzf3HQn5WlpVmttf2SlMP
         FLIA==
X-Gm-Message-State: AOAM533FhfnZQwrzitdu0JQ8tIfYZ72egRBoiqr3KO0zQll278SIQGPy
        YuZNrti5rkNG8qiEpzIT06Q=
X-Google-Smtp-Source: ABdhPJymK27TH5kGJL/EoV+91cYg2zsWinqPXBG6oJtzEAWeUpTPZAAzN7lPEF4QI4wEaGLrxdCnkQ==
X-Received: by 2002:a17:90b:4ad1:: with SMTP id mh17mr9873766pjb.160.1642963244937;
        Sun, 23 Jan 2022 10:40:44 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id rj9sm11344424pjb.49.2022.01.23.10.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:40:44 -0800 (PST)
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
Subject: [PATCH 18/54] drivers/infiniband: replace cpumask_weight with cpumask_empty where appropriate
Date:   Sun, 23 Jan 2022 10:38:49 -0800
Message-Id: <20220123183925.1052919-19-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

drivers/infiniband/hw/hfi1/affinity.c code calls cpumask_weight() to check
if any bit of a given cpumask is set. We can do it more efficiently with
cpumask_empty() because cpumask_empty() stops traversing the cpumask as
soon as it finds first set bit, while cpumask_weight() counts all bits
unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/infiniband/hw/hfi1/affinity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
index 98c813ba4304..38eee675369a 100644
--- a/drivers/infiniband/hw/hfi1/affinity.c
+++ b/drivers/infiniband/hw/hfi1/affinity.c
@@ -667,7 +667,7 @@ int hfi1_dev_affinity_init(struct hfi1_devdata *dd)
 			 * engines, use the same CPU cores as general/control
 			 * context.
 			 */
-			if (cpumask_weight(&entry->def_intr.mask) == 0)
+			if (cpumask_empty(&entry->def_intr.mask))
 				cpumask_copy(&entry->def_intr.mask,
 					     &entry->general_intr_mask);
 		}
@@ -687,7 +687,7 @@ int hfi1_dev_affinity_init(struct hfi1_devdata *dd)
 		 * vectors, use the same CPU core as the general/control
 		 * context.
 		 */
-		if (cpumask_weight(&entry->comp_vect_mask) == 0)
+		if (cpumask_empty(&entry->comp_vect_mask))
 			cpumask_copy(&entry->comp_vect_mask,
 				     &entry->general_intr_mask);
 	}
-- 
2.30.2

