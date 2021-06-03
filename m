Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C51399B02
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 08:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFCGwf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 02:52:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34702 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhFCGwd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Jun 2021 02:52:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1536iAFm092844;
        Thu, 3 Jun 2021 06:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=0xnZuqywDE9QdYXfpLOoGfwDCijxtA93CKj+6YxFdnM=;
 b=FMRHp4eHpJYTm+tqc/Ly2JrkzFEJhf6BxAk36FhLcfLyBXNDJ4+dG8z77e1SotS+/ErZ
 lpz2VEB5ReQ6lQNRNCIA43qIivVoGB9cj9lTfZzn9QNAw8Xjk9hGNtx+PNI+LotxSjHo
 Z5Ul0VHAZLH+pjBRY1gj/7xtyKvr43tK1gtE246VmAfbv+H+thxOsUfSaGpDxkgVh0Yh
 TO8cjionpjHVfDC46QTJ5+TGHzmIAHL5dWssg0LqNj7NB3mObCpE8VeFjhMwu9/XIXpG
 gdZ6b7abHrQLAmCCQ5GBRPlKTCEAy93r/N713QgNVtGv/lPtMRXUxMuKZ3UlfK+p8vxz sA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 38ue8pjd50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 06:50:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1536ohxk045097;
        Thu, 3 Jun 2021 06:50:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by userp3020.oracle.com with ESMTP id 38x1bdm5ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 06:50:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQxnpHEIZuo7MwTUOs/v1dPtPhefzCaMLXIZRSMl8bnasd8QbWznKIUiItYfgy7klahsWDnV0bNlS838KQapXyvficsON6ns/EHLUAR4hD1bzmosw1EmHqxliUDD74imGAAQ4XBaL11qWzOM1JCW7DfhqllNFav5FcGJDQRnGkGFwkL+QmZk60gxT95m1mAEOhRNshZ6EspwCT6lBqfBvHvsUIleKU/ejeAf6CwmSt50zcFNOmhxvvEnjInmF9i1EmFk2Koy9eoiiOQVQf6BXTeOXLPUyqAYAe0Xub++A4ZrMVKxsPeRQ6XyFjEn3dpYJdhMz9tbgwO6lvRE1Q+hFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xnZuqywDE9QdYXfpLOoGfwDCijxtA93CKj+6YxFdnM=;
 b=IoylUl/LgitYu8m06ObHKeXUpENT/sJDqTDL4uG6y4k/GvJoKib1EwguUP+iAyXkH9qm7jXQmpFQ99K3dr9DUwBZq0vGB3pDs6ACNKOR+wsURiuvYN7okxoHL/h3RtriXtISAp9vUucud85dpjWo9NbtjqOi6Uf/KtF0OOcAfNy+uBLDo5YdXmyaU7BRDpww1r84LugeKIRO8xG0gTD1aQ4hnvW3hwMpIDHei1nJKRggnj2fj8F5ciVXU8FZM6++o6ZlPpdPE2JkRmVETgl+gOmdL6RsINHsAnnONI+oHwkALPFSMzTt3R8WKZANOwxLCRNzzyT3ynwhZ+rzYskCww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xnZuqywDE9QdYXfpLOoGfwDCijxtA93CKj+6YxFdnM=;
 b=NKvQ4e/lGPN0CDiNJ062ghJiiXyvyMPLneTq28ZqQYMRBr9HsQ/fX67jeF1FZ4GneaTA+aa4qhss81uSV+9Bpr1P/4AOliB6FH4VKFHPxpIAzwshraRod/E7Tm2uGcdKscQ+h0U4AYWxIVzGNgyXDPTDGyq1ybl1ITvtJjG3Nt0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com (2603:10b6:4:2c::21)
 by DM6PR10MB3979.namprd10.prod.outlook.com (2603:10b6:5:1f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Thu, 3 Jun
 2021 06:50:41 +0000
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::5c05:40f0:dbae:4c71]) by DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::5c05:40f0:dbae:4c71%5]) with mapi id 15.20.4173.029; Thu, 3 Jun 2021
 06:50:41 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v2 1/3] IB/core: Removed port validity check from ib_get_cached_subnet_prefix
