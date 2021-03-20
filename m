Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE57F342CB7
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Mar 2021 13:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhCTMOM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 20 Mar 2021 08:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhCTMNn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 20 Mar 2021 08:13:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CE5A61974;
        Sat, 20 Mar 2021 09:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616232926;
        bh=uTZXTv9ZOUKkfEsnsshjDLCdyqUUK2b5LjxMOoLhzGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lFL+PuGZQyxa8fgGUH5HZn06FX5TNpVNuY+MpJ6LOQqCl2EV0+9Jb3L3A+iXjUBkk
         rXZxaCGEs+AdLxAKQwj8X/+Q4yFZk8YaPpohzKx+algOfTlozR9RSZ279Mum7l3cHH
         JVdhqXjy6b6lTJlfadfhwWIUlLPrGGH1wm3BjUlUnNfxEyOCzG6vMlf4RU2hM/Bn7U
         QO0qpucA5/eN3yM6j0MSZbkTIgVkAbmtjMQ+IwoJ/SUosdQUKI+9dHyGz9oKM3AX9Y
         SP2SISFYD+iyAty+z3Vm+EwG73GVF810p4Is2BP+b1TQHDtWU6tMr678DN+mDmYE+b
         R8WzcnrL35s9A==
Date:   Sat, 20 Mar 2021 11:35:22 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/core: Correct misspellings of two words in
 comments
Message-ID: <YFXB2uRSd7gtj9Yz@unreal>
References: <1616147749-49106-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616147749-49106-1-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 19, 2021 at 05:55:49PM +0800, Weihang Li wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
> 
> Correct the following spelling errors:
> 1. shold -> should
> 2. uncontext -> ucontext
> 
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/core/rdma_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
