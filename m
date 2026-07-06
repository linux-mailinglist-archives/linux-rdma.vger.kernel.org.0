Return-Path: <linux-rdma+bounces-22787-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kY2cJtjySmpyKAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22787-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 02:12:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8412C70BD11
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 02:12:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wdc.com header.s=dkim.wdc.com header.b=WqlEtY3C;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.s=selector2-sharedspace-onmicrosoft-com header.b=fGrQZWzS;
	dmarc=pass (policy=quarantine) header.from=wdc.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22787-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22787-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E2623007AFB
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2026 00:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0B870836;
	Mon,  6 Jul 2026 00:12:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B6A381AF;
	Mon,  6 Jul 2026 00:11:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783296720; cv=fail; b=WNy50CUnD0b23OJ0aRfFn0R/PCXy31K/7qqiZr9EFi4iBLYU/GyKSR/7NlNGj3738IwvHPSEYLsvhk55UoczeE07Z6QCoTD7XbYSduQzcmJ7rW+6sR36gk++AOqM6qhgU7dI/ApTxIE3mxJUbf3hl0hpxuKrxBsU3yEgNN0CgMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783296720; c=relaxed/simple;
	bh=+njp04PlusapcbT2E6P5aQWYlJDtucE1fGpJAeCeWsY=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=hivQtuysnl3oLLEXl8m0Wy/UyYr+1iEFjZcXASFaTQv23ZVnJkHw43w3A3l35zDVuUWvdu+PXD2HsxSC6eS9ri7sncEQpn1QRE3ljsJ6bgZxY9zHWliMIyoF+3uDXrRJqDAZd/8sC+i2wWYg2YzYvwAmPRpjf723i6iqD4TJJaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WqlEtY3C; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fGrQZWzS; arc=fail smtp.client-ip=216.71.154.45
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1783296717; x=1814832717;
  h=date:from:to:subject:message-id:mime-version;
  bh=+njp04PlusapcbT2E6P5aQWYlJDtucE1fGpJAeCeWsY=;
  b=WqlEtY3COQz1wzrZHTbdUdE+QTg+9OpnavSJJJtOvKIM9yuamUBYjtCa
   TbxRLF5L143Pbdi/4u2m0mfD/nL8fk+11FWPtnpUKHJBlay9txspJ6pIv
   I3478X3CI41at6hRRM6Fd8pBjFhmzF78+Hs1xePP6kqVSiY6K8kA/lTMC
   rou03KGUySdvcYoPxOQq6WkAWtdG2nFbiT0VYZN9cwQFi+V4qzyeoE1v9
   eXwHWQMluQhssUw5A6Pjxb5WXvXrxBktw9rt/loM19CNGsLnhLzUOLCzx
   x89hs1QBLI6r0QGaj1Efvq3t0yWO7oeOmpqYRN5PU5Mhl8ZYM7uo6HM4B
   g==;
X-CSE-ConnectionGUID: doPPPwWARmSoUt8P/Y40PA==
X-CSE-MsgGUID: DRTKwSciQK6BmpqkBlovLg==
X-IronPort-AV: E=Sophos;i="6.25,149,1779120000"; 
   d="scan'208";a="148899660"
