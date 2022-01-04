Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8CB484889
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 20:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiADT0p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 14:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiADT0p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jan 2022 14:26:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10808C061761
        for <linux-rdma@vger.kernel.org>; Tue,  4 Jan 2022 11:26:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 81D9FCE1A40
        for <linux-rdma@vger.kernel.org>; Tue,  4 Jan 2022 19:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2A4C36AEB;
        Tue,  4 Jan 2022 19:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641324401;
        bh=2Y3kMW0xD2eUwLeeed3tkePn9ReEAoO8mbwkO6ZF9tM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SLQXW0Qpk90HcYZyzqcKFm9bZDiCLxYl+JyjhwSwX4PJ4btUo5nkPWqG4sBiB3q8i
         iJCD2qlMASTrDcUCI7x4pUw65IPsI9EvEAjIm+qLKSg8mgIttycvzSWCAUZtkmkX/C
         7l5wxpqZcJLNXSzlN6GNgHz2edpzRyaF+ajxFLN3wioBqhkCZPauljxpEPMpRO/nsK
         X6k3sLS04RJs5jwZz+bwtIXVVdpiO5RkyM+ksAL/SBKzrzf1k3aHznp/G2Sv8VyI/8
         BcGBcKu4p1DY+EF3G/De4yoLgLyWjgRF0NBocccDWgGeg7ERH4cW/KkpRRmIzzwLl3
         HNHcJvrZapvNA==
Date:   Tue, 4 Jan 2022 21:26:36 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "liweihang@huawei.com" <liweihang@huawei.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 3/4] RDMA/irdma: Make the source udp port vary
Message-ID: <YdSfbB0O26l/47os@unreal>
References: <20220105080727.2143737-1-yanjun.zhu@linux.dev>
 <20220105080727.2143737-4-yanjun.zhu@linux.dev>
 <1f6f5d2c6c3c422caa69d65e89f30d99@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f6f5d2c6c3c422caa69d65e89f30d99@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 04, 2022 at 05:18:01PM +0000, Saleem, Shiraz wrote:
> > Subject: [PATCH 3/4] RDMA/irdma: Make the source udp port vary
> > 
> > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > 
> > Get the source udp port number for a QP based on the grh.flow_label or
> > lqpn/rqrpn. This provides a better spread of traffic across NIC RX queues.
> > 
> > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > ---
> >  drivers/infiniband/hw/irdma/verbs.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> > index 8cd5f9261692..09dba7ed5ab9 100644
> > --- a/drivers/infiniband/hw/irdma/verbs.c
> > +++ b/drivers/infiniband/hw/irdma/verbs.c
> > @@ -1167,6 +1167,11 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct
> > ib_qp_attr *attr,
> > 
> >  		memset(&iwqp->roce_ah, 0, sizeof(iwqp->roce_ah));
> >  		if (attr->ah_attr.ah_flags & IB_AH_GRH) {
> > +			u32 fl = attr->ah_attr.grh.flow_label;
> > +			u32 lqp = ibqp->qp_num;
> > +			u32 rqp = roce_info->dest_qp;
> > +
> > +	
> Do you really need these locals?

I asked same question in previous revision.

Zhu, please remove them.

Thanks
