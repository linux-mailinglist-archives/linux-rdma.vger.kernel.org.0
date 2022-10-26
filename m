Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C4F60DE54
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Oct 2022 11:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbiJZJjq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Oct 2022 05:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbiJZJj3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Oct 2022 05:39:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCD8305
        for <linux-rdma@vger.kernel.org>; Wed, 26 Oct 2022 02:39:24 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29Q7x1OS020722;
        Wed, 26 Oct 2022 09:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2022-7-12; bh=inqJtp8EQ2/F/2vclH+Eq4MDm2N/IeFh2OPhltKo8O8=;
 b=UEC8lw5WGo+0Gcsjo/1FKskf74/PWnKHsRal/nCQ8NFVPeQ6RsWRGP0OZX6H7jT+Mzwf
 Zks8mgOi7DZyNF/iRoIT+xYeaClnxaiLsOwrCsdCghyAVZmDQF1UUB4FnML6NWWqqfIE
 G09UmJKkCCDm3TUmgbuJf/5RvMPV7uBQ65M02IzschbbnMdiOmWGHawQhA3OUz1dUa/7
 4wX0S9lZxGlTNgcPjsSrvMk+8TiVQJZfdTwLamtEdEcSYvMcErZhxndHiQY2nTRmyy4F
 s7qdaXh9dZTZ5TckyQad5mMDlWWfizPmyhkrFZvkkv8omstI1xRL8e5ByBKWNlkzfbCF lA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc8dbntut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 09:38:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29Q7G6l3013432;
        Wed, 26 Oct 2022 09:38:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6ybcdb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 09:38:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5D5Jkml9HUZOHVQa6Gj8lp7SZ+68ksM6fOFopeV2dxee7TseX9JdVLpfvzu8ACHy16G3ojCe1X7+Gnh9NViaPNZhnk6yZ4lh7IMh5772wy69IMTu9t0duCbejp2mywURwqDDfTh2VRnQ0LheAML5YndCmmMAsDiyAJ+QIAtke4UbJyLEoVs5Iq0uW8AEvdEmGapqPJY2xKxW8OiIBJDQb1uQr4WXFnZuHxyvN6T1HS39iN4rIIc+U6Vo4oU3dXN/FD2SvVdfNoADshqK1WO4PBP1X1zyGqA+xVs2LSMq9F+eW5s+WWFQCFqi/iP3XMf6E53RHoBTohm+1+yYQnlCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inqJtp8EQ2/F/2vclH+Eq4MDm2N/IeFh2OPhltKo8O8=;
 b=XmZ8Zh6zdJ4wh3nE+RBXEesYyOee+1EAWgsjx3zjCH9BJsIh/xegfaR2Xxu9M5LHVKCR5Bu2C6CewgWQjsk6UmlWbgQ4IShSJuujKfLenvrARzcbr4IQ+LV2Pihbd/gRve8riJm/IiOJiNxQUCSeXWyi0HJDVWvLAquDBzcno6ddW8PJx66DAH/iemNT+AmaO3sWGszAGc9oMsm21GNhAC3rOyw58rdzICHQbqkh7YtXDFlphWcIJmE+n+57w84sT1Fl8DXuvHnqteN1415BJuUFPav3Q5qofKxzb8kYQPk1l85oQAEXxtX0+pEwAkdvkkrjW/CDsaNWSEoquqEmxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inqJtp8EQ2/F/2vclH+Eq4MDm2N/IeFh2OPhltKo8O8=;
 b=E/4PRfrCVNzwOZ6iBzykQp/ubFRuFaY/lHgzMaa/XxCySDd5tXrcsJQEKrAaRgK1Jzkl/vYzPwx9d6P0phqV7s8m4eepnoKDTobHx2Ek7n6iLxTCk9hRUGpCY31juSyQ2uT7e83z0/cLiIzunsc/4FYSk/w51hCFFxAbzDPyQNo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB4351.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 09:38:06 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Wed, 26 Oct 2022
 09:38:05 +0000
Date:   Wed, 26 Oct 2022 12:37:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Md Haris Iqbal <haris.phnx@gmail.com>,
        linux-rdma@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, leon@kernel.org,
        jgg@ziepe.ca, haris.iqbal@ionos.com,
        Md Haris Iqbal <haris.phnx@gmail.com>
