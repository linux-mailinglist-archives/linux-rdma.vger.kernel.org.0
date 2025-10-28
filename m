Return-Path: <linux-rdma+bounces-14102-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D352CC149FC
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 13:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875C63BFE25
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 12:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5E432D444;
	Tue, 28 Oct 2025 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SjeHRFVf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NuI+rkoS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2766C2BEC2D;
	Tue, 28 Oct 2025 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761654523; cv=fail; b=AaYa/oTPtedJ8RfwpW+l9RQSA2i3pBxN/D5zSY0t5CfRdiBL3laUk10LtZ1sqA8ryr5IBBeSVWr70ShObiUiwy7nGqL3L7kNrBV485DL2FcDd5tC4c+d1HVH4b3D2WHWUHsIpipUb7fpDiCB72fRlbHW47AEmtsWCEjwLHb4gME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761654523; c=relaxed/simple;
	bh=/Ux32WUcQBWU74T5aXRS8gJ9uyOXjZy2Qo9E9e3QASM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BJ6Hqr1Z4mQJe+t7ZWoTCN42QQZh6PfNwqWsLw/77a4MAibs79jkBhe9EJERuEqvtxhZopgNzfXaH1Y9CojsiD/qd0N9Bg5jRB6fktU/AP4n0ipWgGLQTmVPtAztJMxRVSMABUo1jtKzxELsC6IEgm5u/2AzXqcA/5thyq70Pyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SjeHRFVf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NuI+rkoS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SBDjch029182;
	Tue, 28 Oct 2025 12:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/Ux32WUcQBWU74T5aXRS8gJ9uyOXjZy2Qo9E9e3QASM=; b=
	SjeHRFVfqmDt4Q8jql5e3xECwg7oL44GDarjKBlurkY4g2uJG3dzgUqbiNNCI6Jt
	nonwZbDncmB6h+qv6sZ3QdHmdObnTvtoWP5yX1LJBQ4BM0NpteLmBqSbQ3HeC49m
	2NBHvpdL1WCpxC/o5XPrpKh2ecH4tsUtWBwyPt2PAQRBHOvjdm7V3MgorN1CA9nJ
	vqVxSDb+NM2De+SXSdqhtv8UrR4Mnw+hdjEKG7Yvb8hBr6tnLj1fE+scfw2Pb6BE
	Riv4ljvkOgKhSuzOXTTb5IajtsFSSv5IeGY2ccnVI9YBgseUz3X81MTy6gsWPw0f
	GZfXbQFA17qslHieDS6vFA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a22uubd42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 12:28:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SBNBv7037516;
	Tue, 28 Oct 2025 12:28:35 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n084dh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 12:28:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyN1f9LRULlUl12Pnd9ESce3KHmXkjlzjuZxmyQ9YTlP5cZIPt9JmNg/Wx5lVW5ldD8KPurXz8DRw/cvjHHZqucMbuJ+OAt0bi6JD2O2gOr7k+Wkx3RFLPCyDYA9EO71Gk/tR8XA2+PFWmZaQ1K94Epv0zbKNkxuFR/ioSHHqHgK3b0kZZUFU658DgOKZt+MzMJfP8xsYoh2EUJkNbZX71+YRHuJvZF3qPJc37HXEzWHNK07qqf+/4fLFEfiLollh+lU7UpodrJGZyjoe+LdyFiijhRr8fTNGXzb7VlPghwBuqp/f8mJ8bHB1H30542tNRPrxt5k/xakVprtPZYxkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ux32WUcQBWU74T5aXRS8gJ9uyOXjZy2Qo9E9e3QASM=;
 b=k3usel+oMC2ZlwC+mlc3TraFXpj8kZVWnWGRrgS42EzhaRplpRpbXn50ocObkaooMgUUbNDm3WKvN/yWUzL6Q4uW5fAv856MCX+QXaZ/S/v6Lwzj7fUsR9//s3CRW/o9B/cxK+ZThgQgGgVSgmL/hd5fyu7DK6HOgxQ0Kb0orP7SjG/idmyOPdQgfrbQzrBl4vl0B7ZD1ZnKZ8APcFMxCl4RT0ZNvW4DHD3Kn0iVmzZXCEevHpjvD1UnIxeTavzdx5qtdBP8OJVW9ysGgHG3u0EHyjLWk1SKu7jUhsbEPtCRYPU+skm/PS3aEstXD0II/D8XG7mQ6trFLbWC1p4W5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ux32WUcQBWU74T5aXRS8gJ9uyOXjZy2Qo9E9e3QASM=;
 b=NuI+rkoSs0wbPsk6voPEDT8lW5j43pHU0jixRgxJALn2jvA+u6BtO9RqMf/otawvbu9YzD4HiR2Hwlvf9MJzxa2omhXkFwWfcyEeIpCWSr7dLScjrXn844uq+lNtppPGpF/QoycKzvolmFKaqech8gg/OBug/9ZLs4Na4uEaO3M=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by MW6PR10MB7638.namprd10.prod.outlook.com (2603:10b6:303:248::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 12:28:31 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f%5]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 12:28:31 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Sean Hefty <shefty@nvidia.com>,
        Vlad
 Dumitrescu <vdumitrescu@nvidia.com>,
        Or Har-Toov <ohartoov@nvidia.com>, Jacob
 Moroni <jmoroni@google.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cm: Base cm_id destruction timeout on CMA
 values
