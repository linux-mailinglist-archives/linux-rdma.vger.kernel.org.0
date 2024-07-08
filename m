Return-Path: <linux-rdma+bounces-3719-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8852E92A0D0
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 13:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009ED1F21ECB
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 11:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547807BAE7;
	Mon,  8 Jul 2024 11:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YAlfmVnZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5633374429;
	Mon,  8 Jul 2024 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437434; cv=fail; b=Px9Jxb3HVaPquEyp1o9Wmth7znW+KHSYTeV7+FWAuXiAbUzD01dpTSe04i3Z0ij+/8OeUFauQchOgL9vuVkJzyJxP0RSz4cNfjDNka5/Xu5iv4lyQvOfNBNRhjUWwSdNUjMvpQ3aiv38b9YOIdSv6sRi1RT3JhY+yCHHyWjrIRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437434; c=relaxed/simple;
	bh=v4BTBPgnPUWH9xgp7NU+2CMyU5cffW8evkv4u5PSzE8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JlOGpx06AwuxHmsiQn9Ov1eY61JOtOUZ71GxMKpprJ1hYJE32NfMI4lvLltffVdOjuHUPYCOd05R97X3ct9qZw2SBqKsox9tTL3JEpO/ChGJnwyWCHVDC006ZnmhpLe6wHF7vmO+tXHYwqCvwOUvJghFe91WIKv7L5vsWw3rkoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YAlfmVnZ; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9RWruc2T27R+Q6in8hTTP5WqBHAsHXsj/7fdjd1B0mhLsJblf1/nVKw+dMHazGugvdnf5ITGcZQokve2Ndew6iaBTlr1KvYeC2eckum9UBhb1FNpwSUwMn09y8+3Wfdf2GyvyFO+SZJ1pP9aXyZSYdg36PDFECWnxmxwrkultAIs9Fkdi9PViEChtIaStAkU3j/G2rWfWFLemAmxboS4MtS+4o6+LiWPB0BXJS/8LNf+o3jqVgAHWGMMopadduh4yvwkNJZ2W407LP1YVUo/9AJ4wLRttGuBQVw5q4s+d/5n4G9g2pK9uZfQtHguSLwn6Tn/RfOowrRhHL/AalY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4BTBPgnPUWH9xgp7NU+2CMyU5cffW8evkv4u5PSzE8=;
 b=TA45mLDXwyKYts161sBImjJn2+T4fQallXyoNEN/lNeIWk9qBC0F7Cj6ntSzqPTnZeRDOfIQYuc8RntJ+VpuutVUBnKDNgN92Z6uJurPmIIaFM5Ie+LM7QEgT2LM8PM5E7huiDhoPPWbOZdlUmLH7fj4XjgQcYcBruGKuIBJA29cVt/bAM1tfw/9AWDPa0v4jSfr+4HoswK6/oIp/ESMP6B3Ao5EAXcIXwlvhK0TR8qgHmWG8+Pssi7PfZ1E6qpT+EEgCzC0X23R6B+wPZPXAE71ZnDYA1aHZYf8Efv+ubiaIigQJai/+IslbriMNVQ43+UEoff9rs7ybZjZVJT/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4BTBPgnPUWH9xgp7NU+2CMyU5cffW8evkv4u5PSzE8=;
 b=YAlfmVnZ3AyHzbKM5L1CFtC8c7BZgm1k7vfZQty8CHF383p71OQ18cHGFc+urOR3HHLQ2YlYADrYzgzjt2WnlrJ6zc+K/wMPOBKcSuY7enVwP68UdZUm35S0JKiju45wBNQUd8nCoSlp6hAHWZWtNeUDD9ibPtlwEYhyOQ2pBYjtkBvECDBAfPSlRNpcevSRd7k5kFNPSFLK020ug5/sDTwK281kLeI4Ykm7yKmrCCDGRMh4A1y6b4suOAIk2zcx/FhK1n4MOpisRBckNf+Oka4kznio1IjV2UNilKVfz1UlPCVmlu1i4Gady5zK4tlSoTg9x4/x7Tm0W1Y/Ct9aKw==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 11:17:06 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 11:17:06 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "mst@redhat.com" <mst@redhat.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Tariq
 Toukan <tariqt@nvidia.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"leon@kernel.org" <leon@kernel.org>, "si-wei.liu@oracle.com"
	<si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH vhost 20/23] vdpa/mlx5: Pre-create hardware VQs at vdpa
 .dev_add time
Thread-Topic: [PATCH vhost 20/23] vdpa/mlx5: Pre-create hardware VQs at vdpa
 .dev_add time
Thread-Index:
 AQHawMhZfAWsnj0CYEOKT7TiC0tv/7HPQEaAgAqUMoCAC26hAIAHh78AgAAC0gCAAAF/gA==
