Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F58469E84
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 16:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377498AbhLFPjT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 10:39:19 -0500
Received: from mail-sn1anam02on2071.outbound.protection.outlook.com ([40.107.96.71]:26179
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1378925AbhLFPgs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Dec 2021 10:36:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDNpNpotnlL56xT+oHHhbLPCBckAvHsN01PdMNNoTmGWojBFTpTjuit2cj2jRWeVvIo46OO+wwnxlMLosFvJlc4gFkiPFT+2AGJ4ttg9/vIfsuwSexIKHrBBme6qZlQlonRKyBPdkotDnkpLCV80Lg/PoXacs7MCRGr9gBXr9w4x9Cdrgp/kjsiy7I2VUxa+Fs77+7k+CllqEKqXk6KAWFaDmfP4kitRMyH4GuMTTiKo0QJJMXoL6PPqCzOEyG0WoJEPOQdPFfEEH2sXGRi0xqPZ5QGVMRDwUt0Oc3X7Cz2QxwM5a4+WQxOBgESRy0u0LlrxjAUk4pES75d4G7PA8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sx7i9Y7EhIuoXiL2bsSDvLT2TzVr82sLiuHG3c3HWPc=;
 b=djMx68ueXoKF4YNo6LnWLstrWjrjsY5h1OU9dYpyTx6ICRXm3xqbN6GvyHrte/axeMdhpZvdPt+OlwVpMSC2AWQVRKwcpglioFKhTRpc/GBClxS0IEGGDRdUGtySpPQqxYS5G3+tdNI6pK1UeJg2MqehllJAkxkncYm76aFaNefWOc3chKYqTQXYE24+3dt1XxjTLuATvIiPsM1iTi0B+KK8EXqOIDkltt/SwtYDPgB3uAhHkLj+FD4uyIDOF1ZBXbjcWfTHedLrTOeqpXpJNbnIXsTcclzqjjmdY/nX8svr0M531xqW1RlTvRF5poUmdyGg2QSt7LVL23cNd833qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sx7i9Y7EhIuoXiL2bsSDvLT2TzVr82sLiuHG3c3HWPc=;
 b=oB/Lf3GaRKGcJdpg+y+rBf+RCuYqVrEC4f2RM016rncm8DKG+fCNdAwv4HZ+xx1Xf226q7KwnOnmPr5oGIkgt+cXQY9OKNy7A7ovgN+KWIWfauJyrVVXtTMtoEm4R0Ae9gZEKAbFqMQhZ0eHMe+uIhzPDPBsYq7gFXy4EWTE8P0/4IRt0uEbsqdCPHMdX/UIXlRHsVCzvD9NmAJYtCK3wdWfPmsk1hG3lYC3vbMuabAGNXmF4YKT+ajtRRFqbDO22DYtsWDaveU1LB9YfYIPqaL8JMkFvV9uZDfKl81NGTxR4ut9qx62bmu4B36glVJeHxRpVrBQXMTML8ezVc5/SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5223.namprd12.prod.outlook.com (2603:10b6:208:315::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 15:33:16 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 15:33:16 +0000
Date:   Mon, 6 Dec 2021 11:33:15 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Lameter <cl@gentwo.org>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: rdma-core: Add support for multicast loopback prevention to mckey
Message-ID: <20211206153315.GH4670@nvidia.com>
References: <alpine.DEB.2.22.394.2112021404100.58561@gentwo.de>
 <Yay9+MyBBpE4A7he@unreal>
 <alpine.DEB.2.22.394.2112060811510.163032@gentwo.de>
 <Ya27hlT3SwCdBKZB@unreal>
 <alpine.DEB.2.22.394.2112061317260.175585@gentwo.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.22.394.2112061317260.175585@gentwo.de>
X-ClientProxiedBy: BL1PR13CA0204.namprd13.prod.outlook.com
 (2603:10b6:208:2be::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0204.namprd13.prod.outlook.com (2603:10b6:208:2be::29) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 6 Dec 2021 15:33:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1muFzP-008xkM-8O; Mon, 06 Dec 2021 11:33:15 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36eebc3e-55f9-4141-c894-08d9b8cdb8f3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5223:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5223A768AC587717620369B2C26D9@BL1PR12MB5223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cJBEnFLJscA2il+C+BOjqtlbOlwE9n3VTQ/zAd5H2Q/pdrVUYnXUdjMTkPX8Zw8GpYVLYnH2kaUpeDjnVzBe6qQ/u0DN3EjKNori7kTjvgdIztfdRvqqinhoS8GEwJWgQn0soN9rcSTcryTEatWpuefex2B4Sx0FaImx4BgtbggS053RXepBNMcM3VYB4qbQTJsJ3HR+oZpTNR66QrQJbdHMQKjlP5Cje4bx4rX5/JkqUtQ7YT3xPYf/G/6vnxNHhpg6+Hl1zlaqZ5JGtThSyj1Cr44UEWa7WSVMrl+283dJhxbhE65H3lQJyTBEt2cf63VKQm7meQNb0eI9+AozLdtKQZvA5vNy3PGQfBfIgu8fK+gYt0KE51ePTvNilGb844pfrwi1cVIEolZVl2pY5XEo8oIIMcn6TWZLHCzNjKJt1JMoUodtP7LY8r9ka4X3eQ6wWpeO0vHibeznXsTNQ4z1uqkqfXou1tjWR7eTHb1yvh7nKOkGxMM3WtlYoVTTifg7A6I/TN2LxlEv2aA/8kcgIAtYL9JXTDnG+C5n9HD5g9l+vmQexajjjblLtS5Q9kNpELvtUMHvujBAtknEZA6U4xcppP+ialcbM3Dxq/UlkLdaonZuw689wW5FZp9zFZMMtNDBfnjg7Vx6e1IuFEhdhaY0VDCGzANR4db17xZ15hLdwEFi2PEyanlfatn3EDGWVo0rwPj/5QX4P1BNiv4XUmF3OSNC2U647voVOAZHpTlrMlVUAgvNAA5KusykhpG7zJ2mFKm5fCCNDHAtSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9746002)(86362001)(8936002)(83380400001)(9786002)(36756003)(426003)(8676002)(84970400001)(966005)(508600001)(2906002)(1076003)(2616005)(33656002)(6916009)(38100700002)(186003)(316002)(26005)(4326008)(66476007)(66556008)(5660300002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0lTMVNOemkrVkFUNmo3dzdEZ214STl0bkpXRnFucEdrMjh5blBveVZCcnVl?=
 =?utf-8?B?TnoySnROS0VrV013QXVJKzJWU3dFdEVBbjBqSFdQZW1FRFE2enlzaDdPaVZw?=
 =?utf-8?B?U2dUeFF2UVp5ZnBzNFVFWk0vT2wxamxSSU1pNElrL1g4M01mTFlNV3VIYjVS?=
 =?utf-8?B?dHlHcDEwTE4rRStlWjh3SDFCRi8yaTR6a0Q0a2RvSXRseFRaRE04ZnRiNGJN?=
 =?utf-8?B?eGtHRDloaW1hcWtpMU15cFJDNVhlRjFvaWRPTjVVck53Z245UDFyZ2J1TnUy?=
 =?utf-8?B?Y25NQlFpR1AyWk5XTXJPTG9GYTdKcGZneDI2b045a2FmMkNSQkpmejVSSFJG?=
 =?utf-8?B?YUlPY1pCL0RvTGJ6UVovZjhSd3QyRnNkQ2ZzNnlIRmREa3VnblFPYXIwV1lI?=
 =?utf-8?B?czhGYWtGd1VKL1piLzdtV3p6TTNtdmxyY0hWY0dudFVqb3Y2ZnNQczRvclBH?=
 =?utf-8?B?T3RRV250cnFPWFlCVDFFQkMvaGZjT241Y2g4V0xyajJON2s4aG1wQ2lDWmpt?=
 =?utf-8?B?OHJBdjlHNWcwVm5oQjlUcXZhN1ZDOWRKUnVpbkxFOXhIZVlrT2hwdjVKeEpY?=
 =?utf-8?B?ZDJzQVBQZytyQ0Irdm5pTkQ0S21UaFFJdVc1c1JGRnZ3VXdlT1ZiVUdTMk91?=
 =?utf-8?B?V1FweE4vMHV6SkpKam5aOE8xUUkxekNkRVlud29yUndNRVVmVTVXcjJWSXQw?=
 =?utf-8?B?RmVLeDBoSjFuSVJYL1lBd0NreEs5ZEpzRHViY0h6OXl4WlhGV3EzQ3pVR3Jj?=
 =?utf-8?B?cVVlZ0lDampWRVo3VlY5ejloZHd2OXdKcTJqalFnZVdlK2FmWHNYaHlsZ3Ft?=
 =?utf-8?B?MDVZQjNCUEkrZkdjcEhaTEhySmoxTHBraFk4SkE2enZCOUt2RUhVcFBmc0lw?=
 =?utf-8?B?UUozY1ZpdExPclpDcG1Nbm9LYzlJajhEQTJDRDQxSWVIRys2RWZqNTB5U1JY?=
 =?utf-8?B?dTJscGZNNzFNVVBtQmVvWkdTcC9RTTZCZk51ZnZwcjdDVFVROTN6VVJVSjNj?=
 =?utf-8?B?ODZsZE5RZHFGL1hQUitzUVEzQjNtd3NUMHRYQjUvbm82Z3ZuUzhKN2xtQXlZ?=
 =?utf-8?B?U1VJWkltTlZNV2lKMjllZmZ3Q0cxTXAvcy9jbWQzRC8wQUtndXRNTWRaWmdm?=
 =?utf-8?B?aGdQRmt0cnlYU2NhcENEKzgzUnRiY3ZaTGZKRFVmYkYrM29GSjNycEtRcU8x?=
 =?utf-8?B?ZWhZQkZlOEtoNGZjOHh5dkRwVHhWRExQb3hyUFp0L1VMaTVwSGllNnBuc2hz?=
 =?utf-8?B?T3BBdnlXa2VWdmZTeG1qRFdsNld3TmRlL2R6RzlPV2Q3QmY0WFFST2RwL3ZR?=
 =?utf-8?B?WlFjVXRaZXZ5UWRvemFnTFJrSnVNYWIybCtuQ0ZRR2pkYVBRbzJUNmdvRUJV?=
 =?utf-8?B?cHdzQ0kzTTRSR3lLa3c1d09VVUw2SHY0bTIyRStUSWZ1L2pjZE83TE8vb2dj?=
 =?utf-8?B?S0FudDAvcEphbHZJL1JNa09McFo0YTEvdm94a0dVZFZvU2ZZQXRqS1NBMDBI?=
 =?utf-8?B?QllldkxSYURZaHVHTWtxZlhtVkRvT2U0OFUxVmxOUC9Ib1lqYWI2RjJ1MzZl?=
 =?utf-8?B?MVV0SldDME56eGQ4ZXV2QXhJWG9jUHNKaHhmamErQXNjemZ0dzdraldaQk1h?=
 =?utf-8?B?MGJPZ0tZL1FMelF3Si9sN2RCZVN0SVNRak1VSzRidVZjY2hCSzJzdThueFp6?=
 =?utf-8?B?MlVjUDd4NnR2aFV2MzhnVlZuYlpQOHFUZWVNWVRWOGhsZUhzZlBVK2FJVFVq?=
 =?utf-8?B?Yk1BUVk0YjNoc3M0ckxXd0FnOHJKZU05Q0ZPWXlOL3VFczJnajlhSDRxNVMw?=
 =?utf-8?B?ZUFUUTZkY1ZKWm5HMFZoY29GOHM2V1laR1ZPQ1oyeFNld1E0cGFFemE2Y2xB?=
 =?utf-8?B?a2xTVVlCMXQ0aVFXUHBERlNuY2w5NFVKR2E0bkNZYWFpUUZCUUM0ckJVaGt1?=
 =?utf-8?B?Sjc0TmVaOE82cG1NOTFYTndwMjBrbWY5V3A2SVR5WkV6dEIwMUdIaklHU0px?=
 =?utf-8?B?SXhONFF6dFJqM2NKSEIzRmtWZE5iQTBOWExmbFBtWDFpREQvODd3dmJSS0Rt?=
 =?utf-8?B?ZWdBeXFoVWhWVzhJekZ2dzk1c2ttVnJWa3Bmdm1TVWVWcnlQMnFaM3JWU1A5?=
 =?utf-8?Q?CFB0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36eebc3e-55f9-4141-c894-08d9b8cdb8f3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 15:33:16.1988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H++wt0iLrt1YdyFx4xzyCt8OZPLn59Nrlah4tj9p1Jruwls3pDfO28Pcc5CELBG7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5223
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 06, 2021 at 01:18:00PM +0100, Christoph Lameter wrote:
> On Mon, 6 Dec 2021, Leon Romanovsky wrote:
> 
> > On Mon, Dec 06, 2021 at 08:13:17AM +0100, Christoph Lameter wrote:
> > > On Sun, 5 Dec 2021, Leon Romanovsky wrote:
> > >
> > > > How can I apply your patch? Can you send it as a PR to rdma-core github?
> > >
> > > Well git-am would apply a patch like that but I can also send a PR
> > > request.
> >
> > I wrote my previous email after I tried :).
> >
> > ➜  rdma-core git:(master) ✗ git am 20211202_cl_rdma_core_add_support_for_multicast_loopback_prevention_to_mckey.mbx
> > Applying: rdma-core: Add support for multicast loopback prevention to mckey
> > error: corrupt patch at line 74
> > Patch failed at 0001 rdma-core: Add support for multicast loopback prevention to mckey
> > ...
> 
> Worked fine here. Trying to get the PR done. See pull request #1100

Also doesn't work for me:

$ ~/tools/b4/b4.sh shazam -H https://lore.kernel.org/r/Yay9+MyBBpE4A7he@unreal
Looking up https://lore.kernel.org/r/Yay9%2BMyBBpE4A7he%40unreal
Grabbing thread from lore.kernel.org/all/Yay9%2BMyBBpE4A7he%40unreal/t.mbox.gz
Analyzing 5 messages in the thread
Checking attestation on all messages, may take a moment...
---
  [PATCH] rdma-core: Add support for multicast loopback prevention to mckey
---
Total patches: 1
---
 Base: attempting to guess base-commit...
 Base: failed to guess base
Magic: Preparing a sparse worktree
Unable to cleanly apply series, see failure log below
---
Applying: rdma-core: Add support for multicast loopback prevention to mckey
Patch failed at 0001 rdma-core: Add support for multicast loopback prevention to mckey
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
error: corrupt patch at line 74
hint: Use 'git am --show-current-patch=diff' to see the failed patch
---
Not fetching into FETCH_HEAD

Jason
