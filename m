Return-Path: <linux-rdma+bounces-5379-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1131099A132
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2024 12:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE73282051
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2024 10:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C066D210C10;
	Fri, 11 Oct 2024 10:22:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96AD210C0C;
	Fri, 11 Oct 2024 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642177; cv=fail; b=lWIOiyvk4ilf8Zz4NezLLLh3rGB0YahzOOux/pVQdP+mDdZwW4HysqUJ7R4cZVcAh1jNljaEhO9ym6pIA9akvb8pFUz0VyQ2Z/dM6vsiJFhPlAtNPBMr45qQ0INSobKlU7cDXMc7P6pPAl4mB1xzxMUMT/Q/8thwizrvW2mV+lM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642177; c=relaxed/simple;
	bh=uJ00Q9xQtz0KHM+LInlOd0GlkkabTXIsvKfe90eesPM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CyOCpxzYY6ixUYL3pDTDZOjKYwIrX7RPulPUNJrXj9vymsmUkZHsZZ31P5Cvi2BjpVPQYA8K0yXCgBDO2u4MRcZuiGuf4K5vwT+kuE5OcCAL+nixXAiD3jTgMAD/fAb5zJkNDoCQQ5pdEa+dfY6a5EYqy+ACnLtte/Ds50nsPZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49B53U27002186;
	Fri, 11 Oct 2024 10:22:34 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 426sffgctw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 10:22:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Au38vkoD3oJV2W7FRVank+u8b8CZhMQs3N6G5dyNQWcYAuCaEB8sEK2EkVM8dY2v6qMq4V81wdDy9U6i0E872E3x4FwtVDZtLAszTWFCMr9gmKTsV1V0Y5Wv3iDhG3Leg4bQ7UfvswtXxmtKpNh1UIXSoPUQziMtCAbiARpTtQ3J2LB4zjzi9Wvrn63fjamIm7QAqSUQ22jqSqvnEDHTcPogONatTykrZ0ptpoDEoPtPVGPSKqJMKkrrPwipT+r83bO/IuYw4QFuYV8uvgyyUlHDsQNeBCroE0YNFb5o8LMZupRAR2RTL7oxLVxCujgfAMsXocrLqcxKNo7mXEbrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkoDP6VdLGhZMLml/9dYG4N8NIaym5oUmKF/pjnBWUU=;
 b=us1h0PeEtzaVKzjMa5q/PgFlhL2/Clxn9WfvBoqJE04cSlL70kg6NBLCOkT6UylfRuYp1AYPNlkj0jP/tjGFCPy2yQiyAUZs5FetccxSugi0T5FL7XjvmPKgLWjxfT2SJMVN3FLx3/gtWy6qXGa/P5nybSdjSLOBQDFm7lL4FljbgZjasgqkjbKKEL9F3NhwL9hTl1GmJBj43+3CV0+Tohg8DFGyqjUGHZ18UBCAoUBu4s0vqx3Z5V8cTffRj3y30Zt82d+hn2i6w22bXT4JCCWhSBubvgTIz2Fwz/RPmn7FrAZ575iSY8rn+aGTtMaVF0xwiDXy7KQOHXfhMMwBSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13)
 by CH3PR11MB8137.namprd11.prod.outlook.com (2603:10b6:610:15c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 10:22:32 +0000
Received: from CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4]) by CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4%4]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 10:22:32 +0000
From: haixiao.yan.cn@windriver.com
To: liangwenpeng@huawei.com
Cc: liweihang@huawei.com, tangchengchang@huawei.com, dledford@redhat.com,
        jgg@ziepe.ca, gregkh@linuxfoundation.org, linux-rdma@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 5.15.y] RDMA/hns: Fix UAF for cq async event
