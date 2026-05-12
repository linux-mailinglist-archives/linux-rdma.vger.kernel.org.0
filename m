Return-Path: <linux-rdma+bounces-20482-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFiBOWkKA2pmzwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20482-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 13:09:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EF751F161
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 13:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 409A0300EA8C
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 11:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A134F343D66;
	Tue, 12 May 2026 11:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jhwLL6gX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE3C1C69D;
	Tue, 12 May 2026 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584137; cv=fail; b=I1uaPE9ucSb+n4ILYk4w4zzFQ9oXThbpQ9zmzivf+vUved8Rg0DV+B3jstuVJXG8DcZpSMiEN7Tr8gadJ13/9ohQv3dFxKRizvOgCoADgfuKYBgHtad+hVSgSiAMij9FP45rnBzb2f95sPxd8a8xVSxT9YifB0w72XjyzQtCKsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584137; c=relaxed/simple;
	bh=Aa0mx3yF9WsmB64TWr0WlAx9MJkpZst5fyZjmO3fXX8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UAbFRSJ27EeGcVRfeAYpUSd13/W597hxFIwROjhoxoGhggGbQjTbhvlE56N4vez2PsVtajW9bDL+iNpenynzNNAbHH0fvhwr+AaEAPvyf8GZlJ2FGFFAw9qwceTb6CSgxskS3M5d5TYIaCwkiyMx+C8lSyh9tuKvtg6Pe2QBQ5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jhwLL6gX; arc=fail smtp.client-ip=52.101.46.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGzC62XaSJtFEy2Kzdh/1H2oHc3NKr4wqqlct3LfBvn0QRUxGau6Jv85kmsIV4nSkcQWVOi+yjb7KUwAUqq1crTCpwJoJY0fTFg2yulFH0mSGgIzelLMFjmJGEqcvpfmwpVQI0BsCqQI4R6HZe0TxNbbHPIj+IDy/vXabwZujrzJ6onlUrYRvcoZ3LFNP0p0iu2LDeAGZ+dXTHx3uDmVvDSaZCg0au55rkuP7cufvnzFYIeMn1Ew8YDvj1DUSxxN46tw+LE3rvMKWPyELgTE1JA1JKpsIOrZ0UQC/dsuhBs3ZNY6PKv/gUltx2ST8hUzdwhXA7DKJ4nK/bnX9DXI3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aa0mx3yF9WsmB64TWr0WlAx9MJkpZst5fyZjmO3fXX8=;
 b=n0zJvQiGl5m27TtUeqC3gREH9Pwlj04t8KU6FBXMXQl33VfmUdgDrCDwy+OXnx4vZnL55c7OK/0XdMhI0fYFY9/vsU32tht/cWWVoEABHSAi9X03q9BbP7ukpCeG7PMcZ+vX9VwyqmWRZZs7Vv4OSx0r92XnDZzijTV4Ne+OCGL7g8xfRJjXFuC3lac2AMghVO5DoAnfspCgWZeBOkgLRDVVuw4//II/Q//j4y/diDW4AroL7V+gfQj6gI8uQwSEvV9SqnDySFX7X6O3tLhEhe9JfKWgMFotxH9cuXLgAM9Fr6F+dcufpzUM+7S6jGDhxhKL6KBARVw32ex3PtbbEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aa0mx3yF9WsmB64TWr0WlAx9MJkpZst5fyZjmO3fXX8=;
 b=jhwLL6gX0g8oUnGGjizIKmBHYTfOOJo2qTYh9nMYGpWfhPJT40nkBO8LLv3cv7PuWe1r10dc1WkrSsV8FEF70LfAcYgnmUv6WMdspsfF2mdNygLjd26K7WI4Q8M+lyOnWY4jchoMqDUmJuJXXdPwD8P2fKgLuH8kYgjaYOdm/aFknY1CAGpuV6u6Rgt0vb9h2g481rqugiE2TNhD19abl1RuDTP2NTDli8DD4lM9pAq2DV2ZxYHXyk5E9ls6EItPF3dtqmXfbchQ+dRde2oR3ovSYyULyyk+y9BDfOJRPSZXN91Tjdrsccg8H1sZaAv3O6BZ/calg8zjwd5U14uUkw==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by DSVPR12MB999125.namprd12.prod.outlook.com
 (2603:10b6:8:38a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 11:08:48 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d512:9f9:1c70:e24e]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d512:9f9:1c70:e24e%6]) with mapi id 15.20.9870.023; Tue, 12 May 2026
 11:08:48 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Saeed
 Mahameed <saeedm@nvidia.com>, "matt@readmodwrite.com"
	<matt@readmodwrite.com>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-team@cloudflare.com"
	<kernel-team@cloudflare.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"mfleming@cloudflare.com" <mfleming@cloudflare.com>
