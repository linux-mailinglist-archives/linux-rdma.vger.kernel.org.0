Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 323622990C
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 15:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403809AbfEXNfj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 09:35:39 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44208 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403788AbfEXNfj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 May 2019 09:35:39 -0400
Received: by mail-ua1-f66.google.com with SMTP id i48so2842511uae.11
        for <linux-rdma@vger.kernel.org>; Fri, 24 May 2019 06:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IcqaDeuGJCGa5ZggdGNAYSqFQEnHs8MfUQiHhXABBMk=;
        b=kT6wAqKtAnkGgx9v0S5iMBX5PaiLPotndmiXT1nSNY9JkqPTYWp7A/iyFvybPJh8lp
         6fvGORU6bU9+iKBWjnR/LQcEwu5lBvNu68V94RAb+y6RZW0AwsiOBgIQheR6rtQ4Zd2g
         gR7y0LwWGp1cKWn2n1rsa1Na1N0NqaV89eAZsDyNbrQZb0CxTA4vDx/LWbDVG+DIgvbk
         8E8kuzBfWLz9C7iv2GILGg8qdGMBNgctKYWpscbJ2irgE9XMPm0RJmzA/3hJZ2JRF3vs
         D5OWvsg6hDAq43E7IKvTVtxBBLIx5E4CyvDBEHD4hHqJooOC7TmKHVlHhgNUsGi+XxMP
         3Pkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IcqaDeuGJCGa5ZggdGNAYSqFQEnHs8MfUQiHhXABBMk=;
        b=O8p/yq2ZTRB7hU89YVN6HCvO2Zgxe/8oe6YkcNv5Wu2beOYxYG+kf8tk9ZJd7zocRK
         e82tfGidjCVk2gJkM85XvI6PoJ2mynOBgvJr/PpU8cOuakcMSNhN0tsUi07NxOWpruHy
         Bwyt6MZUFtmBay3JX0NUcvx88HtuK4FJ+McEX3C/x1qwgY6wX7X18YHHPWloncV/SIc7
         9iBIdF4G/J36XTkIwtuCOTqU2aeGmwoaqoE+o5wZGjT6XvDObCq/7Oo02n5h6BkCJOil
         M3nt3U4/jFErvOTxjRKEvhVgRVRou2p4xm9f1XMzxcx84Loki6gpoNyMk65LAcOe9XkQ
         daDg==
X-Gm-Message-State: APjAAAUhXUI2LA62/oqZmYPFsJTWTTdG1qum9mYYMN2UK3Ogn1EoILqz
        0bZB0Fz9klfOnot+7jw/DdtIqIw0WJo=
X-Google-Smtp-Source: APXvYqwS/i6+HbsdCX5+s2T6q31qtlvAXYqPjnfVPNdoqlWYS5H7qKCjFxh3N6+BqekbFs052a88ew==
X-Received: by 2002:ab0:688b:: with SMTP id t11mr15080209uar.70.1558704937753;
        Fri, 24 May 2019 06:35:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id a123sm1060434vka.22.2019.05.24.06.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 06:35:37 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hUAMC-0003DA-Dx; Fri, 24 May 2019 10:35:36 -0300
Date:   Fri, 24 May 2019 10:35:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 00/11] mm/hmm: Various revisions from a locking/code
 review
