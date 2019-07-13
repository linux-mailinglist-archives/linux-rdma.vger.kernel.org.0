Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA9D67A1A
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jul 2019 14:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfGMMMq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 13 Jul 2019 08:12:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39019 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfGMMMq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 13 Jul 2019 08:12:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id l9so11048232qtu.6
        for <linux-rdma@vger.kernel.org>; Sat, 13 Jul 2019 05:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wSRjYLXrGehQ92MoF6l9X1Uen5Hy9hhiufl0O/CqQkg=;
        b=aGrEXQNCXS/qbyuc0w8dxVrD5UMFiKZnCHL7MzUadJaicDoV919KeKJMbVXTVL0e6F
         jtLmRY3j+3UAwqi0sNsOkdcRqGu0zvQaMVX2gsaWqBLji+WqD2pZaCPqXaMBScHPDcCz
         wp/yO+HmUPOVm8pyz6lMgzgxV++j72oYP6CLEBn9barFcuGTi982yK/p5O9mk5Nox5UV
         iCI8iPAdnFxdY9UJV41Mv7DrMjrAvkUJ5ucUeyePjRQYCT+99C7ynjHtxACnWvn3lEq6
         QdoAHNRPB+Ayg+2vCT7n5cMJ6/SksQVigpcY2WtLNd05MMjXRqX9rDDHsy3QJI1RLGqT
         kOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wSRjYLXrGehQ92MoF6l9X1Uen5Hy9hhiufl0O/CqQkg=;
        b=YU6ox79BYFSdAPK3bOyALCP0kBa3F05DxgkMRL2BXQMKGRNyuS6kHiqa1mwDWbI0mH
         Y2nMiiNF8Z9qdZqPr80S5f1iiu3ywURYOqxa8A6m8PUwOEQT4mraBDeq7wLMmVlI6uCA
         zfgHqnNDWHnEYmY+BwaTFde7Y2JDpE4hjy6CKSosH2a8MnVf6bjX7vaiKFokDw/cRqxh
         xZKOLjbl0+c79qikLWQ8aOUUBIXJ8LVIgPFNDdlxyrmuaDYw380mLpnMaNPj0iahK1Zm
         J8h5N3BLVdKEw5VkHZqyfxJXsrVXpOrOfqGdw35BFLpkvQhQxlubI0RT702bcSBtv0jx
         u+LQ==
X-Gm-Message-State: APjAAAWuQL5Chy9PqQsBdNEgWdS++MJ5qJlQ28Ury3PMCHtGB0JlKgW6
        puEz26LtUQsRxLZRpwsnh/hIMA==
X-Google-Smtp-Source: APXvYqyHduXbzwORFDQsoAk95f9vSumZ3U+H2uKUM2cqH7Wbk921vMN6amCW8Vbkz9j+CQ++8wkRDw==
X-Received: by 2002:a0c:d0fc:: with SMTP id b57mr10961136qvh.78.1563019964936;
        Sat, 13 Jul 2019 05:12:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id q56sm6186341qtq.64.2019.07.13.05.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Jul 2019 05:12:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hmGtO-0001cu-L8; Sat, 13 Jul 2019 09:12:42 -0300
Date:   Sat, 13 Jul 2019 09:12:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     Parav Pandit <parav@mellanox.com>, Yi Zhang <yi.zhang@redhat.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: regression: nvme rdma with bnxt_re0 broken
Message-ID: <20190713121242.GA6211@ziepe.ca>
References: <CA+sbYW17PGAW57pyRmQB9KsDA9Q+7FFgSseSTTWE_h6vffa7UQ@mail.gmail.com>
 <AM0PR05MB4866CFEDCDF3CDA1D7D18AA5D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866CCD487C9D99BD9526BA8D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866665D5CACB34AE885BCA2D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <ef6a01a1-9163-ef4e-29ac-4f4130c682f1@redhat.com>
 <AM0PR05MB48666463325E1D0E25D63F57D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20190712154044.GJ27512@ziepe.ca>
 <CA+sbYW0F6Vgpa5SQX+9ge4EwWrMkJ4kQ-psEq11S00=-L_mVhg@mail.gmail.com>
 <20190712174220.GL27512@ziepe.ca>
 <CA+sbYW3Pp=qwky+myAEkiP-9TOui+9=DSyQxivNuSEsD8K4CFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sbYW3Pp=qwky+myAEkiP-9TOui+9=DSyQxivNuSEsD8K4CFA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jul 13, 2019 at 01:21:54PM +0530, Selvin Xavier wrote:
> On Fri, Jul 12, 2019 at 11:12 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Fri, Jul 12, 2019 at 09:59:38PM +0530, Selvin Xavier wrote:
> >
> > > > bnxt guys: please just delete this duplicate detection code from the
> > > > driver. Every GID provided from the core must be programmed into the
> > > > given gid table index.
> > >
> > > Jason,
> > >  This check is required in bnxt_re because the HW need only one entry
> > > in its table for RoCE V1 and RoCE v2 Gids.
> >
> > The HW doesn't have a 'GID table' if it has this restriction. It
> > sounds like it has some 'IP table' or maybe 'IP and VLAN' table?
> >
> > So the driver must provide a full emulated 'GID Table' with all the
> > normal semantics.
> >
> > Which looks sort of like what the add side is doing, other than the
> > mis-naming it seems reasonable..
> >
> > But then I see this in re_create_ah:
> >
> >         /*
> >          * If RoCE V2 is enabled, stack will have two entries for
> >          * each GID entry. Avoiding this duplicte entry in HW. Dividing
> >          * the GID index by 2 for RoCE V2
> >          */
> >         ah->qplib_ah.sgid_index = grh->sgid_index / 2;
> >
> > Which seems completely wrong - that is making assumptions about the
> > layout of the gid table that is just not allowed.
> >
> > Surely it needs to access the per-gid driver context that add_gid set
> > and use the index into the sgid_table from there?
> >
> Agree.. We need a mapping between HW table index and GID table index.
> We can either maintain a mapping in the driver or have an ib stack function to
> get the per gid driver context from gid table index. The later makes sense
> only if other drivers also needs such interface.  I am not sure any
> other driver needs
> it.

I'd prefer a core function to return that context..

Even better would be to have the core allocate a larger entry and use
container_of

Jason
