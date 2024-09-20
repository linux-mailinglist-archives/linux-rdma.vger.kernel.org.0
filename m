Return-Path: <linux-rdma+bounces-5021-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D7C97D5B6
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 14:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113F4281C4A
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 12:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5071152E02;
	Fri, 20 Sep 2024 12:46:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8498B14EC46;
	Fri, 20 Sep 2024 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836383; cv=fail; b=KsY/IIn9j0UwF+bExv9M4avAnkNRER8CQ8q5QICqkDBT/JTcQ/cWvScHw/A1k9Vyan2otljkneWl9jQ9Up+qpf4jPTtbzbObliHwxykaJM3ZIi1h7BYhqtZzRRTobxlr3+uBtlJOjv0XbxWLIr+SSXuO/++/RUBhu32wav5aceM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836383; c=relaxed/simple;
	bh=uJ00Q9xQtz0KHM+LInlOd0GlkkabTXIsvKfe90eesPM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bAs0Hh8SsXISRnC+DBaLbEmO+vczCvqwE3+7T6t3M8WAKWb/zOqUZBY3BgxUbAsB3rIf8XIm88+tw2ZL366yu7CJV59w3QL/Q8VDdbke6iVMfAtTuGILwcNqlsITHIKTdOmpeF5ZAwVnAil43NvkT9g4wysv5PhF04dXGHF9qdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48K9U2ii028858;
	Fri, 20 Sep 2024 05:46:03 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41na0mph4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 05:46:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KV6bCCqcliOZPrXYQ12J3Q4LuQ3lxvGKYv0xHcdmLV1wnhKKR0yTbAkbeMWxj9h5wQoEgH7pTqe/QJRcH2b3Z9M+sPFASVa75DQUx7pxDdhYDmbz+HaEE2JWNfvM7bWl6T+0cQyvwxz7gV8xPsV5UTYWLMZS7sFx2dwSKN8n5nKr2tlD9XjbX/qud0KaFgh7sg9GxcXzCgrjdrnrqSxf/o1ECgDaaxt08lUNZFaicCiE6T5pN4MbS1n4SOaayZxHw5aFi9HT9ia2S9pWqy3q2pajkgKMlMblztsUhgbIX00Ahc4Jl6cfbOAXeaOk7MQIbX6+AXMoS3RmlQa/KoUHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkoDP6VdLGhZMLml/9dYG4N8NIaym5oUmKF/pjnBWUU=;
 b=n3w1EDdQ4HTqMzgXyQyio94MMRfPNEvnhYNcM3AzOzeJoTDQkteXs5rwIR0NHITWkuiD44CDyUOhP9RDF/3J4Kc6KcRfAgvejEBxmvIEuF43Aga1TQ6U9oHoq0kI3kvGthnmAqQXrsJjhpd98exwPCC8tGWyuk67Y4FKznZ7PVMt3sjtaSx97PvtJiOPAWvSX7WlNGSxWmOqqBWmwlwdJUMGM8MLQcxUlL6DXO04JY9+UYGyp5PmQFlQfgB0wTAFPRD+a8c1hfDblU/bO8CQCiEbSnMaG6/y3mOeq0ZutSNADeWVG8ugj5Y8BdBWAYLpWk3LMfBmhpvbimSim9YJcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13)
 by SA1PR11MB8524.namprd11.prod.outlook.com (2603:10b6:806:3a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 12:46:00 +0000
Received: from CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4]) by CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4%5]) with mapi id 15.20.7982.022; Fri, 20 Sep 2024
 12:46:00 +0000
