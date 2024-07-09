Return-Path: <linux-rdma+bounces-3776-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 569DC92C407
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 21:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791601C22431
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 19:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A12182A44;
	Tue,  9 Jul 2024 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOouTwX+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C921B86DB;
	Tue,  9 Jul 2024 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720554403; cv=fail; b=GFCEjbNMLIARKA8b2mnPWbqgOoX/l056eW88Y76pE2wMPb49JI/qHy3CiofIFYKzkw0ePcooxAvl+jUTXBupZEfeQyTrZ+/e7R/nZh9jSIXwzrHXTW/04dL+KYJDuMa7u5dhZoCwLcLEC5XOe0a7brIXifvBQC6SIMPoyJw7RyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720554403; c=relaxed/simple;
	bh=aa5umGJiTRJXgBNAQHbE64xlcd8kMQ0ryOKAFnk5wus=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bqzXPI2+VXbDkxTMWbzbbg1Bs158EZYtOj5iCDaydSYPZGLO+tAkEI7NPBLVAyUP1OO23DtALxTLFuPIXfm0Ruji4XFl9GoSurJHw+/WL05FTHhQSP9O/r7BFs/PEPn+d4t5DP/Vxgpuy/6GPrOIXG4B2mTIc/HD0k2NKVwHb4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOouTwX+; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720554402; x=1752090402;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aa5umGJiTRJXgBNAQHbE64xlcd8kMQ0ryOKAFnk5wus=;
  b=YOouTwX+XTChPbVki8d8+8NDx+cUOQxJwNN0FdwDo5dwuu02ZUqI035/
   Kc3kuFKb1719vccDU6bpkBzZmSZoRjGaq2RjhMmf2KH+5OsJ5F+yi2ur5
   7o9TZE2+Lo6n5YYs4ZFhMP/cFWyeUVDsMTSBLZhOzcPHgMdMlyvCsE0qS
   MFUpoMHAgUdMGFwFcfnN7pMOTAb+Vo54Y8khnvYef4rwVnRF8y9NjVtgq
   7Ro0ccPQ37jCwnEPc+zyHLWorUK9mLj2Ue2x39v4/zrQsRAxcQ2aFkQfK
   1ZTAr4BOfhFGXrJNVftkD1/LvM9zCURHvUnP6m5dk6iXYQpeTrclmLXcA
   w==;
