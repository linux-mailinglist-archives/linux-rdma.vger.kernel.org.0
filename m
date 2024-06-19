Return-Path: <linux-rdma+bounces-3346-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441C490F4C4
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 19:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B571C282579
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 17:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700A715667C;
	Wed, 19 Jun 2024 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FtiUHxJh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DAC156669;
	Wed, 19 Jun 2024 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718816787; cv=fail; b=sf4opslieLFSn25/Ly22gbUcWOZx6h43ecm0vgputU6u5mSU5AEGYgVHz2Fz/2FbSSw1uvaPvQyMSKNpFhVwi2f4CDsvK7d+xcMUMEG/R1BBGSrkM/s5CRhe61WaZ3jNO0lfWlfwVN+chhVcEEzN/JMjkYyQ8WZLMYJ7zH2jKJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718816787; c=relaxed/simple;
	bh=/7WygMHsyIOknPzxYN2RzEu4UwwjUTx0oZBfRlZCYp8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EaWj5/zdOMJjruW/YAY4c3PWGQh2I/vE5ozR4HN7fNO6HBtoFAsIEy+tIKSNuM51bpAHcYqI+r2awbuaYUSmWXWQQSsV/aWgq/GAG0POqpTy5IxTX9nRyDbFAxFZNpHlyBllH146Oq4W8qdOCHSUMr+ubGT0n8NiQw3d+GUFA5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FtiUHxJh; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWsMTMhPEON/y5SGhZON8js41i9mfpiimNNnCXLfdVPOzYmBGLfhtvQtC0AaH00AkGGpt/zIasr699DV0NaoGrjQPrQq4NPSuSMbokY9XbS3N0ZhuobJsO4JSINOcdmfsaGumeiFGIb53L+5YiMKebykKFj8+cWEXkwCQDU1W7Wd/EqSIiODiDd5CJ5N1KzbseSkCPFVkss/1qwT7Gi785gnm0LgnTUuyXGVrdUVI3ork+ePzC3vxp9HIpX62SovWOpOs8Zh7EaTjGZNAi6YPy4Px87wwnc2KKYUYu/AMaieaYAgN3wgsvnivEDbcaY3OnWyfcNABksulmaWLIPcNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7WygMHsyIOknPzxYN2RzEu4UwwjUTx0oZBfRlZCYp8=;
 b=H2XVmLBPCuYrmtT/8EDyh86ILtXKUgW+BHpr8b9EZbsncvsfTJMvJfhFmdhnEY8SL1hNwqSUdozI0HLr1bf1+a1RTHhQTstk7hziZsOJ4S5aIDIkIll21nZnYNkzltHCr66Ez1s5qBr8mUGFCAD03G3e1DR8qe5qLKiNn+gVIhtmSEvfyU/B9UmQxx34HX5gTjroveskFlKfTMsmodokji2/0TZFpaY/7J2JV1PZz4WSdwex3XNbuS7hWgRB5yErAxzBnMeb6IhbxieBnvrS4ZmOkO6LdDOGYHz5mTZKlfL7tv/oD1EykiIbj+E5i5xmaJwsGZGWJk3RB26/27E0lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7WygMHsyIOknPzxYN2RzEu4UwwjUTx0oZBfRlZCYp8=;
 b=FtiUHxJhaS7SHy87AYawvVHsI0A1qJhYvhYsX/WUdyHTVMSV4sjkYHEk5CBH28r5+m5EOMpFyXLVWi5ov70+l56JyP+Ovnfybs4c7egfPWtW+6XhxYvu+F6qJ4hl530fxFRakfCTHPyzG/GY0MnYBumhDcQxOB3jc7BO8WrnwAgUygnL+qnM/eNYUbNE5eXlWCV6SLOquJDij5NzgNqO+fHz8BltsbOIlM9BJsEmLiPPrAvsda7S7eZHu+Px224xuwkfRuqj6tapmnxYAw2dMoh2mGu0+Ky/59R3/uev9LDEJZ/2Ii2YniiYSJuWfJk1zsTgPjcnsHmLKCelf/fZZA==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by IA1PR12MB6068.namprd12.prod.outlook.com (2603:10b6:208:3ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 17:06:14 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1%6]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 17:06:13 +0000
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
Subject: Re: [PATCH vhost 11/23] vdpa/mlx5: Set an initial size on the VQ
Thread-Topic: [PATCH vhost 11/23] vdpa/mlx5: Set an initial size on the VQ
Thread-Index: AQHawMhCFo0qQ8vkMkCFum77C7I5l7HPM40AgAAg3IA=
Date: Wed, 19 Jun 2024 17:06:13 +0000
Message-ID: <cc3241cab90dedf48fc2f518004e1971234d97d0.camel@nvidia.com>
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
	 <20240617-stage-vdpa-vq-precreate-v1-11-8c0483f0ca2a@nvidia.com>
	 <CAJaqyWedSQdAiFoQuqdzwdZ4KNNPD7wyX4=QTMMG4aYt7US7PQ@mail.gmail.com>
