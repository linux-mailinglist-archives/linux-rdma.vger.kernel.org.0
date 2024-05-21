Return-Path: <linux-rdma+bounces-2557-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D55A8CAFF6
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2024 16:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08010B24430
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2024 14:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDE78062B;
	Tue, 21 May 2024 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Io+MCKT0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EPEgEazz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C023A76C76;
	Tue, 21 May 2024 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300193; cv=fail; b=TbzQIZaiwAnjGp5QRdJlDSDoM2FJ8KeAz211yO4WgCorzNpSybLj9ze8Hyk2rTnHxB0A2ULzDFz8pmhJTanZ2l6yZs0WO7QvfsWTAexrLQZtcCRWglKCj/ViydohLAmHJeWPXvh7G5hcJ3FvZEVjJlkli0/6Mmn6t8zDZTPXnTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300193; c=relaxed/simple;
	bh=W+5Cyiok1+215Xwn4F5ZeBacHrdaRwHXqK5GGf2C5Jg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c6aaiI6+i2HsivIHOju2UpwxzKz2IsCFWtAeuDTvoh0A7asUigZLXMIktHLCCfT9xDj77aSK9wmlxH5GvvEw18+37e4KWE3Sjxf86S9rDTsykQ/CkwNA+mAlEPiymjCofi1Kdtx70ooZkIgHzQoNjNIdA7BhB72LGam3v+i0OPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Io+MCKT0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EPEgEazz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LCxwje030351;
	Tue, 21 May 2024 14:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=W+5Cyiok1+215Xwn4F5ZeBacHrdaRwHXqK5GGf2C5Jg=;
 b=Io+MCKT0JGurhckUuDgxqlx7Vs0VCVIatp+GPVCQh9OAAvmRrMe0js8S4YXSPszYCjhD
 MV3npiEWidRUVOYp4gYqwaOOmn7RtLWxHsSry+p5U+cL1HeZOqPf3uTayFfCj9jT4K9L
 3Ghi44oSw6ZmbSVmVjOJIo69g9oOftxGaipWJ8cqDf6YTM7S3wr0/F+8Uxsr77bq4TIi
 CMzJVC0WGZVXsq4u0SQiZn3isnqb881vbumuePj8++rTQVwUTiir8PADhz9q7fzeSWb5
 qqNN6joGcDvmTE0R+XyAdZ+Bkk+nXERWmAH/UqAYmCRDrIZOEOO6VaXiFOTLZKZXASdc LA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k465fnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 14:02:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LDUuXj002678;
	Tue, 21 May 2024 14:02:40 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js7rhae-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 14:02:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l152ssvOklRkhspPOEcZQDWjeOurONaHN+1464gYwxqHYZvsP6wqwtZD0gioEPthQx/K2PKwMoaQPOFvzUIgE2OI7XfVVW0OuqeIeIHipDQKntsgttzHzLtLBIUR9Vp58nAxdIU7bdPcV0clCWg6J7QCERd1ftHpf8Bi5CwAbg5SmlClqL6kWSzSFtNNqNYT9iHOdSltrjM4ADZlyh6r8OevYW1YtovYhS4P1MnHAZuGQFbhVr9PNjkkxgmoh/Z+nITwH+Bx37GlheltA/70NbgTArAy45y/4a1N6gTk8gEvVJvxRtPMu22PEbGo82xqzVQNofWqyIqXblZyqUYnaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+5Cyiok1+215Xwn4F5ZeBacHrdaRwHXqK5GGf2C5Jg=;
 b=Ge07EFhTgm/FFYBw91wxbHk4FNCFM8oXygDJn2hHEmda0uADWorPFr0Qb+3XyTIwXpJB7cbX823lbjJ3qSxEr5aWWoMmehD8+MsYAYaFy3Bvcb+nejBlIh6PNr+m/UgeIEdJiz/RgJzDHA0bnD77HZa9B8tRhnkvc/9A874FR95ht0SwnQ59++lNOLWIeYYX8/+ic8mvf0nioRuFpGw+aO8QAqBfJou+YAyQOxPoyL8/BQNVXS95EDTfaokOoiT9iysacH6otqUTq8b8gI+PyFf5a58TZBV0/0dDWPLQkQXQtO/2jbwustdzlu1Z+W7wKapQhP/I0eEmhP0vBzAWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+5Cyiok1+215Xwn4F5ZeBacHrdaRwHXqK5GGf2C5Jg=;
 b=EPEgEazzqpk02kn+5scASrRSLtJkg/kJBhvRX72uQ9MEa5Yutzr1IjkBSNVkZcW3g24PQbJ4ytS/2KSleppgbsnKzySmYTVGVVLGhhr9ICJuetoxFObczLUHlcxL3q2Yln4d6ofFrTlvUQQs7jBuufh3L9AlNFh8mQCb3bLJnD0=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by MN2PR10MB4126.namprd10.prod.outlook.com (2603:10b6:208:15f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 14:02:37 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::8518:ea67:dd0e:9836]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::8518:ea67:dd0e:9836%3]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 14:02:37 +0000
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
Subject: Re: [PATCH v2 1/6] workqueue: Inherit NOIO and NOFS alloc flags
Thread-Topic: [PATCH v2 1/6] workqueue: Inherit NOIO and NOFS alloc flags
Thread-Index: AQHapscbQhw1QOa7v0WunJjCVUME57GYg3aAgAF5/4CAABF3AIAHsogA
Date: Tue, 21 May 2024 14:02:37 +0000
Message-ID: <C9B198E3-1E73-4F17-8A35-CB9312C9CF1F@oracle.com>
References: <20240515125342.1069999-1-haakon.bugge@oracle.com>
 <20240515125342.1069999-2-haakon.bugge@oracle.com>
 <ZkTos2YXowEFS2fR@slm.duckdns.org>
 <D9786636-CACE-47E1-B4B6-26AB2C4244C3@oracle.com>
 <ZkY0cIiFOmkwzn5G@slm.duckdns.org>
