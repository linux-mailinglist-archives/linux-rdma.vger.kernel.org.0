Return-Path: <linux-rdma+bounces-6713-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852ED9FB991
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 06:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900BC1884E0F
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 05:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A48A148832;
	Tue, 24 Dec 2024 05:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="JEzXqRjW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59482219FF;
	Tue, 24 Dec 2024 05:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735019377; cv=fail; b=Nkx9cjxBXAW6MGgrmT8mWeaUjJwrGBk0arsjEJFUc6NfweIO1swqNltu5s+wfUBMZ3mboWM6gNso6xM39jESujh33XLnGlizcm6TjV9JYqnen4ZVdLTX0o5/7CN0iTWkWOoxOUhytWhFXtOVGrE9m/+n4hEAA5BJA+DD2FLASAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735019377; c=relaxed/simple;
	bh=VIyWMyFmxOISwJvihMGZbpUi0m/+OFFfcUMg8DXAkD4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EOtAE0NPXrgeSKYkhbkNJygyq5BWV0u1SZi8T5GG3STGgaWb6QcnVBv3wVd2Cokt/qP3D7vJzBJ5q3kO31YL/5CqnJUEe8Ff89qcB/ZoHYuvL8dhQ17++/KtPmWsOmKsbnG8ZnHp/0as67tKyELkNk/qnAstKSpufj07521aFvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=JEzXqRjW; arc=fail smtp.client-ip=68.232.152.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1735019376; x=1766555376;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VIyWMyFmxOISwJvihMGZbpUi0m/+OFFfcUMg8DXAkD4=;
  b=JEzXqRjWsHxppEGbk0wNJhfgfjG3VCzo8aiwWkXi2iSg8xcIE3HlEjPu
   pk2vyegD0gpzbeTfVpCwUX83VI+B+n2Ko4khYGkS7ySxIt4aQbsGeNF4d
   InHb2JtjZmzVxRZTi1VuXI0ZWiZbq2jXOJ7gJitAf9b4VkLgguQE0fkHS
   wZ9102XGd7sr9hopbQ1jrl+nG/FZ/Uot4aPz5jl2GTsdmG/7MrVHiN8pG
   6nl03CYnlFIZM53THb2c6sXZQGmxyWaVihc/CA1Pa3W/vb32+Siw7pnyg
   KBLloFYMEH/kzQosv1AaQnNY14JGiO3R9I7P1P0yrLVnZrDY28ow37l9q
   Q==;
X-CSE-ConnectionGUID: K7R3yhmCSdKGJUszN0l0QA==
X-CSE-MsgGUID: H67wXutrRMu9jfDz20YQtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="52230296"
X-IronPort-AV: E=Sophos;i="6.12,259,1728918000"; 
   d="scan'208";a="52230296"
