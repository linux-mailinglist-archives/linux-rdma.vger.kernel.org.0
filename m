Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECB94A0025
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 19:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiA1ScJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 13:32:09 -0500
Received: from mail-mw2nam12on2049.outbound.protection.outlook.com ([40.107.244.49]:16481
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229827AbiA1ScI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 13:32:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLkokiUeYS49MVCxdWC/iSAPZYpM+hRJAgbZAHGdrEKBznqLNlXnb7xMyCDwF7pRAOkfwYlMBEME9Mg+eaWRJPij/sr3jC3sTAsBOffNYgfontxXP99mDX14yxM+2vdX7xvAutrG1JTsry1IXM07eqiRQplPpqWQLRNnKUm1OVZZTl6ZwJXzzQ5rrgGnDmrkLCEm71v7xghnOroYwc3u2C/+JwDGFFEpo7WbseH8cemFjjBD6CYTu4XGWoxE9GS2t2CIYwR/0In221WboXQDegQ1tJM7lfF5pX9XphKojDk41Ox+oVQflN8sFXruktRY0tUwMEQS3UFDyPwe1l5gew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jz4J0A4pMDpjzP4QCwzPtX2kKUom5pOgX4LJLZKfaSU=;
 b=AQwpkftNHkQ3OFs8wGzkp7GSGj/051Fh+BnGK0tkkLm4GqvAp9ArQeZlfHe5jzTkczcVKoT4IMqZDvB28XmMcPLWvb1bqRrstHt1OE1+7xbTDXVKxG5x8xf8v+CUh1D6JJ0PyoXwvVzve30P981Kl6OyIZqsYUtIrhYMxwuA4jJ00XLV66kxbYtAQUibnjhlZAB7XRF/BUQNHgHtnITEmZK63nswsUMx+slNQDYw5tqUzBepDpfI4lkfYUkp/Qtwj6StnWttQaLI/XWVy8zzgxdq2aeND8A50SrX4KSMC57bkP2l6Waty1KhKP5MkzD/QaVBWmq6eVXLkPdW2hSLlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jz4J0A4pMDpjzP4QCwzPtX2kKUom5pOgX4LJLZKfaSU=;
 b=DOLbyYcFrV8qR7h1SOprrsGsbmlBQLyiLr856qI4fPLlFMkozQfjFV3tfzWOpniyTvZIB9KMSnlDdKC25pHzcPVFNPxAVhOWU7FZq6P4rfJg5PSrar18D0LL/DaF0bMxjAiIktV2S+Pu30fIMbAEUAOyEG91Gsdwg4Qr4D5A9IOvoLZYjnRRBEFbKRfjlPMicB4S+Zhv2Dyp22hvOqXdo2F0QjIKoxqqCA6TdB4e/A4u+XuiSDcn3/d/kFvYV9fgUsOTZRA9OYCAvRwZGz0oBOH0szrmnBwmuU8xTyaekp1BUfaV0f0VZwL7anGyGHuoL/yw8/rnDunHeau5Ati2Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB2940.namprd12.prod.outlook.com (2603:10b6:5:15f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 28 Jan
 2022 18:32:07 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.020; Fri, 28 Jan 2022
 18:32:07 +0000
Date:   Fri, 28 Jan 2022 14:32:05 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH v9 12/26] RDMA/rxe: Replace pool key by rxe->mcg_tree
Message-ID: <20220128183205.GF1786498@nvidia.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
 <20220127213755.31697-13-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127213755.31697-13-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0123.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::8) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fffc5e5e-0d4b-49e1-2260-08d9e28c7cff
