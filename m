Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C892B072A
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 15:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgKLOAP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 09:00:15 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8028 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgKLOAO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Nov 2020 09:00:14 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fad3fe70001>; Thu, 12 Nov 2020 06:00:07 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 14:00:13 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.54) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 12 Nov 2020 14:00:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXoNSUOyQwu1gw1gFK+lactcQNsO1xouYYYUDjJTJEQDfjgF6T0hC93VHQjuqj1d5tIm30AZyVMuGpLiLKPZr92NcILGA2UbiC/lmwZEAeFLvJ1vNsVsTY3nTA5kA8RX2BRH4Q1CFKbiVn8xp1hOxYDDOQ6RQ949iFyCIjcVoM7t/aUfTl7IcvnsoDDC2Nvl3AVjkkoOtzmT44hYAWrLPS0NcuFtmhKl5xFDjS3kXfEUfRSqfaTMQQ8x2ZcIqznIV32sKWL9AY+zFiu9EH7aOMx+6NmHt45/JkNIbJbSZHAuQwkOyygYlMdoQFOhXYaya/pbeiEOvIKMTbNlX8IWCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5ld2P8FjeJ3lDQVeg+hz7VV3iYclI7d9iTcL3e1z1c=;
 b=XFap6zku1s8cV80jU4C7OL6GNLKiVMAbawhoFfb2fbFuufz/mloCFsF4n9jOMwtfsr6q/6luU84xUxGtXfh4uCxuixhI1IJiExp2qqYR9Ss7xVKEdhsrE5cZTo3odGklB+4y1I3DLS/Z0b8jnTCaHmR5xlhaUaUbIkW/HfepXa9w0Wb8EUTECnJt/xMdbmX4q5U2VAx8X+xY8lDzZbuN6GssoJ7JTjfIVj2e72p2eqkFth3apM5cpBHEiXQYCHsigXNQmOhcCXh1MngtvxwzIIreuBZCstRpqS3sDNjDUhhQMa9fYMVBA5fsm/2t9Ja/DSCGAcdCm8nKOxHYtd0oaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4842.namprd12.prod.outlook.com (2603:10b6:5:1fe::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Thu, 12 Nov
 2020 14:00:11 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 12 Nov 2020
 14:00:11 +0000
Date:   Thu, 12 Nov 2020 10:00:10 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH 2/4] Provider/rxe: Implement ibv_query_device_ex verb
Message-ID: <20201112140010.GG2620339@nvidia.com>
References: <20201106230122.17411-1-rpearson@hpe.com>
 <20201106230122.17411-3-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201106230122.17411-3-rpearson@hpe.com>
X-ClientProxiedBy: BL0PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:208:2d::41) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:208:2d::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 12 Nov 2020 14:00:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kdD90-003gzK-3R; Thu, 12 Nov 2020 10:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605189607; bh=E5ld2P8FjeJ3lDQVeg+hz7VV3iYclI7d9iTcL3e1z1c=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Ksda13q616T/uFjOYGS5tJv9jXP41mRhPuYBtMM09byZoMJ6uXNMT0ZhkqWRkoKe0
         AWuceehoBX6IupcRXCVod4huV+UQnZkHuQeRqNvbNCBUFqVgm+ihLNTs37qx7V6PxQ
         Y6iA7yl/N0rId8nCYfN7wF8VUg7S/su7kP7KU2PO4+xncY0DKOb5Vxpd8e48LCO5bB
         XsaiHEAAarGb3PBg5PNOZrHRacvRxlNTdg3ORJN+MvND3G4SIFJin2kNaZIEhzkrCX
         rv2ILWLSjWPUwuu0VDsEg83NolJn7VSE6vb923cSnEF0awwM7eNmf7DZAkHyDcGmCg
         7eRVv4PrcYRLQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 06, 2020 at 05:01:20PM -0600, Bob Pearson wrote:
