Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59CB6D4497
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Apr 2023 14:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjDCMk3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Apr 2023 08:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjDCMk1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Apr 2023 08:40:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0518CA09;
        Mon,  3 Apr 2023 05:40:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35E85B819A1;
        Mon,  3 Apr 2023 12:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9076CC433D2;
        Mon,  3 Apr 2023 12:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680525623;
        bh=EgSj7Qv0PkBmFZ4Dodeo1bN+kcfgvMLV+dPFSYwL1xU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SkXD4a4QbJprcm02OXV6/eJsDmlSqPly49I0jCNYMBwB8k2vRfesWvEzLF7CtlHPn
         WCsbMrlEI7j0cQ2EVAt4QeBpQRBzEGsOhxmDl9hnrJ3mSYhp50DRXglfTosoHKNGbN
         MdBMIGhtxVcY6D65g204TYXqBfNVcxurjcxkjEjJXJasCVrWtvKw58WcTrHbVakfN2
         BjO+ma+58ISprW7+ucXKJaRz0ByWo/h1ax05Jn2wLlQlhNuq2p7tqaHjT4y1sRjb3j
         LWFFa/RyffWLANIG6h06KnLg5VINu8XktrQ0NCA2FPM+TtPsB9TfCX4ES/h8KVOROU
         irqAOzwE6XDmw==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, nathan@kernel.org, ndesaulniers@google.com,
        Tom Rix <trix@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
In-Reply-To: <20230330153607.1838750-1-trix@redhat.com>
References: <20230330153607.1838750-1-trix@redhat.com>
Subject: Re: [PATCH] RDMA/mlx5: remove unused num_alloc_xa_entries variable
Message-Id: <168052561997.175957.559845976488333081.b4-ty@kernel.org>
Date:   Mon, 03 Apr 2023 15:40:19 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Thu, 30 Mar 2023 11:36:07 -0400, Tom Rix wrote:
> clang with W=1 reports
> drivers/infiniband/hw/mlx5/devx.c:1996:6: error: variable
>   'num_alloc_xa_entries' set but not used [-Werror,-Wunused-but-set-variable]
>         int num_alloc_xa_entries = 0;
>             ^
> This variable is not used so remove it.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: remove unused num_alloc_xa_entries variable
      https://git.kernel.org/rdma/rdma/c/9eed9353a16755

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
