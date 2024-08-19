Return-Path: <linux-rdma+bounces-4414-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A18956AF3
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 14:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9309280FCE
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 12:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EB216B38F;
	Mon, 19 Aug 2024 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PmhknUGy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="M4PCOl+9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C6F16848B;
	Mon, 19 Aug 2024 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070898; cv=fail; b=LkeU+jioKPGT/uxohWs4y/BhgbxpCMCpFgF24G+853+9Jr69RwAdtOIWZ26LWnY4uWkEPwrePogzpIjrvuCIst+1LQNVc2NJGJdCMzw2cmR/clblDbP3Ics+RqKXfcAQBkgsuCZHcxGKwHbaXrNjBnaqo+x55HDNRi1x96YKbqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070898; c=relaxed/simple;
	bh=k4ID7TXMUjXXJTnAw+/e1NUip7qAP1LOeYjyOkWonUo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gGTXQEf0hIaOAiuGAb1DggllfoL0kucq6BsREWUE2WNmjBXM91CALMC4EZWMBOJG2aQ88V6uDZb/vfH3t8LMSDN8iOXlvE8D5wQllvP9f2MbkSqowzaaUxAkbGl4BG8loxPAdqWxHh1IPKonc4aFKFPMXVDj+TxIRVIr+6VCR9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PmhknUGy; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=M4PCOl+9; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724070895; x=1755606895;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=k4ID7TXMUjXXJTnAw+/e1NUip7qAP1LOeYjyOkWonUo=;
  b=PmhknUGyttVvmaqKbSVsDoIDHJRHPDuoIIpIk/MhTZxNYkU2IXBgrdVS
   s7Zl8In5nUPtxZ2friaWqJTPwccoySucT+AIlyPiyrHzDle6G7CGq8ba+
   Q2cdb3nMkQiEOAgRc7I0trm6hg+hcLJhbqBSEyLwScZ+oQYk7DEh//o3+
   7XTUOTtmd0qHWWgF+zDr7ocpPNS1Osol8rTt67w/EOFAEnssjn1cuBzi5
   c+EKsrpg+MDIXHCeVr1dw5g/IJBrlXXHm2fpSWOvPBGN6ao6VuIzMSVS8
   C0xXwPlsGJO8j/869d8NLg9HfuH5T+DkhOODrlnyvkMuTbat2YvFHu7qh
   g==;
X-CSE-ConnectionGUID: Tcq8qb7bTmeFk2Sg6zXkQQ==
X-CSE-MsgGUID: KcGgofEjQOS7gM5aOGz+eQ==
X-IronPort-AV: E=Sophos;i="6.10,159,1719849600"; 
   d="scan'208";a="24013839"
