Return-Path: <linux-rdma+bounces-4137-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1029435A9
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 20:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185FC1F274EF
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 18:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E083F9C5;
	Wed, 31 Jul 2024 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TQzom4OS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r8MGwP7l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E2DD512;
	Wed, 31 Jul 2024 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722450702; cv=fail; b=LpJqLqq5roJ5+nY4aCjyy+GD1LN4hK13U46SF6p9P9yxnr3YBZnTSGAyhIRMpnx2Q0PrwYTci8S+yJPsJ6gMf7avlqZ6ZZ5iUtLL4zGCGCFWwGvr2LuuoBFBAxLJnTomM8go35WLZoSth13JCbvSusAC85/wpyjm+HjfsSZgvlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722450702; c=relaxed/simple;
	bh=fBC3Z3NGtMnw85gG+0Ioy204HYauCsmKBC4nFw2wjPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hg6t51xbC/4a9+Qt3PGoAQ7RpXAVBKRnO9m8onlEuhaS/nI4jV0mieAoRBPigRWd9ygrAlc0JnVYnvyduSllM6s4/et3aTF63ri+zmTGuR38PZ2loIgjvQauBxvXzxSad5b8nwRak/1EGDgkRrjtNxj9NehCcPY27sKbfmKzjAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TQzom4OS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r8MGwP7l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VHtSJe029206;
	Wed, 31 Jul 2024 18:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=fBC3Z3NGtMnw85gG+0Ioy204HYauCsmKBC4nFw2wj
	PA=; b=TQzom4OS7RL4sm5j9foKeZVIIyy96QNiOQS7dgZoDQA3O/gK1pehIWgjc
	OSSBc8GAULxpOqxEO1M4kn0Beu6OlYVgcHcxX0Z7L8FM0+Gs3b4DSr0zfRS5fzxP
	RR6zYeVRPjxEFTDiBwtdNpE0VfwCEBi1kHeIMymMgrwb0mOvzcMzSq/KWE8Ql2E7
	GTKKcYYqG7SwIUYpxepwryIk96WHNDK3no4X5YgGPidpKOMmgH836cV/6pD9kHUH
	17NanGfCeNzTH00fm0+QUMje2zb6qFwy12SnJZGXr3yVt/MXRitV1h/aHxp/wrcq
	Lrpi6ye1sAggUu3U9kKtmZdDGqGJA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqp204eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 18:31:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46VIJTEf028906;
	Wed, 31 Jul 2024 18:31:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40qmps04mf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 18:31:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKwFCZGYyrbZ8OoEUiKvbLr9YlXajK6Cuq5ZBoKfqnzlcqqsLmKveq9z40ZQHEp3oIDKiw4Kv8cFjo+2CBHYUZxzmdVliVQijaVIyYMFLNxjRjM3XSXwWqjQNXLy8+TGJlXzbsP/dOw8OZGGsf9zD2UMSQ9repvxu1mb8EQGRa5C2yQgDatgA8LasA9za0jwoL6CSoU12jiO57ihdSRdxmt8ThYGxQwfCZim0Sk4TnH4PTh6n6Wd9ek/RnEDseUYQkLSxz+ctXNSLW7REBViZtSHzl8DFYx09XDxvpIAwx7eXEMv6MX6Et2CAhATLHPvWbTG1A6Wjd+Z1jkoBGcnJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBC3Z3NGtMnw85gG+0Ioy204HYauCsmKBC4nFw2wjPA=;
 b=R+hAqklkscHTCPSo5qdCU7IggJ2ZKqNEELd+lvBCJC4mbmuF/glZPBHiaP+Jn68+j5/ABYoDArd4UfuyWpnZeMDfCWnpIXFaGkwZzwl4RHQC9N6y434L3DFO6eigludyGSDjy4tHHJlEEDkeZG9/Wngl8lPpd2t/Te0GaTO+wn56RurrEXv5MamWHw5xKGigX05Nm9GiB4F4LcUxbTSuk7kHacULXgj8RbY8p5dntoOr+z139kRYIqIgBXsB0LnKCnSOZqAU6PTdfcoXcUugrPj8utG9Fir4L5Y0yzn2uGPva+HECNaPxdmvlhAkUaAFTzMWOFniObRjbDLAagOm3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBC3Z3NGtMnw85gG+0Ioy204HYauCsmKBC4nFw2wjPA=;
 b=r8MGwP7lk+PEqsDFq7vSEHbGB8KAnXWbVPUL5P0RPKvB5LqLAjy+r6Fq2pO8ncdE3dVEBd5LvjR0DqpYlmaN4YDxSZy3sejrbObQunctPqX7Zh7QU4fY0O+6WKNObjBlvAtSXtgPVq59V7IZ84cPkbAfg1HN5rLSldiLw+9JHiU=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by PH7PR10MB6333.namprd10.prod.outlook.com (2603:10b6:510:1b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 31 Jul
 2024 18:31:25 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 18:31:25 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] RDS: IB: Remove unused declarations
