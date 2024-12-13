Return-Path: <linux-rdma+bounces-6512-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38B59F0D97
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 14:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3FC188CA5D
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 13:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA291E049C;
	Fri, 13 Dec 2024 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HHTBGRER"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D49C1DF975;
	Fri, 13 Dec 2024 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097372; cv=fail; b=IVpxmpaq25F9nB1HxuttUV0K+7r7LGlrlUNhmy9CWyTrl6XAlnfUnDMDix6hrkGO4woBCaEpAeU6vls4mBwMsEzZVvdi54maNiz8pnsVxRJPrkwpG+ikRXCv5taJXJjEV9onhrdw/BG59W1dX9TjcMGNSzud3MU6lJxOXpECgjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097372; c=relaxed/simple;
	bh=y68QmUVV4X+C7ft0meIAESsxjq/vFUiQyHZsHfJS76Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ELdimWf6ORFMpBSZQrlT5mC2DQWUlwhyZpRK/3Ga24KmG5+FnkK9gkbKBe5Q0S6UQAMVxsYqxPMBoS4XCkBL7Oa7ub8LwWCZ+G41LTSUFmQcK0qmXdRiKaIazJUbKB8sJfcMCf4mAUX1vtI+Vz8BcHdbzeDeLm261IaKN3+8S1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HHTBGRER; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEADVx1RrgkWPx14Au8GZVeLrolho4kSMdZacJb7aDRNV7clFtyc00LCz9DJCBk0EKO9f7DBz9GghLsncrzaCFDX5aFT3CyoB1XHeiXVN1wapywcpt/mkFwc+qse7GD7XhcHvI/fSb2m7iUfE3vLUOioky5zrXowH5gr0SERF2P5oUY6Thv9ue0Uw+LAKNQ2GDoMJbSJ+2rwqzwxLlh7zrauQFM4p9AY1gcHWlP2J4rMno8G2CyJ1Q0upzKbkCs8CZDdJgBsFIizYVlbkPXntJUsmiPkW8yU1OVRaRfpqgvdJ9PYNidSnibDdXFqktIVhEj9OoQJK127WP0u63HAZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y68QmUVV4X+C7ft0meIAESsxjq/vFUiQyHZsHfJS76Q=;
 b=NBnbLoSaZyZn/+tt9yRmAXbse2Nvh83Q451JTjrfet+2H4PuRmHbrvs3v1SPk8jIczkIQKGoOoy80A6KwRGzMJ5Hjtdvn5LCqpkhvlUM4LEBOREEQFfElP1RiA4WmIhgRAe0ZjyC4Gb89iCBnfQBAljvuhoOOcD2o2N4k2CM2iryuyaErPz/YAoWVVZQAlVP7ykm8hzKDXleVHJ+I545RcXukqGZk2Qqbyt8xXGLfd1ZbfiZmJrKtte6kqp/8yrSTRUMIllL2E9/bk7k/j2hQucS2dhEpB8oDMzXmuHXMGvKjs7lmxg81R03wkHaEd6J99uJ15xQjbLh+VNy48EYFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y68QmUVV4X+C7ft0meIAESsxjq/vFUiQyHZsHfJS76Q=;
 b=HHTBGRERq4rn79JQEQl+mDFET4Z9EliV4oDNr3ps37fkVaBSswwy7LLMT2VU5UGtvGwlPUEdBCKWkZXLkoUcGQlXrLgBS5uIwIXIXu7IPzvkRKwGkRJZvLEvCLNGuAs5x0ADjOzmMRX69Dqk9v3849dJTCs1EoEajCBAKk0f1Dyn02euMTxZuhB040isG0VPkpuU0Q3ZooKBvk3WCEDA6KYD/+1SrX4CBFEqUqT+yrAJJTfhhLYryoxMykyr28QhiolgvxyquG2ubk/K93PCyEMbU9aWF0otT/OCSkGHFh/VuzhcLF6iYGmheW6BtXDkNE/LlZUojbthY+kOtHGA5w==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 PH7PR12MB7937.namprd12.prod.outlook.com (2603:10b6:510:270::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 13:42:47 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%7]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 13:42:46 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"ttoukan.linux@gmail.com" <ttoukan.linux@gmail.com>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "jiri@resnulli.us" <jiri@resnulli.us>, Leon Romanovsky
	<leonro@nvidia.com>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next V5 00/11] net/mlx5: ConnectX-8 SW Steering + Rate
 management on traffic classes
