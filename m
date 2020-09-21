Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6E02730A8
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Sep 2020 19:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgIURIb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Sep 2020 13:08:31 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:20773 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbgIURIa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Sep 2020 13:08:30 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f68de0b0000>; Tue, 22 Sep 2020 01:08:27 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Sep
 2020 17:08:27 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 21 Sep 2020 17:08:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neGEnXWHJDz02icC9XfvciAzaKq4Wj0xal3AjfNqFQ3Mw3FsXshdDAIFXYXt5NNSltwpuzRG91uzKsBBFA7Wp0DX3Wv/Z+0luC5RjwapuhHPVvS3NsoJSta6WzL1vITy0BErUglDtQ4/02JSUR2JmlOtlGf/30ogQfVTztZCbHsanfnGvtzzGtGtvqhIXSay3dRB0Q0QcJ463vg3mXNewBpI4oseCO5NeLiGuW/UwhtCqlP2Asdciifu/iQ2EYexn4l5SruhfIY1DpdUmQrMFcvgTziC6gCqiBqcZ8IHxDcn86WenbioNO86wUnHT2b8Ff/RInN0DWyqBtgmP83YVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apck+6sfkLikbUHFbFq1gPQY4bsC5cS3JNhJUabRljY=;
 b=ZmmurrS97cHNRQlPiVgFpBYK+u+wrfO5QnMMsBY/2KEV1ovaQYruFL/QGT6oh/V7e7WQlryaW2J3PpIOx5yfzXUY7PPuTOHdEp4Z0uqee5LQCDJikmH5n90CxtMLAAH1plKz6IZY3se8+DjspHY/iNdk1XO/gN0+GMgSBORRtQ59I+zH+A2VhNDQA522kXE7QuMilMhepmrIBiqoqOnV8e2HDLZea2975pjTQ8ydVqjOr08UudCO1i5k0opRNemS1NybHBle6+9ziQhxI4xgrjtSmLfv+CDjfjOuFB3YDsIMAtejEe8+WH85DOgOjDvvv1hM7jcUUkwLWqPShBTkkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3932.namprd12.prod.outlook.com (2603:10b6:5:1c1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 17:08:23 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Mon, 21 Sep 2020
 17:08:23 +0000
Date:   Mon, 21 Sep 2020 14:08:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yishai Hadas <yishaih@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, Yishai Hadas <yishaih@nvida.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH rdma-next v1 4/4] RDMA/mlx5: Sync device with CPU pages
 upon ODP MR registration
