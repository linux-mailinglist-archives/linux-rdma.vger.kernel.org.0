Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63FD481B96
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Dec 2021 12:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238795AbhL3LIt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Dec 2021 06:08:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38108 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbhL3LIq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Dec 2021 06:08:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBEAD6167A
        for <linux-rdma@vger.kernel.org>; Thu, 30 Dec 2021 11:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8423EC36AEA;
        Thu, 30 Dec 2021 11:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640862525;
        bh=X01JtXhJx+XXpuMjrQraeLSLobVtkh5CRETkOlekm7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CRGhjE4ZFCWtfrbMc99QebFPHcoPtjq+ed94As2p0a8NxGueRvR8jBC/IcEOLNDvb
         6O+tqFNAc+bzutDfO448tY/oqAnKb1AWF5Q5q3oXoqRDAH1Cb8YmE2xpcZeUHnqvJR
         ZanbTT8AaqlQIbYCC7UOiPl2dyxe8je/NKIOSGIf8VtEgtRqYzsPnSwDYFyqaZ17V0
         NgY+HA0nKtu3ZEQSNjWD44UKKdYtmTUM5Mdzjsxy30+5zSXcOH4oB2zz74iPVZhfdB
         DdXYAxtX+cbBFxTQH10RAbocgbhCeQqF2IQlETMnBkQhOxA828ZE5Tkz00cEOm75zC
         dzgR3ON0D6cpw==
Date:   Thu, 30 Dec 2021 13:08:40 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Timo Rothenpieler <timo@rothenpieler.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-rc] Revert "RDMA/mlx5: Fix releasing unallocated
 memory in dereg MR flow"
Message-ID: <Yc2TOLGizSnopOSe@unreal>
References: <20211222101312.1358616-1-maorg@nvidia.com>
 <1b133ec9-b47f-10e1-7e9f-f3393c1d7c44@rothenpieler.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b133ec9-b47f-10e1-7e9f-f3393c1d7c44@rothenpieler.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 29, 2021 at 02:10:31PM +0100, Timo Rothenpieler wrote:
> On 22.12.2021 11:13, Maor Gottlieb wrote:
> > This patch is not the full fix and still causes to call traces
> > during mlx5_ib_dereg_mr().
> > 
> > This reverts commit f0ae4afe3d35e67db042c58a52909e06262b740f.
> 
> What is the status of this in the latest stable Kernel?

The revert is not accepted yet.

> I see that f0ae4afe3d35e67db042c58a52909e06262b740f was backported into
> 5.15, but since then, no fix or revert made it into 5.15.
> 
> I wanted to upgrade our cluster to 5.15 soon, but I'm a bit concerned about
> reports of issues surrounding this patch.


