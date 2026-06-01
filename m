Return-Path: <linux-rdma+bounces-21574-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CG3lIrtfHWojZwkAu9opvQ
	(envelope-from <linux-rdma+bounces-21574-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 12:32:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 292DF61D80D
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 12:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 235FB30BA731
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 10:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BD739E6E4;
	Mon,  1 Jun 2026 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rr+5CKkJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013035.outbound.protection.outlook.com [40.107.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE2A39184A;
	Mon,  1 Jun 2026 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780308019; cv=fail; b=qpWmRrVnFJH3lbHTS+f0srf8lgzqo3EIraKNwe7irKnA9Wkbl5C6lqG8hkwH+Z841hfjAfjD4MjLAnPKWibZCJTdnN7HGX/ecJtSsunzFlsh8QeMpkmItFIRZQQ8x2A5VuIqT4N78yjLpFWvtdJ/c+CeEbQcjKoluD4H200gX98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780308019; c=relaxed/simple;
	bh=UNqRHV2SqQeVNnZQGMbc5fkv1C8xbRU0yvKeUgUH1Zw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hwp/ToSvGGxuqvcwB3TRYBb2rLqh6kesg3xj5nfHq2ZsiDLJMHwPBH1rtF5AXbHfnG+01h8iPnmS3e26J2oIieifSIx9PDrT8XCbzFvaOOrvDux3vWy78XzIV9Xw5/OagnMofkuL3iW/+qzLbDTAwf4vXQnNc7VCJuBsCu62KGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rr+5CKkJ; arc=fail smtp.client-ip=40.107.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pcl07eVHrtUfXTC/Nf/r6V5Lev//GvpJaJKsyLQiYKpFDFRMYE+NOBnvhFiTziLw1Z/kAkkOPZ/+SDl5AhuNTDuozJsPvWV8AsfkG3LgrHSV/z6MCXpWAvzBmSc6dDqh2peGyzMiBt01rdVIdlI79RcMKzQq5b9imoU1X+ymDTp+uTYbDIaTADwMZy1NF7uwrLT04NH+5EvOQz6vxcEUj+qziCi3Zc6U99PuNLQutypPDEYBha/EjSIlgzv7Vp7miZOKtFwj3ls3rOQdUy50iDWoZb0bCx9ZR/O/CR0JmWK3nlPTRWMQj+xn+fWjDBW7Dhzam6oP1eC3eiJv9kGLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3l92iOARTwmDkmKu6zg/eRb0411K0MdXD68y5AhOFvA=;
 b=QEVO0CNh14ptvbJglN4ZBiLpW5ZsFrE434k7HanW5XWbgC+Gt0y1qMm3+srOFZWoYVeveIfwqS2MXNJbeAkN8N136mj8GsnZ4ReiBGmA6xmSYQvJMC6VTu0cfz0ihioGtDH8R7dl5PeFAn9Wl2wyiabnMsr357oHGpJch/BPhV0ovX6RL+ZjaHkCzr5bTx0JswBZgz9Zu6IP0u4RCHdns2cI97ofJjss0l+XGPsR0fm/EJEFBRYb9k8ExPsqN8B4D7X9oaMWRwathXHMJX/QJHP6Z/nq9KUwNxtj2FwpY1KWpaltOkdg9Oa3Vk4UbML9GDgqZeGJDAqfrGaoWnjuQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3l92iOARTwmDkmKu6zg/eRb0411K0MdXD68y5AhOFvA=;
 b=Rr+5CKkJTYA0/we3l1b6UAS1YAz3kCGwiOiGThgUl6VKP84BGLxcBMZ1Niy4hwkpSqrap7o8m2103ONo2IZEUZjiesaH3arl7tDO53gAr3PyUACQRZMOhGHB3sU4byLFZbglKw+48h/itfPdlZC1lxMLpy9aSlhzCeGQMgY2E5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 10:00:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 10:00:03 +0000
Message-ID: <190a1eeb-bd70-4b7b-93a4-60e14f0d6c7e@amd.com>
Date: Mon, 1 Jun 2026 11:59:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca>
 <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca>
 <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
 <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
 <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
 <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com>
 <20260529201130.GU2487554@ziepe.ca>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260529201130.GU2487554@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f4afc6-e365-4d26-dc67-08debfc48cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	FFPJ2aPDT4zhONHf8YV6ZGnTQvWtHmK+pwer8otps/Rq1sRuVjujo2Z4HGMlsW5WaYSAd7rcp7YosUTgJrqIiwh5fiCCRnip7oUTYUCaoe5LSfwrN0qB0q4Fkd4WVSqXLTllo2dgr7U7buUqJNUCRzpxe/9BYBvaMBhSysjkNuZERMNG2b7nmF27ME9e1pjpeXySRHuDqkcIwYA8chyKq4iPTEBqtp4+cqpg4y/qgrDAkXdkD/I92dmn+q2rpEG3q/vpcUw9RP/5dvC9FlvsSHPewvczRO18CL+vjiyYDOohi++qKr8lU9DKHvQWFf9j2CBDyXb6G7V48AoCZ/N78QV/P41Nz3DJBhbenGBFbPnd1iaR9c+h/c9x6fcSISpTkdHXg8LmYBve+L6sShqangM1+pbwfZJ7UWmaQz/6uF71XwfuUFW9M5ZgAeIf8isSyuAxmYSNh/7t+vbb7YUi7/mAuTbmQ+FbSwneL9QTMz9eKu3sKoxuAt01lXtvNfzMplSjm206fxVWHG9rqeR15WAks2JWmfixkQFp6Q6PzWPmmVjPzPpbsiFIYSQLVUnpbUuDfgz1i8OShnoXEOVvVnkJAMBmSaTuWwg7dg46ZnwF+OQBcgrLyj+LwHQqnYkYvo/7JxknWdv2JbQ/NMZpayJuk5CX3VxOXW5hQt7QhOCTvG5wy5t8tfVVBFj522kIQa7/PBbL7HLYqvKran7eCg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzY4NHpGMzBpaUowREczbjRxWllDNlpjRU9ndWx6MjdHNmFmSEVyS1ZnYm52?=
 =?utf-8?B?VXBCQk9zb1NwTDFmSDEvVWhUWmtkS1d4cUFWS1U4eW5RY3BYN3VQR0NpUThN?=
 =?utf-8?B?U2hSblBndHFsdGVPa2l4Y2drZldvSHVvM2greTR2cjJRTGM1VTlMSTZ5NGxZ?=
 =?utf-8?B?MjV4dkJUZlkwRkJaMHJXS3Q1dFBBanVpNC9CZThSZ1JGUTNyeDlISHVSdnFR?=
 =?utf-8?B?MG1ibjJkOGdxQzVwYVQxV1NISXBpR1hYRWR5cUhGVnJJeTRBRjNRanZrYjJ0?=
 =?utf-8?B?TENMMTJkSUhGaXowOVljc2dyK2lNaUc2Z2FHUDE5NXJUMHZqUTRFRjJ4QkJt?=
 =?utf-8?B?SmRRRmV2RzVCNnE5eHNIa3Y1SHlrb290eXhUZWdlQnYrdTN6RXB3K1dhNGFC?=
 =?utf-8?B?OS9GMGFrWGRKQVozc3hEb2k1TFZNWWszTS9FU0RSSHlFOERRa0U3S1Z4bXlk?=
 =?utf-8?B?VkZOMFB3N2VzTFh5N3FQYm9OR09rNmQ1UCs0YTl5SWNkVjdBSnVyQUdoODN1?=
 =?utf-8?B?V2g0azMrR1lGNHE5cHI1L0k2L0g1OXRDYTZjT0FjSEkxcTdKeURtT2pJV1Rs?=
 =?utf-8?B?c01aeXpDa2Y1VDRkcG1zSGZZMkRhd0VxVE9Tem5HV2djaVZlY0g3cmk3ZTJr?=
 =?utf-8?B?MFJSN3ZObXp6aTA5QW0zUG5UNVBUeDFQSzBORHcva1EvZEN1ZmtoYXp6di91?=
 =?utf-8?B?Y1QyQ0QrWnFleXpIbGk3TEFTRXBIT3ZjSDNwVVE3QlNOUkZOVXdSOEM4YXVO?=
 =?utf-8?B?RStMdTM5ZEVpY2hXYnlGRHBFRGdMSGlGTlZObXN3VUNjZmNHUUl6cGlRNDRS?=
 =?utf-8?B?U1RzQjFPdHpmM1lZYzhaZkZSd3FoWVZHcDlPRUZkaHRqUFJxOXRvUjhKeCtG?=
 =?utf-8?B?aFoveVl2eVRPNDJxTUZ5K1FjdW1aSFJMUHh5RmhWUjR0cXd1dzVQZEtvWm9I?=
 =?utf-8?B?NVp5UVVLMWh1ZUtwVTQ5YyttNjgzdzlwZVQ2emFOMEJyMjdjNHBFNG44bWxG?=
 =?utf-8?B?Mzk0Z0I1eTlidlhOd29ram1lbGxYMXNtL3hnbXYyNGVqTS9sRG9UZ1M0eTVE?=
 =?utf-8?B?ditIWU1UdmFqZ2hDemtDaVRFWGdPSWp6WjlTMXFHbXo2VytEYWJCSHlxL1pu?=
 =?utf-8?B?SGxtb0VmSTJ2M0dGU0VYdnQ3N09zUXI2b21zMXRwOG5qSUNnWVBuUzdGRW0y?=
 =?utf-8?B?ZnVJTkc2N3lrZWZSWHBaVFFmOUtzZVFTMFN0VnRsRjJWSHVxVXU0cTJZWUhm?=
 =?utf-8?B?L2FHaGxsK0FRelgyREphQXl2WjR4dW1zSUExZGhmRVJxSVpSUWdMdHdrS2NL?=
 =?utf-8?B?Rk15K3ZGamZFcWZvWWxKVUE4a1MreDZzZDI2WEQ2cDdCT2lDeXFIUDJ2SGlH?=
 =?utf-8?B?LzQ3eVVKZnR6dnpFRmsvRy85R0t5Q3ZVdTd0OW1aMmw2MTdIRnJHWWdiTHlo?=
 =?utf-8?B?VjM4dXVyL1ZIWDgwOFN4NzR0dGpEakZ5RlpPTjQrNWk5UHVZVFEzV1AySEND?=
 =?utf-8?B?dGcxd2RMV24xWjRZeTFURC9oSnlKVGRBTmFUOWVOcTA2ZVMzdDg1VkRRTVdN?=
 =?utf-8?B?c2JDTk55WjU5Zkl6TFNPQzNxUjNFaGdydWQxdkgrZmRIcnV1b0k5Q3dmTDR3?=
 =?utf-8?B?Y2puc1RUR2wxbHoxSWZzUDJmai9UUnFid2NRUFZXbE8zTExMWFAxS0hhb2Nm?=
 =?utf-8?B?MURSU013dEw1SGhKalJUSXpnL3cvOWVHbFBFeWpFbGhpbmVwNkpTS1dBbVhD?=
 =?utf-8?B?WjBwbkFadUw4TmxvanBkUDQ1azhNbktZRkJ4OVRBT1hBbERLZkZSU1VZWGJE?=
 =?utf-8?B?OWJQQmtQeUdlWUt3Mlovem9vUDdWQjlUczVaYnRWUzVvNFI5Mjh2QU12OHl2?=
 =?utf-8?B?eEIvUWg5dHVYMGVhbHFuam5lQkZrM0sxTzNMbGoyRkJZUVdLaHVkcGg1cjEv?=
 =?utf-8?B?ZEE0SjNLWWFWclUrODhMb2ZQdWhFb21pNVpHVkl0TVpWNjE4ZXdIdGR6dTYw?=
 =?utf-8?B?K21KTUNJRFNMZnhnRnRyeDRueUgvdnE2UzNSenphbzZqYjdsMXhiRGFyUFF5?=
 =?utf-8?B?WjloNmFzNnJ5aldkdHkwL1RoajRrNFd6N3U3UWtpNDl3ekxVck81TG1FRDR3?=
 =?utf-8?B?a2NwNTFBa1R1dFFBd3N3M0xxUmhlbmVyQzd0dWRCSi9BbUQzTWdKQTJtRW1a?=
 =?utf-8?B?UHNEYzVwYjM5cVJxakE0ZzM0NTIyRFRsY0FPaWpHSTh0ZXVIU1JXcTFrZDVv?=
 =?utf-8?B?ejJCRXJnRzNQZ2JQSUtKZTlvQkxlbFN3aTUwZ0M4ZmZNWlJ2eGtPVDVZV2dQ?=
 =?utf-8?Q?0GIWqteTHtqfH5+oGd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f4afc6-e365-4d26-dc67-08debfc48cde
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 10:00:03.2668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xt99rZFbHzQeTQR1U+GWmYElZXvcW3213FlLGVyjbbo13EQyutZAhcW+SojRpg6g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21574-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 292DF61D80D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/29/26 22:11, Jason Gunthorpe wrote:
> On Fri, May 29, 2026 at 09:36:00AM +0200, Christian König wrote:
>> On 5/29/26 08:34, Zhiping Zhang wrote:
>> ...
>>> There's no in-tree vendor PF driver
>>
>> Well I have to admit it's a bit on the edge but this sentence is a
>> show stopper.
> 
> I think he means the device is not SRIOV. vfio-pci is the in-kernel PF
> driver.
> 
>> DMA-buf is an in kernel interface for buffer sharing between drivers
>> and any change to it needs an in kernel driver as justification for
>> the added complexity.
> 
> vfio is the in-kernel driver, this series fully shows the in-kernel
> API using vfio as the exporter and mlx5 as the importer. It certainly
> meets the standard required to show in-tree users.
> 
>> When you have a complete open source driver stack which utilizes
>> VFIO passthrough as the interface to communicate with the kernel
>> drivers then we can eventually talk about that.
> 
> That decision is not up to dmabuf

Yes it is. This is the DMA-buf API which is added here.

> - what VFIO subsystem requires to
> accept a new UAPI is up to the VFIO maintainers.

As far as I can see vfio-pci is used as a stub driver to avoid opening up the real driver.

Upstreaming an API changes only makes sense if others can use it and this here is something completely special to this particular use case, without all components involved nobody else can use it.

So as far as I can see that here is a no-go. But at the end of the day it's Linus who needs to say if that's ok or not, that's why I put him on CC.

Regards,
Christian.

> DRM and VFIO have very different views on what is required to merge a
> new uAPI.
> 
> Jason


