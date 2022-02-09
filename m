Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D5B4AF4AF
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Feb 2022 16:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbiBIPEK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Feb 2022 10:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiBIPEH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Feb 2022 10:04:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACA4C0613C9;
        Wed,  9 Feb 2022 07:04:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 449AC60C2C;
        Wed,  9 Feb 2022 15:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972F2C340E7;
        Wed,  9 Feb 2022 15:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644419049;
        bh=rnl42XryuAYpZ/26n1PZFSAKonH9klc6797clpNBQJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lZCvu2+/FnkDSxI3812SQGZcelt2I2ObLTUtnTFCWXR6Qvg2iZ0Q+bKoEnBxNgdxm
         wwTUIaGECJsR+ZyU0zfDRPY4HBnSz5kO8DP3rF7lASA+VFegwKlKq6NlC7IsWXYuL5
         HRbHP/uylGjXJJT76PYY2nPWz4xa7FjcHjaP5/1Wuttnfzn3seoWAbQDZ9dPvVnOcL
         NIgygEYtjBEsu9eZq4O535/my6WDm7yxn7nqWoKh1SBukIj2siz0GECp+Dyes8JJK8
         TnbMc5fhyoUd4e2a+VGmk4PhxrBeBImsqy9gtC6mMFpMZWw7wibvTi7Ix1PAZrW04+
         SBKkNYvCAkODA==
Date:   Wed, 9 Feb 2022 17:04:02 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-rc] IB/cma: Allow XRG INI QPs to set their local ACK
 timeout
Message-ID: <YgPX4lxiNcT7Gx9t@unreal>
References: <1644412980-28424-1-git-send-email-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1644412980-28424-1-git-send-email-haakon.bugge@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 09, 2022 at 02:23:00PM +0100, Håkon Bugge wrote:
> XRC INI QPs should be able to adjust their local ACK timeout.
> 
> Fixes: 2c1619edef61 ("IB/cma: Define option to set ack timeout and pack tos_set")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> Suggested-by: Avneesh Pant <avneesh.pant@oracle.com>
> 
> ---
> 
> To avoid excessive discussions around the *if (WARN_ON( ...*
> construct, just saying that it has been sanctioned by Jason here:
> 
> https://lore.kernel.org/linux-rdma/20210413135120.GT7405@nvidia.com/

And I think that this is wrong, because it cane be triggered by user.
1. Create cm_id with any QP type you want - ucma_create_id()
2. Call to set option - ucma_set_option()
3. See WARN_ON.

Thanks

> ---
>  drivers/infiniband/core/cma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 0f5f0d7..006ea9c 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -2811,7 +2811,7 @@ int rdma_set_ack_timeout(struct rdma_cm_id *id, u8 timeout)
>  {
>  	struct rdma_id_private *id_priv;
>  
> -	if (id->qp_type != IB_QPT_RC)
> +	if (WARN_ON(id->qp_type != IB_QPT_RC && id->qp_type != IB_QPT_XRC_INI))
>  		return -EINVAL;
>  
>  	id_priv = container_of(id, struct rdma_id_private, id);
> -- 
> 1.8.3.1
> 
