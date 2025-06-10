Return-Path: <linux-rdma+bounces-11176-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A145AD4470
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 23:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CADCD189C260
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 21:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7AD2676F3;
	Tue, 10 Jun 2025 21:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A6BRdCQn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="llqvx4JU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C91527472;
	Tue, 10 Jun 2025 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749589771; cv=fail; b=eaqk/uRCnsb4GN95+RvnsleABRR0Hcq7Xo9izCP+oChxPgCKbx8uYLNW+7G/2LvnLriRWflBMqC9FbbPN3mhzDjUn2FfQQs0GOVfDZpz3geGs+A3rSjxPKFy0g701mfs0Ww51J/NLQvtFuo+5C9Y1Y++EBgRlFfxvMBi+8bK6ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749589771; c=relaxed/simple;
	bh=Ea3VTUwj+ZO4lwWwDYRgWYhSc35p5HEWB8HF0SJcUsQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JG/zi+F8Z8jnuidAEFU6y6JmRpidX3NBQuiwTmKsxd5YJfWDvSPTwNI7dYqmS0WSW7TtIpWo+POZjSqMXNICB0Cc/zXn3ub+TOs6E8U/CPNbzgJh/lV4ENTLiKx7h8+T5Y4iKnl20YMN4KnxQHtQ+lYAqFGnVlI1QSDOYrlXr7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A6BRdCQn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=llqvx4JU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AK6jbN018453;
	Tue, 10 Jun 2025 21:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Ea3VTUwj+ZO4lwWwDYRgWYhSc35p5HEWB8HF0SJcUsQ=; b=
	A6BRdCQn+0ftm4DGvV9lCK3S2sxvvBwk7PAXRX3R2m97SJLjvcOlxWqtL2vDBd5H
	fZ95xPST9+4eFrNeeEgeplEB119/Fk6nXNGg0KSdQIhoAY7tcC6LiAq3Sh6Ob4X2
	C0nyeVUMx8iLhaOsNipRI3Rjyl21EJn7BIqCErsg+iDSou+EhNevqAI+NS5nhs4o
	yKW3KVHxpdNOWNQReodyjibIwbPpJSA+BcrnfG2oWN2idECRCrG4Jkoii7NI1Fxd
	Abc8ikDetqiVDBZKK3AdGND9I591A6A+WgR6E75sVscjdHinhsLm9qIOtsIunnK1
	jJG5Dh8uAuSU99YEuOT2Dw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14d3b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 21:09:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55AKiafP007593;
	Tue, 10 Jun 2025 21:09:28 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv91gar-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 21:09:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhlURG7BMCLEBXiB2hyfOrOW1izqQ7+cUtkqoQRaz9481x91oUcAYWZN0sPrN1wcDpBPRzH59ItcjLBhwiXe5ZmS5Q85AdgrxZ2r5r+KfCIlMK9n4PXFoK55q+RQ9MzFJcYWO1jla1V6HOltFuAJkYd7prGHGD/yLybgWAVgT0IWhkMv9lOgy6/IpPjmPNZrMsNEb0C0NG5QTwUix/nG4GLtDPHPwDmDyCwDfRC5YLVyQDQsXMU03FxGFKj6eqkp6yTX/HEIWGSbulu3MeEq93vhfer9RGGuW7VPFeVLl52XBxtkx4P2aaL3xOWlwsQ9uvgM7WakenxhlexUb47Fag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ea3VTUwj+ZO4lwWwDYRgWYhSc35p5HEWB8HF0SJcUsQ=;
 b=JYpdJpfow4r3fQlqXTjtACm6PfmShj34R3tEBpOXeFdUfF+Vfx3SdBCtvVyLbjRkX7BXnKqTcU+7oYs3nVPvRIk9VJwMnP0ylaWhHluPBg+deaAc5PikpU72z7ouMUkhiKCI+0cy72nbmfFcBJ0fXzkhbgkPILuHT+9Duzv+dn7i/J07EW9OoQ82YUFQ1NpkMbLGFZbsqXgRojH47SBNZZM79KDQnYNnpE6fP4xKIpvXeqDfnFMkcjXBoMAch2rzEi9B7bAYg0OtC/6FUh5+xW6usYMUEWAaR1eFYeFXRqSQ1t3B6rY5Gnd+C9sYX9PidS3yvyr76iV34eIh9GNPfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ea3VTUwj+ZO4lwWwDYRgWYhSc35p5HEWB8HF0SJcUsQ=;
 b=llqvx4JU9y8BYaLwTTX7UYu6L4yRccVzVmuaYB1Qmeb63uJZagqrYoH/EZ6jbqvM34EgG7yw6DfIEdWmU4+rAXQqinxuHslDZOARrh9BxqySDXz4yx3sxDE54S9UkWvF/fpqkg5iQ1J1LraoPvro32yBa0r1blizeI6lKslMLao=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 SJ0PR10MB5833.namprd10.prod.outlook.com (2603:10b6:a03:3ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Tue, 10 Jun
 2025 21:09:25 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df%5]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 21:09:25 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Konrad Wilk
	<konrad.wilk@oracle.com>
