Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADAE184789
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 14:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgCMNM5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 09:12:57 -0400
Received: from mail-db8eur05on2040.outbound.protection.outlook.com ([40.107.20.40]:36159
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726594AbgCMNM5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 13 Mar 2020 09:12:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XB/Bmx0aYxbEXlYXtiishLrstgrsJLND4b0nCSerulyyppZYNuNXD6N9/W8GrIDfw3ixscNPRE9bB5/yLGQR+K+U6yK7ex1HuvZ514Gl547wbEZMsTgfvX0lSCICCohUBxgF+kng83acp7x1jb04iUTssn+fN66O6R0NUyrH+r/MT7OuyDD+GlhasrZsBA1FeW+Zk3VPKUQ0hEGMm84sfaxqPaSHeCkS+DbP5dq18llI5fLEyNOc+I1gz9pkJOZXGcntjyZ0S85tI/w4RBFeFExcPMWjhgY/vm1shzZxUvXer/6Vb+gD8bZZjDAJy2xv0+ZsbUxwaEQ7iX+B+0+sgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqIFVtocozUAwqu1KEcJsxKyxSwCD5bz158TEpXHAXc=;
 b=JoXWseCCtjqdjMoW/hctjx0NTzZZiVQITHKMX3I06lU6O8OSQBWxeG5ruqt0zsgjD6+fxog5vFcWEGBL6JGPRmNU4D2ATWQPL5m9EfiuF5CqSOAYHPM7q8mEqS4mXRxkxPkiG1vB4XzM5j0cxhCmZpWOiFc54miYnhpjmXo40HxKSMXXQq/U73VDB2zp40aO5Ac+vN3r650qVH7v9xPjDKYqMLPNBbrAiDU8cfNWMadb2yqaEF8HhzZ5ImpcqQD0aEtJpRTT9KlieBpehmjMMTTGE/6uGvsXlTEC+6oQTKK06zMFeckkwy1/xJ3GcST9wWYjjhi4itlhE4SNQ4wQcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqIFVtocozUAwqu1KEcJsxKyxSwCD5bz158TEpXHAXc=;
 b=RKD4YTlcypqiTD3vrRy3+hJtb/1MpFpxW3L5aJ6nIod6BxE1oKvJtM6zNxtmdaDXbPRYe+i0lO+0xa5ov1d6JYDHTL69yadVXK+Jk0pusxOFvaGF7Tp9uheLCAJtdlTXgfuKAhKSQ7+jkbOz1HcNlUrsT4F3jLqHsgEVGyi8N5w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1SPR01MB0382.eurprd05.prod.outlook.com (20.178.81.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Fri, 13 Mar 2020 13:12:54 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::ed46:4337:c1cd:1887]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::ed46:4337:c1cd:1887%7]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 13:12:54 +0000
Date:   Fri, 13 Mar 2020 10:12:44 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 3/3] RDMA/bnxt_re: Remove unnecessary sched count
Message-ID: <20200313131244.GJ13183@mellanox.com>
References: <1584102694-32544-1-git-send-email-selvin.xavier@broadcom.com>
 <1584102694-32544-4-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584102694-32544-4-git-send-email-selvin.xavier@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:208:234::10) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR16CA0041.namprd16.prod.outlook.com (2603:10b6:208:234::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14 via Frontend Transport; Fri, 13 Mar 2020 13:12:54 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jCk7I-0002xY-CF; Fri, 13 Mar 2020 10:12:44 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b0999cc5-d968-4139-3093-08d7c7503dd7
X-MS-TrafficTypeDiagnostic: VI1SPR01MB0382:
X-Microsoft-Antispam-PRVS: <VI1SPR01MB03824265617BC6612365A786CFFA0@VI1SPR01MB0382.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(199004)(5660300002)(4326008)(66556008)(66946007)(66476007)(316002)(26005)(478600001)(81166006)(2616005)(81156014)(8676002)(8936002)(33656002)(9746002)(186003)(2906002)(1076003)(86362001)(52116002)(9786002)(6916009)(36756003)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1SPR01MB0382;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oYLUro0vSEJMldAUsTpzzWyr4jMUjrHJxKOgKYkEOQdv/V993iwj/Lh1G2RTTCIOcjxZLYnLexUPYbuU9CWBEhsNTslGa8k+t/FHMMFGzJcRczRzKnbP8ld8T21PhmlPhRZ3HlniKmk7ZX/QrzoD/zVmeQhrGxIcXPvNjHZG46DUocXaLMO+Q5luil9e8nrcHUE77iD6GraKv5/RX6LA6jhe9TbYZfTs9fTO5rfuqUEF73WStoZM185U3Q9zb4fmObmVsRKh79oSaTFT7de2O3gO4cqE+CtZeOa9TUmsHp/BqH8Bxy3zhn1YROP2EUNQYq1gJs9XdF8E1POFQhsVekGKVgPOvGtTifW26DoNj2BgHWuNsIOpNSoQLVJviG4N0ihO+Fu1Cqy7rD7feMu+jDm1JubpV67JsLvfu+ZtlUNr5+fMnW1VFbNuT+enZUkn06s9GsqzbeFpXK1IgHWrNMpvihaC5RDWf25O0oYYTPcTTrchnjoZQNqclwIWiFT0
X-MS-Exchange-AntiSpam-MessageData: 4yCIw5r5zze9+BiWkHKWsLUUgKtNFwyf2HHe7683CofqhdCM5yuhonvruafUdVLNCftwowrfy2V50m3nsYvFuSgNoj1xDTdQg/5lxM+2hFdLemC/TRhaRP/6Ba6DABpAh4PutPBYbEfbtwGJ4HVkQA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0999cc5-d968-4139-3093-08d7c7503dd7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 13:12:54.8306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ue3KCw6htHhdkTJOEB/qVm5OY0AmdILvrbdbwR8w3/RlfQ2sZ0oSlMdf8Fb6g+eUwDYqusAA6k6EU47pSPNtAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR01MB0382
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 13, 2020 at 05:31:34AM -0700, Selvin Xavier wrote:
> Since the lifetime of bnxt_re_task is controlled by
> the kref of device, sched_count is no longer required.
> Remove it.
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h | 1 -
>  drivers/infiniband/hw/bnxt_re/main.c    | 7 -------
>  2 files changed, 8 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> index c736e82..e35cc6c 100644
> +++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> @@ -177,7 +177,6 @@ struct bnxt_re_dev {
>  	atomic_t			srq_count;
>  	atomic_t			mr_count;
>  	atomic_t			mw_count;
> -	atomic_t			sched_count;
>  	/* Max of 2 lossless traffic class supported per port */
>  	u16				cosq[2];
>  
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index 82062d8..4df0f8e 100644
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -1670,7 +1670,6 @@ static void bnxt_re_task(struct work_struct *work)
>  	}
>  	ib_device_put(&rdev->ibdev);
>  	smp_mb__before_atomic();
> -	atomic_dec(&rdev->sched_count);

All these smp_mb's need to be deleted too

Jason
