Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A41307707
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 14:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhA1N13 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 08:27:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhA1N12 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 Jan 2021 08:27:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94B1A61492;
        Thu, 28 Jan 2021 13:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611840408;
        bh=7nIYbuoTPLva7tmEdxMTL6hX2xOYlglGai6BQ01xO8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MlA9HoYaus75ELQ4Yzhu12N52xwTP6FnECfVnug67Eesvx++AzrO7ugIQ5qm+qLXG
         IV3fYos/KwVcpaFXSgg91t1o1r7jZVeC3BJ7imsNLPc6yGCNoeGUywJ03bWh8N0tkN
         haeVcy0l+DBdyT+8r2/nIPoISg4pBAFtVnZA4x23hGrSXuP7t3sm8y3RnyOC1SkHh+
         yh9gVcSmPk1E69NXLkCxtjpTMZTkb9OmJX9q354FKALzOrAK3RsskCSDIcPMuFhZu4
         z/2rAiKFnoX+LfZ5+ija4r4ILdCoYXu5RWmGaEpC6RcpGaduY/0uvt3NjjCBI5qLgz
         QJKjp9DP3CKTQ==
Date:   Thu, 28 Jan 2021 15:26:44 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc:     jgg@nvidia.com, dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-core 0/5] Add irdma user space provider for Intel
 Ethernet RDMA
Message-ID: <20210128132644.GA166678@unreal>
References: <20210128035704.1781-1-tatyana.e.nikolova@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128035704.1781-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 27, 2021 at 09:56:59PM -0600, Tatyana Nikolova wrote:
> This patch series replaces the current i40iw library with
> a unified Intel Ethernet RDMA library that supports
> a new network device E810 (iWARP and RoCEv2 capable)
> and the existing X722 iWARP device. The new library is fully
> backward compatible with the i40iw driver and is designed
> to be used with multiple future HW generations.
>
> The corresponding irdma driver patch series is at
> https://lore.kernel.org/linux-rdma/20210122234827.1353-1-shiraz.saleem@intel.com/
>
> Tatyana Nikolova (5):
>   rdma-core/i40iw: Remove provider i40iw
>   rdma-core/irdma: Add Makefile and ABI definitions
>   rdma-core/irdma: Add user/kernel shared libraries
>   rdma-core/irdma: Add library setup and utility definitions
>   rdma-core/irdma: Implement device supported verb APIs

1. As we will approach to the actual merge, please post PR on github,
it will give us a way to see in advance that all our checkers are fine.
2. Kernel headers are needed to be pulled with kernel-header/update script.
3. Please, no fprints in the library for the new code. I recommend to
take MLX5_DEBUG_FILE logic and move it one layer up so it will be
applicable for all providers.

Thanks
