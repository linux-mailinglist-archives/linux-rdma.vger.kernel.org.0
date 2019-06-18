Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC8949655
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 02:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfFRAhB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jun 2019 20:37:01 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45274 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRAhB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jun 2019 20:37:01 -0400
Received: by mail-qt1-f193.google.com with SMTP id j19so13149246qtr.12
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jun 2019 17:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DUhdu87n/RcFK2o2RKT7Xn6jZQqeitWARb0DhK6/xFo=;
        b=Br9RdI5mPQREEmkYKTbqml22ch68dceGzZJ3NpqNGWnyOqMXHH3Vp3I8RbvWN+0dGG
         +g1j7rLYevDrJD9u1C3ny612FtpBO3tbIePe350M5ElOwdk4pjJA8/R330jcc3+vtYpn
         17S07MU/B/lrrFpSdr2NFsNSFXPEIP46dFGaUq3K6P/Gztn1b6znTuHTRL9kMCjl+OsE
         E/SXSnxqH8z94kWuui++s5M1RdL+/flIEAt9fmVVYofcAVK2jbveGcEm8QPiuUNVzG1y
         spSh4cwLvofbfJDRrinF0oVrVOFf22UKWIYy7Uyrxgd7cZ/rnvEbnjdjRkZxGdQjLAWX
         AxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DUhdu87n/RcFK2o2RKT7Xn6jZQqeitWARb0DhK6/xFo=;
        b=PizPHODVKxQBIf4Omk8HG9uilsKtS/S4h6ihRkrxo6RlGAnIfDVmfX2A+DjaxVtr6O
         J/f+I/KjAT451Y3cfOpS85eh1/uZHSs18zPs3CCvCDXj1I6WIDsuRALIqViOQP18IzcZ
         erAzIgO+Xgno3orbiQquAzV44azQeMkXuRAJ1MOvFs4ZP0aORk0hwDsDGG3CjvrfiLXy
         553HvvS4CtUGchyLafHX0Vm+bVWZGpiT8+d09lDIbuQ5fNM6ShmolCYaK3ecqc9aqas5
         ga8e8r9FeBg4wjYkzqtHDK89XjZRbuB3sEKc9D/3cm3P2G2PHuZ+9YIwHNB5vi+7IaOZ
         NGUg==
X-Gm-Message-State: APjAAAXii1MB5Ntaqe9beuTPs+U6ZgU3YUNPxytxgsl88nYGpwvPmYU2
        oqSZ9d6kzCSIvF3M1TjEnaRdqzoGM+lu7Q==
X-Google-Smtp-Source: APXvYqwNKmMPGfd11Aoys/ex+FCBBx8y28tJjyO+G3ezjcr0a4wUE2AKBOFyQh6LE7vtVp6hp3BWOw==
X-Received: by 2002:a0c:89a5:: with SMTP id 34mr4976222qvr.110.1560818219783;
        Mon, 17 Jun 2019 17:36:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 41sm9704086qtp.32.2019.06.17.17.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 17:36:59 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hd27O-0000jS-MT; Mon, 17 Jun 2019 21:36:58 -0300
Date:   Mon, 17 Jun 2019 21:36:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 04/12] mm/hmm: Simplify hmm_get_or_create and make
 it reliable
Message-ID: <20190618003658.GC30762@ziepe.ca>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-5-jgg@ziepe.ca>
 <20190615141211.GD17724@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615141211.GD17724@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 15, 2019 at 07:12:11AM -0700, Christoph Hellwig wrote:
> > +	spin_lock(&mm->page_table_lock);
> > +	if (mm->hmm) {
> > +		if (kref_get_unless_zero(&mm->hmm->kref)) {
> > +			spin_unlock(&mm->page_table_lock);
> > +			return mm->hmm;
> > +		}
> > +	}
> > +	spin_unlock(&mm->page_table_lock);
> 
> This could become:
> 
> 	spin_lock(&mm->page_table_lock);
> 	hmm = mm->hmm
> 	if (hmm && kref_get_unless_zero(&hmm->kref))
> 		goto out_unlock;
> 	spin_unlock(&mm->page_table_lock);
> 
> as the last two lines of the function already drop the page_table_lock
> and then return hmm.  Or drop the "hmm = mm->hmm" asignment above and
> return mm->hmm as that should be always identical to hmm at the end
> to save another line.

Yeah, I can fuss it some more.

> > +	/*
> > +	 * The mm->hmm pointer is kept valid while notifier ops can be running
> > +	 * so they don't have to deal with a NULL mm->hmm value
> > +	 */
> 
> The comment confuses me.  How does the page_table_lock relate to
> possibly running notifiers, as I can't find that we take
> page_table_lock?  Or is it just about the fact that we only clear
> mm->hmm in the free callback, and not in hmm_free?

It was late when I wrote this fixup, the comment is faulty, and there
is no reason to delay this until the SRCU cleanup at this point in the
series.

The ops all get their struct hmm from container_of, the only thing
that refers to mm->hmm is hmm_get_or_create().

I'll revise it tomorrow, the comment will go away and the =NULL will
go to the release callback

Jason
