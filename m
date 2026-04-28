Return-Path: <linux-rdma+bounces-19647-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EElGJDF98GlSUAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19647-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 11:26:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2C04815C4
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 11:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6FA330A0640
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 09:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F509175A9D;
	Tue, 28 Apr 2026 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lEeRZpje";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nldctXTv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6E2288C3D;
	Tue, 28 Apr 2026 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367772; cv=fail; b=P/axWUX5W10lDQHAEtRsNJ7f6eMzUnT9kHN6j/E1QNwJxTbjSeWWTXsXOPp2jn72NVlh8afiTeGQHC1lAdQjNR7dvSZ1CUga9O6DYqvk3xDnVlmjgw1HKeyZIgGQ2aZB+w+mPXGqAO5v3M6obDgij8jpL/jRujK3vURjaAYX5kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367772; c=relaxed/simple;
	bh=gy/RDROL8tYr4tmy8WWn9+NhxoFs8Xbu9lmc53yXcYw=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=k5eOlxv2RSsFjUUWvZIW4L/hxLHpJlt7r2y86ZWsT6EsvTWY6hbH9d8Q1sVp5RtXLs2D7jiIQG/bETmtZg4KkuOoW0c/Qh9RwCvwmseKrSFrCbrf5zcvXg8ZnSmcTy5jXoJP2/i69h7XaoHKzQIIqe/AvzsMU5SlYEY1DbhkOdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lEeRZpje; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nldctXTv; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1777367768; x=1808903768;
  h=date:from:to:subject:message-id:mime-version;
  bh=gy/RDROL8tYr4tmy8WWn9+NhxoFs8Xbu9lmc53yXcYw=;
  b=lEeRZpjeMCupsoVe5v5RWmtp1DJMA75TZOgNCNjXKNt+aFT2gZr+qh64
   QlOE462IFvUxewmYdnjLAiUw1LgjHIpGlttrjPcH5NY9PyQ9UPJMT1z6z
   Ez28dn/8vv9pjC4FofPWfmpFDxDwnzRIJ9O8A+ca9HbCTD6jvHNliw7AP
   heY5dr/67q35oq4Vm1wIwPNBNGQBNtG7rawgwIpMG2HfgBpo84gugnGDu
   FXEmVoynXC4Sz/p9x0l58VQ5oV89Wf6/hLDIlBViXoYblWL9KC8XoAPEz
   KPRucRoxuwlNgJ9dJjdq2xMA2Bi5x9iehF9h79A/IOWcHpBB4qoP/aB52
   w==;
X-CSE-ConnectionGUID: 5cq50SQ+QmaAQsqq3DnnfQ==
X-CSE-MsgGUID: dd0PrPwSQ5mImNeyn9uFqQ==
X-IronPort-AV: E=Sophos;i="6.23,203,1770566400"; 
   d="scan'208";a="146572047"
Received: from mail-centralusazon11011004.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.4])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2026 17:14:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUlVN5KgIGNrEjy+y2YErEYDYNfeR5izek+2CEGRVKh5RBtoimXOuVfEWjg285MZ5VbbxE0SSqwZ2VLWJDRs9iyZNBelm+qkGg/HJ3+p/OQmWUM6WAd5u7WlUu08Bnqb2AF8ywjp6oJ9aqXehey9Y+kQxyRGh2S2KOHh3PgHG3KKnB9+Qs0lWIp7VG0iwVeN1m+va0BdfXesswVbNc4kt/u9HQeaCvcm51K0cO2mLEMJLxMvlA/ZJLkw0D3Y+7TbNlovEIertcVsA5RX61621F5ZcbrcJXCLDiTu/2Mll/VArKmKc2iPamwz0iHXOtNAULtu037OgZfR66t2k4GuLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+lPpZP11exXpW+9k7SOdK647AVhuPL7j2qmYn3s0AA=;
 b=aDi9z4+1RiOP5XEPVzPMOPEnrFhjTQ7puBLVIgXdYP1FoItNyyzrSpdvw/yGgMiP4v6FUcoXFr6ILKROuxXZZ08kaFe9V716gpmKKcEKrA/BqjAjDdJ3684jy2ovD7y+x8KNqroaVSU8/ZhidwPGCjtrNV36Mr6/waqpvPupxW+cx88ib2iRE4fBiv1wTAKW4jwv/Jw64j0R+d2zMrTzsrGDikF30Tw5nMPD7jOtgy2arKt4yNllDrqcLdGXdPczAA2rGjhBBvCX+rtNXFpNKMH4elrem4tb9tjbUOgw5wEC8XFLJtQV80ScXqp83igr9aQ9JtjySyBYWrnPJsl/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+lPpZP11exXpW+9k7SOdK647AVhuPL7j2qmYn3s0AA=;
 b=nldctXTv27F1jB7uQml/F6/7Cfbexd7HgkjXMQNJobmGL8ULOTjBJotLW/QkHB6RIsUWWWz9zfUOHH4Ld4fsrzHmdAB0Rxr/qw3uDo7N7CEQwGLg+NvRkM7VkkLHyckzoa/OQ68UfmhZ8BCZQsDAv18rxHe0NpGaqJIQazTHQPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CH2PR04MB7064.namprd04.prod.outlook.com (2603:10b6:610:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 09:14:55 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729%6]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 09:14:55 +0000
Date: Tue, 28 Apr 2026 18:13:17 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	nbd@other.debian.org, linux-rdma@vger.kernel.org
Subject: blktests failures with v7.1-rc1 kernel
Message-ID: <afB5syZbUrppgsDQ@shinmob>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CPBP307CA0005.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:1::8)
 To SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR04MB8532:EE_|CH2PR04MB7064:EE_
X-MS-Office365-Filtering-Correlation-Id: ab634aef-69a3-49d8-db96-08dea5069be2
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|10070799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NFf1KOahNzU36b7vWK557otlfDjEpwU20Ee3AMVU6J9nXe0FrHnV7AkNr491yXVUhPesj0bjdeZnw6wg3gXAyiPeK8ba+IuiJtLw7XS5EaRmzMRHgij9yMLvFQ0SMJgQHI/l1kSXA2A7WiM10SaYupp24lSMlBAKxyaOjGcUsNJ4OxpPSbJfonnudeqJY3XbaAQfZ+omcLpOVk3vpcFLKQkQOZd5LmBqySbDHdTYARVBpaHr4SKZKr1De9bNBY46eAQd5UTeg0+cIqLSh0H+VBntQDz4ZZJK6xBb00lWqEMeJLxSyxail6ZlYtDFcVVMrhh0/Cc/R7bx5XYcOh95XJkDi+OAp4VB1xu2JerwcHSGIFeD0EStVz3d3IRyMwXpn1V2smQOZ3OOv/CRJaF1YlcOuv357+uRQdHZuCde/aGBAMsBmQ4DvZ6t1cwvE2JvfdG1Qu2Urkhe670pmq/Vh8f4Md60ZpDLPUlal5lS+T1xsfPhE1CoKnYgbrOsnqOgnvMcRUmygo9HK5VpiO1zTGqB79dGrVzeqs2aDpOMaJBMLOANuUy5b7foToiJ98m4/g84tjo983HO6viaJxdiHXEfIZHa8sIaeVjtcCWfWPNGcdCzJsjDp85TAFSou1DLoDmK3ToNWJVgBlBboINvr6NBW0WOX1XTjhoKYprziXPxtrWFg3TVDeP3ydBOmQ1TLQ4MHjJXbk/DjrlGBnEIy/ySQCJUj6tZo0fA7M3n3tujz9eRX2C7FhjXpp8R00fJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(10070799003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aHsbi0UTSlrkQv0FwDYN2GAFdUUy3Ezz6iXKCmsIqTQva3Wdwxo5t6+5Dc0a?=
 =?us-ascii?Q?5CPcWif4Wrv3AvEweWuFYJnti3QE38IlVszj01dw77vQQnXwQOqhuNzJ3TA4?=
 =?us-ascii?Q?YvZl5O3vg0YGbfG9jC1RaAAIkwQ3K92uhDwhr2+NB7dKm0/Xlz/D3O1F9azw?=
 =?us-ascii?Q?cwVwfYTw7YnDDAXaJ0oE/sFhrPqMw6cMwn8j1T5v/EucWXZ7YsFLSbCs6Skv?=
 =?us-ascii?Q?S+x1kyA/sPEWP8+340cQ54Av+H+t98CQ9WEJbts/weUsnQT6TGj6HN6bQ5QK?=
 =?us-ascii?Q?mRT4plzK51nXUFIBTwBD0/53LlQM4Z4RW27NH7DF0E2XvM7ovssvR82NkCN/?=
 =?us-ascii?Q?qv/6oaDjCfU0XxP4YqGq8GGIHODV0bryDDPYYn8msb3Cze6gAJ+2SW75huUQ?=
 =?us-ascii?Q?n28FOlCe/CJbFfwfTHWW4OOHj6TBjySChxty4nSJ/zKV68HDOc4Cn5v5XDoC?=
 =?us-ascii?Q?cxXnchxHGz3McFFFDigFV+Tovdw/oR47r2/PRtv+j3rmTDtW0pQlpng/9nq7?=
 =?us-ascii?Q?vWDaKE7RN32PHSOU7FMU8a0EtPVAb09dgWRCt+Kw7UaGQ+Dl/uCxyhSMVj30?=
 =?us-ascii?Q?DPjPXX3E8bqYOc+nK7erdv0P8P6XJKnMO8kdPhCSVYS6YpPp02BkNHl46dh3?=
 =?us-ascii?Q?dL6cozK45PySqJny43HlUKrHdefUOQ8B2//PlCyc16T3OuM2Pb7kJVZs+PwM?=
 =?us-ascii?Q?9ryRCW/z2zTroI9At/VwBtw2f5jdlSGz3lSA/CEwtmLRv15D1maXFA8tOd8v?=
 =?us-ascii?Q?22oxjLaoc+gU+Y1fs+dAwxJTPpd+vEUoYoBfCSzFqL5BwKrcqxKaKDcsZx8e?=
 =?us-ascii?Q?oYHJOzOwvmL1BkKS7iKhntbV1a+HgRSkLaMNHuFaxQhDBaIFD5cDaS8V1IgW?=
 =?us-ascii?Q?1tA/JRqezRwKojRGJEIunkhSr+VQdAYz1gTdjGPOWl7DeBXuKK2OE93qKG9p?=
 =?us-ascii?Q?PJRqLUy8vgvm5yKWbn/BRP8bTNQwOY7aj4iQ3Fesb0gPwwTcABtLrZQwh/Y9?=
 =?us-ascii?Q?n8iMraxMee2nhO6yYYl++MptFGrbWD9FAJQbvT+Lzx23xh8ZibVwfBK5sAOT?=
 =?us-ascii?Q?iIJORj4afgeX1DSNICgw7ppwBcQanHavpm9K1+CT6SgehF4pYiEcEfhucyNp?=
 =?us-ascii?Q?t88U/zI6rYVhIm2BYCjmF5ZLc+NTVugD5SWP1Clq55XmGqhy0VSXGlMbv0S0?=
 =?us-ascii?Q?oqm+XUE5k3jNynshVIwS9Uv41NSXJhH/kT3Q13zWaY4EK9tjW8P1b7WNLrp+?=
 =?us-ascii?Q?rnYqBmR+Mv7ovP+9H89ukOnKZg6XD7cSh/rxFpjexj3vpi4WRuVf93USO7uT?=
 =?us-ascii?Q?/nN3tF085+wSOqCk3NyCyXFLY5T7Wza1gWvrc2HMaO0/ZM0F6NKkolEwxkVS?=
 =?us-ascii?Q?5tUEGSKEevyVNOBqtsBEqbSzydYDnmMBjqTw2ptiuUFEW9tDM5I/BFiECNM5?=
 =?us-ascii?Q?xopXMEVALKgYw348PA+xpm77CLh70cmXWhDhaYBfFGadbhK/IbjKBFFT96Ha?=
 =?us-ascii?Q?9SVcYH8QJ3y6uy+ybYF1JYRFpYNHucRfkLBFFnGaUZnLP/jxAigQu9+ABpm7?=
 =?us-ascii?Q?bMMATDxPTAK5mOjGRFvwNzG3eBwV5GTT+e9S10rKbXEzzy9Tpb/ZLX6PPi8P?=
 =?us-ascii?Q?yYvP+dXAzbnLGrCl15NM9GxtG/uK4rd1E3lJ2VUwNtmxe29Ivt5RQRkjxlo7?=
 =?us-ascii?Q?FPwgY1a35umdBGim5znHCdCvzEOIkLEnGCHhOXEeCcieKrvT4CFxPJn6XEwa?=
 =?us-ascii?Q?qXPvCvWVuQzIRbnoopSclUwaPVoFl23fbP1aP9XedU4kXKdCbpICK7m1YNDv?=
X-MS-Exchange-AntiSpam-MessageData-1: i5x0o+OGe91+XXDnK57JWaPO7jquJhdXI0Q=
X-Exchange-RoutingPolicyChecked:
	pFnoAliiz7AqMf5+apdOqR+gRa727LYAjyojCcFP/jy0rYQOiu7Q9YN+Q/GnWio50noGfCYBYITsSrjnNZSSa1gtJbbjrgXxPhdwI1V/MLkL5vdnvN6zDNDT79FFfrBJiYyOIHIWCyfWuuCMnS2E3rTmZ40bL0pf04MsGPN/M8krqMIBoio5sfP3ptwoQBAgmmtqBocbdxqD7OC+R1Iu99cBlQIjM8j54pYPWaNNfA7bsanxCneBrIsyby6TVZE6JD4zorhSgy7WwNd3W6tlBkMWQqzMCX02GfgU5WKQwV0kYM8W7S02C4QHH8ni8jr+eJ7HOLil6+U9ahQCJDkQWw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uDQaENVlposfZN3rf0wZv3gS73Y8hod1V1SQBQKU+GV83ioTSkde7Ej5eWqTRwft7mu1Aepf53a/fK6kwwmH2OYtCfQpgWFEdGEI8yLJSAXeRT0PC2VFXPsAWu6WRok0SUZosLHQNRsNgQ/2/rzNZomXzItC2+l9SiQjA/KPB3yU0gEmtcFHGI7hnHz0GPrmDJHCceLGRut/8RyVuH/hyMDvSpZKzupc4ynp/7R8CFKEKLm2etLLE+7A4T2OIC1pzz+y/iRc4KoVokwPxQQlVAB+vJG/xW/FCYNljFbPyxvXkX6RoYjsx/phZ9GoK5+7Fjl2exW+E3PDVwgtMBLXLXduLDjpCwDT++O9mE2hOMFXZTUnjg+xv74/j2ns85uOzsUPKYtdk666/fxdfUqutMRkOlYPljh9ShqbXYyChePvBsTmBPK+tFicLMww0TxQGKoZl30xakPk5fvNspYR1KeE/2/gUmhDOv8PSiTSI5eHw3pSOMUfd7XKieJwqGHRI14cZPhFtI078Aqi0HZXwb+ZHcbpBJ9QfXhu3XQ06LVt7TivsW0WoeXwkFRuFJkjp23Okvn1LS9gon1DRTZVuQD8UBbf4yHPMFBmxB2Xx80u6fIIaOFN5ACucFEHvBMM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab634aef-69a3-49d8-db96-08dea5069be2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 09:14:54.9960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CUAVLSxHs8N431fQsZQFiEuhMa2Kg6roP3fkRzTumP4wWp0awZOdxESKMxjJ7MBxVKIePN/veej0l2fGoDAp02zqzrFpwjWEEJOMcUNZag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7064
X-Rspamd-Queue-Id: EC2C04815C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19647-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shinichiro.kawasaki@wdc.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sharedspace.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wdc.com:dkim]

