Return-Path: <linux-rdma+bounces-3748-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD9D92A78B
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 18:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9D21C213B1
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 16:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01B2148317;
	Mon,  8 Jul 2024 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="foyUnhCp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816C11474A3;
	Mon,  8 Jul 2024 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457037; cv=fail; b=jXLRfmj3yCq32YpSK0+BNJzAL76LlQV5J5qfdHbiMNgp2Zq/CehV5HtmK6wJyGDqi2kNVQvKHdhIAC6Z7+Imx5IeID6jQzlX1dMB/R5eJFxGJsuaBQi5sDnEgj01+FuwRK4fbRMIX7AF26JS7ZHIdSdLSjbCWaSG+mxSFdKUUgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457037; c=relaxed/simple;
	bh=53bKJ4KEzXxW2icMmZpaGDoXSH/58QL2my7hWAUybn0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TeOP5QjOWJ3VsybNWCyDBsL5GoKbnOL9R4EISx/BvFUxJWH4PFy5DnadnTFGv/QfinpndrR1K3yhAxnw1HLO4un9T+1gfjjEhLHM6YEzJQTehhYDyHWylTr/Z0wZA91jdwabYAs0/lGzA0aMOB+pA3rHGU8ym7laRqyc0XkxSLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=foyUnhCp; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQ+XK+cMglkls++xbR7tymSzt3vii5Q0CrkO8XeUUWR3QhTB468sjeZ7kL/db8jj6RjFC0N1+s7bBObm1ztqQY7p9kTfd+CERCFlvnblIjW1lYFf35otBrqVo+Om3I8Lm2dXVTHiA0Td3xn5tn/NAA9MJ1LVXGpYyode0efBHwE7cPZbpcAvGbG6IOFp8dz8+Hrs01QH2V4OQ/7/SZ140x2WVedjMSmk8OVxsVLYDwruJvV3i1IcQZFEnxii2Ca0PTI+wnbTbDZGqTndU7MyB9GyVYCdtibnXwxTdqdCMRATRntj6gdD257av2KvosKadiwKj5CHZ7PRU+mMDbR+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53bKJ4KEzXxW2icMmZpaGDoXSH/58QL2my7hWAUybn0=;
 b=KWAo5lcOJwRr2UiZdsrnlot5YcV0SFXi7nhbrXGmj8QZTHugD2JDZjt16ay5oDBUug2ejOlfomn+6gpVwf6NTwfSuSd6d0qrlae2ltD2TtEJmjSBFcFogreXFbnKoGsLqG7LvHaI6p57ZYToZDwYjumj2ZsuM1wAXGWuY0043jNp0fhr8BKxPOjsOw8/Y0uiXR/KTfk1cV5Tv1ZzxhJUaEiLDZenDE1vi+YwWV3eaYK0b684Ypd5a41lm5R4cFb1UP8WbybY270KiFH3ezoiogvsnv23Po4fRgRw1Puv8gT8jrS50jZYM37oHiuta6W2iR1jBSdsLOO76fZjvOgOiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53bKJ4KEzXxW2icMmZpaGDoXSH/58QL2my7hWAUybn0=;
 b=foyUnhCp/2WnWBC7xoyDiW5r3Ff6Il5GQKf3iyto6X7Lp8ggln1cSa8nUFssH1BW3VkmY8Rmcg75qEUbT+VtYXbu+7zaQ3be8FnFvdDIcLAlOYjrq5UanB0foz3zrq4ThHhgrvXbhcZTQrs2SUhuzlRU9YWy54WcZl1ePrCkqU+HNk4TW+t2AACd8QJ0UQ4yrnO7LuaDIjjqF/j9rfuhYeG/pHS4oTaRCHMRVQ4s77cX229nFljNI0i2mscoH0wqBKBsphyNGEFB8aGGJDsybP8viuN17J0ULZMiWWhwH9NElElN/b31VTf4RLVAaHk2mbON9v0X5tf7NwUCdHpJsg==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 16:43:49 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 16:43:49 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, Tariq Toukan
	<tariqt@nvidia.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>, "si-wei.liu@oracle.com"
	<si-wei.liu@oracle.com>, "mst@redhat.com" <mst@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Saeed Mahameed
	<saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>
CC: Cosmin Ratiu <cratiu@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH vhost 20/23] vdpa/mlx5: Pre-create hardware VQs at vdpa
 .dev_add time
