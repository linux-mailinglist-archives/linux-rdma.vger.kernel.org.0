Return-Path: <linux-rdma+bounces-19434-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHU+A2QA5mnVqAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19434-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 12:31:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF64D4295D7
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 12:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E2B030162A6
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 10:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C67A392C5B;
	Mon, 20 Apr 2026 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IMhXdJ3q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013042.outbound.protection.outlook.com [40.93.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E29B19D092;
	Mon, 20 Apr 2026 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681052; cv=fail; b=BuRM3UzpiA/cm3B/RX/JXmGMRtNX5dNz/iIW7f9U4nqNDMVxG0HDagboLQaw1M3BsMa1gAVaHt/vGhjz9x1XMZnEkvmmmeaBeQ6iIm2Yhc5vJ3CURhMdWA7vPdKM88KeKovxX1nsD/we1+Y1c12yRhczI87+3G3EwL/Kj034OZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681052; c=relaxed/simple;
	bh=v1xlTANnEw7S7A0whLTbrDWQXsOGOsWKLKy3PElBOH8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qg+/AxMg1tbuxH2SbiZ+P/T8cBKhll1V3QHo15B1ZemFe46AU55g/93QfBagflNz7vLzjuphH2fPedvFmtjg4p5vlvngHXo3Q9XuWRcRwq8hJxohkuO00/nYj7+sTQmGf8L41GP71iwFche26da/+yXJTSE5tys9IqA7F1oiWwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IMhXdJ3q; arc=fail smtp.client-ip=40.93.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYbFMG8mUcysv5b8aJAovrq/3Z48EGSWLAXf4RTEjamlUoXK3IQuuWLP84WXUA4AFmjNsm9stUobkiMj8IrC0VtAlgVz4vojGTdA/th13RI3JK21O4+5tA9uzWmn71X1Sf0XwGxTTS2DjBEkZI4fUj1724xR0qil+4zJbjy4o8OyBX8vFeMVyuZGPKnuzgnLh61lSIq5n9ASDB0dvWFdhyIMjUfBhEJFfjlgC+w4Vp/oK00wRBjO15502Fgd/7IXuGvget48I3hgWcg4QyONRpAvopCyrQptLQ3koEow4vkdgEXUbtb6iq9v9/vbWDPdhgt8W8OHcApPJa3vSA/x0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1xlTANnEw7S7A0whLTbrDWQXsOGOsWKLKy3PElBOH8=;
 b=IjyngzdxOrEAt6sR5MBRCYlzNw15WHWgOFcsKPjnFBD3gOqqj2BQ5rdFt4N0K+LG/Lk4PbnyPjR/tIt+PVao/Wi4OBx9apxgsTJxcBMKGFvjB0Ocn4/aBtyrZql3oCh2xXhJP9+9un5opTa7PxMuWfPi1AZ1gjWh8mEuC3ivVhZ9b4kSbweg5z5kjyXcmiyNCsbGEHMPME2rpA0LWq1CI2chS4pm+bHrdMtsr852+TkX8e4Vv8R5InNEFhy06Mai7A9Ef2PFjBLiZ4Tls8LfME/QEc5RMdkpAN+Wrkk1eP7GnhQkIMeDQWh5FKLhTEEXsqPhacbV9sGYmbE6Z7gbew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1xlTANnEw7S7A0whLTbrDWQXsOGOsWKLKy3PElBOH8=;
 b=IMhXdJ3qFjlErFLf5jKg5yZCCjU56ce/scZGk7pQa73X5pBvYEKHQbV6gnrl0dzKClwPB9y7zsHuGb1qkEM5YJBbYGGK54qdqXCfUUMdMvuEKqvP8gQwg7bO7PIkYCLWhgMFNYBO/ng+Z44YMyU62pygz4btdD+9PrfsjKhbH0EqVKwYCNbl02DVFKDTItV0MgIu3m03CMBwpZxmWkgj7Ua6Ps9DayKtFrleVYp0ghy8UG7w5lPXqcTJG6uAJTtIIUTFFLyZGxdAIjvnnrxogXKVsbL290oZk6LBSUE5fNTwayz1Dwl6B1rN9AWWuGohhvdBYCHXMrb5mtBCoUgL+w==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by DSWPR12MB999128.namprd12.prod.outlook.com
 (2603:10b6:8:36c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Mon, 20 Apr
 2026 10:30:46 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d512:9f9:1c70:e24e]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d512:9f9:1c70:e24e%6]) with mapi id 15.20.9818.017; Mon, 20 Apr 2026
 10:30:46 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: Boris Pismenny <borisp@nvidia.com>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "leon@kernel.org"
	<leon@kernel.org>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Raed Salem <raeds@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, "kees@kernel.org" <kees@kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, "edumazet@google.com" <edumazet@google.com>, Saeed
 Mahameed <saeedm@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net 1/2] net/mlx5e: psp: Fix invalid access on PSP dev
 registration fail
