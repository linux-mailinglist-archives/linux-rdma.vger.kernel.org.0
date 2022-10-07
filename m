Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9E65F7DD9
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Oct 2022 21:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJGTU5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Oct 2022 15:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiJGTUf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Oct 2022 15:20:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DD713DD9;
        Fri,  7 Oct 2022 12:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9D2961CED;
        Fri,  7 Oct 2022 19:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B6D2C433D6;
        Fri,  7 Oct 2022 19:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665170416;
        bh=8w/Ae4p5L7TLLoueP0HLXecEPBBCeYZtncXZTpY2JEs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HdVIihy4RhY7+9e696Uu0YRJ0ldMxgt1HIyOiT6qGdsXv8PdZ5HUKQ66XaaFkelj9
         OrubkC0YMFZQpcjySKLiMIAWudQ7wUgpegFcC02Z4UopTrA+i0M+wJ8RXQHqua1Q+O
         ELv8qoqKs5VHjUrO+vb8v/1qz1m2wpAakkUEpp9Ou1OMMJAFfCZZN4GA8BPHNuN6io
         h5/9cOURftq/IKbStbWMcxTsm9iZIVKuFFXcmKRkOhyi1JEEoOuE7FPsvQCQe/ydcv
         Jei2GXLdq80YvXEDPdSBKCo26SXXqRxJESeEIJYMr7WdQ/F1tOXJy2GR8pN6tjYK2E
         E+zpJTOg7z7Ow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B6BBE2A05C;
        Fri,  7 Oct 2022 19:20:16 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yz9eqEUfSParOUJk@nvidia.com>
References: <Yz9eqEUfSParOUJk@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yz9eqEUfSParOUJk@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 33331a728c83f380e53a3dbf2be0c1893da1d739
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e08466a7c00733a501d3c5328d29ec974478d717
Message-Id: <166517041656.8063.1948377182345057451.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 19:20:16 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pull request you sent on Thu, 6 Oct 2022 20:03:04 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e08466a7c00733a501d3c5328d29ec974478d717

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