Date:   Thu,  3 Jun 2021 12:20:22 +0530
Message-Id: <20210603065024.1051-2-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603065024.1051-1-anand.a.khoje@oracle.com>
References: <20210603065024.1051-1-anand.a.khoje@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [103.127.23.88]
X-ClientProxiedBy: SG2PR06CA0205.apcprd06.prod.outlook.com
 (2603:1096:4:68::13) To DM5PR1001MB2091.namprd10.prod.outlook.com
 (2603:10b6:4:2c::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (103.127.23.88) by SG2PR06CA0205.apcprd06.prod.outlook.com (2603:1096:4:68::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Thu, 3 Jun 2021 06:50:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69fcf725-c0e9-46e4-a062-08d9265be740
X-MS-TrafficTypeDiagnostic: DM6PR10MB3979:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB3979DB148E88C204EADD8A3AC53C9@DM6PR10MB3979.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LkN4Xag3qhKBvh3yReq24gMQ2hl1Qcr2N9dDP+5PjfxVt3SeCp2xc8eAtsN3GVk268qjY1PZz4Ahyjhv/UXsfyrVWJ+F7qLLJwvuLO9t3UQWSSTpi+bUBL8OLwFqvOxQmKy9BOM2iZkLUvwFkMuz5w6jxHJrR+zRyzxhyDDk7RAjpijjYdfvMJCA3zMBX/NeHY2GZ3GtJFHOXZjM5emhEJ8jqb/8qcZLsMEHhrxXY9GfnOhSk7KBlZISvRgwqaIr52LPQCLM8PWi0QSukIlcJ4e52JgzvQUpJT9aG426WFH9ywu6ptubIJQiVCLmfTn7qxIFIch/Ua1lJy2IchEC0P3Hogc6DY5+PXSNFoO5Uqv6qPS1eSvpAfc6CvT634AmGCYBeUhbvviE6ZXNUUFw9Yd0zEzxNFxdST2nKM5QxrCrzDv4/JStvYqbALX4rWGV9B0B9tZc7m11EbYlOrJ1W3p/zXpecLP8af911dg/z3ZdTR6cYY7Uu+BHxmJJ35XbpJS2If0Rsyvv3UjLzADS7i627rFBI9B7+2ynVX6xsvZtsNGDNYZiQGdoKFzHNTbYjYZZBAU5PYhi04tjpMgGvq0sOb/x/IgN/ffhYgl4f0oU0pPYDXIcIP9sF52NLAteYIYLe4gI9raIOJadxXv48Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2091.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(396003)(346002)(366004)(66946007)(66556008)(66476007)(6666004)(6486002)(2616005)(7696005)(8676002)(86362001)(52116002)(5660300002)(1076003)(956004)(36756003)(38350700002)(4326008)(103116003)(38100700002)(186003)(478600001)(16526019)(2906002)(83380400001)(316002)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?23V4TA+vFldMqVxZpYR9Kv/veKyg1qBbbQBnF5jYxBPCaegkF48sGUxC9muf?=
 =?us-ascii?Q?pffs2CDMiI8lRpoPb041fChRmMGx0CqHZ4Bs5VsAEK0vJSEVYKhEF36wFLi+?=
 =?us-ascii?Q?M50VWq15iYgZe/nufHUz4+4DzQLk3glvYtJ4+UNNOmahgymXsOuAH3z/3+Sy?=
 =?us-ascii?Q?bNkp416Dlf8T08V6y1ONyEUYzj+7bhR6Za2YgvDM8OxMy4zUd6OGdGG2tDNC?=
 =?us-ascii?Q?gokTjhpaqxwMVlCMk94eAKvmH31U3ny3uRGdjlrYFktMCKnGZ0JmrylOfI0g?=
 =?us-ascii?Q?UU+RhiNvgnxcJ1KRsESUR91F/Oa7STYhdCwyehZZiFCybSOpH5QWu4LKN7Tp?=
 =?us-ascii?Q?WEjo1r99EPNWazGTQC0sngJf/w3bcRImVRCUTUDU4EqXW0F6R188IpCqYkot?=
 =?us-ascii?Q?EdrFLH2PfxVXsSEwts8OTIkoFkXa4qNwbrbByfu8ju+lcEW/9SXVcQpxFzPH?=
 =?us-ascii?Q?/mzkE4DXiSj21Zlc939FYYKcD2kt15cSDQo7G8EXGxrbCU7Bi4KFPpRdWn4R?=
 =?us-ascii?Q?nkYJc6MuMswq/7nqtUkRPs/mLxg8m8wX05DI9MquxCtG9aImkWgBo3kWofxT?=
 =?us-ascii?Q?UV6tNpx0eGt56j+HbWY2uFexiSDCLi4zSoQqbtp9CAfA7pOCjyPkTW6ZZFeE?=
 =?us-ascii?Q?Mb3j8S6Pf3fZhEOYGZwRovQLfCzqzxeqETaJe9ypiRrxtloteUzX5u+M300E?=
 =?us-ascii?Q?TtzB9x/ODaToSzQzJPqNNuHeW1+VR24qYEaCI1gqeWEOQ8FNRgfoynOqr9rM?=
 =?us-ascii?Q?HIa/XHZG8jQbrnREVaDTZ8MHztIS8xb9Ya68jn/wz+pCR8krT5rjOP0r9Bx0?=
 =?us-ascii?Q?opY1HcEYBHAqBp6u1PzOG6U5TD7ciPybHAWMs2grpfWnTmz9HqqVc0BcCnna?=
 =?us-ascii?Q?Y6vlq6KEX/wPSmoJmYyW7X6UYHO7wRNFe1yDxYTx6VOTRH8dtTEJwxVoY4nh?=
 =?us-ascii?Q?UDXQxW9TQ5NKCR7/7ZfsOOHRC86CH6mAMlTuX84QjfkqNfU1N4BNXzazunkG?=
 =?us-ascii?Q?XaVfp2s4DTNbprtzPI8uVeFbWFZ9mp0yzfA6DiehKBViFcTqo5cmHhk1eeh3?=
 =?us-ascii?Q?rdTDVDOOKbC1Zl+hoVDnclhKLSdxYFjOV84rQsFsTzLwQiJ3O6TlI7OElQiD?=
 =?us-ascii?Q?MjS5i/yaRiayUlf1/Qe5lEVnlMe48VgET5hYCSLp4CO0DoKosqPLyKCu/M3z?=
 =?us-ascii?Q?ecrkben7I62OpVcy2xeZR5bwP2JAg9IJQ3rH9YgXEuITL5PMd+G3y0paoRMM?=
 =?us-ascii?Q?SF3Q3zYp7mj+qTzeaQluXIx+YlC4lV1sm58u7cZ7PX0y3ojq27DaUeXMJy1k?=
 =?us-ascii?Q?VhsRyF0hYTvxfm2Z8ol7U80w?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fcf725-c0e9-46e4-a062-08d9265be740
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2091.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 06:50:41.6945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 790+wCb88ZJ6Jee7Ss7kBP0oOnDBVM/kRl+PXMeAOPQad2I0sn1czFiNtrCKIAB1N7PRL6FO1AQUOO7XokaWStJd+BcLuTwzOewjPOLNlDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3979
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10003 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030046
X-Proofpoint-GUID: RRUaoFQ5733TRUr2bD--Zz28A1QAOku4
X-Proofpoint-ORIG-GUID: RRUaoFQ5733TRUr2bD--Zz28A1QAOku4
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10003 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106030045
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Removed port validity check from ib_get_cached_subnet_prefix()
as this check is not needed because "port_num" is valid.

Suggested-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/cache.c     |  7 ++-----
 drivers/infiniband/core/core_priv.h |  2 +-
 drivers/infiniband/core/device.c    | 14 +++++---------
 drivers/infiniband/core/security.c  |  7 ++-----
 4 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 3b0991f..b6700ad 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1069,19 +1069,16 @@ int ib_get_cached_pkey(struct ib_device *device,
 }
 EXPORT_SYMBOL(ib_get_cached_pkey);
 
-int ib_get_cached_subnet_prefix(struct ib_device *device, u32 port_num,
+void ib_get_cached_subnet_prefix(struct ib_device *device, u32 port_num,
 				u64 *sn_pfx)
 {
 	unsigned long flags;
 
-	if (!rdma_is_port_valid(device, port_num))
-		return -EINVAL;
-
 	read_lock_irqsave(&device->cache_lock, flags);
 	*sn_pfx = device->port_data[port_num].cache.subnet_prefix;
 	read_unlock_irqrestore(&device->cache_lock, flags);
 
-	return 0;
+	return;
 }
 EXPORT_SYMBOL(ib_get_cached_subnet_prefix);
 
diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 29809dd..0b23f50 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -214,7 +214,7 @@ int ib_nl_handle_ip_res_resp(struct sk_buff *skb,
 			     struct nlmsghdr *nlh,
 			     struct netlink_ext_ack *extack);
 
-int ib_get_cached_subnet_prefix(struct ib_device *device,
+void ib_get_cached_subnet_prefix(struct ib_device *device,
 				u32 port_num,
 				u64 *sn_pfx);
 
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index c660cef..c2fa592 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -886,15 +886,11 @@ static void ib_policy_change_task(struct work_struct *work)
 
 		rdma_for_each_port (dev, i) {
 			u64 sp;
-			int ret = ib_get_cached_subnet_prefix(dev,
-							      i,
-							      &sp);
-
-			WARN_ONCE(ret,
-				  "ib_get_cached_subnet_prefix err: %d, this should never happen here\n",
-				  ret);
-			if (!ret)
-				ib_security_cache_change(dev, i, sp);
+			ib_get_cached_subnet_prefix(dev,
+						    i,
+						    &sp);
+
+			ib_security_cache_change(dev, i, sp);
 		}
 	}
 	up_read(&devices_rwsem);
diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index e5a78d1..5433912 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -72,7 +72,7 @@ static int get_pkey_and_subnet_prefix(struct ib_port_pkey *pp,
 	if (ret)
 		return ret;
 
-	ret = ib_get_cached_subnet_prefix(dev, pp->port_num, subnet_prefix);
+	ib_get_cached_subnet_prefix(dev, pp->port_num, subnet_prefix);
 
 	return ret;
 }
@@ -664,10 +664,7 @@ static int ib_security_pkey_access(struct ib_device *dev,
 	if (ret)
 		return ret;
 
-	ret = ib_get_cached_subnet_prefix(dev, port_num, &subnet_prefix);
-
-	if (ret)
-		return ret;
+	ib_get_cached_subnet_prefix(dev, port_num, &subnet_prefix);
 
 	return security_ib_pkey_access(sec, subnet_prefix, pkey);
 }
-- 
1.8.3.1

