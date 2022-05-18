Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DC852AEF0
	for <lists+linux-rdma@lfdr.de>; Wed, 18 May 2022 02:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiERAEB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 May 2022 20:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiERAEA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 May 2022 20:04:00 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7636950440
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 17:03:58 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id n8so370831qke.11
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 17:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rc9GkWPYwi9LjqP/Z5LP2qV70hypQrqBkulyuMgMrFs=;
        b=GyE4RctcHXmpHwWg3/vj2qWS+pJOYVc0XqsDwxjK94QvKCHOXSGP/2QEz3efBSZWCT
         H4CvW8XL8GdJD0msOv980Gooh7AC3Wc3CqvDGXkdaAZXz39Q2u71SvyoZF8Up253bzYS
         goKPZggFYA5z1F44SkDR7jfLk29BeY2pWCidXYNEdOeZjC2/oakC7+Gq0sP5tsLHG1yE
         d9LvRHW6oha2Pe+/oGMstHAI4nBRZIAsffa/V5J3qdtwwlSlKeyoeF8WUySB0HRtRYzq
         wXI3kIw/DmdcurybnglIzcCy+Hp68JRkm+PLhCRG4lF2og5VUx9yYeONNJVENCk5isn5
         wT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rc9GkWPYwi9LjqP/Z5LP2qV70hypQrqBkulyuMgMrFs=;
        b=DZtyKvu5Pc1q2wPNjozXTLAZGj55jsGn8F7IkEdbVbiS7mYbqxXnwTSDsGxiKCTAkq
         37DsByrVTHIL5ArXaham3BVgx2yEgkmc0uEy1q+TSXGLVBTLb4A4aHjiKT0QzydQ+gKR
         xVSB+AlSy1Fse0Dd4WQIoPKEGDQiRYqscVaHVodnpd7UOZs52eCVqru/Qt4KoacLaCUg
         IgK9D6avLENDwumby9gzu0CleY6t4DivewtlFU8kSgxITazOZSUljuwJVY2gn8Vvmi+v
         WambjcS9VeV9yVzkKut6YsUGl5iHc2uD0/aJV52uYdd/jFDy+e4OdPaYx9TL3ffbvLr/
         Xg7A==
X-Gm-Message-State: AOAM530PHQUv3QgKqXj/Zf+/oTnuHRJZ4EbcznqC4zZpkyAzD9i3AAcw
        LSbkNn/ARUj4kXRjAZYi0RbQfQ==
X-Google-Smtp-Source: ABdhPJx1uUSvOMA2ilddaCy47Ot+FFkFnYYMTPmBJEHO9pSg/n8gspCmeg+o5fLHgqBtvEqimUFbsQ==
X-Received: by 2002:a05:620a:42:b0:6a0:c64c:35ae with SMTP id t2-20020a05620a004200b006a0c64c35aemr18539952qkt.607.1652832237634;
        Tue, 17 May 2022 17:03:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id n7-20020ac81e07000000b002f39b99f6bfsm262039qtl.89.2022.05.17.17.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 17:03:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nr7AS-008EVK-0v; Tue, 17 May 2022 21:03:56 -0300
Date:   Tue, 17 May 2022 21:03:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Long Li <longli@microsoft.com>
Cc:     Ajay Sharma <sharmaajay@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 05/12] net: mana: Set the DMA device max page size
Message-ID: <20220518000356.GO63055@ziepe.ca>
References: <1652778276-2986-1-git-send-email-longli@linuxonhyperv.com>
 <1652778276-2986-6-git-send-email-longli@linuxonhyperv.com>
 <20220517145949.GH63055@ziepe.ca>
 <PH7PR21MB3263EFA8F624F681C3B57636CECE9@PH7PR21MB3263.namprd21.prod.outlook.com>
 <20220517193515.GN63055@ziepe.ca>
 <PH7PR21MB3263C44368F02B8AF8521C4ACECE9@PH7PR21MB3263.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB3263C44368F02B8AF8521C4ACECE9@PH7PR21MB3263.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 17, 2022 at 08:04:58PM +0000, Long Li wrote:
> > Subject: Re: [PATCH 05/12] net: mana: Set the DMA device max page size
> > 
> > On Tue, May 17, 2022 at 07:32:51PM +0000, Long Li wrote:
> > > > Subject: Re: [PATCH 05/12] net: mana: Set the DMA device max page
> > > > size
> > > >
> > > > On Tue, May 17, 2022 at 02:04:29AM -0700, longli@linuxonhyperv.com
> > wrote:
> > > > > From: Long Li <longli@microsoft.com>
> > > > >
> > > > > The system chooses default 64K page size if the device does not
> > > > > specify the max page size the device can handle for DMA. This do
> > > > > not work well when device is registering large chunk of memory in
> > > > > that a large page size is more efficient.
> > > > >
> > > > > Set it to the maximum hardware supported page size.
> > > >
> > > > For RDMA devices this should be set to the largest segment size an
> > > > ib_sge can take in when posting work. It should not be the page size
> > > > of MR. 2M is a weird number for that, are you sure it is right?
> > >
> > > Yes, this is the maximum page size used in hardware page tables.
> > 
> > As I said, it should be the size of the sge in the WQE, not the "hardware page
> > tables"
> 
> This driver uses the following code to figure out the largest page
> size for memory registration with hardware:
> 
> page_sz = ib_umem_find_best_pgsz(mr->umem, PAGE_SZ_BM, iova);
> 
> In this function, mr->umem is created with ib_dma_max_seg_size() as
> its max segment size when creating its sgtable.
>
> The purpose of setting DMA page size to 2M is to make sure this
> function returns the largest possible MR size that the hardware can
> take. Otherwise, this function will return 64k: the default DMA
> size.

As I've already said, you are supposed to set the value that limits to
ib_sge and *NOT* the value that is related to
ib_umem_find_best_pgsz. It is usually 2G because the ib_sge's
typically work on a 32 bit length.

Jason
