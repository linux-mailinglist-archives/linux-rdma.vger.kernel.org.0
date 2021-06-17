Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E633ABBBE
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jun 2021 20:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhFQS2f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Jun 2021 14:28:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9694 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233818AbhFQS1r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Jun 2021 14:27:47 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15HIBRRH032235;
        Thu, 17 Jun 2021 18:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=3QVKnTBviTaqz08Vsx3NEusPLRN+pJjFaicr2fZurmU=;
 b=ldfhArrTj4PHdesIDfzm3IWUR3LydcUhDbq5dTD1MOwtHu4mLO1qDa1/8Yp0VJVWFK9o
 jYioY1NR3f8xYRdCiue3GbaL04df5JGcDVbhQ9y6QQE+abBu8xFVwsYlNyiy9EO6/r4m
 PrPuksQec/GZ3LIKUBX6rL0JkVR5Zflt3r/XyTJWmJDZEc6/4Rx71tCh1ItKkA3yCyh/
 uoredGVb8aT5E6wt80NNWXzyk5ib3UEi0AwkyokcrDQmSAaEstiSkrxTsLE9v2Tp+BAM
 svRfXUbbRMMz8nR8Q2t9YA86/ItI+VWkoCyjodLnHjyfADzvoNApz7OcAnmpQfdP4QZf Zw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39893qrbcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 18:25:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15HIPZFs125130;
        Thu, 17 Jun 2021 18:25:37 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by userp3020.oracle.com with ESMTP id 396waxxj8w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 18:25:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5GCjtIGs2QPAer5CSCKD9tCTfmBHGefr/uvT+Htvng2L4LOaa7PI2JR9aDcUycRfFGPN6dGiVrOj7T+nd7nDKpSox3aECZLRGfdGqCXSrHlQcxtyFghdKxKuBsa7rv5pMpkjNxrG7PE/nfkMI+un1EVZXxnlSO/63vcJlyP86p++HNQnSSdXjklMiED3TQ9ZLyQgRrsJtYatd/ucsAJP1UR9lF0a+4XFWH5kQt9xuwSUiNbn1RWY3S82em+U3zJ+fXo0WcRmPnqvGl9uF43I1rs6jJIx/ekfnZBbb0W1uDvUyQl3pb9e8e6aFlq3CM3VKrBK8bLylQ2csZCU9ssrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QVKnTBviTaqz08Vsx3NEusPLRN+pJjFaicr2fZurmU=;
 b=it1JAaZ0OxIU6G+OSC0UbctHm638iW1jzxuCPVbzXI++IIvAhY6S3ns3vAhQk2NGZLa33sh0V0s6/nD86uRUl+UkpK57g8zCp8LiDYlxbP6dn88bW+D9objKy8/T6FKpLMJz4ai8Ss3GS/0VLe0f8cdli9IukJiPK+Gah6tmycZ1MVPALcvqMO2r65Iq7tasxaWsozK+xU3UcgDRXCtTKGrkx9YLDSvI/p4e199OgoV/96a5W7GPxmZQ0YrtFt9uRbmT/2jcVJBPVyTl8HhoFvIuFtxfIit4JYDnXlPeUm0GHgWw2GEPdT7OJBVC7HK+6jhqNmYNgg57IQLgmzaUPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QVKnTBviTaqz08Vsx3NEusPLRN+pJjFaicr2fZurmU=;
 b=CKtzSu7m1oUBZBWxhCcntAjjw9zK2unsG+lvxAHq34+CEdfvsr8lOL0PSZM2jPmK84QcGPEbcVTQKypJQJD3ffli1+Z9iI1CHq4h93CGVUty+IcP3T1//XmFVzvX+o2tc5sbaIRpIFb1mjp52cExTX3IwN9bO9eshIiwYZHwTvY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BY5PR10MB4131.namprd10.prod.outlook.com (2603:10b6:a03:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 18:25:22 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::cde8:567e:da77:abdd]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::cde8:567e:da77:abdd%3]) with mapi id 15.20.4219.024; Thu, 17 Jun 2021
 18:25:22 +0000
