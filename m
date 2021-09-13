Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A0A40895B
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 12:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbhIMKuj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 06:50:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239171AbhIMKuh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Sep 2021 06:50:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C6B160FF2;
        Mon, 13 Sep 2021 10:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631530159;
        bh=RVBGAIhg3jBv6SzjpF+toxl7/Z6tQn9VqPcAydocE5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iHOAcTRxD6KI7ZE2KMAOIOT0KoTGAM233ivCYuFChly1O68Z3Y5Mp+PrOlTNwooP8
         wpG6wop/PT2dyAB3iBFizxf60ftg7DZcWpkbKx17ID2nCD7Rw4YFruJA6Vn9oBOr2s
         FEawKEVG5G+RjZTDCL2uW9yBhmCoQJAdMvGhzp1FqFwcukEj7S6TWoPobLd/tXQMv/
         3bNGV9X2A4H732/dIs8+BpmPZYSL6s6aWjClAcQB0TM544uZ6df0SAvGVNTw9zSr2Z
         JWqy9du8ZviKdfN+VPSpjXQ+SDwqEpfIXIidArqS6ABx48BwfSu64GncHKaFuIJhF6
         PNIQA/1SNuoGw==
Date:   Mon, 13 Sep 2021 13:49:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 04/12] RDMA/bnxt_re: Reduce the delay in polling
 for hwrm command completion
Message-ID: <YT8srBnmRb5qj2pE@unreal>
References: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
 <1631470526-22228-5-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631470526-22228-5-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 12, 2021 at 11:15:18AM -0700, Selvin Xavier wrote:
> Driver has 1ms delay between the polling for atomic command completion.
> Polling immediately after issuing command usually doesn't report
> any completions. So all commands in the blocking path needs two
> iterations. So effectively 1ms spend on each command. HW requires
> much lesser time for each command. So reduce the delay to 1us
> and increase the iteration count to wait for the same time.
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 2 +-
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
