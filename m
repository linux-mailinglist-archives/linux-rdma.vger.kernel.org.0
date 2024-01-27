Return-Path: <linux-rdma+bounces-773-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8D783E7DE
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jan 2024 01:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F56D1C21882
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jan 2024 00:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C34187E;
	Sat, 27 Jan 2024 00:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cf6bDj5g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wdSWzufc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742A11FAF;
	Sat, 27 Jan 2024 00:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313646; cv=fail; b=LpaCzhZgCubsbE4X7inylkygwtLvpBjfL+VQp8f+eX/kiXBqmTV/zPuDBSi7Q9HcT07zb/HoX0FSU0EnqQOZw7r31EO9ajbmVxkUirT6AhnQZ1X5c0wG7JaGMy4kNp1GBgF4LgULqbhmH62u8m5yHG/bviIGBZjmYY6tHUhHFMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313646; c=relaxed/simple;
	bh=TkkktTtzt1BJsfE9ai01xnD4Bh2bPzEcpK0UPT/SQAA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hkKVqwvz/chq5j2Yjp55+g1KvrigQ5rHnyWa80cB+C5pmLblYhHScJaMkdo/OAP6SSWCS16T7xbcWpTpZoPQEkDyoiPGExStpIjo9BFjV+vIYo18p1eta2gtNoHUOQYyv8GKNXwyOybJIvO0TQZIeDnlNXbX4pJRqsmOCqEFmOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cf6bDj5g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wdSWzufc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40QLLHJ5018779;
	Sat, 27 Jan 2024 00:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=TkkktTtzt1BJsfE9ai01xnD4Bh2bPzEcpK0UPT/SQAA=;
 b=cf6bDj5gIsegwsdYR7kRrGxwuvO3hhnqg1tf3Azt4Qxcp3inr+nko66HoppV0wM5+sJb
 LX2+b4HEq1+rHsIaRwD+kEtqhL54I4JX3f4WeA8pRbRqGbQrs0IbuUgSQey/cXbC4lBz
 MKD5/16k6iEgE64ioNGMZ6QeFGebbS2PXuN6xguKSP4KYddbvRK+CbuicCYGLkUxtIPm
 jrwmqBCKYDGGOpcLuU76PKwc8J0Ki0R0iRvjbbg5r8FYpZI4S4L8uzfjDISyWacyrk+q
 8puQunxoxhsEW85nV0+CL8ybISZnuGDitgBrGuBTrSqpMWXEqTR2Njt7f57G6XDbyC69 DA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vutwx3x1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jan 2024 00:00:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40QMnfhu026107;
	Sat, 27 Jan 2024 00:00:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs31b1fhf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jan 2024 00:00:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANJv1xFA+pIakEuBpY4Q9yqmqvwkb8M5QOGoOTJjYnRnTBrGhVM6mS/vNngPZD96w8OyHmzLT9J0bPMiIYtWP6LqvFQ+v7dl3154iGyB1+py6HEP+PW19FXpQ//dlG1jZ47wrxusIYq1SfHaBN3SICJSHQWz+bzGjnYuDhuIBpD2fKWWwkjYhYtSvzW14DQb5UyASOGTNe817kMK/RX9aIStbrWMNcANGBs2uvaf256umZ8OPeN25zGUlKRbpVXawzoNhqW9UwxUyz0nQYSZ9Rhsc34o1aOt8T2KbOyDMZGcsXtbhLjIdK5IQL8eO6hL08/e2QNvduo2MhNRaLq8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkkktTtzt1BJsfE9ai01xnD4Bh2bPzEcpK0UPT/SQAA=;
 b=GGvuSEFZ1I+jmF+eGcQqbmxW8za6WC46xi6oIcnqVc6gdEGn79ya6GycwG/P9ikhvbl7ItUu53HQVrATA/+9WBIa5wwVWJLzKg0G9lIZX7vyHSP9uL9ebiSF+W7q9vcpm51NGEuB/PYl3MroVtXRHM/hswLV1O9T/R3IrUS33QoTOFKff4w6HhsuWcV2xXIzpS/cxtl0/lMSh8x1Q5RLVjndLBVBv5569rmz2529Vqh0v8vdeM7k8IsgJmLVXZHxG3Q0kHf6C0tqumAlinktfrsgszPYObXDO9bkcnG+PJt4znMQf8kK8ZmDRyFVwWk9+YTgc4snPltCCWY2ZQXvCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkkktTtzt1BJsfE9ai01xnD4Bh2bPzEcpK0UPT/SQAA=;
 b=wdSWzufcJCJWERRXz9qR8Qr7RjgdG68Q/x7bxty1s/Z6qIB0rrQ8X6QS2o/nBVMoK0nHI4BgfdQbz8ZjUlxAUgm2rR06lduBDhg3CgR4CTL+Opc40VK+qebWCOdpYMddXUEItGW/3xVcYqGd801xCfGLyqaGam+SeYW5B9FhjbI=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by IA0PR10MB7136.namprd10.prod.outlook.com (2603:10b6:208:409::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Sat, 27 Jan
 2024 00:00:14 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::8cde:f1f2:6ec5:fbe4]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::8cde:f1f2:6ec5:fbe4%7]) with mapi id 15.20.7228.028; Sat, 27 Jan 2024
 00:00:14 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Santosh Shilimkar
	<santosh.shilimkar@oracle.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "chenyuan0y@gmail.com" <chenyuan0y@gmail.com>
