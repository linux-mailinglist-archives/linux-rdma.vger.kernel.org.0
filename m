Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06112C88E8
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Nov 2020 17:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgK3QF2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Nov 2020 11:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgK3QF2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Nov 2020 11:05:28 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3496C0613D2
        for <linux-rdma@vger.kernel.org>; Mon, 30 Nov 2020 08:04:47 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id g14so16845382wrm.13
        for <linux-rdma@vger.kernel.org>; Mon, 30 Nov 2020 08:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hUdKZqG+MBQgVjLX/RaYLcdlC7dw60MlnSnsYg73uFM=;
        b=e7stisBTTYgGJbftvZr2SNRlmjLaiUdzJk+7gtbklEBqb3KLnxnVQB/730BjHPFz32
         l4in8mnfA7e4XQ1wyui1plg+yD+VkdluSZHVcapEsfqqi3NSwT4HiMY2NoKrQLfKFXMr
         I0is84tZaDNoE1vE2qMMM8TCTqIatSiueURIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hUdKZqG+MBQgVjLX/RaYLcdlC7dw60MlnSnsYg73uFM=;
        b=rhPoBlE6ynJYQIspdT+5y3UQbUqeSnR+DuhxCk3cRR5P3zVfk19NBkDq1eJ4S7R7VW
         Izhx5qxPPGNaaXKtI9MSi0/Tgp0aEc749yaCs1bcRkCgq7ebaTTK7nFfJ21i/X3T5rPi
         PjekbZhC+U37HP9m4raHAsYWKgjmlT2+v6lKwX9i+D3lsy/F7eybCXNF5oVlsR2pf1MC
         yH36RqTGGw5AEq4Y1yvI7zeo6oFCkjvTtDRghZl6Bv2lCjcYVu0oCvYHAFeDarsnGupF
         yMUA7xGqHSxl9BP34ygFV8cGbijQOELgBVMjFJ4oEKjQ8eXBaHueh08TRc2bK+bUd3HM
         m4/w==
X-Gm-Message-State: AOAM530VLFgaqtpjF6tpcPzI0LsB+oHqsPAypUHVwIFZy85syyRm5HZA
        z7zddnQYwLnbSa2MwA8vGZsMsp/4AsPEcA==
X-Google-Smtp-Source: ABdhPJx07DHU1pcxPbHRWqs6J+D07KInp20G+ns7o06Nyi2BleT3uW+cS8+DggNRhHe75Q05qkBl7w==
X-Received: by 2002:adf:f7c2:: with SMTP id a2mr28783961wrq.11.1606752286569;
        Mon, 30 Nov 2020 08:04:46 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id e3sm29276373wro.90.2020.11.30.08.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 08:04:45 -0800 (PST)
Date:   Mon, 30 Nov 2020 17:04:43 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [PATCH rdma-core v3 4/6] pyverbs: Add dma-buf based MR support
Message-ID: <20201130160443.GV401619@phenom.ffwll.local>
References: <1606510543-45567-1-git-send-email-jianxin.xiong@intel.com>
 <1606510543-45567-5-git-send-email-jianxin.xiong@intel.com>
 <20201130145741.GP401619@phenom.ffwll.local>
 <20201130155544.GA5487@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130155544.GA5487@ziepe.ca>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 30, 2020 at 11:55:44AM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 30, 2020 at 03:57:41PM +0100, Daniel Vetter wrote:
> > > +	err = ioctl(dri->fd, DRM_IOCTL_AMDGPU_GEM_CREATE, &gem_create);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	*handle = gem_create.out.handle;
> > > +	return 0;
> > > +}
> > > +
> > > +static int radeon_alloc(struct dri *dri, size_t size, uint32_t *handle)
> > 
> > Tbh radeon chips are old enough I wouldn't care. Also doesn't support p2p
> > dma-buf, so always going to be in system memory when you share. Plus you
> > also need some more flags like I suggested above I think.
> 
> What about nouveau?

Reallistically chances that someone wants to use rdma together with the
upstream nouveau driver are roughly nil. Imo also needs someone with the
right hardware to make sure it works (since the flags are all kinda arcane
driver specific stuff testing is really needed).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
