Return-Path: <linux-rdma+bounces-5349-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6732D997F60
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 10:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2E41C21887
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 08:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56871E7C02;
	Thu, 10 Oct 2024 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="GA3d1eLl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676611A0706;
	Thu, 10 Oct 2024 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728545106; cv=fail; b=g0uh/9ClXSAwn9opLikGxBFYSqap4a/w1agI90kbWIUND5/pLcpJoKPL/nXd2itWDxOv7FnF+cjXzhhs7kZzUzc89b8iJofBRGJeOp9p2vm1mBi04gAxNSZQyXzvfxj7ELDtusttdZq2f6+GrL2IHUDU1J3jbNJLk/Qb3OExImw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728545106; c=relaxed/simple;
	bh=VTyQoBxOyxbyXUc66mBRoogXUCnioDdpMZF+z7VFECQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iu1Sp4hPD1e5T0Hgnc8gE31nbUKj5P7O26JV5IPu3oCh9Job/DAUlSwMR7rS7SlLCDAQpzvkQ+acfB4lyGY27Yrq60Oy3oKawpRy2hKaJndzJXy5hWdXU4Nzx1CiHabdYqs+OzDc/D4bfojR5nf3yWnI4RwiH45FKAIoxaA5Iws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=GA3d1eLl; arc=fail smtp.client-ip=216.71.158.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1728545104; x=1760081104;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VTyQoBxOyxbyXUc66mBRoogXUCnioDdpMZF+z7VFECQ=;
  b=GA3d1eLlXeaQM+AFolFgR6dp5Vff2UHDv8RZDmIkXp649KXBGzlRXFKG
   zaeHJwJDYNr60Vnukl5vOC025dnMNUJWaSgTNlc7+Yob7PPfOvGcBxKxe
   g3GmUUV9MT4BSveSVEBFHMGCE7+0VRerAHRnMoqPqhsAoXrTAPEEYRvdZ
   tUugD7FzIhCsxRY9BH2J1/MDS9hLqgsTiAeB8h5/m9+ked674WBvTWM58
   5Ooa8+xAYbrGk8Ei/G18CKHEW93M9UQbpZuot4ib5jHvVHv6+T8zPUfdd
   yxF2QQh0h9V2w4Qfh5R/WafvHrN2MavdeG4KHep1H7hwX+jwQX2X+1W+T
   w==;
X-CSE-ConnectionGUID: hUrJuNlQRjG4xYaoPrK+Rw==
X-CSE-MsgGUID: LafqcuxhSjafvlleHV+flg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="138756484"
X-IronPort-AV: E=Sophos;i="6.11,192,1725289200"; 
   d="scan'208";a="138756484"
Received: from mail-japaneastazlp17011028.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.28])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 16:24:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iD0WSAd0RMFdsGZogOR/GbY1wBB8S4V/V/yWnccSlrA2g492I0jx8HNbGlOXsWsJTGDYTWF7QsOegfSzV/lLBL39iWqqytyQueibCd+QOguCUVmncxTGehr53WLcKg9k88K2Th+ZoQ/gYjsx+G8AAf7oueM+Og3DeX86RTX2zn23rR/zXLCp6pazzt/3WSyza4nIJgrh8s92qFbEYgnMaEokmUoezpC5NdFnlYaHA6c/jpSOlAbOdjCRHkHTN3J8hm6hp5H5PkrcLqoNTk4ba3CH69WUbkIwMU8GxMyhn06sDNzhsgpjAYFzFhaIXcAQaSqOOQZB2xgakoi8YwrIXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTyQoBxOyxbyXUc66mBRoogXUCnioDdpMZF+z7VFECQ=;
 b=uAjsTcVmzVvaC2TO5F2aykaePrhal2iTVyHYS5smyjZ/DXCX0nmgC0IvVJr/86UFsvSd6yvgffs1ksJtFRXAIhJ6atAsSDuvxWkgB2y9cH7Hbbte86hlZXSt7QKmBmtBIRrML/SJ/NqbK9FuVj1h9BoWtGl4gFDRROnj2EM7tIYB2fQbO9T4JL7R0U+sGHV/PNI8tSzoVxFgGMNABOyrodt5VM7iKRCC0acjORl+gJGwftke7wXtZWYcEeNj8Fr2VnVdSi5e3cirb+dPDsQ7CDoWaPmJ4Yk41Vw+wYvJTe6k0bZ7c/R4g7VOmtRj4+6v3FN6+bNx8KYLbARKt1GtRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by OS3PR01MB6610.jpnprd01.prod.outlook.com (2603:1096:604:10a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Thu, 10 Oct
 2024 07:24:50 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff%3]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 07:24:50 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Zhu Yanjun' <mounter625@163.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "leon@kernel.org" <leon@kernel.org>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>, "Zhijian Li (Fujitsu)"
	<lizhijian@fujitsu.com>
