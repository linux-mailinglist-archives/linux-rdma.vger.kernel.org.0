Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BB53B1FEA
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 19:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhFWR4W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Jun 2021 13:56:22 -0400
Received: from mail-bn8nam12on2085.outbound.protection.outlook.com ([40.107.237.85]:3808
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229881AbhFWR4V (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Jun 2021 13:56:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxPF7oIlfhsAmcU6XxUzZUdKP8gDD4cSjeXrltcmMlgp5HiacAidh6I0TbeT0/l0z2tA9KcZYfM8JTbHpeZwNBLoXAEaX+X5tSl3C8LLdjCZzq3yKxaPniukU2+yafJUoroW/vSxK8IaH69FT68zViD+ROqnDidn9eMs72QQCsHHbNsIDJ9AI53wgJUfH7dMVQ6QcEhzBLAY5wzH9U2PktgVMECssJPcGe2f/mYA5RbZkAJbzfsEtpZmWNZKt9z1BWzc9t913zrQbBk68QvDy9j6cijKIBbOglS4gN5J7NBXWeKGShDyP0Mtp/SKJqY30U4m8U/hNaMiXznZ53GRcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKnO7ofwHAL8gPmZ4WQaOCWrzAF5dhCXeUmq1Es3FIk=;
 b=WxBDg/AZnjLCAtI+yMnS6JsCtAjXBcLzLEmZK5+cp8L1jJ9JwC9dIek8U6UUJxoi8Z01mB9e0L2acClBa2PZl44dx8sLyqt3RLfqtVdlrxWtSw7hTEmQ0bpDggg7LHHeRRc4zVEknlBcOaO8b/uFy2raJt5lDrV+NpTRIbs5vMkQax+PefczObHaZyqPXTDTx/QPQzS9ZAfXm/1Ez6w0n28NwUAt+Cgdmb8lc65eX8QpIAlXpuw6xg13ifkHEZOQaPS2h7L+Vil3mVFeo6g8rs9aP3NHVJxvlm3EfXso9MKx1u5RZtqXV1cCJX7QDtSZkyT1EFndrd1vo7sDD45Thg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKnO7ofwHAL8gPmZ4WQaOCWrzAF5dhCXeUmq1Es3FIk=;
 b=dL38LVMVG6Q98sp1GWggVe2lmPsNtxb6YSICa3eq6FDg4AZgHyXbik3v5CM8/xxwlC0BRZK3sY+4mVx2Hihw7x/6VVnI7ggSoWNDuOCFlXwibXssrREtwyE3E1I0RB3VixueeuTQAPiAQ70fY/+SydMxKz1tzpUkT8TjyIBpNP6JEbspxPVhDF1j/BqA70ZfipnVM5iOswkVOgbJDWeTY9W6QGTrNE1zI23XRMhsGtCMzmm0fVy76+OYgmUzN/NuxewRp3E5Q+KlbWqxKjeh5ISr4601ZVid0Gv/xM9rPZR+1EPsCzByaaXvJBLJBvkhlCjhazxJVD+yOXrp+1zrFw==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5318.namprd12.prod.outlook.com (2603:10b6:208:31d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 17:54:02 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.019; Wed, 23 Jun 2021
 17:54:02 +0000
Date:   Wed, 23 Jun 2021 14:54:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Fix incorrect vlan enable bit in QPC
Message-ID: <20210623175401.GB2800751@nvidia.com>
References: <1624438201-11915-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624438201-11915-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0094.namprd02.prod.outlook.com
 (2603:10b6:208:51::35) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0094.namprd02.prod.outlook.com (2603:10b6:208:51::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23 via Frontend Transport; Wed, 23 Jun 2021 17:54:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lw74b-00Bkch-Oz; Wed, 23 Jun 2021 14:54:01 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afd566d4-21ae-456d-b3b0-08d9366fe2c5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5318:
X-Microsoft-Antispam-PRVS: <BL1PR12MB531859447C134CDD606C90BEC2089@BL1PR12MB5318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Uxghvymxl1u2jJqh7aQA8BXVfaRQ3T0dsfnfTPV9lVBJib9jH12n8AYq6kdaeZkknB5vn2nceetQWH8rxgMIEvGIGuaQBMKQOdRdH/yUHiHkPJz9sCVPr2VpFfqTMtEkW1h9TIPA1SnvTNrB7ltsn+Et9ymsGzBC5MDFTnpAgPBpPUAE31tBXRnsuUIH61I7Mc0api3OuWiL5FAJxbfb7ER6segNzWUKd9hJ/1CV7ey3x0P/dbr2sor8HkmZrpYZBh9CY6RexI2+L5+HsWv4ZA5gG0Fk7VFRtjLGdsGlBeOzWW7K+wlpkQuLv2YicHxyBKKCQqwctdrKdqvv0l2iuVwu5IW/w2w9IrIYpu6i6gH07N5uNY9m1jYDm2ygK3wjCkk2owvRPicx25Qag9EfMfnacqfrdg5xK4pKC3NB5bXZVnldsmISyzH2cmx2H/2NHckTE9oLN/IDKHuvc/zK6jBjY/YXhdaSkVyqY/4IwZBrV62sxm6wGNVR+QTW6CWqD4F3MzYd0pNs+q41300vDr8LpqtFAOF5G2nC+DE0UPO8/6MmXrJVZl9aAwaNqBkuBU8r9dgpfdAueHKRsrX7FwCrGq/rhh/AjfyS2rf36ZhezFxZ+iDe4YiOQ8xsPJy36YTJ+Ow+KohpwyG6QHJHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(5660300002)(8936002)(8676002)(66946007)(66556008)(66476007)(4744005)(86362001)(36756003)(9746002)(478600001)(6916009)(9786002)(83380400001)(426003)(2616005)(186003)(26005)(316002)(4326008)(2906002)(1076003)(38100700002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iuU56aMJTXJpy6/Jqmc94zPrzkm/S7tdyXGbxQtK6yzZQdAeW4fVDB9lMJpZ?=
 =?us-ascii?Q?ktC4M6CPqY1t9ycXRhQQ/J5Z7dlsq5Rcyh2J+q8ECZqSTGC1GVmigjhTb/qw?=
 =?us-ascii?Q?LbXhh6F5OQxNG+qU9z7iAIZMtGx6LD9wrA+eGR92FeK460G3mddpLyvvVeeu?=
 =?us-ascii?Q?zzN4c/hUaSKZSPZ/nY/uNHNmWVB2lWsiF3VlN9BXK9W3dJB0KuY0vw6hMmE+?=
 =?us-ascii?Q?K7NQK8ABqIVjzxYm0bDWybYb/P5zJtGMjZVvz3G7GD3KBt3Ih7NnElX4He9g?=
 =?us-ascii?Q?A9Bfm7AjvWUDxgbXms2zAL9sDucCKalozUxQfqmn/+7BeVsZeha7N1ouklIP?=
 =?us-ascii?Q?zqDXYKI+O5VFAwJmJroeAQ3Yp5u6BMgM1i2vBA0LeRlxoJDDewrrNZaBAnaz?=
 =?us-ascii?Q?jjrxVRjQ6eG5q2NEApig1GJuieZ18qR1D/ppSTAu0IZNN3qDWjDTpFoE7fr5?=
 =?us-ascii?Q?bqIwom+DzXJ+b8q/ZgcuzRKHIa4hc06D7lFLa5kuWRVx+jO1Fcgoxd6pJw+Z?=
 =?us-ascii?Q?FSVtSntpRDil8hcPNMelMT6aiO21G79ZPwcDnO5IlOTnEADDYXkDSkw99Niz?=
 =?us-ascii?Q?Wuw0ydPDAv+p92eZlQz4uGUK1xZAfTgbi/mq5B2lHuTomEHiSQ5AxRRFHMo2?=
 =?us-ascii?Q?D9ughfC0cBD6aSlUmAeyr6V5jKEHsKSBQKUl2qvebsG+uWiNBwdNJykSJhow?=
 =?us-ascii?Q?eiGARJActgnviWtiOM1PcOteSprxlplCBSqarZqHTLhfpjSr8AT3WWV36Ddu?=
 =?us-ascii?Q?ryrYPdaK890YAszYrIaM7I+dUMgD3MCOhbigV03bDkIM0VZymSCK2Z/D2F56?=
 =?us-ascii?Q?yHGFidUv5cBkMjO/sKQo3hrJ+RhSN6THG92D4E6wtqO0ZenNwcE2TMsoAhL7?=
 =?us-ascii?Q?2nM3SQIN5ccdzqsBKvs0WdL05rGUCl3xyX30A9kQIUZ0biaKKpMtJBcpxamf?=
 =?us-ascii?Q?k33H43QSjWV6xEjIRlfAX90YIJBHhY9hLTVJBknXbfrMPFd/Xr0Z70pJAUyE?=
 =?us-ascii?Q?HnFN78bnp/NK9hyPRIe2OxgSiVWXXOlyyezw/EQtL203oOlxIqH4w61GTCix?=
 =?us-ascii?Q?kKkamtbkCnAFHaKjs/v3Mz4bmSm29HIvmNSvNGy7+tf/vG44LQxB073GNWyn?=
 =?us-ascii?Q?NgsPx+lTH390Tkf90VEoXJRtuEVFh+JMhlNqkZqQQhFXiBP/tzbZ8V2cCNPV?=
 =?us-ascii?Q?0ijWtolrQmctt+85sko2qWLcA/sBZKwjxgfXMDOx+pst/W/9p8Qi1p9czYkJ?=
 =?us-ascii?Q?wI8f4XIMY5nOvCjw3EBitVDvm4VexJOKAEqIZr+y9CZyPc9XtSozo0G7AmM+?=
 =?us-ascii?Q?7CpoUquudkmJssCBlPZIY59n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd566d4-21ae-456d-b3b0-08d9366fe2c5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 17:54:02.4618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDO8uUg8G7xqYqmW4mZAVTVZAM3HYefDNSNpLc9cEsgL0uBziilKMriWVcNwy1lK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5318
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 23, 2021 at 04:50:01PM +0800, Weihang Li wrote:
> The QPC_RQ/SQ_VLAN_EN bit in QPC should be enabled, not the QPC mask.
> 
> Fixes: f0cb411aad23 ("RDMA/hns: Use new interface to modify QP context")
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
