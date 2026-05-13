Return-Path: <linux-rdma+bounces-20564-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK96GihXBGq6HAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20564-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 12:49:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CFD5319F8
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 12:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 897153002F7F
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 10:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80733E95AB;
	Wed, 13 May 2026 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rs0Dvgy6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a6Ribv+w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815513F1670;
	Wed, 13 May 2026 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669207; cv=fail; b=ct6y2PwoetnvrZXKi2RJBN3vll3/lU9z0xkexP4XXkKV4/jfKwEbti73nG6bsFuM3nagRn10wYfIBEcCzmGTBGQHQWQh12VBogQ8itzEGbmLaNSA5FxCeoqRTqQXw0GfMZ5ouy9siA0nAHLviqOpQAuLEc+Oonq8/gxf110Cu3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669207; c=relaxed/simple;
	bh=iKckcTRDRgeeT6PQnMp1u8hn4j9Pd1DMsryxTPoBLrI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TRzotQrrbSM6mpi59nvlBuHNkJlxSXIuLQ65H8UaLfZ5gq5wZ44xSHhgFU0sY54We3blctfibVlfi/LF4NH7nqdMAdSFJi/yhZTx1/vGwSYqOjPfVMBY79k83gQb4lUkGZLVpI/dRUJH9mLN/49L8C2C5/pM4YzFz1c8HLvBrK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rs0Dvgy6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a6Ribv+w; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D7MfAp3637188;
	Wed, 13 May 2026 10:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=iKckcTRDRgeeT6PQnMp1u8hn4j9Pd1DMsryxTPoBLrI=; b=
	rs0Dvgy6d4Ka8RCbk7H0ERR605jebMjC/UivNGg1x5VEs0He8gHulkF5qvYivrxH
	8preksQYtCF7+XNYy71eKJKbf/FTlNLuppVk70YXWXqiCKa/JpG5dj8IRxuOz1gF
	Nw3uHOS5sk7d9CqGhONG0Tb9DAYrddp5zQWrdeL276e/ZHPI+jwpClsV7hU+cg1N
	PIZsOLpPoocOn/0TkLjqs7tDDapWudKg4XF9/qNCPCqDIOVsq+05olBC+RLp6qPN
	Ayao+lITLD58S16yHM7k97wk4qGW6+Il6ONr7h1mc7L2CRPZd72bDADqSumebKA+
	yxVcd3FQhY+V7bqZSD426Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e4c96gyv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 10:46:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64DAdwB6027140;
	Wed, 13 May 2026 10:46:39 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e3nebg816-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 10:46:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOgaFVluFGbBO+jJsXPE1S694dtlJP0wlLx7tYk4nWY9SuL3Rp+goYR3AS3EuxwQb50rQqxIf40Mp6IxPevStsAYhTuEJS6o4brGhyQ+KFV/E0ZaoeZNlt85eHbRdfu5oxcJkRHZJFokiTJYk8F0O1b6Z4apT83yYcUI1EGUypO15OKpqX1tsiGSKOBMiEowjbLkSwlZNPk/01jZJEMAuVNZugNDNXUfPK3QU2sHd7CFcROOJ9nP+HBTpOPFZCD2OBZUB6RHETiYcQiCI8O2H5wc/3GzdU7lklDhUgVWcMbj7USqJF6ezVRiGx+t5bpJsP1ZFW9Gb6xzPf6ACoIALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKckcTRDRgeeT6PQnMp1u8hn4j9Pd1DMsryxTPoBLrI=;
 b=Yp8PDag5rIU1F+6QCMcVJuy7qIMr01bq2U2p4nNY14TOb1ZSZcya8c8halaaa9QPNIZahPryWSrIBtTnQQX3O5hc7EL182GOQLNwuWWUJATvq7mrv7t8IZGjw9E4f1FIOMKRbSW95jotRTXV74wdJp9i5KwvK4vaiTGPw2FWmP2oavwXIQvrinuvD/dD/Np8XFZEp6ZfSXhBNZECSYhY8UBf3zjCsM1qw2Anydt0oP56bkW84P0/tGUJtQRMRduxKe3ybfQDTeZptLeqI/vZA67NZSxJuQwWcIwUXCcZ/2pbuuroIJvA1tJeOKneXtaevRYLY58CpVpVOtx8y2RzPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKckcTRDRgeeT6PQnMp1u8hn4j9Pd1DMsryxTPoBLrI=;
 b=a6Ribv+wX1LQw4VT8VvisNafAt9I9sSJQb3hOnsIG6vyU5oBYPFT0EFJvv0WrvopQqHeC/5JyjpdnoLtYfeUeOl0xITzsSaQ3ekiIQls+5LlNGld2OFACgTNQHbsu60zMwkeV9w85htjn/Gu4l8n6RiOwX5hP2DpQafgmy8IFIQ=
