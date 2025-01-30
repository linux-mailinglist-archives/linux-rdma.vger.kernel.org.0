Return-Path: <linux-rdma+bounces-7337-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F242A22C00
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 11:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1081889E1F
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 10:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC66D1B86DC;
	Thu, 30 Jan 2025 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="fA7rrYuu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333D820318;
	Thu, 30 Jan 2025 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738234399; cv=fail; b=VW3jwDdiUElnLiFniYd9dmkt6XG9kclQhX8IDf5Q8TfqTyqxvYRerZNJm5gJ+Fun+zfZyCqOQCoU+ajn4akhVF9P2lhtS+D558lWTtW1msMhhE4SdmWg3FFLn1RRITYueI5fpY2QouWSwa8SL9nF4k/jpFVNJob0ghZrTDwaNuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738234399; c=relaxed/simple;
	bh=l0WOBjFGLqfbMuQ6imZdOYhL/ymLGusa6CDUfFcnsNY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X/RvfRyLmlH5c/sOL2mOImkgHGq+U4FcPg/nQ0nWu1q+upQXtJUoQxqBXGraBjv/m/P+lBUy89VXuaxpnsZFwkXAa4BObFaklTOVdwp1VSJJfs+Dzdb43VxRPwBAp5+Pi5EBaMzbZtFwGxQpW1f0Nc+kSgiiIkov1sJKEJf/v9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=fA7rrYuu; arc=fail smtp.client-ip=216.71.158.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1738234397; x=1769770397;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l0WOBjFGLqfbMuQ6imZdOYhL/ymLGusa6CDUfFcnsNY=;
  b=fA7rrYuuUvcc8qH163xUbgHkbC0bwW9OyRJv0KAzTDG+g9v1omw1QDf7
   bI4gPnv2OKXX55Npxx2BFTuZOVh529fRPWvHyAVAariO8zJzEHRkxcwfT
   14PS/n0on29hPfgu1Qzj2rcPZEYRh8y0S+59B0t4jNz3PIMTz+M6hsa53
   kdIRBuNYvDwLJSGr2rsdVjPj17N2Tk7lePWZCSuXdtHsG17VmY5CO325m
   lodP1PG1Prc+I/sq/NQ7JE/Y53jNtJsqqN7A/dsCio4+HyiFNCQcNl6ra
   Cb68Bvm0rLyUUcD8Htsc7UqSge0LdldDDr6gNTQCAlaE1KG0xNtQd2Hno
   w==;
X-CSE-ConnectionGUID: GfTjjYjQQleKr1ruWX5uZQ==
X-CSE-MsgGUID: 4FVi4YB6SYSc8JdQQeOwLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="144552260"
X-IronPort-AV: E=Sophos;i="6.13,245,1732546800"; 
   d="scan'208";a="144552260"