Subject: [kbuild] Re: [PATCH for-next] RDMA/rxe: rxe_get_av always receives
 ahp hence no put is needed
Message-ID: <202210252353.AQBJz0Bv-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020151345.412731-1-haris.phnx@gmail.com>
X-ClientProxiedBy: JNXP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|MN2PR10MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: 0809a29f-4890-42a0-39b7-08dab735c8c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a7PnNfFFFSmLMvMGkbNd/bwTQOW6xb1L9cm+C1h0kg8VKF155MnxbbVHuDv3ZJXbBurVeJ2lUmcxvp78xbr0kjnn1LukK08n3xEQwe0LNwmZ/5XAqnPp5vLu4I+Ojj/fGhLIZgs8iSBYTn59zhtAW4AImoMPEQMyHYEDS1E3DmoeWemaTVkg7SFd5HmnHlmlfLZQzlIAOjWKW+UqW4BsauyBsYc6VfxpJKveIAL2BKx7o2EVPQsj1BYWj4cKigHf00/I+87F6E7iVNf/1xHHa5D9X4d/FyfiDHmi4G0QPoK46fVLfbx79k/n4WlBJrPX86bb2skJ1C1BIMXqanaaXKuYt6DVPBVOpj/JiKuRJwlNkR2IYPOfW6djPvXUXp1CTYykQvApvvEY/9AJuKNmTwWNRFeEol/I+rZstG4CF1fev4zqut0aaJ7GIA8Yc+AC+qhCjYh5HW/uThWGBh44zRFjxQ4udr+l/k4b4fJdmaV6ThjnnzBYPREY00cQjnJ3beFNNBtdksTDNOmM6bfG4owixtL0jRpAt7fS5ULp2xRkdoMTe97uLdwUvOqgx63A6rofjPsb+dmegOSueU5p5CGo56oTBIJjMkBLPaXQmj/dNqStmyrWq7OPRR6FX3pYw36NStfWZVFJh7+K2EGnn7mGPFFVSmWvVE/EDCeL6SIKpmvkes5RTVOqECaRFsppFlv7rrbyqO8OxDpmxBrJwt9a2T0fJSjGPvJRe61QxWhSE7q/BB0+lHS9/IA5JBfoJ3e5axELE2ViIwZQWGvg7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199015)(8936002)(5660300002)(44832011)(83380400001)(186003)(2906002)(86362001)(41300700001)(66556008)(38100700002)(66946007)(4326008)(36756003)(66476007)(1076003)(8676002)(316002)(6512007)(26005)(6506007)(9686003)(6486002)(966005)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GXt2sVAdYa+gkzQgW41VqCFb1V2QGG52XevqrLuKruycxkOQx9sOEYW744fj?=
 =?us-ascii?Q?XCycWdpvO5nkOLJhxfnNHIK4RNf8CDS6tDylPAlFNL635Vsbf97zzv0iWeWl?=
 =?us-ascii?Q?IOvTvIFYkJDnOK4bGqOX+S1au9eBVqGpOoKGaQegbhp0SOmeIpPN0XqKRjVF?=
 =?us-ascii?Q?zj9hcSA1/6nw1vxY+aGGGxQuEmdlXT89tpdUBrcSNi3urapBBF9xtfUMggVB?=
 =?us-ascii?Q?D4/RWyURHJ3UioQ7pUNDpe6nUrdg19dPrfn1uSieNfrJYpcF3Y82pGnHLpyT?=
 =?us-ascii?Q?N6WgSMBl5a7Hp/D65N4McXr9z2a5DIW4Lak9F0Vso6iDYvRckt3122j3p+g2?=
 =?us-ascii?Q?Uzz1i/mK1Q7J0rsks5aQxENcBshkHntWltuISooX/MGHPVJCkIH63EIjMrrH?=
 =?us-ascii?Q?8Cdqo4LluXw6r5F/SmYhs1SXfyGf2Tzf2qKX6NsdxU7dWtKP1BR1vCr8t8GN?=
 =?us-ascii?Q?Z8st6ntiNHIzQQnQVHLPkI6VKFLnJVESXCtshTgXH+ZBPoPolkKPPG8wPfem?=
 =?us-ascii?Q?JyvMwM0bm3VWy1DdVJtjNHfJqSZM9yx2YNUsW15dKVHQLfq977POX92K3WGC?=
 =?us-ascii?Q?rBAmzy/sd3V4iia5uU8SLqMk55aGfcj2T1ZQ/716vEJgZTBf92oj6SaPrDni?=
 =?us-ascii?Q?ipc8Dg8bmjL0NvDMovxJD6Z3301YdqKab/mKFEk6G+kqKCiMnoZtFvEYDMsR?=
 =?us-ascii?Q?0ThPkMctcNHK9i0GgBwQWx3biV6qM0lqG2yWu8jxWo/l9qD/jyCH0HSoGAcC?=
 =?us-ascii?Q?YJhbddbO7lE0/WNXmCzy5aI1S6qdZjAV1JGopeyrGqNQcDM0Y/I+byzI8djr?=
 =?us-ascii?Q?Ar6rX0ghTUkjrejnj0uO7Vor4GyiRvohYFsyGzto/Axzqh7+W8V/yKbhQCXm?=
 =?us-ascii?Q?f5v1HlMhiJC3ZoYLbRXy3hYanbdDxaaCkhXj9Bss0cWMqeyryLGv1dSdOJaj?=
 =?us-ascii?Q?4Y45tSPcaFyihKK9E3thT6MDieLHd8S+my6exL1h45snfBLWNlrhbq29/3Zn?=
 =?us-ascii?Q?bx7oXznQVGaYcQSv0FevDV4FjCWx4Gk1zYbFZoVdr7cv80Rum4Fr6Mxf9W4l?=
 =?us-ascii?Q?I7z4d9p/k5ICjqRV/Hnvwofva8/YbuWGwwX37eRyRSGDizh27i8VlsYSOynw?=
 =?us-ascii?Q?RNsgYIx/cLu739HngdE6YC2ZDwP/BnwIjSR1wSvAM917i9ZkCWZw6VWal6oK?=
 =?us-ascii?Q?blgZYvmgnauCq6vU/Toa2xJhN109v6X7gFgeN/8dX5acnyQVJDIujl/tBSG9?=
 =?us-ascii?Q?QL+PHQGLoiAFjdAL9TzqMx4pEt+Kmc5rAcTuZdci1W/X5vQo9II7/uSnWLtH?=
 =?us-ascii?Q?MUN2PDg+1V7EIrvHbW0QU3X2lHldnnq7Kj6pf2DffqoYWKQKdnALW1CpTB2K?=
 =?us-ascii?Q?1mOQJ+zod6+/6S3mvwnvt6qEwmNa85XImrUbNI3yvhHvZUx8FGibZV5WluRs?=
 =?us-ascii?Q?KTnQppuKGISrTc4DATAF7HbKGJXtTD+KPUcETvOqH/lQ+LfWRgW2bI1/khq0?=
 =?us-ascii?Q?yaCzM+V2RoYxr43VVl1tUosLz/B6qxDoIxF8YkeFPaFX1amKIRhO4hSV1ek/?=
 =?us-ascii?Q?IXesznlEEr6/KMgz9PXwdPOsFoNCTackwu9liqGOjE7fzaEmJD8lFSH9k7G+?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0809a29f-4890-42a0-39b7-08dab735c8c8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 09:38:05.8248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOAbgu9TApAnXzT9wXzr7QYg66AiUFOcVanP6aqFawvysOD6I0DvLAg4RYfm3GWZIKr0R4fQpg/OIOmehsxW7cCxeEvK9CO8J4LVQpLANH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4351
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_05,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260054
X-Proofpoint-ORIG-GUID: rF_FkmYxamMs40MxSEEV6swG2D3l6Oj9
X-Proofpoint-GUID: rF_FkmYxamMs40MxSEEV6swG2D3l6Oj9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Md,

