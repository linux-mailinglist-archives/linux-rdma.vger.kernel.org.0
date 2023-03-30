Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CA66D05AA
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 15:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjC3NBa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 09:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjC3NB1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 09:01:27 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E715AF12
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 06:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwV3Dc3nhOhlRjMDmnWWUdzguu8XRjwvExjT4fDauppZsxMwXkgn9znXTaLC1EpTK8STpi1HHHWlBVrhfWcuQuTjy0ddbUHFpz1Rh3Qgqt//dv1BaUPbuPUD5nSRQQiwdKQVR5wfNANelpaXKdQ3LI3GU1hD3dxmNkBoc5t+g5Sw750X7PhCwjLTVgqpnM1pGP3ulszE4rA+B40mp6MtiToc4rlVP/XdnzfKwAdBtP22ZMIHW+caAfoF4ThvTsSNtlxZc1QYwHBSG3XvQ7fNjDpYl4Y8CSJk0ojMDBeXvnn2kt1IGVSUuMcQaMrzukVNmtSoJKH92o1d6KOu4kk6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMzRsFmHQYbq3+U7QVbLH8MvthcS2FiIb29jWqMgsyI=;
 b=ZBRi4bdbFmFsLyd7g0KlMjLP3ZS1PhrnHLAU/qB1zOISf1RzjWXe4J2+2IjW5wELPwP42I3qBcE7yUc30e5kAfHUGP9R5KayGg53KDZlxVhC+X5wRPjfFXSzu4BHPOeiRci2Sj5XbOg1X7jJvOiw8TLIAlefkDqPIwCkg1XOd4p6h4EdeW0kTaU24xDXdMzuVcn/VydTDz4QjtqEq2Qe2UgoW38WK3bcE9CDOgUY6yVBRU4eOquqLZHx4QSAjfuCLXBr1q0MtxS9kJ4Patrre/gUD1+iQwDugFHIbC65oRWnZ61qYvHWJsCMz+0U+P6ebGyzCTuI7qZTzh4JmKSkIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMzRsFmHQYbq3+U7QVbLH8MvthcS2FiIb29jWqMgsyI=;
 b=cvFInIqpkfQiORWHn3wwYEdE2MASPpeQwGPBK3GkbUvD5y3ovXdUWK0AYKbz5F4XQKR3nr80wWjlTw0w6eQtp2XiKD9JGmUghs477cNxUl3I0bddMiO6pAcUggS5CDs9UHqjmOvYUZRuh92DjtP59u3ZgWxNRYiZKcXb1WQU3UQtr5aJgcXoOTBWnlhkBkY+vUp8qac0GlsEQRoJ8WYeItdc5oXvd6YhxLAyHzPxnPIwpPQ+T7VDBQK2xK5rIQfwHKEJ0bXg6c97u4/1MsuC0Mbe37DIDN9+FTioTSFpnLfbIOacpuJm+8sVcWoLN7J6u7NWQDsWgV5r2C/WJzdvQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5686.namprd12.prod.outlook.com (2603:10b6:510:13d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 13:01:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Thu, 30 Mar 2023
 13:01:22 +0000
Date:   Thu, 30 Mar 2023 10:01:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "xuhaoyue (A)" <xuhaoyue1@hisilicon.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [RFC PATCH for-next 3/3] libhns: Add support for SVE Direct WQE
 function
Message-ID: <ZCWIIK2iC3MdrJO1@nvidia.com>
References: <20230225100253.3993383-1-xuhaoyue1@hisilicon.com>
 <20230225100253.3993383-4-xuhaoyue1@hisilicon.com>
 <ZBtQ1/3WjWNXAT/b@nvidia.com>
 <53ff5576-3469-1264-aab9-6eed7956238c@hisilicon.com>
 <ZCGSXzD8LJqsXHTF@nvidia.com>
 <3789bfe9-f96e-8d87-9322-6f1476757704@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3789bfe9-f96e-8d87-9322-6f1476757704@hisilicon.com>
X-ClientProxiedBy: MN2PR10CA0036.namprd10.prod.outlook.com
 (2603:10b6:208:120::49) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: e428aad5-481f-461d-a995-08db311edc51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAVGaN0w6mm9LnodLoT+cal8LGcwjS0TYP7aQ09g0oMxFqmlfYOB2skFRUW0WxQ9VogQzfJ3HaD4D7INWqKWiJs/EulkK5u7W00VVttobroKu+e0Mvfjzho+6qdVMFYP2lqsUHQyrvKiOxnjMyXd9Mk8OiBfpiy2Uv1cejonTwEsZ5+5QIRYpxJnKZ3G24IYPdlkVdk6iRTcmgxGpKmwBjVtdJ/NRyQCyjGTPX0FiW7NFnQ4s710sJtazrm2Nr5J6rIElTM6ViKIK19bn8yQ1+h0CfZLoK9E/Z/8TnBoHUo1D019tppWQO7ALDly5MMyCEp0PXapzkx1fCiFtX9jyw/R+i85InJH21Od82/oleEjLfiaiG2Cc6AXcqeN2EDs3W2UYCZtv/Xft89ghpKYBI/ApLOvQNLkk/hUgSDc6gYAq5Dro9h+t9J8uow0rVotIBC3YpOanGnjn0U4NgrKuv1zVcYb3yPE83AS/SKO/6QL81vcv3/Nm/bmVpvqA+q1a0DQ86SMlOL1uo1HyaJ+ekC1hLhCFJIXaRLqBuA5uujQU+yzAReFkUPz7Pt3MMwl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199021)(38100700002)(2906002)(5660300002)(6486002)(8676002)(66476007)(66946007)(36756003)(66556008)(6916009)(4326008)(478600001)(41300700001)(316002)(83380400001)(2616005)(186003)(86362001)(6506007)(6512007)(26005)(8936002)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ghoxPma+jA48HFHDmusDvDoh3S/c+Yu3CW8+M4t1dbwlstJzRe3IbOCljUkU?=
 =?us-ascii?Q?UhwG5RbqdE/VJbl6zqgnPxlLbTi5ZTSLQmJf9FfBVNYrduFvll+U0sYMfJKP?=
 =?us-ascii?Q?ny6DkToJ4illeDqfj8f77WAhXqQOMswrh3+bkApWFAcqbO0EdQFsRo62axje?=
 =?us-ascii?Q?U4Bz9U+M34x0K52yJwIQBhSefQobvVzLiTPDxRdxy09J58+MRudGU0XPGjtF?=
 =?us-ascii?Q?m/wbDZGVKZTminqtnOoKOxfM+iWHNMhDcBeiyiXlXScgXRwJ+fp2z9fzrLmw?=
 =?us-ascii?Q?9TaNhfCavsDD1nzEttxMQ3M5vzksUAjEuErkJs5w1uxRUqyHaKFGddNgLOPJ?=
 =?us-ascii?Q?mB/uMLwaH+kOxJhRBG7Y6mcp+qAUQ0cQueSo+3FOLas/3QU14gf+ZYDaw4DP?=
 =?us-ascii?Q?wupsv/fAc6/JUpATmf+FtQuwc5wsJatRf91OD+Hcxl0WMwUliTSCOC2Igqi3?=
 =?us-ascii?Q?bggTjr+o2LVsD4fu5TaePOERrenuIldSbrY91dyl6XAhy8FoSrbLH2Zik/D0?=
 =?us-ascii?Q?stccROx9qiZeZwitIJyR7b6lVp6RiM7LT/cKGQQ0qLhnmx6s9L0oG/RS/imA?=
 =?us-ascii?Q?26BdQl442ezcDlCvqLiDYlUs6uAPNOSJvx7QWpGfgtal8iL468NW3GdEwDFE?=
 =?us-ascii?Q?DCwwd8XVroXJmsEHh4mMFMKQjD1/VMJCI0my5XclWUXqB/gNTLCjXGjqzaL+?=
 =?us-ascii?Q?UIcmKHRGtVxXlrZnGeEBHSjORuJ1eKx2GPB/Bkx4z6RIaG0k5IBqXYaCL4SF?=
 =?us-ascii?Q?0ubjP4S9Qg/GRUOXCEpnd0w/ezXJk0o7gQQRE/4IVQQ4835eBWmZ3aGTq+OS?=
 =?us-ascii?Q?p9u7tM1kZ9hKv3jfHIkxT+s8GIyfmLEUEId2RuwCP188ETX5RPYMg4NQIIiz?=
 =?us-ascii?Q?6qDRPtTz5ylHX/nUCFh0SoK1v616qQNMjLb28QvLxxOa0aYe4/elJWv2V2ak?=
 =?us-ascii?Q?0gZtXPegv4tEa/JaMqER983qCBJ91tBBAkqIhShyv09Z203KrqOR9ResNQ4a?=
 =?us-ascii?Q?jf/IKrj5o9RpbHkZIXEiw6U6/75Dfaum8xLLy57mBk2MOXk5r9+vt570mup1?=
 =?us-ascii?Q?EmjA/kgY+kbSgm/KBApATNUwFFFPn0J8XTDCEZl9sklcBtsSlEG/esTQ6WJO?=
 =?us-ascii?Q?hwE4Uwac0amOVmYJPgx5P0f3AD6Kx88QoZkE10DaUi2sFiue8QpdFqT41xYw?=
 =?us-ascii?Q?oE9k+ezJzD75l2VmfQWFqwEUH42/9tK9afuCVHrODHPmuFuSUcUddpLPzxqU?=
 =?us-ascii?Q?kTU5NVY5wO2//WuWgXo+iKLovOvzo2pajnSPPedX8PHbNLRpsPQftxDObCoE?=
 =?us-ascii?Q?MMDH0V9GtJQ55CSOFJxCctsii2BU8gXyozhebDPjEA/RnX9eKO/hjC1v4OAO?=
 =?us-ascii?Q?oVT3YkeKsNycJlrbqQCde6gMhFq6cVdhF0WYTckJio6/oUq07QdYm5hfSUcT?=
 =?us-ascii?Q?SuYF0frldOuUDsxP96yAXFOjLTFiK6RA4S4fwhg9SlW2fxkJzx5W2F/JK489?=
 =?us-ascii?Q?94YSG0kjroivMQYfYMEjEk0UqbHfXp/KzBrr5HBDEd9hcuf3NxEFVXntSAZW?=
 =?us-ascii?Q?O3LXynwAvT6S4vk6XE5m0JGnDsRhJS4Ei8yyzZnL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e428aad5-481f-461d-a995-08db311edc51
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:01:22.0207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NfttTnX/TKVa1nSGhPeRMJD2yowSHTDCwc+rLQ3bvosnFSqW2/N6qCdHf+Y3Ylq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5686
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 30, 2023 at 08:57:41PM +0800, xuhaoyue (A) wrote:
> 
> 
> On 2023/3/27 20:55:59, Jason Gunthorpe wrote:
> > On Mon, Mar 27, 2023 at 08:53:35PM +0800, xuhaoyue (A) wrote:
> > 
> >>>>  static void hns_roce_write512(uint64_t *dest, uint64_t *val)
> >>>>  {
> >>>>  	mmio_memcpy_x64(dest, val, sizeof(struct hns_roce_rc_sq_wqe));
> >>>> @@ -314,7 +319,10 @@ static void hns_roce_write_dwqe(struct hns_roce_qp *qp, void *wqe)
> >>>>  	hr_reg_write(rc_sq_wqe, RCWQE_DB_SL_H, qp->sl >> HNS_ROCE_SL_SHIFT);
> >>>>  	hr_reg_write(rc_sq_wqe, RCWQE_WQE_IDX, qp->sq.head);
> >>>>  
> >>>> -	hns_roce_write512(qp->sq.db_reg, wqe);
> >>>> +	if (qp->flags & HNS_ROCE_QP_CAP_SVE_DIRECT_WQE)
> >>>
> >>> Why do you need a device flag here?
> >>
> >> Our CPU die can support NEON instructions and SVE instructions,
> >> but some CPU dies only have SVE instructions that can accelerate our direct WQE performance.
> >> Therefore, we need to add such a flag bit to distinguish.
> > 
> > NEON vs SVE is available to userspace already, it shouldn't come
> > throuhg a driver flag. You need another reason to add this flag
> > 
> > The userspace should detect the right instruction to use based on the
> > cpu flags using the attribute stuff I pointed you at
> > 
> > Jason
> > .
> > 
> 
> We optimized direct wqe based on different instructions for
> different CPUs, but the architecture of the CPUs is the same and
> supports both SVE and NEON instructions.  We plan to use cpuid to
> distinguish between them. Is this more reasonable?

Uhh, do you mean certain CPUs won't work with SVE and others won't
work with NEON?

That is quite horrible

Jason
