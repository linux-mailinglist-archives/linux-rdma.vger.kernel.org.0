Return-Path: <linux-rdma+bounces-4102-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC49941569
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 17:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6033F1F24728
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 15:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301CC1A2C33;
	Tue, 30 Jul 2024 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ztn8bplt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2091.outbound.protection.outlook.com [40.107.21.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F46229A2
	for <linux-rdma@vger.kernel.org>; Tue, 30 Jul 2024 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722353187; cv=fail; b=fG2r55DFgkDu0C7ENMLEFpb/YrhesytipIo2GJDZ8cOl5/3xWKMb9AVSYEWpcQ3wT0nlqmT/c54YyfIZBtQxx8knG7OQ+DLMqpcSva8xjG882xdIeSSQ2sENuPK8e1Z02jDJOChhHNGdsqQucsgnxIE/iWavgWBteyg8L0Icwx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722353187; c=relaxed/simple;
	bh=DIr9F/X4RP4KmGNO0sHQV5/Gs2V2UNrnctf7h/wuRuk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dmbi8zx7TV6jbzvNSS/x2H0p+u4GQGc9fXsuw7hq1D6SCFDqQekAvYRXXP4rVCl96P05WbtAUoLKiPmPvRhJE79NXy4ppW7zhyFXE9F2Q5/K4DSINZ79VEy2rN+ZsvpjLq0+3xnSaoXYqDvMfXwD9S4gX0Rz5yfLKYnog7SteN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Ztn8bplt; arc=fail smtp.client-ip=40.107.21.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4PwXvyxSIp/u7BRDrvJ2Lyc1C7OfN+Qb5DMZlWf4hfxvNVLzShVKx6FSTlzOB71WYNVEtT7rZjKF6LrC6ZQ0K1RU56y+PNbOd7eNA8czwT5+PCeqK6s4ubPLRnI0OI0RTUUZh/02NlkHVZpoy9U9KLqu+Zy9Nr+4oIiiuPLY9dzSUwBdWquRr14oJglkbakqGg8lwY465RgM/FRs27C0jDqMHVJ555RgddEkQRX6Oq8cJiY6ZjPDGZutZBnPYi+L81KdWkh3QUdtP9X8qhjkZgOe5qlZle0F1liUTv+KM3ScvKN7rQDKyZL4iOM8q8GkkAVi//LTp88cn+8VbCxVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIr9F/X4RP4KmGNO0sHQV5/Gs2V2UNrnctf7h/wuRuk=;
 b=cs5kWqhpQxhyiOMKvYm9yZVAOmr35SdlbRHu45DzqU1wEMVs0XJeKqZYfby230owcFo+nsWR4kwam4AfmpetjDHvcovhmWFUrxAc3SefMRsztHucBD7fO+zH2kIb6KrX7evGPPK5xLBBwvhdUzR5EFVBL4ndWvrleOmHNZDV79oe6ejsuLUykOOtOS7c0a1SZJTtvhQqU0tkFQOLGhD5fA+jRII8CML3L6Ab47nFCM4By9bmHSs0PL5alqi8Ae687+xnCmjVOv7cFJoPrETj8owc9IfzQBWKkSBjcfTaz8c4epK5FQb9ud5sAkPKjEeMxF7xx6XZoIfJSQO247iSTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIr9F/X4RP4KmGNO0sHQV5/Gs2V2UNrnctf7h/wuRuk=;
 b=Ztn8bpltEfLzjlXLlJkzZEWsF4QXuu/uLZXnqOnqAiW8ubwA3Sqct2UmJPO++qltYSAab4DKnlAx40gqknZjhC0VKrE1H2IUcuZaLELB1s75qOeZbcaDyQedECZr62ZNsI0GJ6+/6aCOduvY18OuffpmOYeWuJZrh8dPHFnVeCE=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by GVXPR83MB0584.EURPRD83.prod.outlook.com (2603:10a6:150:154::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.6; Tue, 30 Jul
 2024 15:26:20 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1%4]) with mapi id 15.20.7807.003; Tue, 30 Jul 2024
 15:26:20 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Andrew Sheinberg <as1669@princeton.edu>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: Re: Seeking Guidance: Creating an IBV Multicast Group?
