Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCFA63BCCF
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Nov 2022 10:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiK2JWB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Nov 2022 04:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiK2JWB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Nov 2022 04:22:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F66E5A6DB;
        Tue, 29 Nov 2022 01:22:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D364F615C4;
        Tue, 29 Nov 2022 09:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8114C433C1;
        Tue, 29 Nov 2022 09:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669713719;
        bh=uAaxGnR8WfzXs4T9/P4OaVh7Mbna/JASeMh1Wm5QeDI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qoRNbFI2ktj7yBH5CXHkkk/At/B5J4pmOextVJP+YdiEsYK9GkcEpo7cn3kUUx7rY
         pgset/wl6li0zGPiAWKogQf7icTEkM3R9bg0+XlBZ+BOkoIkkSJZbFs8Aop1pcZZ4R
         rbkrqRn08Z7fNwIM+c+yS2mmtMKV1Nk/QrBld0XiBftMgyPpQf+LM2xJo6S8MTSUkr
         tPmo8Ua9jESw9trgaXittaAqYHXsTZCiw16D3FKupEyEwRggcbRFsvTYo8vMLuhRap
         0HmG17n3/B9fWoqICwo4L7kZS48IVZsrBXKJJgxRFE42gizfHOzoaRykgKyI4fAU0+
         dAVp5geZqobUw==
From:   Leon Romanovsky <leon@kernel.org>
To:     zhang.songyi@zte.com.cn
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        zhangsongyi.cgel@gmail.com, yishaih@nvidia.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <202211291554079687539@zte.com.cn>
References: <202211291554079687539@zte.com.cn>
Subject: Re: [PATCH rdma-next] RDMA/mlx4: remove NULL check before dev_{put, hold}
Message-Id: <166971371504.18968.8462013076488687681.b4-ty@kernel.org>
Date:   Tue, 29 Nov 2022 11:21:55 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 29 Nov 2022 15:54:07 +0800 (CST), zhang.songyi@zte.com.cn wrote:
> From: zhang songyi <zhang.songyi@zte.com.cn>
> 
> The call netdev_{put, hold} of dev_{put, hold} will check NULL,
> so there is no need to check before using dev_{put, hold}.
> 
> Fix the following coccicheck warnings:
> /drivers/infiniband/hw/mlx4/main.c:1311:2-10: WARNING:
> WARNING  NULL check before dev_{put, hold} functions is not needed.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx4: remove NULL check before dev_{put, hold}
      https://git.kernel.org/rdma/rdma/c/7ff54cf9f514c2

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
