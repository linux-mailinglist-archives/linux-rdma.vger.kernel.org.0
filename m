Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E416E7987A7
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Sep 2023 15:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjIHNOz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Sep 2023 09:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjIHNOy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Sep 2023 09:14:54 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9012819B5;
        Fri,  8 Sep 2023 06:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hqnw24CJNRC0hVQbviugl9XVMpOYPf4ZcMqMROWhUxqMTgPPx0gIPE6TizRgpKUQboNCcYybydc4QUQn6blEvUIbJpix8v+iVHBBvzZDYhJBt4PcB4yvaRAkhrMSHbhCxB1AX3vVZ1d//23mLggIVuQoILb2yaLJz3uddyFHfbCTe/de2w6x3OFeiVE4MjTdFAKrnK1Pm+Gq/VvYJgBg794Clj/rcXhz8XKHjaNKGgUwm7eP4PCQFZkF+F85BKzYoqknQ46LtIpRNJ+JWBpYnezhWWkDxt9q1uotTJkVUxfKskCPN7FC9oMMNq4IWfEKOlXbs+4wzBBVavX4Eh4lUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uTrvcOlGXSGNMZxizyoVHTCY82z2LmdZ007NsgX+1s=;
 b=FHjDHyb0qwIC/eFJXFmUpUsIHU9eLDmtXAMU/hmTvL2xnzibGnCudn1jCO0Q49GV8+Bl64Yow/sGKOVU02Q9WDLh/PBr+d051jcjKr71hNk6dOW5ZpztOGdONHeWmHRxfMD/HMlYhMp2dBpymHBhaBzLiwxBemp/4B7pdIM8Ah4ogLkCl6d44RmUQbGXQp+Dp8VYON+HXjSbfY9IJBf5PuLKnNWuZNm4jigG9dqY9OT/O72Z4Su3JFcZUu/VqIYC0kxg2LOc8eXglkv950Qt8qN1ueSCt8MXi1+P6S1BGxACizjYsuqbtRaku+tFOsT8DeLns+JpLZX1B0fqx61F7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uTrvcOlGXSGNMZxizyoVHTCY82z2LmdZ007NsgX+1s=;
 b=S6TMv9pXlgTn+3RCzAtqYjYF+c0QxDBgwlZmKyl18PpFQ/qmJhdQxds+R0Z8MkKW5nifBX57/WsJYTTYmdCSmQ3yk6ZGDNnG/v2xg/jFZzFiZdXo3HMDkhzI+nP1Utvl05HGUkUDF0xZ56XaCcXzAYWgKtCunwig61ipHxhE+URHy2WuP60dLcRPWRAN+Jmbcu0uo+91t0IrIElwcpV69fVC80/pc2FSpr8BkAkiS+iVmU2ScnTuuVypKVl8oRZvEEZbRBgUpYMIsp3ip8e1oDq/bxWZI5kol/9tR5plAAwDpnJCNgW3umDSKJQ6qQrtVhpceteM8if0Tpv5r1YWFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6635.namprd12.prod.outlook.com (2603:10b6:510:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 13:14:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%5]) with mapi id 15.20.6745.035; Fri, 8 Sep 2023
 13:14:47 +0000
Date:   Fri, 8 Sep 2023 10:14:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "'leon@kernel.org'" <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>,
        "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: Re: [PATCH for-next v5 6/7] RDMA/rxe: Add support for
 Send/Recv/Write/Read with ODP
