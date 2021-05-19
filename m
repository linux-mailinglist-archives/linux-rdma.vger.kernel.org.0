Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D05C388C1E
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 12:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhESKzM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 06:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhESKzH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 06:55:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AE966135C;
        Wed, 19 May 2021 10:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621421628;
        bh=S42VLQUNMhqwkl64OQjG5UGVO92yr+TrbjWv9PpdN+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DdYyLxwrc4LmzkgmTqOpbFkzLduPIglc/wSwnDEf5BIqUZyr/v70r8Z17bGTYNA9T
         KMlj1JPjWc8BAGwWGZJBV559ZIr/pCdyU3XYHftjcKS+riZIBxpxgj7sO8vzH2Wty9
         EGrh3/vaNQ/zV/hj8Cpu63i0ORYfseWwi1pFo5RuifmUL2F9f9X6K+3vbXXSWDnqYm
         3+OJfQO40KGu5Pif02V5z8r3B2KIknTr6KgojCfOiaA9FMbPLT/RHezZhhCTp3pQ6o
         F+L+B0BAsVZEL4K6YGCiMwIx2In63eHBkpfe+bpzC+YcuxORdiyiXGvPEcoE+GtDDY
         Lpz4M6SWlG3Vg==
Date:   Wed, 19 May 2021 13:53:44 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Lang Cheng <chenglang@huawei.com>
Subject: Re: [PATCH for-next 1/3] RDMA/hns: Rename CMDQ head/tail pointer to
 PI/CI
Message-ID: <YKTuOF7uqqbXlbAX@unreal>
References: <1620904578-29829-1-git-send-email-liweihang@huawei.com>
 <1620904578-29829-2-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620904578-29829-2-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 13, 2021 at 07:16:16PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> the same name represents opposite meanings in new/old driver, it
> is hard to maintain, so rename them to PI/CI.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_common.h |  4 ++--
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 10 +++++-----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
