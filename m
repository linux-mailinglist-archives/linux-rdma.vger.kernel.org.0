Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC9C47062
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2019 16:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfFOOS3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Jun 2019 10:18:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51424 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfFOOS3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Jun 2019 10:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QAtCly+PQtUNfQV4P5g2hw3GFHENxhTcIuvEPxpIuGg=; b=b90xGJ+x0UwJqU/7Ldqu6D0lo
        DiD/e1TSteHI3mAWCw5RLZyrsLKkdqBExF4Dp2UL7jBDQEkfwhDrxDWPunc3tsNcMuz3t2n1SMwxU
        3zYlg/2iooeD18X5DJ6lLLDByKgg7asLYVufuU51WkA0bxF2v9XGQoL0fIsjRr3BlUGV3QKYhWrUS
        P9CLWe2hrue2MN57fLznBpUgYMfPyO/sPbAnH1Sp5vHhbSbOJ5IZivel1MoZYuDK4CUV4dSQDiOMv
        olCW2JBxsKPM+GNzvfpcXs1yx7oZnKU4hPYZ47nMD6Xjay+rv16teG9PUH51Rcm2NUZf91Av+R2mR
        XT0/l+wOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hc9Vi-0004Vn-La; Sat, 15 Jun 2019 14:18:26 +0000
Date:   Sat, 15 Jun 2019 07:18:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Ira Weiny <iweiny@intel.com>, Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 10/12] mm/hmm: Do not use list*_rcu() for
 hmm->ranges
Message-ID: <20190615141826.GJ17724@infradead.org>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-11-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614004450.20252-11-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 13, 2019 at 09:44:48PM -0300, Jason Gunthorpe wrote:
>  	range->hmm = hmm;
>  	kref_get(&hmm->kref);
> -	list_add_rcu(&range->list, &hmm->ranges);
> +	list_add(&range->list, &hmm->ranges);
>  
>  	/*
>  	 * If there are any concurrent notifiers we have to wait for them for
> @@ -934,7 +934,7 @@ void hmm_range_unregister(struct hmm_range *range)
>  	struct hmm *hmm = range->hmm;
>  
>  	mutex_lock(&hmm->lock);
> -	list_del_rcu(&range->list);
> +	list_del(&range->list);
>  	mutex_unlock(&hmm->lock);

Looks fine:

Signed-off-by: Christoph Hellwig <hch@lst.de>

Btw, is there any reason new ranges are added to the front and not the
tail of the list?
