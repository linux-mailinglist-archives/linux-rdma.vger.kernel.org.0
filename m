Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB074690C5
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 08:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238367AbhLFH1e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 02:27:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49032 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238458AbhLFH1d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 02:27:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD51061179
        for <linux-rdma@vger.kernel.org>; Mon,  6 Dec 2021 07:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B72C341C1;
        Mon,  6 Dec 2021 07:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638775444;
        bh=aKh2wXIGr8xIlGfeMVoIayXFKiuw+YMqcy2S9WXSh+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tOfY5lWDf405Bf1Ykad8Lw//gjV0raQnrxK4bN6Kjv5Gi3nA1juql/4dCXdzq8w6e
         3KjPcSu9Da/+FsqRAKMSKtJHfmWeM5Sh1QBiZscYgoXfchaGuHLCPa4ccvfVHtWcpb
         qHnA6UE8UDccsy9gQHaoMDbl1/t/jbL4OMWaqNpsgKhDmmL2znUuWaYxDQsFPw7B0m
         sW5Ln7YFTXI89+fKifHp1Pm7ru6lRJbqkersd7XqPFzeH174R2WapwOGKZLO2HZDiA
         jZrulLNSvdu+viS2r+k65kBsFZH4dHgzwoNHrTqFytIapA9DM9hUaIb2lNJ87DTCHV
         uQtmc8xGNFjhw==
Date:   Mon, 6 Dec 2021 09:23:59 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH for-next] RDMA/bnxt_re: Fix endianness warning
Message-ID: <Ya26j0Amo7ENQCYz@unreal>
References: <20211205204537.14184-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205204537.14184-1-kamalheib1@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Dec 05, 2021 at 10:45:37PM +0200, Kamal Heib wrote:
> Fix the following sparce warning:
> CHECK   ../drivers/infiniband/hw/bnxt_re/qplib_fp.c
> drivers/infiniband/hw/bnxt_re/qplib_fp.c:1260:26: sparse: warning:
>  incorrect type in assignment (different base types)
> 
> Fixes: 0e938533d96d ("RDMA/bnxt_re: Remove dynamic pkey table")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

sparce -> sparse

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
