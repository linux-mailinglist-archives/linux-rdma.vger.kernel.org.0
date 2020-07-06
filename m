Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62CC21575D
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 14:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgGFMfW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 08:35:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbgGFMfW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jul 2020 08:35:22 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F5B420715;
        Mon,  6 Jul 2020 12:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594038922;
        bh=h7+NgfAtZwJgoiY/mRp0VVjmvEaxbWhChuB+KqJxr+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m7hHAmMUWG2mGzcNdtLhCjvi0mC8/zXYOIn9HdNHCZ9RuzF9JL+qi9Hap5CnhEhex
         1z7IXB684RYai8SZPzyEHhWcE4cOpqvWxQ5p4S6xLryJA2f3rMoSiACKTjk3RwRqoD
         fU0u7Vj5nfGbDvrugWB2m8Sgym4v56hPSqkJUvq0=
Date:   Mon, 6 Jul 2020 15:35:15 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Lijun Ou <oulijun@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Adit Ranadive <aditr@vmware.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Zhu Yanjun <yanjunz@mellanox.com>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH for-next 2/3] RDMA/core: Remove ib_alloc_mr_user function
Message-ID: <20200706123515.GG207186@unreal>
References: <20200706120343.10816-1-galpress@amazon.com>
 <20200706120343.10816-3-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706120343.10816-3-galpress@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 06, 2020 at 03:03:42PM +0300, Gal Pressman wrote:
> Allocating an MR flow can only be initiated by kernel users, and not
> from userspace. As a result, the udata parameter is always being passed
> as NULL. Rename ib_alloc_mr_user function to ib_alloc_mr and remove the
> udata parameter.
>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/core/verbs.c | 11 +++++------
>  include/rdma/ib_verbs.h         | 10 ++--------
>  2 files changed, 7 insertions(+), 14 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
