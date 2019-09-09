Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFE9AD642
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 12:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfIIKBa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 06:01:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfIIKBa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Sep 2019 06:01:30 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9027921920;
        Mon,  9 Sep 2019 10:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568023290;
        bh=tzfwMOVnbNBV7y6Fl+E8cV1pNSVWhpb3An0wMo3RggA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1CS7CQDHSCwVr7VbBMIRU1KNr+8gKfoxiROkJbLeKmNc4oFWHrnHlEm63W26Rjynr
         45W89+NUFItvmYr0UCex3VkTtV0zW8cnUL1qlM47g20qBNEmIdk0EsCnIIDaAH1jsZ
         HvhlezolfEJsG8ecM629/r1z1Eo84yic4i0XuDr8=
Date:   Mon, 9 Sep 2019 13:01:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: Re: [PATCH rdma-next v1 4/4] RDMA/mlx5: Return ODP type per MR
Message-ID: <20190909100126.GD6601@unreal>
References: <20190830081612.2611-1-leon@kernel.org>
 <20190830081612.2611-5-leon@kernel.org>
 <20190909085355.GE2843@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909085355.GE2843@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 09, 2019 at 08:53:57AM +0000, Jason Gunthorpe wrote:
> On Fri, Aug 30, 2019 at 11:16:12AM +0300, Leon Romanovsky wrote:
>
> > +static int fill_res_mr_entry(struct sk_buff *msg,
> > +			     struct rdma_restrack_entry *res)
> > +{
> > +	struct ib_mr *ibmr = container_of(res, struct ib_mr, res);
> > +	struct mlx5_ib_mr *mr = to_mmr(ibmr);
> > +	struct nlattr *table_attr;
> > +
> > +	if (!is_odp_mr(mr))
> > +		return 0;
> > +
> > +	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_DRIVER);
> > +	if (!table_attr)
> > +		goto err;
> > +
> > +	if (to_ib_umem_odp(mr->umem)->is_implicit_odp) {
> > +		if (rdma_nl_put_driver_string(msg, "odp", "implicit"))
> > +			goto err;
> > +	} else {
> > +		if (rdma_nl_put_driver_string(msg, "odp", "explicit"))
> > +			goto err;
> > +	}
> > +
> > +	nla_nest_end(msg, table_attr);
> > +	return 0;
> > +
> > +err:
> > +	nla_nest_cancel(msg, table_attr);
> > +	return -EMSGSIZE;
> > +}
>
> If we are having a custom fill function why not fill the ODP stats
> here instead of adding that callback and memcopies/etc

It makes sense.

Thanks

>
> rdma_nl_put_odp_stats(...)
>
> Jason
