Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5439F15AFB3
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2020 19:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgBLS0k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Feb 2020 13:26:40 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43999 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBLS0k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Feb 2020 13:26:40 -0500
Received: by mail-qk1-f196.google.com with SMTP id p7so2998326qkh.10
        for <linux-rdma@vger.kernel.org>; Wed, 12 Feb 2020 10:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wD7ca8ui9JD8LMdNREOPeIgqUH0cHkM1dV/OrQ6yngo=;
        b=RGjvq2xWzc79Xm/Nld1dr0HZB/tikBbbAeBjjArZL38LZsGdtv+OORoQficoyvFxfY
         DtmAolxkHh5QF5U4LQzyDWvrVYIPZdRiqwbnF+7Sb3GCSMfsoDPYVm/xcIeR+BkTyrz3
         rhbBJpsbScmjJuQn4Votvs69+/D1YHBMrkS2ouCnLYMUZIEyUc7ZsB+w2ffQs+Gg6tVg
         Qno90t1NWI0xPRxGICzGS2GwwVNbtTBbaNPEMbt12IEMk0DUzZVyvFOg3JtXk0uge9JV
         xEPW2ttrpZ77AvySwIYeiMZmpfMD9o5/iGQiy4G1nmq8OLgfxvJj9QMaevLMTfsJc87u
         MoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wD7ca8ui9JD8LMdNREOPeIgqUH0cHkM1dV/OrQ6yngo=;
        b=huFXg6nhmaiRMZLcJl4HWLuwOxLN8d05ypCIewYhkUPZqzYAW38HyOQRBbA7XT414r
         ka6F7AIfj+6+NeXJlgIiSNXBy47SqSHhZjo2JjWyquIlGa7pJ9xxQWS7fJODjac1WzRT
         GCjEBfN2eL38LTh2S1TyvV3KIAHiT9OO/FIixxcf4Kpdevq7+fUb+HKJKoUYHPyv2fjC
         YqIGUTRRQJAQH7e0YNnl57a/lJ2sqzPhCPiLMXlOS6sAQTCo6avjGFYxECWa63sJCju0
         PLmk6LcbBgzhrelKMc+DLKjvA50Vjr7hB7X9V6xYWxWCQ88QYsHsmaoaJgKq3ggyKfgZ
         /Fog==
X-Gm-Message-State: APjAAAVcObwvgkXguGZA9gubLHM8hjZgGRj8qAI8VXmMGbiGajgV5SWq
        dcm5sxYIHnppLx9xkftk52JAsg==
X-Google-Smtp-Source: APXvYqzIhCM7PJ9kO6iGCS8YvOUMzdb3pLAxLWQH7rCiIoiwCeqmXT3mDIR2uOcEeWiMbbfpTVOiag==
X-Received: by 2002:a37:5347:: with SMTP id h68mr8499986qkb.393.1581531999443;
        Wed, 12 Feb 2020 10:26:39 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 63sm630487qki.57.2020.02.12.10.26.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 10:26:38 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j1wic-0007oE-AC; Wed, 12 Feb 2020 14:26:38 -0400
Date:   Wed, 12 Feb 2020 14:26:38 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     anna.schumaker@netapp.com, linux-nfs@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3 1/2] xprtrdma: Fix DMA scatter-gather list mapping
 imbalance
Message-ID: <20200212182638.GA31668@ziepe.ca>
References: <158152363458.433502.7428050218198466755.stgit@morisot.1015granger.net>
 <158152394998.433502.5623790463334839091.stgit@morisot.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158152394998.433502.5623790463334839091.stgit@morisot.1015granger.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 12, 2020 at 11:12:30AM -0500, Chuck Lever wrote:
> The @nents value that was passed to ib_dma_map_sg() has to be passed
> to the matching ib_dma_unmap_sg() call. If ib_dma_map_sg() choses to
> concatenate sg entries, it will return a different nents value than
> it was passed.
> 
> The bug was exposed by recent changes to the AMD IOMMU driver, which
> enabled sg entry concatenation.
> 
> Looking all the way back to commit 4143f34e01e9 ("xprtrdma: Port to
> new memory registration API") and reviewing other kernel ULPs, it's
> not clear that the frwr_map() logic was ever correct for this case.
> 
> Reported-by: Andre Tomt <andre@tomt.net>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Cc: stable@vger.kernel.org # v5.5
> ---
>  net/sunrpc/xprtrdma/frwr_ops.c |   13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Yep

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
