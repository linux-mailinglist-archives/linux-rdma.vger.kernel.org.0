Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E823BBED0
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jul 2021 17:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhGEPYT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jul 2021 11:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhGEPYS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jul 2021 11:24:18 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89622C061574
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jul 2021 08:21:41 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id h2so4280167qtq.13
        for <linux-rdma@vger.kernel.org>; Mon, 05 Jul 2021 08:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EQF1PASyvqSifzSlB1BTrhSt5sT6rp3hwdnxdUVfuqA=;
        b=kmDpglpc3RH0U5xRmBUJk9QboHSHOdWADEPFPwVaQEubGzRnQRRT1SHHBfce7nQKCa
         TRq6ezuT4wo5LOH+ImCdmvwlFyLjejhxNqQWbyAalAxbWsHjdGDhB/vw7rNRktkG9VtR
         E62LMBPwmoFKoqMyuO+MpS/Nm27YZcQ3krKENaRE4KZAlfEhUag8bmyciSrNxjBWPu02
         V1kwt9lHg7OwLc36pRJ9AJn39+4/vCQ0wNP0qLRiZ2YurHA2UO01EGrayBp9VSkrlxCa
         Av0fPe3v8n+hSQyizmYXzW7axfQdHqaMbdxJrXL50juFxWnbUtpid7xdH61Jii4Jv//E
         NWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EQF1PASyvqSifzSlB1BTrhSt5sT6rp3hwdnxdUVfuqA=;
        b=nI0A4DTu88FyPkmOFpSMGobHLSwbrif7mieZXNB35pHX4o6FaB2ZMi1mfaTsDR683t
         MJgvZFJ6TtQ0aZ1O9EzbNK7TfEy+Aspz3gXzAngl+LijdSCdSdGwnqLFO4egwDm6jmpl
         p3lfIMt0nAwyG/Lt+BXJ/TMJfCMLIJxiy3n5XcAzZxIDGDS1LlkckML23+zVlOMayhsr
         lb1dbfJaGhc3884yiExwqPZwalGeJjyYD1SY0VXQo+9phNhkFUvDx0nTq+UxxYMEYwKu
         OOBz2mbCp73KPwwDi/iPwxC+n1cdeZWMBl/KtmjMoBbd9hvSda3oQ+hADN5OSGWjxpWL
         aepA==
X-Gm-Message-State: AOAM5327qoMnnphLFr9sQlOL2uSDN1/2fIjd8ivUHuNIk9Fqp+sNITFL
        UR0loQETYN8bb3Q5JPzaPAr+9A==
X-Google-Smtp-Source: ABdhPJzqbfejz7owHserpym0js6NKw6M0U6WSIEmDVGhY5KKmty1j6Zlb4e8E5uTCQb/l0OoL09K9w==
X-Received: by 2002:a05:622a:3d4:: with SMTP id k20mr12966495qtx.177.1625498500633;
        Mon, 05 Jul 2021 08:21:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id s77sm4474299qke.85.2021.07.05.08.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 08:21:39 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1m0QPi-003qD0-UT; Mon, 05 Jul 2021 12:21:38 -0300
Date:   Mon, 5 Jul 2021 12:21:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Robin Murphy <robin.murphy@arm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, umalhi@cisco.com,
        linux-rdma@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [bug report] IB/usnic: Add Cisco VIC low-level hardware driver
Message-ID: <20210705152138.GH4604@ziepe.ca>
References: <YOLdvTe4MJ4kS01z@mwanda>
 <0b8a876b-f71d-24a2-1826-07aa54248f40@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b8a876b-f71d-24a2-1826-07aa54248f40@arm.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 05, 2021 at 02:47:36PM +0100, Robin Murphy wrote:
> On 2021-07-05 11:23, Dan Carpenter wrote:
> > [ Ancient code, but the bug seems real enough still.  -dan ]
> > 
> > Hello Upinder Malhi,
> > 
> > The patch e3cf00d0a87f: "IB/usnic: Add Cisco VIC low-level hardware
> > driver" from Sep 10, 2013, leads to the following static checker
> > warning:
> > 
> > 	drivers/iommu/iommu.c:2482 iommu_map()
> > 	warn: sleeping in atomic context
> > 
> > drivers/infiniband/hw/usnic/usnic_uiom.c
> >     244  static int usnic_uiom_map_sorted_intervals(struct list_head *intervals,
> >     245                                                  struct usnic_uiom_reg *uiomr)
> > 
> > This function is always called from usnic_uiom_reg_get() which is holding
> > spin_lock(&pd->lock); so it can't sleep.
> 
> FWIW back in those days it wasn't really well defined whether iommu_map()
> was callable from non-sleeping contexts (the arch/arm DMA API code relied on
> it, for instance). It was only formalised 2 years ago by 781ca2de89ba
> ("iommu: Add gfp parameter to iommu_ops::map") which introduced the
> might_sleep() check that's firing there. I guess these calls want to be
> updated to iommu_map_atomic() now.

Does this mean this driver doesn't work at all upstream? I would be
quite interested to delete it.

Jason
