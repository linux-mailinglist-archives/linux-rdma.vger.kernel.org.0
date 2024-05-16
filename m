Return-Path: <linux-rdma+bounces-2511-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E2F8C79D7
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 17:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA223B21A5D
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 15:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945C814D431;
	Thu, 16 May 2024 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TC+8BgHN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WUJeIzGU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712D28F66;
	Thu, 16 May 2024 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874872; cv=fail; b=ZFf+fqLCnAKGUGyPmaV8BmF+ft66LFdTsR1+RVYYKkxT+Z9X1rB4pGpmnNo88N2ujQ8OrFzINiEiRjQVX5WUpwstA61xRkq5HgKKtW9c3Snjbe0nQ5sDB44NNUdVXgIhESFqb45fNhGglITSJ+dRNE1D8vxj7bn5Oa7WMHpM76c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874872; c=relaxed/simple;
	bh=sA591uGqDSchZL4lZXCHVUiAiyS+XNPtR7Yg2pLiqvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aU2df0NkU0RhbAdlMPOrS/bgzLTw6EQX9KueWKmMtA/3rP5Y+mhU818lbw9qaBzNB4sDj3TEoI2qDWWT+evozeeDoBAIFrxXyY6Wc1RhE9Chry7Hjgl3VGWip6JgxQ45eg9MCCn+hFOyepUJLi2CPMM5mE1l4j3slibe1P2gC3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TC+8BgHN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WUJeIzGU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44GFJNaf018719;
	Thu, 16 May 2024 15:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=sA591uGqDSchZL4lZXCHVUiAiyS+XNPtR7Yg2pLiqvU=;
 b=TC+8BgHNDyYTwSzFsvJz27Jm16z9gxnFDZ7yX8V7Z8yYMBf3AbURaYSMESbWKANqBpkR
 gv1KhGDD7JnaaCy1leQDjLwZPlk05Do1PKkOw2eGOLiuAGT54aPj1e23RbJcdLazXNqq
 bvM9D5KPx0oLiZF4e5Emfl+pnKZ+D4YhvqKyro9drjsD1wVIhTxcg97wTGJgMN1Mc1Rs
 I/cjDFfcKGlxBDt2cbmjshggEACZt/po9lCcHhW0IHErqcHRA2VmYqzvlW9CSUICUPk7
 CHyPmNAmf0zOgVITwjoO2WTdsbjE0HnwPEV0r86ww9ZMRGeVjiLVahHcdiroxjsEpG7P wA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3tx37kaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 May 2024 15:49:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44GElGIG005793;
	Thu, 16 May 2024 15:49:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y4ada9y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 May 2024 15:49:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihNLUGeO59Tel4QfJEEkAbqx4G6LAiI2QZt90rBFurbO2M2t2KwWJyIwyLZrOomumaJNUz10elfLu202GaHIXd7f05jDo3WEkzweOCBUKRojov4T4bgTlOhfUaruXU7gTIoo9dnlMBuM0nMW7OQCxSZ/IBrvnooErUhc2JFBGi3NEucPLmmwqjDgFIfCFeU6LVMcnT6NBnxW/NlfOb9ezwGrYViE89kjj0ksIwDmgT8Ov40fL1b+4nSoTrUIRvqWkMLV2HwOZIMzaY/+/7HdNepsurmgbsTbAGyrawfHVjcS1wiGf/GHVL5BPjet2Za29eaXwlvQfgn4cyCrFhRfag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sA591uGqDSchZL4lZXCHVUiAiyS+XNPtR7Yg2pLiqvU=;
 b=GE8cCmD0FEmHkOqgj7YJqEDH/etw5ScRl6dGCj6aYn5JCX8MkEl14M4AH7FGgpm0YXwNnY24DpRglQLTJiZNb9jPICXQSWXNwokZiMnLiZQllhi6SSx8i4EzWBzshJsouxnCUCLzgFucgogMWP5CTaF9tREclFQ6LqMko9Ljabw/Zf1co0dDhzVjGRo5m/WDpR05/BuUN0OJM9H1FC3TQ4fbINWS9NLvibyuND/e0PdecXWRjIGTcg+p2ZYumF8HeSR6kDioSpGF20FqYENYepsQU1cJQmsiu5TTKSV6ldfTarzoBUzCveq+XCCgnTuQ5HcWBI4zla8zREl/2gLVPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sA591uGqDSchZL4lZXCHVUiAiyS+XNPtR7Yg2pLiqvU=;
 b=WUJeIzGUFcZr/Lf5mR+w3e3dRg+BF8DYVx0bwiAaR7flZkYT5vLeShqomQPNJ3XQD8EmJkFxvWry0cEW0tpuTvCWKGTwj9dY4fBzbkGpOocCXCFoWUUuASQqiyk45qoU9Axms8m1zDLi2AiPGow9Jvz5+IWZioPLFhR+P+kQIl4=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by SJ0PR10MB5549.namprd10.prod.outlook.com (2603:10b6:a03:3d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25; Thu, 16 May
 2024 15:49:15 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::8518:ea67:dd0e:9836]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::8518:ea67:dd0e:9836%3]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 15:49:14 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>
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
Subject: Re: [PATCH v2 3/6] RDMA/cma: Brute force GFP_NOIO
Thread-Topic: [PATCH v2 3/6] RDMA/cma: Brute force GFP_NOIO
Thread-Index: AQHapsb3zA/Z31sN+0OQadFdGByD+7GZejWAgACJYYA=
Date: Thu, 16 May 2024 15:49:14 +0000
Message-ID: <236B9732-8264-454C-94BF-7C9D491D3A37@oracle.com>
References: <20240515125342.1069999-1-haakon.bugge@oracle.com>
 <20240515125342.1069999-4-haakon.bugge@oracle.com>
 <82bf9e5f-b798-4d29-8473-c074a34f15b0@linux.dev>
