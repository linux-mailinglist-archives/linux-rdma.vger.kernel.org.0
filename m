Return-Path: <linux-rdma+bounces-2971-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB998FF979
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 03:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1A11F23B1C
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 01:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63A99461;
	Fri,  7 Jun 2024 01:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="fEYGy6Lc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DB5746E
	for <linux-rdma@vger.kernel.org>; Fri,  7 Jun 2024 01:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717722376; cv=fail; b=iUmPK/HkeiP4BYMvP52zOqcQpnzIfeGWtxsznExR8JkcLDFqls7qpSrJKUXduBqBAI5IvECXWVkpH9w7BmkUhtl98uTpL/xBTiL81XyKSsI5LexDIh0i9jWEQqf+OwRalGzskyvrxrXB0sn5vfhcKD/TiFvHIaiNAxN+oW8tEgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717722376; c=relaxed/simple;
	bh=NYTopwDhBLfRWv6rdEVsrm+u6eGsedwRuDXu7ceOPY0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cbZgCrkznMgSw4Pv4sKaItv/BPOeTnIJ8IYEMyGMjVCfH3m4c76pqv24hsoM810HbD9TfscMlcWyXskwLDWEw99WExP8hiwbjmr34J+bEB4w/mpXNCwcvRhULokpUDdJkAHGt8NhMUjDwkJs43Jvb4AvdqpCodi1IO6q0nAl/1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=fEYGy6Lc; arc=fail smtp.client-ip=68.232.159.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1717722374; x=1749258374;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NYTopwDhBLfRWv6rdEVsrm+u6eGsedwRuDXu7ceOPY0=;
  b=fEYGy6LcTCg+iU9VZFZdd87+gt6TS25rsvJPVMwFHPX5rXvxeEAHxW/z
   pWu1siMwwfUfgdxRjbNzUVTekiWwhNFV9ToqKwCJYKbWkqn71SIvpxhA7
   ZL9tAEI/956RfjVNu9GvDGyu7mQ+XRMuNsnH3W+v7E0QI6mz7+bod0PgI
   povDm41wfqyOsRwR8ivN6vn49nZ7zrcz/SKy4yDkS1k3/VhaFKMdwYxEN
   Br+EQlq9zFqezF5XAkwVPLkDVcpyTz55FYdTfE0Lc171Xh33wpT6Q+KxN
   TPb0iuhDrVxbLn1NQbEzN3trVSIglEtu0rGgmFazGMuFRmzg4crgWOeyt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="121731726"
X-IronPort-AV: E=Sophos;i="6.08,219,1712588400"; 
   d="scan'208";a="121731726"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 10:05:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ov29kvIdMzpp0oGKRfxJ6J7CkMVDPNkErWjcMXjRXawe46/OQ1n04XQK9qZ713VkBhL9PiJR2bJnXKqeQJ4ceAWKMVgFZhBWT9x1neOTIKkamUtRCOmyQE0n/hIxI7GuwZjxwJr2XXEugU9FIaSDj1a0EO0f7mwlDAjPJ8XYNb5AvhiVkSvIFAoBZ2BK/r/iytQ7jPdLl7nt9F3RXErE5xPButAI3Wqtwjgz19gH1lqAhCr48x2Qpc8FWm7Dno2OyGCqj/Q7Q3ZlRp+d06v9adE44FtpCafTnkcmN6u69ZMBQcm5Ok1XPpF3O7hj6OgwHytYT+XG4wNziACXvdtjsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYTopwDhBLfRWv6rdEVsrm+u6eGsedwRuDXu7ceOPY0=;
 b=EqkWAYikO8EWMJtVIxGIxZV3S/HFTW5Yye+TyIykIZ5sgJOLw+CC9oQ8Qtooojq1XxBOXIFxp3ERougp5Z780FE0HPso68Md07CSW+KtwqaMHA2v3RLD9HjztgsarHMs6ItFZB6xi//jmJf9RcL24rpnjuFIPn/dApPq8gRKTIi374lZVqn0aziiOzx7Scdgh5f/ZN2AWaYZgw2Ylqr8ZJc+UrRks1mRdDZk0z/Ut+2dk829Ue98H5s4gz/JUIqr6d9JAwp0LUC+CKchgxq7EVLoeqnvuFR3uur71Zkgu156dSy9c0RJoKmd/9O2MuYYZyvb1oaG8FlhsQSB3wIO3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS0PR01MB5476.jpnprd01.prod.outlook.com (2603:1096:604:95::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 01:04:55 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%3]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 01:04:55 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Leon Romanovsky <leon@kernel.org>, "Gonglei (Arei)"
	<arei.gonglei@huawei.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "peterx@redhat.com" <peterx@redhat.com>,
	"yu.zhang@ionos.com" <yu.zhang@ionos.com>, "mgalaxy@akamai.com"
	<mgalaxy@akamai.com>, "elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>,
	zhengchuan <zhengchuan@huawei.com>, "berrange@redhat.com"
	<berrange@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Xiexiangyou
	<xiexiangyou@huawei.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "lixiao (H)" <lixiao91@huawei.com>,
	"jinpu.wang@ionos.com" <jinpu.wang@ionos.com>, Wangjialin
	<wangjialin23@huawei.com>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Thread-Topic: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Thread-Index: AQHatni/kqlze6ybJEOzgcJok23wJ7G4zwcAgAAiZQCAAau/AIAA40UA