Message-ID: <20190524133536.GA12259@ziepe.ca>
References: <20190523153436.19102-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523153436.19102-1-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 23, 2019 at 12:34:25PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> This patch series arised out of discussions with Jerome when looking at the
> ODP changes, particularly informed by use after free races we have already
> found and fixed in the ODP code (thanks to syzkaller) working with mmu
> notifiers, and the discussion with Ralph on how to resolve the lifetime model.
> 
> Overall this brings in a simplified locking scheme and easy to explain
> lifetime model:
> 
>  If a hmm_range is valid, then the hmm is valid, if a hmm is valid then the mm
>  is allocated memory.
> 
>  If the mm needs to still be alive (ie to lock the mmap_sem, find a vma, etc)
>  then the mmget must be obtained via mmget_not_zero().
> 
> Locking of mm->hmm is shifted to use the mmap_sem consistently for all
> read/write and unlocked accesses are removed.
> 
> The use unlocked reads on 'hmm->dead' are also eliminated in favour of using
> standard mmget() locking to prevent the mm from being released. Many of the
> debugging checks of !range->hmm and !hmm->mm are dropped in favour of poison -
> which is much clearer as to the lifetime intent.
> 
> The trailing patches are just some random cleanups I noticed when reviewing
> this code.
> 
> I expect Jerome & Ralph will have some design notes so this is just RFC, and
> it still needs a matching edit to nouveau. It is only compile tested.
> 
> Regards,
> Jason
> 
> Jason Gunthorpe (11):
>   mm/hmm: Fix use after free with struct hmm in the mmu notifiers
>   mm/hmm: Use hmm_mirror not mm as an argument for hmm_register_range
>   mm/hmm: Hold a mmgrab from hmm to mm
>   mm/hmm: Simplify hmm_get_or_create and make it reliable
>   mm/hmm: Improve locking around hmm->dead
>   mm/hmm: Remove duplicate condition test before wait_event_timeout
>   mm/hmm: Delete hmm_mirror_mm_is_alive()
>   mm/hmm: Use lockdep instead of comments
>   mm/hmm: Remove racy protection against double-unregistration
>   mm/hmm: Poison hmm_range during unregister
>   mm/hmm: Do not use list*_rcu() for hmm->ranges
> 
>  include/linux/hmm.h |  50 ++----------
>  kernel/fork.c       |   1 -
>  mm/hmm.c            | 184 +++++++++++++++++++-------------------------
>  3 files changed, 88 insertions(+), 147 deletions(-)

Jerome, I was doing some more checking of this and noticed lockdep
doesn't compile test if it is turned off, since you took and revised
the series can you please fold in these hunks to fix compile failures
with lockdep on. Thanks

commit f0653c4d4c1dadeaf58d49f1c949ab1d2fda05d3
diff --git a/mm/hmm.c b/mm/hmm.c
index 836adf613f81c8..2a08b78550b90d 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -56,7 +56,7 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 {
 	struct hmm *hmm;
 
-	lockdep_assert_held_exclusive(mm->mmap_sem);
+	lockdep_assert_held_exclusive(&mm->mmap_sem);
 
 	if (mm->hmm) {
 		if (kref_get_unless_zero(&mm->hmm->kref))
@@ -262,7 +262,7 @@ static const struct mmu_notifier_ops hmm_mmu_notifier_ops = {
  */
 int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
 {
-	lockdep_assert_held_exclusive(mm->mmap_sem);
+	lockdep_assert_held_exclusive(&mm->mmap_sem);
 
 	/* Sanity check */
 	if (!mm || !mirror || !mirror->ops)
@@ -987,7 +987,7 @@ long hmm_range_snapshot(struct hmm_range *range)
 	struct mm_walk mm_walk;
 
 	/* Caller must hold the mmap_sem, and range hold a reference on mm. */
-	lockdep_assert_held(hmm->mm->mmap_sem);
+	lockdep_assert_held(&hmm->mm->mmap_sem);
 	if (WARN_ON(!atomic_read(&hmm->mm->mm_users)))
 		return -EINVAL;
 
@@ -1086,7 +1086,7 @@ long hmm_range_fault(struct hmm_range *range, bool block)
 	int ret;
 
 	/* Caller must hold the mmap_sem, and range hold a reference on mm. */
-	lockdep_assert_held(hmm->mm->mmap_sem);
+	lockdep_assert_held(&hmm->mm->mmap_sem);
 	if (WARN_ON(!atomic_read(&hmm->mm->mm_users)))
 		return -EINVAL;
 

