Return-Path: <linux-rdma+bounces-2930-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E7F8FE0F4
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 10:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B88A0B21707
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 08:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B7113C695;
	Thu,  6 Jun 2024 08:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="j365m8Bb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2092.outbound.protection.outlook.com [40.107.15.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEAB364BE;
	Thu,  6 Jun 2024 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662612; cv=fail; b=f3Gfa36R5ID/QsW/34Qt3RAJUf88F1GMXmJFGqlJupRE2dCxS+biljkinGTrahB0UK+8g00OAKBkV3l8xMZo4ldSS2L6NbvRTJxXJTubAoar+tdCjtRyyV/uZDDiIX5Nu8icO/xenp0JejsRYtl6GqumzMWGrD1XIOoWDFz7h48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662612; c=relaxed/simple;
	bh=vnGCpLPYZa7nO/WNBWFSrBwl4CTuFWO3O3zlR40CD8o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=moRjRwc+KcAyqnJ0FEMHyFu4XZkuDmI8GNtzL94Y2o9598+jb8zp6GqwoYI1vTCfFFf17+iOFInVa4RmvEuzvM8CVIX6+XNn8aKDzMWZISu55jKIfPRyYeQvfuEka5tRod5f98hxjaEUQvKSt+zMy0h+Z9MjNFbyvqTfgAcU5ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=j365m8Bb; arc=fail smtp.client-ip=40.107.15.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYweoK1Iq+WYaTY9AevwBGOHuOSgj1ze5ejF07vvj8peuCy0C/nRmkA1w1qUBlLXvXnsHh4HE+d+77IKILYzIwPFPQpllTK0y8/SjzC35UUQpY5Z0Qf2ap+PcsWVXkgGu8+qJP0hZcW/Rt8jKjJmQkDIgiHzlIeGAe4VTw7ve9y3Z73DZ5dBj2EHE16KFNgJPeVZOYjO8vGWniVcTxB+y9wysRbTFEakIIeHHFhQdg34vvOGSNwORado6BbF49aINeHAwKYlnjQ2kMWzHeaBkwjAKG4W+ucZRMjcaLhqeDCMLll8y0GI+J2vSoOJFMZxATiYS5/SDxGrvTOwzC0O3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnGCpLPYZa7nO/WNBWFSrBwl4CTuFWO3O3zlR40CD8o=;
 b=G0FON9bTf9KcDwAwYDHiIpGIFBz54gluyNUWNYKzT8jtdxiTAejCAhOaGib57qgfuBHlBgCT9SbGBRUaqe/GmZfWzqJVIM+U5lNfCyx7w1Ur29I0BrQIAJBLB4r82nUouMPn6YwdULWo2dRhrXRSQRRl6fdVimzFkoRYlSxZfeLhDb/s7fvBc/U5faRq9jX2lq8FzKAdEArDCGl4vMJd79tYcJI2+Tn2EOyFN+tfTbkgM2e4zMNPGyzPM0JzVEqlElU4AA1G/iJvQ/sxHad8GMJkJXd26IpPXNPsv6UNPBPH20qiD71FwyFfZCsBymCt53eTs/BfyFmJSYYS1im0KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnGCpLPYZa7nO/WNBWFSrBwl4CTuFWO3O3zlR40CD8o=;
 b=j365m8Bbu7wMuLDT5mJvZYrgkoJCngfSymGZuNqSrJPcl+VhuJEZhUIDbS48aORKIP67XIIhX4olnGug+ewLkPQ0U2hy1WDgGgRYyTbfeNZnCnWYiQxRSrlY0Gg6QC32p/KB0m8Nnmtq9MNl+ZDF4uidvyY/oRFXa+BAk19OJOw=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by DU4PR83MB0679.EURPRD83.prod.outlook.com (2603:10a6:10:55f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.7; Thu, 6 Jun
 2024 08:30:07 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1%4]) with mapi id 15.20.7677.007; Thu, 6 Jun 2024
 08:30:07 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Long Li <longli@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] RDMA/mana_ib: ignore optional access flags for MRs
Thread-Topic: [PATCH v2 1/1] RDMA/mana_ib: ignore optional access flags for
 MRs
Thread-Index: AQHatyClgMeOXlHnCU61xc9TFQZVOLG5vTcAgACqvZA=
Date: Thu, 6 Jun 2024 08:30:06 +0000
Message-ID:
 <PAXPR83MB0559158B879C008258BC7B6AB4FA2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <1717575368-14879-1-git-send-email-kotaranov@linux.microsoft.com>
 <PH7PR21MB307116D097353657259A7BB1CEF92@PH7PR21MB3071.namprd21.prod.outlook.com>
