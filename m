Return-Path: <linux-rdma+bounces-914-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E0884A572
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Feb 2024 21:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EDDF2860E6
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Feb 2024 20:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED54179A2C;
	Mon,  5 Feb 2024 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZVaPlsOz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aFCjDgW/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0781176CBF;
	Mon,  5 Feb 2024 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159854; cv=fail; b=n+ral3Y/jcLycEzwujTi1Hb8TYHbotrziSU8Ymkhg4j5UfcjuneYMdjbP7CmRc3k98NrkzIx50EzlrdzABmVz+DqcYyuCONJLQ6cnZmgKmpuzVjrYZX1go22yNzKNfFbvz3lvUzUV/nFNWnFx8qlsk/h1RZedEpegND7EEjYUlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159854; c=relaxed/simple;
	bh=55Tfyeyi8vKq2CS5rPY2nZJ4Ykpea/AcWwbvO3E4j9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QX4OiBk4daZfMsMRIqryEzHmmgbApHu/jxJmpTyXOAwMBm87sizdJMLFWGPv0DX+OZn0ELfm85HvZmZem9Qr1bs7TNUu9I5hPFZPjjcqcB0kIUSEsBNk2yoIiDkZnUiJYgcjrqOQAJaZt/wKNwwVPli3Ccii1Tc5WW/lP6WiRT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZVaPlsOz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aFCjDgW/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415J43ab010898;
	Mon, 5 Feb 2024 19:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=MKcBPgjaQfbTZQWeId8WkzMl0XMEgqLkenhprcWiCnc=;
 b=ZVaPlsOzNk8T2/jt+Jb+6tDUT6onmPwwH9BPL/Na3+bdaavhHSfvcIbNM6d+f0jXDSrd
 NEVSeGBhkhmu9TrZYwxyGLo/OyeYr71+etEkIVdNIhMSrDBVBE1cOuPWxH9IrFre9RSi
 MgtfKH8RINvQeVIvg+sU+wciLZ4+ZFCkrjtHzSGrCXuT9sVoOdPTWVBJyZ0aeoikecXN
 iU8HFi8blK8wH3Aqhj8hSDIC5HO/xsscMvR57mOZ3M80jG5oD8L3btycpbzaaFWlPd6L
 5ipZlxwo+0XYwPxcOgBvnF0hlYgeeXaqsRw4ehasbxSM68bfutPfIynH91eGL7u43zQG Kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dhdcv6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 19:04:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 415IklO0036822;
	Mon, 5 Feb 2024 19:03:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx6651c-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 19:03:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZL80GkJBadyg85lrzvRww7wDZ7xKDR7/cYu5K3d4uSZnTAC5Z4G+94A9J+WjfVzVyHrPwJFDN47T09NtMLvZVJejb20ZPK204uHsUni8cwaaf5YyWPRbaY6aBvHL/in+w44jRmvtuS26tbx/sfEhu5gYAR58JqnOORyN64+6waY4uC2nBZMv+kqVajL9UWbpyhbSDgFCEDb4QrExqR8zuxIPzcF4Uji7RWlIaStqIA9IRRPkxewYEy5+rpNpQbYvJQksvZkfDQWWsvvi0o2k5sp5zDR8cya12BMbO3lDxi3OV4N9ZDKesOmNggRI/dieyWkjmwlEpA0KddP/6ecfMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKcBPgjaQfbTZQWeId8WkzMl0XMEgqLkenhprcWiCnc=;
 b=WrYX01wFjRwzNjijSWtsrty5BikPT0BW5GgTnJHOTXeDlzuOknfaHvPC3H8nW1XVH6eSm9XnxRgpiexXmhjzIq8+po8gkxEQSbyQR3LywnzJy/i3JTbhDdOhTBxwYpudaj5TSlUEjstk+Oe73EZxJyIfq9TAj3YfqmWluCMa8Kea/d4jLRpHjpAcsZpGnqJB6Ba5/0QRWxexYsKRzFlbYzy5dZdAzvCqiDksVtmFxlWydH/Xus+5/CnjlX5Gc087e6sbqsjH+SHWdWo7dWSL5WU73NE9u9lZfFXGEfAGefEgIGrjj1bf4phSahxNwY65CUFf88Zh0sh0phvPbjkrsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKcBPgjaQfbTZQWeId8WkzMl0XMEgqLkenhprcWiCnc=;
 b=aFCjDgW/wHIXwyf1Yh2bUkvX7QCK8UARDEJkzB450I3sxjv3cSCmPsPnmZhWYQqE7XhHrpIswvuEBu/OBRnlyO1xawhlNRbxg9E2cVthWV3gShLm9ywG1ekp0+xnU/Tez09OJ/ZRbfzOiW/17aqkqEIzJaRZ1aoKYbrZmJ6nmbA=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by IA1PR10MB7215.namprd10.prod.outlook.com (2603:10b6:208:3f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 19:03:51 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::68a8:709b:34ed:2aeb]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::68a8:709b:34ed:2aeb%5]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 19:03:51 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Cc: rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, pabeni@redhat.com,
        kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
        santosh.shilimkar@oracle.com
