Return-Path: <linux-rdma+bounces-2636-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBCB8D1F42
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 16:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D31F1F21B52
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 14:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B903317083D;
	Tue, 28 May 2024 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kKfwVuVX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147C016FF5E;
	Tue, 28 May 2024 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907873; cv=fail; b=mwcQs1yH66ZeBJwEh/00s+6LyCK+xU9D1oIpuf+U3VDk6+dvd2Z/sP3BpDbBKxaYYgJi+G+qZJtjO0DTgA2SCU/q0FD34+JI75ymm9k3QpzG2hcGLh5g2M/8OWlPRR3at+CCrchqUDUeg10WBw+KKY3xGTvPJh8GdwjZ9UtMBL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907873; c=relaxed/simple;
	bh=oHfDBaVeMFmYl3sbutifmKyaIzjHcvdRZQ0gvAQfYsE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=twAPmGytRDeGlaLhy558CK8fF0EXc733NbLcD/ZtLLvR6CFH1rBEcUZRyDuzrGAT5UIWpJusAL0GY5aBqqSGol01sDozumjDB3gfLC5SJ8N8BYDxOFay/j4c/LsjHNuZacaeAHiwa7kUch1FKBRqV2rGOvoXo53ScH5zeK7olJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kKfwVuVX; arc=fail smtp.client-ip=40.107.102.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G67VEcuDuXXF2n0qywqF7tjdZx7bxpqKomqu/NTYbMI1prspIacLNI1vjTU+HoulACblEMAXFyVP8HOWIIPx+N+8HszNsYMpORczSTD6wP2pGGqqjR4qP06LkiebzO7e4UI7a+nMvwkbtpdC3fOYfBNBxhu5fqJCkU32ldEzHnGGYoAJZZF9vHDtdRcsElWHMtvO8wePZcwjNlipUw1mzEQZ069guApgkk/kfw3942LnVU+0prq6lsaMRtvrSLvRKkWDdommIsCf1atYFDMJ3Pk+YVZVVDgCbRpW0/9p2cdgbpnBEyfKICu0XWujqopLd2etYF8lHv08R8aZ0/nt2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHfDBaVeMFmYl3sbutifmKyaIzjHcvdRZQ0gvAQfYsE=;
 b=FgWy2fBNj4494uimG4pGoYdtGDilIl0MWSA0Scil4avvRVxQll4bKDOs7RS0BfB3c7Qjn73b4NPD8WOdUHQALUtSc59F2oVYZZL5/jql2CCufO1chWMZcGIVXz9gdSmESWWsOAQ0TNi4O8kPt4Xi/POWaNPa+qyd+OnwBif39d/Czy9BIQzpibs6ChIEjvj52M8C384dPo+ONqF4QxX6lb1BDPx7Ibe6QIbCpxty7kz3ptmh94QjjHg2Z5eZGrHVrfWFgUJ7ndSlhIIqCuNkoAjmlXVlNgMjcEwjL/nrHkpHnimMVMBtE6n8IzYv9L3mIh0rKWGRrelR+4UEnHv7MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHfDBaVeMFmYl3sbutifmKyaIzjHcvdRZQ0gvAQfYsE=;
 b=kKfwVuVXy9jHF2Y/Cn88N+PKoh516002Kjf+jJ2ne4vW7G38HiSe4D+YfRLRsoEe8/i1/fM7Hfa7Xtm1/DGIxQji3rxhikd1uKNbQFNjt3RiPsEct9TiTr6hTJCmoy37k1tIHwKA+PDe1bgjrxWcr6ghWzV/p99ApnBdKHkayAzsBI0FHeZMODtVznRxCfXcz0VCh+ujp5mmdpISfpOCK/M8k9zi+kUhJGPcL6MshH0DxYH1ND36AkCNn47iLohYqooF8I7qO6VHAKWljBHVLMoXz8bceiuBI0OsjHj6xps6Vj/kRJhIoaZZBD9uNCt4LEBIDHgl6e5jwQlloJ9Gww==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 14:51:08 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd%3]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 14:51:08 +0000
From: Parav Pandit <parav@nvidia.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Shay Drori
	<shayd@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "david.m.ertman@intel.com"
	<david.m.ertman@intel.com>
