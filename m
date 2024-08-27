Return-Path: <linux-rdma+bounces-4580-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A32E3960453
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 10:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E617B23860
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 08:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4BB155CA5;
	Tue, 27 Aug 2024 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="UM8guOoW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010052.outbound.protection.outlook.com [52.101.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E606554F87;
	Tue, 27 Aug 2024 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747008; cv=fail; b=AZGZOdG0+teAQiGrNdWNIXuW1SzQT+sosgnbcnfxDXkP+uOTJe0cjIOSMJ/nA5u6JGDXGSGKwVM1mOyxOoASIcGgZsjpwjTx22f6kq/K4vDCfgW1b8wyPzf3V09/84YdxVzKqpQsscql+v0yWbZYThxTMhK0HHYdgJ8SFxsJRkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747008; c=relaxed/simple;
	bh=NRjOLYsHmoYoLkZXC40QrOXAvRjcxHnBc7f9yjK5U+o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DrqWjvlcWyT2tKQbEA5UkScT4fEEGKaXlqwWFCvz4BEzBJAWAvadNBI8771d4PYP87mbE/RCl5ExIknUu5mH/TAZ9kzstxI0B7iBzVTbKmgS540ctMPLBG2Z8vWGVRjyPpFtwJsHGZNDUUQAwwzDigsej1viR6Vv1Wuto6b/X98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=UM8guOoW; arc=fail smtp.client-ip=52.101.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nae4R/lgQ0fYBA5+aTHh8avC14jkgZ08UEOv62L8p6vuUeBelxoYEX1wVDUwp7N5sQ5EQ04q7t3UT/3gpYuvuOcKzUXC1o0ktCNG6T04cEABoYNqcS8+TtskVD7eztvdm1cwlsBCyDbf8ru/Xul/pXjEDMrbMGfYOViAgIrUzVg4lHCWFcHHnDri/yIBjYzoFsNX3ZmG7uBjnSU8UE85UK3Rzs1kF5tX2Ee86NYl0vNomJMQWOpEfkBqHiToRnNE+Mt1/eBQ9utjICoJxEP7FJngDI4fCoxdYNNzMW97G1+1lloZIF7SiufVYyM5CD9I7PWZFgIKHHd4duUpZ2dxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjOE35ahxkDAV4TvRmTodkO0Jwlida8PtqiD5dDBKyM=;
 b=Xh9UtJIe5KrZoxxg+yB2/bjfVTcXuXWevMMTmq9YzkgsTf0JYbCIVtpR8nJaiyVLiy2awhqZv8tOj/WM61KCNOz/2X9GNe6u3WI/ymW2EV8qqEoja4MvsD0YvJMZBAbnk05dC4EGI+B3Qa906tnNIMdc/0B5uY6Juhrre63ik8mzXmcMazCbPDiKKmz+NLmcA+x8QL6GIxdukOLhCy58C4B7EYleLohhN49VWIYQrh2nbcLzueb+iCFhbwwdk6B7SorEyPfT5tjY0a3OZnHkXxSPE70NIDElwuOrEGbmbyyFvaOE2slNf5707ImbCyHw3aoWg/TYnXL/ur9Pc55XPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjOE35ahxkDAV4TvRmTodkO0Jwlida8PtqiD5dDBKyM=;
 b=UM8guOoWhOd+MA1gT/yCibLhbc1arqAWdS4UtYCRXINgfWKUmLJy+AEXwSOWsEKpupNlwPKDjW1bAl08Wk7NdrybAAik+Vvqb3q1Z9REdtvY1N+WbyVD7lmC10l66a+rfrvyvsywhK/5ti1yEBbdr218IHyNhOMfGeFzGzp3wHW+ve03klzYxHJcYxjVILHxlmzdxbhjOpKmh1tVN49Ke6RVkQe/Mg651NxHP+W9ck/qoGNJzZwvmzpaOvoV5pSYYeSi7us4ttmLrmGhLCa+Ikw+DjFD37CuXp7tcpLMUfW/rvRZPK+/5YF3wjvVexszL8KulRLVzqbEBzqC4uFDtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by SI2PR06MB4994.apcprd06.prod.outlook.com (2603:1096:4:1a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Tue, 27 Aug
 2024 08:23:17 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 08:23:17 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: dennis.dalessandro@cornelisnetworks.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] IB/qib: Use max() macro
