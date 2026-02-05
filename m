Return-Path: <linux-rdma+bounces-16573-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NGSAMaHhGl43QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16573-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 13:06:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CA0F2353
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 13:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35A02301DAF7
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 12:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF00A34AAE3;
	Thu,  5 Feb 2026 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="j44Xvugc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022115.outbound.protection.outlook.com [52.101.66.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F71CEAA3;
	Thu,  5 Feb 2026 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770293004; cv=fail; b=f6GByvYuypVu9ZlKl3HDy24urgGWzhxJPOSGN4qYSpcj8EQ8SNMcba7BPV7nE1fbI7YIS1ofV7R6Liarvny97Km5rSNhDAe8qJb0om/Npe+C/O0uMO9DAGpS4a6J7kk6QjMnRu9T9ShdKxYn9WuS3wlsvYMYfm9N2cmMBEkVZ6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770293004; c=relaxed/simple;
	bh=2RXEQ+0c7ItL3Uyl0bDtAyBEZWIG7tyO3BAxaagjoq0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d8WzzfMCEBVWFObb/Unz/knPmhARFq2FVfYJf4ywsb0P+rPH7fgDPZpZ6roMeBHnxKVXG0Z6DaT0WX0tu+RiAH34CoB568ogeyfyhGUdjbRAnr4fGhxdYdctin+WDQPrzIY5320/NObPtmXraHJYeD7gK0Q86vyJp6tYC+yAs/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=j44Xvugc; arc=fail smtp.client-ip=52.101.66.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcVK/i+Es0MQhnHolyEihLjypIpEZOzgwtkTKCgmheRCjMe/blnpfrRH2ayUoiajlAe7Xf7d8pCLFVAZoUfoHBhuoHFEyTfV0nwr+TW18kvV+W0dvTc+k0JSwNsvNGRFmf/J/w1gAQQxQ7FEQCjYaqsmU2YCScO7l6hQLKHzo63vDOySibQC4Vr/p0qidzktIjTqgVvNY90UlKLwsLc9AdaJs3yYrifHzfj8857r0pIl1/xxCRR8RgBdDfuUwWcESqel72JglBXV71c8o3s+r9LX/mMwRFYulT7DV8GjfA4TVNGhDCvTMGCpnqh//NTwYGoqH0G1bvJTFMPOm4Qtaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RXEQ+0c7ItL3Uyl0bDtAyBEZWIG7tyO3BAxaagjoq0=;
 b=cU9mlvBC+AfQPLHvAkRAiRtPl/ZtsvBS7xR2N11K0W6/MvSq9xoL9CyNJdT2JSGO8UAEdyWoH1VuUM+xP7DMdUnhfocu0kmkT6j1LYIeFug/l2kc/NMD89mWzErZLwXTag64cS/oX0W7bCPGpjcGqFTRZ71EVi2N4jRbzVFuwTKLp8vov33gSpTFw+ghCcItYh5IoKIN2V+OXPJrhtgjd2auQMlwLUCeRpNWaNpA3MrwbJK3vDS+kEwrdmLvX3IZV4S1Yg3P+RNVOp39GIkM0z66tzb/eaUnJAetVBBHvZZM8U4uhyK4174IMO+VAlH4DtL9piqp89vcR42BMj9ZkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RXEQ+0c7ItL3Uyl0bDtAyBEZWIG7tyO3BAxaagjoq0=;
 b=j44XvugcZFGOzq65p+1DgKrktFfpMKlZiGNo4mnyM90HGoOlGznc5qmpm58V97b8RqV6iSeA/ov18JNR/ledpBctbcAGmmr6xXJxCS3XvKGqySXGV+mWvOST0i9hVJhIzNrQRwzkBZF5vEFZvsMd6sK8zFY/Zk4Y0OpYL1q4rRY=
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com (2603:10a6:10:5cb::5)
 by VI0PR83MB0696.EURPRD83.prod.outlook.com (2603:10a6:800:238::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 12:03:19 +0000
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e]) by DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e%5]) with mapi id 15.20.9611.001; Thu, 5 Feb 2026
 12:03:19 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Konstantin Taranov <kotaranov@linux.microsoft.com>, Shiraz Saleem
	<shirazsaleem@microsoft.com>, Long Li <longli@microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: return PD number to the user
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: return PD number to the user
Thread-Index: AQHclpdq6mIsaYtVEk+csMcjpWoLhA==
Date: Thu, 5 Feb 2026 12:03:18 +0000
Message-ID:
 <DU8PR83MB0975E65E87B49534950E9447B499A@DU8PR83MB0975.EURPRD83.prod.outlook.com>
