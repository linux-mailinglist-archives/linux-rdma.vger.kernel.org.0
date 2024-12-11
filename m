Return-Path: <linux-rdma+bounces-6436-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B850E9EC9AC
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 10:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2330C188477C
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 09:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2FA1C1AB1;
	Wed, 11 Dec 2024 09:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l2M1g9T0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A23919F12A;
	Wed, 11 Dec 2024 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733910573; cv=fail; b=JbAzp5bAq9JZHu8CT84JqaIk2OjceTpCYTO9uS+Phswd7VHmtD2OMhA/0FSCCfSwTF9ZwXYo+7eM9i+Czp1tkh/SkZDq/2jOMzQFNZiuSo7D/gXR8cfkvC7RVpQ3zPeyk9JyCeF9Q8B3b9CYtQFO6nAkoPQ+nVhL8I4Zzqud6hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733910573; c=relaxed/simple;
	bh=YTCWgFhdchqRMIBFXj1wD6GcVCeNdvZmS2/Qw9vqMOU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V+pfJ9Rznr6QYTV0939P6+8sY5aP4VxlQSVJbWE5nQ9dZm0yV2L5Xfeqgo4IK6oooEHOGzHil6tUmCVbMzPTS+LmEy73cObRUsRKQU15HBx/Ajwum6LuypGkeDpb/0Va6urLCYMGQkPSek7/82K0hwcDnQ4tojz/zXSU49oEDus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l2M1g9T0; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ev+v+5IP8se3qEIkEUaHSBlBoKR3wGQKLWaggvrl+AR5bBdmNBbSsUsmDN2fJAxUKXNSg7gqowNb2a1wyS2RDfAci1YlWYHPr+iiJ2o0gMjw/K7nNZbCEKQ6PRuq7e0HLa28Mak38VJ53mGlkLVf/EdlasR85GW7BQRI7BnNQztbEbTuppKFr0SJ7B4v3aJxsYTAqpWlSm6WgKtvXOifS+hUxzVW+PhWiXMGR3BEUmqoQqyaLowW77lLL/UrXtcfN6VwRpQ0krgft2rt9ojpttN9XtfL+WvH3rTobUmcT4aoRFFQSAguD3wa/OHaJ6Wflp/F6DOVb1p73ySFzuN+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTCWgFhdchqRMIBFXj1wD6GcVCeNdvZmS2/Qw9vqMOU=;
 b=Ebsg4t1eibRlhEyznPnyR/7Q799hJyVhkdrWHpfP+dA25wGdgnq0I7qcZ+V6V8J48u5It95gwRGYu98c5pW75WPZvCuv5SowCgogN6sYOPQq8+EDycC11kVRpwurnPHVVncd13kt0i5/0bTntoZ3Ul7DXyVeIOqqwcyJ/gZkngSu4T29KgDZzAZvf/81lG1AM/CH8JtBgzk2Dw09ogkrHu0TVsa369Vxl5NUFv8Fppsz3FyaukQNjVhqhauehFD6Q3eh3ZdFLYxBHzzi1t7yU38ABZU8NrxXgHNg6VzTEfMfRFEfU1AIR6w8JWFXjIaWiICUX0Srv7rrQCgH7BCf3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTCWgFhdchqRMIBFXj1wD6GcVCeNdvZmS2/Qw9vqMOU=;
 b=l2M1g9T0lF+6V70JlXLlYKDa1aLJ/IMk1ygFTIo8ifwTy2KNHzg0WGhpywpzscKFl52+KIBqCdJw++oXjbJNcgeJ/3yHkevN8bAikdBcUap8dEuX208gNf3j5I2yGF+4semGAdDX1il/Mwx2wB/qT06/zWfCC/1wQFZGqq4fOauylAco1JVngAQFLaU9iXCToD04epeU91Asql7aYPcINC9AqYJeB+4b/nI260EKfxralGeIDN7SYJLYAaaFUoNBkWZakvPdzXM55gs99FOy1tWqoAEiDgRpgYGTeG6Y+SvMiWQGQTNwBLDfBnFoxb6IP6rREQHaCLGJ0y1jpma6QQ==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.16; Wed, 11 Dec 2024 09:49:28 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 09:49:28 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "ttoukan.linux@gmail.com" <ttoukan.linux@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "kuba@kernel.org" <kuba@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, Saeed Mahameed
	<saeedm@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next V5 00/11] net/mlx5: ConnectX-8 SW Steering + Rate
 management on traffic classes
