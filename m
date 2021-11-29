Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A71461F07
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Nov 2021 19:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379464AbhK2Smn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Nov 2021 13:42:43 -0500
Received: from mail-bn8nam11on2072.outbound.protection.outlook.com ([40.107.236.72]:55937
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1379927AbhK2Skm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Nov 2021 13:40:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vy+GpjPOxkyz7na9I9xVprKn8OGzxXq6VK8qJfyjTTLlmhOYG99FcPbaYtxS5WzKeOvL1sAS8dmfqcjilybkGZyN6Q5N08Nq3xRSMckoIo7uAqIK9sODSNojSt7J//ue0X+DFAPNrzxGqUIII3fNp4DtY3B3fF4ah5nWuTFQ0rIS4TgzuFd1pPjBuIc17PYFFK8EoVPw3cUKAuHHc8sBdiPnEGyJxZTLLUD1zxs1vsZ0YSiHo8G897q1t/U1EyCzJQVsslfCNxwzzEmlHjEC9mfLJrBU41LQsf5h1ec3vc3xIgRDDeJZW0NI/okEOx1BX+ygfYKePOm26t32Whx6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIBYCux/LZal712qdDMJLk2rpujvvfnvxyA2w77JdhA=;
 b=BZdMqF6CqW6mrNQBJjyTgwRtoiLAFCf6GJcgI0ZAf+TNueRYmBiG9tOKLU/nxuJCOrbr97lHz3UqYlvTd633gQOX++yhPtKub6mb2vdkrR/dIH9zgCMOoyyHOSkwoXuYj6DBWCuhYHJ0xWKao5vRaMUDNFBc5x0qPuiokR31I5DBaPaYVP0Fj4jNc8ztOap//eu8XxW0ZboxCxis5p3ieieGLUva4s63pICV0PA0Q2WcpLv8IRVkP060WwW92l+wn/66DIIALYkckjFXm4P1zb+7cRpLl94y9mHCABil9RNjcVV2KQSPbSPMY1DlXp8HTUmO8UveINerF3q2XZL8+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIBYCux/LZal712qdDMJLk2rpujvvfnvxyA2w77JdhA=;
 b=IK+lo6fDfp0CtnDSSUkACokSjfUsmcPyarZK8pcee8QVJkxZJtp8UQLWoS2WA2B1T93C+DixmTlBZKVeubh4o6aMiBRuEsHQbzhFtFTBm0qKRuTMmhzArC4d/Hh9PsJfbb+2oXeJdEUVzRXz2GVzJ0gnFJlGiW9WqTcPusJIZUzTzot/tu0DtkV8iC0I8biCE1xzJrYya3uKqUsJazLxS3cNI47GllckWL3u7UhHDcOdPegfxJfqd00UwaFH7J0+8eMcRelkVt32tBInNexMVlNYhT7gbQ/c90FSYvKYX2j6FLKa0zkEct+SakUzwAvgHegCx8rRgPNudN3rY0onaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5109.namprd12.prod.outlook.com (2603:10b6:208:309::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Mon, 29 Nov
 2021 18:36:50 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 18:36:50 +0000
Date:   Mon, 29 Nov 2021 14:36:49 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] IB/hfi1: Use bitmap_zalloc() when applicable
Message-ID: <20211129183649.GC1065466@nvidia.com>
References: <d46c6bc1869b8869244fa71943d2cad4104b3668.1637869925.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d46c6bc1869b8869244fa71943d2cad4104b3668.1637869925.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: MN2PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:208:120::21) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR10CA0008.namprd10.prod.outlook.com (2603:10b6:208:120::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19 via Frontend Transport; Mon, 29 Nov 2021 18:36:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mrlWD-004TCi-DK; Mon, 29 Nov 2021 14:36:49 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bf8e02e-f241-46bc-c6d3-08d9b36734fb
X-MS-TrafficTypeDiagnostic: BL1PR12MB5109:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51095AB557F285594A961AD4C2669@BL1PR12MB5109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GeJZlxW+PDdR3vlirqCRALLh0SQIB3QP1T85kNvHWNxEuN81r0BkRf9jLlSmgRCQyHG7XSyR5E2Ug8xkvREeJOkI4wy0Ph//Kh7V3joxUDWurjyrrVCfu6LMwVKeEtIEROIRwu18XRISw2LZrDPtMo71vhOTTPsFj4CZkqMAd59awwop/4hiE8u5s8eg/pLhSk2nT3TYJUDKX4pb09A1VoDqHwbh0se4Ztk2TLCsX7LFNfehAWvpgsmaTbsHIdbId9U2F+JUpq+rlzyaBISlaMeuGIxEIunk1FGyAs6hoii6QZbmu/YKGDYOyBWJxMFYqOR91ntfTurM08jFA+pCrU2D0U0+MhGjQlAX9Ub3S8jpESNqr0NDZfsQT1knmkvt3LTX72xfnQgDzQLRRLcZ+X4rn5RSGH0gyBcLJP5Tk2nu0wQEZSCceex2CjNhU1mJFDbc17vVF4iPE12nY/uzirhg8IGypZgG0GaDaELZHpkw5S1m0AkIlwE/FtONpdo7OH6lTH5yjEpMYj96jXrGni94o/J8qhELKq84iF9ztkRrlBmjLdemF9mtOmLqW3VMKmwUq6CqUNTGwyiQwKEFzOocH6eng04KOmglCGcbtNaWm/WtVeJUVkxQ6K/S64pPwEx2aHK/P7dhocEs+7MTyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(66476007)(66556008)(5660300002)(8936002)(4326008)(316002)(66946007)(9746002)(4744005)(6916009)(36756003)(26005)(86362001)(426003)(1076003)(9786002)(508600001)(83380400001)(8676002)(2616005)(38100700002)(2906002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cnJfPX4tOdTSaTLGlr+TTiw+uexlNTTQtrfm/NMevOxY8G3Jng6iPNsGA5VB?=
 =?us-ascii?Q?nIohDKXHO/OnX0JRShE0b1SlfwzA+WjXjTD+K1VY3tjXh5Z0sEo8ZMwFH/I1?=
 =?us-ascii?Q?tKNQ3L80mREEQpcO5zWnVrP+pHc6nO1wbNpApndRUSLOFmpAE0Fmc1IviOVM?=
 =?us-ascii?Q?v9PwoTnfl6vOO2GCU512CF9dwxAJlmdMDO2HYJVbW3GLF6/MIvwRKaqcd19D?=
 =?us-ascii?Q?IrgJzaSqL1/jY7Lh6IOAG7+XPIeZLyrT3rlTSOoWS+PiywpQgs8w394vHTVH?=
 =?us-ascii?Q?RXYYDXDAaHi7ZAvCAOfkKaO8nL12RXP3/IWokRjAd4IKcYcxUlJGnxnGAM+L?=
 =?us-ascii?Q?swcP3MTjY2REqw/Y7Rtqjj4LXSp9u1PNpr355mWFdOLe/oVyN6i2fO+Ns18v?=
 =?us-ascii?Q?Ko8PITUYz9Zc+CXyG1d+DRV7c9AS6ziV676veai+BUb2QsGfKqz4Q0ugkR//?=
 =?us-ascii?Q?+xqlFFkMti16Ksl0gD16B3VQv5lNUlVMh4biqQ3mjmcwqa/wntPgrdti7YUM?=
 =?us-ascii?Q?zdRnV9BFcx5cUUr9o6KqdbupFnuLHHmfDHZDCBKmSUYVs0EEbfYo3qp0u4EV?=
 =?us-ascii?Q?Ovfsw7X6Mk6vMNUp+0JLIiUtPbLYfgukoT9fzPstCijkN3Wji9NIgNEk53rM?=
 =?us-ascii?Q?oMYy1v8NODCqprVnsfU/x27jW4kWNF4I5qUKCCJzy+s06H26U/f4Cpe+wBir?=
 =?us-ascii?Q?qlPJgnZjwwy86FfQuexPcimTbB5Psv84KNoJrDbBIetk4w8Oj3Be/oAOO4ZM?=
 =?us-ascii?Q?yJAQW21+6/BvwEKt5WV/VzrR9x5AwcQtoNu62bpEG2ayWHQD0qWsr8vnN+R/?=
 =?us-ascii?Q?RN6qMdf15LMRQAbx3dfgeYIo9AeVgTl2uCtF2Lg6QPpJc5QvjxWXGrdrsZ34?=
 =?us-ascii?Q?Ko/qsNBLgilXpU3O72MpLEALOaRdezMUEiwgh+8s6mPgKu8R0IDlVLlWl6nG?=
 =?us-ascii?Q?TxenqGRTtDR3npFlTdcaH7Jx4OY+Nigtqxz3ZIPKgNoFReQeWCBtsMWsWfuc?=
 =?us-ascii?Q?AdgFSV46RKDfnPvyo7MEk6D8ibemMtfY3lUzrxNZqpRRKxyNxgZFhEt90nlV?=
 =?us-ascii?Q?SM3OZgPgG70nWDXV0cq2mVYsO/HbFIcmxpZFGK5lTSQakYzqiqV/lUR5bQQG?=
 =?us-ascii?Q?EiwdhZY6jZbKmkZeUrZAQ2sjUf04Twz4STgGIl8GDI7KVj0k7ZtEFkXm7W1q?=
 =?us-ascii?Q?kTomriMtKI4FrlVoHBxNsEzONPpEORXzjgJjaVtZXViHpdIdTxsln7V6O09k?=
 =?us-ascii?Q?wBHy+0KorDKjaA5Ma1n+ItQTHlgutdXl4WmHSqOmAlPfQGpwbP8i97zJ8eOm?=
 =?us-ascii?Q?4w8ulDXNqz9yCJ7QEMFpQfResuXwI7wog+TK7VzGFa7HADbev1oRyDX6/ERI?=
 =?us-ascii?Q?+NSv6+fC6h/Kqj94RyZcbAkwOG+c23vjJ9vbznDErfts3oDGyp82S1eswIYL?=
 =?us-ascii?Q?+VyLjeWKwBYG2rHFWNmpVDUUD8D9DANumk8ttuzeTMVaEkxslrsEo8V4T9XG?=
 =?us-ascii?Q?Cn1rieWP7lPYY/uL61HDFy6di0k/VmgJy3UKoSCZmQPN2a19FbOY/J0rFYm2?=
 =?us-ascii?Q?AqtU2gXFQqYGpagGZ6A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf8e02e-f241-46bc-c6d3-08d9b36734fb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 18:36:50.4730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O04z0S6WXvbtA+eMXJd1xwF0BhykSrF9MMXhQxUc+vqCz2Tf9msp9OVMrD2bgNBJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5109
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 25, 2021 at 08:53:22PM +0100, Christophe JAILLET wrote:
> Use 'bitmap_zalloc()' to simplify code, improve the semantic and avoid some
> open-coded arithmetic in allocator arguments.
> 
> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
> consistency.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/hw/hfi1/user_sdma.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Applied to for-next, thanks

Jason
