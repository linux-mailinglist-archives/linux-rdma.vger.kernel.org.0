Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CF1637F5B
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Nov 2022 20:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiKXTA6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Nov 2022 14:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKXTA5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Nov 2022 14:00:57 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACD096740
        for <linux-rdma@vger.kernel.org>; Thu, 24 Nov 2022 11:00:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGelYPWLaYSRldKt/GIRk4IH9IBZYWiVSlilm3EA8aaxSzIu4DFvgOUxsvP9YuAOUiAT8FfJqrCHw/9jnx7uMCLefri+3/yHSsauePVTU8pcyIGLwXaRaBJvOUwt3zYGHfBT+Vjn7GaH4KzYexiL4xUDwwk6xxm6PepR17sE9Cwfw8dQI0SD9D8Ygwi0hl8KObVEgpisp69B1ZzZ4cjzktVOMIZtXaBGoIKEobcieVJq+QCOZoFCh7ltu13y3CUSsR3HcteTChlh/WN8mMc9rSob2J94GqX1RL+TyVR13+TPns2wVZa2KeTR/YCl9fAbwiZN1whvwE7yZl8MDEmXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEsq15zPgawusz3MncyTjnAZvpDQzEE6B7n5RyHCw00=;
 b=V5uV3W4/pFHrA3NEjstb8r395/CsyWsomTy5BmgLfs9l6JFdm0MEpZs9UNWwMEPFy7Y2xOPoAzgpUesu4qu32Vd2stAu4VIvuFz3qqCc3w22Zsq7G2xsOXBN/oRUQy/a0IVKGhU9ooGRMExlwLTmeoUbokoGwokyBu6HK+D8CHNkkZy/G/FfgzNNjA6QQ+0yXqEE7xgdbNcyO7Zzm6nR9JCIoDXlnl+U1rCpjJcN5RKK4LCJAn0v8z/I5IDyaKKr3b1fG1MIAsygWmn9hdVE6gFBopXfVLrpnHsmbKivoW+uVvR2RYte/q3Xx7vKj3PIBIBXciFsLTZ3Og4AsbG0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEsq15zPgawusz3MncyTjnAZvpDQzEE6B7n5RyHCw00=;
 b=F50L7tLB6qDB+R7fQh73YvDyBKgu+zRxI0qi/uJSCRE0ukGHlEXeay+71yHoNvQ1/2VLd+CAE+80EUdTIchx5VV+cMOYtnvPIHr/n2dKfZsYwkv24CZkJc1u24F55mNBvPs3B9i7MV2j5jLcOyqcbtlQO5IT7oXxQ0s1SU2TZfkK0PX4RboRy9EERAtRYL5BwKch5+QyX00ODd/PjeOGLaoiHPfNAwoN1Luqlsh6G3aIZeNhteQDgt9mYwHYsHramsy0sNaAcjzny+Id8cTQJvB0+gDQG0KDTJ1Shdswgfe/0qHhqysAk0Zp/TKd2TLKoWABWPi1CvrN5woEe7edJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.17; Thu, 24 Nov 2022 19:00:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 19:00:54 +0000
Date:   Thu, 24 Nov 2022 15:00:53 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next 0/3] RDMA/erdma: Support flushing all WRs after
 QP state changed to ERROR
