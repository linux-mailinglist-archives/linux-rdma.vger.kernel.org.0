Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D91E3CF66E
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbhGTIQH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 04:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234866AbhGTIK6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 04:10:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FAB96120C;
        Tue, 20 Jul 2021 08:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626771096;
        bh=Kf3C4FZgBVRBqSMvYqM0Ng37SgWwV6ue9lfwb2pQQOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/1AGIBLaPJKW7xJ9+oLCNl3Yy5wm7b8OwIo28jeTg5t9HU9TgwLdQxUKgEUWhkl/
         3kOOpqASG4+cLMz7KmgB1w5YULwweN4hXf9LHVnQNgShICozhHmCpKrhU+sYx8jB/T
         3ToDOaSt9spgwWJ0ontBQNlxxqeObOElNCb9Exs2LrXytmPHKRTFBaVxRZaOZVj+gM
         8R7T7tFRrdn4MueuQJesB1B8XSJJWA32B3YH1Uw54LJrdCkN9wTtjB0tQyb98xKKYJ
         Ixp7qlPoesfl1c3yC9IIxIXLEP9PSxpdgDNu9l33c1pHw9+f3QCMxpS9xlWFOK2Brz
         FShWV5y2Fr0SA==
Date:   Tue, 20 Jul 2021 11:51:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, jgg@nvidia.com, maorg@nvidia.com,
        markzhang@nvidia.com, edwards@nvidia.com
Subject: Re: [PATCH rdma-core 03/27] mlx5: Enable debug functionality for vfio
Message-ID: <YPaOlTDrV877Jgnt@unreal>
References: <20210720081647.1980-1-yishaih@nvidia.com>
 <20210720081647.1980-4-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720081647.1980-4-yishaih@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 20, 2021 at 11:16:23AM +0300, Yishai Hadas wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
> 
> Usage will be in next patches.
> 
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> ---
>  providers/mlx5/mlx5.c | 28 ++++++++++++++--------------
>  providers/mlx5/mlx5.h |  4 ++++
>  2 files changed, 18 insertions(+), 14 deletions(-)

Probably, this patch will be needed to be changed after
"Verbs logging API" PR https://github.com/linux-rdma/rdma-core/pull/1030

Thanks
