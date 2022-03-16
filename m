Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A694DA6C2
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 01:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351218AbiCPASN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Mar 2022 20:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245600AbiCPASM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Mar 2022 20:18:12 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2067.outbound.protection.outlook.com [40.107.100.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AA54D636
        for <linux-rdma@vger.kernel.org>; Tue, 15 Mar 2022 17:16:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnD0OMFzqfJ3cN4X6nC1MQAUntCA0euV7KhLmMxlvYDfUX0fm0i6Face2pUoqGptihKPsSMEKhK1KWBECusZALVskPxfl1kYieY8+PD5dv11vsX0K36Ip8gfPkDMwE9Jj6gxu91a12FRM6s94DXtRcYe+rtdcoXu/plCHfg+AyS7sKbu7gQ4IZ6rMSRHpLTOmm8iHwDBmBkZBIxlsJLT252IfN4niuxEdI1dkr/xOLuof4uFa4fe8Xh++CyMp1PjANP2FrCV4F2AsQXCB9vb4jgB5fe9KxtrIdxVNkGNTacKoh/YCz2nlN4FWEC+YtkJqEkg0ZjjL5Eum0wHvzw0ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJPkrOT6tcp8q702NyBNBnNkkoqX35gtdaYY7URDkKA=;
 b=XMWwAiw025faPZ6WXxagvbaXiLDSvmHxFwhIDUz39CW6WzqRyBtZe5IBvYqsUiZUNht1wUbyeJ6vlVwsx10o+tNfTyl70CD0kMYd0KKeD4OJwdWlFIprKoj5WXJGe/Nn4eee/VDFewUeCmpchCI/C5IUia8fRPPBSNMgSeNw096H6jnYfY7dNIuzVy69ispWcMeFmsjw3SevqlZ0DALQTzJrtz4HGMazWqFBVzXO0LuPK5QCM9hLpP8fInQiJHr8VYSzkrXGF7tZYDhkdApXEUCVmF3N//Vd4IrzH9sQSD9AgPUaNZ40HSOTZ8Rq4Zc2AqkCensU/QwnXY9eq+Ny/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJPkrOT6tcp8q702NyBNBnNkkoqX35gtdaYY7URDkKA=;
 b=YYzRqxiSfR2zLCxJT+vqiSv35InluEoDYzIktFA0KRXxL2gABCvWY6pfRrdKLnGXSJpp52+iLU4aEH9ddHh04yb5QM0BencKkxFxDDeTieDiaBiuXza/VTGaJvU5un/bX0jJ0aT3XvrikirvZX5WbOq8C00BOX6TpgGF2l4eerFDujV3gEQGPDR5M0q89QMJ5Sfyh3CMX2U0khkPkZiZoN84mKTUyMJZLoyO+XAw4C0l3My+DKg+QWrs4+3eKcSAXQvSdMS67UDo3qk85BJFfoG2WBfFdLhPlh3cT1V3vJYNJvSffLjYwjoby4J2CORqzzStF3kVkwFshM1IGbqgKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Wed, 16 Mar
 2022 00:16:56 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::9ce9:6278:15f:fd03]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::9ce9:6278:15f:fd03%9]) with mapi id 15.20.5061.029; Wed, 16 Mar 2022
 00:16:56 +0000
Date:   Tue, 15 Mar 2022 21:16:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v11 10/13] RDMA/rxe: Stop lookup of partially
 built objects
Message-ID: <20220316001655.GV11336@nvidia.com>
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
 <20220304000808.225811-11-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304000808.225811-11-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR18CA0004.namprd18.prod.outlook.com
 (2603:10b6:208:23c::9) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d153c36b-8d63-416a-e84c-08da06e247b2
