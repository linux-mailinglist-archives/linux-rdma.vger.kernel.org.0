Return-Path: <linux-rdma+bounces-5167-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073EB98ACB7
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Sep 2024 21:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 082B4B2466C
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Sep 2024 19:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC7019992C;
	Mon, 30 Sep 2024 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NyGCWsoy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA0919925A
	for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2024 19:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724063; cv=fail; b=OegJPb9QDVWfUtmqP7HppJOvc0CHX1vhke20SwOrIdwtCiW9vS7CMCeveH85mD/jir+VN1rdMLfUmugqbYRhx6jaKnnz4mgAv/YchTmiqOJJiN1WR8yvMb0HRwdQX+sMf0fPL3bbpaYh3fkTI0CNWnask6MlqN3uRLgc+mUbqO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724063; c=relaxed/simple;
	bh=YhNb31m4GU1OPFV5+/Zw7AXS668jWYM+KBaQI2OU+LI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h1F7mUMFmvyokaOWOs6Q0N3hIiWTa+A60HXnG2QQBF/FFVESr0a0FyV31cZj4vlRlyM39woNi4a+Ya+clE2lER8/+W5Gv2hqTV4wRE1YE91ulNz18inmFq8vcXG7b02QcxZBA54jjsOccdRKhvr+bJ9ewY37Hre9vkQ7G9gfXUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NyGCWsoy; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnehKqgTC/yuCYeW+24WH6SnXegm7qnjGaL/t+TeDo2G64F+cWz7oo4tsWp5BnhLI1GxPm3WTu3iLx3DSLKzZsv1E6//4coFAZPxvKCcaUtG6Dy76SQJyt6GtctjY19CldsGRlHeX1obXZFgwGZyTFcqvOVi4bQOZyQtkBgwkErntHfirZkrn3a/Hw1maG5+mxCP6IfFZT9YzUDbIOc31ICUR328sqnbXJywpW2TKw5s+gkqMwNb0EWVSIGw1lNzRblVjziHZovMiRaJS5YSdjBqawyTrskHEkeCM/Akjwg6VFhnkGZrWf5lSqYBCSESeygfV4TUN9TdCphaFNbXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhNb31m4GU1OPFV5+/Zw7AXS668jWYM+KBaQI2OU+LI=;
 b=pjfMWzhfTVeogu0wciIQ3gXkZD2OgLyjz/G9IuohiLthbXl/tGvruemb9FfYIESU+Ji7dNOnBZ8dm79pQR4QPuJ53XQEJzOr+HsYcUXP5Wy8gknri1Xfl1AmfFN+DeQ3Y7odr/urHcOHLDvMfOBaZqLJl5PjouCbyvHnrghpexBBZ99ri+l0dFv4XJXq4wrGPH6DEM7KawFuQ16WWJqb0i4wPORxFFuOgoqgK1DttY+4JiW67H66B3cO7o8NjPaPisTb2QkEOwRa6uk667LZW4B/ugfXfRVBCuwsBHIqKouufYyxQREINNBPXg+RmS3xsXv1V7+LFSfh4LC50+HpdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhNb31m4GU1OPFV5+/Zw7AXS668jWYM+KBaQI2OU+LI=;
 b=NyGCWsoyMIygQvdD1bC5sC3FfhfETsvfsaULV0un170UPfvBcMZ9xU4BDTTQAyDtXdy0e/zZQIc99p4HziFHri/FNpDRmVtUhCHLYvOCKKq3LgfTyK17gA93FiLEtKTNTljAMOx5kLV1kVV2Bjkp0wi8H+AtUZVCCL5DQBsFxHa9N5gLnwSy8Lsj1m7syjhfrOay/TvqHs6p8tT7/r2EULgysuSwMFx8r1eSd3VFT7av2q3g73iaDF8E6BIeP3B0L5EFoh7oAYza4M8V+xIOZI1sd1SUaU0yCVxJp+/ZpTVhjJC6v4kkjCW9SBw7oBEDSxTwnVHOcq27Zqq9V8+eEA==
Received: from DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17)
 by IA1PR12MB8540.namprd12.prod.outlook.com (2603:10b6:208:454::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 19:20:56 +0000
Received: from DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13]) by DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13%7]) with mapi id 15.20.8005.026; Mon, 30 Sep 2024
 19:20:56 +0000
