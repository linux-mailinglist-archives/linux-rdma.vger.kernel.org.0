Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3D5C0A32
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2019 19:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfI0RUD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Sep 2019 13:20:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfI0RUD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Sep 2019 13:20:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E556B8A1CA3;
        Fri, 27 Sep 2019 17:20:02 +0000 (UTC)
Received: from localhost (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 555055D9D5;
        Fri, 27 Sep 2019 17:20:02 +0000 (UTC)
Date:   Sat, 28 Sep 2019 01:20:00 +0800
From:   Honggang LI <honli@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [patch v4 2/2] RDMA/srp: calculate max_it_iu_size if remote
 max_it_iu length available
Message-ID: <20190927172000.GB13717@dhcp-128-227.nay.redhat.com>
References: <20190923062940.12330-1-honli@redhat.com>
 <20190923062940.12330-2-honli@redhat.com>
 <f18a4e69-f58d-a179-6fc0-ec15fee80957@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f18a4e69-f58d-a179-6fc0-ec15fee80957@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Fri, 27 Sep 2019 17:20:03 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 23, 2019 at 10:11:06AM -0700, Bart Van Assche wrote:
> On 9/22/19 11:29 PM, Honggang LI wrote:
> > diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> > index b829dab0df77..b3bf5d552de9 100644
> > --- a/drivers/infiniband/ulp/srp/ib_srp.c
> > +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> > @@ -139,7 +139,7 @@ MODULE_PARM_DESC(use_imm_data,
> >   static unsigned int srp_max_imm_data = 8 * 1024;
> >   module_param_named(max_imm_data, srp_max_imm_data, uint, 0644);
> > -MODULE_PARM_DESC(max_imm_data, "Maximum immediate data size.");
> > +MODULE_PARM_DESC(max_imm_data, "Maximum immediate data size if max_it_iu_size has not been specified.");
> >   static unsigned ch_count;
> >   module_param(ch_count, uint, 0444);
> > @@ -1362,15 +1362,23 @@ static void srp_terminate_io(struct srp_rport *rport)
> >   }
> >   /* Calculate maximum initiator to target information unit length. */
> > -static uint32_t srp_max_it_iu_len(int cmd_sg_cnt, bool use_imm_data)
> > +static uint32_t srp_max_it_iu_len(int cmd_sg_cnt, bool use_imm_data,
> > +				  uint32_t max_it_iu_size)
> >   {
> >   	uint32_t max_iu_len = sizeof(struct srp_cmd) + SRP_MAX_ADD_CDB_LEN +
> >   		sizeof(struct srp_indirect_buf) +
> >   		cmd_sg_cnt * sizeof(struct srp_direct_buf);
> > -	if (use_imm_data)
> > -		max_iu_len = max(max_iu_len, SRP_IMM_DATA_OFFSET +
> > -				 srp_max_imm_data);
> > +	if (use_imm_data) {
> > +		if (max_it_iu_size == 0) {
> > +			max_iu_len = max(max_iu_len,
> > +			   SRP_IMM_DATA_OFFSET + srp_max_imm_data);
> > +		} else {
> > +			max_iu_len = max_it_iu_size;
> > +		}
> > +	}
> > +
> > +	pr_debug("max_iu_len = %d\n", max_iu_len);
> >   	return max_iu_len;
> >   }
> 
> Thinking further about this, this removes the ability for users to limit
> immediate data to a certain number of bytes. I think that's a step back. How
> about not modifying the description of max_imm_data and to use the following
> approach in srp_max_it_iu_len() for calculating max_iu_len?

Sounds good. I will send new patch to address this.

thanks

> 
> uint32_t max_iu_len = sizeof(struct srp_cmd) + SRP_MAX_ADD_CDB_LEN +
> 		sizeof(struct srp_indirect_buf) +
> 		cmd_sg_cnt * sizeof(struct srp_direct_buf);
> if (use_imm_data)
> 	max_iu_len = max(max_iu_len, SRP_IMM_DATA_OFFSET +
> 			 srp_max_imm_data);
> if (max_it_iu_size)
> 	max_iu_len = min(max_iu_len, max_it_iu_size);
> 
> Thanks,
> 
> Bart.
