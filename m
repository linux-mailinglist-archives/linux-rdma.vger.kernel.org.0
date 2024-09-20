Return-Path: <linux-rdma+bounces-5018-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A349397D3D4
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 11:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E361F22722
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 09:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B086E13AA3E;
	Fri, 20 Sep 2024 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nqX7+YSi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JOmbDXdb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F541CD2C;
	Fri, 20 Sep 2024 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726825398; cv=fail; b=EnIAdIx7p4/mpcvv4m78nHsOXRcmU39u2wRuHACY/c+y7FjW3SYzx4H3wJ4BJyqE4qxwRILjeAB3uPenpQ5SPJ2MjfIrCaQ5/eUId5vLSBq8vbQPmux4onZjUSDodhA5jc6WlCaT/TAEhnX/zy8UNxU96PqMke+qlQFnUFpJtXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726825398; c=relaxed/simple;
	bh=DgRsB4o/WTZTyzxXm1COZ52KaCfF8BUbWduTiFE0oTA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IZH6+2dngWe32KpFPrbuZtsVbtq/iTuF4Ne3cXaAxcUbmmCCk2tV5y4XCaBueuDUZX+NDfzei3u4iGoISXjG6nd1ztbQO0nOUBfYpvKCaWSEmmcJL52fJ8BsXqyRUqektGGeZYiMB34bEDCCwhTMEN1ad7tDhzivsglMUVNUk+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nqX7+YSi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JOmbDXdb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48K7tYRg031849;
	Fri, 20 Sep 2024 09:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=DgRsB4o/WTZTyzxXm1COZ52KaCfF8BUbWduTiFE0o
	TA=; b=nqX7+YSiyGrEyvU4Vxx5/1jee9IskvPVr4UBlSL0ulu/UKKzlnhpPl3jk
	CKpvuJEa6+4tsFzNjMHgFi6vJP/QTdDGoPMrDgl74O79EH35kFS66TEa3XCTd5W3
	ygIix86LyJQnPc/1WdEwGu/uR3hKiL1K4Ic/WqjJouqgznqArLUO7saeWIPc5J64
	ng1LKtpHH/2S//c2g+RPDMu85VUzf0MkBzwhGLKYuoL8WneTUx+BCTRtZQo5PJi2
	GXnRecV8+S/CLWfz9m5izfU02A5cgvThhd3bcH9AAAMsLoWXAbhHQEwAtj7HkT5N
	YSCcp+mcF+3yIasWYF+dehFaNKS9Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3sd6ey9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 09:43:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48K7kvCl034165;
	Fri, 20 Sep 2024 09:43:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nycmwt24-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 09:43:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQaDT51L14Iul+5kUXOntoeUnSSSRY/jvPIWtigiyHVy3dYGSYQoaPwWBg4Amp+DoDCa2cjy6i2uo5craT8nEUP4zrRodDf4EeL0OE2+91xaVkPOYxpS13A0dyoaLKlBM0UjEZpFzpKrKhvH6MRHw0sN4tG02l7VmGrE+BH3zQDcUfn7i9U4F7pfgDEgiuogK6ozST0e+43obA8PDlyvBn9vcBVsmH3Jh/+1Efarxkz6pFhbdXlARcZ+thtyFRYG33Yl8CbzMOpnwFFX+fEvsxgB/L39O38zSfxy/tsj8qL9RP42gkx+JUujfy33ju6zcUi34MRtJhDXzsdm1FDs/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgRsB4o/WTZTyzxXm1COZ52KaCfF8BUbWduTiFE0oTA=;
 b=IN5h8M4j7jAMXf/A75ImoX4q+29+MxzIKawEOScikLHAdAinJuGV29w73xsGM8KVV3GyAQCsD7TVXWyIDeQeT3PZSWqIn8Qj3ACEMLXjppTV23Q8noV6uQXnOraqesJcGyKm1c187ns5PmtQhY6sn8bmoKwLWwRz0PGUzoDe1jlUz3BQMVnJWyBotOofWvdtX5MQizljqy2vHdUKWTpUL5dBvOZXFft4f3kVAfI49PvaRz45krIeh8DN06yEf0gu/Zyqa3mK/Huvi1XLv2//SS1tn8+NEf/IlIdf1u2mCvDEst5JYXb2taHOzqxV2/aUJswHfx9VJ5QALHKz3F0SeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgRsB4o/WTZTyzxXm1COZ52KaCfF8BUbWduTiFE0oTA=;
 b=JOmbDXdbR+YeygyKFQW9BSRsBevIwos2dRcI0voNnOSMj1Y1sRMeVIn9lXyUYPHKMaMvgy8DvibWzhKL9ZbKJLQvh0k1wkZCvk95Xm2vTJwWNgl/XwgrfoDp3qyzrgTVGIzeA6Fx9nWbWYU97uhVTJCbeYFRH7hHIFvzuINxgJ4=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by SA1PR10MB7814.namprd10.prod.outlook.com (2603:10b6:806:3a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Fri, 20 Sep
 2024 09:42:58 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f%4]) with mapi id 15.20.8005.006; Fri, 20 Sep 2024
 09:42:58 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Allison
 Henderson <allison.henderson@oracle.com>,
        "David S . Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        OFED mailing list
	<linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>