In-Reply-To: <ZkY0cIiFOmkwzn5G@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5593:EE_|MN2PR10MB4126:EE_
x-ms-office365-filtering-correlation-id: 713fd136-2e29-4c55-3de8-08dc799eabc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|7416005|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?YkJnRTlZQVBsdHlpQkt6Qys4THRJekRSQURjNE0vY0xrTmxjSE8wV1Y5Qmsz?=
 =?utf-8?B?aUcwSlJZbXhqdmRwVkNwaG5EYWRKTkF1NVUrY256TWsyWG1kQ2hVcEE4ejIx?=
 =?utf-8?B?QUwxRXdDQnJ0TVVod3dFU0puZXZ6bHMrVHJlVlRnU1FBTzFlSjJZdWJuK01m?=
 =?utf-8?B?OWp4S3dhdFB2NVdYMjBVbW51aitmWTRWcXV3UTduSUFGYVIwaERHcHhzSG9F?=
 =?utf-8?B?VDJ3dlBiOXhmZWdidzFwQ2ZOVHZGLzdhNXRiUHJJZHduSVJrWVJOZnJ2RDlr?=
 =?utf-8?B?YWIyNFBHMkgrQmU0OUVyQVY0N1lGNW1NSU05K2pXVnpKOXZzSWVEK2lSWTk0?=
 =?utf-8?B?TDR3QTV0M242am8vbTVxVldQR09uRE4zSHVNdndtSFN1eStYTFlENFRFeTdB?=
 =?utf-8?B?V1ZLV3JXYUxvQytQRXF0RU9kb3VqejVCNCs2ZG5idUVMSlpPTFlPeUFiVWRv?=
 =?utf-8?B?a1BQSjZVYmFveFg0cnF5eUpMbU85cUFKMmZHQjJqUXRlOHlUSllaTFZzbURa?=
 =?utf-8?B?SnVTa1Z6dXVqNXJaS05OVlFEUVRwZmFEMFdXc2VzaFlKSnhsZ285RjhtSHNZ?=
 =?utf-8?B?Z0xBNEdUOFdWd2NBTzdiR0lGTWpJYjlxNlpwbHJXVm1paGVRSVRoYUx3cFRW?=
 =?utf-8?B?dlh0Vzh4S1d6SHEzWE0yNlB3a29sZXFZdEs3a2RhYWFFYjdwckNUS2dmMXcr?=
 =?utf-8?B?QmlYQjdoaWN0cjF5NDdZSzVXYXBPazZ1bmlDYW1qOFNWdXcybnRaMU84N24y?=
 =?utf-8?B?YzVCOUQva2M2Yms1OWZCTVpGQkwwRWUvdFQwd041eEVRYnBTTUxjTmZVcWxH?=
 =?utf-8?B?QlhLWktJKy9PNks4RWQ3M0FOZWZtTmludEpOcGtFcXU0WU9zRXBZQ0UraEEw?=
 =?utf-8?B?bzY1MHliUmFST2lKbU9HZnE0aW52UmJrVEhsUXhiZ1ZxTytwWTBBdWE4UmxO?=
 =?utf-8?B?THg3ZmZTVGxMRW1uOEg1SFg2QXl2SkdnNkFmVDIxSzNpODBWaEFPdVArcVFi?=
 =?utf-8?B?SWlGS2UvZzJFUlNHWFJSamEvT3Q2OFpLNGlWK01JRFMrS1ZNbVFJTG5lNk1h?=
 =?utf-8?B?a2ZOMzFENUFJQjA1T2J6S3hXR2F2ZDkxQTJIRlFEVkRTZlRadW9jSXRURDY1?=
 =?utf-8?B?S2l3cEN3aENvR2QvNU9xQU53M1AxczQrM1FGY1VhTXJQTVk5NmJLQzBldGVw?=
 =?utf-8?B?WXdqcnlsV1l1OUhlclY5REpGc3VkdVVVWmhGS2hMWGwyeUhvd25hWDFKbDNy?=
 =?utf-8?B?T0JDZVhpWXE0RC9nUzVYZy9HUnh4dWViaW1CQkg1ME9lc3RSVmovZTZvVTcw?=
 =?utf-8?B?VFJCaGxnajByU1JRTXk5Si9ZZWhSMENudjAyN1lId0lwKzhGamNKRDlaUnBh?=
 =?utf-8?B?MlYzLzJRVzRrRHpwNCtZZm55RkpVL1lyM0U2QUxZWWxyVE1TN2VWTDVTTXBI?=
 =?utf-8?B?dllGZElVcVFCYmdUQkNBYmJIeWc1ejB1dXFZZTFiVmh5TXFPbzhQNW9hbU03?=
 =?utf-8?B?eU11ck1VYUs3bFRCc25Rdnc2VlFiTFZETjZjM3RUUTA3VUN5dGoxZEtXM2Vo?=
 =?utf-8?B?dGZrRE80MXQ0VWYvZWVXRzJhREc0b1BTWWhPOFZiSmRma3hoc212dTJqdzla?=
 =?utf-8?B?UHRhZVA4aHBtM0ZNTzlLUUtJYmc3V1V5ejVyVEo1S2hCckVGYjdWYUZhU3p2?=
 =?utf-8?B?WTNVc1JJWFNIOWlQUkVKOG55OTlUVHdmMFNTZVU5OW82UmFVcWxvOXl6YXJO?=
 =?utf-8?B?VXR0MnpQdkRlbmlxaThGMXVCY3NLZk5kWG9tdFZ0cnJ3MzBsS01WczZRYlhE?=
 =?utf-8?B?b0cwa01aSGlBSVRZRU11dz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NnJFalBpQy9WeWNqZ3k3d2N1OVh1b3ZBMVBzcEx0S04zQVNaaXMwTFFCUE9z?=
 =?utf-8?B?QzE5dGZsUUxEOFpGVC9PN2N3NXFlVnZmNDkvdW1WY09UbzlOOHh5akc3ODZV?=
 =?utf-8?B?YWpJeWNUVUY1RncrZ2YrMlRhY29uYVFlejg4QnRWNllGVDF2SW1ILzlvR0lk?=
 =?utf-8?B?VW9ickxoR2o0WkxrQy9jUnRpMEdORHBwd09HSFNmdzh4NnBsTWFoUndyR3pU?=
 =?utf-8?B?cUtQZmdtaXdTN0t4bjhNVW42bHRaVUdQbzRPNG9YZkVhOGlJWElDUlNIRUxy?=
 =?utf-8?B?dWtQTzhUZklHSURUSUJPUEkxRjhWRTJ6TkswZ0dUdDJzOG1TYWFodWU0cm8v?=
 =?utf-8?B?UEZnZ2YzeDFORzhjcWgxbVlNT0FqdE9ZTU1jajM3MFdvc3VwekVXcVNFd0ZS?=
 =?utf-8?B?OXlacStlNCs2NWhDT2c5aS9MQ1k4YWloYkgzNC9QMkEzbk1CZkRtZ0Jzdm1B?=
 =?utf-8?B?NGtxeWhDWEtaQXN4WHdGbTN2WGhTeDdMK3R1SDRJV0dMY09ZM3hYdzVST1Ft?=
 =?utf-8?B?UHpWZCtJU3I2RzFZMXhSTmgvNEFGZzI3aWczTDM3ZEtBd0M3QURoMm51dTF6?=
 =?utf-8?B?QUxHMStHNnBTTy8xaFFmc3BwNEhIRlNyM1hobVhZYldlMitUWXQveHVkMFJm?=
 =?utf-8?B?NmhDSUFvWE14aXVjUGk1bmR6K1M2MVR1dlhDK2VKZkVwQjBWTkU4ajVvMzB3?=
 =?utf-8?B?bDdFa2lHbkF1YVZ1TExxdExZTkpTUzBEVXpGaXV3YmFYTGtXazA3cENCSEpv?=
 =?utf-8?B?c0FXNDBmWVZHcndpbWI4amlicWZ5cURDYTI3NytWc2lzT05CWkw3eXR1TXc2?=
 =?utf-8?B?TUdlak10STRWU3M1bS9TUDF4bDZpbE85Tmx0K3d4YlFrQ0tLOTd4T1c5MGF1?=
 =?utf-8?B?WG5ZUlNSVFNYekpzNWRKdzI4WVdSaGM2ZG1peEs2d0xhVVBqTnVxNnVKTHB3?=
 =?utf-8?B?Sld1TzV6NFhwQnBkNVRCUFVqdU9xY05EUWdJWlJDbmhicHNaUEw4UllDUFFV?=
 =?utf-8?B?czJSMkxrTEVva0NzWEtvd0dxUDRmdnlubnF4cStxaythd2pmdXVjdVlFNUZy?=
 =?utf-8?B?YlpkVFVmMndTTVVkbGFFZDFmSytPWVgxUXZuVENrdVU0TjI5N3NRZHd6cjRy?=
 =?utf-8?B?RHpTQXVheFFRUDV6LzJ5WHh3WVpGdjVGLzFLTEpZcDBORXcyaFF0WjYvTENi?=
 =?utf-8?B?R3JoRXRiaFdEaDE0RFZSaEZwcy9NcCtVQlByRjljYVc5WEdHY21BdEhGSWZ3?=
 =?utf-8?B?U21xVFdCYSs5R0JKbVFmOWJvRlNtRHRMbUlTQ3J4NHpKU3BiYkh3S3A0aTNp?=
 =?utf-8?B?Zm5tNnNzTXN5dVZnSzlnZkZudmdxb2JaeVZGUGlZMlNaWEJwUXZvME9CcWVY?=
 =?utf-8?B?Ri9tK2ErOW1KcGpBL3FpbG1uU0FqSUxIbXJYUlNaK1NLZXo0ZWx6RktsNjA4?=
 =?utf-8?B?eHppRTd6d2t4L2hqb0lwN1FPK09qVm5KVmFySjZOVGhleVRsbDlsLzF0ZmUr?=
 =?utf-8?B?bSs1aEV3ZDYrcFdiT2VQUG1yYjY4NWVnbDZ1ZlZSbWR3dGZMNTF5SU1XSjhB?=
 =?utf-8?B?eDFUZjdrbzhSQlpLU0tkWlpqUGhRb25qZkVPekdsVlU2M2JVS3ZFdnRDekhZ?=
 =?utf-8?B?TEJDYkdsTzU2U1cwSzVQcTRad3ZuSEJ4b1ZpYTJFUG40YUhZcDZUV1MvZ2xi?=
 =?utf-8?B?L0pSN1pBcExqM2dOTHBZSFp6dTFORFRYOW9YNXljVnI2VTZjWFJGbVd3bEo4?=
 =?utf-8?B?SFRaT0ltZEI1ZnF6Yk4vNENLZGpWbzJzY2JUV1RuVHZEN1ZLYkhObG5ielhY?=
 =?utf-8?B?R0ltSHV3QzR6NmNDNC9FZkdzVEhheklCa3hJczFhbkU5YTlhVGpDVSsvZTNB?=
 =?utf-8?B?aEJYa0RNY3UzRGhDR1d0T1JoanVMRWozL0o4Sm9RMUNzYm85bEdIOWtVNkNm?=
 =?utf-8?B?NEtJNE1WRjlKV1cwMVhZUlJzemkvdDVpa1FHM2MrdHhnUHhVQXJ4VVdCSzg5?=
 =?utf-8?B?OEJNV1FQazVEVFdlclkxWTgxUmtvQXFnYWR3TEsrNWdFVkV6SDhQLzZhayta?=
 =?utf-8?B?UGhDZnljREpWd0h5aDJYMmNkb0xqNEZ3a1U1T0lYZFNkUDdKQmV5emcvWEhX?=
 =?utf-8?B?L1I0QmF2UUlVd2J3b2xxT1ErNGE1dzdleldEM1lHeUNBQy9nWEdRVHdZWERZ?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B24B8F5D9802CA47926F61C4FA26173C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hpn6W7TbBbYjMFci9OrUpOtSIvYOhYtQ+Bz0tcusz1d+7gyEhX2eb7sljCNofr8OByxFn3v+Ti64RJ6h3GvAsq2jvh2ICisyAvb+udj+QD8j/38m+FGh9Fd3UZKw97DQTYemID9S5E5Sbc99Ly4Xq6AwRwn2Th+DKsYCpye1E4UhaVJb9byhZxzqtUiqBZB2/LVVKuhmrgvWcehmzUARyr6iYtZqB7GO9DgLmoeBg3guqF5DTqITQQWT2N1ZytC3Ib/COR9cDyGZpma66oSfkoPyxqd42fOM6UiGee0m0EilvlUIWFjEjb13ew6Jyyh3IxommISxPg9lMMqns+byKNBxPhaEpgwTtiwuXQlVmk32k4bAOjlpxd1IlmozWpyVeUo3MiTrqRftuKLuismSRX1n+bo6GOnh77j9YMNb/+oabYmXJvJLQvDSmsu6nWwpK90NWOZzcYpMX56RBIuK1iWnC2WMeepyYzcRusy9R3u5mB9P+10vJ+nQ35fXGaIN0wtHYvgu+Ly8eL+drK9H1/LLgNiDm0OiQ89uFCxYU6bb2INFj9azeMYTvCe7IdybCRR5jycDm8u0/kcECLJyq2GPh1rCPvkzfRNKI72NE58=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713fd136-2e29-4c55-3de8-08dc799eabc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 14:02:37.3175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MyNOf2pqcT10uI9a0dfZkh+zIY9Xu7+klg+G3pxeiQxXSVgwMqH3wu2ku6vKaotew86PRQF1dbo8li3hDByE+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4126
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_08,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=842
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210105
X-Proofpoint-ORIG-GUID: tbE8QRaOcQWe71rC0azDKKScWbzi3X3o
X-Proofpoint-GUID: tbE8QRaOcQWe71rC0azDKKScWbzi3X3o

