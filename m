Return-Path: <linux-rdma+bounces-8581-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B806A5C3AC
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 15:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59C53B1A2F
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 14:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E8F25B689;
	Tue, 11 Mar 2025 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rOWCBeL9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529041C3BF9;
	Tue, 11 Mar 2025 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702830; cv=fail; b=i6Ufc34bpuYydcgKDFqDcEg0vDoOcutEVccrEsmRVpEYp99ocEl/hc1bfcnEhUGdcZT30cEzxXoQepa2GPJap5C2KzcqiFxpPRE2ioycBrbfA+d895w3nebicFD8bg5+P6oTab3dN4yUMKBHExVt5cZZ0yAoSJn2l6gtYvnrHeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702830; c=relaxed/simple;
	bh=5vWFFXO+B6gFb3gSyH3SVm02flSSDEaJx2igEGBjhqU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=In2FjB2upyT4jXevhex0wSniSAMZeIq1DIQy8QAERAiB6p38kCXYOwS7W1ZxsQvtmR7BE1vwjoIpPx4UEh8gm2B56+HRsMtXbDXSbfMis6zogMwhHZVZVwA/9mJ94B4ugsCyznpANuF4KsYrUsUYBo8UojBNpgeayIx93YZQ9KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rOWCBeL9; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B9FvIL026729;
	Tue, 11 Mar 2025 14:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5vWFFX
	O+B6gFb3gSyH3SVm02flSSDEaJx2igEGBjhqU=; b=rOWCBeL9Th7Iw8zWrJt2VD
	mn6MdXg2PPU2Hk+VA6uq1M5C3stFXMRuI4nEcMf8QlhXuDnz93c8gg8L4HyxbmKz
	aCuWllKTavJSjWYSNQ0OeQIs1BgyyBCi25y/YrbP3O9wHkQ8frmd9sjdsZYgQXPl
	/p3IVj0GP1vgm92EnyUNe6aeQ52w8noBruTNdm+SJYPsC7acGfoUrUcOvX0895sQ
	APqPJwOf8nS1s6tb0w+bdYVcJf7qINx97lbRKo/JYrm6ZNCh4UzwGyacPCMAnZbf
	cjpJWbpcAYsGPyVbY/JTdFbMOl2j98s5mx/rYOKw4Af1YAXPieMCeevIEJviGBdA
	==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a7a1cch1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 14:20:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbqevUzmEfuWG5NVTE7Q3WJcTn74QcVxDOC1a9pm+NxcOW4O1fgzSS4C51GMBodRCQzAyPiqKXf/KStSx40b35KvIihzMlxwXQpfFNlC+5YFO4wmkKCSysh78nyVc7uPC2E0+8Qp5RHCcz2cxt0j32nvnSTO5ll2/qhC9UtkfmYrzEEc07FHq3AAAQzjRA5cdszCUkN3Fmg6MLIxwOP1m2bD5kmDR/TWT1p4xEFVL5a2LUpCxR6vwYh7cjvKdMnJcN1TxuIK4apQg5XeMM17p0PFdpxpdmWbyXtqJjGig2hgiZUaOOBFKuV1BlU/zBC1vWCz2QxGbyfSsKj7lurohQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vWFFXO+B6gFb3gSyH3SVm02flSSDEaJx2igEGBjhqU=;
 b=VnaKZwu9Geom+lHE12pp3LKkZa0TsTxvwrbHts7wBq/PpCw+8plBZ/t3cdDrJlfjJweIiXu6GQUBZNAf20I8lnbud2SlcS16+67XzYaDNjAT6DJCtrU22pqZ5CjCjxghris8q5zX1m4oftTigNvPNjnb7Kv6fkT+HNMxAzaBJZM4JgQXiz9MX8lDEWtmQMXTltwzhQRu1NCiqnv3GZYAMSbB6dQOkA2vAXUI9K2UqcQZVd2oVVN3MjfCbPClwb50FPxntk7eHMcmW84lfV3Ky5DOEVlOzCAKN3IZsI/Aq01Y2bOiOTYSADhrZdbRhzIfJGjgs427+Mj8CRRd9sh5WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30)
 by PH0PR15MB5831.namprd15.prod.outlook.com (2603:10b6:510:291::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 14:20:07 +0000
Received: from BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16]) by BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 14:20:07 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Nikolay Aleksandrov <nikolay@enfabrica.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "shrijeet@enfabrica.net" <shrijeet@enfabrica.net>,
        "alex.badea@keysight.com"
	<alex.badea@keysight.com>,
        "eric.davis@broadcom.com"
	<eric.davis@broadcom.com>,
        "rip.sohan@amd.com" <rip.sohan@amd.com>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "roland@enfabrica.net"
	<roland@enfabrica.net>,
        "winston.liu@keysight.com"
	<winston.liu@keysight.com>,
        "dan.mihailescu@keysight.com"
	<dan.mihailescu@keysight.com>,
        Kamal Heib <kheib@redhat.com>,
        "parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>,
        Dave Miller
	<davem@redhat.com>,
        "ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
        "andrew.tauferner@cornelisnetworks.com"
	<andrew.tauferner@cornelisnetworks.com>,
        "welch@hpe.com" <welch@hpe.com>,
        "rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
        "kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kuba@kernel.org"
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jason Gunthorpe
	<jgg@nvidia.com>