Subject: Re: [MAINLINE 2/2] rds: ib: Add Dynamic Interrupt Moderation to CQs
Thread-Topic: [MAINLINE 2/2] rds: ib: Add Dynamic Interrupt Moderation to CQs
Thread-Index: AQHbCzFu5UJz/qdHM0uI62yRCMnZUrJgbIOA
Date: Fri, 20 Sep 2024 09:42:58 +0000
Message-ID: <AAE98F7B-F556-4C9E-BB3B-3907790D801B@oracle.com>
References: <20240918083552.77531-1-haakon.bugge@oracle.com>
 <20240918083552.77531-3-haakon.bugge@oracle.com>
 <6971720d-3639-4a80-a17b-48489bfadb0a@linux.dev>
In-Reply-To: <6971720d-3639-4a80-a17b-48489bfadb0a@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|SA1PR10MB7814:EE_
x-ms-office365-filtering-correlation-id: 3a38df2b-d6c3-4c24-a9d6-08dcd9589c7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SkRqWkJWL0hUMDlPbkROQUcwaHFvb0J0QThLTWR4bE42d2YrQU0yY1ozandD?=
 =?utf-8?B?NVpsMGlPWDBRY1F2VU5OYjRrS0FibXJPOVMwMHlqMmxJSzFNblNzQ1hSZ2Fp?=
 =?utf-8?B?NU0rZGtCZlBzNnZ0bHBNUUI1enVtM2JIdkF4SzJkU29XNG4yZGtRNTRyNjNz?=
 =?utf-8?B?am55ZlRCYkhPZEtwQ1p3cG9pSldZT09Mb0tDWDRiNzE3UXNaMGh2c0JlNmJu?=
 =?utf-8?B?Qk4yUEpvczZKOGJlUjBGUnpoaEFiWXdBcmdHNGJjcUJUQnZnTE00WTZPanFO?=
 =?utf-8?B?S2NSZ09kZFFZSGI3enM2RXNJdjNkSmdtVUdlUHRqOXZWcXc0TmUzRi9sbEhk?=
 =?utf-8?B?R2pRWksxdkZKZ3NBSFdTZnlkbitUNjNzQ0d5YnkrUXBSU0F1VWk5bWJDNVJJ?=
 =?utf-8?B?MmpQRmV5YWFpWSsza1Zueld1RDV5RGZSYktjdlhwNlNYTmg3NnMyV0RZWlBL?=
 =?utf-8?B?NjlRQmlIU3dxZnp5WEJiK3lUNzRqM1BWaHB6cFprVDVXbjFaSHVHL3luSVFn?=
 =?utf-8?B?bDdQK0xtSXZVSGo4N1d1aWozNUExc0lZeDVHNnRFeGVpbEI1clJpVjhmMnQy?=
 =?utf-8?B?NXRsTEp3ZmhMUmEvU3dtK0lJM0Z2UnJRa1QrZkRaSnBZMFQ3ZnA0RmxIYVdW?=
 =?utf-8?B?cDBMdTM5MWt0aFAxbW5vTEl6KzlTQmJ4QUREY2hOZXNRVWppTmlDWHRJRTZE?=
 =?utf-8?B?MUt1T1ZQQ2F1amlTeUF1T2Zra05GdVBGOUY4WjlZT2w4MTJ2dDIwS1JWbldu?=
 =?utf-8?B?OUI1SGVmVUdnQkF6b0JLbzhybStlNmorQ3V2dm9hMlZIc0YxVEw0V0U1SEEv?=
 =?utf-8?B?OVNNQ0pDYkpESTd3ZXVrZTRkcDdkV0c1UFE5TFN4alpML3dQZ0dhV2JUSVBM?=
 =?utf-8?B?d1o2MGJXaVNOQ1RQa2ptTjZwSWxhZzNqK2E0eG9LWjV2d3RTWFVEYlNZUndX?=
 =?utf-8?B?c3NackNMWmFtVXlwcGIwb09uY2ZMa3ZWSkhLOGxHZEI1bnlFOWNwOFFiMUND?=
 =?utf-8?B?Qjc1WWs5WGw1NDlFRVZMYUt1TlZoVVI3b2NQMXhBWnRFcm5rR09xOC9VeFhT?=
 =?utf-8?B?WVhHSEt1ZXhQOUxGUEV1aTMvZEpQYjcwT3lKZzZER1ZhV3dGaTNxeHJ5L081?=
 =?utf-8?B?SWFPWk5Ycm41Y21NdHlCVDhzZXhkRVY1Y1VYNWN6RzhlTzVkTWhYbUJMUENP?=
 =?utf-8?B?cXZFem5MRkszMlI2Y0tPZHJCS3lOTTZlK01pMVJQZEVqUmFhZG03UG5hamR2?=
 =?utf-8?B?bzY2RG9OeWxtSHZjTVZXMlBlbVI4NlFFb21vcDVIbFEreVlIMi9TaVRZbDZ0?=
 =?utf-8?B?OW5Qblhwdi9iOUVzWXRXOGlCWjVMVlBuVTRQQmlTL2lBWWYrQUpEUmw3TjBt?=
 =?utf-8?B?VTNKQXhndTNiUFpOSFpsbW5tc3RhZUVLclNoeDc4QmpUanJEVHd1SGVBamxR?=
 =?utf-8?B?V3JsUEZ5V0xyL1B0UGZvbFFnNzQrUFp6SmNMS3ZXQXF3ZVA0UFVWVUFnYXAx?=
 =?utf-8?B?QnMvWmhyT3ppcEhZWEF3S0hlN3BQRFllZnd3T09vL0trUjM2NkdLKzlpRnBM?=
 =?utf-8?B?NXp4SkJRWlVnazFTbkkrVVpmMnNYSVEyZ0M0b2FuM1VTVldlRjNpR1lSUU5N?=
 =?utf-8?B?bXVyYitQMXB3LzhDbVBTSkkzbjZUY3BxMFFVQzhYSzlFZ3kxeUZUZHFXMHN6?=
 =?utf-8?B?WGtuVkgxTlNpU1BLdDVQUDJldDFObFpRRzhLanJFVHpRaHNlN2NuMzl6NUlU?=
 =?utf-8?B?ek4weHdoRGxNcTIwV29NdWdreXl3M05PWjJUSTdEa1h6Z2RTUWFBU2FDalFs?=
 =?utf-8?B?ZitqTExwNkw5aTJjWHVQZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2U2dzArSi9idW5WTFloVVNITFhnazVBWW1LY3lUb0ZuMGdMY2JlTWlkRTdR?=
 =?utf-8?B?U2xJODl6OGpCY2h0bEFrWVQvcUZtYlJVN0hENFB3NUNFTDVtazM1akxDWU1r?=
 =?utf-8?B?c1RrMmw4bkM0Mk5zV1NpTU4vRFAxUG8waTlqUGNrQnVZQmZySzJnUUJRZ0tu?=
 =?utf-8?B?WnozOE1kMStjSnlrZWdNQWpGK0oxSVoxeTRNVlpUZWZFVkF3dmNBSzMwTFgy?=
 =?utf-8?B?eDg4STdjL1dZTXd3UElYVmVraVBGZlVOSlJJMDQ1S2dSQ2xveHNkRkhiZjQr?=
 =?utf-8?B?MlhhQVZDM045eFdXdkgySTJqMW5TK3o1VXd3dWNZZmF0OGdkcXV2UkpqQmts?=
 =?utf-8?B?WUZyTE1iNnUxaVhGekgyNU43NHlJblZZSndGTENJRTg4MHN3VEdGNkNGbFRv?=
 =?utf-8?B?d00wQ1ZsWmEzVXlYSHdxVnNSOWdLUG14NHc0bFpZdVBzRHJPeDNiY0hFWGdm?=
 =?utf-8?B?N2hIcklaWnpXWmxwbHlabkdDL1orY2Q3STExTHJaT05BMjJYcjdoUVdQMWFZ?=
 =?utf-8?B?V1hnWDJRMkVnSE80cGxDK2psS0dVTlhpR3ZOZmJBMTBtc2VTeDgybzFZN2Zr?=
 =?utf-8?B?RmNuNWxnamQ5MnM0aWRaSy8vQ054MW4rL0FlUVRLaHNvMThGR2Z5Y1g0SlIy?=
 =?utf-8?B?Zlk1WnZSb3ExdUg3bVZqUmZCRkFCSGRHWi9xblRzMzk0cGF1U0F3OHhYZzNR?=
 =?utf-8?B?RmpwMWk1VVV4Z2FyNDNmTktMcFRsMHAwMURzamxDWWlnNk5WemVQTmxDK0pq?=
 =?utf-8?B?RXdSa0tJeVVQNDVlWlBsMVNkRGdybUtXTWcrUlY4K1VBWGFLczljc0FYVHVh?=
 =?utf-8?B?anZSNEdYWDhGcVN3dVdqRENHb0pIQ1d3T0I4dWo4SFVsQ0Y3TzhhQ21nNUM3?=
 =?utf-8?B?ZllGNG5LbGF1TC9qY2hsVXIvUGZtVTAyazk1WU9GMnJ0VkJKOHFzcStqOVBk?=
 =?utf-8?B?QTBmSDlUaGFtaUJwbW5xNjRFY0Z2K3gwUmErQmRkUlNNZUVJVHRoVFV5blpH?=
 =?utf-8?B?RjNialorQWt3RTZFTkViOG0xakdIbkc4bmRJcTJ5OVlOWGxDeEI0SVc2U0Fa?=
 =?utf-8?B?SldpYjdzVGo1QW5nUkMyaTJ0aER4US93NVBlVEpPL0lZNzBDUDNJQU9IS2Qr?=
 =?utf-8?B?Y29Sdkd5aHp6emtLeFRMN2JNa2FIWGRDYzU4TG1SYUNaZWRXckNDYjFURCtD?=
 =?utf-8?B?dkdjdFNLRWVjRXcxdzdEVFJDU3J6ZURISXp3cndyUEY2WHByN3BhSFMvU1Yy?=
 =?utf-8?B?RWpma0VVd3kxU2owNE8zL2ZIOE9TdkxncXdEWWgxdi9tOGdrUjdpbjhPbFFS?=
 =?utf-8?B?NE8zTGY1ZlU5NTVGOFN4dlJUcnRKOStCc2dHdTZmRVdOQkR6VkhBS2RyQlFJ?=
 =?utf-8?B?ZStBRzM0VFZuRVJERVFJRWJqWktGRkZSeW80bE1iWGhINWZtNzg3N0pIMDlU?=
 =?utf-8?B?UjlpQmoyOURkV0wrZVJCdUNFVnd2NElMSCtST2wxTmwzUDJ6eGFIZzk3c1k2?=
 =?utf-8?B?ajVDd2ovcUlKM2lweUtqMEt4cFI2WEd2bXlWYmg3VVVzQzkzakhwTUhkbEdK?=
 =?utf-8?B?WWJYbXNaODJoT09sNStRSE9XN2QwaVlzcXhuNjBNcHNxc0RQZDRsSkx2WnlG?=
 =?utf-8?B?Ri9wN0JRRzkzNWY0K2JYZS84K0NMYVVjVmRCcEptS1NZK1pWUHRHa1g3UFc5?=
 =?utf-8?B?aFNxdm55WDBFTU5nanNpa2x6eFNxVXB6WWh6WUJ0WVdmUjRLOUhhTWZmTTNI?=
 =?utf-8?B?aGc4VVU0WDJ0NHN6c1ZGcjZva09NZHRPdnpvWUtBM09WQitTbkV2SUFZVzRI?=
 =?utf-8?B?NjhLSFJrREZ5ZmMxYUx5Szd6aVYwQldsVEx5RDFHdVNDSWh2U29GeWxvaHg4?=
 =?utf-8?B?VEkzeUxOZVRqSkRLUUVDd0J6d3ptc1hUOHFqS1dUR1JwTDRiVGlVQVd0c1B2?=
 =?utf-8?B?eW5EbkJNSWhBYmxiOTN2SUQ5Y2tXYzlvYnFzcEhPL1RvL01OcE5DalZVeFZx?=
 =?utf-8?B?MHNSZUNkZ1ZuVXlwYVVxN1ZQdjlndzh5UStPWnBkbVZEWW5VNllYbkdXc0dk?=
 =?utf-8?B?Y0VGWk11YThka2Q0S2tsb0NLamxBZUxFRU5ET3VjVE0vc0VUS3lGRjdPQlpW?=
 =?utf-8?B?bW8zcXpKWlhmSXZhRTNCaWVWWWFHZ3ZnazQ0MG9uRzVKQmt5SW1NQ0tHVmM3?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFBDA6BB68C4584D899959D51966D2C4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BEisxe1TFBKaL74/HS+QGDQuEgH1C7W5qK1pQyt2BBRUQt0628NvscGSA1J1yb0aM3mXv8+5ccYinraatb2ELVGnHIm/ECD25oNs0QkC44F2I5PTdXmquvChSeg04PThiWkSWAFnoPW0IkcW1Q+vYO/zdOJ4zaJZT2tAUDaRJVhk9Vb2a9xugRnCEYqQxCXhKmEQiZXSyOdhjNg7wLHvckNmGl0it/6WCX34TMWUeubz6rQw6PyhyQaOSrNODmC5SeKmnZdN7Q9fFbrku2GnEHLG1ZeFTWzvy2up5Y09nSyww4RD3M/eM2Sa+O7So55FriTWIZgzFycyZPsEGuNsM10L9RHCMy/ZFnw6QA33saNJ9pJLrDhrsDN5S2dNGuShFMxUo6iPZOPyWhivpFWY3fYZe+hnxpLgIoOjkqsAnJNCpUwgcSg1LAw40qmsqzSWezTXpfp5rgIWsdww9izrpdRIiWAmDKbtNBJao40WfrAIxGCbtX5/QeOfdF3bsXy3Oyj1PW7D6R/JqfXoa8bV8IiR6mW7wrCjIc0808+6ffVYyzAw647jGj4CMv0+c/UiPCug+9db1B0u7lXTF9dOhP9upaUYsH/dBfcnXl/KFCg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a38df2b-d6c3-4c24-a9d6-08dcd9589c7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 09:42:58.4484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 07wyzzmNO5g8P8qxJB95EUAMBbBls93mhk7ebqhaFAzMQwkff10Rub56uzO9mhkUPfqqExZR2gXMSSG64Jnn3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_04,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409200069