From: haixiao.yan.cn@windriver.com
To: liangwenpeng@huawei.com
Cc: liweihang@huawei.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/hns: Fix UAF for cq async event
Date: Fri, 20 Sep 2024 20:45:40 +0800
Message-Id: <20240920124540.2392571-1-haixiao.yan.cn@windriver.com>
X-Mailer: git-send-email 2.35.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0045.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::14)
 To CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8189:EE_|SA1PR11MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a1d2511-eaef-4460-0909-08dcd9722df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CCQ3SBVB8/5OGoG/5V5IKL0/L8Ww9DMuIwEtTT8g3+oxLGhbp/FDqB6K/Qqp?=
 =?us-ascii?Q?kDra7mVtmA0jUfjVHFbPfQVTCQ4rWkTMkhCuxXZwySAxjOEPX5FV19UV+kvW?=
 =?us-ascii?Q?s3JRHlvX8FbdDAT46j7Sg6gSWbOQl+hA96o//g6l+Lefv4udxgIM6Psz0oDI?=
 =?us-ascii?Q?EP28pf/9580uJ4FQHUY+qHcpj4WNqVExL88d7BbdqzjoilQegoTOcXgVUsMS?=
 =?us-ascii?Q?uqmSaaL7IiQBRiw+Ew9/pb/UXEQBLJjalNDQaIQLaquMcxLerVElDM+1X3TS?=
 =?us-ascii?Q?p5gG8dMgFGAGGhoU5E99T23hGHGPORgqdIR8seAxVM3d/mIfZQdEeWLR79Eu?=
 =?us-ascii?Q?bzR0evtACZ+rlBPAYOAw5IrawFkZ9yD2oE8YDPilwA0yZjNNxgHfFbXwScZE?=
 =?us-ascii?Q?3vSUJZ4qYA8x3X/IdVBBuL3IVe8IZU3mUMT2BkM9iPKnsSB3kpYUhYfkOz0w?=
 =?us-ascii?Q?+4r5lU/kNJhPopSLQoAZdN+it6Y/ARNTZAOV0Yq6YpONTwBna74F+9VwcQYh?=
 =?us-ascii?Q?TPePuPnzXktlO6/mbJlisRE2dZ6VXopyxocu9EGNU+TpKC5+oH3HhbZcalDK?=
 =?us-ascii?Q?CG4yZMJ6R4r6DTtntAUM1cEw+is6lRWamb301BjlWmRSuriDu5LQ8p7ZQYzh?=
 =?us-ascii?Q?+P2Pl3Ztnj4nDbWG6dNBCBkQHz0QsLBo6t1EOVMks0z5L0rirrH+qK/AeiMB?=
 =?us-ascii?Q?PmHVxcYJBxsKl3AUPDlqbdlSrAQsuEeLMqucpDr75pNX6DbtVyMTPWKuLKl6?=
 =?us-ascii?Q?zHqcXjHTUHi3W9MIqZuNdnldqtZKIU7z2TlDOByrSPv/1b4MJjbyrxHD1YMu?=
 =?us-ascii?Q?eR8wUNIwcUzQVENf+3Izuv7UiAblfdBfaQ+xfkgFG3QBWSDg5jxYcC0CHf9F?=
 =?us-ascii?Q?mdv9bSUO1dEZyOwGAlun2H2pCKhEpJwJXhdzyvxzUrhSZALGKonUB+DZqiya?=
 =?us-ascii?Q?IkA1DXipPRbNixb9NTjHDafVBn/KzpJYwttPRXlA3+HWI3iU627AmZcSJ5K3?=
 =?us-ascii?Q?OFvqMhnPzHmMzIGIZX8eitPbU2bM7HdYKGhQI1g7ofl1DSuSpvlROGS21vM6?=
 =?us-ascii?Q?S2ZxyoHQ5nKDpckN4BOvdQqZ4RnI675TYYzxjr2oYAeUuZM679sMMsyfxpAz?=
 =?us-ascii?Q?fzO+6axyWRt6L8ATPRP7Kl3z1PhxpuORqZFC9s2gz9gqI+Ix99KtuKjfH3/S?=
 =?us-ascii?Q?eLcE6uqXNxIyxY2EMdZhwKzQmoUZBsIoBGKIFBCmebulUOyNQyZYNjmbnQOs?=
 =?us-ascii?Q?t3SYWhVb2NRo86/LkxspFFphlYxb0emKqtXF75D2hzr8HPTg0ij8c13YbMP5?=
 =?us-ascii?Q?YOTmmDN32KL/LcU/b3RvgjWp75a3SAvlAHVB3th71eR4SlfECoK+gfilq+ab?=
 =?us-ascii?Q?pQ7jee3QAt6Cl8Yz9ESWhy2rkM2+GFJjTl4szF0kH597+nRWkw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8189.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?59HebexcBluTpK9J66TlN2HRnjI4zIzlCj6A6jzOWREEmwTVyNo/wFvcioYq?=
 =?us-ascii?Q?eragmFBETKvQJRDnD498gKLJxOc0A/wyhSQ00R3968YUOcc6J6egaWBjpIpE?=
 =?us-ascii?Q?HLrR2lSxVu92dAVngIu6fYCCfxQEkDeCP8feln5wdr0BmeKuhmvWroH8CH6x?=
 =?us-ascii?Q?HPr4wu1mwJPNkO0AoPwibsZ4XLVOLyaFEeRh+qL4r2PXJe/B2kh4tYnT1Qxc?=
 =?us-ascii?Q?Kd5xbDXoDgIKtYDQy6bo7Csmwix5LUxNwfl4tutNufoX90Ayi+lSbo1C/EIq?=
 =?us-ascii?Q?M/9c02Gn/AC+6mP02BbLnUr/8Lf11oqV7p4ZNxGfRJ14qpA7nre7L6nf3qXO?=
 =?us-ascii?Q?eBqW/q0ZNvN2O79ppOcgayk7PBx9BXFuBQELbTSHM0j2fAXdeLDuN6NOvzUz?=
 =?us-ascii?Q?gWlGzyU+ojOcXA0F0wNlNsJX7/gyLY/rK/peSnLWb7KBtdv73RyoYaThlVCc?=
 =?us-ascii?Q?OCq+4dab/uMUa26Ed5ohmomM82vrXTrAfl1n6WnIGW15Wlf3oPcsVOOgOSoN?=
 =?us-ascii?Q?0H4f+BKwffz2ho/0tK2EPAhrVw7AjmDfHI0RkeAZEjE47YBmsy5IH3c344at?=
 =?us-ascii?Q?SI30axsmT13OT4SoAIL2PoVw6lzRt0EJ7jY3MELn7b/ssACnPiHq7Biq501s?=
 =?us-ascii?Q?G+i3n+V6zJSvLshklum9t5zfIkqw8QwWmJ0fdDPFjj7cuQ1ZLFaPcqeX721F?=
 =?us-ascii?Q?E/3xH3MZwD7KsaSYqnDaoS5Q7n1dcrV0/yx44IccrjY9nRT6IhLi985uEPuf?=
 =?us-ascii?Q?ZW9dEyXnoBVuDmC3goxMAfdtCgc4kzLHLCYYApRIm/12FvNX88ORtGPhV8sN?=
 =?us-ascii?Q?FY1quH9BygiyEpH9g5f2RhcqVxHAiqgeUHBHF5LtavppOOt5ZbdAfWXZDph9?=
 =?us-ascii?Q?y1sp7LwxIAI1Wno74Kr1tb3ldYGJtGNuqsDWbJw0HlLeWC9IDsLVrSfP1ACO?=
 =?us-ascii?Q?wk7lPcWJ4XQ/s+X/B5mZkDqWOmygq7Y1qfbq3S5Xdvdt+AuFS5tPx5Ju/Q1I?=
 =?us-ascii?Q?wsLYhhCaE7TU3GnMaN6fnE3+Ldzj2/iLldNyg6k7cQ1FzwiqcTG03rdGwGzP?=
 =?us-ascii?Q?njlMVCo6qUtfvDcngZObTFG/bVWpDFcQfRnUAt8L4zNgyhDWjiC30TyCQBuA?=
 =?us-ascii?Q?S9E0lGlzxXkBAnoSJAh7Y1wE2248rp+SgQBhpbBDO69L2gTjvR5LtGZdwoYG?=
 =?us-ascii?Q?Gy5Qwtycc1H0FwNp7XmUc09UjUXYCkOuqf/cGOPaxcbZ+r7uAu8e1GcrXkEn?=
 =?us-ascii?Q?CTFz06ZXeO9A2oqvGKZ4LuW5CkLif+k6QgO+PI0GxOEc2DB7+eoC/zmsfUjM?=
 =?us-ascii?Q?/qn1zAXTW8osdHt9w+f8rCZOFRqqAfLTRhDC9LOiSKcLEuqn59KMAJFEDpDa?=
 =?us-ascii?Q?+6cJAffk5EG4pWX4r5dVCQ0Fn6ge8MLILQ0eOqzElDYWHYnXcjYO/WgZfUyN?=
 =?us-ascii?Q?a1gY1pSSJR8f3iHTKC50JpbIPzhWv6oLoqeVQlxhApQGPiqTgXd/IYyG4pW2?=
 =?us-ascii?Q?Uv+KlJBOFOo7hYV85ZHs5+jT1DT2/4OvC3JuHYmNQivixxl2pkN+qK7K1zy8?=
 =?us-ascii?Q?H4cYK5ZFbsUWdHDJ1RUkHelPBfre6J/TQRT56BtqEN2Z43oBQytyR2ManMFK?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1d2511-eaef-4460-0909-08dcd9722df4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8189.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 12:46:00.1954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFFa8q6A74utt4nuX5qD1x6aM58bbrm43DgrIljO3liDrUpFVBNTlj2Tlwa7hImdXmnCrBOIXiDv227t0dfQOABY0T+gavgvp/IRt90CItw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8524
