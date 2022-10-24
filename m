Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325F4609FEB
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 13:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJXLND (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 07:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiJXLNB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 07:13:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA0C3C15F
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 04:12:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B1B861224
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 11:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC06C433D6;
        Mon, 24 Oct 2022 11:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666609948;
        bh=tVQROf0jb3hAfoIS3F5jZ+aBzKkZlpWRGFbGzG22w1g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Sarv+c4QugsjDVJ7zEcygpkq/rI1x0AmXBhYK47L8lg4r9hkpHuqnhyMBw92gbL+i
         TjC6oQtMco1cG5ormYZJCoFV3mDEtaj2aRk5AByOpD73Iz35SWuD2iAA0NFn7B4+kU
         Vh4ikOO8PrY6v7pYtC2kaFz4yghaYTPZkxH91GSIMfATqSFyOIZwjSieb1b+6JXqje
         Hi8enBBrMFhD+kEFQMvQHPmyXYZCil1M1scttmLEzv5b6sRENxAk4yKpUhHF/qgXTF
         sxZzHq/QfKyWmeLA8mxwhuVfw7+yTS0lckHpqREAC8geOId/N80rnoam3Fml7d44f9
         0nxM3/Z4NDmEA==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org, Michael Margolin <mrgolin@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Yossi Leybovich <sleybo@amazon.com>,
        Firas Jahjah <firasj@amazon.com>
In-Reply-To: <20221020151949.1768-1-mrgolin@amazon.com>
References: <20221020151949.1768-1-mrgolin@amazon.com>
Subject: Re: [PATCH for-rc] RDMA/efa: Add EFA 0xefa2 PCI ID
Message-Id: <166660994376.677843.9519117225649755940.b4-ty@kernel.org>
Date:   Mon, 24 Oct 2022 14:12:23 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 20 Oct 2022 18:19:49 +0300, Michael Margolin wrote:
> Add support for 0xefa2 devices.
> 
> 

Applied, thanks!

[1/1] RDMA/efa: Add EFA 0xefa2 PCI ID
      https://git.kernel.org/rdma/rdma/c/c1e42790338020

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