Received: from mail-westcentralusazon11010018.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.18])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jul 2026 08:10:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HI0ejUkmE4Riz3TvLluZ+kVmAp1Ajh6kTH0LAKTjUaQXLljXyk7Ea3GwVprZ6nVpp6L5ykED+Po+CS3ry2VnSG5Ctqbo8fxvTt92p8VASpxkauE2OcCtjMICfseAeSnE0D1Py7I5zUwIi6HkNuvLbTZbQ1v8iNMMJpbmc/GkTkpXGtQLdr8x8b9OIDwLvcJZGJFl21SRZ9H95KbKsLfzZni34YxWy6uyWFx8ohijFvCebKvVGyvlyZ5aXSSjG2uu/9l1x1taOP12ahlGfsJaw9ffE07JktK0Vq9R1/S1f5yes1Msi1g5J8CAbXOtWA95JDQpWNTyyNIJo/qul2DIjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJzjKRU1lo3YgJ2hd16H9YcpvvNNA9ad9yYXEY29Zjo=;
 b=aa2nAiQPLyPr52hnGiPVwV9fhXViRKAxpRjwdV4zPMLILdmt4fsZISaTirkw3bGxOcfxWtBUS3zdoPuN2GAJC1zQq9QcwesvFsQJKnkz2kwp+/cTZb6z4IdFFopXc2Za5r0oVcF8CzF1e5vE2cREonZ8eZjT6DEHZFNzxaqY9SGvgVNIILJ2WVuTsbg+Cg8umsm6vFCGCJ+A7AF3U0nFQUAMqmQOdzTCbFfT7yOaTlPecSbV1S2yEtM4TLD4ckI9M3KI5f0KC9+sgjZBA4IyBYQ9g3HCrswO8kmCGTMfxg2vRs+Q4CqtKlz2ILBqd6KYGZRFGzScWE08ye11DMUnAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJzjKRU1lo3YgJ2hd16H9YcpvvNNA9ad9yYXEY29Zjo=;
 b=fGrQZWzS1R0WlOhBMDkyRaMEIqNJ0bCfbyiozeSF6o/abf++RvAAfBbg/Mdow9fqHExqXAAD0+yrFNnRl18yYpWEMowrS2MCPF1RiWBERXvYcCnhSOjBJ5heqQ7DU710hXGkIKkEOUS0c7ctgtRMpVm0j4Dzvp0TQqawHFnspr0=
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA2PR04MB7657.namprd04.prod.outlook.com
 (2603:10b6:806:14e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 00:10:46 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 00:10:46 +0000
Date: Mon, 6 Jul 2026 09:10:40 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	nbd@other.debian.org, linux-rdma@vger.kernel.org
Subject: blktests failures with v7.2-rc1 kernel
Message-ID: <akryKgCjof_7d9na@shinmob>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: TY6P286CA0032.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::16) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SA2PR04MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: bff3cdd8-f269-4a3e-34c1-08dedaf306d2
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|23010399003|56012099006|11063799006|5023799004|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	57vVa4BeEeXR3Y9cZwkKZ3/h0xnHygrlCBbmkkcQRrh5UjvPPGE1la16mVWSsOZFfWIK/IvYRonS2w90XlPePNK/UuBfOcMtR4TwIo+ExIh4/TCv+90EcqU+GFMZqljlmi6vX9UmQnUhK47JIqzoeHdG27nCn9pmOKOIgHKAZBT7O05xNlyUglVVth0znMQ+f7qD13P0lmyDtuK89ZbzWRXERGpe83uf0G5ZLNtrL9fyVWQfg5/etqhtnUHlhXUD9ElMbSaKObVZUqf+cMcXU30rOUigUqLU3d8MlQbZYjosqjBRrEf7XKyCoMpzwM2qxchlDrykFJiNgPv19tRfRwZIx58b5RK3bGgYPTdgOUVHvnIK7g5f+Hxt7Xb8Vf+nxQQJCFvERamJTEGS59nh1hyVbdzO0LYW7B2uk06jVRPktuYseoQtjrNJvvRmMVLOXAf9zeY4X7tUJW0SR5sd0u9SReWh6dxhXu70s8fh3rsJ7So7FjSRPK9y1noKUJ52gTKpa0M3PCi8IRgxMwh4pCkmJ8kSzwnaTyLrwpJkwvYaOUA0ET4ira0D33xGXVFHlK+fNQ+ryUhjawQEHHUT/LI6/hRa+dHdHP/2wY8QFQadeyuQGcvOZRu9zhYnVcpibJF5eiws1SdVUVUPpP+Dh22z9xJ86Ou/0BrdHspLXXs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(5023799004)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nE1371s4WgKRuz/JqccCtCk+WcJvo0TRoeRNNWU1pSS9vQlqGJuX1cChUHQd?=
 =?us-ascii?Q?td09MqdPqmmKgupcRsG93QNp5qJ5QlnSJFe/hjS+o9kmjPzFir2MU4Fg5QHg?=
 =?us-ascii?Q?W1GyHeXKky7xrfrijMVVUPfnsbBL6fx7XxhhymZSyD6FnXCkqH67jiU51fnf?=
 =?us-ascii?Q?fh1lFV4x8hq2FxX/giBfx780tAkph+sk5OWK5oraA0nU4tc886qpjtHD8hE6?=
 =?us-ascii?Q?jvIk8EJndu7T6eZVP4M0CjKzHO9gA/kgeEYxJ31CWbnlKPvKmpiBgw6CQvet?=
 =?us-ascii?Q?JJA/dW2mBbDChZoykk0fKRMcgmZ/ErlS7eLYBSzbRi9uH6tr6CbyITQTjd/h?=
 =?us-ascii?Q?eSH1GFYYgqU1Fs0t2WbZqgI1XhaQhC9EfQa0I8OV0KunipjPWppZgcfODuaR?=
 =?us-ascii?Q?qV1bUDmpuSk9OvPzl+/nW5F4KlLzmE1lS6/rWBhFDIGWnOv9OKWPZg096CKn?=
 =?us-ascii?Q?sv9HjWTahwN4axkEDOVgbCrwiCGNO8s9oqbzLagH27UmFYmIwjsbayxAR/4Y?=
 =?us-ascii?Q?x3lzf3pbERkZCshez8Bi1WAFjr6QA2/fDxOJwvQsQpb7LAyaf+pJdn+UGwt7?=
 =?us-ascii?Q?axobKcx51XlxDM6u6sJ0Zu3UFdo1PrbJLCLLIon05r0ki3oygO3OI3cnTcmo?=
 =?us-ascii?Q?ElM4J4I/YxsJAnDwpVx3ZbXz8NoCLmhtPEf6culGHGLB+y4DpM1LUwbcuL+L?=
 =?us-ascii?Q?kM7kgqZ1GqtLOF8+Dl3UWQzd3Rl5ciEAtwZR9tLfXuRNnEJ5mfWaj1EbDGHW?=
 =?us-ascii?Q?DqnK7oQo0QcvPeZ0AQ82ZNjuTctXXHUu6NKbl4VNOJ/40gEMSJ8VxOZRRhdU?=
 =?us-ascii?Q?11QAlSOx5aHVAI3DATlX7UY2jc+RtY3AO0bfZ1Zzxtnu8absbRDy620wwFWE?=
 =?us-ascii?Q?O90p0Nzh2uf/JLZ3mtMb8Z2tWuJcXRuY4P7I1pYxdkuec3Lej3AwmLSoQJTo?=
 =?us-ascii?Q?MFffOztZ9GzYddJuCuOSFQ6LNBg6/THh9Hzlvjgnihi+FywN3IF7atvFJi1u?=
 =?us-ascii?Q?YUiWUPMWMqVFMfc3Lbl3zXLkmtM+kEDdnC5Q2kRWz3GkIEytQ/0hVxC8Uuwh?=
 =?us-ascii?Q?fZ6q5ZPxlYHPVklh8+L1l3u6R664SMwrG340UI55Ebk/YMYqtC3eobWXHT1u?=
 =?us-ascii?Q?0Qo96tdSV2/PlkQ/JMHR6GZHN96S1jRrXGPEcidZ/7qjsKcNc8y909JbHFSp?=
 =?us-ascii?Q?gT5UByysMz0Yucex0TCu/ZRdyHtVVdngS/zsL4Ra8g1F2UR065mTe/cT0Ztk?=
 =?us-ascii?Q?2kUUEY8djyX22WX6lHx7jMsUx9/GH+zp0WMdudvGDT6Two3j9QkScfOjo/9I?=
 =?us-ascii?Q?0BSpNt60BBvsIyw0Sjh7c72yDSkQXMjARhv2cO6RBSnbBBM0lqhtA+u2HgYU?=
 =?us-ascii?Q?9Eu9LQlTbH7fHtmnFRYxxabGd4cJXIvFhxMLw0T56fRT+LqW+xfJJc19tcip?=
 =?us-ascii?Q?hwhIXXN/Kw1xLQiBEzJoMUzL06Rab3TE1bsQrpwSkKY8ANkVIYXdkD1QTrY0?=
 =?us-ascii?Q?ZhSEpXFEp3OpfEllvCC5M+PpKUyflx8ONqm2nCJu66fwlGGLnaW3Ajdf0MPc?=
 =?us-ascii?Q?Olwpo2AnRi1GmXBDfjkCMqtkQYZD856rWIyGEoP5xtWhVgRuY6nC/zMJyxIu?=
 =?us-ascii?Q?BQ1C7xQEDRgSJyHvvw75AgJH0bp063KAf8SK7Tey/B672x+iRbPqEz87HlkU?=
 =?us-ascii?Q?7y7PZtrP8ZnfKjtcuDmVQTZlEfkqnrRELyyZqA2KFcHES8Dk/QMhk3eLqZgd?=
 =?us-ascii?Q?16BxPKGoADD7BVl7HBSoF+akmbdufxc=3D?=
