Return-Path: <linux-rdma+bounces-2610-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEE68CE974
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2024 20:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3430FB21D82
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2024 18:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB753BBF2;
	Fri, 24 May 2024 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WlwoXU1H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDEC3FB1C
	for <linux-rdma@vger.kernel.org>; Fri, 24 May 2024 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575103; cv=fail; b=Rijzv5fJpm7Jq1V916d9haxmpdvwWb3ZpaOV8u336ys4DzY63+EG0x7ZTogciNSV5+xAb02fMZi9buWkXYIsdmx6cxmoM5PWK37Lc6ysLKOL4nJJC9zvwoTtAoswBczf98I1gGyAmMPEN64t7moOwwD2E94r+hHxili23h9gJkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575103; c=relaxed/simple;
	bh=VxzmtHFL7o4NR4bOyWK5VVKIMRQfUP/9Vupxuy/vt5Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tz/Ni7k+qq9CPZGxLmb9eZtakjfKdjalVNzcWR8Dy7uZDcjzgVy34BnNAylaUYy3blKAQb+v0p+mqHX+K6neiC+GAVkwvPdgGeyHuFOreewbdU70+lC/E9vwiHNXIYVlBIYVsQgdN4B8OOibBfpezd0ywrZDKUstfffNr2/+QmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WlwoXU1H; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716575102; x=1748111102;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VxzmtHFL7o4NR4bOyWK5VVKIMRQfUP/9Vupxuy/vt5Q=;
  b=WlwoXU1HDnsCwCc9m869w5BOWzBImBGn/0SBNLERuaNnRXeW04t+MFU7
   23zEhdOrTPAB201YLYc4+SeUa8jBfyVnGJ7SumsDyGxrf//8SHi5Qf6PD
   /M0DbN/E8kLq763rvMEtAsuCHW9O93GVTgGma3KO2b0ZGDPlMxDjxtWjO
   wJTd3sJQsY/Knck3ndv3NYVpVd2JFkeHEc9DSYvvzSL46ePkMjnLYvzI5
   Phdi8aEku+RHXf4h2cbvjv3UlumLe1FW0jyqnXwPi8CRmX1DrgDtsavhN
   OMkaE1aARYmlrz6xfvsw5p+WHDDgEYbVtDbq2k7yAL5njKTB3/cDYLIIN
   g==;
X-CSE-ConnectionGUID: YzOYJkQGTYy3DJFtA2pYDw==
X-CSE-MsgGUID: 0bOYcYjhTLGjhizDcky4TQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="11684693"
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; 
   d="scan'208";a="11684693"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 11:25:00 -0700