From: Sean Hefty <shefty@nvidia.com>
To: Peter Xu <peterx@redhat.com>, Michael Galaxy <mgalaxy@akamai.com>
CC: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"yu.zhang@ionos.com" <yu.zhang@ionos.com>, "elmar.gerdes@ionos.com"
	<elmar.gerdes@ionos.com>, zhengchuan <zhengchuan@huawei.com>,
	"berrange@redhat.com" <berrange@redhat.com>, "armbru@redhat.com"
	<armbru@redhat.com>, "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Xiexiangyou
	<xiexiangyou@huawei.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "lixiao (H)" <lixiao91@huawei.com>,
	"jinpu.wang@ionos.com" <jinpu.wang@ionos.com>, Wangjialin
	<wangjialin23@huawei.com>
Subject: RE: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Thread-Topic: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Thread-Index:
 AQHatnjBzD0Q+/leUkmGnsu3pioCmrI8DtYAgAALpoCAKMQMgIAAXY2AgAQQioCAA47yoIABVcMAgAMrZQCAAAQ68A==
Date: Mon, 30 Sep 2024 19:20:56 +0000
Message-ID:
 <DM6PR12MB4313D6BA256740DE1ACA29E9BD762@DM6PR12MB4313.namprd12.prod.outlook.com>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zs4z7tKWif6K4EbT@x1n> <20240827165643-mutt-send-email-mst@kernel.org>
 <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com>
 <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com> <ZvQnbzV9SlXKlarV@x1n>
 <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com> <Zvrq7nSbiLfPQoIY@x1n>
