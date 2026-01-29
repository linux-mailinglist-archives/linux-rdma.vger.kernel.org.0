Return-Path: <linux-rdma+bounces-16193-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGrbAiE4e2mGCQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16193-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 11:36:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7ECAEDC2
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 11:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70D58304D140
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 10:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33D93815E2;
	Thu, 29 Jan 2026 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="krdYaFJT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5FC3815D3;
	Thu, 29 Jan 2026 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682827; cv=fail; b=I9Ae8JBnNhjVVXmHOsFKh1n8T7CVQT7MGr4y94ozHu8ELFrJ3e0IctWyrTfJrf8YTHEoGjlphsJCjSFT11h4nT2kEMmOyM1kSPyi0cqTp7PMLn6xktjlP9hBPuZH5ZGxnAXtIQZPq1U+sqEpNK6H2MXRWMMhDlb8YW7mddeFogQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682827; c=relaxed/simple;
	bh=8girCvT3HqWG6QNCUreF4lQ/rpu+RhCWsROHs5j8Lbc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I0KXhyjHstq+iUQbdcEVJUO2h11NJxnU4GeS2ettBZU68CaYy07C9bODzWWfq1P8jAhfsdmXCsPOc6f3060hRBKkOHyUA0KucLngy947Xv1nvtfIGm2GdaNAlF1hWcmyOhjOfqgk1Nu2YCDP+3sHyGakmzaey+9T41aIkw5RNvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=krdYaFJT; arc=fail smtp.client-ip=52.101.85.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFBh/O+LIfKUqrgvDvH1E+HZgwlyq1JJ9ehtAiDn1ATdX3nbYvUnwlo47U+JTo6DfoaAXdRo4hmGkknYt/nqjx0J9AT3LAbLm4sfnq5iFnAkA3YC/I2Zagxz1qplBMV5yAuUZe6X7SGefOFOlSDvd8oxgxMkOAd4/ED0cahxFGzonFrn2CIxu/gkOZPuO4vav0t7brvgLHsu4jRmaK16uG5Bxly7HeSxDW/Z+ui22Ylt0JMIpjVbFJ78UMNu9i8agTltoMdYM0BDBzmCVwsj0tbKBM/a9h/keTv0e0qRfF3KMrB81e46UKtD/xRYUcaBXf/Yqrf+hHDHfswy6S6+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8girCvT3HqWG6QNCUreF4lQ/rpu+RhCWsROHs5j8Lbc=;
 b=scKbBDjvuuB2vJSERAguuNxP8XScOdseaKA+k+3j4RpxCPqRLuhaE57X36kzX49jQsVhZdTbvu7fwuQ9TM6TDum/I3hINc5+eVywFUFJ7i+3/yehurjgJvptDXShSRY8fzEbIes+0THytSRjttklLjj5fMkNsMCrIILxaeJAw++aD06JT3q7NYneP1docE7H4dxz8rY0sOFDKHZWr0WAcMG4As19ngYTZRHAvmHwn14kZWUDGSlZ6aLWI1sa9/soMAZIyklzPM3lB5xkuLyKuKEut9QZEPS7GvFuzTbr2awvJ+d7m8y73eywgHSvYc4BFqEbymwJg1jICzJgfXevOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8girCvT3HqWG6QNCUreF4lQ/rpu+RhCWsROHs5j8Lbc=;
 b=krdYaFJTllPXaqkFS6JTbMoSdcWJxz1yvIHXp1B+RH3ORxnoUIOCS7VeMMl6k01DJRWf2US8cXuVoOJsuDJhuLCWdj0s9uItp3+/mxiH2oKo6FdCz02oWeExLu5oD5quaYhcAaIXQ3/MUyk+tZs1hNEk2wy0LONQf5h8O0wq5h6hv38VSToFwfHwpLFCuv0L74MwoCO1vSqcqMr1tsY7f+P9mUO/CUirVkqSyNg7NGiCe8RjaeWn4Vi410mwWiuf8lm8yReB1qjfz7vUiaj36n76H5aOWnpfZzg40oZiRkfL8Js5laFFzzADVM+6sqze1xjK9AdUXf671njuZTX0mA==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by SA0PR12MB7001.namprd12.prod.outlook.com
 (2603:10b6:806:2c0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Thu, 29 Jan
 2026 10:33:41 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83%6]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 10:33:41 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, Gal Pressman <gal@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>, Saeed
 Mahameed <saeedm@nvidia.com>, "horms@kernel.org" <horms@kernel.org>,
	"leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH net V2 2/4] net/mlx5: Fix deadlock between devlink lock
 and esw->wq