X-MS-TrafficTypeDiagnostic: DM6PR12MB2940:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2940A371E5D9C3377E1763B4C2229@DM6PR12MB2940.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vg9H742e/6nbmmMIlXLJn0uqZr6qtWqGv9IVCTzy3dumFIUFugkP+rUa0/Wv/WtUdlp35UbKkI1m8s3Rw7KDAj28dM7xMXYxjZRJFgyAsa3rLIeQGUFsUVWSbZc/bih1q6y/oaGqxcn3yhXzvV1rzg8a11XkcRIGpSg+TDo4EBIB0WTcH0yfxe38hxLNfBs+kXHo4Tx+eFyxJv0HPCXfmjlXda4uXijBZ6Dqz8gr/dEE2s8Df9sE5OC3WD1V5TN2mVSBF9C6mOx5V0ZsKPw7Fc5gfoK50ChOqZ23jJjBfRuwPOKUu2HI/AQ9youZfqMJfjshMRFWrWW/iRGEeG3Sug0mOx2KDVVHxRBlHpstZCv6qZWwwovwRAQDAhHKmPR3VRzsruHARrgLEHYzAVIY30Jm1Eu5VvcJzj/Czob3zX2PJ8lL7IlDxiJNavzmqB5i2IiRmTwlr3AqjWZ9PnyQiQRS8UVy95WaIxiP1VCNVE95RiVDic0OZF7+wuyUl5Egl96SxiZF7UzcHb4CLF6NcocRQqtlIufaJBBpVZQp1xP1Dx8lGL9bikbEK0ymZk+tUVYmwcGbnxGMiBPSzGLi0kFFzMHbGKerv/+s+8bVNyoNGkanXwbv94LTyp4XkXhfA0LQa9YFvnpMFdiX/dRTSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(1076003)(2906002)(36756003)(316002)(4326008)(2616005)(66476007)(6506007)(508600001)(6512007)(38100700002)(66946007)(6916009)(6486002)(8936002)(83380400001)(86362001)(66556008)(4744005)(26005)(8676002)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9pndal05P+z3PBDERfdfUmoW4KXtf6MI89tm9yG1+RPaEVLG86KMaskNmU2u?=
 =?us-ascii?Q?AeQ6GSCSquViJe0j94Gi/Wd+bcoqMWqE5tPy4h5TXtAI2cATJ6yExDf4HGgz?=
 =?us-ascii?Q?vkFaTGF6MTE7krXmboPc35s0RzR70qCFnfyuM5yaiRaqLDyaH87XvZPjyQmr?=
 =?us-ascii?Q?8+NBwqDM93bQbyx6wqUKlVuHAOvbzw/gseEWqWijn81lrmYHr4t8VWI0RZJ+?=
 =?us-ascii?Q?v/qOd1wXAWdisccFiQuKV8H09P4m0FQ7gACkwx9O/c/kKGC4IhGNsjEeqmJs?=
 =?us-ascii?Q?EPw9iXsr/A9kJfJyYoljAvDPVc3BmKw9wklVgIPsl9BiMBDpKwb8gLMEigBE?=
 =?us-ascii?Q?lZsAXoWp6WXyMnjh5GUnEPqtOXDBxWhtyOeygm2PvA7Ra1tIn7UTCTTNbHG2?=
 =?us-ascii?Q?P57MMAvd1TgpauvAlfGPXz6c0aYnPIdcNzxpIcHriavYcDc6+YJwT73VMdU/?=
 =?us-ascii?Q?xzT5ntV+3lhrgpQQOKmu6M8rxysMPOsq5ltd9p//EtpuI+zb0R8RIDJMqcJZ?=
 =?us-ascii?Q?dwm4dSxBkW9/3NZayxv46XLNGPVIBtQ6J7YHFkUOavqydJovt2d4ezNs2DNB?=
 =?us-ascii?Q?/DCisjmdX91dyAJW3tCAv25Mpm25wCmv8SWrxJKfjpqaDJl+iVbNQ0XNvrff?=
 =?us-ascii?Q?X69JXDu+un+rDVMpAW3gWl2Ob9u7ltIYG8ZR9Zn/vuobaLPiclTngQxO1HJT?=
 =?us-ascii?Q?s5EvU11UUSC86vBLo4up9p1LkD6Tabxyp0bEf22sTzEAuUxWWabOaDzRAIJK?=
 =?us-ascii?Q?tNBEvNPzDa39QpgvgcJ5fCj3NaNYz0UKUOwcv9TaonNdwxAGc7j6Q7x1XJL5?=
 =?us-ascii?Q?IU4nN3gkyc1isV1q2LrfA/oY7GqMLemS/zlfZi2Vfnj/4fOlmQVM2O3VlLlB?=
 =?us-ascii?Q?bsM4bGidk+lwOTOfnJV6e2vE8sFWyWr4KkWiroD2zdFaS8+3TeiQ1lGk5ICM?=
 =?us-ascii?Q?igkeOpR00GkJjSUuj4F+ruGb4OdyiZlkKo7g4xburOWnzzwBPmQtn0ohvG14?=
 =?us-ascii?Q?m5Ba2bGbNaUg/yIADgi4IU/lh99cdECQEN7xzN6ru5MyIpqR8e9g+8tz8qXd?=
 =?us-ascii?Q?DcFM17YuS8y91d+8IkSXfmWEwdVrHzsD/INVuHTChBTsF/7V5AcVpxBzswhI?=
 =?us-ascii?Q?GcIrOXokbKj5ItgJXFvFTatcSQ5YmI2M9/zHm3xrv9G2+AboDhcZmrq8vzoA?=
 =?us-ascii?Q?frkKCm/ITBqYZdes9XJdDoOn9qSvkUD3xw7/FLp/8j0fqn9To/cObd1N8vUc?=
 =?us-ascii?Q?UZDUj2s1Sm6sVNooXA7bZaYZiyfNl333qyWfqxDwbjGYiMIfEPLeRifeNaw2?=
 =?us-ascii?Q?08U8b/LszBfvt27Oq4TsIIMSgcjKMOmXDQfcTJNfgBcKjEdHbOSETELmrdCU?=
 =?us-ascii?Q?ICwnVL4+Cw0MFe7P8P+3JY1YM0SsWgjKg/ZXmHyR9ViYzw7YnIsl0blGE39x?=
 =?us-ascii?Q?z0UrEKnEgUXD2e9CynioscVscXZM6KSyVyLU4oAuimJNShFMfBzULEH6nj6J?=
 =?us-ascii?Q?x5OFPT6VOdRGGO5OlE4FNdbMr1EEH7E7qc2ylpE8iWW7rBENOl1VugUclfGL?=
 =?us-ascii?Q?7wm9ptv1Kgb63rXhPqg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffc5e5e-0d4b-49e1-2260-08d9e28c7cff
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 18:32:07.1904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUk3VBKRNHzOtXmR52HMiU75DMcfF3oY3yrEN2ExPdOtwdas5F6gu961u0jN8HTm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2940
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 27, 2022 at 03:37:41PM -0600, Bob Pearson wrote:
>  
>  struct rxe_mcg {
>  	struct rxe_pool_elem	elem;
> +	struct rb_node		node;
>  	struct rxe_dev		*rxe;
>  	struct list_head	qp_list;
>  	atomic_t		qp_num;
> @@ -397,6 +398,8 @@ struct rxe_dev {
>  	struct rxe_pool		mc_grp_pool;
>  
>  	spinlock_t		mcg_lock; /* guard multicast groups */

I think you should probably just use a mutex here and simplify
things..

Jason
