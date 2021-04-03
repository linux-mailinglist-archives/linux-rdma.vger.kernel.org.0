Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB263532A1
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Apr 2021 06:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhDCEyH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Apr 2021 00:54:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48860 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhDCEyF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 3 Apr 2021 00:54:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1334qgU2057828;
        Sat, 3 Apr 2021 04:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=s9k6TQZ+88BTvPkUL8syVOoVm+0P0bmKfiaxFKklAfg=;
 b=gF3U6iet/xnWpXmhjrds7Ot7EcsdwmAgemi2dd9ltYQsoxj7rn2+0uoX8QzhPAXnsDf/
 EQufqg1k8S/QchxrJyzNyokQ5hYYLbw254XIz++na1d48a9NofbbA+p4ReYxo6cj5dX2
 wDbv1cQiyiCpjFS7R0sDT55Hoty17zBlIicjj+HSPrdO7v6IOZ2Xs14PxP026eLh9xNJ
 owSqB/lOR6G6lND/cFPh6gKWOcrjo+jbYLp0H4AwPTy/jodShwzW2/iazNXhqUPdrqzy
 bppFCn+OSyuTgesTD2/dJNeVu3N1f2PkzpmCPOEYraV3FQTovNlGEZEUq92WeSd/1C/R FA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37pgam81nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Apr 2021 04:54:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1334p1hI146372;
        Sat, 3 Apr 2021 04:53:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3020.oracle.com with ESMTP id 37pg611y6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Apr 2021 04:53:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RF2yskH8elrzNUVBGXuLYCt6ExHC1ORLPQSZQtckADI+0Y8bHeBNsY9kiNwH0GmsrOlUoC7kKSdB4KEj+EHrvOLMn3tjMbLnIr6BsEoyMpBpFeplXtPwsxzTSPdOVRRLy85fR8OuSVWDfXMnGU/Hn6Ly7LlaqONn0HOxtWGWpliAQUDrNJtv/9hxZXpu0hEsLputZTViWiDviPx4465dAZhN0L5Z/9oLA2EfW18vIUoov2NhlKYU4ZQft1IDu4OVz/yP0G8mL2OLuvXxi4E/O9QSbTghahSj8Z2dCFGR7i2sObuPZZqHoRwx2m1o/4PhK9wEBvl2aSi9sw9JJ9GCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9k6TQZ+88BTvPkUL8syVOoVm+0P0bmKfiaxFKklAfg=;
 b=lyvihyOyLsI9Q5TjhJhAHc5NXise33LiJH7CGt59kI7q0cS8KdycrKTCyfp6Xj182jxkCDanMC35TKrqMhxES/wAm1YS2eZDAdPPkV40K4ySgZDDMD3If4KTQrWoPpP0LC3BGbKqgyGdIUcFxCKd5oZtpWXW+eEDVg/uuDdeKfM6/l+hJbKDGlOLUlWWCczXhH/7lzWhp9UzBW3c+VdjlhS7QPUn+A5pLqYIlEBnyiir++CAhY4LiOYQEKs0WiwRh54dHEk4UQbfmWqyqBD4iEG9DA7l5pMcN/3ALIIut8WIQFVCKYHuAT+NasMJ/iy01P2fsGhbjK+TQ79cNQGKnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9k6TQZ+88BTvPkUL8syVOoVm+0P0bmKfiaxFKklAfg=;
 b=jVXVgAGEtqP2Iw1iS4n/Sw9+Z4rEHI7AlagWTdOMaGWA5Of+A9cZHLSlBWvwrbu/A3EbQT747Oc+E1SY7r7Ncoxh6m9mH+OTtUXxpb4SE794MzevaxTbIStqffkvZVMa0dNM+kdmUlryhh05a8vJi2Hoz3Ul1JEPof6LciaLFSU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR10MB1448.namprd10.prod.outlook.com (2603:10b6:903:27::12)
 by CY4PR10MB1894.namprd10.prod.outlook.com (2603:10b6:903:11a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Sat, 3 Apr
 2021 04:53:58 +0000
Received: from CY4PR10MB1448.namprd10.prod.outlook.com
 ([fe80::69eb:33a1:2d07:8554]) by CY4PR10MB1448.namprd10.prod.outlook.com
 ([fe80::69eb:33a1:2d07:8554%5]) with mapi id 15.20.3977.033; Sat, 3 Apr 2021
 04:53:58 +0000
From:   Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
To:     leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rajesh.sivaramasubramaniom@oracle.com,
        rama.nichanamatlu@oracle.com, aruna.ramakrishna@oracle.com,
        jeffery.yoder@oracle.com,
        Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Subject: [PATCH v3] IB/mlx5: Reduce max order of memory allocated for xlt update
Date:   Sat,  3 Apr 2021 04:53:55 +0000
Message-Id: <1617425635-35631-1-git-send-email-praveen.kannoju@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [138.3.200.42]
X-ClientProxiedBy: SJ0PR05CA0195.namprd05.prod.outlook.com
 (2603:10b6:a03:330::20) To CY4PR10MB1448.namprd10.prod.outlook.com
 (2603:10b6:903:27::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pkannoju-vm.us.oracle.com (138.3.200.42) by SJ0PR05CA0195.namprd05.prod.outlook.com (2603:10b6:a03:330::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Sat, 3 Apr 2021 04:53:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48f6b070-812b-4b19-3be2-08d8f65c7d96
X-MS-TrafficTypeDiagnostic: CY4PR10MB1894:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB1894B09E7F0D7EDB67C232778C799@CY4PR10MB1894.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tq63A2Bz3JE+eb60ZTv+IiskjDU7K4wRAFLFH0u6mGlqttjhPIapiIKN+4cJKEJmzTK+o1tuyAqK0IcNxNbafsiHeKT4Dh79NA0PGYEX0eDEqxcLxB/HlnyFKJqyTg6rA6UUjb6OARojsAYD1aEUqlBMfLc39hUIjqOH38qZqkl8Uz1yfXpHZUilNkQeYu7tJamQP1oNxQwuc+6z7HLQdClCv6c/KmZ9JrE9FnpWksTFcfO/m+nH0NdJAY4sis1eswxPRaKHY7qjcKQtpNTXAPmhb115t20iRPQi2g8qHJYXgnLQkJvs/tvOGxjJNn5xR0LO+Lh2eE0URUN1cFLUbi9KyGfRJTLPh3+nAkBrYBzBogDqqOc99YuqHNa9DbOM/uqytYrWYf+/LL+jToYwXr6dD1g+zOv/Lsj+GsL6WsXDUpzkanqT2ZIzlYWa4reay5eXm4gWk9H94xfw/bvJBrBb1UrKAQhlbrHYWFpPFBk8kJKufmvj9yfIgPtghl8wbh9LFStpq1MmNZCUya4BApEUf/kK50f6rpLnID5rOtzDFx+wNyFgDjFBKxAw/teK1DFZJq25C0zQg6lO3PHuV3qCKg38zldd5W987PgTj9+ztd4xY6vdOt+LHQm2VIsHM0t5hn+xyaegQXgeLmS+3xLoF/+dbv+8Yi3k2Hc8KW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1448.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(346002)(39860400002)(396003)(186003)(8676002)(8936002)(86362001)(956004)(107886003)(7696005)(66946007)(16526019)(83380400001)(6486002)(52116002)(15650500001)(36756003)(2906002)(26005)(478600001)(4326008)(38100700001)(66556008)(2616005)(316002)(5660300002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iTwbtjts+uiXZVV5oSFGXrDLCTJzG+gLTHw28X/4dFJqtIqFhlLZMPc/9ydN?=
 =?us-ascii?Q?XTUUI5gQ0+GEsJWkdB4Jw5b4LXhZ8SyA31qAxp7Rj3chiH9FTyREJrGYY0Hz?=
 =?us-ascii?Q?tONz+bQB3mUf2JekwRgOpcc0jscjEk7KLNy7FZGKKc98CNQe2ZbfUSCyr0C7?=
 =?us-ascii?Q?j9Qs/EtcfrpBz0bQ60mWY1sILS4A+wlMD72DvPQ5yQXaTWYWYdJ7/j+syTBG?=
 =?us-ascii?Q?nEzW2j2avhdBmCEi8SR+/rQeStC30FfaZHOjCL1sKOI5btrKTeaPXJ6NGsb7?=
 =?us-ascii?Q?ZcWa8hqIAzTSZMQZ++/n4I0ElMcbkdFIEdtuhOSDgDhGFQzMTv2yzkf9NE4t?=
 =?us-ascii?Q?w/7KwPD+hjAikb1KBC76hYg6511FV6VL7RMeh8OVPlqB2CJrQVEii/sCznX6?=
 =?us-ascii?Q?nv1i22yxEMNR1k1wTUhwO7MXItsrl2w3eGEX8DPPzIOhiEfdXerCYRNdrrZD?=
 =?us-ascii?Q?KzeV7Np/IHWV70S8CL0UL2eJnYCqV9/aeNSy0xhv9gk1lu+wxjCZnykgAsHz?=
 =?us-ascii?Q?kQHzG5jm8CBzL75J1O4zIJ4PObeCdf884yNhEAHVESB8xMr05wIiugl9+0JK?=
 =?us-ascii?Q?XJhck8ojM/B2nyt/L1LWNjxFUHRQaFYsoAmZsd/TfcNzRMKeinDPNU5XsQ6M?=
 =?us-ascii?Q?qIiQNCyjkQ/WS9MaqYtRfgy7YMWFGrczZnf9PfVsbmhNKNgQvfUio4f6sBrX?=
 =?us-ascii?Q?1fKhWO/KnTzBfdYRYoQAJQ5lHujh82r8reLNTVp0rsOlRw//kEPFhjvwpUkb?=
 =?us-ascii?Q?o0w7C4aCoMkWHLNaUlfkkZK0oPp5qgwnfgROEki5HdIYKYoaQZ5CQB0vWAyI?=
 =?us-ascii?Q?hK9sn2AivqT6FFWukUfzSr5iEeHv9Nt2YKKj1NReCAUZye4SXQF2Af0lX8us?=
 =?us-ascii?Q?e/JUlrk24E4wybu+YqDWeVfLwwAkidVGvv46tK5SCn13cKTDsYS+jZYkgY37?=
 =?us-ascii?Q?MGWwo4PCWQOOV/6mizDZ7Oiv+euf4EBfebMllk1iGu+CIiCDTkHn4aCiuXGa?=
 =?us-ascii?Q?BXDgLt8K6zB7iVBfa3nxptfiWO4hJRhWy1PVtqEXMP7WA1fXCNn6f5iVqLhG?=
 =?us-ascii?Q?ULRlF4zOQYkyBg/Wel78ukFr9+x2bkoTo3vkSqmr5zmqFWTVXjqEnkM6vVN5?=
 =?us-ascii?Q?ysR9v4ZDshHMmyOiL3+mB59cXRjIgFbDNbhu3214oJvrVxjKlTC8ZaljCpNr?=
 =?us-ascii?Q?jvrLvVoGgXcxGfOU5rDMHmJx8wRb4zDcJJz/iR/WDPCLfgaHgKMZsmhvIPXy?=
 =?us-ascii?Q?umf/OO6jTR8nAfsFEkvrfPfgDYvNC6aSc+au+YEwIp7HXqlmAaAZ+4B7Nlvb?=
 =?us-ascii?Q?UI53uo6wQYQ6EzJTJT8UaCuK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f6b070-812b-4b19-3be2-08d8f65c7d96
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1448.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2021 04:53:57.8886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FeQaFKR4G7pYazFmvbSP+6zNs0ky5tP6RYHhxkkSt1+LNza0R+RPduqha1TdbZVJJWD3W1yjk4v9DkzYYah8PrdFFp9B9Am55/vYdNLtGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1894
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104030032
X-Proofpoint-ORIG-GUID: MhecNsImB-kntY2_8C-euwgFhXgZuDVi
X-Proofpoint-GUID: MhecNsImB-kntY2_8C-euwgFhXgZuDVi
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0 bulkscore=0
 clxscore=1015 phishscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104030032
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To update xlt (during mlx5_ib_reg_user_mr()), the driver can request up to
1 MB (order-8) memory, depending on the size of the MR. This costly
allocation can sometimes take very long to return (a few seconds). This
causes the calling application to hang for a long time, especially when the
system is fragmented.  To avoid these long latency spikes, the calls the
higher order allocations need to fail faster in case they are not
available. In order to acheive this we need __GFP_NORETRY flag in the
gfp_mask before during fetching the free pages. This patch adds this flag
to the mask.

Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index db05b0e..429e7aa6 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1028,7 +1028,7 @@ static void *mlx5_ib_alloc_xlt(size_t *nents, size_t ent_size, gfp_t gfp_mask)
 	 */
 	might_sleep();
 
-	gfp_mask |= __GFP_ZERO;
+	gfp_mask |= __GFP_ZERO | __GFP_NORETRY;
 
 	/*
 	 * If the system already has a suitable high order page then just use
-- 
1.8.3.1

