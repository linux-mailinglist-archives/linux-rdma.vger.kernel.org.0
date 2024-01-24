Return-Path: <linux-rdma+bounces-731-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 263B983B474
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jan 2024 23:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E8A1F23B66
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jan 2024 22:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8BE135413;
	Wed, 24 Jan 2024 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d0AkV2nd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gonEmtzO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3760C13398B
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jan 2024 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706133921; cv=fail; b=ig8RQNDXlu0q+lLnvnwdsP3Lm63+/lXfZGUfpBOYyu7ZitSowublUhZZNMhpOaukvMGCVMaqaOAHmT6spMK8bDBCMBRSSd9wC0H6HT4UTYA8cL5fk44WuIN8vJTrYaayh8Nur1iH00WyMesTLFZj0ALimYRjKhkr0hCMJFs+hws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706133921; c=relaxed/simple;
	bh=ICyfLRO7xvx0PGPURktERBSxBcGiDdMNpa/wn1pbUOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FX3g4g0mqt/D4uwidklcC2E1mRqYXhgzu7HEOr/lGdPvZuW8D7Ku8rWYxyxAvTl9xMQRjUmX3YSiPzXuhu0xALl8OPtQWc2wUWNXh5UHNsVpFeLjNFN2n5VvsfyxA+T7SpJydRPoniBN0MC7Ll+qSMypZNpfUtJhb4V/+DWR/NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d0AkV2nd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gonEmtzO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OLcXq7024132;
	Wed, 24 Jan 2024 22:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=DXZdN0SaZRBirUKGaj5SPMu9P3ldHh/5c1sux+SS0Ow=;
 b=d0AkV2ndKL/HUp4Z4v3LKYCJhXmubvnp4nysCnV44ScoM98/nfehaNsmJmSsdp3vyubq
 1SpMJoUMOmcw2dYl1esJIJvgYXweifVtYtHucWjKjSzFCT8c7RykJE/qSApmTDHohNRS
 CIvNMt/USj974sSlXYdhye0+7Kvh2RLaDuTtzlS80flxtVc040b28xxg8kXLBsEEk9ka
 7kI4bjb/01HH3xIZ570UdqeXGYQDZtcdQRRsPf9a5Pu7o26UD3Ns2+G0s3j3z00VxIj+
 TNdgPL5ygi3P/rBGmYEdUwjuyCdhQzFQoPtwgxARMryppgrk06JoBQMj0ycd/FTJNPJF NA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cuwg3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 22:05:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OKosMo030682;
	Wed, 24 Jan 2024 22:05:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs373w9e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 22:05:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QX3qYPgb3khN2Ky+zJbWRaU/skUUoZJYGMYwTUqgeb7GGiHep35o6b0UcD3vi9Yp+v6Djz2XeJ8ym6cLa2wyciq9rieguf54Du5/HnP07SFoLDfd+h2543uzoeAnGUAExgAmaU32902qGCxGsis3dO6Dztw3K38lJDqahl2GjSwstf7KhPMorT1E1KVi2vO1kODTioTfkHt9pje9IfoMXskt4WTLzLFzf/VxM6ms4TQxvebIcRUPq1BvAsnlz5zH4x2of1PAiUqjGXijlYnKJHGBTTv4eOhkETHzPGNu5tEs0n0ptRNcmgGAGfqibCP7J0kfXPEPZqynVeg+Z/+Jrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXZdN0SaZRBirUKGaj5SPMu9P3ldHh/5c1sux+SS0Ow=;
 b=OoFHIfc3DolY2tgap3aSoT0WcF8SNTe7ZUmnY1+Q4Yi9K6JIQihFMspN8DfWriFd17jiywvxl1fRS1eZrhc6rIS40VVcZ6f0TQm5bp/CGQy0c4wlNA/q5HhWEstUP908ml2sMtso4Vuxy0qCU1vUOPHuyHm3SOJQX2QGBtGf01KAEVHbKDT+mqoBA6ViREAYUb4fec+XQfpQx08f8gLi+e4bCpFmK4dPV2IS4iQ42HTALhuAj+0aCm1TQYd7cKeppC/4cno4d4CtzLsoG2KW6dlMDTjFJPY4TWSg26YtmQ1n4oxHHsmv+5y+zwsuQ7jXEpxUCZvY6fx+5HelbpZVpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXZdN0SaZRBirUKGaj5SPMu9P3ldHh/5c1sux+SS0Ow=;
 b=gonEmtzOFmHp8n4BVbuKjU2E0uUP+xyFp8w2MJZxCLImSL+tIIlii5DLrhcMtGa3dbtyRvDUlY/Azi9psQ3/ydgfiUJNFgnrgDG5RmFZzFd8bySwjVqh30T1Fkutl/3Nq7NsEe8pQfXU5qwfuGuYc7VUlXC6C/JtP3QZ94v3mHs=