Subject: Re: [PATCH RFC v1] Feature reporting of RDS driver.
Thread-Topic: [PATCH RFC v1] Feature reporting of RDS driver.
Thread-Index: AQHb2juGJuZV7DjJBESDuSetcmVP/bP842sA
Date: Tue, 10 Jun 2025 21:09:25 +0000
Message-ID: <f9995682f43428905ca680318ff6362b27e890e4.camel@oracle.com>
References: <20250610191144.422161-1-konrad.wilk@oracle.com>
In-Reply-To: <20250610191144.422161-1-konrad.wilk@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
autocrypt: addr=allison.henderson@oracle.com; prefer-encrypt=mutual;
 keydata=mQGNBGMrSUYBDADDX1fFY5pimVrKxscCUjLNV6CzjMQ/LS7sN2gzkSBgYKblSsCpzcbO/
 qa0m77Dkf7CRSYJcJHm+euPWh7a9M/XLHe8JDksGkfOfvGAc5kkQJP+JHUlblt4hYSnNmiBgBOO3l
 O6vwjWfv99bw8t9BkK1H7WwedHr0zI0B1kFoKZCqZ/xs+ZLPFTss9xSCUGPJ6Io6Yrv1b7xxwZAw0
 bw9AA1JMt6NS2mudWRAE4ycGHEsQ3orKie+CGUWNv5b9cJVYAsuo5rlgoOU1eHYzU+h1k7GsX3Xv8
 HgLNKfDj7FCIwymKeir6vBQ9/Mkm2PNmaLX/JKe5vwqoMRCh+rbbIqAs8QHzQPsuAvBVvVUaUn2XD
 /d42XjNEDRFPCqgVE9VTh2p1Ge9ovQFc/zpytAoif9Y3QGtErhdjzwGhmZqbAXu1EHc9hzrHhUF8D
 I5Y4v3i5pKjV0hvpUe0OzIvHcLzLOROjCHMA89z95q1hcxJ7LnBd8wbhwN39r114P4PQiixAUAEQE
 AAbQwQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+iQHOBBMB
 CgA4AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEElfnzzkkP0cwschd6yD6kYDBH6bMFAme1o
 KoACgkQyD6kYDBH6bO6PQv/S0JX125/DVO+mI3GXj00Bsbb5XD+tPUwo7qtMfSg5X80mG6GKao9hL
 ZP22dNlYdQJidNRoVew3pYLKLFcsm1qbiLHBbNVSynGaJuLDbC5sqfsGDmSBrLznefRW+XcKfyvCC
 sG2/fomT4Dnc+8n2XkDYN40ptOTy5/HyVHZzC9aocoXKVGegPwhnz70la3oZfzCKR3tY2Pt368xyx
 jbUOCHx41RHNGBKDyqmzcOKKxK2y8S69k1X+Cx/z+647qaTgEZjGCNvVfQj+DpIef/w6x+y3DoACY
 CfI3lEyFKX6yOy/enjqRXnqz7IXXjVJrLlDvIAApEm0yT25dTIjOegvr0H6y3wJqz10jbjmIKkHRX
 oltd2lIXs2VL419qFAgYIItuBFQ3XpKKMvnO45Nbey1zXF8upDw0s9r9rNDykG7Am2LDUi7CQtKeq
 p9Hjoueq8wWOsPDIzZ5LeRanH/UNYEzYt+MilFukg9btNGoxDCo9rwipAHMx6VGgNER6bVDER
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|SJ0PR10MB5833:EE_
x-ms-office365-filtering-correlation-id: f0ebaaef-8c92-4016-daef-08dda8631469
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MHg5RHYvVXFJaFIzN2pPSXczV1Z4Umd1Z2JYRmljUGVoL3RwWXdBeVZnb3U1?=
 =?utf-8?B?VC9HNnFtNFJhTHRMb0lscnl6TjlpNk04UWZlby9mQzJ0OFcwdGUzRXM2aXJH?=
 =?utf-8?B?U3cvb0hFbFBPYjMvcmtlYU4yaWo4Q1RxNndBd0d6U0NKU1FhdmIvWU9UWCtN?=
 =?utf-8?B?WjhKSmF3QXZsY0tWRy9TUEhtU0FRS1VqcWxZbGJTR1hIR3hYM1pYc2NnRW5R?=
 =?utf-8?B?ZFVYa05XeDNCbGdCRGxZS3pxVGd5M1A4TmVoQm8raC9tV0d0S0RtU09Ga0Rn?=
 =?utf-8?B?blYya2hzMmZnOW96MStIUDRhd3dqb2gyT2RFLzA0TjVPYlRDejl3dWdENW9J?=
 =?utf-8?B?bjN0bVJFZml3TkhxT2VGL2MzYTJVZkR5UGpZMDNZdEV1NG0xK0ZwMW1zVXRs?=
 =?utf-8?B?aDJYK0hNcmY5NUZKVmNmWGlmeWRjRkVmcTNYZDZoV2ZNNndKa0RaRnFieEIr?=
 =?utf-8?B?L0ZlVEhjbGQyTTFqamowUXQ5VmpvVk5Xb3lYVXI1aUlDQTUvU0lHYmNoMml3?=
 =?utf-8?B?ZE5vaFJDNlNwSisxRFlXWTIvYzJUcWxtMWh4WmVTZS80S3dlMXd4QzRWUFJp?=
 =?utf-8?B?VkFoQlNWQkZZZCtjcURMS2NRYk54OTNiSzh1aG9keGU2ZCt0SnZFY1M0ZEpk?=
 =?utf-8?B?S0VvcFdGVHR3amxvTmUrU09sakE5emw2M0ZnK29TdEowdWYzVGVDaTJsYVpZ?=
 =?utf-8?B?UEM3Q2lQWU43QnFJS3YySjRDUzNXczJtQ3dlQTZ5dEw3MzU2eWZsVWFPZlV0?=
 =?utf-8?B?SmpJTi93alBTaXdrTTZVT3RJVVQzZFcvZHFzWE9aN21UQ2xjbzNNblVaK29t?=
 =?utf-8?B?cStJVjIrZHZEZVl5MHVzREE3REtaMk5TcG5DWnJaTXRlMkcvTm9VMDkxMEJX?=
 =?utf-8?B?YmZsRXNXcjUyK3ZqTmtWWFJEdCtLNmRaNGJpR0x3bXFNWFJNK1h6OVcwNis0?=
 =?utf-8?B?ZU1GUmEzd2FhR0taNFN0dC90MFRBTkJ5bU4xNTNuVWQ3UWl1cmRxRVozbnE3?=
 =?utf-8?B?S0NieDQwOE5OWjU5c1pzL1UvTmN3a0crcWNJSlllUTZGcVd6ZlVkbGJ1cUVQ?=
 =?utf-8?B?Q24raitTYlpYc3BhOVRzckJydWR3dlpDQWlUMVVqR21qdTFvdWNTVERrNk5S?=
 =?utf-8?B?RE9zNUJPdFg3ZkN4Mzk5ZDJialNRZnpFUEVjb05kZWdDNWM2b0tUUW9Nd2Ni?=
 =?utf-8?B?VVhuaXhRWEJPN2QyT2MxcFEvNWNoWHoxeGUrMzlzcStiQWZ6ZURMVWdpVlhP?=
 =?utf-8?B?Ukd1dHdxRG9Gb213TFo1amU5Tjh4S1FmS3FFQVBLblk2TWVjZVNGWHVnL0JX?=
 =?utf-8?B?TFBZeVZFbWk1eER2QjRCZDdPMHllaDNHN25sTnN1bXRJcWd2K09oS2lMMXVG?=
 =?utf-8?B?RmVGK0xtSW9DWmNuVExkQ2t0SzhqV1JKVE91WTNJYmZDVG1VcWZVN3V2Rk9P?=
 =?utf-8?B?TjlYbWpRZkxiMUh5aDBFUkhJRkIrMTJtbEVPRWlpaENGL25CbVM4MlNkT0c5?=
 =?utf-8?B?K0VJMDVPUW5relBZRkFnWTBiT1JrY2FMSkh2dVcwNjJscDcwY0ltQUVjUjYy?=
 =?utf-8?B?c2ZnSlNmZm9VMGNwOVEySEY3Ky9GMWtJUU5LNkMrVVJCQmpQYjlrcWhjN2lC?=
 =?utf-8?B?NTBPRnZNMnFwaHJ4a1N1TS9CQkFGSk5PVkUyank0a3JqV1hBMEhHc25mVjEv?=
 =?utf-8?B?QlI5QkgvSnlHQWtadUdEaERpcHdyV2o1MjVnWDJnR0VMaWp6cy9kVUlQZG9m?=
 =?utf-8?B?VWRZU25vVlYwK0t3MVlrdTZwSDNEUjgwTjFuSWhnWGxHaXk1dUdCeXV2YUgz?=
 =?utf-8?B?a2FwSnJxaHYxRDgvTGFEa1Z3WHpDcG5IQmM2N2M0b0tWYW5QUTlkWGo2QnR2?=
 =?utf-8?B?Nk52S1FZNkQ2VUtPSFJlbVQwa1B1WklPQWdBUlZ2NlVkQ3JDWjJhU3NyaFc3?=
 =?utf-8?B?Tk1YZ0x0WFFYTmc1M2M5SFRaSWpzOVM4TUhZZkhFL0tBUHAxNEFRUWwxQjFU?=
 =?utf-8?Q?/l15cbeE4g/H3cG9m5I3gfmk6D9O40=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MVVQTEZncXJsWnorekwyRENLcTNmcm4zOEtvaWFlZW55SjlOR2h3U0MrbDJT?=
 =?utf-8?B?TG14QURoMjBpbnc2Z0tKZDVMdm05cUF3Yk1zM0c4OWhmQnZUNDZ4N0pURU1C?=
 =?utf-8?B?cUJrSE9wTlhjU2g0aTVWUFAxWURYOGdocjR5MDZxSU53Wkd5ZWRWbmY2NGds?=
 =?utf-8?B?ejZCVXdpT2dNUE5yQTV2UE5SWlFMOWM1c1VkblplS2FaOEpINlhscDNiZTE5?=
 =?utf-8?B?bEZGZGViV3RXSHRlZEdJVnZmbzJiUEhVQVBkRUpYKzF2VG13YlZ4RWRoczY1?=
 =?utf-8?B?SmVpbEZkTWpLSytra3VQWVV5Qk5EUHlEVW5UK3VXK3hGaGhjRW1LT25JM0xs?=
 =?utf-8?B?cFJSRy9FdWdmMTZ0U1RNelNqdXJCQ09PVkFuTXFoQW9qeXpXelRDNHZPckRE?=
 =?utf-8?B?eFdYUFJXZkdaelFKSmpEWTNRSVljVEZvaGdQZjFKRDg5WWlCSDhJNytwbjdU?=
 =?utf-8?B?eG5BVG1leVRDN01FeWw4S0N2SC9OT1ZjSXVzQ0l2ZGZCT2dFM29yZ1ZtT3Yz?=
 =?utf-8?B?MjJJTHVJNDVlK3B3aHRCSXI2NUIyWHI3TmlzYWNoRVpvSHo2RUJHNzJXMUd0?=
 =?utf-8?B?cG0yWS85UW54NDlMeW95NFJnYytsK3Q0b1Ztdk14Q0RrNC90VllNMUFvWlBZ?=
 =?utf-8?B?MFlITm5FRVErUnMyN1diRXJ3R1ZFdFlrVnVoY2JaUUtybkdrMitjV09iNHR2?=
 =?utf-8?B?LytVRE1UQWJWMnltdlZuNW5pRWdieElqNVZHZkkzeXowWm1ZOTh2alZaeElN?=
 =?utf-8?B?N0VPNndxdWQ3QU0zL250MkowZkFURkZ2S0dwNzQ5RHRpSE9QbjhwLytXRnFj?=
 =?utf-8?B?dEpSNjRNaXJxQ2ZGNWs4cTFvb1l0NnhEczh5aGM1Y2VNNVZjNWIvRVJabjZ1?=
 =?utf-8?B?ZHlEZVpEbXY4MGEyYVp0MjEycWdxOTcySE54ZGtkSm4xeU04c2hyQVpVVjk1?=
 =?utf-8?B?ZW4xdFhseTY0WktZdE40N2huOHFRSUV6YW43Q0dZaTR4dHltYnVYRFpoa2Rs?=
 =?utf-8?B?T1MvMGU5UnQwdGlvMWtKUEIrbWV1ZVFLVTNSN3pLb2FYNWZwS0MzM1kvTEdk?=
 =?utf-8?B?ZFhWYm1JKzBKTENTemVmVkJCcit6U0JLU3pQMEhmbUFha3M5V2dkc1V3MHRX?=
 =?utf-8?B?Yk1raGUxVDhyWVFCRk1PbUxZeVhwbE5OM0tpdEZ0R0tRWE9kY0x1N2txcUtY?=
 =?utf-8?B?Z3B5U3FYcWlsWXNYYSszc2IzbWtDcGgwQ0xrOTZMR0R0WEZzMEV3VFZtMmR3?=
 =?utf-8?B?czQraEFKZ2c0b25mSXZiclJCNUNpQ2JDMndmMW1wUlBwOTF6N01YUHF4dXFa?=
 =?utf-8?B?MTFoSm0rMEdKS3JwZzNJTk1GYWExSEtVTGRlamRFZElVcGNiK2M2Q0tiVTJQ?=
 =?utf-8?B?cnN3S3NEdFBCRzZjT0JHMWptdmppMXcvVGc1cGRYcjY1cHMrSk9OQTNMV3d6?=
 =?utf-8?B?RUM0c0VBUFkvNWluRmh5MEI2Q1JoanUramFOZ0JwMDcrbUk1Zk5nc3ZMSGly?=
 =?utf-8?B?VUJ2ZVFhOThWVituUW95OU1tYTBMZ3ZUUC9DaHM3bGgwR2h6T00wL2haS0hB?=
 =?utf-8?B?SUJ6Um05SjZSeGllMmxud24zaXp0MC91bzM5Vnlaekw2dUZFQWl3OXU4T01G?=
 =?utf-8?B?Y0JiZUJDV04vL3NBVTRSVThyRi9zRGdlMXFwc1hRTGlJc0dSL2UxYUdONkpq?=
 =?utf-8?B?ZGdCQ0ZEQVEzT3Q4STdLMDdPMmxVNzR4dWpHMmxOODdldjR1ZGN4UTIzN0Yz?=
 =?utf-8?B?aWkxSFFVUUhWYW9aYTdGV1NaN0tGTUtlSER1UGNBTXN4YWNrdWJnOFpaK3R5?=
 =?utf-8?B?UkJtR2FreDQ4L1hRcGRMdXkyZkpNcGZydDBrMjdsT3ZzR1JySDlQd2F0WUxF?=
 =?utf-8?B?NndiOGVDSDgvbEhreGx5QWkxMFJnSklnbTVQVXI5K0cydjkzWTk2dnR1cHl4?=
 =?utf-8?B?T0xHeUo1K3FScTA2M1JiY3FzNloySm5PR3o2NVJUZld5dmwwSDE2Tm16enEz?=
 =?utf-8?B?cjRKT1NvZ3d0WGViVHoyaUtoZUtNckM1cDc4YXBnMWRYWG9HRzZxWVlGSWpk?=
 =?utf-8?B?NG1BMndSYzNYUnJlR2JpTmRBdHE1RlVEd1hpcWhpLzRjWWVxbjlxT1NvMlF4?=
 =?utf-8?B?RkRsZzBxTFZqMUhTd3pZMmZ2dGdIZkI5SG92OGxnc2NUa2oyTUFGakxNcFF3?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40140161F2D0694189AB16DC35BBAD9E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3+lvZ2YUa3Lu7Si+iJHbyxiTL73Dn45Et/gfW7UzDx4pNV6CSd8dAZg6XGMFwa7qJqFL6//btItsgRZ4ta5avgZkEwHqJ54D9X9ZnVu3OJEOYQh6TP24vgo1k9uyAxDouNE93yG0d2YnL6qb0OF+YcCVjZPFdhUpeSSlBRB9uBl20CSSySV3V3d82HxTWI+KC7zadquTGm8nX6zkRyvcX8r++IqXB44YyvYcCFj3xlvBopx7anVxGi11JtI5LePKob3iSykyL8FMecn3CH3T7LwLq8SmawcZozaVyefvygEdz3xiLjm+4rJzCP/145gaBUJJXhKRN77tyVtZkIEZibbH95TzbUbH/gKl4F0KeQQxLR7EBC/IC4uhEM7UJiKC6KtaTP+7EgyeAQlrviI+uT4G9fVlIKNXe2iWZYc9oliQhDgwJ6faCIWwdnRJbOcSovfJr6d52NtGNjTnP8nZOKu+qRmbsugpstFhH5a9mTpH82xAwk3rwlaoWUjLBZuZxtvrj1W8xxCSYb5dOYdhRq2Q/WKQbCUkbJaIq4dYpFm75VXHoolz8VrN7CGQa/1mngWbekZPFpN99MSXHf+7nI9WyhrAw6SUOKJrYWxzkoE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ebaaef-8c92-4016-daef-08dda8631469
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 21:09:25.3747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nt+X1cv2tAm5HtKNgh7lS/YVXhVhBQoikkta1kqr/YXA5OPO1Wdj61H0AP+thUqA5kFMSid4SwEwEVvnZxZ2vsU8lYS6N4++B418uWKMFGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_10,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506100173
X-Proofpoint-GUID: wi-b-TTQIxHkPWzd6ezWH3CRKIStjjUT
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=68489f09 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=lDDbp9lZ74DXpG18zGEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE3MyBTYWx0ZWRfX81BtsyGtARmK CaMqve4ogk9V6g5AyZO3QiFWN4NiwIJE2N4soJ37gHI6/72AUl4vGeBhGvsy1lpbI0bV6DzaoDm BTN83vG/PDTvkzdoCOHzvdwcsGL39CMyxXm+UdIlnmRiHP6Hb3EioNJwVlBhrtNHHDnrrP9ZFsf
 f97Bm5waxBR99bvv0FmdJukzTVg6IAnTihkwMchtQYPN3jzn6wu7bsoLxpHj1ujChZG6oEYO8/A INAZSBR2Ii5tEvoeoKb0GTtf55mkEZjCfv+zDT12YjNsWw3CYsYNfUJOAvXaY8kGdrhPQhTt8h4 jGH8xI1t8vcCSjdZCcbFBz/+QQkASi4BC0hKO5FjITNEjqTfMYOCbXprAqKS8LYEvQ7EZtgh2Ee
 kCdqLCbHOKzLOXkKD34CBplhA5Vpf/sGJEISG+8c7I3mWAE8Nl0PlnSrbNGWYv6cnlGXN4X0
