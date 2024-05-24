Return-Path: <linux-rdma+bounces-2608-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D93E8CE952
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2024 20:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813301C20BDE
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2024 18:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761433B1A3;
	Fri, 24 May 2024 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6B7VjY+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3AC39FD4
	for <linux-rdma@vger.kernel.org>; Fri, 24 May 2024 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716573717; cv=fail; b=pjliQZ5kOrcng55l8q8616e6w3tUzMj+yApJNPYylRsdMcC6d+lgjwN2AMXlXTtTeZOTZ2IRjepUZUcAy3/i8kFO2dpQMFQYfSnALGmlLPxUCzMRrzOvTj2/TfL4UNSsYD4ffb423pwJXu+qdNUi9RsN/1L8hnLF5Fcw8Eh5gAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716573717; c=relaxed/simple;
	bh=wT5WtrANcsuyKAdOShNkBDqY76f4fshjRCJLabwJehI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZyO6riFvJuOlo23aJwV/zu4FS5ZmYMQshdhcu1MxvwagQJfrTLBvv5FdI8ac4kfPdp8FWBnU94vbK7DlfxqvephgTkSQRMz/lXPoiHxvyXBK1EeqsleT0XZv0wTDPlhVYyGQzkAE7C8+7a63mngXgzJBxphW+zYfZOd4WmFIC8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6B7VjY+; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716573715; x=1748109715;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wT5WtrANcsuyKAdOShNkBDqY76f4fshjRCJLabwJehI=;
  b=i6B7VjY+6x6GDYu+D/JWQ2Z1fCLAf1bQAiYryxGkHZ8uQghusYpy7Gdo
   nixXcPgFTPzXxZgigybMvIlx4fXajy7mI3wWOeqfpZ7O02boqUY+Q/8cF
   HqfBolhlXhUK00ISXU3H13ACxWAK2bbJoK98cLYyo8uMkjH1bP2Sd0iX/
   MTkXLlGF/rrbctog8Nd2NjsvhsyGPuw8jfyPINhIwGiQryF7YPl/WL49E
   rF80MCz7WOIxsqDKp8Lwjg8XjcG693sQQQQNwiHVt0zM7XqrAv+TKBstY
   VcFksZCv4DYS2bvdsdmnVelH9wZ8k0zUDvaQUNJf79QWv6vxTwn41L2Pk
   g==;
X-CSE-ConnectionGUID: nEmPxWAYQh2Vb5waLn/g0w==
X-CSE-MsgGUID: XLvpabDESc2FAjjg99BrAw==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="12747258"
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; 
   d="scan'208";a="12747258"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 11:01:54 -0700
