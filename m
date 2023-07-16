Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F9C754E77
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jul 2023 13:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjGPLlz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Jul 2023 07:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGPLly (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 16 Jul 2023 07:41:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC23B9;
        Sun, 16 Jul 2023 04:41:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6329F60C90;
        Sun, 16 Jul 2023 11:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F639C433C7;
        Sun, 16 Jul 2023 11:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689507712;
        bh=hVDmewweJfDc5tEE7Fyg0pSV8XDSV8JX9s6RfaSTEKQ=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=DQHb7/rRYpBb3Df+ckQ499GbkNK9EMF9pAwqD/oPc/Q0Qcz8tgZdmFJc+2WS8gSfL
         ZJK7A7EENO7owMmzqkyTjbUo4e6CFnaaNiHuAoEAvV/L8QkOgXdVNSmiKRb7L9f5Le
         hxmgk20skihBTaRKGIvC06s7C4Rjj9waNEubEgb3LQDNUnDMXdYESPT2z1sukxsPFq
         medkQbtBH7zrmMADD5i5V+mpVWIJ3GPRTj0w7uuEqTXTPe7iw628cykHG4XakWpagt
         djA/TlUfBXZIAK8gOG16yUsNzAK/XmcYWhsvpXRvVEv2oyLjYg9ZcohSRLZcjvGCzN
         uvN5w6jmI3Gyw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>
In-Reply-To: <20230713141658.9426-1-tbogendoerfer@suse.de>
References: <20230713141658.9426-1-tbogendoerfer@suse.de>
Subject: Re: [PATCH] RDMA/mthca: Fix crash when polling CQ for shared QPs
Message-Id: <168950770903.219939.14813629640192938544.b4-ty@kernel.org>
Date:   Sun, 16 Jul 2023 14:41:49 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Thu, 13 Jul 2023 16:16:58 +0200, Thomas Bogendoerfer wrote:
> Commit 21c2fe94abb2 ("RDMA/mthca: Combine special QP struct with mthca QP")
> introduced a new struct mthca_sqp which doesn't contain struct mthca_qp
> any longer. Placing a pointer of this new struct into qptable leads
> to crashes, because mthca_poll_one() expects a qp pointer. Fix this
> by putting the correct pointer into qptable.
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/mthca: Fix crash when polling CQ for shared QPs
      https://git.kernel.org/rdma/rdma/c/5ceccabbdcf805

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
