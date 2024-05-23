Return-Path: <linux-rdma+bounces-2590-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EF78CCC6B
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2024 08:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCB8283A86
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2024 06:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644B613C910;
	Thu, 23 May 2024 06:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="PaTgGk+T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F1D13C909;
	Thu, 23 May 2024 06:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716446744; cv=fail; b=kfgNlG/nSZ8K8jx0U4ic7iCUmp9vVPHghIluX+dIkyNrYqtPOzi3wnFTJjsk6/K9V0RGqUKJNsKsFFBtImn2wpVYJ404Jg0cZYgg+W5ppH8C804T20ACikgKbBDUPkJsrZ6pzr9/juoxn/cDVZXQIk4FCHxEFNOODPHXhGmN7+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716446744; c=relaxed/simple;
	bh=uZQg4I24oPsjSn4RMXh0a7+ry58+BW7Ulkph1+JLIdY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FDu/EcFko1gl2lAYW1z4u9YwUfksChB/zEbD2b2TJM7bFe2GSC29ZsbAmmE4CYgug8hfU3MSxgWPfQyj35IEk47QkrBzory0HVRLpizVW6fIRbo5xXzp2Qo6H6TzooVtUTYCXOrRyCeb59CAN9+nQfwCfZzRI9dpgexJtqlDpo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=PaTgGk+T; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44N4dETg003244;
	Wed, 22 May 2024 23:45:13 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y9xy7ratw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 23:45:12 -0700 (PDT)
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 44N6dPxb007177;
	Wed, 22 May 2024 23:45:12 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y9xy7ratu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 23:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8D9MmueWWZ5Cc4IjGh56MSR3IahPqH18JToO7giExXPfdmrU2wUdRrhcumMEKWu8yMyqpoG2AK+wF8nM/+MA/mP1U7lt4UnA0CCFDQBWF/IM2SkYyVkmMKq483+dx+5Op+V6sIBtgB+FVqP3BqTYfQdk9OhM1n5nSIifTsO0KvJW3cRvVhhgwdXY/1z94453ZYE3G8nlqfoLxGTj+x2jiXcq9FuqCOPe0Ew6tpYQEx9Ms4d7m8PtIci0KdXgIYOO4ZM3XK9sIw/hlUAXNXKejrslYCQxFkYHul3hrLZOz9/1KogypXIE3eI5TggaFSA2+co0S/D4wfUBpdPcm95Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZQg4I24oPsjSn4RMXh0a7+ry58+BW7Ulkph1+JLIdY=;
 b=FBFiLD0S0QE5V3UEQeOMNJ59gvOrkgX/4tIP5kj+EU/WsdnpM7r5PjxKZExwAUNJuOechRzjxEq8Y1gcUXBH4ac9X/ysS6Y9s6RFWVpKezcWjrPaoZ5T/OtMw8xPn8bxAGPRj2Y3Y8dz3KOykICnc1IPdTylBbg+2wvDe5RgH4VKxKFvhGmsoHaAIMG/+wecJJtRmTIKjrQDw+geRomhOjFF1pUTtdRnUr5HyCicn9SD0ULHjWd6tPmWNtA5NHuPWFa6eUby/a3MSxBDRti5df8Min1+lki6eciVQbZRlSHRYGr1AGGcrWVO72yTIGid7Jm5JaRYwR7wWa/X1ZEPqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZQg4I24oPsjSn4RMXh0a7+ry58+BW7Ulkph1+JLIdY=;
 b=PaTgGk+TReqzRfA/wu36Mzafe77z2L0NIkYXwa51ptsTzfi1AclHXYBB8eaaKa+8vSw3QEi5clzpmGWcxlLVCtCgcCjcsc3mvqa8SY2CokGLn3sa2EystXsUdsTBiJhVvyvM6fEUe4hVNbcAVvatiwD4xQlQ/5bgWve/C2qbZ+0=
