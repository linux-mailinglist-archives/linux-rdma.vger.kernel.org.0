Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67880251D45
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 18:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHYQfp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 12:35:45 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8957 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgHYQfn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 12:35:43 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f453d9f0000>; Tue, 25 Aug 2020 09:34:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 25 Aug 2020 09:35:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 25 Aug 2020 09:35:42 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug
 2020 16:35:41 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 25 Aug 2020 16:35:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgQ/c3BgfOIaApO/KjZNqNHKBpthwBfxlETlGty8EA8xE7l9zQj2/7CZkYTmLhqeRQHIXzZUB6mDsLDrNnaTliBDczafl6j7/PJVDMmjRBQgylv1VvTKgErF5Fc54KLE8JqZzPv0Mqp3YP5Ds9FyJV/xveBDpRHGB+LBH36tfCh5DdbyHeWeLuGrGaEWLt6qAPPXiat7FqgmQFMbtLjFBpKsAmw5mn4Yej40EMrukhdIAmLQKRa4UUnj3PL35Yuqz5QmBIu6riG5831dUHL1s1uBoaeqGB0ipWQ4c3i6QFlHhl5eNrPJibqOBOqvsIAwhqrhT0gfaOxXowT78MmOtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQdw6HxE64YuMt89HNQVp7g2ayJGIZiMvJHyKQaHlVc=;
 b=E+dop+SvvG4WPNonWsLw2R7L575NqlNKohE4oEzKXJEOGG/D7bXDnVyVLeNby0anfPi/brsxupW57Ba0VztwLLD4vgeTgKtovHuamaYHxgwG8GIYMKvpuOqSxe+uMOFs/HoV7zLrpH/s8HQff0AbD3KnqnQ59KhYlXNfnWT30NqUF0vI9ue6oA7pwhjt1EAlnfewXKB1RRpfuJFXPt9Y6wP1hOcYxdasb1EfxZa+6wpaNCAkeb7zE+OnQrwqqRLuzfjVjgwJ5QnlYnLTw7QGgc8N3laCWHAUaeWaC2AEybhX1QFyIuHxMFdhW1TAqEQ1btLEWOWTZztmzV+zoS11iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3019.namprd12.prod.outlook.com (2603:10b6:5:3d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 16:35:40 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 16:35:40 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH] RDMA/core: Trigger a WARN_ON if the driver causes uobjects to become leaked
