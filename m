Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AFA254570
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 14:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgH0Myr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 08:54:47 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9878 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbgH0MwV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 08:52:21 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f47abfc0000>; Thu, 27 Aug 2020 05:50:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 27 Aug 2020 05:52:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 27 Aug 2020 05:52:06 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug
 2020 12:52:06 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.57) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 27 Aug 2020 12:52:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxuoWlJ9ZdJYd2dscsf13CecUeZOuzNNvrebP8z6VI77zcAE+5T0TktS6G5fQfFdnlQiv8/NHeoaDAo1zmR1GpyIkihblw1B/uwNEvJp/IoENS8up/J0O0zseOIDVlG3/PPsow+cQm9MObAI/0LtgNloEVrpxkeFf9EexjAJdJFwINfc8x9ycv2/OdbFSdECKaR1WIsMrhOp7vJWf5/I1lEIVqOcQ4VdvhH5qMZhwkjSCJiZHbM35zkT65G60upYYZy0imXonDbnq7KEPnqW+ISl4muor6O8vAqxJ8baWWsFLirEJr3bGvbtTAfW8H+MY0gbWRwi91xilc8JS7KA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X89r3TchNk/Of1dlqCK9Kez5Mvwx/dNm6cDVTtmEqmc=;
 b=nLsSeJNQy72snWHQRgn4A6zzwsGTXcgq5lQ9at9jvJ/9GIBG+tEwv0LZy3lJvsc9Dkmb1ereW2me5VbNhEnWv7ksrNsDpeU7Ov6ZIDTYahyDSbKST1aIRrWUJw0ZTm3YRcTFP3iOyGY0VEvQHHQYnIBlgiJLPOSSnHXevtJy8LLedX1GylPDr/b7azF4zpW6hxtACotPIy0HgHiNI4Ur4K3+T6tlMg+rtnQgcE88UD9JwhnQ0ZMXZ0zK5ICPdZmV6Xv1ov5pbtoMP4nxKO94Be9+OvYp/+1Lu1DWxoLzFNL0YPBDWzVtKlqTm5OSnGvjClMkQAn0vpPGOWd1N8wnxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1147.namprd12.prod.outlook.com (2603:10b6:3:79::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 12:52:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 12:52:04 +0000
Date:   Thu, 27 Aug 2020 09:52:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH v3 02/17] rdma_rxe: Fixed style warnings
Message-ID: <20200827125201.GA4025143@nvidia.com>
References: <20200820224638.3212-1-rpearson@hpe.com>
 <20200820224638.3212-3-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200820224638.3212-3-rpearson@hpe.com>
