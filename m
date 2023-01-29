Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8928867FF41
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Jan 2023 13:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjA2M6B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 Jan 2023 07:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjA2M6A (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 29 Jan 2023 07:58:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EAFB47F;
        Sun, 29 Jan 2023 04:57:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68395B80C67;
        Sun, 29 Jan 2023 12:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E746C433EF;
        Sun, 29 Jan 2023 12:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674997075;
        bh=u5+qwDrySPt+u9m3s5qHVJL4QWn/7pIX9rjNuYnZXPg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HOEYLHHXevsZAV406XZiy0pIlGK4wUHclquxLWim2Tcd+j4+nfDvrON6MGzv4ie2I
         y/hsw5F/V70sHPXAi0NaVKvmXOpR7yHw7YWiOoZZv5f+f5RGcPI8orf7dgN/8nSr8H
         Pdz2Ccf492HhOJXwKABHiA8Q+IiIThc9PAvGpP2Lw+DCJ8dS7TIBVo+vKMeQtkpOZr
         JlBR5JkjbBZjFISDXz5vPUeM0r/F5mGgpCl+Z9T/992ea3RwynWoAQ3zLH+lkR6qmW
         Raynymn9KyutymetcfqxM9zxiE//Hl3iVFYYnWsGvIrbq9XLCqs3KhaOcHCd7Oaaxo
         /29SZSeKpr3Wg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
In-Reply-To: <20230126185230.62464-1-n.zhandarovich@fintech.ru>
References: <20230126185230.62464-1-n.zhandarovich@fintech.ru>
Subject: Re: [PATCH] RDMA/irdma: Fix potential NULL-ptr-dereference
Message-Id: <167499707102.224018.1130031073935778804.b4-ty@kernel.org>
Date:   Sun, 29 Jan 2023 14:57:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Thu, 26 Jan 2023 10:52:30 -0800, Nikita Zhandarovich wrote:
> in_dev_get() can return NULL which will cause a failure once idev is
> dereferenced in in_dev_for_each_ifa_rtnl(). This patch adds a
> check for NULL value in idev beforehand.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 146b9756f14c ("RDMA/irdma: Add connection manager")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> 
> [...]

Applied, thanks!

[1/1] RDMA/irdma: Fix potential NULL-ptr-dereference
      https://git.kernel.org/rdma/rdma/c/5d9745cead1f12

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
