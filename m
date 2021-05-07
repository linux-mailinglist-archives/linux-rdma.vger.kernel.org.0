Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C393766CF
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 16:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237476AbhEGOJ3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 May 2021 10:09:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58698 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237472AbhEGOJX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 May 2021 10:09:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 147E0BYa089949;
        Fri, 7 May 2021 14:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=+BXjrM996ERmL/yu6O5WJlaKpPh0GbiDWwQS2PYktW4=;
 b=AsN8FDPHK9olk1N5mNhcu4QXmZYAIKmGZBJCHpHoE5VCt5ThFS3a2wH+iE90+7VtWb83
 /yfqe4j9eN2rsNk+kpcdRFa3uIDLMUBlESCr8rq9dOPrRijXy5VjHN2VB67ZpwRa/ZDU
 a51QlYxOhvsM1Hc9tqAcTT6lFoI7Z3muvq726SZ5Y/nmi/Ew45k9XSWjld4M06gbEo/Y
 sw1+nRgOKfbKzS6NUvl3gQxBI6q3nUgHfTNIvwx56do50PqthfGIDKaMf2kZicc4kZq2
 bx6Cv+SLe+edsCw4XpxaV85QbIkmdzRydZakwYM6KV3GWLgdwN7q0UdiI5UHNsI0+kL3 lg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 38ctjv1ng0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 May 2021 14:08:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 147E0TPX061818;
        Fri, 7 May 2021 14:08:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3020.oracle.com with ESMTP id 38csrthdk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 May 2021 14:08:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VI33nDd+E2Iqw9xJRuQ+WAOaqNN6NPqSkjneLfsXrIoI+r9EJDRbg6Mk2Og6mNAf1lT229oc2+tSdn/oAzjSXAMf2rBjGcMZOYdHUazR35v9J8QKf800tjQHWhou7gJKVuHfvc7MhfqP9OgKgb1onCbaxRYoEPbYHnrDLDF0+6prAWRseAn+sO/E6xzua6gZN+V7I78zs97llzqguP8JlAP5wW9He0Qm0x22A/tES+xKG3HFGqnvsibX8C1IOWW1iNUe3Yhxo1Hh0puy4Zv/MklXLovWe2t53oBUFwBHNMmKz0c7WRHG9lwdXHIv1//5jjoN4y1KlEzgIXwJmcohIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BXjrM996ERmL/yu6O5WJlaKpPh0GbiDWwQS2PYktW4=;
 b=kW5AvvpCaJJhCA2jcbdPCRArNDWfsJEmNDShULdcfEFp6o0JwUiRrjRh1NjoSnjZKPfnm0vFHtSa/2zulWdhIpUydQl3RxOby8oOd1aB7s2ctYBQRevzSjrpXlP4oYC9a5RKitrYTynh+jL+T4VNKkrSfL9GWBf3i5QfiKRuxtk6u22HxefNNlcMCcirsoS+M2xcZgFl9YoPi+jNDRpNPaUlYzqhzs0hWC1DVFr8vQdeLM5NCilp+LxL+1BIPdbrmwcLA5TUkMBMwQnNZ1Bi/ed17AAnx871cYi00VY2qgk9y41iM6DMyDMtBS/daxiXz03WlCyekCbqs97N3UiKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BXjrM996ERmL/yu6O5WJlaKpPh0GbiDWwQS2PYktW4=;
 b=JOCdjeOvZmdQhC6k4zrzqYbYYKd+2SRbJejk4KOPNDARwcUWVDgfk3zLxN1lAZSQ+xekNlep4O/1rGPaWkxCFqNj4WPXgPUAxSUa2h1U7xzItpf6wc0q4F5O7fe6+Q10H8hWVENCe8AaK/PGcsPDD99QHxPzQ2rO78kJqCvXi6o=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39) by CY4PR10MB1863.namprd10.prod.outlook.com
 (2603:10b6:903:11e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 14:08:00 +0000
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::7c49:4778:12a9:c4d]) by CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::7c49:4778:12a9:c4d%6]) with mapi id 15.20.4087.025; Fri, 7 May 2021
 14:07:59 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        avihaih@nvidia.com, liangwenpeng@huawei.com,
        jackm@dev.mellanox.co.il, galpress@amazon.com,
        kamalheib1@gmail.com, mbloch@nvidia.com, lee.jones@linaro.org,
        maorg@mellanox.com, maxg@mellanox.com, parav@nvidia.com,
        eli@mellanox.com, ogerlitz@mellanox.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Anand Khoje <anand.a.khoje@oracle.com>,
        Haakon Bugge <haakon.bugge@oracle.com>
