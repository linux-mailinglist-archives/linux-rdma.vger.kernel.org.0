Return-Path: <linux-rdma+bounces-1324-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80895875802
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 21:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A486A1C21A15
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 20:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C19138481;
	Thu,  7 Mar 2024 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F9QIhhyi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="apdIQ0k0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70B41DA2F;
	Thu,  7 Mar 2024 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709842452; cv=fail; b=Tff4hmdmUAkxS7JmpZqRWswOGj3s4M9McrWFkWi1HORbUWPKcUioJ1dGO1C7JlL5QWQqZH1DU7gS4yqVWpIeYyHuTIBojsOIZLc3wMkbt7kh07iIYo5TOGH/W97YDb5/QGVLXVOZdBS4SLuI7PAxihZnLpGTS/+DHsA53fORgxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709842452; c=relaxed/simple;
	bh=f9KO4Dj6QO87Aweo7d9C5iHQ7tBphXkheTjIDszrE8g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G4WyGmkwt2UKaHERH0ZV6maFaN7bRwrZN3m0nLD37Ncmkh7omlI7QQjOyErLtG3ExuHAA+WXKx+jBjlgC6qc2/PNnx/pbBs+0zdiLMF96Jw9fGh/9q6tfgqo9rzRs/2Gxrk5qKFjKauJhKISzuKPiaVgCt0hgru62/1Xd7cmE58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F9QIhhyi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=apdIQ0k0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 427Jhpib011618;
	Thu, 7 Mar 2024 20:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=f9KO4Dj6QO87Aweo7d9C5iHQ7tBphXkheTjIDszrE8g=;
 b=F9QIhhyilAsqBmom+sYEvAHQXzgWX5FTvn+QSrzNuE3XSQMsU3BwoBMUouI274X1OMWB
 gOFUQGWdM6QQ7SdDdBi81fS3OmJBKJcHUr3mCTbVR5IYQ4F4e2JPpEw409siWtWRtaz7
 na+WmtO+/7X9owlRFuUMS6ilxKX6FtFica5n/fJsBty9ImLXgiYaCHyv4Fyh5lmZAo3j
 d6eXLXM+CUbIMQHgQNzhxT3gqRYs3SgdSfv72njVBF5zj+rbPhzrfK4xIhm8SLMhavcf
 JMojE6FEkbhdpZvzOO4s0XAPLh7BL/D7DkpR+CEi6epiuX1XIwOkE/ifeQM/XqesZFy4 pw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktw4d7sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 20:13:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 427JMoua013753;
	Thu, 7 Mar 2024 20:13:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjbhsyt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 20:13:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZ5EG/I5/BL5+kRXOEYUL/FzX6JdFsdptO/SsNVAbGFCi/nTH8jDylRfYRjH+EKddCajPgiMALf3jkqDEYTw3FqHvqYB6l+xjjt5yiLQ0jvT4iq+xLAI2oHCbWa4yJpp9cdulngI5l/cF7FTUhIGga8Z38UaFwRkoXS1SW9SUqnQPWvkWxNpaB6QXLtaZzmmwU7iOGDk2JW8AVpNaL+aoHAfE8IC1kiJws0m7wMZLbQULO94KGt3O9OMknh4Yk6fp1U/iGJCnTnD7HWnNwJKIqvbFBfA7KIFTd5L/XS+4KYIj2alXRqyvnhZBJHSYqQ745iSds4+CcFTAjRRC4NQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9KO4Dj6QO87Aweo7d9C5iHQ7tBphXkheTjIDszrE8g=;
 b=dyUa/Vio/AaZpjRERXT1VADCLEcCnYil6lCStg4QgisDxSr8ObEx6YbAuv4pgxt4T7j1ed26Xz83pnLkpXsibpE49Yo8cA7lQ+JEnB7VN7jsOUoqY7TKP0zgg0hu4ZUrzVxsx4s48IYj+iZZkDr8LCbDff7PcHq+HY4x3SKiECF+QT2chXPAy/wB90fHVsPZzsYa5C8QzpXFyCwQ5Am0GPLbP2DKqDqCx/4TSfOxcIZzsIc416jQrnZ+Pr9c3cgvyL9PVCtTVKCuM8aVmRsaMWHhxJDkHQi+BkPWwsDCQ5GcNvXGCagBW2dX5hDP7/rdaISLq93MftK1lJrzsb4Jxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9KO4Dj6QO87Aweo7d9C5iHQ7tBphXkheTjIDszrE8g=;
 b=apdIQ0k0CsaupGaCecswFM9OKGT6z0+GsaPNW5ZtauTPjekcX0T4KmtiOEkedVGUxoddhXXDUnnz2WWUMEwRg6+LR4MmJudS2GDK8yzi7o9rd+5ukD1G9FE/34sGqmIkqccZrZ47dBtgOPpSA43e0CpljhEmCoUgl49CZfuwGpI=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by CO1PR10MB4580.namprd10.prod.outlook.com (2603:10b6:303:98::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 20:13:50 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::fe4e:ebf3:2157:7f36]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::fe4e:ebf3:2157:7f36%6]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 20:13:50 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "woni9911@gmail.com" <woni9911@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "threeearcat@gmail.com" <threeearcat@gmail.com>
