Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B5A248FF3
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 23:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgHRVPv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 17:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgHRVPv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 17:15:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EAEC061389
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 14:15:50 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id p14so234424wmg.1
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 14:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VMpKt1zl4S4rw5tlNZoSLem2HZ39W8LAcxJ1XUOyeZI=;
        b=aIk9o9629dMRxbr2NjdfhFD2ACxPHVCs5qaY8reRsFMATjIeV9NEoP7EJS2pzWKFoO
         HNyCxN3b2GeRNZbT35oBWjCP51PHDURRrc/pKTWjxRkuy9pLGYS7VdDuzhjUGTG1QU2y
         UNAXe9L9VyZ7EUVOEuCXy7hZ/LZWjamk91ypj9dPcXdGXJ5CBtxxbilMlPTQsaiiesuy
         ni8OQyK0Rz2j/Iv0+nO/0Lip57bHYX96Au1cyZM8rJz/ttIwwZFudQcrtlTvZKCTI1Ab
         0l7egkgOg7HHEQ15j2l2biUJFY0PsaJ8sLlzI4w642kJV+GUGWCYsVu0tl6BAPDL1TC2
         lXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VMpKt1zl4S4rw5tlNZoSLem2HZ39W8LAcxJ1XUOyeZI=;
        b=kXB6w9ANr0mcdNcga0vdt92hwDnInMwfaLWXpWYNu1t6wr4/9CbiqZH40m0cxxxuCs
         MTp5R7DIxBeDAQ/tIlWBnQpMfBkMzmIDEwT6lEO/AKLFUZoiaShLsK2LoplWrJTOqXgB
         XuFloG7hQ74gvrOxjZWdPS0iqRg7xBKa7TB1MFx4O60OsaoVQoKN2TJtaK03RPXzcv2w
         71Yy1S+OrctOhVZ8A5XzZxhWDChJC9pIi4THaZg9W0yPFJQasa7HeJ8m6/p55/LN3UNC
         xV6G2/Q95zr6+sXXcGFxLPf517gIp4RPjGPRF/1dvMxa4Ctzr+mFdv8Rt83zXFTvtOyU
         98iQ==
X-Gm-Message-State: AOAM530zwM3z+6RO3qYGT7aMhjsaKsPmyl53cS2a3NF8XUfwlj5UebxM
        1XjaKnuwvZavYFqRuvohLKQ=
X-Google-Smtp-Source: ABdhPJypTpIj6BqjoItNlJcQTopUf4GhC0dA66ZkZWaGEmIjuu61mIoCyjPlz083H3w0f9oX78nklg==
X-Received: by 2002:a7b:c00c:: with SMTP id c12mr1810240wmb.54.1597785349557;
        Tue, 18 Aug 2020 14:15:49 -0700 (PDT)
Received: from kheib-workstation ([77.137.115.29])
        by smtp.gmail.com with ESMTPSA id y84sm1619239wmg.38.2020.08.18.14.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 14:15:48 -0700 (PDT)
Date:   Wed, 19 Aug 2020 00:15:45 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH v2 for-rc] RDMA/rxe: Fix panic when calling
 kmem_cache_create()
Message-ID: <20200818211545.GA936143@kheib-workstation>
References: <20200818142504.917186-1-kamalheib1@gmail.com>
 <20200818163157.GY24045@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818163157.GY24045@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 18, 2020 at 01:31:57PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 18, 2020 at 05:25:04PM +0300, Kamal Heib wrote:
> > To avoid the following kernel panic when calling kmem_cache_create()
> > with a NULL pointer from pool_cache(), move the rxe_cache_init() to the
> > context of device initialization.
> 
> I think you've hit on a bigger bug than just this oops.
> 
> rxe_net_add() should never be called before rxe_module_init(), that
> surely subtly breaks all kinds of things.
> 
> Maybe it is time to remove these module parameters?
>
Yes, I agree, this can be done in for-next.

But at least can we take this patch to for-rc (stable) to fix this issue
in stable releases?

Thanks,
Kamal

> Jason