Message-ID: <ZPseRunzsGSLeiGA@nvidia.com>
References: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
 <25d903e0136ea1e65c612d8f6b8c18c1f010add7.1684397037.git.matsuda-daisuke@fujitsu.com>
 <ZIdGU709e1h5h4JJ@nvidia.com>
 <OS7PR01MB11804464EB36E9E9FE02CA59BE5EDA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS7PR01MB11804464EB36E9E9FE02CA59BE5EDA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0280.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: c87c7342-6674-4a75-f3fa-08dbb06d9336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +g8w34BTGeprsQESwnie7tB30Nmgml0iFG8VFV4ghYLXZSkdRl8k+hpLrg+SYUU1Hse3kz9nP/QP82eRxNH4deCQ/024ehJ8p2bMOQTRhCV71mfIFFMVu8V9eXH5D4PKr3OJWMnY1bqtI8PFTnP6lyE+qZMToBgsyadej9D9KUEPQglkUd+DtrpV/N/J7FS+9KTaGOlLyNRg5MuD1lXYWDn3xbuESajZD0xol9+KwyqxIQdB+MEJjPa8IfP2NMhtb5Kj5uQPmmguqkFPc1lUUIHYn3OCoz1msTrBPqPOun0wl2upJsYGFR/BlHKRpBIX1IUKMugVaylIxGk5Xjw+G+oW0Dmqw3p39YjKvtbmQMPqZKrULuc0L9zrrwFOFWONwqhK0o+FocJcSJWfhD+Z5XEdrjJl6CU5GzFysUg8lXL4DUxlvYFSYFt/WaP5O7GNXEoShGGk7tmQjDwk+P1l17DbinKUxU5weoJeic0LDwy0OW/HD+Dfd1nz/bo4BGPa0gWgrtb8cbrRO1rt9b3WsMG+IYijeqfRo412+ljnGU51HCizcnpPMhudlbYnIzs9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(396003)(376002)(186009)(451199024)(1800799009)(66556008)(66476007)(66946007)(6506007)(54906003)(6486002)(316002)(6916009)(6512007)(41300700001)(478600001)(8936002)(4326008)(2616005)(8676002)(26005)(5660300002)(36756003)(38100700002)(2906002)(83380400001)(86362001)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dMnvGGvgswYGap+q0QGnfb62jV7AkW5r23McPEwehp7iEI6NKyfDcJeLO9gN?=
 =?us-ascii?Q?Mz5ofLZAZ+VT2aIb/e6r9ivlYP2a0LBHbhh+HCY1CkhcbKZL1jaMTjkzccEd?=
 =?us-ascii?Q?EnT7ueFRpO9/lRsKl4h8WOEvlBckttOFPImd/K+mj5rndrv6OpScDpZvfJr+?=
 =?us-ascii?Q?OKAu1WnGrprtjRv2g5SMs7UeriPs0Yw2xjS2YDc3M6nHRefh+smDLOv7Hrhf?=
 =?us-ascii?Q?ulwtX4LBC1a/T1S2wTWbAU+dzohAXd8jUCDOwqI2Evj/9wdN2VhbI9Amm4hf?=
 =?us-ascii?Q?DFRFdDu/nghVnLwqlUnmQHCF8TG2AZ/4E8JIqvN93VJoJoe/Ysf3zDfUBAY7?=
 =?us-ascii?Q?raSLgkVR1PeN/c8CW9mngV0n3WDbQlWQeLAsWsWlnkn2FVXCcG/XC7nYAxKP?=
 =?us-ascii?Q?nekOdNbxrWH82dszfGmBVyFSn06xi+My1Sczbv40TNJ4fBzNS3CaN3b4r/48?=
 =?us-ascii?Q?9Sz7J79gPZmeh6NMdpwIVj7lOOMoBx9jMG+YQIL1T6ItnPk1yt+d2NNCX4OR?=
 =?us-ascii?Q?GJGDwFvySgmlhotu70z/IF/EGDmfgdObsP11ZvdMc/V5H9eUkJBlohDCtRJW?=
 =?us-ascii?Q?hkfTXOX4lV2E6PmAA+tluOvnqnXQQT7vupxCFXtfTSHzOUkqvt9lUth2SFsa?=
 =?us-ascii?Q?NXQaQXQGiUAKI3qmebhwweS8F9pBEr6/cELTldVWiRweewzhklmZso6kwiXJ?=
 =?us-ascii?Q?QjDsJfe6sn0+21QImk6aWEZ4pUoUI5cFpwJgtE+qNYYfGAI2fWIQ2DIxasST?=
 =?us-ascii?Q?zQ0aO95gOUOdqSp3r4mdDKFjckTsp8Oe5oJswAAPFnGlaqAYHKKDDvsiLWtU?=
 =?us-ascii?Q?iZOrX5wnXu7XF8ykjzYzcri43p7WDvOG6Qho5kS7oJz4yqfb8G27t2DAinI/?=
 =?us-ascii?Q?8mBFbk/s7ntSckCJh4ONvqVungQANou4J/uLbHZFqV43b33C9UIpBVCda6Dc?=
 =?us-ascii?Q?9pw5FF4d+B7TDdocQT75Nrk/zDPkomdTfU9OwSS0+g/a38PoksDksWYAVXxA?=
 =?us-ascii?Q?OLOwCsZWVeYw54gLzvgDi4vS9LBUD14dz82VcBBhOdbdoP28cCLh5z+6JYrr?=
 =?us-ascii?Q?0rQ2/5krIMCiEDNx2/c/O0oatjFI5GqVK2QV8N0pLp7lgHzs60sGM+WeVy6t?=
 =?us-ascii?Q?vwPNpMyM+FjEwKhNQBrI11kiO2hSBGsH1A0Q7vvZvS9rr4tYa7mEse7/K7Mv?=
 =?us-ascii?Q?pUfk1pOq7cF+s2MkmNtxEBrcpWx5EcQVE6aUjCWGWTtM/cNYP2gLMT0KFqJK?=
 =?us-ascii?Q?G7BaO6bcNdONXWQEcNIELA88wgVlJ7a0uw7qDoUsd0W9c+tOdRQjy/HfQTpY?=
 =?us-ascii?Q?93GgzxXD/1IKncIAUmu7InzgZl9GpJKvy0llNRO72342MQVP7yJTMFODsUjD?=
 =?us-ascii?Q?EgHLZcw62Zgc6NpYIZMumljmAyCuOBYUGGAisCj6bQZQFIWnmzY8g1NUOi0l?=
 =?us-ascii?Q?KW9Iwshm0P8p6v095yFsOcjNSjcakMmzz/TePTq4ErsKatZferaaO9mRA5yN?=
 =?us-ascii?Q?uJISp9mxvu5sVnFjIhfm+Hh4frDbscFvFnad6TMEvOTMGL4o2G4NHmUTPomi?=
 =?us-ascii?Q?gQs/ffdIfViKP951/zzX6XPGOqyZvjOCKLnmQZMC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c87c7342-6674-4a75-f3fa-08dbb06d9336
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 13:14:47.2447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NC9pnE0F8bQqhbyALRe/92rrV51bx22S+e4JqBuX2m5R30Kr5O7chNRpNQlyYeRj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6635
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 08, 2023 at 06:35:56AM +0000, Daisuke Matsuda (Fujitsu) wrote:
> > IIRC this also needs to keep track in the xarray on a per page basis
> > if the page is writable.
> 
> An xarray entry can hold a pointer or a value from 0 to LONG_MAX.
> That is not enough to store page address and its permission.

It is, this is a page list so you know the lower 12 bits are not used
and you can encode stuff there.

> If we try to do everything with xarray, we need to allocate a new struct
> for each page that holds a pointer to a page and a value to store r/w permission.
> That is inefficient in terms of memory usage and implementation.

No, just use the lower extra bits.

> I think the xarray can be used to check presence of pages just like we have
> been doing in the non-ODP case. On the other hand, the permission
> should be fetched from umem_odp->pfn_list, which is updated everytime
> page fault is executed.

Definately not

Jason 
