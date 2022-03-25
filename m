Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98EA4E7423
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Mar 2022 14:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348144AbiCYNYa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Mar 2022 09:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354380AbiCYNY3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Mar 2022 09:24:29 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC94D110E
        for <linux-rdma@vger.kernel.org>; Fri, 25 Mar 2022 06:22:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqFM+WM9Zt3Xbx9EpfGOT7CURF4voAuVKMH/O7s48I9LN8+ffJVLT4Sy6QzVHOwTy5HywMALD5goRXaquoQa22zFfxKEMKQMH5sY0N9jp0ChhJ21F7dyKUYU7WfE/MIp6umvZBS3XYs85IwiiBe/S3wYpogvMMU7RiiWt4PjSis56pms/PxWTG74evS5PNzNWr4BHhcbwJxVLYliY14/WBRkdseYpCbbMsQREvAhmxUzdhocO4HNQPzGBs/b0aww2hzGCSUQoFbZVo87WXO/1VtX/ybIk7f0ZWlqm5Z6MXlXMjezFLwsTGa3Laig0KmBEsfilqXcT/l2LorJjYPEgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzonXbySIufafigOxCDPu/PH5ENi3mcmW5bVBjrYmv0=;
 b=VtJPhw8ZUYj3pdpBRW1UfvN4VpCA71fewpGoZGlTRNdaTk7rVhRzn3/cs2geWCndenO/M3+83i1kHv66V1JhM47wCV//Bzlc18eTRkzk/c08jBbNZNOuhXT8+it7D40s7K3ZtCIavkiS964VuNdZ7bNoNuyo/ByrP9QYiEsuxA8PaUT4ASVXw04RfV3xKoBQM4pXlb6F6MXgYHVqqNZ1ksJMaNlXmNsntyEAzGhcckTyY9B6KB/Nr1XHXF8FiI8DVVO420LxhvfYQsUu0ZahbgMEPSlV+BJT4IEebu14vaahxBwFdfLu5FoeUDdJBPQM2pQuLnX6dHehIYs/wI04nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzonXbySIufafigOxCDPu/PH5ENi3mcmW5bVBjrYmv0=;
 b=nDoXCFXboZK/nqRDYuzS4RSUJoSO598o8FyFteZEXnAvooPdsPNFaujyzWflc5zxPWEgulsz39sMpJYH73Q7a4PfBrnUBnW8E21JWcPnbKSAdsnNCRYt/cZTRUD5bBr/MeIC1SM6rIyIl6aLFGC97SsNgsDbNt3ZpZGABZ7KKy/A2ATybSvbGa6WTnmJN1DBnJtUAfwMCANEww/ppdNyJqzeojGbo/dKitg7m0BJOfYdawerhQHq9vKUZYtO/+PqCK84tglYaN1UE03audYVT7JpwN+liqC0n2bLYIFCOspSZG/czjhWH0gbZJxWdliE88KwLJV2J7J4Mnmxfxp3Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB2995.namprd12.prod.outlook.com (2603:10b6:408:41::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 13:22:53 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%6]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 13:22:53 +0000
Date:   Fri, 25 Mar 2022 10:22:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: Re: [PATCH v3 3/3] RDMA/rxe: Add RDMA Atomic Write attribute for rxe
 device
Message-ID: <20220325132252.GB1342626@nvidia.com>
References: <20220311115247.23521-1-yangx.jy@fujitsu.com>
 <20220311115247.23521-4-yangx.jy@fujitsu.com>
 <20220315185330.GA241071@nvidia.com>
 <0dcc96af-1d0f-100c-aa17-d423a45f9062@fujitsu.com>
 <20220321153225.GX11336@nvidia.com>
 <c4442831-0704-ed6b-f2a7-ed8288d2944e@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4442831-0704-ed6b-f2a7-ed8288d2944e@fujitsu.com>
