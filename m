Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE0B7EC436
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Nov 2023 14:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjKON6w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Nov 2023 08:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbjKON6v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Nov 2023 08:58:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4093121
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 05:58:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD24C433C8;
        Wed, 15 Nov 2023 13:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700056728;
        bh=XHhy/hjWJQet31Wb7dCnM2rOabqT219OFnEH/LGyEdo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DNEhWLy/mkGPKizKDS5xm9noBsyId9C9rP8RvHEwqSJK8rjl7J7TzCkxDioFbSXjk
         gY/uoYny9AW58hfTqeO3rvJ58Srvx33ceb9XM0ALyQQDoEA0atsAjBsRCHE7TVe/43
         jNWke8DfNhMocb1Y7i/wBcxvvVvfKAOs0sf/JLUHffqJB0RbpNbkXgyNKv5kvqB7fS
         vy38tippOZR4cOR8pUQh3M7EMr6xaJ0LVHzoOGCR+ZjJzHBcjF/sdaSD2VhZD7RCJC
         1hGoNJraeFzEe+JEEIe9kM5dJulz5Ka5cSDKd6TmaLRLnahtglpgcUeO9WJ2qCZYS9
         DE7wchZogbHRw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
In-Reply-To: <c559cb7113158c02d75401ac162652072ef1b5f0.1699867650.git.leon@kernel.org>
References: <c559cb7113158c02d75401ac162652072ef1b5f0.1699867650.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/usnic: Silence uninitialized symbol smatch
 warnings
Message-Id: <170005672418.829880.16718202350610031487.b4-ty@kernel.org>
Date:   Wed, 15 Nov 2023 15:58:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Mon, 13 Nov 2023 11:28:02 +0200, Leon Romanovsky wrote:
> The patch 1da177e4c3f4: "Linux-2.6.12-rc2" from Apr 16, 2005
> (linux-next), leads to the following Smatch static checker warning:
> 
>         drivers/infiniband/hw/mthca/mthca_cmd.c:644 mthca_SYS_EN()
>         error: uninitialized symbol 'out'.
> 
> drivers/infiniband/hw/mthca/mthca_cmd.c
>     636 int mthca_SYS_EN(struct mthca_dev *dev)
>     637 {
>     638         u64 out;
>     639         int ret;
>     640
>     641         ret = mthca_cmd_imm(dev, 0, &out, 0, 0, CMD_SYS_EN, CMD_TIME_CLASS_D);
> 
> [...]

Applied, thanks!

[1/1] RDMA/usnic: Silence uninitialized symbol smatch warnings
      https://git.kernel.org/rdma/rdma/c/b9a85e5eec126d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
