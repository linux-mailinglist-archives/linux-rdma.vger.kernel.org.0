Return-Path: <linux-rdma+bounces-13815-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C968BD3551
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 16:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0081D34C970
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 14:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C6A23D288;
	Mon, 13 Oct 2025 14:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Op9KjobS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Epq9UA8G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA96A233D85;
	Mon, 13 Oct 2025 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364274; cv=fail; b=YS1bCZ6MXpMdZziQ0hjv26FURBVA+SB39d/TZb0h7aq7zCP44WiZyKG/Dpfjt0GGshA5elL5iteSZ1HWdx8g0pLtuRFnW8QaV37X3WaxEQ+uhtKQqwYuqx4UpstXtKUy5f6k2utZ5j8Gtp9Cnxi/h9eAEDaQ0Ky4l5XMAtPPxlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364274; c=relaxed/simple;
	bh=JhL8Jx0+n9hJPGWaNuyFhFrrkoOMnOfCXOhLL6YL1SM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sCnmZf0ZGlIWDjiHLZxDGcTDnbiJP44IVBB28dSIZAmYpOYD62Mu7U2Ln8mwFSd7JIR21bAnjYjpxt7ywudCQaUMOxT8eT01c+KEbmeacZ/6jDjIWZHTUSd4KymuYIXz1Gv3uE1fJsO6CPRtXQTBMVbMZY8G8m8qd9qcpauZ3J8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Op9KjobS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Epq9UA8G; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DDfxOp032080;
	Mon, 13 Oct 2025 14:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JhL8Jx0+n9hJPGWaNuyFhFrrkoOMnOfCXOhLL6YL1SM=; b=
	Op9KjobSrX6OX+6t7s3hTCrWoxkjFbhJgvbEHmZdyX2VVji1m0u0KxBmNL7OJsgG
	v5xase5cMPqk0Uo1LQDSzF7OUBMejPlqFxM4tPBytD/AqTY7hLV8+uLZbVTHbxXH
	Re7yVYJfYjLdOEdxTZZom7VHWGi2p83YvhlhGnp3tc/gfGKOz2/3SQahDRZMUyte
	WfdWH/8atoYSCVUJ4pGUx1pz1PUm5qkwXUIxM6YCm1om8wtnU86MhM32n4vIXK+P
	2Jksa40y5/vOt0arE6faAifVHJpDUGl/uOrRX4VOXfOD6isU9v5rODHxaXsRP45x
	UuEeuurMtHF+/dbG6trClw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qfsrtahu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 14:04:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59DCO2Vm009787;
	Mon, 13 Oct 2025 14:04:25 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpdkmj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 14:04:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQiixw6Whlfa37V2WQuYFdbbVq9XAmsByi5hurdMZKhls5A4JK1SX9/IiCb+r/290YBZv9X8OoX5C0e54UzBJAtGULd88FuE09TS2NECa3AhsRqKv1eUPcFNRVQ1wVj/dj7/GfeXuPMvAnp4IvyodjpxhnthxlbWDvBw7in2Wg6ifDsY3vX4Vz/bkn2SEOIMsXiKtwvu630e3cXk789UAj+cSsbNec5Q7x8h6sr9w2ADBBAh8fnwNPtxj9oCaZjSp16RBOBPFScCdP9QfvFPArXFKu7wnf6XG71+b5MUS13tc0R/CRAocIVNVzkyEa3NMG5JlUTS7g737d/G0rImPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhL8Jx0+n9hJPGWaNuyFhFrrkoOMnOfCXOhLL6YL1SM=;
 b=G9B1R5jVjDvEBJpt0k3sVGU8iNpemkWZUiEOVji82THb+HTNW90JuMlWLxNMKy8WpxFZq5b05Phfisouq4rY7vkNO8MFZse2N5gKW0JAwa5Guaq01zEcN750IqmhF1kvL/FP3ouo4d+W/cBInv7iAnbGwemFrPy6JXW+Iob2GGxjiluqJyAZq7n3Pu/z61hH+9WkErVtiIOiggPe1jw0auA8AAAcD7m1M/Sq4aZxbyOmJ3a1yFXI0tQraA/4LFY9UWRTtf+ALfqdYRqhAVbZE1m6yWMkQd99leRHoaML5z5M37J9wT3PaoPNIvemM1CPUeDWO82oui5rzM2dRuGb1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhL8Jx0+n9hJPGWaNuyFhFrrkoOMnOfCXOhLL6YL1SM=;
 b=Epq9UA8GUH+ByWZeqK4KJkQavL7TooV8LgQlGABhoBt+FjUVt+EEuFO/O8yk/C0Le0soJtNRO6WHXS0ABIJLT0e8A8Ee5Df7DnGCU7pUtHJFFnCueKX6rMyt3S5zL2gLTYHOq2tfKH2f7XyJE8Qvl0dqv33Y3c7XU/zxcjnAYtY=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by IA3PR10MB8513.namprd10.prod.outlook.com (2603:10b6:208:576::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Mon, 13 Oct
 2025 14:04:20 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 14:04:20 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Jacob Moroni <jmoroni@google.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Sean
 Hefty <shefty@nvidia.com>,
        Vlad Dumitrescu <vdumitrescu@nvidia.com>,
        Or
 Har-Toov <ohartoov@nvidia.com>,
        Manjunath Patil
	<manjunath.b.patil@oracle.com>,
        OFED mailing list
	<linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error
 message
Thread-Topic: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error
 message
Thread-Index: AQHcI8zHdy1KL4KXCkyexoudDHS8M7SV4d4AgAAFLICADfC2AIAcdSOA
Date: Mon, 13 Oct 2025 14:04:20 +0000
Message-ID: <ABD64250-0CA0-4F4F-94D3-9AA4497E3518@oracle.com>
References: <20250912100525.531102-1-haakon.bugge@oracle.com>
 <20250916141812.GP882933@ziepe.ca>
 <CAHYDg1Rd=meRaF=AJAXJ+5_hDaJckaZs7DJUtXAY_D2z_a6wsw@mail.gmail.com>
 <D2E28412-CC9F-497E-BF81-2DB4A8BC1C5E@oracle.com>
In-Reply-To: <D2E28412-CC9F-497E-BF81-2DB4A8BC1C5E@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|IA3PR10MB8513:EE_
x-ms-office365-filtering-correlation-id: 0f6c6af2-4e64-4265-8fb5-08de0a6167df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UkxZSXRjaXAvaGplVzFOQk1hTWYxeDh1SjlONENoclp2b2dNVi9ZZXZzSUE2?=
 =?utf-8?B?M3BaNHppeTRRd0o2YVJmcXVsYTBLTE8wNWR6UXBZaitiUkRhTit2SVZna1k3?=
 =?utf-8?B?Umx0V0Z2MEVpSW1WWjBrMnhuVzRJbmFiNEVLZGFudTRsZ080SjYyV3FGRnhi?=
 =?utf-8?B?NjltQzJ1UCtGcEhIVGZFTTNwRWNFQzNJTkd0UXN0Tnh1SW1mZnNDTWltV0RQ?=
 =?utf-8?B?USt5QWFSMG81L2l0UlkvZXlib0xjNmhmVnZES0FHOHAxanhhaUJYejNDbCt6?=
 =?utf-8?B?MlIzYzZtQXcvUWMxdWM1d1VnNkpkYXBYVzdRdVBxM2ZHYW15NFNJVFlKQkFX?=
 =?utf-8?B?K1Z3R0xPTzhnVlJJMnZWYVBUY0ZkVjIyUTUxcklSa3U0eTVqTGxZellwZEp0?=
 =?utf-8?B?OUtFcHlFWTVIRWlmZEo1TlV2L1NxYU1aeWVmQXlzU1pBaXhtdkF3ZTN4NFgy?=
 =?utf-8?B?YXRXSVBvVnA0SzUzRDNqdkZ1ODBPamxsSzIwK2hLVDJFZExxNE80b2s3T1pM?=
 =?utf-8?B?NTNITWNMYXF0QUhwQ0U4ejU2dCt4aGh3aklBR3N5RGZONlNURE1RNldWNDRC?=
 =?utf-8?B?SUl1cnhidXFOamF1dE9Zc2dXeG1JZmFNaHBoTjFyUHphS1ZPR21PRi84L2Qr?=
 =?utf-8?B?cVd4aGJUTVpyZTRMc0RTMUkxODZRa3o2bVBPZk52UWRQZVRpOXI3THl0UVc0?=
 =?utf-8?B?Sm1FOTFzSUhVYnVrRC9nK1BlRTRTS3RpemNPTjFtWFZ2ZkdyekswYnd1TCtm?=
 =?utf-8?B?ekNnOUJqUlR5S1k2d1QvaU5pYjBKSXVMSitRVWhhdnB4VW5uRnYzRVBmSFMz?=
 =?utf-8?B?R1pjTWoyMVZTR1Z5djduYXVzNlRSODRkcm5nZFFWZ2J0dlR2WGtjdmljZEJB?=
 =?utf-8?B?ZXd3MGsyQ0dQMERIWmFIeXlxa05YbmZZaDFCb1pwWFNZQ2xYZzljd3NwZ2pz?=
 =?utf-8?B?Zk5ZdjJCaktNaWlMU3JudGRyWXFLM3VVSU4yWTc1L3Z4TmRJbXhtb1JuVzd2?=
 =?utf-8?B?aUk5MFA4b0VJc0RqVEZaMk56WkF3SVZqcTMzSjN4b1BlU25sZTJtV3RZOTQ3?=
 =?utf-8?B?dk1TVjdMbStPVWtyMlJsY1p0Mm53RitSOVdhcHRFaTFkYyt2T0R0RFpFWm5Z?=
 =?utf-8?B?MnFlNFBldEVjUHdzM0VIeUVhbGhvNGJpTlR2TDZXcVMrdmpNMFpoQThZNlpM?=
 =?utf-8?B?R1lweWRlOG1jVVNhYWxmdWFNZlRFdkpzZkYvKzR1dVVJM3lpc0dscmU1VHNB?=
 =?utf-8?B?SUp4Qi9PTHNVOXRzajY2NkdWc3grWmtBYnFSeU5TZFZmaURVeDZsTGd5TVRz?=
 =?utf-8?B?SjJ4cy9IRVh0UFVjaUhPS3VVRGgvd0hsbWtsU2lra0RDZlljRDFFNSthQjhZ?=
 =?utf-8?B?emtiQjVuZlhzM2NYMEEzY3FhQWtyM1BFVStsb1A3SlV1M2l0OXhsb3YxeVlv?=
 =?utf-8?B?ejBpWnJ6bHMwQlhJbjRuUFp6eHBJbTFYdUZ1Z05DSnpVWnlCQUdXSVZkT1ll?=
 =?utf-8?B?NFJEL2tKZkxPZGw5OTQxVWJnWitlL0tDYVFjZEdJZUVFMWpDejIxVEMyRlky?=
 =?utf-8?B?N2trTnRHckMyM2FmcmtDc1RxdER2Z21WNEI2SXV2Vm5ab0w5SFJuOWlTRnlE?=
 =?utf-8?B?azZFWW5sQTVROXlTcWJjaWMvYW4wYWExaFd4NTZKQm9xSU9CZEFubVJyT1Nu?=
 =?utf-8?B?RW5EUWpRN3owU0IvL3ZMeWtYc0VtMjdjM1lHWllaMzU5Y1lJMk9wLy9xT2pq?=
 =?utf-8?B?SUFFcGRGRm5CbXo4MTB1WEk5RWVoL3dWejZSbDVTRHRUT04wdVRHdFRNbHAx?=
 =?utf-8?B?WnRYVEVyQkV3UnZDdkk2SDNxbTZMOGp3azBZZng3STJXNVdnTTlBajJMVDN0?=
 =?utf-8?B?MXdEVmNaYUVXMGo4aWJyS3JjVlVjcTlyeTFTME1oMEZCODlRbDBkOXl1Mkxh?=
 =?utf-8?B?SElncjNncjh5dFg2eXVrWFgrZnRQSEo2QXI4VUJPMTRhNlNMZklJRTY2bWEw?=
 =?utf-8?B?RzEyUU8rQndSTnJZTlBMV09nTTFrRm9QTE9WYlhvNHFJWVVFRzJSNWVNSEZx?=
 =?utf-8?Q?4g+3wW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TkcyVmh3OHVBV095cnJDL3lzQkRrTHVHaUhyVlRid0lybGhlaVgvT3N2YlFD?=
 =?utf-8?B?eGRiaGVjV3lmTFp3MVU1WCtCWGZ3RWZRN2ZieW9IVnkvZEIzRGtSRzQ4NFpW?=
 =?utf-8?B?Qk50OXZLckNZUFpKRmR0NUFkZkNNNUxCTGFad1YwMm5wWVk1Y1g1OHN1ZUFD?=
 =?utf-8?B?RzF4b29semtTS0crbXYyZFI2b3Jmb0M1SjN2c0xlVUZpYjhRMnVWMElWdWwy?=
 =?utf-8?B?L24xZE9xTWgrVjZIMUJBMHdPNTlHZ01GT2FuN216RTU3TFFhTHF2djNZSDEr?=
 =?utf-8?B?MVBVRTlDZ2I3MlQybXZ1NjNvMnMvdEdPdU5wbTAyWVJuYWJrUURFOHEzdklX?=
 =?utf-8?B?aGR0clF0SkJaeGpFSWYwcVlrZ3pVYXFTZGtPaTZLZ0hpLzlSNjZnUWc1SHVR?=
 =?utf-8?B?bWNMZUdSL3hZZE1KcUIyd09BSU1Mb3VOSzVWdGNQeENYUkRBeXhNTW93VHlv?=
 =?utf-8?B?Zi90U3BEekxZMXM4elBSSmFXYUphaS9wWlNJTmVlTVhOekNuY2tTU2JCVDFy?=
 =?utf-8?B?VStGaitueTBsMFZvNmhhekpFNjhFbm1rSk1NVGtJSU00aWdiQVN2VnV2QkhY?=
 =?utf-8?B?NUNiZitselVEWnBpU2tnbjBsZDk1YUF0RC84ZnFBQ2owUmhZZW1KdDVZekUz?=
 =?utf-8?B?akdlRTZnY0VsNjV1UFRUUldYSE5hbWd5Q0ZubGJFVStYd3Q2SGRDRWxnN0R3?=
 =?utf-8?B?QStzTjFDK3BBQWdiNkd0VHhucmRwVlVaRFI2QzhaOUNmU0VoZmpkMlJmaUY3?=
 =?utf-8?B?M2JWaThjcldhUGdxaExzZ1F2aVhXV2o0VW14ZXJCbkM5UlB3OGRndGloVWVl?=
 =?utf-8?B?SFFIa2tkYVFxcE8zUjl5eTNmRjBtV1pnRmF2SENJMXlWZHNWb2lwMGlJY2Jt?=
 =?utf-8?B?cmFUdTExT2kwTjNNSGNPNnVsZWpaNytoc0JnSUtJOE4zUXJiYW56Zi9qOUFz?=
 =?utf-8?B?V0szcUdDOWZKUGhnNFladWxMenlQblVQQ2FjdXJQVm5XWC91bVVlNEJicEV5?=
 =?utf-8?B?ZFo5VFhJcWtWb09KaGhwSm9mUTJ5R2JQK1pvVFc4UFdSMzJLUmQ4dWNlbjJS?=
 =?utf-8?B?NmlielB1U3NTMnJWamh0ZHp3SGp4enFocG44RDY5U0o5Q0JiZXF0d2MvVXRX?=
 =?utf-8?B?a0tlNEJvcWJoaGR5ZHc5TjB6NTNxQUU2RXVuRDhsTVFJSlpiRFBac3ZoRm1u?=
 =?utf-8?B?TUZRS2pFbjM3R3NoZEhMS0F5bzUwaWFuK2pnU3JwWGdWUTZoSGNvQ1BwUFFv?=
 =?utf-8?B?UkZ2L2NPaXp0aXducXFqZVV6cjFFbnpzUzZqZVVnTXJ1RE5JMXNsU0lTVUdU?=
 =?utf-8?B?V1d6NlR3UndsTnozWXZrSHhOV2ozTDhNak5UUUo2K3diejFMUm5HeGdobTc4?=
 =?utf-8?B?UWp0U1ArZ0lVQW9iVGl2VzBDUU9vZzR1aG51S3VxaDlvSDc3ZW40M29jbmVy?=
 =?utf-8?B?YXduOWd2VXYwNjMzYkpXRGJLVklFVnQ5UENWQk9ucXM3dEJ2TlNKaFhqOFlm?=
 =?utf-8?B?QWFtdWtscDZwMFpyUjFicGlDdURpTDFWSVh4OW9UKzhuTmFCL1BPZktWTTBi?=
 =?utf-8?B?Qjl5TElqYitzazBpa29Pa0VwYVFhS1UrZk5qSmo0VzI5MUxiUDNjVEtwMUFt?=
 =?utf-8?B?Vm9RYmZaL29yNk4xTE5uOHI4dnpWdno3RnV1b29ubHduV1lMcVFjNVFFck1y?=
 =?utf-8?B?SVd2TnVPWFFnbTRzVExleURjRENQSlNwNFBhSnZ2aGtRblFYc1VsSVlKVDBB?=
 =?utf-8?B?L2JodEwzdyt2dVdNdkZJNE9VRnY5RUcveXFvSzk1OWRSeTZkZDFVOUZBSWZ6?=
 =?utf-8?B?OEVHMVdZOXBHdWVsTzY5Q3VNRXh5ZVFsZTdha0pPTVNCaXlzbyszWm4rZ2wr?=
 =?utf-8?B?b3M0eVdISXR1ZWROYnpkUnA2S0pSN3NBU2ZXY3hucTZpSzdLM1JiUTBMK2Ur?=
 =?utf-8?B?QXVmOHV2Ukh3Mkl0ZXl2c1JtWnFRb0FhUktkdTRzd2pBeTdMRTZVVTdzN1V1?=
 =?utf-8?B?YjBqT29tcVUrQ3c0RWVDNDJ6ZGVkOFlOSWpCZ29rd29xUGxwSFg0Q1RJZVBz?=
 =?utf-8?B?bEpBS0MrL3ZiNE5FTldkRHp0T3B1KzY5a2Eyejl2bFJkRjdxMzhKNVRCbDBH?=
 =?utf-8?B?ZHNJdjNaUWdoZkNvZmFLc0o5ZFVJZmZONFpldjMzckJXRDZHL3lsaWREWW1o?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E7D30BA06D02A4FBAD067BCE75044FC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oBMA5iDK2VwYdmyNhUsheSw3UgWkuKwOrEWCuuSRyW4/M7lxDYW7kYmSO/OP6liEtPd529wDs8Il/D0dLB5b9kdRq3G+w0yRmlECopdtJXbscFFFjrzwJGLYNvHcemvKTBXpif1ZRZkoPiA7/+F1fLnJu/IiOHq7FIwAv4qN4DPX8dW+8RUZB8rrAG+h43SW3lRhfuNXIkWFZE9BqudoNJkWfMDKbKZ4MjkAiE0GmsDceAfuMtnTFEZGZxpb74PsQTMP8b6LNtta0e8BBtpBTirgFC1HBI+A6GnzBhqWTugpeASTGTROC2wSjY4Du05h2rudazqAQ1QKRs4CUJkRmUa3r02aG3kFzxWOxzZZuZ+oSgKg3cCUWQ6ORqIgRl05Xno0EADPbOwU9/CdUzbbuQ9YabzsXl2VVCjNsZ9uOHwzfcHmY+t2GkIXqQMa6xmFFveShsQLNbigln1m2YIm3WjJhQ3hFqtgo6I/ksgOibpoQufDOPTM6sP+dOtUKEZydj594Bbp0o+/8lQXKtzak4ILaM3g4l7D3FtBGVOODRBMtdsmRu3aRWhD8PcT2u1HWf8wEFBoFoc8cev7FFCkUfykfwX+vrRKfj8KMPY33JA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6c6af2-4e64-4265-8fb5-08de0a6167df
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 14:04:20.3756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7P9QSgpQNjP+mN1wAZs521ZrtR9qCSDiH5xKd35Ywjjtfds2EawEKyH/hP74LvKLjoX0BCE5QvFizo4ogQwcmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8513
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510130062
X-Proofpoint-GUID: qVebxV88BVuj-tfZFms9dfz9V5dBafDM
X-Authority-Analysis: v=2.4 cv=APfYzRIR c=1 sm=1 tr=0 ts=68ed06ea b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=mL9rJ0wSAHB9iQAcgWMA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMSBTYWx0ZWRfX9rEX81UeZi2U
 Wb/1ZgHdf9rHJQD36+RUiVdSomwjFCJpK1tP2QG1iOCC+lm3t4iLESvEruLh6TbgCOhTF27qke8
 Z9Lv1oly3+OjBcORtEy7cZttZWY/xnVm5+XaKh9omfAwyF0Tf1qufcUFMrw1VNNw1kXQrtdXeX7
 i/DxhFgh/tYoBEA11JrojAuSZegbnXnCdcTuk/J7AkLUOpIV9l0GBJykfdzTZMlqZDOlB/pCYi9
 TMx0hbeM1PTBCz0qbLvCguUTdXStZfr8pnc1u7Y2eH7QB5ymQgwP9ke3jC9mPDCOGrKf3AlafpX
 tn/DRcnP/mlb65okymBNrPg4gGgHUb31UWj/hswGhZhcgLZ38/xiWadCidvHnNIyNwM2F+d+72U
 /B7nEHm5VtsYZYgdAVOU0E81IKTboKoRGHK2TefPzCizdLLhpY0=
X-Proofpoint-ORIG-GUID: qVebxV88BVuj-tfZFms9dfz9V5dBafDM

SGkgSmFzb24gYW5kIEpha2UsDQoNCj4gT24gMjUgU2VwIDIwMjUsIGF0IDEzOjI5LCBIYWFrb24g
QnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+IFtzbmlwXQ0KDQpH
b3QgYW5vdGhlciBpbmNpZGVudCB0aGlzIHdlZWtlbmQuIFRoZSBmaXJzdCBjbV9kZXN0cm95X2lk
X3dhaXRfdGltZW91dCgpIG1lc3NhZ2UgYXQ6DQoNCk9jdCAxMCAxMjoxMDozMSBsYWI2NCBrZXJu
ZWw6IGNtX2Rlc3Ryb3lfaWRfd2FpdF90aW1lb3V0OiBjbV9pZD0wMDAwMDAwMDgwM2ZlYWMxIHRp
bWVkIG91dC4gc3RhdGUgMiAtPiAwLCByZWZjbnQ9Mg0KW10NCg0KSGVhbHRoIGVycm9yIGluIGNs
b3NlIHByb3hpbWl0eSBpbiB0aW1lOg0KDQojIGRldmxpbmsgaGVhbHRoIHNob3cgZW5zNGYxNCBy
ZXBvcnRlciB0eA0KYXV4aWxpYXJ5L21seDVfY29yZS5ldGguOC81MjQyODg6DQogIHJlcG9ydGVy
IHR4DQogICAgc3RhdGUgaGVhbHRoeSBlcnJvciAyNTYgcmVjb3ZlciAyNTYgbGFzdF9kdW1wX2Rh
dGUgMjAyNS0xMC0xMCBsYXN0X2R1bXBfdGltZSAxMjowODo0NyBncmFjZV9wZXJpb2QgNTAwIGF1
dG9fcmVjb3ZlciB0cnVlIGF1dG9fZHVtcCB0cnVlDQoNCkFuZCBhbHNvIG5kZXYgdGltZW91dCBp
biBjbG9zZSBwcm94aW1pdHkgaW4gdGltZToNCg0KIyBmZ3JlcCAiVFggdGltZW91dCBvbiBxdWV1
ZSIgL3Zhci9sb2cvbWVzc2FnZXMtMjAyNTEwMTIgDQpPY3QgMTAgMTI6MTE6MTYgbGFiNjQga2Vy
bmVsOiBtbHg1X2NvcmUgMDAwMDoxMzowMS4wIGVuczRmMTQ6IFRYIHRpbWVvdXQgb24gcXVldWU6
IDUsIFNROiAweGZiNDMsIENROiAweDY2YiwgU1EgQ29uczogMHgwIFNRIFByb2Q6IDB4NCwgdXNl
Y3Mgc2luY2UgbGFzdCB0cmFuczogMjA5OTIwMDANCk9jdCAxMCAxMzowMTowNSBsYWI2NCBrZXJu
ZWw6IG1seDVfY29yZSAwMDAwOjEzOjAxLjAgZW5zNGYxNDogVFggdGltZW91dCBvbiBxdWV1ZTog
MywgU1E6IDB4MTA4OGEsIENROiAweGNhZSwgU1EgQ29uczogMHgwIFNRIFByb2Q6IDB4M2M1LCB1
c2VjcyBzaW5jZSBsYXN0IHRyYW5zOiAxNjM5MDAwMA0KW10NCg0KNDE0MCBjbV9pZHMgaW4gdGhp
cyBzaXR1YXRpb246DQoNCiMgZG1lc2cgfCBncmVwIGNtX2Rlc3Ryb3lfaWRfd2FpdF90aW1lb3V0
IHwgYXdrICd7IHByaW50ICQzOyB9JyB8IHNvcnQgLW4gfCB1bmlxIHwgd2MNCiAgIDQxNDAgICAg
NDE0MCAgIDk1MjIwDQoNCkJ5IHJ1bm5pbmcgaWJfc2VuZF9idyB1c2luZyB0aGUgc3VzcGVjdGVk
IGJhZCBkZXZpY2U6DQoNClsxXS0gIFJ1bm5pbmcgICAgICAgICAgICAgICAgIGliX3NlbmRfYncg
LVIgLWQgbWx4NV83IC1pIDIgJg0KWzJdKyAgUnVubmluZyAgICAgICAgICAgICAgICAgaWJfc2Vu
ZF9idyAtUiAtZCBtbHg1XzcgLWkgMSAxOTIuMTY4LjY0LjE1ICYNCg0KU2FpZCBwcm9jZXNzZXMg
YXJlIGhhbmdpbmcgYW5kIHdlIGdvdCBvbmUgbW9yZSBjbV9pZCBpbiB0aGlzIHNpdHVhdGlvbjoN
Cg0KIyBkbWVzZyB8IGdyZXAgY21fZGVzdHJveV9pZF93YWl0X3RpbWVvdXQgfCBhd2sgJ3sgcHJp
bnQgJDM7IH0nIHwgc29ydCAtbiB8IHVuaXEgfCB3Yw0KICAgNDE0MSAgICA0MTQxICAgOTUyNDMN
Cg0KU3RhY2tzOg0KDQojIGNhdCAvcHJvYy80MzU0Nzcvc3RhY2sgDQpbPDA+XSB1Y21hX2dldF9l
dmVudCsweGYwLzB4MjQwIFtyZG1hX3VjbV0NCls8MD5dIHVjbWFfd3JpdGUrMHhmOC8weDE3MCBb
cmRtYV91Y21dDQpbPDA+XSB2ZnNfd3JpdGUrMHhkNC8weDI5NA0KWzwwPl0ga3N5c193cml0ZSsw
eGJiLzB4ZTgNCls8MD5dIGRvX3N5c2NhbGxfNjQrMHgzNS8weDg3DQpbPDA+XSBlbnRyeV9TWVND
QUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg2ZS8weDANCg0KIyBjYXQgL3Byb2MvNDM2NjA2L3N0YWNr
IA0KWzwwPl0gY21fZGVzdHJveV9pZCsweDE2YS8weDYxYyBbaWJfY21dDQpbPDA+XSBfZGVzdHJv
eV9pZCsweDVhLzB4MjMwIFtyZG1hX2NtXQ0KWzwwPl0gdWNtYV9kZXN0cm95X3ByaXZhdGVfY3R4
KzB4MzU0LzB4MzcwIFtyZG1hX3VjbV0NCls8MD5dIHVjbWFfY2xvc2UrMHg3YS8weGIwIFtyZG1h
X3VjbV0NCls8MD5dIF9fZnB1dCsweDk2LzB4MjRlDQpbPDA+XSB0YXNrX3dvcmtfcnVuKzB4NjUv
MHg5Yg0KWzwwPl0gZG9fZXhpdCsweDIxNS8weDQ4OQ0KWzwwPl0gZG9fZ3JvdXBfZXhpdCsweDMz
LzB4OTYNCls8MD5dIGdldF9zaWduYWwrMHgxNGEvMHg5NjcNCls8MD5dIGFyY2hfZG9fc2lnbmFs
X29yX3Jlc3RhcnQrMHgxMGQvMHgxMmENCls8MD5dIGV4aXRfdG9fdXNlcl9tb2RlX2xvb3ArMHhj
NC8weDFiMQ0KWzwwPl0gZXhpdF90b191c2VyX21vZGVfcHJlcGFyZSsweDEyNC8weDEyYw0KWzww
Pl0gc3lzY2FsbF9leGl0X3RvX3VzZXJfbW9kZSsweDE4LzB4NDINCls8MD5dIGRvX3N5c2NhbGxf
NjQrMHg0Mi8weDg3DQpbPDA+XSBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg2ZS8w
eDANCg0KRGlzdHJpYnV0aW9uIG9mIG9sZF9zdGF0ZToNCg0KIyBkbWVzZyB8IGdyZXAgY21fZGVz
dHJveV9pZF93YWl0X3RpbWVvdXQgfCBhd2sgJ3sgKytzdGF0ZVskN107IH0gRU5EIHtmb3IgKHMg
aW4gc3RhdGUpIHByaW50ZigiJTJkOiAlZFxuIiwgcywgc3RhdGVbc10pOyB9Jw0KIDA6IDE5Mg0K
IDI6IDEwNTQ2DQogNjogMTAyDQoxMTogNTEzDQoxMzogMTQ4DQoNCg0KDQpNeSB0YWtlIGlzIHRo
YXQgdGhlIFZGIGluIHF1ZXN0aW9uIGhlcmUgZ2V0cyB3aGFja2VkIGFuZCB0aGF0IHRoZSBNQUQg
dGltZW91dCBoYW5kbGluZyBkb2VzIG5vdCByZXNvbmF0ZSB3ZWxsIHdpdGggaG93IENNQSBoYW5k
bGVzIHRoZW0uDQoNCg0KVGh4cywgSMOla29uDQoNCg0K

