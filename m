Return-Path: <linux-rdma+bounces-2527-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 181808C8519
	for <lists+linux-rdma@lfdr.de>; Fri, 17 May 2024 12:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9DE285654
	for <lists+linux-rdma@lfdr.de>; Fri, 17 May 2024 10:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83BD3A8FF;
	Fri, 17 May 2024 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="dpQRPSMs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6D63A1C5
	for <linux-rdma@vger.kernel.org>; Fri, 17 May 2024 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715942937; cv=fail; b=p+L50ZE7NyjpgQdp9Bz1D6udrRUzWL/vPhGZIyAQdTeEqgeaQyJ6yCgvdnCkbjljhpQIaruAq62iTxKIGE8koDEugbPQbC24CyZMwj4eztj1/KNdAVuZv7kxdI4pvkSHs5qGCC2FQkN/IU+lrmMYTD32QcoCyZ+blzkU4xS2sAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715942937; c=relaxed/simple;
	bh=mQHyfyM5Wz24RCx9S45h1/tAs8sdMDK92shiSRv0Q8I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bY0oAPMtYh60UYRm6RB2sVc0HB01Wh0l88pwlj3lNXjvQ4o0O3Vz8x+Cj5H8Rv79kI3Q0Z3Su+OE6AqmZRR/hDnULYp4JEKTKE3jhLMqN+wFaEyvbIv8InUCgtx9oTOgsbtNk3rcIlxkWu6w07NyU4p4vf0kq82L9ujki/+A8NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=dpQRPSMs; arc=fail smtp.client-ip=68.232.159.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1715942934; x=1747478934;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mQHyfyM5Wz24RCx9S45h1/tAs8sdMDK92shiSRv0Q8I=;
  b=dpQRPSMswpYwvjqpN8GREWs5f0jkH7sx5kWPYOcg9q7FEaZQ3QVEqeVo
   0O0q5cK0onK1KLX+xkANzKuwhE7lUS+pHvYIPZeLlzzd7lpeZDMtxj4fm
   TJz1qrFvrb5Qxb6kcxmdXKXKZlAhkLQoKtQ3D+X19Ws7Ffik7rd7lnUyI
   JxiMZYF48Zmx9d+ck14kIzOIQEcAL1cWyuFyFVTphW4FN82wjR7JC0FLX
   +zdf4YjgwM9TrSgnvze+GTOio+lQSRmceqil7vtJciL4/7P5nekoRCobg
   XPdrgEH/Gtqua6sN1fIGiwKMnPSQtMq7lHfWfOJp/W+GEzjcZCaOxDwgQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="120053986"
X-IronPort-AV: E=Sophos;i="6.08,167,1712588400"; 
   d="scan'208";a="120053986"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 19:47:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJ5xuAruKJsiFLHmqhX+LIBcnV1tgCDN0vf4X+o6MYLxWXzr0l2S75FpB11WfOP6tRpmnn876DamG7xwMBCisMZ98k+z2yBb8PyAFZq1kK4/wc9j9u209evYWStG6z51nLdX3G08oJgR1Gk4GrOm1ItZW+1GQDGPy7HlURGKR8H3SFAVhcqYU7bPs1Q4SIzQbOlUtY3eJ7qBdEEtogsARxFH4D0ZFjG82TKEGcKFvlf3PZOcDn7f2tjYN9sFUwH2WopotF0R6NzIddGy8bfeEyYBin20LaUaP7mDBiG7ifsfap6qvvVIEsWbrZbgpLN/nBsmdkOyvwyqDm2fPpx10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQHyfyM5Wz24RCx9S45h1/tAs8sdMDK92shiSRv0Q8I=;
 b=A+TuYBiHyBC6fYUFkvXc/e3Nq8KAAUY41Wb+OzGxDUlsA7hF78jZH0fF9A55cvP9SWASy5pkRf/ucjIcDv5zA6gsNW7EMHFZEzhSs3wcacNxLrlLYvRsqyPDtSj4WncHBHw1o72anUyRJRqtjfph13CXmaQaJjuc17BRMJY+oxGqbIAAnSc2gQ92G29flKRAN46H6slQMgbbn4xfPbd8/SMQbh0n9Pb4gslD2y1nNOAZftLn8m9iilZcZ3J8DDaCDxpjoCgAmZdoR9/WQtdp5eNgT1a1mA8o2RWOMtOqnZ70etu5aIi6pCVwEkKhTK7dF8DoGRu/mGyPyTjFk63OGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYCPR01MB12122.jpnprd01.prod.outlook.com (2603:1096:400:43c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 10:47:39 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%6]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 10:47:38 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Honggang LI <honggangli@163.com>, "zyjzyj2000@gmail.com"
	<zyjzyj2000@gmail.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/rxe: Fix data copy for IB_SEND_INLINE