Subject: Re: net/rds: Improper memory ordering semantic in release_in_xmit()
Thread-Topic: net/rds: Improper memory ordering semantic in release_in_xmit()
Thread-Index: AQHab8bV9vqlSX7LYEW3f0DuYrtgRbEsuGCA
Date: Thu, 7 Mar 2024 20:13:50 +0000
Message-ID: <86d88699e8f22ebe0d45ffb5229fb73d78c5aae9.camel@oracle.com>
References: <Zehp16cKYeGWknJs@libra05>
In-Reply-To: <Zehp16cKYeGWknJs@libra05>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|CO1PR10MB4580:EE_
x-ms-office365-filtering-correlation-id: 58d3d57c-4f13-4134-e480-08dc3ee31a8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 XYN7373HNQstYwf2RLxGnlcUAJYEDCbkWwVJoQFfqgmMXdf0FHtaHZMwbmKJhP2GqQKbzh1QJvJquKHrLZgsDEnwdJjR6T4M6PQRIojhp73wpEjJoNiSBgmp/hnduCN/LGVYttXDnp97kBLMyQpb/ym2zaekD3v0DQ1/A5/NfgsSqOkfGoWK28m6aOt0tDxe1NxRY+UoGaFY3EiKX/hBG+618b/UqtpoB4OINRUb+9ZnPFT8MHPfNmgsGVZxv/ThU5mckMbzTJznCBc6KYNrJ6BGQlZr2P7iRJow3rQkA3MirdCgJ0+SsWbXK+e/k1Q94lLgewNimh2sNILop/h5p0dwqBb6/xSrbD+Nka0M1OU9XBJop25VmZmT2fCKmHuZKZF/3k8rlQbrM1ful0EJ6TdNv/Nn/C8uTqnAbCJ1U5oy6YD9Tb14UIPUwQGrH+ZZfF+aqKQ3xyQKhfvgLOdWNZ4LdPPE3hDVy25KHUjej+hgv6aauddG6dTQiIxPhBYbvd+a6YSzSidxIryLufWBTALUor/AfqJw12SzZsq/9OG+4Z8NSON7PmyO5wGOQAMOXXV1P1BlN3Ydtg3FPivnnd16pG50yYySWsJSbJfap4jVhTJvTjLOPu2nXfF36ZhTiGHW+5MkzcxwJjqDo8VID25jotgsyE/OVI8Bw+HSjxR7uXEpywHXeMqgT+BOtQ4rW5Iy2sTSwbgZ1CzmI8E6Rw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VkpJNFR2S3lmM1Z2ZkVJMkdZMmxQM2VIU0tkSG03ZCtqSlU3OUt2UlozMUdF?=
 =?utf-8?B?NkUzZ3JxcUZYN0lFQ0xBVFBDK2M1bW5RZEFaem9VOFhtZVcxUytTY2dWK2U3?=
 =?utf-8?B?bUp0UDhDVHkybG51S2FVU2ZXdDdiSWtXNGQyYnhWL0ZCcXRnWGVWdk5RS2FD?=
 =?utf-8?B?eGdwZ2dPUDcycHpSRktBSHBQOExZWktrRWsvZjFlSFRCVkZ4UkpuT0pkb3JJ?=
 =?utf-8?B?NlJXWVYxVlF1QU5lK3RxN2o4a0p4TUFwSy9YNFM1MTJJYStRaTVZa29BNkQw?=
 =?utf-8?B?am9oLzI3YjVsYTk3djh1Z0tHSkFGNkdlcFpkNktVbWRGQTc5R3pnaGJJTmhM?=
 =?utf-8?B?ZzVqTGFxbncrSVpJb3cwTVZRR0MzVlUrNDU2QTI3bS9Ma2kwZjFOTDkvdmdM?=
 =?utf-8?B?b3RUeVRDeG9hWlpuYzFuMUlJSHF2bHpNc2JWUWZSSVU5VWV0dldNRm1jcG1x?=
 =?utf-8?B?QVJxT1E1ZEQrV2RTZUtaL2h2WmJ5Wms5Nzg1eGFUNlFJNnQ5ckFMNjdmVkJT?=
 =?utf-8?B?ZklVQXRVVW5CbGpJUE53d2hUM1UrN0dLa2RpZlVOT3dJdmE0WWRrcGpZd0Yy?=
 =?utf-8?B?UmZhRzdVaVltSlJlVmFDbEdMS2JFN0swazRCZGtMR0ZhQXh3eDJMWVJjRXgz?=
 =?utf-8?B?SEtmQjcwZ2lLQzJrR0pOdlJZekNNQVRhTC9CWDJLWHZyMVpZNWZCQUZSY2Uz?=
 =?utf-8?B?Yks5R1RLcEpNN0lTdGNPd3dObWFSNGdIc2FsSkVsS05GRWIyTlNnajZ5dTlM?=
 =?utf-8?B?ang4eWN5QlJ1ZDNOYi9LQmNveHhSdzE2ZS8yU296UExydHZYY1lJZjkydmdB?=
 =?utf-8?B?aDlWUU5ZcHhhcWgyWFJhajJXY05PNnQyazRRNWwrdUlaVmdTUU1EY3VQS0lN?=
 =?utf-8?B?bGtMajRVUk9zR2EwZTIxZWtWNmlxcHBpKzFLREtGbDR5Y2hzVWxNMVkvQ3V0?=
 =?utf-8?B?cDZQZTZuQmVtZ01zOTJpd0xNMTBmNVR6SCtNYUhlMlR2aXFqcGlnK3hjMHZZ?=
 =?utf-8?B?cC9aNHYvZXdBYUphUTRMWVFmU0dRVWlFRjRGZWtBN3c3L0tCRkRpdkZzSno3?=
 =?utf-8?B?cUJ6a1hiYndTYTBFalBVVHVUaTIybVErTUxDUWVEQnRXaUZuUWVQMnFDNFg5?=
 =?utf-8?B?V3Z3Mi8yTEZPTXVqVHVFQ0VSbG5WUFZnRTFSNHY1MGxQc2VhQ2RtWlJQVUpE?=
 =?utf-8?B?U1hoKysyZWVKNDlCdkM2Q25wVUpFTjhaTUV1ODJNN1BFUmFtWTYybGV5K0Rj?=
 =?utf-8?B?THBxV1paaWI0Q3UwSEVLR3YzYklNclJOOG5nNVlZYklCYXZVb3pFZ284SDhY?=
 =?utf-8?B?RlM2UW16YlJ5TVJPOU5WTzhRaURoU3JrOUpvVmQxdzVZSDd1a1pEUHIzbnVS?=
 =?utf-8?B?S2plV0JiaXd2SnZ2dVpKNmN1aVJGdlE3UmlScjR5NGlkcVV4STl2SEpNYi9Y?=
 =?utf-8?B?NEtyVW1BZTN4WXZaWFNnOWtpRi9EcVJZaTZXU0wyejV6K2ZKTS9Ea096MjV4?=
 =?utf-8?B?aFlicWczd3NoNDRrcUZhdytBQ0dBdDc0OHVNcXRidkVyb1h4WEFHUlRsMzZX?=
 =?utf-8?B?c0pucWdOUExqZWpkTW5nYTVoWmlLV2RoNmZUUURibEFXd0tlZTI3T1Z0TThx?=
 =?utf-8?B?L0UreUx6UWdHdXlmcTdlNG1XT2QwQmtWcnpTME1LRnV0Z0hyak1mMW9sV0Rr?=
 =?utf-8?B?SnpkeUlnR1hySEw4K05rb1F0dDR3OU9SaE95Unl3NGUrclhuU1dITmJ5MEpn?=
 =?utf-8?B?NURIcGNRVkNJZzdOSmp2amZ0NzJ3VGhhYmpKK25PSC81dmUyNEFNWFhWeTl2?=
 =?utf-8?B?bGtZWnFBWEduc29tdzBEdnc5Wm4xS3FkdnJmMFN5Z1ZFUGtMNGk5MzF6L0FU?=
 =?utf-8?B?a3JjTzVqcFA1dW5iNHRURFdtV1gzN1JJS2xBcFBPbFJ1b0Z3eXhQekNZdS9q?=
 =?utf-8?B?R282OXVtK1FXN2VoU3NsQit4M0t1N1hUZTZGTlFUQU9kZWc3M3FteVBSaFZS?=
 =?utf-8?B?QzE5ek5kWXNBQm04ZHh5SURnSXhkUDFVVXNYOXhtanZ6Mit0T3dQRUM4REZO?=
 =?utf-8?B?RXZKZkFtbSt5NGg3VEdaWEtNREVWLzFraFVtMGNkZlFoaXlGbzBnZ1Q5R1BW?=
 =?utf-8?B?alhDWUg0QW1STmlCNWpCV0pqZjNpa0duVVF0Qy9VbUtUaCt3SGo4TlA5RHo4?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C287E0328A1B24AA8094986D7CF90FB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VGADNG+kg42dV9HP7/sbBE34G2ru3/dQPznjRr/z5PdYq38e7SCexB0D5UwsXQ2GoEkAyMDDfJCRl/mEBXY9TbcZpgQEgOz0H1PDtVeStF+6p+QkVEFcPU//wXEm9htMwe7cvuGINTdANRkM7Cr6HpTFVYV4A1VfJ5qv9H4SSTDw/7nLqHDMHmeuVtgTuDqhBGyhuMEg5p9tvV7Py+y4XzqTUpqYll249wN8BClKMyd49imqyTeZtTa4o1yB+edyr3Od4Znso9Jc5aZU64vk1Q6Lc+d31foR0qVydxKYs18Coc0QbKp3RPQdlzma7KFWbwvWRa0ycFrtkJwkM9REYW02ONoSRYr95mtcfhQ+2mS5tICkFRpzuNnvyTBhWFhcUxo6iwiAJh79niNARTGF5KWjxn90rjhQEscRlsZc5fEjXLKHWiLtHTEmPiLjbHxLLvyIbTbMJEJj60rIJzR6OG588S+pqHCuz5B8sBpnDYlr40BR/4ljhpidM8SVXfdcKkF0eqeU40YvyC6XPlseeKn2a4l5mq1tjdgL0sz2JRjxop5NSiLrM+upc2PqVTEo5uICIAUIVgMRscYEMPscuqOFCZykj81h/QCWDMAsBDg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d3d57c-4f13-4134-e480-08dc3ee31a8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 20:13:50.3455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9e5lIvGQGT5HCzLWl6UA5t3znCw5xlFfJ9UyP1a0vUb+q1eQPzMCC7QMLhW9INmPo1Hal/H5+vF/91h9wEhssBfC1FcCmzcBat0ELu7d+nA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4580
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=953 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403070142
X-Proofpoint-ORIG-GUID: qEBQDoHd0wIZJYvEPNZEDyivnhawZsQQ
X-Proofpoint-GUID: qEBQDoHd0wIZJYvEPNZEDyivnhawZsQQ

