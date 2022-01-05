Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B39D4859B6
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 21:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243785AbiAEUAV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 15:00:21 -0500
Received: from mail-dm6nam12on2047.outbound.protection.outlook.com ([40.107.243.47]:27562
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243779AbiAEUAU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 15:00:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiRsghHbs094SQpcMamFoQbw1LElzOzG2UG58tQqB11GUx7Bj4pQL1caPTsIZ2vuoDxAeXrjqtat+b47L3stqz41vrik23yx9lXQMIy/F7MW0EqV5ZZRawDmxSFtXs4W4n94jxo8WMb7uD64/9whPp9sS6Yp+i/gB63oEaoAthllpFpNawxF+DZWwQdJB6lUSVDjUfo0ek2hxn8XtTEEyc/Zsmq5fgrtkaR1ZoIOKl/10h71b1JT362iIuQvNdvF1CHN1ldDH/VCPXtEQO+ARyrlzybMDrFE58T/dusEK5V4S2uZixYhtvD6zhogFAUMMEe1jjCF5Tsh2NxvJfq4kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5F9+YoGqjlhSo5jrtAhfbM4OZpsHZznuTyTzCwNG36I=;
 b=ejGNCimizP4SXk6OR+cjRrmaY2j3A/s0Vaj0vXB4d/Db2Vq9JSqnMXlBtVD7c4PNMZjUy00YQPNxiFV0wu3c7RTBRf4nRSWwFfB2jaRzeQqj+ttNPNIyuApb4znB1U5lHGDksBHgYAzKbI2yh8gL8yYZSoJj69FouMb/6UF+fkjIt8gtf6xX8uPvEZ4j1Df0O5tCCiCQlCATVXlcIa6JsyLxoEYcPIG1kRvlEkoDnG+wx80TY/27vei0XBQcGTHEqrmaNoaMlwz+OwFBIIHdHKbKMuQXh7zJ9piNeSAHlLhWPJYbCchAf8lHmD/sbqJPjxYDthkfXo2ItUa6fC+i3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5F9+YoGqjlhSo5jrtAhfbM4OZpsHZznuTyTzCwNG36I=;
 b=sl9+QdQC8oIros/paL1p9wNcnfT/y5iH7IqbMHPvvxoLFDuRkU63ME+gbqvIIihclHOBMX+Z2ibwQMIcd4gU1Fyk1pZ47xwh1X71JClqV1AwBLE3eQ3otvyXov3pOmYMWAgvZUvYeTvh7PDnmmY8oQvVGCnb+sYhoKwTu5wP1Jovs5Ns46PXr0+hoqWA5t1Fm/aZgJ9WwmqpvgPY+zxaJNYsyhm14zPK99U13tBU7YMpBCbfDGh+5X4K7bKM6I1kdhKaikUYT2EAkXiQSH2w3CheW0t2QOc+sIep5+mYIKJ4ifebr0sgUyi+7ejX8SCCTfZWv7NnCHMYZ05bruhp6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5207.namprd12.prod.outlook.com (2603:10b6:208:318::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 20:00:18 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 20:00:18 +0000
Date:   Wed, 5 Jan 2022 16:00:16 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH for-next] RDMA/cxgb4: Set queue pair state when being
 queried
Message-ID: <20220105200016.GB2881622@nvidia.com>
References: <20211220152530.60399-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220152530.60399-1-kamalheib1@gmail.com>
X-ClientProxiedBy: YTOPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da74a3c1-ec5c-4b7e-4da3-08d9d085ff65
X-MS-TrafficTypeDiagnostic: BL1PR12MB5207:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB52078ECEBF92FBCDABE47044C24B9@BL1PR12MB5207.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KvS/8G4c4HInE5N1vXO2jmHt45TC88jKfPiF/NvtiYrD6LQPuPSEKYNUww9gzuw6TyQZQZrqUTzQB7olCMR/BDKPWtWwGiG4sfq8BWNwRXGSgEYAHTpNfx25Iyj4sN7gF3hoZkQnS/lSfc6rY0q7Itkinn4FlsGBbjtaDyOfHn+Mu49PuDzAvEtYduiaAopUSYuNlloHErJ6TeTB9PPfeQJYhnu79jVuC28zkq6EGMjcbPK2EwVc4pBZBXdep+7hKo7W5nmO7uhZhlNwaYwEaJN/jWTCPmRMdMkpDLc4Gu3KGqfG7Po0fnVsmofh1IiLjNNCtNmTvKvI01wZNfbMItMMd6QSlCjGx28TIsrD+40WlYul0qsLpbXIkh4frfsVMn805ndvUqoEVK04V7f0Bpm0bgwc4YioPCfHAVM/hzTtU5QafTc4p1ss90CGWvtE15cu1ZNC8VFX22oe6hyB2WcBLQ+YaRiCrs20ZGbrbTKZbLMRgMa9XE3K8dIE8/CtndJnRZHqADutAj7RhrqGic+W1wQ29wrMllAsQ8wlhrLFaatStOZUB5rgfdZuZQyZqwmanuGieUVgTc2eQechNzVvCBlkJHdXgJ6i6y6gbYrH7XZ4O7guQG3S7sDpjW/wayL/QKzTvMwJxI2SzRSvcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(6506007)(186003)(26005)(33656002)(4744005)(508600001)(8936002)(8676002)(2906002)(86362001)(5660300002)(4326008)(66556008)(66476007)(66946007)(2616005)(6512007)(1076003)(6486002)(38100700002)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cSaicLqOqN8cW77REJV9FrLAAbu7MZdyoDY1QR2R9LJz6Rt67eszWnAhiINK?=
 =?us-ascii?Q?bVnVaCd0nTofuegBATY3jbwjg0CETfhShFx/jFsaAIiDQMVTPX1V1j4z1LUV?=
 =?us-ascii?Q?C+Q3lEDBTDBOr2HFiAnGyK7ztPL3jRCc1OXk4414lIGpLEgJ6uMOuuutGwkC?=
 =?us-ascii?Q?fM7a4Ig6Qu2dE3AfxTsRXBFNxr4bPSfP/p01miUnypVR8PTK0kZMR6Tn0Wef?=
 =?us-ascii?Q?vC08B7+eaRXPeOwXDGgBIhAREjeuU58ZWLxYjmgJeA8QfaMFJmhwHHlvl4Nl?=
 =?us-ascii?Q?hqO6FZTdU022ScgX/A+spdbp69RhpRHfmQBGFLv1oDB7aur/fH08pHymy4fK?=
 =?us-ascii?Q?bkuvyyGKGffciDTJAaY4W76AyLLRo2/EmIrDwfv9BWJO12SQDwFpQafU6ZnS?=
 =?us-ascii?Q?cv+vwdEV+vW5sj1uOEAoQnPcbZx69YR7uJ1hxmTPQ/n63gRKqNGO2B8COSt2?=
 =?us-ascii?Q?9B0FVE/mhE+t+W7Jv1nXrZVf3yTJkJw3IW0owsekQeVaD0gNRvxs0u3iIvQt?=
 =?us-ascii?Q?Mecs/0CcBq4lHZuNqt+ItLiqylxWsvTUnBilR1AgOarcUlCfPaf8W3sBiUk4?=
 =?us-ascii?Q?Ji9JtEaRsLHf5RkCO1EI3I2w4XQ94wHxOXzoPWJLFWCe2B3DQjMFNej1FLxz?=
 =?us-ascii?Q?fp9sbU5njFsNvuqtktWZqg/yOZOUT+7UcfEXxc3e1HT9R2gumzBgA0a/4Clq?=
 =?us-ascii?Q?4+cgi1EJQGueNPKMAKsHMkuVDqe4INpRn6mYSdMdiReFZrL920VPXyRTHhDI?=
 =?us-ascii?Q?JChy17oGm0PNHTtSaUNyAdDk2feDuDcUz4KRMZ6ZS4zM/h+s6qnlmG7PcHOO?=
 =?us-ascii?Q?ti9lt0TN/EwTBpUqdRDvTE5xgBSD2CJ3e7RmSePZUsX7L20/lVei5uiR8ysW?=
 =?us-ascii?Q?ukfCOjgd0s3GphYl3dEWWAD0PW67+DUuKyYG8V/sxhekip8F4UHdtA3lRjWn?=
 =?us-ascii?Q?chnrccYzpcOmutwr1rujBC9tQiBxfefMusFjRGCvs5/hkmj1ys66juMoR4QJ?=
 =?us-ascii?Q?qbYYqcERQ1ighArOs1Fievf0I9c8vhB/n+oHZqUA2YFQSMJNlfKZ2W60L4Q7?=
 =?us-ascii?Q?XQybYwOpL5XIH9X3W5efmKKFo9miKeVNrtHu4Y3sA/8SFBCXVE9uXJqUNRep?=
 =?us-ascii?Q?wDPJ74I/gYxddax9cwOcULTqOl942kIizmat+cUMOE0Uj5oTl7UujPY1tDA1?=
 =?us-ascii?Q?14AK+PyAjPdhuxs8z2RmpgdMASQUwlEF942UJcvyq9Hml9IsbuxOTpIkJlTb?=
 =?us-ascii?Q?E3VT7Q+MDe5ySNA9CDQNsbscl8kMS1RATDewJSTCYlNvsdcYLxvgUfaZcRe0?=
 =?us-ascii?Q?rI8sEZRtyrPxVJh7eC+zLV5s17jLsaM2QVxvJNLe+dZh6/y5amcMUe+/kT9l?=
 =?us-ascii?Q?JCfT1/+CAHiKFMr2oCVi7zCNydjofHERsvLpdESt9udUNIhE+ioACjgLEBYn?=
 =?us-ascii?Q?gp9Q+unLJn7g2UTqFJU730X5ogmmDZXO3Pi1y6Ok7E6uXzmvib1QTNFvNx96?=
 =?us-ascii?Q?QkvLZQ7rxuRNmrJ6zq9q63XDUcmLOJifSs0ZrqdkJBfe5Ewa7yoeDL71oVOd?=
 =?us-ascii?Q?bkATqF746yUnuy96VTM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da74a3c1-ec5c-4b7e-4da3-08d9d085ff65
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 20:00:18.5423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cRXyYQbMNjp70NiYlI862uXf+6/SpKHvdWIr6p/IDWtFkiUohncHC2kV7EfvSqW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5207
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 20, 2021 at 05:25:30PM +0200, Kamal Heib wrote:
> The API for ib_query_qp requires the driver to set
> cur_qp_state on return, add the missing set.
> 
> Fixes: 67bbc05512d8 ("RDMA/cxgb4: Add query_qp support")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/cxgb4/qp.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-next, thanks

Jason
