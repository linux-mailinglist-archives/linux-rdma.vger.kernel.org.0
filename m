Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD44383A93
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 18:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbhEQQ5z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 12:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbhEQQ5y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 12:57:54 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3135C061573
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 09:56:37 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id k127so6420639qkc.6
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=28E9ugi9DnQwlbs41XcOpwi9InRu2thJH9qmN3fFNkY=;
        b=m6DNcTOPIMZLr5TTyVLVciui/IkOVqRfWVaR1Q+LvsbpMZ4Pg6pMJuhZT3Bo1tE1Cs
         HnqHWCNQYGryxwDFxbLItRrLovmUwqXbNb+ZHG6s+4Y9wzkjl9Ie3StF9y7lkYhUwkoL
         OgwRQQPBsXVWa9/TYlHdi0IZ7f5opRS/CEIGdmQmMJ8BSGBX2BIKgBTyrHflVif/EkjV
         ycAdNdkgcBFxukg/ZSs8d7Q1GUrlsNi5Uj0luPGtDr7ojtRsOTC1EB79S1xt4jA/xKbl
         zTGXrD+w/nTqZH5S2FRCZ2Ug7fsQS+3EWdZmkORcHGMo9THZRrvfSlHdJZiW0NJEdgwi
         SF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=28E9ugi9DnQwlbs41XcOpwi9InRu2thJH9qmN3fFNkY=;
        b=Ppydn4v45sJ2OGqLjfFKiBDWoq9ApCIZjfBgoaLo6+OGDNqw3phXvuX4ekv2Ll9ov0
         YxYHkYksSR+oVwiFn0tvrY++XNm2Ecd8XcQ/ROfOF5ArDmEGFHY8Ou9POgzaWdWjPe39
         5FZRIiqS/aT/qFiaYvtqTQslU3x8ciOiHsxwooy3Zzl7w6tCsTpwS+gPyKAgcRCESj2z
         rcZJ4dT1PiAnnnz3fZCScyrCa8D2ldVO67R4bRNzf1FPd3e1W6Fn+e52u5Q4Ks2MC7+N
         sSLyhNVGSDDvT0u3qDJKUI/SfynUMQyZl2UlcFE3kRWQiIUJMJT2VLse0W8nlh3SpgR5
         wmtw==
X-Gm-Message-State: AOAM530bz61attFBa3qD7yM8Rr6PFHRl/+DReFauqPBlBH+0+GDRN2Ks
        b0Fb5M9Lvc20KPbjdYvD5JI01Q==
X-Google-Smtp-Source: ABdhPJwruGTXfUSqV8TuYPWApuhaTXv7DEhEco6NZMQQXUTAQYTlVOlOHRQEt6vASi0yHuXIE5sz/Q==
X-Received: by 2002:a37:a751:: with SMTP id q78mr771347qke.482.1621270597112;
        Mon, 17 May 2021 09:56:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id d19sm10295749qtd.29.2021.05.17.09.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 09:56:36 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lifjA-009K8n-Fn; Mon, 17 May 2021 13:04:20 -0300
Date:   Mon, 17 May 2021 13:04:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     liweihang <liweihang@huawei.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 1/6] RDMA/core: Use refcount_t instead of
 atomic_t for reference counting
Message-ID: <20210517160420.GQ1096940@ziepe.ca>
References: <1620958299-4869-1-git-send-email-liweihang@huawei.com>
 <1620958299-4869-2-git-send-email-liweihang@huawei.com>
 <20210514123445.GY1002214@nvidia.com>
 <693f3fc2bcb04615b22a829ac50eb679@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <693f3fc2bcb04615b22a829ac50eb679@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 15, 2021 at 03:07:58AM +0000, liweihang wrote:
> On 2021/5/14 20:34, Jason Gunthorpe wrote:
> > On Fri, May 14, 2021 at 10:11:34AM +0800, Weihang Li wrote:
> >> The refcount_t API will WARN on underflow and overflow of a reference
> >> counter, and avoid use-after-free risks. Increase refcount_t from 0 to 1 is
> >> regarded as there is a risk about use-after-free. So it should be set to 1
> >> directly during initialization.
> > 
> > What does this comment about 0 to 1 mean?
> > 
> 
> Hi Jason,
> 
> I first thought refcount_inc() and atomic_inc() are exactly the same, but I got
> a warning about refcount_t on iwpm_init() after the replacement:
> 
> [   16.882939] refcount_t: addition on 0; use-after-free.
> [   16.888065] WARNING: CPU: 2 PID: 1 at lib/refcount.c:25
> refcount_warn_saturate+0xa0/0x144
> ...
> [   17.014698] Call trace:
> [   17.017135]  refcount_warn_saturate+0xa0/0x144
> [   17.021559]  iwpm_init+0x104/0x12c
> [   17.024948]  iw_cm_init+0x24/0xd0
> [   17.028248]  do_one_initcall+0x54/0x2d0
> [   17.032068]  kernel_init_freeable+0x224/0x294
> [   17.036407]  kernel_init+0x20/0x12c
> [   17.039880]  ret_from_fork+0x10/0x18
> 
> Then I noticed that the comment of refcount_inc() says:
> 
>  * Will WARN if the refcount is 0, as this represents a possible use-after-free
>  * condition.
> 
> so I made changes:
> 
> @@ -77,8 +77,12 @@ int iwpm_init(u8 nl_client)
>                         ret = -ENOMEM;
>                         goto init_exit;
>                 }
> +
> +               refcount_set(&iwpm_admin.refcount, 1);
> +       } else {
> +               refcount_inc(&iwpm_admin.refcount);
>         }
> -       refcount_inc(&iwpm_admin.refcount);
> +
> 
> I wrote the comments because I thought someone might be confused by the above
> changes :)

Stuff like this needs to be split into a single patch for iwpm_admin

Jason
