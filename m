Return-Path: <linux-rdma+bounces-21558-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAyqEbQkHGr9KAkAu9opvQ
	(envelope-from <linux-rdma+bounces-21558-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 14:08:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6918D615F70
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 14:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD3F63006929
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 12:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EC8387364;
	Sun, 31 May 2026 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kp8sf+C+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010068.outbound.protection.outlook.com [52.101.85.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995F438643B
	for <linux-rdma@vger.kernel.org>; Sun, 31 May 2026 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780229257; cv=fail; b=YGos5wEhpg9LiG1ksN0+1sj6N+/DGtDff6BVPohoRK9/oV36KzZB8lLZv3Od9HM8HZku+Ca9093AxX0Cavsr9+TaEBzxKvf7f9bSQl2FtMoSAuCrrMfeAw+bzwKqzf+DoMEkxka6zOixCLLO5R5HpvgubhyLRWTMEWnfpHM2W5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780229257; c=relaxed/simple;
	bh=c7RR9Nwf7Qrt11GvMNz5W028A/ty7axx664RkHYKDMo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nZcP09E3VXQSZqFssIxWGlrS/UFJCXjIWCWd2dmK+N5B2sLlLmcb3N8DwiAihFMmdLq9XXoIRmAoTV9T2SzOv7gdHtXSL9QfbG6baI4329uGjek+IK8HrcQLltgt8gUw3tDBf2UrhdU4izaEK56+R2VKYmVHLFeihKjfQ78/29M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kp8sf+C+; arc=fail smtp.client-ip=52.101.85.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5kEJkElfZ7ZuxWnWHWNj/aqEe4XRMUdi+VyfYgNtjoDX+KtcA3604p49vMyf8Tt6/Ky3YArGU1SSjavkhFG3PfklnAMFEgX2/FuEL2p2shcgfm74w5cnE2yyoNMj2FmYeeZf/ExJQNqaRTSJlYxT6gLb8G/uTwgBg9B5Dq32BdkO924febRQg3L0ga1FWfhIrjLHpRrUHeRbvn3U5uW+dKmzEI+HQeCxrkbPk91cPeVYXutK75Ka5/ijYUPuhKVkG8wPBozzAdmG6uGrcy5dkw98vLlWp9uCpyetKOvwQKSBw0gF/2Mfy9weTpt5myNQISmIS3ZDlVLWGfbRQo0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0I1DOMZvh+D7H5aDqijCjPkvflhYBC3bsNSworu3tg=;
 b=BlkrAuFqEItscRUQIAky/8w458WfDJHALSQsUF0QsVuolb2k5him8ibLOmLd7hZT9y6+8HP7ZspOZ3Rkknh5J8Nyzb6km1PhTf90cs3vRIeqxPusHtHV48mGG+I4VU4l5/w3QmizvOFJE+RFdznuvZjciYvPJHQBOVl2dwlehbPZX0Ei3mSlVVX4qj3aIfQw2NuHpFWDewabJ2LDoSC48Sxlsxwbz5g4/U9uSGJ88TkvejQL1emUXqJI+mKEutzrUnV7kyY2N8RDjw1uvGQIpikBRtbCE60XmMJVIQJn5DKFR0Cjk/Qivinx+yc35RVkm9i+PAoh6oCQPzHRTYD7sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0I1DOMZvh+D7H5aDqijCjPkvflhYBC3bsNSworu3tg=;
 b=Kp8sf+C+EMnMxhkZOdJa3+mZLwvJ2PJdhXUZW7FAka8WUF+ZzUKwDP8z3Hw4q+k1Pbb6aI3JYgzT9IsbRj0zMnCOHiUo6+I5KPuLF/tEiM9Wt8YUXcsXGH8tI2IKHhm9Hc02VUUNcw1z6h+ssnyT8L4bBnerH4LTJM2lVQxdQ0E4T7JVDn6yIaREjPEJEypyUTv6aaNQxmdmDx6aiquRFdhXUOez5SP0Tq8vW9KbVZABRMzRW2UoJxZa3Ju3dvWScEDP2zojcl4Ur03fpXZwIiu3+da+ct3lHxhfU0uPjstsKhF9A0XLjCPaP7aH0fEXJboS5syPzpNPQ/Nzfecx0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by DS4PR12MB9585.namprd12.prod.outlook.com (2603:10b6:8:27e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Sun, 31 May
 2026 12:07:27 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::1532:a957:cff0:9ca4]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::1532:a957:cff0:9ca4%6]) with mapi id 15.21.0071.015; Sun, 31 May 2026
 12:07:27 +0000
