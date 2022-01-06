Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F994868B1
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 18:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241865AbiAFRdu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jan 2022 12:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241845AbiAFRdu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jan 2022 12:33:50 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1411C061245
        for <linux-rdma@vger.kernel.org>; Thu,  6 Jan 2022 09:33:49 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id lr15-20020a17090b4b8f00b001b19671cbebso3916106pjb.1
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jan 2022 09:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SVU9ojxKh3KV/GkNCH2U8jLzNnNx2BrytGLDVlfM2n4=;
        b=B7uhyCQuWye9aBf8yPcxb8+lyR96aaQke/GnM1Lg02NwGIbHRbmz4KClAxslwbq7U4
         Yebv3rE7W75n0qCr4B1yNF0W+BOhQUuc64tplojX1gSd1ODhjw11QN/e6aeUwDBlNx0h
         bh1dxebH0y7DIlnsUH9/9L7tptxPiYlQ+MGC44/aH55Grc/D0PciIW6R7bG7OT9T8+1j
         uQIEyqiFgMEl0bAHBBRzwMzQCbLDyUed4PqBcENUbl7LhcZXdtdaw5dkA33E7Nr4+czL
         4P4mEVEsj97UwkqlV2Xx1QadRt2QpvFJlmlsUkDyY+InxvI2q13Ja5cJoKNCGbZDOWgD
         3OIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SVU9ojxKh3KV/GkNCH2U8jLzNnNx2BrytGLDVlfM2n4=;
        b=6nH0B8QZSvUry3OK8XgaIiP1p9MahFmLwL1tcSsTRWA3AA2VvAddmtnVHsxiAAPNWv
         vRLdlo/rag/iiypsGaJQOXfR/iDcP0n8+voa7wrL99bla+0Rky7IW+9AYH7+AAtufsoB
         vczkvZX4qjJI8lNBAYTij7me69yCa7YXOrNL8rCzRq8sCTvw7WM2Y1awb3/R7o6JSM2Z
         zS3DWjzLkjy5wKU56CM5yR50T7RMTv60scrma78WJVeJJublBFQLxasssL/lch60/sWm
         Qasqwlb6Z6QM2WyT/k/VY0kioo+AEQDjG9OwgaUpvZXFTccmTDS8h+YRv6JBXqU7TXCw
         tumw==
X-Gm-Message-State: AOAM531jR2Wdt57d2mOZpkg2HGg1iqbeQIuWvAqS0W5aNd9KPVgOrX2h
        lZkxY7FDvtis8w4+r1+eWGlmcA==
X-Google-Smtp-Source: ABdhPJyZaTVYpO1ItL4ZGLZUkEwmwFKFW3I/igBkCy9iAG62enlQpIFkRSuiwUlPtU89+7Kwcm6jMg==
X-Received: by 2002:a17:902:8505:b0:149:ac79:d8d6 with SMTP id bj5-20020a170902850500b00149ac79d8d6mr28217912plb.170.1641490429554;
        Thu, 06 Jan 2022 09:33:49 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id ng7sm3343172pjb.41.2022.01.06.09.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:33:48 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n5We2-00CQtq-FZ; Thu, 06 Jan 2022 13:33:46 -0400
Date:   Thu, 6 Jan 2022 13:33:46 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liweihang@huawei.com" <liweihang@huawei.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Message-ID: <20220106173346.GU6467@ziepe.ca>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
 <20220106002804.GS6467@ziepe.ca>
 <347eb51d-6b0c-75fb-e27f-6bf4969125fe@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <347eb51d-6b0c-75fb-e27f-6bf4969125fe@fujitsu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 06, 2022 at 06:42:57AM +0000, lizhijian@fujitsu.com wrote:
> 
> 
> On 06/01/2022 08:28, Jason Gunthorpe wrote:
> > On Tue, Dec 28, 2021 at 04:07:15PM +0800, Li Zhijian wrote:
> >> +	while (length > 0) {
> >> +		va	= (u8 *)(uintptr_t)buf->addr + offset;
> >> +		bytes	= buf->size - offset;
> >> +
> >> +		if (bytes > length)
> >> +			bytes = length;
> >> +
> >> +		arch_wb_cache_pmem(va, bytes);
> > So why did we need to check that the va was pmem to call this?
> Sorry, i didn't get you.
> 
> I didn't check whether va is pmem, since only MR registered with PERSISTENCE(only pmem can
> register this access flag) can reach here.

Yes, that is what I mean, why did we need to check anything to call
this API - it should work on any CPU mapped address.

Jason