Received: from CH2PR10MB4309.namprd10.prod.outlook.com (2603:10b6:610:ae::12)
 by SA1PR10MB6640.namprd10.prod.outlook.com (2603:10b6:806:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 22:05:12 +0000
Received: from CH2PR10MB4309.namprd10.prod.outlook.com
 ([fe80::b0c9:ed3d:9161:b1c8]) by CH2PR10MB4309.namprd10.prod.outlook.com
 ([fe80::b0c9:ed3d:9161:b1c8%4]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 22:05:12 +0000
Date: Wed, 24 Jan 2024 16:05:08 -0600
From: Aron Silverton <aron.silverton@oracle.com>
To: Nicolas Morey <nmorey@suse.com>
Cc: linux-rdma@vger.kernel.org
Subject: Re: [ANNOUNCE] rdma-core: new stable releases
Message-ID: <tax7ypiihhjimf2qvdoqpcwobbm5jwwf742dw5hs3a662orsf5@o4lg3z66sbnp>
References: <8a4daa40-5702-402c-ae80-3f969ac823e0@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a4daa40-5702-402c-ae80-3f969ac823e0@suse.com>
X-ClientProxiedBy: BYAPR07CA0075.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::16) To CH2PR10MB4309.namprd10.prod.outlook.com
 (2603:10b6:610:ae::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4309:EE_|SA1PR10MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 617bb78a-6d9b-4670-b049-08dc1d288960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cvpDkAosUR1x1g+tLj9hiv1qCuodGeKpWhRMlFQU1kCX5y7IWPAUs8OMs+W0Cr+13g8nE+R0Oht9DyyjEadQtJOIG+wASWXimjab8a9io2xEDGo+KrE+GYx+qUaiLU7XRmVd5AYFNZoFscUR6RuRakOQXKZMA6ZFlo3zzVljGRCvAZgKGMQA07EG40ZoDIjYG7PVtMOPcHH4no7jHzUgLg3FdSVKh01g0bXggnycg02j8/wHHbUP00qalL75cLZyAnktFk4CTNzKq8260L/1gBMB/gTn8Ycegwg9h9ahKXU0eEdaOSqaJSCCXqlYZh2jONEO1ARZd4aGFEZ38jP0E8wQjqw1iLkWLBo12xHyK7sbr6j5XE2Y0ZICKXnkmsRLiPhblLKgdhy8lBRoBkjAv+YRIkdqGFw6O6MTR1dbaFyj8oK4Q9TU0mq5j/cuGlgeJKUHi0Xy7Dv8znAZJBMJqQtWXYsLGMHvV4W7902Pae5Xp2HyR16QUjWrhogZwkIjOImik4SJ30waGhrUQ+QUkl9vZm4Vo936KdVTKTin2UGxvZ/MRMgaHttTD9C0czXREnLzVjDKR8EsxHOwsnqjFkfQ0qd6rGOw4FSt3NRNsh0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(366004)(396003)(346002)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(2906002)(30864003)(44832011)(66476007)(66556008)(6916009)(8936002)(33716001)(4326008)(316002)(66946007)(41300700001)(8676002)(478600001)(38100700002)(86362001)(83380400001)(26005)(6666004)(966005)(6512007)(9686003)(6506007)(6486002)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pekQ0851hBdc0EbDE08539tQLTjYF5BESXIx3mz39P8QMPjSnhtrUdwVTjb+?=
 =?us-ascii?Q?7ClNeMEyQlFOEaR1JshYCUATa9eXR093px8BNPGZBnEi7Ed6C8hJX5SIac0p?=
 =?us-ascii?Q?Vcsh+DqcVLSdKQvOt6v/4ktUvKjxzAvRskEidrYJDKL8zdtqsPnM+DPy2L/D?=
 =?us-ascii?Q?LmV/sualY+II7FpVjx9vod9+Q4Ph6tYdsngYxgAHplxUo588AzKvuV1xpV7x?=
 =?us-ascii?Q?DQmOOUzwaWdDi2H/8lNOE/OPMp9jI8X7U1HK98Q23K1LEeCYN0v3trCAbGWF?=
 =?us-ascii?Q?welzAbHdvUEKzHmlKS/4bILRy084k244F1o2KQuFS48ZUVUvU8hI1+YOmNYH?=
 =?us-ascii?Q?B+QZwHf9NWB1oisgVIgrGUxcI/DVYZgd/ZF+rHax8hf4XUg0Z0cP2zgCGVNS?=
 =?us-ascii?Q?n55EaKE+ncJ9r51SnBDelxug2qsZ0kchonM98TBwe02CftOxD5kBYgEN2SQP?=
 =?us-ascii?Q?L51CV0bfA0wUiS7tgc1ZcfPljn818rypa5l1xwo6cVEUnVlLmyHdYZN9r/Pe?=
 =?us-ascii?Q?BCuoIyjHh85VItJ4CEWDCaBXncv4opxxV4lTqYqCSMjJbN8bom9S+za7t9hU?=
 =?us-ascii?Q?Sf8ktvv9HFq65DshGQ7ayy3+5aDWuMQ8k9+PkZF1FfqtnhvTpHCMhJ4P0AZk?=
 =?us-ascii?Q?jOgKGSrQLvFt1hF+YpIiux6KdOkiNbvho4VB63TWgoV1OiYGzrTC3NUpiLRG?=
 =?us-ascii?Q?aUxMa6dG4pYsLVt5S1pMjG9978PW3IBP4954bD2VQsYi+eVCJevdJeBb9pBY?=
 =?us-ascii?Q?EbjMgjDSqRVVu1ebZoBszMZrvW6Cb+GkNESOhXsEwj1HPt5t/86h2zZGsfvZ?=
 =?us-ascii?Q?jDw2L0hq5qlKWNyinjyzwsqHTcWPExPsglJC8qPXCSELonE+rCUGnWvRGnq2?=
 =?us-ascii?Q?xIZysQH1GdPPL9ELsIxoWbh1aA8lhdyd1/ncuhwyCvp7lJlFxgtUEVEVVBw5?=
 =?us-ascii?Q?8i2u3Ng3zHpa5bdP+6PguGQqD91mN3X+sMqhneRAQi+h++qoktK023I56I4Q?=
 =?us-ascii?Q?aBSQFrAZV2aSQ2kF0dMhHE3o4H/xK3cbm1LPB50fGWmzF7RZ1Kcty5YZAcNy?=
 =?us-ascii?Q?HQT4RXwyjHh+5kA6vxo0yAZKJanUKPgl590CNgodM/qO/089Rrt8dUstKy8U?=
 =?us-ascii?Q?DcNoqXYdZMNVkgS57DULSEF6qXonTpHJG/Y2e+muLqcsMSMGkTCjs6CWLcOJ?=
 =?us-ascii?Q?RTrOJD3MOb41VK54bvuDUNMuddSsRY0tybjYq+4KBKmTOaWMzKEQ6yCbMmBf?=
 =?us-ascii?Q?E81/p+ckBCe/vlK0Pm8+jPcRPdX5uuK8Lb0hTMEKPTvYM6tonUVMfM9T5wst?=
 =?us-ascii?Q?93uV4GM8B61b8VRCUpD94Lt/u+TDS28IYP7hqp7yoQWr4qWtSmbVqwGENVkz?=
 =?us-ascii?Q?aQSIuFbEv2W9iLzfIxC6CwxCw23e1zrTFhzWdewH/S3+LjAnjhS8FvXKFAce?=
 =?us-ascii?Q?Yyy6mbHLAVZxD1cm1pCdC9U0yw8RxXeCtniu4Yum/OjSLVfnddfKkIkosEka?=
 =?us-ascii?Q?ndRIXmi1luddEfn/Kd2MIvODCpoBM9wd+RlGjXtPIk54jPRUfKDuDWNDlx1F?=
 =?us-ascii?Q?4VPnZPsDTnPjxu7nhfpqJVUl/DgUhcqCkDOpPs77l6HEM/is7E7L/urmNhbJ?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5k4CzDAlXrI0jBad+n+3zjQrBDa+z6jiHp+/VybuEk8LsSE4qvf6U1vLjcsyKRIAq0Jz7DHqeIdlFMkSl2dkNuHKp4SEEskQiUXmiIRq0OAeMjjBl8ym06segj7+ttemvJkYTrG+7c0GzQdgGbuuzOw9NyTrdLqHGb7s3Zx8KAhN4NUbEhQwOAwuexq8WfzgW1ZSPt1bPcY6TkQEPRuAqOhVTnbykC6A4MDQ4Hl2AdpSFF13uiWpFvFkKv7P3XZyNzhkm/y13kBlpN41o0rr3Ge4wSufMZboDeCoqdRqZH3HXx8479tbv76QgbYg1RkapHSo9x7zFBu0TViHgwktLX4DiCSlomI972CSDkeK7sdhD5QFtNJZfZ3u4Ja00Q1ILxAS352vRLP6qDSLR5brpIYFJ63ceMALSaC1DmBI/lllCd/ex0w3kQOuJdCY56Jr2Yorec+UwFwxoYteD/dSMi8Pxr29OB3TndRsGAL9tMEXAqGAFTV3WxUNrcF/3wyV458p+QXBkhDZmjcXECNrlEKq4uqs/JuDvpDMhwZ4KOSRSM4yyNb5r/zOdWXPUzPC2Mn8oLZJYgZamEbigSUWZ8LLjCooOTlmiExvadAk2L8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617bb78a-6d9b-4670-b049-08dc1d288960
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 22:05:12.2649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBr6gY0tht+KKeo19UYDVb2eFSyP0Aqu3Ok2+QWQQgyBoG+3WYUmJAaS061P11H1QCZ56oUHU4dWL2pS0kZDghnWa3jypw14f3TPFos8H1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_10,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240160
X-Proofpoint-ORIG-GUID: utMZqqiyj4LarbTxBo2G7ileODd2o8al
X-Proofpoint-GUID: utMZqqiyj4LarbTxBo2G7ileODd2o8al

Hi Nicolas,

What is the rule used to determine when older releases are no longer
supported? Can something be added to Documentation/stable.md to explain?

Thanks,

Aron

On Mon, Jan 22, 2024 at 07:33:36PM +0100, Nicolas Morey wrote:
> These version were tagged/released:
>  * v29.12 => This will be it's last stable release
>  * v30.12
>  * v31.13
>  * v32.12
>  * v33.12
>  * v34.11
>  * v35.10
>  * v36.10
>  * v37.9
>  * v38.8
>  * v39.7
>  * v40.6
>  * v41.6
>  * v42.6
>  * v43.5
>  * v44.5
>  * v45.4
>  * v46.3
>  * v47.2
>  * v48.1
>  * v49.1
> 
> It's available at the normal places:
> 
> git://github.com/linux-rdma/rdma-core
> https://github.com/linux-rdma/rdma-core/releases
> 
> ---
> 
> Here's the information from the tags:
> tag v29.12
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Mon Jan 22 14:59:29 2024 +0100
> 
> rdma-core-29.12:
> 
> Updates from version 29.11
>  * Backport fixes:
>    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
>    * libhns: Fix possible overflow in cq clean
>    * libhns: Fix uninitialized qp attr when flush cqe
>    * ibnetdisc: Fix leak in add_to_portlid_hash
>    * ibtracert: Fix memory leak
>    * /sys/class/infiniband_verbs/uverbs0 is a directory
> -----BEGIN PGP SIGNATURE-----
> 
> iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMEQHG5tb3JleUBz
> dXNlLmNvbQAKCRCAG924JZiPZAHSCAC5n0oppCMuRdf+lMKeb61kPxBS/gD1xLcY
> IyUI0YYSOLLQxsrjyp+2MUAPt36KvBRj5kFInZoXtYu9Gn38i4y+pBTXk08N4rri
> GKGLRJxU2hkKytAmn813ocSVLrtIJiyQEl0qdq+O2PK0aKxiKy234ZOp7adMpweX
> CWaC2g509QY6JUjkENaosA/+sXdSU1mwiEfY4J4xjjVaGcFinCt/pXHPAGeOE3sL
> 97M4Hitgk28Jqy44l08QYQ0y45hjdrGbY2GKP6iIpGgkHPwHI6jRKW0E0d877Ml/
> xd38HqSAYJY+nje10Bn15qEFahNcj0D7U7rvtFaEVVIK+hLwqgtV
> =s1mc
> -----END PGP SIGNATURE-----
> 
> tag v30.12
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Mon Jan 22 14:59:32 2024 +0100
> 
> rdma-core-30.12:
> 
> Updates from version 30.11
>  * Backport fixes:
>    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
>    * libhns: Fix possible overflow in cq clean
>    * libhns: Fix uninitialized qp attr when flush cqe
>    * ibnetdisc: Fix leak in add_to_portlid_hash
>    * ibtracert: Fix memory leak
>    * /sys/class/infiniband_verbs/uverbs0 is a directory
> -----BEGIN PGP SIGNATURE-----
> 
> iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMQQHG5tb3JleUBz
> dXNlLmNvbQAKCRCAG924JZiPZIzRB/9CGxKOOIAVWpXiUVTYxEAygQs7rZpN4MYR
> 0h9aVswgLSZNpxb3UvmyCA6264s+6j2ZDheQ7UnPr/Zs16XLWq0CL0+qrWRYnD+u
> F0VZSoz81lqadOA/9TNz3XLN6UBUkFRzauwb76WyYdOnsRHYDiUjwgqUhkMR9MTV
> qYvWyZhPZro+1GItKD+FJ1g/1e/vtKzQzFEnHLv/AH2p5CgmBOFfmVgPYZZAdIjV
> KVSMKaBbtNNjaV/A3996Z0G7251Zo9GIYHpKzuwk8U0cWjQzAKhdoXuC+UlQLrCN
> rRh6u7p9cj2oZp/rGg5Z56/PbZCfPMLXqMXSb6AfxWwuwOd3yZtm
> =GwHX
> -----END PGP SIGNATURE-----
> 
> tag v31.13
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Mon Jan 22 14:59:32 2024 +0100
> 
> rdma-core-31.13:
> 
> Updates from version 31.12
>  * Backport fixes:
>    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
>    * libhns: Fix possible overflow in cq clean
>    * libhns: Fix uninitialized qp attr when flush cqe
>    * ibnetdisc: Fix leak in add_to_portlid_hash
>    * ibtracert: Fix memory leak
>    * /sys/class/infiniband_verbs/uverbs0 is a directory
> -----BEGIN PGP SIGNATURE-----
> 
> iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMQQHG5tb3JleUBz
> dXNlLmNvbQAKCRCAG924JZiPZBZuB/91A03upT+WfvFkV3ZDy4ei2pUJOw0EV9G0
> dSRauUZgWkOb90hgFdFYOKSyq90ChyNhsDyqOVlEppBWgjr67kSjPjmR2pX8m33y
> MYiU56o8c51XsRF5lGjVPuT8Qf4y8lPOizylVC9pN2A/Wtx++7sYOgs7pYuzFiQY
> j0XId4u1w8XgtgDIcRKZwDpPy2o/fCoW4ps1q6nYI1BPXW+Y4B43ova0OUnGRt5Z
> ehSUThcpOkRoyy3+058ylO+ZhSjEIbigy9RwVUyQebD4mmWwnhGLvmx/Cct930tl
> g9oPPg2KZEplXtUgUAynY9r2Q69z1YP4phNcd80MJp+tlst6Dp9Q
> =JVVd
> -----END PGP SIGNATURE-----
> 
> tag v32.12
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Mon Jan 22 14:59:33 2024 +0100
> 
> rdma-core-32.12:
> 
> Updates from version 32.11
>  * Backport fixes:
>    * mlx5: DR, Use the right GVMI number for drop action
>    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
>    * libhns: Fix possible overflow in cq clean
>    * libhns: Fix uninitialized qp attr when flush cqe
>    * ibnetdisc: Fix leak in add_to_portlid_hash
>    * ibtracert: Fix memory leak
>    * /sys/class/infiniband_verbs/uverbs0 is a directory
> -----BEGIN PGP SIGNATURE-----
> 
> iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMUQHG5tb3JleUBz
> dXNlLmNvbQAKCRCAG924JZiPZMXiCAC2dVGWr3MIZVJzCQyv2DU2cPzxnyKYyWcE
> EhyIWMJ9vfpJxTHpSW25769c+6U0r3OBnx+ynGrzsqZSWweeASx1iVjFJ0RJ2wFP
> eYsPEU9kTpb4fn1jjccl7VlBFaE7se99Thdc22yhOJ860JHOQGKFMY8rKFa0sTYZ
> Vs4DBnj2A1g2AFwkNhaaJvY2F2mKT0khyTA2RnfuxVE33epcbwObU9XHT/f8tV5B
> 7uPSZCzaBUSgoKz2dHy+5wT0AXPK+73WsIpWK4KxhE2hEjC48v9GCQwcuHNSrgpz
> y3UHWyotg6sh02qjjGc4NZMfXQxGEjE0GU/dTHUg6haCqYJWXDIv
> =vxio
> -----END PGP SIGNATURE-----
> 
> tag v33.12
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Mon Jan 22 14:59:33 2024 +0100
> 
> rdma-core-33.12:
> 
> Updates from version 33.11
>  * Backport fixes:
>    * mlx5: DR, Use the right GVMI number for drop action
>    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
>    * libhns: Fix possible overflow in cq clean
>    * libhns: Fix uninitialized qp attr when flush cqe
>    * ibnetdisc: Fix leak in add_to_portlid_hash
>    * ibtracert: Fix memory leak
>    * /sys/class/infiniband_verbs/uverbs0 is a directory
> -----BEGIN PGP SIGNATURE-----
> 
> iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMUQHG5tb3JleUBz
> dXNlLmNvbQAKCRCAG924JZiPZDVHCACU5Mr8AQanuwreHd4+fBUhK30NVUlKcQbJ
> eJ2CK28ZBrmZbIhPAzQBNqHL0TlIiDB5jshtYgYXXXc7qwIJNUSIEqTjnr7ijdTi
> zTTW0lWrfOEh1pcqjDe9gPhGamjsCUzGNkTmGtiJpS7UY4ubgWeXgWVtUK5ttkn0
> 7TUvmZvpvhF9H0t5fNwpbyhtwCjRAidS3Q7bbDW609DrbF816/vT9CbpIHZ4q58e
> WTBKuJhRt4+nG2XXqulqDilf1RmH0i+xNcaFwemKS17LY6wPn/e4zDXW9MrDaPkX
> 6Vz7h/8+kQdHmCcRdQ30vhI/utBJOH/zcopY1Od3Kp1lgW1P2TnR
> =sIHH
> -----END PGP SIGNATURE-----
> 
> tag v34.11
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Mon Jan 22 14:59:33 2024 +0100
> 
> rdma-core-34.11:
> 
> Updates from version 34.10
>  * Backport fixes:
>    * mlx5: DR, Use the right GVMI number for drop action
>    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
>    * libhns: Fix possible overflow in cq clean
>    * libhns: Fix uninitialized qp attr when flush cqe
>    * ibnetdisc: Fix leak in add_to_portlid_hash
>    * ibtracert: Fix memory leak
>    * /sys/class/infiniband_verbs/uverbs0 is a directory
> -----BEGIN PGP SIGNATURE-----
> 
> iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMUQHG5tb3JleUBz
> dXNlLmNvbQAKCRCAG924JZiPZNugB/9G9bKbd7FJfbwTFvvi2mO/sioNJTHI88Id
> hm5P7LriVQHLCjzO5PSCxBuK/quU40B4xS02yCUmvD6i0jIfwf7EUX1GiqC/JWj8
> UXPhTOlKc3EngzOw7xYMHWq/mslGkN8CGwEjtNFVT7nec8XwC2Ux3ljetu7VIZB6
> O1NeDHKkxSOeBljxA5GmLFqsehGjt54TcpT0cQhQuIOYfEMHiR7soR1NzJMNJ8/S
> jTdEVrStatI6aXBXcEhgTky2mBeh8v2xZxOwqRyYTYzRxFKEHGNW7+t2UHTk3h/g
> QJC9hFdh7ZwYC3oZOgXMFtwe785cesRuApcKa87OIayyT9TP+UUi
> =qJA3
> -----END PGP SIGNATURE-----
> 
> tag v35.10
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Mon Jan 22 14:59:34 2024 +0100
> 
> rdma-core-35.10:
> 
> Updates from version 35.9
>  * Backport fixes:
>    * mlx5: DR, Use the right GVMI number for drop action
>    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
>    * libhns: Fix possible overflow in cq clean
>    * libhns: Fix uninitialized qp attr when flush cqe
>    * ibnetdisc: Fix leak in add_to_portlid_hash
>    * ibtracert: Fix memory leak
>    * /sys/class/infiniband_verbs/uverbs0 is a directory
> -----BEGIN PGP SIGNATURE-----
> 
> iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMYQHG5tb3JleUBz
> dXNlLmNvbQAKCRCAG924JZiPZAwjB/9ntUqmIEGnzNjPXr8izK9A6cYIqMFr8HAR
> krfZiUDdvbMf/qSfmfYiHZMn6ymFl6tV8nJzLB9pxqNcfcdP5+4oF3B/XpKeMSmr
> VRf0hmpXGEEk4c+DNhIfAI/xT9GJDoUt2oIRHiggBMab2Cg8YIkK/mru1J0J4XYr
> HOaf7usRrcCMxvN8+aeffOPDFAVqEyNYMBEzxiukO7kVwg+fIXL8o4z8JgFN6USm
> txxidSRaCdd9B6bTKT/Z08V0w3CVfp5x9NQlXnVKOf7aplye2q9FK3Ecq4Q7hCKn
> Tf6LsgT3pO8vT749Iu1hm/cfecIvCHVoCyNVUBtIh6nbAJvUm4CT
> =F8k8
> -----END PGP SIGNATURE-----
> 
> tag v36.10
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Mon Jan 22 14:59:34 2024 +0100
> 
> rdma-core-36.10:
> 
> Updates from version 36.9
>  * Backport fixes:
>    * mlx5: DR, Use the right GVMI number for drop action
>    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
>    * libhns: Fix possible overflow in cq clean
>    * libhns: Fix uninitialized qp attr when flush cqe
>    * ibnetdisc: Fix leak in add_to_portlid_hash
>    * ibtracert: Fix memory leak
>    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
>    * /sys/class/infiniband_verbs/uverbs0 is a directory
> -----BEGIN PGP SIGNATURE-----
> 
> iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMYQHG5tb3JleUBz
> dXNlLmNvbQAKCRCAG924JZiPZFk2B/9eyrpri4YlUMYjNZ8CWgdVGMbykmYDvNou
> AlJDZqwu9vycAtwisO8kKG7N8OE+xD8QU5QZDrHdxMK5xMXt6Q1yw9utfF3n0vZ3
> AbmfGiqWFWF/+WLD/HNIrgcfvp7Syq+zpYSNv/phR2VNUkvuy6zBzZYN/5Nw1rUZ
> Q+LghjKKL5J87BiNVCPnbrCdSE8YpRleDFHUiwyvXY8LNoi+cAtO9nZUufn27hFp
> BJL8V7J+26rJ9FFEcy/jbDoOKs6t0cAFMYNPJAyYS8ItJ19X8gaxOcwHt2bgztXT
> 1PWwz5YR1a8oTAeA9Gw3CW4R3u0MmnJC5/OKzM/0Dlw+KXnCV53F
> =tJch
> -----END PGP SIGNATURE-----
> 
> tag v37.9
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Mon Jan 22 14:59:34 2024 +0100
> 
> rdma-core-37.9:
> 
> Updates from version 37.8
>  * Backport fixes:
>    * mlx5: DR, Fix the default miss vport
>    * mlx5: DR, Use the right GVMI number for drop action
>    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
>    * libhns: Fix possible overflow in cq clean
>    * libhns: Fix uninitialized qp attr when flush cqe
>    * ibnetdisc: Fix leak in add_to_portlid_hash
>    * ibtracert: Fix memory leak
>    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
>    * /sys/class/infiniband_verbs/uverbs0 is a directory
> -----BEGIN PGP SIGNATURE-----
> 
> iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMYQHG5tb3JleUBz
> dXNlLmNvbQAKCRCAG924JZiPZFJRB/90dUmtu0S4ChgTdbEXU7ef6Xzng/TW8vW1
> FEnwGwyCnIcEJtjPpsDj4D0WGiaZsJY5MTCYAAhx2n6ClCPgZMrMLL9UnMpCFBe3
> Y52IDvxyuUwqVVzu7yHWrkC3I5g/HJWuaMm8KX8pRGpnfib12sYN4qR6kE0q7Gps
> akLycBKI8WoPkM1oJCgZPFALiuOX1crscF27h931fDCwpzeDk96nRE7ERR2arCy2
> LCgxIQ+jBrUW6uH3oq2qgHtxodz5DUYDzqBy8W7QEbBU1Hq9sC0wuDGW0pc+Cvg5
> fp3XJkKmdm/Re7mG2c4gaMGmDbvFa7q+Le5cgYqtZw5m59u/PINv
> =D/4m
> -----END PGP SIGNATURE-----
> 
> tag v38.8
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Mon Jan 22 14:59:35 2024 +0100
> 
> rdma-core-38.8:
> 
> Updates from version 38.7
>  * Backport fixes:
>    * mlx5: DR, Fix ASO CT action applying in cross domain
>    * mlx5: DR, Fix the default miss vport
>    * mlx5: DR, Use the right GVMI number for drop action
>    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
>    * libhns: Fix possible overflow in cq clean
>    * libhns: Fix uninitialized qp attr when flush cqe
>    * ibnetdisc: Fix leak in add_to_portlid_hash
>    * ibtracert: Fix memory leak
>    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
>    * /sys/class/infiniband_verbs/uverbs0 is a directory
> -----BEGIN PGP SIGNATURE-----
> 
> iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMcQHG5tb3JleUBz
> dXNlLmNvbQAKCRCAG924JZiPZDgyB/kBfCaDaTcL5z3yJB+yGfMo5AeJJTJlZFiv
> 35v06RV6vIsbkIZpOCVsK72FF1VprabhMuvK2g1/gsSpzEtIG834hH3CKvZbTVnd
> /ONEQcERVGedHxqHenfma4shcrnUlWL7Us95RrpbRP/sptztq7P6zAHRQHAq6EGY
> jFclCuuSIO2jDdEBkbZANvcCFUXl6JzpucLEDE0C+D5tQXB20Nhr0dwUUofb8zSv
> JyqbLONxcHFHzbzt4bXm+2s7CtwMDfBszjpXoeCkHEIADjElY6mhUfcyV4QH6d57
> U+YCEXwwlJa63wtCjUUmLcDPT3sXVTFrMeaHGZrQhCSLbomaa2GN
> =H/zh
> -----END PGP SIGNATURE-----
> 
> tag v39.7
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Mon Jan 22 14:59:35 2024 +0100
> 
> rdma-core-39.7:
> 
> Updates from version 39.6
>  * Backport fixes:
>    * mlx5: DR, Fix ASO CT action applying in cross domain
>    * mlx5: DR, Fix the default miss vport
>    * mlx5: DR, Use the right GVMI number for drop action
>    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
>    * libhns: Fix possible overflow in cq clean
>    * libhns: Fix uninitialized qp attr when flush cqe
>    * ibnetdisc: Fix leak in add_to_portlid_hash
>    * ibtracert: Fix memory leak
>    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
>    * /sys/class/infiniband_verbs/uverbs0 is a directory
> -----BEGIN PGP SIGNATURE-----
> 
> iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMcQHG5tb3JleUBz
> dXNlLmNvbQAKCRCAG924JZiPZMjnCAC0oXB/dSOx3bpM2hl99C7hsrIfyUxprK7k
> qgCgOPGNZOOm3jZ8jpijPwGLgwM/CA9TeZmbFuttP1KU+0TOJgrEJehM4hbpAvTD
> 1wbkk62AkA8GYVUpKEDmSVyCX3cIuvj2w3oxQvqi9FFt68FmLG7Hc5tHQU1IAA08
> Qx1otLc7dVbmmotKdVyTOhp8eumSc5a564t5kdmE1lVIQqCMw+8kvF0fXT2fr290
> fhaJY8FwrXkK4nDiK08z7vYGFlRednDBMyxny6Kkxi4n+wS/g6mwq+HOeSFmLBuz
> 4wPm6WFht2ITMY5btVRTxSu7lDBLgKDyH3dquUwSSqlEI2GaBEXX
> =eQy6
> -----END PGP SIGNATURE-----
> 
> tag v40.6
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Mon Jan 22 14:59:35 2024 +0100
> 
> rdma-core-40.6:
> 
> Updates from version 40.5
>  * Backport fixes:
>    * mlx5: DR, Fix ASO CT action applying in cross domain
>    * mlx5: DR, Fix the default miss vport
>    * mlx5: DR, Can't go to uplink vport on RX rule
>    * mlx5: DR, Use the right GVMI number for drop action
>    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
>    * libhns: Fix possible overflow in cq clean
>    * libhns: Fix uninitialized qp attr when flush cqe
>    * ibnetdisc: Fix leak in add_to_portlid_hash
>    * suse: fix issue on non dma-coherent system
>    * ibtracert: Fix memory leak
>    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
>    * /sys/class/infiniband_verbs/uverbs0 is a directory
> -----BEGIN PGP SIGNATURE-----
> 
> iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMcQHG5tb3JleUBz
> dXNlLmNvbQAKCRCAG924JZiPZJ7jB/0bBeQbsw7cIwcRmf27IqdORqtf8kvoUFiw
> dFep16JjJTZ1PDDgDl04aUeeDEhG9VTk5PmuvrbSRC/p/h+9adv8AZGmzJLZfmsz
> BBGAgQ3gcjaUKh3GZYMSb5056FSjsAWGIa9+0SBV/bExVkZCtIs55hKW1wY951cl
> dsiQJT7RGftBwrIwKOVq1zWQJnVkDlLg9Ef82pVKv8M5zJKAMs+cVDwLHnpPjE2o
> RM5nmSSr2vioVy0PQuP9+ck2mnIKT60GryDMuUMSgjyZuvVEId5ISF7UtlC0MNJ2
> lTg4lJGks389XVDbojWrDfEYzfvNWyEDPI7srMWaNYioZQz+YQPG
> =z5S1
> -----END PGP SIGNATURE-----
> 
> tag v41.6
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Mon Jan 22 14:59:35 2024 +0100
> 
> rdma-core-41.6:
> 
> Updates from version 41.5
>  * Backport fixes:
>    * mlx5: DR, Fix ASO CT action applying in cross domain
>    * mlx5: DR, Fix the default miss vport
>    * mlx5: DR, Can't go to uplink vport on RX rule
>    * mlx5: DR, Use the right GVMI number for drop action
>    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
>    * libhns: Fix possible overflow in cq clean
>    * libhns: Fix uninitialized qp attr when flush cqe
>    * ibnetdisc: Fix leak in add_to_portlid_hash
>    * suse: fix issue on non dma-coherent system
>    * ibtracert: Fix memory leak
>    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
>    * /sys/class/infiniband_verbs/uverbs0 is a directory
> -----BEGIN PGP SIGNATURE-----
> 
> iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMcQHG5tb3JleUBz
> dXNlLmNvbQAKCRCAG924JZiPZK04B/0Wz8Y8EquLTpfBO91d/lLa4EFMHI3ev8km
> mBNSIYQnJpcUSgFNJq2IvCHf2x2qX4FOvVknnBqpmgiBwsOwe8K42IVorYcVSOpt
> ORdhRqPqorRnxEI/c1uOHK+RiKTOIQl2tc1CLeDD1X7PGl6efBAjh7zEaMmj9nhC
> EXV6eq8jLBvB9svVVrczggWdtTJzaVUViZwpjeOHe44eSTNEdOMuSTB23jBI4NY2
> A8t+DkcyxVKPs7anlvoLa3AWPtKp/xrs2YZbZcUW/dNgmzojsVgs2KpB7cjXzlUf
> AXdjspNF0pRON/gqO24ypwNMXCSNBvXz88VZvWqJw2+gzjBfDd+5
> =tzAg
> -----END PGP SIGNATURE-----
> 
> tag v42.6
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Mon Jan 22 14:59:36 2024 +0100
> 
> rdma-core-42.6:
> 
> Updates from version 42.5
>  * Backport fixes:
>    * mlx5: DR, Fix ASO CT action applying in cross domain
>    * mlx5: DR, Fix the default miss vport
>    * mlx5: DR, Can't go to uplink vport on RX rule
>    * mlx5: DR, Use the right GVMI number for drop action
>    * mlx5: DR, Fix pattern compare
>    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
>    * libhns: Fix possible overflow in cq clean
>    * libhns: Fix uninitialized qp attr when flush cqe
>    * ibnetdisc: Fix leak in add_to_portlid_hash
>    * suse: fix issue on non dma-coherent system
>    * ibtracert: Fix memory leak
>    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
>    * /sys/class/infiniband_verbs/uverbs0 is a directory
> -----BEGIN PGP SIGNATURE-----
> 
> iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMgQHG5tb3JleUBz
> dXNlLmNvbQAKCRCAG924JZiPZL5FB/9NE1Rk+EQoRCKTEc5TxR99fDPPb7+Jhcvb
> D5d+PtrggZbGb5qDLLm7Wt07cdYwsmWOzGhmbOQJXvJUW36R+qPPV0atIX8gd0QO
> 8GBe8ybBLrJrZyeQ9agh8Hh9FRvryrpInruH+LUuFm2Wu5cOiKiroJ2ZkBhtdVOq
> TWt//ByVG0FdkkOF3dQFTpiXtJj0dNCCSfyycja0ufKZ8Wn6FC+OWhRVvxJ7w+zk
> RxygZisVHEGveywKFejWMQZ8Gk2XjaJwUIllNszw9meGuGC7QEbXjC0WmSLbAaOe
> gO2zTKh9rLBZstsa05gfaHpP2/8cDbmhysXv9OrFE2NUuu3oYl5E
> =aaoI
> -----END PGP SIGNATURE-----
> 
> tag v43.5
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Mon Jan 22 14:59:36 2024 +0100
> 
> rdma-core-43.5:
> 
> Updates from version 43.4
>  * Backport fixes:
>    * mlx5: DR, Fix ASO CT action applying in cross domain
>    * mlx5: DR, Fix the default miss vport
>    * mlx5: DR, Can't go to uplink vport on RX rule
>    * mlx5: DR, Use the right GVMI number for drop action
>    * mlx5: DR, Fix pattern compare
>    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
>    * libhns: Fix possible overflow in cq clean
>    * libhns: Fix uninitialized qp attr when flush cqe
>    * ibnetdisc: Fix leak in add_to_portlid_hash
>    * suse: fix issue on non dma-coherent system
>    * ibtracert: Fix memory leak
>    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
>    * /sys/class/infiniband_verbs/uverbs0 is a directory
> -----BEGIN PGP SIGNATURE-----
> 
> iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMgQHG5tb3JleUBz
> dXNlLmNvbQAKCRCAG924JZiPZDnRCACeYWyurhRjdQObfVwRe9D4jyRlD5kelgei
> uA8dkC5iRC5Pj0099+lSkLQp7howArzql5/NZwf2KStifcUfms+6DfTf1iz2KVrP
> rFaLA52IUi+e9P0i4rT4etS7QjnGq+lJjdT451aP6iI0i3Zt8Od7LMgGDzkSRgAu
> Y+IQPhYT9bB8NdhaQcvF4zJFTg9wWUqXrDsr/v+YbMiZrkl//NehlTsNYeUEdQKY
> ZrKd51nwnVfFQ4Yq+k7SiNHgf6+Xg4/aXZBuUHfa87UMPrUFY/NAx4wKSGO3GYbk
> /E0etODeBx/Zmuv17Sj1lvGuXoataVC6x+rr6HrhTmw9TVGFjczG
> =3Dac
> -----END PGP SIGNATURE-----
> 
> tag v44.5
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Mon Jan 22 14:59:36 2024 +0100
> 
> rdma-core-44.5:
> 
> Updates from version 44.4
>  * Backport fixes:
>    * mlx5: DR, Fix ASO CT action applying in cross domain
>    * mlx5: DR, Fix the default miss vport
>    * mlx5: DR, Can't go to uplink vport on RX rule
>    * mlx5: DR, Use the right GVMI number for drop action
>    * mlx5: DR, Fix pattern compare
>    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
>    * libhns: Fix possible overflow in cq clean
>    * libhns: Fix uninitialized qp attr when flush cqe
>    * ibnetdisc: Fix leak in add_to_portlid_hash
>    * suse: fix issue on non dma-coherent system
>    * ibtracert: Fix memory leak
>    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
>    * /sys/class/infiniband_verbs/uverbs0 is a directory
> -----BEGIN PGP SIGNATURE-----
> 
> iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMgQHG5tb3JleUBz
> dXNlLmNvbQAKCRCAG924JZiPZKiWCACjEgkdV5atcQe8AqUMvEhrG5KGU7q824+E
> 8oRF20yh+5aHOrkotiq40qf6EypY/H0bBe7nhpLG31iqgyoZuSz97Rm7aSc7qi+h
> CntG+MEoX8Ah0ZMJBll/Wfrg4Ps6W/+3dlRwtoEjbXcYR8g5yqFCQzZ+A21Bn1E8
> jDrVSWsJgI7CKND8p+3UcW32zjWKGip25g+bvTBI1LFwNbFHZcHrIt6gNfRkV7GH
> PBLJBvqzkKKcrvQH9CL420dBlP4yVu6vmdnDDD8wasGbRi/GuBFm4Ip67Utwf+Y7
> 2c/UqXrjuESnVYJRlnetqdJZO02WzqugEG1MAFZDdVp75bcqoET/
> =Ja8k
> -----END PGP SIGNATURE-----
> 
> tag v45.4
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Mon Jan 22 14:59:37 2024 +0100
> 
> rdma-core-45.4:
> 
> Updates from version 45.3
>  * Backport fixes:
>    * mlx5: DR, Fix ASO CT action applying in cross domain
>    * mlx5: DR, Fix the default miss vport
>    * mlx5: DR, Can't go to uplink vport on RX rule
>    * mlx5: DR, Use the right GVMI number for drop action
>    * mlx5: DR, Fix pattern compare
>    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
>    * libhns: Fix possible overflow in cq clean
>    * libhns: Fix uninitialized qp attr when flush cqe
>    * ibnetdisc: Fix leak in add_to_portlid_hash
>    * suse: fix issue on non dma-coherent system
>    * ibtracert: Fix memory leak
>    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
>    * /sys/class/infiniband_verbs/uverbs0 is a directory
> -----BEGIN PGP SIGNATURE-----
> 
> iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMkQHG5tb3JleUBz
> dXNlLmNvbQAKCRCAG924JZiPZC2mB/wP07duyCgE7/4n5txuVsREO/Ld1OlbOzsZ
> /NI28jLRneJCzZDWy041eyMkskPkHTdDrsU2DMO1xQhwzyOhhxsSR0zAa+M4b6FM
> tav0pjItquQar2/CoBfnJw11+w/0fWgvYiFjRzzjGN9vjKnZBFKTUNrpbRu+wT44
> 9PHyuDCjx/XKZYCGmA057VQXAYE2KKXvwFmaihfYctJ9IxsKEvR1TO+9QazU35ys
> sR9r26fuCOt4kGnEV+/+MBK2fHyY30cJm/kfyNK4yvMNSPTRFUv0/f/wkvII6siC
> cij2a+kFKsbCK5WkiuaxLeUlWIP7vqfhaVEKIX+lJPyEdazNPrl8
> =mT8B
> -----END PGP SIGNATURE-----
> 
> tag v46.3
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Mon Jan 22 14:59:37 2024 +0100
> 
> rdma-core-46.3:
> 
> Updates from version 46.2
>  * Backport fixes:
>    * mlx5: DR, Fix ASO CT action applying in cross domain
>    * mlx5: DR, Fix the default miss vport
>    * mlx5: DR, Can't go to uplink vport on RX rule
>    * mlx5: DR, Use the right GVMI number for drop action
>    * mlx5: DR, Fix pattern compare
>    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
>    * libhns: Fix possible overflow in cq clean
>    * libhns: Fix uninitialized qp attr when flush cqe
>    * ibnetdisc: Fix leak in add_to_portlid_hash
>    * tests: Remove FW reformat check for SW tables
>    * suse: fix issue on non dma-coherent system
>    * ibtracert: Fix memory leak
>    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
>    * /sys/class/infiniband_verbs/uverbs0 is a directory
> -----BEGIN PGP SIGNATURE-----
> 
> iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMkQHG5tb3JleUBz
> dXNlLmNvbQAKCRCAG924JZiPZNCLCAC3QKML7EHfX9202F2CSYhaTN/1AsuYIKpo
> UQf9s3rKmu4Fah4G0Cf1sG0jgUL/V0UC6yYCLA4hqY38yoZskC3jRdOGko1wblbK
> y8AJmong9gIbQUWjDsFw24TLjgcV+DoFb3p719FjfhbuB+wF4oufEnDmkxg0b4Je
> numgMI6kVwhyf9MPcIKAly1nA69OxLj59KOUwIUIOogJVWvdyLpeFemvEcLyMNi3
> 6aUvsX3FszboKjE2Ybsp3YOOa8A4rzkoZd7MH1lP8xggBya9+68ZcI68thep+jAB
> UK3gdE9yKyMq+511gRNgvrJs/5rkVizCXy/WHK3CgZK8pJJQlBds
> =4lp/
> -----END PGP SIGNATURE-----
> 
> tag v47.2
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Mon Jan 22 14:59:37 2024 +0100
> 
> rdma-core-47.2:
> 
> Updates from version 47.1
>  * Backport fixes:
>    * mlx5: DR, Fix ASO CT action applying in cross domain
>    * mlx5: DR, Fix the default miss vport
>    * mlx5: DR, Can't go to uplink vport on RX rule
>    * mlx5: DR, Use the right GVMI number for drop action
>    * mlx5: DR, Fix pattern compare
>    * mlx5: Add atomic/rdma read for DC comp mask to man page
>    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
>    * libhns: Fix possible overflow in cq clean
>    * libhns: Fix uninitialized qp attr when flush cqe
>    * ibnetdisc: Fix leak in add_to_portlid_hash
>    * tests: Remove FW reformat check for SW tables
>    * suse: fix issue on non dma-coherent system
>    * ibtracert: Fix memory leak
>    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
>    * /sys/class/infiniband_verbs/uverbs0 is a directory
> -----BEGIN PGP SIGNATURE-----
> 
> iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMkQHG5tb3JleUBz
> dXNlLmNvbQAKCRCAG924JZiPZNFrCACljv8ZorgaLfpszpmEoIxVDwOpZCLE+FPo
> fjmTtcegBjOVHXXqQsU6wIHdJJQhu0jfR+4+NEF3CD5k6QBPWgyiEtH+rHaLxwCm
> Ftm7bC7tuDICUv74b/gvxM/O6P0aGzqS88bTQR8v1m/kT5JZBdrbXxBxIzGGOmBR
> qicJbHRMF4aeil1z6tfK9T5gB+c23ZAMMcFHBzVpT7zY0OAJ7TcAZqExzk5ATAjx
> nBDi+A+lN+D+c2nmtzq71CKfY8jG0c5SAl7/lOY4KAt28B8+mBsCbVu/yRoHlD1b
> Ccl4no/p4OpF3hacfoycAyrueO9ZqZhnXymBqGRb91NPD7buWbpX
> =t6Qo
> -----END PGP SIGNATURE-----
> 
> tag v48.1
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Mon Jan 22 14:59:37 2024 +0100
> 
> rdma-core-48.1:
> 
> Updates from version 48.0
>  * Backport fixes:
>    * mlx5: DR, Fix ASO CT action applying in cross domain
>    * mlx5: DR, Fix the default miss vport
>    * mlx5: DR, Can't go to uplink vport on RX rule
>    * mlx5: DR, Use the right GVMI number for drop action
>    * mlx5: DR, Fix pattern compare
>    * mlx5: Add atomic/rdma read for DC comp mask to man page
>    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
>    * libhns: Fix possible overflow in cq clean
>    * libhns: Fix uninitialized qp attr when flush cqe
>    * ibnetdisc: Fix leak in add_to_portlid_hash
>    * tests: Remove FW reformat check for SW tables
>    * suse: fix issue on non dma-coherent system
>    * ibtracert: Fix memory leak
>    * providers/bnxt_re: Fix bnxt_re_alloc_queue_ptr error flow
>    * /sys/class/infiniband_verbs/uverbs0 is a directory
>    * stable branch creation
> -----BEGIN PGP SIGNATURE-----
> 
> iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMkQHG5tb3JleUBz
> dXNlLmNvbQAKCRCAG924JZiPZDIbB/9ZtEOh3EXYUZHN+X9FkcuQ7QKWIINO3XOz
> /DeWHHht79OKhfP1pTlcu5Opnd9uMYmQdVJVPsvSj6wb/6Z+FQAOL/deVPgpsm53
> 9bljctQ8tWwvxq2ppEco1l4QBHdxWuUcP492D0gmFYc/epzScxho8HqwpA8YoR3H
> Z84CVurNHYYYCfLuUHLjWzCFyoU3c2rbnzoq+HhhzxBMCa3sJDP4Qo7237IcxNec
> JG0ddVI4LsWP+AubhOmcaYhImpUJgRzhlkD2S8kKCRGO2qXZfVK057h3vb8u9w9r
> 1un5djWq3swBqA6yjyiJQrDAaF52xEoRhb26J7Q6bCKqXGztqjcp
> =YBdm
> -----END PGP SIGNATURE-----
> 
> tag v49.1
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Mon Jan 22 14:59:38 2024 +0100
> 
> rdma-core-49.1:
> 
> Updates from version 49.0
>  * Backport fixes:
>    * mlx5: DR, Fix ASO CT action applying in cross domain
>    * mlx5: DR, Fix the default miss vport
>    * mlx5: DR, Can't go to uplink vport on RX rule
>    * mlx5: DR, Use the right GVMI number for drop action
>    * mlx5: DR, Fix pattern compare
>    * mlx5: Add atomic/rdma read for DC comp mask to man page
>    * libhns: Bugfix for wrong timing of modifying ibv_qp state to err
>    * libhns: Fix possible overflow in cq clean
>    * libhns: Fix uninitialized qp attr when flush cqe
>    * ibnetdisc: Fix leak in add_to_portlid_hash
>    * stable branch creation
> -----BEGIN PGP SIGNATURE-----
> 
> iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmWudMoQHG5tb3JleUBz
> dXNlLmNvbQAKCRCAG924JZiPZGmEB/9wYunI9Bw9ecBepSTyPheEY1hu/4H4gGDZ
> uUAmOLQpgJMeBcAlj/joSbngEbdPEgnTLRk92Vzdno6/456Aoe64mdhS5h1orcrb
> CLzwpUBqxAzt5++2l2TRSZrywWkci9jQoqBfA4wuF+z6acvpsfyTKq7vblhxJOf0
> 7uIlzO51hOenEwpGiPeGBJTD/yQD4Q4VRs6LVcPi4ewupAyKYRw1ofL5phPD278P
> dhmci/Ral7+X4aFkdFCP4z9OQkiksnT/54wFUxUWf55GKIdZ0hXNK345UNU8qxFX
> 2wvWOr5B+gNxG1NO98PZbWGNR5ty46OovcTJjs/sffPi6JEA5HFW
> =i2gO
> -----END PGP SIGNATURE-----
> 
> 