Subject: RE: [PATCH for-next v8 1/6] RDMA/rxe: Make MR functions accessible
 from other rxe source code
Thread-Topic: [PATCH for-next v8 1/6] RDMA/rxe: Make MR functions accessible
 from other rxe source code
Thread-Index: AQHbGe7dxzAlCRK8qkOdYdUUXbPCsLJ+duEAgAEWJAA=
Date: Thu, 10 Oct 2024 07:24:50 +0000
Message-ID:
 <OS3PR01MB986550BAFCFA30D409F5A089E5782@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
 <20241009015903.801987-2-matsuda-daisuke@fujitsu.com>
 <67b556bc-2d48-4e7b-a00a-6b38512c8e8f@163.com>
In-Reply-To: <67b556bc-2d48-4e7b-a00a-6b38512c8e8f@163.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9ZGE4MmI0ODktNGE0OS00NmE0LTliZjYtNDZiOTlkOTQ2?=
 =?utf-8?B?YmQ1O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjQtMTAtMTBUMDY6NDg6NDJaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|OS3PR01MB6610:EE_
x-ms-office365-filtering-correlation-id: 4444645e-176c-48a3-eebf-08dce8fca082
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yk9yNU8vUXFIVUxqL0NobWlSVTlqZE5MK2x6K3ArWG1hd0lKUmdrUTk3ZmJs?=
 =?utf-8?B?dytnZ3JtcVc4b2hOcjc3TkI4aXMreWlDb3I3S0N5amtRVG83N3YwVGR6WjFM?=
 =?utf-8?B?dURZc0ZrSXFvWDY2MjNLNmRXekFUVTU0WUIwakdXRC9TK0pSSU1mMUdpUFp4?=
 =?utf-8?B?QkZudmVDZGhwa05UUDhtS3IvNE9sN3Q0OFRjZjFCMURrLytpWlhUQTM0V01p?=
 =?utf-8?B?d292WXByNUpXanV5ZG9oTVdHM1RNRzdvNzFqYUo5c2gwUVRvTXNhUlg1bTN2?=
 =?utf-8?B?S0xUMlpsR3FMMFNTZmZYQS9CR0s1RlNFbHYzVllGQ3dESkRIblZLdm5vUTZJ?=
 =?utf-8?B?SVM4cThBOTc3YkVnc2Q3OFh2cDBTak5uMHUvTTF3WWVzdk1tTk8xM1VtaDN5?=
 =?utf-8?B?R0cvZmFSU25LeTNpVWFvQ3NBdmtVcmhKUDVmYzc1aFJoNTM5TytKTEh2NkEz?=
 =?utf-8?B?VzREb1JaSTNTTDR3OEp6WWt0Y0d5bjg5bXlkekxVNnk2ams1S0w1am12dGFD?=
 =?utf-8?B?Ni9MRGJ1OTdnRlRVU2wxWHRGME1pd0N4d3YxVis0R3hBeFY0R3Q1S3drTndz?=
 =?utf-8?B?UHJVbUNCemZRTWZuMzhsSkIydm16eStoWFIyQnhsL1c1YUF2SU00UFl4RUpa?=
 =?utf-8?B?a3dIdzc3V3JvOGJoSDlDZjB5Rlc3UXl2aVlJZzFGU2M3TnFqeVdVUnBuYkZT?=
 =?utf-8?B?NWxlQ0U2ZDIvV2pQM2haZ2dLcktQTFh0Q2JDNURPczloQXlJbS96YmIrRDVl?=
 =?utf-8?B?T3d3TGxURXViaUpvUzM5Z01XY2h1OVM2bHQyQ2ViZE55Q0l0VXhQYUVnbXUr?=
 =?utf-8?B?ckhwTFY5RFFsMzFjSit0cllYanVrd25Bd1E2K3FKcE1EZUVYS1BDS2FwYXFm?=
 =?utf-8?B?azgxNnFnZUswcTBpZTloMjRwOU1TR3ZQWHNJOXlXQ2QwYTVVeU1Ib1ovbEdy?=
 =?utf-8?B?eTVMREdwT29oVlFHazJ0Vjd5N0RPdTJsK3JsdHZoZTgxS05MRmhJVEkrZTBv?=
 =?utf-8?B?cHhOdHdQSUUzNGM3bW0wTGxsbE5SZ3J5YWxtb1dDSkZ3WU0yRkdZYk1TVlJV?=
 =?utf-8?B?WU1jL1QwMks2UDUxdG5GM2VUdWVkREVrcUVmT25qdWJXVEIwZC9WakNNODNZ?=
 =?utf-8?B?SzNsTWp5Q3FLOHdwN1ZRTHhOSEJUN1laRUNUUGp6Vjd3NmZ2elZOOFlQL3Uw?=
 =?utf-8?B?VzA4SWZpcVFJZUlaeEZGaVFPZkE4ei9QOHhOZGdMaHR0bXlKaENSY3pQdVRO?=
 =?utf-8?B?RGhDcTQxQmVyUmUybGI0TEpUYXVlWklPQkxuc2pTUTNPenZRdHdpYzdzUzMr?=
 =?utf-8?B?RXJCSUxrVm8yOXppWWJ6bXdheEJYZVFBS0ZyWnRNbkMzZjJFR3dVT3J3UnlT?=
 =?utf-8?B?bXV6RjhSYXd6R3RONHJmMHZ0WlpyZE9nWWNSeFhGUXRqMklJb0k4RlFPeDky?=
 =?utf-8?B?U3QyMnU1eGJ5WmVHTDN6My9EUGNQQ2ppSGMvQUR4NjhOT1FPNVBCeGlEZVpy?=
 =?utf-8?B?S0FFN1RBTjFJM3Z3OW9GRmRTRHpqU3laU0UxM0licDZMdDdsZkM1R0V0QTlo?=
 =?utf-8?B?cDBZZndlRzM5dkxheWt3bk5SMEZ2Q0Q2dkNqNy9kRzFDSmpPazdRVloyZE5y?=
 =?utf-8?B?MTlMaWplWi90cnhnT1V1eVhia0M2VmJIbjVSczI0V3B5Z285U2ZjaFB2T25T?=
 =?utf-8?B?N0pVSUgvT2djQXZKZ2Q3Y2VFbmVYUXRwZjNJL05yZ0hjTHkyRHBhRHg3cG5q?=
 =?utf-8?B?cWYvckl3SXVtYmVidG5NdXdTRjYxK2lyU1MzT09IL3EvWVpTK3NzNUNPY1or?=
 =?utf-8?Q?E+fJ01a89ZbR2kIWuP1CxRzIYksYZVjkDH0R4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGJMT3JvZ3dDTDhzUzgrZlg1MHRNajRDVFdEWjhpNWtWelJFNTIvaVcvOEF5?=
 =?utf-8?B?ZFZWSU02RHk5ZWQwWlZsMTVKZWNKTnROZ21Jek5hTzhlaG5kaWxVaE51S3Rr?=
 =?utf-8?B?dDA4b1laT2JBSUZob1pxMzZ6NWRKd0RGdnd6d2UwS1BOVHV3WWg0cWZtK1Vm?=
 =?utf-8?B?VUdWZE9MRzlEbjFmZkJiT3pDNENiZXlmZ0g4dmlNTGxEOE40SEhCekQrZURT?=
 =?utf-8?B?UDNmYlBXN2tDUENlcHlRTytXTnE2REdMS00zSEpURjBZT2JXKzJMaTkvdlJF?=
 =?utf-8?B?QWxWdXphZ1RUQnNBOEt3Q1BrdFVxZy91dURCdnA5V0RPck4zbW5FcHFGS1Rn?=
 =?utf-8?B?SHo1eTFDbDE2REYvK2huRVNKek5qRUxsNUxiSTVCNjdyWHg0d05teEtPU2ZF?=
 =?utf-8?B?eGN3ZzQzc2pJOTVqTmxlZVdVT09ITWtwNU10cmcrUDVnWUo2TkJvRWVvMHBl?=
 =?utf-8?B?YVA0ejFWUC9wczVKcklicDg1M2pkci93V0NWeVhsREl4MTZxMEY3Z2lXczk4?=
 =?utf-8?B?NUlVV3hyMUQ2bllnTWdJSC9FN2x4VkVmSkt0MklIK3V2SGUwWkhRTEhTc3V3?=
 =?utf-8?B?SkdxMFJMQXBMTUJJRWE2RkdHS2ZnaTdjTFBCZXBLTUx5dk9sUE5lNmRwRlJl?=
 =?utf-8?B?NEY3ZFVlVkpZL3NPN2RqSUp4TXJwQ0VvL3lneUhqVVJTNktHdVhSMWFwK0o2?=
 =?utf-8?B?NTNiNVkvTDFHK1VGSDY4cFFMdS9MVXoyMkp0aG1HcEo0WHJFQldPeTArSmxU?=
 =?utf-8?B?Ykh5NHVPSmZSeGVpUzd3S2tBUEE3c0ViSGc5NTZIaDk3RzdxYnB3WE80S2xG?=
 =?utf-8?B?dVlTRW1EaTlOQ3VZdUZXdkpkL2NTYnNjZzFxVmVRbXUxYTB3bytGYzgvUDhv?=
 =?utf-8?B?OGdybU53ZThQcGsrSlNkUFB1dmp2bXpoT0RZN0prR1dRalRwZ1BNL2hGMFE2?=
 =?utf-8?B?TTRyY3U2TGFsOGtMd1pVTG9jeXQ1VnRMWlV1YWtOV0VBdkhlR3ZJTm5Rek1K?=
 =?utf-8?B?YjBHNjMrOHk3LzBxSDlGUzRCRXlzLy9XVVRZVmFySW5qRVJBbDFPUG1Mb3ds?=
 =?utf-8?B?NUp6MkhVSGEzYVVVZkpFTXFoZERTZWdqOFAyRnJpSEY1M0Vtb0ZKMEFWMjk4?=
 =?utf-8?B?cFpqUHNHaVJiMzFveVBqMzlTdFJPYlRKVTYyb2ltT3NYQ0tzYkRjc0svYUJl?=
 =?utf-8?B?b2UyeHk5VUVBTnovRWxUZlNBNGRXVmJ1UG1NYkpYSGsyNy9tS01xN3FEUDFR?=
 =?utf-8?B?ZlNpZEI3Sm5iNUQxdGZCeDJiaTlSaWFIbmU1bnhsVlRTcTVlWGMxRVZ0dVRu?=
 =?utf-8?B?aHVPdnR4eU1KSFYrT2lYcUhTejhSZ2VnQVNjT1YvRVhjZDYzOUpXZW16dm5S?=
 =?utf-8?B?RXpldW5KNVhJUS9HZmd3R1Rrc3I3SkhLenNZWTJjNXp3dU81cW1HdE1rcU41?=
 =?utf-8?B?R1FYVjRIVCtHdWZKNzJXVE9UWE5oK2ttY29KZDZpb0llRHQ2ZTQrSzlPN0F5?=
 =?utf-8?B?Mm1hL2t3dTVOam10MEp5QURZVGI4eE9Idmg0YWorUk9ZV2gvVHA4WG1vR3lM?=
 =?utf-8?B?bHFtT01nMU5vc0RnK2VubExFOThsc3pTbUlTVEdQcnRodkFOTkdzQkI0WXhN?=
 =?utf-8?B?eXR6UVl6eVB3aDRWM0U0eUZ3blc5eC8zbG50UWx3b2VPdXU1MnBCZmVDU1Zy?=
 =?utf-8?B?Y211YVFvNUpCRkF2cFRpYlFjK3lQSUVZQURCWURrTHdIeVMxR0RtNkZ6a2NK?=
 =?utf-8?B?MGQ4NXM3ZDFMVUFkREZGeWYxWWtRRFIvTGhBblBsUFArZHo5K29Vdmd6MHZk?=
 =?utf-8?B?aXRFVmo0UGtGS2JTZ2pIU3J1ZitodlJLc3IraDZlMHJhV2VUMmRrLytrMm43?=
 =?utf-8?B?QzFNVjBFb2tDZFhrd3BFenBLTkxhYlk1N3lrRjV2djRKbC94OStESjZsZitV?=
 =?utf-8?B?L0JXa3ZjOTI3RW8xTDlVaTRvOFJZaGxNcXJkc1Y5T0pvTEY4bEcraC9KZytO?=
 =?utf-8?B?dEtLaTAvZXBrR2lES0s1ZnpzUVhKdWkxb0xKWXFkZ29hRGRvY3dWWUgwK1pX?=
 =?utf-8?B?M1BNMU03TXhPU3Q3ZE5DT2oxMzJzWGlkVC9aT1UydzRwY3VKelZiQzZLemNT?=
 =?utf-8?B?SldlajRpNVZLYSsxSVV5eWkyVDZmbEVkamtrVU5WZDdvQW1pSjkrbE5UUEFP?=
 =?utf-8?B?SFE9PQ==?=
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
	x28850J4Nx/k59yoH6maM2xPzixz2EnRY1KzE7bYjMvAfUpK/bWzmhNeN28yqFVFBzvsOVOcuEKjs0QDrOGL/ACzJdGyEQtO1iDnUODhjlR8VB22A4idnHFrhvr0K0pLVE0ozJl7+hucL31sEuvfzoAZdSGiimU/TqyW7/rFPizebaGk84VL3xsP1Q8zkKYeDLuDAb4jnlMv63KMyVHL0MzGJGnYiAV9Wqbareoi7kAqMmCmYKpyS2Mtz5rB/S0XOPd/E2QA736Zpt2j3w8rOJyUltPcLBo97ioATqgXrrS8DkxUil4bDQPiUyzQSSBp+Fz1ZM3zIV2zmxiftkRm6K+AGJduz9gM55cWBFTIGPpMnAtfLtpLQJ2gJWK5RciaS4vSYt/ibZyqmqSeCNuLooqOkfZatir6zTCQsTY8CRr1oMF4kJTUk+fnsSLysb9ayJGtgbLhibOUBBSQdLfGQh4SdHzLyb8Jbvtj3ko4B21g+2kHsIOXwmEdFvd+f7DG6HuIkMrdTkvgWM1RDJaXr4y2bLsL12oO6iQkHsU0d3hy6okVl710ausccQ1ch5fANDSWAkIxNxPUEh0GQq2Daa7lVcLqik+pGORs3fZJKkHTEHf63cYhrkaoT7TtLNru
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4444645e-176c-48a3-eebf-08dce8fca082
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 07:24:50.2059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9FHPj2ep8eAUZlmVTgop/ulbqvSadybCQVrLoMDt6gnyVaezPgy+dhrnrkOfJDQDTsnHtm9loQS/Zwb3tl1GplaDAYcyiMOw7yB9PrBfn3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6610

