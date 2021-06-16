Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4297C3A9332
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 08:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhFPGyy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 02:54:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:39024 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231867AbhFPGyv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 02:54:51 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15G6kUZt022889;
        Wed, 16 Jun 2021 06:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=Cx8AgWs1hpzShOUQ243TfZH9vS1K4MB+r5j7SE0QIfc=;
 b=tAAh46nqImZHs2/nZ0xlWCfJ76wVbeXnLEzqsbkG+E6T7hds4aPtKJo8paGz9xcrU+ZQ
 591aiV50avjnnqyPWhA7qpxwT4HWx+VD+VwDlIcidUeRUpnPDa68oyd7rTfjO6uv5zf1
 jsE4euOQwptbf7jNZ9scXuCLrOcOvTl7uWP28ebJzOy2M1GuOq+mp8mQVfMkK43r5htY
 v+SYgj5tHtxbmCbQdNtW/Hr9MfiTXlQCRmRkdgC+KfE+rqhuok2KqdArHn7DfI2R/Pe4
 ltE7EKWqzJ1eZr0qCizNxLlW2isE1qyGrr7S4sBUi3sQqYuNgP3z1WJqnTDOV1pLbVf/ RA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39770h8c23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 06:52:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15G6p3ul089864;
        Wed, 16 Jun 2021 06:52:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3020.oracle.com with ESMTP id 396waseyye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 06:52:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWbbGWUFNjX2JjxLdHt/nAYX4EkMn5fEjZ4+FOQD/maY8tbJUYsaCwMAjOgWGpibB5ZUbuuTow/ET8aKrgkG9nDlBaiYUG1o/v8XdBkILlSw/AEC91ApzK0AmmAdsuPGSb8BiWecMxlwBhHb9Nkh7drwBSOzV8pP7dwuHsDVqck+S9IqaTnVmaqpIH6dAQIUsRegooGH/X68ETarfYuKWvSIsxxI/vIKA5AUwvFL4iZSqIJ+LWv7p8FL0D6pS63rMHnG6hWCwU35quchTukNaIx64JjeppJbH8yqY9KzJcgbtarrKjL3DwFJWCchKdD+LsM9VDB1CAL203TCWHFumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cx8AgWs1hpzShOUQ243TfZH9vS1K4MB+r5j7SE0QIfc=;
 b=TtXfpUPDf5LFmqczB4iSXYBxaWf78G5CYjujtm+DiKFzG8du47oYjjVUtzxrdaLa/NGfE7AlW1eybjJVdyCrWVF6FsXc2+dKRhCBrXrIl5dyb3AW6onpUYefwPvnOoBMeo6lXHVyqWrmk5GVKzrpybKTlq7iudetyDRmQQJR4gXGArr907jeqKeDiDqoL+yTbkYNTP5v7rStKQBaG2B5CA1kZbIHG52Do8kspdg9FMwpEF9VcKnvCqmli5snepGhxijer+nik/AT0yOdTJyXwMizDTeuoRlFdu5VRVf0E4CQwRqsUq0gvZyU1eisgAyeOr9BO/mjkrBN6jQSeraU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cx8AgWs1hpzShOUQ243TfZH9vS1K4MB+r5j7SE0QIfc=;
 b=L/qwj+neBsrHEkUXLTrYY1OKpQeFhh2zp0lR92OSBYd2oQxgdckloJmrBERKawEqe5y58W1Tw974I3Q7MaOxNfrSswCwYUaP6EvwvqPesyZoVHbZExVUoRuECN7RX+/U7xNPNq/lFtWc8av/5rGbFbq7d7dPiBX79cxe6Nq62LQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com (2603:10b6:4:2c::21)
 by DM5PR10MB2043.namprd10.prod.outlook.com (2603:10b6:3:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Wed, 16 Jun
 2021 06:52:40 +0000
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::211c:a5c4:2259:e508]) by DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::211c:a5c4:2259:e508%3]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 06:52:40 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v4 for-next 3/3] IB/core: Obtain subnet_prefix from cache in IB devices
Date:   Wed, 16 Jun 2021 12:22:13 +0530
Message-Id: <20210616065213.987-4-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616065213.987-1-anand.a.khoje@oracle.com>
References: <20210616065213.987-1-anand.a.khoje@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [182.70.80.33]
X-ClientProxiedBy: SG2PR03CA0139.apcprd03.prod.outlook.com
 (2603:1096:4:c8::12) To DM5PR1001MB2091.namprd10.prod.outlook.com
 (2603:10b6:4:2c::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (182.70.80.33) by SG2PR03CA0139.apcprd03.prod.outlook.com (2603:1096:4:c8::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Wed, 16 Jun 2021 06:52:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23a6b455-2a16-4ecf-d312-08d930935572
X-MS-TrafficTypeDiagnostic: DM5PR10MB2043:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB2043703E6E8F1A0FD0613E73C50F9@DM5PR10MB2043.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WNQ115DHYSoKbJxXfELc1pSseMnKKyR+XinELm9ZxljyK1DqP3u79JJYkD1kMYkUzLXmoJJAZO2LGxWaysRYWHpGbgkImG6SZe4TlTYI6olgDS4r4jP622VnSc7lkL4iZKDoM3+08gGBAPbYKrsB7MfYm75i9qRlvG/zcg0KNwBB7tV0iAbWUFGWFzL1GfQnrNjKis1Fw6aV3pLnONLSo9i3XCrntbWhQE+dwIMrIWq+C0rnAUuPUeWajGnTv94CfGhrIESaA4VkS51D1wJPLeBALETIxHZYcGnHNb/hbzOdm3qFPzYInTjCzh1Zyi5DdyB67JVW4ms9uQ2l4VG9n8d2NnIyTqkLkXK3KZEj+SkLNPE34X2qg9IVtZXIRY4md9ShbR6SlqbpoKtlSVmpW8TgH2tNUadgX5spGBMGZppxTjxBnFwQ6C9W/KgfzgnV4UWpMJrG3BjEEuWFta0xj71gxxSQHOs9G35LWXVvK/cYnMAtucjCjzepFVoai0SfzLg77bhrmfxschCQpYCo+AiK6Aj8QKjhPu3NRVlUgSvmzEHhAzdxtrdyjyf36znuE6n4nuUQLcyeO+o+ZM0qkwr4FEo/eALhkPUeBotx8CCcAdAVbOTDgabuz+5J9YRWeXZk5pdgoADyhiQPE50b4Sa5zBEoWWkT+4F9g2bY5TuUEP/sWYx2LQyefTVFVfrF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2091.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(396003)(346002)(39860400002)(6486002)(66476007)(316002)(7696005)(36756003)(52116002)(16526019)(186003)(5660300002)(66556008)(66946007)(8936002)(4326008)(1076003)(103116003)(38100700002)(83380400001)(2616005)(86362001)(8676002)(478600001)(26005)(956004)(2906002)(38350700002)(6666004)(120606002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pzMoBi+nN7tm/eEmPe4GdJM3eONVupiNgOlHTWbVfs07xATqVD2BTiB1Nlki?=
 =?us-ascii?Q?klIcM2XknJm9M9MP6NDyw6b1QJgUeGrwkRN8F1fOp+6dhbgFbKrymYQqquLW?=
 =?us-ascii?Q?t6U0+XzD9t9b+grIjsgpcexHBDm/AeaxsxQ61q6FfsQXD7jo1PbdPBFJJny4?=
 =?us-ascii?Q?EI0oYIbiuY7xqfBsAf+GpabDAHIEOl/9in6E9uT4ocvKBXO+wBvWKBjJBTfd?=
 =?us-ascii?Q?msnIK4CKElHvx2JSXlSgbukEGANhmmd+cepbzIPZPOw/DqilBiQ16GtI7/tc?=
 =?us-ascii?Q?imPM+4Qco7R4IT7u9Js0b7rDXImCLrj4yNpviOkbhvP8a0jUEp+zR38QQeq1?=
 =?us-ascii?Q?UDRNo77qrQafkJEztSEyhFaa1aYRaq3tiEnZ4Gs6eyjOXmAHJNagqaveTeb7?=
 =?us-ascii?Q?t5ExuRBq0u/9qK50qKYLDCo1dmghJEseQF1vJB/zAVSnRs6d+ITCv0czrafx?=
 =?us-ascii?Q?01UR25PqcHTCKjvU9CofN50VlfSHNTfMkjmsKSsw2SH6CxBNeplYqPXCV+h8?=
 =?us-ascii?Q?o8/zM2hxLJu4XLa0SuQy+SqwF/A2wyuoN1kqf7iJr2QUOpWjTj8rrpLOR8nc?=
 =?us-ascii?Q?y3fkNJZyqW76Kz3U0338uAlzoeobv8HLYt+aZf91fLAptZKbP3XQUzVmFXDm?=
 =?us-ascii?Q?jm1DzfY9S6kBx37BkT3OExrOUAOB7fEstIzuxwffJd9hWNZuNRJfAxEipagR?=
 =?us-ascii?Q?4UQFKhZPvP4Af5NCALJ+1ZqPVkPRu3/PO4hf6E4hN8SY8ayZHCuk55UOBFVW?=
 =?us-ascii?Q?J/BAO63pmEIpBQQocYqfVU4D6buE1LHLkRHEfq/R0Ko7NtxEXvDFfEFah4e2?=
 =?us-ascii?Q?lZXGkbinPaae6vJROF87rRYpSCxM3KM+Qhm8759Of2fAepr4sf0JN05lHF0i?=
 =?us-ascii?Q?uhMhzrfQiIBj+0LJBvVJb3/+k8tpTQ0v43pcdsRDCrVicDTqb/zA9+XyO3r5?=
 =?us-ascii?Q?2ONz0DDdIusUnX9pdGPkfi4MPJXC1Qb/aUV+2WLOFt+iOoofKeKkiZGZEkuT?=
 =?us-ascii?Q?lJxQkUkSa6sB65JV66l/Ni5EfuQDQ9XnPQDOA6vIx4bSi0kDTZxruxTeqwD2?=
 =?us-ascii?Q?X9ciwtJj7YrKaAC1SEaYou4Z793+/RrpFQzQqEw7YJy2qFiCt+M+XIsiB9TR?=
 =?us-ascii?Q?rw8jEGlUsP8Mmz4efi6dyqdWyNZnbG5U2O4OmFdqA+sTOWwb+TI86AIfaMOT?=
 =?us-ascii?Q?0CwFWl+A8dZY+M4G4rdKnIKddE0Z2vK/Z9AyPg3CC8jR0Z29Jz938WYvlCTC?=
 =?us-ascii?Q?Za+FKsYZlwkYYtjAZzgeC6x+u2UZuXDTxhrnOKCgbdNlQKMesMWR6GLvfFhh?=
 =?us-ascii?Q?YSxgLcYn8KyfyNYKRGsROo4J?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a6b455-2a16-4ecf-d312-08d930935572
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2091.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 06:52:40.5178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kT92jJeQmu8olYLdTdGfidsVTX2n+8Id5Z7sAigEWBygfltHaRixxPUaQMsA7nn+hsWr2Z/mMEfzPTVqdDIQtfH25jQIWTW4kPhU+DmTdX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB2043
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160042
X-Proofpoint-GUID: kniKsrh2OVDdQLUGZpbcPY6WdYPMZ3iA
X-Proofpoint-ORIG-GUID: kniKsrh2OVDdQLUGZpbcPY6WdYPMZ3iA
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

In the situation of an event causing cache update, the subnet_prefix
will get retrieved from newly updated GID cache in ib_cache_update(),
so that we do not end up reading a stale value from cache via
ib_query_port().

Fixes: fad61ad ("IB/core: Add subnet prefix to port info")
Suggested-by: Leon Romanovsky <leonro@nvidia.com>
Suggested-by: Aru Kolappan <aru.kolappan@oracle.com>
Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
---

v1 -> v2:
    -   Split the v1 patch in 3 patches as per Leon's suggestion.

v2 -> v3:
    -   Added changes as per Mark Zhang's suggestion of clearing
        flags in git_table_cleanup_one().
v3 -> v4:
    -   Removed the enum ib_port_data_flags and 8 byte flags from
        struct ib_port_data, and the set_bit()/clear_bit() API
        used to update this flag as that was not necessary.
        Done to keep the code simple.
    -   Added code to read subnet_prefix from updated GID cache in the
        event of cache update. Prior to this change, ib_cache_update
        was reading the value for subnet_prefix via ib_query_port(),
        due to this patch, we ended up reading a stale cached value of
        subnet_prefix.

---
 drivers/infiniband/core/cache.c  | 18 +++++++++++++++---
 drivers/infiniband/core/device.c |  9 +++++++++
 include/rdma/ib_cache.h          |  5 +++++
 include/rdma/ib_verbs.h          |  1 +
 4 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 2325171..cd99c46 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -917,9 +917,11 @@ static void gid_table_cleanup_one(struct ib_device *ib_dev)
 {
 	u32 p;
 
-	rdma_for_each_port (ib_dev, p)
+	rdma_for_each_port (ib_dev, p) {
+		ib_dev->port_data[p].cache_is_initialized = 0;
 		cleanup_gid_table_port(ib_dev, p,
 				       ib_dev->port_data[p].cache.gid);
+	}
 }
 
 static int gid_table_setup_one(struct ib_device *ib_dev)
@@ -1466,6 +1468,7 @@ static int config_non_roce_gid_cache(struct ib_device *device,
 	struct ib_port_attr       *tprops = NULL;
 	struct ib_pkey_cache      *pkey_cache = NULL;
 	struct ib_pkey_cache      *old_pkey_cache = NULL;
+	union ib_gid               gid;
 	int                        i;
 	int                        ret;
 
@@ -1523,13 +1526,21 @@ static int config_non_roce_gid_cache(struct ib_device *device,
 	device->port_data[port].cache.lmc = tprops->lmc;
 	device->port_data[port].cache.port_state = tprops->state;
 
-	device->port_data[port].cache.subnet_prefix = tprops->subnet_prefix;
+	ret = rdma_query_gid(device, port, 0, &gid);
+	if (ret) {
+		write_unlock_irq(&device->cache.lock);
+		goto err;
+	}
+
+	device->port_data[port].cache.subnet_prefix =
+			be64_to_cpu(gid.global.subnet_prefix);
+
 	write_unlock_irq(&device->cache_lock);
 
 	if (enforce_security)
 		ib_security_cache_change(device,
 					 port,
-					 tprops->subnet_prefix);
+					 be64_to_cpu(gid.global.subnet_prefix));
 
 	kfree(old_pkey_cache);
 	kfree(tprops);
@@ -1629,6 +1640,7 @@ int ib_cache_setup_one(struct ib_device *device)
 		err = ib_cache_update(device, p, true, true, true);
 		if (err)
 			return err;
+		device->port_data[p].cache_is_initialized = 1;
 	}
 
 	return 0;
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 7a617e4..57b9039 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2057,6 +2057,15 @@ static int __ib_query_port(struct ib_device *device,
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
index 226ae37..46b43a7 100644
--- a/include/rdma/ib_cache.h
+++ b/include/rdma/ib_cache.h
@@ -114,4 +114,9 @@ ssize_t rdma_query_gid_table(struct ib_device *device,
 			     struct ib_uverbs_gid_entry *entries,
 			     size_t max_entries);
 
+static inline bool ib_cache_is_initialised(struct ib_device *device,
+					u32 port_num)
+{
+	return device->port_data[port_num].cache_is_initialized;
+}
 #endif /* _IB_CACHE_H */
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index c96d601..405f7da 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2177,6 +2177,7 @@ struct ib_port_data {
 
 	spinlock_t netdev_lock;
 
+	u8 cache_is_initialized:1;
 	struct list_head pkey_list;
 
 	struct ib_port_cache cache;
-- 
1.8.3.1

