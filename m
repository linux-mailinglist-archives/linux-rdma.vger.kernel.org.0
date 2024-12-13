Return-Path: <linux-rdma+bounces-6507-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C9D9F0BCC
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 13:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F024188958A
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 12:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DA11DDA39;
	Fri, 13 Dec 2024 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cXwvYRxg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F112F43
	for <linux-rdma@vger.kernel.org>; Fri, 13 Dec 2024 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091287; cv=fail; b=Y3SQs9dejICCKS7d2FPVTFvCpjCtRm1zCoVcfkRWC2RD6xuOLULI8j/ay0QwCDDFfpMMpHPeukdoDfMzu+SEYNhww9/UDfdO1Ee67cv7kkZQmG2A2ALwdXkIhXzzR8+BJ6OwJiMDZh4Dk/ZJuhokurrr6lMaNzx4KY1BucrPEEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091287; c=relaxed/simple;
	bh=gNehuBc2DDYyf7NEur1ceOybmf9JZHhBJ/cGuwiatDA=;
	h=From:To:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=El0gnlkzUwFSzQbTK7Rzd6yL/rAkWP1qwTW/ommlyjdUrw6NNGD3tFUeut51b0dEk1LYeQN1x8cwJ5HTNVL92R7buQyhh1HXTVSF1WPSucrvesAsZD1G1/uouicPmUznUxCakp6e52bCsIPglO66SRiB+xXQvpxA/R3TmIWkzKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cXwvYRxg; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCNx7b4028917;
	Fri, 13 Dec 2024 12:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gNehuB
	c2DDYyf7NEur1ceOybmf9JZHhBJ/cGuwiatDA=; b=cXwvYRxg4SUAmvkcGWV3O/
	391Cedcnxw9eI6EXpKB0rqLK1IUcZ2tql2LIpFYU3ed749DIV/pkniGNpHGV49fo
	hrsHY7GiLvdIlGz3wLkXiTWEl+VF+ojGzZEeBDzlJJPNngRmJgoEa8ye2epHrZkW
	3GYLFWPYPikgdPbpV5UMhDKore8q4uiPKohzdDN72QMu66tFkn/D/gcgPdPfstiZ
	f9mM9hFGB6D0//ctvgHEgalGJxy04NKp0z2l7mMVn/5XYWWSjyjVT1aMr6j0OK4v
	5gYlxZJ3ZT2M4dmrUk0kC6ASTNNmNiCLBKaPG+yhU4C0iMa9muxLUV8QdvfuDuRg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43g9yhjssf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 12:01:14 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BDBvkr0009782;
	Fri, 13 Dec 2024 12:01:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43g9yhjssd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 12:01:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hf9C6uWs85fffOgaNBu+o2OWa5eVpzVAnhzAvjiveq2gBy+JiXNuEpEBnlUiCGVxj2gdvMppuOcPWjvVkkjDJK2Se4heNQ9GmWQNUmwaQitc0fH/qLAqsUTDJHnmvrbOkZ6SnKMcCDtZeiVIYzDgR0I3ZbsLP2iOdNfAc5XoEoMzwyZp8BqmFC0HDa+d9aG5JhD/lXLUN25yEVTz9F7P5koqgrK5QTxCPhO1JaYkm5FfrU6b129eGCpA18CYkSf5YwhOwyci3tW4gzPdKXGCIjNhqvhPfieG4/sCs/TppX1MaTM4am6mF/iqJQwYrH+lloSUaZCTPSGcNOONznmC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNehuBc2DDYyf7NEur1ceOybmf9JZHhBJ/cGuwiatDA=;
 b=PQ2Tqf4tdUM2UgdYtRRjRtfzBqBl+aFpq44jBDKfy3EeELOXuywVCNvX2d4PTu/2sMVh0NIg45SozuEn9nKRH7F0OED3Nnl0asoxInRASi2NHoMm73tX8LNqfAhY0XSJJrzroyAp/oAMhUbicnsjaxqor3UvH99Lzs2hB1wJkVxf4EbWKntsrj3DfdGLcEKUWUMEs1tfJdllZWtZC82X6hU5gjLfogDF8+LMvTj3c10fs/eutVauSdp4Jfc8K4e65isxmvMddnn5r5oUmKy3x6NThigAM53vhwbNldWDTHFGjmui64dylZgUF06dz1frw0PBZA+xRTqCxsIxTB70kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30)
 by MW3PR15MB3964.namprd15.prod.outlook.com (2603:10b6:303:43::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 12:01:12 +0000
Received: from BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16]) by BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 12:01:12 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Honggang LI <honggangli@163.com>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] workqueue: WQ_MEM_RECLAIM
 nvmet-wq:nvmet_rdma_release_queue_work [nvmet_rdma] is flushing
 !WQ_MEM_RECLAIM irdma-cleanup-wq:irdma_flush_worker [irdma]
Thread-Index: AQHbTUMft3TSI+MuL0uqskKYUnqaHbLkEmAA
Date: Fri, 13 Dec 2024 12:01:12 +0000
Message-ID:
 <BN8PR15MB2513DD09FA9926D11DA8C53E99382@BN8PR15MB2513.namprd15.prod.outlook.com>