X-CSE-ConnectionGUID: 9ZvoCgbRRuuCBRDuKGtrkA==
X-CSE-MsgGUID: 1mHRCwd7TmqoOr/7DIgEMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="21654138"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="21654138"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 12:44:02 -0700
X-CSE-ConnectionGUID: SVW/RgC/QwinyzCxsf4XhA==
X-CSE-MsgGUID: NS1kkVvkT8+uRO+JbOc/qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="47840804"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 12:44:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 12:44:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 12:43:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 12:43:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 12:43:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3XpBqR9eog5zg+HIJwhW5+IaSt9YMwl2lX00VbqaOFbbELUU7DbJrhEsTsPILNnT2C87SpQj55u4ms8+8j2vYaPLDmEA2dvIHWTXeHAS3WyPCfgYjG8yeII0IXq5R1Hekmyg6kVyI/R9T0i/Q2BvA6wR9zurdPgnh39YZAvkDWdT30SJYS2HIkcl3ueVHn6/K/B5oUuvSHRfYmDjuZq2n+ZePl0HugyWL16ytXTsILxyzGIPCYeq9gPOXDtVFxScME8Rrl3BW/BvOlecF1xIFnplgBeXl8ygKfVKlSkmTfuayaV9Scpcp/mQCLP6LziCUYBTMxZdSlcF4Uk2zy0TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fI7zzssH1/NRSMvrQQHhObLz8MEMAvs2i9pmTtgYLpk=;
 b=Fyqi/WkY1eQHiYYONWnz2TZE98/ieuPa2bDTvEvMaw3kCyIbCa6+plEkXMDPVWfqPiKCrfxg+zflCeHSs+ZflsZQJXQjJ2KdSEcMGE+E8fFET9MDBt05dqTvOUrn68WEP55bBuEQsAZP1OgAOH7xnVUd+m3rh363C/gpC8WdO3GGVivsLT14Y5k28n0kyIS+8ixIcOaWKZP8xqr5LoerkwEmMcob4Ew/I8xF5kS5s+ZoMBjCmk3yDuaJw9f1lipVFaIwY1rqH46P2CqAmkbKDLl5vcAr7ilnpRLP+dkJmUxZqiPoFhXvXngJD8I4VD8xCN7cXKDM2dmZfThOibF8tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6533.namprd11.prod.outlook.com (2603:10b6:930:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 19:43:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7741.027; Tue, 9 Jul 2024
 19:43:52 +0000
Date: Tue, 9 Jul 2024 12:43:50 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Christoph Hellwig <hch@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <ksummit@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <668d92f68916f_102cc2947b@dwillia2-xfh.jf.intel.com.notmuch>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <ZozUJepl9_gnKnlv@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZozUJepl9_gnKnlv@infradead.org>
X-ClientProxiedBy: MW4PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:303:b4::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 88435025-b61b-4abe-69ba-08dca04f763b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wo1e2sMqKw6CqO6WuBWTLbUidci6va37BuBpafLdXaCLaaDBoxvyURsNky3U?=
 =?us-ascii?Q?FT4wXfvBqjFHWIG5UISdphnPHZkuFCK3K4jF+UPB0Szd2/0h+s4J8nYnLxgc?=
 =?us-ascii?Q?kHFBFk+F5m+KZBFhraNmbnDGZht4eDKr4vvLXXUK0FVPf70SZp7AuI4RT0J3?=
 =?us-ascii?Q?P6L3M4oO1YI2Wy8aH9nf+/7zhoYx1zTh24UQlTX7kHfdkZW56iXlRmxGmpnf?=
 =?us-ascii?Q?CN50MDsKDcdZkFl3//XKCZiEjWdm9qslH3SGH9rcllqfdwge4y7IK3fE0AIT?=
 =?us-ascii?Q?VSvJZjajShHpXyLFmP+S/tDliekiCkx2NO3nKIasE8UJvkurNM2moDRuo+5M?=
 =?us-ascii?Q?PLksithrAF0n0bW6GlLrJ7q6cu8wVPEygL0LBamSqJiVcMk85Gv7FT0YB3uU?=
 =?us-ascii?Q?QfL4I0INtti3Z1OSYTguiKbVKdSaBd9CZKoWcO5wXBTBVhKxcReCty1l1UD9?=
 =?us-ascii?Q?vun294Xyp7SHAaPXuuDjQUcEzfp684eaX8U8Df67Q/s3D04sqkViCv4iqgPQ?=
 =?us-ascii?Q?vnT5GMIFE7T1r8ZY8UO0Wb6ZecGVUjkeWAPJXoRob6wOqL/lNmwj4iUzwKpO?=
 =?us-ascii?Q?eBgsh2hrpQo4PW2XugARS8dPuia+4U71T+sN7Q/Md9vj9INj5XuzKiqIsbXI?=
 =?us-ascii?Q?jh/oVScQVmmFoV50xa7VtvtUw0a6lEX/yFoViX7eCtiQfmfKcKsXcuyyj/LQ?=
 =?us-ascii?Q?Ltacobwk1HkGI6/+fX+Cs+rRWUEv5xmPStBJ68wC1OmpSh2nprzDZhfhovBk?=
 =?us-ascii?Q?XIuF8n4PRQ/DeDGxZH8dOI0PfhWOObjsoiOfCOJWUBTJ9FhhjvORMw7CjjXo?=
 =?us-ascii?Q?OgAlGQdqVPDmWUUx6NhXOahHKbJeYkpqbz/RXRMOVONei4/4f69/uPsjoNHQ?=
 =?us-ascii?Q?MTZEfWp85wUCGdnqHC+R3qwXwMgu6GuA5rm6gyNsLMM/4RIDcM8eS5YEN1Gt?=
 =?us-ascii?Q?V9XPvCty/ETBuNshxA3+wSCNJKuyFO70ZINBXaBo1WmxfaRZ3uxAJZmt6RHP?=
 =?us-ascii?Q?6WWHK81DPxox8rzUK401+VGWWnPa+E+Oq6kvHum94uAaxA47hrBYrBEpOHxs?=
 =?us-ascii?Q?T+Je8sIpCOBpWXP6zmdBd75my/DpU4vkfXMVVMxqcNicrt/1SsWE407bKqhX?=
 =?us-ascii?Q?IRlg5R+T5vpKrifEdghn5WQaZo9daKdzthG3ynqPQWKUC3D61xkXfnm+JaeH?=
 =?us-ascii?Q?BryUeXI4o7VhFZyCpbYL1/hdbZYdibUE9x8Mnhj4zflG6tIvZnSt9XPlIlla?=
 =?us-ascii?Q?rPf9lYpfv1amglZmL0jVi/OqowTtdqm2q61dv5/2hCzK1fJtFZa5YleXkppY?=
 =?us-ascii?Q?gwH/d6+HCnDj/J+bWRgO6GSfLDkVjkMB0YJugCOxuavLMg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rgYcR5kvDFe+auFN9kMunBDnsf+XzEU3QSX8YUNobhDWl7EGhlcHiC7yF/mk?=
 =?us-ascii?Q?ulCt/uRWWmYXXrEDLSgapoewTWSCb328iqCrXIngARm0qye226DrVYSemRA+?=
 =?us-ascii?Q?vC94/Sje+jkqr+13QfQG+WpUKZ/Jyb0lZFFIB5SgqtWu9P+MCkQcKjxpYOgb?=
 =?us-ascii?Q?0M9sxX2KZuNFfHgyfUCGhaYyei7zEb01PUPEILDcwOW0fY8oMe0ADjUk4ADw?=
 =?us-ascii?Q?Li4ttZWBxAuH5BNRTEotw0oLdebyof/3Kwwss0FSMYz36lFR7ZLwwKcIh/5M?=
 =?us-ascii?Q?VKnIRUwfyslhhZAVev8d5d4p48TRa20gYhFrD1WRkNkMRhi38M+u9qABsgEg?=
 =?us-ascii?Q?vwSS3LruzYXwCktD0yQSf79EMv3nLauM3ejm3EtjqeDaeDkF/nnqVdnL0GEy?=
 =?us-ascii?Q?SDpYgUTTTwgi9TDjzB1DZBLzIxE8B6WPlzW/Dh8jLqm3qqWi5n4bfjU6nsGR?=
 =?us-ascii?Q?mmf01NCSASNy2sM5+e5KUyhGBSe1sinH7tmXOm/dnxQmzISVUreba0MJx2gf?=
 =?us-ascii?Q?D62U3bGwC+7BYAR5do+xjn75+u8LXE/BbBl0wF+edrxlHwg1aZ/QE53cTAPX?=
 =?us-ascii?Q?yFNPnhvS7HAzhUpPN6wmsLBoaoAdsbfvYSydeYkwc10MzYFGcAXbs5VymMPK?=
 =?us-ascii?Q?/diEkAFKXwaZ5b/qbEASWUOt697aY3Dkg2LSXrbSbRcOTts4TjdCS/MBoOrO?=
 =?us-ascii?Q?+ZyZJdnzc9Pwat92cwOf3qDUJzUf6f+FWp9lcKyJxH+oArY7L4EgRxZqpJTc?=
 =?us-ascii?Q?Cc33Ila33YqJrBqKbuasi7GsWHa+if3Rd4wM8ttF7dc+WVaw9ez7d89bt660?=
 =?us-ascii?Q?BtcXybcNxvlYBXNTIESO80hNjtpFAWirX8VxHsFEKQ2XXn/lOTQL1vrA2kX7?=
 =?us-ascii?Q?3bMpWyFiWxOtRd60k6YHcnGqjhL8xG3QvAedqy10VnRc79QMsklgNhxZ7olf?=
 =?us-ascii?Q?viWWPRRDAp1TZCutXsN2byDbFdxOck0uLr18he7kKbWqAMTqzlscZLo05B6z?=
 =?us-ascii?Q?2PnThvFV/uG0ZvV2eeLtpVCONfNEKVXnwVTse4awUL4wk3LyV4JrAwr+1Ah+?=
 =?us-ascii?Q?IbztVre/BcBrlXJbItgNOSc+Vl+CXFZyXg6WRSJwToIUhZ6xVygrFgqcPgSl?=
 =?us-ascii?Q?os868aMtxzQ8Cdfbnxb+PZRKPhSXy5zXX+4wP9UbnBbZSBUjeONTh/B1U20G?=
 =?us-ascii?Q?Cdd2yWYuE7lyfZloklu1zDJKzN2X0BvlTSxXddzk/T6uMBd3/1ImwpkvNixN?=
 =?us-ascii?Q?FDPg4Z7PjJP6Mq/N+aJqAJTIia43jSFsH+wHVyVCM+6P0igYoo+iRSM2uSA7?=
 =?us-ascii?Q?vbGPwGLaCbc/nxxKfQt1YuZ/WaOyXEB5qKljO+NfkhhyEvHPXqPmrWo/GRnc?=
 =?us-ascii?Q?i5/UMKlFG5WNgedaCCE+16mzSI+Hwj9t4Tterjxbqi/Z3n9vegwXoYfF0u5V?=
 =?us-ascii?Q?TZoDApib1Oooio7TuTyj+9GzBAdLW08eu65ACA3g/nzrBfvRu9N6tae8tQbO?=
 =?us-ascii?Q?1/VR+1SLj2zM9j2ppjTzzMzIWFeVPoTbn2XfsBGAJLXXTfGGbQfFrXN91sp1?=
 =?us-ascii?Q?oFUunUoCzWY/iQ6zw+yvfjJtvos0VqQzFLdFvaITTh8nFgm4BIFBPS+R70fm?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88435025-b61b-4abe-69ba-08dca04f763b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 19:43:52.7336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSYmtwpE1L1B9hbgqXK8XOkuW5pH0hcEVHAoNYXhOcDFhcrr04yfyXuWfIQ0VtU0khwhv8fkoJOrEt0puAKaUT/jg5T5HpKO6KTPIlQGA/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6533
X-OriginatorOrg: intel.com

Christoph Hellwig wrote:
> Passthrough in general is useful, but the problem is that protocols
> aren't designed with it in mind.  Look at the list of command that
> affect too much state and we have to block in SCSI and NVMe.  And
> in NVMe I'm fighting a constant fight in the technical working group
> to not add new command that instantly disable the access control we've
> built into NVMe passthrough.   So IMHO passthrough can be good idea,
> but only if the protocol is designed for it, and protocol designer
> generally have a hard time how software works at all, never mind
> the futuristic concepts of layering, abstraction and access control.
> 

I think this protocol feedback from the kernel community to hardware
designers is top on the list of benefits for this discussion.

How to draw that "needs kernel mediation" line takes
kernel-developer-practitioner expertise.

The positive takeaway from the NVME experience in my mind is that no
doubt the NVME subsystem has blocked commands that hardware developers
prefer that Linux not filter. That filter is likely trivially bypassed
by repurposing some other non-filtered command to have the desired side
effect. Something like "write to a magic LBA == run filtered command".
The fact that those cynical hacks are not deployed and the technical
working group is still holding discussions on the proper protocol means
that hardware designers have a higher incentive to get it right than to
get it deployed.

The conversation seems to break down when it comes to "trust us this
passthrough is only for device-specific functionality with low cross
vendor or kernel appeal." How can we design protocols that have a
high-level of trust?

A "Command Effects Log" seems like that starting point, with trust that
cynical abuses of that contract have a higher cost than benefit, and
trust that the protocol limits the potential damage of such abuse.

