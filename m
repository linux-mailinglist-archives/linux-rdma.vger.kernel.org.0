Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F038E435E54
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 11:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhJUJyJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 05:54:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231520AbhJUJyI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 05:54:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CF956115B;
        Thu, 21 Oct 2021 09:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634809913;
        bh=jJbZjPCQxttg801JDgg2lbvNvnoX7I2yHFROX6dXejI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cdXBruEikBt0J+NoXDwTcnKpDwF/JKt4oayBd9oXYezbA587CFOTJddFAOeHFkMP/
         xr1RlynbIKxN26tt79k7/FBuJYawaCoCFrA9p7xAvfvneOSPgSp7/v31R/me++RiA4
         SHKwbhJ/+gQ269IBBwZ6+4e2TONFYt9WbiUcaCV0IqkICOfrFs3NY7nCD14GSES6MA
         QA0djkRe9bh2QfdDXtJLcK9JhOOiY1nCm+l56fs8CCIRr69yfyTCmYmWdkSQmwOACO
         3Ari0PJDAcX/UZeXGY5WmnUF1u8ECjfh50AiRI+J8+d9tF8rrbjHxQzQsyX0pcw1Bo
         Y00L4UVQvp6hA==
Date:   Thu, 21 Oct 2021 12:51:49 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        liangwenpeng@huawei.com, liweihang@huawei.com,
        mustafa.ismail@intel.com, shiraz.saleem@intel.com, benve@cisco.com,
        neescoba@cisco.com
Subject: Re: [PATCH rdma-next 3/3] RDMA: constify netdev->dev_addr accesses
Message-ID: <YXE4NYDhKrYdHa8Y@unreal>
References: <20211019182604.1441387-1-kuba@kernel.org>
 <20211019182604.1441387-4-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019182604.1441387-4-kuba@kernel.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 19, 2021 at 11:26:04AM -0700, Jakub Kicinski wrote:
> netdev->dev_addr will become const soon, make sure
> drivers propagate the qualifier.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: mike.marciniszyn@cornelisnetworks.com
> CC: dennis.dalessandro@cornelisnetworks.com
> CC: dledford@redhat.com
> CC: jgg@ziepe.ca
> CC: liangwenpeng@huawei.com
> CC: liweihang@huawei.com
> CC: mustafa.ismail@intel.com
> CC: shiraz.saleem@intel.com
> CC: benve@cisco.com
> CC: neescoba@cisco.com
> CC: linux-rdma@vger.kernel.org
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_res.c   |  2 +-
>  drivers/infiniband/hw/bnxt_re/qplib_res.h   |  2 +-
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c    |  6 +++---
>  drivers/infiniband/hw/bnxt_re/qplib_sp.h    |  5 +++--
>  drivers/infiniband/hw/hfi1/ipoib_main.c     |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_device.h |  3 ++-
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c  | 10 +++++-----
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  6 +++---
>  drivers/infiniband/hw/hns/hns_roce_main.c   |  3 ++-
>  drivers/infiniband/hw/irdma/cm.h            |  4 ++--
>  drivers/infiniband/hw/irdma/hw.c            |  7 ++++---
>  drivers/infiniband/hw/irdma/main.h          |  5 +++--
>  drivers/infiniband/hw/irdma/trace_cm.h      |  8 +++++---
>  drivers/infiniband/hw/irdma/utils.c         |  4 ++--
>  drivers/infiniband/hw/irdma/verbs.c         |  2 +-
>  drivers/infiniband/hw/usnic/usnic_fwd.c     |  2 +-
>  drivers/infiniband/hw/usnic/usnic_fwd.h     |  2 +-
>  17 files changed, 40 insertions(+), 33 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
