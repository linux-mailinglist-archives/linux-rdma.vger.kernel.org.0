Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A853C54E676
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jun 2022 17:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378002AbiFPP5m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jun 2022 11:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378001AbiFPP5c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jun 2022 11:57:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1441BD54
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jun 2022 08:57:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GFqaeF029748;
        Thu, 16 Jun 2022 15:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=wgD6XvtTiwsej3yKOJkknZw3tCEcaRnMFhxGaCUOZZc=;
 b=mtMR8N452gs5iGvG6MqR8MVV+w4pkbUUrIvMlDXQzOGgubkwkp/imPyThc3HUBUp2HRt
 OZhMBSSJ3Cftbq0Ks1r/LTBh8OGhfSXn9qymvWEH9H9lQSz7h/ddXUmwoj6fqxptVr/K
 /3sjN9U2ABD1iRsAkkmbi/00saFEhY68v8yy43SiZXWjGcX6lCc0c7i3723veinkEdjR
 nPxKPzCW4w3ueKeOGKY8TX2bYXTN5wTK0MDkWMwpcKOfRYnTGPbVxBnWnpO/MPxKdrm3
 rb5beHRW7bGJ7iRorTTd6ULGGNe/am/3KJ5A9RPI0/jY4AN6v3KZ62EtwhS0vu4FF8TS yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9keay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 15:57:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25GFuJC3020380;
        Thu, 16 Jun 2022 15:57:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpr2bdwms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 15:57:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juP6x52L3h/HhXYq1F/fjv0mNf09JMaOtiog2f0upWuy61z3bKMq7pbs3LhYeF14ckkg3nBxMNOk16n48P9PR0zY6KCDKiiAV3d+LpMfSYu5jTt5YAnmuY0IfvisobJEfQO+WLQD+PuAWQEVZQJKF2QfiqvleXmcTxtgDjDYtXGyBcvdXDKRXM3V6RTjIL6g+3xqa6mDuvGBzo72ifM5ot+1kn+b8Ucj4lOfY0yye7+BtrIbsSJMqLqsCL8lmS3eZhsxCM4Lz4hgqyJlfbr+P1X8gEBZMbBjxIhF3roRQyW4rBhoe8u2UhZfOAFPtoglHDo3MddZh9xmZeQX5ewFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgD6XvtTiwsej3yKOJkknZw3tCEcaRnMFhxGaCUOZZc=;
 b=aqkTRzQ9kODzQRMGY7emV9b6uGitdZmluQ7BW3h9qbQUGgBn8ngGZ2oj1u/+PoTkyoAnxQiDUPf82xNH04bG8bluwCmEJt2YYSSwMjENyDcq1fE2fBcTwPhUUeqDeioLW6mwE8jPo4Fdu8lCyaGr+l0zBE3LejcIOVgQkKRa9yMJuOOx3XbEJxJIVjKbaNRcW0lRVUQZbtgJN5PORwXRahNWIRY6ds+eYUtjuv9jhdMwrmTF24OB8hJT6stQVwGkV9lfw023LA5MkGqwSQlpRfaBK8TO2rf02kSGRkJnjCVf0BAAyD0AtQWnmftwjQnSjkTncOcS9CVcW74e0crz4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgD6XvtTiwsej3yKOJkknZw3tCEcaRnMFhxGaCUOZZc=;
 b=fk09KwcApV4Sb1Xy2O27WP1Ljnk8n8P1dJQ9k6oHkwBybrAMqN/Qb0kOLJwdIojOAXmeoSThv2AtJ3ODP8geE+mXxx0hq1r3BYoAFWyKAcnbb6SigIN6Ut99fHAIU9pPUYu1yhoMFiZiTvNtjfLOvKi6qKHvtuvc89igu16EPVY=
