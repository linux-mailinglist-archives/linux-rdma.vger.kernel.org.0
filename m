Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59EC7E97E2
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Nov 2023 09:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjKMIie (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Nov 2023 03:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjKMIie (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Nov 2023 03:38:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D11B10EC
        for <linux-rdma@vger.kernel.org>; Mon, 13 Nov 2023 00:38:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFB7C433C8;
        Mon, 13 Nov 2023 08:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699864711;
        bh=w9quc07TCiwDxsVoEmd0NCPxGtMAL6YdD6aNxKidRLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SdGYBGgGvEQhVZUzYd8Rpa6UbETkI0GJgmVolchwUOuMIUrqFKoPUXVaJn7CTh4zZ
         BqPOQekOvrJvlQ1el7hUgcr5+jxh2HKTbkhXl8z6t5UNKKx7bCmi0Qbu2S5alvBGAe
         1dd79YSlK+n3W8LkqZnHG5S926fquBNTn788pqXW6gI3MKJHQqPucPuo94jiV5sclj
         40n1HiEhly1XbnmDgiWWGI3EPcxLfY+HMt/WaNodZBkLy4OFtryMaCkWJHkgfha1Py
         KMnKLT0ZfUb+OZXW64ehZ6aJ2SbKmVGhJKVG5nzqKpZRp3+HRFzgy/AB/rPgnOswAb
         rIgI8FTY02pDQ==
Date:   Mon, 13 Nov 2023 10:38:26 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     bmt@zurich.ibm.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH V4 00/18] Cleanup for siw
Message-ID: <20231113083826.GA51912@unreal>
References: <20231027132644.29347-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027132644.29347-1-guoqing.jiang@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 27, 2023 at 09:26:26PM +0800, Guoqing Jiang wrote:
> V4 changes:
> 1. add Acked-by tags.
> 2. update patch 3 and patch 12 per Bernard's review.
> 3. update patch header in patch 18.
> 
> V3 changes:
> 1. add Acked-by tags.
> 2. drop 2 patches and address other comments.
> 
> Appreciate for Bernard's review!
> 
> V2 changes:
> 1. address W=1 warning in patch 12 and 19 per the report from lkp.
> 2. add one more patch (20th).
> 
> Hi,
> 
> This series aim to cleanup siw code, please review and comment!

This series wasn't sent properly and it doesn't exist in patchworks and lore.
Please resend it properly.

Thanks