In-Reply-To:
 <CAJaqyWedSQdAiFoQuqdzwdZ4KNNPD7wyX4=QTMMG4aYt7US7PQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.2 (3.52.2-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|IA1PR12MB6068:EE_
x-ms-office365-filtering-correlation-id: 4ab05394-9820-4cea-61a0-08dc90822026
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|1800799021|7416011|376011|366013|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?YlFWbFdNZlRQSS9mL2xCclNFQk9pcllqVEVic0J2NGhmZ1QyN1pta1cweGRR?=
 =?utf-8?B?THNQb3RuNlYvSkxsZjd3MUZ1aXYrNi82ZDZWc3JkNDdmTmFiMFdpNWhITGx3?=
 =?utf-8?B?clN2YU45WUdqZ2s4NjdvcVZaVitRK1ZlUWFRdFVTTFNiSm1DWDZ3TkkvRmtm?=
 =?utf-8?B?RDJyeGx2WXU3eVU1MDJmWVg2Wjd5NE1QUG5oajRRSjdQNXRJanp6M2lHa0Fw?=
 =?utf-8?B?Ly9ldCtVci9LS2RvakZyaEdVYUtYem8zbmhTbHdDM2VqYWNiaGprZE9Pak93?=
 =?utf-8?B?UFVNSEw3OGRZSlVZYkRCWHB4Q3IvTHBSY0lyUFNvQUs5eW9GbTlVQ1pEMjN3?=
 =?utf-8?B?NkNBc0pyaTUrNHl2MHRETlpFUi9lOFJxZUdSVlc3eUhjbXhqOU51ckNoczF5?=
 =?utf-8?B?NXhpclRHeU41NjlMY2daTXdCTnMzK05XSURCdDVvbjVTQm5xSXNTckRXU3Vl?=
 =?utf-8?B?T0s0VkFRSFdIdkVRYmtINzhweWh2N1BXQUJydXZjNTVVdm5UcCtQcGJ2VXNF?=
 =?utf-8?B?a2Ftc3MwbUhibzRMNEJwMW5kZzYzazhGS0pGRGlvMndDZGxGck1RUGxXZDdJ?=
 =?utf-8?B?Q0NTQ3JmeFMrQXFnc2x1TXdyNXlJRDlwRHdINTl4NkVHb1IzSmdtOEZUSVRx?=
 =?utf-8?B?Tlc2UVJxaStoeEREM2tUWnU3N1RaaDRpT2VtVk84eDZvK2dQVDlzYUFMY0RQ?=
 =?utf-8?B?cjczZW9NajVWN0MrUnlSK0tNMngwWkV1SStuNlVnVkYwNDl2T2p0VXJrZktO?=
 =?utf-8?B?V3R6RGtpcHNwcytJYUFNN21mUjdydmVHTFBkcHNEemo1SmpmKzN5cVlHTTNJ?=
 =?utf-8?B?ZmdiMm0wL2RiVnh2dUhJdmdXZ0pxNXBFT3cydHdRNFh3azUwUjhJakxKU3h6?=
 =?utf-8?B?YU9pb3p1ZEhCK1lDVHBQZWNxQi9ISXBUdWlsZ1MzU0FMemVsYk9mVUJPNmk0?=
 =?utf-8?B?NXhxSjIwUjNFYlZVOGNWdTFkMEFITXlleFNZNTlpUUxLVzRtdFVzVnhJNStC?=
 =?utf-8?B?NUt2SVpwdllBWVRhbDZMN004OVNqTUxrVTd4VTl3ck1palMwamU1RWJMcVh1?=
 =?utf-8?B?dkxYVmEzbXBsQTBwZ3dta3FxVzA2cEdEd2J5b2pYZTQ2TTE3a3NkK2h5UlMx?=
 =?utf-8?B?V01CQWtsRVBQdzRMZnBIblZ6OFpTUHRSZXVZUG4yQTlNcjFFS2doZDkvZVJl?=
 =?utf-8?B?ckRkWlE5VnhBM0QwRXBhZjR5NnBHdUFiV3I3NUFndWNGOWRpa2tmSS85aFVK?=
 =?utf-8?B?ZEtKbno5MTRyT0FiUTZFYzg1T2xnT0pjZ0loVmtrOG05OEZQMUdiRnFOSmYw?=
 =?utf-8?B?ekhDQUY0enJxNVJiMXBMbjFWM1lGQ2hXcDV3bjJpR0ZYSHd5a0dCT3ZQTFFU?=
 =?utf-8?B?VnQxeTJIWTg0Y1ZRNk5IT3NNY0twTUtMeU5MeFZyVmx0aXZIb3JjUDJmTGUy?=
 =?utf-8?B?Sk1RWGdkNkhzVi9oNVRqN2ZuTGRyczVDRFRLREFFVjlIWHFXRzdQcVpUK1NM?=
 =?utf-8?B?ZVlXRndYbWtiLzNidmsyR0hLRG1xY0ExRmM4SGIyemF1c0VOZnpEWFFiYWow?=
 =?utf-8?B?WHQvQVRwRWVoTTFGd2pJK2E2d2ZOdks0RHRMZ0x0eFpYanZrSDZObUFsL2h0?=
 =?utf-8?B?RWd6WVNDUUsvU1Z0NjBSTVlySzRyeTY4SWE1dWtqTzhvRXk2VENaS1hkL1hn?=
 =?utf-8?B?SVRuUUpSSUpEbHFLRzBDb0FGVXZ4d0YzckNLMWF4emdvUHZ4dUhVRm9SUGVO?=
 =?utf-8?B?YU5xdnhYWndJd21qNGpRYk8xakMvZC9xYXIzYkxWS2JURE13eWNINUFvclZr?=
 =?utf-8?Q?IJy0l6qxOLMttmlAUFnOt9r3TXTYmdO8StkmQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(376011)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2xTU2dLODFRdlBER0ZRZ0ltZWVTVTcyazd0empuVC9Fck05elJhWm5YVEd5?=
 =?utf-8?B?Q2JtcVNBNS9jR1pMamd2bHFwQ1ZzSXJsZnpYemplWktsd1owTC82SE1uSzZC?=
 =?utf-8?B?TjJhZmlNeXcwbkhhcVVWRG00ZVE5d1RWWWZoOS9vRVFzdzJUVkM0Z3hJNVlw?=
 =?utf-8?B?Y1h5d3piSlVpWTVwbWpNL1Z3c3VmM3FBRHFXYUxBTXE0Q1F0N1hBUVRFSGZD?=
 =?utf-8?B?YWtxS3FlQ2VrTldEajEvR1FQTHVLL0M2cHQwcWZkcDlQdnZvcFpPYktlUDBG?=
 =?utf-8?B?aUlMTmRXTCtRWXp0N3dmTEVXa0w4c3NPZlR1NEtlZEhFN0IrYlp6QjhvbE1G?=
 =?utf-8?B?b0UrM1hvR3daTXA2bXhTZmxhYWN0RmREK2poenQ1VmM0cG1xNFZGNlVjYVFI?=
 =?utf-8?B?SWl1NWNIVlRCb0NGMjZ4U2MwSkYxV3hyaTNsaWlGVStESERDeUxteU1xc3VH?=
 =?utf-8?B?WlRqazdnbnBRTEd1YVZPYVZkRytFczhkYnFPOUtJMWcxdU5nWlhiVUVtT1gx?=
 =?utf-8?B?RXpuNHE0SFN1Zkp3MTlnWmVZSGY1bUtOQ0VoUmNHbkVmakxGaWFkVlRpa01k?=
 =?utf-8?B?RzlXQ21Ia2h2UmZDRmhrcHYxZnM1TnpEcnRwZUYrZlJ0eXE0dVpFWlIydmlM?=
 =?utf-8?B?R1NDTjYwZVVFZkIzU1BJV0MvVi91c3UyMDFVMTBkbnRFY1RHU05POFh6SG9p?=
 =?utf-8?B?M1ZrbUsxMFdWOVROV1dBVHUzSGdCYXNRa3Z5SU5sdlA0aGY0Mmprd2s3WkdV?=
 =?utf-8?B?bGQ5bnVueTNuMFp5UHE3SzVOU1BzeE5sOHlKMzZtbUYrb2JzZDBYVU1wV2J3?=
 =?utf-8?B?SlhqYS95MUZVd0VmaU45Q1BIRWkveXRUK0VCRjJYeTAvUm1veUNiVEpHZ1dF?=
 =?utf-8?B?ejVFd0xGMFdJekE0cGI4NjFrOTR3a0duZE54a3lyTm02M1ZqRkFhOSt2OTZ3?=
 =?utf-8?B?SWQ4NnpBZnpBT1pkQmJmcXVDa3pmTktDV2lXQ25WaHhSOU4xa3FZUWdWVURj?=
 =?utf-8?B?eE51cFQ1bHN2eDVYYTdLbHRZa0dJajN4K2c0dHJYMERkMnMzVzQxalhRR0hT?=
 =?utf-8?B?V0JlNkJBczhtNlE5cTJMaWtaQkJFcEptcWlTd1B6NFJYb3NzU0dHWGxsTVhq?=
 =?utf-8?B?Sy9YVHlrd1dJaFM5VEVaRzZyMmIwZWkremk0SFlhVHJEUTFDcXNaVDBDeSta?=
 =?utf-8?B?RWYxUmRIajhxWGI4ZEJWWG1lVzUvZFlDNUVyaXJkd3VBakdMeGFyRWtnK0N0?=
 =?utf-8?B?cW0xZUhSZ2YrOWtuRjZLNDBqUmJyRHh1ZEVLZ2dXT1orb0RsOTVKNmZ2RFI0?=
 =?utf-8?B?Q2VxVkRkQTltSTRIbHFjVkg2Vk5WZmpoRDRaeER5c29nV0VRcWdDUEN0Rlpx?=
 =?utf-8?B?SGNIZzFJVnpiMFJhVGpDbEorb2hXMzMxMEtnRTJSeWM4TzBJcU92VFRuZTc3?=
 =?utf-8?B?NVd6Y0VhL2x3Z3ArRnZGVkVNaTUxTzZRWUNiREViSFhFangvZmJSM0VaWjJn?=
 =?utf-8?B?ZE1qTkovcDhOa0FUbFBRVkY1YnNUWWpvN0dQVGNtdUJDOFU5aW1UN1RmOWpN?=
 =?utf-8?B?R0dhNDlSZ3NoeWNDOSt3bkI5amh6R2NWT3hLNFk2cVFHUEFGL1hMOVN6cVFw?=
 =?utf-8?B?Y3JNd0hLRHJJUmh1eUd0T2RYUmx5RUk0cXpzU1Q5aGNxU00vN2dRSVBNeHNH?=
 =?utf-8?B?QkF4ZXJ4MHEvM0hvMkx4cTd3VzN2YjFjc09waUZPWXkrQXgvR3ZLamIzM2FR?=
 =?utf-8?B?Um5ZOXBnYi80VDQrL0IyaTNwYTdRbHF5NFFZcHlXSW9PY0pUNnlWeW53dVJL?=
 =?utf-8?B?TFhpZTFNUDM2VE9kWmhjYVVYbzgyUDZHVGwzZHpYOXFiaUxDRHY0L2RSME5W?=
 =?utf-8?B?VHg3OXhLVU8vaExpMGEwaytXZEFXKzErOUtNeVNpZmpiVUJ4b0xwYnJDVUl0?=
 =?utf-8?B?TlMwTlBHTmtxaUlzRnBJOEc5NEZrT3E4MEVWQmI0L3FIZTBKdlBIOG4rWXNM?=
 =?utf-8?B?bjF3NHhPY09jOGcrb3VyTGR0clhac2JBS01sN29YaFpHdmloTUxkNVZldkRk?=
 =?utf-8?B?OEdJVUEvdkszbG1ZY09pUHZESXdOV1o0QkNYYk5GNzRiQW8vRi8xM2QvY21B?=
 =?utf-8?B?WHVVaUp0V3p1RTJJV2NuOEt0OHM5WVcvd0JORnoycjhqNitMTDFNOXp6RFJ6?=
 =?utf-8?Q?Kbcyl6BJ22VT8BiIEjQZ9Oohks0OjoJ7DMvFFuzh9WI8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BAEBD2E69B14D4FAB4CA5AF9C4DD949@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab05394-9820-4cea-61a0-08dc90822026
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 17:06:13.9268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z3CE6Orc1EUAytmcVrqR5u18MjbmqdzG/7oF5JEeU4bpcpHX1BlcjUTIE1QuIzv1WTEwT7lB9BoHq3EHC/TkNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6068

T24gV2VkLCAyMDI0LTA2LTE5IGF0IDE3OjA4ICswMjAwLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiB3
cm90ZToNCj4gT24gTW9uLCBKdW4gMTcsIDIwMjQgYXQgNTowOeKAr1BNIERyYWdvcyBUYXR1bGVh
IDxkdGF0dWxlYUBudmlkaWEuY29tPiB3cm90ZToNCj4gPiANCj4gPiBUaGUgdmlydHF1ZXVlIHNp
emUgaXMgYSBwcmUtcmVxdWlzaXRlIGZvciBzZXR0aW5nIHVwIGFueSB2aXJ0cXVldWUNCj4gPiBy
ZXNvdXJjZXMuIEZvciB0aGUgdXBjb21pbmcgb3B0aW1pemF0aW9uIG9mIGNyZWF0aW5nIHZpcnRx
dWV1ZXMgYXQNCj4gPiBkZXZpY2UgYWRkLCB0aGUgdmlydHF1ZXVlIHNpemUgaGFzIHRvIGJlIGNv
bmZpZ3VyZWQuDQo+ID4gDQo+ID4gU3RvcmUgdGhlIGRlZmF1bHQgcXVldWUgc2l6ZSBpbiBzdHJ1
Y3QgbWx4NV92ZHBhX25ldCB0byBtYWtlIGl0IGVhc3kgaW4NCj4gPiB0aGUgZnV0dXJlIHRvIHBy
ZS1jb25maWd1cmUgdGhpcyBkZWZhdWx0IHZhbHVlIHZpYSB2ZHBhIHRvb2wuDQo+ID4gDQo+ID4g
VGhlIHF1ZXVlIHNpemUgY2hlY2sgaW4gc2V0dXBfdnEoKSB3aWxsIGFsd2F5cyBiZSBmYWxzZS4g
U28gcmVtb3ZlIGl0Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IERyYWdvcyBUYXR1bGVhIDxk
dGF0dWxlYUBudmlkaWEuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBDb3NtaW4gUmF0aXUgPGNyYXRp
dUBudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMgfCA3ICsrKystLS0NCj4gPiAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5o
IHwgMSArDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMNCj4gPiBpbmRleCAyNDVi
NWRhYzk4ZDMuLjExODFlMGFjMzY3MSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4
NS9uZXQvbWx4NV92bmV0LmMNCj4gPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMNCj4gPiBAQCAtNTgsNiArNTgsOCBAQCBNT0RVTEVfTElDRU5TRSgiRHVhbCBCU0QvR1BM
Iik7DQo+ID4gICAqLw0KPiA+ICAjZGVmaW5lIE1MWDVWX0RFRkFVTFRfVlFfQ09VTlQgMg0KPiA+
IA0KPiA+ICsjZGVmaW5lIE1MWDVWX0RFRkFVTFRfVlFfU0laRSAyNTYNCj4gPiArDQo+ID4gIHN0
cnVjdCBtbHg1X3ZkcGFfY3FfYnVmIHsNCj4gPiAgICAgICAgIHN0cnVjdCBtbHg1X2ZyYWdfYnVm
X2N0cmwgZmJjOw0KPiA+ICAgICAgICAgc3RydWN0IG1seDVfZnJhZ19idWYgZnJhZ19idWY7DQo+
ID4gQEAgLTE0NDUsOSArMTQ0Nyw2IEBAIHN0YXRpYyBpbnQgc2V0dXBfdnEoc3RydWN0IG1seDVf
dmRwYV9uZXQgKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlICptdnEpDQo+ID4gICAg
ICAgICB1MTYgaWR4ID0gbXZxLT5pbmRleDsNCj4gPiAgICAgICAgIGludCBlcnI7DQo+ID4gDQo+
ID4gLSAgICAgICBpZiAoIW12cS0+bnVtX2VudCkNCj4gPiAtICAgICAgICAgICAgICAgcmV0dXJu
IDA7DQo+ID4gLQ0KPiA+ICAgICAgICAgaWYgKG12cS0+aW5pdGlhbGl6ZWQpDQo+ID4gICAgICAg
ICAgICAgICAgIHJldHVybiAwOw0KPiA+IA0KPiA+IEBAIC0zNTIzLDYgKzM1MjIsNyBAQCBzdGF0
aWMgdm9pZCBpbml0X212cXMoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpDQo+ID4gICAgICAg
ICAgICAgICAgIG12cS0+bmRldiA9IG5kZXY7DQo+ID4gICAgICAgICAgICAgICAgIG12cS0+Zndx
cC5mdyA9IHRydWU7DQo+ID4gICAgICAgICAgICAgICAgIG12cS0+Zndfc3RhdGUgPSBNTFg1X1ZJ
UlRJT19ORVRfUV9PQkpFQ1RfTk9ORTsNCj4gPiArICAgICAgICAgICAgICAgbXZxLT5udW1fZW50
ID0gbmRldi0+ZGVmYXVsdF9xdWV1ZV9zaXplOw0KPiA+ICAgICAgICAgfQ0KPiA+ICB9DQo+ID4g
DQo+ID4gQEAgLTM2NjAsNiArMzY2MCw3IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX2Rldl9hZGQo
c3RydWN0IHZkcGFfbWdtdF9kZXYgKnZfbWRldiwgY29uc3QgY2hhciAqbmFtZSwNCj4gPiAgICAg
ICAgICAgICAgICAgZ290byBlcnJfYWxsb2M7DQo+ID4gICAgICAgICB9DQo+ID4gICAgICAgICBu
ZGV2LT5jdXJfbnVtX3ZxcyA9IE1MWDVWX0RFRkFVTFRfVlFfQ09VTlQ7DQo+ID4gKyAgICAgICBu
ZGV2LT5kZWZhdWx0X3F1ZXVlX3NpemUgPSBNTFg1Vl9ERUZBVUxUX1ZRX1NJWkU7DQo+ID4gDQo+
ID4gICAgICAgICBpbml0X212cXMobmRldik7DQo+ID4gICAgICAgICBhbGxvY2F0ZV9pcnFzKG5k
ZXYpOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0Lmgg
Yi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmgNCj4gPiBpbmRleCA5MGI1NTZhNTc5
NzEuLjJhZGEyOTc2N2NjNSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmgNCj4gPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmgN
Cj4gPiBAQCAtNTgsNiArNTgsNyBAQCBzdHJ1Y3QgbWx4NV92ZHBhX25ldCB7DQo+ID4gICAgICAg
ICBib29sIHNldHVwOw0KPiA+ICAgICAgICAgdTMyIGN1cl9udW1fdnFzOw0KPiA+ICAgICAgICAg
dTMyIHJxdF9zaXplOw0KPiA+ICsgICAgICAgdTE2IGRlZmF1bHRfcXVldWVfc2l6ZTsNCj4gDQo+
IEl0IHNlZW1zIHRvIG1lIHRoaXMgaXMgb25seSBhc3NpZ25lZCBoZXJlIGFuZCBub3QgdXNlZCBp
biB0aGUgcmVzdCBvZg0KPiB0aGUgc2VyaWVzLCB3aHkgYWxsb2NhdGUgYSBtZW1iZXIgaGVyZSBp
bnN0ZWFkIG9mIHVzaW5nIG1hY3JvDQo+IGRpcmVjdGx5Pw0KSXQgaXMgdXNlZCBpbiBpbml0X212
cXMoKS4gSSB3YW50ZWQgdG8gbWFrZSBpdCBlYXN5IGluIGNhc2Ugd2UgYWRkIHRoZSBkZWZhdWx0
DQpxdWV1ZSBzaXplIHRvIHRoZSBtdnEgdG9vbC4gSSdtIGFsc28gb2sgd2l0aCBzd2l0Y2hpbmcg
dG8gY29uc3RhbnRzIGZvciBub3cuDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXdzIQ0KDQpU
aGFua3MsDQpEcmFnb3MNCj4gDQo+ID4gICAgICAgICBib29sIG5iX3JlZ2lzdGVyZWQ7DQo+ID4g
ICAgICAgICBzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgbmI7DQo+ID4gICAgICAgICBzdHJ1Y3QgdmRw
YV9jYWxsYmFjayBjb25maWdfY2I7DQo+ID4gDQo+ID4gLS0NCj4gPiAyLjQ1LjENCj4gPiANCj4g
DQoNCg==

