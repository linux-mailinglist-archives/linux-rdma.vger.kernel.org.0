Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E3438A040
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 10:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhETIx7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 May 2021 04:53:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231182AbhETIx7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 May 2021 04:53:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75F2461244;
        Thu, 20 May 2021 08:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621500758;
        bh=yayHFDjpgHtdWHVnBsqe8YdA+I2mjvDBcwmvU9gNzdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kyYJMlHdkUMBOIGFGUFOBz1yG0NmaLNj4MQVNUut1uKIqWWB48fqGt+Tyg/wdPFmO
         OvVYLvTqPQYOGHXnOAq8Om5KwTTRtQWd8Tw7jdK8DKT8bARqMHeiFjqrT7/YYiH/cc
         c8pb+t5i93sQkfxghYcjIjYwj9wtUj2kfrfSXuPv0Rq0Jucx7sITO81laxqMdoLgGd
         s+nPyhbazCKgGbknO4/j9PoWWX46VDYjpBBC/FBNT2tSZap0UD0XAW2eCaFwty9Z/d
         APUqj+hHQyTf2l93P/xREaHReWAaWc28JhtlQ6z687xScApjtwyF0B82nmultQxrkL
         LtS1v7PVV/KCg==
Date:   Thu, 20 May 2021 11:52:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Lang Cheng <chenglang@huawei.com>
Subject: Re: [PATCH v2 for-next 2/3] RDMA/hns: Remove Receive Queue of CMDQ
Message-ID: <YKYjUg20gXo1HTG4@unreal>
References: <1621482876-35780-1-git-send-email-liweihang@huawei.com>
 <1621482876-35780-3-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621482876-35780-3-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 20, 2021 at 11:54:35AM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> The CRQ of CMDQ is unused, so remove code about it.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 97 ++++++++----------------------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  1 -
>  2 files changed, 25 insertions(+), 73 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
