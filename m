Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA752C89A8
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Nov 2020 17:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgK3Qhb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Nov 2020 11:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgK3Qhb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Nov 2020 11:37:31 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A0BC0613D3
        for <linux-rdma@vger.kernel.org>; Mon, 30 Nov 2020 08:36:45 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id y197so11350707qkb.7
        for <linux-rdma@vger.kernel.org>; Mon, 30 Nov 2020 08:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AaUf3CG+RcFh5tQVVsIeq45Vx/zPTvtcS7i+yqcSjjA=;
        b=NnABYn11On6vtQH6QKY/nfOi/tUVS5UiwT/xWZ5Tv2LttGw0LpcBdqycsgwmWK5igN
         am/SPBqXu98E42iWH/WFBVZRJRwj72LLAXPxZikCzprhFVe66LowfbsoozS3V+JynyJ4
         OCUSgn0CEvKx/PA3xL9T9Dhp36tXVXzNZsFT3h+ntYnQgAj4Z+DwpHbx981LR5Ey1oiQ
         ziTDd169OcXkIq8IUWzKFc2m0H1B1S8dcZ9yvh6elRCxTUwPsF3gt5qaAlp4UxeGtSj5
         87LoSlLgzro8oxxBG9YeEzsqBvDFJJQPYAg4N0HFECAj4WcJL9CfUYUncZMVY4eQ95Fc
         +gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AaUf3CG+RcFh5tQVVsIeq45Vx/zPTvtcS7i+yqcSjjA=;
        b=Gg4MGfpjYSyEtX5+dIjz08qGMKuhLpATIfQT3Px8bFwmiY/JjItcI89eAd7w4rmKq9
         5nZlHUbPHlSMVJUMR8QcINnxnWpc58RkmI93A4BdXR7IcBnp8T2qFcN9s+y+mBvGQ1la
         mZgXinzGf53Ebwnwgn9UkFh8IYKTKpVr7yJn1zEpPGkJtMhpQpVoKiQhmFnEoH+sCOQY
         jAGyngg5JBiU6kRqnd7i7Br+2m/GlpToLpsIo7aFlbqBNk2jxyshyr2AQ5ndUDSaxkW6
         d14X7VSrIwrko/gpDIWwOj6iJWiHJzp93NQM7ElslVmyfuYWoPKtWcdH87egnlRhsml6
         F/6A==
X-Gm-Message-State: AOAM5321jxLDIgV66st16kc/D9tjxjc6rWn0of25k6olC4G0Y8QlzaHo
        h6KJVkEqw47/qaIi5IhClqIBug==
X-Google-Smtp-Source: ABdhPJzKNsp23aBi+eRv4c7tD+vWJaHBuGaIlVVwlleyqUuVecTg9HKnJ2+POP36Rxb98/cP/vFoBg==
X-Received: by 2002:a37:b302:: with SMTP id c2mr17538090qkf.166.1606754204209;
        Mon, 30 Nov 2020 08:36:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id n21sm16948269qke.21.2020.11.30.08.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 08:36:43 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kjmAN-0045yW-01; Mon, 30 Nov 2020 12:36:43 -0400
Date:   Mon, 30 Nov 2020 12:36:42 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [PATCH rdma-core v3 4/6] pyverbs: Add dma-buf based MR support
Message-ID: <20201130163642.GC5487@ziepe.ca>
References: <1606510543-45567-1-git-send-email-jianxin.xiong@intel.com>
 <1606510543-45567-5-git-send-email-jianxin.xiong@intel.com>
 <20201130145741.GP401619@phenom.ffwll.local>
 <20201130155544.GA5487@ziepe.ca>
 <20201130160443.GV401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130160443.GV401619@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 30, 2020 at 05:04:43PM +0100, Daniel Vetter wrote:
> On Mon, Nov 30, 2020 at 11:55:44AM -0400, Jason Gunthorpe wrote:
> > On Mon, Nov 30, 2020 at 03:57:41PM +0100, Daniel Vetter wrote:
> > > > +	err = ioctl(dri->fd, DRM_IOCTL_AMDGPU_GEM_CREATE, &gem_create);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	*handle = gem_create.out.handle;
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int radeon_alloc(struct dri *dri, size_t size, uint32_t *handle)
> > > 
> > > Tbh radeon chips are old enough I wouldn't care. Also doesn't support p2p
> > > dma-buf, so always going to be in system memory when you share. Plus you
> > > also need some more flags like I suggested above I think.
> > 
> > What about nouveau?
> 
> Reallistically chances that someone wants to use rdma together with the
> upstream nouveau driver are roughly nil. Imo also needs someone with the
> right hardware to make sure it works (since the flags are all kinda arcane
> driver specific stuff testing is really needed).

Well, it would be helpful if we can test the mlx5 part of the
implementation, and I have a lab stocked with nouveau compatible HW..

But you are right someone needs to test/etc, so this does not seem
like Jianxin should worry

Jason
