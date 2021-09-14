Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B1B40B74F
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 20:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhINS7D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 14:59:03 -0400
Received: from mail-dm6nam12on2052.outbound.protection.outlook.com ([40.107.243.52]:57697
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232097AbhINS7D (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Sep 2021 14:59:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lu3DjJbvIxd4YY745grCEoBpTWqgn/bBSYd6kuMJWdLVIq4dDuYJKhwoCZK8AY+0yY9b5FW1Eo52DGKs33CUPclmA0qqSkS8FCQhsdynx5DS2FgZhpq/UVOLK+GM6a2VF4FQOacpbQablvdgcVRintIRjWebheqjdJJBlOuuop5TfU5qnT+HU5SR75noVRWOTZeTGWssQfF/Cl7pzksdZt2/x/rVF4Z3HkChfbM2YZBf0Fj77N1uYTuLSUT/f/abBvnKmssC39JMovAhS5E0q7Q+ckrF43mCmSq2PavQSzk5nlrYejEvxjrg9BKRoK7hAZ+5AjSBekM8IHxJ4iqoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TVgL7ZLINFcUG1FbP3VRhzCUCC7Vx7fwgI1Nq50QYVA=;
 b=N5TLCm4Sc1iAtbNpSNfxHympuC2RqId9DiFfN82RGzdttKE8nQH0MBuMfEuu2Ihti7sSVFgtALlxTKdzzVQBDVfVlW9447f8a7aZWYCREvs6bO80cTWGEQi5E3vmE/MHlSWWYt5C26MarEuQHhy7jPBCk9lWDTgXpwAqZ3HN/zbeD/IgXhWb+Os6RZVSsQHQl+xtpdw360mcKIN1xUmB+FkPAvPb8vFAqoFoW+sy2cuArz7bDpIvKZOJbU42uf7vnjL74m/BPmqGf87WWxQGPHvXtevdG8hPlR4jA5LjJzzmzw6ALPQHdnYDnHFcLWPLnrUPaNlDYUIEoqe+CSJQdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVgL7ZLINFcUG1FbP3VRhzCUCC7Vx7fwgI1Nq50QYVA=;
 b=BZheT/uQDTkgiW0bwWcXzQtnruCsDwfcizhwV72neDNQXyXrfRgxti8TNLSgRETL/3DlYPV+UGUOZrIIu/xKEwYlzLKMJDfb9QaIjLSCp8NWgX/LFQvfcQyWFHvTkOpVhIif3dq/UuTIoRYahbbagJoF77m/8Qf4jOatd6stIwvTRKoGVHyQqJbtOBNVm3aSKS+DXQYJzA/sPY2kk27GQ76pGU7WrUOLV5fgFXXbNYgokNpaCuS3SnOP/Wrk8OOJ5ji+JGGtzZAkpC5mDdOGPt0LdGWbmHkHZ7Zmj0qUYmARcBSctObSQZDUCuKB9za7Rp5mZdP2h0OfKbXTUya54g==
Authentication-Results: gentwo.de; dkim=none (message not signed)
 header.d=none;gentwo.de; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Tue, 14 Sep
 2021 18:57:44 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 18:57:44 +0000
Date:   Tue, 14 Sep 2021 15:57:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH][FIX] ROCE Multicast: Do not send IGMP leaves for
 sendonly Multicast groups
Message-ID: <20210914185743.GA140712@nvidia.com>
References: <alpine.DEB.2.22.394.2109081340540.668072@gentwo.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2109081340540.668072@gentwo.de>
X-ClientProxiedBy: MN2PR19CA0043.namprd19.prod.outlook.com
 (2603:10b6:208:19b::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR19CA0043.namprd19.prod.outlook.com (2603:10b6:208:19b::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 18:57:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mQDcl-000acV-Lp; Tue, 14 Sep 2021 15:57:43 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15c23bd5-142e-449c-fa94-08d977b18931
X-MS-TrafficTypeDiagnostic: BL1PR12MB5160:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5160E0C583D2CE114A9A6AE4C2DA9@BL1PR12MB5160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w23uZqNkf6PuHMNCE/F2JzMRRXZUWZC5AoFvuaok6imQ1Kz3n1Xas38yaaNgIF6PniSMTBvMs8UpS70uCHx0FYo+ec1Ke1t1k2zB4WAqoeCdfZenafyTJwAUqsDOa6ChncA8cPakHPv8bVFZRbWpur4d5kFaHIk+t0zXh5nKs2LTtkEgNSzRTByoMpAX6y8YAHIrUeKKq6r5Up33mcDn0viDoGFI8vr7SdbOQAm/uPle7OZEl0l691E+eRE6Zkf4CADbXQsPtBqRfogPq17tXyL/tZb/cBpqAwNAgorPZIPlMIpkeTq0yCDMT6d8EjyhAEwANcZFBVnYvLx/oxTwPEpd6btECqGU4PjnVwHoYihk3yUmN67s7d43ig41JkiU3cMM2VVfQyhcNAIJ6sbbq8UQ55fwTMGOYQi5oI4fKgnPdF+QwIlSQlSWUUO2S4bd9lHZwmbaisXlNSxmfUTizBPlAi0dqwpY5J87zp8NyQiDX0uS5PN7jIzDqKqBcalBE945o8WDOOvni3jJlwRl0BQWypRifdPfhhj85WvSXIo78nK7EtwbWq/n9Rbw8wuWawJ8Y0hkKfQ5V6nN76pa1d0BmlPDX4ZXIClTEKTXBqiJZd61FTjGJJvsRcvIkpnuHo89Q7tzN6zmxXfBBf3xB7MGBjjjAbSQ2kTVXHlcoXH9+bxl4uEx4pwI5poor/uAcsP2CY8ghdrvsMms6ve1eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(186003)(86362001)(5660300002)(33656002)(6916009)(83380400001)(9746002)(9786002)(36756003)(316002)(8936002)(2616005)(8676002)(4326008)(2906002)(38100700002)(26005)(66946007)(66476007)(478600001)(1076003)(66556008)(426003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bPL95v0oL2vds/Bl0f80vDiOpbvf6IhA3R8L/5X2BrdxwuXwBnE5ZtRWchtf?=
 =?us-ascii?Q?2s+3ovoHBEB5NACrkfku2iJZoWq5eLr4LWGSuuyv7xiRrlE2wydPKP+w0reL?=
 =?us-ascii?Q?J5UX6PoRatkyqf9znsiz95jhapIhiSrmtofJb7kRdtDKPNKUv44TINJhBdXI?=
 =?us-ascii?Q?Gl/D6dm4NlkjdbKmZmX1UQHV2vQINYGBgwHMqjwXI8sE4tgXmR/+P1mu6buR?=
 =?us-ascii?Q?241ncypEPzxl1S4vV/oNKVUx4vEqPVu09yDAwyKm9Hq6Abm0pYaRfnk2M21P?=
 =?us-ascii?Q?oKddhIcQ72WmFpjrhnKMgXBgCcCV7wwCgb34db7sIVC8ddafOHFk9+cQVgfK?=
 =?us-ascii?Q?FyXojLzJfVMOBWr2V4vXSwZEnKqEJBTServr5odAccAk5qrrDjh2G+252zth?=
 =?us-ascii?Q?akYNJFI8+qvfCpMfBgQs3uOi4S7YdghVHGLZB5dPNp3zPMAmU0o5soqp1Ckc?=
 =?us-ascii?Q?BCooOv5vZ2/oSS+pIg+Hq9K9klADyzFtJLia7Bw1DuqNGw0YPgQ6dCby899a?=
 =?us-ascii?Q?3vc8vDkr2MzpS8lC1AKc6WM6PHqZUT+X5KzdXFNaDfLxlHCuCh5lbjskzg7Z?=
 =?us-ascii?Q?wmuck9fGcXkg09CTBCO9IMrmj4ziFQhekAD2v6eixovrlYw6ClT+xi+0Sc1W?=
 =?us-ascii?Q?zE0TQrGuYL9iYsnP+Rw8qLFw9/iyKeohiDSCBozI0KO0PPq5QmHaxZ5YRQIm?=
 =?us-ascii?Q?mN55/ZFYX1/9b+5+dzKZIU6kDAc0kCrHvL1YiHpivXjwxG6xXDnli+Y+pVyq?=
 =?us-ascii?Q?2VJKqqj4C/hMGJDpLCqVkMiWPzOAYy26fBCk5exH+b7nYYzMeD9ZlXDoxUtu?=
 =?us-ascii?Q?sHSjAOCGGo6E183brUKro2TPO6iwIOYTHt+MtjcJLcwscf5jUvCTECqM0jJp?=
 =?us-ascii?Q?m/Hj8jn9m5mOw4I5VaxEPjiOED3OQK/ZJC74OICoLolfLPHaFw33nmmqpqT2?=
 =?us-ascii?Q?fuuDe0N8F2c2FAd++puQOly9viKXOcffqPd8r/oCrJgyw/xpvaSazkeJcUYv?=
 =?us-ascii?Q?JSkEEkR2DenEZhFO/muKiUPzzt+XZQwhCTmLNsCWAr0o9siHjalhbtD8Ansi?=
 =?us-ascii?Q?WFCXpmm/6WjkxAFU00chf4ZaP1KGRApPqb59zwP4zJBY4JKE1VAojfMCW26W?=
 =?us-ascii?Q?iXp+Pgf7VrYWgNBx9ZXi81W6aaYaJOCqkHd+HlObzQ++63yD/dZe1qlMDIbh?=
 =?us-ascii?Q?9ZhXux7y71GJOScm1gq46+eTWCzE9qm/Yhcg0vuAEkZjMqSDjeLkbakB9qfB?=
 =?us-ascii?Q?+3dYiQfdYG0mfpKcOLOIT8W+h+2RDlaCqDQmwIbhbExqyXXwsW7MJ4aGxywo?=
 =?us-ascii?Q?WsJXnhntU8CRH4TEVPPNFNeJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c23bd5-142e-449c-fa94-08d977b18931
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 18:57:44.6387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwqVRPl1q4hSwZE77Br9oLmR6GLD6V3zn8qrtK0xzux61als6E8PYZTdNbSWcnrm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 08, 2021 at 01:43:28PM +0200, Christoph Lameter wrote:
> ROCE uses IGMP for Multicast instead of the native Infiniband system where
> joins are required in order to post messages on the Multicast group.
> On Ethernet one can send Multicast messages to arbitrary addresses
> without the need to subscribe to a group.
> 
> So ROCE correctly does not send IGMP joins during rdma_join_multicast().
> 
> F.e. in cma_iboe_join_multicast() we see:
> 
>    if (addr->sa_family == AF_INET) {
>                 if (gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP) {
>                         ib.rec.hop_limit = IPV6_DEFAULT_HOPLIMIT;
>                         if (!send_only) {
>                                 err = cma_igmp_send(ndev, &ib.rec.mgid,
>                                                     true);
>                         }
>                 }
>         } else {
> 
> So the IGMP join is suppressed as it is unnecessary.
> 
> However no such check is done in destroy_mc(). And therefore leaving a
> sendonly multicast group will send an IGMP leave.
> 
> This means that the following scenario can lead to a multicast receiver
> unexpectedly being unsubscribed from a MC group:
> 
> 
> 1. Sender thread does a sendonly join on MC group X. No IGMP join
>    is sent.
> 
> 2. Receiver thread does a regular join on the same MC Group x.
>    IGMP join is sent and the receiver begins to get messages.
> 
> 3. Sender thread terminates and destroys MC group X.
>    IGMP leave is sent and the receiver no longer receives data.
> 
> This patch adds the same logic for sendonly joins to destroy_mc()
> that is also used in cma_iboe_join_multicast().
> 
> Signed-off-by: Christoph Lameter <cl@linux.com>

I added the missing fixes line:

    Fixes: ab15c95a17b3 ("IB/core: Support for CMA multicast join flags")

Applied to for-rc, thanks

Jason
