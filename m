Return-Path: <linux-rdma+bounces-19783-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJD5OjxO82lnzQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19783-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 14:42:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1EF4A2D86
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 14:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 897B6305DA50
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 12:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A049140628A;
	Thu, 30 Apr 2026 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IhGlkC0X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9F7406291;
	Thu, 30 Apr 2026 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777552800; cv=fail; b=uQi/8Qd+o7ia0u1LDyJzlfTABatJ9+fEnKHROZjFOavmqgioY/9vil5GEfUrt/3hogXl1QnWoYCbRa2SeoUI6pkXUrk1Oze3GEFaGjvxuBBY3Bi7YW65kIfke2QFomXIX1sj9vAys6pdo7yE/uv2XSOm3FQcRwC6ei8q97TUe68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777552800; c=relaxed/simple;
	bh=0Tk+0PTZbIL14+Bj5UXOu4KK63BrsdJy1RL9V0rnumM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXoUEamS+zeue++yoa4KR7MPFWF6MC71tSezwtY+W+TgvaPLav/bsCbJkOa8OrQUkmAtc9bI1Ra9IlnNcV3eoLmlfm3BbBS/nrh/vttWUXvHlgBExT3RSpH0d7798zzmvxQ1zgEwhxiFt7bYuTwlh0exuK6qc3Sb/CvOE7kLuFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IhGlkC0X; arc=fail smtp.client-ip=52.101.52.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQDYP6WVS7aEKQy0rFek6cCv0bbYYYFXWIok27+4yxEbYxeZgd2oSH/ePtw4/WseyhOha6QCRPnTh2osUlPn77XaGyENZQsKBoxsAAKkh+SJYv7fmfxwu92J9V9PWZRbd64LjArQ4eiyr7gE4tZz4EAfMd93WP/lOBNapLO7qkQKwNOoW5rvxr0WvR1iemA1IxCViMCZPqDaAxSJi596NBktjt7GGxpyE4U0lIPs4Ej8mfs1Ph+N5Zf93KPDYkbAyzMlJvYwc2Cw6TUikiZ3+NqhYVWPf3iaq7FIPfNyji9Ocif2qKCfFwLmppwx1dEjfYgxAx/sG1Dqc7m+jUL63g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oj0EJyCYZTochhbiOIJXwL1IpRYpvR4h4NPiOa4y1uo=;
 b=oI+U3chHSUWhoZ42hbQCNQ8q5l/HFyiC4WZwyFiLO9eA/OIfCcPabdzXbfg/K3tfTRuv2XY/E9zACjH8BuNxV6I4XFjgYNcRMXJqCNw5hCnQ5h7mXHE7MZCDNDvbYWXg2fWThY+HJaX29AC2l5S6ihVA1j3NFq96kVBK/Jhh5wHh8E5CjWWceT+802pVmksbSPNUPoeZhJSNAT5lrnLi4boycrVCXtM/s5/24hxkphAgh2Ny1omgaIZione2/PQbP0OCKFzWahFRptMXp3grWp4aZ7IE3GJtI8MZcnsdbtYcYX5XU7lW+HzrEeTPf3wokHW3btrmNMd8vidPTjCF7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oj0EJyCYZTochhbiOIJXwL1IpRYpvR4h4NPiOa4y1uo=;
 b=IhGlkC0XUuNF3QRVXsOP9FmqnGmzeJfCyQCPPpGqxmSF7z2z0cTKDiUCIRX57SNtOA5ldZzATzrK1m9ANYLft4wIQSw7s6dqIkVEX5boObfINqPvpV26yHCzB2qqFPUdSrSD6kYvIDwgu8msZtqUjI+iKx0RJb0riUqYw09dItk=
Received: from MN0PR05CA0023.namprd05.prod.outlook.com (2603:10b6:208:52c::14)
 by IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 12:39:54 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::98) by MN0PR05CA0023.outlook.office365.com
 (2603:10b6:208:52c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.5 via Frontend Transport; Thu,
 30 Apr 2026 12:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Thu, 30 Apr 2026 12:39:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 07:39:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 07:39:52 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 07:39:48 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH 1/3] net: ionic: Fetch default QP transport mode and RCQ capabilities from firmware