X-Proofpoint-ORIG-GUID: z4RvS_SorkJkIXvSdl9AnKzJgiVIui57
X-Proofpoint-GUID: z4RvS_SorkJkIXvSdl9AnKzJgiVIui57

DQoNCj4gT24gMjAgU2VwIDIwMjQsIGF0IDA5OjQ3LCBaaHUgWWFuanVuIDx5YW5qdW4uemh1QGxp
bnV4LmRldj4gd3JvdGU6DQo+IA0KPiDlnKggMjAyNC85LzE4IDE2OjM1LCBIw6Vrb24gQnVnZ2Ug
5YaZ6YGTOg0KPj4gV2l0aCB0aGUgc3VwcG9ydCBmcm9tIGliX2NvcmUgdG8gdXNlIER5bmFtaWMg
SW50ZXJydXB0IE1vZGVyYXRpb24NCj4+IChESU0pIGZyb20gbGVnYWN5IFVMUHMsIHdoaWNoIHVz
ZXMgaWJfY3JlYXRlX2NxKCksIHdlIGVuYWJsZSB0aGF0DQo+PiBmZWF0dXJlIGZvciB0aGUgcmVj
ZWl2ZSBhbmQgc2VuZCBDUXMgaW4gUkRTLg0KPiANCj4gSGksIEhhYWtvbg0KPiANCj4gSSBhbSBp
bnRlcmVzdGVkIGluIHRoaXMgcGF0Y2ggc2VyaWVzLiBJIGp1c3Qgd29uZGVyIGlmIHRoZSBwZXJm
b3JtYW5jZSBvZiByZHMgaXMgaW5jcmVhc2VkIGFmdGVyIERJTSBpcyB1c2VkIGluIGxlZ2FjeSBV
TFBzPw0KPiBUaGF0IGlzLCBpcyB0aGVyZSBhbnkgYmVuZWZpdCB0byBsZWdhY3kgVUxQcyBhZnRl
ciBESU0gaXMgdXNlZD8NCj4gDQo+IERvIHlvdSBoYXZlIGFueSB0ZXN0IHJlc3VsdHMgYWJvdXQg
dGhpcyBESU0/DQoNClllcywgcGxlYXNlIHNlZSB0aGUgY292ZXIgbGV0dGVyIG9mIHRoaXMgY29t
bWl0Lg0KDQoNClRoeHMsIEjDpWtvbg0KDQo+IA0KPiBUaGFua3MsDQo+IFpodSBZYW5qdW4NCj4g
DQo+PiBBIHNldCBvZiByZHMtc3RyZXNzIHJ1bnMgaGF2ZSBiZWVuIGRvbmUuIGJjb3B5IHJlYWQg
KyB3cml0ZSBmb3INCj4+IHBheWxvYWQgODQ0OCBhbmQgMTY2NDAgYnl0ZXMgYW5kIGFjay9yZXEg
b2YgMjU2IGJ5dGVzLiBOdW1iZXIgb2YgUVBzDQo+PiB2YXJpZXMgZnJvbSA4IHRvIDEyOCwgbnVt
YmVyIG9mIHRocmVhZHMgKGkuZS4gcmRzLXN0cmVzcyBwcm9jZXNzZXMpDQo+PiBmcm9tIG9uZSB0
byAxNiBhbmQgYSBkZXB0aCBvZiBmb3VyLiBBIGxpbWl0IGhhcyBiZWVuIGFwcGxpZWQgc3VjaCB0
aGF0DQo+PiB0aGUgbnVtYmVyIG9mIHByb2Nlc3NlcyB0aW1lcyB0aGUgbnVtYmVyIG9mIFFQcyBu
ZXZlciBleGNlZWRzIDEyOC4gQWxsDQo+PiBpbiBhbGwsIDYxIHJkcy1zdHJlc3MgcnVucy4NCj4+
IEZvciBicmV2aXR5LCBvbmx5IHRoZSByb3dzIHNob3dpbmcgYSArLy0gMyUgZGV2aWF0aW9uIG9y
IGxhcmdlciBmcm9tDQo+PiBiYXNlIGlzIGxpc3RlZC4gVGhlIGdlb21ldHJpYyBtZWFuIG9mIHRo
ZSByYXRpb3MgKElPUFNfdGVzdCAvDQo+PiBJT1BTX2Jhc2UpIGlzIGNhbGN1bGF0ZWQgZm9yIGFs
bCA2MSBydW5zLCBhbmQgdGhhdCBnaXZlcyB0aGUgYmVzdA0KPj4gcG9zc2libGUgImF2ZXJhZ2Ui
IGltcGFjdCBvZiB0aGUgY29tbWl0cy4NCj4+IEluIHRoZSBmb2xsb3dpbmcsICJiYXNlIiBpcyB2
Ni4xMS1yYzcuICJ0ZXN0IiBpcyB0aGUgc2FtZQ0KPj4ga2VybmVsIHdpdGggdGhlIGZvbGxvd2lu
ZyB0d28gY29tbWl0czoNCj4+ICAgICAgICAqIHJkczogaWI6IEFkZCBEeW5hbWljIEludGVycnVw
dCBNb2RlcmF0aW9uIHRvIENRcyAodGhpcyBjb21taXQpDQo+PiAgICAgICAgKiBSRE1BL2NvcmU6
IEVuYWJsZSBsZWdhY3kgVUxQcyB0byB1c2UgUkRNQSBESU0NCj4+IFRoaXMgaXMgZXhlY3V0ZWQg
YmV0d2VlbiB0d28gWDgtMiB3aXRoIENYLTUgdXNpbmcgZncgMTYuMzUuMzUwMi4gVGhlc2UNCj4+
IEJNIHN5c3RlbXMgd2VyZSBpbnN0YW50aWF0ZWQgd2l0aCBvbmUgVkYsIHdoaWNoIHdlcmUgdXNl
ZCBmb3IgdGhlDQo+PiB0ZXN0Og0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
YmFzZSAgICAgdGVzdA0KPj4gICAgQUNLICAgIFJFUSAgUVBTICBUSFIgIERFUCAgICAgSU9QUyAg
ICAgSU9QUyAgUGVyY2VudA0KPj4gICAgMjU2ICAgODQ0OCAgICA4ICAgIDEgICAgNCAgIDYzNDQ2
MyAgIDY1ODE2MiAgICAgIDMuNw0KPj4gICAgMjU2ICAgODQ0OCAgICA4ICAgIDIgICAgNCAgIDg2
MjY0OCAgIDk5NzM1OCAgICAgMTUuNg0KPj4gICAgMjU2ICAgODQ0OCAgICA4ICAgIDQgICAgNCAg
IDk1MDQ1OCAgMTExMzk5MSAgICAgMTcuMg0KPj4gICAgMjU2ICAgODQ0OCAgICA4ICAgIDggICAg
NCAgIDkzMjEyMCAgMTEyNzAyNCAgICAgMjAuOQ0KPj4gICAgMjU2ICAgODQ0OCAgICA4ICAgMTYg
ICAgNCAgIDk0NDk3NyAgMTEzMzg4NSAgICAgMjAuMA0KPj4gICA4NDQ4ICAgIDI1NiAgICA4ICAg
IDIgICAgNCAgIDg1ODY2MyAgIDk3NTU2MyAgICAgMTMuNg0KPj4gICA4NDQ4ICAgIDI1NiAgICA4
ICAgIDQgICAgNCAgIDkzNDg4NCAgMTA5ODg1NCAgICAgMTcuNQ0KPj4gICA4NDQ4ICAgIDI1NiAg
ICA4ICAgIDggICAgNCAgIDkyODI0NyAgMTExNjAxNSAgICAgMjAuMg0KPj4gICA4NDQ4ICAgIDI1
NiAgICA4ICAgMTYgICAgNCAgIDkzODg2NCAgMTEyMzQ1NSAgICAgMTkuNw0KPj4gICAgMjU2ICAg
ODQ0OCAgIDY0ICAgIDEgICAgNCAgIDk2NTk4NSAgIDkxODQ0NSAgICAgLTQuOQ0KPj4gICA4NDQ4
ICAgIDI1NiAgIDY0ICAgIDEgICAgNCAgIDk2MzI4MCAgIDkxODIzOSAgICAgLTQuNw0KPj4gICAg
MjU2ICAxNjY0MCAgICA4ICAgIDIgICAgNCAgIDU0NDY3MCAgIDU4MjMzMCAgICAgIDYuOQ0KPj4g
ICAgMjU2ICAxNjY0MCAgICA4ICAgIDQgICAgNCAgIDU1NDg3MyAgIDU5NzU1MyAgICAgIDcuNw0K
Pj4gICAgMjU2ICAxNjY0MCAgICA4ICAgIDggICAgNCAgIDU1MTc5OSAgIDU5NzQ3OSAgICAgIDgu
Mw0KPj4gICAgMjU2ICAxNjY0MCAgICA4ICAgMTYgICAgNCAgIDU1MzA0MSAgIDU5Nzg5OCAgICAg
IDguMQ0KPj4gIDE2NjQwICAgIDI1NiAgICA4ICAgIDIgICAgNCAgIDU0NDY0NCAgIDU3ODMzMSAg
ICAgIDYuMg0KPj4gIDE2NjQwICAgIDI1NiAgICA4ICAgIDQgICAgNCAgIDU1Mzk0NCAgIDU5NDYy
NyAgICAgIDcuMw0KPj4gIDE2NjQwICAgIDI1NiAgICA4ICAgIDggICAgNCAgIDU1MTM4OCAgIDU5
NDczNyAgICAgIDcuOQ0KPj4gIDE2NjQwICAgIDI1NiAgICA4ICAgMTYgICAgNCAgIDU1Mjk4NiAg
IDU5NjU4MSAgICAgIDcuOQ0KPj4gR2VvbWV0cmljIG1lYW4gb2YgcmF0aW9zOiAxLjAzDQo+PiBT
aWduZWQtb2ZmLWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPg0KPj4g
LS0tDQo+PiAgbmV0L3Jkcy9pYl9jbS5jIHwgMTAgKysrKysrKysrKw0KPj4gIDEgZmlsZSBjaGFu
Z2VkLCAxMCBpbnNlcnRpb25zKCspDQo+PiBkaWZmIC0tZ2l0IGEvbmV0L3Jkcy9pYl9jbS5jIGIv
bmV0L3Jkcy9pYl9jbS5jDQo+PiBpbmRleCAyNmIwNjllMTk5OWRmLi43OTYwM2Q4NmI2YzAyIDEw
MDY0NA0KPj4gLS0tIGEvbmV0L3Jkcy9pYl9jbS5jDQo+PiArKysgYi9uZXQvcmRzL2liX2NtLmMN
Cj4+IEBAIC0yNTksNiArMjU5LDcgQEAgc3RhdGljIHZvaWQgcmRzX2liX2NxX2NvbXBfaGFuZGxl
cl9yZWN2KHN0cnVjdCBpYl9jcSAqY3EsIHZvaWQgKmNvbnRleHQpDQo+PiAgc3RhdGljIHZvaWQg
cG9sbF9zY3Eoc3RydWN0IHJkc19pYl9jb25uZWN0aW9uICppYywgc3RydWN0IGliX2NxICpjcSwN
Cj4+ICAgICAgIHN0cnVjdCBpYl93YyAqd2NzKQ0KPj4gIHsNCj4+ICsgaW50IG5jb21wbGV0ZWQg
PSAwOw0KPj4gICBpbnQgbnIsIGk7DQo+PiAgIHN0cnVjdCBpYl93YyAqd2M7DQo+PiAgQEAgLTI3
Niw3ICsyNzcsMTAgQEAgc3RhdGljIHZvaWQgcG9sbF9zY3Eoc3RydWN0IHJkc19pYl9jb25uZWN0
aW9uICppYywgc3RydWN0IGliX2NxICpjcSwNCj4+ICAgcmRzX2liX21yX2NxZV9oYW5kbGVyKGlj
LCB3Yyk7DQo+PiAgICAgfQ0KPj4gKyBuY29tcGxldGVkICs9IG5yOw0KPj4gICB9DQo+PiArIGlm
IChjcS0+ZGltKQ0KPj4gKyByZG1hX2RpbShjcS0+ZGltLCBuY29tcGxldGVkKTsNCj4+ICB9DQo+
PiAgICBzdGF0aWMgdm9pZCByZHNfaWJfdGFza2xldF9mbl9zZW5kKHVuc2lnbmVkIGxvbmcgZGF0
YSkNCj4+IEBAIC0zMDQsNiArMzA4LDcgQEAgc3RhdGljIHZvaWQgcG9sbF9yY3Eoc3RydWN0IHJk
c19pYl9jb25uZWN0aW9uICppYywgc3RydWN0IGliX2NxICpjcSwNCj4+ICAgICAgIHN0cnVjdCBp
Yl93YyAqd2NzLA0KPj4gICAgICAgc3RydWN0IHJkc19pYl9hY2tfc3RhdGUgKmFja19zdGF0ZSkN
Cj4+ICB7DQo+PiArIGludCBuY29tcGxldGVkID0gMDsNCj4+ICAgaW50IG5yLCBpOw0KPj4gICBz
dHJ1Y3QgaWJfd2MgKndjOw0KPj4gIEBAIC0zMTYsNyArMzIxLDEwIEBAIHN0YXRpYyB2b2lkIHBv
bGxfcmNxKHN0cnVjdCByZHNfaWJfY29ubmVjdGlvbiAqaWMsIHN0cnVjdCBpYl9jcSAqY3EsDQo+
PiAgICAgcmRzX2liX3JlY3ZfY3FlX2hhbmRsZXIoaWMsIHdjLCBhY2tfc3RhdGUpOw0KPj4gICB9
DQo+PiArIG5jb21wbGV0ZWQgKz0gbnI7DQo+PiAgIH0NCj4+ICsgaWYgKGNxLT5kaW0pDQo+PiAr
IHJkbWFfZGltKGNxLT5kaW0sIG5jb21wbGV0ZWQpOw0KPj4gIH0NCj4+ICAgIHN0YXRpYyB2b2lk
IHJkc19pYl90YXNrbGV0X2ZuX3JlY3YodW5zaWduZWQgbG9uZyBkYXRhKQ0KPj4gQEAgLTU0Miw2
ICs1NTAsNyBAQCBzdGF0aWMgaW50IHJkc19pYl9zZXR1cF9xcChzdHJ1Y3QgcmRzX2Nvbm5lY3Rp
b24gKmNvbm4pDQo+PiAgIGljLT5pX3NjcV92ZWN0b3IgPSBpYmRldl9nZXRfdW51c2VkX3ZlY3Rv
cihyZHNfaWJkZXYpOw0KPj4gICBjcV9hdHRyLmNxZSA9IGljLT5pX3NlbmRfcmluZy53X25yICsg
ZnJfcXVldWVfc3BhY2UgKyAxOw0KPj4gICBjcV9hdHRyLmNvbXBfdmVjdG9yID0gaWMtPmlfc2Nx
X3ZlY3RvcjsNCj4+ICsgY3FfYXR0ci5mbGFncyB8PSBJQl9DUV9NT0RFUkFURTsNCj4+ICAgaWMt
Pmlfc2VuZF9jcSA9IGliX2NyZWF0ZV9jcShkZXYsIHJkc19pYl9jcV9jb21wX2hhbmRsZXJfc2Vu
ZCwNCj4+ICAgICAgIHJkc19pYl9jcV9ldmVudF9oYW5kbGVyLCBjb25uLA0KPj4gICAgICAgJmNx
X2F0dHIpOw0KPj4gQEAgLTU1Niw2ICs1NjUsNyBAQCBzdGF0aWMgaW50IHJkc19pYl9zZXR1cF9x
cChzdHJ1Y3QgcmRzX2Nvbm5lY3Rpb24gKmNvbm4pDQo+PiAgIGljLT5pX3JjcV92ZWN0b3IgPSBp
YmRldl9nZXRfdW51c2VkX3ZlY3RvcihyZHNfaWJkZXYpOw0KPj4gICBjcV9hdHRyLmNxZSA9IGlj
LT5pX3JlY3ZfcmluZy53X25yOw0KPj4gICBjcV9hdHRyLmNvbXBfdmVjdG9yID0gaWMtPmlfcmNx
X3ZlY3RvcjsNCj4+ICsgY3FfYXR0ci5mbGFncyB8PSBJQl9DUV9NT0RFUkFURTsNCj4+ICAgaWMt
PmlfcmVjdl9jcSA9IGliX2NyZWF0ZV9jcShkZXYsIHJkc19pYl9jcV9jb21wX2hhbmRsZXJfcmVj
diwNCj4+ICAgICAgIHJkc19pYl9jcV9ldmVudF9oYW5kbGVyLCBjb25uLA0KPj4gICAgICAgJmNx
X2F0dHIpOw0KPiANCg0K

