Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8C560F6C1
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 14:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiJ0MHN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 08:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbiJ0MHN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 08:07:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B19B8786
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 05:07:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 715C4B825E4
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 12:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC61C433D6;
        Thu, 27 Oct 2022 12:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666872430;
        bh=mu5I3ay/+WSdUliD66ExE4z+D3mwjiA2QfMWNthiQ+U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=N4/vcYu8CYvKQ6zZQFl/iFfRuHjv+9i9zaimRnZTMoTDC+TKikBi7rwhrIC4WjJTk
         SCGGrUJYzEbsZCUOmk81VwbBgAJHpB+nWu37AMGrF5BgeRgeNL/2zmEyPNwC70sYAE
         I0iR2xUkkS55kjfZxwtIvGjrkTytWEfQR1w1GcPNe+06c4KQS4Ga5+7drS25BCceaw
         qq9//HX6ncAx9TAHc5LRX38XTjVibo6nHBZTnjTf1maGBWX1RsB+gI+zlXD/YySW+N
         ktBBeq9FoaJjUZ7mVk5s9rH+rUm6qK+iWv8ot+9EvhjpCq8hrggP8ZvuwgsRijF3dq
         DddadGSGtHCzA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Steve Wise <larrystevenwise@gmail.com>,
        Leon Romanovsky <leon@kernel.org>
In-Reply-To: <64e676774a53a406f4cde265d5a4cfd6b8e97df9.1666683334.git.leonro@nvidia.com>
References: <64e676774a53a406f4cde265d5a4cfd6b8e97df9.1666683334.git.leonro@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/core: Fix order of nldev_exit call
Message-Id: <166687242589.396632.5699857114187856368.b4-ty@kernel.org>
Date:   Thu, 27 Oct 2022 15:07:05 +0300
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

On Tue, 25 Oct 2022 10:37:13 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Create symmetrical exit flow by calling to nldev_exit() after
> call to rdma_nl_unregister(RDMA_NL_LS).
> 
> 

Applied, thanks!

[1/1] RDMA/core: Fix order of nldev_exit call
      https://git.kernel.org/rdma/rdma/c/bbdad4967431bd

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