Thread-Topic: [PATCH] RDMA/rxe: Fix data copy for IB_SEND_INLINE
Thread-Index: AQHap3alkfyJZNtp8km6yMUvtyqJS7GaqHCAgACX5AA=
Date: Fri, 17 May 2024 10:47:37 +0000
Message-ID: <889b5c7a-2cab-47c2-99c6-33701f645b1d@fujitsu.com>
References: <20240516095052.542767-1-honggangli@163.com>
 <ef948dee-a65e-4c8c-a8ab-12cc06634b17@fujitsu.com>
In-Reply-To: <ef948dee-a65e-4c8c-a8ab-12cc06634b17@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYCPR01MB12122:EE_
x-ms-office365-filtering-correlation-id: 3bc719fc-2703-493f-2e7f-08dc765ec4bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|366007|1800799015|1580799018|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?R29TWEZhaUtDNnRqM25nbGpleUJ0QVdvTmxiQVB1RXZrNDA3WExrbXBsdkpq?=
 =?utf-8?B?NFgrOTUyWThvV3FDUndXaVdIMEpQbDV1WGFvVFlESlhnNnVQb2c5UmxFVzhw?=
 =?utf-8?B?MytScnIvYnBIZUdGWDBmRWl1OHU2bWtOVWFCZkJ5bndwWlZuT2dSeUtUY2Nr?=
 =?utf-8?B?ZnFmRFVCdHFTa1k2WENlS2JCdHZLQVRGejdSeEY5S2NaNlF5VVlkV2pNcUFr?=
 =?utf-8?B?WjBDSmh6ZGdLcVhUUVhjTjQ5T0E1R0QrUUpXTE9VZnE4akpqSis4bVA3VE5B?=
 =?utf-8?B?VGZ2NzU0TGtQTU5iN1FVd3duTWFuTktVWlJpKzRnRm1qb0tZQXlIMWpGMWFO?=
 =?utf-8?B?R21qYVNGVzZvWXlEM0VwOVFUUWRDc1paT3R5Y0FWVVB4NFhjNlozRE9BdUxI?=
 =?utf-8?B?OTUycmx0RjIxSlN2RmxlWmNJZmYvcndyNDAwclZQVm01Q3hJbTRmaGtDVjRy?=
 =?utf-8?B?TUp2OHkyamxlbHpwQXJoc1owOHROdkpCM3A4UTNkQUJoVXlsTjNYR3pKcGxz?=
 =?utf-8?B?YzVKQWFja3FDMVdBUDhmNEw1ZTRYMXVxcXkrZUlpVVR0OWhWUjVxOXhlNXFH?=
 =?utf-8?B?bklWL0tzaUgvWEtwZzVDWUtJNE16K0lZc3E5ZVViZy9pKysxVENOVG1WTndC?=
 =?utf-8?B?Si9OT05pRnhnZmNnZG1YbytqTXJVUTBNNDcwRXdVcFRpdERQZ1pXby9Yd1Rj?=
 =?utf-8?B?d0JhZjB6VGJEWGpDOVk3a0ZYZjgwWDhCa1NhVkhqVjVsdmxuODNaZGpxWWo3?=
 =?utf-8?B?RkdaODJBQWFpenRITzB1Skk4TmNxOWdvM2xLS0JJdVhIK1Z5U3ptT2I2Mjg0?=
 =?utf-8?B?aHRuSUVTbnVja1JTemVmdjdRWlNoQkdJQUVPY2dxbm85OUFMYjkyUWZhS1Ju?=
 =?utf-8?B?UWkvVzZJRWR0TS84dmRxS3F0Qy84WlQ4NzlFdld4VmE0T3NBcVFuWUxSamdU?=
 =?utf-8?B?d01UQ0w2SVlPem5JdGhuaGVHS0w5dG5OQ3d0N3FPem9jR1RTOEEvY1U4NlJK?=
 =?utf-8?B?N3B6L1lvY3hMVUNJTkhHL0VvNlFTZmp5dUE1K0QzbGdMeCttcXhTWHNRSlJM?=
 =?utf-8?B?ODM1OVQ2WHBIcUZqZmZUb3VaNG9kL2hrRFlrSkw5ZlkrZEF0aUZmNENQSDM5?=
 =?utf-8?B?QTg4UG8vWUxGY215b2xJQlFCTzBmcDVMMnN5NXVSeVBEM2drbGxOSjJITGtv?=
 =?utf-8?B?bTdGa2xoeXRWNGFjOE9zMmxFaFlNRXlPbHFzR2RYdGxKcTVvUE5FNG0rdHZU?=
 =?utf-8?B?WnUyWHkwSERkWnBxVXpmS0taeHZ0UHBxcDVmc01nY0dXNGplbSsvRllGRE1J?=
 =?utf-8?B?N21PQ0luSy9LNHNxOEFtaTIwR2VPdC9wZ2d1RG9vSHpPVU9JODlqZlVSdHlP?=
 =?utf-8?B?czdUNGdOajRDbXFZTnk2YXZLcEFYNW9CMHpVMXU2Z1NENXQ0aFBoR1lXNjNz?=
 =?utf-8?B?R0lCWms1NGR5VkNGY3lGejRIQzBnRzduZlJOTW9MUGc0UzFUZVQzUGFhZGRi?=
 =?utf-8?B?ZzEyUzRQclRaOHRhNTd6L2MwQ0JydHExQ3RLZkFNTExpTkdjYmpOblhtSXdD?=
 =?utf-8?B?Ry9KcHdCZE5QRVlxZCtLVzhZbU8wVC9vdkZTL3k4SXlLK0dIQkZjN0JHbUdN?=
 =?utf-8?B?bVl4dE1NQ3crWU0zVlFJSE9lMW1DTUhkK0lwb2dHWEVZRG0vOEk5UGR1TWh2?=
 =?utf-8?B?QitQbFVpclpXbko5a1dnY0ZhanNuSUZvZW5EUGxxeEw4SSsrOXNzN3FsWEZz?=
 =?utf-8?B?b2hHTUNjQWwvVllRd3Z4RmVhMXBjZHd2N0x0dm4wQmJSLytLanNhWitWR0VJ?=
 =?utf-8?Q?FcVDAS4VqKuSItfDg8ob6RgKHIs2xHSFbVzxQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3Z1UVA4SlRxcjg1SWtLYXJ4VUdzdmV4Ly90b1ZpMEI3LzVoVkJkU2FKY0cy?=
 =?utf-8?B?Ry93STUrOVJWcXFxNkMySGhoMHlIRVF4aUoxTkE4NHZYVkZzbUc3eWVzSkZx?=
 =?utf-8?B?eHVTWXZQbUhjVURhSDdXVmxhSmxmZGVuTWpwZUUxMldTd282RnpiZmNCKzlQ?=
 =?utf-8?B?eXJqeVZweGR5OUladHZ5MUlGMjVETGJzSzNmODNTbENpWi9yNHI0TjNXMy9B?=
 =?utf-8?B?TjE0U1JSeXJEenZnSkZ2bFVuL0JsdUF1MWF2cStIcVZkRkhJdnFUYXR6Sktq?=
 =?utf-8?B?REZLRWRTNnRhOWpEV3JIbkFRWkhLbVEyYjNrU0ZYaFFqVjdwUHBOL0VHallJ?=
 =?utf-8?B?a1ZoS2E3OGw3eDVMMG5Ra0l4Rk5PTEtHMmFWaCt1VTVIaWFNL2lOMlJGSDZP?=
 =?utf-8?B?NVRsV0FiaDltelgvNzFUNEFKK1UwWnNMVDlWckFRQVVIMHd6eVdsT00yVHZV?=
 =?utf-8?B?MU0wWU5wc3NlNmFzUjBLT2JXM0RkUS9SZEtFdDd0OTNwUStIZTgxcndXREZV?=
 =?utf-8?B?M0tmM2xvbjVjZ1NIT0FINnFDajhabk80SUs0VFh0YjB4QVNRMDl1cUlzd1I3?=
 =?utf-8?B?K2lKWTN0ZEFzd3Z6Z0w4ajZ4UFV6Sm1YWjlUeldlMmpuQmZHcVdOZlUvblg4?=
 =?utf-8?B?SjBRVDRqdkFwQWp5QlNENi94ekFEU3lDejRpQURRKytjYW9WNUdqUzlsalli?=
 =?utf-8?B?MjFGOW4rdHRLMkgySFoxVHdJYkxja3lGMDlITVh6dUFlTzlDdEpBU2x4K1Rr?=
 =?utf-8?B?Wlk1amRvL1JQR29xbXNJaVhTYU9BOHJqblVoOFBvWWF4MTJSSk9hbG90L1N5?=
 =?utf-8?B?RWlKZVE2SEIxbi9tREpiVjMrYWRzbXRuc0IyRkpoYmh0K3F3OENtM1dPelNz?=
 =?utf-8?B?N29IdkY1bEZtZGNzdzMwL0t2OUJxaGozcElBbDN6Q0RWQVNxSmltL3hTTm4x?=
 =?utf-8?B?UnprdkRFM1liK1dqdnh3VURtTGFqRWJYYk1kdHdJeERoUGhkYzFmMUw5SHZp?=
 =?utf-8?B?MHJVZitCUkgvOVZQRm9uNkZIYTJwREFRMzMwWTVJTWpmUTVRNm5RTGtmSExk?=
 =?utf-8?B?OVZNRVpsdGFVdmZ2RnVtQkxEOUNaMmwrWHJSdjlQc0pMK3JlbThZd3YzMmhV?=
 =?utf-8?B?NU1nV01IMDg3WEd3MjFMaE1DOVNnZWgrcnNuaW5Od2VscVgwQ04zWTZhWW16?=
 =?utf-8?B?Qy9ubnZ2OTBnWTJPWENCZTFSazlUd09GUEt4RkVUR21iSEE1YW5PQzVheHV4?=
 =?utf-8?B?a2lhSEErVDFpV3lWMTgrdWx6dkpUMEJUdTgxTUMwdGJmMlNRemZ5LzJ3RHo5?=
 =?utf-8?B?cDJkWEplUlZpWG1xOHZKQVVpbVMzNFQ2UzcrRGkydWtmdlNiZFJLOGwwQ0VZ?=
 =?utf-8?B?eFdEUjJvWFBIMm1aNTJkRXRZZGJjYUtLZU9GVVYwSyszblJmVVVQb1luNFd0?=
 =?utf-8?B?ZjI4b1E0NnFaREl0SEpDaUxORW1Ib0l0ZG9MOTJNZHhoMlQ1RFJPOWdXMzcv?=
 =?utf-8?B?ZDhYbEFuRGpDbFQvS3hjUjF5aHUyMmNuVk9XRkFZYjFnVCs1YVpuQVZSTXBy?=
 =?utf-8?B?K0FOWWwyMkxEYytwbDV0QS83bVBseTcra1pyL3V6Zk9ab1pwbERSaHBTSjJl?=
 =?utf-8?B?VkoxcGdPYWVaVEdjZW91WmtvOHBnRkRnSXBYY0x3OWFjMUVSUjBsSUhqRks0?=
 =?utf-8?B?WmRvYWp0VEF6SEdrZlJvNUM0L3ZjejhJbGl1N1RaeWNpVy9CbndlL1A0Q0Zr?=
 =?utf-8?B?K3crTC9ucFNWamRrSU5neUxZWEVRaWh4ZURNNlhkQmtZZVlaNzk1WlNTVzRj?=
 =?utf-8?B?d0toTzJ5NXJCY2ZBNGVBeWRhSlVWd0VuS2NZdUl2aGxQU2V6SnQyaVhNbyt2?=
 =?utf-8?B?TXZDTnRIS0xjWVBvK2djZ0ljSnp3dmxja3JFK2NSaEthZUE1N0k0OGpHcFlY?=
 =?utf-8?B?K1lnMGd1ZmZ5VmRmbUtlUW1qMUtQU2lwYk8zMnpFYVo3TGRPODRNWk1FS3VF?=
 =?utf-8?B?WisxV2I0SWZENG5Tbk05eTR0c09TbFBpd2w1b3VkeHU2Ym5Oa1lNZEE0Y0FD?=
 =?utf-8?B?UlJsWUVxR0lqRDkxNEsveFFCUmhFZ0hsN252TmdFZStCcTZFd0lSWkphcTNm?=
 =?utf-8?B?aVp0NGwydnJ4UkVybU1ncDBiSnQ1UlF3V3NVaDN4V28xVmFzZUtCK3pNVGF2?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40039CAB98A1294CB518BF42120421E3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OUlkOtMdUFDwd+iSfC4mGj45kQ2VO+GFqcYJMvbxF6Zb58SKdbBVFkRUzvS7tE4CsR6KIPET/QeoqUXYVO3CLlgrY54sJfuYzGdW2xA/fmvQv60rST5jL7l+zXLiYVunAIvePZnkWc0G9lbI56E/IfYpHuxmBwSfizUAc9ckN8Z+NQlP7x4nxRx9IWi1PnZS+sy+k6RcyYhs/fhjsP2lN9w+MBoDZaYY0UwZ/DAdlWV20v6xfAjBT896A184kokKlJP99M+UErd7PkbOhyrw4qa6ZxLLa6Kq8Pbrl4GQWMMLTtK5mRGCn4fqGM8cmydENmlpsKP0kTUZTuNwP1zVedT+eQApiuETgtr7hrddSMPOQnslAqIIuMsenMcVwxktr10J1p3bOZPmtdoCLKVm3zE2vzQzPfuflCWrsE/O6sopqQiojl1Ky3kKnR9cTTiBiD8+vjwTG3dE2dnR7YtRKuJi4caIopzP254bBMyUVp1BAfFl5JDS6vnibvUSuIiwciHkOXwHMXMfrnTQqrT+AIu2XHyVIqnwSYLBx2W4Z1LlBYASeenKx0W+eVVLBBBGOHnr/yyEYvHoKE0VgYKclw1E9tUTdnvrNHH523VeXPdQszHYi0tHiZ6aigGyJBFg
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc719fc-2703-493f-2e7f-08dc765ec4bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 10:47:37.8844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ri/ZIV/kghZiHBaqErx9EmVK7vazozdB/orGrrkKELhmQ9a0lnyqjCxwC0w3oFXbKXhwyza/mbv0MtiyzFzd+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12122

