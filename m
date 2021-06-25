Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA743B439A
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 14:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhFYMwS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 08:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhFYMwR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Jun 2021 08:52:17 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23397C061574
        for <linux-rdma@vger.kernel.org>; Fri, 25 Jun 2021 05:49:56 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id u8so1758261qvg.0
        for <linux-rdma@vger.kernel.org>; Fri, 25 Jun 2021 05:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Vp2M6wKaeQ8Ae3VYAdqhfAI9w/ItFEcYpgWESoIC89A=;
        b=nHPRkgwcDCGE29GMQxxUb6k+oz4iVTau3QnEOsoHnR5/UrD/tqLeAToQYPuaKoG3n7
         qoHAup2illTsC1QJqWkr7seQIeTnGC2aBUvcv3er/a0F9tDp4YQejfEOLpAfveV2vcVZ
         9X65FKLrJokM3qRw554fozaku/SOqSBsob2N9YVW1paH03g8J+yk0eWeSjGnHl054Hih
         0k3T/0Q7udIVs91NN8PY6w6P8A7ZOsB7PNefgDW4LeLj3pqnJavIpFceKy+iJxGV3Nx8
         i05tx+LU1fw2ayGUJFmh9VJOZWkbN7Jo26F3vsbTL8COnvsMt7mlO5ARfcOp+YnCXrtx
         HnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Vp2M6wKaeQ8Ae3VYAdqhfAI9w/ItFEcYpgWESoIC89A=;
        b=QYBXMEMV/MlJAPn7iYC4XyM6J3CYZpOSFM4GmDSJG1EsED1RG/fk2c+87slD/5pHRe
         e0QLVFgQNz4nE7Z0oDWt1Dpo7Odoq0nEQu8HWIp7dB9gMNp6XAe/54xcorWYpS7Gk0ZO
         Y6ogOtDonLaOwZfmoYoyqBkR+gh6+6CkxFKIYjVxDWKOWY8qOkimqC2fVLkwa+7IVaf/
         eBnDVFMIppfXwv1U1nnHBVOUU+p//rvF/epW3XksQxmTzez8fkS42yk5RgKoUf86tqtE
         q/2bENQ/B5cbdt4FS94TH6uN4xz0nHPnugpGlNRu7scRG0i7XqhIYnY7fi4AbK/uUAM0
         ZsuQ==
X-Gm-Message-State: AOAM530nEdq+0Ro6zNAjc4HCU3S1/84MGXpc4DEHDfsX0ZQy/1zjXENY
        2wnKu5MpWm9eoCyXZNyJeUgZTg==
X-Google-Smtp-Source: ABdhPJyMdaB4DAd/pfG93A9fwe60ZjH+OQ356McHHPxJ0TuRtuJjVseHoFUN1njN7bR6Cxl5W7nahQ==
X-Received: by 2002:a0c:f60a:: with SMTP id r10mr10941972qvm.53.1624625395329;
        Fri, 25 Jun 2021 05:49:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id i185sm274102qke.34.2021.06.25.05.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 05:49:54 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lwlHN-00CWgL-Ux; Fri, 25 Jun 2021 09:49:53 -0300
Date:   Fri, 25 Jun 2021 09:49:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Shoaib Rao <rao.shoaib@oracle.com>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH v1 3/3] RDMA/rxe: Increase value of RXE_MAX_AH
Message-ID: <20210625124953.GC1096940@ziepe.ca>
References: <20210617182511.1257629-1-Rao.Shoaib@oracle.com>
 <20210617182511.1257629-3-Rao.Shoaib@oracle.com>
 <3aa5a673-3fd7-744b-b664-510005215bd2@gmail.com>
 <10d9763c-4d10-3820-93a0-b79f55acfa8e@oracle.com>
 <edcf0cc0-4da8-5af3-3366-220b4eeba5e4@gmail.com>
 <20210618163359.GA1096940@ziepe.ca>
 <14e2c2a4-6067-c657-6ea4-91cd3c19d032@gmail.com>
 <20210618232535.GB1096940@ziepe.ca>
 <9b651595-94b1-4ecd-1e37-16459530f297@oracle.com>
 <5979c6c7-7ffe-d08c-f970-f97a1727988a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5979c6c7-7ffe-d08c-f970-f97a1727988a@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 25, 2021 at 12:13:57AM -0500, Bob Pearson wrote:
> On 6/24/21 4:21 PM, Shoaib Rao wrote:
> > 
> > On 6/18/21 4:25 PM, Jason Gunthorpe wrote:
> >> On Fri, Jun 18, 2021 at 01:58:48PM -0500, Bob Pearson wrote:
> >>> On 6/18/21 11:33 AM, Jason Gunthorpe wrote:
> >>>> On Thu, Jun 17, 2021 at 10:56:58PM -0500, Bob Pearson wrote:
> >>>>  
> >>>>> It isn't my call. But I am in favor of tunable parameters. -- Bob Pearson
> >>>> Can we just delete the concept completely?
> >>>>
> >>>> Jason
> >>>>
> >>> Not sure where you are headed here. Do you mean just lift the limits
> >>> all together?
> >> Yes.. The spec doesn't have like a UCONTEXT limit for instance, and
> >> real HW like mlx5 has huge reported limits anyhow.
> > 
> > These limits are reported via uverbs, so what do we report without current applications. Creating pool also requires limits but I guess we can use something like -1 to indicate there is no limit. I would have to look at all the values to see if we can implement this.
> > 
> > Shoaib
> > 
> > 
> >>
> >> Jason
>
> The object create in pools (rxe_alloc_locked) just calls kzalloc for
> objects allocated by rxe and checks the limits. For objects
> allocated by rdma-core (__rxe_add_to_pool) it just checks the
> limits. The only place where the limit really matters is when a pool
> is indexed (RXE_POOL_INDEXED). Then there is a bitmask used to
> allocate the indices for the objects which consumes one byte for
> each 8 objects.

Use an ida or xarray instead?

Jason