Thread-Topic: [PATCH net-next V5 00/11] net/mlx5: ConnectX-8 SW Steering +
 Rate management on traffic classes
Thread-Index: AQHbRpmNrHzTfY3l9kW9Sl/INZi8E7LaDhaAgARGzICAACQugIACXauA
Date: Wed, 11 Dec 2024 09:49:28 +0000
Message-ID: <1593e9dd015dafcce967a9c328452ff963a69d68.camel@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
	 <20241206181345.3eccfca4@kernel.org>
	 <d4890336-db2d-49f6-9502-6558cbaccefa@gmail.com>
	 <20241209134141.508bb5be@kernel.org>
In-Reply-To: <20241209134141.508bb5be@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|DS7PR12MB8419:EE_
x-ms-office365-filtering-correlation-id: 6db3b81f-eb4e-4b63-1d90-08dd19c91ac1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UnJzQzBaZVFxaTEyNmVzdzlqbVhJL01aQmFyN21oOWo1L25HTGpuOUZJNmQ3?=
 =?utf-8?B?b2hjdUZzKzZuTnU4YkRjS25aa05mS2VodkJkNDZFVjNUR3NVd1JmVTdxTk9l?=
 =?utf-8?B?Z2pkSXVJSTdiVGUwMkxmbU9MN05vekt6dXhtbDg2MVoxN2NuUDdBSWc1RGRh?=
 =?utf-8?B?emF4UEdEOE8zSWQ4djY5M3plaDlKVy8yakVHV2tCVUlXNTI2RVlFRS9DWkt6?=
 =?utf-8?B?ckxiZUdtS1J0cmsycUZzNjdPLzEwNENuUnNMbzZJck5BUWhvTGo0MVF6LzR4?=
 =?utf-8?B?c0FrczY2ZmZ4MWlPV1VudTB6ckVjWmpwaXFpWDZadmdyTit4dzA3dUIxQ3Vh?=
 =?utf-8?B?RTVybndiQys1cmI1eHRDcVZBUVFLSWpYREVudm9Nb1JxTWUwNW42L0dWakdG?=
 =?utf-8?B?ZC9mNjhkVDVrYXpFUTB1RU9Gb3Zaa0Npc0xISVArMTN5Nnlqc3lSY2NNL21L?=
 =?utf-8?B?ZWJwWGhTb3FGYnhncmFmb3hIdW0zRDArY3pGUEZiaCtQd1E3ZVNDSTE5WFFk?=
 =?utf-8?B?aWpBdllmZkhiSVl3TlpkVUl0Wlo1aGtGa0ZpNWNKRGVrSmQ0SXZCZkJPSlVJ?=
 =?utf-8?B?Sk5EWVJmdmJ3LytiM3EwMUhpall5MnZRNDVubGdOODc4NjlNWmRPMFZnVmV0?=
 =?utf-8?B?NG9aSHJHOG1NWnBSSjVOa2JwSTBKN2ZIbGNNakNqdVVMTTRMU21rU3RsOUlU?=
 =?utf-8?B?UVRzUTh4eDNQbU9RSWtMZzZTVW5HOXRPcTZmUUsrWnUySTRld3ZoeS90a3Nk?=
 =?utf-8?B?ZHhoenFFWS85RTlVSC82UGREWHY4eU8wRjVFWm1QY3hJTnFQSk5KK01zQmR0?=
 =?utf-8?B?ZGJBalNxUXcwWlhpZVZES1Z0Q09mNmQzZ1dtcEg5MDZQcFV1YjhMZERMN1pz?=
 =?utf-8?B?TkJkVHpzVmNnSDFLUjdmUmxHQ0dwMm1yckQvTTA4Mk52OEtuMTJZQ20vRUo3?=
 =?utf-8?B?b1NzdUs3MDhpN2g0L1dFTDhLblhqM3pZK0lRTElCZ3hSb0Vsd2FmOWVTcDlI?=
 =?utf-8?B?MzdmakRQRGJPZGJnRWVwSHlLSUpEdFErMVROK243SkRMblRIeVJzd2huTnds?=
 =?utf-8?B?VDRVZGtGU2hjaU9hZDhqdlR5M3MzSWZRQVdRRSt3QzlEL0ZqZlZlays2QzRE?=
 =?utf-8?B?V3NBdU5mVitRWkZ2TEMzSE9yNERSMGdGSVlvY1NUK2hwWk0vOTBTbUprWHY0?=
 =?utf-8?B?cWhtazZ1bVlvOGZKa1QybFNWejFLUmJhZEUrbzlHNkJBaUI4R3hNZ1AzTzlq?=
 =?utf-8?B?T1g1SkVSNTBaeXd2bXNsWDRqWHNOODZ6cXV0Mk9nNTFORWdXTUp1UG0rM2Np?=
 =?utf-8?B?MXl1SkRxQW0rTG4vR0UxS2lZbHg0TVV3TjBLOUQ4cWszTlg3RkpyOWhlckE3?=
 =?utf-8?B?Y2pxYkJ3NUZrUlhGQ3B5UlhFNFNCRWlZMDBKZWU1ZmR6NFVwS1k1RUh3TTRH?=
 =?utf-8?B?eTFoUkFIL3FrbXNNdzZKbGY3emh2V2RHeXl5NUE0NG1yQTBMK0lLN1R2Um5x?=
 =?utf-8?B?NjFVM0x4dFlObHNPZ2V1akhRYlhRYmRiMFN2SWNUTUNHL0R5SEJhcUFMUmMz?=
 =?utf-8?B?eHNyQ0dqRm90b0Q2d2c2TnlEbFVRUXc3dERiY2ZibXBvcy9MajFrRjhrTUlB?=
 =?utf-8?B?UnJhV0kxUWNickM1NXhCNVJ2RVM1L1lXWTFDWSthK09FTTBZL3NZMWhFMXNW?=
 =?utf-8?B?RzlWbWc2U3pobWpoTDdaZUFTZjZ1ays2aEc4K2VKU1F3MTBpZTYxMjhoYzQ4?=
 =?utf-8?B?V3VCUzhZelNXM0l3NjI2WncyWS84TUxhMG9aV2F2QlVnRVVTWldMK2FYMDBs?=
 =?utf-8?B?SE9QY2VCU1dhdHMzRjU3aG14L2JIekJNSEczSFZlSzF4VzdhcHJEZDNSdDlP?=
 =?utf-8?B?N0R0MmRVQ2xYZC9SeG9CU2JwOEc5Ujg4SnIzSDJaM1ZSN0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDY4dVlmalNNZ1BrcDVUVGRDRDUyUHRjeE1DY0R6bzhYd2NTKzV2aXBwSU9o?=
 =?utf-8?B?c0NJdUZWdFlqeEQ1VTREQ24vSzlvOGJmVHJVTG5oS2NVdHF4c1BkOXlVSzNm?=
 =?utf-8?B?VWRoc0ZDZ3dxdkp1cnZ3VXZMOXhsT09IcmkxNk5vS1dYWkNTWFRzYjJtZUNk?=
 =?utf-8?B?MHZweXhwR1hnNUVQVW00bUlGcFpSUGIydkFwNGRTZmQ1R3ZNMWhkS1hBVkRX?=
 =?utf-8?B?d2duQXF3TnU2SloyNTlVME5rdmFISGJZa3ZiK0lOalVFMkYzbU5CRy94L2p4?=
 =?utf-8?B?aktPbWN3M2ZaN2c0TXBTcDFEQVRQMmVzL3dhQ2ZLd1NqcXFYamZZMzcwZWlq?=
 =?utf-8?B?dURYMmFvL0I5eW5lTVJBZnhZdmZHNm1PWFVGUE9VMnArTldUWjJFTDhsMEs3?=
 =?utf-8?B?ZDhSQVlRb20yNEpEeXJqY29VM2lCM29POG12WUhpWi9Ha1RUd1k1cHN3cVhn?=
 =?utf-8?B?S0pYdTUyaEd5eGI3WVJvUHlobjFqK0UzakZrVGN1ZlMvZnNlWUhoQ1NKc0JF?=
 =?utf-8?B?c0o0ZVl1Mzl3QlRIK1h1cGFWZkg3Zkt5aUNiU0xuZm82WjhjcmVkWjdvTnMw?=
 =?utf-8?B?VktTQjdxQUZsT21ZUjlQMGtLSGNxQnhlbUNKSlBBQUtzMEFFS2Nabi9TTzky?=
 =?utf-8?B?ejl2SCtmSDl3Y2NaMGFwK1NTM3dYTE9MdE82ZENVRXp5bHFKSGg3WXBReWpU?=
 =?utf-8?B?anpMT3o0Zi8zYmMrTUN1TXM2ektRRFlzcVJlcmpXQkw1TlJBRnAzc1A1bHRa?=
 =?utf-8?B?MENZKy94TTl3MzFRRUxPWXFRTFNaR2lFcXZNQkloOTNkWmhhQ3RGQzVKbFRF?=
 =?utf-8?B?Snd1VzlCalJHYWs3ZFp4VmZzYUFka09xODExK2hvaW1uaWFhcGNaRVJhdjRT?=
 =?utf-8?B?bmt2OXZJbnpERFFhOVV4a3RtSkhOSEZnZFYvcWtBWVNkNi83djZCVkNIK002?=
 =?utf-8?B?OHl2OFZwbS9zMnBmTTJGTFZPVlJkNzZ0STNOK0FxVHEyMzlGa3BRMUpVY1Fw?=
 =?utf-8?B?VjRsQVFQQldhMlR3NWIwd2M5UVBkZ0hUZGZLTnFCN081YVl6bGRuZjN5S1da?=
 =?utf-8?B?amxtUzJZd0xmWW1NQk0xN3RtQlFmSXVVdWJkWm9SSitsdXJPbmZ1RDhrRnNj?=
 =?utf-8?B?V3pwSm96dlVrT2RoYUZ6dCtlMWo3QnFmY0hacy9RdnUyeUZDb1IreHVPMW9O?=
 =?utf-8?B?TDBRYnJzUzI3bFpCM2dSWVluTnlSR1U5U0ExcUJFa0k2SUltRHdaL2RHMk9Q?=
 =?utf-8?B?aWxRVGZiNEdlZWc4M0FvWEhBSzVHRVJ5OUoxWHNPRW9PNGM0K2FlR1JLK2RJ?=
 =?utf-8?B?c1FtdUpmM3JPMFRFVTBhNHBta3pad1dLOEVzSGJ6RHdkRGpWUFhYZ2d5MkhC?=
 =?utf-8?B?ZkNPbEMzYnRJUTVQZDN2dG5YMU5NZk9WVkxKam91SE16SXpCTkNVdnNuclFU?=
 =?utf-8?B?K3BMMVVWVWtvZXI3Qkh0em8vbnFVaHhoVzk4ciswSytUMWR6TzI4TkNPc3hm?=
 =?utf-8?B?U3pJMWFxd0Z6ZEtjQ3U3d1FITmI5YzBLYm1lRHBobHlPOFpNWFFqQm81RGFu?=
 =?utf-8?B?ME9kVjFmcW8zNGNsamRuVnNUUFkzU1RzcHViM3FEekhMYXU3NW9OS1RxaUhy?=
 =?utf-8?B?ckYxeFcrcHlQbnpCSUNMUE5NTmE5YVN6bDYydEFIbDl3eXAyMytKaVpyaUgy?=
 =?utf-8?B?Y1ZET0tMdy8zVVBKMzBsVTFNdGN3bDJheDBJOE1NaVBua1E5RmxVd0JUNFhj?=
 =?utf-8?B?MlRDNDBCS05hTDRyc2g5bmkwdXgzNGd5MFN5WTBOQ1VmTHF3clIyNjVSRHFj?=
 =?utf-8?B?bjdZeElLMWEwRTJzMHN2N3YzSzN1WS8xUFBPTEt2bGl2dUtsdmlhWXk1dGVO?=
 =?utf-8?B?SkZOOE0wbUYyd3VUYlNVcVYveEo5dDl6UEMvSk1maTQvZ1Axdll0T2gxaGJv?=
 =?utf-8?B?OUQ1WmNHaGJEUHcvWlJjYnUycWR6cnVOTDBiOXdjMk9KRStMT1lNMDVyTHIw?=
 =?utf-8?B?Z2tFTi9tUkZXWW1CSEJZSUJ5NXVCTm9LZ2FwTk9UbndPTS9kdGZzS1JMb2hV?=
 =?utf-8?B?ZnBQYjJGLzNYYU90SWVUVFlpY0ZzVVNPZ3RDOCtBWSsyYmhjT3J6S0dOTHRk?=
 =?utf-8?Q?YlHp0rVOKL0/fU7+a2E4+dFSj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <703332B5DE98194C88F77D09AE668B46@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db3b81f-eb4e-4b63-1d90-08dd19c91ac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 09:49:28.4370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERMA7Pb5nGHsxdHxBEeEmlPNw7dP7nfcu4dqsDXUrUyj750C8QFS9Pzhj367ssALAw8VAoJa9dQuWwtLrNRY+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419

