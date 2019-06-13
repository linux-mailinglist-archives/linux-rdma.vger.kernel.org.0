Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2CE0449ED
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 19:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfFMRuL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 13:50:11 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45433 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfFMRuL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 13:50:11 -0400
Received: by mail-qt1-f196.google.com with SMTP id j19so23540135qtr.12
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 10:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CW8Dmkt0odT79Xf4+B/xbpKgEC6daDBVeyuQmTJJES8=;
        b=P0/fYNP9ZcO3+OGBpONisUzkN8/fc+iUh8W32JiaGiFfNUt4qj3hrdWOLa/2kOC2Ga
         uu/8ijXw30ur7PSRQYFk7Oe6OadCse1RRqrxDoqyNJlNajrnSqTh1ShrZ48X/c3/G4b1
         9g+0Y3ZmUyd781bC8WLIAtVBzmwUTu3co6WnZDr4CXQvlI8tMzdoMpQOhxvEQuWv/dIr
         FMHaFB6W/Smdy5NjElS5AmWr8tSHAPDVdpcJzzt7mZ8Ty3sqcvZGxCvSXRIoQ81pMrC3
         kMb0362dUdKeGvJFK+wK54XHlEHfz16TwTLECzqd5j0SbpDhpcQWqdCP3c8gebNRqYEV
         sAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CW8Dmkt0odT79Xf4+B/xbpKgEC6daDBVeyuQmTJJES8=;
        b=OYtavX4UUoHF2hgdXFpJQJVQeWLD5KM0r3arTkMAe5Achto1R9VekL+Rsf+cWg+iei
         RhROOBwdxnJbNj/2ZcLhG+1X1k3GU2Q8E5GhM4GQ2Qhx+jpmYh5vuJN2tWYUGyaPXNC2
         eY7HHQcO4/fIGbvFPzuolEFre3aXl5skcTB1sTzzfCcktzfoFJZtcVDmLaHpQ/wlg+kC
         8pbGgkyKN/hT2zo4MmJD18qxfGSg3kesFeJ3f54mrKJkNH0abPCFBfrEr5JbEHjlO6wC
         4UsSwvLfR4d82fbbTtxGsgKrXgk7/b7Sw6gUzsvt8Nwldf1/D+PGXs8PfWjIAoDzwqhb
         lq6Q==
X-Gm-Message-State: APjAAAWn56xC9VyTr1SLrUx4B8IASEz66zpM5ODJI3EBJDi4wuKGdulC
        BRM42HDpDdu9wBckZmQxaSDROw==
X-Google-Smtp-Source: APXvYqyiojsO9AL2I7FFH8QZQ3t97ZM/cVMsGf4rVJyZYQVaUkpxSashUx10y6Oje86asaNHv0rxLg==
X-Received: by 2002:aed:254c:: with SMTP id w12mr79027848qtc.127.1560448210185;
        Thu, 13 Jun 2019 10:50:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id c4sm137165qkd.24.2019.06.13.10.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 10:50:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbTrV-0006NJ-8F; Thu, 13 Jun 2019 14:50:09 -0300
Date:   Thu, 13 Jun 2019 14:50:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Yang, Philip" <Philip.Yang@amd.com>
Cc:     "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 hmm 00/11] Various revisions from a locking/code review
Message-ID: <20190613175009.GG22901@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190611194858.GA27792@ziepe.ca>
 <5d3b0ae2-3662-cab2-5e6c-82912f32356a@amd.com>
 <69bb7fe9-98e7-8a49-3e0b-f639010b8991@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69bb7fe9-98e7-8a49-3e0b-f639010b8991@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 12, 2019 at 09:49:12PM +0000, Yang, Philip wrote:
> Rebase to https://github.com/jgunthorpe/linux.git hmm branch, need some 
> changes because of interface hmm_range_register change. Then run a quick 
> amdgpu_test. Test is finished, result is ok.

Great! Thanks

I'll add your Tested-by to the series

