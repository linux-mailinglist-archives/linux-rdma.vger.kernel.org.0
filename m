Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D672D3C8057
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jul 2021 10:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbhGNIiT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Jul 2021 04:38:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19546 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238503AbhGNIiS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 14 Jul 2021 04:38:18 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16E8YPWh013825;
        Wed, 14 Jul 2021 08:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=1CVWB8rLZLwNqgRwiAJYtqyCr4dOUsSGcf9OD6lj5w4=;
 b=MLenbwFoj0xJTlpNQH9BYmxAxHAaqVewCE9c4PoLTt85wr0cQc3MDNN+Rsk51auPFTzj
 ezi284VvPhDxMiGEB+iLHJs/Idoi5f1woILw6goRRYfFakHWVZcm3Y5UXcRdyWfR1CxU
 8g+QLg1gZQ3WpGdZMiYPZCZBTgQc8t5u9SaxlMAUsdHeCypHh1r4M5UJpo8rmWadoZnA
 Oy1hZ4a9w4vRtz8UsL9OmlU1lnm3Fr8kjBmJ5ZuvXxmyYX1AtH1wXPR9OKTGjghmeV3F
 qe8Zn+fXyEgiEEhSmlL6YG9lyivDHMAZdOFJg1CJx1t4+EorKurluawE+UoDmie9M8g6 Qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39rqm0v7d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 08:35:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16E8Ui2b039942;
        Wed, 14 Jul 2021 08:35:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3020.oracle.com with ESMTP id 39q3cep23n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 08:35:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KslGYL0xxnuSaZaJbQEn6aYzRk9SxseXjbccdv1W9INRpMf+uJvYniK62e6VrZ9vJnqbMt/RbHgAIIXSvk2omNEldmC59kkR9E5FEVBpAfLExMaksOGBVW7Fr2F69dXBWnXHm9qTJ1AztXouXUuNpw5QE8vr4ArMMHdQLSIasPKl1Wwwr5Gw/D8H2IbIHGfojBHtKF98lBLB2xgtWzOv2EUvAm6b01sGFngyr3D5vtygOV7ktemaurpEBc69XSZYeHLwnOPN60kRzW/sG3LCRWo2kfHlRITnp6xMmykIYxUIpfA7LuTL5QluCTZSNxwSiiOBcHDiydPgWaVe/lwcDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CVWB8rLZLwNqgRwiAJYtqyCr4dOUsSGcf9OD6lj5w4=;
 b=TjoYUSWYE0wvTjF1t/jIRwz/tdhFA4UcHxO57+XSQ9+M0IHP9PLITEowFQxxhvUUvZEFhSxZXbeITyJf3fTQBQiD/yy3XdqQldb3oMqe4mLubKrmFo801WbhsfbzjDvx+/iJq1+YLKA2SzqAc0FN3SdQiqkAh3jBHzrWjvptRlRToLzSEDjrPoJAjxvT0CiQ/UKhSKeAYVTaha8CeT8QUgLyaEyfCwzLY7aSDX7FNNSNLg5ALUIThiZ9NiEujOXS0MKWEdYa2aho8/bVh/8ciiu3Cl8NFo0mPblOGDoU+921iCn7JCkHBJW+YvVg9FK9uGKKDdT+gU5VdFpLbCKQCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CVWB8rLZLwNqgRwiAJYtqyCr4dOUsSGcf9OD6lj5w4=;
 b=VtbCchwe5XGYteHLo+Sc6EYmBNn9j7gFxP01vy3ckCJHTJqi3fQEpyvUJZ+wzepI7vWoDdnAYIC7tAH+pAwbkyX8y6VafHBXwqT1NgxYtLgo1yNwDXuir0SF07a+6M/gOUNrcPUq9kC6VP1OAU8vpX8jTjzBFjxIUG15J86/MeE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BY5PR10MB3857.namprd10.prod.outlook.com (2603:10b6:a03:1b0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Wed, 14 Jul
 2021 08:35:24 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21%6]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 08:35:24 +0000
