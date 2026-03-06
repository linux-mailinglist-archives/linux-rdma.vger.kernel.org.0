Return-Path: <linux-rdma+bounces-17608-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEw3JQTkqmkwYAEAu9opvQ
	(envelope-from <linux-rdma+bounces-17608-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 15:26:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33612222A19
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 15:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48C1E3158E98
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 14:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1876A292B44;
	Fri,  6 Mar 2026 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dxsBNn0S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zRA+e+ER"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726A437B41F;
	Fri,  6 Mar 2026 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772806767; cv=fail; b=huHPxDt44YfqG+maFvakqygvxd878BU7D0QsLLTiQuVYptXrmRBeE7q4AL6kvTeo880wVVO4S8sC28ZeHmDlCMDZeoEhnkBsKXqoV6j6FzFKKz6yve+Z5zKKDEAl4rijS9ia1UfxhPVbMi9q9hbtBvBMuuFPbBgXVQPeITEQJ88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772806767; c=relaxed/simple;
	bh=/X9iVNidqjmnawr70JEcHuQXozYZ6m+Iw+QnUTQOX7I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zb/euHoFMKQnfu2lVOke0e/ZEadrFV5p+Scc10cIreT3f9WLPiH1L7ZNjfdqGMnsE6BZg6VortCzRjHYrE8nuAZwzt9uXY9CRLbU2Nt7GIWjN8hQ+i3vi0ZjhQxXg7C1lnZhM3D7oGg/dknbyBIOZud2P67zOsnYNmcbA4r3DAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dxsBNn0S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zRA+e+ER; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626EH20u3541305;
	Fri, 6 Mar 2026 14:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PfmqMk2iNCKV3AHHdYKU/yMMqMbmmPmbDcwiGiqHRIc=; b=
	dxsBNn0SyiEKS5jVrW6PE53YGqEXRNSKxlL1HCka21RnH0wfpDLkSYaWJl7DGps8
	+gBiCj64P6eN3xB7PRCpSuTuFrG7BMUhDOBq/uX/Bsc2aWeH1YDIKokwOdSWJ/j5
	YISBp/2t1YQ4+7yG6SuCswZYM00gZ/SqPNhq28Y3g9WEYR0zzR+DgsxO2JyLgbPR
	zf1fbvwnftIFfuyVneXe6re8yFEq60B/RtpsKcN2K/AC3Ff1tfjI6nXZthnmEoVq
	Cw759lcQf0d/rrRcJMRlNHIoeceb+J53DISsuSBVdfYxL47fL/w39QClMt3zUv9n
	LTXiXf3tq4PKAIgpq1jRPA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cr0j20058-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 14:19:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 626CbDir029873;
	Fri, 6 Mar 2026 14:19:13 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptep1my-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 14:19:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwHPzCn3OER8BbFAWwPYsytwxUS5RqaY+ljsnKty59KIWqw09ya74Oybt2BJ+2yOFZcPGfUGDXbqsFH79xNaJDzeAnsIq/yvoS9DX80hM6AkssI5kyGss0+rM9vKBCg3us+3PG2iHwR+vDicI5ePafmfaPTucD/Y+bKzhSKnsjyzAscd/WHzjB+XVjsWyEOh4opdYLcgAWbxtzWA8rcudw+UMI515UlQqHBWvQKKnO9YkOVO22jzlBFwOuUsP/ZAmlkf85lPJpGEGQI58R+/1g5iAf+4vtOClmWkzzgKpLIkShpK12X66oUWXCXQyyYaz1huz5QYtKu51Rvke+thxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfmqMk2iNCKV3AHHdYKU/yMMqMbmmPmbDcwiGiqHRIc=;
 b=uqstSzr1s+NT0AL4P0FPrry/GgYuZnBkT5eHKlL0rs6tic85PJaciiDc/DW4Tfr+ssjdkJ0GrM2onycfPrrNXpW0GLNXUr9K+Wem+2H/oMJAC3gRzzB5EmSld4ZTRf0KdO0NM0vFkusoZdHNnQ9Clb/J3PpJYZPxmWHk/Nj5PrqFD6eAAFPj6Btl9h15RPe1tct66iGbxJ11VnUifOmWsXcDZf9TCNrzm42+qMbMuwm0KYcW5ICUtBzX75vKCkFlVMHMARTPuskxJbnXTBjjnomDR5GtxJlMx7RJHHn8vKG/6PlLQl30SMO1JWlDuxbw/8dwrXceU2B9L+2EKmdPNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfmqMk2iNCKV3AHHdYKU/yMMqMbmmPmbDcwiGiqHRIc=;
 b=zRA+e+ERUXHOxEriXohlvHqQmaRJ4Hikr+6hGcGOxSt8agiwktbrd8ppwRO1YNibNOcS8Q8lGs9hiHShqF+bg4t4dfiNXq3//IIzZcdPAbh0GwrnVxmt4kSxAQd9OIHRAjOYvbyoEw6lC0YPdWUyrVyeW61+61ounzkEk1PHoUQ=
Received: from CH3PR10MB7704.namprd10.prod.outlook.com (2603:10b6:610:1a9::8)
 by CH3PR10MB7762.namprd10.prod.outlook.com (2603:10b6:610:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 14:19:09 +0000
Received: from CH3PR10MB7704.namprd10.prod.outlook.com
 ([fe80::2a5a:b9d9:26b5:25e2]) by CH3PR10MB7704.namprd10.prod.outlook.com
 ([fe80::2a5a:b9d9:26b5:25e2%6]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 14:19:09 +0000
From: Praveen Kannoju <praveen.kannoju@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "saeedm@nvidia.com" <saeedm@nvidia.com>,
        "leon@kernel.org"
	<leon@kernel.org>,
        "tariqt@nvidia.com" <tariqt@nvidia.com>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rama
 Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Manjunath Patil
	<manjunath.b.patil@oracle.com>,
        Anand Khoje <anand.a.khoje@oracle.com>
Subject: RE: [PATCH] net/mlx5: poll mlx5 eq during irq migration
Thread-Topic: [PATCH] net/mlx5: poll mlx5 eq during irq migration
Thread-Index: AQHcq/Jc3KuDnivfpU60Ol++d2Bny7WezmGAgAFbMpCAAH/ngIAA5tgw
Date: Fri, 6 Mar 2026 14:19:09 +0000
Message-ID:
 <CH3PR10MB7704ABC8F3909C60FFDFB1188C7AA@CH3PR10MB7704.namprd10.prod.outlook.com>
References: <20260304161704.910564-1-praveen.kannoju@oracle.com>
 <20260304201151.GI964116@ziepe.ca>
 <CH3PR10MB7704DD1E6B9A671796FC6B528C7DA@CH3PR10MB7704.namprd10.prod.outlook.com>
 <20260306003217.GB1687929@ziepe.ca>
In-Reply-To: <20260306003217.GB1687929@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Enabled=True;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SetDate=2026-03-06T14:18:30.0000000Z;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Name=Restricted-Including
 External
 Recipients;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_ContentBits=3;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR10MB7704:EE_|CH3PR10MB7762:EE_
x-ms-office365-filtering-correlation-id: fe563481-eee8-4fd0-ad38-08de7b8b5524
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021;
x-microsoft-antispam-message-info:
 btF0ZqtbJ/5hB3e5fgkhvjS/MqGGUukcyc0gUNKWI48Eco9LHKo9yyy+mt5vAij+TdhbKcGIJg3ljLJUOS4LQYuP6rqQx2nHXpp5RP57icJhwujso0PXVZ1PQ/DcTHB25/fWgOBH9rtT10Y4uU/GOONUHMEdHynujXWAioeEPHHWmg0yLKMV4FekcgGU4vTVP8JJoBPOF8sGYiYp839XA9eEiYZ9Pqn+MUahyfR2AiD5cgIRcnNULVbOF59fgaZPqvBm+k0XVEmbXWxaGorjKi/EenjUYIj4iUgOyWCHQsHazNMUp81J0qeHquCYsotl5uCmbf+qdag96pjfHiewDX7rDsJadECTn3qIjTqBzzb+Ft4HpOakJF91XvChKSmq9++mb/iIjLib/Nk++IVJfbTiTgEgK9KGMWGatH5mivR0VWmC6P8munqRSug7oKQdoT08RHxIZmNsakiyFvqFlnoViLOdQ8qT7CRV8JkcY5oMKE60oJ3nFnd4UUfGebcLuwRttnhXtKi/wDPi+2lC3QI52YqX9tdrCvPROqXBelL2EqB1LgbPYDkOdtcxp9boTmHDAloLJwnYgwG6zndHCeveDIi5DF5B5DAec4DRJqv1NwWfa7L7rz+86vpDToywD9VR+mFM2w8d4oa3wvjbHtdRrekqMTy7Dcndheqp80u9H8NDBXddhqMbU1e9Vq2xbQPxVePleYQnoCbYmpE0AsclSTjbjzYoErCHD0oVkgK0oUCjmlOqOdjM8FosQtlwLWfRYbo+DrCGGNQJs6QMqVBLP2vKFKz+/uhejKFYnj0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7704.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?Rng5Q2NsWEtHQzFLQWIxT0dpNmFDVlgxTmhORS83SmhzZWNia1JwQklqa25R?=
 =?utf-7?B?cistcmZZWTE1cXp5a0JJM0d3VUNyeHcybklabmI4Y3Q2ZVNBVGl5MVN3eFZu?=
 =?utf-7?B?UjZPT0p0ZnIzWEM4T0doY29VNkZock81WXh0aXRKM0RsZkY0RFdkdU1WeGtS?=
 =?utf-7?B?S21QKy1OcnlySzVOWDZTWWpXRCstOVNRbkNyM3oveEF5T2pYTWFmaVlWWkI5?=
 =?utf-7?B?ak04QVJVczdTVU5kcEVlc3l0LzRZcnYvTDFPZmNXRSstNGw2V09YQmphNUM2?=
 =?utf-7?B?VWdpRHBuQ3NYZ3dtcklnRWRWT2liR3R0M0JqU016WGgzaVBRUVY0dWRvL0gz?=
 =?utf-7?B?d1N2NDErLTR3Uk96Mkk2SE1FSWlMWWFUd1k2emFWaXFYNnlpTi9UKy1wN1dL?=
 =?utf-7?B?YnE2SWNaUG9wZzBsdVowbThBWlFPWEdOWXdGd05MSlc3RXY3bzY2eEt5QVRL?=
 =?utf-7?B?ZGFVZCstMGI1VFNWcGJUYTl4Y0FVL2lzQ1ZyZkdvZ0NyNFpQeEFic1BtbTRH?=
 =?utf-7?B?UXo1OEZ0Ky14Ky05WklvNVBuNkg5WUpkdWR0QTZ2azR6cDVsQTZlVC9BOGRq?=
 =?utf-7?B?eXAwaVdYdnRZQ2RtM3NtS2ttSXR2WENURjExNHZNUG0zQm5RZHdtKy1BVlpz?=
 =?utf-7?B?c0dIN0lHc25DSklVVjlrbnFicjJRSDNlWWxla055aE9KTEZnKy1ydHV5a1dN?=
 =?utf-7?B?YmRNaGIwR2h6UHZCVWhSUm5vTkN1UmtEeEZOa1UxdThvSGE0Y1hvVmpES2Nz?=
 =?utf-7?B?cTloWXdpQystaUJPTEtSTUgxbUU1MTQ1OFg0cSstQ2V4b3k0a3ZQZGtOTUox?=
 =?utf-7?B?UG9ZU2taWVdRTVpaWUhiUDNXKy1Fb1dNeUE0dWZBTmU2eTlZSVB4bHorLW12?=
 =?utf-7?B?QmtoTG9tUVdFRGF5RDFSWVhIY2FoM1RrdU12Y2xlN29HenNJYjFQaEQ2dkdy?=
 =?utf-7?B?YW1oZHpXOWNaa3JqOU5qZC9HWlJVZnlUU09MTm5Xd3lCbjJvUWozTGg4OGNo?=
 =?utf-7?B?dDJsdEs3WjExTjl1cFl0ZjVFSkM1c2xiZzVoa0c4NUpMN2Z6aSsteVpVVzFE?=
 =?utf-7?B?VXJuSGN3MGhOU2UxVUFvUkZwdEplR0lIWk54YnRROVlrWGtjQkhEMUN4OGQ=?=
 =?utf-7?B?Ky00Uy9FTXJVcistbVNSb1lyV0VRWFVidystejk2UjFuUzMvNWxIeFYwZEt5?=
 =?utf-7?B?ZHR6blFKbGpoN2M1TGpCNFlUZlRkNlhGRng2RWcxdmZURC9BalJMRmloSDlI?=
 =?utf-7?B?ME9OTFdTQlRhRjdYcU9MdFA5TjJyeVorLVBpaXVvSmh4WjByRzVPcE9ZdXdV?=
 =?utf-7?B?RnNBUDkwZVBzeHV6d2VLczJFOG91MXdnY2tCT29LeURpZmZ0Y3F5Mm9YSHlP?=
 =?utf-7?B?ekxINDR0cTBHa2gzTDhVbnp2aW4vSWFSNmRvU3V0MWtBbFcwYXdyb2tWTzlT?=
 =?utf-7?B?dnplMm9GNE5SN3Mvb1JIOVlPcGpicU0rLWVJU0UwN0MwdkdDb3B3VDVCWkFE?=
 =?utf-7?B?ZW9BemZQN0d1NGtoYW1rRThrUFllNVpVRkpBdlpaRGpvQlN0OWUwVk82Q1lM?=
 =?utf-7?B?UWpHNmtkeXc3a3JOUzFrUkRidE84enJlaDc3UGdkRGZpZEhadWRUWkFzanAx?=
 =?utf-7?B?V0VtZ2p4R2RpUVZDSDRGUVVSMTliS0tnS0dRbDg5MEdBWFZyeVY4WjNhbkla?=
 =?utf-7?B?VXJYRTZPKy04bjB1bnBRay9BTVp3a0hUenhOSS93NFpZU1dsS0pCTnJHVWlY?=
 =?utf-7?B?OHZrQ1dqd3M2bWZCKy12emoxSlg3ZVRXYXBmZ3ZLVXRZa1dUTmk5OU9UQW9j?=
 =?utf-7?B?VFZQKy1ETU1BUHJHdXVqOFJhQjZOOWRUUkQvSzBxUDBMZmFwUFRSRUJVN0Ft?=
 =?utf-7?B?NnVuY1VUOTVtd3VINzEycDZrSTVoKy1SZUozKy14VDJLR2RRMEJvd1lGL0ls?=
 =?utf-7?B?Wk53TXIrLURLV3p0alBPaDNOcW56b2RCcW5XeHZzMSstWndZdHExT3h1UTAx?=
 =?utf-7?B?YmxEN1NIVTFxZDFSVVJUdXpJcHB3UTh2eEc5b2M5eWREUE5MSVpqYksxQVZ5?=
 =?utf-7?B?MEhXbS85WG5rQnlKMVkwSDBwMzFLNTZvRXFHVXN5bVlRRGplV0dvYXlkWmY=?=
 =?utf-7?B?Ky1sV3BhZWE2a0V5QTdpUk5TOEV2dGx5SndWZHNCeUZGVExYRTg3T3VPQnhO?=
 =?utf-7?B?a2hJaHU5bHIzOXdmNVdkZEJodTc1NlhVT2RXYkZWZDZ0aHFjeWlqVlRsOE9l?=
 =?utf-7?B?WVpSYlVyNFhuQS9BeDlOVkJSVDdYOWtTTkwwUS9ZUG9rR29OTXVnbnVPTmhY?=
 =?utf-7?B?NDcwYTBCeC9uTGM4bXhMN1FvZnVaU3RmVlJjZ1NDVlVEbmdFdGwvSC9uWkhQ?=
 =?utf-7?B?aGRldEdBNm9RNE5DbVU3OVgrLUxOUTFxY3NRK0FEMEFQUS0=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	vybgKAtKfEqGW7m3Yut1NQeUwuPGI7J6Wscn9z3oWE4Z34Vn16qb6CcTmFeQNh8V0TuWYxKEcFMNaf2eErBW3oDZKzsMdtNqw08GWZHDvRcqs10c5OvGxpbUkYFNP0f+WCkt6dhyRC0Tpu9cnuMvvwJYhLPBZlDBrg30TNpvo8F7hMN3FRXaSo7DXDJDwETBlcjEyuncSRyz0A6iTEKxcLhZIUGCNmEyGVCP5qm63Q/HyqtIE5qO+jOubWtwpSwSvLBqm5CTtttKM1seX2l5k4FjLOJUOuzMGmF1uwo0w5rH4Bb9/m+BbCryx5aAJk+hdOFIHhXdJlaBSdeLtNNAUw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1B/UnHkDr8GXqRN9v5VnKeeTQOjnBzm8m94p/iQW/eomu/t2s3YBQnHXGYgd02Z+/1cUoBGHJzTmsZme3TKgZaHdpEq1RIFLXm88NXdr5UW41OxVNcGqlWY+JeDXl6xykjb6jTKxePGWbVFKIwiCsXCL2B/d5ijdbXW4/pb9dP8nYvoj5fKCN4ns+qi4dalV4yybVb0DkwYP2fV4Ozzcme28DzaBeNJb+8v+QuEEJv3hYX9znqdSOJFUNeVXbQetJ5yo8jILJJEh44TQ2k2J4GLVbvDa1Lcso1+gcPGIfLRAfhHVIw0g2VtfoXLyDPS2WDMxEyQOYex5KdPwjEe4QUewtdLMsUp7+E/CTtk1v3tch/G6/8YtZY/iT7z1ijcbGe3IwMyPTuMoUlvIa+T1YQ6fW6m/ljh1VPfOSmGI7/Aq4X3EcS9lDmYqr41cNY+ck4FonkVCEFkwDz0B6+kZMV0y87b9PyFTnpRroKqMVmG8Vr6R8kZGiDvxg+FrbE4r69t01kSyB33oGr8xIEYgomplU+x7iTbqgLdYcfjV7Kt3vhD3k/mtgJIkXc4m8vCMIYw3iHKqNq48p9g4MiGDUMuHGKlpFB1xpSM4L1yon1U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7704.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe563481-eee8-4fd0-ad38-08de7b8b5524
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 14:19:09.2293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rmh6e3nBIEU4HCJCyPDDB1+WnNIG72ZU5X6xKHS0hUA0LjejsdN4Y7+3AwMnELqc4IpOKacKIGzwkq9YQtMOmjbZigrecPch/4t2EcvejOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603060137
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEzNyBTYWx0ZWRfXzjP+KowZmnb0
 wnH3CgvQCmG4/yZaOvIU6MuW91T9aOR6i0ltU3W5UYcck+uQ5aXVIGN/qVn+crGq52jJJlpOvMJ
 gyy6MjeXFHDNauQL+yJvn0IWqrWO6eNxnuoidrKnYCZdhMdxXVRq/y+kwJtm1hrc7WyXRutU4aV
 nb0EDK5x+lojaiXVeB508HNBQzH26RPE/Gz+LKs91XAWbFmkJEZ4HFVY2K9qhoWu5hwtIaYFiZc
 48M3+kdClS0KqczShUgoIKalpTvsL2dtXSZSRA/4ywWKnb3R9wAESksLxmh62pF97VFEs4gkAak
 UxdOXdHQwKok1yppL6fYfY4z8iolGDijgmbkZRG+5dA3a72UbZ4o6roXOjO7xgw3S+LWqx1/DMC
 v4IeZyfsIxw3XHNcgWeFD549nm3P8lAAa/TVE5v+qJNLD7skoLfEqCQt2qE/2xPh+2Igti64oK8
 93oKKEeyeGUYje19I3A==
X-Proofpoint-GUID: VFehRoe3tPR9xg_rJRdmXXB3hHRxKbA6
X-Proofpoint-ORIG-GUID: VFehRoe3tPR9xg_rJRdmXXB3hHRxKbA6
X-Authority-Analysis: v=2.4 cv=d6z4CBjE c=1 sm=1 tr=0 ts=69aae262 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10 a=YU3QZWNX-B8A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=9jRdOu3wAAAA:8 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8
 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8
 a=Fofg-9D3AAAA:8 a=mQvHCebiAAAA:8 a=BXszkKfDAAAA:8 a=c1PdSmG1AAAA:8
 a=hggDf0hBAAAA:8 a=NSIbRwiEAAAA:8 a=XlRjxQ70AAAA:8 a=csrFLi7Q1mWWhbfsAisA:9
 a=avxi3fN6y70A:10 a=ZE6KLimJVUuLrTuGpvhn:22 a=y1Q9-5lHfBjTkpIzbSAN:22
 a=Xbaoi9ZUBzzYp91LqZJF:22 a=wsrb8zZI_WQ3QAEBCXTy:22 a=duu7wrcty9prphiCz_fF:22
 a=4iM0TfZbaBQr0p37pvCp:22 a=7ilw6d6txcz0Yr6I31bG:22 a=ijqVwrIbDdJfMQQjsWiJ:22
 a=1uMOUU2w0DxzEe95gQqD:22
X-Rspamd-Queue-Id: 33612222A19
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17608-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action


Confidential - Oracle Restricted +AFw-Including External Recipients



Confidential - Oracle Restricted +AFw-Including External Recipients
+AD4- -----Original Message-----
+AD4- From: Jason Gunthorpe +ADw-jgg+AEA-ziepe.ca+AD4-
+AD4- Sent: Friday, March 6, 2026 6:02 AM
+AD4- To: Praveen Kannoju +ADw-praveen.kannoju+AEA-oracle.com+AD4-
+AD4- Cc: saeedm+AEA-nvidia.com+ADs- leon+AEA-kernel.org+ADs- tariqt+AEA-nv=
idia.com+ADs-
+AD4- mbloch+AEA-nvidia.com+ADs- andrew+-netdev+AEA-lunn.ch+ADs- davem+AEA-=
davemloft.net+ADs-
+AD4- edumazet+AEA-google.com+ADs- kuba+AEA-kernel.org+ADs- pabeni+AEA-redh=
at.com+ADs-
+AD4- netdev+AEA-vger.kernel.org+ADs- linux-rdma+AEA-vger.kernel.org+ADs- l=
inux-
+AD4- kernel+AEA-vger.kernel.org+ADs- Rama Nichanamatlu
+AD4- +ADw-rama.nichanamatlu+AEA-oracle.com+AD4AOw- Manjunath Patil
+AD4- +ADw-manjunath.b.patil+AEA-oracle.com+AD4AOw- Anand Khoje +ADw-anand.=
a.khoje+AEA-oracle.com+AD4-
+AD4- Subject: Re: +AFs-PATCH+AF0- net/mlx5: poll mlx5 eq during irq migrat=
ion
+AD4-
+AD4- On Thu, Mar 05, 2026 at 05:08:52PM +-0000, Praveen Kannoju wrote:
+AD4-
+AD4- +AD4-    Regardless of the underlying causes, which may include IRQ l=
oss
+AD4- +AD4-    or EQ re-arming failure, the TX queue becomes stuck, and the
+AD4- +AD4-    timeout handler is only triggered once the queue is declared
+AD4- +AD4-    full. In scenarios where only specialized packets, such as
+AD4- +AD4-    heartbeat packets, are sent through the queue, it takes
+AD4- +AD4-    significantly longer for the queue to fill and be identified=
 as
+AD4- +AD4-    stuck. A proven solution for this issue is polling the EQ
+AD4- +AD4-    immediately after the corresponding IRQ migration, which all=
ows
+AD4- +AD4-    for earlier recovery and prevents the transmission queue fro=
m
+AD4- +AD4-    becoming stuck.
+AD4-
+AD4- I undersand all of this, but for upstreaming we want the root cause, =
not
+AD4- bodges like this.
+AD4-
+AD4- There is no reason to do what this patch does, the IRQ system is not =
supposed
+AD4- to loose interrupts on migration, if that is happening on your system=
s it is a
+AD4- serious bug that must be root caused.

Thank you, Jason.
We'll evaluate more on it.

+AD4-
+AD4- Jason

