Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA30485A3A
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 21:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244224AbiAEUsI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 15:48:08 -0500
Received: from mail-bn7nam10on2047.outbound.protection.outlook.com ([40.107.92.47]:60513
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244235AbiAEUru (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 15:47:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqPCD6384jduK2/Vep/fKTVaR+i709Qb5/jtDrVLBuDb+PGBOtuLU7uX1L9qbH58gwAsYEKLDD7/FufuMP/dAwMJz8StYTuhF/iuj5zK64M7I2v60tRo+ve1xV28zZA1+nHnEH2Wzpb0X3cg1e5LreA6DK+P/HoqUndJq2FQ0A9l529Eyo4954cS2Ajvqp8eF50TT5GHQlkG2VhN/PHZL2yFTWmHWgJaLzp/z1heZi67D6MQl56EpHuHDL7Ov7wRHrcpU4Hxr8JKUshARgLgq+gu2IMoaMWqO4stYy0bYk3UvabL5L47sQay4khNK0I3Bam0E+tyGqDNJ7YIaYagVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mixSQ0GWTykY8sgk12EFcmKIKznoqC27gPpyuMGN2z4=;
 b=dDvz68wLC2P4HQNZFUf7qlGMfgj02DmCpZ75FBb2wZnctChcKLnYipiCD3trsJbxtt0UMJv9wDwUV5OnrrADFv1tjR5F5DFoj2a6u6NpuyUw9f30pDpbRSmuwzNC8eB/ioR/hq14gDyWxk2/11eW2+pMyllTJgp7g/Rrlv7px0zJNvDFTyJQp63sstVEC2SZt+4aq0TrRW/Mac3AawCJHTvbVoYtgze8DomIIjvQr4sW1lNdyD7F4+RW5KQ6SbAPjrQy2A4pgwoqdK0tNFXEuTCsQAk2L9cSw7diCTxnfGlzdXDjt4Q9AMPbT9QGzgRugyQx/60uJxelnI+uiQh7Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mixSQ0GWTykY8sgk12EFcmKIKznoqC27gPpyuMGN2z4=;
 b=rHd9pu7JITzNeiV1nW5SczvUnWOCIk7JIHh0q4deUsy89K8PfQd/ROhuJt0NUZTl1EpKH8jP/hwLQapcL1FrEFF0zVTLIT0eqDF3H1Cp1nOJXzooMO+mDQW5dF+OYPv7afIv0m34s9wy19jjwWpdObWCijTHaNPTKDUXPYcwC+6XFi7+rv9w/0jL6xkf0c6HScAE7cpTNoOUq6HyB+Pj40tzDWbla2mCUDdhHD6GTdN1afPoDroZGMqLIjXyK8VsblKn9x0JmSY24mNSCdMVpuHv5uKKvYVgSvk9OaSuX6sFX48xVef1EtEDftg+1irfMN8xNrwqOs9zIHFMWirTpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5141.namprd12.prod.outlook.com (2603:10b6:208:309::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 5 Jan
 2022 20:47:49 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 20:47:48 +0000
Date:   Wed, 5 Jan 2022 16:47:42 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Maher Sanalla <msanalla@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next] IB/mlx5: Expose NDR speed through MAD
Message-ID: <20220105204742.GA2896982@nvidia.com>
References: <a2ab630d2a634547db9b581faa9d65da2edb9d05.1639554831.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2ab630d2a634547db9b581faa9d65da2edb9d05.1639554831.git.leonro@nvidia.com>
X-ClientProxiedBy: YT3PR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::18) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce286f7f-83c9-45c1-37c5-08d9d08ca25e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5141:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB51413F8E81A9BA57CAB4DB1EC24B9@BL1PR12MB5141.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:459;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IlMkiGd95VDZ1eLpAa7ngSkVos42HJNkUlXiXuC7KaD7THD1opjiM54bxndQgNcboRzrFQNJ47d3Ll1rCzEnXFPyqHgiUhNiA+SI6va/+OAg7vaVxb6qu06TGOVjq43qHeXpc8Vho1lRhIdb3f6WE6mQKndH0Faf0RFHkbVrT9rMEoVPAfzo9Ssaty2KU18ryVBGQNiJieUncwZrEd7EMBkb7vsHCvlTWUYYzZDyxYxguv/Q8BOTQz9ZDZCmtjyAgr06GCoOMckfhC4fNkWd8eL0Cl8TrOGZSpbvFX+r7K3pXe5Cq/8az5XpTvAsvaYkpA1vvhq4BW0SL0PUpHmfPSYYRzc4Zpza2lJ5tUUWunaBcnDKSdxJJNsGPqSppAlHQjH0eYL+RGE4RRCJNN/sHTkueFU8FmRLiFTvUCREwo2y6A3Uh+mBRrvZxXgSD7mXiy7Vz2idHx/mwxpEZ2DBzmXeg2yjwEjzkbxSApRplq5PZpgIlTRdk+EnIwhG7xaJbnjcIY68RiMVwWxHmjXqKh9bsc7idzZrzFJISLDZdwDFiYvI7H0IDSMP89naWHYnO9iY+Lm6xCI7ynsE9uRjamkVML6+7WKSqGaBLXH6AbVx3st+e16BVcP2ZnHAiGhLGRrQ/1Ar1mTY3JY75wCMFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(6666004)(4744005)(54906003)(6486002)(8676002)(107886003)(33656002)(66946007)(66556008)(6506007)(508600001)(66476007)(4326008)(38100700002)(2906002)(36756003)(186003)(6916009)(86362001)(2616005)(8936002)(6512007)(5660300002)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+lPC9jBb604erTrY68DOftH9HzjgSy5N7qO2BVRrpHgxPN1pIL+uV/sXGeeC?=
 =?us-ascii?Q?WtWB6WeCVF4by0YTryVEUxHsNQjtAc8v/fcikC7B83VMYYFg0uoLLNZL4jVI?=
 =?us-ascii?Q?LsvflmibDqVObLJTbibIs2C0vaLr8YuvL4FXxVE2y725j9I7ae+fir9VKyjr?=
 =?us-ascii?Q?C5abaa0FBBEGl9KVKydGUtJCwloUi+quIavw1GysHvQEGbJ+1w4uCb3818x6?=
 =?us-ascii?Q?hTAwj1LncPXFM0zm9vN7KQHIKcfChnBeFzWWk5OZ5D9oFCrm7U/acUS7qtEg?=
 =?us-ascii?Q?FrmMjx1QEvIyZOVZLwEf8GTohkzsAJaYFITupRazasMUHTSfMWXesv8pZiJr?=
 =?us-ascii?Q?9Ma5ywbh3dTyGV15iDrPqbj0L1fBwrL9mlruvYl+f8gulbnS/qhXR5SYBGoj?=
 =?us-ascii?Q?jQa8M5OyM07V6mQDTO1UoHya0+pqOf/cObE8Em+zz8t5yPpxHqigVVEJlnRg?=
 =?us-ascii?Q?3p2eOXyLyjw9MC/yqlooBztu5ve+RRpiBoEtzVmfZXsMMlTwkwd09goIIZuI?=
 =?us-ascii?Q?dQCQtoyqQrdMfNN9rGBdmhwW7N1DvfvROL6xqa/Z+4aKIcut2202186UCldY?=
 =?us-ascii?Q?oAc+ngYr7eJNqCqliTMTtRBU/dLD1JcPmH1U+Wyv9Jg99z90meU9K2Aonkus?=
 =?us-ascii?Q?IeGKjT4S5WhtSnPkDPiig7MKLKoGsugXbPiSjXSFONe7T+LrCWN1dMIbe/m/?=
 =?us-ascii?Q?NB0RGa5/JRyBAMmZCUads90gApHgYRgUrSsT+BBEWeMHrree2t/hHf2hyKM+?=
 =?us-ascii?Q?UtnrolEKCtVam/HGdr0hJJnX2oVXiWmXocgKpliAUhzl3IWW7+ZQKG0IaWp+?=
 =?us-ascii?Q?6BGOgVEvFW9ZQeB4A56TD9Ly8LS8l0V8bdgoFKWOiAEydFZ8Xbyq4olUBqHK?=
 =?us-ascii?Q?Sb6MNXlOXpNcO2fUyTmABRHlcdaLMTTg2ug8XRH4eAWrTt6kwIeBSvsBv26T?=
 =?us-ascii?Q?+ccjest4LXuKEAyQTM0UgEt+o7vnnNKlJXQoDzUKDMUWJNLOFXfgEzJMkRj/?=
 =?us-ascii?Q?k0MowaTf9/1n+WXXAgFjDKGgBEsw9NLJaVt5lh52KQZXeviFyHjnEaYhsRtc?=
 =?us-ascii?Q?aH0kdBTJMvUkeLhvnu74qaqdmkWowwTygeh5SeKQtlSch2wQqQmj5smbnruv?=
 =?us-ascii?Q?uHSujivupNzyTcyvJ9h2W4Wu5kQJ5INgyFsScfUBK1YEw989FhuLozR/5Nd7?=
 =?us-ascii?Q?e+vMpvlntnJNeK9vzfmbSzZmI7Sxs/X8llnVy4KpqehQZTlx+UXS3eYkjy5e?=
 =?us-ascii?Q?OtDx0scwFD0OWOeMyhZ37sUkThab8L6iHwbplb4BvQ1IDBxdbpJU8uvYfxxa?=
 =?us-ascii?Q?IZLI+GOgS0HVcgvNjAlYtaPQlwmkLFitud2NbJGOrpawsMJ7R5vEZX/w4SXU?=
 =?us-ascii?Q?tZd6I6j/lFhUAixiR+5kWgGUL99vc9ZgYKXnDpfwInDc0ZdZwROUlpJWBRmk?=
 =?us-ascii?Q?AmDtvlw6gLaAvx98deGoiwuWiFAuY9EQw21aEoLKV3ORTsNEPZ7RFuL1SCdZ?=
 =?us-ascii?Q?CpOxU8oYoar8WYvwsfSO1hIlJYVIu+EbpPLeY2jOn8rnD52TvFc/ci7Ny3gc?=
 =?us-ascii?Q?BBK9dSA8iBsl/30weMw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce286f7f-83c9-45c1-37c5-08d9d08ca25e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 20:47:48.9436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Os2tprKSIDWQ/9aLloJeqpU+LcllXMAqoAx107mtRbjXdzrufcSEUCP8OajgJIj1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5141
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 15, 2021 at 09:54:31AM +0200, Leon Romanovsky wrote:
> From: Maher Sanalla <msanalla@nvidia.com>
> 
> Under MAD query port, Report NDR speed when NDR is supported
> in the port capability mask.
> 
> Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
> Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mad.c | 5 +++++
>  include/rdma/ib_mad.h            | 1 +
>  2 files changed, 6 insertions(+)

Applied to for-next, thanks

Jason
