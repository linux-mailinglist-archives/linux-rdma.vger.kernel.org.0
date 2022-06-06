Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA8653EEB9
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jun 2022 21:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiFFTiv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jun 2022 15:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbiFFTit (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jun 2022 15:38:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB32A7E28
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jun 2022 12:38:46 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256IuxA5025285;
        Mon, 6 Jun 2022 19:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=HEk+5gAeLfGMkxSsLgASESo+hotiDZzcqNq/2n/3meg=;
 b=da17AYbF6U59myRnny/K8qDZg4cTFeOgYW9ZfZOb1nLuny00BxWYuCZmt3qsdSb4Y33G
 chZx5SPkKePn6kEPKYAQkXT9orH4mpZqR9LylIik9ybN4gzpXkY1SBoYhdilGji3o+lK
 rrHxgt0IbFbxBNMtWAwx1W+H61Tz28vbF71EkWcRz+IxtIc4OFs/yCsVOgqxj9Hjf5iO
 NltBqI9sve7D3NeRyRqUxLf9Qu8z8943/DVx05We8HxkhWV+KUc6fAIxw1d7aky0ES9x
 4+K5fM+EIZ1fM7C4xct0WPQYnsCF56I+VNMFZvCAmhXZ9jc9//DrW526aJmdq9cRQXS0 Ag== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghqad82hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 19:38:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256JaU0x004634;
        Mon, 6 Jun 2022 19:38:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu1u4xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 19:38:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYPUW/OrVJ37YfynyLwIAH+4pcQcyEbwQdlb+DjG9f17xifeeAISmxS+mw2fU0rpAZkhL8jqunuyEXBlnYDdzPyZYYfbWIX9qlxsDIxZ4D1E3yUJIlNf/YXJPf7SjRY6ocTtDfCE9AINJqt8y9dv9X8ZTjmGs12vmDw1yQuamRYz0aVLmuanwYGHdvbQO9svwzkNMo9fpW6iYaQmtjfI7bWxoxej9z+/1CjNZT/DydNdZt7dP7DGCdJlNAdYe+ciLUisdHCkxThXMmn21prr52cZNt2PfU2+N/iYjKZux2I2D9Um3X5wd79WdSkjDEDkuQep8dxPTTc9GRVkdqm+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEk+5gAeLfGMkxSsLgASESo+hotiDZzcqNq/2n/3meg=;
 b=fValGn3A3kyErEeqNbKOlY5vIXqS6Llx1Gd3/s1c3YTQI6ZNEPdx83SF1YYlUa1+uYVQW5Kdtl/ZfUA7S7YRcfbiaIRj14GjR4em6SaYU0Ru5EgDQA7o4+qivVZw+Tk/IvvNh3nqFS2s+4kmurt/+VuH1bnQ53k5Kv0IGaEPu0Rn+oBAbslUKovm/p41hPCClt1uvbYtpwK/y+jAw/uqF0n0L7AXpv87dRJzCbc4XPz8bb1kqyLVCIDP9htl3jbPj01JeL4Aa0jRIBOq0512+MPwy/hImsHlBy17GY7uRIj+Z1tLMfEx+YgBC2PMvMSM0soz9FYq/NU1CYsipaPEWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEk+5gAeLfGMkxSsLgASESo+hotiDZzcqNq/2n/3meg=;
 b=VVQyPIc0tzPx8VGnBs+YvBHtnG3y9ZzHwFV+nK7NdO6hSHNUCCCwq02u3DVcA8Ex1aL09rpZgyDw4k8S/1BPD0og5Ox4Lvt0mOlaFK93SqbfSniSudL0LWD+QRp+Q2Tdthh6bl0C1fN1lLpFT8iwpsZosCHTgjzLX9yO3lrwMf8=
Received: from BYAPR10MB3158.namprd10.prod.outlook.com (2603:10b6:a03:15d::23)
 by MN2PR10MB3520.namprd10.prod.outlook.com (2603:10b6:208:111::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 19:38:40 +0000
Received: from BYAPR10MB3158.namprd10.prod.outlook.com
 ([fe80::14b1:58c6:71b4:6e7b]) by BYAPR10MB3158.namprd10.prod.outlook.com
 ([fe80::14b1:58c6:71b4:6e7b%7]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 19:38:40 +0000
Message-ID: <eb4e348ec730900a47caeeb08fe4aff903337675.camel@oracle.com>
Subject: [PATCH 1/1] RDMA/addr: Refresh neighbour entries upon
 "rdma_resolve_addr"
From:   Gerd Rausch <gerd.rausch@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 06 Jun 2022 12:38:36 -0700
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:806:120::9) To BYAPR10MB3158.namprd10.prod.outlook.com
 (2603:10b6:a03:15d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f17fe71e-eed3-4135-45df-08da47f4284c
X-MS-TrafficTypeDiagnostic: MN2PR10MB3520:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3520C332279167E2C31D25EB87A29@MN2PR10MB3520.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bVd17aQTaK6v/O/vX2BOrZsKNTON9XB4ibhcPr5fh3/f36MFsn8S8xAtGXL4OX6RN6tcXYFo9qOFacO2QTENlccELj3QzCXivVrMLWVJvg4oPlqzKj9ZlAyWZA13BU02ZpbA+nfWOjCmOO854wMT4mv8UvMMogARoREeSFDpzsolTHAHoM1dGDsNc4a+LHu6aduw39hXhGoKOCwNlIJt3r1V9dcKuJ8kOWFudnipFpiExBA0ZwKUrdAhKGOBCXHRajQ4dzBLxj6QelbT53ynsEq+CHKePDcByN6XfjA0yaaKmLxe14ZZTUgmkvwGXazu13UbIhgFvtOQcI7CCNTCmKX5+0Elln4xcUi9I9dhMzqKEL5HGIzlCfVcwtTxIQABpi4hs8XmOfCsP98BwNtY1UUaFsUUzBnn+QqHWyt6TneTNZee3iX4z6h9uJVL/cm9ipsN/rtS1J1gjfICjctXuGwx/QMwvhjz3qQyZU3J7KmClDO4LD4BA5QGkIO89W4rXhXTnEaglDuaBD3+W4sCe0iVgMMh3l86QbJtpqfqfHAyQWgZ4xyVa0US5lNRN6ZzSTnmlwlVoqPJnKuEXdTYoOAZMfnxR8834bf2FyX5K3oWgix6EwpQdjpX28/x9NX5AqCm6iYzdscwC7tlhpyg4LMnRENeRP2bH9I6dqhGeSbRgTZgBUuklb5Q+yS4xqKe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3158.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(83380400001)(52116002)(186003)(8936002)(6486002)(86362001)(110136005)(2906002)(6512007)(36756003)(508600001)(2616005)(38100700002)(6506007)(5660300002)(8676002)(4326008)(44832011)(66476007)(66946007)(66556008)(6666004)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-15?Q?CKKRsaK63QytFQQ4nqIf8Q+iSMjgfVDQzfA1EkeWqDs8Ldc8D71dLU6Ul?=
 =?iso-8859-15?Q?uVKhHDxFtjzOU7AXIJHauakR+W0XlS3b6I/G9cte3CqasyuLyFrqsDsHq?=
 =?iso-8859-15?Q?cZQLK+krWwdoWh2Gh3R1D/f4V94JFtQWdq3lId3OAqSH/8AYjdrBNlvCf?=
 =?iso-8859-15?Q?St53ENRnmqdjTkA0wkUiRHdg/6qhk7rYi1tB7E4drtxfANACcQ51rNtuF?=
 =?iso-8859-15?Q?ZqDCOkzV0yYN3TzuawP1ZuVz+jOSQcoW/yWl9eySD881uXH+FIe/r5uUE?=
 =?iso-8859-15?Q?QKM/eARI6+5RiF3GQDVAqj+ckEbqr6gKDLj5o9hY3JEF+LdSmLFMq/iQU?=
 =?iso-8859-15?Q?LJJrBQ3Y+9D4joCrJtFJEjSvgjZlgIo0JH41Ch9djMYa2pkjMm7iRBhEo?=
 =?iso-8859-15?Q?MQnRFXspihUpe2yhLCgQuXMHF9tkoWwBBEdPsQ5CZAzYMIEK85HYR1hA8?=
 =?iso-8859-15?Q?BWy7eXbyfI/cG1YSwwD0B2qj7LLX/Dxs+U6koaSkY0INcK2PoWF2Gr5lM?=
 =?iso-8859-15?Q?+6Dwzygzu/MQlC+1l5+lXgNU3xhVnjj1Ld65xr+X7sCkcEcjqFVwEGEKl?=
 =?iso-8859-15?Q?c1j58AHCBi6wmGiHuH466QQkVKhPkzxuXAn9XduO3vgh5UWJIdrNktAY6?=
 =?iso-8859-15?Q?fe7XVdBQ761tq2wzCebzrPR+A7pq1TaIppf8hPBRnTWr8SfqyeN2e+990?=
 =?iso-8859-15?Q?aDG6jg1eT6HpTcPSewCl+FVJqXvSiG/1NLxCTG4PuPFqNIpKCOFxZHBTS?=
 =?iso-8859-15?Q?z0KDoFIPXzfQu/NQ7SxcftVJ+dTR01JWLFqyPDmjHcU/Smzu6whqOtfON?=
 =?iso-8859-15?Q?rdEu5v6QrzN5GKPSUL+JBFLIYkCBIJPJeXn4JcnDyaMvYSoMYe6Bk+0Ab?=
 =?iso-8859-15?Q?JV+bEhny+xJMdNEg8OI0U6mqM9iNhzveezGBTWl9YLMN7BEU3A+Otw/ht?=
 =?iso-8859-15?Q?8KZVwhSMclU13eXkVwDb/4Pm3NkWJH7prLQhQnKxovy7ch4y9sbd0IXs8?=
 =?iso-8859-15?Q?JpuO78liYZA0YEqo0gDuU5auqDVlZi97IEQisnvDd9jimILCwZcpAQo/H?=
 =?iso-8859-15?Q?oZpIT5tOXttRCIRbF/7aFbBja8ehBRghpSQIQiE+vR8q+KjK/vGQPU4nA?=
 =?iso-8859-15?Q?M9BBtxXtkkK3ctp7XJYprAB0cFqIB2BEeU72+BKUmyAGl7fvPM1tywRW7?=
 =?iso-8859-15?Q?8X4E6rvqicoznFDeLEHRJjIG2LbFZ5Mf/Fo4pb0YH62UOvjoY2+FZfjSi?=
 =?iso-8859-15?Q?eSwemxchXeJLeuGm8234y036jzi+S+NqDWlu8fvkwvb5J5uvLMW0qvksA?=
 =?iso-8859-15?Q?Dn5H9tcSwq+bHgRzHVJJludipOKIOl9mgxxv0vGWPQpJK+2pVVwIf/zT7?=
 =?iso-8859-15?Q?CJE85nOJhYQxmodWtZQetLDSDkA8jjxPTvs7IuFx2bkb1VjpksJ6diOo/?=
 =?iso-8859-15?Q?f4FzMVKlH8Ls9TnsWiAQeNlNBM8lthZ36NEkxcl02jmzeKDZEUVeRvssB?=
 =?iso-8859-15?Q?zu9jNvpUFT84iLl43qPYY5SdhWimRXyRivNntfIIFPC+oWP/aEl3hSRs6?=
 =?iso-8859-15?Q?aqZqMFwpeT8rcPkGRb2R2IzKiqMMFGECDdEb7s3jH07NOuGcvmFeRW9vj?=
 =?iso-8859-15?Q?KKRrN3LzaAJKBeqjIGQ+xT6/W/s4cH8S2hlU2kVnnOyjUeh3x0I42A6fy?=
 =?iso-8859-15?Q?RXIAZYv11IZwyQKPehupQbOx4x+4O2rpSDw1Od/n1hKEC7ucT4GPOfKjo?=
 =?iso-8859-15?Q?vkdQMrOePWB0PIoqIAO/BcmX3C0hXcQVpBbTsV/LtvKSlq+7Pgia7FRIX?=
 =?iso-8859-15?Q?21hSDfUNn73VAacWVa+YnnDZDAbJ0Y6utvVAml1G/Rgqdo890zjLcYnrv?=
 =?iso-8859-15?Q?RHoBUc7tuJ0ZP6Em/jptB2N9U?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17fe71e-eed3-4135-45df-08da47f4284c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3158.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 19:38:40.3463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6u/g0q6QuO1xGWdCNSuuAWBZ3Fo6Dm7vU8QOIzZZ11CPeN6lnZWCUf1wYdG71Y8hoMTAU7qc/tRW9vzHcoEsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3520
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_06:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060079
X-Proofpoint-ORIG-GUID: 13JkSO5-zjwpCEIx0aLqOM68rCZSIYAj
X-Proofpoint-GUID: 13JkSO5-zjwpCEIx0aLqOM68rCZSIYAj
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
 drivers/infiniband/core/addr.c | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index f253295795f0..db2a86971e25 100644
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
+		neigh = __ipv4_neigh_lookup_noref(dev, dst_ip);
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

