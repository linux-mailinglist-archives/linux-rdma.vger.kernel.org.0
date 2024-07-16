Return-Path: <linux-rdma+bounces-3886-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB6C9329CA
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2024 16:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7299C1C219A2
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2024 14:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82A719B59D;
	Tue, 16 Jul 2024 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="R0ky44Mt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2118.outbound.protection.outlook.com [40.107.21.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47DA1B947;
	Tue, 16 Jul 2024 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721141734; cv=fail; b=eMKDQQPwl58iDeGU2oZF5MtwpKXC3+wJ4SqtMim4KPMnqaGXg30fyUUzDKRM4I9Em0S5d1tgNR2pgQ2H0el+gRDUAKYjaAPewUMLbgIHC+zi3aVuLFAXIkqfywdzbtOGD5pSyK9q5MJ9ZSiZNOEav7nQaablMBXX/TfAVJ4pdc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721141734; c=relaxed/simple;
	bh=Jf18R49+WK5tv7YW7sLu2eSZx6ZBxKrfPQGhgFQN8vU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P9p34mSxWqcw8L1c99QMq/GsP+HbYo1TBIod9LrAefAp6xWZOGuo+HjSFO18eOAElqimo7fvVAQa6DeW4Yjgg4X0P5roaw7eyW9gKANloD198S++wftnCSb1OC2cbMvXHgI6v10z/UyTluLS5mg10dqU6WgVmyan9wxJly0mqlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=R0ky44Mt; arc=fail smtp.client-ip=40.107.21.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGmHuY/E7i7Tgs10xG42jmN1RMBFVyr0r77714nr7xpBbGMqFj3CDcjrH1b5UmqVMCS9ciqgXzuXVRDxGwTRdIj/UKR0Z6+dkaagac9BjCSy7oejXn82PPDbQr5GAE9DzMIuwBS6bT+USwG7bboh8vbGzCtOV5pEtQAZwugz5bnjJDj2JYdNQWeion6PzRE6a7gAerP3Jx/PXyhYZEEHDFCs0y6dSZYjKoqJXAUSE5GY75TbvbJnFv3nCZrdDcMytyhhQQJ1rXaCqLoP94XpULIz6EvX6Obb3L1v1EZI5nlzU+JBFiK9dfZ75rTJ7GpzCgBpaKwXsEhuDfjdATlW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jf18R49+WK5tv7YW7sLu2eSZx6ZBxKrfPQGhgFQN8vU=;
 b=o6h7vfVoEraGl4zAwBYQ+72vn4GHQX4Y8N8l2nk7Eq9OQf1Xm0poibBHQU7jcxMBPIy725cdjsVvFEuNDO4lGSbEmdH4jGCcvnNErvlOF/eeDWEnVb0FVMlUjfcGzs2mmnbb3s5/KEPxspAoRSH/ruxY/HqryIWMVFurlEqOsO8szNAovakYivA9PGi0dPvGL5b/WrRSuI1GlMAzglmL0tAXjoUcdCVbrC2A9w3cRlg2bU2y6xNOWTRrvWWmTezmNjMZLowJyDaBnLf//UauQbwYFL0UBkVv7OCX9UxalWnfIZOrV9CfEsehM8H3gXa+HPC/GjFnC79UHcE7mpVT5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jf18R49+WK5tv7YW7sLu2eSZx6ZBxKrfPQGhgFQN8vU=;
 b=R0ky44MtOxDzugKeUqpGeq3xEGzMB21iFRU/YahcNcA1b741uK4KimwbX1dhMro+mDNt5UNIAOKOQ3tTNuxKZKB/Se9aantWRJOxK31cMJxeDw/DouYZNBEE1F/H3dHyAXPKLcuqpkR24OoA70KNfFVtNGcEYyeroKFtkz4EMto=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by VI0PR83MB0713.EURPRD83.prod.outlook.com (2603:10a6:800:25d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.5; Tue, 16 Jul
 2024 14:55:26 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1%4]) with mapi id 15.20.7807.003; Tue, 16 Jul 2024
 14:55:26 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Konstantin Taranov <kotaranov@linux.microsoft.com>, Wei Hu
	<weh@microsoft.com>, "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: indicate that inline data is
 not supported
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: indicate that inline data is
 not supported
