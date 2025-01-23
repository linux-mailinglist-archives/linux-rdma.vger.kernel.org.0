Return-Path: <linux-rdma+bounces-7213-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B32A1A8CB
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2025 18:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF143A2A44
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2025 17:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA3316B3B7;
	Thu, 23 Jan 2025 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RZZ5zIoB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EDB157487;
	Thu, 23 Jan 2025 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652506; cv=fail; b=jQ2jI71gplkXJYb+j3bB0HGTVtWD94X3VmeZ9QTCkQuj09qWsnC+/ZkvzpwWrEhHPzjoHtZWllvPTS179mqKpJfEH2DuiJezhet7qwe38WXjY5/p634T5hzRrr3cxHKbfOnySuPpqyDtBi7indiuEibkZJ+i2VmYM9f/rDWmOGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652506; c=relaxed/simple;
	bh=WA4FghZNOiBYLBT7H9dEumjQ/mPMgVNLBH2+46/ykWI=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=YOOtqpiNYErc6d38i+jxZHXFdox23lNB/5UnHYNPdoc8ZPKt7CmsKI2HpbucjN1JTJmu+L9oMRncdr8JZVm06msZzROnGyYLxYETn4jJY6JF58CHc+zlLLihPGoamrUtQDGCU4C/oM83HtZwXt0MfJ/Ruqcdb3fc9+CeAUPyXHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RZZ5zIoB; arc=fail smtp.client-ip=40.107.96.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKVGg3ITIDypGTtHoSExeqSJQtx+JQrGZkZwnvC3/1a1b0TTNSFfnFiUkkzMdmpFKoqGX0WoG9q1xRt/Db1l89SWZLQHM5Qipq7pz1ft7OOpBwJ159IfkhuNLhS+6EtsGsedqnB++PfMuVCRF0gaLWJa1i8Dx9z1+0sl7QpHW2dKYVUdIxx3iZM8ouzKWySxtsXI8hCfDRvhHysYnwZSW7R65/2EY9QcaaJlwmaAXMjIiBVpQ0t+H9m7BU5gxgUXrOh+N31p9f43D9UtVWkxGsGCVILSd9X9jTVnGjW+U96NXdS3CfLchVCak++vRDU3CqTGkxMCRj1pFZrAQC8gOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+ihoFq49I3+RwI0MoskrXtWuragZhYEpl7j5LrWsyk=;
 b=LiDyT7agoFXNEgdVJzj3yJheCNlAx8jrpegfnlptYMZczaR9XBhpCDtgMCc9Yh5gHQ7VU+FFpS4iNJrwGpaTKcoLIPCtn6Oy80a5CianIDoBRdtL3OwnUW64uw5Qp+Ky5hLJEiRQ/Xc4EN8I/yckbYcpmqv7CTYrV5OBO+6x3fcrsP9bfQYhCJwOIS0FpwPT0gnNiZ8aI6aMYyVUh6Piu7BywuG0wzCPFAwZVFz8GPevQzPV6VsLBBXFylMDUryWl2HT3ePvK7tHMmtpGMRVzsGrydKkSd71oBaBAw2xm8C6LTOuYHR0b3+SQa50PXA4m5A0wHQejuVITpKlI7PYUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+ihoFq49I3+RwI0MoskrXtWuragZhYEpl7j5LrWsyk=;
 b=RZZ5zIoBnz7I2XYE1gQwOptyFv6OSctVzj3jMOqTqbYpcNPIC1EZMb9na5+lyQ9Z/HoSWU6n8B+hFQiO59fPZImN2fwan7GFUTVOl3OpO9TdP8gWtttSYjqrJoe2xcGBzga8Q+WZyzfn7HR1UbagqfNHjoMOfQ/nZxn8JHhmQLDOPOozAEsban8u/tf95/GWTpHRk+dWQhr8M0RCi9+djZEsRxWWhPytNq5gsa6+PUt+DBsm5n3jGZ6+1yqbe/yz2IVBoRh4tuBdnE1Sf9vfCyodhzP5K0kMgQSojyl5FX0Oul6zy319OujEUODMIIQNrmb2NLUzpdHul8vn6FNB/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Thu, 23 Jan
 2025 17:14:59 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Thu, 23 Jan 2025
 17:14:59 +0000
