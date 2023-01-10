Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F4A663AAC
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jan 2023 09:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjAJIO4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Jan 2023 03:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237715AbjAJIOw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Jan 2023 03:14:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170BD38BB
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jan 2023 00:14:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A00E36150E
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jan 2023 08:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EABBC43392;
        Tue, 10 Jan 2023 08:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673338490;
        bh=1EG51j5TO2s1nCLFcyur64QIYxPTv5FOFvGJeg9G9GU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MsapEvPBqmStfxNvBOrf9tW4Xjra1UTCOh6EoGCj9fBfBR6p5cQzwFufl/dVO2fp0
         /VGQsXzOe2tipkNug68H2x0NySliME8BW1hJ0z8mkrXi9/I3BhbJuF3bprc5N8XSi3
         Esn6op/fD0hzxM9IUgtNUaMsjvV1kcbuPuGDAPrtye3A2vt0CxSwCkRM21w44MpkGW
         TARZVqC5ZlVEv45eUD9pMttVaYR9mTG1sTxHuCbcHE4FqRbfdHr9+8vmzAUjst+0Wo
         WDqQwLTsgTGsJGx21D0JLx8NrvMSqBg0nRiM08DxQ3AwV2p8YaKoHBavRkag+O/qIC
         4hsbQzG/faV7A==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>,
        Wei Chen <harperchen1110@gmail.com>
In-Reply-To: <3d0e9a2fd62bc10ba02fed1c7c48a48638952320.1672819273.git.leonro@nvidia.com>
References: <3d0e9a2fd62bc10ba02fed1c7c48a48638952320.1672819273.git.leonro@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/core: Refactor rdma_bind_addr
Message-Id: <167333848620.1096262.13878953796349442593.b4-ty@kernel.org>
Date:   Tue, 10 Jan 2023 10:14:46 +0200
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


On Wed, 04 Jan 2023 10:01:38 +0200, Leon Romanovsky wrote:
> Refactor rdma_bind_addr function so that it doesn't require that the
> cma destination address be changed before calling it.
> 
> So now it will update the destination address internally only when it is
> really needed and after passing all the required checks.
> 
> Which in turn results in a cleaner and more sensible call and error
> handling flows for the functions that call it directly or indirectly.
> 
> [...]

Applied, thanks!

[1/1] RDMA/core: Refactor rdma_bind_addr
      https://git.kernel.org/rdma/rdma/c/8d037973d48c02

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