Thread-Topic: [PATCH net-next] RDS: IB: Remove unused declarations
Thread-Index: AQHa4xRjdFiWlsb6/0+GKD8/EYDrRbIRKYgA
Date: Wed, 31 Jul 2024 18:31:25 +0000
Message-ID: <40988b083db40968700c79a752590fe78b640a02.camel@oracle.com>
References: <20240731063630.3592046-1-yuehaibing@huawei.com>
In-Reply-To: <20240731063630.3592046-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|PH7PR10MB6333:EE_
x-ms-office365-filtering-correlation-id: bc6670d6-6ac0-4075-9cb0-08dcb18efc6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dUYvQm1qOWt6aGw5RXFXRG5tWnp1aVdScXczWXRMNlFGRHVITkErZTFRRUdu?=
 =?utf-8?B?YVpzZmlIVG9TWENXTWlvQ0ZDaUU4QVRHemZLRFZCQlZSMWlyUUJRWjlVWmov?=
 =?utf-8?B?MzBiYXhFcUFqSW5aMElaUFFyWjZxdHVHQnQ3dlowYkd3NXIvZGdQdXJCWURj?=
 =?utf-8?B?YnV1aDQzVk9FSDYrTnp6ekM4ajgyekhqNnhiRHpRNzNQY0lOb21VeGFZeU5z?=
 =?utf-8?B?MHlnK3JwQmhHZEdwVkozVkNDWGpGTUVGWkpaM3h1OWdaQmNzenVLRFRSU0Jq?=
 =?utf-8?B?cldPV0NSY1h5UFJMUmVCall3L2tkWGE2OEQ2SmtmUzVOWXNrTEpid0grYnpR?=
 =?utf-8?B?ajFFWHB0MklxZUNad1BTVlpUODU2cEc1QkJlQyswOWFad1FOdkhXV3NKTHBw?=
 =?utf-8?B?UzE1K0lSQTNGRjlxVUNoeUhRb2JwQ1gvOTY1cDVzc3RVRkl2REtiRXdPWi9M?=
 =?utf-8?B?SnF2UHBOTEgzMUR5YTVQa2ZwNVlpb2IwR3NsNGhicnRhOE4yTDU4WDhySHJm?=
 =?utf-8?B?QnMvcmNVVlNLbE1ZNytkeXhURTcveEhNMHVmMm1LSmhjNllmR3pSL0F2T1Jt?=
 =?utf-8?B?QXFNbGd3MHVadTIrdDZ0MmVJdWgxZWt6MmRDajZIVHNNQ0RQWFpKUGdsT0N1?=
 =?utf-8?B?RWZKMVFSOTZXdGk1Ym1ZU2JwbXZBWUhKSHdpQW5IWkhmZDJRYlVsSk9qSHNn?=
 =?utf-8?B?SHkzTWJlbmplSTh3UGxqTVNqc000Q3NWdUp1UG9MbVBoZ3BRZk1BV0lNMEZi?=
 =?utf-8?B?M0pCTExqRXk3ejQ4clhzWjRMbnpPN01qSXBMYnF1N3pLZ0xieTBueVpnMi9v?=
 =?utf-8?B?Zld2Z0lHOElXemtlQ1VxckNrdkIxeWpINExjTnJxRVVOenAyQXlXZXNPb0d2?=
 =?utf-8?B?N3hrdVFqR3ppeTNEWjU5OEJuYjJ3MldUUDE1VTlpRitPdjRscDFyNEtNN0xs?=
 =?utf-8?B?TjVsYmllbmk2YUxWTVdGWlZBNUhRSXhRQkk4M3R5UFZtdVMwcStocENMSFdM?=
 =?utf-8?B?OHVrVjNGK0hOdThUMllWRlN2bFdXOFNTNDlsYVNnblZvVXFyaUJZWlR6N3dz?=
 =?utf-8?B?QjMrM2xnckpwc3dudzdCb1dPUEdDVjF0YkJTQmphUnJicGdkU1ZmSUhpL1lN?=
 =?utf-8?B?VFo1b1hyNkp4bHhEQk5KUk9NUHNrVDdlQkdEa0l5SzRnN0ttKzlPM1BGakN4?=
 =?utf-8?B?M2tnWWlKSk95eHFXcXpqR2hWcjd6bnNBUldzc0xSQVVLMXF0eXIvMDJNblNY?=
 =?utf-8?B?ZFFpcG5TWmpreUUvOXhsRDlEWlUzTHZpelBnSkVTUi8xZ3hYZVVMSjliSEtr?=
 =?utf-8?B?VHJ3M2dpRmJha3NPYlUvazhlRHJPMlJueGZEVFM1MFQ0U09YbmlGVUoxUEpG?=
 =?utf-8?B?RzJnZEpPUHV2aUFKNXh3aHNpcTlMZVFnMmpTNUJQcW5sUi9EdXYxYzlYR3BC?=
 =?utf-8?B?anFMOGlHMmloNDRQRHhLNk9KNFB1N1hBdHh2ZE1kL3V4Z2kxRlJqQ1JveTRm?=
 =?utf-8?B?UkNtYmdKVzQ1OEd4OWsvSzZlV3prQ3B3Y01kQnBkZ2dmNE1NYjRyRGFwMFpG?=
 =?utf-8?B?RGk5RjNlTWgxY09lbExTUjdad1VINXBxWXB0WE9HZ0xRTVA4eElzQjNoeWp5?=
 =?utf-8?B?ZlVNWGE2SUQ5Wm9zbE1WME1ISDN0TmpudzZiNTZEWlFQYUFqalQ3Q1hXK1R2?=
 =?utf-8?B?eE5EWmMySGpUNkl6VU9TMmRGWldxVXV5c3Y4UGY1dEVvUGl3QmhvRUNYWTFG?=
 =?utf-8?B?MzluS1dJL21BakZISE5MZHh1M1htZjJDMGR1WGhaMUhTM0dQTDJjUUEzZU1k?=
 =?utf-8?B?M2JoWFZGRXVNemk5SWpxZGdyZjFJaG1VMEYrbmtSV0c4Sm1TODl2WnNqWU1Y?=
 =?utf-8?B?MTZMWUF4czlpNCsyS01vMElqbm9SdHRGRFk2OW9WaE5aUVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHBOUWZLSU5rWlFJYzhIT0VPWkNwd092L09uSFRFK3Vad3dTTy9DemZCY0NI?=
 =?utf-8?B?OG8vdm9LdEpNL3hkTzk1NUNDU1JmeWlidFI4NXp3QVl2YW1hN2VCQTJXWTVH?=
 =?utf-8?B?SXp3Vm9QQkNqNnk4bUJXQjdPcTJiOGZHb2tUNjBoeWh1OHpTZXRYYUJtNEtV?=
 =?utf-8?B?aEVOSUdkbFRsVFZNSUZCYzUySHdXZ0U4ejV5L0dlZmEwc0hNTzQyNTcwZTN2?=
 =?utf-8?B?TWV4WkxuYzZmUWRBamZSSWdmT0ljandpM1R2YU5VblJMVG4rMFNCb3pZLy91?=
 =?utf-8?B?dkU2cEtLODVaYUNGeU9QaG1zdXVFTytWekFKMGlKanpZblQ4QWlCeTNrd1Jt?=
 =?utf-8?B?eUIyd2xOcVkrRzl0aDBEbkVkcHVheGFOekp0QldKYXpvbEJsckYwSkFBN3FW?=
 =?utf-8?B?U0o5T25WMDJmM1RFRUVhV1FZSlIrKzNTZTVTZmUwMlV3MnJ1TGkrK0M5UnA5?=
 =?utf-8?B?NjR2b2NVaUZiUTRuSnpRK3QyTmx3bHFzL1BiblRwZE1TRHN0VkFsa25oNFhy?=
 =?utf-8?B?b1I2MWxacThqNHhYSEVPNDc2OFl3cG4zWjZ0aTZMZjRzVi8zRmdBNGJicFhh?=
 =?utf-8?B?RDNncFh2L1l1Nzgwb1k0bmhCU0NwMG5aVGJqRm9hTWVXaXdjTVhra1dueFlq?=
 =?utf-8?B?OER1ZS82MzY3eVJRL1NrRnJVRktkaU9xUzdMNURQQ0JlblFSdWtyZTFnaDI1?=
 =?utf-8?B?VmV3WmJ1OWRaMFljOS9hampTRGE4d1BxSmxBZDJCRmFFM25RRDhsQ0J5bkNB?=
 =?utf-8?B?bmZOTjFVeC9zWnN5U2VPUnp3dzJ6bWx3MHFoMmpuU1RRSDJoTWVxOGJpNEdw?=
 =?utf-8?B?bzluUG1oT2xReEY0ZFlnczJNSWdldE1veWl4dUlvSStETTEzSXI0cUt5RFF0?=
 =?utf-8?B?UmVvTm5LWVRVQWhnRW83SWUvRjk2WnI1NEpyUm04TkNLc1F2SnlBaVlFVk9B?=
 =?utf-8?B?WXl4OXRMUzZLVVdVTStEWnRWOWFLZ05FTTljMGFjclBBaE4xV2U4a1dNUHF1?=
 =?utf-8?B?UEVidllZc1pEYmpHbnF0WVZOZWhTSE9kUHNSbFh5WTNHblZRb1E3Q3FCTnNj?=
 =?utf-8?B?TVhVOEV5aDBWOW9lUml0OTFwTVRCNE9vVkdlTWNPeWk3cUQ4VTc4SEp0RGY1?=
 =?utf-8?B?c2I4eGpab0F4bm1OZnZYMWM3WG41UjZiVm1Fa0t1Tlc5dnA2VnNnRHo0bHRM?=
 =?utf-8?B?L1Q3bFMyNk9hV09ib1FGMlVKT2lpMUFSaDNTTUF3V0pQdWNobG4vY24vYjIy?=
 =?utf-8?B?V2xZMVB1NDdtL28vUkdBbTM3VytHbEVGMnQwTUw0eldVdzB3NjY4Mi9WQlQw?=
 =?utf-8?B?SjZtTCt1VXFaaUk0cUtqV0Y3dU5TRnV4QldzeE9BdElJa0F5QzFDd05lVzFn?=
 =?utf-8?B?SUZOc3NSYjJMVlAxR0hHaTl5b3Q5QmJ5anN4cG8zUWNjaVYwSENTaFlTeldk?=
 =?utf-8?B?U3J0VDVFdW9oNXhFanphdEI4cVpSbDlaNURGWDNaR1grYTlraEVlc2tQQUR2?=
 =?utf-8?B?a2FlcTUxT28yeEhCbzRLaW9DdzlhWkF3bkxSWk5nL1hzRzhPbmdLU010MFZ5?=
 =?utf-8?B?WnJFd0t6VEd5bUlpY2piTzBCYXhyalNCT2VtWFZGV1pacXBoL3VzejdnRlMz?=
 =?utf-8?B?QzByODJOYWlyZ3MrRENWc3Brb1V5VFN5SWE3Q3M4bWk1V0djMlVmTWh1TkNs?=
 =?utf-8?B?Z1g4SG1HTmMxSGNRUkhPek8rZDd6M0VFS1FDZ0lPU1NGczRZV3ViaDdnWFJm?=
 =?utf-8?B?Tk4yWmNqdzE4TWhySFBQb2Y3VmFEVk5ZMmFaZm50UGxEeHF5b0FvOC9OcUsx?=
 =?utf-8?B?bVg0V2hNUFBKWktkMGpNeDYwQkhtTFp0eE0ySFpIckNCdnZkWmZtTkZ4dnFU?=
 =?utf-8?B?Q1dDRjFETDU1RVE1cnJxcmY5eXNIREtVRHBBM3JmemlTOVRhT0k0UkV2VVVR?=
 =?utf-8?B?U0lQTWpDc1VoSXhBdmpEUXppc3B6K1FvWGpOWjFxdXRtT0FwQjU0b1RVcFND?=
 =?utf-8?B?SWRBRFFtdlFlR0lsdkdFVnA1MVZTeXJUcXR4T3k5b09rL3JwMU9VcVZxSDBX?=
 =?utf-8?B?Y1lrUjVLdW8vSWdoc2VVQ3RJZWNMazlscHdHVmYzNlJveU44U0J6T1pGKytM?=
 =?utf-8?B?UjcxTE9hcytsd3JKMVYxcEVXUTdVNlFWQ3NXdlFpMU1RaWJKcDNsM2VJdnVp?=
 =?utf-8?B?Q2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4357E4EB96A05B45AB6B1221735EFD2B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cgN4TVNYVQ0rm3XKoDFUG7+kLiZ4wEYFgp03uTFJc2qCHScSCz+q8bVUnTOUzMbEM2KSZ5XrPFW7trs5I8Me/6SlO9C2oZOdy57j9GzikdpgsScwhy+rVqxSPzC7+y6MJ85Xa5cIkgUcIzi4UwRFisGiKA1+Thb5WZLhhfbURaAIkLYzAla7XNADHiX0VJzXDpz7t+IPrFdkAxfXVdSBpjxlD5fmRA9QfX5qjiUJ3LS8cQBUh63N+wT0iBNORfSvx6VxM6GnbHHMIm/bxiDdvg1Kyaw5TkoqDlDAlu4MaJxZCBVUnTapUZwDNh8pvN1+uNrtVage7LO5/AMoCLv/yAQilN+tJiXWuNC41WGH4n3Yx9egnjR/dmumPBJksiut1g0NXr5JJSlsNtCDFC7jfwcel+RrgSIw/BkD9wmrt+MbGtc7D6X7iE4izspdypVPNoDiNN13yq2xtcKInrhc51T9D3AZOH4r+PoY1jQGFlWQiULBRGCMQghpPqBaxCWy5Yg1Fy4TsdibyrLAIHmfi3MhqX/MEaFF9dm3JkEzRLJduWJjU2Ogo3Q0mYH4WUwFHSq8pTbA17jRAUUKM39xa7lzYt906OxtXhi2rBJRO5c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6670d6-6ac0-4075-9cb0-08dcb18efc6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 18:31:25.8057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cb3/lSIdnD1bQW0gS6lx2Ml7Iv8ATVp9YPqz7rU0R0/WujJDCFlGYlYBXF/dE13umy8NrVmruHIQbVdq6Zx2grpGQo/aZgyNhyyQfLgFw7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_10,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407310128
