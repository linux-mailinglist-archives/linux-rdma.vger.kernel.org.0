Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD49433EAE
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Oct 2021 20:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhJSSpn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Oct 2021 14:45:43 -0400
Received: from mail-dm6nam08on2074.outbound.protection.outlook.com ([40.107.102.74]:61627
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234418AbhJSSpm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Oct 2021 14:45:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2VtvcDgI1p9pQxoRCQs9WJuTuu0C9Oc9WQhkN0J1nSJyieEExMR7kO1k6q5Vown8a18Mxwd7cAaU9alyjJKyIJcNYa0RLPP0YjwoCiYvf1MPMCmF2qD3FNwQh5IYJ3t7idf2szr9wtHuLC3RDNT96Z1XnzKuO/qtiibdeQw64jOEAC7CBLTpGgAg7CKd6NBJ6NPQfxR9/CxwQ0iRJDNI5Q6UpXUaujeFuRa3PzVMxnOSDg3frnPc3xG0SqH5YZEKFX1K1jhXSw3KzxY0Wv+JqzC2aq+y23WvBWdsA+NmCuA5aFJZljwBe+8p2XZYbTRbcEP4XyBaJKDXaz4bq4sCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eO3tjaboIV1JBL2JmZDf7iGmKd4YUKSNStgGngCzlIs=;
 b=EvHb5s2hXa1Xt8X4EbMY3ynGBHzRgac41eEtErmcQlK0zPnMv0H91uR/M7QQN6qoEReC497tY5I5Tk/zaUqe+313mL6IdyJPi1M6H4XmrOXZlg2raV3dQxrqD+OzrilwROKP137vhI2717TFtibDvuswQd91DLeMQUmqbO670cI7g8egJUbJVwu/cT4TRZEAsnm5WSFFCo6nyKnJoGjXyOVZO0btUTHU/ofzpunvhUA9TpAtj4uplp5GjksMY7WhB4B4DojBLQf9KshsyI2vav/qaFeMSPt14Zcs2lDnb+qSr9MPRVsR7azwbEbE6vs5e5GDnNPC2BwGQwYxXFgfhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eO3tjaboIV1JBL2JmZDf7iGmKd4YUKSNStgGngCzlIs=;
 b=TDAfieHsIlLxoRhi7pSbiwdhs4kUbxeYYq9FyJiwknkqFA1pIqfX+OmTkF3wlbBadUOXhaHmwyClWMZZGue1CjqtiW9dZOKpHa8+shJFF91xUaBlqNhzjxW9DtJ0eLywQrw9DgIDan1VhmzfS6lIaLEyRYpCo39XLoE44bxbHeQDvDl0MmJwqi2cnF69tHp0Za6Wl7tySMsPbROBPq2TfJCpQkVPrVZxBVHqp94/Fa0VPsUTAA1Kkmkps93ecsg0x2SbbNOjssP9wgSOs79X8tA7ir+aUBcDRoNKvRVSoF8H/r0oJrzFRMNW9QGMvloHIlg+35JDklRXOQ1I648vMA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5377.namprd12.prod.outlook.com (2603:10b6:208:31f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 18:43:28 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.015; Tue, 19 Oct 2021
 18:43:28 +0000
Date:   Tue, 19 Oct 2021 15:43:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/6] RDMA/rxe: Fix potential races
Message-ID: <20211019184327.GX2744544@nvidia.com>
References: <20211010235931.24042-1-rpearsonhpe@gmail.com>
 <YWUskJBU5ZHrIhhS@unreal>
 <bfb21e28-2f92-e372-871e-32c5f72338f4@gmail.com>
 <YW7DGrG04eJwbf7d@unreal>
 <ccdf6ffa-dc14-7b50-7a17-c0d01d9305bf@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccdf6ffa-dc14-7b50-7a17-c0d01d9305bf@gmail.com>
X-ClientProxiedBy: BL0PR02CA0088.namprd02.prod.outlook.com
 (2603:10b6:208:51::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR02CA0088.namprd02.prod.outlook.com (2603:10b6:208:51::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 18:43:28 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mcu59-00H53d-7v; Tue, 19 Oct 2021 15:43:27 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6c2177b-f287-40cb-7aab-08d993305761
X-MS-TrafficTypeDiagnostic: BL1PR12MB5377:
X-Microsoft-Antispam-PRVS: <BL1PR12MB537733AE26F83AEC7645B914C2BD9@BL1PR12MB5377.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P77AlmHb7Xjy0lMbWgB7PemZACm8jYuPmmDqvy8SGuEKZzmySHNayLmHumJZr77+KhadGIaHcVWvnwEi4dnuJl1rgtaLEZh5/a2prHlnIQP5vBUskvf5K3XddVyN+CCIImAr1AJ+TEvKFs2yhc2zl9s/xXS5vEA3kfBnSJCHHOTY1WaWN++yaJ09f81Vv+uWPYIBGqHldRkY3F0k0tmy2mR7D51RNFwhPcrzoR20lF1CwWTo4QcGS/VYU4FV4EAO99c/mGF0uuZeHbYq5VtikvfWePLbNGvov38y19lqBFGlWyUq/c9XVwNLgezE8uyP7hWR7i/2EWKqsG/RDVZlJKmhwMA6m57arrzhouln3ojkQoqJbNMcRhMnKq1a3R3hFykQ5B3h+vDkQqYbXWwo4BLqiobic+CWRdiVhSrTIRJRae7Oq8yeNPQ7580xAez0N4Vfqvl7/z9dgnWlQNlNDk0OcAvUfgi077B5DGLagxYcqqp07VBl+5HW1w8syqov/4LDVRoKEfBVMjBOqotkNaVJ301NsSmX8fg4aqNe4KP9tMjDx0mV5F/f4JlRl/1PFxdi4zcqpC032IeYX9kgi4EvSWomBBA/HkCJQQjryXdEWA64ZSSjk3X45rcpH1oOLJ/5fURv3q5FtU9vXC/cdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(6916009)(4326008)(83380400001)(8936002)(508600001)(86362001)(2906002)(66946007)(66476007)(38100700002)(66556008)(5660300002)(316002)(26005)(36756003)(426003)(2616005)(8676002)(9746002)(186003)(9786002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yUGqS6TeWPQ4Zf3+d6t/wKgKvaAAs+fIEmzz6nd6cP1X4U80B2pOL6ceY3Ft?=
 =?us-ascii?Q?7EPhCrRBg2T4T+1nNhTU5Gk6TK4ohbLc9enrKDxRI5JkDWsOT7EatRGMtna5?=
 =?us-ascii?Q?pwLV1dOQHDwmHoKRsYSWCxZCLyBkBPj8lH4kOKgHK7BH+mZ977/sX0O0dwGs?=
 =?us-ascii?Q?8B3fH4FyouUU0wbyTzKRGKKb1t45S6iWOWG4fXxwgYEAXqxzFn214/G7Av+F?=
 =?us-ascii?Q?eUq5+4FNQmtcr7EHt7TrWpQ3LRAojc1+2Pj4goxwn0+26vSwpy5vIeH4d3ZV?=
 =?us-ascii?Q?cLBn1N6/on0Kl2RiI8V22d7v8ItfLVcPoUEdqbqvipuRU61RlsJOi2mR5+Ve?=
 =?us-ascii?Q?LhS5/S0Pfk3mvY6lMpvQMeiYg5EJ5C3Txz5rL3HF7V9DMPlWt2Yl95cPs4he?=
 =?us-ascii?Q?UM4KR8FrPfvoD3ulnOEhZZlaYaHk+iSHWjFg+GCd9hCd0omwiVZTTTRnnIBo?=
 =?us-ascii?Q?qbb+0TUoppfE1KyRzvzTPfVAhfOsqbkKMrn/4dtV8EdrtO79QADoPyY4uqA1?=
 =?us-ascii?Q?Ow5cTHjgqKh3yfMjFUY5wm3td9K9DH6B0iqcMy4BiVw6G0u1R8xlPcVoLVOH?=
 =?us-ascii?Q?Wu9fkzLXYOqQCTf51S9j87KojeCLBUX85Ej8KWhrBvLzXJMME/Xlcr4PFdn9?=
 =?us-ascii?Q?DDruUrvUS4z/I2ofkxxYy+uLbGHzFkwO98hzUFpjOPqxAtXXC2/j4zYysalJ?=
 =?us-ascii?Q?8FFv4uwBd2vCcfQ0AZtkYcf+cWZAFTtnoTvUp7Ft11Pol7hjMwqDoZJtR7eX?=
 =?us-ascii?Q?i/sjczYANbMT9k9JBBvhlVocF517zwlOxV4LTEmrDcHB4cj+EHmTP3WuYpAS?=
 =?us-ascii?Q?Irk0+hKMsoSmfTHvk5kJEdmXTOyNdBb/WIUPo6w16ZX9Nud6H6ix4T2bU2Tm?=
 =?us-ascii?Q?sp77OqbMSzuJb9I9kJPTl/RxcV3n6OJCaeE/rBwNGNvooyGtq2341FfEviGm?=
 =?us-ascii?Q?dMVOMMEQqL6y5H7I0eXn3Aecfi/mRaQ2AdiFDMHTPADQow/gL4go5n4+SIPC?=
 =?us-ascii?Q?QI77m4UdNMM9T1097N0qWKnxZ3Vh7tQpfcYLmNDf33cOQdE3ZLN2WBRIsqfa?=
 =?us-ascii?Q?/swKfs+ML90xvEtkcgNJgg5KHrRWyeZc8WqUFzPGKP4t9q4kzpeao0f0FZHy?=
 =?us-ascii?Q?dMfaXVfE6WxpE7667kUVH6aZPWwNVK9RsD8RVtyG8HDVnNoGy8H4u99xgZlR?=
 =?us-ascii?Q?8VTk8Lxpcv3stMdgTCJVcznSb1ovrbWi7DCJddk/UTNELtU1Tr1cUX/lOpUB?=
 =?us-ascii?Q?NNBlBwTw8ZNItGRIVd+P8kLJ23DJbRrusIePpPG0cjSEqnwkKTUngCI9KUFP?=
 =?us-ascii?Q?12NLlNBQkCU5PzTZeq/7UTX7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c2177b-f287-40cb-7aab-08d993305761
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 18:43:28.5625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgg@nvidia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5377
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 19, 2021 at 11:35:30AM -0500, Bob Pearson wrote:

> Take a look at the note I copied you on more recently. There is some
> progress but not complete elimination of rxe_pool. There is another
> project suggested by Jason which is replacing red black trees by
> xarrays as an alternative approach to indexing rdma objects.  This
> would still duplicate the indexing done by rdma-core. A while back I
> looked at trying to reuse the rdma-core indexing but no effort was
> made to make that easy.

I have no expecation that a driver can re-use the various rdma-core
indexes.. that is not what they are for, and they have a different
lifetime semantic from wha the driver needs.

> of the APIs are private to rdma-core. These indices are managed by
> the rxe driver for use as lkeys/rkeys, qpns, srqns, and more
> recently address handles. xarrays seem to be more efficient when the
> indices are fairly compact. There is a suggestion that IB and RoCE
> should attempt to make indices that are visible on the network more
> sparse. Nothing will make them secure but they could be a lot more
> secure than they are currently. I believe mlx5 is now using random
> keys for this reason.

Only qpn really benifits from something like this, and it is more
about maximum lifetime before qpn re-use which is a cyclic allocating
xarray.

Jason