SGksDQoNCg0KPiBPbiAxNiBNYXkgMjAyNCwgYXQgMTg6MjksIFRlanVuIEhlbyA8dGpAa2VybmVs
Lm9yZz4gd3JvdGU6DQo+IA0KPiANCj4+IFdoZW4geW91IHNheSAiZGVhbCB3aXRoIGdmcCBmbGFn
cyBkaXJlY3RseSIsIGRvIHlvdSBpbXBseSBkdXJpbmcgV1ENCj4+IGNyZWF0aW9uIG9yIHF1ZXVp
bmcgd29yayBvbiBvbmU/IEkgYW0gT0sgd2l0aCBhZGRpbmcgdGhlIG90aGVyIHBlci1wcm9jZXNz
DQo+PiBtZW1vcnkgYWxsb2NhdGlvbiBmbGFncywgYnV0IHRoYXQgZG9lc24ncyBzb2x2ZSB5b3Vy
IGluaXRpYWwgaXNzdWUgKCJpZiBhDQo+PiBOT0lPIGNhbGxlcnMgd2FudHMgdG8gc2NoZWR1bGVy
IGEgd29yayBpdGVtIHNvIHRoYXQgaXQgY2FuIHVzZXINCj4+IEdGUF9LRVJORUwiKS4NCj4gDQo+
IEl0IGJlaW5nIGEgcHVyZWx5IGNvbnZlbmllbmNlIGZlYXR1cmUsIEkgZG9uJ3QgdGhpbmsgdGhl
cmUncyBoYXJkDQo+IHJlcXVpcmVtZW50IG9uIHdoZXJlIHRoaXMgc2hvdWxkIGdvIGFsdGhvdWdo
IEkgZG9uJ3Qga25vdyB3aGVyZSB5b3UnZCBjYXJyeQ0KPiB0aGlzIGluZm9ybWF0aW9uIGlmIHlv
dSB0aWVkIGl0IHRvIGVhY2ggd29yayBpdGVtLiBBbmQsIHBsZWFzZSBkb24ndCBzaW5nbGUNCj4g
b3V0IHNwZWNpZmljIEdGUCBmbGFncy4gUGxlYXNlIG1ha2UgdGhlIGZlYXR1cmUgZ2VuZXJpYyBz
byB0aGF0IHVzZXJzIHdobw0KPiBtYXkgbmVlZCBkaWZmZXJlbnQgR0ZQIG1hc2tpbmcgY2FuIGFs
c28gdXNlIGl0IHRvby4gVGhlIHVuZGVybHlpbmcgR0ZQDQo+IGZlYXR1cmUgaXMgYWxyZWFkeSBs
aWtlIHRoYXQuIFRoZXJlJ3Mgbm8gcmVhc29uIHRvIHJlc3RyaWN0IGl0IGZyb20NCj4gd29ya3F1
ZXVlIHNpZGUuDQoNCg0KSSBhbSBwcmVwYXJpbmcgYSB2MyB3aGljaCBoYW5kbGVzIGFsbCBQRl9N
RU1BTExPQyogZmxhZ3MuIFRoZSBwbGFuIGlzIHRvIHNlbmQgaXQgb3V0IHRvbW9ycm93Lg0KDQoN
ClRoeHMsIEjDpWtvbg0KDQo=

