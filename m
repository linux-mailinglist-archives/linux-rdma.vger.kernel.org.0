Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26ACE2059FB
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 19:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733048AbgFWRwR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 13:52:17 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:56072 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732913AbgFWRwR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jun 2020 13:52:17 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef2414d0000>; Wed, 24 Jun 2020 01:52:13 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Tue, 23 Jun 2020 10:52:13 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Tue, 23 Jun 2020 10:52:13 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jun
 2020 17:52:08 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.53) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 23 Jun 2020 17:52:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c16HRHNBfS3ADqrGGDXKPY1Ohi8AKTaStD70l4YoePlGI2TLwENed/n6P3gbGfoF6wsodBxIVymeroriXlLBEeAYbKy+xujowYwkrURninWUYIG7d/FNCWtxkWQDuWb95arafMULRVXShMbGFZnWV1XnwVwJjKg7o42gEmh4Pwsho1S0pzikK/0GNaRERTHi0nqjTvW6XEqrndATJLCPExZBEIRld3BZzhLEuRYZK4iXFzLSRVH3aJCg8INltCuIKne5sEEHSHv07Qg4AscTnV5dFMoKUi5TDP7gitXThwW+6yjuJ5o2uaLtGoeV3DBeopdLuOyoNYG9x988wbLulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orb31r3w8A+V1INAuHXIlQDni3YWSUX2i4DPtkXeTjM=;
 b=f3wvpiSZWV/EwLA/yMeSf6Ji/7xTI/gb1lGtObcr2dllycTj+4DXUPcVIDdgWk/CuSvRBVBFt0qPlzlbRvMWDSv8eZKCSxRIgK005SyQYOnYTtnhYmiE9QGlruXfIygUCnfvEWLJw8tULqJEyGjpEs4XU/UzO1PfICDeg+7i3oaV9yPG4lEjEeQ8kC5eHe8TV+M/4jPIiZYykFKs7XRtDB/2HwmWG2mNtAG4zTuKjJUSOoy5XGDMCA+36vn8sAGmigDmEEDGNr+6osa4QbX54XXX7f9aFpGMnurVJBODW6Z536qGwhDa4LpwAKVZJE14Jt/9U3KN5e4axFf0YMDV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3836.namprd12.prod.outlook.com (2603:10b6:5:1c3::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 17:52:06 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 17:52:06 +0000
Date:   Tue, 23 Jun 2020 14:52:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 2/2] RDMA/core: Optimize XRC target lookup
Message-ID: <20200623175200.GA3096958@mellanox.com>
References: <20200623111531.1227013-1-leon@kernel.org>
 <20200623111531.1227013-3-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200623111531.1227013-3-leon@kernel.org>
