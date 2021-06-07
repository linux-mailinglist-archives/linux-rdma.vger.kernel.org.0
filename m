Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD5739EA29
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 01:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhFGXeA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 19:34:00 -0400
Received: from mail-dm6nam12on2086.outbound.protection.outlook.com ([40.107.243.86]:17248
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230239AbhFGXd7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 19:33:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edjaNQ4jUD8WLQcYKrCKubfFJsps73R7b3VcdK2QeXg9uRxl4VKG+9uGLeEz2tTMwyWF6Hsw9Jz+wUUmzggpysr7O38721DcKQldCgI3pRV3rtXS9z+3Ps+a1t6omizAx9WHIBH9VBiwmdKCMdrBjcj7w8lYhpyxq1lN9OE9/IWTcIcFZvjz83NHPZOvdpg6IpDs67TZ0jS8cYb4NEvLpnh3mdjlt1WZYSmnYev5FVkBEsBTRRgUzJ93VjBpL7KzHqQQRBJhg21vegMjKMm4kgMWuSiEmfLkCHvuXcQ0GulEp+gneye0ZjqpoHaHeIuFzkbCETgvBv4QkwlODXC0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35tgb7VnE398mqraT5aYrDQ5RJbp5fn1InjDMrIGms4=;
 b=JVggemMVdFTbrA/YAy4NdVNSNXA2+CeJj98BNTnvc7LUyZCO9NQqD1EAAIZZOyffJ7D3k5SSxv8FgNZySK1Fr1APZiWxEQzk2vzpnZ9k53oSR4cyYfT0l9oT4art/ivaBSQWkd6P2vvqc7iljGxfozZQcp8j3TG4eYsR/x+wB1+1M8z7G2cxYXliqp3YyaSd9smdhJjmAVqTtiJeXd5xA0lmx8bm352FXriOwCgbO1NUBJCvREGoUsyGN5Opmvid83XOFsDg9YglSLmGCXqlhMJ0rrfVgdMvb4disgYXGLjUUQ4hDNZpc3qNZj3a79YSJqJWTzlZFWLj7N/FcrkyBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35tgb7VnE398mqraT5aYrDQ5RJbp5fn1InjDMrIGms4=;
 b=XNTfj0QloZ+azBc3V3OY2NVV1HkaN2w0gs29Uu7tTjSIYfRBkyB/B7jhBqdG02Xl6dhfeNKyIittOtcx7ykaJVTseNGmMI1JaxZnxMxQ+k/E/IRGW40GDh74zrxW0S6cZoqO7GScbdk3FLmIvFJyLkHfxBFlS5XHZavjxeOkxkdBzkccaYoL2F71leXv+SFcNVFHZW7x6sp0PUSHJSJn2At5s+4rUaSfkMKl/vw3Kh1em6h2cubYS1reeLuP6JHyoPxmuOI25sa1y+ATTYfXuftwCiB7Hxh9wugXCM/QDtL7be80ayiF7n4E89OweXa1lCxJaytW8Q/R6XS+UlBS5w==
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5141.namprd12.prod.outlook.com (2603:10b6:208:309::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Mon, 7 Jun
 2021 23:32:04 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 23:32:04 +0000
Date:   Mon, 7 Jun 2021 20:32:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Parav Pandit <parav@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next v1 14/15] RDMA/core: Allow port_groups to be
 used with namespaces
Message-ID: <20210607233202.GU1002214@nvidia.com>
References: <cover.1623053078.git.leonro@nvidia.com>
 <a1a8a96629405ff3b2990f5f8dbd7b57a818571e.1623053078.git.leonro@nvidia.com>
 <PH0PR12MB5481C3DE73C097E938B4E5D1DC389@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR12MB5481C3DE73C097E938B4E5D1DC389@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0092.namprd02.prod.outlook.com
 (2603:10b6:208:51::33) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0092.namprd02.prod.outlook.com (2603:10b6:208:51::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend Transport; Mon, 7 Jun 2021 23:32:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lqOiw-003WBG-V0; Mon, 07 Jun 2021 20:32:02 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afe03612-a17f-46a6-5025-08d92a0c74ca
X-MS-TrafficTypeDiagnostic: BL1PR12MB5141:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB51413589046CE96D6EA1D410C2389@BL1PR12MB5141.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Jcnifj29MCP/pIrw4ATRTurf76khZp1htj+WjjQ/GW+PrFPQfBmjXrPzujpuScM0K0eksQiRBJi92cUrnFDECGx5PO4gX8sI5Oh0Py99qHyJi08DexHaryRffFU0tRVH5a1hYVkIFPdQTFa656tyfv+wdPXA//OFgLZqcLHdGskLTunY7ct9/4Kw8lVlunG9+ykYtiX8HIFUnndMKV11hwJmyTABFQTIDFCxzEG+L9YpFqDrtzlowmgHildvYk2isKjyu9D5rDlhykKEk5C/RwJHUwNVCkZQIlNwrVHN/jJwKjZmt1617M2XNhz8MqdWyqUHQf3w+1cyTB9wRyDVGlTHvJTk7mBTEuiwYVdPBcaQEAHkaCrSU97s4Fg4RzZvry9dddLkaeYb8hf8XMlyla2i1WApvQwjESTlmB5KL1yFHgxVVOJbu9QWBUlpj7GxzDF2XizYG0WOro2TKUpjKtyxpFc4pZ4KlAf4r/8l1WsqUPFQBNeHAUBsO/dmgHmMOm+S109zufcp0qdCFHZq03b/PET+M4s6xkebjH+C7WiFox7zhpcC0TozELaHqicZ657v3spSv9HkaTmKJpBCNI+X1LPCNAuAgH0In0mOj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(2616005)(7416002)(316002)(1076003)(37006003)(26005)(5660300002)(2906002)(66556008)(66476007)(186003)(9786002)(4326008)(66946007)(426003)(54906003)(9746002)(33656002)(83380400001)(478600001)(36756003)(6636002)(8676002)(8936002)(6862004)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+AhU9Pmq5OIYVKE42826jxR9bqvhXC+o2ZV1MWxz9ysJ1MzZIJ0+l10mp0nh?=
 =?us-ascii?Q?5TaQRmKNIgjG2iId+1ZAXoOKJ9SG60Xeqe0cty50mm2ErYLjzbSrgotrAFhW?=
 =?us-ascii?Q?mIMYxLj0FViKEamTOsbvPwOt2lKuaeXsdLGAvWAOCji1bzsgV9OoRl1Qig5f?=
 =?us-ascii?Q?0XEeGqPdEdxEuyiYXmpkLh6FkUrNy75cGsGDDHEaNNuFXlrGXqrwxn96e+sq?=
 =?us-ascii?Q?KNRgBjj9i0mUvwqOcTN1KhXEyTAGWvc8PbP411gt9T2sti03bIBCSdV+ImeN?=
 =?us-ascii?Q?qf249Vj0tXPJ08Iwct8TVqkeNVVxObf1j10PS9m40naavU+LTgRxycOKPDzV?=
 =?us-ascii?Q?q40IIag7gqRG4D3qJVsr7356zui4bEBQRcRz/rIP842i4XfcZR35yiIZZgf1?=
 =?us-ascii?Q?h8GUrwM1kh3e9QEo8oaiqSd60rJP33s5HC3xclfSzVZoKIgZgwL/RUxvNG/V?=
 =?us-ascii?Q?mqfEKygpdZd5P5v4Ts8d96S5L4hCl1pMBeWP+S2pgBZs5sEQjrjI/4KxOYi0?=
 =?us-ascii?Q?bw5oS5nAa5MKjIcNNE0cy8F7BSfhFAmJq2Op9tCVF7B4lXf4xrfp3+pfhViQ?=
 =?us-ascii?Q?UZl+c5k14r3NA38SUAWs0bC6Y/DXAiW0h6PMthY+UWgSTGAQNt4SWD8h7v3V?=
 =?us-ascii?Q?mdVXCcGFeU+7R/gp6pKGV9Cohlw5lYIOUc6IjAFZ6ZuLnfRZ5F5arAQKZxT8?=
 =?us-ascii?Q?kvUTyQm2HR0hSCX98Ayl3dxbFLRVhmhGz2iz+vVCqUGVc2WeLoj9ML9Ru98G?=
 =?us-ascii?Q?QPNjqPfvZyHI25XOtCP5VhmkOHZ6BVAKtQwgJ0bBYZ7ETrjDDtIrWtrNrwEW?=
 =?us-ascii?Q?W6rlpuB5JQ0i5g+0l70T4xUhg/H/5zIgSZ1Jtf8KB3FaY/NxxQTJTvGtvpMj?=
 =?us-ascii?Q?EMXym+8KXCbnivRjrtOFccsnbPscmnWWWp7f6KTK5o5h2kw+5DxwDVdZNvRv?=
 =?us-ascii?Q?6vgzRUviTA5PerMoP4q7p8u+9FbcFJvFOlqCuwQGRVr0OF3VBcWExOuFiZZo?=
 =?us-ascii?Q?oj4ZmeaPsdr4SeWl/cvCiQy5VbPMEmrEm4e7aCp3/5AjlklkUAV2Thiiayqo?=
 =?us-ascii?Q?Qth67M9adhttjcWtTCfq98VsyioGx3n62dfg4LYN2Dbay1a0SYNwficg1yzO?=
 =?us-ascii?Q?/Qb+6mxUev5iV8gbcgn0ed8ReeeMs4DksrAts58rBGefwmvoNxp/SOliVx9k?=
 =?us-ascii?Q?gBVxRHSx3Zj86FypUbOzKif59M+7HW43FykFmip5N3A2lrQqBeYrGcMFhk/C?=
 =?us-ascii?Q?dohCrjFJLRpD2fmOuqYyR3pC7of59KCMr6B4gAiRAnMl9CYcHDzo169moLH/?=
 =?us-ascii?Q?BoduT5tX0wjec+4QIzWlAfdd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe03612-a17f-46a6-5025-08d92a0c74ca
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 23:32:03.9166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecuL86syDestcKggzs9FMylbtr5OnlQB8XITxz7SxqsRvcSwEG6hsIX9XGNryZKU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5141
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 07, 2021 at 01:29:58PM +0000, Parav Pandit wrote:
> 
> 
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Monday, June 7, 2021 1:48 PM
> > 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > Now that the port_groups data is being destroyed and managed by the core
> > code this restriction is no longer needed. All the ib_port_attrs are compatible
> > with the core's sysfs lifecycle.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >  drivers/infiniband/core/device.c | 10 ++++------
> > drivers/infiniband/core/sysfs.c  | 17 ++++++-----------
> >  2 files changed, 10 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/infiniband/core/device.c
> > b/drivers/infiniband/core/device.c
> > index 2cbd77933ea5..92f224a97481 100644
> > +++ b/drivers/infiniband/core/device.c
> > @@ -1698,13 +1698,11 @@ int ib_device_set_netns_put(struct sk_buff
> > *skb,
> >  	}
> > 
> >  	/*
> > -	 * Currently supported only for those providers which support
> > -	 * disassociation and don't do port specific sysfs init. Once a
> > -	 * port_cleanup infrastructure is implemented, this limitation will be
> > -	 * removed.
> > +	 * All the ib_clients, including uverbs, are reset when the namespace
> > is
> > +	 * changed and this cannot be blocked waiting for userspace to do
> > +	 * something, so disassociation is mandatory.
> >  	 */
> > -	if (!dev->ops.disassociate_ucontext || dev->ops.port_groups ||
> > -	    ib_devices_shared_netns) {

So this is OK since we have the clean up now

> > +	if (!dev->ops.disassociate_ucontext || ib_devices_shared_netns) {
> >  		ret = -EOPNOTSUPP;
> >  		goto ns_err;
> >  	}
> > diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
> > index 09a2e1066df0..f42034fcf3d9 100644
> > +++ b/drivers/infiniband/core/sysfs.c
> > @@ -1236,11 +1236,9 @@ static struct ib_port *setup_port(struct
> > ib_core_device *coredev, int port_num,
> >  	ret = sysfs_create_groups(&p->kobj, p->groups_list);
> >  	if (ret)
> >  		goto err_del;
> > -	if (is_full_dev) {
> > -		ret = sysfs_create_groups(&p->kobj, device-
> > >ops.port_groups);
> > -		if (ret)
> > -			goto err_groups;
> > -	}
> > +	ret = sysfs_create_groups(&p->kobj, device->ops.port_groups);
> > +	if (ret)
> > +		goto err_groups;
> 
> This will expose counters in all net namespaces in shared mode
> (default case).  Application running in one net namespace will be
> able to monitor counters of other net namespace.  This should be
> avoided.

And you want this to stay blocked because the port_groups mostly
contain counters?

Jason
