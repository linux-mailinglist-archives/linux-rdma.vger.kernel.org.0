Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE92AF703
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2019 09:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfIKHfn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Sep 2019 03:35:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfIKHfm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Sep 2019 03:35:42 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DA04208E4;
        Wed, 11 Sep 2019 07:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568187342;
        bh=PZ50QoSsFbLHTX8/tLBCZMgZyh/RcqIqW3XaIgnOLdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PyR4GHVHbic1tPohI4DPUkvdh8+8Gt8Vu9GPxMbFd585GDB4NQ0Mqb4d9C9EDV/0Q
         iQnP3CQHZiNn4cwjN7hch3MWlSqOQFHQg/pn9h3XM0VpLnlN+08k1+h/2Rf/wdFFY2
         +0//qHnpYDbIEwBzEcwI6CSD6DlkHCY6eHsZPAho=
Date:   Wed, 11 Sep 2019 10:35:38 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@hisilicon.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH rdma-core 3/5] libhns: Refactor for post send
Message-ID: <20190911073538.GC6601@unreal>
References: <1568118052-33380-1-git-send-email-liweihang@hisilicon.com>
 <1568118052-33380-4-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568118052-33380-4-git-send-email-liweihang@hisilicon.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 10, 2019 at 08:20:50PM +0800, Weihang Li wrote:
> From: Yixian Liu <liuyixian@huawei.com>
>
> This patch refactors the interface of hns_roce_u_v2_post_send, which
> is now very complicated. We reduce the complexity with following points:
> 1. Separate RC server into a function.
> 2. Simplify and separate the process of sge.
> 3. Keep the logic and consistence of all operations.
>
> Signed-off-by: Yixian Liu <liuyixian@huawei.com>
> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
> ---
>  providers/hns/hns_roce_u.h       |   7 +
>  providers/hns/hns_roce_u_hw_v2.c | 427 ++++++++++++++++-----------------------
>  2 files changed, 186 insertions(+), 248 deletions(-)
>

No printf() calls in the providers code, please.

Thanks
