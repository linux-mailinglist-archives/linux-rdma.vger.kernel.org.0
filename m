Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474371FAAC3
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 10:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgFPIJt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 04:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbgFPIJt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Jun 2020 04:09:49 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABAC92074D;
        Tue, 16 Jun 2020 08:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592294989;
        bh=TnNFsF8rztMoV7W+U/CQlvlezHaw2ZFT7+kO9FpTDWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=viRklBegqqywEYiYzNSXsGc8i5P/MH/1pw+nn1RxFX1qYLkF4ibTQ5JNh9s/GbQ+d
         HRFUXVuX0MpPHDVzbRCXACR5ypEnQNDL5PXMG16JMftXBVyQiAtwzS6q1kOo8NJNI4
         hwf57hO8chn7zeL76FmzW9gFJM3V7sd2DGuW9J1s=
Date:   Tue, 16 Jun 2020 09:20:19 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     bvanassche@acm.org, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] IB/srpt: Remove WARN_ON from srpt_cm_req_recv
Message-ID: <20200616062019.GA2141420@unreal>
References: <20200616011715.140197-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616011715.140197-1-jingxiangfeng@huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 16, 2020 at 09:17:15AM +0800, Jing Xiangfeng wrote:
> It's easy to show that sdev and req are always valid,
> so we remove unnecessary WARN_ON.

So show it in the commit message, please.

>
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index ef7fcd3..0fa65c6 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -2156,9 +2156,6 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>
>  	WARN_ON_ONCE(irqs_disabled());
>
> -	if (WARN_ON(!sdev || !req))
> -		return -EINVAL;
> -
>  	it_iu_len = be32_to_cpu(req->req_it_iu_len);
>
>  	pr_info("Received SRP_LOGIN_REQ with i_port_id %pI6, t_port_id %pI6 and it_iu_len %d on port %d (guid=%pI6); pkey %#04x\n",
> --
> 1.8.3.1
>
>
