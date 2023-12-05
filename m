Return-Path: <linux-rdma+bounces-246-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B17780431F
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 01:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED23F281310
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 00:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A3D377;
	Tue,  5 Dec 2023 00:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O4ftfLoS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E15B124
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 16:08:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEAKn9RuI1jCRlqsjuStrk6qruSPKnM3l+EWG1tw0eC7GYZUvYEozDo6PQCD3SGw+HJyKsgZhFf2bAA7S1KqeoPEKbw2rhqmVkq0di3TLWL5VbjWAfJHvmZd9w28rWDp6svBU2mCDXjYkb05pFitM0rS3Af2g4/gmEpzUDxYM6KOoTUnWrCqTncpK8MOD+jRVJkrxo09WRfWyXhaHpHthiMMe3vaXTsbZzoV2+C6ynVu6yfPwWhIOJvYgNJVyutkKxsLUoc9E9XwNlT4OnOCVAUyuMv4a/CacOCJ6EfpoCQmtyU0oYwoYYXikNF1fGlmC42vMuwTXd9KQ5o/0gC7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGO7cCZOHbpbBQEhht3AC3nV8xT/uKznf6sFvXfoZZ0=;
 b=iijYpxL2fUB89B+GaoL2Pl3Mpf4Kv/CzEGVrk8yfCN7usMb0Rv4p9lzX5a5TBjuv03efdqenfQ9umtnc11X5iklWb23vSl71P11JfJ5YT3Oms92zfGjUnIGphfZKqtGM6F2d2j490To2q/f5qw6y/PVH15hHeSxzMsgcLEdfnDPwKmc4xIglz10Y2ewjm4aDd5hJzzUEH0eAQhvoUO+MOvMm4gPqUvLEvRBXrxMEz3T0N8/FCdrk+/tCJqC0kSIgkwhMlH29MIFQLAK5HzM8Kkx+40Ek3Mp4d5EQTbqNjgozgBiiDCCaxrenFHRrQj/TdmQG7fbBZMG8iUo/23xKDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGO7cCZOHbpbBQEhht3AC3nV8xT/uKznf6sFvXfoZZ0=;
 b=O4ftfLoSVaSMQMg7+10ICQ/kT4/wg8sZovi6bkftf7rq+hflwyigQBUcuAiXCs1jYe9VQQKAk8YBb4yln32NNPy88yC6P53GbPxJHc5ItkMIyj9CMGEQtl/vMdo7uucvSBi5IXEsu0iaWXvJbRczmjQPL5MY94H9tJW/o1Y5VYRTdviS3q/JLjW/7Cc5yD2s0ix87A6aZg7Ji+Fk7pwoTHF4Je3NUoPPPi1/3tTjZNoObviWHb7sDeVVaSxb6uDTysnmzPEV4QPWLCqORg8i7Dfz5LmduIDKzqSIxQ0mdjjTW3HL4nUbvCw0ziyYvh4iFM+t6vLoEHiOLjsIDLMkpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4529.namprd12.prod.outlook.com (2603:10b6:5:2ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 00:08:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 00:08:33 +0000
Date: Mon, 4 Dec 2023 20:08:32 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Bob Pearson <rpearsonhpe@gmail.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, linux-rdma@vger.kernel.org,
	"leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH for-next v4 0/7] RDMA/rxe: Make multicast work
Message-ID: <20231205000832.GC2692119@nvidia.com>
References: <20231204200342.7125-1-rpearsonhpe@gmail.com>
 <2ce139e0-8fd7-4ed7-af5e-83a9e4b55710@gmail.com>
 <afd3694a-695b-45d9-909c-b28b99a09d24@linux.dev>
 <e91c7ff8-9c67-45e8-b28e-5bfa8c9e97da@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e91c7ff8-9c67-45e8-b28e-5bfa8c9e97da@gmail.com>
X-ClientProxiedBy: MN2PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:208:c0::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4529:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a1a4a8-caa8-4814-af0e-08dbf52651d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i306fKsoYqlbDZgCWYT3LgAEudS+IKUK5rHqrw9qGHx68p19lCao2Gp+3Cg3Rr7jSKkiVBvdSrSQFlHt7UUtraI8DBtHW4bUFtGjJoLS8oQWQChKXaZxPjxUEuzoIgdBgopLUtnfDlHSGCzVhFC05rMW+C6idoHjFgEvUvL0Dw/SSSoNQiv5V6p8L0nbun+WfdfineUzKu9SNOOk0d6yQ317ROJfHp3NsIj0VlAwqCvOJdVQO63WFrhTZamNJ8A4YMzerTC9NPPJChwkscxIv62Q3/SxbN6Mowf76wsVc/fBiCrNByE5dwn8P8rwKS8bfmpnqhRILkttIobeiL1+em2aklunRIe80sIBNwkqZjao5fMLnXVKm/g9+oHeSsLZYrHXpJ0p17Z7gS0tsbc23VvTM2YQLAYE+nH9GD3/BtgvE0KPsRMfX2AcHE4+lTIxVZX8pdjU5GyaaWJ1yNi1pFfGItI8SG4DMM2jnZ1X6yXx9m8NvoHAtzCMe+2Oi0t27PjzikETSvOD6+22kkQq17YSAqS2/cvupUO6rUAwFIQ33l3v6iL4x7hNE5xW1r/E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(316002)(66476007)(6916009)(66556008)(66946007)(54906003)(6486002)(38100700002)(2906002)(4744005)(5660300002)(86362001)(33656002)(36756003)(41300700001)(4326008)(8936002)(8676002)(6512007)(6506007)(83380400001)(26005)(1076003)(2616005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yPlynAIYZfVHPpckhS4kGED8UWmeMiF80bqB6lb/ycg7oUjsmBGCWdxuVpq0?=
 =?us-ascii?Q?OfOeWwGrYnSHNMPlqADtCC+JZ6L1u5/rdM4tKuUJ9z8Y3gGx/H8aQI4T7ndg?=
 =?us-ascii?Q?NAX/hrBiTWHqqRQ76iC4Wc4OP5ZsvGU5e0iiu5EYrIn/9DH5qHNdY5ndxOpu?=
 =?us-ascii?Q?YTvIu0xG6ukgUZKW7sSoYrlQEaPqxWqNKDcfv2TCKe4NMOpyjwioxuXu17kf?=
 =?us-ascii?Q?CFhFXcVHtfahNwwfos/CynVhzOUSVllFXZdArYnowsP1NI7QHmEcYouS170/?=
 =?us-ascii?Q?KZb2EuXCHLiaH2/RKcXkKqyz9OEomT/RuqlUTuRlo4/knjLvEMsHWZMSsPAV?=
 =?us-ascii?Q?1shyh1aTzANv9IuInrG420DssroDni+7PmpyofU94Vpje4LVBHqcljj6x5eF?=
 =?us-ascii?Q?mkh1VzpTCBzqPPj/0LhUoFtR9MdKt2Lp3c5IUPlOYREkaQMX+/M67jGz+KId?=
 =?us-ascii?Q?1QYSTXrlpx4iR4vw9Oqw0IQMnXObIzLO97sl9tkvPpd1CkYAr/s0vWCRoaDi?=
 =?us-ascii?Q?Sow1ZkpMmGyYb9SyxHU9vabik/MV8Q4pJmvficnOuYS413duPDiL004XEPpD?=
 =?us-ascii?Q?bGV4ADumT9lTwavi2SBCWRpNpPbh79bBd8JBi5mpruR2W5ZdX4gujzSO9NoB?=
 =?us-ascii?Q?lWkZT4OG4PrPAZy66By+ttIzfIGOwg6qkeFbTkQ1Y9BcFWOKhAh69KcCuuh7?=
 =?us-ascii?Q?AV8LZNTyXW87EDBcAwGf4RppMRSyLaog+bonZh79zN3YnbbPxYPsMHz3DPw3?=
 =?us-ascii?Q?rjYkznXqZG4KdOSMLPPgPguaNsFeMc1HaioyBOOVSn/rbBFTwt+jY6w6Fu8v?=
 =?us-ascii?Q?bvoYGVNWsi9TKbLbs9yUh3AXN88gmc2XwtW1Z/BFAx8IBbCQHJfJJzvw6Z7n?=
 =?us-ascii?Q?FtS2APEVv9LcQdpLPKWfVpB525M1ns7RjFlAKS8RrPe1/Wu5fc7tMi5Cxihk?=
 =?us-ascii?Q?6kB0aOAOxKj0ehdGKRmHZDhSmvr97vYtGUwWep0ER/VV9q4WBFL8AWqLlC5c?=
 =?us-ascii?Q?ea+uH9vH20mZpFyUu2IG7nEWxmtWeYyIptV/JvmHVcVuR25sfZ9FG6WHK7V/?=
 =?us-ascii?Q?aVm9cCp1bKS5qHryqlZZccb3ByFvmpzlnshksGT33vNTiiJDhpf3hHEAaolv?=
 =?us-ascii?Q?6AOBztfoiyWqB8YgMk1QBuki1sLlmQdi9ONPwP6gLWZEaqUnm0EWMfeTWmy1?=
 =?us-ascii?Q?qEVVTPvMNhfHLsFpICIuGMtlQ4w8T6YhyAQMO32y2ztyqQiXy/fKTBTMzeE5?=
 =?us-ascii?Q?rANN38CNYasISIR/Shmn+7EsgnJHSCkugsku7iF/XSyc7rdLXl+goIEvuSf0?=
 =?us-ascii?Q?yC+lLdp4c7LoCmKYi1OeuFO1B1t5dZ9kdWjFSUV+Avq9fVXeVCiKMYC9bUIG?=
 =?us-ascii?Q?QhKVFHfpyWjV7EzD+S4wi9Jkl/P5sqy+7QSYR/LAOQ18KM1l9aAVrSp0C6b0?=
 =?us-ascii?Q?nEE9TOET7A+/jK/gwEIg/dpCXN4Bi0k9A8uzPn5hHt5dr4DP8E0W8tz6eUKJ?=
 =?us-ascii?Q?pMDX2I97JId0FJEpJQSf+lDbzfw4MKY5Agz/KDIRZ8ikMh6tYttI+QMzlXKU?=
 =?us-ascii?Q?Pp6DE3xYQIk4vUUBbb+mP0DoEsWXRnAYN6sIengQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a1a4a8-caa8-4814-af0e-08dbf52651d1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 00:08:33.4271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CeorW5b3G5vzsDZ2SLhP7vLdrxmEZU9AutHa7pAF+SMgju65Oo1vQRlJQoUoxM7I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4529

On Mon, Dec 04, 2023 at 06:02:55PM -0600, Bob Pearson wrote:

> After rereading v4 patch 0003 I noticed that I missed adding locks
> around ipv6_sock_mc_drop() in the error path in rxe_mcast_add6().
> Would you rather I send a new v4 patch or resend the series as v5?

Please send the whole thing, patchworks does not like it when
individual patches are revised

Thanks,
Jason

