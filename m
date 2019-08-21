Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5670E9816E
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 19:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfHURhE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 13:37:04 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41011 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbfHURhE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 13:37:04 -0400
Received: by mail-qk1-f196.google.com with SMTP id g17so2544526qkk.8
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2019 10:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MHI98aTL0ZzWIW3hYJwDpZImT3PEfG2n1PSa5np3hsE=;
        b=YbV09VFdsL7r5c2of2VQqijCrII+Y0lbdxRsDUxlHafNlo3nuVOeooMF6W2m75a4US
         iGjTtY/VpOpxuJZZvItCaax6o4+Nu6dot/zKus7qWBSSxelbQ576DIlvpGqVaa+FVNkS
         7hX4CCAcBgLG+TABEIASeqnnE64rFsrj7tTGajpNBNuijESikb5XvqaNaxQS1dQI7nx2
         k+ETvvhbWu37P8tOYcHxi8tQktjt66lwkEn4fcMJpymEmwNjVZ5clui7AgzVuqkKTj73
         ioNtqLTzIGHveHEfmpYzopdw1cm5aweU4L5MRBqJTc/0S94GrEKASZ+M8z1A3GoijaUY
         xGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MHI98aTL0ZzWIW3hYJwDpZImT3PEfG2n1PSa5np3hsE=;
        b=RhsW4Lm2sHivuT1AVKORni81XuVQPiYOaT71XHyIxf9YVRakSzEVV5nzLGo3h93XnD
         /GZeiOUhyDLgUuMpIFnFCHZxwj0yIBcLxfK5eBOU8bn1eGfDXMo27/cYxCi8aSeLjVQg
         NX13xheCKLJggGELv691ZpiBR75R2O3sLHrGRbl4NKn3BZ1sd3OtDCqDjf+lTmikcOGs
         WlyLQ3wXrr/i3qORS77DOyukZ5qUjmFeUVEqyEenoldFm4flV+ROq4ElArhZLp0rk6Ym
         tMTQ6BXYPDUiYXHie1mJ8ARQJTpg4OlFpgB+oXVnBQrBLgQliOY9dymzxVJNNX5HgqnU
         UOgw==
X-Gm-Message-State: APjAAAVJOyBPy3EMUGDiwa4kdW1WfcHVrDB/yRbF0376yJCffakfkVjt
        yOo/V9NBeT6GRDIWPBszpuqf6w==
X-Google-Smtp-Source: APXvYqwumrrRISfuEpKEjO/gZaRg73PRGVVCs+WUOz/booF5PHrEqx4QRq1UYlcXyhpyBUakjONtPA==
X-Received: by 2002:a37:4dc5:: with SMTP id a188mr31585559qkb.206.1566409023021;
        Wed, 21 Aug 2019 10:37:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id q9sm10716361qtj.48.2019.08.21.10.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 10:37:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i0UXe-0006V6-4r; Wed, 21 Aug 2019 14:37:02 -0300
Date:   Wed, 21 Aug 2019 14:37:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v7 rdma-next 2/7] RDMA/core: Create mmap
 database and cookie helper functions
Message-ID: <20190821173702.GG8653@ziepe.ca>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <20190820121847.25871-3-michal.kalderon@marvell.com>
 <20190820132125.GC29246@ziepe.ca>
 <MN2PR18MB31821E7411D0E44267F4A256A1AB0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <CH2PR18MB31752BE286837BFDCEE3B17CA1AA0@CH2PR18MB3175.namprd18.prod.outlook.com>
 <20190821165121.GE8653@ziepe.ca>
 <CH2PR18MB3175EDB5640A3987D97A4DC0A1AA0@CH2PR18MB3175.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR18MB3175EDB5640A3987D97A4DC0A1AA0@CH2PR18MB3175.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 21, 2019 at 05:14:38PM +0000, Michal Kalderon wrote:

> > > Jason, I looked into this deeper today, it seems that since the Core
> > > is the one handling the reference counting, and eventually Freeing the
> > > object that it makes more sense to keep the allocation In core and not
> > > in the drivers, since the driver won't be able to free The entry
> > > without providing yet an additional callback function to the Core to
> > > be called once the reference count reaches zero.
> > 
> > This already added a callback to free the xa_entry, why can't it free all the
> > memory too when kref goes to 0?
> True, could free it there. I just think we'll have a bit more
> duplication code

Well, the drivers already needed to allocate something right?

> Between the drivers defining a very similar private structure and adding
> Allocation calls before each of the rdma_user_mmap_insert function calls. 
>  And just to make sure I follow, 
> Do you mean creating the following structure per driver: 
> Struct <driver>_user_mmap_entry {
> 	struct rdma_user_mmap_entry umap_entry;
>               ... <private fields> ...
> }

Yes, that is the general pattern

Jaosn
