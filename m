Return-Path: <linux-rdma+bounces-2673-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED868D3E8B
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 20:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3F02B23877
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 18:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D5015B139;
	Wed, 29 May 2024 18:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c06M1g1d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F7A140389
	for <linux-rdma@vger.kernel.org>; Wed, 29 May 2024 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717008610; cv=fail; b=Ds/LGym4jTbKgw41Akx/5xcikStaJ9NV3s998QNMViOcYNcX3iRrIYdxKvP5rX0NJPbZi2fuW/w4rXThgRnwYtBg4UYU/G8Ubnqd4kU31VQXABeRpTgJtWOAS0GywC0F5j/WJo+9qc9ArTOR7f9nGx/NCga47mmNSRwe7OadRSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717008610; c=relaxed/simple;
	bh=iYEVtyxOuUBz1LajIWYbNTF6ftYbixkq+Xy56pu/M/E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fU3qyGrn9SZTRKpCHXMWupY5J0UfLLV+U8DVHFt7qnSYg51WniKl2VKC2GxPqfwnA5i6pvq5+yS+7qm9JmGwDj33BoTuYgU5Lcb2AEUjPjomslvmIePeEbjcPOa0Al+kdUn726rxFIBrtd21vL8+gbQk9FNpMPuPQFtx6gM39o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c06M1g1d; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717008609; x=1748544609;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iYEVtyxOuUBz1LajIWYbNTF6ftYbixkq+Xy56pu/M/E=;
  b=c06M1g1d1E6lPxK4dfbcfB/eU+/Jg36yAABeEzpUVnyviguEhofuYxTq
   C1u9wPWfofRF02TCmxNL8OMBlDlgvENPsLt+i0+JwS5jH7mse04G7Rrz5
   flEuqT73UlTgVStsZENpuAinWQj4Md6Bw5WmhAzCP3ZLtys4FwkecojoP
   tJysbSGvqenP1vQos93V+bvZ/4NmRPnmrOVGru5P4CHKaBS6dm/zzCW9r
   1ahA7N/pMEcojk5SP+QvobukO/bSptlZ1ey3gLk0dc3gLr3uaIeNsjVPv
   XPPZCM5uiZ1Wgi0+w03hQI+5P9DpHyiS6Z8zq7fmTvkm+Sbtec67mnYzq
   Q==;
