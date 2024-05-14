Return-Path: <linux-rdma+bounces-2477-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD588C5739
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 15:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7DC284ED7
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 13:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F254D14431F;
	Tue, 14 May 2024 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jAwMfxNj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x86zFXEV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD3D55C36;
	Tue, 14 May 2024 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715693546; cv=fail; b=rPsdSzFChUJIHw/JaU0EhER2daJOVmo4boPPJ7RPVJoZePsGYjEDSSNjiU1tGl0KxfdzK2Xx11qZzZAOQj/ZEgg2OiDPbXIz90VzEuZ4pjO5T3eNNsCECXkvtzBIJD467l5n8Dg+1m9mH3LRRxyZTvctJzJVFx94+mrba85SLcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715693546; c=relaxed/simple;
	bh=WT9J/TjT0PpevRLkrAyF9H9+EoBOJ7dxZ3IVukkaVho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tjO2DlYiz323/sLB/ca/P7WohGTVql9jFUbh1n+ixF4JtM/5vqYQ069MGJK4XyVqszeHnX/mmFiTFDYnkzUgEH0RjB+8lceY6njN6y9cJ2P72fOSrLGWgxQif78mU/bS2s6ZbSDizyKgyPiEtem9+LGJS9nmf7xeYw/ZuSHUBiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jAwMfxNj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x86zFXEV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44ECgBLY008667;
	Tue, 14 May 2024 13:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=WT9J/TjT0PpevRLkrAyF9H9+EoBOJ7dxZ3IVukkaVho=;
 b=jAwMfxNj7R3al7oo6lEchAb10s+QG2W2W/CETaHG+ZpzM8KyayI6gXKbv/knTsq4aml/
 qEC/tHUM2EY/VSkSiin5a6p1edEOBrFQwCnSmvh1OiWYPPIX/JxAe26gQ8WeB2Ws1acM
 B6AcS3pqjDjdiECRcUZdXp8gxAqe9rkHJDPUD13jQvmd37sivBxpig2J01/gWu0h8JxJ
 NzfdNgPREujLnGMZF5FTKGs4E68Nd3jLoe7kcd8A1Zx6EI8HRv+Ebo8whTIOT+4lVw3b
 YOJOi+MIWKVoiAIXzs+POQOylE2WZH+kwDwrahztqXLYIpdq+ZQcTRz5bfjBu4wEMzbO eA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3tx8h9f4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 13:31:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44EDN65U005874;
	Tue, 14 May 2024 13:31:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y478bwu-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 13:31:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auJ4nh3VA1JhmBaFsJN2gOlbhYKoDgMsF3cjkbopcEAMhS9BzHJDyNtrz7fSdixjRXyrm6w0FQuCtT65tTrRABNOKCjJ7FRc3MWGuj5g5hr1OoF0jjmGpRcdTAy+A0ILvfH3FkuvLS7oRacFnjJziQAuHa6T0lWtyXZJjv3LYp14PlSEtUXE7GczTk3O1CZ7UuSTepSe8iz1zfc82cvktcrEIASHEXe7JMP4jkwZXQY0sP1pdVb13E7Er7Z9M+XZeMz9+bZMuIUpsxA9bcRBAkRPuUojmmqc8lMNFe/3zUvRrk1wpcgwLUtQdFx6RU3dFhcTS/Cok/zUewwPWF+WVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WT9J/TjT0PpevRLkrAyF9H9+EoBOJ7dxZ3IVukkaVho=;
 b=SueKPN0P9DxUNqOaqwUavsF7Pi5zvm+39RTu6OcsZwxkfhiKJw5eH4cXEjcyccdEgQUI2Jq3VjCBPMCx6ZokOc6jvO9lCpmHWbMJ2QZFivvH+h0q2r28zEGypFXBMwcPHkTvtRaWfz1/iEKho182HGilzbjT0J+UR/XxDcBVGv08hwixToMxLbNsFTy02lNRXbHZLsUWt358MT4MwYiZh8F6ujrhFhjQMrcwRtG8MgGOiYqx4wC17Kicp3MDjL/6f6+EHER0PyzJPv9Tfhc0ZKNxJH3lAn7hkY0HavCtjDNOVTMBee83Q4fTmWK/3Ja6vIZE9fWIpfCIrYBt90BuEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WT9J/TjT0PpevRLkrAyF9H9+EoBOJ7dxZ3IVukkaVho=;
 b=x86zFXEVQlr4ExoRCN6SFQ3hfotrIz3iU2t/ElIe9cT+A//vsM06ZmZNiS+61DEZnYFVutQPTTvcsjY/B9MDwOn2WrKl6S+pnqL+EVb4Jtam4nj0syyhM1HYaCzdjrCQmyfjsjkt9rWDU7JBdzGQW2b6MsXJ8RuQ4TAZ7VYXiQ8=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by PH0PR10MB4792.namprd10.prod.outlook.com (2603:10b6:510:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 13:31:43 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::8518:ea67:dd0e:9836]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::8518:ea67:dd0e:9836%3]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 13:31:43 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Simon Horman <horms@kernel.org>
