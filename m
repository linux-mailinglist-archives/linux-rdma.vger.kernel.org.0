Return-Path: <linux-rdma+bounces-3495-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94706917C73
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 11:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94561C22875
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 09:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ECB16C438;
	Wed, 26 Jun 2024 09:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VmFOEpNw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE112166300;
	Wed, 26 Jun 2024 09:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719394100; cv=fail; b=L9hScqMDdJ5YAfUKUwYk7Dp5yA3y072K81D8ZqVsLDQ0uluRBGAQnLozEuQHm64ycStRkWA9Z3L/1nZUH3LPZssPbb17ds5anluP8sf9Nigx309RIhyFR4smA37O56edWljohOrh57uU+rnC2ve9JXugUkxbhDjDipcP6oAoUX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719394100; c=relaxed/simple;
	bh=q4ASYS4319bk75L9CxNVYIlOQEZyQmDzev03MAmveXM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VXTSRY3ke2lPz56ervZLWxzsuwJLdpzaht2Q8RJscy4LTdCAz//1NxFpd6/YUlAPjeaWQaJy+ubqWY+8FsLwqYNHwRoVWg0ulffDALnMfiNJ6OtMD1gMigIuPi4PnZANlquAy7o3Rg+1aJ8Hu42/xV8zU5YqEf54flTpjP9N3aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VmFOEpNw; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLsyQx2tUM7zkeYm/NT5xWRqXZlcJvDaZpvqtmrsdIOIA6vul2MUtPkPCo8pFMXMqjphxgu/t1nJgYjryTyaSZN40fssgrVRHykH7T+oyWPXHhlHW1YiU1JGCpnXX3OgUjn0R16VQAr4lS3/EOP7PsaHENfE8LVLsj+eHpxVL78WhQNsJ8EysjeSH6V9yjxHSGtJQqxTgOk+dtb/NoBHYjNELhB3nHqifClvKKsltvD3qdIrmOr+1uhKm/Q61Sln2KuFN9/yR8ui52/2fUYs36cCCvBICP5XjyoI5Q1aqwULScFPtjkxIFylnRqjfaWisDCBtvxLTkLc55Xh18RN+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4ASYS4319bk75L9CxNVYIlOQEZyQmDzev03MAmveXM=;
 b=PJlkTMMIkEKc/iKBmASuLI/YROpU4eeVJVAsJ0QXiATSHkhCMQnWyml8VXg32WIIi0cGlkUtMNfxcITeNR89JsKMSgJobI+ScavTQmKidEYp1dXSUHl6l/M7urc6XA6XtDagbGYg/oHL7qespS6i2rETpz/qXfYIBpQAPyuhaXl7p4zyZdZ5Rh/NBWPLwbzDjkT3vPLvAD18tPoUdtgNjZCASDviYMGF9YlL9pp+N4d/Of8RhxcflqlK3R4VoHc0wLsoihOq7Rwj/oDCICRMkI9PBLeIH8PFRrOg4APssS4qqN0qDMlPuYUpEVxsEK5vJls6RYvVjl/SAEVwD2jRrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4ASYS4319bk75L9CxNVYIlOQEZyQmDzev03MAmveXM=;
 b=VmFOEpNw6PlPk8UBqyoHQ1e6Il7pUJAmvbT1KWAw/7BLTYmv1kFTufFw4Nt3oUXsfLDqczxfR+76Tz8H3aoabGp8ZoFk0XaJZn7GLRsUPRfjEy9qaF1thwBwv8YgpEukH3HDGhDX0g0qep82lVJXD/sONTAsUJOzIu0+jl3turl0rYhtEmxyFZQJvT9a3b+bp/kiZSfAK1vDn7gRTE3XlFw8EwMmqxHMxdRx29o1+Uhm0kkqQ2fz3jUsmSv2EviNen/QoupK3j4h4gmkGmGhBNg6N2r7Om5ytCWbXa3C+zYENvpa7UptmGDM9FTLvhIfwQP6Lhx8n4B8ZJxF0/HOxA==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 09:28:15 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1%6]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 09:28:15 +0000
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
Subject: Re: [PATCH vhost 18/23] vdpa/mlx5: Forward error in suspend/resume
 device
Thread-Topic: [PATCH vhost 18/23] vdpa/mlx5: Forward error in suspend/resume
 device
Thread-Index: AQHawMhV87eT65EXVkmE0vxVyNm9IbHVPNYAgASX7wA=
Date: Wed, 26 Jun 2024 09:28:15 +0000
Message-ID: <bd16246e41fba73e84ceeec5dcc33fcf7c224c5c.camel@nvidia.com>
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
	 <20240617-stage-vdpa-vq-precreate-v1-18-8c0483f0ca2a@nvidia.com>
	 <aea8bc89-ca09-45d7-82ba-05c1fad8bebd@linux.dev>
