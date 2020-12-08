Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548382D34CB
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Dec 2020 22:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbgLHVDm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Dec 2020 16:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgLHVDm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Dec 2020 16:03:42 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E884BC0613CF
        for <linux-rdma@vger.kernel.org>; Tue,  8 Dec 2020 13:03:01 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id w79so16609qkb.5
        for <linux-rdma@vger.kernel.org>; Tue, 08 Dec 2020 13:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9sSR/G0iajxP79sAMRXtsqqOVlTG6SJFKBgyvVDhRlA=;
        b=d24RgsZ2dY3yg2s9gT27ixnsxarcSd8idMtkqjVGsflu8OKBdmx+R2xZpdEfehi5h1
         wsWoyB7TEyVi0tMQrziIh9wqoEV4CHrqwMVa9ZzvVQrI7+S1uhaXDE+wZ6KBnDbu2j07
         0eVL4TO4ad0n/ffatp+MiRMFysqbMeTJAGXQ/cIkQn99iZinfNub6qPBjSQCvuQ7hghk
         eSrNrOXSKSZfu2K49CvR/viUdI9Bh2mtwJKAmk2xc9g2YQfnLv1LlMmdHR0ZB3qR3XRe
         ltHttZkYOJVdAsKDGsgnW5q1CG4jEOoBQpDftata+QUZOQWi0RhDdXNnhQbca7rY9Jbv
         GqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9sSR/G0iajxP79sAMRXtsqqOVlTG6SJFKBgyvVDhRlA=;
        b=l/HQAVWe1cvj3mzJeUomCJtCrZyFxdLJK656B5vovdxk0SFeNqeuXoosFwmMcS16rj
         a1e+H7ISFUFSpxYFsCkq4IzapDgYFU3RbhGd7hNy7tINvGJiuYIOyERqx9v9f3d3jRgb
         nBvGnHYh4W0mGYOoS7AjPvR3JYxd51YMUH+m4jtzvryQ26nbJT0/ez+J4L39Ugbc3qI6
         pkVotOuqAUqX+9c9074zLnssQH7ayvDA85dLitZCxA2lqg8HIoIAYEf6D9zaTcZMypQn
         5wZuE95Xfj4LXitxSBC5DbNf41klu0NmhyzDlEigdqjpwhGP306qEm4tFuuQ6BcM6WTT
         qdhQ==
X-Gm-Message-State: AOAM533WWek36g2E+65/f8K0iHsM/j8jjhKoRxFj6R238C1OLHOe8qRa
        aB/3kOqUYKZu1Ezyl/NcT7m3EYrqjsc33g==
X-Google-Smtp-Source: ABdhPJxsADdJkiPwe0Gy1hcj7gLbSLG1LhGiy5Oa+UIfzViYvRxyacUzGMGBsmHeM/l+3idH436LOg==
X-Received: by 2002:ac8:7192:: with SMTP id w18mr31968213qto.149.1607453957166;
        Tue, 08 Dec 2020 10:59:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id q194sm5807666qka.102.2020.12.08.10.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 10:59:16 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kmiCh-007zxe-Ue; Tue, 08 Dec 2020 14:59:15 -0400
Date:   Tue, 8 Dec 2020 14:59:15 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Subject: Re: [PATCH v13 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20201208185915.GO5487@ziepe.ca>
References: <1607379353-116215-1-git-send-email-jianxin.xiong@intel.com>
 <1607379353-116215-2-git-send-email-jianxin.xiong@intel.com>
 <20201208070532.GE4430@unreal>
 <MW3PR11MB45554A727DA7940D81FE1C14E5CD0@MW3PR11MB4555.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB45554A727DA7940D81FE1C14E5CD0@MW3PR11MB4555.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 08, 2020 at 06:13:20PM +0000, Xiong, Jianxin wrote:

> > > +static inline struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
> > > +						 unsigned long offset,
> > > +						 size_t size, int fd,
> > > +						 int access,
> > > +						 struct dma_buf_attach_ops *ops) {
> > > +	return ERR_PTR(-EINVAL);
> > 
> > Probably, It should be EOPNOTSUPP and not EINVAL.
> 
> EINVAL is used here to be consistent with existing definitions in the same file.

They may be wrong, EOPNOTSUPP is right for this situation

Jason
