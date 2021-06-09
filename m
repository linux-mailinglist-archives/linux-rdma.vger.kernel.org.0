Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD2D3A0C18
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 07:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbhFIF5y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 01:57:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53100 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhFIF5x (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Jun 2021 01:57:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1595ovrj051925;
        Wed, 9 Jun 2021 05:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=zVO/ufUnpzdpLeNXWtf7p1UL46MNrXcF4o5Knb9saFw=;
 b=AUfR8kkOgvffQ0pU+1U/FztXBuRleolh/DTiMQwyPHyJHDO9okOTz/PixMldN/QVIl4c
 k0IROnXkmnsOMa6aFH6fEcjco64bX6/k2g+k7157v+cFeZhszi1K7RgGYJ5X2Q3Ir2w9
 uoH+ebnMdXqG/LLdoNFhs9cGIp+WtwsJ1OtrkZ4M2TdEe8xxNGiESJYt7s17C0YdTfeM
 xARanfI5wjHJcf3j+fr+qCBvWzpgmIRkx71N375ZOXr0nl7V/JEUL0RC/T+LYE/Z/vbq
 scZ6OEPQaV3fZtT1SVwmcwSnDEEAUzXVHZzcatbou3kZifhvW228NxXIPwA45wZffGpu Qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 3914qupg5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 05:55:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1595oYX8160732;
        Wed, 9 Jun 2021 05:55:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3020.oracle.com with ESMTP id 3922wty147-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 05:55:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuOIBJwZMrrzKoplf/Bbb6+NX4ydhqO0Y4x0R3ZA/RXIR7lNzV4A6pxjcoLb87uyq1I72PpYhvlRxhJTuPVCAdXWvaYMBdbSfKEtQ/lwamkIqQno3odG+35IpUSGUGUV0tSjhXvRcToEYrHpFAWCOO+ZaRiDw20yDe0XN34G0G6hGkmeBxaCFzk5YrW8kweeyd3K6VTrSwBXIRu3g0WwRrR3hxCo+dRteITdUyYcaE+QX0cTkFdGeSUgw/C2VKQvAda43bz9CFknol99kVlSEmeSFKF+ykpLHaur5whuCh3HIhWxxAt0qUz0fySFGFc79SdWGEYJI0WoHyXXH/s8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVO/ufUnpzdpLeNXWtf7p1UL46MNrXcF4o5Knb9saFw=;
 b=hi5IT9KzLfMEkrrMKldU75AEIIUMSUVWY4N9jsLtJ5ZjvgFjtE9z459PE2u3hWBYcCU7v3gfkJsdtMFBd4u5A9Wj4Hyyj/bNQQxH1ZUlSwMko/GT8pvVTXMVUNUDlM93OZqkDzaFBepSHtO4K1xeONmneUfWXAaIfH+i/KN2yKTT6C580SToM3H+rLwgzl2N9/42Wjp0W8pgp4Oktz4WKAEDVnY3qCG5QDGvSDz/neZSOXz3fZX10riUqmIebTla2kfDtMssVo9CmREnuxjY6tKfY78HBisp1om4dOsFItzUoIVRJfrNb4x7iijhnWH5UOp3MqY3eASQCLwbOAEMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVO/ufUnpzdpLeNXWtf7p1UL46MNrXcF4o5Knb9saFw=;
 b=ZIfX+CnOcNK0IaJGgz2qbrWG24xYfRYl5pWbFM6Xt+JE1qDPJy99dw3iyFgsHXOxn7SrPEqNB+/QuxbXXaKgKVpyuVYqco6SVzEhTgAN93PpJb62r0zHNzvZcvFQbSoz7PHBGpFzbNhZWkqUVEk3877zTXWagIJ5uV05ALHep2s=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com (2603:10b6:4:2c::21)
 by DM5PR1001MB2217.namprd10.prod.outlook.com (2603:10b6:4:2e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 9 Jun
 2021 05:55:52 +0000
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::5c05:40f0:dbae:4c71]) by DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::5c05:40f0:dbae:4c71%5]) with mapi id 15.20.4173.029; Wed, 9 Jun 2021
 05:55:52 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v3 2/3] IB/core: Shuffle locks in ib_port_data to save memory
