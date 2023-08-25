Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46A3788DF5
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Aug 2023 19:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238144AbjHYRpv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Aug 2023 13:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbjHYRpk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Aug 2023 13:45:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCFE2128;
        Fri, 25 Aug 2023 10:45:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F012E62D97;
        Fri, 25 Aug 2023 17:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C77C433C8;
        Fri, 25 Aug 2023 17:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692985537;
        bh=FvFWJfTHnCJBuxAYcJU2vDvioeoRGpbuDc+4qUjlpqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NN+b5k9geYk3K1cJNOm+eHUaw9RzRYKdAr4Uhf7S2hAmpYRTMJhHbj/2am0yxYpJ9
         bv9j/ZLTkpogSFptzQnG2KHXQaDWzKdECGk4Z3uYsfobS/dEuA9riZB+3nVor+fY1D
         uisXjvytC7giuKf6N1PFGEfB6HemZ7wAy6HBvvDPRPCV6YjaGbo1ZJQepZhaqixTtg
         I/FA7A5Sw8ui7n4MWwxa7MvKfPG9q5XF3f4BokNLhGO4P/zp0Ck1/05xcrnuYE81PF
         ZIko3rkLvjUnBWW2Eff9jzWLfh3GICQJUEZq3TuMkvT+8SNHK8rO/kwhZqPQkCXqf1
         64m7NywDjaW5A==
Date:   Fri, 25 Aug 2023 10:45:35 -0700
From:   Saeed Mahameed <saeed@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Gal Pressman <gal@nvidia.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: fix config name in Kconfig parameter
 documentation
Message-ID: <ZOjov4PvI19Jdgs+@x130>
References: <20230825125100.26453-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230825125100.26453-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 25 Aug 14:51, Lukas Bulwahn wrote:
>Commit a12ba19269d7 ("net/mlx5: Update Kconfig parameter documentation")
>adds documentation on Kconfig options for the mlx5 driver. It refers to the
>config MLX5_EN_MACSEC for MACSec offloading, but the config is actually
>called MLX5_MACSEC.
>
>Fix the reference to the right config name in the documentation.
>
>Fixes: a12ba19269d7 ("net/mlx5: Update Kconfig parameter documentation")
>Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>---
>Saeed, please pick this quick fix to the documentation.

Thanks applied to net-next-mlx5.