Date: Tue, 27 Aug 2024 16:22:54 +0800
Message-Id: <20240827082254.72321-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:3:17::26) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|SI2PR06MB4994:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d87b6b-3262-46d0-62cc-08dcc6718060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UewmTxrJYBI5VCVZxNacNFUMOpAHXeGTjvEL+q7Q58hmGYL1rg760IFX9nUH?=
 =?us-ascii?Q?JzdGdcRcmD1KB6QAUnKi11KglOOgRUtCSQBzRyf79IA/BmahVrd6wnM9s+8U?=
 =?us-ascii?Q?mbxcJ9KzeQLjGmfc8GXxWpMWCYJYswOrCTSBYAgGLwlags5+wk7PsIWpRBTU?=
 =?us-ascii?Q?9OcSv4kTfA8HGWe7GFfc6uG3bvikLWnhWOzy/tu8BoN1rj8PKbA2/WLZ6BIS?=
 =?us-ascii?Q?T56l/Ju9fypHKaBjYHmaqXMu4RqdaroWTAi9YXIcYnCVf/A/gjej4s0H0aXy?=
 =?us-ascii?Q?E+OZyrB1oh7EYgf3Msibkv0DgKeKKsbD6sJ8n7AJCS2gUP0EPEWkFaYxBu0l?=
 =?us-ascii?Q?Y8HjLDwsGhYw8tUky339Ogh0VInZdmDhYs87T7QJAOmR9tOlc0kNVD2EZU61?=
 =?us-ascii?Q?51DNIFNPYICSn/iUT7WpBLt9Rn94RHYo5V+fnpgca0lmWxYgtvHNQDiKu6WF?=
 =?us-ascii?Q?xTXB1N33Y6tjHTzAFcvAgxPndH1UEiDMk7WH2b59Yd/fJ7k7uRs92D9IbJXN?=
 =?us-ascii?Q?sxYpYz9jGuCBknwGUHPdcctZ6rV/AFHthogcMjMW1VljpjBcc/3yEWVp8fos?=
 =?us-ascii?Q?My08GZJjKtFbMyqoT4Pp6PCuImt3yx0Hq4YzsjHLDzOy+8WaLbmSbZ5nzzkR?=
 =?us-ascii?Q?aVQzuXedgcIn6nWsodqBJi3rA81WzQO/A6+yP8VluEAQMY+lg07o9pfJbikC?=
 =?us-ascii?Q?tG3BKr7AD3+iHO1rW3bfdGJVGUhBWLaAkExL134F5N8y5g6l4tPIfnGnua0I?=
 =?us-ascii?Q?sTvHNYCVnuIRPvNWeeG1e5fvrtpZfKOEf03Ic3ivGTDfl/AReECeu8x/wi8B?=
 =?us-ascii?Q?7S0R362jhkQe32XyNaI44NdZXrObh+spJ0OKZAVZUwnkU7S9uIrXEsIyw+wT?=
 =?us-ascii?Q?jqEC6jX2OQE2afu/V8nOrDjinGB/sc410Ua5/q69MwP06oeUex7HNRC0J00A?=
 =?us-ascii?Q?nBjjp/u0D5412RPVgxXf+lepH3jCQghRZfIUtOeku/D4Xf0gqltxv9am4EpH?=
 =?us-ascii?Q?yN9L84YPOtB9dLhirKcRU6KVOQ/d3rOYUocqR9gl4xljdYB76FJ7bS7qoCOt?=
 =?us-ascii?Q?m1qKISXtCsjqhtqSwqQQ2ys8tb2tB4u0hsWw5ggdupJSq0n/68oezZpVpZdc?=
 =?us-ascii?Q?M3Q6zg7KXVsC+Fcw56onelyPEcpPfn4YQLBLBhDk+BbczQxT5DxlFfd6H9EN?=
 =?us-ascii?Q?2y7q/iXeonQZ3bFtJIhD7HF9pz/ptH9VhK5ST2I4UUkHJXG2P9GIz12hI9Yg?=
 =?us-ascii?Q?Rz2qW2Rx0yg9WW/M+Xgc+IAdySJHW/ZIPNbw7sRP0ZKYmcILhKNVAG3O2vwF?=
 =?us-ascii?Q?HKYUnJaef2MFvtnpFfI4xZQkOUtB+422j9DUjMzptIlq3+2U75wfO4W0lh++?=
 =?us-ascii?Q?hfCX/pR1+7Jg34fQvmrt2rRHvFTJkWz+yItm2AeUGcyFuaX8IQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0k23XhNgiYCq3+jSGEWCXa1iyM1DOOCsrMw4k1Qa0VPxBCoDDB0ABeV7WyOW?=
 =?us-ascii?Q?0EzTBgVfw4A/RDUj1l+uMKWj4hskI3ZA5BLHC4LcCWaswqs1jJmsdS32+IXA?=
 =?us-ascii?Q?LBhXUQtsJxhJlxxair8ayK04ovM97Qj6g6XlxCVG424lTOJFjoRBDHY2muWm?=
 =?us-ascii?Q?Nvu7UsLU9KU+8n/a6Ief9xhuSf+M/8qiwH3WgBk3Fb553l1qdi2G43Kaew+O?=
 =?us-ascii?Q?aMHB7UKbdP0eeoFk0cDWGfLKpvF1qartDUF1Ea3KlSRSbs5yXaFR934qbW/r?=
 =?us-ascii?Q?/rAp1yernitvyohPDDDL5DQyt12hOfYDmY8uE60hbAyuJDtRg3uhd5rfOgVV?=
 =?us-ascii?Q?jYW0x1TKCpoHwzHmX2B4V9QUeTtVPR3QX06zErn6tJDGVdQ5tMqaUAugfUBP?=
 =?us-ascii?Q?fNLZmCPX072rPSl3cUFZkjPwUOBFzr+zlQ4te2Ofto/imBp/1PQyzP10wW4U?=
 =?us-ascii?Q?Y50oyygEbuqP9NHx1AzeQ9RLcGwtIea/DMJ6HW7dEFoqFsOjxN73YBsX6Q7e?=
 =?us-ascii?Q?/81J0ByjBRBGj0/338KfcksNBgUYMrPx9ad214BhZ/Vt3zv5NcUZj/ru1mKX?=
 =?us-ascii?Q?k9p9TjFifexc3iVlzCtcctK46wRBFMzHhlwfta4L0qv+1Dn5iEdWTW/wLw7V?=
 =?us-ascii?Q?K8wcGnTgSclyoNzDu6sDfnGWwnuRV+LZqGUQ/mhxUHCMuWIwBy8azl2M7RGg?=
 =?us-ascii?Q?d9MNptS31o7octDJyq7GLG1Dzh4DjetasdQ+g2WV2AAaNh4kMulNQm1eAdIT?=
 =?us-ascii?Q?5Zt3Wyypo8jIcKMINzszwTrIoMHpSleHt48gDd7G1/JHyK+ZTzcbm+NV+lg+?=
 =?us-ascii?Q?KQf7G7KafzPwYlddbbvz0DpsQu0LY4QaCBvpa8nwXBYieKgdJWjlEieAnL9L?=
 =?us-ascii?Q?xhOn0/0uK5LEZtO3s8G8h5vNfbX6Xg/Xgu6Y1I+siGXHoI4dB89wI2n3VkQ0?=
 =?us-ascii?Q?2YPKD4Px8PIZnn+IQgoWoFh/GDj3sGePtEw8PF9b2r789UlsThwzDS/riR/W?=
 =?us-ascii?Q?D6Sgl7D34IuC80hbueBTM3DbZFmOlNoKxfM0TJBsHPshOaWXF2aw5v9Qpxsr?=
 =?us-ascii?Q?gGob4pQ8fBcttAn6hsH14cyySpWZ5n2YUgLLNI8xuEmqhZ32nOlR4b3x3jwq?=
 =?us-ascii?Q?4E79HMDb8kyrKyqbRmq5y7PMrv0Tp2KNQhLBaGZEPUYioqKwbo63dMvYFv2I?=
 =?us-ascii?Q?Wc7c1Oc9DQvhzdJGTAS+uk4O+Z0iYSTjyKsD9YpONVIW/x6iy/ThKqdl6pck?=
 =?us-ascii?Q?6Ac+CXIlhNMUvWt2lPkciaK9S6e05dpZBF1iZcbgvY3fjkyKxcxaOwPRLoJf?=
 =?us-ascii?Q?6jfra4rybulrvbYdyUslhql9+vwqblH7ZLUA6fzzq3Hfa7kNdQoCHVBCRC2v?=
 =?us-ascii?Q?Pc2rxcol8BNiwpuF4IF6uAzls3HOt7fWkpYcYWt4HTzXuG7743RtXiv+mQiN?=
 =?us-ascii?Q?u0Jd81LoasXOTkRyTwFNMRFDh5NwT3aQNxBprv8zRVhbjgcdJ5hQbiqT+MkC?=
 =?us-ascii?Q?gNutDgVLAAJOrS4nOyY6e3qEiGN/aFUEek4lcbiF+YdzR9rS4pK6XqKpdBWO?=
 =?us-ascii?Q?jOWicVwARCtdg6t18R+h37HNtxTGavp4G6XIzvGY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d87b6b-3262-46d0-62cc-08dcc6718060
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 08:23:16.8968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: binPTGOUrfgzlLZFfQQFqyitzmlzEpw3WaKshR2wZvgU7r2mSivAqa1SpoxBm8J9MEjCu1koRpu2Ku+FQm/ciw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4994