Date:   Wed,  9 Jun 2021 11:25:33 +0530
Message-Id: <20210609055534.855-3-anand.a.khoje@oracle.com>
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
Received: from AAKHOJE-T480.in.oracle.com (171.50.202.152) by TYAPR01CA0029.jpnprd01.prod.outlook.com (2603:1096:404:28::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 05:55:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bcfe982-9aec-4ba9-ed27-08d92b0b3d5c
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2217:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1001MB22178B6B8AA7AA5FE2C2C8ABC5369@DM5PR1001MB2217.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uga8rHmHjJH/m7FhVtuaUanYO8Fd3ACHEHKEGS+0koIPOGQj8i8BdDrgJNePZb8xKCxb1I7364dApm7osiE2o94kfgNQnjv2vZtoRpwQiToWRQ+cN+L2SzEBpYqtYziTvaY7oQOCv9WUsBuRfCkf0QHk4bLU2HqD8cTg4O5R2inOVtXTcC9xxPu+FsYQPMqm3P1epEALFHznv5rz40pKaj3CUiG4aSX+7/zpnShZvbs73bSrKFHlP7eM3KoGcpMj6KUXDKXBNpliU160wi0Tn1QHW1SchGB0D8n3yP5QD2iQLGOYm+5BChwi681hceVgBFHpf31EKeVWX9ht/9UVVbl2S89N4vKxJBlsE/Vx5DuhTD+yDb/uVHhLg4l0YZa11VDRe7wvQhSUB9kvpjwqknbhn5uneV5T2ue2HCqERpihChczoGBzxP95HGjajlJHarewe6lV/V8FfD2HJQW9aX20NAS0rRyRBDa62iIjtDeU+Q2l5iWsSewOQGHcDjwcIW6ZZKKmnl5DHfo542VtOQEVY0IcFx5E/6sI+moK73G2Yuq/60plM2EMZlbdGUqa5LQt94Nf3MegzAiVHEsMkKuJ++MkmZB++PW+BYfN8UbmpXwum1z1NrcwI9YE5YsNuzosFOFnFzOjm0tEoFm3KE2kP+74t2frUj1rLftgPi4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2091.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(136003)(366004)(346002)(956004)(2616005)(26005)(6486002)(1076003)(2906002)(316002)(5660300002)(8936002)(186003)(38100700002)(6666004)(16526019)(66556008)(38350700002)(86362001)(103116003)(66476007)(52116002)(7696005)(478600001)(83380400001)(4326008)(8676002)(36756003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2duImkrJfHJOWGM1PLKhnCgdsyveMDe6UfbI2VcijRFVLaGO3DR3jXFufr6q?=
 =?us-ascii?Q?s1BLcetWzsh1kao5bwkbnpM9fdEBKLv+Olp79LbI/PSO/OiO2s9RFB5NSjEU?=
 =?us-ascii?Q?MlerF8KDwMK81PHxvIER7MNuRwNoopoDY7DBrcwEsUeXvWEYbQXoDf46kOhg?=
 =?us-ascii?Q?5QRKNlwaODHQqul6lx1lb+Q0HoP44kJgt2oehvqlNYct5xS5V9Hbv/8HGA0Z?=
 =?us-ascii?Q?m7g3yE4dsUSBss0MXTk53ce1IY2fO4ZBRX9eZwyA+hTdT7o2c5SmYH6dnYcF?=
 =?us-ascii?Q?+uB8m8PKOJZGZ1Rxwzkl7+O7epKtFDrAKkUnRwO5ebbEx8wvUQmBbNPeuqUm?=
 =?us-ascii?Q?/XXolD2enoqWvf6emwD2/F3yURC/bwiSfg4tPnjVFnMi2Zrd9RckjK+FJDZa?=
 =?us-ascii?Q?/XYnlVltlRmVCsnmUgB80SBjdwNORf4jAE207vCPdu5z0BR8bGU+frtMpRta?=
 =?us-ascii?Q?IS9XEfvC+I9xOwdJdT+6nojmap+exxJUT9DjVhPmoC1o6vg995mQcmS0Ivf/?=
 =?us-ascii?Q?rq/xV8no8M8xzCqbYBFw7faJu9wSGL/eNnh4ePL12F/Lexzt4fabgH1UBhdw?=
 =?us-ascii?Q?yluqqlwxBg4JaFmi6QRAuupVnFJP8omgvOOIflPoFbiJ4kC/KOxkTIX9w8ig?=
 =?us-ascii?Q?jp3FnJ23UIx1f5kAEII5OykENNIWa7CWXSMOwhf6gFprj3ehKUT6GVaSRGcG?=
 =?us-ascii?Q?8WOm4+khX2PJuGyAaFP7Zc4NPaMOP390avoi58ZAktPqbFGCF86bSbBAPKh0?=
 =?us-ascii?Q?MxJAbIMdTPxMi/ytQ+ykgsm+v+Th/C5axiDUL6u0idmP87tJJCYdwVoWxL+e?=
 =?us-ascii?Q?iVKMlc7QmA+wXC0L+1Dz/pz+XKJwwAQQe4AkG1506aoa7MbeMG+f2R5blbvi?=
 =?us-ascii?Q?qTWgUw5gysfb6ln8C8v4v7CVFJQBobXmLEsOy3T6ZXRx4UyUFa2RE6Xxc2ns?=
 =?us-ascii?Q?tdmqMZi1aF035osC6dP08MDaVkuogDlxvb1VwUwTaHl/T6BP6jl1O+31yBBG?=
 =?us-ascii?Q?7ZmNIorQWm8kwqfyzeQ/zxHvoMVJrWrslXmBNdWhGxMYKlQB9FP5jTD0a2gu?=
 =?us-ascii?Q?ulTRIAF1TtAyBiT/8BIHxP95JgBJkwZZQGck/H3qFlGL8kqkh1wylBcR974b?=
 =?us-ascii?Q?shrrrJJgLJF5TVSRM4UXMKKqmxFiXMlpDw1KFP4BkucrxqFiWtaMmmhDmfPk?=
 =?us-ascii?Q?wE7niMzqL6tqR657nku+VWuaej6jMAcFSSpW1pnk6FSl3sgbf3b/mfZ+L8D0?=
 =?us-ascii?Q?tGV0d9RDMU0fhBzMtAsT8sbkeVQ57I3IEleL3QbjzxjnuZ5jiBgP9QhVnwuJ?=
 =?us-ascii?Q?Vx7sYJnBYFf4ZTmvyJlRuiYB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcfe982-9aec-4ba9-ed27-08d92b0b3d5c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2091.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 05:55:52.6279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5wl/yiQPbPz31saDP7/R//0hG3PADYjUnBi6TLXvUqAYsZxIaVqLlA9m4flzaWsMswMkTzZGflq66hGyYi83FjyNmKocN/z+/us2eny/u4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2217
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090018
X-Proofpoint-ORIG-GUID: g1-in51su9CCwx2kIcyY2ZIq7Uumor6j
X-Proofpoint-GUID: g1-in51su9CCwx2kIcyY2ZIq7Uumor6j
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090018
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

pahole shows two 4-byte holes in struct ib_port_data after
pkey_list_lock and netdev_lock respectively.

Shuffling the netdev_lock to be after pkey_list_lock, this
shaves off eight bytes from the struct.

Suggested-by: Haakon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

---

v1 -> v2:
    -	Split the v1 patch in 3 patches as per Leon's suggestion.
v2 -> v3:
    -	No changes.

---
 drivers/infiniband/core/cache.c     |  6 +-----
 include/rdma/ib_verbs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 7e2f3699b898..41cbec516424 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2175,11 +2175,13 @@ struct ib_port_data {
 	struct ib_port_immutable immutable;
 
 	spinlock_t pkey_list_lock;
+
+	spinlock_t netdev_lock;
+
 	struct list_head pkey_list;
 
 	struct ib_port_cache cache;
 
-	spinlock_t netdev_lock;
 	struct net_device __rcu *netdev;
 	struct hlist_node ndev_hash_link;
 	struct rdma_port_counter port_counter;
-- 
2.27.0

