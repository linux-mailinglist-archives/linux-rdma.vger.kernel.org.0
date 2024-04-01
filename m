Return-Path: <linux-rdma+bounces-1698-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9ED8939BC
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 11:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41AB81F21FD9
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 09:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E9510A03;
	Mon,  1 Apr 2024 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g2b8Xk2k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2138.outbound.protection.outlook.com [40.107.95.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C3DFBFD;
	Mon,  1 Apr 2024 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964874; cv=fail; b=HSc9OTRcM7xe9uIRE7HttPxh9dl0s7nWkcjzIoRNDFMU1KZNiVOowG0jnFgqoCPRoAVFV8etCoRPuIbGb7Rlcf/j7AN/6ZTq5w3ZGcRrrEPti68qUWRVKw1EdF06UkfjsxsbQEPj5B/Uf+tDS4wM3l2LKeUSSp1zQo6nITlqZSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964874; c=relaxed/simple;
	bh=qVjKNbAbE0z6yh9Sg9tnOqHpsL3x4q1g4gHoUF7xupQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u3lfRmcAKZqyv42aLpLfAZDMSpFugSIcryhQ7NCSji8OHCRQ4jLj0WekbNUckwFnG7crF0zkIX/KBqp3j9u35owypahKCK20zck7+cjJUweMlLANfxuC3hb41S7ISdnPRdGjvqKcYvHbGrsXn08RcTj3SrY2LeU/TGy3WJbhM+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g2b8Xk2k; arc=fail smtp.client-ip=40.107.95.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMIFLQCVxM7FMBTytmBcCPQX7e17f9awY7UtyixTmzHw4XkqGEW+jqQZt62XOEGT4r5zCmxN1q4ASKQw6tQYbIwBiJI/nFwJscGLnZGXMi/wnGCbtPY0GAu6JNuRJ2zb8MMyS6mV1TTUGjkcNcmsigG3i7xjgHX83I0guarv4EW+y45+xvNuklds7Pv53mImt8CIdAd8LFEc5/IEADeFTMD/oUGOFEEmJIhbCL9VVDbNH9MncGve8XWRHVTJwtpCl1LQoijXFZgBWFYNVzqXBP9DvNk5tyawjlYasZ/1CZQqC2mUQbXVXDHJEZoQ5sAbM2zELb+IXX6Xdiroz07gbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVjKNbAbE0z6yh9Sg9tnOqHpsL3x4q1g4gHoUF7xupQ=;
 b=LRKgDqQpOt/1M7Yqu/VWrLdfmIjnQKIy3IvIcTUL0Y6bWhlRB1cY8FHvhQ2844niaJGqkyIeieHM+yG7WYfN4IWI3eb6YHl23fxRrs7VtX4wbwawThpGFP1Jsb1ixXzcHDIeFGlIYU4VfHPt2X2SuP75z545+oW+UbzvaHHN10ptqikQ/CYg9ycGHSOzQXsXZA8Gj254OpFVHY+MTSOSBTtr4n2DqApCeqHCd9yUIu9qC+6+VNVGllZWmPx3VEeZgoZaX76sCDjvGn9YTjfBToGzqhtSzrwqlFVW4uBREVeU3A7YCotRewT7fi0BAxwY+Tj28rZrYTZzR3hwrwI+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVjKNbAbE0z6yh9Sg9tnOqHpsL3x4q1g4gHoUF7xupQ=;
 b=g2b8Xk2kg8ibJ4vcBg58iIgPCEDCqYPHdAc7/AWdsaC/aSTW/3F/dCZasVHS9tA7GckdQHV7MesWODswxdaDZXYtZ64w/IciytEl3VcSdIPzMYKNkMBbJqBmjfo1yXpzh/P3yq8zimQD9kK6FGVyC92VL5eSDVIU9H+wHQZ8uGb1QGwXTdymnTXt6To9MAelKUuoSHiyeS5bxiRGoQzhioJsTHTRUpvJvv98QMJ9G11ozQSaHx4dqnOHAkmN7J7RmFODjb2XrKuIqZIOO98vSy/uFeRjthEUHluEjfDukT3w5GbQZHAj8yV4Dr4Pcf3f9RPssdV210/lkLBnwfYckw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH7PR12MB5928.namprd12.prod.outlook.com (2603:10b6:510:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 09:47:49 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::6894:584f:c71c:9363]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::6894:584f:c71c:9363%3]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 09:47:49 +0000
