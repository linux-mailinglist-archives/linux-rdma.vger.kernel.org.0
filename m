Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76616CFC05
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 08:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjC3G4N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 02:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjC3G4M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 02:56:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA051123
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 23:56:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6038DB825F8
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 06:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B97C433D2;
        Thu, 30 Mar 2023 06:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680159369;
        bh=A9+Wt0PO2DxK/3+pFM9KLD2s3eqvekTH8kMQMq3sO9c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KjcA+yU89RC/wrZiUbp8yRca8Z0Z4p5DQgc6QtLZD4mMsq+LiJlXIEuEH15EXCl/w
         7soThCH6f7uNlyxNVl3DbcUCnkjnhCiIpBHdo+xiDVnwrxbAxkUB17QyeSNW77mcdO
         jHb5Z8twNffOLHIokJXWOnHRQZGFW2sCl4n+FULatKdtWO0CNnrFdOLNyi98OF+TiG
         FfHZXFVDhK+BIBUiqE0TIgxzFZYpEyrXYIlp9vEK6eilhog/rA5mkold26dKJYmQum
         6hkO4k6lAkq4bSdfx3umMDrUoS9OcY9edWaM4+fCHWhtgjN8gpEjVcvyYvBGUiaDQ9
         WxHWOEDt34ViQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Dan Carpenter <error27@gmail.com>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Leon Romanovsky <leon@kernel.org>
In-Reply-To: <d3cedf723b84e73e8062a67b7489d33802bafba2.1680113597.git.leon@kernel.org>
References: <d3cedf723b84e73e8062a67b7489d33802bafba2.1680113597.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/rxe: Clean kzalloc failure paths
Message-Id: <168015936476.1613453.5399257500964138590.b4-ty@kernel.org>
Date:   Thu, 30 Mar 2023 09:56:04 +0300
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


On Wed, 29 Mar 2023 21:14:01 +0300, Leon Romanovsky wrote:
> There is no need to print any debug messages after failure to
> allocate memory, because kernel will print OOM dumps anyway.
> 
> Together with removal of these messages, remove useless goto jumps.
> 
> 

Applied, thanks!

[1/1] RDMA/rxe: Clean kzalloc failure paths
      https://git.kernel.org/rdma/rdma/c/b6ba68555d75fd

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