Subject: [PATCH] IB/core: Obtain subnet_prefix from cache in IB devices
Date:   Fri,  7 May 2021 19:36:38 +0530
Message-Id: <20210507140638.339-1-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [182.70.7.106]
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (182.70.7.106) by SG2PR01CA0172.apcprd01.prod.exchangelabs.com (2603:1096:4:28::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 14:07:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6b29ece-b7af-46c8-c949-08d911618532
X-MS-TrafficTypeDiagnostic: CY4PR10MB1863:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB1863881728EDB6188A03B86EC5579@CY4PR10MB1863.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HFYP/b4ptltNMpIOdAsA9vdp/uYPry/1sNOf32Ip+V92EiofjDWu4M+BWF22Hbm0JZFXe0iEmWNZp+kFEZtS3umsw3ffGnavEUJ691fBpGhHrvy+GR4HpVB1vi3lqFvPQAgUS6gTDm7uuZyd7PQOkvsE47xhdG0pdraXv9fv8+vLLLfLNU5d+5pc3eb5IUJGWfu6Sau5RLBRORCucyYcmmMhVGVSi6uiHTwLVNXox5FkZATArdWkU/U7MXad0rIhgA8eOuIF4Ze6mR8u6AOMYzGQJJjY8SPelonrLQ+Y0CzKVV5UKBcR+dfcpA+4HBWv/jTZWTaWg/7dNQMxnxHF9PXGgPMI818F1yt+4IzAHjx/4oNZEEXbKWM0kRXqYXYZtwXOEwJFhAeMYrcIUq3geXiql+cckqcTWbyqqEY6O3ZQFO/2PcEtwMen3EVgRHo3qT6YkB15jCThZPWEKxiQlPBv5VLrkifCa0ANSp2AP+NmYzhp9xfB5Vl3+GVYIkZb2plYO9vLp9rkPjmHj4PGj95xExKmV7FlItF9L8E3X1rwmXY0qNZ0ppnKSICLRM8Ei9ydUFax068as5ospwt8Oo0dTeDnQKxgb2KxAd5FMToniQsDYHoN3VD3NrThCuebolNyMXXONfYwzVVsQFYF1vs+TSqon05RmnB70/98pcUj+Oe14Rfzed1uo8jcc03uiDlpBNxJozYbVwBAT2q+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2086.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(396003)(366004)(136003)(376002)(107886003)(921005)(66476007)(38100700002)(38350700002)(6666004)(478600001)(8676002)(4326008)(66946007)(66556008)(83380400001)(103116003)(956004)(8936002)(2616005)(186003)(7416002)(7696005)(316002)(5660300002)(26005)(52116002)(1076003)(16526019)(36756003)(2906002)(54906003)(6486002)(86362001)(120606002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CN4KpSqKFxKI0B5PO+xjYNdU5k36lHX7Im2qz7Trrp0l48od5f5JgHhZweqR?=
 =?us-ascii?Q?6qWuqxGT2vUM5y/g1dWVVWilEx8yMTCjk/APlWQMxbzIhdo96FeUR90m9D8y?=
 =?us-ascii?Q?xuEYl0bn3iD4JxkouZuUseqxc9tPUMShVy2eIaavm266/SUqzBiLFuaqHIFz?=
 =?us-ascii?Q?VoP2tlWIRVL3tjmlMQJ89aa13E9sYPFTeGE1R3fF5xAr/huDpEnhPnoC+tWQ?=
 =?us-ascii?Q?7Cg3zCmcU7DhN/kc12LahzSe5lv4NtBiKXd8qRoRBLPT/EHIBdxpYZXGfhtV?=
 =?us-ascii?Q?2vR57qz2GwUKzlzMiS7egUd2PWBNqpMujJsRGVpq5I/+h1njOEE3edDo+IPN?=
 =?us-ascii?Q?2WanfF6kvZ2v3PQ174xjZaOAyNUtx2DaV0XRfYRyPp7uNI15MiV9kBkV6eTi?=
 =?us-ascii?Q?ZzB+DZ0Jkw6sZ6knKzH/K1OF6zcP8tKJI4gilQ/6M/eyiozGti0Q0TA1Hj5/?=
 =?us-ascii?Q?UQhgQl4vB5um7ZUvq9BeR/272IwUxQTzcjP34njy2DJsUNEreobVTCUtn1Im?=
 =?us-ascii?Q?zZf1MKhVr9JwsAZwSac06fcOB1S6m8Gqi1sHXLJYtgUgci1PcY9DU9SmlAlV?=
 =?us-ascii?Q?4lstLfOvstTVhKAL89sTWrKu9BmGiLsPE7pJBXBAue5x1P8HBihn7X5y4B5j?=
 =?us-ascii?Q?GnIVNeqeAPV2hQnxlxwwPd5NOEjCzcD5PSwstdX9wZImaQ99gJJRm+zX/TeB?=
 =?us-ascii?Q?Cszvgh0okb6ETIIjTuo7CyPZOKhh3JCk1d/W59s9GeuQRuSwMYR3B3PZDmBH?=
 =?us-ascii?Q?8khIzx76v6kow4BY872qlM7RO1anlv+GJ3dK0ze5P4uTfeVIwswzEi4fP3OC?=
 =?us-ascii?Q?sxzszZGf1homUU0vcpfIGXQ9otZnvLWotbqStsDgBFaZqH8njhj4IqixBe4/?=
 =?us-ascii?Q?qArc2D6bG/tso9DfMdL1r1SC9sBXtD/rpAm/b7krdnBajmN9cqzgg8T/wCkU?=
 =?us-ascii?Q?o4l2FoFHjViQ8cA52Prs4p/bGV3HFreZjbUdUIugjlxZMefCmLOrnevCI+lO?=
 =?us-ascii?Q?5/pNhP+Z3Dmr7kXf9SH/mC1owSB2dBXCGorX/L2hx4xo0EfniH1/WeLNxDd6?=
 =?us-ascii?Q?xwha4xVLPyQKVEj7TrlXkSTNmburlujbtMa7XYanuzXglq+mfBu9Mo5Qgpnf?=
 =?us-ascii?Q?I737TAOEUKHZXIz+FnKueUlnEyBN9MZExQf96pCovxo3pTtV00qY5A7yqN2S?=
 =?us-ascii?Q?mVTKQXx9m2GrSNt2Uyc9CuU5/1Bh14r4mSUz+Rtowl2j9uHew4kJ5i2HOZ6R?=
 =?us-ascii?Q?Y/zzdY02GieeHB7baLgpCKg+N5y3F1L4ZvKrITjQnp9V0SWWHXNyHNm0fJW7?=
 =?us-ascii?Q?GB64o+ZTsQXdRV0fupXBA6R2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b29ece-b7af-46c8-c949-08d911618532
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2086.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 14:07:59.6932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4175FqBu6ImnD2Ze4LaB+GR/+HDuqiyYbe211P6r3O8pbNYWfiJv0/t6Oc/tTNXg3YpRe6RGd/LdnWi+xB3vgeTyiJ46F46OVw1MOP5sdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1863
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9977 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105070096
X-Proofpoint-ORIG-GUID: EFKvL81L3cFeDs0XmR_RT64BLXE4ZWMf
X-Proofpoint-GUID: EFKvL81L3cFeDs0XmR_RT64BLXE4ZWMf
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9977 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105070096
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
The function ib_cache_is_initialised() is introduced because
ib_query_port() gets called early in the stage when the cache is not
built while reading port immutable property.
In that case, the default GID still gets read from HCA for IB link
layer.  The shuffling of netdev_lock in struct ib_port_data is done
such that the size of struct ib_port_data remains the same after
adding flags.

Fixes: fad61ad ("IB/core: Add subnet prefix to port info")

Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/cache.c  |  7 ++++++-
 drivers/infiniband/core/device.c | 11 +++++++++++
 include/rdma/ib_cache.h          |  7 +++++++
 include/rdma/ib_verbs.h          | 10 +++++++++-
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 3b0991f..b580c26 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1627,6 +1627,8 @@ int ib_cache_setup_one(struct ib_device *device)
 		err = ib_cache_update(device, p, true);
 		if (err)
 			return err;
+		set_bit(IB_PORT_CACHE_INITIALIZED,
+			&device->port_data[p].flags);
 	}
 
 	return 0;
@@ -1642,8 +1644,11 @@ void ib_cache_release_one(struct ib_device *device)
 	 * all the device's resources when the cache could no
 	 * longer be accessed.
 	 */
-	rdma_for_each_port (device, p)
+	rdma_for_each_port (device, p) {
+		clear_bit(IB_PORT_CACHE_INITIALIZED,
+			  &device->port_data[p].flags);
 		kfree(device->port_data[p].cache.pkey);
+	}
 
 	gid_table_release_one(device);
 }
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index c660cef..6d62023 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2064,6 +2064,17 @@ static int __ib_query_port(struct ib_device *device,
 	    IB_LINK_LAYER_INFINIBAND)
 		return 0;
 
