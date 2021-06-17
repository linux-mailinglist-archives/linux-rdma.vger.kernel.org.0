Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006B33ABBBD
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jun 2021 20:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhFQS2f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Jun 2021 14:28:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8078 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233514AbhFQS1r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Jun 2021 14:27:47 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15HICm4J016203;
        Thu, 17 Jun 2021 18:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=7FOC9co2yzrUzivuU/hHG8IvI85afKDG5pc4MMjZzQw=;
 b=agDBOApqZXzbP5ebQw8AqcpinJw6BEFNGxqrL/rwF4sLbHkm+gCVm+li6i+8xG4naf/b
 Sj7j5GRa/iHG0y2v1GgHZD6xwA4Yw0mAHbI4rHB4BsKOzdqGwKmiSk8xaVHp2EyU8efi
 gLXOXJG/XJ/gN04OrIbCQchLnfyDcAYyOFCPIbDM9nQlDPPigZOcPsQOe4wlACe18VXT
 SddkMdzZlsmzAr3GVLaoBCROLIoqRy+CJm6QCkjH06aDMvioVb5BmQLBhL0P2tdwiMzU
 JfszbatVwHVBedpDfG7wQUJMcZKZ/5C2AhkD1NMwSRm65WrNOzaI62E1EI77ZPjqb/pk ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39770hbwxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 18:25:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15HIPZFo125130;
        Thu, 17 Jun 2021 18:25:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3020.oracle.com with ESMTP id 396waxxj86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 18:25:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wvk1PMSgcXqsWXtxs9f81IzgC2fP3sgaWJXY3obLOWnOqYOP+FdWYbPzSalBCLOK1OGFdAv+H5Db2HoWEy2apICJhjEe4298tNljAb1w3jPa5uPvIaP0W2VBfZ808+QGPBI3R020AA8VQvOoW4Mxnh90AQoo5250IXAjLH6bi+ABh3zWdRT5iUGH0Jv+dqVOcBSsuA8gV3D4dwKTyqceKTiUGEGi4BmgFYhue9ilHUNVfKCwV8S6JRjGXjUAxyrY4WVL4eH0ZcJi1qjVyHTWLsNgsndmCESkyoFLGMF8GsR0KE8BWQ6BdmGZyLHQzdnoVP2e0wWz5tG8D5Yvcs3KZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FOC9co2yzrUzivuU/hHG8IvI85afKDG5pc4MMjZzQw=;
 b=obaF12/wZGQUUT8BaAti4MFRbHoqzraWMP9p3OnlmFrJegYEAIV+JvV/bGJnVrEE8qNA+9DSwpFEyusp3UlIbAgPflUkBjNhwAFCzCZ+fPt9yPJ5AIeYxusIONWkb/EeF3AW2ExMx8kf8LnchB7PShDKBtmdZAcejJlSy2XND48urtxDwkoBboYnZ01kOQGpEiqC0UZtfbuPAxiZEWxGAOfsF07PjJJ8gAUDKi+fXypST/sOctVfGxCF18ZSK3VKEoUqNS4IJ2OoMG0HI3BRxrVp/rEyEeSRLpbhSfoeqJ/JJTpQfNrXarrCKmUuVKi7/uBcOFQRArwfPI9xfcQYZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FOC9co2yzrUzivuU/hHG8IvI85afKDG5pc4MMjZzQw=;
 b=qw3Aud8BNXCzGnlCfmr4yt1AllQso2jCeBMsrF4RYquqehUeq85UIBTgVHu6YKUbmL1hZi5JAl+P7KbLbgx9zb44FHUTvyQKn1fQwCSnKyeSGtcJ24HSYdyj+wGvu0nAh0EKAIuX7Fg6vkjLibpTtrhptnBjsUklbtXj+JXrsbc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by SJ0PR10MB4495.namprd10.prod.outlook.com (2603:10b6:a03:2d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Thu, 17 Jun
 2021 18:25:20 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::cde8:567e:da77:abdd]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::cde8:567e:da77:abdd%3]) with mapi id 15.20.4219.024; Thu, 17 Jun 2021
 18:25:20 +0000
