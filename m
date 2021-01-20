Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B79C2FCC9B
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jan 2021 09:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbhATIUD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jan 2021 03:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728996AbhATIBr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Jan 2021 03:01:47 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075ABC061575
        for <linux-rdma@vger.kernel.org>; Wed, 20 Jan 2021 00:01:02 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q7so195143wre.13
        for <linux-rdma@vger.kernel.org>; Wed, 20 Jan 2021 00:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XIKOfdQ39sGdLT3c6gVEbQNxQnjkeYmR/4PVU+oFEnc=;
        b=sCYGfWzoNVu8KtENM5iDui+OEStVFvELcOSAZgVmUnzeok+qZ8fnFzMZ3sAt/P5Oba
         e4RhGsXhfWMKRiq0hjgZ/LDIYxuNrJieoznYirdI7l6SHEdfpQ06J/Tzq/wisXzJbiwN
         bVJRKmM37foNRY/4GHERf8gvgxN8O2UImScxlwakHZeSlOsrfyss9ZkGXwGtZLHASy+C
         lROJedl6r4hYLInXTsgZ7g1st+iB400AE9Ffn9DGkbhSUBDxJOXhJAWEchY1FkVs360I
         l2qBGizxkFQxEBxdE5EH5QvXByeCHd+S+iBRUZF1XD8VMqMO2+HJbPGV+oMKzakWA2TR
         gnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XIKOfdQ39sGdLT3c6gVEbQNxQnjkeYmR/4PVU+oFEnc=;
        b=WknAT/UAnGMzp4Kyl0FxK+KgR1uC59bjmnRFjNE7wfu5MgcQHlT0wEY/V7eY7OSmKo
         xclBZ+UzeYEaW7uxtBNfiuSZRFNJBWbEVLcePcCxhvEDJcNBUjlKu5S9mgEfQJTwxaZS
         U8rurslxCnYQWcgyJ7y+hr3Ef4tCyJkscUOvimTs3fXAdmelg02FgXc7xAdyrLm8r2Cl
         hbHk86LfT4XNFi/1+7vwrZJINaQQtZIJGVlNUhfnG8i4Nv12IJzwd7yfk6hJ6BDCS9Dj
         YnmrlzbhPdG6Snsv1NsWzxVU8/awOQvunvEae+LTrJvCoEScycSmcpBJRUudktIq83wf
         Eg1Q==
X-Gm-Message-State: AOAM5311ooiAgfgNDaqr5nj45zz+uu0ZLb36A7QxnZg6QsRBVPljhYu4
        NHHUoppSkhjZxMCt+PzgHTv1bA==
X-Google-Smtp-Source: ABdhPJyDym/bNUT6yBQUvaB9v6KUo2LO5JOEREhjvHPqEJz0wGuXCnI7RAtQTBczYi9YiPZEurxeIg==
X-Received: by 2002:a5d:40d2:: with SMTP id b18mr7677245wrq.369.1611129660723;
        Wed, 20 Jan 2021 00:01:00 -0800 (PST)
Received: from dell ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id i18sm2469692wrp.74.2021.01.20.00.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 00:00:59 -0800 (PST)
Date:   Wed, 20 Jan 2021 08:00:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Intel Corporation <e1000-rdma@lists.sourceforge.net>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Taehee Yoo <ap420073@gmail.com>
Subject: Re: [PATCH 00/20] Rid W=1 warnings from Infinibad
Message-ID: <20210120080058.GK4903@dell>
References: <20210118223929.512175-1-lee.jones@linaro.org>
 <20210120004046.GA1022538@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210120004046.GA1022538@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 19 Jan 2021, Jason Gunthorpe wrote:

> On Mon, Jan 18, 2021 at 10:39:09PM +0000, Lee Jones wrote:
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> > 
> > This is set 1 of either 2 or 3 sets required to fully clean-up.
> > 
> > Lee Jones (20):
> >   RDMA/hw: i40iw_hmc: Fix misspellings of '*idx' args
> >   RDMA/core: device: Fix formatting in worthy kernel-doc header and
> >     demote another
> >   RDMA/hw/i40iw/i40iw_ctrl: Fix a bunch of misspellings and formatting
> >     issues
> >   RDMA/hw/i40iw/i40iw_cm: Fix a bunch of function documentation issues
> >   RDMA/core/cache: Fix some misspellings, missing and superfluous param
> >     descriptions
> >   RDMA/hw/i40iw/i40iw_hw: Provide description for 'ipv4', remove
> >     'user_pri' and fix 'iwcq'
> >   RDMA/hw/i40iw/i40iw_main: Rectify some kernel-doc misdemeanours
> >   RDMA/core/roce_gid_mgmt: Fix misnaming of 'rdma_roce_rescan_device()'s
> >     param 'ib_dev'
> >   RDMA/hw/i40iw/i40iw_pble: Provide description for 'dev' and fix
> >     formatting issues
> >   RDMA/hw/i40iw/i40iw_puda: Fix some misspellings and provide missing
> >     descriptions
> >   RDMA/core/multicast: Provide description for
> >     'ib_init_ah_from_mcmember()'s 'rec' param
> >   RDMA/core/sa_query: Demote non-conformant kernel-doc header
> >   RDMA/hw/i40iw/i40iw_uk: Clean-up some function documentation headers
> >   RDMA/hw/i40iw/i40iw_virtchnl: Fix a bunch of kernel-doc issues
> >   RDMA/hw/i40iw/i40iw_utils: Fix some misspellings and missing param
> >     descriptions
> >   RDMA/core/restrack: Fix kernel-doc formatting issue
> >   RDMA/hw/i40iw/i40iw_verbs: Fix worthy function headers and demote some
> >     others
> >   RDMA/core/counters: Demote non-conformant kernel-doc headers
> >   RDMA/core/iwpm_util: Fix some param description misspellings
> >   RDMA/core/iwpm_msg: Add proper descriptions for 'skb' param
> 
> Looks Ok, applied to for-next, thanks

Thanks Jason, much obliged.

I'll get the other set out in the next few days.

Hopefully we can have Infiniband cleaned-up by the end of this cycle.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
