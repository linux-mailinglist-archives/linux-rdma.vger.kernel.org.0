Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758723CCB7B
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jul 2021 00:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbhGRXCR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Jul 2021 19:02:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:17590 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231846AbhGRXCQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Jul 2021 19:02:16 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16IMuGtx007442;
        Sun, 18 Jul 2021 22:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=SwcoBK+1b1b4qK2BRyCD0gYTTQ3AhiuGQecWfXytqQ0=;
 b=nszP05EChBll27ODEjGgD7tWJdTgqVJ/GiVXEFs9LMKXgIAL+xs4Jd0e1vVa3lVPn1x8
 CCpGrpwkvmOp1DZYlTyCCtly7PhBp/Zm86DLraReuNtyGKVyibvtoKqg3jv1/ZpiLyTZ
 1YGqJBybre4mnVfTeYW2umJrAPJGIBlcTGIyy8Qtje6HyQDMs3HBVrwbl9Znj2FJiiEX
 CWlgolQ97u73NQjQcxPemF1qrCOl9HQU2b/r/nL3u7a20225Ee6fxu7lb+ZFRB1N3bOd
 lHJWMLF8/Uf6/bEHDo/Gp9LiWjs6ciKUKncZ0/M6pF6PZZX82QVD4otAJeOeRJtInD+D EQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=SwcoBK+1b1b4qK2BRyCD0gYTTQ3AhiuGQecWfXytqQ0=;
 b=b/f1LH52+dYIHKC/VrzPdlk770D8TA6bx2xvqQapWpghKBsXQAgOIqPQBz45s8+AdmD1
 6za/M/212qz/ovUUP7DUatWtqsbwV3dIGN8tdRmhUqRvjYR3Gx3Gg9lJgv7NCIWKU63g
 l0jR8pScUUiaaDbQdf5ztEV/6ZscYcPWQD+KAOIg/TKmZk7w5sLickYperqt/8HgOW5i
 yCqQmO7DDeD4SCG737dZzg759s96TiLMTMgu50bbU7HvWjCOyqfMzem8p4Op6Kb7yOle
 qJzI6lwEEoZ/oTVV5VX2GZCzFzQehxPN1oZLw9wmz1JJyhaYe7KZwIwmoycxQ6U1F1y+ UQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39vqm9868v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Jul 2021 22:59:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16IMt0e7175410;
        Sun, 18 Jul 2021 22:59:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3020.oracle.com with ESMTP id 39uq13msey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Jul 2021 22:59:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJ2EsKVz0edU31Y2luQ2meYgWXpvOESjdlo6d1oUZl6YqTN08a/DUdTDL2UjRaCyjLBMOM1LPvpXXzN3n7sgghqAE00563QXydsY8LY6HJEA8cTwZXOBQF41AYSxwVoUsRiIVXYvJZCNPN4grNdkzon4zdHJCaAqcAtxjyl+1OclM6WbzYEmfinJp8MSQoFynIzQ6f50QIJ47CfA0eAnwaVQEQmf+1+7iieVtPtfXMXuOcV40Rrg7NladAcJZWocT9FYqlFVv0k4ftee0m8F+e73iGFSy+AqnMSyGf0bkOU9w4s/MXAMdPnopWBECb9ErK5R/JpkqE/vOMLMImdw6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwcoBK+1b1b4qK2BRyCD0gYTTQ3AhiuGQecWfXytqQ0=;
 b=lvsgTgTe3ATgHDjbcKitsoh3X4yAvASvoQMQCs4SyvxP8N3Ne7cAzwxiJnqd+mhvD3Rknfyejly19gsK/mDMIsy8atuPy9RQG8Jl6Ptx48OTWTDURDMqBGzHSzPgQY/uXGjMUUk8vkEk60wMjzl/M/XkAGSpr2P4MiAtJsf2kId/RuiNP89xN8xRKkLz4qL2P6cFLalu0vu8iCqWeKbaDmE7WGYfhpKlI25j3MW7NPTo899nUG73kohu0I+RKN351WgGnw+abJzZNE7d6LoBZcvRrLUSRm22ZseUZ85hG5QiXia4QqPFVknazwcfHmnfjyFKL5gJsnRosbStttgZ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwcoBK+1b1b4qK2BRyCD0gYTTQ3AhiuGQecWfXytqQ0=;
 b=Np0/tTfnspIoJcE/3l4V1D8QasAeyYob5xZn/ebxJcdhaE3tJOWUXXuU20xN7oIkah+be6e2bsMBdWCfhbQGGxNv93IC8Wi8AboGYBpXLYRDEs/Lz7o6VpITxtoHSRqp0y4pCw6Rv6E3PnPmnkd7q5gnGvMxSWdUBSgAZ2NfVzc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BYAPR10MB2968.namprd10.prod.outlook.com (2603:10b6:a03:85::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Sun, 18 Jul
 2021 22:59:12 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21%6]) with mapi id 15.20.4331.026; Sun, 18 Jul 2021
 22:59:12 +0000
