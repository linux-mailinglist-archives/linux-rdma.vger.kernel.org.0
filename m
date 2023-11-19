Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FAA7F0653
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Nov 2023 14:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjKSNJ2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Nov 2023 08:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjKSNJ2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Nov 2023 08:09:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B40EC2;
        Sun, 19 Nov 2023 05:09:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541D2C433C7;
        Sun, 19 Nov 2023 13:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700399364;
        bh=pW+rpulscaPnRF430jTWtW6AhnHttnT221uqzNoPpBk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QDztnwPU+6wBYzxH7TQ7FoYEtM2Ghk1h0I4JLDObD2J4+0/6+cDYOAczNJrDQqqVm
         NXrP9qysi0y4GLo6//VfTgQOYHcCLN6JuViZS22C43TP1mX53g9fvK6OYfVfd7L4ok
         V5VUSUw+ofHRFKDC/L2imuxoX9o7EBm+OwKANVvHJ45EF+1keX9TK4jYNQklGJQ8VO
         4s60kmKrhDwzsNz4+MUW9DXD5PYtOhw3Bi4LbuIzxoUCIWNBI00rznqV2bE0Pcezuv
         Lu52aLBFnrXgtarF/TXllL7kcxVpGyRLUWlffVP1q1ewYPFjg7iMvbQgck6Bj2pnqk
         Vv3gCETsLiUUg==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, tangchengchang@huawei.com
In-Reply-To: <20231117080657.1844316-1-huangjunxian6@hisilicon.com>
References: <20231117080657.1844316-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-rc] MAINTAINERS: Add Chengchang Tang as Hisilicon RoCE
 maintainer
Message-Id: <170039936060.102302.2532715775350577698.b4-ty@kernel.org>
Date:   Sun, 19 Nov 2023 15:09:20 +0200
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


On Fri, 17 Nov 2023 16:06:57 +0800, Junxian Huang wrote:
> Add Chengchang Tang as Hisilicon RoCE maintainer.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Add Chengchang Tang as Hisilicon RoCE maintainer
      https://git.kernel.org/rdma/rdma/c/b6f09b16558f31

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