Received: from mail-japanwestazlp17011028.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.28])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 14:49:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvRzGXcTI6VQi/wsKA8C8QGqhDFirjmeWwDXreFBU4sgktY54j5XnnDkhiTDSy+1RHGXWwTBydgs//gqyrfITnQi6u59Ek3HQ68gDcAqGwYQxfsOnxOMtGZ6jvr5lKmHRAGcHcnSRv6XTTOzl7gwIyoHeaxFnznfCNBAxLgeguqIesPV5wqekYXqUNLli1Y8yEAu7NMvr+sXIuvtA1+HuovmW58LtcB/A7zELfVhjClr4PcicZM52eJbmONGBdfxX6m/e7eH/plh0i+hq5V+X9q/Jfau7SuJNR8/L5WVPS9O3zPlAYW7pg1HM2C+1VnSOyXXgEj1rOuDPwhZb7j25A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIyWMyFmxOISwJvihMGZbpUi0m/+OFFfcUMg8DXAkD4=;
 b=oKyEHsdaAF5UW0bZs80j4EzMmdRSkkeU+Yl+qDYKzoqwK4NKi1zVdao3EgaPa1EiJDSLKP9FZcWqp85yk9sai+Zhg/9li08nFJqqC8VpvI9qIEzDKkTfARK6TY7HPnXhYLC3Z7o8L7CCNTeAND6ANHAPavcdVzY2tB2mB+Fps/lRtuBJfLEIwB+HdK7rMUJuocgZlQXaKy2G+IVG/A5O9eZCwjJYPgX4dbeqQQ+ycXVKripf/tvRN0dcUdyJ+aUp/3pykdtoQvBf/EZKIR9eg+LaP0mwMy4T7vlsh8JgtM9jXJIlXx3beLBg8vEljW2MIj6gjC1306XOCrYpU/JP8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS9PR01MB12485.jpnprd01.prod.outlook.com (2603:1096:604:2f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.19; Tue, 24 Dec
 2024 05:49:23 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 05:49:23 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Jack Wang
	<jinpu.wang@ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Subject: Re: [PATCH blktests] tests/rnbd: Implement RNBD regression test
Thread-Topic: [PATCH blktests] tests/rnbd: Implement RNBD regression test
Thread-Index: AQHbVP3uy3dd1fBvhkublPURhXa2LbL0snSAgAAyuQA=
Date: Tue, 24 Dec 2024 05:49:23 +0000
Message-ID: <62c3b126-65b7-40ef-94e5-4758d5aa3cf3@fujitsu.com>
References: <20241223054535.295371-1-lizhijian@fujitsu.com>
 <h6qdtbdkdrpsfyk5ebn5fyv7jltmhdrtwgmwdzekfsh752gcrf@ezqvln7wnnr5>
In-Reply-To: <h6qdtbdkdrpsfyk5ebn5fyv7jltmhdrtwgmwdzekfsh752gcrf@ezqvln7wnnr5>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS9PR01MB12485:EE_
x-ms-office365-filtering-correlation-id: bcb8bcb1-b6dc-4ea6-914e-08dd23deb7ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eE44SDRIVEFXaWpUclZXMkNpRG0zaldydkFKRXlkTXdBQ3VmZDJwTGhnaEdJ?=
 =?utf-8?B?OFJGVUY5Tzl4YkxNRGcybkF3YlNxdnR1Ny9RSTlEY3hZVmNDMWR6TlFMcUxr?=
 =?utf-8?B?QmJoa2hGRldGSkM1Z0NVenRWcTVGajBQMUV0Nmx5WDdmd3E3SElnbDNlTnpH?=
 =?utf-8?B?WkRjdFFGeUV5S0U3S2tTc0xnZ0NrTkp5V0pKTitvVkttMmpMSlRPbXJOSW95?=
 =?utf-8?B?UVFRZFg3QmNWb05Fb2laU1JId0dFcm1UaEtnNmlxVkF2TzJGNFlDby80OThE?=
 =?utf-8?B?dzRRWnVDb3RuaGFNa0hkeHBlK0ZySE1nU2xwUW4zZ1ZxQzNWc0p4andaZFE3?=
 =?utf-8?B?UW1iT2I4OElBTW13c0ZZdUFXRk41V05yc0c1dUdub0pHTlhHUUVlQmthL1Zn?=
 =?utf-8?B?SmRUeTc3aHFqYzAza2Rld21VT2R1MlpQSWRkQkdvU3R2aFppMkZJRmlSRTE3?=
 =?utf-8?B?Q0hkOFQ4dmhVZDJMOWk3RjM5UEVsbFVYdHUzOUxBY0pZdU9CMER4Z3dIRGFk?=
 =?utf-8?B?VTloQ2hYYzhCWUVmemZhQTk1bnkyd0FMOWw3SVVFNFRCb1JjZFhVbllYOHZr?=
 =?utf-8?B?a1UrekowM0JzM3hJSEl1NWtSMXlaaEJmNzJXUW0rT2ZhWjBKQXN0VDlhUzQ1?=
 =?utf-8?B?eTg4NFYyb3JybnVuYXd3ckNLQVBVTTlCL00zd0lTR3lLYWFhQi9jNUllaFJJ?=
 =?utf-8?B?czR3TTFXODBDMDJXc0VTa3V5ckJxL21vQklxYWk0L2hUcnJ6NWlqSnlyM3Y3?=
 =?utf-8?B?WmdKOXJ0d0dwRy8wc2hWUWVLRXFXSHVSVVJ4Z2NTNTlCNmhjMmgwYmd0cHVZ?=
 =?utf-8?B?dDFKQUtRd0h6eGxTbXpuYzFHUVVUOHpmcWMwcDJVMHBoZzMyS0dWWnVxcDV6?=
 =?utf-8?B?V0xFTnRlcStZalVsZTNMdXN2dzNFRzhwTVNOUitlN1pRMFgxS01nWlYyWWVt?=
 =?utf-8?B?S2JPWlJHb2l1N1ZLU1hYajdPOSt4MklVbTJRc3BXbzVjdkZrMDVVMzRHekp3?=
 =?utf-8?B?MHQvQnplWUdZcG03UjB1V2lTMkdTa0FJQ1pabDVURUxGekpaTlJSMHJBQUVx?=
 =?utf-8?B?bWhnQkhRZmQxdXJCYk5XUjZMd3lZb2Z1MHFaVXNSVE0vdUJob2lZZEhCQkNv?=
 =?utf-8?B?bFV0VERhZEw5RnF2WnNjOWs3OGpaRHNCbkRyWXJMVC9BM1U5QmFTbThLQlgx?=
 =?utf-8?B?emdHakU5UjFNZEt3NW43cHBhamlpZTM2b2sycFRRQjdNZXJXdVpTVHJZSmpH?=
 =?utf-8?B?aHZRUzFkdlJmZ2lRZ1VVSGoyTms0Sk95M0hMR0NHWFd6WDdJT3NpM1NEdHlU?=
 =?utf-8?B?V1ZkaGw0RGtOdG9MYk54d1dHRG9KY2oyNEJrK1RQcXhSZFU2Q3J3MDdEZENp?=
 =?utf-8?B?TzRQS0V0SkFnQXhEMVdmTGVnc1VhQTlFWWpJd2JJVmxVdU15TjBENUVEemtR?=
 =?utf-8?B?aFhadmhzMnJNcytBVmRyS2lOT1c4U1Q3QVZNS0NHVHRiSlgwWHVFUHJ6cVQ1?=
 =?utf-8?B?aVRsR21KUTF0S215TXQ0TlhveTZxZU9jcDJqWnRkS0Y5eEtTL1RoZTJydTdP?=
 =?utf-8?B?Njl4ZngvYzJFTU9GdnF2ZTRoV2RucWk4VGtma0drVVJvdnRoTHhaS1VSYjBm?=
 =?utf-8?B?b2F1OXNuVUVQbTg1T0NGcCsxcC9WTzBCUkhqa0pZWVd3MWZYdldvdkR0R1lu?=
 =?utf-8?B?andMVS8wLzZHV2N3d3kyOG90M3NocEVjSWJEaTRoajdmc1JoUzBvaWw3RktV?=
 =?utf-8?B?OHA3bW1XRElCSU5yclRjNk82NHhDVXVSMjd1d3RvaFVDMTRIdnh6SFFoY3A1?=
 =?utf-8?B?TkFHSXBrQ1dJL2cySFBrd3JtVFZqeG9mSlZaVzFteEN1NkxvYVg5UExJWndF?=
 =?utf-8?B?ZjdFMzl3RmVQeVh2aUpUdXVDTEVuUk5VendDV0VOSkM5QWRaeENCNTluUUZt?=
 =?utf-8?B?cEc2eGJ0MkpHNnRjd0xpbzRoeUhQSnR5SGNrSUNiRjNqV0d3dzRhdHNtZGdu?=
 =?utf-8?B?RGw2NTFKTnNRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUtUdnJLejZtZ0w5MHpNQUhXQ0dkTUxOMlNnYkQrTWxpbEQ1b0F1ZFp3TFMz?=
 =?utf-8?B?Q21adGZCREdxOUdLdHNoY3gwajhnVDdTMUt1UUk4Vkg3cmlScjJzbjU3Qmta?=
 =?utf-8?B?M3JpejM1WWg1R3JxclF1emp4K1VNdEFQQzk5OVByS2x2bXlHQWI3YU5senMw?=
 =?utf-8?B?d3gyL0JBeWI3WUtXRFIzeG9lZm1FbWE0aHVpMDBkVDRzL1k5eGkxTnZTejdQ?=
 =?utf-8?B?cUFLcUZ5SjQ0ckVhdjlHTzBqMng4TTRaYktOTzlBWTl2Vmx4RWdla1J2L0JL?=
 =?utf-8?B?aUQyc2orbThWTzhRak1mQkJKY1pJZ2psZFJPUnN6MHNOakJHNVhWbmhxTjJw?=
 =?utf-8?B?S0hQbkFDWmQzZmxFZU5MNlhHRkxwOFBZYXpKSkY5WWNvOWsvZGRpUzF1OTlJ?=
 =?utf-8?B?NXBnVDlHaHFoM1lsdXhOMHl5QVgxRjVwbFFZZDhXNDd6bEI1THlRMnhJMUlH?=
 =?utf-8?B?Z2lkYXF5djV2Ky9Wc0RFVTQxelQxazlBc3JMYXNadDRrbWlqTmtaRE5TaTAy?=
 =?utf-8?B?RUovTUxKaTlCYTY1Z1ZkeDBycDdKblFGVWFmQ1pzRnFldDRaZDNIaWFYaDVi?=
 =?utf-8?B?d21zcXBEb01GbVFIK1NlTTg4K3pjWmZ2UE1FVndvTGhDUERVaWlGYXpLdC9F?=
 =?utf-8?B?T3BITnBrRjlYKzVxb0wxV1NMRTRJajJPblpBS09zNGZIQ3Q0aTdnU1cxRDJP?=
 =?utf-8?B?Q0xuVWRaL29IdjBvZzRWNmV2dU84UTJpRys2dFFJUExaTEhXVlk4R3FvV2Fm?=
 =?utf-8?B?L2hJYVdEYUpSc2tESWZhMFJlSjJmalNKZ3I3MnorSTdqN3RLbWZ3OVFvejJn?=
 =?utf-8?B?ZmFBdWloNHh6N0ZGN25DTFplSEdOUmlwZDFSRVlmekxCZ0xIMURaZ2ZlcGEx?=
 =?utf-8?B?cWZHQjhNcFg4UVdBb0NIb2xjSm9uS3EwemtPQmtsRnVrSXVkbW1PemFlRDBV?=
 =?utf-8?B?T2s0Wm5pV3RiR3YzYTFEQVFqOVl6MGJaUHdQb3ExVm41L3Y0K3RqemZFOWI1?=
 =?utf-8?B?NGJRK085QXVQZ3JtS1BHL2owYk5hcWtlTVNzTHJnNFVTbGZJTURHZ0h5RCt5?=
 =?utf-8?B?NnoxYno1SS9EaXh6YnRTV2YvNzZlU0puckhwMjFaeGg5OThrK3hZRHNhSkVW?=
 =?utf-8?B?THB6SVVDdnN6Mk4xZ2dFT3RtWDFiYW11ZFRZOFpEZ0k0bW5TdlJESmg3VVh1?=
 =?utf-8?B?ME5idXlRbzU2RFUwdnhJTUNiM2lOVHY3cEcvaG81TElJVkhSenZobHZOZzlJ?=
 =?utf-8?B?UWRiSVlXK1BQZWRqcTRLdGY3OEVDWFB0U0l2aWhadlpqVm9rbFpJanFPT2FT?=
 =?utf-8?B?bnY3Mk5rRjlTNzJwVXhhL3VYMXpSQzRwOHBtNW11UEdtbXFaM2NjT0xQYU9i?=
 =?utf-8?B?WXVDenRNUUVRNUJiY0NxMStsdXJqWTM5UnpYRFlkZnZ2cUM2SEhEU1ZwYW9F?=
 =?utf-8?B?SlhxR3N5SzUwYjhDNkZyNFB2RnMrNDFoVkdLaERBSlpiOExpeGxPM1UvWFYr?=
 =?utf-8?B?ZTVtN0U1cHA1RVJjOEpXK096dzZoalZlbXZKRVRvc0YvYU5vQW5DQ2huMUpL?=
 =?utf-8?B?Rzk0QXdLYS9HTW1ZQ1BidnpIMGJpQUEyeFlSOFRuOVJYU2RWSkdkSW1VMzhG?=
 =?utf-8?B?WmRNbkZLMUtEcXpWV3A5NmdOZkU5WkNsOVYydGdiWG1ab3dScHB3eVczRnhN?=
 =?utf-8?B?cXpIVEtLa1BxcGhsVTMweHJMZnNjWmt5eEJ3NUtRdDljMGZUY1FrUjZlYlJK?=
 =?utf-8?B?OWhTYytYTkI4KzNWSVY2U1U4ZmpjN2llanZWQzJ6SWxWc0ZTTkhnbGdiWGVN?=
 =?utf-8?B?V2JhNFV3YTcrKzZxVlJEQldjRUY4UllaMDVWemVzbURKeTEwUm1JYVFKVWhs?=
 =?utf-8?B?WjRhUU5yQm85bzQweEN0Qy9OZWNZVm1xUUtzTjAyZ3RZbExNV0dYV0FsOHZ1?=
 =?utf-8?B?R0R0TTNOTC9NUHdQWm9kRC9tSEI0QktiK1ZPeVVYYTYvZ3BqNzZFRWQ5RG54?=
 =?utf-8?B?RVhsQlhGQ1VHU3VjVy9rb1FneWJkcllBcW5CUjZNUXJ4cHNnaGNjeUZVVklL?=
 =?utf-8?B?RTZ6OVJIN1lyOE1vSk1QT2NJK29DVVB6di9DVkk2VGtoRGE3R3JWMVZPVzlY?=
 =?utf-8?B?ci96ckVabHRUUHcydDJPWTd2eXFmK0FFM3NPQVZnODB5RXhrOXJYVml6RFFD?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDDEC6C2DCAC644B82D97213FF851D7B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q40V/z9vCvtUNgYfedmqMd0+zsgPaq0qKZoxMWVJTt1eUNSWV3+TNC0467elyDk8K2TRXnI/vof9ASa/UCmKNLHxJnCWqwGmJZYpDmPcBlEM5sHhuuP95+tgZ8ln7ISeCd81ZjqomZ0Da8jRDaIRqFbFX7d1tdAzYlV27oNAKlEmsSQI+4Eb5EaA7dBurGxMFmP9JDzgUmX+8+niN46Ok385jEc81MulhCV9WfA+h29jhfGfNVZNbd0P78urivWUbqkJXFboYonGkFGujQJWgfZkTkPhxJJCprUd5OE7hRwZKg5L2LAnseEWgoK+wihKm0BIvsxCuq9mUiVrS9tDEOYqIfFN2ocOKSim0ncUzDzSzTHvL07bVKZd+3HxNxoYdZfZ3q11x5FgHlzS0yqw5PZye/33ltsqWtj5GZ348Q9IRoOkfzHyUjPpAq+zc/sVgINa6MHCa5lnEZAToZYYICEVlbh6MG+5b5MT1b9lXRGth0AZgijG3GxCseNdB5BiePBZ7XhN/uUU/RxyTcjVKnGXOCtgpsjaddH5rQwSGwLhFkio/P9sp1NnB731+WmJ2btABse20GgsGT2vNeLrdylCDyZps5A82saCsauJ4GitdMeva31ROyXTjL67WYZc
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb8bcb1-b6dc-4ea6-914e-08dd23deb7ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2024 05:49:23.1878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5lJTYUutKGVYvH8KLXi8ealvumWFHogC0JMb6hcEnaewkWd8EkabkHuIAZ3+nOGMvVMyAgUhwEkyBBezxxJ5Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12485

U2hpbmljaGlybywNCg0KDQpPbiAyNC8xMi8yMDI0IDEwOjQ3LCBTaGluaWNoaXJvIEthd2FzYWtp
IHdyb3RlOg0KPiBPbiBEZWMgMjMsIDIwMjQgLyAxMzo0NSwgTGkgWmhpamlhbiB3cm90ZToNCj4+
IFRoaXMgdGVzdCBjYXNlIGhhcyBiZWVuIGluIG15IHBvc3Nlc3Npb24gZm9yIHF1aXRlIHNvbWUg
dGltZS4NCj4+IEkgYW0gdXBzdHJlYW1pbmcgaXQgbm93IGJlY2F1c2UgaXQgaGFzIG9uY2UgYWdh
aW4gZGV0ZWN0ZWQgYSByZWdyZXNzaW9uIGluDQo+PiBhIHJlY2VudCBrZXJuZWwgcmVsZWFzZSBb
MV0uDQo+Pg0KPj4gSXQncyBqdXN0IHN0dXBpZCB0byBjb25uZWN0IGFuZCBkaXNjb25uZWN0IFJO
QkQgb24gbG9jYWxob3N0IGFuZCBleHBlY3QNCj4+IG5vIGRtZXNnIGV4Y2VwdGlvbnMsIHdpdGgg
c29tZSBhdHRlbXB0cyBhY3R1YWxseSBzdWNjZWVkaW5nLg0KPj4NCj4+IFBsZWFzZSBub3RlIHRo
YXQgY3VycmVudGx5LCBvbmx5IFJUUlMgb3ZlciBSWEUgaXMgc3VwcG9ydGVkLg0KPj4NCj4+IFsx
XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1yZG1hLzIwMjQxMjIzMDI1NzAwLjI5MjUz
Ni0xLWxpemhpamlhbkBmdWppdHN1LmNvbS8NCj4gDQo+IEhlbGxvIExpLCB0aGFuayB5b3UgZm9y
IHRoZSBwYXRjaC4gSSByYW4gdGhlIHRlc3QgY2FzZSB0aGF0IHRoaXMgcGF0Y2ggYWRkcyB3aXRo
DQo+IHRoZSBrZXJuZWwgdjYuMTMtcmM0IEtBU0FOIGVuYWJsZWQuIEkgb2JzZXJ2ZWQgIkJVRzog
S0FTQU46IHNsYWItdXNlLWFmdGVyLWZyZWUNCj4gaW4gX19saXN0X2FkZF92YWxpZF9vcl9yZXBv
cnQiLiBJIGNvbmZpcm1lZCB0aGF0IHlvdXIga2VybmVsIHBhdGNoIGF2b2lkcw0KPiB0aGUgbWVz
c2FnZS4gU28sIHRoZSBuZXcgYmxrdGVzdHMgdGVzdCBjYXNlIGNhdGNoZXMgYSBrZXJuZWwgQlVH
LiBHb29kLg0KDQpUaGFua3MgZm9yIHRoZSB0ZXN0aW5nDQoNCj4gDQo+IEhhdmluZyBzYWlkIHRo
YXQsIGV2ZW4gd2l0aCB0aGUga2VybmVsIGZpeCBwYXRjaCwgc3RpbGwgSSBvYnNlcnZlIHRoZSB0
ZXN0DQo+IGNhc2UgZmFpbHVyZSBpbiBteSBRRU1VIHRlc3QgZW52aXJvbm1lbnQuIFRoZSBjb3Vu
dCBqIGlzIGFsbW9zdCBhbHdheXMgemVyby4NCj4gSSBvbmNlIG9ic2VydmVkIHRoZSBjb3VudCBi
ZWNhbWUgMywgYnV0IGl0IGlzIGZhciBzbWFsbGVyIHRoYW4gdGhlIGNyaXRlcmlhIDEwLg0KPiBJ
IGd1ZXNzIHRlc3QgZW52aXJvbm1lbnQgcGVyZm9ybWFuY2UgZmFjdG9ycyBtaWdodCBhZmZlY3Qg
dGhlIHBhc3MvZmFpbCByZXN1bHRzLg0KPiBEbyB3ZSByZWFsbHkgbmVlZCB0byBjaGVjayB0aGUg
c3RhcnQvc3RvcCBzdWNjZXNzIHJhdGlvPyANCg0KR29vZCBxdWVzdGlvbg0KSSBvZnRlbiBvYnNl
cnZlZCB+NTAlIHN1Y2Nlc3MgaW4gbXkgUUVNVSBlbnZpcm9ubWVudCwgemVybyBzdWNjZXNzIGlz
IG5vdCBleHBlY3RlZCBJTU8uDQoNCg0KSSB0aGluayB0aGUgQlVHIGNhbiBiZQ0KPiBjYXVnaHQg
cmVnYXJkbGVzcyBvZiB0aGUgY2hlY2suDQo+IA0KDQpZZXMsIHRoaXMgaXMgdHJ1ZS4NCg0KDQo+
IEFsc28sIHBsZWFzZSBmaW5kIG15IG90aGVyIHJlaXZldyBjb21tZW50cyBpbiBsaW5lLg0KPiAN
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+
DQo+PiAtLS0NCj4+IENvcHkgdG8gdGhlIFJETUEvcnRycyBndXlzOg0KPj4NCj4+IENjOiBKYWNr
IFdhbmcgPGppbnB1LndhbmdAaW9ub3MuY29tPg0KPj4gQ2M6IEphc29uIEd1bnRob3JwZSA8amdn
QHppZXBlLmNhPg0KPj4gQ2M6IExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJuZWwub3JnPg0KPj4g
Q2M6ICJNZC4gSGFyaXMgSXFiYWwiIDxoYXJpcy5pcWJhbEBpb25vcy5jb20+DQo+PiAtLS0NCj4+
ICAgdGVzdHMvcm5iZC8wMDEgICAgIHwgMzcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
Pj4gICB0ZXN0cy9ybmJkLzAwMS5vdXQgfCAgMiArKw0KPj4gICB0ZXN0cy9ybmJkL3JjICAgICAg
fCA2MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAg
IDMgZmlsZXMgY2hhbmdlZCwgOTkgaW5zZXJ0aW9ucygrKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA3
NTUgdGVzdHMvcm5iZC8wMDENCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3JuYmQvMDAx
Lm91dA0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvcm5iZC9yYw0KPj4NCj4+IGRpZmYg
LS1naXQgYS90ZXN0cy9ybmJkLzAwMSBiL3Rlc3RzL3JuYmQvMDAxDQo+PiBuZXcgZmlsZSBtb2Rl
IDEwMDc1NQ0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi4yMjA0NjhmMGY1YjQNCj4+IC0tLSAvZGV2
L251bGwNCj4+ICsrKyBiL3Rlc3RzL3JuYmQvMDAxDQo+PiBAQCAtMCwwICsxLDM3IEBADQo+PiAr
IyEvYmluL2Jhc2gNCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMy4wKw0KPj4g
KyMgQ29weXJpZ2h0IDIwMjQsIEZ1aml0c3UNCj4+ICsjDQo+IA0KPiBJIHN1Z2dlc3QgdG8gZGVz
Y3JpYmUgc2hvcnRseSBoZXJlIHRoYXQgdGhpcyB0ZXN0IGNhbiBjYXRjaCB0aGUga2VybmVsDQo+
IHJlZ3Jlc3Npb24sIGluIHNhbWUgbWFubmVyIGFzIHRoZSBjb21taXQgbWVzc2FnZS4NCg0KT2ss
IEkgd2lsbCB1cGRhdGUgaXQuDQoNCg0KPiANCj4+ICsuIHRlc3RzL3JuYmQvcmMNCj4+ICsNCj4+
ICtERVNDUklQVElPTj0iU3RhcnQgU3RvcCBSTkJEIg0KPj4gK0NIRUNLX0RNRVNHPTENCj4gDQo+
IERvIHlvdSBleHBlY3QgdGhpcyB0ZXN0IGNvbXBsZXRlcyBxdWlja2x5IChhcm91bmQgMzAgc2Vj
b25kcyk/IElmIHNvLA0KPiBJIHN1Z2dlc3QgdG8gYWRkIFFVSUNLPTEgaGVyZS4NCg0KWWVzLCBR
VUlDSz0xIGlzIGZpbmUuKEl0IGZpbmlzaGVzIGluIDE1IHNlY29uZHMpDQoNCg0KPiANCj4+ICsN
Cj4+ICtyZXF1aXJlcygpIHsNCj4+ICsJX2hhdmVfcm5iZA0KPiANCj4gSSBzdWdnZXN0IHRvIGFk
ZCAiX2hhdmVfbG9vcCIgaGVyZS4NCg0KT2suDQoNCg0KPiANCj4+ICt9DQo+PiArDQo+PiArdGVz
dF9zdGFydF9zdG9wKCkNCj4+ICt7DQo+PiArCV9zZXR1cF9ybmJkIHx8IHJldHVybg0KPj4gKw0K
Pj4gKwlsb2NhbCBsb29wX2RldiBpIGoNCj4+ICsJbG9vcF9kZXY9IiQobG9zZXR1cCAtZikiDQo+
PiArDQo+PiArCWZvciAoKGk9MDtpPDEwMDtpKyspKQ0KPj4gKwlkbw0KPj4gKwkJX3N0YXJ0X3Ju
YmRfY2xpZW50ICIke2xvb3BfZGV2fSIgJj4vZGV2L251bGwgJiYNCj4+ICsJCV9zdG9wX3JuYmRf
Y2xpZW50ICY+L2Rldi9udWxsICYmICgoaisrKSk+PiArCWRvbmUNCj4+ICsNCj4+ICsJIyBXZSBl
eHBlY3QgYXQgbGVhc3QgMTAlIHN0YXJ0L3N0b3Agc3VjY2Vzc2Z1bGx5DQoNCkkgd2lsbCBjb25z
aWRlciB0aGUgcmF0aW8gYWdhaW4uDQoNCg0KDQo+PiArCWlmIFtbICRqIC1sdCAxMCBdXTsgdGhl
bg0KPj4gKwkJZWNobyAiRmFpbGVkOiAkai8kaSINCj4+ICsJZmkNCj4+ICt9DQo+PiArDQo+PiAr
dGVzdCgpIHsNCj4+ICsJZWNobyAiUnVubmluZyAke1RFU1RfTkFNRX0iDQo+PiArCXRlc3Rfc3Rh
cnRfc3RvcA0KPj4gKwllY2hvICJUZXN0IGNvbXBsZXRlIg0KPj4gK30NCj4+IGRpZmYgLS1naXQg
YS90ZXN0cy9ybmJkLzAwMS5vdXQgYi90ZXN0cy9ybmJkLzAwMS5vdXQNCj4+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLmMxZjk5ODBkMGY3Yg0KPj4gLS0tIC9k
ZXYvbnVsbA0KPj4gKysrIGIvdGVzdHMvcm5iZC8wMDEub3V0DQo+PiBAQCAtMCwwICsxLDIgQEAN
Cj4+ICtSdW5uaW5nIHJuYmQvMDAxDQo+PiArVGVzdCBjb21wbGV0ZQ0KPj4gZGlmZiAtLWdpdCBh
L3Rlc3RzL3JuYmQvcmMgYi90ZXN0cy9ybmJkL3JjDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi4xNDNiYTBiNTlmMzgNCj4+IC0tLSAvZGV2L251bGwNCj4+
ICsrKyBiL3Rlc3RzL3JuYmQvcmMNCj4+IEBAIC0wLDAgKzEsNjAgQEANCj4+ICsjIS9iaW4vYmFz
aA0KPj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0zLjArDQo+PiArIyBDb3B5cmln
aHQgMjAyNCwgRnVqaXRzdQ0KPj4gKyMNCj4+ICsjIFJOQkQgdGVzdHMuDQo+PiArDQo+PiArLiBj
b21tb24vcmMNCj4+ICsuIGNvbW1vbi9tdWx0aXBhdGgtb3Zlci1yZG1hDQo+PiArDQo+PiArX2hh
dmVfcm5iZCgpIHsNCj4+ICsJaWYgW1sgIiRVU0VfUlhFIiAhPSAxIF1dOyB0aGVuDQo+PiArCQlT
S0lQX1JFQVNPTlMrPSgiT25seSBVU0VfUlhFPTEgaXMgc3VwcG9ydGVkIikNCj4+ICsJCXJldHVy
biAxDQo+PiArCWZpDQo+PiArCV9oYXZlX2RyaXZlciByZG1hX3J4ZSB8fCByZXR1cm4NCj4+ICsJ
X2hhdmVfZHJpdmVyIHJuYmRfc2VydmVyIHx8IHJldHVybg0KPj4gKwlfaGF2ZV9kcml2ZXIgcm5i
ZF9jbGllbnQNCj4+ICt9DQo+PiArDQo+PiArX3NldHVwX3JuYmQoKSB7DQo+PiArCW1vZHByb2Jl
IC1xIHJuYmRfc2VydmVyDQo+PiArCW1vZHByb2JlIC1xIHJuYmRfY2xpZW50DQo+PiArCXN0YXJ0
X3NvZnRfcmRtYQ0KPiANCj4gSSB3YXMgbm90IGFibGUgdG8gZmluZCBzdG9wX3NvZnRfcmRtYSgp
IGluIHRoaXMgcGF0Y2guIEl0IG1pZ2h0IGJlIHRoZSBiZXR0ZXIgdG8NCj4gYWRkIF9jbGVhbnVw
X3JuYmQoKSB0byBjYWxsIHN0b3Bfc29mdF9yZG1hKCkuDQoNCkdvb2QgY2F0Y2gsIGl0IHNvdW5k
cyBnb29kIHRvIG1lLg0KDQoNCj4gDQo+PiArCWZvciBpIGluICQocmRtYV9uZXR3b3JrX2ludGVy
ZmFjZXMpDQo+PiArCWRvDQo+PiArCQlpcHY0X2FkZHI9JChnZXRfaXB2NF9hZGRyICIkaSIpDQo+
PiArCQlpZiBbWyAtbiAiJHtpcHY0X2FkZHJ9IiBdXTsgdGhlbg0KPj4gKwkJCWRlZl90cmFkZHI9
JHtpcHY0X2FkZHJ9DQo+PiArCQlmaQ0KPj4gKwlkb25lDQo+PiArfQ0KPj4gKw0KPj4gK19zdGFy
dF9ybmJkX2NsaWVudCgpIHsNCj4+ICsJbG9jYWwgYSBiDQo+PiArCWxvY2FsIGJsa2Rldj0kMQ0K
Pj4gKwlsb2NhbCBiZWZvcmUgYWZ0ZXINCj4+ICsNCj4+ICsJYmVmb3JlPSQobHMgLWQgL3N5cy9i
bG9jay9ybmJkKiAyPi9kZXYvbnVsbCkNCj4+ICsJaWYgISBlY2hvICJzZXNzbmFtZT1ibGt0ZXN0
IHBhdGg9aXA6JGRlZl90cmFkZHIgZGV2aWNlX3BhdGg9JGJsa2RldiIgPiAvc3lzL2RldmljZXMv
dmlydHVhbC9ybmJkLWNsaWVudC9jdGwvbWFwX2RldmljZTsgdGhlbg0KPj4gKwkJcmV0dXJuIDEN
Cj4+ICsJZmkNCj4+ICsNCj4+ICsJIyBSZXRyaWV2ZSB0aGUgbmV3bHkgYWRkZWQgcm5iZCBlbnRy
eQ0KPj4gKwlhZnRlcj0kKGxzIC1kIC9zeXMvYmxvY2svcm5iZCogMj4vZGV2L251bGwpDQo+PiAr
CWZvciBhIGluICRhZnRlcg0KPj4gKwlkbw0KPj4gKwkJW1sgLW4gIiRiZWZvcmUiIF1dIHx8IGJy
ZWFrDQo+PiArDQo+PiArCQlmb3IgYiBpbiAkYmVmb3JlDQo+PiArCQlkbw0KPj4gKwkJCVtbICIk
YSIgPSAiJGIiIF1dIHx8IGJyZWFrDQo+PiArCQlkb25lDQo+PiArCWRvbmUNCj4+ICsNCj4+ICsJ
cm5iZF9ub2RlPSRhDQo+IA0KPiBOaXQ6IHRoaXMgcm5iZF9ub2RlIGlzIGEgZ2xvYmFsIHZhcmlh
YmxlLiBUbyBjbGFyaWZ5IGl0LCBJIHN1Z2dlc3QgdG8gdXNlDQo+IGNhcGl0YWwgbGV0dGVycyBm
b3IgaXRzIG5hbWUgYW5kIGRlY2xhcmUgaXQgYXQgdGhlIGJlZ2lubmluZyBvZiB0aGlzIHNjcmlw
dA0KPiBmaWxlLCBsaWtlLA0KPiANCj4gZGVjbGFyZSBSTkJEX05PREUNCg0KU291bmRzIGdvb2Qu
DQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCj4gDQo+PiArfQ0KPj4gKw0KPj4gK19zdG9wX3JuYmRf
Y2xpZW50KCkgew0KPj4gKwllY2hvICJub3JtYWwiID4gIiRybmJkX25vZGUiL3JuYmQvdW5tYXBf
ZGV2aWNlDQo+PiArfQ0KPj4gLS0gDQo+PiAyLjQ3LjA=