Received: from mail-japaneastazlp17011030.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.30])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 19:52:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFcpyv3aep+E7JtUQMH1ZPzUhvHaQNJGFHp45hscok5aagwuwtrUFj8QyLY00RUldtbpYRiuL5RfUZyoinDZlMaIAlIq9aeth43u06FhOl7Y2J5LRwePK6HLduFSoqrF3xCPWiQy8LQSX4ds6+JAB0QyLAiL/B6O3d4sABKx06kCET8pDaZDgAQl4fkXYbfNt3egxLH2npmwj+WPkjUIPav59W5inRc+tujQbU6N0JnNwm0ZkTvG3yENbFNCrquyFwsJb5b2hlSz4h9sptAxpoonliDWb0xMcoZSnKIefgLs5ggEvA+OqBMEPR8LtgmDBf5cLpwsH21V9+Wy4QrN2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0WOBjFGLqfbMuQ6imZdOYhL/ymLGusa6CDUfFcnsNY=;
 b=YoKtRlqE0OER7fpTIEWW0CzUU7fUwsY6Tv8jCqgN8uWgYivfwpx94dYsl8bImWLnzVzSJnl0+TyLgwETWLhWAwC+98/y4ddBS5v8oJ1EDbP9fHu31ELCDNmLwaVu6Q83UnUfOidP6wkecmteYANxqFQ8a9DgV1lGPd2+tQiP10M8X8TeLMsHu2Ypkm+DmAd+u4WAWbATjBJaBFAwza8aD+cfWWrJe5shDrov4gg+PtPZ+aJ8q1JobMkf15p7CIWubCY9a7mMau3b2MrTL7MYOgOQJgU/27Ms9yUMbUxP1jaXq+A7olQlC5vTJgtlHGDwB9HQvMjfzsMaRY1r5HNj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by OS3PR01MB7238.jpnprd01.prod.outlook.com (2603:1096:604:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Thu, 30 Jan
 2025 10:51:58 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff%5]) with mapi id 15.20.8398.017; Thu, 30 Jan 2025
 10:51:58 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Jason Gunthorpe' <jgg@ziepe.ca>, Joe Klein <joe.klein812@gmail.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>, "zyjzyj2000@gmail.com"
	<zyjzyj2000@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rpearsonhpe@gmail.com"
	<rpearsonhpe@gmail.com>, "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: RE: [PATCH for-next v9 0/5] On-Demand Paging on SoftRoCE
Thread-Topic: [PATCH for-next v9 0/5] On-Demand Paging on SoftRoCE
Thread-Index:
 AQHbUsdVttNAApocPUWbNvG68fDe4rLyh0MAgACNdPCAAfaMUIAQMRwAgAArUQCAD20tgIAAdY2AgBoBB3A=
Date: Thu, 30 Jan 2025 10:51:58 +0000
Message-ID:
 <OS3PR01MB98659E07C0DAA1838FFBC70DE5E92@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20241220100936.2193541-1-matsuda-daisuke@fujitsu.com>
 <CAHjRaAeXCC+AAV+Ne0cJMpZJYxbD8ox28kp966wkdVJLJdSC_g@mail.gmail.com>
 <OS3PR01MB98654FDD5E833D1C409B9C2CE5022@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <OS3PR01MB9865F967A8BE67AE332FC926E5032@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <20250103150546.GD26854@ziepe.ca>
 <CAHjRaAfuTDGP9TKqBWVDE32t0JzE3jpL8WPBpO_iMhrgMS6MFQ@mail.gmail.com>
 <CAHjRaAd+x1DapbWu0eMXdFuVru5Jw8jzTHyXo2-+RSZYUK9vgg@mail.gmail.com>
 <20250113201611.GI26854@ziepe.ca>
In-Reply-To: <20250113201611.GI26854@ziepe.ca>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9OWYyODZkZWEtMjAyYS00NmQyLWI4MGUtNGY4ODBmMzNj?=
 =?utf-8?B?ZGQ1O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjUtMDEtMzBUMDk6MjI6MzZaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|OS3PR01MB7238:EE_
