Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8862F61632D
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 13:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiKBM6B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Nov 2022 08:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiKBM6A (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Nov 2022 08:58:00 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DEF2791B
        for <linux-rdma@vger.kernel.org>; Wed,  2 Nov 2022 05:57:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mj3pHwuxsALUYhIyhI7u12HxESS2aeBb9BSn9XF3XanjIAGQdsoX9ge1Hy+Bcy89nKRlNA2bwSzsI32mzJoJPxgk53m4SjJchgvemngUqnCrU2E0wld4t+fWs6nKRQpTe0/zxVj37VUUySx/uqZXWLnguOjefFTwWvsk6CAvdQlJnos4tbehBT3PVYFAQFSIgs2NzYo4FUo7vmVXh8fcgGFrxGVPQWV4dCtWo5z7aw4w2NLCE45r3daG0SUf0YD0f0NsDp+x3Vns4nfPkU8IHRmA33so8LESaHztNt+Nobpovu8SkuwGSXLY/+6+vNxsPRA/KXuRBXFK4bJDDs2oDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3WXvRISm0B8hEwReMQsAZ1mP9+6/oAJJUmnjz2Bi2c=;
 b=VYp+3RbDIDzT2j+af58+uAjhVOqJTkTBNQkP1eDQbFeVVmoHK/gca3KFSW4CR6QkAUbYqQDAhiRn3sYbQ8GV3tOqX7X29COaLLfyA1C/D0Sfyg4dUdor9CdDTpnCojguvncJ6Mt0ki0ZEKk1w9h53ztvdHiQt7y03js7oqbXkhLpZfsxp39KJZQiMvHd/F11rnK78EQh4F225t7Y10+lI3PfxhCBpYvcwHtrRckXy8WeH3DH+gFxc71J8srXT5EpNHKZ57AtZTVtJA9tJggOobDbSw9NCAZInmlA7L4H6ADMZCvaA8U8uHI/YEfiH+r3toE++mDjE3n8jjnnV1V6Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3WXvRISm0B8hEwReMQsAZ1mP9+6/oAJJUmnjz2Bi2c=;
 b=MYAGX3fbx+7k0sV/+rwc8DmoGVczn43pnzs/0QK/wvHnwH6fpzhT7J3voloIFc5gGvEXoiy92y1f6dNQAkPcNNZVq5twrcAUE7mpJUuJFUC7Pbph4Dx8KsjqvhHHny2dnWBqkm2CY8MV2Lo8ZfAgrZSk5CoJMfE9794tLhGRUN95H2r44M0LfFf123K4wGnkHsucSI990/rDfAdjYTdlkZmDWQvT6vQZMLSebFt3CtHMmODjihybKx7Uizw+lz8SporZIBam/oQkI1DLCZDkIp5gw+bhhO0eY2mRrF9YmZ3UGRi4S+JS3XSusTn6s3q9eXPYBCz7s14/hLHV5u50yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 12:57:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Wed, 2 Nov 2022
 12:57:56 +0000
Date:   Wed, 2 Nov 2022 09:57:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 01/16] RDMA/rxe: Add ibdev_dbg macros for rxe
Message-ID: <Y2JpU2hJaTghhgAn@nvidia.com>
References: <20221101202238.32836-1-rpearsonhpe@gmail.com>
 <20221101202238.32836-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101202238.32836-2-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:208:23d::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 097073c3-ac3e-47c0-7fc9-08dabcd1dc7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZXCIzRehHWcIKw3ToEwQCOwfSBil00ZCi3GsB1NV5pP6WNXh8YxFYdzCb6mi/Rwz5jBPQMUbu1DoqGuX8ihxEGdKsNwxViEg28V4vHKL5vgL09RkW0Ve34NaXsNdeqmPGq0XwqLp/1TgKkix19k1jWkRpHzQwtr1R8bTAZNsNTxuatwRlYh+Tba3XkDY88EXL2v+GrwUQjEa/Ro88WtM0TM/XiowWxELxcvf+hfJ+lTJksuk+xa2ratqNcGiXrrlIt5K6/ljA6Op8Yj0XhmxbWmgcj1zYdGrkF/guFhuLB3RgvVJzj6P53IoY9N/pBUFZ+FspF6AJ+K5f8t2sh7/E0ImN0eL9cDH7pAcPN2QFsINMJGkL5h1qh1eN+mo39j07jV89JwW2crlSOPsW4YG0fm4nd+9PkZbe7FVvEdqMShk77WHJeRYD4FI0839/Yb6ZN43Q3Gq3NoTChAVF0wqB9bXNg9+0iXV7FrFwuiUE1uEJ4bCXZr3OBk/yDkvPskp2T5TDWEu9/NSs1LinLme0Du9yoFB0THBkRsEUr8+uIA5rRLyllnV0hxkQDwWXhkqdQoGQF29uNtDjjTMHo8IVbOBnviKPXgrZEMm3PbWAQOkCoZZeXPAN5YGB1thMTPZTxBBodaymvVlCYuZ6lFFj2cgfTyJL08NWKzriRmL5QIHMujbBAFnvFli+GGrwNHu1KerK5kSK2+MupgZZcuYKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(41300700001)(2906002)(316002)(8936002)(66946007)(66556008)(8676002)(66476007)(4326008)(478600001)(6486002)(6916009)(5660300002)(83380400001)(6512007)(6506007)(86362001)(186003)(26005)(2616005)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CEcK/1Beh0pp3fzHwJJ3W1CIzWuV34xQXoKaZK8isEkrlrYdd2wCEw/4C65T?=
 =?us-ascii?Q?IWdrCqrJE7j6TtuHSy4w5FBvdBqdpQs70g2IvMU5abOwlV6COTAMVOR160Zl?=
 =?us-ascii?Q?7Pz/ivAw/+NVmI/Je8rZO+PMhOMfDrR8b2IpAP412ybaEBifS+bYaygNtBo1?=
 =?us-ascii?Q?D2lriZfo2YnouHvImK13mlZlKsdVQudkjgsHFYfs14ZJMmfpq24+sssmUMOK?=
 =?us-ascii?Q?NVhZ1tHa8/nNPBtcqrfS9X22iHFdmLcA+xBbwLtYgn0lURFEsXJR00mpvAff?=
 =?us-ascii?Q?I9S+4eS936H8FxopAGIMqcT4Gzm1rZfLTEI+VCyuHhg4kdTvVepDY7CO5bvq?=
 =?us-ascii?Q?1xMxWDmQfz3tAP5PS+JFx/pFhOT5wWaKVQWpvk/kaCJD7HxE+du9Ec2NU8//?=
 =?us-ascii?Q?OFKgyEk8/mU6oOS0o0M1y/Z6mF3GjEWr5oYcOXNTYUjtpYiSsCjmceIJkd9y?=
 =?us-ascii?Q?y09KUE6evcpIpBLL+onfe2u3svPS54ifi2ia8foeNU/TS4rg371ohhoHtrwz?=
 =?us-ascii?Q?PT9TqxVg5oSkJGOm48KKXC6XFylAseegqQbvd8X4JuEg4qmqwSFXCXSXdczx?=
 =?us-ascii?Q?FTU+ELzXhfF8ToqQZluqKZ9GzZBSyGXpJ0kRPMLfuCjKQQyn/DhD37/ISIFv?=
 =?us-ascii?Q?ugZcRx1PkmRlU0IX1Ki/kyAIn+yaY7+jp5qNxPTyioT3kgp9Ijkvptoks7ER?=
 =?us-ascii?Q?NJMgkh1f2Vo4yAccX4HYP5it2CF6pMO8TnPhCpVixNtEckaz9a/NGNAMMsRN?=
 =?us-ascii?Q?vvgMM+WNmigCTSikr8xXsbl4WfLbvxKm2LXcYiIV8+bZTFZCeb+TKVM+URpB?=
 =?us-ascii?Q?oppgqMZ0/Ly2oCqRLyNXC+LpQPA1b7JnclT+lEmMfTmBYlPpkStM0d9u3eU7?=
 =?us-ascii?Q?c1XUXO7mii+3VifQjjV0puWaOOkGiQTnFrkuJXb0tsc6uvZ65dxw68Oju96+?=
 =?us-ascii?Q?xHQ9lxT+bUwvFGwvF2/LyJMfW7A4W/FjA7rhRSgbecodWHUqvoP8ztR+YEtL?=
 =?us-ascii?Q?atEScK/iY7CGlbwaW0hB+6KLOsq2twcRKRU3+RoVU5TxGVsbRnGSXxBknMoN?=
 =?us-ascii?Q?Q09pT9MsicSjhICmxT+/OXzwFaucRJ742KfJP0+UQjrubqAEp8kzWZfvBCvX?=
 =?us-ascii?Q?GeoOnv1qjI+/mIxsJrfGasi77c8yyxv3yZJbRTxWmgwOssjLyOWjW1BtVS/I?=
 =?us-ascii?Q?m7W2MUvb5X+oVJyI+LRW0Yx+/NzybjJVajF2eCzIgNCKyiGxFx9gH/p8ORLL?=
 =?us-ascii?Q?mADGklm6lfqyWB+IfIrK6l9MmnGggP+0PUXwFRPVf95G/ceR2AFvj7z+Fxaq?=
 =?us-ascii?Q?6nHBgQyM9Nx75+EQMMkVrCdwAzkZ4CxSywOcA6/tSVFDMaRvBcbj2FUqem9t?=
 =?us-ascii?Q?KJolwuKdFkLfAMMN4ne9PjuB/05ttlnqpuUjUr6CFxmtgy85m9qyxzEdCd8M?=
 =?us-ascii?Q?4pKDOPpTDgYGecrlIHTbTepa4k5pmu2HoBS9flNxTGnmUUdKEuNutE+UEUYh?=
 =?us-ascii?Q?2DSkOb+Ja17Yq7ApuJYsNp89+48QoctYvILSxz26IlCB4QPxNgt7e9IK36DS?=
 =?us-ascii?Q?nycIBIhjWRugW4naYz8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097073c3-ac3e-47c0-7fc9-08dabcd1dc7c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 12:57:56.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vp1rM3MKE7TpkPzJBQTukCf5yoWVKDT/EvYBcXo1+AjNo5WwZrtes7PfNiXh8VeA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 01, 2022 at 03:22:25PM -0500, Bob Pearson wrote:
