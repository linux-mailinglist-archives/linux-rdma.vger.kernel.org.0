Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC27A3AA04B
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 17:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbhFPPsR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 11:48:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23818 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235629AbhFPPro (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 11:47:44 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GFgaiq032158;
        Wed, 16 Jun 2021 15:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=gRvhXvfiFGs1PFaln8O2IWi88XqwNFi79YVJ0VzHryQ=;
 b=sY1IceE7DVso7mdJra7H4QfdDBqtYS0A3xbvIW4TdQsLlwtobkUUol+95JhBHYd08GLN
 rhkdI45FEJ3488DWqPRuCEN1Vlthc34lv+KyKKlovchH8DWaWlovQNi+rJXK3dxq8F8D
 G9CYSv8ht4JMT42/VkSsiOxiOoFpNiN6SbdO4GKMPKCQARXJ2umO1IccbcNWN3Yc6Ok6
 lz3O3IUgk7xHTjpIC+xUf2T1sXLG0VdBcwP5XM7MQ2HE3Ha1YJQUhpv/S6IPHJAPfI3L
 q11+S2Lac0Sm5uFfWHIoCu1fh5n4zLaRFtYJa/o/nR+1bxx+E5uZyHdphBybh10eZM0c 3Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 395y1ku5kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 15:45:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15GFf6BM078192;
        Wed, 16 Jun 2021 15:45:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by aserp3020.oracle.com with ESMTP id 396watguwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 15:45:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/JxMMGp9H+FSA8qlY1mZqiixC4gC2AM1YSfkHTBOF+L2PLxwuJ7SQ8giVSEi5yuoQG5dwP5o0wFuYjyuaHAyJuiCwaFK/BSB8Fhe2HKrBnOwQzjwHTyS8in8RS4B4+MvSlNthV+9sxi0/92aXmUQkEJLRuC99a2JvnTKdSvJ2mVo8fBq29Y3E4Lq33WlGAmGVlla2yEgIdSBHmt64XbpcFGNtzYvD+TwmsG1IxgrScZRat1Qe9k+SqLBJ+5NmHx1Qemms0Irnv6ipFgOLb0q7aga0Aw4QX6vhgLufuNFa65X84wzN8ti7+syoxBM1gBATcrrQl9zG0kDS5zUkwK9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRvhXvfiFGs1PFaln8O2IWi88XqwNFi79YVJ0VzHryQ=;
 b=VAta8lOPY0J5YxIt2FK/pJMo4hMqncs+G7b58we+IBvYNKMriFqfspcsnwIqVm2rUgGur85Y/FDnC8WI5HRoJtKiMHwXRS9DtAqcAFMuaFWMI2CToH88ie1RcKI9fNfJsQek7wzb/WfCR0iqrK2FDDIWmKxBjNifUXBt/Ny6grOjqetZPBcnKwLtA+FAHQwF+9FqMQRfsLiwAywCNsEKpI5VmekRvikp9/kwDtzsZL5VtzSgIwxHXknyoh4E9gnVsmriTL9KrF41bRq55J5xQYw8UdoZ3O0x60tjyL2XmIQSyDkiVIuK4rCWEI9k3R6IZvqZuytZceQvIAMwoVzDaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRvhXvfiFGs1PFaln8O2IWi88XqwNFi79YVJ0VzHryQ=;
 b=Oas7NGk25QvD1yCWeR/opUzLDypoEFlvQj6JlxtFTmB6++PJ6LNYdV0QWLQkrKnVvC+LHUc/J+cM80UoL58Vjodq6LpOm6Gg1V4Xh4BhcXCTpcv7rtVzGmCwL7sw9AtHy5ix1PlqzCcdEnzP0at+g0bWv1ALmhq7U20llPOze5c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com (2603:10b6:4:2c::21)
 by DM6PR10MB3754.namprd10.prod.outlook.com (2603:10b6:5:1f5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Wed, 16 Jun
 2021 15:45:33 +0000
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::211c:a5c4:2259:e508]) by DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::211c:a5c4:2259:e508%3]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 15:45:33 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v5 for-next 2/3] IB/core: Shuffle locks in ib_port_data to save memory
Date:   Wed, 16 Jun 2021 21:15:08 +0530
Message-Id: <20210616154509.1047-3-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616154509.1047-1-anand.a.khoje@oracle.com>
References: <20210616154509.1047-1-anand.a.khoje@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [182.70.80.33]
X-ClientProxiedBy: SG2PR06CA0129.apcprd06.prod.outlook.com
 (2603:1096:1:1d::31) To DM5PR1001MB2091.namprd10.prod.outlook.com
 (2603:10b6:4:2c::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (182.70.80.33) by SG2PR06CA0129.apcprd06.prod.outlook.com (2603:1096:1:1d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 15:45:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 817175d0-72b5-4cd6-3cac-08d930ddc69b
X-MS-TrafficTypeDiagnostic: DM6PR10MB3754:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB375493E2154DEE46462B6C71C50F9@DM6PR10MB3754.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ow3BiTJcSYFzgeGHyxkB6dLxhgb6N3IGpO0nRt87fVXFc93kfwm4FtgArXFUWuc7j8t82iZuSvR4Jzg68Uu5KnA4aSiSgcDv0Q3ZOFQENmSTRVCGzOC+eMklQbTP8Ql6yagZEl5A5qD6Hmh8SuLjkTjK4t65kDjNthJlTg3+27bWSrUjWqZiAQDJq9HBJTF3B7/03S8dTBEKC9hjbGnLXKkt3z+WR+ZPIh+Iz5XGw6vvWgOAhAmOsgONdo4RlkYAyN4Jk+xTshca5ggNlOy/UZ1mTaop807HKv2AJdVD9+dybtF6OuxZ++YldBHIK73/H+9cZTbETp1E+0osu74Vc/+dCpGG5ZN3p40b3EHiG/Bkgilu7rhEzkFanbc5xFIptnFsstMbQ20T53GzqqOIrMahgcsUZZpG/wBbpJ/osMnW+cQ5jbnfXP/lhg40cNr8Xa1C5qjJo6Pr9TD42TIsjwI42+2Aq4SbCHvA47cE/6S7DBSy/V1mbR/E4xA1C3r0Cv0wI23zwpjWTALEgsWgYdFhiqKmD+RXAl3CWHGem3wyhrMh72gqTqWupEruLuN3hC+5fvy2cXSeyR4k7mABZS7TrD9ZI06MYTgaKGNWYBecxiOa39tv+6njazA07rPp/c6uWQVKFgLS0t5frdadkgqjPI9N/MltFuDqzVIxr01/qqd7Mgrwi8OLelMgmnKh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2091.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(366004)(136003)(396003)(2906002)(38350700002)(86362001)(6486002)(38100700002)(8676002)(186003)(26005)(66556008)(316002)(6666004)(5660300002)(16526019)(4326008)(2616005)(103116003)(1076003)(52116002)(956004)(7696005)(66946007)(478600001)(83380400001)(8936002)(36756003)(66476007)(120606002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /i0D9ffaQI3ch6KHgYe3nJMC8JJHG2NV4S+cPKcFaqNU+HbrDxgzz5mxMLMJBYPomL3UmEmFDW1iuI5x0+6TT35jJ+ZngxgVxaZ6rlSvjvBfpupUylGE/WzmPItVHmdqapLYQBuf++QVzH2YcHTMorJ5vNoJUwyPFEFas2y/tgg/VoHdl22jTpANDcM6JRdyHHBJHC6ks+oZIy9RN9KUoKb3LPk82YpOf7YEkK1Tq32YtCD2CXbKEVNIyDeMFQ/sod7Pwk2n+J1qHHJwkSJ5ChDVR+g5crONCt+/TI9TWLjuZfOFjyquLoUEDWQfPI14aqf+6WBLiU/EwwiOnKcw1Ws7ZaL6SI7fkqfwuyBYQV/kQXXbZCMO6p/Hr2fECWvhVk7gGGid4tBsOTS+G0nlg2tAEcW3Zi4XQG/rxBPU7UlFsxUrDGwlhzy15qibwTqSdFd51XivQeXSbP/3RlxYWuu4T6mMwwhKcIizNr/c1GRixmaAJeBv27hU6CvKpcYaXazH59SQnlGmqB0I/jROa3W+dKDKr28hVJInGrIdkDFnO0hpYsbsvmNjaM0TNUVtp6TvNL0jURcnCWzLSPX5x2X3H+njPZCr9D5D1DUOgFOjeygyoIAHBcq+w/tMNH7ose7+2+zo3ZvMF30rWy8afM7leG9vHHHu4frxuA8zwVhBFBi4KWiXvGr8km/3lnmJrCv5jrRoVdGjtfTY8fiP0dsU+6HnfqfnhAQ4o+xAPx76QpB+iTSpUOl4Ge5w93fH
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817175d0-72b5-4cd6-3cac-08d930ddc69b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2091.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 15:45:33.1011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2JXoB3HeePR8z2+NW9xV8ek8F75IxHVcoLHOI7f1qXkeXMVwOi2kSE/+IUHu+miHW1Mlp2pDKHPEDqwCKl+7Tuwfv82pDSAUwzD0MQKeRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3754
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160090
X-Proofpoint-ORIG-GUID: FQKn0xy9EOzxVeP9CrsbgwL7cU7g0cNe
X-Proofpoint-GUID: FQKn0xy9EOzxVeP9CrsbgwL7cU7g0cNe
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
    -   Split the v1 patch in 3 patches as per Leon's suggestion.
v2 -> v3:
    -   No changes.
v3 -> v4:
    -   No changes.
v4 -> v5:
    -   No changes.

---
 include/rdma/ib_verbs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 05dbc21..c96d601 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2174,11 +2174,13 @@ struct ib_port_data {
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
1.8.3.1

