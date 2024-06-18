Return-Path: <linux-rdma+bounces-3269-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FBA90D53E
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 16:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6A6288FA3
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 14:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F9714A4C8;
	Tue, 18 Jun 2024 14:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lr/k4fuG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VFdnYOau"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BC212CDB5;
	Tue, 18 Jun 2024 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720157; cv=fail; b=SDrnZnMFreJZV/Bcg/UEXf+KgHcgUY+31YSmqswfr9dUsGQ8/9F8EWK2QM/fk9Yk5sn93BKpEhEX5lFMqseHmze9YJ0PuU3aHqT2ohFQv+ZGIaRTetMamJmhLpEKyQD3TUhz9hULRv9Pn8jB+CwZO3ObDAHgI9smna1V6B0Y2m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720157; c=relaxed/simple;
	bh=j+U0GmB3QGqqElmhHLVL4AWpdhZzPQfUOnHKnVc0dH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e54IIVzEABfLHEHBDY2l/ZelV7pFNipNHpdkKH9ZMimmxqkVFVlQZEY+1wWWsj5pgvqKItZ25VTovTLRGpR3I8rpmCt1g8PCyEtWloX+86ZYM4EcR8x6e30zgKUsz+TcBKMN4O5uBYB0GruuTTivpoyxAlQS/XCb17lF2tfTdC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lr/k4fuG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VFdnYOau; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I7tQZK026674;
	Tue, 18 Jun 2024 14:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=j+U0GmB3QGqqElmhHLVL4AWpdhZzPQfUOnHKnVc0d
	H0=; b=Lr/k4fuGS4GQ6MmhgBP7/2FbagezvvVXPCRtg3YZ7togBkEZkqyK1eClJ
	VFqnZPstnyDYQ+gGaAVBqfzdIRpg3toXgRLnOkClXXXQ5OTj4PWI88XsIwcVPyHZ
	ECFy4f9zKG6fFv8DX95arPgyZL5kHjN38VXxN+OMj6CYO8VC9kDrYkOvwzIoUPzj
	YQx9SLk32pe62BmHl0QqKpv2ZGEvVulJlbbyxI1V0K81KWDKLvsyLMsd4/JdXddn
	pNEjXJ9VRf1C82o/wq2JH9P32zx4nU+LxTl/xii4YDj1X2aDnTfevEZ//6w2uj6B
	/Y73V0U6/e/P48M9P90XpGmFonLNg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys2js4y49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 14:15:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IE2gUl029122;
	Tue, 18 Jun 2024 14:15:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d84ewr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 14:15:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNyM0fjZXIONTIsnWGjUV3cDXCtlUKhp1L3RVs13lOrY8giX6S5+Qjawdd9XVVckT8ehvCZLcg4hUDsSjE7JUTxJblZwRQDD9iqDVkR/CGOKLym1NF/QTeSDP1Riws5gY0Jp8MG6jpMAqzZ2qQNnCC2/lCPm0cF9dUQhWk/8phasYXwV2RCRNvmmtieNh4X3ew0Ors89tVcO0FinlDUu1lFoDD70n5xwVPIQ1q5HuHXOQe3whVtsLf9ahNOTAn3UptG9zwhUGZHtZn3tCkZJwsaef82zZj2y7ZNXnaNnNZV9UanQXQ9a1+Z4wxnzWTJpOSF2TxFKfsy0bEcx2ak4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+U0GmB3QGqqElmhHLVL4AWpdhZzPQfUOnHKnVc0dH0=;
 b=ZO+K3uWqlpg1QLhsvjIsbIhrMLVy64jyMaGvZl46Ty0TiO4hU2eFyZ/ZkRrl+Jcsud0iXcpMDA28uKLyT6nb8v92uD6Q05tbAXDwJALdWysrpPRjMf5in8zkWH1GPb06zWMirZPXoAp0Xnhkm6QZdfTpKa8jwbHevjYPVyObCxjnIbrORIfmnGw1JRvee2XUDOC5rMTVemjXqzIyfq/3FMn3saD4GszxoCg0fpE3XYY8X8nMEcAe31EBaR5CPmtAVG/hdi8B9cruWZgI24cUBr++xlCvMFMJfbO+fM1QflwhBwx1727ydIVasMt9VuZMXe28U118OBcw4yFqxlP1Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+U0GmB3QGqqElmhHLVL4AWpdhZzPQfUOnHKnVc0dH0=;
 b=VFdnYOauA5oiBgBvF2GjEkDtkKPX4lf6eg0C38K/ArnodM0FSugdMj7gCHa2mhHKkclMjWGuEEvX3TCEvAvobMSuNFZsdNpvNinlUuJ+jeRZiBHP5gH9FhxyjJUVaIXcNQYYjPhioV05TTRfTHhuHsPfejtd9kX5R5WXcMpNIUE=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by CO1PR10MB4772.namprd10.prod.outlook.com (2603:10b6:303:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Tue, 18 Jun
 2024 14:15:27 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%5]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 14:15:27 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "lihongfu@kylinos.cn" <lihongfu@kylinos.cn>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rds:Simplify the allocation of slab caches
