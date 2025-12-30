Return-Path: <linux-rdma+bounces-15238-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EAFCE8B00
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Dec 2025 05:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EC7E301D595
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Dec 2025 04:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA2B2DAFD5;
	Tue, 30 Dec 2025 04:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="cROurvri"
X-Original-To: linux-rdma@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011053.outbound.protection.outlook.com [52.101.125.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6401D17D2;
	Tue, 30 Dec 2025 04:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767070025; cv=fail; b=mupCHCcPF6DiqI9cJ5CDhqr0lltmP5XhPvUWU4u52+UQbcRhPmGbjr20yf+B5vf23KF+WbXd3280WHvfbMwug/KzlTq48zu2qqI+rWZOtnLoafIgNk2bya+eeE7U05g3HIfPDWkKVW7MGQE9XU2v2lotm9dIk1b4Pu9qtvfpXpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767070025; c=relaxed/simple;
	bh=82aqjOTj52wdYBm4eK0PtEQqmwYW01BV2bcL5/VqXio=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RzpCM6Aweaxi0Ftl9dnrsT46QPmj6C6tXULpEKQ13unhF77LhcbOHiTCM+GF43LBlIBFpBugvwexghuZqyCrtcnV9A8J9naAtFS8IkVYZwIQv8FcNOmew5YlpRZTB5OT+i6b66GQPiBSpRgwn88YS+0sEahK5g8xUE/9N8ASQDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=cROurvri; arc=fail smtp.client-ip=52.101.125.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBHHAY4CaKd6JswJh3tMabghm5jcF5i+MD9fz4PyN7uCmct116V/xm1dSYjypZEopZessbW2pR39SoI1J/B9De8VAO6ftvKbWOZw/fhgEHR8lPkb+lAOOnzAiNvwimsN5G0X4hIkrVSKVv45DUCTJI1VS86NN1wZg9y8lhgKl3tNPg9Xmy9A9l+bhnNbLReJ9mWPRB093p1eIVIsYzTjcZxyUuURJGmLTjD2NAc/HKWmQpz1V1yaDzYQ/b1t43X0iEdIdXCiEZ2pwTv4mRTpLPYtEqNYQQdkq7DulozDecM38NI5ft0j7PdRde/N0r9s5lSPJOzoDnK1dIbW8LcUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82aqjOTj52wdYBm4eK0PtEQqmwYW01BV2bcL5/VqXio=;
 b=GZgDzSwiOgFV2oQzZTNO+Vi1rXwhJq8uVSure5cs3tt9nO/yN2crySysiORAB59fKHV/vhRGJdFYJgTed4yv822TIE2/xcuED9U2k8Kxwo/tpGXfuS2Xzg+mUPpNyH9zqjDFl6VKp8HR+6JlA90JWv4OuODO0kUKAU+TCUxV9Wl4Uf2epUZ61OA61gd+TRry/2mJP9A3l5QyvuIyEHqz4v9ZvPMQmYBShzl/pp53NPkR2nrs1B/MeB51TGlatvKH95PMbyYU93l91NiUtX+9ojyiFTwo3Jeju/zit7P8eJgRCAdLlxTgxd3KPUqZbvaQbSfrbMqq/puexd6ruxAY2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82aqjOTj52wdYBm4eK0PtEQqmwYW01BV2bcL5/VqXio=;
 b=cROurvriGJLCdWo4KuxNn8G78/A9XVu4An9vx6NR5EU8qBK7ocM4+CzN4D/FIDwJJY58OABjZjj7yBknDPo37LOK9wTRLIXAlmcJ1yKAQC4vu7jkPYHsJlTZe6HEmS70aAuL6uM8pH+Ac3Cx/TTFEEs9pcbIDlWzSajM6RGpPz72eubeI89xvH4kNfdqN77XQAz231NqOWofGW44qwj/9B8AxbF+Hut6rfM+mD61xNYuCTbI2zmg74lRaluVdUhktBosD5MtBTO7lpDGFbiNlZ/xLJF6mqw85nkc0AJC8kIafEutYR6xbVxjJHU1iycCgec/l1Y8VZ7/lyt3tMfxjw==
Received: from OSZPR01MB7100.jpnprd01.prod.outlook.com (2603:1096:604:11a::13)
 by OSZPR01MB8155.jpnprd01.prod.outlook.com (2603:1096:604:1a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 30 Dec
 2025 04:47:01 +0000
Received: from OSZPR01MB7100.jpnprd01.prod.outlook.com
 ([fe80::392e:5cfe:7cd5:92af]) by OSZPR01MB7100.jpnprd01.prod.outlook.com
 ([fe80::392e:5cfe:7cd5:92af%7]) with mapi id 15.20.9478.004; Tue, 30 Dec 2025
 04:47:01 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"leon@kernel.org" <leon@kernel.org>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH RFC] rxe: Fix iova-to-va conversion for MR page sizes !=
 PAGE_SIZE
Thread-Topic: [PATCH RFC] rxe: Fix iova-to-va conversion for MR page sizes !=
 PAGE_SIZE
Thread-Index: AQHcdk1rywJr32Xi+kGTH0jFIevMrrU09aYAgASf6gCAAAyAAA==
Date: Tue, 30 Dec 2025 04:47:00 +0000
Message-ID: <68c333fb-7026-4412-9bcd-be877b95b99f@fujitsu.com>
References: <20251226095237.3047496-1-lizhijian@fujitsu.com>
 <0afef9d8-dbe9-4df0-bdf0-0c4be15e7d04@linux.dev>
 <5727c511-7fd2-4119-b7d9-3b33b578e767@linux.dev>
In-Reply-To: <5727c511-7fd2-4119-b7d9-3b33b578e767@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7100:EE_|OSZPR01MB8155:EE_
x-ms-office365-filtering-correlation-id: e8f4bf30-4d68-4e38-d129-08de475e78b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?eFBDNHdqNDJpdFFVUEVzNGo5VjVQRmdsR3lxblJnRHZmVVd0Ty9QaUx3SXRv?=
 =?utf-8?B?K09QQzI5M21lYlN4T1pYYmlNVURhc2R4Rk5jbFFTT2E2bWpWN1ppRE9tc2FR?=
 =?utf-8?B?T2NuanFMdi9tL1lYRjdZQ0hRRHJ0eGt3UzhjdUNDNW9QbEwxR3NGU2hmSk15?=
 =?utf-8?B?NTVmYkVBaDlMU0ZIRVNwNXdkMG5FSHlzcWtURFF3ajRFVm1KMGYvTGFQbENq?=
 =?utf-8?B?cGxlQXI3WGtJVGpyNUMvcEhjTithYms0bkxTWHNHUUdOd0EvLzNmeHQyZ0xw?=
 =?utf-8?B?MU5JQWlhTnNTeU1udkpidDVjNlB4MkRuRklBSTlrdEhRUmxMdXMwR3l6eGY3?=
 =?utf-8?B?UVFVZmZES3pvb2FFMHYvc0Z5RCtpdk1IN3EyZVk2bnRZTlVVbUFwTGNHS0hI?=
 =?utf-8?B?ZTVla3dIWlRpemFpdjBaTDZpSmd6aHdQd296cXVHbFVWVzUwWitPQ2NKU3Vo?=
 =?utf-8?B?K1RSVE9meFlZc0VqNC9WNVZueWpjZGdCY2daUzQvSFBFTWRIK3RPTytkMENS?=
 =?utf-8?B?MEVqc2FQdWNUcUxEamVuTlUvRGZlTE1PemlHaHovZFlaTk14S0pycXc0Nm5H?=
 =?utf-8?B?VDloL0t3b1doem5JK1g3TEErUWJNRlFQbEJubUtYUUtEL1E3TWNkcWRpcERU?=
 =?utf-8?B?WThkcERaUjFMNjJ3d1BVS3VzbXcxM0pBQTZBTzRoU1R5dGZISmNuL1lxbU0y?=
 =?utf-8?B?QkhpWUcvb0pyTCtHcU5wRkY0VVl3cGhHYzIxamlBU2V6WHdjOHlzb1JkNXRR?=
 =?utf-8?B?dmJPVVFnUjFYYlJaWGxTRGJKY2VVZGpVYVN6bW5ET2pzZkkwazU1Myt5WlZV?=
 =?utf-8?B?OVAzOW1raG9Va1RwMU5Mc21UVDZOYkUveWtaUkdSaFFnVjcwUnFoUmVITkE4?=
 =?utf-8?B?QTdJMFMvRzNNSzhkZk5idUNKekdQMS9NQlU5Vkl5TlgzRmpld3BIWXJIRzZa?=
 =?utf-8?B?b0JZQlR3eXM0RGpCQm9SakxXRUZGcW4wOGFRYkhnQUZ2VUhSOG9UUnFLdFZZ?=
 =?utf-8?B?Qk1peGlMRDJpeUNiZE0xWGRweXhPNURpejJuTExHbFFIVzY1bUdRTWEzNDlk?=
 =?utf-8?B?clI3OGRMVGRrKzRqeDBoM3hoU2IrV0g0L1hlREhZV2phZ1NDUm54RHdITENM?=
 =?utf-8?B?d1V6MERVZnRUU214Ui9IaFE5eFptQ1BzRUZRWDN4TUVFTmMwU2hGd3dHd213?=
 =?utf-8?B?OWkvd2syUk12aDRDTXp5QytSOGh1MSszNEw1YUhucWVId0hEckp6YThjSzEr?=
 =?utf-8?B?M0pGOWwxZG5iRG1JNU4vVzExWFlaMDRvc1lnalp3dVBoczdUNVFoOU0yQVkv?=
 =?utf-8?B?MTBtUFQ1RVlMb1NRYXMzL1oxM1dxbnhKRTA3MlFtb3B3WGgrbVJVRTJsaTRW?=
 =?utf-8?B?Ui9BWGtSNENvTlFnKys2d3k1aU9EQWdyR0JzVFUrUGtiSnFtaEE3TTMrckJl?=
 =?utf-8?B?bUtjUWN1bkRIUytvellmcFlFUW9VSWlCQURyYURDYXorT2RwaGJjZXhieHpr?=
 =?utf-8?B?bG9ScDYwSk9OWU04NzFUSHhub2hhSXljTmhORllBMVQxQUJnam92QlhQMExs?=
 =?utf-8?B?TnpXa3NNOGZLcTJuT0ViZWQ0djVhendrTEVwUUE3MWRmZ3Flc2J1S0IxUEZX?=
 =?utf-8?B?SjJ0WnJiSEtZYW1Pamlxd1d5d0xYL2FEY2o1cXdhb0tGTWdrbkZlSGlQN21o?=
 =?utf-8?B?dVp1a1R3aGcreEtvZVNNOHMrT2pRNGxZcGpEM1E0Mjg5clUvNVdHRUVjT0Jt?=
 =?utf-8?B?OVd1bDJWMzVGd1dka2h0WXJybkdVaVl4VVppZ1NRS0h2WFpWUHp0SmVRak1l?=
 =?utf-8?B?cXluV3k0cFlTUGJxRFVjZmhWM01SYVJMMnlFb3cvRHlMeE5OQnpHMXNMQWZ4?=
 =?utf-8?B?MksrWlZha1ROSGttQnRvT1pPU0ZIbklKNkJGNEptN2hMVlNQVXR4RWVsaW85?=
 =?utf-8?B?SEhqUkJTSGdWdlhLV3Fxbk04akIrTmVOTEZ5bDBEUVV1ZFlJMG5wbE1LNFZJ?=
 =?utf-8?Q?KPEa6OQcKRf83CYlYa7trsFwQ6GxvI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7100.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cGlBd00ySG10bE8rMGg3ZC9Mb24zMTY4OUQxSXF6VVFIa0xTc2JUOFpIbC94?=
 =?utf-8?B?WHRWSWZicGNvNFRGSzdXT2k1MGdnaEpoWDhlOGd6ejV6M3dGUlp6WDFYTEts?=
 =?utf-8?B?WHNpUWxuQWJqUm56RFJ0M1Q2d1J4MGRiTEJHcFRPZnlqTzB4YzBiaC9YNUp4?=
 =?utf-8?B?SWovR21uem5NMWxZNmV0TkRCSHM2cjZEb3BTd0lNT01VdXJuWDF4T2l1a0hV?=
 =?utf-8?B?RmNyTDFzRXVBVXQ1NFZtNGtlR3dVUTQ3YmpkS3prNU05ejNTVDhqakREWCs0?=
 =?utf-8?B?TE16UUZ5b1d4MTNOWWlxSStoY1ZrSlNuYUwySFJ1NjFzOU82VG8xVU1vVmZ0?=
 =?utf-8?B?em4wZHl2MlFiT3h3QVJEcFdRdi95clg3ZTI4WDV0aWxqY3FwRy9DeDhpRWZW?=
 =?utf-8?B?aG4xY1JzNHZ1MkREQXFtZVlkOHd1S1phMlRwdzVzZ3ArdU5DeU51QVRYTlNZ?=
 =?utf-8?B?NU9aRyt0TWJnVE01V1BsM3I0c1pUeWF6M3pOanQxVGJHQlNjRCtZY2VFRW81?=
 =?utf-8?B?Q2Vpa3VKdUJYak9ZS01Nb1FaTHNHcUpKd0JVdC9keCtDYlZ4cUxkL3AvbzNO?=
 =?utf-8?B?VWNESHRqMlRQMDFiUkprMUFteFZPK1dxeGMzQzhFWFp6QWNMRUNIMUUxMWY2?=
 =?utf-8?B?MFZCWVdXM3c4dFpPRnFJTTgxZWY2NVpZYmx3QWZ4WDc3UUdtWmRLSjZXbHZX?=
 =?utf-8?B?RFBvRFZWNFBoMW8rTTJ3enJnb2xWK0NsWjZXUkppRWJpNEJDUC9GWG1sZGk5?=
 =?utf-8?B?WEtKME5JNmdaSTUwR1JGZFdLa3FmZXl1dTYrMGlTbkh4TG8vY3gxeExhYjBQ?=
 =?utf-8?B?THlBQjFCWVg2UU5qMlFWRUN6ZDZ6bXIweDZ6QWJTYUhuQnlOZzVsenk3VDVp?=
 =?utf-8?B?bFdDZVFjbTdYaVdHbGRvM3gxbzV3Zk1FUTIxOHNNWjB0clVnbHhrZEJJK1Qx?=
 =?utf-8?B?bEtJSFNqdlJRc3pWMmttdHg2alFTdUVTdGdWenFWenhtNTN5cGgreGtua0k4?=
 =?utf-8?B?NmJiTEZGbzZWZUw2TlQvYVYrZW9lWXVjMmFSaXoxSXoxb3RpU1NGU2tJbnBF?=
 =?utf-8?B?SnZhOEpnZTFzL08rWlpYZkRTK3k5Tm8rWmJWbG80Umlla0ZySXYyZzYrc25u?=
 =?utf-8?B?bnlRRkd3bnJjOVY5UFRBMnhmZElRckJuMGdUQnVnUVdWdmhMUk1LZ0xLMjEx?=
 =?utf-8?B?amdYUXI1cXdHaVpOVU9sb1Jac01neTZwVzJ5SzBYVTQ0ZkVuc1V0aG9TMThK?=
 =?utf-8?B?UWZIL2cvVlFSUGdJL0E4dEE0K2lCdUhjTUYwWUhmTThBOEhqTGhaNnFRU2Rt?=
 =?utf-8?B?SUl4UkZuUVVvTXpFekMxeVBRMmhTMk5lS3pKVDE5M0RHdjVRZFIxY2tEbTRk?=
 =?utf-8?B?Vk4vT0MwcVpLQjdwOTRRbkJBNE1NaUxwL2xaVmluTStHS1NBMHdPZHo3RmJY?=
 =?utf-8?B?blJKZE5FQkZxUHNtRVdJeXplY0dQcmlOVjdTL1lOV2E0SmNhNXBzaGNSYkN0?=
 =?utf-8?B?UTNYZHFKOE1DZTVuQUJWZW9IWW10NzN3R0Ftb1p5Y1Q1SzBEWHhzYkw2RWoy?=
 =?utf-8?B?UUk2WE8zZkFRRjAxb01DV1pUYVRBR2FJR0FqTWNSSVB2S29VcmUyQWM2dWpQ?=
 =?utf-8?B?Q3hoMWlLNjhYbUI4aUI1Z1E2U1B4aFgvc29pRi83Q2hGUld3ZWUyYzVCbDM5?=
 =?utf-8?B?NzhVS0Z3U2VrRkI0WmZUclNZL2ZlQkdmZ1BLT1lnVkN2dWpxT0cwejdvbGhH?=
 =?utf-8?B?ekY5Qy9QTHlONmNXMmFSaUZCWEF0Y2QraVlwdDY5VEoxcXljcm1rZVJZekll?=
 =?utf-8?B?dE52VHZtc2pxcXZEdy9kK2ZtdjJvVzE4RXZnVTB6V21hUm1GZCs2UlNQYlFn?=
 =?utf-8?B?elN6YVlHQ1NrMDRvYXpFRlB3OWZVOFJUdmEvYXREZVRZWkI1cWVPUkJJOWZy?=
 =?utf-8?B?QmppbCtsQVFtYzBGQ2hEUUJvSWNmSGRMMU5ndTYzdjAzSGdwWHE5RldtL3Jk?=
 =?utf-8?B?V0p4UUovTGhFS2NBWElCR1dZYjM4aGYySnRsM0N4Uys4WDZ4dTVQdndLYWUy?=
 =?utf-8?B?NTRxRzFUZVBsWlpjcFE4cEYxZ242c0xWVFZPOFdLSVU2bmd0eWRxZmVnVmgw?=
 =?utf-8?B?c3BhQzBEbzZaV2dPajBsaitvaXhjb3NsZ2psYzhCRWloU0tzbWJHaml0SGZQ?=
 =?utf-8?B?aS9PemgzTHYxOU8rUlRXb3YwQ1Z0bFNoUnNveGJWZm83L3hzUWQyTENuN09K?=
 =?utf-8?B?dmRqNlRrckhLMk11Y3JuYzd0eVNGcXEvdnE2a1VILzd4T1dBTXNnRHExZU9G?=
 =?utf-8?B?SDVOT1dmalBIR0twc3AwL0RLTFVhTXhuQ3lsZTN1UmFEUE1CbXQ1anVELzBT?=
 =?utf-8?Q?EdG0eHobdzSoRYU8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02B267513862294B9052DECDE2381425@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7100.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f4bf30-4d68-4e38-d129-08de475e78b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2025 04:47:01.0028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05pQa3BCGDBIzEAFST6mnzKcWN6vZ9+HiHXrb6UA5TDA4rv3p/wRRf7E+oXjTiYKwbEe5iy/gn02+7NQWMyUYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8155

SGkgWWFuanVuLA0KDQoNCk9uIDMwLzEyLzIwMjUgMTI6MDIsIFpodSBZYW5qdW4gd3JvdGU6DQo+
Pj4NCj4+DQo+PiBIaSzCoFlpDQo+Pg0KPj4gVGhlwqBtZW50aW9uZWTCoHRlc3RjYXNlLMKgdGhl
wqBsaW5rwqBpczoNCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DQUhqNGNzOVhScUUy
NWp5Vnc5cmo5WXVnZmZMbjUrZj0xem5hQkVudTF1c0xPY2lEK2dAbWFpbC5nbWFpbC5jb20vVC8N
Cj4+DQo+PiBDYW4geW91IGhlbHAgdG8gbWFrZSB0ZXN0cyB0byB2ZXJpZnkgd2hldGhlciB0aGlz
IHByb2JsZW0gaXMgZml4ZWQgb3Igbm90Pw0KPj4NCj4gDQo+IE9uIHg4Nl82NCBob3N0cywgYWZ0
ZXIgdGhpcyBjb21taXQgaXMgYXBwbGllZCwgYWxsIHRoZSB0ZXN0Y2FzZXMgaW4gcmRtYS1jb3Jl
wqBjYW7CoHBhc3MuwqBCdXTCoGluwqBGZWRvcmHCoENvcmXCoDQywqB3aXRowqBBUk02NMKgYXJj
aGl0ZWN0dXJlLA0KPiANCj4gdGhlcmXCoGFyZcKgc29tZcKgZXJyb3JzwqB3aXRowqByZG1hLWNv
cmUuDQoNCg0KTWFueSB0aGFua3MgZm9yIHlvdXIgdGVzdGluZy4NCg0KVGhpcyBjb21taXQgc2hv
dWxkIG9ubHkgYWZmZWN0IElCX01SX1RZUEVfTUVNX1JFRyBNUnMsIHdoaWNoIGFyZSBleHBvc2Vk
IHRvIHRoZQ0KVXBwZXIgTGF5ZXIgUHJvdG9jb2wgKFVMUCkgaW4gdGhlIGN1cnJlbnQga2VybmVs
Lg0KDQpTaW5jZSByZG1hLWNvcmUgdHlwaWNhbGx5IHV0aWxpemVzIElCX01SX1RZUEVfVVNFUiht
ci5wYWdlX3NpemUgYWx3YXlzIHNhbWUgd2l0aCBQQUdFX1NJWkUpLCBpdCBzaG91bGQgbm90IGJl
IGltcGFjdGVkLg0KDQpUaGFua3MNClpoaWppYW4NCg0KPiANCj4gScKgZGlkwqBub3TCoG1ha2XC
oHRlc3RzwqB3aXRowqBibGt0ZXN0Lg0K

