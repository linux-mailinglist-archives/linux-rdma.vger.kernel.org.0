Return-Path: <linux-rdma+bounces-6715-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9F69FBA28
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 08:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53BE016426B
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 07:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80A715B102;
	Tue, 24 Dec 2024 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="NY3iXeR8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EB1EEBB;
	Tue, 24 Dec 2024 07:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735025045; cv=fail; b=l6OG4BKrWQ5/NboYNR25rpLP57jMip0wxAoH0Iq0fMvgYBBjuL/pbeLridwRMkU+dsoWcIsP3o1VqKqNMoT2Hy33V18Ak4AAyQ3W+GtUeLvX8VsBbD7FjivZpCBbyPV1gL7InicvS78acii/0NRysk2s2EulSwtJlNt2kJ8uPXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735025045; c=relaxed/simple;
	bh=tzT4E5qgcoUf9ggLm2lsBqfaJX727ZSt7rHYiLLc3SQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZWI5bKdZCx8E0hxSyKOxQJc7p27rw79bIndBsbkyoSSxaH8OGvvzekKWpCJpty/v0SDyji87DZaT3L1TYRIksqM/bu5lr7xJ+KLmAGurTUjkOPLUQjGns9YNXoi/xZPwQUVJFdprx5VUoqAAMoO6fUH5NjdNxPwkzWjuiDXK4XY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=NY3iXeR8; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1735025044; x=1766561044;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tzT4E5qgcoUf9ggLm2lsBqfaJX727ZSt7rHYiLLc3SQ=;
  b=NY3iXeR8aEmcRQDmFO+mdqJQAtn6sN3BfzXUXnPjYIv1pl/Ubz5BhWtm
   pxbtrpt1zHaFCCavDxTKjxW4k1YJGXmEidPyxYv+NeKB4EuBQroW2DL5T
   Q9ma0mv88rIjDcgGqJ5CkAlJOlEQHjPfsSZJLwSg3gEZz4NIz9rzwf6O7
   pnC2K2OvaVVVv2+SX6rJ5aqrpunBmxEPg+z7NvdjnvRHaok/vyNIJP722
   rCNMhKAndkg4V9vQCUUYYZBiwLE1bgMJlpCm0XpAxbaYqBtdVALFUbstF
   Ac69yODD0Uni5X3hc5Qb4YJRyCG8/KeBZ+c2NBZThr2L5GbvILvyJbFSY
   Q==;
X-CSE-ConnectionGUID: rjzxkhGVSXO+0UhljewRDQ==
X-CSE-MsgGUID: EvC6Ive+QaGNWr3PeneCKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="140788951"
X-IronPort-AV: E=Sophos;i="6.12,259,1728918000"; 
   d="scan'208";a="140788951"
