Return-Path: <linux-rdma+bounces-12505-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8328B139F7
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jul 2025 13:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0751F189277F
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jul 2025 11:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A145C25D533;
	Mon, 28 Jul 2025 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JM6IhZWv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E8121CA0C;
	Mon, 28 Jul 2025 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753702593; cv=fail; b=OBOXcWRquECmzO0Us3hfVsbFfRcbqYaiO1Ekpu7usr6ySliom0760pQyWUboYSyFOZU7hC59M9GHGE7ZzODtyxyjiOIhIOdnUjqPCJ6kb1HIpAWo/kfweQSjLMgx41/0KT7FReke+AiCNQsgRKGR6nUChemdZ+Pjc/mrMV9k0TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753702593; c=relaxed/simple;
	bh=tHGtsSxLT5+6Gi58yDBmaEJTt9E1JA/R48m/wRrPlNI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=TRy7rvCKLX/RBGp6h58gFuOM9KOjJD6hResDVqSb/d5IitmZH//hciQzrYxlIvVlQ78K2GW8DNEvPjp6ebiSIu3tY+T4P+rkLCSRibVnbhRSyr5gNyg+1D3f6AiomZ3Ndgn8UQ79hgTnp7Gy7PaQ0zJyYcTo8XCRgOegMwdyja0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JM6IhZWv; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56RMfeB4015077;
	Mon, 28 Jul 2025 11:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tHGtsS
	xLT5+6Gi58yDBmaEJTt9E1JA/R48m/wRrPlNI=; b=JM6IhZWvCTXTg2Ir+ZDeZu
	qq57JPZBhdXLXsE6jyLJeCz+ZPgVpY2cg50HkModj638j+mitIr6LsM66PpIZvRJ
	f1jp+nVrKzSL7RQmPT8sdPON7d2dqQopIElQMk+WFrdt8aDcZiQXqQWZhI+Avqx3
	Lqqiz2cxrm9XXX9a4jUX2S+cnwoumqSqO5B7ZQE28OkKD8IAiUHlE+tI2+L4SRRB
	av/tAmAOh9NKT1m90/XppQtptpALCalkFtpbExYQ/1yYmfVfzKkdyiNCgPYzZDgQ
	wwaN8QMbi+DTUg+Ci6VxTpXQQXsjzHgmALWaLYkqTRsVPWsvF86Scc9fkqS/2q0Q
	==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfqgp0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 11:34:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSHVFyz80NEY5oWGGqUapwf7j6Udj6i93DXgU0feYVfmss2ixqkKJXxwhBATDk+PVIkg7SDKv5qIOX+1uD2LJvJ73iXtBOc8UK8IJcapnRcQdJBKvIAv+isqdVbbnmKUOlnK4IsgDbn8aTFnB3xRNVSkBN7685SkHhhkeXJZVPrMRkFeNGrjdlGhG6vcB19I2A4QVO/ruLzcwQgzucpz7QCdD2QEpFQ8xbjNTrRLQgjyM0u5u8dLueOPd6im1JPA3G64QxB+egltZk9QcvS88bgwNREIJ01PeMCzivx050WNuK2/f3LtIz/EZfe5G3+u/DgqWxiqqJRQjVEPbW0Q3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHGtsSxLT5+6Gi58yDBmaEJTt9E1JA/R48m/wRrPlNI=;
 b=dx9qh+VaitOVvRucc1fBC/4JeWmyc9zjmQdQiHAnhTIetEBUToamGHFk9uNOtZypDdQKvrtKgb6cfr8BwHx/dSYrdmShPWTLvWPWedzjSOsc5cH5gOaq4mnhgyq65PF9z82duzr6DdzpokZKfv7G1LR3UAA3ELVuCSEluUXks3q4OP/oxhFBerfkitcSj7zYunblEmPYA94Olp0hy1LOCH6eM2lvs5KgrJ8LudsLceap3inhuwxP4WkYGpOP6YfDB+tIIEmsjpXFV9axkckpy78X3x6HocPiSDbitzD336/sgO6vYFrUZ8rLa5eMOW4hpqq2LV/IwrwkfW0+ZCwiQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30)
 by CH4PR15MB6697.namprd15.prod.outlook.com (2603:10b6:610:221::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 28 Jul
 2025 11:34:35 +0000
Received: from BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::4349:d5ca:1d09:1e40]) by BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::4349:d5ca:1d09:1e40%7]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 11:34:34 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Pedro Falcato <pfalcato@suse.de>,
        "bernard.metzler@linux.dev"
	<bernard.metzler@linux.dev>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jakub Kicinski <kuba@kernel.org>,
        David
 Howells <dhowells@redhat.com>, Tom Talpey <tom@talpey.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        kernel test robot <oliver.sang@intel.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] RDMA/siw: Fix the sendmsg byte count in
 siw_tcp_sendpages