CC: OFED mailing list <linux-rdma@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        Jason Gunthorpe
	<jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        "David S . Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Tejun Heo
	<tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Allison Henderson
	<allison.henderson@oracle.com>,
        Manjunath Patil
	<manjunath.b.patil@oracle.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Chuck
 Lever III <chuck.lever@oracle.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH 2/6] rds: Brute force GFP_NOIO
Thread-Topic: [PATCH 2/6] rds: Brute force GFP_NOIO
Thread-Index: AQHapTSuvih1311I2k2HMlXHLpFj1LGVeFsAgAFDTAA=
Date: Tue, 14 May 2024 13:31:43 +0000
Message-ID: <564056C5-59A6-4C32-80E1-1E5DB6275989@oracle.com>
References: <20240513125346.764076-1-haakon.bugge@oracle.com>
 <20240513125346.764076-3-haakon.bugge@oracle.com>
 <20240513181424.GU2787@kernel.org>
In-Reply-To: <20240513181424.GU2787@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5593:EE_|PH0PR10MB4792:EE_
x-ms-office365-filtering-correlation-id: 5ddb2968-62d1-4b75-94ce-08dc741a31bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|1800799015|7416005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UzExRkdlRk9zdHdwcG9Ua2VBVlZvS0ZnY3lXd212OVN6dDZmNWMwYmlKWVZi?=
 =?utf-8?B?cEtzNXRCZWo1di9QQUJHcUcrd3l6Tk12YU9qZmloZEF0a2xObmVEeTRDeTJG?=
 =?utf-8?B?R3g3SGN6Q2ZUTHQxZ2hHUE1vd3M1RFJrQzBMUVN2dTJ0QVRvS3VYV2pOdmJq?=
 =?utf-8?B?bGpJN2t0M3lGbWZvL1NmZU1Nai9JOWk1c09tL2d0b0YwUzJuRnZETzlkc0xw?=
 =?utf-8?B?d3hVRTU3OHpBWnVRVjZST0dHbjhZTkF4R0FkRHR5eGJZbjlVMm5wZWVGVGxE?=
 =?utf-8?B?UVltTm5WUDZuSitxRy9nbWJHU0l0Nm1BTGlCa3YwRC83aldxbUVoVVpEcWFZ?=
 =?utf-8?B?YWxybkFRSkI0S3NQQlpQNW1iM2hhSlllUEhhalZjUFFGc0JNTWFUV0VSSmx1?=
 =?utf-8?B?ajd1MlZpNWFTanJmTTlRcStLY3hZYlhpQXhKcXdsbnpBcmhPR3NJSnlyVC9E?=
 =?utf-8?B?YzJscTRKU0F2VWdOM1JPeUhvNmVFWGFYMk9xbGNEd2VWeEtqbEJURXhoQ0FT?=
 =?utf-8?B?Z1Yyd1FKemxQUHRyQU5Dd2xqMUtPSW5JbkhMYlRmM1N5N28wbGViTVF3ZWFW?=
 =?utf-8?B?TjkyU1drNGpESVlhK3FmZFdOWURGbXdsYWZnamVxR3d2dG9RTGhVbTFVcDF6?=
 =?utf-8?B?M2FWenFHRkxxTnBSUDlRZHlHakp4Ni9XNERLaVp4Uy9lbEFjSW5DdGkxNUt3?=
 =?utf-8?B?OTdIaXhwMXRUUFp6WC9BU1VlU0RXSS9kNWFBb3djM00rS1l4SUc4SjdFWlh6?=
 =?utf-8?B?YkNDNzRjeER2azBCdTBnZnFidVVXNEZZTUdrSGFKNnFYMXVTN1U3ckFMdWlR?=
 =?utf-8?B?UmxQZjUzVDlkbzc5YStaMTIrSnBoZEJaWEYyM3NvTGl5dldMV3lUUkJiNUxT?=
 =?utf-8?B?NTJFWW5aRlQvTldRd2VsUWRKbGo5TEFjb0hLWTBtQzNiYnpvL3R3RUYyVHlU?=
 =?utf-8?B?OTZpR0gvWG5jSnFzR3JMRGFYaFhLbUNqOVJDZHMzVHBWbzVlU2pwdDk5U0xZ?=
 =?utf-8?B?dGU5SFdHMFhJVFU4WVZIL0tLVUhaZUhiK3UxUWxYcVV1TG5MSk9lUjJObE1x?=
 =?utf-8?B?WUhNY1BEYjRuZS82cHV2RFhvR1hlWEVVcmsrb0xZUG9LeUQ0REhKRnlCK2FF?=
 =?utf-8?B?OVJCd2RqNWxSdDRBQWhOUC9LOGZrVHhTT2pxd0d1VTdvVkpSZEZkdVFvazc1?=
 =?utf-8?B?NmVpb3pMZnB2dXoydVNWNTIrNFBCT3dTK0lCaVN1RTFMMW1FQXVFVlovUDJp?=
 =?utf-8?B?OE1EOW5UMFB6bmJOT29uV1dpcDR1WXU0OCtLUDBxMHpMSFlMYnJUa3ZUTHRF?=
 =?utf-8?B?VndEMGluU2U3a2VSKzR0VWwrc2o3VTNpem9KV1lCN2xVcWY3NVF5S3QyRi82?=
 =?utf-8?B?cmZJaGpOTExmRU9HdGVVVVpWV1NFcFJ4Y0tVYjYxZGJDSFdLSngzdmNMNEti?=
 =?utf-8?B?d0lGbkFidnM3VmVLQnZtN3pBaXE1SUYrUVJIRGVSenBjeFpzVytZTFE0VlN5?=
 =?utf-8?B?QnROZjVzZEwrNWRTM0xvVC9jQVgvWDd2R3htWitmSG5uWHQwQzQvdUFiamtk?=
 =?utf-8?B?amZOZ29SRVJGbmF6RmxKUmdPOE54UXZSc212bGJ4TUNOWmxFWlhnN0lxVEwv?=
 =?utf-8?B?RitpbzQ3eGRNbDFVbUhHcys2Nm4vd25uSCtqZGQrOTNhajl5NFJ3ZGplckV6?=
 =?utf-8?B?dTJjYmlqVFFCTGx2RW9DSWI4MnpxYUtQNEI4c1NGQ1hzczg3dFFuU1h3PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aVdoenJaUVg1RGc3QWt3dEhQb21IT3ZBWGJuU2hmaVF6WERnZ1BHRnh3Tno0?=
 =?utf-8?B?OHJRS29yMGtxdTlFN041c0thZ0dlUWVQTzVNbSt1RURtNmhLL1lseSs0SVNL?=
 =?utf-8?B?L2txeEk4YStKbEw1MFlvY1dDUTRobWxDYkVUZ0xRam00NzVPc29DRUd1NGRJ?=
 =?utf-8?B?eW5xc2QwZ2NnejczZzJYQ3NNdlVsK2NaR1ZWT3gwbmQ2V2dBK3NTZk5CbGF2?=
 =?utf-8?B?VisyODc5WGlJdTdxZjN4RndHckdEN1RONjFkcWI2aWx0Y1ZkZjFsY0RPMTBI?=
 =?utf-8?B?b1dSUUl0dWFKYmsrOWdmdjBlajZ1UUswNm9uTzdYNDBDVDJQcVBtTUJIT0ty?=
 =?utf-8?B?VGZZYnJqUEFTZ0I2eFJ1RmNDb05oNzllbFFKL050cGQ1c2o4MmtBYUtvUldL?=
 =?utf-8?B?Q0V0Y3EvWXBpSTZhSXdmOW1JVnhDeG02Zk1kOFFtRnFwUnpGOUprWTZnRFM4?=
 =?utf-8?B?UlArbzRjdXNEUFhrS053cHM4ZWxWMTVJdS83NVgrMlNzbHU0TjBZR1VNU2lP?=
 =?utf-8?B?aGM2b2FmODlUMisyZmErODdmM1FZbys2dWNuWmcyLzFkcEdPOTV0QmpFMGdI?=
 =?utf-8?B?K0JKUWRuNU9vMEllNFZvUnloakV6dysrK2o5MlJvU0g3eW0wc1JYOWNVUXJi?=
 =?utf-8?B?MExBYU1vbkVWdDhzYnVlRzBuUDBWRFNUUUR3NEc3c0lPNUx6aWpPTUg5eVFQ?=
 =?utf-8?B?anh6UlJBZkJOdHRaUFZDcS83NGhmcTIyQ2dJTW9vS0JYYWtBNFAwMksyclRn?=
 =?utf-8?B?REZzemsvMWIxVWdxMFlWNjg5ZzVDWThsazZZSUtlbjVpTkVUUTcwejJZbGI5?=
 =?utf-8?B?cEZWUnN5Ri9WRjUzaU44K3ZLc0crVzBFOHRpWmk0ZEMyOXRqcXpkckxpcmw1?=
 =?utf-8?B?MFZzMHdNcE1VZnFscW1Jay95aThIWmhJbXF0R245NlBWeWlwOEF1R3ZEbGtC?=
 =?utf-8?B?alRoUXdZQmZQcjFtMndySU9LZnVObTA0cENiaS9zSW1DOHRXaGZvejFCR0tx?=
 =?utf-8?B?eXllcysxQkphT0srTVN2WjV5Q1lUV3I3RnNjK0d3OFhxTnhsd0NkZGFPVUlt?=
 =?utf-8?B?V1lMVTlBWGd3NFlHTUxncUVpckFwcnMrQTEyTmlxOGVXWmtTSHpzYlEvblQr?=
 =?utf-8?B?V1B3d29lSjlLRjJueTIrS000YWpjTFVHZWlmUDdvNEVJVkFiRjY5ZXlmaCti?=
 =?utf-8?B?aEpDTCs1N09VRHVQcE1Wc1U3TkVBVEpiZkxyTnNrRFBGRzMwN2ozcVJRa3Bo?=
 =?utf-8?B?b1kzaFBZMlNuUzZCTFg4V242RmUwWTZGcHJRRnYyOVFvVTZmZStLY2xSYnRZ?=
 =?utf-8?B?VWwyeXVYcVA4amRlVDJuV0diVU1jK2FzRU51ZkcwTXpraHRHckNIcStwQTNY?=
 =?utf-8?B?bHhnS1hNT1hIZ05vK1grQ2lZM0lSZmxlSVk1d0t3WkpNRmlybkQxM1ViQXln?=
 =?utf-8?B?aHR5aEp2YWhjNElVS2pNUTNtQnNIQkdvSTBQOU9qdGo0TjRPd24weU41cTRJ?=
 =?utf-8?B?V3pwTzNkQm0yc2M5Uzg1MGU0bEpMWHNDNm11dXFaeUYvVytCRk9hVjBIUkQw?=
 =?utf-8?B?ZGFIZ2NvbDZqVm5EalAyd0NVYWxGRGxTNWdmUEl3cnhMb2dYdzJ1M0NiTFMr?=
 =?utf-8?B?d2owZGl3MGpVd2ptZ2pleEk1RVF3R1hGbVVvZ0lnaVlHak1PTHp2dGdRQWYz?=
 =?utf-8?B?U2pMM0YyRGw1b2plc3FnSk03M3hYUkhTUUpEOG5tWWhRdTRTN1hJZ1k2cXUv?=
 =?utf-8?B?MnA4VUk5L1FDczZYbjU0WEZkSVRUb2pGTHJyTGQxQVExVGhmWEFGU2Q1NWVO?=
 =?utf-8?B?YnJvNmpZUU93MmVuS1grVHJwWEg3cDZ5YTVHTHBmdWhFOGI2YzY5bGdnVHlI?=
 =?utf-8?B?b3JEdkJ6eTdRZE44RjV6YXgxM1lxSDlFTlNycG9uUFFOTlVJd0FsZGQvL1ZT?=
 =?utf-8?B?ckMxVlJFblVQbkxHSlJKaGxFeFhWbUpHdVorQURHSWdaKzRKLy9tNy8ybkIz?=
 =?utf-8?B?eDRkSXRxRjMwdkNtV1V6UGF0OTdEWTMwZjRZVUNmTzhneEVuZWNsbmRncVRS?=
 =?utf-8?B?a05JeUxVVExaNmRQZUkwU09KbUcyeGpTd2ErZkRTTm5UdXFvdWFCVVZRZkxW?=
 =?utf-8?B?ZnlQbzVNYWMwNnpFZGQxdVFNTlhYUWVFRGtYV1dGYlJHVmlaN29ITExNelZ0?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F08C219836AD8F4091BAC50A6AAF9080@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UxdFO5J+WZOKyuGmCkKS/Jpmn1XXCbEvVBEFTfyUmopwtwlIL3LJMO1lsOBp8ZvJXGYxoUjp9yV9+jBcxB+OSRvenkUu00epw8r4Xz5KH/1GDV+NdHAZcwhDbkVc38dJsu1tRP04ZJdmzHYfi13Ihdii4eWhqYef6NQrRGJPGGk+mGBUnmQ9EneV8fIWdVa82d2mSm7YVBCynw+c3zIbPvJR6PTUf3+e0rLTnRxDlnr1nZe0B+1AF1gwcCIG+7clDjXdvzXXRIjderr7Y0gcbqh20h6Hhr1TDkqGcDrUcubIKaBUzkdkOgx7jwpg7AJ2XiK8/AIFgDShb8Jg+bPWAb6qBqiGOv79ul7OdkJJPGMjaXwmz12KAIwMA9tYMwV7++XrcFtXY3zwK+aNU4UgmYHb37ef3t4XD1tiiTqoTPHlnQfdhXpkqzEd2JcLEi+1/FsKZ9KUQzw3+8brjB55H6+Wt6lhM/1h/t+EVtF0sjRKFMjdDdLAEp11kpvv8WatDwPhNm5p6Lod62TQlOG3feVhuTI9Qpif/qkinnJVD4wnORwDn1UYfPAS2SvS1EXS6LoFo/i563NTVAbxxOqu5lsqNQpyt9NRuO1fekaveok=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddb2968-62d1-4b75-94ce-08dc741a31bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 13:31:43.1485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QLpfr9lDhh583v064cORy/png1ZPpr2UJHf8xpXYHX3n01YyP/qpjBXSps9kcIyrrNlucc5x0T5U2IlwyHcQtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4792
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_06,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140096
X-Proofpoint-GUID: zPrswnRT-TerywQ5CzwONwIUUXpmO5U0
X-Proofpoint-ORIG-GUID: zPrswnRT-TerywQ5CzwONwIUUXpmO5U0