In-Reply-To: <82bf9e5f-b798-4d29-8473-c074a34f15b0@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5593:EE_|SJ0PR10MB5549:EE_
x-ms-office365-filtering-correlation-id: 70220a3c-7418-448a-26df-08dc75bfbcf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MUYzcnU3Z09hMmxYTm80ZWV1cEw0M3hnZGN5cnZtSTBZbTNPbVJEK21KZDJm?=
 =?utf-8?B?ZDdOb1I3b2NvcG1kYkE3QzJDNm9TNjlpV0RsU0gxRDJHVzJKRkdrU2pldzFG?=
 =?utf-8?B?OEsxTlQzazBsdmFSa050dVpaTERtcjMwbUZTaS9hL0d1M0ZUN2pMb3JsdVZ5?=
 =?utf-8?B?blNrczEvUXhKMmFVamZmbXhPSWxsMnRHWUtQTmtDVWlDdTdLUW1yM0NCWSth?=
 =?utf-8?B?a0tWWVNzR0phdnpHOHEycEpIeWxENHNQU00yREVaK0V2bzN0MllYWTg2MzFN?=
 =?utf-8?B?bVFpclp0SDAyeFQweUM1aXBDNk00akovMkpCejlyQnRobzVyTFNWbVpCYUZj?=
 =?utf-8?B?VDZsQy9ERU1seVZxWUtWSU95cnFRUm9NK2pCSzBSc3ZySEtsZGJUbXloaGNG?=
 =?utf-8?B?aXQ5ditQamhkSXpsNFQwd1B2WHkwdWZNdE1DZ1lGM2NDaGtSQTZmVU4reHIy?=
 =?utf-8?B?Z3o4SDNoNkFMQlZJQXM5VmtUUnBkU2R3ZXllZDR3S1FtUk9JK1VEeTlqbUVD?=
 =?utf-8?B?dzlaWUhHYklYaDhFa2NhWG5kQU1oU2F0czZoODFHRmFZWDZtb0ZIMzNQd3kr?=
 =?utf-8?B?UXBLajBOMVpQWkRadDZYaXlVaGVmM1p0aGI2S0M0ZlZNRmFoVlBzU24wSmdC?=
 =?utf-8?B?bnlWeHdoZ25KdFBVdzdzWmdDSEtRcFpuZ0prOHZLS0I4UVZoQXZNdmhrbnBT?=
 =?utf-8?B?UWZEbkJob0IyMUt1Tk9HckFoTU5ybkF4blhudWtMdnlpc1BjU1FzcjVoVGJl?=
 =?utf-8?B?OTRJeHdjSGlSVGlSdS9zSStWR2F6MUJrVVV2dkZwelZ0cXpGaFV5ZGZsZlQ4?=
 =?utf-8?B?KzJ5VjdPK0ZGV2VaNmZsS0VqaDQ1UldSVWExMEFWVU9maDhqV0dLcjcxWFhR?=
 =?utf-8?B?dWJUVkVUN2RLY0pkVFRCNTVkemE3WEN1WXlqVnpNeG53WGNnZUgrUVBFVUd1?=
 =?utf-8?B?Z2FjTTVmcnVZL3NSQkVGSStINVN1N3pHWnhUVXBiUDlSVmpsTU0wcFNINlFR?=
 =?utf-8?B?NGVaOUhaQXNPWFVGOE1Eb3Q5Y3RPTTdUbzRtU0ZpL1F4QU4rcTRKY1ZFenRI?=
 =?utf-8?B?MjZpM2dsQU1BMkM1aUFJd3RPSHpNWDFNRXY4T1FTcGZqUUpTcW5TL1pZeTdG?=
 =?utf-8?B?MGNTNkpYUis5MWJQeFBwaXFFQjc5dFFOS05zZkRLZGV0NkZIQmUya2s0S2FR?=
 =?utf-8?B?U3Bxb1hXNzV2S1ZzeE5paTBaQURrL3JGR2doRDVxR1ZxK0orMUtoMVp4TEx1?=
 =?utf-8?B?NVNUblI5ZWVRUHczZnRjRGgvVktZS3dkNCtLM1ArN2IwSDl0dk1YVFg0VlIw?=
 =?utf-8?B?cXJqRW1vdjloUGsvc1MvZXlpV3N4VUZaTFpmZEoxWGUyRjdEbTNHaWlxS05h?=
 =?utf-8?B?cHM0Zzk1ZjVvcUpaajBaaTV2SlV6SHdydVhiVEFjTjlhWDI1Q0JLOXc0VVc4?=
 =?utf-8?B?UzNhbjJ3KzJoTXZKSHpkOVhvYWxIanFpVWtEWjZ4WVl5UkdsakMxdVZMYno4?=
 =?utf-8?B?OSt0K1Q2UXdEbUtRYm40WGZBekh2MHhJUTJGUElqUmYyM1FCbEZWelBOYllP?=
 =?utf-8?B?Yyt6SUVnMjkveUs4TXo1YW1PVjhkcTNRYnpiL1FLSmVhLzNWVFVTdlRPS2U3?=
 =?utf-8?B?NENzdlFyb1cyM3Y1RVhkQXlRaEZzR2JBWWhHS3U2L0QwN0ZMRTRxcVMyRm5S?=
 =?utf-8?B?Qm55WklNTTJCM2xpNWRteFY2dXN4bjQ5OXpCR1ZqZis1Z1dYaXQ0TWN3PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YzJzRTluMENtVDJIK1QyN243VmZzc1hTdzdXVFJBMDVZMDVtZFUyV3NtVXhX?=
 =?utf-8?B?Y05Vd2RPOFdWYjlNY3N4ZHhNVzRncStRaHV5cUNiZm54OUxkaEl3VTdQVHFU?=
 =?utf-8?B?TElGS2R6Mm9nVS9BbGNnSTVoVFhFSFIwTTZnU1cwcHZQTVhETE9xdFhOdmMx?=
 =?utf-8?B?ZE5BVlZDdEkzTDRaRUJUaEJwU1dNNVdKSmdWdm9TUHpmQmpNOUYvWWttL3ZD?=
 =?utf-8?B?bWQrbW93alF6UVM1d0hjek8vMmJpaTAxdFJ2Qlh0elJ0MGZ5eG85dEc3ZTg3?=
 =?utf-8?B?anBCZnVHcG5KVnE5Vk0wVFM0MzRIZWxIZnowZk9DSVBPMXZvc2g0UWY4Mm9E?=
 =?utf-8?B?UzNYTEY3SjE4OUYwUG8yNllPN0F5NGpFTWJRMUc2ZXBuZEE1eW4rYVNqVzBp?=
 =?utf-8?B?elpIaC9kTVZkTk45dEdibHdmS2taRmVSRkFhS2pyL2ljQUErd0NsaFNRR2Nz?=
 =?utf-8?B?a2xtUXcvaWV0T2pZTUlweDdjM3ZRYmN0eDMxNk55UHEyd1FsdGJjSXZrRUky?=
 =?utf-8?B?VC9XWUk4cG1tOWtxN0p3OHpjNHBOS3dvc2NUeTJzVTVoNFl1TXNYVk04NVhD?=
 =?utf-8?B?b0FGZnlxNThZNXA3TDZxNzZtKzR0YmxyNk5WUmxtdGZOdUhsWlVxL2ZuWEox?=
 =?utf-8?B?RGFLZGlqbjB1cFZNZVZRQk1HbllERkxGZ21NZjAvSjdhOUVJeWJRSU05VlVk?=
 =?utf-8?B?cnNsZ0hGRDdpdEZvVUtjbTVabFhCM05WVld2cVZKY3h4QU0waEZqRHI3VWtm?=
 =?utf-8?B?MFhEVko4QTlPTWN6VnZNQW5wQVREUE0rTjA0VC85L0RjSjBkTkp6NXA3RERj?=
 =?utf-8?B?OUtkeUNXaXZYWkNRQXBuUVpVVGgxTTdQMFBmcUw4b2tvSTNRTnljY0tVN3d4?=
 =?utf-8?B?RHVhZkJKY1ZlenErNE1JTVcyTE1YaTBFY0dtakpUYWg4ZDBBa29QN2tNZjY4?=
 =?utf-8?B?VUR0dnlCWGlQNlF2SG5PK0ozVXBTc1ROT2V1WTZaVk9qdXpUcmJZOTJIQ0lJ?=
 =?utf-8?B?bFE0anl5aEpJa01NNzRBOWlBK2ZCc1BLMWlaNGtOenJvMWVCbG1NYlFCSGEw?=
 =?utf-8?B?bXJUc3ZNRkZwbDBXK2p5elF0K0RHOXlnOURlUzNOQ1hRVUJFeVkvTlhlckRV?=
 =?utf-8?B?ZkkzYWE0TmoxMktLaG1TN25weFhtaVltWjlXYzFzMHhOOUphYm5rT1pFWEZU?=
 =?utf-8?B?aHo1c0VtZnZIODBBd3FpVXVFUGUzTVV0UUlTWDhQQmFaSFVUVGR5alZUMFNm?=
 =?utf-8?B?M2FZMFErNXh6TlIzZlU2TGpzK2lxY29NeitEek5pYU1LZExwKzhxUDlCZ09J?=
 =?utf-8?B?M3RMOXlLQkhrdkRMWEVyWEFlRm5VS0kwV0ZlbHhqeXlma0kzSVYrVXdzR0Y2?=
 =?utf-8?B?ZkdLWHpiaEdGSXpxcGxIUVQwc1pVWFZmUGhGUGhRK0FBRGhPQ25XTm9xZ2xP?=
 =?utf-8?B?WklPN0xJZzRjVjZ5Z2ttODd5UW5GQTJSQzFMMkh0RWxlRmtvVUlLT3JZZFY3?=
 =?utf-8?B?NjB6STZGWWNqVjZDVFJwZHEvcWpOck1ObDdTdi9ZMS9iajFtWWNjUzVmMVZZ?=
 =?utf-8?B?TVM5N1RNY2lvMnVZSkpTaTY2R2pRNml6d1FScThEUHJpM0RqdTdod2w2MlFZ?=
 =?utf-8?B?WTZCR25jaWJEUk5OSWhKWEpQd3RsYnZnejdNMkpKVzFlWUdSUWxKNW1WRnh2?=
 =?utf-8?B?ZjFHYnQvRWRFSGl6RmFJQ2FzbW8rM0gydlJ2V3R0VVRDQXVhVHg1dDlUblBR?=
 =?utf-8?B?U2JhSTVBcFpSS0VTMGQ4SzdUbmhzajBBTmYwdkRMSVVYaU5CR0hCZml5cXlE?=
 =?utf-8?B?VVQ0NnF6ODB0aWp6MFBONkFqMW40dXhobGp6NnZ3QVdYdEtQZG45NTdUU2kx?=
 =?utf-8?B?S054MFJyRG12a284QXJqNHFVd0ZxOXZOOE9sTEcvRmVZVlJoWVFLam1kZU5t?=
 =?utf-8?B?aHRUZnJNSG5lVFhXTXZOUEdGSWtzcUhGNGtZQ3BTRFUxTjNjV0hmN2ZLMlhh?=
 =?utf-8?B?S1ZCdTN4Ylp1NVFtb1kyVXpjUmtyNWtBWkJkM1RzREN5UkVNbWUyRkJ5a3cz?=
 =?utf-8?B?VWRPdHdrN09TeWN4SmRkSUtOdUtXUWxGVzczMnNKNDZNekhoK2dEWmZKWXBT?=
 =?utf-8?B?bHAvelN3M08vMUQ1Q0hCZUNuNEFWK2VwL0VDS1NMaUNPWDFhVE1qcFlVWUhX?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0762E4DB59C5254FAAF0950A7AC53720@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	y8C1lBv7wSZOSo3iOWUnEgfAOytCWsQPFo9ciWlxZvcwHYXT+Z/Fpl9BGWVeKJ4IsEEUiAly0yfzkLQ1mnRLa0K+Ca2M9EKGLW6ZgCzurqg4S8Zi5VbXZWMIq3INCElOZbAwaffxMvm7bsSde+Dr0304pkrnvDOljhz0uQjnoVOxnwEjCeR4rYHdJR9b1ARLZlLq+xcl1r7FUg8mD1XpVmqgG7+av+cQUF9S8UXSjja8jQ+aPTGAyAJgEY21c10jk4aZg7tftidNUbM2uZ2jEWCnm9FiBonAkBgb5bl0QgisYsSu8IxGMTr+ArTW5YwGpMvCU856CAYja1CNx3lEWftmpeNjB9VSNbbkurz3Snc255ikTNNs4wKw2m+m1WFqd6od0krXiIX9JtiT3TilggQYyXhsU8UTvZOQJ1vcS7JbSaDVUC66kdtrV79AfWUpqY8oRa+8KPma/K4H2tMDlT101cLzOWaLmkABA9Ns4PMQGlrAfQesef4wHWCUjvKuprxorJKLDvhbVb+xFsxjOWC3mpk6X7sVGppAIuEn6C6nUhCoE+a9wOpC42F7Rlf/wUqvWBBEL+EFzB0VcIE6JLB1K4D7E4AnmWRY5p4lRjo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70220a3c-7418-448a-26df-08dc75bfbcf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 15:49:14.8717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z/1ngJiRfEBMjntiqd34UEmuk3Wg5kcaTyvdKF5nzGCJFPbIlqbozx5cCtCAVABR8Nww2RF86uPCpC1BjOMTVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5549
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=895 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405160112
X-Proofpoint-GUID: BlRORTjTn_zzQm_Zgo6LdOJpIC3NDKxj
X-Proofpoint-ORIG-GUID: BlRORTjTn_zzQm_Zgo6LdOJpIC3NDKxj

SGkgWWFuanVuLA0KDQoNCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL21h
aW50YWluZXItbmV0ZGV2LnJzdD9oPXY2LjkjbjM3Ng0KPiANCj4gIg0KPiBOZXRkZXYgaGFzIGEg
Y29udmVudGlvbiBmb3Igb3JkZXJpbmcgbG9jYWwgdmFyaWFibGVzIGluIGZ1bmN0aW9ucy4NCj4g
T3JkZXIgdGhlIHZhcmlhYmxlIGRlY2xhcmF0aW9uIGxpbmVzIGxvbmdlc3QgdG8gc2hvcnRlc3Qs
IGUuZy46Og0KDQoiSW5maW5pYmFuZCBzdWJzeXN0ZW0iICE9IG5ldGRldiwgcmlnaHQ/DQoNCg0K
VGh4cywgSMOla29uDQoNCg==