X-NVConfidentiality: public
X-ClientProxiedBy: BL0PR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:207:3c::46) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by BL0PR02CA0033.namprd02.prod.outlook.com (2603:10b6:207:3c::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 17:52:05 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jnn5U-00CzgJ-UL; Tue, 23 Jun 2020 14:52:00 -0300
X-NVConfidentiality: public
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4e50193-4271-4752-bfef-08d8179e248c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3836:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3836646FDE7731E4F53FE7F2C2940@DM6PR12MB3836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Uj34PdmDDHdlkrHYnqy7Z2CKihvwa1hubZ/VZXfe/KFG2ImUiGfqtYQ7Z9tPHs6RoLJmNK+HaRPWOzPmVeKWxnW+4UUUFhhfUc88WMgDCXQXYMGx/o1ojzMNimgNmK3FqZVhbk9s9q9lVMfLZD9RwTZytrYgMLEpYUw3WoMBTlzCfF3iT6PPnok1FRfxTyjXu32XT7hZv+lUhiF9RLG5isIiPqoZ7bhUWXv144G1KqmSmQuZTDA/K+brBuF1a0CTho2mq7TWoXWBKI7IlP3ci4yDh+nQV/OXDP2g18rLDTc1eqF9j2CJ50BfV20BEYA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(366004)(136003)(39860400002)(396003)(54906003)(2906002)(66946007)(316002)(66556008)(66476007)(5660300002)(36756003)(478600001)(8936002)(86362001)(33656002)(6916009)(9786002)(9746002)(8676002)(186003)(83380400001)(26005)(1076003)(426003)(9686003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mp4xUM13L6RLgNDhh73XJJfuLIj/soNI5+P+DpJB82UGgvXbbYPgYwVQOTDMiQ5zMqkluYYyRLL10+vKknYnQO4+l8JKUgvZqh3i86y1nY1aT3wJKBb2d5xDt6XuG/R5zNOf1QHqX3sQhgWTzjnCKD96e1N7PmF+k2kUywwag5T50AHmNTMtxIChuBkhQ5j6Shk8GDJbaOkOIWk60ZiwSLApz+7VsqxEeV31b2F1i3Kb3Fatkpqp9J45GxYBRrGmrTfcRyeUJ4c3HhS/yaXkvqtuZ3o4MrIrWT/ImCMpQwO+e9Zhi33SPpZ+M1cgoWKXiThRF7kcG//Fec7m3aHUul323ZdA9lM1csZlJ7XkvZ00w+AJ2ZC4RPSzZibyv8Az+cW9owQZXGSkvfnhsfH7I57CpFROU5eMiSOQ5vJZnCPmzFcyVYU+LAeWNNAJUi9m09HP/F1BYnL+Qld+cL10RXiIp0GGwA+6aFxjva3mbBepB7HlN1bFfji7IAP3Kq9s
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e50193-4271-4752-bfef-08d8179e248c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 17:52:05.9460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5onhzXDtzWvCaZpGd1g9sB5r9fdEDb5QoggQgbZiZCFKl0dJPnWzGTcMPaTIXOP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3836
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592934733; bh=orb31r3w8A+V1INAuHXIlQDni3YWSUX2i4DPtkXeTjM=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-NVConfidentiality:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-NVConfidentiality:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-Forefront-PRVS:X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=DRM7UB05k30mNZDLFPWUNCd+noyvI5Wi2xNoz+D244SXpAIDuc6iZzVq+2bMBhp8c
         FKTCLzlJLNfmViceqsFxPaGEFuJTy9RxSkyUsVka+EqKxwIAS3uVO/TYE17CHobdHO
         itPhVmJBwjVooGP2ls3ZT1PObKp1RcL5IkqzeA2qmMk76mi6sYMm3X4YPwMUZJtSia
         pgiWPcLlLJvo7gEjIhdTIKbL60gWRlAR42CStLmWJS00GbEfvhmYsclixQKS+gllUa
         NA+jECj9vwVmlZZPcLyKaIUTD1LMLsdg9bEzQj2wWNj7nzNxx3nIslU42Flj5wbki7
         cXB4L8WZArTWw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 23, 2020 at 02:15:31PM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
> 
> Replace the mutex with read write semaphore and use xarray instead
> of linked list for XRC target QPs. This will give faster XRC target
> lookup. In addition, when QP is closed, don't insert it back to the
> xarray if the destroy command failed.
> 
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/core/verbs.c | 57 ++++++++++++---------------------
>  include/rdma/ib_verbs.h         |  5 ++-
>  2 files changed, 23 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index d66a0ad62077..1ccbe43e33cd 100644
> +++ b/drivers/infiniband/core/verbs.c
> @@ -1090,13 +1090,6 @@ static void __ib_shared_qp_event_handler(struct ib_event *event, void *context)
>  	spin_unlock_irqrestore(&qp->device->qp_open_list_lock, flags);
>  }
>  
> -static void __ib_insert_xrcd_qp(struct ib_xrcd *xrcd, struct ib_qp *qp)
> -{
> -	mutex_lock(&xrcd->tgt_qp_mutex);
> -	list_add(&qp->xrcd_list, &xrcd->tgt_qp_list);
> -	mutex_unlock(&xrcd->tgt_qp_mutex);
> -}
> -
>  static struct ib_qp *__ib_open_qp(struct ib_qp *real_qp,
>  				  void (*event_handler)(struct ib_event *, void *),
>  				  void *qp_context)
> @@ -1139,16 +1132,15 @@ struct ib_qp *ib_open_qp(struct ib_xrcd *xrcd,
>  	if (qp_open_attr->qp_type != IB_QPT_XRC_TGT)
>  		return ERR_PTR(-EINVAL);
>  
> -	qp = ERR_PTR(-EINVAL);
> -	mutex_lock(&xrcd->tgt_qp_mutex);
> -	list_for_each_entry(real_qp, &xrcd->tgt_qp_list, xrcd_list) {
> -		if (real_qp->qp_num == qp_open_attr->qp_num) {
> -			qp = __ib_open_qp(real_qp, qp_open_attr->event_handler,
> -					  qp_open_attr->qp_context);
> -			break;
> -		}
> +	down_read(&xrcd->tgt_qps_rwsem);
> +	real_qp = xa_load(&xrcd->tgt_qps, qp_open_attr->qp_num);
> +	if (!real_qp) {

Don't we already have a xarray indexed against qp_num in res_track?
Can we use it somehow?

Jason
