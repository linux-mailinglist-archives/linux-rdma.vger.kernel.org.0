Return-Path: <linux-rdma+bounces-9247-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D47A3A80BAD
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 15:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02C2D7A46E4
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 13:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB0FC148;
	Tue,  8 Apr 2025 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cmc6AG09";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WPILbQ0c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A523CA5A;
	Tue,  8 Apr 2025 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118270; cv=fail; b=DVKCQnHmjA4bdU9Gbn20xT09Ol56PmIl+QGvtiRGAYh2N9islKnlm+KGr3POwUKspdTzr7pntI0R38VF78P9LYClDcPH/t+Y5JEp3G1PVHbf/4y805116Pmsgy7eLxPy0NZzzA4ytKz7PAFFlCA3q25QX47AdZdVoKC+U8QIk78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118270; c=relaxed/simple;
	bh=Kz/CyXM+3/rlgfVkK2h/0Gu3iNSJF6ZdPhDy7mH+ZGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nWjYiFbSJRnAT33vvHbS3kR7cjq788dtDeV9XhVjw7yea+HFGy9K26MSzjbBt1TRqYStoiIUDMlzawgA6Q0E0c0iWVGyX0NmddHNEoiOUOfXltYSs9pSvcW09SYms7uyfYGcTfK/CAiWwM2Ofo2/lmr9KXgkGJnRw9Y+3mGsEJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cmc6AG09; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WPILbQ0c; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538C6jST011246;
	Tue, 8 Apr 2025 13:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Kz/CyXM+3/rlgfVkK2h/0Gu3iNSJF6ZdPhDy7mH+ZGU=; b=
	cmc6AG09bwNN2skugf+tqpu3cM343Q2l/23Z+Br7klC03k8vWlmPj9yr1Dk3XMsX
	QZOGY247z2+B/l6z419jwe8SuX2xpX7/XW9RhAKDjPPS4Yb1PVQarI85HYueK24Q
	haNtBD9O7lG4J4oqs37jjdiSLJTYVDyXnHNhcRRv5l6pjlUMj0aldeVPeQEgznSP
	yNvpkHjMJVOJ6u/0BoLhZdHTJSf82wUeEFtARG8amBpHuvWVIhiRQuCxRzoEXvdv
	FSSUJomvMl95qx6mteADKY6HXtOkJpGZDsFTtCcIJDewlZDo/c2rl2MIPQv9ImLS
	xKPXTBOKqHMQh5xW+VbSXQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45ttxcvqb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 13:17:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 538CHZrW001830;
	Tue, 8 Apr 2025 13:17:42 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012037.outbound.protection.outlook.com [40.93.1.37])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45tty999ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 13:17:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFvZhaf9n0trbcXPaWebdAAAID497X+Pp6DKt2v5D37bielvq/DHZKgyOP+IGnTWdKayHrUzzm/gRCjMRnfDcf0V9q+IzMIltvtBO7cUMFFT/zLAN39vEoleGMHHFmmDm4VlT4kb1ipvFBv12Yq8srcIjITRxWZzHVSw0ncXlw9VVaWCj6SN/Tu1wRAmLZlcajunjoVRvjkO18ZONYl8ILFqrxL4VKREf0iXn8+ABoH9V38eo4VlH115dgmk9xjW51ip+/7LYU7jKY/QHoyY/+aw7gVDjo0Fp+Zj8KlbfSxAV+O/nQ2HnnoFMEm/r3M2tehZj+67UZ/+hSQK21YZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kz/CyXM+3/rlgfVkK2h/0Gu3iNSJF6ZdPhDy7mH+ZGU=;
 b=bX34WU3+yNVy43UZwG9cbDMx8KPAbw2ZQbjLO4pXga5zaD1lyi18e45yus5XZgTkHE3JwVWdUM1UcR+6fKXjglrcbIUf3xtu0EVrRUwhqC7DX+y/LfhiAv6hMfEIwEaQr4gLCsZ4MPBH+RNZ5ABAiHAMsKOSw/QOQna5euExSeHM8z5wX3Lyjd1zUix6Bui1C0Rcy4ECrvqSJZ3UkGvASjJe0wb4fRvrjN82+BG/0Nnb+W9bIcXGJXzML6VxmOp95lZ/BPdR17dWsP/CN/Z+RefuvDk5iBYAdSfLQwYcuxwwUQ8k1pKLaxIj7mKl0W0mdKO2MTp1pg0rhrKQw+q5jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kz/CyXM+3/rlgfVkK2h/0Gu3iNSJF6ZdPhDy7mH+ZGU=;
 b=WPILbQ0cvc+1GygwNROvMZJdOWHhb9Q/FnXyqNgXjvcFGWt3x5ZZHZzBpDqWjg87g3pWfUbbRgXzboiioOEejJJkSo0EGSwD5dPS2THkAJ9LuG8FIgowlf0GtiaqBl9Zcl4ufbAqXzJtNH5/e5ZAjiCjBkPkeWa+dGDUByv4/qI=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by BN0PR10MB4933.namprd10.prod.outlook.com (2603:10b6:408:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 13:17:40 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 13:17:39 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Sharath Maddibande Srinivasan <sharath.srinivasan@oracle.com>
CC: Leon Romanovsky <leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "phaddad@nvidia.com" <phaddad@nvidia.com>,
        "markzhang@nvidia.com"
	<markzhang@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Aron Silverton
	<aron.silverton@oracle.com>
Subject: Re: [PATCH v2] RDMA/cma: Fix workqueue crash in
 cma_netevent_work_handler
Thread-Topic: [PATCH v2] RDMA/cma: Fix workqueue crash in
 cma_netevent_work_handler
Thread-Index: AQHbnpLTSMP3q8c/XE6H5pf1rQl6jrOZ1AKA
Date: Tue, 8 Apr 2025 13:17:39 +0000
Message-ID: <D90F918E-A69B-434C-9593-D1E253F150F4@oracle.com>
References: <bf0082f9-5b25-4593-92c6-d130aa8ba439@oracle.com>
In-Reply-To: <bf0082f9-5b25-4593-92c6-d130aa8ba439@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.400.131.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|BN0PR10MB4933:EE_
x-ms-office365-filtering-correlation-id: 78508acc-1392-4020-52b0-08dd769fbcdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M0FmdzF4VWJWeGR6c0NUSmQxbGJpOTlDWVFDZStrQWxJd1hYZnBOc0lnOUhN?=
 =?utf-8?B?U0FGeHR6a1hNcHhyQ0VoTmJvOHF5cnFZMUJJcDd6dDlPVUZwRkJYZnNKWjNp?=
 =?utf-8?B?eDR1S0RRQXN4YWFXU2VjRFdlUVBqMVNPZEZPWmpXenJZWUZyc25jZ2R5QWZt?=
 =?utf-8?B?WlU0eEFaTndualFUUUpKZWFJQTA3U1VzWERDblk2VXAzQjFrMjJzMndQbGFI?=
 =?utf-8?B?SkxsTUc5dS9BTWE3T3JzOFU5NDdWT1NZQjZTV29qSzlabFpPMmt1bklpVkwz?=
 =?utf-8?B?dzRaT0JlU1RWeTcyL0JNeVEyNGVDUGxGcnZzT0tGaXBzMlVQTjBGbGVxRGND?=
 =?utf-8?B?OFFyL1JobUUxaWlHU0VVeTJZbkFxbWlaamlYTE1sODU5TmtYdEkwc3FqNGs0?=
 =?utf-8?B?UzQ3ZGhPY2ZUeVcydW9GSENZSlh3cGpYa2c3ZmtmWDJhMUZTcW1uWkdHWjJJ?=
 =?utf-8?B?M0Fubnlqayt1YTlwdWdRelFVS1JSaGtkT0szczlJRTlQbytSN2kwdFpMeExX?=
 =?utf-8?B?a3FNaFVaWkdhUFlRTDZxb1lhN3RQM3pZREpDQTh5eGt1TUtzY0U2ZVdoUGg4?=
 =?utf-8?B?aE51WVRNc3U3T09TL05wSGgyajZsTjEvVTF0bVN0aTFKQ1BLZWptc1hDcUY1?=
 =?utf-8?B?ZE43bWh3SnlxdEFSd08xMHh4NFVwNTZYWnprSno2TlhaTjlEZExQTFRjYXZZ?=
 =?utf-8?B?NE4vb3Ftcko4OFZ0a0QyNjgwbnRJNk9LQnVsTmpBUWsvcjRMZkJURXU0aFU1?=
 =?utf-8?B?VTh1TzZKVGdjaFpEVnFBSHhGYlRNU3B3bjg4ZUVNUnl3N1ZXNGZ0bFAxTFFK?=
 =?utf-8?B?ZVV5SVg1dHZ6dllVbWpOOFZkT2xqYXdYTDNaTnJCd0Q0eUhSVUpWa0pDRTlp?=
 =?utf-8?B?VTFINS9FYjBPaUtsTzB5eVR6aDdTbklyKzY4TDlFNkhXaWRFdWhnT3RmdFF1?=
 =?utf-8?B?dW5VanFNVFp6cmFXVC9jNHFmcExCR0lUdGlaeVFEeTNTL1FlQjIyb2ppZXJ5?=
 =?utf-8?B?T1RwK0hUU0VsVmxkOG1ySW9TQXF3ZnBjUWVCMWpjM1VSR2dncjh2V2s5WEIx?=
 =?utf-8?B?cmV1bG51dGJZRkpubG9KZVVwOHU3NlJoK0VOdzlFbVJSaTFXa0tsNUZSWWNP?=
 =?utf-8?B?MkhjSEtHOWpCK1dyUVBGYkV6WXh5cjVEeHB1T3BNUjd1RGg1Ym9EaWx0VU43?=
 =?utf-8?B?MUlPNDAwQ2F0Wk9IMDV2NXluOVdKbExyYlB1Ynh6TUpubXJWb0F5ZWRwU0lR?=
 =?utf-8?B?ZjRJNC9zdzczK3J5Rkt6WlBHajQ1SnppRktPblJGazBQTURBaWI2WkhCR2s0?=
 =?utf-8?B?d1VtbnZ0bk9uODlzNHM2SDk5K2xBci96VnZxekQvL3pta1AwUnVYMVZNOUUy?=
 =?utf-8?B?aEN6dC9iYlltZ0xzL1FZcnlQN0laL29XQXJQWWlmUVRGNElnVVZnNHppMVJ1?=
 =?utf-8?B?UTBIQzRCMWZkTWt6Ykhab3hrditXTmVJMWJJSlJiNlFCT0N5U3JTVUNpdXRW?=
 =?utf-8?B?b1lDOFphM3dBSlN2RmFCdUVZSVlTcmg5VGdDaEQ2a3pHWWpGOU9rVXo3SFZq?=
 =?utf-8?B?VFlBZVdmNkxkTkVLSFVIUjBMZEZhSitvWXhidnVodDhpUC9TZTlTNE5yY0Zw?=
 =?utf-8?B?aXR6LzF6dDJjTVVwL29UQ3MzV2xXSXhwV2RPd3Q5N21aWGVmc2dwbFlvQUo4?=
 =?utf-8?B?S3lHVFFDWi9tRktzOXJDUnQwY3pObEJtcWZMVWQ1NUpveFVvckFuSXhDekM2?=
 =?utf-8?B?S3g2a2JDOGZDMERHTzdGRzJXZVQ0MmNMMXdjTlhQQWgvb0pEYVhGWkh5QXp3?=
 =?utf-8?B?SFYxSlNZUjlJSFk0ZU9zMGVUSkNESUtEVmVqdnpxVEV4aVBQd1A3b0VZVHpV?=
 =?utf-8?B?ck5IN3o1dXlBbmNIODFwYWpUMVFxczRkMUQyTUpYbnNTTnFvZWUxcUZQWEV1?=
 =?utf-8?Q?YoTO9LpC3hQUSutGFihr4RUkQc8p92q0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTBVemRzZW9rajFGWnhDS1ZLZDFkeEd1WExtN28xNjNPYlh0YmNYMW5nQzNW?=
 =?utf-8?B?TzI0YTFNTjk2WXRZTklXYVNXaHgrVzlxWHpnZjZTelEyNlJOb0dKa2wwU3Fl?=
 =?utf-8?B?TDZybnEvSHJPSmREK0xDUnZLZEtUNEJ3NGg3b0dZNmpaWEd5TXNVRlBUUjZr?=
 =?utf-8?B?ODduSzV3N1FsZFJCdjVZMXZaYWhNeFNzS3hlYnpXOE5vZS9SdXNybU1xclls?=
 =?utf-8?B?YUx5UThuZmVpcWs2amVRN2h6OFp5WjhYS3VtRVdUd2pnOWNvYldWaVJTSVRK?=
 =?utf-8?B?ZzJzeWk0Ump6aUoyVnRnQndrcWkrZzJWcm9GZWI0MXZGcjJJNGNvUXR2bUc0?=
 =?utf-8?B?MTdzTzNGaVdGK1g2WTdDdjRBRy9GNGoxeDF2UmM4UVVtZXpSald2dGhTaWdQ?=
 =?utf-8?B?Y3h2Ump2ZlZ6c3BlTEtKZFJLb2tacmEyMGhPOGt2VjhHcGRkSW05V1pUVFhB?=
 =?utf-8?B?Mnh4VXBhb2NzZEVIVGJxV3poSzJJMHMycjBSYVpmTEZSajllWm4ySlowbWFp?=
 =?utf-8?B?Y0IybnNUQ0xmQm5XYllzZGVpbXB6Ti9CbGswTVl6WG9wWU52Nk1ka2R4N2M0?=
 =?utf-8?B?UzRBTUQ4MU1RZHlLREJmdVcwWmgzck5kQjhSclpMNDBYbHZCUTRLWU9PYjZo?=
 =?utf-8?B?ZkpaaUV3Z2JKNDJwMVJKaDd2V0k2UEJ1Y1dIMjNCMFBmbzZqaEpBT3NvUjVL?=
 =?utf-8?B?R1BjcmZDYjBQZDhucW5tYnIxd2o0RkMya2lwc3YzemJ3K1JzSUJXZHZkT1Ay?=
 =?utf-8?B?NnJKVW9vYk91UHMzeGt6dHgwb0tJWHIzR2cxK0NiL2FiVVZEY2ovcWhZR3NM?=
 =?utf-8?B?MjE4ajMyZ3B0bzk3SW5wbGprUzJzQzVEUkN2ZFVIbzVDY3k2eDl3L2tHMnlu?=
 =?utf-8?B?Z1l3UnFadjl2bzBGV3dRaTQxV3pwZmZ5R2xQL1I2YW5UZGlVbHVGSy9xSXR5?=
 =?utf-8?B?WE5IWUw2eldvRSt4Mk8zRG5JdzBDa0tLeDdPT3EwcDBLcHRYbytVN00xR096?=
 =?utf-8?B?eFlGWkc2VjJiZUtTb1hDWldNaW1uNjRUQ0dHamlUN3VFTnVOU3NhamNLSm1P?=
 =?utf-8?B?NE9CR0NSQjRONkZRM2NrbXNUK0doMHp3ejBTaDk0MUdtNHVFdGlMbzY5N3ZN?=
 =?utf-8?B?ZEl0eGlwU3dMQzg1LzBxMkxYMENGUkY5cnpKMkllbDQvVnRpZE5hUitRWDY5?=
 =?utf-8?B?SWU0a2w5ekw2YnJGWmpPK09VUDdhcU1zVk1xa1dNMHlKRXBlOHYvY01mNUZR?=
 =?utf-8?B?dDkzZEZyeXlrOXd4RlQ3Sjc1bDBiT1RNUWxEVE5CVUJNL0N2ZlV6a3cvbFhj?=
 =?utf-8?B?d0hsRHpRQUZNOUJ3STdLWm03cnVSTWFtaGFucnAyeHhPNVpxazRIVU13Skt0?=
 =?utf-8?B?eTlJcms4N3BOa2pTTTZCUFBKUERQUlA2WWRLYlZpVm1nTkhXb3hzVGdIY0tW?=
 =?utf-8?B?cCtCQUl0ZW1TRGdQZEREMForTmVJRnZoZDc2QXZUSlIvNDlabENveklJM3lm?=
 =?utf-8?B?TCszVlV2UWlWdGxQWllnTzlDMWtvRVNEakJCM3V6WUVPeU9UVUpSdE9yT2ds?=
 =?utf-8?B?RGxjMm9rUXNXWjJBbnd6M1ZoNU1oRS8xLzBvb0RQUVlwanNIeS80bC9aQjlq?=
 =?utf-8?B?UGFITG1rR2VDY2RTSHdueXlwRk91dzlBYzlDazA4NGJxSnFlNkhtR3FMZFkr?=
 =?utf-8?B?TTMvSzRnU3pYTVJVSFNDM3VDd0hzVXg4amNCSXZaems2VnZwREtvNUE5OTFt?=
 =?utf-8?B?Ti90SlVhUjVYcTc0MTlVWXRERXpUV3IxZjViZnZscEQ0MnNlUm55OVpFNXd3?=
 =?utf-8?B?clAyTm41M0wvdjJla201Y1NWcmZ5VDB2eVBqQlZYZnlaYVpGUkROQ2xmdGxn?=
 =?utf-8?B?WTBKL3hFekRsYjd4eHh4VlpNSmdYRktYeTZaQ05JWElVL0hQaENrQTM3cW9K?=
 =?utf-8?B?T1l6R0cvYUN4Y0NRejZGYnZiUEE5bTVCa3BsNjkwTWVpWElwSmlPVWJpQ3pm?=
 =?utf-8?B?Q2JrbFNHZ2pJd2xpdktzOGE2WG9lYmtQYy9qTmtDU0kvWEVTS1BxeEE4NWo3?=
 =?utf-8?B?QllBSUphWDdDMkFhcGFkV0JPOE9HQUNZbkhoNTB4cEUyZFBON2JPMDhqS1hi?=
 =?utf-8?B?dmZRQjlTc0RmSXRsa29qcFo3alpZMU1JTXBDNUl2SUxJU3JldTVmVm9td1k5?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D88665C72ED2D448AE016EF2DB24217@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y2SQw+ly1DWI+DcM2VcMNnUQJ/Jf+S+NCnCtnUpr20+zO/OD0JqQ88BpRl5zKEl14hKxerP8CnbDujiAuZv4xK2xMtVrQb6fjXiAOKxb7BSedoMwnYMKrq5IGhkVI3pElO9cCB1LVtUSmJ98x9PO+gUZITRw6o0comyrmAzvMP0mfRANJSHJ6KUtkgkw/iJRBF7gm4aAwuePCnDnBm21aoppV9CIGgpjRspI57H4zRToAiEqXxo/AS1Sh/JDbFz1g5Vr9pOxs7xLWeBP6W2Z/e4mwDfsVdHu//CwrRgONrpNfqpt3aalFWJ/vIqag+Y5Sney5cxISxiZhA3u91xgWyl/QLZrqPXaVcYlhynLqlGQXvqxd0khEjDy6NrJPczOJ+SWHoPKXHZxvHALREpVd5kFpObzdcWazzpZNQSQrYoVLCBw+xAJIjMUCNsM+nPGnDiG9pR5UTSSskFODlbDineV+0ZgWa78HNlh7vLKIrwlP8MKd4j10O4UWniUDVkr4xUrTIOvR6iElnKOFz61q3EqT2a+F+rANqsvV/erQ4rFewS7KAeRwzsVb06hlvbC9x8edrOIKClJjKdR9cumKPdJHkaiF2UFwvUzOh3zQsc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78508acc-1392-4020-52b0-08dd769fbcdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 13:17:39.6681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c64Cv+b4na0ksfl10PzCQmopHyvGZnLtxTTG0AkDV1p06WpAgykog2wkxO46gWKgWIPH1FtBwmz74aFwUuWwEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4933
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_05,2025-04-08_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504080093
X-Proofpoint-GUID: FJvWAkOWVvFTe_xC2AVUTlSO05QeX8bq
X-Proofpoint-ORIG-GUID: FJvWAkOWVvFTe_xC2AVUTlSO05QeX8bq

PiBzdHJ1Y3QgcmRtYV9jbV9pZCBoYXMgbWVtYmVyICJzdHJ1Y3Qgd29ya19zdHJ1Y3QgbmV0X3dv
cmsiDQo+IHRoYXQgaXMgcmV1c2VkIGZvciBlbnF1ZXVpbmcgY21hX25ldGV2ZW50X3dvcmtfaGFu
ZGxlcigpcw0KPiBvbnRvIGNtYV93cS4NCj4gDQo+IEJlbG93IGNyYXNoWzFdIGNhbiBvY2N1ciBp
ZiBtb3JlIHRoYW4gb25lIGNhbGwgdG8NCj4gY21hX25ldGV2ZW50X2NhbGxiYWNrKCkgb2NjdXJz
IGluIHF1aWNrIHN1Y2Nlc3Npb24sDQo+IHdoaWNoIGZ1cnRoZXIgZW5xdWV1ZXMgY21hX25ldGV2
ZW50X3dvcmtfaGFuZGxlcigpcyBmb3IgdGhlDQo+IHNhbWUgcmRtYV9jbV9pZCwgb3ZlcndyaXRp
bmcgYW55IHByZXZpb3VzbHkgcXVldWVkIHdvcmstaXRlbShzKQ0KPiB0aGF0IHdhcyBqdXN0IHNj
aGVkdWxlZCB0byBydW4gaS5lLiB0aGVyZSBpcyBubyBndWFyYW50ZWUNCj4gdGhlIHF1ZXVlZCB3
b3JrIGl0ZW0gbWF5IHJ1biBiZXR3ZWVuIHR3byBzdWNjZXNzaXZlIGNhbGxzDQo+IHRvIGNtYV9u
ZXRldmVudF9jYWxsYmFjaygpIGFuZCB0aGUgMm5kIElOSVRfV09SSyB3b3VsZCBvdmVyd3JpdGUN
Cj4gdGhlIDFzdCB3b3JrIGl0ZW0gKGZvciB0aGUgc2FtZSByZG1hX2NtX2lkKSwgZGVzcGl0ZSBn
cmFiYmluZw0KPiBpZF90YWJsZV9sb2NrIGR1cmluZyBlbnF1ZXVlLg0KPiANCj4gQWxzbyBkcmdu
IGFuYWx5c2lzIFsyXSBpbmRpY2F0ZXMgdGhlIHdvcmsgaXRlbSB3YXMgbGlrZWx5IG92ZXJ3cml0
dGVuLg0KPiANCj4gRml4IHRoaXMgYnkgbW92aW5nIHRoZSBJTklUX1dPUksoKSB0byBfX3JkbWFf
Y3JlYXRlX2lkKCksDQo+IHNvIHRoYXQgaXQgZG9lc24ndCByYWNlIHdpdGggYW55IGV4aXN0aW5n
IHF1ZXVlX3dvcmsoKSBvcg0KPiBpdHMgd29ya2VyIHRocmVhZC4NCj4gDQo+IFsxXSBUcmltbWVk
IGNyYXNoIHN0YWNrOg0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0NCj4gQlVHOiBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAw
MDAwMDAwMDAwMDAwMDA4DQo+IGt3b3JrZXIvdTI1Njo2IC4uLiA2LjEyLjAtMC4uLg0KPiBXb3Jr
cXVldWU6ICBjbWFfbmV0ZXZlbnRfd29ya19oYW5kbGVyIFtyZG1hX2NtXSAocmRtYV9jbSkNCj4g
UklQOiAwMDEwOnByb2Nlc3Nfb25lX3dvcmsrMHhiYS8weDMxYQ0KPiBDYWxsIFRyYWNlOg0KPiB3
b3JrZXJfdGhyZWFkKzB4MjY2LzB4M2EwDQo+IGt0aHJlYWQrMHhjZi8weDEwMA0KPiByZXRfZnJv
bV9mb3JrKzB4MzEvMHg1MA0KPiByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzANCj4gPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IA0KPiBbMl0gZHJnbiBj
cmFzaCBhbmFseXNpczoNCj4gDQo+IHRyYWNlID0gcHJvZy5jcmFzaGVkX3RocmVhZCgpLnN0YWNr
X3RyYWNlKCkNCj4gdHJhY2UNCj4gKDApICBjcmFzaF9zZXR1cF9yZWdzICguL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL2tleGVjLmg6MTExOjE1KQ0KPiAoMSkgIF9fY3Jhc2hfa2V4ZWMgKGtlcm5lbC9j
cmFzaF9jb3JlLmM6MTIyOjQpDQo+ICgyKSAgcGFuaWMgKGtlcm5lbC9wYW5pYy5jOjM5OTozKQ0K
PiAoMykgIG9vcHNfZW5kIChhcmNoL3g4Ni9rZXJuZWwvZHVtcHN0YWNrLmM6MzgyOjMpDQo+IC4u
Lg0KPiAoOCkgIHByb2Nlc3Nfb25lX3dvcmsgKGtlcm5lbC93b3JrcXVldWUuYzozMTY4OjIpDQo+
ICg5KSAgcHJvY2Vzc19zY2hlZHVsZWRfd29ya3MgKGtlcm5lbC93b3JrcXVldWUuYzozMzEwOjMp
DQo+ICgxMCkgd29ya2VyX3RocmVhZCAoa2VybmVsL3dvcmtxdWV1ZS5jOjMzOTE6NCkNCj4gKDEx
KSBrdGhyZWFkIChrZXJuZWwva3RocmVhZC5jOjM4OTo5KQ0KPiANCj4gTGluZSB3b3JrcXVldWUu
YzozMTY4IGZvciB0aGlzIGtlcm5lbCB2ZXJzaW9uIGlzIGluIHByb2Nlc3Nfb25lX3dvcmsoKToN
Cj4gMzE2OAlzdHJzY3B5KHdvcmtlci0+ZGVzYywgcHdxLT53cS0+bmFtZSwgV09SS0VSX0RFU0Nf
TEVOKTsNCj4gDQo+IHRyYWNlWzhdWyJ3b3JrIl0NCj4gKihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKikw
eGZmZmY5MjU3N2QwYTIxZDggPSB7DQo+IAkuZGF0YSA9IChhdG9taWNfbG9uZ190KXsNCj4gCQku
Y291bnRlciA9IChzNjQpNTM2ODcwOTEyLCAgICA8PT09IE5vdGUNCj4gCX0sDQo+IAkuZW50cnkg
PSAoc3RydWN0IGxpc3RfaGVhZCl7DQo+IAkJLm5leHQgPSAoc3RydWN0IGxpc3RfaGVhZCAqKTB4
ZmZmZjkyNGQwNzU5MjRjMCwNCj4gCQkucHJldiA9IChzdHJ1Y3QgbGlzdF9oZWFkICopMHhmZmZm
OTI0ZDA3NTkyNGMwLA0KPiAJfSwNCj4gCS5mdW5jID0gKHdvcmtfZnVuY190KWNtYV9uZXRldmVu
dF93b3JrX2hhbmRsZXIrMHgwID0gMHhmZmZmZmZmZmMyY2VjMjgwLA0KPiB9DQo+IA0KPiBTdXNw
aWNpb24gaXMgdGhhdCBwd3EgaXMgTlVMTDoNCj4gdHJhY2VbOF1bInB3cSJdDQo+IChzdHJ1Y3Qg
cG9vbF93b3JrcXVldWUgKik8YWJzZW50Pg0KPiANCj4gSW4gcHJvY2Vzc19vbmVfd29yaygpLCBw
d3EgaXMgYXNzaWduZWQgZnJvbToNCj4gc3RydWN0IHBvb2xfd29ya3F1ZXVlICpwd3EgPSBnZXRf
d29ya19wd3Eod29yayk7DQo+IA0KPiBhbmQgZ2V0X3dvcmtfcHdxKCkgaXM6DQo+IHN0YXRpYyBz
dHJ1Y3QgcG9vbF93b3JrcXVldWUgKmdldF93b3JrX3B3cShzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndv
cmspDQo+IHsNCj4gCXVuc2lnbmVkIGxvbmcgZGF0YSA9IGF0b21pY19sb25nX3JlYWQoJndvcmst
PmRhdGEpOw0KPiANCj4gCWlmIChkYXRhICYgV09SS19TVFJVQ1RfUFdRKQ0KPiAJCXJldHVybiB3
b3JrX3N0cnVjdF9wd3EoZGF0YSk7DQo+IAllbHNlDQo+IAkJcmV0dXJuIE5VTEw7DQo+IH0NCj4g
DQo+IFdPUktfU1RSVUNUX1BXUSBpcyAweDQ6DQo+IHByaW50KHJlcHIocHJvZ1snV09SS19TVFJV
Q1RfUFdRJ10pKQ0KPiBPYmplY3QocHJvZywgJ2VudW0gd29ya19mbGFncycsIHZhbHVlPTQpDQo+
IA0KPiBCdXQgd29yay0+ZGF0YSBpcyA1MzY4NzA5MTIgd2hpY2ggaXMgMHgyMDAwMDAwMC4NCj4g
U28sIGdldF93b3JrX3B3cSgpIHJldHVybnMgTlVMTCBhbmQgd2UgY3Jhc2ggaW4gcHJvY2Vzc19v
bmVfd29yaygpOg0KPiAzMTY4CXN0cnNjcHkod29ya2VyLT5kZXNjLCBwd3EtPndxLT5uYW1lLCBX
T1JLRVJfREVTQ19MRU4pOw0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0NCj4gDQo+IEZpeGVzOiA5MjVkMDQ2ZTdlNTIgKCJSRE1BL2NvcmU6IEFkZCBhIG5l
dGV2ZW50IG5vdGlmaWVyIHRvIGNtYSIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+
IENvLWRldmVsb3BlZC1ieTogSMOla29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogSMOla29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogU2hhcmF0aCBTcmluaXZhc2FuIDxzaGFyYXRoLnNyaW5pdmFzYW5A
b3JhY2xlLmNvbT4NCg0KQSBnZW50bGUgcGluZyBvbiB0aGlzIHBhdGNoLg0KDQoNClRoeHMsIEjD
pWtvbg0KDQoNCj4gLS0tDQo+IHYxLT52MiBjYzpzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IC0t
LQ0KPiBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEuYyB8IDQgKysrLQ0KPiAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9j
bWEuYw0KPiBpbmRleCA5MWRiMTA1MTVkNzQuLjE3NmQwYjNlNDQ4OCAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5k
L2NvcmUvY21hLmMNCj4gQEAgLTcyLDYgKzcyLDggQEAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25z
dCBjbWFfZXZlbnRzW10gPSB7DQo+IHN0YXRpYyB2b2lkIGNtYV9pYm9lX3NldF9tZ2lkKHN0cnVj
dCBzb2NrYWRkciAqYWRkciwgdW5pb24gaWJfZ2lkICptZ2lkLA0KPiAJCQkgICAgICBlbnVtIGli
X2dpZF90eXBlIGdpZF90eXBlKTsNCj4gDQo+ICtzdGF0aWMgdm9pZCBjbWFfbmV0ZXZlbnRfd29y
a19oYW5kbGVyKHN0cnVjdCB3b3JrX3N0cnVjdCAqX3dvcmspOw0KPiArDQo+IGNvbnN0IGNoYXIg
Kl9fYXR0cmlidXRlX2NvbnN0X18gcmRtYV9ldmVudF9tc2coZW51bSByZG1hX2NtX2V2ZW50X3R5
cGUgZXZlbnQpDQo+IHsNCj4gCXNpemVfdCBpbmRleCA9IGV2ZW50Ow0KPiBAQCAtMTAzMyw2ICsx
MDM1LDcgQEAgX19yZG1hX2NyZWF0ZV9pZChzdHJ1Y3QgbmV0ICpuZXQsIHJkbWFfY21fZXZlbnRf
aGFuZGxlciBldmVudF9oYW5kbGVyLA0KPiAJZ2V0X3JhbmRvbV9ieXRlcygmaWRfcHJpdi0+c2Vx
X251bSwgc2l6ZW9mIGlkX3ByaXYtPnNlcV9udW0pOw0KPiAJaWRfcHJpdi0+aWQucm91dGUuYWRk
ci5kZXZfYWRkci5uZXQgPSBnZXRfbmV0KG5ldCk7DQo+IAlpZF9wcml2LT5zZXFfbnVtICY9IDB4
MDBmZmZmZmY7DQo+ICsJSU5JVF9XT1JLKCZpZF9wcml2LT5pZC5uZXRfd29yaywgY21hX25ldGV2
ZW50X3dvcmtfaGFuZGxlcik7DQo+IA0KPiAJcmRtYV9yZXN0cmFja19uZXcoJmlkX3ByaXYtPnJl
cywgUkRNQV9SRVNUUkFDS19DTV9JRCk7DQo+IAlpZiAocGFyZW50KQ0KPiBAQCAtNTIyNyw3ICs1
MjMwLDYgQEAgc3RhdGljIGludCBjbWFfbmV0ZXZlbnRfY2FsbGJhY2soc3RydWN0IG5vdGlmaWVy
X2Jsb2NrICpzZWxmLA0KPiAJCWlmICghbWVtY21wKGN1cnJlbnRfaWQtPmlkLnJvdXRlLmFkZHIu
ZGV2X2FkZHIuZHN0X2Rldl9hZGRyLA0KPiAJCQkgICBuZWlnaC0+aGEsIEVUSF9BTEVOKSkNCj4g
CQkJY29udGludWU7DQo+IC0JCUlOSVRfV09SSygmY3VycmVudF9pZC0+aWQubmV0X3dvcmssIGNt
YV9uZXRldmVudF93b3JrX2hhbmRsZXIpOw0KPiAJCWNtYV9pZF9nZXQoY3VycmVudF9pZCk7DQo+
IAkJcXVldWVfd29yayhjbWFfd3EsICZjdXJyZW50X2lkLT5pZC5uZXRfd29yayk7DQo+IAl9DQo+
IC0tDQo+IDIuMzkuNSAoQXBwbGUgR2l0LTE1NCkNCg==