From: Parav Pandit <parav@nvidia.com>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>,
	Shay Drori <shayd@nvidia.com>, Dan Jurgens <danielj@nvidia.com>, Dima Chumak
	<dchumak@nvidia.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>
Subject: RE: [net-next 2/2] mlx5/core: Support max_io_eqs for a function
Thread-Topic: [net-next 2/2] mlx5/core: Support max_io_eqs for a function
Thread-Index: AQHahBPVCPQAuDgxKE+YbEKJ5RMNW7FTIp6AgAAISgA=
Date: Mon, 1 Apr 2024 09:47:49 +0000
Message-ID:
 <PH0PR12MB54818883821AC50658B042E5DC3F2@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240401090531.574575-1-parav@nvidia.com>
 <20240401090531.574575-3-parav@nvidia.com>
 <CAH-L+nOY0A41GBrKw03a1ZLpkppGOKAfYb8VacQ=VyTUzsWdkQ@mail.gmail.com>
In-Reply-To:
 <CAH-L+nOY0A41GBrKw03a1ZLpkppGOKAfYb8VacQ=VyTUzsWdkQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB5928:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 31YQlfVgO3ryZfXAn+IqMCgWYRXbxXQSt12qU/ZtI0f0G+/trRRewAMCgSwBCeH35apqaUNGZd3MZdTgx0YnyhYmuwQ6hmI6+U0e2nVX1Zc+DnSET48Jk6gt6O7RcsOZQhPuRxVx5rbxVZQy69ZWJAe2r0K632jemz5eEHuxz7CMn11KwVe4o5pVTrFJlIJFaic52WNC8LVbrYb4hGCaPFPA8HzO7PBkI6Odfn7wbDiWro4wsfy0SLTeQ1K07K8QK1VRvVmz+46IbSh+QjPJyEBDNSVKcwiSf3sfbbDEkf3w7gBF90iTrVViOfJqUX5mzB49jgSfSuK3PE8mIHx2C+uIMaW+gNkm4NkntRy5jDjDETPiGsm3AlOqyHqiKGC6pgrbtPh0MnGHF0ALfq2LtRlFs5wneyl9yABrBIutPjyo/BGaKiNeUMGwT+ZJKNYgnp58/wUQVNLP+x+YTNtpd8UFWK2fQSPhyaExScNdgISLAZOCNy8GMeCmn/1vJD5f/jtqBhEJaTDORqAju/V7HX6IHryXKNq6VyHpkz+qFsUsIev44dzdetLeHFKTOBjd3fb/GQ2AZtpaa0UKCDbvJHwQEI7b79ABcBVvNJpbW3boL8qFKFmsmO+7UNk719nCisw+6pLy2cUGPjOqlFB4gbU5owh0ksBtXGpNixfcBrY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXpwN25GbWhub2dwS3lMeWlJSW1NZnZDUHBJZ3M2UFNEbm5JWFRGQy81NFd6?=
 =?utf-8?B?WWM4SzJVNktVMGE2MndtaXpxdFMxTkViT1pDandoVUpYUHR1M3RkWlAxVk5X?=
 =?utf-8?B?RzNoSG1NYjNoYUdrMUljUXBqVnhhREhzNlFoN2tMenloQmlqeVdnZWkrU0s3?=
 =?utf-8?B?N042ZU45R0ZwSHdUa0tWSTd6aEUyNStvTk5URUV1YnVjUjJsREhscUVYNzB0?=
 =?utf-8?B?aTVMcGJ0YTkzT2dWUTdneUVRd1lIV0xBc3l6U2tUV3RVeWYxOGJ5bithZW9w?=
 =?utf-8?B?bzFaZlZzNVp5a1ZtcXJyYldRQ0l6dFdGa0xjd1hzeUltcnlZTkpIMGNIQ0VH?=
 =?utf-8?B?OVhXbStiSzZyT2RZVkZqZG93NWdFWnJTd2xTQTU5dkF5blAxSWoyMHYrOUtp?=
 =?utf-8?B?WGk0QmN1QTZ1T05lcWtzenNnZGlSSmFVaGFQWEZaTjdDeEt4ZXgxUkxiWkcw?=
 =?utf-8?B?bTBlMTRrazl2MUdac3QyY1pRSFRIYjNlZU1HZEEzd3VnZzlQSmxPMHYzcTc2?=
 =?utf-8?B?UWI3a0p5ZkE0emoxQ3U5QllucDIyeWhmdGtPY0QzMW90ZnZaNy9CNlBqZGdx?=
 =?utf-8?B?WTgxd2RPcnBiM1Y4eWkvUWVEQ3FjU1p0YmZuRDZIMW9sUnR4NldkSXpNeUJ4?=
 =?utf-8?B?SExTbTIzMkt1czEwc01YVjJLRUhLa3ZZWThXL1hzMWRSVnNjWnEwRnRyTURH?=
 =?utf-8?B?cFllTGs0czJHNXQ4SXNKSW9rMjFPblFYZVRnS3Evc0lQczU1bXZZaEYzOUpG?=
 =?utf-8?B?em1HVHlYTnNsZzV3T1BadEVvaVJ1Yy9ENUVZZDNFemlhbzNtMjdsU1c0dXEx?=
 =?utf-8?B?OVcxOWhJVnZzY3hic3plclpJUVFmZnhXcVJiN2NubTEyMkdZY2ZEOFhsYmh0?=
 =?utf-8?B?RGthQmZrTWJ5Y3NndEttSkNINzJZcE5UQ2VMYXlTVWZMUjJsQkxKMEJFK282?=
 =?utf-8?B?MlJWc1VqVW9OMG0yYm8ySnF1MzlPMmswdmVQUzVjQ0hWeVJubndpL0xJeUU3?=
 =?utf-8?B?N3dpdjgyUnBseVI1NkY4K2JyQXdzMXFGSmFLbGNSVTZjalpnanprK2VtWTNR?=
 =?utf-8?B?VDlGelA4VkFickJVVjhYaEozdmNlVEJCbXUrTzNSaFRxZTI1a2RqZTUydUtm?=
 =?utf-8?B?U09QV2ZnNW02dXJrYVIydG8razV4VmFWYkdsY2NwT1RvYmx0RFlCKzRTSFlp?=
 =?utf-8?B?YXZKZU96a2lMdnY4UG03QWJzVTZKODdFWmd1VXhVKzVhN3NnN2craDFRVEo0?=
 =?utf-8?B?eE5Ia2VBNFNEdXFUL1FJbmNQNWg2eEN0OHFjRXdBQVJKOWtocE1uRnYranZW?=
 =?utf-8?B?cEplZUwxS2I3MitEc3dqazlEQlJES1NvKzFaNzhuUW45QVUvM3VPRkV5b0t5?=
 =?utf-8?B?czdGcU5Ec1F0d3grSDE4Q2VHS2MxTkxUeVBvdnJrZmdNbnp1cHZnbXhaVXdC?=
 =?utf-8?B?NEVuWkhxS3RPWTUwdCtQOTc3N3pqcWZtQkxjV2JBaldsQlc4YzVXZ001QWoz?=
 =?utf-8?B?THcxOVF4L04rMWtvaDJaWERPTXpZSHNQSmI2dTN2VkFIR0I3SThZT1NjRUVQ?=
 =?utf-8?B?bWR0TVJaKzVrRkJGcmdtQnBXZUViU01KeFZzMW4rRmwvYmYvYVFWd0Z3QkIw?=
 =?utf-8?B?R2JTWWJ4V1I1ODI0S3lqVUdYWm5BR0lNWHNNQWJaVHIyeUlHR1o5dmFpYVR5?=
 =?utf-8?B?YmphR3Z5NVBCelRYTEs4blZhSGh5RzU1ZW5MRzBhNlkrdmpGWjJWZWU5NGla?=
 =?utf-8?B?Z0lhZGNXM2pxVlpBYXhiTzlheFAyQVBXc1dFYVVkaE4xZjZISUZrTHBIS1BM?=
 =?utf-8?B?anppL2pLSXBJNWpVQ2RjUnZvV0d1eU45L3EwU1JHRDhNdVkyNWxuY1dDcnVH?=
 =?utf-8?B?MDBWMVlRTytxaEJKckRvMFczeU41MUFNM0pFOWY1NXp4bTVIYTBZcUxWc1B0?=
 =?utf-8?B?Rks5cEpIb3dPS0dOUk5ya01NNExvdzdyVmVOclBENFpRT0ZOSnlDSzdWT1NO?=
 =?utf-8?B?VW5XMi82eFNJd2szTDFEMzVTWlpBVUFWblc1cG05eXR1dDVoTWJObXVTUXQ1?=
 =?utf-8?B?WkVRaUExckl5R0VVMmwvL0JTVGxmYk5KZ01Ecjc0ZnFyTVlvMkc0cjFjZThM?=
 =?utf-8?Q?knpY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a06288-0f60-41ff-217a-08dc5230ca9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 09:47:49.0942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hp7trzhLfbBcp5yCARU/ysaPzabkyzDExxG8QE4rBOXkUr67HHajfVhHQO/mtqhp+tGLrKXug1bi/iY2PfiwyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5928