T24gTW9uLCAyMDI0LTEyLTA5IGF0IDEzOjQxIC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gTW9uLCA5IERlYyAyMDI0IDIxOjMyOjExICswMjAwIFRhcmlxIFRvdWthbiB3cm90ZToN
Cj4gPiA+IERvIHlvdSBleHBlY3QgVEMgYncgYWxsb2NhdGlvbiB0byB3b3JrIG9uIG5vbi1sZWFm
IG5vZGVzPw0KPiA+IA0KPiA+IFllcy4gVGhhdCdzIHRoZSBwb2ludC4gSXQgd29ya3MuDQo+IA0K
PiBMZXQncyBsZXZlbCAtLSBJJ20gbm90IHRyeWluZyB0byBiZSBkaWZmaWN1bHQsIGJ1dCB5b3Un
cmUgZGVmaW5pbmcNCj4gdUFQSSB3aXRoIGxpdHRsZSB0byBubyBkb2N1bWVudGF0aW9uLiAiSXQg
d29ya3MiIGlzIG5vdCBnb2luZyB0byBjdXQNCj4gaXQuDQoNClRoZSBvcmlnaW5hbCBpbnRlbnQg
d2FzIHRvIGRvY3VtZW50IHRoaXMgaW4gdGhlIGRldmxpbmsgbWFuIHBhZ2UuIEJ1dA0Kd2Ugd2ls
bCBhZGQgc29tZXRoaW5nIGluIHRoZSBrZXJuZWwgZG9jdW1lbnRhdGlvbiBhcyB3ZWxsIGluIHRo
ZSBuZXh0DQpzdWJtaXNzaW9uLg0KDQo+IA0KPiA+ID4gSG93IGRvZXMgdGhpcyByZWxhdGUgdG8g
dGhlIHJhdGUgQVBJIHdoaWNoIFBhb2xvIGFkZGVkPyBIZSB3YXMNCj4gPiA+IGFza2VkDQo+ID4g
PiB0byBidWlsZCBpbiBhIHdheSB0byBpbnRlZ3JhdGUgd2l0aCBkZXZsaW5rIG5vdyBkZXZsaW5r
IGlzDQo+ID4gPiBncm93aW5nDQo+ID4gPiBleHRyYSBmZWF0dXJlcyBhZ2Fpbiwgd2hpY2ggcHJl
c3VtYWJseSB0aGUgb3RoZXIgQVBJIHdpbGwgYWxzbw0KPiA+ID4gbmVlZC4NCj4gPiA+IEFuZCB0
aGUgaW50ZWdyYXRpb24gbWF5IHR1cm4gb3V0IHRvIGJlIGNoYWxsZW5naW5nLg0KPiA+IA0KPiA+
IEFGQUlVIFBhb2xvJ3Mgd29yayBpcyBub3QgZm9yIHNoYXBlcnMgJ2Fib3ZlJyB0aGUgbmV0d29y
ayBkZXZpY2UNCj4gPiBsZXZlbCwgDQo+ID4gaS5lLiBncm91cHMuDQo+IA0KPiBXaGF0J3MgdGhl
IGRpZmZlcmVuY2UgYmV0d2VlbiBxdWV1ZSBncm91cCBhbmQgYSBWRj8NCj4gDQoNCkkndmUgbG9v
a2VkIG92ZXIgdGhlIGxhdGVzdCB2ZXJzaW9uIG9mIHRoZSBuZXQtc2hhcGVycyBBUEkuDQpUaGVy
ZSBpcyBzb21lIGNvbmNlcHR1YWwgb3ZlcmxhcCBiZXR3ZWVuIHRoaXMgcGF0Y2hzZXQgYW5kIG5l
dC1zaGFwZXJzDQphYmlsaXR5IHRvIGRlZmluZSBhIGdyb3VwIG9mIGRldmljZSBxdWV1ZXMgYW5k
IG1hbmlwdWxhdGUgaXRzIHR4DQpsaW1pdHMuIEJ1dCBhcyBmYXIgYXMgSSBhbSBhd2FyZSAoWzFd
KSwgdGhlIG5ldC1zaGFwZXJzIEFQSSBkb2Vzbid0DQppbnRlbmQgdG8gc2hhcGUgZW50aXRpZXMg
YWJvdmUgbmV0ZGV2IGxldmVsLg0KDQpTbyB0aGVyZSBhcmUgdHdvIHRoaW5ncyB0byBkaXNjdXNz
IGhlcmU6DQoxLiBJbnRlZ3JhdGluZyBkZXZpY2UtbGV2ZWwgVEMgc2hhcGluZyBpbnRvIG5ldC1z
aGFwZXJzLiBUaGUgbmV0LQ0Kc2hhcGVycyBtb2RlbCB3b3VsZCBuZWVkIHRvIGJlIGV4dGVuZGVk
IHdpdGggdGhlIGFiaWxpdHkgdG8gZGVmaW5lIFRDDQpxdWV1ZXMuIEF0IHRoZSBtb21lbnQgSSBz
ZWUgaXQncyBjb25jZXJuZWQgd2l0aCBkZXZpY2UgdHggcXVldWVzIHdoaWNoDQpkb24ndCBuZWNl
c3NhcmlseSBtYXAgMToxIHRvIHRyYWZmaWMgY2xhc3Nlcy4NCg0KVGhlbiwgaXQgd291bGQgbmVl
ZCB0byBoYXZlIHRoZSBhYmlsaXR5IHRvIGdyb3VwIFRDIHF1ZXVlcyBpbnRvIGEgbm9kZS4NCg0K
VGhlbiB0aGUgaW50ZWdyYXRpb24gc2hvdWxkIGJlIGVhc3kuIEVpdGhlciBBUEkgY2FuIGNhbGwg
dGhlIGRldmljZQ0KZHJpdmVyIGltcGxlbWVudGF0aW9uIG9yIG9uZSBBUEkgY2FuIGNhbGwgdGhl
IG90aGVyJ3MgZnVuY3Rpb24gdG8gZG8NCnNvLg0KDQpQYW9sbywgd2hhdCBhcmUgeW91ciB0aG91
Z2h0cyBvbiB0YyBzaGFwaW5nIGluIHRoZSBuZXQtc2hhcGVycyBBUEk/DQoNCjIuIFZGLWdyb3Vw
IFRDIHNoYXBpbmcuIFRoZSBjdXJyZW50IHBhdGNoc2V0IG9mZmVycyB0aGUgYWJpbGl0eSB0bw0K
c3BsaXQgVEMgYmFuZHdpZHRoIG9uIGEgZGV2bGluayByYXRlIG5vZGUsIGFwcGx5aW5nIHRvIGFs
bCBWRnMgaW4gdGhlDQpub2RlLiBBcyBmYXIgYXMgSSBhbSBhd2FyZSwgbmV0LXNoYXBlcnMgZG9l
c24ndCBpbnRlbmQgdG8gYWRkcmVzcyB0aGlzDQp1c2UgY2FzZS4gRG8gd2Ugd2FudCB0byBoYXZl
IHR3byBjb21wbGV0ZWx5IGRpZmZlcmVudCBBUElzIHRvDQptYW5pcHVsYXRlIHRjIGJhbmR3aWR0
aD8NCg0KQ29zbWluLg0KDQpbMV0NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi83MTk1
NjMwYS0xMDIxLTRlMWUtYjQ4Yi1hMDc5NDU0Nzc4NjNAcmVkaGF0LmNvbS8NCg==

