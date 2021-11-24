Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF7F45C8E3
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Nov 2021 16:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242437AbhKXPnZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Nov 2021 10:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243404AbhKXPnS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Nov 2021 10:43:18 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323E8C061574
        for <linux-rdma@vger.kernel.org>; Wed, 24 Nov 2021 07:40:09 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id m25so2953488qtq.13
        for <linux-rdma@vger.kernel.org>; Wed, 24 Nov 2021 07:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qic7/5sQZV+FbCNsv73jkBpMH6W9kBYGrI+X6vZnMMk=;
        b=Y/SD2Yb6WYkntEHGlXa8kKmDolBlSQjHcK6mjq8G8wm6uAv3DYgn3Xpvj9XYwTLfU9
         6nCDE+unwPS2IW94mxlIKLts+UcoAJYtCL4IecDXfejhapLeFfu5gyNVuwp5mG2vTFek
         5kP7pW65TEpvzK2fccxhwxiDVPI6XogUHZ8NVTC+QjdBl//tzwB6DQOQJhmwrJ3qWQJf
         XaqFsqZumCyQG15VlUVeu3bxb4zYSx5oWBn4mY4utP6iMvdpyyqhfjW6F7uqDMnIIxeQ
         ULr9l/xzQRksILbE41CNnHMUP0+IFSCMbAtE5pSNJRkLF4pVYfjuT3RKeQtaEzlU36aj
         qufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qic7/5sQZV+FbCNsv73jkBpMH6W9kBYGrI+X6vZnMMk=;
        b=5pQO7vw6uiMHAB4DyYWYzKuy6X9C7kCg+CQhh8rOzyiIZpvZs+IqaFjm/mC8J7PDYk
         uSowcsp12TpSAh3O8mxs0kgMSq/ugMVDSVXl62yq86/NC7sgpDApr0X1zrc2+mX4XIiv
         GaNSZfXO2JHKXWooIYFZFVi06JJfFDoVhzQ3zVwLpCE7KtildOzNs2OAih5BjrDA/ztx
         3mO39dd20WiEXwojPIJDYX+e9sSVuG3Q2Kc7VIC4mQbQxkydDE4i38VbdFY9/KQmIZuG
         Remb1RLJaPoR7zHzN7ou/fOHD0TcPkEpEU3w4sN5XffiQRSPMk44MvN/02jKBrC6v5Fw
         kXAQ==
X-Gm-Message-State: AOAM531Qer38Ga5InYpZsRJ7RtS1O0DK7Qrw1BA40CoBliZteXEz1+lM
        mBsXgRwRNT13aGesKxF8UDbc/w==
X-Google-Smtp-Source: ABdhPJwh/zZotzejPgSq1Xvd3Ycb1DB1K/3TqvUit3yklgnB03juS0KAl71H+gisi23hOWnJT4VrDg==
X-Received: by 2002:ac8:5a53:: with SMTP id o19mr8879937qta.4.1637768408385;
        Wed, 24 Nov 2021 07:40:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id h11sm38506qkp.46.2021.11.24.07.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 07:40:07 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mpuNT-0013Sk-39; Wed, 24 Nov 2021 11:40:07 -0400
Date:   Wed, 24 Nov 2021 11:40:07 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH rdma-core 5/7] libhns: Fix wrong type of variables and
 fields
Message-ID: <20211124154007.GK5112@ziepe.ca>
References: <20211109124103.54326-1-liangwenpeng@huawei.com>
 <20211109124103.54326-6-liangwenpeng@huawei.com>
 <20211123141308.GA42666@nvidia.com>
 <a2acf617-013d-84b7-4622-44c024bac9f7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2acf617-013d-84b7-4622-44c024bac9f7@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 24, 2021 at 07:39:34PM +0800, Wenpeng Liang wrote:
> 
> 
> On 2021/11/23 22:13, Jason Gunthorpe wrote:
> > On Tue, Nov 09, 2021 at 08:41:01PM +0800, Wenpeng Liang wrote:
> >> From: Xinhao Liu <liuxinhao5@hisilicon.com>
> >>
> >> Some variables and fields should be in type of unsigned instead of signed.
> >>
> >> Signed-off-by: Xinhao Liu <liuxinhao5@hisilicon.com>
> >> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> >>  providers/hns/hns_roce_u.h       |  6 +++---
> >>  providers/hns/hns_roce_u_hw_v1.c |  6 +++---
> >>  providers/hns/hns_roce_u_hw_v2.c | 11 +++++------
> >>  3 files changed, 11 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
> >> index 0d7abd81..d5963941 100644
> >> +++ b/providers/hns/hns_roce_u.h
> >> @@ -99,7 +99,7 @@
> >>  #define roce_set_bit(origin, shift, val) \
> >>  	roce_set_field((origin), (1ul << (shift)), (shift), (val))
> >>  
> >> -#define hr_ilog32(n)		ilog32((n) - 1)
> >> +#define hr_ilog32(n)		ilog32((unsigned int)(n) - 1)
> > 
> > This should be a static inline function not a macro, then it can have
> > the correct type.
> > 
> > Also please send this series as a PR on the github
> > 
> > Thanks,
> > Jason
> > .
> > 
> 
> I submitted a PR on the github:
> 
> https://github.com/linux-rdma/rdma-core/pull/1090

I mean of your whole series

Jason
