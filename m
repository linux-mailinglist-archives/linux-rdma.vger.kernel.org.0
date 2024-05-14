Return-Path: <linux-rdma+bounces-2478-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFA18C575A
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 15:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE39DB21640
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 13:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7831448EA;
	Tue, 14 May 2024 13:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EAmIsKyq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kj52v3L7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AF2111AA;
	Tue, 14 May 2024 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715694528; cv=fail; b=JP5pz2gunOL0f1jHjLMRDvpq1hzgL03jOY2QkeLrhKEzDVtLvacOsG+s1OkUEC166PreeUjp5pmw6j2JwLj1JdQWLpFjn1wtUdRf4n7RgDXf3OTissmf8V1bXEyEp9qv6bYTAIHhiptFJuZSkNZvnrYx0dzcI5YabD2KCTlF/GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715694528; c=relaxed/simple;
	bh=d3bvtuQ9xYOIEDxjCyQ2B45TsqL88+2APkezoOM0YjY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qT8+XieTzFSLGFjOMDBYrvjQdBRd4Iyyo50hr8tZ+sUTRospsMdItvvxE7FDCV7bgnkFN9FGrJ0UfmtP6g0cGE3OJgtD3D39QpbByXDEfAGS3YLR6DLaHL1uzeDUFf7P+4WirW/l4xfPD0nlEJuE7k78naKyibvKWuF89dPU72o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EAmIsKyq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Kj52v3L7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44ECgKMt003216;
	Tue, 14 May 2024 13:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=d3bvtuQ9xYOIEDxjCyQ2B45TsqL88+2APkezoOM0YjY=;
 b=EAmIsKyqkoJNEqm9ZIIBtHqGKhnjlgK6IucZfRK8GRmvwoBY3ZlpJlLOeUEr0eY4QfRp
 4sclu0bt5AI3yTFWcmw2956Y1B2x/BJXHHBtornSYmlycqilA69CIsYjzAIYMPi/VYKj
 Ugs8qosee3mcvpCxgYjhGJ1vYSzQVhUWXmMzm7qqtj3B4dWZgdjJW3JRzozuQOE1UBBU
 uQ9NA6qmphCV2uIN7P2MzJ84xGSqkZzkLaI44O0plr/IThRdaDJR1G02uIpRO36/Bx5g
 wG67pcGtdYKcqN1MQcggiZk1Iqp7fzMq+gYu7ALmmHaznBBe0Fuyu1C7t8Qb7s/T7/KB 1w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3txc1c4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 13:48:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44ED6ZAj019285;
	Tue, 14 May 2024 13:48:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y3r84tp84-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 13:48:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iS6zaUWCRjYMDW5PZneCZdWkW798dVfiv5wiFJyTY3t1DsoDlOmL08avrIcElOVm8EG4Q35yCRen05+c81Ga6fUbAdP5viZyAQoeMiHnvQIE/CE+/SepFtGb8qhcwyjm2193Q6pnWYKEWDRPXPcMfIjU01tl2q+UEs7q94wNkT2UdonNoBiD/9sbcl21j4btJ7oPl9GuWoFz1ysRYb4DUaySVKd5SOb+tCBQsjHT8RGvlZF0y/6P9MGhJ57I5vuonxUUBWGiYzBPWxFsBv3SOvPGYh8spV5JnvoD/EqhtB5O9a4sbE5jg4SZdGf0bV0n+eUbdVPEst+8VsYI3OvcgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3bvtuQ9xYOIEDxjCyQ2B45TsqL88+2APkezoOM0YjY=;
 b=KWXYAdHJr89JsluKM0vQ6P9FMQZJMl+/SgYxsHI4xcOgFlJlUi8D17h1JvCYpYAeEdVlzel5RzGhSlJRKrnWIss5d/gHk7tdN0fl5Vr4NIYvCx5rvkeiSTVekm3QOAT+jzi+hJ0OlZQ4ETF7DiLxNWI6ZoRy3XriRjZgdUPtPMZt0Vss+5YXVB8BwOSG27VGBTV+161pA7450CnxGUuWfvlaM7sUQGZ5ZC4WnhP6OtegQVKnABXdkTvRq6f/+zb2ZRefyjYmlwwQzht+sJnWtCYmUV/LyVvhQSOKZ6BakUcD8dxo19qhxx4vfHSDvMX6tCVp2s20Y2UH4wxmA+4XvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3bvtuQ9xYOIEDxjCyQ2B45TsqL88+2APkezoOM0YjY=;
 b=Kj52v3L7VtWVotm061lQHh2VkTM8pk3451lcSbJcQ5dYTTl/2FIcqs4cG9+vBa9FaQDc+wRgFCEbD1SEDMc2/LEKddG6SPgDCuMJ3/KsutoTuqQqCnhU/dqZ5pIu/rvp68eG06WnbxdwvjNdjL7hOFZkiZSVaVsIOE0sA0GScS0=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by DS7PR10MB5166.namprd10.prod.outlook.com (2603:10b6:5:3a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Tue, 14 May
 2024 13:48:24 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::8518:ea67:dd0e:9836]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::8518:ea67:dd0e:9836%3]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 13:48:24 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Tejun Heo <tj@kernel.org>
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
        Paolo Abeni <pabeni@redhat.com>,
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
Subject: Re: [PATCH 1/6] workqueue: Inherit NOIO and NOFS alloc flags
Thread-Topic: [PATCH 1/6] workqueue: Inherit NOIO and NOFS alloc flags
Thread-Index: AQHapTSrQvuhoNL+7ECbQrjKwsOry7GVYGQAgAFf7gA=
Date: Tue, 14 May 2024 13:48:24 +0000
Message-ID: <6E7B1E61-5BB1-47C0-ACA9-989EC0FD03B9@oracle.com>
References: <20240513125346.764076-1-haakon.bugge@oracle.com>
 <20240513125346.764076-2-haakon.bugge@oracle.com>
 <ZkJEZuNRqIVUGcSn@slm.duckdns.org>