CC: "rafael@kernel.org" <rafael@kernel.org>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "leon@kernel.org" <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>
Subject: RE: [PATCH net-next v5 2/2] net/mlx5: Expose SFs IRQs
Thread-Topic: [PATCH net-next v5 2/2] net/mlx5: Expose SFs IRQs
Thread-Index: AQHasN9SyiId9qz1h0ebRlD2zBAaibGsulMAgAAAg3A=
Date: Tue, 28 May 2024 14:51:08 +0000
Message-ID:
 <PH0PR12MB5481E8C0312FF6A6231F5E26DCF12@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240528091144.112829-1-shayd@nvidia.com>
 <20240528091144.112829-3-shayd@nvidia.com>
 <fb037803-0002-4d91-9c9f-bbb233490acb@intel.com>
In-Reply-To: <fb037803-0002-4d91-9c9f-bbb233490acb@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH8PR12MB7232:EE_
x-ms-office365-filtering-correlation-id: ede79317-bb0e-4b9a-923e-08dc7f259bef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|366007|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?VUM1aGtyd2RVNVlKVVNXZVdHUys4aTFrUUFFMG10andSUW11YzV1R2pOTVo3?=
 =?utf-8?B?S0JDMXVqRXNHTXppSjdSM2YvWjZkVEkvZkhPbVNCVGhFZ3dBSG1zZ3Ezcm5n?=
 =?utf-8?B?ZjlGK21QakllRTU1dkpTR1VmZ3VDdXV3MWJTTkFENU9UdjhMa1NEQ09Ob3lF?=
 =?utf-8?B?T1I3WXVzS1JkSG00bkN0dGM2VXZISTdNT2ZoVHR2RnhneUpya0pHK0tNSlk0?=
 =?utf-8?B?Y0lldWFoYzZKTFdFdDdRanZFUlRuUHdNMUFnUHpuVHV4K1EranFoN3ZWaVNQ?=
 =?utf-8?B?Y2x1TWovd3E1MDlaQXdabTJKUEhnU2NiYWJTVWRKREN6V1hEb2xRR00xL2Rp?=
 =?utf-8?B?NTY1d1ZNZkZ1YWJ6bHppb2svcnNEU2lWVHAvOGpPUWI2VGI4WFJ1Wk95Z0pD?=
 =?utf-8?B?Mk9vZlBTakxrN1ZUaFBlU3RxRzc3ZnBWcHNDZkQyejdJQjVZUTRiWlZwam9h?=
 =?utf-8?B?ZzZXcjE0Skg1aHU1eUdPd1ExQVdjYkV1bTJhNDZueGh5UU4rZlZPVFROVU5I?=
 =?utf-8?B?aStzWTZpWkcySFNMdmNwaUhXbG1hUTdKMnh4T0pXMkE5M0IwYlJxNGhmb2lx?=
 =?utf-8?B?RmZLM3JDcU9IUWJ1dHUrdmZSZEQwckJ1WWhiWEt6a2ZZSmk4d213OElGaXVC?=
 =?utf-8?B?aWdMN3pjMUUzL3QvT09lRWtrbEpIakVhMUwzdW5nOGlMVm5HUnloM2JsWjIv?=
 =?utf-8?B?eUNwZmhDZXlxM0dvRFR6SkZ3aU9zNHFDNkdWdnkzcVRUMEphK0NyUjUycWJG?=
 =?utf-8?B?VTRlWVV3ekExUUZFdElmbXBUY2FqeDl2Y0RKL0MwOHJZU000TTNPTURlcE0x?=
 =?utf-8?B?czEwb3FyWEZsaWtObFM1bG0zK0V3WE9xa2pFSEVkVDVaZXhTaUhYd1ZmTWVF?=
 =?utf-8?B?RTZaank0M0VQODV4elFEUDNwQ2RGMHdtOHZ0SFFnejhGZ0Fia25GSEpWNmRH?=
 =?utf-8?B?N2JSVzZ4bFFKTUs2aEFjcUhOWHZLMGlxaklrUEZwMUlrTXFKN3lsZjRCd3l4?=
 =?utf-8?B?cFdvNWJLMVhpWUFiUTlWcXFCRjhJM0N6WmcxclNqaHN5aFVUc3JIaVp4Z2k5?=
 =?utf-8?B?bTFsU0JkSmRhL0VxaTE5eXVzQ0FHUk1YREtMOWN2NzNJNDJrSHlGMzNtUll2?=
 =?utf-8?B?aHg0UU92RmhPZWN3dGI1N2UycXZpUjMzUDNsY05yeGZHUGdYZUo1Wk1ob3pX?=
 =?utf-8?B?eTh3c0h4NG92djB6V2o5amhNMmsxMGRuSERXOTF0YVJxMjJwNy9rS3ZxSWt4?=
 =?utf-8?B?TWZrWFJNcDdIU1BnL25HaWNabTVwRkc4eVhBcTRuK2F1NXplcnNZMndNL3pu?=
 =?utf-8?B?RFBmRnhPOTJqSUVtQWF0ODFXaUdITlo4RHk5MzZUcVJaM0JJTjB2VDNkQmk3?=
 =?utf-8?B?STAzVmZ1SUQxd3Z5a0VqaXFjeGp3OGFoRTdYL2FFK1VTOEFKUWZLSm1mTGNh?=
 =?utf-8?B?NTdSYXBZanBQRkcyM1V5bmVJQzJyalR1a1NrSGpPNmlWZEpYZDZoemY1ODJw?=
 =?utf-8?B?TnZhSFBtNWdrTFo0ZGV1SzQzUkFiQ1gwenlXd0dkTFltZmxnNEg4TkJINUJH?=
 =?utf-8?B?NFNCQmtCTGtHeCtMNEhCN1dSMFVoY0NPVEwzbS9abElrS1hCcmxpZXg0ZzdX?=
 =?utf-8?B?NE9QL1FRT2RHY3pEenpOWGREWGlEUVZyM21TYnY0Y3loZHlUVlhESkxMU0xR?=
 =?utf-8?B?NFhrT0NXMU9jaGtRSFFzT2JQU2F3S2dtUGZ2RUg3MTNxcFVuWGtxMzZKd1Ay?=
 =?utf-8?B?bkRqUVB5ZGFRZjlrZVJQVTRjTWhvOHUyTXlJL3JxcGEybFJiSEVOODl2QnVB?=
 =?utf-8?B?YldrRTkybGN0dUhZWHZXQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXBCdGp4M0JITitFNTJRcDlVU0h5c3d1ZC9XbUxNSHdCSTBOMThkQ1V1TUl5?=
 =?utf-8?B?UllQQ3ZuWGFvWjlqYUoyWVAwdnRWSW9neHZSK0NSaHB4QTcxVkRHTFZvRlN4?=
 =?utf-8?B?VWtsMGQyRGV3MEppVUsrU1UyTWxCSGRsMVpRNHJpVVZ0cllkOCt6Z3pEbGpx?=
 =?utf-8?B?VlZFRXBSTkdCK2hBRG8zRGNUbFplL2txcmhnOCtoTXFUNjBNSjhBdFpOU2Vt?=
 =?utf-8?B?ODkwVkdCNDFyUXBMNHA4enJlY1hFT0EwK242Qldwc21PWlpnZkRhb1orcUVn?=
 =?utf-8?B?YlJGUU1JMFd0OENFcGtsblNETGxUdWR4YnlEREI3d2hORDJvVXZPUzJVR1M0?=
 =?utf-8?B?TXdjeEVUd1VVdlhZcXEwa0tMY2ErbDZ0aE1pQ1Q5YXZ1R3BSaThoem1JRU1x?=
 =?utf-8?B?dWdzUTNZS1NkYlBUMmVkNDJ0eHJHT3ZndmE5Skh6a0tBV09sS21RZThTNnp3?=
 =?utf-8?B?WkNraEpaZWxURGdKWTVHKzRYMFRPSS92WTllYzhZcGtaRlY3bGJZQUdnV1pL?=
 =?utf-8?B?NGhFZmlnUldQN3B6blM5RFV6YS8vUnpBeU1xMTVHYVM1VE4rZVRIcDJZMUxU?=
 =?utf-8?B?dXZFNTJoWU9zWm5iTGs5R0d4ZmRjbVVncUZKaFlHSXRHMWdZOGxURkZNUTBB?=
 =?utf-8?B?ZFIrNUx5STNEN0MrSkJGdldXUC90c2dhWk1DazMray9WT0lyOGVHUWpaOFhx?=
 =?utf-8?B?eGQzdnlva1V4Q09EN3M5cndlQWIvdFN4aFJyTWI1RURRUlBycUZkbDlFL1d2?=
 =?utf-8?B?MDlUUllsRG9ZWFhZRG9Td05kbWhRdEg0aHVyQ0Q1WURXeGU4UHZXTEsxM1Jn?=
 =?utf-8?B?cFRCRGcxS3A0dVRGenhyaGNLS01WTHRHWExKbTg4cFVidkc3Z0FRZXRiRGlT?=
 =?utf-8?B?SDNwWkV3N0Q5VGlTRW4yM0k5QlNJTnlBL3NKS1Y1ejJ3SUZrVURWeU50MW9F?=
 =?utf-8?B?bFcyMlpqNVJqRzVTT2h1eEFsMUdrdjM5THNVU3RTckJudkpzWG9xejd0OUZ3?=
 =?utf-8?B?ZlVhZnNwK1NEUDFPZHRxYmVlSjUwOUxvUm02OWRKb0pKc01pdmUzb2J4c3N4?=
 =?utf-8?B?UXNFTzRyeWszR2M4cjNOdEZFK3NqcThxL0hXeGw5eDVURXkwYTFUT1JsTE91?=
 =?utf-8?B?VmVGc2FwbmNlOGtENDJmajRic0gxSTRvQ01HT0w4ck4wZ2lJcC95Tml2Yncr?=
 =?utf-8?B?MkZSQi95Sk1ZVEVVYWx4bHl5Y2RINDV3YXpGVE11cGU1bHZ6ZUFpSjI5cnJI?=
 =?utf-8?B?T2trMWlEZkRiU3V4dzVjeEVsRDk5TjBaMFNIWC8vc05sODJuS2d4S2lMb2pF?=
 =?utf-8?B?eTRpdmkrYzZ3UkJiU1hreXlYZklUdGs4TksyN1RvTEVteGhReUtSZTN1enNB?=
 =?utf-8?B?dStWb3JOcENDSmNMMzVMc0xZK3hvRUVBUERHQlNFMVJJaHhsWWNhd1dBcE1L?=
 =?utf-8?B?dzdxR21aek5lSHh3d0djd3A3endpa010d1A3Mm1BZ3Q2ZlVtdndZWnNyOU9E?=
 =?utf-8?B?VFdZdFpUa256L0N4YjNrTVRvT0xnMjJ0QTJQM0xPZDkwMzBJNklIWEp5NmFk?=
 =?utf-8?B?L0VxQ3BoVTJzZW12ZzIvYy9SM0JjR054NmVkVzNpUGJvcjhlRWIvN2srZnZY?=
 =?utf-8?B?S2U5WS84Vm9YRkhpN2p5Q1BNSldxdDNYWE93dEtHWEVGM1F1VlExUUJlWmE3?=
 =?utf-8?B?V1pncjFTdHh4WDlYYll1TE5PbzA5MkZzVE8vU2gzS0FFRlMyanNRbHFlNlk1?=
 =?utf-8?B?UjE1UWV4TENLVFo0VmN0SDJBNXQwcUNCclZmQXd6MVFNNVVqTloyQUdYL05F?=
 =?utf-8?B?MGhzZkJZOUdlalM1Vk4wMCtWMytZZ2VROURDaDVmVEJyc1dSQWNEenBwWHpD?=
 =?utf-8?B?WmIxc1ZaeFJuOGdvMjV0eXJTVTFKUCtERVY2Vys5cVQzdGR0SDJ1MzZWVUsv?=
 =?utf-8?B?UWhvVkdtZ2VwSlY3ZmU0Rm02SkZqRC9tT1ZQckR1OVMrT3lraWNxOGRWb0Vh?=
 =?utf-8?B?RXZkZXhzS2pWL2lOVEdSOHlwWW0rNlE5TjVlT3pwRVZnYTVSeUxvK0VYSU01?=
 =?utf-8?B?QUFhbnk1YmF1aUxMTHN4U1pXRTBqYnRVWitUaWg3NGZTRW40dS9CNDJGcHRw?=
 =?utf-8?Q?o1jk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede79317-bb0e-4b9a-923e-08dc7f259bef
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 14:51:08.6029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w4autIu+R7uNgsLrlb87aY2/NJwEoB/k0PdLWxD92oWSsEMncuwWLqTqBI6aIUONo2zEG8N2U1Mhg4vro7+6Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232