From: Jared Holzman <jholzman@nvidia.com>
To: linux-rdma@vger.kernel.org
Cc: Jared Holzman <jholzman@nvidia.com>
Subject: [PATCH] rxe: Fix dma.length computation in wr_set_sge_list
Date: Sun, 31 May 2026 15:07:21 +0300
Message-ID: <20260531120721.1347977-1-jholzman@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|DS4PR12MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: 27284a57-5b80-45cd-407f-08debf0d2ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	pVpdBsRVNLEYWUIr0afqoMBlp3tSIgwf8uVOoCDJcK/FrjlUNcbvSTTZNjig6GISKyp5MtlAxNyFIIzRYLvRQ5b1Z+pTt4jO2DZBXbqKya+bXkmFv8PTlGB9IAtSJVItL5LQiHNGvFqvNVctJ+y2B95feqOZnwaRJF21TzTpaG8dFOFWw9SvyH6pBT7O5w1XRLqnjPZh68rhtnFqirBTETdVpSXnWhf9JKqSA8Bg+QPKNHylRMBh94ebw4GNloH8oV31E0kgze/irC2UZMvvTlQn9zvkMOvIe5ZUM6/UXaDw/4Eyl6TVU+79P1gkWyDehBASN4iUvjI3GsGYRSVKRT6phk/Cgfzs0UtlvdwtBcQlUROUtM4HtPzv1mxu8gqhJ493gQBcow3O5JLS0KbMq4nY209fO/7FVMEZVZADfJuIaSioSd84I+J0FJNcITlFLSRfzjMLuXUEcoS4uEIl3m55D7/HA2tYbBH8YfsjMa6AeQ3qP9pwGiTz6zHILk8Lo9FDiYUpY/bof5SWdeQLwKuXhcxUMEtb5Dcw0T/J5y0dqZgs9M0qYP88sYBULL9JhOJktYsVb7L3Et+pRPcqqU0gFJslmUjh+gFZCIQMTo3vocsQyMa7VzNj4azYG+4MnwsP5OFCsi4/UkGMYPuj4zoiS4UvrSFo4FrAhPJy4lx+vZ23kkedVBOmnpYOBQMa8e6kxNQ2Pd7ZvG05XwJMzQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jYyOGszqIP9vfExMvHNXcZVNBNt4qkh4nDTEdT8Ngn9tKwx/RTipEhNhMTcD?=
 =?us-ascii?Q?gFO02jT+buzBlPx/fKkJtMzzeTs46bno19As+vbiusCrGjoCen3dj8GKuWoT?=
 =?us-ascii?Q?4yS559cGGzt9jKTXGJbj2k6bOFTiEGm6MZQafDk4hroLcZb178qpTYvAzFMj?=
 =?us-ascii?Q?V0PN8Ryv9Aq7Vst4p8mB7YDR2etPq4p7d0vMmaHDG0GvgzYZeIadzSBlaFrE?=
 =?us-ascii?Q?v2IyU7FQXgkTGNk+iVmowoM65SJeFoQLdYGSeYOFlMCRMpaqnq/z/VwYU2c7?=
 =?us-ascii?Q?RNXPZm7FhqRyU3//maiKVxXqAiGaEAcGOzKjMd87aBhoCGKzCfjMqMp/rTBE?=
 =?us-ascii?Q?Lqo9q+RL5sVnGuPso5bNSvGRNB1aBh+AC2Bz+aplkTcc/EnV6HLtSYOi3Ehp?=
 =?us-ascii?Q?XGYg/9yerB/fuG76IAJjqU2Z7Z3OzNk3DoL7Rp4/I4D4B0QnZ0+cG4tMzqns?=
 =?us-ascii?Q?HfMBPgSwzwQlpw2+nMgLmLqqBwPcZHq0zoSkGUcbOpvptE/urRr4pCX4+Mfl?=
 =?us-ascii?Q?S/7I9mByivLTGuWK5e1L8xTR1eFC6QVdy9YoW8LLYvkuhmgwM34y21lRqKJE?=
 =?us-ascii?Q?iXX513CIBSVr2GSbZsmf9bbuYePX6VXmGqwLXab2wZDYNYWYhlkPjF3ZmVsP?=
 =?us-ascii?Q?Wj4znYq8PnKcbQjzcsRTh+uC+aoZjGrAfApObdnOQmKAKdrtdqpIvD/rH6LS?=
 =?us-ascii?Q?CuKtezyKSqOuGjsJAjhdtdoHqPUjhD1i2y9fXctK60SEgba/LXq+pqImTEMg?=
 =?us-ascii?Q?i4wjFf5jPKnG9XHO1C9dQCqOM26AvxHuEfAFWpjy7MaHjTuf7mCQvILcqP2d?=
 =?us-ascii?Q?MMW4NfNWmwk9S6gzVAZOwPyNU02OXDxPQZkpCU/LFhhB5sadjEPwAKAjqYMl?=
 =?us-ascii?Q?nzyis3vBwBsi64lkEsbD9WNTZSF8bPBZlGfxd0irsoWOwZxd2lQ/iJj6nT24?=
 =?us-ascii?Q?qf9as9/N4UIIM75HUmce29S/FDw1MFE+tIv6kkHvsSNOIIhuXIvyz8DhJ6HL?=
 =?us-ascii?Q?P881FiH4BtU8uvFNEA8kLZTwnZfVWgG1CQku3C6OOdQi+4BrixqZYX12RASs?=
 =?us-ascii?Q?AvWMJsuQgdv3eQXlSq9pSYImfe52Jt1AyqIm3elmxzPmUMAJLeisSReEbfwc?=
 =?us-ascii?Q?gn/LCSDN8pNTCkrgQLRvXa4njbq2lvPtJjGM3IVeKWYVQf2jxtmoEoDTRaA7?=
 =?us-ascii?Q?0f/Q5lwPyYhnaRRfl3c+N7y8SXm2JUDvZp+4EgEfaonUXcYeh/GbhduavPn6?=
 =?us-ascii?Q?7cczbkgbjcuLTo14jISeOqm7HLe4UoNMNN+19xnR/8fkdT6PLG+JDztyV6Z4?=
 =?us-ascii?Q?QAcRR9fqc5qu1xmCn+BAdBeHNiEvIv5zkg0mqn8BR4oLEIO/VjTAIq8xK7/H?=
 =?us-ascii?Q?5zgiWFqkZmIOVP8X3G2jUzn0F2Wor0/2Q95aUSFHNU2ITX9aR5INe8WpAE88?=
 =?us-ascii?Q?nrRTag56zAdCYb9ani45AZsPt8rrrs3CaGkep2e7GQSY3H7DhCp1M8465MoA?=
 =?us-ascii?Q?d66kdL6dZQJ1pRgdnCfFStnHBwkflAA5ZlfIeJ1l5HMtkPEdRgkw1lhTWAqW?=
 =?us-ascii?Q?Z6SXVz2MHIVlaabjSZwxYRGcXLGNz7fWR7UZg3kAAmOtxVAHcStCNK5qxPim?=
 =?us-ascii?Q?01iBWDbBZZX+9BeSofEO1YY3K4cDX0FgSRiQN+i8pIgsUDVU4r7qCQj6GoFF?=
 =?us-ascii?Q?NgeT1Pq9xyW8wTns0VRU2UQ47CV+bISNMg4ijEpZC2XC+GUF+4AAfIoawbzY?=
 =?us-ascii?Q?+cSwPWzUxSvfnsGbCkmWEjSUDWf6sffg+raZ+8tB6YvYVhKHWbrliJkDPNU2?=