Thread-Topic: [PATCH] rds:Simplify the allocation of slab caches
Thread-Index: AQHawIuu/Loy1Kcan0yixV6fgYGcUrHNktYA
Date: Tue, 18 Jun 2024 14:15:27 +0000
Message-ID: <0fdfe2c864b404a607c852c8a33378497f5b769f.camel@oracle.com>
References: <20240617075435.110024-1-lihongfu@kylinos.cn>
In-Reply-To: <20240617075435.110024-1-lihongfu@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|CO1PR10MB4772:EE_
x-ms-office365-filtering-correlation-id: 0d40be94-5e4f-4ffd-2603-08dc8fa11a69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ZFAxL1JTTG5jd1B3dmcxMEtDcUFHVmlsSXQ5ZzBGUnlmdUpuWjZuKzNaNTUr?=
 =?utf-8?B?a0NQckJUdWd3ZitkcVdaN0JhU0VhT1NuVWdtVVczWEtNY3UyaE54K2w0eTl0?=
 =?utf-8?B?L3pHM2pOcEtvMTRrY01wYjIvcjJ4akk0akhudFBHTWRxbEFRSFRsQkNVVVBu?=
 =?utf-8?B?aExDTG1nQnNUOFZpdDdrSjk0UjhlYUFmUkNNeXhhZTYyUENRdlpnR3NWT3c1?=
 =?utf-8?B?TS91dVA5YnI0ODRQWlNDWnVpR0Y5VHdzaXJrQ3kyTk1RR0h0cHNKVDRnUWZL?=
 =?utf-8?B?QzRCRFEyWXlsc0dzak5zOThPT2UxTm1VMkNDRGxZNmIvYVR5QllBaUdPVTJp?=
 =?utf-8?B?aGd4RHFURzhJZFRVYklCOThmYkQrbENEbVJFOC9KbTNnWDNKMEp4U0pQa1dR?=
 =?utf-8?B?R3I0TitQcnc5UVJCMTVyVWlWWWcvRldqZGpBVmtFKzl6ejFSWVFYeXl3d3A2?=
 =?utf-8?B?eVlNRUdsNEx3RHNZa3poTUlGV1RTdUU2RUtUUi8zRDdNNDBUeHhLNzJiRDVa?=
 =?utf-8?B?WjZCQUNMakd6YUYvYk1qeitkdTl4dTdCYXlGMkRGdWJ1NDJPTUlyNWlnSU9C?=
 =?utf-8?B?bXFnVzdBaFRzSDNoei84YXIzYjhnUWhzTjJYZlVjR2E5T0p5RVFKTk1VN1dW?=
 =?utf-8?B?S1ZLdWZnR0pTaFdJVXl3Y1FpRHZNYllzQUY0cFBlZHNtMEtaWXUzeXB2ZXZn?=
 =?utf-8?B?eUk1QlFtU0l0MUNpbFYxQ1d0OXJVN3YzNFlYR20ycXR4dUhRNmlzTnU3WkdR?=
 =?utf-8?B?Z2drOWNwdzNzRHkrdkNrcGJ6SHhCa213SzZ2bVJiUXJjbDlYUHNoZ2dDY0dr?=
 =?utf-8?B?Si83ZkJJeDFTT2J2RUlWRUplZHdUQmJqSTRrSlJ6dUFnV3NDenNaRi90RnlD?=
 =?utf-8?B?ajZIdFZxUmpWc09kRXhSbFJjQjFqcEFvbmROTDhhY0tzNEtBZWR4QktrV1B3?=
 =?utf-8?B?WWxhalc4aFplYzA0U2NueTM4MjB4cDhSdThPSGx4eFljclVveStaVjFmcFZI?=
 =?utf-8?B?MkNWNTVudUkxa3VlZENwQmpVSGUxOXhRZUlENm1Ed0RuR0VTNmxjd2RWcnlX?=
 =?utf-8?B?MDQxTTBJeW00d3F2RTRkRHZUcGJ2TTlzU1ZsUkNSTWMrZk1WaVJWN09QQlpy?=
 =?utf-8?B?clA4b1B0ZGRjMTBWOEkxRnJDMWkxZXQwSjQ4eXFuVmxEUFVIcXRUVEtXWkU4?=
 =?utf-8?B?OXlNUFNFa09oUXFDUjhqdUxJaFNiaVplZU8vdmJQRkg4cHVreURVS2dmM1ZE?=
 =?utf-8?B?UEJsTGdZd2Z2TktqSWI4YUhJdlA4Y1ErRUtONHcwWlRPRytUQXZpejdDN3FX?=
 =?utf-8?B?ZXJxT01nSXJsVXJzQlorNlBBdERTQlF3UDFmRlZRWWZQcDNpczJGWTYyNEd2?=
 =?utf-8?B?TzhxenlXaTFuak1zbkN6WlpHMEMxeDk1bm4wRUdhdUFLZG9ibmIyY0N5YTNE?=
 =?utf-8?B?YUR2VUZOQkdSVmJhZXRaRm1CSEtkM1RvUUZ3QlR2RVg1aStMWHBZYmhaN09l?=
 =?utf-8?B?a2JQN2Q0ZjlsVnFHQUVCUDkrYldHalVJNDVjNzcyR3l5NzI4WFZuK0FOZTB3?=
 =?utf-8?B?Njgzck04REhsMWMwdTVIVCsvQStJU2o0aUJRQTlUU3FUMW5ac2l4OXhnNEtC?=
 =?utf-8?B?ZXJJUldwSXhPRTN6eEhjckpDSEdOMFp6eVg0Vm1jSi9JRm9jVWl4Qk8xTldI?=
 =?utf-8?B?QkhoZ1NBRVNEalRJS0Q4Y2xPTWNjOTdVR2JnSm5QaEVqYW9uQ3hySUVmNFFq?=
 =?utf-8?B?RVV1K2NTZnBHS1JHK3ZTT1MxVGt0TFE0NDFva1QxMVZaZy8zWGJYTnVoWGtB?=
 =?utf-8?Q?nHoHsAuPnGNQ2K6c9ZHux6W5iOwXWip2y0hkM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YTZpRjJUSUg4eTZwanVtSjZUa2hvYVhPc3B2OTI3dmpkbHJCUHVLVG1NcWR3?=
 =?utf-8?B?VGhZQzJJMzNvaGtueTBFeHhnUkU1b3lpbXJMS01jRUVZNUZ0RWFRdkJBUlhG?=
 =?utf-8?B?YVN6QmxVcjUwdkNvYyt0WUQ2ZnRObmIyRHl0ditPNVJRakFRQkFmdDBUdkIy?=
 =?utf-8?B?eDlBL2N1SVBDV3JmbVZDVTVZTUo3cUlBL1V1QTJ6cFFEWWsvam1zM3p6NXly?=
 =?utf-8?B?cG81dXdjYTU4NFlNQ08xdUd3Ykticjc2MGwydXRpWWROcG51UGxvTkJBK3M4?=
 =?utf-8?B?d0Vua0lINFFCOXBqR2UzL1BmL0lTNHJUeWxVTVdwcFJ6dmdTNlQ5UFNJOXpC?=
 =?utf-8?B?ZW9ZaDVvWEhlNkRCR28yUDNMQ2lsd0dqVXRkUDNoYm1CcUxDbTZkNHhFUTBG?=
 =?utf-8?B?R0FRRFBaT2ZYSTdlNXBvS1NxMlpzNUg3UW4xNG5QYXBzTGhRZFlQY0tpNmJa?=
 =?utf-8?B?NkxLYTZtdG1SUDFVVXlYYkFHMld2SjQzbkI5MDQrY2lxQis4b3FjYW1OS1Vk?=
 =?utf-8?B?ckl1dVkvYzZGbEFSdGZHWm10a3F0SFg0Zk0wSEFYS2tUQ1p4QWpoQklBek5M?=
 =?utf-8?B?MENoTEE2OEM3MmxXTEpyOW1QZkZGOXRNRW9UZUdlQ1c3c2U3WCtTRXpndVpG?=
 =?utf-8?B?OGI0NWZ5L2t1MmFXdGp0c1JObDF3S3FvRFgzWDlZQXF6b0dTZEdGZkJHVXBB?=
 =?utf-8?B?N2p1L3BkcWwzTkc4alk3VGxpVGViSXo5ckFZUTFjY0NCamp3ZFI1OTRHeEp3?=
 =?utf-8?B?ODRNVFhjMWtnUUQ1ZktLajRrODNzYmRvQ2RYOU5TME1uMU5NeWJ5VlNjZEt2?=
 =?utf-8?B?dWEyME5pNmhNL0J2dGJaNGI4STIyVU5tSXJhdUMxaE9VVnF2MGpFbnRybG9C?=
 =?utf-8?B?bTdmMExDUUhyelRTaDVHVFpYSGlFQ1BIeGJYOVFpWEpxTnkyN0h4VURRWTNM?=
 =?utf-8?B?eTJ6OWpKTGhiWG9TaVRvdnBudXBXSlpHcWNIcENzbERpbm9nMXlVOEJGdTdW?=
 =?utf-8?B?clM0Q21SOEZHeHEyWHNlQ1pkaEVtQkZVSTNzWlpVbW9wNmFmVUlmMWpaZTIy?=
 =?utf-8?B?aW9uZEpzREswM1JLa2Y2UlE0a2l3NFg2YmtleXcvckJxZW1uc2NtTlhHMG84?=
 =?utf-8?B?YkVZdDBWYnNJNUR3ZWJxbUFHaCtIcHBFazhkdVMrZ054WTd4a09LUVdLeG9O?=
 =?utf-8?B?N3NqUjZORHphM1dOVmlDRXZienVoRjRkTlg4MW43bkx0dm5oVlp0QXoxcEpX?=
 =?utf-8?B?dllLNklZMWZ4L21CUjVkRkF0U0hUaDFsSHl4em5lMEdlU3hrYVcxMzBpNUtV?=
 =?utf-8?B?MjlGSzVXQ3c2UG9qZlpVbHEwV3daVmVpd2h1U21XTkhSRERaZmFBb3UvbDJR?=
 =?utf-8?B?RVkrZmQwdFFaTHRZTnoxQmJmYnR6QXBoaE1JaTFRa2p5eU9iSWZHVTRuWENZ?=
 =?utf-8?B?a0w4T0xhZW0vMUh2ckpUdnYyNW9zWUpBc3AzdGcvelpMTWJBUGtlYTVVV2Fp?=
 =?utf-8?B?RlVXbmxjY1AwYVNiOXBoQ3BFYWppbk8rb1hkL2VaamtsTVRFY1R2b2FFSzll?=
 =?utf-8?B?MTZIMEYzalY5RjhpNzViVEp5Ykk4ZXV6MXRCV3lncW55Zm43VmdQcnJZZlNN?=
 =?utf-8?B?ZXFQZmkvUWxZdkdnZGg5bmpEU040cURHdGZpNW43dGk1amh6UTRzRGY2dlh4?=
 =?utf-8?B?aXRHV2pLcTJsSmhydW02bG5vTjdUYnc4Q0xCaEhIWTkxTlgybkRyck85SVJC?=
 =?utf-8?B?Q3M2cDNsNjA2a2laeDlpd05PL3FzZkFuMFhIUlp3U2paaGxZRDU1UGZvSVJl?=
 =?utf-8?B?TGMxSjRuWlhvUjJQaWdpUDdybXN6MkYra09oWmFja2FxZXY2VnhXejlOVVVu?=
 =?utf-8?B?WnVHbnN0eThwUisxaTkyUXkvS2pTQXpGZU15azRGenJJdVo3YXpOME5HM3Rr?=
 =?utf-8?B?VGVIN1oycUxGR3NhbDJFOXZFc04ra21uK2t6U0RZRUZrWkI2c2p0ZVBLZ2lW?=
 =?utf-8?B?cDc0eU9aTXhjbDdmdkdTRHhMb0tseUJuYmNibEZycWJUdUFLeGxZV2l3YjdK?=
 =?utf-8?B?TEZZMTl5aFpPckp1ZXNKZTloazlzME1XWXhkc0Qwc0F0WDV1Q0x5WXA5ZzJa?=
 =?utf-8?B?QmE1STRBMzhrekRiV0oxaWJIZDJWMHdMWkpyV2Q3a0YzRzljZmtiVHdWUmJp?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D898BFC9FF2FB34B86AE474FFDA61FF6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	naWzyqwNpdh++r3rBnNQSHxEciHyBSWzkp9oxClmwOrB8yLJ38zbYNetV8moUWU+o37seqc1IVbi3JKNjMmg6aMA099zy2g8G6VSquyc68vBeLxLQmVXCytCFWtT+BP0sZUuslT8xusesX0wS5+lKI4m1o7RiJ7+nr4bmbFCrEDnlTKXHJJY8IlgidgiyD4dKHdnCR0IqI+M+dB4tU7Y8sAzOcR90tW4hbgwvSxfkdcgt4XlMO5EiZtnx+WmegtyjzcpYCbjDaoITnhZ9/U9Mwe/+JakXd+Xr8Drj3dU4SUnCYOwr4leNEs9eI1jn15RXVFtkuJZcTgRIU+7lRSW39AvSmbiBaPqY69OsuMs4F6CkTLhLlF74CuM1PtlAj8P1CmM82EIP2+jhmAwjpRnuOgqXKYUUwELJIAMmHDQ5MNm9YtQjACN+HKbrKFZ3vAm10dqWShzx8/BbuvpfIinraLIAfTb0/KgX/XJTIiMcWRGYDdLgJMHd7kj+LaWBY0CQEpU2k0eHdRVhEq40xj6OdYywDxL4PdhNm3imsYlX60Mf0cHjES6wTCc7lLH4/is6ie45ou+SFANyjulLJv/wXdcH4Q4ejdwO5vZeIGfsKE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d40be94-5e4f-4ffd-2603-08dc8fa11a69
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 14:15:27.4975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TBfJTdBeKmNGeSUuz0EF/16APZfAr/JwPjwW85zDEbz8q42YxRj/tqnqY0fo6S4MrfYJQa2ZiTd8wfhCM8o72i8bCqI+ghfygi2cnv2mk2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4772
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406180106
X-Proofpoint-ORIG-GUID: BvGSD_ruVavexUJdKbaVGYRV48UyKx2l
X-Proofpoint-GUID: BvGSD_ruVavexUJdKbaVGYRV48UyKx2l