Thread-Topic: [PATCH net-next V5 00/11] net/mlx5: ConnectX-8 SW Steering +
 Rate management on traffic classes
Thread-Index:
 AQHbRpmNrHzTfY3l9kW9Sl/INZi8E7LaDhaAgARGzICAACQugIACXauAgAEMU4CAAlmFAA==
Date: Fri, 13 Dec 2024 13:42:46 +0000
Message-ID: <73d7745697a9ab7507c5e4800b0dfc547823d475.camel@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
	 <20241206181345.3eccfca4@kernel.org>
	 <d4890336-db2d-49f6-9502-6558cbaccefa@gmail.com>
	 <20241209134141.508bb5be@kernel.org>
	 <1593e9dd015dafcce967a9c328452ff963a69d68.camel@nvidia.com>
	 <20241211174949.2daa6046@kernel.org>
In-Reply-To: <20241211174949.2daa6046@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|PH7PR12MB7937:EE_
x-ms-office365-filtering-correlation-id: b391eb62-fb0d-4e8c-095c-08dd1b7c072c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZmFaMVFLajVKODMrZjJGVnFWcEZsWHREeVJXWWpGK2hnbm9VK2ZjYjhVMy8v?=
 =?utf-8?B?SFlWY2h4NkU3REtiQ3NtbGd6WFdYbXg2UU5oTWhpaDNDOUNQdEVNYW5EVzA2?=
 =?utf-8?B?aWdXakdOS2Y5aWJ6Sm9DVFBSeUZycll3aGVUaTBIWVNZc1NGYVV5ZlBGSFlB?=
 =?utf-8?B?ODJ0U1kyVE1WOHhQbVYranVpSVpaWk5VTHQ0QVRYMzJhdE1Rc2NkQjJKUUxP?=
 =?utf-8?B?VXE0b1c0cFhqSExiT3dtTzJOM3BSQ0I0WTFIK2taRlRvV0IxNXRtKzBkZDFK?=
 =?utf-8?B?MTAxMzZwQis5cmxaYUtSYTA2K0pHOTFBYStvRXR0bUJ6bk1qSWRjR0Z4Y3g3?=
 =?utf-8?B?NGpUSTdTTG9WMmpnR2xhbVZDV3FrT2t3a3VLOGNJTFhVcnlzU1g0NGF5aWdN?=
 =?utf-8?B?bGpjei9XUitsVS9aNXd5RDYwc2xnQTRYcHMyeWNPcGk0Rm01RDg5WFQ4d3Zq?=
 =?utf-8?B?ZitRTGROSkFmL013N1NpZXpFZS95d2pvNnZsRUpzK0RIVXFxSU5tOVphQ2Yz?=
 =?utf-8?B?WXZWL2huRENxRDRlRDNBUkhHWlUvTEczVzJ4T1dOU1Q5TnpuL01xQ0x5WVFX?=
 =?utf-8?B?dzVPUTY2c3J5VlRzV1hnek80MXgzaWZnWjlhWkp4VHRaWHczNE8wMy9UNXRO?=
 =?utf-8?B?a21qZDJ2VEhKaUN1a2ZtUEZnMERtMG5YczhheC9DaGRBNk1sQmlpNm1HYmIw?=
 =?utf-8?B?S1BGelZVNUhFQUxVbzhBeHQvUTJqd2FJbUZmSzF3NmlJRUdmang4U0RPcXJM?=
 =?utf-8?B?ME90bUxrSHR6eEFYeDNlV2RMWVZObzM0QkEvazJ6ZnVpZWJPUWZkb245R3J0?=
 =?utf-8?B?UUxpMURYK1ZYcE42ZHNUblRNUmVGVXNsT1Y5S3NadWJ6cG5CdGI4NGFtR29m?=
 =?utf-8?B?M0doQkZXenNnTlZVSWlOdUpkRWlIR1ltK1JzMnM5ZnRhcWxXd24zNzZhbHFz?=
 =?utf-8?B?M0lzT05VK2ZDcWo2VHNaMktEMStFTUFyN0pJRDAwcU9ybG41YzNIL2FpYzhw?=
 =?utf-8?B?L1JxY1Jhc0FVdWRMMHdyWURaN1VpS1ErYWllZzFuQ05xOGs1akRrSWgyNDFR?=
 =?utf-8?B?dDRiVXFiOFltQkpLcHR1UjFLbVJhOU54RmU4WHZnU1NCWDh2OSsxUW5vTzJh?=
 =?utf-8?B?WllDRmZub3J6MFpwU0k4Qlo2SmUrb1k2OGNGS3NiR3pkZGdtMlJJVkNmcmhE?=
 =?utf-8?B?aDlWYWJQamtwZERadXJlOUtuVndqWTZrcm5kdGtYYVV1d29SUUU2MjdiYWpo?=
 =?utf-8?B?RTVjL2VqYmtXYkNjUnhPamdsSFUxTC9Ic004MXRsVy9EWXYwdmdaQTFXdGFn?=
 =?utf-8?B?NWJOUFd4MDh5UzdOd2xnNVBXb295REJUbCtzdzdPdy9JZWRKNGltUTlNdmlm?=
 =?utf-8?B?RkVjMkZaSVRoV28ySTBSd3hxN09IbGkyaFRMbzBhZDlQdFRZN0lHT2RBaHFH?=
 =?utf-8?B?Yml4cVZ6NGFTOHdCMExqeDFMMHdOUGlaMW5yM0pCdlRSSTM1ZTBSdCsxWHhQ?=
 =?utf-8?B?QWVQbFVIb3BOZXo3WE5HbU1lMlBtbWxKR2dvUGFlbjlMZTZ6ZE55OHFnWjEv?=
 =?utf-8?B?SllkaVRMbHZkT2M2NnFwdDk4dnA1SU45N1M3cUlDS1BTV1YvdHhraXJTWjNS?=
 =?utf-8?B?UkFEeWRacHRtV1FtaDU4QnhBK1I5ZGlyMzk0ODBPNGw4TlBZellobXdaakov?=
 =?utf-8?B?TlFUdGhBemJqVjZEbHl5ME10aGw0VE0wTWVzazl0SnoyUGdFWWNjZmtpUDdX?=
 =?utf-8?B?dWpRZmtJbVhVNHh6ZVgxSTlpdWFPVzFjN0Q3bkNxd3ZvdmdmQmR5MWRQOFVi?=
 =?utf-8?B?QlNWZmUzZ0h1dWdBTTJ2THcwL2xUbzVGT2FjL0lpZndkVys1ZVNZckVJbit5?=
 =?utf-8?B?bDJpWXpBVFlQZXQzZS8vSHBvZXBjb2Z4b3d2MGRDZzdOUHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L3Z6cVJGSlE2MmZ2RXErNXgzMjd4aDRNdVU1UTVVL3JlL29YWmZqbHFjNnZE?=
 =?utf-8?B?SzdrV1RYdnhmVzJDWkUvRXhwZDJUVnZaaElRNWlYaENDL2JGeU1VZ0NPRERS?=
 =?utf-8?B?YmljTDZxdDNtSXZ1L2pZYmx1TWJxdzA5TFpoaytVMUoxbUpVVUNHUWxSOFNy?=
 =?utf-8?B?WFQ5dTNKSGxDUHlyTDB3ampGcDhxeERySFJnQmtXZTh2N2t0ZUtaMG42MU92?=
 =?utf-8?B?Zk1Xb3hNa2NFdDh2eERJTEpxdC85Q2hPNmhsYWlyVUl5cmRBSXZ5aFZMYWVr?=
 =?utf-8?B?SE1DRy9RYmFhQlVyTGJjcEc0aFlsdGxPNTgwWURJY3lESExYZ2FoS2l1a0lJ?=
 =?utf-8?B?TzY5ekRtL2JwZVc2R3NENWUzeGRNcHU2bTRNTWErYmFRczEwT3NlMUM5TnFE?=
 =?utf-8?B?ZlE2SFR6c3l6NFc0c214QWE4SkYwbEtkYWVqcUE5NVptMTd5RVJ0U0FabnQ1?=
 =?utf-8?B?UktiN0VQMXEzc0JyNmtYckRnREVUK3ZuSWNhYTVhWGsyWnY0K0lUMVEwd2ZM?=
 =?utf-8?B?MFp5cVovamZJQlExaUpYYVdIbWU1cXI0ZExmMHQyakZmNE9hWllZblVsaGxa?=
 =?utf-8?B?eVNEcUF4bGo4MGJoSFoxL3dPLzJrWXVRTG90NExPUUFQdzJFNkVGVnF5cHMz?=
 =?utf-8?B?V3oxNGw3R0p0eSszZEtnNjdOck5UL092UlNEWER3cCt1N0Z3TGxXQ2NqMU9h?=
 =?utf-8?B?L3p1UmowaHFvdmRxZTV5aXoyMjdEdDhkSHNHLy9vV2lUcVh6NnByM1FUa0JX?=
 =?utf-8?B?WTNnUDhiZzNidU5RNEFkRjZqNUthVjdMeml5YlRGZC9tNXRlc28xNUlyNU5k?=
 =?utf-8?B?VEVSaHlpVC85cjAvL2ZDOXdDVFFmR2tFSnZxdFU0dFNVbDQvOGtWUzRNSGJ2?=
 =?utf-8?B?OEo3REx4Rjg5NjArQmRLa09ldjJ1dVp1bnhUWkhxbGpiVnR2U2VsSXJPNitJ?=
 =?utf-8?B?Q0R5L0ROa0svYTRCY3dxSWVNTWppaXpZcGRuQ2JSVFBEMmM1WG5tWnlXSnEv?=
 =?utf-8?B?dzNJNXBIZSt4aU5HOG5Wc3NycUZLU2huT0IyQUx5a0VuQnZYRmRPRHdsZi8y?=
 =?utf-8?B?cFVNRW96V1p5QTNXTGdiTW16VG1PQ2VPbktERWU1MytyWG8rMFhJOTYrV1R6?=
 =?utf-8?B?UTI1cHN5MTZrQkx1RVNOUk5WZDB3N25mZ0xwblAwOUFiZzdRd2ZnN1gwa3lH?=
 =?utf-8?B?OEM1ajFjY0tZMFppcWIzdVR3bThrdlpnMWc5dUMwemRYaWlTb251WWdUMDdZ?=
 =?utf-8?B?SmRHUEtQdjJZR1BuS3ZxTHNCSUZwcHNTQmVuTUd3dzBIWjNkK2xoaEtiVUpx?=
 =?utf-8?B?VUhLSFIzd0hZQlZ2MHoxUFB6NWIzaU9LYzBQdXZoK0VEZXpSZ2g4Sisya0Yy?=
 =?utf-8?B?M0dvZ0hHVnFiNE9WZyszZkQyMjZpQ1YxeHBnSFJQdWZ0MGRnUmljRThManQ4?=
 =?utf-8?B?R0NHOXZqVW5rKytzcEVJejZFTWhYRUEwRXAvMGd6SFNFUEhJdEJVV3k1dkRF?=
 =?utf-8?B?UXBsemJxS1ZhbUl2Z3cvRU1XS2NodUF1cmRuc2tJRkFjVUs3NG5yMUozRDVM?=
 =?utf-8?B?cCswMFFQcEZ5OHNQRjJCc3N2WjBCb0NTOEpTOHpxUndRZTFqQlB3SGNtWUdZ?=
 =?utf-8?B?aVpVcGJPT0JoZWdXTlczMXU5dlQxejRTZzIya0lzMzBCVHJmdXRhQ2g0cFVj?=
 =?utf-8?B?czFtRXdkb1FCbnB1bTdqQmZ1eE1aTEZEQ2NmOHBLN2dhSWQrRjVDbHFIcERN?=
 =?utf-8?B?bGZXdjIwdW5wMzZMZzBWMjhDUnlsUnJPN3Jnc2ZCT3c2TFZnUHo3U08rRldz?=
 =?utf-8?B?ZDFuNVVEbHhWOFpTMlBqSlBKcUt6ZGhoc1MzNDVxNVN5aTI2ck5DNjdRNFZy?=
 =?utf-8?B?RStiNE1ubFc5NGVCby9SWFBQSzhDWDlnWGluWkszaGEzcFYzTm9BZnBUSDRL?=
 =?utf-8?B?Z0xCQktKUTVzVGpZU082LzF0aEM1Zm85eENVR3BwbFQvNmJWK0xSbFl5djBT?=
 =?utf-8?B?R2JzVTBJc3NiRit4bEVxS001bUZ6NnBkSUdqdmh3Q2RMby9NcDVxaGpMSEM1?=
 =?utf-8?B?WnlMYXZXOXY0MWhUczBjblBMbW14azJmNytzall4OUhUS2lManBuSXUzazZn?=
 =?utf-8?Q?LtQxDvQ8rKHN2voQ0blaIHbyg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1AA4B5E1C92854CB62D5897166EA372@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b391eb62-fb0d-4e8c-095c-08dd1b7c072c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 13:42:46.6299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRZOkoCdHUFXlLj8S0otXILOiw6IL3jVJYJm6KhWW7Z6FiNkBFILyGU1Unax8OQSqjYZmKsoKXsLX8UOMTJy6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7937

