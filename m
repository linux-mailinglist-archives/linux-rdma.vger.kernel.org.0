Return-Path: <linux-rdma+bounces-16058-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGg6D4CFeGmqqgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16058-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 10:29:36 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B77991B82
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 10:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C28E3024A69
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 09:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3985D2DBF47;
	Tue, 27 Jan 2026 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="WL0L1kIZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010064.outbound.protection.outlook.com [52.101.229.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B86D2DB79C;
	Tue, 27 Jan 2026 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769506050; cv=fail; b=PhtKCw6TxLVSxBOlzUVa2GViJ9b9OVGtYBTjHTqpkCKHYUPMUXBctakmGrihV82A2CfH6X8c/Oo/6emlVcHoDcPGsvQ4/Q2eqAIgsw8tmkDb+TplI8YzmVtCi+CxkWgDwL0l6EOxKXZlvluxypVopmmPTcSicysLx9IQgOi75D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769506050; c=relaxed/simple;
	bh=UwZMVTYb5Tu6tsT7U3TncXsuMtqSd3Z+nAw+xQG3XMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M+tt56VZe8PFwUa84fwCKRnCvqikXysm45t5udr6VoG3aKH/QUIklCVdLavnRv6KauqGwITmqgzNpr3QWBPv0KiRph5qe8O3BlPyPA2hsci0m6D1JiDyPvs7fbkWnm+Nj9LotLyMm58S8lPe+kqfaWwnnCBwwcpnxl/eSskCF0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=WL0L1kIZ; arc=fail smtp.client-ip=52.101.229.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXgwUTc6jij2jkZwN2+Bom8heXI8WAdhylB87TBmeDoMMY7S5ywRAL2+7K3HoyVx9QzI1fTNTjaoHg7dkDD4PHTdTHXaw11KYYumTtIyAteEHZjNTZaKc4KngOth+34OX8gzD8hRFzEDd1UjQU8Hfi8chgmDhCqUtTmszWYyQzCUF70EL2rm+1ARsDSEkKONloJqkxAMEwM+yWBttQgJoszleDxjMXBZamzqaVULbBIucBoiLGu5rf2M8Nc/AVA89XLUZrZtstuPRk3Go4aQkEnPHLhFMDJR7cDsuMQPAd943i6mXQuYgH32d2f8CiQzSCEB4YMS0oVB4kkVQWb6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwZMVTYb5Tu6tsT7U3TncXsuMtqSd3Z+nAw+xQG3XMw=;
 b=ar8Zal5mcnBejteQsgRSLy43HFHf2VaExwZFui+xR/QCU0Hj9ytqNgx6YJ1V27nVw8iCq69WD66x5IG8HjOdNjgU7cUq7quhULB3t8wgMUH5zcMui6+GXgQsyffa0p9g11M4KstqEbJbsrOYzDpbdQbttF6mwxCIymmFw5iMgTL15rxEioqHL0PT1BwfYPCbhfatfdNwvG/A/S7LvlK/3ovY1PBuLrQGs496BuuRtJpusfh41Vozpfy5wM+6T8xewRu7CAqXh8kcu0GH8OszLx+pO7NNSR95vk2lYpehJ3NMGK9rvrMD/aByZVf+pY9S+Ooz3R5WwwKCw9VUXWiKqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwZMVTYb5Tu6tsT7U3TncXsuMtqSd3Z+nAw+xQG3XMw=;
 b=WL0L1kIZXSY+pZwD/24MW40L2Kj8T15NCeJP7MbKkrEYm9aotudyoHojf6Fphq803pzAbB4j5LT+CKfVbJezO4y16VqXL79JbYtcreunVtHLGqzreEg5uKka7fjG1Yz/swt+4AAUp3Ao9AJ0ewK/1N0Y7JNTb8LkDN4anOcVXV3iVEBHdbug1xTcJo1iaWTlDda7J7b6OosDdj2Qquu0CGx46eHXfGoHKicbOVKSXPKK0Jm21/sQG1tiUFRIvzO6zQB28qWu/I/uvvPL2aaC246H70idWWB6pgPL5xQW5Ih74n2HpiJ5FP3JH0+jUmvoYgaMPK0l/J5OUbCnb0KQ6g==
