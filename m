Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A535F1B5EE3
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 17:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgDWPQ1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 11:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729011AbgDWPQ1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 11:16:27 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC00C09B040
        for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2020 08:16:26 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id m67so6680532qke.12
        for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2020 08:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RuwvuXrV7STsC2XSTWZguPreMY6qFyucfZMv6dyCZ9g=;
        b=L1nG+W+9ij6Dmdui58Miqo8Hh4qEFLkqwCmLJxQxFoePYWrMwKGNzaxr4E80FZkNCe
         hQY0MtIjCD3biwbp2usIhc/bG/mliQ/SqZ0McDel88WUP76y2ZGdmL7PMNp0PaHNo0rl
         MKaRM6WGmnlovhV+jkviMk0Md8xSeIBeyYs3Jhj1MboZsVxSy5Z6KFdWQkuMOmJMkHPs
         xPJ9WRJzN1iFHYZg9vn/CoYF58u7O3qGIJsDg9NbskJH9YenhnG+h/m1F2YovvkdJuHM
         TlIy/oK9hmHrgClqupcDFQjiLPAX4CZbEe2orbnKjAJwMTc7eueUgAjkgMriugvWA7bZ
         9BvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RuwvuXrV7STsC2XSTWZguPreMY6qFyucfZMv6dyCZ9g=;
        b=EkUpL+QGdcjPWRFeLoZUuMSVTQUcQs9OfgzaPi6v8AWq5ZwEIcpQzxiRVgw7a3tJoS
         rlhBA+6InbCECowKvDSqWpzGNChjesVXf3JXzrtZJ2fmptdEd/v9kzJNm9XpB8oZfpkX
         PE0BP86Xmne+wseMNn7kg3HgOvp7bjSQakH4HQw2F87D4TxJP8a4Qs9t1rOnYtzp9Ii5
         dxORSzD7pxm+sI95f70mZJGveU1DhNMy76/0E6lKcTQMNwuzqVLi6tc0pNKzpgqvKhDj
         3ZzkEd857leHSjJAH9q1Kxsh3Zau2qBp3unuaAbW56iYnIwO/DqqBNxDHWtre6bOM7Tl
         xf3A==
X-Gm-Message-State: AGi0PuZeZxcGI40F00maOOdY4USr7/A9HKXeLQ2kI1udU9sMYaF70ZMJ
        pvUSlcZOQ/5qcXVhyB5UVLdmcA==
X-Google-Smtp-Source: APiQypJiqOT4fipFLUGohNv7Deb1s+6ID4GDzmCNpgpgqR/iKAnZEgmnnLbZQ13uR71Jym2saStjag==
X-Received: by 2002:a37:9dd6:: with SMTP id g205mr4268266qke.9.1587654985482;
        Thu, 23 Apr 2020 08:16:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id a22sm1663046qko.81.2020.04.23.08.16.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Apr 2020 08:16:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jRdaS-0003hD-Gu; Thu, 23 Apr 2020 12:16:24 -0300
Date:   Thu, 23 Apr 2020 12:16:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "kieran.bingham+renesas@ideasonboard.com" 
        <kieran.bingham+renesas@ideasonboard.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [RFC PATCH 1/2] Kconfig: Introduce "uses" keyword
Message-ID: <20200423151624.GA26002@ziepe.ca>
References: <45b9efec57b2e250e8e39b3b203eb8cee10cb6e8.camel@mellanox.com>
 <nycvar.YSQ.7.76.2004210951160.2671@knanqh.ubzr>
 <62a51b2e5425a3cca4f7a66e2795b957f237b2da.camel@mellanox.com>
 <nycvar.YSQ.7.76.2004211411500.2671@knanqh.ubzr>
 <871rofdhtg.fsf@intel.com>
 <nycvar.YSQ.7.76.2004221649480.2671@knanqh.ubzr>
 <940d3add-4d12-56ed-617a-8b3bf8ef3a0f@infradead.org>
 <nycvar.YSQ.7.76.2004231059170.2671@knanqh.ubzr>
 <20200423150556.GZ26002@ziepe.ca>
 <nycvar.YSQ.7.76.2004231109500.2671@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.2004231109500.2671@knanqh.ubzr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 23, 2020 at 11:11:46AM -0400, Nicolas Pitre wrote:
> On Thu, 23 Apr 2020, Jason Gunthorpe wrote:
> 
> > On Thu, Apr 23, 2020 at 11:01:40AM -0400, Nicolas Pitre wrote:
> > > On Wed, 22 Apr 2020, Randy Dunlap wrote:
> > > 
> > > > On 4/22/20 2:13 PM, Nicolas Pitre wrote:
> > > > > On Wed, 22 Apr 2020, Jani Nikula wrote:
> > > > > 
> > > > >> On Tue, 21 Apr 2020, Nicolas Pitre <nico@fluxnic.net> wrote:
> > > > >>> This is really a conditional dependency. That's all this is about.
> > > > >>> So why not simply making it so rather than fooling ourselves? All that 
> > > > >>> is required is an extension that would allow:
> > > > >>>
> > > > >>> 	depends on (expression) if (expression)
> > > > >>>
> > > > >>> This construct should be obvious even without reading the doc, is 
> > > > >>> already used extensively for other things already, and is flexible 
> > > > >>> enough to cover all sort of cases in addition to this particular one.
> > > > >>
> > > > >> Okay, you convinced me. Now you only need to convince whoever is doing
> > > > >> the actual work of implementing this stuff. ;)
> > > > > 
> > > > > What about this:
> > > > > 
> > > > > Subject: [PATCH] kconfig: allow for conditional dependencies
> > > > > 
> > > > > This might appear to be a strange concept, but sometimes we want
> > > > > a dependency to be conditionally applied. One such case is currently
> > > > > expressed with:
> > > > > 
> > > > > 	depends on FOO || !FOO
> > > > > 
> > > > > This pattern is strange enough to give one's pause. Given that it is
> > > > > also frequent, let's make the intent more obvious with some syntaxic 
> > > > > sugar by effectively making dependencies optionally conditional.
> > > > > This also makes the kconfig language more uniform.
> > > > > 
> > > > > Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> > > > 
> > > > Hi,
> > > > 
> > > > If we must do something here, I prefer this one.
> > > > 
> > > > Nicolas, would you do another example, specifically for
> > > > CRAMFS_MTD in fs/cramfs/Kconfig, please?
> > > 
> > > I don't see how that one can be helped. The MTD dependency is not 
> > > optional.
> > 
> > Could it be done as 
> > 
> > config MTD
> >    depends on CRAMFS if CRAMFS_MTD
> > 
> > ?
> 
> No. There is no logic in restricting MTD usage based on CRAMFS or 
> CRAMFS_MTD.

Ah, I got it backwards, maybe this:

config CRAMFS
   depends on MTD if CRAMFS_MTD

?

Jason
