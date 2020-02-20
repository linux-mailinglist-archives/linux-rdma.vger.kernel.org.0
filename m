Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D88165EDA
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 14:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgBTNci (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Feb 2020 08:32:38 -0500
Received: from mga05.intel.com ([192.55.52.43]:20515 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728066AbgBTNci (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Feb 2020 08:32:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 05:32:38 -0800
X-IronPort-AV: E=Sophos;i="5.70,464,1574150400"; 
   d="scan'208";a="229479690"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.204.151]) ([10.254.204.151])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Feb 2020 05:32:36 -0800
Subject: Re: [PATCH rdma-next 2/2] RDMA/opa_vnic: Delete driver version
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20200220071239.231800-1-leon@kernel.org>
 <20200220071239.231800-3-leon@kernel.org>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <a5b477e5-1c2b-055b-b617-76351b290adf@intel.com>
Date:   Thu, 20 Feb 2020 08:32:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220071239.231800-3-leon@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/20/2020 2:12 AM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> The default version provided by "ethtool -i" it the correct way
> to identify Driver version. There is no need to overwrite it.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>   drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c  | 2 --
>   drivers/infiniband/ulp/opa_vnic/opa_vnic_internal.h | 1 -
>   drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c     | 5 -----
>   3 files changed, 8 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c b/drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c
> index 8ad7da989a0e..42d557dff19d 100644
> --- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c
> +++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c
> @@ -125,8 +125,6 @@ static void vnic_get_drvinfo(struct net_device *netdev,
>   			     struct ethtool_drvinfo *drvinfo)
>   {
>   	strlcpy(drvinfo->driver, opa_vnic_driver_name, sizeof(drvinfo->driver));
> -	strlcpy(drvinfo->version, opa_vnic_driver_version,
> -		sizeof(drvinfo->version));
>   	strlcpy(drvinfo->bus_info, dev_name(netdev->dev.parent),
>   		sizeof(drvinfo->bus_info));
>   }

Is there a patch series to get rid of drvinfo->version? Seems to me if 
we don't want drivers to set it then we don't need it to begin with do we?

Regardless I don't have any objections to the patch. We've been down 
this road with version numbers and I believe this was added to vnic 
specifically to fill in something for ethtool.

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>

-Denny
