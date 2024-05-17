Return-Path: <linux-rdma+bounces-2523-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DEB8C837C
	for <lists+linux-rdma@lfdr.de>; Fri, 17 May 2024 11:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2849D2819D7
	for <lists+linux-rdma@lfdr.de>; Fri, 17 May 2024 09:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3727028684;
	Fri, 17 May 2024 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AwEC5nDb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rGkgLjfZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A22A2263E;
	Fri, 17 May 2024 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715938149; cv=fail; b=d9u/YWrzJ+JufoS7V8sAl2mk96bJPqiYuMvA285dyVIZugVNR0h7sYOD73cGHg5cNsGHyf97rw77pvoga+N3wFx/n8wyv4FtfGoojyQpa2Rt/vwV4gCsbgkSH4rCJ1yMt0qQQjcodraT/PlI+26loqy42xgem+JWbXdEliH5F3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715938149; c=relaxed/simple;
	bh=ZxkZdkoVJ+vP2jf7UCma+JI3KNY/htQdtGXMTLlAfH8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f+hc0ijmjPkWAG0PA5SB4kPz27ezUVPQ/V9WKqi9H78VzPKIL4gCyIws8Q/7zRVdJklRMB0leTIZOorIVpHeL10DxZhnQfRNNWNM+FN0Kb4IzDAtCC5IdLyetLayPvhXXw8n93XxZXY+7qRIMLWC4oQ3e8sIVD0FC+YiDwft6eE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AwEC5nDb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rGkgLjfZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44H8YYiA010158;
	Fri, 17 May 2024 09:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ZxkZdkoVJ+vP2jf7UCma+JI3KNY/htQdtGXMTLlAfH8=;
 b=AwEC5nDb5u3mx8CX3B5vpBCTcCKQRo0TJWrD4g3CzEm/X0uPVn7ogEKuarVKGkSXj8yi
 ol7/pWWgvQnCW9dxpo46uDavipDn9jLWYJzDfP+Kxi3R8Thnz6vQ7u0Q7VfGRqJu7nBl
 4B4HS/6yy3PaGYpq8xZ+CGH45iFWQSPCigtuUH1XUjTfHUiGn4XAuq7jL+ty6iB6jKRD
 TkdkeXY9KbEne/tNJMei6bhyS8QGRGxAdOLX39vw7+ajLv6RZgKxkvbEptX9FWUK6ID5
 wlnalwedpOt9avi5g7d/9Uv0MdAWPdHAF9cfvKo0IczY181pf/zqAFeZLeJb62HwD7hz cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3t4fhdt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 09:28:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44H7eA2O038367;
	Fri, 17 May 2024 09:28:47 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y24q14dm6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 09:28:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFMEJSMmdoKnkizQL/L3lz0GNhnCP1ICbeNFCZn5L65wp2kjPNOSsdXvEmmlThS4wJ6AS4ecRmzE6jPIaVvykM31EjM6M2mEfxDcYaCkshsv6Wtf4C3OcsQWvNpDiTucAxzUeW9BNFaArypBPPIFOWtNkDq6pQIM1lFJpKQyg3YCS3VjTDnEwg7GHGfCkJqluOAwOI5+bFjZTZvNKeJkI1RwuJA23yuvc/terRVhAsNuWkpHRXyJ41vpn7mmVv70eR5dmvqx5YF8ItkOW5j5G6Rg6qgQ2+1gcuT2wE26oaMzNxEXwZGWclHdoEb7HzR9D+TAU2cvmgnPSlYVPDE1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxkZdkoVJ+vP2jf7UCma+JI3KNY/htQdtGXMTLlAfH8=;
 b=amBWHf8qCCOQn22rLtxT/jSpXg7TuTJphfO+MDvPPdO+aD8fRYpSklOxldh+mGLleuTGpvibo/cZKc3NzEkn31KRleWH79BrYxsMu7x3lDbQNSfqo+zezVJ7m3oElpEz+2NG7Wl6soo2aimr281XYfmsamH0idlxkwo+qCOUCSC1tMowhb2NSiCjB1WwzxV+NEkbMOLyOsm2RPXRCjK/fnW4AFxc4PKo8R2PGvgu7RwY+8/rp/L3V+YCK7LBJX5HwhWi/GKOfFlA9Tlpu8lR9qFjQUpiJk1AtRLfGcf5Ek5lFPIHG0CQLOeyIjrAo0qnigumQtJ4YGncJq40B/dVxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxkZdkoVJ+vP2jf7UCma+JI3KNY/htQdtGXMTLlAfH8=;
 b=rGkgLjfZtlXwPvPegqyexyGoB6KE1ArOZ8F0VzcnWf38q6AtnIARP7Diixj9Na5IFXUOqxlUbYflO4P+5mlhZOCOOfZQx0KfnjCiqbxbnrBdCKldlGb0+mLEb9kGZhi8WckYryfKrEzDk7USY1V+rCvU6QdLZcfTTdmGm9m4B7Q=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by DS0PR10MB7066.namprd10.prod.outlook.com (2603:10b6:8:140::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 09:28:44 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::8518:ea67:dd0e:9836]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::8518:ea67:dd0e:9836%3]) with mapi id 15.20.7544.052; Fri, 17 May 2024
 09:28:44 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Greg Sword <gregsword0@gmail.com>
