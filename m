Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A3057814A
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 13:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiGRLwN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 07:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbiGRLwM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 07:52:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2535D22BFF
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 04:52:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71DA7B810F4
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 11:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F960C341C0;
        Mon, 18 Jul 2022 11:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658145128;
        bh=/MaSzchmbQMowCfJN7gc+y/CSuRJUMxrsR0ePa3x6A4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Px7BqwwJbmZrbpWzFRwjclwGT0LF1Hsy6R27yeXfChWhAwwfsBaq/z9Ja3obqC3OZ
         hAowtQjdELMKezyh3WRsAoZhAjGxvLZ0AX/5tcs17MbSTQ7zMrBM0UzFTbH2bX/A/j
         cOlTQyyCxtXR0Wrcy/+FrQiZ8IvTKM0oI0BIE8p+4ALrczjmZHsk0CdRfVlGl33MvH
         Xeef1Sys0RhBWwsvtPUjihvGxARtLCoqHrVy4bh5rlnpJ+MELhfeRgeozSmK+Ws/B/
         BFTGKEYU16pQhaE5wmOBHzIRshKaNwFtupr5z9U7mK2JPa+/QrGC62STNNP+cNUH/r
         cwXWcNMBhOmNw==
Date:   Mon, 18 Jul 2022 14:52:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH for-next v2] RDMA/rxe: Remove unused mask parameter
Message-ID: <YtVJY4pfnNE5XQLs@unreal>
References: <20220715035340.1900168-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715035340.1900168-1-lizhijian@fujitsu.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 15, 2022 at 03:46:36AM +0000, lizhijian@fujitsu.com wrote:
> This parameter had beed deprecated since below commit:
> 1a7085b34291 ("RDMA/rxe: Skip adjusting remote addr for write in retry operation")
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> Feel free to add above commit to fixes tag if needed.
> V2: add commit log.
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Thanks, applied.
