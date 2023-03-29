Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3B96CD873
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 13:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjC2L2e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 07:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjC2L2d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 07:28:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1C9448A
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 04:28:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A73AF61CC4
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 11:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C51DC433D2;
        Wed, 29 Mar 2023 11:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680089311;
        bh=GnU9zHHaI5t0utp9qlD6bkA+9tbcpfP4Mbo/NMD2Udc=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=NphtOxC7srpiQkrdEpTBvRevBpRHEel0mpUShrJ8zgdyAKw96oR+wy04i9sUx5fOL
         tRWDuIUyUTNwjUWxK7bNscDbduHRs3Vm9RxIMCtI/PDkaaCFSteMItrPp5jpWsHcfb
         FIMalXuF2pH0watjn2xHPN5afApu5xnYYhBWQNMwNwm42l/uqg4qagIjlKaIfUAGg6
         WDraEYcG/CL4wzlagfZ3+kzc557bJFNDBISqY1aldj8852eEkeeExsGR+ltvcbl6PP
         jd8onHcy2azuJMr5Isv6xiuCKOAUUG+oFedH7BDnDkbHYThSjjcgaUj1fxSuYUaF9T
         7hY/Dr/tiKhzw==
From:   Leon Romanovsky <leon@kernel.org>
To:     zyjzyj2000@gmail.com, BMT@zurich.ibm.com,
        linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230327215643.10410-1-rpearsonhpe@gmail.com>
References: <20230327215643.10410-1-rpearsonhpe@gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Remove tasklet call from rxe_cq.c
Message-Id: <168008930726.1169130.15820862793202103828.b4-ty@kernel.org>
Date:   Wed, 29 Mar 2023 14:28:27 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Mon, 27 Mar 2023 16:56:44 -0500, Bob Pearson wrote:
> Remove the tasklet call in rxe_cq.c and also the is_dying in the
> cq struct. There is no reason for the rxe driver to defer the call
> to the cq completion handler by scheduling a tasklet. rxe_cq_post()
> is not called in a hard irq context.
> 
> The rxe driver currently is incorrect because the tasklet call is
> made without protecting the cq pointer with a reference from having
> the underlying memory freed before the deferred routine is called.
> Executing the comp_handler inline fixes this problem.
> 
> [...]

Applied, thanks!

[1/1] RDMA/rxe: Remove tasklet call from rxe_cq.c
      https://git.kernel.org/rdma/rdma/c/78b26a335310a0

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
