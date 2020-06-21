Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E43620296E
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jun 2020 09:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbgFUHzh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Jun 2020 03:55:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729443AbgFUHzg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Jun 2020 03:55:36 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E8D32076E;
        Sun, 21 Jun 2020 07:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592726136;
        bh=1IMhqm3Nc53cjnEx6dx0GgDgPSa+AqRKPcTsxskOsEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k//iI1h8RK9bpzC5mWuPCOTd2aLTlmVfQL6O7LO7681tuGU9bSlBrzYu0feCJXMxh
         j3HlRrF3+kqC4UQmNY0QkXl8DYdW79+y5MNpWv1SNuRNwcr1hUJp6GGeOJVG5GqZl7
         SF3uazslgTV3902Nu2rjLcARCPk+5tO+6amPrFHI=
Date:   Sun, 21 Jun 2020 10:55:32 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 08/11] RDMA: Add support to dump resource
 tracker in RAW format
Message-ID: <20200621075532.GB6698@unreal>
References: <20200616104006.2425549-1-leon@kernel.org>
 <20200616104006.2425549-9-leon@kernel.org>
 <20200618232009.GA2487227@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618232009.GA2487227@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 18, 2020 at 08:20:09PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 16, 2020 at 01:40:03PM +0300, Leon Romanovsky wrote:
>
> > +static int fill_res_qp_entry(struct sk_buff *msg, bool has_cap_net_admin,
> > +			     struct rdma_restrack_entry *res, uint32_t port,
> > +			     bool raw)
> > +{
> > +	struct ib_qp *qp = container_of(res, struct ib_qp, res);
> > +	struct ib_device *dev = qp->device;
> > +	int ret;
> > +
> > +	if (port && port != qp->port)
> > +		return -EAGAIN;
> > +
> > +	/* In create_qp() port is not set yet */
> > +	if (qp->port && nla_put_u32(msg, RDMA_NLDEV_ATTR_PORT_INDEX, qp->port))
> > +		return -EINVAL;
> > +
> > +	ret = nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_LQPN, qp->qp_num);
> > +	if (ret)
> > +		goto err;
> > +
> >  	if (!rdma_is_kernel_res(res) &&
> >  	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PDN, qp->pd->res.id))
> >  		goto err;
> >
> > -	if (fill_res_name_pid(msg, res))
> > +	ret = fill_res_name_pid(msg, res);
> > +	if (ret)
> >  		goto err;
> >
> > -	if (dev->ops.fill_res_qp_entry)
> > -		return dev->ops.fill_res_qp_entry(msg, qp);
> > -	return 0;
> > +	if (!raw)
> > +		return fill_res_qp_entry_query(msg, res, dev, qp);
>
> Are you sure the RAW query should duplicate all the stuff the normal
> query does? Shouldn't the raw query return only the raw blob?
>
> The rest seems fine, but this is rather odd?


RAW duplicates only fields that are not known to FW, like PID, name
for process identification and port_index, device_index, LQPN for entry
identification. The only one in question is PDN, but it helps to
understand relation between PD and QP, so I would like to keep it.
>
> > @@ -1252,9 +1291,11 @@ static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
> >  		goto err_get;
> >  	}
> >
> > -	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
> > -			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, fe->nldev_cmd),
> > -			0, 0);
> > +	nlh = nlmsg_put(
> > +		msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
> > +		RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
> > +				 (raw ? fe->nldev_cmd_raw : fe->nldev_cmd)),
> > +		0, 0);
>
> Isn't this ternary just RMDA_NL_GET_OP(nlh->nlmsg_type) ?

I don't know for sure, let me check it later and send a followup patch if needed.

>
> and I suppose RDMA_NL_GET_TYPE should be named MAKE_TYPE?

RDMA_NL_GET_TYPE came from UAPI header file and renaming this define won't gain us a lot.

Thanks

>
> Jason