Message-ID: <Y3+/ZS5O19aHWgHc@nvidia.com>
References: <20221116023107.82835-1-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116023107.82835-1-chengyou@linux.alibaba.com>
X-ClientProxiedBy: MN2PR01CA0021.prod.exchangelabs.com (2603:10b6:208:10c::34)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 060d7cb9-5eb6-468b-5c43-08dace4e364f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obtNpLS0SRjFreGfpybC67mORsdZ4+yn2jM0j4w5Ux+FFGPjRzvwjpT3YuhkGmHCsCP7Zs9aCWT5Dj4I5q/a0WnQcv6FUXXcUghdq5fHWE3Ltn2dfmXvlnLmoq49C3+xqL60XAAp/aVoF+bndekpbMxNcNJ9FG6BGpwT84HqM3S7j4L9M3xWO5laanrbT1dlNF2Ir1Yn8TF35MOnvK40NIvBBFRW5tZAr1fScDRXEB0zdiTyEtuBLgU0mqSoNhOfKfvbyi0Szo7eoq1yHG2PYtZ64Ri9xZsBWwcw/GcYmaRBT4ySoxXBDZpSdR1O0td41vKTKjpeXW3nPhKNXGkvmSp+2xD58thIcKPwWAQmPWgiCvv6IjmmjF8Pu4bdmQsSz8iSIwgDATohsmttaSllTkv3NIKgD76aDXlHKCEIUNGO3+sZg35lL+St0DSW8VfPLAgrftSHOirzFzda21A0a88czJwd4k8++PFL0Ex66zb+EeD8JDgh3zgxjUSWzY2aFoDXHGfNIAO0XA5Hx9jGemiIlXLwLQmM7Vit8gtZTNdzZ829TCSBbXGmt1Ook3zfBmFUlyNe0sk40Zcaoh5CIMO/+ybTKZtXTL+IXvyVAvrGkP66Hs1sW5KNo2lN096c9TusxIdw/TJDur3bYmzy+5XID5suWW5cxziqT78Ql3Aw+b0FHpwUSZq/lzWGPi7lt2j4EhelT7dIsGNF6Qa53HGZU/yY0i8D1bXTS8qtwJ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199015)(6506007)(478600001)(26005)(6512007)(6486002)(966005)(4326008)(2906002)(66556008)(66946007)(8676002)(66476007)(5660300002)(8936002)(2616005)(41300700001)(186003)(38100700002)(86362001)(36756003)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DSozx5rqh/1cfZpXlP9K4/EHI9oySHXP49dXftEJXVsHhz7b5ZHfIg/KZvK4?=
 =?us-ascii?Q?GhcTzepITIUzXnuHGsvFNQG48epoPiq0QdieCxG3jsQJSJLaBHRXJvCsIaLK?=
 =?us-ascii?Q?o501QDEhLgxY7jMbrnrhLhMk2XfAfnd2806su80oEHdLEII8QUN+P5b9l6GL?=
 =?us-ascii?Q?LLKH5F+dl6RUPnAIvQ9SGiYZPdiZyoTbeR6zk6oFZS5n7RIuNGGGDLXEM4rT?=
 =?us-ascii?Q?rSyXHTp4DAUvsFt4eZIwp1HDD5T46ONTIcxH9abJQI45jjeKA96jUUyLqevU?=
 =?us-ascii?Q?RN5WJpymxw1oloNIQRakhOxDON2TkIiV2fdhKb8W3tbovKUqzLHUx5VEsfI6?=
 =?us-ascii?Q?P+RUaoEZMIy1T3XlwJElO+Rscei7YnkZuxXit+E5tHIDl/qec21/0FnOfkio?=
 =?us-ascii?Q?M4AHy+oqYjqgp4JJvPiBiycGdlpXs7udRO1DNI4mlAmZS/D3PWlfmKBXnD3J?=
 =?us-ascii?Q?pG9gCizZvbrMJJJgMiyB3BA1nsIN6h9HOoje93Q2g1aOFmJe75Fj2Q2a4zn0?=
 =?us-ascii?Q?hNl857hsO2MbqfjSevEICGwCoikUhDi1aBz/Guw5WlsDdfgfKzZpsa5MSYqk?=
 =?us-ascii?Q?Ep4PfEYGj6SJNTcCX/zPve6oS3racoMfyfJ2CXl38KR3ctAl+K0nnv3d5J5L?=
 =?us-ascii?Q?7UnDyvA8r99lmdSU7yMDLRwh/hCKInfHsk1BE8E4dHCpQknc9anj/i3gfoav?=
 =?us-ascii?Q?vrRpsgVLIyVnYmvthZsaeTwt0XCA8fqpouv2qvvTJPlKGRVpKC95OXYlLekU?=
 =?us-ascii?Q?N24dJf546CQxeTbhgH8+F1ZCYPIyES9kXVuwnL6DK142v2v6SR5LCp1Lv1dX?=
 =?us-ascii?Q?xuAFSuBbEf+XFDxa40ftubjhBIV4RnUl4QZnUciLfUkDBlHdOaxGNQcdyOid?=
 =?us-ascii?Q?n4dG//jpZVc7o+Q65fyK01U/kRjnmBBUDBdQGNGwtENzND9VwQ7EuLyC1K6j?=
 =?us-ascii?Q?zH0ycpqYA9DaDPUc7i7WztVEUYS6DQ3z3qSdXW81qlFD0NuikrTLg3rND8+U?=
 =?us-ascii?Q?YiD1HrLf2RAymo30lbA1VDfYk+r+uoiow7XeIxbSluTj8LukXL8tbyE4QIHh?=
 =?us-ascii?Q?9D6O2A/O2DYkLXNXXceh3z2FNvty9rQkfcs+1JHy9Dut3qdE0ppy5FKQflkA?=
 =?us-ascii?Q?ZohIYkgUbcjfXwNVeQLiHK4SzRSGgRzXxemkq0HyAhg4J26PfNIMYYNB9fXi?=
 =?us-ascii?Q?14x0o/cB0K6JDzRbPl2UdVIzhFdP0gNiWVsmfM8bbowLnnNDJSJHxDO7gqQ2?=
 =?us-ascii?Q?mewXZTKZQnR4kufdvDtN7/MbXURrr/PXW2C7Ez0xro3YYP435SXtGmYKkTLP?=
 =?us-ascii?Q?ljUWhYUhVZ/VFsJAcOe1am2inNbP1bHp4VX+UOb4WpVS0o0OBMZAzv5pTHSX?=
 =?us-ascii?Q?+JIUQr1nm/o7rjcCoJgkOEA5M4lUhAbV9w5bJGRpOgrus2vFQnBwh6H/orpH?=
 =?us-ascii?Q?QFr0wgLsgYXCucNyd7HvxFE56stF4Z7HVoCaGOEDOt3+1rwOQ3kQItbbXW9D?=
 =?us-ascii?Q?YOuP5OnwNsNfaAg2SBBnUGBWf2fDprwzK3Endx28pAt/SVl5YFaTfZmoqLi9?=
 =?us-ascii?Q?Hd04CIuv2x370Rohod8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060d7cb9-5eb6-468b-5c43-08dace4e364f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 19:00:54.1538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJhUZE7jOzzlUEK07J9ERonGBbihRkJIrCA+3uf3B2GoK1VXxUmhkAxjkaQS1SdR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 16, 2022 at 10:31:04AM +0800, Cheng Xu wrote:
