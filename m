Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4FE2B6E0E
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Nov 2020 20:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgKQTIl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Nov 2020 14:08:41 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17687 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgKQTIl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Nov 2020 14:08:41 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb41faf0000>; Tue, 17 Nov 2020 11:08:31 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Nov
 2020 19:08:40 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 17 Nov 2020 19:08:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHzOEOeOD8nie2vc35OMyBDb4EC5jJY4CC9wkixJjL1bHiwUkRGpxUrw52ms1Y6t4jzqzXAAT5LkVgImqtEVTMhcaZjg7gP14uAV4VqEblrXzf9WsTNaN0uaiuO9xe3eTLFy0WUf9xU8jv4aNXamTsOLFN7D3GQ9oqdI0v8II9hHkZldkzk9nzpKmGFoXuw+EfEV3QkQdGk5MwiK1daIQ5koW+sqbw8bJ/SVggdOFtvylxV1+9Nx3Y5TaNk8yCichOLqeOcL4ksHMTNZIpdiWpyWwRJsMcIHiHgHyvEshB0+wjU3cUJRqM/PkRNQMA28hwK61cBhgw7w1o6mDJITqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+sFymohoYxZPrbNUPfTAL2TuKkZZSUBUVc2T63FcQ4=;
 b=VfhdgwumtCF/ojmmfgfhutTR6955+QU6/aHHeMhilpgLgoVqSYFi6beVM+tpYQyjYM99ANH2FAJdp46qdiK0w/Htdz09FgwazfdadqD7gaLy2+c1jfWPbk+8unJNQ9Nhv7hb1QR0Sr/vpmNqjMbf/FCAq8s/Gv3jEEoCmTLv7BOZPqlWMWQ9F6qORZy5i143PaPiLEHsWvk1+oyLJTJrDHxRXVMxQmoiHKIb9ImxDAgh7MmgvljpST2A0FhvAnOywMLQ3/Fy1PqLwaBuDsoqZCT9goK0b8fcH8naQsc5cNp0X4+GciNSJ7NGOCSR4qIYVihdESZEYo5bbiQD9PixLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3931.namprd12.prod.outlook.com (2603:10b6:5:1cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 17 Nov
 2020 19:08:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 19:08:38 +0000
Date:   Tue, 17 Nov 2020 15:08:37 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yishai Hadas <yishaih@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, Bob Pearson <rpearsonhpe@gmail.com>,
        <maorg@nvidia.com>
Subject: Re: [PATCH 3/9] mlx5: Move context initialization out of
 mlx5_query_device_ex()
Message-ID: <20201117190837.GW917484@nvidia.com>
References: <3-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
 <7f9d950b-329d-17d0-a25f-4e6f5851c26f@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7f9d950b-329d-17d0-a25f-4e6f5851c26f@nvidia.com>
X-ClientProxiedBy: MN2PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:23a::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by MN2PR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:23a::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Tue, 17 Nov 2020 19:08:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kf6LF-007Bmq-3Z; Tue, 17 Nov 2020 15:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605640111; bh=o+sFymohoYxZPrbNUPfTAL2TuKkZZSUBUVc2T63FcQ4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Y8hbZ+9OmEI6kNY9dtgUJOA2rJ6qwyVpQIvX5usurv2IBW+5FcE2RBVMgDNQZnBn7
         i2gKUshBtE8wzfhesocOrJew1Q+GjljLlQTo//Cu272GUdAo752eQfNM7AvI/cZXhp
         OKWbBIDYNfdJgAduas63v28N5EnpSgfkQdRZQfLm9zGzDV4d4IoO2xMf/vt3XcwEfk
         1aG2agqkIZjFyseVDUDwcoHkS5sXh7Wmq9ACn2FyDwUKn01NMI+KC/bvC2xJudkP/v
         j1enU3Yqr9XnEAqIFYkuawVnaKpIQGZ+qPH1MhBXsGTJpMUKb89K87X+dzZm5UzC1O
         io1SiuEICT8Rg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 17, 2020 at 07:24:41PM +0200, Yishai Hadas wrote:

> > +void mlx5_query_device_ctx(struct mlx5_context *mctx)
> > +{
> > +	struct ibv_device_attr_ex device_attr;
> > +	struct mlx5_query_device_ex_resp resp;
> > +	size_t resp_size = sizeof(resp);
> > +
> > +	get_lag_caps(mctx);
> > +
> > +	if (!(mctx->cmds_supp_uhw & MLX5_USER_CMDS_SUPP_UHW_QUERY_DEVICE))
> > +		return;
> > +

> Any reason to not read some applicable context fields (e.g. max_dm_size)
> over uverbs by reducing the resp_size to the ib part ?

No, I missed the device_attr detail

> > +	if (ibv_cmd_query_device_any(&mctx->ibv_ctx.context, NULL, &device_attr,
> > +				     sizeof(device_attr), &resp.ibv_resp,
> > +				     &resp_size))
> > +		return;
> > +
> > +	mctx->cached_device_cap_flags = device_attr.orig_attr.device_cap_flags;
> > +	mctx->atomic_cap = device_attr.orig_attr.atomic_cap;
> > +	mctx->cached_tso_caps = device_attr.tso_caps;
> 
> The device_attr.tso_caps is not set over uverbs / cmd_device.c, it
> comes as UHW.  The below should be done instead.

Got it

I updated the github

Thanks,
Jason
