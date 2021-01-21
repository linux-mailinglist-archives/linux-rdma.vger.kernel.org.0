Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE012FF270
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 18:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbhAURvc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 12:51:32 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2514 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388079AbhAURv2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 12:51:28 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6009bef20001>; Thu, 21 Jan 2021 09:50:42 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Jan
 2021 17:50:42 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Jan
 2021 17:50:37 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 21 Jan 2021 17:50:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYR7l1hHd3dpjUa0nVORK5Z5Voy+aX3kijK+81P96BrMfqvjzDP+z8zhK5HGa9BuFegktZD2MFlYbPpdZZhZWKf6zE2sffzZpKGMuYQNBE+PirFSgTP1mYGVCDZkJRBlxrfbe9H5v1dbB7Wt1U3vYRxnOAXrjdZfMn2BKp2wceLqUDZ3qTNncE7iehYMxgxz8zm+J1L1pX2fQ+g81SKCi3pDj60jKj3iesnXaPIl9chw2OfbN4w+rGqalbwZlvTB3yYJy9iEDWyYvdbfCd56eJXDe+PIEY+8hsU9RzEqRWUP4UqUFPzcCNHUTIcpT7ComaJ1Qkh3vLUJgXAdwwmjSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVY2g1BnDJL36ksOKbP/qph9Y6l+z+y8d9PJgSkDE0A=;
 b=L6o1YWm/aqixHO3o8no1nJXjrtgZsDzAR+iy2LpfdD9rVsTRzi1YjU1Z0eZpUK9GLpHOUafNcI64EIzYpzdP44v12EgzdalO+omDu/9LcZhuTjWwGmxul2cLlQk88LMRU5xiMNISm48dcM4+kxFnMxfySMS7wrvGwLUJlrNQYIeHCqSHZWrR77Znz2AB6jXcIEkkyKldlofZmH/EqHWK6w8bc8jMHwP7bKr6rwt2FhuABGoPJW+tRptTUi10tqfwDxEZQIN5HBSrgh7qSWartZNnew59aqmXCdGAcS4NVBsFtuFLe0s16t2F+Hn3eiQ0AeiqnEnXJ4kHQpi0oaJdhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Thu, 21 Jan
 2021 17:50:35 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.011; Thu, 21 Jan 2021
 17:50:35 +0000
Date:   Thu, 21 Jan 2021 13:50:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Add caps flag for UD inline of
 userspace
Message-ID: <20210121175033.GA1221624@nvidia.com>
References: <1609836423-40069-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1609836423-40069-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL1PR13CA0215.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::10) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by BL1PR13CA0215.namprd13.prod.outlook.com (2603:10b6:208:2bf::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.7 via Frontend Transport; Thu, 21 Jan 2021 17:50:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l2e6L-0057uJ-4t; Thu, 21 Jan 2021 13:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611251442; bh=AVY2g1BnDJL36ksOKbP/qph9Y6l+z+y8d9PJgSkDE0A=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Ybckea6vKEIk5AY/19jOICfH2kRiJwGByGAXAqSBxiJePMUDDPfQ/x0LV36rSMv6I
         QOiCLorU92BzM4LRLg3IKbWAPACBdlz/qKarAvgsWCF+Yz0VbRXiVCyb/mueYr+jBH
         xuHo0+rXS+DjAKFgL61d83ZJA5RIiFyC0MKLWHjXjrmZ1pFZ7VzmQC3uwEXRziVE8t
         1uUUt405+6FwDGmlNVHsBw2EsdRizhUfIWXyHD4Z/+bFUn1A6yH5HSXUpIoZWirTCT
         ZXdUwA2ELpustgHysd9yeye8vtC2POnltR3un7nGQXQKFWiKBk4hT3VpU9+SIkVhfj
         IaPiGwo5CLiQg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 05, 2021 at 04:47:03PM +0800, Weihang Li wrote:
> diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
> index 90b739d..79dba94 100644
> +++ b/include/uapi/rdma/hns-abi.h
> @@ -77,6 +77,7 @@ enum hns_roce_qp_cap_flags {
>  	HNS_ROCE_QP_CAP_RQ_RECORD_DB = 1 << 0,
>  	HNS_ROCE_QP_CAP_SQ_RECORD_DB = 1 << 1,
>  	HNS_ROCE_QP_CAP_OWNER_DB = 1 << 2,
> +	HNS_ROCE_QP_CAP_UD_SQ_INL = 1 << 3,

I don't understand why you need this flag.

The # of bytes of inline data should be returned from create_qp in the
max_inline_data cap.

If things doesn't support inline data then shouldn't that just return
0?

Jason
