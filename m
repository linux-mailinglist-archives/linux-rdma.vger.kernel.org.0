Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA98152994
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2020 12:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBELBh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Feb 2020 06:01:37 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:26963 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgBELBg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Feb 2020 06:01:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1580900496; x=1612436496;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0nR57jj7ZxzEJ6vmfDYzwy37BPnHTuGk6TzvkW4aDa4=;
  b=Z/DgT2OJ97YSh3pyyYlfhro0xD3R+AVwedgBWYAreaSGaePRxQ+7JmX4
   7OzEQPVoy/KAcpb7SnRZn3EiCLAtdJnw80zJoHr140vgxeEPqwpMy0lui
   KCaD2u8vsYCNDC2iGmBZast9gFugxqB+Sjc3Ue82sOkttnXtHMc3tvqFD
   o=;
IronPort-SDR: VoDBFdMi/NNsULERajaX+G7MEyukLoCfyBbix7+X1gvQV8B8/D+DOXpXlpiTMJCNC/5mavqXrw
 OONwWdNmGywA==
X-IronPort-AV: E=Sophos;i="5.70,405,1574121600"; 
   d="scan'208";a="23179937"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 05 Feb 2020 11:01:19 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (Postfix) with ESMTPS id 2FEF5A1CF6;
        Wed,  5 Feb 2020 11:01:19 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 5 Feb 2020 11:01:18 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.203) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 5 Feb 2020 11:01:15 +0000
Subject: Re: [PATCH for-rc] RDMA/siw: Fix setting active_mtu attribute
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        Bernard Metzler <bmt@zurich.ibm.com>
References: <20200205081354.30438-1-kamalheib1@gmail.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <68c6b5f3-05e9-2662-5247-6bc23d3a93df@amazon.com>
Date:   Wed, 5 Feb 2020 13:01:10 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205081354.30438-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.203]
X-ClientProxiedBy: EX13D33UWB003.ant.amazon.com (10.43.161.92) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 05/02/2020 10:13, Kamal Heib wrote:
> Make sure to set the active_mtu attribute to avoid report the following
> invalid value:
> 
> $ ibv_devinfo -d siw0 | grep active_mtu
> 			active_mtu:		invalid MTU (0)
> 
> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/sw/siw/siw_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
> index 07e30138aaa1..73485d0da907 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> @@ -168,12 +168,12 @@ int siw_query_port(struct ib_device *base_dev, u8 port,
>  
>  	memset(attr, 0, sizeof(*attr));
>  
> -	attr->active_mtu = attr->max_mtu;
>  	attr->active_speed = 2;
>  	attr->active_width = 2;

Off topic: these should use ib_port_speed and ib_port_width enum.

>  	attr->gid_tbl_len = 1;
>  	attr->max_msg_sz = -1;
>  	attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
> +	attr->active_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
>  	attr->phys_state = sdev->state == IB_PORT_ACTIVE ?
>  		IB_PORT_PHYS_STATE_LINK_UP : IB_PORT_PHYS_STATE_DISABLED;
>  	attr->pkey_tbl_len = 1;
> 

Reviewed-by: Gal Pressman <galpress@amazon.com>
