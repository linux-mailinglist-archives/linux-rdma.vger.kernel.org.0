Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAAC41A17B
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Sep 2021 23:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbhI0VtA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 17:49:00 -0400
Received: from mail-mw2nam12on2074.outbound.protection.outlook.com ([40.107.244.74]:16288
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237486AbhI0Vs5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Sep 2021 17:48:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqpPkdJyAL+Cn97wfExAbKq9MlCecMYqj9rjOBB80LSnsApV0f9GmTGCC9wYXsrLZy5c9BTvtRCEzFdEq5VqAs60s3VaCfQeRcLZb7iZCWhs1+R08hIpIFpmGm3gUUNfiIKco0iQs+l0Ig4XrjJ/pySkvI9Ra0HXid3wYmiDTtQYX9FHt7t3Rh9nCR/qkhjiVgKR4k81aBF6DQGzJDyvBRYr7z7kBf/jQn2netKR7xoEs9iogUTTE74/E6wHFU6SlsHaqvt4/7JYjlIIpuh9z3cb/maQQbct/5NfH4aQxHD7Js++BQ4KDQIbTj3dxZ7K3oszAFWJLw9SJYd/z+M1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=v7YGpp7fDftoOaJlMdfMBaCFcSykJQBgoz+1ow+jjD8=;
 b=QToCDYdSIc3OyEUtPwOjWwPFg9/EoGn/4fcN0EyUWx0g0uHihKpuAPM8AAzrYc7nLvIYfG5Hx3UChCwtoOJ39z+FvllpscP1Zvq9JdNg2rOhlS8zhmW1yUeRLeNUDm+vVg1Tfib4sjZ6Oq1K+kXpM+QdRM+XtqlgATLTbzIIDgZkKuVZ4sKZe+l2JYWLJpNymAR6KAKogikdVt/J4PXd9iwClLMns2soNkTOrYx6hRQog2p5gO/mLL1EY3h4vxx8gohbGrTC7DJ9Rlz243gw1oFaAi74+gzqjr3G6P4nhVk/A6U1+iq8h8Qs59yNCW/jyJPqozBXgZD/jUgszIbeSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7YGpp7fDftoOaJlMdfMBaCFcSykJQBgoz+1ow+jjD8=;
 b=XKdsukgmbOSYoW77n/PEl0afgDTYf1gffVrqrMVNPUdRRB6fzfxEDnEnh7KTppL9chpuLgeWJAXIKmnCE89GsDA06xr5OZkp0MgjdAE0Wwplh2EZ9Ft+8CF5GHVJImifGuRQ2W08BMd61acn/woAYR4bsInsntKM2P9OsXfdPMdLKR0rsDhRlca3UToBbpkMn8LfzQgyudol61tg8vhPGPl3d8w3jR4yGJlZii/6LYUHaRAgXMXOBm/+ig15/QjpF8SC0DAwvyvhV9qRvcMDL34xhJwosRLXxSm2aX/1uZMaNNfNnvRJP9iyVFk122EyJMwCrTg1eE9aJ4nUMgI5OA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Mon, 27 Sep
 2021 21:47:16 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 21:47:16 +0000
Date:   Mon, 27 Sep 2021 18:47:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 5.15-rc3
Message-ID: <20210927214715.GE964074@nvidia.com>
References: <CA+icZUUuacTuaWXopzH_YC3pCa3FPB=GReJ6BwE5zJ1j2WB_ew@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUUuacTuaWXopzH_YC3pCa3FPB=GReJ6BwE5zJ1j2WB_ew@mail.gmail.com>
X-ClientProxiedBy: MN2PR18CA0004.namprd18.prod.outlook.com
 (2603:10b6:208:23c::9) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR18CA0004.namprd18.prod.outlook.com (2603:10b6:208:23c::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Mon, 27 Sep 2021 21:47:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mUySx-006f42-I9; Mon, 27 Sep 2021 18:47:15 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2d1bbf5-df04-4a71-8f43-08d982005f91
X-MS-TrafficTypeDiagnostic: BL1PR12MB5254:
X-Microsoft-Antispam-PRVS: <BL1PR12MB525413F0BC6AC0949C718AB9C2A79@BL1PR12MB5254.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UYjJ6qbdoNXukpIx1acPan7fabH/fuaAI1IduR9hdVJZCnVMZ7/eEk90phGQjsWb1R192J+txju/le0lDB/LkiqJGc6mX8FCP3fphos4SvqIvgep4V8CsbQRzeEO9SLT5TFhqEYHJj9w3YP85Y02YO5gDUzJ66vv8JpZ1RwBCxY52zY2ldwH8PeAMEGLHy3kMamTlL03vAJGwZRiP+xt8LEh7qBB5cr/ZlxWOQ732l+cddfcW0QWWD9FS6FC8JhXeIBrmJeVIfvIsePxCGTIJ3xJ49fSMO+GPBLEXR3j6t83mb4Y723XaevK0qpm5xuRTJOqsh1lo8c4R5fYZJNwYpR4oEsjNM0JXW82i7oXCQJVW1L42Qu8rgTzw0OrWlCnq8eLkviuQoWLRcQJl3FnAtpXgaDunu2mvZ+XWpF1CwRv1qp5pwfKnSXF+jQOMVH5kqJFb7rdxgZl76ygP1Fme+pbUWh/vVO+D4JgsswuIsCvzFLoPW5iIN5o5aRv8On/h7mBZi89P7snXqOuigrFl+Oib+li9vhydN9ooSa5JpbMCjFHPbxTZjsoKIqwn8bIAbZptFd0fmXMiM4hjTbduGukd1WxhWl8xuEJC1cyncK3fH3J4NMZ8wJN9GXJ4RIIRm2Hts0p3TnVopAbuh7hAlz1b8kb4j9tFYcq+MR7DC790K+552eJe4+lpGgMj/6X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(66476007)(66556008)(66946007)(1076003)(33656002)(54906003)(316002)(9746002)(9786002)(8936002)(8676002)(86362001)(508600001)(26005)(36756003)(83380400001)(426003)(6916009)(2616005)(4326008)(5660300002)(38100700002)(2906002)(4744005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jyVzinVSDAaND3B4Q617EQi/by84pbkqqjWF86f7DZpuvy34zOfKwDWwUP12?=
 =?us-ascii?Q?RcH/tqnn1Md5kylQQ1PNKkhItJ2RcPftqVI7w7kJ265ApEy6Q5IgOx4K3E/g?=
 =?us-ascii?Q?lFsHhP/zMxVvsshJte3bnJ/PUrNLtV8kaI4YEBO2i8K6U4v+PfftUr5um9jl?=
 =?us-ascii?Q?Wl7w7/dDH0fFJANmgbvEtLlT0HXmvKuBp/ddqeu7tdTGVYtGXG3ABGloOA5C?=
 =?us-ascii?Q?fTxDu3upHQLgWXcIWUDx56KFSnLE7wDKbmkKIAM/Jnb6vRM7dyzctgHn1u/t?=
 =?us-ascii?Q?PXp22Vx9BZeFwKSOUw/0omvJvebpnQSEN0I0t9a2Td7VttdGQH9TEYR/2prz?=
 =?us-ascii?Q?GNxKEBLjl5QQGO3LoBs6sTcqZdJVYE63i0WDqQkcwXKAUwjohWZjYcaWGZcu?=
 =?us-ascii?Q?PPkLA4TjAbYsluf3rNMju61aYOvxc5chi9d1WW463q45VGuLaC2YUgFByXCF?=
 =?us-ascii?Q?0gkwLCFFmOCDLPL7wIMv3EZS8i4rOLTxmX3i1rd9Z4FsAis1LwQEpM4zv7ix?=
 =?us-ascii?Q?kPf/TAFv+QA+t9jAFeCi4Xv+BlOdz7Ha7o9/qe08A5AZPGbwc8jdvT98ZV8+?=
 =?us-ascii?Q?svnxXe8K2PZ/Iqq/K2heklTYyuXtFobXaBhNNGdVI8XvgAOgHnMEbCW8k1Se?=
 =?us-ascii?Q?RnEpdlH9Olrq1vFPwSDJgZ+/TzmwX9m5niEJAh8dRb4eJobSHfbnFGX+GHO3?=
 =?us-ascii?Q?Cg14K/OKpMDYddwtgKVhHLpBk3fqywM16AVquOo/e/Jawi4JP4cfgHi3DhkI?=
 =?us-ascii?Q?fF18K7pN9OuK1Ac9S3mn96KM7XKNK4eEUb7kXHQm4tTz5u0u1YrQw772OSOU?=
 =?us-ascii?Q?rXczdOhkrCdhINQIaRUX3+iUB40BF8e9ZF6MMP5vVuj/UzArK5a3Qvett+Qs?=
 =?us-ascii?Q?pHFZ82QRUjAeELNKyrQJlZpaTWmMaNfEmdr4YUspwzvoDrpN+Oda5GuA5ldV?=
 =?us-ascii?Q?cppecoPeC3qc+m8BWMI7eZxCYuRtWb/3IR4eHvOnAIGueXtWyunK3jKH49+g?=
 =?us-ascii?Q?wUkTg8O2gow97HZd0IfPZ1VSCCSJV/L0nIHs0MTdqKOiUwqlaa2SnsIdLQn2?=
 =?us-ascii?Q?KnvncMH/RXd4gDRtHPJosvVwy7nLZgXP6p7ohPTaP1GWUil51Z8vgF0ojypI?=
 =?us-ascii?Q?BnJ+YjPMlVerwjujd7t4UvVtinjTC2v6Dn9MQLjJ+EQhK2MT2+iiqsd/bkTg?=
 =?us-ascii?Q?+uwEoD0fUzxfGfyxBIzldOa+hphAF86NTkla9r4zlGVZBeHJzafHfs7+KJft?=
 =?us-ascii?Q?pT/ZoE25Htd1ESudim5cApOtboMPMnxg8ZK6ZtiYObHpFzBNL7RdwYt+ouBB?=
 =?us-ascii?Q?ttJ4M5iIpjgY1kTG/FcczWSO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d1bbf5-df04-4a71-8f43-08d982005f91
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 21:47:16.5686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFlexQwRQx2Y90Lb0ifIM8OXxFvNRB4jd7Ux2h5aEZkCAehWVqwXPXW1rL0GtgIz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5254
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 27, 2021 at 10:48:42PM +0200, Sedat Dilek wrote:
> [ Please CC me I am not subscribed to LKML and linux-rdma ]
> 
> Hi,
> 
> with CONFIG_INFINIBAND_QIB=m I observe a build-error since Linux
> v5.13-rc1 release.
> This is with LLVM/Clang >= v13.0.0-rc3 on my Debian/unstable AMD64 system.
> 
> For details see ClangBuiltLinux issue #1452 (see [1]).
> 
> The fix is pending in rdma.git#for-rc (see [2]):
> 
> commit  3110b942d36b961858664486d72f815d78c956c3
> "IB/qib: Fix clang confusion of NULL pointer comparison"
> 
> Dunno if there was a pull-request from linux-rdma folks.
> Cannot say if it is worth taking this directly...?

It should come as a PR this week, I don't think we need to do anything
special urgent here, do we?

Jason