Message-ID: <20200921170821.GY3699@nvidia.com>
References: <20200917112152.1075974-1-leon@kernel.org>
 <20200917112152.1075974-5-leon@kernel.org> <20200921142543.GU3699@nvidia.com>
 <cf4516e4-f5f3-295f-d4ef-f0411765c9e8@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cf4516e4-f5f3-295f-d4ef-f0411765c9e8@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0047.namprd13.prod.outlook.com
 (2603:10b6:208:257::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0047.namprd13.prod.outlook.com (2603:10b6:208:257::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.18 via Frontend Transport; Mon, 21 Sep 2020 17:08:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kKPIb-002gIX-IN; Mon, 21 Sep 2020 14:08:21 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b1cc659-f8b5-4ebd-2059-08d85e50f251
X-MS-TrafficTypeDiagnostic: DM6PR12MB3932:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3932E3588A1E0FAC2548B46BC23A0@DM6PR12MB3932.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 346suN43ubCDgsjg5TpqMxYvzVqKCI3G0OncKgZqNzzoAEka2XnUwQHmuCR7p7SxqZwoSe+OkOxmyi5sp0nBVIB0q4KqOtuUhCEtj5YlwzTRm5oWLbCq6Kc/sh4TuStFyNXh6Ch0LKS8zSPnhSDzixRsQfp+Z8z/PuX/h1T7TV9qh7g0DGPUH5FmmCWcIDuVNh9OVJwMnaKrAShQxDc1GuS5/dH8WR1tLfbjuzLZdPediTOHVZ9CglsV2x0dcm+/l50EpSg5NZ9UoBzQ2z8jULnlgYxiTPNlHgF0PDEImHmKgDvMPcPDoXfGX7Pms9bA1nYkE+87Ja8ncVb7IQ5qeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(9746002)(4326008)(8676002)(5660300002)(83380400001)(186003)(86362001)(53546011)(6862004)(6636002)(54906003)(2906002)(26005)(1076003)(66476007)(316002)(66556008)(33656002)(66946007)(36756003)(9786002)(2616005)(37006003)(426003)(8936002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: sGCI5E8DAhkvSWQG2m5neY69TTbKUVaK7ZfUymEsdCiNRhsM6GTips/UK33/MOYCph7Mdib2ih3ttzE9dH0bRIr2qjibZYpQLaU5MLMRxY+JyIDS8ROTNTXqoVXvVnSP9BtWapRHF1VOH+KJ+X3GPp8PAcGsKwI++RL0BTzoGg/D+V6ubcQatBSp4bPcf4kM3BHUW0ZG/uHStqqXvdQhsV1Cn9Svq7ufN88DGSLAld/QkvPFNopnV+ET+t45UT5GqZLWbODoseha4apvVX8Xzu03kh0+7cBZ/vTSAJdG8/+JbX9cuIwKVRAOGvtwwh+n8I0pdbrzxcbXsi4CX4sQfh+kC0XKt99d5FDFJlW8EI+bT9J940FjWhDEBQmdsNOkiyr/Z05VcA4Wz93+fzkY/HIl/cSxpADTVFOSCbi34WfuaUKyIRp8GTTvZscz+YyZ+ZmcZEvlFW7fE4i0a4/ryugLVGret5iL1JgbMSBFGcf/rF21sT52WVSjcFezha8KorRxyss+mJEVjz0gKFcFgRZDCRIisP2hCAGvYClSmFeXEKrECH2mBpehMyo+tHriuJkz6iQIUpSSLlwz3T+Sxrj7h6xodGcg3wb5HttkJxYzxYwho6a9WTmsvSv6i+KwTks31MN2cE6Yc64H7BhD4Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1cc659-f8b5-4ebd-2059-08d85e50f251
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 17:08:23.7337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3X4HJvmW7wBPcVBpr9+LLBii5v6gUFuISYU5p9LJVe2NAvIlbws0KnbM2B2JJJ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3932
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600708107; bh=apck+6sfkLikbUHFbFq1gPQY4bsC5cS3JNhJUabRljY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=hWof/+mZX2TPRjPu7rR1VhKsNeSwNqahLGBxzZvdeIqrpAsBbqsvFgMqI4dHdVVs4
         KZBDoYrx9WnT79M2Xs8aDpCcDy7xPCEKduFo5Uqvm3Or8xJc7tlzIxXKtAazwfQTR5
         oAUlCY9qF4de90LXJ/b8s60ybUpOAEp6A1C9gysbRiOM6+X6VD8gtSi5QirmYBrGlk
         c8iLFqjvpWQfrb+XgzqxWWTEI36k4aBPtPRF33zxjMmsa7sfURCrI7ew2P7q7nEbEk
         Ea2UZBhLJH4CRTl94RT/ELBMXwiugI5VAR4aJYc1SxmHDFLbt9rfoUwHgkuRvCnNzd
         01IsVKtbgS19A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 21, 2020 at 08:04:43PM +0300, Yishai Hadas wrote:
> On 9/21/2020 5:25 PM, Jason Gunthorpe wrote:
> > On Thu, Sep 17, 2020 at 02:21:52PM +0300, Leon Romanovsky wrote:
> > 
> > > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> > > index dea65e511a3e..234a5d25a072 100644
> > > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > > @@ -1431,7 +1431,7 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
> > >   	mr->umem = umem;
> > >   	set_mr_fields(dev, mr, npages, length, access_flags);
> > > 
> > > -	if (xlt_with_umr) {
> > > +	if (xlt_with_umr && !(access_flags & IB_ACCESS_ON_DEMAND)) {
> > >   		/*
> > >   		 * If the MR was created with reg_create then it will be
> > >   		 * configured properly but left disabled. It is safe to go ahead
> > > @@ -1439,9 +1439,6 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
> > >   		 */
> > >   		int update_xlt_flags = MLX5_IB_UPD_XLT_ENABLE;
> > > 
> > > -		if (access_flags & IB_ACCESS_ON_DEMAND)
> > > -			update_xlt_flags |= MLX5_IB_UPD_XLT_ZAP;
> > > -
> > >   		err = mlx5_ib_update_xlt(mr, 0, ncont, page_shift,
> > >   					 update_xlt_flags);
> > >   		if (err) {
> > > @@ -1467,6 +1464,12 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
> > >   			dereg_mr(dev, mr);
> > >   			return ERR_PTR(err);
> > >   		}
> > > +
> > > +		err = mlx5_ib_init_odp_mr(mr, start, length, xlt_with_umr);
> > No reason to pass start/length, that is already in the mr
> > 
> > Jason
> 
> The start / iova is set on 'ib_mr' in the uverbs layer post returning from
> reg_user_mr for all drivers [1], so the function just got both.
> Makes sense ?

The information is stored in the umem_odp

Jason