Date: Fri, 11 Oct 2024 18:22:15 +0800
Message-Id: <20241011102215.1173180-1-haixiao.yan.cn@windriver.com>
X-Mailer: git-send-email 2.35.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0232.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::18) To CH0PR11MB8189.namprd11.prod.outlook.com
 (2603:10b6:610:18d::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8189:EE_|CH3PR11MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e86949-f610-46f6-85b1-08dce9de9e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1aNAKkrGpnTmcfHO7EE5isAf1+VdJg43f68BgTuZq4LD9JDuiHC5tyMRMuTP?=
 =?us-ascii?Q?ac5VM6XZXV/D2rcWZ44SxLLahqz5zJxVIwnLNq+jcP9WHGo5dScda0vQbuNY?=
 =?us-ascii?Q?UsKDZHWOJ4tnQKcadeKCUHm4u8b7+VddQJhDtAHwJgqlkIpe/kL9EME1WUfD?=
 =?us-ascii?Q?0HAIbsN93nDWLnuBGNPU1yiUaGtgYl2MsYiaRXMWZVXEmxESr90Ela65BwYE?=
 =?us-ascii?Q?kGetXCI/P0i9x1HB0ouot98tUsA5fKB/i+cDi7nlfNSL3KSwOnZK8lFMq9qN?=
 =?us-ascii?Q?cd4N94kPlRhssb2BY798RG97x40nzEjPl07npn5i50+JcUX64pIROQH2IWKQ?=
 =?us-ascii?Q?0etapymS4NbfUYAfHoiCrdTO4UinPjQDhV3+Q14VedPGlJVcuuHD98Iq7f7n?=
 =?us-ascii?Q?+3esD9rKW13HAkQrJZFMS+VQ7fw4vCjn/SwuxdRxZpekSNmqOT5HA9NVrb8p?=
 =?us-ascii?Q?5DOQezA3ectPxGUk3ogOaJzqdKJPLO8ZLbWnoaKtpILhtfrJqnKMzZQfALG6?=
 =?us-ascii?Q?U+ZziZWtEXpfCOf97bsECnGv3fpKsTvd4HM/vh/MEWXhuiaNstsEHa6/6FaL?=
 =?us-ascii?Q?qbIGDbh9B5sDrntqnCgfSl2TcAQ2q8oKavcCBRgZ+vtaHfaRanxnROWLpm4X?=
 =?us-ascii?Q?1CGfc3SbCoquRldIXfvdYlgFl0W/VlgxIU3+yblQTFT0qC+vI60KidUhUGCv?=
 =?us-ascii?Q?nN1qEN8lTvRXtg5c+or7s5bvMRfbnJM2htNGy1nNXWY8am4FhWIgr/FfebVt?=
 =?us-ascii?Q?MY4A5NA4f5QgLLLRGVgW9U6ltQc+ZlV0Ca7hN2dsDrsSEQSPo6gt+ptFcwQV?=
 =?us-ascii?Q?hBwraCyTY3zjWWJtbnLFXRBU9iW8N69nYl0BdYbWcRGXlt0yvx2/ZaArwymp?=
 =?us-ascii?Q?ZKsWVXlLGqdAFH4mIvmkkkgRs4xxlukw4ZEDRSpB/wE96HmS+JhVOfZvaj6s?=
 =?us-ascii?Q?aj/Bv4itWp0U14F+DAFi9xKmvksWttgLyzBVisLbuCo5WLzoEZ18z+wPQK5J?=
 =?us-ascii?Q?3oGz4FG2xQLj1Hk4cBc8Y0J4QqwK9UBDArIrTLgGI1RgtwoAORILygTnQdUo?=
 =?us-ascii?Q?c7EBjbuKEUn/MyADoEiKlCK6qb8+QP0O4+HM2p2Yo2qnxC44CDaEv+0Hehla?=
 =?us-ascii?Q?kqlmAvYlVL0RVZji1KhJlWrRWGqMhBkXAMNw3+HF4W+/PyCAqGahYTSx9Lxk?=
 =?us-ascii?Q?oXoxIGZunGcQdjeUoxWIHrBlh2aU6qReqxe/e1hXeOVd4xeo24ElH/NdC1hX?=
 =?us-ascii?Q?+lObS0iMw4xXkfnwZ4YQeHqHe5tkD0lahwgYuPveNCfcUHXPFj+xMARMCNkg?=
 =?us-ascii?Q?W5XfoXvsE1hbeYkzzbYgmVbgybcU8Jjees5+oQus8uwUDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8189.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NN0oxyXR23vhf1J7uer6P06A5j4zAX0sZYHCfr/vmxRElVh5PcHfGhjBaurb?=
 =?us-ascii?Q?QIdXwJSQ8NhwMYP/EAod/wyrAcqgAwt8ZNdgJXWbybeXdvgqiKKvPHknqOZw?=
 =?us-ascii?Q?QE5nhZxt8LVLRSLrSrtQi2aMoe/QELV51ugrAe9fxOJ3q3pyELt5Y7+vzn9f?=
 =?us-ascii?Q?cOg/jiGULlkFFHljbEGWE9lhkfnWJ9v+bXBoDIAZcE2vaDznuh9BCl38dh3u?=
 =?us-ascii?Q?XlnfbFuV4N47NBxve1nr3Sr0xUNXGujZytOXof47N0hFqloOg/DYHR0NeYYX?=
 =?us-ascii?Q?UaK5aXl5/l1w515qqBH13p2uvyt3IRXq3sRdQxENKFamJIgYYgTCK6EGuY8X?=
 =?us-ascii?Q?tsKix0LFvkCkqXIolzutT8aumq31Gdn3OOiXFyU6gvaQIG77ZjwH14iKDgRW?=
 =?us-ascii?Q?u4+eyOBdB/5vT6MHwc7q2qC9wQXOnQTwW+UlecaB9aE1gq71vU+xs7xpCnyR?=
 =?us-ascii?Q?0cB9Ve6qNgxSMmDSk979MywlgLjygH+nIswW76X+rVmepEwnMK6h4Ipl9HJm?=
 =?us-ascii?Q?yAaQ0UjT25Pcu4ChZdiEcKme1DM8nrQkXhoMPVlP9HwTXulf5UoDtchjsSGA?=
 =?us-ascii?Q?nyVLKEBmqVaaMYUQlQRT6WQG5AMaHSASBztkX2BVDM+f/LrDSUqP2M9VIK8N?=
 =?us-ascii?Q?46vLOHSNNjhB5IxSUP8gATl/sAvRsRqw5tsfyAiyxviLNi6cLBpdJwiU/FSk?=
 =?us-ascii?Q?d/QMFuBAv4QHI17avfQZ/+ZaAbJmkJmvLq3h7yow6ZyI1bZ5mY1KiHLoiQqG?=
 =?us-ascii?Q?+/N2PmHq7dwxWvcpz9TOxcDnvKe6BAcbF7fAAwpVL7FrllU4N11p0pDQx4AW?=
 =?us-ascii?Q?m8Ky+Gz1bs1VbL4JCcl8oRipAhiq0mrCtre0x28CSLZoruR087mRk4g0m4I2?=
 =?us-ascii?Q?NZ31Zq/Ktmxf83D/FbCAYXoXIiaGZ+eeh79r24z6NcIsfIGKY3mAxn4kN385?=
 =?us-ascii?Q?tFFuZZTwbczgNxxVGBUKgCWFi7hhWALVHoqjFTsr/IjcH82hSQtcmm74XQ1L?=
 =?us-ascii?Q?ibfN48Zf5BRvQXgEiM7XJYeolj6DBCmD3nToFXTtNqYs4kbQSsJ4KwUTC7Vs?=
 =?us-ascii?Q?RVI5mLxmAvrYFlRvC31ueh+F1RfIgk6RGDX/2kzWiKrCOfZh80GO9KJQbWNn?=
 =?us-ascii?Q?ag0ew1wZw4xp20ntUMxhEIXtJLk5zSRAgtI/sZS2g4BJHeBvP8DMZgn7v0ps?=
 =?us-ascii?Q?AebGky/tE3GbFnIDhzw+T4NxScSDLyj0SOfpa0KoyJJYqbFlu9e57NwHPmTB?=
 =?us-ascii?Q?g42RqdykbA0+ZSDxp5+5HGe1HKmpdV3YteH4jUWiVEY3TQ7Pi1MlvISpiJiC?=
 =?us-ascii?Q?EVaa30G9sBDf5oAhTNAkr1TNkQcGpdzAwQ4p0YrGjvaOK6aTQhInWK3LqamH?=
 =?us-ascii?Q?nUes/bSa9+pk1FirfFCbSlvkWw1fEZOyklxm+Zb6j+AubER8B56hjX0Dbh+z?=
 =?us-ascii?Q?FpKwk4D/I1tjCKLlsXXN5g5RBB55lvfDrLtl+XthBLBvaLW2ZGXH09KCJQYR?=
 =?us-ascii?Q?VhqTeYMcoiBnKHIi4K4Q5LCnatMz14sK5W7wKTsZGOeYLhwPNAPE3BdzCWRv?=
 =?us-ascii?Q?1+QINXsz3MJHOsNp4UOE8fF7Fuj1HXafPgsvtchTYvCMXnIsIdGaFKtxR9iC?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e86949-f610-46f6-85b1-08dce9de9e0d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8189.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 10:22:32.5326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eK5Z1qv8kMqiDMPslaoqWXVBU0kM6tjtjIokmSI1u8FcJpnEq4Z9tRF6r2SxD1hvkbnQH9rsCZCX2ykt3uv4fUpNXUU2mT3AtGkImB5YR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8137
X-Proofpoint-GUID: mRCetQLjXxBTCchU6qOYjYP0SIlK4RnM
X-Authority-Analysis: v=2.4 cv=IrZMc6/g c=1 sm=1 tr=0 ts=6708fc6a cx=c_pps a=7V8mf9/socFTThwl5N0qNQ==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=bRTqI5nwn0kA:10 a=i0EeH86SAAAA:8 a=BTeA3XvPAAAA:8 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=inzseO1IMo6gxlbjCuoA:9 a=tafbbOV3vt1XuEhzTjGK:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: mRCetQLjXxBTCchU6qOYjYP0SIlK4RnM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_08,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=818
 suspectscore=0 spamscore=0 impostorscore=0 mlxscore=0 clxscore=1011
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2410110071

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