DQo+IEZyb206IEthbGVzaCBBbmFra3VyIFB1cmF5aWwgPGthbGVzaC1hbmFra3VyLnB1cmF5aWxA
YnJvYWRjb20uY29tPg0KPiBTZW50OiBNb25kYXksIEFwcmlsIDEsIDIwMjQgMjo0NyBQTQ0KPiAN
Cj4gT24gTW9uLCBBcHIgMSwgMjAyNCBhdCAyOjM24oCvUE0gUGFyYXYgUGFuZGl0IDxwYXJhdkBu
dmlkaWEuY29tPiB3cm90ZToNCj4gPg0KPiA+IEltcGxlbWVudCBnZXQgYW5kIHNldCBmb3IgdGhl
IG1heGltdW0gSU8gZXZlbnQgcXVldWVzIGZvciBTRiBhbmQgVkYuDQo+ID4gVGhpcyBlbmFibGVz
IGFkbWluaXN0cmF0b3Igb24gdGhlIGh5cGVydmlzb3IgdG8gY29udHJvbCB0aGUgbWF4aW11bQ0K
PiA+IElPIGV2ZW50IHF1ZXVlcyB3aGljaCBhcmUgdHlwaWNhbGx5IHVzZWQgdG8gZGVyaXZlIHRo
ZSBtYXhpbXVtIGFuZA0KPiA+IGRlZmF1bHQgbnVtYmVyIG9mIG5ldCBkZXZpY2UgY2hhbm5lbHMg
b3IgcmRtYSBkZXZpY2UgY29tcGxldGlvbiB2ZWN0b3JzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBKaXJp
IFBpcmtvIDxqaXJpQG52aWRpYS5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9tZWxsYW5veC9tbHg1
L2NvcmUvZXN3L2RldmxpbmtfcG9ydC5jICAgICB8ICAyICsNCj4gPiAgLi4uL25ldC9ldGhlcm5l
dC9tZWxsYW5veC9tbHg1L2NvcmUvZXN3aXRjaC5oIHwgIDcgKysNCj4gPiAgLi4uL21lbGxhbm94
L21seDUvY29yZS9lc3dpdGNoX29mZmxvYWRzLmMgICAgIHwgOTQgKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDEwMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2Vzdy9kZXZs
aW5rX3BvcnQuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9l
c3cvZGV2bGlua19wb3J0LmMNCj4gPiBpbmRleCBkOGU3MzljYmNiY2UuLjc2ZDFlZDkzYzc3MyAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUv
ZXN3L2RldmxpbmtfcG9ydC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFu
b3gvbWx4NS9jb3JlL2Vzdy9kZXZsaW5rX3BvcnQuYw0KPiA+IEBAIC05OCw2ICs5OCw4IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgZGV2bGlua19wb3J0X29wcw0KPiBtbHg1X2Vzd19wZl92Zl9kbF9w
b3J0X29wcyA9IHsNCj4gPiAgICAgICAgIC5wb3J0X2ZuX2lwc2VjX3BhY2tldF9nZXQgPSBtbHg1
X2RldmxpbmtfcG9ydF9mbl9pcHNlY19wYWNrZXRfZ2V0LA0KPiA+ICAgICAgICAgLnBvcnRfZm5f
aXBzZWNfcGFja2V0X3NldCA9IG1seDVfZGV2bGlua19wb3J0X2ZuX2lwc2VjX3BhY2tldF9zZXQs
DQo+ID4gICNlbmRpZiAvKiBDT05GSUdfWEZSTV9PRkZMT0FEICovDQo+ID4gKyAgICAgICAucG9y
dF9mbl9tYXhfaW9fZXFzX2dldCA9IG1seDVfZGV2bGlua19wb3J0X2ZuX21heF9pb19lcXNfZ2V0
LA0KPiA+ICsgICAgICAgLnBvcnRfZm5fbWF4X2lvX2Vxc19zZXQgPSBtbHg1X2RldmxpbmtfcG9y
dF9mbl9tYXhfaW9fZXFzX3NldCwNCj4gPiAgfTsNCj4gPg0KPiA+ICBzdGF0aWMgdm9pZCBtbHg1
X2Vzd19vZmZsb2Fkc19zZl9kZXZsaW5rX3BvcnRfYXR0cnNfc2V0KHN0cnVjdA0KPiBtbHg1X2Vz
d2l0Y2ggKmVzdywNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFu
b3gvbWx4NS9jb3JlL2Vzd2l0Y2guaA0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94
L21seDUvY29yZS9lc3dpdGNoLmgNCj4gPiBpbmRleCAzNDllMjhhNmRkOGQuLjUwY2UxZWEyMGRk
NCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2Nv
cmUvZXN3aXRjaC5oDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4
NS9jb3JlL2Vzd2l0Y2guaA0KPiA+IEBAIC01NzMsNiArNTczLDEzIEBAIGludCBtbHg1X2Rldmxp
bmtfcG9ydF9mbl9pcHNlY19wYWNrZXRfZ2V0KHN0cnVjdA0KPiBkZXZsaW5rX3BvcnQgKnBvcnQs
IGJvb2wgKmlzX2VuDQo+ID4gIGludCBtbHg1X2RldmxpbmtfcG9ydF9mbl9pcHNlY19wYWNrZXRf
c2V0KHN0cnVjdCBkZXZsaW5rX3BvcnQgKnBvcnQsIGJvb2wNCj4gZW5hYmxlLA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBuZXRsaW5rX2V4dF9h
Y2sgKmV4dGFjayk7DQo+ID4gICNlbmRpZiAvKiBDT05GSUdfWEZSTV9PRkZMT0FEICovDQo+ID4g
K2ludCBtbHg1X2RldmxpbmtfcG9ydF9mbl9tYXhfaW9fZXFzX2dldChzdHJ1Y3QgZGV2bGlua19w
b3J0ICpwb3J0LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
MzIgKm1heF9pb19lcXMsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHN0cnVjdCBuZXRsaW5rX2V4dF9hY2sgKmV4dGFjayk7DQo+ID4gK2ludCBtbHg1X2Rldmxp
bmtfcG9ydF9mbl9tYXhfaW9fZXFzX3NldChzdHJ1Y3QgZGV2bGlua19wb3J0ICpwb3J0LA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1MzIgbWF4X2lvX2VxcywN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IG5ldGxp
bmtfZXh0X2FjayAqZXh0YWNrKTsNCj4gPiArDQo+ID4gIHZvaWQgKm1seDVfZXN3aXRjaF9nZXRf
dXBsaW5rX3ByaXYoc3RydWN0IG1seDVfZXN3aXRjaCAqZXN3LCB1OA0KPiByZXBfdHlwZSk7DQo+
ID4NCj4gPiAgaW50IF9fbWx4NV9lc3dpdGNoX3NldF92cG9ydF92bGFuKHN0cnVjdCBtbHg1X2Vz
d2l0Y2ggKmVzdywNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFu
b3gvbWx4NS9jb3JlL2Vzd2l0Y2hfb2ZmbG9hZHMuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0
L21lbGxhbm94L21seDUvY29yZS9lc3dpdGNoX29mZmxvYWRzLmMNCj4gPiBpbmRleCBiYWFhZTYy
OGIwYTAuLjlkOWEwNmEyNWNhYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9tZWxsYW5veC9tbHg1L2NvcmUvZXN3aXRjaF9vZmZsb2Fkcy5jDQo+ID4gKysrIGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2Vzd2l0Y2hfb2ZmbG9hZHMuYw0KPiA+
IEBAIC02Niw2ICs2Niw4IEBADQo+ID4NCj4gPiAgI2RlZmluZSBNTFg1X0VTV19GVF9PRkZMT0FE
U19EUk9QX1JVTEUgKDEpDQo+ID4NCj4gPiArI2RlZmluZSBNTFg1X0VTV19NQVhfQ1RSTF9FUVMg
NA0KPiA+ICsNCj4gPiAgc3RhdGljIHN0cnVjdCBlc3dfdnBvcnRfdGJsX25hbWVzcGFjZSBtbHg1
X2Vzd192cG9ydF90YmxfbWlycm9yX25zID0gew0KPiA+ICAgICAgICAgLm1heF9mdGUgPSBNTFg1
X0VTV19WUE9SVF9UQkxfU0laRSwNCj4gPiAgICAgICAgIC5tYXhfbnVtX2dyb3VwcyA9IE1MWDVf
RVNXX1ZQT1JUX1RCTF9OVU1fR1JPVVBTLA0KPiA+IEBAIC00NTU3LDMgKzQ1NTksOTUgQEAgaW50
DQo+IG1seDVfZGV2bGlua19wb3J0X2ZuX2lwc2VjX3BhY2tldF9zZXQoc3RydWN0IGRldmxpbmtf
cG9ydCAqcG9ydCwNCj4gPiAgICAgICAgIHJldHVybiBlcnI7DQo+ID4gIH0NCj4gPiAgI2VuZGlm
IC8qIENPTkZJR19YRlJNX09GRkxPQUQgKi8NCj4gPiArDQo+ID4gK2ludCBtbHg1X2Rldmxpbmtf
cG9ydF9mbl9tYXhfaW9fZXFzX2dldChzdHJ1Y3QgZGV2bGlua19wb3J0ICpwb3J0LCB1MzINCj4g
Km1heF9pb19lcXMsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHN0cnVjdCBuZXRsaW5rX2V4dF9hY2sgKmV4dGFjaykNCj4gPiArew0KPiA+ICsgICAgICAgc3Ry
dWN0IG1seDVfZXN3aXRjaCAqZXN3ID0gbWx4NV9kZXZsaW5rX2Vzd2l0Y2hfbm9jaGVja19nZXQo
cG9ydC0NCj4gPmRldmxpbmspOw0KPiA+ICsgICAgICAgc3RydWN0IG1seDVfdnBvcnQgKnZwb3J0
ID0gbWx4NV9kZXZsaW5rX3BvcnRfdnBvcnRfZ2V0KHBvcnQpOw0KPiA+ICsgICAgICAgaW50IHF1
ZXJ5X291dF9zeiA9IE1MWDVfU1RfU1pfQllURVMocXVlcnlfaGNhX2NhcF9vdXQpOw0KPiA+ICsg
ICAgICAgdTE2IHZwb3J0X251bSA9IHZwb3J0LT52cG9ydDsNCj4gPiArICAgICAgIHZvaWQgKnF1
ZXJ5X2N0eDsNCj4gPiArICAgICAgIHZvaWQgKmhjYV9jYXBzOw0KPiA+ICsgICAgICAgdTMyIG1h
eF9lcXM7DQo+ID4gKyAgICAgICBpbnQgZXJyOw0KPiA+ICsNCj4gPiArICAgICAgIGlmICghTUxY
NV9DQVBfR0VOKGVzdy0+ZGV2LCB2aGNhX3Jlc291cmNlX21hbmFnZXIpKSB7DQo+ID4gKyAgICAg
ICAgICAgICAgIE5MX1NFVF9FUlJfTVNHX01PRChleHRhY2ssICJEZXZpY2UgZG9lc24ndCBzdXBw
b3J0IFZIQ0ENCj4gbWFuYWdlbWVudCIpOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVP
UE5PVFNVUFA7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgcXVlcnlfY3R4ID0g
a3phbGxvYyhxdWVyeV9vdXRfc3osIEdGUF9LRVJORUwpOw0KPiA+ICsgICAgICAgaWYgKCFxdWVy
eV9jdHgpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiAr
ICAgICAgIG11dGV4X2xvY2soJmVzdy0+c3RhdGVfbG9jayk7DQo+ID4gKyAgICAgICBlcnIgPSBt
bHg1X3Zwb3J0X2dldF9vdGhlcl9mdW5jX2NhcChlc3ctPmRldiwgdnBvcnRfbnVtLA0KPiBxdWVy
eV9jdHgsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBN
TFg1X0NBUF9HRU5FUkFMKTsNCj4gPiArICAgICAgIGlmIChlcnIpIHsNCj4gPiArICAgICAgICAg
ICAgICAgTkxfU0VUX0VSUl9NU0dfTU9EKGV4dGFjaywgIkZhaWxlZCBnZXR0aW5nIEhDQSBjYXBz
Iik7DQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+ICsgICAgICAgfQ0KPiA+ICsN
Cj4gPiArICAgICAgIGhjYV9jYXBzID0gTUxYNV9BRERSX09GKHF1ZXJ5X2hjYV9jYXBfb3V0LCBx
dWVyeV9jdHgsIGNhcGFiaWxpdHkpOw0KPiA+ICsgICAgICAgbWF4X2VxcyA9IE1MWDVfR0VUKGNt
ZF9oY2FfY2FwLCBoY2FfY2FwcywgbWF4X251bV9lcXMpOw0KPiA+ICsgICAgICAgaWYgKG1heF9l
cXMgPCBNTFg1X0VTV19NQVhfQ1RSTF9FUVMpDQo+ID4gKyAgICAgICAgICAgICAgICptYXhfaW9f
ZXFzID0gMDsNCj4gPiArICAgICAgIGVsc2UNCj4gPiArICAgICAgICAgICAgICAgKm1heF9pb19l
cXMgPSBtYXhfZXFzIC0gTUxYNV9FU1dfTUFYX0NUUkxfRVFTOw0KPiA+ICtvdXQ6DQo+IFtLYWxl
c2hdOiBNaXNzaW5nICIga2ZyZWUocXVlcnlfY3R4KTsiIGhlcmU/DQo+ID4gKyAgICAgICBtdXRl
eF91bmxvY2soJmVzdy0+c3RhdGVfbG9jayk7DQo+ID4gKyAgICAgICByZXR1cm4gMDsNCj4gW0th
bGVzaF0gInJldHVybiBlcnI7IiB0byBwcm9wYWdhdGUgdGhlIGVycm9yIGJhY2sgdG8gdGhlIGNh
bGxlcj8NCj4gPiArfQ0KQWNrLiBUaGFua3MgS2FsZXNoLiBGaXhpbmcgYm90aCB0aGUgY29tbWVu
dHMgaW4gdjEuDQo=

