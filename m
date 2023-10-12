Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005FD7C773E
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Oct 2023 21:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442639AbjJLTtN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 15:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442643AbjJLTtG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 15:49:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A522CF5;
        Thu, 12 Oct 2023 12:48:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDAFC433C7;
        Thu, 12 Oct 2023 19:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697140135;
        bh=JX7ZU2XiXw++bn1D18ecdFGhzCKpId5/KU2GQQr0DK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DQ2sVY7rwTATyZWtaVainC2Bi+Ou4hsHYEsc7mupLgOr+D2qk2qc3Xyn+hIKdeRSH
         uuNWJ0zxxbPNCe8LcIseklrUXJxmQ9XxrbKU48N8IStxCCNKohuqcHpCz3el+wQ3Kc
         W7w51TyVK4XYmvm7fymS4fpCVsiAkI2ajl4cp8higGFiC/E5tYpTn6HXWLbmgFFajA
         wvNY7Er4QIiDVFT+qUJFtt6ljilipKRUK8fN32NnqJZAz6QAkp83gJ0cVPsaF0T1B8
         PMQfo/vL6tCfoQnOuGRsYc6eZn/br6naXFoQbH0a2huyGYC4OzNqMAXUaP9+pVi+b1
         EiWc1593XwgaQ==
Date:   Thu, 12 Oct 2023 12:48:54 -0700
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
Subject: Re: [PATCH] net/mlx5: Annotate struct mlx5_flow_handle with
 __counted_by
Message-ID: <ZShNpk6mPNDYiFSj@x130>
References: <20231003231730.work.166-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231003231730.work.166-kees@kernel.org>
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
>As found with Coccinelle[1], add __counted_by for struct mlx5_flow_handle.
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

applied to net-next-mlx5.


