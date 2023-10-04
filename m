Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593857B8B03
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Oct 2023 20:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243785AbjJDSpB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Oct 2023 14:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244257AbjJDSpA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Oct 2023 14:45:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743D9C0;
        Wed,  4 Oct 2023 11:44:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7350DC433C7;
        Wed,  4 Oct 2023 18:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445096;
        bh=kMdSleGdDSkNeDkcR8NOit5Qc/BamxxI/xtLxfY4N7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gvBSh8+d3KS95DWmkQU5S8YVC+ZI3O+PTcEZCLG5tn4cSI9ZlVpg/QlKMjI9qr1af
         W/UIXvUhfw+qogfjtZypafxFlHUHilDm0Jk9S6tOmvbdgEG2EtDZy8qCoi9EssSORJ
         lLrVyegmxtJ4obzy8MGR356nWOdRGcW6RPquak3X4gpUNMJPKv8PbWtAn7az9kaiXU
         UZKnNiQTI/M3AHuyEwqiFIt8+NTFJuf/+oYTlIsbdkxq/lX4ddY/HTZT9PZgk7sRX3
         PX5Zn8tGWJ5JUQXTvUOuJPQuMmDdxZQrjivfV1eFnCqWUh8HiCeOiYu7cDPZpff5vI
         b4bzATHFmvxYw==
Date:   Wed, 4 Oct 2023 21:44:52 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
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
Message-ID: <20231004184452.GF51282@unreal>
References: <20231003231718.work.679-kees@kernel.org>
 <CAFhGd8p_o5xtmrV+Vm0JUR5VQmMenqtm3xbJuE0TSj-_4Bthfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8p_o5xtmrV+Vm0JUR5VQmMenqtm3xbJuE0TSj-_4Bthfw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 03, 2023 at 04:21:05PM -0700, Justin Stitt wrote:
> On Tue, Oct 3, 2023 at 4:17 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Prepare for the coming implementation by GCC and Clang of the __counted_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> > array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > functions).
> >
> > As found with Coccinelle[1], add __counted_by for struct mlx5_fc_bulk.
> >
> > Cc: Saeed Mahameed <saeedm@nvidia.com>
> > Cc: Leon Romanovsky <leon@kernel.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: netdev@vger.kernel.org
> > Cc: linux-rdma@vger.kernel.org
> > Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