In-Reply-To: <Zvrq7nSbiLfPQoIY@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4313:EE_|IA1PR12MB8540:EE_
x-ms-office365-filtering-correlation-id: 6dd485e9-bd30-4f64-c613-08dce1850241
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WGtBRXlQS2t2UUg4bVRsb3pPaHUzQTN5ZUUzZ1I5RGpvWVh4R05zQnpJem9S?=
 =?utf-8?B?SFUwbGNRWUEwSGx2VGM1amhlK1lVL0dvRUwvYjVETkpQdVRIbENNVXN4bnhu?=
 =?utf-8?B?MmZDaTNUdCsxNXNyNU0vNHU0NFdTTjZDb3o3YXZCNkFmR0lPdlhuR2RocDBP?=
 =?utf-8?B?dFcwRHVJNnZUdG41eTR5RWpzbXhMWDlCaGxmdjl6emRFOGlTOWJ3WVV4SmtW?=
 =?utf-8?B?VllhRHVVM3N0Nzh6ZDliei9RbktHYWRRNVcycVJXYXhGamRzTDZ0RFJjakpJ?=
 =?utf-8?B?dytpbTdXbStsOWdNSU1nM1ZUN3lPM0Raei8wcmxrWUg0cW4rUHp6MnlULzBB?=
 =?utf-8?B?U2V6Y1JRTGgvblpjd0d0WVErMFZKbUlNbDdmSFZWbjJIbTEzRFFTKzFRMTBx?=
 =?utf-8?B?YVpZV3l4M2RTZnBxZ0pTTldKUUpxVDJkOFNpcSsyYjZLTTAvcFBGY0ZjbnBk?=
 =?utf-8?B?Ky9qT0dKRmlSMFNDNXJoekpyeWVHODJ4aFJTeUNKZ1Y0UVRJVHdhVEgzZ0Fy?=
 =?utf-8?B?VFhUS1hCc2FJRDVGNktSU1ZZNFBQWDdXSkxOQ2pFcVNYN3dhVUFaOTFrUEUv?=
 =?utf-8?B?bDBVOVJia0NoRVQ1VE5hOXNwRC9OU3gxQlVITWh0WDQzYkRKQ1lTampzdDdN?=
 =?utf-8?B?S3dLM2VPMmg2QUtiZHNGLzZURHNpUkEwY3NwbVl1NHZpNnBsMWtJQnI0MDBK?=
 =?utf-8?B?OVAwMno3bG1Vb1Q0cTRqVjBYL0hJYTRwQ1YrU1AweW1kbGVkd2RuUjVoSUdr?=
 =?utf-8?B?aE9YUEIrUWVmekFZVFh3NFJNYk5ubXZNWjJJM3QvN1M3Vmc3ZlBvY2x1aUMv?=
 =?utf-8?B?ZFZVSytLU2ZQSW9CUFcxRFJtbnNvejBMaWtzWDZ4UW9OMENoWk1CWGd2R3hR?=
 =?utf-8?B?a0ZVRzI5QzY4Wm12TGdqSFRuL3loOTFCTzlPVGtsRkI5eGZHdlYyRjd2VVVn?=
 =?utf-8?B?M3BQM1djSXpuMzRUc25IZWpuMzVxcHpCZWJLaHBCQWRJMml3d2x3SUtXMkMw?=
 =?utf-8?B?YXpkWEpvbEF2c0wzNkNYRU9BQkIyUS8yR2lZZldLYXJhTFFwSXlUbllpUjVQ?=
 =?utf-8?B?YUdWMmxUWFlobDNGQmgzM09Ramo3eTdacEo0cmVnRURraVh1eHcvMmZ4aEZy?=
 =?utf-8?B?d2hxZ2o1dW85WVBnR2ExalhxbDBEa2FyaDQ2a1ZtVkZubDN4bEovRkFXbith?=
 =?utf-8?B?TEN2RlV1bEFEOUFrMVRtclhiN1dORDB5RmRVVzVJNjRxWm5LYUdHVXJCeXdV?=
 =?utf-8?B?K29OdUFUbHhDUmRvZ0xlY3dQK1lKeDZrMnUvcGcxUkZWRStFcStrQTJjMENq?=
 =?utf-8?B?RFpSTVFGdkE0cFRRR291YTVaMlZhYmV2dmNZV2xKaS96YmZWUmFBYmpjb2w0?=
 =?utf-8?B?L1A2algvSklSN3ZibHFIMU9Wbmw0bFNEZ2pJank2QURwVlZ0ZDdkaWxPaUtj?=
 =?utf-8?B?cW1HQXlOQTl1MUhwbjNBbTBmQkdrUE5paVVPdk9zdEh5TTc1b3ZDRnRnRU1U?=
 =?utf-8?B?d0N1WWJMbElWVFdFdVZHc05CeDJuUzNvS1ZSVlFLSTByNzUxSlh2c0ZTamRX?=
 =?utf-8?B?eUNTLzZ6OVhVQlhEd2Z2VE5mQWp1QXF2TDlmajkzMlNVbFlRN1d6ZnVOWFo3?=
 =?utf-8?B?cWdrY3B6SWlVNCtXTGV6VEFUNTBqMm1IQlF0TG1pMDhWWlBSeGREQm1BMEdp?=
 =?utf-8?B?WFFRRU9HNmx2YVhOYWhzT3NNSUc3QXZVR1ZzZHZCeWQ1dUs4c3NabGsyamkz?=
 =?utf-8?B?cGlmeGhGK3dqNnE4RGZMM1RiYVJiOUtQcXNjUXJmbEthZkZkRkd5WlVlaTZM?=
 =?utf-8?B?TzdqQmNrd2xQL2pyeUIvdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4313.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aW9ZN0g3NzAwZlFtM1JETDdUQ3B2UzNTdVBtWW9XdVVWN2tPS3RrQU9adURs?=
 =?utf-8?B?VjFNSTBoQk9iaG1VZGhaRlpkOXhTUk9wNzE2VFFCb2tYVVVUd25vWVRTNTV0?=
 =?utf-8?B?VFMycDR3UUJHRVJYR2RINFlJWFJYc0JEanExaXhpSmwrREJWdDY3M1hvbWd0?=
 =?utf-8?B?RmRTOVNHejl3cVc5dU9rcStORVBCL01Kakh1NUNNUmJFTElUVThTdkx4WUg1?=
 =?utf-8?B?S1g0L2l6TFJ3alRoeEZnWGc3SnByT0I4NDAyWmUwZzAyUThTcjI2R3FKRWJ5?=
 =?utf-8?B?aUQ4ajRYY2FRNWJ6QWh2UVcwMTZCVVpSNFRBcExuYmhxZUVmc3dxaFREREdX?=
 =?utf-8?B?dzBHdDdvMHI2enFla2VFWXQyb29UUVhqRTZzRlpVLzljYitBNmNHTUtZZmh0?=
 =?utf-8?B?S3djdDFzQVhkUmdDcVF2dW5malhXVXZNamIxQjkycXdsWDg3VnpRL2pwelFT?=
 =?utf-8?B?dFZzT0JldkxPZ0w5b0h3T1JhZStFRHVOUVdBcjN3ZHJnSHoyU2JyUitTOUl0?=
 =?utf-8?B?N2xydUFEK2NOVExObkVzSnVab0lZektxV09pYlFPaVJ4NjMzK1lGU1V2ZS92?=
 =?utf-8?B?ZHZSL1p0SVp5MDNUcGV0blF2NHlrQWdneDk0YVFhN3ptRStEWVRWa1lpdVdx?=
 =?utf-8?B?MVBoazFoTlVUVzhHR1laLy9menA4NHNVTzltWllUM2YxRWlmNCtiUnV3SkUx?=
 =?utf-8?B?NnNpR1Z5enNxWlR4bGF0NTAzMmZxY2t0MVM1MG5XaXlGdDdKb3l5VFdvVWgv?=
 =?utf-8?B?UDZuU0NuNzY4VEY0dUZZOHJUMHU0ZElsbVNmRGxLdXRkMkNvTEJZNDZ0SWlp?=
 =?utf-8?B?TE1WR2k0djJnbnJOQ1V4WmhUN1lIRjhKeXhHTnpkNEhveEFDRzU3TmdFbmRy?=
 =?utf-8?B?b1VQdW1xbllaZVBuTmFlN2QrTExQSFdvS2FiV2hwZFQxOVhJZlUxRW5DenJi?=
 =?utf-8?B?QkRRUmFsZncvZ0N2LzVnODZheVBRRm1yUjlqRlgyd3MxZUtpc3pKR2VBQ3cr?=
 =?utf-8?B?cWgwa2hyT3l2V0ttTTlMU1ZIdU9VYnJoZ0NUeHJJVWg5NlhqeFlqM3BLaW1u?=
 =?utf-8?B?YW4xdkU1MS9jV2pTN2FvUUl2Skh2ZlhMY2U4QTFaYXJueGhpTFFtRzRJMmt5?=
 =?utf-8?B?Q1AxM3J2SmtlMkppRE1IQzQ0UlM3V3FPejFlc3JOa1VLUzRGaUNNSlNXMFhS?=
 =?utf-8?B?Zk5wY2VCUDhaeWlZVWQ0V3doRldLMWlnbDZtcVYzUTFobTM0aXBJdmp3WVBq?=
 =?utf-8?B?MXBHdHU3L3RWTXRsR29QTlF3eEpmTkVxLzRXZ3I2ckhFRXZxTVB2K1BHaUV3?=
 =?utf-8?B?eFdvS09NbGsydk9ESjI5aGNQL1F6dWNHMWRZUC83TUJ4QzF0aXFZb3Y2dUpr?=
 =?utf-8?B?TnErUTNHTDQrSkJtaThHSGJ0UTlQb0FVM1dXVDdPWUU4K0JRWDVzZkNXeVJ0?=
 =?utf-8?B?RnFQOXZOLzA2VjY5dU9LZjBLZGQvUjkzdnl1TkNkVG5pd0JWcUtEYTYrUEd3?=
 =?utf-8?B?VU1EK3ZPVFc1TjBPSEtOOFBZdzJhNkhkRHpmWEF1eGlMdUVwSTlXVG5DeTRD?=
 =?utf-8?B?emE0U1lHMEJBNERHbDFsM2psT29rVTNCb0dPN0xjK1UySm1zQkpWanhTc3NP?=
 =?utf-8?B?ZlVJeEZMYU56YlRLUjN0ZVRLVXhiWG5XTUQ0ZnVvWWtVZ2VCMElqQTlaaHRQ?=
 =?utf-8?B?aUYwMlpSQjlTczUrbmFWYnZlTm1BNVJkTGs2Q0pmSEFSa2RicDE1VlBNenVK?=
 =?utf-8?B?U0N2bUF4ZHFlZk9QejRYTFVhME9yL251eWVHTWtyQjVyZnZZTW1kYnJ4ZjNr?=
 =?utf-8?B?UWhuTytZOHRQNGJMaGRYQ2p5UWJLRWd5amI3d0Nic2plTEVkdWZvNmMydk5W?=
 =?utf-8?B?T2pBL055eDJWZUJCeXlsVUtpODlRQkpybWUvQlNaUTVYVlBib0RWbGQwOWxh?=
 =?utf-8?B?WnZtWlU0OFVnODZmemRpT0gzWnNnV092S3QyOEgxRWEvOE1NMXZITTZPdTFZ?=
 =?utf-8?B?ZU42UUR4b3N0Q1B1OFQwZHVUOFlZZXVlV0JxeSsrUXd2cnhZb0lpVmpxcUtW?=
 =?utf-8?B?QmtSbEY5UmQvUXFpK2VjV2EwMEZmMFRyR29HQUgyMXVpYVcxcU9MTjh2ZjJW?=
 =?utf-8?B?dFFPWURDaTdaajFWTGhNeWpQTUdCNHdBdS9IQVQ3eXRVcVpHdzFzY0MvWk5y?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4313.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd485e9-bd30-4f64-c613-08dce1850241
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 19:20:56.3954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8BbHBsfWMYRyRh0MVVpuzJ22RUc/8BrR/3I2kERp019GUKhnM0q0O+qx/7sqqzv985p/60YIoN1uHpyLnCZEHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8540

