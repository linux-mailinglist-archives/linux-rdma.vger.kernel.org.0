Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93DB75EE80
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jul 2023 10:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjGXI4f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jul 2023 04:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjGXI43 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jul 2023 04:56:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E8B10D;
        Mon, 24 Jul 2023 01:56:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77F7960FF5;
        Mon, 24 Jul 2023 08:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C280C433C8;
        Mon, 24 Jul 2023 08:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690188975;
        bh=GwLL2dPjVrHICs4WvTid2ZDcfK5CYiUEUPt9eZFTZl0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bd4gwFb/snmvmEkYoyYbVrLaparwOTSqRPolWy/hAb3BWrM2amv4ZLbNtb7RiIbVl
         0TaLPMsUpLhYwDk+/C9juY/Q8sHuz+RGmlweZSEDoO05L+dmgVztqvTxbjRu67/8c8
         6dLU6e3dveVgSDAv4yB514HJqTHUqFQ1CuZdxthu2Z0SEA6eIwBocHz+vo9Uj1GcQX
         9Xjzdn2YFrKM4O4X/6S+CnR6TBtCGX7cHtxSfvEXRm8soY1k1yRKj0oLqcIeghFosl
         sBHPdTqQ9GcLyA0C0gKcA2F/MiHM9Yu2lPHN1lv5Pl21e/DU5X4XZD3ZkG3ok1uYKd
         FTXZpyYIYBYew==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230721025146.450831-1-huangjunxian6@hisilicon.com>
References: <20230721025146.450831-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH v3 for-rc 0/2] RDMA/hns: Improvements for function
 resource configuration
Message-Id: <169018897253.260945.10196182263272868712.b4-ty@kernel.org>
Date:   Mon, 24 Jul 2023 11:56:12 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Fri, 21 Jul 2023 10:51:44 +0800, Junxian Huang wrote:
> Here are 3 patches involving function resource configuration.
> 
> 1. #1: The first patch supports getting xrcd num from firmware.
> 
> 2. #2: The second patch removes a redundant configuration in driver,
>        which is now handled by firmware.
> 
> [...]

Applied, thanks!

[1/2] RDMA/hns: support get xrcd num from firmware
      https://git.kernel.org/rdma/rdma/c/8b1a5fc24e74e8
[2/2] RDMA/hns: Remove VF extend configuration
      https://git.kernel.org/rdma/rdma/c/d6cfa810d8a58c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
