Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC4E603AC2
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Oct 2022 09:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJSHjR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Oct 2022 03:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiJSHjR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Oct 2022 03:39:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D57179632
        for <linux-rdma@vger.kernel.org>; Wed, 19 Oct 2022 00:39:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBB77617AB
        for <linux-rdma@vger.kernel.org>; Wed, 19 Oct 2022 07:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0380C433D7;
        Wed, 19 Oct 2022 07:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666165155;
        bh=Amu5RsyiHoVd29cnzpyWXGYGSc9xBFkdvJeOawQiMJ8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UuZvm6dQsPCgryKbrgkOBoRLLBs62QdNcCsClEWIXCi4L/rpfzPidQhtxsYAB3J/K
         Z+GJ9s0md0VnKFioQaUXOSnn57ff9ydf02NcFcJJQX6Q/Sx1rVsnlbUWnWScacT3eT
         v9pNfi/tVg9QYFWB29W26icJ6fJE4MDcFL3YUbU/lCGYqmgjKML1TeuYBqW8rwvBpT
         7zU8Nf3KEcgpYxhKhlEL+6HvD8jxvzQWducTpQwM7G79faSq8F3jdDnFzcL/y1z56U
         3uKbkTRhue3xiVRA0dvz6GCYEjniXlEsNOKMzxDNzkHNxajHbGqxnbXaHVqGY/kbsm
         b8a1tbAeQeTpg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, sagi@grimberg.me,
        linux-rdma@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>, sergeygo@nvidia.com
In-Reply-To: <20221016093833.12537-1-mgurtovoy@nvidia.com>
References: <20221016093833.12537-1-mgurtovoy@nvidia.com>
Subject: Re: [PATCH 0/3] iSER patches for linux-6.2
Message-Id: <166616515112.243426.785190844127418726.b4-ty@kernel.org>
Date:   Wed, 19 Oct 2022 10:39:11 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, 16 Oct 2022 12:38:30 +0300, Max Gurtovoy wrote:
> These small patches add safety checks and simplify the code.
> Please consider including them in the next merge window.
> 
> Max Gurtovoy (2):
>   IB/iser: add safety checks for state_mutex lock
>   IB/iser: open code iser_disconnected_handler
> 
> [...]

Applied, thanks!

[1/3] IB/iser: open code iser_conn_state_comp_exch
      https://git.kernel.org/rdma/rdma/c/acc7d94ab431fb
[2/3] IB/iser: add safety checks for state_mutex lock
      https://git.kernel.org/rdma/rdma/c/a75243ae08d232
[3/3] IB/iser: open code iser_disconnected_handler
      https://git.kernel.org/rdma/rdma/c/c1842f34fceef4

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
