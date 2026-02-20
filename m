Return-Path: <linux-rdma+bounces-17037-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKg/EyuhmGkPKQMAu9opvQ
	(envelope-from <linux-rdma+bounces-17037-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 19:00:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D671169EE7
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 19:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 161F5304C058
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 18:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5069A36654C;
	Fri, 20 Feb 2026 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fA/bZggN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18368366544;
	Fri, 20 Feb 2026 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771610405; cv=fail; b=pUsMhhW5f0gj9kgxO3kHW8eQSU7QxFbzpaqAPdC0Ya/Fkf3h+vGCkn2d/dJbGfeNIdpKKK+nF/RGSx+ks2j0IgnA/T7Lpxh4gk2TP1yOBQLR1wXLh5ZOk6ULtWNw8GUnRVGjwYHPmKAWZHk4gSk3dt4FG8fbkH0bvDOAGKnG5CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771610405; c=relaxed/simple;
	bh=AvRrvJN/NPE5C8WVadt/2Fl0RjMDdeRrvwfeR4L/aTY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=F/4NCOvGU1zDQom5FtQE2D4GVUNMvOk/SVmilcZWOCSuJ/nHEDiVmqhOOpbW0tOXffyMyO9C/51uIMgND5LaYjIJV9zDJPt5OcmtdCGPG+KtMVEKeSpAUSSzxHv67tMswQFHaa2rnr5Szo2Q97eaM1Y2V0i1XGSNAZnPZimhjjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fA/bZggN; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KEXUFG1812611;
	Fri, 20 Feb 2026 10:00:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2025-q2; bh=AvRrvJN/NPE5C8WVadt/2Fl0RjMDdeRrvwfeR4L/aTY=; b=
	fA/bZggNmv1Qe6XrnKFlW3mb4afx5jeCNb+J4C5N7ggELo5P9x8WjLMZH67J2Pl/
	R2p0rn0hIW8tfy+8mwy+eF7hpCrrlqSLLomGCkvztYOM65aibi4UzjlwwA0hvu1w
	HTNmVhKPVJ0psbGG1nKvjRNbR0nkq6egwYtD1y1bZrTsR8Ba8I14ruHVts1Aq7Lf
	XO6mpIDFPgLg1EdRjIxWpajMyM56B9zBLvyqihOHqmkUfRKO+kTsS3ujbd4OUBob
	ce/tFyYDjOnrZPFUotufp0ZkLZMZAW0YioiN+9TSGVirAJBBZvhB/vzJKAP+SwXa
	qnzu39fBxzNhK20MDyWO0A==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cesfsssne-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 10:00:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seZs1h0/7QoWdtym7S6jMGnhTnYKcdXQer7D2no4xhxBr4RVNf5vrgrMGXzap0sT2bEueYYvp1hCMDqrlCE5gsjhZQlVmdeaYd1Bzq+2osT5W7d0/I3fGOxW8F0FLVTWWxJJkNRN6CSceLeuSdBKuPUHQ0Ix6JJCOrjoOjpTOl7anKWAP5edfrmPKI6o19TSV+/rE4RqStrF2bqMZCUvJEFLa16YHDp9+K7NX7Zs+RgxmMv2p0UpwUC/WGoGBpHb/PKI3ET0bLgdgq7REaD6PJOKrh9Rmr05mHYpUF0qeX70uADb910W5yCQupfNtrIBHMR3Sq7OheIbP7ZBe+w8Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hh/Z5NNYNfpN3AYv1idVpGHId5uRC1Ub0TyFTFAlBLY=;
 b=gjp5CrdeR3VQNKYy7B8cKIVjsa6GRIYdNGyCMjUEXvFRzin4sq/oRfweQJq0qboG0x0wmgOCQPHzei3DhT6/npEDUAG6fnI01PQoRrRsWZQzJffnhy6ZQc5YXFzAIWYQuZlWhiX9bKmXsJWFZL5xtJAHhqK8cwqydIcpIGvlnidLaTB7cD3VsBmeWw8T15jevtwQ5R11O0TOnJgZ9OVKxhBhwfQM644hGm8L4Ii79dTdmYrMJAfbq4RiIzxFV77NJ36Lig5N4VSedtmKrGR975OkkJNWlHRlE9y4BEPUKqBMCKTqDWmAqpQQMvqgGMfEi8HTU3+r0XbGM+/sIGvodg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB7075.namprd15.prod.outlook.com (2603:10b6:510:3ac::20)
 by SA1PR15MB4642.namprd15.prod.outlook.com (2603:10b6:806:19d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Fri, 20 Feb
 2026 17:59:58 +0000
Received: from PH0PR15MB7075.namprd15.prod.outlook.com
 ([fe80::6fdc:a09b:a94f:e773]) by PH0PR15MB7075.namprd15.prod.outlook.com
 ([fe80::6fdc:a09b:a94f:e773%4]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 17:59:57 +0000
From: Evan Green <evgreen@meta.com>
To: yanjun.zhu <yanjun.zhu@linux.dev>, Zhu Yanjun <zyjzyj2000@gmail.com>
CC: Wei Lin Guay <wguay@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon
 Romanovsky <leon@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/rxe: Generate async error for r_key violations
Thread-Topic: [PATCH] RDMA/rxe: Generate async error for r_key violations
Thread-Index: AQHcnD7ZNNi3428KQEyeD2HGkc4cbrV/eHIAgAvuZoA=
Date: Fri, 20 Feb 2026 17:59:57 +0000
Message-ID: <B810FD4C-0D5B-4FAB-A6C1-6201CF44E829@meta.com>
References: <20260212164355.3585961-1-evgreen@meta.com>
 <9264c8bf-e3cd-46db-b1a9-63a556ecb1d4@linux.dev>
In-Reply-To: <9264c8bf-e3cd-46db-b1a9-63a556ecb1d4@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB7075:EE_|SA1PR15MB4642:EE_
x-ms-office365-filtering-correlation-id: 3b0af601-a100-4418-1717-08de70a9dc2e
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Qm05MEJOTHRnZHhJclBtS2lJS0lMaTh2aFFNaHRSS2tRNVNFd1FzQi9yTzRL?=
 =?utf-8?B?MkZNTnpLdHRhOWxHTm83bFRRRkVEcXZxUGRvZmN5ZHBVQVVaTTNCVnlualBZ?=
 =?utf-8?B?NW5wbThNSXZqR0R5NXB3V3o5T09XL25vRW11Z3FGTGU1d1ZadXpMR1FhQ041?=
 =?utf-8?B?T1pRdUpwb1pZNFA1aWw1N05HQ29wY0R2aVN6WTk5emZKNU9hTHJkQ2tsTFoz?=
 =?utf-8?B?MzkyTUVpcDdvOENnZEl1SVBqQjROSy9XUnlEMC8zWUx4QWRnbDJIa3RGeG1G?=
 =?utf-8?B?MEcxdHBSbEkyTWpIRWRvbm1PeU5OLzRQdktlcisrRnFLOUh2NkVObWdFN0hh?=
 =?utf-8?B?VUhtQU5VbmxXOGZxOHQ3eC9FMTBJaHh2bzlSNDQzcWl6V0FmRlQ5Q2d4WXFZ?=
 =?utf-8?B?eGZVNGQ5ZEk5QU9pZHdTT2MxSnJHVVQrSk1LZ3ZXTTBkMUhBWTh0TklGbllh?=
 =?utf-8?B?OUhsU1Z0L0hsdEVWcFpkZG9tcVFyQ3B2SWM4R2RsYUV1R2JiVWhhdlVkeTNv?=
 =?utf-8?B?RGR1TEpBYUtUb3licjhYUlp6TWJPVlJ5dXVpWVNXd2IrZjkrUUU5aVNxcUt0?=
 =?utf-8?B?MjFMOUVMUWNwZDdIK0h4enJnZFFVQ0s0aDJDVkFVb2FZaDVnaS9pcngrZVVT?=
 =?utf-8?B?SWdvOUZDSUpsckpTNUlIaVZJcnFhdFpveUlqSUZLam1nTnZFbGxzb2JaaHhK?=
 =?utf-8?B?TURYempRUkNERXJ3NlVGWFJzSDFXdFhFZ2N5bUFxNzZpckpWVmdsbHUvZjVq?=
 =?utf-8?B?QlFFaGw2L2kvc09HVFVrTmdTUzRiMHkvMzJ0MFQ0WS9KYk1OdHE2TXNXdVZ4?=
 =?utf-8?B?bGtvRDlYQXJPai91eW1hZFZZUFNFazBpM0pMRTZGQVVNUDlINmtuM2VGOU9W?=
 =?utf-8?B?RVVyZXRBakFTNy9aSHM1UUxIeFRBMzdqSWpydGVnY0F1cDUwWklYVC9QbUZL?=
 =?utf-8?B?VkpaVjUzZlhlUTNsWWZGN2pTWTVxbWsrRkU2MjlHQ2R1ZERsZVp1WWpaM2Ez?=
 =?utf-8?B?Vlh5aTdGM2hvNW9CdzNPZ3loQzVXM0twdml4NU90czVqYTRBcVV0aDFvMS90?=
 =?utf-8?B?dm9vREQwQ0NFZkpDRGJVYUFhS1dWZlZHaTZwVmxSM3lVOEdueWtEM1dpMU45?=
 =?utf-8?B?SFRsWlhsNWxHTnpyU2RqVnkxUzBwREw5ZG5lVk9qN1hKb255U3FiTE9MYVpm?=
 =?utf-8?B?Q1ZjOFNxTi9wM0EvSlV5cFRSWDVPWXMxTUkyTjZjY2NDZEVLRHo5amNOeDA1?=
 =?utf-8?B?VVk5akg5NnkzbHg1ZGpHVEFiRTBGNEJhbWtYWlRpQkxSSmRVZGJZSzN5UC96?=
 =?utf-8?B?THI1VWdpelRrRW94WHJjaWlZb2NBMGFSZmVCUEFrYmtMaVByQ1VIQUx5ZG5J?=
 =?utf-8?B?eW5KaDZKbi91czZxSVRnTXZ5R3JwN0FlenBDdnVqYTRoc3dURUt3Y1dkS28x?=
 =?utf-8?B?N2xta0RtNjF4Nk5FekU1SUNpQXhBd24vc2tLT1hEUUxWOHR1dVB5bjJGTUh0?=
 =?utf-8?B?UXdoYjZFeTNDUmxtMy92ay91YzNrYkxIY1U1OFQzOE44QUo1cXhCOTZQMTZO?=
 =?utf-8?B?cjBWNFIxcGpDT3VlcmxrUXExQzdTbmRMTEFWMDNiSFRuS1dwRndYLzhTS3g1?=
 =?utf-8?B?OEFCcEVrOFR6WTUrSklEK1ZHc3hiVzZYL3B3RE9ZV21KYUduVnRYemprV1JC?=
 =?utf-8?B?T3RpejIyUi9LcGgwdFRDOG1PK0tZYlZKVThWazV1M3JHeVVmWXFRNURLQm1K?=
 =?utf-8?B?dHYvRjdUNTdRTlp6ZFB0L2xiNkRDaXh4SFZ3bU5jYlZsL09sNTFEUi9Kb0FG?=
 =?utf-8?B?K3NsNTR3d1RaSGhSVlhENlhXVGY5N0VmQTJKbGhkM21XYWlBYzRXOE5DM0JM?=
 =?utf-8?B?MjkrZTZmK3M5MmdIa0J3M2dwbVg0SGFpNy9VbURJL0VwYThnelVWR2tMaVlm?=
 =?utf-8?B?K2YvNEdrV2krUnBmckRJVlg2eWg4VUdQWUVvQWdFUDVtNmhWRTFSR3dzQU92?=
 =?utf-8?B?MkNJM0p4STBzOFFDOUJ2dzdkSnhpaWZpaG1zaTRyZVVmQjhmRVhlY2xMTGxX?=
 =?utf-8?B?c1NrV1dFZGxnNWNEaGN6djRkRFY5RTNNMWNjNkhQQTFwdXJxaElsWFFjMmRD?=
 =?utf-8?B?a1NVR29WbUxoVXh3d2lYVldEclBtejA4ZEljd0F5TVVXSTlqd2g0VndrNW5M?=
 =?utf-8?Q?sjrpiJ4zjqp3S8NfYA30lu4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB7075.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ty8ycHlGeHhnRWJEUERPcXBtVDhMTUZOaG1qOFRrSExiM0lqdnRZdmJKVHBD?=
 =?utf-8?B?Tyt2NVBMUjQ4bitYMk93ZC9Xb0txUDRVSDNJUTVRL0xFWkorSnIrNUEyby8x?=
 =?utf-8?B?eUZCMEwwK2ZhZjRud0V5M3F2U0hHdEtMeVN0d0s4Rks3ci9paWFPSmNUOFgy?=
 =?utf-8?B?OFBORUpGK2JYTXJSUEpzZXpOWkF5ckRJSm5UUHNoMlhzM09NVDZuZDFkUGVT?=
 =?utf-8?B?TU9kZTAwMjI5QW1nOTB0cThueUJGWDF2d2NHa1RhTldqUDR2c2VxaUFScDNu?=
 =?utf-8?B?RnZiM2VnUEpISFZvdXVMaS85STE2c05SVnU2aDY4Mmc0S0pzYXhOVVZMZjZL?=
 =?utf-8?B?M09RNStZeG8rZDhhRVJ1ZjBZVHpYdCtqU1ZTLyttYk5pT2RGUDFUaHJCdHpV?=
 =?utf-8?B?UHZsdGxwVEpYK3dTeDB4SFpzV1FkY3FSNzRpZ25jeUNmRDNXOEVpUXRZSXhB?=
 =?utf-8?B?eVBQbkNTRFZVa3VNY0NWSXBKaHNGR3I2YWxVWTNrb0ZKSXJrdzZrRlBwZmpr?=
 =?utf-8?B?RjZVTm84aHV6SzRQZkd2OG9XTTBaYmNxV28vYVNVQXozZVVIM2tTdWp4U0hh?=
 =?utf-8?B?dGhwNFRIVmxrblRMMmlmUnV5SUFrTDZ3UVRiRldsUXBEcVBoTmFpS2pnRDVU?=
 =?utf-8?B?TmdtYUhEU1J5K0RSdFNqb0w5TEZDR0dhZFdqdU9ZYVlENGhFYkw2U3JDRUd5?=
 =?utf-8?B?ZXVwWkV6SHp3anBYUTJpcmRLSTA2WlprMkRRTDlSNlZETytiMWlqRHF2dS9o?=
 =?utf-8?B?dUUzdGdaQUxjZWFMWXVpeTVmdnN2cEVlaTZUKzNBKzUveHFwWUhwWXp2amRz?=
 =?utf-8?B?QTFHdEJFTmppeUtoQ3pqajhaYjE5M1NuNi9ZRGc1bzZLTjk3czJCZmdUY09V?=
 =?utf-8?B?L2NSYUtQRTJwWTc5bk9rTXhwMm04VTNUK2ltZ2NYSzcyK01ML0hMaU1FMVUz?=
 =?utf-8?B?eUI1RDBwTDhVY0tGMm9WRmt4VWxEYmVNOUV5VWFMTmFzMUI0eVphNHBqNm1B?=
 =?utf-8?B?ZmlFRC9EMlZjaUpVbmJNZW43SDVucWFHWStCb1g2TjZhTzNrbjJqL3QvMU9o?=
 =?utf-8?B?WHFhOW04MlQrc0FMS0lMRFdLZWFkK3AyL2RhcG5nd3pFdGhJSFBtMnZIbTlD?=
 =?utf-8?B?ZWdOcjZ3SE5UanVaWWlYN3JFajBFRjVGdjczTnNuUEVOUnk3Q1RhdGd5OHZk?=
 =?utf-8?B?QmY0amNNTXkyQnNOK2lUVkxrbTl1cTVnSFZhR1Faa0FPaWptNzJLZUZrd3U3?=
 =?utf-8?B?ZXkrcEQwbGJVTEszWTdVa2xINXBKM1VqU0JqTUlFcGhQNnc2SjM0cHBjbUdV?=
 =?utf-8?B?YlVHc3crWFpqTkZhM3FsV1h1QUFqMWgyV0lIbVE2cjZNaVRJN09rQnVNTFM2?=
 =?utf-8?B?VGsxOFF1WXYyQkFzMGN4QWFVZmNNZVA0QUo1VkIralRuWUkzb0J6bUlseFBK?=
 =?utf-8?B?UC9BU1g2TTlBblozOGdld0hqWmU5Mk1Wam4xWWJxM21WQlNiTG02UzdzQjRJ?=
 =?utf-8?B?eHd3OHRSeFkva1l5TWwyVU9tQVBlbHFWOGJYc1N0aUg2QTllV0cvelJKZWlN?=
 =?utf-8?B?VVZtMVdOdUdFQWRJejRxN3JQTDRiUlhFU2JPWHI4NDFHZVRMOUZIWmdQK3Bs?=
 =?utf-8?B?WmdtbjByaE9Td0xVTk9nL0dFNGRkdDk2MnJmdnJpcnRpZk5PMEdwMHVkcEtq?=
 =?utf-8?B?VGxNcW4vKzVZTnpMSkdYTFV2a0dzTmRwWEpyOTFCVmdVLy9zdGx2Um0vOXhu?=
 =?utf-8?B?RlV0Tjc1Zkk5L3NSMmdkWnpabUlCR01kK0N1TU83N2RDNWZVRGR2N2hPU1FN?=
 =?utf-8?B?UjFobXIyMmYyaEhqRlB4QW1zR0dmNWo3d2t4d0JmMTFUSG9ZYzN6MVkrdE14?=
 =?utf-8?B?Uzl6QTd0NHFXRVd2VEJtdmV6dkhIdWxGOEMzTGN2YTFNNmVNVlFDbUdYOWEy?=
 =?utf-8?B?eXBtOUhzWTJmckhSU0loQzJldVp2dndXOGp0YVAyQmcwU1lYNWNoaHdwc0Jm?=
 =?utf-8?B?TFhmdUgzREErcjQ3Zm5tc0g1WWJaZHd1elVocUlWVzkvMExyd0FOazVLTGFh?=
 =?utf-8?B?SjB2UFhkcDVqVHdwWDdoeXI4QkQ2cTlSaFdYbFFWMVZ5TVF5TG1TWEtnNDBo?=
 =?utf-8?B?U0c4SlZrRkh0VDl3dGpkSVJ6K2VwTWU5a0FyS0I0WEovOWRTV1ZqYXNySnJY?=
 =?utf-8?B?YnRXRmJMc1NRZzZFaXlIWDkyRHdOZUVsY2RoRWExWnl3eDVJTnRlYmJMMVVv?=
 =?utf-8?B?TXpiWTRjeCtMbU9DVm13eU9oZUt6bmZSai9SWGNBZFpoZ3RuRlZTYnM4Z2tz?=
 =?utf-8?B?bk5XTTY3NjhTOTFhZHVpRFV0SlBiMDc2WS9sZnFscmE5Y2hCYzBlZz09?=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB7075.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0af601-a100-4418-1717-08de70a9dc2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 17:59:57.8523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GS7Z9r0L4bXFpHiN448LKFhSEcvaXCXaoe8Rc0fCtl0kLNb6RWSJcyMhOjeBD/15S9WCX6BinJTIUXhY84Gq2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4642
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <C882C4DF39D58F4F9C04D794C1B2B695@namprd15.prod.outlook.com>
X-Proofpoint-GUID: jI9ILPKVEoIyuJh8ATj8gwaqRBW0Y21N
X-Proofpoint-ORIG-GUID: jI9ILPKVEoIyuJh8ATj8gwaqRBW0Y21N
X-Authority-Analysis: v=2.4 cv=KM9XzVFo c=1 sm=1 tr=0 ts=6998a121 cx=c_pps
 a=Ess5LnjAiV6zB+80YbJDlg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=fOWFSvIUk13Ew2IH0woA:9 a=lqcHg5cX4UMA:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE1MiBTYWx0ZWRfX9oTuzqwCVnhl
 mdV/SVymu8COt3Gx4Onadl1A6UsoF2hkvtO0rhvNJGDZrToIL7N6A/CLXHu1eC/3qNWguF0OMBc
 FDSCYKOgJ35xqMDQvDd1pe0yeFK7mise/Rj00TxA9LYm7pWClVMVMSLMk2cTKMwQf2mR2YV2+YC
 yB9ZZTWc4b4BYBAd+mqHL36NppT+tlIAo3TMyYO5inrU7o7XV0ozKoKl9lf5aojEuMRhjH7JuU4
 GkCr+AKhKofwNHcwj0jlXP29yh8q3b5gYZx+WWHmhCQP6HLuQbRr+pcONc6tnqBawkC14SX6Arv
 nvUq2ArEuWE4jae+xc7krjtpcbQSpbowvUyH+3LY3ENEeWGuM8uFOSk3BlPu5H1xhWLDqp4CrJ8
 a7gJBuSGcfw+whqcI/4+IuGKd8+fZxTh8JZtv2wqlCcApau6/AT0GWlmZ7hwKHsMtZyVdlJKwvv
 LlpzwtZpXeadi9yscbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_02,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_FROM(0.00)[bounces-17037-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evgreen@meta.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8D671169EE7
X-Rspamd-Action: no action

Hi Yanjun,

=EF=BB=BF> On 2/12/26, 11:48 AM, "yanjun.zhu" <yanjun.zhu@linux.dev <mailto=
:yanjun.zhu@linux.dev>> wrote:
>
>
>>
>
> On 2/12/26 8:43 AM, Evan Green wrote:
> > Table 63 of the IBTA spec lists R_Key violations as a class C
> > error. 9.9.3.1.3 Responder Class C Fault Behavior indicates an
> > affiliated asynchronous error should be generated at the responder
> > if the error can be associated to a QP but not a particular RX WQE.
>
>
> This paragraph should be the descriptions in the commit log.
>
>
> "C9-222.1.1: For an HCA responder using Reliable Connection service, for
> a Class C responder side error, the error shall be reported to the reques=
ter
> by generating the appropriate NAK code as specified in Table 63 Re-
> sponder Error Behavior Summary on page 448. If the error can be related
> to a particular QP but cannot be related to a particular WQE on that re-
> ceive queue (e.g. the error occurred while executing an RDMA Write Re-
> quest without immediate data), the error shall be reported to the
> responder=E2=80=99s client as an Affiliated Asynchronous error. See Secti=
on
> 10.10.2.3 Asynchronous Errors on page 576 for details. If the error can be
> related to a particular WQE on a given receive queue, the QP shall be
> placed into the error state and the error shall be reported to the re-
> sponder=E2=80=99s client as a Completion error. See Section 10.10.2.2 Com=
pletion
> Errors on page 575."

Apologies for the delayed response, I'm having an awful time setting up a m=
ail client with proper formatting.

Sure, I'll add this and send a v2.

>
>
> In this commit, a new asynchrounous event=20
> RESPST_ERR_RKEY_VIOLATION_EVENT is introduced and implemented based on=20
> 9.9.3.1.3. It is not a bug fix. As such, no FIXES tag.
>
>
> I am fine with this. I am just wondering if this similar feature has=20
> already been implemented in iWARP driver or not.

I... can't tell, kind of? I see three places where QP_ACCESS_ERR events are=
 generated in siw. They do look like R_Key violation scenarios, though I do=
n=E2=80=99t see any any spots where SIW_WC_REM_ACCESS_ERR is produced as an=
 error code.

>
>
> Thanks,
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev <mailto:yanjun.zhu@linux.de=
v>>

Thank you!
-Evan