Date: Thu, 23 Jan 2025 13:14:58 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20250123171458.GA1053362@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gLSVxa/y6kCLAX/P"
Content-Disposition: inline
X-ClientProxiedBy: MN0P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: fe594941-bb1e-4a73-612c-08dd3bd17753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MS9yOU9rL3BZaHpVVE9NYzZ1UVphVHluSkVNY2VVY2g5cnlYNmVqb0E4dXlt?=
 =?utf-8?B?cjU5SWJLSWN4Si91Q0llYkZlNkFXNHhQNjgvak5nWTBTSzM4SG1mbkZFRmZn?=
 =?utf-8?B?bWRSLzUzSWgrb3FnZkNLSHQrTG5qb1F3aFZ4V2YvckNXY3FqNmtNSWVTaFQ3?=
 =?utf-8?B?SElrY3BMYmdaL2FNblJKVTROUlg4Zk1HMkJqRWtLazJyRE9NZ0N0WUJ3bFEv?=
 =?utf-8?B?eStGbEgwSTN4ZncwRzNWbGZVVFpCK2hRUk9VRWpOamZ5MER0YnAwc3RCQjNu?=
 =?utf-8?B?c3M2VTdvQk9JYmpHd1RYYVJWcEx3NGdabjFEeDNVUERkTHE5ZWM5SEdSeFpR?=
 =?utf-8?B?ZUdxb28zcGc4aTJGakZaQVFaVUlUQ0lpeU5GK3h4bnN6dGNFVGlTT2pQYytt?=
 =?utf-8?B?djBSRHlaS1hkSmJHdTBvZThSbk1sMFRFUVZiNkxjTUM0UVZhMVBpY1lBOG1T?=
 =?utf-8?B?NnJiWDlzMWxxaGhiemtWRDJDNjdGTjkwM3d0Z3JTSldhWU03Mks4L05rVGY0?=
 =?utf-8?B?OUxNYWN1N2tsOTRzaEtMYVU5c0JEckNYdGhYWFdxUlY1d3dpWUFuM2Nqemxh?=
 =?utf-8?B?bWc3ckg2aGt1Q2lUOUliNEhhT3RVUDBSV1RYcGtDejQ4S05nenl5M2ZaTGdy?=
 =?utf-8?B?OXY1R1hSaHpFa2pzVTlXN1lXTXFlcnlZMm9DMXhiSWVvU0lFTUNTRHp1dGpG?=
 =?utf-8?B?QjhEK3B6SDhORGFuU2xUbVpjUFNUZlJ3MFdqWU1qNFYzbE5jYmZWNitRKzI2?=
 =?utf-8?B?M2xYbWNqNzNRSFhBZU8yZi9leks4ZzIrK0F6M3ozNUl1ZEV4bSt6L1k5MlBh?=
 =?utf-8?B?REd4cG03UWVWNzVFc3k2YzFsU0x1UWY5VzBFOUVRcEpxc05VSVZob1V0dWJN?=
 =?utf-8?B?VkRZT0kvbFdXMVJ0SDB1MEpwU2tvUVhxS1kwTnZGS3FuYWRuamE4bnlYOHpz?=
 =?utf-8?B?VkFGc2ZXeURqL042aEI5Mmx4MWk3R3VzOGJ0TVlMdGtDbVFsTWJRTXg2bTc3?=
 =?utf-8?B?RXdoNEZRSzBhY256RFFFZkdVV0hxbVVYcTh3dXlyOWlPd0tHc2dLcktXZnhp?=
 =?utf-8?B?b3RORTZ3MEE2cTkyZERRcnMxVTdYZFl4ZHZCbTZwSWpBK0JUZ2FFRWJ0TnZw?=
 =?utf-8?B?M3Z1bVZoNlc2VlAzUmpKWnQ2WWRrdkRNZHpxWHVvZGZYQmZ6NXBvaVlPdE5P?=
 =?utf-8?B?UTMxTFVZeCtXRnowU012NW1DZzVrc04yZmdqT1QrZkpkSWFRaXZuN0hRUllV?=
 =?utf-8?B?cHJnYmhVQnR3THlYdXlIUlI0TVRkME1xNFdERWVlYUwxTE5oditlMXlrVU92?=
 =?utf-8?B?Z0cvUjRTQVhKSzRkcWpDVkxUVWszQXNUQ0djZGNlRVNRWWRRQXREUjFJSngz?=
 =?utf-8?B?RUN6aTJpVy9LZXN3NGREYXJmakM4K3NCNXJNeStCL2F1aktuUXBUdGJpaGpl?=
 =?utf-8?B?YytFMzUyam1CNkVzMS9DNk8yOEEvZ3FmcUNsb2gvNEdsdHlsN08xY0RLN2hR?=
 =?utf-8?B?RFlqSnF0a2JVSU9FRkVBM1JHUnQ5bkpVdlVha0ZwbzBETVRMUE5UL2VCSCtw?=
 =?utf-8?B?T1pIV2pRdUFVb0I4NFBPelMrMiszUHRNVTN3YWtGSkJSY3pZZUxBelhKcTNX?=
 =?utf-8?B?T1J5b1MxcGlPbkpDV3BNbG1CeGwxeEgwQTdsemZnUGhyeVRUZVRHcEdVQWN5?=
 =?utf-8?B?SlVvZ2UwOHJ3b2Npb3ZqdmFIUEFpRHhNR2J4dEhjU0hrM0JKZWhhMEFQRU1G?=
 =?utf-8?B?Ty9ONjZLcXljd0VHUEJrME5ZZUpjazR2SXEvRFZiZDVsbFRlQ3hwQkNYYUZP?=
 =?utf-8?B?MUR5UUNYN3RXTDhGODJTNXBjdHBicFU3L3ZRVGVzTWQ1Unk5Yk9OKzIvUjlB?=
 =?utf-8?Q?YFOFyyiorwYop?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGd6RXVRTktPbFlMeHRidHNoTURxMkN2KzRNZEJGQm93OGxaZnB6SWVYelRr?=
 =?utf-8?B?a2tHa0JFeFJqYjhhZlFUQUtmaDFIcU5tTTFML2wyWXp3dm5jck9iYzJ4V1Ry?=
 =?utf-8?B?OWtqd2NRM1Y2RVpFRU9oMStvSkZFSjZzMGcyMVJlSHc4cWN0UkVzdWJzU205?=
 =?utf-8?B?OXFHR1RCVDZyVWllOXNVN05JQ2xjb1UxOGhxNkdRYUFhM0NzSmhOTmxoTG1q?=
 =?utf-8?B?cUc5NGE2aHAvenA4RDlKcmUvdEJyaVRBaWE0d05XVXAzOGZQRmdQM0xFM1M0?=
 =?utf-8?B?d3phdGRmdHdJVm1XSC81NUVLWXhEc1J2M1k1cUZ4SHdyODZ5d2loWStCNVJk?=
 =?utf-8?B?Nnd3TE5pOFZyNHZhY2FmMzFWbzdxcGhIQmFQRndvMlZMSTk1b1haelNjcVUy?=
 =?utf-8?B?Z0d3cjFMUmdZWjJ2bUJzTHlWcUw5dDJFYzZQbHZ5amo0ZlJmQTZUbTZ2Wi9t?=
 =?utf-8?B?Y1RJcmV1VGd0WEc4WG56R0ZvRFRIQ0tyNG55NVBwUk1KTVYwS0JPNDlQTzMy?=
 =?utf-8?B?UXVMU0lHZjlkSHc1N2tTQjlmZzJ0ckR6Uno4bkdHTTFpOVl0cENiVzFaSkNB?=
 =?utf-8?B?bVVBaTVsRzJtMnREdzBrQU9GclkzdU5BcnBJblVIb0RTS3RueEl4Z3hpYjJs?=
 =?utf-8?B?RktXcWtiblJZOUd3Tk15cnk2UGRhb1k3S3ZJNEh3Yk9sY0Z1dmt1ZXduZEI4?=
 =?utf-8?B?c1FHZHdmbXRVOTRVUkZ1K0d2amtpcURsUG5DTzdqT2h1dEV5bGtGS1Nnc0JB?=
 =?utf-8?B?NDh5L0tmSUhWYW1pb29EcXlIV3dZU0pqelo1bHlvVjJ5TWtoM0t1WEYvbXds?=
 =?utf-8?B?STN1amI4VFFCRnZ2OUlSK0hodXJkRTYrYzhVV3dtUEk3V1REc1FyUStxNitm?=
 =?utf-8?B?dFdNa3dWYWg2STRvQitJamxVNXoxVjBwQ0xYOURNNEE0R0hPeEdZcFRLM0lt?=
 =?utf-8?B?aXM0Ly9nallmb3dqV012QmtCRnRXYmNHUTVxcWdtZW5zMVVVNmRrTE85dE5w?=
 =?utf-8?B?T1hyQWlwaW9PSnJuS2czcENFQVhRRzJZeUx0SFp0ZFZQS3FQUkdBV0xrekdJ?=
 =?utf-8?B?bVVkTFFybkdxeHVlNks3ZVFXUkp6TDBQbTNGU2pMTElpWUZScTV2Rk9TTG9B?=
 =?utf-8?B?Y2hhNzNnb2pQUDg1U08yWUp1RlV1SjB4THBBSDQ5U0hMK1ZVNHBRV2JvUkxM?=
 =?utf-8?B?aDhPYXJOaWs5N0ljQ0k1TUVZeW1PUS9nckRQVndTdVcwejV0MGp5Q2tNQ3ZD?=
 =?utf-8?B?aFNob3hUL0NBRllnak00T1FDcW1FNE9SSHYxSy9LYi9QTFo3eTZaaHc3NnRv?=
 =?utf-8?B?WUgyYnNNb0dRNDEvaklMZm5qeXc2Q3BzMEI0eTd5N3hMM0FwbVFyZTlqblZx?=
 =?utf-8?B?VTJiYSsrclYvUjBEQStYdnduellpQWk4WE9kaXEvT3gvZWxzUmtsemJmbnBZ?=
 =?utf-8?B?SG5KNm1xYU8xTkEwT3ZOTi9YNjhvSXMrWEV5TWhCMTJWQi9XVDEzWmZUSEl2?=
 =?utf-8?B?NE0xZk81bGlJK202amtSZ212Q1NUVTgwUXdBQlVrRVlxR0dteVRBejk3WUFT?=
 =?utf-8?B?MnpqN0hkTVE5OUVBeldCaG94SEtzQVd5djNvaXRtSmUzL0lUL1IrWkpEamNq?=
 =?utf-8?B?RFRUaU9OcURKQnVqbnJieURyVWE3cW9CRnJWOWJ4ZkNJMGMwc3Z0QmJySGNF?=
 =?utf-8?B?dkliWklwZXRUMlVLQVQxV0R2K3F4NVh0aFdHWlpPNHRPMWI2Z3hsem9YOU1u?=
 =?utf-8?B?WkhDTVZLejQ3QkluRTB5YlJkK2gyZUpsaTV1UjU0dGt6UkU2U2tTTjM4WTBi?=
 =?utf-8?B?dkVjUDQ3WnNLYTIxMWlqWXlSL0pwMmdzaWtBbHhMVTJudktTeEJySU1Ka3RO?=
 =?utf-8?B?L1RndzFUL1VKTlEyZUxPNzhVb1h1S0dFRmtKcE95dGZsVmlnNjNwQ25EQkgr?=
 =?utf-8?B?aE9aT1RVd3VXcDg2SUR6ZmFlZXh6cTNqWjkxenIrN292YktJSHhCZ05oUWtm?=
 =?utf-8?B?d05lK1N2ci9mNHB3SnRJOUljYWZHZk0va3lpclB0L0RZalhrQ2dKcDdSK0JL?=
 =?utf-8?B?djZoRGRZNHBYUW14SVB5aUJHdXZ0QmxIb0RhQStsUEUxSVo4dWpPTXN6dG5N?=
 =?utf-8?Q?n136f0hFG2WGdo+8auoQJIXX9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe594941-bb1e-4a73-612c-08dd3bd17753
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 17:14:59.4265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkzeIkxl94E3PgmyJjDGytUtosztjSu7Zvdxw7OmWM+0KTJQAu5u0vCCVFpKImy7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743

