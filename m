Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B2E4171DE
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Sep 2021 14:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343652AbhIXMaY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Sep 2021 08:30:24 -0400
Received: from mail-co1nam11on2079.outbound.protection.outlook.com ([40.107.220.79]:50336
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245135AbhIXMaR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Sep 2021 08:30:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTo5DFCRmtFYvB0bRMqKX5wRC5mqoXR0us1bToEkfn/w9tHaIOp0XwLOpUPg9XkmnDgEHgQrmZBcAvdULiOFgbW4ulEwPQXrz2LdqHegkbfqjFSsKHQaXa4Zbuw/nbRc/QdzQX4G/zZ7cdVbW0Dwa2s1Q63CCXidC5H2/z4n1uqg1kEIVxqB9ESykWFH41SnKoNUMErE9fK16mWht5hE932dhX9rO1oQaKolW4+5gNuDveLg3fmCevuGZT5O1DYAzSaum5QVuemirfmSTJiWuT6Ld2WkicVbWMgpqKk/feuOwokG+XOfP7ORxM95/Fgku+gqeXpM+oGvPid5v2njpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zvd3ul51I9fFXluuxeflKrlzqpIZCDmomqF6LKuoHbs=;
 b=POpq2V3IdCwEDDpzpUiA9Sy/AyXQgfn/L7XoFU8iz9/h+qSUl/IetlEcIK3HC4vMZsP2LVB/ZE6PXRj+VZShl5pLZFV7N4m8+q14CrjCGx5nuB5Xj9+MvPtmWAMor+gqAjfOy9vgDuTS4B+yVJQ/REY87AySG3isEZ3IrmGv1RoO9cAk4I5eW3RLQhmkP8IdEaa3Fe409DPVga0zp9V0eFHkPX+vATVzKIVS+MZQKUdhch/4QyocSVwZH1CnJNXtdIGoYwvsFG3zLMRcpzl6xNK858aPYvCacGjJss9CzkGgyP8JOY0XuH/AELdZzUyfCVcU6ki0ru/PuAW9T7CUxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvd3ul51I9fFXluuxeflKrlzqpIZCDmomqF6LKuoHbs=;
 b=cXamIowPP/PBfB3PbwZM1RHzrtFACP55Ln+fiIq+q/ADzV7MXmE4M7N7gjLDnW60s1mPg3u7u6udFXakDGhVCJNvXOiFtPBX30ML9Yj7NG3j0vrSXgbbZm2iBiQctzIMApJdibAIG431ooBR3/6/ZoLVRtiOmEk8sz1LW2Hr7DQdO/hEJ/MZptZ8RvLjj5k5eSlfyhshkUDMGF4J4f+YhoFrpDvQGimn/JnMNIljrbV/RJSgy44yBVvnYYkufd3mEBNdIaeB6gAE9rtaZAUdWKeDKOoZ8rgB4pyOepLu+gULaSdWBa5fChx0topNKeEO2m6mqnZd0skX+owdTG8Mlg==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5379.namprd12.prod.outlook.com (2603:10b6:208:317::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 12:28:43 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 12:28:43 +0000
Date:   Fri, 24 Sep 2021 09:28:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>, linux-rdma@vger.kernel.org
Cc:     Lang Cheng <chenglang@huawei.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Weihang Li <liweihang@huawei.com>
Subject: Re: [PATCH] RDMA/hns: Work around broken constant propogation in gcc
 8
Message-ID: <20210924122841.GA1194592@nvidia.com>
References: <0-v1-c773ecb137bc+11f-hns_gcc8_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-c773ecb137bc+11f-hns_gcc8_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR22CA0022.namprd22.prod.outlook.com
 (2603:10b6:208:238::27) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR22CA0022.namprd22.prod.outlook.com (2603:10b6:208:238::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 12:28:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mTkJl-0050mP-OY; Fri, 24 Sep 2021 09:28:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e95b15f4-6d31-463c-dca9-08d97f56d88a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5379:
X-Microsoft-Antispam-PRVS: <BL1PR12MB537993277F2E4E92686C9399C2A49@BL1PR12MB5379.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U98/dIGTiOOELdJ4OpobI/8fGl5AT544foJ+f4+xBjL/x8OK5gYi4CdLElkwDVZMPJmmwKGEyOFqqK1HizCRE2dglkEw9qBUAf6E3z6VJ38Fnm4e2k5cxW7i2e3Li3QmmtNnFQcZbk/A6acz0Fb/L+Icqm1s7NDfauadRoYPrroz7aYhy3M+I7fjw2GxrIteicudh23BFrmtYgeq0PV67y9EIBlKqsg03N4DHsqxS6AD+tahEnyeLYLcKWxnD6FYGK0VMP8tA0J/jeXRtuaQ6bFJNxqMMeH6lPSlJXclLoWEyvQjKPXNwPue4DMQ2Yq0tUsg7BAALNtDFKhT9IBAoxYDa6DrWCvbAPSR6lgk42jsiVQidWTY9cXyqVTmj94ln8+G2kyvP8WhXcV1kmFbhzrZ95bBnchpKmEMhkVmizaloNqzhEKKmP7uw2Ndfc1VHjEmRNEG4WSKH+gaDn4Jelysm6QbGA2hZUKDRMYqIZaqHmVbm/C6YPHT8LE4mBtZesRfvUimN2UBFGIevGcRqM+aWaJeeemFCX5eNcaHeBWxLfVDT9fr+D1EB6mqhBz0/Nz+uoztc7ubEmXsn5At3qmMljjaqeKMAC4ieY5WI2U87VP1Xssg7qGB/kuW0n0/7EJlDdLaAWWvU+bKCSrt9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(5660300002)(2906002)(83380400001)(54906003)(66476007)(1076003)(36756003)(86362001)(9786002)(9746002)(316002)(66946007)(508600001)(426003)(2616005)(40140700001)(4326008)(186003)(8676002)(33656002)(26005)(38100700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B96T+0kK1j7OAATrw+8sjUF5fi808uaSx7zrAl2NQOXhWjK4Qs/lV3VMjooe?=
 =?us-ascii?Q?MZn9UfyvXK4pDd/RrsJnNqmzZXMelYq8giwfWSCyKdCWJ6P3jw5s7+Cgm0jZ?=
 =?us-ascii?Q?/PCNuTFC1LMxSgSTrncr4hhNuMLm6k31srD5nDyiWcB0oOuN/RS4gKQZMpAY?=
 =?us-ascii?Q?4hec5FdVn+bztrZNyOGRbLRrw7DINKMJUro+etfF5w+ibp1Zb3ZRVvEIPP54?=
 =?us-ascii?Q?zKmFBJuPQbOz4gHEOq1uDkt3bRwk45Fu1MFKs3SLEWbFarmTPKl5W6Qzv+lt?=
 =?us-ascii?Q?0VMAc2nPIyYwDY8ooYYgq4GGESfRj+ovYLH4CJfwAmq520bt6WbEZ5Tc1BaS?=
 =?us-ascii?Q?DePId9hfYFEKciTX29gfryajitC2ZN+AEAiiFhTlxz2tsOzTjnpfTtAmV0YF?=
 =?us-ascii?Q?fAQM6lHALrQSHJAL/uP4ziID4TsyviWltxni72A5o3WzHRMLqCH3UBdjvJrk?=
 =?us-ascii?Q?hBsUEvfi7+FluBUO/JHr1HdOMOHd+kQt3soz2tRp4TX0Iv5bX+It5k/a+tJe?=
 =?us-ascii?Q?pfZ+V2JEdDCgCWsydP1ya4L/QBNfygwLqM+lwdh77Ct5ZcnQFWLcJSyNLeyV?=
 =?us-ascii?Q?LzprvMHH/fCSc5wlnpNFvSyheNoZQAVH8BCAxVeHqT8W1zCRgfgmDoyDzNa3?=
 =?us-ascii?Q?o24H5zQevrWgoIfHQw2TMMtBi/8qThJ38e7/SgdImKYiWvYXcHPYc0pP6RV2?=
 =?us-ascii?Q?Syqm3xTPYr5WZ/lha+jz5Z1ErB48kas5mLKZ3BzaFNL0WAI9c0sssa3aMTn0?=
 =?us-ascii?Q?zeeu7JVNYMGQLHzQ0UGGyj5Om8Hkm9L7MEb2mAaKyyBYB932uXbePxm2xGjd?=
 =?us-ascii?Q?jzl/zlfzF6CK/V+K8WHPbbrLeci+2sBpsL+9zPnpNONVMJ+4XRB28MO2Ab0X?=
 =?us-ascii?Q?23SFmuBxOPJcUfR2JHdo51A3y2RedU6UN0s4TT3RuoB2+u4xMF3RQuhiUeHP?=
 =?us-ascii?Q?H6Y/HL0T0hJ3b2JNRbW9CNXzqiSbClFtTOVtz9x7EefEiY6cvvqiw12P9ta4?=
 =?us-ascii?Q?uFiobGTee3i+0GjNJ8OgNF/plRKY8zM2/sfVKC0SSD2QsTBY1VQfoMK+5FEM?=
 =?us-ascii?Q?/cOBo4X/sLPH0EqDbDDd/ggmrp0s2Wz3m93U6GRXh59rBPNTBxfjrnEe4zjC?=
 =?us-ascii?Q?2gZAtwFEtg8m+LYT35oLGptKX+CGTpt9QAOcUgsDCv548sKU9XyQwhp1JRka?=
 =?us-ascii?Q?WUBaFPcmzdrct2ySz3TBgVYmrlG91v8doFt1gtn1Ac9TFe1HIHi3VcciN08T?=
 =?us-ascii?Q?FPadf24lAChYFfND03Fpo5FtmNYLQ2SIBh/KYDF12rZOYJQlyoV6sjpYjakQ?=
 =?us-ascii?Q?OEOgbH0BmGQ0EevrdxGioT2E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95b15f4-6d31-463c-dca9-08d97f56d88a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 12:28:42.9556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OMz32j5dI4zWKT4t6zbtAfUkO2cn82h5cPGJzboFUicZtOiKQ3QMuHQ0mByz5Bp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5379
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 16, 2021 at 12:05:28PM -0300, Jason Gunthorpe wrote:
> gcc 8.3 and 5.4 throw this:
> 
> In function 'modify_qp_init_to_rtr',
> ././include/linux/compiler_types.h:322:38: error: call to '__compiletime_assert_1859' declared with attribute error: FIELD_PREP: value too large for the field
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> [..]
> drivers/infiniband/hw/hns/hns_roce_common.h:91:52: note: in expansion of macro 'FIELD_PREP'
>    *((__le32 *)ptr + (field_h) / 32) |= cpu_to_le32(FIELD_PREP(   \
>                                                     ^~~~~~~~~~
> drivers/infiniband/hw/hns/hns_roce_common.h:95:39: note: in expansion of macro '_hr_reg_write'
>  #define hr_reg_write(ptr, field, val) _hr_reg_write(ptr, field, val)
>                                        ^~~~~~~~~~~~~
> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:4412:2: note: in expansion of macro 'hr_reg_write'
>   hr_reg_write(context, QPC_LP_PKTN_INI, lp_pktn_ini);
> 
> Because gcc has miscalculated the constantness of lp_pktn_ini:
> 
> 	mtu = ib_mtu_enum_to_int(ib_mtu);
> 	if (WARN_ON(mtu < 0)) [..]
> 	lp_pktn_ini = ilog2(MAX_LP_MSG_LEN / mtu);
> 
> Since mtu is limited to {256,512,1024,2048,4096} lp_pktn_ini is between 4
> and 8 which is compatible with the 4 bit field in the FIELD_PREP.
> 
> Work around this broken compiler by adding a 'can never be true'
> constraint on lp_pktn_ini's value which clears out the problem.
> 
> Fixes: f0cb411aad23 ("RDMA/hns: Use new interface to modify QP context")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Applied to for-rc

Jason
