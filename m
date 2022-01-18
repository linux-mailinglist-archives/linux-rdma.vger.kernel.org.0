Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A514925C2
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 13:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiARMfK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 07:35:10 -0500
Received: from mail-dm6nam10on2079.outbound.protection.outlook.com ([40.107.93.79]:29113
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234397AbiARMfK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jan 2022 07:35:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkKcD3ppV1QsKezi6VYNxU3g25/RmWTWdlUpdrhfm4M98Hp/vhzD+KfQ7HQOYyY/lj1y5xxloZqYymul43GXk8aoi4VcLzgNx22HgxfM1kprpMNeGdqidQsXkO5FSbanSgg/ZBRqKoDfR+0shkj3UIdLZ/w4AaDOvwfhc+AMBMtCE2EaaJ5CP1rOSFu796kdgIKl7kfP8ZB03xwQtW+hOsCFJLukzYSfYLkrc9dclfIx80zgnRRZp4jUTZvEnV/MSu4yyjsY5TCZbwEhif8pnRKJjV5voAANbAcqb8f9eh+1SbTZcEFQfpoxiAT9+UG4H8bHSxZAcY66hC5MUFNd4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2DQghfOu6lwuJhneHOaMW5o42IhfBzhA8KCMwiAGK8=;
 b=dEre+OnJlIh+bbxBft8Y8TVaKTKlRhkhZGbwcXgfoKBrDECh1YEc3rWds8a8Fp4h0xnqmEYUBolhFdobiMhK7K4df2dVZN4mUWc1Iz/W0wObej7QNK7/ayF+zOeRm0NeK/VyKtZftLp9IIj2+G3ZuCVnxFxdbyj2kf8litG0NhzqUqeWxmrqWKc5ZUHt34WRjOt7LTElWHD1+/1LCnYtKjyoET1c9kGm7Gmh4XKN3kbOPtDN7u0joHbK1zmKgSsGG51fifP4m+HjR824+o0iBEJ0vTfIBBZIe9McuSo458PWdt/qq9ghZvBfH8cO3xPhmSnBNqDXYC1JF0SF+hQEDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2DQghfOu6lwuJhneHOaMW5o42IhfBzhA8KCMwiAGK8=;
 b=d2t/X0JhtO9QlQaccN3Vsr+B/Z4DBK2zGe3KX37Wsr/8N2k/2IG1syJkoIbMBrn2ZJ0DnKs1TKzT3peBO/2gZJjMVN1NHaCH6ivQD9o2rVdysyhDOynxQ9d9R83AEtvPtjD3DE2vDrnvP1pcw0AVRbWX88irSlN2jeY2fe8D8Tz7M5kAOGra11/C8iXo6eG/PdemH42burNHJH2A7UOOFdtQUgx7MbTOpKTm+5/05Z0ermxOBHV6dzfgSGzQUhTFmA0J2i1n0EZyAReNpM/Weo305Oxxiw0xSff0smbzKUSdWdOKMLz5xLhBfFwwPmHPVufkGTaZplZHtR0rJsygEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 12:35:07 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%8]) with mapi id 15.20.4909.007; Tue, 18 Jan 2022
 12:35:07 +0000
Date:   Tue, 18 Jan 2022 08:35:05 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "tom@talpey.com" <tom@talpey.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Message-ID: <20220118123505.GF84788@nvidia.com>
References: <20220113030350.2492841-1-yangx.jy@fujitsu.com>
 <20220113030350.2492841-3-yangx.jy@fujitsu.com>
 <20220117131624.GB7906@nvidia.com>
 <61E673EA.60900@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61E673EA.60900@fujitsu.com>
X-ClientProxiedBy: MN2PR06CA0021.namprd06.prod.outlook.com
 (2603:10b6:208:23d::26) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ede6bd4-aa19-48ce-c946-08d9da7ef54a
