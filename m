Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01D049FC28
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 15:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349510AbiA1OwD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 09:52:03 -0500
Received: from mail-dm6nam10on2052.outbound.protection.outlook.com ([40.107.93.52]:37985
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346346AbiA1Ovu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 09:51:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePLiDVLhIBjSg7eT2O4+AOgipT3E02km7yJA1hQEkYUaYERsh20XkTf3vF+6LPlhIMZw5An+0cB6IMemfbwyZtujTQT7kIYNLfvdJEbIBzyTVHKSQiGSKssf41ZiUfQmX8ldGIGYvb2pBSWWOh3ro9T16wV3YUBHWTQrcjsZkPaBp3uAoRQNXvKl4Ic+hFJQ6DoSwIj6y1PA8BX2GAMWFUfuQDE5P/1gqRyaITK8M/ZSgHucXS6ERN7rkVxrtkkUVrT8FunEnv3FBOds6XPVG/DESrs1pQRPyOGCClzpYC+5JYWBpgtcVYf+7hKxjKy91r8B16zEcsVaeb+ULMxUYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRqVc8HVL6i0y1JlCqQMKUqWyNaGhCgIHuZavyc0hGU=;
 b=jY5KQN8Zpq1TMIKmInAnr6qQQ731aV6zUJmunIps8V/+YVjl9n0HbmGzBYQ/m8rRiB3H/WWJj/0mAN+je3twvDCV308KiiGd8JUWfjGmUiR7tEm0hdPJTzWAXVL9RjCMr9Lq2n5w37lerSyxC9WisNmD6A1XuMiUX7GYHqBkS1F1jAVG4PcirphpOhor4Rj3+nL7jZgULlsAPSL27440+/TAZPDOkKnwVkHbKqybNq7QAgtWXcB8BmI935a/VPWPCSssuVRO9irZ3DjHlhy+I+FzowxKACO+l5Z2nBef5ArWCcNA3qi4AeCpeiKp9STPgC2cTm/VPtnO1U8w6DnuzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRqVc8HVL6i0y1JlCqQMKUqWyNaGhCgIHuZavyc0hGU=;
 b=tq5gnGGCJhvaYKbLFt0NcN94OZqPaoePAMpTQBlqa2Svrvqw0ZQx3vleWLBODS75xowUDiLXlRBL5xVDdiCMt/NDE0g/8M0ZgdXEll+KUrNOBf88Ynj0qasTk19NUtkx8GE5rdTUkDm9o1oNz5O0ycx/RhlpbPZkJeD6akZEBh0VG/JkKPSyhn8+gJtVehOf+JzG7KBpH2BeAr8olrlyHngJRG7mGIOOER5bj46uV9J9JLNdG35g1kC653RwKW3F41fGh75yQXuLEg41ml1xM9IYu79z/iI8gLj19pkNll7RRiF/IrTx0vQa19JugxGGYb3yT3gTEue9QVcVjFcJGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB4593.namprd12.prod.outlook.com (2603:10b6:408:aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 14:51:49 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.020; Fri, 28 Jan 2022
 14:51:49 +0000
Date:   Fri, 28 Jan 2022 10:51:47 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2] IB/mthca: Remove useless DMA-32 fallback configuration
Message-ID: <20220128145147.GB1792367@nvidia.com>
References: <03c66fe5c2a81dbb29349ebf9af631e5ea216ec4.1642232675.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03c66fe5c2a81dbb29349ebf9af631e5ea216ec4.1642232675.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: BLAPR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:208:32e::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24726128-bc02-46ea-9028-08d9e26db650
X-MS-TrafficTypeDiagnostic: BN8PR12MB4593:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB45931CD10DAAABF832EE448EC2229@BN8PR12MB4593.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CtdVCup//n/Pb0g3JWxFzy43eDD3gixdXMrvkE0ammzAnKcwusc6Q3b3CbWTuJfbQajdkrXnb6oS49Tp9Qwwh9Yhz1KtfifTqCWtUY8WUqucAUPRba8N6tw7lEZBSBRdeTB+wH7e1mlbJPX9QwiwVCm5XYd4HBqInEMM+EHQ7jIllZg7UHByDO0WQH0QXYPYFq/B9seTmecum79yzruYMAHqjRawviPLZBp0GDWuzFzYQRS0PTZe+acGzQ+2CjH0AdNSsny/ZPeHN/Lz2t/3VNZe/+mT7JqEWD8Dmtx7rsD0xKLTBjFKilKAaouqlJ3zet2xi/F+OrtPrhx2BXV8qweAm1rbVWjxyXB+O3vVYAppEw8C7awzEnS2PtXgm2DICySYLX2db2y9fuTkXdn3mRg97QYJFcILUih9/JnrXKc5swOG/myzrtEljhN45D9VX0GTnHcDxDJeWVKis7h/uX1grVlh7CEy5s+llLQ8ITkkd4dlrdQiAdKiSufqSSzExNZFMuX+oRCRXebpTedkI1wPuwpfcWgqy6uvbduNukrRFFLo5WwBcPKaGVmcQ9JXc2HClqsjVPUZRMdAd3wvhmYq9mjfr57H1sv6B6YTVNtWC9REvYsYQlhxo7SopLCpk1U+NA/mCclhfyrXhsXV9E+tl1EcX206dpSus0XrgKvqiVoVf34GT4zyMzVBVQeN7xurpVoK3KCTWcJ/lnF3LA1N+tm0a6GnX57kKD+3Lis=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(86362001)(8936002)(6512007)(2616005)(8676002)(6486002)(1076003)(966005)(6506007)(36756003)(186003)(26005)(4326008)(508600001)(316002)(4744005)(6916009)(5660300002)(83380400001)(33656002)(38100700002)(66556008)(66476007)(66946007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s5PwMNC9Sn8jh7VIHSKcklA4oCZsjfob9BmBMvSorzLOut37oFSNRHMv1+hu?=
 =?us-ascii?Q?gr/U8flYzqqgSUIDY6Ul9wR+dMMS5C9lzdQmYE9U/rJOXxXjL2q7gmZVNjLo?=
 =?us-ascii?Q?5peKcifqAOnfYrf3SzfzZifOowfDpmBKrTtA5okq90zmwnNzXdTpRBC8RWgl?=
 =?us-ascii?Q?sSmqOmG2VphDtXeZL2ioot9Qw15o9k887rudkBhnPYn8LRFrpw9CJJEljXAm?=
 =?us-ascii?Q?HufetbJDdyv2udS+rHVAXfiIDtQzPO53qeGqPRTT6pz2eWdBXXdic+h4MSC9?=
 =?us-ascii?Q?p5t+TsfIAzsk90dpxULCG+N6Tawcen71vPb2xfxz+aQsemWFWQL3A1E1TQ+i?=
 =?us-ascii?Q?kPjASm/uLOpN8X8EUxSOZTnDEzvgY95Za1ZTKGBd2lWe2yo2eiWYEz9Nvlvm?=
 =?us-ascii?Q?+85j9ATRifF6tXy3a/W73sIozFLUHaIhiCmhsE7ISMZDEpyv0OKnBtViGWzQ?=
 =?us-ascii?Q?6X8XcKj2LqbEoMfFhNAz+1hF8gl7Yr8q5U9q9Y4tteM6zuCpmCWhshAEdr0M?=
 =?us-ascii?Q?YZTOtQFBghPsPhCAIXxsrSeiuJ+36Z3co4+j1XgMWswM2pDq3qZFRh7DTPia?=
 =?us-ascii?Q?q5C8NEEowQXRf6vTObkuh3LGcZ33kyaZMvrW0n3o5I3o5qoasiRCkOdcPlIW?=
 =?us-ascii?Q?yIL8jj8Tq15xX2jX9gaCY7+itEKvjIpfOOkEWB2xA0tDR1leZBdP5PJUQI8t?=
 =?us-ascii?Q?9HKeghaIllFlzvTbUXlus5i6haoQ2r01b7ETJ4mNZcSAeogcwSnlnWD5qhH0?=
 =?us-ascii?Q?vINQZTiQL177n8+noOJbViQChyo1wOl6cFa0P3NTmKoeZB4rHhWxR/YNZhYd?=
 =?us-ascii?Q?Zvt09U2NMTfQnmublEg9hi1EHibjA/WibCVSmTEHKjSez7UWK9khxs0tJTSh?=
 =?us-ascii?Q?wh/rBwFG/76tL4sMiW6CkVM0SJAvJDK0pruoIxzWt/w9Z796sq0nDzz1J6zO?=
 =?us-ascii?Q?7ggHllP5VOBYcjt8coRcYsHJ7IduYaVxqbb0xfEffUdzogwchACvpcLvBdrw?=
 =?us-ascii?Q?U4GtOBaVSFBftxFh1G4QAMi6B4EqL31QGenl3RlT1EorMPIesQEAld5/1OHf?=
 =?us-ascii?Q?j4WMaLqKZHpu8fwC8dSshOqX+l4Pb9671Fp2zuDQOe/MdKfwL3O26UIl8Ung?=
 =?us-ascii?Q?3M2yluIdrAfx1d3QZEfYK8gjf/P1G5bk9NbgnQO7O84MmQ+1tojcgdq/QP5r?=
 =?us-ascii?Q?A3Fsbx/4YfTBDvruuy+hS89cQnyIA0HXjzeOiySYWP+nzswRESeMdyE45Itc?=
 =?us-ascii?Q?HXPGeBj15oWYI3ue9AAYbhl1UlzFPVfKuiQrSXCD5ffAxbtuV14Fxe3IiT3J?=
 =?us-ascii?Q?AYB1xaCZyvWsO3c/9MudMRjK23GhsB8W2mnKVb5AE6VO60uONe2vJKPHdrl0?=
 =?us-ascii?Q?ON7zrjgTgP2HMpCqeOPJR6XLGv7cvAgDBunxlLbY30ydT60hR1/FI+oIcii1?=
 =?us-ascii?Q?/KHVNM3qvTpP67g2TzU3v9ZzRcQF4MVNINhl0+AkPQL6xyNHZe93ikghcPNe?=
 =?us-ascii?Q?f0Wlr9P54QWww2rzwpK9XsjOPJlidbnCCbjGiHfC5pztHXJ7dZe6nKqup52T?=
 =?us-ascii?Q?phnAIeYXd2fGza1iIbo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24726128-bc02-46ea-9028-08d9e26db650
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:51:48.9087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KSnkCqbbilF4TGjVxiayRE+iAp5qlWfSIJeXmQBdeguLwOwxmuLVujglyQ82usq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4593
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jan 15, 2022 at 08:45:05AM +0100, Christophe JAILLET wrote:
> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> Simplify code and remove some dead code accordingly.
> 
> [1]: https://lore.kernel.org/linux-kernel/YL3vSPK5DXTNvgdx@infradead.org/#t
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: Update link to use lore instead of lklm
> ---
>  drivers/infiniband/hw/mthca/mthca_main.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Applied to for-next, thanks

Jason
