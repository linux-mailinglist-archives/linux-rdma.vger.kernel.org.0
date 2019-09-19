Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95E09B71EF
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2019 05:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbfISDgi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Sep 2019 23:36:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbfISDgi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Sep 2019 23:36:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C3BFD307CDD1;
        Thu, 19 Sep 2019 03:36:37 +0000 (UTC)
Received: from localhost (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EC5F600CC;
        Thu, 19 Sep 2019 03:36:36 +0000 (UTC)
Date:   Thu, 19 Sep 2019 11:36:35 +0800
From:   Honggang LI <honli@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [patch v2 2/2] RDMA/SRP: calculate max_it_iu_size if remote
 max_it_iu length available
Message-ID: <20190919033635.GB6303@dhcp-128-227.nay.redhat.com>
References: <20190917032421.13000-1-honli@redhat.com>
 <20190917032421.13000-2-honli@redhat.com>
 <ba8ed403-b74e-dc6a-2c47-d4dc6f81fbdd@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba8ed403-b74e-dc6a-2c47-d4dc6f81fbdd@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 19 Sep 2019 03:36:37 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 17, 2019 at 10:40:00AM -0700, Bart Van Assche wrote:
> On 9/16/19 8:24 PM, Honggang LI wrote:
> > diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> > index 2eadb038b257..d8dee5900c08 100644
> > --- a/drivers/infiniband/ulp/srp/ib_srp.c
> > +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> > @@ -76,6 +76,7 @@ static bool register_always = true;
> >   static bool never_register;
> >   static int topspin_workarounds = 1;
> >   static uint32_t srp_opt_max_it_iu_size;
> > +static unsigned int srp_max_imm_data;
> 
> Each SCSI host can represent a connection to another SRP target, and the
> max_it_iu_size parameter can differ per target. So I think this variable
> should be moved into struct srp_target_port instead of being global.

Yes, will do as you said.

> 
> >   module_param(srp_sg_tablesize, uint, 0444);
> >   MODULE_PARM_DESC(srp_sg_tablesize, "Deprecated name for cmd_sg_entries");
> > @@ -138,9 +139,9 @@ module_param_named(use_imm_data, srp_use_imm_data, bool, 0644);
> >   MODULE_PARM_DESC(use_imm_data,
> >   		 "Whether or not to request permission to use immediate data during SRP login.");
> > -static unsigned int srp_max_imm_data = 8 * 1024;
> > -module_param_named(max_imm_data, srp_max_imm_data, uint, 0644);
> > -MODULE_PARM_DESC(max_imm_data, "Maximum immediate data size.");
> > +static unsigned int srp_default_max_imm_data = 8 * 1024;
> > +module_param_named(max_imm_data, srp_default_max_imm_data, uint, 0644);
> > +MODULE_PARM_DESC(max_imm_data, "Default maximum immediate data size.");
> 
> This description might confuse users. How about keeping the name of the
> variable and the module parameter and changing its description into the

Yes, will keep the name of the variable and the module parameter.

> following?
> 
> "Maximum immediate data size if max_it_iu_size has not been specified."

Yes, will use this description.

> 
> >   static unsigned ch_count;
> >   module_param(ch_count, uint, 0444);
> > @@ -1369,9 +1370,19 @@ static uint32_t srp_max_it_iu_len(int cmd_sg_cnt, bool use_imm_data)
> >   		sizeof(struct srp_indirect_buf) +
> >   		cmd_sg_cnt * sizeof(struct srp_direct_buf);
> > -	if (use_imm_data)
> > -		max_iu_len = max(max_iu_len, SRP_IMM_DATA_OFFSET +
> > -				 srp_max_imm_data);
> > +	if (use_imm_data) {
> > +		if (srp_opt_max_it_iu_size == 0) {
> > +			srp_max_imm_data = srp_default_max_imm_data;
> > +			max_iu_len = max(max_iu_len,
> > +			   SRP_IMM_DATA_OFFSET + srp_max_imm_data);
> > +		} else {
> > +			srp_max_imm_data =
> > +			   srp_opt_max_it_iu_size - SRP_IMM_DATA_OFFSET;
> 
> Please use as much of a line as possible. I think the recommended style in
> the Linux kernel is as follows:
> 
> 			srp_max_imm_data = srp_opt_max_it_iu_size -
> 				SRP_IMM_DATA_OFFSET;

The new patch no longer needs this. So, it will not be a problem.

> 
> > @@ -3829,6 +3840,8 @@ static ssize_t srp_create_target(struct device *dev,
> >   	if (ret < 0)
> >   		goto put;
> > +	srp_opt_max_it_iu_size = 0;
> > +
> 
> Static variables that are not initialized explicitly are initialized to
> zero. Since this initialization is redundant, please remove it.

The initialization is not redundant. For example, a srp client connect
to target-1 with 'max_it_iu=1234', and then try to connect target-2
without 'max_it_iu'. At this time srp_opt_max_it_iu_size has garbage
value 1234. That is why we have to initialize it for echo login.

Because srp_opt_max_it_iu_size will be removed in new patch, it
will not be a problem.

thanks