x-ms-office365-filtering-correlation-id: 7246d04c-4a3d-4769-0909-08dd411c1e94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cEdpamhmcTQ4cWpNd0lWbnJ1ZWlWVEhEUlBGMEIrdE5ScS9VWDYzd1lQTnN1?=
 =?utf-8?B?WjlIUnpZdjJ2ZEltVk5YYnZPaFNWYm5HSDc2UXdsZFNzNnV0anc1a3JIR2M4?=
 =?utf-8?B?c1BGejY2cXJFaWhpVkhVbVNpUnZPZXVmNWtkWndwNTk4ekpNMk9ZMWhVdkdr?=
 =?utf-8?B?K095UGlLK0JHUXVBR3FHRm02QWhpTFRQWFVUcHJmUlVtYnVNbG1Ha3dvTEJt?=
 =?utf-8?B?b1JsTklmZWZTMXY2MjBJTDZ3cE0zQVZXVGhNbS9MbHlGN1pOYll6RjA5TDZS?=
 =?utf-8?B?bjFYaUhZTGNsUzhveTdaOUhGOEo0MTJkcFNYR2RYcGZ0VXN1RWxCMm0rM285?=
 =?utf-8?B?enVLc0RLWWdlR3dIWXo3R25LS2c5UFMvaE93U25VNlI0SW9xZTFsbXhPMTM2?=
 =?utf-8?B?QUVGYmNTWlFKVzA4UVRkUUM5cURQNFJLWlJod1lqNUgrdEFTd2xVOWhROWx5?=
 =?utf-8?B?Q0thS0paeXRjalNBSFR0b0srcXJ1YU9KYXJyUGRkcWlWeXpiNjBldEljV1Fw?=
 =?utf-8?B?dUR0eTZpaGFvMGxSRW1SNXhvQThjV2QxYkNPSVVTQlNGdGpkeXEwUVRqb2dO?=
 =?utf-8?B?dE0vV1BmUkhscUJNYTFRRUdxV3BSamI1Yk5TOXU2ampockpNaDR3cm1ObGpx?=
 =?utf-8?B?eGJBK3ZTa2xsbUtWV2ZPVzFFQXdaMFJXSFNQTFUrb2pzV0IrUkc0eFIwWjhI?=
 =?utf-8?B?eStFZ09VSnh6OTl2VU82eUZ3cTNjQlpUczlaK2laelJ0Wm5nN3QxWm5UMHQz?=
 =?utf-8?B?K1JVaEJ3dll5UFBZSTIyZWJxL1huMFZ1MC82bGwxS2taUFNQclBOdExDQmZa?=
 =?utf-8?B?WlgrUzIyTG1nLzBHa3J6K1dKeVBQQmxPdmdSa3hVeEQ2eURmUkhCTzd3cVg4?=
 =?utf-8?B?dk5lOTlhODlHS3FjV2k1SEhZNXp1TVhYb3RXV0pRbGg5YVdodXplY1Rhc3pi?=
 =?utf-8?B?cHRkTmM0RlFLVE5VYWNTU2tvWDBicE50dnFBWUhuTzlwUVpqUEtWeG81WE5h?=
 =?utf-8?B?ZTlRY0VwS25pSDZ4NUNwZ2NuMW5wemFIc3JIOUk2K25YRDFzVVNWK1c1Ym1T?=
 =?utf-8?B?MWlST2J0MVpsVmQrN2txSFRLUWZFenlRblFIYUFMSkFWYmpzMDlIckk4eFdv?=
 =?utf-8?B?NUZyZDNpOW5ZOFl4QkJwejhTZ3loK3Y1N0UyZ1pmQlJCQTBZNnAvNGM0NmRL?=
 =?utf-8?B?c1RvUlVxQnAzeXU3MHJPNWlRSzhITXZBaVd6YU9seHlhOFVLeWhkZW1VdUs4?=
 =?utf-8?B?SU0xUzFHeDBqcjZoUW9CMk5mUUVWd2doT05ZalBrUzF3bEdUekFCNlFOaHlt?=
 =?utf-8?B?OVk1SHArKzh6Ykk5TVJFK28ydHBacFNScXM3ZlpkU2pVRVBGMkV0SXNZdkRD?=
 =?utf-8?B?dHA0VXJWeFRxQ0ZaWE53UGxkMjlHVS85QW0rcFN0dHZDRmUrZjZaTmhVUU1y?=
 =?utf-8?B?UmRXY1l5eEprRkM5eVF0S0kwV2VTbUpjb0FxQ0pvZ1NmblRaRGQ2dDhPbE85?=
 =?utf-8?B?c1N1eTErOHlJQzlqbmRPd0pFd3FOV1hseEtmelR3cU05bGlLa213M1ZJMm1H?=
 =?utf-8?B?dllRS2k3QVBtaU9nTmhnZXVodW12SlVnQXBPOHZEczdFZW1FZi9NdC9OYmJ0?=
 =?utf-8?B?azdqdmZSVEp0WjdiL1F0U3FjN0YwY0c5VVVzRUJOdjVpT2YzTDVYak1lZ2VZ?=
 =?utf-8?B?OXlNdXlKcG5WNnZheEhRZlVWMFI2Y2NmUGVlR3NqMFNtTnVOSXVHNzVvMUlK?=
 =?utf-8?B?QTh6MkJwZ0RGYmhlNjlUeVp4L0pFZ3p0R1FQMTVxOVQweVoyRStWRjRZdjBm?=
 =?utf-8?B?VGhBb1MybWl2S1RhVE5TVGR5aWwvMTJKbkppa3h2TWhnQmxzYXJENUNWOUdN?=
 =?utf-8?B?OUt2T3psc0hCU2NIUlVIVFVXMHl2SFBEaWZCdHJ0cHllU0NMWDQ3d3lkMEUy?=
 =?utf-8?B?L0RMQ2ZaeWZTRDF3dEtVODR5MW9TbVNIcTdmWFQ2MlFFdHRHY0svQkVKd2Fw?=
 =?utf-8?B?a3ljVUpzdVBnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ckViMXEzS084RDBNbFJhdVlPQUZxSGw2NVdxSHZNd2tUSWtYM3haMzE0VUFO?=
 =?utf-8?B?MmY0WXUzbUdVbjBJOW1KaTVzSFltcEFMc0ZlUVVWSm1UVE0xSGV0RS90SjRu?=
 =?utf-8?B?TDU0clpnYUd4VnRMaCtOTjZxNHNNaWtaK0dKQzRTbXhYbkVEM3JHaGsyNjA1?=
 =?utf-8?B?RS9yUVBFQ1BoQi9nemk0SlZaL2kxZ0NhNnhPT1o0cDZ0dkIvbFhUaEFBVDR0?=
 =?utf-8?B?ME1reEN1ZHNwc1pyL2FqM2ZBeVJnd2RMT2xqajlXM09KeWtxMXk5WG1wQ1gx?=
 =?utf-8?B?bmxxNFRRZ056TS9FVlcyYmJNZnNqKzJDUzI4eTFVRnhTNGFJMUloUGF4T3NX?=
 =?utf-8?B?cUpnZzJMU092U2RXZG9LMUhmNlQ4T0RHaFdjT0oxVGcrVjIyWjZ6YVhvRFli?=
 =?utf-8?B?Wmo3UEk5Kzd1MGFFNEdiR2g1MjIzUE9xVGN4QVhuRXRSV3JGOTk1VW9DSE5x?=
 =?utf-8?B?MmdWSlFsOERLR1JxdXZMQXZqVHhUckdFTjB2Mnd0Q1pLVjV6aGZqd2lOSkMx?=
 =?utf-8?B?TlVobUxoK2FRYzhlaWxzKy8vNzFSVk95TXcwaVJ3cElnd09CZ2pxckltTzIv?=
 =?utf-8?B?Z0oyczN4ek1lWVRQNzJsMVZCaVdOZFN3UmZjeUFoQmpFZTJtRjFuc21keG81?=
 =?utf-8?B?OHMvOExyN3MvSzdCV3NIMmkxTFh2OVo3b29nTjRqK29KdzdWWEhMZFYvejdr?=
 =?utf-8?B?YWNNSjlERjRrUzM4MXRBQlJhaEpuL0t2L3hWS294czYwcUdpdGtLVmVZNjdq?=
 =?utf-8?B?dmpCeGV0aUZWM1R2TnlRYTh5c0hOVDFOZ3JsZjA0R21pTnVGVXh6Q3U3UXB6?=
 =?utf-8?B?RStMbGFYSFVJYUJFZDY3OWZjTXg3Qkp3UXNWUXdybFZXZ0dxYnByWkhlSFNW?=
 =?utf-8?B?SEZxb1VBM05reUhXZ2RxcWl1TEZ3V3pvaTlDUVlKSWdtR2dOMFNXY0FrMmVi?=
 =?utf-8?B?Q0hvOHdaQ2YyaGpZNHNBdit0clFoRGtMQXdnQXVTSVhQOUNTa1hublIzMmJl?=
 =?utf-8?B?SnZCWkJQS3o1L0FoRVY0RWpxNGVIWUxKQ3c0UHZhWExBVWdFc2xCdEgwWHc2?=
 =?utf-8?B?dW9XUGpzSXZPK3BMYmhDV0lMV1lJUkl6Mitua3V3ZHFRRHNjeVlxZXNzWHl4?=
 =?utf-8?B?ZnFJQk1vL0VuanRJRlpSVVlVbTBBTWhFaXZ6ek1kaytuc21qc1RjYmxTNmVW?=
 =?utf-8?B?OFNNMEdVTFZYRCs1d3BpY1N3aFEvbUNCRzVFWlE5ZnF6VHZJRlgvQjRzejB5?=
 =?utf-8?B?RGphWkNoZWoyMi96eHlUbWpnWXJJdEtKWFNFNDl1L0pIaFhvbVdyc1FsdCtF?=
 =?utf-8?B?WDNkeWRBUGFJNyt6NFIvVVB3eko3b0hqTnlqM25KQzFuRFJ3Y1laRi85Mk5Y?=
 =?utf-8?B?bkJCK1RZR1JmaERPZVpwRk5kWUovUmxTSGdxazJKQmovWTg2NEExTm9aL1p2?=
 =?utf-8?B?SHJPQVJOVXlUS3hOWmx5aHZvU3RIckZZV09CbjJETHJOWE45WHMzZ0E2N1hN?=
 =?utf-8?B?RnVMazFnRDVwd29lNE41bGp0YThOS21mV2F6M0hPb3hONmc5T3RyOHN0RGV3?=
 =?utf-8?B?TTJORG5MaElkLzhFRzdIOTJBMU9hMlJCRVJaM3BSSExNbVpnUFlrR2NObFFz?=
 =?utf-8?B?V3ZGSWVBS2JHZzFqbjg4QmNBQk9MUkUzb3NuaVRPT1lNaXhnWit1citFWGdB?=
 =?utf-8?B?ZDVWcjY4MWtDaEJwNGw3SUE2di9Kempma1QrQS90QzJOdTFLUzIxaUx2ak5t?=
 =?utf-8?B?dE14SDFBRTgwTTl5SVhhQUVmT0NYRS9VMjl1blpSVWp5OGkxbm41VlM2WHIv?=
 =?utf-8?B?bGlCdUFDUlh3YU1ISk44Ly8rRWJESW9jejJtTXFnc3AwNnF5MXl0cHI2M0Yz?=
 =?utf-8?B?blNHVFA4c3U5RE9lTTlpT0Rjb2l4Ky9sQWMxRHNLUXlBZURoSGRvazBVaXlT?=
 =?utf-8?B?ei9pdjRhSEd6aDZ1MEgxR0tWNko0NE1DeHJOZVA3YUtBeFFxSzQ0dzNUOEFV?=
 =?utf-8?B?WUh5ZkpvQUoybzl1RlZ4RU5OcjZXNERUNTkweTlhT0hqQVdvOGhLOWlvcGZp?=
 =?utf-8?B?eW81bFExR3prd2RremJvR01QN2JIbXBMaXp0YXNCSTNUWFRLQjZ3SHZVYXVS?=
 =?utf-8?B?cmtVcjlsWk1pMWpqc0JKb2NnSmg2bE9zVzJhKzNOdytpQ3JZMHBDRFk3OFdV?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hfTMd5DyQvmoyLO/l2ncsh5Pau7ypyQ2qA1AwY+pwIGiJcD+LHF0BZ8ElB3MjjsDz64F8GWMTpK1B2qZmI+skPo6cJLoLGZ/zblxjOT9GG7UgjrZXtU5MiHQklMSusHVzEgKLndo5dRQq2hli3PU4DIACtlzY7CAq7ratBwI7GzHVkALSYjTyLu+qewrCFFRWmkYT52wq0nM7hpiaHjOhq6Qk6GED0lJVmEPbedKLsFguOIR+uWwlUNmeLPEJM1Aev6EkKovYt5FkS3ZJT5rVvNNYJggFgRzL9A1nuHVWC0kIg4N2Ho3wXt7HteByjwqfJogyCcOIacDp46/vR94RgCFGnERBh7DlwwbALxDKJ1B8mfok+r89bTyoi72kMBHksPUmZsySFwPvnefj7DMIACWxI5daZVjd04F0x27aA0FhaZ47KhZRM3lBnGXOD8lH8ZW55NHULRFmAXFm/V3iJIAYTRo0QI6Lz7biXZX516WS6iK4P4HcWVDrFfcdZFzLMP7TNN2rR9wGv9/7NtJnLu6GGurpqHtgWAiP8nVemJeLZbKQBpDnjkQ1i86mjTOeAPvp0Q0Ms+GqpbqxVsToj1Y5fqJjXBZAeohN7Soqkq4t+2bIpVjDZl5oNhsxkjf
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7246d04c-4a3d-4769-0909-08dd411c1e94
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 10:51:58.4074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5kYyybSXgMN7A3ygmphTHkd/gOFgRAzVedBUasHnUzEqluqBUy4/4FKekmAJvOjSXtASRAzXPATZRF6N4tzxoeUfN4o39PVmK7GyaDVpjzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7238

