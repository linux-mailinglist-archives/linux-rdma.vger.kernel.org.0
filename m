Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2033775F3
	for <lists+linux-rdma@lfdr.de>; Sun,  9 May 2021 11:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhEII7U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 May 2021 04:59:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhEII7T (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 9 May 2021 04:59:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 297196140A;
        Sun,  9 May 2021 08:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620550696;
        bh=PcMjlLJocNQns2vKI2Mcx1MouVYWg+3v61Punsj0VxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VVW/uJ4XMjbWJE+b5/8orGzzZtdEh4W/lIQcI9mDBGhH/Jv8Oa2gnY1VsQUgfl6p9
         7LKESqyoRopKzNjCVGtCzu0641w0u+Gy5lkLXWFD21a2set6adJAHAT2Ms8OWHrMhO
         W68JfHMGqS9Qh2h5a+6lSLYupw0t9Gpdht5bA22EdyPYW0du46MDviMzje8B8ZsC2u
         M7ATMsxU0Sl/wS0JVNx1+Dellul2MGlvT25r70oURpT9kWbC8OcxTd6S9cdwImv5XE
         iTMxlCSHRvtmCc2dAG9AZmnsbZlsPpzI9YqhEUTfnQbOHSqJKfxsXJ/3Nd4MmZO24A
         1SUz/QudfBmuw==
Date:   Sun, 9 May 2021 11:58:13 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     yishaih@nvidia.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx4: Remove unnessesary check in
 mlx4_ib_modify_wq()
Message-ID: <YJekJchyiVv2D+TO@unreal>
References: <1620382961-69701-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620382961-69701-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 07, 2021 at 06:22:41PM +0800, Jiapeng Chong wrote:
> cur_state and new_state are enums and when GCC considers
> them as unsigned, the conditions are never met.
> 
> Clean up the following smatch warning:
> 
> drivers/infiniband/hw/mlx4/qp.c:4258 mlx4_ib_modify_wq() warn: unsigned
> 'cur_state' is never less than zero.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/mlx4/qp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
