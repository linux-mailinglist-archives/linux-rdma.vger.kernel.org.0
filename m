Return-Path: <linux-rdma+bounces-3432-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16861914859
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 13:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6EA82854E0
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 11:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28E51384B1;
	Mon, 24 Jun 2024 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YZ0H0CEB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DAB130A79;
	Mon, 24 Jun 2024 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227917; cv=fail; b=fWwvb3CPFEGmwxjPOuGFciRLErQuVswr5zFrDiOuyBLYRITbXTvk3DUNDydYLEHnAvydKs56RPkmTZgked4qQkiurCs5wosOemPg3SswpfGS7/nvx/X6AQMOsxDbQa8entMtQ2SXa1bmsFu7fuMXqy+zh6sQal6CK1S1Ey5ODfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227917; c=relaxed/simple;
	bh=9SUdVY4Ykpc+NmfbpuoGrZDowZvKRDqojJ3k2oc1XGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FEkLA9xl7/c7wHxnkGFCXVgRFnXXWUBTjGVfyiL2cDt48HMnxE06jF0Sf9SNGpG0pBzbvyJl/Esje3uFyQTFH9CoLKkdVff0t0gbMcELZXjaEiGT97ltm/KdZ7Yn1VtJ4xIlfJsLwuk2BRkwB53nlEKoCKY3itVqNzAS0J7jyx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YZ0H0CEB; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmzugmdf5f94rxDDg1oLB21FCzhi3rzU9jrguZHvcsWdR0n9yZfBIKgxHzxF5BoNBop59F1zuIMJjOQW4E24STkMuAg2E86DHoDM58VcxkvnocDjCxG0U/+yOLSXZrDQTIiz/OE7eaz9QRZ+gUhXkrluFC7Ao/b1tYtagqW9+FKVLs79MtxVPRx6mdegjwdpunUs9MRjzshg8fK/eV8+xVb8fE/kPJcX4GLdpy7EY1g4OBugHtGzrZZf/2FeeVgKhEvRW97V4geFzf7hPvWlVj0DsXz3zoZylpYwl6HzgWYoWSnXWAHqoP5ZWE8c3suf2l8Y4/rsr9ZKmIjs11WKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SUdVY4Ykpc+NmfbpuoGrZDowZvKRDqojJ3k2oc1XGU=;
 b=cFyW23zOdRmx8Mpdjk9H4DdIpX+fK5O6Rln2yVVHXX2Z3b7Zjn6EdVW6vamx2GE1gUYB2FqYL7ECGUBMQc2lb7Md61Evr9b96HjFKp3jAL01Lwm6CDCQwUWk1F7ymJK8QzYZm1TiGrmYqE2PrHfy4Z/Ew6rAyFdeOqjmqtkgRIJenzh+NwH8ewhiMReRiMPl7eXOqnQ/DKU0FzWHlGrek/vGUczaffh0kSHDxQyqDjwIJ+2feVhnhnynN5QBO5tkVA3IYgD15dTqyua0cIA4EtSz/X48YLCXHxJc7VEKGDwrq3claxe18EYT3QyCyhp3ygs7mTWj8N4kHRxv116dGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SUdVY4Ykpc+NmfbpuoGrZDowZvKRDqojJ3k2oc1XGU=;
 b=YZ0H0CEBD9enXDySpxK2ocvssTNnFwZP6sNMkN3ILm6EPG1IcFVkn2UZmyG0sds6/ccFAPUnYBhuTu6N/RM4+pnJvl+lB7nkNstmcKEEz2Ks/xB+5w+rLBiUezw3HqZQbtb5YQFSho4JBdHHRB7UD2HPmwguQBbE7jpjh7DlbdgNNYpa60ghXTj4MYjvsRNMug9Usgl6NA+CpBRBro7DljivletL94VKL/c/P1k7jbdmrbFoGfVXhyl63l7v8oOhLwjZkbq6eTlM7tC77PM3TurZfCDQVXuk2+AILbEftz/azKwSUHBpkED8amAK+FeeQ4pumfqA4CI1psT0qUPoXA==
