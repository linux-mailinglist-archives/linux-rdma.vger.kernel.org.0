Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A871646F83
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Dec 2022 13:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiLHMX4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Dec 2022 07:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHMXz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Dec 2022 07:23:55 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D596C73B
        for <linux-rdma@vger.kernel.org>; Thu,  8 Dec 2022 04:23:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h01EfyaLjFZBNooanlPoYkVtfk4ZoucOezW9hE0fvWrxJhXfPVIZV1QyCI6EPRdbdVJq3Ur2LlKROp8oYnpxzYTEI++ZTksBD8dEQgiLK7ZZGV1w3PrhENsyMyml2KQ++JDm7t1iUTKZX0J/sFWmITv+6W7+VtDPABkTa71F4yLNS4V0oqie2vW2gLQwq658Chlies04TxUmhC7PvhrfQ24iO1jxju0lRf5sY+aagi3XM9osyDzkHT9SwhtxgUBhY0MVpfYrtjdq4z2Rdn1fzzJS2PPp99gUSkBMPor8hBuW4DnxZNbGXG8W2YtbSwYS/0t8P9nucvQd6dvT1ylMIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mResQQvI8ko8fxJNFi/mG+bsOsWItKs2g6avpuOhTBo=;
 b=fJMTQmfLwGwWYdVnHCW78+l+98Xgx0GTwBb5N9JFG9eHG0Qew0hOUxU01mZNTC2fbqaYnuCs6p7zRpBTH9MR1I7iwwFFWZZ07M5+PsQt+trFYbtSPaFWpLjj64GEEuA1GHnJGCq3fN8BBAsyx+XSg7kHtt0VEw4fUkXYy5DSKXBkTrh8p0BsmFpL058cASBGA6j3gvMzbbKm2nC3jKVCu+Y3FVcgEozjF8s5HZPfxL1fRn6OzFCcp+McHcMYtzdnkvaqJPdzM8t2ne8Q85UHJYZbnvaoskqgOmocWeFk9CiyBPf7UEICY8p+ntWottVV8fKaDaYHl4zPuH95vGY5hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mResQQvI8ko8fxJNFi/mG+bsOsWItKs2g6avpuOhTBo=;
 b=HqTMEBw5KkeOZbA27Ez/iMvDqtgalvT39xJ/dJmQO+fQ0c6/6f962z7gkR1GqrvYHpwnc7midMp985yJGwDARk0Kw3Yv3F5ZmAxLMrrezEq6GST3dIo70YVBSnrdhzaLRCyh0+BEtnf367l7BizmWKi7jJyq68mzYOKF462va7xh2XhjPjt7Zu1SUq49IZGvNFb7nweGUB0DC2XDm9CUFsqt5A5jGn1uYOFdXiR6Np82tpFRCA/oLnV6ff30MVyG2T1RxOU+BOLbMHhG2C2FJq/ZCiFoOLnu/CSnmAnc0RGJNWKblsbw3AO7gB5AVxK3B96FXR6OPe0I35rVuQIyRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Thu, 8 Dec
 2022 12:23:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 12:23:51 +0000
