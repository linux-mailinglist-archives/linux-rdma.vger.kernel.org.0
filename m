Return-Path: <linux-rdma+bounces-989-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 603E084EED9
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Feb 2024 03:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55DF1F24CD0
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Feb 2024 02:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7FD1366;
	Fri,  9 Feb 2024 02:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FpULPbxS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rh+kaJ0Z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F331849;
	Fri,  9 Feb 2024 02:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707445757; cv=fail; b=Y9C23nni1Vuwap8T7VusJgmty+xjKpyoyvCL/cOsnx9tcLnZW1/tw1ErLwbyyNiz9lc2L08Y4L7RBGWjmDp31xQWpxcMb88nT2I29uo5Dd2jrTVTObs8lDY6Vykx//cIsEsViq/EiFwFfzkUOSCq9aXHltLhIrLXjry+K80LcaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707445757; c=relaxed/simple;
	bh=Z7mBPCEBJu83vEnWaZfNhLjerotlRJGhwRWAUC0g3W8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=c1x6U+IQ9hsV6WmkAK2ix2v1YipbgxktOUE/2rcE2P1IzY8WALyiYBvFgjnOgnoyK0xshOvf2N/uHBDCnL85TbPEj4VO3bdWgLQrlrBHRxTSV74cWZSqS6PZqIL1fMHzLvnbsEAPMG/h98Fw269fCuXOBkXtZ4QcsieheIfvS6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FpULPbxS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rh+kaJ0Z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418LT9xQ024393;
	Fri, 9 Feb 2024 02:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=bnTyvJf4Vz7VAubGZrOWDmTsaVQ8MMxHNYMXxZNt7nE=;
 b=FpULPbxSoDoRldVi8AL3adnLbZIrS7p8SLZGDdSy27/zUftbTaKi0dNKKPZujmWv5xgN
 wSKwYFmeIGsGVETehlpbas/vbOl937m013hOLJyfv5xGhR//DR3JyoYJiDvRleUFYdge
 7uSscE6gkJrLMohVFSU4NtYLt5r2IYx4JYYhHaLfkzthKe2mw6mjF2m1D0K5ZXJzhEug
 d0RP7ZaWl6bu62/jVBOtag7ZuGOEdeI8mv3WKfhMkOhHfYiOpclZ+ytR2Q/WHqlEofS1
 o1Bv2lLFQUr9HkoYbXzo60lzjRfymaG+wSo2BhWgbQSSd2FgBqB7fZMky7ZHKN0RSiyx Bg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1e1ve9ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 02:29:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4190KtmS007428;
	Fri, 9 Feb 2024 02:29:01 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxby9dy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 02:29:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbVdZMSHC2igqGKzUs+nk9x7PYRolAxw610f4CkAy0qXBETw3dz70n0z8HIwzIFEDifaRg2QChuE6WrOIlVRTNpv9QzPn0CzDM8jD0oCjehyaRl/AuYwHEI9aSnKzeU+Y35i/9XbHvPSKyID78uHCtP8vSesyxtxvSBNsVWZlclg1TZzWnLnxjU6l8hznFBr/tY4l9Bxh2raJe0LknTo7EgLvOwj3yI3TivTY1QlYok1LIkV48e1Eqc9iPpJ5BC91H4kIPLaHnaQh3z1zWrxDbxwnl2Li/KI0njYER/QKKq4d4xFnVv4tTGecGl/t8P72BvWDTqf4E0L2BNOZjojmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnTyvJf4Vz7VAubGZrOWDmTsaVQ8MMxHNYMXxZNt7nE=;
 b=T4FHVVFkMeDEwCwukNPP2RJ814PmfTea9qoKNlYBNi/G//3in6kXfFfxN1MNN6L/53nXoaR+a5yWnfz6pDsfceXiCQkPIYpBjq4wcXpe0ib4jDYwMkFJ2PT79wbmqjvKP3tGeUNaRT745/NeQ0OXhOZvomjQNRn62c8inIaazNfAIpC0WM5dznswmyUEWAqyMoxXfLFu1g+sJ1mRX4XWkSdqU/a0P3z5+d+mxlbSyp4MtZBI/bc4fD5PyP6+gTi28rf2+tXpT3Utzjmt9YotrslJnGnLZcl44Jt9V+Gdaa9Bk36BbMPNYZRJUDKJ/JySc6axER4Y/xY5+E1FEqQUnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnTyvJf4Vz7VAubGZrOWDmTsaVQ8MMxHNYMXxZNt7nE=;
 b=Rh+kaJ0ZC1Z1F2EPlMV856jE8rE7SZ2VMS/3R4ftt0wpxH1DeHPPRw759jG4n9OWUqTm2gyqyGjkoDjbSMRa+mwD69YDdgF5YtAWXq1UYohoxttaPu/MjyXa4+1F3sR3u2lgo07Q0wAEWQ5ikiBvUpuZrNd4uYimgYtYaq3ysMU=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by MW4PR10MB6464.namprd10.prod.outlook.com (2603:10b6:303:222::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Fri, 9 Feb
 2024 02:28:58 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::68a8:709b:34ed:2aeb]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::68a8:709b:34ed:2aeb%6]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 02:28:58 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Cc: rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, pabeni@redhat.com,
        kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
        santosh.shilimkar@oracle.com