X-Proofpoint-ORIG-GUID: CamTQ-QXvWeDTaUi5JLHRlVpZojEo643
X-Authority-Analysis: v=2.4 cv=d6+nygjE c=1 sm=1 tr=0 ts=66ed6e8b cx=c_pps a=oYCWE2dcp7hbP1SgTdEJ+A==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=EaEq8P2WXUwA:10 a=bRTqI5nwn0kA:10 a=i0EeH86SAAAA:8 a=BTeA3XvPAAAA:8 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=inzseO1IMo6gxlbjCuoA:9 a=tafbbOV3vt1XuEhzTjGK:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: CamTQ-QXvWeDTaUi5JLHRlVpZojEo643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_06,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=844 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.21.0-2408220000
 definitions=main-2409200092

From: Chengchang Tang <tangchengchang@huawei.com>

[ Upstream commit a942ec2745ca864cd8512142100e4027dc306a42 ]

The refcount of CQ is not protected by locks. When CQ asynchronous
events and CQ destruction are concurrent, CQ may have been released,
which will cause UAF.

Use the xa_lock() to protect the CQ refcount.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://lore.kernel.org/r/20240412091616.370789-6-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
---
This commit is backporting a942ec2745ca to the branch linux-5.15.y to
solve the CVE-2024-38545. Please merge this commit to linux-5.15.y.

 drivers/infiniband/hw/hns/hns_roce_cq.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index d763f097599f..5ecd4075de93 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -125,7 +125,7 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 		goto err_out;
 	}
 
