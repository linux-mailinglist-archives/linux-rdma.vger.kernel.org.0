Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4826CF26B
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 20:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjC2SoS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 14:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjC2SoR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 14:44:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467EC5FCB
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 11:44:16 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r11so16734364wrr.12
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 11:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680115454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wzLiOvTFePp4SmkKVJ5FbHc01Qo7u4rWRNeReLelqTI=;
        b=pTxqfza4OBIKfjURDbo87vmb7BsC+SOK0TkgTTGdPD2FYryzvu+Ja3pU4yGfpStWzV
         JWC2wn9mLps4qYyZV8BthUA38WELw54mhTuy1aLV9CahwFC8rXXoLMGqeLavJh/iX4ST
         gpu4mfJ7L3CgS01PqEVBqykiNJMhJMftZpAljimdSI12Imj6VEwHUh/LrNgGDMaqBRJh
         kts8jWP5K102sQxx34lzHXY/m93+LaJh5Cdc6tsABl+FI8AO7VW/H+foAouvq/DwFf4C
         Z8Q47mpkgpfkx40wKBvj1e1TCc54LGzvCRL1aQM69eAIth50ucxYG5LG1xT23fRRwPED
         2dZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzLiOvTFePp4SmkKVJ5FbHc01Qo7u4rWRNeReLelqTI=;
        b=6rLmVjORrK4ZpsbTk0mKSQYUWIyNfe7w30sYzI923ctaRFJ8vcdiQpl73WLOB5Kst0
         zYACAdPs3z/AAOteQxE9z09Y5O6JBQg2ujDoyqlS5fqQGxI1sGV/+NoEL+C0TevyClLM
         YCf2EnwvqerySSMi0p2Dtae7iLDWfp/WeotwbtXhQIY6Rd8nlrZJ4PdaDSI1Wm/N6/r0
         U3u8TEskA2dYFJwD5qPt+m1QZ7UmZm++wRDGR+i6jz2sAii+jpoU0lzlWEOLJUbAuYpH
         cFbWRlQFvBMR76LeXZ55vFGoLZEcim/rlF0t9lvbV0Eux5LPZycbVWR+9yy+IhyKX/z6
         ylFQ==
X-Gm-Message-State: AAQBX9dfC8/HMfirQVxfQm7eHsarP2U/NCoqDQHRaV4YX5h/TvEy+e1s
        ITXod5OpAcu47RPxa2yfuaM=
X-Google-Smtp-Source: AKy350bhKw2wVhJlvN3FrA4Du1EBWvDZ95tnjtUvDM8iC1KY1nL7Zl8jWVdS/QjE0H5WwYvTDscJ0A==
X-Received: by 2002:adf:e848:0:b0:2c7:fde:f7e0 with SMTP id d8-20020adfe848000000b002c70fdef7e0mr14876519wrn.65.1680115454529;
        Wed, 29 Mar 2023 11:44:14 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a7-20020a5d5087000000b002c55306f6edsm30780596wrt.54.2023.03.29.11.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:44:14 -0700 (PDT)
Date:   Wed, 29 Mar 2023 21:44:09 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        linux-rdma@vger.kernel.org, Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next] RDMA/rxe: Clean kzalloc failure paths
Message-ID: <88b57490-4260-42f6-88e0-ff8a3d30ce51@kili.mountain>
References: <d3cedf723b84e73e8062a67b7489d33802bafba2.1680113597.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3cedf723b84e73e8062a67b7489d33802bafba2.1680113597.git.leon@kernel.org>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 29, 2023 at 09:14:01PM +0300, Leon Romanovsky wrote:
> @@ -1287,11 +1279,8 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
>  	}
>  
>  	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
> -	if (!mr) {
> -		err = -ENOMEM;
> -		rxe_dbg_mr(mr, "no memory for mr");
> -		goto err_out;
> -	}
> +	if (!mr)
> +		return ERR_PTR(-ENOMEM);
>  
>  	err = rxe_add_to_pool(&rxe->mr_pool, mr);
>  	if (err) {
        ^^^^^^^^^^
If the rxe_add_to_pool() fails then it calls:

	rxe_dbg_mr(mr, "unable to create mr, err = %d", err);
                   ^^

"rm" is zeroed mem and not useful at this point.  Possibly in a later
patch though.

regards,
dan carpenter