From:   Rao Shoaib <Rao.Shoaib@oracle.com>
To:     linux-rdma@vger.kernel.org, jgg@ziepe.ca
Cc:     rao.shoaib@oracle.com
Subject: [PATCH v1 3/3] RDMA/rxe: Increase value of RXE_MAX_AH
Date:   Thu, 17 Jun 2021 11:25:11 -0700
Message-Id: <20210617182511.1257629-3-Rao.Shoaib@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210617182511.1257629-1-Rao.Shoaib@oracle.com>
References: <20210617182511.1257629-1-Rao.Shoaib@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2606:b400:8301:1010::16aa]
X-ClientProxiedBy: SN7PR04CA0084.namprd04.prod.outlook.com
 (2603:10b6:806:121::29) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shoaib-laptop.us.oracle.com (2606:b400:8301:1010::16aa) by SN7PR04CA0084.namprd04.prod.outlook.com (2603:10b6:806:121::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend Transport; Thu, 17 Jun 2021 18:25:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abf3e49b-a61e-499a-b9d4-08d931bd44dc
X-MS-TrafficTypeDiagnostic: BY5PR10MB4131:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB413106B52DC346A4466E8CFEEF0E9@BY5PR10MB4131.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PA694ymi1MTOqLfWw5Lqa26Z3+WSYFS3lu1btt81bbHdjAMzD2ehcur3tdfchFEhGr4RXs8O3jEiwMg+OR6/dwuyswgO37Q0YOJJHrY449tl+lCHw84vB/ilUQTBfJjtdNu7TZ6VlWoFB8OEiMRcjsFEs1OxCdIguJRE5cHnoWnJiQT7KDR7KPCmRg3XwoYaI+fc1VyiouSBNwLwclEzUjkn+p0+osm+EGx7Ug+fzVVC6X6HKuvDwFbUpaUtWjXKIxftCHNPdkDiygkNYiS7GsDovuXqObW4doqusLVBkP2/WQaM6aJm3cGKQNGj+g0wsyK2IkuDcU3rI856UH9L9IOZyRG5MEOQ1qYzr26UohLCfnQgLgzbFbIM1//MhNoHh7bqbAj/P3HRBVQLYhT6QRUF2HKY0zGS94fZCFCM7vPevRjBb8DA3FqQWyoyAsNnO3idhbpr/hNOjkDwI5YKdj2hoqBJ2tnJOvPYHdkKkExN9EoBkPtlgbyLcH5vYadpAf5vyAuiKS7+w0kGjjkCxA2hXTsGrjCy2gytNrQF5WN1oxPpx5h+MjkYPsW0cbhBpwjwgI2cYuWR4lXevxmMj4NGWQBQ3O1tEQB1WgzxCP4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(376002)(396003)(366004)(107886003)(5660300002)(6666004)(186003)(2906002)(16526019)(2616005)(4326008)(7696005)(52116002)(83380400001)(4744005)(38100700002)(86362001)(8936002)(36756003)(66476007)(66946007)(6486002)(66556008)(1076003)(478600001)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qDZtaJXow3Nzd8xvt1vNcKUPMtvwMnuT+03GEvzEZ3nd3/nR1l4UWDKAIM18?=
 =?us-ascii?Q?W0VWOoihb7eogJMXfbtRsCZWtWV63qHKfc05s9KlebugC/AEXm8y8CjDCQ1C?=
 =?us-ascii?Q?6FEBkhwK24QfZ7i2uc6bOpzZIc2smSvkB1fFNf+kZnwkXbdfbKuag4BWhoQY?=
 =?us-ascii?Q?XnIqeTGZnwFmii8EWlLg9SyAmmUTIfGnnOZdEeGyrbzb09Yma4deJSXZldAh?=
 =?us-ascii?Q?mcyicoGBOZJaRKByLezczkpMJF//NKXnfvJacmrtPKDKivwbHnFvBj7eNzKE?=
 =?us-ascii?Q?RvvGhrhEK0R+U+fkxxQs9uv7LYnBtCnzubQG0spD24Cvp6sg7SOJhPOPrq+j?=
 =?us-ascii?Q?4+N4Lp++g3pa+AnQX881MTS53zANC7JCfEe6A4kEIk42Z+nHfDkbTBrhhim2?=
 =?us-ascii?Q?3shEfvvQBnMTV1//h+yrxDAX+1Su/qlq6V5Hu762QbTrl3mrGSX8QocmwXRl?=
 =?us-ascii?Q?RucKhQxGi9E/WVXhnf86Mea3JqN4FPVEXIJ0MYENOQTSWeJtFxrdfW4SuZwe?=
 =?us-ascii?Q?PvtWCn0rjDwa3Yp88WcUqVaQjQGjTZS2A+hqWy4Egn9k77eOptRnnDUk2N4H?=
 =?us-ascii?Q?Co0MVVvp6XrFLW8fsHlDWKgdybts966Muvoj0FI+ly+YVsEWOW6Xi/mwP5xs?=
 =?us-ascii?Q?zsl/uCb1I9P0Vl5VHsDLB8c182uQBk7SLm/oOmIlrHu4+9PsQzkjsMHV8mnC?=
 =?us-ascii?Q?jzZDoDIJ5jFPWkjLX5+MpJpi0jP06szrMELW0CzU9p0enNpl/TiRhAX7NdXR?=
 =?us-ascii?Q?8zZ0iw8VUyLzoM8PzNdH6EMBEy06JlR+1Fr7007+CYY5mk/Saw4Hwj+HCtAE?=
 =?us-ascii?Q?ViGlm+KXa8XRRezhPNiOc3r1BmDn3xxi2P6q/bV6161ViiTts8HsQESFUOPz?=
 =?us-ascii?Q?RwSe5KAJh1ZiLQU5aLWlWqjDUbqkK7gUmxEt7s5EONUyS5GdcpYBHqXcUPcb?=
 =?us-ascii?Q?fU79Ug4SKihxvNTeh+wm9IbWwb+4+nvpiovGSGKc23tKXEFlI5jRxwhQbF56?=
 =?us-ascii?Q?CSjASYExNrFVNPpyXWEvWibPQy8gqiTUlJq7EwxI9n42p1FuVdRanyf1UeUf?=
 =?us-ascii?Q?lfJKIaRRmFw3oQ8RHEjVs8CwZyJ9t69QzxefEHvZiPCzJ6Gs1vDLjI3K70if?=
 =?us-ascii?Q?iAr19Rp+PeaBYyKqjru7z1loBic8tcnfZZG1ygQZV6NP86ZNs2U+M8n5bP37?=
 =?us-ascii?Q?w9VQknXRvSw0Zw7rbgRKBc68bXwTn7foTkOpUBljZOtWkGXNsA1GTJ6UpRha?=
 =?us-ascii?Q?Qg8Z5euCJ7IUMwtdUxwBavC7r3mwI6Fz9Nz8N04k+8QlB322gP2yv2Mc9IZV?=
 =?us-ascii?Q?mfuC5xoikZsKiCZbCOGEIA8QEtqtLEzPnxCBhGwLojemJN6T4ZXwaoJIVMyQ?=
 =?us-ascii?Q?c8gPljo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf3e49b-a61e-499a-b9d4-08d931bd44dc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 18:25:22.5393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54KP4r45a6cVg0BKW9mCasbQvaTHnFcWFonDrrwFPRektHb+xeeGukt4Atrln1c4U3p1Rvd7Dq2qPEkpZ9xyiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4131
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10018 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170115
X-Proofpoint-ORIG-GUID: 16d2T0D7v-A_7fCx2sQMvMBo0pwN09dS
X-Proofpoint-GUID: 16d2T0D7v-A_7fCx2sQMvMBo0pwN09dS
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
index 3b9b1ff4234f..d375f2cff484 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -66,7 +66,7 @@ enum rxe_device_param {
 	RXE_MAX_MCAST_GRP		= 8192,
 	RXE_MAX_MCAST_QP_ATTACH		= 56,
 	RXE_MAX_TOT_MCAST_QP_ATTACH	= 0x70000,
-	RXE_MAX_AH			= 100,
+	RXE_MAX_AH			= 64000,
 	RXE_MAX_SRQ			= 17408,
 	RXE_MAX_SRQ_WR			= 0x4000,
 	RXE_MIN_SRQ_WR			= 1,
-- 
2.31.1

