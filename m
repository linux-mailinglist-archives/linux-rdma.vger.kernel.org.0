Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026BD579543
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jul 2022 10:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbiGSIdH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jul 2022 04:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236914AbiGSIdE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jul 2022 04:33:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A253246F
        for <linux-rdma@vger.kernel.org>; Tue, 19 Jul 2022 01:33:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2C65B819CB
        for <linux-rdma@vger.kernel.org>; Tue, 19 Jul 2022 08:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E01BC341C6;
        Tue, 19 Jul 2022 08:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658219580;
        bh=u/LtEZf1fuqyLoflg2yr/zNVY9DpWTKvCkBsJn6/HO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jqyZqblXYz0THj+aosf/zXslMsz8h73BVk/N3R7qDdr1mmziSnkRRpjP+m8jcW7eJ
         w2d0XLYOjb0Z5wU5F8vp4L1JOzYaV9OyKzr2pMB714JjpzsqibmMMFV32hCtGCDml+
         DxZQ9gfb5gFvq38bu7hF2fNcnXcaqIYR+/+6tUdSZpY3tPAlp7pXUFNJuYvKDlOmj+
         tdMF+K9ONf6yuFO6o3JqVdIoO0EdPgyMdYNpu0OmafZs5zn/Vlf1QE0aWUk34E++Fv
         otulpLUnwNqD/9CSp3sXNYksCvNHxNAKRmVNkooIckl4anpqvknXeebbUswxm2B3UZ
         JPKA7/wIaHN0w==
Date:   Tue, 19 Jul 2022 11:32:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [RESEND PATCH] RDMA/rxe: Remove unused qp parameter
Message-ID: <YtZsOEgAXxzxEURC@unreal>
References: <20220708035547.6592-1-yangx.jy@fujitsu.com>
 <YtUZNruUx4jjrNhW@unreal>
 <4bca5022-2db6-b788-9a88-0615d6ea9e97@fujitsu.com>
 <YtVPEFHs5VaLe+mY@unreal>
 <3085f614-a64b-84d7-6d1d-9bbc0c4b71f1@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3085f614-a64b-84d7-6d1d-9bbc0c4b71f1@fujitsu.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 19, 2022 at 02:22:35AM +0000, yangx.jy@fujitsu.com wrote:
> On 2022/7/18 20:16, Leon Romanovsky wrote:
> > Please, try to apply the patch to wip/leon-for-next branch.
> > 
> > Thanks
> 
> Hi Leon,
> 
> It's OK to apply it to wip/leon-for-next branch on my environment.  Did 
> I miss something?
> 
> # git pull rdma wip/leon-for-next
>  From https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
>   * branch                      wip/leon-for-next -> FETCH_HEAD
> Already up to date.
> # git am 0001-RDMA-rxe-Remove-unused-qp-parameter.patch
> Applying: RDMA/rxe: Remove unused qp parameter

Strange, I used b4 and it failed to apply, but manually it worked.

Thanks, applied.

> 
> Best Regards,
> Xiao Yang
