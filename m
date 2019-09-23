Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31B5ABB537
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 15:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406992AbfIWN2R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 09:28:17 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41094 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405044AbfIWN2R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 09:28:17 -0400
Received: by mail-qk1-f194.google.com with SMTP id p10so15325660qkg.8
        for <linux-rdma@vger.kernel.org>; Mon, 23 Sep 2019 06:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IefxKbqK0aNcxhdxNNvzEkfAMO9H+jjfMOqUb5aFuSM=;
        b=Huf1bpbecSc4MGWMrXXEE5/4OzBQKq4jXEyIwjy8jMViy747c3oi894wlzFzvyjMNg
         bxiBbxQeF5qXbTdFWxWdWPoI2YVt8PsCvOzzmmeQFVJEwUS4OVTwLIN5HxLxdvfDl0xx
         h9krkEBp6/90LLZYb9RTNoHJw8sSpe/JX5jx+DzwakpTYyWLnu5bL3py7YczIjyBYSdR
         GeOwl9XyKYYat9qGIJV1RNmLPE7XdnOF74CaoSnpKwU2/ikY1VcMGLhQKC1Fej6aeGbm
         Fw30JiO3RH2958pBlM5IIxSjH8rdKuk/V5hE+0v09HaMhamlhKR06H7viiP9NqZahFTM
         s1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IefxKbqK0aNcxhdxNNvzEkfAMO9H+jjfMOqUb5aFuSM=;
        b=P5Y7LsiWcJkDDAPBUcHadvC/SKAWB9opd7OC4N4rI5IvS3ampHvTAYc+z8laZMjs/K
         fYTSM0y0NV4gTN2EsyxOKywKseZByIpofN8jrwQ2lgeEERUMdqhAkwGY4XYuWLB+5/Kn
         6RI1p+/DwCwQVxiVjA547MsPkSc34bsx/b5dk0naD2hqkdcesc+DGbMPwmob0YnS5r3i
         +DzgHT96vEOG3RaeqYwLvCMhYo0iqmfwxp4VhZGAq+lds4o14mXtO29LhvJ33O0TsipR
         vcUMKbI1QZOpo74IrdSDPLt2ssU/wjgo5EfG3cVcRfmXPJmvn0xYl0wr1lslIPllSxMx
         ZxKw==
X-Gm-Message-State: APjAAAWS88HLsndn0Bd5Ei+GHwVmwKgv4upwIXx6qOIGk+TcRUvIMK3r
        iB/qbrXwZy9FI9yw9Nwr4jFKMg==
X-Google-Smtp-Source: APXvYqwOT45AtJSMFKLura2TJ+hgpf2XzE2aglbzOgEFmTwJpfZrr6bQ0FzzMrDSCMPrsbYN/Fjr5w==
X-Received: by 2002:a37:5187:: with SMTP id f129mr16466552qkb.382.1569245296587;
        Mon, 23 Sep 2019 06:28:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-223-10.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.223.10])
        by smtp.gmail.com with ESMTPSA id e9sm4788321qkl.10.2019.09.23.06.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Sep 2019 06:28:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iCONz-0003m1-Lb; Mon, 23 Sep 2019 10:28:15 -0300
Date:   Mon, 23 Sep 2019 10:28:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v11 rdma-next 3/7] RDMA/efa: Use the common mmap_xa
 helpers
Message-ID: <20190923132815.GB12047@ziepe.ca>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-4-michal.kalderon@marvell.com>
 <20190919173701.GB4132@ziepe.ca>
 <MN2PR18MB31823E8EADC7E27A12D09423A1850@MN2PR18MB3182.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB31823E8EADC7E27A12D09423A1850@MN2PR18MB3182.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 23, 2019 at 09:15:54AM +0000, Michal Kalderon wrote:

> > This hidden detail should also be noted in the comment for
> > rdma_user_mmap_io..
> 
> I actually misunderstood you before and thought that we want to
> maintain all mappings in umap.  Now I understand you meant only the
> io mappings, since they're not referenced counted by the mm system.
> I'll revert the changes and add an additional parameter to
> rdma_user_mmap_io -> However, this means more changes in drivers
> that call this function and don't use the mmap_xa, Should I add an
> additional interface ? or are you OK with me sending NULL to the
> additional parameter from all drivers using the interface ? (hns,
> mlx4, mlx5)

It should be OK

> Also, who should increase the refcnt of rdma_user_mmap_entry when it
> is set to the vma private data ?  The caller of rdma_user_mmap_io or
> inside rdma_user_mmap_io function ?  This will definitely simplify
> things.

I generally prefer to see refcounts incrd at the spot the pointer is
copied, so the thing that sets vm_prviate_data should incr the refcount.

Jason