Thread-Index: AQHa15Axxh1tqRxLuk+cZ2Vxnf/mzA==
Date: Tue, 16 Jul 2024 14:55:26 +0000
Message-ID:
 <PAXPR83MB05595BBC92EB695753EB8563B4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <1721126889-22770-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240716111441.GB5630@unreal>
 <PAXPR83MB0559406ED7CCDAFC0CAEC63DB4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240716142223.GC5630@unreal>
In-Reply-To: <20240716142223.GC5630@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0fd30a16-fbfb-43f4-9090-30189f723470;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-16T14:30:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|VI0PR83MB0713:EE_
x-ms-office365-filtering-correlation-id: 7634e79a-7712-474d-4a8a-08dca5a75410
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b1B0K3FvcmVSeFZYTmFCUXhPRTF0WURvQ3dmK2xWaWhUZTFGSnVscStFWjBE?=
 =?utf-8?B?WXRsUmZrd09JMERSN3ZzZGJ0VFNTZHpDYytNZTJPbHpRMlFxVDY1THNIWDFQ?=
 =?utf-8?B?RXRrSCtIVmRRbFBPR25IajErcm5OWE8xMk1SYlVQTHhDWW1aVER6NytQbS92?=
 =?utf-8?B?QTA4QjJrOW1lam95SS83dExRYTNjWmNZeXFyQUh1ZStSZkFqaEZvRTZRY0Ri?=
 =?utf-8?B?Mno1SkUzYkwrR2VvWjdnYzl6NTdrSVIzWk9zUFdVTkxHVHdtWDNLakZpK3lB?=
 =?utf-8?B?Ti9tZ00xWklBRmhYUjhnaDFZUDI5akxhcHZSckY5WDB5OXl5RFhuYVRpT1VT?=
 =?utf-8?B?VU5hSDNpd2w0N3dJTFIzT25vcTFYTXlWSEloSTU2bGc1K3dvK1FHY1doa2Ix?=
 =?utf-8?B?dlZSWitwNDZlRlp4cy9Rd0FORHRHK2I5NzdlZVRsbkNZRnB3UDVFNFdvekFn?=
 =?utf-8?B?a0RMbkFjSDdRdENOZ25PWkRNUWpQQkJIV3Jtd2lkUVA4Q1NtdUQ5T2lkWVcr?=
 =?utf-8?B?aXU0QU9vZ3RIRW1Xa1puTEdtWG5wNmFpbWNQODNzNVo5L083VXRZenVlUjEw?=
 =?utf-8?B?WEVoeldqa1RKTWtlVjNORzlsV01CZXRHZUZ2NTVGeGt2S01wNUNUb2xUaHl5?=
 =?utf-8?B?OG5oMlJrdjV5YzhiU3VxajBRT1lpa2Y0Y0JNVkwvN05Sc05hZU0xWmY0TXp4?=
 =?utf-8?B?NWgyQm1Fb0pNWUVabEh6eERVV1MvWlRrZFp4T3pnenpJMWZ5TzBzeTBiSXlR?=
 =?utf-8?B?dHNZT0pMN1FBY0hxd1VFeGNGMWRSR2ZMNmNIcFpVaHpKMEY4elFmZnowWjB6?=
 =?utf-8?B?bzdDdzVnaW9reXRIV2phZm9wMytDWjJ5RWlrME5wcWgvRE1IZi9XNHQ0QVNK?=
 =?utf-8?B?bG8zZVdsYnRLd2c3UGMza3JOc3IzdFk5MHBiSTFodHdjSmpHckp0SCtBSnFJ?=
 =?utf-8?B?YXJVRlNGYm1COFlUb2RjZlozdUREdzNCcGIrNlBWWVBuYUVpeXdwZzkxMXZu?=
 =?utf-8?B?TnBzNGRiRzJiZkNiMmFNa2NsMit0OUo4NldGN1Z3bFJwUDEwVXlMbnd5d2N3?=
 =?utf-8?B?NmJQY051TGZnTldRRC9jOTVaZkV1Q1JwV1BDQ1pDbkV5Z1FYc2ZqK0w2RzR6?=
 =?utf-8?B?ekRxWjBEZEE3dTBlaWJPZzVFVWQ0NytIZkZzSDE4QzdKQnl6d3Y1ZzByUnpj?=
 =?utf-8?B?M0p5V2MwRzdlOUVYRytKQ05iZG9PT05ZdTNrUUFsbGFPUUoxdHVxTkU5WFI0?=
 =?utf-8?B?cXlhc0p1UG5IbHNJL0IyRmcxZlRuWDhLUWdSVEZpWDM1TE8xbzlSNklyeldL?=
 =?utf-8?B?ZGN6NWlSaENzR2tITW14UUVtTVlTdE82enVTWUg4VFpuZ00yMW1zb3pWMjlZ?=
 =?utf-8?B?SElkWi9pQmxHRXNIZENsUTdrbHM5UVkyODF1T1ppZitTNXA3aHl4MzV4WmFC?=
 =?utf-8?B?NXNxWWt5a3JjKzZJTGxXMzFlYWhrd2lNY1NTOEQ4S0VocVFMM09Gb2tYWDZ4?=
 =?utf-8?B?NDdnRkRsS3R0aXI3Tm1EeHhkUno1RlAwcXNDL0x0bjY4eDVSSG9NL0RMbHNG?=
 =?utf-8?B?SExoNlMzcElGUTRYbjh1aE1qczRqSmFwajFHNFJGSmFFTnlONkhxSVBrQmpw?=
 =?utf-8?B?SnYvNGVGeWFwWTdJVERkMGtYeVdaZVpuSHNWVXBIbDNpZ3krVGtwZk9RKzZE?=
 =?utf-8?B?VGFoYmJJWS8rV2pwUFJTSG9ZcnJoOGNVVEw4NVNPenVtdnp2VC9XblZVRjRh?=
 =?utf-8?B?M1E0Sk1FT2xXL3FoYitJY1NPcHdoQTRZUVIvTjRrYnNWUUxCWlg3eGV3dnlm?=
 =?utf-8?B?Vmd4V3U0V2tSb0d2RDdEbHJVaGlGajVlODNidDIvVmlDOUoycUsvNTFJaENx?=
 =?utf-8?B?eWtBeDNmbFZXbFMySXZoSFYrMk1IRDVkMFZJM0dVUlJzQnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFd5bFJnU3NCUVd6Y0NTZGlRT05mbkZmWHVKSmFJRlRxaWs2RE9jeG1mUnhx?=
 =?utf-8?B?M0NtTUFuMjc5bnh1UzcrNm1YdEVnUFJXTG15NDk3ZWUzdVVmRXM3VVRKcCtI?=
 =?utf-8?B?UzZvMkxuVHNFYmhGbTdKR3l2UWxvT2tQUXdHRDJ6MlYxV0ZxNE9PRHR3U1Iv?=
 =?utf-8?B?ekdOV0I0dzgrdmNFbzA4NUVmLzdkSXhwQ2o3SDNkRklHMWJqNWQrU2pxWERL?=
 =?utf-8?B?TTVqcmFiNUM4b2paQ3E4SnhBcVRQTDhyL1dUNDlGb0dQWHZQbW9sd09vN3dR?=
 =?utf-8?B?eUNBWkFINFNOaGhSZmNOU3BjbG1KMG5uNjJsOWU2M1V4NnhCUjJpNGdUSHJs?=
 =?utf-8?B?dzAvVWxPb1F3bU1EQmh3anFLQUcwMTRpcnRJTVNwelk2TWRVYkt5SFNKZ01h?=
 =?utf-8?B?cWlua3N4L3VQWWRyTFhOOW40OWhGVnpuMFJqdk5TakhCM1lqMktPV2R4OHh1?=
 =?utf-8?B?RWhZeU9kWElmSUx1MDFmQlNJRU9yUGR3MTdmeEN3VFA0SnoyNnhpdlRCbUZl?=
 =?utf-8?B?VncwVFk3Q3R1eEpxVXMranRGU1JIOHg1SjZ2SUwzeHJNbTMzT1JuT3ArYkRS?=
 =?utf-8?B?ZS9rdDFTQ05RYVF6ZnJ3cVVDL3VuQjZ0WWk4eTAxR2g3YUt6YWQvZVVBOXFP?=
 =?utf-8?B?U0Npc0kwVzJFd0RQelkyUUZJL1d5aGtUcjFHUXp3R2RxZEMxMVhMOC9FNDZZ?=
 =?utf-8?B?YXdhMUdmVUZSL3p1M1VCVUs3U2VqSGhBZS9RVGhJc0VIalN3cmlxNXByMlhk?=
 =?utf-8?B?L2oyeW1reTB3ckJBMFJoM0UrOHY1VU9RMndxZzB4TlIvWm5aZ2hYVGtsakEr?=
 =?utf-8?B?Z2k5M2wrek5pZzBqWE8rSFB5RmFGNXkzV0pXb0hDQXVmQkZQQ3hrMW9rK3pV?=
 =?utf-8?B?THFiaUdzS3pGTVlWUXJIS3FtNzY1ajUyMDc5VWRrVUEzWEVCeDhYSzNqeHM2?=
 =?utf-8?B?anFGZksrL1d4VmR6MWRlNjF4bFZWbTQ0VVFEOE4zRnovYVpRVzFYSVRPazlz?=
 =?utf-8?B?RCtvc1krcnR4eXZYWkZTeEF5U1pJSmhMV21vOGJJYlpxeFg1UUNPUi9FSVUx?=
 =?utf-8?B?RVhwbnlTTlBBNm93anl5QXVMRnQ3NzM4MlhlWXpGMHlNZWRWRFUzMzYvaFZI?=
 =?utf-8?B?V1pSK2lqRDNDdmhyOWxKNjhBNUtQWnlnQ0hMZVN6eDd0UU5VZVV1TndWcnk1?=
 =?utf-8?B?b0VzWUNQZkppWElubTJ1ckpvRWg2a3hleFB1ZE05YTJvTXBrRHNRSlE2QjBh?=
 =?utf-8?B?TjZUUlZyRTBiRnpmWTJCV3kxWlkzYm5lOGd6OEJVMlRNWWFPdFdXQk0xWkpV?=
 =?utf-8?B?NlFFVW1kQ0FsUDhzRTNQODN1d01tMUJSYWYzdlRMREk0ZEdiQjZaNDgvMzZk?=
 =?utf-8?B?dTRLMlBYOStnTHkyZzZUZGxCeDhSMEVtSnQ1bGFaeU41R3laaXUrTGdtRG9V?=
 =?utf-8?B?Mk1tWXlscnRKbG51aTYxN0xLNmhQZjZpeXpXTmtySTBCUnpOYmhDbW1iZUFl?=
 =?utf-8?B?YTltak50VEt6T2xPRjBwZWZ6RVpmUHI4bUdaL3FzVXo4c0lVMWN6MlhBQVpG?=
 =?utf-8?B?Y0o3VE9EYVE2bEc1ZTNVajkyOFF1RWd6SFdHVytBRnhzSWlQd0JZRFpuRnU1?=
 =?utf-8?B?WnVzbUFyK2UrQ2RRWEN3U2dBWWY1NDYyeE1kc1p2RHNzUmp0dWNSdU1odTJR?=
 =?utf-8?B?a3p0TW5PdDdGYm5MSm05L2plYjFXWFpIbWRHYS9CaW1ncWdqdUhzbVB0VzNM?=
 =?utf-8?B?ZFY5dDVtcHhmZUJGMW1vSWFHRHJ0K0hpd3BOaEd2aW5nbGNVcEsya2FudS94?=
 =?utf-8?B?U1hJMG41NW9aYk5tMHRHSjVHMllPL05wTXJWS1RPRUxjMWMrbjdKdm1tZXZC?=
 =?utf-8?B?bXJzUFl1aEcyNWJDQkNnOUJZa2NiOWVLR1BtSFNacm9Wa3Jyb2ZFWnJ6U2lI?=
 =?utf-8?B?U1JhQVJLeUdvTEhtaVlmam0rRnJob1BKYzFTVWJxcUNUVHBYR2FiOXBlWVht?=
 =?utf-8?B?c1YyRzQ2bmdDQ2s4OG9UVXBaTXhHUmZvNGZ2OXVaa3k0M2NPQXFjWEVsTDNq?=
 =?utf-8?Q?unZ9bs?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0559.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7634e79a-7712-474d-4a8a-08dca5a75410
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 14:55:26.7757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4e5MWesPadGOWMZ3wVtSWz1pTPyGLXM3r0nqDtPwhza0BbtX+ieU1Ixt6yXsfj+8GWn1eagCHmIggvb3yXnEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR83MB0713

