Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6034A2B25AF
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Nov 2020 21:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgKMUlf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Nov 2020 15:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgKMUlf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Nov 2020 15:41:35 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD32C0613D1
        for <linux-rdma@vger.kernel.org>; Fri, 13 Nov 2020 12:41:34 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id u12so4326013wrt.0
        for <linux-rdma@vger.kernel.org>; Fri, 13 Nov 2020 12:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L5e4DIZV3VJ4/DZhaxMedvf932BuCNS+uWtVsQlOpwI=;
        b=XxNPjkbmXf7MCgGcE/QgflUYbsN17qETnpKjYFS9Tmq8Ug+Eh73nfFd9TdzkCf9AE2
         oXqwEtnOGsYB3/Qkqvm7ruzS2MjUIY3aaFb/sI8NiY9wk+1Z71m9h2JfZmeR80VoBtTg
         7iQXDKjWZq5LlUw07orJj+TOP6gH4hHKFOli0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L5e4DIZV3VJ4/DZhaxMedvf932BuCNS+uWtVsQlOpwI=;
        b=Wti74QJBC1abKFYpupi/kRhwn+mA6zie5QLfeTiBOQhe0gU++dfzf7Qt1n0DVHwonP
         ytuVXgMdWgEVrHQ/Y8Nfzg9BmRhltDYDr5NvNGh8xElB2dBrDwVXpyAkBKz6iBwYn/Uu
         7zVDOx/0UaRG9wJpuzUCnPswCaLH9qip3MLgJfT+S1Qpu3DdMvNFLLRUwxeMc0dWjt7j
         kULRuZiAEdKvt7NS82DSnNfPcSSb4B/H2iApWhM13zkAEsEWw410K/SBzQbX6QtVnslo
         bZp+UkB9ySMSxogMq0JmdGDmVpNUp02Jz1fkUywhV+hpLwCqeHmnGZL6oocvtzEG7UnD
         xDjQ==
X-Gm-Message-State: AOAM530lqTLr2+TGtE1RhsfFZCtEgjlOzV7MVyjCYWBD7cps9PzdHDg7
        S4VQsvpeVOYGdqknUM5vvgpfKA==
X-Google-Smtp-Source: ABdhPJy+vZyBmSoL9CBj+APp8QgyaRgbuZ4I7P5mhruXWGfad54Kzai82pflGZdDNk9mmE7+FVR9aA==
X-Received: by 2002:a5d:4cca:: with SMTP id c10mr5895092wrt.372.1605300092835;
        Fri, 13 Nov 2020 12:41:32 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o63sm11571531wmo.2.2020.11.13.12.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 12:41:32 -0800 (PST)
Date:   Fri, 13 Nov 2020 21:41:30 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [PATCH v10 6/6] dma-buf: Document that dma-buf size is fixed
Message-ID: <20201113204130.GU401619@phenom.ffwll.local>
References: <1605044477-51833-1-git-send-email-jianxin.xiong@intel.com>
 <1605044477-51833-7-git-send-email-jianxin.xiong@intel.com>
 <20201111163323.GP401619@phenom.ffwll.local>
 <20201112132514.GR244516@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112132514.GR244516@ziepe.ca>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 12, 2020 at 09:25:14AM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 11, 2020 at 05:33:23PM +0100, Daniel Vetter wrote:
> > On Tue, Nov 10, 2020 at 01:41:17PM -0800, Jianxin Xiong wrote:
> > > The fact that the size of dma-buf is invariant over the lifetime of the
> > > buffer is mentioned in the comment of 'dma_buf_ops.mmap', but is not
> > > documented at where the info is defined. Add the missing documentation.
> > > 
> > > Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
> > 
> > Applied to drm-misc-next, thanks for your patch. For the preceeding
> > dma-buf patch I'll wait for more review/acks before I apply it. Ack from
> > Jason might also be good, since looks like this dma_virt_ops is only used
> > in rdma.
> 
> We are likely to delete it entirely this cycle, Christoph already has
> a patch series to do it:
> 
> https://patchwork.kernel.org/project/linux-rdma/list/?series=379277
> 
> So, lets just forget about it

I can get behind that :-) Also I realized that even when we need it,
probably best if you merge it to avoid a partially broken feature in the
rdma tree. So not my problem anyway ...

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
