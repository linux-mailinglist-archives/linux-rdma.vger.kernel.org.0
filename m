Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F057D5527
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Oct 2023 17:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343537AbjJXPQn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Oct 2023 11:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbjJXPQg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Oct 2023 11:16:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9A910E2;
        Tue, 24 Oct 2023 08:16:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB1DC433CA;
        Tue, 24 Oct 2023 15:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698160593;
        bh=0NrY7joD0QN8CxuK5EACBmNxwYvhzcOzcKThmxRZNkU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nuZL7NOyiyiqkrkofBG2HosMFLnJYDVGVarFuZ7gZsj/cR104ZqZJ9p9X8fXzoKyI
         LFOX0Ia03tmGiJPftM/iaxhNQT3mlHltnMWjsT6O2I8k5OzvFgfofAPJQvmrfhDrVT
         ciRQur3lQPgzWZJqHDaBcom3dAJunSXIPVQy+iiQpFr9sVRIZ4nbnm4957oQJUzDT3
         VTg2pVLl4jQ1Y69zNL2iMU21m5jBrR3yW3sAN2t4GBjET8uoOJhzxFAP3W0q8TvOUz
         jfC2p4lFwR4/cgmE1twmFvxtmHi+uF/vYTGCGKLtC6pxULkPQPNjorEWhY8i311Z+i
         7fJeirFgVqvyw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231023141733.667807-1-colin.i.king@gmail.com>
References: <20231023141733.667807-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] RDMA/hfi1: remove redundant assignment to pointer ppd
Message-Id: <169816058968.2308077.4145972998710819648.b4-ty@kernel.org>
Date:   Tue, 24 Oct 2023 18:16:29 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Mon, 23 Oct 2023 15:17:33 +0100, Colin Ian King wrote:
> Pointer ppd is being assigned a value in a for-loop however it
> is never read. The assignment is redundant and can be removed.
> Cleans up clang scan build warning:
> 
> drivers/infiniband/hw/hfi1/init.c:1030:3: warning: Value stored
> to 'ppd' is never read [deadcode.DeadStores]
> 
> [...]

Applied, thanks!

[1/1] RDMA/hfi1: remove redundant assignment to pointer ppd
      https://git.kernel.org/rdma/rdma/c/b55706366c5ed6

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
