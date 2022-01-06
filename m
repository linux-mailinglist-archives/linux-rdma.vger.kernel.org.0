Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E21F485D3B
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 01:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343848AbiAFAfa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 19:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343830AbiAFAf2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 19:35:28 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F48C061245
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jan 2022 16:35:28 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id a11-20020a17090a854b00b001b11aae38d6so1172544pjw.2
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jan 2022 16:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/dgM38nH9o8fmC3S1YCg/YggFGRsvCmKnoOuH6xTuns=;
        b=jMNnnvuhcFeDCUsNA7IB1tnGTpFJSji9ve2cvca3TgSTVw56PL212pUZZ0f1ZJWsi2
         P4r3DTaEIWY/w3httxSjFDuE676yxI+u+qx7i84IDeHAPeHBAFYtT07Gb95cscCreEIS
         hjB/Q6/jgvmEG+dAXiQC55RCJWVwfwSVRVIOarQHwBscvDazT6+RHr3cSzaicgPsa6AZ
         ollu+uoV1dMv/XwEeaO0asU1xn7cApC0nrxZgTjzp4IqgDH8NKOBOJxujLKsl6+JpvKU
         x9P8e/63s4SE3p+Pb06/n7wB4RV851ELzlaLb/AYRr5rWX5dwA/k0g4PjVeR3Lvbpvaf
         sNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/dgM38nH9o8fmC3S1YCg/YggFGRsvCmKnoOuH6xTuns=;
        b=oqlR7nBSGtoKtRpehHdPoowMCocoBUBilM4wiT4Bl4daInzqIiIsgOy+44mt8t4qzz
         0nsg+bbRr1+DmGi8GRk73mWdP+JK2k/E6Ao8PAfqy8Kfd4Dcr/tQk38vpM2+LmTm64hd
         fMw88aIAUL2ZUxX2CoMPybMmCqihHB6nEn0nQoi9skKYRQvxRZV/25ECiRZ+Ra9/sA9K
         9jS6hg4wK5bYAGGPAKe7ZHdCxzeJ1pBcGwQwiBemJBRXOZ2gfncrUktzYVQ3ccDoccZy
         DH0tTc1hkvVWPUJhQW1MTXVuKm09Ox9xC18/SLtHlJS4YmyMfEE/fsYnyZTGqIs3w7W7
         np7g==
X-Gm-Message-State: AOAM531/SZ8ZNiwSmvimPhjTpp5ABi7qg3OsYtUuHFOZ3OFZ7q5Qundg
        yyPKsZsq8+NzfLXdxHMkZEBhwQ==
X-Google-Smtp-Source: ABdhPJwI1M2o+qP77Lv7sMzLsdslDVY8qUMAFpBAjlHNE6ysmF/7QU6sZglf/IKSQbkkV15BO6eKCg==
X-Received: by 2002:a17:90b:3809:: with SMTP id mq9mr7062172pjb.245.1641429327593;
        Wed, 05 Jan 2022 16:35:27 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id s8sm243085pfu.58.2022.01.05.16.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 16:35:27 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n5GkX-00CDig-JJ; Wed, 05 Jan 2022 20:35:25 -0400
Date:   Wed, 5 Jan 2022 20:35:25 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tom Talpey <tom@talpey.com>
Cc:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
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
Message-ID: <20220106003525.GT6467@ziepe.ca>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
 <9f97d902-aad5-db0f-f2dc-badf913777c4@talpey.com>
 <fd561077-358e-e38d-a7d0-5c61593eff6a@fujitsu.com>
 <17122432-1d05-7a88-5d06-840cd69e57e9@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17122432-1d05-7a88-5d06-840cd69e57e9@talpey.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 30, 2021 at 09:32:06PM -0500, Tom Talpey wrote:

> The global visibility is oriented toward supporting distributed
> shared memory workloads, or publish/subscribe on high scale systems.
> It's mainly about ensuring that all devices and CPUs see the data,
> something ordinary RDMA Write does not guarantee. This often means
> flushing write pipelines, possibly followed by invalidating caches.

Isn't that what that new ATOMIC_WRITE does? Why do I need to flush if
ATOMIC WRITE was specified as a release? All I need to do is acquire
on the ATOMIC_WRITE site and I'm good?

So what does FLUSH do here, and how does a CPU 'acquire' against this
kind of flush? The flush doesn't imply any ordering right, so how is
it useful on its own?

The write to persistance aspect I understand, but this notion of
global viability seems peculiar.

> Well, higher level wrappers may signal errors, for example if they're
> not available or unreliable, and you will need to handle them. Also,
> they may block. Is that ok in this context?

I'm not sure we have any other tools here beyond a release barrier
like wmb() or the special pmem cache flush. Neither are blocking or
can fail.

In pmem systems storage failure is handled via the memory failure
stuff asynchronously.

Jason