X-CSE-ConnectionGUID: aplq2qNLTiixr+Hg7rYTDw==
X-CSE-MsgGUID: jQDZ03suSO6LAnETzQj2oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; 
   d="scan'208";a="71515298"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 May 2024 11:01:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 11:01:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 11:01:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 24 May 2024 11:01:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 11:01:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0EhJ4KQRy1WrWsv51Hrb91Sd9XYkMGHZUvqQ2q/uIW/vGScbmSSHMOUJ9C4dl3c2zsygeUA/qQwiBadmf/2DFGfh6ZP4uMlMzNze2zXM/UCmqjVFpBJ0EAJfJ21Z+4chTr/CL+pxHryhlowFA3ZGC72PirCzGHX91GLtyVpGh+D3Rwu0q/X6iqElkRa3Yr7ivFYYRjdffkyqlCn/wlqLaFHvmo2hRbpX4bppdcki5lg8T74rIZKjHcreAM2+Fk/JmZRwt4Sod4Xb548ZHxSGbGfGLYBj0tiSfCKTxw9G9NBtFcZO7slZZGk5VCMm1ZhfGLv7pIDy9qSgfwxH8xofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wT5WtrANcsuyKAdOShNkBDqY76f4fshjRCJLabwJehI=;
 b=WvIhgn3LiubHN/RJFMG8X6KvYTZXfL1Rsv71oxX9Jg3Jt7xyPEeOA6VHyd0rJb3lcdCaJItpxDtvl7yTXzfP5YSZmAHgc02wGXHPlAQh6e2oJcUtM+IMcihG7kS9gvpXSP8w+tJFMKXRk0GxlzpIB0T7mcfHgZTPO+uwW2zT7KDLpjueybpSGa5M/o+wdlhMN/LVwJXFxjTaponK6DVV4QSrJTDGs7WK5oqsimHtSMrw89bXNGAi6pRDCUuoez0aarVW3cq7bcu+NoPPTVT24vaEMBrSW5nuUDsscB2dRJtr38p3BdUXKtFRF+1ZCzmA4XssC8LZJz0S3QJ4cbD7hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6895.namprd11.prod.outlook.com (2603:10b6:806:2b2::20)
 by CH3PR11MB8591.namprd11.prod.outlook.com (2603:10b6:610:1af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.26; Fri, 24 May
 2024 18:01:51 +0000
Received: from SA1PR11MB6895.namprd11.prod.outlook.com
 ([fe80::6773:908e:651b:9530]) by SA1PR11MB6895.namprd11.prod.outlook.com
 ([fe80::6773:908e:651b:9530%5]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 18:01:51 +0000
From: "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"kheib@redhat.com" <kheib@redhat.com>, "edwards@nvidia.com"
	<edwards@nvidia.com>
Subject: RE: [bug-report]rdma-core v51.0 build error with Rocky Linux 8.8
Thread-Topic: [bug-report]rdma-core v51.0 build error with Rocky Linux 8.8
Thread-Index: Adqnx6BozKwzKve5Tt+XbFDGYf6BwAFXOpkAADRYzdAAAV5KAAACJvKQ
Date: Fri, 24 May 2024 18:01:51 +0000
Message-ID: <SA1PR11MB689549B8852C1A337271747286F52@SA1PR11MB6895.namprd11.prod.outlook.com>
References: <SA1PR11MB68950882F65EE948009BF33986ED2@SA1PR11MB6895.namprd11.prod.outlook.com>
 <20240523151902.GJ69273@ziepe.ca>
 <SA1PR11MB68959864102CC0DA683FA28E86F52@SA1PR11MB6895.namprd11.prod.outlook.com>
 <20240524165704.GS69273@ziepe.ca>
In-Reply-To: <20240524165704.GS69273@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6895:EE_|CH3PR11MB8591:EE_
x-ms-office365-filtering-correlation-id: b7a607c3-45ee-43bf-ed38-08dc7c1b96c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?695FSa0zym26GuJvHzgkuEfhCHFvEHstEiEk+ustfc0v1HGzsk/VIF85JO4c?=
 =?us-ascii?Q?A9OBO/QjU5XXLStsqviQ9GeIrBxP4eRVVz2Qf2w2jHBVzDgZKai3ExBJ2t35?=
 =?us-ascii?Q?mXnu65FyQetR2A8D5Kdx0Zc8hb2zywj9VmHUadcxJJkebmn4JhQCqcLrAEcm?=
 =?us-ascii?Q?aC0oaNPPG/xF9tt1Pr/R5w+WmsTcRTvj54v3mze4wBKK2xwS6mF/dT72lznJ?=
 =?us-ascii?Q?KPxwObcwndPIk6IIfnWVRVRxUmeD6H/x0rQIJt2Zbxnql0zffus7rp07zXN/?=
 =?us-ascii?Q?/uaOQ0YJk3DNkuAYCMS6eIsURR8OuinzpZVFfGcVYfaXbFgMDVcJG1ZjmyiX?=
 =?us-ascii?Q?AnygqRlfYIcFuAkxfDmVfJEHDVwsB0KjC5YRAYsRfeJwyJDZFh4AXfDaaTDK?=
 =?us-ascii?Q?JbLBrd6gchyKlChWr39yKM0QbgKHomBfSNTlYvqfy4W+T9yO+INBKw0Vp6Qm?=
 =?us-ascii?Q?cQ1dwdV94jABLfasUm+vp4utNPV98QJu2epRGQ7FJ9o/X4wsoAV61NJL2WRy?=
 =?us-ascii?Q?85m5aUP89ceRCe3gEgngVdtFalBcjz5qi8wwxYitX40vr8sDCS2SuJHymRsT?=
 =?us-ascii?Q?X319MUHZteN886qt6t/sDdIE6zOqBcu9bLb+2YeeGTsM7EfWSURvnDHTILPP?=
 =?us-ascii?Q?5PpZOSN7uLLJj9xsoI1RZHhPH8rYxAZ/APy/h4NS85Oi+dZFytKLls2EZjqZ?=
 =?us-ascii?Q?FQ2OXxYBJ5aPSP/5BHK6FyRgZ+ke1deorQcTd5sg8gipQgQ83g0NjT+8IPjo?=
 =?us-ascii?Q?Ger49ibLVnabafRW3Z6npRPV8hkO5BKoYHvK6l5hoMvxBIADK3UiBU9gIk2H?=
 =?us-ascii?Q?gTjAI5ovQg4tvZzIMCklOFaefQqZ2Li8IqwycAl6BrzStmm5S72PmPUyOBRr?=
 =?us-ascii?Q?kc/biAE6K2WQ8v2mpYUl4Gb3ocQWQmPVoRgWz3R2YBcaOrym3NDwnyfujmjA?=
 =?us-ascii?Q?yDE8wsp/3MN6xy09q0U9/W5h8322VjcxaGZ4tuy/LJKu9ULnrdfbmPulSYED?=
 =?us-ascii?Q?DH3kOKzsRJS+xBQbuPyizdyWfu8cW9Wn09uuttI8hUgIXrBp81BPb7jWmlJL?=
 =?us-ascii?Q?oaPxHziDn5ysKKelLv+k5PQYmkWVQKwMhXGCE9+QI9DObslvDu3H6it79kN2?=
 =?us-ascii?Q?6P2ji7vR9rGpVlPRMgrXew29CzzBYr4FZ/6qRHWcbPA3fCPhJD72X0K7x5vr?=
 =?us-ascii?Q?26sRkOh13d1BvfvR91DIjN0LaWhvMvuAaNS+cAaGak8n2zg2IPNVTVH2coTD?=
 =?us-ascii?Q?+Oy6RvWrU+P0lFuYUYIp3Awmedp6zlPiInDpoGhIL+G2WN5vjX2esmV/BUkF?=
 =?us-ascii?Q?jJBP8suhiA0NZxqJSVji42c17mp/XJvbzTY5K8fss60VNQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?osRl6/tEUvybhlemAmQ5APPCY2uqDPIAtXCdyaNXwca4FdIkLcm1vBSW11sf?=
 =?us-ascii?Q?9d1xzmOKPXtV6xdJiSZZiZl/WZrnAyLu8tftZsmzCpqXgpFXE4ALBori6HAH?=
 =?us-ascii?Q?GChWXKLa9rM+PXBonNZG8b6AttE7JQDVQymhpMUeU1XAQ79+4avWNVRjsuWn?=
 =?us-ascii?Q?XfBeEkxtdPQx3MoQDPDTAz1W+2dGKox3REPg684S5oTnq1xf4IY5JWmMp/Lh?=
 =?us-ascii?Q?FQQ1760SLJHxx5DNKGosDtkDi3smjDqRgmmvgLbMyCHpMFCmeqDBAPyVloUd?=
 =?us-ascii?Q?3oKTvSV6PtD0uZCiIgxRRXQ2JA2C4P4FM9UCgddqk/61FYmoUC6Gb7Xu8Jkm?=
 =?us-ascii?Q?OO898bIYzj28bfTt50sjX5VcbhlQtPtlW0x4Yt/EEag0MgyGNCZRwJdcHzBY?=
 =?us-ascii?Q?qBiQ7ry8qQOVEMW1Zb9JQXq83K69kVbytQEQ5m3MDd9D9JtQf148eTs9O4O8?=
 =?us-ascii?Q?Geel96mDmV7u4VBy+VqN1UHjEd2saeObb9zRwAsiVTqKkkmGFGN0wBIxn9Hx?=
 =?us-ascii?Q?qHK4XdpSz3KE00rB/Rvo5QTyapEvKZJOdPaB7xCBnJgzCxETOimG/I5nR9TN?=
 =?us-ascii?Q?JJAsllp4KZHZ/czCcemyeqyl/I10lDSM1R/Aeq2q3Nr7dL6rG/lHGA7LoTB/?=
 =?us-ascii?Q?RepYMmb4QeJucsrLVwWfsU5WenHt4Q6YRpIEY2dG82xoGajqs7+pKvBiUE8H?=
 =?us-ascii?Q?t7XNa4VIyykHtN+lqlg2rT9zcxyS62TRS2G3VeDuxiMgj/DhZM4r2m5PnUR2?=
 =?us-ascii?Q?QAiapjZV/NjKznduNPUaZbaEiEEpKoZU4FhLWGFWGtuoWA/LqnHMyZ65TSt9?=
 =?us-ascii?Q?C63k2MRURto55XLFg4JFb5AJ/dtO66eR68jPmpvcbk2eSxe9vDjMoKyZAI8g?=
 =?us-ascii?Q?CV4MGPgELNibBjJH01BF4tbbzIAI2thkI7mGVjBjD3XY5M8FyaR0sBXGwyHX?=
 =?us-ascii?Q?bAMD0jYbeZqmRNSX3wcY7o5V+HnLuAaaba8dl/76fSWGh1OU7onBnXiT9T8L?=
 =?us-ascii?Q?+mAMQsWRCv+y3ZaSUyThbZLpf/QQlCZ1MQR47Gk+rYDG4gmFaK1Uz+HTeSF2?=
 =?us-ascii?Q?eLwSJkCXeARB5P8oYKCD3CTfxmCYFUk6p46AiPEyWG8DC8WF3UesafqEL3NB?=
 =?us-ascii?Q?lTBmSiEEwfL7Sz+HdkUFnrlTqrspdG1LhUAGxIDyLgqUv4eKnMZewdw1Hs0O?=
 =?us-ascii?Q?C/KMdpHooXwlTGchhCrtZcb9bjgl0aQ2G6IdEmgD/IOKyf8xeTBAkvJejSmD?=
 =?us-ascii?Q?AIBlsZwzi7YlfMVhAPEnhtmaThMaVjzqjmls81G7IVUVFn9+afdInmps1VgH?=
 =?us-ascii?Q?JH+H1KmnJ66tAn/RzAUAQxvcuMeHkZ5tZIkwD/oatrRIzFWg/8+oGjOZQVo1?=
 =?us-ascii?Q?nNCymMdunOdQkFqtNU50eXSd22NJCNTmTO/YVOtSe3WWJjvJSGl5Wnc7wXqM?=
 =?us-ascii?Q?HPIWefqSkoOKcp19wEQG6SdTWCzTbO/+8AFg/Ie+uYeuPq039JZlkUgMDRUL?=
 =?us-ascii?Q?yvqXQ7X7IY7bvHHpWDL/J/0JPv22ddkd3mCKmGmDtGFQyMJdJGe3wwyjLdSL?=
 =?us-ascii?Q?VDjq9RBBQkYVTj30CXpFnSeaxD4faZt3A5X5VcB/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a607c3-45ee-43bf-ed38-08dc7c1b96c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 18:01:51.5185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BKXQYIr/Wy69za8E5u+8hsU+VHjV77SUjtIJIPwTTiseuf3fHdMruJEu6lQdccq76iSMBNKRC+LBwISCPQc0BF22RLcaE+6HBz+3RjO6jQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8591
X-OriginatorOrg: intel.com

> >
> > This can be reproduced by loading a newer python and rebuilding the 51.=
0
> rdma-core from a git clone using either 51.0 or master.
> >
> > An RPM based RHEL build can replace the existing PYTHON_EXECUABLE with
> > Python_EXECUTABLE.
>=20
> You mean at some point we lost that PYTHON_EXECUTABLE works and it got
> renamed to Python_EXECUTABLE ?
>=20
> Jason

The Python_EXECUTABLE is workaround that can be applied to a spec file.

What happened is we added a new code path in our cmake list that behaved di=
fferently on handling cython.

I'm kind of new to cmake. Sorry.
Mike

