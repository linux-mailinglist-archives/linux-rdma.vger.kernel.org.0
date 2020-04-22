Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0656B1B4D44
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2020 21:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgDVTWa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Apr 2020 15:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725961AbgDVTW2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Apr 2020 15:22:28 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D605C03C1A9
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2020 12:22:28 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 92so2721255qtg.0
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2020 12:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CN43+dhBFndfri4biu3f0rYCyyiNZRagKV6flNNGro4=;
        b=Qz3S/A6g6FqCWR0GY0x0ot+OcB1rS1sgJF74IVrIoSY71NvhECB0O0z3ex68RwoaZp
         zq8QUxJM2gYqbAlJ7gWKZmh+rUDRfqe5n/RSV86UzogOIwztRqGpw4TrqIGDcfb7TtxS
         dRGrDTChDY3uGIqdsGazi94Yw/f2S0i/aMTf748r//d2NvbuFRI0L4SDFTo2be+c0UTi
         xgJqnkwFgtHV2jJFPIPCRVnYkYCDKq7mVUKwXeYAwiqv9M11XlsWXAvIki0p9ZuV1abi
         0kn7lp02m9TWaEbAEGoM+Vw8V8IAWmQDEirxum0h6yrxdP62NgJRtb7PpZusimz2fdfR
         a3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CN43+dhBFndfri4biu3f0rYCyyiNZRagKV6flNNGro4=;
        b=B2JNQChSCZ7iWa76qJ/GUDht/f2MrBOZ9T9Du3APSxN+dafyaKjsozvu8osswqid83
         j1+XP9Np5z4mTO78XahC+QXo3sjjFROuXgLEMy6Gk+wXGPMzvI7cOhYP0w7+3auFRuCO
         wIfIQfBz0lsnZMUIsj/OjhnL6h+911yZp91gxAwCTzSapkOhwZblUVbDcOQVB8D6VFTD
         5EhduwxqauOYWb6Z9r2wrUp2kvKuU20dfyNlEH99e2IzSXrXcgTGlZ9vbaJLaz0lwrvl
         Eqvep5u4rnhDVLtSLLs8p13Zf2SpHjWCdEO6JylYgkkVFXyYuzvHdZDdneqxLmeSnmx6
         yb+A==
X-Gm-Message-State: AGi0PubMg3DwPGWcsOtVevVo4NyVuOwDxW+mCCZcW4u3plq9HP44sk26
        O7DrvS3GY/8RL5OA1nrCt1m1OA==
X-Google-Smtp-Source: APiQypIpM6Cq2xb/2SjJV3ydF+AQpuaGrVMkjolYqFpno5PkO/tttDqTjt+OQJxTeq0+pEnpondgDA==
X-Received: by 2002:ac8:31aa:: with SMTP id h39mr197046qte.190.1587583347704;
        Wed, 22 Apr 2020 12:22:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id j25sm117035qtn.21.2020.04.22.12.22.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Apr 2020 12:22:27 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jRKx0-00037P-7D; Wed, 22 Apr 2020 16:22:26 -0300
Date:   Wed, 22 Apr 2020 16:22:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/6] RDMA/hns: Support 0 hop addressing
Message-ID: <20200422192226.GA11931@ziepe.ca>
References: <1586779091-51410-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586779091-51410-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 13, 2020 at 07:58:05PM +0800, Weihang Li wrote:
> Add support for 0 hop addressing, which means hip08 supports multi-hops
> addressing range from 0 to 3.
> 
> Unforunately, there are still some dev_*() in in the initialization process
> of the hns driver in this series that can't be replaced by ibdev_*()
> currently, but they will be modified in subsequent patches.
> 
> Xi Wang (6):
>   RDMA/hns: Add support for addressing when hopnum is 0
>   RDMA/hns: Optimize hns buffer allocation flow
>   RDMA/hns: Optimize 0 hop addressing for EQE buffer
>   RDMA/hns: Support 0 hop addressing for WQE buffer
>   RDMA/hns: Support 0 hop addressing for SRQ buffer
>   RDMA/hns: Support 0 hop addressing for CQE buffer

Applied to for-next, thanks

Jason
