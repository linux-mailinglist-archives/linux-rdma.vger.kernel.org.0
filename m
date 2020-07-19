Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBF72251E6
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jul 2020 14:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgGSMvg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Jul 2020 08:51:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:32942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgGSMvf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 19 Jul 2020 08:51:35 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A38420809;
        Sun, 19 Jul 2020 12:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595163095;
        bh=SJ4NWVZk5/wVvAa19846pBQA1rQAoZBQRt7ncBrO/Fk=;
        h=From:Date:To:Cc:Subject:References:In-Reply-To:From;
        b=d4O5EdniwwgaKrPhBNznwVCRUh+e5kVDHqg5d6k4YaJtuW/vXkGmUNIRUWVsgYvyc
         ZWubS805FHxJlqC+H+ZT/dZEZKZqVc/i6lilqkLv90XtLpUShI+ZkKcfbh51lHhV1O
         PjZivKMtNmQmTpbRRe/bzyBX3WSsiDAwDp6d+Zs4=
From:   leon@kernel.org
Date:   Sun, 19 Jul 2020 15:51:31 +0300
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     kernel test robot <lkp@intel.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/2] RDMA/uverbs: Remove redundant assignments
Message-ID: <20200719125131.GD127306@unreal>
References: <20200719060319.77603-1-leon@kernel.org>
 <20200719060319.77603-2-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719060319.77603-2-leon@kernel.org>
erom:   Leon Romanovsky <leonro@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 19, 2020 at 09:03:18AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>
> The kbuild reported the following warning, so clean whole uverbs_cmd.c file.
>
>    drivers/infiniband/core/uverbs_cmd.c:1066:6: warning: Variable 'ret'
> is reassigned a value before the old one has
> been used. [redundantAssignment]
>     ret = uverbs_request(attrs, &cmd, sizeof(cmd));
>         ^
>    drivers/infiniband/core/uverbs_cmd.c:1064:0: note: Variable 'ret' is
> reassigned a value before the old one has been
> used.
>     int    ret = -EINVAL;
>    ^
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/uverbs_cmd.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index a66fc3e37a74..7d2b4258f573 100644
> --- a/drivers/infiniband/core/uverbs_cmd.c
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -558,9 +558,9 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
>  	struct ib_uverbs_open_xrcd	cmd;
>  	struct ib_uxrcd_object         *obj;
>  	struct ib_xrcd                 *xrcd = NULL;
> -	struct fd			f = {NULL, 0};
> +	struct fd f = {};
>  	struct inode                   *inode = NULL;
> -	int				ret = 0;
> +	int ret;
>  	int				new_xrcd = 0;
>  	struct ib_device *ib_dev;
>
> @@ -761,7 +761,7 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
>  {
>  	struct ib_uverbs_rereg_mr      cmd;
>  	struct ib_uverbs_rereg_mr_resp resp;
> -	struct ib_pd                *pd = NULL;
> +	struct ib_pd *pd;

This line shouldn't be changed, PD is passed as an argument to ops.rereg_user_mr.

Thanks
