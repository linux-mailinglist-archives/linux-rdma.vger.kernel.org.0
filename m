Return-Path: <linux-rdma+bounces-9497-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC15A90FD1
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 01:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2648175703
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 23:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893FC24C073;
	Wed, 16 Apr 2025 23:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ficWAry+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6319221F07;
	Wed, 16 Apr 2025 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744847930; cv=fail; b=GpeY+YGrywbJimD+pk1PlGrZHo+5X5lZ0da/9bvzSnUXY+TsDSQM/Dh1LM0Kn95gfV6WBZiIUGkqgtsmoIsozYIepgNex6r71JD+a/TS6MTCzeIVqwiiLtinHQzVWij1w0wxBZOwHLiU7QdKZny1Pa+irBNPEudF9Dp/xKKfuTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744847930; c=relaxed/simple;
	bh=53f4kSH0IoTnHSQDQciPh7sVjm1q8EscXoYlj2256po=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZjYptPAXl82k1HJS0jqEaL4gdhc/vQafVb8pf9MpK3akgRyaYFyp0CEm/dhLbhvb9RIpFyspu8w3YPOGE8KZmxePVTajGzic9JA186z4aeeUFKILMvOwhoo8908v56R9RhnpfZ5WR99WqmdBjp7agFcXdRML6+DlcY2Fbmyrslg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ficWAry+; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzLc6belCbjGF3AjsFRtW5xykLCAUuQMBdNUppJd0JAbhbInWu0q0TRwIvACZk1PVc6j9ct/TtmEHgiuJesISOQOt9Lr3eUy+p5CRrzPRfEfE++T1aPXiKSV4UKYD3pCpApM9MIu7F/xXSkoHEvAv8cL3oCF97nhLApTJCRSak/TTCSk4uDoGQs3qBHzX2hSGf0FXAGhRVkqrMFm9YwBORTNqTGdoCf1C0nz1HGDhUrfCYCwJd+mkzIH+Wt8lV0JrJ08UQdUzzv2iXWtOSQnpI/Y45sjTTWAWHYHBoDW6x7tJiPXadeFb7V4a4OS+PRWBjuf93C8FD19mCz3B0u2wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53f4kSH0IoTnHSQDQciPh7sVjm1q8EscXoYlj2256po=;
 b=T1V/PPvVs2aUuGWDFu0yWJebxj0eCNHbUYkUJr7cMNn2Ep72abl+pg7KTZyJJ7ZmkKCM7iFw3qbzpIncFfaID40E8OBbhRcPg3RUNiif7ZGATrV9Ryhrs+DynHg3m9U6CKGVAL6TV7nOCq4d9pAJYQJwV8mSMHXDgmPJC+3Bqfni1u2q33QwR04ohxvVrDGnw7aZ+Ao7vxal/Z0Vi1fBHmb1Ll2ddpTbXPMIFWj0hkYs1rEfMz/g13iV893urUpJJKEuF6R5tfQQYOZAqI+Zq1CHm/JN6O6XqzHAZEnKBVWAAUt7tD753+gEFCD1oqlXsNY2SancaySltCt9iKGGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53f4kSH0IoTnHSQDQciPh7sVjm1q8EscXoYlj2256po=;
 b=ficWAry+LlfkkBqsIgXtehLKXpu2WPAgdrBlYb7B9EdPQtAaNuhUFHdgs0w6cFHdI7R6h0wRP1YalddfhjNY7lhgty++TRAkoS+FAxZSGr7VStdSOCy0iT2sdA7tkvUCqctA+BYJ6ccTdh4m8avpYpRAlVXhO1A5dB8onSvWo3hH9ySvE9jsJp4QP8V+LMpOqw8Bz+9SZHP79qIURHwREzXXSB+v3yvRtFNgG/g4CeAlt/jN/OT2S03oxGz5OYL+AEiPjZtIswrwsXdbj+9d13MriwlSbV1N56VUHnKeitlUkhS1KwxW3KGQlTSlyV0hHxyYf70Odgz6nD7qwkOdiA==