References: <Z1wBEgluXUDrDJmN@fc39>
In-Reply-To: <Z1wBEgluXUDrDJmN@fc39>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2513:EE_|MW3PR15MB3964:EE_
x-ms-office365-filtering-correlation-id: 8cd69f4f-debd-4b5c-8dc1-08dd1b6dd697
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SlFOd1hmcDVWb2hxUUFjQ2V6UzBvbHlNKzd5SDhneHlvL2I5U1hjK0lvcGU0?=
 =?utf-8?B?SlY3RkVKVjZYYVpvRnVhZ0pwSGhZZ3ZHZy9MQ2pValhzSFI0dU9jb0liYVVD?=
 =?utf-8?B?QUhtL2tiKzN2MWlaMVZyUGhZMTVPUWZ4eVAzdFAxK2hGcHl6Nm1MZW14cWgy?=
 =?utf-8?B?Vm1yYm55S1VSeUNFSjFmWW9UUjl5b01Dc21XekNCYnhUU2Ewd3pOanVkM3Bv?=
 =?utf-8?B?dytoMGxMWmVuZTVCK1Q4ZHZDdHMxeVY3bzdtTHBEakNiM2RCTHh6QTJmTDBu?=
 =?utf-8?B?TkVGMktFbTdPVkxvdjdTNUIxdVFzZWVHanRMVlBoblhmZnlPbk1KZmN0QXlz?=
 =?utf-8?B?dmNCcm9uODc4SUwwSzNsTFNNbFpXdFRtaUJaMEV0S3pMQTlzbDRiSW1qTk5k?=
 =?utf-8?B?YjR2SEJRbUNleCs0SWVPbUFqVGhPQnREUzY1cWF4TlF4bjU2dnUrWTJseWhU?=
 =?utf-8?B?TWJ3TktNVWJLLzJ6ZDhWWTJ4eG5yS2xKa3ZxY095Uy9PV21YaU4ybzF4enRi?=
 =?utf-8?B?TXJiSFU1K3hsRHY5UVZJTS9ZYytBYXhudzJMOUczSnpiM0FvTDJnYlNIYTNE?=
 =?utf-8?B?QW1kTTBTNXZXaFpCenQ5NVNTTnc0NDR5VWc5VVFMNVhIWjZzejRQNHlocytT?=
 =?utf-8?B?VkdSMTRWYk5oK2Z1c2VmMnRxemptZWVEM2xWVGhtcmtRS2pzL2t4NzhhR1Bw?=
 =?utf-8?B?S3k2WDl1RXlmL1QwLzJiWDNhQkEyTnBjYkFKNmJDNFBZU29nSUpYNDJ3MnpQ?=
 =?utf-8?B?TGRMelhYWkpOR04weDl2K3pkM2dVaFZQVzJOalBxUjE5RmRIMWd5alVacHdv?=
 =?utf-8?B?b1cxNWhUUUJXUXFmS0tBb0ZmVnhPemJMNWFUNUFwMmE5YVhCU3FyN0xDL0tu?=
 =?utf-8?B?OTJkY0VtODFTZURpN2Nsb01rSkZDNXNzdGdJVTFId29KdDg3Z0FCNHpWSTFW?=
 =?utf-8?B?dTIwRWNoR0UxZmNFL0tpcGhFbkxuOU1sZkI4TWhsU2IvMnR2ZnlWQVZJL3FE?=
 =?utf-8?B?d2ovcGY4U05TRjVtZ1lLdzJBOUxLWGVYL1g5VThQamN0bGF1ajRKT0dpdEVX?=
 =?utf-8?B?TXB3d2tid29LVEYrUmpOaHd4OW54QkNOdE5VQVVEd2NsVXVGUmxRakk2ZTFJ?=
 =?utf-8?B?aEFYeEEzSE53dzIrS1pEbStyekFWRzYrMHk3ZStycTA4cDJSN1lSMmlZK0Nm?=
 =?utf-8?B?cVpmQjQ3ODdlcUlpYS92OXA3VVlrTDdMelBPSWdrQ1M2amx5RXR0WWt2aFMy?=
 =?utf-8?B?VDhtMFEvZVR0NXJJV1Zna0VNbHRIT09JbEJBd3lNVy9mcE5jWmt5UGJETUNI?=
 =?utf-8?B?eXdqT3Z5aFRTUjZCTERINlZQRTZ5ZDBIQXpKdVJyYnpGMzZGV3AxTkJ5c1I4?=
 =?utf-8?B?a3BaaXhyZzVHZEVSc2t4NGlia1ExRGQ4dHJteGk1MXplU3pKNVp3UGQrVWFz?=
 =?utf-8?B?SVJIbXRsK2RSTEtRdThkRUd5bXNrTGtlOHU5VlM0WW5TS28rZGtqN3NFRExa?=
 =?utf-8?B?Y0tMN08wZ0J3QkViK2s2S3VaUDZLckx0MThCZTJiT1RycFo4bi9OZGwyZ0F2?=
 =?utf-8?B?VHBGQmV2Mi9xQjhRRXpWYytDaUlDcDhsTHNJNGpSczdYbnVjQktEWkVhaENC?=
 =?utf-8?B?bFI4cnIxVXNYSEJCYlhXRmVxTVlIQmxRYktWL2trcStMdUV6TEhRM2EyMjRP?=
 =?utf-8?B?dmlvSGdnaHhlZWY0NE1md08yUkVsei9lMllaL3FBazlSYUJ1ZzFZWDd0b1Ur?=
 =?utf-8?B?QXFESUN5MGwyZmJkN0VNQnRZeG1TTUJRMmJzQjVpSERuZThXUEVNN1hLSWNu?=
 =?utf-8?B?Z04rU3YzRHpqRUsxdnNxVm5BU3BZaW9NSktjUDVXQjlaK2I1VXByVjI0Z1ZL?=
 =?utf-8?B?L0lBZmk0SDFibTcvdko4ajVySFVHZDhRTVU5MDc4THRRaGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2513.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTdZMnp4NHZIa0ZPbmlrbWhIRWI4SXpSOHNCbGRNZU5rNm9aelR4anhGTTBT?=
 =?utf-8?B?d2ZxQmY0OHUxdFg2ZHl3MEN1a29vMnpEVkRpZnBZUm5GR21vVzRYejJsa2lZ?=
 =?utf-8?B?azREZ3Vac090SFI5clYzdjZNdXRrYmwxNnNGWHBid09nbjNoOEFsSndTMncv?=
 =?utf-8?B?OWNMZS9TSGd3SzRCb2gxMytIN3k2ZUFJNjV6R3JtcmtpZFRFNUs0R1pLbko0?=
 =?utf-8?B?VHJYUEg5TmhvU3ptREFvYUdBS0wzSkJ5aVhGYXI4MVZtSXQ3cG5HMi9lQXFF?=
 =?utf-8?B?WWdyaGgxckZPOVJXc1FIRkxJbWVNNXZBOXg2Qkt4TVZXRmpndlM5VDdPdk5l?=
 =?utf-8?B?a0lOSXh2K1Q2eklySnBtWCtiRGNQclo5dTB6WXp0NWRNSnVZUzA4c29nSDU3?=
 =?utf-8?B?SFAwTkdlbC80dHNNWWZPSEZ6OWxneEs1bWFJaXc2eE1BZzVWUjM5dlBkSWRq?=
 =?utf-8?B?RHlWanFYZ1B6LytDOW1icmljMmtnRExLU2tYelNtNTJNQkkxZllDMHF4azJM?=
 =?utf-8?B?Nk1JQjh1b29uL04zZ0RtYU5la1FjQWFIMjEydDlETjBtSlhPR2ppbWRRNjZ1?=
 =?utf-8?B?VjFlQUdheE91V3c4MjhqNHV1S1JwNlFYVzRMM2VCR2tRQTNuMGFOM1l1VU9S?=
 =?utf-8?B?THJVOXdnNTNXZTAxclgvaW1FLzVwUENtL0ZkM0o3a0taazlEM2IzT1lwb2V4?=
 =?utf-8?B?QXNKZ1Q5dWtkZjl2SFh6L0c5NDYxZG1WZDBXN2F6NUhCOEhTdXNUMElpN1ZZ?=
 =?utf-8?B?K2ZITEVTdUNBTVl2Q1F2WkhhQ0k5R0toZUJOZTR1M1BueEo5WnQyRjNVa2ox?=
 =?utf-8?B?d1JLTy80bFFTbzM5R2JFS1lSdWlqbGYvTEQ3R1N2VEpQL1NpMjBMLzVmZHdr?=
 =?utf-8?B?YTFMUk9LK1ZKNDJ4Z1dtUWVRUXQxcFVSc2dSbUFFWlJad05TZzZLN2RQZ05r?=
 =?utf-8?B?dWhJOXdyQjJmTGkwMy9COVNaQVZOWm0vVEpQZ21BM09TeFd1Z3dKRW5SRjVW?=
 =?utf-8?B?ZDNGVk5mR1Z3akgyaGhwa05ySjluNjQ3cXk4c0svNTJLYmpkdE5HU01DRUJT?=
 =?utf-8?B?dDY1ZkZNb2RSeUQzSllkMDc5cGR4SjZNVUNFQ1dreW5oVDBkUXJUYTN5NmNE?=
 =?utf-8?B?T1NYb0pTWnFZakhmR1ZqSldqd2IwUHJZSXZ0RW5Bdm5KdURtcFhHZ1RYVVlv?=
 =?utf-8?B?YXowdXZrczlIVkxIZUR1VzZ3RERMYmMwdXBWTS9jaXhFU3ZTZTZlY0lWWi9S?=
 =?utf-8?B?eWtSL1BFa0FKbmZHYmNjMXMrdmtZL213RmhMTk9teUJ0VTZPVnR1dmlVRVht?=
 =?utf-8?B?L3RRU3RsNWs3NmpuZUpueTZ5VzZXSk1JdysyVjQwdENaRENNSXhGcThsTFg2?=
 =?utf-8?B?VFRyaE55emhsUHM2UFJyajIrRm96RTZQUFl2SW8zeWN0bldDQVE0cXVxT3kz?=
 =?utf-8?B?SVRLbXFyQ3pISStzVWM4NHlrQXpHVm02VGdaai9kbzg2TmNOUHp2ZWQveHJk?=
 =?utf-8?B?eGg5aEdrcVhMTDFoSjRuN3pwZm9saFFKaERhL1gyeE5JK21URXhCZTlEakp3?=
 =?utf-8?B?NkFrMG1JMXFQRGNwNHBzcjJVUGVLYXR5WHJrdGYxSHNEVTBldDNZb3ZDaXZM?=
 =?utf-8?B?ay81Z3BoZFpSZVUyVEIyMFg3T084R3JYWndFTzNFZytpUHZORzZPakxmQzZU?=
 =?utf-8?B?cGl1UmpzVE14YURWa09pQ2Z3bCtFYWR4dU40c205Q0taNi9JRHkzSm0vSGk0?=
 =?utf-8?B?WnVkbWR2bUxxNDVFb1krK2FaVGZJdUVBR1NjdkZaSkwrQ3FmYlpWZklLc1Mz?=
 =?utf-8?B?aUczalhtckJPNno5UWR3bVZxQk1yb0Zvb3JRV0tuR3plU05WVUY5QmdIZGFG?=
 =?utf-8?B?Z0RJV1V5SDkyQXRiYmdkck9HM05OR3FRL3NKSVgzKzJMTmxWVzNmeXQwRU56?=
 =?utf-8?B?ZDZTZHZFS2pKSXNlRFlDaGpNWnhGZnliTXhPU01RRVNtNWlPK3ZqUWo1a0Jk?=
 =?utf-8?B?TUYvMWRXRmpMandqcno5Si9RY3IxaWJFcllpdm1XZGduVS9YVEZ2d0g4cVhT?=
 =?utf-8?B?aGZjVkIvZkdyT3ZqOWZ6YlpIdlpBN2FSdFBPRjFzUmdyTUhGcWVPRjNqQ3hu?=
 =?utf-8?Q?qRnQTTA/7ZuRweQrqxzOUQlda?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd69f4f-debd-4b5c-8dc1-08dd1b6dd697
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 12:01:12.1504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qWpx3IrCGlhi3HbMTDRKbXusAVIl3TGMCRaip4djX5T17TbUocnH5SEtimUWXNZ5DLAIODjLuae695C0SMnLVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3964
X-Proofpoint-GUID: xbFe5Cd9-HTvwxWXVlLOgN-VMINWISa7
X-Proofpoint-ORIG-GUID: eJqXv4l1nUHeZpaMpK03kvUg6rCm3yc6
Subject: RE:  workqueue: WQ_MEM_RECLAIM nvmet-wq:nvmet_rdma_release_queue_work
 [nvmet_rdma] is flushing !WQ_MEM_RECLAIM
 irdma-cleanup-wq:irdma_flush_worker [irdma]
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130084

