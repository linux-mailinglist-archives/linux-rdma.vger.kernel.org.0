Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065402161D4
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 01:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgGFXEb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 19:04:31 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7457 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgGFXEb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 19:04:31 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f03adf20000>; Mon, 06 Jul 2020 16:04:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 06 Jul 2020 16:04:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 06 Jul 2020 16:04:31 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Jul
 2020 23:04:19 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 6 Jul 2020 23:04:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPfdkEd2xxg5jUkKi63CzyHy4XNBHwKnMxC7gCKRXIxB+wGnCLA9C8z/9Zp2J8FGdw5/Ya8VAHRcHa91PLgAGGUYszlq6ellLgDrAwfl1aB7Abwdz0ksu5MbeoUc3oDOd/WhsoH2x978xrh8J9IW9HJ05vUzYBMFPFVvWEOPsykAvvLWni6CWXMqyF01z10PMx+3ikL+6z+Sdc3lw0OPy+NzPgPDpwu3F4yxlaTsQk9p+Y9RoKam7U1CCTTpmQ8LLtkyOJP6jWnSFhaQEyxPAcHJuoHTDPiiBZ7prQfa5sD/VDjKSWF2GtmerLnF9mhNoTij/5iS2IR+C12VfCv9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egox8B4CXRlvjqOg96++RbHynBiK/J39TTZITsXoTiE=;
 b=Vhr3Ypxoz/+8fDn0NfbVPPVSk2280hPKEO60/otE464zlypLKb0oULUQz7bYqCmtM8UlhSsF+i18yLiOgyUwjfnVasI8NwASZAHT9QXMNPJtY/ZBwyQocqwvqtXSywEaWCkKLzz3V8zFIInw3RjwB+XZkFTcM5e9qPcXPSiFvr0fJrJB8BilN/oLuMhz6pnYU3xfiSG+zMyrekvehf5ulJMVG1QMWo1MNWjfhZabA5Fw4nScXU2XGWEXGS1IAwu/af5GTzi46mb2iwhofk8FDjwctkL6ITKJENiYyLiwq2JNhX6h2lfdA035/3a/mVl1xj8/mDCICV7/WTgBz6KDow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Mon, 6 Jul
 2020 23:04:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 23:04:19 +0000
Date:   Mon, 6 Jul 2020 20:04:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Lijun Ou <oulijun@huawei.com>, <linux-rdma@vger.kernel.org>,
        "Potnuri Bharat Teja" <bharat@chelsio.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next v1 2/4] RDMA: Clean MW allocation and free flows
Message-ID: <20200706230416.GA1283287@nvidia.com>
References: <20200630101855.368895-1-leon@kernel.org>
 <20200630101855.368895-3-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200630101855.368895-3-leon@kernel.org>