https://git-scm.com/docs/git-format-patch#_base_tree_information  ]

url:    https://github.com/intel-lab-lkp/linux/commits/Md-Haris-Iqbal/RDMA-rxe-rxe_get_av-always-receives-ahp-hence-no-put-is-needed/20221020-231859  
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git   for-next
patch link:    https://lore.kernel.org/r/20221020151345.412731-1-haris.phnx%40gmail.com  
patch subject: [PATCH for-next] RDMA/rxe: rxe_get_av always receives ahp hence no put is needed
config: openrisc-randconfig-m041-20221024
compiler: or1k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/infiniband/sw/rxe/rxe_av.c:133 rxe_get_av() error: we previously assumed 'ahp' could be null (see line 107)

vim +/ahp +133 drivers/infiniband/sw/rxe/rxe_av.c

63221acb0c6314 Bob Pearson 2022-03-03  102  struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt, struct rxe_ah **ahp)
8700e3e7c4857d Moni Shoua  2016-06-16  103  {
e2fe06c9080694 Bob Pearson 2021-10-07  104  	struct rxe_ah *ah;
e2fe06c9080694 Bob Pearson 2021-10-07  105  	u32 ah_num;
e2fe06c9080694 Bob Pearson 2021-10-07  106  
63221acb0c6314 Bob Pearson 2022-03-03 @107  	if (ahp)
                                                    ^^^
Check for NULL.  Maybe this check can be deleted.  It's never NULL in
the current code.

63221acb0c6314 Bob Pearson 2022-03-03  108  		*ahp = NULL;
63221acb0c6314 Bob Pearson 2022-03-03  109  
8700e3e7c4857d Moni Shoua  2016-06-16  110  	if (!pkt || !pkt->qp)
8700e3e7c4857d Moni Shoua  2016-06-16  111  		return NULL;
8700e3e7c4857d Moni Shoua  2016-06-16  112  
8700e3e7c4857d Moni Shoua  2016-06-16  113  	if (qp_type(pkt->qp) == IB_QPT_RC || qp_type(pkt->qp) == IB_QPT_UC)
8700e3e7c4857d Moni Shoua  2016-06-16  114  		return &pkt->qp->pri_av;
8700e3e7c4857d Moni Shoua  2016-06-16  115  
e2fe06c9080694 Bob Pearson 2021-10-07  116  	if (!pkt->wqe)
e2fe06c9080694 Bob Pearson 2021-10-07  117  		return NULL;
e2fe06c9080694 Bob Pearson 2021-10-07  118  
e2fe06c9080694 Bob Pearson 2021-10-07  119  	ah_num = pkt->wqe->wr.wr.ud.ah_num;
e2fe06c9080694 Bob Pearson 2021-10-07  120  	if (ah_num) {
                                                    ^^^^^^
Perhaps it is a false positive if checking "ah_num" is intended to be
equivalent to checking "ahp"?

e2fe06c9080694 Bob Pearson 2021-10-07  121  		/* only new user provider or kernel client */
e2fe06c9080694 Bob Pearson 2021-10-07  122  		ah = rxe_pool_get_index(&pkt->rxe->ah_pool, ah_num);
63221acb0c6314 Bob Pearson 2022-03-03  123  		if (!ah) {
e2fe06c9080694 Bob Pearson 2021-10-07  124  			pr_warn("Unable to find AH matching ah_num\n");
e2fe06c9080694 Bob Pearson 2021-10-07  125  			return NULL;
e2fe06c9080694 Bob Pearson 2021-10-07  126  		}
63221acb0c6314 Bob Pearson 2022-03-03  127  
63221acb0c6314 Bob Pearson 2022-03-03  128  		if (rxe_ah_pd(ah) != pkt->qp->pd) {
63221acb0c6314 Bob Pearson 2022-03-03  129  			pr_warn("PDs don't match for AH and QP\n");
3197706abd0532 Bob Pearson 2022-03-03  130  			rxe_put(ah);
63221acb0c6314 Bob Pearson 2022-03-03  131  			return NULL;
63221acb0c6314 Bob Pearson 2022-03-03  132  		}
63221acb0c6314 Bob Pearson 2022-03-03 @133  		*ahp = ah;
                                                        ^^^^
Unchecked dereference.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp  