References: <20260204135813.870538-1-kotaranov@linux.microsoft.com>
 <20260204142827.GF2328995@ziepe.ca> <20260204174643.GA12824@unreal>
In-Reply-To: <20260204174643.GA12824@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=eb711a49-8ab8-4eaa-8705-fb9914bc2759;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-02-05T11:54:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU8PR83MB0975:EE_|VI0PR83MB0696:EE_
x-ms-office365-filtering-correlation-id: a483586a-8b0b-485b-9fa2-08de64ae8d46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VkJFb0N3eEpWVW1BSmVtNjQ0NkpRLzhyd2dTNHgwMDRVSmxsM1Vsay9BQlNL?=
 =?utf-8?B?b3FiSkc5U0Q0d0xKazd1UTczZm9DYUVqVTZ5R0xpWmcvT0JIREgvQVU1SlJ0?=
 =?utf-8?B?MUZBVmZCc1NHeFRYajBkdEt1cm9TNEtYQWFUNzhPcHpsR3lZdkJldUxWSzI3?=
 =?utf-8?B?ZDlUYkNZYTBCMlpGd09KNXJEcC9GRlg1b2FSSWxQQkR5dFF5UTN5QWEyTkdJ?=
 =?utf-8?B?MDBRUHM4UUQ4OHErTHJmQ3dldmc2MUg3eVFNRUtqeDhvK0tvRnlvTXhJTXhZ?=
 =?utf-8?B?MnVncDBhSjliUFg0Z1VPUnpERXIrbmxpMXBWdWNrUjNSQ3h2RWNyUTBnODQ5?=
 =?utf-8?B?R05VQ3V5NStLazhlOHFZeDl1TTlLanVSM1JNRUFQM0h2VHlzaUFxaW1GRFZ0?=
 =?utf-8?B?Si9LK2JrZVRwZ1J6cys5dHdxYSs1a3ppaklieDNFcGsyQVFZSEt2T2VlcWVK?=
 =?utf-8?B?T1QyQnByQXlBSHVHeHg5N0d1UzJ6SnRwWlhkRGZYQWxrK0txQWk5L3RQOXRy?=
 =?utf-8?B?QkxoYzFianVqOXpPQTNXSnpOTU9JbFNyK052YjRZZHZ6ZkxQc01JU0cyNmJV?=
 =?utf-8?B?YXNMYXBuQWFoRTh2a3plK0pNMW55bFNzelZ2ZjRlT1ZUbTN4QkZzbTV3MzJi?=
 =?utf-8?B?YmhFd1l1QkIweldZRHRiOHhpSjd0ZERyUXdBYUV1V2NBRXpnKzdXY0RPY0c5?=
 =?utf-8?B?ditiMzJ0Y0hOcUErZS9WVll3L0cxWG0rZjZldHE4WVZYbStuM2NwdmJSNE9r?=
 =?utf-8?B?aVZ3WHZpWDI4U3N4MVpUSng3WndvQlFLS1plbVZFSzVORkRQUWZkUDV4bzZk?=
 =?utf-8?B?Z0dhdGdCZktmb1NTK2NoNnlVRXAxUXAwNGhVM0xDck1jWCtzNXFxbndkbEww?=
 =?utf-8?B?OUwrWGNTVUhoY0pTd0Y4TDNuRE95M0lBNFYyanVLVjQvUjNRZ3Z2N0k1b2F0?=
 =?utf-8?B?Nk12Qm55TEpzMUk1dWxTMWwvVjVXV2pTTlVHYWp0Tk0rNnlQLzhtSDgyTkRP?=
 =?utf-8?B?dy9tZ0YwallvTnpLTkdGRTZRQlF0MktKSVhWck5uVzB1L1JSdUpCUGk5QW94?=
 =?utf-8?B?YmdYQS9nMit1M2JScis5SG5kZ3BnaUZaUDJSanBONHVlM0pxdEl3bTRpbmpx?=
 =?utf-8?B?bHJmamZQd0tNUnhndFNGRXo0TXJWcEUydXpaZlI3TmFoOXFrSXd3WEdoSjZt?=
 =?utf-8?B?NjRidHVBelpqUHBsbE9leVI0K1lrOThhVG05RjBWVVFrS2pZajU1TXZOeHBl?=
 =?utf-8?B?c2tzRGxaTm40L0FkM0s2dkhCNWQxVjNpdzNuMXI3M1gyU1FGNFpzN2VJV1VR?=
 =?utf-8?B?YVAxcW1oM0Zzc0FTRDlWV1pYeDVFTW8yMnZUUzVVc0hOWjVOUXIwelNPTjUz?=
 =?utf-8?B?ZjdYUFc3c1VDd0orN3E5UFNKR3NXZjdwN2lscjRNOWRCdGV6TDlrOS8xY2Yy?=
 =?utf-8?B?cGtPL1I0QnA3UUhyT0kvR25KaTdHZnlPTmplcTY3OVNidW8vV2FmRFRDQ0Nk?=
 =?utf-8?B?NFJ6MmQwai9oYTA0TGp5NUZWVHZlNnI1aXVPVjFwKzQwSHYwTHhmaGk0YTlp?=
 =?utf-8?B?NCs5TFE3dTd4K3laSDJqbzFMTE5tQiswMkswZytwUklydm5NTDl4ekt2cHdo?=
 =?utf-8?B?LzBsQTdtdk5kUU9TL3liVys4ZTB4R0ZHcmtSRWtlSU9pRVI4QzJxV01pT0tK?=
 =?utf-8?B?bGl4TUpHQ1ZsdHljZ1RzZTBxMlJUTHc2ZjFXajJGU2NhSkwra1FSWUlqdndl?=
 =?utf-8?B?T1QzdjVVRThLcWFhN3FyeHdZQnNnWjVDMVJkMGE4UUZ0SGU3NTMzNkpqak8r?=
 =?utf-8?B?eWhNSWgvcU5BTzZsZmNGN2d1UGI4LzNtNk5aTXRFLzJ1L2RYY2RMVkxvd3A2?=
 =?utf-8?B?aWJZOERGU1ZpQlkzTE1Jbld2cXJERkcyTDR0T3VqanVOOE5GdzJ1N1BXbVhL?=
 =?utf-8?B?R0d2YUF0RDg5Z01yelREMmRzZVNLVyttblZMeUxFbkVRWmQ2S2RUNTJrc0Y2?=
 =?utf-8?B?aElmWjlIdTdnR3BuUnVReCtZMTdsUmlXd3djRUNvbmFnRTREVCtVamF3Y1J4?=
 =?utf-8?B?SWVyck9XRHJQZWF6SkJRSG5IcTRzcDlXQTdQcVhEc09FTURHY2htNE8vcDd1?=
 =?utf-8?B?em8zME5tSno0S0lFeS8zbGhlUzBia0x6NVJyakEzL2JDWWtXc2dNL1YvRmJl?=
 =?utf-8?Q?9BfGvv3AgiPgW0S9hN/GPzI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU8PR83MB0975.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWtBQk9QTFBkWkZZVWZOb0ptNjFVQStLanY3WFo3ZlBQNDZsU2UxOGNnRFo3?=
 =?utf-8?B?cGNlV1RNWWZmdnAybnJ0SDkzQ0xVMTE4TG5NdGlUaFh4VTJQTlN0cVhUdElE?=
 =?utf-8?B?REVrdWs3VEZvcDNXTTZRRGlEUitEVElhL0lFRnRqaWY4RU5DRDVFc1F4dGlo?=
 =?utf-8?B?VnZxdGIwNGFDYXRFbFJEV1FmNC9jb1RjeFovT1Y3ZFRvejAxUnZsbnZLV1Fa?=
 =?utf-8?B?RXFWL2pNL2FaTXYzTS90b1I0VkF5ektJQTlBWTJGd1JMeCtndlRMR0RxYjdu?=
 =?utf-8?B?NUJLd2tzVTNOa2xIbXBsNnlyZnBqelBFN2ZibmpSTERFOFBleHNYdzZRTk9q?=
 =?utf-8?B?RXBDbjVvNVg5cTY2cEpLTmlSRUV6UG56NEhnQ0hVd21HOXFqQU5IRDJlcytH?=
 =?utf-8?B?WElTY0hrK3ZQYVJibmRBbU5aa3RENW9VQXFFcHpxK2pPTVhKM3ZRbnlOTC9r?=
 =?utf-8?B?NDU3VTZ2MkYrZW9KT0ZnOFo0NGRJTmJUTXN6ck9mUldRWXdMdGgxK0V6MTA1?=
 =?utf-8?B?OGo0VUsveFdGTzZDOTRUbmZ5UmMzR00wQ01RK2sxN25jYyt5TDk1VERzRXMv?=
 =?utf-8?B?Zjc2Y1E3eHNheEp0Z1l6U2o3LzRoYkRXVWVUWGY0U2NqMlpZQSs5QVhnNEFt?=
 =?utf-8?B?NG5xZksrNDBQTmhiMWlrSUVvSzRNUUdBNnNzaW9lWE0wSXZ0RTU4cjlQUEpN?=
 =?utf-8?B?ZFhQZUFEeElEUUM1QjkxUDZ3Vm5lcEVqU2k2SE00Y1JQeVM0S0lpMndTU0dX?=
 =?utf-8?B?SzltVS9pV3NyZ0FVbEhqc3FRRyttMy95cVNONjl0V0ZvWEYrb2JDb1FrQkRj?=
 =?utf-8?B?eWlnQi9OVTRFbGx4bkcrK29nM1lvSytEZFE5ODRqNHIrVmxjOUhwYzliMWRG?=
 =?utf-8?B?akg1eGVZOGtNYlA5ZC9kUWlvOG8wcC8wSWZhMjhqMU9FRWxaMGhMZFIrN2lR?=
 =?utf-8?B?VnFMVVZURFJLeUlwQjNMc1lsM21JamI2UWdhWUwwcTNOQ1JxY0Qrd2JsV0Rt?=
 =?utf-8?B?Sk0wNEFiYVVUN21WOXdCRzJxQit0ajNkSFVBK2hXRk1veld0c3VrZ1VzTkly?=
 =?utf-8?B?YzRDa2pFUlU3a2k3VXlPekFNSHhlTFZrKzhSQ3lyNGdjWU0yaWtMalJSdFZB?=
 =?utf-8?B?SVBMM3BNK3JLWlZEbnNWdkwxbGkyRkRETlB3NUVIOVRubDhLRnRVdTZURmpF?=
 =?utf-8?B?VGs5MmVjK3VwOU15cks1eUtDdFlZS2N3UzBTNFlYV2FaNkxScHJua05qVm9X?=
 =?utf-8?B?b1ZTU09MdVFNUHQ0Y2ZUdHBOTm1OWW1DM0tPRC9ockhER0IvQVJ4TlBpNXdG?=
 =?utf-8?B?V0FTZEZHZXprOWhJSmhkT29paExEbXpyd2NSMkRMYm85WU5qaVhZWDZPcE9w?=
 =?utf-8?B?Um9xRGtrY09nb0lITWpzYjFGV1NMelVBN2NTZU1ueVVsZXVZZWpPQkZWdXhv?=
 =?utf-8?B?N1RvWWcrYjMyYnl1S3FIL0s4TFlHWHhlbVByOXQzdmRiQTNtSzUvczgwQVA1?=
 =?utf-8?B?WVUvcWxHNUZUclZndUhrTExYNW1MeThXZVJKUCs2VVgybTBPOEI3SmRTbE51?=
 =?utf-8?B?c2podFhlSVExMGplYTFaZEdJdk8xa3RCY0Y1QnIyMENXa2NpMnZJZzE5MFFO?=
 =?utf-8?B?ZEYvYzk5bjJwS0JRcWlMWHpSb21NRUFadloxYytLdHF5RlFqUVpjWHZzOERG?=
 =?utf-8?B?NHdlb0hPVTU4d0Naa21Dc2E5TENsU2hqUWhoOFVEV0tYa0ttK2hUWlMwREkx?=
 =?utf-8?B?RUxSS2RRWk00THkyWGNvbEt2bzBvUFUzeEMwMy80bm42M0xQZ2svQkYyMGF3?=
 =?utf-8?B?bCtjdTdIRWhycEl4UGtLZEg5VzBBdEpFZ1pNQmw2K3pJYU1Yd28zbDR4ZVF4?=
 =?utf-8?B?eWVMV1hHWlQ0ZnlOc1NxQ2NQSTdwRXBENDRiVXlJd3Z4UlpOQmprT3lwRmlh?=
 =?utf-8?B?VFgzT09oZ1FtMnBqTXp3UlFMMTlWRHZ1dk8rMUh5SFZYNGVEK2N1VjdleWxB?=
 =?utf-8?B?bThweDN5elNGeTJFRWF6V2pBZmJrbFNWVGM2bmkrNjdUcGp6VHE3VnQ4dUp2?=
 =?utf-8?B?eUlnUXJ4Z1hjMzhCVlkzb0lRMHArRGd5bC9INkpsa1RwN2VMNjdScDhPeVZq?=
 =?utf-8?B?c2tTYy9CclNvRVc2WE9vc3Rlc0dwcURUQnBpTkx0QzMxNWlYQ3NrMmYrNzdm?=
 =?utf-8?B?eDFsNmpDbVIxalZhVnBSdEh5LzJ6Vk5zcURnM1NqYjIyckJBVE9FbGlXTmRI?=
 =?utf-8?B?d1RHQXZ5SUZjRUp6Z0ZXT0xWOTF3PT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a483586a-8b0b-485b-9fa2-08de64ae8d46
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 12:03:19.0113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LGE29w9HJCel/cjX8RZI1Dej2kmBU+0cXnNajIxO8Gu9Inyw6FidI66Y6nBWKv1tKoLh9u9rs7Bmcbjj1t0uQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR83MB0696
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16573-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kotaranov@microsoft.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59CA0F2353
X-Rspamd-Action: no action