Thread-Index: AQHb++lkWjUdTuVAk06Toe8wCZHR2rQ/6HwwgAMc0oCABGjAkA==
Date: Mon, 28 Jul 2025 11:34:34 +0000
Message-ID:
 <BN8PR15MB25137ADAFE2A3677D12F8630995AA@BN8PR15MB2513.namprd15.prod.outlook.com>
References: <20250723104123.190518-1-pfalcato@suse.de>
 <DS0SPRMB00679C99808A4D85BAB6DADF995FA@DS0SPRMB0067.namprd15.prod.outlook.com>
 <nwtutmewgtziygnp7drmhdxpenrbxumrjprcz7ls2afwub5lwf@due2djp7llv5>
 <DS0SPRMB006759C349217E60D43F923B995FA@DS0SPRMB0067.namprd15.prod.outlook.com>
 <l5cavrkmzvebjqz62ttdajqc24q3fksxogiibv4tiee7c3j2lk@skxdyrnsqgmm>
In-Reply-To: <l5cavrkmzvebjqz62ttdajqc24q3fksxogiibv4tiee7c3j2lk@skxdyrnsqgmm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2513:EE_|CH4PR15MB6697:EE_
x-ms-office365-filtering-correlation-id: 0a04e353-2193-4d55-4f04-08ddcdcaba39
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NjVBbW8zYjJsM0RtR1QzbUMvT29INGJQRlAxYm1wN1N4dE9STVZ6TEZkcktQ?=
 =?utf-8?B?NXpTMFRncmxKUVgvVzh1UzczRCtHMGROcEl1OXlqM0E2NUpOaWw4VXBOU09z?=
 =?utf-8?B?d1Y0TmJxbnZsMFJ3WnFJT1NicDdSc2lzeXUyOERGbkhtWGl5RGg5MWZsVG9t?=
 =?utf-8?B?R2tjYk5OWEVuNjAxQkVxV3BUWkxWdzQ2OUlXczJybm9OaEpOYUpGVEd2dWtC?=
 =?utf-8?B?Yi9YQWJzc0tnWUZydk04RUVJQjZhcUxEZ0UrWkU3UTFRQ21jK0tmV0hHYk9E?=
 =?utf-8?B?cTlXeUlBZ2JoMlA3NFpuVEYvU05BVnMzSUhLUGsrTlFkcm1IMVRYMVg0RnMr?=
 =?utf-8?B?TnZsaXVsWkd2eUhxcEVSL0hoY1NmeFFoVGhGMnM0c0lZakZmeUo4ekdlQWgv?=
 =?utf-8?B?QXRvSmdGdXh1UE9rdmNtR3BRZVUwWTFzNXZ5RnFrWE82NEJkTFpHcFlXendm?=
 =?utf-8?B?TTU1YkF6UGVWQWFGL2cvN0htcElKanIweXJsZitkOXZYaXc2ZHdoVmxOZlU4?=
 =?utf-8?B?ZHdmRkJRbTJqQlRmWUlkZjYrS0l3Tk1mSFhyaVB1MTN2VG9KdGRhOU14UWpn?=
 =?utf-8?B?N3dhRFF4aEJlcG9hWGRpKzBPaUJWY0VOak8wV0xLOTB2dm53Q1psV1NHOUhr?=
 =?utf-8?B?R0M4WFRvYUlQWWZYaUZDR0h5YUdsWFkycUtpSmNvM0hMSlErTFdJWDVXM0Zw?=
 =?utf-8?B?QjQ1VGJidFRXSXZjNzVwWG8rNERORW5pZmdNa0pQaGhOdTZpbGdUZ1kwSEY4?=
 =?utf-8?B?K2JseE03OElTbzVhbENORTh3NVdRdExaNm9VRGNuWk1rRlowT0ZoVk1QT3pw?=
 =?utf-8?B?T1JESFRmRVIwTTU4cGZIN2FqdFJRc25qUnZrVUpFenlmais5TUJ0MzB1TnVl?=
 =?utf-8?B?ckk3Q2tKdnFrdy9LaEhzanRPcEFkanpvblAyTGhqK0srYnJ3Yk5tanZOcjA2?=
 =?utf-8?B?dXpZcml3UTlzN2pDcUwvSVhDOUErUzdabWRZc2VmWFpPdXBHdHlsQmRnVzkx?=
 =?utf-8?B?enU3NFNnaStBUS9VNktkWHhKZDI4SFlNSHdzQVJEVGVTM0docFUyMmYyY1B6?=
 =?utf-8?B?ZGxVTnVJR1Y0UTdHb1NJbzJlK25NaGx4bXJEeVJNQUJrZkNKM3g5K3phVWFl?=
 =?utf-8?B?TSsvTUJ2K0dNOVBkRkFQeXVOSDNvNG5YcEhkOUZTYWNESmF1dk1iZzZSK3Rr?=
 =?utf-8?B?SE9qWS9velVvL2hUMjBsdWlhS1luK1NRQ01IOHB2ZHdaNVRNNVphMjgvcjVm?=
 =?utf-8?B?L3JhUGQ2NWRHTGtPUzJld0FpMEtPNUlxRWVJcjYwdmEwMnRaT0VPN1g5cGR0?=
 =?utf-8?B?Q3JEY3R5NGlrV1I0M00xSzdsenlNc1RycU9Bd0FNeHFQQ01peGY4NnQ4bFlv?=
 =?utf-8?B?SjYzbENwMGtBVXpmaVVuMFNlVGRpYjA2QUpSS0RITFdISGwwcDFKSnpudzkv?=
 =?utf-8?B?Q3NMWjlucVBzY2NOOWFhSUNOZEoyWVllMEkwQS9tOU9zMGNHOTY2Ry9Rbzlm?=
 =?utf-8?B?eTJSa25XckNWTmo3bTRnSWhkLzBOTFhxS2djcG5YckVVVy8yUjJZSVFTSzZ3?=
 =?utf-8?B?V3BmcHRtbFhHc1lXcS9NNUJibU9Qc3JzOFgxVXBxNG0vQ1ZNb0Y0Ty8vcFJH?=
 =?utf-8?B?NU42QWZROVVlazJKeGRrTnZBTEc3UFpvY2hoMUFHb1VqbEdUVDZyd2JBZy9M?=
 =?utf-8?B?N2I3dWRaRkpzVjhaNHFyNVhnU01jTVhRdTVod0hzYlFZK0FwMHhzcWx6TzJj?=
 =?utf-8?B?UXRiUFJOUnJScUhBWmI2SEtNR3U5dlZ6b2cybkk0QlpCSzc4R1p1eGNiZ09h?=
 =?utf-8?B?UUN3bmRPZEkxdWF5aEJxaU4wOHRCWE5mS3BZM29aMWp4UHQ2dk5wQTdQTXN6?=
 =?utf-8?B?RnVYMVhhRnJldk9TTE80d3lxdE5JZTh5K0wyMmVtZmVtMEFYVjB1dzZhR040?=
 =?utf-8?B?QXExcThPa2FneHNTYTYwUXhWL0xBb2c4ZjZoQzhIOFgwVndGWEMyYkJQZmxo?=
 =?utf-8?B?NHFiKzc2TGFnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2513.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEcrcmxJaFJWd2ptbTIzMkpzMXBPcEE1amlHREdFVVkvV2lRRm1rMGo5Umda?=
 =?utf-8?B?bHBIRC9aRHNMclpLTXIxOCtBWkNTbVgzOG8rYWdXVGNZaEpMa0ovSnY2eG1F?=
 =?utf-8?B?RURiUThDdytVaHc3U0dOMXl0SWNxSVFYZStneURZbkdXWUZiWG1ucmRzdUUx?=
 =?utf-8?B?ZzN1cWpZM2NyVXFLeUlVK2NBVDZQLzk5YWJNQXl6c2I4ZHpTRk5OYUNqeVNi?=
 =?utf-8?B?dTNZUmRnWmhybFFIOXIzYXFNT3dxOE1HV3pkdHhiNGNNT2lIQ3FveTJuMmJh?=
 =?utf-8?B?aDJQRGIvWUUxeHNSQm1YN0M1OWhmejdBT0o5eThhSE1QYnVyQ1V1NS9INW1Q?=
 =?utf-8?B?UUd3QzZLajY4U0xWbzJPVnlTc1BoRWRVbEd2NVJRbU9qb2VQRmNYL0d3OE9x?=
 =?utf-8?B?a1BmOGNIcDBEa1dabDUxajRnOTduckRIaFUzUENzUFZyWGRVOGRobEdrYVE3?=
 =?utf-8?B?Yzh4UFlqd2lHcUFBR0tLb0ZrVFhsQzhVb1pPTjZzc1Q4Wk1FTWZjWWNzdmtG?=
 =?utf-8?B?SVo5U3BjUEZOWGQyRmthRURUSm9aNFprdURkUkRGWFE1MFkrTG81YWVZbWln?=
 =?utf-8?B?YU5ETlMxSFp0MVR3QkVtUlVDanRINnFPdDhZbzFzS0pLQVQwbk54TG1IOXRM?=
 =?utf-8?B?MUZ5Ly9xdWlDSUdiUGFGcmx5cXZwVzVQUzlxQURFK1l1dDRhczZOb1YrV1ZV?=
 =?utf-8?B?RHZObURuOUVweTE0ZmkrR0h0S1JSY0V1QUNlVktHOHJORVBpKzVNdFk1L3Zk?=
 =?utf-8?B?UExYdk1tcmE5TmQvRFlEY0lySzhqMkFNK2FLY0RRYUFiR0w5Q2lWam1nY0dJ?=
 =?utf-8?B?WmswTVIxdkFKMmlXSThBd2EzaDhrZTRPaDA2Z1lZVVdSZjFCYzBEWTVMU3Zy?=
 =?utf-8?B?cTFEVXRJRjhqN3VWamt0L29oVXErOVNwNm9JblJja1JBcER5YTAwbVkwNkN0?=
 =?utf-8?B?b2U5eHFxYVdKZ3I0enloT0NDNzRBYXlCUUhsL2lTNGJJd2hKOVFVUDhTeHZQ?=
 =?utf-8?B?M0xQV3FyRk96RTE3ZmNKSmtDSXBmSDB2SmFjU1RMNjU0amtwZjN6TGpMSmVM?=
 =?utf-8?B?OVRwOGc0L1NPQmF5RGdmVjI4TTBPNUJLVG5hd253KzA4cDAwM2lURDZUdlhk?=
 =?utf-8?B?ckNvRytGMk1DVWNoQmxhZkNTUmJZMWRZa2NKN25hUXAzNHdOZVQvQzNlOHJS?=
 =?utf-8?B?Ty9tMDJaRTZEVG1MNDRYSG9wRDl1MmxLOHdKVWllTnhwZmwyNGdlQ2llbEZs?=
 =?utf-8?B?MThoMUZicXpIeXp1NldieVhYaG1kcEVQRi9PdXI5SkdUMUo5L0VJcjArdWR0?=
 =?utf-8?B?ZHRGRXQ4TVM3aEhJRGtJaVlFS2U5bFVCSW4ybVpQbzFTRkZEOXVyaG5SOHNU?=
 =?utf-8?B?dWVSamU4clFGREFZdWlhakJLanF3MEgzL3MwS2lTM3V4Tk5oQkY5VXRZVXow?=
 =?utf-8?B?Z0N1Q1E3T1AxMVRScHpPT29ZZHhkTGpCK05Fei92QVEwY3d3T1VFdVVvNDVK?=
 =?utf-8?B?SUcrWUVJV2I2UXYyUm5RWGQ4RmlDVnNWSFBDMlZtbW5aOGZRRG5iZFl1am1z?=
 =?utf-8?B?aWVUTVB4VnhFN1ZHdUhOYi82Yk51Tnk5bFhDbzdqc2lxOGNvMlUvTk10NjVL?=
 =?utf-8?B?K3VmOGlOUGF5RW56ZUpmaUpOQlp0YjNtRUhwZWF0cWtIUmtwb3o1bHhGRWFI?=
 =?utf-8?B?RmJZeG1nVGh5bGc2OWZPcE5YUW9qeGQvRVRnNlBoTGdVa3hlUWI0QllQVEFj?=
 =?utf-8?B?NE16STRaOHZLM3RobHNGMmtZYnlJZ3NEQ1o5aXVJejZnN2lQcTlkT2lMK0s5?=
 =?utf-8?B?OFJwNS9ONjFzalI0SlpPbXBlTjhwVCt1TXZYNGU5Ykc4V1k4b1NrdS8xNW5n?=
 =?utf-8?B?Y2VRQmcyK2Z6RGU3UzZiR3IyT0czd1hWYlpmMUdEYVltdStOZ21EMlBWVHlD?=
 =?utf-8?B?Wm54L0Nlc2hqOWlNcGUwSTlxVHIrd3o5WTNzeWVEU2p1YmxGcUdOLy9kNk03?=
 =?utf-8?B?MEJ4UUZmUHpaYWM3a3g2K1BpYWJsL0RBME95ZjIvWVhvSklEajBLNzNCVk5r?=
 =?utf-8?B?dkxuY1krVFArc05nTFJDa2V6VzVZSWl4V3BTb3dwaUhxUUduUk5takxuT3cz?=
 =?utf-8?Q?X1Bj2JqEnVj+zLStysjm8ebjO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a04e353-2193-4d55-4f04-08ddcdcaba39
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 11:34:34.7290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M1Zd7mywM69YDchJ4t9FKA88EOnLRixnqP8o4aNgVlKL1Fiuv2kf8+jHMt6ugjGPOrkufptagSatAwDod9GaLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR15MB6697
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA4MyBTYWx0ZWRfX6iNpussO9UhB
 8OWmG883BnQjh5zfUWdMssygQtOk/dYRtx7t+2A2nY3SJFsU2BvBisgGK2ZkY/xv8LgnoeON30N
 k2gx9RKQ9M9EsfjK0H+mBspdOQzV4PMcbrRbLRZ6I23jz5G2vl3m/u5ObnTxteZQ9S9AuKZPmfN
 xmVmbOjYD1hx2JaM5veos7NxLBh10aSmJ5yPJmRMWwRwCrZqyWmMpOckRBcJ8tXfsTwBZope6hO
 DSEzwsLbHWW8R2PV/JtVsDYg8ZkAclj702SGQG5xLC8+ZqgLNRLM3WycV5mTTMGPrtzfkdMXspk
 +F4oBFOlKSuLLiz7AB5WZWbJ8G2uI+JbgcIed3evNyTtmW/iEQ6tCHUxqw4ADnmr5kAGYLmcniZ
 s19XqsmEALojorelzWzlTahlbXrYcyq7NSbxiprqd5HXhClM82vSyY2auv6YiT4NTg8fYhZL