CC: Zhu Yanjun <zyjzyj2000@gmail.com>,
        OFED mailing list
	<linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan
	<jiangshanlai@gmail.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        Mark Zhang
	<markzhang@nvidia.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Shiraz
 Saleem <shiraz.saleem@intel.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH v2 3/6] RDMA/cma: Brute force GFP_NOIO
Thread-Topic: [PATCH v2 3/6] RDMA/cma: Brute force GFP_NOIO
Thread-Index: AQHapsb3zA/Z31sN+0OQadFdGByD+7GZejWAgACJYYCAADd5AIAA8IsA
Date: Fri, 17 May 2024 09:28:44 +0000
Message-ID: <5AF30C96-0430-449C-9A97-F5D7EF7EC9EB@oracle.com>
References: <20240515125342.1069999-1-haakon.bugge@oracle.com>
 <20240515125342.1069999-4-haakon.bugge@oracle.com>
 <82bf9e5f-b798-4d29-8473-c074a34f15b0@linux.dev>
 <236B9732-8264-454C-94BF-7C9D491D3A37@oracle.com>
 <CAEz=Lcvbc3O+PtDSLvGAgd5fmps8j69DDn+Mgm8UWMFMNSd8WA@mail.gmail.com>
In-Reply-To: 
 <CAEz=Lcvbc3O+PtDSLvGAgd5fmps8j69DDn+Mgm8UWMFMNSd8WA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5593:EE_|DS0PR10MB7066:EE_
