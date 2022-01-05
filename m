Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBCC485973
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 20:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243688AbiAETtN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 14:49:13 -0500
Received: from mail-dm6nam11on2075.outbound.protection.outlook.com ([40.107.223.75]:16224
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243684AbiAETst (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 14:48:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYjEWAe2onnyavIPSiPalIbCznwKhxJggtIEiCQjkcnatcaBNL2MM59GzbHBjsJaH2VFR+kaavpPY9rjyjSu3Bg2OM8r7ezybFmQforp0KJiMu1YYJ0UtUkJm18JtknTXz83MVBGKBLxtaJ044gDw5HIb8otA6SKlsun8m1LxLLW+HqTxf48SP+TvD4tMcD5ZUfeNRU3WELe4xp91KfBYteGVCQXD3FoRa6vsTSs8EoLDEtZgapKL1eCYWK7sMSkxzzaypdWw4K7zHLuH1kZC0avu0DurRMvn2lxxgz/CWwWuwjU0CM8AO9DDq8/STjiSsdb6nuToM6KU1CCpAMzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/Gb/ONMLKH+UL2JPHKxBi7PRC31+w3CCqlL9Rlobwo=;
 b=dhQy1cC/OifBiYdB6qTcxGfDq0mK2qGo7yWcf0qbawTILRoIgxKZbnGT8wz0VNlP6m0Df0TN1Xmpruma6C+1o+0KZlmDn7U+tsAfXTW5B6fMbmXzUf2YcC4eJKJ7P8tzbtbaI2a9tJwXdRVFXPI38/RSHDddpO8YIT8ESLeLBc0vdnGbqS1vfVvDp8cd0Htrvq73dr8lYHDCbkGGUb3j9EC69XD6unuqjh4QSnHcQTsk7ksDDo4DoUfIqdc79qe7trA5vQCr0RWWJt2oEHX2r/YBuPM5EPxgCrCcyKZrF4v9aV9oqJGZ+iHvESJ8cUQRpsIlIGWqE0rHPpEcuFRSXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/Gb/ONMLKH+UL2JPHKxBi7PRC31+w3CCqlL9Rlobwo=;
 b=AExutx169vcCozy0S8tmSiUvSGWv4f44ZeOSjowEaUiEdExrryLrTapIA/Th/gPa0PjbFkPGJdPAJs89Rp0RZCN3C3y8SJDI+zXgRK1V3M7NUfmIzJ1k/MlkLWaA6ikL4NLHXr0Jl/fpw3tAsAp5UYJcpA4U6EP1wKx0Bgrl19yX+Iv7h4j6cFpUbeDasoyqDJrWXqZKxUFnNupE+ZCME/dC9vFzSRqIxfLZFueo5zCcAS91AsZz4+g48qqGDZ7HdHh5nwuzh830yawt8M5ZmkIWRPFwyRjo910jEfgYlVUUa+/JLnC4T/DjrvD6c5AjZPMfG9Kogy5VnIQyMSgcGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5079.namprd12.prod.outlook.com (2603:10b6:208:31a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 5 Jan
 2022 19:48:47 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 19:48:47 +0000
Date:   Wed, 5 Jan 2022 15:48:44 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Leon Romanovsky <leon@kernel.org>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Weihang Li <liweihang@huawei.com>,
        Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA: use default_groups in kobj_type
Message-ID: <20220105194844.GA2872048@nvidia.com>
References: <20220103152259.531034-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103152259.531034-1-gregkh@linuxfoundation.org>
X-ClientProxiedBy: BYAPR11CA0070.namprd11.prod.outlook.com
 (2603:10b6:a03:80::47) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3dca8be-43ab-4401-7b80-08d9d0846322
X-MS-TrafficTypeDiagnostic: BL1PR12MB5079:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB507949AD06552BB8712BDE08C24B9@BL1PR12MB5079.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GCeAdyqLjUHEeiHDBR4RRuG+ou1YYv4PxfCAdZIEnOQPyVGZ+GmwXrAf8IxsbHd96U42/35WW6QcCMN1bQqUo30lDfPz9GIvYeuPRck6Us5rTHVqa0v3hABQfLBnJ9tddNSVJR0eTCL4/TOk+JFkP9vnjf3dXz8AkDFmAZO5pn2JPy3G/8Dp2Q2CB74iw15UlsCCP1OZ5gpPxBZJAF+GLWqD5GdWgapz3r03p/eHM+Eag1O7uJvS+wVlmir9sueWpQs8cS2lvK0mdjuoEcgzdHRmRbqr5xDCO8i9Iwz0JMda3Thl34ohjNY4nTTyIVcaJWSgDaHOTJlgpgEwbxM6X2B38GdumvFXzdHVG9+7VVTQJdewDqqlRSC0ShkGa+hJSO/NJMhhzZ3LfFg3EO9uMrkjQOb/lsgCMYx5Bd3eWDmVUOctsq9q8V56MpDeS2ZJj5BSDgPfQY8n78ggbUhQcSzkKgb6TkQO1Qn7dArA5uCfLd7WhvLuG0Rm7kZ/VzRgUaza6VrrZc12K6+Dp6LgVE17DA6f6OusaD/S8LNIGFwgKDM+m5CMOShuqjg9/C/a5MXMZq5GLdCidR3K0xUKWqA8uogqnG6P99guiY9bmr5AftufJbufXm1X1LgpZ+QKiOzJUMZLg6oY1jdZO/Jh0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(6916009)(1076003)(316002)(66946007)(33656002)(86362001)(508600001)(5660300002)(83380400001)(8936002)(8676002)(36756003)(38100700002)(6666004)(186003)(6506007)(4326008)(26005)(2906002)(6512007)(54906003)(66476007)(2616005)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bCJMUJxLfh2xQ2WzvUDKUgf2jnShAtI6bKpA7Yyb9dtl2QSCfcsPCHdRZu3C?=
 =?us-ascii?Q?zVY2vZyJ07txa0QsC7LY3dJLsDGxEuKv0iZGnA8xM2Lk7+ASUw5nbFVbaXGP?=
 =?us-ascii?Q?Oq9D5FX21Yg9r+XiwwaY4iqigjJjbC/JGIF89qTb967cMOcmihsm/v60TRBl?=
 =?us-ascii?Q?gjyskqiabt12SVvm8rrN5Byd+jgMjXSaIy41y5IjvDz0H32VyOB4FAX7x1y6?=
 =?us-ascii?Q?9/kJLf4wgiQV1OUOyhbcAM+2crTAiM8ylTFP1tx8lUHW1c5EdnWLXdMTaC34?=
 =?us-ascii?Q?y1mqm+/13kSz+EFKi8vSE8Fo6exyJncxCVleJfuYhCAgOZCGPCEQwHuM5ABt?=
 =?us-ascii?Q?ztdmHvtMqUVp03Mb3RmzqzX1U422a9fUCUNc9vBrJQ5Aw4hpmIQ/0yHSAzA0?=
 =?us-ascii?Q?6R563VBspAb0Ti5Z7YspyT598zsj1mIVp74VLg56pA8/Xo01MXVbk0deJs8z?=
 =?us-ascii?Q?YJ3X+NUwwFv8W/BsLfEo4BhVW8p/nUBnOAH52a/+XpDVILzYneNoBSthfUAq?=
 =?us-ascii?Q?88WrDxumDFn/JlJ3llGmbEOZI27ZJUENic1a8sU/Rs3hVwHGBTta5Rem2awK?=
 =?us-ascii?Q?U+bO6Q7YbPp0JyDgzoaxIK4jFfKGv1CTcEHmYRgJSscwq8ohk97RILgk/W/l?=
 =?us-ascii?Q?/vyLK6CKSXluohzQzX8b4VrulBZivylEwwLUQDlx+baVfFCzCxylZX4gbhWR?=
 =?us-ascii?Q?fBjR+NrHNbcBZ3rRPCMnpjcWW9PDPNDo8wOuToj5tR183LOC4jjf+Tv0bUys?=
 =?us-ascii?Q?pKXxJfueFVm4pJG4iLad96jI/j+jYESNraindssHX434dqRE/ZXEe3g3xxpn?=
 =?us-ascii?Q?/BJsoI8kCTTWfAmc8kDeCID5kXPqeEr7Zla6PTzCifBS1QbA2xN/zg7Izg3V?=
 =?us-ascii?Q?NvCZK3heSUDlaAcrhJ5mnLnYSRP53Av/lRzxOHrQ6p1mY3izGoet+LSdnYWW?=
 =?us-ascii?Q?5MnUkpBoKzGOKYpOdRgYgCufeClPWrly7TAOEjrf+R+X/N9Lmf6Z3pniJRGV?=
 =?us-ascii?Q?yw4RlqRF4zdFgRVU7l+ubFTpbw+E+5ujXfksX5Pbx00Z0ea+KiwoRze3sUxl?=
 =?us-ascii?Q?YsmwJRBOFZh0TdExZTKdLW5GzUd+YeMsTREV2jx8bIffehI/nvZjG55n1+5i?=
 =?us-ascii?Q?Js6kyZYJ8xjpQPdANZBIn9STJFk3qloQE/XlihICNS6Dqwpb3U7cm1+WsuLx?=
 =?us-ascii?Q?r0B1o30X/Om+5GZmZfg00BVPQxkHA9/phEEW+UXkzR100UoYo1sMnl6rkCAP?=
 =?us-ascii?Q?EOnHg1p8joJa9bQ1r855tLwMGZnZuNRHlM7yTrU0OP9gJX7IIh2AaVGIkclX?=
 =?us-ascii?Q?dQ74jhXd4kFODh53Q6Fda32dcCjO2HUWy1layM4Ynxg+/41ECj0wmes2Raat?=
 =?us-ascii?Q?wzknxzuDP6HTduPBtDOl6JANJ6TPM4VSz6iHbQkHmRpFTsAEEm8lBDrSSieK?=
 =?us-ascii?Q?X9ioRQHETLq1PnTPmlT9UXIVYLLKO9xNnYszpW91AgF2kvTsKcXt4V30FS5s?=
 =?us-ascii?Q?ZFEC8T7mLvayqzoZfBCfqqjfQisI5hJmRYvSEVFRC8U4AklZAxOll+jbp6Xo?=
 =?us-ascii?Q?19rw9r4+qtzGMXXDNTw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3dca8be-43ab-4401-7b80-08d9d0846322
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 19:48:47.0537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92WDYtVTGKX67z7OLmvz/oLibF/AKce6Px+j7DDgjHqojew6b7vjB7rHFO7uwlXe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5079
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 03, 2022 at 04:22:59PM +0100, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the IB code to use default_groups field which has been the
> preferred way since aa30f47cf666 ("kobject: Add support for default
> attribute groups to kobj_type") so that we can soon get rid of the
> obsolete default_attrs field.
> 
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Christian Benvenuti <benve@cisco.com>
> Cc: Nelson Escobar <neescoba@cisco.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Wenpeng Liang <liangwenpeng@huawei.com>
> Cc: Mark Zhang <markzhang@nvidia.com>
> Cc: Weihang Li <liweihang@huawei.com>
> Cc: Aharon Landau <aharonl@nvidia.com>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/sysfs.c              | 3 ++-
>  drivers/infiniband/hw/usnic/usnic_ib_sysfs.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