Subject: [PATCH 1/1] MAINTAINERS: Maintainer change for rds
Date: Mon,  5 Feb 2024 12:03:43 -0700
Message-Id: <20240205190343.112436-1-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::31) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|IA1PR10MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: bc64e979-c5b6-451d-7b0d-08dc267d309a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0cMJv5s5/gO4M4tF7FepTUJ9OrgUFvf3W2/G9b9+2cMAQlSGqmNqpaptbRiBl2brSWr1+3My5IAOSEx7Lq7PO45DX3tjlNW/iHlRH6kk3xKD/ElKJmNgbj8IUUswlGLa1QVRqpk/bpEkLy46OH1hSfbcPTiqRLa/xCa0pZ2gCHJ3ZQeaMvR2yu7Bmc1/b8z75cbK+5GkJOphR+gqjc+O2/HIvkGRQepWX6YCTn7aPIModIhJnbmr393RYx+WJyhgABWKyJcr2W+7du7B1KX5/fURCvo4/KpOp03LFb6BErsFa6WJIGPa4HUcYEHAJowGOeLoIxTamBSQ3Fzf6qTT0l1ksvYMjkEI5zmzJqHor8f4PTaBtH6bqky7S2rbRTcNNzWBqvB7IF8nynESxa+ffUNOVbMy5YjLF2XDWLThUWb5tW3VtRm6JCDb3SWVmrwuQkTQzQ3pFKHnLNOW3VcslH0Vy+aFr5uNwlJ9EdsVae/5P3+nHE/9b61RdaXDvWZIrhOxD6sCdaXQo262UNHiJhd29wjMgpfLKw92QAoQSTKTT+wi3j1+WvQ7egKlE55c
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(396003)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(26005)(8936002)(8676002)(4326008)(4744005)(2906002)(5660300002)(9686003)(6486002)(36756003)(478600001)(6666004)(6512007)(6506007)(66946007)(66556008)(66476007)(107886003)(2616005)(6916009)(316002)(1076003)(83380400001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fLeLWXNPyNrmcfP9I6r0xkFfSuVPRW2j07vq5W/z6OQEOrcBfGscKCOAV/us?=
 =?us-ascii?Q?BfrMCnSYi1NBdxZ+gqfG8SP04ewuwk2Du1WHa16VqgfqLEGWMTJYs3uSqCMT?=
 =?us-ascii?Q?wzJOma27a/OzG/geGgCU4U7NpysWKkAXD4sqMv6kZgO/ECMVEMn2q5IuvdvT?=
 =?us-ascii?Q?Vzrd1bVr9rxixXssf62fXo8R18cDh5gxGZpRoWuRkhwHsLRrR7OuLfW+qy+w?=
 =?us-ascii?Q?8PqHKeTuGG8jpoAD09slZAQ3y5DSCOlL8b2N5KlOXYwWY8nS869VDg4LgLgw?=
 =?us-ascii?Q?AO1wA/wsWIoFMvBcOx1ySbt36nEMDrz+xPBKcU7hb22rG7nEkr5C9D9YIJSW?=
 =?us-ascii?Q?uD927ne00m57jL/Ce9+cjfyV6cB4igbYuVQlYsoT2sZyICedWgaYnVGgwRi8?=
 =?us-ascii?Q?b4df1ecgkDgxc122UaSW/yCIaWr2nq1/Ey3FehPt8WswvNH2trHeNhWH9Pdl?=
 =?us-ascii?Q?zyslCsjFU2x6RH7NybZRPYc8O1PXG4N0LBtV/pMYxcRDw7DNAUjYM/yQm41t?=
 =?us-ascii?Q?6qGXp2IGdB/7amGHBx+uE9BOLx6Fkeof9TNi+L+epK5ab+f19rgTCPjjxuUE?=
 =?us-ascii?Q?F3e9pT8WqLVg8K+TXkv/QFzut55hti9OxKKVazQSOIA9O6eHoJfG54QVafdu?=
 =?us-ascii?Q?3zZrPHJ8spGFWhAvGeJctjFgQGk5pQM+Z52KDo0faYhkZCtfbHUaOko246Gb?=
 =?us-ascii?Q?c51JXM86gH/6PAd64MTOLkbigwugTJwoYKtBQMzRWDRIIeiEA47gDhJbqGbP?=
 =?us-ascii?Q?slXiloayB3706jT9Tk3mb/Ai1skiX+x6ziCvgZJXx4p96czAPUdxa+/Ee9nh?=
 =?us-ascii?Q?Y2m7YDK7a3X19rCtwI3mDNX8MrWymnDFmMMJ7JZH2FbhvdHK7yhuQkAqohZz?=
 =?us-ascii?Q?dAdqRaynrY1wg40ujpnUxK/l6o9vv9Bg0DT231R7c2rfpGGrFzJnTQI6G++5?=
 =?us-ascii?Q?sehWnqvx+Z0//QPcYfwMX9itmq1VdS2pav7lY4sGdU7PlHt5OtmRhyBlVRwY?=
 =?us-ascii?Q?k9XahEfMWyWDGu3VTT7yAIKLwUYrMoHf+V+c3/QO5kqGoE6Ztg7vbsyJ0lJA?=
 =?us-ascii?Q?XVQrg1GSrZypen3CRK1hlzMDAqvdl3/ZO3a15aoYvZSfEHQyLyHcUb/JYOQt?=
 =?us-ascii?Q?OL26wEXTgIVkPAXFErcJl42e2Y4kkWISiuMEYiYMO/9haDebRzvudF8zOrx+?=
 =?us-ascii?Q?Ml4rC8EFCA2z2dQT4GWncom+jK1OU65vz/E0qjdKfhqyeYXXr+3QlaD88Xip?=
 =?us-ascii?Q?UDatbMN+8RKZw1KqzLN8+1GlKl9r46cUU8PWG7H/qHM6OGGEvRUzjsLZQk+/?=
 =?us-ascii?Q?00vbjgo+qANA9zA8DqNX9k5hhBZ611EgT0J2tkrIOWtE/v+IlP3QGql1hTfi?=
 =?us-ascii?Q?jrn+iBlT1h1UYf4/4M57CVUFNo94dB7Xw/QwHBWKktVLBQXGLlMvDP85kDbr?=
 =?us-ascii?Q?/Gfnr7HqvgsjwVABLYPRisVEP5SuAoxkeFykMa5aUB1lvrje7BQ6XpCWdwr4?=
 =?us-ascii?Q?uRinruH/exRIjD8V8ee+QjybgArS8Pt+VpviWs9LIVM/8H9P9OmzNt4dBQOm?=
 =?us-ascii?Q?hz89BcjkkK3jrO73TrkOCtQgZPPhHqw/bA0IwKf6H5blFtbzZTBN1GLV3wNn?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yOw4wJHIz40LYGp8Or+6aFKHUdjdB61UNmta9LPW2pPjC1ZtG/9rFA4W2TqGCSFZ9IOcpwpT3OIth5AUnQs5yMNg0htfpqCYp9C5T10FABVWWuLO3c5NC8Rvq3avp7DY4g/XaaI3CnbnuP5wwYeXYMAAKUJQoDgQ27fXT5HZsDUnntLD56o4Hh9EsPXqy3duFKGsDAdiS9Z+PHm7hIWG8k/X8+FqVRNG8v6Ucs5N6LFQPHjQ392fwO7EDDEVixCcdzuW14rPx6zd+li17iYld0Wjzb9SmWDs5q3+uKqHZf5CLrdE7iwAt9nfAu7QOEifcCr2fiyqEED8DiPXxEYICZ7RhYm6jVKNnCDdJyKQO0Q2fFH/PPb3W+w4YrJuJKimJPvaNZsf/7EgZouC3fzgYP/qftfUW9klXcRiVO4L9YQJGrXF1I/87v8f+fGpwzLDO8EQ1yi/i0J7AZT3fWgxPSnhgP5n7eTvsXUOKN/NqwYGw2GJOuVJAqg797dluC9sTs+a2hoAzvPD8vHktMMgptXY1kU/lIT13GUtbccKj1HDRKGekNS3hv0ILcpY026iwPJrMBEowhZnmaKwt58Rb4mw2fX7jpM/FpoAEyBTksA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc64e979-c5b6-451d-7b0d-08dc267d309a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 19:03:50.9354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaJk6KQSWTFZKIIL/jQgSBK4tL6XZ1GYG3CotTLDSVWU/GHKF+e30eirOHTmAWX2YZ1x6x0CiaDwITHihjt6EpxWX0zvPk0t4IuPKof6Vaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7215
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_13,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050141
X-Proofpoint-GUID: 162OfSOtm3qv_Dl-wvrX9-gihu5AApzd
X-Proofpoint-ORIG-GUID: 162OfSOtm3qv_Dl-wvrX9-gihu5AApzd

From: Allison Henderson <allison.henderson@oracle.com>

At this point, Santosh has moved onto other things and I am happy
to take over the role of rds maintainer. Update the MAINTAINERS
accordingly.

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f465fd778b1..718ab5f7f25f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18444,7 +18444,7 @@ S:	Supported
 F:	drivers/infiniband/sw/rdmavt
 
 RDS - RELIABLE DATAGRAM SOCKETS
-M:	Santosh Shilimkar <santosh.shilimkar@oracle.com>
+M:	Allison Henderson <allison.henderson@oracle.com>
 L:	netdev@vger.kernel.org
 L:	linux-rdma@vger.kernel.org
 L:	rds-devel@oss.oracle.com (moderated for non-subscribers)
-- 
2.34.1


