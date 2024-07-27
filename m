Return-Path: <linux-rdma+bounces-4032-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10A793DC74
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jul 2024 02:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DBB0280C7F
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jul 2024 00:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3671B86F1;
	Sat, 27 Jul 2024 00:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LoLafOeo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C854D1B86E8;
	Sat, 27 Jul 2024 00:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722039377; cv=fail; b=uSxNHK/y5XnLPUUYnZp0M5a1nH0zB0J/fSasrsyl28IAnA3lQrQCakuMTtTpDeShZfGhtX9WCtv6jz4x6m2g+pk/CGSq5IM4K8LHzDDKtb8LsDpuVOdiNs7eYxn87kawW6NpC6+7EXoaHws8blRveGpKpf4njP9yomHBFci4m6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722039377; c=relaxed/simple;
	bh=14J3nTEEWz19n6/neYTiLmJH51/9qewwHnpDOqjoU6c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U4JJ1zZHA/eRbO82YCGg1Y29H3CCacujs5HCT+yAOM/AbHmCAuWtgsqN+KQ7iEJTW22RGilEPx6EK0kcFVVMwPQMCcDTAdklFqBV3+xs/ad2rOQbi6HbtozTRTly91UXCNgjw7jZMDCPLOHEoT6ZrNhS27bnm0igl0y/W49kIs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LoLafOeo; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722039375; x=1753575375;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=14J3nTEEWz19n6/neYTiLmJH51/9qewwHnpDOqjoU6c=;
  b=LoLafOeoJb1IyEQD6oCVIzr7scNeXUNGyIZcvxMNyomM7kFQwNOtSrvH
   /cZvoJ6vKYjJ8HyH4xngxI6GX7tcqJ5wK4uUn4VlUkHhBGje995wTpIc1
   kW8qjLELaj2tkkYqPIRXogSEz8pzgCPrN8qXmRvizu9hkbYERMw/4aEI4
   k3WPgmfI/PwyMeE0WEvBhFkbpB8W9PBYj3JnYuUpxoFxqZNces6WsfNHU
   VUV0T7roofdLyutsS6bDeWod8ws20vCxyWJ6SQnE5hMln668C88SMRkjl
   WhPqDltfrEZcR1I4ie7h5HHyvhoQt2lA+FCxjv+Eah+W/KDahugMzkAWG
   w==;
X-CSE-ConnectionGUID: jeVv55VLQLKt08v1MVqXkA==
X-CSE-MsgGUID: ZZCcWbSNQkG0FnwvtGAJbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11145"; a="42380281"
X-IronPort-AV: E=Sophos;i="6.09,240,1716274800"; 
   d="scan'208";a="42380281"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 17:16:14 -0700