X-Exchange-RoutingPolicyChecked:
	XaV9I7R1LR+0DZs/wLeUbgtQayBjK3zqB1HXXp3Tx7uTC9+63Xu5Se0NiKpYfQs54SYl1CPzFu69XM34dWwlBiC04P/gQ7ZWTWnkW9AWH4PA/+S1RcENAYh0rItTJO2ZhJnlQHvgpqgpQA72q6OnQxo8i2P9EpT12KViZFTgdr9oZub/yBOpHYtJlansY0qps1WUTn4bTelU0sS5vH3GHPZ0SzBprn288A2vpmnz0ekt1jbMhTYj/jiViQEofS82wpEE+rgXuAwXmPV+G6XiXghDm/sbejMjk12iJHU/XtSeDAs6K8PYh+t+icuvqMrG11gsBOLLRduURAixz6gDFg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lzEbQCiGKTlInkonm5Nx9gNmoCHGOeRr8IG4CRW2dGi/dy3gnQfeIJ/RNdDnVydzBs9usZsTjebZaYHI00RKy1KDuPpAazRA5GlFvJLZ+4MfQev5yTdWmBCMjM4nKiro0hmUDuLYclb0ijDtPijxrtZgoH3ZOXeJ/he0KSehrWBv6DZ0OFehtGC3ju/EzpvwyeGjP712E32noJwD7L1/I04miXAkPlHMTYRCeQ7m8/7RsIfsv1ts88PbOGIaJQZCiM1QkVOjNJgj2wecMNFt5kkGiyU3yr38qNgPU/UFOALbfP5l9J/GqUe1noqJmLkuC25LBpBdnXpVQ3HkJ7FwuXPFGS/xw/Jm2p5fXt/Zxa25t51k+Q4NYgg78Bi/JERCzojg/7O6SV8Y5hWt3IhiNKPfvEBleUvyX/11P1F/gDr6L9xOAUvypaIKSrgb57TMBn/YPD5CbBme2b/2kmWbBCpr5Ey7G6+bdDew5H1ZvBm2k8bwAgMD1IDLf5UXWRQSSOHcsGe4VdipZ7oU72d5KyMFYhKJjB7kT9SK9K7w0Huk3CyK3YHDZ0WDocPbkSDg0h6yvzLlbRshFErkNKaIk5NFoG4IcRpl+Jkyz0aU37oR6pVK1Zr+jEoSFf6V4t07
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff3cdd8-f269-4a3e-34c1-08dedaf306d2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 00:10:46.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2mry0QgmFp7JGCQm/iROtg78juJ/bFSMIpbja/aD2uusTNIjr42DMBEdba0x8hLxhmcjdU043/w7srHSnhR6H40A/5wtQY3pPI7bXEZeao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7657
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22787-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-block@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-scsi@vger.kernel.org,m:nbd@other.debian.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[shinichiro.kawasaki@wdc.com,linux-rdma@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shinichiro.kawasaki@wdc.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sharedspace.onmicrosoft.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8412C70BD11

Hi all,

I ran the latest blktests (git hash: 34941855abbf) with the v7.2-rc1 kernel. I
observed 6 failures listed below. Comparing with the previous report for the
v7.1 kernel [1], 4 failures are no longer observed (nvme/005, nvme/060, nvme/061
fc transport and nbd/002), and 1 failure is new (nvme/033,036,037). Your help
with fixes will be appreciated as always.

[1] https://lore.kernel.org/linux-block/ajtk1CaN1pBreS4O@shinmob/


List of failures
================
#1: block/005
#2: nvme/033,036,037 (new)
#3: nvme/058 (fc transport)(kmemleak)
#4: nvme/061 (rdma transport, siw driver)(kmemleak)
#5: nvme/062 (tcp transport)
#6: nvme/063 (tcp transport)


Failure description
===================

#1: block/005

    The test case block/005 failed under some conditions due to concurrent
    writes to a sysfs IO scheduler attribute. A fix patch candidate is
    available [2].

    [2] https://lore.kernel.org/linux-block/20260626004221.711326-1-shinichiro.kawasaki@wdc.com/

#2: nvme/033,036,037 (new)

    The test cases nvme/033, 036 and 037 failed when TEST_DEV specifies a NVMe
    device with metadata. The failure was triggered by the kernel commit
    c8cdecdb47d3 ("nvme: core: reject invalid LBA data size from Identify
    Namespace"). After the commit, NVMEoF target passthru no longer makes block
    device available for namespaces with metadata. Assuming this kernel behavior
    change is expected, I prepared a blktests side patch to avoid the failures
    [3].

    [3] https://lore.kernel.org/linux-nvme/20260630113714.848831-1-shinichiro.kawasaki@wdc.com/


#3: nvme/058 (fc transport)(kmemleak)

    When the kernel enables CONFIG_DEBUG_KMEMLEAK, the test case sometimes
    causes kmemleak. The memory leak report with v7.2-rc1 kernel looks similar
    to those I reported for v7.0-rc1 kernel [4].

    [4] https://lore.kernel.org/linux-block/aZ_-cH8euZLySxdD@shinmob/

#4: nvme/061 (rdma transport, siw driver)(kmemleak)

    When the test case nvme/061 is repeated twice for the rdma transport and the
    siw driver on the kernel with CONFIG_DEBUG_KMEMLEAK enabled, it causes
    kmemleak that is detected at the beginning of the 2nd run. A fix candidiate
    series is posted [5].

    [5] https://lore.kernel.org/linux-nvme/20260629051529.810925-1-shinichiro.kawasaki@wdc.com/

#5: nvme/062 (tcp transport)

    The test case nvme/062 fails for tcp transport due to the lockdep WARN
    related to the three locks root->kernfs_rwsem, sparse_irq_lock and
    root->kernfs_supers_rwsem [6]. The same failure symptom was also observed
    with v7.1 with a fix patch [1].

    This test case failed with another similar symptom with v7.1 kernel as
    reported [1], and a fix discussion is ongoing [7].

    [7] https://lore.kernel.org/linux-nvme/cover.1782436781.git.liuxixin@kylinos.cn/

#6: nvme/063 (tcp transport)

    The test case nvme/063 fails for tcp transport due to the lockdep WARN
    related to the three locks set->srcu, q->q_usage_counter(io) and
    q->elevator_lock. Refer to [1] for the details of the failure.


[6] nvme/062 dmesg with tcp transport

[   63.220556] [   T1033] run blktests nvme/062 at 2026-07-05 17:24:37
[   63.483614] [   T1144] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   63.525274] [   T1147] nvmet: Allow non-TLS connections while TLS1.3 is enabled
[   63.539092] [   T1150] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[   63.684385] [    T327] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   63.696587] [   T1157] nvme nvme5: creating 4 I/O queues.
[   63.704345] [   T1157] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[   63.721305] [   T1157] nvme nvme5: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[   64.282423] [   T1211] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[   64.853510] [    T327] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349, TLS.
[   64.861282] [   T1218] nvme nvme5: creating 4 I/O queues.
[   64.919781] [   T1218] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[   64.941335] [   T1218] nvme nvme5: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[   65.502530] [   T1289] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[   65.873248] [   T1302] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   65.935059] [   T1308] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[   66.128024] [   T1315] nvme_tcp: queue 0: failed to receive icresp, error -104