Date: Fri, 7 Jun 2024 01:04:55 +0000
Message-ID: <37e9ff28-1a58-4a91-abcf-94401544a78a@fujitsu.com>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <20240605035622-mutt-send-email-mst@kernel.org>
 <e39d065823da4ef9beb5b37c17c9a990@huawei.com> <20240606113122.GG13732@unreal>
In-Reply-To: <20240606113122.GG13732@unreal>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS0PR01MB5476:EE_
x-ms-office365-filtering-correlation-id: b6879999-a3ef-46ed-7d0a-08dc868dd855
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|366007|376005|7416005|1580799018|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?VGJ2WDdNWVBMVTdEZlJGZ2k1ZzF6bVFJa2crTExpbktwK1ZENWhXUnc1VFBV?=
 =?utf-8?B?d1VsbUI3eDVFeHN6eFJ5eGc1SkRDWHBiSzlzOXRCMUJrdllmbDVxNUlSa0Vu?=
 =?utf-8?B?ZUpOdjQzZEVKSkhCL1QwaS85WXNLOUNNL2hiRmNEWDlvcXlQNDJiNisySEE0?=
 =?utf-8?B?ODYvb0dFRVRZU244SVZzUzZSZVpUcHp6dmRWejRKbnRVdkQzaGRGVmQ4R29y?=
 =?utf-8?B?aUQ5R0dqNFZ5UXk4Z2ZMd0hxeWNBV2tSQzBxUUhOcVRpcWtLbHFhVFZzZVJ0?=
 =?utf-8?B?ak8zVXd5VU1QTmYrbFFWelRmdGE4d1JsSnBZRVVjVmhBVkNrdkMrZnVpTThw?=
 =?utf-8?B?OWI2KzhSOGNMcmNpL3RRZHdWVkFobmlWTG1yK3NPdGhyaTZJc2hvWjN0djkz?=
 =?utf-8?B?QkZmRG5MQ0U4Wk9ETVRTQTEyTXNEeUE1VUVGc0VZWUhzT2VNdUMyclBLa2Ux?=
 =?utf-8?B?bUorZmJFMmZzUHp5bDlVS3FJdUlXazNCZmZ6QUZVWE9XMmVQOHJkMGNhd3Rw?=
 =?utf-8?B?eVYwL01MOXlMOFdpQW9HVW5yQVZVcFpBbGJqM2lDVU40azVjc1JqVlZ0UVBp?=
 =?utf-8?B?clZiMThyelN3OFNrT3BxQktRbTNURVV6RDBjY1hxT3ZoeWxHTmNCSTdZc0Mx?=
 =?utf-8?B?bWMrWTRyS2g1S052bHF5WDlub0NDYUpjdUZrUHJMRUlkWXA3OGFyS2pDQ3kz?=
 =?utf-8?B?MjVGaXdYajdqRlo2N0FuYldQT1JTQW9DTUg4QmRtakdJZE81VWVIdTRyajNk?=
 =?utf-8?B?UjUrOFhPeHVYTE1UMDJhN3VVelBnRHQ5QTNISHcrYmcxRzgvai8yczcxaUxx?=
 =?utf-8?B?eW5XQVdVSGxQeVQwd3hJSERpK29PZ3RWeDd4Nm5uVVU0bG95T2cvNHEvQVVi?=
 =?utf-8?B?QVlCK1ZuV0hPeUY0VUl1N3dPK0ExVERYOHNFVTRkL1o1T3l1Q3JJMldJQ1B2?=
 =?utf-8?B?SGN4Yll1Sy9hYndGSmJsb2dCTkR2OWQ4Y1J4TEN1NU9HV1RzaGdBcTJjVXh5?=
 =?utf-8?B?RmYreDcyUHNjNmcrMGxWZUtkc1h1SkNUK09uV2YyY1lkbk9zL1kraWVYd0ZV?=
 =?utf-8?B?YnZhRzlsOGEyOFRpRk1xSy9pMjB3VHYraUNYOWUrc1FCdjhFWDUyWURPRXlK?=
 =?utf-8?B?Ui8rdEZEa2ZrWEUrTVdmVlh1VTkwQ24rOGdYaGxYblpuektlM3dnaStVNkx6?=
 =?utf-8?B?d1B0OC9OQWRKcjdpV1BMVUk2eUNVSXQ3aFBXWVdnQ0VPOHNQZ2lLYXVMVzZL?=
 =?utf-8?B?bjNtSlVETmJ5TlVoZWxpeVFYaWNlWGhlN3paMlRyQmkyRFVBU2lUK0JtN0c2?=
 =?utf-8?B?bUFLK0ZrdzI3Q1c3MWt3TXNKemQ2L0FvbThGUTFoMHNqWkcxM2p5cHd2V2Fp?=
 =?utf-8?B?dUdMOE5adVdaQ1BQc09rWmxMZGdQa0dYcE5vclZlSnYyVU5EMXdNdngrempN?=
 =?utf-8?B?b3RScDlRcnJHTlZ4VzQrQ3ZaUDFTNStUWmxIbFBrZWYySHZUdFJGV1hPMnlt?=
 =?utf-8?B?WDhKYnMvcUR4MEpVYkIwNWNNVC93TFpTdXVnTWJiVzJKUGVGSnZYdjducXI5?=
 =?utf-8?B?SWVOcU5GeVlHbklDbXV1YVJkYlFKNTdPdG1MdWcvVkpJY3hjbENqOEtOb3Na?=
 =?utf-8?B?QjR4WVhKazlnaFpBMlF6SzhxWENPMmRiL0IzUDFLL3ppY2xnYXZiekFxcVRW?=
 =?utf-8?B?S3J1KzNBdXdvMmZRMUVHMDZTN2lNVitqdlNFc1VTMGRLUGh6aC9sOFRZaE1m?=
 =?utf-8?B?MzZDd1AranFTdlB1eUV6THRmbTVOOHlnN2twMlowaUFBVGZyaGpzMHBDRlFl?=
 =?utf-8?B?bWRRNVl5VnJBKzJ2eUhFWkU2WVpMeXAreXc2Z1MvR2liTUxORmUxRDkwaEdM?=
 =?utf-8?B?TmZmWWV6RDkvQjE0RDhhYjNJYTlzcWVnYzNwRTlQZWZ2RFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SmtuWkJ5VEliVGJrRmNKYjZ0bmlxUXYwZldMdGJUTlo0MGhodEtEaWROektR?=
 =?utf-8?B?S3d6cVM3cS9BcCtDVmpORVVYTjh6ZUlETExxZ3B1RG5kZldRa2hJVTVDV3dS?=
 =?utf-8?B?Z0MvOFExS2R5eFR6S01BYWwxQmxKZXNhWnQ2WFphUVl6aUg1RnFDbWhRM3RF?=
 =?utf-8?B?enlWNVlDc3kwWDU1T2hhOXZRcm5zTWJ6elVPRFVwQTBZTnFnSUtCZFVWdUJD?=
 =?utf-8?B?TUZOZlI3VkVlVngyVENreEg3SnAwdXNMY2NHeG5MZEFHb1BTekU4d0pXbjND?=
 =?utf-8?B?RjNEWllhcFNSRTV3dHZ1L2ptTWpxQjJEVTAxOSsxQVZtUHpubW4vblMxc29K?=
 =?utf-8?B?M2RCWmVrampWWWN5VGI1Z1RVcjNEREM3aXNMaDlWRno1Y2Q4UjFNV05yU0RI?=
 =?utf-8?B?eVJGUFd1bjIzNkx3R1lXdFhqd1A1TkdXdXoxeXlCWUtqYWo2WE0xbHRFcFVL?=
 =?utf-8?B?bE5TQ0NLYjRhTnRVOE8rWXdESi9mcXhCYXl4QUlaelRnVWtOU1ZEMHVwNnlU?=
 =?utf-8?B?WFJLazBObGt0SzBkanRxVTVWMVN4YTR2c2VKcW02UDhEdDNJVkVZc0doYUZ3?=
 =?utf-8?B?K2dRZ1p0ay9VVlJ1enhhWWpBVVdvVUJ5aHllUmp0S1dONEJ2YnZWWnBUY0Iw?=
 =?utf-8?B?TlNHSmR4WnlxK1dGc3RhbFBac3M5R3VxMUlEcnI5Y21wRVVyWThrdHI4LzBO?=
 =?utf-8?B?c1FYUUpJSk1VcFArRjZuYUZBcXNWeTk2WlVYMVk3ZGk0RTloMnhCRjljbGx6?=
 =?utf-8?B?d1pZZDhqb3hTYXR4RkdYQmFFTXUrMlFOVS9JeEpVYWxpS3BzckQydHpCd2RJ?=
 =?utf-8?B?dG42YjRnS2xRWi81S3l3OSt0R3FzUzdKbjBxMFF2YzBUOEEwTkxnZzloQ1U1?=
 =?utf-8?B?Rk15QkVmZGRHZVNFUzIyWGJGdjJoRGQ0c0dvNFBkSm5FS2JlQ1c1TGVmK1FY?=
 =?utf-8?B?ODJuTG5vdEh0aGkxQlpaaUFWMEhzRXZJa05HcUcwdk9MUkE0RjBUb1dlSnUz?=
 =?utf-8?B?SW5WcG5Lc2NScmNFMkZSWFAyYmpCeFlFZXRid2Frb2Y4dnlCS2JkcGVBdmtu?=
 =?utf-8?B?ZzdtRGh0eFY5dEEzVThMTXdXNm1OQ1VQN1VzdGdqYTZZY3dwdmNOQW1ZazdF?=
 =?utf-8?B?dGRiakd4MVhrakFPYUhOVXYxUTU5K3Y4QUh3ejdFZlVTUXFPWGJhNDFVNmw0?=
 =?utf-8?B?WGtsWG9VdUw5MTZOK29BSlpmRDRlSllNVlFyK2ZINWk3bTlJZ2FzbDYrd2Z5?=
 =?utf-8?B?M1dCZkY0bXE4N1ZXZHZFRHkwY1lUUExRalcvelBqZTZFYzV2R1laejJzSjdi?=
 =?utf-8?B?dzBVaUYvZ000M3FRYnFSMGN6OHJsN081ZE5Wd3dlYmJNY2xXcVlhM2FYYjdu?=
 =?utf-8?B?bGlBVFM3REpDUHIvVW1aMmQ2bVQvRWI4bDZDNDBuZmVmbmszUUlsL3dmRGNo?=
 =?utf-8?B?dTlEd29lZjluWmcyMmlEQzczN0lVdUdNUEtpTTZyUmRROWN2SCtmcytmako4?=
 =?utf-8?B?Q3V5eVNNckRIUWRPMUF2dTVHbEhQdWFSY2ovZzZMTk5YSjdsREtWTFJSM1Jp?=
 =?utf-8?B?eXVQVEJoN2d4dVBSSCs2dXZBUFgzc0hJRlBjSTZQSnE0LzJrdVNDWXdqY2hB?=
 =?utf-8?B?OFp4Q1FrRms0aURSemRxUnQzQjFGQVVGbG9qNE1DcUhyMmphdEVmbzNseU9m?=
 =?utf-8?B?NXFRUXVzc2hJT2dsV2ZDZmQ2YmIraUJIY0NQWWJFVDFBeW9KbGFIYU83RzVO?=
 =?utf-8?B?QlQ4dFkyejdmODJjSHh5ZDdpQm5SSjQzNklNc1AxQjJLWnU4VHNocFl5SnRh?=
 =?utf-8?B?WkRjd2lPekpkdk5WbEJRZW9yYlo4SFZLN1VIL1JxV3lMMVR3amp6Yk42bGli?=
 =?utf-8?B?M2VxN1VOc3JFaS9yQlMvQUVCOUdPUklvWUlVTkNqS3g4WTcxR1NoMCtkQ3BV?=
 =?utf-8?B?Wjh2L2dQbmxnM2RrV3NtekswaTY1cDFGeGJtMUxoQlZhQXp2MnJmekdSc2V4?=
 =?utf-8?B?eEdObld3Ti9Ba2d1NlZwZTRNcU0yWmxKanZidWV1UVBER3RnT1BjbC9HTFFi?=
 =?utf-8?B?UjlrUTNoeHdIZVlrUmJPN2h1cHpPdTFJb2hkWmkvWlBmUzBiUWhTbU1QRzA0?=
 =?utf-8?B?L3g3MDhteVpKaWNiM09SQzdydHBHSm5DNWkzSUtOdktvTTFJRW1iU1ZMNzEx?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC09FA40A77E104C9A256D588E2B1AEB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jV97+lXZFftjPM5DDCVwEZKspj+0Mnot4WgWa55gJ0/Xz6fCEUwOR/Veqz7YCJU9DJq+pxG76lOitlGsWIHwZ6U/TBqS7g9Z7qeZtJ76QzhdIagoyDtqzep6qj100NH33QYsnKfF1Trqin9TQCsifb0Sr54CkBle9x3IQVojPXYGVZ29iJvdn1UaPeIaEkw4gdLXMbgiUUlFFNbNheFyB7aKF+L9ZiQcQXXSWEK5zOPBOnI8KaQ/NCRT0Za22hLwtalZ7D8iKiaB8DLbgrNqZLpkDr2tvWr3HgIeU35sGm+dKd9KC7T40UjKYufiPiY895rIAv5Zjo94JqFasH1FTTBARWKVKbdWQJCPeI4g3uBsF7PuSJ744/VTTR8x6IyyMjs3TQUtPN4FiyBrGsmbx38bhg0WhTPWnXf5fCTIlNd+IY30vqZ+gKUcsfp4+J272TYM4kl7C8/UexzDY8eM9jt7B8t+cV8YKBdRkT2d2U9i0y7Azv+pGzbhMKwatCaQej3SibVi+DBd9j96Lut/cfpOXBZ5j5ueBcs3ybJZH7Byw5UruDWBw6JaC2e3i+g6Cx4WOjqhGl3tay1kDLGCgwFddsMqC8XzQqzwO/7JPsKEbQ4MBEkAUJamCQ+GyisL
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6879999-a3ef-46ed-7d0a-08dc868dd855
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 01:04:55.7246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJTSD/kMLlglTg79leA5UEePXS4CDjaTmM9UKSflGQm6wsasam4HM/gmMifYWtXvLsdu+p3U8Aux+mLhyyO0ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5476

