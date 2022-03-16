Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C6B4DA6C9
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 01:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352769AbiCPATw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Mar 2022 20:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346484AbiCPATv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Mar 2022 20:19:51 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2044.outbound.protection.outlook.com [40.107.100.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBD61F628
        for <linux-rdma@vger.kernel.org>; Tue, 15 Mar 2022 17:18:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhxeyqErtC60QsAtL4OEpZ8ZA761+pXfjoTmnnBWrVseuBxHiLy4cOcns1Uc4aabR3Z0+jR8a8OBASAf5jQ3bO1WMwZ1pbRqyZ8VlbLsdH8x9A+1hWms0P7yOob+8whcv4i67A3uNdzNacEGyjqKgx1x5fQfbwLSyxo94IN/18RVCSvhb4+UzietwcbQZcgvGybvw8GZLMKoJ4SHbyxzI0/2FtBFZQNha02oQB4/n+ra8WS32zNTGbFqdJ/88VkQbSnV4WlFlZfG9ok1uZMegV9mPUPqsjJ8Sywub4fQHB0VEiZ9umuEeyTqFwNQncVcpNXXrNXzBdKU7mw4DbLCUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwOkatDjNxsjjkSjI0dyykYDpzegRNNAQe6CSUkPoPs=;
 b=i2w9YFNIhVcSHNOly6jB2+QxdI6d3iym2Q9GkZX9orKe2QjtATpb1NCOcbHnWaxqICPEmqUhilnQTB66dQ/Q6zLIdrkBNAhvqfDS2pcw0Uh/KvcuvyLk6uwMDz/qCQJ/znYRevJ+RwSuITDAym6iOJ6wR9da/hRf9zvpJ4XSiz47dXVIeYEADY7vCOgw2kTLhRlu8yw3ivWi54HAfNIwkSUTnPWIyX94rV2JBbSidgrG5Zw++iHc2dEEot+0TxV3+yBI0wG7HcgePk4IjNHoM3Zyj7CKNXsNhwhJbuqiMGoLWRrsoAPwerTWgO2KyOyqEERz43UEJHXofjZUGUTFdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwOkatDjNxsjjkSjI0dyykYDpzegRNNAQe6CSUkPoPs=;
 b=KZd7k0th6Iu5OhOvopG0TTYnuaaxhL8tQ+a9gFZDKIk4z5QhrFIvWTo8gAzRly5BiTA3Cl8Yoekr/9Xuib/rBgccJDE6Q4iuUKKGcKe2dEn98vg7JX4p/p2QsUwJbdVDrJleTdo+6fJJRPZ1BwLKWT9pkp/yAVxtHyNHEaydAnyvlOoZxJmWYGEFUaWRx4nBflKZLRF6cVw3qkzrzw6pWnl1IrhBYQkBb6++LfgufakLh6YNG9VbGnQ4+v3fKsksF83PW7OXwdBpMoYZTrIg3JP6tRIYviMViv2UQbUOEUTMDUpF9CmhdxkrAJyLK8HCpLIMXTZKngJ3pwvUCi5GAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Wed, 16 Mar
 2022 00:18:37 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::9ce9:6278:15f:fd03]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::9ce9:6278:15f:fd03%9]) with mapi id 15.20.5061.029; Wed, 16 Mar 2022
 00:18:37 +0000
Date:   Tue, 15 Mar 2022 21:18:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v11 12/13] RDMA/rxe: Convert read side locking
 to rcu
Message-ID: <20220316001835.GX11336@nvidia.com>
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
 <20220304000808.225811-13-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304000808.225811-13-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR15CA0016.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::29) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b48fda6a-f189-4c62-509e-08da06e283d4
