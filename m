Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A23F6F86C3
	for <lists+linux-rdma@lfdr.de>; Fri,  5 May 2023 18:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjEEQcl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 May 2023 12:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjEEQck (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 May 2023 12:32:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D30A255;
        Fri,  5 May 2023 09:32:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F2CD60F13;
        Fri,  5 May 2023 16:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0FCC433EF;
        Fri,  5 May 2023 16:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683304358;
        bh=F8Pcuij3dAuNBRRdWfXIz2M2vKjF/5eyboVxzllRmRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z5oSX760hWQUUvH9I9I8xdaoGa0plTsNBol4+OrtEvmrAzYY620KWn21VGTpWfBGq
         BiWZPBvFU4drrP/tn6/OhwxVlaow/+EOkiEMu5EVKi9XIdkU9VKAobDDqFt7+fZsHx
         A4ji6S5ehEirWrVQWDuP9qZyGcBmDRvSZEt/tZVfU1DPfpqdL/LHIg/2hhb8fx+jeh
         ku3ASXI2zmXtNrcOMmWzTROLJ3FmVs2ZKmPIZSjmP/KE9GanAiT1K6pJ/UWy0P1a2X
         7mfalGE3Nts2TEK9dPoTjYroAGVFDv7h21x4L2lXFBbicx1Ej0ct1NzWXlPUa4OmWr
         znWSyYhdL8jrQ==
Date:   Fri, 5 May 2023 19:32:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     jgg@ziepe.ca, jiangjian@cdjrlc.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Use fdget() and fdput()
Message-ID: <20230505163234.GB525452@unreal>
References: <202305051133576690069@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305051133576690069@zte.com.cn>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 05, 2023 at 11:33:57AM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> convert the fget()/fput() uses to fdget()/fdput().

Why? What is wrong with current implementation?

Thanks

> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/infiniband/core/rdma_core.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
> index 29b1ab1d5f93..c35df0b27e86 100644
> --- a/drivers/infiniband/core/rdma_core.c
> +++ b/drivers/infiniband/core/rdma_core.c
> @@ -335,7 +335,7 @@ lookup_get_fd_uobject(const struct uverbs_api_object *obj,
>  		      enum rdma_lookup_mode mode)
>  {
>  	const struct uverbs_obj_fd_type *fd_type;
> -	struct file *f;
> +	struct fd f = fdget(fdno);
>  	struct ib_uobject *uobject;
>  	int fdno = id;
> 
> @@ -350,18 +350,17 @@ lookup_get_fd_uobject(const struct uverbs_api_object *obj,
>  	fd_type =
>  		container_of(obj->type_attrs, struct uverbs_obj_fd_type, type);
> 
> -	f = fget(fdno);
> -	if (!f)
> +	if (!f.file)
>  		return ERR_PTR(-EBADF);
> 
> -	uobject = f->private_data;
> +	uobject = f.file->private_data;
>  	/*
>  	 * fget(id) ensures we are not currently running
>  	 * uverbs_uobject_fd_release(), and the caller is expected to ensure
>  	 * that release is never done while a call to lookup is possible.
>  	 */
> -	if (f->f_op != fd_type->fops || uobject->ufile != ufile) {
> -		fput(f);
> +	if (f.file->f_op != fd_type->fops || uobject->ufile != ufile) {
> +		fdput(f);
>  		return ERR_PTR(-EBADF);
>  	}
> 
> -- 
> 2.25.1