Received: from OS7PR01MB16842.jpnprd01.prod.outlook.com (2603:1096:604:41b::7)
 by TY4PR01MB14945.jpnprd01.prod.outlook.com (2603:1096:405:25f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 09:27:27 +0000
Received: from OS7PR01MB16842.jpnprd01.prod.outlook.com
 ([fe80::8c8e:d933:4018:fd36]) by OS7PR01MB16842.jpnprd01.prod.outlook.com
 ([fe80::8c8e:d933:4018:fd36%7]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 09:27:27 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Leon Romanovsky <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: Re: [PATCH] RDMA/rxe: Fix race condition in QP timer handlers
Thread-Topic: [PATCH] RDMA/rxe: Fix race condition in QP timer handlers
Thread-Index: AQHcieCqiMtlIurO70+LaRpL0O2s+7Vi9FMAgALWOAA=
Date: Tue, 27 Jan 2026 09:27:27 +0000
Message-ID: <02afa3a2-42d1-48c2-a75e-0555e8803d65@fujitsu.com>
References: <20260120074437.623018-1-lizhijian@fujitsu.com>
 <20260125140812.GE13967@unreal>
In-Reply-To: <20260125140812.GE13967@unreal>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB16842:EE_|TY4PR01MB14945:EE_
x-ms-office365-filtering-correlation-id: 6ab794d6-056e-4914-5288-08de5d864968
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?TmlBODRCdWFCUTBsS3FVVWY0VkV1WXV5YmczWVV3c0RCRk5XRTJMQ3lJMkRH?=
 =?utf-8?B?ZG56dHpFU09RcnlwWmE1OVY4Q3dYTkpqOEhWU2hHUWlKRkRFZ1dVZ3djcWpj?=
 =?utf-8?B?MTB6bFRGU2dpMm5lZmNDOEVGc082NXh6aEs2Y2ttOVZ3VlhpclNoamVzeGRK?=
 =?utf-8?B?N0U3WjA0NDd5SElvUHFHUUd4NlRBRUZDemJtOU84bUt1SGhHVCtaOHBweHpB?=
 =?utf-8?B?U3k5WDh3bHRxTHRTRXVOTDU2MHNUc3FraDZuTmFGKzV6TWRLUlBzdjFuYURw?=
 =?utf-8?B?S2QrZSt1YkdwbVpjM09mc0NONEpBSjJMTXhlQ2IxY2xDZGx6MEw4T0dsQVEx?=
 =?utf-8?B?MjFQeTdmZmJJTUxRN2twRkQyT09IS2laeUNOM0w0YWJma01Xc204VVJhTDdn?=
 =?utf-8?B?ekh2WXpiNjBkUmZOZ01pbEJaYnlBYmVDU0R6cm9zeVpUblcwcW5KMzUwbi80?=
 =?utf-8?B?cjEyOURlcWtubytDR3FxYnljWC9VWnU2ak12MHRyVVZBeWNnQUtHS3hYUzhM?=
 =?utf-8?B?SExDenhuM1hJRlR0NlJ5NHNYYXEwMkNqMVRCZCtsNm9NZGcyT3phOWhwM0xW?=
 =?utf-8?B?ZkRLWW4xYVJSenBLWFBtMUxjSDh5THhFanZyb2ZGc3A4eWlSYTdQU1YzQnVN?=
 =?utf-8?B?eGcxcGtYZVNoQVhWd1RSMzJVb1ZMdW5JTk40bUxHQU0xMVJUUEEwYVFiaXVP?=
 =?utf-8?B?a2pSa3Y1S0IwNTZkeUU2cnZKT05KMG1MSTV0dnN1QkEyTnZQSHA5WXo1Z21v?=
 =?utf-8?B?QzhCS0N6Uk5pLytJZ2hwdEJmdldoc2JyZUZleG1oUWthTDQ0NHJYb1BPVnEv?=
 =?utf-8?B?ZDRnYTBPZzZ2YUp5TXFLNmF3MHU1U0MwdFp0K01Tc3Zld3pFY0RVeHVHTEpp?=
 =?utf-8?B?cUROaGwxbWpnNmswNWRyV1FCdXdsSktCT2NGcDdJd2w1cytlTWR5R3J0OU5a?=
 =?utf-8?B?TytQWFNQa09XSU96T3BCc0dlbDRLVVh2NU8wd0k3MlZ5Ung0NFFJQk9IRHM2?=
 =?utf-8?B?Q2l0NXdnM1N3aVlXcUFNS3VZMno0amY1NS8vOVBTRzUxQjZZMGZ1M01pVml2?=
 =?utf-8?B?ZWpWVG8wd09WRU5HeHhGKzVPN2trYi9NRDBJdXVPYTN1RHNBbnk0c1JmVGhh?=
 =?utf-8?B?VTFvZGwxUXkxTEhYWWp2QUJNdkh1MHU4L2FLM0xPSVlJZHBTajVFZDhUMmlQ?=
 =?utf-8?B?bHdaMGNPTlVBMXptbU8zRlA5ckdVdjRLSitKSDVoVEZqK1NOVzExbEU5U0R1?=
 =?utf-8?B?ZHcxNUlGeDQ4ckJlUTRXT2JOcDVTbWsyZjR3c3Z2NithNUt4dXpjSzNDYzgv?=
 =?utf-8?B?NDRSUmhRb3VjRmc4TEZWY2VJUmMxTzE3NTNkMWhLcHg1SEl5dGxucXpTUS9C?=
 =?utf-8?B?OFBKOUJJVHFzZW05LzM3UjM4UEF0WThINzhwY05zZjJacFZKSjZ0dkVWTnd0?=
 =?utf-8?B?K2ZTZkl1VFB5K21OditTTU1aWE4walF6Wk51NDlEb1BzNllWVVBQVE9PT01k?=
 =?utf-8?B?SUhpallVbGt6QTlKZElvWVFmMHdYRUh4RkkwcWJKSitDUjZ3azlRaEpORmlu?=
 =?utf-8?B?Z3VuUUVPeFdtWGJKSWVoZzNQWG53czZlNEY2Ulozc3Y5dVd6MTgvTnRHZ05F?=
 =?utf-8?B?bUdkamx5bWlHTnJ2d1piSVJueEpiVUpXR0tYeG8yenl1MDNLMDhIcXQwWlBN?=
 =?utf-8?B?QVVOYmY2RitoTW5ML0ptOVB4d1A1NzBRUmlBdGJ3VHgzZm9EcURHdDBTanBB?=
 =?utf-8?B?MXBJcjE5YkNmMFVLQUdpNkFySEQwM1lCYlpsR2tiYlNhM1JvYnE0OTh4K2Vk?=
 =?utf-8?B?T3YzQ2c5ZG1iOHdvallkSmFxaGxrUzJva3BwZUszSDVKSGRwMjUzYS9reVVy?=
 =?utf-8?B?UlBYU2xnMlJ5dW9VYVpYanI0L09ERVUwdXphdmRsODBEUFk2N3pSSmYwTndj?=
 =?utf-8?B?TEdMTVp1SnY4OXdPSFd0a0MrYjB3NmdKNnJtU0NnL3FYd3FHUXloalBCNzhC?=
 =?utf-8?B?cCtOb2VnRWx2V3ZaZzlIbllVcURJRm1oSW0xTUVzQ3U1Ulp0Rjd3dGFMY1Q4?=
 =?utf-8?B?MExXVUtzbEpsUHhLdG4zVVhwNGlXdEdqcFFOMkhYNWh2WDBIK1F0T1Ezc0Nn?=
 =?utf-8?B?Zi9EeGFDVmVnanYvdWxOM056Y1J3LzZrYVNKSmZDVFduRWpHbFVudzRSUUM5?=
 =?utf-8?Q?wCVDOzDkpTqo0hoGOhMkLL7+9pESzCct2z8w8LarOuHD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB16842.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dUtKMkxBMGYwY1NwQ0RvR2ZSOWNGMFVEdmpJL3Q4QXU5UUZKd1Y3NHI2VVNm?=
 =?utf-8?B?QjR3VFVkOWJrWGtSWC9VWUFmbHUrY0lkQkRJQVJUUFJYYkQ5RWJ5TVFXTzIy?=
 =?utf-8?B?SEZRUFIybU96SUpMOCtuVk9pUUJBUU5LV1luOFFndjdHb0FUZ01JYWpnYmlr?=
 =?utf-8?B?SUdvWW15RUo1OHVFcU90V2V3SkYzMHNLQ1BIMHlaTzFxS2Y3MlM1UlpLWTZu?=
 =?utf-8?B?alFHZUE5T3BOL0xidU9MUTBLRjhPRHVkV2RKUTZmMEMzNGNJenNLWkZNWjJB?=
 =?utf-8?B?Qm5VWEFTdjdnU25oM29XZ2xDOCtDeExRa0N1Zm9nQ2xENlVtdzlrMEUvRW5i?=
 =?utf-8?B?N2lidWpabkRwM2ZaMjF6MWJuMWhQdDJSZjV3NDgxR2lETzFkY0VGd2x6TXAv?=
 =?utf-8?B?OFAxZXh6RElqclZQbm5PdTV1UExaT05NWlhCeFRXQWZ3bW9JRGs5TmQzL3NT?=
 =?utf-8?B?elBua0wxVW1VQ0lrN1Q0cWduZkVZMVE3VTBlMXRqem96c0dhT3lydHNieUFh?=
 =?utf-8?B?eHJGb3drV09lRk1jcFpRcDNZTXNDSEJtWUwwRHJqNGwrelRTSVVjRWdSTUpo?=
 =?utf-8?B?YVhVU3N6RG04TU5CelhZY05yZ3ZzTTIyQk84WEcxNDE3MkJTWnFmWXhsVjFE?=
 =?utf-8?B?SnlacnB4L2pqUlZjQWlRTDZNbHo1VlNwK3lyc25WVTE4KzhYcE1XL1pTb0Jj?=
 =?utf-8?B?b3VJdUF2RWlkR3JRL2FZUExMM3J4WFhWOEMvZGRKOVk0Qm9kdWhlRno2NUU0?=
 =?utf-8?B?czBRT01FbEI5R0JodmszTS82TkdLSktWd0ViMWRMZFM3ZzJkS1FNL0djVUpD?=
 =?utf-8?B?OUZaU29GUElGeXkyc1dFZ2xENmlLY3gxVmZFaTlxeXlQU0ltbWRuSHhUcCtS?=
 =?utf-8?B?NW1UdXBpZXY0V1diTi9wMUpMUjhYMEVpUk9TNTlvL0VlTG0wRmNpUlhTYWdj?=
 =?utf-8?B?OEQwRjRBSW1SeTd2VEVpSGhMMVhzbVpCZlBCS01HeUNkUWtRQ1Fqdm12Y0Zp?=
 =?utf-8?B?SmowbVRhZGdPVDJONnFsSFJDUTFTMklkeFViMWdlSGxIemFCZXZTMlRBNnpR?=
 =?utf-8?B?T1l0a1JnYU04eFNxSGYzaHdTNzNqUk8ybjM2M0xIV25XcGF6YWVnWnVqQ25F?=
 =?utf-8?B?M2NSc3o2ZkhaQXljYURTbEVVSFFzNDdJM3pwMjVOVUdwRm1ubHJqTFBjcnR0?=
 =?utf-8?B?a0RaeUpoVG0vUlluVmJUWjh0WXFqNVBXNUV0emsrSlZxOHNuSC9uRldmMSti?=
 =?utf-8?B?WVBDZ3l3ODF2bE80SmJQWW1lYXhKWDVrZjJkVGFzQmxZQ0hvTVIwS3hyODRN?=
 =?utf-8?B?Umdidmxmc3hYaHJYNUhxUlB5R0I3VmdpU01GazIxUlpMRTY4WHRjaTRKREFt?=
 =?utf-8?B?V2hXdjF3b0dUWFhqZ3craSsxQmo5YWJoSW1QZmxsZTZGUUxkNm16aDlIVlFa?=
 =?utf-8?B?NURnMWlPOUZFN1RJWE9Fb2FaY0NGT2F3Q0xwRTJaYjRkUXVWbUI1amxXNXFj?=
 =?utf-8?B?TUR3Ti84L0tlbTU2NTE2ejBBWXFFQnExWDZBM1VGaTljWWxscjRtNHQ3OW1G?=
 =?utf-8?B?VzR3R0RSSnNIMUlaZ0dNVmZOTktPOTNPYW5vZEJDOFNrR25qT2M3bnZwTlVy?=
 =?utf-8?B?TUtHa0x1SzIxWSt4Vmo2TWJ4QlNzRG0xM012cGpyY2VWR3BJd0lNY1FSVDFR?=
 =?utf-8?B?SlM3VXVwejBqVlowNW1lcVlYREFrSERrVXY3UjF1RnBuZUdaRDFlZ1RKbEoy?=
 =?utf-8?B?R2wxNW1JTDBjakQxY0o0MDcrMHBjQmdWWC9aMjF0bzdzd1doVG1SNEpYUGs5?=
 =?utf-8?B?YlZsUytUWGtXSDd6eFQwSXA3dm4vWEtzY3dEaDl0TC8reEw2aVZRZ25JRkhm?=
 =?utf-8?B?Y05QWVdVVEVIRGt4UVlZTklkZ1lNRjlUNVRxc3o0bFYwRFEyMUpuUDdIbW5F?=
 =?utf-8?B?eG5EcGd6RUFIM3pSKzBzSVdEd2xPZzY4MWRIL3pzSkRGZWpnWDBpNk1CTGtN?=
 =?utf-8?B?QVBLMWJzelBqMlQwZkltZkFyYStqRngzNmV2bUdrRmNxVThoU0JUams4dk9V?=
 =?utf-8?B?Q3VaRFI2NmpoSXdiT2NKQUQzTEJjMWNQNjZxZmp0Sk0xN051YjRLdTYzNWhq?=
 =?utf-8?B?YkdLbDBNTWRqOUxvUjM5STJTRmZXNnNCMVMrU21HTDZ1M2s1ZWtGdHRQdW5l?=
 =?utf-8?B?bW9zcTVZaVFjL1JSR1F0UXhwbjdtd3BhaGRpckE1WjBjV2RyTEQ5VVEyeWgv?=
 =?utf-8?B?SStYb1hINzlIWHc5OHdCcUp6Qnl4UXJJSi9xS1R6SnZ1Rm9FaXp0STVab0Ir?=
 =?utf-8?B?RWpQejNtaklTd0llZDFIQm5ibEVubmRnM3NWUGwyOG5ZYlNwRzRrZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F9F25171F372242BB40D0ED94E97092@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB16842.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab794d6-056e-4914-5288-08de5d864968
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 09:27:27.1312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qRPPnfMs4MglxEjZHhf8Srv0Yz5XSAn4MRiXATbcFWH2ZlPOda4o7U+9m5F+D4RrPYQK0LaXDse+OfwoPh53w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14945
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fujitsu.com,reject];
	R_DKIM_ALLOW(-0.20)[fujitsu.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16058-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fujitsu.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhijian@fujitsu.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,ziepe.ca];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fujitsu.com:email,fujitsu.com:dkim,fujitsu.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B77991B82
X-Rspamd-Action: no action

DQoNCk9uIDI1LzAxLzIwMjYgMjI6MDgsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4+IEVuc3Vy
ZSB0aGUgUVAncyByZWZlcmVuY2UgY291bnQgaXMgbWFpbnRhaW5lZCBhbmQgaXRzIHZhbGlkaXR5
IGlzIGNoZWNrZWQNCj4+IHdpdGhpbiB0aGUgdGltZXIgY2FsbGJhY2tzIGJ5IGFkZGluZyBjYWxs
cyB0byByeGVfZ2V0KHFwKSBhbmQgY29ycmVzcG9uZGluZw0KPj4gcnhlX3B1dChxcCkgYWZ0ZXIg
dXNlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW48bGl6aGlqaWFuQGZ1aml0c3Uu
Y29tPg0KPiBGaXhlcyBsaW5lPw0KDQpJIGJlbGlldmUgdGhlIGZvbGxvd2luZyBgRml4ZXNgIHRh
ZyBpcyBhcHByb3ByaWF0ZSwgYXMgdGhpcyBjb21taXQgaW50cm9kdWNlZA0KdGhlIFdBUk5fT04g
dGhhdCBub3cgdHJpZ2dlcnM6DQogIA0KRml4ZXM6IGQ5NDY3MTYzMjU3MiAoIlJETUEvcnhlOiBS
ZXdyaXRlIHJ4ZV90YXNrLmMiKQ0KICANCkhvd2V2ZXIsIEknbSBub3QgZW50aXJlbHkgY2VydGFp
biBpZiB0aGlzIHJhY2UgY29uZGl0aW9uIGFsc28gZXhpc3RlZA0KYmVmb3JlIHRoaXMgY29tbWl0
LCBhcyBpdCBpbnZvbHZlZCBhIHNpZ25pZmljYW50IHJld3JpdGUuDQoNClRoYW5rcw0KWmhpamlh
bg0KDQo+IA0KPiBUaGFua3MNCg==

