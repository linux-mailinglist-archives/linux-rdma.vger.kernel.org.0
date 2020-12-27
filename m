Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347EE2E3078
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Dec 2020 09:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgL0IeK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Dec 2020 03:34:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:46784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgL0IeK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Dec 2020 03:34:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33A25217A0;
        Sun, 27 Dec 2020 08:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609058009;
        bh=MKeP2MUmgRa7CjR0r38nTcmSO6fgoGp9VeSiQuUILQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CK5jww0lUBSzR6qsB5zrpFw83KrvuLVbRPafX/uDansknAmIZiNzGM2lIYwzI5o81
         BVaXz/CX5WcueqLQp7tDjxqDFoFLB5ntIIR2ACqPbCWq1A4sP41NDMbmxzfqLPoL6A
         h85eaGh9BpScK1YoFdMWDcb0EHczb4fke4plFJ2+wns9vZf7ODVTeUIyUPFRx7oki6
         2eA3qc+4FYP/Kvjm0ToQxxayNVrdYqKzSDeNSBjLE/Unz31e36uQkId1O3FTgtCf6B
         4lCAeFGgMYCXFR8OvyDgqs6aDEJ0WwM6UIascMcpTcXcke5z58LgAELwI+bJFhDLZS
         03Iy6ZBhULlVg==
Date:   Sun, 27 Dec 2020 10:33:26 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     trix@redhat.com
Cc:     oulijun@huawei.com, huwei87@hisilicon.com, liweihang@huawei.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: remove h from printk format specifier
Message-ID: <20201227083326.GE4457@unreal>
References: <20201223193041.122850-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223193041.122850-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 23, 2020 at 11:30:41AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
>
> This change fixes the checkpatch warning described in this commit
> commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary %h[xudi] and %hh[xudi]")
>
> Standard integer promotion is already done and %hx and %hhx is useless
> so do not encourage the use of %hh[xudi] or %h[xudi].
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
