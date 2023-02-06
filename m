Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBFE68BF15
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Feb 2023 15:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjBFOAX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Feb 2023 09:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjBFN7f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Feb 2023 08:59:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BE644B0;
        Mon,  6 Feb 2023 05:58:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D8BFB81180;
        Mon,  6 Feb 2023 13:58:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0D8C4339B;
        Mon,  6 Feb 2023 13:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675691937;
        bh=2us+JKXuAHskZPeOXRaG4c//LxLkYK3uje4zohFmfsM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=r+xTYGwBiHqX/JL/DipHrOkLEJxBoo0PXofiR30vy5UXXijR4Cn1v0sHUFr0/6aFC
         GUKIoBMBO11BqUMo6Yt/eM4mKGD3ZEyOXXGi9YLgNda+ZuU9bO9Y1/QIJt9+//kNWN
         wff32g+RM7/o9xOhqdWGjJYgXzNVAt9HcwpQ5eDmRtSwD3V2FDbVzh7B5dHDjrS+mV
         NntCpuTKGPHtUHIQu3UYYgJ9sDGti85dTddBt/uQz2KwsndJKbywBkPCutlYxFHnDP
         HIswGTqjFa9D+ljuDxK3hEjkIfgD/tpHiGVJmENpLvoZy5mNyVFhXnBcVCFHQ03Ysr
         rnbjJFHRm2Cyg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
In-Reply-To: <20230202184850.29882-1-n.zhandarovich@fintech.ru>
References: <20230202184850.29882-1-n.zhandarovich@fintech.ru>
Subject: Re: [PATCH v2] RDMA/cxgb4: Fix potential null-ptr-deref in pass_establish()
Message-Id: <167569193407.220508.5248380038372866365.b4-ty@kernel.org>
Date:   Mon, 06 Feb 2023 15:58:54 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Thu, 02 Feb 2023 10:48:50 -0800, Nikita Zhandarovich wrote:
> If get_ep_from_tid() fails to lookup non-NULL value for ep, ep is
> dereferenced later regardless of whether it is empty.
> This patch adds a simple sanity check to fix the issue.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/cxgb4: Fix potential null-ptr-deref in pass_establish()
      https://git.kernel.org/rdma/rdma/c/283861a4c52c1e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
