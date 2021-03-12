Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A8A339001
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Mar 2021 15:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhCLO2F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Mar 2021 09:28:05 -0500
Received: from mail-eopbgr690057.outbound.protection.outlook.com ([40.107.69.57]:47595
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229959AbhCLO1u (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Mar 2021 09:27:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajBCX61CP+rsydaHrjak2pRGiBI4pHDwjk+Lf+i4AsvXvsJ1We3RVLbch9IEDUQ0UtKmGozU7C35y7C0Cu8qwq+7EZ+ktXiFLmv8yEx4+7Z0qWrvpWp9ZZfOar2sRS8UxmIpjAeP832zLv5V16voubuL9t3L1V9ReL9zVf1RCT3mqRh2rhQ2somqaLNnYpFXGygagW32WTu60l2c0Tn7cYtGsgHPJ+rb46i5Z7mspvwfSeaU6BZYxaoZM/RktV+NtgrrgyQL7kgd+gFOGR7VQbf1HtmIw/2kOg4yn8Y1Z+cbkhC9nkWAlgMu7LxF7pIrYno4eiUG3AYJsF7R5AihVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bl1ib3SbPysTbZ6t6DHneT2Ri76xDBsNwFFnqV/PUIo=;
 b=Sp3RXTcMu2gPqaSBbf13OWPdLSScgLCVqi06mKG+EOesrdtNzx+NnkI1xNUngy8JXHFGj5ty9KN4Bm4oqYaHL6n9cuTUoKsivD7ARQ9DAqDPspEDqDBktSbiEqEpISBGt83J039qroXB4YTdcSi3FWiW1R8441i0K3Pu7OzzMeVvwvuPG+aaHmipuG/VIGTNMR4ZfZHyRhKirj4UoKsxK7VnvypdyPMcxIQW6D/Mq6mf4Jg/DC6JcfkzOX8OQPPP3ENqPfzOq90mrk3FQAOakO1N/w6dHqYU6H3NNk8S0pef1WWVXdujN2rtrsPwA0S2kP3FGV1f9MzCGlXtHL6inA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bl1ib3SbPysTbZ6t6DHneT2Ri76xDBsNwFFnqV/PUIo=;
 b=chRcV2q5llMMSzbcgwE8/ebamsS6EBTM5ugvnTjQrIkBQp6D9EUs8HzQjTU0KKbi0Z3Ilp0mWQvmEiZ+Dq5/of/2t0KGIRrWvhRfRtRy6Jo1vvr2O0kDWhK+bB47U5ikXBiv0x5HaVifoDFss5QUxCXGgNHsoy5qcAu33URPxNbUMIWvCDvfXLbi1FDJEhuap3aFKPVmwPZPdovq5ymXFzkURyamjST0lofVNABBx1RLW2UR+ugErme33AOXzdPDWfteU1LC1P1CMXqCXMkynMpgg/lETBWJX7Zh3Z4ln4nQ1qQzW8ahhAlsCUk80NSm5VtVH2MAOqnTwY2u9BbZFw==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.24; Fri, 12 Mar
 2021 14:27:49 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 14:27:49 +0000
Date:   Fri, 12 Mar 2021 10:27:47 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH RFC v2 rdma-core 5/6] libhns: Add direct verb to support
 config DCA memory pool
Message-ID: <20210312142747.GB2356281@nvidia.com>
References: <1614847759-33139-1-git-send-email-liweihang@huawei.com>
 <1614847759-33139-6-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614847759-33139-6-git-send-email-liweihang@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:23a::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR03CA0012.namprd03.prod.outlook.com (2603:10b6:208:23a::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 14:27:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lKilX-00BvOn-Uy; Fri, 12 Mar 2021 10:27:47 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6290a26b-c571-45a4-67d4-08d8e5630316
X-MS-TrafficTypeDiagnostic: DM5PR12MB1753:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1753BCC5986BAC9894564555C26F9@DM5PR12MB1753.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NiL7weCRyfchPKuKk9TjujwAJcNx1YcArykw3wXaEomDErMgbHobKB6vCWMoJqGCSnU/nn6BWAu5Cxbs5+julZsB4Xr5KkwmNVcay06VxcQqenDDyVHA0Etw6gGg8jJhwAD/dKEWS9RWcdDfMubUnU9/O6T5WbwMX2tE2qp9Br5qpDnHCWDGeIHzwSbJyd19kB5fgpoMeFq0ZpoUQMVRyq9jnCMQdPJu+pDx8z+E1TQDiAKOPh5Co5beOMbHtQ68Ax8lJebIHC2W68ot3CGzHPPdsnro+D1PJkJfCC3zUvrCj68JJYcNw5+2DTC/3/mYf9uLGrzxoNuU+VJrI59o6Xx1F3SnTFSTmUNjhQzXvCrOGknrJgbFX2Z8gHZqizFn0EyruBPgfi0VhzJEfzwQQwgWakh6uF3EzCT65L57uJFzaDMq6TNw0MrhhspgUobyVIkKsJAr8pfbCKo+hrKeNbpVa3PaaZvyY1KBEpmgA7MV6zW3xvbMowooZUvcP4CFT5GjcojArZ0YY1L1s1WiOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(1076003)(478600001)(2616005)(5660300002)(33656002)(4744005)(9746002)(2906002)(66476007)(66946007)(66556008)(4326008)(8936002)(8676002)(426003)(6916009)(186003)(9786002)(86362001)(36756003)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bgbTm4c4QYeCQJxiDrt/JJRgM3R4Ap37txa3ktcUM+tBzi8y7AC7Tv4IaO7M?=
 =?us-ascii?Q?I/1gTWosP6Kv8jSDd97/49aFNHyLFURIahcJ6N0TaGmZxQ55Fah2ffYlP91d?=
 =?us-ascii?Q?jPMM2WV39yGG9nYDBdMPe5wnZRpJzvFWTkUhkG+VZ0RDC22+4eUlGEXFJJV/?=
 =?us-ascii?Q?9B5xvz+nNnsWQm2sI1vedwo+HkEJMgtPmoCpjWCU/DahdHjvVpF77qU9tSK5?=
 =?us-ascii?Q?fQNZKcgb2Yzuc36mLloYFVvH5tVjAMC4P15rfZPHcJowSuxMJT90TyHSnhSc?=
 =?us-ascii?Q?ojIIA1DDBslwSg8PiJfOJZoTlOiCYRWF4UQ0tLWuf7wrmNI3G3SgNJ/PEYYK?=
 =?us-ascii?Q?j65DmGAyjCTTvO+RHdEgDY1gfvW140SKbND30HiFgSzMyFozQnzZBU0sErPe?=
 =?us-ascii?Q?F/9koLtuRAMdua/KoRnQ0+Hh13c3BHeAB7oTps8iDrqQNTC0RtutU4Omcbbd?=
 =?us-ascii?Q?VPAH56umHm+jXFMYLOF2l2LfiW7CGJWJlO8ICLMMggYupbfUsz4ZBnh4JvZG?=
 =?us-ascii?Q?Ywck+XVJDli17ImttA7+dMgc+IUlXjfQ1T7de8tOBNRDrynN14RzehMEoR92?=
 =?us-ascii?Q?OwzhUJ2uz4YMjXu4f0wnr3jdWQopRJUxcc7vQAcSAbtzEIhoPpmFaxbLpa16?=
 =?us-ascii?Q?zm7SB3fNl7dkTtQ4b8G+bUa2tYLPUqhva655jH9UVjkaxPH9XL9qGR80XPXf?=
 =?us-ascii?Q?2u79lbjyDiIfLRnCAH6vtH+bdnlx2vIQfhLTaA1onB1WLP7Mfuaj7jTXh64I?=
 =?us-ascii?Q?jS+GQ80kF0IZnK5qnEVBlooWhMMBRpL6GOYYumNU26NU0Sy3+o70ellAwWVS?=
 =?us-ascii?Q?X4PgX/m6ojQC8U8Ib5oS43cFpz2G/xzEmGAJnb5ygR/T55z+oXf40htjIJ/i?=
 =?us-ascii?Q?4GheQH9JB1+UwPX1H077W2QYCUAtpQ2bsEHMqdHby9TOdUKXajjVUBwXGLBc?=
 =?us-ascii?Q?ku852zEUoZuinGsVKr1yGEQX+opfRlF2kWadnk95osjZxYoiObj5pFsbswTn?=
 =?us-ascii?Q?GeA8bb6FUMLi9iDAB1lcevYPAtuDMImA9Mh1QVGgLHz/ly8GtLsHp1mZ5nxM?=
 =?us-ascii?Q?roER+6e2zzgFlWFJU2Eq/4Nmdef3AXWt7/XKEabcARv1o18wRz9s/x9pVkXX?=
 =?us-ascii?Q?NvUq+rdszVzy+xuVQ9qK+e5Tw5oT2bzqLr3pSw7z01hz7yNsAT9cAAPm+341?=
 =?us-ascii?Q?cznAAGnT0unHhpVmfg1KMfIDo7WdfUoqUv8UEqtHnBD2soBaQdDmiNNZQZmq?=
 =?us-ascii?Q?h3YVc+l4sSVLvJwV7xRiGjG6n0k4JhvgvtTwvr+fisjWa5ftX50Tt02SlyXP?=
 =?us-ascii?Q?o6PTyNHh13NPnerwL5Kt2KyUVLwdyGrO3sqhYhbQfMZpdQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6290a26b-c571-45a4-67d4-08d8e5630316
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 14:27:49.1796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vX3pUGO3KTfOwyUG4tDBFAGsy+XeYiFBLknBTr2ueRhQvHoaAfFy/h/iehGL/B66
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1753
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 04, 2021 at 04:49:18PM +0800, Weihang Li wrote:
> diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
> index 656b0f9..db37dce 100644
> +++ b/libibverbs/verbs.h
> @@ -918,6 +918,7 @@ enum ibv_qp_create_flags {
>  	IBV_QP_CREATE_CVLAN_STRIPPING		= 1 << 9,
>  	IBV_QP_CREATE_SOURCE_QPN		= 1 << 10,
>  	IBV_QP_CREATE_PCI_WRITE_END_PADDING	= 1 << 11,
> +	IBV_QP_CREATE_DYNAMIC_CONTEXT_ATTACH	= 1 << 13,
>  };

No, all the stuff related to these kinds of extensions must be in the
hnsdv.h and can't be used with the normal APIs at all

Jason
