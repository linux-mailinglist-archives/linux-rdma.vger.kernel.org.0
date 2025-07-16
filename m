Return-Path: <linux-rdma+bounces-12205-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCC6B06C81
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 05:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E849561886
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 03:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102D723ABB0;
	Wed, 16 Jul 2025 03:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iXegU5BH";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iXegU5BH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012019.outbound.protection.outlook.com [52.101.71.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D1913D53B
	for <linux-rdma@vger.kernel.org>; Wed, 16 Jul 2025 03:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.19
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752638325; cv=fail; b=GJO8/s+HhR45XiYaR6/8NZjX6xO5u01GCfI/EPF3CC5EVrs3TGOr/7rwMzRQbInT60VRrvgfbdBlILFCN+5Jm/5kd42FOxSloqqK3OWEluxBKtzGMd+q3FBBlKjlXR2h1WQ9hO6hdrZ9X2vIxLD6hwJ7/xstWxC3yQ8kDUwGx88=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752638325; c=relaxed/simple;
	bh=FbMSkUbbii0qAj0Xgs6c6Rb8hSZzAwIuRdU0O2DMyf8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EcHVSjgM1UuceX4VElYRoQERqpAX9fipmVTmExT/TlxOWRNuD2ZqdbTA6yosgkrnqiCjIZXbBKgf0n/3YtgaZV6PHY1XEq+4jrhnUuNMS6p5NSpf/BFzDXQKistT37t41KEjnYivHW+sXjE4c26mk32UUKaO6iyg/prC6DlrIOA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iXegU5BH; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iXegU5BH; arc=fail smtp.client-ip=52.101.71.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=uGxgfTRwTcKRySI5EaALvRZzGIV1c5Th2TeYwa4VGfsBtaTTvc6ZCctr5NCtkoAbp5GjeFr9Om+L0L8JZPJK6h7fVoRFDxTa/1oxGf0Z0PScTOrSKpEr3EAGxOWfv2NA3P8ojYMPDHv0gMe7EyJoOHljY5GwOIHbg4ehaum4Z6vefixNWpvR5c/ZHDrl8eoAbaXa0+yfDI7KnwJb0qc4ouVI3GjlDHRy+rlSUDE6vLUfpQ3qA7LGjjbJJB9BZmMYsi3ileUmqZjKIWY13z9eDAfJUxDzc8AljmcmzG5pDNoABB4hRde7Sp9NyKRQwmSp7BNNWs5iH+MWjj+wUEyQKQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbMSkUbbii0qAj0Xgs6c6Rb8hSZzAwIuRdU0O2DMyf8=;
 b=Q6zn+HioUKZB0FoJ2rM8Y6SAv1WvEXaqrlx3npHSuxsK1Q2qfFyz5B9MYfe++SHuRTlJDdvznIMOcXcOBqFJo36X0GA0VCyfsU8E/1Y+6Myx96hNnD9lcZpAFN6v1rcLOdtJeGIAP3HxkpVRUqFrBcRJ41vkp0ngh+OARdLLc2Oq6VGs79xHvwV7LTurYKygPtro75SCfEqH1OGmp7ZzLGKE8yEnxYjzvu3SIQ5QD5yzOO2EcfFqGjkt/JqVVWJnvXWieSw5F14SVI/OQp+Blxh248g74hADy8tXAyoEtwKDD30uKrwn4C+5o7d60PBmBUjjPK5kHpv7gxWRLAHmtQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbMSkUbbii0qAj0Xgs6c6Rb8hSZzAwIuRdU0O2DMyf8=;
 b=iXegU5BHXc4k7NwiCmtaM1FstD3Mr8aMssUfF9+ZKn74lfQjlIYYSx5wquznY81H+mfMyL3Txv6Byxln2GA2MlfsK1lnJhbanIQi3+c4O/OztEpH0jrT5nJlj9p3crGhaz8m+HKeTPrZHkL396Hrlk7UzPoUYEZSd9hf7oWuWPc=
