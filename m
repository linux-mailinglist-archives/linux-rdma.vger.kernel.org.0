Return-Path: <linux-rdma+bounces-2708-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7488D51B7
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 20:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02ADC1C22752
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 18:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F41D4C602;
	Thu, 30 May 2024 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ST0HIb5t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5945745BE7
	for <linux-rdma@vger.kernel.org>; Thu, 30 May 2024 18:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717093392; cv=fail; b=t0GNUdFbAnlhwNEuTlyWnztbR82oWF8NPqKIjU7k4LGRzOg9dhDUO1DIvY5ltmaQMMaCcVXcUcoP/rsyGxTE4LAJHwozDfFXInUNMNvLt1ddI7vEAPz2fOJeEO/pIVT6UWqdpMnEL3tgtTJpUVU/0fxeMeUA+YhK/ErWr3Xjopg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717093392; c=relaxed/simple;
	bh=ejbLikR4ixNxym8FN+oZLHJwgoHa9CNPmCEEM2t3Na4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ld5b1/rjrlMbNwJD06vGYMzJvVj6dFLMhli0FXhk0b5F4Wn9HSM5mn/20iiedMZJ4jEOUuSazAdqTBuXv8ryFLNz3KmeHGcPTsTxVA+ryvwV/u9TfqMq4eA1qv7ro8nFagCxp/vMpL0mY9j4gNUxQHhMShjMHnH8/Z5Uq1aTyHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ST0HIb5t; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhV3NluFYCWbdK4R3jZYNOGWzwA/P8CGW+anvMb+8wFuFBtcLXsx9EqUb6/Mfg1zqCw27sDhYNPN3AaFTVnMod2RHMB2E8JXdgVu2vAzdusJ/KCIlVslRJtsnMa6rxCWupzZeEs17gB5ZES59gubxqjX3nvoOhtnhxmbz59PkLRfW5a7wGcVMk/ITWYkkt7+gCo+ediwzNK3/IpKBKumk+0Tb1fMHXHLSrls+IQdEfDyPa+63unyu58acCjiOOWBZbfNTRrlXL7R+U5bTMzPzf+lulXXtOtTm2HK+FIneO2u48HJwo6OIWE0luEHRaIoqi8Er3mIl1+6gHAqHkmc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejbLikR4ixNxym8FN+oZLHJwgoHa9CNPmCEEM2t3Na4=;
 b=oGMDX0k5OgNz+s55szDUi4Ii2Kf9efa/QUhU0+dwoPjmvG4mcGIyf/06x9jr/dmwlVpHoqkEnOojWlIMp6piVrtLzZej8IduJ/bOVXzTWz93oN9+MAVEIXRMB22hJb1usFpoGaX8mm2qHpK4EgrCY3V+kGSjpjBW/3f80hIIqW2RV8ocbcSy5Yi4fdjN9ClQecxq6DuyUEWZ5k3Tf2SRac5mOgcVja8wspCbib/fQ/ya7fpVQvMI2MYOVLsmRjX2S2LQO9fshnQATQ74f+LCUk2iCiSf0Vt6YeLMUEo5slfqF9aogF8WFllz4aalUgpLojkAakb9/xoB57H66cGRnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejbLikR4ixNxym8FN+oZLHJwgoHa9CNPmCEEM2t3Na4=;
 b=ST0HIb5tCxcIo/kM8skGnpfTGijn57CBOdDePHpQJ2TDjeqz4R+rfAQhfx6ukKYC44c4Jc7Qz1VL/apTZOdpV2xtMkDeLxlIzIq9NO4MXlPcyxXz4NMnPey5wP8+xxi7sPdBbWuwxDHMuO2bAWh28OTBKSL82LYoGKZ8rQDKmTX+zkMJPd8X38FrbBDvoNPzn2p1iCMAuMG75dJF6V6tsiQbCPRDVz8Dvv31wBqK5HPrYGXbDMl/H/WCErtCNEeS8K6dYXXuLeP8WQxJdznn3JGmWtJUC5RBEpqidyHhWJihJaehIF54FfT6g4Cp4wG7d7JIxGXNXEiMFJWcg2sM2A==