From:   Rao Shoaib <Rao.Shoaib@oracle.com>
To:     linux-rdma@vger.kernel.org, jgg@ziepe.ca
Cc:     rao.shoaib@oracle.com
Subject: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via uverbs
Date:   Sun, 18 Jul 2021 15:59:04 -0700
Message-Id: <20210718225905.58728-1-Rao.Shoaib@oracle.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::13) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shoaib-laptop.us.oracle.com (2606:b400:8301:1010::16aa) by SJ0PR03CA0248.namprd03.prod.outlook.com (2603:10b6:a03:3a0::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Sun, 18 Jul 2021 22:59:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7059942-d9d6-429e-a92e-08d94a3fa863
X-MS-TrafficTypeDiagnostic: BYAPR10MB2968:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2968DF4A906E98879856F4EBEFE09@BYAPR10MB2968.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GVaquiGFLBFWTmf1cnMJrjmqzM9UtvlnwSftz/g5F2pelduEd8+IQv8BcaWnffX3YCXWGVJymew+EdACc0uOR4K+QFHbzlgK3n6VKY9d5XiChHTZsN0fLyoIX74umVTftGkRSifedHbFYGWniytUxX9jfFytjuXCmzD1DjJOORGPSAxHKcXf7bwlOY+5fuzT1YlcgPzTGSM2OQw++y2MPtQcrFB5qGKWa/o7cGXPGOvNrpER7JuYlZNEdixJPIEoFa69Konyd6boVcgi8wSkjgTnv1DnH2bSp5X+pwnIfRnELBRD7GD8Zodc4T6N4FNGba7N32XCvPbS5m9aUOiaqQPhQ3Bx2rZFx/x0VUBCIwJNPGjV2ITRHw8/jfNERcxW5y+uFa/U++reNsvkcyvcsmGE+vBT/MuKgFkPhKKyBageQa7tgtyp0DA8Sl+p+J70OE3woHf0s2etBVj4ZXIZuk+huAWhP1ZMI7pYVI+/S6FtPIHkep2wa5xaKIlm7vada9YgaTmKiC1jhThgP4Ks7CC4W4xZ4F4YRjUQPlwDYlRHagCL8dmTvL2U/Of6gsn9PE+8jJ4RxuTKCpRxBEwJHJ2gM4NGCnFZDEPX320JednpCNrPor8EJn7Pf/ZUnUNIhg8J8vdSlxuumByLo0aaxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(366004)(39860400002)(376002)(186003)(107886003)(478600001)(36756003)(1076003)(66556008)(66476007)(66946007)(38100700002)(6666004)(8936002)(8676002)(2616005)(86362001)(4326008)(52116002)(7696005)(4744005)(5660300002)(316002)(6486002)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wMD0lxBijpv8pBawr/A1eLpPo4OetxOnheF20nv9FzaynCTI5Q3fBuqfOoAi?=
 =?us-ascii?Q?YFoUInpZHlLepDET3lHffMXu0nOGQb2USAIPjFUnIcfJNVYBwwtvMmy8/isc?=
 =?us-ascii?Q?jSjrkB5CtvAVpC1nppXFcE1jrmWkbQnix6nhtEY+6+Lf+mng0BJWubBnIl4p?=
 =?us-ascii?Q?FIqQ6dCeSfxav86RbUpbHwSjjCSaLIpyLViVOu5kv98015p0DGNGPVbkW4V8?=
 =?us-ascii?Q?XfqXieKPVNA/Zo6AJuw/6uMh/L0hk7wVgRTD2QR2mOUdKj07WFPJ/yle6f4z?=
 =?us-ascii?Q?a5TyO4+m5TIBCAYAAJTI+NITDDQaj8QDEM21R2qRBgCf21ITxHMHXuxh+lJ5?=
 =?us-ascii?Q?73h0Exu97JV3JXzzdzfEzuuixSFF8LU8teoc9y8rUaCNnzBL5v+n1tkGxecl?=
 =?us-ascii?Q?OXZN7f2getWP8lHbtrsKTIF+1yKZE7wwa3i5m6z4w49yER0avlRNCf1bcct/?=
 =?us-ascii?Q?kzRH6vMIeaFz8vzuWbbjQSX21x59F5fBnvYmulhvJG1Dra4iPcuzyVfZyeya?=
 =?us-ascii?Q?ALAYNb/zqlM5MVkkLpTp9J+BLKSk63YF2x0iVTU+DL85CGmTIbZFBv8rycVb?=
 =?us-ascii?Q?B0mE0b1GDglL6mKSJSG0cfaB4FtEeB85RX7fnmRW2b1xfQmdWyPLrhaTVq6Y?=
 =?us-ascii?Q?H40LQkEP74Wmu7bnsmZk0tlkpSg0j7LFkBoGhs4f6cXC6mrof7urxa6O4FPC?=
 =?us-ascii?Q?Iigo10x95ZJdNUk8kybSNovfKlPUuMb0hOCu8wdA7V8jrDSWY8i+osMshPFZ?=
 =?us-ascii?Q?WekdHQitW1JJTYKvQY8iLCoGayeTidX8rYlgiajd+7cS7E+opowZLQs+3Mh8?=
 =?us-ascii?Q?9ShZiIz6I3bzOzjqkDrJflv4Kyfmt9zDSg8E9bFihMoqXwWgZGmy8IlQymqj?=
 =?us-ascii?Q?6gkZj1m4KHumzrSYiDzVE1+JyQErAFtjwXqhBe3bTDnEm+rgPtMHDeXWEOPx?=
 =?us-ascii?Q?lhwh/74IcEaGTyoFaXHNYEuIRXyVwL5Kq1C+CsdSWwY8B74PR9m0zfhnrxQ/?=
 =?us-ascii?Q?zPnrgqejOlfA++mT9NPgDppqrCLNiB4v66YnjMYovzZF4fWryxFipDaY7z6D?=
 =?us-ascii?Q?FTyv3IvYV/A0yCajhlb9eWABYR8LFYdySKnxFpefSNGkJrc65i2gZpzlyqU4?=
 =?us-ascii?Q?rCMEPlvhE9aNhyTQF5BuTIM9O7LFx1SSNEXvHZTI7GmHEvrbYO5i6tozB7tM?=
 =?us-ascii?Q?xgUYc5Xr88BUXPY+ryJ/n+QoNpkzCDzUCxhArAYMZs+UkJlJU/92Vo7sLuc7?=
 =?us-ascii?Q?VRSX1S/P9sOSdAYXza50z1AUu7kXOR7D38PXzFcsj4qEw2xuxLTzeqliAL9X?=
 =?us-ascii?Q?XOTBAQtKuXlx5f3VfGJ9tawLGQ6tawasYPBlz5aRbFOXVPYaDL5zI7ouHszc?=
 =?us-ascii?Q?SEkiZB4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7059942-d9d6-429e-a92e-08d94a3fa863
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2021 22:59:11.9329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EB9Be1w8LfuwNxyFsI2pCvIlWWCpCebBbXWeIgJoZCCrRG0jKPty9pbDFxe18DMTc025pm7esaze2Rruxj86fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2968
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10049 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107180156
X-Proofpoint-GUID: JMc9RpESgm5rUsJ1qQukyWkkKUovKDAi
X-Proofpoint-ORIG-GUID: JMc9RpESgm5rUsJ1qQukyWkkKUovKDAi
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Changes since 1st rev:
	Fixed an issue reported by kernel robot build
	Fixed index not being calculated properly by zyjzyj2000@gmail.com

Rao Shoaib (1):
  RDMA/rxe: Bump up default maximum values used via uverbs

 drivers/infiniband/sw/rxe/rxe_param.h | 30 ++++++++++++++-------------
 1 file changed, 16 insertions(+), 14 deletions(-)

-- 
2.27.0