X-Proofpoint-ORIG-GUID: wi-b-TTQIxHkPWzd6ezWH3CRKIStjjUT

T24gVHVlLCAyMDI1LTA2LTEwIGF0IDEyOjI3IC0wNDAwLCBLb25yYWQgUnplc3p1dGVrIFdpbGsg
d3JvdGU6DQo+IEhpIGZvbGtzLA0KPiANCj4gVGhpcyBwYXRjaCBhZGRyZXNzZXMgYW4gaXNzdWUg
d2hlcmUgd2UgaGF2ZSBhcHBsaWNhdGlvbnMgY29tcGlsZWQgYWdhaW5zdA0KPiBhZ2FpbnN0IG9s
ZGVyIChvciBuZXdlcikga2VybmVscy4gUkRTIGRvZXMgbm90IGhhdmUgYW55IGlvY3RscyB0byBx
dWVyeQ0KPiBmb3Igd2hhdCB2ZXJzaW9uIG9mIEFCSXMgaXQgaGFzIG9yIHdoYXQgZmVhdHVyZXMg
aXQgaGFzLiBIZW5jZSB0aGlzIHNvbHV0aW9uDQo+IHRoYXQgcHJvcG9zZXMgdG8gcHV0IHRoaXMg
QUJJIGluZm9ybWF0aW9uIGluIHVzZXItYWNjZXNzaWJsZSB3YXkuDQo+IA0KPiBUaGUgcGF0Y2gg
ZG9lcyBpdCB0d28gd2F5czoNCj4gDQo+IDEpIFBvd2VyIG9mIHRoZSBFTEYgLm5vdGUgc2VjdGlv
biB0byBwdXQgaW4gdGhlIG1vZHVsZSBzbyB0aGF0DQo+IGFwcGxpY2F0aW9ucyBjYW4gZGlzY2Vy
biBiZWZvcmUgaW5zdGFsbGluZyB3aGV0aGVyIHRoZSBrZXJuZWwNCj4gaGFzIHRoZSByaWdodCBz
dXBwb3J0Lg0KPiANCj4gMikgVGhlIHN5c2ZzIHdheSAtIGluIHdoaWNoIHRoZSAvc3lzL21vZHVs
ZXMvIHdhcyBhcHBlYWxpbmcgc2luY2UNCj4gaXQgd2FzIHNpbXBsZSBhbmQgbm9uIGludmFzaXZl
IG1lYW5zIG9mIGRlbGl2ZXJpbmcgdGhpcyBmdW5jdGlvbmFsaXR5LA0KPiBhbmQgcmVxdWlyZXMg
bm8gY2hhbmdlcyB0byBleGlzdGluZyBBUElzIG9yIGtlcm5lbCBsb2dpYy4NCj4gDQo+IEkgYW0g
bm90IHRpZWQgdG8gYW55IHNwZWNpZmljIHdheXMgLSBoZW5jZSB0aGUgcmVxdWVzdCBmb3IgY29s
bGFib3JhdGlvbi4NCj4gDQo+IEFuZCBhcyBzdWNoIHF1ZXN0aW9ucywgY29tbWVudHMgYW5kIGRp
c2N1c3Npb24gYXJlIGFwcHJlY2lhdGVkIGFuZCBpZiB5b3UNCj4gaGF2ZSByZWFkIHRvIHRoaXMg
cGFydCAtIHRoZW4gdGhhbmsgeW91IGZvciBzcGVuZGluZyB5b3VyIHRpbWUgcmVhZGluZyBvdmVy
DQo+IHRoaXMgY292ZXIgbGV0dGVyIGFuZCBJIGFtIGxvb2tpbmcgZm9yd2FyZCB0byB5b3VyIGZl
ZWRiYWNrIG9uIHRoZSBwYXRjaCENCj4gDQo+IEtvbnJhZCBSemVzenV0ZWsgV2lsayAoMSk6DQo+
ICAgICAgIHJkczogRXhwb3NlIGZlYXR1cmUgcGFyYW1ldGVycyB2aWEgc3lzZnMgYW5kIEVMRiBu
b3RlDQoNCkhpIEtvbnJhZCwNCg0KVGhhbmtzIGZvciB0aGUgcmZjLCAgSSB0aGluayB0aGlzIGlz
IGEgZ3JlYXQgd2F5IHRvIHN0YXJ0IGRpc2N1c3Npb24gZm9yIGV4cGxvcmluZyBzb2x1dGlvbnMg
YW5kIGNvbGxlY3Rpbmcgb3BpbmlvbnMuIA0KVGhlIGVsZm5vdGVzIGFyZSBjcmVhdGl2ZSwgYnV0
IEkgdGhpbmsgdGhlIG1vZHVsZSBwYXJhbWV0ZXJzIGlzIG1vcmUgY29tbW9ubHkgc2Vlbi4gIEFu
ZHJldyBtYWtlcyBhIGdvb2QgcG9pbnQgdGhhdA0KdGhlc2UgYXJlIG5vdCBhY3R1YWxseSBtb2R1
bGUgcGFyYW1ldGVycyB0aG91Z2gsIHNvIEkgdGhpbmsgdGhlIGZlYXR1cmUgc2VhcmNoIHN1Z2dl
c3Rpb24gaXMgd29ydGggZXhwbG9yaW5nLiAgSSdsbCBkbw0Kc29tZSBkaWdnaW5nIG9uIGV4aXN0
aW5nIHBhdHRlcm5zIHRvbywgYXMgSSBhbSBub3Qgc3VyZSB0aGUgYmVzdCBwcmFjdGljZSBteXNl
bGYuICANCg0KVGhhbmtzIGFnYWluIGZvciBnZXR0aW5nIHRoaXMgc3RhcnRlZCENCg0KQWxsaXNv
bg0KDQoNCj4gDQo+ICBEb2N1bWVudGF0aW9uL0FCSS9zdGFibGUvc3lzZnMtZHJpdmVyLXJkcyB8
IDkyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIG5ldC9yZHMvYWZfcmRzLmMg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgMzMgKysrKysrKysrKysNCj4gIDIgZmlsZXMgY2hh
bmdlZCwgMTI1IGluc2VydGlvbnMoKykNCg0K