X-ClientProxiedBy: YTOPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::48) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTOPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Mon, 6 Jul 2020 23:04:18 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jsa9o-005NrT-Qa; Mon, 06 Jul 2020 20:04:16 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e82247cd-dee1-453f-9225-08d82200e962
X-MS-TrafficTypeDiagnostic: DM6PR12MB4499:
X-Microsoft-Antispam-PRVS: <DM6PR12MB449919B71DB469F92339CA31C2690@DM6PR12MB4499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbhsfsvs/DMyRFcubQqCJQ+oJ267YQ46SGIrdVmWpXl1fISCAM9vz6NYQCNBHGcB+vHfWcmQ/tFZli9qTAdiaUnT1C8jnKsDOPH5E/ckeaF6NOqZrMmQhRbGLnOZ4ia9blxCTyht/S0qBB3o82tkLb8BXI9TmCi8MlUqAs0G8zJ0ZXRpk3pRkQqq0kdSJT8onPavF9xwLGxayLqS2oMuE+ncOTmJWwQZPJXthmV3wWf2x/vL9VdYXko61a0AehTRnICJOsBbOk+oul7xtw7eFv5io0qFvkLYNQGPZMZ9jXcBKPAzEYGON9Tscna7qfI7LBlYJyZHJlk6T/RiE4GRNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(186003)(4326008)(5660300002)(36756003)(26005)(1076003)(6916009)(2906002)(8936002)(86362001)(9786002)(9746002)(66946007)(478600001)(66556008)(66476007)(54906003)(8676002)(33656002)(426003)(2616005)(4744005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: aihCFSrqRQZkB3iX8PRLMTcQQuO9v4qtf/kY+SgttZJHvuQXGHMSxYWWMipRwZe2juLw5o3A2DRosaai+N9om1fXFgXKPl75/8F+D4YjKuLYySBIftnnMtYRyM/xgvfI/bIj2QWjc/I+0vnFBVCDmo17EHnl4IDfnPuzeqcxBUYmvgJDoOWW3BQk4QHMguZcmNE/4JZInvyMapB0mz1PyDDfwO6QEOuUmzGMfgSx04KA1OgPeZXQ90Q5llkZPHec54wnHUv59kc4BhcLM3iw+BmdAfNzOSBz3ZgcYpKqlUIipXPu2q2bP7NuYmi5YSrK/fuRzM84ajnXnjHxSxPur9gvbdm9gIpN2HhQ+ndN/CvyFjsdfPrjbrMAaYvmFRLgOG01o8KsTX6owsRUHNsRhbWObTcL3rgyDj42jNeI2MEHL7484Ej1h9dzILQwnAbSimP5nJ2mTZhqu1m0EJdJttTWEzNC9YoogVP40P/BNBmKqe2VC0aVrX/GAXVm9BYV
X-MS-Exchange-CrossTenant-Network-Message-Id: e82247cd-dee1-453f-9225-08d82200e962
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 23:04:18.9837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNt8sPtR+AXgXMvQayBICBD9bGVFovPyfzMnxolFTtquY1H93oNaJRIoG6PxBNnS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4499
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594076658; bh=egox8B4CXRlvjqOg96++RbHynBiK/J39TTZITsXoTiE=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-Forefront-PRVS:
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
        b=OBiBMszNBBVRKtnojtJWF9kn6T40D+rrjFmIkiI/ZG3vNUFxNkyhb2j1/P2D2pElE
         gq/aZgeK6LUQbKlH58e5RpoycIOKMDEc87XYzvKfLBvzohyI6PSJmaMmOCfF8tihxM
         +klO22SEhxgJqYIFjEf6s7Dycr+FjagEc9rbVA3dchQZuFz0qcdlmdXUEjHT+n2VCq
         tMsw7W67GYBDFbR+BjGd3b0u4aR5dKSauTZmYujM1mQxzK/UCTozM7g5wGyPbvReUv
         KoqP6RKrcLTngiweU2NfdFNPVUp5FcuG6+xhB4dnkQWYU2n3u8Kd2Qg7BcjSgSOL6g
         Q5cK+UVoIa9Rg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 30, 2020 at 01:18:53PM +0300, Leon Romanovsky wrote:
> @@ -916,21 +916,24 @@ static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
>  		goto err_put;
>  	}
>  
> -	mw = pd->device->ops.alloc_mw(pd, cmd.mw_type, &attrs->driver_udata);
> -	if (IS_ERR(mw)) {
> -		ret = PTR_ERR(mw);
> +	mw = rdma_zalloc_drv_obj(ib_dev, ib_mw);
> +	if (!mw) {
> +		ret = -ENOMEM;
>  		goto err_put;
>  	}
>  
> -	mw->device  = pd->device;
> -	mw->pd      = pd;
> +	mw->device = ib_dev;
> +	mw->pd = pd;
>  	mw->uobject = uobj;
> -	atomic_inc(&pd->usecnt);
> -
>  	uobj->object = mw;
> +	mw->type = cmd.mw_type;
>  
> -	memset(&resp, 0, sizeof(resp));
> -	resp.rkey      = mw->rkey;
> +	ret = pd->device->ops.alloc_mw(mw, &mw->rkey, &attrs->driver_udata);

Why the strange &mw->rkey ? Can't the drivers just do mw->rkey = foo ?

Jason
