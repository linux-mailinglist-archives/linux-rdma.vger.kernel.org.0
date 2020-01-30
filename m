Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 402F714D7D7
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2020 09:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgA3IjI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jan 2020 03:39:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:33044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgA3IjI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Jan 2020 03:39:08 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A533206D5;
        Thu, 30 Jan 2020 08:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580373547;
        bh=/4RmTE17GOWd6NrUkf8NAVvVf/IAN9bLW5LOHzdaNa8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mH0REqHXZj2SikLJ7+7NLEThLraVgoSK6xoJIMyx4m5Mt2M8XH8tQA/OX/C5kpO+R
         jQOkcRaCLaWKWZ+VQO9AzxwWEEG49vq4B9NqlPoPV3kRjyPn29VtzVva6+16HF8+d2
         JqdutMX7V//T8NmtkKcazXrl+CpnbyPXvCtmLlzg=
Date:   Thu, 30 Jan 2020 10:39:04 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-next] RDMA/providers: Fix return value when QP type
 isn't supported
Message-ID: <20200130083904.GF3326@unreal>
References: <20200130082049.463-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130082049.463-1-kamalheib1@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 30, 2020 at 10:20:49AM +0200, Kamal Heib wrote:
> The proper return code is "-EOPNOTSUPP" when the requested QP type is
> not supported by the provider.
>
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c     | 2 +-
>  drivers/infiniband/hw/cxgb4/qp.c             | 2 +-
>  drivers/infiniband/hw/hns/hns_roce_qp.c      | 2 +-
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c    | 2 +-
>  drivers/infiniband/hw/mlx4/qp.c              | 2 +-
>  drivers/infiniband/hw/mlx5/qp.c              | 2 +-
>  drivers/infiniband/hw/mthca/mthca_provider.c | 2 +-
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  | 2 +-
>  drivers/infiniband/hw/qedr/verbs.c           | 2 +-
>  drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 2 +-
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c | 2 +-
>  drivers/infiniband/sw/rdmavt/qp.c            | 2 +-
>  drivers/infiniband/sw/siw/siw_verbs.c        | 2 +-
>  13 files changed, 13 insertions(+), 13 deletions(-)

*_err() prints definitely should go too. Simple user space
application will create DDOS on dmesg with those prints.

I would say that other prints should be removed too or at least
put in general way inside the caller of ->create_qp() callback.

Thanks
