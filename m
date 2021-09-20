Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5101411560
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Sep 2021 15:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhITNUB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Sep 2021 09:20:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233139AbhITNUB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Sep 2021 09:20:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3A5760EB6;
        Mon, 20 Sep 2021 13:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632143914;
        bh=Y2J0IeF0q/cehNxRUBp40t2TG1Q7OJzW6vVRppT8Blw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dNaRAE6Kxt+XfyhM8AeU4yf1pQEswVD0X4jYZZrAQUxJfPaDf4oBzz009r7feE0ey
         WW7K+2q1iPIGV0xI0EFn4NTqV/NWXJYfANQHpxt9SAyJdNmNKxOGQ3rzwAmMIlp5Ue
         +fcjVTPJMNvIcbe5lT7WbaKdpjtzId1fQ+uNbOaDiOz5E4uoDn77J91kxvuiw0kvSS
         Sk0g5EfduPWRUDR8wMyCZjiKUQM/wnKWfvbUglQSfuI56aYpFz0lbxS/iZjYgbEIhm
         tQO4MUVvdjfPdgcstPtvJjbv/Zizk/kADx/wgLYGkLmh+y3Ff28H00AnrHj9aS/cLq
         xMAhL97wzZC+A==
Date:   Mon, 20 Sep 2021 16:18:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 05/12] RDMA/bnxt_re: Support multiple page
 sizes
Message-ID: <YUiKJn7fbL5nMcjT@unreal>
References: <1631709163-2287-1-git-send-email-selvin.xavier@broadcom.com>
 <1631709163-2287-6-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631709163-2287-6-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 15, 2021 at 05:32:36AM -0700, Selvin Xavier wrote:
> HW can support multiple page sizes. Enable bits
> for enabling sizes from 4k to 1G by reporting
> page_size_cap.
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
> v1->v2:
> 	Removed the unused macros
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h  | 14 ++------------
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c |  4 ++--
>  2 files changed, 4 insertions(+), 14 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
