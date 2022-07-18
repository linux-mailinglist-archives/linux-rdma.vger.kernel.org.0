Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5025780EB
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 13:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiGRLhw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 07:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiGRLhv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 07:37:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1656921243
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 04:37:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B06FCB81208
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 11:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BA9C341C0;
        Mon, 18 Jul 2022 11:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658144268;
        bh=uJ8PG0UhAhWWAKbe1XKGW5b44EIn/+vXoEHaEpxGTf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iG6sLidJaRKsdyJpXGdlqIo7O9kV2d9DUvAXCklfDScGFKVt0yOsqXHd2IqLVt9wi
         UlW1TSbUrG5DEaSYBgc99Pg/WmerT132NjFdcGd+M1ZibaDBzcqLzrjevNYXcEyrbm
         Txyl7kKWasF+rtKgZs/mL602TybHgfGXi5CwlWYpfuNHUET3u2nPNsGnN3OLsgflQO
         3Z6aeVflficnh3lzJQ7jgh1am09bxqQ56BkA4AurEDS0Y9PZs47m/tDTkmxuVXSGks
         /QISAsm41LAOHY4DWU0YCvUFLpd0IMv/ev62JDM3RzksdhOCOO/wpTtIu3HpBkz3Lf
         vYqmfM6bt9jpw==
Date:   Mon, 18 Jul 2022 14:37:43 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, jgg@ziepe.ca, rpearsonhpe@gmail.com,
        zyjzyj2000@gmail.com
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Add common rxe_prepare_res()
Message-ID: <YtVGB4lbLf+bZb4j@unreal>
References: <20220705145212.12014-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705145212.12014-1-yangx.jy@fujitsu.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 05, 2022 at 10:52:11PM +0800, Xiao Yang wrote:
> It's redundant to prepare resources for Read and Atomic
> requests by different functions. Replace them by a common
> rxe_prepare_res() with different parameters. In addition,
> the common rxe_prepare_res() can also be used by new Flush
> and Atomic Write requests in the future.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 71 +++++++++++++---------------
>  1 file changed, 32 insertions(+), 39 deletions(-)
> 

Thanks, applied.
