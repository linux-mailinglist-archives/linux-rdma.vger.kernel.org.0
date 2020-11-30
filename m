Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F272D2C88AD
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Nov 2020 16:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgK3P41 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Nov 2020 10:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbgK3P41 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Nov 2020 10:56:27 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADEBC0613CF
        for <linux-rdma@vger.kernel.org>; Mon, 30 Nov 2020 07:55:47 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id t5so8477395qtp.2
        for <linux-rdma@vger.kernel.org>; Mon, 30 Nov 2020 07:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CjVLOOEtBqUtB/09GI5wIXC8/zFmYYrYUeLfPULXHCc=;
        b=XDk9ObBj653+EScMyll6sJbalbBB5wbOv1Zw6deoHHA575dMosxoGicwjijLY0xijn
         kIVb3ixHJDRvYuYYMkMueqhqAVGJyQ3OxMdaunwzXkjUjlJNvHmB3eWhfy05oO/Sl5KY
         kqb25dIKw0YXdHqAuhDJbuCDOMruvl3AV4Br0hb8RJU3klkO6Ymmhj4GnZ7UekUbYOtb
         AkkBDF34E/wwgltfeKyT2YXSUckHOTV5ngHJ67T8C1lEDNelROFy8PeKxRpQiUtZwuG+
         S4KNaGneyHnkbCXuvmf/zkdajT5fLf5hNdAkoLgmwgYKn2LgrV/61qbJEcZABPea7ar3
         n0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CjVLOOEtBqUtB/09GI5wIXC8/zFmYYrYUeLfPULXHCc=;
        b=I7dfkIJGmBHgqk7GrOfbvPb3Mh20HIwabIf+cR+SZw8OdDIxKh73f2wbjsppvTWD5s
         HNBHeTwNFj5fVCsYU7PiG25T5Sk1Sq0Ewp8BdrvN11bNlwRf1ebodEBzXu6b2oMbM8NT
         j+g4hFIehnj0h99HxdIq5Dkc3LZz/AiaFpj/3A5+bmPOq8CkbcSP5F1OiDKS3mgDATRi
         MWB7Orxluv9lGwaITS+cEB2buSfECeLH1vMNMJNqRoG/L6lOa7fD5uRwEqsiQ8W/IdNJ
         fz3rrC7wg+b7BV6BxHDv7eeBr4w+QXsyfEfaMi45mOE73x4DTq98KsMqXENSYy/tIsij
         +PuQ==
X-Gm-Message-State: AOAM530QxZaSI+geZ7jv4THxpRLLjkLn89Q+LD22GenzNz1XI6RbwUJA
        cpYOt2AsrrZDeD0X3xaAWbUD5A==
X-Google-Smtp-Source: ABdhPJyqY+NbTgrfg0rrr34jfN9FWUEJU+D/A6r+m4+LvoHrlHDw9X08cY6TAx+Zy/fxU5+UavX81w==
X-Received: by 2002:aed:3025:: with SMTP id 34mr22385936qte.39.1606751746458;
        Mon, 30 Nov 2020 07:55:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id v15sm16156986qti.92.2020.11.30.07.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 07:55:45 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kjlWi-0045D3-GJ; Mon, 30 Nov 2020 11:55:44 -0400
Date:   Mon, 30 Nov 2020 11:55:44 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [PATCH rdma-core v3 4/6] pyverbs: Add dma-buf based MR support
Message-ID: <20201130155544.GA5487@ziepe.ca>
References: <1606510543-45567-1-git-send-email-jianxin.xiong@intel.com>
 <1606510543-45567-5-git-send-email-jianxin.xiong@intel.com>
 <20201130145741.GP401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130145741.GP401619@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 30, 2020 at 03:57:41PM +0100, Daniel Vetter wrote:
> > +	err = ioctl(dri->fd, DRM_IOCTL_AMDGPU_GEM_CREATE, &gem_create);
> > +	if (err)
> > +		return err;
> > +
> > +	*handle = gem_create.out.handle;
> > +	return 0;
> > +}
> > +
> > +static int radeon_alloc(struct dri *dri, size_t size, uint32_t *handle)
> 
> Tbh radeon chips are old enough I wouldn't care. Also doesn't support p2p
> dma-buf, so always going to be in system memory when you share. Plus you
> also need some more flags like I suggested above I think.

What about nouveau?

Jason