Received: from BL0PR10MB2820.namprd10.prod.outlook.com (2603:10b6:208:75::10)
 by CYYPR10MB7626.namprd10.prod.outlook.com (2603:10b6:930:bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:46:31 +0000
Received: from BL0PR10MB2820.namprd10.prod.outlook.com
 ([fe80::e0d8:3402:3fa7:260]) by BL0PR10MB2820.namprd10.prod.outlook.com
 ([fe80::e0d8:3402:3fa7:260%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:46:30 +0000
From: Praveen Kannoju <praveen.kannoju@oracle.com>
To: Leon Romanovsky <leon@kernel.org>
CC: "yishaih@nvidia.com" <yishaih@nvidia.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anand Khoje
	<anand.a.khoje@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>
Subject: RE: [PATCH] IB/mlx4: delete allocated id_map_entry while sending REJ
Thread-Topic: [PATCH] IB/mlx4: delete allocated id_map_entry while sending REJ
Thread-Index: AQHc3TfomMZpIpF0xUu1l8BvfgDSAbYKY5KAgAFtRVA=
Date: Wed, 13 May 2026 10:46:30 +0000
Message-ID:
 <BL0PR10MB2820D13E6889E9578A0AAE518C062@BL0PR10MB2820.namprd10.prod.outlook.com>
References: <20260506090824.359239-1-praveen.kannoju@oracle.com>
 <20260512125819.GT15586@unreal>
In-Reply-To: <20260512125819.GT15586@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Enabled=True;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SetDate=2026-05-13T10:45:39.0000000Z;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Name=Restricted-Including
 External
 Recipients;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_ContentBits=3;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR10MB2820:EE_|CYYPR10MB7626:EE_
x-ms-office365-filtering-correlation-id: 71bbfae3-2691-43b1-d43e-08deb0dce452
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|38070700021|3023799003;
x-microsoft-antispam-message-info:
 UT6mDi7VIL2l5OPrfMzEyxbLu+MoFAZjVUhIHRnFLSLTYlRIaOcivd4V+XXaBf403K8uYqaVDJlrjlHiNTOs8tkUWHhgf62IjBo8Pa7opj77qJidH0SFOQE96tE3Es8WgrtBIR1ZnkKENLNt2niXbiB83Lrs+nNLnb5KEfSDg4VCmXqYYL3T4ZoMvkTHa7F0H9M2SzQ2jzECZ5WEEGZkBIU4x/c0m4dkEebqEGnAzt0e9RGcbXRwt52ScUgwHEuO8bbyaWKulbQ/3DrVRbLqpixqWRrX08OfsnpNni7V0iBTjKpEu/SBhKiwyATKB+Bli18ljgpu6VWzxdjSRpQkbMI3j+B0tdkwmZ58LJ9w4jKxnJ7FTtFpc90wD0b2Vke09hh+mp8iEunra8xfW4Al+G9Iz8+DGvT77lGMXqKwT5loQ59DhPfWZ0mHs9n8mFRSz3aC1mdJiusLfa7Kme4QWYVbe1W/xYpnxrkm4qfgafUEKZdktLZZuiRrTb3iuRHUQTbHJrkb5iDdA/GbNM9JUIJM2ecugGtLAT83wUBrAZc9qwD7xUsFghw8aZh+Ze+lCp9bv/LS8lO5mtJO6n3P8hhB1mgHuQoZWz41OTFGve9iyYVwv78uYsUXC1AA+v0J9uIUNTK/GOamAfGR8cJLw/PvCu4yaIxhWAVX3fjnnslx21LvFdG6o7twp0W6K/znI5mrrQLadz5aO3hun/qv1rPmkn4cRmF6M6LrjfoEJzaiR89ndcx5xV0h6MMLk3O1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB2820.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021)(3023799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STA1K0k3R2Q5UWRuVXFMeDRnMGJmQTcxRGR2dDJkbHk3amM0NVdrdnpKUTBt?=
 =?utf-8?B?ODVON0JnaUZzcHFKWlJqS0NhUS9xVllSQlBmeW1CaWhYNzN1S1VKOXhBSmJ2?=
 =?utf-8?B?bWpzRU1QK01NaTZ2L0tvTVBheWh6N1ZxSnM3ckdoWnN0aCtpNFF5ZERYRjBz?=
 =?utf-8?B?NEkwWkZaQi9nM3U4ZStMUGxLR2ZyOHdPWUNRZldhYWZGc2ZDeHhOdktHSDEy?=
 =?utf-8?B?aDRWeWhKK3NlQlFVaWtuNFVHTWphZFNBc1cyT1hFVU9NdC9tcVA2QnllMEpq?=
 =?utf-8?B?OWtXeVRNenJ1bWJ6NjNDZnNraVA1aWRKZXdla3pxV0pJeStWQklCVlp4Znk4?=
 =?utf-8?B?T29jRGNMVHU4c3JOQUFsa09JQ2dZMjVEK3dRbkR6SVNqWjJEMFREb25ncGVr?=
 =?utf-8?B?dlMrMWt6TFhtYTNOZnBKRVg0d2RIOVN1aTBkZjFwQmNhSFlOZWxoVm0ray9m?=
 =?utf-8?B?RFVyNUkvb2xjcEVEUEVEemRKMmJOS1JvalJ3WGdJUXRZby82bHpUakJtUmZX?=
 =?utf-8?B?NU5xcUt4c1Btd0RHNFV0TVlmbXQzdkd4dlBrdzRGNmt5eGZaV3hCa1pFclEz?=
 =?utf-8?B?RGZrTDFnNytESFRlTDRwYWg3QnR5SHdMZHRXeVJKZ1VLMEU0QXZMZUEyOUxk?=
 =?utf-8?B?SUlpbjlzTnFIV3BmTjVRR0VpaHJDR1hIZXlYSEc5azlnM3N0L0tGS096RDh6?=
 =?utf-8?B?WnBsNjdJQlZjbStyWDEzS0JLU1hBRVh2WEt1bi9ndjhONGE2TmYwYzdKTEJC?=
 =?utf-8?B?THhpSVlaaDcvYkg1bXkwdjlEKzNTcFNHMm0yMVR5S0kralg3VCt4REF2bnNL?=
 =?utf-8?B?a1o4bDhHMnZrTURVZEE4dThrbGNPTXFtQWRIdXBFMDNDakZrS0hRVW5SZ1hl?=
 =?utf-8?B?alduTUMzZVBLVTRWZEtpQ1hyd08ydWdnMkR0K1BPMG5KZlhDRW96Wi8zbncw?=
 =?utf-8?B?NENyU1lSazlTd1BBcktxb2xveUpDWkFCSi9vRDlXYXNJZDRxb0FXcFdZaXJn?=
 =?utf-8?B?NVVnOG5kU2c1SUduU3YzcS94SGhEQWYyVG5JbUhNY2JmK0dIMDhTTEZBZERW?=
 =?utf-8?B?WkdwVHhXL05jaWRGMVAvQUVJUWhMV2RJNXNzRFZCSGJNckxTZHpESEtjSDE5?=
 =?utf-8?B?TmRFWjRqazZvd08xbUQyeHNwZkQ2cEpiZVJ1enA1NzFtcWcwMnc0bU9DcHpS?=
 =?utf-8?B?TlNXbjdER0QxZEc5RHdlSEZQa003a01JVVRXUVNvMzU3T1F1QUVrcUFQZGZY?=
 =?utf-8?B?MnlLY2ZKK3lnMUl0OE1xUFU4bGt1OXFKandSUEVSS2lrdTVUWS9ZSlBnYnA3?=
 =?utf-8?B?SU5yRGdDZkdZS3I1Qy9TdU9uOWQ5WWFXdHFoL0N2dkllU29tY2FzVGdLc1dY?=
 =?utf-8?B?amVNeUhjRjdRRlhTRWQzVWsyRDQ5L0J0R2lYYnVoVG1XVklvWlliZCtOckYv?=
 =?utf-8?B?eXFqV0poamU0cGFvTnZJdDdZTjZHdmdJekc1ZHVTdkE5NytsRjR0SFJwbVZr?=
 =?utf-8?B?NTBoMnNyU1hZVHl2bE9uY1NMNnBFOWY0VC9jK3h0ODM4R2xRc2tXU05CQTBE?=
 =?utf-8?B?TGMrYlBoVC90YXl4aDlzYlNCT3I2S1VGaWZiMVFCL2RXVHhwM3ZPcmpYdVdF?=
 =?utf-8?B?TWsyMndHUmRMbWZ1a2FONFBoTFZyOExwS1V0NTVHMlBLSzE2MHJSMUV6Q0FS?=
 =?utf-8?B?NzJhUFdvdWZvVC9oczZSMVB3YmFqZ2lWWlNHQ3NzbWNsQ1NyMVZUY280Vmlh?=
 =?utf-8?B?T1g5UFExdEdLM3ptT3RKTXZocEJBc3NDVEI2UjRaY09aU2dva3lOUVh5dEhP?=
 =?utf-8?B?M2ZzeTF4S0VBLzE1ZENHS29lQ01KamdmZitQMHFRWTdDbkkrSU9pVW5yMEd6?=
 =?utf-8?B?ek5vWTdsY290aWY4dHQzQnFUcUhab3NOWXFIc1pqMUppR2VGbTFJelV0a0Rk?=
 =?utf-8?B?WC9mUFNKZU1Pd3JjbFRwZWlNR2ZMWGNhWEt3eXlLM25Fc3VTYUVkQmY1MGlK?=
 =?utf-8?B?YURwTGVrSXIrMXM3cGNHdTk3SytWN3V2WUdYZnZScVB3V1VpeEphME5HcXhv?=
 =?utf-8?B?S1FYY0tLLzkvZVNsSEhFY216UTg0eHU1eUhZTlowTENacjJkRk5hU1VuK0hC?=
 =?utf-8?B?K1pabjN4M0kxR2luTWo0WDh2TDB4S3EyRVhtWmhudWN5K3h3dUdaVmphS0pQ?=
 =?utf-8?B?cndaQzd1Y2YyUWVRSzBwdjBZSC9kTmlTNnorV05EWUJYUkFEMTQ3YkhCSzZy?=
 =?utf-8?B?bTl0Y0s2WFdxU2I5bEd6U3VRcExhRkZaVENEaUo1NjZzaFpleXVhdkRSZjlZ?=
 =?utf-8?B?cUhkQklmaFI5TXRIcEdPMHBZYUVJSnV5Y0hmc2pLNHJhTTU0aUVBZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	GCXugr7SFX0Aqf42AnNXVee3k/JtcVYUZzDmZwnp49FQm+1m8dojVM/j0QZWFEI7cU79EgWkFGMfOyZSrC2/88DWivg411Tez0zud1qBtD4yU3jhHl1neK+n2AhLpzjmyUljiDUtVEEZ3Xl5z2P4yNpOTsSJKg6KWjo5yN3QwVMEN2DYNx/hKN+6lX+U5h6ftj1j6d+/jHIr9KN8AFf4nUIT7N9mcACHtJR4kGqlLqLUI7OQMO8do8lMPBLSnculP8dr8qGEurQ4xJXgbTByHj25dyX2YyPSvE1/GdaIt91XkaytYWl0UTRSOLM0Y4QS+Uo759CpCgCmRkPrg6A+5Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b+B/ON+qpXK5CkMg9qyY8bThy9VgQbCstiw2xN8ItHTAgFCdu75iZTArYoa6Qa2Qzhk1mW6kHA9q69uZR/esugoHVYTuMG1+O5VKx+2/XzNM5CbQlOhn+kpO6mo/2RSlvX1IMfq9e/GCyVJ+mNsK2t4dNnQB1x7PgTmOrEBdREEkD3AAr3qnbhNuTK0ZIymURxsCH4bvYDcerILE2Utz/zdT7Yt5P1pFkW7U3a/cJXxCQIwNno4gpar9StPRLYTHe3lMgWBXQFiGPlY0z15dkk4mZWmAnEtdqRS2BJ6PH7UyswgESRmDTxvdvj2/cZhLBgabJJeTsP6CnAH+qhROecvKofbzWFXsvPr/oC4A3YvSAEpwlBeJgNRYWEAy5hg+eLORtg02blkBxBaVzrw7lQlBcJGq2oH1i625BbnU1TR1IxdiBU8nXX696rMOlrd4WfL6EYBR41NQ2WQaiddQ2hASidRlgd6TIqO22hB0Z/OqvMkOYnkjkICaSuoIqbKuLKDNcofWLpGm0nNwzcxQj5b6+Z0U1Vu9P6bX9v86UFnNxFgkQDmlGYp5urb0UMaWm5lxBXsRajf3mIErUg1hwRtmykHcQfSxJBqT2jBunGc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB2820.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71bbfae3-2691-43b1-d43e-08deb0dce452
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 10:46:30.3033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EHBeeIZh/FckxGkEkpTbuXypbntz2DwZu8kM8l4X8U6OGSsTyfieZfc6duqQkF8KkS3xM8ACGWwXETMI0PqAesEKWnQdwCRYjEyr7BXR3B4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7626
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605050000 definitions=main-2605130112
X-Proofpoint-GUID: rsei0p5zngBguqPdzb7tpz_WiedUyqUS
X-Proofpoint-ORIG-GUID: rsei0p5zngBguqPdzb7tpz_WiedUyqUS
X-Authority-Analysis: v=2.4 cv=fvnsol4f c=1 sm=1 tr=0 ts=6a045690 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=9jRdOu3wAAAA:8
 a=vnv3ECiJB2qDF86_QF0A:9 a=QEXdDO2ut3YA:10 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDExMyBTYWx0ZWRfXwIaoXgEoiHDi
 zA6kivL72LMaepiGmAAlda1/IyrehEq1RaHh/Xa3Qlg77jsp8GLxNdo9jIQYho87pT4yybbKnpM
 hAbUmKDp7BbxwD5jxUFIWnIs4ZDuFkk/5JU8eYjlbvPMzyb68hR4BCUjbgp/Qm0qq8Gj6OqM++c
 X50ZR8rWjBTZRzvxL4+dGMO+fniyeBWfDXwesxJy4+MHYtb1uccw52kmaiKy2dpKuqWHa2dI3vu
 b9f3tZ1ACtWbTsAETFuWAmFk1guVBY/pvA34Q3OTGkv9BYOpbrX/e1V3d1g2n5vP8qlYeFRusqt
 ZxTGidVg6PZPNor7viPS3SS2CvSK3wmZ8tjHz5zLnMRWjgxIU/e69gNzzpKk/x7zX+3jOfnpc+n
 /zfeXKYGZ11JRppGwJudSKCix5i1ORohuEmvlMLfKupcWJV2gOhvVbsVsPO48gRRAS4bGcbtK5j
 JCJq6Aem/qVAg5b2C+Q==
X-Rspamd-Queue-Id: 60CFD5319F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20564-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,BL0PR10MB2820.namprd10.prod.outlook.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,oracle.com:email,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Q29uZmlkZW50aWFsIC0gT3JhY2xlIFJlc3RyaWN0ZWQgXEluY2x1ZGluZyBFeHRlcm5hbCBSZWNp
cGllbnRzDQoNCkhJIExlb24uDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcuDQpXaWxsIHJlcHJv
ZHVjZSB0aGUgaXNzdWUgdG8gY29sbGVjdCBrbWVtbGVhayBhbmQgcmVwbHkgeW91IGJhY2sgd2l0
aCBpdHMgb3V0cHV0Lg0KDQotDQpQcmF2ZWVuLg0KDQoNCkNvbmZpZGVudGlhbCAtIE9yYWNsZSBS
ZXN0cmljdGVkIFxJbmNsdWRpbmcgRXh0ZXJuYWwgUmVjaXBpZW50cw0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz4N
Cj4gU2VudDogVHVlc2RheSwgTWF5IDEyLCAyMDI2IDY6MjggUE0NCj4gVG86IFByYXZlZW4gS2Fu
bm9qdSA8cHJhdmVlbi5rYW5ub2p1QG9yYWNsZS5jb20+DQo+IENjOiB5aXNoYWloQG52aWRpYS5j
b207IGpnZ0B6aWVwZS5jYTsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBBbmFuZCBLaG9qZSA8YW5hbmQuYS5raG9qZUBvcmFjbGUu
Y29tPjsgTWFuanVuYXRoDQo+IFBhdGlsIDxtYW5qdW5hdGguYi5wYXRpbEBvcmFjbGUuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBJQi9tbHg0OiBkZWxldGUgYWxsb2NhdGVkIGlkX21hcF9l
bnRyeSB3aGlsZSBzZW5kaW5nIFJFSg0KPg0KPiBPbiBXZWQsIE1heSAwNiwgMjAyNiBhdCAwOTow
ODoyNEFNICswMDAwLCBQcmF2ZWVuIEt1bWFyIEthbm5vanUgd3JvdGU6DQo+ID4gRHVyaW5nIHNj
ZW5hcmlvcyB3aGVyZSBhIFJFSiBpcyBzZW50IGFmdGVyIGEgUkVRIG9yIFJFUCwgdGhlIGFsbG9j
YXRlZA0KPiA+IGlzX21hcF9lbnRyeSByZW1haW5zIGluIG1lbW9yeSwgcmVzdWx0aW5nIGluIGEg
bWVtb3J5IGxlYWsuIFNjaGVkdWxpbmcNCj4gPiB0aGUgZW50cnkgZm9yIGRlbGV0aW9uIGR1cmlu
ZyBSRUogaGFuZGxpbmcsIGlmIGl0IGlzIG5vdCBOVUxMLA0KPiA+IHJlc29sdmVzIHRoZSBpc3N1
ZS4NCj4NCj4gRG8geW91IGhhdmUga21lbWxlYWsgb3V0cHV0IHRvIHByb3ZlIHRoZSBsZWFrPw0K
Pg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJhdmVlbiBLdW1hciBLYW5ub2p1IDxwcmF2ZWVu
Lmthbm5vanVAb3JhY2xlLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3
L21seDQvY20uYyB8IDggKysrKy0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmlu
aWJhbmQvaHcvbWx4NC9jbS5jDQo+ID4gYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NC9jbS5j
IGluZGV4IDYzYTg2OGEzODIyZi4uMjFmMmY0MDFlZDYxDQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDQvY20uYw0KPiA+ICsrKyBiL2RyaXZlcnMvaW5maW5p
YmFuZC9ody9tbHg0L2NtLmMNCj4gPiBAQCAtMzIxLDEwICszMjEsOSBAQCBpbnQgbWx4NF9pYl9t
dWx0aXBsZXhfY21faGFuZGxlcihzdHJ1Y3QgaWJfZGV2aWNlDQo+ICppYmRldiwgaW50IHBvcnQs
IGludCBzbGF2ZV9pZA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywg
c2xhdmVfaWQsIHNsX2NtX2lkKTsNCj4gPiAgICAgICAgICAgICAgICAgICAgIHJldHVybiBQVFJf
RVJSKGlkKTsNCj4gPiAgICAgICAgICAgICB9DQo+ID4gLSAgIH0gZWxzZSBpZiAobWFkLT5tYWRf
aGRyLmF0dHJfaWQgPT0gQ01fUkVKX0FUVFJfSUQgfHwNCj4gPiAtICAgICAgICAgICAgICBtYWQt
Pm1hZF9oZHIuYXR0cl9pZCA9PSBDTV9TSURSX1JFUF9BVFRSX0lEKSB7DQo+ID4gKyAgIH0gZWxz
ZSBpZiAobWFkLT5tYWRfaGRyLmF0dHJfaWQgPT0gQ01fU0lEUl9SRVBfQVRUUl9JRCkNCj4gPiAg
ICAgICAgICAgICByZXR1cm4gMDsNCj4gPiAtICAgfSBlbHNlIHsNCj4gPiArICAgZWxzZSB7DQo+
DQo+IEl0IGlzIG5vdyBzaW1pbGFyIHRvIHRoZSAiaWYgKC4uLiAgJiYgUkVKX1JFQVNPTihtYWQp
ID09IElCX0NNX1JFSl9USU1FT1VUKSINCj4gZm9yIGFjdGl2ZS1zaWRlIHRpbWVvdXQgYWJvdmUu
DQo+DQo+IFRoYW5rcw0KPg0KPiA+ICAgICAgICAgICAgIHNsX2NtX2lkID0gZ2V0X2xvY2FsX2Nv
bW1faWQobWFkKTsNCj4gPiAgICAgICAgICAgICBpZCA9IGlkX21hcF9nZXQoaWJkZXYsICZwdl9j
bV9pZCwgc2xhdmVfaWQsIHNsX2NtX2lkKTsNCj4gPiAgICAgfQ0KPiA+IEBAIC0zMzgsNyArMzM3
LDggQEAgaW50IG1seDRfaWJfbXVsdGlwbGV4X2NtX2hhbmRsZXIoc3RydWN0IGliX2RldmljZQ0K
PiA+ICppYmRldiwgaW50IHBvcnQsIGludCBzbGF2ZV9pZA0KPiA+ICBjb250Og0KPiA+ICAgICBz
ZXRfbG9jYWxfY29tbV9pZChtYWQsIGlkLT5wdl9jbV9pZCk7DQo+ID4NCj4gPiAtICAgaWYgKG1h
ZC0+bWFkX2hkci5hdHRyX2lkID09IENNX0RSRVFfQVRUUl9JRCkNCj4gPiArICAgaWYgKG1hZC0+
bWFkX2hkci5hdHRyX2lkID09IENNX0RSRVFfQVRUUl9JRCB8fA0KPiA+ICsgICAgICAgbWFkLT5t
YWRfaGRyLmF0dHJfaWQgPT0gQ01fUkVKX0FUVFJfSUQpDQo+ID4gICAgICAgICAgICAgc2NoZWR1
bGVfZGVsYXllZChpYmRldiwgaWQpOw0KPiA+ICAgICByZXR1cm4gMDsNCj4gPiAgfQ0KPiA+IC0t
DQo+ID4gMi40My43DQo+ID4NCg==