DQoNCk9uIDE3LzA1LzIwMjQgMDk6NDMsIFpoaWppYW4gTGkgKEZ1aml0c3UpIHdyb3RlOg0KPiAN
Cj4gDQo+IE9uIDE2LzA1LzIwMjQgMTc6NTAsIEhvbmdnYW5nIExJIHdyb3RlOg0KPj4gRm9yIFJE
TUEgU2VuZCBhbmQgV3JpdGUgd2l0aCBJQl9TRU5EX0lOTElORSwgdGhlIG1lbW9yeSBidWZmZXJz
DQo+PiBzcGVjaWZpZWQgaW4gc2dlIGxpc3Qgd2lsbCBiZSBwbGFjZWQgaW5saW5lIGluIHRoZSBT
ZW5kIFJlcXVlc3QuDQo+Pg0KPj4gVGhlIGRhdGEgc2hvdWxkIGJlIGNvcGllZCBieSBDUFUgZnJv
bSB0aGUgdmlydHVhbCBhZGRyZXNzZXMgb2YNCj4+IGNvcnJlc3BvbmRpbmcgc2dlIGxpc3QgRE1B
IGFkZHJlc3Nlcy4NCj4+DQo+PiBGaXhlczogOGQ3YzdjMGVlYjc0ICgiUkRNQTogQWRkIGliX3Zp
cnRfZG1hX3RvX3BhZ2UoKSIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBIb25nZ2FuZyBMSSA8aG9uZ2dh
bmdsaUAxNjMuY29tPg0KPiANCj4gR29vZCBjYXRjaC4NCj4gDQo+IFJldmlld2VkLWJ5OiBMaSBa
aGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+IA0KPiAoQlRXLCBEb2VzIGl0IG1lYW4g
Y3VycmVudCBweXZlcmIgdGVzdHMgaW4gcmRtYS1jb3JlIGhhdmUgbm90IGNvdmVyZWQgSUJfU0VO
RF9JTkxJTkUpDQoNCkF0IGEgZ2xhbmNlLCBjb3B5X2lubGluZV9kYXRhX3RvX3dxZSgpIHdpbGwg
b25seSBjYWxsZWQgZnJvbSB0aGUgVUxQLCBub3QgdGhlIHJkbWEtY29yZS4NCg0KDQoNCj4gDQo+
IA0KPj4gLS0tDQo+PiAgICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV92ZXJicy5jIHwg
MiArLQ0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3ZlcmJz
LmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV92ZXJicy5jDQo+PiBpbmRleCA2MTQ1
ODE5ODliMzguLmI5NGQwNWU5MTY3YSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlX3ZlcmJzLmMNCj4+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUv
cnhlX3ZlcmJzLmMNCj4+IEBAIC04MTIsNyArODEyLDcgQEAgc3RhdGljIHZvaWQgY29weV9pbmxp
bmVfZGF0YV90b193cWUoc3RydWN0IHJ4ZV9zZW5kX3dxZSAqd3FlLA0KPj4gICAgCWludCBpOw0K
Pj4gICAgDQo+PiAgICAJZm9yIChpID0gMDsgaSA8IGlid3ItPm51bV9zZ2U7IGkrKywgc2dlKysp
IHsNCj4+IC0JCW1lbWNweShwLCBpYl92aXJ0X2RtYV90b19wYWdlKHNnZS0+YWRkciksIHNnZS0+
bGVuZ3RoKTsNCj4+ICsJCW1lbWNweShwLCBpYl92aXJ0X2RtYV90b19wdHIoc2dlLT5hZGRyKSwg
c2dlLT5sZW5ndGgpOw0KPj4gICAgCQlwICs9IHNnZS0+bGVuZ3RoOw0KPj4gICAgCX0NCj4+ICAg
IH0=

