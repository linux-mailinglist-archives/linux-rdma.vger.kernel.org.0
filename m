Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5AB49658
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 02:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfFRAiK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jun 2019 20:38:10 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45292 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfFRAiJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jun 2019 20:38:09 -0400
Received: by mail-qk1-f193.google.com with SMTP id s22so7436894qkj.12
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jun 2019 17:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EFgy84qSqdB63j+sw5RQb8FlQ7olTwYiiqpzSjRkr8U=;
        b=gEMe8OGDFmOz6H46yGNGMqF8pI5BwGDEcf+SCaHqb0Q7uRwuonwPVlWfdaht7QofIf
         YtRgnZv2e9ADohWcFTRVNBYXno1F4xdqwANh3AoWhgQMpkk6q4C73j++QLk+F6iC/Wju
         IPMl2CiAFZSvU7ydMedZlrsuuDZ/6Y0XEeYIDVixBngY8FE0gVLsWnlEJSLgpw6skcr+
         zzYgJ2BJQj3dg2qGcz6M9TsKsHpszq25fWMd1XzmqaGMWCdE4XNQHbUtNhiHChs/I842
         xkYSo0wFMFiReic1CZqd6S3jyFJPcJgNcxDLbu/6GrsVfkHd0kWkCTx4jW2kP6BEEWBL
         gN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EFgy84qSqdB63j+sw5RQb8FlQ7olTwYiiqpzSjRkr8U=;
        b=SOWvIg9eR0nGOR2SHFB2lfZsHOpkTfOQKX/9Z3CVpHZwSI1f8mxuNej6gsQVVimzu5
         QvPGXRAmex11xY5khSp49lOt17++0yR+hBEz7FYZiQttTGvGRet4JLQtD2H5cPzwy5Yv
         6iFEMDqInj36G2uVFxnBaIS9FRI/hJNKhuH+Quz/oIBSkrweOdRAz3KCATpjzQlZq/x5
         p2BTv5K4au90Afv0NIT70D2ORT9vJLTuEn85Ry1JpWevgVczjEgifQVwX808pKMy/Yv0
         vRgGR8H4drROOXRSthX7wGS5Z3rxo4IJbAM+0D09w3+Ff1JATvIy9kPrmXBoeyjtUGZi
         WMVg==
X-Gm-Message-State: APjAAAVAJT2QItevtAWbcLMK87Bwo6zr0oUZI1JgYQjoM/S0ThvnZJjs
        9Q1DIQglQ4PyBaoa6WZ5yaP0aQXsvR+uHw==
X-Google-Smtp-Source: APXvYqyeFBKaRlaV7l7eUdOweeWB83eOAxMhqF5BFWtungKZNloqqlhd+ctR1JGUO5HBcVp4eWezCA==
X-Received: by 2002:a37:4793:: with SMTP id u141mr66063884qka.355.1560818288855;
        Mon, 17 Jun 2019 17:38:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id i22sm7653833qti.30.2019.06.17.17.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 17:38:08 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hd28V-0000kY-Jn; Mon, 17 Jun 2019 21:38:07 -0300
Date:   Mon, 17 Jun 2019 21:38:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Ira Weiny <iweiny@intel.com>, Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 10/12] mm/hmm: Do not use list*_rcu() for
 hmm->ranges
Message-ID: <20190618003807.GD30762@ziepe.ca>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-11-jgg@ziepe.ca>
 <20190615141826.GJ17724@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615141826.GJ17724@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 15, 2019 at 07:18:26AM -0700, Christoph Hellwig wrote:
> On Thu, Jun 13, 2019 at 09:44:48PM -0300, Jason Gunthorpe wrote:
> >  	range->hmm = hmm;
> >  	kref_get(&hmm->kref);
> > -	list_add_rcu(&range->list, &hmm->ranges);
> > +	list_add(&range->list, &hmm->ranges);
> >  
> >  	/*
> >  	 * If there are any concurrent notifiers we have to wait for them for
> > @@ -934,7 +934,7 @@ void hmm_range_unregister(struct hmm_range *range)
> >  	struct hmm *hmm = range->hmm;
> >  
> >  	mutex_lock(&hmm->lock);
> > -	list_del_rcu(&range->list);
> > +	list_del(&range->list);
> >  	mutex_unlock(&hmm->lock);
> 
> Looks fine:
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Btw, is there any reason new ranges are added to the front and not the
> tail of the list?

Couldn't find one. I think order on this list doesn't matter.

Jason