X-Proofpoint-ORIG-GUID: WTXzhG4EVCqyq4fKbMXGY4Dm35glzu2B
X-Proofpoint-GUID: WTXzhG4EVCqyq4fKbMXGY4Dm35glzu2B

T24gV2VkLCAyMDI0LTA3LTMxIGF0IDE0OjM2ICswODAwLCBZdWUgSGFpYmluZyB3cm90ZToNCj4g
Q29tbWl0IGY0Zjk0M2M5NThhMiAoIlJEUzogSUI6IGFjayBtb3JlIHJlY2VpdmUgY29tcGxldGlv
bnMgdG8NCj4gaW1wcm92ZSBwZXJmb3JtYW5jZSIpDQo+IHJlbW92ZWQgcmRzX2liX3JlY3ZfdGFz
a2xldF9mbigpIGltcGxlbWVudGF0aW9uIGJ1dCBub3QgdGhlDQo+IGRlY2xhcmF0aW9uLg0KPiBB
bmQgY29tbWl0IGVjMTYyMjdlMTQxNCAoIlJEUy9JQjogSW5maW5pYmFuZCB0cmFuc3BvcnQiKSBk
ZWNsYXJlZCBidXQNCj4gbmV2ZXIgaW1wbGVtZW50ZWQNCj4gb3RoZXIgZnVuY3Rpb25zLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogWXVlIEhhaWJpbmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4NCj4g
UmV2aWV3ZWQtYnk6IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4NCg0KSGVsbG8gWXVl
LA0KDQpUaGFua3MgZm9yIGZpbmRpbmcgdGhlc2UuICBUaGUgZGVjbGFyYXRpb25zIGRvIGFwcGVh
ciB1bnVzZWQsIHNvIEkNCnRoaW5rIGl0IGlzIGZpbmUgdG8gcmVtb3ZlIHRoZW0uICBUaGFua3Mg
Zm9yIHRoZSBjbGVhbiB1cC4NCg0KUmV2aWV3ZWQtYnk6IEFsbGlzb24gSGVuZGVyc29uIDxhbGxp
c29uLmhlbmRlcnNvbkBvcmFjbGUuY29tPg0KDQo+IC0tLQ0KPiDCoG5ldC9yZHMvaWIuaCB8IDQg
LS0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL25ldC9yZHMvaWIuaCBiL25ldC9yZHMvaWIuaA0KPiBpbmRleCAyYmE3MTEwMmIxZjEuLjhl
ZjMxNzhlZDRkNiAxMDA2NDQNCj4gLS0tIGEvbmV0L3Jkcy9pYi5oDQo+ICsrKyBiL25ldC9yZHMv
aWIuaA0KPiBAQCAtMzY5LDkgKzM2OSw2IEBAIGludCByZHNfaWJfY29ubl9hbGxvYyhzdHJ1Y3Qg
cmRzX2Nvbm5lY3Rpb24NCj4gKmNvbm4sIGdmcF90IGdmcCk7DQo+IMKgdm9pZCByZHNfaWJfY29u
bl9mcmVlKHZvaWQgKmFyZyk7DQo+IMKgaW50IHJkc19pYl9jb25uX3BhdGhfY29ubmVjdChzdHJ1
Y3QgcmRzX2Nvbm5fcGF0aCAqY3ApOw0KPiDCoHZvaWQgcmRzX2liX2Nvbm5fcGF0aF9zaHV0ZG93
bihzdHJ1Y3QgcmRzX2Nvbm5fcGF0aCAqY3ApOw0KPiAtdm9pZCByZHNfaWJfc3RhdGVfY2hhbmdl
KHN0cnVjdCBzb2NrICpzayk7DQo+IC1pbnQgcmRzX2liX2xpc3Rlbl9pbml0KHZvaWQpOw0KPiAt
dm9pZCByZHNfaWJfbGlzdGVuX3N0b3Aodm9pZCk7DQo+IMKgX19wcmludGYoMiwgMykNCj4gwqB2
b2lkIF9fcmRzX2liX2Nvbm5fZXJyb3Ioc3RydWN0IHJkc19jb25uZWN0aW9uICpjb25uLCBjb25z
dCBjaGFyICosDQo+IC4uLik7DQo+IMKgaW50IHJkc19pYl9jbV9oYW5kbGVfY29ubmVjdChzdHJ1
Y3QgcmRtYV9jbV9pZCAqY21faWQsDQo+IEBAIC00MDIsNyArMzk5LDYgQEAgdm9pZCByZHNfaWJf
aW5jX2ZyZWUoc3RydWN0IHJkc19pbmNvbWluZyAqaW5jKTsNCj4gwqBpbnQgcmRzX2liX2luY19j
b3B5X3RvX3VzZXIoc3RydWN0IHJkc19pbmNvbWluZyAqaW5jLCBzdHJ1Y3QNCj4gaW92X2l0ZXIg
KnRvKTsNCj4gwqB2b2lkIHJkc19pYl9yZWN2X2NxZV9oYW5kbGVyKHN0cnVjdCByZHNfaWJfY29u
bmVjdGlvbiAqaWMsIHN0cnVjdA0KPiBpYl93YyAqd2MsDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCByZHNfaWJfYWNrX3N0
YXRlICpzdGF0ZSk7DQo+IC12b2lkIHJkc19pYl9yZWN2X3Rhc2tsZXRfZm4odW5zaWduZWQgbG9u
ZyBkYXRhKTsNCj4gwqB2b2lkIHJkc19pYl9yZWN2X2luaXRfcmluZyhzdHJ1Y3QgcmRzX2liX2Nv
bm5lY3Rpb24gKmljKTsNCj4gwqB2b2lkIHJkc19pYl9yZWN2X2NsZWFyX3Jpbmcoc3RydWN0IHJk
c19pYl9jb25uZWN0aW9uICppYyk7DQo+IMKgdm9pZCByZHNfaWJfcmVjdl9pbml0X2FjayhzdHJ1
Y3QgcmRzX2liX2Nvbm5lY3Rpb24gKmljKTsNCg0K

