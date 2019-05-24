Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEBD229925
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 15:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391550AbfEXNki (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 09:40:38 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37493 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391361AbfEXNki (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 May 2019 09:40:38 -0400
Received: by mail-vs1-f66.google.com with SMTP id o5so2281252vsq.4
        for <linux-rdma@vger.kernel.org>; Fri, 24 May 2019 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jk1Lvx1FvIw772wUrAuBFbuzjdT4riWG2uGTCncDffw=;
        b=TJ1v3fknWXI7eBDTfpR4QuLVeyX1otnSWo1H+q2e4OMUI4FDYhMl+gkN9H1i+7mOhO
         7/aDgJCW3ND4tnYxrEw1oB8b8v0vhLGSWJwGFDhhFwdjtmXO1CjA9vX5aIeYCApUY6Oz
         oNA0Bacu6lV9kocnIprEn4BtBq9N0vh25RDNUa7RUM7LzAI70qLEi+L74kbDWi/ebHHq
         EZOI/Y/fhswKPJt/JjMudE0M0zKse16oB9WUlDb4A6Dy36PRO74rbqLaTf0yGGxwJlz6
         DBqTn1hSDKCT3Hdy3NmSOlACj5Q4uQPtcDwQrpx9MluvudT6JLzTdpifJWxlcS0JwkCT
         ZkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jk1Lvx1FvIw772wUrAuBFbuzjdT4riWG2uGTCncDffw=;
        b=Z0qJQfMt10zu+UyJ2BAKz5GvFsOAh3aWclCPeyf8798baGQRlRbNwCua/sXJRIpYp6
         6Of2tH10WkDwM1MGZF+UeI5RRMINezMzXBv6V/4bBVar58l9GMdHQS/CLihBjh6THXL4
         zjQpRY2QbBiIbObTvJYfXtY4i71+HbVumrf/nJeE7KccJ4AQTZDov9ALj680I7un5V6k
         P9HmYmaykMUjH9eU3EUivLAHRwBIMhm33oZJwQl7iBPHpVyeeNCgMMas9Ks89FX0fPUh
         IAAQD+tjw3xQr1zdCwTujL3p3Sz/djmE0PFsyCW1ZccrVDMNCcNWfwMC14jlogOLdsJ+
         y9Gw==
X-Gm-Message-State: APjAAAV2wuAGvd6KSHU66fBKR+n/iESTaKRHRBHp49VTdJRq+kerRzzy
        HHxDBRZVC6NF4Px9hVA1nFOsjsNQtVc=
X-Google-Smtp-Source: APXvYqw8mwBk3DO7N2wH6PK1f+AD1sgPGSjHEWIChiWeOIKAMl3omYHQb8VqEw5144BspC8y2H55mg==
X-Received: by 2002:a67:e9cf:: with SMTP id q15mr19361500vso.194.1558705236966;
        Fri, 24 May 2019 06:40:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id 102sm864606uar.11.2019.05.24.06.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 06:40:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hUAR1-0003QD-Jx; Fri, 24 May 2019 10:40:35 -0300
Date:   Fri, 24 May 2019 10:40:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 05/11] mm/hmm: Improve locking around hmm->dead
Message-ID: <20190524134035.GA12653@ziepe.ca>
References: <20190523153436.19102-1-jgg@ziepe.ca>
 <20190523153436.19102-6-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523153436.19102-6-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 23, 2019 at 12:34:30PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> This value is being read without any locking, so it is just an unreliable
> hint, however in many cases we need to have certainty that code is not
> racing with mmput()/hmm_release().
> 
> For the two functions doing find_vma(), document that the caller is
> expected to hold mmap_sem and thus also have a mmget().
> 
> For hmm_range_register acquire a mmget internally as it must not race with
> hmm_release() when it sets valid.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>  mm/hmm.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index ec54be54d81135..d97ec293336ea5 100644
> +++ b/mm/hmm.c
> @@ -909,8 +909,10 @@ int hmm_range_register(struct hmm_range *range,
>  	range->start = start;
>  	range->end = end;
>  
> -	/* Check if hmm_mm_destroy() was call. */
> -	if (mirror->hmm->mm == NULL || mirror->hmm->dead)
> +	/*
> +	 * We cannot set range->value to true if hmm_release has already run.
> +	 */
> +	if (!mmget_not_zero(mirror->hmm->mm))
>  		return -EFAULT;
>  
>  	range->hmm = mirror->hmm;
> @@ -928,6 +930,7 @@ int hmm_range_register(struct hmm_range *range,
>  	if (!range->hmm->notifiers)
>  		range->valid = true;
>  	mutex_unlock(&range->hmm->lock);
> +	mmput(mirror->hmm->mm);

Hi Jerome, when you revised this patch to move the mmput to
hmm_range_unregister() it means hmm_release() cannot run while a range
exists, and thus we can have this futher simplification rolled into
this patch. Can you update your git? Thanks:

diff --git a/mm/hmm.c b/mm/hmm.c
index 2a08b78550b90d..ddd05f2ebe739a 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -128,17 +128,17 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
 	struct hmm_mirror *mirror;
-	struct hmm_range *range;
 
 	/* hmm is in progress to free */
 	if (!kref_get_unless_zero(&hmm->kref))
 		return;
 
-	/* Wake-up everyone waiting on any range. */
 	mutex_lock(&hmm->lock);
-	list_for_each_entry(range, &hmm->ranges, list)
-		range->valid = false;
-	wake_up_all(&hmm->wq);
+	/*
+	 * Since hmm_range_register() holds the mmget() lock hmm_release() is
+	 * prevented as long as a range exists.
+	 */
+	WARN_ON(!list_empty(&hmm->ranges));
 	mutex_unlock(&hmm->lock);
 
 	down_write(&hmm->mirrors_sem);
@@ -908,9 +908,7 @@ int hmm_range_register(struct hmm_range *range,
 	range->hmm = mm->hmm;
 	kref_get(&range->hmm->kref);
 
-	/*
-	 * We cannot set range->value to true if hmm_release has already run.
-	 */
+	/* Prevent hmm_release() from running while the range is valid */
 	if (!mmget_not_zero(mm))
 		return -EFAULT;
 