Subject: [PATCH v4 1/1] net:rds: Fix possible deadlock in rds_message_put
Date: Thu,  8 Feb 2024 19:28:54 -0700
Message-Id: <20240209022854.200292-1-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0081.namprd07.prod.outlook.com
 (2603:10b6:510:f::26) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|MW4PR10MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: 677e0a0f-38a5-47b7-c4f3-08dc2916ded9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7/v8NQdkRLnjcClLTVIjGhVBZeT5Fw8nI/Ul4aBC0Y9qoil7TYpMu1QUv5sFRdmTizWYN9XvY4Kr4atIwCAv8vmND9Mkm7WX3woQrDB/iB6hVksCTjF8MWQRfPnd3bZx/2pmjDGM4TC+fZToyLu5v7mBk2OWH5p3c70E/GtZWL1Rpek7ZtcuFqbuzwDxOfVaFC4T/cIpZSNVv1aSrNsx5KLJaFCE6+0/AETmRjqK9HN/tBU/frcXly10mUu3EGTjg+9XNZch0TLK9EHor3tDl0lLEyupimhkvwh30j0E7OVUyf41ynfOENe546qFGyEHfJ6laASHO80OiAsW+2HAQGSxdwPPTCgiqWfLdnYKz52+bNHJLvDxUIASMqxrgekOQYAnHVUzjmjZaqefc4JB1hrlUI6IhkV1E/G06aBU8FTfkjGFme6LstHgJ6Ni9sXcNDCQdYojwvz+ph47KvTLyA8iKgG6Cik35BxBBhCIaYbIVnh0Gwib9cqbDd0jkTMkYiazB+HgKGSLxcjIdw9E3OCwRXhStshf+P+8PQIaWYmSGkwRcBvaIpBWCpqDMHP/
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6506007)(66556008)(6666004)(66946007)(6486002)(478600001)(107886003)(66476007)(26005)(2616005)(1076003)(83380400001)(41300700001)(9686003)(316002)(8676002)(8936002)(4326008)(5660300002)(2906002)(6916009)(86362001)(36756003)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Z1UwoixThDdOKAcrT4Utw49Ip8V7v8Jnp2wBd40HGKi5dsmwRnnHbtt7j3kA?=
 =?us-ascii?Q?/ppugLZ58p3qagcxm1S7UEHpWGyk24+OV+TC7/VzQ7K3nfz7clxmSf0DTrkc?=
 =?us-ascii?Q?Evqn801BLGH4DhsEdjN7hscU0OHBkKk8LrpEm87+fi93Hsl6d1crryiYBO7P?=
 =?us-ascii?Q?6H6GUTAjPXCJ2qOmH29nRCWuc/nlHVhbzeMlE7J2TYX9F4t1Tc0CNysD+fqT?=
 =?us-ascii?Q?TeytJV/qCFtSRLX/klck8cecfNqadI0S8aGhHahokYPEsS0qbyQZP2pVj39H?=
 =?us-ascii?Q?BIcOqC/2YF+QdC7xpPNTu7hNB3mlpRY3UAWSC2Am7KrPkHHOqQ20ZD9tIU0D?=
 =?us-ascii?Q?DLlofkVBK73InBdDfstch6W1M0FGklESZRMsdtJyvWRgh6rTRDGFlqyTpSLu?=
 =?us-ascii?Q?yA9XZTmXX47lKMh2i6/HV5T4HK5o54JRHYVwEEWkzyb+gjJaCfIfPgOaF4nF?=
 =?us-ascii?Q?qyNk06vGweCAKj5KJMxTRzkgFMUpggB97bZgfwl4RB4rv3T0spYRVWZkzipL?=
 =?us-ascii?Q?yKR8O+VmbfmQgQJ1WWqlSWooQRa4vMm4ln7g0NNLZh96QGURI6hECTPSmYn5?=
 =?us-ascii?Q?9xIIgenIyl/IeJv3ObNmEujX4hBCNbfNk3gaWlX8GYAqWBYlbqc4lB2VF3mr?=
 =?us-ascii?Q?l9UOkL90d3aF1h24U59sr8SJuPpJDBayIwIozBhT0mIx5FYx9qPlKChClkjg?=
 =?us-ascii?Q?u892BYRlwo8lkIPo8iGI2jMfkE5IHBcO40j0DHK9/ye8rzvM0JoEBe5j31rS?=
 =?us-ascii?Q?Sj4vtLFtn+x4fLjOAzJ9MkaRIal6vElVPC0m6EBeDIm8EGeW6YiKKXMbmrIm?=
 =?us-ascii?Q?jmJTAfe93KJRMvC8MNalevK5ZPOgrLfDSDu0DVX8Zx7uwtZGF7B+TNglLg7+?=
 =?us-ascii?Q?kseFcF976nVM1hPPhJ6xR2Vnulyk83XOYMR2xzA0oQuliw6mjuDekAt8hHXa?=
 =?us-ascii?Q?EP9gVdIEsSvhevjvxLPjyMEABuf4N1R/PeADwJR+Kw7leWsy61lFX4v6jo6Y?=
 =?us-ascii?Q?/UkuDrHwallmhQrwiUoJNQwTf9ZY4gICVu3GcK7XSwHSEAEp8HVgRQqfk8mg?=
 =?us-ascii?Q?A1o6oWwjlPASAoftUWr8c/yDTseLoIyraMp/s7ClgcLb2o9ONCVhh6S2r2Bv?=
 =?us-ascii?Q?q4Qo6VgelSzZzChbFWOnj/Q6FAL9Wf/DXrm0MiC0/w+d8yb3jDmUCs5mZjtW?=
 =?us-ascii?Q?1L3mYS65fYKe12E4Ydv7QTe7LRRe8INo4xQYddztBxaI0Q3ettbrPGWcFSmS?=
 =?us-ascii?Q?ljmGMkfvhFRjQDxXnUE4/3SA466bHSoeyo99LFXNl0Oi53oMaSV+/lBAKVlG?=
 =?us-ascii?Q?GZikfJcMbCZ5y+j1IG5PkMROsg8gZB6zI45evfGWXKEA+VIpEuyB/nOjJhmU?=
 =?us-ascii?Q?NqRKbSr8fDOmNj5OZd9h8qTsuqeXN57xKhS8VNAcFEkqneeuuJ0KRQmqx4e1?=
 =?us-ascii?Q?QnxDEyNeG+8JeTz+hSqieF3YKVCHqQ1RmSbWCBexBrJd2WRCeyhuNV40wrdz?=
 =?us-ascii?Q?hg8Kpb06045Gwal6BVZHeuZS+qx3m8ckyZe0LewHW9nU49dexnOh0/iHuCUq?=
 =?us-ascii?Q?JBU4FbA5kcWNf7m7pid6DjcPj32iDaHXNnRnpqepNy9YKFhjFvrTe8/c5k4S?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tdLeGPcliIPBm6ZdNCNUZL5uW/hLOSIf2BoXx3ZEONTLX3mcHLODhR99VhTLtzr9qzEWwapVJzz6ZkIQh98CvvG8ZC/pze3qA2aExZ5mJyd7KqZkloW0r6STJc3FvvDlk8Ioy1QGGh3Jar8fzHk4CN2s34PN87km6qgKz18vCYG9p3eI09SKOAfpi2m/pRD/ndyJKs1vFJD/G6uWbjscuj+4GU5tXrRfIcc6Zq0x94hD2JyzmC2j+gHfRnIBebEdiZA7riHr7qk62Wwd9CjK4ifk+2DhHDAZGOExA6hdccUXoPR2qB2sNGz4DTlhCQn0Vo76DVw/XrxalVJViu/wBAp9y+aPoMdkNAA/BqPZyoltPqNvg2LfDoy3JwbrRE5veCdtkO6+dM4QYvFUCHtGf8Wi2/2Oc3MOtILs7IxwMIQhJz0OCtwLkASmTha29bAkPYIveSzhiI8ojNg2kWXhypF+lfkxkOjCzUC1jXySBVIby4jQTePzFYS7hD9tHXJTrz15mD7RvbSqWloyVt4zGT47F2d3NxevYv/yZ6dAQypBerRHCfvYufLyCVtNVcl88hBeYy6Sjm3+4EqHOPooqvbc0C/J6x4EhOZ+9HxlIMo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677e0a0f-38a5-47b7-c4f3-08dc2916ded9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 02:28:58.5903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rzvERhdSWyS+H3UtaXACVLMidXv/D/HIFKUXaWxaOEdYfb81LTQnq4gcPKclWoLK4Q0fKB51pW51RpOKdFh8MpXwGpFJKgQ3O/WeTyouuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6464
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_13,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402090016
X-Proofpoint-GUID: DOeveeWXzXQwF-oLynQHc70V9znqYx3C
X-Proofpoint-ORIG-GUID: DOeveeWXzXQwF-oLynQHc70V9znqYx3C