Thread-Topic: [PATCH for-next] RDMA/cm: Base cm_id destruction timeout on CMA
 values
Thread-Index: AQHcQo58OIV2QmOFQUOEgINVc8jyirTV5tmAgAGgugA=
Date: Tue, 28 Oct 2025 12:28:31 +0000
Message-ID: <C74C62EC-EBF7-4244-9085-C3219C24EF71@oracle.com>
References: <20251021132738.4179604-1-haakon.bugge@oracle.com>
 <176156500963.450375.15935808694605364471.b4-ty@kernel.org>
In-Reply-To: <176156500963.450375.15935808694605364471.b4-ty@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|MW6PR10MB7638:EE_
x-ms-office365-filtering-correlation-id: f1bb270b-a01e-4f90-5637-08de161d8153
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MW5zZUhJbnRVTlRNNm9qWHRabWRzWFZJd2ppbjV3Vm13NlRLemhWbndxdjFM?=
 =?utf-8?B?b3EyWmJuUElaTldvWmZPM05pK3VnRytDQWd4WnpGQnFDSVNyT3RrTUYyMG8w?=
 =?utf-8?B?RStldUk4SVFmc004SFRoTnF4TTF0c05GNUlVeFVNbHBTZEU2VVVZTlpUNXRR?=
 =?utf-8?B?NUR6d1dNNWhLQUE4RE81VUl0WEJxZDBEaFNYRGxVUnhjT2hZVDd2djcrbnRP?=
 =?utf-8?B?OTh3Z3BGZmdFRzFNRDJ3TlYxUU1iR3hsbC9WcktJOUdUL01VeU1sZS9OM281?=
 =?utf-8?B?QjRPS0RwL3FEWUt4aytZc1lNMzlONnZNdCtpWnA4cXhQb29JR09NcEtuYWxK?=
 =?utf-8?B?NHhOTVRCd0JEWlhuSmNPSXUwR2tWR3hNb1JtMmRzTzhzUmd3cEZhUHFraTBu?=
 =?utf-8?B?UUsxMzJnZUY1RVp6WE9jeWc5WVhSeWNDSVVaWG9NVFZzbElnaHhXV3J3MkN6?=
 =?utf-8?B?WU8rUDNKTm1aOHVtZWR3QkJiZTFEQ3gxL2syUjB0T2JHRzVBMjFwYWdPY0pm?=
 =?utf-8?B?TTk4eStPOFZjUXU5UEFnWGNIaHAvM1FEMzRNdjF6aTB4Ylg0VEd6YmhqNkor?=
 =?utf-8?B?dnVJbm9EajBGTHpJWnQvSmF6WnhoZElKR1F3NE1tckxrL292Y3RZUVN3UEtC?=
 =?utf-8?B?TWJEWlZDTmRQbHZkdllqKzFnS0tGUFF1a0VxM1pyWnltMEpQbGQvbmU5ZzZK?=
 =?utf-8?B?QjhHbWtxb3ppMS9GckpFMklFa2FORmdhQzdxR2xzOTRwblJEenVIN043c2xx?=
 =?utf-8?B?R1Q5L21LN0ZpT3dMWjZWTllnN0ZTZW4rVHVZaWx5T2g0VHdhQ0NoMWVQZDcw?=
 =?utf-8?B?dVBTakIrVk10RWRwTlEwOU9hV1llcmZEL21oMmFoRWdZRExVTGZnK3RDeUdU?=
 =?utf-8?B?T3dMYnBITk8rdG82MXpXTlZRZlVjaUUwa1FxODkzaVVjVEV2ZEg2MmQwOWhK?=
 =?utf-8?B?NzA1M2hkZzVnd0hBNEprekE0UUxkbDFKcWlZclZ0RTlEWXRMdUcxU3pnMEds?=
 =?utf-8?B?OS9FYTdWRkZac0w0Qld0QjIzODZCYVdBSWx3RlJHOWFwQTkzUTVHSVRRa0JC?=
 =?utf-8?B?ZjVYL0FjN252Tk83dUFUdUZmQTR4UG0vaHNla1cvdk1mYTBpV0t6WXZQWk9Z?=
 =?utf-8?B?cFVpMUYvdmoyVWJFaXYvaENBQlFCelZEdVVlcW5KZTF3bkI1VC8xOWNXTDcy?=
 =?utf-8?B?VkR6VVM3WHVRMkRMQ21oQ1BVcjFhekdEenp5RWxabXp0VjRNTTdMZm9taXhZ?=
 =?utf-8?B?SmR5enBIVVNCMGRPMzNWcUw1b2dXcGgzUDRuamtFbkFROUZmVmptOHNjc3Rs?=
 =?utf-8?B?NnBhUUJWWFYzbFlqY3dpeTg5WTdFWXJDc3EzSWJYUlRwOWo5T0RCNW8ySVgy?=
 =?utf-8?B?S2dJeGJvampRbS9UQkl6TWd3Ykt2VWpSNy81QmRxdUhBdC9JVEFybjRGSllD?=
 =?utf-8?B?YmQzRzlRYlliaTVtcEZxdnJVQWlBZGxGM3g4Qm1Da1B6NGlCcHpQMVZZWWx0?=
 =?utf-8?B?cXNZWVovUmFtRE54MkMwMllLZHZ1QzZmdEZuZE9EZ3dKcFBXZVc5M0ZvZ0R6?=
 =?utf-8?B?NkJwTCsvSDJNa0l4Z1BRZmd1VjFrY0xJOWtON0QwaTJPdTNBVmFqeEZ5M0t6?=
 =?utf-8?B?Y3dyWVFSTUpwdVo1eisrRlltUlRsL3JJRG13RG8vbTh3bzVyYkh6RWVxdFZL?=
 =?utf-8?B?Q0lBWWM0eWNQdWQwdGxWbGZ0cFQ3cmJyZnRDV3VXUUtpaXBzT0tmbFdHNVpZ?=
 =?utf-8?B?d0ZCSHRtbmFGcG9xWmZuQnJQK2V1UzgyNTBMWmlYcFNCTW82TFNCZWhkekdl?=
 =?utf-8?B?QVdGaEwydmR3eGRLVUVwcndBRkt5M1VYWjhNeURZTWJkQTZ4eUh1anh1KzFQ?=
 =?utf-8?B?N3lFM29MN1hxQTQ0ZXMxWit1T3pJMWp2NEszRmxhSVBiVzU1NmlpK3lHVUtU?=
 =?utf-8?B?S3JoTXRlSnp1WmdqQk1hUVZNR2lYZU5NOG1ZU3dRazZMVlVVM3d1dlFNL3pR?=
 =?utf-8?B?M2R5VnBmRkIvZUl6SnZybUVJV2dCcmhZLzM0SnVEajFzc0lsVDYwVjBXSnds?=
 =?utf-8?Q?JDzefp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OWxKK3hXUHArSllhYzVYN1o3cExleFNoeGllQ0prNjQxaGtRQVRaaXMwVmk1?=
 =?utf-8?B?VW9ZTHFnMCtXdmhKNFVHcktqeURnT3NsRVVtd0JiangyaEdSQ3ZUM2RGek01?=
 =?utf-8?B?RU1WNDMrTVcrTkFvQ3RDM2huOC9tL2RHektWZlp6OThjZFR2Zm9iLzFxcERW?=
 =?utf-8?B?VjU4dFh1cmhFMkJOOHdadUtVeHg3aWJXTU0yc25KcWlSWWtyeWNhZGx2a1NL?=
 =?utf-8?B?LzJFejdUWGxUdjF5bGJmK1J2bDdreGczbnZqdW8vVzdmV1h2SDFjZzJKNjl5?=
 =?utf-8?B?dG5SQlM5NmtsQkZXLzZmNERnTzFPaGw2SUtPeVpSZktNZmsycU9sUWFieGh1?=
 =?utf-8?B?NEJ1YW42cU00VXo3UCs5eHRoU3l0d28yUTRtSENRanZUbzZNbDNvOFZHYi9Z?=
 =?utf-8?B?ckFrVlNFY1hSOVVpd3c3WXY3SHZhbTZUYXRBOTcyeUNYVktMNnQ5TEo5ZGRX?=
 =?utf-8?B?V0pKbHFlbFNaNkNpb1duamJaRjlwc2xHYWt6ZXFMbTdlemNKaTJBNHdZdUk5?=
 =?utf-8?B?N2VzTmQxZmxjaWtvVWxOSXovM1Y3ZVJtNFA0NC9iQmJvWXk4dDBjaE40V3BW?=
 =?utf-8?B?K256SnhPemJqWUp5QXpzL0F1Y0cvRlF1Z1VvbXlXalE4UDdRVGRsb0E2c3d1?=
 =?utf-8?B?bXh6WHBXbGRab0RnV1JmRGV6WnNQaFNOSDhIWU83RmtJd0N2UWkvRTNpMVFM?=
 =?utf-8?B?Q0dUVXdlRGg5M3BicGZ2RGJKUk9WWkpjSXhGRUg3bDk3SllSUG16OFlNMFoz?=
 =?utf-8?B?andaZzdvQWJTTGdwRERPOGx0M1BjUkxDb3AzcEcvdDZYRjVocEJ0YmNnaEpM?=
 =?utf-8?B?bkJQMXZpdjRXMERkWTFHRElmV25QTGtPY3JnaWtBdTBvamcvTXFwTTVhRHVq?=
 =?utf-8?B?ckgyZVVrWWhwRGYxQmMvRzg3eXF0QTlsVDFWeWR0bnFhSkFwc2xNWUVoMy9T?=
 =?utf-8?B?TnFQL0pKcUkvU2NWK24vQTJ4WlZRUkczSmlMbm1tZXZKZ3p5cm0xMlZSbXpW?=
 =?utf-8?B?NVRmbFJhMmlqR3BBMmJiejAvUXlSQ3VROFN1b3U0NEdaR1FzU2lpTGhhK2Mz?=
 =?utf-8?B?N2ZRcGJEQjQxRndwdjlwOW14SmtNMjBSRVhodXY0bmovM0lYSUFJdzIxTEN3?=
 =?utf-8?B?VEtJam5VMHRBNDlRZkRoM3dud05JOGZ3aGtMK3Rna3FFUUhzSDlaMFQzbFo3?=
 =?utf-8?B?RGVpR1l0MlFWZGJ3MDhNbDZma2lDT2xXeS9Wa3NZNG1LWWxNc2pnNGdNNlB6?=
 =?utf-8?B?T1hIdTBCcWE5eU05K0tCRjV2UWJSWGJGWHhZNmM2V3V2STlUQklNQVhNK0dC?=
 =?utf-8?B?WUtINXVKSEVhMFNySWpXRXdqRmc1VmF6cHgzMjhqZU1aYTd1ZnQ5RWJyOERn?=
 =?utf-8?B?NzgwaTlCOUpIWWNDeVEvL2FIYjNHK3ZQNnBIZzluTXR5Zk55bklJK0tCRVRQ?=
 =?utf-8?B?dTJUNjRQc09tL2tDU3lCOEs2RmwvdlR6bnpwMWFHTDVrM3lSZUdyam52dzNz?=
 =?utf-8?B?cERPUXBGc3dNY1J0VHF6R2RwWEpDV21WSWRYLzluQmx4MEk4K1NTcjV0bGRS?=
 =?utf-8?B?NlI4UHJRL1Z6OTBLNUxVTHhrTmRZUFg4V0RoZzRwYTBqK0c3WXV1ZzNOVll4?=
 =?utf-8?B?TmRoaUY1WlRCcFJ0alhIV29ZTENES3N5enV5VWhhWkhsL0NHNzRWV3ZwR0FU?=
 =?utf-8?B?VXd0Tm5xTFk4Q1RDZGZzN3dzSzJ6aHpCN21nRUR2SUlIMlErSUNXdHo5dXBP?=
 =?utf-8?B?dkJZUXhqelFpcXhzVlJCS09NTncwbk51Nkl1R2tBb3o1TzRTVi9FaE5nWDcy?=
 =?utf-8?B?L2htcUZzR0ZTUHl4aXpRc3F1RGZUUG1hRHFOOTRlNUtGTHp1dUFUdVAzNXM5?=
 =?utf-8?B?MXRFYzU4WUhKaEZuUkNndG1jQUU2NlcxU0pNSExEVUFZYjlvUWhDTzhNWFZn?=
 =?utf-8?B?ZUQvUFdDdVgweEluMmNHOHlrU2s1UCtibXVpdWZsbHBBcjhsdG9pOENucStY?=
 =?utf-8?B?aCt5MDNYbDVlNjY4YytJa2FGeWhsRlk3ZWo0bDdqdzJxZm02S2Q5SGVuR0dF?=
 =?utf-8?B?YzBXTklHY0h3Zy80ejhyRkwxODFjam5iZjIxQ2U5c0xxK2F3MDdxOVA0TTl1?=
 =?utf-8?B?S2NMQ1U5dTVoampYQmlaVGoyZzBVekNPZDNQUWNHWFBOR1hFdEhPR3ZRQS9n?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D6E8A4A172F1A47A145054438359BAD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pQPDnGVpvbRlh92zrPID2gNXmOHe/LtvoSNpNAtN6oVB1mVqXDJMO5oA4B4FQMmDgIrq/ztmn3oNQ7mYr+0sxnd4FgcEvMwIIQM7KdLhqAa1DHTFLCuXUt+YhXSg0AFYaSA4w8goAwmSZt2BBWkaJ8eZFccNfbRulZk4Z+sBzI8yEQLOQvRSkHSRY2Ab1DQwohVlcWY/fzZ/brseH15GThfbQPTzKJ0XXsWB6dk36OgNU/684n6uPOJJh3gkuBb/Cv+V3rmmke0TywIwNiFNwmUi/3JJNI1w2lsUFfrKe8ZQy21M6gVFONKWb0HU9D7/OHU1j2mv+hzLTEji1Nkr/LkXWZWkds0xzIy5p7jiXLQDnrSHrLRwZ1aOJLMone2u7Oh9ae0+GffPzLVJ/oBSOTY10g/3vbwzDMsc0XM9j9SLNxkUOjsmhU3zZELkYrw4IAshnoDuJo2F2mTa8HDlW+TBfrQ+CG6PcogONek0xlDHvjMxz/KHQPowbUGag2W1d3iobHzDtWH4zbpGdpDq4XuVab+1CkKeuvhA67/0Kj1A+GbFv07nrb/PGfYDC3WfMAHp0W8dkWWULx4fpw5bbUkiWAO5+gAxDrF0djHiVOA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bb270b-a01e-4f90-5637-08de161d8153
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 12:28:31.2405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oJe9exWCve8cFJbkKeb+YR380f3cjdAOlNH3zOquxKHkyQdeo9efediK5L3okcg8LwypeBh5l8Iu7BiU88bRjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7638
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510280104
X-Proofpoint-GUID: V-FkzCfopyxUiJJlcWZ_JtrcHYvCsR04
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MSBTYWx0ZWRfX5TfQCxo+Y73m
 yZtvBjKZ31LbNAlKsNstZ1qCfmj8KjaqCW7kf1rWrK1mAcLcTI/uQJhHbpu2KEIWmmLBESt+Iwz
 +sdLKXRmc8HDf1xR73C+/6VPeg3jdCKi8YyQekj0F+aX6IpDBXzz2SP3VgrKHeCzAs3QfR6GEd2
 fH8aAqk9hSIUSvDmmPU+z1HwWgn77TSWs4PvECUp8iimaOw+Aj9fGTaQOFEHsE1EnDw8cFXrO8o
 ZIT3Lpgob1H4SYvCsion1rCt8XLdg3un0dS0wz6Di1cBKnPwCg/FsVVU1OUGUm84MhLqqRt+zT/
 oAFqxSaP4f759Lc43C7pHjfgQBghbw5F0RfuOfHk3vtIz5PZuqq6I4bWOuKWUWlu5jwXB2h8h0f
 eeffjpbzdkDp4tK/0642iYx01Mhw5w==
