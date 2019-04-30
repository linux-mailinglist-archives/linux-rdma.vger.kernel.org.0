Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 008C7FF22
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 19:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfD3RyL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 13:54:11 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39286 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfD3RyL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Apr 2019 13:54:11 -0400
Received: by mail-yw1-f65.google.com with SMTP id x204so582704ywg.6
        for <linux-rdma@vger.kernel.org>; Tue, 30 Apr 2019 10:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1JNp+4ItAftQLKZcPu/PSkolskxHpXOZVtTnmsVTYEs=;
        b=duwg7sSKXApgguEvbxCMXhjQyfZ9bndnzLEy35/e17yhBbe188q2qgb4gzPj9mgXxp
         Fj5VC9MnoNfcTnKkrKgtEsPEzwc57ZRgOMqtGatNgTy70BNjM9jul3Knt265dscUiIbU
         aGhDGZ5NUhP1TXPgVS2qGxlB6mRf5pXXmdv/NU8yblkYU/PwbdIHlnMVFEOrXcZRRn4x
         POHlbdw9+HzzvVoSAvzN2cDEs8DghwhqJ3Xoc7ibp85LnjIc+73L+x5ko/W8BwH+hnj/
         ZUpdKTjFWGHSh9ZX4ayjsbxWLEubdDCdW/HXv6U5bpGmCvUJkgEn5MY4XZyIQYUNWPC+
         +mXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1JNp+4ItAftQLKZcPu/PSkolskxHpXOZVtTnmsVTYEs=;
        b=Fp9xtEVz8V3sBsd9fBTOw90Eb/v26AduiVzHc0RixA7uNB8+O6CDKwQziArgE6Ndok
         P0nG9Gc4bg1odNBNUBch/S4n1HJdpTKN8ae0LhYom5o0R1lgxAA5pIrU6lkscNOapzzq
         vu2YocUA/69sSkXuZ9llLu2Rju9TN6UCSgnDnTCY1ajxyp+0OukoyuRaaoxv53tZ/N+4
         jGzdeHbLwD0IgcF0JiKWwbc7SNTQ8v9XSWI+jcvWq6p8apcG8UplVaGLrR9IvfZGI09P
         q8XcfWL1lFhqn8OzsJi0USuAgiQ9BU3tFEcXcRPQY73Xo30bg+O5mS9vcpMRjfsOLSc6
         xaEw==
X-Gm-Message-State: APjAAAV9p1MQqnudzHcDiXz/ku46z+Jvhwp4Ov2M1yR7+Bk7++Bn+p7S
        JXGfB2tq9SGwMWG7kii0Iw8aFg==
X-Google-Smtp-Source: APXvYqwgPeU+bzSgAR06Yk+kx0cO82koGYqOfy1HF7Sl+2eiylKlginCXxshiRon35VVjTwQo9knYA==
X-Received: by 2002:a0d:db08:: with SMTP id d8mr49345516ywe.86.1556646850069;
        Tue, 30 Apr 2019 10:54:10 -0700 (PDT)
Received: from ziepe.ca (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id f85sm5173247ywb.8.2019.04.30.10.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 10:54:09 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hLWxE-0002Cb-5E; Tue, 30 Apr 2019 14:54:08 -0300
Date:   Tue, 30 Apr 2019 14:54:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leon@kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH for-next v1 2/4] RDMA/uverbs: uobj_get_obj_read should
 return the ib_uobject
Message-ID: <20190430175408.GA8101@ziepe.ca>
References: <20190430142333.31063-1-shamir.rabinovitch@oracle.com>
 <20190430142333.31063-3-shamir.rabinovitch@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430142333.31063-3-shamir.rabinovitch@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 30, 2019 at 05:23:22PM +0300, Shamir Rabinovitch wrote:
> future patch will remove the ib_uobject pointer from the ib_x
> objects. the uobj_get_obj_read and uobj_put_obj_read macros
> were constructed with the ability to reach the ib_uobject from
> ib_x in mind. this need to change now.
> 
> Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
>  drivers/infiniband/core/uverbs_cmd.c | 165 +++++++++++++++++++++------
>  include/rdma/uverbs_std_types.h      |   8 +-
>  2 files changed, 137 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 76ac113d1da5..93363c41e77e 100644
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -37,6 +37,7 @@
>  #include <linux/fs.h>
>  #include <linux/slab.h>
>  #include <linux/sched.h>
> +#include <linux/list.h>
>  
>  #include <linux/uaccess.h>
>  
> @@ -700,6 +701,7 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
>  	struct ib_uverbs_reg_mr      cmd;
>  	struct ib_uverbs_reg_mr_resp resp;
>  	struct ib_uobject           *uobj;
> +	struct ib_uobject           *pduobj;
>  	struct ib_pd                *pd;
>  	struct ib_mr                *mr;
>  	int                          ret;
> @@ -720,7 +722,8 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
>  	if (IS_ERR(uobj))
>  		return PTR_ERR(uobj);
>  
> -	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
> +	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs,
> +			       pduobj);

This should be &pduobj in all places so it reads sensibly..

> @@ -2009,6 +2034,12 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
>  	const struct ib_sge __user *sgls;
>  	const void __user *wqes;
>  	struct uverbs_req_iter iter;
> +	struct uobj_list_item {
> +		struct list_head list;
> +		struct ib_uobject *uobj;
> +	};
> +	struct uobj_list_item *item, *tmp;
> +	LIST_HEAD(ud_uobj_list);

I'd rather not add this for AH's if we don't plan to drop the uobject
pointer right away.. Same for the other place making a big logic
change

Jason
