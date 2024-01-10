Return-Path: <linux-rdma+bounces-587-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC0E829208
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jan 2024 02:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81111F2507E
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jan 2024 01:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E271375;
	Wed, 10 Jan 2024 01:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Qs4KCv4i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D555381;
	Wed, 10 Jan 2024 01:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1704849746; x=1736385746;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p1cq66PxuZqqpI9Gm4Hh/28sdEYtxsxJOCvmxYzR2Qg=;
  b=Qs4KCv4ifoNufC6hbVm5wfKDApGa2fGkCvCo1iJG/2epFmF+MwaiprUt
   ga2qwxb5C4YsL7eNYIR6iaUBD6iKBxUWzpCm+0UWr35usyaN6AKZc8ueD
   Eql316DkgzADh36974BSo5XJXej6LlpOnLpEO0qm7iBhpe/aTEhBm0ij9
   QGEhCTFbStnZzeC8TbYUpUw4gd1/uO62FtG6OupnA8nAHhsf17wHmf5Wk
   mrd89m86rC+hWgyrl/XltNz7mIsJrZyqcAd47x1QNacaiNOai0nUOzUmC
   eCRvK6XJb0Kc4W+iyZZYg7QtHXk1E0zDsZTrMiF8NSwA/3gznuq9MABKY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="107299157"
X-IronPort-AV: E=Sophos;i="6.04,184,1695654000"; 
   d="scan'208";a="107299157"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 10:22:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpiC+dU7Qfk2kzV/VEPSf0iQgmA2maGGBA/UsMlmJl2yQDUoXAPnL7xPeC1gkOdIrCrNaJryFHfPG6HMuEFqDhvGzOguHCbkzVqaPyVcubB2BKt4/+8qiDEW9uRsQbLL+qyRsmaxRwl+uDOwVXwdsOfXy+6uCkPQc869Uhc9L8ZXT9cgbETniT3TQXr9O4JMU5cBJVk2PbCkK0PwAFBB2wZlP9LzL4fP5M3h3bdYWaBE1Wcin3GD9ZLp2fd9B92ltLC4/Oeex5jwRE0eVvIcr0zRbd4Qi2jxdzYcLhTdST5+oVrUXKMMwPvgWtOFMDs9YRlfWWgz5wOIo0QUbVRsng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1cq66PxuZqqpI9Gm4Hh/28sdEYtxsxJOCvmxYzR2Qg=;
 b=BLQK8uf9P8uOBRmC4Bsa1e/o5bgSG/XfuiIsTISMO1GlWJRu2ZVFqObZShzSJkFTHA1KgiU9j37UpOZ87dfJP+BdCTSl/6MCJky5jq8ZQonEb982dst2Lx3hOipdPxg8gQqmwzhiNdjDF/IzDSeUYV9mMi0vI1ZCecsTMNh50r31uME7Wt2TuKENVspiwDa9E4vpAQ+avwHO5n2hcQQFS/HPF8Vwam96jR66IcoiUpWLNAN/Wvi7LUBherpF+BbG6Mq3Q7dkQIJihM0UV617m0p+1whx+DPRS0z17AmAWjhhMwQDXM2yDjmCej+SQUkivHofbUmQ69OU2ykC6gpebA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYYPR01MB8216.jpnprd01.prod.outlook.com (2603:1096:400:111::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 01:22:12 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50%6]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 01:22:12 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Greg Sword <gregsword0@gmail.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"leon@kernel.org" <leon@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rpearsonhpe@gmail.com"
	<rpearsonhpe@gmail.com>
Subject: Re: [PATCH for-next v4 2/2] RDMA/rxe: Remove rxe_info from
 rxe_set_mtu
Thread-Topic: [PATCH for-next v4 2/2] RDMA/rxe: Remove rxe_info from
 rxe_set_mtu