In-Reply-To: <ZkJEZuNRqIVUGcSn@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5593:EE_|DS7PR10MB5166:EE_
x-ms-office365-filtering-correlation-id: fe349a7a-00a7-452c-27fc-08dc741c869e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ZGQzVmVObDlmdWdIbVFhOExzUTFacFh6T042b2VDdGdpZFRGaFFlNG51VkJu?=
 =?utf-8?B?Mm5qNkgvUEpuZWpUdnJoU0ZCV3MzbDV3N2ROdXNhVXlDQzBHR1FCaUhFZU9o?=
 =?utf-8?B?bDhTM0RDZTdLSGJkZk9VaVFWd2R6OUpIVzdtTS8wamthQWptTnJmUlZZQzc0?=
 =?utf-8?B?S0swbWVrRnV2YmlLaUgrK2NmUFR6QTZxNDRrMGg3SUdRYlo1cytlMm9ZSU95?=
 =?utf-8?B?V0I5QUJOZVFIbFVjRUZ2Mm5kUnpLcHJ0S2hzVDQyZlVFWnhtR0ZVTnJCM2lz?=
 =?utf-8?B?WHg0SEpaQ2VjbU1lemRzQ2F1TEMxQkdqZTdHMnVxejlIcFhkQjN3a2JQa1ZQ?=
 =?utf-8?B?YXhmUU5hTjFxeTE1cjVUWGFCbDVmaG1iZktUT0ZBL2xrWTYyWXRXbmJGZG9n?=
 =?utf-8?B?UTRaY0RvbmtrMTZoS2dhVlJIaG1IdmRrQmtQVTdhQnBXTElGMXJOd1NrUGNE?=
 =?utf-8?B?Z1Y5ZVIyaktKY3lyOEI4MFV3aDVycEtNK1pwMDJtbFJXbGo0amF1WUNneVFm?=
 =?utf-8?B?MTFOSzBTNmNzS1RLVEIwbnkyVnlWOTlCdFpyMnE2bk5BRGovTVJTcWFNSXdt?=
 =?utf-8?B?MFFJc1d1dlhDc0psSmwyanVoSmxqOHNBRXVSQ0RRcWxjeEhSSTdHcDB4Ymp0?=
 =?utf-8?B?Qkw0M1l0V2FDbXZnNlgxRVFlcXQ2c3I4cVlYd2RrZEordXZQNGpnSjdWb2FZ?=
 =?utf-8?B?TXhGQksyT0FTekg5bVhvT3RoeDY5TnFoTXNycjJqd2hMWlgzeHJabFFHallm?=
 =?utf-8?B?YlkxdnRCQlU0aVBzMHcxb1JwRUxWWlkzRVAwSVh6czVKcUE1bjNXcnY3QXpS?=
 =?utf-8?B?c0RQc0pod1V6bGFGNGJKYysyNXZyd2JRY3lScC9pTi9PcmVGVFBlWG4rK1Iw?=
 =?utf-8?B?OHFCcUI5UXo5RTcwK2huSTRWcmVOU3ZPVFdkbXhPU05MVitucjk4a1E3RjVT?=
 =?utf-8?B?Z3FGeUFHcE9TMUhDUmozUzhyMkFXTmdYcmxqTm9ya2JBbURZT000c1UrUWVH?=
 =?utf-8?B?TUFMWTVML09wK2pJaXIyc0pJR1ZwWkFmRXROK2tBUXhuUG03N01IZ055RE5k?=
 =?utf-8?B?UHNocy9rSVdjUnVhdnVyQnRXZEpjeVFEQ1ZGSDgrNXJyNm90WUYzamJBd2dY?=
 =?utf-8?B?VkhUdVYzS09aNWhzQWhnUm9pN2I5RUxuUXdua2dZWXVWL0NVdE1NZDFpMGU5?=
 =?utf-8?B?TjcxSUd3REcyT0oySFEyMVZ5cENpYW9aRXJlK09uWTg1U0tyU0IwK243Ym5D?=
 =?utf-8?B?eXZpTUdWNTFiUTBRa2RHSzI1dlZnZjdyVjFiejcyQUlZaFFsRnd0TDN4MXJU?=
 =?utf-8?B?NUpGY05ZbU8xTHdFTjcwZXZyZ0tWSER2cU1RekhkTGkvMkhWazJKY09zaExx?=
 =?utf-8?B?RE5MY3pjaHdZbS9HclJRREZabis3TTkrSUhoeGJ5cVJ3bUxVallHK2oreENx?=
 =?utf-8?B?b2V6a2VzSDdhVjlYemdTRzNjYThhK3ljc29MVFBXSGhRWmZ5TVV3d2o1ZXFK?=
 =?utf-8?B?UzBrVW5pNklLOVVuOTZFeUNtVTRzMjhsQ3NVNlhFWEVtYjFsTW93MDFvNmdz?=
 =?utf-8?B?YTk4VUZWQ1Qva01ZcW1vMC91MlRPN3RSaTk2SDU1Y3BJMVFGNWhKSTFqYlRE?=
 =?utf-8?B?cXR4YXRxdDBaWk1HRTdFZnBqSVlaZWNQVkVKenpXUmFnVWp5MzlNQkNra0Z1?=
 =?utf-8?B?aCtVTHRveVdiZ2syVzJtQUVLUU9MamdGM083K3VPUFNWYjczOGVMbldLK0xt?=
 =?utf-8?B?K3A3TlBxZGdkVG9YT0hmRHhwYVc3dWpnQW9BcU5DazZPMDJsd1BZNmZCZ0Rr?=
 =?utf-8?B?U01Nc0JkajdEbFd6WHpyQT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TnFsRThrYnpkb1RQajNyMWhQRlQ3VmN0RU40MnlkcjcvNGZZcWRHdThUUzRq?=
 =?utf-8?B?ZkhpeDZ2OHllUUwvMnNrQjNURlRReHdSRHdpa2RJZCt4a3cyZFMxOWh3bDlC?=
 =?utf-8?B?ZHhjY2dlNlVrREhsbzRKMzAzZlFCSnZpU25kRTlSMGlDSmNERGo1bDg4blpC?=
 =?utf-8?B?bEJhaU93K29MaWlGQmxBNlIzRk1ndTQ1UUJoOUpEYmlaKys5czB6Rm5adXBS?=
 =?utf-8?B?V001NFprVDRWeXBFOTFOSkhqR0MvZDJFTDlXWU0vd1FzbklxUTNJbzFWdnIz?=
 =?utf-8?B?UWpXeWw2RDdDZ1ExdDJJOGxIK3RaRXozYUJnZkpzTHpmblcvai9ZdkZFbUMw?=
 =?utf-8?B?S0Q4SktuTW0ySnU5c3VVUk9Ia2VYaTRqNllhejVUeHZNdmR1MEllV1orZW15?=
 =?utf-8?B?UXFZL0IwU1JnOWJXOXNMVzBUUHUxRDUrOWtROEEybHBLUmlKZlZGbG5kNmFl?=
 =?utf-8?B?cHpPTlhjRFcydFY1TmE1OUdOTS9FZmNtNVM0cVd4MVN1OTV0SlEwc2tKU21x?=
 =?utf-8?B?NHRhZ1dQcmlneTFuWTJQL2VFOCsvcTVKUVMraXZ0WGVMQ1lLOU9BU2RoYTAx?=
 =?utf-8?B?TXFiNzJlN0FaRTlvYzAwdTRLREFraWpHcFA4L0dGYnlsSFJsLzBZclluQjRM?=
 =?utf-8?B?MlBUSEV3Zk9BejVJNHYwUGlkMmNLQTFHVDByM3ZaUllxbnBQKzV4cGh1V2dG?=
 =?utf-8?B?WmpXOE5aOWxLZU9idEVRMUo5WG5uNXFBOEc2QkkyOVJaSmI1L2kyaXYxUnZO?=
 =?utf-8?B?MGVDKy9oemRJcXVuakFaZ241ei9TZ3VlbU1ocW5RZjNmZHJ6K0gzUkN6Mng1?=
 =?utf-8?B?RC9KM2ZGZXlzSG15NVdkVzRjV1RGL1R5OWhycU42bnFMVVlZQ0w1VlNXZzEz?=
 =?utf-8?B?QkI3Vjhzek5NVzNzT3JUb0ZxTDlYRCtpd0xOekg0d2JWQmxDYWlFdXVoS3Uz?=
 =?utf-8?B?WjNpWDhsWXNtRTNWY3lIUitMOTZxRlpsMHQ1YWFMenNGUVJxZ0RrSjlpSEx5?=
 =?utf-8?B?bEhmVE5IV1lVY1JuS2FHSlR6NStHRHd5N1N5YVViakxPSUU4aVRkZ2UyZUlD?=
 =?utf-8?B?aTBDWEltaCtSd1ZDdTNjZXdjOTFrZjZVc2tHUmpTeHpRSFlTVE9DNEc5NUJy?=
 =?utf-8?B?blVGS1Rwblc1VlQrVnU1blZydDVZT1Q4a3FRbHVJUDF0MUdWa0hTU2FZeEc4?=
 =?utf-8?B?dEp2OExCdTRUN0toUFJkMDJmckZWRTNRVmZCcjNOQVdPbkpacGZsOUltZHJk?=
 =?utf-8?B?MGdTaXloSWQxejA3ZG1FQkt6d2VvOGJnZEdtQ2dnMUJuWHZRNXNJR05JR0F5?=
 =?utf-8?B?cngyb2NCZ0haSnRwNjRkZFltbXo4L1hTaENKcTZWdlJHOFNOYWhPUkZDbGhR?=
 =?utf-8?B?MllYdHlmYzNDeUpIQnNYMWlTYjRmbUR4ZmJndnNYSXJnQlhnMExMS0xWbFg2?=
 =?utf-8?B?TG9nOXF0dEVaUUlmYlZEcFkzWUJxNGRUMzZoS2xMck1KQmJMVzVzYWhUWExD?=
 =?utf-8?B?b0VUSzM5ZDJMT3B2T2QyNXJITXFVbHhkNUJkVGdLdWNuR2VIWGFkYVhQM2sy?=
 =?utf-8?B?eThBbFJHbXpKWmVyTXhPVzNQcEZJTWNXNk5TdWxYaTZ1c3FRc2xIajB0dWlu?=
 =?utf-8?B?RGJtZ0FRT3VYdVVQWVRqL1ZJTEZ6Q0ptR0Z5VkJoamhMclhkNmU0VlpDb2Y2?=
 =?utf-8?B?THcvZmNVdUpxVHpEalJOUTE2aktCNk9xNzJsZEdKRHByUk5oSXhRV2FSRjlV?=
 =?utf-8?B?amJwY3ZiSms5emFxdElNbkx2LzN1OTQ1cWIxV3BlRTROeTNsTURIcTlidWNT?=
 =?utf-8?B?WHY2NXQrcGQwT1hOWE9QWE5JK09OSnFWZkRKbjlEakZSOEZBQ3hVMGxTQnVO?=
 =?utf-8?B?TExuN29TbnZYam5vZjN2eDFlUXF5dlRBQkpCNFo0VTJtWENOVkdhaGt5bXMr?=
 =?utf-8?B?U1IrUWxxWTA2dVltdVJLbWphZ21OdE5wd1NHOGlqbDY3RitoRVhpa3gwdDB1?=
 =?utf-8?B?ZEJRdUZ2UVVGMW5PVWl5S1hKbVR3T0d0NVBnOFo1c3ljZWFHdHF0N0pGai9E?=
 =?utf-8?B?K1ZueXJjdnVkemlTSW5yVlFjNjlwN29JMkgyeXd6cFc3QlhiS2oxSGFWYlRv?=
 =?utf-8?B?UWUrT05KMkxZa1U3VVpQdHFjYWdSRDlPaXJGWDdRczF4alRORUNuU2hPOGNG?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27FDAD88191C8D42B954816BF40B940F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Nug91Lfxl6BxV8Q9sqySZwybqk6iNHjgEDGYJNI1THhlMWmJHY+AnJyn28rqzhANQRZY7wWyeWYSDg6m/GqEXmPWR8JU73k3hnk4jVWZIogqY58D4UKezj1Ico+fqZnI5ePZ76ozj/z5qegZOkdtOcan/DIDOjvXYLVST8iKPfYFNEsf/JsU3nfnjR6Heu2RSbzhX/HOkP3YB0UvRkT9OGBiDYizw1fK5ztb+KsPy1W+2W8YwGOjZeFRjg7EOlqEDohHYCm96s6NnoxU6K1DcV04V8GMhYE7jHtp7QkdypGSHmJBmA6AKasITCc3o6LsSHn3HqtkwdEHW8WSyhZ8L9Z1wLVsKakFXARJIK4SDEHRFeZed267q/7ACxJRImMYZ/DhN7mOwbMzTudzp/WsSxJmnTnsuYB5MVAb5TeQjCDJ0FVZk6gr2PDKHLuwhsuA6XvqCMMTr51KOvUtGqfRUD2XXVKN+E5Sj9gKMvLu4oyyX28zUyX1xlrZYy1XEWDm85rYy/22nRYbuTQdhg0OIZnXE83ng2d3Q71o/n/k0iMicTlAz6p7/oTTbLzoRNrwuoWLZISpdoxz9a/36uFZjHMRf2mIyvTfBOMqosw6+Dc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe349a7a-00a7-452c-27fc-08dc741c869e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 13:48:24.6153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4TRFda7BFmVEG4JavrX4KbVf5DBKuRnVPBC1wRArPkMuL536gWNQZ/kQJpYmhq8qwRXIxg+rimAzoRQaPxlIyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_07,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=917 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140096
