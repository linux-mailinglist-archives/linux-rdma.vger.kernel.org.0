Return-Path: <linux-rdma+bounces-21637-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a45LDFExH2o3igAAu9opvQ
	(envelope-from <linux-rdma+bounces-21637-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 21:38:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3435D63175F
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 21:38:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=tXeec52w;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21637-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21637-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1AAA2301AB58
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 19:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B468D3090C1;
	Tue,  2 Jun 2026 19:37:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011039.outbound.protection.outlook.com [52.101.57.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C4B352026
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2026 19:37:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429054; cv=fail; b=TzQ6H9KqnLfTNothcV9Dkm0QT7DQAxdRbS8H7bI7DANIAV1GBZ0qKqngVkbwJqDOc2SR1mkoIu2KANcgSNgMI1dCSlSUGlbKPxi4r1d2n4v2Tiu+2JVzPTGzPHSaApu1TOTk5i0L3PAouncXVdhxdoLK7O0Jeb6EIgHJQnI815c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429054; c=relaxed/simple;
	bh=E7onBPeVzzqv6LfsS93COeF4y13M0zPLmpLLbUx0M/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=txQDouD6EIbjAgz0M0z8ztQDneb7ysKP4fdRjxu3mLe7PkxNKXCEo3FyAqSMtgt+h0slPZawOvXK7uQwYSHOD72q5/yG5MdHVnPpnkEK59r6Nd10IujdHJrcJzvitDhUjDtBw/yMifVOc1iyJBFl0a4fSQjYGUEI3delY8n/nHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tXeec52w; arc=fail smtp.client-ip=52.101.57.39
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gU/wt0zINag+nz1Tx3GL9o8zXgasEs01APrG3IOMhHfM7TSb4/t8pFbEC1GTuf/y25xPleMKFJdFxfv6fLGqxE2Ox0atEZwFr1hlKrEc97EOpHnX0bfdMHqGd/jRz2UOEgsvZ2DZgyA3sFFQauJ+NoBCzNI8ozp09zgMABIl+/B9zw8y7w1TYq8V4Ufe32JyugXIq+2DoxR23mmpDn/sGFSFkO3u2nLLTnl17Laqzyv1qF64myCyEd6QQX/8oM78tdDPH609ZPR5A9ad49w8tSmuoOpCRlRXZBesAVGFbRQOAlyezIjd0Mi9HMW+RmKok1LmuRuwZR2z9Ynl2cmsvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czERaC5f4Ufz17FGzITAzlX/CaY8habXIbzqPKoUC8k=;
 b=KKMkIputUcL8PW7muFj7s0ZfB+E2+deZjeNljTH7264NjMPujuAgL01mpyGx9C1dmZt1h34joESXF14YhVdkhoYze5aXJFJ87kWsK00XRnwe4OdJqQwfU352PFxQPqW0/5Ea7kpuYFJy/QzVGrmuIpD+Iz6a/uhvBtKc4TwQP0Op74k7Y5lPKSqIOZzBVt4p7S/1A6GBYOddWknRV8b+rOisCtapfsmEwsO0/J4NP53soj8wzVZXArDjpmuGYec9CTe1yxeFa9Tuyt2IIBlnxf//cT4uNGlYd14uiZNWemcdY4poPSbm+OPNPCpNpiO1Te1jBIWe9etJrkQ624UKXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czERaC5f4Ufz17FGzITAzlX/CaY8habXIbzqPKoUC8k=;
 b=tXeec52wJ8XlkMFWZbCkAmI0DsG0W8rXnbTuAI2nSsyA9lSyvracfUCf9GOyNX5zgnwKQe0/icP1uBnYJbquaOD1nWQuOw9aBhdvAO6CbyRfftnP8Nqxo6dJNYN2/OQ9jKe16+nosvC32hbBudxE2O+l1Y+X99vT0Ezs5IpqeyeG8VsFLrclUp1JkuwGLyG1YSGjTwP1LGXMwqtiaF1phKz1asN6TBS3BdN0YwGQGhD5xfZU/Uq0l1exym8tHoxV/Q9JYfKUmuih/0PQ9v+WhdCsl2HNvE1S7NganpYBF1zOm7EbgMjI7X+KKvoT7DeNv7XmgSxID8Tbp/uVtM5fQQ==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 19:37:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 19:37:29 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Mark Zhang <markzhang@nvidia.com>,
	patches@lists.linux.dev
Subject: [PATCH] IB/cm: Fix av cm device leak on an error path in cm_init_av_by_path()
Date: Tue,  2 Jun 2026 16:37:28 -0300
Message-ID: <0-v1-38292501f539+14f-ib_cm_av_leak_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV8PR12MB9714:EE_
X-MS-Office365-Filtering-Correlation-Id: a57b2844-fc97-4d13-475f-08dec0de6227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	WkVWH9EU4q3aq3fjsmcH1d7fJKqlxRj7gmRieU59bUgoWIlfKRchfw5d6SNzFi6AnOicdXeAbtMVBirN8RJFELtHgDk5IfnqNVtjf3mh2TgkyuteVhZcfGITa3WrL4H0lJwyNSgSjdg7tIlvqybxG/vm+QrGIklrB3bE7gcHOLwgytCvrlodCtCdLgLH9BhZKoz8k4wCsJzS3tXMkJto8MherI2y4QW1pWx2iA5tolAUZKGkINGwPhcOQvNbNaqsLamdTSXJcuRnKv99gPGWU1Qr6Ebj7GBuJWji4smgtuNQ+2AGDJ92l0SFdqIBBmgjJ9o7DtSiegl1EyMj27cUxw8yy/uIOD1dyl4RkpDE6ZcydrAT3RP3SeuZk3AAZWE0GFM2ai0rbK36xTOAqE5a+0j62Vpm0cyR5OqbRYFCZtWawDg327uiOLKm+CoeL496TheiK5RAX3UXuD28rT8riSp9Te/DP1DsflYqy7bQBE/RHmNYpB4ZG4aYkZPsj037WyJjFW9ZsnZxZFKCKHXy67WeqZurrDSSxoV5jpn8UuwqtqfyOnWxBrUDCBV5JN0JYPQ0NPO/qZ5Hn8Wl+cDIZtOUEJa6HJc4F9aqP+2/A1HaCGpcW4UMT4A9GviM5RKcXTqTRLHC63VDf6/SGnRVYrAFKG/Bf6+8xWlKVXvnr21NEsWbH9WjhZPPDzj02C0b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?26XKOaNn85Pmv+wsFVCLxjpOMseE5kctnj4Lo35vncdzAqRAaH09cDpp0Y1U?=
 =?us-ascii?Q?HekNWh5bVhK2qGOz8N+ygDw+bgxzKR/BSaTWxtFoX6Nj5LeIGOutbCO9iInJ?=
 =?us-ascii?Q?OKuEHpS+SfXucSK/R2Z1KZK0B/k2W1iIK7ERL81KQBPCwwE0w9EFnkufiBp9?=
 =?us-ascii?Q?c7HPk/gWIuyIFgLdLto1Pxbn11ctp5z1PgLcbc87mSvz8CmomQeoK+M9JYof?=
 =?us-ascii?Q?gcuHJ0GiDhvkn9/5OXby3giW4+VxOJks/Pj2nzKWM2tqgVbWVLnSmpXRxUQO?=
 =?us-ascii?Q?DvtFZaZNxVEUvXJHiVA/1Ns6teHpUXBLwBtgLfmkgdatZdoocQ0hkSMM/EU+?=
 =?us-ascii?Q?3pDnvLvtyAmdDylKOm+yo3uG4KdQBaoXUBH8BFUZo6SpWE7zjwYMrGQS9Mmk?=
 =?us-ascii?Q?84whKw57LdVRTLc4DeO6SP7PzaPRz8ihE98CaCGKqXtiRxW6agMTsCDUdXA2?=
 =?us-ascii?Q?kZJEArf5b60Gc+m1sKiYT8jbYMREnuQOCI6M+EpLeE70RL3WlGXjmugsz8O/?=
 =?us-ascii?Q?DiyAqlNN/LtBiiVA8a2A03T3zBvTuL616Idr1gjPV1zE3cA4F6amYjyeAn75?=
 =?us-ascii?Q?3OBp44iHWGm/KvdwO8pze+M/laMhazUOM4emXwzJSuvq8QCzqvlAcaQ++yYx?=
 =?us-ascii?Q?Sm7fxT9CaVURWVWVjI3fvtEPWm/JLF6U5a4pFNqz+uKXXrcPw5/PHklHhlwA?=
 =?us-ascii?Q?hN4yGzIVXw4/mZ8I5ZFLQuRegtelvl27S3KzHaTrvuQ64ZAL6pdMWFrLEWqB?=
 =?us-ascii?Q?xRQiNiGezvD9ZqO0/Q4gCRNZjWGJr2RIK3Bopj0fnuwmR3mnC7b+pQ0cjWTg?=
 =?us-ascii?Q?fGBEuwSEjBfddBnvyri0j2FEKZW53LoJuhbac7RVZOGD9oC7lm8NCHPkd0Wh?=
 =?us-ascii?Q?jrL4x2hwLSPs2nKUnS5Boh6cCqNeafdDWiai7xQK3HPS/4n/Yc97e9SFYYBJ?=
 =?us-ascii?Q?RJxmZuEkn3vRUYenkKt/k3+h7rJr1mCbq1QNFAKg3TuJ3rUUgq2keec2NfVu?=
 =?us-ascii?Q?DJPqtzvpSpKbN6GcBglHxkXLSnD15oQNNAbWb/9rDuGxlZZ1956Ci5HV4cRW?=
 =?us-ascii?Q?2th4e5gey38suM2s7oYDq07KdBsb0EsouPYBpaBG/RYe0Kc59Msg6sow1FjS?=
 =?us-ascii?Q?6Uu78n92iAP9m4KPLOLN1IFicJr9c89ptr5JsOPoU3uJv9dFbSCP89/DBJKD?=
 =?us-ascii?Q?DAL2lLeyRuiaJo8o6Tj/Eb2vwCykh7eyeE/B8LhVCRFq8JC2VMCbna/plPH6?=
 =?us-ascii?Q?LBVR67BjPii2ZZqgvkY4AsD3ctNY7HvFF4CJ79SDr5BSz0QN3k4bedu41qH1?=
 =?us-ascii?Q?dB+ZBYrZVAJy/fpYGEOwM3jD0qEO5CVnZkZ00IHGuE8EBlOqF67P/boC8UhH?=
 =?us-ascii?Q?Ggrc7Q+eZqhkLkn29MDcdOIrkBNiref0OteNWl2oOFycPB2zT6oJE91IYlSc?=
 =?us-ascii?Q?S13nGEij6l3apkt/ZY74W1xGv4USQeWWCyacWn/CvMKQhZ05c0lBbK+LFiD5?=
 =?us-ascii?Q?yfaR7nRnU4iJr50/NCsmIoUNtgUeg+If0otkw0d4/SuvwKBKBW5anNUVbjWJ?=
 =?us-ascii?Q?wgzNXr8/yfcFyUXK1Gf/UiomYHfvQiUiEfM4N79k9ZtssQ1ejE1PRP4ft3yU?=
 =?us-ascii?Q?U5lZmfv0fzdCJztbCOF8/n3aOKHaQpqf0bZs6TjqxMqbdd7PokUXJMI4icln?=
 =?us-ascii?Q?cNmSZO0NnsZANgb0RPigpE6DFGdFZEgj/owpNav5B7uZhmwM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57b2844-fc97-4d13-475f-08dec0de6227
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 19:37:29.7002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DD/uTLz7j9C32C5QtLpaEKCUbUq4Z5Za3nldAr8MSCQiEoR8f1ehQbFDGrHqNlVO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9714
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21637-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,sin.lore.kernel.org:server fail,Nvidia.com:server fail,nvidia.com:server fail];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:leonro@nvidia.com,m:markzhang@nvidia.com,m:patches@lists.linux.dev,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3435D63175F

Codex pointed out that cm_init_av_by_path() can call cm_set_av_port()
which takes a reference on the cm device, but then can immediately return
error if ib_init_ah_attr_from_path() fails.

Since callers like ib_send_cm_req() put the av on the stack this leaks
that cm device reference.

Re-order cm_init_av_by_path() so it doesn't touch the av until it has done
all its failable work, and then update the av in one shot so it is either
left alone or fully init'd.

Fixes: 76039ac9095f ("IB/cm: Protect cm_dev, cm_ports and mad_agent with kref and lock")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/cm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 6ab9a0aee1ec60..ee966a25141b12 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -530,6 +530,7 @@ static int cm_init_av_by_path(struct sa_path_rec *path,
 	struct rdma_ah_attr new_ah_attr;
 	struct cm_device *cm_dev;
 	struct cm_port *port;
+	u16 pkey_index;
 	int ret;
 
 	port = get_cm_port_from_path(path, sgid_attr);
@@ -538,12 +539,10 @@ static int cm_init_av_by_path(struct sa_path_rec *path,
 	cm_dev = port->cm_dev;
 
 	ret = ib_find_cached_pkey(cm_dev->ib_device, port->port_num,
-				  be16_to_cpu(path->pkey), &av->pkey_index);
+				  be16_to_cpu(path->pkey), &pkey_index);
 	if (ret)
 		return ret;
 
-	cm_set_av_port(av, port);
-
 	/*
 	 * av->ah_attr might be initialized based on wc or during
 	 * request processing time which might have reference to sgid_attr.
@@ -558,6 +557,8 @@ static int cm_init_av_by_path(struct sa_path_rec *path,
 	if (ret)
 		return ret;
 
+	av->pkey_index = pkey_index;
+	cm_set_av_port(av, port);
 	av->timeout = path->packet_life_time + 1;
 	rdma_move_ah_attr(&av->ah_attr, &new_ah_attr);
 	return 0;

base-commit: d6ab440240a04b8737ee4c7bb21af9182e451733
-- 
2.43.0


