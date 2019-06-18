Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4669D4A4D6
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 17:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbfFRPLC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 11:11:02 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44359 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfFRPLC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jun 2019 11:11:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id p144so8753160qke.11
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2019 08:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pqCED5mYNInU5PAv2mesXGcqWFvLrmpHYJb9ulnVVgI=;
        b=nCh2sLXrPktHy5XUJpjTlsCcshtqkRGZMfOua9pN5auRQe260AAMJlewmn5vXSTf2e
         Yc6POt9RnXEBOGGODqrP1rFPH7Cwm6+JhjPT5/rllkwaH/LtoXrRvluoAV6oe4NarBzt
         1k5+QybFYGGCga2ITf4dP/dJkwooOrYiCGgJL9cFPsdHIBZq5pdRYq1+Pz/XBNpoCt7E
         gS6VMSVDRqNygqmTx+TNLNkcy7/motNSfs4g6axRbb+X8ahuJ+lBfs2r0vK6Gb5qHpps
         EtDtwPMeiq+vcBcuwP536GU8VcFj8CLrVVuBc2x1aB7dl4PGOS5QoIPYqgsDjQ7l2cLm
         LZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pqCED5mYNInU5PAv2mesXGcqWFvLrmpHYJb9ulnVVgI=;
        b=Z/XA/BizawAq4+NG5fJowvRJAyORHDeMqhffhhlHoovaXS7Q1AQCcxb2LUBQ9U1hGZ
         28/JGk5RQhWaTzzly9A6sxCFhMBHE/Sl7EcRqmZs66KnRi0sOZEDkk5p7up69mrvdJpN
         OiKSys/nvdr9Q0WTHKbSQAeb+Lcwla2tVMN2NHgl2Vts5zYAPkYIK1SAynvxGo7famgc
         zC4dIx9rf2d2mzKzJoXjSFctyBHuKOFELd6r5mmnfM4Cgw5XB7Mc2NT2mHlDBwWc4Tik
         bWTMo6QNh5CVPM7a3NBxMrqdOqejWGumi7hwt6uhnYiRjtY/OpiafGIcCG6wuAmJ1EHu
         Z3WA==
X-Gm-Message-State: APjAAAUhuEJ3mwnpMoCZxDqinbZOILNiohtWaJ2R0FyTycq8gd/R3GVE
        5HfxkNMNrQr6O0srn4TSG0w00A==
X-Google-Smtp-Source: APXvYqzNqG1TNcSVdITe8C3fCMJFkUWykHx0vaCyd8hF7H/75BSskda+UeSXCPEKbmE+kRdajwWEsQ==
X-Received: by 2002:a37:7847:: with SMTP id t68mr91753295qkc.128.1560870661341;
        Tue, 18 Jun 2019 08:11:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 15sm8515948qtf.2.2019.06.18.08.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 08:11:00 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hdFlE-0008OK-D5; Tue, 18 Jun 2019 12:11:00 -0300
Date:   Tue, 18 Jun 2019 12:11:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 06/12] mm/hmm: Hold on to the mmget for the
 lifetime of the range
Message-ID: <20190618151100.GI6961@ziepe.ca>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-7-jgg@ziepe.ca>
 <20190615141435.GF17724@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615141435.GF17724@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 15, 2019 at 07:14:35AM -0700, Christoph Hellwig wrote:
> >  	mutex_lock(&hmm->lock);
> > -	list_for_each_entry(range, &hmm->ranges, list)
> > -		range->valid = false;
> > -	wake_up_all(&hmm->wq);
> > +	/*
> > +	 * Since hmm_range_register() holds the mmget() lock hmm_release() is
> > +	 * prevented as long as a range exists.
> > +	 */
> > +	WARN_ON(!list_empty(&hmm->ranges));
> >  	mutex_unlock(&hmm->lock);
> 
> This can just use list_empty_careful and avoid the lock entirely.

Sure, it is just a debugging helper and the mmput should serialize
thinigs enough to be reliable. I had to move the RCU patch ahead of
this. Thanks

diff --git a/mm/hmm.c b/mm/hmm.c
index a9ace28984ea42..1eddda45cefae7 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -124,13 +124,11 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	if (!kref_get_unless_zero(&hmm->kref))
 		return;
 
-	mutex_lock(&hmm->lock);
 	/*
 	 * Since hmm_range_register() holds the mmget() lock hmm_release() is
 	 * prevented as long as a range exists.
 	 */
-	WARN_ON(!list_empty(&hmm->ranges));
-	mutex_unlock(&hmm->lock);
+	WARN_ON(!list_empty_careful(&hmm->ranges));
 
 	down_write(&hmm->mirrors_sem);
 	mirror = list_first_entry_or_null(&hmm->mirrors, struct hmm_mirror,
@@ -938,7 +936,7 @@ void hmm_range_unregister(struct hmm_range *range)
 		return;
 
 	mutex_lock(&hmm->lock);
-	list_del(&range->list);
+	list_del_init(&range->list);
 	mutex_unlock(&hmm->lock);
 
 	/* Drop reference taken by hmm_range_register() */
