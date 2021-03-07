Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518FC32FFD2
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Mar 2021 10:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhCGJNa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Mar 2021 04:13:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:38912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231393AbhCGJN0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 7 Mar 2021 04:13:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C45D65135;
        Sun,  7 Mar 2021 09:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615108406;
        bh=SEZex5rnGZhTc5ZP5HkX8RmLz9ASnYMBQobd3oDgRO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=obhNE3LabZyZPW6jleR5IfMjeJ6Eblb2XtkZTZ/ReJFiZURpoWicIvKnH2Pa2otcZ
         1aolAOG4mph1LoVZAnSK+3UamsfI+dcPynGiMzXzqZ5eoMvj1IyZ5uyizgXqX7myEQ
         JE6UscMBjJ9VQSNUwFTW/G/SDdbL42T92++7wu8b37k/hwOi8mL7NoWoXFaIZuJcfp
         uK+JQBOZzUhlsACJ4wUcjvpkYD51L/Tr0VBJaKb97QPIn3bsNlszzoDlZnyZ+at3+T
         9FbDr6GI3p5qMWZROuDxvDtoSSmJuUTw7zXs04n4jgtZEQGsIOgmj8qsCLBxTqnZZb
         +Lc/J2w1uJdlw==
Date:   Sun, 7 Mar 2021 11:13:22 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     bharat@chelsio.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: hw: cxgb4: fix error return code of
 close_listsrv_rpl()
Message-ID: <YESZMn77CV7DJTUw@unreal>
References: <20210306135548.17939-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210306135548.17939-1-baijiaju1990@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 06, 2021 at 05:55:48AM -0800, Jia-Ju Bai wrote:
> When ep is NULL, no error code of close_listsrv_rpl() is returned.
> To fix this bug, close_listsrv_rpl() returns -EINVAL in this case.

I don't think that this is an error.

>
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/infiniband/hw/cxgb4/cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
> index 8769e7aa097f..94492d2dfdc7 100644
> --- a/drivers/infiniband/hw/cxgb4/cm.c
> +++ b/drivers/infiniband/hw/cxgb4/cm.c
> @@ -2400,7 +2400,7 @@ static int close_listsrv_rpl(struct c4iw_dev *dev, struct sk_buff *skb)
>
>  	if (!ep) {
>  		pr_warn("%s stid %d lookup failure!\n", __func__, stid);
> -		goto out;
> +		return -EINVAL;
>  	}
>  	pr_debug("ep %p\n", ep);
>  	c4iw_wake_up_noref(ep->com.wr_waitp, status2errno(rpl->status));
> --
> 2.17.1
>