Date: Mon, 8 Jul 2024 11:17:06 +0000
Message-ID: <27ef979aff26d3614091a4b966fc8b1d866e236f.camel@nvidia.com>
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
	 <20240617-stage-vdpa-vq-precreate-v1-20-8c0483f0ca2a@nvidia.com>
	 <CAJaqyWd3yiPUMaGEmzgHF-8u+HcqjUxBNB3=Xg6Lon-zYNVCow@mail.gmail.com>
	 <308f90bb505d12e899e3f4515c4abc93c39cfbd5.camel@nvidia.com>
	 <CAJaqyWeHDD0drkAZQqEP_ZfbUPscOmM7T8zXRie5Q14nfAV0sg@mail.gmail.com>
	 <c6dc541919a0cc78521364dbf4db32293cf1071e.camel@nvidia.com>
	 <20240708071005-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240708071005-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (3.52.3-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|MN0PR12MB6032:EE_
x-ms-office365-filtering-correlation-id: a67cc203-b76b-4171-9fab-08dc9f3f808b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NDZKTU9reDFibDBoNENFOVYzeURYaWNqMGJVUWpmRlc3SDBXcnNYRktJKzRZ?=
 =?utf-8?B?VWFoQ0JQQlYyMDZnSHpKc0lFWk1rUmxFdHo1cXBOQVBhYWIyZ3pMWC9zTTJw?=
 =?utf-8?B?T0dMcFJYOGh0YkM3YVljc1orcEZLSWV5MXpmamZZV0R3YzRQakxINmZvUkhP?=
 =?utf-8?B?UnU4TXp0SXRGWjNIYTlIOGliUVFYbUQrRDJOQzBLR05KOTdQcUVUYkNma1BN?=
 =?utf-8?B?YjRmTkNUVUtTYVM3WUlqZ0F3eXllWEhSQUw4bEM5cnFlRHd5N0YvdUZ5WU0w?=
 =?utf-8?B?aVRuVmdhaVhyZWtCUzVVdVc3cm5uLzBXVUk5NkRkSTdnZVNuVWFHMWRmWHRU?=
 =?utf-8?B?aEUvb1hLdkxyejZKaGVBUlZRVmFVUmpSTGV4eExjUjA3ZExIYmg0SS8ycDZh?=
 =?utf-8?B?SCtyWnpzVTNXRjY4anVKbmh0SlZHREZvNC9tOTQ4Y0dzT3JRLy80RUZ4dG8x?=
 =?utf-8?B?YnVSL1VGbXlLWk9wb25aUkVKNFo4MUo4YnRRQ1Zya0RoUHZFM1grSzVTYTFh?=
 =?utf-8?B?OXc3RXBCeE9Vd0FBWVlRV05mZThadGswVy84R1ZpRW5MMk45V1NEY2Y3MTVj?=
 =?utf-8?B?VUpESnJocjE5NTM2RCt3WkV4MHBLVnF6RGFnd1Y1cWJlSXkrck5pOGhwVklC?=
 =?utf-8?B?dVVWNVI5TUlLRWZiRm5WMkhlZ2FmUXhZNWxRUVA5djByeUFhSG5PRFpFUmo0?=
 =?utf-8?B?ekJRWTUwYWVQdE51M0lJY20raEZvN2NxU3ozQlNtekRDWElBZjJVd2owMENP?=
 =?utf-8?B?RW56ZkZqVlNHMHBIYnlNdHN2V2hTZGpBK3c5RWplT0J5U0dLaXJJOC9kN1kw?=
 =?utf-8?B?T3RFeXY0Mjh2UWIvOGVRNEUrNGxkZlRqSjRqVkNHbGg4REVhMGN2clBtTjls?=
 =?utf-8?B?dDZROEw4eFNFYWxMOUxhVERkUFYrZVBlNk8wNEFGWGNNNjkzZTRReG1aaDlx?=
 =?utf-8?B?WGVBdDRLb1FiakVyUnRmZEpaQzZEZlg0aThOM1VONDlhcjA3UWFibzR2MVRP?=
 =?utf-8?B?SGlibVdaaDVOZVM0eCtXdXB6YnVrZDIwNmJkbXY1b0xyL0tuQmgzUG9Kd0Vu?=
 =?utf-8?B?OVIzb29UNlI2K0ZYakhYRGpaTENpZ21HTVY1TzI1bkpvVm8yNHVmUlU4NTlk?=
 =?utf-8?B?V3NUSWhrT0xsRHpuMHZUcWhqUE01dWRDOXRqSVlkdk1OTlprbEpCenRucnNU?=
 =?utf-8?B?dUtTc1RVeEc0UzVGUitNY2NFc1JUak53MlRMNml1SXlKaFF5d3hTTkRiQVNl?=
 =?utf-8?B?dWZFd0QxS3lHV05aRGZtRzg4QWxjUVdCTVBpMTJLTHRlMDFKd3pPdTJLWFRj?=
 =?utf-8?B?R3Z5TWZFdmMrNkFYWVAzK2JNOCsyL3lWb3BnYmIrczMwUERxejArMkNXT0V4?=
 =?utf-8?B?NU0xSFhjSFdHUG94bVpxOXFia09OWS9XTVBubU5KK1BsMzZCOXo5RWEzanFN?=
 =?utf-8?B?cmZDVzhEMDFYRlAzeElXV28zamZqNklXbXdHenp2d0haalBqUDMzREd6NGE3?=
 =?utf-8?B?em1melMyRDZqUWR4bEhNVHFzanJtb1h1M1dLeHMwMW1qTFRXZVFQN2FtYmhM?=
 =?utf-8?B?UmcvNk1maXZFOXJISFdWMXhlblJuZHZsZDZZeFVDc3hPQzlqRFFZeTJwSFdU?=
 =?utf-8?B?TWk1TXZqeVdjdkx2NDBxalNsNDhoVEhZMk9WYUhyQVk1VUJ3bkdDRlJjd2RE?=
 =?utf-8?B?cVRlQ1MyYlJRN2xaeFNTZytXeXgvSFdkUmlDUDlSSndkTmRmUzJXd3I1VWFN?=
 =?utf-8?B?QTcvVEVqdUl1U1p6bndSVDVKTiswUTlSdForUm1HbTJrSlpodDBnazVOcUZQ?=
 =?utf-8?B?cE5JVkZ0MkdBQTlQZThYOGw5cmJ5WXYzb1YvSWMxZGNtSkNXQXNpNHlwVDg0?=
 =?utf-8?B?amhkdEtaMXpKRmRmYUljN2ErRkc0S00rNnk2UWtpK1JhY2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a3RyRmtKYXFiamJBaE8xbm9Bb2t3eVJGNW1lY1ZJRnplY01iaGZJZTFyRXRx?=
 =?utf-8?B?bllqd3F0czVuTWpzRzFIRUdLS3FXQnF3SnhGd2kwbHI2OGxwQ1ZIQ1hpMEFJ?=
 =?utf-8?B?cFNVZFZNVlk5cGRZRnVXRkZoL0VPTERqVXplbFloQTNrWVUzK01DOFZ0WktH?=
 =?utf-8?B?RmtrcVplS3p0Tk9id1dsRWludDl1bGZJT2gvYzZoK0JmT0hQMGkyL3paWEU0?=
 =?utf-8?B?bG5mSWoyVDllV2FHQnN6bjk5V1VxTE9yc2FHZEV0QktCbU9ldXVmVEcxZktV?=
 =?utf-8?B?dE5RSlVpSWtJRUlCaUtKekt1MGVIZmhsUS9OYldLZlBXRWtwVUc3eFRBdVpC?=
 =?utf-8?B?OXJKZk5JUzRWM1NiRkFVOHB5Q0E1RU8xQ3NQa3ZNZnRhQzdWQ09RUjlnY1VW?=
 =?utf-8?B?NlEwdWRwVWIrZ1B3ZzgvaklGdlM2NUttYjZiU1BKQUtXRW42U1BZWk5HVVNE?=
 =?utf-8?B?TEl3RGYwcXc3ZWdJQ0RUUXlWL3NBZzVNZ1pRSkUzSlRrNlBVbjVTVzM1Y0oy?=
 =?utf-8?B?UWZwZjZuY3pJcHR5TG1Pb3VHS25PSGNCQndYZ2hTcm1aVVJXQTdsYmJRUkF5?=
 =?utf-8?B?N1hkT1hFZDB2bHJJNlp2VTNnU0tzNWl5ZXhyb3ZUY1JQMlhsaVZGcEMvMUI2?=
 =?utf-8?B?Y1J6TzkxbVZSODFqY1hDMys1Y25kYWR6akVyMVRGOXBNTDVUdzB2dmxVZ1hU?=
 =?utf-8?B?bnpNZlhMSFpRRmRWY29uaDlCd2tIVys0MWtMUnhJUmxlSnpBaDFoM3pGZ1dn?=
 =?utf-8?B?cFNXb0I4c0Q5NjhUYmRCZ3FVVDJoNWE0SUpTT3Y5Y1ovTGN4UUw0RllheFhZ?=
 =?utf-8?B?YjlPUkJlOGp3YjBPL3VxajhSUy9pWmp6ZTA3YTJsQ2VJL0lSYTUvRGhoQ1Np?=
 =?utf-8?B?b3lQclV4TER3aXZkdjVieFpITEMxem1UL1N5SGx1SU9SL1ozekV2cEk0MjBv?=
 =?utf-8?B?RWg3R3FncXArVGV3dVBqdENhaEMzaFY1OW1qZHFUNGswdmdLbkhncGQ2TmNB?=
 =?utf-8?B?TFpXYWRBemRKdnNYMHozNk9qWnk1a2xFNEsvV1NDVXk2MWJHT2pPcjdFcVRh?=
 =?utf-8?B?Ujl4WExZdzROUnRtOHR4SUpYYzdvY3c1SktaZVlMWUFCODFzMWFkVi85S0ll?=
 =?utf-8?B?MjZRM1RLYlpQcm1uLzk3Zk9nL1dNeTRFZThPZjA5VDRqNVF2Vy9YQ2U2U2dt?=
 =?utf-8?B?eTJvMDJDc2VrN1NxdS9zNXF2dUFUZXV6Z3ltdTB5eGFmZkhjLzhSSHhKRlFs?=
 =?utf-8?B?NUwvZS9sbm4ycEZ0N1k1R2FwVFFWaUprRkVSaU4rNzZ4ZjAwNTdBVTc0Y2I1?=
 =?utf-8?B?ekV1YWtWWHVZZUdVS3VydURLZ21pV0UycGIxRjQ4OXRMcVViSGhIWXNrRFpD?=
 =?utf-8?B?dXlFcGtKMnJ5ZnRhazJocDlNNWdzeWJMUEVtNU94ZVlnTVZkMjNodDEvZm9D?=
 =?utf-8?B?QzFlZ25zdEZIOWhwMk02b0FRL0NaU1FmWUU4SXhRN0NnUXQrWTlTbmQ4ZDdE?=
 =?utf-8?B?OFdnOUhmc3dLWll3TTJYSEUxVUJpL1VPbjdXM3F0OUdoY1lyM2xxVWt1OG1Q?=
 =?utf-8?B?VEFuTEJzSEZVRXB5UmdtaXN5TnVIeDZUNlRZWVY0cFlRSm4rOWMxK1NUS2NQ?=
 =?utf-8?B?U3B5NzE2QXVmYlAyN1BkcStPMkNsYWMzQ0RvMWlKdkE3MWo0Y1pOZ3MzSVBP?=
 =?utf-8?B?dStkcFdEU0htUzVNNDJicVFNY2puMDZOQlRKeE5HMUpMWVFpdEpCOXZ2Y3Fr?=
 =?utf-8?B?alN4NWZGNXRtSzZSWDlyN3JldDhnME84RlpmRFhuNWw5K25HckZNUlNhM1FN?=
 =?utf-8?B?Uy9zNlV4NHpXUWFCRGZQV2M4RjF5d3VnN1lYOHg0cyt5ZkhPZjl2cWRxbHZt?=
 =?utf-8?B?bTFzNnJhanIrbk5wRk1vNnlBODROZUtiYU1XWFc3bmExQ2IvS3EvZEhXazNW?=
 =?utf-8?B?bk1wZnNvakJqWnpERG5ySzl1Ukk2RzV3ak9xUHhEMTRyNWJIK2psaXpwc1Z3?=
 =?utf-8?B?RHc5aXpFVTB2MDJ6eUJTa2U4dXNYbmRnL3ZERGZ1bXZYZ0xadm9GYm94dExX?=
 =?utf-8?B?d01abDJBdGxCMzgxelZQbkJ0cE5wRllVYVJGMjZyT1lrbW5MZVBaLzA1YVVT?=
 =?utf-8?B?QzV0aDNJY3U3b2VFUUVXTEFneTVEYjAzZHZmWUdZS0JIdWRsMEFwaFNTdUQx?=
 =?utf-8?Q?PtTSx6uMFny78CUvHIuuXNQDg+X/dpcxD9tE2RNCJ1Bq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8CBDF4B662B584299D7A69DF980ACB3@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a67cc203-b76b-4171-9fab-08dc9f3f808b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 11:17:06.7746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ND4EvVNBZXDE9drBgCv+0UifyCYMGBavv64tu9QOpBVrPxzzpGgfRCjV7yg55XV9UfQwtYR/ChleaJcun50WpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032

T24gTW9uLCAyMDI0LTA3LTA4IGF0IDA3OjExIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6DQo+IE9uIE1vbiwgSnVsIDA4LCAyMDI0IGF0IDExOjAxOjM5QU0gKzAwMDAsIERyYWdvcyBU
YXR1bGVhIHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAyNC0wNy0wMyBhdCAxODowMSArMDIwMCwgRXVn
ZW5pbyBQZXJleiBNYXJ0aW4gd3JvdGU6DQo+ID4gPiBPbiBXZWQsIEp1biAyNiwgMjAyNCBhdCAx
MToyN+KAr0FNIERyYWdvcyBUYXR1bGVhIDxkdGF0dWxlYUBudmlkaWEuY29tPiB3cm90ZToNCj4g
PiA+ID4gDQo+ID4gPiA+IE9uIFdlZCwgMjAyNC0wNi0xOSBhdCAxNzo1NCArMDIwMCwgRXVnZW5p
byBQZXJleiBNYXJ0aW4gd3JvdGU6DQo+ID4gPiA+ID4gT24gTW9uLCBKdW4gMTcsIDIwMjQgYXQg
NTowOeKAr1BNIERyYWdvcyBUYXR1bGVhIDxkdGF0dWxlYUBudmlkaWEuY29tPiB3cm90ZToNCj4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQ3VycmVudGx5LCBoYXJkd2FyZSBWUXMgYXJlIGNyZWF0
ZWQgcmlnaHQgd2hlbiB0aGUgdmRwYSBkZXZpY2UgZ2V0cyBpbnRvDQo+ID4gPiA+ID4gPiBEUklW
RVJfT0sgc3RhdGUuIFRoYXQgaXMgZWFzaWVyIGJlY2F1c2UgbW9zdCBvZiB0aGUgVlEgc3RhdGUg
aXMga25vd24gYnkNCj4gPiA+ID4gPiA+IHRoZW4uDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
IFRoaXMgcGF0Y2ggc3dpdGNoZXMgdG8gY3JlYXRpbmcgYWxsIFZRcyBhbmQgdGhlaXIgYXNzb2Np
YXRlZCByZXNvdXJjZXMNCj4gPiA+ID4gPiA+IGF0IGRldmljZSBjcmVhdGlvbiB0aW1lLiBUaGUg
bW90aXZhdGlvbiBpcyB0byByZWR1Y2UgdGhlIHZkcGEgZGV2aWNlDQo+ID4gPiA+ID4gPiBsaXZl
IG1pZ3JhdGlvbiBkb3dudGltZSBieSBtb3ZpbmcgdGhlIGV4cGVuc2l2ZSBvcGVyYXRpb24gb2Yg
Y3JlYXRpbmcNCj4gPiA+ID4gPiA+IGFsbCB0aGUgaGFyZHdhcmUgVlFzIGFuZCB0aGVpciBhc3Nv
Y2lhdGVkIHJlc291cmNlcyBvdXQgb2YgZG93bnRpbWUgb24NCj4gPiA+ID4gPiA+IHRoZSBkZXN0
aW5hdGlvbiBWTS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhlIFZRcyBhcmUgbm93IGNy
ZWF0ZWQgaW4gYSBibGFuayBzdGF0ZS4gVGhlIFZRIGNvbmZpZ3VyYXRpb24gd2lsbA0KPiA+ID4g
PiA+ID4gaGFwcGVuIGxhdGVyLCBvbiBEUklWRVJfT0suIFRoZW4gdGhlIGNvbmZpZ3VyYXRpb24g
d2lsbCBiZSBhcHBsaWVkIHdoZW4NCj4gPiA+ID4gPiA+IHRoZSBWUXMgYXJlIG1vdmVkIHRvIHRo
ZSBSZWFkeSBzdGF0ZS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gV2hlbiAuc2V0X3ZxX3Jl
YWR5KCkgaXMgY2FsbGVkIG9uIGEgVlEgYmVmb3JlIERSSVZFUl9PSywgc3BlY2lhbCBjYXJlIGlz
DQo+ID4gPiA+ID4gPiBuZWVkZWQ6IG5vdyB0aGF0IHRoZSBWUSBpcyBhbHJlYWR5IGNyZWF0ZWQg
YSByZXN1bWVfdnEoKSB3aWxsIGJlDQo+ID4gPiA+ID4gPiB0cmlnZ2VyZWQgdG9vIGVhcmx5IHdo
ZW4gbm8gbXIgaGFzIGJlZW4gY29uZmlndXJlZCB5ZXQuIFNraXAgY2FsbGluZw0KPiA+ID4gPiA+
ID4gcmVzdW1lX3ZxKCkgaW4gdGhpcyBjYXNlLCBsZXQgaXQgYmUgaGFuZGxlZCBkdXJpbmcgRFJJ
VkVSX09LLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBGb3IgdmlydGlvLXZkcGEsIHRoZSBk
ZXZpY2UgY29uZmlndXJhdGlvbiBpcyBkb25lIGVhcmxpZXIgZHVyaW5nDQo+ID4gPiA+ID4gPiAu
dmRwYV9kZXZfYWRkKCkgYnkgdmRwYV9yZWdpc3Rlcl9kZXZpY2UoKS4gQXZvaWQgY2FsbGluZw0K
PiA+ID4gPiA+ID4gc2V0dXBfdnFfcmVzb3VyY2VzKCkgYSBzZWNvbmQgdGltZSBpbiB0aGF0IGNh
c2UuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJIGd1ZXNzIHRoaXMgaGFw
cGVucyBpZiB2aXJ0aW9fdmRwYSBpcyBhbHJlYWR5IGxvYWRlZCwgYnV0IEkgY2Fubm90DQo+ID4g
PiA+ID4gc2VlIGhvdyB0aGlzIGlzIGRpZmZlcmVudCBoZXJlLiBBcGFydCBmcm9tIHRoZSBJT1RM
Qiwgd2hhdCBlbHNlIGRvZXMNCj4gPiA+ID4gPiBpdCBjaGFuZ2UgZnJvbSB0aGUgbWx4NV92ZHBh
IFBPVj8NCj4gPiA+ID4gPiANCj4gPiA+ID4gSSBkb24ndCB1bmRlcnN0YW5kIHlvdXIgcXVlc3Rp
b24sIGNvdWxkIHlvdSByZXBocmFzZSBvciBwcm92aWRlIG1vcmUgY29udGV4dA0KPiA+ID4gPiBw
bGVhc2U/DQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBNeSBtYWluIHBvaW50IGlzIHRoYXQgdGhl
IHZkcGEgcGFyZW50IGRyaXZlciBzaG91bGQgbm90IGJlIGFibGUgdG8NCj4gPiA+IHRlbGwgdGhl
IGRpZmZlcmVuY2UgYmV0d2VlbiB2aG9zdF92ZHBhIGFuZCB2aXJ0aW9fdmRwYS4gVGhlIG9ubHkN
Cj4gPiA+IGRpZmZlcmVuY2UgSSBjYW4gdGhpbmsgb2YgaXMgYmVjYXVzZSBvZiB0aGUgdmhvc3Qg
SU9UTEIgaGFuZGxpbmcuDQo+ID4gPiANCj4gPiA+IERvIHlvdSBhbHNvIG9ic2VydmUgdGhpcyBi
ZWhhdmlvciBpZiB5b3UgYWRkIHRoZSBkZXZpY2Ugd2l0aCAidmRwYQ0KPiA+ID4gYWRkIiB3aXRo
b3V0IHRoZSB2aXJ0aW9fdmRwYSBtb2R1bGUgbG9hZGVkLCBhbmQgdGhlbiBtb2Rwcm9iZQ0KPiA+
ID4gdmlydGlvX3ZkcGE/DQo+ID4gPiANCj4gPiBBYWgsIG5vdyBJIHVuZGVyc3RhbmQgd2hhdCB5
b3UgbWVhbi4gSW5kZWVkIGluIG15IHRlc3RzIEkgd2FzIGxvYWRpbmcgdGhlDQo+ID4gdmlydGlv
X3ZkcGEgbW9kdWxlIGJlZm9yZSBhZGRpbmcgdGhlIGRldmljZS4gV2hlbiBkb2luZyBpdCB0aGUg
b3RoZXIgd2F5IGFyb3VuZA0KPiA+IHRoZSBkZXZpY2UgZG9lc24ndCBnZXQgY29uZmlndXJlZCBk
dXJpbmcgcHJvYmUuDQo+ID4gIA0KPiA+IA0KPiA+ID4gQXQgbGVhc3QgdGhlIGNvbW1lbnQgc2hv
dWxkIGJlIHNvbWV0aGluZyBpbiB0aGUgbGluZSBvZiAiSWYgd2UgaGF2ZQ0KPiA+ID4gYWxsIHRo
ZSBpbmZvcm1hdGlvbiB0byBpbml0aWFsaXplIHRoZSBkZXZpY2UsIHByZS13YXJtIGl0IGhlcmUi
IG9yDQo+ID4gPiBzaW1pbGFyLg0KPiA+IE1ha2VzIHNlbnNlLiBJIHdpbGwgc2VuZCBhIHYzIHdp
dGggdGhlIGNvbW1pdCArIGNvbW1lbnQgbWVzc2FnZSB1cGRhdGUuDQo+IA0KPiANCj4gSXMgY29t
bWl0IHVwZGF0ZSB0aGUgb25seSBjaGFuZ2UgdGhlbj8NCkkgd2FzIHBsYW5uaW5nIHRvIGRyb3Ag
dGhlIHBhcmFncmFwaCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgKGl0IGlzIGNvbmZ1c2luZykgYW5k
DQplZGl0IHRoZSBjb21tZW50IGJlbG93IChzY3JvbGwgZG93biB0byBzZWUgd2hpY2gpLg0KDQpM
ZXQgbWUga25vdyBpZiBJIHNob3VsZCBzZW5kIHRoZSB2MyBvciBub3QuIEkgaGF2ZSBpdCBwcmVw
YXJlZC4NCg0KPiANCj4gPiA+IA0KPiA+ID4gPiBUaGFua3MsDQo+ID4gPiA+IERyYWdvcw0KPiA+
ID4gPiANCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IERyYWdvcyBUYXR1bGVhIDxkdGF0dWxl
YUBudmlkaWEuY29tPg0KPiA+ID4gPiA+ID4gUmV2aWV3ZWQtYnk6IENvc21pbiBSYXRpdSA8Y3Jh
dGl1QG52aWRpYS5jb20+DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICBkcml2ZXJzL3Zk
cGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAzNyArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tDQo+ID4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyks
IDUgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMNCj4gPiA+ID4gPiA+IGluZGV4IDI0OWI1YWZiZTM0YS4uYjI4MzZmZDNkMWRk
IDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5l
dC5jDQo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMN
Cj4gPiA+ID4gPiA+IEBAIC0yNDQ0LDcgKzI0NDQsNyBAQCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFf
c2V0X3ZxX3JlYWR5KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCwgYm9vbCByZWFk
eQ0KPiA+ID4gPiA+ID4gICAgICAgICBtdnEgPSAmbmRldi0+dnFzW2lkeF07DQo+ID4gPiA+ID4g
PiAgICAgICAgIGlmICghcmVhZHkpIHsNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICBzdXNw
ZW5kX3ZxKG5kZXYsIG12cSk7DQo+ID4gPiA+ID4gPiAtICAgICAgIH0gZWxzZSB7DQo+ID4gPiA+
ID4gPiArICAgICAgIH0gZWxzZSBpZiAobXZkZXYtPnN0YXR1cyAmIFZJUlRJT19DT05GSUdfU19E
UklWRVJfT0spIHsNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICBpZiAocmVzdW1lX3ZxKG5k
ZXYsIG12cSkpDQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICByZWFkeSA9IGZh
bHNlOw0KPiA+ID4gPiA+ID4gICAgICAgICB9DQo+ID4gPiA+ID4gPiBAQCAtMzA3OCwxMCArMzA3
OCwxOCBAQCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfc2V0X3N0YXR1cyhzdHJ1Y3QgdmRwYV9kZXZp
Y2UgKnZkZXYsIHU4IHN0YXR1cykNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZ290byBlcnJfc2V0dXA7DQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICB9DQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICByZWdpc3Rlcl9saW5r
X25vdGlmaWVyKG5kZXYpOw0KPiA+ID4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgZXJy
ID0gc2V0dXBfdnFfcmVzb3VyY2VzKG5kZXYsIHRydWUpOw0KPiA+ID4gPiA+ID4gLSAgICAgICAg
ICAgICAgICAgICAgICAgaWYgKGVycikgew0KPiA+ID4gPiA+ID4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBtbHg1X3ZkcGFfd2FybihtdmRldiwgImZhaWxlZCB0byBzZXR1cCBkcml2
ZXJcbiIpOw0KPiA+ID4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3Rv
IGVycl9kcml2ZXI7DQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAobmRl
di0+c2V0dXApIHsNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ZXJyID0gcmVzdW1lX3ZxcyhuZGV2KTsNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaWYgKGVycikgew0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG1seDVfdmRwYV93YXJuKG12ZGV2LCAiZmFpbGVkIHRvIHJlc3Vt
ZSBWUXNcbiIpOw0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGdvdG8gZXJyX2RyaXZlcjsNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfQ0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNl
IHsNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXJyID0gc2V0
dXBfdnFfcmVzb3VyY2VzKG5kZXYsIHRydWUpOw0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpZiAoZXJyKSB7DQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgbWx4NV92ZHBhX3dhcm4obXZkZXYsICJmYWlsZWQgdG8g
c2V0dXAgZHJpdmVyXG4iKTsNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBnb3RvIGVycl9kcml2ZXI7DQo+ID4gPiA+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIH0NCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
IH0NCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICB9IGVsc2Ugew0KPiA+ID4gPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgbWx4NV92ZHBhX3dhcm4obXZkZXYsICJkaWQgbm90IGV4cGVj
dCBEUklWRVJfT0sgdG8gYmUgY2xlYXJlZFxuIik7DQo+ID4gPiA+ID4gPiBAQCAtMzE0Miw2ICsz
MTUwLDcgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfY29tcGF0X3Jlc2V0KHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRldiwgdTMyIGZsYWdzKQ0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgIGlmICht
bHg1X3ZkcGFfY3JlYXRlX2RtYV9tcihtdmRldikpDQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICBtbHg1X3ZkcGFfd2FybihtdmRldiwgImNyZWF0ZSBNUiBmYWlsZWRcbiIpOw0K
PiA+ID4gPiA+ID4gICAgICAgICB9DQo+ID4gPiA+ID4gPiArICAgICAgIHNldHVwX3ZxX3Jlc291
cmNlcyhuZGV2LCBmYWxzZSk7DQo+ID4gPiA+ID4gPiAgICAgICAgIHVwX3dyaXRlKCZuZGV2LT5y
ZXNsb2NrKTsNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gICAgICAgICByZXR1cm4gMDsNCj4g
PiA+ID4gPiA+IEBAIC0zODM2LDggKzM4NDUsMjEgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfZGV2
X2FkZChzdHJ1Y3QgdmRwYV9tZ210X2RldiAqdl9tZGV2LCBjb25zdCBjaGFyICpuYW1lLA0KPiA+
ID4gPiA+ID4gICAgICAgICAgICAgICAgIGdvdG8gZXJyX3JlZzsNCj4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gICAgICAgICBtZ3RkZXYtPm5kZXYgPSBuZGV2Ow0KPiA+ID4gPiA+ID4gKw0KPiA+
ID4gPiA+ID4gKyAgICAgICAvKiBGb3IgdmlydGlvLXZkcGEsIHRoZSBkZXZpY2Ugd2FzIHNldCB1
cCBkdXJpbmcgZGV2aWNlIHJlZ2lzdGVyLiAqLw0KPiA+ID4gPiA+ID4gKyAgICAgICBpZiAobmRl
di0+c2V0dXApDQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gPiA+
ID4gPiArDQpUaGlzIGNvbW1lbnQgdXBkYXRlZCB0bzoNCg0KLyogVGhlIFZRcyBtaWdodCBoYXZl
IGJlZW4gcHJlLWNyZWF0ZWQgZHVyaW5nIGRldmljZSByZWdpc3Rlci4NCiAqIFRoaXMgaGFwcGVu
cyB3aGVuIHZpcnRpb192ZHBhIGlzIGxvYWRlZCBiZWZvcmUgdGhlIHZkcGEgZGV2aWNlIGlzIGFk
ZGVkLg0KICovDQoNCg0KPiA+ID4gPiA+ID4gKyAgICAgICBkb3duX3dyaXRlKCZuZGV2LT5yZXNs
b2NrKTsNCj4gPiA+ID4gPiA+ICsgICAgICAgZXJyID0gc2V0dXBfdnFfcmVzb3VyY2VzKG5kZXYs
IGZhbHNlKTsNCj4gPiA+ID4gPiA+ICsgICAgICAgdXBfd3JpdGUoJm5kZXYtPnJlc2xvY2spOw0K
PiA+ID4gPiA+ID4gKyAgICAgICBpZiAoZXJyKQ0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAg
IGdvdG8gZXJyX3NldHVwX3ZxX3JlczsNCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICAgICAg
ICAgcmV0dXJuIDA7DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ICtlcnJfc2V0dXBfdnFfcmVz
Og0KPiA+ID4gPiA+ID4gKyAgICAgICBfdmRwYV91bnJlZ2lzdGVyX2RldmljZSgmbXZkZXYtPnZk
ZXYpOw0KPiA+ID4gPiA+ID4gIGVycl9yZWc6DQo+ID4gPiA+ID4gPiAgICAgICAgIGRlc3Ryb3lf
d29ya3F1ZXVlKG12ZGV2LT53cSk7DQo+ID4gPiA+ID4gPiAgZXJyX3JlczI6DQo+ID4gPiA+ID4g
PiBAQCAtMzg2Myw2ICszODg1LDExIEBAIHN0YXRpYyB2b2lkIG1seDVfdmRwYV9kZXZfZGVsKHN0
cnVjdCB2ZHBhX21nbXRfZGV2ICp2X21kZXYsIHN0cnVjdCB2ZHBhX2RldmljZSAqDQo+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+ICAgICAgICAgdW5yZWdpc3Rlcl9saW5rX25vdGlmaWVyKG5kZXYp
Ow0KPiA+ID4gPiA+ID4gICAgICAgICBfdmRwYV91bnJlZ2lzdGVyX2RldmljZShkZXYpOw0KPiA+
ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKyAgICAgICBkb3duX3dyaXRlKCZuZGV2LT5yZXNsb2Nr
KTsNCj4gPiA+ID4gPiA+ICsgICAgICAgdGVhcmRvd25fdnFfcmVzb3VyY2VzKG5kZXYpOw0KPiA+
ID4gPiA+ID4gKyAgICAgICB1cF93cml0ZSgmbmRldi0+cmVzbG9jayk7DQo+ID4gPiA+ID4gPiAr
DQo+ID4gPiA+ID4gPiAgICAgICAgIHdxID0gbXZkZXYtPndxOw0KPiA+ID4gPiA+ID4gICAgICAg
ICBtdmRldi0+d3EgPSBOVUxMOw0KPiA+ID4gPiA+ID4gICAgICAgICBkZXN0cm95X3dvcmtxdWV1
ZSh3cSk7DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4gPiAyLjQ1LjEN
Cj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+IA0KPiA+IA0KPiANClRo
YW5rcywNCkRyYWdvcw0KDQo=

