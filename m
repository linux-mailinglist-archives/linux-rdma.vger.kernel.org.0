Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88D42A81C0
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 16:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgKEPCH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 10:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730822AbgKEPCH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Nov 2020 10:02:07 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34E7C0613CF
        for <linux-rdma@vger.kernel.org>; Thu,  5 Nov 2020 07:02:06 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id i7so1248451qti.6
        for <linux-rdma@vger.kernel.org>; Thu, 05 Nov 2020 07:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aEjedQGnbvpDY6glZjQQcDKpPqhdsXXdZcrkeVyX5oQ=;
        b=Z2Uj4OilmylQVxDL+DU7Y5P/c8WGD1UFcOjbpAk03p2/6cc/znY23y8onLANtbgIe6
         Wzy12eNa7rr1nd6EhL1CVV5r/LS0Wi8ucJQLG4BximCQtOnGUwOu0FlP7ongNUuot0TB
         3/lpC5SO9WFUnvBE1kp8bt+EOXHfHVWzm2Wt756f7OqkcQxgRpgcjE3POCExH2zsanWs
         yANPGFQNLss2vNuYUoThphC/zkoB0lbsZ4yE67VYczwB71LWovITSngT1lwbpqgZqLuh
         mHe8PshigzPyRe0l+ujOnsVKK4nAhagz47twlmO32ddw2IiROoEK37k+ZQdAzbG7HcBL
         E7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aEjedQGnbvpDY6glZjQQcDKpPqhdsXXdZcrkeVyX5oQ=;
        b=Z2zHxXQSwqLYKFa5tYyZdYQ3KHqMGHRDZmkx4cuT0Ufp70WpTwBP0UNE8zp+qZkZ5f
         pbSlBlCIGyFFVPtc0Bnpj55dCdfEfkmJFUl4HHyn19AanB4vwNJw+8FRJHeQ//fcEJus
         e5eNJBMHTko8/JhdS3FK2aFgfm+bcTEamAY7W0HQgrsEovAiEdMzSJXIdlJGxeRYv/dp
         0SOWGHdIb6mdDLoZaY7GgLHBGaPLV5zG/ziuSbCpnCyN31670k6qsZULTjM1mQomKCwN
         1RsJKmDw1Z6+v7ifEAAKDa7DXQ2Xibf4bv2e0KP7L7D5yfUEPRxHamfAoGgoXhn/g1n0
         Eg0A==
X-Gm-Message-State: AOAM530tEBN3OZxnA/hWxi/Z78X8hQRlOE0qg8Y9kD4zMoA2iginmL1V
        X4sU04cqMCdeUfus2OYnL7BL+w==
X-Google-Smtp-Source: ABdhPJy8L6TLYOaMOx02cH+3l45WHaqYAs7U33rCwZ2gyd8yzEhDkMmQIxa3O/OlV15G2AWP4TENsA==
X-Received: by 2002:ac8:6683:: with SMTP id d3mr2286456qtp.137.1604588526219;
        Thu, 05 Nov 2020 07:02:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id c12sm978506qtx.54.2020.11.05.07.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 07:02:05 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kagm4-00HODJ-GO; Thu, 05 Nov 2020 11:02:04 -0400
Date:   Thu, 5 Nov 2020 11:02:04 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     "Xiong, Jianxin" <jianxin.xiong@intel.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [PATCH v6 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20201105150204.GC36674@ziepe.ca>
References: <1603471201-32588-1-git-send-email-jianxin.xiong@intel.com>
 <1603471201-32588-2-git-send-email-jianxin.xiong@intel.com>
 <20201023164911.GF401619@phenom.ffwll.local>
 <20201023182005.GP36674@ziepe.ca>
 <CAKMK7uEZYdtwHKchNwiFjuYJDjA+F+qDgw64TNkchjp4uYUr6g@mail.gmail.com>
 <MW3PR11MB45553600E8A141CCDE52FABDE5110@MW3PR11MB4555.namprd11.prod.outlook.com>
 <CAKMK7uFMAiv27oRi98nAvx15M6jniUEb+hhe3mrY3mdYtzsmLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFMAiv27oRi98nAvx15M6jniUEb+hhe3mrY3mdYtzsmLg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 03, 2020 at 09:43:17PM +0100, Daniel Vetter wrote:

> > > Yeah definitely don't call dma_buf_map_attachment and expect a page back. In practice you'll get a page back fairly often, but I don't think
> > > we want to bake that in, maybe we eventually get to non-hacky dma_addr_t only sgl.
> > >
> > > What I'm wondering is whether dma_buf_attach shouldn't reject such devices directly, instead of each importer having to do that.
> >
> > Come back here to see if consensus can be reached on who should do the check. My
> > thinking is that it could be over restrictive for dma_buf_attach to always reject
> > dma_virt_ops. According to dma-buf documentation the back storage would be
> > moved to system area upon mapping unless p2p is requested and can be supported
> > by the exporter. The sg_list for system memory would have struct page present.
> 
> So I'm not clear on what this dma_virt_ops stuff is for, but if it's
> an entirely virtual device with cpu access, then you shouldn't do
> dma_buf_map_attachment, and then peek at the struct page in the sgl.

Yes, so I think the answer is it is rdma device driver error to call these
new APIs and touch the struct page side of the SGL.

After Christophs series removign dma_virt_ops we could make that more
explicit, like was done for the pci p2p case.


> As a third option, if it's something about the connectivity between
> the importing and exporting device, then this should be checked in the
> ->attach callback the exporter can provide, like the p2p check. The

Drivers doing p2p are supposed to be calling the p2p distance stuff
and p2p dma map stuff which already has these checks.

Doing p2p and skipping all that in the dma buf side we already knew
was a hacky thing.

Jason
