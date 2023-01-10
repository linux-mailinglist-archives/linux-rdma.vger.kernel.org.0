Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD88B663D85
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jan 2023 11:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjAJKHr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Jan 2023 05:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjAJKH1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Jan 2023 05:07:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E172510B50
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jan 2023 02:07:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8684161588
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jan 2023 10:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676B7C433D2;
        Tue, 10 Jan 2023 10:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673345246;
        bh=rSdoulM94J4YFWnpmUoZUHDuyI846bbC8N9Q3BV6leg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MtRQHH39IZhJbXdt5h2m1aFeMslqNZ2Pb77VrdxVNJzWwkGyEE+BwQGys3HIRjs4V
         WKyn+ocoLEVCzdugWWvoBYeVlFypDxh5n9+4G8vhYUc5g2QJw0lZ0eiUkRaRSt5Dtu
         EeftLJwdw0GXkagKSo0V5aFXqVojgCuQ+w+MQekg09Byl37TTBIwHAyv6uE5b7CBwS
         ieKYc1wiAVy8Fs6xwh/h83qv16kia0G+IJoqCt95/2t1HyrHvBQQGY282hx0/I9UC7
         AKRH2H+YbzNNXHs+r51pLJf+icpootrc1pgaR7/yFnT8UcFyEtYvlIY8wuzE/5jBLh
         t7WUqS+n906XQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org, sleybo@amazon.com, matua@amazon.com,
        Jason Gunthorpe <jgg@ziepe.ca>, ynachum@amazon.com
Cc:     mrgolin@amazon.com, yatias@habana.ai
In-Reply-To: <20230109133711.13678-1-ynachum@amazon.com>
References: <20230109133711.13678-1-ynachum@amazon.com>
Subject: Re: [PATCH for-rc v3] RDMA: Fix ib block iterator counter overflow
Message-Id: <167334524142.1182097.17381379205736385248.b4-ty@kernel.org>
Date:   Tue, 10 Jan 2023 12:07:21 +0200
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


On Mon, 09 Jan 2023 13:37:11 +0000, ynachum@amazon.com wrote:
> When registering a new DMA MR after selecting the best aligned page size
> for it, we iterate over the given sglist to split each entry to smaller,
> aligned to the selected page size, DMA blocks.
> 
> In given circumstances where the sg entry and page size fit certain
> sizes and the sg entry is not aligned to the selected page size, the
> total size of the aligned pages we need to cover the sg entry is >= 4GB.
> Under this circumstances, while iterating page aligned blocks, the
> counter responsible for counting how much we advanced from the start of
> the sg entry is overflowed because its type is u32 and we pass 4GB in
> size. This can lead to an infinite loop inside the iterator function
> because the overflow prevents the counter to be larger
> than the size of the sg entry.
> 
> [...]

Applied, thanks!

[1/1] RDMA: Fix ib block iterator counter overflow
      https://git.kernel.org/rdma/rdma/c/e71b6f877b4070

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
