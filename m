Return-Path: <linux-rdma+bounces-15883-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2INdGf4NcmksawAAu9opvQ
	(envelope-from <linux-rdma+bounces-15883-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 12:46:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA816631E
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 12:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8213570BAD3
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBA43B5305;
	Thu, 22 Jan 2026 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JWxVQfaf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011064.outbound.protection.outlook.com [40.93.194.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DE336826A;
	Thu, 22 Jan 2026 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080543; cv=fail; b=D3fICJSycfBNJBqmRJMSnRoAOKARfHzPVot+Y1r/s/EqsnKKzMhFcDqebMYutA3P3HSbLWfttxs9aXb22rnc//O7+yaxY+6nxreUeBp6iFyqvwk7GDYyQL30+nF4FALOzRm8blQh+QsvtuIzz9BlsP7YlmQ8ft8OzxEHRjHUZTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080543; c=relaxed/simple;
	bh=lwD9hidsaMt5dZ4Zgsqgrb8GFqX7D9klBACquI+FG2w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VI/ylkpp9CevG3C8RyKzyGyKZmA69XtRVOGsM3YPFMSza7Be2DmRzIn8JR8rFSFlXjTvKVO2AWChQsIDq3vdUEJEzqSC7HInq4bmv6byUYu3ReFhen4fVQHB211163GijYCPVdC/8TNp8M0TibFBjEUrhaSXAQzakZRQxuBtAh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JWxVQfaf; arc=fail smtp.client-ip=40.93.194.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/egQTnY/SnHouOzeeZyRSce6xk2xZtFWjCj1J7SzoNHd3yHHsHfiNcPGRAwIC1/zSq9YxX7w2nOaT8/VX0m2J84IWIPBo4YMNuw4dEsvP2FKuYVINrn5BSY8nmJ5uHddrC8KfAfELHhO9LP1ATQ9EbJwPik6tuGePG8UxJ2f4aZWRUY4oYTIXsbJ+Wk2Yo/QgZ3qd5k1Odgog3fPsXxbZbsoTdxhrjosYyu3gmj9uwhKwMw/tLZT3TKofJ3pnjkbNVeCt66QgXERHccTihZdlqjbTHyK+X+rQwYvA3tV4pX4JhIlG+dLVYlpQZ7of6FLG2Tw4WK57LGVJmyye3PKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwD9hidsaMt5dZ4Zgsqgrb8GFqX7D9klBACquI+FG2w=;
 b=MtjToaoLiBrTLt3bZCPcgjzwkPyjXKTx+XkQeJ6n8jNPKhrCW7aa4PpQY9BK0A4vpH53Irpm1d2ZLTiCGNQX55aDA3vHHjsZwS6Rq1n/Szf0f601bobdXdgAAlcp29aRr8rLj0wB5NHxmRrz/F3RKuJuVUplg6uFPsHI7HTkOi88aLZcenuW8VoaPteME9LQhPqc9n5w097umVH3mPPZYMstZSN+z4EC6PEZmENoXy6xNKLTt/1HVE/t7uzsBh6vqzLpT1XrIUCnvcLamkjGJIAJW73fZI9Ge8dqKGNLj7DeZsSnb2gqNbtQGMUt+tTGAkDqTwRqyWyuxhVj3WbO8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwD9hidsaMt5dZ4Zgsqgrb8GFqX7D9klBACquI+FG2w=;
 b=JWxVQfaf4bHaf7j/tCsEi7ItXrS058AUL0hnCIenApoW8hclrXl0GcIUi08sEaw11+nQNmnkil9MV+4w+1nfRDqVwUzk5fESV7dotwxZDCXY3SPpeqHyQ3rWkzncUAragbojNfK8ByvjYsrDZ/p9l5kCYRowT4fHYZNpiXbKHRdBayXET82BrAiM1Ant8Mjjvid+k4pvq4RWt30Cec87dy4y6PcnDlHMM47I9RlOEFWaNkrlyjrGjPe6E0MqBMwsD22Qpk4Zdc4SL+l8OssJsdzQ2Wh0tWeVagJPay7l6X2ubx+B6BzIJTCDoksWSayGDE/c5bf34lVLpzH08W6DKQ==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by MN6PR12MB8471.namprd12.prod.outlook.com
 (2603:10b6:208:473::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 11:15:38 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83%6]) with mapi id 15.20.9542.010; Thu, 22 Jan 2026
 11:15:38 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "rdunlap@infradead.org"
	<rdunlap@infradead.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "leon@kernel.org" <leon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "jiri@resnulli.us" <jiri@resnulli.us>, Jiri Pirko
	<jiri@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "krzk@kernel.org"
	<krzk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [net-next,V5,12/15] net/mlx5: Store QoS sched nodes in the
 sh_devlink
Thread-Topic: [net-next,V5,12/15] net/mlx5: Store QoS sched nodes in the
 sh_devlink
Thread-Index: AQHci1DO3C+9aIDafEGAxrD6KHjngrVeCjyA
Date: Thu, 22 Jan 2026 11:15:38 +0000
Message-ID: <f958d572454eb0e298660d2d713804692e77e16a.camel@nvidia.com>
References: <1768895878-1637182-13-git-send-email-tariqt@nvidia.com>
	 <20260122034003.2579276-1-kuba@kernel.org>
In-Reply-To: <20260122034003.2579276-1-kuba@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|MN6PR12MB8471:EE_
x-ms-office365-filtering-correlation-id: c420371d-06e8-45eb-bf5c-08de59a792a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WTZEU2lHWWRyWHhHNkgraFhnWkliZGl0WHNMb2dMbDhCLzFMbkJkaDRGSVBP?=
 =?utf-8?B?L0xKWS9wMWs3NWNncmZhMFZTNjF0Y3hFZVNzNzRua2dvRXJUdG1lZkx2WkhB?=
 =?utf-8?B?ZXJ2eGdVc0NhNTJodWJlblFmQkFQaWhYWVd0S29pSzJjZ0xacHBxQWw5Z1Rx?=
 =?utf-8?B?b3RYRUpKUThPSzVsWnZKczhobUJiYSswL20rNmlQYy9LL2o3V1RmY0lhSVFR?=
 =?utf-8?B?dGhLNVovVGxlWHh3TDUrSjhid1k3bWhXSkcrdEpYMEs1RkhiOTNyS0JiSVFN?=
 =?utf-8?B?ZjBnTWhjVm1aK0dYUWlvVS9iajhJYWtuVEluYTEvL0dHVzRncC9yMTNyUHVp?=
 =?utf-8?B?OUduMG1aL3V0WmhBRUw1TmIweTBBWTlkb3lwZXFQczduOWgyc2U3bzZ5VkVq?=
 =?utf-8?B?ZlBBbmVpRHFCNWlmTml2aU5BanNRUjZsTEdhMkN6elBVV05JUUdKT28zZXpp?=
 =?utf-8?B?VVdCRmpKNFptdnBNejJrVlpEQTBIeVM4b2lKTytBN1RldnZoT0oxdWszTmFa?=
 =?utf-8?B?bjI2dExvZmVDRVF0MlRQWWlESDFlT3AxWHM0QU9oU1NOdXBkM3VkT3V3ZzR3?=
 =?utf-8?B?VDdKNFBwb1ZjUExLc1JXWlVQU2FpVzd6RmJJUWFRMFZVUitNTjBkZC9OUzA0?=
 =?utf-8?B?YUlmdHNaY3p1Nk41SWZCdzhvWDdvdW9FWFoyZzFTSFhjeklLTi9EbDlPUVp2?=
 =?utf-8?B?eDFPSldTdGpSdjZZTkpwWXJkeVMvZFk4dkNyaDEwQlBlVEd1WkZETng4WW16?=
 =?utf-8?B?WVpvblZhZWtYbXZuQ1JBb0ZTenVPek4yWm9PMk5rcExIdnkxMUlvZjA1bFJt?=
 =?utf-8?B?Mmt1RnNZWElNaTVlYlVZb2ZBT3l1WnlON1JtQkhxZVpuUEdrVkdwOHdRNUkv?=
 =?utf-8?B?enczUmpxNDBZUDM3ckJVOXVYNjZTWExyNU50cEpLMkx2ZTRwQy9xWlU2WnJI?=
 =?utf-8?B?UXptSXhFUFRudEVmcTYveEY5bSsvYjhMYThvdFFlN0ZmZStFUmxlZHBDMnZH?=
 =?utf-8?B?c3dMRUZ1cDFTdVBMUmQyYkRIN3NwRGhYVlhmRS9FWktyaVVpS3Z6QmJVQjVK?=
 =?utf-8?B?UkRoZnVzYkUySEwzczkwUUI0QktFVTladEhremRBakFQUHdtNE80SllXcFZ6?=
 =?utf-8?B?V3d5NnN2TDRwMFZoU0lQZ0Zadm5GOHFSWThoRDlPcWZ4MFF5czZTUUs5MXIx?=
 =?utf-8?B?eG93bUlQYVZmUERPRmJ1VEFsbWR6d0lvNE8yNlFJRENmVFA3ZkhQd2YrK0xp?=
 =?utf-8?B?QURIVDR0REhxZ0lzYTRZaFVXTWdmUHVadFZOeCs3dVpieWI2bnNLK3ZodGVP?=
 =?utf-8?B?d3hjazJBRnQrazU2VWJaZHhER1d5VXVlcWE5NnM0WEdtbnYzdWV3VlhOU0dx?=
 =?utf-8?B?ZFFQa3B0VXZ5RG1QVGYrNW82dXd0Q0RWTFNoeTYxWnI5amh5Q0JsV1pQaVYr?=
 =?utf-8?B?emRmWkNCWU9sNkRLYiswbFJtOERpcC9QNzN2bzJhd29XOXlQeGV2aDRWZXBH?=
 =?utf-8?B?UmxwRlFPNDR5T2pYbm40V2NJM21Sd1diU25HRldXekNWM0VkVHVjZEdnNExk?=
 =?utf-8?B?Y0gzTThxZk9DbUs1a1pRNGhDditwK214TTNZNHJjY2V6dTZ1bXlVRGtyUU5D?=
 =?utf-8?B?Q2VqVVN3eTlPUTVNNlphS2NteXAxY1lnbUM5V25PSEdiU21MSVhaMHhoa0lD?=
 =?utf-8?B?S3JhWXUxL1pwQVdLOGQ3dzdXa1c4ZUNhSG5LUXhOMTFWNHNTWDF5UmtGaDFk?=
 =?utf-8?B?RnJGbkpvanU0UEpxdlhCbGhoY0RZR0JZNFNpaWNGemRxSnRPZnBGNXZIenFP?=
 =?utf-8?B?ajJoNlZZK3Q4dVUyNldsNE9uYjFERHVkbVk5NDhkdVh6R3c4aUhSaGVSdkdU?=
 =?utf-8?B?dWRVa3o5b2xWN05aemMvcHpRSUlseEMxYyszOXpYZFJxbGt2Vk85NCttNEk5?=
 =?utf-8?B?VFNWdFBHZW9xZDVrTUxvc1ZWaE5GRWVDWFE4bkdwTmtFRSthWmtMMXpjd0RP?=
 =?utf-8?B?cE5kV0R0Q3Jya0NsZUVYVDBmVy9oSStqZ0FOSGl1YU4xeVNaMERzYWRDV0hN?=
 =?utf-8?B?eTBVbVVCWVFWT1VWcFNoa3JRZWJNMExkbkdhU1RmdkdnZ1R0ZmpFNG1VaXYv?=
 =?utf-8?B?b0trRlZoQkNuM01rUzV1L3dqVjVmQm9qZnpxNW9tcTZwMzRTZWZyb0dyRTV0?=
 =?utf-8?Q?PxQzKGLy6uXwcRPQXqM174M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1V3czlkdnpKM0VoUHV0VlpqUEtPaTZWL0pWci9LSEtONnI5RTdXQTJRc3Rj?=
 =?utf-8?B?bHJLdURNZm1yY1pNMndUcHJ2VHNYL2lLMjd5ZWpsTnV0eERJTmFQYjM2Q282?=
 =?utf-8?B?bUNacUY5Sk5RdW5mbDlLcElqUnlIT3lncGRrSEUrSjM0WUxyaWFHWnFmTDJp?=
 =?utf-8?B?UnR2RUhBMitHZEdmdXBLUzFQVyt5bS96V2RKbzVLNUVUTXhBUzljVVZzbFZz?=
 =?utf-8?B?QUh6WEpkYTZWajJ4ZU9HVG95NVg2c0pJcmJONVVka3Juay9pQjJCYWE3V1BP?=
 =?utf-8?B?bXZtLzF1b0xoME5ZZDFUaU9jMkE0N1FmdDZXN3pQaGJKYUl6bmkwU1JSVkt4?=
 =?utf-8?B?M2ExZEVYemZmbzVPWnlyTmNSMW15QWtldHVmZ2E1OXI1Y3hWU0EvcWFXUHFj?=
 =?utf-8?B?azBRcnhDakQydEZDdTM0TkVvcm14Q0xpZUZvdTM5Z3diSEdJRU90TG0velk5?=
 =?utf-8?B?NFpYTW52dEhSbDFGMkRaNEcvV2gyeitRVDg5bHpscFlOV25yOUdsUzc4Uktw?=
 =?utf-8?B?RG8raHlwWkxZZVVrT0ovZTVqTWJqSUc0M29xbXFZY2JlNG03azhXdUxxNUNh?=
 =?utf-8?B?R3c3VTVqQytaM2xycUZCYmQvQUR4cU4xWDAzL29UVUpoQW94eFlqWTFSb2dr?=
 =?utf-8?B?VTZCQitHTDRqcDgrcFBKZjlWVVE2SVhiTVN1aDEzM0NNSkNNbzJvRzkyM05Q?=
 =?utf-8?B?Z2FJZDNMMkFxb2FqeTVZQ2NiZUsvbW5MbXp4MzB0S25uOUhsRkJQekhRdTVa?=
 =?utf-8?B?YU54Yi93SW1PUUQwakl2MzhBMk5EU1FRTlh6RlV0UmxtTFVjOXVOaFFQUlNk?=
 =?utf-8?B?Z3RmZG9yT2F6cFJYdnNJOVh3Q2dZUHhCLzIxeGpSaDBXMmQvUTZiR2xHYU5Z?=
 =?utf-8?B?UmErdG15b2JqV0JqeDZ2aXg1OVF3Y0xhL0lKM3I1VDUyWEZZanNrOUNkclBY?=
 =?utf-8?B?NUhPb3N4TVJCSHMyWnRoU0VCTkNiQnJzUnRrQTFnOEsxMWI2YlgyZ1djbmE2?=
 =?utf-8?B?bFVpcWgreHVDZjhEaHZBeEJHYlRocU9KaldNYzJXNmVqdFNxd1dscEhRVDcw?=
 =?utf-8?B?V1ZvZkJqVWRWNXZJaGY5QjJublVnTVJSbWxuK0JvN21WdWkzdVdyY29PRmh5?=
 =?utf-8?B?OHBUcVNFNzhuVlluT2p6c3Z5N253emtSOExmQlNXVTgvaVJ2T1lhYXJMUE9z?=
 =?utf-8?B?aGlqRlg5eUpvV2M5NmRBRUQ1QVBHd2wzZDVoTUpWaHU0OXlIT1o2MW1OdnFW?=
 =?utf-8?B?dk9LQXU5dnNKby9oVDdTVkRnZG5lSkJXKy82TVUzdmdsVGpUSWFSZ0RNZ1U5?=
 =?utf-8?B?MHVBR0xrcm5xUFV5dVVsakltTGlvRE8vS1Izb09wVkJ1QmZVdmoxaTVjYmNx?=
 =?utf-8?B?ejlwc3lDU2JGeFd1MkFja1VqQ0F4dW15UUg1QmxKV1FaV3ZpbEgvUEUwdzdp?=
 =?utf-8?B?UG9BeGNoeGwxS1pYbFBVeTNsVktQUVVVdE41UmNqL05lNXNJUXJKU29oZzBp?=
 =?utf-8?B?c2tuKzRHcjF3NUxoa0tQc2djMENnQk5VUSs3bm80dnFMN1l5TGp0dm5sL2RS?=
 =?utf-8?B?U1pUaERJR0xGQjZPSVJob2t2cUFIMzlEajl0Rm0rWTQyakRaektiRDFORHBK?=
 =?utf-8?B?ZjcyeGJTbnA0QkNlWml1WmtrbEpkc0o1bXYrZFZaUXU1a3Q2Sk1hQmlyVlFR?=
 =?utf-8?B?NFk1VnJKbjVPU25QRDBYVFczdXNPdHRqQnp3RUluVFVqbE1LWFhBTW4rOE9S?=
 =?utf-8?B?cVVZZk1EUndybXlRSDN0bHZGYk9DVXhyalI5L09hTUNHWmdtUkIwczVyZDBn?=
 =?utf-8?B?S3VGcXdzNHdFdGhweXlvY2RZU2FtUU1mTVI4aUEyOVBxQUR1bDI1K2xZQ3U2?=
 =?utf-8?B?TWxxUVQ4WFFTbnZLckR6VkpSZ3Z5eFZTZXF6SUlTQ05HZmd3c3c1ZFFTbCtq?=
 =?utf-8?B?L1RraHpjMlJ0Rnd2K0gvTFFuV09yVkRoeE13S1UzdW1ZeTFWNTMyQUNNNElI?=
 =?utf-8?B?OHJ1dmJpNm1JSW5jYVp5RmpuRDhpYkFsQUxGN3RZOVQ3M2xzRTJwNUxjYXFH?=
 =?utf-8?B?c29nZnVRbGpWdDRBWjRka2xLNUQ3UW5xdmlDM0toQUtYUVRic1hOSnBmVEVM?=
 =?utf-8?B?S29mS2NlZ2IzL05HZHVSeFFHcGJGMGhVNisrN2YyRlo1dkVKMW11aVl5Ull3?=
 =?utf-8?B?WVZjNWJWZy9WeDcrVUN5T2NaR3BIN3A0UGhlLzNjVVN1cUlPYnFLWFVNQXdI?=
 =?utf-8?B?emhSNGF0djV2VGRRVmxqT2xxK1NBZmIzN2xlaXRxVUNSLy9uaXNxN2lZWGRF?=
 =?utf-8?B?Zmc4V0lVTmM0YnJKRzJueGJUZE5nTUJDOVU4N3lhUXBLbmRrd1Izdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3089A328943DA479E9F9C54ACB166F9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c420371d-06e8-45eb-bf5c-08de59a792a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 11:15:38.7725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K7/rNjX8ia+GkhkOvAt3Y9f0FNeGqqB+qrgyU9RMYyIYmKGCLXLYdUQsJZgoOGQ84z7w2CzWMR5Sh5YfY9tXDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15883-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,nvidia.com:mid,nvidia.com:replyto,Nvidia.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lwn.net,infradead.org,lunn.ch,gmail.com,davemloft.net,kernel.org,vger.kernel.org,redhat.com,google.com,resnulli.us,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: ECA816631E
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAxLTIxIGF0IDE5OjQwIC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gVGhpcyBpcyBhbiBBSS1nZW5lcmF0ZWQgcmV2aWV3IG9mIHlvdXIgcGF0Y2guIFRoZSBodW1h
biBzZW5kaW5nIHRoaXMNCj4gZW1haWwgaGFzIGNvbnNpZGVyZWQgdGhlIEFJIHJldmlldyB2YWxp
ZCwgb3IgYXQgbGVhc3QgcGxhdXNpYmxlLg0KPiANCj4gVGhpcyBjcmVhdGVzIGEgYmlzZWN0IHdp
bmRvdyBiZXR3ZWVuIHRoaXMgY29tbWl0IGFuZCBlZjZkYjRhN2YzODENCj4gd2hlcmUNCj4gdGhl
IFFvUyBsb2NraW5nIGlzIGJyb2tlbi4gQ291bGQgdGhlIHNldHRpbmcgb2YNCj4gc3VwcG9ydGVk
X2Nyb3NzX2RldmljZV9yYXRlX25vZGVzDQo+IGJlIG1vdmVkIGludG8gdGhpcyBwYXRjaCB0byBh
dm9pZCB0aGUgYmlzZWN0IGlzc3VlPw0KDQpUaGlzIHdhcyBhIHVzZWZ1bCBpbnNpZ2h0LCBhbmQg
YSBjbGVhciAyLXBhdGNoIGJpc2VjdCB3aW5kb3cgd2hlcmUNCndhcm5pbmdzIHdvdWxkIGJlIGdl
bmVyYXRlZC4NCkkgd2lsbCBtZXJnZSB0aGUgc2V0dGluZyBvZiBzdXBwb3J0ZWRfY3Jvc3NfZGV2
aWNlX3JhdGVfbm9kZXMgd2l0aCB0aGlzDQpwYXRjaCwgc2luY2UgdGhlIG1seDUgY29kZSBpcyBw
cm90ZWN0ZWQgYWdhaW5zdCBjcm9zcy1lc3cgcGFyZW50cyB1bnRpbA0KdGhlIG5leHQgb25lIGlu
IHRoZSBzZXJpZXMgKCJTdXBwb3J0IGNyb3NzLWRldmljZSB0eCBzY2hlZHVsaW5nIikuDQoNCkNv
c21pbi4NCg==

