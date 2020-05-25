Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31DD1E134C
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 19:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389263AbgEYRLT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 13:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388230AbgEYRLT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 13:11:19 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B30C061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 10:11:17 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z80so18075392qka.0
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 10:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5G4+fP9ti6jWKYWIDn+zl4F4FpE4x5za3vxrFwNcuQg=;
        b=nkD73SM5J5L3KbTv6kwD4h+fMuoPq1St6EeEpM5/RcYvFPmJtM6DHFag8qIg1WU0MI
         echTlctwYPWAHp8BZ1QpVBZH2cjFdmua7dy7j06urCbObZGQE6klp6V2oyejPSHHPEmM
         aPcyv0PcDj3u9N9ytV42HKi9hK1Z7NMKihR9DUkmy+mMK1ZpIHBkgLXUSM0MM7UQxjgE
         oJ2FOca6srMp1GZAk9Zo7IJ+zo6zluYSFvyqMFtTQWuJ9ztdSKVOQUasSvHnPt6bWWd2
         QHYoMNmEd3sPps+qinGY/BruqWwa2dgg13C7EpIw+uDYH0C0dS/mqFiUwOj8I17T5Wqf
         nGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5G4+fP9ti6jWKYWIDn+zl4F4FpE4x5za3vxrFwNcuQg=;
        b=JRBa3va/UQ40A/KV6vWSDNOW+A9fwHtPCvmcVSu6qKJuKXWFu4nV0wGR0GPkvfqP/z
         u2KuSACsV8IUtpkIVGzyx7je3gl/zYTKdC2O3Y9BqVrv6HkJEvwYGb9H7yQUUVY376rW
         r1UisvzuTeTKTjpeorTURXhUZCiVYeyJODCRQR2A95oftlDjVy444DAaTxH9RtgV5AJR
         9hCYuoHTiMdG7Dl5Rnj485kSAAUf1q0oS41oHIR89+TZzyciD1WVQwHhlglqQnbGyieq
         UtiO1SCQpbcZT45o+9Y5f1Md25aGfZhUegMgXHdXnOgKfPLm7f5tF0OmvgLgVetiDw9+
         wttg==
X-Gm-Message-State: AOAM5333Ko65hwnX2XbzVKrBD7X+4w95RumDyrjl0Of7wjVCnfSS9G0U
        s7NpOWSQFrVGHNOikhju1cuxaw==
X-Google-Smtp-Source: ABdhPJwp4w0Etg1akVTe4Bb5CGJsQhLYaeve1XdpuQb6cDwE3Dp1Ff6524NbC6j0r1yeOBP+knK7MQ==
X-Received: by 2002:a37:b95:: with SMTP id 143mr19143716qkl.99.1590426676978;
        Mon, 25 May 2020 10:11:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id v1sm11777246qkb.19.2020.05.25.10.11.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 10:11:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdGdA-0004S8-6X; Mon, 25 May 2020 14:11:16 -0300
Date:   Mon, 25 May 2020 14:11:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/9] RDMA/hns: Cleanups for 5.8
Message-ID: <20200525171116.GA17025@ziepe.ca>
References: <1589982799-28728-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589982799-28728-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 20, 2020 at 09:53:10PM +0800, Weihang Li wrote:
> These are some cleanups, include removing dead code, modifying
> varibles/fields types, and optimizing some functions.
> 
> Lang Cheng (3):
>   RDMA/hns: Let software PI/CI grow naturally
>   RDMA/hns: Add CQ flag instead of independent enable flag
>   RDMA/hns: Optimize post and poll process
> 
> Weihang Li (2):
>   RDMA/hns: Change all page_shift to unsigned
>   RDMA/hns: Change variables representing quantity to unsigned
> 
> Xi Wang (3):
>   RDMA/hns: Rename QP buffer related function
>   RDMA/hns: Refactor the QP context filling process related to WQE
>     buffer configure
>   RDMA/hns: Optimize the usage of MTR
> 
> Yangyang Li (1):
>   RDMA/hns: Remove unused code about assert

I'm going to take these anyhow, the field macros could be improved
someday if someone wanted. Applied to for-next

I have to say the patches coming lately from hns have been following
the kernel style and protocols much better. I'm also having a much
easier time understanding the commit message and what the patch is
trying to do. Keep it up!

Thanks,
Jason
