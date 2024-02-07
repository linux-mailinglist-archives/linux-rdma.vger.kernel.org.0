Return-Path: <linux-rdma+bounces-962-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC05A84D6BD
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 00:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BFA1C229F3
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 23:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F84535AE;
	Wed,  7 Feb 2024 23:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mOx8LzXl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HfkMw89p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F37320335;
	Wed,  7 Feb 2024 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707349180; cv=fail; b=RIeoDlV32db1dmI1d9dfp3RawPD6Hk8504PYWoP/icRPdk8fo4ADE5uJcVZH8kyGRL69V86hOyEs2GaLoWr+V45ATKY8Xhz6De0BS01JQOxUHdvrq3oVNWqANTVX4dB5r5pzU8GXqdydiTI2wtGu3tYzWDkBjmjx2ciNiMMAgeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707349180; c=relaxed/simple;
	bh=I59GZU1L9Y8kcZHp7FeTWfvuVPUzkBi/Y+sNHxrpoa8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FehxzgDzCjdPy9xsqINx9EimKwdu8Ro6Gfwy0sf+S8VQ+qQlTNd3HcZSEypSWy9KllFDaW2Bf7Dl4mZIxmig2MsRhkdDOxmUV6/fpvBF5pkHEoS/WMevx7Gyq5Qi1vsZnWmXmHDpq3k9pB7Z12fGzF+W7HlRAGLz5AEtvQftAMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mOx8LzXl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HfkMw89p; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417MbSI0017687;
	Wed, 7 Feb 2024 23:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=hZs8OnUkyu/Pu16nMdXpPT0RsweYzl6TsFJX0mfeOmA=;
 b=mOx8LzXl7m8hbtstF1xeXrD3us4VjxzN5k5cn9XgDO90gJAPTPyeJIPy/7/7QvYvKyrZ
 5OAHwmu27lsgyzmdjiMifWE1v2RO5ZbdDsWG4D35GuKcUYoLg0c08ycFdxhP6XjxuNR8
 srh8NUbEZFqi6U63fGhfzXrHOP3AgPGel5cEDf8S2pT9eiQnbBokBvTvrkpf86zB860C
 EXbMglqxwyvDLWg9N1xpnaE/G5DNgVz0ceRndJaIhJ5WevUN/EOthYo9SOzLJIUNO4PC
 4fp5c9NbsUQaz8FoywSkj9cS0jUJKhJ29aPulRDyC71JUp6XhbcVPpUZZdmAgR7qPnBX KQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dcbk2fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 23:39:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 417N8Ttw038324;
	Wed, 7 Feb 2024 23:39:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx9mnby-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 23:39:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDDQp24QTczIrkl6+y+Zwe94Tq16STNSPQaXmtmgzGDQW/4jrNhAhk+CyEa6lIGGbLre1IGEChjfCdC3vWcVOJP78IIDKWsHYr1symz+kQosPxyac5o7smm6uzFRS9Aoug8UxFLfLseWjes0cpQLsh7ItoYjrtegreq783eNZZhE7r7BeL27Gu2QjwFh0GCcpbau/kMX7U7G3hzZu+pel/0KURlsZAarOyAB4/bkCH1Yy8Jiq7k7Sxna+rA0eDhoCaeyc80+ro1b9bIpnmrB3LHRSIYpkfhjBwvMgyLaI5aehTtttCdSDWvMG7G0YQynMOIbkHQqUS3w1cUxgQhzfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZs8OnUkyu/Pu16nMdXpPT0RsweYzl6TsFJX0mfeOmA=;
 b=W2Gme39FTvjuovVYyl3MBwjjkOBpsydtQuGHyOkArUZte1PUdVT5kuU9sX4xHUtnA1drEAbRnshdk/XhKsrK3nyV+K9tR6n+msDHW5NmqskQCPEIz06txTMQq+BjacVwHezNBkYAMd1mnGmgeYGNXuMb1Yf/0PbIeBxHz2jB0y6DXMDMlBbHsR4wZd+CUVjfseGfpqBQ3Jf02N6VsI5YGXxi7BSGq1A4YnFYJ0+bJaZpJJZC+oKu2FKeHwNdZIndC+i5CoYSU7B0iJy4Um4WV80Tk3pBou115yJsaXZr2bzNlX4GebQV2lJr2MY5tSNL0PCGs3cJ+htHPJ3n2FD8sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZs8OnUkyu/Pu16nMdXpPT0RsweYzl6TsFJX0mfeOmA=;
 b=HfkMw89pSux9Gcme6UHqDNZiErrrElqVuJNgDGY1JmeQmGv7OuvQg1ICV1nqCyOi7br2Fy6yTf8B6uSOw163aVtj5gCfWXtYY//YSdSWKzocCxaXTmZgiNpXJJP3KxgBmM0vNX/JtycIsjg3VVthBkZVc4Isj7MPLAspDeKjfNo=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by MW4PR10MB6369.namprd10.prod.outlook.com (2603:10b6:303:1ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 7 Feb
 2024 23:39:03 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::68a8:709b:34ed:2aeb]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::68a8:709b:34ed:2aeb%5]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 23:39:02 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Cc: rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, pabeni@redhat.com,
        kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
        santosh.shilimkar@oracle.com
