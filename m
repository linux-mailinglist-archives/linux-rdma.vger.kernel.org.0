Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5A5A1797A7
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 19:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgCDSQO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Mar 2020 13:16:14 -0500
Received: from mail-am6eur05on2048.outbound.protection.outlook.com ([40.107.22.48]:6221
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725795AbgCDSQN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 4 Mar 2020 13:16:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTvc0EIasN/t3ypzQrHr310egnpcPPyW5yLEsprZDukd04zZPQweb6CYTIgigM+BGbiOODl8wxdMkJ/BSohMwrQec/tqdskLoEgTezjuzqZHTyjWuwn/CL2PwcfqCuNjyi9eAtMS7+I7NMHixV6gObUGR9mExnJ6JiX5qQE7lXGGMD68jJs/VZy4pcdqK9idHlVYnq9C6JZzQN9jvgR1VQDk46UxHwZjaAeUdyDPB3wL0Rpmjmg7mcBvSjV3vCdFbNh/IQV4ZetsSUPPjbEKXRAGD1B816b7XUOYFkJCTfRiWgoyZZnzzrFpjbVMvUiRJjAOphh0BRutyIK99CDRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1BmzMwGpg6+IgzCMWR0ONJ22NMaVkLeY0LQQfoquSM=;
 b=TbTdUh2ggzasUq1IlECeu0HUDVuTce/EsqiR9To7aKPeO8C5m0m9oVqhU4iRUNnRN7qIIpN7SiP+vP67Jwx3N2v9ZK/kgZiFY9swY9eObbLAAEXxLLEDOlfliL5SjnwXf2SCwf8t/Pk0NRaOpPo3jPZrOSiVp2Twm46PX8HMgNmJ6MH90TteAqObU37GfLi0YMSl4g8szPEz+VNlODk+zdIHkCTOhgjLNLI67j0p2GYKyF34921fQI3ct7RCDaj6suijB2STApS0RqgnNuZNbzdWvaG3Q7XQc/Lju8i/7KyOuDFjB/Q/gR6B5OocPt47k1JenCn3qTeP+5Np47GYvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1BmzMwGpg6+IgzCMWR0ONJ22NMaVkLeY0LQQfoquSM=;
 b=nXz/NZuO2NBzRWIWrEBuJIQkfNOVkKKcH8Vxb7T9ErIpF9Yjh4+j0w0ekdxE40Boydz8mPCDEGM73AzljNCwraUoyj9fDHAsGVjMlzmmmsouiMW4Z7wZsFs+YrMX/xee0MBuNTR3V4LbOfUQjNw8hKLND53kRk54YAPXrsk7v/k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6415.eurprd05.prod.outlook.com (20.179.27.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Wed, 4 Mar 2020 18:16:11 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 18:16:10 +0000
Date:   Wed, 4 Mar 2020 14:16:07 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     linux-rdma@vger.kernel.org
Subject: [PATCH for-rc] RDMA/odp: Fix leaking the tgid for implicit ODP
Message-ID: <20200304181607.GA22412@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL0PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:208:2d::49) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR03CA0036.namprd03.prod.outlook.com (2603:10b6:208:2d::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend Transport; Wed, 4 Mar 2020 18:16:10 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1j9YYx-0005qF-9p     for linux-rdma@vger.kernel.org; Wed, 04 Mar 2020 14:16:07 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5a770152-f99f-4001-5031-08d7c0681dd5
X-MS-TrafficTypeDiagnostic: VI1PR05MB6415:
X-Microsoft-Antispam-PRVS: <VI1PR05MB64151DB4E82F94CF63B766F8CFE50@VI1PR05MB6415.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(1076003)(8676002)(478600001)(33656002)(86362001)(81156014)(9786002)(8936002)(2906002)(316002)(81166006)(9746002)(4744005)(36756003)(6916009)(9686003)(186003)(66476007)(66946007)(52116002)(26005)(66556008)(5660300002)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6415;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DG2Ep9+KENIrdgWXQ8qHrlD5bnxxRcZNxNtUIq8BJj/q3OOCSUpdtZb0iYtedECyyHIdRiEvjc6GJQfybQhbNLAlb6C7RWU6Zs2G9UIbz5ln9nhMlqoK0eUA4DxyASMA76wnr3zrulNKuo6M60r7Ksk1BXhCB7b81M5LwQ4He0FoeesaJYvpnqIY4S3VVGeZr0CbTNnPJYPuRkZJEMD+2aOlmzBvs2EHNZfyT0wKjj01ZFhWRoLRbzm6rUP6pzd3IyETFg1+H+fOTQ7gxkMOSutPkKY6W+wfn416DU+LVfi9tk9gq3v3nMvfoyVM4OP6kifXToIPpDwjV3QOaOAwvPQ32hYx4QiuTEbXj+6xsNwPEoK12XbBSudc1PU9BsMAve9jznGNzGR5GPfSTai5QLCjkumkKzEYoOPTIaxPz99AMXpB4srhbKosXrobjVDL7VqdPsRMEM8TSFTwT3aA5SUFgKi5XAWkCx3Km/enGrOzQT9Ra+EoMoJs4+poK23z
X-MS-Exchange-AntiSpam-MessageData: KTGKREwVIk0XyPCVqcvi/s1OQPBlFLzeT/7RjdxGNJ2J4dlBtpM8SuFAlMeOLyaM62kF/FPkEtPxfIyY6BEs4nAvdzYr43wDhUSQNTr5B1SYPruvh5REboPK+c/8AGQ/8GYxffrBUeH4sJqZjXv5yA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a770152-f99f-4001-5031-08d7c0681dd5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 18:16:10.7364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYgvsWHF8DQ8afDKlRvZvk4DCOQt2I0elB2gYu69RMqLIAgD6SIbo7woOwMDrOBlqAOLrSPoZGLBOeugvFBwdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6415
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The tgid used to be part of ib_umem_free_notifier(), when it was reworked
it got moved to release, but it should have been unconditional as all umem
alloc paths get the tgid.

As is, creating an implicit ODP will leak the tgid reference.

Cc: stable@kernel.org
Fixes: f25a546e6529 ("RDMA/odp: Use mmu_interval_notifier_insert()")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/umem_odp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index cd656ad4953bfc..3b1e627d9a8dd5 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -275,8 +275,8 @@ void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
 		mmu_interval_notifier_remove(&umem_odp->notifier);
 		kvfree(umem_odp->dma_list);
 		kvfree(umem_odp->page_list);
-		put_pid(umem_odp->tgid);
 	}
+	put_pid(umem_odp->tgid);
 	kfree(umem_odp);
 }
 EXPORT_SYMBOL(ib_umem_odp_release);
-- 
2.25.1