X-CSE-ConnectionGUID: k4SaWO5kTi6h5f/9gEz+sw==
X-CSE-MsgGUID: K+8jllskTgebKoAL5jdGKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="24049311"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="24049311"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 11:50:08 -0700
X-CSE-ConnectionGUID: Ry7Qh/AbTQCzL8tXJRPCQQ==
X-CSE-MsgGUID: IwClXz5TRN2aa3OPsQ/Ojg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35557505"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 11:50:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 11:50:07 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 11:50:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 11:50:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 11:50:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=in4T3my3DHBVJ+qeNZfEgDpZySd2voYN+bBP1ixISH6sbczaEaKZjL5Xh2NV/jYH1ZOGSyqe56QK6le6w9jN5sMlRdZ+T6/vD8Spn3kYl5MCFINbxkcu0l9U8yA0z3GmNDYtqfj3ILoTCNeXSh/A1FpdhPc5g5Bnc4x7DX6q9wNJ7L3kCzxrcNXoZsYnbcnvf8X2IdB97vExuf+FWZPv/kBSQKyaZqtWkXDjhggXXwl03ihwOkrWm7xBdSADd9stgDLD4O5mMrOqg7PKMbSKIg9UHLHJJZoV38YNQZOwllHXRE/5/NYywsed/YVYUNGHQ1KYU8sVRntGBg+qc+e1PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2HVPeXVAkQeGtwjM7Z0qlnAr3el++T+nETAEx8g6bo=;
 b=BzMxd5e6CJzQQHApVdgXerpWq+v+qN+BA2rLr4OAdQ5qnuJapaPlvXdtekM+AzXmZBzy2emBBp4hVJbNBVfEvQfbCS4+YVkdKFrNeSbsFKKMiQrItWdSO8QUPgLxujzMFqwuBCyhqGv2I4mWUVcBlgq4aJR0sIw+I0u6saLCIS9D3Ml9+ONOLRh7jr7kKlOERkly1LpBm6nI3vyHqqbYfUGZJd52Kon9RYQC0wYKRVvJtlmplw4bOPRWX1PPSN3I/r5npM249nKzMcrZvzWo5oYXuaZNswgbmdN8AmEezMXAOm5uemP5fl24elyr6hd3YWj8z2hJTyu5DutqXokqsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6895.namprd11.prod.outlook.com (2603:10b6:806:2b2::20)
 by DM4PR11MB7328.namprd11.prod.outlook.com (2603:10b6:8:104::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Wed, 29 May
 2024 18:50:04 +0000
Received: from SA1PR11MB6895.namprd11.prod.outlook.com
 ([fe80::6773:908e:651b:9530]) by SA1PR11MB6895.namprd11.prod.outlook.com
 ([fe80::6773:908e:651b:9530%5]) with mapi id 15.20.7611.016; Wed, 29 May 2024
 18:50:04 +0000
From: "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"kheib@redhat.com" <kheib@redhat.com>, "edwards@nvidia.com"
	<edwards@nvidia.com>
Subject: RE: [bug-report]rdma-core v51.0 build error with Rocky Linux 8.8
Thread-Topic: [bug-report]rdma-core v51.0 build error with Rocky Linux 8.8
Thread-Index: Adqnx6BozKwzKve5Tt+XbFDGYf6BwAFXOpkAADRYzdAAAV5KAAACJvKQAADTGQAA++vjEA==
Date: Wed, 29 May 2024 18:50:04 +0000
Message-ID: <SA1PR11MB689505F4DBDF8C5A7912D01E86F22@SA1PR11MB6895.namprd11.prod.outlook.com>
References: <SA1PR11MB68950882F65EE948009BF33986ED2@SA1PR11MB6895.namprd11.prod.outlook.com>
 <20240523151902.GJ69273@ziepe.ca>
 <SA1PR11MB68959864102CC0DA683FA28E86F52@SA1PR11MB6895.namprd11.prod.outlook.com>
 <20240524165704.GS69273@ziepe.ca>
 <SA1PR11MB689549B8852C1A337271747286F52@SA1PR11MB6895.namprd11.prod.outlook.com>
 <20240524182218.GT69273@ziepe.ca>
In-Reply-To: <20240524182218.GT69273@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6895:EE_|DM4PR11MB7328:EE_
x-ms-office365-filtering-correlation-id: 8a4bc9d6-1cbf-46da-6e0c-08dc801026fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?+WuIvRI1CaeQzs5OYR+uMZmz2Ee2Yaj5E/0OwjfifLTcPHzjiZ3uwpQr46nc?=
 =?us-ascii?Q?/6DlcCOxkw5yHo0ERB61vJpzXr+cCU2GxuJcKN9T+Wz2Sjdvf81PLbtHBWtx?=
 =?us-ascii?Q?ZYodUTXY0JhvqdPImtUq3iawoQfZLrtABLJEnZh3Z3koFmbveoDnEkNhfaoG?=
 =?us-ascii?Q?nYhYCtBGmAM/2ttKLjp9k+fdC5wB1Dk0pG/obPOS4HmWJC/rub2kF6gbLa64?=
 =?us-ascii?Q?Nbv6L01q5y+kNqTfUFczbNSfLyPA2gmFJRqVZiZ2TO1+1AgMXokHQcLP88kL?=
 =?us-ascii?Q?e89dkWxV+h9J5SafOc+Tlee94SBGK22qEwfDFKNtFEk5R9/F8KWJNI3m3zZI?=
 =?us-ascii?Q?TYFbZH2xpnB+4nw2irvA6RBWn5qh4QweWYVrIzEW/td5Y8Eb8W2UzbDD7tt2?=
 =?us-ascii?Q?gxKFCou93o7Naw9Px1S0gnBd3y3eSfN0qit9ro3nD3zUX/6glzrTCIuSL+Md?=
 =?us-ascii?Q?y8kWRsbNTlApynhjKcUrh5TFn7uVSgxJcgoDVyklrK+YMZd5tGN0lbJA6moo?=
 =?us-ascii?Q?a/5/8lenREd9xhA2SL508EbDFmBO52veou/ff0ycuR7hU55hr/BqBLcqPkL9?=
 =?us-ascii?Q?xihYolSKt4AN1+rwUbj8sRP8e7Bhcm52LJjcP7tS1mOa9XxfdbqAJlXF9vOq?=
 =?us-ascii?Q?Lom8aw6FBHe1BoKvVcPRqlSGSx3rx+lmteHXdHZJQth0I5jDEJEuS1a6kg8B?=
 =?us-ascii?Q?DIK4q2MQB0ZGXyfMYdmMw6k6NKI5r9Gj2e/JVAaJ1MbsAB8C1JboPiU4tcAC?=
 =?us-ascii?Q?MdtVMOES3+6KJGbzus6XJ6BiDTGU45f+tHiPnvmPO/kmrYBiHWpWNBsQitKs?=
 =?us-ascii?Q?4f0K+CenuCV7EY+gSnf6DnuCo7ndFYvL5zsh+GDlfy/1mwGK1Ojgj+frresa?=
 =?us-ascii?Q?wMWGwYKVpNTtBzjgJgVPzfzL26rkByilCxshSAEKnk9UZ0LniYe5REh1e/Wt?=
 =?us-ascii?Q?Il/7QSc325SxqiVfx4HykaYGB1Jw1Lacl6d5eWVUHIGfZIOohU+IK3VUT4a/?=
 =?us-ascii?Q?MTyZpK6wAGZq+4k9CUVMRtcabXyFFSJcQihIbHcJGxM8n8DPk/aNzbUMeeni?=
 =?us-ascii?Q?TE3BpxnW/XNslD59g5n5LyFn3010DBrJmZBVsI5WnHx66geijsABOGdy/Uoz?=
 =?us-ascii?Q?wYPzdwQgl1p1VLvY9OTk3k0O2476qRS8GF+60bOvM9LfEoomNTQCdd1SAkFt?=
 =?us-ascii?Q?3ljMBLvd0rCXaLI5dfHrHQnZPutYpZP6hGIEJ9R7Es3VI7G5Bfx9xSRwZAy9?=
 =?us-ascii?Q?cqGJ1hfJEhBkxI64LOjI0yQiM8hCHyMjC7tET4Pu6ZWAvAbUkw+9K5CAKiIx?=
 =?us-ascii?Q?XVacCks7raRXtiN//3mLi7yRIGCgsu6KxsrSJKzs1vwNHw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NCuM497+xnNUVngiRz7Z33l7MHNMHwfNG9q/Lw4qL32xtmv245ZdsUbRVgP5?=
 =?us-ascii?Q?dzFyRnCHW1LQhuZfjy6bXsQF6zaLVjzSzCmhHHjIM/V67iZwxUzYxvEf7/Fe?=
 =?us-ascii?Q?4PMgSCUiYg3Lz6ynuxZE8BFB5ifIRU4z/rXsvTlvr4zzRsQcUDJmp39DAGRP?=
 =?us-ascii?Q?3cfp4SJNZs6a0PSykQcABSHSZvHhxaRnxpuZzlp1BjrGWCyHgNsz/8RTEDIQ?=
 =?us-ascii?Q?7rD9fO8KkurD06p7lOCvvmojD1nftWvn73ieTj/haQtqKlcY4ctzy27u6Qc+?=
 =?us-ascii?Q?8QivJvl3ueWS5d8KntY1Df7qvOVKZO1fRs60AtWExw1ogZD2k480iOjg1Pv4?=
 =?us-ascii?Q?XHHw6NMSV1Iy047U8ow3b1mNFkEjaXVWWDEaLtmBh3PGZjfWl4Zx7pQhd+Ca?=
 =?us-ascii?Q?pWskO991q2yhh/y99d5z06LIErFq9bZmka/nhaV8wd62JaORSDT9kwzzwntu?=
 =?us-ascii?Q?PKXA/bCaj2ftyHXuOd9X8ayDEdJtK1U7sgnsomPA22ttjLdx8sXNvl6n9h0y?=
 =?us-ascii?Q?WlSFvxVNaypwZfo/Es/+lkxDZZ1WsUdRUOdXRbip0qreyamyyDyTl2gGK30/?=
 =?us-ascii?Q?4ROdMfUDE/RNZhaJMqSZL2dLpkNksEhixvl9qdXobq6b/WEyucFQeoiua/IY?=
 =?us-ascii?Q?qshMTFVyutMceikZQtE+iwLMk0jcby0ejlVFrGnAd83JM4GVv7XDjRHCbpOm?=
 =?us-ascii?Q?enbvpv8GE+8BSTOR7YAvvdsP5nVajiFM7GVhCi/jpaRsmQ5LtE0xl22zRmSt?=
 =?us-ascii?Q?gbiNTZLmcZ0MY2pOxctyg3kOCL1jLOieEu+imBFIswDkGnt+hXLshLL4S7qG?=
 =?us-ascii?Q?d6SGsohi+Yyh1aH9vN6t0eWobcJ+MyY49YC4RgMUY12Nwey8laA1j/5AeFuW?=
 =?us-ascii?Q?7T1dGaYGk3vRuHCPec0Lxdn+/mp9CWSdtaFGOiBg/UJwPxeF2FdssuXZb+vp?=
 =?us-ascii?Q?xDCtwfbqPtfIm+ACp5vFo95rZtl7Lio5put3RcoGH9etw1BJQXXyLKLwEA3z?=
 =?us-ascii?Q?1qCTuISX49I94FLxYpe5EkKUjW5l89g7TYHm1pbSA6aq+A/VEYyDf3GvX6Tc?=
 =?us-ascii?Q?rNunBRXpH33AXtm1yW41BjMDMq+UqH6onB58vbaUDJMz3iUkqPeGAx3HVJfC?=
 =?us-ascii?Q?+MQcFSRg7hYBP+O7X2yc7JGwrlWogHxDNEWpN1SrwX/WH3zNq2+E/T+kU2ID?=
 =?us-ascii?Q?6Si0KxNd8iHeft9KuvFh8o3NbxO+zxPEmAxj+wOnR+Cc2nNTJOIqzQvQE2LG?=
 =?us-ascii?Q?HLxjf/Wu3GQrRu6JZnGU7FRPaGu4dE1z94dBmQU3WeGahKqQIrOXfKQgpuv7?=
 =?us-ascii?Q?KqY7Kaw/GVLbQjPZWhkQ2bgL+Jux0nDV0amR1lrTYm1LNWL5LKOlI7WNfvZw?=
 =?us-ascii?Q?UhL+kBYT/I+MzPms1T15hT0TFtUmwqd4u0VayJk38E0soFYhKDN1Og8MlBbw?=
 =?us-ascii?Q?xvw2GdytVACFVmv3fkPbQ8bQ43NAvjBoFQ+H+k22frSFFfWcfxH7qYJO48QP?=
 =?us-ascii?Q?s4HKh69o4o0Ng5UBLZwgQ+wIB4zP0ai+O9vAqN0VoyfZLNnLh65Cx+xlhqQl?=
 =?us-ascii?Q?EjSrOA+cs1av64Fd8q++IRh/Bstz9yU1RuvajTxt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4bc9d6-1cbf-46da-6e0c-08dc801026fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 18:50:04.1207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D7W7BvCrPXZbatebUquXfuGZ8W79M8+J9wGJZ2DZ8DWNzSxVbjURKiGMXfWi7DRe3iYo7XnTfXpLSEGRDpVEimc4f33+M0J4I1zEFEHm/A8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7328
X-OriginatorOrg: intel.com

> > The Python_EXECUTABLE is workaround that can be applied to a spec file.
>=20
> OK, that is clear. If PYTHON_EXECUTABLE no longer works that is a well
> understandable issue.
>=20
> Something like this maybe?
>=20
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -216,6 +216,9 @@ endif()
>=20
>  # Use Python modules based on CMake version for backward compatibility
> set(CYTHON_EXECUTABLE "")
> +if (${PYTHON_EXCUTABLE})
> +  set(Python_EXECUTABLE ${PYTHON_EXCUTABLE})
> +endif()
>  if (${CMAKE_VERSION} VERSION_LESS "3.12")
>    # Look for Python. We prefer some variant of python 3 if the system ha=
s it
>    FIND_PACKAGE(PythonInterp 3 QUIET)
>=20
> Jason

Jason,

After a lot of more testing, I have found that the tip of the master branch=
 is ok!

These patches resolve the issue:
5dcc1f402 Improve python searching logic in buildscripts.
462a8737 build: Fix cmake warning

Technically, the earlier patch is the one that breaks the -D, and the secon=
d fixes that.

On a system with two python 3 interpreters, when PYTHON_EXECUTABLE is NOT p=
assed in from the command line,
the pyverbs is not built as expected, but the build otherwise works.

When it is, the pyverbs is built.

We can pull these two patches back to fix the issue to earlier versions as =
we need.

Thanks for your help!
Mike


