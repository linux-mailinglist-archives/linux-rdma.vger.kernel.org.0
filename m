Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C113C5C24
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jul 2021 14:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhGLM3n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jul 2021 08:29:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47646 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233028AbhGLM3m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Jul 2021 08:29:42 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16CCNGJR027762;
        Mon, 12 Jul 2021 12:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=nPL9GAXtRlfciMoN/+AWdGirYzSQ3Lj5Ad3nP/ubmeA=;
 b=gl3nhTqZMWL/BIYKZocfIWXwQi5JAE9AAyS0rW/xrT+IsT1xlBKCGQqJYKrBQaMoF+SK
 P8DZN2vPErvCPqhTt71etuPYSMvCYQKqt3MudlnVe6adKARbKD1qTyXm8Vs09D95C9lF
 7efTPZpx3aKfZ+W37kdPqg8+Ac2DIK79L5xMM2VB5EV+ADU6+5NijSt8pmNPaBjLlAsJ
 taUbD3kpv72GZ37o4pNx32dVou5ocE9eQOucIa9XnNLwU8B0cXHqTZHd6P52LN31+J+i
 FfXnEjnw/KNvSfCGi6NBi2XrmW9UjpKPMRgoi/WOsCt5+Qz5zBLzdzCH0CrI0cgNWe2m Og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39r9hch0y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 12:26:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16CCKpGn028598;
        Mon, 12 Jul 2021 12:26:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 39qnatuwy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 12:26:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ST2MhC0EzHWhfUwpSZOcX08vWlHqACl6Vcl1d+NxotRQg/YVpsFs5/GMRnGlioWjk0x1gICGTKobXLSOoUSYA3pL2pHFzzjQpwBzVYtJAjx9LxqWuqoeRRDFbF8inb+Ziab3xOXXt0MQxVxabxBchN0gvi/fbFgRsYrAAj29etyJ+dLvkyO/oE0qoCerzoDGVRf6gyyaaYdLi1yp/kUl9CEDAEvOLt1HWAc5eXBPt+abpE+uZcjQD2PFIHvjcuFdQa2knHqvwmYm9ApbFYXX5T+TlpKj8n2Xo8em1bGDHy4yX4xVnmK5RvfV1omYIozXkxiM371BSPAuQ6A0Y6UKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPL9GAXtRlfciMoN/+AWdGirYzSQ3Lj5Ad3nP/ubmeA=;
 b=Du5pA7ZHVGXfE/Nvqt6JXfroRcLASJRN3kvOLyM8XF/wTYj6ZPdYGecrgYwWKK3sUcEScydWeTNYz3dBn8hv1AcfzeUkOvGvKz5PaKepM9uy5XhcWNxOAhBag+BJDTF6PIytV/a4MHCamDABD2wvUuNS19uybJlbaTyJ2baVC+Ye4bf8At4ETYxYwUkcmlcYx9FJz6SW9SHbDmazqVRYqs8pAkSEqATp4FY4R8qoRfdvU2tYg8SkzNFEd1Htp66+SM7r6PYxLFqEXXYBZlB9Q7wl94P0h4nl181JxUBKw2yaw2t3a6z8FdlWyVPkInwJQ7B3nOd+vUEVcF/DXUM3rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPL9GAXtRlfciMoN/+AWdGirYzSQ3Lj5Ad3nP/ubmeA=;
 b=RqWCEtpaGE3UWZMRi73yEdLmoATV+3zZ/C65SWWRDNqUnHLye4AJGwUnFTBr7sb+6g9jYL0gYI+uLzTP115XLukQ7FSWE04AVVROYB4TGGU1lUvjhVDl6yEQ7q74f7CpEva16Hwt2RDcyMAPIg0H0f6lJ3uT4qWA0lIEZqYMp4Q=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39) by CY4PR1001MB2262.namprd10.prod.outlook.com
 (2603:10b6:910:42::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Mon, 12 Jul
 2021 12:26:48 +0000
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::9dcb:26d6:7408:b4d5]) by CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::9dcb:26d6:7408:b4d5%6]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 12:26:48 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v8 for-next 3/3] IB/core: Read subnet_prefix in ib_query_port via cache.
Date:   Mon, 12 Jul 2021 17:56:25 +0530
Message-Id: <20210712122625.1147-4-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712122625.1147-1-anand.a.khoje@oracle.com>
References: <20210712122625.1147-1-anand.a.khoje@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8015::10) To CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (122.170.228.204) by TYAP286CA0005.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8015::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Mon, 12 Jul 2021 12:26:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac9b8072-f781-435b-f5cb-08d9453051c4
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2262:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1001MB22620A0CD213BDD0B2F6D12CC5159@CY4PR1001MB2262.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O0fFlVNL3EkLSZTU4gJnonv1WLMzZwZjqiTAxdWSSPoGXEoW8c1hk1TTBUy5siRyGQE3GcFHsSO25WI/p7UIHlFP16//SdfgLTRCq+JLrOA1ocDs8bPAZRp/r/09lD9KoiNuGVwQYMfur1/AZ6yyqJWUgLudPB3WikXEhMMZGk4131sHrnMUA8ZG/wpxDWsG3vegYfBVHYPmdYPCHL+7LRfTcvlVcTwIhpiUTJYeWWye2feXmgZNvdqExWLRPNwTxJhPVKr3/NAy2uFJrVJXBKRiH8z9VGH/6dQYp9iZK4xZBb0a57T7z4u75UwaTZyK4x3s6VBy5usBhkVkx93IbE3tsp0X8O7dpWmZB5KxeZMCYK2ClngHiEOFvAVR+JdPDOWzRGfRfbuv96Xodqvg60GMRnsq1R6AoVl2RREiMv/F4LzX0i795Cminz6KTaelua1eQ/InoIoOPUNlpPcEDzfMycA7Oqy1hYRq7CaMxxFQDXfG/9ETYoz+WFfnGtuDCmcpe4xAPt9tphHUwacW5DGehr2u/bPB7casCV44E1fZ/u69xw2Fy93dwmBfqGLYYnp+VSFM2CBj23a4MqSoROygyIBKuOAUgYFsqriGJGBOzjharLXX1mRt3mtPOMiWqKgzgVxTXm34ke0pkSBKqX2+wCs/XfTMwzoHQ1ND4+D4l0rHDOqYhErgsj5g4gkDvsxeZCLrTwjZxj+8pY/ORA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2086.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(136003)(376002)(38100700002)(38350700002)(5660300002)(83380400001)(66556008)(36756003)(6666004)(186003)(26005)(55236004)(52116002)(66476007)(478600001)(103116003)(1076003)(4326008)(956004)(2616005)(66946007)(8936002)(316002)(86362001)(8676002)(2906002)(7696005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xhNeym7Aie8zZ2PBEukDQU1/edS0BBg/Dbcf5KYVJB9K6jsG6bubvySt/A2Z?=
 =?us-ascii?Q?l9Te/6/2Gx8zjkVheCtI4H25PA+t3wdEjPsApHHQFNXI9Z6CYVeh2dCYhscR?=
 =?us-ascii?Q?xSuBn+qn15rMWTofsxhUhsw0/ZmvmnH0Oy4jy9nWzFssYV/H8YteD/leqdiQ?=
 =?us-ascii?Q?6iqiN6jsmkhiNrNipRuhJO3h9pci5de4Myn50RczPOVHMqKtAn+lkFQaVxTe?=
 =?us-ascii?Q?zcherx+0Lz4Hwv0A0SnL8SGzgjebwCxrjnp1OKZGCntgmVyrHtYxeHHQrbRd?=
 =?us-ascii?Q?vnYgXEZXp5Sc3GGSG9Ed6vrPPxIlXoQ5vhIvRJYvltJBnNSgA5JDAnfyt3Xi?=
 =?us-ascii?Q?LQb9JKI7teklQpWBPbtTJZMtJzkiWuPk6FricQ4KW54y5z3u22F5t91/mROU?=
 =?us-ascii?Q?dsaFiShUKnywOObRwEJcY+O89mfeZYuFh0PjfZqazZIwYIx8l28os0IBpfTA?=
 =?us-ascii?Q?wFEBesevj9YZmF1yD/O8fpLN33tJmla1TzG6EnTd5KFejIAmlko2gpv0uXaP?=
 =?us-ascii?Q?01c+lBSW6IX/Lke+p1PN4eOb5qOkUaqW8Y9b0j+tDuZbtUzg2bjvFjpLlx3N?=
 =?us-ascii?Q?JL8ZeFTe5MenTVhY82hT0mr5HUJ9yr0XdaB7SDFnnHIn4Vtxovod90speO+g?=
 =?us-ascii?Q?xg0kwtCeUi3eoGgwib/uap//VYTCEkzAwZ9NemqWx3uGtUmtNd27D4CO42y/?=
 =?us-ascii?Q?GStLlko0UjwEbhRJuSQmejj9bxXwoI4w1Lz+XFlMwWrhyIbiuBjHRq/NYRIJ?=
 =?us-ascii?Q?MXLlf0v75J+BMWa8vrNvnUrE9ChIyCu/B1d5d05CwuX9kJA/g519Y7hTl1Xd?=
 =?us-ascii?Q?wzA02sjgiSmjjhpUDZPrDAbdeudu3VWtV7hYyhrBcBXXuHKcw5edYJkZFixI?=
 =?us-ascii?Q?8G8sBNpFxEzB1mX5S2d66JhpxoD3xWGPvGoTsHwtgfCgf55jBOHjbgrARHuv?=
 =?us-ascii?Q?jQ6XRZXKpEDm1aqLKRHu0dnQfpVfpaooASzd7BulWhhN8HCVphvLPUDQCwoC?=
 =?us-ascii?Q?pbJEUEdLs2dKp3PfZ+r+741dR5SOica8ufBCLZ0BUVswrX1NnhXcVLrEyXaU?=
 =?us-ascii?Q?lBEZ62lJZ7VaajogM29v72cFj7zYH0oXx4H7+iLWs/+oAWZKycnM+uPIQMIc?=
 =?us-ascii?Q?FHLyqyULQG2+JlY/QKnSua4SBL+j7kMPSspz31bdK5m403hxbHJEZ1GeNfly?=
 =?us-ascii?Q?hwMuyscI1s1nh0rRhBZ0hgMvGKq9iIzkvzr1qoLYd5CJtMYIx6+a+Xz16Z4f?=
 =?us-ascii?Q?4CB3ZI5b9U7dOjw4ueT/qT7HTkodah6qySwbX0X7zIS6Xl/QkS05NQmkLpHu?=
 =?us-ascii?Q?qTcuoZpVfNNyP/GW1TnJOji3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9b8072-f781-435b-f5cb-08d9453051c4
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2086.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 12:26:48.6142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AIJ4gfSzWXnOsZvQmDA2ycBDE9vVc9axYn5EAUqYKZDpBw/1PYUwwejmKEy+dZ2L9mqaROowzxbyybjpZiuOfLXY0J1BQDkwrNv8+6kvHiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2262
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10042 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107120097
X-Proofpoint-ORIG-GUID: hEbnMwGRPH8gCnpSl3rTDWywQPOEzzlH
X-Proofpoint-GUID: hEbnMwGRPH8gCnpSl3rTDWywQPOEzzlH
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ib_query_port() calls device->ops.query_port() to get the port
attributes. The method of querying is device driver specific.
The same function calls device->ops.query_gid() to get the GID and
extract the subnet_prefix (gid_prefix).

The GID and subnet_prefix are stored in a cache. But they do not get
read from the cache if the device is an Infiniband device. The
following change takes advantage of the cached subnet_prefix.
Testing with RDBMS has shown a significant improvement in performance
with this change.

Fixes: fad61ad ("IB/core: Add subnet prefix to port info")
Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/device.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index ba0ad72..9056f48 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2052,7 +2052,6 @@ static int __ib_query_port(struct ib_device *device,
 			   u32 port_num,
 			   struct ib_port_attr *port_attr)
 {
-	union ib_gid gid = {};
 	int err;
 
 	memset(port_attr, 0, sizeof(*port_attr));
@@ -2065,11 +2064,8 @@ static int __ib_query_port(struct ib_device *device,
 	    IB_LINK_LAYER_INFINIBAND)
 		return 0;
 
-	err = device->ops.query_gid(device, port_num, 0, &gid);
-	if (err)
-		return err;
-
-	port_attr->subnet_prefix = be64_to_cpu(gid.global.subnet_prefix);
+	ib_get_cached_subnet_prefix(device, port_num,
+				    &port_attr->subnet_prefix);
 	return 0;
 }
 
-- 
1.8.3.1

