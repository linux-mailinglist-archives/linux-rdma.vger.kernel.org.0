Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11974495F52
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jan 2022 13:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350527AbiAUM6l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jan 2022 07:58:41 -0500
Received: from mail-bn8nam12on2081.outbound.protection.outlook.com ([40.107.237.81]:1677
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238446AbiAUM6k (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 Jan 2022 07:58:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UD23FfXjxyRCrHbs0m5muetO9ncxd3lqrizcDGHFm5SLqr0kUIs4jhfKMn0nEDHfNPiZNgbvna+f526yXyLZdVasZtuYTtBPKkI5CTsythfDtpQ7UywwSDUtVUBfV9YtS7GkqgsIFYnGM5PglgNc1jtu1R3/jFyXz4Llt2E7CB05t/TpnwtFbBY994aMuSsSQcKc6oLTQmO4hrru7RFqHTkTPbKW3nniUi2GkiR9bAGUqtOa2oHks9a95UWcULSKGwCpwqb9yUrQYZmBc+SP0EwZNAqGzXsvtafLxgD9xtGMRiunDVhI4eFxjqf29atk9er0mu7mRoKXbQM1K2pQZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/a6lVYoKi2d0FKCyHWIDB52IJ28u2AaHa2JG/SM+x8=;
 b=d8W4OPthHMSkzEjYjs6OKn9gKTo8paTqRemYHjp8U3RDIsKs+53jn0JHPvNqvtbdfBP9hNPY6NsVjPM4CBPn6CYkHVQpdf0C+uCQpzNTHyPHnA+s0O6eL4JdLSxLvbSBHUj/huMWX2P4PS345/67zrKz5sl2ofPwLwUha+J5BP5VoAtkEj+9rCyIs6qQjLnYtpRZOkU+BfJ0PmRNM5Kgc/MaNYsedtvnM2uLSwCmPoWYjf1oC0aiXOG+IKoNwtQErUOPuDMni2sHBsr1p3l9sO2R0rcWr7fx+vfrYIBWcajfThDAZTJQjVFibaT27EF8LO7uZtQ482R1jCRvmF7HuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/a6lVYoKi2d0FKCyHWIDB52IJ28u2AaHa2JG/SM+x8=;
 b=TX3mhGkE1UytAo8EFxiKkt2PjEg1w+3ir6kQp7rpm/RyUdht+fyalE7fCukJDfJ011lARVFT7YOm+fO7litujVXHqzDBIBqMeOqitSNqPlzJMvLeltjd9f5Iz9zTyziQASDvGjP2wklNf8hgxmmt5UWIusGAVDe+M44Unac7zkgF7nw++gHQM+QLeZbaulkq2GFzNKIYgQQ7sGtpo+dPSCfDzJVbkK6Bm4M+XXKMzAOyMMtQSng5ApE9cMkAcrUcKZ4jOIzvsC7qZuEGTZZXtenl67PjWe0jKt5lt23gCA8JZigZusH8t3IjjNLS9JKGDMtBJtb4vNnTkOV1ShHeHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by DM5PR12MB2344.namprd12.prod.outlook.com (2603:10b6:4:b2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 21 Jan
 2022 12:58:38 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%8]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 12:58:38 +0000
Date:   Fri, 21 Jan 2022 08:58:37 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Li, Zhijian" <lizhijian@cn.fujitsu.com>
Cc:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "tom@talpey.com" <tom@talpey.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Message-ID: <20220121125837.GV84788@nvidia.com>
References: <20220113030350.2492841-1-yangx.jy@fujitsu.com>
 <20220113030350.2492841-3-yangx.jy@fujitsu.com>
 <20220117131624.GB7906@nvidia.com>
 <61E673EA.60900@fujitsu.com>
 <20220118123505.GF84788@nvidia.com>
 <7dfed756-42a7-b6f7-3473-1348479d30db@fujitsu.com>
 <20220119123635.GH84788@nvidia.com>
 <022be340-a49a-1e94-5fb8-1c77f06fecc2@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <022be340-a49a-1e94-5fb8-1c77f06fecc2@cn.fujitsu.com>
X-ClientProxiedBy: BLAP220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::16) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47521aba-a129-4423-a378-08d9dcddbdd7
X-MS-TrafficTypeDiagnostic: DM5PR12MB2344:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2344F1C237923E43218D2247C25B9@DM5PR12MB2344.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mIGKKc/s+WJfFzWkQMWaurpFN5w9Q2i7lR9kNBTTr1tJ8g1O/Ur+e1HOY7M6pIx2gDYdFsFEy/00WeFNV73bnF+LObuieWfhHVddi19ma88Fw3NF+BdfDN4+DIddW+/k1AOEOG8ZbVUofhzsaaNmp74imZ4oy02p/1NmL3bquhxRp81R6dDqDnPMdPiLHtiBZcjhe7/R/xLFXLneUNi//eRh0CiHVFYIAkO8L6MsWCC4MQuvqoQgkZZvwRheKYbonR7SI2bt5aq7ciRkkj7nBRujJrbvXKodasBwcXjDHUOjE52UP3W+9bIDiJmLsfVK2PleRP25EtflfhJY+6/UBFXChVWYsUlXYPoJ3zlPuIgUxVpWrZeSbOVrEBH5fJGEvXuy6Z7QYzxYyfSI44QnVgngWhDlZvpPggQ85cl34JuoE7/DblfqOZ14IvYtzXlG/d3Kp1EleqsZY03d76gVzForUn1HbU1eJ0nig7r4CCOIr1a2vorXnkMmr7yNOQCuH4HdsSgTu1fwfZGDfkE0KUE3bYKrZqx9p5bDM3pi4Do8/8ixSAgKWQO0t+RxxTY+FLEMGVdAt4K7Xv/eQi+AH3olXgh74G6ncfaIIddDDjKIgvUcmZBdL9PnlVYniBESgmvTaO4M2AyvcG1qieHRiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(38100700002)(4744005)(508600001)(5660300002)(6506007)(66946007)(36756003)(33656002)(66556008)(66476007)(6916009)(1076003)(186003)(8676002)(2616005)(6512007)(8936002)(26005)(2906002)(54906003)(316002)(6486002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SyswZTJMOGY2em0wWEs5UUQ3UWlOQzJLaldZWVFIVjY4V09pc0tUWFpYNHlE?=
 =?utf-8?B?aW1DdUlqalFtMzlwa0E0S21hMHVnSVdnQm1YMFcrZ1RjaHAva2J4eFQ2VVZl?=
 =?utf-8?B?UERvNUVyNzQ5NFJGQUxWS081cm1SU01DMDJBblhmcTBXMFgvZ1VBWXFqRlZj?=
 =?utf-8?B?elNUM21JUEU4U0thWFE4NEJhVVRYWEUrSlREa2dqbmFwSER2dXZLOWt1ZVBa?=
 =?utf-8?B?YThUakZkd1FTRCs1Znp2ZkxVMm9HZmF1TWhQWnZORmdVNHROazEvOWdiaW81?=
 =?utf-8?B?cERkRnNCWGovSy9wWXMwMm1CWi9SdHpERCtZeTlUM21RMTc1MDdzWHUxRzkv?=
 =?utf-8?B?NFNCTUN5Y25oR2RkNTl4T2FRMUtmQVJrRjFmTUczSjgwQ1FZcndrZ3FMWHF3?=
 =?utf-8?B?Uy9KRDlobGxSRk1NdmV2Z0dvNzdMd0UzdkZhck1pb3ZSdjAxdWlNRXZHVmZO?=
 =?utf-8?B?YnJodVNFdEhYcFhYWm9iMWw0Umd1V2RGK2FpODhIckdURGpjK0RzY0VYbzcr?=
 =?utf-8?B?SUorbTQ1MkFHYmtWSXpSbWpsaWJqOUorc1FwT3duMVBGSGlldVgzMks0QW1I?=
 =?utf-8?B?cFRyWUJabzJiUW90ZWJ2RThSS2xtb0VrVDhYUzN5b1VzY2ZxZUJtVXBxazdY?=
 =?utf-8?B?ajg4aTBsYTY1TEx1aUtlMmwwQTVySDZiYkVtQ3NPY0pjT3lIaVlld0wzZ3g2?=
 =?utf-8?B?NE9vWmFKVFNHVjZXRlZ3UEd6VnBVV0JScS9YaFdNUVZHSnRSc0FWQWIwMFNW?=
 =?utf-8?B?TnJTRkxZZU9uVjMxNGJXdTc1dEd5QnRvQUZWMlM2VUphVWdCSkltcW5QYk90?=
 =?utf-8?B?bXpGQXBJazBDNVU4dGdIT0ttMGFQRVJwVkFWcHNrTy95TEsyVFFZUWJCVXRu?=
 =?utf-8?B?UllFMTdMMFdpd0RCS1NGdWxNaW5TSWFJK3JabnovU3loVXhIRjh2MDhIMlJV?=
 =?utf-8?B?dzNoNXZEQ2lnWDROQ01WSzA2b3BGR3FrZHJIWm5sdGgvaEorMUk3cEluNEU5?=
 =?utf-8?B?UjZZdDZPK3hGTmdESHlkRFZCWHdzcnhSbXJQdm1qS0NwMWVNeGQrV1h0OS84?=
 =?utf-8?B?emNVR1Z0UWdERTRveWN3NW9kSXlzc2JaR3hwUWhic1F0RDVFNHB2VzhDdjhx?=
 =?utf-8?B?NitHKzdvLzVYVzFiT0gzcTVaSVZjRnFEMmwrUldSQ3ZkWTc3Z2VQaDN1SW1P?=
 =?utf-8?B?RkZ6SmVuUFBDem42Q28zYVpCTEkzMStEMjc1MlFDZTIvNU9uLy95YzBDU0xK?=
 =?utf-8?B?S0FsdUhUMUxGTlBqR1ZyejJEWTFQRXdWMTVLTGNVZlk4NzVWY2JyZmVpV21v?=
 =?utf-8?B?M2pJSHNRaktwWXdRT2dPQVVFNnZzSEZOeFk3RGRtd0YvR2VPRWEvTnZsYkt3?=
 =?utf-8?B?R3UzT2R4YktlMVBIQjdVd0Z4b3BmT0pGQzFPZEt6Z2xyQkhRNDkvUnNVS3Vq?=
 =?utf-8?B?UkM5UWVQK1ZzVlFGbWVaSWtZODJIcWc0V1B5UmNyRSs2ZkZKdzNUWE5zbFVM?=
 =?utf-8?B?Z09mL1A4WDgxbkhMTENZdlZQWUY5ZEZEOG5IREhieStER1NlQ2hNc2tGWUx2?=
 =?utf-8?B?d0hLZnVYYnVYSTEvUFlKVjdoa2RGR3lCb3laWDV2YkFGNG02cHEwdmNkdnd2?=
 =?utf-8?B?SmZzK3FNMUZkWFRQSUVHaVNoeS85TmxteTZySXlzeTB6bnJWM0cwdjBaK04z?=
 =?utf-8?B?UEVyR2pLRmNVcGNVV2dRdjZKb3lRZDlHZjdWZDdiVklydkxXRFA4WTNmT29P?=
 =?utf-8?B?Sm1ESlZESjBsVmJBdkVZckVlcXQ4VHJPQXFybm1IbkVjUVFvVHNQeVAvMWxS?=
 =?utf-8?B?L2c4VjFhYjFMU1lDR1ozdk1PRUViR3h6NUY0YlpxNlBLNjRNYjlROXVtWlVB?=
 =?utf-8?B?anV4akkwMU5hd0FVSk5TQktGc3VQYm9QbUh1S3ZxUWNoV2N3RnlDVWFYOHNE?=
 =?utf-8?B?bkgvOHd6S2NKUVhQTXZEZ3dNS0tBVndLVDRIQUhkVGRDYWVBSEJwSWZ0RHVy?=
 =?utf-8?B?VDRSK1ZCc1VSYjVocEhDanV3YUlqeE5sZWM4aWdHNW9tRE15ZUdFOHNTTjJj?=
 =?utf-8?B?MmtOcDVEUGhDcHJSUTJzOEsrZEJmc292WjFRYVE5TnpndEM4cHF0TU9OeXVV?=
 =?utf-8?Q?3QM0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47521aba-a129-4423-a378-08d9dcddbdd7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 12:58:38.4138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKs9+NNhquKPmPgY3bYN+u48Pr3XNcfI/mndX9V94AhcxFp+U+hA2GhqWovYSjgV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2344
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 20, 2022 at 08:07:36PM +0800, Li, Zhijian wrote:

> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c
> b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 0621d387ccba..978fdd23665c 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -260,7 +260,8 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64
> length, u64 iova,
>                                 num_buf = 0;
>                         }
> 
> -                       vaddr = page_address(sg_page_iter_page(&sg_iter));
> +                       // FIXME: don't forget to kunmap_local(vaddr)
> +                       vaddr = kmap_local_page(sg_page_iter_page(&sg_iter));

No, you can't leave the kmap open for a long time. The kmap has to
just be around the usage.

Jason
