Return-Path: <linux-rdma+bounces-4597-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB3E961B31
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 02:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14C9285248
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 00:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E97FDF51;
	Wed, 28 Aug 2024 00:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="WhIXs/ft"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C1BBE6C
	for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2024 00:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724806368; cv=fail; b=pRbFooc9qS0CdP53S/9v6+8FlB/rIUJLg1ziBdfw1pCh719FJvmJ6qzZ9vtQVl8btl52gXDw5yJ2E96XqnNzK8PRJhSmDqPPw5xgLssSNqEzCcanw9WySAEYFOMDtRWatvGXQco91yucaNEA1rna6zMyZFmaouHggnz2YcWGdD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724806368; c=relaxed/simple;
	bh=9Fn88xCLl3SWHj1XJ6sSxOo0HYdWYJX0aUaHqyyirT4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uYYEFVZO5yyYGaoytUlt3nbOd2wqgR35hktMPCU5Kbh7t8lqtGByYl4JQ1pD6AHiqyhYnjQ4SraLDsWJgXQPCTmbcjoPDGJy1fAn9g83ki8Qjt7Kr+njIYub1sb4HfBl7I2u4ht8DUDbUqJ7MAFym/YDUc7oyGvv7HAxFJD9uxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=WhIXs/ft; arc=fail smtp.client-ip=68.232.159.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1724806366; x=1756342366;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=9Fn88xCLl3SWHj1XJ6sSxOo0HYdWYJX0aUaHqyyirT4=;
  b=WhIXs/ftPq5YhXYxaflZd3P4ZMd6Ig53j9PMLOnGH9dn1X3N947V4Ylf
   N7b3ZLjhhPpGGXqwWjHq2/HZzEdmzVASe2vNavCJsqWO1I9zfitIftj/d
   bZiOpXJnoYgL/zjsXLRlrcJlD5h8heIXhSFpxgWfsEzhXBImIP1lA+Dwa
   80RgIgUiPoqemre8CcVNAmf24bb6hzfPl+j9lJyBgOluKhvF5cnB/jlbC
   Ji36ADohxv69I3ZzHQTIRUuSHvaQhMNWXreNcF9MHEibOCrizGqtJ+sNi
   8kUEfVDwIcKduwz9UK7h8WbwRjz4Fao0OFfBlUky2QRE+SO+AK3WpukvS
   Q==;
X-CSE-ConnectionGUID: EeNBrAhRTmaEkX5JAW4jGQ==
X-CSE-MsgGUID: T/R+bTWgQLi9cv3i1SVh8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="129272117"
X-IronPort-AV: E=Sophos;i="6.10,181,1719846000"; 
   d="scan'208";a="129272117"
Received: from mail-japanwestazlp17010001.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.1])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 09:51:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lu/keB7AIA8qjoa6ge0fwIiNJ3ZmEa0FMInVXUsNY/ehb1Qx75VbHVM1joizQcRmdsfRHoQ8mUeP5ZSwdvKqCaxtm5Fliwx3BoCzdEOqTEc7/axEc6S5rz+ffwr3LExWc9eWYn332bc+GLXhsp3A6d8k3Rz5ldFz7dZd8ZXybKZeXjRGrzsIR6Nibrzu3/8GYKyn0dwre7uVWJ6lHpLApaqSLgCoGzvIGI4FpKn6GhMPnwbl+HlSkyM/RdryUowH7Akj2PvnzFzsaLXm68pCrDls9pLStrC4N5j1pQ15dld0D/JSjMdUE9CYRczJahrirfqs41qjBPg167Rph/nSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Fn88xCLl3SWHj1XJ6sSxOo0HYdWYJX0aUaHqyyirT4=;
 b=K0XN9jfzgXVP/XZlP9BLzE/FLdW/SH1m+Nf3xllzOIFQBJ7dA7OBgt7BP65c3rkjUSKFjecPH5NpXjTXI+KehlNft6RIU4jDlfVyJSaRB72oIDDnIRr6/HaiW8ldoM7OHtrO80ThOvCAqjWG6RwgbqTMkVk6x70byhcKq8RrAvlgFqZTNZiAZwQH6RA0SPuskN3h6FRw9xRkDZx7toBGC1co5LlXxyOIcP0jG+YdhkB7itXXgJbjp6rbPWZeOt8Sx2kNxYrHLCgQ7e3hXWcTL8pehlxNKF43CSyjovPxNcEY5mHrln+XlpGZyEGxWH9UJ5EusSnBYP9cUx4n/5fZuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS3PR01MB6706.jpnprd01.prod.outlook.com (2603:1096:604:108::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 00:51:30 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%3]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 00:51:30 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: =?utf-8?B?6Z2z5paH5a6+?= <jinwenbinxue@163.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject:
 =?utf-8?B?UmU6IFtidWddIHJkbWEtY29yZS9saWJyZG1hY20vY21hLmMgcmRtYV9jcmVh?=
 =?utf-8?B?dGVfcXBfZXjvvJphZGQgaWQtPmNxIHJlZmVyIHRvIHFwX2F0dHItPmNxLCB3?=
 =?utf-8?B?aGVuIHFwX2F0dHItPmNxIGlzIG5vdCBOVUxMLCBhbmQgaWQtPmNxIGlzIE5V?=
 =?utf-8?Q?LL?=
