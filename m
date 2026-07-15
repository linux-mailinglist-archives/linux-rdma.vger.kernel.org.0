Return-Path: <linux-rdma+bounces-23261-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N+e1OOBDV2pQIQEAu9opvQ
	(envelope-from <linux-rdma+bounces-23261-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 10:25:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8C375BD75
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 10:25:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microsoft.com header.s=selector2 header.b=FEAlnCjJ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23261-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23261-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microsoft.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B59AF3017F9E
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 08:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21923C3C0E;
	Wed, 15 Jul 2026 08:23:44 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023134.outbound.protection.outlook.com [40.107.159.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D2F2FFF9D;
	Wed, 15 Jul 2026 08:23:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103824; cv=fail; b=i/pxDsElZsviZmSPnnsGmMocADzDaPChGEzeJr/mF+raYFYmKim5oGp0G5DWTUsoyfDNodlK0k9zx5qSGLOsO9ov+bDMBT1XzjbfKyEaaAS5lVsdWJakZOoKMpqhP46lOsCBjpTaHTw2WPG2IFhQuYrnNvKKGUQIxHkIjUFR7X4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103824; c=relaxed/simple;
	bh=bDwczlr8qfN1J+oM+npuQN0jMZ7Iqvf71ACHnNfJVqA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JORZzW/H+eAFzK684dOer/sAIA9Bme8u9ulU22FMIwfoOV2dAVR4uuUPyI9eBThbicW5aZvBiNttnkh5cLyFZ0CM4MoJRsm793d2eGG1zMmUMB2tUperhABqBDFkbfyCq0t4L5trqJLxA1WGjItVLF9mluBv+7Tux0fzlonuGQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=FEAlnCjJ; arc=fail smtp.client-ip=40.107.159.134
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tL9nPr2z98Dm34sAES/L0XYICviKFSz5RAnwvqpDQi2aBjEF7sFEBhMuVPibioQ8Hwxe+KgqCWiDyQR805MQ0Ph+X+RseQBWe3LMxmdPr9D9+CVo55srh74SpmoLpslFsDxwK73uew70d7FileYtQx7LJ7wTKmhgG4YOIys4HMIWOR7NwMwsEPKqkZ87H6mnuhpt2ovsY6iN6G1xisjLGoiJ7Gnd8jge3abqwGLep1OnzbsLgWCmvhw9utLJmwUcKbKNvxfbyoZwr+NJQpyOVClKRMzpnOMG69/SrYcjpKieoKvlPbY2RZqQEDzF7ovXDO6d4VwYqn3NwUleupINEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDwczlr8qfN1J+oM+npuQN0jMZ7Iqvf71ACHnNfJVqA=;
 b=L1BdDH4WpwPSRrY5M1syP2LF6ECX5Y2wn89lJ7aKxnO+Gz0P4OM92WDG5HOKlZ7GjT7HVGCWGhq3rW0P0D/dTYb9z3HcaV+XuzQ45dZeWPd8UxxFwiRtAGwrSmeDDsphl7LLh6FsC1vc9OIYjXBWJ6Y+T5RdX2EiVkoslCb6jzZFE9q6/Sb7DiEFbhB9U4MyhalGE2KVBgukt144OSKdcTLJv4DuS5r3ng5eP1QA4T1D20+yB3LUa/PnVSOz9stL1gi6bQRX/T7QSgJXWy8ps7eMlg9MZsupLbG6YJtvrO6X3+iPywCH5EcfPvS+l1XL8D4zCyxSdpFck4i9x4LKGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDwczlr8qfN1J+oM+npuQN0jMZ7Iqvf71ACHnNfJVqA=;
 b=FEAlnCjJYbmHVEZxjdRlWkN4e/b8FMYTA7MXHRY10tJ5FZqWMbxtZBodOh7qv5UtJtFcFaHqPnWMHd/MhjXxp4t6FdV7xsc+rIvZXkF8s2A39pm7v/Qg+L4uhx5mBv9yDpqqHhGHlupDe/zhz6lDm0K4pFsCO/qk3p+ul5FwaDY=
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com (2603:10a6:10:5cb::5)
 by PA1PR83MB0824.EURPRD83.prod.outlook.com (2603:10a6:102:484::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.3; Wed, 15 Jul
 2026 08:23:37 +0000
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e]) by DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e%6]) with mapi id 15.21.0245.003; Wed, 15 Jul 2026
 08:23:37 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>