Date:   Tue, 25 Aug 2020 13:35:38 -0300
Message-ID: <0-v1-b1e0ed400ba9+f7-warn_destroy_ufile_hw_jgg@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: YQXPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::44) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by YQXPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:15::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Tue, 25 Aug 2020 16:35:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kAbv8-00EhqR-Hm; Tue, 25 Aug 2020 13:35:38 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2134d00-dbeb-411e-e378-08d84914e75f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3019:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3019D402F0003C2D2A8A99DCC2570@DM6PR12MB3019.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IF/DmlTbcfbyJmeYDmo/p4tA7830HumvTlz49SapYwo4BI8ZvsJnLw4WAZrVdISZ2Mrn890FjQ4d8b9njqQFSz2MMsQESrtf3MLL2hs/XPvJHiwnG7xusUbjnzjizfZqLu7ZBNCImCEnElgzjGYpz+8fld4OhNmE94cAfmBEbF+Jijw7A/1XwVfXnfqqE03D3ZMiDb51g1papyHT7nSJuB1Nvsb82XXDS+SFWjdRaE9OTd7VdkQhW0ZwiykX8Oj4eOVT65v+KRjs6GQAB+L2KQ3OBSSaCHNxiRy5Z4JEYw7LKh2m3SfNV7ohrdrLevx/SUqJzfYxDJ+RSVvXT176NTlMjzK88i1bLLxpZU6kBEZNhZ71gjAOKqB7b3nYuFhI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(478600001)(4744005)(2616005)(66556008)(66476007)(54906003)(86362001)(107886003)(66946007)(426003)(83380400001)(2906002)(8676002)(186003)(5660300002)(9786002)(9746002)(36756003)(8936002)(6916009)(26005)(4326008)(316002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3i0+CXNJAFOEYRKT1nFPeQPLdEWhDGrZi8Uhh/yrnJI+nmkmCJL8kGIW1u5jPwVe/tiuoSeOBuEJnSaGuyqcA1Mhar0lJ2STdQOQZu6Od9royg4xC0BEW7/h9QBpq562EREyPlllx3wWXvsAPRCa6m34CWFZZTRzeNOKXMVN+4RKqdU3a/2aXxg6yuhQsoiA5X8wmywYzutY2smIOL59jZ+0Yax7g2ISo6giuDSdX/j3bsqMC1S0rqDOsIatJg0rA8SJlmeBYS42ounzhtYQeqhWzAnAJHPdOnvaRC5iGfy35dZmq1cobpocgl27oQ76yBb4QIMPPMVaXNOJXJTvjH4vlLDu81EQ1pkQyp7RUsNecKaPeI54gbAYomPVi8xU13X9xfMdSWe9RyxrjJgI5wnVsdEjDfEZs1tysfMonZBkO/jVrdZtVz8NH2Y+QyYqHo1RCAAQePpJaawdfVG/8BpMeWSVGzARTPo9T4Gpa0jiLmsXD8QDXffhJZZt8oe5a9okPCoRZESYZLSZHOEZh2GAfmwX0V9jMqxl46lF7h9UtukWboJcb9W9KPeyWVYg+fwFtNDq0f6/rFEf7JPw11SlZMxU7oOoT6XYGK2x9f5TSeYYYmB5vAI8SmOjEOdGO8e2xvFkT5nDKZ0ONgW12w==
X-MS-Exchange-CrossTenant-Network-Message-Id: b2134d00-dbeb-411e-e378-08d84914e75f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 16:35:40.5498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsdiT5aOZUx+AFQFa3UvjqtCV33Ba0JQc2sw7uFDXK/D6n77808YVs5vMCI1nIi2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3019
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598373279; bh=CQc24ai0ItgEpaAdCKotcncAHqxsP0/RjlI2Q5T63mY=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:From:To:CC:
         Subject:Date:Message-ID:Content-Transfer-Encoding:Content-Type:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=kJnehnuug1uTvFbaCQds9RBX29WdjzkSbV3nWKqnlL9gSpjfcsQ9UsTijEggRVzc7
         1LXvn+yD16+ULaiHIl54e0tAHK5koY2EXQNHF5qOC1mqK1V3RBJaifUbhFBIwbO7du
         aSub3+UdLhMujq9V2yMdKfOK/FCCSWws13D67LbQUCYlk8YE7KaSxlUnA4VvK4nzDQ
         m6hwXeHAw8Br85GftqNEnfoonK9i80fa6rX6BeL1mv7Q+gppeGuo7fK4OSbvaICtk5
         1A1OxVu1Ek4G3PTehe5HMnJD3f3sgHio0cXp7lREw9gXw+A8jNLNkQvr3A0Z675EQN
         2kTz9e1dIKkxA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Drivers that fail destroy can cause uverbs to leak uobjects. Drivers are
required to always eventually destroy their ubojects, so trigger a WARN_ON
to detect this driver bug.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/rdma_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/=
rdma_core.c
index 3962da54ffbf47..d2b5417a4d5170 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -895,8 +895,9 @@ void uverbs_destroy_ufile_hw(struct ib_uverbs_file *ufi=
le,
 		if (__uverbs_cleanup_ufile(ufile, reason)) {
 			/*
 			 * No entry was cleaned-up successfully during this
-			 * iteration
+			 * iteration. It is a driver bug to fail destruction.
 			 */
+			WARN_ON(!list_empty(&ufile->uobjects));
 			break;
 		}
=20
--=20
2.28.0