Hi all,

I ran the latest blktests (git hash: ea5472c1adc8) with the v7.1-rc1 kernel. I
observed 8 failures listed below. Comparing with the previous report for the
v7.0 kernel [1], 2 failures are new (nvme/045, scsi/002). Your actions for fix
will be welcomed as always.

[1] https://lore.kernel.org/linux-block/aeCDXI5hY_ivSWm4@shinmob/


List of failures
================
#1: nvme/005,063 (tcp transport)
#2: nvme/045 (new)(kmemleak)
#3: nvme/058 (fc transport)(hang)(kmemleak)
#4: nvme/060
#5: nvme/061 (rdma transport, siw driver)(kmemleak)
#6: nvme/061 (fc transport)
#7: nbd/002
#8: scsi/002 (new)


Failure description
===================

#1: nvme/005,063 (tcp transport)

    The test cases nvme/005 and 063 fail for tcp transport due to the lockdep
    WARN related to the three locks q->q_usage_counter, q->elevator_lock and
    set->srcu. The failure was reported first time for nvme/063 and v6.16-rc1
    kernel [2].

    Chaitanya provided a fix patch (thanks!), and it is queued for v7.1-rcX tags
    [3]. However, nvme/005 and 063 still fail even when I apply the fix patch to
    v7.1-rc1 kernel. The call traces of the lockdep WARN are different between
    "v7.1-rc1" kernel [4] and "v7.1-rc1+the fix patch" kernel [5]. I guess that
    there exist two lockdep problems with similar symptoms and patch [3] fixed
    one of them. I guess that still one problem is left.

    [2] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
    [3] https://lore.kernel.org/all/20260413171628.6204-1-kch@nvidia.com/

#2: nvme/045 (new)(kmemleak)

    When the test case nvme/045 is repeated twice for any transport on the
    kernel with CONFIG_DEBUG_KMEMLEAK enabled, it causes kmemleak. The 2nd
    run does not fail but records the kmemleak in results/start.kmemleak [6].

#3: nvme/058 (fc transport)(kmemleak)

    When the test case nvme/058 is repeated for fc transport, it fails or hangs.
    When the hang happens, a lockdep WARN and a "BUG: null pointer dereference"
    are reported [7]. I reported similar hang for v7.0-rc1 kernel [8], but did
    not observe if for v7.0 kernel, probably because the hang is sporadic.

    When the kernel enables CONFIG_DEBUG_KMEMLEAK, the test case sometimes
    causes kmemleak. Due to the hang, kmemleak recreation is rather difficult.
    When it happens, it does not reported as failure of the test case, but
    recorded in results/start.kmemleak. The memory leak report looks similar as
    those I reported for v7.0-rc1 kernel [8].

    [8] https://lore.kernel.org/linux-block/aZ_-cH8euZLySxdD@shinmob/

#4: nvme/060 (rdma transport)

    When the test case is repeated for rdma transport around 50 times, the test
    case fails. As reported for v7.0 kernel, there are two failure symptoms [1].
    Both symptoms do not look kernel side problems, but blktests side problems.
    I will allocate time to look into them.

#5: nvme/061 (rdma transport, siw driver)(kmemleak)

    When the test case nvme/061 is repeated twice for the rdma transport and the
    siw driver on the kernel v6.19 with CONFIG_DEBUG_KMEMLEAK enabled, it causes
    kmemleak that is detected at the beginning of the 2nd run. Refer to the
    nvme/061 failure report for v6.19 kernel [9].

    [9] https://lore.kernel.org/linux-block/aY7ZBfMjVIhe_wh3@shinmob/

#6: nvme/061 (fc transport)

    When the test case nvme/061 is repeated around 50 times for the fc
    transport, the test process fails after Oops and KASAN null-ptr-deref. It
    had hanged with v7.0-rc1 kernel. I did not observed the hang with v7.0
    kernel by some reason, but it was observed with v7.1-rc1 kernel again.
    Refer to the report for the v7.0-rc1 kernel [8].

#7: nbd/002

    The test case nbd/002 fails due to the lockdep WARN related to
    sk_lock-AF_INET6, cmd->lock and nsock->txlock [9]. The lockdep WARN of this
    test case has been reported since v6.18-rc1 kernel [10]. In the past,
    related locks were mm->mmap_lock, sk_lock-AF_INET6 and fs_reclaim, which are
    different from those are observed with the v7.1-rc1 kernel.

    [10] https://lore.kernel.org/linux-block/ynmi72x5wt5ooljjafebhcarit3pvu6axkslqenikb2p5txe57@ldytqa2t4i2x/

#8: scsi/002

    The test case fails with the message below. The failure cause is sg node
    file open failure. A fix patch is already queued for v7.1-rcX tags [11].

  scsi/002 => sdc (perform a SG_DXFER_FROM_DEV from the /dev/sg read-write interface) [failed]
      runtime  0.029s  ...  0.028s
      --- tests/scsi/002.out      2023-04-06 10:11:07.926670528 +0900
      +++ /home/shin/Blktests/blktests/results/sdc/scsi/002.out.bad       2026-04-28 13:55:02.175755412 +0900
      @@ -1,3 +1,4 @@
       Running scsi/002
      -PASS
      +write: Cannot allocate memory
      +FAIL
       Test complete

   [11] https://lore.kernel.org/linux-scsi/20260415060813.807659-2-hch@lst.de/



[4] nvme/005 dmesg on v7.1-rc1 kernel

[   57.930787] [   T1039] run blktests nvme/005 at 2026-04-28 09:03:22
[   58.140452] [   T1092] loop0: detected capacity change from 0 to 2097152
[   58.184809] [   T1096] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   58.217712] [   T1100] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[   58.371398] [    T277] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   58.377420] [   T1107] nvme nvme5: creating 4 I/O queues.
[   58.383816] [   T1107] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[   58.392229] [   T1107] nvme nvme5: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[   58.794140] [    T277] nvmet: Created nvm controller 2 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   58.800118] [     T81] nvme nvme5: creating 4 I/O queues.
[   58.826897] [     T81] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[   58.889841] [   T1155] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"

[   58.929003] [   T1155] ======================================================
[   58.929781] [   T1155] WARNING: possible circular locking dependency detected
[   58.930534] [   T1155] 7.1.0-rc1 #1 Not tainted
[   58.931082] [   T1155] ------------------------------------------------------
[   58.931904] [   T1155] nvme/1155 is trying to acquire lock:
[   58.932529] [   T1155] ffff8881459e9298 (set->srcu){.+.+}-{0:0}, at: __synchronize_srcu+0x21/0x2b0
[   58.933631] [   T1155] 
                          but task is already holding lock:
[   58.934534] [   T1155] ffff88812c5b62a8 (&q->elevator_lock){+.+.}-{4:4}, at: elevator_change+0x188/0x4f0
[   58.935616] [   T1155] 
                          which lock already depends on the new lock.

[   58.936855] [   T1155] 
                          the existing dependency chain (in reverse order) is:
[   58.937947] [   T1155] 
                          -> #4 (&q->elevator_lock){+.+.}-{4:4}:
[   58.938923] [   T1155]        __mutex_lock+0x1ae/0x2600
[   58.939588] [   T1155]        elevator_change+0x188/0x4f0
[   58.940258] [   T1155]        elv_iosched_store+0x308/0x390
[   58.940947] [   T1155]        queue_attr_store+0x23b/0x360
[   58.941615] [   T1155]        kernfs_fop_write_iter+0x3d6/0x5e0
[   58.942338] [   T1155]        vfs_write+0x52c/0xf80
[   58.942909] [   T1155]        ksys_write+0xfb/0x200
[   58.943488] [   T1155]        do_syscall_64+0xdd/0x14c0
[   58.944092] [   T1155]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   58.944849] [   T1155] 
                          -> #3 (&q->q_usage_counter(io)){++++}-{0:0}:
[   58.946578] [   T1155]        blk_alloc_queue+0x5b3/0x730
[   58.947565] [   T1155]        blk_mq_alloc_queue+0x13f/0x250
[   58.948595] [   T1155]        scsi_alloc_sdev+0x84e/0xca0
[   58.949597] [   T1155]        scsi_probe_and_add_lun+0x63f/0xc30
[   58.950621] [   T1155]        __scsi_add_device+0x1be/0x1f0
[   58.951639] [   T1155]        ata_scsi_scan_host+0x139/0x3a0
[   58.952646] [   T1155]        async_run_entry_fn+0x93/0x550
[   58.953640] [   T1155]        process_one_work+0x8b4/0x1640
[   58.954605] [   T1155]        worker_thread+0x606/0xff0
[   58.955505] [   T1155]        kthread+0x368/0x460
[   58.956596] [   T1155]        ret_from_fork+0x653/0x9d0
[   58.957573] [   T1155]        ret_from_fork_asm+0x1a/0x30
[   58.958565] [   T1155] 
                          -> #2 (fs_reclaim){+.+.}-{0:0}:
[   58.960089] [   T1155]        fs_reclaim_acquire+0xd5/0x120
[   58.961031] [   T1155]        kmem_cache_alloc_node_noprof+0x54/0x700
[   58.962076] [   T1155]        __alloc_skb+0xde/0x5b0
[   58.962927] [   T1155]        tcp_send_active_reset+0x84/0x780
[   58.963878] [   T1155]        tcp_disconnect+0x16f3/0x1f10
[   58.964787] [   T1155]        __tcp_close+0x7d8/0xef0
[   58.965646] [   T1155]        tcp_close+0x1f/0xb0
[   58.966469] [   T1155]        inet_release+0x100/0x230
[   58.967340] [   T1155]        __sock_release+0xb0/0x270
[   58.968196] [   T1155]        sock_close+0x14/0x20
[   58.969012] [   T1155]        __fput+0x36e/0xac0
[   58.969793] [   T1155]        delayed_fput+0x6a/0x90
[   58.970625] [   T1155]        process_one_work+0x8b4/0x1640
[   58.971526] [   T1155]        worker_thread+0x606/0xff0
[   58.972381] [   T1155]        kthread+0x368/0x460
[   58.973165] [   T1155]        ret_from_fork+0x653/0x9d0
[   58.974005] [   T1155]        ret_from_fork_asm+0x1a/0x30
[   58.974882] [   T1155] 
                          -> #1 (sk_lock-AF_INET-NVME){+.+.}-{0:0}:
[   58.976282] [   T1155]        lock_sock_nested+0x32/0xf0
[   58.977124] [   T1155]        tcp_sendmsg+0x1c/0x50
[   58.977929] [   T1155]        sock_sendmsg+0x2bd/0x370
[   58.978755] [   T1155]        nvme_tcp_try_send_cmd_pdu+0x57f/0xbd0 [nvme_tcp]
[   58.979827] [   T1155]        nvme_tcp_try_send+0x1b3/0x9c0 [nvme_tcp]
[   58.980833] [   T1155]        nvme_tcp_queue_rq+0xf77/0x1970 [nvme_tcp]
[   58.981824] [   T1155]        blk_mq_dispatch_rq_list+0x39b/0x2340
[   58.982774] [   T1155]        __blk_mq_sched_dispatch_requests+0x1dd/0x1510
[   58.983817] [   T1155]        blk_mq_sched_dispatch_requests+0xa8/0x150
[   58.984823] [   T1155]        blk_mq_run_hw_queue+0x1c9/0x520
[   58.985703] [   T1155]        blk_execute_rq+0x166/0x380
[   58.986536] [   T1155]        __nvme_submit_sync_cmd+0x104/0x320 [nvme_core]
[   58.987606] [   T1155]        nvmf_connect_io_queue+0x1c6/0x2f0 [nvme_fabrics]
[   58.988687] [   T1155]        nvme_tcp_start_queue+0x812/0xbe0 [nvme_tcp]
[   58.989707] [   T1155]        nvme_tcp_setup_ctrl.cold+0x658/0xcad [nvme_tcp]
[   58.990770] [   T1155]        nvme_tcp_create_ctrl+0x834/0xb90 [nvme_tcp]
[   58.991789] [   T1155]        nvmf_dev_write+0x3e3/0x800 [nvme_fabrics]
[   58.992796] [   T1155]        vfs_write+0x1cc/0xf80
[   58.993609] [   T1155]        ksys_write+0xfb/0x200
[   58.994408] [   T1155]        do_syscall_64+0xdd/0x14c0
[   58.995258] [   T1155]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   58.996246] [   T1155] 
                          -> #0 (set->srcu){.+.+}-{0:0}:
[   58.999068] [   T1155]        __lock_acquire+0x14a6/0x2230
[   59.000816] [   T1155]        lock_sync+0xbd/0x120
[   59.002557] [   T1155]        __synchronize_srcu+0xa1/0x2b0
[   59.005220] [   T1155]        elevator_switch+0x2a5/0x680
[   59.007054] [   T1155]        elevator_change+0x2d8/0x4f0
[   59.008936] [   T1155]        elevator_set_none+0x87/0xd0
[   59.010904] [   T1155]        blk_unregister_queue+0x13f/0x2b0
[   59.012840] [   T1155]        __del_gendisk+0x263/0x9e0
[   59.014762] [   T1155]        del_gendisk+0x102/0x190
[   59.016561] [   T1155]        nvme_ns_remove+0x32a/0x900 [nvme_core]
[   59.018584] [   T1155]        nvme_remove_namespaces+0x263/0x3b0 [nvme_core]
[   59.020685] [   T1155]        nvme_do_delete_ctrl+0xf5/0x160 [nvme_core]
[   59.022773] [   T1155]        nvme_delete_ctrl_sync.cold+0x8/0xd [nvme_core]
[   59.024904] [   T1155]        nvme_sysfs_delete+0x96/0xc0 [nvme_core]
[   59.027013] [   T1155]        kernfs_fop_write_iter+0x3d6/0x5e0
[   59.028937] [   T1155]        vfs_write+0x52c/0xf80
[   59.030473] [   T1155]        ksys_write+0xfb/0x200
[   59.031897] [   T1155]        do_syscall_64+0xdd/0x14c0
[   59.033169] [   T1155]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   59.034583] [   T1155] 
                          other info that might help us debug this:

[   59.037069] [   T1155] Chain exists of:
                            set->srcu --> &q->q_usage_counter(io) --> &q->elevator_lock

[   59.039698] [   T1155]  Possible unsafe locking scenario:

[   59.041167] [   T1155]        CPU0                    CPU1
[   59.042028] [   T1155]        ----                    ----
[   59.042857] [   T1155]   lock(&q->elevator_lock);
[   59.043619] [   T1155]                                lock(&q->q_usage_counter(io));
[   59.044570] [   T1155]                                lock(&q->elevator_lock);
[   59.045399] [   T1155]   sync(set->srcu);
[   59.046010] [   T1155] 
                           *** DEADLOCK ***

[   59.047629] [   T1155] 5 locks held by nvme/1155:
[   59.048305] [   T1155]  #0: ffff888124718410 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0xfb/0x200
[   59.049257] [   T1155]  #1: ffff88813051ac80 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x257/0x5e0
[   59.050220] [   T1155]  #2: ffff88813faaf2d8 (kn->active#140){++++}-{0:0}, at: sysfs_remove_file_self+0x61/0xb0
[   59.051229] [   T1155]  #3: ffff8881383dc1c8 (&set->update_nr_hwq_lock){++++}-{4:4}, at: del_gendisk+0xfa/0x190
[   59.052222] [   T1155]  #4: ffff88812c5b62a8 (&q->elevator_lock){+.+.}-{4:4}, at: elevator_change+0x188/0x4f0
[   59.053238] [   T1155] 
                          stack backtrace:
[   59.054340] [   T1155] CPU: 2 UID: 0 PID: 1155 Comm: nvme Not tainted 7.1.0-rc1 #1 PREEMPT(full) 
[   59.054342] [   T1155] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
[   59.054344] [   T1155] Call Trace:
[   59.054346] [   T1155]  <TASK>
[   59.054348] [   T1155]  dump_stack_lvl+0x6a/0x90
[   59.054352] [   T1155]  print_circular_bug.cold+0x185/0x1d0
[   59.054355] [   T1155]  check_noncircular+0x148/0x170
[   59.054358] [   T1155]  __lock_acquire+0x14a6/0x2230
[   59.054361] [   T1155]  lock_sync+0xbd/0x120
[   59.054363] [   T1155]  ? __synchronize_srcu+0x21/0x2b0
[   59.054365] [   T1155]  ? __synchronize_srcu+0x21/0x2b0
[   59.054367] [   T1155]  __synchronize_srcu+0xa1/0x2b0
[   59.054369] [   T1155]  ? __pfx___synchronize_srcu+0x10/0x10
[   59.054372] [   T1155]  ? kvm_clock_get_cycles+0x14/0x30
[   59.054375] [   T1155]  ? ktime_get_mono_fast_ns+0x193/0x490
[   59.054377] [   T1155]  ? lockdep_hardirqs_on+0x88/0x130
[   59.054380] [   T1155]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[   59.054383] [   T1155]  elevator_switch+0x2a5/0x680
[   59.054385] [   T1155]  elevator_change+0x2d8/0x4f0
[   59.054387] [   T1155]  elevator_set_none+0x87/0xd0
[   59.054389] [   T1155]  ? __pfx_elevator_set_none+0x10/0x10
[   59.054392] [   T1155]  ? kobject_put+0x5a/0x4e0
[   59.054395] [   T1155]  blk_unregister_queue+0x13f/0x2b0
[   59.054397] [   T1155]  __del_gendisk+0x263/0x9e0
[   59.054400] [   T1155]  ? down_read+0x13b/0x480
[   59.054402] [   T1155]  ? __pfx___del_gendisk+0x10/0x10
[   59.054403] [   T1155]  ? __pfx_down_read+0x10/0x10
[   59.054405] [   T1155]  ? up_write+0x294/0x510
[   59.054408] [   T1155]  del_gendisk+0x102/0x190
[   59.054411] [   T1155]  nvme_ns_remove+0x32a/0x900 [nvme_core]
[   59.054422] [   T1155]  nvme_remove_namespaces+0x263/0x3b0 [nvme_core]
[   59.054435] [   T1155]  ? __pfx_nvme_remove_namespaces+0x10/0x10 [nvme_core]
[   59.054446] [   T1155]  nvme_do_delete_ctrl+0xf5/0x160 [nvme_core]
[   59.054457] [   T1155]  nvme_delete_ctrl_sync.cold+0x8/0xd [nvme_core]
[   59.054467] [   T1155]  nvme_sysfs_delete+0x96/0xc0 [nvme_core]
[   59.054478] [   T1155]  ? __pfx_sysfs_kf_write+0x10/0x10
[   59.054480] [   T1155]  kernfs_fop_write_iter+0x3d6/0x5e0
[   59.054482] [   T1155]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[   59.054484] [   T1155]  vfs_write+0x52c/0xf80
[   59.054486] [   T1155]  ? __pfx_vfs_write+0x10/0x10
[   59.054489] [   T1155]  ? lockdep_hardirqs_on+0x88/0x130
[   59.054490] [   T1155]  ? kasan_quarantine_put+0xff/0x220
[   59.054493] [   T1155]  ? kasan_quarantine_put+0xff/0x220
[   59.054495] [   T1155]  ? kmem_cache_free+0x14c/0x670
[   59.054499] [   T1155]  ksys_write+0xfb/0x200
[   59.054501] [   T1155]  ? __pfx_ksys_write+0x10/0x10
[   59.054503] [   T1155]  ? __call_rcu_common.constprop.0+0x466/0x1120
[   59.054506] [   T1155]  do_syscall_64+0xdd/0x14c0
[   59.054508] [   T1155]  ? __x64_sys_openat+0x10a/0x210
[   59.054510] [   T1155]  ? __pfx___call_rcu_common.constprop.0+0x10/0x10
[   59.054512] [   T1155]  ? __pfx___x64_sys_openat+0x10/0x10
[   59.054514] [   T1155]  ? rcu_is_watching+0x11/0xb0
[   59.054515] [   T1155]  ? do_syscall_64+0x1ea/0x14c0
[   59.054517] [   T1155]  ? lockdep_hardirqs_on+0x88/0x130
[   59.054519] [   T1155]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   59.054520] [   T1155]  ? do_syscall_64+0x208/0x14c0
[   59.054522] [   T1155]  ? fput_close_sync+0xda/0x1b0
[   59.054524] [   T1155]  ? __pfx_fput_close_sync+0x10/0x10
[   59.054526] [   T1155]  ? do_raw_spin_unlock+0x55/0x230
[   59.054529] [   T1155]  ? rcu_is_watching+0x11/0xb0
[   59.054530] [   T1155]  ? do_syscall_64+0x1ea/0x14c0
[   59.054532] [   T1155]  ? lockdep_hardirqs_on+0x88/0x130
[   59.054533] [   T1155]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   59.054535] [   T1155]  ? do_syscall_64+0x208/0x14c0
[   59.054537] [   T1155]  ? do_sys_openat2+0xfd/0x170
[   59.054539] [   T1155]  ? kmem_cache_free+0x14c/0x670
[   59.054542] [   T1155]  ? ksys_read+0xfb/0x200
[   59.054543] [   T1155]  ? __pfx_ksys_read+0x10/0x10
[   59.054545] [   T1155]  ? rcu_is_watching+0x11/0xb0
[   59.054547] [   T1155]  ? do_syscall_64+0x1ea/0x14c0
[   59.054549] [   T1155]  ? lockdep_hardirqs_on+0x88/0x130
[   59.054550] [   T1155]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   59.054552] [   T1155]  ? do_syscall_64+0x208/0x14c0
[   59.054553] [   T1155]  ? __x64_sys_openat+0x10a/0x210
[   59.054555] [   T1155]  ? rcu_is_watching+0x11/0xb0
[   59.054557] [   T1155]  ? __pfx___x64_sys_openat+0x10/0x10
[   59.054558] [   T1155]  ? lockdep_hardirqs_on+0x88/0x130
[   59.054560] [   T1155]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   59.054561] [   T1155]  ? rcu_is_watching+0x11/0xb0
[   59.054563] [   T1155]  ? do_syscall_64+0x32/0x14c0
[   59.054565] [   T1155]  ? preempt_count_add+0x7f/0x190
[   59.054567] [   T1155]  ? do_syscall_64+0x5d/0x14c0
[   59.054569] [   T1155]  ? do_syscall_64+0x8d/0x14c0
[   59.054570] [   T1155]  ? irqentry_exit+0xf1/0x720
[   59.054572] [   T1155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   59.054574] [   T1155] RIP: 0033:0x7fdb4f75cc5e
[   59.054577] [   T1155] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   59.054579] [   T1155] RSP: 002b:00007fffea324500 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   59.054581] [   T1155] RAX: ffffffffffffffda RBX: 00007fdb4f9269a6 RCX: 00007fdb4f75cc5e
[   59.054582] [   T1155] RDX: 0000000000000001 RSI: 00007fdb4f9269a6 RDI: 0000000000000003
[   59.054583] [   T1155] RBP: 00007fffea324510 R08: 0000000000000000 R09: 0000000000000000
[   59.054584] [   T1155] R10: 0000000000000000 R11: 0000000000000202 R12: 000000001933c860
[   59.054585] [   T1155] R13: 000000001933e580 R14: 000000001933c680 R15: 0000000000000000
[   59.054588] [   T1155]  </TASK>


[5] nvme/005 dmesg on v7.1-rc1 kernel + the fix patch [3]

[   67.239277] [   T1061] run blktests nvme/005 at 2026-04-28 08:50:20
[   67.344722] [   T1114] loop0: detected capacity change from 0 to 2097152
[   67.371912] [   T1118] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   67.401439] [   T1122] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[   67.518659] [    T241] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   67.524965] [   T1129] nvme nvme5: creating 4 I/O queues.
[   67.530490] [   T1129] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[   67.535182] [   T1129] nvme nvme5: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[   67.974785] [    T241] nvmet: Created nvm controller 2 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   67.983865] [    T306] nvme nvme5: creating 4 I/O queues.
[   68.016549] [    T306] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[   68.082379] [   T1176] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[   68.084613] [   T1101] block nvme5n1: no available path - failing I/O
[   68.086877] [   T1101] block nvme5n1: no available path - failing I/O
[   68.087821] [   T1101] Buffer I/O error on dev nvme5n1, logical block 262136, async page read

[   68.106497] [   T1176] ======================================================
[   68.107314] [   T1176] WARNING: possible circular locking dependency detected
[   68.108149] [   T1176] 7.1.0-rc1+ #3 Not tainted
[   68.108699] [   T1176] ------------------------------------------------------
[   68.109551] [   T1176] nvme/1176 is trying to acquire lock:
[   68.110222] [   T1176] ffff88814523f918 (set->srcu){.+.+}-{0:0}, at: __synchronize_srcu+0x21/0x2b0
[   68.111334] [   T1176] 
                          but task is already holding lock:
[   68.112293] [   T1176] ffff8881088abd68 (&q->elevator_lock){+.+.}-{4:4}, at: elevator_change+0x188/0x4f0
[   68.113485] [   T1176] 
                          which lock already depends on the new lock.