X-Authority-Analysis: v=2.4 cv=Je28rVKV c=1 sm=1 tr=0 ts=6887604d cx=c_pps
 a=up6PulAVXqy3i+yUvDkarA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=VarWvt3nGuvZ4FJz:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=9jRdOu3wAAAA:8
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=SEc3moZ4AAAA:8 a=37rDS-QxAAAA:8
 a=QyXUC8HyAAAA:8 a=XWuZZz3BFMLTGP7MArIA:9 a=QEXdDO2ut3YA:10
 a=ZE6KLimJVUuLrTuGpvhn:22 a=5oRCH6oROnRZc2VpWJZ3:22 a=k1Nq6YrhK2t884LQW06G:22
X-Proofpoint-GUID: uVjkjFLjysuOsZzzErvyzjGbYcySlTCl
X-Proofpoint-ORIG-GUID: uVjkjFLjysuOsZzzErvyzjGbYcySlTCl
Subject: RE: [PATCH] RDMA/siw: Fix the sendmsg byte count in siw_tcp_sendpages
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 mlxscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280083

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGVkcm8gRmFsY2F0byA8
cGZhbGNhdG9Ac3VzZS5kZT4NCj4gU2VudDogRnJpZGF5LCAyNSBKdWx5IDIwMjUgMTg6MTANCj4g
VG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiBDYzogSmFzb24gR3Vu
dGhvcnBlIDxqZ2dAemllcGUuY2E+OyBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz47
DQo+IFZsYXN0aW1pbCBCYWJrYSA8dmJhYmthQHN1c2UuY3o+OyBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPjsgRGF2aWQNCj4gSG93ZWxscyA8ZGhvd2VsbHNAcmVkaGF0LmNvbT47IFRv
bSBUYWxwZXkgPHRvbUB0YWxwZXkuY29tPjsgbGludXgtDQo+IHJkbWFAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7DQo+IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbCB0ZXN0IHJvYm90IDxvbGl2ZXIuc2FuZ0BpbnRl
bC5jb20+DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSF0gUkRNQS9zaXc6IEZpeCB0
aGUgc2VuZG1zZyBieXRlIGNvdW50IGluDQo+IHNpd190Y3Bfc2VuZHBhZ2VzDQo+IA0KPiBPbiBX
ZWQsIEp1bCAyMywgMjAyNSBhdCAwNDo0OTozMFBNICswMDAwLCBCZXJuYXJkIE1ldHpsZXIgd3Jv
dGU6DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZy
b206IFBlZHJvIEZhbGNhdG8gPHBmYWxjYXRvQHN1c2UuZGU+DQo+ID4gPiBTZW50OiBXZWRuZXNk
YXksIDIzIEp1bHkgMjAyNSAxNzo0OQ0KPiA+ID4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1
cmljaC5pYm0uY29tPg0KPiA+ID4gQ2M6IEphc29uIEd1bnRob3JwZSA8amdnQHppZXBlLmNhPjsg
TGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+Ow0KPiA+ID4gVmxhc3RpbWlsIEJhYmth
IDx2YmFia2FAc3VzZS5jej47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+Ow0KPiBE
YXZpZA0KPiA+ID4gSG93ZWxscyA8ZGhvd2VsbHNAcmVkaGF0LmNvbT47IFRvbSBUYWxwZXkgPHRv
bUB0YWxwZXkuY29tPjsgbGludXgtDQo+ID4gPiByZG1hQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOw0KPiA+ID4gc3RhYmxl
QHZnZXIua2VybmVsLm9yZzsga2VybmVsIHRlc3Qgcm9ib3QgPG9saXZlci5zYW5nQGludGVsLmNv
bT4NCj4gPiA+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSF0gUkRNQS9zaXc6IEZpeCB0
aGUgc2VuZG1zZyBieXRlIGNvdW50IGluDQo+ID4gPiBzaXdfdGNwX3NlbmRwYWdlcw0KPiA+ID4N
Cj4gPiA+IE9uIFdlZCwgSnVsIDIzLCAyMDI1IGF0IDAyOjUyOjEyUE0gKzAwMDAsIEJlcm5hcmQg
TWV0emxlciB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+IEZyb206IFBlZHJvIEZhbGNhdG8gPHBmYWxjYXRvQHN1
c2UuZGU+DQo+ID4gPiA+ID4gU2VudDogV2VkbmVzZGF5LCAyMyBKdWx5IDIwMjUgMTI6NDENCj4g
PiA+ID4gPiBUbzogSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+OyBCZXJuYXJkIE1ldHps
ZXINCj4gPiA+IDxCTVRAenVyaWNoLmlibS5jb20+Ow0KPiA+ID4gPiA+IExlb24gUm9tYW5vdnNr
eSA8bGVvbkBrZXJuZWwub3JnPjsgVmxhc3RpbWlsIEJhYmthIDx2YmFia2FAc3VzZS5jej4NCj4g
PiA+ID4gPiBDYzogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IERhdmlkIEhvd2Vs
bHMNCj4gPiA+IDxkaG93ZWxsc0ByZWRoYXQuY29tPjsNCj4gPiA+ID4gPiBUb20gVGFscGV5IDx0
b21AdGFscGV5LmNvbT47IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gPiA+
ID4gPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IFBlZHJvIEZh
bGNhdG8NCj4gPiA+ID4gPiA8cGZhbGNhdG9Ac3VzZS5kZT47IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmc7IGtlcm5lbCB0ZXN0IHJvYm90DQo+ID4gPiA+ID4gPG9saXZlci5zYW5nQGludGVsLmNvbT4N
Cj4gPiA+ID4gW3NuaXBdDQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gIGRyaXZlcnMvaW5maW5p
YmFuZC9zdy9zaXcvc2l3X3FwX3R4LmMgfCA0ICsrLS0NCj4gPiA+ID4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jDQo+ID4g
PiA+ID4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jDQo+ID4gPiA+ID4g
aW5kZXggM2EwOGY1N2QyMjExLi45NTc2YTJiNzY2YzQgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYw0KPiA+ID4gPiA+ICsrKyBiL2Ry
aXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmMNCj4gPiA+ID4gPiBAQCAtMzQwLDEx
ICszNDAsMTEgQEAgc3RhdGljIGludCBzaXdfdGNwX3NlbmRwYWdlcyhzdHJ1Y3Qgc29ja2V0ICpz
LA0KPiA+ID4gc3RydWN0DQo+ID4gPiA+ID4gcGFnZSAqKnBhZ2UsIGludCBvZmZzZXQsDQo+ID4g
PiA+ID4gIAkJaWYgKCFzZW5kcGFnZV9vayhwYWdlW2ldKSkNCj4gPiA+ID4gPiAgCQkJbXNnLm1z
Z19mbGFncyAmPSB+TVNHX1NQTElDRV9QQUdFUzsNCj4gPiA+ID4gPiAgCQlidmVjX3NldF9wYWdl
KCZidmVjLCBwYWdlW2ldLCBieXRlcywgb2Zmc2V0KTsNCj4gPiA+ID4gPiAtCQlpb3ZfaXRlcl9i
dmVjKCZtc2cubXNnX2l0ZXIsIElURVJfU09VUkNFLCAmYnZlYywgMSwgc2l6ZSk7DQo+ID4gPiA+
ID4gKwkJaW92X2l0ZXJfYnZlYygmbXNnLm1zZ19pdGVyLCBJVEVSX1NPVVJDRSwgJmJ2ZWMsIDEs
IGJ5dGVzKTsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICB0cnlfcGFnZV9hZ2FpbjoNCj4gPiA+ID4g
PiAgCQlsb2NrX3NvY2soc2spOw0KPiA+ID4gPiA+IC0JCXJ2ID0gdGNwX3NlbmRtc2dfbG9ja2Vk
KHNrLCAmbXNnLCBzaXplKTsNCj4gPiA+ID4gPiArCQlydiA9IHRjcF9zZW5kbXNnX2xvY2tlZChz
aywgJm1zZywgYnl0ZXMpOw0KPiA+ID4gPiA+ICAJCXJlbGVhc2Vfc29jayhzayk7DQo+ID4gPiA+
ID4NCj4gPiA+ID4NCj4gPiA+ID4gUGVkcm8sIG1hbnkgdGhhbmtzIGZvciBjYXRjaGluZyB0aGlz
ISBJIGNvbXBsZXRlbHkNCj4gPiA+ID4gbWlzc2VkIGl0IGR1cmluZyBteSB0b28gc2xvcHB5IHJl
dmlldyBvZiB0aGF0IHBhdGNoLg0KPiA+ID4gPiBJdCdzIGEgc2VyaW91cyBidWcgd2hpY2ggbXVz
dCBiZSBmaXhlZCBhc2FwLg0KPiA+ID4gPiBCVVQsIGxvb2tpbmcgY2xvc2VyLCBJIGRvIG5vdCBz
ZWUgdGhlIG9mZnNldCBiZWluZyB0YWtlbg0KPiA+ID4gPiBpbnRvIGFjY291bnQgd2hlbiByZXRy
eWluZyBhIGN1cnJlbnQgc2VnbWVudC4gU28sDQo+ID4gPiA+IHJlc2VuZCBhdHRlbXB0cyBzZWVt
IHRvIHNlbmQgb2xkIGRhdGEgd2hpY2ggYXJlIGFscmVhZHkNCj4gPiA+ID4gb3V0LiBTaG91bGRu
J3QgdGhlIHRyeV9wYWdlX2FnYWluOiBsYWJlbCBiZSBhYm92ZQ0KPiA+ID4gPiBidmVjX3NldF9w
YWdlKCk/Pw0KPiA+ID4NCj4gPiA+IFRoaXMgd2FzIHJhaXNlZCBvZmYtbGlzdCBieSBWbGFzdGlt
aWwgLSBJIHRoaW5rIGl0J3MgaGFybWxlc3MgdG8gYnVtcA0KPiAoYnV0DQo+ID4gPiBub3QgdXNl
KQ0KPiA+ID4gdGhlIG9mZnNldCBoZXJlLCBiZWNhdXNlIGJ5IHJldXNpbmcgdGhlIGlvdl9pdGVy
IHdlIHByb2dyZXNzaXZlbHkNCj4gY29uc3VtZQ0KPiA+ID4gdGhlIGRhdGENCj4gPiA+IChpdCBr
ZWVwcyBpdHMgb3duIHNpemUgYW5kIG9mZnNldCB0cmFja2luZyBpbnRlcm5hbGx5KS4gU28gdGhl
IG9ubHkNCj4gdGhpbmcNCj4gPiA+IHdlDQo+ID4gPiBuZWVkIHRvIHRyYWNrIGlzIHRoZSBzaXpl
IHdlIHBhc3MgdG8gdGNwX3NlbmRtc2dfbG9ja2VkWzFdLg0KPiA+ID4NCj4gDQo+IEhpLA0KPiAN
Cj4gU29ycnkgZm9yIHRoZSBkZWxheS4NCj4gDQo+ID4gQWggb2theSwgSSBkaWRuJ3Qga25vdyB0
aGF0LiBBcmUgd2Ugc3VyZT8gSSBhbSBjdXJyZW50bHkgdHJhdmVsbGluZyBhbmQNCj4gaGF2ZQ0K
PiA+IG9ubHkgbGltaXRlZCBwb3NzaWJpbGl0aWVzIHRvIHRyeSBvdXQgdGhpbmdzLiBJIGp1c3Qg
bG9va2VkIHVwIG90aGVyDQo+IA0KPiBJJ20gbm90IDEwMCUgc3VyZSwgYW5kIGlmIHNvbWUgbW9y
ZSBhdXRob3JpdGF0aXZlIHZvaWNlIChEYXZpZCwgb3IgSmFrdWIgZm9yDQo+IHRoZSBuZXQgc2lk
ZSkgY291bGQgY29uZmlybSBteSBhbmFseXNpcywgaXQgd291bGQgYmUgZ3JlYXQuDQo+IA0KPiA+
IHVzZSBjYXNlcyBhbmQgZm91bmQgb25lIGluIG5ldC90bHMvdGxzX21haW4uYyNMMTk3LiBIZXJl
IHRoZSBsb29wIGxvb2tzDQo+ID4gdmVyeSBzaW1pbGFyLCBidXQgaXQgd29ya3MgYXMgSSB3YXMg
c3VnZ2VzdGluZyAodGFraW5nIG9mZnNldCBpbnRvIGFjY291bnQNCj4gPiBhbmQgcmUtaW5pdGlh
bGl6aW5nIG5ldyBidmVjIGluIGNhc2Ugb2YgcGFydGlhbCBzZW5kKS4NCj4gPg0KPiA+ID4gSWYg
ZGVzaXJlZCAoYW5kIGlmIG15IGxvZ2ljIGlzIGNvcnJlY3QhKSBJIGNhbiBzZW5kIGEgdjIgZGVs
ZXRpbmcgdGhhdA0KPiBiaXQuDQo+ID4gPg0KPiA+DQo+ID4gU28geWVzIGlmIHRoYXQncyBhbGwg
c2F2ZSwgcGxlYXNlLiBXZSBzaGFsbCBub3QgaGF2ZSBkZWFkIGNvZGUuDQo+IA0KPiBVbmRlcnN0
b29kLiBJJ2xsIHNlbmQgYSB2MiByZXNldHRpbmcgdGhlIGJ2ZWMgYW5kIGlvdl9pdGVyIGlmIHdl
IGdldCBubw0KPiBmdXJ0aGVyDQo+IGZlZWRiYWNrIGluIHRoZSBtZWFud2hpbGUuDQoNCkxldCdz
IHNlZSBpZiB3ZSBnZXQgaW5wdXQgb24gaXQuIEV2ZW4gaWYgdGhhdCBpcyBhbGwgc2F2ZSwgSSB0
aGluaw0Kd2Ugc2hhbGwgcHV0IGluIGEgc2hvcnQgY29tbWVudCBleHBsYWluaW5nIHdoeSB3ZSBk
byBub3QgcmUtaW5pdGlhdGUNCnRoZSBidmVjLg0KDQpQbGVhc2UgaW5jbHVkZSBteSBuZXcgbWFp
bnRhaW5lciBlbWFpbCBhZGRyZXNzIGluIGZ1cnRoZXIgaXRlcmF0aW9ucywNCmFuZCBzdG9wIHNl
bmRpbmcgdG8gdGhlIG9sZC4gTXkgSUJNIGFkZHJlc3MgZ29lcyBhd2F5IGVuZCBvZiBtb250aC4N
ClRoYW5rIHlvdSENCg0KQmVybmFyZC4NCj4gDQo+ID4NCj4gPiBUaGFua3MhDQo+ID4gQmVybmFy
ZC4NCj4gPiA+DQo+ID4gPiBbMV0gQXNzdW1pbmcgdGNwX3NlbmRtc2dfbG9ja2VkIGd1YXJhbnRl
ZXMgaXQgd2lsbCBuZXZlciBjb25zdW1lDQo+IHNvbWV0aGluZw0KPiA+ID4gb3V0DQo+ID4gPiBv
ZiB0aGUgaW92ZWNfaXRlciB3aXRob3V0IHJlcG9ydGluZyBpdCBhcyBieXRlcyBjb3BpZWQsIHdo
aWNoIGZyb20gYQ0KPiBjb2RlDQo+ID4gPiByZWFkaW5nDQo+ID4gPiBpdCBzZWVtcyBsaWtlIGl0
IHdvbid0Li4uDQo+ID4gPg0KPiA+ID4NCj4gPiA+IC0tDQo+ID4gPiBQZWRybw0KPiANCj4gLS0N
Cj4gUGVkcm8NCg==