Received: from SN7PR12MB6840.namprd12.prod.outlook.com (2603:10b6:806:264::14)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 18:23:06 +0000
Received: from SN7PR12MB6840.namprd12.prod.outlook.com
 ([fe80::c07d:14d:c611:903f]) by SN7PR12MB6840.namprd12.prod.outlook.com
 ([fe80::c07d:14d:c611:903f%5]) with mapi id 15.20.7611.025; Thu, 30 May 2024
 18:23:03 +0000
From: Sean Hefty <shefty@nvidia.com>
To: Jinpu Wang <jinpu.wang@ionos.com>, "Gonglei (Arei)"
	<arei.gonglei@huawei.com>
CC: Peter Xu <peterx@redhat.com>, Yu Zhang <yu.zhang@ionos.com>, Michael
 Galaxy <mgalaxy@akamai.com>, Elmar Gerdes <elmar.gerdes@ionos.com>,
	zhengchuan <zhengchuan@huawei.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
	<berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Zhijian Li
 (Fujitsu)" <lizhijian@fujitsu.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf
	<kwolf@redhat.com>, Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
	Prasanna Kumar Kalever <prasanna4324@gmail.com>, Paolo Bonzini
	<pbonzini@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"devel@lists.libvirt.org" <devel@lists.libvirt.org>, Hanna Reitz
	<hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth
	<thuth@redhat.com>, Eric Blake <eblake@redhat.com>, Song Gao
	<gaosong@loongson.cn>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?=
	<marcandre.lureau@redhat.com>, =?utf-8?B?QWxleCBCZW5uw6ll?=
	<alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
	Beraldo Leal <bleal@redhat.com>, Pannengyuan <pannengyuan@huawei.com>,
	Xiexiangyou <xiexiangyou@huawei.com>, Fabiano Rosas <farosas@suse.de>, RDMA
 mailing list <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Thread-Topic: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Thread-Index: AQHasYFlL7/k5NcYE0eGwMvWFUneprGwEXkQ
Date: Thu, 30 May 2024 18:23:03 +0000
Message-ID:
 <SN7PR12MB6840BBC38BD6E7D7665607ACBDF32@SN7PR12MB6840.namprd12.prod.outlook.com>
References: <Zjj0xa-3KrFHTK0S@x1n>
 <addaa8d094904315a466533763689ead@huawei.com> <ZjpWmG2aUJLkYxJm@x1n>
 <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com> <ZjzaIAMgUHV8zdNz@x1n>
 <CAHEcVy48Mcup3d3FgYh_oPtV-M9CZBVr4G_9jyg2K+8Esi0WGA@mail.gmail.com>
 <04769507-ac37-495d-a797-e05084d73e64@akamai.com>
 <CAHEcVy4d7uJENZ1hRx2FBzbw22qN4Qm0TwtxvM5DLw3s81Zp_g@mail.gmail.com>
 <Zk0c51D1Oo6NdIxR@x1n> <2308a8b894244123b638038e40a33990@huawei.com>
 <ZlX-Swq4Hi-0iHeh@x1n> <7bf81ccee4bd4b0e81e3893ef43502a8@huawei.com>
 <CAMGffEmGDDxttMhYWCBWwhb_VmjU+ZeOCzwaJyZOTi=yH_jKRg@mail.gmail.com>
In-Reply-To:
 <CAMGffEmGDDxttMhYWCBWwhb_VmjU+ZeOCzwaJyZOTi=yH_jKRg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6840:EE_|CH3PR12MB8755:EE_
