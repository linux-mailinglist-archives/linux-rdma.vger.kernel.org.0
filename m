Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F81791E1E
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Sep 2023 22:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjIDUHg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Sep 2023 16:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjIDUHf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Sep 2023 16:07:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34D4100;
        Mon,  4 Sep 2023 13:07:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90C14619D7;
        Mon,  4 Sep 2023 20:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2785BC433C9;
        Mon,  4 Sep 2023 20:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693858052;
        bh=otNGsPgRSJF+GJWAh44zBy59QOwduMh71EusH+v9EH8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Bb0fQ8Bp2MykA3GLRHCBMvGzsmj3KxpkioZtTjMLXduT5ih5d59gJQ77WvZq+a4Um
         2sRxGMhgUplOQ6qFiI6sNK8by8z1RQkufhyCWeFb7lXWIJwsbPh9kdcUTZqGXbP4fb
         gVa2hZa6mXzEymue7ZP2Y8diBuYSH43spq5nsqX04mrkHz8Rdzy2x3o60vuBe9Go98
         gp8wTrnrQgkF69gbqSlvBY4cL9Y7/csO1te4yx7f+kvmsFZY5EuVfWfgPbqnnc/8L1
         A/K+jTJNO8GqbqLAfl+Eyo4HKoOMciPSfSmpuBQSU6++lis9/+bbCSLQr8x+p7cW10
         1c5SeiXbNVEmw==
Message-ID: <fe404996-6568-e2ad-656d-e75523d96637@kernel.org>
Date:   Mon, 4 Sep 2023 22:07:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] infiniband: cxgb4: cm: Check skb value
Content-Language: en-US
To:     Artem Chernyshev <artem.chernyshev@red-soft.ru>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20230904115925.261974-1-artem.chernyshev@red-soft.ru>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230904115925.261974-1-artem.chernyshev@red-soft.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 04/09/2023 13:59, Artem Chernyshev wrote:
> get_skb() can't allocate skb in case of OOM.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
> ---
>  drivers/infiniband/hw/cxgb4/cm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
> index ced615b5ea09..775da62b38ec 100644
> --- a/drivers/infiniband/hw/cxgb4/cm.c
> +++ b/drivers/infiniband/hw/cxgb4/cm.c
> @@ -1965,6 +1965,10 @@ static int send_fw_act_open_req(struct c4iw_ep *ep, unsigned int atid)
>  	int win;
>  
>  	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
> +	if (!skb) {
> +		pr_err("%s - cannot alloc skb!\n", __func__);

I don't think we print memory allocation failures.

Best regards,
Krzysztof