Thread-Topic: Seeking Guidance: Creating an IBV Multicast Group?
Thread-Index: AQHa4pTTFJ4Kj65hDUGgpTdA47elew==
Date: Tue, 30 Jul 2024 15:26:19 +0000
Message-ID:
 <PAXPR83MB055925286F0F0A12B21E2C18B4B02@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <1FF42574-65B2-493A-A779-D27F853063A7@princeton.edu>
In-Reply-To: <1FF42574-65B2-493A-A779-D27F853063A7@princeton.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8b7528ca-d2e9-47fb-be81-61bbe010ca5b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-30T15:19:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|GVXPR83MB0584:EE_
x-ms-office365-filtering-correlation-id: 1efc496c-2e1b-4d93-c583-08dcb0abf675
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QklKVHdIbHpIZC9oY2JSbUZCS2FBRVhhVTBlSHB4clF4b0dQQllaNE1ObVZN?=
 =?utf-8?B?S0htZWk4VjRrejFtamNsbnRra215QlFxQTZXZFpRZ2VZaFlQYklSRWNFUlRO?=
 =?utf-8?B?dHZ3RGh0NUZKbGsyL1l3NHYyazNNSlBLcllYdERPZ0dMNUVTdkltYVVzN1hD?=
 =?utf-8?B?cTlqRlIzWjNqMTUvZ3U2KytNVktLQnAyQUphcXdveVNRQ1Bndkxib0R2S0R2?=
 =?utf-8?B?clRhLzRRY2tOV1ExR0lTMjBIckVxSXh3enNidTI1NExra1pxVDR3dXhwMkZ3?=
 =?utf-8?B?LzdFUjVwdjNVd0t5UW1VUVd0bUxtVlRYTHZMYlVwR3VQSjMwRU9OQjdTa0VG?=
 =?utf-8?B?MzZJSmpDR0d4WFBiWWk4clUwNG43S3N6MjY5Ym9hazl5b1VSOGUycW1ya2NF?=
 =?utf-8?B?Sm90R1g5a2l2aUlObStpOW1RY2xUVGlleVZIeGFVV20rVnB2NGJNSU1RazNF?=
 =?utf-8?B?c3VTSUNrWVJYNTNKY1F1VjhlUEF5TllUVVNRR0t6N3BHRFhCK0Q4UGZvWThs?=
 =?utf-8?B?TnU4NlJ3MGNydlpGTHUxem5XMDJwdVFlSU0rakVldVRlaTlwMWpnc3FvYUpE?=
 =?utf-8?B?bzUzZ3FjbGhFNFZBU2sxK0cwS0Mwbk9QaE5PTE5TNXp4N1RsSGNIcVdCcG94?=
 =?utf-8?B?Q253Y2RkV2JYZ2tDRDQxcDNhbXV3QlliN1dqeWk4Nitha0JSNlFNaTd6K2tL?=
 =?utf-8?B?eVFvWlRFbGlDTVFuQVZtczgrR21zQ2RRSmRLdm8rVUdlcGVlVFBBQ3VYNFZX?=
 =?utf-8?B?MVNKZW5KZG10S2lVbEVCd1JWRjFUdE54YkNIV2pUa283Y25FRkpzOThpMllu?=
 =?utf-8?B?dE9OMUFhVkpCcG9kK2x0SkpHcDRjSEVEYlR1c2pDY1dFWWMrcGpUdzMzVHhr?=
 =?utf-8?B?N0Jab0JIOGl0K01veldSYjZhTHNBL0kyaUdxWjdDams3US9TMFJjdkNhVjhO?=
 =?utf-8?B?TkZ3SXEvYTNMMHpDeUxXWlkxcGRNSXpyNzZXdjNvaC8vZWZvU0xNV0Z5QVgz?=
 =?utf-8?B?NWdiVTRpSjVrQ1cwQ3lxaEtSNkVFVDArajM0QUZWS0tMZDNMWW9ZVVRYR251?=
 =?utf-8?B?bTNPczlOaWxGSUZhY0JoamtGL3FYdk1pMTVhNzhSSjN5YnBucEdiQmUvVjVx?=
 =?utf-8?B?cEtkZzhPVWFqK2RCWlZpcy9NOFF3ZXp4TDJCL3kxTkYzandsMjRTZmFwUHJh?=
 =?utf-8?B?b2FhdjQ4UHR2T2hVc0VLenphWHlJTXQzZU04czhQYjZCdGZPdnozY21HelR5?=
 =?utf-8?B?aCtnVUJ3NjlnYis4OTg2SUFWQmpMcjhzN1J1Ym45WDB3a1V1cXIwN1RzUXhV?=
 =?utf-8?B?NUFJNDJiVU9sRXpHTllnYk13b09wSnQzUUJQSXBDVk9maWJnVmthcDZzVlY0?=
 =?utf-8?B?ZVQya1NkZkhGeTZZNmZjWm52Y1lkaWRidnVwdS9ocU9OQlo0NXZKYzFKWW1Y?=
 =?utf-8?B?cE5USmlRdjF0cTd6RDVSdGZLNjRaejMyUVAzZnhwam9ZcVRBYnM3b1d6L05T?=
 =?utf-8?B?S05XQ3VwRlV6dlhEOU45Q1p4dS80cDUxdElCQ0oxcVd1eGJJakJHa0NDaklW?=
 =?utf-8?B?M2hiLytrb2ZOdEVUdkhRMkZmSWhCYTcrYUowNVY5Y2xDVFpkc1ZmSkIyclY0?=
 =?utf-8?B?bFVRWkxMQXVuZ1pxTDdjWURGUzF2SHJ0aGkvV0hTVnM1WmpweHpsOFVDNHpX?=
 =?utf-8?B?cjB2RVloeldseGt4NmlBZ3FQaXBiMDViN3J3bTRtUldVVW1CR0xXM25JUWto?=
 =?utf-8?B?bVYxeWpTOGplYUpCTUEvaDJhbS83NDF5YnFwZGNHVlgxdW5XTVZrVnd5U0Ir?=
 =?utf-8?B?WWNTQklTYjBoS3FMWFM4cHZIdWY2aTdIREk3RXFnTVlIWlkyNXZ3ZGpSZGsz?=
 =?utf-8?B?OENHWEQ2MEYvUlZENkJ1VmFSQnZVRlJub05aUFZqT3lhN2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEdNV0VCTlJ4YkJlQU1WWXNzZGExamNSWFh4aHpLZXRKcHhIdE9MODhFeVoz?=
 =?utf-8?B?K0prSmgwcXIrbnYvbkRYbWc2OFVkS2l1MitRYkhKT3hIMC9LU25yQWs1aUhl?=
 =?utf-8?B?em5KaC9iWExmMUdhV3lPWVMveE8ySUNxNEE2cWx3MjE0YVJNTEp4anJxOG1V?=
 =?utf-8?B?NnBEMC9pZGo5a0lkVjZ5djVieGVhN0IyWE1vTGtnU1JuU1NOOWRkb3VyNmIw?=
 =?utf-8?B?aFhzaHh6SFE5MExrQW9ZREVWVEtKZ0pOT3NjR2dZT3g2WERYdld3Z1BtTFRL?=
 =?utf-8?B?RlRDdTRpODk1emJ6RDVETWNTS09FcmlDWmZYWm0yOUJ1a1Zud2tFSTlXcVBj?=
 =?utf-8?B?NU5ab1IyRWdGVGxJdXNCNDFvaWJESXR3aVJzVFB0T2pLUDlYdGNKRWdnUXF2?=
 =?utf-8?B?dHBYeExvRVBpajAwd3JYdTRKdjNJQ3VFT1IzaUZ1ZkFuY3Bid2ZqWTFLV2Zw?=
 =?utf-8?B?V0FFMnZvcWNBQU5adlBNSUd5WExSNmJWVFJoQVVLOTdQZGZtRVdjS01WSzlP?=
 =?utf-8?B?YW1qN0dINjNuUFNIWEFjMGxoS2ovNTdiMlZ6QXNtaGswUHJTMU03S3NuZDZT?=
 =?utf-8?B?NkxXTWxMSmV1TDhyS1pjd2l1MGpaT08wNFhPeVhpYlNTMHl4Wk9tSFBTRVZD?=
 =?utf-8?B?UG9HRTVmOS9yZHdjcVBKZUVFcEpZYVdXYlM4Z05GaVkxeFMrUXgvVjhLZVFH?=
 =?utf-8?B?dmV4U1RCSWUwZGc1L0dMbFJBdVFic0xjdVVRb3k0cktPaCtEK2lqajdzMnNH?=
 =?utf-8?B?Snc4WldUdWlBNHB4RTVCNThPd2VyWHRrL1V5SWFWVnJHYTVKcGkxNDMrSkF4?=
 =?utf-8?B?blhEaVVxckNMbEdIS0FFQ3RWZGhleTNUZnNEK01aNGU3b1hGSS8ySjVyckJQ?=
 =?utf-8?B?WjJpRmQxTjF3WmdJcVRuVmVDaThoMXBRaW9DUkVyT3Fna2tkbkVITk1vQUF6?=
 =?utf-8?B?UHU5aWVXaWJsNWFXSUdJaHRWZ2w3OG1mM0VYS1ptQnRQV013TnppRTJOWlJx?=
 =?utf-8?B?VkNreU1sTDhPM1FHOFlpVnpaRFJLQmlZdjJabkpzU0ZSUVF4ZUFQdG1xbEVM?=
 =?utf-8?B?c2xiSG5SQ0JwK1htV1RNeEN1cjBaemVUVjBWM2oreXhNcEQ4akFyRDhkdWJN?=
 =?utf-8?B?T1gybGN4Z1BoUjE3RWlUNkpNVmJXWDBSckNEd2MwR1EvaEZ3SGRmRFRiaEE1?=
 =?utf-8?B?Znpsak0yeTRxMFVRVTdKR01qR3AwUGQ3NE16bUsycjVscTJ3OUVqdzlQamhS?=
 =?utf-8?B?NlpsU2xPd0ppSmJhN2RmYXdqNzNOL3dUY21tNDRtZ29VMUdBRFZqNnh4WEZ1?=
 =?utf-8?B?VjVibGJWcjJKVCtOaFAvNE8zSm5UY2xpb1k5bHRuSHdBMVZYeSswOHNPRkdG?=
 =?utf-8?B?ekF2T08yMHZKSTdhRUx3MTh6Q09yQVhKSkJYYy9CRUNXRFlSNXF4bHlVNkF3?=
 =?utf-8?B?TkFNU3Raa0tzYnFaSGN2Ny9PNHhrUGR5c2ZoWHFoczkzaEk2WEJCZjhVT1Q5?=
 =?utf-8?B?TzI3anB5QmV1WXdKdkhZTEtXalNON0JVTklobzdDMlBZazR4Q1dkckhYcHUv?=
 =?utf-8?B?cjlCOHVab2k4c2FFQ0M1UzhPMDRITnZ1U3RQMm9RMitpeWwrdDZOZURNSlJW?=
 =?utf-8?B?WHo0eVczdnp3K1VrSk1JdVluaC9QWEZYd05PaUNnY2FHdnhPamowemJucGdn?=
 =?utf-8?B?T2JmZnhTMmlKQ0hKd1ErWmhZQVdrbHpEMnVxcTFyU1kyT2hRclo4eXRMcHcr?=
 =?utf-8?B?U3Zrd2ZGVVNkNEtVY0lLbERDbHF4WExyandBMmNoNHFaYjM5YTVHSHErL1RY?=
 =?utf-8?B?R1g4MmN4ckZKR3R4NU1aR3ZVY0pSUWVjQitzSm05d3M2VjMvNFZubGFPbW5o?=
 =?utf-8?B?WjZJNFRzeGRFYzEzelgvSGdTRC9jUERxRUpPamhHZFVYVGlac3BGWGRLQzhh?=
 =?utf-8?B?dGlFekphVmdjNWlBTUh0Z2xSSndycStpWGVmdnBtZWNKd3pBekNlTE5kQzhi?=
 =?utf-8?B?Q3FYSjEvTTZSaTQrbDNoZWlCVy9NenJUaXNJaFZvNmZJZFFCeEplUWxQVkly?=
 =?utf-8?Q?TTlOGQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efc496c-2e1b-4d93-c583-08dcb0abf675
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 15:26:20.0384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iNQx7T4R+LeJ1EzOhsCqKeK7/+akZsZKE680qaUlkOiVGIesvbM+VTemBxKzoMoGlRItiKOTnWbGDpxd6+vL9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR83MB0584

