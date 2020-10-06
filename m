Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156A6284FEB
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 18:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJFQe0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 12:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgJFQeZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Oct 2020 12:34:25 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A624C061755
        for <linux-rdma@vger.kernel.org>; Tue,  6 Oct 2020 09:34:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o5so14208017wrn.13
        for <linux-rdma@vger.kernel.org>; Tue, 06 Oct 2020 09:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IQwIiSBu/shWVWC8XNTOg4imG3CzBYBvVpGZ06fvFrE=;
        b=h+NTcOH7LE548gMVTKxDrCvbnM0gjCsoOxsQq8EnBOPN2FjBjvvPnp82HvizwAMI4M
         HJXDXzqDcKAcuIOSzCvRkRHz1hhbZ9Og4jhEqTMKT3MxMZcjLjQpfCXLShF4zrho90H8
         otyo8ifaNvpe/ZXsWLwBv+bWzcXtnNtuzBHHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IQwIiSBu/shWVWC8XNTOg4imG3CzBYBvVpGZ06fvFrE=;
        b=GC7lzW/qB4a+l+VFy2hBoD9ZGn8fZ47+9YzFzSVgvCeT4NvZYZpRR0Fbr4ohw2K0Lc
         bfTF8pi6xsJTuuY8i/LWUM+aWDWqbKkZf5q4CFqKqPHojbcvG6ik2Rm+a8s2gv6MaFtO
         zigAD7zkOO+NdlWoUxkCibJUqCMuJCXuLlTmJENxHnGTlCFbt/zNC17o1DWV1gJQGMRH
         0co+wg/bnTgEm8catrPiqjwCkf76bBFBS31Ge4dC1DUkxuwHTNJ0LBaI2aI11nX5UXl5
         PvPgZPXSRH7usBv7nj9NtCzRr+dvRw6YWC/42Kh4R0JwqundnTWFTfF4hRHgM8scQiXk
         FiTQ==
X-Gm-Message-State: AOAM531hxlwPDzESIIdWxB6MfXAFcY5H5kvXHC+xtkMZB/aLgwMQ5R8P
        oAl345xZN3geD/JLVyFUca6BbPks4lRhkKIT
X-Google-Smtp-Source: ABdhPJwAEbTRD/Tl8B9cQZ5yWXIli073oDxajpejyexueSRaOy4JEy50WWRW8eAr9Alox57L3Vibig==
X-Received: by 2002:adf:cd0e:: with SMTP id w14mr6494980wrm.0.1602002063675;
        Tue, 06 Oct 2020 09:34:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id r3sm3586777wrm.51.2020.10.06.09.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 09:34:22 -0700 (PDT)
Date:   Tue, 6 Oct 2020 18:34:20 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        "Xiong, Jianxin" <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [RFC PATCH v3 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20201006163420.GB438822@phenom.ffwll.local>
References: <1601838751-148544-1-git-send-email-jianxin.xiong@intel.com>
 <1601838751-148544-2-git-send-email-jianxin.xiong@intel.com>
 <20201005131302.GQ9916@ziepe.ca>
 <MW3PR11MB455572267489B3F6B1C5F8C5E50C0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20201006092214.GX438822@phenom.ffwll.local>
 <20201006154956.GI5177@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006154956.GI5177@ziepe.ca>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 06, 2020 at 12:49:56PM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 06, 2020 at 11:22:14AM +0200, Daniel Vetter wrote:
> > 
> > For reinstanting the pages you need:
> > 
> > - dma_resv_lock, this prevents anyone else from issuing new moves or
> >   anything like that
> > - dma_resv_get_excl + dma_fence_wait to wait for any pending moves to
> >   finish. gpus generally don't wait on the cpu, but block the dependent
> >   dma operations from being scheduled until that fence fired. But for rdma
> >   odp I think you need the cpu wait in your worker here.
> 
> Reinstating is not really any different that the first insertion, so
> then all this should be needed in every case?

Yes. Without move_notify we pin the dma-buf into system memory, so it
can't move, and hence you also don't have to chase it. But with
move_notify this all becomes possible.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