Use the max() macro to simplify the function and improve
its readability.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 drivers/infiniband/hw/qib/qib_iba7220.c | 2 +-
 drivers/infiniband/hw/qib/qib_iba7322.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_iba7220.c b/drivers/infiniband/hw/qib/qib_iba7220.c
index 78dfe98ebcf7..4c96b66a93b5 100644
--- a/drivers/infiniband/hw/qib/qib_iba7220.c
+++ b/drivers/infiniband/hw/qib/qib_iba7220.c
@@ -4094,7 +4094,7 @@ static int qib_init_7220_variables(struct qib_devdata *dd)
 	updthresh = 8U; /* update threshold */
 	if (dd->flags & QIB_HAS_SEND_DMA) {
 		dd->cspec->sdmabufcnt =  dd->piobcnt4k;
-		sbufs = updthresh > 3 ? updthresh : 3;
+		sbufs = max(updthresh, 3);
 	} else {
 		dd->cspec->sdmabufcnt = 0;
 		sbufs = dd->piobcnt4k;
diff --git a/drivers/infiniband/hw/qib/qib_iba7322.c b/drivers/infiniband/hw/qib/qib_iba7322.c
index 9db29916e35a..5a059ec08780 100644
--- a/drivers/infiniband/hw/qib/qib_iba7322.c
+++ b/drivers/infiniband/hw/qib/qib_iba7322.c
@@ -6633,7 +6633,7 @@ static int qib_init_7322_variables(struct qib_devdata *dd)
 	 */
 	if (dd->flags & QIB_HAS_SEND_DMA) {
 		dd->cspec->sdmabufcnt = dd->piobcnt4k;
-		sbufs = updthresh > 3 ? updthresh : 3;
+		sbufs = max(updthresh, 3);
 	} else {
 		dd->cspec->sdmabufcnt = 0;
 		sbufs = dd->piobcnt4k;
-- 
2.17.1


