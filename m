Return-Path: <linux-rdma+bounces-4353-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF6B950B0F
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2024 19:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E8FDB23F5E
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2024 17:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A473225D4;
	Tue, 13 Aug 2024 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8PCJoH8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A1225779;
	Tue, 13 Aug 2024 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568651; cv=fail; b=oXOkmRxlwuV4BWiyXdadcz8YNR9xYc+ki/VFuHFSAzPnE8Q7/E74PvDHw0/YYYtxxLFBXkYbXd2V47UuZWUqNo61m/tFjC5iV+ilh89wEZhDHHnhxczfE1OccyLJ3nfewYSF89hrfBuzvjY2cRBLVxvq4W3wqwmmRM5MZhORMBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568651; c=relaxed/simple;
	bh=fLr1qSDRjWoFI1I4tGijsKOLxUXM3EokhibLbJRVYAw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tmu4VXEazCvR3eH/wyWq8CM1E0Cq92DwO+X0JwnZ/5xPffhjxbn8BGMFoS5/hYdy/7efv3D7Tu10odAr76LtwT2NvYr9/PHYjJkucvcMe/rLKMqMBkcv+jfUBhuKNra9Bq44MlGGurzwqAtd1KEC49J4Ap2UDZURhbfdM+lNJzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L8PCJoH8; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723568648; x=1755104648;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fLr1qSDRjWoFI1I4tGijsKOLxUXM3EokhibLbJRVYAw=;
  b=L8PCJoH8ma6CoFfrIRd76xNFN0yWrzdqTj3ibSld0Fqe9LcCvDUPV3Qy
   JZZDXedPl8vfZ0YbSpZfxAi747R1vQFNSzWg29lsK3CMgtEuaDCXFHrU5
   ilUd4NZWd8czyVGQeFyPI64J9mapMDRxZpHIvOJMwheI21cz47ObKwbiB
   AzFT6JVcLS+Nt1ED2PxIFL2l8fynOHVsiyGbG4uY8Xm92CpVKAPg26uTY
   BscMKtxKcUOnjFJgY1JGrVtZKDkMgDDvCbcugWVvpI0L9cFyuIPZ9yWnc
   9fDqCduLoq67QXZh6v39dcIDvHOKZC4CH1HOJctSjtcPCQcRQuNk6Uqfs
   g==;
