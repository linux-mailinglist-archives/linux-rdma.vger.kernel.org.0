Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7570D1B5E9C
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 17:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgDWPGD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 11:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728878AbgDWPGA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 11:06:00 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29C4C08E934
        for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2020 08:05:58 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id fb4so3009834qvb.7
        for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2020 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zc2RuJG+E2+4TamJRI8Bv/UYisP7AVTkwnNZjUmbgck=;
        b=W9Z2Sq4/1SQQqjT4ehzpodampIzNO11tWTR2bOJ5Scxv7AoliJfPHi6YEJJzz2u/B+
         BJOCWEFn7b1OwSecxvRATeV2vfj74grYnlYtbgDT3D2O2Ik/pvxDgUnoMSknT9diq8hm
         fw5Nv/O2M8WKsUmp4k5JgRQY9U0TwL4t8eUR0MhvJo0L4O5WE85ck4BTCrjxBNs2ec3m
         Lq5qvMNOwcQyuPky1TXPtT6/kFhuwjSHzh8SQTEcytYtSsSw4eb2IDtuqFDv5X4tI16P
         alF+8PnqZgPdaJubC0iDV/pQkk1OdPkAi1SYRdxZyctq0Squpr23MmtOucFrJuXBgMHr
         KlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zc2RuJG+E2+4TamJRI8Bv/UYisP7AVTkwnNZjUmbgck=;
        b=bFZSVvo54V6ErLkXQSqa6ZgJkqZI9TZh/fAJJf++n5ZqGnmVuDiE5ssfIBSCRwMxKA
         VRdJqc5jxzDPr6CbNLUJjkSG1YGBgZk0ZWNHK/bhfpN/kbUTiLu/ujgfY8+/xVTVUI+0
         cbb41JfxNu/M2RrdcEMpaKi/EjjZkS0Kk+yTLq38p3sTkEP/aoBS5B1Qp6MwYG/b9TPp
         LWD2hYIHhNs7wTd/lKlM/5dNkEzCz/IfoknfsJV8X+ptSJ/Ynm3jbOZuW9dCI5EnYvX3
         Ky5MxBR5vVxBYQgsWHsLMP9jr8XnW1WadB6jzPhko8EWQEUxiOKBZcM0ruXsUAVktrKY
         ZFvg==
X-Gm-Message-State: AGi0PubRYKL+fO/yKP/JEqYsM+jyHD01rcEML/ZU1Ad5/cqL84CnDcCW
        79joQQWgJylSkOvOfSiA0m31IA==
X-Google-Smtp-Source: APiQypJKp5yz55pfWs4zALFblkF3bu5PrTjuV4Sybqnw2ul0xRXyMtBn4EEnV1Tzf7oUBdkQI2pMNA==
X-Received: by 2002:ad4:44ab:: with SMTP id n11mr4639727qvt.235.1587654358068;
        Thu, 23 Apr 2020 08:05:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p24sm1910939qtp.59.2020.04.23.08.05.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Apr 2020 08:05:57 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jRdQL-0003UI-0h; Thu, 23 Apr 2020 12:05:57 -0300
Date:   Thu, 23 Apr 2020 12:05:57 -0300
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
Message-ID: <20200423150556.GZ26002@ziepe.ca>
References: <CAK7LNATmPD1R+Ranis2u3yohx8b0+dGKAvFpjg8Eo9yEHRT6zQ@mail.gmail.com>
 <87v9lu1ra6.fsf@intel.com>
 <45b9efec57b2e250e8e39b3b203eb8cee10cb6e8.camel@mellanox.com>
 <nycvar.YSQ.7.76.2004210951160.2671@knanqh.ubzr>
 <62a51b2e5425a3cca4f7a66e2795b957f237b2da.camel@mellanox.com>
 <nycvar.YSQ.7.76.2004211411500.2671@knanqh.ubzr>
 <871rofdhtg.fsf@intel.com>
 <nycvar.YSQ.7.76.2004221649480.2671@knanqh.ubzr>
 <940d3add-4d12-56ed-617a-8b3bf8ef3a0f@infradead.org>
 <nycvar.YSQ.7.76.2004231059170.2671@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.2004231059170.2671@knanqh.ubzr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 23, 2020 at 11:01:40AM -0400, Nicolas Pitre wrote:
> On Wed, 22 Apr 2020, Randy Dunlap wrote:
> 
> > On 4/22/20 2:13 PM, Nicolas Pitre wrote:
> > > On Wed, 22 Apr 2020, Jani Nikula wrote:
> > > 
> > >> On Tue, 21 Apr 2020, Nicolas Pitre <nico@fluxnic.net> wrote:
> > >>> This is really a conditional dependency. That's all this is about.
> > >>> So why not simply making it so rather than fooling ourselves? All that 
> > >>> is required is an extension that would allow:
> > >>>
> > >>> 	depends on (expression) if (expression)
> > >>>
> > >>> This construct should be obvious even without reading the doc, is 
> > >>> already used extensively for other things already, and is flexible 
> > >>> enough to cover all sort of cases in addition to this particular one.
> > >>
> > >> Okay, you convinced me. Now you only need to convince whoever is doing
> > >> the actual work of implementing this stuff. ;)
> > > 
> > > What about this:
> > > 
> > > Subject: [PATCH] kconfig: allow for conditional dependencies
> > > 
> > > This might appear to be a strange concept, but sometimes we want
> > > a dependency to be conditionally applied. One such case is currently
> > > expressed with:
> > > 
> > > 	depends on FOO || !FOO
> > > 
> > > This pattern is strange enough to give one's pause. Given that it is
> > > also frequent, let's make the intent more obvious with some syntaxic 
> > > sugar by effectively making dependencies optionally conditional.
> > > This also makes the kconfig language more uniform.
> > > 
> > > Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> > 
> > Hi,
> > 
> > If we must do something here, I prefer this one.
> > 
> > Nicolas, would you do another example, specifically for
> > CRAMFS_MTD in fs/cramfs/Kconfig, please?
> 
> I don't see how that one can be helped. The MTD dependency is not 
> optional.

Could it be done as 

config MTD
   depends on CRAMFS if CRAMFS_MTD

?

Jason
