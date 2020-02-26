Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54BED1705A2
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2020 18:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgBZRJt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Feb 2020 12:09:49 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41174 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgBZRJt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Feb 2020 12:09:49 -0500
Received: by mail-qk1-f196.google.com with SMTP id b5so97170qkh.8
        for <linux-rdma@vger.kernel.org>; Wed, 26 Feb 2020 09:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ziSDGSLWDgcIEb0rOcA6gyMUFaQKB2SngFXxZv1iHlM=;
        b=HbdB99CYoL21m/WJct9uFJ+4se606l/CxlUVghYJ1ePPax9Gs9H5kS1I7+NAtt0j63
         m1LvkWACeKU7kRvcppZvSFBCbyfE9i7s7G9Apa1yZ7MzNfM6p0t7GQ6KJB61LoNwVSku
         oR7Cu4YbSaKgpb2mhKxomNMVrFK6t7Qw97BmOnvWHgac9cRQeOC+D18wZXyWYD/WfmhQ
         dYkaRnLsnUY2SC0OY0AKhV3vll2Wj3N8lLcYZ/EnR+FNK2y6FtHcvUHqM1oMJ31N5CHu
         3XueW6ml0V/Agngv2BngnujB2zLBXN3ZS5DbGsu+QhRr+mzNC2fBIC11x/PjJMl5OhM4
         rntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ziSDGSLWDgcIEb0rOcA6gyMUFaQKB2SngFXxZv1iHlM=;
        b=svQ+bNCnr80D8eTbww0is/yrIf2IgdT45xk7WGQknO931qOM+IhjENzexL3c+IsEa4
         BdDu4uGfuQk/uVnDVb92ozBgy3PPUbwpKE4ZZ+9A0h0NktSOK7kzp2JFYnxlHzHOtfTB
         zJ8W+zWhIGE94aNGej1Akyh97Sx9rKPz7wCzX1ey1C1hIyvBO9dlw6IULh1JvwFGlZHj
         X1GwoROI9S+bCmWqrxTloaWOmkj99xgRgRxdW3Uofi+uOBXopSn6LdTkgmlY1r7vTrxi
         vx5acFOstdw28Si2FzH97p3tIMk5KdOudLKynzdfJk5xeSMBXbJBeUsUakpJBU/3J0uY
         +BXg==
X-Gm-Message-State: APjAAAUxp7B2q7ZOmYPVjAyqJAPnxunesc1HqAITF8MVDYXv5Nl+U1Ho
        +He8iyAfH6GIo1zBlJHMQhOtnw==
X-Google-Smtp-Source: APXvYqzNeaCATb+rsZ0yigu34G1wLaS+Dyzo+InY0Et9SBCVsJA7LWqWHgqUSv7QmAT2XFQqwQrswQ==
X-Received: by 2002:a37:5285:: with SMTP id g127mr52792qkb.315.1582736987306;
        Wed, 26 Feb 2020 09:09:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 65sm1410073qtf.95.2020.02.26.09.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Feb 2020 09:09:46 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j70Bu-0004L4-G1; Wed, 26 Feb 2020 13:09:46 -0400
Date:   Wed, 26 Feb 2020 13:09:46 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Haim Boozaglo <haimbo@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: "ibstat -l" displays CA device list in an unsorted order
Message-ID: <20200226170946.GA31668@ziepe.ca>
References: <2b43584f-f56a-6466-a2da-43d02fad6b64@mellanox.com>
 <20200224194131.GV31668@ziepe.ca>
 <d3b6297e-3251-ec14-ebef-541eb3a98eae@mellanox.com>
 <20200226134310.GX31668@ziepe.ca>
 <20200226135749.GE12414@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226135749.GE12414@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 26, 2020 at 03:57:49PM +0200, Leon Romanovsky wrote:
> On Wed, Feb 26, 2020 at 09:43:10AM -0400, Jason Gunthorpe wrote:
> > On Tue, Feb 25, 2020 at 10:25:49AM +0200, Haim Boozaglo wrote:
> > >
> > >
> > > On 2/24/2020 9:41 PM, Jason Gunthorpe wrote:
> > > > On Mon, Feb 24, 2020 at 08:06:56PM +0200, Haim Boozaglo wrote:
> > > > > Hi all,
> > > > >
> > > > > When running "ibstat" or "ibstat -l", the output of CA device list
> > > > > is displayed in an unsorted order.
> > > > >
> > > > > Before pull request #561, ibstat displayed the CA device list sorted in
> > > > > alphabetical order.
> > > > >
> > > > > The problem is that users expect to have the output sorted in alphabetical
> > > > > order and now they get it not as expected (in an unsorted order).
> > > >
> > > > Really? Why? That doesn't look like it should happen, the list is
> > > > constructed out of readdir() which should be sorted?
> > > >
> > > > Do you know where this comes from?
> > > >
> > > > Jason
> > > >
> > >
> > > readdir() gives us struct by struct and doesn't keep on alphabetical order.
> > > Before pull request #561 ibstat have used this API of libibumad:
> > > int umad_get_cas_names(char cas[][UMAD_CA_NAME_LEN], int max)
> > >
> > > This API used this function:
> > > n = scandir(SYS_INFINIBAND, &namelist, NULL, alphasort);
> > >
> > > scandir() can return a sorted CA device list in alphabetical order.
> >
> > Oh what a weird unintended side effect.
> >
> > Resolving it would require adding a sorting pass on a linked
> > list.. Will you try?
> 
> Please be aware that once ibstat will be converted to netlink, the order
> will change again.

This is why I suggest a function to sort the linked list that tools
needing sorted order can call. Then it doesn't matter how we got the list

Jason
