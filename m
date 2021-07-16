Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94843CBA45
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jul 2021 18:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhGPQJj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Jul 2021 12:09:39 -0400
Received: from mail-mw2nam12on2055.outbound.protection.outlook.com ([40.107.244.55]:48736
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230358AbhGPQJj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Jul 2021 12:09:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KILmtm4RNaWcDpMjkP28CGse+dvEHLQhkfz3WLWDfn8E0YWtcIzjM1ObBDPrW5JwqCy6VNBfdoqqNEsck2JEG7zw+zFg400VbmwYZhfwtBFqfz7ukXpYPH09bMvlck05wdYrWSK2ZGmIsyOdLLVRE6loEes0NshDKsCmmHzIi1ls5ZhUkk/G0nuT7Jq4PFHIZ2zOVwt3ceh702u21YuPKx2SEB68vRLLskgd2qx1073ODqrMCoULTZuFJKokgpH1MHaQX/2f0DbIuntcP3m4xdmBSgMZCQObXXxwdAtreiD/0/MEAhDSsIVJ2H2Eezc7Ec7sjOrssFBGMEoas8T0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snTtxRG5OKV8fkDWwxy0Upeh3SN24tDLzmzI4pr+nt0=;
 b=GCpwYJL9V19mpS1vlVfQjTMmOqO7ZEv2mQGQ32+NXsPD1UJDL7KsPIk2m+BXCdedBkjh5pFuHvZ1gPjZeiysONSAzdXVRvRfnMDs/Kpk7/RLkpNH9W3TLGFRhkoqe2BA9O6xAhUy/8LnghYyj4F7LfFbc8vlfFEmqBgcQBS3o1Nfm6uuw7RfChoKShi2V0XXSEApOP8VIdmmcJwzf7VQ1bHoU3Qe4RTWRc80PYUMckFZ20dIAvNDiStHoPwsyoC/RbAuoonsXiElw+LNSxwlnE2v9LkPyJHHCy/CmSOkn+V9/nrxUbXmvjzvW4b2gaSwosKDNiHzXk4CJxXctZGE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snTtxRG5OKV8fkDWwxy0Upeh3SN24tDLzmzI4pr+nt0=;
 b=VLftcZfrJ6R5mOAh/4s0SoWiLplzfBo/SPqeUuCJlEn/gO3v4/Ml20mSSZHHUhRbjkPlatSh8YSpCf5EQsZQObp1gJbJ9Z4VklfbmUsD2SbLrUlR1Ael6VsdBoDTFNmqImHPPxSv8jzfSoAcYVfdDqpotV/ZBOQyS49r1NRVLg4xhwWz1Netsg2V7sc0KfcgZKyH1v9ek6h5915NbXp+dAvZ6eU569rjtBefn+MxCRiRGIFxqVEzf9Qc7iid35y94o2Tjyd+ZTCEwOGI/PxJ9moAtKbtMOKKHmPvgOzHiqQJjkVlT5NPB2dlXJ3BLJFjZ2zxFAzPVpYx/6ipe0olAg==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5222.namprd12.prod.outlook.com (2603:10b6:208:31e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Fri, 16 Jul
 2021 16:06:42 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.026; Fri, 16 Jul 2021
 16:06:42 +0000
Date:   Fri, 16 Jul 2021 13:06:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 9/9] RDMA/rxe: Fix types in rxe_icrc.c
Message-ID: <20210716160640.GC759856@nvidia.com>
References: <20210707040040.15434-1-rpearsonhpe@gmail.com>
 <20210707040040.15434-10-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707040040.15434-10-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0430.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0430.namprd13.prod.outlook.com (2603:10b6:208:2c3::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.11 via Frontend Transport; Fri, 16 Jul 2021 16:06:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m4QMK-003Byy-UQ; Fri, 16 Jul 2021 13:06:40 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7642983e-9f9f-47e4-a5c7-08d94873b35f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5222:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52223EFED7C268BB5CD83EDEC2119@BL1PR12MB5222.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TSeHKuVXJqdLzq58ArxWiEzl88s32e82Sg4LeATfbCKf8RBqBvfwX10k1xkXqj5cCtqczQImwncSf//QM+MXjFCrbNcHqkrsF8PdPJtP1fU/LWxVJ8yMDtYNnNzEMRSNePom2hW80q5JkiyAeeNrf7EPJeRMxZb2Z63Fzncelh4zgNuVzGgX1kgUqqslzq+15+64KsxHoITBWbM4t6HadEzUXYmkfx1eV9myPFXtLitghp1r2IN89Fy/jgjiH5+PysRSwKsHSERoo4ObagckiN3ah5oPJLFnEzvr5QIX4Nsqut72xTccUYETPccJ66+MmiQMiPAI1bwiI5e4C+RC0rKo0VGPdClxPPZGPYQS+xwiiyWlVAvSQCClljsHGOrANFbu7uIx9IW8Y6UY72x+89RoaOwuDyrvrQkFHnfaQLuwsMHpwtcZ3x91F5io8lniZ5ZLxktz2+fpZO5zXHWciUhMXKdeSro5qhD1onEzb4OMOBH6BZYjKE7Wqtm+rsARP7GM6AZLyQ2vEhFvf5Cd+7xrbRsvB96UsHlZlddF2pfOUf7LG3YN3ejYxB+sD6YkVGHym+Fb2naiCWEwrLG6PWuNLY447+K52PpSkX4zb+WK0pjLTydWrsxwyFESyLlFksDGNCu5NeINIilFDheKJVYiv+KFVsXWDyiISzAikzLVdKt3dYDHXt2ledkawLO1uyMd6CiJbyjCr2teSKTuLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(8936002)(478600001)(86362001)(1076003)(426003)(5660300002)(2616005)(33656002)(4326008)(38100700002)(83380400001)(9746002)(316002)(186003)(2906002)(8676002)(9786002)(36756003)(6916009)(66556008)(66476007)(66946007)(26005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jHDudosA6lADos2KRH4QEVT188UkHhRX5yibxvsbEYUa44elALmx4KR8Moyl?=
 =?us-ascii?Q?dIpZk5r2B/+2IeeyYVrF8nDxrrx6xhQms5tjs15ZvG4CKdYyCpYBNXw3tZxo?=
 =?us-ascii?Q?UGrWxtiQl9aydO/3yHOpuVXkb8WnQ/rV6bFRH+lXTHDFOAgpQb9gknCA3Yj7?=
 =?us-ascii?Q?MXvHIK5N0/lRPvX1frnKzgSsnXiSTp/eZUPdqQrqcqBk6npyczX4TSj3Alsz?=
 =?us-ascii?Q?dTh22ikGlx+s4AO/bCMMPwPMWxzvB9f4NeYTuS7RXIuQn9Opy1a/kcnq3yg3?=
 =?us-ascii?Q?sYDzbIa5XPBoaeYeJPy88MD+Wyg1kGzpGsSszlCsk9jJgFXN/n3zM93OHpfe?=
 =?us-ascii?Q?SxJzzfPkgbIy67NzxXWksilIlraK3ZLzhEiV8Hi5CuwJbxptwNpz/75NN0+t?=
 =?us-ascii?Q?BAGNR9BLGgb5Br4cohEYwOPukV0zBqLvawysU4Co5h7/02qiV9vDERGy3H8y?=
 =?us-ascii?Q?WdQ6zJgqqSlIei30GtLYRPwAhdorw5XrhVrMgXEkjruQHwRMgd/VuNL2Ihhs?=
 =?us-ascii?Q?RNrOrlYMOesfYPutLG9pIWEBBVlEENENCZGwOP+hvYFgNU3+71HlDTROWI9a?=
 =?us-ascii?Q?IlfsqLfbrQ4FaUCGLVE6KPBcxQ+x56Jcf3GTxM7t/6G8zWLKuKcqEX8qgLmP?=
 =?us-ascii?Q?Zh0hUd9RFIe63u1A8zmT09x7a8GPLcZG1y5MoWOEqZlBXzKLcbkMdV1FVoZu?=
 =?us-ascii?Q?4mA4hhJltf6Yq9nfRncVy2jaf135i7Xt4F+4L6v2iBsSOzrgLu4VjcASBVpm?=
 =?us-ascii?Q?1QJ1EdWjYYdbyGN0zeYO2rxxm3QjRI8E8ek4ZPdm1uL+iEe0JBGBzXoYOrnO?=
 =?us-ascii?Q?ug1mbL0X8MOaTkNY7QyeoXrxUeCyYqrVXZziWw5ETUUupncHL/f0fFXvWx3e?=
 =?us-ascii?Q?6UJTFvJroj4+UCj7y8ZJGgWokjzKgfnhQGdFn1gbq6IihHybOUs07ABatrJw?=
 =?us-ascii?Q?a0ZeR5/ewP4xZYNGsJIoy1RMdZWJB7bYjXv+6EnTxVIxa/HUXkhWsLaSuZfU?=
 =?us-ascii?Q?uMzP0ana7vp+UD8nF/Q/CmZoNVMFqHYvhcpDKXzkZK1qhCHAmTNNXcsdsPFk?=
 =?us-ascii?Q?1AA1C7r/1QIQRlHfnPnw2B5paAfCNZosbhRLFh6eBZU0QcDlTmMtqaZUgloI?=
 =?us-ascii?Q?sJZ+QlAZg+Scc3zew5khrwMkCWtUw9hI//Za8xY6FxzlSOm45Pxz42MV1uRz?=
 =?us-ascii?Q?ZaQ837rVUz8lBUrF+lljPoky37h4Y5je6P7zaIPwO13DXzHVLLWyigPOAb4r?=
 =?us-ascii?Q?z3hK8a2WIZvO1qfHSkuBfOAyYsVhAtASHL713emxlSzRt144Upsg64l9k8Nk?=
 =?us-ascii?Q?RE9tJ2Sq4jAT0J+kJpaTYcet?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7642983e-9f9f-47e4-a5c7-08d94873b35f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 16:06:41.9127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fB83YjBW4qUEcYGJn991Xb9m61VgFRBQqbLu4UV1rNPmW+CW+0hgr0kCPOn+niGM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5222
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 06, 2021 at 11:00:41PM -0500, Bob Pearson wrote:
> Currently the ICRC is generated as a u32 type and then forced to a __be32
> and stored into the ICRC field in the packet. The actual type of the ICRC
> is __be32. This patch replaces u32 by __be32 and eliminates the casts.
> The computation is exactly the same as the original but the types are
> more consistent.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_icrc.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

Oh, well Ok, it mostly gets fixed up here

>  	shash->tfm = rxe->tfm;
> -	*(u32 *)shash_desc_ctx(shash) = crc;
> +	*(__be32 *)shash_desc_ctx(shash) = crc;
>  	err = crypto_shash_update(shash, next, len);
>  	if (unlikely(err)) {
>  		pr_warn_ratelimited("failed crc calculation, err: %d\n", err);
> -		return crc32_le(crc, next, len);
> +		return (__force __be32)crc32_le((__force u32)crc, next, len);
>  	}

But all this makes my head ache, I'm skeptical it is OK, but isn't any
worse

> @@ -91,7 +91,7 @@ static u32 rxe_icrc_hdr(struct sk_buff *skb, struct rxe_pkt_info *pkt)
>  	/* This seed is the result of computing a CRC with a seed of
>  	 * 0xfffffff and 8 bytes of 0xff representing a masked LRH.
>  	 */
> -	crc = 0xdebb20e3;
> +	crc = (__force __be32)0xdebb20e3;

Eg should this be cpu_to_be32(0xe320bbde) ?

Hard to know without a BE system to check it out on

Jason
