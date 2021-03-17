Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D6D33F61E
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Mar 2021 17:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhCQQ46 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Mar 2021 12:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232499AbhCQQ42 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Mar 2021 12:56:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F194C64F5E;
        Wed, 17 Mar 2021 16:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616000187;
        bh=hwGEhFB4YcpCQIKOUfRsHM4equpQqj/Oynp++j1wFQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lmObq/fOCpest7tknibMEScj6dHIpwxjUrxQWnXdy9zQONdNBd8j729pmACMfFaO9
         LezuY9sdSL39/0kO+sR2z6pHpblMZYRAfKyJ/9A7jFwCZIkkMn9SahXBMJ6SNXDVtu
         l96zFKd7rCAq8nd8YqfHxljEjwSiu2qo9TacVvKlU50eldHgu0JtmsXZ3eKxyWfvsK
         dzKaF8ZVJHyCVTqIecedW+U81wnrfl5WelUDzUdF1vJmqSIjYn4ZPQ8QSCF+XmuSME
         v+laMBpn/3KfLTgo0TI52KfrzcioHtRg/dsoimhaFIHHvMSD01/jO3XzE3nXL1JA5Z
         J+ilQG8qwmf9A==
Date:   Wed, 17 Mar 2021 18:56:23 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH for-next] RDMA/hns: Support to query firmware version
Message-ID: <YFI0t3yLJfb0gxK2@unreal>
References: <1615882161-53827-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615882161-53827-1-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 16, 2021 at 04:09:21PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
>
> Implement the ops named get_dev_fw_str to support ib_get_device_fw_str().
>
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_main.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