From: Allison Henderson <allison.henderson@oracle.com>

Functions rds_still_queued and rds_clear_recv_queue lock a given socket
in order to safely iterate over the incoming rds messages. However
calling rds_inc_put while under this lock creates a potential deadlock.
rds_inc_put may eventually call rds_message_purge, which will lock
m_rs_lock. This is the incorrect locking order since m_rs_lock is
meant to be locked before the socket. To fix this, we move the message
item to a local list or variable that wont need rs_recv_lock protection.
Then we can safely call rds_inc_put on any item stored locally after
rs_recv_lock is released.

Fixes: bdbe6fbc6a2f ("RDS: recv.c")
Reported-by: syzbot+f9db6ff27b9bfdcfeca0@syzkaller.appspotmail.com
Reported-by: syzbot+dcd73ff9291e6d34b3ab@syzkaller.appspotmail.com

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/recv.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/rds/recv.c b/net/rds/recv.c
index c71b923764fd..5627f80013f8 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -425,6 +425,7 @@ static int rds_still_queued(struct rds_sock *rs, struct rds_incoming *inc,
 	struct sock *sk = rds_rs_to_sk(rs);
 	int ret = 0;
 	unsigned long flags;
+	struct rds_incoming *to_drop = NULL;
 
 	write_lock_irqsave(&rs->rs_recv_lock, flags);
 	if (!list_empty(&inc->i_item)) {
@@ -435,11 +436,14 @@ static int rds_still_queued(struct rds_sock *rs, struct rds_incoming *inc,
 					      -be32_to_cpu(inc->i_hdr.h_len),
 					      inc->i_hdr.h_dport);
 			list_del_init(&inc->i_item);
-			rds_inc_put(inc);
+			to_drop = inc;
 		}
 	}
 	write_unlock_irqrestore(&rs->rs_recv_lock, flags);
 