X-CSE-ConnectionGUID: mP8tXgznRx+LD7KNTfhfHw==
X-CSE-MsgGUID: tdjXQPK2R0C/G5DUsmrqog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,240,1716274800"; 
   d="scan'208";a="53332743"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jul 2024 17:16:14 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 26 Jul 2024 17:16:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 26 Jul 2024 17:16:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 26 Jul 2024 17:16:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K84WAXMHlVdFk1ONO0MWw/u7ArHfiFKJKoUTPBUxzYKqOK4J8VWlDJgzRFG/L4OvYnKarvzmLFlBsaxxD8G6SQL6pX4tD9ngaYLYB74ERr6+AQYPdC3rIb2t+Z7sRENDmM5yZsMoxAYy4uGtwk0NblPv2U9HE+1d3TwF4stnNRspOHOFATwioyXbD7ymUEU3Dfb3tR88weYvPNwE19PBAQH7hScWw3Ws3IGrNwY6pw2YrHFG1P+hfIPlX4O2ecFvq+sOVqcPkMh2gYOB7LPDioU3jB8P116A2KJMB+GpiLjrNDU0ly6ovbNSNXoTDNmS9gfe8x/4L1B1vm5YBfDDzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8JuGsIkfqycruDdcrQmAZp1n/+d8ol1w2VBU2nIHv0=;
 b=ULo0L3fbtqdPMmP2DK05rnZ8NZPnQ9vH2kheGLSCrQVQfLS9kca5nxPYajSpcrZHBKKpeCinBYBnwP00ORKVh4cPRgwPv96BxJb5zv8oMKL/9L5YGynlxGrIacHD/1BOdKjZ1pJwacDF2xXBcQ/Te3ZwVt9SxP8Ljmje+LLxT+GW2WEngXpGfBczzaYeISodDKiOT00lzxGl6OyfJntx8SImru1rslagKaCLumqhvchH94VpzqZUAIjormPA+92MyfSe52tDcqboOzB4Tmund4zWlAA/+uv7/29Jbyo/5QlOQ2FN+6pTP5lSsZ1OwTar2HQoI2JLFASZTKsEBzIFqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5765.namprd11.prod.outlook.com (2603:10b6:510:139::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Sat, 27 Jul
 2024 00:16:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.027; Sat, 27 Jul 2024
 00:16:11 +0000
Date: Fri, 26 Jul 2024 17:16:08 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <ksummit@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <66a43c48cb6cc_200582942d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <20240726142731.GG28621@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240726142731.GG28621@pendragon.ideasonboard.com>
X-ClientProxiedBy: MW4P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: 1653f08e-c8e8-478b-75a1-08dcadd151de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GUFQAwQPkLXFeUxRBR0JB4fwlSDFBx2bRmeVQXZCrPYtDMppp0ye/iXXX81x?=
 =?us-ascii?Q?+bfntJBf7S/G6qExWAxE4JgeyVLm/cz3H7GR3gqCbLccmzNUevLONuSf/HV4?=
 =?us-ascii?Q?M7t+jhTcjxpye9b9EU2UL0X3nxSCoEctHgoq7qwQHE/5g+HCZeeG7vMxUvxJ?=
 =?us-ascii?Q?/bKLZdWFziMCkoF7ZXVBtp/+ALRx/QH0fGV2L2W8GnBJ/WHxv5AdjGNTKV0J?=
 =?us-ascii?Q?R4AzKUWGMTUKm8j0brSOwwfZMgtKvs3N/jIBsYaZqtRZCZVeyRtunVb207Up?=
 =?us-ascii?Q?/uaRBgOv5tvXjO381g5LLETmTu4/SUheqdk1DUHoPGjFfIMu0RQBMchGS4zU?=
 =?us-ascii?Q?+i+DQaUOmr9Hztl2yUVWV2krzpI+e0QzMvNSPVpMR9iwWdms9h9GYMqh2XyK?=
 =?us-ascii?Q?S8LcvI1qI8kj4flXilqFAvvRjZId/l++vsPg7H9pbXxSz83ljbpwv0DCiSsL?=
 =?us-ascii?Q?SYqa3ThfPJA61Broe/PhC18KHSpTr9QzT1mOZOMn3SNBbDltNbakaA1WCsHo?=
 =?us-ascii?Q?A+UDF38ZcSAizRRCBF3mk7Hx6801ZKLHOSqgzCAkU2qeBL/zEp4DU2+TfXmH?=
 =?us-ascii?Q?iBnmUHsuvycVRkVk4dLeoTFd9zj02Akx0PmMfP+b3KM0Kee0HmRWCdFOd1DK?=
 =?us-ascii?Q?AkW4T9RvyjIZ1XDWvv15uVSkPqiAg6J/kl3ZdzSPdecJ4XiPmLlN6Ob/YERf?=
 =?us-ascii?Q?TiCFmNT/DtoaBOungG5C2BvY8+/hMiEH0jL/UgminowVS0WL4d9WIOzFQ+r3?=
 =?us-ascii?Q?//NCCkXRXARhlNYODmeIwXjQ8TmEcry6tH9WGsjt8d7KWLotWnXjHyuAjBzl?=
 =?us-ascii?Q?e2DjXuwuBophlRkXl8io2uB2VvY4EmM7wSeEsPphq4W1rj8jnBEPTv+nYPem?=
 =?us-ascii?Q?zKqIvyqKKf8mfv3L2BZiR0qnNtz0BhbwdWVjkyqwTatFsDqXKOUBqa2vnwmi?=
 =?us-ascii?Q?RlIB8kVFTv7G18+b4Trxdy6gIJsdKoNYMYYeNh6sRKKE1MV/BqpFEUrVFZrd?=
 =?us-ascii?Q?6PbUVB/4NG327g1bwyDaA62SpUXXEi4BR0LsmFhsc3bmUdKDXuL6l1o6JDEB?=
 =?us-ascii?Q?IF+Mo/iOgOYFwB/8+YR1f4QypqfUthuq2dkxXEsrhHDMP0TUC6EDfACze7kQ?=
 =?us-ascii?Q?Wn0HwQUW+QBhyVqMTFGDXb7TBW7JRy+NTSTetZ/6vhRA0gKF2r8LA6Nkdd8b?=
 =?us-ascii?Q?Pvk0P92lRx0ACqmPmAeB93cpTyXccn6C5pPVGpQ7VKPJ+ebTwP67oZYA7fxC?=
 =?us-ascii?Q?sncjZC6wielqln6mifRUO45zAigt/0fILW5vYOikK7zID97WDYHKQuBmpEWZ?=
 =?us-ascii?Q?5zjjFLtfD/7XkArJsUJ8auFyr5mYJFIGrq4M706cgEjfdg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lm9PXKCo0lct29BonzvPLQBSTvT9pTe9p+C1+zydyAt7W2Y5Sao7hJs7coEE?=
 =?us-ascii?Q?wkon7leUxM3bfcf5ojr0skcyZOrG31SQaxhIXCX5XzHmWAbuQcVeKkcoPS25?=
 =?us-ascii?Q?ghqcARltuqKiZkV7NfZUhLoXY68rUwmooaxV5y5JyK73dqCKVR36tZhkomxv?=
 =?us-ascii?Q?my0tcISRqdYIJqX71uERm7vofpmCSM2hjAxUjK57i/Tj0Pesl+Zeg8qKyZMT?=
 =?us-ascii?Q?5V6RG8G28ZZWqKtbQ4RIvGuVopfWgROhvheikP8Wi2B+ScvucyQnUrfTTshi?=
 =?us-ascii?Q?07XX9zkR765OOOhQyoCWKNxOKG5Ki44eQ7s7fQ71L3pRRfj/PohNej7+W54H?=
 =?us-ascii?Q?05S0RAzAcvvfl5BRMszJxiBezjyb5hukrtKpgphFuYOAqHfnHO/B19mTF14Z?=
 =?us-ascii?Q?VQK7pgu2PRxwrrLt1KjYC1aSwp9qsjLSVmUH5w3DBhYZBd5uPlLT2o8OYTRK?=
 =?us-ascii?Q?22G9ahe7KsS9etpBN6PFM7pyKEF6SNnH0c2XnWfikc9V6vqujBI2M1vYS+oJ?=
 =?us-ascii?Q?wVfFVeowfHtRcP3EeibRe0zCrflaquhcTi9Xh2qB0EZ+9uPSXQNGuFuz1Sr4?=
 =?us-ascii?Q?R/LHn/pJzfk7SRnVLEWwitOcYCVacLBNCjCvmfvWXvGbHzbd0QuzmfFP23gx?=
 =?us-ascii?Q?xFgip07WIFmxXnNMuoo/yDbda43K+LlNE3AL/lrkIrchCxUT15PxkLmY0/My?=
 =?us-ascii?Q?q5iTSwuJXvbzTfaz06I5pKhsUjIRSJnmu2YzJjyuhDjIh8NbbDqczOQlheeG?=
 =?us-ascii?Q?7E3J+A/LqrKpDK+TWfQHn4T0Y6zPPq+ndr2Z10e0GzOcu1Qk3C9VeahSZPqi?=
 =?us-ascii?Q?/N9hxcDB20l9q7P0BvAwzkEB94HDTrcrCFVSlysW0eiKAvOhgf+PW3agU13Q?=
 =?us-ascii?Q?GDUVfNjHpOsgzBnMFHVAiDjfSX9aoFyp+vHFj8Gt0z1TkJCjqxbpe+bI//BT?=
 =?us-ascii?Q?t3mTqx7yCUEW1l94UMJ8XYgn62Gw1NDUYDahHgCS3vJ+6BiM+w2bMPpqOVsj?=
 =?us-ascii?Q?UyL+KvzRNbc6bO7UVnZW9nDZJNW3vIGnkwoYZj0PJYTGWtFJfBes2STUpmRB?=
 =?us-ascii?Q?Fk/kfn5pXGkIqVRpIyWtNZ1kHvqJRI6ru73rqWcUc51QTcRcktNpvnUaTyXl?=
 =?us-ascii?Q?KUbxboH4h+Kyqk7YmZUmBeL4rayEUFh4RaCfNj2qDEXwfsf6AXp+EUtwLyjK?=
 =?us-ascii?Q?VhhjDInlOD/lopuJ1veYZfjU3suEaTC3MYwSieq/fNNz0LOSNUvAR4qeT+CV?=
 =?us-ascii?Q?KCTIa/bABKQNGZebRf8Pv1o1aDRMpBqpfUJyXXvik8FaRpbmN2Mq1RKiSNOY?=
 =?us-ascii?Q?OJVyrmZm/H4ES/49sdIXu87euEWRKxrHQhb8IBQVfSIH1fWSAT476iirj5zZ?=
 =?us-ascii?Q?wjm/m0xSVzr3tyXqWLYkJp0Jex71/Wf3qCGVBCXw8LeY+SvNOlW6JcUYtoQK?=
 =?us-ascii?Q?s2lFD2bMfv04eF7MkX1jBxbliB9cExHRfWihMLIt3heVPyA/xDfG+Vj26exx?=
 =?us-ascii?Q?JgHOnVMIaUYFpHSGYPSYxHDRSle2PqihyUKl10THRfxqX3pLw2RrCk/QQSaY?=
 =?us-ascii?Q?DkpnsaCqaAkFjs0bR1T5z+//v96jQ6Enj9qXkp03gx+tDehqhah9EIkpffSZ?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1653f08e-c8e8-478b-75a1-08dcadd151de
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2024 00:16:11.4231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxWQ12EPw6kYWpyKjf5Vnr/StKklPyLx9jlvk3xYYAe00qWqaXlI9uoz6EiBIXPzfNVXzJaD2w6Z/OrKwjk8MpNIuipU+ExhJPgSP3Uty9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5765
X-OriginatorOrg: intel.com

Laurent Pinchart wrote:
> I know this is a topic proposed for the maintainers summit, but given
> the number of people who seem to have an opinion and be interested in
> dicussing it, would a session at LPC be a better candidate ? I don't
> expect the maintainer summit to invite all relevant experts from all
> subsystems, that would likely overflow the room.
> 
> The downside of an LPC session is that it could easily turn into a
> heated stage fight, and there are probably also quite a few arguments
> that can't really be made in the open :-S

A separate LPC session for a subsystem or set of subsystems to explore
local passthrough policy makes sense, but that is not the primary
motivation for also requesting a Maintainer Summit topic slot. The
primary motivation is discussing the provenance and navigation of
cross-subsystem NAKs especially in an environment where the lines
between net, mem, and storage are increasingly blurry at the device
level.

