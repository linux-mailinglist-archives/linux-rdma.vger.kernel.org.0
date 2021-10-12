Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A26342A920
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Oct 2021 18:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhJLQNR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Oct 2021 12:13:17 -0400
Received: from mail-dm6nam10on2062.outbound.protection.outlook.com ([40.107.93.62]:50944
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229495AbhJLQNQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 Oct 2021 12:13:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQsK7RiMRU5PmO3C8ywzhmpAABM8+1Q2TLkWIH+vyTuuf+gbx+b/gzLXyVODGUKguwW3N5mlwsDvyajbzg1ObxtO1ZK9rFAROUvlvJxf/G0BDvUPzUn20lkWFV5TUP1DbDrVteCX95LxNQ1FphB1fqXwegkzNkzJtIzMzk1UMIEaIRwsRi8bpLF3uOtwERgXKz3d23Yz7Sp5zGA5qoVaTatVbV9TkkXGGabXEpYZ+IdR80A67KE4u1qLisHqGlBoVK8+BR1rMvN27NCt2N5Sv69i4qYLCaypBB8l4Cykk4fXPTOx258RgJcuqOBgavStWCMODj69yI8M3bspo53viw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huBNme4xIeb4HvmBfu356fi+QNDw4d9bH/IvCvIh79M=;
 b=eB5DdoYvWb3yThjo9k36aFPuhBNqBM6DZwEQeJmjQkN7tHK5U7dluBbbhmTLrX6rgxVX+kqX2LmTi0jlZzdtM48oyio+OgaiKBrGQiDRoo9VNuXoT3UgDO41NP1GJzaLadyc+rU3aPhj+UCWqxxJVizr1PHauav0cgumW5PE7frFeDermLI+ftMIlrLGte70bJVamXx98fb/gDyVGMgV33KrWxGBHSdLKaycf4zjKvpZRRPMuInx8BcRZ50BpVaSKdXpgniyQiKvCJ8xeHp9B5+jBn8ZZsaXXT3boWFKbqaurccydbZtxGYLqwNdPe+tCwEuUGgWeYiaRBtUYTHvsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huBNme4xIeb4HvmBfu356fi+QNDw4d9bH/IvCvIh79M=;
 b=uU1/ucXoOJLmOAQGZhn14B/w09NtglG2xrkqjRi3mAWsaoKjpDYD//DakZUbVZw5AkpFMqqCRjrXrLP7twQN1GoLn5vGBuvPxGiEnerm5Xl42sbEU30d7MtnxdWMvaP9LuzR5s/3+UrYloyYZ+QP1L/L7uRNMBPIvEqQAD1EkD6GXLl8GFnHML0y7yY6DCWyrdvcbF5bGOAOBld35i/zCf4FZmS9QleAZlHkH+NtPHrJXtnm/oHaYznjYupmniE8NiMShs4DGgtn+Ux4WTwOdsdbnxLt1CmzAF9d/Q9053z1R7txqY/gdaTUMe/PJkv/xT9uHYf7YnpB8pBKtvX6wQ==
Authentication-Results: baidu.com; dkim=none (message not signed)
 header.d=none;baidu.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Tue, 12 Oct
 2021 16:11:13 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%6]) with mapi id 15.20.4608.014; Tue, 12 Oct 2021
 16:11:13 +0000
Date:   Tue, 12 Oct 2021 13:11:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Lijun Ou <oulijun@huawei.com>, Weihang Li <liweihang@huawei.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: Use dma_alloc_coherent() instead of
 kmalloc/dma_map_single()