Thread-Index: AQHaQtZ2mvX2SodGUEeuRZ4rIPppQ7DRNF0AgAEM1IA=
Date: Wed, 10 Jan 2024 01:22:12 +0000
Message-ID: <dbbd1887-af93-4323-ac27-f937bafc5756@fujitsu.com>
References: <20240109083253.3629967-1-lizhijian@fujitsu.com>
 <20240109083253.3629967-2-lizhijian@fujitsu.com>
 <CAEz=LcvphS6QECpHTFhrRoC=FcSbEU4j_XuqJF7ognjJu+uF6Q@mail.gmail.com>
In-Reply-To:
 <CAEz=LcvphS6QECpHTFhrRoC=FcSbEU4j_XuqJF7ognjJu+uF6Q@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYYPR01MB8216:EE_
x-ms-office365-filtering-correlation-id: 0c03f417-00a8-4477-301c-08dc117a92c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Xxmn4S7bNc7ldtwgm3aVH2ZPVtl00hf90NhFAQTz1qSa0flyp8FJE/5sa3F3ZCZRXHFvI++JPtOMym/JCx3EUI9ViQTbBwF3t2uM+U0g6w4Y0x7GDRt0Gs03NW445av1zIFgyF8c8LtY+L55PYBFb2wXYQHCyEvvKVoha0aWqec6mBNEVUzv3LWjiNSVvJ5eo6hOPnfPvQbfjmpLVzL+k1KUOZvGCo6MM5iaeC+b4DiiC0YxiNT+qEz6ZrPdw/31i6SzaLSM5dg8HFk7ObrINtqqlkP8OAyTjxZRRjZb7b28YZpzFewg6FWhhOPIggh65YwPL184kEizkt9MPLgmapioEqw1voUNAO/+UAuAmsab7/XbqCg+YROwhwqFHSZGgIQMPgvGuH9QPi1Uxr4NExOhXUmjOHpdoRSmxbjNrTb4R9vDE1nXRrXceEBybFoQAFAA34vYsE7J//9KQiRYhfnVpA40defCvkgX+6WvEW9//gp2oZzIg7QHp0A34Ng/i1h8yPUmaUGZldEJZZjFchRyRoqNuba5iVf+4brCfVCEtNOtFi2JkxhVS5+gNlkCYyseQIs7/v9e1lDcBobj3jzfkeBMQQn7p3jw8sM3L+4X3SMqAnJ3G+JJz14Cvf0lIM1VNE2su5O2DOI313z/xHPiglzi0YhW10tzFQNDBS2OCX7VF96ms7d5kPtxMDFyXnM0oS2a4f7M+UwkQSJncA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(136003)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(1590799021)(6512007)(6916009)(478600001)(71200400001)(66446008)(64756008)(66946007)(66556008)(66476007)(91956017)(54906003)(8676002)(8936002)(76116006)(316002)(6486002)(6506007)(53546011)(2616005)(26005)(83380400001)(2906002)(4326008)(5660300002)(41300700001)(38070700009)(36756003)(85182001)(38100700002)(82960400001)(122000001)(1580799018)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d2RkQjVQd2E2TlhpeCswS3FNMUxUd3dyMUhwUmx1QVFoSzJrSE9jU0tNTjRZ?=
 =?utf-8?B?YUN3a3Z5aXlLVnd3ZWFNWGRILzQyLzNMNzlhVGNmVFlYeG5uSjExWkJQb3JC?=
 =?utf-8?B?bUY1UzlMMzI3WExRVHRuZUpTWGk3aEZpYy9yQ21xODM1ZGdseEJGNFdUWngw?=
 =?utf-8?B?VHU1azZzWVg3eEZndGRKR2o4a1NUaGQ3S2NRMTU0UnNUV25KZS9qaGtaYzhI?=
 =?utf-8?B?NUdkbXlheXR0RVAva3RVQVBiY3ZoekN1VGFjdkhDSFhobHdRYkVvNk9keHdY?=
 =?utf-8?B?TUU0blZ6dFQ1VXdxcEdmcmtMM1Nja0drOXIzZExGblMyYWQvS3VWWW14QTNR?=
 =?utf-8?B?UElZTHBtT2dmcFFoYzBZR2dCK0RmUzR6Q1c5dnFnRHp5WURreHVQdFZtUjk3?=
 =?utf-8?B?dG5Ra05LSHFDdFpXdzhPQm1zMzhncE1UOWhKSi9NZS90Y2RycER4azl5bGVt?=
 =?utf-8?B?MHF0Y2tpelR6RlNsZy9iVXRraHlENU5oZHFCbDUwaTQyUE12K21jbUNzaURm?=
 =?utf-8?B?TUcyc25naW5pT3IvenhhTjVMSVhldHhjYlIzV1RJcEFadWQ0dGlObytOL05E?=
 =?utf-8?B?c1daN0U2VWN5bGo3QkxZSm14bWVQMHZEZFBmL1gyWHNEYWtiZXFvNlNwVENX?=
 =?utf-8?B?dDNseFk1V1lEVUU4VE42NnVvK0lkcUNXTVo1ajc4MktMSzFyVWRZOFlEUlQz?=
 =?utf-8?B?ZXpOMndFaDlOdk42a0E3Q2g4Ujllcno2ZmpiQ3JRZ2dWbDhYdmFURDRJREE4?=
 =?utf-8?B?NkMrUlV6SlpmQzZDK0xmVlNST0lSWTlsUFdPaU1uRS9WV3NxbHdRVWNNTHpG?=
 =?utf-8?B?SkdYQVVjdllmSGpGZnFnK1E1a0d3RGdpQjVrRTJwbzFtY3ZFSWhxMXJCR2t2?=
 =?utf-8?B?NzhxVUNzbVlQNkVrOFF2N0pBOWFOQTAzRUxxK2ZHeEFYMXNGYmdCRUFCWUxH?=
 =?utf-8?B?VTFJbjMwSitlYnlxSS9wdjRmNjRmdm9XTHFGYkM4VHJxQnNvbXNCMXIyeWw1?=
 =?utf-8?B?SHdBZ1hCanUzMTFITEliMDZyM2FtdDk2THJJYmxrMUltZU1WaS93NXBPYVho?=
 =?utf-8?B?SDZuTkxPL3gyVmJpUkYxbCtJNVVVclBzT05ycTdzMjFxZDVManZjK2pqcjRp?=
 =?utf-8?B?aDArUm9NYzZVUC9BeUhVdyszR0hPNEVrWnRpTVlhcDdCaGZ2YkxZY29jVk51?=
 =?utf-8?B?d3krd0dYOTBqZXNodHdUWkxwN2JLZmxPam1yUTZ2M0VkNmQ0RVc2WmxDUUhF?=
 =?utf-8?B?Z01tRFhBNDBqdWtLdDIzanhNU2VVQ0J2dGNEdVVWQVZ3c1VCWURkanRhMEhY?=
 =?utf-8?B?WGZVR3lNc3p3ZzhVTkd3VlRURlQ1bVNycHJ3TVdKd2ZlcmdTN2NXeDFLMHpQ?=
 =?utf-8?B?RXVrZjJyMU9WZEpGRmE3ODk4MXg3bWVkLytIRTJvaFlxVE95ekE3MFFqOC9X?=
 =?utf-8?B?aDNoVDc0M0RmWStjK0VEbTQrbEJuazRDSVg1ckVtK05IN0JINUdZNFRVWThI?=
 =?utf-8?B?STYwVU04MHNtNFc1RkxPWTB1aXZiQXA5WmcrcjZ1RXhDdG9ieDE2bXVrdWIy?=
 =?utf-8?B?bUprQW9TNU9nUU1lODdBY05MdmNza0NLU01hWVBaZXVnMWFGWEd2NjJJTjhN?=
 =?utf-8?B?NHNpQjVhSlVRbU5GSFFhRHlhRnJTT0l6MFo2c0VaeEVlV0tvaTFTaUZRMTlD?=
 =?utf-8?B?RFZWQTcxcUtzd3NqTFkrM3ZyZVBFK1pDV2ZwM3ZFalZ4VWs5Y2lESUd2SGtK?=
 =?utf-8?B?ZmhCYXh2ZENzSmtKSkZIL2tqNkdLdnRxbksraDF3UFhOdkY0UThwN1VYQytD?=
 =?utf-8?B?cktVbGdZK0N0dXNuZVZLcGJhemJ2VHBsMHhIN3YvLzFmVEVKY29PMXJoN2x6?=
 =?utf-8?B?TG5XWDM1ZFBNVzRibmZKSFpmWnJRdGpFM1JaQU5yNlpCYzNEVkR5WHRNWXhs?=
 =?utf-8?B?SUtmV0ZVR0RaWlMwQVgzeVJlZ01xUWJmVS9sUWRqdS9oeTNIZGRjTHl4QTY1?=
 =?utf-8?B?OWZxM28rYy9nelNvbFFzbldkVG01VWI3eUhUSk9FUWtXVVF4NFBVN21maVds?=
 =?utf-8?B?UkNNSVZ6azNtQlJtMFZCMEE1NVE5QWFwRUNZd0JiL21NU2hvckVsN2ZIRit3?=
 =?utf-8?B?amtyNUplemFJelB3R3hNclpNa3hyd2MxY2YwdW1MOWxuYVBKZ2tLRnowSzhr?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <632EAE14FDC453448290203FC95E6966@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YkOg6shPxZoHOEbpEcsR5iXccqAu7LXzg0g2owziFL8pgepq98entfPSSBEL2N/TsuYjO175R/m8T7sqYa2iP1om0ELjTuRPb5jJc8OQNd1mGTZfdKGvzVMxlpbG0zDJXAInATZFfK/s5jw9FwKpCPrFhe/QyMomRNgwKoZ37elHnOuvU6ly+bHz93FbtpmhbNPP/DZvwaMZnqM2Wll8pNyfQzc5HyKRmNgyIg7jnbt84J7GX6pc5rjCB/aIgUcUMcKQgnDOnnoqFVYuTTNncQkX37NoXvnMYW7w8ZYGP11LA6nbrkH0/D8NR2bu8WqCgPZlNaSS5ahvnE8k3ojme+nGB30OLesUlkYJI5AaZCBX1V7nwQi2U2dAaN8IPGEYGTh6y1VYJ2Q13u3bTyJVyAROqeUv5lAuwwByadJALkg55xUaZL8pW7XhgJqOC/Tx5cL8VdNpTSUnN//weFNAICdbrJz5oT9aIJ0UVMqJXY89o9P490inkhwtPmfm0t9/nNcBsXERN2+/8n25UpUs2r3k8So1jZXq5X+4JPUXEfkY2DUUFUNgZMTS3lqxhY2Eeob3cs5CJcD45H3UIMXZfBFfUFwmKB++jAxHRcOamh9IVwSCaEapHFJgL8pJxlo5
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c03f417-00a8-4477-301c-08dc117a92c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 01:22:12.5255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tGIx8B+tRmGTSBCOiSAzjwlM+B/NLlDJ3FDGno60x8m+PXmROvTH4UP7ycGrb0chXuNBlYFiauPfziiGdT+jNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8216