X-Authority-Analysis: v=2.4 cv=Xe+EDY55 c=1 sm=1 tr=0 ts=6900b6f4 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=cvz2JWPksk8YKr9w-LkA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: V-FkzCfopyxUiJJlcWZ_JtrcHYvCsR04

DQoNCj4gT24gMjcgT2N0IDIwMjUsIGF0IDEyOjM2LCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiANCj4gT24gVHVlLCAyMSBPY3QgMjAyNSAxNToyNzozMyAr
MDIwMCwgSMOla29uIEJ1Z2dlIHdyb3RlOg0KPj4gV2hlbiBhIEdTSSBNQUQgcGFja2V0IGlzIHNl
bnQgb24gdGhlIFFQLCBpdCB3aWxsIHBvdGVudGlhbGx5IGJlDQo+PiByZXRyaWVkIENNQV9NQVhf
Q01fUkVUUklFUyB0aW1lcyB3aXRoIGEgdGltZW91dCB2YWx1ZSBvZjoNCj4+IA0KPj4gICAgNC4w
OTZ1c2VjICogMiBeIENNQV9DTV9SRVNQT05TRV9USU1FT1VUDQo+PiANCj4+IFRoZSBhYm92ZSBl
cXVhdGVzIHRvIH42NCBzZWNvbmRzIHVzaW5nIHRoZSBkZWZhdWx0IENNQSB2YWx1ZXMuDQo+PiAN
Cj4+IFsuLi5dDQo+IA0KPiBBcHBsaWVkLCB0aGFua3MhDQo+IA0KDQpUaGFua3MsIExlb24hDQoN
Cg0KSMOla29uDQoNCg0K