x-ms-office365-filtering-correlation-id: 444a5794-69f2-4873-c08e-08dc80d58b63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|7416005|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?WXltMGxuejdFbW9kZDg2bkZJajhSMmd1eFlmdmdQbW9ablIvanF5bVJtZUkx?=
 =?utf-8?B?WnJPSTJBV3RIZWFFdEVXa3pwR1RQMERXcDVnREMyZXpDWDFPYitPWExCTmFj?=
 =?utf-8?B?aWZ0OWM5eGFrVlNWSHBKTlVncDlrcnJ4ZUNqUzFGcUhtRTFiSmE2b3VoUC80?=
 =?utf-8?B?T0p0SUdMZEU2UUJJQnpTRXN5M2NJTmRLNzJVamtaYlBTQjZTck5RckVvM0p2?=
 =?utf-8?B?L3pEcG9PYWdOV1NYY0NXNEw1VUtGQzRNRC9tRDRya3FHTEowa2ltSWdpeUNn?=
 =?utf-8?B?RmpaVjlFNkg3REY5T05QbFpuWjlqOUVGUHIyUVdMMDJkS1JUK0hDQ1k4c3cz?=
 =?utf-8?B?Zmk5N1pKRzBtcFJwbWtESDFBUWJNLzJ1UGMvQ1kvOG9PMElxRGFORC9BeGNE?=
 =?utf-8?B?Zld6SGhpL0VpK0N1MG8zNWwvUmViWFh0Z2JSbDlONFl6Q3ZINkVadmdia1hn?=
 =?utf-8?B?dDBXZkJTRDBRZSsxRkNFZ3FLWkJtSld2YkQxbWhGa2g3ODlIS0xzT2dpcjNt?=
 =?utf-8?B?MEkrTWtWcnVhOTV4Lytacis5L0tNdmxBbXNUNGpYQUZtcGpJdjMyY253eTda?=
 =?utf-8?B?a2NPTVhJMTdzVStOOGdhdnZrYlhaYktncXNwTk1JNCtHcUVueGYxTzdIajAy?=
 =?utf-8?B?VEtMblNpZ3lwV1VPZHc0MnNEaUYyZ1habFJsVSs1ZldhNlVwcXkzZzlGMGUz?=
 =?utf-8?B?S1h5VStQWUhzd1VoTzBzVlNGUS84UTRVQS9PUGhKd2l0dTNIdk80Q0s1Tldy?=
 =?utf-8?B?MjVXT0owZG9jUFg0RXE5b2I0OENxR1k2dm5iRmM5dzExTDBaM3p0Z2t1bWZa?=
 =?utf-8?B?cUJaNXRwb3cwR2p2NWZwS2pBd0VnSURwS1M3VHNwOENMYkJkNTRYMWN3bXF1?=
 =?utf-8?B?TzRnQVNZZHpHdkE1UG1rT1hLVHFjQWpvS2VnKzVENUVXaEZ1SExCWEpwclV6?=
 =?utf-8?B?STZoR1I0RTU3bXdDR043RVNGU3BOeGQ4VC9idmU5S1B0SjcranRHWUJsLzlp?=
 =?utf-8?B?MkZIZHNqWVdhLzUwV3FkYjJ3SzVJOUxuMXBRbHpvZkZmcGJuc0V2OGFkVERQ?=
 =?utf-8?B?cnEycnhDVUNHaTgvOTBoOGFKMFAzR2QxeHNWdkk3MjU3TmYzbHFPN1Q0eWxC?=
 =?utf-8?B?MVBGa0VuVWNBekltSUhaQVBzbzFzdGVaYVZqVjFTZFVGd3A1N3ZIdStZdGdz?=
 =?utf-8?B?UHVrM0haSWpzTngxMmdnM1FEUmF4ODlRRzE5NzIxT2Zubkk3d002Wll5NXZr?=
 =?utf-8?B?Sm4vM1NueDRRME5sMDREb3BFV0R0RUd0RmNaRmlhTmxsZ0FJZWpheEhyWGJG?=
 =?utf-8?B?UnpNY1dLRVVPN0wxL1RYUkdCaE1zWFVPYU95eHFnWi8wR1NaWEY0M1RmNlc2?=
 =?utf-8?B?M05nU0pBVkZIU0JaZlJpdjlzK3kwN3JtNWZTdzl0aVZSQUpqNFkzcloxVC9q?=
 =?utf-8?B?dDAwa2tCaDNQK1hkaEhtM1UxK1hGc1UvMjEzMjMvY0dpdzhLZytSc2toUitT?=
 =?utf-8?B?b3JzK0o4ZFFjK2RkZXRjQXptaUM1QW9VZEU5M3AyenVFZkxTSS91U1QyTTJl?=
 =?utf-8?B?MnYyVENHRy9wL2Fab1JXWmxYNVFuWmd6Rm5seTc5MUx2RHRjTUIwRldxbzdW?=
 =?utf-8?B?WnVHcXp6K1RyZFZRWitUKzE0WXpOZGoyd1hYaE9qdVhEOGsxSGVtekNSdXBy?=
 =?utf-8?B?VW5ZZjBNeTZ0YnJaZkhIdjRQTFJWTG1nN0cwM0xHd0FTQ2JadW5UdlMzUkZu?=
 =?utf-8?B?TldSNWxzUXkxdmZWcmEvaVFYWm1lZG5Zc3h6NU05UzR0Q1J0SHIvbUV4ZFY5?=
 =?utf-8?B?R05VR2huMzhqZVNqT1drdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6840.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eG5Id2lDVjhSeVdjaVh1NmlwOFYyd1h3b0pzS05hUnBncThDV0NMa0dodnBm?=
 =?utf-8?B?dENWN2RSZWc4dVVybTVYM0tBNHd4R1kxTU5XZEZQdXFUNHZVOXUxQkZDQTRP?=
 =?utf-8?B?RUV3RXNjK3BEVVBpOVQyb0FVQjdZMy9VRW1JMFc1ZkhRckZlNmVyaFZXay9W?=
 =?utf-8?B?RnIwOW8xSy9OdktQRVgxT2tmQjFDMWhqY3BKWmE2NnI5aG90aC9ZRkJuQ05k?=
 =?utf-8?B?eVFNcFYyeEhxWElhMWxFaUhRaHNGWHRpUytpdmZMWlRIN2VkdDZCS20zTTNS?=
 =?utf-8?B?WHZtZXpocUVzaExiK2dtK2dZclh4elRONGFQMW50dlJJT1lsS0V2SWJWd05S?=
 =?utf-8?B?WnNUVStZQTNTZXJDSGltUkpFM0ZHNFpOYTlLelVVbHFzZ1NYT2VFcHNSdW9w?=
 =?utf-8?B?Yk5JU2NkTjBIVElmdjhnalBwNURaeENnWFA1bWo0VjBWQmMxdmo1VUhhTGND?=
 =?utf-8?B?WFYxNlBnY2g2Uk8xbXRuekNrREZsaE1rWkpqQ05MTllibnVnYXUwTFJyK015?=
 =?utf-8?B?cC9SQ2gvMFBsOXZnY2g5M2UwUExSL0Y2eHI1bVZ1a3A3Wi9uTlFXRHU3dmdl?=
 =?utf-8?B?MVBaRzdtcjNJQU1UWkR0aEhpRzRUM1BkSnc3TnZHMS90MThLRkpMVXMzSU04?=
 =?utf-8?B?S3hQMTVDSEVVNkY3WHBENktja3lRWE01cGhhSEc1cGdPUmRoZ1MxbWRFeVo2?=
 =?utf-8?B?RUQxVy9sRWNBOWU2Yy9saW9nR0psZEdMYzdZR1l1OThkc0w5L3JjMTk4YU9I?=
 =?utf-8?B?L1d1Y0RFWVQzMGI1VmUxVHdjdzJ6MDFNZGdINXpQalpXYURoWFo1eCtLVGRx?=
 =?utf-8?B?ZFVHbndFNm5RTkY4OXFMWHN1blNZVEIyZEZOTkNxQTFoODhMNXdkL2RGTkM2?=
 =?utf-8?B?VGdNOFJCdkZGcGUrV0o1eStlRWxYR1psSnZCOGMyOGJsNXdkajhvejNvcFR3?=
 =?utf-8?B?T2lSN0gvWmMvcFo0Y2hXSjg1b1NyZzVzN0NTeG9UeXF1U1UyMHh4aUZJREpa?=
 =?utf-8?B?aXN6Y1preml1K3ZQMVg2T252OXR2S3QxWDc2OUtCN3JGeWJJK1gwTmx4WGVi?=
 =?utf-8?B?M0hNMnBtNEtSaEljRVdHUlQzVENSWkhQVERxdUtNaWlJaEpTUDVkWDU5Q2py?=
 =?utf-8?B?bUszOGhLVGdBdXZtdWNpejIxTWJjNDR2MnE0Tkp6Z2k0TDFQcU96L0RZUGt1?=
 =?utf-8?B?akxpeXNzVkIvMkluLzUwbTRQZFRFNVNkTmg1WWdpOEo1Y2lQM0JLVmhYTGFr?=
 =?utf-8?B?RCtjYXBlOHgrd0hsUFFjak9IRHN2b0w0QWh3WXpNSGNIamoyWS8rZXpIc0lX?=
 =?utf-8?B?ak1NMHprMlRQQyt4cW9qK3d3MHZVUE0yQlpNY1QyMURFOVE1VnZEWHNWUFNk?=
 =?utf-8?B?NVJwTmY4N1B0dnEzazJ6NmIwdUpwbUVuRW9lN0NHem4vRkpMM0xoUWFHTnMw?=
 =?utf-8?B?KzhmOWJNY2dGVm42dU8xUHNncWR6M1BtKzY0K1FjTExMQ2FuM1o2QlhqUFRS?=
 =?utf-8?B?ZkpuQW1jNnFHL0hlL3MrQkphbkRka2pIN2ltS0hBNWpHcjh3aDMvQVVrSEVF?=
 =?utf-8?B?NHNwOE56S0ZsNnJYZ1RPUkJvQUdXZGVhbjlYQll0NldSMFhiS01HdWtRdGZq?=
 =?utf-8?B?by84YWdxVUpwc3N3OG9aT2lmdDNIM2xSWS9FWkVZcmVRU054aWFsSFJkSGt2?=
 =?utf-8?B?S2tQUlVHaGlndmhTWEJaZDRBMmVTQzR1dkJTWkpSZk9HZ2IyYVozeHNFdENQ?=
 =?utf-8?B?ME9vRU5wSjhJWkVFMUhJTFAvL0wwQ1VVOTQwN0NBMjhCQ3pMUThvSVAreks3?=
 =?utf-8?B?anA2V1UwMVlKcEJpbTBPSFNTRGhUd0Y1ckpFZjExTG9KTzJWY1o4cG10QWVW?=
 =?utf-8?B?Nmp1eUhma3YvMk1ZU2lNcHh5dGk2ZWZ0eFJOU0ROWWFYRXJ4VEw3Z25URDEz?=
 =?utf-8?B?SnlqbEtWclArbmVYRTQyNko4eWJ4SVJ6RkczY0M0OEtETEg3TEtGeUlvTmdz?=
 =?utf-8?B?dWgyVVdzYVlUd3JBOGpMbldUaEFGUmwwcVhTM2lRbktaQkV3b3VQUEx6Zzhp?=
 =?utf-8?B?TEhqRk9TQ0FISkRCT01lU3ZOTXZhWkN5UmxiTDRWOTZOVWtiaGR4S2o4Q2U1?=
 =?utf-8?B?TzBTbWFXSC9PS3I3K3EyeHF0MUJBNWxPak5HbjdrdHZvWVlaamtNazh4cmxh?=
 =?utf-8?B?Tnc9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444a5794-69f2-4873-c08e-08dc80d58b63
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 18:23:03.4226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cv6dWetOZgDOnKEPMR4iShF8aVo3cPSL3u4U6PCCfvJGHJUennN1HgCkAlzdEA6TPVavruZl8hmhwoz4pSG3sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755