Received: from mail-japanwestazlp17011026.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.26])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 16:22:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1sGflb7D79+8r+RAqdgXIC/T5yWV60tZfP28wX7YrrImYq3WuB+I0CkZe64SBOKTHFeG58YEqNLa8B1x/LTaOcRHTDhDxfXgss32Khn0ONVLZMEQgiSVBQfbj9oQIMA2A7+ImrGOTE8bcJZ8Iew7T97mfPLyklMeCNCX8B9rwxpx6BiGZCbIvoBP5X2mJLpbTgSoLkD7DEDBdax/2D3MDwXfCG2OhYxm5dtVmTLNq2RCUmk1X6ngzWbjrzeemELOK7UoSln7DXM61m/xmOMEBwQH/j1xJsHdvlMIdd1iFZLppUBVuFJTMq/EScp1DYAm/4GUDOWsQvs3xm157LOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzT4E5qgcoUf9ggLm2lsBqfaJX727ZSt7rHYiLLc3SQ=;
 b=p5lnpWbfV3OleP5xtTisV0FtAgnRcGVfCjR2reVN3LLbSyMkObRJJV4ye8K1Si5HcvIIrIHSsyenzvR7MidIAvzWHkP2PD8BinmobJp5qyJ/AC7eyJKKc2AKUs173M7TjhQmWJ2O05H9FePM6fh9301vZ5QLjpOcNPPpo+o5qgWSp9tveYHP6F4vw7213bHsvKPG78ivDQkKxwW6eqpuapinhKNIiiTfQkts6SzsOzRZyXFvQogj8Px9BOXeOTKrgU9SKDk3wxNNsWeIRhq3pFCbvpW8wM6Fxm/67mB5ElWq5sI3SDcQdLGKexYw+Ea+oZnymn9fnRB/21+8FfQ5xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYWPR01MB10210.jpnprd01.prod.outlook.com (2603:1096:400:1e6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.17; Tue, 24 Dec
 2024 07:22:47 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 07:22:47 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>, Jack Wang
	<jinpu.wang@ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/ulp: Add missing deinit() call
Thread-Topic: [PATCH] RDMA/ulp: Add missing deinit() call
Thread-Index: AQHbVOZd0FKAzOSIGUKPVREyWNNbsLL0+pCAgAAE5QA=
Date: Tue, 24 Dec 2024 07:22:47 +0000
Message-ID: <985b1b4c-9454-499e-9b0d-790098782d31@fujitsu.com>
References: <20241223025700.292536-1-lizhijian@fujitsu.com>
 <eabd8945-cd07-4ee4-b6e1-a6f251d157c0@fujitsu.com>
In-Reply-To: <eabd8945-cd07-4ee4-b6e1-a6f251d157c0@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYWPR01MB10210:EE_
x-ms-office365-filtering-correlation-id: 464035e8-5e92-4f70-0a07-08dd23ebc45e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?U01PQ2l2MWZlLzJKVVNmaHBoOXMxc3Z4aXc5VkdLQlNaU2N5VEN6UFRnOEhZ?=
 =?utf-8?B?WUQ3VjlCQUJPdnFxOWllK3VpRUJFbzlXWEtxT05JWE5yS0t5cmhSSGxDRWFZ?=
 =?utf-8?B?Mlgya1VRaFQ5U2o3YXBDb0RKQVQ1clY0cTJ4blJ4RWlYbWlxb29YSmxpdi9h?=
 =?utf-8?B?SVpXL3l0Q2lWNFRBRVFNRmRpUnRoRHJoODRka2dCZUMrQ2picXZGS3QyN3BI?=
 =?utf-8?B?c3V5YlFFZThCYVBSa3J3WGtzY3dqMDIwWGRUYkw0K3dLTEJ4Q1ZKUWxaaUxJ?=
 =?utf-8?B?M3dtbjQ1R3pDOEZ5cUhDTUhoN3lqSXJ4MHl1eFdiQTFHTkx3eEwwVStJMVpy?=
 =?utf-8?B?YkNlV0FnbkJhU2VYSk9XdWRqL043U05tRm9lOVRPbE4rTjZhSGJWUXhmODVa?=
 =?utf-8?B?SjJOWk0rTHUzcDI2VUhrNnB4OEJaYlptUldlYndMaXpYNkJuN2VNeFEwclkr?=
 =?utf-8?B?T1JacEplbFpFZHdKWVJGNG5qQmJNU09BZDdINmljQm5NaDBlNDdERnlsdU5L?=
 =?utf-8?B?NkJCdUNUeGFZYnluYTU1d1M3QjZSZkJWaklualJIcXhyTUlCVWFoVGJvV1Ba?=
 =?utf-8?B?VUZlZEx5RnhQQkdLMnhYT3YxdkRlTjBiVUpiTnpHQ1ZNbzF4WmxNUW0wYk13?=
 =?utf-8?B?ZHozbktnMzVtYzdla3craW9sNHRFWEswWHFqYnVPSitBTmhtVXd1WVJEWkRl?=
 =?utf-8?B?c05CUkxtU09ERUc4RFZ5RXFjNGhLc0FZR2dlK2hlRCt0azJXYjEzeHNHbUt6?=
 =?utf-8?B?SEQzcnE2cU03MG9nWGM4b2Vmdnk3N3ZzaTVKYTJiN1ppZ3YvVytYRGJkbXht?=
 =?utf-8?B?eTh5THR4RTRET2NjeXFWVlppaktsNTVtM2hHaU0rSXJPd25lUkZobHV5ZTln?=
 =?utf-8?B?NlRTdWRGZHNNaUo5bnkwOFB1Q1Y1alR3d2xGUUl6c0xWRC9zSTlsczBLQ2dw?=
 =?utf-8?B?Z2Q5bWZleGhhNjMxa2hZQjhqRWxLVmdKUEpWOHhQUHptL1hOM09pUys0dFZL?=
 =?utf-8?B?eTQ4c3E3eEQ0U2wwaVpHM2xPUWVZd2N3ejdEbDM0NTVvYTN6ZWNYWGJwT21B?=
 =?utf-8?B?d0t4U0k0SFBid0xGZUYrZmY4TEJYOVkzM1F4Z3dtQmdYR1RoNDBvZyt0YU5l?=
 =?utf-8?B?RWI5b20yeTE0aXNPTndUMDQxb1BZQXoyaHRFSjNJREpXNG1WQW9rTDZ3UlZQ?=
 =?utf-8?B?QlpOckcrODBSZjJDcWQ0RFl0WXAvSUFqUGNNNXU4ODNxU2JwaWRaQ3JzdjRF?=
 =?utf-8?B?QXZGdUJNeHlLWk00NU9KNCtTYkhaallGTWRCVWt6K09pWFFyZUZ1MmtBaGxH?=
 =?utf-8?B?NkhOQlpZM0Y1cUVXYy93bkI4QjhyRGczODhNZUlac2xkRXlBMGFlMnVNQ2Rh?=
 =?utf-8?B?MzVCVDFKV3E0V2c0VFN4LysxT0orVzZ6RjRWd3Jab2R0dE1wbVc0bTVXKzR2?=
 =?utf-8?B?SFdyS1VOMjRCQ1lob01iYTk3Qmg4QStYK2pYZjBwYkFTeFRsYzZKT3Uybkd0?=
 =?utf-8?B?NVR3OHczeWhoQXYyRG1xTVVYN1BPV3pZL2QrOU5NUVVjeVE3M2J5NDNCOE9C?=
 =?utf-8?B?VjlYcGJxZUVJRDBoTTZLZlZxcWpSQVFkTVRGUG5Hc2RpRmowTWs1NmY4V1hO?=
 =?utf-8?B?NTVOSGROM2tMaDBCZ0Q5YXlFekc0SElvM0daSTgxVDlmK3djbGc0SU96aWEx?=
 =?utf-8?B?SXcwbTZJZzNGMlEvMkg5c0JRREUwczRYUGlqM0U5bGNzaTVFb2taeVJWZzZI?=
 =?utf-8?B?dURFWi94RmM2bkF0dTh5RW54bGJOS3BBK05vMldMS2NzR2lsMVlFSTMrT1pW?=
 =?utf-8?B?bzlucjFOaVFoZFArVURyaUdqNHNJU0xBYW1yNzhJUXRvOGpBK0hFd2dqN1Zl?=
 =?utf-8?B?dnNIQ2wrdzVGT3RpcW43Yk0wd3lLVmdiQ3dRZnNlUTNUS3BBc1d1Um45YS85?=
 =?utf-8?Q?Rs5GMqRIVnCfbmKeUpcUTjSAuIWzBIms?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SEpYSkVUY3pTWjE4NXpVTUV5aFRQeitPKzhLOG1TTjFBTUhvQlRzWHBBVE1j?=
 =?utf-8?B?RWsxL1YvK0w3SmJxcE03RS84SFh6cm9xMmU0QmVTQTg0emxWLzhnamdQV25T?=
 =?utf-8?B?bkM0RFdVYzRFSExiTDg2WFdFbnRpNEdKRkRoRTdTRGJYUFFSYi9jYS9TT2Uy?=
 =?utf-8?B?OEptUFcrUlk4TG92YUp1OW9hV2VXSkY0Kzg0bVBWVHN3OXo2dUpxWU1rbHFX?=
 =?utf-8?B?ZzI5YWdLS0VJUHBOZGRmckFML1k4Qnd5T09xUFExWE10OTFHU1ljei9GREg1?=
 =?utf-8?B?dGVPRStnN01uWVdjMXRtcGxrbzRSOWsvZm9Ea2liYlRYMFA1eFg5WkhBQm1z?=
 =?utf-8?B?VDRESEtvSlIxZEMzTTA1VmRhenVqcExDSEFBQ01JUEpEY3JKeGVMNFB1ajd5?=
 =?utf-8?B?WnhyVmprWkQvcDl0S212VUtHbVBuYkxNNXNKR042Y1U0WWJ0TnNEd2lXZ2hZ?=
 =?utf-8?B?MVVQRzJMSUpSeXhDR1loZWREZllyeVc3SG1mNTNXdldUTHN4TVpickxhRGFt?=
 =?utf-8?B?ZEFrVm5NNlhzZ2t4RTZkbmkrSkM4dVhyVXM3UjlDelRsaTJma0Y5NDNkZ3FD?=
 =?utf-8?B?aENNSWlTWWJ1WkpLTERXekd4MnYzNEUxZTg3MFZpQ0hhT1l0OE9OWkU3cUpa?=
 =?utf-8?B?OHBOWFNGYXRYTk1EeThpQytCTUd3VmswdVpQQVQwNk5NemxUUjhMMXM2QjFl?=
 =?utf-8?B?eFQ5V2hXSXlNS2ZRY0EzUXpLaXlFdGpVcWcvaW5FSEZ5Z3hNcGxDdGVMRTd1?=
 =?utf-8?B?OTFkNDljR2FlQW4xWHhGaVVaTWlYL3hXSFE1UURFbFN5b1drdGxsNmdrOE5j?=
 =?utf-8?B?R08zS1BqWHJ0OWM1N0d0Z2lTaVRiR0txdjd6ZC84SVlOTkQ3ZTgxUXlmS3ow?=
 =?utf-8?B?aVp3WDlqLzFWT0JiTllxUzJnN1pYTThLb0VRNlpnSlFkVTlzTDY3V002OHB5?=
 =?utf-8?B?UTQwamw0UW9kVDJ4Mmx5NzB4YmZVVzllV3VubUduZERXNXFxem5WcmtpYmxQ?=
 =?utf-8?B?djIwNGdxUy9DaUhPcGdsOWRsenYrQVR2Z3k4MnFpUlF5ZlBkbjFHWEs1dHFx?=
 =?utf-8?B?a1p1YUNOTlBaelFUUXRycW9JeXhiWEhOMXdqL1k5QkVnQjg1NVBkc3BmTjhs?=
 =?utf-8?B?bER3ODNyaTlYTUNqMHE3bEYxbGtLUWxrWkxveGpEbHpxamw1WnBVa3FVTXlE?=
 =?utf-8?B?TTJ2UHkyeExjM1A4eHpZR1RiSGxJV2ZwRUE1TDUrYnVkdVFReU9TcmRqSGUx?=
 =?utf-8?B?dkxjZjlMMEcrR3pmdFNDVDA5cmJGdWNzQ3BzM0hVR1BjV29BSHRtS3p4UnZX?=
 =?utf-8?B?QjlKMnNrN3I2eDNhWFB1dmlmblltcmlxdlh1dFNRVzZUcVVZdXRFa2RBb0xS?=
 =?utf-8?B?dFBkY3RwNlRFWVZzUDFtZDVST1pSeWtPbFh4L0o1ZWNqWEJ2YlNUOGRSaXh5?=
 =?utf-8?B?N3A0dm5tK1MwazRPVjRDY3dwRHZUeHEyUVZuYW5CSHJkRWduMWtGSmRkenJ3?=
 =?utf-8?B?dTRXUWxyaWdveGZ1VFVpMnl4ck0xeU96SXpEeEdkWi9vMThiUjBnMmJnUGdJ?=
 =?utf-8?B?YTdVSGpRL09UYU1FYlQrNlFWb2lEeEMxOCt6dmRjaHVkTWVva05zNkRveDJ2?=
 =?utf-8?B?Z2RZZyt4SDh4UXA4U2FZYmZGZlVXMXZHcXhwZGtLS1F6Q3kyQWl0bHZtWWZr?=
 =?utf-8?B?ekw0Vzd0bHZQb0piRHJ3YThEYUF0YkpaQ3ZGbEJjckZzOVhxZlZuZldHYllF?=
 =?utf-8?B?NVhUclY2U1NjRElBWFFQT3BPS1RQRnV0aTJ0N1lEbFViQjcrZTFuNG02bllv?=
 =?utf-8?B?U0orc1p1L1hhZndsWWgrcFBMOWlUQzJ6YVMrMlF1ZUFjK1Z0V3FMZSs3d01y?=
 =?utf-8?B?WWZ6MndNd0VSUzRZWjNGWEtLbFdraVpLM0ExOHpyUTRtdnIyTXdIYWF6M0xW?=
 =?utf-8?B?N3RMZEZya2YxeTBmTjFWRks0VDNiSmxhQ2g1MVBRdW04Qk42Q0RNeHlvY3o1?=
 =?utf-8?B?elpIU2w2eWVzSCtkMlVXbXMwUk93Q2hMKzlFYzk4MmhmSDRkeGFYM2lxTHZE?=
 =?utf-8?B?aWd2SnMzLzNlOENVcUpUSW14MjVka2I1OEk3aWpJbzIzYndsVWUxVWxqUGpu?=
 =?utf-8?B?aFJtZElzYzNpUVBnYUJiSWtnWDhYYkViZ0pseEY4NGtVcExza21kcjFTT2E4?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40A43DF96BD61C4197A807AA5A44BA70@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7GmxWKC5j3IvUREgskbSW8B704FvjDTJmB92IfhrNlg0f3Ax8WjzaLxwl48uSUwqnLMceb48SerGSezLIxfyAJzCDuXX9dFjyKjB8xczqOdcH1f/SD8BmauD0Gd9uD8KspdCV55F3I0K9pJZ2PWcesrLxxnmgollJhQDHryP2Be4x1QfJSfps16W7PhGXLJwzw1M8yo/1I5jp6sIHajTO4GUJOeP/lfEZf5NrQdVCdCuit2HCmDwrNM3nmzX2YHtN98b8G/5WeG0/+idAFft1tCtocvswLqouVNMaGFqEUKL0wBIk9PjdzaRpVhnccdoEqy3g65oLZFG9PPvaBriOOxaqH3CMyhJkiii9+kUbg82N+8/minlipu3y5L6lS+40CV8umOjy7l2NSzAPGnbtNDLXicH+nwXsq1l/KmSVp51JsYEQYH6BTmk7xVi7WHUa1BKQNuWUjkWhB8+oympUc3TCAdoKL8G/EckvOrE6pOeHbdh5UotX/0ZDMhT8ENpKY/Z7GjxkkurEx0z3eSIlcj2btZ/syQGs4rVN7VTzT8w0aUfdhFNtvcqDSObXwESo26qEf69DF5LxKtQORoEP+atua0B3pbUD1JFZif5VGAVLxy8tQEOC7whbeLkX9en
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 464035e8-5e92-4f70-0a07-08dd23ebc45e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2024 07:22:47.4801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RbrmkImzHX+klk29sdvCrKnXElUOI2t4lL+9xaZ0qcZ/Hg/UF0TP8C93H2X9ULisw1hc5EURIcQRDbOHujA89g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10210

DQoNCk9uIDI0LzEyLzIwMjQgMTU6MDUsIFpoaWppYW4gTGkgKEZ1aml0c3UpIHdyb3RlOg0KPiBU
aGUgc3ViamVjdCBzaG91bGQgYmU6DQo+IA0KPiBSRE1BL3VscCAtPiBSRE1BL3J0cnMNCj4gDQo+
IEFkZGl0aW9uYWxseSwgdGhlIHJlbGF0ZWQgcmVwcm9kdWNlciBpcyBhdmFpbGFibGUgYXQgdGhl
IGZvbGxvd2luZyBsaW5rDQoNClNvcnJ5IGZvciBteSBmYXQgZmluZ2VyLA0KU2VlIHRoZSBsaW5r
IGFzIGJlbG93Og0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYmxvY2svNjJjM2IxMjYt
NjViNy00MGVmLTk0ZTUtNDc1OGQ1YWEzY2YzQGZ1aml0c3UuY29tL1QvI3QNCg0KDQo+ICAgIA0K
PiBUaGFua3MNCj4gDQo+IE9uIDIzLzEyLzIwMjQgMTA6NTcsIExpIFpoaWppYW4gd3JvdGU6DQo+
PiBBIHdhcm5pbmcgaXMgdHJpZ2dlcmVkIHdoZW4gcmVwZWF0ZWRseSBjb25uZWN0aW5nIGFuZCBk
aXNjb25uZWN0aW5nIHRoZQ0KPj4gcm5iZDoNCj4+ICAgIGxpc3RfYWRkIGNvcnJ1cHRpb24uIHBy
ZXYtPm5leHQgc2hvdWxkIGJlIG5leHQgKGZmZmY4ODgwMGIxM2U0ODApLCBidXQgd2FzIGZmZmY4
ODgwMWVjZDEzMzguIChwcmV2PWZmZmY4ODgwMWVjZDEzNDApLg0KPj4gICAgV0FSTklORzogQ1BV
OiAxIFBJRDogMzY1NjIgYXQgbGliL2xpc3RfZGVidWcuYzozMiBfX2xpc3RfYWRkX3ZhbGlkX29y
X3JlcG9ydCsweDdmLzB4YTANCj4+ICAgIFdvcmtxdWV1ZTogaWJfY20gY21fd29ya19oYW5kbGVy
IFtpYl9jbV0NCj4+ICAgIFJJUDogMDAxMDpfX2xpc3RfYWRkX3ZhbGlkX29yX3JlcG9ydCsweDdm
LzB4YTANCj4+ICAgICA/IF9fbGlzdF9hZGRfdmFsaWRfb3JfcmVwb3J0KzB4N2YvMHhhMA0KPj4g
ICAgIGliX3JlZ2lzdGVyX2V2ZW50X2hhbmRsZXIrMHg2NS8weDkzIFtpYl9jb3JlXQ0KPj4gICAg
IHJ0cnNfc3J2X2liX2Rldl9pbml0KzB4MjkvMHgzMCBbcnRyc19zZXJ2ZXJdDQo+PiAgICAgcnRy
c19pYl9kZXZfZmluZF9vcl9hZGQrMHgxMjQvMHgxZDAgW3J0cnNfY29yZV0NCj4+ICAgICBfX2Fs
bG9jX3BhdGgrMHg0NmMvMHg2ODAgW3J0cnNfc2VydmVyXQ0KPj4gICAgID8gcnRyc19yZG1hX2Nv
bm5lY3QrMHhhNi8weDJkMCBbcnRyc19zZXJ2ZXJdDQo+PiAgICAgPyByY3VfaXNfd2F0Y2hpbmcr
MHhkLzB4NDANCj4+ICAgICA/IF9fbXV0ZXhfbG9jaysweDMxMi8weGNmMA0KPj4gICAgID8gZ2V0
X29yX2NyZWF0ZV9zcnYrMHhhZC8weDMxMCBbcnRyc19zZXJ2ZXJdDQo+PiAgICAgPyBydHJzX3Jk
bWFfY29ubmVjdCsweGE2LzB4MmQwIFtydHJzX3NlcnZlcl0NCj4+ICAgICBydHJzX3JkbWFfY29u
bmVjdCsweDIzYy8weDJkMCBbcnRyc19zZXJ2ZXJdDQo+PiAgICAgPyBfX2xvY2tfcmVsZWFzZSsw
eDFiMS8weDJkMA0KPj4gICAgIGNtYV9jbV9ldmVudF9oYW5kbGVyKzB4NGEvMHgxYTAgW3JkbWFf
Y21dDQo+PiAgICAgY21hX2liX3JlcV9oYW5kbGVyKzB4M2EwLzB4N2UwIFtyZG1hX2NtXQ0KPj4g
ICAgIGNtX3Byb2Nlc3Nfd29yaysweDI4LzB4MWEwIFtpYl9jbV0NCj4+ICAgICA/IF9yYXdfc3Bp
bl91bmxvY2tfaXJxKzB4MmYvMHg1MA0KPj4gICAgIGNtX3JlcV9oYW5kbGVyKzB4NjE4LzB4YTYw
IFtpYl9jbV0NCj4+ICAgICBjbV93b3JrX2hhbmRsZXIrMHg3MS8weDUyMCBbaWJfY21dDQo+Pg0K
Pj4gRml4IGl0IGJ5IGludm9raW5nIHRoZSBgZGVpbml0KClgIHRvIGFwcHJvcHJpYXRlbHkgdW5y
ZWdpc3RlciB0aGUgSUIgZXZlbnQNCj4+IGhhbmRsZXIuDQo+Pg0KPj4gRml4ZXM6IDY2N2RiODZi
Y2JlOCAoIlJETUEvcnRyczogUmVnaXN0ZXIgaWIgZXZlbnQgaGFuZGxlciIpDQo+PiBTaWduZWQt
b2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+ICAg
IGRyaXZlcnMvaW5maW5pYmFuZC91bHAvcnRycy9ydHJzLmMgfCAzICsrKw0KPj4gICAgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lu
ZmluaWJhbmQvdWxwL3J0cnMvcnRycy5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3VscC9ydHJzL3J0
cnMuYw0KPj4gaW5kZXggNGUxN2Q1NDZkNGNjLi4zYjNlZmVjZDA4MTcgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL2luZmluaWJhbmQvdWxwL3J0cnMvcnRycy5jDQo+PiArKysgYi9kcml2ZXJzL2lu
ZmluaWJhbmQvdWxwL3J0cnMvcnRycy5jDQo+PiBAQCAtNTgwLDYgKzU4MCw5IEBAIHN0YXRpYyB2
b2lkIGRldl9mcmVlKHN0cnVjdCBrcmVmICpyZWYpDQo+PiAgICAJZGV2ID0gY29udGFpbmVyX29m
KHJlZiwgdHlwZW9mKCpkZXYpLCByZWYpOw0KPj4gICAgCXBvb2wgPSBkZXYtPnBvb2w7DQo+PiAg
ICANCj4+ICsJaWYgKHBvb2wtPm9wcyAmJiBwb29sLT5vcHMtPmRlaW5pdCkNCj4+ICsJCXBvb2wt
Pm9wcy0+ZGVpbml0KGRldik7DQo+PiArDQo+PiAgICAJbXV0ZXhfbG9jaygmcG9vbC0+bXV0ZXgp
Ow0KPj4gICAgCWxpc3RfZGVsKCZkZXYtPmVudHJ5KTsNCj4+ICAgIAltdXRleF91bmxvY2soJnBv
b2wtPm11dGV4KTs=

