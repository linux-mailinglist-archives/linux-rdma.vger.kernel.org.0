Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0E421574C
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 14:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgGFMcy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 08:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbgGFMcy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jul 2020 08:32:54 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91E83206E6;
        Mon,  6 Jul 2020 12:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594038774;
        bh=EkDjqWhfNHfJFC/yKEFFyliPxvW+I3KXcTvKIPQHDXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xTJ8UY4NPalXp2/eW5XV7UY84kqm+hja8Rx+6DD4QJyZhv3pI8o9uJ+23RbzUnLsD
         mI2Al23G8j5vN+9i1GU9S3GZHPJM7kNecIDW+4Udb9BnH8xMZt1I/+QsmsKHEQBrAW
         oX19EnD0m5PJSZUtS32hHTvJaIv6kJ3pyL99BaME=
Date:   Mon, 6 Jul 2020 15:32:50 +0300
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
Subject: Re: [PATCH for-next 1/3] RDMA/core: Check for error instead of
 success in alloc MR function
Message-ID: <20200706123250.GF207186@unreal>
References: <20200706120343.10816-1-galpress@amazon.com>
 <20200706120343.10816-2-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706120343.10816-2-galpress@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 06, 2020 at 03:03:41PM +0300, Gal Pressman wrote:
> The common kernel pattern is to check for error, not success.
> Flip the if statement accordingly and keep the main flow unindented.
>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/core/verbs.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