PiANCj4gT24gV2VkLCBGZWIgMDQsIDIwMjYgYXQgMTA6Mjg6MjdBTSAtMDQwMCwgSmFzb24gR3Vu
dGhvcnBlIHdyb3RlOg0KPiA+IE9uIFdlZCwgRmViIDA0LCAyMDI2IGF0IDA1OjU4OjEzQU0gLTA4
MDAsIEtvbnN0YW50aW4gVGFyYW5vdiB3cm90ZToNCj4gPiA+IEZyb206IEtvbnN0YW50aW4gVGFy
YW5vdiA8a290YXJhbm92QG1pY3Jvc29mdC5jb20+DQo+ID4gPg0KPiA+ID4gSW1wbGVtZW50IHJl
dHVybmluZyB0byB1c2Vyc3BhY2UgYXBwbGljYXRpb25zIFBETnMgb2YgY3JlYXRlZCBQRHMuDQo+
ID4gPiBBbGxvdyB1c2VycyB0byByZXF1ZXN0IHNob3J0IFBETnMgd2hpY2ggYXJlIDE2IGJpdHMu
DQo+ID4NCj4gPiBXaHkgZG9lcyB1c2Vyc3BhY2UgZXZlciBuZWVkIHRvIHNlZSBhIFBETj8gUGxl
YXNlIGp1c3RpZnkgdGhhdCBpbiB0aGUNCj4gPiBjb21taXQgbWVzc2FnZQ0KPiANCj4gUHJvYmFi
bHkgZm9yIHRoZSBkZWJ1ZyBhbmQgd2UgaGF2ZSByZXN0cmFjayBmb3IgaXQuDQo+IA0KDQpTdXJl
LCBJIHdpbGwgYWRkIHRoZSBleHBsYW5hdGlvbiBpbiB2Mi4gT3ZlcmFsbCwgaXQgaXMgZm9yIGFw
cGxpY2F0aW9ucyB3b3JraW5nIG9uIHRvcCBvZiB0aGUgcmRtYS1jb3JlIChlLmcuLCBtYW5hIERQ
REspLg0KVGhlIHVzZS1jYXNlIGlzIHNpbWlsYXIgdG8gd2hhdCBtbHg0IGFuZCBtdGhjYSBoYXZl
IGZvciBhZGRyZXNzIHZlY3RvcnMgaW4gcmRtYS1jb3JlIGZvciBpc29sYXRpb24uDQpBcyB0aGUg
d2hvbGUgcHJvY2VzcyBvZiB3b3JraW5nIHdpdGggV1FzIGFuZCBDUXMgaXMgaW1wbGVtZW50ZWQg
aW4gdGhhdCBhcHBsaWNhdGlvbnMgKGUuZy4sIG1hbmEgRFBESyksIHRoZXkgbmVlZCB0byBrbm93
DQpQRE4gdG8gYnVpbGQgYSBjb3JyZWN0IHJlcXVlc3QuIFdoYXQgaXMgbW9yZSwgdGhlIEhXIGZv
bGtzIHB1dCBhIGxpbWl0IG9mIDE2IGJpdHMgdG8gdGhlIFBETiBmaWVsZCwgcmVxdWlyaW5nIGEg
ZmxhZyB0byBlbnN1cmUNCnRoYXQgd2UgZ2V0IGEgUEROIHRoYXQgZml0cyBpbnRvIHRoZSBmaWVs
ZC4NCg0KSSBob3BlIHRoYXQgaXQganVzdGlmaWVzIHRoZSBjaGFuZ2UgYXMgbW9zdCBpYiBwcm92
aWRlcnMgaGF2ZSBwZG4gaW4gdGhlIHVzZXItc3BhY2UuDQoNCi0gS29uc3RhbnRpbg0KDQo+IFRo
YW5rcw0KPiANCj4gPg0KPiA+IEphc29uDQo=