X-Proofpoint-GUID: mybh1qJbnmzBfh-CIjvDLT2FSYBL9faC
X-Proofpoint-ORIG-GUID: mybh1qJbnmzBfh-CIjvDLT2FSYBL9faC

PiBIZWxsbywNCj4gDQo+IE9uIE1vbiwgTWF5IDEzLCAyMDI0IGF0IDAyOjUzOjQxUE0gKzAyMDAs
IEjDpWtvbiBCdWdnZSB3cm90ZToNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvd29ya3F1
ZXVlLmggYi9pbmNsdWRlL2xpbnV4L3dvcmtxdWV1ZS5oDQo+IGluZGV4IDE1ODc4NGRkMTg5YWIu
LjA5ZWNjNjkyZmZjYWUgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvd29ya3F1ZXVlLmgN
Cj4gKysrIGIvaW5jbHVkZS9saW51eC93b3JrcXVldWUuaA0KPiBAQCAtMzk4LDYgKzM5OCw4IEBA
IGVudW0gd3FfZmxhZ3Mgew0KPiAJX19XUV9EUkFJTklORwkJPSAxIDw8IDE2LCAvKiBpbnRlcm5h
bDogd29ya3F1ZXVlIGlzIGRyYWluaW5nICovDQo+IAlfX1dRX09SREVSRUQJCT0gMSA8PCAxNywg
LyogaW50ZXJuYWw6IHdvcmtxdWV1ZSBpcyBvcmRlcmVkICovDQo+IAlfX1dRX0xFR0FDWQkJPSAx
IDw8IDE4LCAvKiBpbnRlcm5hbDogY3JlYXRlKl93b3JrcXVldWUoKSAqLw0KPiArCV9fV1FfTk9J
TyAgICAgICAgICAgICAgID0gMSA8PCAxOSwgLyogaW50ZXJuYWw6IGV4ZWN1dGUgd29yayB3aXRo
IE5PSU8gKi8NCj4gKwlfX1dRX05PRlMgICAgICAgICAgICAgICA9IDEgPDwgMjAsIC8qIGludGVy
bmFsOiBleGVjdXRlIHdvcmsgd2l0aCBOT0ZTICovDQo+IA0KPiBJIGRvbid0IHF1aXRlIHVuZGVy
c3RhbmQgaG93IHRoaXMgaXMgc3VwcG9zZWQgdG8gYmUgdXNlZC4gVGhlIGZsYWdzIGFyZQ0KPiBt
YXJrZWQgaW50ZXJuYWwgYnV0IG5vdGhpbmcgYWN0dWFsbHkgc2V0cyB0aGVtLiBMb29raW5nIGF0
IGxhdGVyIHBhdGNoZXMsIEkNCj4gZG9uJ3Qgc2VlIGFueSB1c2FnZXMgZWl0aGVyLiBXaGF0IGFt
IEkgbWlzc2luZz8NCg0KSGkgVGVqdW4sDQoNCg0KVGhhbmsgeW91IGZvciBzbyBxdWlja2x5IGxv
b2tpbmcgaW50byB0aGlzLiBZb3UgYXJlIHF1aXRlIHJpZ2h0LiBEdXJpbmcgcmUtYmFzaW5nLCBJ
IG1pc3NlZCBhIGh1bmsgZnJvbSBhbGxvY193b3JrcXVldWUoKSwgd2hlcmUgSSBzYW1wbGUgY3Vy
cmVudC0+ZmxhZ3MgZm9yIFBGX01BTExPQ197Tk9JTyxOT0ZTfSBiaXRzIGFuZCBzZXRzIHRoZSBj
b3JyZXNwb25kaW5nIGJpdHMgaW4gd3EtPmZsYWdzLiBGaXhlZCBpbiB2Mi4NCg0KPiBAQCAtMzE4
NCw2ICszMTg5LDEyIEBAIF9fYWNxdWlyZXMoJnBvb2wtPmxvY2spDQo+IA0KPiAJbG9ja2RlcF9j
b3B5X21hcCgmbG9ja2RlcF9tYXAsICZ3b3JrLT5sb2NrZGVwX21hcCk7DQo+ICNlbmRpZg0KPiAr
CS8qIFNldCBpbmhlcml0ZWQgYWxsb2MgZmxhZ3MgKi8NCj4gKwlpZiAodXNlX25vaW9fYWxsb2Nz
KQ0KPiArCQlub2lvX2ZsYWdzID0gbWVtYWxsb2Nfbm9pb19zYXZlKCk7DQo+ICsJaWYgKHVzZV9u
b2ZzX2FsbG9jcykNCj4gKwkJbm9mc19mbGFncyA9IG1lbWFsbG9jX25vZnNfc2F2ZSgpOw0KPiAr
DQo+IAkvKiBlbnN1cmUgd2UncmUgb24gdGhlIGNvcnJlY3QgQ1BVICovDQo+IAlXQVJOX09OX09O
Q0UoIShwb29sLT5mbGFncyAmIFBPT0xfRElTQVNTT0NJQVRFRCkgJiYNCj4gCQkgICAgIHJhd19z
bXBfcHJvY2Vzc29yX2lkKCkgIT0gcG9vbC0+Y3B1KTsNCj4gQEAgLTMzMjAsNiArMzMzMSwxMiBA
QCBfX2FjcXVpcmVzKCZwb29sLT5sb2NrKQ0KPiANCj4gCS8qIG11c3QgYmUgdGhlIGxhc3Qgc3Rl
cCwgc2VlIHRoZSBmdW5jdGlvbiBjb21tZW50ICovDQo+IAlwd3FfZGVjX25yX2luX2ZsaWdodChw
d3EsIHdvcmtfZGF0YSk7DQo+ICsNCj4gKwkvKiBSZXN0b3JlIGFsbG9jIGZsYWdzICovDQo+ICsJ
aWYgKHVzZV9ub2ZzX2FsbG9jcykNCj4gKwkJbWVtYWxsb2Nfbm9mc19yZXN0b3JlKG5vZnNfZmxh
Z3MpOw0KPiArCWlmICh1c2Vfbm9pb19hbGxvY3MpDQo+ICsJCW1lbWFsbG9jX25vaW9fcmVzdG9y
ZShub2lvX2ZsYWdzKTsNCj4gDQo+IEFsc28sIHRoaXMgbG9va3MgbGlrZSBzb21ldGhpbmcgdGhh
dCB0aGUgd29yayBmdW5jdGlvbiBjYW4gZG8gb24gZW50cnkgYW5kDQo+IGJlZm9yZSBleGl0LCBu
bz8NCg0KSXQgX2Nhbl8gYmUgZG9uZSBpbiB0aGUgd29yayBmdW5jdGlvbnMsIGJ1dCB0aGF0IHdp
bGwgYmUgYSBjb2RlIHNwcmF3bC4gT25seSBpbiBSRFMsIHdlIGhhdmUgdGhlIGZvbGxvd2luZyB3
b3JrZXIgZnVuY3Rpb25zOg0KDQpyZHNfaWJfb2RwX21yX3dvcmtlcigpOw0KcmRzX2liX21yX3Bv
b2xfZmx1c2hfd29ya2VyKCkNCnJkc19pYl9vZHBfbXJfd29ya2VyKCkNCnJkc190Y3BfYWNjZXB0
X3dvcmtlcigpDQpyZHNfY29ubmVjdF93b3JrZXIoKQ0KcmRzX3NlbmRfd29ya2VyKCkNCnJkc19y
ZWN2X3dvcmtlcigpDQpyZHNfc2h1dGRvd25fd29ya2VyKCkNCg0KYWRkaW5nIHRoZSBvbmVzIGZy
b20gaWJfY20sIHJkbWFfY20sIG1seDVfaWIsIGFuZCBtbHg1X2NvcmUsIEkgc3Ryb25nbHkgcHJl
ZmVyIHRvIGhhdmUgaXQgaW4gb25lIHBsYWNlLg0KDQoNClRoeHMsIEjDpWtvbg0KDQo=

