Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304A768BD3B
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Feb 2023 13:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBFMsh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Feb 2023 07:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjBFMsg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Feb 2023 07:48:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D2E14EBF
        for <linux-rdma@vger.kernel.org>; Mon,  6 Feb 2023 04:48:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E88E360EC8
        for <linux-rdma@vger.kernel.org>; Mon,  6 Feb 2023 12:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E46C433EF;
        Mon,  6 Feb 2023 12:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675687710;
        bh=JVxlqlz08cUhM1e5KxEKB8DvFpBBrbStY5uz1fXjVvM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eL9eOzWKzPKF2A1faad09cpdvAXYiZwW/brKaD1Y5BmbWkjfTvAFD36r4hjkhVe71
         1l3qG+Ex5Bq2YQHb4Qti9xoFmLFSdbAyXYBH/9CK7YbF3uDl1WacxjCyGUjhOFB3Rz
         szP7WabkmhzpePUlEvaQNJUoDcIcF7E89TJsi6l/Cf1543Wsw1g31GVJG5EdDqGR9l
         FVOZ0D0I7NXPFgKxKs6NafEku4Mh+dYqbmydJLwyTKXre9zLIo833BZuJxA6au0y8U
         dFDewt9PSIABZzFKbH5PMH1wu9X0oHKhBR8aMRpuO7if0pXxHRtxoL8RnxdqnkzE8K
         f8f2hlYdW27rA==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org, Bernard Metzler <bmt@zurich.ibm.com>
Cc:     apopple@nvidia.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
In-Reply-To: <20230202101000.402990-1-bmt@zurich.ibm.com>
References: <20230202101000.402990-1-bmt@zurich.ibm.com>
Subject: Re: [PATCH] RDMA/siw: Fix user page pinning accounting
Message-Id: <167568770698.125328.17381455127017651737.b4-ty@kernel.org>
Date:   Mon, 06 Feb 2023 14:48:26 +0200
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


On Thu, 02 Feb 2023 11:10:00 +0100, Bernard Metzler wrote:
> To avoid racing with other user memory reservations, immediately
> account full amount of pages to be pinned.
> 
> 

Applied, thanks!

[1/1] RDMA/siw: Fix user page pinning accounting
      https://git.kernel.org/rdma/rdma/c/65a8fc30fb6722

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
