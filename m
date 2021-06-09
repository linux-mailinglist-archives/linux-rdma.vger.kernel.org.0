Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB043A0C19
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 07:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbhFIF5z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 01:57:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54188 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhFIF5y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Jun 2021 01:57:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1595oHsv112256;
        Wed, 9 Jun 2021 05:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=bSRuSEzERi/e6QasgFjbWYvgSIYkno2OGtGnZUB6wWw=;
 b=vJFMlU+ydxkJJxA2Si76Mn3WtoWjoeBpbAKC8qw3UP7uWyeWSNiq2gNN/DoTiVq5U80+
 p0ygG9Q+zJae7U7mI+aeNxj9NTvF1x3iDVKAuEuPiur44CjujjmQPZ7WhlfTzypASdvK
 wrBk5bdSjc7aqIowZXiIISi7TUTNzogGrsZAwkxkrarREPa9ObNVMCr1NIue09wpZSak
 aDVHTQxRJ+j/ngB3HRrPH/Y+ldsCNwYm2hicCaaKzyziTqWGa8dXpl1NzjuXBLJonKrT
 8ffsiH5MwLX1TR/MGoi0EaChjbeNoOnizQ+rVGaXWWddCB6MaBJWtqALR0uSkelrcbhK 7w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 39017nfymg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 05:55:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1595osCA061835;
        Wed, 9 Jun 2021 05:55:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by aserp3030.oracle.com with ESMTP id 38yyabfkk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 05:55:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bnd1rux/uJOjDQ+a0VbtHealTEyQQvo2edv0zGCykQWy6RGcL43GsRzuK9qxUXmag7SQYq2C3tZ/eL66mw/QQGUQVvjOxRf7+JJGPeO4C8sT8yhrHNpPiisBDoRUMYeSBw3oTPbRp94i/y8uS/UadVDEtSmXGPX4Is+HjA1Yaz/Ky5LtAGTrNQFwuRvoKEr/REVjrcqppLVn2eeVwbeNC0i1volnspFsEXR6YUPB3eUCnHew/y1gkORRAnz2JMz1+2GGMpmXOhen3KUaiiN7yXCGtG7TuS1qYriPKkGBzaTB4N2LBwmVlyN32e3bgYHup7+ZJcEW7qR7gYdY9BECmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSRuSEzERi/e6QasgFjbWYvgSIYkno2OGtGnZUB6wWw=;
 b=LLxsd4VLbqLt6h7xLZcmwNaAjJQNiM/cmD+PxT547+sTfhHQ17ZSCevajCyI7qmlWD9+e7I2xS2sERYX40a07RE61YCtM4fXH20sm4tO/n0KKk1lhV9LLVTIGcHPjUW0Ow7nrDrbFfZiD5LJ73bV3whTuWrhKVeBMAtibrmgRnKVbBcBlfIzZTGDYWcDmZ/RaraMIWTv8AxZyQJ3cwlHo47viGSKtJdw4ZWTvFpl6kalewq73ECEr6pqlIA5Q9qmu1RlrzxOwBaxWEiMXM9Mu8GMRBrPQFwn2N1+1jVOZch0P0a1bAMvPeF4i0XgRoDYU7RtYSl8c2jg4b6sG7SejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSRuSEzERi/e6QasgFjbWYvgSIYkno2OGtGnZUB6wWw=;
 b=OMj1DLP1RT/F9R29VQRXaFSC810yAE23ySf/lLs9CRu4W4Iepo50ma1tpTEtFEENE21qeX5Rhps0sk7xdz9EW2EisLU+esOSnLEEA9WkA+zsDuGfZ/wNbo+cNqEVnHU/Qfwd2wC6Jzy5/o5Aucfa0qYM0UuFBBmq3HCw4E06txo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com (2603:10b6:4:2c::21)
 by DM5PR1001MB2217.namprd10.prod.outlook.com (2603:10b6:4:2e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 9 Jun
 2021 05:55:55 +0000
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::5c05:40f0:dbae:4c71]) by DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::5c05:40f0:dbae:4c71%5]) with mapi id 15.20.4173.029; Wed, 9 Jun 2021
 05:55:55 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v3 3/3] IB/core: Obtain subnet_prefix from cache in IB devices.