X-ClientProxiedBy: BL0PR1501CA0021.namprd15.prod.outlook.com
 (2603:10b6:207:17::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR1501CA0021.namprd15.prod.outlook.com (2603:10b6:207:17::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 12:52:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kBHNp-00Gt8k-Mc; Thu, 27 Aug 2020 09:52:01 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 664c8af2-0724-416d-6df5-08d84a87ff04
X-MS-TrafficTypeDiagnostic: DM5PR12MB1147:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1147372E23E6C6EB18A7EF5CC2550@DM5PR12MB1147.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AbwtmfrGPWmZ6Z/vCnYnzEy7i/5ipHa2o8+N1p2Y/L4KXxr+bSeuNkLHVux8/k3GNcbqBSJ1i5WQ96+SScHARw6Jyuc4b3OOXDbo2AxIbT/w+nJEeBOV/At2R/ezpfHgLQ7M1VpkEgUGyV7VGsBG/C5mfdvPBsCTYv9ftvkHOu7ub4RprKhn0TYBfyNmTTBalFwlgzr50K/lF8kJrluZ8y4WMSNPvaDxuKDlah/0BhPil546qiX2KgcvRSXERIgbsOEXJi9ywtemaD3e545vfvsx9SpqZE301MOqtcrIFb+KR5SHyDF5uJFGIcrG3zJrpVar4wSi8p95vcjwnBUK6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(426003)(8936002)(6916009)(478600001)(33656002)(4744005)(316002)(36756003)(5660300002)(8676002)(1076003)(86362001)(66556008)(66476007)(66946007)(9746002)(26005)(186003)(2906002)(2616005)(9786002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: C49UE5jcdX8XeEJrQNRncCwgIB/jjZXo13Pliqj/Bw3HL4lBIoYvSzRIT3FcAAyn/g2lKXqfYuP6voHFZDb25fVh4b585L1C6DvoEfrJL92OGOoTbhRsi9P19AWypWvh99EDSgtlwgt2ExfKCPQCykr7utS8/8KspRiMj5gEdE8V2RN6QRBkxE5LnOK4JUToChN6Y/Bb1kzxrKM1A6JN1T3/RV/+erSxK37GXqlaLmGpyM9IUhcrjYfDOZpiLAZ5XJsLvwAEFbiv6+q9cf5zkTWFaJPLFvNU+AdlkZHF20R0TuBtgGH1QRS/gBg3SqC1w6W2NHXvvSziC9Fy0ThWr69xMO2+hOagjX7BAb4ic3w17wt8l7plaZ7isQBksmdJj7jE9oHZrivM0s2RDFkzYLFf+EzjVq8PMGb0OH4U6Bu2G70EWON7MoZXhlma/Dk5zHpwjraGIx7Bi0fPFmiystkV+zykP8/emIIVWwVHuR0Gab+UUPt2ZEJTpJ9T8/F+ETa4wryxG+2HLiDLkgzQXJJMamHQPAL61lK89DzLsXEx9t1dOZni5jQ+t6Ry4emn2kMdKPcqxhAI0FoJZZh/QcCNbwCvCLDxALsovMtIGPMFnCeHtYFH+Mm6Bd3zJkHrL4UgApGyj+wdJKnmGbHcXA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 664c8af2-0724-416d-6df5-08d84a87ff04
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 12:52:04.4359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7dHDud/16/4Ewj8rJAiyLMg0q3SyrSu4z3hhASD3TA3ZFMKMp07Smrj4QQLLO7e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1147
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598532604; bh=X89r3TchNk/Of1dlqCK9Kez5Mvwx/dNm6cDVTtmEqmc=;
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
        b=WYiZIOXliv4pPx4RIocwARcqS/JndavMVXv4QFwdQ5qIPMar066XkgukvubiOG/mD
         zFPOix0UBR6YgfoVfIPczCP50+ZF4Eoe+OwNA60O6WgALKQSLD0y49tUZz6wbHmwgl
         InF96rhPdgd/CeRYmTQpbV+dSqirKNDU+lPdK0rbkgzxoouzwm7dLGOVbLBWTkmQDe
         fHydqG7j8jIC3jR9wb8CXOrAeoISoo16CnLyO48qp0klGlxOB/GjNOpWbdNPhNcewg
         9fLOp4wwcbtZwsp5hEPrR8mrnl+Ri6+CDEEO8IXQml0ApfreFSrSCWJMzuFvPsZ/jF
         +qj5pVrkBtvLQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 20, 2020 at 05:46:23PM -0500, Bob Pearson wrote:

> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 9aaf3a9fed7c..c2d09998b778 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -566,6 +566,12 @@ static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
>  	    qp_type(qp) == IB_QPT_GSI)
>  		memcpy(&wqe->av, &to_rah(ud_wr(ibwr)->ah)->av, sizeof(wqe->av));
>  
> +	if (mask & WR_REG_MASK) {
> +		wqe->mask = mask;
> +		wqe->state = wqe_state_posted;
> +		return 0;
> +	}
> +
>  	if (unlikely(ibwr->send_flags & IB_SEND_INLINE)) {
>  		p = wqe->dma.inline_data;

This hunk is a functional change, I took this patch to for-next
without it.

Thanks,
Jason