Date: Thu, 30 Apr 2026 18:09:29 +0530
Message-ID: <20260430123931.3256130-2-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430123931.3256130-1-abhijit.gangurde@amd.com>
References: <20260430123931.3256130-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|IA0PR12MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b03eeec-9456-4e49-b26b-08dea6b593a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Vq8Um25P+ovXgxryfuiJf3vzks5X1B+VcuCX0kAEDizJDVdhXYDYi59fRme0ylOAphvZPhVUJqMvpNdG/GmWk53N/lvQuCsQWxn9V+m5Vwo6MvUgo69Kiudig1t93B/OsXchDN+UxVcwR11+h9E23HUheiF1rH5Ip2BwE36NOgIUD5yjfdDFAcXtyYjc2OTKEeeAf83wDEQVs0xAC+4hqxcVH1HW6cEzkpQLIwSbU5/hjhDpDlPJrAvw8sTQ7wD5e4VAad6I55lIDZt5naLx1vf7nDNjkBVR201NgELtosGhDiVvb4OnaRMGm3z+qZ64OIp2x2ugPx/65xRB+1fdeogB5/RyGNgtdMq8UGayw+StB1+H9rAkBFE9EVxpB7t+01Kd/hKBxzte+DckVAlcrprYVGsip3r8Wu1XUoLeE9P67MieLbcubr7fAAUnbCBI/SaY6Qin8+s/Jf37ogc3QU8kJ32Qb5WCUvMXfo9NQqTEHRWOF4sxkHnyuvl4QXAojLqYkTbAl8Ppli7u4nJoaCOM6cYybHKd5zDSCXy1k1Mh7vvHMDDV+jaU8ocLQszVhy+AwwvayxRNjNHBFMJ7coD4YndG+1U2UelsGkZK29EZNPgFvZuVmlOuzGIksrMAfWNZ3OGcCoTIVEAOP4pdzc1v+DukDyaWtHaZcZhm9/Ywk2s5M2f8BaQ2g7vO93TLj/KKcayf+gwuY+69fXyVl8U/PYZQd7hr8Knm5w2YIxvqYDHimjz+44GYnVaPiaEWViR8kJ4h1lLmQO17q9Oy4A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8nt1N3ZYQ6GekKAqo5C0kF+B/YP1bt2Zg4fqQY38ml+MSuT8nW927XFsArva5Sxl0f25whotvwchBi11Bk63SvmXeQt4FATSKD7WauMnrat6boM88qSuSNAcyqBD31ohz5Zi0TJ2vJwPMufHLvMFHiT1WzW0VxKiD008NkAz3UxuzsV5/FRIhUWcwWeQuUV4MOm0WpQyDrTNxuep846TdZobl1ucMC2TjpEXZrdd0Ux/tX/oHDMIIjeDPL6u8lexxpW/L5j6fo6CJGJFON2Au+YZpabz2SWT846RX+QMRuxCfZ60zOSL2gTewyybxeB01NM7oOU7CqEMaYD6sk4Sqy5uQLOMm/ERj35m1g4Z9d/Z2pXsahje/8w9bn7W9PmusmnjWDakaIa/v6M411fE8DMzc5ZHErsP+mKgHmqOgGPnykR8lSpw9iQ+mP6gIXax
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 12:39:52.9202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b03eeec-9456-4e49-b26b-08dea6b593a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698
X-Rspamd-Queue-Id: 4E1EF4A2D86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19783-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

Read the default_qp_transport_mode and rcq_sign_bit from the RDMA
LIF identity reported by firmware.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_if.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
index 23d6e2b4791e..f6c2ca335dfb 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_if.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_if.h
@@ -553,6 +553,11 @@ enum ionic_lif_rdma_cap_stats {
  *	@rdma.eq_qtype:        RDMA Event Qtype
  *	@rdma.stats_type:      Supported statistics type
  *	                       (enum ionic_lif_rdma_cap_stats)
+ *	@rdma.rsvd:            Reserved byte
+ *	@rdma.rcq_sign_bit:    RCQ sign bit
+ *	@rdma.srq_qtype:       RDMA Shared Receive Qtype
+ *	@rdma.rsvd2:           Reserved byte
+ *	@rdma.default_qp_transport_mode: Default QP transport mode
  *	@rdma.rsvd1:           Reserved byte(s)
  * @words:               word access to struct contents
  */
@@ -598,7 +603,12 @@ union ionic_lif_identity {
 			struct ionic_lif_logical_qtype cq_qtype;
 			struct ionic_lif_logical_qtype eq_qtype;
 			__le16 stats_type;
-			u8 rsvd1[162];
+			u8 rsvd;
+			u8 rcq_sign_bit;
+			struct ionic_lif_logical_qtype srq_qtype;
+			u8 rsvd2;
+			u8 default_qp_transport_mode;
+			u8 rsvd1[146];
 		} __packed rdma;
 	} __packed;
 	__le32 words[478];
-- 
2.43.0