Received: from DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 16 Apr
 2025 23:58:45 +0000
Received: from DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13]) by DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13%3]) with mapi id 15.20.8632.035; Wed, 16 Apr 2025
 23:58:45 +0000
From: Sean Hefty <shefty@nvidia.com>
To: "Ziemba, Ian" <ian.ziemba@hpe.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Bernard Metzler <BMT@zurich.ibm.com>, Roland Dreier
	<roland@enfabrica.net>, Nikolay Aleksandrov <nikolay@enfabrica.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "shrijeet@enfabrica.net"
	<shrijeet@enfabrica.net>, "alex.badea@keysight.com"
	<alex.badea@keysight.com>, "eric.davis@broadcom.com"
	<eric.davis@broadcom.com>, "rip.sohan@amd.com" <rip.sohan@amd.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "winston.liu@keysight.com"
	<winston.liu@keysight.com>, "dan.mihailescu@keysight.com"
	<dan.mihailescu@keysight.com>, Kamal Heib <kheib@redhat.com>,
	"parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>, Dave Miller
	<davem@redhat.com>, "andrew.tauferner@cornelisnetworks.com"
	<andrew.tauferner@cornelisnetworks.com>, "welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Topic: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Index:
 AQHbjuwVUw9AWIkXnUa8bbJSM0sPK7N6v4MAgAgXf4CAAAnsgIABEwYAgAAgrcCAAYj9gIAAAVBQgAARqYCAAABpoIABaOyAgAaJkiCAAUvLgIAAK6TwgABCwQCABHrAgIAAgVrAgARv/wCADl708A==
Date: Wed, 16 Apr 2025 23:58:45 +0000
Message-ID:
 <DM6PR12MB4313339425CB8921299AB9CCBDBD2@DM6PR12MB4313.namprd12.prod.outlook.com>
References:
 <BN8PR15MB25131FB51A63577B5795614399A72@BN8PR15MB2513.namprd15.prod.outlook.com>
 <DM6PR12MB431329322A0C0CCB7D5F85E6BDA72@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+QTD7ihtQSYI0bl@nvidia.com>
 <DM6PR12MB43137AE666F19784D2832030BDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+Qi+XxYizfhr06P@nvidia.com>
 <DM6PR12MB431345D07D958CF0B784AE0EBDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+VSFRFG1gIbGsLQ@nvidia.com>
 <DM6PR12MB431332A6407547B225849F88BDAD2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250401130413.GB291154@nvidia.com>
 <DM6PR12MB43130D3131B760AF2A0C569ABDAC2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250401193920.GD325917@nvidia.com>
 <56088224-14ce-4289-bd98-1c47d09c0f76@hpe.com>
 <DM6PR12MB4313B2D54F3CA0F84336EB71BDA82@DM6PR12MB4313.namprd12.prod.outlook.com>
 <c1b9d002-85f5-420e-b452-d6f2a11720d4@hpe.com>