Received: from BYAPR10MB3158.namprd10.prod.outlook.com (2603:10b6:a03:15d::23)
 by DM6PR10MB3372.namprd10.prod.outlook.com (2603:10b6:5:1ae::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Thu, 16 Jun
 2022 15:57:16 +0000
Received: from BYAPR10MB3158.namprd10.prod.outlook.com
 ([fe80::14b1:58c6:71b4:6e7b]) by BYAPR10MB3158.namprd10.prod.outlook.com
 ([fe80::14b1:58c6:71b4:6e7b%7]) with mapi id 15.20.5332.022; Thu, 16 Jun 2022
 15:57:16 +0000
Message-ID: <60b4df0f7349570fe91b94eb8861043f0aba7cf2.camel@oracle.com>
Subject: [PATCH v2 1/1] RDMA/addr: Refresh neighbour entries upon
 "rdma_resolve_addr"
From:   Gerd Rausch <gerd.rausch@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Date:   Thu, 16 Jun 2022 08:57:14 -0700
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0003.namprd21.prod.outlook.com
 (2603:10b6:805:106::13) To BYAPR10MB3158.namprd10.prod.outlook.com
 (2603:10b6:a03:15d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 743a6b68-32f5-4e5c-6a24-08da4fb0e29f
X-MS-TrafficTypeDiagnostic: DM6PR10MB3372:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3372EEBB4AED73A51266DB6787AC9@DM6PR10MB3372.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M77pS5oJgwi7/ROM2nnYzidWfK5D47s0Qtr4TMdyiAN8Y0yi6RxSTaxEalBEL/4ZsFE79kJc+59sOrtIYANzcD1jwoOEk7hZzRqAdpwMxtq9usg7WwgKzcbdU2TjkE4bpPWRkJWDAxz0nB/JQRF5ytCYWt/s2ELp8IFX1eJvjOlm3PxM2Asw6hpznIr70fV4oM7lGOqgIaOY6E5k028F2fDySIXr9nCXb1XJzdKRj2UiF0QqE84muJY2unnqEdn2t0xnM2HW/Bz+pAl5S4js8w5nZxqnaeuULGGiAJtTSYDLUC6plAnWqw8VkMJsx191TeLz4roNBu1jOGIxkaFExFmKupaQnFsKp9X4H+eSqxi4wIW5GnxwNRM3md0cW6LS2yd1e0WLDLSIELoCMrB4vfVZMrW5c00KXeS495olLDdBxjwwP6TlmiDvJwajYxLZXq6yZTqUh0Ph4XdS1d8JC4uM4z3n9dsJy1UzkUFeI63ETZoZqULzwmgoheE5EzVfDvmN6o6dFDb5actwnnSJRR7kgnmKSfWPWheSnrabulB4O5laTDjeogKkcMvRTLV5nth+wBiHU7Z/eU6oogaOLzxsYJ+81+iWkgLQSU65YzNIHoKShnksWlDhLqZWrcxsmByAKIF7Ua8clgFTrPjqu8TMOTlltxvWp/6lakpSTBA8Dm9JObVNypu8nZnCJFQV0KizxPLgSdYgREDAe+75WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3158.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(8936002)(44832011)(6486002)(6506007)(36756003)(498600001)(83380400001)(186003)(5660300002)(4326008)(86362001)(52116002)(2616005)(2906002)(110136005)(66556008)(66476007)(8676002)(38100700002)(66946007)(316002)(6512007)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-15?Q?192a+0EcWPm9vbviYMPEhR+vBAQe1CZYQUvN5zOHPjcpYUUAirzr6OD3v?=
 =?iso-8859-15?Q?W2f6Pxs986SwPPSaBMhYf/NWBtKzHmEe73hk5VyEkHPt27+kswTSD9CcE?=
 =?iso-8859-15?Q?PX0YT/3a7sr7tQgpGnEkAIdsBCoatuwxTYI+CaEWywixA7vqngyyx51qx?=
 =?iso-8859-15?Q?LO+5Qz/22GAZg13LUue3CL8HSx65Z14Mp7xMxIJ/3WWboL6JbjbeTM7Yo?=
 =?iso-8859-15?Q?uLOwxnVcOAWaNwc6DfwBfLR2VzR0k62gCww6ZTsyq4DwCdEfoXp/sqxrh?=
 =?iso-8859-15?Q?ByAMMT5fKeOgRzJQf5PzYdygImyW8Df7D+iqjI9+0m2qawRdDPu7ATOWr?=
 =?iso-8859-15?Q?Dqy/7aaFGBXiMp/nC8dnHAAoAakCVvemiXw/26l1nqkRSb03gseUz7ceH?=
 =?iso-8859-15?Q?Q80gAl2miIchEyJjleL8+4BuhnYSefEQ/MTDbGQdkkOduNSHKqX/qK1RV?=
 =?iso-8859-15?Q?yRsoNG16uL+9XjYjEJGRZ9SE3+nUr0uVFfDoeTTCxZbpofGNE3q8hfMEv?=
 =?iso-8859-15?Q?h4fS+qprxTwGW/+SDA2a8v6fiNCmrtJLKWH43s8B+P0XZ/Q1IU+ItLSSa?=
 =?iso-8859-15?Q?iWH3mWghvYhZTn7NAF+mo2w5bnW8njCRrKEX/h9sk/mQaCMHg9kwD4S2Q?=
 =?iso-8859-15?Q?vFKH4xZFIwfMcw1b5QJf6R2j3dwBN6PDsFt6dvGQkGxrrstLEF3Mp/v34?=
 =?iso-8859-15?Q?lcmxG4bkUqiDwgnUsXrmGfCuV4wpeegL5i3lU+3xvInRhk/mgh0i0XbOK?=
 =?iso-8859-15?Q?HHrT+Abb6sMQmpjExZz1YNmvphH+rSABcIZVFuzellyLqTLEQERY0qffJ?=
 =?iso-8859-15?Q?t44jWkzxoYrm1kur1jWRD2zAwQp4CisRf5dit2nSAIxHT5iMhy8izuIfF?=
 =?iso-8859-15?Q?D/wm3JnBdfLtl3orrgZjVBaPpcYLmmO8bpoEln2lydTW3oY+Sredk2cnp?=
 =?iso-8859-15?Q?NmClZY1/OxOnENrXOJdfZY96bmADS7PaHUsBROHquSuIWrcX5u0OjToS5?=
 =?iso-8859-15?Q?oGU9n7sIobF7NYMwehFzNoTlHWLrrTok5cNyOYAmTD490Uu/4pArnoVfM?=
 =?iso-8859-15?Q?271OLLieCO4CBTEdJ+uieSKS0/bLNkaF0BgiK2MxseughT1VSIIo7HXKP?=
 =?iso-8859-15?Q?VTUGDN4VB4UYXBhukdWebMBZVRdCsByzqy59KrnDIUVhAoVq/BKwd23Jj?=
 =?iso-8859-15?Q?549go+RTC3ZfAgNYLcGbOEc7rZ5ByWFYsmwIWA+ivr1dTV2OEI7JCBYBJ?=
 =?iso-8859-15?Q?hpaWpjcZ90fYHAhNIn6A5f7XANxCNh8eEogTSL7O1zAJIfxTXZxX9AxAY?=
 =?iso-8859-15?Q?NmMcvwYnILU1wumPMmch8WEJStKIj3yXyPJtGBcq3NJRcjdThrbwXSr+B?=
 =?iso-8859-15?Q?HD61snBT3ff1RkaCRxaefoRQ/OJh+vGVIWkG7glwgchcrcbaUO8wpEh2a?=
 =?iso-8859-15?Q?KIetOoDB1I/DwyYsz+J7XxYuPDJFAzepq9SUJVD+jxX/021npEF3hUCpW?=
 =?iso-8859-15?Q?36i+S0Zi6/wQ4EUWzDeF/heRj0FNucoyobbufSMiS6Dzjf3WaqYvDE5qj?=
 =?iso-8859-15?Q?nRSVskDj1ATZAH3f4tUKTvfaSoOZelyEUqFk8U2gmVsm66aWCFoK2ts2X?=
 =?iso-8859-15?Q?WJHLnVvm/35txsKnf5pf8U/TZEC6Zptf7/C8fYKWIOwQwRX3M3tJOhPZ3?=
 =?iso-8859-15?Q?VvrFmGAeAPO2HdPhU5OtqObqeCV2HrqiDzxgcMRgdv0xQquPH8r6B7d/2?=
 =?iso-8859-15?Q?zaq9LQCqDUSmKJxhfMUca0uYPrVVH9/gfcRlyj6d5hl6eRV+CHbteecZw?=
 =?iso-8859-15?Q?pf/GDjhI4ijkW1sH2Rh+tsPQEhFjUECZS5S7tXI58qi62Ko1JJQGputhH?=
 =?iso-8859-15?Q?xuYXO8IOdWcd8uHyXy+sBLI0E?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743a6b68-32f5-4e5c-6a24-08da4fb0e29f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3158.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 15:57:16.2220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdPGbmkPjWKdUID1UcoJOAPE0N9dZMBJHDNgUJhAl0FzajwIznmvQ99emRSFoptcBylTntdvj2qVYGGwtwM13Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3372
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-16_11:2022-06-16,2022-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206160066
X-Proofpoint-ORIG-GUID: Y1njquVW_J3UvLP3x3hRm6DOEgx1M8KO
X-Proofpoint-GUID: Y1njquVW_J3UvLP3x3hRm6DOEgx1M8KO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Unlike with IPv[46], where "ip_finish_output2" triggers
a refresh of STALE neighbour entries via "neigh_output",
"rdma_resolve_addr" never triggers an update.

If a wrong STALE entry ever enters the cache, it'll remain
wrong forever (unless refreshed via TCP/IP, or otherwise).

Let the cache inconsistency resolve itself by triggering
an update from "rdma_resolve_addr".

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
---

v2: Add a "(__force u32)" cast for "__ipv4_neigh_lookup_noref"

 drivers/infiniband/core/addr.c | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index f253295795f0..704dc9cc130e 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -394,6 +394,8 @@ static int addr4_resolve(struct sockaddr *src_sock,
 	__be32 dst_ip = dst_in->sin_addr.s_addr;
 	struct rtable *rt;
 	struct flowi4 fl4;
+	struct net_device *dev;
+	struct neighbour *neigh;
 	int ret;
 
 	memset(&fl4, 0, sizeof(fl4));
@@ -409,6 +411,24 @@ static int addr4_resolve(struct sockaddr *src_sock,
 
 	addr->hoplimit = ip4_dst_hoplimit(&rt->dst);
 
+	/* trigger ARP-entry refresh if necessary,
+	 * the same way "ip_finish_output2" does
+	 */
+	if (addr->bound_dev_if) {
+		dev = dev_get_by_index(addr->net, addr->bound_dev_if);
+	} else {
+		dev = rt->dst.dev;
+		dev_hold(dev);
+	}
+	if (dev) {
+		rcu_read_lock_bh();
+		neigh = __ipv4_neigh_lookup_noref(dev, (__force u32)dst_ip);
+		if (neigh)
+			neigh_event_send(neigh, NULL);
+		rcu_read_unlock_bh();
+		dev_put(dev);
+	}
+
 	*prt = rt;
 	return 0;
 }
@@ -424,6 +444,8 @@ static int addr6_resolve(struct sockaddr *src_sock,
 				(const struct sockaddr_in6 *)dst_sock;
 	struct flowi6 fl6;
 	struct dst_entry *dst;
+	struct net_device *dev;
+	struct neighbour *neigh;
 
 	memset(&fl6, 0, sizeof fl6);
 	fl6.daddr = dst_in->sin6_addr;
@@ -439,6 +461,24 @@ static int addr6_resolve(struct sockaddr *src_sock,
 
 	addr->hoplimit = ip6_dst_hoplimit(dst);
 
+	/* trigger neighbour-entry refresh if necessary,
+	 * the same way "ip6_finish_output2" does
+	 */
+	if (addr->bound_dev_if) {
+		dev = dev_get_by_index(addr->net, addr->bound_dev_if);
+	} else {
+		dev = dst->dev;
+		dev_hold(dev);
+	}
+	if (dev) {
+		rcu_read_lock_bh();
+		neigh = __ipv6_neigh_lookup_noref(dst->dev, &dst_in->sin6_addr);
+		if (neigh)
+			neigh_event_send(neigh, NULL);
+		rcu_read_unlock_bh();
+		dev_put(dev);
+	}
+
 	*pdst = dst;
 	return 0;
 }