Subject: Re: [PATCH net] net/mlx5e: Fix use-after-free in
 mlx5e_tx_reporter_timeout_recover
Thread-Topic: [PATCH net] net/mlx5e: Fix use-after-free in
 mlx5e_tx_reporter_timeout_recover
Thread-Index: AQHcx4flU9y7g7jPNUqfCqsqD4u4C7YKcFcA
Date: Tue, 12 May 2026 11:08:48 +0000
Message-ID: <00ce6b5b1081bea03195a39c525b9230e3524256.camel@nvidia.com>
References: <20260408184458.1274662-1-matt@readmodwrite.com>
In-Reply-To: <20260408184458.1274662-1-matt@readmodwrite.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|DSVPR12MB999125:EE_
x-ms-office365-filtering-correlation-id: 7877d9d9-c87b-4baa-4409-08deb016d76b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003|11063799003;
x-microsoft-antispam-message-info:
 2aC+UCqTFKoLyvGyYgRgEp1UI28QNz/OSn+1R8Tauk77DSeFCuYHnjsgreUS0RFjo4tvZtmX+qYRHAXTuF8lTs4p7XnKFNB/3a9oYV3A3SR3exERYVCuQUoVLDXbFaU1nv2TfBSGsmmpkqaj3qBW2RfiVVwrzWUvlGr5/KvCR+6VPDCHV0UY/ZA3uDHBZ1xW+05ZnDUYLEjB9zAmmsZxmUznmL4Hs1S4Qlf4Nt6x9GpdvT0m91YA1OjTtJNLuLZtESrQdNDbgntQLSDx86BOFy4oKm7Z449O00vPWHQUJ3dTcrTnxRx1/DIU4dpvD1lalqgk/znoqQzNh7dzFhXjc+7IQ1hZDwrxaVXx3boSDIQyPHo+Z/OoBq66upg+gN+YrShGdJAJ31e5i1wBdFLyjjwAreRHEl/QvMzeTrmUWqCeGUd7ij5qBZEXSR+34tiI9VEW3F88NQGHXtLCyfpN2KVd7+bMmhdyGdxmiqFFKFoSPtglv0hLsxOLzBW9cfiJKrRzZ+z/mybufHayi5UCiA85MOwOtdj1c+YiNCPHBdc30H5pQTkRgHR7Yi5K+YJ9deqqblMaWNTR7IFYqteoheuBVkolj/+N9r69G9T/6arqwclFD7DQuL031k6GbI4J1CEIsgFsq6E7fJGXtvvT+NCoDVn/R1dnGXJ7U6GQpBVIaFDmBIvvgyl4WaSv1wBlt2DfmVx+XV8JNzIB+zcGRbT79hB8lD7zMIVnGGoxfkmc7NgPc9A9p5gQdYjFpbdA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2hERlVIQTVkQjZHR0lVM0psczdieDBGQ3ZmOFBMaWNQS1JISGxmd0dPN0l1?=
 =?utf-8?B?OUk5Mk90My95MnE1MUt4a3p5SWVUdkV2VnM4NnAwWms5K0JHUi96cHBMTlRW?=
 =?utf-8?B?MWFwTGtQNEpqcGlUNUhmYm4ySW5vajFkRHYydVVYOXF5OVJvU1dOZW5XZ0hI?=
 =?utf-8?B?RzgxbnJwSGpTYXRPM252QWZmdDBBdXBMdVJJMTZmSTlMcmN1anNIN3YvZEdX?=
 =?utf-8?B?UU1SdTVjeUNZdzVxM25wd1RjV21MamdQNjdQYStuYkZLMW1zU2pmQTA2NWhi?=
 =?utf-8?B?SE92bEcxTzBHS3F6a1R5a2RrT2M2bjArc25oK09oYlJnODdQTUZETGVjOGhC?=
 =?utf-8?B?QUZHY2JLNFdObjdTSkIwY1UrNC9lMURCRGJkaWEzMlN3WE5nZ0xzRUcwd2Zl?=
 =?utf-8?B?Qm4rQitzYS81d0VRNUFESTNHTkVsWEw2Z0xobm1oaWZnL2NLbjFXUXpjdGFE?=
 =?utf-8?B?eTBZTXRHdC85Ny9PRVErbStrQmlVMkpmZjFDUXVpYTlMVHV6VVpKYnhzT1dR?=
 =?utf-8?B?Z1lZM1lYdHlhUkF1STAvSFg3Rk5mTFZRbHhWU3RVVnQvRzUrUmFqc29qeG9h?=
 =?utf-8?B?MlJaR0dJS0tkSzh2Zm1aWk9WMW9ZTTBldUQ2S21jQ1A2eGt5SFZKbUxoM3VT?=
 =?utf-8?B?cjFXZ0JJU09pK3JNNWlBanpNb0ZpL0JKSkM4S21VR1IrYUVpS05Jc0RZUklY?=
 =?utf-8?B?RzBqRmp2OVR2UFM2MXl6aVlYQit4N1FpdkJZcGRCY2xjblFaZXdFc3lpcFhn?=
 =?utf-8?B?WGhxT1VITnR4QmpKdEROODRFZWFNQVZXYm5YRm1sMmozbE1WTTkrWVFHcktl?=
 =?utf-8?B?TlQ1RzhLdXA1NTU4aXpEdHRqU0lxZlpDVGc2L0JhcFhxdlU5RXVOR2pxcXVW?=
 =?utf-8?B?S2tZNXgycXBwNHJOdnEya1lnQjl2Y2NRVkNwZUpaSjhOWEdYeXhzT0dnZGxJ?=
 =?utf-8?B?b1hOZzc2N3VuNVdUWmZPcTVwU3ViRzJCVFczWXNLNDZWbkZLQnhPQzVMMlIv?=
 =?utf-8?B?K1dNSm1XSTR4cTg3YmNIb2twRkJNMlJLQnY5bGRGeDVWaFVLZjQxazdoODgr?=
 =?utf-8?B?Vko4Qi81UDUrb2lRNFdDZ2M3clFSUVJ0SmNZTGtITEVVZWFaT2xOY0VRaGJC?=
 =?utf-8?B?UEdNQk1TdGdqRzFBbm4rSk5sOFAyQVZxOEc4WTZ5Z002dlpqUUI3RElGTVBr?=
 =?utf-8?B?Tit2d2RnaHd5RlJuM08vaHJzRy9CaGVHVG9nS29JaitDL3VKVUwvZmRYald0?=
 =?utf-8?B?RmNnSUg2THp6Mk15ZHN5WUVYNHNhMVJ6U1doUnlCKy9DRlJFMHd2V0dxYWtG?=
 =?utf-8?B?NVNZdEtaNnNPeEIzMDlmY0dwcjByVDZxVExvcFF6V3JQWXNvTGVmZy9KSHgy?=
 =?utf-8?B?bXRYT29lQjgyRkJ2d3hjQk9SSDk3NXR5c3YzdEZZU3VDYlFsQmtwQ3VqaHUz?=
 =?utf-8?B?dk5hNEVIQTdNY3JKelNwL0UyWXNncU5EWWVIWFR3ck43a01OREZ4YUhKUEho?=
 =?utf-8?B?SnNLeisrOGpnQmljZG9CbmNjYjRlK2FxTVdXSWt4cHg1NkVjcGIydWdvUmIr?=
 =?utf-8?B?SjBGMm9xMEFOZ09iUWVxQnRROWQ1amxQWHlqQXNoMjZiL2lFUTNiT1pVbm04?=
 =?utf-8?B?UXNjU2tVRXBJODhjTzlwbDkzNEJsUEg4MXRSVzVOeHpZL1h6ZWNXdHFrOG9j?=
 =?utf-8?B?Mnl3Y3VzaTkzbDZ3c0RnRXd2K21lWlg2am1XS2RVREc0R0R0NDMrWTBwTFVu?=
 =?utf-8?B?alN3NFM4Q2VNRXVNbjNTR25KYXZPcnJ1Rit5RDZPbUhtc0xtVFRYdFBkVVdq?=
 =?utf-8?B?cGFNNmNsL1BDV0hDWVYySkVZZWUzbXF3VGE5N0NKYXdXcEVHK1BXME1EUlNj?=
 =?utf-8?B?alVRd29SR1kxSTQ2MmdURVdUTERNZHE3YTdMdHZyQ3dYQW9KOUUzR1hoenZZ?=
 =?utf-8?B?STNyNUJZK21JcEg5bUdqc1BQbDdYK1pSK3ZCRFptV3FvelRreXJkVVBqNTcy?=
 =?utf-8?B?QTlmVllNMDZPOUN2U3ZvRzVHTDZVYmdZL0lwd3pOckxvRHVzcERaVnlpZ1dJ?=
 =?utf-8?B?SiswamhvNHVpdmI3eDYyVVpXUjhSeWlNbDN6VzZJUHJWa2wra1l4elFzTEVM?=
 =?utf-8?B?a1FmMkl5NEFLd0ttYTBiWE5DK1BvUGhhelgxMXlBM3M2MW9ZeG9JR20vQXlP?=
 =?utf-8?B?VzRYRHlYcjFPZXhSMEIzeHFBVXRxdlg3NmExU0tSa2FraGpJbFVTNktuaVhm?=
 =?utf-8?B?TXpSbEE0U0NQNjNwalFIVzg3SFR0V01CczlsWXlvZTU4KzJMK3pMZCtDaDFC?=
 =?utf-8?B?S05HYzJUaEN5NG9zL0F1U1VJc2g4SXkxS3JtbnJCcWJ6TERZcUpoZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1B32BF4E3AA7449A2C01CA788AF9F47@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7877d9d9-c87b-4baa-4409-08deb016d76b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 11:08:48.2787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RbUSr+uZWI7hNfJ9wmk3Cb6u1XGwUf9/UGKq5yzlrOWN5Zq5BOqjCbY66jiUDOUfiyy15UNQjJr2hdCyM8QbiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999125
