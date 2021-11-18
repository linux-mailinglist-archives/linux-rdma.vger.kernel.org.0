Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8ECC455C3D
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Nov 2021 14:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhKRNJT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Nov 2021 08:09:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229898AbhKRNHj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Nov 2021 08:07:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 291D461026;
        Thu, 18 Nov 2021 13:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637240678;
        bh=FX6L/sWvNE43wjd+TigeHsPb3cZQsArnu1HmaLjgDoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q5nlBNo/kABO7QmpMr0bG3vE5GIZRQ3UcU8gEX/1DP0smh16PIBcHgGu4FWXRhp9A
         iszSPSEGV0S33/W49QDnZ/oDVf84rLU5CN785lAewcugQ7gUfUVV1oCZOVKQlvIUCG
         vg7mDODzmHNOK4vcPntj9uzMr7OuJ1ouB7W01tx3L4v/GAwNIaCUa0ymttOIl3qgAa
         T5VQLttggTKYpJ8iUfShykfUfg2NhwmZ62uV7SD85boJievdiQfJoM7sTJUnPv2niz
         Bw8QU9x3R39hm8UV/V4UjM3XN1Xvv31JCbgzIqIc947lDS8q0EmkfmFFsfrbkQpsnG
         w1e8u47ECPHzA==
Date:   Thu, 18 Nov 2021 15:04:34 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Christian Benvenuti <benve@cisco.com>,
        Upinder Malhi <umalhi@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA: clean up usnic_ib_alloc_pd()
Message-ID: <YZZPYsPNrfSE5i34@unreal>
References: <20211118113924.GH1147@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118113924.GH1147@kili>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 18, 2021 at 02:39:24PM +0300, Dan Carpenter wrote:
> Remove the unnecessary "umem_pd" variable.  And usnic_uiom_alloc_pd()
> never returns NULL so remove the NULL check.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