CC: Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next v3] RDMA/mana_ib: Adopt robust udata
Thread-Topic: [PATCH rdma-next v3] RDMA/mana_ib: Adopt robust udata
Thread-Index: AQHdFDM8BhQi0NgFuU+a20E8rnfGzw==
Date: Wed, 15 Jul 2026 08:23:37 +0000
Message-ID:
 <DU8PR83MB0975BDB75B8FDFCE95E8C9ECB4F82@DU8PR83MB0975.EURPRD83.prod.outlook.com>
References: <20260714123113.3792099-1-kotaranov@linux.microsoft.com>
 <20260715080701.GC21348@unreal>
In-Reply-To: <20260715080701.GC21348@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=25f0eaa1-b174-469b-9649-536b6e29cf3b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-07-15T08:17:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU8PR83MB0975:EE_|PA1PR83MB0824:EE_
x-ms-office365-filtering-correlation-id: e62b9cd1-d484-4551-3fe7-08dee24a5e98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|4143699003|11063799006|38070700021|56012099006;
x-microsoft-antispam-message-info:
 w8ZoAaqoHpDlGXarA8+4v63SJEUWyto9EBoWvZMdooM97imfFNvjXXFMe2G4VN4jvxbBKmss9g/enS1Lh1N/Fh8WaYQJ+2vHOlsszCMeRAhlcUNB2ROafWi0x2Q+MjeBsLlN2L6OKY5AOqhK+EyHtkF9KUCEVavYEl1ZNuiGp3q4VoAokH0IEQXhtc/F1YdJsuDLFBZxNrNHYoXcEz3psJXgxUJU/0SdDqIYHF7Pvn4tUarryMxZQWf9obsaFyd1EyLYv6abplL1DBRw6C6Ovgzl3n3+JOO1G9y3NM56VRBk8ZpSNT5bBUGa0toie/p7TNl0r4z6pnqNI3qrjuN5a9SprkhABOed91l+CsuGCso8v79AzUBBZ5ELVK6a1Ny3vdEG7L+nIHB3SkmfnFsh/TrwujhtHxgN28V7hKjGtH9+u9v75/6qOXL/7toZnJhDnmzzaS01wYuIl3tb1qYwkY440ozIuxKJ2fNDhq6sF12aptYS4ZSrSoW49GTYUN0HVgjNPO9s+jxVLcbNnXik73tH0A71ryIAtZebQlAWYSyRtiAl+HCq7+Z9AVCBR1Z/M2KRlO6sjVam2Iqx6oMTwbJ/WLX3nx48RXFFVvBCbzW/2vX9ex1xIJNt8pP7d6DNvvuT15tLJvtH6kn0ZvcUTnwuk4Iyh0K5lPc/jWh6VKXEi1MUirPqccUpyTbpcKiYKwNTGUWwBX0ug5L1BL+o/yOhudKubxzGr1J/4t/+6vY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU8PR83MB0975.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(38070700021)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2owWW1HYnRsMjlqUTZuTUMyOXJmcE0vVFJuMnJKcUNKWElHL0tWdWEyZDU4?=
 =?utf-8?B?T0RWU3JoQ3IyVWZreURuQnlOQkhPdHA5SktwdS84RCtRMjhPeVBSaVY3Y1pU?=
 =?utf-8?B?enBQWHdSbHMzcTllMFdoVW96ZVNpd2VyaWVuZmxYeVowVlBGRTl1OHJWZnUw?=
 =?utf-8?B?MWtaK2dkY21hZ1kvV3F0NzVPRTR5UytBVnRDb2ViZlhtTUo3YXVXclRGRWhy?=
 =?utf-8?B?V3ZodkhKWmVERlJqZFBMM2hVTXNsVmVzZUFsUDhYSUJnanpNeFFQMWRQR0pu?=
 =?utf-8?B?Rjlta1NNZUdnVDVxa1AwOXkvblVscEJkS2pNYXc3MEJ0eGF1SURJdW1wVVVG?=
 =?utf-8?B?M2VXUGtidEtNQ1BBNTNPSFlVa2dzdC81Ym1JUXFtZ1JVS01CdTRnVy9PaDFr?=
 =?utf-8?B?dU56QXBERVdJM08xd0swaVdSRHNrSzEwUzRCRkZvLy9lckwwbHZtcDNKRmN5?=
 =?utf-8?B?Y0VjWkx2TzFxOWwwZUxkMWJzb1o2L1Y1Q25DK25TL2c2VDc3VlBKRmp5cFQ3?=
 =?utf-8?B?R1pkQ1ZDRjJCVXpScmV2ODFiY2lscGFUa0JPeEpuUXVPTlkvRjBXVTlSbDFv?=
 =?utf-8?B?MHRoSTRuSHd4Wk53c3RnVjJRMHJ3Ty9JK0dZL2RTNW1Tb0VyNlBSK0dzemxX?=
 =?utf-8?B?TGRmdStyMVpsMExJRmE0SFRrb2pZbkRJVk9mS0xBbWoyVlBxRGFuY0RBZ2Za?=
 =?utf-8?B?OUZCL0t1VytCT2hIWWQ2NWFYRmthYWF3OUNQT1FFQ1hkVHFnMldqejlmWHB2?=
 =?utf-8?B?MnFQYkk3TjkwMkRWR2pOZitnMmxxUlhRNlBqM3VKVldnUS9IVkNrYk9WYkNX?=
 =?utf-8?B?ZmtNaExFbHhUMXV1OGRIQnRvallHOTczQWpIZnJnemx6UHpVRTY3djM3Yjhk?=
 =?utf-8?B?UEwxWUtQNTk2eEc3NGRvY1ZraVdhNDRLeGNJeTN3RkRBbnRFdlpXNnE4TmhV?=
 =?utf-8?B?RTczZjhrM04wakNBOTBEa1Nhc2ZYZlVGWVBLSUptQXY1VS8yOXRIVnQ4RlJZ?=
 =?utf-8?B?NTVmTzFKMUhmTTRqOEVTQW1JSHlzb3FBZ2E0ZzU0NWZjemJrK0VzQ1NFY0Uv?=
 =?utf-8?B?NnNNNlpnZkdBbHhkTFhOZWo3R01iYzZvN043OTBSRFkwdHpVMHJvQzhxNGFL?=
 =?utf-8?B?Z1BmdllCU0gzUnBBQVM3aHNQaXVFYm5CSGVnNjAwUktOeVJVTi9UMVkyZlkv?=
 =?utf-8?B?NTdwa0QxVm5XVDdEbkhTMU90NndyR29aUUdtUDc2SG5sREp4eDBlV0NyUHBO?=
 =?utf-8?B?ZWFxTTR1VnZpUmZyWkErRjNSR3o2NmFrRXBYWXdCekpBZ3doNzBNSEF3aklI?=
 =?utf-8?B?cHJTaEpUVFphQytjOXdSNUs1MzdVeUZFekZjaDFDK0JLZXJZMXBoVmQ5TjJL?=
 =?utf-8?B?bUJoUGFGNEgrOG1kV2hteWhocEk5enE5SWY1ek9hRzNhQTF6RHFacXdYV3Az?=
 =?utf-8?B?eHRYVTRRcHNkdFYzY0cxUis5SkI0MURGVFlJdS9ZTEl5NWY1MVcvVlRPRHdx?=
 =?utf-8?B?a2tmYTZwa01JYUdpRllJcEdkdkRub3pja1N2TklOK1lyeHdSbWx3Smt2U0Ew?=
 =?utf-8?B?dDJOV2EwM2Z0cjRTdlhSUGduZzBkekl1QUJEL2hiaGNUMU1KaDZiRW1CaEZp?=
 =?utf-8?B?SFNJOHg5R291Y2l4TmVDcTBQOCszY0NycFVhbUllek9Ja1VhK1pGN2pNeEo3?=
 =?utf-8?B?M0RyRm5EcEErNUZ6QlRoUWRzRzZLNURGbjl3bDRXbHY2cFY4Y2phSjdQM0Zm?=
 =?utf-8?B?dFM4cE9Udk5SRTcyOHkrRmZFdXVKZHlQZlNtUFZNRHg1UUtVakNpVDB2eFdP?=
 =?utf-8?B?SjNFdWVxOTFxeHRXZjdGTlZWV2R3NzdOWGJ3YWpvciswZ25IWkp0cVVLVHkr?=
 =?utf-8?B?cDlOUENod0FaUjZkd2IrRDZjdU12NXhKSlc2WjEvYnVZL0R5MHgyNHl4RHJG?=
 =?utf-8?B?aE1IS2NKdkxoZjc0MlpuS054U0ZQaUtDZmFvQnRXMnNmanlRZ2pKNFVwSGN5?=
 =?utf-8?B?WDdIRE12MUlwNTdEUy9mRUozZXJ0dmljQ05NMXpRMkM5UiszS3ZPbkpvd0Jt?=
 =?utf-8?B?STZWSmFUcnJaNEprUk84WElaUGxGTXk1alFLT1J4TnNrNnVpUFNMa1dHNkJX?=
 =?utf-8?B?RGJFY2tENVAyNUJMU1pVV0hQaE9JWHpLejRqcHJ5bmZIY2hTVXk0Vmx3NXlv?=
 =?utf-8?B?OE83cmNJbldXeHJhU0JDNEdHSzJRUWY3TlN3SXJ4T1BwczFGUGZSQ3RoSlo0?=
 =?utf-8?B?Z3BQZ3E5MGFvejc3ZG1OVDhxRjhnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU8PR83MB0975.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62b9cd1-d484-4551-3fe7-08dee24a5e98
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 08:23:37.5165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8gtKVo2rdpgFfZLkmdEDW2DqrgyUTKy0+zi5Ctp4mc2plB6AYX4eXr2bzZoGluZqrkfvzvp7HtKVxGaOK20GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR83MB0824
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.06 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:kotaranov@linux.microsoft.com,m:longli@microsoft.com,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kotaranov@microsoft.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-23261-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kotaranov@microsoft.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[DU8PR83MB0975.EURPRD83.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F8C375BD75

PiANCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL3JkbWEvbWFuYS1hYmkuaA0KPiA+IGIv
aW5jbHVkZS91YXBpL3JkbWEvbWFuYS1hYmkuaCBpbmRleCBhNzViZjMyYjguLjgzMzZiZjUxYiAx
MDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL3VhcGkvcmRtYS9tYW5hLWFiaS5oDQo+ID4gKysrIGIv
aW5jbHVkZS91YXBpL3JkbWEvbWFuYS1hYmkuaA0KPiA+IEBAIC0yNSw3ICsyNSw3IEBAIGVudW0g
bWFuYV9pYl9jcmVhdGVfY3FfZmxhZ3Mgew0KPiA+DQo+ID4gIHN0cnVjdCBtYW5hX2liX2NyZWF0
ZV9jcSB7DQo+ID4gIAlfX2FsaWduZWRfdTY0IGJ1Zl9hZGRyOw0KPiA+IC0JX191MTYJZmxhZ3M7
DQo+ID4gKwlfX3UxNgljb21wX21hc2s7DQo+IA0KPiBUaGlzIGNoYW5nZSBpcyB1bnJlbGF0ZWQg
dG8gdGhlIHBhdGNoLg0KDQpJdCBpcyByZWxhdGVkLiBJdCB3YXMgZG9uZSBmb3IgdGhpcyBjaGFu
Z2U6DQotCQllcnIgPSBpYl9jb3B5X3ZhbGlkYXRlX3VkYXRhX2luKHVkYXRhLCB1Y21kLCBidWZf
YWRkcik7DQorCQllcnIgPSBpYl9jb3B5X3ZhbGlkYXRlX3VkYXRhX2luX2NtKHVkYXRhLCB1Y21k
LCBidWZfYWRkciwNCisJCQkJCQkgICBNQU5BX0lCX0NSRUFURV9STklDX0NRKTsNCg0KVGhlIGhl
bHBlciBpYl9jb3B5X3ZhbGlkYXRlX3VkYXRhX2luX2NtKCkgZXhwZWN0cyB0aGF0IGZpZWxkIHRv
IGJlIG5hbWVkIGNvbXBfbWFzay4NClRoaXMgaGVscGVyIHdhcyB1c2VkIHRvIGVuc3VyZSB0aGF0
IHRoZSBrZXJuZWwgcHJvY2Vzc2VzIG9ubHkga25vd24gZmxhZ3MuDQpTbyBpZiB3ZSBhZGQgYW5v
dGhlciBmbGFnLCB0aGUgb2xkIGtlcm5lbCBzaG91bGQgZmFpbCBpdC4gaWJfY29weV92YWxpZGF0
ZV91ZGF0YV9pbigpIHdhcyBub3QgY2hlY2tpbmcgdGhlDQpzdXBwb3J0ZWQgZmxhZ3MuDQpNeSB1
bmRlcnN0YW5kaW5nIHRoYXQgZW5mb3JjaW5nIHN0cmljdCBjaGVja3MgaXMgYSByZXF1aXJlbWVu
dCBmb3IgdGhlIHJvYnVzdCB1ZGF0YS4NCkkgaGF2ZSBhbHNvIHVwZGF0ZWQgdGhlIHJkbWEtY29y
ZSBQUiB0aGF0IHJlbmFtZXMgZmxhZ3MgdG8gY29tcF9tYXNrLg0KDQpLb25zdGFudGluDQo+IA0K
PiBUaGFua3MNCj4gDQo+ID4gIAlfX3UxNglyZXNlcnZlZDA7DQo+ID4gIAlfX3UzMglyZXNlcnZl
ZDE7DQo+ID4gIH07DQo+ID4gLS0NCj4gPiAyLjQzLjANCj4gPg0K