PiA+ID4gPiBTZXQgbWF4X2lubGluZV9kYXRhIHRvIHplcm8gZHVyaW5nIFJDIFFQIGNyZWF0aW9u
Lg0KPiA+ID4gPg0KPiA+ID4gPiBGaXhlczogZmRlZmI5MTg0OTYyICgiUkRNQS9tYW5hX2liOiBJ
bXBsZW1lbnQgdWFwaSB0byBjcmVhdGUgYW5kDQo+ID4gPiA+IGRlc3Ryb3kgUkMgUVAiKQ0KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBLb25zdGFudGluIFRhcmFub3YgPGtvdGFyYW5vdkBtaWNyb3Nv
ZnQuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5h
L3FwLmMgfCAyICsrDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+
ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9x
cC5jDQo+ID4gPiA+IGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvcXAuYyBpbmRleCA3M2Q2
N2M4NTNiNmYuLmQ5ZjI0YTc2M2U3Mg0KPiA+ID4gPiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJp
dmVycy9pbmZpbmliYW5kL2h3L21hbmEvcXAuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL2luZmlu
aWJhbmQvaHcvbWFuYS9xcC5jDQo+ID4gPiA+IEBAIC00MjYsNiArNDI2LDggQEAgc3RhdGljIGlu
dCBtYW5hX2liX2NyZWF0ZV9yY19xcChzdHJ1Y3QgaWJfcXANCj4gPiA+ID4gKmlicXAsDQo+ID4g
PiBzdHJ1Y3QgaWJfcGQgKmlicGQsDQo+ID4gPiA+ICAJdTY0IGZsYWdzID0gMDsNCj4gPiA+ID4g
IAl1MzIgZG9vcmJlbGw7DQo+ID4gPiA+DQo+ID4gPiA+ICsJLyogaW5saW5lIGRhdGEgaXMgbm90
IHN1cHBvcnRlZCAqLw0KPiA+ID4gPiArCWF0dHItPmNhcC5tYXhfaW5saW5lX2RhdGEgPSAwOw0K
PiA+ID4NCj4gPiA+IENhbiB5b3UgcGxlYXNlIHBvaW50IHRvIG1lIHRvIHRoZSBmbG93IHdoZXJl
IGF0dHIgaXMgbm90IHplcm9lZCBiZWZvcmU/DQo+ID4gPg0KPiA+DQo+ID4gU29ycnksIEkgZG8g
bm90IHVuZGVyc3RhbmQgdGhlIHF1ZXN0aW9uLiBJIGNhbm5vdCBwb2ludCB0byBzb21ldGhpbmcg
dGhhdCBpcw0KPiBub3QgaW4gdGhlIGNvZGUuDQo+ID4NCj4gPiBJdCBpcyB0byBzdXBwb3J0IHRo
ZSBjYXNlIHdoZW4gdXNlciBhc2tzIGZvciB4IGJ5dGVzIGlubGluZWQgd2hlbiBpdA0KPiA+IGNy
ZWF0ZXMgYSBRUCwgYW5kIHdlIHJlc3BvbmQgd2l0aCBhY3R1YWwgYWxsb3dlZCBpbmxpbmUgZGF0
YSBmb3IgdGhlDQo+ID4gY3JlYXRlZCBRUC4gKGFzIGRlZmluZWQgaW46ICJUaGUgZnVuY3Rpb24g
aWJ2X2NyZWF0ZV9xcCgpIHdpbGwgdXBkYXRlDQo+ID4gdGhlIHFwX2luaXRfYXR0ci0+Y2FwIHN0
cnVjdCB3aXRoIHRoZSBhY3R1YWwgUVAgdmFsdWVzIG9mIHRoZSBRUCB0aGF0DQo+ID4gd2FzIGNy
ZWF0ZWQ7IikNCj4gPg0KPiA+IFRoZSBrZXJuZWwgbG9naWMgaXMgaW5zaWRlICJzdGF0aWMgaW50
IGNyZWF0ZV9xcChzdHJ1Y3QgdXZlcmJzX2F0dHJfYnVuZGxlDQo+ICphdHRycywgc3RydWN0IGli
X3V2ZXJic19leF9jcmVhdGVfcXAgKmNtZCkiDQo+ID4gd2hlcmUgd2UgZG8gdGhlIGZvbGxvd2lu
ZzoNCj4gPiBhdHRyLmNhcC5tYXhfaW5saW5lX2RhdGEgPSBjbWQtPm1heF9pbmxpbmVfZGF0YTsg
cXAgPQ0KPiA+IGliX2NyZWF0ZV9xcF91c2VyKC4uLCZhdHRyLC4uKTsNCj4gDQo+IEF3ZXNvbWUs
IGliX2NyZWF0ZV9xcF91c2VyKCkgaXMgY2FsbGVkIGV4YWN0bHkgaW4gdHdvIHBsYWNlcywgYW5k
IGluIGJvdGgNCj4gY2FzZXMgSSBzZWUgdGhpcyBsaW5lICJzdHJ1Y3QgaWJfcXBfaW5pdF9hdHRy
IGF0dHIgPSB7fTsgIg0KPiANCj4gSXQgbWVhbnMgdGhhdCBhdHRyIGlzIHplcm9lZC4NCj4gDQoN
CkkgdGhpbmsgdGhlcmUgaXMgc29tZSBtaXN1bmRlcnN0YW5kaW5nLg0KU28sIHRoZSBhdHRyIGlz
IHplcm9lZCBhdCBpbml0LiBUaGVuIGl0IGlzIGZpbGxlZCB3aXRoIHZhbHVlcyBmcm9tIHRoZSB1
c2VyIHJlcXVlc3QuDQpXaXRoDQoJYXR0ci5jYXAubWF4X3NlbmRfd3IgICAgID0gY21kLT5tYXhf
c2VuZF93cjsNCglhdHRyLmNhcC5tYXhfcmVjdl93ciAgICAgPSBjbWQtPm1heF9yZWN2X3dyOw0K
CWF0dHIuY2FwLm1heF9zZW5kX3NnZSAgICA9IGNtZC0+bWF4X3NlbmRfc2dlOw0KCWF0dHIuY2Fw
Lm1heF9yZWN2X3NnZSAgICA9IGNtZC0+bWF4X3JlY3Zfc2dlOw0KCWF0dHIuY2FwLm1heF9pbmxp
bmVfZGF0YSA9IGNtZC0+bWF4X2lubGluZV9kYXRhOw0Kb3Igd2l0aDoNCglzZXRfY2FwcygmYXR0
ciwgJmNhcCwgdHJ1ZSk7DQoNClNvIGF0IHRoaXMgbW9tZW50IHRoZXJlIGlzIGEgdmFsdWUgZnJv
bSB0aGUgdXNlciBpbiB0aGUgYXR0ciAoaXQgaXMgbm90IDApLg0KaWJfY3JlYXRlX3FwX3VzZXIg
aXMgY2FsbGVkIHdpdGggdGhlIGF0dHIuDQoNClRoZSBkcml2ZXJzIGFyZSBhbGxvd2VkIHRvIHR1
bmUgdGhlIGNhcCB2YWx1ZXMgZHVyaW5nIFFQIGNyZWF0ZS4NClNvIEkgd2FudCB0byBzZXQgaXQg
dG8gMCBhcyBzb21lIG90aGVyIHByb3ZpZGVzIChzZWUgcHZyZG1hX2NyZWF0ZV9xcCwNCnJ2dF9j
cmVhdGVfcXAsIHNldF9rZXJuZWxfc3Ffc2l6ZSBmcm9tIG1seDQpLg0KDQpBZnRlciB0aGUgZHJp
dmVyIGNhbGwgaGFzIGhhcHBlbmVkLCB0aGUgbW9kaWZpZWQgY2FwIHZhbHVlIGFyZSBjb3BpZWQg
dG8gdGVtcCB2YXJpYWJsZToNCglyZXNwLmJhc2UubWF4X3JlY3Zfc2dlICAgID0gYXR0ci5jYXAu
bWF4X3JlY3Zfc2dlOw0KCXJlc3AuYmFzZS5tYXhfc2VuZF9zZ2UgICAgPSBhdHRyLmNhcC5tYXhf
c2VuZF9zZ2U7DQoJcmVzcC5iYXNlLm1heF9yZWN2X3dyICAgICA9IGF0dHIuY2FwLm1heF9yZWN2
X3dyOw0KCXJlc3AuYmFzZS5tYXhfc2VuZF93ciAgICAgPSBhdHRyLmNhcC5tYXhfc2VuZF93cjsN
CglyZXNwLmJhc2UubWF4X2lubGluZV9kYXRhID0gYXR0ci5jYXAubWF4X2lubGluZV9kYXRhOw0K
b3Igd2l0aDoNCglzZXRfY2FwcygmYXR0ciwgJmNhcCwgZmFsc2UpOw0KQW5kIHRoZW4gY29waWVk
IHRvIHRoZSB1c2VyIHdpdGg6DQoJdXZlcmJzX3Jlc3BvbnNlKGF0dHJzLCAmcmVzcCwgc2l6ZW9m
KHJlc3ApKTsNCm9yIHdpdGgNCgl1dmVyYnNfY29weV90b19zdHJ1Y3Rfb3JfemVybyhhdHRycywN
CgkJCQkJVVZFUkJTX0FUVFJfQ1JFQVRFX1FQX1JFU1BfQ0FQLCAmY2FwLA0KCQkJCQlzaXplb2Yo
Y2FwKSk7DQoNCkRvIHlvdSBhZ3JlZSB0aGF0IG15IHBhdGNoIHNvbHZlcyBhIHByb2JsZW0gaW4g
bWFuYV9pYiAodGhlcmUgaXMgbm8gcHJvYmxlbSBpbiBjb3JlKT8NCk9yIGRvIHlvdSB0aGluayB0
aGF0IEkgYW0gdHJ5aW5nIHRvIHNvbHZlIG5vbi1leGlzdGVudCBwcm9ibGVtPw0KDQpUaGFua3MN
Cg0KPiBUaGFua3MNCj4gDQo+ID4gcmVzcC5iYXNlLm1heF9pbmxpbmVfZGF0YSA9IGF0dHIuY2Fw
Lm1heF9pbmxpbmVfZGF0YTsNCj4gPg0KPiA+IFNvLCBteSBjaGFuZ2UgbWFrZXMgc3VyZSB0aGF0
IHRoZSByZXNwb25zZSB3aWxsIGhhdmUgMCBhbmQgbm90IHRoZQ0KPiA+IHZhbHVlIHRoZSB1c2Vy
IGFza2VkLCBhcyB3ZSBkbyBub3Qgc3VwcG9ydCBpbmxpbmluZy4gU28gd2l0aG91dCB0aGUNCj4g
PiBmaXgsIHRoZSB1c2VyIHdobyB3YXMgYXNraW5nIGZvciBpbmxpbmluZyB3YXMgZmFsc2VseSBz
ZWVpbmcgdGhhdCB3ZSBzdXBwb3J0DQo+IGl0IChleGFtcGxlIG9mIHN1Y2ggYW4gYXBwbGljYXRp
b24gaXMgcmRtYV9zZXJ2ZXIgZnJvbSBsaWJyZG1hY20pLg0KPiA+DQo+ID4gVGhhbmtzDQo+ID4N
Cj4gPiA+IFRoYW5rcw0KPiA+ID4NCj4gPiA+ID4gIAlpZiAoIXVkYXRhIHx8IHVkYXRhLT5pbmxl
biA8IHNpemVvZih1Y21kKSkNCj4gPiA+ID4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiA+DQo+
ID4gPiA+IC0tDQo+ID4gPiA+IDIuNDMuMA0KPiA+ID4gPg0K

