Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35191C79BC
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 20:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbgEFS5j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 14:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgEFS5j (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 May 2020 14:57:39 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A17C061A0F
        for <linux-rdma@vger.kernel.org>; Wed,  6 May 2020 11:57:39 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id dn1so1360007qvb.3
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2020 11:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YkrQZyF1C2vowmT5vUlAUl1cqi2kZrk4F+3fXxVRE00=;
        b=P2mr//BBq47TtHMzIljLFgeF8pDdXdOSJT0hKPYIDNAGa2XpMmHqZR2t8IAvIjX0Gr
         rPigzwaRGhG5E1IYZJZtZ18Ujj5yoEz+dgmKHng2Cv4yFXkMggsnHzmJiJolgvvTZiMu
         mrqnYPvew+3b8qG3qsZ+Kc+V13zLhu8dnUMCMxVvR8BFCWNvJlVWe1YKYrp8WNdo6wR7
         Dxh7U9LXfrD1xnqyU3DZY+jZAC6X2bmTF5NGy/tqiREttywJkSL9vDNRehc8I1AIATQ0
         0mtk/S96cRiLCjPa0KuaX4qP++DlFzLMmZTjEfOTvKV79BsWd0jO3erO9woK967H0Rk9
         WxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YkrQZyF1C2vowmT5vUlAUl1cqi2kZrk4F+3fXxVRE00=;
        b=Jy63sQX/ZrSjRxWK/bNkkr44TWr4cjf782nB75sOCzUrMO4fWgIqS/tkv31m2OG0Q9
         ZvRr6q6aajQmrj4kGdcaB25XoJJc5soPME8fbIYEicizg1C/sfohrAbWaDDRsdbLARRc
         UUQnM7F3iCUgkzRm690RdLwD3S2FqncAWhrbcv3R5o4Fz/az0+vQSsUqD5+TGerst/0P
         AeW78XXx8IEW3HL4QDe1WOsrOEVMw2Ba2hcCi9PtHsx8zP2C3Hox4nGh5MCuCatjYQgI
         wG49q9KfFEAWtlKZHxI/wFJP409vFLxUfOEGerHKJwwDdulM9jrFliPTbAVxvNX+6bSd
         vU0A==
X-Gm-Message-State: AGi0PuZQ3o+TLWtZO8rKHfp/vVc7+eyN3OEq/ADNX3IOoGRsNjH5kWSE
        cZUEvCWKQ/TjYktGeuuhzaZkBA==
X-Google-Smtp-Source: APiQypIN2UdZXotXKH0yi16RaFbCz9EgWEJphylDctjYVKy3f6BXmTDu6i5w8ZJvhWCQN4piCVc8UA==
X-Received: by 2002:ad4:450d:: with SMTP id k13mr9927617qvu.138.1588791458332;
        Wed, 06 May 2020 11:57:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id y140sm2413731qkb.127.2020.05.06.11.57.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 May 2020 11:57:37 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jWPEf-0007ig-9r; Wed, 06 May 2020 15:57:37 -0300
Date:   Wed, 6 May 2020 15:57:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     jackm <jackm@dev.mellanox.co.il>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        ferasda@mellanox.com, mohammadkab@mellanox.com, moshet@mellanox.com
Subject: Re: [PATCH rdma-rc v1] IB/core: Fix potential NULL pointer
 dereference in pkey cache
Message-ID: <20200506185737.GJ26002@ziepe.ca>
References: <20200506053213.566264-1-leon@kernel.org>
 <20200506144344.GA8875@ziepe.ca>
 <20200506165608.GA4600@unreal>
 <20200506180936.GI26002@ziepe.ca>
 <20200506214123.0000121c@dev.mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506214123.0000121c@dev.mellanox.co.il>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 06, 2020 at 09:41:23PM +0300, jackm wrote:
> On Wed, 6 May 2020 15:09:36 -0300
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > > > > +out:
> > > > > +	ib_cache_release_one(device);
> > > > > +	return err;  
> > > >
> > > > ib_cache_release_once can be called only once, and it is always
> > > > called by ib_device_release(), it should not be called here  
> > > 
> > > It doesn't sound right if we rely on ib_device_release() to unwind
> > > error in ib_cache_setup_one(). I don't think that we need to return
> > > from ib_cache_setup_one() without cleaning it.  
> > 
> > We do as ib_cache_release_one() cannot be called multiple times
> > 
> > The general design of all this pre-registration stuff is that the
> > release function does the clean up and the individual functions should
> > not error unwind cleanup done in the unconditional release.
> > 
> > Other schemes were too complicated
> > 
> > Jason
> 
> What about calling gid_table_release_one(device) instead of
> ib_cache_release_one(device) in the error flow ?

Why?

That is not the design, everything that is freed by release is defered
to release, even on error paths.

Jason