Received: from mail-eastus2azlp17011025.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([40.93.12.25])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2024 20:34:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsjTCWChoHtZj3DMwtSU1YiyZthuDPrF0v+1q6OYF8IIOxMEnlZT5+dI8uTdzRQR24h+mAHryyTbeMcxB7bdQ70aUwI2n0ktb6yzG7dDnHTNH37xo3nj0PipQckXITt65rz0WYqinfUMEFT7F7LM1L4e7TzCGyVFGEurvDi9JsYAUvyHWhutrXReWt0lwjJ6BlCdXBw8i9KSc5n+gHjTTIiGkcUTA3va5CPuGtE2BTCsasxgd70LtP0FwRgl7iFPlqwVoar82KvsEyY2UwO8WcOaOP263CO179cbLVDNC1EGyiAZUHvC3xzvqi8kcTyekbUYyRbSuisV/gX/MJpKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4ID7TXMUjXXJTnAw+/e1NUip7qAP1LOeYjyOkWonUo=;
 b=S7pONDWMVsWPOwzEtPCLXQcr1vH2cCpdr+ORP6DEeeL7WnmDDZR08EXjbp9clI++TMZEe9zCoowbnjlRwyj79tf+Y0CoRLAx08Uk8Ib7IZebkOgkf99bDTE7/xallNt0jxl07u8zubyzpE9rsRBff/EFcYhBQaS2PJ3ABfRzgSlinUuKOjnWFdurixqGZGooxZJlwGO0H6eNOKSTTE8fHNQGB9W8PdcoVPm59fKWqSH/gcXc9sEkEu6X254FG6i6X6/RbJfWerAADnSHawEjmx4ihkC+24Lg1/BWj+NR8eRuxTxhkP2VnY3DLSeSL2//uV+NZWodY6pptw3pn7F2pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4ID7TXMUjXXJTnAw+/e1NUip7qAP1LOeYjyOkWonUo=;
 b=M4PCOl+9qeasT6mEOgwG7MVl8Ko/ZVQJmMWuuEZNsiKUcCThmoV2UI17r48Y5HkxK/PQBDF2kaV+JXHUKxOLqpLerv6ARj7KrKi52xC6UNr5hWNgEl9I4t9+dFpmPkydlXFtTIRQEZJI7ZAmGos4zW1XwcE/5Azo+C7VaT+XbbI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB6951.namprd04.prod.outlook.com (2603:10b6:610:a0::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.20; Mon, 19 Aug 2024 12:34:51 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 12:34:51 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: Yi Zhang <yi.zhang@redhat.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "nbd@other.debian.org" <nbd@other.debian.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.11-rc1 kernel
Thread-Topic: blktests failures with v6.11-rc1 kernel
Thread-Index:
 AQHa5LuxC+CuFbi0TEaEvvPM0kqq9rIT4jmAgAAE2QCAAEdYgIAQpsUAgAHuX4CAB9tYAA==
Date: Mon, 19 Aug 2024 12:34:51 +0000
Message-ID: <tczctp5tkr34o3k3f4dlyhuutgp2ycex6gdbjuqx4trn6ewm2i@qbkza3yr5wdd>
References: <5yal5unzvisrvfhhvsqrsqgu4tfbjp2fsrnbuyxioaxjgbojsi@o2arvhebzes3>
 <ab363932-ab3d-49b1-853d-7313f02cce9e@linux.ibm.com>
 <ljqlgkvhkojsmehqddmeo4dng6l3yaav6le2uslsumfxivluwu@m7lkx3j4mkkw>
 <79a7ec0d-c22d-44cf-a832-13da05a1fcbd@linux.ibm.com>
 <CAHj4cs-5DPDFuBzm3aymeAi6UWHhgXSYsgaCACKbjXp=i0SyTA@mail.gmail.com>
 <1f917bc1-8a6a-4c88-a619-cf8ddc4534a4@linux.ibm.com>
In-Reply-To: <1f917bc1-8a6a-4c88-a619-cf8ddc4534a4@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB6951:EE_
x-ms-office365-filtering-correlation-id: b5b5dc96-eb35-4bfc-a3fd-08dcc04b5238
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OGVRSFd0bkdmWTQxK2JBOVNGU0JiMnlqeDNPZy9kVndTYkpWQjdBaGNadGxj?=
 =?utf-8?B?bk80clZSSjlFWlhSNlR2R2R2YmRlS3Y0VVVsWncvY2VJczc4NmdzbFNBaGRo?=
 =?utf-8?B?RDg0Rzh1ZG1nNjZoNjJLREVQUzZLWjNoWWpKKzY4WGVPcEVnTXVjMzRHRVUx?=
 =?utf-8?B?dVRVbmxJbXJFdHRuU1ZrblptVGVuK3NsNEY4NHQzTVhhSTZ6REJ5ZE5CbVo3?=
 =?utf-8?B?amRQR0hqNVhadHJPOXhoTlVGTzN5V1MxVFpSdnA4RTQ0Y1lxdUxHcmdzRFhI?=
 =?utf-8?B?eU00YS9EVTBya0F4dnljRzFaZTFTS281NjEvaXJiM1krd2FGOHp0eGxHOXEy?=
 =?utf-8?B?NW1tcVlhVFFPQW9oNWNPRmdpeGNMYUF6QTJRQk0zdmE3VmM3bFNrNU1tNE1t?=
 =?utf-8?B?SjNJaXJERExvOEw4WWpsWkErdmhiV25LZG1pTER2azJZa3lDTFdmWDhSL252?=
 =?utf-8?B?K1MrV2Q5aEVMTk1uejNQWGhKc0R3d09uN0tkUWRnSzBDQnBmR1loUlVNY090?=
 =?utf-8?B?SzNZMWF6RVRhNlB0dFRjd00rUnlybGs1UHorcENVdlpMME9HbklzaFR6Ri9x?=
 =?utf-8?B?Y3BxSEkrSkQ1L0hDVVp4YzBFclo2NUIzUWxWbnpQcFlZOFhVbzczb0dySDNv?=
 =?utf-8?B?K3VQcmJWSDc3NEovam1UUkU5MVd0MHFNYnVrUkpZN1NaQVdnNUlBdk15WndT?=
 =?utf-8?B?K3VkSC85ZUlpWEN2R0t1eVEwWmt5bTVSTUFaZzRSVU9jbHI1UzJQSTcrRDZB?=
 =?utf-8?B?VjBmSWY1SFVpVTFkajVTcFhCSXF4WitSekNyNytIdVNyV1lWOUFtYUZoVjM5?=
 =?utf-8?B?VVA5NldRRFBUQ2lYajdFZFhLTHA5cER4MW10eGdCUTg5UWlOY1VxL0d2QUhL?=
 =?utf-8?B?d1dmSXkzQWlMUVhuVzlaUVYwTGJRWjB3R0F1d1NSQzhuckpnYkpiSElHT3hB?=
 =?utf-8?B?bDRUSWdnZnJ4QUd3VEhoL2l1Y1JJYzl0VVFiRGs3bHFXQ1oxWENJMkd4aHYr?=
 =?utf-8?B?TzV4T0RQUWZJVEpWalFwSjB0aHNmQ2tHSGRQV1BkYmU3Zm95WEdWZklNYWhI?=
 =?utf-8?B?TFAwRjUyNUJycHpiRlF0a2xSODA1ZUkzcmlqR21aWW0zNGVHeXN6dXYzbHBh?=
 =?utf-8?B?akxKTWt4MzZCaC9JWU5hL0lCUVpiMlhKcU5ISWltbnBCTHlIQ1J4YUd2Snc3?=
 =?utf-8?B?QlJFRnE1YmY2WnRxTnpWQS9HVTNrNlpRWUhqSC85S21pRldJMFdOY2VmZlFY?=
 =?utf-8?B?dVV3a0VQRGlRa1k1UHBmbEVabENPWEQzcnp3Ni9YQUgyTkM3K3VrOWllRS9h?=
 =?utf-8?B?OStEKzZiSnZsdktiMnRuUmZRNVYxNGEzd2VEZjNzeTdpdXRGWG9hbUpqT3c3?=
 =?utf-8?B?NTVmWndMYWFUWUJMbkdtUVFRby9va2JubGlpWmMybkMxeWd1RUhXNzM5UTBJ?=
 =?utf-8?B?d0NrYjRUeUtYY0dVWmF2MWgwaGYxQ2JiVktLdmlQMUp5V3E0UTVUZnVyTlFh?=
 =?utf-8?B?cGpPWTVUQUF5UkoxejZMNEpCcCs1TktKdXVlNzdsUVd0alhmSVNJbDVNN1lq?=
 =?utf-8?B?aFV2VVlaNERITzRpN1p0Nnp0R3dvVzJoa1NEeGVBUU5vdTZ3amYwcDdPN2Z5?=
 =?utf-8?B?eDdFSnczL0NxblVLc0FlNHBOWm5aa2F0RUw0TWJsM2M2eERYZXFGaTBXTkxy?=
 =?utf-8?B?dEs0Z0JnVzVwemtNc0lVN3E3SGpDVXRxOE9IRSsrMUNqRFo3SHRFUktyQ1Fh?=
 =?utf-8?B?NUY3NzZ2dTFXQ05lMnA3WmJ5ajBYU3VydUc3WENTSnE4R2xaTHp4d3cxbnA0?=
 =?utf-8?B?TVVPYmo4by9aR1cyM3llRG02cCtMVnJWcy9lRzBSRVZzd1B1Mkt1NENuMUdj?=
 =?utf-8?B?V0kwci8zbVV4MEUydHB0WCszRE9kZW1uMDhBbkVxOE5zaEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ykt5SzZER0FIbHl3RlptcnJtVTEvdzBldEowMWI3MlQ4OFVMNVhVMzRTTi84?=
 =?utf-8?B?T2VZSmNWV3hpT1A2U3cvN3BrdzkvRkt6SGRxR1BYR1BLcjN6K0huOVA2R0Iy?=
 =?utf-8?B?enVRL3lUZms3V0wyNE92SmhuclMwZGhrc2lqUmF0eFZ5N0g4MHd1TGVQZVZS?=
 =?utf-8?B?YytFckJUZVBleWVES2ZDalQ1N0FObFV3bGRLa2VEV0ZLaGRzbVY1OWlJQWJW?=
 =?utf-8?B?bDJsWjJsd3pqcVN5R3FUVVlpaVBJbUhuRWlSb3NWaTZ0ekxTeU5lZXVKRmt6?=
 =?utf-8?B?aUJFZ1lTNFNnTmljM3liRjNkd3IwRWpZUVE4ZXpEQTdXc3pvVjhteUkwamRY?=
 =?utf-8?B?aGpaVXZRZi9KSldmUEZkNGFUV3V5TnZMRGhMOUF4SlZkZHVITWI4cjRuNzV6?=
 =?utf-8?B?RXJMaE43ZldWS2VKZFJicFJJdmNxTDdEaytHckhJUXRmR0hzMzRuS0VhMUhW?=
 =?utf-8?B?ODBRbkc2YktFbGlzN2IyTWh0a2xYeG9udkl4MUR5WloxZjVaeDd5bUplaVJR?=
 =?utf-8?B?V2JrbEJKeFFQZTFGUmhWYkZOdXBqQi8yY2Q1Q3prNVRpZ0wyQ2V6YzEzZU1u?=
 =?utf-8?B?Y3Bvakh2ZENUam03cW9URTVNZkZuMEs3c1QwTjRtWkU3NEZodTUzVFAwelhx?=
 =?utf-8?B?Z1lFeEtTNy9PZWZUWEZxUWRpeEErYll1eFkwdXpKWTBYTGExNlBvWnJIaEFD?=
 =?utf-8?B?d3FTOTVZVjJObGg1cHFwYkk2czVYMWlwa1Byd2lCT09wYmZoU0NnbWNSbFcr?=
 =?utf-8?B?bVFBVG04MGVVeENFcml6b1VhOHorZUNLb2YwSm1wd2RjSHlPM2pLYTArOWcy?=
 =?utf-8?B?SEFOdFgwNFk3WnFyV3NaV2VreTVHR2sxZm40THovZjJkUUZyMHBKWktiNXFv?=
 =?utf-8?B?NHZyWFczaEo4ekxJUUdpbEFXWXBka2c0TGNHbDFZc3JmMUh3UW9HYlhJSnlM?=
 =?utf-8?B?alM1b3pXUE93eEVVTnNPa0R4WlIyR1JBK0NHbHpSSXM3OU5zMXh3UEJ0S3JE?=
 =?utf-8?B?RkNNWUtzOXZSOHB0SUNvOWZkN05GaEp1K09HOXRjaUF1anRYSVVMeWs1Tkkv?=
 =?utf-8?B?NGYvd2s1N1EraUExMHYwWjlDMWVxZC9MK0QxNzB1c3I4YksydUcra1BvNHly?=
 =?utf-8?B?Y0NXT1RjM1YxQUR2aGpIWnJKUHBmRVJpakpyTldJWUxhOTdhMnhYOFo2clRR?=
 =?utf-8?B?SGhvY05oS0toTU03b1YrbVlRVkw0Vzd3aDVyK29oU09Pb2U2RnFBUzVGd2w1?=
 =?utf-8?B?c3I2MzVvSGlIVW4xQXgzQUlldEhWREdHUGxST2ZKeU8vNXJhUGxaWGRUdWRQ?=
 =?utf-8?B?NjQ4Y2lZS3dVc013Rlc0S1l6cTVXUmlOZGc0R0hMb1FHRXdWYS9vMlJGYmJy?=
 =?utf-8?B?a25wY2hzVG5xa3VCQ2FUS0crdENzOXl1dEZXTXErbE5Xb2JINUVjUlBUY0pS?=
 =?utf-8?B?N2VxbkJodHdNUjVsdlpQSzZBcTNDSndZdm1DcDZCeVpxaXQzRWdtTGJMMWU3?=
 =?utf-8?B?Y2szOGZQK08vdmJPNGcyNjdIeisrbFVxemo1YVJLOGNJUW0xNVQ2T1Z2TzdE?=
 =?utf-8?B?WVpGczJDL0dDVkhVTU5UZHFaQTZralJTZEYzS2NDZ0xUY2dNbWRsK2lDUURv?=
 =?utf-8?B?WDBqMlA1bkI5enBuV2wrSXlWOE5xTndhVHNsbGRaNFg0dVlHUGF5WGc1M3FR?=
 =?utf-8?B?Vy9LYWlEOXQ3VE1CNmNSRy84azdjZ1BCSDM3a0JlSHRFTnhaSkFPdStFQXgv?=
 =?utf-8?B?Mm1mVVdVRnhNRTJ3OEFtUmFQalFOa2IrZVJnS0lqR0g2ZGxPQS9XTzBoVFJT?=
 =?utf-8?B?L2pNdjNuZWtvS3FKK2tVek5ETk5BU2drU0Q3STZnZzQwL0N4V0FqekpFVFJK?=
 =?utf-8?B?MWM1S2JuSEdKZHRCbGpqOVduS1hUZWVPZzFUSGV6c2E1ZlVURGNLSUkrNXRj?=
 =?utf-8?B?dUVuaTRnRG9jRGNQMThjZ1ZnMisrbDhyV3VYbFdGV0orMUpiUjUwa2xSamJi?=
 =?utf-8?B?bGF4cTB4UDRCWml5RmMwZUI2d0hjNkRmVUtpL2NNZ2NaTzJOaFVPSHliZ1Ji?=
 =?utf-8?B?U2h3MW9RbWhmeUNLblRGc0N3WDF4aGxjMVVlMTBVTWdIV2xyUnlRU3A1M2ls?=
 =?utf-8?B?L09KWERnN0tKUyt5V1pvbHllS0xQNXgzZk8ycVR4R2UxOHZReFp6Rkl0QzBj?=
 =?utf-8?Q?Ca6Ieq32ns7kIXD8NWl6pgc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75DE5A6A7B0F5B4596DF93A3EFCBC9E3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nZtIoj6lbrHoEBx61nVVilnINMjEfd6m8R6ol5OHZKooKsLkwyvy4bkE+Avv04CP0KWzWDrzIT9c7knKciOEZVTGtti4YKQkYIOj2CwOfUmKYcJfzpVlYlP829l2jLCxHokf/MkN+1yHi/lMATs52SMtCx7zYHf6zd7RyqgSeipX8rcp7oWisN4LZnuZ/U3Ujf1vJP2i4BsVi4S549yBkuYpcdGvrvNirF9OXRcWZ/khkuxpYUm5SCxw7Vl/wnqyyEtPxWBp63uKe7BUmUoF8jACn0yte0I6bkGOFShtALiM534KEZ2YC9uuhE8zOSuAPoZm/hP8ypfaXd6nU2/ykk20eC2QuYkAAuj2yQKknwmYbsYYUoy1ywQl8IuNBDfg4qqiD1aqGBUKON5ud9YCn5wGuaR0i3T5cFVjH1LHV0T7c/TNfE0odoMWhjDiF+dxEtujHNsy4rIlkrnKj1PT8zgLdfy4jPDh49evzXuwc+JYVN0onRORSV+sXUZ/LohySAbGjkiOXygccF987EHsn2xAepyYzcVE3FhfPFCU8W4T4JfIaeJLy48u9jhrkBKL2UsOkJbgNH4TdKeYkTmc/R2kc8Hql1xYzk8o2zPjznPZoBJN+kl9WjZBno473rws
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b5dc96-eb35-4bfc-a3fd-08dcc04b5238
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 12:34:51.3692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 71RI3FIFFySy6Lyb4RsxYQ8xDogAjLbx9QHPzHF+/SXHcuIKO4gCjkIEOhnEeZuzJP5D1CHkxZ2H7YwHq3tLXw6Ah2lm9tvZXW30T9LnglI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6951

T24gQXVnIDE0LCAyMDI0IC8gMTg6MDUsIE5pbGF5IFNocm9mZiB3cm90ZToNCj4gDQo+IA0KPiBP
biA4LzEzLzI0IDEyOjM2LCBZaSBaaGFuZyB3cm90ZToNCj4gPiBPbiBTYXQsIEF1ZyAzLCAyMDI0
IGF0IDEyOjQ54oCvQU0gTmlsYXkgU2hyb2ZmIDxuaWxheUBsaW51eC5pYm0uY29tPiB3cm90ZToN
Cj4gPiANCj4gPiBUaGVyZSBhcmUgbm8gc2ltdWx0YW5lb3VzIHRlc3RzIGR1cmluZyB0aGUgQ0tJ
IHRlc3RzIHJ1bm5pbmcuDQo+ID4gSSByZXByb2R1Y2VkIHRoZSBmYWlsdXJlIG9uIHRoYXQgc2Vy
dmVyIGFuZCBhbHdheXMgY2FuIGJlIHJlcHJvZHVjZWQNCj4gPiB3aXRoaW4gNSB0aW1lczoNCj4g
PiAjIHNoIGEuc2gNCj4gPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0wDQo+ID4gbnZt
ZS8wNTIgKHRyPWxvb3ApIChUZXN0IGZpbGUtbnMgY3JlYXRpb24vZGVsZXRpb24gdW5kZXIgb25l
IHN1YnN5c3RlbSkgW3Bhc3NlZF0NCj4gPiAgICAgcnVudGltZSAgMjEuNDk2cyAgLi4uICAyMS4z
OThzDQo+ID4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09MQ0KPiA+IG52bWUvMDUyICh0
cj1sb29wKSAoVGVzdCBmaWxlLW5zIGNyZWF0aW9uL2RlbGV0aW9uIHVuZGVyIG9uZSBzdWJzeXN0
ZW0pIFtmYWlsZWRdDQo+ID4gICAgIHJ1bnRpbWUgIDIxLjM5OHMgIC4uLiAgMjEuOTc0cw0KPiA+
ICAgICAtLS0gdGVzdHMvbnZtZS8wNTIub3V0IDIwMjQtMDgtMTAgMDA6MzA6MDYuOTg5ODE0MjI2
IC0wNDAwDQo+ID4gICAgICsrKyAvcm9vdC9ibGt0ZXN0cy9yZXN1bHRzL25vZGV2X3RyX2xvb3Av
bnZtZS8wNTIub3V0LmJhZA0KPiA+IDIwMjQtMDgtMTMgMDI6NTM6NTEuNjM1MDQ3OTI4IC0wNDAw
DQo+ID4gICAgIEBAIC0xLDIgKzEsNSBAQA0KPiA+ICAgICAgUnVubmluZyBudm1lLzA1Mg0KPiA+
ICAgICArY2F0OiAvc3lzL2Jsb2NrL252bWUxbjIvdXVpZDogTm8gc3VjaCBmaWxlIG9yIGRpcmVj
dG9yeQ0KPiA+ICAgICArY2F0OiAvc3lzL2Jsb2NrL252bWUxbjIvdXVpZDogTm8gc3VjaCBmaWxl
IG9yIGRpcmVjdG9yeQ0KPiA+ICAgICArY2F0OiAvc3lzL2Jsb2NrL252bWUxbjIvdXVpZDogTm8g
c3VjaCBmaWxlIG9yIGRpcmVjdG9yeQ0KPiA+ICAgICAgVGVzdCBjb21wbGV0ZQ0KPiA+ICMgdW5h
bWUgLXINCj4gPiA2LjExLjAtcmMzDQo+IA0KPiBXZSBtYXkgbmVlZCB0byBkZWJ1ZyB0aGlzIGZ1
cnRoZXIuIElzIGl0IHBvc3NpYmxlIHRvIHBhdGNoIGJsa3Rlc3QgYW5kIA0KPiBjb2xsZWN0IHNv
bWUgZGV0YWlscyB3aGVuIHRoaXMgaXNzdWUgbWFuaWZlc3RzPyBJZiB5ZXMgdGhlbiBjYW4geW91
IHBsZWFzZQ0KPiBhcHBseSB0aGUgYmVsb3cgZGlmZiBhbmQgcmUtcnVuIHlvdXIgdGVzdD8gVGhp
cyBwYXRjaCB3b3VsZCBjYXB0dXJlIG91dHB1dCANCj4gb2YgIm52bWUgbGlzdCIgYW5kICJzeXNm
cyBhdHRyaWJ1dGUgdHJlZSBjcmVhdGVkIHVuZGVyIG5hbWVzcGFjZSBoZWFkIG5vZGUiDQo+IGFu
ZCBzdG9yZSB0aG9zZSBkZXRhaWxzIGluIDA1Mi5mdWxsIGZpbGUuIA0KPiANCj4gZGlmZiAtLWdp
dCBhL2NvbW1vbi9udm1lIGIvY29tbW9uL252bWUNCj4gaW5kZXggOWU3OGYzZS4uNzgwYjVlMyAx
MDA2NDQNCj4gLS0tIGEvY29tbW9uL252bWUNCj4gKysrIGIvY29tbW9uL252bWUNCj4gQEAgLTU4
OSw4ICs1ODksMjMgQEAgX2ZpbmRfbnZtZV9ucygpIHsNCj4gICAgICAgICAgICAgICAgIGlmICEg
W1sgIiR7bnN9IiA9fiBudm1lWzAtOV0rblswLTldKyBdXTsgdGhlbg0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICBjb250aW51ZQ0KPiAgICAgICAgICAgICAgICAgZmkNCj4gKyAgICAgICAgICAg
ICAgIGVjaG8gLWUgIlxuQmVmb3JlICR7bnN9L3V1aWQgY2hlY2s6XG4iID4+ICR7RlVMTH0NCj4g
KyAgICAgICAgICAgICAgIGVjaG8gLWUgIlxuYG52bWUgbGlzdCAtdmBcbiIgPj4gJHtGVUxMfQ0K
PiArICAgICAgICAgICAgICAgZWNobyAtZSAiXG5gdHJlZSAke25zfWBcbiIgPj4gJHtGVUxMfQ0K
PiArDQo+ICAgICAgICAgICAgICAgICBbIC1lICIke25zfS91dWlkIiBdIHx8IGNvbnRpbnVlDQo+
ICAgICAgICAgICAgICAgICB1dWlkPSQoY2F0ICIke25zfS91dWlkIikNCj4gKw0KPiArICAgICAg
ICAgICAgICAgaWYgWyAiJD8iID0gIjEiIF07IHRoZW4NCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgZWNobyAtZSAiXG5GYWlsZWQgdG8gcmVhZCAkbnMvdXVpZFxuIiA+PiAke0ZVTEx9DQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGVjaG8gImBudm1lIGxpc3QgLXZgIiA+PiAke0ZVTEx9DQo+
ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIFsgLWQgIiR7bnN9IiBdOyB0aGVuDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZWNobyAtZSAiXG5gdHJlZSAke25zfWBcbiIgPj4g
JHtGVUxMfQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBlbHNlDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZWNobyAtZSAiXG4ke25zfSBkb2Vzbid0IGV4aXN0IVxuIiA+PiAk
e0ZVTEx9DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGZpDQo+ICsgICAgICAgICAgICAgICBm
aQ0KPiArDQo+ICAgICAgICAgICAgICAgICBpZiBbWyAiJHtzdWJzeXNfdXVpZH0iID09ICIke3V1
aWR9IiBdXTsgdGhlbg0KPiAgICAgICAgICAgICAgICAgICAgICAgICBiYXNlbmFtZSAiJHtuc30i
DQo+ICAgICAgICAgICAgICAgICBmaQ0KPiANCj4gDQo+IEFmdGVyIGFwcGx5aW5nIHRoZSBhYm92
ZSBkaWZmLCB3aGVuIHRoaXMgaXNzdWUgb2NjdXJzIG9uIHlvdXIgc3lzdGVtIGNvcHkgdGhpcyAN
Cj4gZmlsZSAiPC9wYXRoL3RvL2Jsa3Rlc3RzPi9yZXN1bHRzL25vZGV2X3RyX2xvb3AvbnZtZS8w
NTIuZnVsbCIgYW5kIHNlbmQgaXQgYWNyb3NzLiANCj4gVGhpcyBtYXkgZ2l2ZSB1cyBzb21lIGNs
dWUgYWJvdXQgd2hhdCBtaWdodCBiZSBnb2luZyB3cm9uZy4gDQoNCk5pbGF5LCB0aGFuayB5b3Ug
Zm9yIHRoaXMgc3VnZ2VzdGlvbi4gVG8gZm9sbG93IGl0LCBJIHRyaWVkIHRvIHJlY3JlYXRlIHRo
ZQ0KZmFpbHVyZSBhZ2FpbiwgYW5kIG1hbmFnZWQgdG8gZG8gaXQgOikgV2hlbiBJIHJlcGVhdCB0
aGUgdGVzdCBjYXNlIDIwIG9yIDQwDQp0aW1lcyBvbmUgb2YgbXkgdGVzdCBtYWNoaW5lcywgdGhl
IGZhaWx1cmUgaXMgb2JzZXJ2ZWQgaW4gc3RhYmxlIG1hbm5lci4NCg0KSSBhcHBsaWVkIHlvdXIg
ZGVidWcgcGF0Y2ggYWJvdmUgdG8gYmxrdGVzdHMsIHRoZW4gSSByZXBlYXRlZCB0aGUgdGVzdCBj
YXNlLg0KVW5mb3J0dW5hdGVseSwgdGhlIGZhaWx1cmUgZGlzYXBwZWFyZWQuIFdoZW4gSSByZXBl
YXQgdGhlIHRlc3QgY2FzZSAxMDAgdGltZXMsDQp0aGUgZmFpbHVyZSB3YXMgbm90IG9ic2VydmVk
LiBJIGd1ZXNzIHRoZSBlY2hvcyBmb3IgZGVidWcgY2hhbmdlZCB0aGUgdGltaW5nIHRvDQphY2Nl
c3MgdGhlIHN5c2ZzIHV1aWQgZmlsZSwgdGhlbiB0aGUgZmFpbHVyZSBkaXNhcHBlYXJlZC4NCg0K
VGhpcyBoZWxwZWQgbWUgdGhpbmsgYWJvdXQgdGhlIGNhdXNlLiBUaGUgdGVzdCBjYXNlIHJlcGVh
dHMgX2NyZWF0ZV9udm1ldF9ucw0KYW5kIF9yZW1vdmVfbnZtZXRfbnMuIFRoZW4sIGl0IHJlcGVh
dHMgY3JlYXRpbmcgYW5kIHJlbW92aW5nIHRoZSBzeXNmcyB1dWlkDQpmaWxlLiBJIGd1ZXNzIHdo
ZW4gX3JlbW92ZV9udm1ldF9ucyBlY2hvcyAwIHRvICR7bnZlbXRfbnNfcGF0aH0vZW5hYmxlIHRv
DQpyZW1vdmUgdGhlIG5hbWVzcGFjZSwgaXQgZG9lcyBub3Qgd2FpdCBmb3IgdGhlIGNvbXBsZXRp
b24gb2YgdGhlIHJlbW92YWwgd29yay4NClRoZW4sIHdoZW4gX2ZpbmRfbnZtZV9ucygpIGNoZWNr
cyBleGlzdGVuY2Ugb2YgdGhlIHN5c2ZzIHV1aWQgZmlsZSwgaXQgcmVmZXJzIHRvDQp0aGUgc3lz
ZnMgdXVpZCBmaWxlIHRoYXQgdGhlIHByZXZpb3VzIF9yZW1vdmVfbnZtZXRfbnMgbGVmdC4gV2hl
biBpdCBkb2VzIGNhdA0KdG8gdGhlIHN5c2ZzIHV1aWQgZmlsZSwgaXQgZmFpbHMgYmVjYXVzZSB0
aGUgc3lzZnMgdXVpZCBmaWxlIGhhcyBnb3QgcmVtb3ZlZCwNCmJlZm9yZSByZWNyZWF0aW5nIGl0
IGZvciB0aGUgbmV4dCBfY3JlYXRlX252bWV0X25zLg0KDQpCYXNlZCBvbiB0aGlzIGd1ZXNzLCBJ
IGNyZWF0ZWQgYSBwYXRjaCBiZWxvdy4gSXQgbW9kaWZpZXMgdGhlIHRlc3QgY2FzZSB0byB3YWl0
DQpmb3IgdGhlIG5hbWVzcGFjZSBkZXZpY2UgZGlzYXBwZWFycyBhZnRlciBjYWxsaW5nIF9yZW1v
dmVfbnZtZXRfbnMuIChJIGFzc3VtZQ0KdGhhdCB0aGUgc3lzZnMgdXVpZCBmaWxlIGRpc2FwcGVh
cnMgd2hlbiB0aGUgZGV2aWNlIGZpbGUgZGlzYXBwZWFycykuIFdpdGgNCnRoaXMgcGF0Y2gsIHRo
ZSBmYWlsdXJlIHdhcyBub3Qgb2JzZXJ2ZWQgYnkgcmVwZWF0aW5nIGl0IDEwMCB0aW1lcy4gSSBh
bHNvDQpyZXZlcnRlZCB0aGUga2VybmVsIGNvbW1pdCBmZjBmZmU1YjdjM2MgKCJudm1lOiBmaXgg
bmFtZXNwYWNlIHJlbW92YWwgbGlzdCIpDQpmcm9tIHY2LjExLXJjNCwgdGhlbiBjb25maXJtZWQg
dGhhdCB0aGUgdGVzdCBjYXNlIHdpdGggdGhpcyBjaGFuZ2Ugc3RpbGwgY2FuDQpkZXRlY3QgdGhl
IHJlZ3Jlc3Npb24uDQoNCkkgd2lsbCBkbyBzb21lIG1vcmUgY29uZmlybWF0aW9uLiBJZiBpdCBn
b2VzIHdlbGwsIHdpbGwgcG9zdCB0aGlzIGNoYW5nZSBhcw0KYSBmb3JtYWwgcGF0Y2guDQoNCmRp
ZmYgLS1naXQgYS90ZXN0cy9udm1lLzA1MiBiL3Rlc3RzL252bWUvMDUyDQppbmRleCBjZjYwNjFh
Li40NjljZWZkIDEwMDc1NQ0KLS0tIGEvdGVzdHMvbnZtZS8wNTINCisrKyBiL3Rlc3RzL252bWUv
MDUyDQpAQCAtMzksMTUgKzM5LDMyIEBAIG52bWZfd2FpdF9mb3JfbnMoKSB7DQogCQlucz0kKF9m
aW5kX252bWVfbnMgIiR7dXVpZH0iKQ0KIAlkb25lDQogDQorCWVjaG8gIiRucyINCiAJcmV0dXJu
IDANCiB9DQogDQorbnZtZl93YWl0X2Zvcl9uc19yZW1vdmFsKCkgew0KKwlsb2NhbCBucz0kMSBp
DQorDQorCWZvciAoKGkgPSAwOyBpIDwgMTA7IGkrKykpOyBkbw0KKwkJaWYgW1sgISAtZSAvZGV2
LyRucyBdXTsgdGhlbg0KKwkJCXJldHVybg0KKwkJZmkNCisJCXNsZWVwIC4xDQorCQllY2hvICJ3
YWl0IHJlbW92YWwgb2YgJG5zIiA+PiAiJEZVTEwiDQorCWRvbmUNCisNCisJaWYgW1sgLWUgL2Rl
di8kbnMgXV07IHRoZW4NCisJCWVjaG8gIkZhaWxlZCB0byByZW1vdmUgdGhlIG5hbWVzcGFjZSAk
Ig0KKwlmaQ0KK30NCisNCiB0ZXN0KCkgew0KIAllY2hvICJSdW5uaW5nICR7VEVTVF9OQU1FfSIN
CiANCiAJX3NldHVwX252bWV0DQogDQotCWxvY2FsIGl0ZXJhdGlvbnM9MjANCisJbG9jYWwgaXRl
cmF0aW9ucz0yMCBucw0KIA0KIAlfbnZtZXRfdGFyZ2V0X3NldHVwDQogDQpAQCAtNjMsNyArODAs
NyBAQCB0ZXN0KCkgew0KIAkJX2NyZWF0ZV9udm1ldF9ucyAiJHtkZWZfc3Vic3lzbnFufSIgIiR7
aX0iICIkKF9udm1lX2RlZl9maWxlX3BhdGgpLiRpIiAiJHt1dWlkfSINCiANCiAJCSMgd2FpdCB1
bnRpbCBhc3luYyByZXF1ZXN0IGlzIHByb2Nlc3NlZCBhbmQgbnMgaXMgY3JlYXRlZA0KLQkJbnZt
Zl93YWl0X2Zvcl9ucyAiJHt1dWlkfSINCisJCW5zPSQobnZtZl93YWl0X2Zvcl9ucyAiJHt1dWlk
fSIpDQogCQlpZiBbICQ/IC1lcSAxIF07IHRoZW4NCiAJCQllY2hvICJGQUlMIg0KIAkJCXJtICIk
KF9udm1lX2RlZl9maWxlX3BhdGgpLiRpIg0KQEAgLTcxLDYgKzg4LDcgQEAgdGVzdCgpIHsNCiAJ
CWZpDQogDQogCQlfcmVtb3ZlX252bWV0X25zICIke2RlZl9zdWJzeXNucW59IiAiJHtpfSINCisJ
CW52bWZfd2FpdF9mb3JfbnNfcmVtb3ZhbCAiJG5zIg0KIAkJcm0gIiQoX252bWVfZGVmX2ZpbGVf
cGF0aCkuJGkiDQogCX0NCiAJZG9uZQ0K

