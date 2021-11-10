Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11C144C2F6
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Nov 2021 15:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhKJOdH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Nov 2021 09:33:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232041AbhKJOdH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 10 Nov 2021 09:33:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FBA16109D;
        Wed, 10 Nov 2021 14:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636554620;
        bh=YrSsH515O4D9y9GoxhbDq1natgiJ0EExdks6igdAXAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lCPtMl3w06gSY43LN0dM8jFOK/Sr/yAmYbbXOTAmjU/jQCBrqcO07r6EtxoXbMghs
         6c1LhFwZZMigsL7WHdnsBCYxwxI+qvkxsL6l3gLQBT4HHPA9xIVpCnkmWLwhhu9J64
         5otVYv8/qtb3EdzV/1TfWf/BoG8jG6F1ufObVjRYTbH2sOeaXcIZLM4caJeQEjhw5C
         6GzSePJDx5brV4GER/HJHjODO2z2E3axBf1uiqOH96s05d/ScviOerOgqY3iPgJnAk
         WzFoyWFa3bzV8E1BDAxJf4oBghLh+QVaJDvBuMnqhofZB6qSvpqG6t9T7bcAuZVeM5
         gi+1bfnys9mpg==
Date:   Wed, 10 Nov 2021 16:30:16 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH rdma-core 0/7] libhns: Cleanup about removing redundant
 code and cleaning up static alarms
Message-ID: <YYvXeCgs2IaR3Mta@unreal>
References: <20211109124103.54326-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109124103.54326-1-liangwenpeng@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 09, 2021 at 08:40:56PM +0800, Wenpeng Liang wrote:
> Patch #1~#3: Remove redundant code.
> Patch #4~#5: Fix wrong type of printf format, variables and fields.
> Patch #6~#7: Other miscellaneous cleanup.
> 
> Lang Cheng (1):
>   libhns: Remove unused macros
> 
> Wenpeng Liang (1):
>   libhns: Remove unsupported QP type
> 
> Xinhao Liu (4):
>   libhns: Fix wrong print format for unsigned type
>   libhns: Fix wrong type of variables and fields
>   libhns: The content of the header file should be protected with
>     #define
>   libhns: The function declaration should be the same as the definition
> 
> Yixing Liu (1):
>   libhns: Remove redundant variable initialization

Applied, pending CI results
https://github.com/linux-rdma/rdma-core/pull/1082

Thanks
