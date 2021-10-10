Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD25428041
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Oct 2021 11:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhJJJos (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Oct 2021 05:44:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230412AbhJJJos (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 10 Oct 2021 05:44:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3006460F9D;
        Sun, 10 Oct 2021 09:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633858969;
        bh=sAqR25dwG7tSbeuGzfn5VLMZuFullgGtTpopfC+YhHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WVvMNbCIrxD092Jxow2lPbbJukkIbUBzbuOD7H2+xX2zfQRGcobutaocMycqBKeBk
         mbRxo1xFX/ZSpPL9VuinjFq3dYVMMo+C6RvKN6Iq4HbY9zD4SgZR0f+HB7nWCsiTFh
         TH9bwWUgjEs+8v8ilupwhJXKOZjLH/65ZV6NIN/Oktq38Mmx55in5wglo/flbdWVJX
         0OxR4wtryQ10WOJ/R0TjdivA4PRN9R5gFtQ2zy2MIUo6bZmvONMgLGfnSC3+bAW7zF
         O8U+Bg/Xa4ckZC7Ovtr52WubSteIBOg88ylvJX/R6jxAaBmYQ0FcTIVfEcjDUQZrhO
         46pesFOpDHkQQ==
Date:   Sun, 10 Oct 2021 12:42:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc:     jgg@nvidia.com, dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Message-ID: <YWK1lZS/1SbMHyqn@unreal>
References: <20210823154816.2027-1-tatyana.e.nikolova@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823154816.2027-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 23, 2021 at 10:48:16AM -0500, Tatyana Nikolova wrote:
> Add ice and irdma to kernel-boot rules so that
> these devices are recognized as iWARP and RoCE capable.
> 
> Otherwise the port mapper service which is only relevant
> for iWARP devices may not start automatically after boot.
> 
> Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> ---
>  kernel-boot/rdma-description.rules | 2 ++
>  1 file changed, 2 insertions(+)

Tatyana,

Are you planning to resubmit it?

Thanks

> 
> diff --git a/kernel-boot/rdma-description.rules b/kernel-boot/rdma-description.rules
> index 48a7ced..f2f7b38 100644
> --- a/kernel-boot/rdma-description.rules
> +++ b/kernel-boot/rdma-description.rules
> @@ -24,11 +24,13 @@ DRIVERS=="hfi1", ENV{ID_RDMA_OPA}="1"
>  # Hardware that supports iWarp
>  DRIVERS=="cxgb4", ENV{ID_RDMA_IWARP}="1"
>  DRIVERS=="i40e", ENV{ID_RDMA_IWARP}="1"
> +DRIVERS=="ice", ENV{ID_RDMA_IWARP}="1"
>  
>  # Hardware that supports RoCE
>  DRIVERS=="be2net", ENV{ID_RDMA_ROCE}="1"
>  DRIVERS=="bnxt_en", ENV{ID_RDMA_ROCE}="1"
>  DRIVERS=="hns", ENV{ID_RDMA_ROCE}="1"
> +DRIVERS=="ice", ENV{ID_RDMA_ROCE}="1"
>  DRIVERS=="mlx4_core", ENV{ID_RDMA_ROCE}="1"
>  DRIVERS=="mlx5_core", ENV{ID_RDMA_ROCE}="1"
>  DRIVERS=="qede", ENV{ID_RDMA_ROCE}="1"
> -- 
> 1.8.3.1
> 
