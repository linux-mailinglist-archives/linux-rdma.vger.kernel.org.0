Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBD732FFCF
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Mar 2021 10:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhCGJM0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Mar 2021 04:12:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:38640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230442AbhCGJMJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 7 Mar 2021 04:12:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B997C65115;
        Sun,  7 Mar 2021 09:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615108329;
        bh=64r1NergPuPwb4MswX5BqdZcz+kmHeInEtFiaz12t+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sE4QM8B/N17NFBd0/E/whSAxXfVofIBAnL4vW3rfMh5KikYswO5+H1s4w2oLL8B49
         UFYo5pc722XhN9jIdnj1QTjXl2lOuPM74HX4wbxFtdLbIJ5d/6FMP5QpH+Lf7e7FUS
         hupoKdSFgCvxdIOgms/Lhysow3PjBv7SSFsbMh7lpTAvby1AoW/JANvlb7JbR9CsJM
         Kp1fYswJ+zq+JX6rD1oh0hpbFljsI+jTIOf8zrdlG6XYA7r2kPPulhaJS9CyBdV8J6
         ucS0xdguq7QP3lnhrG5dMJqV5iQjsyN5L+0KnP0bzlB7pTeIQKcz9U6T1JJcN7rIej
         7rR+sArHGx2Aw==
Date:   Sun, 7 Mar 2021 11:12:05 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     bharat@chelsio.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: hw: cxgb4: fix error return code of
 pass_open_rpl()
Message-ID: <YESY5fG5a8sCRiS7@unreal>
References: <20210306135317.17803-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210306135317.17803-1-baijiaju1990@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 06, 2021 at 05:53:17AM -0800, Jia-Ju Bai wrote:
> When ep is NULL, no error code of pass_open_rpl() is returned.
> To fix this bug, pass_open_rpl() returns -EINVAL in this case.

Why do you think that this is an error?
>
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/infiniband/hw/cxgb4/cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
> index 8769e7aa097f..773d3805bb25 100644
> --- a/drivers/infiniband/hw/cxgb4/cm.c
> +++ b/drivers/infiniband/hw/cxgb4/cm.c
> @@ -2382,7 +2382,7 @@ static int pass_open_rpl(struct c4iw_dev *dev, struct sk_buff *skb)
>
>  	if (!ep) {
>  		pr_warn("%s stid %d lookup failure!\n", __func__, stid);
> -		goto out;
> +		return -EINVAL;
>  	}
>  	pr_debug("ep %p status %d error %d\n", ep,
>  		 rpl->status, status2errno(rpl->status));
> --
> 2.17.1
>
