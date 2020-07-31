Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB354234750
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jul 2020 16:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbgGaOEz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jul 2020 10:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730170AbgGaOEy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 Jul 2020 10:04:54 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EA1C061574
        for <linux-rdma@vger.kernel.org>; Fri, 31 Jul 2020 07:04:54 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id b25so22982226qto.2
        for <linux-rdma@vger.kernel.org>; Fri, 31 Jul 2020 07:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=781IgXX02TRDkWHahRceQKsFXQSmPskr3l/EDT57Vi4=;
        b=Q6DR3qA2s07ap18NgbhUz2I65CJAcbZd0GqAm8NJxwCYrMe7KPboFzZXDRIW5lebPB
         oPAHJk7XUdYIt6eLnbwRK5OsrvSiHbJroVQmKedNKll7+oQTEicW2nHi4Rn6BWyBvJmc
         lEcbaN7HrczmvO3LYz4q8LcxNGlBJ3tUKlHS8B68jhZ9zFDhvmhI9wnD5QNOETP1shOL
         79KgAqq62WlRj0VUpG9xstUqwVILBIlJ7fRjPbuyu2hRjsy7UxqmSM7o55hhWvcbtFih
         IJ29FiOq3N/1C3oFhp4V5OwU8vwRHkhlq6ImCk398H1tIuyiht+hq6GxBMWm63ZYSugB
         yLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=781IgXX02TRDkWHahRceQKsFXQSmPskr3l/EDT57Vi4=;
        b=hx4SpSPRvy0wbrl2FlXXaWw3V08KZmNZgABGTh5r3IyVZgY2fOdpuhcRvR0BnbBJV7
         vmZHpwSvBihTntJDVfwVEuLhf74UjYZkhOOiqSwlVmi2pNse42uhI8dboj72PRfzAF8r
         b1a2n6PpHkiHXxlrgLuoyNgzaM+4tixV+cnZpur7FZQQOBWSJhlIij85ItK64gl/Rg7D
         9zv0rpi/mnKEpNwmqHB5lmnix+/fMkDnJ1BDwqMRF/98/8YAeenhhamBfuMYTnhvj82W
         MMC6cdeKyVVCx83EsMXxaTzPZrBLh7+716jVyqIuYVTYJo/T01zU5nQpM+jggBLOt0br
         fBWg==
X-Gm-Message-State: AOAM530G4u28LoJBENVVLxoK/aueHFUebBNauyiYcRrwBqPQrCFrzfQt
        09GuQ0QaaCqttmzpwnkAvkTM/w==
X-Google-Smtp-Source: ABdhPJy1g859VdHLa7g09AW4SpHkI8nxyECHbw18XD+WYQwl6Uwee6XxVPfUS5+iBrmKK+EwP4CFMA==
X-Received: by 2002:ac8:7383:: with SMTP id t3mr3755232qtp.160.1596204293590;
        Fri, 31 Jul 2020 07:04:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id w27sm8432660qtv.68.2020.07.31.07.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 07:04:52 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1k1VeW-001u9f-23; Fri, 31 Jul 2020 11:04:52 -0300
Date:   Fri, 31 Jul 2020 11:04:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH net] rds: Prevent kernel-infoleak
 in rds_notify_queue_get()
Message-ID: <20200731140452.GE24045@ziepe.ca>
References: <20200730192026.110246-1-yepeilin.cs@gmail.com>
 <20200731045301.GI75549@unreal>
 <20200731053306.GA466103@kroah.com>
 <20200731053333.GB466103@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731053333.GB466103@kroah.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 31, 2020 at 07:33:33AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 31, 2020 at 07:33:06AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Jul 31, 2020 at 07:53:01AM +0300, Leon Romanovsky wrote:
> > > On Thu, Jul 30, 2020 at 03:20:26PM -0400, Peilin Ye wrote:
> > > > rds_notify_queue_get() is potentially copying uninitialized kernel stack
> > > > memory to userspace since the compiler may leave a 4-byte hole at the end
> > > > of `cmsg`.
> > > >
> > > > In 2016 we tried to fix this issue by doing `= { 0 };` on `cmsg`, which
> > > > unfortunately does not always initialize that 4-byte hole. Fix it by using
> > > > memset() instead.
> > > 
> > > Of course, this is the difference between "{ 0 }" and "{}" initializations.
> > 
> > Really?  Neither will handle structures with holes in it, try it and
> > see.
> 
> And if true, where in the C spec does it say that?

The spec was updated in C11 to require zero'ing padding when doing
partial initialization of aggregates (eg = {})

"""if it is an aggregate, every member is initialized (recursively)
according to these rules, and any padding is initialized to zero
bits;"""

The difference between {0} and the {} extension is only that {}
reliably triggers partial initialization for all kinds of aggregates,
while {0} has a number of edge cases where it can fail to compile.

IIRC gcc has cleared the padding during aggregate initialization for a
long time. Considering we have thousands of aggregate initializers it
seems likely to me Linux also requires a compiler with this C11
behavior to operate correctly.

Does this patch actually fix anything? My compiler generates identical
assembly code in either case.

Jason
