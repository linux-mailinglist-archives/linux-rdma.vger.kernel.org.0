Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE9692911B
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 08:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388365AbfEXGk4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 02:40:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49750 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388335AbfEXGk4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 May 2019 02:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MboJlUX6ud6Y8h1xvMwj2zi3GdAiWghHA9DcE9E0NzM=; b=gCA2ZddjLB5JYDteejHRuh95u
        wJtaMuKOt5ACv/IoDR4+kaisQNbxEfqFZy7k1OXAn1DibvkRaXx+6ppZxoi/sgG+aZCL/GCx+GaXT
        xYn1+r+DqaVdoo9xeLPjTM1sWHV6skEExwJRIQwTSreXcRSJ0noVHx3MlPRSUPg81/AxHUivOym9w
        3uSlGykT8z6X9n9lodjYzb4NpCAUUqgt5J70gjw2mlp42t5mvX0r7bpW08CB9ZOYsPp42p76e2ZHC
        cObH1wCHfyOxmPP/jgAmUasX014LH9QR7Dq1g24+bAB9ecrOGc5a5i7RdtUcfpguWkQRROfWnpeMw
        BqaRnYRLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hU3sp-0000NM-Do; Fri, 24 May 2019 06:40:51 +0000
Date:   Thu, 23 May 2019 23:40:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jerome Glisse <jglisse@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
Message-ID: <20190524064051.GA28855@infradead.org>
References: <20190522174852.GA23038@redhat.com>
 <20190522235737.GD15389@ziepe.ca>
 <20190523150432.GA5104@redhat.com>
 <20190523154149.GB12159@ziepe.ca>
 <20190523155207.GC5104@redhat.com>
 <20190523163429.GC12159@ziepe.ca>
 <20190523173302.GD5104@redhat.com>
 <20190523175546.GE12159@ziepe.ca>
 <20190523182458.GA3571@redhat.com>
 <20190523191038.GG12159@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523191038.GG12159@ziepe.ca>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 23, 2019 at 04:10:38PM -0300, Jason Gunthorpe wrote:
> 
> On Thu, May 23, 2019 at 02:24:58PM -0400, Jerome Glisse wrote:
> > I can not take mmap_sem in range_register, the READ_ONCE is fine and
> > they are no race as we do take a reference on the hmm struct thus
> 
> Of course there are use after free races with a READ_ONCE scheme, I
> shouldn't have to explain this.
> 
> If you cannot take the read mmap sem (why not?), then please use my
> version and push the update to the driver through -mm..

I think it would really help if we queue up these changes in a git tree
that can be pulled into the driver trees.  Given that you've been
doing so much work to actually make it usable I'd nominate rdma for the
"lead" tree.
