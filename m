Return-Path: <linux-rdma+bounces-3494-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D030917C65
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 11:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFBAD1C22714
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 09:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCA316A948;
	Wed, 26 Jun 2024 09:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fh2Gsp9C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE3516A92D;
	Wed, 26 Jun 2024 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719394034; cv=fail; b=dQ4x5SUnMqDNuEWh9OqJ/DafOfSu4nWD1df0bwQvElCEV7M8K4mGu/Ka7qofYG1uE5Rl65Tt1At4ZC3zsFyj/sQqZdfDSHxlSznKjPF6nd+hAYMe+usaL29McK0qUKPuLODuUYPIko7Wfu0mbddezmiTmFi/vHpfFN/f4pOd74E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719394034; c=relaxed/simple;
	bh=zoJZfS41OYRCPBZDZTCgGFWgdRjfaTa/xmN2b6NyOrA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ikzhB/rmp4mCNLa+uMX8Dj+8TbCcjaWnxfWhdT09/tMTmKQBuHn0sTtLCr03kjDNMKkbasMDPqUDGt3v//Fcex/I5q+oceqJIfJuvBogvW6HwyrsJJ/vpNYjR99H+O5z1VZKioLvwhv2oS/lTMpNSprzJWQnBbWO/6yW50KUcD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fh2Gsp9C; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9IwtTH6RWymA/Hv3pwkmwdwFmIB28LgJO6bM2toLA76let1h40/AEx0j0A8KGmk0aa//netnSXHhAhZStsTrAhs712qGoRQNDKfqmwdQbirE3RYmDHvfNnOEBapreeGlA7q4Fbh8Yq8jsO6lExkrrf4NJdQe5fsivQnnvC6J9ox7Hxcd22G2SQyCz9pOPWFBhx+8s6dPErMO6CKuT7zsIThWy3VFT7InGM2VBf+XnY8MKY6gTIenaeGEXJ9RTg2Mypz/+ANCIfLEUS/dVImyHsXJY13fciQ0ie3/58FBw2riEhcxwtDUUcVOP22TOnCOK5A3Qqgnwa3gU9jeBTYzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoJZfS41OYRCPBZDZTCgGFWgdRjfaTa/xmN2b6NyOrA=;
 b=S1HEAE7FPXbQ5EaXB5Ly5+wdfWVm+jd/P89gxa7vOGVKKT/0EYkoL6y77i4wmaRxecP4iselEIVEpFlo4l4Yp5JJy+YQZwpMWouH8CRyqcx69orm/BJEM9e3iaZnINzwxhz37FmzG9MDSh5zdibUWvtrrCZEx1eLj2MGvxNH5rbQ4VJpz+uklUZfOFgxapfLfRk33XybpVySsKfSfT1IbxZJuAPeaHB4b+veBPNgZCMah38RAHcIz/+CPoC/2K8tnRsJ0Pg6Tf7dL8j20anEDEkLdua9edxHcxrKMNez2MJ+1Zn5912qWHGd5j5mhrZF3I9z9QkS2Ck2fD4//jPxxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoJZfS41OYRCPBZDZTCgGFWgdRjfaTa/xmN2b6NyOrA=;
 b=Fh2Gsp9CY1lEM8xVNnUH2wVhCjRs1Mn3w9Fdk1TNgQCDJx1LrtFJX79bivlZq9z02EBBk/6+/FypwLml2FbsENLP7cdFFHHqcmAm2QUc0KNv9GTJaXnQRM0P84/21HUQkj/2T81fAJvPvPO99MvVKyqZMW6x9HfhrwjsKTvV13YPoOPKjwIiP0b/byEkNsfR1K7SkPT1PC9wPO4Ie9UqF9zuNsslM1mm91HUqh9Jjr6hhmEy/IvdY0kfjrcS8xLPfbrldJ2DNDeNHitZrqcVQI6krAS1TnQIzyf8XO5u/d+RQldI98m19RD8OrJEiP3C03PVQYlkB8cLLDnG8cg6vA==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 09:27:10 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1%6]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 09:27:10 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "eperezma@redhat.com" <eperezma@redhat.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Tariq
 Toukan <tariqt@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
	"si-wei.liu@oracle.com" <si-wei.liu@oracle.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Saeed Mahameed
	<saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH vhost 20/23] vdpa/mlx5: Pre-create hardware VQs at vdpa
 .dev_add time
