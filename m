Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F62876562D
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 16:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbjG0Oor (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 10:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjG0Ooq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 10:44:46 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254A3F2
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 07:44:45 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-63d09d886a6so7020966d6.2
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 07:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690469084; x=1691073884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZMOLwIPx11RNNFfz2Bi7WhwWnEDDYAvMvY/oojlgXw=;
        b=CT/PM8Z7gunKcPnZv425e/pwZxOOzj3a60bJ11qrUnfTcr5oDVed41WyTODE3r0uht
         V9gvXPscyIvL/IFiP9pVSr1kRkPeN//71efhLolEHydCx+756oLbQRCobHigQiViKqcL
         YlTWgVjVL9EoYOsF7+j4juJU807U4G8Ui9m6Bn3+6oCyPu9K/6V/O2gffrXdWx71+SDx
         c2aYleXpO8Inid/Y3tVbAuSKkr/hSkZll6Fh9HmfOYjrndGgPNFJ0CR0+GEpTP2GkjZd
         aT+k1c4b1y+95jDTJJzsiN0bc3K2Zy3gmLX522LlU8PkTXt8IgPN+prJVV0zNdcFteOn
         A/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690469084; x=1691073884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZMOLwIPx11RNNFfz2Bi7WhwWnEDDYAvMvY/oojlgXw=;
        b=lN4sm21291AH74LfyJrHagHRJXCstbw5YS9X/gP6NyhJDtrdwFBE8NUDV/yjCF3CsB
         tjgJZuDToc+O4Hud97zDtYZ/uYg54KYFKzFiaDOGlpWpgOUd4Xti7MFgwL9IapneBFwJ
         MDpg1dKmqupHp9cTltRuM71Pq4/pjFidkPRVFQI4GvxTOCCCyEOjQPiFiXtY6ai4dOyX
         3PCIVGXj8ae7etDc5FsOpLq+5IU1JpNNMObCohbwUuqE/ZsA0USzUUSH5JP9FvBpXU9H
         jjWg2e0ZiDLT+EaxOtTg+WLcHwTPvGvf3JxY4WM02NL8QZ8K0BVmiMy1chn5VbYqyPWJ
         XRTQ==
X-Gm-Message-State: ABy/qLakh9JzN9N92W/JXRtTDbtW2aAGH91b0Ce3F4/ZxykhXxSzL6A/
        al0pCO8yyQv5CYzr3nhEPvS8CA==
X-Google-Smtp-Source: APBJJlGJBP9XcceU4GuC2NHBXkbZxLuw0f7SYFCD7tPvIHgEBW931xb5bCZ8TOxOnB3ShxENhNr84Q==
X-Received: by 2002:a0c:efce:0:b0:63d:2902:6391 with SMTP id a14-20020a0cefce000000b0063d29026391mr141602qvt.27.1690469084178;
        Thu, 27 Jul 2023 07:44:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id i11-20020a0cf48b000000b0063cf9478fddsm463526qvm.128.2023.07.27.07.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 07:44:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qP2EM-001Lzl-Nl;
        Thu, 27 Jul 2023 11:44:42 -0300
Date:   Thu, 27 Jul 2023 11:44:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com,
        Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Subject: Re: [PATCH for-next 1/1] RDMA/bnxt_re: Add support for dmabuf pinned
 memory regions
Message-ID: <ZMKC2vmcCPs9umv2@ziepe.ca>
References: <1690468194-6185-1-git-send-email-selvin.xavier@broadcom.com>
 <1690468194-6185-2-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690468194-6185-2-git-send-email-selvin.xavier@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 27, 2023 at 07:29:54AM -0700, Selvin Xavier wrote:
> From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
> 
> Support the new verb which indicates dmabuf support.
> bnxt doesn't support ODP. So use the pinned version of the
> dmabuf APIs to enable bnxt_re devices to work as dmabuf importer.
> 
> Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 48 ++++++++++++++++++++++++++------
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h |  4 +++
>  drivers/infiniband/hw/bnxt_re/main.c     |  1 +
>  3 files changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index 2b2505a..3c3459d 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -3981,17 +3981,19 @@ int bnxt_re_dealloc_mw(struct ib_mw *ib_mw)
>  	return rc;
>  }
>  
> -/* uverbs */
> -struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
> -				  u64 virt_addr, int mr_access_flags,
> -				  struct ib_udata *udata)
> +static struct ib_mr *__bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start,
> +					   u64 length, u64 virt_addr, int fd,
> +					   int mr_access_flags,
> +					   struct ib_udata *udata,
> +					   bool dmabuf)
>  {
>  	struct bnxt_re_pd *pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
>  	struct bnxt_re_dev *rdev = pd->rdev;
> +	struct ib_umem_dmabuf *umem_dmabuf;
> +	unsigned long page_size;
>  	struct bnxt_re_mr *mr;
>  	struct ib_umem *umem;
> -	unsigned long page_size;
> -	int umem_pgs, rc;
> +	int umem_pgs, rc = 0;
>  	u32 active_mrs;
>  
>  	if (length > BNXT_RE_MAX_MR_SIZE) {
> @@ -4017,9 +4019,21 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
>  	/* The fixed portion of the rkey is the same as the lkey */
>  	mr->ib_mr.rkey = mr->qplib_mr.rkey;
>  
> -	umem = ib_umem_get(&rdev->ibdev, start, length, mr_access_flags);
> -	if (IS_ERR(umem)) {
> -		ibdev_err(&rdev->ibdev, "Failed to get umem");
> +	if (!dmabuf) {
> +		umem = ib_umem_get(&rdev->ibdev, start, length, mr_access_flags);
> +		if (IS_ERR(umem))
> +			rc = PTR_ERR(umem);
> +	} else {
> +		umem_dmabuf = ib_umem_dmabuf_get_pinned(&rdev->ibdev, start, length,
> +							fd, mr_access_flags);
> +		if (IS_ERR(umem_dmabuf))
> +			rc = PTR_ERR(umem_dmabuf);
> +		else
> +			umem = &umem_dmabuf->umem;
> +	}

This is pretty ugly, why can't you pass in the umem from the two stubs:

> +struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
> +				  u64 virt_addr, int mr_access_flags,
> +				  struct ib_udata *udata)
> +{
> +	return __bnxt_re_reg_user_mr(ib_pd, start, length, virt_addr, 0,
> +				     mr_access_flags, udata, false);
> +}
> +
> +struct ib_mr *bnxt_re_reg_user_mr_dmabuf(struct ib_pd *ib_pd, u64 start,
> +					 u64 length, u64 virt_addr, int fd,
> +					 int mr_access_flags, struct ib_udata *udata)
> +{
> +	return __bnxt_re_reg_user_mr(ib_pd, start, length, virt_addr, fd,
> +				     mr_access_flags, udata, true);
> +}

?

Jason

