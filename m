Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E194837AD42
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 19:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhEKRoO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 13:44:14 -0400
Received: from mail-eopbgr760058.outbound.protection.outlook.com ([40.107.76.58]:7870
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231329AbhEKRoN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 13:44:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRMb8nQjot8znzjBWxO7iETPOmlShaSCA0yR7b3Mw88Nbib2mEAGJ3mly67HC/d0mvJtsTZ2Ex4Vngo3cq70Wmu2h/WsZ7Ig/TqvM3kpqe+ThXaDJF44LE3KZAZ2o6B7shelxVXUCLOJwTVmKniQBFHN8GP1e63Eo8b7YPscpoBC7Vx1G7/4c6uo9okQ/hp5p3903BKX3b1MBD2g+M7zW/NOjSIKC0xkGFplEgMXCSVu4MkmpXICm3y3CYb31fd/0+F9Se9eN5m0NLV0EMQN+jbiaEQFpY8YDSyz5lFD/Ck+EjO6mMBQmXmOcHGKbOh+RgSKI9ZAByWm2excIVfTDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndMvzTiCIR6s01HfJS8Gf4Z21K8UoF4uoy+0RZq3BfA=;
 b=YzYx4RWr8KkL/lvU9jr4TfDP+RyW0geVfQUX5WPLLkHuQDAHKROnLa6Df+jEskNSZ/OI8H//5cu0ry8vGVE7Hc3fD5r7So0Ax4jsKSJFEVrJnRtcCE/HkLwyHDb4bVJJ9aGSAbqgCQE5K9NbOwQ3MEgJoIBggFCBvCDlJnXc5/JQvsaF5JtN90/M4y5+vQ0o/YV/2R3pUXK1+Ir/ma9jOYoMpAB3hfHDizTZfhEYapk6YLvFmnVcoemvy9GlPJb/YBpRq5H3yseqIvKbDhjR4XYhsT8/MtPVMxlCEX1irt4omXg8PE1k62i++D5FMELNgEe7cH4lKF8brkTeXhvx6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndMvzTiCIR6s01HfJS8Gf4Z21K8UoF4uoy+0RZq3BfA=;
 b=ly/NEt3lzkQDcSWCH1wdfJA0kLcT7eHeCa31vIh+/cH2joDjmGJ1Nx/q55yaE3UoN3vOTZTcbxtunHXsPHu2gmS5HJknrgjZd1gbY1kDs6YC1+ZYhPr0KqPj50hIWepqsOX1tj2YGX56CL2Xnbt3WTPu9LxQhjD3EP7qzyS/RgzMkcCF3pL95ylCcfCbB8Ig98oRJn/0gWsNJCfHL/pAMViLPe2D+HQdujl9CeRjVgoBk6I7+QI/jxCG8ZQtNricR3j83WCuElUMEV6AK+iASPagNuU7W0tfWtyvY0MOa1WbFMPSnGovMxa5h2ybDbH72fpuokI9zZxiCoU7VB5SbQ==
Authentication-Results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2860.namprd12.prod.outlook.com (2603:10b6:5:186::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 17:43:05 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 17:43:05 +0000
Date:   Tue, 11 May 2021 14:43:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     yishaih@nvidia.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx4: Remove unnessesary check in
 mlx4_ib_modify_wq()
Message-ID: <20210511174302.GA1291834@nvidia.com>
References: <1620382961-69701-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620382961-69701-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:208:329::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0072.namprd03.prod.outlook.com (2603:10b6:208:329::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 17:43:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lgWPO-005Q5D-Tp; Tue, 11 May 2021 14:43:02 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6232f1b1-be80-434e-6aac-08d914a43b2e
X-MS-TrafficTypeDiagnostic: DM6PR12MB2860:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2860E10FE3438E3D7A29516BC2539@DM6PR12MB2860.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L4ynnmJtuMyMZh8F0Ww3S+ltCmiUL0E52XQmRHfTFl1WGHfVBvu6vK//8eRrLgsWxk8nNJGrWYyYlcm+lJewKb0FXeWcnxUMR4O/BBrRA855AM+CYZ/lkZy+WCH7+cll7tvxibj2CjgGdPh9O0Q84SUWLRFwRZt6jxWdhCDfiUO9qxzYQDTInAgzkf53EotHsfRabpWhkFF+Ab3sSefRCDrdIo/IA70xw7701Lv5xsMHE8LXJ0AN2y3REoyP2iNkRU4ovUyIhKGVYA+kQK+wVA3Ef5h0bWr663PnVpg/xKgBghAYXyyVYO+d5lqbNUUsyXP2dTkbnTbEj3o2ZxSOOTzTWPp0ox2h0wrt5qcIMYkbWlqO70NHUZ9L0tiyNsnZ1tThTLr4/GiImCSgNNi/g+4PDPBXr5k4vryPlzMiFHb1C6IxJRXFyT/Zukas0X/Wmy3m9FtRhxZ3ERVMDs1/MF6GDekodngGEyF5pw5AiUEoJpy83yooozR6ptIeIE543bcZIBNn2lRs3GU2dmgffbmdyCj7pzSJupF6JhWiygNxLMkaNuVpZdDuF/QUfb/emq6Uk5otAgBgGbWlE2PWk/oaK14H84xQAJWgHWIKEyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(6916009)(38100700002)(4744005)(9746002)(9786002)(426003)(1076003)(66946007)(5660300002)(186003)(2906002)(8676002)(86362001)(4326008)(66476007)(66556008)(498600001)(36756003)(33656002)(8936002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jxROgqUQ6ghnvcY/W2oWJdLIW8ASkwsx+QRq9qwIN7qDFfsPFlsoZ8JUyDMC?=
 =?us-ascii?Q?jGG7A6cp15tUZhjxYeCPR5RxjZhIdWw/pFJXaq3dw5mWJnUAJJx1MjyNFodi?=
 =?us-ascii?Q?0JrA9nyq7BRVdRgCJZqYyROk+O3OEQHTcNEEo8M59Z6a90jDfXt9KS5ufbJm?=
 =?us-ascii?Q?GKqt6XiE/o+RlPd7rOGrY8aufCrVdO/ejqjIYJ0GSIvejANGeAtuWCM46M3T?=
 =?us-ascii?Q?fMv2Jqauyz2k69BMNlOyCpoRq7x3RFFBrteu1BEVy98X5o63kDnQW5goKmIz?=
 =?us-ascii?Q?tQ4YQDoydyWk9vK0uFR7PQ/hnfBvjVr0m4KDUFEZgleRLeseI4zOIFw9wb2I?=
 =?us-ascii?Q?RNeKiIRInw+Cwr5B1S4gjlMHOP1ym182tG3QHyJjpDYLp/hLqhprzIm+Wuui?=
 =?us-ascii?Q?qvMIKlzK4Iy4lZx6Vkg83ZM4gBAn4ZdlGlgYprI5wP8VBfHoumGCzEcNT8yR?=
 =?us-ascii?Q?3lIYqwxoQjbNYdaz7meZPR/YjoD2QdaxDCQA7Ia2co9yap4HeZQzE6n3itaG?=
 =?us-ascii?Q?DJ/ipZ1w09Jf4HKXPUb7zW2FCLZNRgoMbrV3jM5pyFPxl0Q1yIu9BUIxOFj5?=
 =?us-ascii?Q?Sf6L2EHTC6vuvvHpJTTX1RRzxC6p80NOnVfeYnTA/ewMT4aPdmwsizw7eoNp?=
 =?us-ascii?Q?/LHepn0IBzwUAyP78FVJw3r9kFjFR92v9x0B1mEGQEj/spdMduj8USagSv2Q?=
 =?us-ascii?Q?Qchy6SeOPMDFKVFsibmFVQwRdjPvZs50ZqZmHpi12+66kDLjovk+CpQAiEFq?=
 =?us-ascii?Q?n1nxwaxN5LSjLisc28lpLoOAjre5gV72Nu+CI+rf40wYUfT1XuLhjqaFApUk?=
 =?us-ascii?Q?PaL/UIAwpW2uEny4GHm8lw8jDUCmRxz6DW4zAKXtDUw1RwuOfqe8w0ah7/bc?=
 =?us-ascii?Q?ARbYnxqz7n7iZLYr1qvjeHblWoBpfaUdivqAIhlGlPHHtZVOlyPO/iCu0ajs?=
 =?us-ascii?Q?t994oQQuSeuLICZ2JXA9ZXa98GX/+EeWB8Pl+MVRzHC+SLuzQVOF/WLpcRld?=
 =?us-ascii?Q?R3b4HdUgY753W8KRq3CyuW80bX2h8a7Ff7qTzqhBYwXvck/Xm9UrHE2k79/p?=
 =?us-ascii?Q?pdugpX4F/vAmrKgTJn2NBptQwN1pr1wLXgHFppXRKM/YjBNWiyi1Rk514o34?=
 =?us-ascii?Q?MAXg4reBQ8qhFXR8XOvvH6g4Ql14qJCKV6pE4sKg7fl4uld/28f5UmntrsTS?=
 =?us-ascii?Q?v8GJ2QcQOqP2b9WuE/argeH34Fu5RCfLJP3obTYD+zaWEsx2gKD53Mez3B6Z?=
 =?us-ascii?Q?CHGdf6Ptky25Pdsz4a94phR7r98AbVoH8/TWqcpwiiXUKhwrWZbf8+nLyH+6?=
 =?us-ascii?Q?UleSPdpkE/qo+bAbRI375XqO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6232f1b1-be80-434e-6aac-08d914a43b2e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 17:43:05.8150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJaqpznNsPTs4W/q0RWqq5hxlR+xl0D1Ol40C0qMaamyAQZQWyIforhy35KU7iWE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2860
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 07, 2021 at 06:22:41PM +0800, Jiapeng Chong wrote:
> cur_state and new_state are enums and when GCC considers
> them as unsigned, the conditions are never met.

But doesn't gcc consider enums to be 'int' as the standard requires?

This change looks really sketchy to me, cur_state and new_state are
both userspace controlled data. We should not make assumptions about
the underlying signedness of an enum when validating user data.

Jason
