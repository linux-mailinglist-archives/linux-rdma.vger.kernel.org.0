Return-Path: <linux-rdma+bounces-9517-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED60A91C69
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 14:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360F61887B70
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 12:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AA6241136;
	Thu, 17 Apr 2025 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tc+SaKcL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03ED1E49F;
	Thu, 17 Apr 2025 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744893380; cv=fail; b=kpGlrunDOnfEYJAMfbJXFlkzCZzKc2THirdATtKqewcclPnBJsFcgeGEDfeE/yFwlpkeqofJUpxUv3bgDf504zWFwN44ugevvJ+CVxxiKTzJZP6bffCL5VF//paiElvppsrzzOEDHvjDUe6U1HtZrhMYYKzGP6Z0myyy/tEfXW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744893380; c=relaxed/simple;
	bh=ZJ8TrB0JnV27ERCPWlDyDg+gvUKSbL+va7I9xvHP+A0=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Tz3vVp9dA33d6AeQKknJx2G4loFS0wy0zVdD6DmyCmA11UY/dcHEFmV+nUFpgEBW9qV+tzg7913/Pzlh3qx7xoRIJnsUAIklYR/wqwqoRiciimv3i7OM2j4EWXzMjDKgrGtvDnwHvJEElnpKhsfYkOs4kpX0QC39utWKFIlAmTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tc+SaKcL; arc=fail smtp.client-ip=40.107.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAqaXBGcibuBtFv7TvKJE9xgOA7WudbY9y4q3XmsTBhontDJ/JKcXDV4s3V4FUUtbdvU0F51gSAuAlaBJCujSVFOY16EDIqKIvcS0xIi1PCQdif2RDgp0U5QE6io/iXtMivzZfwERhVF0Rf+V6di0JjQffd+CL0NYF7gaNGQHUqzm5zvfPc0V5XUrpUjsHUoE9sILW2AwPnQkZjhSqjmQDFW2+Q4fq5OVTMfcG7VNTYDVsOkM7IMGz4zgGxFl1ISNLrwee4KfyAvQwGaqlSsWmIuGEc4eGsBVUIi9LZZoGvHVZRARVk/V8hSxPCEsst2Brzn1MNjoXh5EDPSSAX6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7aderZH9A2Njfkf8seouf66kibJaCOrZSSLeFDnjd8=;
 b=oZ2X8yn+RR9aePmt7uYo1+KFH3ZE45Uiamy6mfKOpSpu5vFBDTIeBgApShgv6FfQKkzovDds3bpCcd/DwNZAmLVbPoatb0Gvq1uo/IyQOEXN/t9w+qZOVVtYGxnsfm/kVKnNimk1ku68lQyMJk7UONVwCTXHHEWV2Y+ytPjet0pDCkvAaXP/D/FwDLQ2F1xubxspSgCmmhY9whlJwreGwR2e/z4/DHItWESc8qK+vNoaTbZ7pr1kFWLMc2HKvjDf/kHVht4GyKbd7DP8s364NBq4jKKWEwUbHOGFkVPwXunZkafOquQqbA5KhD6j9nm/H8bfiJoCLdUaHiyTSrBzDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7aderZH9A2Njfkf8seouf66kibJaCOrZSSLeFDnjd8=;
 b=tc+SaKcLZsqcHT5ntt+Egw3k84MKOcTpBsmYTalQKXcfkdXYOkwDy1OUREywWRshRYF2BPAZM79gbJodtiwll20d6SoIzdWnRrYzdWe0+MjgpuG7KE25Ux10Ny0biCHzMSd1uqvEJuARoWPJRv52oP+fsF/9Im8oDl/Qg88A/joP1R4YdjQWQm3eb7mwqWBEc3iDWkBCCayRyky1ePaqFd3hbBwkTKX26sMkGX9VhbG+IuyucjHty7DE/J6FImG8cCmuR42oWHH7Jg01OSpz0kp8pU8BLC4HqmbIhK1gpqhXSQgEW0M0IGuGFVD7vmerZmLqK7pvYLhiY2/rwnHVtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB5742.namprd12.prod.outlook.com (2603:10b6:8:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Thu, 17 Apr
 2025 12:36:12 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 12:36:12 +0000
Date: Thu, 17 Apr 2025 09:36:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [GIT PULL] Please pull FWCTL subsystem changes
Message-ID: <20250417123610.GA1213102@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KaZWuqmqntIc7f8m"
Content-Disposition: inline
X-ClientProxiedBy: BL1PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0d55cc-8444-4df0-0074-08dd7dac6faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HzZdoYWdtmFynsZA0Iw4bzoVToyQHv57AKkAiQpu+OWWj3iR2OXhSfovgvX6?=
 =?us-ascii?Q?y/jzNWmVnGO7WRcJ55sYyEgWG+MpbRfjhDCbkpF5+cXT4dlJrX9+BHzgw7N/?=
 =?us-ascii?Q?b2/KW+GflimQhYdTU8nxAyGHzIX+usOybaCM6TtH69soYtPonSZYQ1N7cArK?=
 =?us-ascii?Q?nj65kw5KwbOM64gLUozsSxXiwN99a60TfUlIa4KdtegfIOa38NKBDJF1HXuu?=
 =?us-ascii?Q?4xzIboSYjHv++yu7RM8fTAIgYMzBpweaBE3lsjeeiUmhZXWoXaGRzVnZ7zzo?=
 =?us-ascii?Q?SLhhLTRB572E326fPAVR72hoezmfczBraecTzHnkm3eMCLjaJ0GNHC3YjG5K?=
 =?us-ascii?Q?ZP0DqwXMsMKwnzCemvvoMUuHy3puawHh627VcHC1/92+UQ69sFwXhO99Sfwj?=
 =?us-ascii?Q?UmoMSJsVh3lMLknM2CyfM0whExKoQp4NAeK/mESMZlk3I5wP0lvm+0XpNrMs?=
 =?us-ascii?Q?XDB0mG/BFcbi28qdCMQ5HfGCOh/Wnv78vQ34UYVXIZjQCqi4GFwRtB7fL+x/?=
 =?us-ascii?Q?up2QbKBMkB52GTTFOHgsojuW5Ck7NcHFbUBjovldlJRfyFiQPfcQLiwICJCp?=
 =?us-ascii?Q?ZuWa4dOLVSSOnSZS1AKnLSgDe/p2sA4HEqiWUdHPxndcLg7HcgNeEB4UCCYo?=
 =?us-ascii?Q?RXYfzbeqJNTMBspqN/JWudkmjPrY3SvQglBn9rbC6uv8Qo8/Svyqi4dRbBwg?=
 =?us-ascii?Q?B+qvecnTaqaeWZl3OK2+2uiTGe+1vNqiByRvveduiTubuBdHtu8cWISs48Kc?=
 =?us-ascii?Q?RVEZc/UeVMRCyNwPkbaN7xuxBKDUtF6SyyKlME42xkxGgnSx/44kQlaXb7jJ?=
 =?us-ascii?Q?NeEeoLJznFlkCO2cKXFMQgQqxukwf+y5ze9xSo1+l9GOyddWl85Ax4awYkn9?=
 =?us-ascii?Q?PX/hqVelOGgBh9d88pzT9oPS8EsIpT3/HTYDOyYb7jiSlPGa48D78haMRtyJ?=
 =?us-ascii?Q?tPAEv/sVvHFnNlbdTpDxJrVRVo/JepaUsjhqtOKX4jMXrFvMaricttcXwK/L?=
 =?us-ascii?Q?y3uAuV+4Hh9ZHo+W8Ppb74GLFlWSK6S1U+j+jvSealHsaeBrdvNkh5SHLpkF?=
 =?us-ascii?Q?rRvYam4HL4UOXcqUpNF7IpqqYg/WWrI10LAVCwMi16YAimdSDuQ95j98ZyPK?=
 =?us-ascii?Q?XVKQjPRMUMJUd2dBaPOTLaT5fdBZ18CZgs1aQfDfLpn33PGUTq5cxByL0gnc?=
 =?us-ascii?Q?cKzIUnqm6ZcajNUfY4xB3GY1nCAvQtmgTSTjZQ6J4OPC0s7jnVgGIgSOEcpO?=
 =?us-ascii?Q?/Fs4ruEQGcVWuBA3hikVGRgYbvSKG5F6I99cG9MYNc8a/MSKOOw3inx9Rr8C?=
 =?us-ascii?Q?7E7K5gtDBH9sNESrBq5e1WNT7DAQh7HjUjX0LYfzmv6I5ND1OL2hoR5kzOjM?=
 =?us-ascii?Q?3GyWbs1RDwWZs+msY/9/xRvcbkDlUOCzNUU3DuHlrY//W2ZUT7MOdiQWUZuY?=
 =?us-ascii?Q?/yEy7cy5hBs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KG1E3k0d8j/ZKOf8EKUag0+HA5pMV09jwj/VsGmffbMTxL/JIWBHJFyoh9Jl?=
 =?us-ascii?Q?P1+sZE0eMh9HwNEHfFl6t0un1LKXO9Udn5iL19BfhQj/knsTgZyqN+BTaKAY?=
 =?us-ascii?Q?y8Qr5h7wFEcncdJdIZrCBNI1YXMmCQRFI4k3qKi/LQSd7pWiHIuFITt5P1SO?=
 =?us-ascii?Q?IBsPECKLsTww/B7rPnfrhLy9KN76W+D+vAbjF6yQD6WzJsZ8liX7sFDjbYnV?=
 =?us-ascii?Q?3kTQMaO4oOIsP1u7nkUZTYGc1CWdJQxCl8HrnuhEHgH6z/tCdH4ODn+Qb98M?=
 =?us-ascii?Q?5diuljDjptspkgYwcN1WD6Pa03RsPt3L56rMVcYzUpwPn7wXq7qHepsyETvY?=
 =?us-ascii?Q?mFl7oCQQfc+2tMi/YKMP1qR42U/bPhhOfuNEg70a/G5qvol1LNgFTdMNX3kN?=
 =?us-ascii?Q?NdRKzvDsLkrJUp2SefhNGo2twgt0DQ9vhMAR8uhPopt5HQi6Nopg53iQqi/+?=
 =?us-ascii?Q?MHF/e8n5J0DEaO5fEygt4TSbHIL1+hRlyj9fSKT63coD5nEc3WxtfTbySkof?=
 =?us-ascii?Q?qDs8xtSyXBa1ymdWLJnD7pXx6eZqvtHTCgLKuHQXpqLe3p2DoL58tNdBbq+y?=
 =?us-ascii?Q?atZ8C+KEX6hGtQ5uu6gQQXvY5SZDAujHflKdDKiP6P87xT63R5kIJus6ab0E?=
 =?us-ascii?Q?+vLRI/BaY4vZYYhbEhhJrwE9nnfYpYv41gktQqQtksYgCjecyLA6miQFGIs5?=
 =?us-ascii?Q?fCeFAPhy3p1dM35cdyrEQHgO8gVhNl2AUyqullsKYpN6CvO/yYTnSHmmWcDD?=
 =?us-ascii?Q?LouzrLbHKEqCNFT7ON3L4A7WTwCMUE7DIjE2RHZwHQQiNUNan87YlD5m2XL6?=
 =?us-ascii?Q?mdZ3qAfHv6gKZiKWCoF494V0wxngCKwEpO/IAxmdpb9hJ3x65jHb//BnNsXs?=
 =?us-ascii?Q?wpU8m8PIUS+0QbvStj6558yIH5t+w4fBmgbeoKu1NEHcMbb+owFLZiuMo02J?=
 =?us-ascii?Q?uX+CBiZ/fOOuSyMlPdd+QotkQe2WAzo8l2xL5bo+8W2t8Yg+tSgyJmssz7MH?=
 =?us-ascii?Q?OEgidsSmC3Qu/JQqZ9K+kEC0EmtxupbusQoBYp/LuhggMWm65EfVRezutWUD?=
 =?us-ascii?Q?pAyrVdfeihNNrElqA8uU0gEg+B4beHxs2AFXsbUyxhpztalXMBdH8WutFyfh?=
 =?us-ascii?Q?6M0R6u9qk8ZzXJQwrpVgx2LQltBlPuYY2+6ciIUyt7eMXWcUmSReF2rGMP7Z?=
 =?us-ascii?Q?KNnfVhyC8ITivfnN3ghV/gMaOZFdHwF/hmwEGtpOVtsotonAzORCuaoD0s5f?=
 =?us-ascii?Q?mhB9keBzhKiJkHbGf9d//Tz/9ShpSonT1n/Y+MXp+E7veIIC3B3p5+4YK6FW?=
 =?us-ascii?Q?aWaWqo1NGjuLu9+Wilt2tfs6Bq7BQoLqaewZas4H9pCx4osPo3tfD2tVqL/G?=
 =?us-ascii?Q?J+d15RWNs26YXzks0C7J8JADPnh4jwvVBIFXXJxguIQLZkp30isuPcSSdyRg?=
 =?us-ascii?Q?QD2OxqUrlMcmQRkNjgiPuO09MJIqqfeRRl1ALZ7qZcprGLfx/+Qn48dpKaQu?=
 =?us-ascii?Q?LZi9gf21GkozaEYP1mHL4/I+kdg+efFEZ6c72Wry9m4o+jTvn4EldjbaoE/0?=
 =?us-ascii?Q?4+j4g39ppWFM2/PPGcSSbXbxzmLrihvXD4iLsMtC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0d55cc-8444-4df0-0074-08dd7dac6faa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 12:36:12.1385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0wegP3sUiVE4hVlGGC+eJ7MyFuzeYI5ohJKNLb2anPSiudGLMg7THj1HLOwtza8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5742

--KaZWuqmqntIc7f8m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

A few small updates, thanks

Jason

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus-fwctl

for you to fetch changes up to c92ae5d4f53ebf9c32ace69c1f89a47e8714d18b:

  fwctl: Fix repeated device word in log message (2025-04-11 20:47:45 -0300)

----------------------------------------------------------------
fwctl 6.15 first rc pull request

Three small changes from further build testing

- Don't rely on the userspace uuid.h for the uapi header

- Fix sparse warnings in pds

- Typo in log message

----------------------------------------------------------------
Dan Williams (1):
      fwctl/cxl: Fix uuid_t usage in uapi

Shannon Nelson (2):
      pds_fwctl: Fix type and endian complaints
      fwctl: Fix repeated device word in log message

 drivers/fwctl/main.c        |  2 +-
 drivers/fwctl/pds/main.c    | 33 ++++++++++++++++++++-------------
 include/uapi/cxl/features.h | 21 +++++++++++++++------
 3 files changed, 36 insertions(+), 20 deletions(-)

--KaZWuqmqntIc7f8m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCaAD1uQAKCRCFwuHvBreF
YRX0AQDVIbh0WXtwNsdGMkhSg3QQZW844fN8mscJfVNRebcOMQD/ZRaon0Whxrdg
7bXWwgWPHc0soeXTD0od9NQicRPdKwc=
=1ZEm
-----END PGP SIGNATURE-----

--KaZWuqmqntIc7f8m--