X-MS-TrafficTypeDiagnostic: DM4PR12MB5772:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5772B31D928E6151F136DA06C2119@DM4PR12MB5772.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LhCzzbtN+7XhPPwxvGbCyu5prpdUMG8qH2nMx7PPLEZd+wfT01N6s8scek9jyq1ux6Qbj6E+RtnVNy9yQS4qeR89TbuOdwtXcZVMBlnfknftgRHBLYb0tVw3SIHHMxDHwHAaKEwi8jZWwICeY4ytfjypX7QundC8uTQCVqAqUXXBXo3C3Y2k/9NID1AjlQqw4T0dUolI5/DVs+4c0Gi8KF6QnhicErLdob4e4T+hhiSP+p4/Dd9J7+g0IP2TWErvowqCv97gF18eGcxBUVNtMy2F4mY9MTKM/srLRNNccoQOX69irx6VUCIQVLul6XfwWxoMepw8TqFz8wrbi0EigtoTzvFQ0z03W029Pf0yvxUZoPZwzduoglwc8RlBSYQiBSel5yhiB+UAISQgt4l2AWCZu2l9W7ZtyIm1m2PjK+ItDhjZsSBP2i0U9dHAIN8Cie7WVXQyhMObl9J1RtLsr0eSDSFiVrdOmMOsBrxu2z4FjlKdceQE0Ze9dbMh+zQoIcwTVEsaaEi4GAG2Ax/RYXT3TJm3xfY0lpQ6LGtuMM1qWpziIOGj1c8uEX99qN5mXMnJuB1QbgSdtrim01SLfwjTR/Z9knzMehgluJaLDFUoINHBe8BmydxXCo+lBjspzMNm1loLeBNLBOcR5ivbHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(83380400001)(8676002)(26005)(6916009)(4326008)(66946007)(66476007)(66556008)(36756003)(316002)(6486002)(6512007)(33656002)(2616005)(86362001)(5660300002)(8936002)(1076003)(38100700002)(2906002)(6506007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eTHwFTJxmKp2LVpm9YlE9Nv1EBXC+iR6uotVcvDB4EpUBqsSC7A+57aHJvrv?=
 =?us-ascii?Q?g+40WslesLJ3ha7ror2TyxXIMKiKgEG6Py0JqbDtz0hnEpRc8Kp+kbE+2xRt?=
 =?us-ascii?Q?FaCEeCeNP+QTohs0SFfu2qjdKwaVnclb8rWz6H/B1xHsWgOHhbw44f/dMnaj?=
 =?us-ascii?Q?O1DcFbx5OBmeRajewFHdGkpbRiz93n2+YB0Ndy4+hCYohB1HX2S2BT8mtA0X?=
 =?us-ascii?Q?tpo8E+6m0GUUIqz5iTmZzSu2hedHAnLCOXuehLHWZyjAUuYQhu5UoTZiBAHC?=
 =?us-ascii?Q?x2H16iPKISVSOiqQYU9GTHyqwLhWnEKOZfhlmkdvBxdb1KrKm0dxhO0sG6gf?=
 =?us-ascii?Q?tET1VNHAhIqbRCYBug+WHQo/j1iCEveGyoUEPHejpDGrBxrrp8Gl+ct1KtCK?=
 =?us-ascii?Q?/+PdalbXIgOwLKM8reVL8mjl4EWnYRDY+dNghVuw9ifbIIYd34JgThZBs0KI?=
 =?us-ascii?Q?mdbKMRLOpkRJqiAd2eHRzMDWe9Hc820Hh5bIw6x141nMWF6b/GzxzLO+KAlg?=
 =?us-ascii?Q?ym+Oi9V1uCkmqAMaHPzqkS4XpfMcGKBr6Oh4XfZdIkQTE2anGYhDDnaMrni1?=
 =?us-ascii?Q?SUCpEOotuCw8tPb0XMTBZgvl3JPQclDykHboNW8DMkIaSfCzBAs3tY+un5MB?=
 =?us-ascii?Q?zrxYpOpLUdcn7W8u2y7c9yujVcQ9XFzJHkdCCWA/1bBRMGnSVyD6WPHQts/H?=
 =?us-ascii?Q?LCz9AZ7cXpg4TVl0UBfUKzBdFXz0F5C2o4djNMEhBJ4CrbBxYSiuYtP/umvQ?=
 =?us-ascii?Q?V2glqn+e74IEZIcYnEcxjdL2gYUoXMhpz5pjdkwOKso4tl5PLft6ONm+k1eQ?=
 =?us-ascii?Q?3yUz3pXRSUj246sG5+8LxFTPxmsMR+66veDVCQ90b/HAT7+BARPqvqmf1eI/?=
 =?us-ascii?Q?xx5VYP0tLUbC38npEKCneqYyEITDiE0aFpVAWaxXJNwSng37BMF8DXQgqsQl?=
 =?us-ascii?Q?ppmfDFZHQT3RzyZAGOvge4TQmNEImE5UrvYqRZDOF6fl4fr5gIwodwoBD5fU?=
 =?us-ascii?Q?IjAeqxrDUnr6+QMhLd4AyJtnoESYFVYBYJWAhvhzcAnr6qvCnJz7a2SBVhV3?=
 =?us-ascii?Q?ZnQz66zThF3eQwMqqGF37yXplQTlr0fLJ9c6kWJ8yCBCmE3bLBqtbfuAGr95?=
 =?us-ascii?Q?FkvNWeeej0tN6RXdjgWcStB7SYUPs4V94o7ULW4a/mNn8y+LrMpPzLkMN9xo?=
 =?us-ascii?Q?dMMRiSdyUupEO0bXG0ja3E9X5EvFRbmh9ipqc7XygbJxA1Dc5unPptq+tK1c?=
 =?us-ascii?Q?iUYUwxqfXgJBA7+CfmbhpFDYqkPOBSSuoJDLseOIj9me3e5NJ329iz1nJT+S?=
 =?us-ascii?Q?zrX55wrHJSEK5KQ6Vod8wjZvU+S1LiZVKXcZag+HNDdEXwjsAqH+0rP3mS5B?=
 =?us-ascii?Q?ES8TtwfBArRzTMLBNdqVm0LM8Ptlji6bStC84ZdWy2g5OZ3q4FNK+bHH99ek?=
 =?us-ascii?Q?8nKgXr/p+OvLgBSeYXvc2YInGFCKNBy8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48fda6a-f189-4c62-509e-08da06e283d4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 00:18:37.1870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlKI01jcMTvOREFKf7i1e2pYvD+/QNRTC1CpbVCwhKSe7dqklM9kE5Eq670WApqG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 03, 2022 at 06:08:08PM -0600, Bob Pearson wrote:
> Use rcu_read_lock() for protecting read side operations in rxe_pool.c.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>  drivers/infiniband/sw/rxe/rxe_pool.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 4fb6c7dd32ad..ec464b03d120 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -207,16 +207,15 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
>  {
>  	struct rxe_pool_elem *elem;
>  	struct xarray *xa = &pool->xa;
> -	unsigned long flags;
>  	void *obj;
>  
> -	xa_lock_irqsave(xa, flags);
> +	rcu_read_lock();
>  	elem = xa_load(xa, index);
>  	if (elem && kref_get_unless_zero(&elem->ref_cnt))
>  		obj = elem->obj;
>  	else
>  		obj = NULL;
> -	xa_unlock_irqrestore(xa, flags);
> +	rcu_read_unlock();

This makes the hide even more confusing because hide is racey with
a RCU lookup.

Looks OK otherwise though

Jason
