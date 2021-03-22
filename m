Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E78534471B
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 15:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhCVO14 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 10:27:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230364AbhCVO1Y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 10:27:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F8686197F;
        Mon, 22 Mar 2021 14:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616423240;
        bh=lUpsdR1/Qa0+MEXsmZEzBB4MkNLzq0yoCO/pf2fKJvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fT6Fv7v1BOXpon8Q/2bkWU0AAloiMIw25iMS8t8LlfplxBwMsWOuuYRaVfReyhOe/
         29EG3ieGAtuGdL3w6EnigMsgjSP2zjaZiqXvqFNZzrg7eCzihfNpyaKrMNt1rvuFFn
         2XzsuVbMpWxOCIe/kJ6hTeZ5xXXqyTI5jr4DOQqztV/5iT4xbL6Cp5QL+u54vWS1E/
         fw0SkRtbb7il7MfZG9jz6QPODsaktthpSG70vbcQuVXFLti6+xK4uHc55f8m7LhsCa
         UhS5Ys9p0u0Ug7I0bP0N4vpSV19NWHWz6icQ2+X2AsFKo/atRGDTpmH89rQrjrtHtg
         5BHbhxp29cv5w==
Date:   Mon, 22 Mar 2021 16:27:17 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     sagi@grimberg.me, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: Fix a use after free in isert_connect_request
Message-ID: <YFipRTHpr8Xqho4V@unreal>
References: <20210322135355.5720-1-lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322135355.5720-1-lyl2019@mail.ustc.edu.cn>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 22, 2021 at 06:53:55AM -0700, Lv Yunlong wrote:
> The device is got by isert_device_get() with refcount is 1,
> and is assigned to isert_conn by isert_conn->device = device.
> When isert_create_qp() failed, device will be freed with
> isert_device_put().
> 
> Later, the device is used in isert_free_login_buf(isert_conn)
> by the isert_conn->device->ib_device statement. My patch
> exchanges the callees order to free the device late.
> 
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>  drivers/infiniband/ulp/isert/ib_isert.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

The fix needs to be change of isert_free_login_buf() from
isert_free_login_buf(isert_conn) to be isert_free_login_buf(isert_conn, cma_id->device)

Thanks

> 
> diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
> index 7305ed8976c2..d8a533e346b0 100644
> --- a/drivers/infiniband/ulp/isert/ib_isert.c
> +++ b/drivers/infiniband/ulp/isert/ib_isert.c
> @@ -473,10 +473,10 @@ isert_connect_request(struct rdma_cm_id *cma_id, struct rdma_cm_event *event)
>  
>  out_destroy_qp:
>  	isert_destroy_qp(isert_conn);
> -out_conn_dev:
> -	isert_device_put(device);
>  out_rsp_dma_map:
>  	isert_free_login_buf(isert_conn);
> +out_conn_dev:
> +	isert_device_put(device);
>  out:
>  	kfree(isert_conn);
>  	rdma_reject(cma_id, NULL, 0, IB_CM_REJ_CONSUMER_DEFINED);
> -- 
> 2.25.1
> 
> 
