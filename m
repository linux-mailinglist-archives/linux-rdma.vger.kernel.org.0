Return-Path: <linux-rdma+bounces-19455-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKYPInKM52lY9wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19455-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 16:40:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEDD43C318
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 16:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7D1130868F7
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 14:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025E33D88FE;
	Tue, 21 Apr 2026 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fR9nb3XD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011006.outbound.protection.outlook.com [52.101.57.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB043D88E0;
	Tue, 21 Apr 2026 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782038; cv=fail; b=EAB9exlgpS1Lfp9Ht/0/Dz8nwqMOjUq3sA1RVaW2qPyhoDXrq67zaXLchNoFrYHgf6kW7jpP09F2/yJq12pF8gQvD3HUQVwIAMVu5lOMf+v6Wxy+vdRDjOU72VBqqbesHtJUSfqAK6OfqmWPsTOoqxJo1b2VI2RurjBx87PQpd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782038; c=relaxed/simple;
	bh=jZhJ0KJfA0jDWABRZjD99badfwtQqyYPA0A+vV5NXLk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cPLvIs7IKste5dL56goKIVDrHnt60aBKzwxcBU5MMI6op7Tz2jRGeeyWmwWOgtoo0vN4AIpE3LmcdvgsYNru5dNc21156CYaNlgVaqMWMNWM7lysAsuC6jYvPxRDfaAH2NbLJiImUzsne/fhjvyKD2wXTLnXARMW3WjEhUdgCyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fR9nb3XD; arc=fail smtp.client-ip=52.101.57.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quP8cHo4H+tHDcSBn+xSyTWOvhLxVZwdK684dbCW9IONLUC8WD7FOvAnid/csl2b/VqQGPuRqL10NK3UMqF8piHxtHTrf01RRd7li/5O4kBDVYngMTbRUjA3zw0H2CH3ql+jlxSK/gLLtdHKr/yRV0Vzpp4fGP+SFLfsl/EXAwKBNwL08pLbtUVXOH9wHieASf2WXbhkiXDPeUIdxyAGpaU75yJPNgq+JIQaEfG+m5eLlc3XZ5CyzuaYfHaIp8yms4WaygHNcfR0V8jvXM50bLV9PPfuNoznO9b9LbhCGj0h0ym3oGzba/gKmmktYJarbUtv9FTSzXYt+OTydXHXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZhJ0KJfA0jDWABRZjD99badfwtQqyYPA0A+vV5NXLk=;
 b=ImGnSPH2qwPXNQz2YposQA/IESwdBll1BkE5P8okdcUC6Qk6pj74OTUVul9eLZyRzvxbxMEpip4opWgvo1j2oUDf6oRvVOYEF9MWzl3ZFxbqGvBKJjzg1Bi6qx7NLZYB7G4BeMHVj1GK8uZeUm9RxKEbQwDLuLg2yKO4VIfU/NQn6pkCXaBhJwFkpz0KbyIDBYfjn/BxTTR+D8D8TKfaj7I9M2P3l6By5fZ8DiECJkVvtD4buzBJROlOoFQSBPFtYV+mN+Z2BjqdhizFYW5nbdDwG9odsxzMRhfqh8WFG75+TpiZ2t6K+QaCAkfxsz0NjFIooYon0vej1yIvWqB7ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZhJ0KJfA0jDWABRZjD99badfwtQqyYPA0A+vV5NXLk=;
 b=fR9nb3XDNY3dRYKhYplHdYe7+20cP0MlKH+eBSaUOqQiChHuOFW8YQZkidOchDgAbP+Y3GKmfXMrHEZ65h4MxPTrIgTIz0GLPNxFJIQFVOFWTQOVXvmrD7vnjnzZKjvIg3SCf3YmqXnoGV0B/0m+65NKljPEW9pB/CHkhOxcOTRUcsuV1H1KutklFpIT+ACKTLUT/T5QguDCo81ojyZO4xaQvdQc9Y4z0KZcV6mt+OTmhtvN0C6pyk9cfOuJe6jQD95pyuKy8sMBw19DWz+OfkvRtalhE2wVNrz2W9XoR1WFGf1rGc0PDHoOsKYh1xd0FidZScCj5vUpwKHB39SJsw==
Received: from CH1PPF189669351.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::608) by DS0PR12MB6557.namprd12.prod.outlook.com
 (2603:10b6:8:d3::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 14:33:52 +0000
Received: from CH1PPF189669351.namprd12.prod.outlook.com
 ([fe80::61d1:eea7:9eaf:f448]) by CH1PPF189669351.namprd12.prod.outlook.com
 ([fe80::61d1:eea7:9eaf:f448%8]) with mapi id 15.20.9846.007; Tue, 21 Apr 2026
 14:33:51 +0000
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
 AQHczieNmLFIHpbrDUuqFWyBz+NLKrXlMUIAgAKT6wCAAG9bgIABRBKAgAAgroCAAAIjAA==
Date: Tue, 21 Apr 2026 14:33:51 +0000
Message-ID: <3ca1bee450608d37cd0f9199ebc44c52c084cb08.camel@nvidia.com>
References: <20260417050201.192070-2-tariqt@nvidia.com>
	 <20260418190848.204170-1-kuba@kernel.org>
	 <d7e2d46769e120a16ce12d345c51a47349733828.camel@nvidia.com>
	 <20260420100917.1e4be22a@kernel.org>
	 <f327ce67e69c27ed971f4ed38f46381cd2f97ec7.camel@nvidia.com>
	 <20260421072609.4b15e7b9@kernel.org>
In-Reply-To: <20260421072609.4b15e7b9@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH1PPF189669351:EE_|DS0PR12MB6557:EE_
x-ms-office365-filtering-correlation-id: 604e8294-3114-46b0-9def-08de9fb301ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 f3vPAsxDODFK/r3TnwN3dU1U8bxm7j/I5CP+x9KgxQdm0cQqRtt4C/riTotY2Yh3J3nzBdzjCypXOWE4t2r/hLdXiOMSnoLY2mmHMf/5btu9ViQzvyXH8G34yASjwSjqElRVxcntQYNUAW85w+JHzflI3nrsOFEtQ8GyiVP3mLdeTl3IFE/WM2S7mZa5rf8Hz4B4mEaUG99FbyTS3DM9aRTE9vOCxdZYGP+dE2oqnQn0roUQYRJvW/ukImhBPd1e5GLQCAK2MHJcHcNngUccLxKu1dkiT51KTBiVOJrikepn/zY6Xc0ed3jL1VlGdLZEwouAGSSjnDA7kURwGLfjboFj9nMzGWQKzc4xkRr6CSBCr3XPii40wPP7ItizHcWjn3AV8awJP5kuvYEuNHhDzec+I2Up9RRjgz8opXP8r46xbfdY8bW4jXnSpgWRXpx/dol9jQd779JZb67luYKcXt447zhoSAJ/Fi5Sxjf8M8DHQI4F7VRYb8jP2MTPh94yk27zC67HrOIdF1IEgI5tDIu6FwnLyrvs5HsQgcYwsaGvDyQkdXXpD6rP+zWDDE10W1RR8F9hVuxTiZ2V0NOFs7Imok9GXMQ4ryP/q/kaeoaFpDPkAU7s6xhMHHhYWeMjQNhgnOIJjKjQ06gxK35kK7FeRpJZ5OrHTZ8oerf/tjNzDvDqgDX9SADmgBk9sqwEKQoATGB0W5pXscVc5YZiY51bXWB2UHGDQUbsLDuDxUS361w3i3nZiPiTQad4Aj1kVmdMq5bt0vG4M7kHa0huLty9K3ih5Ns9umyQoa8NeVY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPF189669351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OThpYVRNdFpqcGIxaG1ua1N4RnhQMGl2RWZRN0JBaVBQMVd4Vi9Xb1VhVlMz?=
 =?utf-8?B?QUYxTnoxQmEyRG5zQmRqeWlPclVCZjJDaGRjRWpmc1Uvdlc1eFUyQktUZVdC?=
 =?utf-8?B?K1RKU2dLUXZKaXlTM3ZvcXM2WkkzWUtvNVdwM1lSUTZEWi8yVEJhcDRSdHpE?=
 =?utf-8?B?VkNuaWJocFRlZTk5bkU1YVV4OGpIM0JaMEF4Y3VJZm1RNVpyb0RUVGwwWm9p?=
 =?utf-8?B?bjhaZ1k5bERNeEZOVDMxaGE0WStlaCtJZGJyMkdCczloZEp0VWk4bFlqQ1Nu?=
 =?utf-8?B?bXFyM3ZNYS8xaTFUNW5YZk9yZ3JpQUpmUk5YdG1wbzZIbjl3blptb1hJOVd6?=
 =?utf-8?B?bElVck55M1VWYVBaUTBaZTEzOFR5Unp6R2dzNWQzaHlBTkE2MTBnWEJHYVYz?=
 =?utf-8?B?eURoMlVyUVpuMTBucFQyaEVFanpKaStYWHYyOFkwdVVITm9PTU4rZDAzOUxs?=
 =?utf-8?B?VmMzVVhJU05qR3F1WEE5eDAzeW8vWDBSRlEwQThtMDNJK2syTk5UNmY0blds?=
 =?utf-8?B?U21yejVWd01PbU1nVGhneE00SzErWVFnKzg0enZUeGZuTzRFbXk3ckpLV0xO?=
 =?utf-8?B?cXZkamlxcUxxcUlvbDdJcVpUSjA1emxNaEozVXdkTW5NTUV3OFVNRkd5Y0o4?=
 =?utf-8?B?dFRSZUtjeE9RQzZ3aHpFWFNRcFh1QkVKdkQzZ2pCczhiaGRZaVUwWlFrTkNE?=
 =?utf-8?B?TnJkdS9mcDBrRmdFYnVkMmk0dU5vdjBadmcwdnlMYzNnV3FSMWI1ekEzVzR2?=
 =?utf-8?B?WGgxR0xkNzNnMnpOWjZGUm1oak9rZjJtT0hDMy8waU0zZFJ1LzlsaFIvSGcr?=
 =?utf-8?B?c2dxdTZPdythQWg1UHd5dHRMS3ZYd2ZmSDdrRkYrMWEwUWhWb2hJa1g3YTdw?=
 =?utf-8?B?VGVISys5aDl5WmlJWTZ5YWREVUo4dTVvK3BGUHJmVTJtVU5URzZLb0lTSDFK?=
 =?utf-8?B?cXVrWEI5UTU1d010aWx1L1VZYXBFc3FIVXBSc2QrN0diRE96QnRBazRZTTBw?=
 =?utf-8?B?cVhmSnFvd3RwK0hOb3pTS0JzaDFIMXhVc1haRUpCa0h3VHRqZkJ2bmlKNTFZ?=
 =?utf-8?B?ZWUyRWd1REo5UElkNFI1YnB1YVpqWmxzVmo1aWR2ZFJYTWZlajB1RzNuUG5J?=
 =?utf-8?B?UkRYbjh6bEo4OTEwa05kVnZUSnRYK3ZVN3llUEFUQnB6MzdDci9icDU0WHk2?=
 =?utf-8?B?c2NaZUNJejJqcHNrNVRvNlRCSGJPcWNRUUEzVzZlMHVlenphMVMrS2piZGNB?=
 =?utf-8?B?R2srWXIxSG1Gczdub1c3d2x2dEN0Yi9zZmlDZ3BROWNyMlp4OHBrTUorZEZF?=
 =?utf-8?B?M2R6Zy9WMExDc2cybGxvWEN3MjE4b0Q0ZXhVZlIvL3dXUzJML21kZVlHWUZk?=
 =?utf-8?B?RTU1NG9WUUdheDJvMUJidUxnYW5OZldQUHF3RngxSEJ5SUdFUjRKc05ZeXlE?=
 =?utf-8?B?ZEc4K3N5TmNSalBEKytTL0QxVHF0YXVXSFNPUFltUEovQzBlSHRPb3JxT0Fq?=
 =?utf-8?B?M21YYWppRVRTb1JBZHNxNXRybjBMQVptS2p5Z1JEdXBZc0JyaDdrUUtOaDRx?=
 =?utf-8?B?L3hzMENjbzhidkpyeFZVM3VrRHBzSnBOWEVXS2VBQXF1Skw2WU5aWjJFRDd5?=
 =?utf-8?B?SjNtSjg2VmtrM0NERVg1WFVCWHNoK3Qzb0VTL29HQmhYVzNpVmdGVHEvYlo3?=
 =?utf-8?B?ZzRhMFJkZks0L2RzWEtxck1KYmlDK1hkeHhGRG54NnZvUEJmblVPOGE0M284?=
 =?utf-8?B?VjFOMWJVaFpUVnB4MjZOVDlCTXU2MENQWFN1T0hkYmtVZVYwUzlVbkRXVTZl?=
 =?utf-8?B?d1hZb2JmVktkYVpsQStHNm9SanVyNFJKQ1Z0VFRIV2Q3VUpyQy9hSXNiYWlD?=
 =?utf-8?B?V3BKNjBBaXBqdHBua1ZjcUJyaVRZNlNabFFJTWUzd3p3VTVYcXcyc0dFQ1Uy?=
 =?utf-8?B?TGlLcGlOc04xRmQ4KzQwdGNFQjZaOGdGL0I0anNnalppdUVnd1d6dFV6MFB0?=
 =?utf-8?B?NnlDRUw1c1ZmbDJLeFdBR2RyUkNxMFVFU28rSWRXR0Q0MC9BdkFTWDdpS1Fu?=
 =?utf-8?B?R1F2WjBqVHIwSi9lR25pRUtteW13aGZTcXp3MGI0bUdOTjdKejdLMk1XTUht?=
 =?utf-8?B?cnFJTGFNTkdUWWZKb2M3Y1BQc1U2UnlHVVI2QTB6NWRoVzRqQ0tUNE9IV3E5?=
 =?utf-8?B?RkxIejdtdjNsR3ZLdDVteXNuME50MkdqSjVINjd5a0RDd3dkTWxKL2tqVlIy?=
 =?utf-8?B?cVM1eDQ0eUo4TEswVHplcitqcTNONmU0dmVpMHdUMldZSFBUbURpQVZqU2FD?=
 =?utf-8?B?bHowcldVcit2ZGxTQnREYVliYVdYVHNleUxMNVdEVkc5S1VFd0Nndz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83AA54A0E38D2A46918C61286BD9617F@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 604e8294-3114-46b0-9def-08de9fb301ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 14:33:51.3415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5r7eVN6M+T+Fmih2mcQ9Nc7Jfoj5jRXWCIhhrR/YG0EqL/ibngldQb3/PdukQMujbulVOAZtykgy1eI1Y8YEGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6557
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
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,lunn.ch,davemloft.net,kernel.org,vger.kernel.org,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-19455-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 3FEDD43C318
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAyMDI2LTA0LTIxIGF0IDA3OjI2IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gVHVlLCAyMSBBcHIgMjAyNiAxMjoyOToxMyArMDAwMCBDb3NtaW4gUmF0aXUgd3JvdGU6
DQo+ID4gPiBTdXJlIGJ1dCB3aHkgYXJlIHlvdSBsZWF2aW5nIHRoZSBwcml2LT5wc3Agc3RydWN0
IGluIHBsYWNlIGFuZA0KPiA+ID4gd2hhdGV2ZXINCj4gPiA+IEZTIGluaXQgaGFzIGJlZW4gZG9u
ZT8gSU9XIGlmIHlvdSByZWFsbHkgd2FudCBQU1AgaW5pdCB0byBub3QNCj4gPiA+IGJsb2NrDQo+
ID4gPiBwcm9iZSB3aHkgaXMgbWx4NWVfcHNwX3JlZ2lzdGVyKCkgYSB2b2lkIGZ1bmN0aW9uIHJh
dGhlciB0aGFuDQo+ID4gPiBtbHg1ZV9wc3BfaW5pdCgpID8gSWdub3JpbmcgZXJyb3JzIGZyb20g
cHNwX2Rldl9jcmVhdGUoKQ0KPiA+ID4gbWFrZXMgbm8gc2Vuc2UgdG8gbWUgLSB3aGF0IGFyZSB5
b3UgcHJvdGVjdGluZyBmcm9tPw0KPiA+ID4ga21hbGxvYyhHRlBfS0VSTkVMKQ0KPiA+ID4gZmFp
bGluZz/CoCANCj4gPiANCj4gPiBwcml2LT5wc3AgYW5kIHN0ZWVyaW5nIGF0IHRoZSB0aW1lIG9m
IG1seDVlX3BzcF9yZWdpc3RlcigpIGlzIGluZXJ0DQo+ID4gd2l0aG91dCB0aGUgUFNQIGRldmlj
ZS4gQ2xlYW5pbmcgaXQgb24gcHNwX2Rldl9jcmVhdGUoKSBmYWlsdXJlDQo+ID4gd291bGQNCj4g
PiBiZSB3ZWlyZCwgaXQncyBjbGVhbmVkIHVwIGFueXdheSBvbiBuZXRkZXYgdGVhcmRvd24uIFRo
ZSBmYWN0IHRoYXQNCj4gPiBvbmx5DQo+ID4gbWVtb3J5IGFsbG9jYXRpb25zIGNhbiBmYWlsIGlu
c2lkZSBwc3BfZGV2X2NyZWF0ZSgpIGlzIGlycmVsZXZhbnQNCj4gPiBoZXJlLg0KPiA+IHBzcF9k
ZXZfY3JlYXRlKCkgZmFpbGluZyBzaG91bGRuJ3QgYnJpbmcgZG93biB0aGUgd2hvbGUgbmV0ZGV2
aWNlLA0KPiA+IHNvDQo+ID4gbG9nZ2luZyBhIG1lc3NhZ2UgYW5kIGNvbnRpbnVpbmcgaXMgb2sg
KHdoaWNoIGlzIHdoYXQgaXMgYWxzbyBkb25lDQo+ID4gZm9yDQo+ID4gbWFjc2VjIGFuZCBrdGxz
KS4NCj4gDQo+IFRoaXMgaXMgYSBtaXNndWlkZWQgY2FyZ28gY3VsdC4gT3Igc29tZXRoaW5nIG1v
dGl2YXRlZCBieSBPT1QNCj4gY29tcGF0aWJpbGl0eS4gQWxleCBEIHNvbWV0aW1lcyB0cmllcyB0
byBkbyB0aGUgc2FtZSB0aGluZyB3aXRoIE1ldGENCj4gZHJpdmVycy4gSSBkb24ndCBnZXQgaXQu
IE9mIGNvdXJzZSB3ZSB3YW50IHRoZSBkZXZpY2UgdG8gYmUNCj4gb3BlcmF0aW9uYWwNCj4gaWYg
c29tZSAqZGV2aWNlKiBpbml0IGZhaWxzLiBUaGUgY29tcGF0aWJpbGl0eSBtYXRyaXggd2l0aCBh
bGwgZGV2aWNlDQo+IGdlbmVyYXRpb25zIGFuZCBmdyB2ZXJzaW9ucyBjb3VsZCBqdXN0aWZ5IHRo
YXQuIEJ1dCBjb250aW51aW5nIGluaXQNCj4gd2hlbiBhIHNpbmdsZS1wYWdlIGttYWxsb2MgZmFp
bGVkIGlzIHB1cmUgc2lsbGluZXNzLg0KDQpJIGFtIG5vdCBzdXJlIGFib3V0IHRoZSB3aWRlciBj
b250ZXh0LCBidXQgZnJvbSB0aGUgUE9WIG9mIHRoZSBkcml2ZXIsDQppdCdzIGNhbGxpbmcgJHRo
aW5nIGZyb20gdGhlIGtlcm5lbCB3aGljaCBjYW4gZmFpbCBhbmQgaXQgbmVlZHMgdG8gZG8NCnNv
bWV0aGluZyBhYm91dCBpdCwgZWl0aGVyIGZhaWwgdGhlIGVudGlyZSBuZXRkZXYgYnJpbmd1cCBv
ciBhY2NlcHQNCnRoYXQgJHRoaW5nIHdvbid0IGJlIGZ1bmN0aW9uYWwgYW5kIGNvbnRpbnVlIHdp
dGhvdXQgaXQuIFRoZSBkcml2ZXINCnNob3VsZG4ndCBuZWVkIHRvIGtub3cgd2hhdCAkdGhpbmcg
ZG9lcyBpbnNpZGUgYW5kIGhvdyBpdCBjYW4gZmFpbCwNCndoaWNoIGNhbiBjaGFuZ2Ugb3ZlciB0
aW1lLiBUb2RheSBpdCdzIGEga21hbGxvYygpLCB0b21vcnJvdyBpdCBtYXkgYmUNCnNvbWV0aGlu
ZyBlbHNlLiBJdCBkb2Vzbid0IGFuZCBzaG91bGRuJ3QgbWF0dGVyIGZvciB0aGUgbG9jYWwgZGVj
aXNpb24NCnRvIGNvbnRpbnVlIG9yIG5vdCB3aXRob3V0ICR0aGluZyB3b3JraW5nLg0KDQpJc24n
dCB0aGlzIHJlYXNvbmFibGU/DQoNCj4gDQo+ID4gbWx4NWVfcHNwX3JlZ2lzdGVyKCkgaXMgdm9p
ZCBiZWNhdXNlIGl0J3MgY2FsbGVkIGZyb20NCj4gPiBtbHg1ZV9uaWNfZW5hYmxlKCkgd2hpY2gg
Y2FuJ3QgZmFpbCwgc28gaXQgcmVhbGx5IGNhbid0IGRvIG11Y2gNCj4gPiBvdGhlcg0KPiA+IHRo
YW4gY29tcGxhaW4gdG8gZG1lc2cuDQo+ID4gDQo+ID4gQnV0IHdoaWxlIHRoaW5raW5nIGFib3V0
IHRoaXMsIEkgc3VwcG9zZSB3ZSBjb3VsZCBjaGFuZ2UgdGhlIGVudGlyZQ0KPiA+IFBTUA0KPiA+
IGluaXRpYWxpemF0aW9uIHRvIGhhcHBlbiBhdCB0aGUgdGltZSBvZiB0aGUgY3VycmVudA0KPiA+
IG1seDVlX3BzcF9yZWdpc3RlcigpLCBhbmQgdGhhdCB3b3VsZCBzaW1wbGlmeSB0aGUgbnVtYmVy
IG9mIHN0YXRlcy4NCj4gPiBJIHdpbGwgZG8gdGhhdCBpbiB0aGUgbmV4dCBwbGFubmVkIFBTUCBz
ZXJpZXMgZm9yIG5ldC1uZXh0Lg0KPiA+IA0KPiA+IE1lYW53aGlsZSwgY291bGQgeW91IHBsZWFz
ZSB0YWtlIHRoZSAybmQgcGF0Y2ggYW5kIGxlYXZlIHRoaXMgb25lDQo+ID4gb3V0Pw0KPiA+IEl0
IHNob3VsZCBhcHBseSB3aXRoIG5vIGNvbmZsaWN0cyBieSBpdHNlbGYuDQo+ID4gDQo+ID4gT3Ig
eW91IHdvdWxkIGxpa2UgdG8gc2VlIGEgc2VwYXJhdGUgc3VibWlzc2lvbiB3aXRoIHRoZSAybmQg
cGF0Y2gNCj4gPiBhbG9uZT8NCj4gDQo+IFBsZWFzZSByZXN1Ym1pdC4NCg0K