Thread-Topic: [PATCH net 1/2] net/mlx5e: psp: Fix invalid access on PSP dev
 registration fail
Thread-Index: AQHczieNmLFIHpbrDUuqFWyBz+NLKrXlMUIAgAKT6wA=
Date: Mon, 20 Apr 2026 10:30:46 +0000
Message-ID: <d7e2d46769e120a16ce12d345c51a47349733828.camel@nvidia.com>
References: <20260417050201.192070-2-tariqt@nvidia.com>
	 <20260418190848.204170-1-kuba@kernel.org>
In-Reply-To: <20260418190848.204170-1-kuba@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|DSWPR12MB999128:EE_
x-ms-office365-filtering-correlation-id: ad65bd23-f471-4112-8150-08de9ec7e220
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 Xi9MV9eoeGxe1jzljiN63BcWeRJIoOXVk/pY6Y1Ifta39TonF2KlxItbzyFVu9MIzC0LhBR/f3kJNbbDjrAF+0CcbW8kU7K0YpVniQHEEjoYrXwlZH/MAIyRgr5F1/dP2Mkyw6HusFQnM9II4VGXhpbWNlLTp93p1KyEdyo2+YNvuqh9SuJoysKoYr7w87eHMApZT4/hZdME5SChjOo/o851K8vnzP4hgsuACCgWJ/Q9VSYru9AHnZe4GFaVbGXGmVMvLGtblJ9m4oZvp8Yfe3v5Psd3CJxwro6O4LmTh1KLIc7eraEl77Bjh5AiG/1Wf/4EIzjkPjqiR7z4tWOJEbtgzEklTuSKVvlTB6jfILqwPPBeCxw4jJEjYdblVgoSDAw0Xvn5Nft8DwkUO9pqZUGa6B2XowrXDSFhqRP9JF/US5WYrnQ2+5wt1xqpAxZLrwU/5VFmc55i16Ag5v/jY+VzDVQw6fa7LW5vioKqg5cepJVYEodSlKvsExCRzx/mAKDwPvwq8pCdriqQn5ZkwCKmRzj56pI3Lh3F92LXlMb3DkIgZrKh58v7/llDDImxtfdcoHBjejRa8iLVp6jt2QJvjte96QJ2rRV8AGUQythwlp7TT0MLpwONH7XAcrpqoJRbzkXVSVQ/ouYwtKJcSQR3wBdAmNN1RoJLfD2Qp+Btjjf55BCPutobOx/wmE3J9kRfYae3aJk2Z5WmzNUcZtTlJ0amyNlakUlG/zMfxIgf/7t8qmEDvoWsiki9InRcynS+i39RhWDX00piLfEt2fRIsI+HUBDlHXHoF0zSDas=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXVnUzVERTBtZkM1clNKWi9Jc1E4N1JORkZqRWE5UDlVcFFROW1uMHhhZE96?=
 =?utf-8?B?M1JVZFFHT0RXU0kwbS9RT3BiS0c4M1BRWGFOMTkzKytMWmUzQ3VJZHZ0YW5k?=
 =?utf-8?B?eGwxbEFIaTRmZGwwczVQOFJlNW05V1QvZ3ZNL3FLV0RJZ0FvaEIwczhLclJC?=
 =?utf-8?B?VXNNUFVHcGt1dGVScjd1YU5iZWxPV09sR3lkMkM0TjNkMHJmRnljOW9oTUF2?=
 =?utf-8?B?ZU4xSmdzeUdJRnBuQ21tOE5EWGJsU3BQZDFVUmtUSEViNlZMUm1iZHRzOXNQ?=
 =?utf-8?B?UndITEQ5ZzcydzdtUTBhbWc0cGw1Z1ArbTNLenFEMDcvVHZMK3lMTmtaSDRY?=
 =?utf-8?B?Smc3WTlYZlBYSFU5QjdlTEpNWTRGeFVFMzA1aEtQVGFaQ1BGc3BCTlBqTjFQ?=
 =?utf-8?B?ajZYR0tudkhNbER2SVZNazVoWUx1R0xjOGU5SGduQXNxZUhsSmhGSmdBOHBU?=
 =?utf-8?B?dVpLSnJHLy9SdWExYzNTMG4rZWVSMFFtYklCSVczSmhsQyt5cVMxMU10b2Ur?=
 =?utf-8?B?ZWpTN0VyU1Z6Y0RLalhCdWFOakx1ZFBFTFZXM3dPRTI1VWdTcENPY2h6bUN0?=
 =?utf-8?B?RERRMWZMRHlJbnM1Rkh0TTdEU2hRbGE1TmNuZzZiUit3cFc5R3ZzS1IxWVhH?=
 =?utf-8?B?eldXRE1KZU1jTXUwam1PdmQydXM5ZXhra040SjJyRXYxNk81eXBsc2l3L2U5?=
 =?utf-8?B?VnloK0JFc0kwakdmaXhGQlpMU2pySGlBM1hBck5INVlNV1A5MVNNcTFYTW8v?=
 =?utf-8?B?YzgwVzNRSi9aQXpwVjcrWUhRWmpnUGpWeU9qUi94UlJBNEZQSTU3K1lqczh4?=
 =?utf-8?B?ZTY1eU5DOXBkTUpUMURJTGNFZkNidFVxbnczUmxUbkNacldWa0xtRi9lVFNE?=
 =?utf-8?B?N0NlMlkxMUlFWjVYRUU5b3JiVmRLVkFXQVl3dks3c0pWT3RjclByQS9RMmtm?=
 =?utf-8?B?Szl3VnVOOEsvaEZ5UFlWTE1ncUdXMFA4VVhkNlRVdCtEZXlqRFcveXY1L0RS?=
 =?utf-8?B?NkFmYlBTZzNnNlp4THhDUmROM3VZR0g2WGlPb3BPbEJKczhOaG1BSlkvaVhF?=
 =?utf-8?B?eTRPQWFENDJVa1QrK05LOGxsYjhqMnBYWVN0RkNpeGN3RjBmbDJsWVNSUmRn?=
 =?utf-8?B?eWZ4NlI0K2N6cVFVU0tyb28vaGxtWWZXU3FHbVNrNEdHamV5TEcvU3lZQ2FI?=
 =?utf-8?B?SXdVNEg5Ly9kekVpQkZIMS83bzNMUXozY2V4cEdBV1FTSmV5a2Q0bGJXTWcw?=
 =?utf-8?B?Ky9jUWFsL0NiQ1lVZENvMm5hSXQzZU9NV29VMFl3bzVGUmJrRGc0L0VLd2RV?=
 =?utf-8?B?VFExNFRDWFk0QXZTcGhoY3lpTGI3RFFqVXlKK0xFSEtSVjg3UE40aExYMDNO?=
 =?utf-8?B?TmE0TXg5RFRMNm9EcGhHRUtOWWliQmZRMGtLbWlWYnhaOE5Ka1pua1RmNi82?=
 =?utf-8?B?bHcyTDJpa2k4TW16M1Z1UGpLNWFzZUF5K2pJa1RiMmREUEFEcDFwcWRnRk80?=
 =?utf-8?B?UElNMUg2bmFGbkJrMnRsbElWbjJ6Q1NEaXFyNXJCS3NnbFluSFo1K2V0SDlr?=
 =?utf-8?B?QXMvKzNRcEhudyszcVpacFMwT0dyT010aDk1L0tNMTkzWUlGUUVZak1YaHpR?=
 =?utf-8?B?N1UzMGg0R2dzVVhGWGYyNnhDTWlVdXFjNEZUbGs2WWdKMHZNQk15cFc5cDBQ?=
 =?utf-8?B?NlUxUkNwYmRlQUpsbmpiL3R1aHZVeTBZdlRhK21wWWVCQXBCUCt6bXc1ZTg5?=
 =?utf-8?B?dExERnJIb1JjZDZ3NGltaDBraklFU05GY21nWkdSd0V4bjd3dXI3a1dJK3lR?=
 =?utf-8?B?QkpEZkNCTmFNOGJ6c1JpQjFpQnlhMzlnQ25CNE1oK0VMU3Vkam9ocDhXRnlP?=
 =?utf-8?B?Y0hieVV2TWN0R2ltbTIwREpHLzMwazJwbFBNbDBVMEYyZmhYZUlCSHhBUzlM?=
 =?utf-8?B?M2dhUlVsSGYxY3VRRmp0QjFhZnVKK0NNS1FlVWprUHEvSFV4NXU5aFAveHAw?=
 =?utf-8?B?aW5DUkZNZlFIeGUrWEg5c0lJbC8yaW01L040U1pCM2pKVk1KZ2kzTm9KRDY3?=
 =?utf-8?B?dFp2VGpuazNRVG4wYkhnOUdPTTBXVGZYUlR3ZDZ0RUNFRjZwMjBXaUIvNGNV?=
 =?utf-8?B?UTlaSHIraEQzZjA5MUQzY2d4U21ybkJEQW9xbGJOSTI4dXk2UUV1ck5NeHZx?=
 =?utf-8?B?bUphL2owK21YYU9PRVYyakVJNzNkZ3U3REhtRk5kU252dnIyTnlXUWtNWTFZ?=
 =?utf-8?B?U0xQQWVkVUpFdW1oYjFZdVBmTWFYUDliZFVrUmlwaXNGV0dDT2dzY2lBNGtz?=
 =?utf-8?B?UmsyRzFwMWtGd1EwMEhNT3BaVi9EVFIxUDd2K0dFRXh0a0R4bDVOdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFD7E5202FF1DB43916512F31F6B1D4E@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ad65bd23-f471-4112-8150-08de9ec7e220
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 10:30:46.2441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gmTUiUyp/dVEnqt7du+IJPCJ/zD+zayWHubZlk4SfWBweGL4pF0oYtDZHzDjJRdn4X4pwiTvOiSvxNmRvCs7pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999128
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,lunn.ch,davemloft.net,kernel.org,redhat.com,vger.kernel.org,google.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19434-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:replyto,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: BF64D4295D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gU2F0LCAyMDI2LTA0LTE4IGF0IDEyOjA4IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gVGhpcyBpcyBhbiBBSS1nZW5lcmF0ZWQgcmV2aWV3IG9mIHlvdXIgcGF0Y2guIFRoZSBodW1h
biBzZW5kaW5nIHRoaXMNCj4gZW1haWwgaGFzIGNvbnNpZGVyZWQgdGhlIEFJIHJldmlldyB2YWxp
ZCwgb3IgYXQgbGVhc3QgcGxhdXNpYmxlLg0KPiAtLS0NCj4gbmV0L21seDVlOiBwc3A6IEZpeCBp
bnZhbGlkIGFjY2VzcyBvbiBQU1AgZGV2IHJlZ2lzdHJhdGlvbiBmYWlsDQo+IA0KPiBUaGlzIGNv
bW1pdCB1cGRhdGVzIFBTUCBkZXZpY2UgcmVnaXN0cmF0aW9uIHRvIHVzZSBhIGxvY2FsIHZhcmlh
YmxlLA0KPiBvbmx5IHNhdmluZyB0aGUgUFNQIGRldmljZSBwb2ludGVyIGlmIHBzcF9kZXZfY3Jl
YXRlKCkgc3VjY2VlZHMuIFRoaXMNCj4gcHJldmVudHMgYW4gZXJyb3IgcG9pbnRlciBmcm9tIGJl
aW5nIHN0b3JlZCBpbiBwcml2LT5wc3AtPnBzcC4NCj4gDQo+ID4gLS0tIGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX2FjY2VsL3BzcC5jDQo+ID4gKysrIGIvZHJp
dmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX2FjY2VsL3BzcC5jDQo+IFsg
Li4uIF0NCj4gPiBAQCAtMTA3MCwyOSArMTA3MCwzNyBAQCBzdGF0aWMgc3RydWN0IHBzcF9kZXZf
b3BzIG1seDVfcHNwX29wcyA9IHsNCj4gWyAuLi4gXQ0KPiA+IMKgdm9pZCBtbHg1ZV9wc3BfcmVn
aXN0ZXIoc3RydWN0IG1seDVlX3ByaXYgKnByaXYpDQo+ID4gwqB7DQo+ID4gKwlzdHJ1Y3QgbWx4
NWVfcHNwICpwc3AgPSBwcml2LT5wc3A7DQo+ID4gKwlzdHJ1Y3QgcHNwX2RldiAqcHNkOw0KPiA+
ICsNCj4gWyAuLi4gXQ0KPiA+IC0JcHJpdi0+cHNwLT5wc3AgPSBwc3BfZGV2X2NyZWF0ZShwcml2
LT5uZXRkZXYsDQo+ID4gJm1seDVfcHNwX29wcywNCj4gPiAtCQkJCQkmcHJpdi0+cHNwLT5jYXBz
LCBOVUxMKTsNCj4gPiAtCWlmIChJU19FUlIocHJpdi0+cHNwLT5wc3ApKQ0KPiA+ICsJcHNkID0g
cHNwX2Rldl9jcmVhdGUocHJpdi0+bmV0ZGV2LCAmbWx4NV9wc3Bfb3BzLCAmcHNwLQ0KPiA+ID5j
YXBzLCBOVUxMKTsNCj4gPiArCWlmIChJU19FUlIocHNkKSkgew0KPiA+IMKgCQltbHg1X2NvcmVf
ZXJyKHByaXYtPm1kZXYsICJQU1AgZmFpbGVkIHRvIHJlZ2lzdGVyDQo+ID4gZHVlIHRvICVwZVxu
IiwNCj4gPiAtCQkJwqDCoMKgwqDCoCBwcml2LT5wc3AtPnBzcCk7DQo+ID4gKwkJCcKgwqDCoMKg
wqAgcHNkKTsNCj4gPiArCQlyZXR1cm47DQo+ID4gKwl9DQo+ID4gKwlwc3AtPnBzcCA9IHBzZDsN
Cj4gPiDCoH0NCj4gDQo+IFdoZW4gcHNwX2Rldl9jcmVhdGUoKSBmYWlscywgdGhpcyBmdW5jdGlv
biBub3cgcmV0dXJucyB3aXRob3V0DQo+IHNldHRpbmcNCj4gcHNwLT5wc3AsIGxlYXZpbmcgaXQg
YXMgTlVMTC4gSG93ZXZlciwgcHJpdi0+cHNwIHJlbWFpbnMgYWxsb2NhdGVkDQo+IGFuZA0KPiBu
b24tTlVMTC4NCj4gDQo+IERvZXMgdGhpcyBsZWF2ZSB0aGUgUlggZGF0YXBhdGggdnVsbmVyYWJs
ZSB0byBhIE5VTEwgcG9pbnRlcg0KPiBkZXJlZmVyZW5jZT8NCj4gDQo+IElmIHByaXYtPnBzcCBp
cyBub24tTlVMTCwgdGhlIE5JQyBSWCBpbml0aWFsaXphdGlvbiBwYXRoIGNhbiBzdGlsbA0KPiBj
YWxsDQo+IG1seDVfYWNjZWxfcHNwX2ZzX2luaXRfcnhfdGFibGVzKCksIHdoaWNoIGNyZWF0ZXMg
aGFyZHdhcmUgZmxvdw0KPiBzdGVlcmluZw0KPiBydWxlcyB0byBpbnRlcmNlcHQgVURQIHRyYWZm
aWMuDQo+IA0KPiBJZiBhIFVEUCBwYWNrZXQgdHJpZ2dlcnMgdGhlc2UgcnVsZXMsIHRoZSBoYXJk
d2FyZSBmbGFncyB0aGUgQ1FFIHdpdGgNCj4gTUxYNUVfUFNQX01BUktFUl9CSVQuIFRoZSBSWCBm
YXN0LXBhdGggc2VlcyB0aGUgbWFya2VyIGFuZCBpbnZva2VzDQo+IG1seDVlX3BzcF9vZmZsb2Fk
X2hhbmRsZV9yeF9za2IoKSwgd2hpY2ggZGVyZWZlcmVuY2VzIHRoZSBwb2ludGVyDQo+IHVuY29u
ZGl0aW9uYWxseToNCj4gDQo+IHUxNiBkZXZfaWQgPSBwcml2LT5wc3AtPnBzcC0+aWQ7DQo+IA0K
PiBTaW5jZSBwcml2LT5wc3AtPnBzcCBpcyBOVUxMLCB0aGlzIHdpbGwgY2F1c2UgYSBrZXJuZWwg
cGFuaWMuIFNob3VsZA0KPiBwcml2LT5wc3AgYmUgY2xlYW5lZCB1cCwgb3IgdGhlIGVycm9yIHBy
b3BhZ2F0ZWQsIHRvIHByZXZlbnQgZmxvdw0KPiBydWxlcw0KPiBmcm9tIGJlaW5nIGluc3RhbGxl
ZCB3aGVuIHJlZ2lzdHJhdGlvbiBmYWlscz8NCg0KRmlyc3QsIHRoaXMgaXMgcHJlZXhpc3Rpbmcu
IEJ1dCBtb3JlIGltcG9ydGFudGx5LCBpdCdzIGltcG9zc2libGUgdG8NCnRyaWdnZXI6DQotIHdp
dGggbm8gUFNQIGRldnMsIHRoZXJlIGNhbiBiZSBubyBQU1AgU0FzIGluc3RhbGxlZC4NCi0gd2l0
aCBubyBTQXMsIFBTUCBkZWNyeXB0aW9uIGNhbm5vdCBzdWNjZWVkLg0KLSBhbGwgdW5zdWNjZXNz
ZnVsbHkgZGVjcnlwdGVkIFBTUCBwYWNrZXRzIGFyZSBkcm9wcGVkIGJ5IHN0ZWVyaW5nLg0KLSB0
aGUgUlggaGFuZGxlciB3aWxsIG5vdCBzZWUgYW55IFBTUCBwYWNrZXRzIHdpdGggdGhlIG1hcmtl
ciBzZXQuDQoNClRoaXMgcGF0Y2ggZml4ZXMgdGhlIGNvbXBhcmF0aXZlbHkgd2F5IG1vcmUgbGlr
ZWx5IHNjZW5hcmlvIG9mDQpwc3BfZGV2X3JlZ2lzdGVyIGZhaWxpbmcgYW5kIHRoZW4gbWx4NWVf
cHNwX3VucmVnaXN0ZXIgcGFzc2luZyB0aGUNCmVycm9yIHBvaW50ZXIgdG8gcHNwX2Rldl91bnJl
Z2lzdGVyLCB3aGljaCB3aWxsIGRvIHVucGxlYXNhbnQgdGhpbmdzDQp3aXRoIGl0Lg0KDQpDb3Nt
aW4uDQoNCg==

