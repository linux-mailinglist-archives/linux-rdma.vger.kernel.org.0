Return-Path: <linux-rdma+bounces-10070-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF1FAABDE6
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 10:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B534E60ED
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 08:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBF7264FAA;
	Tue,  6 May 2025 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HZySGuFL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BA3264A9C;
	Tue,  6 May 2025 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746521681; cv=fail; b=Rnzc/gKucjPKalS2STYhCG9KCcYWLf+E3bb4kUr9B9VDmJ7qG6gKHUBnXP/uplSr1TGTrxlK6Uzn/m2pFR4PKEHmwn25UZWbr5PPG1oevtT5YpYWg0Bm4diHgaGZWyEi0DotZGw1qK7B3fLefJle9+p9lnzrPx1fQ70riMo1BdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746521681; c=relaxed/simple;
	bh=/ESV8584VZr+/IkXjTkDnhbMo1t395McgDRQH4z/0bI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=QQ+AygDGJeRh6oKr1Fbg6JsUQfTMI7NArW36z+cYjDUqnVNEgzHvVJXaHtuqSJa04K7A/ohKez1+/v9AfqRVIb6oiQpL2b6fzr5br80ZJXenOqYZWmYRduOfR9si2yLSD4lSkG9hpHaXHJOVSoaFTZ3B3P4CO3X3Vf4cuWLv8vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HZySGuFL; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5465gdSP006662;
	Tue, 6 May 2025 08:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/ESV85
	84VZr+/IkXjTkDnhbMo1t395McgDRQH4z/0bI=; b=HZySGuFLmKRhmRWGmQhWUK
	lr7ada3SGtwbuhfB+X7bnOAkkXofGkkF7YTbkeKQ1zXvxY9+N9y+2cbkhbpsU/vM
	Dbayk52HGbjfNKu+0SIOZTIGSEnMm70ZzBKs3G6+QtQeMJgpotNm2zcj6dp25l/C
	CpXK1ZDDxOLwWN8AZhOGkZZUfgyFM5WjVJjQjcfYF+S37Roa9ofANGwCNyjEIqYS
	IPG4bp2aQx7WFyhzlNtIpb7cIjUOXxwUdGC9HXoDhJWrVy24qm57FxZ9JcviAK4T
	9fsQnRaQ7lmeWchok8q9UjqntV8bruMTeniAG1zdNBCvXeUvKsIVauwvv8XxhLSQ
	==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fcgy0qe9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 08:54:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnCU9qWlx0sIHU7xRBsY+cpyt5VZILLInJWfkg/40D5I1guQKH6iIJD2hJCm7YpcqmcnHtmoSn4PFFyz2wTSfmoTaxyu0iz/j9Y7fm/kYUm8VTx5o6Jf5l3ggF6rPqIlWvtd56GlaLbDUP0XWMF/XqzJrhvZS1AK4gfjQjdWc6cr2Qhc4d3AIqfZg7n8UpJ5l1WcBK9ubr+pMqGQRu9JfByF9/ZrUm69Dhf6K9a2duCtfEw23QxSXDnbE8H5OjsKfjN3F5aL5WJCSVksaJBusHltyfHf+uxRfUZzHvemZT7lBMkeahc/qUTkSL0MJ1rCqWe/mOoucjkjDRmzjbsMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ESV8584VZr+/IkXjTkDnhbMo1t395McgDRQH4z/0bI=;
 b=KvE/mO4EOgTQS2Wi1Kw+4CTuZJHU87K+RBlOgzljyQ1JJFhSf6VoGCKFVXQ2sF1cgLE9NAXHD/YccseLqWTzizZeyARotCsqP0udqzpLEcBJs7J29pSW3kmftCM/tF2fI2TFJRmHm2YwQrzMM/2OqLhRuiYNWYTduyJmtwNrJLYB/3QOylngGt263+dK/4hxBl5R2Z/PRsggfEpY6iDcVI3wAF6hKtoPT45qj5jP84pU9HQt+Gpb3jBadcvDJF8brj4CtHsBHcw/7gi2+RdO2TxKNpo6YkOnmw1VDkL1BjWaFH+cd0tqiWby1Zu1AoZczQ2qt2nNuWihESYUYu2TTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from DM6PR15MB2522.namprd15.prod.outlook.com (2603:10b6:5:1a9::11)
 by SN7PR15MB6157.namprd15.prod.outlook.com (2603:10b6:806:2e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 08:54:20 +0000
Received: from DM6PR15MB2522.namprd15.prod.outlook.com
 ([fe80::75f3:e794:8dcf:7855]) by DM6PR15MB2522.namprd15.prod.outlook.com
 ([fe80::75f3:e794:8dcf:7855%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 08:54:20 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: "linux@treblig.org" <linux@treblig.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] RDMA/siw: Remove unused siw_mem_add
Thread-Index: AQHbvgEFJZoIr3B/Wk+mUMYRcFjvsLPFTGIg
Date: Tue, 6 May 2025 08:54:20 +0000
Message-ID:
 <DM6PR15MB25226B69D82A496491A9BDC499892@DM6PR15MB2522.namprd15.prod.outlook.com>
References: <20250505210226.88994-1-linux@treblig.org>
In-Reply-To: <20250505210226.88994-1-linux@treblig.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR15MB2522:EE_|SN7PR15MB6157:EE_
x-ms-office365-filtering-correlation-id: 07aca67b-7344-4cbb-77d7-08dd8c7b979a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YkxqcXB0ODVqdXJ1bzBjY0FUeTluZmVvendEKzhrQW1tOVIzdE1GOE9tRkNB?=
 =?utf-8?B?RXgwZ29LV1d2MFVUMHYvc2YvY2xrVHVZWnpzZHo5RVlrTGVHS0ZPSDR4Smtn?=
 =?utf-8?B?clQzZHB4KzJVSjRLNDFSOUJQbGVpT01YM3lTZEQweGl6N0EwVjhsRWZEUmo1?=
 =?utf-8?B?SW9yWnUzOG9Ub1ZFUDBGUXg2TEhuRy9abk9ZeFIrQVcvRDVGYVU2QXJ1b0Zu?=
 =?utf-8?B?WFZaSUhiWmpFczFubThvbXdnQS9oRndyZXlwTVdQUXRhSFZJM3Nsa1NUZ2JO?=
 =?utf-8?B?dnNFek1jY2pRdHYrSzJpNWhnTzcwS2F4akRnNVZ0SE15TEdFakVoVTFpWE5l?=
 =?utf-8?B?WnBNT01JbUVGRjJHWG5lVHZZOWo3OVZkczF6bEJneFhWdUFuVUMzbWJWL3FH?=
 =?utf-8?B?SUNyMkVUYjZEcW9LK1NEV01hRnZaVkE2NWJQdWE1bzlTQTVBcHBXaVVTSkpC?=
 =?utf-8?B?aVBLM1l6TUp1bHdHaVcrR3VQMzNKcW82UnZBdmxJWG9zSk94Nmp5Rld2bnlF?=
 =?utf-8?B?QWYwMUJidVp6NFo2K01rMGFuazFWaWdwbC8xY3RTOEFBSUVPN2ZiL0RrMUZS?=
 =?utf-8?B?WUlwM3VRRUFERU9rV29oOTluazU3ZXk5aWgxZ1d4eTAvZnZpZ0IxWS9TYjB2?=
 =?utf-8?B?VE03NzJVR3BFeU5oRE5RRTY5cWxvdmdRT096cVpNUlg5NWVUZmFlcUs3TlVN?=
 =?utf-8?B?aXNldS8waDFEU3VvSDZSNkcvc0d2S3U2R1ZObU4xQUM0QWtnaEI2bjRlZkJ6?=
 =?utf-8?B?ajFTd1FFb3Q4aWQ3cDdSWVBaanQ4emxiM2prY1JhSXl1bzFiQ0VON3BpdXhM?=
 =?utf-8?B?elFGeDU2MjBzTGRlVW1sQkhFM2FZcW9LUEMwY0lJMFdKaTQvdVdYMGw0dWVZ?=
 =?utf-8?B?cXpmVU5OY0JyczBHZHpCaHhrQkZGRFVPd3pncXkzZHNYLzBobUdDbzBpTldp?=
 =?utf-8?B?YUhESmhBempJM1BueTYwbCszakNpTjQzQXA1djV4K1YzUGhmUjhoazFsYW8w?=
 =?utf-8?B?dW5sL0VYdVZ6alBQOCtuR3FrUzFjOWFGTW1DTTM2djg3bm5udFQvQVRGZFh5?=
 =?utf-8?B?ZFpHVWlGM08zUkNERXo5Y0YwWFVZR081cDRlTnpkUkZROUtpNHpJN00rZkhY?=
 =?utf-8?B?aWE3ZUpnVU1VM1Z5ZWlzNXdoV2UzNm12cXRHeWsvd1hIWVJKaDVEVUN0OHM0?=
 =?utf-8?B?MEpaMWNvRi9RUkNBczRNU2FGSUdkMjFyNHMwL0UwUUo3WVJiNFJXOExCcWJ2?=
 =?utf-8?B?U3JuOEsxcXVaNzBQS01tVU8vbHk4NklKUG95bVI4ay9NbmhuWkpIR0FnaEhx?=
 =?utf-8?B?NG1DODk2d01qa3pIcnhoQmNPc3lHZXI2NXh3MjlmWU54V29wQ3I3Y1ZjcDhK?=
 =?utf-8?B?UmxncjRLeGRrQXF1S3V0bzBwbzJaR0VQV25tRkpWYitSQTJ6UVpEUDEvelRt?=
 =?utf-8?B?WFMxZnJqbjU1TXBaVC9aQUlQbTlWaTcwSFRMQ1BSL0FRaHVPUVNOL2ZNWDln?=
 =?utf-8?B?d2Vpa25WRjErbTNSdlpCaGFQYzFldXo4OXdlQ3dvRlF6dVNqbERpOXhDaWRQ?=
 =?utf-8?B?ZjBzQ2hnTjdybmhpNGE1RVkyaDE0S0tVYVNlMEhzSzZrK2VLTXl2U0FmcnpT?=
 =?utf-8?B?WE80Zi9zVVpjMGZOYTR4Q1ZWY09nVkpueE1ZL0ZJWExsa0phNWtaa25CS2lj?=
 =?utf-8?B?UEFob0xlUUw5NjE0SGlEbWY0TVZqVmdJWW9kQVhpTmRYQ21nVFlwQklldDhs?=
 =?utf-8?B?UEhzU0ZZekUvV2Q5T0xTdUdTcXhkZjBXN25LbHlZeWJuamNlckVJZFRMeVIx?=
 =?utf-8?B?RFNGN0t5dlplbWt6T254TnhvMENrSkJtRkREQXZyUHdOak1WNVl1RmwwMmRn?=
 =?utf-8?B?LzM0MDNLMW5NaW9lblpzRzhoUGtDcWgxcjZkSW1YalZxcy9uMTNzMWJ5ZGVT?=
 =?utf-8?B?Y2o4L3l4cGdDU21SVk9KVC9RY09hV2srMytudENNclcrMVVYOXU5WmJpMW40?=
 =?utf-8?B?eFJvOUhPWDFnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB2522.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFVSN2l3eU1seFk2N3AxcjVnQXdhb0JQd1cyazZkUjNYT1hSTWcrK2NtbkND?=
 =?utf-8?B?MHVSNlc3SjdKeitWcGpDcUlEaTJhVTlETU5oNmlESXZQbWVXcDJQSExPZ096?=
 =?utf-8?B?dUxkOWFMMkQ1azdZU3JITzd1akpEbmc4UXBaU2sxcnNlemV5R29LV2pkazcv?=
 =?utf-8?B?RkxyeUlCYXozK29sSnJzRUxzWDdnVXZJVURudE9FT255YkRVZHZnZE5Sd0lC?=
 =?utf-8?B?bklZdFVwcC9vNTJHNXliZWMvZklyVStnUk1FNXh3TW5QVGk3aHNqd05XR0hU?=
 =?utf-8?B?Vi9obnJ2cituVnk5d3FJQ2tkdS8zbmtWZ21ucUsrZ3RYNWczQUZnVzZHUlQv?=
 =?utf-8?B?UkQwVFJoZytVY1BmNkZEb1NPWjlIdk9LbXUwL1UrbWNMa3FQdlZXNE9mZzZJ?=
 =?utf-8?B?NGs2MFlWODV2MkFubTVOcTVkSFFac3lSTWwzYUFaYXNhbEpNRWVwTjFMTkg1?=
 =?utf-8?B?Qy9td21jblpuejdpQ3RUVE56ZmV2RjhKNitiWklIbXRuTDM1S1lpVnpkUjFu?=
 =?utf-8?B?dmIwRGltbk1IV2UrWXVDUVZOQkNOV28wRlViN0VkY0dhencxMmZRamlSMWQ2?=
 =?utf-8?B?SFNsQUY0QTVub09tMnd1b3JUc2pOelhpRkJiZklSbnZmK2xHNndkZnJDQ25n?=
 =?utf-8?B?Mk9QWjExYkkzUjFMWmNwNVVaSDdIcXhtL2V4TmxxS1lndkl1SHM3NGVaSy9p?=
 =?utf-8?B?dmpLNDhtTzVteDA0eVMxVHlIOFhVNldIczZGL2ZmSkJXWGlVcDNWWHc2OEhn?=
 =?utf-8?B?M1FjV2pxV2ZUamhOaFpDMHpML0RlenJ2RWF0cS9vdVpYS3p4SEZObUN2MkNh?=
 =?utf-8?B?UDh3MGYrYjEzb21MZFgwbExxalExc2xyamE5dlpNVzhjTFE3bWtXRHpBa1dC?=
 =?utf-8?B?aHJ4bzRWbXpKZE5hMWZWN3I0STdVSXNHdkd5WVV1TzRRcC85aG5za0RTejB6?=
 =?utf-8?B?R3RmOGZRNjc0RWp6SERDMXF4N0dGVnM4SkZMZ0VzNVBWU0pHOGs5YnJ2WXBZ?=
 =?utf-8?B?MTAzN1ZCY2trVTV0UG1FSlU5azRYeldLNVpKdGxjbFFDeTFsaC84ekdRbldZ?=
 =?utf-8?B?N0RRUlRWNTZRRUNWYXZrYXZLTmZ2OUxiUlZtS1N6SkMvbVpnblZNRWdjK0F1?=
 =?utf-8?B?Z015Mk1FdGZ6NEJycG1Lb3NRcW0wZnJpQXhHM2tWRjJDNzdQNjVzQ0NKaWFn?=
 =?utf-8?B?aEJja2lXKzFsaWFQVXVLTTEvZVN3MTFLTGJPR1E4ODhYeWV1YWREQnh1dnNr?=
 =?utf-8?B?VGJJV3pMWFkyUEd6Y0ZtWCtic1VxRit5bFp2NDdOeGZyQkNoMzU4dWlhZFVV?=
 =?utf-8?B?QXFTdm9iMTl1T1hHR3g0WTM1UU1MaHRuKzdyeWNvaWZhbXkxUzRQeE8ydG9V?=
 =?utf-8?B?TEFhZjFXcWIzdWZsVXo1cFk0RWFyaU1sWWI1Q0hkMGpRMG5abUJTNXJCdE5j?=
 =?utf-8?B?clVrZGxtSXlvVHJ0cDNKbnNnLzBGSlFsbjJJMXNWRmhua1Fhd2kvVmkvOEs2?=
 =?utf-8?B?MmtkZGlFQmUxczBCMWM1aW95Z3FVSUZxOTZhQkpRZEJuK2hxVDVldGJhKzhL?=
 =?utf-8?B?NGMzdWM5empNOThVZDJWTzZONmM0Ni9abzV0MG5FWFU1T3N2alJ6MU5WenBC?=
 =?utf-8?B?ZXR4dktoSmVBYXdIWksybGg2YjF6cXRKRjdndlRRU2Zjb2dFa2hPUE9aZDRK?=
 =?utf-8?B?c0Vid1k0NDladjRBdFZjUmU5TG40SzIzQWF6K21acER6T3RiOTdDc1hUQVp1?=
 =?utf-8?B?ZzRiK1NLbXY4dktpSkovSWllMm1ia29XZ3g4eVdUR1NaOHozUFl2VzBQZkpP?=
 =?utf-8?B?YWtialJ3YUUzcU1VMGVOVnM4ZVdjdDlQZzB5ellqYzF2a3l2Ykg3OFhMYXdw?=
 =?utf-8?B?WlRvVlFGN2lVaW13cnRWQjVWTkZYRTdXbm5YSVg2SGNXWFo1dWg0K01aS0N4?=
 =?utf-8?B?UzU5SUQvNFY2ZnQxVFNsaUhDMHVIS0xYUjFzM29mZkV6b0F3ZDY5Vy9oc2FE?=
 =?utf-8?B?MC8rcjJ4YkIrcC9VdWNaZm1OUEIvcGZhbnpMRVo0WC9tQkZvTmVHYWJuT3lK?=
 =?utf-8?B?bFNkZk93UFZ4bDFXcnpGbGowM2xnMFplNFF4Mm9vZFNQaXBlNDN4aVRSdDhG?=
 =?utf-8?B?SzdjM2lZWGpKT1ViNk5xOGNqYng4MFVrWmd5ZDR6RFFTWlcvLzZTdDd6enhV?=
 =?utf-8?Q?ahP29kefEbqT8mmpE6jhdok=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB2522.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07aca67b-7344-4cbb-77d7-08dd8c7b979a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 08:54:20.8509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +uHkQbAhYzI6QwhMgZHpYF+5h5iWfrjmHZuq+GfSKMbFRX6bdO8Zj6VpAEaZrwC2QlrHzQRFNu6QkpOlTR18sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB6157
X-Proofpoint-GUID: weOwqU7vw1lqPbk_jNghC-FxLgL2m1qe
X-Authority-Analysis: v=2.4 cv=Pa7/hjhd c=1 sm=1 tr=0 ts=6819ce42 cx=c_pps a=9T78G36u1E64A7MtQSounQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=3WJfbomfAAAA:8 a=VnNF1IyMAAAA:8 a=9jRdOu3wAAAA:8 a=VwQbUJbxAAAA:8 a=RXxvZOSptMuzDYM1ztQA:9 a=QEXdDO2ut3YA:10 a=1cNuO-ABBywtgFSQhe9S:22 a=ZE6KLimJVUuLrTuGpvhn:22 a=t8gNky6DTScCJD9b48VS:22
X-Proofpoint-ORIG-GUID: weOwqU7vw1lqPbk_jNghC-FxLgL2m1qe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA4MSBTYWx0ZWRfXwErlFhg5SIug 1LVXrQu+0KxjGvfqZON6KG7y3UsXk1SdQ6GYcAkaDPjvqg6PBVruCLti4/ULpQIXNy8Bw+RudTR 3VpJh0ngowOtOxdinCA0IAkqeMuJUiHkrCVA+5KNtgqbbiIEsM0upAP8nPHZcc4MMJf1QK3TMKy
 QZ3AFqKgxyge7HSkmnV3YInxRvWHZhKk8AuyMXuU6YNnE/QnqbEspexmz7QkhkeGt/NjA7YXQQr aLy17bjhpCkZtBmh+Hw8XaZNmTE4xkpppB4jY2H1o5KFphpmawERznjzCsMXyaxoZ/A4cD+uHL7 4xIdHxl55Gla/oRZfwTnn1JQfAnfGcOPMbyEoItHuf3g3kL9wvr2IY9+eIJFeDod43sHEbuYhpp
 rDjTkiyirV32aEZQaWVOyyQONh4QrWMwc1jaAgchzj4XV6pikHFHTIwY/TltED+wiSqkr/kr
Subject: RE:  [PATCH] RDMA/siw: Remove unused siw_mem_add
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060081

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXhAdHJlYmxpZy5v
cmcgPGxpbnV4QHRyZWJsaWcub3JnPg0KPiBTZW50OiBNb25kYXksIE1heSA1LCAyMDI1IDExOjAy
IFBNDQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT47IGpnZ0B6aWVw
ZS5jYTsgbGVvbkBrZXJuZWwub3JnDQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgRHIuIERhdmlkDQo+IEFsYW4gR2lsYmVydCA8
bGludXhAdHJlYmxpZy5vcmc+DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIXSBSRE1BL3Np
dzogUmVtb3ZlIHVudXNlZCBzaXdfbWVtX2FkZA0KPiANCj4gRnJvbTogIkRyLiBEYXZpZCBBbGFu
IEdpbGJlcnQiIDxsaW51eEB0cmVibGlnLm9yZz4NCj4gDQo+IHNpd19tZW1fYWRkKCkgd2FzIGFk
ZGVkIGluIDIwMTkgYnkNCj4gY29tbWl0IDIyNTEzMzRkY2FjOSAoInJkbWEvc2l3OiBhcHBsaWNh
dGlvbiBidWZmZXIgbWFuYWdlbWVudCIpDQo+IGJ1dCBoYXMgcmVtYWluZWQgdW51c2VkLg0KPiAN
Cj4gUmVtb3ZlIGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRHIuIERhdmlkIEFsYW4gR2lsYmVy
dCA8bGludXhAdHJlYmxpZy5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Np
dy9zaXdfbWVtLmMgfCAyNCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIGRyaXZlcnMvaW5m
aW5pYmFuZC9zdy9zaXcvc2l3X21lbS5oIHwgIDEgLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNSBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3
L3Npd19tZW0uYw0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X21lbS5jDQo+IGlu
ZGV4IGRjYjk2MzYwN2M4Yi4uYWM5NDM0NzRkNzk3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lu
ZmluaWJhbmQvc3cvc2l3L3Npd19tZW0uYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cv
c2l3L3Npd19tZW0uYw0KPiBAQCAtMTcsMzAgKzE3LDYgQEANCj4gIC8qIFN0YWcgbG9va3VwIGlz
IGJhc2VkIG9uIGl0cyBpbmRleCBwYXJ0IG9ubHkgKDI0IGJpdHMpLiAqLw0KPiAgI2RlZmluZSBT
SVdfU1RBR19NQVhfSU5ERVgJMHgwMGZmZmZmZg0KPiANCj4gLS8qDQo+IC0gKiBUaGUgY29kZSBh
dm9pZHMgc3BlY2lhbCBTdGFnIG9mIHplcm8gYW5kIHRyaWVzIHRvIHJhbmRvbWl6ZQ0KPiAtICog
U1RhZyB2YWx1ZXMgYmV0d2VlbiAxIGFuZCBTSVdfU1RBR19NQVhfSU5ERVguDQo+IC0gKi8NCj4g
LWludCBzaXdfbWVtX2FkZChzdHJ1Y3Qgc2l3X2RldmljZSAqc2Rldiwgc3RydWN0IHNpd19tZW0g
Km0pDQo+IC17DQo+IC0Jc3RydWN0IHhhX2xpbWl0IGxpbWl0ID0gWEFfTElNSVQoMSwgU0lXX1NU
QUdfTUFYX0lOREVYKTsNCj4gLQl1MzIgaWQsIG5leHQ7DQo+IC0NCj4gLQlnZXRfcmFuZG9tX2J5
dGVzKCZuZXh0LCA0KTsNCj4gLQluZXh0ICY9IFNJV19TVEFHX01BWF9JTkRFWDsNCj4gLQ0KPiAt
CWlmICh4YV9hbGxvY19jeWNsaWMoJnNkZXYtPm1lbV94YSwgJmlkLCBtLCBsaW1pdCwgJm5leHQs
DQo+IC0JICAgIEdGUF9LRVJORUwpIDwgMCkNCj4gLQkJcmV0dXJuIC1FTk9NRU07DQo+IC0NCj4g
LQkvKiBTZXQgdGhlIFNUYWcgaW5kZXggcGFydCAqLw0KPiAtCW0tPnN0YWcgPSBpZCA8PCA4Ow0K
PiAtDQo+IC0Jc2l3X2RiZ19tZW0obSwgIm5ldyBNRU0gb2JqZWN0XG4iKTsNCj4gLQ0KPiAtCXJl
dHVybiAwOw0KPiAtfQ0KPiAtDQo+ICAvKg0KPiAgICogc2l3X21lbV9pZDJvYmooKQ0KPiAgICoN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X21lbS5oDQo+IGIv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfbWVtLmgNCj4gaW5kZXggZTc0Y2ZjZDZkYmMx
Li44ZTc2OWQzMGUyYWMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcv
c2l3X21lbS5oDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X21lbS5oDQo+
IEBAIC0xMiw3ICsxMiw2IEBAIHZvaWQgc2l3X3VtZW1fcmVsZWFzZShzdHJ1Y3Qgc2l3X3VtZW0g
KnVtZW0pOw0KPiAgc3RydWN0IHNpd19wYmwgKnNpd19wYmxfYWxsb2ModTMyIG51bV9idWYpOw0K
PiAgZG1hX2FkZHJfdCBzaXdfcGJsX2dldF9idWZmZXIoc3RydWN0IHNpd19wYmwgKnBibCwgdTY0
IG9mZiwgaW50ICpsZW4sIGludA0KPiAqaWR4KTsNCj4gIHN0cnVjdCBzaXdfbWVtICpzaXdfbWVt
X2lkMm9iaihzdHJ1Y3Qgc2l3X2RldmljZSAqc2RldiwgaW50IHN0YWdfaW5kZXgpOw0KPiAtaW50
IHNpd19tZW1fYWRkKHN0cnVjdCBzaXdfZGV2aWNlICpzZGV2LCBzdHJ1Y3Qgc2l3X21lbSAqbSk7
DQo+ICBpbnQgc2l3X2ludmFsaWRhdGVfc3RhZyhzdHJ1Y3QgaWJfcGQgKnBkLCB1MzIgc3RhZyk7
DQo+ICBpbnQgc2l3X2NoZWNrX21lbShzdHJ1Y3QgaWJfcGQgKnBkLCBzdHJ1Y3Qgc2l3X21lbSAq
bWVtLCB1NjQgYWRkciwNCj4gIAkJICBlbnVtIGliX2FjY2Vzc19mbGFncyBwZXJtcywgaW50IGxl
bik7DQo+IC0tDQo+IDIuNDkuMA0KDQpUaGFua3MgRGF2aWQsIGdvb2QgY2F0Y2ghDQoNCkFja2Vk
LWJ5OiBCZXJuYXJkIE1ldHpsZXIgPGJtdEB6dXJpY2guaWJtLmNvbT4NCg==