Thread-Topic:
 =?utf-8?B?W2J1Z10gcmRtYS1jb3JlL2xpYnJkbWFjbS9jbWEuYyByZG1hX2NyZWF0ZV9x?=
 =?utf-8?B?cF9leO+8mmFkZCBpZC0+Y3EgcmVmZXIgdG8gcXBfYXR0ci0+Y3EsIHdoZW4g?=
 =?utf-8?Q?qp=5Fattr->cq_is_not_NULL,_and_id->cq_is_NULL?=
Thread-Index: AQHa+ElaPqWbuw+F20iz+6JnLWysKLI72EEA
Date: Wed, 28 Aug 2024 00:51:30 +0000
Message-ID: <63408cd4-c4a9-4268-84a7-2c7fab9b690e@fujitsu.com>
References: <f819f8c.52ce.191927ea67c.Coremail.jinwenbinxue@163.com>
In-Reply-To: <f819f8c.52ce.191927ea67c.Coremail.jinwenbinxue@163.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS3PR01MB6706:EE_
x-ms-office365-filtering-correlation-id: 6cf1f78b-1eae-417b-1deb-08dcc6fb8e31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?cGFQcStGQXVhSUNBNCtCSzEzd1RNSCs1aldhYTh2eDIrY1hhc2FVNDlKWmFv?=
 =?utf-8?B?bVdKYXBjRjNBUFo4Kzd6UFJUbEdocjhDZVNaNFU1bXRsZTE4M1BzNDBleVVU?=
 =?utf-8?B?UFRXZFlOcTdhWlFSSHBQbkxlRGFWKzBTbU5uOTBXMlJrYXc2U09VQzJRanFT?=
 =?utf-8?B?M2pjdi9kTEcrMTQ5Sm9pSTk0WG1lRG5keXZDUmloMWlaaFo2WThpMkJkaFFs?=
 =?utf-8?B?ZzJDSHJMSkRyM2hPQmxGcE1BbTlXcXVxL251bEF4dXJhN3M3VWNOanBndVl1?=
 =?utf-8?B?eEs3ZFdld21ZR09lbXBXVkt2V2lWSm53V2VGMm5nNTE2aEc2QkdlRm9FQk90?=
 =?utf-8?B?SGRMTjdLeGpsenlYRnlkQWhldktZeUExUHlkOXpGRHBLTjNaNnFoQVplTGw1?=
 =?utf-8?B?VDhXQnB0MXgvRDFZc0s4VG5PVDVaUTlMZE9aMGlXMTB0MGdhay9MV0xLeVIy?=
 =?utf-8?B?K1pTTlJjcERzdUFyN21udDd0Q2IvWjdBM3pPemZnNURXQ1hnYVBNQWQzWTQ5?=
 =?utf-8?B?c3BmSExQQjNDa09HT05wUFAwOWZHaXVRRXlSNS9UNDJNVTBzTG9ra2lnTCt3?=
 =?utf-8?B?Vlo2b1VMcG4xY052K1hnbDVLVVhHdkpzMTUzTW1zUmY0R1hFN21JRlBIalVP?=
 =?utf-8?B?SExvbVkveTBZcEVweG9aMDgzbzhjM0tEcHcxcFY0UDRaZ1FqUlhXRTZRNGJk?=
 =?utf-8?B?d2RxR3c3RGh0TWVWRmFaeWF0OXVGRTRacU8ySld3VHhoUFo0OUJ2U0Vpc0xO?=
 =?utf-8?B?N1dQZnZYVGY0Q3J3eWFEKzJhUURnU01pZktWcFkvQm5hZ3VaaTBnNkZhK0ZI?=
 =?utf-8?B?WEF1YW52WThBMThIMmorak1XdEJIOUhGMnlOSVkvdG9wK2hMRzcwTWpiWUlv?=
 =?utf-8?B?VUgvbkgrVlBDdWdZK3BsTFp0MVZ5dC9IYUpiWUZHL1BUMGF0ejkvYXJzK2RI?=
 =?utf-8?B?SFRZdnF3VFprSnNuWmFKN3BPUXNHVU0xb2QwSTB3VFBLdjlCbEVUZWtRZGd3?=
 =?utf-8?B?YitaSm5IMGkzd2QwMERBdFVzTUx5ZXhMcGoyekF6OTFxVkpWcWs5dkpTcFBu?=
 =?utf-8?B?K2NDT2RzR0R5ODdOcFdZTVBkTFlpTE1kb0dGWkZPdDZqT1RDb3J1Njg2d3B1?=
 =?utf-8?B?ZXltK05haE1pSDNjV0xGTjdCVkJTWjAyR3hOMUJTazB0akgyYUs0MVZxYUlP?=
 =?utf-8?B?SFR4RUMra3F3SVdJUndDb0Y1cEVFbW4rbmQyVjlpc3F3cjhWclJZaWJLZ2Nm?=
 =?utf-8?B?K25yNWJEZ1NDS3dEM3liVmVMR01XRHdzU2lrdHhlcmc3ZmFHWC9pcHhGSzYx?=
 =?utf-8?B?ZzlRMnZkR1J0cGdzQ1JmSzk3aDBTNmFmbC9LT2pNeDJBRFA4bEhTOUZXR2J3?=
 =?utf-8?B?b3F0RFJTTTFIeWg4SmlUQXNIRHhDdFNHU1IxZ0VFSHdsck00Sm1YbEdMUlI2?=
 =?utf-8?B?ZnZ2VEljSC92YUFTVTZQRksrVFp6T0R1cXNuVnBtQzBDZERLS1lHTEpBcHUw?=
 =?utf-8?B?SHpvcml6RjNTdFlyWCtpSVY5eU9vakdrNHBYQ1ZuUG1kVy9OZDNwdHRoQ2Ev?=
 =?utf-8?B?Mm5wOVJsMkViMkg2QU8xSUlFSk9nT1FmTXJyNjk3N2FBYjdTS0NqQ1F1OGx4?=
 =?utf-8?B?WTkwQjBMb294MFhTMk4wdDQremFHWHFTOURvRWc4NzhJbHM4MUN2Ti95KzZU?=
 =?utf-8?B?MXkwM0ZnQ00yV01vNmJycFV1b2pxTlE0M3dtVmd2TVpxamUzU3IrbGlRaWhG?=
 =?utf-8?B?VnpvOGUrQk5DQjVuUlBVaE5mU2xxTFFPdmlHY1Q5cXF3c290M3lJTS9uc1pE?=
 =?utf-8?B?bVpWTW1FWm5KcW9UYXNlMms0NDJ6NXlSN2JRakZyd2V6VUxyVk9McS81OTFy?=
 =?utf-8?Q?AOjns4s50x4bV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0k2NW5rWWR1N3pFTElaVGsvV3o1ZWVZUUROMkEwR0I0b0ZuVmhuWHpUQ2Nj?=
 =?utf-8?B?Y3ZTK1NNK2kybEo4VC80VlV3bW51Szgxc2plRHQ5bnJTa3NBVEh5ZFVrQVdN?=
 =?utf-8?B?MkQzM1Y2Y0RkSmd1TW1hcjI4Y3pQUHpDNUoySWlKcURqU2RCb3o1NlFZQmN3?=
 =?utf-8?B?ZGlpWjNhUUJFVUhWSnFYYm1GQ2ErSXdnSGJDd2dZcTV4RmN3ZCtTWGcyUzAy?=
 =?utf-8?B?TEk0R1UwZnBrb21JbmppSEVUVXNKT1lXaWhML0tZQnRxRWEzU0JvRitYOWZM?=
 =?utf-8?B?d0d1ZDdWSUF2NFA4RFljaVgzTllkYmVIM1hxYXBKa0JKNXhQeUFBWk9RMmM3?=
 =?utf-8?B?NTIzYzZxNkd5NEYzb3FCVS9oaVppS0xPalVaUmJEZFNTVVBWVnhWVVRjcjVQ?=
 =?utf-8?B?eWZnUVB3OEdnQnh0YmFIMXZyK1FpR3FMNTVjM0pMcE5MZ1lTYUs0QW1Uands?=
 =?utf-8?B?Y1JEWHROcWIxZE4yWjV4cityQWdmN1Nua2FTUjN1THNKUDE2R2xnV2R4cWE4?=
 =?utf-8?B?T2poYUVxeW40YkJXRHZROXA5UDBZV09VSU5EaE5mL3czV0UxREhVbkgvTHFJ?=
 =?utf-8?B?Tmp6cFpjbXUxOTd1SGtNd2k2UDN6NUhuQU5zYWhOVzdQU0lLRGFvMmh6SFNj?=
 =?utf-8?B?OXNLVFdrY3pDWUVRMittc1BEREgyaWZhNXRpYWR3RlNrenhUZ2NsdWxpZU1h?=
 =?utf-8?B?UFEwbHZUM25lTmsyd1Z6R3BIbFRBTU9YZENlUkFNODZtUlVpMktKSW1aQjJS?=
 =?utf-8?B?KzgvZGFtc2R5b1lxM0pQaHdtUjVVbEhETTJxYVBSSWJRcmlvd1dnR1hSV2s1?=
 =?utf-8?B?Wkovcm5LbFZXbGVpMDlySm42Q01aQ2ZGb0tiRkRrQnNscmFzMlc1SWh0U001?=
 =?utf-8?B?UElNYlloSzhoYTQwRWFSMlF2eEJrSmorRVVVQVZCYmZFU0pPU3ZzaHVkU003?=
 =?utf-8?B?OVZnUUVsQkZnZ2gvUFgwWnNZLzVWblhmamhWKzVlSlZUVkhSakdkemMvRDhF?=
 =?utf-8?B?NGVKdDlJbkU2SHpQdTl4dHJvMlZva3IxSmtzcU9IaXRkRXpmVGxhYlo2RUVw?=
 =?utf-8?B?VU0xaGJRNWNabE1xdTlGRXJFWEUybHphQVI4czQ3OUQ3MktWMWFtUTZka3o0?=
 =?utf-8?B?RTJDa1Z4dTluTjFUenZZNW9pSlZQY3R4M1EzUmRUaVNFOTZ1WldFM0w5emwv?=
 =?utf-8?B?bm04UENJbURtVE9qN2NXTlVVVENUVEdXeTdRZ1l0SXVNTVNUeWdIcDFJdVF6?=
 =?utf-8?B?a0xJRy9aQXgyWGlHQWtTSzk0aHJKOVFDL2pPTGNYRVNNd0VWbDh6ZkcvMkFU?=
 =?utf-8?B?RE00cHkrT043aElkYU50TlBwV1ZnYVBGRWp1cmMzeXVQM043VHlnZ2VuTEow?=
 =?utf-8?B?c3RTTy9UaStSMWtSWHlMVE5jaS9iMnp3NS9RSy9JY09pcGllN2pJd0duWUJy?=
 =?utf-8?B?UktZQU1kaS9iMU85NldtdVY3ZlkxZ1M4bFloOFRTS2dRNmdKNFVNaFQ0SjRi?=
 =?utf-8?B?Qnh5dWtZUjN3YTdqMmp4OW05Vm9idko5Q1FIVWhXdlpyVC9tNThudjdxbjJY?=
 =?utf-8?B?WG1wTi84ZnNyTTRDWDBNRWZ0VlhUVTdsTG1Mb3VIRFMzTEpod3lnRUJmNUQ4?=
 =?utf-8?B?VENXSGhONEx3VHJHVUhobXQwcEcxV2FXUjRVak8rOWNnTTJuSE9RRWQ4dHdF?=
 =?utf-8?B?aVY0L05XQW1RaVp5SUpJaTYyK3RJUHI3S2tTWVQ0K09COGljWEEyK3hOVTJ2?=
 =?utf-8?B?RzRzU1JwK0FpSllUeFVhTkp0bTRYWlJZR1pOSEJweGNVNTlXUWovOHZVRG02?=
 =?utf-8?B?SDB5QWlMTFVpU1RsZ2dpcXhXdG4rWmNMSUlDZk8rUnB0VEN5bkw0RHpKeHMr?=
 =?utf-8?B?dDNIdVBNckFIcWtxa0JJSVVIUkFvckNSeDRuZjV1cHhhMStMZmV4K284THZC?=
 =?utf-8?B?UjYzV1FZM2ZtaERIL0h5L0p5Q0NPT2NzSmpOQTY2TDhxL2hSZlFCY1MxN3N6?=
 =?utf-8?B?SjZsZys3VXNxcWdLYmtaOURwYVFxUkdZb25hQzNEU0Y2TUZWTFU0ME4zS3pJ?=
 =?utf-8?B?eElobFNacHUwODFtVXpyTDdENDhLRVdzSUFvd0crcG12YXRrK1lrUnpnRDBO?=
 =?utf-8?B?Tk9LZ1ZOV1ZMVkFWYzRVdmw0a2xiZlFDQmRxUEJJYkRpLzI5WkRvYWk3Ui9L?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6A539FB224BF0468545445534BB4733@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QPfnLhv3SV2JLNF35NsOaSenKa5ZfbKJFSGTO9IDAcJXmvEOwq3w7wto/PXIibEKQYhzlxdhUP4PNLI3nY/psdCporIvoY5siudiEWtPYcgxSzpGePx2c3EmagQ6zv9Q/EmUj1TUPNnLfTiKUnwV9Nup8lSIkWt+/RZ2n0/vrhsBq+kf75zEVGw9BKemOF/Ecvq+rpbaZW+n7YktfzVqsL3pHGL6hpmVjosdUgffQkD5YtEutOPIJvjMsVvRtkKLIqtfVgyaTp9GpLE/GDUICLERQoOuyCGmcHcbu3um/NqMdE34lOY0cCgSljoorK6euntJpl831kEmWtbMRsw3EPNxxdO5UvgQ/GrPL0CCD8ZAmovcQUl52ndk2WXeuNgzJY0tKq/JsVMISJrKVOzf5I0Y1FOes9IXJ9ZzFuIgYNwXUbQSyCXNgo5tWqc8WHHt/2aKWGPFhrc64ArIKy9A+UhjU3jb7/MYO3yHpdTBgbNCBhpZTCPwoS9qpL3CtyOTbKQv3h88TElmbdug2YhIlNO+zmx9UuWx9dzhpA+p2Vpa0DeTdXMO6k91nj7YBmlVzJXhmQGHSCZcrhPZA+iuKWNdUt/irM4uZQXjou9CFzpE9YB52SZxKzaCy6WefEor
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf1f78b-1eae-417b-1deb-08dcc6fb8e31
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 00:51:30.4127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y1o9VkyJhlvsWgc1w2xtCI8IKFc9BySWOwY3oocVSCvPT91wRubhurAoAzKSiy0hVqj8u6BtesQYBZe9iNnqwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6706

