Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61B76E3773
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Apr 2023 12:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjDPK37 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Apr 2023 06:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjDPK36 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 16 Apr 2023 06:29:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A64B8
        for <linux-rdma@vger.kernel.org>; Sun, 16 Apr 2023 03:29:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60D7A60E9A
        for <linux-rdma@vger.kernel.org>; Sun, 16 Apr 2023 10:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F82C433D2;
        Sun, 16 Apr 2023 10:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681640996;
        bh=NdmRjDH9zEwD5ez4UdF3U0HPoTMc/w8FRZEzPXnc1G4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OsLdxqxccV/Kbo4QDNKduQ5Ame2hUtTe7ODmfu/PecT3LxHyDNZZBUKpXFk5c74vS
         uqgQiHw339ZFJLNy2xcdP5m+NzGSyrCyGCecdYYPGyzB1CSvM1LkZZH599tIGT8AZI
         dedCysdN2uJG+Y2r1rr06Z4BjZTPXyfHvtNi3t10gH1M0AbLlYRK70S+tEEmntL6rl
         kA7OMDugLCnHCo/wX+BF8ySd9nmrge34d+/QLdNZS1ntLWzJ3ODJmuZYXh99BFIHds
         P0WeuCPmXdakgaZnn8UUqnj2jA7qN9oDtfS5KRy1Dvq0Ijg3bDTZpRJoEJzYIEtuj0
         5faAsUHA8vsbA==
From:   Leon Romanovsky <leon@kernel.org>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
In-Reply-To: <20230413101115.1366068-1-yanjun.zhu@intel.com>
References: <20230413101115.1366068-1-yanjun.zhu@intel.com>
Subject: Re: [PATCH rdma-next v4 1/1] RDMA/rxe: Fix the error "trying to
 register non-static key in rxe_cleanup_task"
Message-Id: <168164099257.148301.1485801490533264476.b4-ty@kernel.org>
Date:   Sun, 16 Apr 2023 13:29:52 +0300
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


On Thu, 13 Apr 2023 18:11:15 +0800, Zhu Yanjun wrote:
> In the function rxe_create_qp(), rxe_qp_from_init() is called to
> initialize qp, internally things like rxe_init_task are not setup until
> rxe_qp_init_req().
> 
> If an error occures before this point then the unwind will call
> rxe_cleanup() and eventually to rxe_qp_do_cleanup()/rxe_cleanup_task()
> which will oops when trying to access the uninitialized spinlock.
> 
> [...]

Applied, thanks!

[1/1] RDMA/rxe: Fix the error "trying to register non-static key in rxe_cleanup_task"
      https://git.kernel.org/rdma/rdma/c/b2b1ddc457458f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
