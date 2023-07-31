Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0BC76908C
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 10:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjGaIoV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 04:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjGaInx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 04:43:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D12B2133
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 01:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E336360EFB
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 08:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9263C433C8;
        Mon, 31 Jul 2023 08:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690792859;
        bh=35FnYxxroxrAaxeUXWJ5nFKw1S1ug44qxQ4ynFMHu4U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uaiOQ6rguAQIEuhoNhbjvSNUNiTXrzyGzmFBcv6APy3FnV2stvMnuPoUMFZsfSS81
         cFnq578eC4jVXfk9PdPUFYzQuOkru0ibhdr21qYVl8zZ3oG/ZvWThHt9Y0P2/lSNnY
         cDcztCjzjiZ+5Adhx/qz703P1TBA11JzJKMl9SuE1GtCzxH2ZW9m+bvWPdKFNKuSPM
         njO8hOOChXWwDp8qCSC+HMGHqCR3z6w9IIGVOBiv6os55ZGDP2IpQlciTbB6cjXNdp
         WxI1/SZNwyxJ3Y3eeROLKN8zOFyleKuBcNWoVA4JcDGZaJaWBmjO+ObMsU7rVPyNG5
         2vrgkcrypMnhw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     Shetu Ayalew <shetu@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <01cd24cd7f591734741309921fdc01fc770d84a8.1690121941.git.leon@kernel.org>
References: <01cd24cd7f591734741309921fdc01fc770d84a8.1690121941.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next v1] IB/mlx5: Add HW counter called rx_dct_connect
Message-Id: <169079285548.134805.16248099034190268174.b4-ty@kernel.org>
Date:   Mon, 31 Jul 2023 11:40:55 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Sun, 23 Jul 2023 17:21:14 +0300, Leon Romanovsky wrote:
> The rx_dct_connect counter shows the number of received connection
> requests for the associated DCTs.
> 
> 

Applied, thanks!

[1/1] IB/mlx5: Add HW counter called rx_dct_connect
      https://git.kernel.org/rdma/rdma/c/f0ff2a2dd08df5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
