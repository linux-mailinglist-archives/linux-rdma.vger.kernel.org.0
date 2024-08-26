Return-Path: <linux-rdma+bounces-4573-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5044795F7DA
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2024 19:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7489A1C21E4D
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2024 17:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666FD194C95;
	Mon, 26 Aug 2024 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="YcFaDhlH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2092.outbound.protection.outlook.com [40.107.96.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A9464A;
	Mon, 26 Aug 2024 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692929; cv=fail; b=R4vczMNNMjGS2E96MFhz5W2mYh5V1UhUhgFEcVJkSL3PoijNYWjL+G1YPR/qLLBsEnmeQMpXyP5XBWu8+zk4N7RvEUPhV/7wkPTYvj0wB7MdnC/SmAt3SxvBma56XAmw9mK4qB/PVczv9pxHEXlMag7s3C/+F7nCeWsHWBWRMBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692929; c=relaxed/simple;
	bh=Zk8tGyxaWFmUgTCzngNTii6DCvCDnvvw0OVZk9fiuI8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h/7yfFZfObjEDWM/glyS1JSEK9Co9LnG7NIo0PjPLbUa9vdtFqNMC5kHySlOmOTFjGOrWWGp41VNOM9dtRLf2Jwlsq5wICKxPiBh9dv2q8LNaIC5KxVxIoBoogY9x69GaVsvDdrBkIH0vuqIXiwY8EaVegyyRCLbNZQh2O10wEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=YcFaDhlH; arc=fail smtp.client-ip=40.107.96.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLUhvwtpzs2cMzf4qc0PMGiYsP1qZijOdi9kMWBr81vxC9NHV3TNLRnjPK288YANeuwq6C4TNjEKzv8cLx2QjgD8Oq1r24u3kAWudH4311sm5SxPaqxuO6ymvMHR1vt1pXmMjV8aOZU6LbIgJ1vrQKc/bPkIlqNfC2ZqZVUbIu6rroYAfFIbnR738F6UDgYTll/knmyixGoHn1euV7/Q9k9BizHViH8FZB6JqQseqrnWYjUevdja7k2bXKxKonT0/bMKkVdBdI6QLc9/v2ZSUzGYVQ4q5PV59eZL12szspamZmMAMrlxLJvNvu7TIhDDqToHHQTrZzTsft/64BJk/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpN5Ij5XjI9JG0VqIeOlPamp2FkNZSKgOy6NFwlmSBU=;
 b=qqRGuuVib5IOzfOfWjum96JAc4nBzIvT5aaz03PGPebn4c/yNDwqIYHM5+Q9MlZjsJM8aIrt4BSyynKlylrdOrCW5bV5y0xpvdTv/blySFd15fLxVeOKePFhiit2935kyT3FyLA5ShH6HUUYjzR3qJm2mIohYHJ1hfFV+7rzfQvjDHhDt9sdwbR/4ht3wU3mNskfuG0cYhqu2ArUz+hAZbkvdfXbn4t28z0oRGDgJsXamI/q3pskXRPzdu4QXWCxXg0abvWdwKzB2mAra3auRLzR/BHbZ8V+EqnHYnWZX6igGCHsEFQenIL6hWfrjkuZiaKVWVtXPC+h6JrXPxT55A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpN5Ij5XjI9JG0VqIeOlPamp2FkNZSKgOy6NFwlmSBU=;
 b=YcFaDhlHEcIdnNhp+VfCFGbWLPrbIFQNoV4MtjVfAMfaMS//mUBViB63/fZ6NuBLZFcxrzX1bPY7SDggj3VKkoqOJeBt5V20F7VXAufwUSRHL5xHNYiicy8cvA9t6xWYK5+0DE9qpVx8ABFxJaAV/eMZNIufmFyEX7r7KmNnDiLYmE733/jdp8xsGFd9Op1Vndi2appiRB2+MetFFd2OVkdlyp9DbD7kYhJwEkn0thU2uC3d0SFXf5wexPluT1exuenrmnHvnSBIEUoBHHoMMqY2mAp/BYNsU4zIRzj220F6r6dotk2i5EBJKsuO1MTx3ifoDlojOnr8aDEGrhgMkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SJ2PR01MB8151.prod.exchangelabs.com (2603:10b6:a03:500::12) by
 SA1PR01MB8250.prod.exchangelabs.com (2603:10b6:806:38b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.24; Mon, 26 Aug 2024 17:22:04 +0000
Received: from SJ2PR01MB8151.prod.exchangelabs.com
 ([fe80::8212:f21e:96f4:82ec]) by SJ2PR01MB8151.prod.exchangelabs.com
 ([fe80::8212:f21e:96f4:82ec%6]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 17:22:03 +0000
Message-ID: <59cd0c1c-b5a0-471a-810d-65d42b021760@cornelisnetworks.com>
Date: Mon, 26 Aug 2024 12:22:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Using RPMSG to communicate between host and guest drivers
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: linux-remoteproc@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 OFED mailing list <linux-rdma@vger.kernel.org>
References: <133c1301-dd19-4cce-82dc-3e8ee145c594@cornelisnetworks.com>
 <842aef7f-d6e1-490a-97b9-163287ddfe2d@cornelisnetworks.com>
 <CANLsYkx2OThcBjs1Qn_Bgd0LE1+EN7c0Dh7NE=1dEBB4xqS9cQ@mail.gmail.com>
Content-Language: en-US
From: Doug Miller <doug.miller@cornelisnetworks.com>
In-Reply-To: <CANLsYkx2OThcBjs1Qn_Bgd0LE1+EN7c0Dh7NE=1dEBB4xqS9cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:610:76::19) To SJ2PR01MB8151.prod.exchangelabs.com
 (2603:10b6:a03:500::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8151:EE_|SA1PR01MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: b03720d6-6c02-4700-f90c-08dcc5f39a3f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHNlYWJrSXZtblJ5MEM1Ti90SWwxcjV4d01sWVNEWEpxaW0xL3dieVQvY3cy?=
 =?utf-8?B?KzFUSVduOTduUVJQOHh6dVkwaU1YWFNaMmx5QUVPMCtBMnNGSnIrK0d4WnhZ?=
 =?utf-8?B?aUVUR25BV25yekpnUXhJaFBYeFNyaXQ5RVZ4eEFXbktuS2tTQ3U2Ni95RlhX?=
 =?utf-8?B?L1dOdDBwNmFncW9hYnd1VVFoU1VsRThSaFpCdUxad1dHVkkvRlZCbW9nZFpH?=
 =?utf-8?B?aTlGNU5QbEZIdk8xMktGZDRST3ZxR3ptQ2E3MlBPL0g1WmFJVW1BZnFiWllK?=
 =?utf-8?B?V0FTQUNHNi9Tcmc1WENSVnRMSmtIdjJsSVpkMlJiT3lmc09SRklHUkIwbmlx?=
 =?utf-8?B?aXJCME5DUlBXblZ0dU83blF6cXEyWmowcXRiN1Q0Y0tOZ2tXMWs2K1VRbEFu?=
 =?utf-8?B?ODRKVlBzY3BlcUpYN2xpb21OMnhVUzdmNVR0NGxOc3hoY3VZRFBiSFU0K2hZ?=
 =?utf-8?B?cndwdG5DQ2tGVDlVWGpRcC9scWRicGxrR2h3MzhGckN5Y2JaKzE2UGFIcHRY?=
 =?utf-8?B?K29KaHlMZFppTkxnQzNXQTdjRkNTOHd2WWptSXcwbjJRT1RZMjlzYmxxTDhV?=
 =?utf-8?B?RVVRQnVHYmo4L2UxUGNYV1ArRi9TQVYxR2tjM3htZGFOcDA4L1h2UnU2QnlF?=
 =?utf-8?B?Z2hmdWRWbGUySE4zYk9VaWJDbjVUZlJpbDdiNVNsNWN6UXNHMTdsQXl1eTNG?=
 =?utf-8?B?ZVhRM1FPRk5IMUhjVFNtNys0eHN0NnF6ckwrR3lHZlVibDZ1Nm8yVVROQTMr?=
 =?utf-8?B?c0V3ME9YVEVnUkdXYzNCTGZSOWVUNzUvUHV0bk1HdFZ2SkxoRTNvRHBVWVpz?=
 =?utf-8?B?aXMvZWRzc0R2bTBxbEhJKzFHV3NLa3FJTTJUd1gvczZBY2tDekVPVVN1eEFZ?=
 =?utf-8?B?cGZJNFMweVlESDJpSEgwS251NFB6SkVGdDVIVjVtTnZDclZ6SXk4TG1rSXZq?=
 =?utf-8?B?WlhHRDBrT1JyaGpoc0tPZnM4QmlEM253TTVnWDVQOUJxRkRidkQzNG5TbGVH?=
 =?utf-8?B?TFZmTU4xSTJ0ZmZWR1pvNW9xazJPNjNMOTRnaldPQTY4Sms0ekN6cmNIcjdE?=
 =?utf-8?B?SjlvNkNBQWROVFNVVHJRNm1QR3FSNDRKTG1LNnNWTVdEUEQ0dU9qSzd0UDVX?=
 =?utf-8?B?SDlHK1IxV0tLS3JEZFhyYWFpLzhIOXFoWWdCZ2FCV2QyY0NIbEEvYzVTTFlJ?=
 =?utf-8?B?SWQ4TmtqVnlXb252bnJBNVUveFpVWEk4S2ZXSTIxV0djMkUreWRkT0ZleFBH?=
 =?utf-8?B?Q1JCQlU4TFFRVWpjc2I2V2h2OWFZenBoNmFuQVFxNWVMR2R1OWdPdjJzSFc5?=
 =?utf-8?B?TWdMUTV0WEI5a3ZNbk9lVEE3Y1ZlSzc1elord1RZOGw1cjh2cHB0RlRwbExh?=
 =?utf-8?B?c1Y4VysrN01ZUnV4R2lxN3hFZ0EwTUQ2L09uT0VoNmRVbFJiRUlJZTZLa05X?=
 =?utf-8?B?RlZEVm52b2JIenZIcFNJdGN3aWZMUTYwMGdBOVozYmJVNmRLVkJ5N3o5MlRK?=
 =?utf-8?B?dklmRXdmNXFoNjhXUHpjSVdaell1N1J5NWx0VzJTQXYyTndnVTdrU01nZEJB?=
 =?utf-8?B?T29NT1MwbnFjdS9ybFFIZThhekJla2t6cDFjVHBXTTZnL3VlZmlMY2l0bUN4?=
 =?utf-8?B?YWk3T29sY04wVUdjV3Ryb1poRkliZUV6UzltU0NJMjByN3BIbkZJNnFXd1JB?=
 =?utf-8?B?Nld4cytNRmhFbElLNjF0MC9UVDI1S0Z0Vkd6bHNYbldZZm85RFdHNHpPbk5W?=
 =?utf-8?B?ZzZLWThFZ3R5RS9vV21aUHBtY3BaWEU0MFZmdzJsSWhSMEduTGo1bVBwMXFY?=
 =?utf-8?B?aEJsU2Y5MGtRVkJpK1pPZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8151.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vlo3YjdKRU9GemlHWWp1aDRQNTg0YUpLcXcvb3c3TmpnVXVsUTFzcGhJa2ov?=
 =?utf-8?B?QWdMZXJkb203d2ZOellKNnRLNnVEQmtwNTBNdS8zdmN5Zm11NWxTL1RNaWtC?=
 =?utf-8?B?TUlBd3hzWENDZzRkN1BhcjdlUnF2TjJXa1NSUEI0Y2NxczJsNDhPUXZNWVZX?=
 =?utf-8?B?d0ZMbzdLRWZGL3RxV3prcCt2TlBsWXFOV3NUeUpzMHFTeEpFdUttbWxZblRm?=
 =?utf-8?B?bktnejdFbmV6K1RMOGFmR21YSWw1NEZ4U2hwbDBVU1dDNTVFclphc0lXVWt0?=
 =?utf-8?B?Ny9NdjlzbDh1b25RWFFxNWtxc2ZHNkFhZlNYb2Y4akhwMWFJWUJYWkFLNmlO?=
 =?utf-8?B?MnVCeldmMHAvVFlUbE90VTR0NG5sUWVNQlNaTTY4eDZNQUtFd0lhbjdFRWRn?=
 =?utf-8?B?a3NjSURHMnpUcWxXelgrMjNkakJNd05HdWJYSHJTRTBnaml6b3dFOXNFcFdN?=
 =?utf-8?B?eVdtVy9wbW9DSnhEQjNuYW5lKzFTZnlMenAzbHgzMHRCZFBYak5ZcERWTkZo?=
 =?utf-8?B?LyswQW9xQ2VvS3U5U2hmUVBJaDlhZExNQjBQWTRaSUhVeUxER05IbUFBTmVK?=
 =?utf-8?B?NzBMTGpFSmNUQlIwQi9QUTZLZDFaOUFMaUpmaXFJZ3JmUllGem9nVmtFTFlV?=
 =?utf-8?B?UlZjdnFwbndMMWxoNENRL3ZDQzU2L1dzNWtGeUlSL3EvY29OdWwvVjJqUlQz?=
 =?utf-8?B?OGVPdTgrZzc2Q25jdmdFWldScWFlN0lpbTVSVVQ0cjI5UlRHWmxDY3RkOGlL?=
 =?utf-8?B?QzhCS2kwQWZqOWxVdHN4dVdKOXpKbllFaG10alBkZEpkWHd6ZkxHVUlteWlW?=
 =?utf-8?B?YXJwWmU0VVROUDRDcHloSGt6Z2NJaXFvRFJtOWxuZjk0THFwK2d3UWtjOU1r?=
 =?utf-8?B?MDBoNjhMVGRTaVJHOXJlUEl4YXJLeDIyY2JJczZCMGlSYU5jVlAxOGpPejNW?=
 =?utf-8?B?VDMwSDluUldEUFM3NUY1U3RSZHdZNk1GRi91ZENrY0FRRVJkbFV4R3Nwb29v?=
 =?utf-8?B?VU9uTVUrdy9iVUlrNU1XeEViODBpRWpYZXZyV00vVnpmVWZmRXhqWHcwOXJj?=
 =?utf-8?B?N2JZcmNhbk1veHJ1SUtGcjlDNExCNEtFRVg4M2lmd09qYVA5Y0Jrd25EZVFQ?=
 =?utf-8?B?NHEvNXk2b1Z2M1VNc2V0Uk9JZTh2eGFMSzFCQmZVNU4vMzFFaUwzWk0vRHlF?=
 =?utf-8?B?UEtKVXB5bVNOdE95cTFiRlBPM2hLOWg0R0tGS2JnbGp2Y1lsbGFEREsxV0xU?=
 =?utf-8?B?Z3JOdDVUd2hXT1N2YjI4R1p0VlJpcWMwNTRLSzVOOGw1eCthS2VMbzBpTjh4?=
 =?utf-8?B?QUZMTjZZaDdlMktpNExsVlVLTEwzK05xU29tazQ4c0U5YUxFVzBHWUFOT2ZC?=
 =?utf-8?B?Vzc4eENUVG9Sdnk4S1U1VGZ5LzdwYWNwaTBvMm4xVitmZWtkV29aL1pTcVpa?=
 =?utf-8?B?NTJTeHVBaDVCUHBCRFBtTi9iSWR6ME9hZ3FOMHgzRTlOdFBYRU40a0h5NGpv?=
 =?utf-8?B?Y25GeTdrcWh4YnhabkcyYzJWUEVNS3B0cGxVeGpoZ3ZMV1EwaUNIbXMzdlZr?=
 =?utf-8?B?ZnFGRlhCM2d6SW91dHdJL054SFdVdHIrUG55NTkrRVVJdVJRaXlEVExYaEVx?=
 =?utf-8?B?V0dmcTVLWFhFemwzNGtlMm5CZG9aclpUNUxmbUxtQW9waWtyMzRTcDRDK0d2?=
 =?utf-8?B?TUp6WkhCVldwN3Ridm1nZnQrem01U2c0Sk9CVGFVVDVPZWVLRSsvZE9GL1cr?=
 =?utf-8?B?MTRERDFWWkhPVm5Cb3ZGNm9xbG9QV1pKYktORk5MSGcvUHVqdDhNWFh4ZXJE?=
 =?utf-8?B?Q3A2bFJRbXVvNUdId0J2VHJoOUtaaFFzTnNVUmZpbHB3UWdocVpYbHk5YzZ3?=
 =?utf-8?B?ZW0wa092MFdzaTNFYUtKVjFNQmlaZzB1TDBZVDJXakFoZC9jZHY0dUhHdHdJ?=
 =?utf-8?B?c0pzcG9pTk1sTUVkcmRzREIvRVU1V25SV1RPbHBMSnAranVwNE5RSzdkUjFt?=
 =?utf-8?B?Rm1sZU1YL2w3SWFVN3FFNmNJYzJmL3dDYjJPTTY2V2NzRTBteUF5NDJGMEk2?=
 =?utf-8?B?NEJ0ayttTjRtQnA0SW5zdGhvSWw1aVhEaVMvRmtYUmJxeWU3WmlyM1RDQUdU?=
 =?utf-8?B?RHdRMnBucDFxa0xiZjlEenRmaDZVMG4xeUFCWDRuTERTbFVNVzZqRlB2SkdZ?=
 =?utf-8?Q?TG+LA1zGIbc0+xabc/6dpSQ=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03720d6-6c02-4700-f90c-08dcc5f39a3f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8151.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 17:22:03.6717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5opmX9JIaNRQLH+MFMJbS6Uzi15PH2geivMc2dmXIvLV5vMKxEo0w6tIEqSWs1L+pBlhS0+Cn5XPQV/GqyESVvGWZ/c5d31o2kEMZei83ZDamILmNiWgBH0hoSixx0x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8250

On 8/26/2024 11:50 AM, Mathieu Poirier wrote:
> Apologies for the late reply - this got lost in the vacation email backlo=
g.
>
> On Mon, 26 Aug 2024 at 10:27, Dennis Dalessandro
> <dennis.dalessandro@cornelisnetworks.com> wrote:
>> On 7/31/24 4:02 PM, Doug Miller wrote:
>>> I am working on SR-IOV support for a new adapter which has shared
>>> resources between the PF and VFs and requires an out-of-band (outside
> It would have been a good idea to let people know what "PF" and "VF"
> means to avoid confusion.
"PF" refers to the Physical Function of the PCI adapter - that which
exists always, regardless of whether SR-IOV is active. The "VF" refers
to the virtual function(s) that are created when SR-IOV is enabled and
configured. Typically, the VFs and the PF are assigned to different OS
instances running in different VMs. So, the OS that owns the PF needs to
be able to handle resource requests from the OSes that own the VFs (and
also send notifications).
>
>>> the adapter) communication mechanism to manage those resources. I have
>>> been looking at RPMSG as a mechanism to communicate between the driver
>>> on a guest (VM) and the driver on the host OS (which "owns" the
>>> resources). It appears to me that virtio is intended for communication
>>> between guests and host, and RPMSG over virtio is what I want to use.
>>>
> Virtio is definitely the standard way to convey information between a
> host and a guest.  You can specify as many virtqueues as needed
> (in-band and out-of-band) and it is widely supported.  What
> information is conveyed by the virtqueues and how it gets conveyed is
> entirely up to the use case.  Have a look at the specification of
> existing virtio drivers to get a better idea [1].  If the driver you
> are working with hasn't been standardised, I highly encourage you to
> submit a draft for it.  If it has then add to the current
> specification.
>
> All that said, you could use RPMSG as the protocol that runs on top of
> the virtqueues - that should be fairly easy to do.
I had initially started looking at using virtio directly, but it looked
like I was going to have to get a new device ID defined upstream and it
would be a significant effort compared to using an existing facility. I
then saw device ID VIRTIO_ID_RPMSG, which appears to be exactly what
we'd have to create if we were defining a new virtio device for what we
need. However, the problem has been understanding how to write code to
provide the rpmsg "device" side. There does not appear to be any
documentation and there is no example code to follow. It seems that the
device side is typically contained in a GPU or accelerator, which was
not written for a Linux kernel. So I have many questions on how (and
when) to use the interfaces (rpmsg_register_device,
rpmsg_create_channel, rpmsg_create_ept, rpmsg_find_device, ...).
>
> Thanks,
> Mathieu
>
> [1]. https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd=
01.html
>
>>> Can anyone confirm that RPMSG is capable of doing what we need? If so,
>>> I'll need some help figuring out how to use that from kernel device
>>> drivers (I've not been able to find any examples of doing the
>>> service/device side). If not, is there some other facility that is
>>> better suited?
>> Hi Bjorn and Mathieu, any advice here for Doug? Adding linux-rdma folks =
as that
>> is where this will eventually target.
>>
>> -Denny
>>

External recipient