[   68.114800] [   T1176] 
                          the existing dependency chain (in reverse order) is:
[   68.115942] [   T1176] 
                          -> #5 (&q->elevator_lock){+.+.}-{4:4}:
[   68.116899] [   T1176]        __mutex_lock+0x1ae/0x2600
[   68.117531] [   T1176]        elevator_change+0x188/0x4f0
[   68.118199] [   T1176]        elv_iosched_store+0x308/0x390
[   68.118876] [   T1176]        queue_attr_store+0x23b/0x360
[   68.119529] [   T1176]        kernfs_fop_write_iter+0x3d6/0x5e0
[   68.120441] [   T1176]        vfs_write+0x52c/0xf80
[   68.121496] [   T1176]        ksys_write+0xfb/0x200
[   68.122513] [   T1176]        do_syscall_64+0xdd/0x14c0
[   68.123524] [   T1176]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   68.124925] [   T1176] 
                          -> #4 (&q->q_usage_counter(io)){++++}-{0:0}:
[   68.127229] [   T1176]        blk_alloc_queue+0x5b3/0x730
[   68.128229] [   T1176]        blk_mq_alloc_queue+0x13f/0x250
[   68.129235] [   T1176]        scsi_alloc_sdev+0x84e/0xca0
[   68.130204] [   T1176]        scsi_probe_and_add_lun+0x63f/0xc30
[   68.131259] [   T1176]        __scsi_add_device+0x1be/0x1f0
[   68.132250] [   T1176]        ata_scsi_scan_host+0x139/0x3a0
[   68.133243] [   T1176]        async_run_entry_fn+0x93/0x550
[   68.134221] [   T1176]        process_one_work+0x8b4/0x1640
[   68.135181] [   T1176]        worker_thread+0x606/0xff0
[   68.136096] [   T1176]        kthread+0x368/0x460
[   68.136931] [   T1176]        ret_from_fork+0x653/0x9d0
[   68.138003] [   T1176]        ret_from_fork_asm+0x1a/0x30
[   68.139068] [   T1176] 
                          -> #3 (fs_reclaim){+.+.}-{0:0}:
[   68.140466] [   T1176]        fs_reclaim_acquire+0xd5/0x120
[   68.141509] [   T1176]        __kmalloc_cache_node_noprof+0x51/0x740
[   68.142579] [   T1176]        create_worker+0xfb/0x710
[   68.143620] [   T1176]        workqueue_prepare_cpu+0x87/0xe0
[   68.144686] [   T1176]        cpuhp_invoke_callback+0x2a7/0x1230
[   68.145752] [   T1176]        __cpuhp_invoke_callback_range+0xbd/0x1f0
[   68.146792] [   T1176]        _cpu_up+0x2ec/0x700
[   68.147628] [   T1176]        cpu_up+0x111/0x190
[   68.148452] [   T1176]        cpuhp_bringup_mask+0xd3/0x110
[   68.149487] [   T1176]        bringup_nonboot_cpus+0x139/0x170
[   68.150575] [   T1176]        smp_init+0x27/0xe0
[   68.151400] [   T1176]        kernel_init_freeable+0x445/0x6f0
[   68.152540] [   T1176]        kernel_init+0x18/0x150
[   68.153628] [   T1176]        ret_from_fork+0x653/0x9d0
[   68.154856] [   T1176]        ret_from_fork_asm+0x1a/0x30
[   68.155932] [   T1176] 
                          -> #2 (cpu_hotplug_lock){++++}-{0:0}:
[   68.157409] [   T1176]        cpus_read_lock+0x3c/0xe0
[   68.158235] [   T1176]        static_key_disable+0x12/0x30
[   68.159130] [   T1176]        __inet_hash_connect+0x10f7/0x1a50
[   68.160055] [   T1176]        tcp_v4_connect+0xcb0/0x18b0
[   68.160924] [   T1176]        __inet_stream_connect+0x349/0xf00
[   68.161960] [   T1176]        inet_stream_connect+0x55/0xb0
[   68.162984] [   T1176]        kernel_connect+0xdf/0x140
[   68.164144] [   T1176]        nvme_tcp_alloc_queue+0xa48/0x1b60 [nvme_tcp]
[   68.165175] [   T1176]        nvme_tcp_alloc_admin_queue+0xff/0x440 [nvme_tcp]
[   68.166258] [   T1176]        nvme_tcp_setup_ctrl+0x8a/0x830 [nvme_tcp]
[   68.167239] [   T1176]        nvme_tcp_create_ctrl+0x834/0xb90 [nvme_tcp]
[   68.168242] [   T1176]        nvmf_dev_write+0x3e3/0x800 [nvme_fabrics]
[   68.169232] [   T1176]        vfs_write+0x1cc/0xf80
[   68.170029] [   T1176]        ksys_write+0xfb/0x200
[   68.171305] [   T1176]        do_syscall_64+0xdd/0x14c0
[   68.172140] [   T1176]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   68.173074] [   T1176] 
                          -> #1 (sk_lock-AF_INET-NVME){+.+.}-{0:0}:
[   68.174440] [   T1176]        lock_sock_nested+0x32/0xf0
[   68.175263] [   T1176]        tcp_sendmsg+0x1c/0x50
[   68.176037] [   T1176]        sock_sendmsg+0x2bd/0x370
[   68.177057] [   T1176]        nvme_tcp_try_send_cmd_pdu+0x57f/0xbd0 [nvme_tcp]
[   68.178142] [   T1176]        nvme_tcp_try_send+0x1b3/0x9c0 [nvme_tcp]
[   68.179125] [   T1176]        nvme_tcp_queue_rq+0xf77/0x1970 [nvme_tcp]
[   68.180107] [   T1176]        blk_mq_dispatch_rq_list+0x39b/0x2340
[   68.181042] [   T1176]        __blk_mq_sched_dispatch_requests+0x1dd/0x1510
[   68.182719] [   T1176]        blk_mq_sched_dispatch_requests+0xa8/0x150
[   68.183842] [   T1176]        blk_mq_run_work_fn+0x127/0x2c0
[   68.184865] [   T1176]        process_one_work+0x8b4/0x1640
[   68.185968] [   T1176]        worker_thread+0x606/0xff0
[   68.186967] [   T1176]        kthread+0x368/0x460
[   68.188269] [   T1176]        ret_from_fork+0x653/0x9d0
[   68.189171] [   T1176]        ret_from_fork_asm+0x1a/0x30
[   68.190060] [   T1176] 
                          -> #0 (set->srcu){.+.+}-{0:0}:
[   68.191490] [   T1176]        __lock_acquire+0x14a6/0x2230
[   68.192459] [   T1176]        lock_sync+0xbd/0x120
[   68.193315] [   T1176]        __synchronize_srcu+0xa1/0x2b0
[   68.194240] [   T1176]        elevator_switch+0x2a5/0x680
[   68.195154] [   T1176]        elevator_change+0x2d8/0x4f0
[   68.196048] [   T1176]        elevator_set_none+0x87/0xd0
[   68.196931] [   T1176]        blk_unregister_queue+0x13f/0x2b0
[   68.197896] [   T1176]        __del_gendisk+0x263/0x9e0
[   68.198779] [   T1176]        del_gendisk+0x102/0x190
[   68.199665] [   T1176]        nvme_ns_remove+0x32a/0x900 [nvme_core]
[   68.200739] [   T1176]        nvme_remove_namespaces+0x263/0x3b0 [nvme_core]
[   68.201863] [   T1176]        nvme_do_delete_ctrl+0xf5/0x160 [nvme_core]
[   68.202941] [   T1176]        nvme_delete_ctrl_sync.cold+0x8/0xd [nvme_core]
[   68.204162] [   T1176]        nvme_sysfs_delete+0x96/0xc0 [nvme_core]
[   68.205332] [   T1176]        kernfs_fop_write_iter+0x3d6/0x5e0
[   68.206346] [   T1176]        vfs_write+0x52c/0xf80
[   68.207710] [   T1176]        ksys_write+0xfb/0x200
[   68.208396] [   T1176]        do_syscall_64+0xdd/0x14c0
[   68.209041] [   T1176]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   68.209876] [   T1176] 
                          other info that might help us debug this:

[   68.211549] [   T1176] Chain exists of:
                            set->srcu --> &q->q_usage_counter(io) --> &q->elevator_lock

[   68.213460] [   T1176]  Possible unsafe locking scenario:

[   68.214585] [   T1176]        CPU0                    CPU1
[   68.215236] [   T1176]        ----                    ----
[   68.215899] [   T1176]   lock(&q->elevator_lock);
[   68.216589] [   T1176]                                lock(&q->q_usage_counter(io));
[   68.217375] [   T1176]                                lock(&q->elevator_lock);
[   68.218120] [   T1176]   sync(set->srcu);
[   68.218780] [   T1176] 
                           *** DEADLOCK ***

[   68.220308] [   T1176] 5 locks held by nvme/1176:
[   68.220925] [   T1176]  #0: ffff88810ee7a410 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0xfb/0x200
[   68.221887] [   T1176]  #1: ffff88812f8b4080 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x257/0x5e0
[   68.222946] [   T1176]  #2: ffff88812256b0f8 (kn->active#140){++++}-{0:0}, at: sysfs_remove_file_self+0x61/0xb0
[   68.223950] [   T1176]  #3: ffff888114bec1c8 (&set->update_nr_hwq_lock){++++}-{4:4}, at: del_gendisk+0xfa/0x190
[   68.224948] [   T1176]  #4: ffff8881088abd68 (&q->elevator_lock){+.+.}-{4:4}, at: elevator_change+0x188/0x4f0
[   68.225981] [   T1176] 
                          stack backtrace:
[   68.227111] [   T1176] CPU: 1 UID: 0 PID: 1176 Comm: nvme Not tainted 7.1.0-rc1+ #3 PREEMPT(full) 
[   68.227113] [   T1176] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
[   68.227116] [   T1176] Call Trace:
[   68.227118] [   T1176]  <TASK>
[   68.227121] [   T1176]  dump_stack_lvl+0x6a/0x90
[   68.227126] [   T1176]  print_circular_bug.cold+0x185/0x1d0
[   68.227130] [   T1176]  check_noncircular+0x148/0x170
[   68.227136] [   T1176]  __lock_acquire+0x14a6/0x2230
[   68.227139] [   T1176]  lock_sync+0xbd/0x120
[   68.227141] [   T1176]  ? __synchronize_srcu+0x21/0x2b0
[   68.227145] [   T1176]  ? __synchronize_srcu+0x21/0x2b0
[   68.227146] [   T1176]  __synchronize_srcu+0xa1/0x2b0
[   68.227149] [   T1176]  ? __pfx___synchronize_srcu+0x10/0x10
[   68.227152] [   T1176]  ? kvm_clock_get_cycles+0x14/0x30
[   68.227155] [   T1176]  ? ktime_get_mono_fast_ns+0x193/0x490
[   68.227159] [   T1176]  ? lockdep_hardirqs_on+0x88/0x130
[   68.227161] [   T1176]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[   68.227164] [   T1176]  elevator_switch+0x2a5/0x680
[   68.227167] [   T1176]  elevator_change+0x2d8/0x4f0
[   68.227169] [   T1176]  elevator_set_none+0x87/0xd0
[   68.227171] [   T1176]  ? __pfx_elevator_set_none+0x10/0x10
[   68.227174] [   T1176]  ? kobject_put+0x5a/0x4e0
[   68.227178] [   T1176]  blk_unregister_queue+0x13f/0x2b0
[   68.227181] [   T1176]  __del_gendisk+0x263/0x9e0
[   68.227184] [   T1176]  ? down_read+0x13b/0x480
[   68.227185] [   T1176]  ? __pfx___del_gendisk+0x10/0x10
[   68.227187] [   T1176]  ? __pfx_down_read+0x10/0x10
[   68.227188] [   T1176]  ? up_write+0x294/0x510
[   68.227193] [   T1176]  del_gendisk+0x102/0x190
[   68.227196] [   T1176]  nvme_ns_remove+0x32a/0x900 [nvme_core]
[   68.227215] [   T1176]  nvme_remove_namespaces+0x263/0x3b0 [nvme_core]
[   68.227228] [   T1176]  ? __pfx_nvme_remove_namespaces+0x10/0x10 [nvme_core]
[   68.227241] [   T1176]  nvme_do_delete_ctrl+0xf5/0x160 [nvme_core]
[   68.227252] [   T1176]  nvme_delete_ctrl_sync.cold+0x8/0xd [nvme_core]
[   68.227263] [   T1176]  nvme_sysfs_delete+0x96/0xc0 [nvme_core]
[   68.227274] [   T1176]  ? __pfx_sysfs_kf_write+0x10/0x10
[   68.227276] [   T1176]  kernfs_fop_write_iter+0x3d6/0x5e0
[   68.227279] [   T1176]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[   68.227280] [   T1176]  vfs_write+0x52c/0xf80
[   68.227283] [   T1176]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   68.227284] [   T1176]  ? do_syscall_64+0x208/0x14c0
[   68.227286] [   T1176]  ? __pfx_vfs_write+0x10/0x10
[   68.227288] [   T1176]  ? __pfx___call_rcu_common.constprop.0+0x10/0x10
[   68.227292] [   T1176]  ? fput_close_sync+0xda/0x1b0
[   68.227294] [   T1176]  ? kmem_cache_free+0x3d5/0x670
[   68.227298] [   T1176]  ksys_write+0xfb/0x200
[   68.227300] [   T1176]  ? __pfx_ksys_write+0x10/0x10
[   68.227301] [   T1176]  ? __pfx_fput_close_sync+0x10/0x10
[   68.227304] [   T1176]  ? do_raw_spin_unlock+0x55/0x230
[   68.227306] [   T1176]  do_syscall_64+0xdd/0x14c0
[   68.227308] [   T1176]  ? lockdep_hardirqs_on+0x88/0x130
[   68.227310] [   T1176]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   68.227311] [   T1176]  ? do_syscall_64+0x208/0x14c0
[   68.227312] [   T1176]  ? __pfx_fput_close_sync+0x10/0x10
[   68.227315] [   T1176]  ? do_raw_spin_unlock+0x55/0x230
[   68.227317] [   T1176]  ? rcu_is_watching+0x11/0xb0
[   68.227319] [   T1176]  ? do_syscall_64+0x32/0x14c0
[   68.227321] [   T1176]  ? preempt_count_add+0x7f/0x190
[   68.227324] [   T1176]  ? do_syscall_64+0x5d/0x14c0
[   68.227325] [   T1176]  ? do_syscall_64+0x8d/0x14c0
[   68.227327] [   T1176]  ? irqentry_exit+0xf1/0x720
[   68.227329] [   T1176]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   68.227332] [   T1176] RIP: 0033:0x7f2bda4a5c5e
[   68.227336] [   T1176] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   68.227338] [   T1176] RSP: 002b:00007ffd31a34a80 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   68.227341] [   T1176] RAX: ffffffffffffffda RBX: 00007f2bda66f9a6 RCX: 00007f2bda4a5c5e
[   68.227342] [   T1176] RDX: 0000000000000001 RSI: 00007f2bda66f9a6 RDI: 0000000000000003
[   68.227343] [   T1176] RBP: 00007ffd31a34a90 R08: 0000000000000000 R09: 0000000000000000
[   68.227344] [   T1176] R10: 0000000000000000 R11: 0000000000000202 R12: 000000001a0cc860
[   68.227345] [   T1176] R13: 000000001a0ce580 R14: 000000001a0cc680 R15: 0000000000000000
[   68.227348] [   T1176]  </TASK>


