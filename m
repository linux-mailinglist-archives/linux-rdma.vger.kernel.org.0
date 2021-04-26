Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C5836B2B2
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Apr 2021 14:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhDZMEg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Apr 2021 08:04:36 -0400
Received: from mail-eopbgr750055.outbound.protection.outlook.com ([40.107.75.55]:47421
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231550AbhDZMEe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Apr 2021 08:04:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGOvqT1jb3BtPL0pMqHTmG5qUeSYT4tpiLffCWR+3L05wsAGq0chs2M4vAkt3lMsVX86RMoqUu97wZ0Y59HpOT+m0PVRtc7+MoAJA5NTqQ/o33SOS7FwVkZ7lXpeUwUs5y1lgYOVOZgQsYpSQA5e55gOT/ss1badHrXHsRcrfwbI057Rm0citHsEHF4eCQnqjIHmYPvCf84nC2mgSHOTcFKL/1347DWfbZ0qVz1dQwQWZda5J9XT9Urn7zwoFJ9nuA/bn0PuIVyuwj7z92v2qEGmRRy1PODH4Uwp2g/dSBIDdoWrD6fZSISUDsZD4eUI8myQS9ZHoDErOC67IQuCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cMw7vx3m5F5O42yb+JP2z1WjGdP8QG9pnOByvesn5Y=;
 b=IKVVWmfsJ7nYXPZuLEHFso20A2cLyIky4HSGLg1o4UjGBD/ANMIrdrxRv4jBvrZTN0W3SUKA8tqECcVA5Dqlk8zLQiTkq84vl7bF1et9hY1JWX+oWB19E4bZM8hAgNmqPisEnsVF1FKUuNLqWivCXbNWz6TBHwqODkIA/k3knNReM8vrS5oZFpsBQIVt9J30cicEatLdazUDKUThMqo1e2AmeYgDD2jsHGGJyrFvHW1Gn5I/jtEY/BI3Mh+78q5ntdVyg7VsT59TKCvOcngzAX00vJMnOFSsD9z/mPxtEtpJUVcyQyAwIeNaPHGl2NouYyk1FcfNsC3oBM6zeoDMKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cMw7vx3m5F5O42yb+JP2z1WjGdP8QG9pnOByvesn5Y=;
 b=W6rriQLRix/a2G32hQhavT+Lpaz/KVGfwtcM89i94JhX6KSnBAIOUpBv98zO9/dzy+vbLRDNs22bXCo0gLLNZWci1xneHrtx5ocSfj4eiYGLCgBSh+Nw1IVzuGJqqcPdW5e15lsX/HxRYneVD1fDrtfYkLFZCdbEY3XIhNtB8/c2vruhRoh/B9hT9TE5KVnF0pHy+evDZsuRHYmDXVaDR/BBBFXwcwGlaszdJomHFy2i2UKRRArPPV13jpreyfLpniUJldIDonXOkE3q12f91a5Zgc72B5FikYhmbyn2hJqRRF9ISibxQ8RdjldUiSy/yEpN3xDwO5XU7PSIHJt8WA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Mon, 26 Apr
 2021 12:03:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.026; Mon, 26 Apr 2021
 12:03:51 +0000
Date:   Mon, 26 Apr 2021 09:03:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Shay Drory <shayd@nvidia.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/restrack: Delay QP deletion till all
 users are gone
Message-ID: <20210426120349.GP1370958@nvidia.com>
References: <20210420123950.GA2138447@nvidia.com>
 <YH7Ru5ZSr1kWGZoa@unreal>
 <20210420152541.GC1370958@nvidia.com>
 <YH+yGj3cLuA5ga8s@unreal>
 <20210422142939.GA2407382@nvidia.com>
 <YIVosxurbZGlmCOw@unreal>
 <20210425130857.GN1370958@nvidia.com>
 <YIVyV2A0QhUXF+rw@unreal>
 <20210425172254.GO1370958@nvidia.com>
 <YIWpMbUg3VlT3uJy@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIWpMbUg3VlT3uJy@unreal>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0378.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0378.namprd13.prod.outlook.com (2603:10b6:208:2c0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.17 via Frontend Transport; Mon, 26 Apr 2021 12:03:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lazxt-00D10C-5w; Mon, 26 Apr 2021 09:03:49 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ece569b-abfc-4fee-363f-08d908ab5aa8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4943:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4943D229843A7FE77028133FC2429@DM6PR12MB4943.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DO0MBD+qCfvT5ddFAg323s45F/LoplY5Y4BtJX/Dqc43PoJ25hNE5HCp138M+B8xnPudf59WjZzJNWJ5IjtYczq+kkL+WQcpQt+3dIeG4qKnDc6moxuMpSyFxe6PzcWKu9OPJR+07t3ic8Hi6si173I+8AmVxN01bSa/9uuEEN5SIaHn9f+RBkoDm8BIM+fdHkwR++ww7USWmckI2rhv0lMFbP7VgrvLR0kIvNJIOdaC+RQDFaeMA5Xf3YiHnqdiD5IUwyk44+5eVuUQzvwvFK168mc3sM8R6YY3YVZRmfxvh2FsjbwkmmsO6DHLZMbof9SCCPml6N+R+Es7Sqrws9f7uZfXyhrWYJbS6Q1US0bodKmkVj1B96gjEDu6uOppXkhi04DS6ymE5O3hee7g0JIrPPAEKOeS4aOkflog3uILvQb6e16NmfnVgj1VIcol9LBxnIHO4LUvE4x8DAqwRs/YI7ho4UqNBlXvcGf0L4Bn/WPdzXGKaloOLmbCSjzD0dtdFoyrLMgp5U5Yjm0Qqwy+s2uRLjRvlBeEN7cCPoI5bQmTvTgnnj6rh1HALYU4L8rzVl5UnFAcTZiDm5O91ezB5q7t8mQfIVx5FT9budw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(1076003)(5660300002)(2906002)(2616005)(38100700002)(33656002)(316002)(66476007)(66556008)(66946007)(26005)(54906003)(426003)(186003)(4326008)(83380400001)(36756003)(9786002)(6916009)(86362001)(9746002)(8936002)(8676002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eknoJn3GVCV+LWG0glwWXSQzU0D4b/zX9gYEgaieppGrXt25ODRTmUWvX7af?=
 =?us-ascii?Q?91KJUGpZcE/u6G21Od7BrFtUTr0yoFFRJHll5CUjAbJiwtgVbRF9WZG9LMEp?=
 =?us-ascii?Q?4bul4YZZE2Z1pbyID0dLnGa2mPgi2Ptzn/1No3FPSvMl+0ujIfV5+K5Cp+gu?=
 =?us-ascii?Q?g+ZxE99K7nzRKsTeCbfHT2/1+qisQxWJn5wgpI6zmQI6KL3peLp6nFQ/Z8bV?=
 =?us-ascii?Q?okpviQ5hxLT5MJ1kyP45pzK6T7z9eahYtnxfabmvH70jaVakBjzTZQjafkkk?=
 =?us-ascii?Q?v+WRHsUrnU6Fim3UDkPvgcd7x5X0eXJO+bekJyYTsrC6kDMOBncJkK3dNNSj?=
 =?us-ascii?Q?7hc0UxqtEV4qFq7JImu7i0ajgipz5k8RiM7PqS2IOMM+ri8V3APw0z8RNXPi?=
 =?us-ascii?Q?ltI4P4rh4cm3c+nbQUMWfLsbJLjSQrZrEyT57eDIXSG7iiEOstFxos+dPKmU?=
 =?us-ascii?Q?K0tBNQWmini4n4vevMmRbXpzYUocjwWHW2hWhjaoI6OVxFNnDRVVfGiDiCf0?=
 =?us-ascii?Q?eQpVQlFRxMkCUnt1Pw0oA6s8ZysuVo/u2nh//TVMW2Fe9WCEGxiPhRg8gN5a?=
 =?us-ascii?Q?gBUD1nKlHenHA9MApCFEU0PRwYsJ6QM4CFh0CLjf2loeIEgQQnT9i1KLufNm?=
 =?us-ascii?Q?ofcXEuFWV1KXa/CSYqKaA6jI88uaWPClDx92tYROVjQXLWu7kfQqimIGkonu?=
 =?us-ascii?Q?0QfXockErS2vN7C9PndGLH3TeGP9Gqqx8sjcENBtfmuFaV4oA4d+1ukXPMhV?=
 =?us-ascii?Q?r9kr9wqD1XlTyOCUYzinTSVTBvQrLsZZd1n4+mXeOhFMtc2DBvNE/e0ut/Wo?=
 =?us-ascii?Q?KLP0oEbTAPa9XWdS399oPDqO68XzNVQfA5UfCTXe401mVYeuX1aeklfjdwnY?=
 =?us-ascii?Q?aCuru2GJbrxixV8QtlnJsIjeLJn01tRFWwGBRTjn9MwBlWp5CLbRoqeg0mMp?=
 =?us-ascii?Q?1mpLOd+p74/UoEwjuIaXPzMyyhnJ09tG5JRs6JBoA9MyJOe7g8x5af53mPGW?=
 =?us-ascii?Q?B1PEt9Z+KupBVkTOHZy5wrgwKuyG0vOZhv5IYQyhmzWLC00uNF/tdD3xaa1H?=
 =?us-ascii?Q?7U5qhTLbuQdW1PJ0ZNrE9dDoAZU44qYv9PVdstxTVduo8ymXaQ3YgXeriH7l?=
 =?us-ascii?Q?ShEQOeYdY4Xj1EBt411ICx/jrtaXqOEwmu2VPXjD9jyTUKX4mnsACRDTCLSO?=
 =?us-ascii?Q?hMEEj8pqUP2fJBpkng/5ktZ4YWuod703/Ia08fXw6eUyJEs4HmMo64PYElgW?=
 =?us-ascii?Q?+rnjGjuamRCfEEZHuMaSeJJxco4k82Gn/RU5G4aoMe4isvgNpMYr7mSXZlR9?=
 =?us-ascii?Q?DKfoAkOSgOIUscX7YsMAMsod?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ece569b-abfc-4fee-363f-08d908ab5aa8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 12:03:50.9495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cKTofMJoHRn6Nrs4PZFEeCadeJAdu7IuDwVBUYsCeISv7UK2PFzNqbbWBHFyo6K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4943
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 25, 2021 at 08:38:57PM +0300, Leon Romanovsky wrote:
> On Sun, Apr 25, 2021 at 02:22:54PM -0300, Jason Gunthorpe wrote:
> > On Sun, Apr 25, 2021 at 04:44:55PM +0300, Leon Romanovsky wrote:
> > > > > The proposed prepare/abort/finish flow is much harder to implement correctly.
> > > > > Let's take as an example ib_destroy_qp_user(), we called to rdma_rw_cleanup_mrs(),
> > > > > but didn't restore them after .destroy_qp() failure.
> > > > 
> > > > I think it is a bug we call rdma_rw code in a a user path.
> > > 
> > > It was an example of a flow that wasn't restored properly. 
> > > The same goes for ib_dealloc_pd_user(), release of __internal_mr.
> > > 
> > > Of course, these flows shouldn't fail because of being kernel flows, but it is not clear
> > > from the code.
> > 
> > Well, exactly, user flows are not allowed to do extra stuff before
> > calling the driver destroy
> > 
> > So the arrangement I gave is reasonable and make sense, it is
> > certainly better than the hodge podge of ordering that we have today
> 
> I thought about simpler solution - move rdma_restrack_del() before .destroy() 
> callbacks together with attempt to readd res object if destroy fails.

Is isn't simpler, now add can fail and can't be recovered

Jason