Tm90IHJlbGF0ZWQgdG8geW91ciBtb2RpZmljYXRpb24sDQoNCkluIGdlbmVyYWwsDQotIFBsZWFz
ZSByZXBvcnQgYSBidWcgd2l0aCBtb3JlIGRldGFpbHMsIHN1Y2ggYXMgaG93IHRvIHJlcHJvZHVj
ZSwgeW91ciBleHBlY3RhdGlvbnMgYW5kIHdoYXQncyB0aGUgaW1wYWN0LCBldGMuLi4NCi0gUGxl
YXNlIGZvbGxvdyB0aGUgcGF0Y2ggc3VibWl0IGluc3RydWN0aW9uWzFdIG9yIGEgUFIgaWYgeW91
IHdhbnQgdG8gc3VibWl0IGEgcGF0Y2ggdG8gdGhlIGNvbW11bml0aWVzLg0KDQpbMV0gaHR0cHM6
Ly9kb2NzLmtlcm5lbC5vcmcvcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMuaHRtbA0KDQoNCk9u
IDI3LzA4LzIwMjQgMTQ6MjAsIOmds+aWh+WuviB3cm90ZToNCj4gDQo+IA0KPiANCj4gDQo+IA0K
PiBJIHRoaW5rIHRoZSBmb2xsb3dpbmcgbW9kaWZpY2F0aW9uIGlzIG1vcmUgY29ycmVjdCwNCj4g
aWYgdGhlcmUgaGF2ZSBzb21ldGhpbmcgaSBkb250IGtub3csIHBscyB0ZWxsIG1lLCB0aHgNCj4g
DQo+IA0KPiANCj4gDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbGlicmRtYWNtL2NtYS5jIGIvbGlicmRt
YWNtL2NtYS5jDQo+IGluZGV4IDdiOTI0YmQwZC4uOWU3MWJhODU4IDEwMDY0NA0KPiAtLS0gYS9s
aWJyZG1hY20vY21hLmMNCj4gKysrIGIvbGlicmRtYWNtL2NtYS5jDQo+IEBAIC0xNjU0LDEwICsx
NjU0LDIwIEBAIGludCByZG1hX2NyZWF0ZV9xcF9leChzdHJ1Y3QgcmRtYV9jbV9pZCAqaWQsDQo+
ICDCoCDCoCDCoCDCoCBpZiAocmV0KQ0KPiAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJu
IHJldDsNCj4gDQo+IA0KPiAtwqAgwqAgwqAgwqBpZiAoIWF0dHItPnNlbmRfY3EpDQo+ICvCoCDC
oCDCoCDCoGlmICghYXR0ci0+c2VuZF9jcSkgew0KPiAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
YXR0ci0+c2VuZF9jcSA9IGlkLT5zZW5kX2NxOw0KPiAtwqAgwqAgwqAgwqBpZiAoIWF0dHItPnJl
Y3ZfY3EpDQo+ICvCoCDCoCDCoCDCoH0gZWxzZSB7DQo+ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGlmICghaWQtPnJlY3ZfY3EpDQo+ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGlkLT5yZWN2X2NxID0gYXR0ci0+cmVjdl9jcTsNCj4gK8KgIMKgIMKgIMKgfQ0KPiArwqAgwqAg
wqAgwqBpZiAoIWF0dHItPnJlY3ZfY3EpIHsNCj4gIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGF0
dHItPnJlY3ZfY3EgPSBpZC0+cmVjdl9jcTsNCj4gK8KgIMKgIMKgIMKgfSBlbHNlIHsNCj4gK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKCFpZC0+cmVjdl9jcSkNCj4gK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaWQtPnJlY3ZfY3EgPSBhdHRyLT5yZWN2X2NxOw0KPiArwqAg
wqAgwqAgwqB9DQo+ICsNCj4gKw0KPiAgwqAgwqAgwqAgwqAgaWYgKGlkLT5zcnEgJiYgIWF0dHIt
PnNycSkNCj4gIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGF0dHItPnNycSA9IGlkLT5zcnE7DQo+
ICDCoCDCoCDCoCDCoCBxcCA9IGlidl9jcmVhdGVfcXBfZXgoaWQtPnZlcmJzLCBhdHRyKTsNCj4g
DQo+IA0KPiANCj4gDQo+IA==