+	if (!ib_cache_is_initialised(device, port_num))
+		goto query_gid_from_device;
+
+	err = ib_get_cached_subnet_prefix(device, port_num,
+			&port_attr->subnet_prefix);
+	if (err)
+		goto query_gid_from_device;
+
+	return 0;
+
+query_gid_from_device:
 	err = device->ops.query_gid(device, port_num, 0, &gid);
 	if (err)
 		return err;
diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h
index 226ae37..bebeb94 100644
--- a/include/rdma/ib_cache.h
+++ b/include/rdma/ib_cache.h
@@ -114,4 +114,11 @@ ssize_t rdma_query_gid_table(struct ib_device *device,
 			     struct ib_uverbs_gid_entry *entries,
 			     size_t max_entries);
 
+static inline bool ib_cache_is_initialised(struct ib_device *device,
+					   u8 port_num)
+{
+	return test_bit(IB_PORT_CACHE_INITIALIZED,
+			&device->port_data[port_num].flags);
+}
+
 #endif /* _IB_CACHE_H */
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 7e2f369..ad2a55e 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2169,17 +2169,25 @@ struct ib_port_immutable {
 	u32                           max_mad_size;
 };
 
+enum ib_port_data_flags {
+	IB_PORT_CACHE_INITIALIZED = 1 << 0,
+};
+
 struct ib_port_data {
 	struct ib_device *ib_dev;
 
 	struct ib_port_immutable immutable;
 
 	spinlock_t pkey_list_lock;
+
+	spinlock_t netdev_lock;
+
+	unsigned long flags;
+
 	struct list_head pkey_list;
 
 	struct ib_port_cache cache;
 
-	spinlock_t netdev_lock;
 	struct net_device __rcu *netdev;
 	struct hlist_node ndev_hash_link;
 	struct rdma_port_counter port_counter;
-- 
1.8.3.1