T24gTW9uLCAyMDI0LTA2LTE3IGF0IDE1OjU0ICswODAwLCBIb25nZnUgTGkgd3JvdGU6Cj4gVXNl
IHRoZSBuZXcgS01FTV9DQUNIRSgpIG1hY3JvIGluc3RlYWQgb2YgZGlyZWN0IGttZW1fY2FjaGVf
Y3JlYXRlCj4gdG8gc2ltcGxpZnkgdGhlIGNyZWF0aW9uIG9mIFNMQUIgY2FjaGVzLgo+IAo+IFNp
Z25lZC1vZmYtYnk6IEhvbmdmdSBMaSA8bGlob25nZnVAa3lsaW5vcy5jbj4KClRoaXMgY2hhbmdl
IGxvb2tzIHNpbXBsZSBlbm91Z2ggdG8gbWUuICBUaGFua3MgZm9yIHRoZSBjbGVhbiB1cC4KUmV2
aWV3ZWQtYnk6IEFsbGlzb24gSGVuZGVyc29uIDxhbGxpc29uLmhlbmRlcnNvbkBvcmFjbGUuY29t
PgoKPiAtLS0KPiDCoG5ldC9yZHMvdGNwLmPCoMKgwqDCoMKgIHwgNCArLS0tCj4gwqBuZXQvcmRz
L3RjcF9yZWN2LmMgfCA0ICstLS0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9uZXQvcmRzL3RjcC5jIGIvbmV0L3Jk
cy90Y3AuYwo+IGluZGV4IGQ4MTExYWM4M2JiNi4uM2RjNjk1NmY2NmY4IDEwMDY0NAo+IC0tLSBh
L25ldC9yZHMvdGNwLmMKPiArKysgYi9uZXQvcmRzL3RjcC5jCj4gQEAgLTcxOSw5ICs3MTksNyBA
QCBzdGF0aWMgaW50IF9faW5pdCByZHNfdGNwX2luaXQodm9pZCkKPiDCoHsKPiDCoMKgwqDCoMKg
wqDCoMKgaW50IHJldDsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoHJkc190Y3BfY29ubl9zbGFiID0g
a21lbV9jYWNoZV9jcmVhdGUoInJkc190Y3BfY29ubmVjdGlvbiIsCj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc2l6ZW9mKHN0cnVjdAo+IHJkc190Y3BfY29ubmVjdGlvbiksCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMCwgMCwgTlVMTCk7Cj4gK8KgwqDCoMKg
wqDCoMKgcmRzX3RjcF9jb25uX3NsYWIgPSBLTUVNX0NBQ0hFKHJkc190Y3BfY29ubmVjdGlvbiwg
MCk7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmICghcmRzX3RjcF9jb25uX3NsYWIpIHsKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IC1FTk9NRU07Cj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dDsKPiBkaWZmIC0tZ2l0IGEvbmV0L3Jkcy90Y3BfcmVj
di5jIGIvbmV0L3Jkcy90Y3BfcmVjdi5jCj4gaW5kZXggYzAwZjA0YTFhNTM0Li43OTk3YTE5ZDFk
YTMgMTAwNjQ0Cj4gLS0tIGEvbmV0L3Jkcy90Y3BfcmVjdi5jCj4gKysrIGIvbmV0L3Jkcy90Y3Bf
cmVjdi5jCj4gQEAgLTMzNyw5ICszMzcsNyBAQCB2b2lkIHJkc190Y3BfZGF0YV9yZWFkeShzdHJ1
Y3Qgc29jayAqc2spCj4gwqAKPiDCoGludCByZHNfdGNwX3JlY3ZfaW5pdCh2b2lkKQo+IMKgewo+
IC3CoMKgwqDCoMKgwqDCoHJkc190Y3BfaW5jb21pbmdfc2xhYiA9IGttZW1fY2FjaGVfY3JlYXRl
KCJyZHNfdGNwX2luY29taW5nIiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2l6ZW9mKHN0cnVj
dAo+IHJkc190Y3BfaW5jb21pbmcpLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAwLCAwLCBOVUxM
KTsKPiArwqDCoMKgwqDCoMKgwqByZHNfdGNwX2luY29taW5nX3NsYWIgPSBLTUVNX0NBQ0hFKHJk
c190Y3BfaW5jb21pbmcsIDApOwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIXJkc190Y3BfaW5jb21p
bmdfc2xhYikKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRU5PTUVN
Owo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKCg==

