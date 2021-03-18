Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1F23400AB
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Mar 2021 09:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCRIJg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Mar 2021 04:09:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhCRIJZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Mar 2021 04:09:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2D1464EE7;
        Thu, 18 Mar 2021 08:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616054964;
        bh=WPxDclEB0X5omHeU6WqS1JrTWWPC6yzLbdK0Ig43btw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cGg3vf2g/x9iShtKSHnftkmE4kO8OUPNOYAjjP8FZE8kTZk7q4/4XfOlbv14OhZlC
         aCBQVDqY0uL/53Ntk78uQ5SlvpNbOFnHLIHQNotiORW03c/oECrDALthE8ruxlzHrf
         7MDClbnplkixJVvN8aKPLGCf/ygY5HKYyx4oPXTUXpWNp8mHGqL7FBBgpBjLh/QZR6
         6SZjz6Nu/3MDY7H/HsM4Spvypvb0Gsuc00ivO3zocwVrSLUzWhn+n1Gk//so0/uXwr
         ytnHlNJIhCI2C/DxGySAiwgV6iJxVth5Q8j8wSjDcz7SIeeP+tn1VktHj3MGpgDiYB
         wSRzVFBCAom/g==
Date:   Thu, 18 Mar 2021 10:09:20 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/cma: Remove unused leftovers in cma code
Message-ID: <YFMKsBlAD+Elv70T@unreal>
References: <20210314143427.76101-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314143427.76101-1-galpress@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 14, 2021 at 04:34:27PM +0200, Gal Pressman wrote:
> Commit ee1c60b1bff8 ("IB/SA: Modify SA to implicitly cache Class Port info")
> removed the class_port_info_context struct usage, remove a couple of
> leftovers.
>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/core/cma.c | 9 ---------
>  1 file changed, 9 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
