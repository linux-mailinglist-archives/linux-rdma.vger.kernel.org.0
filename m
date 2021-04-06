Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3ED354EE4
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 10:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244491AbhDFIpm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 04:45:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244485AbhDFIpl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Apr 2021 04:45:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31BA2613C2;
        Tue,  6 Apr 2021 08:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617698733;
        bh=P4WkmhP18w3/qefzSYLBVb6xExN/hOqmzTYO9VJh9X8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rY+NtmgnsmhSAm+sGz8PgQxusLwGrHW7tXbTjq3PT2kkyVz7bKsRTsxQsGrBw6XZ7
         HHSh2gc7E/9eqOPpO3hTS4Y1bqNrZcSqplpmK9X6Px+/kLAFr7riiQU2pBX1WlFkrh
         i+NiCnOf1YDofxkkftoUt2dTEwD8ZEN8WBkLhtL/eyhsGf4U0JUHN9HbiPK/PIl47h
         Om4aZ80KdiEr490QWsAxnXsjnChnnMQ/EtBCkUkaNqufqDoomSq8ya91xYvoCBujbi
         0pkP3K4scUlstxTrh1IwHRdvq3Kj7VTVo02wArnwBh+WGk5wQVsdRhqHtJ+SVug8KM
         1BO0rIUSdETeQ==
Date:   Tue, 6 Apr 2021 11:45:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/core: Flush workqueue before destroy it
Message-ID: <YGwfqiCRi4dq2F8r@unreal>
References: <1617698091-47439-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617698091-47439-1-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 06, 2021 at 04:34:51PM +0800, Weihang Li wrote:
> From: Yixian Liu <liuyixian@huawei.com>
> 
> It is safer to flush the workqueue before destroying it.

Sorry, safer for what?

destroy_workqueue() flushes workqueue internally. There is no need to do
it twice.

Thanks

> 
> Signed-off-by: Yixian Liu <liuyixian@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/core/addr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
> index 0abce00..e58a06b 100644
> --- a/drivers/infiniband/core/addr.c
> +++ b/drivers/infiniband/core/addr.c
> @@ -883,6 +883,7 @@ int addr_init(void)
>  void addr_cleanup(void)
>  {
>  	unregister_netevent_notifier(&nb);
> +	flush_workqueue(addr_wq);
>  	destroy_workqueue(addr_wq);
>  	WARN_ON(!list_empty(&req_list));
>  }
> -- 
> 2.8.1
> 
