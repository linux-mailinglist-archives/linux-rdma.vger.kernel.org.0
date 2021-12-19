Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BD8479FF5
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Dec 2021 09:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbhLSI6C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Dec 2021 03:58:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51984 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbhLSI6B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Dec 2021 03:58:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E97160C8B
        for <linux-rdma@vger.kernel.org>; Sun, 19 Dec 2021 08:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B271AC36AE7;
        Sun, 19 Dec 2021 08:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639904280;
        bh=1fKxY0+vE5IYdT2aYJVPiLv9dWljQQ+7Ea5vtqRb2/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iOEpUUsxO9cJNs0f77toYhjIsM+j8Oaka+HCoJ2+DsOtmIITsW3Ya/FB4RuJ1P6Lh
         ITF/Ad2/hlOBfQdVvvmJIJpTTfQ3PKqYm+WmFvIt+3K+2eKh4AhYQnZMmHSMzArbTq
         dAZ98Dm1xrpSOkzt+ZS3dq8jF9vPFF+yMo05hPLIefBGG+fCjnvKTnhmkAeL1SUx2o
         pK9xqQOVleNIk+jRU6+xpGzOa7WD8GfRQTFd77CzwtS5T5YUhSNQhK4EIszfJuryf2
         f4tEYdEttv9M7EbrJhm3zpWiRPCjSLb3M0NKK+sGPNoXE1whS9dEYK+5KPmTgxQbfJ
         ve93mkgNo2LUA==
Date:   Sun, 19 Dec 2021 10:57:55 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in
 dereg MR flow")
Message-ID: <Yb70EzdWWvOcoNFc@unreal>
References: <EEBA2D1C-F29C-4237-901C-587B60CEE113@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EEBA2D1C-F29C-4237-901C-587B60CEE113@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Dec 18, 2021 at 09:25:18PM +0000, Chuck Lever III wrote:
> NFS/RDMA with an NFS client using mlx5-based hardware triggers a
> system deadlock (no error messages) on the client. I bisected to
> f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in
> dereg MR flow").

Thanks for the report. We started to look on it, but the vacation season
makes it is slower than usual.

Thanks

> 
> --
> Chuck Lever
> 
> 
> 