Date:   Wed,  9 Jun 2021 11:25:34 +0530
Message-Id: <20210609055534.855-4-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609055534.855-1-anand.a.khoje@oracle.com>
References: <20210609055534.855-1-anand.a.khoje@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [171.50.202.152]
X-ClientProxiedBy: TYAPR01CA0029.jpnprd01.prod.outlook.com
 (2603:1096:404:28::17) To DM5PR1001MB2091.namprd10.prod.outlook.com
 (2603:10b6:4:2c::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (171.50.202.152) by TYAPR01CA0029.jpnprd01.prod.outlook.com (2603:1096:404:28::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 05:55:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebb0239b-eb48-432b-7c7a-08d92b0b3f0e
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2217:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2217717F10FCE4C37BC553E5C5369@DM5PR1001MB2217.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oqIARSbBO9AISPSY0rU+Mvm0xzdJ2Y9LNkGpNrQ11Y6QuNno65ccHamuL2NMacGIJSSgho435Rq7OPQMrby9wOJZyL20gw7PK/Ctq7e8xzhdWfEB2POuM7JuSuE646g3MSwBuWQFzRQT3vEo3nq7aGzvtHR4t/H6p9RaMkkcBz4d1eHlRaiJYC7C1gl6zI22PGqnTdm0JO+hw58jRyP0N47kkDaGHWFcyL7OQ4lNWKo6jAgKghS3c9ygonz3pjp+FtD8mciMu22HyiIKHmk9a+gUebhyJQw3p9oaBZUj83cak4a8c/VppuXTpJxEsbviBXhPD9EeDXUlu8yU2CBaDFZbiMrpPQS5KMgpueybJrWy4iv+/e2zbuLzJKqFQQRWy8AxmPWNHj+3Zsnbb2EhzOpTSzLMr1iUUFbzT504S+S7rfzFtqVBSOU2APctpT5e3LWr/n041NT1leyVAt+frBB8ukV4uNyXeHSbXV5JvnrBKV4gDd7b4tdxgpYzANe4zb0vdjwRa9t3Sq4Kb9OtTcw0mh/9A4/0G2B6SkpEeaLUFfif/ruzbSopqU4r37iCfrK5stO13xSV0qOF9FeGK/fYUay2GhRAR0P67VR3fWMAixWJAPWFOT0SaC1sB01yc2DuNh7P+vVeIbHFjvxksw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2091.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(136003)(366004)(346002)(956004)(2616005)(26005)(6486002)(1076003)(2906002)(316002)(5660300002)(8936002)(186003)(38100700002)(6666004)(16526019)(66556008)(38350700002)(86362001)(103116003)(66476007)(52116002)(7696005)(478600001)(83380400001)(4326008)(8676002)(36756003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4sW/leAvBPh2fzD8eSHXVYSh30wGocwmGwcAjv0nsli63NW6Ei4PhN+G0zCp?=
 =?us-ascii?Q?k4vbex5DeiAA7L9Ki/5T9sd0xXo9hUePAmQIQGqu9kiuMNaCxBKuvBN/7syM?=
 =?us-ascii?Q?HW6u1l+KT2Pyq8qsocDD7QWy6/m6u2ckbl9GQ6TUZ6dr2htaSiqZrguvcuda?=
 =?us-ascii?Q?RvMzIMOOIy2UyOthHGCJU13wEor7lhuy7CYHP666nVQLoB+jPMtzfdXYZhHu?=
 =?us-ascii?Q?ohj0MugT7+AH5zRXZC0gwpTPcMNTcMfK6dDqBZZwCdOgZ2vzEj91cn0/GyfB?=
 =?us-ascii?Q?Zmsf650mcGlEK21gZtzMasxj7cfdOIcNw6p3twbD/wDkP/4bmzm0+lK8qDc9?=
 =?us-ascii?Q?ikEWR/o/aRpux79UmKm/HaxMtNhJaRrzq3/0pKwziwl0xir3QbRUN8vAExDx?=
 =?us-ascii?Q?7xxV5OfNmcW8B2q/eUKbFEV76/oKvrVvZK6JE0AJvwTKMqDFcfumwZbg4v+4?=
 =?us-ascii?Q?Hzc89XcvrowYh5I+hhiypIDK9+9qF80Ifi+mcM6blTVphycenrI1tVl7py1J?=
 =?us-ascii?Q?afeFar+dqrkT8oQQXYjNYfnYLDFfz+JSQNBz+7wiHTk1aGYltP/f48py50Yb?=
 =?us-ascii?Q?ChPnQhzAQAMmhxBtpJy4kyqRvSLcvqi24dvBt6zXL1B8aC1JSuqxEXBp7fQx?=
 =?us-ascii?Q?bMvIVMWMJVFslD6Y8KUsJIswAg2+Bg++e4ajaQBE1W/QYBar62krb2PpOwdq?=
 =?us-ascii?Q?0wp7vw/ICCAVB0oCsZXNUApSypzjMIvDE4q3mUekD/oiWhVd4/w5lDuGAgrP?=
 =?us-ascii?Q?5L4KXzPevhOlU56/C5av94+eGz+8/3SlYaEAdD2p6mRiRF5fFZw4+/u3gxlo?=
 =?us-ascii?Q?yfjy2jeMbMgZCMcfqHT3xE1jW6IVKBkGMYB06u387TR+WIPXNpcqafoz+taD?=
 =?us-ascii?Q?s51MvoBFLYCpLykryHErUAuaBQL5gjQ+/WnMnxI3u3ylyydtg/ULQOMbukm9?=
 =?us-ascii?Q?pEcHnpFTy32TzS2lQeabvgHmI1HgH1AHopOqi52alLKRvM+NX68ah4F8mTwZ?=
 =?us-ascii?Q?gJHeZxY8RVet6VwFWMVM3K8bxSizkfL7gQJ/7duYLycLaB7M5yWMmDE2a/we?=
 =?us-ascii?Q?++hdCUDmUQeOYvcOoBjzOyRTAPDQzgdAJBDAtzLvswSIM/aktT5kID6LrMEa?=
 =?us-ascii?Q?EtyaUSi4GkxxLmmQznJP2qexx6IxVWoRL05Gy9kyRMhOHispE2jxSHj9dW4S?=
 =?us-ascii?Q?rZ9vslsL989WcBU25UXxN9CbCuWueOJCed0HMDOgd5FEqaEKPbxH4TAt4XVT?=
 =?us-ascii?Q?PwEyjwUO62jbMqXfzHg3gOY9jXN3/DZWOQJbiNuSkVFjrJWmycLckqnPTv0L?=
 =?us-ascii?Q?ueNrleGyM0Ug7u+pfgkct7R6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb0239b-eb48-432b-7c7a-08d92b0b3f0e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2091.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 05:55:55.4603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AooBm1L8NiEcNkFBDRMx2CuxCq6yDWVRnxcpQ3jydB0JLpHwcQsToAKXH2gACKXghgyNlp7ePq2f/cNSvIEcDb799Icl3thnb22/wJLvcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2217
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106090018
X-Proofpoint-GUID: ceqfm4T-3uQUngq8_ucBgW9K7kXkCudh
X-Proofpoint-ORIG-GUID: ceqfm4T-3uQUngq8_ucBgW9K7kXkCudh
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106090018
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

In that case, the default GID still gets read from HCA for IB link-
layer devices.

Fixes: fad61ad ("IB/core: Add subnet prefix to port info")
Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>

---

v1 -> v2:
    -	Split the v1 patch in 3 patches as per Leon's suggestion.

v2 -> v3:
    -	Added changes as per Mark Zhang's suggestion of clearing
    	flags in git_table_cleanup_one().

---
 drivers/infiniband/core/cache.c  | 7 ++++++-
 drivers/infiniband/core/device.c | 9 +++++++++
 include/rdma/ib_cache.h          | 6 ++++++
 include/rdma/ib_verbs.h          | 6 ++++++
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index e957f0c915a3..94a8653a72c5 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -917,9 +917,12 @@ static void gid_table_cleanup_one(struct ib_device *ib_dev)
 {
 	u32 p;
 
-	rdma_for_each_port (ib_dev, p)
+	rdma_for_each_port (ib_dev, p) {
+		clear_bit(IB_PORT_CACHE_INITIALIZED,
+			&ib_dev->port_data[p].flags);
 		cleanup_gid_table_port(ib_dev, p,
 				       ib_dev->port_data[p].cache.gid);
+	}
 }
 
 static int gid_table_setup_one(struct ib_device *ib_dev)
@@ -1623,6 +1626,8 @@ int ib_cache_setup_one(struct ib_device *device)
 		err = ib_cache_update(device, p, true);
 		if (err)
 			return err;
+		set_bit(IB_PORT_CACHE_INITIALIZED,
+			&device->port_data[p].flags);
 	}
 
 	return 0;
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 595128b26c34..e8e7b0a61411 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2059,6 +2059,15 @@ static int __ib_query_port(struct ib_device *device,
 	    IB_LINK_LAYER_INFINIBAND)
 		return 0;
 
+	if (!ib_cache_is_initialised(device, port_num))
+		goto query_gid_from_device;
+
+	ib_get_cached_subnet_prefix(device, port_num,
+				    &port_attr->subnet_prefix);
+
+	return 0;
+
+query_gid_from_device:
 	err = device->ops.query_gid(device, port_num, 0, &gid);
 	if (err)
 		return err;
diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h
index 226ae3702d8a..1526fc6637eb 100644
--- a/include/rdma/ib_cache.h
+++ b/include/rdma/ib_cache.h
@@ -114,4 +114,10 @@ ssize_t rdma_query_gid_table(struct ib_device *device,
 			     struct ib_uverbs_gid_entry *entries,
 			     size_t max_entries);
 
+static inline bool ib_cache_is_initialised(struct ib_device *device,
+					  u8 port_num)
+{
+	return test_bit(IB_PORT_CACHE_INITIALIZED,
+			&device->port_data[port_num].flags);
+}
 #endif /* _IB_CACHE_H */
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 41cbec516424..ad2a55e3a2ee 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2169,6 +2169,10 @@ struct ib_port_immutable {
 	u32                           max_mad_size;
 };
 
+enum ib_port_data_flags {
+	IB_PORT_CACHE_INITIALIZED = 1 << 0,
+};
+
 struct ib_port_data {
 	struct ib_device *ib_dev;
 
@@ -2178,6 +2182,8 @@ struct ib_port_data {
 
 	spinlock_t netdev_lock;
 
+	unsigned long flags;
+
 	struct list_head pkey_list;
 
 	struct ib_port_cache cache;
-- 
2.27.0