Received: from DU2PR04CA0202.eurprd04.prod.outlook.com (2603:10a6:10:28d::27)
 by AS2PR08MB10265.eurprd08.prod.outlook.com (2603:10a6:20b:62c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 03:58:38 +0000
Received: from DU6PEPF0000A7DE.eurprd02.prod.outlook.com
 (2603:10a6:10:28d:cafe::6e) by DU2PR04CA0202.outlook.office365.com
 (2603:10a6:10:28d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Wed,
 16 Jul 2025 03:58:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7DE.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via
 Frontend Transport; Wed, 16 Jul 2025 03:58:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxMyTPjybdXjE4sl9xjwIUNGrTpeFVnXqa5rVq7tg1pNOkkfDt3EJM6n6Y9ThQRCkdNL2BzJnLKEvqCeNBjk+53ZHL1bqbeeQvoFSJTSXYlZ4GadTek2zF0jpVOEcDtN3Iw4mZ+ZfQtkvYiIh97+ry8JxxCxC9l8NYMLJ34/Niva2/J4+LZnkvZ6BpjYU9FBtDdxZtrtvNKiH8m/Pf6QB71CJkQZ0ttFFzjK2j5uImMtagCdZYhpUgUnfm8Tb3psDAHF6rgV9TiOrrk2AJmYGCP0laZlMb2uIeOn9xIOVrLKaNjV5OixAj4AnK/UD/cyomfUQisHX+EdcTET/FcHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbMSkUbbii0qAj0Xgs6c6Rb8hSZzAwIuRdU0O2DMyf8=;
 b=AKDoXrXkT8pi5eEoEw6ivKaX2vIqCAtEr5TkHhCUb/YUpOYcblpjzOD8n/qTM4BjY+1roH6fDC76QZNHPxK2hAcoCN8ssw+Hu2ab5N3ENwdGEePJljOWiVUQuo+mdAX4WmCQEnaemP/IGSxCTlcYqTiVYKlOAyQexbH+JmXPKfnQVkL7IjBqJ1+obIxMfm/8P0NtwftH9Os8mN4NOieOWmzk9e3P/PeXlKQKWyVRAlLy5ClIvrH9On9RJhNLyfZex0PBeFTFq84XdYbKUfdZL95V7mD5hkFWuuHoAq3JaTEs6CVM7bdOd7sxnihgz0LKIeLNSaEFIeIv4Ly6IjMYjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbMSkUbbii0qAj0Xgs6c6Rb8hSZzAwIuRdU0O2DMyf8=;
 b=iXegU5BHXc4k7NwiCmtaM1FstD3Mr8aMssUfF9+ZKn74lfQjlIYYSx5wquznY81H+mfMyL3Txv6Byxln2GA2MlfsK1lnJhbanIQi3+c4O/OztEpH0jrT5nJlj9p3crGhaz8m+HKeTPrZHkL396Hrlk7UzPoUYEZSd9hf7oWuWPc=
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com (2603:10a6:102:33a::19)
 by AS2PR08MB9763.eurprd08.prod.outlook.com (2603:10a6:20b:604::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Wed, 16 Jul
 2025 03:58:03 +0000
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294]) by PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294%6]) with mapi id 15.20.8901.036; Wed, 16 Jul 2025
 03:58:03 +0000
From: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: Yishai Hadas <yishaih@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-next v1 5/8] RDMA/core: Introduce a DMAH object and
 its alloc/free APIs
Thread-Topic: [PATCH rdma-next v1 5/8] RDMA/core: Introduce a DMAH object and
 its alloc/free APIs
Thread-Index: AQHb9ftF0QJ+H24dYkyaT7Cz4g5qy7Q0G3uw
Date: Wed, 16 Jul 2025 03:58:03 +0000
Message-ID:
 <PAWPR08MB89096EE77AA03539FEDFEBD19F56A@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <cover.1752388126.git.leon@kernel.org>
 <b1ff9b142f785a52009b288567bf4e15dd34ecb8.1752388126.git.leon@kernel.org>