In-Reply-To: <c1b9d002-85f5-420e-b452-d6f2a11720d4@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4313:EE_|IA0PR12MB8981:EE_
x-ms-office365-filtering-correlation-id: 4f1f4bde-1374-438c-3637-08dd7d429f93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2JsR0FDak5YcFY2N2hFSlUyR1JqK0RJaFEzS2hWUDhka0VzMFFUT211WEEv?=
 =?utf-8?B?dW5VTmpEZkpJQngvK25hMjlCVVI4cWhGN1kwV1ArL2twem9XM0pPUUJ6YjQ0?=
 =?utf-8?B?QUhnMUlXd2huZ1o4dkRrSkpNVWEyam1Qdml2dkUvcXE1c1RyeFlESzdkWFRI?=
 =?utf-8?B?S0Z1N0R3ZFQ5a2JpaDBXLzJaV1pEUGJKR1JsT3VyWTZMbUF5cHBHMVFoSkw1?=
 =?utf-8?B?UVhLU3gzcXJvNXJMcDhkTUhYNVF4Q1Jqb0JYWUZ1RFZkcHlJNlFhMGd5UzR0?=
 =?utf-8?B?R1B0V3NSRFB6S3ppS1BJYmw2Yi9EQ1ZVLzZLU3E0akZ6b3NVQVBvbk9STCto?=
 =?utf-8?B?MU1ZUHNYR3IvMWJpNFR4cUdXWEw5RWNlWGtJRU1raEQ2MjlITHZtcU1vY3pV?=
 =?utf-8?B?RkY1RForcGpZSDVERnB6SWY1M2lGcGk4UjBlRnNyS25UR0VSaUZvYllFRXdG?=
 =?utf-8?B?V2E0T01oMnA5Rm5CN0IwOGRmZU9tdmhvUkorVjJlWkF2dDlpYjNGUm9FZGZR?=
 =?utf-8?B?Vk5FQzdPd0F6NHJJc0dFMXRBbDBhYzluRmVXR3hOdUU4b3JLRzY4T1hyWlpG?=
 =?utf-8?B?bU9iMHA5TVEzQVFYcGozL3dqUWZpZC9WNGZtM2x1UW9zdVUxdDVYSXVaaEVH?=
 =?utf-8?B?VnNJdldXSEh2dEtFRG4xL2hPamgxQ1B5NnJVQ21kZS9LbWNlSHlOZDhqMzJE?=
 =?utf-8?B?Mnc5cjVTYjlSb3JudXRjOUsrbldOeHBEYXlSNFEyd0EwNENjdE1oQTFQL3BN?=
 =?utf-8?B?c0M4U1lQYkhEamthSi82eHN1eVJINmVmakNoc2Jza0NyZFdxUnB4Y3F4VmVK?=
 =?utf-8?B?dHVTUFFzVTJMaWQ5UVZBdUJEWmFSK3E2QjJGYlgvWm5KR1Rmd3o1YWFLUnYr?=
 =?utf-8?B?Q1BYUlljUnZkQ2RCcTRjVFpyTE9iN0tBUnJ3ajlnM1dIL01YYTNDMitUdjVx?=
 =?utf-8?B?SGdxNWtXbm9nN2ZBMWZobG5ZeEhsdjg4Y3RQcWxQOVRVblFqME50WStFZlJ5?=
 =?utf-8?B?S0xlMXI5V0o5ZTh4RjU3RFVKZnI4RW5iVTQzRm5yNXlKaytpY1F1VjZyK3FB?=
 =?utf-8?B?akU5bkVvZHRSbXNPQXlvaksyMTZLaWdZSk1DZHM3SlN2Qm9pcG9leU14dnpN?=
 =?utf-8?B?NDdQdHNZVC9ScDNzK2VVcWV6MmRqMXpRN21LL1I4bGxXZ0NnWFFvMDdKK3Rh?=
 =?utf-8?B?NDd4ZHhyNkw5Rng2SWdEbm8yZmhXQ2UwcEdYT3BoYytBQmcrc3FNNmNuWWtF?=
 =?utf-8?B?eWt6TVFlbTZiYnh0RURqOFpmTDFUZUM3SjY2Rzg2aWdmaXJEclFJTUd6VjI3?=
 =?utf-8?B?RlZEWFRPdjdpUThzVUVqeXMrT2F4cU4yZlZYUUtMZ0JaZXBYMGFEcC9mTnB4?=
 =?utf-8?B?U2hFNHlldytuTXNicTRsUHd3WEg4R0FzNVJvemVlV1MrZzk0YWZTWlJ2WmRY?=
 =?utf-8?B?akNacGExKzRjTUt4cVU1R0hGdWZmMHltaWJEbXFHR0JMd3U1WmpUbVM5RTFH?=
 =?utf-8?B?Z1p3Z0htTGFBSXh5dnNSa3lLUnQ5WmlYT002dmhuZDdNV3FKWG5Vci9mNlVh?=
 =?utf-8?B?dXl6T2xMV1JKcU1EM2pWa0h1QlhQWm9YRmt0dHk1Wkw0RG41Mk8xeXBrdCtU?=
 =?utf-8?B?eEJhVzdTR2RGeUhTVG1PQjM2N29McTdjYXdmeUV0UGlxbDU1NTBDR3hGZ0pl?=
 =?utf-8?B?RzBmWStMVlk1Sm1pTHoyV0pXc2hSazlCRXJETWc1eW9wamdCWFFIWFBWQ2Vl?=
 =?utf-8?B?dzh0Y1E4aG5rWDZ5OTVpUUlSTXNFdU0rRmJWMWNlcUs2cjR3YWhHZlJxQXZx?=
 =?utf-8?B?RlZCOFgzU3lnMmpCQkFxZjJNWmlvdlVEbUg3NXF5M0lwODdyemIrNy95Zmdm?=
 =?utf-8?B?UHpIU1d0MUlCYkIxS3NiRldGWlV5Zk03K2ZRK3I2dEwrWERmbHVVaUMvYnox?=
 =?utf-8?B?dTEzQzRHcG43NUh3WEM1andoQzFoaG5FNUhXVGFqcWdDTWlyTjd0SlJoSTlR?=
 =?utf-8?B?MExuL0FJOWd3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4313.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0twVnRNTHZlcklEMDFZOGNWcEJ4ZVlXTTZjdWdNV3pwUHYralFhcm9USXpW?=
 =?utf-8?B?a2kvdzRnKzJmcG0wM0hJQTN5WmdNRzRnd29XdzJQbnpuRUhyQVRDNGJPakpx?=
 =?utf-8?B?Ly9TR0dibWN5a1NHbVZnMWJoUTduZGlqWVk0M1RjaWVMcTRLWVBlcDJLcjlD?=
 =?utf-8?B?NkhnbTh6ckZRNGwrV2Q4VU8zSGFwOEJzQmdSNE14V0IyQVFKYURjYWJvdTdE?=
 =?utf-8?B?WEt3NTNFeWFaREJWdUpQdmsvT0hMdXVsWTVMMThUSm0xU3hEWjVtNldmaXZ3?=
 =?utf-8?B?ZGJGdXkrUWdZZVNDSDErVW5HVE1CU1ZPZHphNmFVbXFDb1JjemM1emNObzNN?=
 =?utf-8?B?MXNYOWZQQ1hIYitEMis4ZnNLTHlDWTNuQ0JGZVU2bC82U0gvb1pyRDZFYlVo?=
 =?utf-8?B?Y1Z4a2xQU0YzaXF6aEMranNLSU1oUlBJTW1xMUZXT2hOQWx5QTJHMUd2WVpW?=
 =?utf-8?B?WFZMaHByQVpKcHVmaFkzeXl1bGZhakVYZGRxeDgxV3dRTXMzWTdzMTNTcVB5?=
 =?utf-8?B?VmJuRGw5MlFNd1Q5djJiV2RKMEtiYUkwY0dUZGtTMGNpQzQraGc2SXJxb1p4?=
 =?utf-8?B?dk9FYjVxTVp1OGhNZTJYdkJSNlZJS1JTTnBTTFF6enRoalhDRU9KcVdpbkdF?=
 =?utf-8?B?bjdBcWpUdEJtWGE2YVJPb28raWEyd3VISUlKait4YzVRN0dBdEVZajNpc2s1?=
 =?utf-8?B?ZDRsdDFEaFc3WVA4QjFIV2RkSkkxK3RoZGpwSDVITHZWNFlPeFJIVWhBbFBh?=
 =?utf-8?B?K2crSFZIUjQwUDI2NTZtdzkzWDFkeVpPUDRMT05uMldDMEpEZXVLQnUyU2NK?=
 =?utf-8?B?S0dxbnM4cUtOODF3dXdlalV3Q0szZzhQakpDMnpFcDh0OFJOWTVOek9xbGpU?=
 =?utf-8?B?YlBBQTg1MzZvNEYyaDExcFNRK1pJVDNqV1JXd0t3T3Q2NThyNVFsUE1NaEZq?=
 =?utf-8?B?ZlNJTmlIM2I5MEF4NVN1MDg3UHJ0bXNwQUxSZ01xZllaYk5UQWVMdUMxcGFD?=
 =?utf-8?B?K3ArT3lOaUptK05zMjRBa3J0OThiYW1FTHBNbGM5Y2Z5L2JKMDZpbUF4UVpJ?=
 =?utf-8?B?c3VEenFEaWxwaDR2V1M2RGlHdjRZdXFvN0VDYzRYV2NNdDYyV1JEanA5cFVH?=
 =?utf-8?B?VCtMQ0k5d1Z3K1NYTUFuR2ZIQTRwbW9sWUxURUg3aDlTNjJQN3liNUtqNzNk?=
 =?utf-8?B?UExqMmpBR0YrU21PQW52WXk0RGdSWGEwN0pib2RPc1hLaWVPU1lKSFNwVjlx?=
 =?utf-8?B?WUtDMGZ1YUdmbGljNFlyOVFiU3E3czZpSEVCWHcyTHlDNXFIOVBMaHlwc3RK?=
 =?utf-8?B?cFN4Q0ZoTC9pYXQySk5HbDRIQkZaaWM4ZmR0dW5HZlhQWFhoVFdWV2c2Rmhr?=
 =?utf-8?B?WmlUWHlpY2ZaQmRaL051TzdXZUk3c2JmL3Z1Rk9rVC85SmFSb3Y4M25DdTg2?=
 =?utf-8?B?YzBLS2dZUXJwK3FVekttSE1hM0EwWWhETk5BRTVYZzJkV013eXhNNE4wQVA2?=
 =?utf-8?B?SG5ER1VLbjlvSGJyVkp2dVpPUlNRR2dQdS9TTmNhLzhoZmkzNGxBT3RmNWg0?=
 =?utf-8?B?bU0ycEl0aFZ5T0FLQnpCcDNCQ0tkeUlxVkxYcnNBR3hEQzhNRUdLTGNJekpt?=
 =?utf-8?B?L1prWXlkOURIUStUVTBBN3dUV1JNNVcwUGNRNTFETTZ6VFBKMG5KZ0t3c1BU?=
 =?utf-8?B?cm9VaHVScERCY1dYWnpuRW9xOGpQVkJRS2dJVmk4bHBTWS9SaTFCUWNoT0F4?=
 =?utf-8?B?WkIwdGVQdStOdC8wakc4c25qM2NWQ1BnZFU2a05qSEx2MUVzU0IxdklKTEpa?=
 =?utf-8?B?dE1LMEIrSDVsdDVwYUlybnMwNFdIVTdWTmVGNUtzeDM1bmFhL1FHb1MrY0tI?=
 =?utf-8?B?akljbkprL081QnFXNUl5NHNoelZlVStHOC9lQkU3eXNwVitna2FPODZ0QlRk?=
 =?utf-8?B?MkxNbHJUdEtiQVdTb3hGaHRuY1o5NHArbHQxM1pyYXhmc2pQd2poY1RKQXc0?=
 =?utf-8?B?MElsbDVmZ1hkWEJHYkRJZTZlMTNEamg4M05PT0hhYk9lNi85dm5qb3NZSzBJ?=
 =?utf-8?B?bjZ6N3ZYaWEvNTVNMnRFMVNLeis2SGM4TEV1NmRRMU9zc0pRR1F3a2sxZXBI?=
 =?utf-8?Q?Yko3wCUQSoBMDMKZ8nh31GLtL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1f4bde-1374-438c-3637-08dd7d429f93
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 23:58:45.4729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oStMZCuaRe67JkbjGxQ1vGg9+0W/u6iJ9HKmidA77Q7Et16Qx8nH3o7q23c92hT6hqKg2ZM9FaPEds9GRe8DLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981