[6] kmemleak at nvme/045

(Unfortunately, symbols of unloaded drivers are not decoded)

unreferenced object 0xffff88813299b200 (size 256):
  comm "kworker/u16:7", pid 303, jiffies 4305033663
  hex dump (first 32 bytes):
    de 3a b7 1e 89 3f ef 5c 65 7f d0 5f 6d a6 6c 9d  .:...?.\e.._m.l.
    91 ed b3 2c d6 8a 22 cb 46 b8 88 d4 50 2a 9d 29  ...,..".F...P*.)
  backtrace (crc d02fff80):
    __kmalloc_noprof+0x5c7/0x7f0
    0xffffffffc1bb29e1
    0xffffffffc1bacb8e
    process_one_work+0x8b4/0x1640
    worker_thread+0x606/0xff0
    kthread+0x368/0x460
    ret_from_fork+0x653/0x9d0
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xffff88810c07ea00 (size 256):
  comm "kworker/u16:0", pid 1916, jiffies 4305033682
  hex dump (first 32 bytes):
    86 8a 8c 5e fc 0e 67 0a 66 d9 2e e8 d5 3f 1a 86  ...^..g.f....?..
    6c 45 52 8b 9b 00 b1 6f 3b 56 ba 74 10 50 2d 95  lER....o;V.t.P-.
  backtrace (crc 283a2b5):
    __kmalloc_noprof+0x5c7/0x7f0
    0xffffffffc1bb29e1
    0xffffffffc1bacb8e
    process_one_work+0x8b4/0x1640
    worker_thread+0x606/0xff0
    kthread+0x368/0x460
    ret_from_fork+0x653/0x9d0
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xffff88814c1e6600 (size 256):
  comm "kworker/u16:0", pid 1916, jiffies 4305033695
  hex dump (first 32 bytes):
    09 e2 48 6f 9d 3a ae 44 84 0b 11 03 fc 47 8a 3b  ..Ho.:.D.....G.;
    3f 53 ab 25 bd ca 98 5e 77 78 eb 4c 8b f4 d7 5e  ?S.%...^wx.L...^
  backtrace (crc 284bb03b):
    __kmalloc_noprof+0x5c7/0x7f0
    0xffffffffc1bb29e1
    0xffffffffc1bacb8e
    process_one_work+0x8b4/0x1640
    worker_thread+0x606/0xff0
    kthread+0x368/0x460
    ret_from_fork+0x653/0x9d0
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xffff8881268ac080 (size 32):
  comm "kworker/u16:1", pid 1920, jiffies 4305418991
  hex dump (first 32 bytes):
    77 81 56 74 ac d5 3e 96 13 51 35 b7 1c d3 12 fa  w.Vt..>..Q5.....
    75 68 69 43 66 97 1e 2e 7d f2 70 8c c9 2b 03 1a  uhiCf...}.p..+..
  backtrace (crc ebaf1ed9):
    __kmalloc_noprof+0x5c7/0x7f0
    0xffffffffc1bae361
    process_one_work+0x8b4/0x1640
    worker_thread+0x606/0xff0
    kthread+0x368/0x460
    ret_from_fork+0x653/0x9d0
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xffff8881032289c0 (size 32):
  comm "kworker/u16:1", pid 1920, jiffies 4305418996
  hex dump (first 32 bytes):
    bf b9 e5 a3 14 40 21 d9 cf 83 7e d6 4c 6d 96 a7  .....@!...~.Lm..
    37 db 2c 70 ab 81 d2 31 28 e7 45 a4 81 98 a6 ac  7.,p...1(.E.....
  backtrace (crc 98f08252):
    __kmalloc_node_track_caller_noprof+0x60f/0x860
    kmemdup_noprof+0x1e/0x40
    0xffffffffc1babf05
    process_one_work+0x8b4/0x1640
    worker_thread+0x606/0xff0
    kthread+0x368/0x460
    ret_from_fork+0x653/0x9d0
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xffff88814a880cc0 (size 32):
  comm "kworker/u16:3", pid 14486, jiffies 4305419259
  hex dump (first 32 bytes):
    fd a3 33 db 24 38 bd 54 2c 74 74 b8 49 4d fd ac  ..3.$8.T,tt.IM..
    86 a2 cf 6e 23 7b a0 f0 eb cc 17 2d 46 13 aa fb  ...n#{.....-F...
  backtrace (crc 48efe929):
    __kmalloc_noprof+0x5c7/0x7f0
    0xffffffffc1bae361
    process_one_work+0x8b4/0x1640
    worker_thread+0x606/0xff0
    kthread+0x368/0x460
    ret_from_fork+0x653/0x9d0
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xffff88811afa3e80 (size 32):
  comm "kworker/u16:3", pid 14486, jiffies 4305419266
  hex dump (first 32 bytes):
    dd 06 a6 2f 4a 7c fb 7b 46 73 ab 0f 58 29 a0 e6  .../J|.{Fs..X)..
    4d a2 08 ea 70 30 38 42 6d 9c 0f 92 12 db 03 cb  M...p08Bm.......
  backtrace (crc 6eb836f):
    __kmalloc_node_track_caller_noprof+0x60f/0x860
    kmemdup_noprof+0x1e/0x40
    0xffffffffc1babf05
    process_one_work+0x8b4/0x1640
    worker_thread+0x606/0xff0
    kthread+0x368/0x460
    ret_from_fork+0x653/0x9d0
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xffff8881ca73c300 (size 32):
  comm "kworker/u16:3", pid 14486, jiffies 4305419271
  hex dump (first 32 bytes):
    8a ca 11 a5 07 dd f6 32 4a 2f dd c0 9e 53 d0 75  .......2J/...S.u
    5d 67 48 55 76 eb 5c bb 0d 7f 94 c8 30 1e 09 e7  ]gHUv.\.....0...
  backtrace (crc ddcfc613):
    __kmalloc_noprof+0x5c7/0x7f0
    0xffffffffc1bae361
    process_one_work+0x8b4/0x1640
    worker_thread+0x606/0xff0
    kthread+0x368/0x460
    ret_from_fork+0x653/0x9d0
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xffff8881ccfddec0 (size 32):
  comm "kworker/u16:3", pid 14486, jiffies 4305419276
  hex dump (first 32 bytes):
    ba f7 70 83 57 b0 dd 2e e7 53 0b f5 8d 5d 00 7a  ..p.W....S...].z
    f0 df 9b 14 5c f9 8e 49 3f 24 7a a5 45 f8 c0 ac  ....\..I?$z.E...
  backtrace (crc 87f5af03):
    __kmalloc_node_track_caller_noprof+0x60f/0x860
    kmemdup_noprof+0x1e/0x40
    0xffffffffc1babf05
    process_one_work+0x8b4/0x1640
    worker_thread+0x606/0xff0
    kthread+0x368/0x460
    ret_from_fork+0x653/0x9d0
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xffff888126848c80 (size 32):
  comm "kworker/u16:3", pid 14486, jiffies 4305419282
  hex dump (first 32 bytes):
    72 8c de 2f 96 02 7a 70 bc cc 99 5e 44 e8 c4 1b  r../..zp...^D...
    61 ed b8 97 9c 1d cb 48 be 8d f7 6e 98 fa b5 f9  a......H...n....
  backtrace (crc b705e8f1):
    __kmalloc_noprof+0x5c7/0x7f0
    0xffffffffc1bae361
    process_one_work+0x8b4/0x1640
    worker_thread+0x606/0xff0
    kthread+0x368/0x460
    ret_from_fork+0x653/0x9d0
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xffff888126848440 (size 32):
  comm "kworker/u16:3", pid 14486, jiffies 4305419287
  hex dump (first 32 bytes):
    01 2b 91 26 9c b5 ab 59 50 60 2f e1 0b a4 05 9d  .+.&...YP`/.....
    8b 0a 71 ae 3e 62 6e cc fc 3a 0d 20 01 5f f1 38  ..q.>bn..:. ._.8
  backtrace (crc 41d8e0f8):
    __kmalloc_node_track_caller_noprof+0x60f/0x860
    kmemdup_noprof+0x1e/0x40
    0xffffffffc1babf05
    process_one_work+0x8b4/0x1640
    worker_thread+0x606/0xff0
    kthread+0x368/0x460
    ret_from_fork+0x653/0x9d0
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xffff888131285800 (size 1024):
  comm "kworker/u16:3", pid 14486, jiffies 4305419374
  hex dump (first 32 bytes):
    d4 81 86 9f 8b d5 c8 14 6d a1 29 79 6c d4 c3 81  ........m.)yl...
    38 13 4b ab e9 7d 15 1a 6b a8 f5 c7 be 4f 68 fd  8.K..}..k....Oh.
  backtrace (crc 247d825d):
    __kmalloc_noprof+0x5c7/0x7f0
    0xffffffffc1bb29e1
    0xffffffffc1bacb8e
    process_one_work+0x8b4/0x1640
    worker_thread+0x606/0xff0
    kthread+0x368/0x460
    ret_from_fork+0x653/0x9d0
    ret_from_fork_asm+0x1a/0x30


[7] WARN, BUG and hang at nvme/058 fc transport

...
[  293.665982][  T291] nvmet_fc: {2:1}: Association created
[  293.670038][  T291] nvmet_fc: {5:2}: Association created
[  293.671603][ T1367] nvmet: Created nvm controller 9 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  293.672532][  T291] nvmet: Created nvm controller 10 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  293.677966][   T48] nvmet_fc: {5:1}: Association freed
[  293.679101][   T77] (NULL device *): Disconnect LS failed: No Association
[  293.679348][   T82] nvme nvme5: NVME-FC{0}: controller connect complete
[  293.682751][  T290] nvme nvme10: NVME-FC{5}: controller connect complete
[  293.684671][  T299] nvmet_fc: {2:0}: Association deleted
[  293.687820][ T1376] nvmet_fc: {4:1}: Association freed
[  293.690346][   T14] nvmet_fc: {5:0}: Association deleted
[  293.691727][  T300] nvmet_fc: {1:1}: Association deleted
[  293.692723][ T4548] (NULL device *): Disconnect LS failed: No Association
[  293.696209][ T1437] nvme nvme7: NVME-FC{2}: controller connect complete
[  293.700784][ T1438] nvme nvme8: rescanning namespaces.
[  293.703147][   T75] nvme nvme7: Identify Descriptors failed (nsid=1, status=0xfffffffc)
[  293.703575][  T303] nvme nvme7: NVME-FC{2}: io failed due to lldd error -125
[  293.704038][   T76] nvme nvme7: identifiers changed for nsid 2
[  293.705044][    C2] ------------[ cut here ]------------
[  293.705861][  T290] nvme nvme7: identifiers changed for nsid 3
[  293.706405][    C2] DEBUG_LOCKS_WARN_ON(1)
[  293.706406][    C2] WARNING: kernel/locking/lockdep.c:238 at __lock_acquire+0xfa0/0x2230, CPU#2: ksoftirqd/2/32
[  293.706417][    C2] Modules linked in: nvme_fcloop nvmet_fc nvme_fc nvmet nvme_fabrics nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables qrtr sunrpc 9pnet_virtio 9pnet pcspkr netfs i2c_piix4 i2c_smbus loop dm_multipath nfnetlink zram vmw_vsock_virtio_transport vmw_vsock_virtio_transport_common vsock bochs drm_client_lib xfs drm_shmem_helper drm_kms_helper nvme drm nvme_core nvme_keyring e1000 sym53c8xx nvme_auth scsi_transport_spi floppy serio_raw ata_generic pata_acpi i2c_dev qemu_fw_cfg virtiofs fuse virtio_console [last unloaded: nvmet_fc]
[  293.706468][    C2] CPU: 2 UID: 0 PID: 32 Comm: ksoftirqd/2 Not tainted 7.1.0-rc1 #1 PREEMPT(full)
[  293.706471][    C2] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
[  293.706473][    C2] RIP: 0010:__lock_acquire+0xfa7/0x2230
[  293.706476][    C2] Code: 01 44 8b 44 24 08 85 c0 0f 84 bf f8 ff ff 8b 1d bf b8 79 04 85 db 0f 85 b1 f8 ff ff 48 8d 3d 10 d2 7a 04 48 c7 c6 0b b2 ee 8d <67> 48 0f b9 3a 31 c0 44 8b 44 24 08 e9 44 f2 ff ff 44 89 44 24 08
[  293.706478][    C2] RSP: 0018:ffff888100e97b30 EFLAGS: 00010046
[  293.706481][    C2] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000001
[  293.706482][    C2] RDX: 0000000000000001 RSI: ffffffff8deeb20b RDI: ffffffff8ee90120
[  293.706483][    C2] RBP: ffff888100e38000 R08: 0000000000000001 R09: fffffbfff1dcfcf8
[  293.706484][    C2] R10: fffffbfff1dcfcf9 R11: 0000000000000001 R12: ffff888100e38f98
[  293.706485][    C2] R13: 0000000000000000 R14: 1eb851eb851775c4 R15: 0000000000000000
[  293.706487][    C2] FS:  0000000000000000(0000) GS:ffff88841e189000(0000) knlGS:0000000000000000
[  293.706488][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  293.706489][    C2] CR2: 00007f7407ee7cc0 CR3: 00000001412be000 CR4: 00000000000006f0
[  293.706494][    C2] Call Trace:
[  293.706495][    C2]  <TASK>
[  293.706497][    C2]  ? rcu_is_watching+0x11/0xb0
[  293.706502][    C2]  ? hrtimer_start_range_ns+0x105a/0x19f0
[  293.706506][    C2]  lock_acquire+0x1a4/0x330
[  293.706508][    C2]  ? complete+0x1c/0x250
[  293.706512][    C2]  ? finish_task_switch.isra.0+0x258/0xc40
[  293.706515][    C2]  ? trace_hardirqs_on+0x15/0x1a0
[  293.706520][    C2]  ? lockdep_hardirqs_on+0x88/0x130
[  293.706525][    C2]  ? finish_task_switch.isra.0+0x258/0xc40
[  293.706528][    C2]  _raw_spin_lock_irqsave+0x44/0x60
[  293.706530][    C2]  ? complete+0x1c/0x250
[  293.706533][    C2]  complete+0x1c/0x250
[  293.706536][    C2]  blk_end_sync_rq+0x5c/0xa0
[  293.706541][    C2]  ? __pfx_blk_end_sync_rq+0x10/0x10
[  293.706543][    C2]  blk_mq_end_request+0x1b4/0x370
[  293.706545][    C2]  ? nvme_complete_rq+0x18a/0x560 [nvme_core]
[  293.706564][    C2]  nvme_fc_complete_rq+0x240/0x350 [nvme_fc]
[  293.706572][    C2]  blk_complete_reqs+0xa8/0x120
[  293.706574][    C2]  ? trace_hardirqs_on+0x15/0x1a0
[  293.706576][    C2]  ? blk_done_softirq+0x16/0x60
[  293.710125][ T1437] nvme nvme8: IDs don't match for shared namespace 1
[  293.712871][    C2]  handle_softirqs+0x1ee/0x890
[  293.712878][    C2]  ? __pfx_handle_softirqs+0x10/0x10
[  293.712880][    C2]  ? lock_release+0x1a7/0x310
[  293.712884][    C2]  ? rcu_is_watching+0x11/0xb0
[  293.712888][    C2]  run_ksoftirqd+0x3b/0x60
[  293.714261][ T1376] nvme nvme8: IDs don't match for shared namespace 3
[  293.714374][    C2]  smpboot_thread_fn+0x2fd/0x9a0
[  293.714751][   T75] nvme nvme8: IDs don't match for shared namespace 2
[  293.716018][    C2]  ? __pfx_smpboot_thread_fn+0x10/0x10
[  293.716021][    C2]  kthread+0x368/0x460
[  293.716024][    C2]  ? _raw_spin_unlock_irq+0x24/0x50
[  293.765612][    C2]  ? __pfx_kthread+0x10/0x10
[  293.766483][    C2]  ret_from_fork+0x653/0x9d0
[  293.767314][    C2]  ? __pfx_ret_from_fork+0x10/0x10
[  293.768144][    C2]  ? __switch_to+0x16d/0xdc0
[  293.768939][    C2]  ? __switch_to_asm+0x39/0x70
[  293.769723][    C2]  ? __switch_to_asm+0x33/0x70
[  293.770464][    C2]  ? __pfx_kthread+0x10/0x10
[  293.771186][    C2]  ret_from_fork_asm+0x1a/0x30
[  293.771921][    C2]  </TASK>
[  293.772576][    C2] irq event stamp: 11301453
[  293.773250][    C2] hardirqs last  enabled at (11301452): [<ffffffff8a524db6>] handle_softirqs+0x1a6/0x890
[  293.774313][    C2] hardirqs last disabled at (11301453): [<ffffffff8d1d091c>] _raw_spin_lock_irqsave+0x5c/0x60
[  293.775369][    C2] softirqs last  enabled at (11301446): [<ffffffff8a525c9b>] run_ksoftirqd+0x3b/0x60
[  293.776397][    C2] softirqs last disabled at (11301451): [<ffffffff8a525c9b>] run_ksoftirqd+0x3b/0x60
[  293.777412][    C2] ---[ end trace 0000000000000000 ]---
[  293.778178][    C2] BUG: kernel NULL pointer dereference, address: 00000000000000c4
[  293.779078][    C2] #PF: supervisor read access in kernel mode
[  293.779827][    C2] #PF: error_code(0x0000) - not-present page
[  293.780610][    C2] PGD 0 P4D 0
[  293.781248][    C2] Oops: Oops: 0000 [#1] SMP KASAN PTI
[  293.782027][    C2] CPU: 2 UID: 0 PID: 32 Comm: ksoftirqd/2 Tainted: G        W           7.1.0-rc1 #1 PREEMPT(full)
[  293.783217][    C2] Tainted: [W]=WARN
[  293.783927][    C2] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
[  293.785031][    C2] RIP: 0010:__lock_acquire+0x1fc/0x2230
[  293.785824][    C2] Code: 24 20 41 89 44 24 24 4c 89 f0 25 ff 1f 00 00 48 0f a3 05 67 04 96 05 0f 83 4d 06 00 00 48 69 c0 c8 00 00 00 48 05 c0 29 04 90 <0f> b6 98 c4 00 00 00 41 0f b7 44 24 20 66 25 ff 1f 0f b7 c0 48 0f
[  293.787939][    C2] RSP: 0018:ffff888100e97b30 EFLAGS: 00010046
[  293.788843][    C2] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
[  293.789807][    C2] RDX: 0000000000000001 RSI: ffffffff8deeb20b RDI: ffffffff8ee90120
[  293.790764][    C2] RBP: ffff888100e38000 R08: 0000000000000001 R09: fffffbfff1dcfcf8
[  293.791750][    C2] R10: fffffbfff1dcfcf9 R11: 0000000000000001 R12: ffff888100e38f98
[  293.792708][    C2] R13: 0000000000000000 R14: 1eb851eb851775c4 R15: 0000000000000000
[  293.793679][    C2] FS:  0000000000000000(0000) GS:ffff88841e189000(0000) knlGS:0000000000000000
[  293.794756][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  293.795643][    C2] CR2: 00000000000000c4 CR3: 00000001412be000 CR4: 00000000000006f0
[  293.796621][    C2] Call Trace:
[  293.797294][    C2]  <TASK>
[  293.797942][    C2]  ? rcu_is_watching+0x11/0xb0
[  293.798782][    C2]  ? hrtimer_start_range_ns+0x105a/0x19f0
[  293.799670][    C2]  lock_acquire+0x1a4/0x330
[  293.800447][    C2]  ? complete+0x1c/0x250
[  293.801215][    C2]  ? finish_task_switch.isra.0+0x258/0xc40
[  293.802088][    C2]  ? trace_hardirqs_on+0x15/0x1a0
[  293.802912][    C2]  ? lockdep_hardirqs_on+0x88/0x130
[  293.803703][    C2]  ? finish_task_switch.isra.0+0x258/0xc40
[  293.804532][    C2]  _raw_spin_lock_irqsave+0x44/0x60
[  293.805314][    C2]  ? complete+0x1c/0x250
[  293.806067][    C2]  complete+0x1c/0x250
[  293.806775][    C2]  blk_end_sync_rq+0x5c/0xa0
[  293.807502][    C2]  ? __pfx_blk_end_sync_rq+0x10/0x10
[  293.808278][    C2]  blk_mq_end_request+0x1b4/0x370
[  293.809095][    C2]  ? nvme_complete_rq+0x18a/0x560 [nvme_core]
[  293.810006][    C2]  nvme_fc_complete_rq+0x240/0x350 [nvme_fc]
[  293.810910][    C2]  blk_complete_reqs+0xa8/0x120
[  293.811703][    C2]  ? trace_hardirqs_on+0x15/0x1a0
[  293.812503][    C2]  ? blk_done_softirq+0x16/0x60
[  293.813293][    C2]  handle_softirqs+0x1ee/0x890
[  293.814172][    C2]  ? __pfx_handle_softirqs+0x10/0x10
[  293.815037][    C2]  ? lock_release+0x1a7/0x310
[  293.815931][    C2]  ? rcu_is_watching+0x11/0xb0
[  293.816782][    C2]  run_ksoftirqd+0x3b/0x60
[  293.817561][    C2]  smpboot_thread_fn+0x2fd/0x9a0
[  293.818362][    C2]  ? __pfx_smpboot_thread_fn+0x10/0x10
[  293.819148][    C2]  kthread+0x368/0x460
[  293.819894][    C2]  ? _raw_spin_unlock_irq+0x24/0x50
[  293.820672][    C2]  ? __pfx_kthread+0x10/0x10
[  293.821397][    C2]  ret_from_fork+0x653/0x9d0
[  293.822153][    C2]  ? __pfx_ret_from_fork+0x10/0x10
[  293.822913][    C2]  ? __switch_to+0x16d/0xdc0
[  293.823627][    C2]  ? __switch_to_asm+0x39/0x70
[  293.824351][    C2]  ? __switch_to_asm+0x33/0x70
[  293.825063][    C2]  ? __pfx_kthread+0x10/0x10
[  293.825769][    C2]  ret_from_fork_asm+0x1a/0x30
[  293.826466][    C2]  </TASK>
[  293.827053][    C2] Modules linked in: nvme_fcloop nvmet_fc nvme_fc nvmet nvme_fabrics nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables qrtr sunrpc 9pnet_virtio 9pnet pcspkr netfs i2c_piix4 i2c_smbus loop dm_multipath nfnetlink zram vmw_vsock_virtio_transport vmw_vsock_virtio_transport_common vsock bochs drm_client_lib xfs drm_shmem_helper drm_kms_helper nvme drm nvme_core nvme_keyring e1000 sym53c8xx nvme_auth scsi_transport_spi floppy serio_raw ata_generic pata_acpi i2c_dev qemu_fw_cfg virtiofs fuse virtio_console [last unloaded: nvmet_fc]
[  293.833056][    C2] CR2: 00000000000000c4
[  293.833850][    C2] ---[ end trace 0000000000000000 ]---
[  293.834748][    C2] RIP: 0010:__lock_acquire+0x1fc/0x2230
[  293.835608][    C2] Code: 24 20 41 89 44 24 24 4c 89 f0 25 ff 1f 00 00 48 0f a3 05 67 04 96 05 0f 83 4d 06 00 00 48 69 c0 c8 00 00 00 48 05 c0 29 04 90 <0f> b6 98 c4 00 00 00 41 0f b7 44 24 20 66 25 ff 1f 0f b7 c0 48 0f
[  293.838612][    C2] RSP: 0018:ffff888100e97b30 EFLAGS: 00010046
[  293.839454][    C2] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
[  293.840421][    C2] RDX: 0000000000000001 RSI: ffffffff8deeb20b RDI: ffffffff8ee90120
[  293.841417][    C2] RBP: ffff888100e38000 R08: 0000000000000001 R09: fffffbfff1dcfcf8
[  293.842417][    C2] R10: fffffbfff1dcfcf9 R11: 0000000000000001 R12: ffff888100e38f98
[  293.843433][    C2] R13: 0000000000000000 R14: 1eb851eb851775c4 R15: 0000000000000000
[  293.844463][    C2] FS:  0000000000000000(0000) GS:ffff88841e189000(0000) knlGS:0000000000000000
[  293.845496][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  293.846406][    C2] CR2: 00000000000000c4 CR3: 00000001412be000 CR4: 00000000000006f0
[  293.847520][    C2] Kernel panic - not syncing: Fatal exception in interrupt
[  293.850079][    C2] Kernel Offset: 0x9000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  293.851457][    C2] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---


[9] dmesg at nbd/002

[   68.349737] [   T1093] run blktests nbd/002 at 2026-04-28 13:46:39
[   69.096569] [   T1124] nbd0: detected capacity change from 0 to 20971520

[   69.103872] [   T1087] ======================================================
[   69.104746] [   T1087] WARNING: possible circular locking dependency detected
[   69.105632] [   T1087] 7.1.0-rc1 #1 Not tainted
[   69.106815] [   T1087] ------------------------------------------------------
[   69.107767] [   T1087] (udev-worker)/1087 is trying to acquire lock:
[   69.108609] [   T1087] ffff88810d651d58 (sk_lock-AF_INET6){+.+.}-{0:0}, at: tcp_sendmsg+0x1c/0x50
[   69.109745] [   T1087] 
                          but task is already holding lock:
[   69.110999] [   T1087] ffff888131cb5868 (&nsock->tx_lock){+.+.}-{4:4}, at: nbd_queue_rq+0x361/0xe50 [nbd]
[   69.112349] [   T1087] 
                          which lock already depends on the new lock.

[   69.113756] [   T1087] 
                          the existing dependency chain (in reverse order) is:
[   69.114918] [   T1087] 
                          -> #6 (&nsock->tx_lock){+.+.}-{4:4}:
[   69.115971] [   T1087]        __mutex_lock+0x1ae/0x2600
[   69.116645] [   T1087]        nbd_queue_rq+0x361/0xe50 [nbd]
[   69.117392] [   T1087]        blk_mq_dispatch_rq_list+0x39b/0x2340
[   69.118182] [   T1087]        __blk_mq_sched_dispatch_requests+0xabb/0x1510
[   69.119086] [   T1087]        blk_mq_sched_dispatch_requests+0xa8/0x150
[   69.119971] [   T1087]        blk_mq_run_hw_queue+0x1c9/0x520
[   69.120787] [   T1087]        blk_mq_dispatch_list+0x4e0/0x13a0
[   69.121555] [   T1087]        blk_mq_flush_plug_list+0xf8/0x680
[   69.122270] [   T1087]        __blk_flush_plug+0x26a/0x4e0
[   69.122979] [   T1087]        __submit_bio+0x492/0x5f0
[   69.123588] [   T1087]        submit_bio_noacct_nocheck+0x41f/0xb40
[   69.124360] [   T1087]        block_read_full_folio+0x3db/0x780
[   69.125051] [   T1087]        filemap_read_folio+0xa2/0x200
[   69.125759] [   T1087]        do_read_cache_folio+0x1af/0x430
[   69.126491] [   T1087]        read_part_sector+0xb9/0x2c0
[   69.127201] [   T1087]        read_lba+0x183/0x2f0
[   69.127857] [   T1087]        efi_partition+0x227/0x1f80
[   69.128571] [   T1087]        bdev_disk_changed+0x5da/0xe60
[   69.129309] [   T1087]        blkdev_get_whole+0x144/0x200
[   69.130009] [   T1087]        bdev_open+0x610/0xc60
[   69.131048] [   T1087]        blkdev_open+0x2a7/0x450
[   69.132032] [   T1087]        do_dentry_open+0x418/0x1240
[   69.133050] [   T1087]        vfs_open+0x76/0x440
[   69.133985] [   T1087]        path_openat+0x1baf/0x30a0
[   69.134932] [   T1087]        do_file_open+0x1ce/0x460
[   69.135855] [   T1087]        do_sys_openat2+0xde/0x170
[   69.136787] [   T1087]        __x64_sys_openat+0x10a/0x210
[   69.137802] [   T1087]        do_syscall_64+0xdd/0x14c0
[   69.138764] [   T1087]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   69.139877] [   T1087] 
                          -> #5 (&cmd->lock){+.+.}-{4:4}:
[   69.141276] [   T1087]        __mutex_lock+0x1ae/0x2600
[   69.142134] [   T1087]        nbd_queue_rq+0xa9/0xe50 [nbd]
[   69.143039] [   T1087]        blk_mq_dispatch_rq_list+0x39b/0x2340
[   69.143989] [   T1087]        __blk_mq_sched_dispatch_requests+0xabb/0x1510
[   69.145092] [   T1087]        blk_mq_sched_dispatch_requests+0xa8/0x150
[   69.146151] [   T1087]        blk_mq_run_hw_queue+0x1c9/0x520
[   69.147099] [   T1087]        blk_mq_dispatch_list+0x4e0/0x13a0
[   69.148071] [   T1087]        blk_mq_flush_plug_list+0xf8/0x680
[   69.148974] [   T1087]        __blk_flush_plug+0x26a/0x4e0
[   69.149832] [   T1087]        __submit_bio+0x492/0x5f0
[   69.150710] [   T1087]        submit_bio_noacct_nocheck+0x41f/0xb40
[   69.151732] [   T1087]        block_read_full_folio+0x3db/0x780
[   69.152731] [   T1087]        filemap_read_folio+0xa2/0x200
[   69.153638] [   T1087]        do_read_cache_folio+0x1af/0x430
[   69.154548] [   T1087]        read_part_sector+0xb9/0x2c0
[   69.155445] [   T1087]        read_lba+0x183/0x2f0
[   69.156219] [   T1087]        efi_partition+0x227/0x1f80
[   69.157040] [   T1087]        bdev_disk_changed+0x5da/0xe60
[   69.157895] [   T1087]        blkdev_get_whole+0x144/0x200
[   69.158749] [   T1087]        bdev_open+0x610/0xc60
[   69.159562] [   T1087]        blkdev_open+0x2a7/0x450
[   69.160425] [   T1087]        do_dentry_open+0x418/0x1240
[   69.161346] [   T1087]        vfs_open+0x76/0x440
[   69.162154] [   T1087]        path_openat+0x1baf/0x30a0
[   69.162998] [   T1087]        do_file_open+0x1ce/0x460
[   69.164717] [   T1087]        do_sys_openat2+0xde/0x170
[   69.166075] [   T1087]        __x64_sys_openat+0x10a/0x210
[   69.166942] [   T1087]        do_syscall_64+0xdd/0x14c0
[   69.168879] [   T1087]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   69.170567] [   T1087] 
                          -> #4 (set->srcu){.+.+}-{0:0}:
[   69.172603] [   T1087]        __synchronize_srcu+0xa1/0x2b0
[   69.173558] [   T1087]        elevator_switch+0x12f/0x680
[   69.174494] [   T1087]        elevator_change+0x2d8/0x4f0
[   69.175398] [   T1087]        elevator_set_default+0x232/0x2e0
[   69.176357] [   T1087]        blk_register_queue+0x40e/0x5b0
[   69.177304] [   T1087]        __add_disk+0x5fd/0xd50
[   69.178043] [   T1087]        add_disk_fwnode+0x10f/0x590
[   69.178846] [   T1087]        nbd_dev_add+0x6cd/0xa50 [nbd]
[   69.179806] [   T1087]        0xffffffffc0bf814c
[   69.180666] [   T1087]        do_one_initcall+0xd1/0x4f0
[   69.181594] [   T1087]        do_init_module+0x281/0x840
[   69.182469] [   T1087]        load_module+0x63c5/0x7000
[   69.183407] [   T1087]        init_module_from_file+0x161/0x180
[   69.184557] [   T1087]        idempotent_init_module+0x226/0x760
[   69.185536] [   T1087]        __x64_sys_finit_module+0xc9/0x160
[   69.186483] [   T1087]        do_syscall_64+0xdd/0x14c0
[   69.187355] [   T1087]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   69.188385] [   T1087] 
                          -> #3 (&q->elevator_lock){+.+.}-{4:4}:
[   69.189803] [   T1087]        __mutex_lock+0x1ae/0x2600
[   69.190722] [   T1087]        elevator_change+0x188/0x4f0
[   69.191621] [   T1087]        elv_iosched_store+0x308/0x390
[   69.192547] [   T1087]        queue_attr_store+0x23b/0x360
[   69.193447] [   T1087]        kernfs_fop_write_iter+0x3d6/0x5e0
[   69.194411] [   T1087]        vfs_write+0x52c/0xf80
[   69.195234] [   T1087]        ksys_write+0xfb/0x200
[   69.196024] [   T1087]        do_syscall_64+0xdd/0x14c0
[   69.196858] [   T1087]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   69.197961] [   T1087] 
                          -> #2 (&q->q_usage_counter(io)){++++}-{0:0}:
[   69.199568] [   T1087]        blk_alloc_queue+0x5b3/0x730
[   69.200375] [   T1087]        blk_mq_alloc_queue+0x13f/0x250
[   69.200992] [   T1087]        scsi_alloc_sdev+0x84e/0xca0
[   69.201610] [   T1087]        scsi_probe_and_add_lun+0x63f/0xc30
[   69.202405] [   T1087]        __scsi_add_device+0x1be/0x1f0
[   69.203065] [   T1087]        ata_scsi_scan_host+0x139/0x3a0
[   69.203686] [   T1087]        async_run_entry_fn+0x93/0x550
[   69.204376] [   T1087]        process_one_work+0x8b4/0x1640
[   69.205011] [   T1087]        worker_thread+0x606/0xff0
[   69.205638] [   T1087]        kthread+0x368/0x460
[   69.206274] [   T1087]        ret_from_fork+0x653/0x9d0
[   69.207167] [   T1087]        ret_from_fork_asm+0x1a/0x30
[   69.208017] [   T1087] 
                          -> #1 (fs_reclaim){+.+.}-{0:0}:
[   69.209623] [   T1087]        fs_reclaim_acquire+0xd5/0x120
[   69.210712] [   T1087]        __kmalloc_noprof+0x9b/0x7f0
[   69.211745] [   T1087]        sock_kmalloc+0xec/0x150
[   69.213005] [   T1087]        __ipv6_sock_mc_join+0x261/0x780
[   69.214115] [   T1087]        do_ipv6_setsockopt+0x2b00/0x3740
[   69.215173] [   T1087]        ipv6_setsockopt+0x79/0xf0
[   69.216007] [   T1087]        do_sock_setsockopt+0x156/0x380
[   69.216868] [   T1087]        __sys_setsockopt+0xe0/0x150
[   69.217786] [   T1087]        __x64_sys_setsockopt+0xb9/0x180
[   69.218573] [   T1087]        do_syscall_64+0xdd/0x14c0
[   69.219235] [   T1087]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   69.219975] [   T1087] 
                          -> #0 (sk_lock-AF_INET6){+.+.}-{0:0}:
[   69.221119] [   T1087]        __lock_acquire+0x14a6/0x2230
[   69.221748] [   T1087]        lock_acquire+0x1a4/0x330
[   69.222393] [   T1087]        lock_sock_nested+0x32/0xf0
[   69.222996] [   T1087]        tcp_sendmsg+0x1c/0x50
[   69.223621] [   T1087]        sock_sendmsg+0x242/0x370
[   69.224264] [   T1087]        __sock_xmit+0x22c/0x4b0 [nbd]
[   69.224920] [   T1087]        nbd_send_cmd+0x63c/0x15c0 [nbd]
[   69.225623] [   T1087]        nbd_queue_rq+0x9c1/0xe50 [nbd]
[   69.226331] [   T1087]        blk_mq_dispatch_rq_list+0x39b/0x2340
[   69.227024] [   T1087]        __blk_mq_sched_dispatch_requests+0xabb/0x1510
[   69.227755] [   T1087]        blk_mq_sched_dispatch_requests+0xa8/0x150
[   69.228528] [   T1087]        blk_mq_run_hw_queue+0x1c9/0x520
[   69.229252] [   T1087]        blk_mq_dispatch_list+0x4e0/0x13a0
[   69.229922] [   T1087]        blk_mq_flush_plug_list+0xf8/0x680
[   69.230641] [   T1087]        __blk_flush_plug+0x26a/0x4e0
[   69.231342] [   T1087]        __submit_bio+0x492/0x5f0
[   69.231992] [   T1087]        submit_bio_noacct_nocheck+0x41f/0xb40
[   69.232786] [   T1087]        block_read_full_folio+0x3db/0x780
[   69.233589] [   T1087]        filemap_read_folio+0xa2/0x200
[   69.234298] [   T1087]        do_read_cache_folio+0x1af/0x430
[   69.236024] [   T1087]        read_part_sector+0xb9/0x2c0
[   69.236753] [   T1087]        read_lba+0x183/0x2f0
[   69.237457] [   T1087]        efi_partition+0x227/0x1f80
[   69.238125] [   T1087]        bdev_disk_changed+0x5da/0xe60
[   69.238849] [   T1087]        blkdev_get_whole+0x144/0x200
[   69.240303] [   T1087]        bdev_open+0x610/0xc60
[   69.240997] [   T1087]        blkdev_open+0x2a7/0x450
[   69.241687] [   T1087]        do_dentry_open+0x418/0x1240
[   69.242425] [   T1087]        vfs_open+0x76/0x440
[   69.243053] [   T1087]        path_openat+0x1baf/0x30a0
[   69.243695] [   T1087]        do_file_open+0x1ce/0x460
[   69.244420] [   T1087]        do_sys_openat2+0xde/0x170
[   69.245065] [   T1087]        __x64_sys_openat+0x10a/0x210
[   69.245721] [   T1087]        do_syscall_64+0xdd/0x14c0
[   69.246444] [   T1087]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   69.247139] [   T1087] 
                          other info that might help us debug this:

[   69.248717] [   T1087] Chain exists of:
                            sk_lock-AF_INET6 --> &cmd->lock --> &nsock->tx_lock

[   69.250577] [   T1087]  Possible unsafe locking scenario:

[   69.251714] [   T1087]        CPU0                    CPU1
[   69.252939] [   T1087]        ----                    ----
[   69.253605] [   T1087]   lock(&nsock->tx_lock);
[   69.254164] [   T1087]                                lock(&cmd->lock);
[   69.254853] [   T1087]                                lock(&nsock->tx_lock);
[   69.255590] [   T1087]   lock(sk_lock-AF_INET6);
[   69.256183] [   T1087] 
                           *** DEADLOCK ***

[   69.257688] [   T1087] 4 locks held by (udev-worker)/1087:
[   69.258368] [   T1087]  #0: ffff888128c28350 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0x6c9/0xc60
[   69.259222] [   T1087]  #1: ffff88814a827418 (set->srcu){.+.+}-{0:0}, at: blk_mq_run_hw_queue+0x1bb/0x520
[   69.260095] [   T1087]  #2: ffff88814bc28178 (&cmd->lock){+.+.}-{4:4}, at: nbd_queue_rq+0xa9/0xe50 [nbd]
[   69.260993] [   T1087]  #3: ffff888131cb5868 (&nsock->tx_lock){+.+.}-{4:4}, at: nbd_queue_rq+0x361/0xe50 [nbd]
[   69.261926] [   T1087] 
                          stack backtrace:
[   69.263024] [   T1087] CPU: 1 UID: 0 PID: 1087 Comm: (udev-worker) Not tainted 7.1.0-rc1 #1 PREEMPT(full) 
[   69.263027] [   T1087] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
[   69.263029] [   T1087] Call Trace:
[   69.263032] [   T1087]  <TASK>
[   69.263034] [   T1087]  dump_stack_lvl+0x6a/0x90
[   69.263041] [   T1087]  print_circular_bug.cold+0x185/0x1d0
[   69.263046] [   T1087]  check_noncircular+0x148/0x170
[   69.263051] [   T1087]  __lock_acquire+0x14a6/0x2230
[   69.263054] [   T1087]  ? sock_has_perm+0x20e/0x2e0
[   69.263060] [   T1087]  lock_acquire+0x1a4/0x330
[   69.263062] [   T1087]  ? tcp_sendmsg+0x1c/0x50
[   69.263066] [   T1087]  lock_sock_nested+0x32/0xf0
[   69.263071] [   T1087]  ? tcp_sendmsg+0x1c/0x50
[   69.263073] [   T1087]  tcp_sendmsg+0x1c/0x50
[   69.263076] [   T1087]  sock_sendmsg+0x242/0x370
[   69.263079] [   T1087]  ? __pfx_sock_sendmsg+0x10/0x10
[   69.263084] [   T1087]  __sock_xmit+0x22c/0x4b0 [nbd]
[   69.263095] [   T1087]  ? __pfx___sock_xmit+0x10/0x10 [nbd]
[   69.263099] [   T1087]  ? lockdep_unlock+0x5e/0xc0
[   69.263105] [   T1087]  ? do_raw_spin_lock+0x124/0x260
[   69.263107] [   T1087]  ? lock_is_held_type+0xd5/0x140
[   69.263111] [   T1087]  nbd_send_cmd+0x63c/0x15c0 [nbd]
[   69.263117] [   T1087]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[   69.263120] [   T1087]  ? lockdep_hardirqs_on+0x88/0x130
[   69.263127] [   T1087]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[   69.263129] [   T1087]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[   69.263132] [   T1087]  ? __pfx_nbd_send_cmd+0x10/0x10 [nbd]
[   69.263136] [   T1087]  ? __pfx___mutex_lock+0x10/0x10
[   69.263140] [   T1087]  ? __pfx___mod_timer+0x10/0x10
[   69.263147] [   T1087]  nbd_queue_rq+0x9c1/0xe50 [nbd]
[   69.263153] [   T1087]  ? check_path.constprop.0+0x24/0x50
[   69.263155] [   T1087]  ? __pfx_nbd_queue_rq+0x10/0x10 [nbd]
[   69.263158] [   T1087]  ? save_trace+0x53/0x360
[   69.263161] [   T1087]  ? add_lock_to_list+0x8c/0xf0
[   69.263163] [   T1087]  ? lockdep_unlock+0x5e/0xc0
[   69.263165] [   T1087]  ? __lock_acquire+0xd03/0x2230
[   69.263168] [   T1087]  blk_mq_dispatch_rq_list+0x39b/0x2340
[   69.263171] [   T1087]  ? __dd_dispatch_request+0x75e/0xf80
[   69.263176] [   T1087]  ? __pfx_blk_mq_dispatch_rq_list+0x10/0x10
[   69.263179] [   T1087]  ? __blk_mq_alloc_driver_tag+0x191/0x850
[   69.263181] [   T1087]  __blk_mq_sched_dispatch_requests+0xabb/0x1510
[   69.263185] [   T1087]  ? __pfx___blk_mq_sched_dispatch_requests+0x10/0x10
[   69.263188] [   T1087]  ? lock_acquire+0x1a4/0x330
[   69.263189] [   T1087]  ? blk_mq_run_hw_queue+0x1bb/0x520
[   69.263191] [   T1087]  ? lock_acquire+0x1b4/0x330
[   69.263193] [   T1087]  blk_mq_sched_dispatch_requests+0xa8/0x150
[   69.263195] [   T1087]  blk_mq_run_hw_queue+0x1c9/0x520
[   69.263197] [   T1087]  ? blk_mq_run_hw_queue+0x1bb/0x520
[   69.263198] [   T1087]  blk_mq_dispatch_list+0x4e0/0x13a0
[   69.263201] [   T1087]  ? part_inflight_show+0xe0/0x140
[   69.263204] [   T1087]  ? __pfx_blk_mq_dispatch_list+0x10/0x10
[   69.263206] [   T1087]  ? __pfx_update_io_ticks+0x10/0x10
[   69.263209] [   T1087]  blk_mq_flush_plug_list+0xf8/0x680
[   69.263210] [   T1087]  ? rcu_is_watching+0x11/0xb0
[   69.263214] [   T1087]  ? blk_add_rq_to_plug+0x382/0x7d0
[   69.263216] [   T1087]  ? blk_account_io_start+0x42a/0x8b0
[   69.263218] [   T1087]  ? __pfx_blk_mq_flush_plug_list+0x10/0x10
[   69.263219] [   T1087]  ? blk_mq_submit_bio+0x17a8/0x2870
[   69.263222] [   T1087]  __blk_flush_plug+0x26a/0x4e0
[   69.263225] [   T1087]  ? lock_acquire+0x1b4/0x330
[   69.263227] [   T1087]  ? __pfx___blk_flush_plug+0x10/0x10
[   69.263229] [   T1087]  ? bio_associate_blkg_from_css+0x3d5/0xf20
[   69.263232] [   T1087]  __submit_bio+0x492/0x5f0
[   69.263234] [   T1087]  ? __pfx___submit_bio+0x10/0x10
[   69.263237] [   T1087]  ? __pfx_blk_cgroup_bio_start+0x10/0x10
[   69.263238] [   T1087]  ? bio_alloc_bioset+0x501/0x1170
[   69.263241] [   T1087]  ? submit_bio_noacct_nocheck+0x41f/0xb40
[   69.263243] [   T1087]  submit_bio_noacct_nocheck+0x41f/0xb40
[   69.263244] [   T1087]  ? __pfx_fscrypt_set_bio_crypt_ctx+0x10/0x10
[   69.263249] [   T1087]  ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
[   69.263251] [   T1087]  ? submit_bio_noacct+0x86f/0x1ed0
[   69.263253] [   T1087]  block_read_full_folio+0x3db/0x780
[   69.263257] [   T1087]  ? __pfx_blkdev_get_block+0x10/0x10
[   69.263259] [   T1087]  ? __pfx_blkdev_read_folio+0x10/0x10
[   69.263261] [   T1087]  filemap_read_folio+0xa2/0x200
[   69.263266] [   T1087]  ? __pfx_filemap_read_folio+0x10/0x10
[   69.263269] [   T1087]  do_read_cache_folio+0x1af/0x430
[   69.263272] [   T1087]  ? __pfx_blkdev_read_folio+0x10/0x10
[   69.263274] [   T1087]  read_part_sector+0xb9/0x2c0
[   69.263277] [   T1087]  read_lba+0x183/0x2f0
[   69.263279] [   T1087]  ? __pfx_read_lba+0x10/0x10
[   69.263282] [   T1087]  efi_partition+0x227/0x1f80
[   69.263285] [   T1087]  ? __pfx_vsnprintf+0x10/0x10
[   69.263288] [   T1087]  ? __pfx_efi_partition+0x10/0x10
[   69.263290] [   T1087]  ? seq_buf_printf+0x138/0x2a0
[   69.263292] [   T1087]  ? __pfx_seq_buf_printf+0x10/0x10
[   69.263296] [   T1087]  ? __pfx_efi_partition+0x10/0x10
[   69.263298] [   T1087]  bdev_disk_changed+0x5da/0xe60
[   69.263301] [   T1087]  ? nbd_open+0x21d/0x480 [nbd]
[   69.263305] [   T1087]  ? __pfx_bdev_disk_changed+0x10/0x10
[   69.263307] [   T1087]  ? __pfx___might_resched+0x10/0x10
[   69.263311] [   T1087]  blkdev_get_whole+0x144/0x200
[   69.263313] [   T1087]  bdev_open+0x610/0xc60
[   69.263316] [   T1087]  blkdev_open+0x2a7/0x450
[   69.263319] [   T1087]  do_dentry_open+0x418/0x1240
[   69.263322] [   T1087]  ? __pfx_blkdev_open+0x10/0x10
[   69.263324] [   T1087]  ? devcgroup_check_permission+0x132/0x320
[   69.263329] [   T1087]  vfs_open+0x76/0x440
[   69.263332] [   T1087]  ? security_inode_permission+0x78/0x100
[   69.263334] [   T1087]  ? may_open+0xe6/0x340
[   69.263336] [   T1087]  path_openat+0x1baf/0x30a0
[   69.263340] [   T1087]  ? __pfx_path_openat+0x10/0x10
[   69.263343] [   T1087]  do_file_open+0x1ce/0x460
[   69.263345] [   T1087]  ? __lock_acquire+0x497/0x2230
[   69.263347] [   T1087]  ? __pfx_do_file_open+0x10/0x10
[   69.263352] [   T1087]  ? alloc_fd+0x365/0x660
[   69.263357] [   T1087]  do_sys_openat2+0xde/0x170
[   69.263359] [   T1087]  ? __pfx_do_sys_openat2+0x10/0x10
[   69.263362] [   T1087]  ? __might_fault+0x97/0x140
[   69.263365] [   T1087]  ? lock_release+0x1a7/0x310
[   69.263367] [   T1087]  __x64_sys_openat+0x10a/0x210
[   69.263369] [   T1087]  ? cp_new_stat+0x45d/0x5a0
[   69.263371] [   T1087]  ? __pfx___x64_sys_openat+0x10/0x10
[   69.263373] [   T1087]  ? iput+0x9d/0xa20
[   69.263377] [   T1087]  do_syscall_64+0xdd/0x14c0
[   69.263380] [   T1087]  ? vfs_getattr_nosec+0x2aa/0x390
[   69.263383] [   T1087]  ? __do_sys_newfstat+0x8e/0xe0
[   69.263385] [   T1087]  ? __pfx___do_sys_newfstat+0x10/0x10
[   69.263390] [   T1087]  ? rcu_is_watching+0x11/0xb0
[   69.263392] [   T1087]  ? do_syscall_64+0x1ea/0x14c0
[   69.263394] [   T1087]  ? __pfx___cant_migrate+0x10/0x10
[   69.263398] [   T1087]  ? do_syscall_64+0x208/0x14c0
[   69.263399] [   T1087]  ? count_memcg_events_mm.constprop.0+0x22/0x130
[   69.263401] [   T1087]  ? preempt_count_add+0x7f/0x190
[   69.263403] [   T1087]  ? __seccomp_filter+0x3b5/0xe70
[   69.263407] [   T1087]  ? __seccomp_filter+0x43e/0xe70
[   69.263409] [   T1087]  ? find_held_lock+0x2b/0x80
[   69.263411] [   T1087]  ? lock_release+0x1a7/0x310
[   69.263413] [   T1087]  ? __pfx___seccomp_filter+0x10/0x10
[   69.263417] [   T1087]  ? preempt_count_add+0x7f/0x190
[   69.263418] [   T1087]  ? do_syscall_64+0x5d/0x14c0
[   69.263420] [   T1087]  ? do_syscall_64+0x8d/0x14c0
[   69.263421] [   T1087]  ? irqentry_exit+0xf1/0x720
[   69.263424] [   T1087]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   69.263426] [   T1087] RIP: 0033:0x7fe6f9c09c5e
[   69.263431] [   T1087] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   69.263432] [   T1087] RSP: 002b:00007fffb83f0690 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
[   69.263435] [   T1087] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe6f9c09c5e
[   69.263436] [   T1087] RDX: 0000000000080900 RSI: 00007fffb83f0750 RDI: ffffffffffffff9c
[   69.263437] [   T1087] RBP: 00007fffb83f06a0 R08: 0000000000000000 R09: 0000000000000000
[   69.263438] [   T1087] R10: 0000000000000000 R11: 0000000000000202 R12: 000055ae0a1eada0
[   69.263439] [   T1087] R13: 0000000000000036 R14: 00007fffb83f0b80 R15: 0000000000080900
[   69.263442] [   T1087]  </TASK>
[   69.419238] [   T1131]  nbd0:
[   69.473398] [   T1134]  nbd0: p1
[   69.546480] [   T1135] block nbd0: NBD_DISCONNECT
[   69.547662] [   T1135] block nbd0: Disconnected due to user request.
[   69.549552] [   T1135] block nbd0: shutting down sockets
[   69.617973] [   T1141] nbd0: detected capacity change from 0 to 20971520
[   69.621194] [   T1087]  nbd0: p1
[   70.670335] [   T1149] block nbd0: NBD_DISCONNECT
[   70.671061] [   T1149] block nbd0: Disconnected due to user request.
[   70.671805] [   T1149] block nbd0: shutting down sockets
[   70.778324] [   T1154] nbd0: detected capacity change from 0 to 20971520
[   70.781835] [   T1087]  nbd0: p1
[   70.872226] [   T1161] block nbd0: NBD_DISCONNECT
[   70.873344] [   T1161] block nbd0: Disconnected due to user request.
[   70.874398] [   T1161] block nbd0: shutting down sockets