X-MS-TrafficTypeDiagnostic: DM4PR12MB5772:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5772347E70463F409606376FC2119@DM4PR12MB5772.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPM8Pxo3NhXd5sfrRGeX6yv5enD2S5Lj00fhn71dajP/iZNB6fznt6lERBB/9/KXezxDE/FQHRvrxspBM8S8lX0WqWQMy8ksMijzHT2J3QEydJnjskWnG2iDgFm8X9xwUH3lUQVOtiU2rfcA4h1233cVV+RyfDgT1w06JepbWDlTRY9umOAYgeWSwHs4t1oe8Cbf29usv+MyVPtoF66KghBJRgkSG/FJV65DY0vc3ywVGZyzWizOA1HNNVArx5CM6J+kIwbK157e8X8/G2E6PHN/kpz6JAfgqYmqFiO3TZKejLrDDQDEBGySNlbdb0p+mqQNWzPBVwfk3UM1JC34uxhFeML9BUeSziMFZrM+dAcjQ/6neZu3ujof37ba+zwMpqH8Zy1jhGx3M3LegWZgGbEqY+Zo0ctSCGmeGx5yVxwjLddRHbAlY8kCnrkdnZt1po2Ux0aRt9htH0y2Zd3vLnPUMunnWL6oTJ/5XeYx6EacV0VjnHJbz5ZFQx0xbpsiF6ZQJipl5M7Zv0BWy0nGWwbbAf3ze3LUJNdImPJ0p3xa2OtVSE5ebxBd+Yp4clnadn/2fAIQj+ZzNDIP5HSswefOn66Klfs0l5YJaVaS8IQHKF/Acw2E3psQvAPkSGv5jDyFXyIEO6/yBPAqKCqIVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(83380400001)(8676002)(26005)(6916009)(4326008)(66946007)(66476007)(66556008)(36756003)(316002)(6486002)(6512007)(33656002)(2616005)(86362001)(5660300002)(8936002)(1076003)(38100700002)(2906002)(6506007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CTagvBQ9Cm4cnIXTLH72hrgPC9A9rajUI6NoaQmPYdjyMWZXhCQvSgUva1Hp?=
 =?us-ascii?Q?lFf0mfUMwNKY4TVvg6ur1mzhAJ9xrdJE0SQRUfAsU1JOpeHoBKIDG1u28nOa?=
 =?us-ascii?Q?T1MqVILnuvPvJ3InoY0ippIOq2W2BQExunpBOBRv7mDl/KBAbfd6u8e8f2vK?=
 =?us-ascii?Q?mkwU1aEcbBwXQC9xBZiBMiyFTLn3d43EImY7SKAvseJ4YqPd6555hVlwzoJ4?=
 =?us-ascii?Q?S/Hqv7z0IgyYgMZxskeVO5q07mUst9Sxlq5vlx7ng0GcPTCJq20A7LIiDYJH?=
 =?us-ascii?Q?zwtvApb5M5Flg0G/JXtZYPxlCV2Rl7zr6I9yxGQm+lYFuzKEQVbP9jeBEq0l?=
 =?us-ascii?Q?6jJXT46BzVijFxKMIfhTBAdpnkc6PlMUsdGyN6uyS6M7q4vzmVaO/brxpVo5?=
 =?us-ascii?Q?yn9NJoTE0SRq+WpLhqx453QKTsOXtjB4V60OR2SEZWZLMpOyIDviX+/yTjFw?=
 =?us-ascii?Q?z3L8d6B6aqPea5CywymjTELEKyKAhh/1ku/Y51NvaBG3C2UA2UFYvNbpsHVy?=
 =?us-ascii?Q?99S/T4PP/ZlzZWyiQIzvUNasPrkI6FuOywVIoz8U3JvPaBExhWVtU3aquK2q?=
 =?us-ascii?Q?Fb97QpVDiGocRwnVxKwDC4WM+6Vdk6u7bB/TQsNaBx0+RWEjvBA/48gVL7x+?=
 =?us-ascii?Q?rXCKtwCGARdaDwI01ShP9jheejTFNBEauNF94eVrFTK6snZazyaPa362VFo/?=
 =?us-ascii?Q?1K6FmzqaYUmuJH4MxM1z1oPNU4s9jE+bzA2SzqLFduxCwGeDDc6Jv6cPsQU2?=
 =?us-ascii?Q?2TmWl+mjDHylyKaChaJ1scwe72xJ5Fc6WNEvNeSP3xrXfsPvu0uyzA5/bEnK?=
 =?us-ascii?Q?/1ouOw4EWBCxt2CUBaZnxdBHfrHS961CeL4S3xk7uvGjq2B5pQmPR5OfTt7Q?=
 =?us-ascii?Q?w2GE0gbWlBkm46HwOrsLEy6TNgfGy+aMl4l/n+JkGaaxUSPVwxH+YNtQR1BT?=
 =?us-ascii?Q?Yi8E1zfT7jn9kcdpkbkRYKox42TqTLBG26P6zywJamjL0vOcYolA9mzzIqZL?=
 =?us-ascii?Q?iKCnZbVhrdWjrf6jvFZa/EHoVydyfwUTXllhXz71DBHnKJ4DWCMQ/JD7fW3D?=
 =?us-ascii?Q?Fkscm+lylAVO5bdIgBZY4QFgAcHi/XWk6FJplwvVCnd4QIkSHfm1idCnfjFk?=
 =?us-ascii?Q?tfP7jzzgcWjDPOQUMJrkuZ/F1WJgUjG/VNIcKcFyEbkKbm7J08DjWeTia+q3?=
 =?us-ascii?Q?wALLI8EQ5I1/3Bsoan5tvSQpL+uNv/cXP5Cb9Z5SndNeL9yOzDlsP88wcvhX?=
 =?us-ascii?Q?90A8Qndm62CktdDEJGTi+ItsSCP0WhVCdzXbiKIJ/NoyNAWqrsHc8fkZc/5D?=
 =?us-ascii?Q?uj0P3Exynak1EF5zjtRqt89ut+NOoHsBkrqYLm9F1122J8SjUhBUGAegN4zs?=
 =?us-ascii?Q?cR05VrLiEIrEqRyx2M6yd2oWTCmGE1jGN85OHVai/Vu1Ankn3aVnI8DGI3jF?=
 =?us-ascii?Q?tzfEvfqLKaN64A0ZI2BMjWPPVuoNeXlj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d153c36b-8d63-416a-e84c-08da06e247b2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 00:16:56.3347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVROqlTgcd1hCBImq01U3GurI3mu6k+qzRj+mxIO2uoH6/2dF3tbTyKUwallefFX
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

On Thu, Mar 03, 2022 at 06:08:06PM -0600, Bob Pearson wrote:
> Currently the rdma_rxe driver has a security weakness due to giving
> objects which are partially initialized indices allowing external
> actors to gain access to them by sending packets which refer to
> their index (e.g. qpn, rkey, etc) causing unpredictable results.
> 
> This patch adds two new APIs rxe_show(obj) and rxe_hide(obj) which
> enable or disable looking up pool objects from indices using
> rxe_pool_get_index(). By default objects are disabled. These APIs
> are used to enable looking up objects which have indices:
> AH, SRQ, QP, MR, and MW. They are added in create verbs after the
> objects are fully initialized and as soon as possible in destroy
> verbs.

In other parts of rdma we use the word 'finalize' where you used show

So rxe_pool_finalize() or something

I'm not clear on what hide is supposed to be for, if the object is
being destroyed why do we need a period when it is NULL in the xarray
before just erasing it?

> @@ -221,8 +221,12 @@ static void rxe_elem_release(struct kref *kref)
>  {
>  	struct rxe_pool_elem *elem = container_of(kref, typeof(*elem), ref_cnt);
>  	struct rxe_pool *pool = elem->pool;
> +	struct xarray *xa = &pool->xa;
> +	unsigned long flags;
>  
> -	xa_erase(&pool->xa, elem->index);
> +	xa_lock_irqsave(xa, flags);
> +	__xa_erase(&pool->xa, elem->index);
> +	xa_unlock_irqrestore(xa, flags);

I guess it has to do with this, but why have the xa_erase in the kref
release at all?

>  	if (pool->cleanup)
>  		pool->cleanup(elem);
> @@ -242,3 +246,33 @@ int __rxe_put(struct rxe_pool_elem *elem)
>  {
>  	return kref_put(&elem->ref_cnt, rxe_elem_release);
>  }
> +
> +int __rxe_show(struct rxe_pool_elem *elem)
> +{
> +	struct xarray *xa = &elem->pool->xa;
> +	unsigned long flags;
> +	void *ret;
> +
> +	xa_lock_irqsave(xa, flags);
> +	ret = __xa_store(&elem->pool->xa, elem->index, elem, GFP_KERNEL);
> +	xa_unlock_irqrestore(xa, flags);
> +	if (IS_ERR(ret))
> +		return PTR_ERR(ret);

This can't fail due to the xa memory already being allocated. You can
just WARN_ON here and 'finalize' should not return an error code.

If you want to be fancy this checks for other mistakes too:

   tmp = xa_cmpxchg((&elem->pool->xa, elem->index, XA_ZERO_ENTRY,  elem, 0)
   WARN_ON(tmp != NULL);

> +int __rxe_hide(struct rxe_pool_elem *elem)
> +{
> +	struct xarray *xa = &elem->pool->xa;
> +	unsigned long flags;
> +	void *ret;
> +
> +	xa_lock_irqsave(xa, flags);
> +	ret = __xa_store(&elem->pool->xa, elem->index, NULL, GFP_KERNEL);
> +	xa_unlock_irqrestore(xa, flags);

IIRC storing NULL is the same as erase, isn't it?  You have to store
XA_ZERO_ENTRY if you want to keep an allocated NULL

> +	if (IS_ERR(ret))
> +		return PTR_ERR(ret);
> +	else
> +		return 0;
> +}

Same remark about the error handling

> @@ -491,6 +497,7 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
>  	struct rxe_qp *qp = to_rqp(ibqp);
>  	int ret;
>  
> +	rxe_hide(qp);
>  	ret = rxe_qp_chk_destroy(qp);
>  	if (ret)
>  		return ret;

So we decided not to destroy the QP but wrecked it in the xarray?

Not convinced about the hide at all..

Jason