Message-ID: <20211012161112.GA3375648@nvidia.com>
References: <20210926061116.282-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210926061116.282-1-caihuoqing@baidu.com>
X-ClientProxiedBy: MN2PR01CA0002.prod.exchangelabs.com (2603:10b6:208:10c::15)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR01CA0002.prod.exchangelabs.com (2603:10b6:208:10c::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 16:11:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1maKMy-00EAAe-9A; Tue, 12 Oct 2021 13:11:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af997a5e-6170-4333-229f-08d98d9ae983
X-MS-TrafficTypeDiagnostic: BL1PR12MB5192:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5192D3B1A2BB3C2BFF27AC98C2B69@BL1PR12MB5192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q8pyZoqqP4hrJAD8xUmQVtPnd1seEnkEmgJOIUwm59ru/QPNWMkzIVrFTENKYsIM70wZ7S8TOGiYY19s/g9wl3UnPM7KdH7Aghd+iJ4jLFW7QfZ/nWxPcOKmBSiu9sbhECNQHThNZ9ju3ZzKuwzayD63CqoZVE75UiL9gXbzhm1iaq3aZoeY6iDyrpUmaWk7eDw2+j1dlAYmyIttU71j7oBcBNUXaZ7Ntyciiur57eAN1FXm7D3P01c0Y2yt6qEzhkw+S6ZwwA4arjjDCmjdPPzWXKTf+s0yJ4jBTyMqUTIiaRjAbCYZxEBv4DNHlQjpFJRyf6NBylWGdZXjSBWDW1T4amy3Wlh6InjWc+sZB+02s7k46JwetcEDTQ8SM6Pmi/c5GO41mVyQ0zAuynIodB0q3Riu3YdJVs8dHj8AXEb08Y80D7HOcoIW20Y8s51AIKjvLQvXm5mqepyz6qjcDTue67m4wfVxPSMkWWGUtCE/BI5GSzVAcxCoBrx5AP8TBOELcnEOsJekNYPKp1oiBGGqdBkKN6qgMYsyNUwQGdGoTs+vZzx0Ocuj5iabZLu5QE1q0isKZBQp3LheR904Jm//u779bBgAVG0vUgHPXIzrWUbI5Au9BPdJxZ9ZkV52XyRBydf4Hd03M9rO6zIQSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(426003)(186003)(4326008)(508600001)(26005)(4744005)(9786002)(2906002)(66946007)(9746002)(2616005)(33656002)(86362001)(6916009)(8936002)(54906003)(1076003)(66556008)(5660300002)(38100700002)(36756003)(8676002)(316002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pRq5LC3afz2P2ERNfR3sVfaqZviAO16k2gJWQwnhTYJGoQCRk9tGohSM8hgq?=
 =?us-ascii?Q?5Py10tfKnwvAmTVSvqSIy31tPXwxyF4OFHB38SY9VSX+dNYWvEyYeRDPmbAV?=
 =?us-ascii?Q?bU+1F0YHdeMlprC6H4SFw3LSB7SFSimkVXhOuiBgvOntm0U43bUE9CY0t0qY?=
 =?us-ascii?Q?lqy+auhvYsY8hf8lHkb6obfjNoeeOB+3yPYlCeVap6NYgCccaKCOoTjNoIpv?=
 =?us-ascii?Q?Pb6ydVWFiiKQssmu87BSADSdKg1Z3w6apxgv/oB28p777BULm+akhkU7YwnM?=
 =?us-ascii?Q?rSMH3VSIEbHHR6L1F/w2h4gzwgmbpCF/Iu5HG3cIGMONJPW5JCKooaMsiVFP?=
 =?us-ascii?Q?zpCXZvtKxh9/bufvgAFhZ3/GsYHmRTTMnYbaq+3a1tUcGv7zxgXKAwwpGdQ8?=
 =?us-ascii?Q?+xZTsB6D8wqxkxp7rHBKgyhlzKQF2Hyh3KhgODJZBIaKj8tF1CU5lfOMku0Z?=
 =?us-ascii?Q?H0xns7uv//2LGEPH3OeS+19+wekvtlqcK7XQFvkgxwhLt3EhzxheKOqZNYdW?=
 =?us-ascii?Q?vW8gieqGAyxph3CsxUJ/d2u/9Tipba5lP1pCM/GNl9T0IZopg+6i9/QiMGyA?=
 =?us-ascii?Q?ROXWULorBorJqa6R9VYX2Wde66Z11kfCok1sYv3oKs3TRnHyFMtb/xBGwabS?=
 =?us-ascii?Q?byO+O+mu4l7BWDvHwZ68UBkZg/RdFJuiiclw8228l/aIKyNl4eNUsnYmX55G?=
 =?us-ascii?Q?l2eqcgBHl2il7Oc1ZtigCorK1RCMpsIpKP4U6/LnOrBKJngQYHU8n1pbqUNh?=
 =?us-ascii?Q?y03i37O0zPq192hBRceUq+Yep+c1T5GdOGm3z0Hk/J4ZVhzM8YyiZkWR6jrh?=
 =?us-ascii?Q?qhfuoXJAfQVSEANGbcPx8GaZpB0Q9CxUo0hvmy7D0eXjCiEK8FuLHya4fHc8?=
 =?us-ascii?Q?U1Sx7bCV5O+R4mJtnuHNv8MPZDNxAkoE7zKLvZVwS4addSUKjKDstGjz9mJg?=
 =?us-ascii?Q?ZIT1nBdc21R90bun9GG8xVTgAAlooUM2AryQTAJ0lHq07T3HHqvFKWLY8A2e?=
 =?us-ascii?Q?78kqFAe7Jq5S6VvkNOfvvZctJGMVnLthDM2LBIMhnbTMIxN0Uags5kgXbkiQ?=
 =?us-ascii?Q?Kp6y+InAD/UOGiWaayIs4vsI4s4dHKBCWTrLW2N/QUXg/SfZQwX7p0OW/p0L?=
 =?us-ascii?Q?A/orHRiu2xhIL2hLW4xo/FwBvaVsPBKiI61zs1o3SBZY+hJPE2GZJchEMA7n?=
 =?us-ascii?Q?aXTUAQyotkXOebsYUzliDA7j5w6T+C3ivAmuXK6es6J7cenYEJTqAJkL+rbr?=
 =?us-ascii?Q?qce43G7cCcN3c05qkP3u2e9f2huxB9jbUfxJex+mPgmK4t+ADwEqoRG0tQqf?=
 =?us-ascii?Q?66QGssRIG0nST8FH3bAChFJzjL+MAuTv20S4JlTuxmQWeQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af997a5e-6170-4333-229f-08d98d9ae983
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 16:11:13.5295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntA9lK7hd5X52D94JmlpNH/5LFABYnGOUxD5fh8lsvxm55ySW2zO3KqEpyvGkJ/Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 26, 2021 at 02:11:15PM +0800, Cai Huoqing wrote:
> Replacing kmalloc/kfree/dma_map_single/dma_unmap_single()
> with dma_alloc_coherent/dma_free_coherent() helps to reduce
> code size, and simplify the code, and coherent DMA will not
> clear the cache every time.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> Reviewed-by: Wenpeng Liang <liangwenpeng@huawei.com>
> Tested-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)

Applied to for-next, thanks

Jason
