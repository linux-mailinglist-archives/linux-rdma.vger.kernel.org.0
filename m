Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4197F1ADF79
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2020 16:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbgDQOIH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Apr 2020 10:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730868AbgDQOHy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Apr 2020 10:07:54 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A334C061A0C
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2020 07:07:53 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id q31so898044qvf.11
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2020 07:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+LqhOO57sChESg9+cIngyrXtjaLelgEgf+v+L/tbLWk=;
        b=gy59aPv8zMj56Mv03vyLFGLBjHJ7J1u+UArIzN0R+rT72xnw/cutPk5HRKX2d/1xSE
         hKj5WfRwjwgNBiBwpu21u9UkwU1NN7FZGkJLCpxItWEKZUwsINzhO6JPR6PivXLj7MQo
         DzlEdqiF/kNV0iIENDraE2hef4Q3wXijNqzULS2WDLUwm63Q6O7Y1oO0EPjvaSWN7MD0
         AunwqeklzSrYcvc3UTO2x5yR3FPVWYFM74ybRxl3Xmx6E1s4oWCv/m8igVBmhfwOLa12
         kXgIX2z40DDQpn1mBfE7DJmt9RJZ1SuirkW4fEIj9HgNfMqTedHLx/oI8bh09LtR45/s
         R9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+LqhOO57sChESg9+cIngyrXtjaLelgEgf+v+L/tbLWk=;
        b=o1lBZJBPg6qDtghe1gvwnLCmdlQ9PxDbPOzvXl1uzEoCHMtl6vVZFXwwm7d2xxE2Pe
         grrggIJMzeBrORxN5oJ6o8YK6sQQWz9Ns4kSatK2JKeAls9FIctzwJ5lIdJRk0tkhg6w
         ISICFBeTJ1GHa/8wZSXau/WL7qlwrDhS/Nr/xRvv9bwvT8nEyIhERqfBSpsATrrN2Ghh
         hVkixnLtGYc043S5l5VlV4Fvta/UuY1rqpBUvsJR+XVzA6oqHLF4/Dqk3EbTo5dE5S/M
         b+PkjOz7dFJqv5R6xsA3vcxDK0KO0NpbmuOw9ak1NC6gz+qZ4bSK/Cf6w8fM67VlN4Rc
         BAtQ==
X-Gm-Message-State: AGi0PuaOoWKeTvE7KvlhfEAERC8/oD9nTv9wpOfs2lMvtbQUVI0wPcTV
        oxCjK2Ov9My8MWhAZ0i9jjKHzQ==
X-Google-Smtp-Source: APiQypKaGok3DQChb57xxsDjD/Iyacg7EOqm08DjV1CqcQ8BJaa7llQ5QiLWdRU37gbKKcQtu2odUg==
X-Received: by 2002:a0c:b790:: with SMTP id l16mr2844426qve.244.1587132472350;
        Fri, 17 Apr 2020 07:07:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n190sm16749764qkb.93.2020.04.17.07.07.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Apr 2020 07:07:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jPReo-0000hP-VC; Fri, 17 Apr 2020 11:07:50 -0300
Date:   Fri, 17 Apr 2020 11:07:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nicolas Pitre <nico@fluxnic.net>, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, leon@kernel.org,
        kieran.bingham+renesas@ideasonboard.com, jonas@kwiboo.se,
        airlied@linux.ie, jernej.skrabec@siol.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [RFC PATCH 1/2] Kconfig: Introduce "uses" keyword
Message-ID: <20200417140750.GF26002@ziepe.ca>
References: <20200417011146.83973-1-saeedm@mellanox.com>
 <87v9ly3a0w.fsf@intel.com>
 <20200417122827.GD5100@ziepe.ca>
 <87h7xi2oup.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7xi2oup.fsf@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 17, 2020 at 05:01:18PM +0300, Jani Nikula wrote:
> On Fri, 17 Apr 2020, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Fri, Apr 17, 2020 at 09:23:59AM +0300, Jani Nikula wrote:
> >
> >> Which means that would have to split up to two. Not ideal, but
> >> doable.
> >
> > Why is this not ideal?
> >
> > I think the one per line is easier to maintain (eg for merge
> > conflicts) and easier to read than a giant && expression.
> >
> > I would not complicate things further by extending the boolean
> > language..
> 
> Fair enough. I only found one instance where the patch at hand does not
> cut it:
> 
> drivers/hwmon/Kconfig:  depends on !OF || IIO=n || IIO

Ideally this constraint would be expressed as:

   optionally depends on OF && IIO

And if the expression is n then IIO is not prevented from being y.

Ie the code is just doing:

#if defined(CONFIG_OF) && IS_ENABLED(CONFIG_IIO)

Jason
