Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB9E7473A4
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jul 2023 16:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjGDOHi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jul 2023 10:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjGDOH1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jul 2023 10:07:27 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38331E72
        for <linux-rdma@vger.kernel.org>; Tue,  4 Jul 2023 07:07:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-307d58b3efbso6216197f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 04 Jul 2023 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688479643; x=1691071643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bfa1/VBRiNKgEl3qdEAtKMNGvx01sB2q9WDNlFHKK1c=;
        b=z6pMi7YbOvNgeA/MwIw5jnbFTmwFIWpWEUtMAnW3hhn5RC9cAEVI8tFZvBthd3jBqH
         KpYVP414qrfxgVNG39QP2t/6ek5mgjpBTzalv5mtetoMSBFBKHJ17K+uHzNizK7Sx/O9
         MlvjnwesNjVdPsoyhlLKSGq4xPbXKZWu/9Mt2wdxERA5Vs6sL+nWZ1l+B/+AeIoF5+qG
         uHGQCtCiiwiN7K3i8sfM37HS1py/bOp1J0ilUjDz9lEbJaBF+lmeG3nc2nph4x8AqG8h
         ovH//OmEO6BKvjHsDk+3RloazUV89m0xKwMQbOBXsN17Yix6dZA6TmV0xDi+wlfCtv6U
         Fj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688479643; x=1691071643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bfa1/VBRiNKgEl3qdEAtKMNGvx01sB2q9WDNlFHKK1c=;
        b=f03rjZ8hIeUq2fpv4hf/+ZzXnspTrAUaYsCknVY3PiTeFAbwVP0y4f7rznsQkXObpX
         dqR9TtZ+3dAlcNjAYIgpu/JPnSC+shuWScloW5o/cLEXn0gEw1Qhpp6A5Q8jGMVVnCHd
         tdlaVgm3aSyx1bJopOlT5thzCPE+OvKSEha21e7hUwdlgoasIsviiwipynUa1XCBbRO3
         KEl2OEuGlfrQGOBjA6f0Iudo2w5YKWwWGjAQm1AEgNDJ3fTJHdZaKnSMQUXOaWxGQCS/
         KD5XVUsPzU6rNOKLLqoaX6oWVwbjo2loehHhQzjPxsHqd36hzpbx37zCfo6aLQ4r9z03
         y06Q==
X-Gm-Message-State: ABy/qLaXb1n21t8H6RYc8Hye35+Wmlr/ozHu+TgUBMPIRrrLYNOs7iW6
        JHi7EHYx7UohyvMZ2UlzDpqMug==
X-Google-Smtp-Source: APBJJlGireM4qFr+8mexUwYlWxsi1ThA6EdbPSWsPwCGvU5BGxn1v/W0kKfqBUxCNr6faMKKSUqI2A==
X-Received: by 2002:a5d:4444:0:b0:314:2d89:70f1 with SMTP id x4-20020a5d4444000000b003142d8970f1mr7274880wrr.16.1688479643649;
        Tue, 04 Jul 2023 07:07:23 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j4-20020adfea44000000b0030fa3567541sm28597400wrn.48.2023.07.04.07.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 07:07:21 -0700 (PDT)
Date:   Tue, 4 Jul 2023 17:07:17 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Guy Levi <guyle@mellanox.com>, Yishai Hadas <yishaih@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx4: Make check for invalid flags stricter
Message-ID: <359dc6de-2b08-4baa-99cc-d5e5f6e6ce43@kadam.mountain>
References: <233ed975-982d-422a-b498-410f71d8a101@moroto.mountain>
 <20230704133841.GD6455@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704133841.GD6455@unreal>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 04, 2023 at 04:38:41PM +0300, Leon Romanovsky wrote:
> On Thu, Jun 29, 2023 at 09:07:37AM +0300, Dan Carpenter wrote:
> > This code is trying to ensure that only the flags specified in the list
> > are allowed.  The problem is that ucmd->rx_hash_fields_mask is a u64 and
> > the flags are an enum which is treated as a u32 in this context.  That
> > means the test doesn't check whether the highest 32 bits are zero.
> > 
> > Fixes: 4d02ebd9bbbd ("IB/mlx4: Fix RSS hash fields restrictions")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > The MLX4_IB_RX_HASH_INNER value is declared as
> > "MLX4_IB_RX_HASH_INNER           = 1ULL << 31," which suggests that it
> > should be type ULL but that doesn't work.  It will still be basically a
> > u32.  (Enum types are weird).
> 
> Can you please elaborate more why enum left to be int? It is surprise to me.

Enum types are not defined very strictly in C so it's up to the
compiler.

Clang, GCC and Sparse implement them in the same way.  They default
to u32 unless the values can't fit, then they become whatever type fits.
So if you have a negative, it becomes an int or a big value changes the
type to unsigned long.

Since 1ULL < 31 fits in u32 the type is just u32.

regards,
dan carpenter

#include <stdio.h>

enum example_one {
	VAL = 1ULL << 31,
};

enum example_two {
	NEGATIVE = -2,
};

enum example_three {
	BIG = 1ULL << 32,
};

int main(void)
{
	enum example_one one = -1;
	enum example_two two = -1;
	enum example_three three = -1;

	printf("%lu\n", sizeof(enum example_one));

	if (one > 0)
		printf("one unsigned\n");
	if (two < 0)
		printf("two signed\n");

	printf("%lu\n", sizeof(enum example_three));
	if (three > 0)
		printf("three unsigned\n");

	return 0;
}