Date:   Thu, 8 Dec 2022 08:23:50 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH] Revert "RDMA/rxe: Remove unnecessary mr testing"
Message-ID: <Y5HXVisxlA2MsXT/@nvidia.com>
References: <20221202110157.3221952-1-matsuda-daisuke@fujitsu.com>
 <Y5ElLH2Lyw0466fK@nvidia.com>
 <TYCPR01MB8455576D21C033F8694EA5A8E51D9@TYCPR01MB8455.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB8455576D21C033F8694EA5A8E51D9@TYCPR01MB8455.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a408ab3-b6cb-40f9-51b8-08dad91710dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sv9LKspk+0r6IWbefPqs9M2ql+vnKadwXnyMBwzoDr6wFeDb1j7fFXEiXQ/jfJ0QnkEc6LyncVi2+UfGVHWaGz2oG/vcgS7aZ8Tm0esNHTMQ0mNyId7NhKsYNPSleahJhT/vY/ZeFeaa9yKJWivlirhho2IXitmSYOUzo2e+BYZ9SDkEReOFbAKTjeCucufAL2lTQBkVYbk4qJLyXWoOi6fbuvGa8ojCELqRpn+DLFFHVAaqSmck9/p/3zoBkfpzpnOWBdkO+seKWoUnfvFsAgcBkh7lgC/MpfwC7ORtg9qfRfqjFuHqkCPD2dMN+guBDNIwKxjV8osveKNkPfjVVk7zBi71rrmtBcrYcCLuhjF0z5l4DaQPf2OOsxJu2AOFDeIa49+XwX8bmvCODR+CiaPAlLzfq6BRTXkaTA4GbjzFGcQTMSkvmXzqooZTwVBAELOH4FN3+klRVEmYjShCkJNW20vXaAIH6kQzBNW2skSck99QML7nHV9CjECZd9/b788Epr3A8WBWfwCt5DkzF9aKYlFSfh5XwHSRSmV4l5D4A/ZmhsJosbBzGNP9zIOEUjSZcPDy7PNWiQ1bNGbFKlR0pejyfKoAb07dBLQWa4QOpNgM+yP7AUioZMcAK99RSoxbzsIXpVbI0TuyikvsnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199015)(478600001)(6486002)(6506007)(53546011)(66476007)(26005)(2906002)(36756003)(6512007)(38100700002)(54906003)(6916009)(5660300002)(83380400001)(316002)(66946007)(4326008)(66556008)(8676002)(8936002)(2616005)(86362001)(41300700001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3eELffjOFyb2HMMs09o2A6goQAtPXUNv/Cp4m+TlW7WQfJrmZtdUwY0fh82H?=
 =?us-ascii?Q?/XLn/mhkLJUCneJbW4BzvvM/UqjKUovIDN7+T0MHr36NpPqLdAtW/eH/ktLy?=
 =?us-ascii?Q?ve+Jm4Gak0dl0RWeVZEo0nisW9ae4YGM2OKgYeLJ6jGnh9lRWwZ8qGPW+80E?=
 =?us-ascii?Q?yM71KdcSIYXlPM8b2mtid919YRQS3DJAcrV+hGFSscm+onRJlDVoOZMn2Aqv?=
 =?us-ascii?Q?saZXwDZKuUBZRrC12vlbEwCPkWWFCzTeJCa42jQXMDI1wWokvH1EWTutqtal?=
 =?us-ascii?Q?vDZd8SMkDzzsohzmQJGmOBGRwh5k5xTo3F+b2eRNkPHn3pvwVTTgi1HaK9jl?=
 =?us-ascii?Q?cJyMfe1w/BOcEq+btG4GpI+jnt3oqOWQKepTcFEgUwiJjB3dkAwPELe+zFru?=
 =?us-ascii?Q?7QZ5pAk5LzTZ5+ry/KBR0jOhMV2HSFVLvheSxaU3Ai/IrrYXmQBBEXjqCZr5?=
 =?us-ascii?Q?dvYH7EN4RYIpLVoxbCKBmUZqfpesXfoWusNw01cYmQkk5FRN9BaQggmL9ZUq?=
 =?us-ascii?Q?8z3OKOQCetXek6l66ZfOSCD9K4pr3Prquk9hL8Lk4NkYcMRRaTf0NoLUEBdK?=
 =?us-ascii?Q?rFe9bLWJRC8bx1jUrcFKzqwRNjgDkCA3y6chzyD+kQ8Qa2BHuGeYyNmk6Jfy?=
 =?us-ascii?Q?ndy++4aLBDjr0UQesWo35y+AzQG01Nq+mtgFMtCBcDsfUNXR6gvLBN9U3AnI?=
 =?us-ascii?Q?zbkG0f86DatPygmBYa82qJTW/O/W36I1CsHALGGS96CJIBuZAlZbll5p4iOk?=
 =?us-ascii?Q?R+vkYzx2Nb62PqQ4o71UuIkFawe+0D0vqlN1cx5hlXtoZZw0x9nkbxXp0XzX?=
 =?us-ascii?Q?YP006dD8diMvgVgl1FT3bVCAFfIWuRFT8JvBy84r8dUD+juqpzUmNGCWbchJ?=
 =?us-ascii?Q?YwCbr1MnmALYS50ObC8WP0qQTp9J6FkMkc37qBOn0RAqkEOGzE7+VFg6QkHF?=
 =?us-ascii?Q?zWF1PpJr9IzhItLMoMMq268+zazE2HkPAr7Rw7MQj2dhJPfvIPy2Nh6Pw4DJ?=
 =?us-ascii?Q?sxcRVy5OFuATRfeoeoxmPG0e/C7E2PQ0nhVUXJ+MZVzBpOUI7src/DIO0lNg?=
 =?us-ascii?Q?hvpB3Sz9qZsvvEE3Y1VL4vAwQ2y8K3jwifh0DN9ErkyqbKd/sGP0uii9RSyB?=
 =?us-ascii?Q?XJf2V/wlVB5s8qHoM6nHuvmrr7Vs+wFIOLj5Z0p8RWKDp5XQBOM8hb6AsEEy?=
 =?us-ascii?Q?l/8hTY/sU6tU3/52CutdLm8p0HkzE/bTKdZ1CoI1mTBXxTbtD3yIm1Sq/XHE?=
 =?us-ascii?Q?aC/NyNngny3S9p+txxMq/qp7AV7cOsnON+D3mFAsVDwZUOQUX+xiHu8fHDx2?=
 =?us-ascii?Q?92gYwkEYt2ltz5wUvyn1P3J7XoN9UGwisoXlwdqaCFQGlmU8LlwWjVpEq31n?=
 =?us-ascii?Q?BRnlYLqPXSfMcVJOqY7/bItEPAU8UqFkAglKzSPU0Ss5ZmmcMcjXOGIikpxe?=
 =?us-ascii?Q?IURsW4rs/mxiP6F7F5M77FZAtf/QfLJYuGm+hB//6DIRgJrosifFQ+mG3onP?=
 =?us-ascii?Q?cxt7PnJ/q4ajPA9G85uptwcnfofAUJwe6aODLmoXc2ltZrIFOLTIAgJvSnNH?=
 =?us-ascii?Q?crr9jUtCQRWSbr/K/zc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a408ab3-b6cb-40f9-51b8-08dad91710dc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 12:23:51.8101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBW32IpZ9HCAjS+Yv3cY0/B6SzCSm5Iq2a3M8xCztN/fD4q0QOhyasIeuOuZGknw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 08, 2022 at 06:08:30AM +0000, Daisuke Matsuda (Fujitsu) wrote:
> On Thu, Dec 8, 2022 8:44 AM Jason Gunthorpe wrote:
> > 
> > On Fri, Dec 02, 2022 at 08:01:57PM +0900, Daisuke Matsuda wrote:
> > > The commit 686d348476ee ("RDMA/rxe: Remove unnecessary mr testing") causes
> > > a kernel crash. If responder get a zero-byte RDMA Read request, qp->resp.mr
> > > is not set in check_rkey(). The mr is NULL in this case, and a NULL pointer
> > > dereference occurs as shown below.
> > 
> > I don't think this is right.
> > 
> > What justification is there for not validating the rkey in check_rkey
> > just because the length is 0?
> 
> I referred to IB Specification Vol 1-Release-1.5-2021-08-06b.
> The behaviour of responder on receiving a packet is described in "9.7.4.1".
> The current implementation of check_rkey() is justified by "9.7.4.1.5 C9-88".
> 
> > 
> > IBA 9.3.3.2 says:
> > 
> >  <...>
> 
> The document is proprietary. I think it is safer not to quote the contents,
> so I do not show what "9.7.4.1.5 C9-88" says here.
> Sorry for bothering you, but please check the description by
> yourself.

Well, that seems clear enough. Let's reference C9-88 in this patch as
well

Jason
