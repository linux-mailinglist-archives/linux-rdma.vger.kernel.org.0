Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C1A7AC493
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Sep 2023 20:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjIWSyb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 Sep 2023 14:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjIWSyb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 23 Sep 2023 14:54:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1D3113;
        Sat, 23 Sep 2023 11:54:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208A4C433C8;
        Sat, 23 Sep 2023 18:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695495264;
        bh=sICPMG7DrfOIsbSz6O+ydsinXn38Gvmn60xRu4Htgbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jh2AclgOIt9jUjQcls244C0E2UgqwBQHanDiARy2WXJUt1epZlozfZomdLiyUC1hw
         yAfXl73bLDf3Zu7zdZzd0pxWZFkjEb/c7Lrnm2OlDkJwgFuXKehZyBEXs+Jlh5DBjx
         Eh0hC/dDbm2p/a62AJsz3JKgihST/SkOOkWSVsrtZfR1R/h9/scotpdA06Kx3SrUbY
         r/TRlbpfAIEA9i5yp1dDrdxX7avl6Xo8WEkQo6pBImsavX8o4H0W7tdz4uQAqmP/I7
         AaDXCW0hUJbN1hQsB3rAYXm1EQCy+gdxNlznazZU3pkPX9EJMfSiqASjhEdiXChtxw
         atHI4eZEGYOkw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Roland Dreier <roland@purestorage.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] IB/mlx4: Fix the size of a buffer in add_port_entries()
Date:   Sat, 23 Sep 2023 21:54:16 +0300
Message-ID: <169549523606.309442.12357071231764109578.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <0bb1443eb47308bc9be30232cc23004c4d4cf43e.1695448530.git.christophe.jaillet@wanadoo.fr>
References: <0bb1443eb47308bc9be30232cc23004c4d4cf43e.1695448530.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Sat, 23 Sep 2023 07:55:56 +0200, Christophe JAILLET wrote:
> In order to be sure that 'buff' is never truncated, its size should be
> 12, not 11.
> 
> When building with W=1, this fixes the following warnings:
> 
>   drivers/infiniband/hw/mlx4/sysfs.c: In function ‘add_port_entries’:
>   drivers/infiniband/hw/mlx4/sysfs.c:268:34: error: ‘sprintf’ may write a terminating nul past the end of the destination [-Werror=format-overflow=]
>     268 |                 sprintf(buff, "%d", i);
>         |                                  ^
>   drivers/infiniband/hw/mlx4/sysfs.c:268:17: note: ‘sprintf’ output between 2 and 12 bytes into a destination of size 11
>     268 |                 sprintf(buff, "%d", i);
>         |                 ^~~~~~~~~~~~~~~~~~~~~~
>   drivers/infiniband/hw/mlx4/sysfs.c:286:34: error: ‘sprintf’ may write a terminating nul past the end of the destination [-Werror=format-overflow=]
>     286 |                 sprintf(buff, "%d", i);
>         |                                  ^
>   drivers/infiniband/hw/mlx4/sysfs.c:286:17: note: ‘sprintf’ output between 2 and 12 bytes into a destination of size 11
>     286 |                 sprintf(buff, "%d", i);
>         |                 ^~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] IB/mlx4: Fix the size of a buffer in add_port_entries()
      https://git.kernel.org/rdma/rdma/c/d7f393430a17c2

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
