Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECAC7B8B0F
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Oct 2023 20:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244580AbjJDSpg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Oct 2023 14:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244585AbjJDSpf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Oct 2023 14:45:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE18AB;
        Wed,  4 Oct 2023 11:45:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC99AC433C7;
        Wed,  4 Oct 2023 18:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445131;
        bh=2imu9D3Z8TAnL2w/VZP/VIqsJlXJpUNbul4OIe8I16A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MCz6fPWJcorTD75aqEQSmwSmhDZufZ0eg12ZpmbultXKSI7554NgQ4mCitq3MiJA2
         CampcKPjQwgI900hdL2SDQwM0P5xsuvug/Qc56rDAmOKqXNU7Ll5K6zaV7W+sJDqxX
         6bFWjtn64KzEwOhwE7pEdVuRe72/bXFmSptgLPfIjUgBcMtCtFaq8ZL/JzVBNZRb2H
         BipAKufOsbSh2wKzuOIMyP+HB5iXo7oyWoQtUplFXcEmn/MIc9OvyvzXrqKqgZ+yRb
         ZrdmjM2/5QuvWv7zFGJbNtVV65iCdamrCgx/Yly9Wg5qwCt3OKKLZxhhsS9v+7NM4n
         uKp3HYdhmcYkA==
Date:   Wed, 4 Oct 2023 21:45:27 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] net/mlx5: Annotate struct mlx5_flow_handle with
 __counted_by
Message-ID: <20231004184527.GG51282@unreal>
References: <20231003231730.work.166-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003231730.work.166-kees@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 03, 2023 at 04:17:30PM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mlx5_flow_handle.
> 
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-rdma@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/fs_core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