--gLSVxa/y6kCLAX/P
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

As seems to be typical, this is a smaller PR probably due to the
holidays, but also normalish for RDMA right now. The new ROCEv2 support
for ERDMA stands out as the largest functional change.

There are some non-trivial merge conflicts with the RDMA -rc branch,
it took a couple of rounds with Stephen to get things sorted, but this
is what has been in linux-next for a while now.

    https://lore.kernel.org/r/20250106105106.3d94b0c3@canb.auug.org.au
    https://lore.kernel.org/r/20250106120252.000a2afa@canb.auug.org.au
    https://lore.kernel.org/r/20250106111307.7d0f55ba@canb.auug.org.au

I've also prepared the tag for-linus-merged with the agreed linux-next
merge resolution using v6.13 that you may prefer to pull instead of
this unmerged tag.

Otherwise, here is git show of my merge commit, which matches
linux-next, for reference:

diff --cc drivers/infiniband/sw/rxe/rxe_net.c
index d400aaab0e7000,8cc64ceeb3569b..132a87e52d5c7e
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@@ -577,7 -595,13 +585,13 @@@ void rxe_port_down(struct rxe_dev *rxe
 =20
  void rxe_set_port_state(struct rxe_dev *rxe)
  {
- 	if (ib_get_curr_port_state(rxe->ndev) =3D=3D IB_PORT_ACTIVE)
+ 	struct net_device *ndev;
+=20
+ 	ndev =3D rxe_ib_device_get_netdev(&rxe->ib_dev);
+ 	if (!ndev)
+ 		return;
+=20
 -	if (netif_running(ndev) && netif_carrier_ok(ndev))
++	if (ib_get_curr_port_state(ndev) =3D=3D IB_PORT_ACTIVE)
  		rxe_port_up(rxe);
  	else
  		rxe_port_down(rxe);
diff --cc drivers/infiniband/sw/rxe/rxe_verbs.c
index dad3cacb904880,8a5fc20fd18692..6152a0fdfc8caa
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@@ -55,10 -62,9 +62,10 @@@ static int rxe_query_port(struct ib_dev
  	ret =3D ib_get_eth_speed(ibdev, port_num, &attr->active_speed,
  			       &attr->active_width);
 =20
- 	attr->state =3D ib_get_curr_port_state(rxe->ndev);
++	attr->state =3D ib_get_curr_port_state(ndev);
  	if (attr->state =3D=3D IB_PORT_ACTIVE)
  		attr->phys_state =3D IB_PORT_PHYS_STATE_LINK_UP;
- 	else if (dev_get_flags(rxe->ndev) & IFF_UP)
+ 	else if (dev_get_flags(ndev) & IFF_UP)
  		attr->phys_state =3D IB_PORT_PHYS_STATE_POLLING;
  	else
  		attr->phys_state =3D IB_PORT_PHYS_STATE_DISABLED;
diff --cc drivers/infiniband/sw/siw/siw_verbs.c
index 592a015cc4c6a0,7ca0297d68a4a7..5ac8bd450d2407
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@@ -178,13 -178,21 +178,20 @@@ int siw_query_port(struct ib_device *ba
 =20
  	rv =3D ib_get_eth_speed(base_dev, port, &attr->active_speed,
  			 &attr->active_width);
+ 	if (rv)
+ 		return rv;
+=20
+ 	ndev =3D ib_device_get_netdev(base_dev, SIW_PORT);
+ 	if (!ndev)
+ 		return -ENODEV;
+=20
  	attr->gid_tbl_len =3D 1;
  	attr->max_msg_sz =3D -1;
- 	attr->max_mtu =3D ib_mtu_int_to_enum(sdev->netdev->mtu);
- 	attr->active_mtu =3D ib_mtu_int_to_enum(sdev->netdev->mtu);
- 	attr->state =3D ib_get_curr_port_state(sdev->netdev);
+ 	attr->max_mtu =3D ib_mtu_int_to_enum(ndev->max_mtu);
+ 	attr->active_mtu =3D ib_mtu_int_to_enum(READ_ONCE(ndev->mtu));
 -	attr->phys_state =3D (netif_running(ndev) && netif_carrier_ok(ndev)) ?
++	attr->state =3D ib_get_curr_port_state(ndev);
 +	attr->phys_state =3D attr->state =3D=3D IB_PORT_ACTIVE ?
  		IB_PORT_PHYS_STATE_LINK_UP : IB_PORT_PHYS_STATE_DISABLED;
 -	attr->state =3D attr->phys_state =3D=3D IB_PORT_PHYS_STATE_LINK_UP ?
 -		IB_PORT_ACTIVE : IB_PORT_DOWN;
  	attr->port_cap_flags =3D IB_PORT_CM_SUP | IB_PORT_DEVICE_MGMT_SUP;
  	/*
  	 * All zero

Thanks,
Jason

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to d3d930411ce390e532470194296658a960887773:

  RDMA/mlx5: Fix implicit ODP use after free (2025-01-21 14:10:49 -0400)

----------------------------------------------------------------
RDMA v6.14 merge window pull request

Lighter that normal, but the now usual collection of driver fixes and
small improvements:

- Small fixes and minor improvements to cxgb4, bnxt_re, rxe, srp, efa,
  cxgb4

- Update mlx4 to use the new umem APIs, avoiding direct use of scatterlist

- Support ROCEv2 in erdma

- Remove various uncalled functions, constify bin_attribute

- Provide core infrastructure to catch netdev events and route them to
  drivers, consolidating duplicated driver code

- Fix rare race condition crashes in mlx5 ODP flows

----------------------------------------------------------------
Advait Dhamorikar (1):
      RDMA/erdma: Fix opcode conditional check

Anumula Murali Mohan Reddy (1):
      RDMA/cxgb4: Notify rdma stack for IB_EVENT_QP_LAST_WQE_REACHED event

Boshi Yu (12):
      RDMA/erdma: Probe the erdma RoCEv2 device
      RDMA/erdma: Add GID table management interfaces
      RDMA/erdma: Add the erdma_query_pkey() interface
      RDMA/erdma: Add address handle implementation
      RDMA/erdma: Add erdma_modify_qp_rocev2() interface
      RDMA/erdma: Refactor the code of the modify_qp interface
      RDMA/erdma: Add the query_qp command to the cmdq
      RDMA/erdma: Support UD QPs and UD WRs
      RDMA/erdma: Add missing fields to the erdma_device_ops_rocev2
      RDMA/erdma: Fix incorrect response returned from query_qp
      RDMA/erdma: Support non-sleeping erdma_post_cmd_wait()
      RDMA/erdma: Support create_ah/destroy_ah in non-sleepable contexts

Chiara Meiohas (1):
      RDMA/mlx5: Extend ODP statistics with operation count

Dan Carpenter (1):
      rdma/cxgb4: Prevent potential integer overflow on 32bit

Dr. David Alan Gilbert (6):
      IB/hfi1: Remove unused hfi1_format_hwerrors
      RDMA/irdma: Remove unused irdma_cqp_*_fpm_val_cmd functions
      RDMA/core: Remove unused ib_ud_header_unpack
      RDMA/core: Remove unused ib_find_exact_cached_pkey
      RDMA/core: Remove unused ibdev_printk
      RDMA/core: Remove unused ib_copy_path_rec_from_user

Junxian Huang (1):
      RDMA/hns: Clean up the legacy CONFIG_INFINIBAND_HNS

Kalesh AP (11):
      RDMA/bnxt_re: Remove extra new line in bnxt_re_netdev_event
      RDMA/bnxt_re: Remove unnecessary goto in bnxt_re_netdev_event
      RDMA/bnxt_re: Optimize error handling in bnxt_re_probe
      RDMA/bnxt_re: Eliminate need for some forward declarations
      RDMA/bnxt_re: Remove unnecessary header file inclusion
      RDMA/bnxt_re: Fix to drop reference to the mmap entry in case of error
      RDMA/bnxt_re: Add Async event handling support
      RDMA/bnxt_re: Query firmware defaults of CC params during probe
      RDMA/bnxt_re: Add support to handle DCB_CONFIG_CHANGE event
      RDMA/bnxt_re: Pass the context for ulp_irq_stop
      RDMA/bnxt_re: Allocate dev_attr information dynamically

Leon Romanovsky (3):
      RDMA/mlx4: Avoid false error about access to uninitialized gids array
      RDMA/mlx4: Use ib_umem_find_best_pgsz() to calculate MTT size
      RDMA/mlx4: Use DMA iterator to write MTT

Li Zhijian (1):
      RDMA/rtrs: Add missing deinit() call

Ma Ke (1):
      RDMA/srp: Fix error handling in srp_add_port

Michael Chan (1):
      bnxt_en: Add ULP call to notify async events

Michael Guralnik (1):
      RDMA/mlx5: Fix indirect mkey ODP page count

Michael Margolin (1):
      RDMA/efa: Reset device on probe failure

Patrisious Haddad (2):
      RDMA/mlx5: Fix link status down event for MPV
      RDMA/mlx5: Fix implicit ODP use after free

Selvin Xavier (1):
      MAINTAINERS: Update the bnxt_re maintainers

Thomas Wei=C3=9Fschuh (2):
      RDMA/hfi1: Constify 'struct bin_attribute'
      RDMA/qib: Constify 'struct bin_attribute'

Yishai Hadas (1):
      RDMA/mlx5: Fix a race for an ODP MR which leads to CQE with error

Yonatan Nachum (1):
      RDMA/efa: Align interrupt related fields to same type

Yuyu Li (12):
      RDMA/core: Add ib_query_netdev_port() to query netdev port by IB devi=
ce.
      RDMA/core: Support link status events dispatching
      RDMA/bnxt_re: Remove deliver net device event
      RDMA/erdma: Remove deliver net device event
      RDMA/irdma: Remove deliver net device event
      RDMA/rxe: Remove deliver net device event
      RDMA/siw: Remove deliver net device event
      RDMA/usnic: Support report_port_event() ops
      RDMA/mlx4: Support report_port_event() ops
      RDMA/pvrdma: Support report_port_event() ops
      RDMA/mlx5: Handle link status event only for LAG device
      RDMA/hns: Support fast path for link-down events dispatching

Zhu Yanjun (1):
      RDMA/rxe: Fix the warning "__rxe_cleanup+0x12c/0x170 [rdma_rxe]"

zhenwei pi (1):
      RDMA/rxe: Fix mismatched max_msg_sz

 MAINTAINERS                                    |   1 +
 drivers/infiniband/core/cache.c                |  35 --
 drivers/infiniband/core/device.c               | 116 +++--
 drivers/infiniband/core/ud_header.c            |  83 ----
 drivers/infiniband/core/uverbs_marshall.c      |  42 --
 drivers/infiniband/hw/Makefile                 |   2 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h        |   5 +-
 drivers/infiniband/hw/bnxt_re/hw_counters.c    |  11 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c       |  47 +-
 drivers/infiniband/hw/bnxt_re/main.c           | 339 +++++++++------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h       |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_res.c      |   7 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h      |   4 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c       | 117 ++++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h       |   6 +-
 drivers/infiniband/hw/cxgb4/device.c           |   6 +-
 drivers/infiniband/hw/cxgb4/qp.c               |   8 +
 drivers/infiniband/hw/efa/efa.h                |   8 +-
 drivers/infiniband/hw/efa/efa_com.h            |   6 +-
 drivers/infiniband/hw/efa/efa_main.c           |  28 +-
 drivers/infiniband/hw/erdma/Kconfig            |   2 +-
 drivers/infiniband/hw/erdma/erdma.h            |  14 +-
 drivers/infiniband/hw/erdma/erdma_cm.c         |  71 ++--
 drivers/infiniband/hw/erdma/erdma_cmdq.c       |  26 +-
 drivers/infiniband/hw/erdma/erdma_cq.c         |  65 +++
 drivers/infiniband/hw/erdma/erdma_eq.c         |   6 +-
 drivers/infiniband/hw/erdma/erdma_hw.h         | 135 +++++-
 drivers/infiniband/hw/erdma/erdma_main.c       |  62 ++-
 drivers/infiniband/hw/erdma/erdma_qp.c         | 301 ++++++++++---
 drivers/infiniband/hw/erdma/erdma_verbs.c      | 568 +++++++++++++++++++++=
----
 drivers/infiniband/hw/erdma/erdma_verbs.h      | 166 ++++++--
 drivers/infiniband/hw/hfi1/hfi.h               |  14 -
 drivers/infiniband/hw/hfi1/intr.c              |  31 --
 drivers/infiniband/hw/hfi1/sysfs.c             |  14 +-
 drivers/infiniband/hw/hns/Kconfig              |  20 +-
 drivers/infiniband/hw/hns/Makefile             |   9 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c     |  13 +
 drivers/infiniband/hw/irdma/osdep.h            |   4 -
 drivers/infiniband/hw/irdma/protos.h           |   4 -
 drivers/infiniband/hw/irdma/utils.c            |  71 ----
 drivers/infiniband/hw/mlx4/cq.c                |   6 +-
 drivers/infiniband/hw/mlx4/main.c              |  60 +--
 drivers/infiniband/hw/mlx4/mlx4_ib.h           |  18 +-
 drivers/infiniband/hw/mlx4/mr.c                | 286 +------------
 drivers/infiniband/hw/mlx4/qp.c                |  12 +-
 drivers/infiniband/hw/mlx5/main.c              |   4 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h           |   6 +
 drivers/infiniband/hw/mlx5/mr.c                |  17 +-
 drivers/infiniband/hw/mlx5/odp.c               |  70 +--
 drivers/infiniband/hw/mlx5/restrack.c          |   9 +
 drivers/infiniband/hw/qib/qib_sysfs.c          |  16 +-
 drivers/infiniband/hw/usnic/usnic_ib_main.c    |  73 ++--
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c |  66 +--
 drivers/infiniband/sw/rxe/rxe_net.c            |  22 +-
 drivers/infiniband/sw/rxe/rxe_param.h          |   2 +-
 drivers/infiniband/sw/rxe/rxe_pool.c           |  11 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c          |   6 +-
 drivers/infiniband/sw/siw/siw_main.c           |   8 -
 drivers/infiniband/sw/siw/siw_verbs.c          |   5 +-
 drivers/infiniband/ulp/rtrs/rtrs.c             |   3 +
 drivers/infiniband/ulp/srp/ib_srp.c            |   1 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c      |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c  |  39 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h  |   8 +-
 include/rdma/ib_cache.h                        |  16 -
 include/rdma/ib_marshall.h                     |   3 -
 include/rdma/ib_pack.h                         |   3 -
 include/rdma/ib_verbs.h                        |  24 +-
 68 files changed, 2009 insertions(+), 1254 deletions(-)
(diffstat from tag for-linus-merged)

--gLSVxa/y6kCLAX/P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZ5J5EAAKCRCFwuHvBreF
YcH5AQCW1oKLfxsjtN/9MJz44RRHrzVEHB7pU8sUxp1ZSJq4sAEAsK+xlKAw03Ln
+tKOZ/C11sn2q6Rq3qsULdA7WI5qBAA=
=ByEb
-----END PGP SIGNATURE-----

--gLSVxa/y6kCLAX/P--