Received: from PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14)
 by DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 11:18:31 +0000
Received: from PH8PR12MB6843.namprd12.prod.outlook.com
 ([fe80::5958:e64b:fe79:d386]) by PH8PR12MB6843.namprd12.prod.outlook.com
 ([fe80::5958:e64b:fe79:d386%3]) with mapi id 15.20.7698.024; Mon, 24 Jun 2024
 11:18:31 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>, "leon@kernel.org" <leon@kernel.org>
CC: Paul Blakey <paulb@nvidia.com>, Vlad Buslov <vladbu@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Chris Mi
	<cmi@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [bug report] net/mlx5e: Implement CT entry update
Thread-Topic: [bug report] net/mlx5e: Implement CT entry update
Thread-Index: AQHaxicMLRaWW44jRE+EzplOmcY5YbHWxC0A
Date: Mon, 24 Jun 2024 11:18:31 +0000
Message-ID: <5b69b639df7dc88103f5d8c6fbeaa00b62c27c6d.camel@nvidia.com>
References: <74076270-8658-4773-aeac-e99d11acea7b@moroto.mountain>
	 <20240624110915.GF29266@unreal>
In-Reply-To: <20240624110915.GF29266@unreal>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6843:EE_|DS7PR12MB5958:EE_
x-ms-office365-filtering-correlation-id: 6104f405-e58c-4c35-5b2f-08dc943f611a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?NUg5OXhIeDZXS1JiMGpPS25BTDFzUThJd2NucVhGR0RhbS9PQTNIOGpiaFZF?=
 =?utf-8?B?UEYrNnM5Zm9lWWJENHFRLzZOMTE2SFE3Vk1RSmZOTHlHTlFaZ0xidk9NSTdB?=
 =?utf-8?B?Q1dndDBRYnM0cUlnQjhPZ0t2VzV4eWxldTY3V285dnpJVW9FeDk2OFlVa2hS?=
 =?utf-8?B?b3VkL0k4UEFIMkxBTk9qUTBSK081S0VqOGdaUW5xK0d2bmMyL1ZEVCtUSHhN?=
 =?utf-8?B?ZGE0eEVpaFFmNE1XeTJVdDl4cXZOTTgvS2hITmxkdGV4UW1uMGh3d2U5VnNi?=
 =?utf-8?B?L0pCMnNOVXBUbzhzWEN2Q2NsbnNkMkNZbW9qMmg4eHRtM3BmbzZIZjgrU0Fi?=
 =?utf-8?B?RWdkeTc1cWdwTWxxQklPTCtLQmxpRkYxVThOcUhhNENhaU56Q1NOSklhSlZK?=
 =?utf-8?B?NEZIaWN3NmgvLzBTQk9SMlo4WXpBNlVtODBQYWVuVHhTWWMycmhWSXFGd3F4?=
 =?utf-8?B?cHJFTkZtNVlhY01waE9FZHRXdUYvY2RhWFNGZGczZ1hydjJMTHh5aytiOThK?=
 =?utf-8?B?bHJnS094NkxhMDRWQnhsdFErR1N4a1RvVHhpN21jcE8xZUhyd2lCZ1BtRU14?=
 =?utf-8?B?ckVQdkd0TkFtMVkzcytaMkNmQ2JtdWNDNm5YbGkwLzBJTTdZSzU2OGllTG9s?=
 =?utf-8?B?bExJQnEySnhmMkplL1VIRzlTVWxDTGV0eU9USS80SEgyNHAwK2VPZXVIejRs?=
 =?utf-8?B?bXFPOE5WM1dnaEdpZGxjS2hqSjQ2SG5aTk9ZajZMck01SlNoQzcrb3VIOFJq?=
 =?utf-8?B?ZFdkK3N1QkJUZ3R1YS9rUklTdzJkanBvZlRnTW9PVUFRMnFwaEhMMmVXVDU4?=
 =?utf-8?B?M0RTVzdFTWMxWk5UTTFmS0tmK1pJY3l4VTZLQ0NiMWE3VFBPejVrcDZMUi82?=
 =?utf-8?B?RlJvZThGNTM4SEFpRkNZM3dVZE83eDRlV3VraFkwVDNUSWhQdlRwUHM0RHdp?=
 =?utf-8?B?anhnSDZGMmEvR0ZsWWhvNVgvamo1bHVkT1dBcWVIYlpTMG8yb0hYWEFvOVVF?=
 =?utf-8?B?NXc5dTFNNE9iZjRxZG55VjA1K2lBd2dtTDBjc2dCaTRFMzVYdndFYkFndEh1?=
 =?utf-8?B?cmRlcXprN1Q4NXViRjJMbHA3V0Ric0drS2U1N1BmSlRiVEJsSWxMSTdzUEdJ?=
 =?utf-8?B?YWZSOUNYbDhxZG8wb2p0Z25JQ1J5T3Uvd3A2eHhqYlhGdkwwQmM1R20xbUZp?=
 =?utf-8?B?L1A5c3N4NXljL2J5bHNzakoyVU5LNjFyeWt2RHZra2dOMUxGclNzZUt3VzI1?=
 =?utf-8?B?dUxnOEVGL2VLMFhuOVFWcWNpcU9RVDhwbkxGTlNyUWZZTEpKa3FweUNjbEg1?=
 =?utf-8?B?WDNOOXRwYlR6UDBWZjl1blBmeVV0TkJjYUd6Rk1ySWZUU240M05tTlVpOGlj?=
 =?utf-8?B?eTF5c3ZwajZNdFhQaDRnakpGdEVSTHhJbmJKbDA0VzFNQmFVRkc5WXY4akZK?=
 =?utf-8?B?K203RDYrL2JHVXFXd1RtK2FLWFB3Y3BvRkQwZ3M1UW9jQUVCWmNFVGVNS0hY?=
 =?utf-8?B?KzBhdVdnRnVGUnBCSUtCWG81N2NxWDFRVmMzVmZ4SEh6YVdXdzRQMVBIbTFs?=
 =?utf-8?B?Q29qaWVGYlZOMVNFdEdGRjBkRXVtUkZwMXk3VTdWUURwekkxSmJLeDdwanZt?=
 =?utf-8?B?b0pyVkwyUWpCVnliMDN4bGRhakJPTHNjVll3WkFjSnZieUd2aGViWnN0OXM5?=
 =?utf-8?B?ekNRMHM5ZWpPSlNESVlyZFhVUlBRZmJvT2N0ME5ZcDlueXBVaElYdVh3K0lD?=
 =?utf-8?B?aU5oYmxKUDJvOVpMa1l6UHEvaWtPRHZpNTJtV2dlTEh0L2tYRXkyMklJUk9p?=
 =?utf-8?Q?s1qJTnxY9w7AkxvWNkYjA6WjEzgFmnExqfS+8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VllKRndFWjZzbHMwNTUycWt6ZFdiZUhoenNFenNIdXo2SWdFaU1ERU45V2NN?=
 =?utf-8?B?UnJ4NUZLZnU0S01WM2VqYmRFUHBkUk1sSjd3UGdMRm9HSDNpUkVLZGxnTVF6?=
 =?utf-8?B?UFUvZGVEMHV4NjJUMENhLzNyZGFRYWpPY2VMOXFGZkVoeUcvdWlXbnU1Zm1I?=
 =?utf-8?B?RzlJVmkyZ1AwZFRvUTlsZjBVbkRzRzJjQ0JOYjYwd3dVaXZMYWZPOXJiTW92?=
 =?utf-8?B?bnZyN0tVMDlFY0x2RXBPM1RaWmZwRkFmV2tXa3N4QTg0SE1PMjJ3b1VzS0JM?=
 =?utf-8?B?UDFtRWhGUDJ3ZDlRVkdKZ3NaVm00SzJuOXA3Slg4MWZHR0FKZFN6Zjlzb2E5?=
 =?utf-8?B?OXZiNGFEcWU2RWIvL3orTTVjR05KNHphR2lscU1LS29aZjRHNmE2TmNkVGNi?=
 =?utf-8?B?a2huNUU2SStyY2FmbE5nUFRIcnRPQkdQd08rb3VnRUZoS2VJZkl0T0NpeTla?=
 =?utf-8?B?azJyNTc0cnp1elJNNzR0TmhtTGI3aTJLdFd2c3NESWwwTGw4TGViYkoxaUZY?=
 =?utf-8?B?WSttKzRWNEp1NGpYb3dyMjEzdDZZR2czbmdMWjBvaWRQWndzRmZIcUhRQUpD?=
 =?utf-8?B?aW02UTQvSGNSYnN0Y3dicUcvdkxGSXhqdXowSkd6elc4UGdoaWF3R1dSL2hQ?=
 =?utf-8?B?aGk4T2VyeGdJWGFiN1JiaFBheUR6YWZlNE1yeTF2OUcrWElZa0hCT0pCL2RM?=
 =?utf-8?B?U1hMS2hPcExSTnBmSXJGZWt5S0Y0a1Y0WDFjckVqQ0JKTE5DZ2VoYko1NmI1?=
 =?utf-8?B?R21IZlYyc1FkdDZCUzgrcFZqLzB1Q1RTenk2RkQrN210K2E4UlhKQVFZcm5w?=
 =?utf-8?B?SjBGVzhqYy9LYlpWdTBPWUJiRjJaanFKQWhKdUNUd2VhREVyN1JZSUlDU01v?=
 =?utf-8?B?ZkNYbGhnOHJjTEFFS2FhYTk5UTErRXlydjEvMlpnY2pQdUt0MmFmZmNRc0tI?=
 =?utf-8?B?Nmt3eTdrNTIvRllzTmJSaW9GNmtpSE40L3MxZFVyUjVIamxEcnFTOUN4NUF4?=
 =?utf-8?B?TGRZYXU5TVBlMVZuRk9EeEdBRlRnMUVlOUdqWmcybFdySWp0UXh6dy96MlB1?=
 =?utf-8?B?ZzRQU0R0K1ZCcmh6Y0JiS05DTXJUdDdvWjBZcEt5a01ob1pFMG9mSGt0U3Vl?=
 =?utf-8?B?T1dHWUVPMk4reG0wdkFxZ1FoSXFhRW5COTY2aStIcFJ4Y1I4L3htWjY2aGJo?=
 =?utf-8?B?SWxJeFV3aGlhMkNsaC9jbmxXckxPMytmUURPY1gybGZjZzdpSlkvVkZjN09h?=
 =?utf-8?B?U0YyRFdQSzFaNllqVDRLYUU1WUtMNzlPSlhITmNVWHkxUVBFV002TDVPaEN1?=
 =?utf-8?B?R2hKWjBGWTBRZ0RLb1o0eXdEeHFNSVU2WWNhUlREeVhncFR2azVlbkNsbEpQ?=
 =?utf-8?B?WEIwM0pWeEcwNUZ3RERIell3SEQzNmZOZmFiU3Nuby94WFEwa1BwUmV0eHd2?=
 =?utf-8?B?SiszVTVPeWtQNTkxa05NVXFmcnJWTmgzMk0xY0xNMDJWbUE0NW9pVlJNY0N6?=
 =?utf-8?B?TmxSMU42c3VpeVFWUHkxbllLUHAzdHdtRXgybE85L3dmV0pjOEcxMFFaOXdp?=
 =?utf-8?B?ODd2VGpKRVdPQ1BhT2trMFlxWEE3cUM1b2xrazE0WWRWZGhaNElmUDUwZm5S?=
 =?utf-8?B?Tkd1UUNNdE5jeVdrY3N1QXdXaE4wRUQ4TzdLem9zSm94K2pkaWxHcEVNL3pY?=
 =?utf-8?B?djZYZ2lWY2RJOXNjVk1FOHlNM0tnZFF3cEQ0VmhlOElYTkZBSDk0ZzVqZDBR?=
 =?utf-8?B?VkRsSno4WkFTdUVyWTBCcUhDOXorWWppaFJ5S1ZrTW5qZktBTHgrL0t5SldZ?=
 =?utf-8?B?N3EvazMxVGlVdkRnaWZFanVSdTlRR24vUUViUmtDcVVKWjY3MTJ5aGtXcWk3?=
 =?utf-8?B?aStZRXpUaCtVVFNLbkxWa0d6R2NyWXp1VWV5WW5iczhrSm1aaXc1TEJLNytM?=
 =?utf-8?B?QmMvbnU4Y1k4R2ZhOTAxYUdYT09ySXk4NFlUaCtoWXhWWHpaR1pnTTRDMFR3?=
 =?utf-8?B?UDhXM1dUVTdNRkxnbXpTRFdrZ0VUUmxIMXhpZVVNaVNnUVZXbFBMSFVvM3RP?=
 =?utf-8?B?SFBQUHRobEFINzRyelo4TXVyYVVLOW1YZTFUM2ZobGduSzJyelZMdkFPbU5t?=
 =?utf-8?Q?srGf+7obsanV3Ev2m8/p4aq5M?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1A44608CE422142990950839A560597@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6104f405-e58c-4c35-5b2f-08dc943f611a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 11:18:31.2124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0kogIOduCnUYIC7gUaVtrLC4RuYJ2hyd3isGc2CFsv9AlxO/y7AMZ01g+AuAb3IOvcV1yVJIX/qoqohzg9D1XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958

