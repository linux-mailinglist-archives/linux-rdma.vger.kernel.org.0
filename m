Return-Path: <linux-rdma+bounces-12428-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35599B0F86A
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 18:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2759EAA8412
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 16:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844F11FC0E2;
	Wed, 23 Jul 2025 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FTEy9xID"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795D91F4176;
	Wed, 23 Jul 2025 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753289407; cv=fail; b=MRzJOYv7XO4jpACdkXhhQVIZVW/mCNotp12ILi8pcqHwnJDS+SNHwS44YUEl1IEIa18P6KUwjV8OYURnY6wCMcPh2TL7Srv/Ywunz46am9J5OUikvvMq+DWggzSppABLadOQqB9qt+g1A8fa1Qb9HdZUbHM8QLHoH2oRBkowx38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753289407; c=relaxed/simple;
	bh=Nm5SWkmepqMfjKou1GuhCU1/db4IbBZD92NBejEhWik=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=BnXtWaXF41V7vswlnkJY17dENTqZIYkxV6xoTqzMuM/zP0rMnQGqREcDrl823SmwugUwK27R38EASEBWnTdSQ/nHN75MLqkZS0FPfJukmF99V8IpUZO9IFXg0GtH/2Ag4EOOrplLThK32ElV4Xu5UrJNQvpmGCj2umn2hgbEOPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FTEy9xID; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NAfOpR028748;
	Wed, 23 Jul 2025 16:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Nm5SWk
	mepqMfjKou1GuhCU1/db4IbBZD92NBejEhWik=; b=FTEy9xIDqMJg021D+w4UMG
	KtfnZQYWWKpV4E9wqGbt1HeTJC9WfC6U0+QcOMAHoBz67ivuHOTAtSKz0CwzBzFN
	IaqgIOXSy64hjlaKM7vgkq2BiF70XGBFH8e6OL39YMhNGVclvweld1GaRkGEqHu6
	7OgjvVpdjbLRB18VOJ8BNG2NLG/zV44Sd/3snHqtrAk/Zte8LVv0EZoTYIND+uAe
	gA889cGaArU/JUpH/bE2MwvpPgppT89exiQZLa9aJIksh11HSJALicHnao02uZMr
	kVoxasPc2HEnsUJ/J94+nVXYxn5tW3ToKipx/FryBMjctx8/up3wN2kdiKhnxzaw
	==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482kdymt56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 16:49:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDoWkHCg217TKjJCeUZPCMGgpMiuW1fXGLpNJuXntaDtt0aAZ+EUvX5Ls9xKI85aHxu2uBajAcMvAEmkvdPmiKM2IP60KYOc7mtP2E8EL1k5HsT2qettTcvTEJzDNP+qHArMVKjNmd9yQPcz6hztkMUbdeM8Kg2cR4dykdgorPHkIGfmwI0JzU9c4ORzQlyRdcGsn9BTsK9LwwIb/8DZcNNRv23j6cqAI6Sz7Ow9c1yHI3qRhyx8RhO9BxfIOQj8kAaTjbPS4+4z7gzWtwLoNblcHyELDZgFES0o9cLmQnjp34UltjYVnQtbpnH4lOS7NPWa5oCsBQojZsmitKcXLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nm5SWkmepqMfjKou1GuhCU1/db4IbBZD92NBejEhWik=;
 b=yebRbxH7slYW6MlxqKSOsw6joQcObHb3mKhy+qGKS0DAF4nkjQo5X+9J3pOyzhewB5F53VwQcj190oUzJqsBSx/XBS3CeRrqxCZ3LfxHJRxwYm13kljWvK4X/bxzZ4GcGwAxkHjWwSnXglWRfK0mRgDgnxKVC77COPdQhoNqqky+61ICn+WPAFyQM1uQMGJ/tQoGKDsv33mJ3ILpIMXtEmGlfeCRd7d6PrVs4BUpXrucQSygLjhKSwS+9kCaNTet87yJIlYEUZcy3f7cJx8v08fQpXgYplkIPTpDE9FQQmZXhRPk/iFTrQR5/9X2B5wQ3IZSHsOlZoN5bNqSifuHdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from DS0SPRMB0067.namprd15.prod.outlook.com (2603:10b6:8:fa::6) by
 SA0PR15MB3821.namprd15.prod.outlook.com (2603:10b6:806:8e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Wed, 23 Jul 2025 16:49:30 +0000
Received: from DS0SPRMB0067.namprd15.prod.outlook.com
 ([fe80::dbc1:cd0e:bdf2:dabc]) by DS0SPRMB0067.namprd15.prod.outlook.com
 ([fe80::dbc1:cd0e:bdf2:dabc%6]) with mapi id 15.20.8943.028; Wed, 23 Jul 2025
 16:49:30 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Pedro Falcato <pfalcato@suse.de>
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
Thread-Index: AQHb++lkWjUdTuVAk06Toe8wCZHR2rQ/6Hww
Date: Wed, 23 Jul 2025 16:49:30 +0000
Message-ID:
 <DS0SPRMB006759C349217E60D43F923B995FA@DS0SPRMB0067.namprd15.prod.outlook.com>
References: <20250723104123.190518-1-pfalcato@suse.de>
 <DS0SPRMB00679C99808A4D85BAB6DADF995FA@DS0SPRMB0067.namprd15.prod.outlook.com>
 <nwtutmewgtziygnp7drmhdxpenrbxumrjprcz7ls2afwub5lwf@due2djp7llv5>
In-Reply-To: <nwtutmewgtziygnp7drmhdxpenrbxumrjprcz7ls2afwub5lwf@due2djp7llv5>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0SPRMB0067:EE_|SA0PR15MB3821:EE_
x-ms-office365-filtering-correlation-id: 38e85b5c-5e9d-45a2-0dad-08ddca08e4cb
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MTV3VGpBRjRtNk9paWpCckhwc1p3NWN1Zmp0RERNdDYxZ2Y3enkzTHZtNWFx?=
 =?utf-8?B?UzlCU1diSWtXZFcwdUJsMENoSVAvTlNuTEJKbnowb1l4ZUdSZlRjcmhIa2tB?=
 =?utf-8?B?Y003Wi84R2hFOW5uci9JZXJhaytrWXJhTVZxcmhmRWdoQldrQUxsbk5HZ2Jh?=
 =?utf-8?B?VWRGRFpDdjF6UmNNTVNZc2pnaFlrK0hGWmtmaCtKcDc0VnFGSGU1dllnTyts?=
 =?utf-8?B?Y3hVbFhyNXM2L2g2QVpiZVppTEpBUFh1SXJzbStXYXlad3IrRUNBR0hYYldP?=
 =?utf-8?B?M1RmWWpRNG9MN0dIMHFIR3gyWWs5QVpzRVhxOWpMME1RUlB5NzZFKzZGRVIw?=
 =?utf-8?B?NWJYb2IyUzExTitnd0RVUVdzL0RjcXcwdHlqc3ZSQ2MzVTQrNHNVZ1AyTGJM?=
 =?utf-8?B?NXQ4cER5UFBRdUUvdERJNG9kdko5c1Iwazd2aGhCNEhGVzVtTHA2dDdTNkpY?=
 =?utf-8?B?TFQ4d1BxeHkvR3AwWU9ta2s4ODdhb0gwSnlpT3hScG94OVk3RjlWMVlWSnRi?=
 =?utf-8?B?Uis4YWY4dUlOME5vaGV5L1JuVjJHR3d1cEZDLzVUaG1GSy9qSmZaUlRPSGxQ?=
 =?utf-8?B?UnhvSDJ1SmFyQlRRTDFjdWZwN01RQWQ3K3gyRUFjVExVNlpZUjlBdGE0UWxo?=
 =?utf-8?B?TWVyMTJBU3krd3hqUVQzNnQrOTJZaHczVzJFK0U2REtQQUp6Zi9pZmlYNE9W?=
 =?utf-8?B?alp5QVViTHNHVFhjOC91eHlwc1BHWjVRMFRVOUtLTTg5bXBQcm4yT3E2VXUw?=
 =?utf-8?B?N1hkM05Nakd3RkEvcmVGRGFOMmY4bWpxZVI4L3JrMEdkWTBlaS9DODZzVnBw?=
 =?utf-8?B?ME5ReU1RZXFKZTBxdXFSUzRoZ2UybTQwRFVDOEU5dGttMVA5R2RCbDBDWlFY?=
 =?utf-8?B?bkNLWFNiRXl6VmxqQzA5elVyNnc0dkpLcTRZRFcwWlNsS1N0U2pZMWdvMHdU?=
 =?utf-8?B?STJsT2tCOFk4cGZWU2dGUnpDd3NTekhCZmVxbjhGYmRsYm80Rm5WSGFTZVl1?=
 =?utf-8?B?Tkh1VHNWNlRkcXNmM0t2dVY3b0VwZXBqZ0FNYmpSRXlMSkR6TEM3cXJnczJG?=
 =?utf-8?B?c3dRQnU4Y0tzaUxKaXJmeWh4KzBDVCsyekpqQm1wT0RyUEovM0dIcFdmVHFi?=
 =?utf-8?B?Ymx0dHpMUjRIcnAxNDFOQlltSGFTbFpoWGxrTjVOUkZsQWhiN2t2UEtaRXhR?=
 =?utf-8?B?MEhoTEtXc04rS2twK3l2ZFBtS3RuU2lHaDlnVitPSFZSNFN5NytYYmNVVnBJ?=
 =?utf-8?B?dlZ0UldkcnZrdGNwM3daeU0rZnppYUZxaDdxRXdOWk1ZTXdrcFBBZ0NxTkN4?=
 =?utf-8?B?dG5Xc0xEdzRGZkY1ZVQrSGJpTWN5U3FPcGc1cXJVWitiV3l6ZUhPZVpsZW9k?=
 =?utf-8?B?aG0wZm15RjhDcTNZUGxvSTZXenJ3enZ2YVRFc2FkR1VSTmIzNzdQVGdwMFk5?=
 =?utf-8?B?a3ZvRFJGb1NOYzdhNklqZ2hVSHBkSHQxTXZmQ1pWNm0xaU1MeHVQeHBkUytm?=
 =?utf-8?B?VWZKZys1KzU1UVRndHM5Qkl6R2g5eVMvbUdJeEdvZVBRaTdGczg3TDMwdXIy?=
 =?utf-8?B?UHRxWEQ1THZGN1FaaENWSFlkNlR5bFR0V3luRVhOZGlIbzhlZEhxb0Y2bksy?=
 =?utf-8?B?cTlpQVVWZXlQTko0Z3B3bVdnczFnTUZVckdZTGNWMjFmbEtiZDdGaWVLZEYv?=
 =?utf-8?B?VjIyQ3BVdGdSZVU3SjRyMWFMOFhhMm5HYkF1Nmd2ZmVublQ0OFJJYmlYbmVC?=
 =?utf-8?B?TGNLM3dkTjRlckhiSEd2aDVuR09rNkZ4RVpaOTFHSzB5N0JiVnBqWVAvSzd4?=
 =?utf-8?B?TUJLa25ZQkxUQ0xDcmlVQ21BMm45SlUyRVZpM0tBR1NPTE5FS1NBcTUrcnl2?=
 =?utf-8?B?OVlXNjlYb3I2MmZlRzdxeXdLZ2IyZnVOdlhZSUNFZ0FRMldUd2ZTdkpPZ240?=
 =?utf-8?B?bjdkNlEzQmFLdXI1NGhVZVZXNWJKTU9tT1l0YWpHMUl3SHJJd1MwUnkzSGhx?=
 =?utf-8?B?aTNEUXd4USt3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0SPRMB0067.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V083MWlsTytFQ1Vya0pPUmJvUDE5M1l5TFBpRXFhdUloNzdjcENGcWFtcUtQ?=
 =?utf-8?B?NzhIZHZURWZCYUoxQ2E5elRqUTFRMkJaT0R6SHlLZkRUSGg0V3pwbnNrR21C?=
 =?utf-8?B?d0hzelhOUi8wMVArbCtlbVl4SEZwQmdDRHZjQ2YzZnkxcUdDR0gxblJZa0ps?=
 =?utf-8?B?cmVmV1c2ZUJnYnZXRDJVQS8vMkU5RGRrUU50L3BHT2JJMmlsTkRWK3VaUjJx?=
 =?utf-8?B?eWxkUFhEWENvbjlyYk1MS2VRSVQ3eXB0SkdLTnJoaDFNN1FsZGR6MGtua3kx?=
 =?utf-8?B?WWgyaVlSZEVocGRyS2t6V1ovTXRsKzl5TDBUNld0UDdFUy9SZTV0dXVSZGE4?=
 =?utf-8?B?bkRwUVB2T0wxQVNRbjFUaHJLMkpUUENNS2U0N0JUSWVhb1IrcDZLMnZJZC9T?=
 =?utf-8?B?RzNDY2R4N3FLWU1uMDJ0T2ROQ1hlOWo2VEtySHJUeTFMU3BqZXFsNEptbzJV?=
 =?utf-8?B?WnBuTXBUb3VPbDJ6a1YzRXBIcU5MYitTdmdXM212MjF6NHExUy9CUzNQcVg3?=
 =?utf-8?B?LzU0TWt1cVV4N2VOb3NNYjVYYjBha09KQ1pQcjltVlM0eUV1Q1h6c2NnVDAr?=
 =?utf-8?B?bVRFQU1YeWw3Wm84aDhxMlJnZlVBc0ZPYk9xcTdEUVFqSjBFWDhIdjFTb0Fs?=
 =?utf-8?B?dXJCcUJXOXh1WXJLY0lzc1EvaEptaVV0eVlKYkFZRTdDQmpTZzBHNzlxR0li?=
 =?utf-8?B?S0grTTJNRFNmSGF2S3YydEpLM2ZtaTkvTGEvZ3BHeUhaY082RHFYTUhDWUh6?=
 =?utf-8?B?RjF6VklQdmZqUTBGaXowSGFBbUxxak1zQ3hnNjV2SjNTbDJ0TnFseXRDRjBQ?=
 =?utf-8?B?dzFTeVVEYVhXLzVlNEpQd09RTlZUR1EvZW44QTMxbDJPZ3gvSEs5aWZibU9u?=
 =?utf-8?B?MFRKSjdrOVlJQ2R0aDJJSXcrdGxMaUI0a0FDUFRCRWsxUFVEeFh2dERVQVZI?=
 =?utf-8?B?QlBPV1RUSGdkeW1JS1kzako4N3BFbUJIYTZMWTJpR2V4WFJkM3QvNGRDNjJO?=
 =?utf-8?B?OUlvQUdSNVdUUXkyTjd4eXBCbktETURTR3YwRGRybHRKUHErbWNUN2FtM3hp?=
 =?utf-8?B?ZStEZVFNdUpSK1VkU2VOZ0xYNm82WkpNTUJoVVRmclBmTHp4Y204ZE9uRFdH?=
 =?utf-8?B?SGx1TFMxTCtkUmRGT3E5UW55RXFTakFrN2NveTlHWnRqbnhsYXRmYnhzc1c2?=
 =?utf-8?B?UmVSKzI0YkpGYzJFQTl3QnFqdWpveXlGTG9LcjNnSEw1Ulh5RDV2YjhQSHZt?=
 =?utf-8?B?UEtiTHQ3ZVMvSnhDa1p2Z1hWMURMaFR5V1czbUxWRTd5R2VYcjRzbXV1Y2JL?=
 =?utf-8?B?ZDNlLzI3L2NIaURpSUVNNjZhVHpiMU9MTUdtL1BKMUNUdENsVE9zdWdhekpu?=
 =?utf-8?B?RlN1QUNJVThSdXo4eis3ZDhRdWJkMVlkOTR6Mjd6OVlFS2svZC82aE1KcXpz?=
 =?utf-8?B?RmNzZ1d0L0RFVTFTYmFGdVNoMFhFUDBpK05BZCtyZzhOVUFNbzc1R0hyM2Zn?=
 =?utf-8?B?ekFyRk50c0ZuY0x4WHRzRjYwTERUQjduN20vMWUyckFYMUNTUmJteVFlQjFj?=
 =?utf-8?B?YitSejYrNC9IMWVqb0w3VnlScXBLU3pHUHBRL09lclNidEFUSGRaMVhIaE5O?=
 =?utf-8?B?bE1VWEJhb29RSUdzR0lhRWlJbDlUbnV5Y3dCWC8wYVJCeU9TWG5lNnFiNkZX?=
 =?utf-8?B?d1kzSy80YXBJaGpPL0VlR2pEMFpkNHdKaytXWFVaQm9oZTdLdk1zL3poUTg2?=
 =?utf-8?B?Rm1KNlB1b1J0eENWUklrM2xVNHdTbzZqdDZFZ0ZvTHd6dWkzVjJTZEVpanh2?=
 =?utf-8?B?YTlmMjhtZ3AyeHFSUllEVXFnWmNGM2hwQkJPcW9YdGxQUGxiRDVOeWlWdk1t?=
 =?utf-8?B?QVI5ZDBkaEFUZHZiRW91d2NvVHRkemFFajlHdU5GT1cyUks1dzhiQ1J5dlpG?=
 =?utf-8?B?TE5ybHhDV2o1dDd1OVYxQTF6VHN2M0ZmaTZvQWRINUs3QWJyS3pyVldNSEU3?=
 =?utf-8?B?Y1RHTHNOQnhVSnQ1L0Q0bmxkVXAxQm16d0FBKzI0QW55Y3NPN2IrVzRudmdB?=
 =?utf-8?B?MUR1RkF1L2dSM3JqUUVSTXk2U0J2R1liV0ZVRDEvekdSRjRIOWxXRGM2b3hk?=
 =?utf-8?B?ekg4L1NqL1UyY3M0V21uazdJaThoMGJkbTY3OUppSUp1Sk1xN2VHTnRESTZY?=
 =?utf-8?Q?kUvNNAwap+oid7Y+3Zbhnpo=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS0SPRMB0067.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e85b5c-5e9d-45a2-0dad-08ddca08e4cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 16:49:30.2892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uCwJGWgspkrbIQpCcSxQpsaa2GeXAm3hQ1yHViVDR96jBQg0QAeaJa6IbUlwJ79q2dY7d45bjw/kTl6nfNt3nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3821
X-Proofpoint-ORIG-GUID: SaRKr-81A_-dr4ofoSD-nQ-kXeKJgE4r
X-Authority-Analysis: v=2.4 cv=XP0wSRhE c=1 sm=1 tr=0 ts=6881129d cx=c_pps
 a=gu6RomWtnwV9OjqK3d0IpQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=VarWvt3nGuvZ4FJz:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=VnNF1IyMAAAA:8 a=9jRdOu3wAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=SEc3moZ4AAAA:8 a=37rDS-QxAAAA:8 a=QyXUC8HyAAAA:8 a=zY-ZbBsuiQihI-GzCrcA:9
 a=QEXdDO2ut3YA:10 a=ZE6KLimJVUuLrTuGpvhn:22 a=5oRCH6oROnRZc2VpWJZ3:22
 a=k1Nq6YrhK2t884LQW06G:22
X-Proofpoint-GUID: SaRKr-81A_-dr4ofoSD-nQ-kXeKJgE4r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE0NCBTYWx0ZWRfX/A35Y7FYTzFx
 T7GPbr6nV49d6eZgD87vrcPMuuaf8xrSmcB7LwrkuVgOkVkpA68P2bKGFHrjq/JsRD5l+0jd+ae
 zTa7yE3RKOqbNYH3Rla5/Ta5B+2crNH0EzThvHv85vBdnpx9I96eJtaRcaRY2wUsRr/ml3kAIqM
 pr7wL8j7ueAw8DNMJ1vbdR6DtNUGtDol0vv0Bus1BiQ5DrfnZmwyiJtUvs3ZfyKZGEkV35zYKQ4
 ILFxMlEsxREV2t7s09QK2WQIJEQXCADGwkWHTPCEoWhyUm1PEBwgNz79s8jkTzKrozd5vjeQGc/
 0IonEVI+zILC49pnIgl7NeQ4EjTyLmlrfPpIFjVeLD5MSLfdYbdT+3hgJEGl5n0p1DQuhoJ4oDb
 S1mIAEeuJ25mq+lWaYe9uq/aZIhaULhqkzpuULcLAdVvoALN1b0C7Jf2DHmamiYhZlgKUcxe
Subject: RE: [PATCH] RDMA/siw: Fix the sendmsg byte count in siw_tcp_sendpages
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230144

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGVkcm8gRmFsY2F0byA8
cGZhbGNhdG9Ac3VzZS5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCAyMyBKdWx5IDIwMjUgMTc6NDkN
Cj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiBDYzogSmFzb24g
R3VudGhvcnBlIDxqZ2dAemllcGUuY2E+OyBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9y
Zz47DQo+IFZsYXN0aW1pbCBCYWJrYSA8dmJhYmthQHN1c2UuY3o+OyBKYWt1YiBLaWNpbnNraSA8
a3ViYUBrZXJuZWwub3JnPjsgRGF2aWQNCj4gSG93ZWxscyA8ZGhvd2VsbHNAcmVkaGF0LmNvbT47
IFRvbSBUYWxwZXkgPHRvbUB0YWxwZXkuY29tPjsgbGludXgtDQo+IHJkbWFAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7DQo+
IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbCB0ZXN0IHJvYm90IDxvbGl2ZXIuc2FuZ0Bp
bnRlbC5jb20+DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSF0gUkRNQS9zaXc6IEZp
eCB0aGUgc2VuZG1zZyBieXRlIGNvdW50IGluDQo+IHNpd190Y3Bfc2VuZHBhZ2VzDQo+IA0KPiBP
biBXZWQsIEp1bCAyMywgMjAyNSBhdCAwMjo1MjoxMlBNICswMDAwLCBCZXJuYXJkIE1ldHpsZXIg
d3JvdGU6DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+
IEZyb206IFBlZHJvIEZhbGNhdG8gPHBmYWxjYXRvQHN1c2UuZGU+DQo+ID4gPiBTZW50OiBXZWRu
ZXNkYXksIDIzIEp1bHkgMjAyNSAxMjo0MQ0KPiA+ID4gVG86IEphc29uIEd1bnRob3JwZSA8amdn
QHppZXBlLmNhPjsgQmVybmFyZCBNZXR6bGVyDQo+IDxCTVRAenVyaWNoLmlibS5jb20+Ow0KPiA+
ID4gTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+OyBWbGFzdGltaWwgQmFia2EgPHZi
YWJrYUBzdXNlLmN6Pg0KPiA+ID4gQ2M6IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+
OyBEYXZpZCBIb3dlbGxzDQo+IDxkaG93ZWxsc0ByZWRoYXQuY29tPjsNCj4gPiA+IFRvbSBUYWxw
ZXkgPHRvbUB0YWxwZXkuY29tPjsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0K
PiA+ID4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBQZWRybyBG
YWxjYXRvDQo+ID4gPiA8cGZhbGNhdG9Ac3VzZS5kZT47IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc7
IGtlcm5lbCB0ZXN0IHJvYm90DQo+ID4gPiA8b2xpdmVyLnNhbmdAaW50ZWwuY29tPg0KPiA+IFtz
bmlwXQ0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBf
dHguYyB8IDQgKystLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9zaXcvc2l3X3FwX3R4LmMNCj4gPiA+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9z
aXdfcXBfdHguYw0KPiA+ID4gaW5kZXggM2EwOGY1N2QyMjExLi45NTc2YTJiNzY2YzQgMTAwNjQ0
DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jDQo+ID4g
PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jDQo+ID4gPiBAQCAt
MzQwLDExICszNDAsMTEgQEAgc3RhdGljIGludCBzaXdfdGNwX3NlbmRwYWdlcyhzdHJ1Y3Qgc29j
a2V0ICpzLA0KPiBzdHJ1Y3QNCj4gPiA+IHBhZ2UgKipwYWdlLCBpbnQgb2Zmc2V0LA0KPiA+ID4g
IAkJaWYgKCFzZW5kcGFnZV9vayhwYWdlW2ldKSkNCj4gPiA+ICAJCQltc2cubXNnX2ZsYWdzICY9
IH5NU0dfU1BMSUNFX1BBR0VTOw0KPiA+ID4gIAkJYnZlY19zZXRfcGFnZSgmYnZlYywgcGFnZVtp
XSwgYnl0ZXMsIG9mZnNldCk7DQo+ID4gPiAtCQlpb3ZfaXRlcl9idmVjKCZtc2cubXNnX2l0ZXIs
IElURVJfU09VUkNFLCAmYnZlYywgMSwgc2l6ZSk7DQo+ID4gPiArCQlpb3ZfaXRlcl9idmVjKCZt
c2cubXNnX2l0ZXIsIElURVJfU09VUkNFLCAmYnZlYywgMSwgYnl0ZXMpOw0KPiA+ID4NCj4gPiA+
ICB0cnlfcGFnZV9hZ2FpbjoNCj4gPiA+ICAJCWxvY2tfc29jayhzayk7DQo+ID4gPiAtCQlydiA9
IHRjcF9zZW5kbXNnX2xvY2tlZChzaywgJm1zZywgc2l6ZSk7DQo+ID4gPiArCQlydiA9IHRjcF9z
ZW5kbXNnX2xvY2tlZChzaywgJm1zZywgYnl0ZXMpOw0KPiA+ID4gIAkJcmVsZWFzZV9zb2NrKHNr
KTsNCj4gPiA+DQo+ID4NCj4gPiBQZWRybywgbWFueSB0aGFua3MgZm9yIGNhdGNoaW5nIHRoaXMh
IEkgY29tcGxldGVseQ0KPiA+IG1pc3NlZCBpdCBkdXJpbmcgbXkgdG9vIHNsb3BweSByZXZpZXcg
b2YgdGhhdCBwYXRjaC4NCj4gPiBJdCdzIGEgc2VyaW91cyBidWcgd2hpY2ggbXVzdCBiZSBmaXhl
ZCBhc2FwLg0KPiA+IEJVVCwgbG9va2luZyBjbG9zZXIsIEkgZG8gbm90IHNlZSB0aGUgb2Zmc2V0
IGJlaW5nIHRha2VuDQo+ID4gaW50byBhY2NvdW50IHdoZW4gcmV0cnlpbmcgYSBjdXJyZW50IHNl
Z21lbnQuIFNvLA0KPiA+IHJlc2VuZCBhdHRlbXB0cyBzZWVtIHRvIHNlbmQgb2xkIGRhdGEgd2hp
Y2ggYXJlIGFscmVhZHkNCj4gPiBvdXQuIFNob3VsZG4ndCB0aGUgdHJ5X3BhZ2VfYWdhaW46IGxh
YmVsIGJlIGFib3ZlDQo+ID4gYnZlY19zZXRfcGFnZSgpPz8NCj4gDQo+IFRoaXMgd2FzIHJhaXNl
ZCBvZmYtbGlzdCBieSBWbGFzdGltaWwgLSBJIHRoaW5rIGl0J3MgaGFybWxlc3MgdG8gYnVtcCAo
YnV0DQo+IG5vdCB1c2UpDQo+IHRoZSBvZmZzZXQgaGVyZSwgYmVjYXVzZSBieSByZXVzaW5nIHRo
ZSBpb3ZfaXRlciB3ZSBwcm9ncmVzc2l2ZWx5IGNvbnN1bWUNCj4gdGhlIGRhdGENCj4gKGl0IGtl
ZXBzIGl0cyBvd24gc2l6ZSBhbmQgb2Zmc2V0IHRyYWNraW5nIGludGVybmFsbHkpLiBTbyB0aGUg
b25seSB0aGluZw0KPiB3ZQ0KPiBuZWVkIHRvIHRyYWNrIGlzIHRoZSBzaXplIHdlIHBhc3MgdG8g
dGNwX3NlbmRtc2dfbG9ja2VkWzFdLg0KPiANCkFoIG9rYXksIEkgZGlkbid0IGtub3cgdGhhdC4g
QXJlIHdlIHN1cmU/IEkgYW0gY3VycmVudGx5IHRyYXZlbGxpbmcgYW5kIGhhdmUNCm9ubHkgbGlt
aXRlZCBwb3NzaWJpbGl0aWVzIHRvIHRyeSBvdXQgdGhpbmdzLiBJIGp1c3QgbG9va2VkIHVwIG90
aGVyDQp1c2UgY2FzZXMgYW5kIGZvdW5kIG9uZSBpbiBuZXQvdGxzL3Rsc19tYWluLmMjTDE5Ny4g
SGVyZSB0aGUgbG9vcCBsb29rcw0KdmVyeSBzaW1pbGFyLCBidXQgaXQgd29ya3MgYXMgSSB3YXMg
c3VnZ2VzdGluZyAodGFraW5nIG9mZnNldCBpbnRvIGFjY291bnQNCmFuZCByZS1pbml0aWFsaXpp
bmcgbmV3IGJ2ZWMgaW4gY2FzZSBvZiBwYXJ0aWFsIHNlbmQpLg0KDQo+IElmIGRlc2lyZWQgKGFu
ZCBpZiBteSBsb2dpYyBpcyBjb3JyZWN0ISkgSSBjYW4gc2VuZCBhIHYyIGRlbGV0aW5nIHRoYXQg
Yml0Lg0KPiANCg0KU28geWVzIGlmIHRoYXQncyBhbGwgc2F2ZSwgcGxlYXNlLiBXZSBzaGFsbCBu
b3QgaGF2ZSBkZWFkIGNvZGUuDQoNClRoYW5rcyENCkJlcm5hcmQuDQo+IA0KPiBbMV0gQXNzdW1p
bmcgdGNwX3NlbmRtc2dfbG9ja2VkIGd1YXJhbnRlZXMgaXQgd2lsbCBuZXZlciBjb25zdW1lIHNv
bWV0aGluZw0KPiBvdXQNCj4gb2YgdGhlIGlvdmVjX2l0ZXIgd2l0aG91dCByZXBvcnRpbmcgaXQg
YXMgYnl0ZXMgY29waWVkLCB3aGljaCBmcm9tIGEgY29kZQ0KPiByZWFkaW5nDQo+IGl0IHNlZW1z
IGxpa2UgaXQgd29uJ3QuLi4NCj4gDQo+IA0KPiAtLQ0KPiBQZWRybw0K

