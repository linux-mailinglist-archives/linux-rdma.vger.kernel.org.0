Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41FE3A2C1A
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 14:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhFJM5Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 08:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230230AbhFJM5P (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Jun 2021 08:57:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5EB4613C1;
        Thu, 10 Jun 2021 12:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623329719;
        bh=jFiGQsr+d6m99FXk1PiNXPVKjr3i9BnzD5Q3oxfRdks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pAjLV10wHMFVajY1Q7jMSmNLCk0CIFQP1alQZzY2PzpwfdTxMZp5LqCrQBbNSingO
         1LnHYzYVPQ6UgRRR7ieU/LX7Dq/yrcP11+tstkLa+STnjgb8ATqRKcFfUglCTjJR6R
         SVbYrNYEuV1N4OLNzGfEAvLOoi6zXkXukwO0z/k1soADwtLG80ZJvgqg8MCIlUbiXu
         t1NWHadsq4iTgmulygW3t8HUH4ukU1D2bmamacl0nZyGOZvLQmmzxs8mNcX6rymgsY
         35YJ1El2n+3VNOvPbTHByg+D6/xnfRdkRhwSbVaFaIk9Eb8/Im5pfdVEfhGSfRxk2L
         QTePYNf7rTRQQ==
Date:   Thu, 10 Jun 2021 15:55:15 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     liweihang <liweihang@huawei.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "wangxi (M)" <wangxi11@huawei.com>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Clear extended doorbell info
 before using
Message-ID: <YMILs5uDMig7VMh0@unreal>
References: <1623323990-62343-1-git-send-email-liweihang@huawei.com>
 <YMH8GD2eoGLJugsS@unreal>
 <ec240826f2674a65b8de37bf3a7b18ec@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec240826f2674a65b8de37bf3a7b18ec@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 10, 2021 at 12:04:29PM +0000, liweihang wrote:
> On 2021/6/10 19:48, Leon Romanovsky wrote:
> > On Thu, Jun 10, 2021 at 07:19:50PM +0800, Weihang Li wrote:
> >> From: Xi Wang <wangxi11@huawei.com>
> >>
> >> Both of HIP08 and HIP09 require the extended doorbell information to be
> >> cleared before being used.
> >>
> >> Fixes: 6b63597d3540 ("RDMA/hns: Add TSQ link table support")
> >> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> >> Signed-off-by: Weihang Li <liweihang@huawei.com>
> >> ---
> >> Changes since v1:
> >> - Add fixes tag.
> >> - Add check for return value of hns_roce_clear_extdb_list_info().
> >> - Link: https://patchwork.kernel.org/project/linux-rdma/patch/1623237065-43344-1-git-send-email-liweihang@huawei.com/
> >>
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 21 +++++++++++++++++++++
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  1 +
> >>  2 files changed, 22 insertions(+)
> >>
> >> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >> index fbc45b9..d24ac5c 100644
> >> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >> @@ -1572,6 +1572,22 @@ static void hns_roce_function_clear(struct hns_roce_dev *hr_dev)
> >>  	}
> >>  }
> >>  
> >> +static int hns_roce_clear_extdb_list_info(struct hns_roce_dev *hr_dev)
> >> +{
> >> +	struct hns_roce_cmq_desc desc;
> >> +	int ret;
> >> +
> >> +	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_CLEAR_EXTDB_LIST_INFO,
> >> +				      false);
> >> +	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
> >> +	if (ret)
> >> +		ibdev_err(&hr_dev->ib_dev,
> >> +			  "failed to clear extended doorbell info, ret = %d.\n",
> >> +			  ret);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >>  static int hns_roce_query_fw_ver(struct hns_roce_dev *hr_dev)
> >>  {
> >>  	struct hns_roce_query_fw_info *resp;
> >> @@ -2684,6 +2700,11 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
> >>  	if (ret)
> >>  		return ret;
> >>  
> >> +	/* The hns ROCEE requires the extdb info to be cleared before using */
> >> +	ret = hns_roce_clear_extdb_list_info(hr_dev);
> >> +	if (ret)
> >> +		return ret;
> > 
> > You forgot to call to put_hem_table(hr_dev).
> > 
> > Thanks
> > 
> 
> Hi Leon,
> 
> This operation is to tell the firmware to clear the on-chip resources
> configuration before initialization, the HEM table is not involved.

Please check your hns_roce_v2_init() implementation.

You called to get_hem_table() 6 lines above, in case of error in
hns_roce_clear_extdb_list_info(), you need to return the hem_table back.

You did it in 4 lines below.

Thanks

> 
> Thanks
> Weihang
> 
> 
> >> +
> >>  	if (hr_dev->is_vf)
> >>  		return 0;
> >>  
> >> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> >> index cd361c0..073e835 100644
> >> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> >> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> >> @@ -250,6 +250,7 @@ enum hns_roce_opcode_type {
> >>  	HNS_ROCE_OPC_CLR_SCCC				= 0x8509,
> >>  	HNS_ROCE_OPC_QUERY_SCCC				= 0x850a,
> >>  	HNS_ROCE_OPC_RESET_SCCC				= 0x850b,
> >> +	HNS_ROCE_OPC_CLEAR_EXTDB_LIST_INFO		= 0x850d,
> >>  	HNS_ROCE_OPC_QUERY_VF_RES			= 0x850e,
> >>  	HNS_ROCE_OPC_CFG_GMV_TBL			= 0x850f,
> >>  	HNS_ROCE_OPC_CFG_GMV_BT				= 0x8510,
> >> -- 
> >> 2.7.4
> >>
> > 
> 