Subject: RE: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Topic: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Index: AQHbkKJljtvDfPUWBkyn2/S3SWreCrNtni9A
Date: Tue, 11 Mar 2025 14:20:07 +0000
Message-ID:
 <BN8PR15MB25136EC9F3DE1FBEF9B2429199D12@BN8PR15MB2513.namprd15.prod.outlook.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250308184650.GV1955273@unreal>
 <CY8PR12MB7195F4D67BE6D9A970044572DCD72@CY8PR12MB7195.namprd12.prod.outlook.com>
In-Reply-To:
 <CY8PR12MB7195F4D67BE6D9A970044572DCD72@CY8PR12MB7195.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2513:EE_|PH0PR15MB5831:EE_
x-ms-office365-filtering-correlation-id: afae2a18-c011-4a9c-722f-08dd60a7d30f
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T3lBNDZ2WEZxWXNtZGJMNjMwaTJJVGFvb0FUeEFrOGpReDRFMTRuM0w0eDQx?=
 =?utf-8?B?Tkx5RkdBMWdyS0gvNnpQU1o3eG5wblVNejI1ckVEaDcxMGJ5aVJsYy9mUkFS?=
 =?utf-8?B?SW0rZXBkSUQzazFFWFFkNEtWOVRweUgxYUgwaDVKUGVQVGlka1k5dnNkVGx6?=
 =?utf-8?B?b2czY0Z4dWs0VU9iSGxUR2pzK1hWQTFpZU5zTHFkY3oySy9aaFQ4K3VNSGJN?=
 =?utf-8?B?V1VyYXc0TVVQRkdIU0ZqY2tJU2xjVWE4UkZuZDNhbmJ5anFQa2MrdStNZlpY?=
 =?utf-8?B?Q3NWVmlTMStwdHFpQTQyTVY1c2tBeHlFRCtBNlNYbHNkVkhoOFQvN1h3U3BI?=
 =?utf-8?B?dlA1cWVtbHJtQTdLOEUvY1Z6R3Z3VjBpNWRTcy9ielI0RDJLQVRlVElwRXpH?=
 =?utf-8?B?MEJPUlgxWTU3UnZtMlZ6R0VRVUJncWIxY21iTHVtMjkwQUZBMVNaTWpFWjkx?=
 =?utf-8?B?NzJzTGE2QlE5eEltazNmd0xUbUV5bWlIVlRKYzhYTmhGNDZIbzdIdVJsYkNz?=
 =?utf-8?B?Vm5Pa1dSRUt4cU1vYXR0blIxZUJ3Ty9mdUJJaWlZLzVFQ1QzeHRYVkhHT0VT?=
 =?utf-8?B?NmcrOWdscnJlNTRDbWNPM2hoZjcybWFIVmhjaGRsRlgzazZ5L05zTmdITHFl?=
 =?utf-8?B?UDJ3U0RZc0s4U052NXZFcDJLaW5qM2Flbm9hWUZvVUUzQ005THkrUGVFcUtr?=
 =?utf-8?B?RjA4WkZqbEk3WFp6QnpPVmNjVzlNQ2FaNEhRbHFWSUdJMnpNem01Wi9ZNWRF?=
 =?utf-8?B?blRlMUx3YjQ5OStmWlM0TmEzTWg4ekNpMWU0b1A5T2FUQzZSZnFKV2RZVTRE?=
 =?utf-8?B?dmtLTG1BWnF5UWxYRzh6VjNtZUdSdnRhRUV0Q0VXdUJBd1dIRkJlUEh5cjZp?=
 =?utf-8?B?Mi9yMlFlSDFaUVgyMHFzRlhtOHpqOGEzRHRLVThiK0FOcmxyM3AvYXo2dDR1?=
 =?utf-8?B?djgwUnB5dXc4bys2bmMyZDF0QjlQejFGMHh2Q1hFWVdrUUprRlRRMEt3WHM5?=
 =?utf-8?B?KzlobjMzWlZyMXFIQzNzN0twVjJiNWo3dzVweGc1ZjFZWG1ibE56allhcUNV?=
 =?utf-8?B?VnJpazA3amlyS3FieDlqSUFIWTZEek1lWEVwUStSRDZ2OVNWYWtQaTd4dFZE?=
 =?utf-8?B?ZUpxNGRuSGhFQU1ITHJITG5BNXpJOEI1Y0NIVUtPOHBhQWc5M3YwUXFZVTI2?=
 =?utf-8?B?SGIvcnVpUUFaeTgyRzVDc05DWThkVEZSOWZIMHFmdThPeTlwRGUrMnp2Wldi?=
 =?utf-8?B?U3o4QTdKeGRxUXBTL3NaY2lIclNVSTN2NzJVc0dmREM1Q1NZdFlVMFMyYWdz?=
 =?utf-8?B?bm1CV1gzNkdYWXk0VmZVcjJkSll2eDRzelJxSTNIOU90NWpMTDIzTUdKaENN?=
 =?utf-8?B?SmZNeWczUGprbDFieFZKTlVOdFBBNDZSS1pxZ1NkTEJRbmZQNVovRVZESFcw?=
 =?utf-8?B?OEQ1bnpxOXZGaldvcWt2OU5WQVorMjZEQnhQcEhjRFpaUUthTlNObGxQYzJV?=
 =?utf-8?B?TU01cEc2a2dOTjNWOWVXeUptNnRXczI3L0xvV3VtamtlcGxjT3NlNWI3V1Rl?=
 =?utf-8?B?Ym4zTllTRk1vMTZPcmtodEFteWNra3BBN25tY1o0WU1CUVc4TzhIeWhmQ3ZC?=
 =?utf-8?B?UC9rOUVmU3loYzNveld3bVJIVFRoMUpNMmtJQ2FxODVqcFNpUjNvK3pUWlg3?=
 =?utf-8?B?ejBJMmpOSDhuWm9EaXdWVWMra1h5c1VSdGtDMUcyRFVkVWdsU1JnMEdTUWZG?=
 =?utf-8?B?SmpYWGZiQk1rdWxkeG9GUU5wVVVmQUdLOXhSb0ZoVHVtUWxJeGdrVmFSMjNn?=
 =?utf-8?B?Q3FRbnB5VThLOFpFL3o2MnZSazl6LzR2anNzMlo1d25ySW9qNGQrU3FDT1c1?=
 =?utf-8?B?Y0c3L3dOYVl2dTkrQVVSTWFEbHlSRktWRnFvTmdyUmFLSEZqYThoSWppcllJ?=
 =?utf-8?Q?OryVqlwejPxpTEGZQ7t2Q/d0Z0jp5tFu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2513.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ui9LUWxxSHY1NHoxRXhERUsxM3htU1JZY3BjcFdwdEM0UU9QVEhuK3Bac3pr?=
 =?utf-8?B?MWhkMlJWcTlUd2JMY2Fsd0JEOTlCTzhyM0FjeFFvaU9zR2FJeTRwMDhFd1FG?=
 =?utf-8?B?T0hWSFZ5MVVCNU9aOXJzUktPQ01FcWFUTzZqMFZ4MXY5WHZ6M2lEcEMzMUxa?=
 =?utf-8?B?VEx3bzV2T2JVMkZNZEg5NCtBRzJlVnNIeXExQ2dSN2x1SzlxTmxIcm94YnFC?=
 =?utf-8?B?MGNuV0FnOXl4SjEvVEpqekRXaDB2VjJBd0ozai9pMjVncXhRZlk2eU1seGFl?=
 =?utf-8?B?T0ZReWFocjlSTzNKNFBIelBVQ0s1ajhIQyttRjJjeTRZY3Z1Qm45MVNXWWFM?=
 =?utf-8?B?OERBQURnMzQ3dEFnZnM3TUZPaWdRYVRURTZGblhtVmdrM2lMeEFOdHNJMzk2?=
 =?utf-8?B?UDJpNElzN2FFN09qY2RLQ0l4US9GbDdPQWlDSzdjb29pWEVqa1hJVHV0UlFh?=
 =?utf-8?B?QjhBcjNTb2JuMmR2L0N2dFZKaHlkOHJjZGloakwreGMzTytzUEJkdGxTcXpH?=
 =?utf-8?B?NXRCdkVmL2RabTZ0U3h1eTI0WitjaEVzR09kRXcxVjhVb3FNckZiV0tROXdU?=
 =?utf-8?B?aWxmRmZhdTZSeFNEM2FaUTNCOW1JRmQ1TVlmSGUxWVRuV0dGdFNqMVZzaGZ6?=
 =?utf-8?B?b0V6WS85RXdWMXphZzlqaGQrL2d6YVFlN0xmTHZuc3FGT1pXaWJmTVcrOVFp?=
 =?utf-8?B?ZUpFK0FXS3FYOVJwV00zMTUzbnU2aVNkSG9mMzFZbW5sekRJTG1iQ3ZmLzFy?=
 =?utf-8?B?bS85WWtxd1gvb1BqdWNBZFBWazBGcURSc0Rjb0RWUHpGK200ZGlodDNDbnNQ?=
 =?utf-8?B?UEREUjVaYUNQeDkrL2NnbDdvWmEycU1CNzIwSmpvaTc3QzJrVnhuaHJib0RN?=
 =?utf-8?B?L3JKTXhhOVJsMWR2UU4yenQ1elI5c1p6c09SMVBwdGNZMUdzSVJsMHNjdzY4?=
 =?utf-8?B?RXpoaFhKd25KYTE2aC9ZL2tNbGhsbjFhYUI2T3B0WlZTSmF5R3RWY2JHaUhq?=
 =?utf-8?B?cHZDSGcrQ0Erc2ZzMGJhcWpDdFVkd3RHSDVnamxNR3grUWwvYWxJRGRMOVNr?=
 =?utf-8?B?VFR0YXFIekxJN2VYWFlQaE9RVTc0cjRraXRkT1NreUhqdFlDZUV3ZWJCVHZW?=
 =?utf-8?B?SlBFL3N3SVdyVlRWb2ZPdDdsTTdhbjJXbkRXRU1Sc2NTZGdMVmRIUXh6Q1Qr?=
 =?utf-8?B?MkRiVE0yTDNmSlZSOCtodHVuYjdPT0VyclBibm91QWFzRVQrb2JwbnRpTGdE?=
 =?utf-8?B?cnpoNzZCQ2JZOWlFbTFzZjc5ZUErU1pvb20vR2VYdzExdE5SdGs0QTJGMHM2?=
 =?utf-8?B?OGVIcWZYcXNZUEJnNUxwd2NXL3BEYjRFdlhsWWZVaXVlSDZaRjFmem5SekFN?=
 =?utf-8?B?cFAvdTFrNFdYbXVCN1Y5cC9WSXhkcVRKNTUyUGVHcnRibGpPTWIxM2VRK1VK?=
 =?utf-8?B?Q1BDT0p2R0RKVi9GcG00WlJ6ZE8zVFF6NndlTGtzc0tlTGpZZXppUmlhVFhk?=
 =?utf-8?B?TlBqbmdRbjgvOWVla0hvb1pkbml4SXNHWlA5dkxERUFuSzBVQzRVbGRWdlF1?=
 =?utf-8?B?UC9vM3BjNzE2dm5OYUpYSGNuS1FQZFMxN2NKcm9TaEc5Y1BDMU9HOTQ4dHk3?=
 =?utf-8?B?NjFPeUQreDRTVWFGVldPWVREczBzU2t2c2hiUWpuNXg4YWxobkJWYzQ2cnJG?=
 =?utf-8?B?VzRVQjV0Wjd4dXRtSDVOQm8zMGRERHpUcmZnTlFnemltQ0hLWTZVTFBpTlM4?=
 =?utf-8?B?eFJneXc5RmVrZk5ZMEROT3VweGREYXVPL2syTU1pbG5lMTRweU1ZM0RyeXpx?=
 =?utf-8?B?VGlUVUFWQmZEMzhRQ0lZY0tGelVMQWJyTGJLdGxaTEI2ZGlHa0laZTEzVlNO?=
 =?utf-8?B?cElPdlAwWEZEcUZWUFY4RlJjaEdLL1FXT3FSRXdCLzdXYjV6M0I4UUxCaVhH?=
 =?utf-8?B?bWhzMGphZHc5Y3dmTjNKc3NHODh6VmJ4ZjNCdGFuaUdweU5xaDFDSkpsS0Mx?=
 =?utf-8?B?N3c1NU5FSjF6eVVJWG1DQ0FNV0NkSGxRdGtnTVhEVDVaeDBLNHdRdlBYYS82?=
 =?utf-8?B?RjV6S1lSeG96dVAxaFk3aXIwWmFXNkNmSjFMa0tIS3JpT0ZpdU40dlJiUWVa?=
 =?utf-8?B?VzF5aVRGYmtHVjJKSklwWHNER1N3OEFINURhZ0JtTmt5NW84a3lzNkJ5R0Np?=
 =?utf-8?Q?eFKAMSJKE6SxPkFyuHEZjsk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2513.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afae2a18-c011-4a9c-722f-08dd60a7d30f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 14:20:07.3175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j9NplJFfER/ivg72Hpw2Iui6jzj2DheNhb/JFzT6JWFeoHteV0pQ5LaU48jEOGnPvhvpViZlcCMJP9USykBCBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5831
