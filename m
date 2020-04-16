Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03A01ACF52
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 20:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbgDPSFj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 14:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731040AbgDPSFi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Apr 2020 14:05:38 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A79C061A0C
        for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2020 11:05:38 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l25so22327195qkk.3
        for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2020 11:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fftro3jZbixsL8aeMcmWYxRlcOZc1xYOuCyBw47w/C8=;
        b=Nl5IfyW61dNBvqPmzCjDg2WCgVKn+WFlEvYzGa2/Vrnc/VsdQvuSMtSJLw96V+j4cv
         dejqS2JY8YzSiyRBlm/hUKJgwK0Tzom0hkNIV5ncn9tn6oI8GL9vvyOSS+TwwBl3sWr6
         eB1vfy9a/ugWT7bvmGZ8rswnhmYtjyiewE66r/iz8C0/ifJemhTzwk37NhpK5HVa2mGC
         mct5lE9F2dC0DGY9hSdmw0pKAAp++x4KY85qRRtX7ytHUbEKeNAyxdXTsiSKdER8zo9l
         mDhbSmRmNGo36pfEh+D9rtGp/tvR2jQxxDtegfyWmsNeEflc3I7b5Hqfkgt66pgB08TY
         cBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fftro3jZbixsL8aeMcmWYxRlcOZc1xYOuCyBw47w/C8=;
        b=VNeAyprlM3HfiDes4COa728tvMhE7Oe706ejPQ1NepVSx8+1UBboddsFMzX8P+R92q
         MY2aFdA+eOy0PcDbk4B207itl1XSaCpmqIpwHIFvjQGjN2pJxuWqY2D2KObtk+p5l1UY
         5w6BSfzJnqv7wjZYatdcK7PgBanQTj64IH6/y4VHz0BYKEshuPFLjlMeS/aLjjRx0+hN
         awYhoop9XbGkbS/iZmTsrhFNqRhb/Yfjxy94n6wiSBaUasVMSmnPaknFsxLp6nH6RqNe
         EYEeD+mfrVZBiEL/nmFYT05xgbECMPG4rMjgPF9jdDAEh8/+ba56mAyCUHrff1StDsfR
         PbuA==
X-Gm-Message-State: AGi0PuZKCl/g7QCwXb9zaoEi2QjGBRkRy8Fbegk8FVAFwoaCKY4GRcNP
        ED6LeNsGHRQaQwFdye3HmaljkA==
X-Google-Smtp-Source: APiQypJriZ2ts89EQA9ZmbRGIKxW4OALaXNJVu4hOm4BVdrkDvh3k+fSMcXaWS8jrdSR/LMHDO1tYg==
X-Received: by 2002:a37:8741:: with SMTP id j62mr30990828qkd.441.1587060337403;
        Thu, 16 Apr 2020 11:05:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n185sm6205781qke.82.2020.04.16.11.05.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Apr 2020 11:05:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jP8tM-00069t-Dc; Thu, 16 Apr 2020 15:05:36 -0300
Date:   Thu, 16 Apr 2020 15:05:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nico@fluxnic.net" <nico@fluxnic.net>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kieran.bingham+renesas@ideasonboard.com" 
        <kieran.bingham+renesas@ideasonboard.com>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>
Subject: Re: [RFC 0/6] Regressions for "imply" behavior change
Message-ID: <20200416180536.GW5100@ziepe.ca>
References: <20200414152312.GF5100@ziepe.ca>
 <CAK8P3a1PjP9_b5NdmqTLeGN4y+3JXx_yyTE8YAf1u5rYHWPA9g@mail.gmail.com>
 <f6d83b08fc0bc171b5ba5b2a0bc138727d92e2c0.camel@mellanox.com>
 <CAK8P3a1-J=4EAxh7TtQxugxwXk239u8ffgxZNRdw_WWy8ExFoQ@mail.gmail.com>
 <834c7606743424c64951dd2193ca15e29799bf18.camel@mellanox.com>
 <CAK8P3a3Wx5_bUOKnN3_hG5nLOqv3WCUtMSq6vOkJzWZgsmAz+A@mail.gmail.com>
 <874ktj4tvn.fsf@intel.com>
 <CAK8P3a1S2x1jnx9Q5B22vX8gBHs0Ztu-znA9hqZ5xp5tRAykGg@mail.gmail.com>
 <20200416145235.GR5100@ziepe.ca>
 <CAK8P3a3HwFYKfZftm2fWE=Lzi486rXpMBwjy1F4oohYU2+o7-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3HwFYKfZftm2fWE=Lzi486rXpMBwjy1F4oohYU2+o7-g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 16, 2020 at 05:58:31PM +0200, Arnd Bergmann wrote:
> On Thu, Apr 16, 2020 at 4:52 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Thu, Apr 16, 2020 at 02:38:50PM +0200, Arnd Bergmann wrote:
> > > On Thu, Apr 16, 2020 at 12:17 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > > > Of course, this is all just talk until someone(tm) posts a patch
> > > > actually making the change. I've looked at the kconfig tool sources
> > > > before; not going to make the same mistake again.
> > >
> > > Right. OTOH whoever implements it gets to pick the color of the
> > > bikeshed. ;-)
> >
> > I hope someone takes it up, especially now that imply, which
> > apparently used to do this, doesn't any more :)
> 
> The old 'imply' was something completely different, it was more of a
> 'try to select if you can so we can assume it's there, but give up
> if it can only be a module and we need it to be built-in".

But it seems to have done this as a side-effect, and drivers were
relying on that, otherwise this series wouldn't exist..

Jason