CC: "zzjas98@gmail.com" <zzjas98@gmail.com>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: Re: [Linux Kernel Bug] UBSAN: array-index-out-of-bounds in
 rds_cmsg_recv
Thread-Topic: [Linux Kernel Bug] UBSAN: array-index-out-of-bounds in
 rds_cmsg_recv
Thread-Index: AQHaSuPoqrBq7FRRfkKN9r2A2oY9ZbDj86cAgAFj2QCAADJvgIAHR+OA
Date: Sat, 27 Jan 2024 00:00:14 +0000
Message-ID: <8dc57a5a51783495878c9f43f2fc39d6898dd043.camel@oracle.com>
References: 
 <CALGdzuoVdq-wtQ4Az9iottBqC5cv9ZhcE5q8N7LfYFvkRsOVcw@mail.gmail.com>
	 <27319d3d-61dd-41e3-be6c-ccc08b9b3688@linux.dev>
	 <c4cd5048-1838-4464-ba79-26cc595e380f@infradead.org>
	 <9f7eb287-543f-4865-90ca-b853e04ff126@linux.dev>
In-Reply-To: <9f7eb287-543f-4865-90ca-b853e04ff126@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|IA0PR10MB7136:EE_
x-ms-office365-filtering-correlation-id: a6bedb02-8068-4e85-1ccf-08dc1ecaf068
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8B2jofVnTSGmwO/SmIXQw+4er6RM0ezhUYSze74n0xNv5opXPHKO15dNTL3iC1unONr1bLWupdebmMPR4xJbN+21h7bPS8T7ZFE4KirPvbfJXnAnVs/dyN6WFso8WKlauSXkl4rdYDHqf/WTCaOWoEiizVRKBGMhA92Q8MeL2hE6jStPP7JtrJGv8rMyMJCEkIMxsjOMzBwA7mMu6OfYLdKoFiSWUlnxJG082ebu7Y03XivWg9EwUGGn0kT93zl+0NZa0JVcTkxSJhzW0GpCsgzgX/7a1O1rDnMGuYdBP2GeWPXtIvalq64n0tk7p1I2oKbCA0xCrvubLjnh6kc2vZ7frlS0Cpp7rCtjubBJvHDmtm5gVDgEGsi706KlW6tD3agKFwGFIR6Ebu95TlS+8NajpbuW8/ht+0jnGLAYrcOBhc037B/Jz7YzEKHNtc4pyfZMLYAOid5XwauErvDB99sSxtEesI77U3aoDO0ikQTka5f31ICVLZuwy7Kg8kgOgf9v/hjmm2HDlrTDOXULRdJ0PKRlnOXgwiqXROVqE4WQc+hbg+MZlQ5/1BnCvCCjXk5hWi0BxRZNSs5kuNGpGiIekWeUj58bimYExKqJhy8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(376002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(71200400001)(26005)(6506007)(2616005)(966005)(66476007)(66946007)(110136005)(64756008)(54906003)(66556008)(5660300002)(86362001)(76116006)(66446008)(44832011)(38100700002)(122000001)(83380400001)(19627235002)(6486002)(53546011)(6512007)(8676002)(478600001)(8936002)(4326008)(36756003)(38070700009)(7416002)(316002)(41300700001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eFpaRUVWbVdkVnFTeVlCcURuUE04N2ZiWkN3VzBSTDU0c0dLS0J6bmVVV2xI?=
 =?utf-8?B?NGt2WmhEM2lPQXRRYzdWTUswL3JVaHp0Z0ZMaU9zSkwvU3dyS2FPN0dYYTcw?=
 =?utf-8?B?Qm94Sm43Rnh5cWdRVVdwUDlDZWpIbGdwRDE4cTZlcmIyeDljWHJCSnJQRjUv?=
 =?utf-8?B?TWJFMDRLZlMwek8xdmJCNFp4TjFWS2l0UVZYYkRRbWJjbDdQZU00UFpmL3h1?=
 =?utf-8?B?VHZid3EwaG4xdmZsWERveFFWdU9EOUk5dE9SaWVMWW5jcS85ZEFLY3F0d0Vj?=
 =?utf-8?B?ditUVENFVFFvT28yWnFvNFV3S01JaWhDRHJRRGJNYWpBeUtPZjN5ZmdGWHBF?=
 =?utf-8?B?MFNmQS84ckdWMWRUQWRkUm1CN1lUMURUbU0zTzRPR1ltTmd0U0hxK0pRaTI4?=
 =?utf-8?B?SFh3NUhJVTlTbEN0aTZsazh1L1h4aVFSbHB3K2xJeU8wV1hGVTlVNkNxeFA0?=
 =?utf-8?B?QnB4SkNuaGthVTdTZ0JONEViZ051VWNpV1IxK3hZTm80VjUySzlRVjVVcmgz?=
 =?utf-8?B?OUtWdzNReE1SRHJTNTJhSVdMS2M0bDN5WFF5bjRLK0ZON1BJdEdQSkxDbVNi?=
 =?utf-8?B?SFczL3dyN1BUeHVBY0VQSC9rbG0zSzN1ZHY5Y1VXNzdmKzFaSEx4RnYrUkhs?=
 =?utf-8?B?Nk5GZGdSSlhkOGVTRm5BbU5WVTRFb2RFQVZudk9WcHRuRUZ1emVDUVZZNlpn?=
 =?utf-8?B?d241bmt3cEE2L2cwZERKREt2MlRmVnkycXN5emJGci9CS1VjOHBnOGhXQmEv?=
 =?utf-8?B?YWJiNDJjL1JmMUM0eUxBVjFRRnZvelhvZFFKYU1NT29tampPZSs4aHYxcXRJ?=
 =?utf-8?B?UUM4MnVlNkJ1WTl0bExRVkxFYzl4M0ZQejVKb3RqR3V4T0l3ZXd5SUQrNk5E?=
 =?utf-8?B?eHNOSEl1T1dhalVSd1RrekIwSjM2TEJnZ3NDd3N1VSszdHRUYkdaY2x0YXFT?=
 =?utf-8?B?eGxIaWlqYXByTDg3QklkNHNCVWdDbnhFUWExdmRkeGJ4SVNhYjRubnBaakNz?=
 =?utf-8?B?NE0yQWRlUUQ1c3ZOeU5VTEErUXM2YXk3OXlMd013SnMzdmRFbUVWVjFUdnFv?=
 =?utf-8?B?elhoc1RJSFFhUXBWM1lMVDBLd2lCZVdFaEJQZG5RYVlYUmdGTVBHZm00RGtj?=
 =?utf-8?B?VHVpcVh5OTFETXNXUDVQaWxFczdkVnZCSzZFVysvVnM3QmlzZUJXa3RHY3Bm?=
 =?utf-8?B?dmxCUHVKcVRvSHZQcFcxVkpoL0R6Wk15YXh2bUVVbldlT1hBMW9KWFZDc3No?=
 =?utf-8?B?b1MrOENkZXRyWXk4N3YwMnVRbjFrT3VKK3dja2hiN1BWRUFhZGEwUkgzbTd0?=
 =?utf-8?B?N1Nlek1PSmgxNU9KR24wQVdQZnNpVVd3ajRQYTcrc2RnaW8xcm5nV3BjdXBL?=
 =?utf-8?B?YWhFOWs1T2FmWGxuWi9vM0NhR3lraVZZM3ljRDRTenhCa3hRN0JHMHV3MW4y?=
 =?utf-8?B?Z3lvaFJISm01LzNqY0Z2S2hsZVlOSlIzZjJpWEQ1U0h4VmRERDJXSWIrekV4?=
 =?utf-8?B?YVJlUmltZVBzSytqbndWN0Q5aXdSWEx5bXZUTk5rdmFvVlZiN0lvSm1HMzZm?=
 =?utf-8?B?cVBNRTkvZHMwbElPZk85NEVjV1Q2WE5xSEtmM0tlMmxYaEROeXgvWlBQLy9t?=
 =?utf-8?B?RWxJT2ZLUjJtajNDNllwN1RBSm83OEF2T3ZCRkJDNUc1UUU5L1ZWOFBVRXh0?=
 =?utf-8?B?a2QrcStKVC8xR2FKY0tneCtES1hsbDI5RmpXMDdoZWVCNDZma1RwK0J4WC9E?=
 =?utf-8?B?d3FyR1pEMDdwQk5DM2ZwR0dhQlRmWnFXa2I1NTRUVSt6elYveUNYaEVrcTdG?=
 =?utf-8?B?QWxtK3VBWFB0dGVuTDAyRjMweERyVHJJWDZJemE4U1hVWVhTU3pjbHpSWmUx?=
 =?utf-8?B?dGZUVmVlb1VPSXNwRTVrN0l5TDloWFk1c1BBZmVXaVg0OUZka2JheHV3aDRJ?=
 =?utf-8?B?Ui81WFN3a0hCTXpla2Z5QldTV054VG5iWThQbkZOb1hrZFVTWHdQOVVZMW5v?=
 =?utf-8?B?MkhjOXFzSjZPM2YzSktHTXQzWHg1YVE5T1lnZ3BEd1dkSDh1V01MNDc3Z2hW?=
 =?utf-8?B?eFE4S2dKbS9idlZUS1Z3ODNtVGZhQ3FPSnFOZW9qdXlxNWVXaWNmeGJxbFRq?=
 =?utf-8?B?UnlEcUEyK1h0dHc3amdjZHVsSTVQc1RNSjBJVHRDNktPdjBqNmNYSWRYQXNC?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <603CA78CF6B3A84E88677650AD0FC4C1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	woARqtk5nM7NktmQghRTrpURvli7RdVkNyB1RwPAIhuI2W2OixgRDXyEuCofdJ8tQSmBpyJcbuYuQDtKo0YWgp/ofjhT41q78SW+zHhX+N2lnjcDHeP3WVGrp30j+xAycVEOxqjHxZgZjwzVgbl+5MshSSL0yuLcS8lEQbYc1tPEcw5ZvRPIVSd3xb8whw16DZcBKv0MMnRlI+uZrLxPULXFDMR/5Jyw+kYzkZPV45o61rCtnXxBPvnkfMtKvcbP9DXcgi+fN76c6LMYsRNY2TLYX5y7zTi2vyTGAVNd/hhDCHulrfD96DGKAvVlUviHed7rpXFpGcSE79sqjblAkLqG6Sl55a1GhwmgKequdGIla0l6ap+gJjgy6edXcPTDHXvvqA2aog2Dnke40GXSKUDRSVTkCC+hg4BD4TMb/XgRFI+GK+Uj51ZTJr2+aoI+Q35vJfi9AvmSXJnryYJ9foN0fdqgZl+PLYXH7brHCvz+tOozA/3yBYNHtuQkuZGf6uB9MUKngom7M6v3xEb8Buiyqdfw3X6+0SHyt8Kpx7kfYnOzjVfefGpicY2sqsu5F1Jg4SZSumq/Z6HhqZdjFSZoos6MwCVpEeF4RTHuXbQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bedb02-8068-4e85-1ccf-08dc1ecaf068
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2024 00:00:14.5016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E6ONHLLH9fkP/uSvml62aQ6juA7byxNoNVRwJC3xWjd5Pl2a0Q50Z4j1pyKencsL6YQRw/IHgLlpJHOYc0Cqmqjf8BVygZGFLMZ7o74PrU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260177
X-Proofpoint-ORIG-GUID: 2-1yduUKT_Ei54vMhlpd_rU20gper3qh
X-Proofpoint-GUID: 2-1yduUKT_Ei54vMhlpd_rU20gper3qh

T24gTW9uLCAyMDI0LTAxLTIyIGF0IDE2OjQ5ICswODAwLCBaaHUgWWFuanVuIHdyb3RlOg0KPiDl
nKggMjAyNC8xLzIyIDEzOjQ4LCBSYW5keSBEdW5sYXAg5YaZ6YGTOg0KPiA+IEhpLA0KPiA+IA0K
PiA+IA0KPiA+IE9uIDEvMjEvMjQgMDA6MzQsIFpodSBZYW5qdW4gd3JvdGU6DQo+ID4gPiDlnKgg
MjAyNC8xLzE5IDIyOjI5LCBDaGVueXVhbiBZYW5nIOWGmemBkzoNCj4gPiA+ID4gRGVhciBMaW51
eCBLZXJuZWwgRGV2ZWxvcGVycyBmb3IgTmV0d29yayBSRFMsDQo+ID4gPiA+IA0KPiA+ID4gPiBX
ZSBlbmNvdW50ZXJlZCAiVUJTQU46IGFycmF5LWluZGV4LW91dC1vZi1ib3VuZHMgaW4NCj4gPiA+
ID4gcmRzX2Ntc2dfcmVjdiINCj4gPiA+ID4gd2hlbiB0ZXN0aW5nIHRoZSBSRFMgd2l0aCBvdXIg
Z2VuZXJhdGVkIHNwZWNpZmljYXRpb25zLiBUaGUgQw0KPiA+ID4gPiByZXByb2R1Y2UgcHJvZ3Jh
bSBhbmQgbG9ncyBmb3IgdGhpcyBjcmFzaCBhcmUgYXR0YWNoZWQuDQo+ID4gPiA+IA0KPiA+ID4g
PiBUaGlzIGNyYXNoIGhhcHBlbnMgd2hlbiBSRFMgcmVjZWl2ZXMgbWVzc2FnZXMgYnkgdXNpbmcN
Cj4gPiA+ID4gYHJkc19jbXNnX3JlY3ZgLCB3aGljaCByZWFkcyB0aGUgYGorMWAgaW5kZXggb2Yg
dGhlIGFycmF5DQo+ID4gPiA+IGBpbmMtPmlfcnhfbGF0X3RyYWNlYA0KPiA+ID4gPiAoDQo+ID4g
PiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2VsaXhpci5ib290bGluLmNv
bS9saW51eC92Ni4NCj4gPiA+ID4gNy9zb3VyY2UvbmV0L3Jkcy9yZWN2LmMqTDU4NV9fO0l3ISFB
Q1dWNU45TTJSVjk5aFEhSjhRR0czZmlfTzBnDQo+ID4gPiA+IDZwM29PYm9xTmo1QnVUY011THVG
LTctDQo+ID4gPiA+IFNBVG1OajhFRlRLeUM2OGNvNmNub0c2TFF6WTFsSjlNX1hBNnZvRXJPZmot
cVhUcTNCU25XMjFUayTCoCkuDQo+ID4gPiA+IFRoZSBsZW5ndGggb2YgYGluYy0+aV9yeF9sYXRf
dHJhY2VgIGFycmF5IGlzIDQgKGRlZmluZWQgYnkNCj4gPiA+ID4gYFJEU19SWF9NQVhfVFJBQ0VT
YCwNCj4gPiA+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZWxpeGlyLmJv
b3RsaW4uY29tL2xpbnV4L3Y2Ljcvc291cmNlL25ldC9yZHMvcmRzLmgqTDI4OV9fO0l3ISFBQ1dW
NU45TTJSVjk5aFEhSjhRR0czZmlfTzBnNnAzb09ib3FOajVCdVRjTXVMdUYtNy1TQVRtTmo4RUZU
S3lDNjhjbzZjbm9HNkxRelkxbEo5TV9YQTZ2b0VyT2ZqLXFYVHEzQllYM3lWRm8kDQo+ID4gPiA+
IMKgKSB3aGlsZQ0KPiA+ID4gPiBgamAgaXMgdGhlIHZhbHVlIHN0b3JlZCBpbiBhbm90aGVyIGFy
cmF5IGBycy0+cnNfcnhfdHJhY2VgDQo+ID4gPiA+ICgNCj4gPiA+ID4gaHR0cHM6Ly91cmxkZWZl
bnNlLmNvbS92My9fX2h0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2Lg0KPiA+ID4g
PiA3L3NvdXJjZS9uZXQvcmRzL3JlY3YuYypMNTgzX187SXchIUFDV1Y1TjlNMlJWOTloUSFKOFFH
RzNmaV9PMGcNCj4gPiA+ID4gNnAzb09ib3FOajVCdVRjTXVMdUYtNy0NCj4gPiA+ID4gU0FUbU5q
OEVGVEt5QzY4Y282Y25vRzZMUXpZMWxKOU1fWEE2dm9Fck9mai1xWFRxM0JWVGFhTmt4JMKgKSwN
Cj4gPiA+ID4gd2hpY2ggaXMgc2VudCBmcm9tIG90aGVycyBhbmQgY291bGQgYmUgYXJiaXRyYXJ5
IHZhbHVlLg0KPiA+ID4gDQo+ID4gPiBJIHJlY29tbWVuZCB0byB1c2UgdGhlIGxhdGVzdCByZHMg
dG8gbWFrZSB0ZXN0cy4gVGhlIHJkcyBpbiBsaW51eA0KPiA+ID4ga2VybmVsIHVwc3RyZWFtIGlz
IHRvbyBvbGQuIFRoZSByZHMgaW4gb3JhY2xlIGxpbnV4IGlzIG5ld2VyLg0KPiA+IA0KPiA+IFdo
eSBpcyB0aGUgdXBzdHJlYW0ga2VybmVsIGxhZ2dpbmcgYmVoaW5kP8KgIElzIHRoZSBSRFMgbWFp
bnRhaW5lcg0KPiA+IGdvaW5nDQo+ID4gdG8gc3VibWl0IHBhdGNoZXMgdG8gdXBkYXRlIG1haW5s
aW5lPw0KPiANCj4gV2hlbiBJIHdhcyBpbiBPcmFjbGUgYW5kIHdvcmtlZCB3aXRoIFJEUywgSSBo
YXZlIHBsYW5uZWQgdG8gdXBncmFkZSANCj4ga2VybmVsIHJkcyB0byB0aGUgbGF0ZXN0LiBCdXQg
YWZ0ZXIgSSBzdWJtaXR0ZWQgc2V2ZXJhbCBwYXRjaCBzZXJpZXMsDQo+IE9yYWNsZSBEZXZlbG9w
aW5nIENlbnRlciBvZiBDaGluYSB3YXMgc2h1dGRvd24uIEkgY2FuIG5vdCBmaW5pc2ggdGhlIA0K
PiBwbGFuLiBCdXQgdGhlIFVFSyBrZXJuZWwgaW4gT3JhY2xlIGxpbnV4IGhhcyB0aGUgbGF0ZXN0
IFJEUy4NCj4gDQo+IElmIHlvdSB3YW50IHRvIG1ha2UgdGVzdHMgd2l0aCByZHMsIEkgcmVjb21t
ZW5kIHRvIHVzZSBVRUsga2VybmVsIGluIA0KPiBPcmFjbGUgTGludXguDQo+IA0KPiBPciB5b3Ug
Y2FuIGluc3RhbGwgVUVLIGtlcm5lbCBpbiBSZWRIYXQuIElNTywgdGhpcyBVRUsga2VybmVsIGNh
bg0KPiBhbHNvIA0KPiB3b3JrIGluIFJlZEhhdCBMaW51eC4NCj4gDQo+IFpodSBZYW5qdW4NCg0K
VGhlIGNoYWxsZW5nZSB3aXRoIHVwZGF0ZWluZyByZHMgaW4gdXBzdHJlYW0gaXMgdGhhdCB0aGUg
dWVrIHJkcw0KZGl2ZXJnZWQgZnJvbSB1cHN0cmVhbSBhIGxvbmcgdGltZSBhZ28uICBTbyBtb3N0
IG9mIHRoZSB1ZWsgcGF0Y2hlcw0Kd29udCBhcHBseSB2ZXJ5IHdlbGwgd2l0aCBhIHByZXR0eSBi
aWcgcmV2ZXJ0IHRvIGJyaW5nIGl0IGJhY2sgdG8gdGhlDQpwb2ludCBvZiBkaXZlcmdlbmNlLiAg
SXQgbm90IGVudGlybHkgY2xlYXIgaG93IG11Y2ggcmRzIGlzIHVzZWQgb3V0c2lkZQ0Kb2Ygb3Jh
Y2xlIGxpbnV4LCBidXQgd2UgYXJlIGxvb2tpbmcgYXQgaG93IHdlIG1pZ2h0IGdvIGFib3V0IHVw
ZGF0aW5nDQphdCBsZWFzdCB0aGUgcmRzX3RjcCBtb2R1bGUsIGFzIHdlIHRoaW5rIHRoaXMgYXJl
YSB3b3VsZCBoYXZlIGxlc3MNCnBhdGNoaW5nIGNvbmZsaWN0cywgYW5kIG1heSBiZSBvZiBtb3Jl
IGludGVyZXN0IHRvIGNvbW11bml0eSBmb2xrcy4gDQpUaGlzIGlzIHN0aWxsIHZlcnkgbXVjaCBh
IHdvcmsgaW4gcHJvZ3Jlc3MgdGhvdWdoLCBhbmQgc3RpbGwgdW5kZXJnb2luZw0KYSBsb3Qgb2Yg
aW52ZXN0aWdhdGlvbiwgc28gWmh1IGlzIGxpa2xleSBjb3JyZWN0IGluIHRoYXQgZm9yIG5vdyBp
dCdzDQpwcm9iYWJseSBiZXN0IHRvIHNpbXBseSB1c2UgYSB1ZWsga2VybmVsIGlmIHlvdSBhcmUg
anVzdCB3YW50aW5nIHRvDQpkZXZlbG9wIHRlc3QgY2FzZXMuDQoNClpodSwgSSB3YXMgdW5hd2Fy
ZSB0aGF0IGFuIGVmZm9ydCBoYWQgYmVlbiBzdWJtaXR0ZWQsIGJ1dCBJIGFtIHN0aWxsDQp2ZXJ5
IG11Y2ggbGVhcm5pbmcgcmRzLiAgSWYgeW91IHdhbnQgdG8gcG9pbnQgbWUgdG8geW91ciBzZXQs
IEkgd291bGQNCmJlIGhhcHB5IHRvIHN0dWR5IGl0IGV2ZW4gaWYgaXQgd2FzIHN1Ym1pdHRlZCBh
IGxvbmcgdGltZSBhZ28uICBUaGFua3MhDQoNCkFsbGlzb24NCg0KPiANCj4gPiANCj4gPiBUaGFu
a3MuDQo+ID4gDQo+ID4gPiBaaHUgWWFuanVuDQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IFRo
aXMgY3Jhc2ggbWlnaHQgYmUgZXhwbG9pdGVkIHRvIHJlYWQgdGhlIHZhbHVlIG91dC1vZi1ib3Vu
ZA0KPiA+ID4gPiBmcm9tIHRoZQ0KPiA+ID4gPiBhcnJheSBieSBzZXR0aW5nIGFyYml0cmFyeSB2
YWx1ZXMgZm9yIHRoZSBhcnJheSBgcnMtDQo+ID4gPiA+ID5yc19yeF90cmFjZWAuDQo+ID4gPiA+
IA0KPiA+ID4gPiBJZiB5b3UgaGF2ZSBhbnkgcXVlc3Rpb25zIG9yIHJlcXVpcmUgbW9yZSBpbmZv
cm1hdGlvbiwgcGxlYXNlDQo+ID4gPiA+IGZlZWwNCj4gPiA+ID4gZnJlZSB0byBjb250YWN0IHVz
Lg0KPiA+ID4gPiANCj4gPiA+ID4gQmVzdCwNCj4gPiA+ID4gQ2hlbnl1YW4NCj4gPiA+IA0KPiA+
ID4gDQo+ID4gDQo+IA0KPiANCg0K

