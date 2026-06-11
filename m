Return-Path: <linux-rdma+bounces-22101-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hTuFAGh/KmrvrAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22101-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 11:27:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6603670654
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 11:27:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=2IwgaqCr;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22101-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22101-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11F543003831
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 09:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F283AC0C1;
	Thu, 11 Jun 2026 09:26:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DDF36404B;
	Thu, 11 Jun 2026 09:26:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781169998; cv=fail; b=n+FWPaPPKZBsClsaLfKKdSt8gW1enjByLfIKAQ0Rp11ihsseR69eXjJogvtzUnqOEjPoNxHNtOGY/jlIju1fEdFB+pmVMHQDNe7LwFVJfmHOp/sT3JlX+JGpNSQ0vOffc3OSoSCEXrYpU4GD5SwnuA9jqhbL0FYapYVQjxHbN3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781169998; c=relaxed/simple;
	bh=as4oW+uyDR+Lqfa2014fJuPaoejgN/AR/3FRddsT4t0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LfDju5a1FnHY2QdUnKoShgMzBMVKucdjBuj7Uv1NOLwz6USfveKTWnWwbkHdACejrvRG2mF0yV2Tg3D03K8HGFw8MoMluwlc8iyUhVem5HRBLPmb+eyki0nb8pUaS3tPEKqOdOhwEuKuQRpguLxfjjF4Sp55Ul4hw3P/b/6oXPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2IwgaqCr; arc=fail smtp.client-ip=40.107.209.24
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CANwGlxcXnvdEIeHGUxbQtbVjnOydeu7q88693t5jRFsIeAGew4LECbcZMhtVM0wzkS67ReWqjvouFVFkWKcixR/2Q/dL+wM7lnVRASL5URMyhoWhiZoNWDUZ+pAnOaXBBGcjr996UMg5FckLm0CAdp1CQANoVSsrNP+CTp6Ude5Kj7ro59HZNkkWl7pifWbehHqjFZLP8ky/Ha/22UB/Y/Y1rF3iP5TyGHveJ3W2TzO4WdEjmJkqgUMlbo8iqMvRPlxg3trOm/H5oQ8stDOn+AcVFN3RQxFoJFmk8PcbLlBdXaFWPlmg+LB39MHyO9Pmb2O2SQlI+ETVRbJpCWjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJ4m/XyJGhFs2T/e8fR4sdjYwH/28u+sWH091FmsZ+o=;
 b=k9Q8IGwwMnGF9EbHn58a3HC5YK1AYQ4zJju7IJh9dJM50tR9ivK9R0h5nmzTrQFw+4TG+lI89EEvNG1LLXwdZ03LLO1GStfar/znBbTOLzeSqoeDVGqH0pUg9CIXV+mZzk9uQJ3vtBTDdeCfChPfhs1LuLXTY42YmTfbgcCEamJ4eYJxEUYQSwmmeIXOb2zpZaWvWrTMC8Z1gKHyQ6jzB43KiiEdJP0IiMzX3OuwUpiwgM87ZMkTA5dgeUHrV8QLjg4zk8dcGad1pJxpnW8r3zn+UVpt10EOt2fhV8MOj5Ux7Y0/Ev4LfHfLiHNygEXdscs8lswvbUc0e+UJDT/BhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJ4m/XyJGhFs2T/e8fR4sdjYwH/28u+sWH091FmsZ+o=;
 b=2IwgaqCr30kEbQv9XBQcUBh/+9T8jU04smxaSI0TuzpF+wtAUsKYaY5t0oYMRyx+vXaMdOydrd62DysxGdmWrMwBR8xwa8BnAkpWixTFgeLA+f/v4nXR57cG6VED/G9Tn4c2kK4tuG2KOjGLHdV8TgCx+ol3UVkRx+evlcYoNlc=