Subject: [PATCH v3 1/1] net:rds: Fix possible deadlock in rds_message_put
Date: Wed,  7 Feb 2024 16:38:56 -0700
Message-Id: <20240207233856.161916-1-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0183.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::8) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|MW4PR10MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b3ad03-19ff-4161-5352-08dc2835f753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	z6WNea9fMXRYg38jsEngFamDz7B+Q6tTBYaW5yo6hTizEEJ3MaaJsT7kXUSfLHPa2EQFcEvpfbn6tdkOqXa1mT2iiRITI6c+esteUUDN7qo2ItX9Jtnq44PJqJkRxrh917TK2CqJCDNJrbym2eZ309wWo4oSShgq/++caEPxZufZBUpDRBlMYp1qlfzZ41ctx2VlOuKDnb3Y6aQiyx5xWk83q2C7m5GiezOUKS9O9+qihbDdznJk6yjjuxsg2SjtlsGk+JEjA6wD1Xl2cA66xJOYcBdS5KCUescf0qhNEJyZRk4SlwlX2dIeOuEv6AVKXq1d+EKRLlmDN/JqYJVdiHBZ8BV3c8xaPTiwhmvhv4hzBPRIqqha7GxxAT1WbPfpT0oxeEC6t6GtMkE58U3ujI2YiKYO3OzGz0Q1XiCCwEJPhgGyFueGV3r4yBO1pQTrybay0Btob4G44P8FPNXjwwJGH7fXxpCzUqRjDshCu2pVpgTm7cI9nhY25VktOoLmy7es1rAi6Sg2ElnAH2R6KHpg93GzfNJRwnDWatm0XTTr05JKleFsFe2C1G1/EATM
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(36756003)(83380400001)(5660300002)(9686003)(26005)(2906002)(6512007)(1076003)(2616005)(6506007)(8676002)(6486002)(66476007)(478600001)(6916009)(8936002)(4326008)(66946007)(316002)(66556008)(86362001)(107886003)(6666004)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Q+RDM88F5M+ymBLCvEh5k3rSOdTWNGV47b43wVbdNMbypx8vI249X+kTpAGA?=
 =?us-ascii?Q?5cd0FuTXHRAb+TvSKmJzGWfGKA+UmKdJpsKYJDY/TR5WUuvbCbkp+2e25ymh?=
 =?us-ascii?Q?Ag8kQ3vTkUNZic1wqthnlqz4q1OEPHFIfeICY+oxsvuAZAV0VX66adagh4U4?=
 =?us-ascii?Q?1uPMR27pkVbCT6+vN50RUthbDptY6Nlz2iDX3jYhmmHmqcn0QlZEOp4Yb6Ec?=
 =?us-ascii?Q?tNwzZ1a7WCo6Jb/U4pEAALMzzxsnew91kRFgfM435pbi+EnOi4FT+0hmQi2p?=
 =?us-ascii?Q?MaCnk0ij0w0C8E68FLD5gvNoFAm1lQzbrxg/GAaSQABSTf0IOWlcBLL3s3Tf?=
 =?us-ascii?Q?zld4L26AE2AAqLWMxog0CmvidBlFA5WOHYvHUycqkz9lEp/SIcJRSNdVscPb?=
 =?us-ascii?Q?mpPZ11lp3X5d8eveACPz7U62M6xVB8zpOPjRHGU1NyBAiU2dKamWHco+KuhE?=
 =?us-ascii?Q?vVX6gnPSFVHmWOmqqNQ7dtkmWjLFENDpZe1SvAcYdzmGQWX4U1lp27oT93ha?=
 =?us-ascii?Q?M0czLF4/RvdFRshcevtOCXB0S6I+pmjqYB0layCo4mjNXEEsO68xrO4aTkMs?=
 =?us-ascii?Q?OfU8PhtIeiQBi2EFtH6WEalek7Zc4+bibk8mRbtZFMzSbOQM5GX+yd0bfmzv?=
 =?us-ascii?Q?aI7LGJ4GaRjPJjiP26xA4YX4GQQxplkU3eN5AO27mN5jkLyRXuwnEkWcYqoM?=
 =?us-ascii?Q?V1FBAPZutB7J0EmUqPi3fI7KkLmh1PC9dgI2wMDIs741yW+oha20LwZNug7c?=
 =?us-ascii?Q?DxkqKrPSwrZZW+UKLf+HOnTxnO9sYDVjFuBnaCyXKUHZzuhGHesRWnXsDh9r?=
 =?us-ascii?Q?RdHql8gR/J2zbNz5mqCPryxEo3FUR2YEtggdDBrmSJc4ecygtgl3eG8C5g84?=
 =?us-ascii?Q?81B1yUetnYD79Ll5X75lAB/d77FRL/jkVODugYl0ccPqpDbmL0hZT8QMa7jx?=
 =?us-ascii?Q?y1hBlbu3i1BWygoXtJhp7eT2/hD/tVvewgAr4AiLb5gH728nvi+0ynQhJybL?=
 =?us-ascii?Q?jpSkRfwYGRKyfuzKeH1JbsHEPw2oF20ONtl/yeomM5JJLcj2SphQJNmk+Ziy?=
 =?us-ascii?Q?/TbMUJjo50UA9AuedPAE8+tXEKMo/ervKpBv8SqmXMIQZ9OT0IDIXYHa7Qoe?=
 =?us-ascii?Q?vsWKvSd2FSyM6ubbrwBb9yTn9e4dQBFTokSvwnfHAJYLqZls3jZPBW1KOb/c?=
 =?us-ascii?Q?kCvaHT9Fp2im0YyIdXxpkwlmUG0SVH8tWtOVnTzUxlK24VNSf2epVue+N7E2?=
 =?us-ascii?Q?Ylw1AxZV5OkYRiGRiQcIeHzXsECvBTR8w/zNmYOZY08ZaTlhBPC5c6W52s7Q?=
 =?us-ascii?Q?+JyQExEb4HrpyWXNT52qDSuvXAASeN1HIIrm/ngUu3Zp4kHnEvmbdJmeA/ei?=
 =?us-ascii?Q?hZlYRix2kUJeC6CtuIKAzMG/HeCRYNxcRMKh0oolg4Nsm7SxzviPsl2Tkchs?=
 =?us-ascii?Q?G5nBPz4f+riDDF1Mq0URI8va9A0wDrdor/4QqrZ8XN8gKlX85myEeNPwKs7h?=
 =?us-ascii?Q?JCEW2w0BpCSoC5BXvx8iSRhkJ7AnPyhIXdwGlas5AFsN2I9agBqoCXMSBGL7?=
 =?us-ascii?Q?BWezMmNqZbrBGD5K7bsrnIUcPwMiDfkpYV20YmXkmr5Tcgya2FrjP33ZmULm?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ydy4n37b6UlML0JCdgL+9V8AqaR6YU0up3eko9sE0sIf2C4p62tkElPaUmaTTbsMjeZVPMy+XdvDS1hBsZzulSMdX0iozzEs3j+PDylb+uahZD85R7YreYDbSaGGyLkfkmmV0CDg/NmoGlSOXabkiD13QE2yw/F501mLx7RyHOR2AqQY2w1lzFhRR1e08Xr1tITc2nKHcm5NxgA9/gm08NmqKE8SLJmlNcY2p/HC704GfaEv8m+PXN0iVFl1nvfRMCp5u3M9JQto6b2bJqrTRJAOQ+rUzTP9zXoVIgI3jnbBUkueZkRpTMFjSgePPDB/Yx5OReL2xDqFMMZ83QDA81VBeHiJBXDZzlDoKWyp2/PQd+u6rZwETuuT/D8fCt1c662e1gDSIFtS35CGKeW9mk1iA1ECmtEl4wycOuGuy6wxhTTYdMXAzuF/flnhZCymQikZFfpRcTttcG4x4ps0k7IybH4mGaMAI7mXHLZ6Bvfqx89f0FYx9OnevRLsllHJLFSNYNeGeskQGVirt1O7fgUy8uvrIOEcvx3Hb9NwDZ76eWlOKpYAOVnTgvrMibeeHelBAVmmOEIHbGHSn2SJNbacWHFIRtTQ969KQmV0zWg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b3ad03-19ff-4161-5352-08dc2835f753
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 23:39:02.8928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOpv6LuOb1+6/I1yC/vPquBBNoicSfqrfUojpyuuQirc6BL095XuaHS9ZdqCgO3JIUqO9GyKqV+mSUm02mQZlOTNIxIbR9IvNZ+ehjk7brc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_09,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070173
X-Proofpoint-GUID: 0a4-79JvEYIKDPUslovhrZoa_TzJs4tJ
X-Proofpoint-ORIG-GUID: 0a4-79JvEYIKDPUslovhrZoa_TzJs4tJ

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

Fixes: bdbe6fbc6a2f (RDS: recv.c)
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