-	ret = xa_err(xa_store(&cq_table->array, hr_cq->cqn, hr_cq, GFP_KERNEL));
+	ret = xa_err(xa_store_irq(&cq_table->array, hr_cq->cqn, hr_cq, GFP_KERNEL));
 	if (ret) {
 		ibdev_err(ibdev, "failed to xa_store CQ, ret = %d.\n", ret);
 		goto err_put;
@@ -160,8 +160,7 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	return 0;
 
 err_xa:
-	xa_erase(&cq_table->array, hr_cq->cqn);
-
+	xa_erase_irq(&cq_table->array, hr_cq->cqn);
 err_put:
 	hns_roce_table_put(hr_dev, &cq_table->table, hr_cq->cqn);
 
@@ -182,7 +181,7 @@ static void free_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 		dev_err(dev, "DESTROY_CQ failed (%d) for CQN %06lx\n", ret,
 			hr_cq->cqn);
 
-	xa_erase(&cq_table->array, hr_cq->cqn);
+	xa_erase_irq(&cq_table->array, hr_cq->cqn);
 
 	/* Waiting interrupt process procedure carried out */
 	synchronize_irq(hr_dev->eq_table.eq[hr_cq->vector].irq);
@@ -478,13 +477,6 @@ void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type)
 	struct ib_event event;
 	struct ib_cq *ibcq;
 
-	hr_cq = xa_load(&hr_dev->cq_table.array,
-			cqn & (hr_dev->caps.num_cqs - 1));
-	if (!hr_cq) {
-		dev_warn(dev, "Async event for bogus CQ 0x%06x\n", cqn);
-		return;
-	}
-
 	if (event_type != HNS_ROCE_EVENT_TYPE_CQ_ID_INVALID &&
 	    event_type != HNS_ROCE_EVENT_TYPE_CQ_ACCESS_ERROR &&
 	    event_type != HNS_ROCE_EVENT_TYPE_CQ_OVERFLOW) {
@@ -493,7 +485,16 @@ void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type)
 		return;
 	}
 
-	refcount_inc(&hr_cq->refcount);
+	xa_lock(&hr_dev->cq_table.array);
+	hr_cq = xa_load(&hr_dev->cq_table.array,
+			cqn & (hr_dev->caps.num_cqs - 1));
+	if (hr_cq)
+		refcount_inc(&hr_cq->refcount);
+	xa_unlock(&hr_dev->cq_table.array);
+	if (!hr_cq) {
+		dev_warn(dev, "async event for bogus CQ 0x%06x\n", cqn);
+		return;
+	}
 
 	ibcq = &hr_cq->ib_cq;
 	if (ibcq->event_handler) {
-- 
2.34.1