PiA+IEknbSBzdXJlIHJzb2NrZXQgaGFzIGl0cyBwbGFjZSB3aXRoIG11Y2ggc21hbGxlciB0cmFu
c2ZlciBzaXplcywgYnV0DQo+ID4gdGhpcyBpcyB2ZXJ5IGRpZmZlcmVudC4NCj4gDQo+IElzIGl0
IHBvc3NpYmxlIHRvIG1ha2UgcnNvY2tldCBiZSBmcmllbmRseSB3aXRoIGxhcmdlIGJ1ZmZlcnMg
KD40R0IpIGxpa2UgdGhlIFZNDQo+IHVzZSBjYXNlPw0KDQpJZiB5b3UgY2FuIHBlcmZvcm0gbGFy
Z2UgVk0gbWlncmF0aW9ucyB1c2luZyBzdHJlYW1pbmcgc29ja2V0cywgcnNvY2tldHMgaXMgbGlr
ZWx5IHVzYWJsZSwgYnV0IGl0IHdpbGwgaW52b2x2ZSBkYXRhIGNvcGllcy4gIFRoZSBwcm9ibGVt
IGlzIHRoZSBzb2NrZXQgQVBJIHNlbWFudGljcy4NCg0KVGhlcmUgYXJlIHJzb2NrZXQgQVBJIGV4
dGVuc2lvbnMgKHJpb3dyaXRlLCByaW9tYXApIHRvIHN1cHBvcnQgUkRNQSB3cml0ZSBvcGVyYXRp
b25zLiAgVGhpcyBhdm9pZHMgdGhlIGRhdGEgY29weSBhdCB0aGUgdGFyZ2V0LCBidXQgbm90IHRo
ZSBzZW5kZXIuICAgKHJpb3dyaXRlIGZvbGxvd3MgdGhlIHNvY2tldCBzZW5kIHNlbWFudGljcyBv
biBidWZmZXIgb3duZXJzaGlwLikNCg0KSXQgbWF5IGJlIHBvc3NpYmxlIHRvIGVuaGFuY2UgcnNv
Y2tldHMgd2l0aCBNU0dfWkVST0NPUFkgb3IgaW9fdXJpbmcgZXh0ZW5zaW9ucyB0byBlbmFibGUg
emVyby1jb3B5IGZvciBsYXJnZSB0cmFuc2ZlcnMsIGJ1dCB0aGF0J3Mgbm90IHNvbWV0aGluZyBJ
J3ZlIGxvb2tlZCBhdC4gIFRydWUgemVybyBjb3B5IG1heSByZXF1aXJlIGNvbWJpbmluZyBNU0df
WkVST0NPUFkgd2l0aCByaW93cml0ZSwgYnV0IHRoZW4gdGhhdCBtb3ZlcyBmdXJ0aGVyIGF3YXkg
ZnJvbSB1c2luZyB0cmFkaXRpb25hbCBzb2NrZXQgY2FsbHMuDQoNCi0gU2Vhbg0K

