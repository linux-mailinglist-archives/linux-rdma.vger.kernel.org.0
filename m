Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2951D5234D2
	for <lists+linux-rdma@lfdr.de>; Wed, 11 May 2022 15:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242276AbiEKN5o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 May 2022 09:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244354AbiEKN5n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 May 2022 09:57:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94E8517FF
        for <linux-rdma@vger.kernel.org>; Wed, 11 May 2022 06:57:40 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BDMtOP024435;
        Wed, 11 May 2022 13:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=4QQEdEkjdxlFVowADiHPi1kZ4KAvh3xItggEGa992cU=;
 b=GGindbCzwa9eeNVBDN1+dgrjhzVVc24w3gRZPQzqKoeSsAewDcVqJN26+mdrpgpvAjym
 x0jQEJAxzH7EJu7qR29ewm06amvVO20PXhj1EYwaZ9DIua8cHt5D9WvrCuJdkezJAizI
 vWXSSbYnLvCh1c8jVDSXxd3K44nETS0voxhMCeRlLl4vRcrUouKVrg1pQQpBlIsXP8xC
 2VmtrCCnzf1r9ziKOeyEhGN7mAiRM9slgHjuE3ynk9JFubl5w9dwTC1jKFjWwt6eAnwg
 aApJ/JTsq74zjmAhb3UoroF4EVIvBYNk7tExY+lAIJr/vp2Cyk66YR4NclopUKSU/HIm yQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgcssxve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 13:57:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BDtSdI034730;
        Wed, 11 May 2022 13:57:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf73njuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 13:57:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOSmAaLcGoDZcSWM+vzvPI66foObC85S2DLmFSFB4cKopDNBhlQoWt65vzjFAtxCpqp3g0xO7D/ugpUzRRrjL27qfz/DqZnyM2mchbtS7nkliZLvUWg36TaFLnY/LIzG2Iq+CeEfIWMdgGc9FBxjYQPg/8pML2jmkq+ZmMtvVCPR1af6fHIJawLVT9L8269pdLSdLaJDK8bEAOlaGVVjq7m2TKlERBx9/Bu+Kvg4tPCP4bAnIr2gsFyTHnO6xfIr3BEMrhE1BYP3GE+/+IxPFCtO19/07I8VzDVzD6PEFfHBKbbuvPrfU0zvS5Y9r6xaNQwkjeaHNT2TGq8Tqq8GAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QQEdEkjdxlFVowADiHPi1kZ4KAvh3xItggEGa992cU=;
 b=iOb9fF0mxMtjRMA965M/3WxB5f8+YIkG499WDlvMvv/c+Qi54mqveq9np4CAMOmdqBGp8ja2W1F7f02aeODbj2Kxh8PTyAOVCi4ULKBZgQvAzi7WQ4DXMQV0UnYrXiKNWoPPZ20DVd4c2H7VC96UQLZ47YPqUM+2DxEqPLxehLL9z5oFc2lzlKlndZ08LziPfVukVPy4sJQJshEtw2dk7sS8XFMVYYBEgTypuypXyfPPuQyn/B1T9GLtKddvXYVZw/iZNUANLtyIzPFdL5YJ4eMfrYdQlHYdsP8qLx6FLkTmglbEe6xANQO7MwlNSQF4OKZtUCDmX4BfqQxxFbMDMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QQEdEkjdxlFVowADiHPi1kZ4KAvh3xItggEGa992cU=;
 b=s5bpBhOlusl2KduU8nuGwUalwhUR4XIOuBOs24m8C40bFT0yPT8tAtc1kyDiIhvhe6xskjhlhEkC989/1Jq83pRiggFOp+25RbpcKyesdonGY5xCFsDa77WSEhEn4q0KoQCtHDuZFRp+uMYfrTKeLczGQ4uhwgw2uRwakpBgjP4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3158.namprd10.prod.outlook.com
 (2603:10b6:a03:15d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 13:57:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 13:57:34 +0000
Date:   Wed, 11 May 2022 16:57:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     maorg@mellanox.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5: Add direct rule fs_cmd implementation
Message-ID: <YnvAxF0JO7E0fZvO@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0007.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 100028cb-8cf1-4c75-347c-08da33563305
X-MS-TrafficTypeDiagnostic: BYAPR10MB3158:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3158AF224506AD5FA7373EDB8EC89@BYAPR10MB3158.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +/5GUXVo01g9b2Jz/LWun+2LIR3ptasprFHP/w+1B6lpTDSjIus8n7g5akmFwXZNmZ6YOWZf0fLC5eHFdPG6q2oOqcMMwkSn0LGZU3Ro2ts1Us94xTPEuzUA3WONupNquC0nJD+CKiJ3UG/cOQaHwPjeHqn64JBgNQGLGpGaBD34SacmQa2HPehwW8nRgcVJSc1IWbRKL1tNiXuZhZ+rdzSvD5lRtyXezG7rKmmGoybY0xWEvhNnnX6Z0DkplABLMVwka02uUYbEgvMB6vXrPQfTGfjEYxEBgJQ0f7S9rTpdO3zjkYVi15JgszQcjmTLZ3WhM9+0dSOMZRl7fRTLPLd6J0fKNu462D8HdI5z1FbrnHC3NTthKup8pRj2u3MUDvUfqBZsOBEP1Cl88nh+wQznp58Po0812gxS94yYehE9TU0TCgHYXyeYU7vnNM92C57WBAqdlBDHXwFumzbJ/sBKJ13yFAgj6hpYVUsh4TIdvW1wEQpLFqp+mxHOjpFQ+JBVcmYI/G2Qwx791iG6PHCgIQT05Pj+sekhq1CDwpzDl63O5/eRLp03DzPqh17RtGMW2DwqMVeXfJ0rXEIRj/lFh9188TboD/IbqdrssBclu6Xg0L1RN46A2kBFcxcBQkgibbkfBL7TmK0mL9q/M+fy2mNkfbEjkJtCRAKCV4BT/+9EdBwLidPSF27LsxZ5mku/1ddTUPMYDIiEvKbi6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8936002)(2906002)(38100700002)(38350700002)(9686003)(26005)(6512007)(52116002)(6666004)(508600001)(86362001)(5660300002)(44832011)(6486002)(6506007)(6916009)(83380400001)(316002)(33716001)(66476007)(8676002)(4326008)(66556008)(66946007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MXjfRq77Og7C/0Vj1M+tzVnvnkDUTSmZb+hbRPpeFp7l44Fc4zauOZW6bza0?=
 =?us-ascii?Q?2povfDkTwjiaj4KOG31Cpv7ohP2tAOzSQgKpOR5i5YZJVylBFQB8YP8Tv8Yz?=
 =?us-ascii?Q?qC3HZ3Ngq7MEkHALcyRm1s0Gdlty5/re78XwJ8MI8V3j7npo185+US2UMtTb?=
 =?us-ascii?Q?pq8DnI5VxSRpncWBRKxsTS0TGNtFYpxEi5865qw3ArDd9b3T66WxNQs3GuO7?=
 =?us-ascii?Q?4vzIBzNiCF30mBk+pPhtE0aO9FA1qq/7GvgITx6cbhdbOdtsnep5KwGH53E9?=
 =?us-ascii?Q?9x9nmqnFFM6X5+YWjUYDfYmMsNhnQx7ZYjWu0iJ+gKUXuCCyCRYKfvOI96QF?=
 =?us-ascii?Q?gnkazLOUuRnxCvIr9HSmr9sQStbmrAPHvwS6AuBvv0DxuRkKGGZXw+ZNJV81?=
 =?us-ascii?Q?mwd+gPEvMJfNHxqhUElOLpfczNaext2ZL9l0Qe/dFJBTfeRHp20dGdyP/H/u?=
 =?us-ascii?Q?b8qJDvKvpgHsR57Ksioa9tyk/VbmBXy9N3YWiCAwbVjQghrTq9U+6X99VFgN?=
 =?us-ascii?Q?xGEYXdJi/MyqHzTJev68KNhHUZ09qEJ0ySxb0F1gmxq9KS5H9QbXTDQDLpfy?=
 =?us-ascii?Q?R0oi8pkMDcTVliTgt2U/j4HCBh/SOFq9JXTdRR5IoTCHaMqa26AD77YyzDLQ?=
 =?us-ascii?Q?MvfMDTTtElJqxaTCXJe/+9MRgepaP/cQ5vptSyU79heVJVAUlrDtKtLsAzuo?=
 =?us-ascii?Q?ts77iWqMZz9/didsY2ZZXS0o7vcmKyYTWg0EmjYZtjDuHcnVqb2kG04T3EB1?=
 =?us-ascii?Q?FrWsXB3HP4+/4TI+3c2soY7mud1F5s4Pl/zHUhs1xw4p6BNqkU+DWoeZ9rst?=
 =?us-ascii?Q?jxYgbprHCjfcyg3FO9+IkWQ3kR8I5vrxpcux4EZUkK/JODWwz+KJ5dWbMKTT?=
 =?us-ascii?Q?1nk/m53/whcXEvLFekpBZH7Ka7Vrgx7WNfB7zd9zouRGU4TRdBoXRzTaXlrY?=
 =?us-ascii?Q?Wrr81bTeJg2xsTBk6g98uEaAY6U4Q/JGR5HGAm39lYykOXw+M3NWVBamghva?=
 =?us-ascii?Q?OZeuf/ZbNXvGK4ABvADFTz1iaUlGmoPVJr79gRjTXHT5mlAOtXtLsC1rJL27?=
 =?us-ascii?Q?eE58eGUuJTGgkZF/SktnDn2xEOD61wOXHmTUNBPwQ5TiroPPy37AoiebjzID?=
 =?us-ascii?Q?PQuQPPLx53Gvm3DY84VMJVP8S2U+/UohCoVR244/sCIQQtinXrgPvrCaJNws?=
 =?us-ascii?Q?kSpdH/MA0ITP9H9KnP+mJYssTcjLr0gc04ktF5RuBYuArhPRNh+gb653D3IP?=
 =?us-ascii?Q?EUYG8ljS5501N+8H9maIyO6ylDaBflBU8MMm3P9ZYxqDp0PTc+ha/w/+1tRq?=
 =?us-ascii?Q?LcWez5BqhMOo8rBwU3IOEQjCgsWK6vt7BjmzXkNR2b2ah+8OyHKbPozrgCfH?=
 =?us-ascii?Q?3FKjNjX5dBza+bWrbHjmBtf5+7Uwm6tQ1F4OOYWDIRsx6lZv/Q1tPDKWJe31?=
 =?us-ascii?Q?RAiwxLVg+a8DXqVbdYYfXYlNPHymQ4KY3MAro+Po7RAPhjt7bFDqyQEpo3vB?=
 =?us-ascii?Q?nRILwgHoFOm1WZuUhJmdhia8g31dzTxxbGdgoB8JnUtaqkkuL2fwNGKr74sw?=
 =?us-ascii?Q?HYf95vBYqFgsj6/VX5+0t2CzSesJscwFQhS7f94EKN5UGkfJi1JsoimyAH5E?=
 =?us-ascii?Q?6M2IgMSIpNhTLmWz0FGaUWfCzV/mTyfdZ5x1lda+rKKQOaw451JSoDBhfRWl?=
 =?us-ascii?Q?UJbEbzEx3pQnIeCkmrtqnhhg5rcQiNUgVdSsmSLym6WomTNGbVv4/pArYflr?=
 =?us-ascii?Q?AoE5ZqIcUA0O+nrrsRLdXwjGFbCaMPM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100028cb-8cf1-4c75-347c-08da33563305
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 13:57:34.3935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzSZoq5hSsZL209kPP/0dvimRpkZT+epbjXYCDIwKljyzAAQTinH6vXuSgWWKioahk+nw/FiRZiuqnnuJdpLfcAy+U2oc5/1gagw0vXM1fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3158
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_05:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=894
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110066
X-Proofpoint-GUID: u_oahqGwqf1QnXKXpI6rwcXPnDFuXb4G
X-Proofpoint-ORIG-GUID: u_oahqGwqf1QnXKXpI6rwcXPnDFuXb4G
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[ I was reviewing old use after free warnings and stumbled across this
  one which still needs fixing - dan ]

Hello Maor Gottlieb,

The patch 6a48faeeca10: "net/mlx5: Add direct rule fs_cmd
implementation" from Aug 20, 2019, leads to the following Smatch
static checker warning:

	drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c:53 set_miss_action()
	warn: 'action' was already freed.

drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
    28 static int set_miss_action(struct mlx5_flow_root_namespace *ns,
    29                            struct mlx5_flow_table *ft,
    30                            struct mlx5_flow_table *next_ft)
    31 {
    32         struct mlx5dr_action *old_miss_action;
    33         struct mlx5dr_action *action = NULL;
    34         struct mlx5dr_table *next_tbl;
    35         int err;
    36 
    37         next_tbl = next_ft ? next_ft->fs_dr_table.dr_table : NULL;
    38         if (next_tbl) {
    39                 action = mlx5dr_action_create_dest_table(next_tbl);
    40                 if (!action)
    41                         return -EINVAL;
    42         }
    43         old_miss_action = ft->fs_dr_table.miss_action;
    44         err = mlx5dr_table_set_miss_action(ft->fs_dr_table.dr_table, action);
    45         if (err && action) {
    46                 err = mlx5dr_action_destroy(action);
    47                 if (err) {
    48                         action = NULL;
    49                         mlx5_core_err(ns->dev, "Failed to destroy action (%d)\n",
    50                                       err);
    51                 }

If "err" is zero then "action" is freed.

    52         }
--> 53         ft->fs_dr_table.miss_action = action;
                                             ^^^^^^
Use after free.

    54         if (old_miss_action) {
    55                 err = mlx5dr_action_destroy(old_miss_action);
    56                 if (err)
    57                         mlx5_core_err(ns->dev, "Failed to destroy action (%d)\n",
    58                                       err);
    59         }
    60 
    61         return err;
    62 }

regards,
dan carpenter