DQoNCk9uIDA2LzA2LzIwMjQgMTk6MzEsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gT24gV2Vk
LCBKdW4gMDUsIDIwMjQgYXQgMTA6MDA6MjRBTSArMDAwMCwgR29uZ2xlaSAoQXJlaSkgd3JvdGU6
DQo+Pg0KPj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IE1pY2hh
ZWwgUy4gVHNpcmtpbiBbbWFpbHRvOm1zdEByZWRoYXQuY29tXQ0KPj4+IFNlbnQ6IFdlZG5lc2Rh
eSwgSnVuZSA1LCAyMDI0IDM6NTcgUE0NCj4+PiBUbzogR29uZ2xlaSAoQXJlaSkgPGFyZWkuZ29u
Z2xlaUBodWF3ZWkuY29tPg0KPj4+IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IHBldGVyeEBy
ZWRoYXQuY29tOyB5dS56aGFuZ0Bpb25vcy5jb207DQo+Pj4gbWdhbGF4eUBha2FtYWkuY29tOyBl
bG1hci5nZXJkZXNAaW9ub3MuY29tOyB6aGVuZ2NodWFuDQo+Pj4gPHpoZW5nY2h1YW5AaHVhd2Vp
LmNvbT47IGJlcnJhbmdlQHJlZGhhdC5jb207IGFybWJydUByZWRoYXQuY29tOw0KPj4+IGxpemhp
amlhbkBmdWppdHN1LmNvbTsgcGJvbnppbmlAcmVkaGF0LmNvbTsgWGlleGlhbmd5b3UNCj4+PiA8
eGlleGlhbmd5b3VAaHVhd2VpLmNvbT47IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBsaXhp
YW8gKEgpDQo+Pj4gPGxpeGlhbzkxQGh1YXdlaS5jb20+OyBqaW5wdS53YW5nQGlvbm9zLmNvbTsg
V2FuZ2ppYWxpbg0KPj4+IDx3YW5namlhbGluMjNAaHVhd2VpLmNvbT4NCj4+PiBTdWJqZWN0OiBS
ZTogW1BBVENIIDAvNl0gcmVmYWN0b3IgUkRNQSBsaXZlIG1pZ3JhdGlvbiBiYXNlZCBvbiByc29j
a2V0IEFQSQ0KPj4+DQo+Pj4gT24gVHVlLCBKdW4gMDQsIDIwMjQgYXQgMDg6MTQ6MDZQTSArMDgw
MCwgR29uZ2xlaSB3cm90ZToNCj4+Pj4gRnJvbTogSmlhbGluIFdhbmcgPHdhbmdqaWFsaW4yM0Bo
dWF3ZWkuY29tPg0KPj4+Pg0KPj4+PiBIaSwNCj4+Pj4NCj4+Pj4gVGhpcyBwYXRjaCBzZXJpZXMg
YXR0ZW1wdHMgdG8gcmVmYWN0b3IgUkRNQSBsaXZlIG1pZ3JhdGlvbiBieQ0KPj4+PiBpbnRyb2R1
Y2luZyBhIG5ldyBRSU9DaGFubmVsUkRNQSBjbGFzcyBiYXNlZCBvbiB0aGUgcnNvY2tldCBBUEku
DQo+Pj4+DQo+Pj4+IFRoZSAvdXNyL2luY2x1ZGUvcmRtYS9yc29ja2V0LmggcHJvdmlkZXMgYSBo
aWdoZXIgbGV2ZWwgcnNvY2tldCBBUEkNCj4+Pj4gdGhhdCBpcyBhIDEtMSBtYXRjaCBvZiB0aGUg
bm9ybWFsIGtlcm5lbCAnc29ja2V0cycgQVBJLCB3aGljaCBoaWRlcw0KPj4+PiB0aGUgZGV0YWls
IG9mIHJkbWEgcHJvdG9jb2wgaW50byByc29ja2V0IGFuZCBhbGxvd3MgdXMgdG8gYWRkIHN1cHBv
cnQNCj4+Pj4gZm9yIHNvbWUgbW9kZXJuIGZlYXR1cmVzIGxpa2UgbXVsdGlmZCBtb3JlIGVhc2ls
eS4NCj4+Pj4NCj4+Pj4gSGVyZSBpcyB0aGUgcHJldmlvdXMgZGlzY3Vzc2lvbiBvbiByZWZhY3Rv
cmluZyBSRE1BIGxpdmUgbWlncmF0aW9uDQo+Pj4+IHVzaW5nIHRoZSByc29ja2V0IEFQSToNCj4+
Pj4NCj4+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI0MDMyODEzMDI1
NS41MjI1Ny0xLXBoaWxtZEBsaW5hcg0KPj4+PiBvLm9yZy8NCj4+Pj4NCj4+Pj4gV2UgaGF2ZSBl
bmNvdW50ZXJlZCBzb21lIGJ1Z3Mgd2hlbiB1c2luZyByc29ja2V0IGFuZCBwbGFuIHRvIHN1Ym1p
dA0KPj4+PiB0aGVtIHRvIHRoZSByZG1hLWNvcmUgY29tbXVuaXR5Lg0KPj4+Pg0KPj4+PiBJbiBh
ZGRpdGlvbiwgdGhlIHVzZSBvZiByc29ja2V0IG1ha2VzIG91ciBwcm9ncmFtbWluZyBtb3JlIGNv
bnZlbmllbnQsDQo+Pj4+IGJ1dCBpdCBtdXN0IGJlIG5vdGVkIHRoYXQgdGhpcyBtZXRob2QgaW50
cm9kdWNlcyBtdWx0aXBsZSBtZW1vcnkNCj4+Pj4gY29waWVzLCB3aGljaCBjYW4gYmUgaW1hZ2lu
ZWQgdGhhdCB0aGVyZSB3aWxsIGJlIGEgY2VydGFpbiBwZXJmb3JtYW5jZQ0KPj4+PiBkZWdyYWRh
dGlvbiwgaG9waW5nIHRoYXQgZnJpZW5kcyB3aXRoIFJETUEgbmV0d29yayBjYXJkcyBjYW4gaGVs
cCB2ZXJpZnksDQo+Pj4gdGhhbmsgeW91IQ0KPj4+DQo+Pj4gU28geW91IGRpZG4ndCB0ZXN0IGl0
IHdpdGggYW4gUkRNQSBjYXJkPw0KPj4NCj4+IFllcCwgd2UgdGVzdGVkIGl0IGJ5IFNvZnQtUk9D
RS4NCj4gDQo+IERvZXMgU29mdC1Sb0NFIChSWEUpIHN1cHBvcnQgbGl2ZSBtaWdyYXRpb24/DQoN
Cg0KWWVzLCBpdCBkb2VzDQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCj4gDQo+IFRoYW5rcw0KPiA=

