Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB713429DA6
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Oct 2021 08:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhJLGZU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Oct 2021 02:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233085AbhJLGZT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 Oct 2021 02:25:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19C5560EDF;
        Tue, 12 Oct 2021 06:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634019798;
        bh=GdcaW52Qft7w3IzkVpFppX5OfAJA+jde2Qeea4ajf00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MtXbXT9dgjwLHd0+J5Ez9y5dpn8ebX8/WKkKae6bIyFpfrI34iBFImb3DEfW4xDMw
         4rjSku5U1W8QHnAIueMK8WbqbGLf4+DAaWt9NUikDrGbdHnG8lt6lGs5qzpcipYrlV
         uYSz8fw0qFrimABHT22OQ2vJzUkSbLUQPockPoQWRGZwUY2NsUYgTfTsgyk2R5ZsNA
         aA/MkoM/uHzxHUUdmtN2GHusHgn33LHf+VFrTmlfiN9JzeUvKu78FentKlRCb2IKs6
         mKF/I7iLiEf5J/GZl+Ne8QD0rIJ6u9dYBetq3O9R46pgrgldowianuRjvJOS7Djtq/
         iCb54/ImmnPSg==
Date:   Tue, 12 Oct 2021 09:23:14 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dledford@redhat.com, jgg@ziepe.ca, bharat@chelsio.com,
        yishaih@nvidia.com, bmt@zurich.ibm.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA: Remove redundant 'flush_workqueue()' calls
Message-ID: <YWUp0s6TD6R1cse8@unreal>
References: <ca7bac6e6c9c5cc8d04eec3944edb13de0e381a3.1633874776.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca7bac6e6c9c5cc8d04eec3944edb13de0e381a3.1633874776.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 10, 2021 at 04:08:10PM +0200, Christophe JAILLET wrote:
> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
> 
> Remove the redundant 'flush_workqueue()' calls.
> 
> This was generated with coccinelle:
> 
> @@
> expression E;
> @@
> - 	flush_workqueue(E);
> 	destroy_workqueue(E);
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/core/sa_query.c        | 1 -
>  drivers/infiniband/hw/cxgb4/cm.c          | 1 -
>  drivers/infiniband/hw/cxgb4/device.c      | 1 -
>  drivers/infiniband/hw/mlx4/alias_GUID.c   | 4 +---
>  drivers/infiniband/sw/siw/siw_cm.c        | 4 +---
>  drivers/infiniband/ulp/ipoib/ipoib_main.c | 1 -
>  6 files changed, 2 insertions(+), 10 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
