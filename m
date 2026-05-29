Return-Path: <linux-rdma+bounces-21485-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJBfCrJCGWqNuAgAu9opvQ
	(envelope-from <linux-rdma+bounces-21485-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 09:39:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E265FEA9F
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 09:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25C023095739
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 07:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FDB3B0AE1;
	Fri, 29 May 2026 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pA39tgAy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013058.outbound.protection.outlook.com [40.107.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AE63AF677;
	Fri, 29 May 2026 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040172; cv=fail; b=PqCMeixmgmwO5rJs5/ste6gz4IFAJ3Ohw5PbkztCky/4ctKmPWHf5WTJE4keO4Ru6YDsNf8IO08dXFBcnz+4SrJ1u7TKQXSNglXu4ymj/qAosWNgtJ7vbnMhDKlTMOBNBhT8FSEzlrKqsDBMvVHVfCJeGrWm0KD2LNJqqF7+LH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040172; c=relaxed/simple;
	bh=ORO9s2WnCC90PuLkWGhevZNGYomktkn0F4Q9d65zjRk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K6uezI5qjb7rMCvyaNjIIcoyG90nzQ9cmRE6ZYTfRBITttFBcGQW4mfr+BaTTGvca7/0SQATY3X/dkCW3NwtmpBv0ElZWC+FTCRF9chIn5AEfK143zUBfZzsmgpnn9decCxQo2hVAp8JvDE4gxv51jNcstN73DW0A2gY1azUdPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pA39tgAy; arc=fail smtp.client-ip=40.107.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvRQUQFlomxwTa4SycXuD6ncqJ0Rr4qB8hi+tS65MzhRcLLNA3ypOWJ0gShS8mr2aLVNZrT76qDfkBiQ8oWwqAy/Et8Z8hIAfqovz5/VNa9GrPD6moMM38LYcQFjxfh7VXVIHeKytXngXK+bCWpunucRT6X7d7Bpv/g6joC+iodituzCzivWpbfmxnHZ78AkVzw9JjzdbQs2x5LLwTMJoU8w5wiV9MIjx+WZN8rTgGAA3mr+VIV/4LRIfySLcKr92nlTdzGOap4NsYmMQJQH4MpNcPN1gCCkgVR0mZeWcQAwI6u3B3v5rREiO3TmYExVGsKHl6VDkCrNVuwHS9Pvnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqqKeSs1eb6kQUmv2qSzxBrLPimbyH4yZdtAtUNSrRw=;
 b=zC/gkT/ZjSTV6syb0qlyvWWGPtV+Fd5iD66Vjm66PNvuQVdmbFpuZlXxAYqMtBpVpBJS3URDQIB2lYLdQdHeBozNtGyuWzAG8l1IuOc1FZuwZdeJa6YKHN6H/3jAsaLQS7ppxfcWmmtAr/anhovBfG2g/W53jIsZDrBBkxw06h9ZPEkNGYboxjjzeP81UkS5IOwpOUY5j91G4a8EOT5pC7HsQ6hNpWS9M14tN4TVcoNeBzgGnj7bTciMGVswPUSfCx4iEx3Hwkbg7FTb5ZWvJZdKLrB1P4yKVih4/qx6NxhWxhL5xHvDgHECQd2iwpCCqnKsdDpeHIgXotI0EbLoLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqqKeSs1eb6kQUmv2qSzxBrLPimbyH4yZdtAtUNSrRw=;
 b=pA39tgAydcdBh317mCjvFritZwd/QpzqlF8A3mKZV0ByPbZmYiw9v25h5q544LuG7ZLOO8yX0I4t26PT9ttnYBxGDbAfdQ528lzK1EEk+OLc/UycXIhuh5rImKqwEImEhcw/dFFBmmzVTOcI/D5DtV8dtvPB6vDGdMufRMAW6BM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8011.namprd12.prod.outlook.com (2603:10b6:a03:4c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 29 May
 2026 07:36:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 07:36:07 +0000
Message-ID: <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com>
Date: Fri, 29 May 2026 09:36:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>,
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
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0419.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: b34ab829-1a26-481e-ea69-08debd54f259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|11063799006|3023799007|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	NL+ISUi1yNLKOsb2obGD97hlRnejpbxeA+2q0G00yoccJbImRRjInv2BVoKcrtD85AR9wf4A7AZBMJoTPXtfStAbz56vefQsEczhG/hxPVPiiIeTVe94FHVmFprhR+HCqZVoTY+pfpL9Ecp2Ll4JHyw5npTduRVmBYXqYQkmRZykiGUzKWJ6LKpNVgE3rmpxJlcOvngAgUVE+XjTtNVHbJate/H2jngHPe3tOxid4xfhWSbUD61ivUL5Vrv7KLYTgWwUZOuGvXATSBJgJHORNgDj6bObZi7pRmsUeCHa4uCunIIILQgaazXlV0rGIkl5IHSEKu7J/3Vf4PB7m2rYpT8ou3dzQ6mPZwofwr3tg4ddAbE9mtFU9LV7MwX0t0AJgfAGWdZ9utQLL5Em0OCAsz2ByJZzFtI3iqKcWZ8E5+U/gUMoafccEjZlx+gVI6FbNgqVhjiOBhlrcMFlaIdQkqTR6iVm6/jmjR8b0I4orhl3KI5xlacb7Zy77UIdft544grkXK6bSetPM4IYhdTvxYjKUrv4bEig8H9hD/+s/VjMFZvxiMEsuJAWuVdF/XGZWBW6A8b5B+TmHzOa9KED1zki3SEfaUPxN8EAo8QlOtTfzvX3VK6AJ7dbNF6l3a3kq362MqaqPViC+o5j9Ljhv8K9oXJUkJV1MBGNGT4LKGdWWqqaFR82BsD7u6gHnJ3J
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(11063799006)(3023799007)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aThpcmFHWVJ5Z1RzbjJadk1sZUhZSTFjVUpQVDVmRlQvT2hNT2VHZlNMT1I1?=
 =?utf-8?B?VGc5N3g0Q3V2VXZLTzA0WUh4STh0UEE1QlI0b2lFbjExRUQ3d3dhSG1SbG9l?=
 =?utf-8?B?Kzc0K2VqZmFoVFhhVUNkZm43dDRYQzhHSlN5TjFiM05sUmd3K3B5MFVSSDkr?=
 =?utf-8?B?aGdJSFJlQU5FM3lBUTJrRlBzWDF3dXFlV1hTQmh3U0tOSVZ5K04wUXp2b2xW?=
 =?utf-8?B?bnBtSE16aVhBRnA4UEpzbkgxVWVvWTNubktMY0Zwcy9JRGdaVGNrWmlPcTVB?=
 =?utf-8?B?eTdKRnhyTVROZlhrV2JuaTZDZFJ3Wnh6Y0REaHBlTnF2UFJYdXB3bDY4bENG?=
 =?utf-8?B?aE9RbDhXckdYVXR5REhsQjUwby9HVUNnNWUyN0RHMnkwY0FNY0ZRZWdXQVlV?=
 =?utf-8?B?V2V5QzRBUXhRckJJRWorbG1LejlvYmc0c2gycDF2enRudTJDSWtnOFRHa1dq?=
 =?utf-8?B?V1dOeXRoUC9FNzV2a2Y2TU1JT2RvRFNjWURXRVpOVnZuelRqeGlWTnQ1aUlW?=
 =?utf-8?B?MTdlTU5NMmtTTE1XSGlEZU5ONGY4MUpWY1NtSWszVlJUYmJNdTFPdmF3djFN?=
 =?utf-8?B?Zmt4MlNlNmZNNWY1NkpJNWt1dkdLYXhYRlRsZFArM1hKWCsxUGYvUkJDZnh2?=
 =?utf-8?B?TFl2OFdoS2dkR0RkcFdPSXltbEg3cmhsdE1SWjRxeDdMN3d2aVpiS2EwNm10?=
 =?utf-8?B?dURWUnc0TmpYU0lUM3VPWnE4VjdiK1ZkcldnRGFYNGNFNkN2c2JLSHpjU2hp?=
 =?utf-8?B?ZFVObXpMenF3eE9OeTFsYVhuaHR1UUx6eVBjT1FZVXhiOFpybVdqRldvd1gy?=
 =?utf-8?B?Q25rSHo4dzZNRy9tbVlOZVFwa1gwOXFoSVUzRk5ZRGc2cHJpZ01hWW5lVmNa?=
 =?utf-8?B?Sm82bmJXbUhCeC9objlYSGtycHRMdDJ2S0ttaVRlYWJuL0xqSzNtekxRT1Vr?=
 =?utf-8?B?R2NpZTNERDBWVnhqTDdRdWZzYVZYUUJpL1psMmFJQTdjN0tmNFFyUWdSKy9G?=
 =?utf-8?B?VkxiczdSSld2S2p4Y3gwTVYwK3FxNm0yZkE2aFROWlhHWGUxczM0ZFdUSXpQ?=
 =?utf-8?B?Mm9BMUtpNjdheWZORytwdlVCc2tPSXlYUXF1NGxyU3NXbWVOL09CYy9qdFlk?=
 =?utf-8?B?NlZ3alNXK001MjRMT0FsRnFYeTNzOWVBRXltbFVrdWxUalR1TVMxMTBjNlBS?=
 =?utf-8?B?NGQza0RhYlZtV0d3RktJWE11bHpGMmFuUEw1NGhzQUVCZzZlY0JNakFlZzlE?=
 =?utf-8?B?OVpPTEl1eGNuY1VWVHJBZmhTcDZVby9pN0t4dStXUGRQbG0rQXg5UER5akJq?=
 =?utf-8?B?NW5NdVdKUXVrMTY1ekJTb3ozbEdnTmhXZlphN0hwSzJqK1hyRnBRRnBqNEhl?=
 =?utf-8?B?NU95T2N5U2QzVEZuenRQblhDRkVBdHc3MTJJUTh4WkF4eFZkZkhqWXZwRDFI?=
 =?utf-8?B?c2Z5VHZyQXViTUN4V0xsWnN5MUFTUWpqSWJ3cWcrQm9pVUJCRGpUSXdhblFG?=
 =?utf-8?B?czB4QUxOS3owUURMNWlzTEt3Q2RoRVpsQTl0WTZRMytaWGdHRGxrWkFDekZX?=
 =?utf-8?B?Umo2c3Q0SW9TUWpDbW8zcTUyd2ErNm0wd1VnUjNOeWRRbmE3dDB5dFRXcnh4?=
 =?utf-8?B?SnhkUEwxa2ZJTHVXWDcrMTZBR2FYeHg1T2hlbXVlNU00d3ltNzVYQ0tvaUFD?=
 =?utf-8?B?dDNrT1kzcmdkVldZZU4rbm9ONURVeUJ3d2FoaE91N25LODVFelRwVmp3RG40?=
 =?utf-8?B?UlBCYzl1TE9WM3Z6V2NLTUZMdUt2MUYrQkt6UU01VmUzZmlEMGM0dm8wL24w?=
 =?utf-8?B?UVYzL0JCbWdWb1dpZHBQRzhrVWE3NlR5R1BvOHZmU1BNTHowNmM1dHhLem90?=
 =?utf-8?B?QlRPU0gzV3dtMGZpU3hUWUQ5bHlkcmViTUxDa2x5RzI0WEx5MW5vL3Fya0JJ?=
 =?utf-8?B?TmlQZUtnRGJFREMrTzFDeEtvMGhnZW1iTnFnc2FVcjBpRnBHdlJFQWlVUFEx?=
 =?utf-8?B?b0RvcDhaQ2hBamRWZmw2ZEtWdW14c2YwaUZFZ2d4aUcwVXY2aDhkdFBnVGFZ?=
 =?utf-8?B?MTlPVnRMN3A1TXMzdTFGMlV3Ry94Qy8rVmFKUVkrUisyOVRzbExDUm5NSHdX?=
 =?utf-8?B?eXRNQUJxOE1hWS9LQXpSZHpUSmRBZG8yWk14UXRPOGZmWVE4N05ieEpheDNq?=
 =?utf-8?B?aUoveFRDaWR5a0x2dnNDbEEvWmhXRDRYZTlRZzc0Sm4yODdSSUR0VFBEYXUw?=
 =?utf-8?B?NGtMaFhGVXRQY0d2and4Y3dGQTRkcy9icDhHbUlVN1lFQmpnaUR4TlZvdTdR?=
 =?utf-8?Q?LTMEN6UQqbGnPMIEdx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34ab829-1a26-481e-ea69-08debd54f259
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 07:36:07.5313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Psr9sFC0JNsbLC8In6ARzxpl8jkENX7cLOaGf4KciQ0e+WWpOf9idRyv0e+Dw65D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8011
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21485-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:mid,amd.com:dkim]
X-Rspamd-Queue-Id: 09E265FEA9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/29/26 08:34, Zhiping Zhang wrote:
...
> There's no in-tree vendor PF driver

Well I have to admit it's a bit on the edge but this sentence is a show stopper.

DMA-buf is an in kernel interface for buffer sharing between drivers and any change to it needs an in kernel driver as justification for the added complexity.

> — the device is a Meta MTIA
> accelerator managed entirely from userspace via VFIO passthrough.

When you have a complete open source driver stack which utilizes VFIO passthrough as the interface to communicate with the kernel drivers then we can eventually talk about that.

But as far as I can see without upstreaming or at least open sourcing the full stack to utilize this functionality it's a clear NAK to upstreaming this.

Regards,
Christian.


> That's why the ST has to flow through a uAPI: userspace owns the
> device and its ST table, so it's the only entity that can publish a
> meaningful value for a given dma-buf.
> 
> On the effect: the endpoint's PCIe ingress block uses the 8-bit ST as
> an in-band instruction for the incoming P2P TLP — selecting a target
> cache partition and, on writes, an in-flight operation on the data
> before it lands. The dma-buf callback keeps this opaque to the
> framework — only the producer (userspace owner of the VFIO device) and
> the consumer (endpoint block) need to interpret the value.
> 
> will include these words into v6's cover letter.
> 
> Thanks,
> Zhiping