T24gVHVlLCBKYW4gMTQsIDIwMjUgNToxNiBBTSBKYXNvbiBHdW50aG9ycGU6DQo+IE9uIE1vbiwg
SmFuIDEzLCAyMDI1IGF0IDAyOjE1OjI3UE0gKzAxMDAsIEpvZSBLbGVpbiB3cm90ZToNCj4gDQo+
ID4gPiA+ID4gUG9zc2libHksIHRoZXJlIHdhcyBhIHJlZ3Jlc3Npb24gaW4gbGliaWJ2ZXJicyBi
ZXR3ZWVuIHYzOS4wLTEgYW5kIHY1MC4wLTJidWlsZDIuDQo+ID4gPiA+ID4gV2UgbmVlZCB0byB0
YWtlIGEgY2xvc2VyIGxvb2sgdG8gcmVzb2x2ZSB0aGUgbWFsZnVuY3Rpb24gb2YgcnhlIG9uIFVi
dW50dSAyNC4wNC4NCj4gPiA+ID4NCj4gPiA+ID4gVGhhdCdzIGRpc3RyZXNzaW5nLg0KDQpJIGFt
IGdvaW5nIHRvIHN0YXJ0IGJpc2VjdGluZyB0aGUgcm9vdCBjYXVzZSB0byBmaXggaXQuDQpJdCBt
YXkgdGFrZSBhIHdoaWxlLCBzbyBwbGVhc2Ugc3RheSBwYXRpZW50Lg0KDQo+ID4gPiA+DQo+ID4g
PiA+ID4gSW4gY29uY2x1c2lvbiwgSSBiZWxpZXZlIHRoZXJlIGlzIG5vdGhpbmcgaW4gbXkgT0RQ
IHBhdGNoZXMgdGhhdCBjb3VsZCBjYXVzZQ0KPiA+ID4gPiA+IHRoZSByeGUgZHJpdmVyIHRvIGZh
aWwuIEkgd291bGQgYXBwcmVjaWF0ZSBhbnkgZmVlZGJhY2sgb24gcG90ZW50aWFsIGltcHJvdmVt
ZW50cy4NCj4gPiA+ID4NCj4gPiA+ID4gV2hhdCBhbSBJIHN1cHBvc2VkIHRvIGRvIHdpdGggdGhp
cyB0aG91Z2g/DQo+ID4gPiA+DQo+ID4gPiA+IEpvZSwgY2FuIHlvdSBwbGVhc2UgYW5zd2VyIERh
aXN1a2UncyBxdWVzdGlvbnMgb24gd2hhdCBwcm9ibGVtcyB5b3UNCj4gPiA+ID4gb2JzZXJ2ZWQg
YW5kIGlmIHlvdSBvYnNlcnZlIHRoZW0gd2l0aG91dCB0aGUgT0RQIHBhdGNoZXM/DQo+ID4gPg0K
PiA+ID4gV2lsbCBtYWtlIHRlc3RzIGFuZCBsZXQgeW91IGtub3cgdGhlIHJlc3VsdCB2ZXJ5IHNv
b24uDQo+ID4NCj4gPiBOZWVkIHRpbWUgdG8gY29tcGxldGUgdGhlIHRlc3Qgc2NlbmFyaW8gY29u
ZmlndXJhdGlvbnMuDQo+ID4NCj4gPiBXZSBtYWRlIHRlc3RzIGFnYWluLiBTb21lIG1lbW9yeSBl
cnJvcnMgYXJlIGZyb20gUlhFIE9EUC4NCj4gPiBUaGUgd2hvbGUgdGVzdHMgY2FuIG5vdCBiZSBj
b21wbGV0ZSB3aXRoIHRoaXMgcGF0Y2ggc2V0Lg0KPiA+IFdpdGhvdXQgdGhpcyBwYXRjaCBzZXQs
IGFsbCB0aGUgdGVzdHMgY2FuIHBhc3MuDQo+IA0KPiBDYW4geW91IHNoYXJlIHlvdXIgbG9ncyBz
byB0aGF0IERhaXN1a2UgY2FuIHJlc29sdmUgd2hhdGV2ZXIgdGhlDQo+IHByb2JsZW0gaXM/DQoN
ClNpbmNlIEpvZSBkb2VzIG5vdCBwcm92aWRlIGFueSBzcGVjaWZpYyBpbmZvcm1hdGlvbiwgaXQg
d291bGQgYmUgbmljZQ0KaWYgc29tZW9uZSBmYW1pbGlhciB3aXRoIHJ4ZSBsaWtlIFpodSBZYW5q
dW4sIExpIFpoaWppYW4gb3IgQm9iIFBlYXJzb24NCmNvdWxkIGZpbmQgdGhlIHRpbWUgdG8gdGVz
dCBhbmQgcmV2aWV3IHRoZSBwYXRjaC4NCkNmLiBodHRwczovL2dpdGh1Yi5jb20vZGRtYXRzdS9s
aW51eC90cmVlL29kcF92OQ0KDQpIb3dldmVyLCB0byBiZSBob25lc3QsIEkgZG8gbm90IHRoaW5r
IEpvZSdzIHJlcG9ydCBpcyB2YWxpZC4gSXQgaXMgbm90IG5vcm1hbCB0bw0KY29tcGxhaW4gb3Ro
ZXIncyBwYXRjaGVzIHdpdGhvdXQgcHJvdmlkaW5nIGFueSBkZXRhaWxzLiBJdCBtYWtlcyBkaWZm
aWN1bHQgdG8gDQphc3Nlc3MgdGhlIHZhbGlkaXR5IG9mIHRoZSBjbGFpbSwgYW5kIGJsb2NrcyBh
bnkgZnVydGhlciBkaXNjdXNzaW9ucyBmb3JldmVyLg0KDQpUaGUgdGVzdGNhc2VzIGluIGxpYmli
dmVyYnMgcGFzcyBhcyBJIGF0dGFjaGVkIHRoZSBsb2cuIE90aGVyIHRoYW4gdGhhdCwgSSB2ZXJp
ZmllZA0KbXkgcGF0Y2hlcyB3b3JrIHdpdGggcGVyZnRlc3QgKHdpdGggT0RQIGVuYWJsZWQvZGlz
YWJsZWQpLiBJIGJlbGlldmUgSSBkaWQgdGhlDQp0ZXN0IHByb3Blcmx5IGFuZCB0aGUgcGF0Y2hl
cyBhcmUgcmVhZHkgdG8gYmUgbWVyZ2VkLg0KDQpEYWlzdWtlDQoNCj4gDQo+IEphc29uDQoNCg==