T24gV2VkLCBPY3QgOSwgMjAyNCAxMToxMyBQTSBaaHUgWWFuanVuIHdyb3RlOg0KPiANCj4gDQo+
IOWcqCAyMDI0LzEwLzkgOTo1OCwgRGFpc3VrZSBNYXRzdWRhIOWGmemBkzoNCj4gPiBTb21lIGZ1
bmN0aW9ucyBpbiByeGVfbXIuYyBhcmUgZ29pbmcgdG8gYmUgdXNlZCBpbiByeGVfb2RwLmMsIHdo
aWNoIGlzIHRvDQo+ID4gYmUgY3JlYXRlZCBpbiB0aGUgc3Vic2VxdWVudCBwYXRjaC4gTGlzdCB0
aGUgZGVjbGFyYXRpb25zIG9mIHRoZSBmdW5jdGlvbnMNCj4gPiBpbiByeGVfbG9jLmguDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBEYWlzdWtlIE1hdHN1ZGEgPG1hdHN1ZGEtZGFpc3VrZUBmdWpp
dHN1LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2xv
Yy5oIHwgIDggKysrKysrKysNCj4gPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21y
LmMgIHwgMTEgKysrLS0tLS0tLS0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9u
cygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvcnhlL3J4ZV9sb2MuaCBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2xv
Yy5oDQo+ID4gaW5kZXggZGVkNDYxMTkxNTFiLi44NjZjMzY1MzNiNTMgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbG9jLmgNCj4gPiArKysgYi9kcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV9sb2MuaA0KPiA+IEBAIC01OCw2ICs1OCw3IEBAIGludCBy
eGVfbW1hcChzdHJ1Y3QgaWJfdWNvbnRleHQgKmNvbnRleHQsIHN0cnVjdCB2bV9hcmVhX3N0cnVj
dCAqdm1hKTsNCj4gPg0KPiA+ICAgLyogcnhlX21yLmMgKi8NCj4gPiAgIHU4IHJ4ZV9nZXRfbmV4
dF9rZXkodTMyIGxhc3Rfa2V5KTsNCj4gPiArdm9pZCByeGVfbXJfaW5pdChpbnQgYWNjZXNzLCBz
dHJ1Y3QgcnhlX21yICptcik7DQo+ID4gICB2b2lkIHJ4ZV9tcl9pbml0X2RtYShpbnQgYWNjZXNz
LCBzdHJ1Y3QgcnhlX21yICptcik7DQo+ID4gICBpbnQgcnhlX21yX2luaXRfdXNlcihzdHJ1Y3Qg
cnhlX2RldiAqcnhlLCB1NjQgc3RhcnQsIHU2NCBsZW5ndGgsDQo+ID4gICAJCSAgICAgaW50IGFj
Y2Vzcywgc3RydWN0IHJ4ZV9tciAqbXIpOw0KPiA+IEBAIC02OSw2ICs3MCw4IEBAIGludCBjb3B5
X2RhdGEoc3RydWN0IHJ4ZV9wZCAqcGQsIGludCBhY2Nlc3MsIHN0cnVjdCByeGVfZG1hX2luZm8g
KmRtYSwNCj4gPiAgIAkgICAgICB2b2lkICphZGRyLCBpbnQgbGVuZ3RoLCBlbnVtIHJ4ZV9tcl9j
b3B5X2RpciBkaXIpOw0KPiA+ICAgaW50IHJ4ZV9tYXBfbXJfc2coc3RydWN0IGliX21yICppYm1y
LCBzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnLA0KPiA+ICAgCQkgIGludCBzZ19uZW50cywgdW5zaWdu
ZWQgaW50ICpzZ19vZmZzZXQpOw0KPiA+ICtpbnQgcnhlX21yX2NvcHlfeGFycmF5KHN0cnVjdCBy
eGVfbXIgKm1yLCB1NjQgaW92YSwgdm9pZCAqYWRkciwNCj4gPiArCQkgICAgICAgdW5zaWduZWQg
aW50IGxlbmd0aCwgZW51bSByeGVfbXJfY29weV9kaXIgZGlyKTsNCj4gPiAgIGludCByeGVfbXJf
ZG9fYXRvbWljX29wKHN0cnVjdCByeGVfbXIgKm1yLCB1NjQgaW92YSwgaW50IG9wY29kZSwNCj4g
PiAgIAkJCXU2NCBjb21wYXJlLCB1NjQgc3dhcF9hZGQsIHU2NCAqb3JpZ192YWwpOw0KPiA+ICAg
aW50IHJ4ZV9tcl9kb19hdG9taWNfd3JpdGUoc3RydWN0IHJ4ZV9tciAqbXIsIHU2NCBpb3ZhLCB1
NjQgdmFsdWUpOw0KPiA+IEBAIC04MCw2ICs4MywxMSBAQCBpbnQgcnhlX2ludmFsaWRhdGVfbXIo
c3RydWN0IHJ4ZV9xcCAqcXAsIHUzMiBrZXkpOw0KPiA+ICAgaW50IHJ4ZV9yZWdfZmFzdF9tcihz
dHJ1Y3QgcnhlX3FwICpxcCwgc3RydWN0IHJ4ZV9zZW5kX3dxZSAqd3FlKTsNCj4gPiAgIHZvaWQg
cnhlX21yX2NsZWFudXAoc3RydWN0IHJ4ZV9wb29sX2VsZW0gKmVsZW0pOw0KPiA+DQo+ID4gK3N0
YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyByeGVfbXJfaW92YV90b19pbmRleChzdHJ1Y3Qgcnhl
X21yICptciwgdTY0IGlvdmEpDQo+ID4gK3sNCj4gPiArCXJldHVybiAoaW92YSA+PiBtci0+cGFn
ZV9zaGlmdCkgLSAobXItPmlibXIuaW92YSA+PiBtci0+cGFnZV9zaGlmdCk7DQo+ID4gK30NCj4g
DQo+IFRoZSB0eXBlIG9mIHRoZSBmdW5jdGlvbiByeGVfbXJfaW92YV90b19pbmRleCBpcyAidW5z
aWduZWQgbG9uZyIuIEluDQo+IHNvbWUgMzIgYXJjaGl0ZWN0dXJlLCB1bnNpZ25lZCBsb25nIGlz
IDMyIGJpdC4NCj4gDQo+IFRoZSB0eXBlIG9mIGlvdmEgaXMgdTY0LiBTbyBpdCBoYWQgYmV0dGVy
IHVzZSB1NjQgaW5zdGVhZCBvZiAidW5zaWduZWQNCj4gbG9uZyIuDQo+IA0KPiBaaHUgWWFuanVu
DQoNCkhpLA0KdGhhbmtzIGZvciB0aGUgY29tbWVudC4NCg0KSSB0aGluayB0aGUgY3VycmVudCB0
eXBlIGRlY2xhcmF0aW9uIGRvZXNuJ3QgbWF0dGVyIGluIDMyLWJpdCBPUy4NClRoZSBmdW5jdGlv
biByZXR1cm5zIGFuIGluZGV4IG9mIHRoZSBwYWdlIHNwZWNpZmllZCB3aXRoICdpb3ZhJy4NCkFz
c3VtaW5nIHRoZSBwYWdlIHNpemUgaXMgdHlwaWNhbCA0S2lCLCB1MzIgaW5kZXggY2FuIGFjY29t
bW9kYXRlDQoxNiBUaUIgaW4gdG90YWwsIHdoaWNoIGlzIGxhcmdlciB0aGFuIHRoZSB0aGVvcmV0
aWNhbCBsaW1pdCBpbXBvc2VkDQpvbiAzMi1iaXQgc3lzdGVtcyAoaS5lLiA0R2lCIG9yIDJeMzIg
Qnl0ZXMpLg0KDQpSZWdhcmRzLA0KRGFpc3VrZSBNYXRzdWRhDQoNCj4gDQo+ID4gKw0KPiA+ICAg
LyogcnhlX213LmMgKi8NCj4gPiAgIGludCByeGVfYWxsb2NfbXcoc3RydWN0IGliX213ICppYm13
LCBzdHJ1Y3QgaWJfdWRhdGEgKnVkYXRhKTsNCj4gPiAgIGludCByeGVfZGVhbGxvY19tdyhzdHJ1
Y3QgaWJfbXcgKmlibXcpOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cv
cnhlL3J4ZV9tci5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYw0KPiA+IGlu
ZGV4IGRhM2RlZTUyMDg3Ni4uMWY3YjhjZjkzYWRjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMNCj4gPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQv
c3cvcnhlL3J4ZV9tci5jDQo+ID4gQEAgLTQ1LDcgKzQ1LDcgQEAgaW50IG1yX2NoZWNrX3Jhbmdl
KHN0cnVjdCByeGVfbXIgKm1yLCB1NjQgaW92YSwgc2l6ZV90IGxlbmd0aCkNCj4gPiAgIAl9DQo+
ID4gICB9DQo+ID4NCj4gPiAtc3RhdGljIHZvaWQgcnhlX21yX2luaXQoaW50IGFjY2Vzcywgc3Ry
dWN0IHJ4ZV9tciAqbXIpDQo+ID4gK3ZvaWQgcnhlX21yX2luaXQoaW50IGFjY2Vzcywgc3RydWN0
IHJ4ZV9tciAqbXIpDQo+ID4gICB7DQo+ID4gICAJdTMyIGtleSA9IG1yLT5lbGVtLmluZGV4IDw8
IDggfCByeGVfZ2V0X25leHRfa2V5KC0xKTsNCj4gPg0KPiA+IEBAIC03MiwxMSArNzIsNiBAQCB2
b2lkIHJ4ZV9tcl9pbml0X2RtYShpbnQgYWNjZXNzLCBzdHJ1Y3QgcnhlX21yICptcikNCj4gPiAg
IAltci0+aWJtci50eXBlID0gSUJfTVJfVFlQRV9ETUE7DQo+ID4gICB9DQo+ID4NCj4gPiAtc3Rh
dGljIHVuc2lnbmVkIGxvbmcgcnhlX21yX2lvdmFfdG9faW5kZXgoc3RydWN0IHJ4ZV9tciAqbXIs
IHU2NCBpb3ZhKQ0KPiA+IC17DQo+ID4gLQlyZXR1cm4gKGlvdmEgPj4gbXItPnBhZ2Vfc2hpZnQp
IC0gKG1yLT5pYm1yLmlvdmEgPj4gbXItPnBhZ2Vfc2hpZnQpOw0KPiA+IC19DQo+ID4gLQ0KPiA+
ICAgc3RhdGljIHVuc2lnbmVkIGxvbmcgcnhlX21yX2lvdmFfdG9fcGFnZV9vZmZzZXQoc3RydWN0
IHJ4ZV9tciAqbXIsIHU2NCBpb3ZhKQ0KPiA+ICAgew0KPiA+ICAgCXJldHVybiBpb3ZhICYgKG1y
X3BhZ2Vfc2l6ZShtcikgLSAxKTsNCj4gPiBAQCAtMjQyLDggKzIzNyw4IEBAIGludCByeGVfbWFw
X21yX3NnKHN0cnVjdCBpYl9tciAqaWJtciwgc3RydWN0IHNjYXR0ZXJsaXN0ICpzZ2wsDQo+ID4g
ICAJcmV0dXJuIGliX3NnX3RvX3BhZ2VzKGlibXIsIHNnbCwgc2dfbmVudHMsIHNnX29mZnNldCwg
cnhlX3NldF9wYWdlKTsNCj4gPiAgIH0NCj4gPg0KPiA+IC1zdGF0aWMgaW50IHJ4ZV9tcl9jb3B5
X3hhcnJheShzdHJ1Y3QgcnhlX21yICptciwgdTY0IGlvdmEsIHZvaWQgKmFkZHIsDQo+ID4gLQkJ
CSAgICAgIHVuc2lnbmVkIGludCBsZW5ndGgsIGVudW0gcnhlX21yX2NvcHlfZGlyIGRpcikNCj4g
PiAraW50IHJ4ZV9tcl9jb3B5X3hhcnJheShzdHJ1Y3QgcnhlX21yICptciwgdTY0IGlvdmEsIHZv
aWQgKmFkZHIsDQo+ID4gKwkJICAgICAgIHVuc2lnbmVkIGludCBsZW5ndGgsIGVudW0gcnhlX21y
X2NvcHlfZGlyIGRpcikNCj4gPiAgIHsNCj4gPiAgIAl1bnNpZ25lZCBpbnQgcGFnZV9vZmZzZXQg
PSByeGVfbXJfaW92YV90b19wYWdlX29mZnNldChtciwgaW92YSk7DQo+ID4gICAJdW5zaWduZWQg
bG9uZyBpbmRleCA9IHJ4ZV9tcl9pb3ZhX3RvX2luZGV4KG1yLCBpb3ZhKTsNCg0K