PiBPbiBNb24sIE1heSAxMywgMjAyNCBhdCAwMjo1Mzo0MlBNICswMjAwLCBIw6Vrb24gQnVnZ2Ug
d3JvdGU6DQo+IEZvciBtb3N0IGVudHJ5IHBvaW50cyB0byBSRFMsIHdlIGNhbGwgbWVtYWxsb2Nf
bm9pb197c2F2ZSxyZXN0b3JlfSBpbg0KPiBhIHBhcmVudGhldGljIGZhc2hpb24gd2hlbiBlbmFi
bGVkIGJ5IHRoZSBtb2R1bGUgcGFyYW1ldGVyIGZvcmNlX25vaW8uDQo+IA0KPiBXZSBza2lwIHRo
ZSBjYWxscyB0byBtZW1hbGxvY19ub2lvX3tzYXZlLHJlc3RvcmV9IGluIHJkc19pb2N0bCgpLCBh
cw0KPiBubyBtZW1vcnkgYWxsb2NhdGlvbnMgYXJlIGV4ZWN1dGVkIGluIHRoaXMgZnVuY3Rpb24g
b3IgaXRzIGNhbGxlZXMuDQo+IA0KPiBUaGUgcmVhc29uIHdlIGV4ZWN1dGUgbWVtYWxsb2Nfbm9p
b197c2F2ZSxyZXN0b3JlfSBpbiByZHNfcG9sbCgpLCBpcw0KPiBkdWUgdG8gdGhlIGZvbGxvd2lu
ZyBjYWxsIGNoYWluOg0KPiANCj4gcmRzX3BvbGwoKQ0KPiAgICAgICAgcG9sbF93YWl0KCkNCj4g
ICAgICAgICAgICAgICAgX19wb2xsd2FpdCgpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgcG9s
bF9nZXRfZW50cnkoKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19nZXRfZnJl
ZV9wYWdlKEdGUF9LRVJORUwpDQo+IA0KPiBUaGUgZnVuY3Rpb24gcmRzX3NldHNvY2tvcHQoKSBh
bGxvY2F0ZXMgbWVtb3J5IGluIGl0cyBjYWxsZWUncw0KPiByZHNfZ2V0X21yKCkgYW5kIHJkc19n
ZXRfbXJfZm9yX2Rlc3QoKS4gSGVuY2UsIHdlIG5lZWQNCj4gbWVtYWxsb2Nfbm9pb197c2F2ZSxy
ZXN0b3JlfSBpbiByZHNfc2V0c29ja29wdCgpLg0KPiANCj4gSW4gcmRzX2dldHNvY2tvcHQoKSwg
d2UgaGF2ZSByZHNfaW5mb19nZXRzb2Nrb3B0KCkgdGhhdCBhbGxvY2F0ZXMNCj4gbWVtb3J5LiBI
ZW5jZSwgd2UgbmVlZCBtZW1hbGxvY19ub2lvX3tzYXZlLHJlc3RvcmV9IGluDQo+IHJkc19nZXRz
b2Nrb3B0KCkuDQo+IA0KPiBBbGwgdGhlIGFib3ZlLCBpbiBvcmRlciB0byBjb25kaXRpb25hbGx5
IGVuYWJsZSBSRFMgdG8gYmVjb21lIGEgYmxvY2sgSS9PDQo+IGRldmljZS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEjDpWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+DQo+IA0KPiBI
aSBIw6Vrb24sDQo+IA0KPiBTb21lIG1pbm9yIGZlZWRiYWNrIGZyb20gbXkgc2lkZS4NCj4gDQo+
IC0tLQ0KPiBuZXQvcmRzL2FmX3Jkcy5jIHwgNjAgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tDQo+IDEgZmlsZSBjaGFuZ2VkLCA1NyBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9yZHMvYWZfcmRzLmMgYi9u
ZXQvcmRzL2FmX3Jkcy5jDQo+IGluZGV4IDg0MzVhMjA5NjhlZjUuLmE4OWQxOTJhYWJjMGIgMTAw
NjQ0DQo+IC0tLSBhL25ldC9yZHMvYWZfcmRzLmMNCj4gKysrIGIvbmV0L3Jkcy9hZl9yZHMuYw0K
PiBAQCAtMzcsMTAgKzM3LDE2IEBAICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICANCj4gI2luY2x1ZGUgPGxpbnV4L2luLmg+DQo+ICNpbmNs
dWRlIDxsaW51eC9pcHY2Lmg+DQo+ICNpbmNsdWRlIDxsaW51eC9wb2xsLmg+DQo+ICsjaW5jbHVk
ZSA8bGludXgvc2NoZWQvbW0uaD4NCj4gI2luY2x1ZGUgPG5ldC9zb2NrLmg+DQo+IA0KPiAjaW5j
bHVkZSAicmRzLmgiDQo+IA0KPiArYm9vbCByZHNfZm9yY2Vfbm9pbzsNCj4gK0VYUE9SVF9TWU1C
T0wocmRzX2ZvcmNlX25vaW8pOw0KPiANCj4gcmRzX2ZvcmNlX25vaW8gc2VlbXMgdG8gYmUgb25s
eSB1c2VkIHdpdGhpbiB0aGlzIGZpbGUuDQo+IEkgd29uZGVyIGlmIGl0IHNob3VsZCBpdCBiZSBz
dGF0aWMgYW5kIG5vdCBFWFBPUlRlZD8NCj4gDQo+IEZsYWdnZWQgYnkgU3BhcnNlLg0KDQpIaSBT
aW1vbiwNCg0KWW91IGFyZSBxdWl0ZSByaWdodC4gSGFkIGFuIGVhcmxpZXIgdmVyc2lvbiB3aGVy
ZSB0aGUgc3ltYm9sIHdhcyB1c2VkIGluIHNldmVyYWwgZmlsZXMsIGJ1dCBpbiB0aGlzIHZlcnNp
b24sIHN0YXRpYyBpcyB0aGUgcmlnaHQgY2hvaWNlLiBGaXhlZCBpbiB2Mi4NCg0KPiArbW9kdWxl
X3BhcmFtX25hbWVkKGZvcmNlX25vaW8sIHJkc19mb3JjZV9ub2lvLCBib29sLCAwNDQ0KTsNCj4g
K01PRFVMRV9QQVJNX0RFU0MoZm9yY2Vfbm9pbywgIkZvcmNlIHRoZSB1c2Ugb2YgR0ZQX05PSU8g
KFkvTikiKTsNCj4gKw0KPiAvKiB0aGlzIGlzIGp1c3QgdXNlZCBmb3Igc3RhdHMgZ2F0aGVyaW5n
IDovICovDQo+IHN0YXRpYyBERUZJTkVfU1BJTkxPQ0socmRzX3NvY2tfbG9jayk7DQo+IHN0YXRp
YyB1bnNpZ25lZCBsb25nIHJkc19zb2NrX2NvdW50Ow0KPiBAQCAtNjAsNiArNjYsMTAgQEAgc3Rh
dGljIGludCByZHNfcmVsZWFzZShzdHJ1Y3Qgc29ja2V0ICpzb2NrKQ0KPiB7DQo+IAlzdHJ1Y3Qg
c29jayAqc2sgPSBzb2NrLT5zazsNCj4gCXN0cnVjdCByZHNfc29jayAqcnM7DQo+ICsJdW5zaWdu
ZWQgaW50IG5vaW9fZmxhZ3M7DQo+IA0KPiBQbGVhc2UgY29uc2lkZXIgdXNpbmcgcmV2ZXJzZSB4
bWFzIHRyZWUgb3JkZXIgLSBsb25nZXN0IGxpbmUgdG8gc2hvcnRlc3QgLQ0KPiBmb3IgbG9jYWwg
dmFyaWFibGUgZGVjbGFyYXRpb25zIGluIE5ldHdvcmtpbmcgY29kZS4NCj4gDQo+IFRoaXMgdG9v
bCBjYW4gYmUgb2YgYXNzaXN0YW5jZTogaHR0cHM6Ly9naXRodWIuY29tL2VjcmVlLXNvbGFyZmxh
cmUveG1hc3RyZWUNCg0KV2lsbCBmaXguDQoNCj4gDQo+ICsNCj4gKwlpZiAocmRzX2ZvcmNlX25v
aW8pDQo+ICsJCW5vaW9fZmxhZ3MgPSBtZW1hbGxvY19ub2lvX3NhdmUoKTsNCj4gDQo+IAlpZiAo
IXNrKQ0KPiAJCWdvdG8gb3V0Ow0KPiANCj4gLi4uDQo+IA0KPiBAQCAtMzI0LDYgKzM0Niw4IEBA
IHN0YXRpYyBpbnQgcmRzX2NhbmNlbF9zZW50X3RvKHN0cnVjdCByZHNfc29jayAqcnMsIHNvY2tw
dHJfdCBvcHR2YWwsIGludCBsZW4pDQo+IA0KPiAJcmRzX3NlbmRfZHJvcF90byhycywgJnNpbjYp
Ow0KPiBvdXQ6DQo+ICsJaWYgKHJkc19mb3JjZV9ub2lvKQ0KPiArCQlub2lvX2ZsYWdzID0gbWVt
YWxsb2Nfbm9pb19zYXZlKCk7DQo+IA0KPiBub2lvX2ZsYWdzIGFwcGVhcnMgdG8gYmUgc2V0IGJ1
dCBvdGhlcndpc2UgdW51c2VkIGluIHRoaXMgZnVuY3Rpb24uDQoNCkJ1bW1lci4gQy9QIGVycm9y
LiBUaGlzIHNob3VsZCBiZSB0aGUgcmVzdG9yZS4gRml4ZWQgaW4gdjIuIFdpbGwgYWRkIFc9MSBm
b3IgYnVpbGRzIGluIHRoZSBmdXR1cmUgOi0pDQoNCg0KVGh4cywgSMOla29uDQoNCg==