X-CSE-ConnectionGUID: ub2u/b4eQnePuG+3Z+UNrw==
X-CSE-MsgGUID: 9ovzg/93R/aulJHt07PLWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; 
   d="scan'208";a="34207719"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 May 2024 11:25:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 11:25:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 11:24:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 24 May 2024 11:24:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 11:24:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsTtR45CLyEfgfd9QgSxQ7ZtFhjEn6z+t9IAUX40AwpfJwAtrrjSN2z6ZfI/5SpK50cJ3SvJh7veEnU3XbLRY4TIiA+ixdYhaR2FHxuXXN0fDPLYYjxsXK0uMgRG+HPJTX1BSmyrwu0y0sOgd3osWEmJ93y4A1q9z96uNAQ0d0qF5ToHcZkD6O+SBbsUqcoixTtXAq6yUZUeILhLGsCIn2E000V1Z7Th1h+dyTSZx4X8CVhdvf5x53T6NVsyLmhwOExACgQrJgEOq0ngV2ylKjCrUpQJX9uOHmG0Jtyjjhc2CYYZFbQsDI6Cy4TxfWPRnurn1v+tT8qGgXLbwmu3yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9/rSTlY7nnn1l6PH5KcIATjtBzI7lPFn5xpIP3zH84=;
 b=gVQhbCRaLttnXo64S+8e9o/vewGp1aLt1yYwsjqmKkVoI7wXmV/O2wB009VobNnGBK41TYYGOyolMpw6uS+VJdG/cmUcr2/twNA+KJ2xsN5joKT91eBGwsdJzoCBmK1zBHZg8XLiIZR0CvQ3p1xJrYE9XAcV4qawMcvKUnX5Q/AgnyW0IQbBxBHBkvPSsyGIYXsyh1Vb27zejoFfpgrEY9Yjac+Yv1Qv1V7D9kCpVNTPI2e1BYWLdzkPbFNOJKCPKeTdA9YtiYu5IERXcORNXhD4jB7ZGfOaUohvrcc5mv4hMaTuJjRzgLX7OyGRSx4JCog62LViSN2Qu0NeMAh/Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6895.namprd11.prod.outlook.com (2603:10b6:806:2b2::20)
 by SA2PR11MB5132.namprd11.prod.outlook.com (2603:10b6:806:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 18:24:52 +0000
Received: from SA1PR11MB6895.namprd11.prod.outlook.com
 ([fe80::6773:908e:651b:9530]) by SA1PR11MB6895.namprd11.prod.outlook.com
 ([fe80::6773:908e:651b:9530%5]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 18:24:52 +0000
From: "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"kheib@redhat.com" <kheib@redhat.com>, "edwards@nvidia.com"
	<edwards@nvidia.com>
Subject: RE: [bug-report]rdma-core v51.0 build error with Rocky Linux 8.8
Thread-Topic: [bug-report]rdma-core v51.0 build error with Rocky Linux 8.8
Thread-Index: Adqnx6BozKwzKve5Tt+XbFDGYf6BwAFXOpkAADRYzdAAAV5KAAACJvKQAADTGQAAAAqzQA==
Date: Fri, 24 May 2024 18:24:52 +0000
Message-ID: <SA1PR11MB6895F7437497815D5E24AA6D86F52@SA1PR11MB6895.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: SA1PR11MB6895:EE_|SA2PR11MB5132:EE_
x-ms-office365-filtering-correlation-id: 9ae99e41-74c3-4e68-2d45-08dc7c1ecdbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?1bOsaS2Ok4sEJOcbL0ubdmwv9F78IIjdqyMoBbEQen6XK8tg29blYdMb7KtA?=
 =?us-ascii?Q?9SJjIle2szsxfN2TS5QHfenb410kmHuDtkwuw5TggVjycRfKlxgq3ju/f46i?=
 =?us-ascii?Q?BEMVxd6h6LdYh0jPVMs27ZgdL4V78aEhz2f3HCBtvXwu/DFf5w6NLDz1OBUX?=
 =?us-ascii?Q?LTJ0SioxviSfctMen4N9FhTGsCJ052lL2uHmNO0QP2d19WrWrbVbNzZDkH8d?=
 =?us-ascii?Q?8YrqAw7Hd5bUz+gMYoWIZlKKEk02CvZStRoJCHk2Asd4vWXgzuxNMBuFOpdd?=
 =?us-ascii?Q?Rd6RYabkzL39TwHOV1F5U6uLNMqed9yRJyK7i2clGQewc7XumnkWU/WQ5h2H?=
 =?us-ascii?Q?dRjRK9qIThvj52HgZ+/Q0tMJvTKZaSfy1zNDDfxpBqd7gy0d+krYgS42wJz3?=
 =?us-ascii?Q?nImTRmmJSAgu8BLIZaF4rgNgW+d4h0yB9e/X5mWhTt15YDYHtjtNNzxiRJaE?=
 =?us-ascii?Q?wlrsEXbYqmr5mMXg99AlZxtAnC3U66pnEkWRIrKvGGiEav6sZaNNVRdJCjhm?=
 =?us-ascii?Q?Ix02NhD9iWFgFNArlpqM+DjsWx3uId2UT4KbP8mLJW/Lrn5hioUjEsq1bCz0?=
 =?us-ascii?Q?+O1p6pQ1l9Ed5eNYhHLmZGj0MB+4B7EHNopO5H6agS0kRF2XKXK/yJPg/d9L?=
 =?us-ascii?Q?DVPoee8NYr6JSmirPELb/SmRsFyHjG6nFfJbg3Zm8UJRjo6hh5CveCuH9aYy?=
 =?us-ascii?Q?D6+7xKfBUcOcgckWlViqj2bckTC8d1T0RYl9hZwJgvua7ZAUdoUF62MQhfrP?=
 =?us-ascii?Q?nFfE8Q2H+spvvQ8EansWqXoJ+usuVYGPMb4SFJl90qEtnhgFVDGUZz1qfmLG?=
 =?us-ascii?Q?updAHFiGu6N1tcdLZlnpfdOyVXh5CFYq9LN7bYb8SjnNDb6qnQ439QfqmFHq?=
 =?us-ascii?Q?Yet4LVEHNYj1jRyxeAZLoR9475y92Vr921ZecF4+DbYP2uJyhqrg2atsTOkY?=
 =?us-ascii?Q?4NKDNZwpMpzKibO2+Cvf85meOEyohCgML6ct6DL6SCEgvhudAyFOoaKf0GkH?=
 =?us-ascii?Q?dKbR2N4GCn+lvWNBbemaJuylR/ddHtU+wHopqXcSr5Bjs2OCGe6pYONAG3Fm?=
 =?us-ascii?Q?yOKinbQQDWr6of4DPJyLCleJ1SbGXQCjgcDwT7nVzeJyR0OLDt/q/gxUoX/o?=
 =?us-ascii?Q?z2qLDOb1ub92FL/2qi76ZKCm+gd336ujlI1Zj35FxMBccnvGwqShVAqbvkGE?=
 =?us-ascii?Q?UZb8SA4ma1O+TelsQapTM7ukohA6j15tJK6ZxKrVaFwMWOAP+FHcwHG8zFg2?=
 =?us-ascii?Q?owaRb/akK5+pE7WIuvRAsyfkOLysdzDJZlF7a43gzzzoMjCQgIknJN54GAzV?=
 =?us-ascii?Q?DVe1MoMF3e0gFJke6J+kBAatan7mIXj+6pAh5TQWlhJKnA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rtSK3Pb3I6BtLv3fedUvuXW1ihHhQiH/rVyxNqOhLZGhSaYNysCahy84VLW7?=
 =?us-ascii?Q?wLf6jdr7eBzB7dp8oALbQ4lvWkWQg+zc4UFO6SYNKJt+fATr3qfAj8jHLfAr?=
 =?us-ascii?Q?ZW/zCYTxIJJ8me2kW/7DCTL5V8lRLddhxu1QhzkK53detyG+2oDkewFkMmHW?=
 =?us-ascii?Q?jgK5ynJrO9erY2urpsvZvYAARfDmPfXoy7aCLPQSgWlPyc+P+OSjeBj/Z+/A?=
 =?us-ascii?Q?4caYDjx/eUWlpvo+SYwkKZhrxnqNCqYoWIPTcCxanaQF+tqvBZ2txgpEEfFt?=
 =?us-ascii?Q?Sgz7vU1W4of5iAoNo2BlRSX1H0kkU5ZIt5hvu8rR++xxGqVypd0lW0DmpT4I?=
 =?us-ascii?Q?dtCu431I3an6w460o02Vf+AntCsh2gZKJ3ZWIGmurf3EyEDghqjkmto/oZPw?=
 =?us-ascii?Q?tgkFGCryFWO+E4GIAcbE8iN//2hHpHjAuneqhx43z4Mgstof23lC53ewEzhl?=
 =?us-ascii?Q?cjmZ89sJ0vrN1/a5UyYEAneS/sf4vg28EkPoDUo8gkGgZIvQzksRH25fSY/V?=
 =?us-ascii?Q?dE1IqJZV6/SgJ0P6IlhWVJaBuJYhkHLS+o5U83yZx7Eph45rgCNLERz9nWrL?=
 =?us-ascii?Q?axxCAgiXplF301s4E/FYMwDdNEL1eU2R+diEhHs4O2lqJEJKbuAufSJXDpd5?=
 =?us-ascii?Q?GbjjFkpqY6j1OfsVdqg/BW5tGTLVxWHhL/b5o4VQqaijuJ5tv4jbODN6AYvu?=
 =?us-ascii?Q?0XKvn6vpAbhS+pLYxGIriluIuadHBFY9hpOohUQxZX/qUxiAgjtsSmiveeG8?=
 =?us-ascii?Q?n6djdzioan2/w0WkrEp4Yz2fu0WTCDWmBenwPAR76hJTve8hF5b0LjZoDfJ7?=
 =?us-ascii?Q?7a5sj32YglKNxrg199rE3wVyTV2f6R/BtQq7Ss9IqU0EfbrXIL7uvuae79BM?=
 =?us-ascii?Q?QndOEYL2h1AuYUJw/P9dZqaN7W6UBYIaYEGv271Sd0AJ6TwxjzogjHbM6KH0?=
 =?us-ascii?Q?wzVDMd8U52/w4tzWcofuoUh320Pp9b1+XcBpR1poKEyBqCEccCwDZy5RawHl?=
 =?us-ascii?Q?1OtgGDm5jsPuhi45MH03zo7OH2g+lusXCRiGaYOj7Ap5xay2TUPIxaJKGjYI?=
 =?us-ascii?Q?wPSO1/lDLxjGfLdztLFkc++rcJN11+2MjzTcX/XqK+2NuPRHoNq4Yk5hZtng?=
 =?us-ascii?Q?bX9032v6y5++bwVKek50w2WBknn9QMvDIgBbI34RL2wRE+2LTz+6kS7hc3bu?=
 =?us-ascii?Q?o7SEGcqpH8jWbsMwh01snqHeQ+jZVcF974x1yPcF0iWrLCT7Wa3H0ANN3O20?=
 =?us-ascii?Q?pkpX7jYLwsEU+Bon46HFrrVucsVIbQQoP7dlyvmbutvZAIaenJE8T/GjGAEf?=
 =?us-ascii?Q?2/BGfB+EPNfKFeVc7pP9ENtj4Ng2CzQBjAMm1f2lkd6KCQxikSxO/EoxMLVd?=
 =?us-ascii?Q?AA28GZVNomf1DI/B8GK0AjUznwUNdH10Fn4lLa4jVW1odCBdQy8s6I/0nO8K?=
 =?us-ascii?Q?ChvUsoookkTDZTJMgqTRWMifjanD3Va1Lr7Ia2ItzMuQAFPMCaeDqRUudwvp?=
 =?us-ascii?Q?povkX9Np544CHIZ5r+yvZvWqsdyIWkMbETkIszWyaTjrgu7Sw9MFRx7pwtug?=
 =?us-ascii?Q?aVKuVBF0TFCptfBZFPm4tyNJBrkjhFRjTEp2cNCh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae99e41-74c3-4e68-2d45-08dc7c1ecdbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 18:24:52.1807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0yOwdDiYuKNe1/d+h1KXhLkxWRTfTL3XY6os1RZU2qPJwMaC8ScfWAUQ3A9vhLtR1tjFcJsYGuEAGMOfU2FYMalgK8yu7eq7L/WEUPjkm1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5132
X-OriginatorOrg: intel.com

> >
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
Ok.  I will give that a try.

Mike

