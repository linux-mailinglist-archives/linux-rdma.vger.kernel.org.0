Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A24A7D912
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 12:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfHAKK1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 06:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfHAKK1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 06:10:27 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9918F206B8;
        Thu,  1 Aug 2019 10:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564654226;
        bh=xdUmGqlkKKHPRZYpNIXYrU6rl1LlF4QUNBWLB8n4PrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VvBNK3f7i4CetdgFcyjUeqVWbufpz3ovhP3c5TvB6RcdTHyiH0EKYm0AiGOF6DI2r
         +MQl/BylYctg0rdmOQlIK+TfZF0daHOUCvrab2PLWh1gOtyFrNErEZ5bsYVJQV3ZgX
         mxKXDRjUf6EFTTiS1EWB/1pAbuAnKsGmtJu1TobQ=
Date:   Thu, 1 Aug 2019 13:10:23 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     oulijun@huawei.com, xavier.huwei@huawei.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/hns: remove set but not used variable
 'irq_num'
Message-ID: <20190801101023.GI4832@mtr-leonro.mtl.com>
References: <20190731073748.17664-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731073748.17664-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 31, 2019 at 03:37:48PM +0800, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/infiniband/hw/hns/hns_roce_hw_v2.c: In function hns_roce_v2_cleanup_eq_table:
> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:5920:6:
>  warning: variable irq_num set but not used [-Wunused-but-set-variable]
>
> It is not used since
> commit 33db6f94847c ("RDMA/hns: Refactor eq table init for hip08")
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 --
>  1 file changed, 2 deletions(-)
>

I'm hitting this error too.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
