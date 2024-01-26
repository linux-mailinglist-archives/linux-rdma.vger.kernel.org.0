Return-Path: <linux-rdma+bounces-771-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457B883DFFC
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jan 2024 18:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD044281A3C
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jan 2024 17:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9501F604;
	Fri, 26 Jan 2024 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EM0nn2/K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dltkpIJt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1BF1EB41;
	Fri, 26 Jan 2024 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290029; cv=fail; b=eQP0VkwcjRSYnWPv+EksspXPKS96Ew8AzZ+Nd1o6vIHW4O7Ud14RgDNqTxPRdt0/TnbvzdhZetSIfQGBydXO997geoEysZKw6CSsajStjL8U7R/UnPC9RJyjzwwN8313JTXseLR4yFQpm1Sn/j4elwGuDkLA/FNG2aTl3K9H6jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290029; c=relaxed/simple;
	bh=xuxQhHONWQD+iX1KBIKmE4uDHpLucnBKSK1ITFqolwk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dSD07DK58ioko7B5x6kgYVm/YfmsBBEjDVUT6rYUrfEbldQqs/GFuMnpIXsBFs417qdt/8PlBfPK/oMaY1dr9kSZZkHQPb3X0bg501I6CNfRVSQ5QkHHbTtQ6J8va71Ca8+3kvar4ExHtkI/AnMwLRycItwbF6O1hmDkxr6XLoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EM0nn2/K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dltkpIJt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40QEi497003483;
	Fri, 26 Jan 2024 17:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=eB2nDC48SmaIubQ3faYiAV6RTVnMpcEtf6C4Hw/jWvs=;
 b=EM0nn2/KuYynbmzAgqGbs/UScRVu5uekq25EDxSFKiINelPsEOapAN011gq5S2Kwpc6L
 Rk5seiF5Vjg2y0bKlcntnWEdONLwYtqG1CAwu5krfNNcqHH2OPPEvCkiCwlnr3kJsb2/
 MvnoGS/2TT7h3Fi0mbq86XaDAqFL6UQYdn43X9YyQD0QCfPxPaAxRCIbmU/HSN3RF0AV
 Gm5L2bZVuRNTJ0ycgH+ePPfsMwT43V9D1KgoIDCyfCRQuo8HiS9TYVvrtjIwdTnvXniV
 Mpvxb2VDPA03/kvDgSPm0pjTVaaTnRZCkD7S7duitVvSwn9dtXnGy7VvQyzbUr7An/wn kw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cwte1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 17:26:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40QGmCXX003980;
	Fri, 26 Jan 2024 17:26:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32w64t4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 17:26:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPKVIobykR+VvbsbFWxCK9GJEnoFxaw1Ukvw96nI1sSSOylwXyWjQZ54eZQxc9XXDuS/CtG0faJ9gP7MwY2KKVwQlLUpVoG5EjuVSgup2zMDGztttWwS6FFg+f1hZP69ldGQUUxgmtwL4JE+Kat84zuup42h1G2ee/rtlNJQ8F9q5KqP94llhmDYytQVcbyWpiJboeQIgJ2ge0+s5yQAqU6+hL1FoRBxHvkMz69DyeDw9PNnQAXk/pcAU7WdHn5Ged1i2OQKyiidcHieuLWvVGkfG0jqTDUIyJj8PG8LU5Fk3aUCJe5YNdnbSfoHXf4M2+6fcuWJlbgIfRyAe4IOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eB2nDC48SmaIubQ3faYiAV6RTVnMpcEtf6C4Hw/jWvs=;
 b=PNj2qOsISIzU4uJoOY/XQTnucKNBBe9+WTH3n+MrWrRJf42PTYL6TQFkXe18+mrHoIeJCX73vnGbT2We4b+FFF3yi7w//IfvgYMUq1YxNTLPrzHv/ODsNP4WzFnu+wssHPlmY9nVvijLj494WvaehDpgeR0q0ek4z690nfYG1gXZi1EjkY/7+sxtVc5kxxL8iPiygN79EwYH3UbZfMRZgyRHkBed5zxEJl/aJHQKyk7+BEqQRFQxa8vVjrBbNqLyXMmqAmVL/iDCMsRWwgvGwWytvy7/9ecfU2kwmkCB3H3kpOGueEAHxCsRVB1OyaVgm33WV4wQrFysGRZwZqpcIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eB2nDC48SmaIubQ3faYiAV6RTVnMpcEtf6C4Hw/jWvs=;
 b=dltkpIJtdkMjQRTKJS+VSOJovkjbM6qmGl4Cj7xuY98TrNsUEEFaHhwQLfeT2qrNnlM5Ul6DXaBGBZx47jm1RH/ueHXXS6X8qRBBxyyVMXCxJSry+ZOZdHBRokMbxUvRy+w9vNN3HUNqVQr43LB/mG6YEK9ofJNISXv5u1rIP1Y=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by CH3PR10MB7494.namprd10.prod.outlook.com (2603:10b6:610:163::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 17:26:55 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::8cde:f1f2:6ec5:fbe4]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::8cde:f1f2:6ec5:fbe4%7]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 17:26:55 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Cc: rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, pabeni@redhat.com,
        kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
        santosh.shilimkar@oracle.com