[   66.134922] [   T1315] ======================================================
[   66.135319] [   T1315] WARNING: possible circular locking dependency detected
[   66.135756] [   T1315] 7.2.0-rc1 #14 Not tainted
[   66.136089] [   T1315] ------------------------------------------------------
[   66.136506] [   T1315] nvme/1315 is trying to acquire lock:
[   66.136826] [   T1315] ffff88810092b180 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_remove_by_name_ns+0x53/0x160
[   66.137495] [   T1315] 
                          but task is already holding lock:
[   66.137997] [   T1315] ffff88810092b2a0 (&root->kernfs_supers_rwsem){++++}-{4:4}, at: kernfs_remove_by_name_ns+0x4b/0x160
[   66.138597] [   T1315] 
                          which lock already depends on the new lock.

[   66.139232] [   T1315] 
                          the existing dependency chain (in reverse order) is:
[   66.139794] [   T1315] 
                          -> #9 (&root->kernfs_supers_rwsem){++++}-{4:4}:
[   66.140329] [   T1315]        down_read+0xa6/0x540
[   66.140624] [   T1315]        kernfs_remove_by_name_ns+0x4b/0x160
[   66.140989] [   T1315]        remove_files+0x8d/0x1b0
[   66.141849] [   T1315]        sysfs_remove_group+0x78/0x170
[   66.142749] [   T1315]        sysfs_remove_groups+0x63/0xd0
[   66.143640] [   T1315]        __kobject_del+0x7d/0x1e0
[   66.144513] [   T1315]        kobject_del+0x34/0x60
[   66.145332] [   T1315]        free_desc+0x23a/0x2a0
[   66.146148] [   T1315]        irq_free_descs+0x4d/0x70
[   66.146984] [   T1315]        msi_domain_free_locked.part.0+0x492/0x690
[   66.147900] [   T1315]        msi_domain_free_irqs_all_locked+0xe9/0x140
[   66.148826] [   T1315]        pci_free_msi_irqs+0x12/0x90
[   66.149837] [   T1315]        pci_disable_msix+0xab/0xf0
[   66.150808] [   T1315]        pci_free_irq_vectors+0x12/0xd0
[   66.151775] [   T1315]        nvme_setup_io_queues+0x5d6/0x16c0 [nvme]
[   66.152802] [   T1315]        nvme_probe.cold+0x30f/0x65a [nvme]
[   66.153809] [   T1315]        local_pci_probe+0xdf/0x190
[   66.154710] [   T1315]        pci_call_probe+0x160/0x6d0
[   66.155656] [   T1315]        pci_device_probe+0x179/0x2f0
[   66.156557] [   T1315]        really_probe+0x1ed/0x900
[   66.157365] [   T1315]        __driver_probe_device+0x1af/0x400
[   66.158182] [   T1315]        driver_probe_device+0x4a/0xd0
[   66.158996] [   T1315]        __driver_attach_async_helper+0x10b/0x280
[   66.159849] [   T1315]        async_run_entry_fn+0x93/0x550
[   66.160653] [   T1315]        process_one_work+0x8b6/0x15e0
[   66.161436] [   T1315]        worker_thread+0x5fd/0xfe0
[   66.162191] [   T1315]        kthread+0x36a/0x460
[   66.162902] [   T1315]        ret_from_fork+0x655/0x9d0
[   66.163636] [   T1315]        ret_from_fork_asm+0x1a/0x30
[   66.164381] [   T1315] 
                          -> #8 (sparse_irq_lock){+.+.}-{4:4}:
[   66.165611] [   T1315]        __mutex_lock+0x1ae/0x2510
[   66.166330] [   T1315]        cpuhp_bringup_ap+0x52/0x950
[   66.167053] [   T1315]        cpuhp_invoke_callback+0x2c5/0x11f0
[   66.167833] [   T1315]        __cpuhp_invoke_callback_range+0xb6/0x1e0
[   66.168651] [   T1315]        _cpu_up+0x2eb/0x6d0
[   66.169355] [   T1315]        cpu_up+0x111/0x190
[   66.170017] [   T1315]        cpuhp_bringup_mask+0xd3/0x110
[   66.170787] [   T1315]        smp_init+0x27/0xe0
[   66.171556] [   T1315]        kernel_init_freeable+0x442/0x710
[   66.172363] [   T1315]        kernel_init+0x18/0x150
[   66.173036] [   T1315]        ret_from_fork+0x655/0x9d0
[   66.173754] [   T1315]        ret_from_fork_asm+0x1a/0x30
[   66.174454] [   T1315] 
                          -> #7 (cpu_hotplug_lock){++++}-{0:0}:
[   66.175644] [   T1315]        cpus_read_lock+0x3c/0xe0
[   66.176327] [   T1315]        static_key_disable+0x12/0x30
[   66.176988] [   T1315]        inet_hash+0xf3/0xd00
[   66.177628] [   T1315]        inet_csk_listen_start+0x350/0x440
[   66.178345] [   T1315]        __inet_listen_sk+0x191/0x650
[   66.178989] [   T1315]        inet_listen+0x9a/0xe0
[   66.179612] [   T1315]        __sys_listen+0x85/0x100
[   66.180266] [   T1315]        __x64_sys_listen+0x4e/0x90
[   66.180909] [   T1315]        do_syscall_64+0xdf/0x790
[   66.181583] [   T1315]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   66.182334] [   T1315] 
                          -> #6 (sk_lock-AF_INET){+.+.}-{0:0}:
[   66.183509] [   T1315]        lock_sock_nested+0x32/0xf0
[   66.184200] [   T1315]        tls_sw_sendmsg+0x1ba/0x2a50 [tls]
[   66.184987] [   T1315]        sock_sendmsg+0x31c/0x3f0
[   66.185725] [   T1315]        nvmet_tcp_try_recv_pdu+0x14e3/0x1ce0 [nvmet_tcp]
[   66.186646] [   T1315]        nvmet_tcp_io_work+0x122/0x2420 [nvmet_tcp]
[   66.187507] [   T1315]        process_one_work+0x8b6/0x15e0
[   66.188285] [   T1315]        worker_thread+0x5fd/0xfe0
[   66.189029] [   T1315]        kthread+0x36a/0x460
[   66.189800] [   T1315]        ret_from_fork+0x655/0x9d0
[   66.190561] [   T1315]        ret_from_fork_asm+0x1a/0x30
[   66.191288] [   T1315] 
                          -> #5 (&ctx->tx_lock){+.+.}-{4:4}:
[   66.192530] [   T1315]        __mutex_lock+0x1ae/0x2510
[   66.193218] [   T1315]        tls_sw_sendmsg+0x12e/0x2a50 [tls]
[   66.193921] [   T1315]        sock_sendmsg+0x31c/0x3f0
[   66.194585] [   T1315]        nvme_tcp_try_send_cmd_pdu+0x60e/0xcc0 [nvme_tcp]
[   66.195394] [   T1315]        nvme_tcp_try_send+0x1ef/0xa60 [nvme_tcp]
[   66.196145] [   T1315]        nvme_tcp_queue_rq+0xfa3/0x19e0 [nvme_tcp]
[   66.196894] [   T1315]        blk_mq_dispatch_rq_list+0x3e0/0x2400
[   66.197614] [   T1315]        __blk_mq_sched_dispatch_requests+0x20a/0x15d0
[   66.198407] [   T1315]        blk_mq_sched_dispatch_requests+0xab/0x150
[   66.199170] [   T1315]        blk_mq_run_hw_queue+0x1d9/0x590
[   66.199885] [   T1315]        blk_execute_rq+0x189/0x390
[   66.200574] [   T1315]        __nvme_submit_sync_cmd+0x104/0x320 [nvme_core]
[   66.201411] [   T1315]        nvmf_connect_io_queue+0x1fa/0x320 [nvme_fabrics]
[   66.202251] [   T1315]        nvme_tcp_start_queue+0x7bf/0xc20 [nvme_tcp]
[   66.203030] [   T1315]        nvme_tcp_setup_ctrl.cold+0x6ed/0xd2d [nvme_tcp]
[   66.203909] [   T1315]        nvme_tcp_create_ctrl+0x874/0xc20 [nvme_tcp]
[   66.204786] [   T1315]        nvmf_dev_write+0x40b/0x830 [nvme_fabrics]
[   66.205695] [   T1315]        vfs_write+0x1cc/0xf40
[   66.206438] [   T1315]        ksys_write+0x112/0x250
[   66.207162] [   T1315]        do_syscall_64+0xdf/0x790
[   66.207937] [   T1315]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   66.208773] [   T1315] 
                          -> #4 (set->srcu){.+.+}-{0:0}:
[   66.210039] [   T1315]        __synchronize_srcu+0xe1/0x2f0
[   66.210750] [   T1315]        elevator_switch+0x2bd/0x670
[   66.211429] [   T1315]        elevator_change+0x2e7/0x500
[   66.212104] [   T1315]        elevator_set_none+0xaa/0xf0
[   66.212783] [   T1315]        blk_unregister_queue+0x15e/0x2e0
[   66.213527] [   T1315]        __del_gendisk+0x28f/0xaa0
[   66.214237] [   T1315]        del_gendisk+0x11a/0x1c0
[   66.214913] [   T1315]        nvme_ns_remove+0x331/0x9e0 [nvme_core]
[   66.215729] [   T1315]        nvme_remove_namespaces+0x289/0x3f0 [nvme_core]
[   66.216589] [   T1315]        nvme_do_delete_ctrl+0xf6/0x160 [nvme_core]
[   66.217431] [   T1315]        nvme_delete_ctrl_sync.cold+0x8/0xd [nvme_core]
[   66.218321] [   T1315]        nvme_sysfs_delete+0xba/0xe0 [nvme_core]
[   66.219120] [   T1315]        kernfs_fop_write_iter+0x3d6/0x5e0
[   66.219874] [   T1315]        vfs_write+0x4b3/0xf40
[   66.220615] [   T1315]        ksys_write+0x112/0x250
[   66.221389] [   T1315]        do_syscall_64+0xdf/0x790
[   66.222148] [   T1315]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   66.222978] [   T1315] 
                          -> #3 (&q->elevator_lock){+.+.}-{4:4}:
[   66.224209] [   T1315]        __mutex_lock+0x1ae/0x2510
[   66.224904] [   T1315]        elevator_change+0x197/0x500
[   66.225608] [   T1315]        elv_iosched_store+0x38f/0x430
[   66.226418] [   T1315]        queue_attr_store+0x25f/0x3e0
[   66.227141] [   T1315]        kernfs_fop_write_iter+0x3d6/0x5e0
[   66.227917] [   T1315]        vfs_write+0x4b3/0xf40
[   66.228607] [   T1315]        ksys_write+0x112/0x250
[   66.229308] [   T1315]        do_syscall_64+0xdf/0x790
[   66.229971] [   T1315]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   66.230748] [   T1315] 
                          -> #2 (&q->q_usage_counter(io)){++++}-{0:0}:
[   66.232002] [   T1315]        blk_alloc_queue+0x605/0x7a0
[   66.232701] [   T1315]        blk_mq_alloc_queue+0x168/0x270
[   66.233442] [   T1315]        scsi_alloc_sdev+0x8df/0xd10
[   66.234116] [   T1315]        scsi_probe_and_add_lun+0x5bd/0xbf0
[   66.234870] [   T1315]        __scsi_add_device+0x233/0x280
[   66.235679] [   T1315]        ata_scsi_scan_host+0x137/0x3a0
[   66.236433] [   T1315]        async_run_entry_fn+0x93/0x550
[   66.237161] [   T1315]        process_one_work+0x8b6/0x15e0
[   66.237927] [   T1315]        worker_thread+0x5fd/0xfe0
[   66.238700] [   T1315]        kthread+0x36a/0x460
[   66.239387] [   T1315]        ret_from_fork+0x655/0x9d0
[   66.240142] [   T1315]        ret_from_fork_asm+0x1a/0x30
[   66.240930] [   T1315] 
                          -> #1 (fs_reclaim){+.+.}-{0:0}:
[   66.242127] [   T1315]        fs_reclaim_acquire+0xd5/0x120
[   66.242842] [   T1315]        kmem_cache_alloc_lru_noprof+0x6f/0x6d0
[   66.243694] [   T1315]        alloc_inode+0x9d/0x1e0
[   66.244399] [   T1315]        iget_locked+0x19d/0x630
[   66.245091] [   T1315]        kernfs_get_inode+0x42/0x440
[   66.245842] [   T1315]        kernfs_get_tree+0x5d0/0xbd0
[   66.246588] [   T1315]        vfs_get_tree+0x87/0x2f0
[   66.247292] [   T1315]        fc_mount+0x16/0x220
[   66.247945] [   T1315]        path_mount+0x854/0x1d10
[   66.248660] [   T1315]        __x64_sys_mount+0x208/0x270
[   66.249379] [   T1315]        do_syscall_64+0xdf/0x790
[   66.250052] [   T1315]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   66.250848] [   T1315] 
                          -> #0 (&root->kernfs_rwsem){++++}-{4:4}:
[   66.252094] [   T1315]        __lock_acquire+0xe20/0x2440
[   66.252777] [   T1315]        lock_acquire+0x199/0x320
[   66.253468] [   T1315]        down_write+0x8c/0x1f0
[   66.254123] [   T1315]        kernfs_remove_by_name_ns+0x53/0x160
[   66.254908] [   T1315]        sysfs_unmerge_group+0xd5/0x160
[   66.255691] [   T1315]        dev_pm_qos_hide_latency_tolerance+0x1f/0x60
[   66.256563] [   T1315]        nvme_uninit_ctrl+0x8f/0x110 [nvme_core]
[   66.257376] [   T1315]        nvme_tcp_create_ctrl+0x887/0xc20 [nvme_tcp]
[   66.258083] [   T1315]        nvmf_dev_write+0x40b/0x830 [nvme_fabrics]
[   66.258878] [   T1315]        vfs_write+0x1cc/0xf40
[   66.259581] [   T1315]        ksys_write+0x112/0x250
[   66.260218] [   T1315]        do_syscall_64+0xdf/0x790
[   66.260892] [   T1315]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   66.261703] [   T1315] 
                          other info that might help us debug this:

[   66.263435] [   T1315] Chain exists of:
                            &root->kernfs_rwsem --> sparse_irq_lock --> &root->kernfs_supers_rwsem

[   66.265397] [   T1315]  Possible unsafe locking scenario:

[   66.266612] [   T1315]        CPU0                    CPU1
[   66.267323] [   T1315]        ----                    ----
[   66.268043] [   T1315]   rlock(&root->kernfs_supers_rwsem);
[   66.268760] [   T1315]                                lock(sparse_irq_lock);
[   66.269614] [   T1315]                                lock(&root->kernfs_supers_rwsem);
[   66.270486] [   T1315]   lock(&root->kernfs_rwsem);
[   66.271166] [   T1315] 
                           *** DEADLOCK ***

[   66.272829] [   T1315] 3 locks held by nvme/1315:
[   66.273499] [   T1315]  #0: ffffffffc1ad8260 (nvmf_dev_mutex){+.+.}-{4:4}, at: nvmf_dev_write+0x82/0x830 [nvme_fabrics]
[   66.274619] [   T1315]  #1: ffffffff9ed0e3a0 (dev_pm_qos_sysfs_mtx){+.+.}-{4:4}, at: dev_pm_qos_hide_latency_tolerance+0x17/0x60
[   66.275819] [   T1315]  #2: ffff88810092b2a0 (&root->kernfs_supers_rwsem){++++}-{4:4}, at: kernfs_remove_by_name_ns+0x4b/0x160
[   66.276970] [   T1315] 
                          stack backtrace:
[   66.278139] [   T1315] CPU: 2 UID: 0 PID: 1315 Comm: nvme Not tainted 7.2.0-rc1 #14 PREEMPT(full) 
[   66.278141] [   T1315] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-10.fc44 06/10/2025
[   66.278143] [   T1315] Call Trace:
[   66.278147] [   T1315]  <TASK>
[   66.278152] [   T1315]  dump_stack_lvl+0x6a/0x90
[   66.278156] [   T1315]  print_circular_bug.cold+0x189/0x1eb
[   66.278160] [   T1315]  check_noncircular+0x173/0x1a0
[   66.278164] [   T1315]  __lock_acquire+0xe20/0x2440
[   66.278166] [   T1315]  lock_acquire+0x199/0x320
[   66.278168] [   T1315]  ? kernfs_remove_by_name_ns+0x53/0x160
[   66.278170] [   T1315]  ? __pfx___might_resched+0x10/0x10
[   66.278173] [   T1315]  down_write+0x8c/0x1f0
[   66.278176] [   T1315]  ? kernfs_remove_by_name_ns+0x53/0x160
[   66.278177] [   T1315]  ? __pfx_down_write+0x10/0x10
[   66.278179] [   T1315]  ? kernfs_root+0xac/0x1b0
[   66.278180] [   T1315]  ? lock_release+0x1b5/0x340
[   66.278183] [   T1315]  kernfs_remove_by_name_ns+0x53/0x160
[   66.278185] [   T1315]  sysfs_unmerge_group+0xd5/0x160
[   66.278187] [   T1315]  dev_pm_qos_hide_latency_tolerance+0x1f/0x60
[   66.278190] [   T1315]  nvme_uninit_ctrl+0x8f/0x110 [nvme_core]
[   66.278212] [   T1315]  nvme_tcp_create_ctrl+0x887/0xc20 [nvme_tcp]
[   66.278216] [   T1315]  ? nvmf_dev_write+0x2ff/0x830 [nvme_fabrics]
[   66.278222] [   T1315]  nvmf_dev_write+0x40b/0x830 [nvme_fabrics]
[   66.278226] [   T1315]  vfs_write+0x1cc/0xf40
[   66.278229] [   T1315]  ? __pfx_vfs_write+0x10/0x10
[   66.278231] [   T1315]  ? __call_rcu_common.constprop.0+0x4af/0x11a0
[   66.278234] [   T1315]  ? __call_rcu_common.constprop.0+0x4af/0x11a0
[   66.278236] [   T1315]  ? __pfx___call_rcu_common.constprop.0+0x10/0x10
[   66.278240] [   T1315]  ksys_write+0x112/0x250
[   66.278242] [   T1315]  ? __pfx_ksys_write+0x10/0x10
[   66.278244] [   T1315]  ? __pfx_fput_close_sync+0x10/0x10
[   66.278246] [   T1315]  do_syscall_64+0xdf/0x790
[   66.278248] [   T1315]  ? do_syscall_64+0x1ec/0x790
[   66.278250] [   T1315]  ? rcu_is_watching+0x11/0xb0
[   66.278253] [   T1315]  ? trace_hardirqs_on+0x14/0x190
[   66.278255] [   T1315]  ? preempt_count_add+0x7f/0x190
[   66.278257] [   T1315]  ? do_syscall_64+0x5d/0x790
[   66.278258] [   T1315]  ? do_syscall_64+0x8d/0x790
[   66.278260] [   T1315]  ? irqentry_exit+0xfc/0x810
[   66.278262] [   T1315]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   66.278265] [   T1315] RIP: 0033:0x7f5f789ee08e
[   66.278268] [   T1315] Code: 4d 89 d8 e8 94 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 03 ff ff ff 0f 1f 00 f3 0f 1e fa
[   66.278270] [   T1315] RSP: 002b:00007ffd6525c110 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   66.278272] [   T1315] RAX: ffffffffffffffda RBX: 000000003ff23e00 RCX: 00007f5f789ee08e
[   66.278274] [   T1315] RDX: 00000000000000cf RSI: 000000003ff23e00 RDI: 0000000000000003
[   66.278275] [   T1315] RBP: 00007ffd6525c120 R08: 0000000000000000 R09: 0000000000000000
[   66.278276] [   T1315] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
[   66.278277] [   T1315] R13: 000000003ff215b0 R14: 00007f5f78bc78c0 R15: 000000003ff233a0
[   66.278280] [   T1315]  </TASK>
[   66.414442] [   T1161] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349, TLS.
[   66.424755] [   T1325] nvme nvme5: creating 4 I/O queues.
[   66.498028] [   T1325] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[   66.505881] [   T1325] nvme nvme5: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[   66.948962] [     T82] kmemleak: 2 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
[   66.974719] [   T1383] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"