X-Rspamd-Queue-Id: 89EF751F161
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20482-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,nvidia.com:replyto,cloudflare.com:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTA0LTA4IGF0IDE5OjQ0ICswMTAwLCBNYXR0IEZsZW1pbmcgd3JvdGU6DQo+
IEZyb206IE1hdHQgRmxlbWluZyA8bWZsZW1pbmdAY2xvdWRmbGFyZS5jb20+DQoNCkZpcnN0IG9m
IGFsbCwgYXBvbG9naWVzIGZvciB0aGUgZGVsYXksIEkgbWlzc2VkIHRoaXMgYW5kIGl0IHNlZW1z
DQpub2JvZHkgZWxzZSByZWFjdGVkIGZvciBtb3JlIHRoYW4gYSBtb250aC4NCg0KTmV4dCB0aW1l
LCB5b3Ugd2lsbCBwcm9iYWJseSBnZXQgbW9yZSBpbW1lZGlhdGUgcmVhY3Rpb25zIGlmIHlvdQ0K
ZGlyZWN0bHkgQ0MgdGhlIHBlb3BsZSBpbnZvbHZlZCBpbiB0aGUgcGF0Y2ggd2hpY2ggaW50cm9k
dWNlZCB0aGUgYnVnLg0KVGhpcyB3aWxsIGFsc28gbWFrZSB0aGUgcGF0Y2h3b3JrIGNoZWNrZXJz
IGhhcHBpZXIuDQoNCj4gDQo+IG1seDVlX3R4X3JlcG9ydGVyX3RpbWVvdXRfcmVjb3ZlcigpIGFj
Y2Vzc2VzIHNxLT5uZXRkZXYgYWZ0ZXINCj4gbWx4NWVfc2FmZV9yZW9wZW5fY2hhbm5lbHMoKSBo
YXMgdG9ybiBkb3duIGFuZCBmcmVlZCB0aGUgY2hhbm5lbCAoYW5kDQo+IGl0cyBlbWJlZGRlZCBT
UXMpLiBSZXBsYWNlIHRoZSB0aHJlZSBzcS0+bmV0ZGV2IHJlZmVyZW5jZXMgd2l0aA0KPiBwcml2
LT5uZXRkZXYgd2hpY2ggaXMgc2FmZSBiZWNhdXNlIHByaXYgb3V0bGl2ZXMgY2hhbm5lbCB0ZWFy
ZG93bi4NCj4gDQo+IFRoZSBuZXRkZXZfZXJyKCkgY2FsbCBhbHJlYWR5IHVzZWQgcHJpdi0+bmV0
ZGV2IGZvciB0aGlzIHJlYXNvbjsgbWFrZQ0KPiB0aGUgdHJ5bG9jay91bmxvY2sgYW5kIGhlYWx0
aF9jaGFubmVsX2VxX3JlY292ZXIgY2FsbHMgY29uc2lzdGVudC4NCj4gDQo+IFRoaXMgZml4ZXMg
dGhlIGZvbGxvd2luZyBLQVNBTiBzcGxhdDoNCj4gDQo+IMKgIEJVRzogS0FTQU46IHVzZS1hZnRl
ci1mcmVlIGluDQo+IG1seDVlX3R4X3JlcG9ydGVyX3RpbWVvdXRfcmVjb3ZlcisweDFkZC8weDM2
MCBbbWx4NV9jb3JlXQ0KPiDCoCBSZWFkIG9mIHNpemUgOCBhdCBhZGRyIGZmZmY4ODk4NjBlZDBi
MjggYnkgdGFzayBrd29ya2VyL3UxMTM6Mi81Mjc3DQo+IA0KPiDCoCBDYWxsIFRyYWNlOg0KPiDC
oMKgIG1seDVlX3R4X3JlcG9ydGVyX3RpbWVvdXRfcmVjb3ZlcisweDFkZC8weDM2MCBbbWx4NV9j
b3JlXQ0KPiDCoMKgIGRldmxpbmtfaGVhbHRoX3JlcG9ydGVyX3JlY292ZXIrMHhhMi8weDE1MA0K
PiDCoMKgIGRldmxpbmtfaGVhbHRoX3JlcG9ydCsweDI1NC8weDdjMA0KPiDCoMKgIG1seDVlX3Jl
cG9ydGVyX3R4X3RpbWVvdXQrMHgyOTcvMHgzODAgW21seDVfY29yZV0NCj4gwqDCoCBtbHg1ZV90
eF90aW1lb3V0X3dvcmsrMHgxMDkvMHgxNzAgW21seDVfY29yZV0NCj4gwqDCoCBwcm9jZXNzX29u
ZV93b3JrKzB4Njc3LzB4ZjIwDQo+IMKgwqAgd29ya2VyX3RocmVhZCsweDUxZi8weGQ5MA0KPiDC
oMKgIGt0aHJlYWQrMHgzYTUvMHg4MTANCj4gwqDCoCByZXRfZnJvbV9mb3JrKzB4MjA4LzB4NDAw
DQo+IMKgwqAgcmV0X2Zyb21fZm9ya19hc20rMHgxYS8weDMwDQo+IA0KPiBGaXhlczogODNhYzAz
MDRhMmQ3ICgibmV0L21seDVlOiBGaXggZGVhZGxvY2tzIGJldHdlZW4gZGV2bGluayBhbmQNCj4g
bmV0ZGV2IGluc3RhbmNlIGxvY2tzIikNCj4gU2lnbmVkLW9mZi1ieTogTWF0dCBGbGVtaW5nIDxt
ZmxlbWluZ0BjbG91ZGZsYXJlLmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy9uZXQvZXRoZXJuZXQv
bWVsbGFub3gvbWx4NS9jb3JlL2VuL3JlcG9ydGVyX3R4LmMgfCA2ICsrKy0tLQ0KPiDCoDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuL3JlcG9ydGVy
X3R4LmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW4vcmVw
b3J0ZXJfdHguYw0KPiBpbmRleCBhZmRlYjFiM2Q0MjUuLjg0MDlhZTczNzY4ZiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuL3JlcG9ydGVy
X3R4LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2Vu
L3JlcG9ydGVyX3R4LmMNCj4gQEAgLTE2MCwxMyArMTYwLDEzIEBAIHN0YXRpYyBpbnQNCj4gbWx4
NWVfdHhfcmVwb3J0ZXJfdGltZW91dF9yZWNvdmVyKHZvaWQgKmN0eCkNCj4gwqAJICogY2hhbm5l
bHMgYXJlIGJlaW5nIGNsb3NlZCBmb3Igb3RoZXIgcmVhc29uIGFuZCB0aGlzIHdvcmsNCj4gaXMg
bm90DQo+IMKgCSAqIHJlbGV2YW50IGFueW1vcmUuDQo+IMKgCSAqLw0KPiAtCXdoaWxlICghbmV0
ZGV2X3RyeWxvY2soc3EtPm5ldGRldikpIHsNCj4gKwl3aGlsZSAoIW5ldGRldl90cnlsb2NrKHBy
aXYtPm5ldGRldikpIHsNCj4gwqAJCWlmICghdGVzdF9iaXQoTUxYNUVfU1RBVEVfQ0hBTk5FTFNf
QUNUSVZFLCAmcHJpdi0NCj4gPnN0YXRlKSkNCj4gwqAJCQlyZXR1cm4gMDsNCj4gwqAJCW1zbGVl
cCgyMCk7DQo+IMKgCX0NCj4gwqANCj4gLQllcnIgPSBtbHg1ZV9oZWFsdGhfY2hhbm5lbF9lcV9y
ZWNvdmVyKHNxLT5uZXRkZXYsIGVxLCBzcS0NCj4gPmNxLmNoX3N0YXRzKTsNCj4gKwllcnIgPSBt
bHg1ZV9oZWFsdGhfY2hhbm5lbF9lcV9yZWNvdmVyKHByaXYtPm5ldGRldiwgZXEsIHNxLQ0KPiA+
Y3EuY2hfc3RhdHMpOw0KPiDCoAlpZiAoIWVycikgew0KPiDCoAkJdG9fY3R4LT5zdGF0dXMgPSAw
OyAvKiB0aGlzIHNxIHJlY292ZXJlZCAqLw0KPiDCoAkJZ290byBvdXQ7DQo+IEBAIC0xODYsNyAr
MTg2LDcgQEAgc3RhdGljIGludCBtbHg1ZV90eF9yZXBvcnRlcl90aW1lb3V0X3JlY292ZXIodm9p
ZA0KPiAqY3R4KQ0KPiDCoAkJwqDCoCAibWx4NWVfc2FmZV9yZW9wZW5fY2hhbm5lbHMgZmFpbGVk
IHJlY292ZXJpbmcNCj4gZnJvbSBhIHR4X3RpbWVvdXQsIGVyciglZCkuXG4iLA0KPiDCoAkJwqDC
oCBlcnIpOw0KPiDCoG91dDoNCj4gLQluZXRkZXZfdW5sb2NrKHNxLT5uZXRkZXYpOw0KPiArCW5l
dGRldl91bmxvY2socHJpdi0+bmV0ZGV2KTsNCj4gwqAJcmV0dXJuIGVycjsNCj4gwqB9DQo+IMKg
DQoNClRoYW5rIHlvdSBmb3IgdGhlIGZpeCwgaXQgaXMgYSByZWFsIHByb2JsZW0gd2hpY2ggY2Fu
IGhhcHBlbiBpZiBkaXJlY3QNClNRIHJlY292ZXJ5IGZhaWxzIGFuZCBhbGwgY2hhbm5lbHMgbmVl
ZCB0byBiZSByZW9wZW5lZCwgd2hpY2ggaXMNCmFwcGFyZW50bHkgd2hhdCBoYXBwZW5lZCBpbiB5
b3VyIEtBU0FOIHJlcG9ydC4NCg0KUmV2aWV3ZWQtYnk6IENvc21pbiBSYXRpdSA8Y3JhdGl1QG52
aWRpYS5jb20+DQo=