> Add macros borrowed from siw to call dynamic debug macro ibdev_dbg.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
> index 30fbdf3bc76a..1c5186c26bce 100644
> --- a/drivers/infiniband/sw/rxe/rxe.h
> +++ b/drivers/infiniband/sw/rxe/rxe.h
> @@ -38,6 +38,25 @@
>  
>  #define RXE_ROCE_V2_SPORT		(0xc000)
>  
> +#define rxe_dbg(rxe, fmt, ...) ibdev_dbg(&rxe->ib_dev,			\
> +		"%s: " fmt, __func__, ##__VA_ARGS__)
> +#define rxe_dbg_uc(uc, fmt, ...) ibdev_dbg(uc->ibpd.device,		\
> +		"uc#%d %s: " fmt, uc->elem.index, __func__, ##__VA_ARGS__)
> +#define rxe_dbg_pd(pd, fmt, ...) ibdev_dbg(pd->ibpd.device,		\
> +		"pd#%d %s: " fmt, pd->elem.index, __func__, ##__VA_ARGS__)
> +#define rxe_dbg_ah(ah, fmt, ...) ibdev_dbg(ah->ibah.device,		\
> +		"ah#%d %s: " fmt, ah->elem.index, __func__, ##__VA_ARGS__)
> +#define rxe_dbg_srq(srq, fmt, ...) ibdev_dbg(srq->ibsrq.device,	\
> +		"srq#%d %s: " fmt, srq->elem.index, __func__, ##__VA_ARGS__)
> +#define rxe_dbg_qp(qp, fmt, ...) ibdev_dbg(qp->ibqp.device,		\
> +		"qp#%d %s: " fmt, qp->elem.index, __func__, ##__VA_ARGS__)
> +#define rxe_dbg_cq(cq, fmt, ...) ibdev_dbg(cq->ibcq.device,		\
> +		"cq#%d %s: " fmt, cq->elem.index, __func__, ##__VA_ARGS__)
> +#define rxe_dbg_mr(mr, fmt, ...) ibdev_dbg(mr->ibmr.device,		\
> +		"mr#%d %s:  " fmt, mr->elem.index, __func__, ##__VA_ARGS__)
> +#define rxe_dbg_mw(mw, fmt, ...) ibdev_dbg(mw->ibmw.device,		\
> +		"mw#%d %s:  " fmt, mw->elem.index, __func__, ##__VA_ARGS__)

All the macro arguments here need to be enclosed in brackets if they
are not a singular expression:

 #define rxe_dbg_mw(mw, fmt, ...) ibdev_dbg((mw)->ibmw.device,		\
 		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)

Jason