DQoNCk9uIDA5LzAxLzIwMjQgMTc6MjAsIEdyZWcgU3dvcmQgd3JvdGU6DQo+IE9uIFR1ZSwgSmFu
IDksIDIwMjQgYXQgNDo0MeKAr1BNIExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4g
d3JvdGU6DQo+Pg0KPj4gY29tbWl0IDlhYzAxZjQzNGExZSAoIlJETUEvcnhlOiBFeHRlbmQgZGJn
IGxvZyBtZXNzYWdlcyB0byBlcnIgYW5kIGluZm8iKQ0KPj4gbmV3bHkgYWRkZWQgdGhpcyBpbmZv
LiBCdXQgaXQgZGlkIG9ubHkgc2hvdyBudWxsIGRldmljZSB3aGVuDQo+PiB0aGUgcmRtYV9yeGUg
aXMgYmVpbmcgbG9hZGVkIGJlY2F1c2UgZGV2X25hbWUocnhlLT5pYl9kZXYtPmRldikNCj4+IGhh
cyBub3QgeWV0IGJlZW4gYXNzaWduZWQgYXQgdGhlIG1vbWVudDoNCj4+DQo+PiAiKG51bGwpOiBy
eGVfc2V0X210dTogU2V0IG10dSB0byAxMDI0Ig0KPj4NCj4+IFJlbW92ZSBpdCB0byBzaWxlbnQg
dGhpcyBtZXNzYWdlLCBjaGVjayB0aGUgbXR1IGZyb20gaXQgYmFja2VuZCBsaW5rDQo+PiBpbnN0
ZWFkIGlmIG5lZWRlZC4NCj4+DQo+PiBDQzogQm9iIFBlYXJzb24gPHJwZWFyc29uaHBlQGdtYWls
LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNv
bT4NCj4+IC0tLQ0KPj4gVjQ6IFJlbW92ZSBpdCByYXRoZXIgdGhhbiByZS1vcmRlciByeGVfc2V0
X210dSgpIGFuZCByeGVfcmVnaXN0ZXJfZGV2aWNlKCkNCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2lu
ZmluaWJhbmQvc3cvcnhlL3J4ZS5jIHwgMiAtLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxl
dGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGUuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlLmMNCj4+IGluZGV4IGEwODZkNTg4
ZTE1OS4uYWU0NjZlNzJmYzQzIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3
L3J4ZS9yeGUuYw0KPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGUuYw0KPj4g
QEAgLTE2MCw4ICsxNjAsNiBAQCB2b2lkIHJ4ZV9zZXRfbXR1KHN0cnVjdCByeGVfZGV2ICpyeGUs
IHVuc2lnbmVkIGludCBuZGV2X210dSkNCj4+DQo+PiAgICAgICAgICBwb3J0LT5hdHRyLmFjdGl2
ZV9tdHUgPSBtdHU7DQo+PiAgICAgICAgICBwb3J0LT5tdHVfY2FwID0gaWJfbXR1X2VudW1fdG9f
aW50KG10dSk7DQo+PiAtDQo+PiAtICAgICAgIHJ4ZV9pbmZvX2RldihyeGUsICJTZXQgbXR1IHRv
ICVkXG4iLCBwb3J0LT5tdHVfY2FwKTsNCj4gDQo+IEknZCBsaWtlIHRvIGtlZXAgdGhpcyBzdGF0
ZW1lbnQgc28gSSBjYW4gdGVsbCBpZiB0aGUgbXR1IHNldHVwIHdhcw0KPiBzdWNjZXNzZnVsIG9y
IG5vdC4NCg0KRHVyaW5nIHRoZSBtb2R1bGUgbG9hZGluZywgb25jZSBpdCdzIGxvYWRlZCBzdWNj
ZXNzZnVsbHksIHRoZSBtdHUgaXMgc2V0IGFzIHdlbGwuDQoNClRoZSBhbm90aGVyIGNhbGxlciBy
eGVfbm90aWZ5KCktPnJ4ZV9zZXRfbXR1KCkgYWxyZWFkeSBoYWQgaXRzIG93biBkYmcgbWVzc2Fn
ZSBmb3IgdGhpcywNCnBlb3BsZSBjYW4gZW5hYmxlIHRoZSBkYmcgaWYgbmVlZGVkLg0KDQpBbnl3
YXksIEknbSBvcGVuIHRvIHlvdXIgcG9pbnQuDQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0KPiAN
Cj4+ICAgfQ0KPj4NCj4+ICAgLyogY2FsbGVkIGJ5IGlmYyBsYXllciB0byBjcmVhdGUgbmV3IHJ4
ZSBkZXZpY2UuDQo+PiAtLQ0KPj4gMi4yOS4yDQo+Pg0KPj4=