> Hi,
> 
> This series introduces the support of flushing all WRs posted to hardware
> after QP state changed to ERROR.
> 
> Old Firmware may not flush the newly posted WRs after QP state chagned to
> ERROR, because it's a little difficult for firmware to get the realtime
> PI (producer index) of QPs, especially for the RQs.
> 
> Previously we want to avoid this issue by implementing custom
> drain_{sq/rq} [1], but this has falw, as Tom and Jason pointed out, which
> we also meet in some scenarios, for example, NoF fatal recovery.
> 
> So, we introduce a new mechanism to fix this. When registering the ibdev,
> we create a workqueue for reflushing (we name it "reflush", because
> hardware is already start flushing for the QPs at that time, and it's used
> for hardware to flush newly posted WRs). Once QP needs to flush WRs, or
> new WRs posted after flushing, we post a delay work to the workqueue or
> modify the delay time if is already posted. In the work, driver notifies
> the lastest PIs to firmware by CMDQ, so that firmware can flush all the
> newly posted WRs. This applies to kernel QP first.
> 
> - #1 adds a workqueue for WRs reflushing.
> - #2 adds a reflushing work for each QP.
> - #4 notifies the lastest PIs to firmware for reflushing.
> 
> [1] https://lore.kernel.org/all/20220824094251.23190-3-chengyou@linux.alibaba.com/t/
> 
> Thanks,
> Cheng Xu
> 
> Cheng Xu (3):
>   RDMA/erdma: Add a workqueue for WRs reflushing
>   RDMA/erdma: Implement the lifecycle of reflushing work for each QP
>   RDMA/erdma: Notify the latest PI to FW for reflushing when necessary

Applied to for-next, thanks

Jason
