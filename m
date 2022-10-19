Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09057603A4C
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Oct 2022 09:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJSHG2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Oct 2022 03:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJSHG1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Oct 2022 03:06:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9A274E00
        for <linux-rdma@vger.kernel.org>; Wed, 19 Oct 2022 00:06:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D157AB81F4E
        for <linux-rdma@vger.kernel.org>; Wed, 19 Oct 2022 07:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFDCC433C1;
        Wed, 19 Oct 2022 07:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666163184;
        bh=3kGJZY4AqRvplyI1Kb4/AfAYBrZCo5HMP3FR2xEuIpk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nOWGHxHKBR8+iZ1j4v7fNko8GfaCzfNsH8STQKZhfeTBQsPM2trl1586hj17QuIJs
         dsAlVjuZPlyHzzizDwbBky7VASUe7FWiaxH5Ve3KFNF9wFDVq2t2wJVVBGkFsJyEds
         Ky8xhTmdcoaevqLGyywQzQThyoQZUUewiS/tmKdsqpQyfZ/Grs0fPw5f14dZ6knhaJ
         Ie8bLtevze9oFc4TF0JcNn5wGKLw4FdltgeTPDcH7YpDAVZOvtgakGOW8kJbzGzfHL
         DFmlM9S4dsrCzYPvHT40dt8F1gt9RigS7sSfeN6IkcdfOD0CDf52Q4LyRzwiPOpP0v
         uC3VnJrDLE6tg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
In-Reply-To: <166610327042.674422.6146908799669288976.stgit@awfm-02.cornelisnetworks.com>
References: <166610327042.674422.6146908799669288976.stgit@awfm-02.cornelisnetworks.com>
Subject: Re: [PATCH for-rc] IB/hfi1: Correctly move list in sc_disable()
Message-Id: <166616318061.239749.14013244447764614676.b4-ty@kernel.org>
Date:   Wed, 19 Oct 2022 10:06:20 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 18 Oct 2022 10:27:50 -0400, Dennis Dalessandro wrote:
> From: Dean Luick <dean.luick@cornelisnetworks.com>
> 
> Commit 13bac861952a ("IB/hfi1: Fix abba locking issue with
> sc_disable()") incorrectly tries to move a list from one list
> head to another.  The result is a kernel crash.
> 
> The crash is triggered when a link goes down and there are
> waiters for a send to complete.  The following signature is
> seen:
> 
> [...]

Applied, thanks!

[1/1] IB/hfi1: Correctly move list in sc_disable()
      https://git.kernel.org/rdma/rdma/c/ffad65329ba89c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
