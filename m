Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF626EA1DF
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Apr 2023 04:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbjDUCu7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Apr 2023 22:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjDUCu6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Apr 2023 22:50:58 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148246EB5;
        Thu, 20 Apr 2023 19:50:57 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b62d2f729so1525824b3a.1;
        Thu, 20 Apr 2023 19:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682045457; x=1684637457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrkvCxlxcddagK2yaLOOMG4Y/CE9pr0ilngxK0X5Vcs=;
        b=c1D0l4VFEN5et1lJc400wBpLI6YQQVyklfQAmpDQO+ssteaWRX5ExAfvZQgLZSRrJa
         Au338bpjVqaaLNIxrfSdVfpOOfA0sNglhpQTH+d+b1QilXqPfQJOeRD53PhFSZMsVrNb
         NnO/3jFONXgbh178zX3WuTlIOLys/IdfcGImmOaLEF42bs7ol79o+fbLnZt+N8EJlGNz
         mZHg9yN6oOr9mT7ymCCx46vyHyyx99zQ6K43mun+15EhQXa9/hHtmPEjPEZJcUJdC1mU
         5gkeblIz6Sz+4r8myGRTABi+4XfyUq7rtsoZdDeXD9EPwo6oNc3aQ9YhK1IdGHbWzEKv
         Jh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682045457; x=1684637457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BrkvCxlxcddagK2yaLOOMG4Y/CE9pr0ilngxK0X5Vcs=;
        b=FrsoDnvUUdUT7LpypTruQXBtS1M2Y6Ddq4nqRiXWfengRvxnE+hWdGYnlSTNANxMrb
         MJvJRhRYCkRBTrVoaghaVfcJb8IdMnqbiQkIXFsBhPeI6Rq/9ETXbmZSqcRMZOLwn/Ii
         bygt87HyqNkbsA3ONG2tzc/TMwZMvgrtZuqnJ7mqLjmj2E/oo70uW7MV2a7vDYI5wPgV
         ++DgfSehZ4ps6hC2eSRVZJ0Kw0wpmzoip4HbsN09HCKfQUnpolyQ/5wNMaXyJTjuliU3
         viWXZlaHI+8ZJ/Mz5DNqQcHrD1PyVW5ibSWHXlhfip40SHCbszp4TD3rHwTvUWMJbbmx
         Kzmw==
X-Gm-Message-State: AAQBX9cE1awT4HMuQQxe6jKpzIqhpErZ6R2ZqE60ofDLOEc2aLmGz3iH
        AwwXM4PKh7RYnk2fYuw3/Rc=
X-Google-Smtp-Source: AKy350Y/IC7tKdrpjxv0oeokymwNJ6LoAT5AcYMwUP0QYOJykFGNZqJXJIdmPBeM/WZ1R0xfXYFKvg==
X-Received: by 2002:a17:902:da8f:b0:19d:138b:7c4a with SMTP id j15-20020a170902da8f00b0019d138b7c4amr4624417plx.3.1682045456373;
        Thu, 20 Apr 2023 19:50:56 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id jo13-20020a170903054d00b0019acd3151d0sm1250013plb.114.2023.04.20.19.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 19:50:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH 03/22] IB/hfi1: Use alloc_ordered_workqueue() to create ordered workqueues
Date:   Thu, 20 Apr 2023 16:50:27 -1000
Message-Id: <20230421025046.4008499-4-tj@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421025046.4008499-1-tj@kernel.org>
References: <20230421025046.4008499-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

BACKGROUND
==========

When multiple work items are queued to a workqueue, their execution order
doesn't match the queueing order. They may get executed in any order and
simultaneously. When fully serialized execution - one by one in the queueing
order - is needed, an ordered workqueue should be used which can be created
with alloc_ordered_workqueue().

However, alloc_ordered_workqueue() was a later addition. Before it, an
ordered workqueue could be obtained by creating an UNBOUND workqueue with
@max_active==1. This originally was an implementation side-effect which was
broken by 4c16bd327c74 ("workqueue: restore WQ_UNBOUND/max_active==1 to be
ordered"). Because there were users that depended on the ordered execution,
5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
made workqueue allocation path to implicitly promote UNBOUND workqueues w/
@max_active==1 to ordered workqueues.

While this has worked okay, overloading the UNBOUND allocation interface
this way creates other issues. It's difficult to tell whether a given
workqueue actually needs to be ordered and users that legitimately want a
min concurrency level wq unexpectedly gets an ordered one instead. With
planned UNBOUND workqueue updates to improve execution locality and more
prevalence of chiplet designs which can benefit from such improvements, this
isn't a state we wanna be in forever.

This patch series audits all callsites that create an UNBOUND workqueue w/
@max_active==1 and converts them to alloc_ordered_workqueue() as necessary.

WHAT TO LOOK FOR
================

The conversions are from

  alloc_workqueue(WQ_UNBOUND | flags, 1, args..)

to

  alloc_ordered_workqueue(flags, args...)

which don't cause any functional changes. If you know that fully ordered
execution is not ncessary, please let me know. I'll drop the conversion and
instead add a comment noting the fact to reduce confusion while conversion
is in progress.

If you aren't fully sure, it's completely fine to let the conversion
through. The behavior will stay exactly the same and we can always
reconsider later.

As there are follow-up workqueue core changes, I'd really appreciate if the
patch can be routed through the workqueue tree w/ your acks. Thanks.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/hw/hfi1/init.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 62b6c5020039..e03d867cda13 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -755,14 +755,13 @@ static int create_workqueues(struct hfi1_devdata *dd)
 		}
 		if (!ppd->link_wq) {
 			/*
-			 * Make the link workqueue single-threaded to enforce
+			 * Make the link workqueue ordered to enforce
 			 * serialization.
 			 */
 			ppd->link_wq =
-				alloc_workqueue(
+				alloc_ordered_workqueue(
 				    "hfi_link_%d_%d",
-				    WQ_SYSFS | WQ_MEM_RECLAIM | WQ_UNBOUND,
-				    1, /* max_active */
+				    WQ_SYSFS | WQ_MEM_RECLAIM,
 				    dd->unit, pidx);
 			if (!ppd->link_wq)
 				goto wq_error;
-- 
2.40.0

