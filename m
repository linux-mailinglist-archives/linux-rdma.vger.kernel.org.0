Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37C62CB19F
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Dec 2020 01:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgLBAkG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Dec 2020 19:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgLBAkG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Dec 2020 19:40:06 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6D1C0613CF
        for <linux-rdma@vger.kernel.org>; Tue,  1 Dec 2020 16:39:25 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id cv2so1826918qvb.9
        for <linux-rdma@vger.kernel.org>; Tue, 01 Dec 2020 16:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uqFnA4wlIT9Sy7S8bA1zmlv7ZeBGWwkq7YIi+6/Fl7M=;
        b=eosQAu2h9055luOQLikH91uBAk1IZRYNH2FBpVUNBk3cIAzEr2iNx1WVdSEvkNhnC+
         vQrQAKnmUbjRjqEgOokhJlbpdGzIzqXWHOwE90vWFjDZe7vVoHPVkfXG7ysGahxbj8ST
         Cbxje4qi4tD4m6NxuwtGlADjLvXOm2jT25GaCaxaIrrvKeZTDmgWk8LGQlgzAt1VyEjz
         kMWios7ott+E5MY1U4wIKvyhr4ZrCB+zdLBcpecnbJL4ViQj82ToZftwJL2e5+odl5Q9
         Ta66UcnHpf5NWYsGwhDSHShCp8+SubMxjQ+db8u0jP7geEyrdOfReXIgczufYiCyj2t1
         J5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uqFnA4wlIT9Sy7S8bA1zmlv7ZeBGWwkq7YIi+6/Fl7M=;
        b=RGityBYLa6gEe5pYShx8sT0uz5ct+aUys0f/RZ4s9mB2iy/pU6adKGgnmVbiXf94jt
         4AuQRnqVJwtNiU5aR6Y11jSgh/aLdaUhGkRW0pq/YJp7fswh8kbR0yKZXuo4qiAqFye7
         9FCwOfHZ3BEQwn0MrT69qgvDcmwtAfaOCoMxMza9kx2MKTwJtvCycOnR4RRDQfMdseQ5
         EzV7aN5b+g2XDVENR0Vemiuz2l3wa8AfUvzBedZzoWBc9d/DqDHtUvAn9SUBJrZYdIRZ
         9DC9xm5+WKQIpTTluLYXSj78WdqWjv64VOMpw0AK8HLxu3qsj1OXkJl+PbHqEmjs/p6J
         ZLbg==
X-Gm-Message-State: AOAM533L+wVjLNfdN7rWKf/YslLEvXKoBBeACabpn2gdbUBroO5+r7fe
        l8oOSj3jRvRmfxpWUhhVzY+YbA==
X-Google-Smtp-Source: ABdhPJyZ+D1oBjr6GvYx10q3kexS42dlrJyY492YKNNXXdAAqN0ekmKqh97rzBrzrurkVHG9wS5vlw==
X-Received: by 2002:ad4:5043:: with SMTP id m3mr6088503qvq.45.1606869565176;
        Tue, 01 Dec 2020 16:39:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id z73sm129097qkb.112.2020.12.01.16.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 16:39:24 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kkGB1-004cmh-S8; Tue, 01 Dec 2020 20:39:23 -0400
Date:   Tue, 1 Dec 2020 20:39:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Subject: Re: [PATCH rdma-core v3 4/6] pyverbs: Add dma-buf based MR support
Message-ID: <20201202003923.GI5487@ziepe.ca>
References: <1606510543-45567-1-git-send-email-jianxin.xiong@intel.com>
 <1606510543-45567-5-git-send-email-jianxin.xiong@intel.com>
 <20201130160821.GB5487@ziepe.ca>
 <MW3PR11MB45556C1BAD4AF795DF0F783EE5F50@MW3PR11MB4555.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB45556C1BAD4AF795DF0F783EE5F50@MW3PR11MB4555.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 30, 2020 at 05:53:39PM +0000, Xiong, Jianxin wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Monday, November 30, 2020 8:08 AM
> > To: Xiong, Jianxin <jianxin.xiong@intel.com>
> > Cc: linux-rdma@vger.kernel.org; dri-devel@lists.freedesktop.org; Doug Ledford <dledford@redhat.com>; Leon Romanovsky
> > <leon@kernel.org>; Sumit Semwal <sumit.semwal@linaro.org>; Christian Koenig <christian.koenig@amd.com>; Vetter, Daniel
> > <daniel.vetter@intel.com>
> > Subject: Re: [PATCH rdma-core v3 4/6] pyverbs: Add dma-buf based MR support
> > 
> > On Fri, Nov 27, 2020 at 12:55:41PM -0800, Jianxin Xiong wrote:
> > >
> > > +function(rdma_multifile_module PY_MODULE MODULE_NAME LINKER_FLAGS)
> > 
> > I think just replace rdma_cython_module with this? No good reason I can see to have two APIs?
> 
> rdma_cython_module can handle many modules, but this one is for a single module.
> If you agree, I can merge the two by slightly tweaking the logic: each module starts 
> with a .pyx file, followed by 0 or more .c and .h files.

Then have rdma_cython_module call some rdam_single_cython_module()
multiple times that has this code below?

> > Here too? You probably don't need to specify h files at all, at
> > worst they should only be used with publish_internal_headers
> 
> Without the .h link, the compiler fail to find the header file (both
> dmabuf_alloc.c and the generated "dmabuf.c" contain #include
> "dmabuf_alloc.h").

Header files are made 'cross module' using the
"publish_internal_headers" command

But we could also hack in a -I directive to fix up the "" include for
the cython outupt..

But it should not be handled here in the cython module command

Jason