T24gV2VkLCAyMDI0LTEyLTExIGF0IDE3OjQ5IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gV2VkLCAxMSBEZWMgMjAyNCAwOTo0OToyOCArMDAwMCBDb3NtaW4gUmF0aXUgd3JvdGU6
DQo+ID4gSSd2ZSBsb29rZWQgb3ZlciB0aGUgbGF0ZXN0IHZlcnNpb24gb2YgdGhlIG5ldC1zaGFw
ZXJzIEFQSS4NCj4gPiBUaGVyZSBpcyBzb21lIGNvbmNlcHR1YWwgb3ZlcmxhcCBiZXR3ZWVuIHRo
aXMgcGF0Y2hzZXQgYW5kIG5ldC0NCj4gPiBzaGFwZXJzDQo+ID4gYWJpbGl0eSB0byBkZWZpbmUg
YSBncm91cCBvZiBkZXZpY2UgcXVldWVzIGFuZCBtYW5pcHVsYXRlIGl0cyB0eA0KPiA+IGxpbWl0
cy4gQnV0IGFzIGZhciBhcyBJIGFtIGF3YXJlIChbMV0pLCB0aGUgbmV0LXNoYXBlcnMgQVBJIGRv
ZXNuJ3QNCj4gPiBpbnRlbmQgdG8gc2hhcGUgZW50aXRpZXMgYWJvdmUgbmV0ZGV2IGxldmVsLg0K
PiANCj4gSXQncyBub3QgYWJvdXQgdGhlIHVBUEkgYnV0IGFib3V0IGhhdmluZyBhIHVuaWZvcm0g
d2F5IG9mDQo+IHJlcHJlc2VudGluZyB0aGUgc2hhcGluZyBoaWVyYXJjaHkuDQoNCkkgdW5kZXJz
dGFuZCB5b3VyIHBvaW50IG5vdy4NCg0KPiA+IFNvIHRoZXJlIGFyZSB0d28gdGhpbmdzIHRvIGRp
c2N1c3MgaGVyZToNCj4gPiAxLiBJbnRlZ3JhdGluZyBkZXZpY2UtbGV2ZWwgVEMgc2hhcGluZyBp
bnRvIG5ldC1zaGFwZXJzLiBUaGUgbmV0LQ0KPiA+IHNoYXBlcnMgbW9kZWwgd291bGQgbmVlZCB0
byBiZSBleHRlbmRlZCB3aXRoIHRoZSBhYmlsaXR5IHRvIGRlZmluZQ0KPiA+IFRDDQo+ID4gcXVl
dWVzLiBBdCB0aGUgbW9tZW50IEkgc2VlIGl0J3MgY29uY2VybmVkIHdpdGggZGV2aWNlIHR4IHF1
ZXVlcw0KPiA+IHdoaWNoDQo+ID4gZG9uJ3QgbmVjZXNzYXJpbHkgbWFwIDE6MSB0byB0cmFmZmlj
IGNsYXNzZXMuDQo+IA0KPiBXaGF0IGFyZSAiVEMgcXVldWVzIj8gTklDIHF1ZXVlcyB3aXRoIGFz
c2lnbmVkIFRDPyBZb3VyIHBhdGNoZXMgc2hhcGUNCj4gb24gYSBncm91cCBvZiBWRnMsIHNvIHRo
ZSBlcXVpdmFsZW50IHdvdWxkIGJlIGEgZ3JvdXAgb2YgcXVldWVzIA0KPiAoZS5nLiBncm91cCBv
ZiBxdWV1ZXMgYXNzaWduZWQgdG8gYSBjb250YWluZXIpLg0KDQpNeSB0ZXJtaW5vbG9neSB3YXMg
c2xpZ2h0bHkgb2ZmLiAiVEMgcXVldWVzIiBhcmUgYSBsb2dpY2FsIGNvbnN0cnVjdCwNCm5vdCBu
ZWNlc3NhcmlseSBjb3JyZXNwb25kaW5nIHRvIGRldmljZSBxdWV1ZXMuIEFzIGZhciBhcyBJIGtu
b3csDQpwYWNrZXQgdHJhZmZpYyBjbGFzc2VzIGFyZSBkZXRlcm1pbmVkIHdpdGggYSB2YXJpZXR5
IG9mIG1ldGhvZHMsIGFuZA0KY2FuIGJlIGVuY29kZWQgaW4gdGhlIElQIGhlYWRlciAoVG9TKSBv
ciBhcyBtZXRhZGF0YSBpbiB0aGUgdHgNCmRlc2NyaXB0b3Igc29tZXdoZXJlLiBJIGFtIG5vdCBz
dXJlIHRoZXJlJ3MgYW55IGNvcnJlc3BvbmRlbmNlIHdpdGgNCmRldmljZSBxdWV1ZXMgYWx0aG91
Z2ggb25lIGNvdWxkIGRlZmluZSBzcGVjaWZpYyBxdWV1ZXMgZm9yIHNwZWNpZmljDQp0cmFmZmlj
IGNsYXNzZXMsIEkgZ3Vlc3MuIFRoZSAiVEMgcXVldWVzIiBJIHdhcyBtZW50aW9uaW5nIGFyZSBh
DQpsb2dpY2FsIHJlcHJlc2VudGF0aW9uIG9mIHRoZSBwYWNrZXQgZmxvdyBhbmQgcmVmZXIgdG8g
dGhlIGhhcmR3YXJlJ3MNCmFiaWxpdHkgdG8gdHJlYXQgZGlmZmVyZW50IFRDcyBkaWZmZXJlbnRs
eSB3aXRoIEhXIHNjaGVkdWxpbmcgZWxlbWVudHMuDQoNCj4gPiBUaGVuLCBpdCB3b3VsZCBuZWVk
IHRvIGhhdmUgdGhlIGFiaWxpdHkgdG8gZ3JvdXAgVEMgcXVldWVzIGludG8gYQ0KPiA+IG5vZGUu
DQo+IA0KPiDwn6eQ77iPIC4uIGdyb3VwaW5nIG9mIHF1ZXVlcyB3YXMgdGhlIG1haW4gZGlyZWN0
IHVzZSBjYXNlIGZvciBuZXQtDQo+IHNoYXBlcnMsDQo+IHNvIGl0J3MgZGVmaW5pdGVseSB0aGVy
ZSwgcGVyaGFwcyBJIGRvbid0IHVuZGVyc3RhbmQgd2hhdCB5b3UgbWVhbi4NCg0KQW5vdGhlciBz
aWRlIGVmZmVjdCBvZiB0aGUgdGVybWlub2xvZ3kgSSB1c2VkLiBuZXQtc2hhcGVycyBjdXJyZW50
bHkNCmRlYWxzIHdpdGggZGV2aWNlIHF1ZXVlcyBhbmQgZ3JvdXBpbmcgdGhlbSwgSSB3YXMgdGhp
bmtpbmcgYWJvdXQNCmRlZmluaW5nIGFub3RoZXIgbG9naWNhbCB2aWV3IGZvciB0cmFmZmljIHNw
bGl0IGFjY29yZGluZyB0byB0cmFmZmljDQpjbGFzcywgZ3JvdXBpbmcgb2YgdHJhZmZpYyBjbGFz
c2VzIGFuZCBhcHBseWluZyBsaW1pdHMgdG8gdGhlIGdyb3VwLg0KDQpSaWdodCBub3cgVENzIGFy
ZSBub3QgbW9kZWxlZCBpbiBuZXQtc2hhcGVycyBhdCBhbGwuIFRoYXQncyB3aHkgSSdtDQp3YWl0
aW5nIGZvciBQYW9sbyB0byBjb21tZW50LCBJIGhhdmUgbm8gaWRlYSB3aGF0IHRob3VnaHRzIHdl
cmUgcHV0DQppbnRvIG1vZGVsaW5nIHRyYWZmaWMgY2xhc3NlcyBpbiBuZXQtc2hhcGVycy4NCg0K
PiA+IERvIHdlIHdhbnQgdG8gaGF2ZSB0d28gY29tcGxldGVseSBkaWZmZXJlbnQgQVBJcyB0bw0K
PiA+IG1hbmlwdWxhdGUgdGMgYmFuZHdpZHRoPw0KPiANCj4gRXhhY3RseSBteSBwb2ludC4gV2Ug
aGF2ZSB0b28gbWFueSBkaXNqb2ludCBBUElzLiBuZXQtc2hhcGVycyB3YXMNCj4gbWVyZ2VkIG9u
IHRoZSBwcmVtaXNlIHRoYXQgaXQgd2lsbCBhdCBsZWFzdCBhbGlnbiB0aGUgaW50ZXJuYWwgYW5k
DQo+IGRyaXZlciBmYWNpbmcgQVBJcywgZXZlbiBpZiB3ZSBzdGlsbCBuZWVkIG11bHRpcGxlIHVB
UElzLg0KDQpUaGUgY3VycmVudCBwYXRjaHNldCBleHRlbmRzIHRoZSB3ZWxsLWVzdGFibGlzaGVk
IGRldmxpbmsgcmF0ZSBBUEkgd2l0aA0KdGhlIG1pbmltYWwgc2V0IG9mIGZpZWxkcyByZXF1aXJl
ZCB0byBtb2RlbCB0cmFmZmljIGNsYXNzZXMgYW5kIG9mZmVycw0KYSBmdWxsIGltcGxlbWVudGF0
aW9uIG9mIHRoaXMgbmV3IGZlYXR1cmUgaW4gYSBkcml2ZXIuIEl0IHdhcyBkZXNpZ25lZA0KYW5k
IHN0YXJ0ZWQgYmVmb3JlIG5ldC1zaGFwZXJzIHdhcyBtZXJnZWQuIFdlIGRpZCBjb25zaWRlciBp
bnRlZ3JhdGluZw0Kd2l0aCBuZXQtc2hhcGVycywgYnV0IGJlY2F1c2UgaXQgd2Fzbid0IHlldCBt
ZXJnZWQsIGl0IGNvdWxkbid0IGRvIFRDcw0Kb3IgbXVsdGktZGV2aWNlIGdyb3VwaW5nIChub3Ig
aW50ZW5kIHRvIGRvIG11bHRpLWRldmljZSksIGl0IHdhcw0KcmVqZWN0ZWQgYXMgdGhlIEFQSSBv
ZiBjaG9pY2UuDQoNCkNhbiB0aGUgbWlzc2luZyBsaW5rIGJldHdlZW4gVEMgbW9kZWxpbmcgaW4g
bmV0LXNoYXBlcnMgY2FuIGJlIGFkZGVkIGluDQphbm90aGVyIHNlcmllcyBvbmNlIGl0IGlzIGJl
dHRlciB1bmRlcnN0b29kIGFuZCBkaXNjdXNzZWQgd2l0aCBQYW9sbz8NCg0KQ29zbWluLg0K