PiA+IEZvciByZG1hIHByb2dyYW1taW5nLCB0aGUgY3VycmVudCBtYWluc3RyZWFtIGltcGxlbWVu
dGF0aW9uIGlzIHRvIHVzZQ0KPiByZG1hX2NtIHRvIGVzdGFibGlzaCBhIGNvbm5lY3Rpb24sIGFu
ZCB0aGVuIHVzZSB2ZXJicyB0byB0cmFuc21pdCBkYXRhLg0KPiA+DQo+ID4gcmRtYV9jbSBhbmQg
aWJ2ZXJicyBjcmVhdGUgdHdvIEZEcyByZXNwZWN0aXZlbHkuIFRoZSB0d28gRkRzIGhhdmUNCj4g
PiBkaWZmZXJlbnQgcmVzcG9uc2liaWxpdGllcy4gcmRtYV9jbSBmZCBpcyB1c2VkIHRvIG5vdGlm
eSBjb25uZWN0aW9uDQo+ID4gZXN0YWJsaXNobWVudCBldmVudHMsIGFuZCB2ZXJicyBmZCBpcyB1
c2VkIHRvIG5vdGlmeSBuZXcgQ1FFcy4gV2hlbg0KPiBwb2xsL2Vwb2xsIG1vbml0b3JpbmcgaXMg
ZGlyZWN0bHkgcGVyZm9ybWVkIG9uIHRoZSByZG1hX2NtIGZkLCBvbmx5IGEgcG9sbGluDQo+IGV2
ZW50IGNhbiBiZSBtb25pdG9yZWQsIHdoaWNoIG1lYW5zIHRoYXQgYW4gcmRtYV9jbSBldmVudCBv
Y2N1cnMuIFdoZW4NCj4gdGhlIHZlcmJzIGZkIGlzIGRpcmVjdGx5IHBvbGxlZC9lcG9sbGVkLCBv
bmx5IHRoZSBwb2xsaW4gZXZlbnQgY2FuIGJlIGxpc3RlbmVkLA0KPiB3aGljaCBpbmRpY2F0ZXMg
dGhhdCBhIG5ldyBDUUUgaXMgZ2VuZXJhdGVkLg0KPiA+DQo+ID4gUnNvY2tldCBpcyBhIHN1Yi1t
b2R1bGUgYXR0YWNoZWQgdG8gdGhlIHJkbWFfY20gbGlicmFyeSBhbmQgcHJvdmlkZXMNCj4gPiBy
ZG1hIGNhbGxzIHRoYXQgYXJlIGNvbXBsZXRlbHkgc2ltaWxhciB0byBzb2NrZXQgaW50ZXJmYWNl
cy4gSG93ZXZlciwNCj4gPiB0aGlzIGxpYnJhcnkgcmV0dXJucyBvbmx5IHRoZSByZG1hX2NtIGZk
IGZvciBsaXN0ZW5pbmcgdG8gbGluayBzZXR1cC1yZWxhdGVkDQo+IGV2ZW50cyBhbmQgZG9lcyBu
b3QgZXhwb3NlIHRoZSB2ZXJicyBmZCAocmVhZGFibGUgYW5kIHdyaXRhYmxlIGV2ZW50cyBmb3IN
Cj4gbGlzdGVuaW5nIHRvIGRhdGEpLiBPbmx5IHRoZSBycG9sbCBpbnRlcmZhY2UgcHJvdmlkZWQg
YnkgdGhlIFJTb2NrZXQgY2FuIGJlIHVzZWQNCj4gdG8gbGlzdGVuIHRvIHJlbGF0ZWQgZXZlbnRz
LiBIb3dldmVyLCBRRU1VIHVzZXMgdGhlIHBwb2xsIGludGVyZmFjZSB0byBsaXN0ZW4gdG8NCj4g
dGhlIHJkbWFfY20gZmQgKGdvdHRlbiBieSByYWNjZXB0IEFQSSkuDQo+ID4gQW5kIGNhbm5vdCBs
aXN0ZW4gdG8gdGhlIHZlcmJzIGZkIGV2ZW50LiBPbmx5IHNvbWUgaGFja2luZyBtZXRob2RzIGNh
biBiZQ0KPiB1c2VkIHRvIGFkZHJlc3MgdGhpcyBwcm9ibGVtLg0KPiA+DQo+ID4gRG8geW91IGd1
eXMgaGF2ZSBhbnkgaWRlYXM/IFRoYW5rcy4NCg0KVGhlIGN1cnJlbnQgcnNvY2tldCBjb2RlIGFs
bG93cyBjYWxsaW5nIHJwb2xsKCkgd2l0aCBub24tcnNvY2tldCBmZCdzLCBzbyBhbiBhcHAgY2Fu
IHVzZSBycG9sbCgpIGRpcmVjdGx5IGluIHBsYWNlIG9mIHBvbGwoKS4gIEl0IG1heSBiZSBlYXNp
ZXN0IHRvIGFkZCBhbiBycHBvbGwoKSBjYWxsIHRvIHJzb2NrZXRzIGFuZCBjYWxsIHRoYXQgd2hl
biB1c2luZyBSRE1BLg0KDQpJbiBjYXNlIHRoZSBlYXN5IHBhdGggaXNuJ3QgZmVhc2libGU6DQoN
CkFuIGV4dGVuc2lvbiBjb3VsZCBhbGxvdyBleHRyYWN0aW5nIHRoZSBhY3R1YWwgZmQncyB1bmRl
ciBhbiByc29ja2V0LCBpbiBvcmRlciB0byBhbGxvdyBhIHVzZXIgdG8gY2FsbCBwb2xsKCkvcHBv
bGwoKSBkaXJlY3RseS4gIEJ1dCBpdCB3b3VsZCBiZSBub24tdHJpdmlhbC4NCg0KVGhlICdmZCcg
dGhhdCByZXByZXNlbnRzIGFuIHJzb2NrZXQgaGFwcGVucyB0byBiZSB0aGUgZmQgcmVsYXRlZCB0
byB0aGUgUkRNQSBDTS4gIFRoYXQncyBiZWNhdXNlIGFuIHJzb2NrZXQgbmVlZHMgYSB1bmlxdWUg
aW50ZWdlciB2YWx1ZSB0byByZXBvcnQgYXMgYW4gJ2ZkJyB2YWx1ZSB3aGljaCB3aWxsIG5vdCBj
b25mbGljdCB3aXRoIGFueSBvdGhlciBmZCB2YWx1ZSB0aGF0IHRoZSBhcHAgbWF5IGhhdmUuICBJ
IHdvdWxkIGNvbnNpZGVyIHRoZSBmZCB2YWx1ZSBhbiBpbXBsZW1lbnRhdGlvbiBkZXRhaWwsIHJh
dGhlciB0aGFuIHNvbWV0aGluZyB3aGljaCBhbiBhcHAgc2hvdWxkIGRlcGVuZCB1cG9uLiAgKEZv
ciBleGFtcGxlLCB0aGUgJ2ZkJyB2YWx1ZSByZXR1cm5lZCBmb3IgYSBkYXRhZ3JhbSByc29ja2V0
IGlzIGFjdHVhbGx5IGEgVURQIHNvY2tldCBmZCkuDQoNCk9uY2UgYW4gcnNvY2tldCBpcyBpbiB0
aGUgY29ubmVjdGVkIHN0YXRlLCBpdCdzIHBvc3NpYmxlIGFuIGV4dGVuZGVkIHJnZXRzb2Nrb3B0
KCkgb3IgcmZjbnRsKCkgY2FsbCBjb3VsZCByZXR1cm4gdGhlIGZkIHJlbGF0ZWQgdG8gdGhlIENR
LiAgQnV0IGlmIGFuIGFwcCB0cmllZCB0byBjYWxsIHBvbGwoKSBvbiB0aGF0IGZkLCB0aGUgcmVz
dWx0cyB3b3VsZCBub3QgYmUgYXMgZXhwZWN0ZWQuICBGb3IgZXhhbXBsZSwgaXQncyBwb3NzaWJs
ZSBmb3IgZGF0YSB0byBiZSBhdmFpbGFibGUgdG8gcmVjZWl2ZSBvbiB0aGUgcnNvY2tldCB3aXRo
b3V0IHRoZSBDUSBmZCBiZWluZyBzaWduYWxlZC4gIENhbGxpbmcgcG9sbCgpIG9uIHRoZSBDUSBm
ZCBpbiB0aGlzIHN0YXRlIGNvdWxkIGxlYXZlIHRoZSBhcHAgaGFuZ2luZy4gIFRoaXMgaXMgYSBu
YXR1cmFsPyByZXN1bHQgb2YgcmFjZXMgaW4gdGhlIFJETUEgQ1Egc2lnbmFsaW5nLiAgSWYgeW91
IGxvb2sgYXQgdGhlIHJzb2NrZXQgcnBvbGwoKSBpbXBsZW1lbnRhdGlvbiwgeW91J2xsIHNlZSB0
aGF0IGl0IGNoZWNrcyBmb3IgZGF0YSBwcmlvciB0byBzbGVlcGluZy4NCg0KRm9yIGFuIGFwcCB0
byBzYWZlbHkgd2FpdCBpbiBwb2xsL3Bwb2xsIG9uIHRoZSBDUSBmZCwgaXQgd291bGQgbmVlZCB0
byBpbnZva2Ugc29tZSBzb3J0IG9mICdwcmUtcG9sbCcgcm91dGluZSwgd2hpY2ggd291bGQgcGVy
Zm9ybSB0aGUgc2FtZSBjaGVja3MgZG9uZSBpbiBycG9sbCgpIHByaW9yIHRvIGJsb2NraW5nLiAg
QXMgYSByZWZlcmVuY2UgdG8gYSBzaW1pbGFyIHByZS1wb2xsIHJvdXRpbmUsIHNlZSB0aGUgZmlf
dHJ5d2FpdCgpIGNhbGwgZnJvbSB0aGlzIG1hbiBwYWdlOiANCg0KaHR0cHM6Ly9vZml3Zy5naXRo
dWIuaW8vbGliZmFicmljL3YxLjIxLjAvbWFuL2ZpX3BvbGwuMy5odG1sDQoNClRoaXMgaXMgZm9y
IGEgZGlmZmVyZW50IGxpYnJhcnkgYnV0IGRlYWxzIHdpdGggdGhlIHNhbWUgdW5kZXJseWluZyBw
cm9ibGVtLiAgT2J2aW91c2x5IGFkZGluZyBhbiBydHJ5d2FpdCgpIHRvIHJzb2NrZXRzIGlzIHBv
c3NpYmxlIGJ1dCB3b3VsZG4ndCBhbGlnbiB3aXRoIGFueSBzb2NrZXQgQVBJIGVxdWl2YWxlbnQu
DQoNCi0gU2Vhbg0K

