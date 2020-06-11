Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423211F6437
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2020 11:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgFKJDu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jun 2020 05:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgFKJDt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jun 2020 05:03:49 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CD6C08C5C1
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2020 02:03:48 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f185so4263659wmf.3
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2020 02:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=611EZXoXvMC0wgvkSoDqQkuDX4b96jfM5TQTQEW07+g=;
        b=rBu3ZBBsiU7BegTaLT92EmVcTqTQ1ln4TngPt+QtaRUJwZJvFNvlbvL3HcjTBtXw9H
         G1BFGLxRjII2qe+n6Wb4wAjp/MIbndhkzRvvFKrM4W8lQT+ibssLtH8TT46cMB5P5uU3
         5NUykMXB6wJxIim5uZLsueE9Lb1sMJwsx7fkaWRSDcEwhKWAYhiGyzIwnkpl/z6oq0Or
         4x+BtmbF9c7Gs6DTj+RsOX7oSNj6Q0tkv5onPLhaBIsEtG4yxV9T70vq8ePrXAlDNpD8
         5sB2zFwst0zY2C9XYIlAcPCJ2JUIt9V9Hjz4+vjSenZxVun25fMG+8FtkYQcjlFwLPq+
         dTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=611EZXoXvMC0wgvkSoDqQkuDX4b96jfM5TQTQEW07+g=;
        b=oZaLWkHXJcD4H/O+7cdTiCvfALR1mkunbhky2aKcJIUb7NUtc4WrOObXtCsMrK4G85
         GFSypYUtmwIpVLtbaxC8PK9x7b+dCI+l+grG3X//+X5j1Kl2bYpMjnNhkMch9EbbXY4M
         MTlcRIbvn/0IhBpebDpagxpIyDUIDdHMN5zUq+YS/5UybtcfXpZuSJFufrge5iRoGqPI
         /z9GYBiIcOpNp2DaHLnZxyYqpwVVnAqoauU48gMmjiT5yUy1H/5KHC5edIaIzf21i9lB
         R/pJZE2LshdgoQordqRj0Pjox0L2AQe9Kuc0tVZZlGxmEhdtYFOERMqzv5bJQw8iMgzJ
         y6LQ==
X-Gm-Message-State: AOAM533hY/7dN+hwZrGVevY62OeIip12nGPUmzC6feMPzDdgLSUd7bWd
        Fx82mZZZlCpZPrIb1eqwTCKDIiysZPmq/Xq5CuaFNA==
X-Google-Smtp-Source: ABdhPJxPKKxxiM1BfEdkh9RUDLtOEwohJAfgWmxAu+vR7pTgkQ6fdURfjYcm3A4r4/Ejum+DBwaGettYUqKJ7IOPnc8=
X-Received: by 2002:a1c:6a01:: with SMTP id f1mr6984797wmc.52.1591866227178;
 Thu, 11 Jun 2020 02:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-4-daniel.vetter@ffwll.ch> <159186243606.1506.4437341616828968890@build.alporthouse.com>
 <CAPM=9ty6r1LuXAH_rf98GH0R9yN3x8xzKPjZG3QyvokpQBR-Hg@mail.gmail.com>
In-Reply-To: <CAPM=9ty6r1LuXAH_rf98GH0R9yN3x8xzKPjZG3QyvokpQBR-Hg@mail.gmail.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Thu, 11 Jun 2020 10:01:46 +0100
Message-ID: <CAPj87rM0S2OPssf+WA+pjanT-0Om3yuUM1zUJCv4qTx5VYE=Fw@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH 03/18] dma-fence: basic lockdep annotations
To:     Dave Airlie <airlied@gmail.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

On Thu, 11 Jun 2020 at 09:44, Dave Airlie <airlied@gmail.com> wrote:
> On Thu, 11 Jun 2020 at 18:01, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> > Introducing a global lockmap that cannot capture the rules correctly,
>
> Can you document the rules all drivers should be following then,
> because from here it looks to get refactored every version of i915,
> and it would be nice if we could all aim for the same set of things
> roughly. We've already had enough problems with amdgpu vs i915 vs
> everyone else with fences, if this stops that in the future then I'd
> rather we have that than just some unwritten rules per driver and
> untestable.

As someone who has sunk a bunch of work into explicit-fencing
awareness in my compositor so I can never be blocked, I'd be
disappointed if the infrastructure was ultimately pointless because
the documented fencing rules were \_o_/ or thereabouts. Lockdep
definitely isn't my area of expertise so I can't comment on the patch
per se, but having something to ensure we don't hit deadlocks sure
seems a lot better than nothing.

Cheers,
Daniel
