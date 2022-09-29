Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC7C5EF2EF
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Sep 2022 12:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbiI2KC0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Sep 2022 06:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbiI2KCZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Sep 2022 06:02:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A8913A07F
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 03:02:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 468C7B8237E
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 10:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710A4C433D6;
        Thu, 29 Sep 2022 10:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664445742;
        bh=7EhD1Kch5g16dRgsZdb+kYA++qX6gSqG61t5ZAvDOtw=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=GX1M80L9jSa11kvR7jVAFU0fRkVoWGdS3yr6o8EXA1rZZtH/LCTN6h3ZIqtdQKjnI
         lHA4JJwcitmb/z+9T8bvhQ/DpTfxbAhaRVpw6DPFQwfoATkuQPdgrSBKfZhkwwKhRh
         BczL75jmCuEWWapcjobc6Plxqtgk2tQzQesOk9QUqmpENpPRItZFFj10xUHows4Vxa
         RbV00kw1g/Kr1pRqKmoWY9TzzBN67thJPOvWuYrsanc33ip+0q47U1l0Z9Nza40LRl
         Qyt9ZBknMgS/dFUWeG+EeawtSQjlP9//ytvznFADcRRz6FOFbtTs3ubBMkyMqYhpNv
         VtLVk0tEgV5Tw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
In-Reply-To: <20220929080023.304242-1-matsuda-daisuke@fujitsu.com>
References: <20220929080023.304242-1-matsuda-daisuke@fujitsu.com>
Subject: Re: [PATCH] RDMA/rxe: Remove error/warning messages from packet receiver path
Message-Id: <166444573771.614024.15980210460911680879.b4-ty@kernel.org>
Date:   Thu, 29 Sep 2022 13:02:17 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 29 Sep 2022 17:00:23 +0900, Daisuke Matsuda wrote:
> Incoming packets to rxe are passed from UDP layer using an encapsulation
> socket. If there are any clients reachable to a node, they can invoke the
> encapsulation handler arbitrarily by sending malicious or irrelevant
> packets. This can potentially cause a message overflow and a subsequent
> slowdown on the node.
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/rxe: Remove error/warning messages from packet receiver path
      https://git.kernel.org/rdma/rdma/c/8ad891ed435ba2

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
