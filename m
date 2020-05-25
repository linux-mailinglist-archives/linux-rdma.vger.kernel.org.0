Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EB71E128B
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 18:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbgEYQVv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 12:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729338AbgEYQVu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 May 2020 12:21:50 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C47D920776;
        Mon, 25 May 2020 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590423710;
        bh=OAnN4GcDnOU/gdPbA341pRCct1B8xy/Kr63aibsALho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MaSiWesINesUIrV4SFtCEhPVC7yMIA96vEO1JcEQpVVKycScnkdWer22j5Sf5AWfP
         lFNo6Io9oqvmvoO3lWsJ9OP52zJUnfpRfIJYL1TGVqQYpCoUktY5r4KyaxRVGhnTWd
         BR56vh5vHxu2YVouMBfPwk0aSjVb7XhTZAWIIBIs=
Date:   Mon, 25 May 2020 19:21:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>
Subject: Re: [PATCH rdma-next 11/14] RDMA: Add support to dump resource
 tracker in RAW format
Message-ID: <20200525162145.GB10591@unreal>
References: <20200513095034.208385-1-leon@kernel.org>
 <20200513095034.208385-12-leon@kernel.org>
 <20200525144136.GA21858@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525144136.GA21858@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 25, 2020 at 11:41:36AM -0300, Jason Gunthorpe wrote:
> On Wed, May 13, 2020 at 12:50:31PM +0300, Leon Romanovsky wrote:
> > From: Maor Gottlieb <maorg@mellanox.com>
> >
> > Add support to get resource dump in raw format. It enable vendors
> > to return the entire QP/CQ/MR context without a need from the vendor
> > to set each field separately.
> > When user request to get the data in RAW, we return as key value
> > the generic fields which not require to query the vendor and in addition
> > we return the rest of the data as binary.
> >
> > Example:
> >
> > $rdma res show mr dev mlx5_1 mrn 2 -r -j
> > [{"ifindex":7,"ifname":"mlx5_1","mrn":2,"mrlen":4096,"pdn":5,
> > pid":24336, "comm":"ibv_rc_pingpong",
> > "data":[0,4,255,254,0,0,0,0,0,0,0,0,16,28,0,216,...]}]
>
> That is pretty gross, why not bas64 encode it or something?

We are talking about rdmatool output, right? It can.

>
> >  static int fill_res_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
> > -			     struct rdma_restrack_entry *res, uint32_t port)
> > +			     struct rdma_restrack_entry *res, uint32_t port,
> > +			     bool raw)
> >  {
>
> Should it be a flag not a bool?

I assume that once this RAW series will be merged, the MR res dump will
be close to feature complete.

Thank

>
> Jason
