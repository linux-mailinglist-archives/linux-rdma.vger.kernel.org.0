Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0BD3AEBBA
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 16:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhFUOwH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 10:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhFUOwG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Jun 2021 10:52:06 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76110C06175F
        for <linux-rdma@vger.kernel.org>; Mon, 21 Jun 2021 07:49:51 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g12so13585670qtb.2
        for <linux-rdma@vger.kernel.org>; Mon, 21 Jun 2021 07:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7EhCVDJi9/mtNith6sHIuVtzdsDVwMIUM7u21aSrhMw=;
        b=pMj9icezCyVPhAoUcyIC4hXg8iF9vNR6ki/LwTLTUx9T50dBy/aY+JIQc2BM9Hz1/z
         JkL9Jm7F3sTwTj1cBu4VqQ0lfWp+QeZb+UHm3PoPx1trXAkMT1LHeTAZ6a272Hh7Cypf
         IolYhYiuvw6yY/3OnYlCLxHAyGeUoFVQKeTwptIxn6w6eA5jjABocMAs4na9+zV2VW5T
         rz9L38LXMzbPG5+9/L86DpSMJOUqS31ppQLS8vlTPUn6gfpb9oKUdfcwayMnbRDQquI9
         O2qE291+F/7jfBsLM1X67J41Z4Pn6F3VqTRzoFIhrsTP3dOflNs6XlBQ7VQiN7wGxWNO
         b1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7EhCVDJi9/mtNith6sHIuVtzdsDVwMIUM7u21aSrhMw=;
        b=VPw3uD6YSL38gvFYfrP1KrfS9eZoMoTy2b/PyhJ9Lpz/A5qqFhqiY5ue9CLolSVNsG
         N05ri77CUJCDHS4Xv3ahAaxbcbs5xfiTeu8UCTpr9b9kkl0Xv1vLtWaa7FfyQa4HKJI6
         zgOTK4GkcR3ab2ie979K4bRnJWRX0qQXvzteJnJ038AIl3Eki3do8AorpGQIRK32GQIE
         Ej2VzkZnn8di4unCpK2Hr4+AQJxyucmoFGRtW5K74ubUatRcjYZDUFwrLZ5PK1nHfP2H
         4sagvvuSiVwvfpa8dVB/isw1yPMqG32dvvI9eJ6uxhk0umG1/Xs4it76lZVI79zYXcP8
         JO1Q==
X-Gm-Message-State: AOAM530AeJgKC6vOHvRIh18Sriej7NSTiLPPaTOQ20r42ekShq5lfzJm
        Q+J2ms1i43xc0vPS69jV9d0bKg==
X-Google-Smtp-Source: ABdhPJyQ783oDw7ztSH9iUqFrEniMfq/XeByphnoK7SGzg/3oOO5hx+wfM7vN3NxmC0psXJAIBTnIQ==
X-Received: by 2002:ac8:4d84:: with SMTP id a4mr24377635qtw.319.1624286989919;
        Mon, 21 Jun 2021 07:49:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id 186sm4426217qkf.29.2021.06.21.07.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 07:49:49 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lvLFE-009XIx-Pt; Mon, 21 Jun 2021 11:49:48 -0300
Date:   Mon, 21 Jun 2021 11:49:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Oded Gabbay <ogabbay@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomer Tayar <ttayar@habana.ai>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 1/2] habanalabs: define uAPI to export FD for DMA-BUF
Message-ID: <20210621144948.GG1096940@ziepe.ca>
References: <20210618123615.11456-1-ogabbay@kernel.org>
 <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
 <YNCN0ulL6DQiRJaB@kroah.com>
 <YNCgM1svqKGUhcFY@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNCgM1svqKGUhcFY@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 21, 2021 at 04:20:35PM +0200, Daniel Vetter wrote:

> Also unless we're actually doing this properly there's zero incentive for
> me to review the kernel code and check whether it follows the rules
> correctly, so you have excellent chances that you just break the rules.
> And dma_buf/fence are tricky enough that you pretty much guaranteed to
> break the rules if you're not involved in the discussions. Just now we
> have a big one where everyone involved (who's been doing this for 10+
> years all at least) realizes we've fucked up big time.

This is where I come from on dmabuf, it is fiendishly
complicated. Don't use it unless you absoultely have to, are in DRM,
and have people like Daniel helping to make sure you use it right.

It's whole premise and design is compromised by specialty historical
implementation choices on the GPU side.

Jason