From:   Rao Shoaib <Rao.Shoaib@oracle.com>
To:     linux-rdma@vger.kernel.org, jgg@ziepe.ca
Cc:     rao.shoaib@oracle.com
Subject: [PATCH v2 0/1] RDMA/rxe: Bump up default maximum values used via uverbs
Date:   Wed, 14 Jul 2021 01:35:15 -0700
Message-Id: <20210714083516.456736-1-Rao.Shoaib@oracle.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0075.namprd12.prod.outlook.com
 (2603:10b6:802:20::46) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shoaib-laptop.us.oracle.com (2606:b400:8301:1010::16aa) by SN1PR12CA0075.namprd12.prod.outlook.com (2603:10b6:802:20::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 08:35:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02ec0aac-0d1a-4b68-9dbb-08d946a2533f
X-MS-TrafficTypeDiagnostic: BY5PR10MB3857:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB38573A6CD8172FFD48642A1EEF139@BY5PR10MB3857.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZRLpzRa+6ZgMakwqu/RD8KmTJliBp0eEpRN6FrhLdoEDudrNIl9YHpgkqnD6k7ODTVYV5btm7CuftSSf+PtAWFJZpOR4J/rJCa6PSUE7/9aE1oR8aGoQr2cVkYz9hU+pxd0C5alX+yvoclIn9tQFaQAGb0diFxWghisSBZgs4pRTFxTObTshLrsAFr/J3zDBlfOIAvR6+SteZ8oKV1+BSPMEF8Ce1Rmg5w6MSXewyaSZlOzdPnPMXgNp8WO/h1H2mazkNb9Vq05lwILx6Gdhhm4B7LyZPFmH6p37/aN2YoCOf+dwlJsUdQcgR7UXPdOZYEfviUZfYCZCk6IPaTjdHScx25bqHtKcyQxZjyM1IX36jUiTztxzzRYTAbTpgPs5Qb+Fg5xdN4yfoghQ/2a2IRC/nUh3ngETDQrzSxta7VoXXjR+0BbYImAvgXLOw5qwIlSL/8QkjjadCXXjHbrMeExuMjb015YXNHVFwv+J9pIC909mLPfXZagaHI0abeHkkB9CDNVeoAUQtO5mZHaNU1inBSmXDcSv0aYlWr6f5krM+CDleorpz8phsvZ0IuEPCanuD6irDa42ERT47dQZxhPB6n2XzwPX1TZTFk6mueLmxmYWkjUZhZplhsfznBb7JduajJPB3YZQRf+w9lPFgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(346002)(39860400002)(366004)(2906002)(478600001)(36756003)(4326008)(38100700002)(1076003)(2616005)(5660300002)(8936002)(52116002)(7696005)(107886003)(8676002)(86362001)(4744005)(6666004)(186003)(83380400001)(66556008)(66946007)(66476007)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O3e/7MPhKAXWYT4Dk0qhe0yizdtHTC4x1ThxU/7a9H85lEeRy3EORggCo/ps?=
 =?us-ascii?Q?vzBgKfY/rgJ8S6/H05/yrPPGl2iD9xHv961Gav54SWm7KXfFNi6HpkZbxhAv?=
 =?us-ascii?Q?Wf6Ev1Yi3LYAmsp46sQHWvzh7JFk/IpFoaB6whvjIYTix4nMU7OUY2CgO5Lj?=
 =?us-ascii?Q?dRiPGhnFErNeyb44hWzPF9iQnoiY+K1yy6QKYrpFU1MzwgduB+forSKbGvLg?=
 =?us-ascii?Q?3Uneqk235mMonROZccyMKHiNkBMHIa1Zn5YTU6t6upbnJ75k8yieuWSEvNo+?=
 =?us-ascii?Q?DHgkCWzRL7bBYXkt17H4WgLz/LnlvkcTpeNwQFse+FzBTXnqMcXXJ5JhkSMO?=
 =?us-ascii?Q?M+0FtnLhdzr7ccdoB6kjoGScdOqOMk4tjB/r9KxqS+pE1SC3+wO6wb2LaQs8?=
 =?us-ascii?Q?z9j6mUErWeu2rjOyMKCWXWt/hvqoB/1Zz4h9mXDPo/1g/n4i/k3TNAeX9wBm?=
 =?us-ascii?Q?eFYZoyBqiB2TXEwqnjmiiNGqFGpN08gEtwTYLXi9Lc+gB+M/LxLNFQKtWmHU?=
 =?us-ascii?Q?1uo77ocz66d9O5oioPl5u7794uyrBgcs10Miui+yOF/VDX7a/vIy+JusWl9t?=
 =?us-ascii?Q?a02rCVOWCje3VF9BthQq5D038iPQlK3nbmJJUW5zY476BhjkHDHZt4MB9i1F?=
 =?us-ascii?Q?/KJHx3UdQD2z1pD5eAw5TdmMQfxm5/g8jd5KL/F6lB7b05ygY/E4ot5CErCX?=
 =?us-ascii?Q?jWoIe8h5AcZCQNxIfDkwlrBn8f4znLz0zCKoNJID5w4qhOG9rPam0MGKIubi?=
 =?us-ascii?Q?7unoV/HzXxFF2U07cwxuWd1gOcLqWvZuAz5cw37EqC9ugCWxcLxY8RQZTu4u?=
 =?us-ascii?Q?T9oD8Uv+zCcpLOG53bvzD6H+uhdIJkAfaHaa3hey6VVpSXw8qUc3FfsfxVVj?=
 =?us-ascii?Q?dhXlto/pPFa2eOtmgzxbOlrNA+dI1bn9wnGF5rgGkRieNcUf3ME/OHxPq4FB?=
 =?us-ascii?Q?PT3CmDg8uEO/LKcWk/7Xt5n6VPooFrpTDDYFzRBWZUsxKNjOzqFA2oUb/2+L?=
 =?us-ascii?Q?5GKseQu4+3BgOg1FAoaqkTc0qlYApuWtky5UddUUih6H6xIU4LKYDSH6HIdY?=
 =?us-ascii?Q?bkHDSaOIj7BApJzBMrED0BF9M8p4AArMZh83kfeFllofZzrD8HmzQURfnqEM?=
 =?us-ascii?Q?3Bc4YWhQ6XGTXokVobR1gj2/Tu8K5qBFziHGtOIcuCjxsFtCFme6ul2y3W34?=
 =?us-ascii?Q?8zbZRPxiHmjBAw5RDkm3Uq9i8Cj7aMUe8Tgu3seN7EAqmSSrpMFtF1yJ8DPI?=
 =?us-ascii?Q?n0D1obetO/VWaXQrAcipP6kErP6nlZQvPxiQeVteAxZAcx2f4UaOQEHXG2I1?=
 =?us-ascii?Q?UWbb9BHftYBuS7n7+4IMkD8BRJrN0D3KuzsvwzWTHk8E5SBhscJctxvp1nZt?=
 =?us-ascii?Q?GAwEz/I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ec0aac-0d1a-4b68-9dbb-08d946a2533f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 08:35:24.7031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s29S4reaF3AtQZGng5g1+9hboWIMuE+uyGrnxTaDRqkSSr0tqyWX/y50a54iuWGLBGqx3XX/5snYy/KtdILoKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3857
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10044 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=878 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107140055
X-Proofpoint-GUID: 19DK1JoG_TF8o8_oGKD6Cn6madRPbAvs
X-Proofpoint-ORIG-GUID: 19DK1JoG_TF8o8_oGKD6Cn6madRPbAvs
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Resubmitting my previous patch after kernel robot found
that RXE_MAX_PKEYS is a u16 value and the value assigned would
over flow and result in a zero value. I have reversed RXE_MAX_PKEYS
to it original value.

Rao Shoaib (1):
  RDMA/rxe: Bump up default maximum values used via uverbs

 drivers/infiniband/sw/rxe/rxe_param.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

-- 
2.27.0