X-ClientProxiedBy: BL1PR13CA0253.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::18) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcc6e65b-964c-4e8e-1025-08da0e62913f
X-MS-TrafficTypeDiagnostic: BN8PR12MB2995:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB299564BE38FF48875505246EC21A9@BN8PR12MB2995.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lfc1FgH1UTRhjDnlmlfQ9ydeiF7GXwguWAUwUIQ7Weqy2O2sJxKRhXqNHyL9RDGSA4fhoOLtIaUvYuKST11k/dh+7KznOR+SpDwXvgImgo5H/5C+DohNAVFFbZAa2jZQzVelxBg5b8yvtmQLu59NZ2eZEAqkTgxPzTfYGYgpXYuy59q+euHgf5SJYZwZGCNI3gAgZOUr1bHIesQPinasVRKme66AIXTBEwSUo1SnNkWjbjkEeYX1xXu1EfcGh317z+8v+obvI8akhbAhqkAbsIoiDSg9PM2TQQNPTEEcLclnywkO6fYS/u+OKjLN8MjGyy2Uu/0Rh5USLd6UsV34q+OMWGQ+PDW+LLxCMtxjKJRn5MTwqIHUbj/NdPF88qGMj05sox+hIqQqqUjB/OU598fi5n93V0Jyid/HkQlPhB95z0HSpBhyRNyTgycNASZNxB9gxIt5mfKOZ/ce2C+yLfd9Z9ZfYjfpb5hLKE/fGPVVQM3anczWvsNmV0Grdg1unw7z7rQ5YY5p/TVj5Yxwyk2JqMor5M5LGAHXBtJH+Jv/qU2KMNBq+NzZliHCbTitNQuH3f6HMCcOt3uoIhW+POFOpb8/9PFHrfQVdj4SZJwZc5ASVnOZoVhD/GDjNgNGGfGIhn72CJwfwfLL8X/bCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(83380400001)(8676002)(316002)(4326008)(36756003)(2906002)(33656002)(86362001)(66476007)(66946007)(66556008)(6506007)(38100700002)(8936002)(4744005)(5660300002)(508600001)(6486002)(6512007)(2616005)(1076003)(186003)(6916009)(54906003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VYQXzt/bnSjGNl+tqlFpqx6JYLE5KTYn0IC15HHjegHmcfvbzJlBaako6hz3?=
 =?us-ascii?Q?UbC+Q6HpkB7cTxSJVwrTez7moXWPlpxZWq1PktQziJroPkPuSYGkL3hlD7qj?=
 =?us-ascii?Q?ktj4L5tHEjOVzsc4S94nb80rAsiMD2KcqXwRblm6JzgrHChSBR1P+XR07slf?=
 =?us-ascii?Q?3gVMkpyFJcU/zU6h2TaPyryYZWNl4G4nXyaKS+NLjvPpLQZSrUiqHX5gEtc4?=
 =?us-ascii?Q?XaNnNoGphWniLnuvxjYh26kd4n+jU4sLrjRNRaakkf8Dj+cWq+++vefPiZ+8?=
 =?us-ascii?Q?UWdJDw038wW8+iZXrJ7b4f04PGXi7CPqUekbXEvZ0CJjGHb5GX2JVqM3qx9y?=
 =?us-ascii?Q?GtM4vM9XcXoQlViK0Zk7wCrc6UiE99g7zYMxmRdGwJhRPWjnPvZuzE3i6+L1?=
 =?us-ascii?Q?CtFrNFPGTIb83KLgU6pnNkeXKTZJOvn/5fA57o+MczNkV2AyrFGFNM1i2uAP?=
 =?us-ascii?Q?lPbqCUIiGrGQhNOU90lVCYW9XMRUSY021ZZKLm+009+JKm71uqvpE4I3DlAu?=
 =?us-ascii?Q?/uIbLEQsMzVE0eE0ozl/kS5YO0WMZT0qxbyv8MxbwGlooXCCDQh+2J4H7ziV?=
 =?us-ascii?Q?oXR5CYUYD00+D0a0uhU7gH4t2c+L5DLWHjy5mFMgfF+KGU2pJE8Ns9sQdbHo?=
 =?us-ascii?Q?ho377+ugouXNvQ5pwkBk93DEdEe8Sw3AmnJMZhzfyF04ZZ7uRPWCSSQ9WF0A?=
 =?us-ascii?Q?emsUuKMMSsrOC0aIBKeTvYAbUgZd3xW/czsTS9KG5/JHsE1PzKpkt11EDCkr?=
 =?us-ascii?Q?DbQb0uO8iCJWB6BG9KkUFBn1hEgBprvhkFkAdmCD8I7Ojv7vBxcLUDnVAQm6?=
 =?us-ascii?Q?3pjKYzOmevtE8+9mEZIneW4DZ/s3oozuRGQKnwwbVkGgzrCH2Nzbi1ER1nyb?=
 =?us-ascii?Q?LWofTxHwc2d8d1J+FO6Iu7uL5WMv+QLnoXD33qGfyoJsLRxSWTDI/nScLDCE?=
 =?us-ascii?Q?n46SA5eZ0TVWLdolb+CYDFTWtmqU5ePeaZ++RbohGUkCXTE43gR85FOLI3MD?=
 =?us-ascii?Q?+F7knMZQT38pLHNRA4xhiCp29pS1GgamqT4WBmyW9cQLFTFhsjhG+NlsGeAV?=
 =?us-ascii?Q?wNoS8rIAoqjW6OnNPZx7Wb/Jhr2dJtzBpSZXFx7lKvh7SaVhbccCoVznm3KE?=
 =?us-ascii?Q?UvJYV6ZNYGrukyJ/f/GgT6M+26xb5dCvfh4tZuruPcbKHQ8LqNmuH+gHWl9+?=
 =?us-ascii?Q?VFpjFG23EPNy1uc2eCKU/6l1NtWxN3jPiDc6eEq073nrG7qzozCFgFZ+YbZq?=
 =?us-ascii?Q?lzuTI2LzHp26jWjjCAyMsu08jg1hyBCdi9XOV3/QDtxlk04ZGibvm3NMQYlY?=
 =?us-ascii?Q?WTPxfHyAs/WQtf4QagkLhv01C9EBbaZ3UjAZad8wXbBdhxPSFnF+USlLdDJX?=
 =?us-ascii?Q?RD8v0vOMAwKtNuyyp+59HRdK1Yfbm4ZmhGf1HPRvcJBt7DPxkk2F/0DXwcWi?=
 =?us-ascii?Q?OuD/MLklggNh6IBJqLm8saOf7MZkD4m8DHWkEPdtMrQcxfD9X9YGe3lHSUn4?=
 =?us-ascii?Q?OvCYS9m+uUOozFBZGRo92ICt5Nmm0JoK4SwI2TehA6aEBeJZDFJ5ihnU5LSw?=
 =?us-ascii?Q?0zfzFJeQzBdP3DQwfZR+q4UMpNajCpg21tgCHdidfj5B5SuBdyBFnxwTjX3X?=
 =?us-ascii?Q?SHVWP8s6NCjc3SmDzw96T0Xxv1yIlWivfiQuTLykGN+6mTFiNxPl/tA8ZL8o?=
 =?us-ascii?Q?XxGNkWJc5LkHxG6kI5RuXn+JbWXaSv20W+gO5xAVK9REy1H7GawMCVAjhnA/?=
 =?us-ascii?Q?ahiz2HppxA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc6e65b-964c-4e8e-1025-08da0e62913f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 13:22:53.3696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eovuh9E51If5aCwzYQoVxodfUKukN055GDC6CLOnVdqQUuFtOlAxuCiiLEXZbwsR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2995
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 25, 2022 at 11:44:53AM +0000, yangx.jy@fujitsu.com wrote:
> On 2022/3/21 23:32, Jason Gunthorpe write:
> > On Mon, Mar 21, 2022 at 03:55:01AM +0000, yangx.jy@fujitsu.com wrote:
> >> On 2022/3/16 2:53, Jason Gunthorpe wrote:
> >>> You'll also need to do something about the 32 bit compatability that
> >>> kbuild detected - I suppose this can't work on 32 bit platforms? So
> >>> IS_ENABLED() it off or something?
> >> Hi Jason,
> >>
> >> Is it possible to fix the issue by atomic64_set_release()?
> > No
> >
> >> If not, we may need to add a check for __native_word(*dst) and return an
> >> unsupported error when __native_word(*dst) is false.
> > The whole feature, including the cap bits should be turned off for 32
> > bit builds because it cannot possibly work
> 
> Hi Jason,
> 
> Is it ok to disable the whole atomic write by checking CONFIG_64BIT?

It is not great, but there is not another choice I can see..

Jason
