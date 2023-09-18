Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F627A478E
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 12:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjIRKun (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 06:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241232AbjIRKuV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 06:50:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B381AD;
        Mon, 18 Sep 2023 03:49:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8891BC433C8;
        Mon, 18 Sep 2023 10:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695034182;
        bh=omo90vbvxu9QZeYX3a8b8+CNEeUkpugaGhRbaHCeEXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z1bCkFvlusnmPxZevHaIZtLiKEome6S8kM4zv3NxRgOlDve22ZBtp24/xi4dhRjcl
         M/vR3jCvbo5htzp1FZ6Wn6rbTKybliUmiMkVMyREJk7z5dPh43hWt4AbEiz2xmnTOW
         nvlsMz1OfygnA/tBqGzDEoqWMAB01qjY8eK00F5d883NScpoFFgNqgbWxuuxIuoDVW
         xDPJ+rBrf3z5J2MIkcmYYYq4kvtUfKQiYQhGwv9wSBw5PnqaWkrCboPA04TbefGCY4
         E5WLZciSchHgX76DEMN75L0agdixnFEaDyQ5VnDPmoYgp8v0kcWdaxJVQPdAuLU7Ds
         bw1NfRnnoggxg==
Date:   Mon, 18 Sep 2023 13:49:38 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] RDMA/core: Use size_{add,mul}() in calls to
 struct_size()
Message-ID: <20230918104938.GD13757@unreal>
References: <ZP+if342EMhModzZ@work>
 <202309142029.D432EEB8C@keescook>
 <2594c7ff-0301-90aa-d48c-6b4d674f850e@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2594c7ff-0301-90aa-d48c-6b4d674f850e@embeddedor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 15, 2023 at 12:06:21PM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 9/14/23 21:29, Kees Cook wrote:
> > On Mon, Sep 11, 2023 at 05:27:59PM -0600, Gustavo A. R. Silva wrote:
> > > Harden calls to struct_size() with size_add() and size_mul().
> > 
> > Specifically, make sure that open-coded arithmetic cannot cause an
> > overflow/wraparound. (i.e. it will stay saturated at SIZE_MAX.)
> 
> Yep; I have another patch where I explain this in similar terms.
> 
> I'll send it, shortly.

You missed other places with similar arithmetic.
drivers/infiniband/core/device.c:       pdata_rcu = kzalloc(struct_size(pdata_rcu, pdata,
drivers/infiniband/core/device.c-                                       rdma_end_port(device) + 1),
drivers/infiniband/core/device.c-                           GFP_KERNEL);

drivers/infiniband/core/sa_query.c:     sa_dev = kzalloc(struct_size(sa_dev, port, e - s + 1), GFP_KERNEL);
drivers/infiniband/core/user_mad.c:     umad_dev = kzalloc(struct_size(umad_dev, ports, e - s + 1), GFP_KERNEL);

Thanks

> 
> > 
> > > 
> > > Fixes: 467f432a521a ("RDMA/core: Split port and device counter sysfs attributes")
> > > Fixes: a4676388e2e2 ("RDMA/core: Simplify how the gid_attrs sysfs is created")
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Thanks!
> 
> --
> Gustavo
> 
> > 
> > -Kees
> > 
> > > ---
> > > Changes in v2:
> > >   - Update changelog text: remove the part about binary differences (it
> > >     was added by mistake).
> > > 
> > >   drivers/infiniband/core/sysfs.c | 10 +++++-----
> > >   1 file changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
> > > index ee59d7391568..ec5efdc16660 100644
> > > --- a/drivers/infiniband/core/sysfs.c
> > > +++ b/drivers/infiniband/core/sysfs.c
> > > @@ -903,7 +903,7 @@ alloc_hw_stats_device(struct ib_device *ibdev)
> > >   	 * Two extra attribue elements here, one for the lifespan entry and
> > >   	 * one to NULL terminate the list for the sysfs core code
> > >   	 */
> > > -	data = kzalloc(struct_size(data, attrs, stats->num_counters + 1),
> > > +	data = kzalloc(struct_size(data, attrs, size_add(stats->num_counters, 1)),
> > >   		       GFP_KERNEL);
> > >   	if (!data)
> > >   		goto err_free_stats;
> > > @@ -1009,7 +1009,7 @@ alloc_hw_stats_port(struct ib_port *port, struct attribute_group *group)
> > >   	 * Two extra attribue elements here, one for the lifespan entry and
> > >   	 * one to NULL terminate the list for the sysfs core code
> > >   	 */
> > > -	data = kzalloc(struct_size(data, attrs, stats->num_counters + 1),
> > > +	data = kzalloc(struct_size(data, attrs, size_add(stats->num_counters, 1)),
> > >   		       GFP_KERNEL);
> > >   	if (!data)
> > >   		goto err_free_stats;
> > > @@ -1140,7 +1140,7 @@ static int setup_gid_attrs(struct ib_port *port,
> > >   	int ret;
> > >   	gid_attr_group = kzalloc(struct_size(gid_attr_group, attrs_list,
> > > -					     attr->gid_tbl_len * 2),
> > > +					     size_mul(attr->gid_tbl_len, 2)),
> > >   				 GFP_KERNEL);
> > >   	if (!gid_attr_group)
> > >   		return -ENOMEM;
> > > @@ -1205,8 +1205,8 @@ static struct ib_port *setup_port(struct ib_core_device *coredev, int port_num,
> > >   	int ret;
> > >   	p = kvzalloc(struct_size(p, attrs_list,
> > > -				attr->gid_tbl_len + attr->pkey_tbl_len),
> > > -		    GFP_KERNEL);
> > > +				size_add(attr->gid_tbl_len, attr->pkey_tbl_len)),
> > > +		     GFP_KERNEL);
> > >   	if (!p)
> > >   		return ERR_PTR(-ENOMEM);
> > >   	p->ibdev = device;
> > > -- 
> > > 2.34.1
> > > 
> > 