x-ms-office365-filtering-correlation-id: d57980e4-fc7c-4c64-2e5e-08dc7653bf20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UHRHNE4zNDJYekNwR3RaY210bXVWWjJRcTczbUtPWUdIV0ExTGFoZ0RGU1JW?=
 =?utf-8?B?dXZFRXZORXg1Vk1majlmWlhjOWtIdWNjK2Z3RzlKS1lucWpvcnFCd1oyOThj?=
 =?utf-8?B?Tm1sZHZzOHc5dzE1VTloOEJDVjg2UDhESW9PVXhKbmpOc2NVcVkrcEtJdjVW?=
 =?utf-8?B?dnowNWNyWlZkNHR0ZXhJdjJiQkhnWDlLSHYyZklNNk42MjB6aUU5Tnl6Z1Bx?=
 =?utf-8?B?OTBDRWJmVFFsL1d0NTNiMElKMTQ4Tk5TeElJTXV5UTkzZ2tPckRZRmoxditO?=
 =?utf-8?B?S20wZ1FEdDZOc08vaVJFTXdNTGJTOXpZR0pyNDk4YkdjTzAvU0k1bURRZ0k2?=
 =?utf-8?B?SEUrMEIwaEtRdUttbDczRHFPOXljakJKUm9henJJL3cyZDQ0NDVQU01meUd3?=
 =?utf-8?B?M2ZzN2xMaFRtZkRySkpTaEpyV3F5b25mcm1BdkJXM25FT0orZzVYWlE4d0hp?=
 =?utf-8?B?aDdQaFo1RVNVZ0hYNFRJMk8vTWlTRkoxT0NQWTcwMzRVOHZHNTFoaEJ5d25s?=
 =?utf-8?B?eFk5b05VSlpCb05JZE14TnBDUGpnUEtZVzdlby9haHlIbXVJNmNGeW50eGZG?=
 =?utf-8?B?djBYOWkxemQzUVFNeFVHOGVpbFk4NWh2ZW5ScDFNdFdEOFkxcW9lT0RlY09U?=
 =?utf-8?B?M2xoY1pOaFd5Zm9sRy9wK0FLblRRNnhTSTBpVEZBWnRKNlBHWDUrWmVZbnBi?=
 =?utf-8?B?SEVRZ3pQcEZHSkVhNHZXYi85UFkzdGxFY093SmFDMDVjTVdaZGc2dktQMVRo?=
 =?utf-8?B?K3p6N0RLbDF5U3MybXRyR21DblNHL2QrZS9GUDNWOUZmb0lxWnNDOXBIR1Ju?=
 =?utf-8?B?SEF3bHl4Z2JDT05nMXUyZ3FnTG9memN5UXNTQUtGK1k3RkUxK2pJSlhiVCto?=
 =?utf-8?B?czVpN3MzemFXdlUvU2ZRL1lKV3l0RDlHWG5oYjE4SDRoMEhmVHA1YmZ2bmY3?=
 =?utf-8?B?ekdYa3hMTWlmRFJqa1plNDZzNDV1ZWpjMFRaSlZGSTIrRm1EYVFEMnl0REdF?=
 =?utf-8?B?SlFmRktDRC9sYVlwUGo0NmQzYjhESTNKUzJ0bmtlMlh6OU8vTU9lSHA2MjBM?=
 =?utf-8?B?RytPNFFLMFdFOU1na0dOMUVVeHloelRhSHZoaSttRVd1LzB3SjAzS3plUTJT?=
 =?utf-8?B?NUFKUEUxVmVBUVhIOVJKNmtjWWN3MHpBd3JqaldvSzh6dTZZdHdhUGtsRGhv?=
 =?utf-8?B?cFhoMzBJR3hrRyswMVVMNVAzTUV2dGcrcEsxNGljNXhqYllpVUxnWXo2eUJj?=
 =?utf-8?B?biszcUdUQ1ZzM01CdHJLWGZYMENiUlZpZW1FdUFwdHA1VzhmZmtnck5zS2ZO?=
 =?utf-8?B?MFZuc3J6d1lxbGl4MWxabFBRQ3p4K2ZTM2M2OFhmVmN6RVVhRkJ1QU1NOUc4?=
 =?utf-8?B?aW9nZDM4SG91UTJSZ3VPTWQ1a3B6T0pveVNkcS9ETjB0LzZ5cXN5WHJnaDBk?=
 =?utf-8?B?VXQ3QmpBNmlDczd1ZzVoaDQyZmtSVlNpTU9VNnpWNGY5dWdEb0ZtMi9xQ3NR?=
 =?utf-8?B?cXdUWG81anNEVFp4OUJ6cFZpZjRRbWJDdktQYktzK3ZaVm5vY3oxSUY3aGpp?=
 =?utf-8?B?bG1nS1pXQ1NKSDJWZDhaQXdQeEJRZVlVbWZibVk1bGRGdnRBUm5KZ3IzWkZE?=
 =?utf-8?B?NU5FNS9YajRFVHFrWFBiNEd0OEtKNXkyOUt3UExyVFVVcDd2RUVFMGZVbjZL?=
 =?utf-8?B?ei9DZERXMERiUWFVR0Y0MHZpZWhwYTJvdjExaFl1K04wdXBpREthUkJRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cGZhTHp2YVFGY2toSUdVQWc3aVVWY2RXMHZ1a2x0Y0R0ZTFOd0lxOHBlK2pF?=
 =?utf-8?B?SFRvT29zWEtMM1ZwR0hSZVdkb0YvNlJMSWxIMENGVjZYZWJIbGZZa0hZWUgr?=
 =?utf-8?B?Zkg4Ym9ZTXV1QkFPeHFscVhqL29xY1ZFNk9nM2ptSGNzK1JpcHlUM0h6Mmpr?=
 =?utf-8?B?WkRJeWFWd0J5Z256ZVJLYjJOT3hSNTRUZTBXa1JpbWxJUFNLbXlPdzFaOFNY?=
 =?utf-8?B?K0ZHanpCTGl1ek5GTWppdWpIWUVZczdpK3VZdy9ISHlPRGtCNlFZMlQ1OXUz?=
 =?utf-8?B?cnd2QStIQmwwbUpuWjVpN3ZxRkhmMC9HTzlOM0plZENqeEVPMzhQT2h5WllK?=
 =?utf-8?B?SVFjbHpMTkVlTmtmdTJhT09iWHdFQ2Ewdmc0VTd2QzZ4eUJRVFNHNFJCYjhL?=
 =?utf-8?B?OEtjL3lqbGs3OENZSXJVSG9MTTZIbFZDcElZbllpOGxFUE1TWUtjQ3RsZDY1?=
 =?utf-8?B?SWNQMFE1bndLQVN4ank5VHA0dktLenhySVJrUkUzdmYzNisxdVdMN2twL1BT?=
 =?utf-8?B?Ulh3blFCUnhNUXF1SHVRZmx6S0pGYmlVTDJ6WnBMZWwrY0w2eHQ1ZGF2NTI0?=
 =?utf-8?B?TnBBTm4zS3JZem5WY2ZQbkNlOG81OTk1ZWU1SjVWOUNHUjdRUzNjVzNDd05Y?=
 =?utf-8?B?aEFyd2E1djl0ZjlPTmNBNVk0a3hrOVp6L1NXQ0RYUlBzc3BtSDkyV0RzMTVF?=
 =?utf-8?B?UWZSUDIxc24zY2JMUllvR0pMbVFLYm5yN0hGcHdxSU5mSzRjMGYzRVl5VDZx?=
 =?utf-8?B?MHVWYUh4V0F4QnJ1SXA0MFR1V0ZQTWRrdlRFUldPZHVRNDVreVJyeEVvRy9v?=
 =?utf-8?B?T0J1M0NUNGJvTmRGT0RablYwcDV1UjBTNTdoYUVkRmY5b0QzQTNTZGsxeTFu?=
 =?utf-8?B?NVdxUU5STkZIRXJWdHJKdHZUbkdTK3VvZVNnV2dpazZSSG1Rdy82K0FCTDZa?=
 =?utf-8?B?NmN2dXlETFNjeExDU3NJVHdsbEdtcnZ1OFZESm1ESEJEVGhWOXY0aUh1TURX?=
 =?utf-8?B?Z2t0Zy91WmI5TGlJdFVtckdFT2dwRGRuTE9vRnV6OUNpUkd5Y2JmeHhHRnlv?=
 =?utf-8?B?NFVqUmhDQnB6cnZaeDBmMUJiLzBFbHRHTzBGZ0NkdzNIbUJqelp3ODl0Smx5?=
 =?utf-8?B?QVdQbUg3d2hnSzVkYk1GZU0va0ZTbnk1U3hlM2tEekUzTnZxNm9zT2xDYUxY?=
 =?utf-8?B?cHROd0tqdzJnMXZjU0YvdkVGMWlob3RoSGF0d3A3akR6b3daa0Vwc25wM2JU?=
 =?utf-8?B?V2w2bkpxdjJEK3M5aXEyc2p5KzdGTDhhZXgvbTczTW9jZXBlN2J3WWhqSGY1?=
 =?utf-8?B?dUlNZTBtd3Rwd2kwd1dkZVBzYmkrVkdnL0V3L2RES2tlV2lMUnNuYkRONW1p?=
 =?utf-8?B?azlQYlZnSzdUUC9FK3B0R1ozN3VrTC9WTUhNNGZxeFlhcHNjS0xpdWdiZWpu?=
 =?utf-8?B?RVFEL1hQRXFEa3hhaityVUxYTEtMVmREYVdicHM0d2JQaU9TKzIvRk5vTHNq?=
 =?utf-8?B?VzFoQmp0bFdxV2hJVStQOGlOS0lGWitDRzhBbkk3d3E4TmNUNTRwUDZORCtO?=
 =?utf-8?B?R3hZWTFCRW1VVFdaWngwei9yZVZ0MkdRYTJOL1hvVVN2NjZwc2hYWnNrVE5o?=
 =?utf-8?B?YitCTTZUUmNhbVA5TzV1UzhqdmhWQ090RUMxTDBoZDB6R3RRa2hrVFJmZmk5?=
 =?utf-8?B?aVI1WWtid3NPVU5ZeTZBdFRDQ0E4R3VOR21kQnlWM2xkOGZhdmFncGlrKzQx?=
 =?utf-8?B?My9UTGlaWXJPeU96NEx6Vy9sWDdTQ1FoR01OR3FiQmdPeHRiTG5KUU42bHlr?=
 =?utf-8?B?cHcrczJQRnAwREdwM2pKV3A0N05WNitxUm5SajZod1dIZ2cwWWZjMzFwNFpN?=
 =?utf-8?B?dW16U2xpK25mY1dwbExSbkV2aDZBRU1WcW55UmlReml5aUFoNy8wWGpmNGpt?=
 =?utf-8?B?SkYrQkJoOUlVMndBdGFwUHJpSytUQ29DZkpSMUVpNzNoUGhHTmFTc2ZMZXE1?=
 =?utf-8?B?czJNYzNpUTBVaFU0QUI3dWpmYzNsblZLQXBlWlVXeUFOYkFiRmZQeEpGODJh?=
 =?utf-8?B?VlUwN2dWRjhGeE1wVHpyRmx5TjdRWXFHbWg3WmdBanBra0tkU3ZlYTlDa0k5?=
 =?utf-8?B?VFVIT09zNVBpM2JpUzJucE5LSXJ5a3dIdmx2SGYyTDl3VkRiajJRQUUwL0tX?=
 =?utf-8?B?NHE4TkdwWWFwVnovVXJNVWFNdHhOTVBMbEVrRGxHQ09hUHhVc1FYTFIxckhv?=
 =?utf-8?B?eHZ3NDZwWXRCaEVUQWZsNFFBbC9nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99ECDDF62275E3499CD863CB5C0ABBB3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	k1t/BCUjBeH3TcBiEcP0Pj/bwasofeKwUSMtOPW6zJsJOIyoJ/rJBfFnpu3Gn0mpx3W+L2onG4q053tHlsXn7AEQV/YOOEBC+SOp+N7ZWTsrhzpVu26jMPsiptjG1eD6mIVv6fovfddxepOEcSSkNM5FamJttTWzOdBsm+RmtglmsxWm+oX6yWD5Ivx4DsxOYAsBclcVgMBHNQAodVpHtNAf9Xo4YQLyFJ5QI02FSLVvTxw7FUB2eFIeZkHlKvn1IQdR1KwYPnGqjocy11lS8BxtsnXKxuuDfT64SFCbMa4naFD0BMP7k4hvrhwbJYp0SKo2cesDrxwj8WPvs/0bQqhOnacXzkRpM58H6zbEJRWbioQONBaicsnWz5VePxPDouMzdMZiK4rlTlCmgt+Bht4iY2BUy1DqxmQ/iGs3DMnJ9ip9e0Sr1++S+k9SiVHV7dAmAitGSAEBRTf7InpauXs4E+JgsViwCmnV4Q8IIMMoJ5YWWNI7bXFrU0xP60zY4BaUzlVP8hbD/onbxsqYOAcSV3MEpqTffHyHuK4XUtFL79kI0aRawmewIlDZw/8/BK/pwwqF6c60MlSUyKjIyCoH/lsmlOLAaVzrardbNuM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d57980e4-fc7c-4c64-2e5e-08dc7653bf20
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 09:28:44.0307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MYj4C0t/tkuv/4Bjcm9am420SlRZy1HLK3ixwc7H0Q4aDlGtTSBj3O8TJ4URgb0LDOIveL3dIpgMxnfMg8tr9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7066
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_03,2024-05-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405170075
X-Proofpoint-ORIG-GUID: wEbnz2lxnEFKvUAHI0-3SvCpwE3pXiVZ
X-Proofpoint-GUID: wEbnz2lxnEFKvUAHI0-3SvCpwE3pXiVZ