DQo+IEZyb206IFByemVtZWsgS2l0c3plbCA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT4N
Cj4gU2VudDogVHVlc2RheSwgTWF5IDI4LCAyMDI0IDg6MTggUE0NCg0KWy4uXQ0KDQo+IG1seDVf
aXJxX2dldF9pbmRleChsZWFzdF9sb2FkZWRfaXJxKSksIHBvb2wtPm5hbWUsDQo+ID4gICAJCQkg
ICAgICBtbHg1X2lycV9yZWFkX2xvY2tlZChsZWFzdF9sb2FkZWRfaXJxKSAvDQo+IE1MWDVfRVFf
UkVGU19QRVJfSVJRKTsNCj4gPiAgIHVubG9jazoNCj4gPiArCWlmIChtbHg1X2lycV9wb29sX2lz
X3NmX3Bvb2wocG9vbCkpIHsNCj4gPiArCQlyZXQgPQ0KPiBhdXhpbGlhcnlfZGV2aWNlX3N5c2Zz
X2lycV9hZGQobWx4NV9zZl9jb3JlZGV2X3RvX2FkZXYoZGV2KSwNCj4gPiArDQo+IG1seDVfaXJx
X2dldF9pcnEobGVhc3RfbG9hZGVkX2lycSkpOw0KPiA+ICsJCWlmIChyZXQpDQo+ID4gKwkJCW1s
eDVfY29yZV9lcnIoZGV2LCAiRmFpbGVkIHRvIGNyZWF0ZSBzeXNmcyBlbnRyeSBmb3IgaXJxDQo+
ICVkLCByZXQgPSAlZFxuIiwNCj4gPiArCQkJCSAgICAgIG1seDVfaXJxX2dldF9pcnEobGVhc3Rf
bG9hZGVkX2lycSksIHJldCk7DQo+IA0KPiB5b3UgYXJlIGhhbmRsaW5nIHRoZSBlcnJvciBieSBs
b2dnaW5nIGEgbWVzc2FnZSwgdGhlbiBpZ25vcmluZyBpdCB0aGlzIGlzIGNsZWFybHkNCj4gbm90
IGFuIEVSUk9SLCBqdXN0IGEgV0FSTiBvciBJTkZPLg0KPiANCj4gPiArCX0NCj4gPiAgIAltdXRl
eF91bmxvY2soJnBvb2wtPmxvY2spOw0KPiA+ICAgCXJldHVybiBsZWFzdF9sb2FkZWRfaXJxOw0K
PiA+ICAgfQ0KPiANCj4gWy4uLl0NCg0KSSBjbGVhcmx5IHJlbWVtYmVyIGRpc2N1c3NpbmcvcmV2
aWV3aW5nIHRoaXMgaW50ZXJuYWxseSB0byBlcnJvciBvdXQuDQpXaXRob3V0IGl0LCB3ZSBkaWRu
4oCZdCBhZGQgdGhlIGVudHJ5LCBidXQgd2Ugd2lsbCB0cnkgdG8gcmVtb3ZlIGl0IHdoZXJlIHRo
ZSByZW1vdmUgZnVuY3Rpb24gZG9lcyBub3QgZXhwZWN0IGFuIGVycm9yLg0KDQpTaGF5LA0KRXJy
b3IgdW53aW5kaW5nIHNob3VsZCBoYXBwZW4gd2hlbiBmYWlsIHRvIGNyZWF0ZSB0aGUgc3lzZnMg
ZW50cnkuDQoNCg==