T24gV2VkLCAyMDI0LTAzLTA2IGF0IDIyOjA0ICswOTAwLCBZZXdvbiBDaG9pIHdyb3RlOg0KPiBI
ZWxsbywNCj4gDQo+IEl0IHNlZW1zIHRvIGJlIHRoYXQgY2xlYXJfYml0KCkgaW4gcmVsZWFzZV9p
bl94bWl0KCkgZG9lc24ndCBoYXZlDQo+IHJlbGVhc2Ugc2VtYW50aWMgd2hpbGUgaXQgd29ya3Mg
YXMgYSBiaXQgbG9jayBpbiByZHNfc2VuZF94bWl0KCkuDQo+IFNpbmNlIGFjcXVpcmUvcmVsZWFz
ZV9pbl94bWl0KCkgYXJlIHVzZWQgaW4gcmRzX3NlbmRfeG1pdCgpIGZvciB0aGUgDQo+IHNlcmlh
bGl6YXRpb24gYmV0d2VlbiBjYWxsZXJzIG9mIHJkc19zZW5kX3htaXQoKSwgdGhleSBzaG91bGQg
aW1wbHkgDQo+IGFjcXVpcmUvcmVsZWFzZSBzZW1hbnRpY3MgbGlrZSBvdGhlciBsb2Nrcy4NCj4g
DQo+IEFsdGhvdWdoIHNtcF9tYl9fYWZ0ZXJfYXRvbWljKCkgaXMgcGxhY2VkIGFmdGVyIGNsZWFy
X2JpdCgpLCBpdA0KPiBjYW5ub3QNCj4gcHJldmVudCB0aGF0IGluc3RydWN0aW9ucyBiZWZvcmUg
Y2xlYXJfYml0KCkgKGluIGNyaXRpY2FsIHNlY3Rpb24pDQo+IGFyZQ0KPiByZW9yZGVyZWQgYWZ0
ZXIgY2xlYXJfYml0KCkuDQo+IEFzIGEgcmVzdWx0LCBtdXR1YWwgZXhjbHVzaW9uIG1heSBub3Qg
YmUgZ3VhcmFudGVlZCBpbiBzcGVjaWZpYw0KPiBIVyBhcmNoaXRlY3R1cmVzIGxpa2UgQXJtLg0K
PiANCj4gV2UgdGVzdGVkIHRoYXQgdGhpcyBsb2NraW5nIGltcGxlbWVudGF0aW9uIGRvZXNuJ3Qg
Z3VhcmFudGVlIHRoZQ0KPiBhdG9taWNpdHkgb2YNCj4gY3JpdGljYWwgc2VjdGlvbiBpbiBBcm0g
c2VydmVyLiBUZXN0aW5nIHdhcyBkb25lIHdpdGggQXJtIE5lb3ZlcnNlIE4xDQo+IGNvcmVzLA0K
PiBhbmQgdGhlIHRlc3RpbmcgY29kZSB3YXMgZ2VuZXJhdGVkIGJ5IGxpdG11cyB0ZXN0aW5nIHRv
b2wgKGtsaXRtdXM3KS4NCj4gDQo+IEluaXRpYWwgY29uZGl0aW9uOg0KPiANCj4gbCA9IHggPSB5
ID0gcjAgPSByMSA9IDANCj4gDQo+IFRocmVhZCAwOg0KPiANCj4gaWYgKHRlc3RfYW5kX3NldF9i
aXQoMCwgbCkgPT0gMCkgew0KPiDCoMKgwqAgV1JJVEVfT05DRSgqeCwgMSk7DQo+IMKgwqDCoCBX
UklURV9PTkNFKCp5LCAxKTsNCj4gwqDCoMKgIGNsZWFyX2JpdCgwLCBsKTsNCj4gwqDCoMKgIHNt
cF9tYl9fYWZ0ZXJfYXRvbWljKCk7DQo+IH0NCj4gDQo+IFRocmVhZCAxOg0KPiANCj4gaWYgKHRl
c3RfYW5kX3NldF9iaXQoMCwgbCkgPT0gMCkgew0KPiDCoMKgwqAgcjAgPSBSRUFEX09OQ0UoKngp
Ow0KPiDCoMKgwqAgcjEgPSBSRUFEX09OQ0UoKnkpOw0KPiDCoMKgwqAgY2xlYXJfYml0KDAsIGwp
Ow0KPiDCoMKgwqAgc21wX21iX19hZnRlcl9hdG9taWMoKTsNCj4gfQ0KPiANCj4gSWYgdGhlIGlt
cGxlbWVudGF0aW9uIGlzIGNvcnJlY3QsIHRoZSB2YWx1ZSBvZiByMCBhbmQgcjEgc2hvdWxkIHNo
b3cNCj4gYWxsLW9yLW5vdGhpbmcgYmVoYXZpb3IgKGJvdGggMCBvciAxKS4gSG93ZXZlciwgYmVs
b3cgdGVzdCByZXN1bHQNCj4gc2hvd3MgDQo+IHRoYXQgYXRvbWljaXR5IHZpb2xhdGlvbiBpcyB2
ZXJ5IHJhcmUsIGJ1dCBleGlzdHM6DQo+IA0KPiBIaXN0b2dyYW0gKDQgc3RhdGVzKQ0KPiA5Njcz
ODExIDo+MTpyMD0wOyAxOnIxPTA7DQo+IDU2NDfCoMKgwqAgOj4xOnIwPTE7IDE6cjE9MDsgLy8g
VmlvbGF0ZSBhdG9taWNpdHkNCj4gOTYwNcKgwqDCoCA6PjE6cjA9MDsgMTpyMT0xOyAvLyBWaW9s
YXRlIGF0b21pY2l0eQ0KPiA2MzEwOTM3IDo+MTpyMD0xOyAxOnIxPTE7DQo+IA0KPiBTbywgd2Ug
c3VnZ2VzdCBpbnRyb2R1Y2luZyByZWxlYXNlIHNlbWFudGljIHVzaW5nIGNsZWFyX2JpdF91bmxv
Y2soKQ0KPiBpbnN0ZWFkIG9mIGNsZWFyX2JpdCgpOg0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9y
ZHMvc2VuZC5jIGIvbmV0L3Jkcy9zZW5kLmMNCj4gaW5kZXggNWU1N2ExNTgxZGM2Li42NWIxYmIw
NmNhNzEgMTAwNjQ0DQo+IC0tLSBhL25ldC9yZHMvc2VuZC5jDQo+ICsrKyBiL25ldC9yZHMvc2Vu
ZC5jDQo+IEBAIC0xMDgsNyArMTA4LDcgQEAgc3RhdGljIGludCBhY3F1aXJlX2luX3htaXQoc3Ry
dWN0IHJkc19jb25uX3BhdGgNCj4gKmNwKQ0KPiDCoA0KPiDCoHN0YXRpYyB2b2lkIHJlbGVhc2Vf
aW5feG1pdChzdHJ1Y3QgcmRzX2Nvbm5fcGF0aCAqY3ApDQo+IMKgew0KPiAtwqDCoMKgwqDCoMKg
wqBjbGVhcl9iaXQoUkRTX0lOX1hNSVQsICZjcC0+Y3BfZmxhZ3MpOw0KPiArwqDCoMKgwqDCoMKg
wqBjbGVhcl9iaXRfdW5sb2NrKFJEU19JTl9YTUlULCAmY3AtPmNwX2ZsYWdzKTsNCj4gwqDCoMKg
wqDCoMKgwqDCoHNtcF9tYl9fYWZ0ZXJfYXRvbWljKCk7DQo+IMKgwqDCoMKgwqDCoMKgwqAvKg0K
PiDCoMKgwqDCoMKgwqDCoMKgICogV2UgZG9uJ3QgdXNlIHdhaXRfb25fYml0KCkvd2FrZV91cF9i
aXQoKSBiZWNhdXNlIG91cg0KPiB3YWtpbmcgaXMgaW4gYQ0KPiANCj4gQ291bGQgeW91IGNoZWNr
IHRoaXMgcGxlYXNlPyBJZiBuZWVkZWQsIHdlIHdpbGwgc2VuZCBhIHBhdGNoLg0KDQpIaSBZZXdv
biwNCg0KVGhhbmsgeW91IGZvciBmaW5kaW5nIHRoaXMuICBJIGhhZCBhIGxvb2sgYXQgdGhlIGNv
ZGUgeW91IGhhZA0KbWVudGlvbmVkLCBhbmQgd2hpbGUgSSBkb24ndCBzZWUgYW55IHVzZSBjYXNl
cyBvZiByZWxlYXNlX2luX3htaXQoKQ0KdGhhdCBtaWdodCByZXN1bHQgaW4gYW4gb3V0IG9mIG9y
ZGVyIHJlYWQsIEkgZG8gdGhpbmsgdGhhdCB0aGUgcHJvcG9zZWQNCmNoYW5nZSBpcyBhIGdvb2Qg
Y2xlYW4gdXAuICBJZiB5b3UgY2hvb3NlIHRvIHN1Ym1pdCBhIHBhdGNoLCBwbGVhc2UNCnJlbW92
ZSB0aGUgcHJvY2VlZGluZyAic21wX21iX19hZnRlcl9hdG9taWMiIGxpbmUgYXMgd2VsbCwgYXMg
aXQgd291bGQNCm5vIGxvbmdlciBiZSBuZWVkZWQuICBBbHNvLCBwbGVhc2UgdXBkYXRlIGFjcXVp
cmVfaW5feG1pdCgpIHRvIHVzZSB0aGUNCmNvcnJlc3BvbmRpbmcgdGVzdF9hbmRfc2V0X2JpdF9s
b2NrKCkgY2FsbC4gIFRoYW5rIHlvdSENCg0KQWxsaXNvbg0KDQoNCj4gDQo+IEJlc3QgUmVnYXJk
cywNCj4gWWV3b24gQ2hvaQ0KDQo=