DQoNCj4gT24gMTYgTWF5IDIwMjQsIGF0IDIxOjA3LCBHcmVnIFN3b3JkIDxncmVnc3dvcmQwQGdt
YWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIE1heSAxNiwgMjAyNCBhdCAxMTo1NOKAr1BN
IEhhYWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4gDQo+PiBI
aSBZYW5qdW4sDQo+PiANCj4+IA0KPj4+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZW50YXRpb24vcHJv
Y2Vzcy9tYWludGFpbmVyLW5ldGRldi5yc3Q/aD12Ni45I24zNzYNCj4+PiANCj4+PiAiDQo+Pj4g
TmV0ZGV2IGhhcyBhIGNvbnZlbnRpb24gZm9yIG9yZGVyaW5nIGxvY2FsIHZhcmlhYmxlcyBpbiBm
dW5jdGlvbnMuDQo+Pj4gT3JkZXIgdGhlIHZhcmlhYmxlIGRlY2xhcmF0aW9uIGxpbmVzIGxvbmdl
c3QgdG8gc2hvcnRlc3QsIGUuZy46Og0KPj4gDQo+PiAiSW5maW5pYmFuZCBzdWJzeXN0ZW0iICE9
IG5ldGRldiwgcmlnaHQ/DQo+IA0KPiBBbGwga2VybmVsIHN1YnN5c3RlbXMgc2hvdWxkIGZvbGxv
dyB0aGlzIHJ1bGUsIGluY2x1ZGluZyB0aGUgbmV0d29yaw0KPiBhbmQgcmRtYSBzdWJzeXN0ZW1z
DQoNCkkgYW0gbm90ZSBhd2FyZS4gV2hlcmUgaXMgdGhpcyBkb2N1bWVudGVkPw0KDQoNClRoeHMs
IEjDpWtvbg0KDQoNCg==