Thread-Topic: [PATCH vhost 20/23] vdpa/mlx5: Pre-create hardware VQs at vdpa
 .dev_add time
Thread-Index: AQHawMhZfAWsnj0CYEOKT7TiC0tv/7HPQEaAgAqUMoA=
Date: Wed, 26 Jun 2024 09:27:10 +0000
Message-ID: <308f90bb505d12e899e3f4515c4abc93c39cfbd5.camel@nvidia.com>
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
	 <20240617-stage-vdpa-vq-precreate-v1-20-8c0483f0ca2a@nvidia.com>
	 <CAJaqyWd3yiPUMaGEmzgHF-8u+HcqjUxBNB3=Xg6Lon-zYNVCow@mail.gmail.com>
In-Reply-To:
 <CAJaqyWd3yiPUMaGEmzgHF-8u+HcqjUxBNB3=Xg6Lon-zYNVCow@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.2 (3.52.2-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|MN2PR12MB4144:EE_
x-ms-office365-filtering-correlation-id: 53a4d88f-29b9-44e5-33a3-08dc95c22803
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230038|376012|7416012|366014|1800799022|38070700016;
x-microsoft-antispam-message-info:
 =?utf-8?B?azJUWTlBRnpFR2s0WHFVR3daM3F2dm50OGlIRXczY0dKM1d0czZyb1h3QjBZ?=
 =?utf-8?B?aUFYczE3OG1UY2ZqL2NXU3JkUnBPcllDbGt0L1BnVzhHelFDK3JhUEUyNGRs?=
 =?utf-8?B?U2hvcHpsQzVVQmkxWlJVTG5SbW1TbFhZQnhMMDlUNXRFRElTc1FtNWhUWEsx?=
 =?utf-8?B?djVkOWdrbklkREYrZ1lBU1U4YWo3ZmZLbVZCQjUyM1hlRXE3WXZhR0lBTDU4?=
 =?utf-8?B?UDk4RHcyTUhSUy8yL3lsbEdKaktoWGFlcEVFdS9UYUYwa3ZEb2lyQUQrY1lQ?=
 =?utf-8?B?K2twVDJ3bTVKcmdpUTM3OFRFclNiT2dkTVRaRm55L1dCSHBmcmNDSm5SSlVN?=
 =?utf-8?B?Y1FLV0hHOGJ1a29GQ2pzTHdqQTAva09tL1VnaDNlS1FMUjRQcjhvdGZKUjJR?=
 =?utf-8?B?L214c1RhUUZiOXZqdytSK3NTaW9xam1VdG0xcEozU1UyTkNBcHhVa3JKVkpk?=
 =?utf-8?B?bnJyT0lHcXp5WlNBZVJTdVp0bW5wWEY2ZEdTaWVkelhGOTdzNnRBdjMvRkJV?=
 =?utf-8?B?Rjk0VmRZa0g3TnNGTlg2YnhYOUo5aGpIZzVCMDg5UWI2bTdPcDRBdm81aGht?=
 =?utf-8?B?MVRXZmI5V2tnV1J3S2tmUlpzTGlERld1cDJCSVJYazNDNFduTm45Q2cvUjlP?=
 =?utf-8?B?WTkzdlJ4YVpLazRPU2xmWmRENHZRM3ZwSWN0azRXeUYwUFdnYU8wZ2dxejUy?=
 =?utf-8?B?YXB1VDBvSFROYVc1Y1BHbkVEQ3ROL1ZRN3NyRGFFckZBWHQxTUpIT0xGVm9u?=
 =?utf-8?B?WDlqRnFTcDZzL1JPb1RoRDNWYm9ycnJpNHZ2amMyZUs1VFVTVUZONW1ONXFO?=
 =?utf-8?B?bU5hU3BPbG9nZmZ0SnBSenZCaVpsM3d6ZVBNSEIyUjlTVGRJbkhXUE8rVXN3?=
 =?utf-8?B?MWw4WlhPZEV6MVpTT3pBZGxHZkVIRGsvUWZybUMwSG91MXRmVlphUGF0VSsw?=
 =?utf-8?B?V1gzRWU2Y2NJZTRCMUpQTjNUV3MvaGpqdDFNWVdHM0FhK1pIUU94eGZ3bVJm?=
 =?utf-8?B?dThmQUZaZzhEWHVKYVFUT2NRZU1Fcm1obHNIRysyTVp4Y2M3c1lJQzdFck4z?=
 =?utf-8?B?YndSMFBvcEdYZ3l0RS9UaWhmTDZXVkJOU0pJQ3oxR1FmY2lPUVAzWFJpd1JU?=
 =?utf-8?B?SVp3cFRRWHNuYXFtYWkxMXIyUjBzRDVzRHhHenU3bmNONGtucWZIekZITXpQ?=
 =?utf-8?B?SEJHUndCSk9nV09heTkycDlCTVpTU3IvbGpVQXY5Y0Q2OStnaTNyRGhVeitJ?=
 =?utf-8?B?dWcybldaY2NHVm9ROWVpaFo3ZXB1STdGdGdBZ09hRGQyQllBNXRCZGZBVVdU?=
 =?utf-8?B?aVVTV0JvZTFodWZnNXpBWmdVYVZEWnE3USt3S3NjeWV4bzJNRm9za0pTTU5I?=
 =?utf-8?B?TEF1em5JMWppR2hXeE5JQ1MvS2Nxa2FTUkhYR2tSQ1dZNVJmVWZDeVlMbTY0?=
 =?utf-8?B?Y0cvOWVwcDNsOTJFa1hZcW9oMmZ6R09QK0hyZ0VuY2pmWnZoYURUdUNnT1VJ?=
 =?utf-8?B?T0x5RG1WSVVFZWpWZ0JlNEJDcWdIdDNSVVRUalluZVB3S1JGZzdjbzg5QXZZ?=
 =?utf-8?B?dEVXUVU4Wm5oWnBXSTBpVDFHTDMyeEdicUM5MW9xNUZtN0J5Nkwrby9hSURK?=
 =?utf-8?B?NjkwWnkzY1NkRG5sRGJCOFMzNitNQ2VOL0pMVnEvdDhEVmQ4SllyMlVreDls?=
 =?utf-8?B?VXhieHExYzd6YjVOa3d1a05KN0gxbTduUHdwT2JqRXJSSFp2TW9aMUUwQU5K?=
 =?utf-8?B?SnJvV0tIK2J6U3pESllrWmpOOHNmSWd2dkdQZjhRaWdJZHhLWk10aFMvYm1D?=
 =?utf-8?B?eU9OV0JGVmZzZEFXTlhXWnp3R1VBdG95YTJMcWFwQ2JTU3pZemFpOFlIZStv?=
 =?utf-8?B?cFNqVjkzeU1mZGRaTTJSVi95Y1ZNcW9Mb0IxYmtjZnVFdmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(376012)(7416012)(366014)(1800799022)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dHBrcXg0M05sUjJ2eDB1dS96VDRaTXdhQUlkek01Q0d1OGg5KzFUMFpyQVR4?=
 =?utf-8?B?WFNadXpPS3N0NUlTN3VyMTFSOEJ0U2VZRTd1bVJicDMvS2NlejhXYTBMVWwr?=
 =?utf-8?B?NGs3NzFxMWE5dTRySGRQenRjOW8zVDhEbU13WkdzS3c0ckgySEhZS1ZPclVu?=
 =?utf-8?B?eE1GQTQyTEhZeTRuTkdqazZUUFhHTS9NQmlGYlpUeHBJMDVZSlZubU5iOVJM?=
 =?utf-8?B?SE4rakRXV3J3R05pQ2VwTG55UFZrczNiUGk2MUxFYlJFUm9DemtuMGV3L0xk?=
 =?utf-8?B?MjB3Y3JZaVdHV2hXQXBrbGxvejJ4Q0dwWE1RV05hOTdoU1lkU0grOXFFWVU1?=
 =?utf-8?B?WktnNFVRTGd5bzQzVVdOSTNBZ2g2ZlZwWUdiMXVjK205VmZIQUh1MW03NXFq?=
 =?utf-8?B?T2puZlNvVGJLeUozd3JsNnRRbGdyUklnRjdSckxjYkxzelhMaDVuSzR0bEl4?=
 =?utf-8?B?bnJPcldpVUMwbGQ1U3o4ODZSWFNJTFd3VlN2cDN3YnFjWGluVE5uS0FTRkNC?=
 =?utf-8?B?eU43THVaSVp6RUFDR0IwOTAva2dtR1k2Nld3K2JtT0lyN1UxaEtrMVRHVjN1?=
 =?utf-8?B?eDI4SVZ5ZGV3NjNwc285aG9tcE1Wd1VSVityc29kdHdoTnliNjd2L0pSY0hD?=
 =?utf-8?B?Y01YSHNWWGsrTWQvWFpBWVU4UTVpZHYzRFVBTnh5MXJINnZ0WHFjVkxTVzVp?=
 =?utf-8?B?cU9ScFlyNkJXTFBKTElFODVvLzNHZ0tkeHJRVG1lS0ZFdlo0Z3F0TUYxOHNj?=
 =?utf-8?B?cnMzbmdtdG1wdTVsNGJUdysyNWZhN1FTSUx4VDl2azJWWUlFSGhWSThoTW53?=
 =?utf-8?B?YnBVTFRHeHJOUmw4SVBRcGpGOGd3MFhIVWRGQ0djcWoycEx5am9HZjZoRmxk?=
 =?utf-8?B?RXpPaUdSNGEzZTBrbHliUzhwL2RRMjhIN29KQWxtM00rM2piRlF6NXRZYjZB?=
 =?utf-8?B?b29tdWs1T0lrT1pacDA4NXZwWmFRajJZWWp3V0Y3OFI0ajNmLzE0bnA4cS90?=
 =?utf-8?B?YUtEVytXYmpBWHhHV0ZxWmNpNnBtcHVXRlhDWDJBTHhlbmhvdFBoaVEvVWw0?=
 =?utf-8?B?NGRTajcxb042VjZjQzRDRUcwWlBYWm5RWncxMGhYRnN4cTUvbmZLQ1FjTHVC?=
 =?utf-8?B?elF4Y2lMbGhMOVViWWdmTzZ3bWZURlRSWmNoT3ZoS2dsZUZyNXQxbnlmUURr?=
 =?utf-8?B?T3VsK3JJRmsrcnF1WnJvcTVndG9xVXcwWUZibkFxZVU5UjJ5RzhRUmlPWkRi?=
 =?utf-8?B?VnhvZ1Z6azVHRm9ZeTQxV0hQMkVDd0V2NXgyTVdDZTlKK29TWi9XOE9BU3Zm?=
 =?utf-8?B?K3BPbkwwZFA1VnBpUStTRVZxSjhaSGZFckJod1IwRDlkVjVaUXdzSVhCTnFR?=
 =?utf-8?B?bWlBRmlGaHpHOVFjaXoxaU9taGU1djlBV08yc3laS2g4dlQ3d3E3RURBRSsv?=
 =?utf-8?B?SXFvTm9jdUpBNDZOaitpdU95ZGN5Y1BoNm5tRXlWcFc0NHdURzZkSlNGcGpT?=
 =?utf-8?B?TDJ0QlU1NTJzanhtbzdCUjNXWmp6cWdySjlFMW5UTXFwbHhZeHBXOEZkR2pt?=
 =?utf-8?B?bzI0b29EMmRYbUJHWHhLRksrVUswY3puR24xR3doSUhMRVlQcGlRSXRDS3Bs?=
 =?utf-8?B?TlZIUldkbjFiMlI5ZWF0c1BlOGllWW1IZ1dKaG9xK0Q0T2NxMlhIVEhBSHFZ?=
 =?utf-8?B?MmdtRnpURXJhZUpza09aM282UCtyaDhTU0Evdm45cU9mSUlmbmZiUUFBVHcx?=
 =?utf-8?B?bEc1a0xkL3NzV1cxeU9UYThyT0h3R0l2NlFESVNJS1Uxa1JSbG1EZk5qcUtx?=
 =?utf-8?B?ejJrYWpLa2NCZE5FMXh5UXJZOUJjNTRLQ2paMWIyT2RkU3gzRWt6RFZrZ05v?=
 =?utf-8?B?Sm5YRG52blFJVUZRUUhPZVE5a1huclBtdWVFV2d2bDVoOXJRV1l2MVVlclp0?=
 =?utf-8?B?bVlaN25BSThKNEZocHkwakVaVHFzeWhDOEp5ZkpZdGdnWmJGdWVlQzFpSU43?=
 =?utf-8?B?QzRMYzh4OE5BbWpuczc3TGs5NVN5M0t5SDNrdkU5bSs2OHdSTDgzeHVucW5M?=
 =?utf-8?B?Sk0xRW5wV1hVTlZzbXFQMk5RWlhZV0FYOUVndWw3RFRpd2JQK3RCNzZlVkZn?=
 =?utf-8?B?ZVVkYXJuU0xsVnNEbHJWRjROd0RlMGhQREttZk52YXVIZ0lGSGlXbVRiazBp?=
 =?utf-8?Q?86h7UOYZSBEst3fmp86A67kjLG9jnq6nHWsPdqp7MGpD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EA9EFD78064F64AA9B6A75EB14F998E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a4d88f-29b9-44e5-33a3-08dc95c22803
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 09:27:10.7172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O869v8/yoYOVV8crMbbPaLAz6amJtIyDimHKnjNtUU0hcGWtQEk3iMerkgUym+xPo2hRhrxx3IFGKVLfq5rfPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144

T24gV2VkLCAyMDI0LTA2LTE5IGF0IDE3OjU0ICswMjAwLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiB3
cm90ZToNCj4gT24gTW9uLCBKdW4gMTcsIDIwMjQgYXQgNTowOeKAr1BNIERyYWdvcyBUYXR1bGVh
IDxkdGF0dWxlYUBudmlkaWEuY29tPiB3cm90ZToNCj4gPiANCj4gPiBDdXJyZW50bHksIGhhcmR3
YXJlIFZRcyBhcmUgY3JlYXRlZCByaWdodCB3aGVuIHRoZSB2ZHBhIGRldmljZSBnZXRzIGludG8N
Cj4gPiBEUklWRVJfT0sgc3RhdGUuIFRoYXQgaXMgZWFzaWVyIGJlY2F1c2UgbW9zdCBvZiB0aGUg
VlEgc3RhdGUgaXMga25vd24gYnkNCj4gPiB0aGVuLg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2ggc3dp
dGNoZXMgdG8gY3JlYXRpbmcgYWxsIFZRcyBhbmQgdGhlaXIgYXNzb2NpYXRlZCByZXNvdXJjZXMN
Cj4gPiBhdCBkZXZpY2UgY3JlYXRpb24gdGltZS4gVGhlIG1vdGl2YXRpb24gaXMgdG8gcmVkdWNl
IHRoZSB2ZHBhIGRldmljZQ0KPiA+IGxpdmUgbWlncmF0aW9uIGRvd250aW1lIGJ5IG1vdmluZyB0
aGUgZXhwZW5zaXZlIG9wZXJhdGlvbiBvZiBjcmVhdGluZw0KPiA+IGFsbCB0aGUgaGFyZHdhcmUg
VlFzIGFuZCB0aGVpciBhc3NvY2lhdGVkIHJlc291cmNlcyBvdXQgb2YgZG93bnRpbWUgb24NCj4g
PiB0aGUgZGVzdGluYXRpb24gVk0uDQo+ID4gDQo+ID4gVGhlIFZRcyBhcmUgbm93IGNyZWF0ZWQg
aW4gYSBibGFuayBzdGF0ZS4gVGhlIFZRIGNvbmZpZ3VyYXRpb24gd2lsbA0KPiA+IGhhcHBlbiBs
YXRlciwgb24gRFJJVkVSX09LLiBUaGVuIHRoZSBjb25maWd1cmF0aW9uIHdpbGwgYmUgYXBwbGll
ZCB3aGVuDQo+ID4gdGhlIFZRcyBhcmUgbW92ZWQgdG8gdGhlIFJlYWR5IHN0YXRlLg0KPiA+IA0K
PiA+IFdoZW4gLnNldF92cV9yZWFkeSgpIGlzIGNhbGxlZCBvbiBhIFZRIGJlZm9yZSBEUklWRVJf
T0ssIHNwZWNpYWwgY2FyZSBpcw0KPiA+IG5lZWRlZDogbm93IHRoYXQgdGhlIFZRIGlzIGFscmVh
ZHkgY3JlYXRlZCBhIHJlc3VtZV92cSgpIHdpbGwgYmUNCj4gPiB0cmlnZ2VyZWQgdG9vIGVhcmx5
IHdoZW4gbm8gbXIgaGFzIGJlZW4gY29uZmlndXJlZCB5ZXQuIFNraXAgY2FsbGluZw0KPiA+IHJl
c3VtZV92cSgpIGluIHRoaXMgY2FzZSwgbGV0IGl0IGJlIGhhbmRsZWQgZHVyaW5nIERSSVZFUl9P
Sy4NCj4gPiANCj4gPiBGb3IgdmlydGlvLXZkcGEsIHRoZSBkZXZpY2UgY29uZmlndXJhdGlvbiBp
cyBkb25lIGVhcmxpZXIgZHVyaW5nDQo+ID4gLnZkcGFfZGV2X2FkZCgpIGJ5IHZkcGFfcmVnaXN0
ZXJfZGV2aWNlKCkuIEF2b2lkIGNhbGxpbmcNCj4gPiBzZXR1cF92cV9yZXNvdXJjZXMoKSBhIHNl
Y29uZCB0aW1lIGluIHRoYXQgY2FzZS4NCj4gPiANCj4gDQo+IEkgZ3Vlc3MgdGhpcyBoYXBwZW5z
IGlmIHZpcnRpb192ZHBhIGlzIGFscmVhZHkgbG9hZGVkLCBidXQgSSBjYW5ub3QNCj4gc2VlIGhv
dyB0aGlzIGlzIGRpZmZlcmVudCBoZXJlLiBBcGFydCBmcm9tIHRoZSBJT1RMQiwgd2hhdCBlbHNl
IGRvZXMNCj4gaXQgY2hhbmdlIGZyb20gdGhlIG1seDVfdmRwYSBQT1Y/DQo+IA0KSSBkb24ndCB1
bmRlcnN0YW5kIHlvdXIgcXVlc3Rpb24sIGNvdWxkIHlvdSByZXBocmFzZSBvciBwcm92aWRlIG1v
cmUgY29udGV4dA0KcGxlYXNlPw0KDQpUaGFua3MsDQpEcmFnb3MNCg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IERyYWdvcyBUYXR1bGVhIDxkdGF0dWxlYUBudmlkaWEuY29tPg0KPiA+IFJldmlld2VkLWJ5
OiBDb3NtaW4gUmF0aXUgPGNyYXRpdUBudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAzNyArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCA1IGRl
bGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMNCj4gPiBpbmRl
eCAyNDliNWFmYmUzNGEuLmIyODM2ZmQzZDFkZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Zk
cGEvbWx4NS9uZXQvbWx4NV92bmV0LmMNCj4gPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMNCj4gPiBAQCAtMjQ0NCw3ICsyNDQ0LDcgQEAgc3RhdGljIHZvaWQgbWx4NV92
ZHBhX3NldF92cV9yZWFkeShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUxNiBpZHgsIGJvb2wg
cmVhZHkNCj4gPiAgICAgICAgIG12cSA9ICZuZGV2LT52cXNbaWR4XTsNCj4gPiAgICAgICAgIGlm
ICghcmVhZHkpIHsNCj4gPiAgICAgICAgICAgICAgICAgc3VzcGVuZF92cShuZGV2LCBtdnEpOw0K
PiA+IC0gICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgIH0gZWxzZSBpZiAobXZkZXYtPnN0YXR1
cyAmIFZJUlRJT19DT05GSUdfU19EUklWRVJfT0spIHsNCj4gPiAgICAgICAgICAgICAgICAgaWYg
KHJlc3VtZV92cShuZGV2LCBtdnEpKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHJlYWR5
ID0gZmFsc2U7DQo+ID4gICAgICAgICB9DQo+ID4gQEAgLTMwNzgsMTAgKzMwNzgsMTggQEAgc3Rh
dGljIHZvaWQgbWx4NV92ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1
OCBzdGF0dXMpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl9z
ZXR1cDsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgcmVnaXN0ZXJfbGlua19ub3RpZmllcihuZGV2KTsNCj4gPiAtICAgICAgICAgICAg
ICAgICAgICAgICBlcnIgPSBzZXR1cF92cV9yZXNvdXJjZXMobmRldiwgdHJ1ZSk7DQo+ID4gLSAg
ICAgICAgICAgICAgICAgICAgICAgaWYgKGVycikgew0KPiA+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgbWx4NV92ZHBhX3dhcm4obXZkZXYsICJmYWlsZWQgdG8gc2V0dXAgZHJpdmVy
XG4iKTsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX2RyaXZl
cjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAobmRldi0+c2V0dXApIHsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVyciA9IHJlc3VtZV92cXMobmRldik7DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoZXJyKSB7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1seDVfdmRwYV93YXJuKG12ZGV2LCAi
ZmFpbGVkIHRvIHJlc3VtZSBWUXNcbiIpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBnb3RvIGVycl9kcml2ZXI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB9DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIHsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVyciA9IHNldHVwX3ZxX3Jlc291cmNlcyhu
ZGV2LCB0cnVlKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChlcnIp
IHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWx4NV92ZHBh
X3dhcm4obXZkZXYsICJmYWlsZWQgdG8gc2V0dXAgZHJpdmVyXG4iKTsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJfZHJpdmVyOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
IH0NCj4gPiAgICAgICAgICAgICAgICAgfSBlbHNlIHsNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICBtbHg1X3ZkcGFfd2FybihtdmRldiwgImRpZCBub3QgZXhwZWN0IERSSVZFUl9PSyB0byBi
ZSBjbGVhcmVkXG4iKTsNCj4gPiBAQCAtMzE0Miw2ICszMTUwLDcgQEAgc3RhdGljIGludCBtbHg1
X3ZkcGFfY29tcGF0X3Jlc2V0KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTMyIGZsYWdzKQ0K
PiA+ICAgICAgICAgICAgICAgICBpZiAobWx4NV92ZHBhX2NyZWF0ZV9kbWFfbXIobXZkZXYpKQ0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgIG1seDVfdmRwYV93YXJuKG12ZGV2LCAiY3JlYXRl
IE1SIGZhaWxlZFxuIik7DQo+ID4gICAgICAgICB9DQo+ID4gKyAgICAgICBzZXR1cF92cV9yZXNv
dXJjZXMobmRldiwgZmFsc2UpOw0KPiA+ICAgICAgICAgdXBfd3JpdGUoJm5kZXYtPnJlc2xvY2sp
Ow0KPiA+IA0KPiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gQEAgLTM4MzYsOCArMzg0NSwyMSBA
QCBzdGF0aWMgaW50IG1seDVfdmRwYV9kZXZfYWRkKHN0cnVjdCB2ZHBhX21nbXRfZGV2ICp2X21k
ZXYsIGNvbnN0IGNoYXIgKm5hbWUsDQo+ID4gICAgICAgICAgICAgICAgIGdvdG8gZXJyX3JlZzsN
Cj4gPiANCj4gPiAgICAgICAgIG1ndGRldi0+bmRldiA9IG5kZXY7DQo+ID4gKw0KPiA+ICsgICAg
ICAgLyogRm9yIHZpcnRpby12ZHBhLCB0aGUgZGV2aWNlIHdhcyBzZXQgdXAgZHVyaW5nIGRldmlj
ZSByZWdpc3Rlci4gKi8NCj4gPiArICAgICAgIGlmIChuZGV2LT5zZXR1cCkNCj4gPiArICAgICAg
ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICsgICAgICAgZG93bl93cml0ZSgmbmRldi0+
cmVzbG9jayk7DQo+ID4gKyAgICAgICBlcnIgPSBzZXR1cF92cV9yZXNvdXJjZXMobmRldiwgZmFs
c2UpOw0KPiA+ICsgICAgICAgdXBfd3JpdGUoJm5kZXYtPnJlc2xvY2spOw0KPiA+ICsgICAgICAg
aWYgKGVycikNCj4gPiArICAgICAgICAgICAgICAgZ290byBlcnJfc2V0dXBfdnFfcmVzOw0KPiA+
ICsNCj4gPiAgICAgICAgIHJldHVybiAwOw0KPiA+IA0KPiA+ICtlcnJfc2V0dXBfdnFfcmVzOg0K
PiA+ICsgICAgICAgX3ZkcGFfdW5yZWdpc3Rlcl9kZXZpY2UoJm12ZGV2LT52ZGV2KTsNCj4gPiAg
ZXJyX3JlZzoNCj4gPiAgICAgICAgIGRlc3Ryb3lfd29ya3F1ZXVlKG12ZGV2LT53cSk7DQo+ID4g
IGVycl9yZXMyOg0KPiA+IEBAIC0zODYzLDYgKzM4ODUsMTEgQEAgc3RhdGljIHZvaWQgbWx4NV92
ZHBhX2Rldl9kZWwoc3RydWN0IHZkcGFfbWdtdF9kZXYgKnZfbWRldiwgc3RydWN0IHZkcGFfZGV2
aWNlICoNCj4gPiANCj4gPiAgICAgICAgIHVucmVnaXN0ZXJfbGlua19ub3RpZmllcihuZGV2KTsN
Cj4gPiAgICAgICAgIF92ZHBhX3VucmVnaXN0ZXJfZGV2aWNlKGRldik7DQo+ID4gKw0KPiA+ICsg
ICAgICAgZG93bl93cml0ZSgmbmRldi0+cmVzbG9jayk7DQo+ID4gKyAgICAgICB0ZWFyZG93bl92
cV9yZXNvdXJjZXMobmRldik7DQo+ID4gKyAgICAgICB1cF93cml0ZSgmbmRldi0+cmVzbG9jayk7
DQo+ID4gKw0KPiA+ICAgICAgICAgd3EgPSBtdmRldi0+d3E7DQo+ID4gICAgICAgICBtdmRldi0+
d3EgPSBOVUxMOw0KPiA+ICAgICAgICAgZGVzdHJveV93b3JrcXVldWUod3EpOw0KPiA+IA0KPiA+
IC0tDQo+ID4gMi40NS4xDQo+ID4gDQo+IA0KDQo=

