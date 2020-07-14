Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C39F21FDF2
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 21:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgGNT7Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 15:59:25 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:16778 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbgGNT7Z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Jul 2020 15:59:25 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0e0e990000>; Wed, 15 Jul 2020 03:59:21 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Tue, 14 Jul 2020 12:59:21 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Tue, 14 Jul 2020 12:59:21 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jul
 2020 19:59:21 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 14 Jul 2020 19:59:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0/hyz6HrA2FsU416JWAFNiYE/5tJ+970VRV5Ha2Fx7sdXu8loTFfzfueNlWFgZF10Qbg5bKFxf8QgToGPx2qBSjA6vcOpsvBC2gYxEnb2m5L6Fj6ePk3YX0y/LqA7BQUreBZl0PD1XuN86zyzznM97Sjz/UAupfZs9isk1eAiDH1YQjiVLBEzn7PrFuHZcZ82ngFMl/jwhkNPsq4ciijGiUMbz5/ddasf+DXdNBo2pujqnZNq7fp5e/0IphdD1nUWC728trNa1THNFsUpivn2Sj/wsqVus4u/R1yg9rnvucmOzTJKW1wNDCCtgh0COJFHQRX1m0A+AdRhibX8WFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6Mwm3AUV0IMApOB/1pT0tglv5V8v9BqIe6GzN1KY2I=;
 b=JGZ33VZew2E5rUPwP1VWWw4OoVHyHcKTgTs7BZyun7FHwvB8QgXT4uU3k/qS1f3AF2CIiOh9GFmc2bVjRTCE793oVO2nvn3Z+is8cNXexL9Li9l13yHVVyDJKD/2VerlwHp8p4Tru7Hc3HnaQLxXUxBLgWxd7ET1WL5R/sguINIkDrNwQNhGN5/OIgtVKQ7tvVBQwDsUKSwvm8wVLsnkksYGbY4VyC8JFkQvLJ9nC3HaIU7iy3NH3z+pJkEx63s0D1A9RBsWRk49YUUmZgu824zdUmgx9QMIRY3Tu2jvo7ah0YTL03u1NAc6spyzT9Dx3ok/E3nm4bxugQQL+rQp1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: yadro.com; dkim=none (message not signed)
 header.d=none;yadro.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1660.namprd12.prod.outlook.com (2603:10b6:4:9::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Tue, 14 Jul 2020 19:59:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 19:59:18 +0000
Date:   Tue, 14 Jul 2020 16:59:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <m.malygin@yadro.com>
CC:     <linux-rdma@vger.kernel.org>, <s.kojushev@yadro.com>,
        <linux@yadro.com>
Subject: Re: [PATCH] rdma_rxe: Prevent access to wr->next ptr afrer wr is
 posted to send queue
Message-ID: <20200714195916.GA2475296@nvidia.com>
References: <20200609125411.13268-1-m.malygin@yadro.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200609125411.13268-1-m.malygin@yadro.com>
X-ClientProxiedBy: YT1PR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0119.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend Transport; Tue, 14 Jul 2020 19:59:18 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jvR5B-00ANwy-07; Tue, 14 Jul 2020 16:59:17 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8543fb9-e0ec-4eb6-f090-08d8283064ce
X-MS-TrafficTypeDiagnostic: DM5PR12MB1660:
X-Microsoft-Antispam-PRVS: <DM5PR12MB16601882DFDB60FE7B60BFA6C2610@DM5PR12MB1660.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eggrebSiXEVXqu7sqSVHU9zAo5LNiLMkZoKnqTQDlqt62zywxueSDZ2QRIC6MS9HQX0mW3gQ2Xks1/7U8XWvf+X43c1OEmg0p9C3wBYrG6tw0kmziT+fHQu/SHt2ken8FhGWUcZnok4eufIEDQlBAuua1LH85xY4fE6cUbTF7bc35/J2m24k+59Lj+ZinoDa9HKX4g1GzBvCmE6pnmmgo7YLbRSpkBOdW8XoUt7YZXv5vU+dPLzuuDHusvIDKB46zy3nnKmBmwnVMyVzuyKBeCgaIGt6zM+S1c+H9HGUMzr48Ut35dXLhP3D+/j9WFde
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(33656002)(5660300002)(2906002)(66946007)(186003)(66476007)(66556008)(6916009)(9746002)(9786002)(86362001)(8676002)(8936002)(1076003)(478600001)(2616005)(426003)(36756003)(26005)(83380400001)(316002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fGWxbCcqILfxCAmGx+QksIsCd4LU++kcjFjpcHnPI8Uy7ouFBlXSTfz3bluJ4/ppXyYGHIs6PCwtCkCIz+ny5zM5mWZB/MzMBWSlvqIfaiHxEbjX+GgLjt9gOEHABo1lCnET0TiO2uTn3jjve25VoKis009ZDAneOyV4xwxcvsPSSdqq7KkEFsswQSszxWr64mF3i9un7emR2zY6I2FVYa8rmL3xU+sIwXi4ezkQbKKF4jrjx6XfotvL0JXl+PPG7MYp25eYyuIPaHdt50hNsl3cziTJ7yS3M3pvi6oUAfi8XnPDApqjq6Cjx7wUFCAMkE2Ud8rpU0NazyRmCEjQKa21gBF0umtx8gL8675pH/EoHFcRSQfS5NPO0PYHBh21zaG06Y2PClY0OpHVx4FFwx+ccvrjq09ToxPc7tDaAc0//Mv+qTSLhvN7hTpegYX9VP/TB+iyldY+70mT8HtBAq7TrIb5kuVkN0WycoIKos/+J03OLlYBeyIVzVOC3s8Z
X-MS-Exchange-CrossTenant-Network-Message-Id: a8543fb9-e0ec-4eb6-f090-08d8283064ce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 19:59:18.9678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+JEGkfrlNt+Tln9n2pY8P2V5CvfW8Bo0GsxMvmAGnRc7NcCaJSDqYK6NJ6bOb4J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1660
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594756761; bh=I6Mwm3AUV0IMApOB/1pT0tglv5V8v9BqIe6GzN1KY2I=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=DniIJ29OG5Zq6nXtEtnn/Utz3SJaKomjVN/mdLb5MvZY90ADN6ANUnT8ARwP5BVBQ
         1lbZgFX2XyPEmgFORRaWIFXiOCbFkTCP2ci0EDy183OgmxE1k3E8JJGX+ivBZISqr4
         UmaNJkluzJxUAK6XYYhH0ut+vo0Eer+8Gboc6dJHYMFfOul02vib7CbREmaEy1M0fJ
         tHMdomPrGXdxQbufWShVhoFWlrVSRBc1Iyk6MmD8v+oBO4RlXTt5T4T1XFlcoKHJJ0
         jFiF4KM7Rt79JlFDY1Me74NUawjtkYBNw4zgzyBc/Pt0HDyrEYEFvRbceRVgxQrtqp
         zftrRxrlqDsRg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 09, 2020 at 03:54:12PM +0300, m.malygin@yadro.com wrote:
> From: Mikhail Malygin <m.malygin@yadro.com>
> 
> rxe_post_send_kernel() iterates over linked list of wr's, until the wr->next ptr is NULL.
> However it we've got an interrupt after last wr is posted, control may be returned
> to the code after send completion callback is executed and wr memory is freed.
> As a result, wr->next pointer may contain incorrect value leading to panic.
> 
> Signed-off-by: Mikhail Malygin <m.malygin@yadro.com>
> Signed-off-by: Sergey Kojushev <s.kojushev@yadro.com>
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index b8a22af724e8..a539b11b4f9b 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -684,6 +684,7 @@ static int rxe_post_send_kernel(struct rxe_qp *qp, const struct ib_send_wr *wr,
>  	unsigned int mask;
>  	unsigned int length = 0;
>  	int i;
> +	struct ib_send_wr *next;
>  
>  	while (wr) {
>  		mask = wr_opcode_mask(wr->opcode, qp);
> @@ -700,6 +701,8 @@ static int rxe_post_send_kernel(struct rxe_qp *qp, const struct ib_send_wr *wr,
>  			break;
>  		}
>  
> +		next = READ_ONCE(wr->next);

Why is this READ_ONCE? The wr list at this point cannot be allowed to
change

Jason
