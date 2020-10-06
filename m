Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED12284F3C
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 17:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJFPt7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 11:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFPt7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Oct 2020 11:49:59 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E72AC061755
        for <linux-rdma@vger.kernel.org>; Tue,  6 Oct 2020 08:49:59 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id d20so17198716qka.5
        for <linux-rdma@vger.kernel.org>; Tue, 06 Oct 2020 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XmlBZwSgT9XrRvfOtXu2s7SNTLyfzcwrzv/8Mqny/GA=;
        b=kYrcMx1WLb2Xxtj3NW15rbJXK16a7ttF3/iW+/N9oXZMsRK0sVENFb125wgKnjd+/f
         4ckyiCRLf+MMMp73oGUgFrx8s0C2Jy1KU6DVKZbEl4wE0GK4xs28LcyfGaYFXLUCylqB
         1jAvolNrxgeqrYPXSsMpYkuJbGU7qAwUW8lxk10k65NqDD5Fw7KkqNmzJvZR/yvPx/uH
         yqluV3mwNR/mKod9cuaz/7i9Cbwcc3mhC/MIwO1C0KfC8psHs8mcl1VGqXVrRE5bXivo
         Ys4OMArwmAsukW7JSjYFC9GmdZlj/fGlJ9Tx5S0dqAbAmnUyvN/GU4GDM3wTmeRM6Wtp
         XYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XmlBZwSgT9XrRvfOtXu2s7SNTLyfzcwrzv/8Mqny/GA=;
        b=ZajmyuhVOEaCjSGqFhGk1u5urSZh4EiFUrpdwevYu6NLzJywwKy2jail+NFNoxkGbw
         1Wr4O6Xtz/x81uX9yF2RGKXhe6YMngZ7zWVfNI3qbFcoZH7DmQDuZrsTKYrW+BV/EGN+
         4viy55gQEI7ETUci2f6P/Opd5WeAzLDGiGSVyOaIPa3ya4XwUWzZSW7IpI2LuQU+0Vgf
         6MRN4STObceOEvwwxk83P96yIKFJ15P5PlYhVJu55aZQPBt92NGWn7hPPjC6JOCwQtyV
         a/8/ij8Hd1NAIfkZqqAbNCnD/ewUUIbL7bzM+dOAxz/Phd4kZIGuHoFM3ymz/Wn09/UC
         4vPA==
X-Gm-Message-State: AOAM5312ZQtTcOvggZOuwcdzLj+OCl6GVkNBKgQ1AKiAZHVeZpT51JPo
        2RO7PSdj11LDXPsF4SFkhqe3Lwijgji4sj0c
X-Google-Smtp-Source: ABdhPJwICIB9a2K0/LMAcKo0X/sy0duPgZW4seNw2K2BMx3nX0ORxtJyh5iGpKZIxXy4ht7OifK7+g==
X-Received: by 2002:a37:a750:: with SMTP id q77mr5518029qke.377.1601999398339;
        Tue, 06 Oct 2020 08:49:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id l19sm1697866qkk.99.2020.10.06.08.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 08:49:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kPpDw-000ZpU-TR; Tue, 06 Oct 2020 12:49:56 -0300
Date:   Tue, 6 Oct 2020 12:49:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     "Xiong, Jianxin" <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [RFC PATCH v3 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20201006154956.GI5177@ziepe.ca>
References: <1601838751-148544-1-git-send-email-jianxin.xiong@intel.com>
 <1601838751-148544-2-git-send-email-jianxin.xiong@intel.com>
 <20201005131302.GQ9916@ziepe.ca>
 <MW3PR11MB455572267489B3F6B1C5F8C5E50C0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20201006092214.GX438822@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006092214.GX438822@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 06, 2020 at 11:22:14AM +0200, Daniel Vetter wrote:
> 
> For reinstanting the pages you need:
> 
> - dma_resv_lock, this prevents anyone else from issuing new moves or
>   anything like that
> - dma_resv_get_excl + dma_fence_wait to wait for any pending moves to
>   finish. gpus generally don't wait on the cpu, but block the dependent
>   dma operations from being scheduled until that fence fired. But for rdma
>   odp I think you need the cpu wait in your worker here.

Reinstating is not really any different that the first insertion, so
then all this should be needed in every case?

Jason