Received: from SJ2PR18MB5635.namprd18.prod.outlook.com (2603:10b6:a03:55a::21)
 by PH0PR18MB5212.namprd18.prod.outlook.com (2603:10b6:510:166::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.37; Thu, 23 May
 2024 06:45:09 +0000
Received: from SJ2PR18MB5635.namprd18.prod.outlook.com
 ([fe80::efe5:32a7:11a8:840d]) by SJ2PR18MB5635.namprd18.prod.outlook.com
 ([fe80::efe5:32a7:11a8:840d%7]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 06:45:08 +0000
From: Naveen Mamindlapalli <naveenm@marvell.com>
To: =?utf-8?B?SMOla29uIEJ1Z2dl?= <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Saeed
 Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        "David S .
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Tejun Heo
	<tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Allison Henderson
	<allison.henderson@oracle.com>,
        Manjunath Patil
	<manjunath.b.patil@oracle.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Chuck
 Lever <chuck.lever@oracle.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yang
 Li <yang.lee@linux.alibaba.com>
Subject: RE: [PATCH v3 4/6] RDMA/cm: Brute force GFP_NOIO
Thread-Topic: [PATCH v3 4/6] RDMA/cm: Brute force GFP_NOIO
Thread-Index: AQHarNzA6HBeX/6Yok6cnHL7LFHsGQ==
Date: Thu, 23 May 2024 06:45:08 +0000
Message-ID: 
 <SJ2PR18MB5635B31CDA691101A79ADA85A2F42@SJ2PR18MB5635.namprd18.prod.outlook.com>
References: <20240522135444.1685642-1-haakon.bugge@oracle.com>
 <20240522135444.1685642-9-haakon.bugge@oracle.com>
In-Reply-To: <20240522135444.1685642-9-haakon.bugge@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR18MB5635:EE_|PH0PR18MB5212:EE_
x-ms-office365-filtering-correlation-id: 645ded6e-eba8-41f6-d232-08dc7af3e34b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|366007|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NzBsME5EUGwwOENCTU1YV1Z6Nzd0RFIyb2Y5WEgySnNzY1I0MmdpQzhUOGh0?=
 =?utf-8?B?L1Y2bnBQdjByNHdiaytZcHdWODVYQnhPNmpYRmpXbUF1eEVoU1lQZ2krdWIx?=
 =?utf-8?B?T28xZXhieWp4aG5XWTFHc1k2bVBNSEtTb2tKc21ta2dyaGp1emwzNXhrNDdx?=
 =?utf-8?B?YmpEMVVIOTg5MDlybGNtUks4cWhkYlNObjg3YnhvOUIyazcwazl1dEZMMG55?=
 =?utf-8?B?MzlHUzNqUGVxNHRBcFgxVTRnOStoZWxzYlVwVGFxMGhmWlFFbWtCaVhFZ1oy?=
 =?utf-8?B?VjYram1sUHpVZkJyTEgrTmRKR3RVVlRabjFTVFg2NTVIaHhaWTN0UWxFdkF0?=
 =?utf-8?B?dXVSYU12dFdNb2tqUElNK2RRUnJya1E3Z2dYTmxkUFM3VS9uS0gxVUtGYS9v?=
 =?utf-8?B?MzI4Wk5sVHAyV2pWcWZUTXpIL2JtT3REWVVET2J6Tzl4WUFxbTF4QSt2WXNP?=
 =?utf-8?B?ZVJjeXZpTXZ2QkxySk8xRlR1ZC9sMVIwa3BOQ1psMnFSM1lQNmE0aE5ROWIr?=
 =?utf-8?B?Zzk5YzBudStVNzhCZmVEVFhMZ2xCaFB4cmhraTJIMUk5MGIrb29pU2ROd05J?=
 =?utf-8?B?V2dJNlZDMFhlUlFRWWU5UTgxK0ZUNnpHZFhTenE4L2VnUXRxbDExMVZmQ2JK?=
 =?utf-8?B?emZMemRaM1BhUmcydnNDalR3Vncvc1pXQWYyK1Q2K1JuMWlmd2ovdTcvTUox?=
 =?utf-8?B?YU5obzFaRzRuWG8yamtSdUJTbnhKZExIREVRL2U2UUtBMkNMUytaMUxFVnVx?=
 =?utf-8?B?Um5iZG52WjY0eDVwSW4weVBkY0JnYThpckZSaVB1dGZWTjUzY2V0STcwZXhM?=
 =?utf-8?B?eEx1cm9DUUEwSGRnTjhUN1VjSUJ0UDRJYktmNXdqS0N3WGwwNDlBeS8xMGR0?=
 =?utf-8?B?YXFHYTFnRjFobU16UFdzOEpiakxxVjRTS0o5Nk5laDFlTlgwb2RxT1RhTVND?=
 =?utf-8?B?T3NMa0xkV1J1eTlhWGtCTExRZ3NPaWFVeHJ0RC9Nd0UrWjZnckVORHg1MUZr?=
 =?utf-8?B?MmhKNVRmc012aEhQaVl1ZnRwcGF1dlBpZ2NxbnV6NFUvbFdscnBCOHFTWng1?=
 =?utf-8?B?ekp5cDVzdDBmelhqZHpVVVZ3aTFoVnhERVJRTFJMQlBwQXFnbHBBSk14OW9o?=
 =?utf-8?B?RDJtWHBPWDU2c0RzQW9UWTRJakp2bmdNai80WTh5RW1Vc1RjZTBYblM0c2VV?=
 =?utf-8?B?aWZGQTdsd3lNYng5bXVqRzhHWk02a0lnaU5hbmV6QndCVkZtVm5OdTlHS25K?=
 =?utf-8?B?SGtMTXd0eVBSTFE5dTI4cWEvU2RoM3EvTHgvVUlDY05uSmFDU1F0VmxHSitG?=
 =?utf-8?B?dldDTlhNUmRTb1dnRXpMN2lLUkFJUk1DY3d1TkZxeDZ2WGcwS29oa0lrVEdy?=
 =?utf-8?B?TjhtU1cwNDFJaDNZMTBtRmtFdHVlSWszMXFrOG9leitCK0dtUzlPaFFnZ3Er?=
 =?utf-8?B?ZVhha2oyZ2Q5U2F2U1ZmL0ZNQlZBSS9hNDVVSExBcW50Mld4TXFtbHgvWFpU?=
 =?utf-8?B?b0xab1ROdVNRTjBNSGhBZnhkVUVvZjRPTjRxR21ScWdENmVpVjljb1lWRGY0?=
 =?utf-8?B?a1JQZVBXSGtEZXZJdUtIUkJtY3dtYnhLMG1zVnNQbC8rRkxjYUs5Zk9uWWxW?=
 =?utf-8?B?OTE1RkNEcGZEMWRsVkFlK0hQRXYyeGxYeENoaUZtTHhpRkkrSHRoSURacm5s?=
 =?utf-8?B?TTlpQ3Npak9WclpzKzBwUFFzbWlrQzlmQU9Galk5anE3Z3dZY1B5M2cxcld4?=
 =?utf-8?B?THp5QWdJR0U1VXAzcUJDSmlBcWJvdmQ2ekNHQXNuaDFCSC9mTk5TaDNJLzhI?=
 =?utf-8?B?QThtSUZ4Tkh3WW5JdStwQT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR18MB5635.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K3NjYVVRTmg4S0ZBUDZxZ3RoNUlWZGJUVlNScWJqVjMxRm80NUNLY1ZMeUd2?=
 =?utf-8?B?bzl1ZTQ1YzVTajlBV29pbjlvRUhBcW5LZEk2OE9icVBuYWJvak0wRlVWNVVk?=
 =?utf-8?B?S05MNWFBUW1QRjRUaXFnZng0cWt0RFNRMnlldEdPTFhIWUR4S0hrODhTNGFl?=
 =?utf-8?B?cThFSlFGK1NGaGt2K3lISmQrd0MyWlg5R2piaDZNVWdydUlXVzc4UEU4QWJL?=
 =?utf-8?B?b2YyUDFWK2VuNVdXdnpwLzd3SXJjZVNRRVk5NHhmNFpjNlhhSVhvTGFPZ1Vv?=
 =?utf-8?B?dTZ6T2djUjZheWplU3lYSjdjeHE1OURpUFBZdVVnbTk3NmtRbm9zdGtDUXVQ?=
 =?utf-8?B?Y2FXY0loNGZzZzFRVTVNUEI3VjJDcURIeWpSV0FqSGJlT0hhQ2I3MUgvTDVY?=
 =?utf-8?B?WlgwQnlPeGx5WHR0WFI3Z2FaUTdXdzY2bUkxeU5ibGlLbWpaczlLS3RMSGNu?=
 =?utf-8?B?ekNnT0dpd0xWRWErbm9ZT0huamZjdFowdnZxbm41ZzhhQXE1TFFxcDlIVEZE?=
 =?utf-8?B?dGpQSDlyU3VkemhwRDdZTWRZSE93cmZLT3hjN0o5Kzh1UVkyQmZGRERHZTBK?=
 =?utf-8?B?SUVSQklYQmdFRnB1N1dSWWJURG9BWS9KdUVDSTZHVE00Z0QzaDYxWWk0U3Jj?=
 =?utf-8?B?RmM3MjArbmJlTzEvV0VUc0Y1cUs4Y1Q3TEVyUXJBN2ZDSkNYYjduVkdDMEYw?=
 =?utf-8?B?ZDVqeCs5cUVKdzRiblltZUF4dnFyT1QyZ2JRVWhaWEkwWnpTVWJVUC9XcDdi?=
 =?utf-8?B?VmwzdGxCRXNKcWtaUEtwY0I4SzB0NVE2OUdrd3FBL0s5S1pOK0N3dlNpUURr?=
 =?utf-8?B?Q0lYWmQ3UXJTdkR3U1MxYkdjYlV0b1hvZVdxcjRwWWJnL1cwZUVGbGxaNWxy?=
 =?utf-8?B?TWR4Q1ZGemoyOG5mQ0t0aHpTK0ZTYk11ZFlqa2FicVBTK0UrR3Y1MlhkUkFn?=
 =?utf-8?B?WU0xaWxOYWpGVHlsNWNLa2lNL3ZSMGZmZHZXaWZMTE9HYk9sOHpxVXZhN01P?=
 =?utf-8?B?NWJ1ZXV2NWk2aGZvcW9lbkh5dnhOb2hGQWNqSkRuU21DSHovcXRsSTlRR2R3?=
 =?utf-8?B?OWFzek5TeDEzcC9NUXhBc0taR0pHM2ZyWk1pL2lWMVNsNWdKdDdkbGk0T3J6?=
 =?utf-8?B?NW0wS2VhWm1rSWJjZExHcDM5NmhndUk0K1JJMGQraldOejNGTzFXTktzSkZD?=
 =?utf-8?B?WmhIK3FFSVRwbEtpTGR2QjBIUU5McFRtam1sNnkremdKZXJqOVkvamI1WGtD?=
 =?utf-8?B?V3l1ZWVkbGxPU3RjZnVsc3BiNVIySmZtdmxMa0tWQ1VNaVQ0ZVMvWktHa0Ur?=
 =?utf-8?B?QTgxaVpVTE1sV09STVRESjZoWU5ZUm82YWxEL2VpYkFIN3BXSDhvZXJOekNs?=
 =?utf-8?B?UHoxRHFJalRycHIvQm1kdlNacHJ3QnlkVDcxWm9iczdXUkJmOHMvMDZ3NnV4?=
 =?utf-8?B?bC9kRkl6d3FjUmdJcEk0VUVMN2U3QWN6WkEybU01R0l4L00xSW5UaUhoNXY3?=
 =?utf-8?B?SUJSQ212QktmSUFGaU54cE82b2hUaVM3N0NTZ3lwZHdtMmtJZXFOQjVDdG9S?=
 =?utf-8?B?L2czL3cyeGhFOTczd25mZFhVSS94UHVJdGt2UDBVbUZaVk54Qy9FTWRwclJQ?=
 =?utf-8?B?cWZ3a25LL0p2ZDZ1T2t4dE94Mnl1S2taQmZDZFdVYXpIcU1IMkZJczlRTTNa?=
 =?utf-8?B?OHg0S1A0TVNzM3FvajgrN1EyMEFmQ3RrRnJnUC9zSTVMRURDcE5mNzFPdTdH?=
 =?utf-8?B?OUJPczVXMlRMRlliT3RpeGNiWitXNDVLNGh2a0pjbjBqVzFpbnEwQXRzY1Q1?=
 =?utf-8?B?MWZubDlva0llWHBJV2JhTVZTTlFrWHdWNW5TYk1pcFZkWi9wLzkzOUJhcG5S?=
 =?utf-8?B?SHlXNVNKU0plaVVWeUMrRDJJNUVZRHNvL1RNdnU5L045bWN1ZVpsWktKOE1j?=
 =?utf-8?B?MlhEQXhCSTkzenp2K0hxMmNOT0VZM2s5OHNlbENxSlBubk1HUWYvVldVTEFV?=
 =?utf-8?B?OElpQnJvdE4zcnFqT1AvaGxkTExqU3lQTmp3a1BPeG1ldUtlUGZUUUg1cEtO?=
 =?utf-8?B?K3FBbXEvQzZTWUptdmdGcTFIamxVNTU5WmVNMW1pT3g0cHk1UFRYNWM0alk0?=
 =?utf-8?Q?tnxr0yILgWjMRhgNEkjD0WZOC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR18MB5635.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645ded6e-eba8-41f6-d232-08dc7af3e34b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 06:45:08.8720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r3LjYQ/6+HatKysQUzcpvVM5hY0sby7dC343eWGqkuQATIovoYcU5ar0Zatd8gfb0EdsftN/VuuJT/ZxwnbETg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB5212
X-Proofpoint-ORIG-GUID: yZ12ISefuROTnUtFFVVqfD4YL-Gd5FwP
X-Proofpoint-GUID: Q-Ld5FTpFaiojFTQlRVnR4VBUHMTBPiz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_03,2024-05-22_01,2024-05-17_01

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEjDpWtvbiBCdWdnZSA8aGFh
a29uLmJ1Z2dlQG9yYWNsZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDIyLCAyMDI0IDc6
MjUgUE0NCj4gVG86IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOw0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyByZHMtZGV2ZWxAb3NzLm9y
YWNsZS5jb20NCj4gQ2M6IEphc29uIEd1bnRob3JwZSA8amdnQHppZXBlLmNhPjsgTGVvbiBSb21h
bm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+Ow0KPiBTYWVlZCBNYWhhbWVlZCA8c2FlZWRtQG52aWRp
YS5jb20+OyBUYXJpcSBUb3VrYW4gPHRhcmlxdEBudmlkaWEuY29tPjsNCj4gRGF2aWQgUyAuIE1p
bGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldA0KPiA8ZWR1bWF6ZXRAZ29v
Z2xlLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaQ0K
PiA8cGFiZW5pQHJlZGhhdC5jb20+OyBUZWp1biBIZW8gPHRqQGtlcm5lbC5vcmc+OyBMYWkgSmlh
bmdzaGFuDQo+IDxqaWFuZ3NoYW5sYWlAZ21haWwuY29tPjsgQWxsaXNvbiBIZW5kZXJzb24gPGFs
bGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+Ow0KPiBNYW5qdW5hdGggUGF0aWwgPG1hbmp1bmF0
aC5iLnBhdGlsQG9yYWNsZS5jb20+OyBNYXJrIFpoYW5nDQo+IDxtYXJremhhbmdAbnZpZGlhLmNv
bT47IEjDpWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+OyBDaHVjaw0KPiBMZXZl
ciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT47IFNoaXJheiBTYWxlZW0gPHNoaXJhei5zYWxlZW1A
aW50ZWwuY29tPjsNCj4gWWFuZyBMaSA8eWFuZy5sZWVAbGludXguYWxpYmFiYS5jb20+DQo+IFN1
YmplY3Q6IFtQQVRDSCB2MyA0LzZdIFJETUEvY206IEJydXRlIGZvcmNlIEdGUF9OT0lPDQo+IA0K
PiBJbiBpYl9jbV9pbml0KCksIHdlIGNhbGwgbWVtYWxsb2Nfbm9pb197c2F2ZSxyZXN0b3JlfSBp
biBhIHBhcmVudGhldGljIGZhc2hpb24NCj4gd2hlbiBlbmFibGVkIGJ5IHRoZSBtb2R1bGUgcGFy
YW1ldGVyIGZvcmNlX25vaW8uDQo+IA0KPiBUaGlzIGluIG9yZGVyIHRvIGNvbmRpdGlvbmFsbHkg
ZW5hYmxlIGliX2NtIHRvIHdvcmsgYWxpZ25lZCB3aXRoIGJsb2NrIEkvTyBkZXZpY2VzLg0KPiBB
bnkgd29yayBxdWV1ZWQgbGF0ZXIgb24gd29yay1xdWV1ZXMgY3JlYXRlZCBkdXJpbmcgbW9kdWxl
IGluaXRpYWxpemF0aW9uIHdpbGwNCj4gaW5oZXJpdCB0aGUgUEZfTUVNQUxMT0Nfe05PSU8sTk9G
U30gZmxhZyhzKSwgZHVlIHRvIGNvbW1pdCAoIndvcmtxdWV1ZToNCj4gSW5oZXJpdCBOT0lPIGFu
ZCBOT0ZTIGFsbG9jIGZsYWdzIikuDQo+IA0KPiBXZSBkbyB0aGlzIGluIG9yZGVyIHRvIGVuYWJs
ZSBVTFBzIHVzaW5nIHRoZSBSRE1BIHN0YWNrIHRvIGJlIHVzZWQgYXMgYQ0KPiBuZXR3b3JrIGJs
b2NrIEkvTyBkZXZpY2UuIFRoaXMgdG8gc3VwcG9ydCBhIGZpbGVzeXN0ZW0gb24gdG9wIG9mIGEg
cmF3IGJsb2NrDQo+IGRldmljZSB3aGljaCB1c2VzIHNhaWQgVUxQKHMpIGFuZCB0aGUgUkRNQSBz
dGFjayBhcyB0aGUgbmV0d29yayB0cmFuc3BvcnQNCj4gbGF5ZXIuDQo+IA0KPiBVbmRlciBpbnRl
bnNlIG1lbW9yeSBwcmVzc3VyZSwgd2UgZ2V0IG1lbW9yeSByZWNsYWltcy4gQXNzdW1lIHRoZSBm
aWxlc3lzdGVtDQo+IHJlY2xhaW1zIG1lbW9yeSwgZ29lcyB0byB0aGUgcmF3IGJsb2NrIGRldmlj
ZSwgd2hpY2ggY2FsbHMgaW50byB0aGUgVUxQIGluDQo+IHF1ZXN0aW9uLCB3aGljaCBjYWxscyB0
aGUgUkRNQSBzdGFjay4gTm93LCBpZiByZWd1bGFyIEdGUF9LRVJORUwgYWxsb2NhdGlvbnMNCj4g
aW4gVUxQIG9yIHRoZSBSRE1BIHN0YWNrIHJlcXVpcmUgcmVjbGFpbXMgdG8gYmUgZnVsZmlsbGVk
LCB3ZSBlbmQgdXAgaW4gYSBjaXJjdWxhcg0KPiBkZXBlbmRlbmN5Lg0KPiANCj4gV2UgYnJlYWsg
dGhpcyBjaXJjdWxhciBkZXBlbmRlbmN5IGJ5Og0KPiANCj4gMS4gRm9yY2UgYWxsIGFsbG9jYXRp
b25zIGluIHRoZSBVTFAgYW5kIHRoZSByZWxldmFudCBSRE1BIHN0YWNrIHRvIHVzZQ0KPiAgICBH
RlBfTk9JTywgYnkgbWVhbnMgb2YgYSBwYXJlbnRoZXRpYyB1c2Ugb2YNCj4gICAgbWVtYWxsb2Nf
bm9pb197c2F2ZSxyZXN0b3JlfSBvbiBhbGwgcmVsZXZhbnQgZW50cnkgcG9pbnRzLg0KPiANCj4g
Mi4gTWFrZSBzdXJlIHdvcmstcXVldWVzIGluaGVyaXRzIGN1cnJlbnQtPmZsYWdzDQo+ICAgIHdy
dC4gUEZfTUVNQUxMT0Nfe05PSU8sTk9GU30sIHN1Y2ggdGhhdCB3b3JrIGV4ZWN1dGVkIG9uIHRo
ZQ0KPiAgICB3b3JrLXF1ZXVlIGluaGVyaXRzIHRoZSBzYW1lIGZsYWcocykuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtLmMgfCAxNSArKysrKysrKysrKysrKy0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY20uYyBiL2RyaXZlcnMvaW5maW5p
YmFuZC9jb3JlL2NtLmMgaW5kZXgNCj4gMDdmYjhkM2MwMzdmMC4uNzY3ZWVjMzhlYjU3ZCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY20uYw0KPiArKysgYi9kcml2ZXJz
L2luZmluaWJhbmQvY29yZS9jbS5jDQo+IEBAIC0yMiw2ICsyMiw3IEBADQo+ICAjaW5jbHVkZSA8
bGludXgvd29ya3F1ZXVlLmg+DQo+ICAjaW5jbHVkZSA8bGludXgva2Rldl90Lmg+DQo+ICAjaW5j
bHVkZSA8bGludXgvZXRoZXJkZXZpY2UuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9zY2hlZC9tbS5o
Pg0KPiANCj4gICNpbmNsdWRlIDxyZG1hL2liX2NhY2hlLmg+DQo+ICAjaW5jbHVkZSA8cmRtYS9p
Yl9jbS5oPg0KPiBAQCAtMzUsNiArMzYsMTEgQEAgTU9EVUxFX0RFU0NSSVBUSU9OKCJJbmZpbmlC
YW5kIENNIik7DQo+IE1PRFVMRV9MSUNFTlNFKCJEdWFsIEJTRC9HUEwiKTsNCj4gDQo+ICAjZGVm
aW5lIENNX0RFU1RST1lfSURfV0FJVF9USU1FT1VUIDEwMDAwIC8qIG1zZWNzICovDQo+ICsNCj4g
K3N0YXRpYyBib29sIGNtX2ZvcmNlX25vaW87DQo+ICttb2R1bGVfcGFyYW1fbmFtZWQoZm9yY2Vf
bm9pbywgY21fZm9yY2Vfbm9pbywgYm9vbCwgMDQ0NCk7DQo+ICtNT0RVTEVfUEFSTV9ERVNDKGZv
cmNlX25vaW8sICJGb3JjZSB0aGUgdXNlIG9mIEdGUF9OT0lPIChZL04pIik7DQo+ICsNCj4gIHN0
YXRpYyBjb25zdCBjaGFyICogY29uc3QgaWJjbV9yZWpfcmVhc29uX3N0cnNbXSA9IHsNCj4gIAlb
SUJfQ01fUkVKX05PX1FQXQkJCT0gIm5vIFFQIiwNCj4gIAlbSUJfQ01fUkVKX05PX0VFQ10JCQk9
ICJubyBFRUMiLA0KPiBAQCAtNDUwNCw2ICs0NTEwLDEwIEBAIHN0YXRpYyB2b2lkIGNtX3JlbW92
ZV9vbmUoc3RydWN0IGliX2RldmljZQ0KPiAqaWJfZGV2aWNlLCB2b2lkICpjbGllbnRfZGF0YSkg
IHN0YXRpYyBpbnQgX19pbml0IGliX2NtX2luaXQodm9pZCkgIHsNCj4gIAlpbnQgcmV0Ow0KPiAr
CXVuc2lnbmVkIGludCBub2lvX2ZsYWdzOw0KDQptaW5vcjogcGxlYXNlIGZvbGxvdyByZXZlcnNl
IHhtYXMgdHJlZSBvcmRlcg0KDQo+ICsNCj4gKwlpZiAoY21fZm9yY2Vfbm9pbykNCj4gKwkJbm9p
b19mbGFncyA9IG1lbWFsbG9jX25vaW9fc2F2ZSgpOw0KPiANCj4gIAlJTklUX0xJU1RfSEVBRCgm
Y20uZGV2aWNlX2xpc3QpOw0KPiAgCXJ3bG9ja19pbml0KCZjbS5kZXZpY2VfbG9jayk7DQo+IEBA
IC00NTI3LDEwICs0NTM3LDEzIEBAIHN0YXRpYyBpbnQgX19pbml0IGliX2NtX2luaXQodm9pZCkN
Cj4gIAlpZiAocmV0KQ0KPiAgCQlnb3RvIGVycm9yMzsNCj4gDQo+IC0JcmV0dXJuIDA7DQo+ICsJ
Z290byBlcnJvcjI7DQo+ICBlcnJvcjM6DQo+ICAJZGVzdHJveV93b3JrcXVldWUoY20ud3EpOw0K
PiAgZXJyb3IyOg0KPiArCWlmIChjbV9mb3JjZV9ub2lvKQ0KPiArCQltZW1hbGxvY19ub2lvX3Jl
c3RvcmUobm9pb19mbGFncyk7DQo+ICsNCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiANCj4gLS0N
Cj4gMi4zMS4xDQo+IA0KDQo=

