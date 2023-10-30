Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993ED7DBA04
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Oct 2023 13:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjJ3MmJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Oct 2023 08:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjJ3MmH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Oct 2023 08:42:07 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A960DB7
        for <linux-rdma@vger.kernel.org>; Mon, 30 Oct 2023 05:42:02 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-672f5fb0b39so4614856d6.2
        for <linux-rdma@vger.kernel.org>; Mon, 30 Oct 2023 05:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698669722; x=1699274522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DaVImc0dkBy3Z9VTY5Zc/APOkE9bH1O0oC3xdyopltQ=;
        b=b2VjK9lYfopeqoSMxqnpGF1Z7qPRaXlTZt4hG+CzcTOrrSAtsnjeeF79xLDAVhtQ0m
         ymnruuu84qnPeBvB8KSb6Bo4VOLsy1dmN9iTEMeWOCB3ddSMku3/QNP8wIi3YKcW8HKs
         XpnOqGg+DwRjfRwMfK5BfKxiR9GdlLS/SAiXGrZOPYldPNzB+Sft/YMuG5l+1CAft3dN
         xsc8TTXKMArFYX5ROH2dOJwi2iM5EJZymzm4LHfxKjq0sQchIUO6JsFrZxyANbBWWPLf
         R5jqgBLVPKFQVUmYcKEsKQbOYkNDiWkFVUSibu3U9p1TY36kLEMfcT54+MUHn3+YLC5Z
         +NUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698669722; x=1699274522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaVImc0dkBy3Z9VTY5Zc/APOkE9bH1O0oC3xdyopltQ=;
        b=ehlmmhzf1e6x5HgKBt9BwGfKsrnCULJjcd/qX0UkvbjAsNuAEdal3HOD5cwdCy2qeJ
         8QlYnHoE3+DMImqrM0GmBz56j87krcEsx186TLeeTDIAa/MJv6Yjow8VmX1Roy+Sgobx
         8tzmomcm5zcEz0zKyKrXUNtFG6crMoaNxHLHeQEGCGTNhC7voRkAn3DWcBuTEJI8kbEb
         kfhHms9FNa820xPEs5n+dZ/t+wCEnwLX7ybYbs4Zps1bzvUsoUSVpPsCcRszvkhmSGL4
         RQcErKjwak1dZRXYW1FQ/PYe/3osulfyy9Al3NVa5JKONxHuULbQjG5XYV0hGX6GmO9x
         BVNg==
X-Gm-Message-State: AOJu0YwNdhRtyWLeVhGiexEem4pRv9HU410ZAquFuFaugcR5BsEHIlLP
        qYO6LVaBR6Q+Zy89Mrq99guV0g==
X-Google-Smtp-Source: AGHT+IEOz8S23BFi1wdI4YLJqyV/rMmzVLc6eQlLZ2YijSllB3dRYQ7TQWi1PVTb30pu0Qc98Y61Sw==
X-Received: by 2002:a0c:cd0f:0:b0:66d:6544:8eae with SMTP id b15-20020a0ccd0f000000b0066d65448eaemr10074472qvm.34.1698669721602;
        Mon, 30 Oct 2023 05:42:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id w10-20020a0562140b2a00b00656e2464719sm3390314qvj.92.2023.10.30.05.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 05:42:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qxRai-006ev4-JC;
        Mon, 30 Oct 2023 09:42:00 -0300
Date:   Mon, 30 Oct 2023 09:42:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Long Li <longli@microsoft.com>
Cc:     Ajay Sharma <sharmaajay@microsoft.com>,
        "sharmaajay@linuxonhyperv.com" <sharmaajay@linuxonhyperv.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [Patch v7 5/5] RDMA/mana_ib: Send event to qp
Message-ID: <20231030124200.GF691768@ziepe.ca>
References: <1697494322-26814-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1697494322-26814-6-git-send-email-sharmaajay@linuxonhyperv.com>
 <20231023182332.GL691768@ziepe.ca>
 <MN0PR21MB36067E337A53C3BAF8B648E5D6DEA@MN0PR21MB3606.namprd21.prod.outlook.com>
 <MN0PR21MB32641E489F378F0C5B357795CEDCA@MN0PR21MB3264.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR21MB32641E489F378F0C5B357795CEDCA@MN0PR21MB3264.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 27, 2023 at 09:35:05PM +0000, Long Li wrote:
> > Subject: RE: [EXTERNAL] Re: [Patch v7 5/5] RDMA/mana_ib: Send event to qp
> > 
> > 
> > > -----Original Message-----
> > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > Sent: Monday, October 23, 2023 11:24 AM
> > > To: sharmaajay@linuxonhyperv.com
> > > Cc: Long Li <longli@microsoft.com>; Leon Romanovsky <leon@kernel.org>;
> > > Dexuan Cui <decui@microsoft.com>; Wei Liu <wei.liu@kernel.org>; David S.
> > > Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> > > Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> > > linux- rdma@vger.kernel.org; linux-hyperv@vger.kernel.org;
> > > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Ajay Sharma
> > > <sharmaajay@microsoft.com>
> > > Subject: [EXTERNAL] Re: [Patch v7 5/5] RDMA/mana_ib: Send event to qp
> > >
> > > On Mon, Oct 16, 2023 at 03:12:02PM -0700,
> > sharmaajay@linuxonhyperv.com
> > > wrote:
> > >
> > > > diff --git a/drivers/infiniband/hw/mana/qp.c
> > > > b/drivers/infiniband/hw/mana/qp.c index ef3275ac92a0..19fae28985c3
> > > > 100644
> > > > --- a/drivers/infiniband/hw/mana/qp.c
> > > > +++ b/drivers/infiniband/hw/mana/qp.c
> > > > @@ -210,6 +210,8 @@ static int mana_ib_create_qp_rss(struct ib_qp
> > > *ibqp, struct ib_pd *pd,
> > > >  		wq->id = wq_spec.queue_index;
> > > >  		cq->id = cq_spec.queue_index;
> > > >
> > > > +		xa_store(&mib_dev->rq_to_qp_lookup_table, wq->id, qp,
> > > GFP_KERNEL);
> > > > +
> > >
> > > A store with no erase?
> > >
> > > A load with no locking?
> > >
> > > This can't be right
> > >
> > > Jason
> > 
> > This wq->id is assigned from the HW and is guaranteed to be unique. May be I
> > am not following why do we need a lock here. Can you please explain ?
> > Ajay
> 
> I think we need to check the return value of xa_store(), and call xa_erase() in mana_ib_destroy_qp().
> 
> wq->id is generated by the hardware. If we believe in hardware
> always behaves in good manner, we don't need a lock.

It has nothing to do with how the ID is created, you need to explain
how the missing erase can't race with any loads, in a comment above
the unlocked xa_load.

Jason
