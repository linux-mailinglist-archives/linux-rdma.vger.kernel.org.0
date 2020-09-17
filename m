Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD41226E1B4
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Sep 2020 19:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgIQRFW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 13:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbgIQRFQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Sep 2020 13:05:16 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D1CD206A2;
        Thu, 17 Sep 2020 17:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600362316;
        bh=4vDvtVqStZPJ5PaYsrsuay+CwsikfXiFuhGtIVFY3jk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SRY3EW1SudaDv4PvQXVJP8XxnFJqM1+CepkkECdh20VgjeIEVjfooGkbiCzgQYZme
         dgQvpUtH+niQBVne10rH849paQ6qS7hM6KbYvkvnFb/cNZoDUI5nWYXsIJTnkDWp9t
         LHVaTWdy9fgq5DaUHfEWeXM21L4q5e5PLFJP82aA=
Date:   Thu, 17 Sep 2020 20:05:11 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/mlx5: fix type warning of sizeof in
 __mlx5_ib_alloc_counters()
Message-ID: <20200917170511.GI869610@unreal>
References: <20200917082926.GA869610@unreal>
 <20200917091008.2309158-1-liushixin2@huawei.com>
 <20200917090810.GB869610@unreal>
 <20200917123806.GA114613@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917123806.GA114613@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 17, 2020 at 09:38:06AM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 17, 2020 at 12:08:10PM +0300, Leon Romanovsky wrote:
> > On Thu, Sep 17, 2020 at 05:10:08PM +0800, Liu Shixin wrote:
> > > sizeof() when applied to a pointer typed expression should give the
> > > size of the pointed data, even if the data is a pointer.
> > >
> > > Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>
> Needs a fixes line
>
> > >  	if (!cnts->names)
> > >  		return -ENOMEM;
> > >
> > >  	cnts->offsets = kcalloc(num_counters,
> > > -				sizeof(cnts->offsets), GFP_KERNEL);
> > > +				sizeof(*cnts->offsets), GFP_KERNEL);
> >
> > This is not.
>
> Why not?

cnts->offsets is array of pointers that we will set later.
The "sizeof(*cnts->offsets)" will return the size of size_t, while we
need to get "size_t *".

Thanks

>
> Jason