Thread-Topic: [PATCH vhost 20/23] vdpa/mlx5: Pre-create hardware VQs at vdpa
 .dev_add time
Thread-Index: AQHawMhZfAWsnj0CYEOKT7TiC0tv/7HtJHkAgAAF+AA=
Date: Mon, 8 Jul 2024 16:43:49 +0000
Message-ID: <5c5e0ad02e120fca7b2bd612e9f8bbc7818b9e7f.camel@nvidia.com>
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
	 <20240617-stage-vdpa-vq-precreate-v1-20-8c0483f0ca2a@nvidia.com>
	 <34ce285c-d87d-4116-adbc-a2d691cfa4c9@linux.dev>
In-Reply-To: <34ce285c-d87d-4116-adbc-a2d691cfa4c9@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (3.52.3-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|MW4PR12MB6731:EE_
x-ms-office365-filtering-correlation-id: 85b15900-44ed-49d6-9371-08dc9f6d24a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Nkcxa1psOWRlTVhMWjVVK0c0aVBrMFFLRWxwWHNlSG5tZlpjYnVDb3l5ejdw?=
 =?utf-8?B?WUxxK1FmTHE1ay94cFVlMlczRjNPOXpWc2hhWnZMVXRZLzdEYVNDQzBHOElt?=
 =?utf-8?B?ZThqeTB0ODNQd2x6T1Jsa2Y4Sitjb21rQXhvYTMwcjhMcnZXbGJ2dUdiRDBa?=
 =?utf-8?B?Qm9QdGM0cFRpS1JmclEwMEtYMWlBT0R5dDNORFlxcjc1ZVdwOHlVR1BhY2Q5?=
 =?utf-8?B?T2Vkd3I1YmJTTHdrNzhERHhEdlZTNFYrOVdnS1dVRUorQ1I2RE55S04vL1NL?=
 =?utf-8?B?RThYRUNBSUJvQWFmY2FYSDZDdW1hTEcybUVXWVFOTGg3dUpPazd2Z1Z3RFlu?=
 =?utf-8?B?bktpVm5tMm1pT0xoZXV4d0hRdWZpUzErUlBkbGRkWVlSaUwvaHhYSXNmdVBk?=
 =?utf-8?B?OHhiUE5NU0ZUS2ErdVJJbmNmSzh0VkxLRHA5T0toS24rNW42aS9EbHZxSlAx?=
 =?utf-8?B?Z0J3cGtyUkhxV1JQa2lMY29JZloyUkppcUdDTmZkaTBZNXN3LzZsK05tcXpk?=
 =?utf-8?B?bUhmbFRvQTNvSzdqT2VBRnk5V0xHa21xa3JPYW5zckxMaEx5U2VHeFc3QXcr?=
 =?utf-8?B?MnZMVGdxTHMyVnJ5ZDJhTGtNQndLWlZtUDlSaEZLcnlDaHBQc0M0dFZTZjhX?=
 =?utf-8?B?b2w2QnEyVk85VTZGcWNQQXV3dW9iTHJNS2R5cXdoVkkxVkxyRFBlaVNnZnRF?=
 =?utf-8?B?NkZIRXBBL0dMZ0gwWGJUSkVSYkh3MDFtN3BMZkdXc0tKalNNT1ZZdUdOdW0z?=
 =?utf-8?B?RjY5VFhMMUJFSzBWaWZxaW0vMFBwSk5CaWlSdVhONHBhbjRlTmEwVUpCeGkx?=
 =?utf-8?B?TFVrVlFFODBSNDNJV1lmaWtwR01vSmNoODJJV2g1VE9JQ3J0M090M0c1Nm5m?=
 =?utf-8?B?R1pXd2VFcFMyOTdEVWhRQzNtRFV1M0VzZkt0aUFTZW1LT3JER3kwenV4S0hV?=
 =?utf-8?B?VVBNZFBtdzNqUFNXVFdqekZZTmxTd2NVNU1sbGJGcS9PNHVLajVIQ2pBd29j?=
 =?utf-8?B?MG51dXdBTHZhdkdNT3orcG9HdEsrcENlZHJqcEsvUDN0WldTK3hheHVielJW?=
 =?utf-8?B?MXp5T2NUK3VVTHM3MjVyalptcDVjdnB4WXBJc2k5Tm1yWUhXQmdaSlhOd0dX?=
 =?utf-8?B?b0Q0L0dUaTAwbDdvMkF5YzYrdTlQZUhSd3V3MmtIYkdvVXJ1VzVQMHhuWUVr?=
 =?utf-8?B?aHArdjdIVzVRUDhjc2lwa3l1N0VTQURNeWpleklpS1QyOGUwK3EzeXVxNWlv?=
 =?utf-8?B?M3k0d1AxblJKWHlNVW4zd0FSUWxQWis1QUozNE11SFNuZ0hFdi9RTkVSUU1C?=
 =?utf-8?B?Zm9WVUxmWmVEdTRLZnlaOWhtZ2VEblBQZlVrc05KUzFWTTJ2LzFMa0JTMmNR?=
 =?utf-8?B?N3JkWkRpVEJ6SjdvLzNFMUxjNU13WjV6eFNRUDMxaDJzQ0NoQ1d6NmpZbzh4?=
 =?utf-8?B?LzdHMGxvSVMvU0w0S3BqQkNqWC9kS2ZsZEdneVA3ZkRTQk5oZDVWRU1FYWl0?=
 =?utf-8?B?M1hxVHVnMDZiVXQ0WGVIcGVZaFdtdmNseXRJYU1vSllnenVDR3BQcmkwajdZ?=
 =?utf-8?B?QkgxR0o3NVZWcytsV0RuZUlTQUFsWGpLZGptYWlIL3RyNmE5YUloRzBOOTJR?=
 =?utf-8?B?ZkV3MnEzVWdCakJ1SlRkblZ5bXFBcDVKbUlvNDZVY3JJU3F2Z0RQTTArYVMx?=
 =?utf-8?B?YjFmQnZ4Mno4VVZkS3BUb1F4Y2RBL3hZeDVOeGpoRnd2U3pRWVpROXVYUmtU?=
 =?utf-8?B?cnUwd29yREJDSEFRdk5tcG5kVUU4SlFpbGVNUUoya3pnbmJuaU9waTdzcWRC?=
 =?utf-8?B?ajFCeWVRR3pUd2dCZ2dLa0lXenA2Q0ZoRDNGOTlRUkZiTUlqalVCVWZPcmJI?=
 =?utf-8?B?MnJkQTl6NUNieG9SUDF3NDNURitxMzZ2MWZVV3NlQmNVdkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bENNODB2TlJUV3RZZUZUR25FM2xZUU1lTnJoMnk4d2pqRk8wczdCbkpEakQr?=
 =?utf-8?B?a0NxVVRFZTVIbThOWkZZQ2Z6bTM3ZVlGVWlNek5OS0J6cUl4K3JKbWRSbmM2?=
 =?utf-8?B?ZVV6WXZYY0g2QStxZkJWWkFOOU1tMFRpT1Z0bGNZbG1MbjV0T1JseWx2djJj?=
 =?utf-8?B?cjhDTm1VWHlRcTNkQ3V3OG9zVnR5RGhmb0pZODEzTVp3UGxCQkltL2oxL2tB?=
 =?utf-8?B?Y0YxT2w5eXpXQzF5dXJtOGFtQVZRSmNUWUE5VlU2cTZML3BnMUVqOVhWdWRt?=
 =?utf-8?B?Nm5OQnl1YS9TeEhHeTBsMDNWWkE0WXZ6K1EvaDdXYk90SGRTb1RVZmIwWGtk?=
 =?utf-8?B?eWUzdWkyQVJwWTdiRjFDWHM3bFIvZFQ3QUNmZVpaU0dDQkVVN1lsRk9wbUZD?=
 =?utf-8?B?cWtnMFRSOHkvS1lVOWJReCt1V2hCSVZPQ3pNSWM4TGd1eXp6c2JOd3F6eWV3?=
 =?utf-8?B?MWk2NHVkRm90cXc2MWk0RWt5WkZQWkxJd2g4OEhmNS9pdHJ4N1FvdmVMVlJF?=
 =?utf-8?B?Wk1ENGFOS0hBM1d1dDg2K3pOV1M2ZUhyenJTYyt6dDFBRjY5R1diRlpjenFM?=
 =?utf-8?B?d29DSjdIUnNwakpCeW5QdFYveWZqTUlqU0RVYkp1MlV3SVJiZEVtSlZhZm9Q?=
 =?utf-8?B?ZE1FbHlnYUFMeEZZTlVnNXBoZzlmNVAyTjJtZXh2Rkg3QVBEa3ZId3FtK01y?=
 =?utf-8?B?MTVvdnJvanNyMzB4YnVyU29MVVduNWtXVFJzZXN4V2xienBsdTNqVFkxYWh0?=
 =?utf-8?B?TVZRbURjNXVxOEd2WnAvTzBZdVk0aTltRlBxaGVrQ3lVQzIrVzlTU3l6UGc3?=
 =?utf-8?B?ZE1wQVNNMzlMWGZXZVJHcjlVR3dpYnZ1dklRSXJ1OUlTa2xFaURtNmpnT1R3?=
 =?utf-8?B?WXliYlpIakVMcjVVOGdmKzVqSUprYUJSbWVua0xUQkFEZDQ4KzVTYlVHRDZQ?=
 =?utf-8?B?VjFucDB5RURaSEF5VU15bVN6dmNqcnRsVGJsbUVHYnhaeHVBTlY3VEEvWkVW?=
 =?utf-8?B?VitQeUY3T1p6OG1zcjgxbDQ3d2FpQzdNM05VemVxekZtWVdMOWdMbmhtc25y?=
 =?utf-8?B?L0RTd2FzQUNaK211YVNSR3RtNytMRVRpajg5bFlrSDQ4b2JsQ0ozVGQ1TWZE?=
 =?utf-8?B?VGNHNlJtK21rVGExYzJ2NG82b0xQR0JCVTRUREJTOTZHWGR1SFltTThVOXE1?=
 =?utf-8?B?ODJldVllZUJJeUJpSjVycWdwT2JzYjNDZENMcmtPYWNqK2ozQ1JKWjZjcmV4?=
 =?utf-8?B?aUVDVWRnQkd6aWk3Y3lMeTEva1hCekdNVk9PdDZHdXVyU1ZwZE9aMXNFYnJ2?=
 =?utf-8?B?RlVURlFxRW5YdFJYSDdkdllqMmVtK0dUdE5jQWlPVVVXcVpXcnQwdlJPMHJk?=
 =?utf-8?B?UHgwTS9Nc2pQOXMxczlQQVFwa0REeFM5Tk1ncFR5anlDNTFEQUw4Z2FwRXgv?=
 =?utf-8?B?VWp6RTgwREh2NHJmaDNGWGZZbjd6WW9EYlpMeHI3S3J5Q3oybzJ5SGtkMzRL?=
 =?utf-8?B?dDRjcDloV25OR1JRWDlIVjhBT043Si9yUnk0K2g2ajF1VzQxeUNMczZMRFRw?=
 =?utf-8?B?dE9yMEVrYXlWLzBTY3IrbHVkRTN5L3c2aDF6dkgwQlQwenNwdEFyQVZ5SHpz?=
 =?utf-8?B?OWdXaGFMU2ZNbk5vbmlRVFNYSS9yYjJsMEFoNFR0dmkrMHFlZ08xWWY2azcx?=
 =?utf-8?B?RlM0YVI5YmxjTDFYd2dqcllRdnRkaGM4a1Q2WHdTenZtaEcydm9YVjVvOUFu?=
 =?utf-8?B?VGtYbzZaOGVHeEs5UldJeGhZUXdKL0o0Q0VVY042WWtHeVlVL29BbzY4b3JZ?=
 =?utf-8?B?RFA4MkR6MG8yL0RFeXZlVzdQMHlPdW4vdjUwa2Q3UlRjcUd6WnRMZFQ3QkM5?=
 =?utf-8?B?WGN2dFlvVjNwUnR1eEJ2Mm5DcGs4a1VrbFVNcGJxMTFlUzczNXNLMUZqUHNv?=
 =?utf-8?B?clJjeDYvOGx2dDlGbWJ1clk2Nm03QU1PdDl2NEZlMVZ5Zm5IT1JNKzZURGNh?=
 =?utf-8?B?M1lNYzdLcGt2R0xIZ2tSTjFYdW5PM0ZtanRrY0VRMURaOGdxWmp3T3VOOVh3?=
 =?utf-8?B?SHZ2TWFtODg0eTlYQjNVMGNjZGl0bXNnTllEQ0dSb0VIMWtFZHQzQTM5VjNX?=
 =?utf-8?B?Z2tYbHl3Y0RBdmF3S2luRmd5Wm1na0g5cXpsdTBHOFZ3eDBYOW82RGNBU1Qy?=
 =?utf-8?Q?Q0gEkPEFXaL0F9JFX9Qmz3Tq4JmFHa5VlA3RqTg4x61N?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87A85296F56E1C4492F72166F66AAF66@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b15900-44ed-49d6-9371-08dc9f6d24a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 16:43:49.4499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dbr+jzfmQBHubP1ApJWySPpYvG5/8KL8ClGTJgGu1xGtetYuPJ3yQ5UctpR+j8ZOI9SYlaCweaHzPR/s1aSoZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731

SGkgWmh1IFlhbmp1biwNCg0KT24gTW9uLCAyMDI0LTA3LTA4IGF0IDE4OjIyICswMjAwLCBaaHUg
WWFuanVuIHdyb3RlOg0KPiDlnKggMjAyNC82LzE3IDE3OjA3LCBEcmFnb3MgVGF0dWxlYSDlhpnp
gZM6DQo+ID4gQ3VycmVudGx5LCBoYXJkd2FyZSBWUXMgYXJlIGNyZWF0ZWQgcmlnaHQgd2hlbiB0
aGUgdmRwYSBkZXZpY2UgZ2V0cyBpbnRvDQo+ID4gRFJJVkVSX09LIHN0YXRlLiBUaGF0IGlzIGVh
c2llciBiZWNhdXNlIG1vc3Qgb2YgdGhlIFZRIHN0YXRlIGlzIGtub3duIGJ5DQo+ID4gdGhlbi4N
Cj4gPiANCj4gPiBUaGlzIHBhdGNoIHN3aXRjaGVzIHRvIGNyZWF0aW5nIGFsbCBWUXMgYW5kIHRo
ZWlyIGFzc29jaWF0ZWQgcmVzb3VyY2VzDQo+ID4gYXQgZGV2aWNlIGNyZWF0aW9uIHRpbWUuIFRo
ZSBtb3RpdmF0aW9uIGlzIHRvIHJlZHVjZSB0aGUgdmRwYSBkZXZpY2UNCj4gPiBsaXZlIG1pZ3Jh
dGlvbiBkb3dudGltZSBieSBtb3ZpbmcgdGhlIGV4cGVuc2l2ZSBvcGVyYXRpb24gb2YgY3JlYXRp
bmcNCj4gPiBhbGwgdGhlIGhhcmR3YXJlIFZRcyBhbmQgdGhlaXIgYXNzb2NpYXRlZCByZXNvdXJj
ZXMgb3V0IG9mIGRvd250aW1lIG9uDQo+ID4gdGhlIGRlc3RpbmF0aW9uIFZNLg0KPiANCj4gSGks
IERyYWdvcyBUYXR1bGVhDQo+IA0KPiAgRnJvbSB0aGUgYWJvdmUsIHdoZW4gYSBkZXZpY2UgaXMg
Y3JlYXRlZCwgYWxsIHRoZSBWUXMgYW5kIHRoZWlyIA0KPiBhc3NvY2lhdGVkIHJlc291cmNlcyBh
cmUgYWxzbyBjcmVhdGVkLg0KPiBJZiBWTSBsaXZlIG1pZ3JhdGlvbiBkb2VzIG5vdCBvY2N1ciwg
aG93IG11Y2ggcmVzb3VyY2VzIGFyZSB3YXN0ZWQ/DQo+IA0KPiBJIG1lYW4sIHRvIGFjaGlldmUg
YSBiZXR0ZXIgZG93bnRpbWUsIGhvdyBtdWNoIHJlc291cmNlIGFyZSB1c2VkPw0KPiANCldoZW4g
eW91IHVzZSB0aGUgdmRwYSBkZXZpY2UgdGhlcmUgYXJlIG5vIHJlc291cmNlcyB3YXN0ZWQuIFRo
ZSBIVyBWUXMgdGhhdCB3ZXJlDQpwcmV2aW91c2x5IGNyZWF0ZWQgYXQgVk0gYm9vdCAoZHVyaW5n
IERSSVZFUl9PSyBzdGF0ZSkgYXJlIG5vdyBjcmVhdGVkIGF0IHZkcGENCmRldmljZSBhZGQgdGlt
ZS4NCg0KVGhlIHRyYWRlLW9mZiBoZXJlIGlzIHRoYXQgaWYgeW91IGNvbmZpZ3VyZSBkaWZmZXJl
bnQgVlEgc2l6ZXMgdGhlbiB5b3Ugd2lsbCBwYXkNCnRoZSBwcmljZSBvZiByZS1jcmVhdGluZyB0
aGUgVlFzLg0KDQpUaGlzIGNvdWxkIGJlIG1pdGlnYXRlZCBieSBhZGRpbmcgYSBkZWZhdWx0IFZR
IHNpemUgcGFyYW1ldGVyIHRoYXQgaXMgc2V0YWJsZQ0KdmlhIHRoZSB2ZHBhIHRvb2wuIEJ1dCB0
aGlzIHBhcnQgaXMgbm90IGltcGxlbWVudGVkIGluIHRoaXMgc2VyaWVzLg0KDQpBaCwgb25lIG1v
cmUgdGhpbmcgdG8ga2VlcCBpbiBtaW5kOiB0aGUgTVNJWCBpbnRlcnJ1cHRzIHdpbGwgYmUgbm93
IGFsbG9jYXRlZCBhdA0KdmRwYSBkZXZpY2UgY3JlYXRpb24gdGltZSBpbnN0ZWFkIG9mIFZNIHN0
YXJ0dXAuDQoNCj4gIg0KPiBPbiBhIDY0IENQVSwgMjU2IEdCIFZNIHdpdGggMSB2RFBBIGRldmlj
ZSBvZiAxNiBWUXBzLCB0aGUgZnVsbCBWUQ0KPiByZXNvdXJjZSBjcmVhdGlvbiArIHJlc3VtZSB0
aW1lIHdhcyB+MzcwbXMuIE5vdyBpdCdzIGRvd24gdG8gNjAgbXMNCj4gKG9ubHkgVlEgY29uZmln
IGFuZCByZXN1bWUpLiBUaGUgbWVhc3VyZW1lbnRzIHdlcmUgZG9uZSBvbiBhIENvbm5lY3RYNkRY
DQo+IGJhc2VkIHZEUEEgZGV2aWNlLg0KPiAiDQo+ICBGcm9tIHRoZSBhYm92ZSwgdGhlIHBlcmZv
cm1hbmNlIGlzIGFtYXppbmcuDQo+IElmIHdlIGV4cGVjdCB0byB1c2UgaXQgaW4gdGhlIHByb2R1
Y3Rpb24gaG9zdHMsIGhvdyBtdWNoIHJlc291cmNlcyANCj4gc2hvdWxkIHdlIHByZXBhcmUgdG8g
YWNoaWV2ZSB0aGlzIGRvd250aW1lPw0KPiANCg0KWW91IGRvIG5lZWQgdG8gaGF2ZSB0aGUgbGF0
ZXN0IEZXICgyMi40MS4xMDAwKSB0byBiZSBhYmxlIHRvIGdldCB0aGUgZnVsbA0KYmVuZWZpdCBv
ZiB0aGUgb3B0aW1pemF0aW9uLg0KDQpUaGFua3MsDQpEcmFnb3MNCj4gWmh1IFlhbmp1bg0KPiAN
Cj4gPiANCj4gPiBUaGUgVlFzIGFyZSBub3cgY3JlYXRlZCBpbiBhIGJsYW5rIHN0YXRlLiBUaGUg
VlEgY29uZmlndXJhdGlvbiB3aWxsDQo+ID4gaGFwcGVuIGxhdGVyLCBvbiBEUklWRVJfT0suIFRo
ZW4gdGhlIGNvbmZpZ3VyYXRpb24gd2lsbCBiZSBhcHBsaWVkIHdoZW4NCj4gPiB0aGUgVlFzIGFy
ZSBtb3ZlZCB0byB0aGUgUmVhZHkgc3RhdGUuDQo+ID4gDQo+ID4gV2hlbiAuc2V0X3ZxX3JlYWR5
KCkgaXMgY2FsbGVkIG9uIGEgVlEgYmVmb3JlIERSSVZFUl9PSywgc3BlY2lhbCBjYXJlIGlzDQo+
ID4gbmVlZGVkOiBub3cgdGhhdCB0aGUgVlEgaXMgYWxyZWFkeSBjcmVhdGVkIGEgcmVzdW1lX3Zx
KCkgd2lsbCBiZQ0KPiA+IHRyaWdnZXJlZCB0b28gZWFybHkgd2hlbiBubyBtciBoYXMgYmVlbiBj
b25maWd1cmVkIHlldC4gU2tpcCBjYWxsaW5nDQo+ID4gcmVzdW1lX3ZxKCkgaW4gdGhpcyBjYXNl
LCBsZXQgaXQgYmUgaGFuZGxlZCBkdXJpbmcgRFJJVkVSX09LLg0KPiA+IA0KPiA+IEZvciB2aXJ0
aW8tdmRwYSwgdGhlIGRldmljZSBjb25maWd1cmF0aW9uIGlzIGRvbmUgZWFybGllciBkdXJpbmcN
Cj4gPiAudmRwYV9kZXZfYWRkKCkgYnkgdmRwYV9yZWdpc3Rlcl9kZXZpY2UoKS4gQXZvaWQgY2Fs
bGluZw0KPiA+IHNldHVwX3ZxX3Jlc291cmNlcygpIGEgc2Vjb25kIHRpbWUgaW4gdGhhdCBjYXNl
Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IERyYWdvcyBUYXR1bGVhIDxkdGF0dWxlYUBudmlk
aWEuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBDb3NtaW4gUmF0aXUgPGNyYXRpdUBudmlkaWEuY29t
Pg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgMzcg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5n
ZWQsIDMyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1
L25ldC9tbHg1X3ZuZXQuYw0KPiA+IGluZGV4IDI0OWI1YWZiZTM0YS4uYjI4MzZmZDNkMWRkIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYw0KPiA+IEBAIC0yNDQ0LDcgKzI0
NDQsNyBAQCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfc2V0X3ZxX3JlYWR5KHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRldiwgdTE2IGlkeCwgYm9vbCByZWFkeQ0KPiA+ICAgCW12cSA9ICZuZGV2LT52cXNb
aWR4XTsNCj4gPiAgIAlpZiAoIXJlYWR5KSB7DQo+ID4gICAJCXN1c3BlbmRfdnEobmRldiwgbXZx
KTsNCj4gPiAtCX0gZWxzZSB7DQo+ID4gKwl9IGVsc2UgaWYgKG12ZGV2LT5zdGF0dXMgJiBWSVJU
SU9fQ09ORklHX1NfRFJJVkVSX09LKSB7DQo+ID4gICAJCWlmIChyZXN1bWVfdnEobmRldiwgbXZx
KSkNCj4gPiAgIAkJCXJlYWR5ID0gZmFsc2U7DQo+ID4gICAJfQ0KPiA+IEBAIC0zMDc4LDEwICsz
MDc4LDE4IEBAIHN0YXRpYyB2b2lkIG1seDVfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRldiwgdTggc3RhdHVzKQ0KPiA+ICAgCQkJCWdvdG8gZXJyX3NldHVwOw0KPiA+ICAg
CQkJfQ0KPiA+ICAgCQkJcmVnaXN0ZXJfbGlua19ub3RpZmllcihuZGV2KTsNCj4gPiAtCQkJZXJy
ID0gc2V0dXBfdnFfcmVzb3VyY2VzKG5kZXYsIHRydWUpOw0KPiA+IC0JCQlpZiAoZXJyKSB7DQo+
ID4gLQkJCQltbHg1X3ZkcGFfd2FybihtdmRldiwgImZhaWxlZCB0byBzZXR1cCBkcml2ZXJcbiIp
Ow0KPiA+IC0JCQkJZ290byBlcnJfZHJpdmVyOw0KPiA+ICsJCQlpZiAobmRldi0+c2V0dXApIHsN
Cj4gPiArCQkJCWVyciA9IHJlc3VtZV92cXMobmRldik7DQo+ID4gKwkJCQlpZiAoZXJyKSB7DQo+
ID4gKwkJCQkJbWx4NV92ZHBhX3dhcm4obXZkZXYsICJmYWlsZWQgdG8gcmVzdW1lIFZRc1xuIik7
DQo+ID4gKwkJCQkJZ290byBlcnJfZHJpdmVyOw0KPiA+ICsJCQkJfQ0KPiA+ICsJCQl9IGVsc2Ug
ew0KPiA+ICsJCQkJZXJyID0gc2V0dXBfdnFfcmVzb3VyY2VzKG5kZXYsIHRydWUpOw0KPiA+ICsJ
CQkJaWYgKGVycikgew0KPiA+ICsJCQkJCW1seDVfdmRwYV93YXJuKG12ZGV2LCAiZmFpbGVkIHRv
IHNldHVwIGRyaXZlclxuIik7DQo+ID4gKwkJCQkJZ290byBlcnJfZHJpdmVyOw0KPiA+ICsJCQkJ
fQ0KPiA+ICAgCQkJfQ0KPiA+ICAgCQl9IGVsc2Ugew0KPiA+ICAgCQkJbWx4NV92ZHBhX3dhcm4o
bXZkZXYsICJkaWQgbm90IGV4cGVjdCBEUklWRVJfT0sgdG8gYmUgY2xlYXJlZFxuIik7DQo+ID4g
QEAgLTMxNDIsNiArMzE1MCw3IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX2NvbXBhdF9yZXNldChz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUzMiBmbGFncykNCj4gPiAgIAkJaWYgKG1seDVfdmRw
YV9jcmVhdGVfZG1hX21yKG12ZGV2KSkNCj4gPiAgIAkJCW1seDVfdmRwYV93YXJuKG12ZGV2LCAi
Y3JlYXRlIE1SIGZhaWxlZFxuIik7DQo+ID4gICAJfQ0KPiA+ICsJc2V0dXBfdnFfcmVzb3VyY2Vz
KG5kZXYsIGZhbHNlKTsNCj4gPiAgIAl1cF93cml0ZSgmbmRldi0+cmVzbG9jayk7DQo+ID4gICAN
Cj4gPiAgIAlyZXR1cm4gMDsNCj4gPiBAQCAtMzgzNiw4ICszODQ1LDIxIEBAIHN0YXRpYyBpbnQg
bWx4NV92ZHBhX2Rldl9hZGQoc3RydWN0IHZkcGFfbWdtdF9kZXYgKnZfbWRldiwgY29uc3QgY2hh
ciAqbmFtZSwNCj4gPiAgIAkJZ290byBlcnJfcmVnOw0KPiA+ICAgDQo+ID4gICAJbWd0ZGV2LT5u
ZGV2ID0gbmRldjsNCj4gPiArDQo+ID4gKwkvKiBGb3IgdmlydGlvLXZkcGEsIHRoZSBkZXZpY2Ug
d2FzIHNldCB1cCBkdXJpbmcgZGV2aWNlIHJlZ2lzdGVyLiAqLw0KPiA+ICsJaWYgKG5kZXYtPnNl
dHVwKQ0KPiA+ICsJCXJldHVybiAwOw0KPiA+ICsNCj4gPiArCWRvd25fd3JpdGUoJm5kZXYtPnJl
c2xvY2spOw0KPiA+ICsJZXJyID0gc2V0dXBfdnFfcmVzb3VyY2VzKG5kZXYsIGZhbHNlKTsNCj4g
PiArCXVwX3dyaXRlKCZuZGV2LT5yZXNsb2NrKTsNCj4gPiArCWlmIChlcnIpDQo+ID4gKwkJZ290
byBlcnJfc2V0dXBfdnFfcmVzOw0KPiA+ICsNCj4gPiAgIAlyZXR1cm4gMDsNCj4gPiAgIA0KPiA+
ICtlcnJfc2V0dXBfdnFfcmVzOg0KPiA+ICsJX3ZkcGFfdW5yZWdpc3Rlcl9kZXZpY2UoJm12ZGV2
LT52ZGV2KTsNCj4gPiAgIGVycl9yZWc6DQo+ID4gICAJZGVzdHJveV93b3JrcXVldWUobXZkZXYt
PndxKTsNCj4gPiAgIGVycl9yZXMyOg0KPiA+IEBAIC0zODYzLDYgKzM4ODUsMTEgQEAgc3RhdGlj
IHZvaWQgbWx4NV92ZHBhX2Rldl9kZWwoc3RydWN0IHZkcGFfbWdtdF9kZXYgKnZfbWRldiwgc3Ry
dWN0IHZkcGFfZGV2aWNlICoNCj4gPiAgIA0KPiA+ICAgCXVucmVnaXN0ZXJfbGlua19ub3RpZmll
cihuZGV2KTsNCj4gPiAgIAlfdmRwYV91bnJlZ2lzdGVyX2RldmljZShkZXYpOw0KPiA+ICsNCj4g
PiArCWRvd25fd3JpdGUoJm5kZXYtPnJlc2xvY2spOw0KPiA+ICsJdGVhcmRvd25fdnFfcmVzb3Vy
Y2VzKG5kZXYpOw0KPiA+ICsJdXBfd3JpdGUoJm5kZXYtPnJlc2xvY2spOw0KPiA+ICsNCj4gPiAg
IAl3cSA9IG12ZGV2LT53cTsNCj4gPiAgIAltdmRldi0+d3EgPSBOVUxMOw0KPiA+ICAgCWRlc3Ry
b3lfd29ya3F1ZXVlKHdxKTsNCj4gPiANCj4gDQoNCg==

