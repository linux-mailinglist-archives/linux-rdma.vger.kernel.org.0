Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FF4375136
	for <lists+linux-rdma@lfdr.de>; Thu,  6 May 2021 11:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbhEFJFR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 05:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233765AbhEFJFR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 May 2021 05:05:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50434611AD;
        Thu,  6 May 2021 09:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620291859;
        bh=t5kO1RsBj6L282zo2Irz4ki0RAdod79K0nlUviJ0DRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dr53OI1jURTtSScsXd57eUQ9+2gsxRRQ5HE8nSaQjtxPiDpLi1OUYk3IfWGj50WeL
         lsxXsfBKQNaS+YCt6aFGYEhLMDYppmMkoj2RghPGPa9dOnlYwDgW/Z1iB+QG4vmW4s
         Gk/1EOtZD7f4bze/Q7+pGvLY54pEPJ7s5rcpoS/0Hn4AkRYbBEge0u0HX+ubH1kQz6
         Df12ZMnE4yAi3Tu3O9pFA/CxKkD3QLThxqeUZqxdIyCRbmUhgELaVBHyoi4xl7yE1L
         9vqEGnKxBguWG2hgrXUaAhazZeSSIw595UkjoOy1VFO9RLIBgREWYGb/Yu4+PiIKR6
         VMaEA2aSKQD0w==
Date:   Thu, 6 May 2021 12:04:14 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     jgg@ziepe.ca, liweihang@huawei.com, liangwenpeng@huawei.com,
        shiju.jose@huawei.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH] RDMA/ucma: Cleanup to reduce duplicate code
Message-ID: <YJOxDlL1v9bV0dZf@unreal>
References: <1620291106-3675-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620291106-3675-1-git-send-email-tanxiaofei@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 06, 2021 at 04:51:46PM +0800, Xiaofei Tan wrote:
> The lable "err1" does the same thing as the branch of copy_to_user()
> failed in the function ucma_create_id(). Just jump to the label directly
> to reduce duplicate code.
> 
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> ---
>  drivers/infiniband/core/ucma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