+	if (to_drop)
+		rds_inc_put(to_drop);
+
 	rdsdebug("inc %p rs %p still %d dropped %d\n", inc, rs, ret, drop);
 	return ret;
 }
@@ -758,16 +762,21 @@ void rds_clear_recv_queue(struct rds_sock *rs)
 	struct sock *sk = rds_rs_to_sk(rs);
 	struct rds_incoming *inc, *tmp;
 	unsigned long flags;
+	LIST_HEAD(to_drop);
 
 	write_lock_irqsave(&rs->rs_recv_lock, flags);
 	list_for_each_entry_safe(inc, tmp, &rs->rs_recv_queue, i_item) {
 		rds_recv_rcvbuf_delta(rs, sk, inc->i_conn->c_lcong,
 				      -be32_to_cpu(inc->i_hdr.h_len),
 				      inc->i_hdr.h_dport);
+		list_move(&inc->i_item, &to_drop);
+	}
+	write_unlock_irqrestore(&rs->rs_recv_lock, flags);
+
+	list_for_each_entry_safe(inc, tmp, &to_drop, i_item) {
 		list_del_init(&inc->i_item);
 		rds_inc_put(inc);
 	}
-	write_unlock_irqrestore(&rs->rs_recv_lock, flags);
 }
 
 /*
-- 
2.34.1


