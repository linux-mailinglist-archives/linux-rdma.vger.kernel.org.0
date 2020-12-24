Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB402E24C5
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Dec 2020 07:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbgLXGWw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Dec 2020 01:22:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgLXGWw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Dec 2020 01:22:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6591022571;
        Thu, 24 Dec 2020 06:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608790932;
        bh=ad4bPxuanUCvftR8hiKgiLTzJnilQOEQ+KqnElp7dSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lj8eI9sy2uo6YPGArhx2FKaXHjHvSJiZ82EuyYkNyz6zPG77tuOaSI1VxTtymI3nJ
         j6xQCDoMDzb/A7mwd8DX7V0qta5We+fR+Y/aMvhAJLe039A2ZF3CWbY9Uvi5xpqsmf
         9V6ZGUuvi2StfO1uJrhIJaeSTw0SCyWVzUT9X0afsJjMtkbs21R66pvNldCyqQyU1r
         PrbbrVAvx5H9ULLhCIyYPW5+KEolvqQNU9R7xjT2sGlNOrKRGgz14JV+m6jj5Uce0W
         laCCLvR4px3X4/cQdn2tgiuwmqFBO9IM89ySRcX6wwDaAHtq1LD8vfMeaCbuoZ1hNB
         E1vRKGgLRK5kA==
Date:   Thu, 24 Dec 2020 08:22:08 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mlx5: use DEFINE_MUTEX (and mutex_init() had been
 too late)
Message-ID: <20201224062208.GA18357@unreal>
References: <20201223141223.313-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223141223.313-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 23, 2020 at 10:12:23PM +0800, Zheng Yongjun wrote:
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

It is unclear what you wanted to achieve, because the commit message is
missing and subject doesn't help either.

Anyway, this code was changed in the commit f22c30aa6d27
("RDMA/mlx5: Move xlt_emergency_page_mutex into mr.c")

Thanks
