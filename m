Return-Path: <linux-rdma+bounces-19472-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIK5Ovzm6GkHRQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19472-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 17:19:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E031D447CD1
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 17:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A85B30D427E
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 15:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1196B311C1D;
	Wed, 22 Apr 2026 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EhormWBC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011056.outbound.protection.outlook.com [40.93.194.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AA4219A8A;
	Wed, 22 Apr 2026 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776870796; cv=fail; b=jN4GxDL4QvfvZK0W1KChu6aJmhE9UiHu7xrnyE7PZFiAh4+EoH/HCX7oPudeK7SJM/vtGbFud6iseVnrKBuuLu7dyY5J86nK5595H/QK6M70c5mH7lTcBVH+z1BMJd9R7yDwsCuzTp5v1VUOsLTpyxHxJn1Mtj5zg0Dq1qkKsYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776870796; c=relaxed/simple;
	bh=MVjBFHhs0twBfrEbCBotL4rStBQdf6h5/MejnsqcTCE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gn7mF6eoSjGNegrBUPx88o53yEH16GceUVvLfIuKg9YtxP4mKz1lNIh2BRQuQOyga3bAEjMndfGPstbZxRFfl2EpuHbWUCRlMv1vcTht2fELRTW2mpjaWoI+ePefFoR6uXna/1565ZXnOO4ueTncNak8Gl4AtcevkKiHtzuVNJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EhormWBC; arc=fail smtp.client-ip=40.93.194.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsij24PXzBmTftLR4+9kiXC0GI5FcN6ZZQNpkjnGi9QwGimnRhjawbCP+VqdZMp0qeIlPxK8Qm7Gp5TZST44rTfPJZzJFkmuX2lP6onRvrZlHWk/57otdzIl4x0n2boftCoPksEnCdvcNnAUSGMhlhq018pthgYp52o0aAZaxGbrhWl5FKoNBD9nGqx8jFkicBGtdkHo8wYVtpfOOSNA1F7TF/Kvqq92P+lL+qWdc6utQnj28YOe6hznRgq8zkjCPRZp1TGym/LpU18xI39Y4aScfxDUKA40RXMz+S05g6OrG1oY599/7afiDTkC7ggJ/84EI9/n1qetEELMZQk5cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVjBFHhs0twBfrEbCBotL4rStBQdf6h5/MejnsqcTCE=;
 b=sW7Qf6y/Cz6kOyPdvyEwGegkAVcP1M5KIPMj0lM2YVjlTGG95nMj0ttQ+IPe2Jb5ZSasYyMSLRsu+GZ5sbXwMdS/zW5spoL1b8kX0gbPo1U5ktg/nt/xcxZsIT97iMT8qXH1ojZgDCvvhalsxePcdyGmexwsIo9/yecCHXiouJqIXHmPB6HEH3t/WToItVRTVsgQC0yiogUU6WdFHOosLei7T+gbyBtXr4+YQXx/03OKDr82F1ZmuVNai7WJ+SgirUCIu92zxg8WtshVH9cHCWs1Ta9YLuZDKSXQlaoXPoPNVoYWK96nSEcJ2ml/PrtUvWsJ/Q2cloZ2nyHAyG2+jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVjBFHhs0twBfrEbCBotL4rStBQdf6h5/MejnsqcTCE=;
 b=EhormWBC8Pbnvfyj3tvOj2mXOzzw1gU6HXmx0nBbnqv0ga7IsUggvffdrRrPw3ZLBVf+7ohjVX5eLKNfAKDCh49Lb4GFpwSfxj0jvoixUjjeRzW+2uv3Ly8nhfoD0D6SklI81KcJNNc4JYwVgn3eTnEcJaHvod04sZfzpMHR3t922CXJN8o2hfZHs7dmHmqTm1cxGQQUzNbFhLNp77xMV5fauoeGu1dyfRQadwA6PG/cSVqgqluQHqqK+EHVvRBaTZCYWspPCEbubru1FhhAzsaUBfFZiaJ0OCX6B4twh4gsNdPjx1tqR/VRNvF25u1sRhBF4Lz4SQWnoTWsqgtLIw==
Received: from CH1PPF189669351.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::608) by SA0PR12MB4367.namprd12.prod.outlook.com
 (2603:10b6:806:94::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 15:13:11 +0000
Received: from CH1PPF189669351.namprd12.prod.outlook.com
 ([fe80::61d1:eea7:9eaf:f448]) by CH1PPF189669351.namprd12.prod.outlook.com
 ([fe80::61d1:eea7:9eaf:f448%8]) with mapi id 15.20.9846.007; Wed, 22 Apr 2026
 15:13:07 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: Boris Pismenny <borisp@nvidia.com>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "leon@kernel.org"
	<leon@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Raed Salem <raeds@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, "kees@kernel.org" <kees@kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Tariq Toukan
	<tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: Re: [PATCH net 1/2] net/mlx5e: psp: Fix invalid access on PSP dev
 registration fail
Thread-Topic: [PATCH net 1/2] net/mlx5e: psp: Fix invalid access on PSP dev
 registration fail
Thread-Index:
 AQHczieNmLFIHpbrDUuqFWyBz+NLKrXlMUIAgAKT6wCAAG9bgIABRBKAgAAgroCAAAIjAIAAChOAgAAoZoCAABAhAIAA+YAAgABhMIA=
Date: Wed, 22 Apr 2026 15:13:04 +0000
Message-ID: <5167f0714e3ddf750f80740bf2ab18a7bb567b16.camel@nvidia.com>
References: <20260417050201.192070-2-tariqt@nvidia.com>
	 <20260418190848.204170-1-kuba@kernel.org>
	 <d7e2d46769e120a16ce12d345c51a47349733828.camel@nvidia.com>
	 <20260420100917.1e4be22a@kernel.org>
	 <f327ce67e69c27ed971f4ed38f46381cd2f97ec7.camel@nvidia.com>
	 <20260421072609.4b15e7b9@kernel.org>
	 <3ca1bee450608d37cd0f9199ebc44c52c084cb08.camel@nvidia.com>
	 <20260421080951.570e6e49@kernel.org>
	 <6d96452f67d5b58578f67f97f750101abd4af9f6.camel@nvidia.com>
	 <20260421113210.4f6a8eb6@kernel.org>
	 <e9d10b11f73c0ff212a5dee0b08d9ca90eca5407.camel@nvidia.com>
In-Reply-To: <e9d10b11f73c0ff212a5dee0b08d9ca90eca5407.camel@nvidia.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH1PPF189669351:EE_|SA0PR12MB4367:EE_
x-ms-office365-filtering-correlation-id: d23ae57d-0078-4821-da66-08dea081a75d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 2gJGtT7iTIsFsXGxk5xdmDYReCg4HOaP3TpNw2jn+uOjTL20LQUEJGQzSZ+x6Fzr1BBW/tIqBn52K7kFSvfj4w2/Yo2RHcsT3HSmcDHKjJE62R723EdHV8ebEATHIeFdLqaaEdwgLEHlulgnBg1+vKTVsxnudGhJfPn0EAG4j5cOYD+ujeHppstpMdg0AnvlMzVY+AFn0PcJJ8jz9pe3xMldQqowdw49raKZibarXudPqIrn8IJ7YSKwWV1wtKBkREpuj/CkGkz30g8b4l6oGAoGpADa1IkBKQCVwErllDS3DJ36LprHCAL3zS+q5Q6PdKZytBjBKdWJ8oZ0rS5d16Mu2Rz9qZYaMZVWEy70JHyjTvk59ttuwGBqoSwauKHhHSPO7aUNBqy3m3Ysqbf22C2bN5FMnmEa0bNNz3PON7I091ek413/rVp75nchMeP+imQLt8XsnIK+ZI7tqRSPFn/U5bMWl/V6gBC+qortZoPt0sNH9KRUDw0xLSh0SmPYTl+yOcxToQRAeOIlx2EtTBqB5Cn2yoEwBtzNQ8PMm/e+1S2BHMPgYievlHBk0NBRhhJPjKWDcewLUu8TDZVcqSf+6++wN8/LCVy8Q3h9qKZtXAVX5/xIin/hsIN+8KC+1e+PORV26LGHEAqjHu8xzqd5Z59JloCTnJUYQJ7gS7x49cbXllo08oDHNWrKjikWPC47zo1dz0uru9JQfASTiQ9x8YG71pdYu8nO6ZT5PZbjnHE1hR/Ej7JyvMvlFNz314qsMT+HrIX+7/YrLL/y8lFsqjvXafbE57w1dxk4j9I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPF189669351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3V1R3NCSWkxZ2FCSm4vdXV5Y2VSeE1LaTVQaGxRd2ljVzlmbzkrU2hWMHA5?=
 =?utf-8?B?eWttNExBMUZiTFYrTUNoS25DL3FpY2pXZVBHY0UrbHZlc0RKV1JtOVZLSkRq?=
 =?utf-8?B?S2k5M3lmeDVFNzM2N2tzRmVUTFNnTzFoQS9DL2E1ZDl5bUk1cFNuUnJQd1dD?=
 =?utf-8?B?Ui9OY29CV0RWZkNGaURyQWl0VEVhRmZlOUN3WVNtN2QrWFd0YkZnTlY0OTQr?=
 =?utf-8?B?a3JXb2x6Q01XQUhneEE3QWNFcEs1dndRNzd3NzZvZURxaTk4SURrOEtZUFVX?=
 =?utf-8?B?U1RLZE1yY3MzOVJHQjlPM1huQnVSNzhUTkdCQUJLZmhqSkZNcm9qMVlhVTNq?=
 =?utf-8?B?bFVuNTdtOWlZcmRqclMxN0x5VUlhdFhNUzM2b2ZrOVVEd0ZTZWtUNTFHWGNT?=
 =?utf-8?B?Y3owTUdac25XM3BiM1BuTHdYNEJuUXNoaEtrZXVSZTNxVi9uM1hvK3BSdnVl?=
 =?utf-8?B?TldPLzFGbTJUQ2RoMlQydVVSMFNiczNYaHpjaTM4L0FuYU91S25KUzlGQXpE?=
 =?utf-8?B?Q3pzbDhjM3VSc3h0MVNtSkFOT2xUak5MaHBraDVTWjdUbzVWVmxqQjU0aFhG?=
 =?utf-8?B?bGt1T1cyMnRmYkZWOFUxVUVwdXJNWXNMWHU5bzF1OFJvWHVMMUJCYUJsdFc2?=
 =?utf-8?B?a0h0TGJhb2E0M1hQQlhpa2hZbkRKYUduN3ZNZThSWUtkdmZxOTJIN0xJd1p6?=
 =?utf-8?B?M2tVMVcxYmx4TXlJOEFudzF4d2dDMlU3aHJvck1QUU5oTUlucEthWkxKY285?=
 =?utf-8?B?ZytWOGFOd29sOVhpZytOVVNVT1NrVi93SFZkbHo5eHJqV05Zd09LK2VPTEsw?=
 =?utf-8?B?UmxKUi9HRVpYTjBmdGI3WTJnSVVuT2p5TWE2ZHE1eGFOQ2NaMEZRT0UzbWFy?=
 =?utf-8?B?ZHdaK21wM08rRHhSSGVGeXFSVm13T2c5NnJmUUVnSWlidHRqenBBTFNyM2xi?=
 =?utf-8?B?V3VUU2VhWC9OK2VkYUtYdWsxMzVhd1VQN3NVY2ZMbkVzQUNhVUVTK3NzWGo3?=
 =?utf-8?B?S0pBZHQ5OWJzV1BwSHBaWTZTbE9NajZCMlB3VnVPTG55ZnRDVkxmQVRCQVlo?=
 =?utf-8?B?WWdIRnBWUjNRYXA4UDRWczZYeXM0bXBOMzhYTGtUbEliNENPRnFCQ0J6cGtT?=
 =?utf-8?B?SE1oaXphVVUxZFFDbUR5ZXdnNzhxdXdHRGZWUEtqNTlhaVN5aTM4eGlJVmhn?=
 =?utf-8?B?K1RkdjJ6UFJjNThyMkxVeFl0UVdLRTd5alk0UFJUeXV0RENZVTRmY3JBbVFP?=
 =?utf-8?B?TDB3Mi9DV0x4YXFvelJ2OGRLOUlEekRWQ2NlSFVMbkVFdFNvWnFvRVhOM1Yz?=
 =?utf-8?B?eXZDV2N3N3doOWdocEo3ckNTK05VZFFIMmdIaXd3NmV0NVkrYjBBTTBIdkNk?=
 =?utf-8?B?SDBYdmxFNWMwajl3Rm9hTW1DcG9VRllrNmZKNFVFT1VvSjBEY2xzK0dhQTZn?=
 =?utf-8?B?dHpiV1RKelpwK1BmWTE4RnlpamVDMyt0MW9aYUZiZWJQck93Q0VoMllHYUZm?=
 =?utf-8?B?bDYxTkFUWmRxYXhCdDNBVWR5R29qUEhYakcxWUw5RWR0UE9DeTV0dWt1Tkdt?=
 =?utf-8?B?a0s5NStjQ2MwSndFajNiUlNwa3lhc1M1YnVjS3h6YkxTeGw3elB0NmdjU3Fr?=
 =?utf-8?B?V3dwM1FieXgyWTRiY0tQYnMwU2lQZ2V1ejF3VHE5cDhqMG9VeXFVc3haZ3Ax?=
 =?utf-8?B?eWtucHlPamZvNHBoQk9kbVdBQU9LNDJZOTFvcnVqdmthZjRCZ3g2Qmo0Rnd6?=
 =?utf-8?B?c3Y3VG0wMWs0QzdOK28rV1NNbTRMdUpzeTFYVFgzTXZLK290WGV1Mm16eDlu?=
 =?utf-8?B?QnBvWTIyYjRpdUVpeWVESXV4K0ltdmZLNnNnOEpIbnByTTREbmVJeVZaZnM0?=
 =?utf-8?B?bUt1MTYvNllwYWVDRHQrVU1xMDhmU2FUZHlKbTJxYWM4OVkwWHBYZXprY1ln?=
 =?utf-8?B?cURDV2lLN1JRZmptZGFwZkhpVjlBMGZJU3BHSHVnZTM5Y2VBUm4wdmdNUlo1?=
 =?utf-8?B?a0JwUklIZExkZUt3VmhlMDdJRzdHVlhUbjNYSHVXSEJsZ3VwdGlDRmNDYUpS?=
 =?utf-8?B?UUpBTTJtbzJITThCamUrMnRaUVQwWFlzeXJxWjcveGo2Qktabi9DZTdDMkFH?=
 =?utf-8?B?bTd4dlIzUWpGbGlubGJ2eW45UFF6N3BodnI1K1RGOUhCREhvNGd1aXFLbVZp?=
 =?utf-8?B?UEFXWHhHN1orUGVmdEhKcVMxSlNXZ0ViakdaN2JYS0FaSzloejBvRjIyajNO?=
 =?utf-8?B?YmQrNk1pdExyYTVIeFBDV05scSsxbmIvWGhKZTVzeUtYeStqTXI5b2lVY3pL?=
 =?utf-8?B?NVhiNm5UckNKMlFhc1F4Q1RpRTArMldDckwwd2hRVEQvRnM0Q3Jwdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DF25246CBBFCE4E89D3C4912D17B4CF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH1PPF189669351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23ae57d-0078-4821-da66-08dea081a75d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 15:13:05.2087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WetLCFqqoLZrsvNMCaUiNy9s6FotmfK5Kcmo6GuWydceO90tw2mD1JasxxtAo2SF6bi7rbDBje+LpnW3BlM1IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,lunn.ch,davemloft.net,kernel.org,vger.kernel.org,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-19472-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: E031D447CD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gV2VkLCAyMDI2LTA0LTIyIGF0IDA5OjI1ICswMDAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+
IE9uIFR1ZSwgMjAyNi0wNC0yMSBhdCAxMTozMiAtMDcwMCwgSmFrdWIgS2ljaW5za2kgd3JvdGU6
DQo+ID4gT24gVHVlLCAyMSBBcHIgMjAyNiAxNzozNDozMiArMDAwMCBDb3NtaW4gUmF0aXUgd3Jv
dGU6DQo+ID4gPiA+IE5vLCB0aGUgbm9ybWFsIHRoaW5nIHRvIGRvIGlzIHRvIHByb3BhZ2F0ZSBl
cnJvcnMuDQo+ID4gPiA+IElmIHlvdSB3YW50IHRvIGRpdmVyZ2UgZnJvbSB0aGF0IF95b3VfIHNo
b3VsZCBoYXZlIGEgcmVhc29uLA0KPiA+ID4gPiBhIGJldHRlciByZWFzb24gdGhhbiBhIHZhZ3Vl
ICJrZXJuZWwgY2FuIGZhaWwiLg0KPiA+ID4gPiBJJ2QgcHJlZmVyIGZvciB0aGUgZHJpdmVyIHRv
IGZhaWwgaW4gYW4gb2J2aW91cyB3YXkuDQo+ID4gPiA+IFdoaWNoIHdpbGwgYmUgaW1tZWRpYXRl
bHkgc3BvdHRlZCBieSB0aGUgb3BlcmF0b3IsIG5vdCAyIHdlZWtzDQo+ID4gPiA+IGxhdGVyIHdo
ZW4gMTAlIG9mIHRoZSBmbGVldCBpcyB1cGdyYWRlZCBhbHJlYWR5Lg0KPiA+ID4gPiBUaGUgb25s
eSBleGNlcHRpb24gSSdkIG1ha2UgaXMgdG8ga2VlcCBkZXZsaW5rIHJlZ2lzdGVyZWQgaW4NCj4g
PiA+ID4gY2FzZSB0aGUgZml4IGlzIHRvIGZsYXNoIGEgZGlmZmVyZW50IEZXLsKgIA0KPiA+ID4g
DQo+ID4gPiBJbiB0aGlzIGNhc2UsIFBTUCBub3Qgd29ya2luZyB3b3VsZCBiZSBzcG90dGVkIG9u
IHRoZSBuZXh0IFBTUA0KPiA+ID4gZGV2LQ0KPiA+ID4gZ2V0DQo+ID4gPiBvcCB3aGljaCBwcm9k
dWNlcyB6aWxjaCBpbnN0ZWFkIG9mIHdvcmtpbmcgZGV2aWNlcy4NCj4gPiANCj4gPiBXaGVuIHlv
dSBoYXZlIFggdmVuZG9ycyB0aW1lcyBZIGRldmljZSBnZW5lcmF0aW9ucyB0aW1lcyBaIEZXDQo+
ID4gdmVyc2lvbnMNCj4gPiBpbiB5b3VyIGZsZWV0IGRldi1nZXQgcmV0dXJuaW5nIG5vdGhpbmcg
aXMgbm90IGEgZmFpbHVyZS4gSXQganVzdA0KPiA+IG1lYW5zDQo+ID4geW91J3JlIHJ1bm5pbmcg
b24gYSBtYWNoaW5lIHRoYXQncyBub3QgY2FwYWJsZS4gQmVzdCB5b3UgY2FuIGRvIHRvDQo+ID4g
c3BvdCBhIGJ1Z2d5IGtlcm5lbCBpcyB0byBub3RpY2UgdGhhdCB0aGUgZnJhY3Rpb24gb2YgUFNQ
IHRyYWZmaWMNCj4gPiBpcw0KPiA+IGRlY3JlYXNpbmcgb3ZlciB0aW1lLiBBZnRlciBzaWduaWZp
Y2FudCBwb3J0aW9uIG9mIHRoZSBmbGVldCBpcw0KPiA+IGFscmVhZHkNCj4gPiBvbiB0aGUgYmFk
IGtlcm5lbC4NCj4gPiANCj4gPiA+IEJ1dCBJIHVuZGVyc3RhbmQgd2hhdCB5b3Ugd2FudC4gWW91
J2QgbGlrZSB0aGUgbmV0ZGV2aWNlIHRvDQo+ID4gPiBlaXRoZXINCj4gPiA+IGJlDQo+ID4gPiBm
dWxseSBpbml0aWFsaXplZCB3aXRoIGFsbCBzdXBwb3J0ZWQrY29uZmlndXJlZCBwcm90b2NvbHMg
b3IgZmFpbA0KPiA+ID4gdGhlDQo+ID4gPiBvcGVuIG9wZXJhdGlvbi4gTm8gaW50ZXJtZWRpYXRl
L3BhcnRpYWwgc3RhdGVzLiBUaGlzIGlzIGEgbm9uLQ0KPiA+ID4gdHJpdmlhbA0KPiA+ID4gcmVm
YWN0b3IgZm9yIG1seDUsIGJlY2F1c2UgbWx4NV9uaWNfZW5hYmxlKCkgcmV0dXJucyBub3RoaW5n
Lg0KPiA+ID4gUmVmYWN0b3Jpbmcgc2VlbXMgcG9zc2libGUgdGhvdWdoLCBpdHMgb25seSBjYWxs
ZXIgaXMNCj4gPiA+IG1seDVlX2F0dGFjaF9uZXRkZXYoKSwgd2hpY2ggcmV0dXJucyBlcnJvcnMu
IEl0J3MgY2VydGFpbmx5IG5vdA0KPiA+ID4gc29tZXRoaW5nIHRoYXQgc2hvdWxkIGJlIGRvbmUg
Zm9yIGEgbmV0IGZpeCB0aG91Z2guDQo+ID4gPiANCj4gPiA+IEkgaGF2ZSBhIHNlcmllcyBwZW5k
aW5nIGZvciBuZXQtbmV4dCB3aGVyZSB0aGUgUFNQIGNvbmZpZ3VyYXRpb24NCj4gPiA+IGlzDQo+
ID4gPiBob29rZWQgdG8gbWx4NWVfcHNwX3NldF9jb25maWcoKS4gSSB3aWxsIGxvb2sgaW50byBp
bXBsZW1lbnRpbmcNCj4gPiA+IHdoYXQNCj4gPiA+IHlvdSBwcm9wb3NlIHRoZXJlIGFuZCBwcm9w
YWdhdGUgZXJyb3JzLg0KPiA+ID4gDQo+ID4gPiBNZWFud2hpbGUsIGRvIHlvdSB3YW50IHRvIHRh
a2UgdGhlc2UgZml4ZXMgKDEgYW5kIDIpIG9yIG1heWJlDQo+ID4gPiBqdXN0DQo+ID4gPiAyDQo+
ID4gPiBmb3IgbmV0IG9yIG5vdD8NCj4gPiANCj4gPiBDYW4geW91IGNhbGwgbWx4NWVfcHNwX2Ns
ZWFudXAoKSB3aGVuIHJlZ2lzdGVyIGZhaWxzIGZvciBub3c/DQo+IA0KPiBEb25lIGZvciB0aGUg
bmV4dCB2ZXJzaW9uLCBjdXJyZW50bHkgdW5kZXJnb2luZyB0ZXN0aW5nLg0KDQpUaGVyZSdzIGEg
c25hZzogcHJpdi0+cHNwIG1heSBiZSBhY2Nlc3NlZCBjb25jdXJyZW50bHkgZnJvbQ0KbWx4NWVf
Z2V0X3N0YXRzKCkgLT4gbWx4NWVfZm9sZF9zd19zdGF0czY0KCkgc28gd2UnZCBuZWVkIHRvIHBs
YXkNCnRyaWNrcyB3aXRoIFJDVSBhbmQgdGhhdCBnb2VzIGJleW9uZCB3aGF0IGEgbmV0IGZpeCBz
aG91bGQgYmU6IEl0J3MgYQ0KcmVkZXNpZ24gb2YgaG93IHByaXYtPnBzcCBpcyBoYW5kbGVkIGlu
IHRoZSBkcml2ZXIuIFRoZXJlJ3MgYSByaXNrIHdlDQphcmUgbWlzc2luZyB0aGluZ3MsIG9yIGl0
IGJlY29tZXMgbW9yZSBpbnRydXNpdmUgdGhhdCB3aGF0IGEgZml4IHNob3VsZA0KYmUuDQoNCkkg
d291bGQgbGlrZSB0byBhc2sgeW91OiBsZXQncyBwbGVhc2Ugbm90IGRvIHRoaXMgcmVkZXNpZ24g
b2YgcHJpdi0+cHNwDQppbiBhIHJ1c2gsIGFuZCBsZWF2ZSBpdCBmb3IgdGhlIG5ldC1uZXh0IHNl
cmllcyBJIG1lbnRpb25lZC4uLg0KDQpUbyByZWl0ZXJhdGUsIHdvdWxkIHlvdSBsaWtlIHRvIHRh
a2UgcGF0Y2ggMj8NCg0KQ29zbWluLg0K

