Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99D7768535
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Jul 2023 14:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjG3MHA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Jul 2023 08:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjG3MHA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 30 Jul 2023 08:07:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BFC198C;
        Sun, 30 Jul 2023 05:06:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E08B60BB8;
        Sun, 30 Jul 2023 12:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93FEC433C7;
        Sun, 30 Jul 2023 12:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690718818;
        bh=Ra80a0aIKgvFmi8fzh0InRNVF5NIjmriiDM4GB77148=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XRM1UN5ebIxwK9KklCEaRFpaRj701rZnPO31EK2m8/ERHJs4c+Kg9CBpofNiEx6/F
         2QYuSDr2fi3DWvjdHLFH0CU/rh7ddKOrMtev3tQdqzmpUizdY8dSxg8NjTIvpxBBE0
         xi7rVbJWkAbFyOQZUI8hSqQvD8rt6gaWEQFjksJVzzlJ1qbqG5fh9vErzXxJZth8XD
         km6VJC6IsUT6PcRdtIi4tj3iI6kdVP8jig6Q19f89h8ceH8MHZ9w2jyxHcudqII6q6
         H4Uy3sk0oFzBL9FQVxL+r9F+bOxAJ7HvqXI/FXyImjsTtqmI7fW29FsnK8k49l5jE6
         R9XeUsik2vdyw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230721092052.2090449-1-huangjunxian6@hisilicon.com>
References: <20230721092052.2090449-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH v4 for-next] RDMA/core: Get IB width and speed from netdev
Message-Id: <169071881408.197073.10243396231178591967.b4-ty@kernel.org>
Date:   Sun, 30 Jul 2023 15:06:54 +0300
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


On Fri, 21 Jul 2023 17:20:52 +0800, Junxian Huang wrote:
> Previously, there was no way to query the number of lanes for a network
> card, so the same netdev_speed would result in a fixed pair of width and
> speed. As network card specifications become more diverse, such fixed
> mode is no longer suitable, so a method is needed to obtain the correct
> width and speed based on the number of lanes.
> 
> This patch retrieves netdev lanes and speed from net_device and
> translates them to IB width and speed.
> 
> [...]

Applied, thanks!

[1/1] RDMA/core: Get IB width and speed from netdev
      https://git.kernel.org/rdma/rdma/c/cb06b6b3f6cbc5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
