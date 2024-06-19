Return-Path: <linux-rdma+bounces-3345-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AB890F4B0
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 19:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE54AB218D4
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 17:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED98A155730;
	Wed, 19 Jun 2024 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Is7eBW1f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147581848;
	Wed, 19 Jun 2024 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718816642; cv=fail; b=KklsjIpxLIb3gMqHXds+/FqwDbfqV8C2N6WmXHdefszFIpov75tWvF/LhEjHJFDJsqMCIl5EFPOmM8/o+toQZi3OQ4ph5eozS3zmhB6jUkd8DnPkeiC0oqb/a+E+sOlOZjxqJh5D3C3JHxA5m4ylTmWIzEsXDjISQyiFtTn2P1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718816642; c=relaxed/simple;
	bh=LraWRy6XM5aWv8JjF1jwmf80Nc/X8Ksf1LpDobmTmnU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WjzwpjlEWOTw24lP2519JkCv3nLyztw2ox6faU095fFqhIdp/dC0kqGx8Y7poeE/mnL9TcKqoRtToOI4nIfPbJDp02NYeDG27m/PhAoQCRQOLPGzfdXowJlO+4xRpaavsLMqy5NcTQJQcmhNY0zh5q/EnLQKihc7Dbhb3rKzz2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Is7eBW1f; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSDpWPTsfGhIyKfjhhrKsTawDJaqGTa3OL3F3pqm7duH4Qf40Bs8Rwe+x+wpHNkQlDPOCWduiPeHdJyPu9Jgb1Y0o/7KJRZroDL9RtzDw/5i0GCxBU1xov0X2HN5X7cVGuTwPt9F6GcU7hGLVT55Ib0JCzAa2HqSNbFIDVfZN5P10ZFe9in9YIBNrqmn9k7S3Yze+Q/Q5flrmys4LZifcBHykE2TzZQOCMwfzhZbBp6ocnt6o0rGa92nHi4DFzlCGPT0tOD3G4GN7sKL86Q4RUJWHb2Zp4YWLiwwYdyZ+L0gFrS6vm9mI27btc9L7yucRozjh1z0eIS6wPteB0sa+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LraWRy6XM5aWv8JjF1jwmf80Nc/X8Ksf1LpDobmTmnU=;
 b=HkBNzbCjites3pTRkcBouasPcNAxerUHiyllADFRy8+l8pnberDKWBr84oKKp/pXPtwBKzwmv3qpov1K0MzlFYqUGkl9G5KSE7IoxHsAfXM+VkDwASVZUBRfPKoIgkOTLO9MD2Jg0iZ9VD+XWNlsAJ4gs7sgQdPzdjtXyXkOd0JvHrR2xdJlLFz6s7pMajJ5fN+BE8wn8Da4sSuP0PFYO2YGZsbBhhFwDwU94slxltfcpiUCz4MFyCGNrvW7JnRRbF0TY6/YmRhHkkHEN9OPS7N1mfEpGSoFxXL6iwcb/+SLDKMKkhLvFzHN6/BnnVEav+A2/jO2tgtI3iDaSB90UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LraWRy6XM5aWv8JjF1jwmf80Nc/X8Ksf1LpDobmTmnU=;
 b=Is7eBW1f92amdC2IVLNsz3DE+3el9EKvDXWRxF1u6qyTYhbRZC5ibqsYodzW0BWr1GzUxB2wc9nWTzABFsHtUyg+47flp5mGzETd9w372KNvlqZGMC5WAwnbIUPyTGHXxZriI7EjgoqXAlKvxKV2Qnl0nOXcrxyXAwDdfLLrkiml6CtZghxQNTP8Mthbapg4KYPhhvMO0rqIzOgHv5e7HsqIJQCH3zeF/ELfMM9H3L1IEHf260+3X3YtqptUJMjZiEhwMvQPnbhNPslQR9/KtW55HsSti7XLlu1aQV0+a95BE2u0dmHDrXunDRVP889hjQ+Up7NVjoUxaA27oOQDmg==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by SN7PR12MB7154.namprd12.prod.outlook.com (2603:10b6:806:2a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 17:03:56 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1%6]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 17:03:56 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "eperezma@redhat.com" <eperezma@redhat.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Tariq
 Toukan <tariqt@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
	"si-wei.liu@oracle.com" <si-wei.liu@oracle.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Saeed Mahameed
	<saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH vhost 08/23] vdpa/mlx5: Clear and reinitialize software VQ
 data on reset