PiA+IFRoZXJlJ3MgZGlzY3Vzc2lvbiBvbiBkZWZpbmluZyB0aGlzIHJlbGF0aW9uc2hpcDoNCj4g
Pg0KPiA+IEpvYiA8LSAwLi5uIC0tLSAxIC0+IFBEDQo+ID4NCj4gPiBJIGNhbid0IHRoaW5rIG9m
IGEgdGVjaG5pY2FsIHJlYXNvbiB3aHkgdGhhdCdzIG5lZWRlZC4NCj4gDQo+IEZyb20gbXkgVUUg
cGVyc3BlY3RpdmUsIEkgYWdyZWUuIFVFIG5lZWRzIHRvIHNoYXJlIGpvYiBJRHMgYWNyb3NzIHBy
b2Nlc3Nlcw0KPiB3aGlsZSBzdGlsbCBoYXZpbmcgaW50ZXItcHJvY2VzcyBpc29sYXRpb24gZm9y
IHRoaW5ncyBsaWtlIGxvY2FsIG1lbW9yeQ0KPiByZWdpc3RyYXRpb25zLg0KDQpXZSBzZWVtIHN0
dWNrIG9uIHRoaXMuICBIZXJlJ3MgYSBzcGVjaWZpYyBwcm9wb3NhbCB0aGF0IEknbSBjb25zaWRl
cmluZzoNCg0KMS4gRGVmaW5lIGEgZGV2aWNlIGxldmVsICdzZWN1cml0eSBrZXknLiAgVGhlIHNr
ZXkgZW5jYXBzdWxhdGVzIGVuY3J5cHRpb24gYXR0cmlidXRlcy4NCiAgICBUaGUgc2tleSBtYXkg
YmUgc2hhcmVkIGJldHdlZW4gcHJvY2Vzc2VzLg0KMi4gRGVmaW5lIGEgZGV2aWNlIGxldmVsICdq
b2InLCBvciBtYXliZSBtb3JlIGdlbmVyaWMgJ2NvbW11bmljYXRpb24gZG9tYWluJyouDQogICAg
QSBqb2Igb2JqZWN0IGlzIGFzc29jaWF0ZWQgd2l0aCBhIHRyYW5zcG9ydCBwcm90b2NvbCBhbmQg
dGhlc2Ugb3B0aW9uYWwgYXR0cmlidXRlczoNCiAgICBhZGRyZXNzLCBqb2IgaWQgKHJlcXVpcmVk
IGZvciBVRVQpLCBhbmQgc2VjdXJpdHkga2V5Lg0KICAgIFRoZSBqb2Igb2JqZWN0IG1heSBiZSBz
aGFyZWQgYmV0d2VlbiBwcm9jZXNzZXMuDQozLiBEZWZpbmUgYSBQRCBsZXZlbCAnam9iIGtleScu
ICBUaGUgam9iIGtleSByZWZlcmVuY2VzIGEgc2luZ2xlIGpvYiBvYmplY3QuDQogICAgTXVsdGlw
bGUgam9iIGtleXMgbWF5IGJlIGNyZWF0ZWQgdW5kZXIgYSBzaW5nbGUgUEQsIGlmIGVhY2ggcmVm
ZXJlbmNlcyBhIHNlcGFyYXRlIGpvYi4NCjQuIFN1cHBvcnQgY3JlYXRpbmcgTVJzIHRoYXQgcmVm
ZXJlbmNlIGpvYiBrZXlzLg0KDQpXZSBjYW4gc2hhcmUgam9iIElEcyBhY3Jvc3MgcHJvY2Vzc2Vz
IHdpdGggcHJvY2Vzcy1sZXZlbCBpc29sYXRpb24gb2YgTVJzLiAgVGhlIHNlY3VyaXR5IG1vZGVs
IGNhbiBiZSB2aWV3ZWQgYXMgbWVldGluZyB0aGVzZSBjaGVja3M6DQoNCkVuZHBvaW50IElEIChR
UE4pIC0+IGVuZHBvaW50IChRUCkgLT4gUEQNCmpvYiBJRCAtPiBqb2Iga2V5IC0+IFBEDQpya2V5
IC0+IE1SIC0+IFBEICAgIG9yICAgIHJrZXkgLT4gTVIgLT4gam9iIGtleSAtPiBQRA0KbGtleSAt
PiBNUiAtPiBQRCAgICBvciAgICBsa2V5IC0+IE1SIC0+IGpvYiBrZXkgLT4gUEQgKD8pDQoNCihP
dGhlciBmaWVsZHMgY2FycmllZCBpbiB0aGUgaGVhZGVycyBhcmUgbmVlZGVkIHRvIG1ha2UgdGhl
c2UgbWFwcGluZ3MsIGJ1dCB0aGUgY29uY2VwdCBpcyB0aGUgc2FtZSkuICBBY2Nlc3MgaXMgYWxs
b3dlZCBpZiB0aGUgUERzIGFuZCBqb2Iga2V5cyAoaWYgYXBwbGljYWJsZSkgbWF0Y2guICBUaGUg
ZW5kcG9pbnQgY2FuIG9ubHkgc2VuZCB0byBqb2JzIGFzc29jaWF0ZWQgd2l0aCB0aGUgc2FtZSBQ
RC4gIEUuZy4gYSBqa2V5IGlzIHNwZWNpZmllZCBpbiB0aGUgV1IuICBUaGUgZW5kcG9pbnQgY2Fu
IGJlIGNvbmZpZ3VyZWQgdG8gcmVjZWl2ZSBmcm9tIGFueSBqb2Igb3Igb25seSB0aG9zZSBqb2Jz
IGFzc29jaWF0ZWQgd2l0aCB0aGUgc2FtZSBQRC4gIEUuZy4gT24gcmVjZWl2ZXMsIGVuZm9yY2Ug
dGhlIHNlY29uZCBjaGVjayBvciBub3QuICBJIGFtIHVuc3VyZSBvZiB0aGUgbGtleSAtPiBqb2Ig
a2V5IGNoZWNrLg0KDQpJZiBhIE5JQyBvciBlbmRwb2ludCBvbmx5IHN1cHBvcnRzIGEgc2luZ2xl
IGpvYiwgdGhlIGpvYiBrZXkgaXMgY29uY2VwdHVhbGx5IGlkZW50aWNhbCB0byB0aGUgUEQuICAo
QW4gZW5kcG9pbnQgY2FuIG9ubHkgcmVjZWl2ZSBmcm9tIHRoZSBhc3NpZ25lZCBqb2IpLg0KDQoq
IFRoZSBqb2IgbWF5IGFsc28gYmUgdXNlZCB0byBzdG9yZSBhbmQgcGVlciBhZGRyZXNzZXMgYmV0
d2VlbiBwcm9jZXNzZXMuICBUaGF0IGlzLCBpdCBhY3RzIGxpa2UgYSBsaWJmYWJyaWMgYWRkcmVz
cyB2ZWN0b3IgcmVzdHJpY3RlZCB0byBhIHNpbmdsZSBhdXRob3JpemF0aW9uIGtleSBvciBubyBr
ZXkuICAoQ29udmVyc2VseSwgYSBsaWJmYWJyaWMgQVYgbWFwcyB0byBtdWx0aXBsZSBqb2Igb2Jq
ZWN0cywgc2VwYXJhdGVkIGJ5IGF1dGhfa2V5KS4gIFRvIHJlZmxlY3QgYSBtb3JlIGdlbmVyaWMg
dXNlLCBJIHdvdWxkIGNvbnNpZGVyIGNhbGxpbmcgaXQgYSAnY29tbSBkb21haW4nLCByYXRoZXIg
dGhhbiBhIGpvYi4NCg0KLSBTZWFuDQo=