>  But there is below kernel BUG message, seems hmm_free_rcu calls
> down_write.....
> 
> [ 1171.919921] BUG: sleeping function called from invalid context at 
> /home/yangp/git/compute_staging/kernel/kernel/locking/rwsem.c:65
> [ 1171.919933] in_atomic(): 1, irqs_disabled(): 0, pid: 53, name: 
> kworker/1:1
> [ 1171.919938] 2 locks held by kworker/1:1/53:
> [ 1171.919940]  #0: 000000001c7c19d4 ((wq_completion)rcu_gp){+.+.}, at: 
> process_one_work+0x20e/0x630
> [ 1171.919951]  #1: 00000000923f2cfa 
> ((work_completion)(&sdp->work)){+.+.}, at: process_one_work+0x20e/0x630
> [ 1171.919959] CPU: 1 PID: 53 Comm: kworker/1:1 Tainted: G        W 
>     5.2.0-rc1-kfd-yangp #196
> [ 1171.919961] Hardware name: ASUS All Series/Z97-PRO(Wi-Fi ac)/USB 3.1, 
> BIOS 9001 03/07/2016
> [ 1171.919965] Workqueue: rcu_gp srcu_invoke_callbacks
> [ 1171.919968] Call Trace:
> [ 1171.919974]  dump_stack+0x67/0x9b
> [ 1171.919980]  ___might_sleep+0x149/0x230
> [ 1171.919985]  down_write+0x1c/0x70
> [ 1171.919989]  hmm_free_rcu+0x24/0x80
> [ 1171.919993]  srcu_invoke_callbacks+0xc9/0x150
> [ 1171.920000]  process_one_work+0x28e/0x630
> [ 1171.920008]  worker_thread+0x39/0x3f0
> [ 1171.920014]  ? process_one_work+0x630/0x630
> [ 1171.920017]  kthread+0x11c/0x140
> [ 1171.920021]  ? kthread_park+0x90/0x90
> [ 1171.920026]  ret_from_fork+0x24/0x30

Thank you Phillip, it seems the prior tests were not done with
lockdep..

Sigh, I will keep this with the gross pagetable_lock then. I updated
the patches on the git with this modification. I think we have covered
all the bases so I will send another V of the series to the list and
if no more comments then it will move ahead to hmm.git. Thanks to all.

diff --git a/mm/hmm.c b/mm/hmm.c
index 136c812faa2790..4c64d4c32f4825 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -49,16 +49,15 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 
 	lockdep_assert_held_exclusive(&mm->mmap_sem);
 
+	/* Abuse the page_table_lock to also protect mm->hmm. */
+	spin_lock(&mm->page_table_lock);
 	if (mm->hmm) {
-		if (kref_get_unless_zero(&mm->hmm->kref))
+		if (kref_get_unless_zero(&mm->hmm->kref)) {
+			spin_unlock(&mm->page_table_lock);
 			return mm->hmm;
-		/*
-		 * The hmm is being freed by some other CPU and is pending a
-		 * RCU grace period, but this CPU can NULL now it since we
-		 * have the mmap_sem.
-		 */
-		mm->hmm = NULL;
+		}
 	}
+	spin_unlock(&mm->page_table_lock);
 
 	hmm = kmalloc(sizeof(*hmm), GFP_KERNEL);
 	if (!hmm)
@@ -81,7 +80,14 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 	}
 
 	mmgrab(hmm->mm);
+
+	/*
+	 * We hold the exclusive mmap_sem here so we know that mm->hmm is
+	 * still NULL or 0 kref, and is safe to update.
+	 */
+	spin_lock(&mm->page_table_lock);
 	mm->hmm = hmm;
+	spin_unlock(&mm->page_table_lock);
 	return hmm;
 }
 
@@ -89,10 +95,14 @@ static void hmm_free_rcu(struct rcu_head *rcu)
 {
 	struct hmm *hmm = container_of(rcu, struct hmm, rcu);
 
-	down_write(&hmm->mm->mmap_sem);
+	/*
+	 * The mm->hmm pointer is kept valid while notifier ops can be running
+	 * so they don't have to deal with a NULL mm->hmm value
+	 */
+	spin_lock(&hmm->mm->page_table_lock);
 	if (hmm->mm->hmm == hmm)
 		hmm->mm->hmm = NULL;
-	up_write(&hmm->mm->mmap_sem);
+	spin_unlock(&hmm->mm->page_table_lock);
 	mmdrop(hmm->mm);
 
 	kfree(hmm);