UlhFPyBUaGVyZSBhcmUgaXJkbWEgY2FsbHMgb24gdGhlIHN0YWNrPw0KDQpIbW1tLg0KDQoNCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIb25nZ2FuZyBMSSA8aG9uZ2dh
bmdsaUAxNjMuY29tPg0KPiBTZW50OiBGcmlkYXksIERlY2VtYmVyIDEzLCAyMDI0IDEwOjQxIEFN
DQo+IFRvOiBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXJkbWFAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gd29ya3F1ZXVlOiBXUV9NRU1fUkVDTEFJ
TSBudm1ldC0NCj4gd3E6bnZtZXRfcmRtYV9yZWxlYXNlX3F1ZXVlX3dvcmsgW252bWV0X3JkbWFd
IGlzIGZsdXNoaW5nICFXUV9NRU1fUkVDTEFJTQ0KPiBpcmRtYS1jbGVhbnVwLXdxOmlyZG1hX2Zs
dXNoX3dvcmtlciBbaXJkbWFdDQo+IA0KPiBJdCBpcyAxMDAlIHJlcHJvZHVjaWJsZS4gVGhlIE5W
TUVvUkRNQSBjbGllbnQgc2lkZSBpcyBydW5uaW5nIFJYRS4NCj4gVG8gcmVwcm9kdWNlIGl0LCB0
aGUgY2xpbmV0IHNpZGUgcmVwZWF0IHRvIGNvbm5lY3QgYW5kIGRpc2Nvbm5lY3QNCj4gdG8gdGhl
IE5WTUVvUkRNQSB0YXJnZXQuDQo+IA0KPiBbIDY4NS43NTczNTddIC0tLS0tLS0tLS0tLVsgY3V0
IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiBbIDY4NS43NTg3MjVdIHdvcmtxdWV1ZTogV1FfTUVNX1JF
Q0xBSU0gbnZtZXQtDQo+IHdxOm52bWV0X3JkbWFfcmVsZWFzZV9xdWV1ZV93b3JrIFtudm1ldF9y
ZG1hXSBpcyBmbHVzaGluZyAhV1FfTUVNX1JFQ0xBSU0NCj4gaXJkbWEtY2xlYW51cC13cTppcmRt
YV9mbHVzaF93b3JrZXIgW2lyZG1hXQ0KPiBbIDY4NS43NTg4MDldIFdBUk5JTkc6IENQVTogMTYg
UElEOiAxODk3IGF0IGtlcm5lbC93b3JrcXVldWUuYzoyOTY2DQo+IGNoZWNrX2ZsdXNoX2RlcGVu
ZGVuY3krMHgxMWYvMHgxNDANCj4gWyA2ODUuNzYyODgwXSBNb2R1bGVzIGxpbmtlZCBpbjogbnZt
ZXRfcmRtYSBudm1ldCBudm1lX2tleXJpbmcgdGNtX2xvb3ANCj4gdGFyZ2V0X2NvcmVfdXNlciB1
aW8gdGFyZ2V0X2NvcmVfcHNjc2kgdGFyZ2V0X2NvcmVfZmlsZSB0YXJnZXRfY29yZV9pYmxvY2sN
Cj4gcnBjcmRtYSBxcnRyIHJkbWFfdWNtIGliX3NycHQgaWJfaXNlcnQgaXNjc2lfdGFyZ2V0X21v
ZCB0YXJnZXRfY29yZV9tb2QNCj4gcmZraWxsIGliX2lzZXIgbGliaXNjc2kgc2NzaV90cmFuc3Bv
cnRfaXNjc2kgcmRtYV9jbSBpd19jbSBpYl9jbQ0KPiBpbnRlbF9yYXBsX21zciBpbnRlbF9yYXBs
X2NvbW1vbiBzYl9lZGFjIHg4Nl9wa2dfdGVtcF90aGVybWFsDQo+IGludGVsX3Bvd2VyY2xhbXAg
Y29yZXRlbXAgc3VucnBjIGt2bV9pbnRlbCBrdm0gaXJxYnlwYXNzIGJpbmZtdF9taXNjIHJhcGwN
Cj4gaW50ZWxfY3N0YXRlIGlyZG1hIGlwbWlfc3NpZiBpNDBlIGlUQ09fd2R0IGludGVsX3BtY19i
eHQNCj4gaVRDT192ZW5kb3Jfc3VwcG9ydCBpYl91dmVyYnMgYWNwaV9pcG1pIGludGVsX3VuY29y
ZSBqb3lkZXYgaXBtaV9zaSBwY3Nwa3INCj4gbXhtX3dtaSBpYl9jb3JlIG1laV9tZSBpcG1pX2Rl
dmludGYgaTJjX2k4MDEgbWVpIGkyY19zbWJ1cyBscGNfaWNoIGlvYXRkbWENCj4gaXBtaV9tc2do
YW5kbGVyIGxvb3AgZG1fbXVsdGlwYXRoIG5mbmV0bGluayB6cmFtIGljZSBjcmN0MTBkaWZfcGNs
bXVsDQo+IGNyYzMyX3BjbG11bCBjcmMzMmNfaW50ZWwgcG9seXZhbF9jbG11bG5pIHBvbHl2YWxf
Z2VuZXJpYyBudm1lIGlzY2kNCj4gbnZtZV9jb3JlIGdoYXNoX2NsbXVsbmlfaW50ZWwgc2hhNTEy
X3Nzc2UzIGlnYiBzaGEyNTZfc3NzZTMgbGlic2FzDQo+IHNoYTFfc3NzZTMgbnZtZV9hdXRoIG1n
YWcyMDAgc2NzaV90cmFuc3BvcnRfc2FzIGRjYSBnbnNzIGkyY19hbGdvX2JpdCB3bWkNCj4gc2Nz
aV9kaF9yZGFjIHNjc2lfZGhfZW1jIHNjc2lfZGhfYWx1YSBpcDZfdGFibGVzIGlwX3RhYmxlcyBm
dXNlDQo+IFsgNjg1Ljc3Mzg5MV0gQ1BVOiAxNiBQSUQ6IDE4OTcgQ29tbToga3dvcmtlci8xNjoy
IEtkdW1wOiBsb2FkZWQgVGFpbnRlZDogRw0KPiBTIDYuOC40LTMwMC5wYXRjaGVkLmZjNDAueDg2
XzY0ICMxDQo+IFsgNjg1Ljc3NTI2N10gSGFyZHdhcmUgbmFtZTogU3Vnb24gSTYyMC1HMTAvWDlE
UjMtRiwgQklPUyAzLjBiIDA3LzIyLzIwMTQNCj4gWyA2ODUuNzc2NjI3XSBXb3JrcXVldWU6IG52
bWV0LXdxIG52bWV0X3JkbWFfcmVsZWFzZV9xdWV1ZV93b3JrDQo+IFtudm1ldF9yZG1hXQ0KPiBb
IDY4NS43Nzc5OTNdIFJJUDogMDAxMDpjaGVja19mbHVzaF9kZXBlbmRlbmN5KzB4MTFmLzB4MTQw
DQo+IFsgNjg1Ljc3OTMzMV0gQ29kZTogOGIgNDUgMTggNDggOGQgYjIgYjAgMDAgMDAgMDAgNDkg
ODkgZTggNDggOGQgOGIgYjAgMDANCj4gMDAgMDAgNDggYzcgYzcgMjggZmUgYjEgYjIgYzYgMDUg
NGYgOTcgNTkgMDIgMDEgNDggODkgYzIgZTggYTEgOTEgZmQgZmYNCj4gPDBmPiAwYiBlOSBmYyBm
ZSBmZiBmZiA4MCAzZCAzYSA5NyA1OSAwMiAwMCA3NSA5MyBlOSAyYSBmZiBmZiBmZiA2Ng0KPiBb
IDY4NS43ODIwNTBdIFJTUDogMDAxODpmZmZmYjMxMzQ4NzkzY2M4IEVGTEFHUzogMDAwMTAwODIN
Cj4gWyA2ODUuNzgzMzk4XSBSQVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJYOiBmZmZmOTZjNzA1NzU0
ODAwIFJDWDoNCj4gMDAwMDAwMDAwMDAwMDAyNw0KPiBbIDY4NS43ODQ3NDRdIFJEWDogZmZmZjk2
Y2U1ZmNhMThjOCBSU0k6IDAwMDAwMDAwMDAwMDAwMDEgUkRJOg0KPiBmZmZmOTZjZTVmY2ExOGMw
DQo+IFsgNjg1Ljc4NjA3N10gUkJQOiBmZmZmZmZmZmMwZDIxN2YwIFIwODogMDAwMDAwMDAwMDAw
MDAwMCBSMDk6DQo+IGZmZmZiMzEzNDg3OTNiMzgNCj4gWyA2ODUuNzg3MzkwXSBSMTA6IGZmZmZm
ZmZmYjM1MTY4MDggUjExOiAwMDAwMDAwMDAwMDAwMDAzIFIxMjoNCj4gZmZmZjk2YzcwZDJhYThj
MA0KPiBbIDY4NS43ODg2ODhdIFIxMzogZmZmZjk2YzcwNDNjNmE4MCBSMTQ6IDAwMDAwMDAwMDAw
MDAwMDEgUjE1Og0KPiBmZmZmOTZjNzA0MTQ3NDAwDQo+IFsgNjg1Ljc4OTk3MF0gRlM6IDAwMDAw
MDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjk2Y2U1ZmM4MDAwMCgwMDAwKQ0KPiBrbmxHUzowMDAw
MDAwMDAwMDAwMDAwDQo+IFsgNjg1Ljc5MTIzOV0gQ1M6IDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAg
Q1IwOiAwMDAwMDAwMDgwMDUwMDMzDQo+IFsgNjg1Ljc5MjQ5NV0gQ1IyOiAwMDAwN2Y4MjA3MTUx
MDAwIENSMzogMDAwMDAwMGQxNTQyMjAwNiBDUjQ6DQo+IDAwMDAwMDAwMDAxNzA2ZjANCj4gWyA2
ODUuNzkzNzQ1XSBDYWxsIFRyYWNlOg0KPiBbIDY4NS43OTQ5NzNdIDxUQVNLPg0KPiBbIDY4NS43
OTYxNzldID8gY2hlY2tfZmx1c2hfZGVwZW5kZW5jeSsweDExZi8weDE0MA0KPiBbIDY4NS43OTcz
ODJdID8gX193YXJuKzB4ODEvMHgxMzANCj4gWyA2ODUuNzk4NTYzXSA/IGNoZWNrX2ZsdXNoX2Rl
cGVuZGVuY3krMHgxMWYvMHgxNDANCj4gWyA2ODUuNzk5NzMyXSA/IHJlcG9ydF9idWcrMHgxNmYv
MHgxYTANCj4gWyA2ODUuODAwODgyXSA/IGhhbmRsZV9idWcrMHgzYy8weDgwDQo+IFsgNjg1Ljgw
MjAwM10gPyBleGNfaW52YWxpZF9vcCsweDE3LzB4NzANCj4gWyA2ODUuODAzMTA3XSA/IGFzbV9l
eGNfaW52YWxpZF9vcCsweDFhLzB4MjANCj4gWyA2ODUuODA0MjAwXSA/IF9fcGZ4X2lyZG1hX2Zs
dXNoX3dvcmtlcisweDEwLzB4MTAgW2lyZG1hXQ0KPiBbIDY4NS44MDUzMTVdID8gY2hlY2tfZmx1
c2hfZGVwZW5kZW5jeSsweDExZi8weDE0MA0KPiBbIDY4NS44MDYzNzNdID8gY2hlY2tfZmx1c2hf
ZGVwZW5kZW5jeSsweDExZi8weDE0MA0KPiBbIDY4NS44MDc0MDddIF9fZmx1c2hfd29yay5pc3Jh
LjArMHgxMGQvMHgyOTANCj4gWyA2ODUuODA4NDIwXSBfX2NhbmNlbF93b3JrX3RpbWVyKzB4MTAz
LzB4MWEwDQo+IFsgNjg1LjgwOTQxOF0gaXJkbWFfZGVzdHJveV9xcCsweGQ0LzB4MTgwIFtpcmRt
YV0NCj4gWyA2ODUuODEwNDM3XSBpYl9kZXN0cm95X3FwX3VzZXIrMHg5My8weDFhMCBbaWJfY29y
ZV0NCj4gWyA2ODUuODExNDc0XSBudm1ldF9yZG1hX2ZyZWVfcXVldWUrMHgzNS8weGMwIFtudm1l
dF9yZG1hXQ0KPiBbIDY4NS44MTI0MzddIG52bWV0X3JkbWFfcmVsZWFzZV9xdWV1ZV93b3JrKzB4
MWQvMHg1MCBbbnZtZXRfcmRtYV0NCj4gWyA2ODUuODEzMzg1XSBwcm9jZXNzX29uZV93b3JrKzB4
MTcwLzB4MzMwDQo+IFsgNjg1LjgxNDMwMF0gd29ya2VyX3RocmVhZCsweDI4MC8weDNkMA0KPiBb
IDY4NS44MTUyMDFdID8gX19wZnhfd29ya2VyX3RocmVhZCsweDEwLzB4MTANCj4gWyA2ODUuODE2
MDkwXSBrdGhyZWFkKzB4ZTgvMHgxMjANCj4gWyA2ODUuODE2OTU2XSA/IF9fcGZ4X2t0aHJlYWQr
MHgxMC8weDEwDQo+IFsgNjg1LjgxNzgwMV0gcmV0X2Zyb21fZm9yaysweDM0LzB4NTANCj4gWyA2
ODUuODE4NjMzXSA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8weDEwDQo+IFsgNjg1LjgxOTQzOV0gcmV0
X2Zyb21fZm9ya19hc20rMHgxYi8weDMwDQo+IFsgNjg1LjgyMDIzMl0gPC9UQVNLPg0KPiBbIDY4
NS44MjA5OTRdIEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBrZXJuZWw6IHBhbmljX29uX3dh
cm4gc2V0IC4uLg0KPiBbIDY4NS44MjE3NDldIENQVTogMTYgUElEOiAxODk3IENvbW06IGt3b3Jr
ZXIvMTY6MiBLZHVtcDogbG9hZGVkIFRhaW50ZWQ6IEcNCj4gUyA2LjguNC0zMDAucGF0Y2hlZC5m
YzQwLng4Nl82NCAjMQ0KPiBbIDY4NS44MjI1MTNdIEhhcmR3YXJlIG5hbWU6IFN1Z29uIEk2MjAt
RzEwL1g5RFIzLUYsIEJJT1MgMy4wYiAwNy8yMi8yMDE0DQo+IFsgNjg1LjgyMzI1OV0gV29ya3F1
ZXVlOiBudm1ldC13cSBudm1ldF9yZG1hX3JlbGVhc2VfcXVldWVfd29yaw0KPiBbbnZtZXRfcmRt
YV0NCj4gWyA2ODUuODI0MDAyXSBDYWxsIFRyYWNlOg0KPiBbIDY4NS44MjQ3MDZdIDxUQVNLPg0K
PiBbIDY4NS44MjUzODZdIGR1bXBfc3RhY2tfbHZsKzB4NGQvMHg3MA0KPiBbIDY4NS44MjYwNjBd
IHBhbmljKzB4MzNlLzB4MzcwDQo+IFsgNjg1LjgyNjcyNF0gPyBjaGVja19mbHVzaF9kZXBlbmRl
bmN5KzB4MTFmLzB4MTQwDQo+IFsgNjg1LjgyNzM4M10gY2hlY2tfcGFuaWNfb25fd2FybisweDQ0
LzB4NjANCj4gWyA2ODUuODI4MDIxXSBfX3dhcm4rMHg4ZC8weDEzMA0KPiBbIDY4NS44Mjg2Mjld
ID8gY2hlY2tfZmx1c2hfZGVwZW5kZW5jeSsweDExZi8weDE0MA0KPiBbIDY4NS44MjkyMjldIHJl
cG9ydF9idWcrMHgxNmYvMHgxYTANCj4gWyA2ODUuODI5ODE5XSBoYW5kbGVfYnVnKzB4M2MvMHg4
MA0KPiBbIDY4NS44MzAzOTZdIGV4Y19pbnZhbGlkX29wKzB4MTcvMHg3MA0KPiBbIDY4NS44MzA5
NzJdIGFzbV9leGNfaW52YWxpZF9vcCsweDFhLzB4MjANCj4gWyA2ODUuODMxNTQ4XSBSSVA6IDAw
MTA6Y2hlY2tfZmx1c2hfZGVwZW5kZW5jeSsweDExZi8weDE0MA0KPiBbIDY4NS44MzIxMjldIENv
ZGU6IDhiIDQ1IDE4IDQ4IDhkIGIyIGIwIDAwIDAwIDAwIDQ5IDg5IGU4IDQ4IDhkIDhiIGIwIDAw
DQo+IDAwIDAwIDQ4IGM3IGM3IDI4IGZlIGIxIGIyIGM2IDA1IDRmIDk3IDU5IDAyIDAxIDQ4IDg5
IGMyIGU4IGExIDkxIGZkIGZmDQo+IDwwZj4gMGIgZTkgZmMgZmUgZmYgZmYgODAgM2QgM2EgOTcg
NTkgMDIgMDAgNzUgOTMgZTkgMmEgZmYgZmYgZmYgNjYNCj4gWyA2ODUuODMzMzQxXSBSU1A6IDAw
MTg6ZmZmZmIzMTM0ODc5M2NjOCBFRkxBR1M6IDAwMDEwMDgyDQo+IFsgNjg1LjgzMzk1NF0gUkFY
OiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogZmZmZjk2YzcwNTc1NDgwMCBSQ1g6DQo+IDAwMDAwMDAw
MDAwMDAwMjcNCj4gWyA2ODUuODM0NTY5XSBSRFg6IGZmZmY5NmNlNWZjYTE4YzggUlNJOiAwMDAw
MDAwMDAwMDAwMDAxIFJESToNCj4gZmZmZjk2Y2U1ZmNhMThjMA0KPiBbIDY4NS44MzUxOTZdIFJC
UDogZmZmZmZmZmZjMGQyMTdmMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5Og0KPiBmZmZmYjMx
MzQ4NzkzYjM4DQo+IFsgNjg1LjgzNTgyM10gUjEwOiBmZmZmZmZmZmIzNTE2ODA4IFIxMTogMDAw
MDAwMDAwMDAwMDAwMyBSMTI6DQo+IGZmZmY5NmM3MGQyYWE4YzANCj4gWyA2ODUuODM2NDUwXSBS
MTM6IGZmZmY5NmM3MDQzYzZhODAgUjE0OiAwMDAwMDAwMDAwMDAwMDAxIFIxNToNCj4gZmZmZjk2
YzcwNDE0NzQwMA0KPiBbIDY4NS44MzcwNzldID8gX19wZnhfaXJkbWFfZmx1c2hfd29ya2VyKzB4
MTAvMHgxMCBbaXJkbWFdDQo+IFsgNjg1LjgzNzc1NV0gPyBjaGVja19mbHVzaF9kZXBlbmRlbmN5
KzB4MTFmLzB4MTQwDQo+IFsgNjg1LjgzODM5NF0gX19mbHVzaF93b3JrLmlzcmEuMCsweDEwZC8w
eDI5MA0KPiBbIDY4NS44MzkwMzddIF9fY2FuY2VsX3dvcmtfdGltZXIrMHgxMDMvMHgxYTANCj4g
WyA2ODUuODM5Njc5XSBpcmRtYV9kZXN0cm95X3FwKzB4ZDQvMHgxODAgW2lyZG1hXQ0KPiBbIDY4
NS44NDAzNTRdIGliX2Rlc3Ryb3lfcXBfdXNlcisweDkzLzB4MWEwIFtpYl9jb3JlXQ0KPiBbIDY4
NS44NDEwNDldIG52bWV0X3JkbWFfZnJlZV9xdWV1ZSsweDM1LzB4YzAgW252bWV0X3JkbWFdDQo+
IFsgNjg1Ljg0MTcwN10gbnZtZXRfcmRtYV9yZWxlYXNlX3F1ZXVlX3dvcmsrMHgxZC8weDUwIFtu
dm1ldF9yZG1hXQ0KPiBbIDY4NS44NDIzNjddIHByb2Nlc3Nfb25lX3dvcmsrMHgxNzAvMHgzMzAN
Cj4gWyA2ODUuODQzMDIwXSB3b3JrZXJfdGhyZWFkKzB4MjgwLzB4M2QwDQo+IFsgNjg1Ljg0MzY3
MF0gPyBfX3BmeF93b3JrZXJfdGhyZWFkKzB4MTAvMHgxMA0KPiBbIDY4NS44NDQzMTZdIGt0aHJl
YWQrMHhlOC8weDEyMA0KPiBbIDY4NS44NDQ5NTVdID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTAN
Cj4gWyA2ODUuODQ1NTkwXSByZXRfZnJvbV9mb3JrKzB4MzQvMHg1MA0KPiBbIDY4NS44NDYyMjNd
ID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTANCj4gWyA2ODUuODQ2ODUzXSByZXRfZnJvbV9mb3Jr
X2FzbSsweDFiLzB4MzANCj4gWyA2ODUuODQ3NDg1XSA8L1RBU0s+DQo+IA0KDQo=