In-Reply-To: <aea8bc89-ca09-45d7-82ba-05c1fad8bebd@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.2 (3.52.2-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|MN2PR12MB4144:EE_
x-ms-office365-filtering-correlation-id: c1e69545-4349-4ed2-25ca-08dc95c24ec0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230038|376012|7416012|366014|1800799022|38070700016;
x-microsoft-antispam-message-info:
 =?utf-8?B?UVJocEZ3UDBZcWZHZEJ0aDdvdTBxbkVLN3hKeUFQQmdQcXVBMk5Fb21mY25K?=
 =?utf-8?B?VDAwenAxNXBDR3R1cjVidy8wRDBtTTRqVjUxMkJKRitOeGZ2eUpXTTVkazJX?=
 =?utf-8?B?TVk0eHkxa1ZsTXAwY0VhYVRNN3B3RVNWdFdQdjZLdlRoUG9Vd3RrWUNMUU1F?=
 =?utf-8?B?SkJleEJtQlZpeGQ5L1pZOWp2WHhCWHVsZzhheTVPQnhSOHlxMzBVUDh0Ymxl?=
 =?utf-8?B?eXcyWWdMUVAvUFFraFVobjNhdEdtd3ZZdHhXaVNGSFpYKy9PK2JiY2s1T25O?=
 =?utf-8?B?TVZkMS9Jb2dSOGVDZDFTbGV5dk1TS0dqQ0tEakhXaldDNEMySWZES2s3aWFn?=
 =?utf-8?B?NlFFSDF2b3c1RjFabFlGR3BDQXBOMmlNa3llYnZiVTk5VlNRNmVUeHc5OUNo?=
 =?utf-8?B?TWk0TU5OeDVQeEVXbmlHaGpqMkp6N2o5QjBiZ0FxWk05cVRkaTlQajBITGVY?=
 =?utf-8?B?L0FsVlNLU05Yb1Q2ajdVbXBlYmVDc2ZaUXVRbjAyTGduaEwyYldQRWpOOW51?=
 =?utf-8?B?OFZIc1k1UXg2Nnk1aEdaVmh6Myt6WGhDc1E0SlJGbnJhdFc4dW5QK1p3KytB?=
 =?utf-8?B?YllqZzl1d3dLOWcyWHpFcHJOUzZFdkwxaGN2NkljbG9KYyt0R2tkb2Q3dk5u?=
 =?utf-8?B?TEgxOVBRRjZwakxlMlFsVDB0TVNFckpiZzIvem1ZTWlWTzQrV1J6RldWV0tV?=
 =?utf-8?B?bDhFWXI3b2dxSGphZXNxd2FxdFREOUZxTkorRzdyamVkREEyZ0FhajdQejNu?=
 =?utf-8?B?MXpYdGp1NWN3aS9ucnE2STYxOE02cm5kbHB3VytLbWhGajBlbkVVTS9uNnJJ?=
 =?utf-8?B?aEpEcURUbVN3MmtIV0ZqWXFtU0FQVDNibFZZQno4OTFmMHNHbWMyaVFVSllm?=
 =?utf-8?B?NFVZbTl4QSs3cWJXanowZHk4QWpQU1k1MnN2c0tMZVVwVjhGRXJtdGZPT0p6?=
 =?utf-8?B?WW9PVlhBbFhkbVJkTHRoNDBIbjM0NzZqMitUSHdNMU5rS1JmOU5IL3dNYi9H?=
 =?utf-8?B?ZWFTVnZSaWNMS3JjaWR2NTNYeGRBUDBUbTZzVUN0RHE1V0habmYyY1NLUW0w?=
 =?utf-8?B?ZE5SWXBGT0ZTcStEQ0hGaUs3eGJRM3pWUGhwRUtVZXlQTVJFdUpQaUFaZDZF?=
 =?utf-8?B?K01MZkpKS3dMSkE4ZHZaVEppYm0rQXYwOFdscFIveVIrWlovcHRsblhwRzdD?=
 =?utf-8?B?ZGtJMkliT2x4Sno2dnN4Q0xjb2x3Um5LQTdVbnVIdG5OSWU4dWh5ZmNWUyt0?=
 =?utf-8?B?UFBQMEU3Y0U0N1BWOGlyMHp3RldjSUk2aEJFV1ZEVTUzTGhYTXFGQVFaVmRR?=
 =?utf-8?B?QVg3YldIY2krM01pV3FocFNzMGVKM2lCSXJUWUxDQU9WRHdYTEhkRzhRWlhC?=
 =?utf-8?B?ZWhrRW5SalJaUzQyM0hRUUd3bitCRGZCQWtNWjJXVjZpT29LQWtDeUw5cEMr?=
 =?utf-8?B?MGxXT2RSWnRNSTUwdU5YbTVYYXBBZWgyZkgxV21yd0orVVJySmVBa2VTNkQ2?=
 =?utf-8?B?d2MwRWxYTlRndUhndUs2eTZCcHFNZEpMZDY1UG1lWFRaRTFFY0tac1dia0FZ?=
 =?utf-8?B?bXRESDBtcjhLc096TE1GTWRxYndidkZURGhnbW5SRjU0Unh6SFBnMldpeVJL?=
 =?utf-8?B?UjM3U1NkNGdLd2VPUUdHMVJ5M3dBYVVZc2RIa3lucHJvSEtFVGcvaDFFbTY1?=
 =?utf-8?B?MEZFdERudkNtZmtCektya1NTeGI1RDhHSUVDQjRkcDRSS0d4Sysvd1BSR3Bh?=
 =?utf-8?B?K0Y1Tk4xU3hpTnhYM1dyL1NrbVpoeVMxbnhPL3dnT0hQLzY5SVM1VElnMWl6?=
 =?utf-8?B?Z2NZZlh2VmhtWHJHOTE3VG9CaXNEMEVCaHVVZDlRVDJlYUlZcTB6L1dBR2dz?=
 =?utf-8?B?azlVcFk0QVZaSlVuQ0t3ZHFzU3hGK203WTJEdXZqZTd1ZUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(376012)(7416012)(366014)(1800799022)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1R4V0VIN25na3QxbU5xUm5yV2hURU1zTXdVME9tM2lEc010bEprUGF5OVJG?=
 =?utf-8?B?b1NGZGdYclhHS3hFNkxoODFTTVhFRjVsQ2NNZlQ5VjRGdUl2V1MvU2hJN3JG?=
 =?utf-8?B?MGNEbHVBV21ucExVYXd6ZENOMVdYREVMamE4aTljeVhqeEcrUDlPSFZ6T0hz?=
 =?utf-8?B?eWRwdmlNUWYxRm5TU3FWQWpZaldacCtZU1BOT1NQRkFFU1poSURTVkhTS2Y3?=
 =?utf-8?B?aW9CdlBzY3NDbHpSWGNzYXR6Uy8vbVY4QnY2b3VrODVEeFVicFRtbmpFVTRl?=
 =?utf-8?B?UVNxUUtTUGJDK3BUaHBubVRUWGtoVENRbi9tSWZuT3E0MFl6YzJ4UnZFRkVP?=
 =?utf-8?B?RmdJSHNNWDA0aFo4WmI5aWFnYiswbFdsRmU5dmNaUE5TS1ViY2huZCs3WWZM?=
 =?utf-8?B?TXlnajY2UWZSb0Raa0xvVnVPT3VIeThxSG9HRjRsazdQN1BJZXIveFlVUVN3?=
 =?utf-8?B?NkNqZll1RDhRWVF3K2FVQ0FOVkZ0NTBEVDl3UjkvVzBaNjJuUXRnbDZaRlVF?=
 =?utf-8?B?UFBwSEQ0cmVMaEd3aWpqY1RlbkZpODNIQ09DTEwrVlROdmxZTDViWWp6NW43?=
 =?utf-8?B?V0wxTFgxSENIbE9DT1liN3BEcFo3RVk2NWtjMmlTTm40dkhSWWo1MS9qSXJw?=
 =?utf-8?B?T3BYVThKQ09jck5xSHRtVW1hT2g4Nk1iN043TmFDbVFxT1hUbG50bFRmZDlt?=
 =?utf-8?B?SUdCczJnWEN3MVVkbXhGbmtZYmtIMFJpVHhrS1ovbDM5Yyt3bTJ3anVabjFH?=
 =?utf-8?B?TlR0OTk5Y3duQndZYWZ5YklQQzJ1YTFMcmFFUEgwS3FOM0RjZ0ZMWXZvamI1?=
 =?utf-8?B?TnpiL093c0sxL2o4Y0pUY09BQnhUUE96c3lValZpdVNBejcvSVV3WXVmT0dj?=
 =?utf-8?B?bTlKbE9FY2w5TDlxQ1pXYTkyZWRLWlVFdnNiNFoxYkNxOW1vZUNScEIyNWxz?=
 =?utf-8?B?QlcwR0pKeDlmbDhWbHd2MWR4YmlieWVFSlozNmtOQ2R0UGdLVEhoQjc1UWNZ?=
 =?utf-8?B?Vk5hV1YzaEtKQnhvREZZR0hwQ2tJOGtXNXZSL0ZNaW1LTERCdFprV2ZLQTMr?=
 =?utf-8?B?VWNhMEtFQ1RFUGdPS2JRWWVGZW5uMVZVUEpPOGx0VUdlL1ZpVFFxMDBtNjRY?=
 =?utf-8?B?S1NNbEJnRnJGUDM0YmdXOVFCc3o1QytMYVJNU1FCZjlxelJhclk3SWRaS00y?=
 =?utf-8?B?Q044U0J5ZW5JVjJKRWNvRHVsUGIyMDFSQ3NwNTNRT3JKY1U3QVVEaG9KYUx5?=
 =?utf-8?B?cnVzdEVZcUNJYmh4MmRQMzM5SGFYNEd2QlBSRTU1REpMQzJvSSt3QnQrRlV2?=
 =?utf-8?B?Q3JNRFAxVy90U2FYUTdKRmhNT1crcmN0YW5YeitoQ2Roak5OSndUalRRbG9t?=
 =?utf-8?B?a0VRUHBPS2VhZ1NpQ0crZWJVckhyWUo5d0JjQWRCMFphMFNOd0tPWmNzclNV?=
 =?utf-8?B?aGhwaWNUMzd2SXFUcXJ6dG9CNUIyK1Z0ZkpsdmFaaUliTzVLRlhXSlJsUUw0?=
 =?utf-8?B?dHRyVU9sWjBGdUZtZHdNY3JPR1grYk0rV1RueEczaUxacVRkSnM1WkdxY1Bx?=
 =?utf-8?B?RDNUWHducG05NDdsdk5lTFg3czBRaEg1cVZHZS9Ncy9CSTRzQ1FCU3MrODNR?=
 =?utf-8?B?RzlYdDFrMUprVmZ6TjVqV0d6VUNBUjNnRUtoUWRJeGRwMmtzODRJbHdBNWsy?=
 =?utf-8?B?bnBoZDdoejE0dU1WaWtiYmlSSmc3NUh4TDBwSnJxOWVqY3FBTHNoazM0Kzlw?=
 =?utf-8?B?S0hlRkd3WW5GeU12WGNqamNxakV2SGZtM2hOd0ZzWGZqODAxbVFDclRtSmpO?=
 =?utf-8?B?cklKOFFnYmZnWFRTTjdVSG5zclI0VnVLb2draGJjQlJqMzhtaVVYTXZWQk1o?=
 =?utf-8?B?ZTdNc2hYSDdXUlQ2aFJFU2YxRThFRG9heTZ4SGRHS0p3NjdPMVFlRjBINTNT?=
 =?utf-8?B?T3dFK0cvQ0w1ZEdtV3JhdzFOUnF2UHZ2YzZwV3VlKzBQcXhlbC8vZjJXeDdG?=
 =?utf-8?B?NDMzZUNZV1kvMFMrdm9OVTloTnFYVzNWby9vdmlwR3ZIL1FqYVNsdG1VZmhn?=
 =?utf-8?B?ZlFRYjl2SElzNzBSaTdRaWVoaU9PWmFHTHBmeUpLWVBiZXFnL1NObWdKZnlB?=
 =?utf-8?B?RFZaaGpMZHFTS1FNMVJVaTdMeExtSjF3b01Rc1Z5NFFVUTJKR2d6UEh4dTh6?=
 =?utf-8?Q?uuDGN6XR+BNbxqdnJLCdRpnhkX9s/mf7fGLO2zSIM2gu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD7E1E4B293F454C86CD57E4D88744EC@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e69545-4349-4ed2-25ca-08dc95c24ec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 09:28:15.6730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e8wigktcji8ueF89l54QqcdyjUOVM3KL9ikwhD5VsyRr32vRlas4AMrJ41GM/h54uAY499t2eEL8mi2jBUzdzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144

T24gU3VuLCAyMDI0LTA2LTIzIGF0IDE5OjE5ICswODAwLCBaaHUgWWFuanVuIHdyb3RlOg0KPiDl
nKggMjAyNC82LzE3IDIzOjA3LCBEcmFnb3MgVGF0dWxlYSDlhpnpgZM6DQo+ID4gU3RhcnQgdXNp
bmcgdGhlIHN1c3BlbmQvcmVzdW1lX3ZxKCkgZXJyb3IgcmV0dXJuIGNvZGVzIHByZXZpb3VzbHkg
YWRkZWQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVh
QG52aWRpYS5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IENvc21pbiBSYXRpdSA8Y3JhdGl1QG52aWRp
YS5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMg
fCAxMiArKysrKysrKy0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1
L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYw0KPiA+
IGluZGV4IGY1ZDViMjVjZGIwMS4uMGUxYzFiN2ZmMjk3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1
L25ldC9tbHg1X3ZuZXQuYw0KPiA+IEBAIC0zNDM2LDIyICszNDM2LDI1IEBAIHN0YXRpYyBpbnQg
bWx4NV92ZHBhX3N1c3BlbmQoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KQ0KPiA+ICAgew0KPiA+
ICAgCXN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiA9IHRvX212ZGV2KHZkZXYpOw0KPiA+ICAg
CXN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2ID0gdG9fbWx4NV92ZHBhX25kZXYobXZkZXYpOw0K
PiA+ICsJaW50IGVycjsNCj4gDQo+IFJldmVyc2UgQ2hyaXN0bWFzIFRyZWU/DQpXb3VsZCBoYXZl
IGZpeGVkIHRoZSBjb2RlIGlmIGl0IHdvdWxkIGhhdmUgYmVlbiBwYXJ0IG9mIHRoZSBwYXRjaC4g
QnV0IGl0IGlzbid0Lg0KDQo+IA0KPiBSZXZpZXdlZC1ieTogWmh1IFlhbmp1biA8eWFuanVuLnpo
dUBsaW51eC5kZXY+DQo+IA0KVGhhbmtzIQ0KDQo+IFpodSBZYW5qdW4NCj4gPiAgIA0KPiA+ICAg
CW1seDVfdmRwYV9pbmZvKG12ZGV2LCAic3VzcGVuZGluZyBkZXZpY2VcbiIpOw0KPiA+ICAgDQo+
ID4gICAJZG93bl93cml0ZSgmbmRldi0+cmVzbG9jayk7DQo+ID4gICAJdW5yZWdpc3Rlcl9saW5r
X25vdGlmaWVyKG5kZXYpOw0KPiA+IC0Jc3VzcGVuZF92cXMobmRldik7DQo+ID4gKwllcnIgPSBz
dXNwZW5kX3ZxcyhuZGV2KTsNCj4gPiAgIAltbHg1X3ZkcGFfY3ZxX3N1c3BlbmQobXZkZXYpOw0K
PiA+ICAgCW12ZGV2LT5zdXNwZW5kZWQgPSB0cnVlOw0KPiA+ICAgCXVwX3dyaXRlKCZuZGV2LT5y
ZXNsb2NrKTsNCj4gPiAtCXJldHVybiAwOw0KPiA+ICsNCj4gPiArCXJldHVybiBlcnI7DQo+ID4g
ICB9DQo+ID4gICANCj4gPiAgIHN0YXRpYyBpbnQgbWx4NV92ZHBhX3Jlc3VtZShzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkZXYpDQo+ID4gICB7DQo+ID4gICAJc3RydWN0IG1seDVfdmRwYV9kZXYgKm12
ZGV2ID0gdG9fbXZkZXYodmRldik7DQo+ID4gICAJc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXY7
DQo+ID4gKwlpbnQgZXJyOw0KPiA+ICAgDQo+ID4gICAJbmRldiA9IHRvX21seDVfdmRwYV9uZGV2
KG12ZGV2KTsNCj4gPiAgIA0KPiA+IEBAIC0zNDU5LDEwICszNDYyLDExIEBAIHN0YXRpYyBpbnQg
bWx4NV92ZHBhX3Jlc3VtZShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpDQo+ID4gICANCj4gPiAg
IAlkb3duX3dyaXRlKCZuZGV2LT5yZXNsb2NrKTsNCj4gPiAgIAltdmRldi0+c3VzcGVuZGVkID0g
ZmFsc2U7DQo+ID4gLQlyZXN1bWVfdnFzKG5kZXYpOw0KPiA+ICsJZXJyID0gcmVzdW1lX3Zxcyhu
ZGV2KTsNCj4gPiAgIAlyZWdpc3Rlcl9saW5rX25vdGlmaWVyKG5kZXYpOw0KPiA+ICAgCXVwX3dy
aXRlKCZuZGV2LT5yZXNsb2NrKTsNCj4gPiAtCXJldHVybiAwOw0KPiA+ICsNCj4gPiArCXJldHVy
biBlcnI7DQo+ID4gICB9DQo+ID4gICANCj4gPiAgIHN0YXRpYyBpbnQgbWx4NV9zZXRfZ3JvdXBf
YXNpZChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUzMiBncm91cCwNCj4gPiANCj4gDQoNCg==

