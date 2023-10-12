Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D39D7C773A
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Oct 2023 21:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442653AbjJLTsu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 15:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442540AbjJLTsj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 15:48:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1C7199B;
        Thu, 12 Oct 2023 12:48:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F438C433C7;
        Thu, 12 Oct 2023 19:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697140094;
        bh=xKxtPIbjmhojr5P8UlRXEZjXsWNlqy3DYQ9BpEu6EeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sdgp7WDKUJOHj9qRddUYHur95feMlemPaULF34kusLfglTtXdjntyDVO8IyTUOmdo
         Vl3aXOa+VQwgnzNoBj3oJ65LFLXkm8mAdIWk3sjN+akB31QZLwfS73HpYQl0BwfgD2
         y09BWLWJLvn2GsJs5xDcOXyMyHe/KMibo/Rl/T8G0f5x6VpSLtjIdeV7tRygf19IzV
         w987XPBsnHeeM2UvkY/bdWzatG92r7UB76loWOmeCQ7aUaBBnKOA/TA5/i9BGvDMcY
         A9MA0ctXdNnR4zTjXQ6hg/k/zrYjBrwSNOYFSl7knpFgra3oCCWYASf/gWsjIWU+xX
         et4lo44WRYUqA==
Date:   Thu, 12 Oct 2023 12:48:13 -0700
From:   Saeed Mahameed <saeed@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
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
Subject: Re: [PATCH] net/mlx5: Annotate struct mlx5_fc_bulk with __counted_by
Message-ID: <ZShNfcI7dnZwyLhM@x130>
References: <20231003231718.work.679-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231003231718.work.679-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 03 Oct 16:17, Kees Cook wrote:
>Prepare for the coming implementation by GCC and Clang of the __counted_by
>attribute. Flexible array members annotated with __counted_by can have
>their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
>array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
>functions).
>
>As found with Coccinelle[1], add __counted_by for struct mlx5_fc_bulk.
>
>Cc: Saeed Mahameed <saeedm@nvidia.com>
>Cc: Leon Romanovsky <leon@kernel.org>
>Cc: "David S. Miller" <davem@davemloft.net>
>Cc: Eric Dumazet <edumazet@google.com>
>Cc: Jakub Kicinski <kuba@kernel.org>
>Cc: Paolo Abeni <pabeni@redhat.com>
>Cc: netdev@vger.kernel.org
>Cc: linux-rdma@vger.kernel.org
>Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
>Signed-off-by: Kees Cook <keescook@chromium.org>

Applied to net-next-mlx5.

