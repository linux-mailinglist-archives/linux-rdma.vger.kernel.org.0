Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD83E3CBA2C
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jul 2021 17:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbhGPP6y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Jul 2021 11:58:54 -0400
Received: from mail-bn8nam11on2078.outbound.protection.outlook.com ([40.107.236.78]:63072
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235486AbhGPP6x (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Jul 2021 11:58:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkahAJ5nbku6XtrDfaaUjhLriE2JVbKqq3peDO0QpAPO/nOk095ES4rAA8wvqT/v93shzy1Zg3H8f+A1luF8VALJsdDD1rxLCMmEJTh+MiCmZvcNQNSTJ/DpL3Y4SibjUPCvdEgZHxlNFkCTHjFBsgyq2EaHMOgUbFBC0S3lfBhgwKMPYTulD5/RYRpFkojefMpEP/a41Jdy9FAb5QDhy9nXdhHzZtT2+jUEM9ugdms0/Mi2gOWPvMYcMAYQ1Go81zf/t0TPc5QmM5PzQB8CspiwzeLsANVkCru4YIUYfrTp/1pHexm5+cM29Ua2L8xPaBbhyN8WyOf0oYkh9I2rkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZZ60QSe8dpTxAjHRgGgJhdd6eTBwvJf/4c9Y2s8V0s=;
 b=k7CBnMIeUlBrGO/486oMGTRyaBfONzC/SxC9M6sGSTVRVV3JKUJ1pQBzGyhh32iTAv/D7LKVysS567hiU5HmXbofJvB7RssQnYC1A4CLaLQQOamsTuf1TJy9lJkTa7c6Xp4e5D3LF420AHNMyUipEJikZkt+XCQ2uNAhrYbTEV7uH+PuggKzjVs3nl4D9lU01mxkWPEpn6sX1eCRGXit8JcpRWgzCyGr2Pjch94W8Lb4OeLJhXUpvaWzxibczq1LgPMqquYIwrygaiGl8YxtTLh3gbD4NGgTznvjWWJbd2l0DyGCmfx5KtF9OsUuyWLtc1toZdf9wNDEhcfaTWXh/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZZ60QSe8dpTxAjHRgGgJhdd6eTBwvJf/4c9Y2s8V0s=;
 b=bkByEwbBBr6PNvKzn0UzSMT3oUcYfyaE4vEM5qS07fTRAetnTtNYNT7hW6c7clECW8LBxrx8dzhDQMHz6OYWz0GHitvu65hgZ6ggU5xW+Z2ToCsjTqcUQ0hIT7auQ/MC3rIjbpgLGfvNHaLaqLOiOCyuVOlSS8utNFhEOE2ouPSEU1pLu+mj4VrnyaOfjjgK1GZOQVdqrmQR60o3KIw6WLndG5OLGnVb1FTnQIiA0sIfrmjMi4iLJkSkihSxw3Aqdl3sVx/tezA7pebsaqdj5AAanATJ07y1x5jQar5K+WaPYzogPOocLsPcn3tSoPlm6wU4Xz13dT8mo2GbQ015tA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Fri, 16 Jul
 2021 15:55:57 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.026; Fri, 16 Jul 2021
 15:55:57 +0000
Date:   Fri, 16 Jul 2021 12:55:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 1/9] RDMA/rxe: Move ICRC checking to a subroutine
Message-ID: <20210716155556.GA759856@nvidia.com>
References: <20210707040040.15434-1-rpearsonhpe@gmail.com>
 <20210707040040.15434-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707040040.15434-2-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR19CA0042.namprd19.prod.outlook.com
 (2603:10b6:208:19b::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR19CA0042.namprd19.prod.outlook.com (2603:10b6:208:19b::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Fri, 16 Jul 2021 15:55:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m4QBw-003BpA-2R; Fri, 16 Jul 2021 12:55:56 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b2ff8f4-a8b4-408a-dc37-08d948723313
X-MS-TrafficTypeDiagnostic: BL1PR12MB5350:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5350285F8FD221C8E9639261C2119@BL1PR12MB5350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KS63i0AF19Xzip2zyqmPkerl9Z+g4gx7BaTgh6NI4ejKxp6F+CCnGo8Y/c0tDihYsUrBfhVlNUkfK/VYgozimIur6dibpGOnGCg0w32xDOSgXrX+7oaDJUszCJQTUkSaCbWWLQ1SPK+xbs3uL5eyS6Ysx0soZZKtkWCPoq/ABgAZQTT0sJdrCFq4zieLvyA4lQM+9V2C5/fTbYUu7pEVmyElolWGw7V46gm9rLEMgGlLM5wyyrzNoiRfCVUlaBdJFmlw3X2EPSn1ubOABR9OV0dcat0M98WkncMCqwICawitqGkZWPH/nZH7fb2wjnlF47AI6Af3L7BRGThuHQ/lJdYmNAk6Dt5JA0en2kE2JLUCBwJewEIbssP1/v1pL/QCHWyL2JVBFvtmgGfn3++GAz3xDbLvPdkWTjFpHXTa3tih8PEZj+UoH2Xu1PX/+Pa+4tRyxhyvlLXeJA2JcJBTyBcCz1fA4YsLrkJnuONc4s58RwEQRpPsEZO5N9aBoK7ZAeS/C88VeKcOAEJtOZgV3A/GY3IIMLTX2THRU+MVuna+VZ8buwMYdA0h0b6WH3kSSGObTWh4MCah6a8IjsRsSL9EzjmszEg15ziVyyQd8ozaL31kMDxZT8KE4BRcnLM3+Ti4dI9GTbrQi/HlQsBPhvIAak/sWGRA6JyOZP70oXKnJUMV4pM5RiPpQXAF6uUQmEOYduFtYyFXofZsH2cWsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(66556008)(26005)(66476007)(66946007)(83380400001)(426003)(1076003)(6916009)(2616005)(36756003)(478600001)(9786002)(9746002)(316002)(2906002)(4326008)(5660300002)(8676002)(33656002)(186003)(86362001)(8936002)(38100700002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tUhAahPqAVE/bUiWy0XqnsEQ6oAx8QWB0xYjlO2b2m3xIK1TllRU7PCcVxxA?=
 =?us-ascii?Q?c7KKCwPweo4h9LLZ4SN/iXvn/R+yZsdZL8UhZqhH0Epm8hJx7UPdpJY+8aMt?=
 =?us-ascii?Q?RtrbP47kws1q1jmtRRULw41cVCxvSGu5bjlnnM4Cay/XW23CIBA6i7obJsjQ?=
 =?us-ascii?Q?U7GMG58XC0yQbvTGc6V2Kyr9QorNXN4L0rb2zrCzJ4TS25+I0qjjeDtSLcVe?=
 =?us-ascii?Q?EG55owdM6SSwfOJF5ksvDmKFbOqul6hhiLDZ63IuyV5Pbv2IbMMTIf4bhUjw?=
 =?us-ascii?Q?b32ZCBcJteKubGUeFXgDg2J+IvepqLZKlo9s5IvOFu4vVAJUuCx+1koUdC+L?=
 =?us-ascii?Q?nib06Bw/6ifypXWs1VyIXS2uohrhYRSNwpglRCyzne4mVAVeaNUIU9Evf+1A?=
 =?us-ascii?Q?TDtrvtiA8xcsHSsaVdlqhgMdAlwywNoyYoMHM3P0lAEBFsq+bXBTs6k6uIx8?=
 =?us-ascii?Q?c9KvG4Xy6T3T5rAdiqc09YqZUDcmxHoR0SXXfEzFsEUI8mO4mY6IsmwBL8aY?=
 =?us-ascii?Q?ArEKQ3pxoIXpZeuSQ5tZg1Mm86M0bSPWtx28pRHdyt9L/abB9v7hZpG+902S?=
 =?us-ascii?Q?yoe04+x0scFQaKMPahRN1zpii4+8kumbEvqUrGJ2fYaXgftORNgGxhBj++JL?=
 =?us-ascii?Q?q8alPrdsnQIRapl5FBlzopDmPnJ0wPXAgc7RnGa7RREqtxd0Zqph3+avv2wt?=
 =?us-ascii?Q?6FEjC8ZNttJ4QyLH9iq8M7fRveP4yqNNwfnoOraARIgksxT7iP1KdPX4Rvqw?=
 =?us-ascii?Q?K62bvNZiHAN67KyYWrsHT3aG71kwIpyR0FVAxr7DBtbI7R+0jgT7nCtV7o0m?=
 =?us-ascii?Q?MsrHPIikw+Axd4fcFxNPteYrDuhIIpKmw5VdwJmvVgZ5Rxe3AQEyHiie3nUS?=
 =?us-ascii?Q?qLStzunP3XvysH075HNrumNEH2e6K0C1ltINUo8gh9nNvtaeEl7Cg/DbTZzP?=
 =?us-ascii?Q?481Vl4X/nshGoS2RwCctZNmRl56Blf979PgGlA1NZyoRcmDUDhBwpMZCaf7C?=
 =?us-ascii?Q?wRK2lsnrK8XnR9ApR4awAjhmtjNlJ1wH0vS41dtASpECPlIWsmkamSsQ45FW?=
 =?us-ascii?Q?uQEo8oCnuA9ucYqlkjcjN55o+gHK9imnDZl5yhrLabTryFJsy75Yo4MSieWB?=
 =?us-ascii?Q?qmAYQ6Y+3+5ljuv+BacJHjKh8tGBAyIuxI0UtugjfHzsPONbhjgGgob1lPMR?=
 =?us-ascii?Q?EHLR8MFQjl44vW3qjSiEUdk6LKgiy7iVnI2f8IvNgrGvWeTjbWsCukRZLUXj?=
 =?us-ascii?Q?kKgX1fCMy43naOlZsMQy3MkyTV84U2SkDRW+Mmj8/D+1HZUqyOJMh/u/bW8y?=
 =?us-ascii?Q?VbJMAlhUX3dxoqJ5EjCZlSQi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2ff8f4-a8b4-408a-dc37-08d948723313
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 15:55:57.4497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0y6D2YWgnWpwD+JzeAVWqNDq0FLMljeGb5TWP7CNOYixw7LsgaXv737+OvJLxfde
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5350
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 06, 2021 at 11:00:33PM -0500, Bob Pearson wrote:
> Move the code in rxe_recv() that checks the ICRC on incoming packets to a
> subroutine rxe_check_icrc() and move that to rxe_icrc.c.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>
>  drivers/infiniband/sw/rxe/rxe_icrc.c | 38 ++++++++++++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_loc.h  |  2 ++
>  drivers/infiniband/sw/rxe/rxe_recv.c | 23 ++---------------
>  3 files changed, 42 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
> index 66b2aad54bb7..d067841214be 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
> @@ -67,3 +67,41 @@ u32 rxe_icrc_hdr(struct rxe_pkt_info *pkt, struct sk_buff *skb)
>  			rxe_opcode[pkt->opcode].length - RXE_BTH_BYTES);
>  	return crc;
>  }
> +
> +/**
> + * rxe_icrc_check() - Compute ICRC for a packet and compare to the ICRC
> + *		      delivered in the packet.
> + * @skb: packet buffer
> + * @pkt: packet info
> + *
> + * Return: 0 if the values match else an error
> + */
> +int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt)
> +{
> +	__be32 *icrcp;
> +	u32 pkt_icrc;
> +	u32 icrc;
> +
> +	icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
> +	pkt_icrc = be32_to_cpu(*icrcp);
> +
> +	icrc = rxe_icrc_hdr(pkt, skb);
> +	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
> +				payload_size(pkt) + bth_pad(pkt));
> +	icrc = (__force u32)cpu_to_be32(~icrc);

This isn't right, the return value of rxe_crc32 is a __b32 so icrc
here should be a __b32 too

> +	if (unlikely(icrc != pkt_icrc)) {

And this should be written

if (unlikely(be32_to_cpu(~icrc) != pkt_icrc)) {

Or, alternatively you can skip both of the be32_to_cpu's and just
directly compare the __be32 types

Also, I'm not sure the rxe_crc32 byteswapping is right either, the
crc32 shash implementation is storing a __le32 in the shash_desc_ctx()
but this code reads it out as a __be32 ? On BE that will gain a
byteswap, is it OK?

Jason