Received: from CH2PR14CA0009.namprd14.prod.outlook.com (2603:10b6:610:60::19)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.13; Thu, 11 Jun 2026 09:26:32 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::6f) by CH2PR14CA0009.outlook.office365.com
 (2603:10b6:610:60::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 09:26:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 09:25:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 04:25:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 02:25:55 -0700
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 11 Jun 2026 04:25:51 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [for-next v2 1/2] net: ionic: Fetch RCQ sign bit from firmware
Date: Thu, 11 Jun 2026 14:55:42 +0530
Message-ID: <20260611092544.783731-2-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611092544.783731-1-abhijit.gangurde@amd.com>
References: <20260611092544.783731-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b7bf019-f7ac-491b-b3a3-08dec79b7113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	PaTvwLiTuVRQitkj4BdY3uhfw8AHQ/FELvEgiI7//AdxWEmkKsOVykleKW1512wFklQkz42kt/72s7DGUP+UTBxX8574vvHgM5LYoe1jK/DaSoglQy0ivx1nQUek/6Ql+amM4ke1YY/I+h43J2/Ap3okk7IXzh8r0Z5wX7Lz8uKp1Xm7XjOKjxCyNnl9JRwbe+uDbiJh2cF0Mb2qr8ANQ6BfoBvUC70n3e4mFPnujaisIAhC3ka89MBrbeiWymPOjGQPT+kogotox2hlW7VBzrG0hl/Hkct0rm1bzDhnjMM5tx8GVTxmEvRsTN7mk3ldRcLv6kJ+ohe8YQu4Vvr+2kmUJlIPRMfwIk/uGirgIAMH14QIEaOOjp2zQpyV2S71x+WbsK0RCAsIdxkwEvTJMTh+TnXyQL52w0wjfF9tU/ouJS20prJoGl1BUO3RD/oKc4bh1QIwaBE6j8tSiRVCpGD0rhsTEgHA4R/lyFllU+FdVdCZBuFg8a/xw8kbDENAzAQ15Fhzx66/wwhLgYkPk+vPi/zxc+ZIytNXti81Qx56Fi74v3aFnCiCd2Kesr985dUs2Pvqb/2wuw7ulPWeZmk5XuwdZAl66q8uvDgkb1Y55zk1GKzgThDAqIt2PthGUsfxWecDjyPSITlz0ZWciK2cNSLGbBDEFKANwxqD28hlEpD4Chl7D1SScu8zfGmrJT9+TfC/ysY8W/eokgYevlgdoa+kuq3u8xqSxsNjvZk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+8OQtyT1FuoW/2r17bs4NHj+bfxLrZCnWO5hhhEJjQXqObSPZBJEGowEzhyRtfs0u5ofRlfdHpMMlx6d7/VkE67ffdJ2JWaoaYLzMdadvz9GH0wbxy/iVno0qmjc3M0dP4eZpPtJRwKiyHmn5OrZ0FQaHWounWAGx5SS5yYDQ6VZ+Li9FIdMCYA9mOC1gcItwIco895o+jgbjodZU4T/lLiTb7xqx7X8eb2Kj7vAr6Zl05YeqDeDKOysVtSV3HrWFwoOXb63doN31JFld5M8AjCP3cFWF6KdRbk4LxAI2wVI1wZgIgKRpDt3U4NQI8mrGLIPbDh9dqEFPfHUJ3kMxN0EwcAc/IAZ65nyxzatn1HRrC9AFMsWFTycDiqdepzQ33l7ZYHQXZudgILBke09jUkXmZzCT99wFAto82/ZDqyhD4cLvi+3R26tlfiPhUrN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 09:25:56.3584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7bf019-f7ac-491b-b3a3-08dec79b7113
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-22101-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:allen.hubbe@amd.com,m:nikhil.agarwal@amd.com,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:abhijit.gangurde@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6603670654

Read the rcq_sign_bit from the RDMA LIF identity reported by firmware.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_if.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
index 23d6e2b4791e..b97de96f78c4 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_if.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_if.h
@@ -553,6 +553,8 @@ enum ionic_lif_rdma_cap_stats {
  *	@rdma.eq_qtype:        RDMA Event Qtype
  *	@rdma.stats_type:      Supported statistics type
  *	                       (enum ionic_lif_rdma_cap_stats)
+ *	@rdma.rsvd:            Reserved byte
+ *	@rdma.rcq_sign_bit:    RCQ sign bit
  *	@rdma.rsvd1:           Reserved byte(s)
  * @words:               word access to struct contents
  */
@@ -598,7 +600,9 @@ union ionic_lif_identity {
 			struct ionic_lif_logical_qtype cq_qtype;
 			struct ionic_lif_logical_qtype eq_qtype;
 			__le16 stats_type;
-			u8 rsvd1[162];
+			u8 rsvd;
+			u8 rcq_sign_bit;
+			u8 rsvd1[160];
 		} __packed rdma;
 	} __packed;
 	__le32 words[478];
-- 
2.43.0