> Implement ibv_query_device_ex verb. Make it depend on a RXE_CAP_CMD_EX
> capability bit supported by both provider and driver.
> 
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>  kernel-headers/rdma/rdma_user_rxe.h |  1 +
>  providers/rxe/rxe.c                 | 35 +++++++++++++++++++++++++++++
>  providers/rxe/rxe.h                 |  2 +-
>  3 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma_user_rxe.h
> index 70ac031e..a31465e2 100644
> +++ b/kernel-headers/rdma/rdma_user_rxe.h
> @@ -160,6 +160,7 @@ struct rxe_recv_wqe {
>  
>  enum rxe_capabilities {
>  	RXE_CAP_NONE		= 0,
> +	RXE_CAP_CMD_EX		= 1ULL << 0,
>  };

All the kernel-headers/ changes need to be in one patch at the start,
the kernel-headers/update script will make the required commit.

Keeping this 100% in sync with the kernel is important

>  struct rxe_alloc_context_cmd {
> diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
> index c29b7de5..b1fa2f42 100644
> +++ b/providers/rxe/rxe.c
> @@ -87,6 +87,34 @@ static int rxe_query_device(struct ibv_context *context,
>  	return 0;
>  }
>  
> +static int rxe_query_device_ex(struct ibv_context *context,
> +			       const struct ibv_query_device_ex_input *input,
> +			       struct ibv_device_attr_ex *attr,
> +			       size_t attr_size)
> +{
> +	int ret;
> +	uint64_t raw_fw_ver;
> +	unsigned int major, minor, sub_minor;
> +	struct ibv_query_device_ex cmd = {};
> +	struct ib_uverbs_ex_query_device_resp resp = {};
> +
> +	fprintf(stderr, "%s: called\n", __func__);

Don't send debugging prints in patches

> +	ret = ibv_cmd_query_device_ex(context, input, attr, sizeof(*attr),
> +				      &raw_fw_ver, &cmd, sizeof(cmd),
> +				      &resp, sizeof(resp));
> +	if (ret)
> +		return ret;
> +
> +	major = (raw_fw_ver >> 32) & 0xffff;
> +	minor = (raw_fw_ver >> 16) & 0xffff;
> +	sub_minor = raw_fw_ver & 0xffff;
> +
> +	snprintf(attr->orig_attr.fw_ver, sizeof(attr->orig_attr.fw_ver),
> +		 "%d.%d.%d", major, minor, sub_minor);
> +
> +	return 0;
> +}
> +
>  static int rxe_query_port(struct ibv_context *context, uint8_t port,
>  			  struct ibv_port_attr *attr)
>  {
> @@ -860,6 +888,10 @@ static const struct verbs_context_ops rxe_ctx_ops = {
>  	.free_context = rxe_free_context,
>  };
>  
> +static const struct verbs_context_ops rxe_ctx_ops_cmd_ex = {
> +	.query_device_ex = rxe_query_device_ex,
> +};
> +
>  static struct verbs_context *rxe_alloc_context(struct ibv_device *ibdev,
>  					       int cmd_fd,
>  					       void *private_data)
> @@ -883,6 +915,9 @@ static struct verbs_context *rxe_alloc_context(struct ibv_device *ibdev,
>  
>  	verbs_set_ops(&context->ibv_ctx, &rxe_ctx_ops);
>  
> +	if (context->capabilities & RXE_CAP_CMD_EX)
> +		verbs_set_ops(&context->ibv_ctx, &rxe_ctx_ops_cmd_ex);

This isn't needed, we know if ibv_cmd_query_device_ex() is not
supported because the kernel returns -EOPNOTSUP when we call it.

What is needed is to just call the fallback like dummy ops does:

if (ret == -EOPNOTSUPP) {
        if (input && input->comp_mask)
                return EINVAL;

        if (attr_size < sizeof(attr->orig_attr))
                return EOPNOTSUPP;

        memset(attr, 0, attr_size);

        return ibv_query_device(context, &attr->orig_attr);
}

And I wonder if we should make ibv_cmd_query_device_ex() just do this?
This whole thing is a mess now that the kernel always supports
ibv_cmd_query_device_ex() on all drivers.

I don't have time to fix it all properly, so I suggest you just use
the above fragment for now instead of the RXE_CAP_CMD_EX

Jason
