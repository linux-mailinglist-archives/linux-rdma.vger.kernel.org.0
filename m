Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2C8616B033
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 20:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgBXTX4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 14:23:56 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45854 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgBXTX4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 14:23:56 -0500
Received: by mail-qk1-f195.google.com with SMTP id a2so9684725qko.12
        for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2020 11:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bSYURdilK+N6Xg2iZYnkaMczk6vdToiJ3RBUsuldfrs=;
        b=UkxbFFxxxwalBqrS2ubquqRNCV9lRdg6qHS1Le+Mkk5W4N9H5jKWMdkCyZ4icfCOu5
         whbIpzvOeqkBCQMAA38vMDJcHUWbG4o9ZgA52F1aR4GSyLsXiw4tRTgFfbyE8AKThSSS
         VELdkA2UoGaO7Gn60jzIsii9NCkPQ413qY7TDgBxiLF9dJE0uD5x1g4PGMWFrmjJBUad
         UAWzDMgtE2zdhwkRIoetA8exfHf6LGzHxUWRaVFTWv1/Dmdn3lWHoHESGXiM/LgcIyMb
         6xVX6uXroO8GSooNxDW/VwxdITQiZTWh9g5/q0O8vCNCUip6XjTkH5avTmCRorfXQPTR
         HG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bSYURdilK+N6Xg2iZYnkaMczk6vdToiJ3RBUsuldfrs=;
        b=dYMAlDpRXiNLGlyi1/r1AhtLtk1uJc4yujOdwS5AYKZlflE2Gj30B6GLzvS1qHdfZl
         YNxt7w9pe7DnsrQse6158lB6D9nY4OZceHx87CVObDNbZEPCZj1ivDcbm8fmdjiaz+27
         06zdyG1UK1TExa4Ou644Y4tGyvjhGqZss+E+by65k6Wngajpal2r8wTJEXYX5oVkWQTE
         Ux/IGo4NzDIfObseveY7eI/phl7DnMjC/+UpXy6Siz6bfCjweCKEAXoM5C0jULIBE/St
         cysFlDeQW2SPYH2fql+wR61Th/pbZQOmcf/U2Bhgp3eYLgTiQq9DRVnSBruu5XHRGRM9
         VL/A==
X-Gm-Message-State: APjAAAU+r8Jt0K2b7+t4bQFohwhqqS28JUhcRZPqa1xZyUuyDvCzXrLx
        R4tnODDRBEzi6emNLb2YjpTPzA==
X-Google-Smtp-Source: APXvYqzysz2cjGvotVYUTo+ZmG0bCz4LZvwWoNuXO/dtk+aCGb8OM82oHlF8vNuXogK/RIVgOmjXgw==
X-Received: by 2002:a37:de0b:: with SMTP id h11mr50645780qkj.274.1582572234868;
        Mon, 24 Feb 2020 11:23:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w134sm6178910qka.127.2020.02.24.11.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Feb 2020 11:23:54 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j6JKb-0005Si-N4; Mon, 24 Feb 2020 15:23:53 -0400
Date:   Mon, 24 Feb 2020 15:23:53 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Weihang Li <liweihang@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: Is anyone working on implementing LAG in ib core?
Message-ID: <20200224192353.GU31668@ziepe.ca>
References: <280d87d0-fbc0-0566-794b-f66cb4fadb63@huawei.com>
 <20200222234026.GO31668@ziepe.ca>
 <98482e8a-f2eb-5406-b679-0ceb946ac618@mellanox.com>
 <20200223094928.GB422704@unreal>
 <5db0d4f8-1893-33c2-fb25-e6012e0fc6d6@mellanox.com>
 <20200224105206.GA468372@unreal>
 <20200224182902.GS31668@ziepe.ca>
 <8c2df0c3-db07-4f18-1b7f-f648539d52d1@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c2df0c3-db07-4f18-1b7f-f648539d52d1@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 24, 2020 at 07:01:43PM +0000, Parav Pandit wrote:
> On 2/24/2020 12:29 PM, Jason Gunthorpe wrote:
> > On Mon, Feb 24, 2020 at 12:52:06PM +0200, Leon Romanovsky wrote:
> >>> Are you asking why bonding should be implemented as dedicated
> >>> ulp/driver, and not as an extension by the vendor driver?
> >>
> >> No, I meant something different. You are proposing to combine IB
> >> devices, while keeping netdev devices separated. I'm asking if it is
> >> possible to combine netdev devices with already existing bond driver
> >> and simply create new ib device with bond netdev as an underlying
> >> provider.
> > 
> > Isn't that basically what we do now in mlx5?
> > 
> And its broken for few aspects that I described in Q&A question-1 in
> this thread previously.
> 
> On top of that user has no ability to disable rdma bonding.

And what does that mean? The real netdevs have no IP addreses so what
exactly does a non-bonded RoCEv2 RDMA device do?

> User exactly asked us that they want to disable in some cases.
> (not on mailing list). So there are non-upstream hacks exists that is
> not applicable for this discussion.

Bah, I'm aware of that - that request is hack solution to something
else as well.

> > Logically the ib_device is attached to the bond, it uses the bond for
> > IP addressing, etc.
> > 
> > I'm not sure trying to have 3 ib_devices like netdev does is sane,
> > that is very, very complicated to get everything to work. The ib stuff
> > just isn't designed to be stacked like that.
> > 
> I am not sure I understand all the complications you have thought through.
> I thought of few and put forward in the Q&A in the thread and we can
> improve the design as we go forward.
> 
> Stacking rdma device on top of existing rdma device as an ib_client so
> that rdma bond device exactly aware of what is going on with slaves and
> bond netdev.

How do you safely proxy every single op from the bond to slaves?

How do you force the slaves to allow PDs to be shared across them?

What provider lives in user space for the bond driver? What happens to
the udata/etc?

And it doesn't solve the main problem you raised, creating a IB device
while holding RTNL simply should not ever be done. Moving this code
into the core layer fixed it up significantly for the similar rxe/siw
cases, I expect the same is possible for the LAG situation too.

Jason