Thread-Topic: [PATCH net V2 2/4] net/mlx5: Fix deadlock between devlink lock
 and esw->wq
Thread-Index: AQHcj2p4+z8li4woFESbbGRh3+CRZrVomGQAgABePAA=
Date: Thu, 29 Jan 2026 10:33:40 +0000
Message-ID: <d52714243592921c08175aa742f32ae56e4f6651.camel@nvidia.com>
References: <1769503961-124173-1-git-send-email-tariqt@nvidia.com>
	 <1769503961-124173-3-git-send-email-tariqt@nvidia.com>
	 <20260128205622.12e1f026@kernel.org>
In-Reply-To: <20260128205622.12e1f026@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|SA0PR12MB7001:EE_
x-ms-office365-filtering-correlation-id: 5dfa0848-ec14-4ccd-3b03-08de5f21ded8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QTNYM01SdHhEa3JpekR6NjlwVVRJN0c0NGNRbm9sUlRZc1puUjdSamlrQ3hF?=
 =?utf-8?B?cWZWNEtmK2lhcUVITS9GVUFFSDE3VUE3STR5ODZ4UU12TUlkYVFDUlMrM3J1?=
 =?utf-8?B?TzBpTjltbWdmSkU0SmJ1bldwUFllSnEwbUFTQW1CazFLbGtqNUY0S3dXemFF?=
 =?utf-8?B?clE5UUhOK25qWEVQNk5oaEVGcHNERU05dm5qOG4rVUhCOXhhWVBJUDcreEtU?=
 =?utf-8?B?VjZTUlUybUlVbk1WcFdzTXRNT1Yrbm5xSEZ4SlczZDFNdjZLZ0R3MTJsYjFL?=
 =?utf-8?B?VW5WZTZ5YUhRSC9qQk1vTzkrbkJFQ2VXTE9UTExjcnVnUzcveTU5Q0MrU0Zu?=
 =?utf-8?B?bFBwYmJiNUxlODIwenZlTElnWkNaWUhtaC9ic3pRcHRPd1hqUGQ5dTJnTTdU?=
 =?utf-8?B?UGYzZHNnYUMwSEh2Y0tzSUJWcEJCZnlrSjE0VXFMNEMxcExrUDZxcW45Z2NC?=
 =?utf-8?B?a3BkRzJRRGxwN1JHTjUvZEJ3elBlOEEvK3NmZFRMd1J2ZExZNDgwUFJRVlkx?=
 =?utf-8?B?K1JyMDloU0hNcFV6dEdaaGN4Z1U3b085NXhmV29SZ1J0OHJBcExKRE1oYXp5?=
 =?utf-8?B?ejB1QWU0c1J4MjRKTURpcjFuWHV5UUVUTlVPRWUyeFFmWU1iTnhWR1NVRkN2?=
 =?utf-8?B?aUZlOFlxVDNDK1ZCREZNYUczY0tQMmxDc0lnS3hIOTdkb2gyb3ppczlRbnMy?=
 =?utf-8?B?SDIrQkFQRm1QU1dab20rU2hUdnZidjQvZlVZang1Skd2WW92bHQ3dDhwNk1v?=
 =?utf-8?B?RE9HSkdaNmU0VnJFdTNPelNXY0lYWXZlb3MxMy80V1VGdGxzNFZ2WFkrMDlm?=
 =?utf-8?B?Nkx2RWFDUlJVOEhjaWs1R1I0eTNVQzQ2c3RaRW1LdGhhODZOZ2FuRnlSMmQ0?=
 =?utf-8?B?V0ZkaXBxTVhwdm1hYi91dFB6dEw0NDRDdWdLb0pBQkFnODI4WmkwR3laTnQx?=
 =?utf-8?B?eTQ3aVgxNjFoMjVseHdabWpQVlA1elVScnhYYjZFeU9ZZk9XT1J2a0NJOFRE?=
 =?utf-8?B?V1pwekZFTmx3SHFmWUU2RmZyQVVMZHZ0MGk3Z0ZkcTZjNDVTNUFUMlQ0Mkxt?=
 =?utf-8?B?eG9BZlJ4QkRUV25JbGIyQUFaY2dnRnZRM2xxSk1UbFZvNCtOcW1kM2p3cXJ5?=
 =?utf-8?B?UVplSzF3VFA2TC9zMEhxQ3hjWFJ2L1JLOWJJUXpsbXZHQVVUNklrQjBYaTRt?=
 =?utf-8?B?alRBMWt4bW0zSDM1RmFENUkrYmZ5K2ZXVm9XbnRYYlBrKzBmSU5pSitSNC9K?=
 =?utf-8?B?ZnFzNzRQMDVpb0RZUXc0RkswVWE5ditROWgwVTNPTGsxc0VYZVRsSk9pTWNx?=
 =?utf-8?B?UE12bTI3YnRUM2RNZ3hqV09EbzQ2M2RWZUs5b0F0dzI2aS9CdlVyOG5QeTYy?=
 =?utf-8?B?eiszRHp4VU54dzVwVFdWdjZFbVFlZENQdnJNTVRlK3ZCQ3g5bjRIZEIxZ1Zy?=
 =?utf-8?B?SkJLMzB0eitEVktFMkt4WUd2bkVrR2FmYkpzUlZ6dXFKUWI4U3NLQWdmZHVZ?=
 =?utf-8?B?OXU4USt6QjlaTTJNa1NpNVFnaWdDbE9DQmxnZmM5enNYWWtpRTFMUXU2NDN2?=
 =?utf-8?B?RW5aejRWWDU4TXMzdVhwM251T09BbkhqenVHV20yUGN4R2NSVTlCa3FsbWhO?=
 =?utf-8?B?L2VyRGFlN28vYk42emcrb2MrQ21WaEQyd2c1WnlNeW15bE9seUp2N3MvUlRK?=
 =?utf-8?B?VElCb2FKMytsTkwvM05iVjBUZnhTR05KejJKNGxWOUV5dnhpbERxOGsvRWxi?=
 =?utf-8?B?cFhSdzNaNDFZOUk2SFFsNWxHVnBiSWRib2JmYUpLcDVYd2puaHV3TDdqWmc5?=
 =?utf-8?B?QUtBUEtWQTBNdktOYzhWeVNURVZRNU8rQm14UDBoY0svdmRweTNaQnR2Myth?=
 =?utf-8?B?cVdzTm9Gd3dVOURRL2IwSzF1TklMTU1PVXdwTlVIckRyZEg0WDZGdmVMcnZI?=
 =?utf-8?B?cXJXU3BJU0tielpVeHFwS0o4TTAxWVBtd1NGZ0RXdFFmU0hLRGtrRFFveVhT?=
 =?utf-8?B?RlA5ZnhxbzdEdUVBM0xyTjNyOWcrL1YrMUVUdVZ0akdHTGhrcnRQU25LMXpa?=
 =?utf-8?B?QUwzTlhlVDlTVXhLNVRYK3RSNWhWOXR3TEdDUnl4UzQ2bEsvM2F0V2ZGV2VP?=
 =?utf-8?B?elQ4YVZUaWVuZzUvWVhqL3VxYlBPYVU2OGF0b2ZCV1gvSFJod1lTdG8rdnpD?=
 =?utf-8?Q?FHl9RaipkHjGkGIKgoSYiz4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmlZMjZZY1NDMWlPVDU3MVdiSWZ3M2lSNS80S1U5S3A2OUQ3NUVwS1VwQ3pk?=
 =?utf-8?B?TGZtZENvNkE0SGozV1RRNENaUzNLSUh4eE1abWptQTB3ZlQzOGx5cUdTRWdh?=
 =?utf-8?B?MU1vWTJXUTFIdDF0aEp5UkpVZlFZeFU4cUxnMFZIeGdpY0xEdVRId0tyMWt3?=
 =?utf-8?B?cXNxTHZLZk1vYS9VZ0xxRDN4Q0NsM3plVWRmUlZnYVErMHYyNDFpYThGRlIz?=
 =?utf-8?B?NkhpdHRDL0dDMHZWR0JiVTRLRm9UUDhUZHdLRkZzWUZkOWVjOUZSbzJLYkt5?=
 =?utf-8?B?aUU3TTZoUkV2UVJFNHE5QlRXb25DZ2RWNCtBTVltNHUvWHFzSFFsbUNCT1hG?=
 =?utf-8?B?OEI0UGtGcnZ5RTM0QWNDTnorRkc2OUZuYmJHQXJKRlo3R3R0Zm1KTS92RjVM?=
 =?utf-8?B?YjZXSy9pbG1QMHZSbVh1Y1dxVGtiME5RQlZTaWNIM2lVSWtZK2t0OGNuZjVr?=
 =?utf-8?B?cW94Ti80RHBvUzlCWU42cmo5b01zODhJcit5bXZSK3c4dzBWYS9TTEZzQldY?=
 =?utf-8?B?YS82Ukg0WWFnSnJ3eFBEUWFwSDV5Mk54V1dUaGYxdEhZNmdMWmdzWUlva1Yw?=
 =?utf-8?B?TEZJa1g0U3JwSjZ0NkxHbVlxZ2FBcURINEVpQTJ3WGVTVXBabTZHL2ZzNnRp?=
 =?utf-8?B?clZtWGtpblZiWDBuSlNaQzhUVG80TVVxSldrWGV1Nno3a1dIV1hOM3BQQWZk?=
 =?utf-8?B?NlRkQ0lMV3B2WWY3T2FpREdic1RDYWZYbjAyVmRxYnhwcG03ZXpmMUp0L2tl?=
 =?utf-8?B?cDZMQXdjU3hsQ2gyaVBzTG5la0Y0ekt4RnhQNUl3eWxRMGdBVlN2K3lDTldP?=
 =?utf-8?B?Z1lqa05xNXZJSmkySjlCVEUxRDIxeUJkZy9uTTMzdXRUOHBtcm8vQXVzSTQy?=
 =?utf-8?B?bThDZUt1cGxkZWhZSjRZTDlXQnNlYWNETnVmRXlYWmRtWVVpanZHbGJCYmtJ?=
 =?utf-8?B?aFEwU0NoaEM4WXBudGNWckpRcFp4VXRZaXdHQ25lbk9wWXNCbytjblhZQzc4?=
 =?utf-8?B?dzhBMXRMekF6RXVGRXFYY0lIMU5VOFBWU0s3Mk9iK0VyWm9hTzNuczlkQ3hj?=
 =?utf-8?B?Vmc2dlZtRStuanlXc05pNGxnUkExdmtQOEtsS1ZQK1lYbi9rSnlCNjFXYWw1?=
 =?utf-8?B?THROWXllQTV4Z0UvUE5sRlQ1andMcHNxeHFURHFUcXUyNFRkdW5PVW45UnV2?=
 =?utf-8?B?YUFUd0JlbG1xaElNU3lTZzhMTHRjallRZ2tWT0VMQW5uMDVhMG9QTUVXSGYz?=
 =?utf-8?B?Q2VOUDB1QnBsRGtLRjdxaHoyRUdjY1VuSXJvTXBjWVJnN0NMd1J1UnJuUFhv?=
 =?utf-8?B?SjdBMTFFbWFsZ1J1aTZ5dGw0VC9ZYWc4NHFZR3hzQ2R0czlYUGpVZmZKMjN3?=
 =?utf-8?B?eWNETEs4bk1nU3h6ZERWRzVqS3RqRWtVeTBrc1haZlpQT0crMWNQYWg1M2RF?=
 =?utf-8?B?V0FKWU9rQ1o0RFlyMitVWUcxbVBqZFpqdFlnVGZ3bmpKaFZHaUp5OEhTelp2?=
 =?utf-8?B?dkxJQ2pVQkJaYmI4T1hySktWRTFuR2VId0FuUmdhRjVqNnJtWm9RTGdpUHZi?=
 =?utf-8?B?d1RvRys3cmxSYVA5TzE4QlNlVTNTOGc0M3ArTjN3OTBEL21uaGtlTmxjdWZZ?=
 =?utf-8?B?RmYzb2RaWFQ0a2pndE84NmxiZFFYY2hFL2RmcjBvWXdoc2ZBSG1MUXpQUmI4?=
 =?utf-8?B?ZlRqbklCRDR0NU5DMldZMkRXSkNEVHRHSlU0TGFvSkVVMEV5VWFXZHBNU1NV?=
 =?utf-8?B?V00wYWpTaWZ0bU9EOUlQeWtCMXpaWGE5eStIL2QwZ2JZL0xsb01KRjZZUmVy?=
 =?utf-8?B?OG1QVGFwLzZhMmdSYktKeUFLR05hejI3SzZpNmRJaWV5dk1xMXBUZy9sVXNx?=
 =?utf-8?B?cDVORUxDMGxBTS8wYzkrc2NpYkNVWDdxZkUwTEJLQVVYUTJmTGQyQVo4RUEr?=
 =?utf-8?B?UmZZNmNlWmtROVBkMUxhamk5T1l2ZFcxeU9EcmVTRjNYcFU0bkMwZTZhN2cr?=
 =?utf-8?B?VncyVlZrM1VEYloyaFJHKzk0VGVmd0Y3Y0JrTzlGeExaZ0Z4T1ByeXpJWFdD?=
 =?utf-8?B?dkhwS0UvdVhreUNNRkFvclhRZ3daNzd3T2pFUmowR2NCQ2VqcGtEU3VPSnpP?=
 =?utf-8?B?TE5haFVaN1JtLzdmUTZyUnRNSEpPcFJ2NG1FUUV3QkloUWU5RFFWYmFIUmZ6?=
 =?utf-8?B?UUlpQm8yM2tpeWxiNnhDYVFxaFdQR25ocjNZQjNwOU9vajh3cUxrZ1RMZGho?=
 =?utf-8?B?SWN1ZVlaaVB0T0dyOUg4czVTSVpKT1VkMnFXc0VmSC9NMVF5WllPYnJ0WE5v?=
 =?utf-8?B?WVdFVHprU3dxdVUwS2lJVS9LVVJUQjA1Sjl6MjBrMmd6ZFU1U0pSUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05FB083BE21BEB419857C56BF653FCBB@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfa0848-ec14-4ccd-3b03-08de5f21ded8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 10:33:41.0316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gB0bTApODr1FWGU+cSvITRXOuHC6OS+2qHLvYQQVQj97OVnfiOynUko5KYca72duw1BvFo/9VixTRSxvHdARsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7001
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16193-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:replyto,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: BB7ECAEDC2
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAxLTI4IGF0IDIwOjU2IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gVHVlLCAyNyBKYW4gMjAyNiAxMDo1MjozOSArMDIwMCBUYXJpcSBUb3VrYW4gd3JvdGU6
DQo+ID4gZXN3X2Z1bmN0aW9uc19jaGFuZ2VkX2V2ZW50X2hhbmRsZXIgLT4NCj4gPiBlc3dfdmZz
X2NoYW5nZWRfZXZlbnRfaGFuZGxlciBpcw0KPiA+IGNhbGxlZCBmcm9tIHRoZSBlc3ctPndvcmtf
cXVldWUgYW5kIGFjcXVpcmVzIHRoZSBkZXZsaW5rIGxvY2suDQo+ID4gDQo+ID4gQ2hhbmdpbmcg
dGhlIGVzdyBtb2RlIGlzIGRvbmUgdmlhIC5lc3dpdGNoX21vZGVfc2V0IChhY3F1aXJlcw0KPiA+
IGRldmxpbmsNCj4gPiBsb2NrIGluIHRoZSBkZXZsaW5rX25sX3ByZV9kb2l0IGNhbGwpIC0+DQo+
ID4gbWx4NV9kZXZsaW5rX2Vzd2l0Y2hfbW9kZV9zZXQNCj4gPiAtPiBtbHg1X2Vzd2l0Y2hfZGlz
YWJsZV9sb2NrZWQgLT4NCj4gPiBtbHg1X2Vzd2l0Y2hfZXZlbnRfaGFuZGxlcl91bnJlZ2lzdGVy
DQo+ID4gLT4gZmx1c2hfd29ya3F1ZXVlLsKgIA0KPiANCj4gVGhpcyBpcyBxdWl0ZSBhbiB1Z2x5
IGhhY2ssIGlzIHRoZXJlIG5vIHdheSB0byBhdm9pZCB0aGUgZmx1c2ggYW5kDQo+IGxldCANCj4g
dGhlIHdvcmsgZGlzY292ZXIgdGhhdCB3aGF0IGl0IHdhcyBzdXBwb3NlZCB0byBkbyBpcyBubyBs
b25nZXINCj4gbmVlZGVkPw0KDQpOb3QgcG9zc2libGUsIHVuZm9ydHVuYXRlbHkuIEkgc3RhcmVk
IGF0IGl0IGZvciBxdWl0ZSBhIHdoaWxlLiBUaGUgd3ENCmlzIGZsdXNoZWQgYmVjYXVzZSB0aGUg
ZXN3IGlzIGJlaW5nIHVuY29uZmlndXJlZCwgd2hpY2ggcmVtb3ZlcyBkYXRhDQpzdHJ1Y3RzIHRo
ZSB3b3JrIGhhbmRsZXIgdXNlcy4gRmx1c2hpbmcgdGhlIHdvcmsgaXMgcmVxdWlyZWQsIG90aGVy
d2lzZQ0Kd2UnbGwgcnVuIGludG8gd29yc2UgaXNzdWVzLg0KDQo+IA0KPiA+IMKgCWRldmxpbmsg
PSBwcml2X3RvX2RldmxpbmsoZXN3LT5kZXYpOw0KPiA+IC0JZGV2bF9sb2NrKGRldmxpbmspOw0K
PiA+ICsJLyogUmVwZWF0ZWRseSB0cnkgdG8gZ3JhYiB0aGUgbG9jayB3aXRoIGEgZGVsYXkgd2hp
bGUgdGhpcw0KPiA+IHdvcmsgaXMNCj4gPiArCSAqIHN0aWxsIHJlbGV2YW50Lg0KPiA+ICsJICog
VGhpcyBhbGxvd3MgYSBjb25jdXJyZW50DQo+ID4gbWx4NV9lc3dpdGNoX2V2ZW50X2hhbmRsZXJf
dW5yZWdpc3Rlcg0KPiA+ICsJICogKGhvbGRpbmcgdGhlIGRldmxpbmsgbG9jaykgdG8gZmx1c2gg
dGhlIHdxIHdpdGhvdXQNCj4gPiBkZWFkbG9ja2luZy4NCj4gPiArCSAqLw0KPiA+ICsJd2hpbGUg
KCFkZXZsX3RyeWxvY2soZGV2bGluaykpIHsNCj4gPiArCQlpZiAoIWVzdy0+ZXN3X2Z1bmNzLm5v
dGlmaWVyX2VuYWJsZWQpDQo+IA0KPiBUZWNobmljYWxseSBSRUFEX09OQ0UvV1JJVEVfT05DRSBp
cyByZXF1aXJlZCBvbiB0aGlzLg0KDQpXaWxsIGZpeC4NCg0KDQo+ID4gKwkJCXJldHVybjsNCj4g
PiArCQlzY2hlZHVsZV90aW1lb3V0X2ludGVycnVwdGlibGUobXNlY3NfdG9famlmZmllcygxMA0K
PiA+ICkpOw0KPiANCj4gV2h5IF9pbnRlcnJ1cHRpYmxlKCksIHlvdSdyZSBub3QgaGFuZGxpbmcg
dGhlIHJldHVybiB2YWx1ZS4NCj4gSWYgc29tZWhvdyB0aGlzIHRocmVhZCBnZXRzIGEgc2lnbmFs
IHBlbmRpbmcgd2UnbGwgdHVybiB0aGlzDQo+IGxvb3AgaW50byBhIGJ1c3kgcG9sbCB3aGljaCBk
b2Vzbid0IHNlZW0gaWRlYWw/DQoNCg0KRGlkbid0IHBheSBhdHRlbnRpb24gdG8gdGhpcyBwb3Nz
aWJpbGl0eS4gU29ycnksIHdpbGwgZml4Lg0KDQpDb3NtaW4uDQo=