T24gTW9uLCAyMDI0LTA2LTI0IGF0IDE0OjA5ICswMzAwLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6
DQo+IE9uIFRodSwgSnVuIDIwLCAyMDI0IGF0IDExOjUwOjMzQU0gKzAzMDAsIERhbiBDYXJwZW50
ZXIgd3JvdGU6DQo+ID4gSGVsbG8gVmxhZCBCdXNsb3YsDQo+ID4gDQo+ID4gQ29tbWl0IDk0Y2Vm
ZmI0OGVhYyAoIm5ldC9tbHg1ZTogSW1wbGVtZW50IENUIGVudHJ5IHVwZGF0ZSIpIGZyb20gRGVj
DQo+ID4gMSwgMjAyMiAobGludXgtbmV4dCksIGxlYWRzIHRvIHRoZSBmb2xsb3dpbmcgU21hdGNo
IHN0YXRpYyBjaGVja2VyDQo+ID4gd2FybmluZzoNCj4gPiANCj4gPiAJZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuL3RjX2N0LmM6MTE2MyBtbHg1X3RjX2N0X2VudHJ5
X3JlcGxhY2VfcnVsZXMoKQ0KPiA+IAllcnJvcjogdW5pbml0aWFsaXplZCBzeW1ib2wgJ2Vycicu
DQo+IA0KPiBUaGlzIGVycm9yIHdhcyBpbnRyb2R1Y2VkIGJ5IHRoZSBwYXRjaCA0OWQzN2QwNWYy
MTYgKCJuZXQvbWx4NTogQ1Q6IFNlcGFyYXRlIENUIGFuZCBDVC1OQVQgdHVwbGUgZW50cmllcyIp
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDYxMzIxMDAzNi4xMTI1MjAzLTMt
dGFyaXF0QG52aWRpYS5jb20vDQoNClllcywgTGVvbiBpcyBjb3JyZWN0Lg0KV2UgYWxzbyBjYXVn
aHQgdGhlIGVycm9yIGluIG91ciBzdGF0aWMgY2hlY2tlciBydW5zIGJ1dCB0aGUgcGF0Y2ggd2Fz
DQphbHJlYWR5IHNlbnQgdG8gbmV0LW5leHQgYmVmb3JlIHdlIGNvdWxkIGFsdGVyIGl0IHdpdGgg
dGhlIGZpeC4NCg0KPiA+IGRyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9l
bi90Y19jdC5jDQo+ID4gICAgIDExNDIgc3RhdGljIGludA0KPiA+ICAgICAxMTQzIG1seDVfdGNf
Y3RfZW50cnlfcmVwbGFjZV9ydWxlcyhzdHJ1Y3QgbWx4NV90Y19jdF9wcml2ICpjdF9wcml2LA0K
PiA+ICAgICAxMTQ0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZmxvd19y
dWxlICpmbG93X3J1bGUsDQo+ID4gICAgIDExNDUgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHN0cnVjdCBtbHg1X2N0X2VudHJ5ICplbnRyeSwNCj4gPiAgICAgMTE0NiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdTggem9uZV9yZXN0b3JlX2lkKQ0KPiA+ICAgICAxMTQ3IHsN
Cj4gPiAgICAgMTE0OCAgICAgICAgIGludCBlcnI7DQo+ID4gICAgIDExNDkgDQo+ID4gICAgIDEx
NTAgICAgICAgICBpZiAobWx4NV90Y19jdF9lbnRyeV9pbl9jdF90YWJsZShlbnRyeSkpIHsNCj4g
PiAgICAgMTE1MSAgICAgICAgICAgICAgICAgZXJyID0gbWx4NV90Y19jdF9lbnRyeV9yZXBsYWNl
X3J1bGUoY3RfcHJpdiwgZmxvd19ydWxlLCBlbnRyeSwgZmFsc2UsDQo+ID4gICAgIDExNTIgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHpvbmVfcmVz
dG9yZV9pZCk7DQo+ID4gICAgIDExNTMgICAgICAgICAgICAgICAgIGlmIChlcnIpDQo+ID4gICAg
IDExNTQgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4gPiAgICAgMTE1NSAg
ICAgICAgIH0NCj4gPiAgICAgMTE1NiANCj4gPiAgICAgMTE1NyAgICAgICAgIGlmIChtbHg1X3Rj
X2N0X2VudHJ5X2luX2N0X25hdF90YWJsZShlbnRyeSkpIHsNCj4gPiAgICAgMTE1OCAgICAgICAg
ICAgICAgICAgZXJyID0gbWx4NV90Y19jdF9lbnRyeV9yZXBsYWNlX3J1bGUoY3RfcHJpdiwgZmxv
d19ydWxlLCBlbnRyeSwgdHJ1ZSwNCj4gPiAgICAgMTE1OSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgem9uZV9yZXN0b3JlX2lkKTsNCj4gPiAgICAg
MTE2MCAgICAgICAgICAgICAgICAgaWYgKGVyciAmJiBtbHg1X3RjX2N0X2VudHJ5X2luX2N0X3Rh
YmxlKGVudHJ5KSkNCj4gPiAgICAgMTE2MSAgICAgICAgICAgICAgICAgICAgICAgICBtbHg1X3Rj
X2N0X2VudHJ5X2RlbF9ydWxlKGN0X3ByaXYsIGVudHJ5LCBmYWxzZSk7DQo+ID4gICAgIDExNjIg
ICAgICAgICB9DQo+ID4gDQo+ID4gQ2FuIHRoZSBlbnRyeSBub3QgYmUgaW4gZWl0aGVyIHRhYmxl
Pw0KPiA+IA0KPiA+IC0tPiAxMTYzICAgICAgICAgcmV0dXJuIGVycjsNCj4gPiANCj4gPiBJZiBz
byB0aGVuIGVyciBpcyB1bmluaXRpYWxpemVkLg0KDQpJbiBwcmFjdGljZSwgdGhlIGVudHJ5IHdp
bGwgZGVmaW5pdGVseSBiZSBpbiBhdCBsZWFzdCBvbmUgb2YgdGhlIHRhYmxlcw0KKGlmIG5vdCBi
b3RoKSwgc28gdGhlIHVuaW5pdGlhbGl6ZWQgZXJyIHdpbGwgbmV2ZXIgaGFwcGVuIGluIHByYWN0
aWNlLg0KUmVnYXJkbGVzcywgdG8gZml4IHRoZSBub2lzZSwgdGhlcmUncyBhIHBhdGNoIGFscmVh
ZHkgcGVuZGluZw0KdXBzdHJlYW1pbmcsIGFib3V0IHRvIGJlIHNlbnQgYnkgVGFyaXEgc29vbi4N
Cg0KQ29zbWluLg0K