Thread-Topic: [PATCH vhost 08/23] vdpa/mlx5: Clear and reinitialize software
 VQ data on reset
Thread-Index: AQHawMg9uIw/bQzER0mLDnFuEUZ3p7HO9fCAgABd1YA=
Date: Wed, 19 Jun 2024 17:03:56 +0000
Message-ID: <c72573d7e0c2165eaa92618a2c1c912d7c8117d6.camel@nvidia.com>
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
	 <20240617-stage-vdpa-vq-precreate-v1-8-8c0483f0ca2a@nvidia.com>
	 <CAJaqyWd5HRa2JVXVgPxYZn05drN8UyUHu=7jyxtON1d-XHneNg@mail.gmail.com>
In-Reply-To:
 <CAJaqyWd5HRa2JVXVgPxYZn05drN8UyUHu=7jyxtON1d-XHneNg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.2 (3.52.2-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|SN7PR12MB7154:EE_
x-ms-office365-filtering-correlation-id: 0d1c1a65-f8b0-457f-f87a-08dc9081ce0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|366013|7416011|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?M01rYXcxb3RTNDd3TXRCeE9EOGREbTZ1NGdTVTNZUW9JR0x5eTR1SUc0ajMw?=
 =?utf-8?B?U3lHeDdxNUhkY1BPTi9pQTRPUXZTK3VVYXl6M01HeXYySVlwTWU1eW9HcFBX?=
 =?utf-8?B?RDBiejhWc3NpMnd6TW9XdnpoeTVuU28wR1M2cjVwdFp4Z2Y3VjllK0t5QWEr?=
 =?utf-8?B?K1VKeitoYzFRWHJ5VSs1ZGs4UHY3bjl1akIrWWZRc2RWZ2wrWmV6WEluMGs4?=
 =?utf-8?B?S2crUHA3UE9BbVlEZllPK0p0SUtEbit0bzdNbmpIa0tYM3lma0FaM2dyUEZp?=
 =?utf-8?B?M1BaOUpLUHlvazMrQ0l2OGJIZDFGT3dRZWpXV1RTMzVJTldRL2RNWkh1c0VR?=
 =?utf-8?B?NlZqUmYzM21scUVTKzlUU0cvaVlGQlVQTlFhSktpQ2NFcXRvSDFxWXE2ajZF?=
 =?utf-8?B?ekpub095VDJod25GTW1abFozblNtUVlNbWVVZng3WGlPSU5DM3IwQkNpNnd6?=
 =?utf-8?B?YlQrWlQvTjhhQkdvbEVUOFJ6R0cvdVI3dG5vYXRHNHd0Tm5lMGwwdUpiRkg4?=
 =?utf-8?B?RmVJaG5QWUJjSlM2RjZvaU5qMStURWZTd0hNSWRwaU9mVjFCZTZqZXF0bmJp?=
 =?utf-8?B?aXloSS9UNmdHa0dLWjN5V0l2eEV6SWRkSmNXTmUzbWVLVDY3ZjdHbzAxL1lp?=
 =?utf-8?B?RGMvblk3cWlvNTRkSkIxRFJtMmxIR21UQ2ZNRjFnUFBzODRyMTYvYVYzNnI3?=
 =?utf-8?B?NWp6NGR2Sit3eEZ0NW45ZU1nN01jNXFsRVR1WTFJZnR4OTFoa3dVSHNlWURO?=
 =?utf-8?B?cUhROHpWV29DbGxqQnBGeVZ4RENRYmhZZE1PKzBCZGttc3NLemd6YVBvZHRm?=
 =?utf-8?B?ZzVEbnNkOUJ4L1lGZFdjSnJCN2MxK094c3RHNHR1Zk55bFpYc0dhYUxIanBj?=
 =?utf-8?B?bjA5Qm1IMkRZSVgvanptYnVnbFV4TXh1THJQMTg2anpmTFpVcWoyKzdremI0?=
 =?utf-8?B?V3JpSTR1cTBjYWl4WW4rZmdlb2lKYXpqTDlNazN5Mjgwb0JJdTJGQmVyQzJl?=
 =?utf-8?B?clVPUEZHY2wxakVmRnI1SUZoTHUyb29qazlUdnhHaUp4bGN2VU9vbGpxeGhN?=
 =?utf-8?B?OUlQRlVzUXRkbVdaQThVZzA2ZUR2dzRGUlpYclZUNGFITkdFY1ZtdG41TkpW?=
 =?utf-8?B?OHVZMkxhekYxK0FiVnZBWTdKUUN5M0pBcVJmRjBFKzJLSGtEYjlLYXNudGg3?=
 =?utf-8?B?QVlibkozK01oRHhrQ0VPUVcxLy83dE1IaVRuaThoUG14bEthTHVlc2l3R2pP?=
 =?utf-8?B?S2R0ZUZNWmp6WTdGNndlYUlLMEx1U01JSHNvaEF4TnYwSUw2NkZ5VCtSZzk2?=
 =?utf-8?B?QVRjcE40Q1lWLzhiOXR3MTUrQ3krakNva1REbXN0aDVtaDc4aWx2TjQ4aWxX?=
 =?utf-8?B?STBhWkN6ZGNTMHBPQzJFa201TG5iTlo2OVF4cVgrdW9WVnNvV2d5aER2Ym5R?=
 =?utf-8?B?NGZ3TExEdkZVS0V4SHRucjVMakZPNzh5c0RZRTV5QUNqWExiSjA4RXlMK2Nk?=
 =?utf-8?B?VXkxd01aQkwzK1hIa01JUk8vZVp2S3htZi9EbmF3STh2QzdrUEtXdXRCMlJR?=
 =?utf-8?B?KzYvbVY4aE1EbjRwK1JLSmtzSk5XT3pja2ZseHVrMWlUMm0xS3greXlObjBC?=
 =?utf-8?B?RGh5VzVOWklTTGVUUS9Taktvd2QvT01XaWs3MU5rQUNOclY1MklhZlJwYTV4?=
 =?utf-8?B?SDY2a1o3ZVk5SUk4bmt0eGZEMGlidjZLVzdBN2wvK0ZnNi9UOGFYN085N1l6?=
 =?utf-8?B?b2YvYXQzTTFJWTFjMGFhK2VldjIrZFhEdjYvUXZYRS9abFgweDduLzJSY0FN?=
 =?utf-8?Q?moDHG6cWJVrTXdSX5Bj3XRbBKt72ToCyPM0Jw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UStDUlJNSkhQUTQwUDdqdllJYm15UHJnVjBRU0JtWFMycmU4VGp2SVhqempp?=
 =?utf-8?B?RjJ0aUVxM09WNENQR1dCM0ZjRmtFR1Y3ZUdibWdtbDdzR2ZoRzBQdk4ycEhC?=
 =?utf-8?B?OWI0QXJGVjRaZ3B4ZDFod29hTThJdmlNcEV1cXZocm5BY21qUlJjcm9lSC80?=
 =?utf-8?B?TG5teGZwcHgxeDNHc01sMThRYmtjYllRdTBSSFVQeVNOaUtDT3ppOXlFbldp?=
 =?utf-8?B?SWhmemovb3Blc1BicGk1WmVVOW54L1FncEpLQVlEZzltWld5dmFyVE5SdUp4?=
 =?utf-8?B?UHNnVGlQdWVzbTh1eFpnLzBYQTEvaHNBby9ZSjZqeDJERzdBTm9qdXByRGxl?=
 =?utf-8?B?TmNJWW83K0diVXdxK3lkNmt1byswVkxBQ25IK21OY0Z4V3FTZEJiTFphazQy?=
 =?utf-8?B?RlJGaFpHcy9ObmhWNmo1b2lwNitFS0NqTnh2MkFVS2JpbWl0dHJWWTY5NVBK?=
 =?utf-8?B?cjFVZnluRzNEZzE5R3dWbXNpWHZjNERjRDVTSVFScUFLNmFTT0VRa2dpL1Ex?=
 =?utf-8?B?QVpQRVBza2xoZ3ppRHhQOWQ3ZkE2MUNwejRTNDlzTzUxejFxalcwd3pvVjBO?=
 =?utf-8?B?Tys0Qlo1Um4yS29iZUVQRGdYVmMxa1ZXTkJubVJDRW55ZjhGVklhSlVNUVQ4?=
 =?utf-8?B?Z0N3bVBubWdNZEU0am5rUVFEdVUwWkpISnJabVJ1dzZoVE03cmxoTi9OTVB4?=
 =?utf-8?B?d0tQTSszV1BXZ1Z0QVBmYXg1S3ZsTEVKbEZMdUNxVXRadEtYR3k3b29LRGpS?=
 =?utf-8?B?cVJzVC9URG84QkdiTThGT0FHVUtzeXlKQnZJSUdvNmJTS0l2TUJVTlZhS2R0?=
 =?utf-8?B?eWhsbkQyWVIySTVaWWpsR1QvbmI2ZXZKLzdST2R5b3U3ak4xdjJLZ0Ixckpp?=
 =?utf-8?B?R3RxMTRkazJ6aHBMblNPZWhERXpNQldiSHpsY0N5RFV3Q05zcGh4WElkYllW?=
 =?utf-8?B?TjU0dVZPZkVWb1JGUU1HbFBNQ2M3aWZLZkZVK1dGYUluMENIYkpoN0lPZ2pi?=
 =?utf-8?B?OWVKUjZuZ0ZzTVRCcmVzNU02cm55TjVNSXRoWmpqbm44d3djeG80SG92NndJ?=
 =?utf-8?B?cmhNckZtRmx3THhpN0Vxb0xGWmE3dy9Id1dQSi8vMmxtQVJlSDRIR0cyVFRp?=
 =?utf-8?B?MWZhY2JGUVJ6YUhvekVrUGpjbkNud0lBVURnMms5elc4V3NtcFJWSVh2YkQ4?=
 =?utf-8?B?Q0Y3K1EyN0ladGovaHJEL1J0VGtJc1JiWFZQTDdqNnp3M0svTDNyaWtseCtv?=
 =?utf-8?B?NmVvcVFBeWtVelJLUjdBNnNGRGRrWHo2WlFaNENqcG1kWUNNa1Z4QWpqRnBS?=
 =?utf-8?B?dXdSRXdtdUZURmppVXVLQ2NVS0kzcXRsbDVjVEZsNVdEOXZvNXhxNFlwRW5p?=
 =?utf-8?B?b0MzOVZ5a2FCa0o2eXh2Zlk5UUZsQmFaZHRBZ1k0QjZsN2toV2g5VHd6SFRH?=
 =?utf-8?B?cUt6RjRnamdQRmwwM1RtOXpGV3pSaWtvNC9PV3dIaXpKYkxpVXJLVngvRFNS?=
 =?utf-8?B?T05PUnB0SURxK2x4dG93VlVDZTg5OG14eURsdVZjQzlwV2RjVEgxdVR4dXBB?=
 =?utf-8?B?UVNiTjZWRklvMFdkaDlJTlZBS1d6aFJSTWxCVEltd3VDcVljRktzbDVJaDRX?=
 =?utf-8?B?Ukk0UGVRcEQvYUFiTTZkQ0xYTkhiaUhqSTJSazh0Zno5WFRHUHlWNFhaVVky?=
 =?utf-8?B?cHNXK2tkM010bmJVL1A3QmxsRCtMRlFkZ2oveUhaTmluMTBqSHVrcmpVTUhr?=
 =?utf-8?B?U3ltZGVkSVJmYVgyU0gyNDdpQXJwTXFqRzRrL3A4WWV6SEF2enJ3MkMvVGJs?=
 =?utf-8?B?RnZHZ0VWQmpEMHBPS2tYZFlzeVViUWg3WUY3STAxOTJuTVN4NmJrYWpyQkJ4?=
 =?utf-8?B?OWhDV0VGSkpocjJ3M2xDSzRicGMwVFNzZVAwWklyNjJZRXFUVXlsOXNKcUFh?=
 =?utf-8?B?bTFjc0V0WVloSnR5MVdPa0Z6alIydUFaQmQwTjkzYTN1Nm44L3Jka0RDUVkx?=
 =?utf-8?B?MzlKdUYvdVBrdEJtd2FWUC9BamNrdHQ4VlJFSmFqOUcvL2s0TnA1elJ1c3FQ?=
 =?utf-8?B?TjhsTVFNM2dkSUZJSStCalloZWtobDdtVmtpdTJTN2ZGaG9vNnhWQktRdlpI?=
 =?utf-8?B?WXRJa1ZLTEFzQ1k2bUFUeWZIVzc4eTJwOWRxT1NNWkVPQVJpUWJhZFdnNzNu?=
 =?utf-8?Q?U3e04n4cWcAHdtOgAnSBcMpdq1fklF/4JrLBlmOf99jm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <367D7816B31C7649B34BAADC4330DAF4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1c1a65-f8b0-457f-f87a-08dc9081ce0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 17:03:56.1373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N+ptga6pKD6h0Jues7/68yXqPbnjD38TvkHNZkxekRVuWZk6MmwvRJrXSTpzAp3hQsZ6KR83+V5NmtcstgCN8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7154

T24gV2VkLCAyMDI0LTA2LTE5IGF0IDEzOjI4ICswMjAwLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiB3
cm90ZToNCj4gT24gTW9uLCBKdW4gMTcsIDIwMjQgYXQgNTowOOKAr1BNIERyYWdvcyBUYXR1bGVh
IDxkdGF0dWxlYUBudmlkaWEuY29tPiB3cm90ZToNCj4gPiANCj4gPiBUaGUgaGFyZHdhcmUgVlEg
Y29uZmlndXJhdGlvbiBpcyBtaXJyb3JlZCBieSBkYXRhIGluIHN0cnVjdA0KPiA+IG1seDVfdmRw
YV92aXJ0cXVldWUgLiBJbnN0ZWFkIG9mIGNsZWFyaW5nIGp1c3QgYSBmZXcgZmllbGRzIGF0IHJl
c2V0LA0KPiA+IGZ1bGx5IGNsZWFyIHRoZSBzdHJ1Y3QgYW5kIGluaXRpYWxpemUgd2l0aCB0aGUg
YXBwcm9wcmlhdGUgZGVmYXVsdA0KPiA+IHZhbHVlcy4NCj4gPiANCj4gPiBBcyBjbGVhcl92cXNf
cmVhZHkoKSBpcyB1c2VkIG9ubHkgZHVyaW5nIHJlc2V0LCBnZXQgcmlkIG9mIGl0Lg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IERyYWdvcyBUYXR1bGVhIDxkdGF0dWxlYUBudmlkaWEuY29tPg0K
PiA+IFJldmlld2VkLWJ5OiBDb3NtaW4gUmF0aXUgPGNyYXRpdUBudmlkaWEuY29tPg0KPiANCj4g
QWNrZWQtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPg0KPiANCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgMTYgKysrLS0tLS0t
LS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlv
bnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVf
dm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jDQo+ID4gaW5kZXggYzhi
NWM4N2YwMDFkLi5kZTAxM2I1YTI4MTUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy92ZHBhL21s
eDUvbmV0L21seDVfdm5ldC5jDQo+ID4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVf
dm5ldC5jDQo+ID4gQEAgLTI5NDEsMTggKzI5NDEsNiBAQCBzdGF0aWMgdm9pZCB0ZWFyZG93bl92
cV9yZXNvdXJjZXMoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpDQo+ID4gICAgICAgICBuZGV2
LT5zZXR1cCA9IGZhbHNlOw0KPiA+ICB9DQo+ID4gDQo+ID4gLXN0YXRpYyB2b2lkIGNsZWFyX3Zx
c19yZWFkeShzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikNCj4gPiAtew0KPiA+IC0gICAgICAg
aW50IGk7DQo+ID4gLQ0KPiA+IC0gICAgICAgZm9yIChpID0gMDsgaSA8IG5kZXYtPm12ZGV2Lm1h
eF92cXM7IGkrKykgew0KPiA+IC0gICAgICAgICAgICAgICBuZGV2LT52cXNbaV0ucmVhZHkgPSBm
YWxzZTsNCj4gPiAtICAgICAgICAgICAgICAgbmRldi0+dnFzW2ldLm1vZGlmaWVkX2ZpZWxkcyA9
IDA7DQo+ID4gLSAgICAgICB9DQo+ID4gLQ0KPiA+IC0gICAgICAgbmRldi0+bXZkZXYuY3ZxLnJl
YWR5ID0gZmFsc2U7DQo+ID4gLX0NCj4gPiAtDQo+ID4gIHN0YXRpYyBpbnQgc2V0dXBfY3ZxX3Zy
aW5nKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldikNCj4gPiAgew0KPiA+ICAgICAgICAgc3Ry
dWN0IG1seDVfY29udHJvbF92cSAqY3ZxID0gJm12ZGV2LT5jdnE7DQo+ID4gQEAgLTMwMzUsMTIg
KzMwMjMsMTQgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfY29tcGF0X3Jlc2V0KHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRldiwgdTMyIGZsYWdzKQ0KPiA+ICAgICAgICAgZG93bl93cml0ZSgmbmRldi0+
cmVzbG9jayk7DQo+ID4gICAgICAgICB1bnJlZ2lzdGVyX2xpbmtfbm90aWZpZXIobmRldik7DQo+
ID4gICAgICAgICB0ZWFyZG93bl92cV9yZXNvdXJjZXMobmRldik7DQo+ID4gLSAgICAgICBjbGVh
cl92cXNfcmVhZHkobmRldik7DQo+ID4gKyAgICAgICBpbml0X212cXMobmRldik7DQo+IA0KPiBO
aXRwaWNrIC8gc3VnZ2VzdGlvbiBpZiB5b3UgaGF2ZSB0byBzZW5kIGEgdjIuIFRoZSBpbml0X212
cXMgZnVuY3Rpb24NCj4gbmFtZSBzb3VuZHMgbGlrZSBpdCBjYW4gYWxsb2NhdGUgc3R1ZmYgdGhh
dCBuZWVkcyB0byBiZSByZWxlYXNlZCB0bw0KPiBtZS4gQnV0IEknbSB2ZXJ5IGJhZCBhdCBuYW1p
bmcgOikuIE1heWJlIHNvbWV0aGluZyBsaWtlDQo+ICJtdnFzX3NldF9kZWZhdWx0cyIgb3Igc2lt
aWxhcj8NCk1ha2VzIHNlbnNlLiBJIHRoaW5rIEkgd2lsbCBjYWxsIGl0IG12cXNfcmVzZXQgLyBy
ZXNldF9tdnFzIHRvIGtlZXAgdGhpbmdzDQpjb25zaXN0ZW50Lg0KDQpUaGFua3MsDQpEcmFnb3MN
Cj4gDQo+ID4gKw0KPiA+ICAgICAgICAgaWYgKGZsYWdzICYgVkRQQV9SRVNFVF9GX0NMRUFOX01B
UCkNCj4gPiAgICAgICAgICAgICAgICAgbWx4NV92ZHBhX2Rlc3Ryb3lfbXJfcmVzb3VyY2VzKCZu
ZGV2LT5tdmRldik7DQo+ID4gICAgICAgICBuZGV2LT5tdmRldi5zdGF0dXMgPSAwOw0KPiA+ICAg
ICAgICAgbmRldi0+bXZkZXYuc3VzcGVuZGVkID0gZmFsc2U7DQo+ID4gICAgICAgICBuZGV2LT5j
dXJfbnVtX3ZxcyA9IE1MWDVWX0RFRkFVTFRfVlFfQ09VTlQ7DQo+ID4gKyAgICAgICBuZGV2LT5t
dmRldi5jdnEucmVhZHkgPSBmYWxzZTsNCj4gPiAgICAgICAgIG5kZXYtPm12ZGV2LmN2cS5yZWNl
aXZlZF9kZXNjID0gMDsNCj4gPiAgICAgICAgIG5kZXYtPm12ZGV2LmN2cS5jb21wbGV0ZWRfZGVz
YyA9IDA7DQo+ID4gICAgICAgICBtZW1zZXQobmRldi0+ZXZlbnRfY2JzLCAwLCBzaXplb2YoKm5k
ZXYtPmV2ZW50X2NicykgKiAobXZkZXYtPm1heF92cXMgKyAxKSk7DQo+ID4gDQo+ID4gLS0NCj4g
PiAyLjQ1LjENCj4gPiANCj4gDQoNCg==

