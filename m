Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8B62B4137
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 11:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgKPKgZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 05:36:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:41476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbgKPKgY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Nov 2020 05:36:24 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50FDE20674;
        Mon, 16 Nov 2020 10:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605522983;
        bh=sB1fHRfQmwkkYezelPi5kH60dsraF17NjD8mYeSex1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BuNrY5fQErUh/1P2ZIaVFVahY1lVfFpyAKONxMmg1jvFNxvE4H20Sf+mP3esbFc0o
         yVWG3oNBBWberVrRNkVye8LBn5qXslIaj8pXV2rzuVLkM/7cdl4jXrK0xb8sl+mEB2
         subjnfIe1JOggyBsD6p5eMVRCep9YSZ7e4OlZ2dI=
Date:   Mon, 16 Nov 2020 04:36:16 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bart Van Assche <bvanassche@acm.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Danit Goldberg <danitg@mellanox.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Divya Indi <divya.indi@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Moni Shoua <monis@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Xi Wang <wangxi11@huawei.com>,
        Yamin Friedman <yaminf@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: Re: [PATCH v4 07/27] IB: fix kernel-doc markups
Message-ID: <20201116103616.GA13162@embeddedor>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
 <4983a0c6fe5dbc2c779d2b5950a6f90f81a16d56.1605521731.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4983a0c6fe5dbc2c779d2b5950a6f90f81a16d56.1605521731.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 16, 2020 at 11:18:03AM +0100, Mauro Carvalho Chehab wrote:

[..]

> diff --git a/drivers/infiniband/sw/rdmavt/ah.c b/drivers/infiniband/sw/rdmavt/ah.c
> index f9754dcd250b..480b621d1a9f 100644
> --- a/drivers/infiniband/sw/rdmavt/ah.c
> +++ b/drivers/infiniband/sw/rdmavt/ah.c
[..]
>  /**
> - * rvt_destory_ah - Destory an address handle
> + * rvt_destroy_ah - Destory an address handle

s/Destory/Destroy

>   * @ibah: address handle
>   * @destroy_flags: destroy address handle flags (see enum rdma_destroy_ah_flags)
>   * Return: 0 on success
>   */
>  int rvt_destroy_ah(struct ib_ah *ibah, u32 destroy_flags)
>  {
>  	struct rvt_dev_info *dev = ib_to_rvt(ibah->device);
>  	struct rvt_ah *ah = ibah_to_rvtah(ibah);
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&dev->n_ahs_lock, flags);
>  	dev->n_ahs_allocated--;
>  	spin_unlock_irqrestore(&dev->n_ahs_lock, flags);
>  
>  	rdma_destroy_ah_attr(&ah->attr);
>  	return 0;
>  }

--
Gustavo