X-CSE-ConnectionGUID: IEvq/thIR+C5O0JueDMfRQ==
X-CSE-MsgGUID: IvmNFrDMQc2SnpkrRTzRHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21893814"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="21893814"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 10:04:03 -0700
X-CSE-ConnectionGUID: 6+BAIltUQiCHmXRA497ziA==
X-CSE-MsgGUID: I7+CiI7jRH+m9ojDXsnjSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="63395962"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 10:04:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 10:04:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 10:04:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 10:04:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4lXSfd8SalwMllk9XDFMZsSn1pGuZ7cZW7O5Qj4RJ2RMDbGyb2LxtyFc3qMn/arJSBY4N/5XquQlQSclddJq4QdDbwoVwRe3Bk0nzG3Y1vxnPdilz5CnPtM0/qq1QO6c0JQM7v3q8Ud2Iq364UyM3JW8LUwvDyHlSrTgisvtmwdZiy33+1d1ZL+CaOGRXH6Awq28hobwfYEXUu6RJqWj3v56GjL1ryLQIvWnEgMJDEbEoiuV+WlNCNt+tRHrKxAQhGKYi/zc6bK4qZZ+9zFeegmREGXhYcMaIROT5bx4CkOSSMOYhMzw8pRdV4JS6zT/gbsj4X7mscxfKCKAq5ZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbj1qC/259NuojKuTk5O1BktveG8cKpRNtAcLJaK7jE=;
 b=m0nxGo217djVCX7dVFa2VylQonLRzGdBYMzLDKNzKDznaV/Hejk7tnexTQkMXNUs5AOLdFqh9ErW361sVX4m3pMIN1cpN9N6Hq9yniDB6s7dmlxB8DooXb8s6ZViNmTHPyMVFgZOA2hXKWkXQDvOtaBWM1LfWRT5FxDGYCCwZv2OBI4U+qno03gSxdkLjDWahOyZ3bKFR6F7tMNv4xsBiox07jCiefS/Pc7fzG4oy9glLXKrYKAlUjZlATh5yNQosODGIRhxp6ELTY4BqvJKDB9BMiMA7+lS3lD0Tot7GokV39wbr5bLJmZv6eBrZ9eQ9pdUekaXnpR/hAV/O5iZ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BY1PR11MB7983.namprd11.prod.outlook.com (2603:10b6:a03:52b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 13 Aug
 2024 17:03:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Tue, 13 Aug 2024
 17:03:59 +0000
Date: Tue, 13 Aug 2024 10:03:55 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@infradead.org>
CC: Martin Oliveira <martin.oliveira@eideticom.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "Artemy
 Kovalyov" <artemyko@nvidia.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Leon Romanovsky <leon@kernel.org>, "Logan
 Gunthorpe" <logang@deltatee.com>, Michael Guralnik <michaelgur@nvidia.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>, Shiraz Saleem
	<shiraz.saleem@intel.com>, Tejun Heo <tj@kernel.org>, John Hubbard
	<jhubbard@nvidia.com>, Dan Williams <dan.j.williams@intel.com>, David Sloan
	<david.sloan@eideticom.com>
Subject: Re: [PATCH v5 3/4] mm/gup: allow FOLL_LONGTERM & FOLL_PCI_P2PDMA
Message-ID: <66bb91fbcbe66_1c18294fe@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240808183340.483468-1-martin.oliveira@eideticom.com>
 <20240808183340.483468-4-martin.oliveira@eideticom.com>
 <ZrmuGrDaJTZFrKrc@infradead.org>
 <20240812231249.GG1985367@ziepe.ca>
 <ZrryAFGBCG1cyfOA@infradead.org>
 <20240813160502.GH1985367@ziepe.ca>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240813160502.GH1985367@ziepe.ca>
X-ClientProxiedBy: MW4PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:303:b7::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BY1PR11MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: 651b313a-503c-4347-2e56-08dcbbb9ec6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+DKWN2rmmAD5Tu6oexKge1RAmoyft//jmddeHQemMM4kv2U3xxwwRldkRtyc?=
 =?us-ascii?Q?FWmce6MSdECtnjUhRfJFaEUcoYd3iCfxwDDuyyOB8Inu5lIbkX694xQRQfqk?=
 =?us-ascii?Q?C4Bet0ZIShNufmEFQlj6cOLUup5PTs3JOJYl3JU0jh4H+z8QLBBMMDSfpo2k?=
 =?us-ascii?Q?Rj0ZS6m0rBgEDldhMNnjFMmNU/X9tgZqxyCTpgoNkRod0de1nXCJ4QPbqT8b?=
 =?us-ascii?Q?aXCyjuJC2+ijb9DnzwPQQIffyUWg3bEnnPewf6p/xkav5VB2dw7PAnyKNBQi?=
 =?us-ascii?Q?fkEyluNSe68x+pxRKx1sBhCbtM7ddCy+APDRY0QonTm+rhPjnR7c5jbQMFZf?=
 =?us-ascii?Q?lyu+nK/a2NUmbn5MCSwl4RitRgtpZGEcYtPHVoV8Imq7Dfq0oMglBGbdydlI?=
 =?us-ascii?Q?Qukbo0vD/phJ+tKn4uwirx6s6zsK3J5cLns35lzSPHq/0c6HY1nSaz07R76S?=
 =?us-ascii?Q?ILFo9TlhxSP2ZPOSeO69HdVlrK+6Wg56323GICfnjGKYXr3vozbRYD0BO1Jt?=
 =?us-ascii?Q?2FupelJLuOU0mxLrsWdqkLdOeXiLLdcvxJ04MPkqQEzjVz5cUabU5ocsCX8q?=
 =?us-ascii?Q?/aUuZfUjFVxojQB+oILEDF4QwttLygiS+3YPcic+L/Q1fbToriuuZscHgVmH?=
 =?us-ascii?Q?X50GakuQr8ktIc4VbbNaao8JxQ+3ooGKxXUtjD9d6rPGn6WK/zECef5T9NWW?=
 =?us-ascii?Q?L2N1HCo4w6oiiPnNXVdDM45r9LVGjivuLHnvUoh7/EmSvIjka086AcFhALWM?=
 =?us-ascii?Q?Be9mlrLt7G8fFGFR3FbJB3adjeLfRy7s17BNf/dJhN3SuuKFCQMzN5OBCkdT?=
 =?us-ascii?Q?jiOt1PlWP2RGPgy4sQbVsihtesoiZ56m+Hdp7V3VX20DPlJ4/CHWk7zPvd6x?=
 =?us-ascii?Q?dvpkzNANsYqXleLKg4XOvORsKDVb/XeRM/AeWkAqSnQLlsfKUsS+bbevIHSQ?=
 =?us-ascii?Q?JtM513bfR65uOgSNlJmGh1zumXo2nor/zn4AwPfww29uoWK/y+moxggDfYWg?=
 =?us-ascii?Q?MF5VWVoHL9XT2trDRUQ9GHsrECR7PDlKna929n2rp3LaMgMc08uYSpLLkRGM?=
 =?us-ascii?Q?D49hu764Qz0gDcgqiUTPvYquF+HKeclPkD13IYz6WHwqbRUGZixsLFQ8RVPS?=
 =?us-ascii?Q?DkdplGN6h9GDTa3urlgnJGxieowtDEIO8tMaSs/HCv8+llxNuKdiR98XPoa6?=
 =?us-ascii?Q?1XtkjoRoK345kierS05u6JmJQvDLi3P2d7swXboQ9jNNXFSIrKgTCU6dxHxi?=
 =?us-ascii?Q?WepTKlvJbF+JDQXTQ7U7/ZmE/sZOb304aDwexGcoWZOVomJCpM5k41P3PHzK?=
 =?us-ascii?Q?Wg3Uz9t/QBccpE4ot5vnNCZC/n9+H3Wv8hdG20566qJeeA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lGfzKb/lmxk2u26ZybeXAcfF/9DI/tosDuFOwp+rq3/mfJ5t4okcql7fhm3S?=
 =?us-ascii?Q?DmWxERfZWZb/U5FiB2pPSVlbC+FLmP5V5lwQv/7XISZoKOdM3WxsY+SKzdAD?=
 =?us-ascii?Q?rxPZ5T3wNf1n7LakHjmXremoPj/jLEAdDnViPM6hv95rMDj4wLTyTspnzfN2?=
 =?us-ascii?Q?sFY6qeFTnRJdnTdfDpx4j60tDg+lCtfZEjXSDGSJ53gPXtGtbyyp6DZttszo?=
 =?us-ascii?Q?J6NWMf0k7RY72ehti5LEdHwXV0YX1RGzb2hnSjxyBNFHAd+0L6TWHRvp58fJ?=
 =?us-ascii?Q?5Ae0rKTiRl7VOUTW6V0jPbQ2fVHJAiebdGDehi1t55+8vKk4SSLU3iptl8BH?=
 =?us-ascii?Q?D3gxJfWf5LxphICPDb+cCvqcFVWSPnL/AA7rFHc7y0erlIEiszZEt0h64c15?=
 =?us-ascii?Q?MFc/ns5Gt8JNui85yLtKeYmxRlGd/eseJk7k6wb3mt+xHN2UL6I/WRS/QibI?=
 =?us-ascii?Q?7E2aU8c32PnDRGt6w3EWjDSF5JTQNjSU1y6VShfwBluLIYeSYofzNlQ+kZip?=
 =?us-ascii?Q?SFEaGDT4c/XCiVAtCrkGSGu96emyAKyAjIAfDZl1H7HaXrZM10+Ly6ySTPCl?=
 =?us-ascii?Q?MWGan65P2MR569eLTDF2OQ2NdRKD+JNhqwCP8q3n/4dl19antXwHnFoVbjS5?=
 =?us-ascii?Q?PRKavXQ1ONjDb7ZJEMKtHAfJe6Knt9Imh67Yz0qnaZ4x4dUkPuA5ryvsiIYk?=
 =?us-ascii?Q?eR76pg3rB5y2qP8e/IC9ZfFg+RzV5lDn/Spj3QN9FjHXxBF2CWOJLjGUNLhL?=
 =?us-ascii?Q?cOr1C28/v+NUdF/MdSkQtAVL1nbDh9BsqFOw0ziYIXqpRWrUY1NrHRY/fvbQ?=
 =?us-ascii?Q?OT3AUZo1MSh+s1solBN04yo8lK4bv0Y7Vzd0AqaQVBrPMSzBPrGMJot6tviI?=
 =?us-ascii?Q?JnafqbyPfDlAv7nE8L0TTc09xHfjcAktFcLZfNC0SzfWct7WNn4YIfoWUfwY?=
 =?us-ascii?Q?q7OU3B/PzVoIcBxcqNL25gMezGI6YoZjV0X+UqCGMiN/s07X+hfUtwolpRU3?=
 =?us-ascii?Q?mUtetCul1Bx0NyoFsoE0cUxwmvFq1XjGnMFe3gKkJLCCYRUcyPUbqNHW9uW+?=
 =?us-ascii?Q?H3SqbKZ28ugxXl+D0Uq2Gnk4vGacMa9l9OM6X1PFhvBkCtQEOhrPaEfqwLMC?=
 =?us-ascii?Q?pzTcI3y7zzMBTBp+gJICePEINEBn8y76ZDRWPb2f6zjOuTSTZHATyiiH7mZr?=
 =?us-ascii?Q?oxq/9oytgGi7/xLULszFK19IXNxljT2ClH9abZ5sZBO8jLvr38Mjg8TgRRsP?=
 =?us-ascii?Q?1NRVATTiMbap9VDbTrSd7JweVZAp/0abCQBvvEWj3KzCHPVV42MIRla2Ccdo?=
 =?us-ascii?Q?/s6QxUQXIe8v3jc8mgasyPqA9a1RHHAYGd4kSgq9lBJQkdKRq6FAaHplWa+q?=
 =?us-ascii?Q?fQKevl3D3nwFxXkx3I4HdUK0EjYEIDOdKk+wotlfvvs1PVX3AosQl/oVhVPE?=
 =?us-ascii?Q?0RmlXaiN2yRIjdeglynstEPRILn1dQlBx2Nu4yq1DW77nSKgThd2lP/YZRcA?=
 =?us-ascii?Q?h+wIh7cLkoZbx8XL+qJVuwutmHpSpn/QE/XFbAS1J2P+CeVB1O7jbVBrL540?=
 =?us-ascii?Q?AsOH+5HKp0ZJ8QT5eL+SBtgrX3d19TKD+0dOlTuJVBM8U7fkU7NmNgCh7hOp?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 651b313a-503c-4347-2e56-08dcbbb9ec6d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 17:03:59.1242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJU/1sD8UqQU4OMRNmGWRJfLg9cwHMpKnawP8U98miJO0Vw+up3djFA6Yn1Q/FcMqqtF4ang6bEoryPYCi+kql9LV0dqCncWeqguq3xQo2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7983
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Mon, Aug 12, 2024 at 10:41:20PM -0700, Christoph Hellwig wrote:
> > On Mon, Aug 12, 2024 at 08:12:49PM -0300, Jason Gunthorpe wrote:
> > > > This is unfortunately not really minor unless we have a well documented
> > > > way to force this :(
> > > 
> > > It is not that different from blocking driver unbind while FDs are
> > > open which a lot of places do in various ways?
> > 
> > Where do we block driver unbind with an open resource?  
> 
> I keep seeing it in different subsystems, safe driver unbind is really
> hard. :\ eg I think VFIO has some waits in it
> 
> > The whole concept is that open resources will pin the in-memory
> > object (and modulo for a modular driver), but never an unbind or
> > hardware unplug, of which unbind really just is a simulation.
> 
> Yes, ideally, but not every part of the kernel hits that ideal in my
> experience. It is alot of work and some places don't have any good
> solutions, like here.

...but there is a distinction between transient and permanent waits,
right? The difficult aspect of FOLL_LONGTERM is the holder has no idea
someone is trying to cleanup and may never drop its pin.