PiBJIGhhdmUgYSBzeXN0ZW0gd2l0aCBtYW55IGluaXRpYWxpemVkIFVEIHF1ZXVlIHBhaXJzIChp
bmZvIGZvciBhZGRyZXNzIGhhbmRsZQ0KPiBjcmVhdGlvbnMgYW5kIHFwIG51bWJlcnMgZXhjaGFu
Z2VkIG91dC1vZi1iYW5kKS4gSSBhbSBvbmx5IHVzaW5nIGxpYmlidmVyYnMNCj4gZm9yIGVzdGFi
bGlzaG1lbnQgKHB1cnBvc2VmdWxseSBub3QgdXNpbmcgbGlicmRtYWNtLCB0byBhbGxvdyBmb3Ig
bW9yZSBmbGV4aWJsZQ0KPiBlbnZpcm9ubWVudCBjb25maWd1cmF0aW9uKSDigJQgZXZlcnl0aGlu
ZyBpcyB3b3JraW5nIHNtb290aGx5IGZvciB1bmljYXN0LiAgTm93DQo+IEkgd291bGQgbGlrZSB0
byBjcmVhdGUgYSBtdWx0aWNhc3QgZ3JvdXAgYW5kIGF0dGFjaCBzb21lIG9mIHRoZXNlIHF1ZXVl
IHBhaXJzDQo+IChpYnZfbWNhc3RfYXR0YWNoKTsgaG93ZXZlciBJIGFtIHN0cnVnZ2xpbmcgdG8g
ZmluZCBhbnkgZGV0YWlscyBvbiBob3cgdG8gY3JlYXRlDQo+IHN1Y2ggYSBncm91cCAoYW5kIG9i
dGFpbiBhIHByb3BlciBNR0lEIGFuZCBNTElEKS4NCj4gDQoNCkhleSwNCg0KSSBvbmx5IHdvcmtl
ZCB3aXRoIG11bHRpY2FzdCBvbiBJbmZpbmliYW5kLCBhbmQgZm9yIHRoYXQgSSB1c2VkIGBzYXF1
ZXJ5IC1nYCB0byBnZXQNCmF2YWlsYWJsZSBjb25maWd1cmVkIG11bHRpY2FzdCBsaWRzIGFuZCBn
aWRzLiBJIGd1ZXNzIHRoZXkgd2VyZSBwcmVjb25maWd1cmVkIGluIHRoZSBTTQ0KaW4gdGhlIHJh
Y2sgSSB1c2VkLg0KDQo+IDEuIFdoYXQgaXMgdGhlIHJvbGUgb2YgdGhlIE9wZW5TTSDigJQgaXMg
dGhlcmUgYSBDIEFQST8NCj4gICAgICAgICAtIEFyZSB0aGVyZSBhbnkgZXhhbXBsZXMgdXNpbmcg
b3BlbnNtIHByb2dyYW1tYXRpY2FsbHkgYW5kIG5vdCB3aXRoIENMST8NCj4gICAgICAgICAtIERv
ZXMgdGhlIEFQSSBkaWZmZXIgb24gSW5maW5pQmFuZCB2cy4gUm9DRXYyIGZhYnJpYz8NCj4gDQoN
ClRoZXJlIGlzIG5vIFNNIGZvciBSb0NFdjIuIFlvdSBuZWVkIGEgU00gaW4gSUIgdG8gZ2V0IGxp
ZHMgb2YgeW91ciBhZGFwdGVycyBhbmQgY29uZmlndXJlIHBrZXlzIGFuZCBldGMuDQpJIGFtIG5v
dCBhbiBleHBlcnQgaW4gU00gYnV0IHRoZXJlIGFyZSBwYWdlcyBleHBsYWluaW5nIGhvdyB0byBj
b25maWd1cmUgaXQgY29ycmVjdGx5Lg0KVHlwaWNhbGx5LCB5b3UgaGF2ZSBvbmUgbm9kZSBydW5u
aW5nIFNNIHNlcnZlciBvciBTTSBpcyBpbiBhbiBJQiBzd2l0Y2guDQoNCi0gS29uc3RhbnRpbg0K
DQo=