In-Reply-To:
 <b1ff9b142f785a52009b288567bf4e15dd34ecb8.1752388126.git.leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	PAWPR08MB8909:EE_|AS2PR08MB9763:EE_|DU6PEPF0000A7DE:EE_|AS2PR08MB10265:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f146beb-83dc-40a6-b3ea-08ddc41d0abc
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MGRQeFk2dmloNGxTN2gwdEprNE02S2hZWFJuQ2tIUkdPY3BnQnA5bmJCQzZl?=
 =?utf-8?B?c2xJVUdmUXdtZDNEZVYvOWpaVUJFV0M5dGpYelZGd21Qc0ZVaTVYeDB4b25D?=
 =?utf-8?B?M0E2VHQwVnFyRTBlNTlINTlrVDg2YTF5TGJ2U01VOTN1UXNoV1g1c2ZiRlVr?=
 =?utf-8?B?NFFrNmIxbnpoN1NwQ1hIV1BqYVV0VGNzRU1Dajd0ZTFkMUhpYXdMa0Y4U1JE?=
 =?utf-8?B?bWJRMkNpcEQySXBBc0QzWVdrSDRocHZkeHRSeHkxS1RSOWUzaFJpWFJmMlpo?=
 =?utf-8?B?Rjk0cnJ6cmM0UThKYTlrY2FBRi82aHQ2bGQzK3Z2QUo1NGFnaDA1VjJNOE15?=
 =?utf-8?B?NS9TdEZOUUhEaFNuWDdHQTRUN3VRR0pyam5KKzllbzRJY2JDUmNKUWZHNG43?=
 =?utf-8?B?a1JiVmN0Qk5HNnNTZkxlcHBrcFBHMFk4S1M0ZHFHWDFId3N0S2tqVy9oNUxO?=
 =?utf-8?B?R2xyMXM3QmJJSzhBQjdnWkZOUVRHN2xTL0pSSHdBb2NEenR5dEdXL202TVVJ?=
 =?utf-8?B?L2pSdnN4Z080K2EvTjZOUUtzNkg4bitjbFZzQ00xT25RQVIzZlFjWi9zTDRV?=
 =?utf-8?B?Y094c1ZLVmp3SEhJOHgzcjdyTmk2NzBtYkFIVFQ4enZLaXROMUNzWUpkRmM1?=
 =?utf-8?B?THZvNStLVTJ1Q2Y3N2lZQm9YelRkdWwzcXk0Q2hueHNIRjFESy9sOEFNKzhH?=
 =?utf-8?B?Nk5vV29LMDdwdjNROHdtdGxlOVJLMVg2ODI4ZjVsQmRFNEtNWjcwSTF1eDAy?=
 =?utf-8?B?blFUNWdpWEJXaU1XZ0xNZEJ6SXhlSmxBazRiZjdDdHo0N1MzM0lKeGphM0Mx?=
 =?utf-8?B?dm9ETXRxOVNtTnIvbVVoNXM4Q1E3aTI1V3JvbGY5R2xvNEtVZGNPNlpWT0M5?=
 =?utf-8?B?TjhGanB0ZHEyZm5VZFlBZXo4SWM4MEJLZTR5WlZLVWs0YjFqOGJIdkVDaVpY?=
 =?utf-8?B?Ui9XaFcvaU5WQUNGYm56SVl2MTNDR3BPcVBiZ0RTdVcraHNjVHA1T3g3TXI0?=
 =?utf-8?B?bzArb0FUa1ZXT0p6ZE5rZWZaY1BxM0FmaVB3NzJkT1RNWXI0RnFJS1pzSVhz?=
 =?utf-8?B?SkNYR1NDZksyMXp0UlEzc2cxdWRMV3IzV0kveWl5Q2V5M0NXb0JYUlBZR3RQ?=
 =?utf-8?B?d1RaU3JIQ09oNE1CS3hBbk52TU9QYi9mNFRNdFJiZDFQYk1sMWpsQlE4aGR3?=
 =?utf-8?B?TVQ4MWl4U2p4ckFFL1ZZV1I5K1BEVFRiaDFMS2JadlJnbEFDd3JvWEFmY2Fq?=
 =?utf-8?B?dEFySXNpNkhoMWJkNGxSZmpNWDY0ZHhLYVVPbjZMM3pwWFNGMGtIa28rLzhy?=
 =?utf-8?B?MU9jMkxDaDJCVzR4WVNyR1pMSWpmU295akc4c3NCSTMyL2k4angxUEJsdk9H?=
 =?utf-8?B?RVE0ZnA2VXI3Rkl3NDBhWitlT3NKdmJ6cEpWY2VCWElhb05XdDNSR09sR3hX?=
 =?utf-8?B?amU2WkZvbGI0TzBwTTUyc0xoQXlyQVlZbmNodmRZazdIR3lpOVFWWjJlMkJa?=
 =?utf-8?B?U1hTVWV0Q0pNZXRTVmh5dkJVak5SWmlrOUgvZEtKZkNOK3lkQThGaXlGS2p5?=
 =?utf-8?B?SVU0QU9QRGRFc2ZjREkwZ1JWTnNudll2ZVJMQmhhTEkyL1AvN29YN0llWk8r?=
 =?utf-8?B?cjR4R3duWjJZcU96Z0VYSmNoU1kzTUNxeExzTWVRbnBIMzk2NzJ0bVI4TVpU?=
 =?utf-8?B?YVBaZGVqOGNjbFVMd0lHL09HSHJUMmhNY2d2OGJaYWs2NEtGcUcxY3QxbXhh?=
 =?utf-8?B?RnFHckIvYWRENlZMc1Vqak1Ob0hPWEF4N0g0amx2N2JObHRlRjhZTlpYeXBY?=
 =?utf-8?B?OGhrdFpjWHpvb212SjNLa3lUZVBVRkdrYVlFd3lkaFZici9Vbzd2a2pYUWc4?=
 =?utf-8?B?RUFuajlac2MyUm5teHVjUitlWStvN2tXYWlMT1NNSmx6bU53VTVBTkdlOXlH?=
 =?utf-8?B?WUhBUGhVU1pTNXVoU2NydzRjNUhNaTNMemU3SVBXdytvVUtDQzJRRWlJNW1E?=
 =?utf-8?B?SEFnbnc1Zy93PT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR08MB8909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9763
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	73cacede-f6eb-4911-ac52-08ddc41cf6a2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|14060799003|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFg4OGVXSjlrZGtyOTYrQmlmUEo2MHNUNWhRb2xYTTJ1Q0hpdmdGcTM3OHV4?=
 =?utf-8?B?ekNvNWZqZDR6Wk1La0tlK2tpNHlLQXF3L0QvTGtxajJhZjRnemFKMVUvc0Rx?=
 =?utf-8?B?RXpjWTFQdnllQ012VGExMjBSSG16NEc4YXUrQ1JSN1lJREJ6SEVVT1lNZDdt?=
 =?utf-8?B?RW1OdEw2QmRJK1JLVElZYzFudEhndFk5TzEzd045a1ZuOUF3VlFJbms2ckR0?=
 =?utf-8?B?cloxRXNpQXEybUhDcUlPZ0cvbnhWcnAzUXZITDJ5QTYvT1ZOdWE4NE1JZDJ0?=
 =?utf-8?B?eVhHSmdDM0hUVjZkUTIvYUtkTnpHYmhNdU5YZlY1Z2VaazBxMEpINjBpdWJo?=
 =?utf-8?B?U0FkcGhSNDVmRkJKczlLN2NOeFNmZEFTWGNJTjUzY2xNM3V0Zkt0VDA4OGlK?=
 =?utf-8?B?UFp3TGh3Z21vakdtZTRUUU1KSjJQc3lmNTNnRzErVDVxdVMzYWFNaCtzQkRN?=
 =?utf-8?B?VWxKR2tZVjFpQ0VNY3FDckZzd0lpdWxtTDFCRFhMaXRBdDZ5TDFmbTBWV3hs?=
 =?utf-8?B?b0xLS3ZQcTRBRG5aaEJmV0p6MzM5d3lOUXREUnRzS1dtOHVmVDZpUWdJNEhD?=
 =?utf-8?B?c0k0L1NGRVhWWlJBZk44WWdwMkRGTEREZE9kdjFESmFLbzNnc09rQzhPdkY0?=
 =?utf-8?B?dmZydnk0NjcyK3VTeDhzOFI3RkVuK2haU2M4TThDQUsvZ0dvR09YbTdYbHZi?=
 =?utf-8?B?K3hhQUFhZW1DS1FDK3NnSDJwcXZhUEhmOC9NRmZDb24zcE5jdHRJa2IxaSt5?=
 =?utf-8?B?K0ZBNU1jdmdlNG1sa3NyOXNCM2NhN3ZnYzUzdTlkbEdlYWIrbVlNcE5XaUQw?=
 =?utf-8?B?SkRhLzZVNjhvanFVV0tTVFFZYnZ3ZEVQak5lTWlsQzJxRkRKU2tUTml5cllr?=
 =?utf-8?B?dENrNGpDNkRlTG1XaG1YY00wSVZFS0ZOb0pCUnNJYUxaY2lwUlFueEJoRHBh?=
 =?utf-8?B?NkZleTB3U2k4clJtRmc5RE1rd09XQmJ3RGZrMmxYRmdhRzRPQnZNVVl0WFZW?=
 =?utf-8?B?UStTR1ZqdXhUdUVrWEZCVk4xM21UNUFPdnpXSUMyenE4K1crdlNjcHh6SGk4?=
 =?utf-8?B?VksxT2o5bGRBdk1kajF2V0F1Yjk2TWR2Q1lZQXBsYkpHSWNkSmF0RzN3dENa?=
 =?utf-8?B?bnhKdWg1cjh4dWpyOFk1cEJ2eVNWWVRKbDlOei9JRnAvK2Z2MUNRdW50bENa?=
 =?utf-8?B?eGx5bUdXU3RWS0wySFlhUC9SQll2a0kxYW1BdUQ2bEFHS25VLzNEV0EwdmMx?=
 =?utf-8?B?UzBDcExxRmhadDhQa25MaTZaSFg3QzUwTzcyeUNSbks3QUkrMWN4VUp0V0Ur?=
 =?utf-8?B?Tzl6c2VqQzgwdHYyVFhUNXBzVk9kNjJsOFdzenJKb2RJREV4cXVqNXplOWRJ?=
 =?utf-8?B?SXJ5c0MxNjVRMnI4TnRYc3dEUnJscUluYnFYYWlNcXJNdUtUbWovZ1VzRTUy?=
 =?utf-8?B?bk04L3ZHcGZkWFZ1dEpWNExwazlQOXZTVmJBQW45bGhhZ3ZiOWE5YVJWVGla?=
 =?utf-8?B?SVlrRFNFaEVpdUo1ZXBrTU44RlRHaGJjSFA3MXYvcnZoekJoSmNmOGRreVBM?=
 =?utf-8?B?aHZ1WktZRVFFeUs3MUxra3lWUnd6UkRiRWJuYWVnOXVHbXNEbVA4a09OU1hC?=
 =?utf-8?B?cVArY0d6RDNrR0lWeUJnMzFkVkk3V1pmRlZrWVpqb1o0R3hVQWFqOFlNU080?=
 =?utf-8?B?Yml5d3RnMEhUYUZNb0krNDA1bUV3SFBjbHpsVzFoRHQ5Z3V1RnhWRFJaOXdL?=
 =?utf-8?B?VFEyVHZJK2Y0amZhbUNyK1QxSFU5VHdQSkhnVlkvdFBPbVhZbkFKWVFJMUV0?=
 =?utf-8?B?STVTdXJEVHhxYTgreHVsOUdyNWU4TytMNEthTUtzZnpOdzJ0OEFFZWU1WXZk?=
 =?utf-8?B?MUFubFdXZmc4UVMyeVZXVTJXM2RzWjAwZDBjWFlzZHNVZDB3VXc1VXc4eXA0?=
 =?utf-8?B?TDIxOSszL2JLN2ljYWxoTWxWRFliaVd5SXlrdnErdzU2cnlSR3lJaE1kR0lP?=
 =?utf-8?B?VHhUU1ZDbjRFdWlmRmN6MExnQ0pyNEd5bDU4WG9UZ2llYWpBdzBuc1dVaUx6?=
 =?utf-8?Q?jqSlMc?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(14060799003)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 03:58:36.8733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f146beb-83dc-40a6-b3ea-08ddc41d0abc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10265

SGkgSmFzb24sDQoNCj4gKy8qIGJpdCB2YWx1ZXMgdG8gbWFyayBleGlzdGVuY2Ugb2YgaWJfZG1h
aCBmaWVsZHMgKi8gZW51bSB7DQo+ICsgICAgIElCX0RNQUhfQ1BVX0lEX0VYSVNUUywNCj4gKyAg
ICAgSUJfRE1BSF9NRU1fVFlQRV9FWElTVFMsDQo+ICsgICAgIElCX0RNQUhfUEhfRVhJU1RTLA0K
PiArfTsNCj4gKw0KPiArc3RydWN0IGliX2RtYWggew0KPiArICAgICBzdHJ1Y3QgaWJfZGV2aWNl
ICpkZXZpY2U7DQo+ICsgICAgIHUzMiBjcHVfaWQ7DQoNCklzIHRoaXMgYSBsb2dpY2FsIENQVSBp
ZD8NCg0KLS13YXRoc2FsYQ0KDQoNCg0KSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9m
IHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkg
YWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50
LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9z
ZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9z
ZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsg
eW91Lg0K