X-Proofpoint-ORIG-GUID: HoAngnyGN9g-oVLLt2bfC-B8SDTEYeB4
X-Proofpoint-GUID: HoAngnyGN9g-oVLLt2bfC-B8SDTEYeB4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1011 mlxscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2503110089

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFyYXYgUGFuZGl0IDxw
YXJhdkBudmlkaWEuY29tPg0KPiBTZW50OiBTdW5kYXksIE1hcmNoIDksIDIwMjUgNDoyMiBBTQ0K
PiBUbzogTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+OyBOaWtvbGF5IEFsZWtzYW5k
cm92DQo+IDxuaWtvbGF5QGVuZmFicmljYS5uZXQ+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnOyBzaHJpamVldEBlbmZhYnJpY2EubmV0Ow0KPiBhbGV4LmJhZGVhQGtleXNpZ2h0LmNvbTsg
ZXJpYy5kYXZpc0Bicm9hZGNvbS5jb207IHJpcC5zb2hhbkBhbWQuY29tOw0KPiBkc2FoZXJuQGtl
cm5lbC5vcmc7IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPjsNCj4gcm9sYW5k
QGVuZmFicmljYS5uZXQ7IHdpbnN0b24ubGl1QGtleXNpZ2h0LmNvbTsNCj4gZGFuLm1paGFpbGVz
Y3VAa2V5c2lnaHQuY29tOyBLYW1hbCBIZWliIDxraGVpYkByZWRoYXQuY29tPjsNCj4gcGFydGgu
di5wYXJpa2hAa2V5c2lnaHQuY29tOyBEYXZlIE1pbGxlciA8ZGF2ZW1AcmVkaGF0LmNvbT47DQo+
IGlhbi56aWVtYmFAaHBlLmNvbTsgYW5kcmV3LnRhdWZlcm5lckBjb3JuZWxpc25ldHdvcmtzLmNv
bTsNCj4gd2VsY2hAaHBlLmNvbTsgcmFraGFoYXJpLmJodW5pYUBrZXlzaWdodC5jb207DQo+IGtp
bmdzaHVrLm1hbmRhbEBrZXlzaWdodC5jb207IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOw0K
PiBrdWJhQGtlcm5lbC5vcmc7IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IEphc29u
IEd1bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUkU6
IFtSRkMgUEFUQ0ggMDAvMTNdIFVsdHJhIEV0aGVybmV0IGRyaXZlcg0KPiBpbnRyb2R1Y3Rpb24N
Cj4gDQo+IA0KPiANCj4gPiBGcm9tOiBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz4N
Cj4gPiBTZW50OiBTdW5kYXksIE1hcmNoIDksIDIwMjUgMTI6MTcgQU0NCj4gPg0KPiA+IE9uIEZy
aSwgTWFyIDA3LCAyMDI1IGF0IDAxOjAxOjUwQU0gKzAyMDAsIE5pa29sYXkgQWxla3NhbmRyb3Yg
d3JvdGU6DQo+ID4gPiBIaSBhbGwsDQo+ID4NCj4gPiA8Li4uPg0KPiA+DQo+ID4gPiBVbHRyYSBF
dGhlcm5ldCBpcyBhIG5ldyBSRE1BIHRyYW5zcG9ydC4NCj4gPg0KPiA+IEF3ZXNvbWUsIGFuZCBu
b3cgcGxlYXNlIGV4cGxhaW4gd2h5IG5ldyBzdWJzeXN0ZW0gaXMgbmVlZGVkIHdoZW4NCj4gPiBk
cml2ZXJzL2luZmluaWJhbmQgYWxyZWFkeSBzdXBwb3J0cyBhdCBsZWFzdCA1IGRpZmZlcmVudCBS
RE1BDQo+IHRyYW5zcG9ydHMNCj4gPiAoT21uaVBhdGgsIGlXQVJQLCBJbmZpbmliYW5kLCBSb0NF
IHYxIGFuZCBSb0NFIHYyKS4NCj4gPg0KPiA2dGggdHJhbnNwb3J0IGlzIGRyaXZlcnMvaW5maW5p
YmFuZC9ody9lZmEgKHNyZCkuDQo+IA0KPiA+IE1heWJlIGFmdGVyIHRoaXMgZGlzY3Vzc2lvbiBp
dCB3aWxsIGJlIHZlcnkgY2xlYXIgdGhhdCBuZXcgc3Vic3lzdGVtDQo+IGlzIG5lZWRlZCwNCj4g
PiBidXQgYXQgbGVhc3QgaXQgbmVlZHMgdG8gYmUgc3RhdGVkIGNsZWFybHkuDQoNCkkgYW0gbm90
IHN1cmUgaWYgYSBuZXcgc3Vic3lzdGVtIGlzIHdoYXQgdGhpcyBSRkMgY2FsbHMNCmZvciwgYnV0
IHJhdGhlciBhIGRpc2N1c3Npb24gYWJvdXQgdGhlIHByb3BlciBpbnRlZ3JhdGlvbiBvZg0KYSBu
ZXcgUkRNQSB0cmFuc3BvcnQgaW50byB0aGUgTGludXgga2VybmVsLg0KDQpVbHRyYSBFdGhlcm5l
dCBUcmFuc3BvcnQgaXMgcHJvYmFibHkgbm90IGp1c3QgYW5vdGhlciB0cmFuc3BvcnQNCnVwIGZv
ciBlYXN5IGludGVncmF0aW9uIGludG8gdGhlIGN1cnJlbnQgUkRNQSBzdWJzeXN0ZW0uDQpGaXJz
dCBvZiBhbGwsIGl0cyBkZXNpZ24gZG9lcyBub3QgZm9sbG93IHRoZSB3ZWxsLWtub3duIFJETUEN
CnZlcmJzIG1vZGVsIGluaGVyaXRlZCBmcm9tIEluZmluaUJhbmQsIHdoaWNoIGhhcyBsYXJnZWx5
IHNoYXBlZA0KdGhlIGN1cnJlbnQgc3RydWN0dXJlIG9mIHRoZSBSRE1BIHN1YnN5c3RlbS4gV2hp
bGUgaGF2aW5nIHNlbmQsDQpyZWNlaXZlIGFuZCBjb21wbGV0aW9uIHF1ZXVlcyAoYW5kIGNvbXBs
ZXRpb24gY291bnRlcnMpIHRvIHN0ZWVyDQptZXNzYWdlIGV4Y2hhbmdlLCB0aGVyZSBpcyBubyBj
b25jZXB0IG9mIGEgcXVldWUgcGFpci4gRW5kcG9pbnRzDQpjYW4gc3BhbiBtdWx0aXBsZSBxdWV1
ZXMsIGNhbiBoYXZlIG11bHRpcGxlIHBlZXIgYWRkcmVzc2VzLg0KQ29tbXVuaWNhdGlvbiByZXNv
dXJjZXMgc2hhcmluZyBpcyBjb250cm9sbGVkIGluIGEgZGlmZmVyZW50IHdheQ0KdGhhbiB3aXRo
aW4gcHJvdGVjdGlvbiBkb21haW5zLiBDb25uZWN0aW9ucyBhcmUgZXBoZW1lcmFsLA0KY3JlYXRl
ZCBhbmQgcmVsZWFzZWQgYnkgdGhlIHByb3ZpZGVyIGFzIG5lZWRlZC4gVGhlcmUgYXJlIG1vcmUN
CmRpZmZlcmVuY2VzLiBJbiBhIG51dHNoZWxsLCB0aGUgVUVUIGNvbW11bmljYXRpb24gbW9kZWwg
aXMNCnRyaW1tZWQgZm9yIGV4dHJlbWUgc2NhbGFiaWxpdHkuIEl0cyBBUEkgc2VtYW50aWNzIGZv
bGxvdw0KbGliZmFicmljcywgbm90IFJETUEgdmVyYnMuDQoNCkkgdGhpbmsgTmlrIGdhdmUgdXMg
YSBmaXJzdCBzdGlsbCBpbmNvbXBsZXRlIGxvb2sgYXQgdGhlIFVFVA0KcHJvdG9jb2wgZW5naW5l
IHRvIGhlbHAgdXMgdW5kZXJzdGFuZCBzb21lIG9mIHRoZSBzcGVjaWZpY3MuDQpJdCdzIGp1c3Qg
dGhlIGxvd2VyIHBhcnQgKHBhY2tldCBkZWxpdmVyeSkuIFRoZSBpbXBsZW1lbnRhdGlvbg0Kb2Yg
dGhlIHVwcGVyIHBhcnQgKHJlc291cmNlIG1hbmFnZW1lbnQsIGNvbW11bmljYXRpb24gc2VtYW50
aWNzLA0Kam9iIG1hbmFnZW1lbnQpIG1heSBsYXJnZWx5IGRlcGVuZCBvbiB0aGUgZW52aXJvbm1l
bnQgd2UgYWxsDQpjaG9vc2UuDQoNCklNTywgaW50ZWdyYXRpbmcgVUVUIHdpdGggdGhlIGN1cnJl
bnQgUkRNQSBzdWJzeXN0ZW0gd291bGQgYXNrDQpmb3IgaXRzIGV4dGVuc2lvbiB0byBhbGxvdyBl
eHBvc2luZyBhbGwgb2YgVUVUcyBpbnRlbmRlZA0KZnVuY3Rpb25hbGl0eSwgcHJvYmFibHkgc3Rh
cnRpbmcgd2l0aCBhIG1vcmUgZ2VuZXJpYyBSRE1BDQpkZXZpY2UgbW9kZWwgdGhhbiBjdXJyZW50
IGliX2RldmljZS4NCg0KVGhlIGRpZmZlcmVudCBBUEkgc2VtYW50aWNzIG9mIFVFVCBtYXkgZnVy
dGhlciBjYWxsDQpmb3IgZWl0aGVyIGV4dGVuZGluZyB2ZXJicyB0byBjb3ZlciBpdCBhcyB3ZWxs
LCBvciBleHBvc2luZyBhDQpuZXcgbm9uLXZlcmJzIEFQSSAobGliZmFicmljcyksIG9yIGJvdGgu
DQoNClRoYW5rcywNCkJlcm5hcmQuDQoNCg0KPiA+DQo+ID4gQW4gcGxlYXNlIENDIFJETUEgbWFp
bnRhaW5lcnMgdG8gYW55IFVsdHJhIEV0aGVybmV0IHJlbGF0ZWQNCj4gZGlzY3Vzc2lvbnMgYXMg
aXQNCj4gPiBpcyBtb3JlIFJETUEgdGhhbiBFdGhlcm5ldC4NCj4gPg0KPiA+IFRoYW5rcw0KDQo=