X-MS-Exchange-AntiSpam-MessageData-1: xicZ3oDby83CYg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27284a57-5b80-45cd-407f-08debf0d2ed1
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 12:07:27.5710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+xB6FfjEq3Dw4KxtAz0BQLmiqr5cjLP/noxOO19Ectmb71DubhB/NjRIotp8jHX8zGnkxJ8hfGXFoFbbzw2Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9585
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-21558-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jholzman@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.966];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 6918D615F70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

wr_set_sge_list() summed the SGE lengths with a loop that never
advanced sg_list:

	while (num_sge--)
		tot_length += sg_list->length;

so tot_length ended up as num_sge * sg_list[0].length instead of the
true sum, and wqe->dma.length / wqe->dma.resid were written with that
wrong value. The per-SGE entries themselves were unaffected because
they are populated by the preceding memcpy().

The kernel rxe driver requires dma.length == sum(sge[i].length) and
enforces it in rxe_mr.c:copy_data(), so a multi-SGE WR posted through
the ibv_qp_ex builder API (ibv_wr_set_sge_list) on rxe completes with
IB_WC_LOC_PROT_ERR once finish_packet()/copy_data() runs off the end
of the SGE list.

The legacy ibv_post_send path (init_send_wqe) is unaffected; it sums
the lengths with an indexed for loop.

Fix by computing the total with an indexed loop, matching the style
already used in rxe_post_one_recv() and init_send_wqe() in this file.

Fixes: 1a894ca10105 ("Providers/rxe: Implement ibv_create_qp_ex verb")
Signed-off-by: Jared Holzman <jholzman@nvidia.com>
PR: https://github.com/linux-rdma/rdma-core/pull/1744
---
 providers/rxe/rxe.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 423f834b1..6d7be1493 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -1138,6 +1138,7 @@ static void wr_set_sge_list(struct ibv_qp_ex *ibqp, size_t num_sge,
 	struct rxe_send_wqe *wqe = addr_from_index(qp->sq.queue,
 						   qp->cur_index - 1);
 	size_t tot_length = 0;
+	size_t i;
 
 	if (qp->err)
 		return;
@@ -1150,8 +1151,8 @@ static void wr_set_sge_list(struct ibv_qp_ex *ibqp, size_t num_sge,
 	wqe->dma.num_sge = num_sge;
 	memcpy(wqe->dma.sge, sg_list, num_sge*sizeof(*sg_list));
 
-	while (num_sge--)
-		tot_length += sg_list->length;
+	for (i = 0; i < num_sge; i++)
+		tot_length += sg_list[i].length;
 
 	wqe->dma.length = tot_length;
 	wqe->dma.resid = tot_length;
-- 
2.51.0