In-Reply-To:
 <PH7PR21MB307116D097353657259A7BB1CEF92@PH7PR21MB3071.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fd62b7c4-c936-4e68-9d76-f103e3a31ac0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-05T22:09:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|DU4PR83MB0679:EE_
x-ms-office365-filtering-correlation-id: 4a0d1dee-163d-4686-d7ed-08dc8602df0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?bG5HamRDTkFsUmpzVkhoT3BmTVg1d2tnakFyUFY4Sk5qN05Id3FvUkY2eGl3?=
 =?utf-8?B?OVR1cUN0RU5jVW8wSWFRWk9lSGVlVDNlQWhTRjI1cFM3ZWNvUzYrV0FaVGFq?=
 =?utf-8?B?WHEvZDcyYmg0NTRVMDZDanNCSDdzNUMxbGlFWnVPMnpSV01HcDlKamRTQ1lt?=
 =?utf-8?B?dWs0bUszYzNldkV6TEVEMkRUVnpieElsOGdLb0xoajZMa3dWNjVkZ0VvZ2o1?=
 =?utf-8?B?OUtGTE9yUVVReVhUbElMY253cWd2Mmw3Qi80L1RJZW5xY2NDT2F5cG5aV3Nq?=
 =?utf-8?B?bm5IOWN4aWcrN0pJVXg1Q09Ja0tscFpRUHlqd09CN2NiVXU1NXNaYXA4WUIy?=
 =?utf-8?B?cXZXVG8yczFrQVdJVFBSNzd1RGpqSXhaL1FqaWdQRG1WN0xUdEFaMFNxdG04?=
 =?utf-8?B?TlBWVGZpejNtSGQ5QXRrSnBWZ1BFaEdRZDZXUWIvK3Ywc0IyOVJBMUdrNFdo?=
 =?utf-8?B?c1QzSmtOV1hxTXovUVQrc2tKTFlwc3BoWWhTWXJnV1NpNzdleTlRck9nV3V3?=
 =?utf-8?B?ZWQ2Y1I2UmFXMXNwYURxQjVpR0FqaGs2Qmh1R1JaYXVyalRGTjh3NVgwK3RS?=
 =?utf-8?B?UE83R09Pd3diZ2hCdERYMWJwUmVNci8yS0xTc3JaWVdHNkI2a2JHd2ZMcVNh?=
 =?utf-8?B?YmFCbTRYL3hmRU5UZnRQY2IwNE1veWRJR2puei9iWk44eWVkS2N5dVgwbUtQ?=
 =?utf-8?B?RnVtRTJBZUErSlFjejZhL3pYc3grbnFhenZKK05HZkxiQjVnNjA1bjhzWm9D?=
 =?utf-8?B?WjlGclRPRVJ2WCtPOStOTlNOUmFHLzIvbU82THVQQlBHcDRNNGdrTjRRbzZM?=
 =?utf-8?B?UkNSU0p0SnltYzhBRXhHbFkxTmFOSGtmcEordjlxV2V1WnFxZERzemZxSml1?=
 =?utf-8?B?aitNOStOaFVQcTZkYm0wWGZpV3Z1dUh1Tnl4VGhQTi91d1dsSG85cTBJRXhs?=
 =?utf-8?B?WkJIKzhrdXpUd1VHK0tTRHdXL3F5Z2lzdGlzWnMzampPNWh3bVRPTmE4cjA3?=
 =?utf-8?B?NzhnUEk4RkR3TVdqM1plS2hxazJWQ2o3b3FEdTdVK3Q4TXRZL3o5b1VrN0Uy?=
 =?utf-8?B?SVorQXNuQ1Fxc1RuWTA5YVFGaFczYjc4a01CRzh5ejZBcUFHZjMvQUFRVDdJ?=
 =?utf-8?B?eWdRWG5RbE1ZeEdNM2NwaURWLzlYeG00aFljTzNoT3dNNC9hbHVvQWtoVG52?=
 =?utf-8?B?TmtQWVdwUEFTaFpHSkJFa2hMcFFWUFpOSWVTN3Bkc0xNNFBMa2hFTE1qS0Zq?=
 =?utf-8?B?WTdNV3FaSWJaQ0ZoaWRuRG1YcHFSQXgrWjRRYmNDWFFHQnNWZnFtQml5RXUw?=
 =?utf-8?B?a3NXRktnVzRHbDExejF1VXBrRGpHek4wcGFCOE1CL3hRME1ld0Q0OUJWU2ZY?=
 =?utf-8?B?NlZWNEp2S1FRVjFKSmNralM4TlFORXRXejFpMkNmTUxhQ09UZlFJTXlRV1NH?=
 =?utf-8?B?N0t1cWZVUzhtZDNVM3FNNmZxS3AxdzhhMjlpMUd5V1hQUmRCcGZmdlJhM3Zs?=
 =?utf-8?B?azcyZTJZbktPWjZxcC9vQkd6ZVkzVWZWWFBxVmdnOW1LOS9lR2xFNi9yNVAw?=
 =?utf-8?B?cnpSOW1LWmZURU5rcjZuV2ZMay9Icm9xWDJ5U1RlQlluZ1lURU9jVHI5M3Ez?=
 =?utf-8?B?em1zV1FldlJCNEJiSWdhQXRlZk1VM084TnorY2dOUGJLZnUrNEl3Tk1NMlBi?=
 =?utf-8?B?TGFvVUgzZmxRNno3SWZFSURJc2JlbWpvcmVObXhmR1hSZlhJZFRzL25tTmJ4?=
 =?utf-8?B?M2Jyclp5bHZSSlN2NWJBaTBodnZPTmhxTi9vQlhGaHBCN1NGb2ZoY0NtWmFs?=
 =?utf-8?Q?GIUbmFbi79XKrxpbqm3gCd7UR0uKRMz8j8WSk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QS9JNDM5cVpZRmxNWDFTV1JUNGllK0NmME93WFhSaWFiaWFzTlc4WnEvR1NY?=
 =?utf-8?B?d0syNGZTcDdnN0VTeno1WjYvS3pueTlsZ3dBb2NEU2w3MDVWZGx3b0tNU0Ry?=
 =?utf-8?B?R2o4c04vU2J1c0xjQWMxY2QvR2VMNkt3Vkt0dlBhSGIxWkZuYWpSTm9FVmZk?=
 =?utf-8?B?RWluUHN3b2JoVlN3MnJ2czhYTkxGQkZOa2s0S2N2SFpMY21CSkcvaHdDWU1R?=
 =?utf-8?B?SEdTQVF4RmQ0eFlsQlZYNDRSNWtsaGJic2lJQTJnMVp3amF2NkJKS2FBTmUz?=
 =?utf-8?B?aDZIalV5VTJ1TlYzZDhqNUFkYTQ2d2EzS0NRZ2J1SEhkTm56VnVEd09XTlh1?=
 =?utf-8?B?NDdaVzl3ZzFPeVdQTDNvejNod3F1bncxUVlzaHBTQUdsRVZJNHFvMDJDMkJC?=
 =?utf-8?B?ek9vamkrNzdUU1J3bnNCY0JMUkR5NWgyZ1NCenlPdEtTeHVac3JoUTUrQlF6?=
 =?utf-8?B?UmRRT21LVERGRkt4WDVlUVpaTzNPSkhnNlc0bCtyWGhPOWpXYnBhYTFtSEFX?=
 =?utf-8?B?U2hSRkVLWEZHSjJOOVFqUmFYZXFVV1l4UFdZdzh5ZGlOUzRBbm1IQlYvb0xq?=
 =?utf-8?B?NkVmdXZ2U1lLNkVjeWhuVDN0N2ptQWhWTTFjVmJMNGpyRlZqaVd1WXN5eEpz?=
 =?utf-8?B?ejV4NG9WVmw4MStkbDR1aWdobEM1STlhbUdBY2tFeE9SMGxxVFlXbDZzcXZn?=
 =?utf-8?B?ckhmQnNrUkRoL3pMYm9pU1Ayczg3U0NYZ0dJa01zeUNNTW51RUF5eEZ3dTFz?=
 =?utf-8?B?NnZFYmlIRHBtTHRhdkRvTzY3ek93ZmM4c3I0UzJTaW5OWGtIdEIwekFMRXRW?=
 =?utf-8?B?b1J6R2psUE8rQ0VWNEtrZ0o2ekdjWkFRRFdKOWI3VVI5RW5ianZLRElLMU9p?=
 =?utf-8?B?OHdjakU0M09KWkF4NE5CM0RHWGEwM0ZpbDZIZkFSUFk2bkp0M0dNT0xRdGty?=
 =?utf-8?B?c1BsQUxXYkV1OFBoRzFOdlJTK2Y1aUxCR24rVkhIemlOQkZRajY5Rmpid3c3?=
 =?utf-8?B?elZoblYwTU5SZjR6VWd6QzUrcTZVTWVsL0tqTFdzcGxwQkI3Ym01dWVEUkhq?=
 =?utf-8?B?cnJ4YlRJaFppWk8vTmVtUllWcG9LalhsVW5YdHNJT05OZHRMZXpFTWJDM3hK?=
 =?utf-8?B?QkxZZi9ROStTQlUxaGF3dHNETDZabGtBMktCdDZLTWZyVlVnMm9TS253eWxq?=
 =?utf-8?B?bTg0azhSSTkvMVJhSjFiaEpJdmYxbk9IYzlHUXB2WXBCaVpDdXhPUExFMEIr?=
 =?utf-8?B?WkFQNTMvVTdoSXdzZVAyUWxTc3NqSVBUVldvQXIzYXhnQ21jRWNnL1I0T2g4?=
 =?utf-8?B?Yko1NVZBSUZuU01DZXJhODFpellrN01iWG40cERLZDd1bG91d21BNndObHFK?=
 =?utf-8?B?eDMwMDRNRUxUeS82eDVLMkN4MkZwNmRsS0Rtek1aM1oydU5GTTlWWnNQckxW?=
 =?utf-8?B?Z1Zhb0pTT0pwRk0zYll3cHJweitRUG9Ga09oNWdmWlZLTXlhaS9rb1crN243?=
 =?utf-8?B?REU3QXJRM0NWNnNiSG8xSXExY3grMFZoWU9HSDdPaXZIRVI5KzUxRVdLWWhT?=
 =?utf-8?B?dEhDc1FHT3loV2UyZ0loL2s0UGpTdEMwZHRZSUltbEpMaHg2M1FSRG1YVUVI?=
 =?utf-8?B?S1Z0Y1lCaFFyaHZ3T0FnRml0MGEyTENIZXQxWHhmVnFJb2tHdVZodjBic2hR?=
 =?utf-8?B?YU82Q0MwWWswTXR3Sk5KcnhjMVZMMFArUVVhbklnSTJXakxoa1RLMjZ0aDdJ?=
 =?utf-8?B?UjZiNklNSUptQWhhSURyUWw4NFZXdTJrc1JqMmpqTmZpVVNudVpDalUzUkNq?=
 =?utf-8?B?TVRYNWE4MjlkZ3BkMFdVSTZoUmJpVWRGWEJFRWZ6bjIzUnNpZ3FCVDAxa3JE?=
 =?utf-8?B?UnEybmdoYzVpcWh3YWVmVDJBeTM3UnNyVWFVVUJyVGsrNytycExxSjJ4SHJs?=
 =?utf-8?B?WXhaOE9ENnp5OE9RdkhFL3VFTlNLa3djeUkydjRoclRNeE9ZZGw1WTJWSHZ5?=
 =?utf-8?B?TGlKUDJhN25VdVdKOSttSHk3amZpZzVzY2t1Nmtyc0s4a1MyOEFzbkZ1eXFB?=
 =?utf-8?Q?AvElmw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0559.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0d1dee-163d-4686-d7ed-08dc8602df0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 08:30:06.9254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gUIUkQqaJLo+QgSouztfJwYJK7+QZoD82sHKFh1Jc+Voegg3T7p3K/BtpD+4QkgOa0B+UGOEFcKVc7k2/pcXwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR83MB0679

PiA+IElnbm9yZSBvcHRpb25hbCBpYl9hY2Nlc3NfZmxhZ3Mgd2hlbiBhbiBNUiBpcyBjcmVhdGVk
Lg0KPiANCj4gQ2FuIHlvdSBhZGQgZGV0YWlscyBvbiB3aHkgdGhpcyBpcyBuZWVkZWQ/DQoNCkRv
IHlvdSBtZWFuIHRvIHRoZSBjb21taXQgbWVzc2FnZT8NCklmIHdlIGRvIG5vdCBpZ25vcmUgdGhl
c2Ugb3B0aW9uYWwgZmxhZ3MsIHRoZSByZWcgdXNlciBtciBmYWlscyBiZWNhdXNlIHRoZSBuZXh0
IDIgbGluZXM6DQoJaWYgKGFjY2Vzc19mbGFncyAmIH5WQUxJRF9NUl9GTEFHUykNCgkJcmV0dXJu
IEVSUl9QVFIoLUVJTlZBTCk7DQo=