From:   Rao Shoaib <Rao.Shoaib@oracle.com>
To:     linux-rdma@vger.kernel.org, jgg@ziepe.ca
Cc:     rao.shoaib@oracle.com
Subject: [PATCH v1 1/3] RDMA/rxe: Increase value of RXE_MAX_UCONTEXT
Date:   Thu, 17 Jun 2021 11:25:09 -0700
Message-Id: <20210617182511.1257629-1-Rao.Shoaib@oracle.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2606:b400:8301:1010::16aa]
X-ClientProxiedBy: SN7PR04CA0084.namprd04.prod.outlook.com
 (2603:10b6:806:121::29) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shoaib-laptop.us.oracle.com (2606:b400:8301:1010::16aa) by SN7PR04CA0084.namprd04.prod.outlook.com (2603:10b6:806:121::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend Transport; Thu, 17 Jun 2021 18:25:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b96d7a6b-97bf-489d-28f0-08d931bd4397
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4495BAA2E43277715A76D514EF0E9@SJ0PR10MB4495.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6aURWjdTDCRa4aSsXLpo+St3g/dZAJBVKV9H/Ol8lPpSAAX8K+rDGnt2mEouSOM6v5hiB7wv5oyrKEvfcvTPsSjqJgXoQa92E2xGEoUv80d8Rx79ZCdZf3NLX8HvjMGwkCzlrCpT5AosZ5MYXNQd1YABPBviELAglkWkw00cSCEV5qaQgd1R8TeaJJRdPPqRjWkvB0Zri+26IuqwNRMiyqIE+H1LmQK5mJBf+aXspiJcXNB66d7JI7QPWAoVqu1FuWj6GnHpbhUsbxujYel9azWqRIa5fqAH6zFtFmlMSR+DGC8wFWRuttp/e5dYZbmNGFJW6TXqraQGclMefQUjs6pAgaDqXZED2Lb63tgD2eTp7sAmnQ0TZ9tCcvfA3HsGwEMfEsXPe61/yATbMtVJm8zXsOKzlgrjltrpTXJiV2EFIOeYizdZpi4KU4wiLTfgBE6uefW4WwZJvys2hG4VjZkOt6YhrEBdwlFozpJiV1he27PWWpivooF0BPZ8VQqUxPUH309J/CIc+oIjHz4XrDIfAPJdU/B0CL0V24iH897w7z2ZzR2IL+w/uvQ/i8X36B/WlNTSa2P9YGKt9l/2WIYgRuArVJHJBVZr4tPZSYw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(39860400002)(366004)(376002)(36756003)(7696005)(316002)(52116002)(86362001)(4744005)(66946007)(478600001)(38100700002)(6486002)(5660300002)(8676002)(2906002)(8936002)(66476007)(4326008)(107886003)(6666004)(2616005)(83380400001)(1076003)(186003)(16526019)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GwckvubJmPWHZdrsISG7AfamA988rFAyXYzZ1tTf5r3n5XtT9HfXUCAeYNJu?=
 =?us-ascii?Q?YmsiDq26Asfths2AbaOy8gGuxRnOWyTnfjQW3dorUUMfH1svTMpojFu5PJFv?=
 =?us-ascii?Q?xMLhegHhbuwhjQdM5zqvomrtPbIHWAkEs9bAhUVX4SbVNF9lxrIizAvsdJOV?=
 =?us-ascii?Q?g09O+tDFl+ITXfwUmeTLA4zo/VP50S5Zne5Cf6KQLqdBd0btnpgNfwFHCyCb?=
 =?us-ascii?Q?mSNfJZyDFUuvPvKnIHKO6wXQuHVIe1AwxYAsyR5zVWuopvw/StnY/cM2SzZu?=
 =?us-ascii?Q?C2e0LdIyVfkDMUqa+JZ5VJ5tzMkHDCph0O41ek2hWhCIQ9x6UUku5/UKBibF?=
 =?us-ascii?Q?Ij2dhKQTgbU8p1ZFp0t2Eo1IcGjqUxr82U3RU2WsHUjCFaYmxrwUf/BSMxKj?=
 =?us-ascii?Q?JTy6POGRzeX96qjGcMut04xeH/3rA/KZ9bZJbt95lcMJv0i+UKFfWuZeD5J/?=
 =?us-ascii?Q?kXBnPLo28w90PG2Y8XJHWMr72M3OPeb+Sqpx7qVYTLwfCHfnX/G0omTgCK6n?=
 =?us-ascii?Q?8zPCHMT7dza+I6f/EyyR7RZNHW7WN3C0BHxLG5Afcc4OdOKsYa7cGAWKn20T?=
 =?us-ascii?Q?57H9DH2mCrOKrm9kvYGfKpuX0K2vvltCgycKbi0v3zQUpajuc50dKGVRSh+F?=
 =?us-ascii?Q?r1ZQpDsRmdHt/f66UUWC/p6WaCzzLwyp1dJvqGiUnqCgJqqAYilzJfaFEHo6?=
 =?us-ascii?Q?9gW7D3cyZiJiFF8nzV8qMFxndK6cMyvhei4Mv6aSO6+GpVD6I3hyVq3+m2gx?=
 =?us-ascii?Q?4A10GIELUFAtj0J+ns9umxXAXH6aAb5ok2aQroaxXbp+BLzD7eSpqz8FTNbE?=
 =?us-ascii?Q?GNHHk/n2YMxsWi9pTfdVI6BNYDHkQBfFzrPiWAhk1CfOXz5YALQH0fSHTtB5?=
 =?us-ascii?Q?rE6MTRFlil1dMEMPk4gGGxsUuI5zERMCWI5ba4+/SH4EwkcVmzALYIuVAgPD?=
 =?us-ascii?Q?aRgv/SwqtT+dS1GFEq8RNZPWWyQKbDqyr/c0GKK2h8enkLNmKnR5qtwT9V5q?=
 =?us-ascii?Q?n7JIwX/P9RUVRiiwDRWRBu3q5V6MGcLQx2rbf4JmIN5txt1bg7t9iqFUcK/A?=
 =?us-ascii?Q?OHeSBi8mGPCz8dF4TFo1eiDclCfSVDCGqmOJDB0bBZIK1WoiexXes78ZKNC5?=
 =?us-ascii?Q?z/k4gREnOgsR1vcquSVp5MFT0i4xS1wTipmC3o9O3/DUgnVe4+yZsjwU7E5k?=
 =?us-ascii?Q?hi2CCoPNpK36E+um5UKch1In/GJ053G+4NINfl1XYqr9gNXGDnK++utPMA2/?=
 =?us-ascii?Q?95HT8hJtMRhXp9sAp42NDePhAx9+XlRgIfOcPoCQidZeCTNGoDsBaXThqF1/?=
 =?us-ascii?Q?Ekws3qwvQcdVEY6hlkWmkgeNxjX9ri+YpplrLKNY6qhp6/ckxaH5XjUD1IY5?=
 =?us-ascii?Q?qgA+ebk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96d7a6b-97bf-489d-28f0-08d931bd4397
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 18:25:20.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1if2dJWK0xH6rFWZQlEhcyBh+ij2muFx31bwRPFYj6V8UDNiNBYeW2VRg2V0bBFtdujKSxWA3KoZId8YMlG9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4495
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10018 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170115
X-Proofpoint-GUID: XxYCo3Pb8tQFDimuXmPQ61yockn8sRTY
X-Proofpoint-ORIG-GUID: XxYCo3Pb8tQFDimuXmPQ61yockn8sRTY
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Rao Shoaib <rao.shoaib@oracle.com>

In our internal testing we have found that the
current limit is too small, this patch bumps it
up to a higher value required for our tests, which
are indicative of our customer usage.

Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 25ab50d9b7c2..2fd5af44258c 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -76,7 +76,7 @@ enum rxe_device_param {
 	RXE_MAX_PKEYS			= 1,
 	RXE_LOCAL_CA_ACK_DELAY		= 15,
 
-	RXE_MAX_UCONTEXT		= 512,
+	RXE_MAX_UCONTEXT		= 17408,
 
 	RXE_NUM_PORT			= 1,
 
-- 
2.31.1

