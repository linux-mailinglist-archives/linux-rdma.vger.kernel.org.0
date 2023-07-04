Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366F074779E
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jul 2023 19:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjGDRTQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jul 2023 13:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjGDRTQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jul 2023 13:19:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0762510CA;
        Tue,  4 Jul 2023 10:19:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 996696132A;
        Tue,  4 Jul 2023 17:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D770C433C8;
        Tue,  4 Jul 2023 17:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688491154;
        bh=n/1SKK4xF03Yp2pUYhLstwmUNmos1rf2SDsw/6rtFCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HA9azoRSkkUvt+UmiQiMSjGkaxLNSigeqU6fnbYOgXCsmcCsHmKocuZnx678mFTzv
         qZPNtEZe431SOIGQj+V1uVsBruwCkya1uSg4+phGuhpI8+eZoMpfiZ9jfKPB11u1Qi
         +Tjaukf1+7IJsJZbhkB0vvpDqipccP30uh7X3dM1VcvjMOZP0R2nLJbYdrRkZfsun8
         Pp4+JYyf4v14vl5zqK6Is8duap+xazjN4BqtRwmMRutsw0SmVgnl15V++RtOQ4bpDh
         GvLIUlFlCszChveNd5NCySjJAd/6HcvIQswqGFfcMb/yn9aoDNUZknA76fO7EtBqaT
         Xtz6nXhWEr8sQ==
Date:   Tue, 4 Jul 2023 20:19:09 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Guy Levi <guyle@mellanox.com>, Yishai Hadas <yishaih@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx4: Make check for invalid flags stricter
Message-ID: <20230704171909.GE6455@unreal>
References: <233ed975-982d-422a-b498-410f71d8a101@moroto.mountain>
 <20230704133841.GD6455@unreal>
 <359dc6de-2b08-4baa-99cc-d5e5f6e6ce43@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <359dc6de-2b08-4baa-99cc-d5e5f6e6ce43@kadam.mountain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 04, 2023 at 05:07:17PM +0300, Dan Carpenter wrote:
> On Tue, Jul 04, 2023 at 04:38:41PM +0300, Leon Romanovsky wrote:
> > On Thu, Jun 29, 2023 at 09:07:37AM +0300, Dan Carpenter wrote:
> > > This code is trying to ensure that only the flags specified in the list
> > > are allowed.  The problem is that ucmd->rx_hash_fields_mask is a u64 and
> > > the flags are an enum which is treated as a u32 in this context.  That
> > > means the test doesn't check whether the highest 32 bits are zero.
> > > 
> > > Fixes: 4d02ebd9bbbd ("IB/mlx4: Fix RSS hash fields restrictions")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > ---
> > > The MLX4_IB_RX_HASH_INNER value is declared as
> > > "MLX4_IB_RX_HASH_INNER           = 1ULL << 31," which suggests that it
> > > should be type ULL but that doesn't work.  It will still be basically a
> > > u32.  (Enum types are weird).
> > 
> > Can you please elaborate more why enum left to be int? It is surprise to me.
> 
> Enum types are not defined very strictly in C so it's up to the
> compiler.
> 
> Clang, GCC and Sparse implement them in the same way.  They default
> to u32 unless the values can't fit, then they become whatever type fits.
> So if you have a negative, it becomes an int or a big value changes the
> type to unsigned long.
> 
> Since 1ULL < 31 fits in u32 the type is just u32.

Thanks for an explanation, I found the relevant sentence in the C
standard as well.

"The choice of type is implementation-deﬁned, 128) but shall be
capable of representing the values of all the members of the enumeration."

Thanks

> 
> regards,
> dan carpenter
> 
> #include <stdio.h>
> 
> enum example_one {
> 	VAL = 1ULL << 31,
> };
> 
> enum example_two {
> 	NEGATIVE = -2,
> };
> 
> enum example_three {
> 	BIG = 1ULL << 32,
> };
> 
> int main(void)
> {
> 	enum example_one one = -1;
> 	enum example_two two = -1;
> 	enum example_three three = -1;
> 
> 	printf("%lu\n", sizeof(enum example_one));
> 
> 	if (one > 0)
> 		printf("one unsigned\n");
> 	if (two < 0)
> 		printf("two signed\n");
> 
> 	printf("%lu\n", sizeof(enum example_three));
> 	if (three > 0)
> 		printf("three unsigned\n");
> 
> 	return 0;
> }
> 
> 