X-MS-TrafficTypeDiagnostic: MW3PR12MB4348:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB43485A43458B1652BF738E01C2589@MW3PR12MB4348.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XpVENRU7EmgVPqsQVbiRq3XaZ/bboT5g5B/33T08ORqMsS5Dip6uoHuMbj8qn7pyVvjR8cH6uagg+v4wK1WEbjmGWIMKOcfclAcbAHtqsCOuuodPPiJot0G1/zCO0huaEy46Nx423a3C7ORtA5E+/0ZegT4mudEVKQMkWA8VWZfNTkb3zaUm2Xrz7YBrYEdfEvPrS1avhOongUXNAbd/Dy5whBC+A+e14WljIVRUPDDD8Air+i46jKl/H9cLVBO9eDfdE0hx8elHPvvaI24IRg58z8f/aPTzew0aqc1Kcee+H78P5FiIZZY2WelWEXvpTOxAQcfaRPclkQ1UZ28gMo4kICHE73i3NcNBMiGVFKO9Z8Nj+2C+kqmmpMihUot07Xf9fDH8PN2jgeiUz241RnDQfB80zzQKJs8/KcxFs6lS+yEtjb8GPfG5GKKfMyMUlUAbpvGIOdfF7iSF5shZqYtE1xu1q/IPLOO/cwVBPZRDIoiNx/Xn474Fc7EGYhRmy1emAuLdB5etzD2zSaLB6RQOIf8lM+oxpr77o3XiTsz6EtU0ahV9gjuuQUMlWIpPvIeivVgGSHFutegAa5xcpKRgWLp8X1Ajvsmt49J0WqJyyLTLpNy/hZ2t/WZ9LU4GtvjCME+RkC5KJi9F1LegjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(86362001)(53546011)(6506007)(26005)(8936002)(4326008)(33656002)(6486002)(6916009)(186003)(1076003)(36756003)(66556008)(66946007)(5660300002)(38100700002)(4744005)(66476007)(2616005)(508600001)(2906002)(54906003)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Su4YjKdljWlcpLVnPLSL1YbNwdkgirfAqC/0zonm0YXca4iDa1bPPe47TrH?=
 =?us-ascii?Q?0om6eeEBA5yfqrK8iTxsvjOEvoG+o5TPT4caaHJIUXZdaBp0OlTFA5ru0WJO?=
 =?us-ascii?Q?Hr+xB1zha/fDcDPouhurqXIGt+hpXC+aA8GJRF3S8Ks/nE8kLGW0tAGyCyWE?=
 =?us-ascii?Q?DKoHCYyUJKkI4XXc6h7TWVgZ1/rpnkQgam50Bvuki8EZUBBM6TruwNtKvHDC?=
 =?us-ascii?Q?bZjeoxMh94QMkN3eCiU6uC75YWS6+loK42iE65XnlbOMW3GpmD0p736M0eR6?=
 =?us-ascii?Q?SBSVSTvf34fOJRtsYcDjz38ecaLJjvanDSeqbVgqGXaxXAi6oYoo8QG2S96G?=
 =?us-ascii?Q?hqjt1ktHrPnowOJAunBnJ7GLA6RN+yrETVXNZC/AK9BB7qTbPxWEsoNem29A?=
 =?us-ascii?Q?A/wUgG2z8vmISmB0oeZ/RiYwNuVrtPJ2H2K7QhB8OJq/T/BSzti8izTV4/Zx?=
 =?us-ascii?Q?3dl+mmkXeU/rZDnPZiVspuAlLCRfhQGektK9jC+leB3soFzDHiff56xKTHFn?=
 =?us-ascii?Q?WO6UisFBQxLNRyL1SP3XSWdIc/rmKn7LBGvhPVa4IJbgDZ/v/mr6d62YRpzc?=
 =?us-ascii?Q?motAIQZNLRmy0/8BKQXghQ0PRNcrNd/zW6mnqPWz5IXYFIq8QMx+FJOo4zLZ?=
 =?us-ascii?Q?DORd6wMa6yF3VUD5khh6uMGRO0fsE2TZGe7Ie9L06fVS22lB6paxpNHNmRIb?=
 =?us-ascii?Q?V05Kz/c0qdLMwC9PeRIcpDGvZ+lj95FYNtIlJqBb1wF87dWuQPekjBQSeDRE?=
 =?us-ascii?Q?v0sxBUszYEuMSzALLge41iSIjRQzlHqFuOYajs++Wq1klVT5y1yWXz+0PiW+?=
 =?us-ascii?Q?O6zz4xkNG643foxTjfG7efCWDCbk85r7tcgKeKrIDlwoVsMLoFQUI9GiGTdw?=
 =?us-ascii?Q?KorQYjFdnTHRhUZMnrcTGLAR+Xo/SbXpnV8EJea6Fn0W/Dqv02HcmOX8kYZo?=
 =?us-ascii?Q?wuvaLUxgooRjiIcOaKbzkl5qPbOQ9bavh4MXG6bhMMIHm2JOnpNnxlymPVmf?=
 =?us-ascii?Q?Ia+MeoeHKYtF3HbSXdCVVXkgeXRO4YWyIZggcWhrIYV6oAqSPqDQIH8khBEl?=
 =?us-ascii?Q?+mUVthiF7uNSYxVK1m25TJa+kL/PW5dM07wrEU9yq31+DWMnbIdH7kbNr+U1?=
 =?us-ascii?Q?vQRhWVxkHLkBDf4BhXO9oJ37Z/v/aJaI3IW4c+mWjolkPia0gTiY3K5eH9aA?=
 =?us-ascii?Q?DKw4teos60k1Xta9CV/oQNyYy+dBCHg+cyVuQpYTqHdeJ393XrluGg1JtZwP?=
 =?us-ascii?Q?V9QfOjJXtFwLaSpWvaXWv1BA0Mq+a49pafkem06H2KAld43R9PBxiedJanBn?=
 =?us-ascii?Q?L2BmKIoEpANtYtgLX73Ym8SjLUrtfTKDXfKsfzJvwqXvTrROt0OZmQ90Thmt?=
 =?us-ascii?Q?tzBxAwQ40holBdUqbfFBFaPTGloCliKo/oh1ZAargSin241nNioX9Y+sLNPi?=
 =?us-ascii?Q?hLR2OVlM8Z79UdC7Cb1Nb9jR0nndmJsNGNnVCwZg0wQ39j8PSsUueRGIt7rE?=
 =?us-ascii?Q?tSceGIYxoGYdmdxhxM+TSxaFU0fV5L8vGc1T0OV9l8vkMGn+2Rn7NEbewIwJ?=
 =?us-ascii?Q?Z+EzWCHz3JDM8Wf/I0o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ede6bd4-aa19-48ce-c946-08d9da7ef54a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 12:35:07.0376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2YnuXoKqOKxA/HFWfzfP35q9AAxyVq1SxbcQgksnbL5veIXFtDblxoMz36M7aTz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 18, 2022 at 08:01:59AM +0000, yangx.jy@fujitsu.com wrote:
> On 2022/1/17 21:16, Jason Gunthorpe wrote:
> > On Thu, Jan 13, 2022 at 11:03:50AM +0800, Xiao Yang wrote:
> >> +static enum resp_states process_atomic_write(struct rxe_qp *qp,
> >> +					     struct rxe_pkt_info *pkt)
> >> +{
> >> +	struct rxe_mr *mr = qp->resp.mr;
> >> +
> >> +	u64 *src = payload_addr(pkt);
> >> +
> >> +	u64 *dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, sizeof(u64));
> >> +	if (!dst || (uintptr_t)dst&  7)
> >> +		return RESPST_ERR_MISALIGNED_ATOMIC;
> > It looks to me like iova_to_vaddr is completely broken, where is the
> > kmap on that flow?
> Hi Jason,
> 
> I think rxe_mr_init_user() maps the user addr space to the kernel addr 
> space during memory region registration, the mapping records are saved 
> into mr->cur_map_set->map[x].

There is no way to touch user memory from the CPU in the kernel
without calling one of the kmap's, so I don't know what this thinks it
is doing.

Jason