Subject: [PATCH UPSTREAM 1/1] rds: Fix possible deadlock in rds_message_put
Date: Fri, 26 Jan 2024 10:26:52 -0700
Message-Id: <20240126172652.241017-1-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0334.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::9) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|CH3PR10MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f721f8e-78c7-4227-bd8a-08dc1e93fe20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6t1kJAwumssuRA8QMcmLU2as0qyQFU20PmwzMbMZ4xc1Z221gJS5gTn8o5HUKv1pn3phAzqyTjrtplkxMAmdSqLleAnyWfPCUk5yTqQymD+b+R8ljYJksvkcbQQelvSRbaYp4kL/u1IPrdx2sf5IVrwddVHlIJOqx6JBt+WZ6opS4NsRPWxVQG7xJ1ZCV/M3/jb+aDqXshPGSbpd1yHf+T7g+LuVkt8ZBcKhef9hX5rVzacEIgwdd/RojUro23NPo9SNqUSJgY0UQFXfBAwavkQyR3EihqrGjIJX9BR9MMLOavsvSwPyi/SzNIJzHc7fgBg3o1xq9Mu9DnAJyFmfbP+hIqXbQN3W6CLVKik8VMxcsR4DSvoSSd2XipHBlb4R4Yu7q5Yx/fPKbeh98I4mGjtsvG6VzrECEXYQk0d7RF8cK8+NRBgixflS+VhGOto49ZYUSKN0yuUa6L/WWJuuoJJWio1ZVfHjetg+BAyktchDBU5N7I61Gzfzh5ANp7cISiqYGRviU3m1xE90L8a5KAh8Q0/dGYR7VlnA3lxIf2PEfP6NhevSq2HNjUupXust
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41300700001)(38100700002)(316002)(66556008)(66946007)(66476007)(6916009)(86362001)(8936002)(6666004)(8676002)(6486002)(478600001)(6506007)(36756003)(4326008)(2906002)(5660300002)(1076003)(2616005)(107886003)(26005)(9686003)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wzKXZKgLBPBoBZyaGHgW/krspDtc5GSlyjY+JcVqjBxDOSbg+Av8KES+9Rrc?=
 =?us-ascii?Q?uU9M/O2q6NtB4YTmsvfR5qYEVnGyhIaCcZzWya9A5dAsHruQkshGaa/bCnLq?=
 =?us-ascii?Q?UKG+BHw79wXUy9woTLmCtRIuWs+Sz+9yU4n1YgvHCGR2IgvRtCRe2Jlu3rRp?=
 =?us-ascii?Q?jhPlfHe+qM6wdTw+3/LP21CHkpb95R/dUkQt1WlbE8R7JMavs3Xzjj8o6sRc?=
 =?us-ascii?Q?5lAOV5OFN9EUZL5HbSWzW3MnbE1w1cn+PJwE5O+EDRksNAUjJDktoxaR3wIt?=
 =?us-ascii?Q?U840ot6Y8oWvepWTk0gK+vq9O+aEa8aRHDWrDYeFK9TUQOxkVykXkhb0Au4+?=
 =?us-ascii?Q?mt+WzlHwCFKQxM5we1v9yMfwmrv/aiw2srMDF7iSzxPVIiMDoAQllVQzs44o?=
 =?us-ascii?Q?+IaimJqCBL0a13+cGYQXmxfGje7wrn2kjgCJ7pgIEJOlkaJYpI8pJV31vDeC?=
 =?us-ascii?Q?L2MzegvJX92E+ERaOEFHptXev4HvSSEdeUbROJHPFZaqm1NFxqHVKPqtfYdM?=
 =?us-ascii?Q?QBQOVlMTR0EQnqCqCtC7ydlCqJrkUr+xkVwuU47o86kOe5b5JGKba+2MnwrT?=
 =?us-ascii?Q?/3rtkNLIFKqgLVEynCeVAolTVnXGhhcP1qJTzMPP37959jLib5zES0VRq5r7?=
 =?us-ascii?Q?yymFlEnxiQGYhrPQFogC4gtaAmI5sos7PMuM62miLBquq9U71yYO+thw7yGq?=
 =?us-ascii?Q?vnUYdcVqWoliQIBGSKdOZJhVpwnWeOGBKOCcQqvHTR7h4zSFM18zfbO/l77w?=
 =?us-ascii?Q?jBtaOU8kJtDW5RKrzilpcz4MaXE5VNav3R7MWuX3trtCv7T9w8B7IDRvVkFN?=
 =?us-ascii?Q?tXFAyy8gGF7qqOudiLz3EiucD2njjNkzi9qQ2rdK0umzy2n3/R1YccMEJiip?=
 =?us-ascii?Q?io/VEAc9tXFyRAkrgUNoBmjtwjKn7YcQ7hA5kkTASTFbyBRU46jrJaBE1TDO?=
 =?us-ascii?Q?R/EBIO7AbvOs+smyFy6QD/dfAFjHRDR1t3Sh0opegjFlbpnT/3airsAC3Op8?=
 =?us-ascii?Q?UNS8XV/s5pmhFTX9B2EgXKNWv8/CaXjiHB7bS/ScNDQqHdE/sKOtDfe1EtuV?=
 =?us-ascii?Q?L4GiilMjEBqQDgX0GhCJwm0MKb7UWjh+I1Fi7VzApJPmtEPzmKO961Zqs1UZ?=
 =?us-ascii?Q?tcuTMtLp8jyIUhPYI69DyQH+wL5IczqnK2mhxA5QaPNgMnGCO2La+kXJPUYl?=
 =?us-ascii?Q?gypj8CzBxwFRSfApCIsG5VkHZRJiNIC725SewZBQ5aB2B+BQk4Swke6ClPw4?=
 =?us-ascii?Q?qysYghc+itSy70A6wVyH4/mihCNLT1OExpX+ghrtJV+Ix0rtvHDa1nUEE15O?=
 =?us-ascii?Q?nvf+FLG8HhA/pbi6PFuE7bqZ67kOlZrFxm8X/xZKd+/NEh61j4nUBQbOxYPh?=
 =?us-ascii?Q?9a04yG1HjIkSPcwdBJGjoPgyobPN3dvjquHb75RuGNRRbE+34IM5LjtvSoa7?=
 =?us-ascii?Q?CG7mwi/SyneaZqZW6c2oTK7qGrtoht8xx9fhe7vLVVmk4PR9EFkHAeJcHu+U?=
 =?us-ascii?Q?kKLX33zwmR/QTy6CI+pt0M2IDGEYQwX8KdGL1ULUjtpjIUrSlgNs/SjHS0m4?=
 =?us-ascii?Q?eQzDr1PoQy9d+KnbY+r0AAqrNAhrbSnJsidz6vS26ZpVdw7+Jrln1RSdTH9Z?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ajc+Gkbncg1WhBOV6WS5/UofCXQ19tI5gmp5bHcBAEwH+ROkNbi5/P1EZuAnTP5BW6iPUsVQFSsTu8XSAudtuII52RlTCe6l6sG/X9RGu76fkS7cLr58KDRDmZbu/HNnHcURGNCWsqhPMYscMLrxaR0aubqwySBuySMVE4ys/PVFJSyuq7b9zWsE6hbRwtYw7APDAmY4l0oIvwycU311IpGCJtga1n2GS78oyotTYfLYfNXzw4QGKMd9tTiGP6huo8VYtAkQdleAJaaWg6mY2wIrjo7THx4yKf+jM0dW1zXPVHwzbCQNw7UPmFKvkbqh3JpGKg9zZhVbeZyqR9MHM9XaKB/ZpRJ6UHNW5V8nTKyxJTQC2AVx+MWqJz4+XjRoUrZSJMl5OmvU0Yj0n7YMvGWv2CdhJ4Iy0hBdFMdrdP8idKvPykGn9CvXut+NP13mtJMJeQGWwfb11kBP0Bhtas/avvsir+p8P/xgSddlX5ywbBNJom0R1OUuy/423Ql+LHntmkKKMDIKcswAnPFdFNEjOZ5/S+TbCSF6Vlcfla0crnphNSmT2FZOMmYIG/pxPF+Ee2oWzEM1WdZDXTxx0E8aIYGcS+Kry+5LXFhlD84=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f721f8e-78c7-4227-bd8a-08dc1e93fe20
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 17:26:55.3340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FT/hQs6vyCryA67WB/WUoY/Kcxi+NoCChFXbaLum7XL5EA6fgqya51ed+55tAZEBjYYZM6VwZHPOx4zTCIgHcedyChcJR7eXwbgExtVUhuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260129
X-Proofpoint-ORIG-GUID: -HPXhWrkEiiLiz1rHycFQNl4V1_l8oLY
X-Proofpoint-GUID: -HPXhWrkEiiLiz1rHycFQNl4V1_l8oLY

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

Fixes: possible deadlock in rds_message_put
Reported-by: syzbot+f9db6ff27b9bfdcfeca0@syzkaller.appspotmail.com

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/recv.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/rds/recv.c b/net/rds/recv.c
index c71b923764fd..d5fb0a22a9a2 100644
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
 
+	if (to_drop) {
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


