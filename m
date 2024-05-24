Return-Path: <linux-rdma+bounces-2606-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC42E8CE8CC
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2024 18:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6E81C20D8D
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2024 16:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5712F12F37A;
	Fri, 24 May 2024 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8Pnxr96"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8610312E1C9
	for <linux-rdma@vger.kernel.org>; Fri, 24 May 2024 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568828; cv=fail; b=c8piXHcAj4kBGcmQPfUTThU+ISR1OXGToxYgPpyaCRZSuwRJfvKCXrG6uO/RvLbsDtQtrl+p2wKIVBUZLsXxgFgqG/YmknriM3aV13nTzyLmX/dX5zFqGDILUkRx7QzWOHnDmZugVf8Y9I1QxmjOQAli5OJJE1SDzp/pfuFlTvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568828; c=relaxed/simple;
	bh=Gz36coeK1WS3X1V/Ezi3z3Ohd6kzQI6VNnJIFF9q4As=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RJwDJTdBeQPhRKICjiD3d/XUFFNPX0EeX9gOXwLD4xCVle+Es8M/5roF0Clip0s3bBm0SwoNk2ie2xDksrtckHUWaPVawHlr3WPtRuN8xexzhaAUlr64jRE7rDBMiFvpX7j/RRyZWlYZKA8D/zGVbOKQVE7C1dR8TGpAFEFC91I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8Pnxr96; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716568826; x=1748104826;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gz36coeK1WS3X1V/Ezi3z3Ohd6kzQI6VNnJIFF9q4As=;
  b=C8Pnxr969ExexrUQjXEOfoqiU+F5T5QDjSz83zItbJ2tsWGvruLWxF9D
   cGO0TQEvTk7/ioBkOx1V7xBTA0duwnd6GlD/xLBQaUgpZbiBNjrNmePmz
   HG7mo/jZFZpN3+rSLDhrWJqxq9hv2K7J02I2jvc2vR/SZANzmzS0b9VPl
   HmDU25JRRakX/hrn6dqwFCdEHmiRmWWDLdN2XejbRN5PeTXjGKU+v67rQ
   QVIFmcK78kmk+8iNRL8tOKjbVwhur0q9aNO+zH3N4OxZn8iTGWsrYELEG
   uRsibO5359E5AwZq7sBY2GddcYg7CfkRdQn5LPuhFJNK6QaN1LUzK32iY
   g==;
X-CSE-ConnectionGUID: i8ca7b55RNy9Jskf5cmLZQ==
X-CSE-MsgGUID: QmK9xOW5RNyX5u7B8qvtFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="12739386"
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="12739386"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 09:40:26 -0700
X-CSE-ConnectionGUID: UCZLtO4VQfeyEqcUb0xzWw==
X-CSE-MsgGUID: +IaZcecJROiUU0tAGAItgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="71493848"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 May 2024 09:40:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 09:40:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 09:40:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 24 May 2024 09:40:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 09:40:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dE9/HXYkpwdgK9z9y6L/uTgssGxxbsZohGfJqBTBdb+FTeWySRjAGTOi8x1z5xx66iSUR41L3U8JyzzWHG6DWe53GAUztbVaNTi9ZoIancISU6uhSH6sKNs40jOpp0Kl01YvdsV/n+HDcA3NKLZYOhBQD/CSfiq5GQHtNpi1U5NGlkefHa418qRFsSjtmQEXuH9MWthPlYbJHC+1omVvFSCemNHM/V8j+pPtF4CdHx8HG/L+96U5TUF0X4MovDoME2xGGjS0QQy3ssjS+zIqdtZLe1ODvSHJb/jLf+5yGTl/YvXdXHHs91grTeN67U8heQPMBqQnkh7XX8LsJezshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIvDY2YuN0IDZkR32jX5rR3tIB4M0duc8WMgckmlTl0=;
 b=UpfakKDFfOUXLEzuMEVrUhiJiMgTSw6cxcyyfTEOcTdD6uhNF8Yqws6q8GfSM5JoAjPUWrL6MFwsQe92tjqwI4iIDssW8XFCjWltPCJ47QwwKqVuYeER10GlxrvmwObE7bfow1LVxgFLD7uT3RATUWvgNTT4pzZWSn7UCHNoKhx1P3CPaLEDutwbxtR5eAHxTaaL/Dxr10elwzWBzXAQkuhlRx1z4yxDeCKydEPdye4aZsgSdIRCSP/Z7ALS4Yy2uQ7B6bd5xq8zsiXuccDB0SAR9qggEbiLP7CzWtrBZslkCzCM/UbItM66Q60MElbnPeyxJrkoZPeeMwTmWIVHrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6895.namprd11.prod.outlook.com (2603:10b6:806:2b2::20)
 by SJ1PR11MB6107.namprd11.prod.outlook.com (2603:10b6:a03:48a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Fri, 24 May
 2024 16:40:21 +0000
Received: from SA1PR11MB6895.namprd11.prod.outlook.com
 ([fe80::6773:908e:651b:9530]) by SA1PR11MB6895.namprd11.prod.outlook.com
 ([fe80::6773:908e:651b:9530%5]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 16:40:20 +0000
From: "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"kheib@redhat.com" <kheib@redhat.com>, "edwards@nvidia.com"
	<edwards@nvidia.com>
Subject: RE: [bug-report]rdma-core v51.0 build error with Rocky Linux 8.8
Thread-Topic: [bug-report]rdma-core v51.0 build error with Rocky Linux 8.8
Thread-Index: Adqnx6BozKwzKve5Tt+XbFDGYf6BwAFXOpkAADRYzdA=
Date: Fri, 24 May 2024 16:40:20 +0000
Message-ID: <SA1PR11MB68959864102CC0DA683FA28E86F52@SA1PR11MB6895.namprd11.prod.outlook.com>
References: <SA1PR11MB68950882F65EE948009BF33986ED2@SA1PR11MB6895.namprd11.prod.outlook.com>
 <20240523151902.GJ69273@ziepe.ca>
In-Reply-To: <20240523151902.GJ69273@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6895:EE_|SJ1PR11MB6107:EE_
x-ms-office365-filtering-correlation-id: 8a76fcdc-42af-448b-ec7f-08dc7c103393
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?A+8SgOdf3062eY5XAdtDLeE5cKijQqKndiE8va2pvNZgL1tUckJEMiIkFq0p?=
 =?us-ascii?Q?FBQOBKn1Aj0AeUJbQWV+mn1OD4woy37BR2eZwa/cyqgqZn0JCorgqOHgnrFW?=
 =?us-ascii?Q?rghsUkm9xIzpuH6AOCzBUR5lerEN3ahhM7YWU6aLHvYKnhBJX0aAER5Fy8F6?=
 =?us-ascii?Q?9n6XRHBm6CgCcLIjs7RmfzJHdWp9ffEJYGiteaDFnIdFRwkVRX2TKhq9S+VT?=
 =?us-ascii?Q?so41RyqjZSUfFDZaQy503/zAgrMoMzg8dI4SDvo5hOilZOCXPWUP53pdAwDN?=
 =?us-ascii?Q?Oo8aOfa7t/eucHDY/nekuQdXff51zhkPNrQzgDscS+KFuWG5nCJdlsRilk6+?=
 =?us-ascii?Q?tORvgi80mN6JGJARC7qpkI6VoOmE2KRuLpA06+uEmJ1s00Y1s5ehJPAAX1Yt?=
 =?us-ascii?Q?MJoDhg/n7C29TXQwi6ThX+VwubCrXZrhnSCuZWiDDFevJXi2emSOr3H/DcuG?=
 =?us-ascii?Q?NN2u433+khPmrIb6Y6gT7dAUNnJOAzNs7naGaGkKHhnnzm3G0yZVIuUvvsMt?=
 =?us-ascii?Q?tVrlvuhlZ8Nx+tBk4QPNskl4GsmSSSFRgBU1Yf9idSKMRPZyuCxrotYi7T1h?=
 =?us-ascii?Q?Mu3Cd+Ry9n8erVq+YaX+5jUd9Y3yLfd3gB7YTToUSSp35QeJokLDK80Ye2Sh?=
 =?us-ascii?Q?XTBUibI2LOMqN9nH4ySz3jpa7BykbXWHJc+5/koMvFcxQlfsPK/2SYAO4M2R?=
 =?us-ascii?Q?UMjnsgHpNTnCQPRZRsuz7KJjmITFZ+XszBS/G1K0f9d/OkNCLHSqmdLTYsz8?=
 =?us-ascii?Q?9LqgPTw73Ot+Jlo2m+F+XNzwr19xlzB8zr/+9nzlc5cHdgONrxgE/zAP5tsK?=
 =?us-ascii?Q?nDhj7NU8PX5tInRbqi7nF0yxevlZjTOPHFdP7+ItofUWGLRG+ocAD2r9m/p0?=
 =?us-ascii?Q?ItZnvBCsh0RqJlgxSkjSsyrU963WX7LvKMKdthyH7vniw3xGO4NZtEWGaowI?=
 =?us-ascii?Q?AO5XK5GMB3kcEdHL9nDgouv8Z/P91bLS4doXRFClDZXqMUo7GwPkBsPNGNpg?=
 =?us-ascii?Q?dGkJqXwUPgphJaE8vfvb158RPJZPM/qdEuCtc/OBDiBKSgszg0anqybvxZps?=
 =?us-ascii?Q?fc8rJuKk+a0cmMjIViqJ0qweGugfZsLHWoJUlIsRg/0yq2h5+p0JbPCH5qSi?=
 =?us-ascii?Q?aOoZppq7rHU9MaaR+SOKoqIgsv66B9aYY6tpjaIgI6o32y1Tiu07e9k2643Z?=
 =?us-ascii?Q?6eDFSl9BxtZjLRqVq5JYRleN0IbNzAjJCzPgdMyeyfk0UOiP286796hm1u6V?=
 =?us-ascii?Q?aE/eB1ZXwR080BMAauDSeUo/YbAiaX4kWnEDI+I7DPwX1Zxh8xO5YxpVinCq?=
 =?us-ascii?Q?uJn9Gwo6E4pDpyiPonD/jSs6NIz38qitWNUjiRQM2WwzCQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t4Y23bXPCW2mit8KL7kdGWJQvRJdWnfT5cmGNZIzffIh1hJwUXi4Fz8Rhf50?=
 =?us-ascii?Q?5+yjJyrlehwf4B2fd3JjO4fKE1318GUxaxrenNK2E44g1zzQoKxFZilUOUnH?=
 =?us-ascii?Q?pnk8Gah9sE5wscr/KjAQUiXAdn1Rcx+2M+UlO0LLteksHmmwUJSkZXDcb3ew?=
 =?us-ascii?Q?O65GtEdVwJ1jTtRTkh/yP+xHS14wWbwE2TeBJ41zJBeoL5v9f9dqy1H4tWnf?=
 =?us-ascii?Q?3UknvOfik9158L5G4FrsFtE6V/vPZNneKCPnp3EvjPd1ehBhgDvahguZxyVg?=
 =?us-ascii?Q?l+S1aLEDpnJ1J42fB579UIosqOQ3i/ZsRXPf63ugTYp+YSTuQhgrQsQK0AjD?=
 =?us-ascii?Q?5l6hswPSILBe95iYjP29CTW1AEqgbVwd3gKFejLEmsh2khzJDYDzxgQdbqRw?=
 =?us-ascii?Q?zv8wjNOXE52D7Xdkc0CqR47Mvm9hwwAML71bTp3G0v4QEGQYYn3M65Rwj3/R?=
 =?us-ascii?Q?M4AxVOdCiMp0KYNiYCYaJ2bok/ptQFKafW/4KeV+US3KFcvRbSqHYiRNxaxR?=
 =?us-ascii?Q?nDBqCXISGV4ESWbGvO0maTjHiTVT7/QhN0HO51XMumUn9iU6lES//bgRcpUF?=
 =?us-ascii?Q?xFHnL9NsSC09Xycu08Z8Z403aMrUT60sEX2BSmXneSDOf922sRNAim24R9PZ?=
 =?us-ascii?Q?MOrea5hJa6eMrgHigWgMsFV8RhS/KKTPIOdL12VjPzWQ565jNKJSYiciESMF?=
 =?us-ascii?Q?7yx5aVetNE8iQu5nXsx1vgSgvdALB7X4wIjRQbvcWYOOuMWA3bvSW0X8ZAA6?=
 =?us-ascii?Q?HcekXP3DUI+SbsquU2J4tGdekqzh1LdfXRaaJTgh+QltZdff2ahuibmmm2Gs?=
 =?us-ascii?Q?EQAliFglerVzKbpCeIbKmjBoPiAih0zn0wQbM/QNSJWwellhWwFTVwYn4l23?=
 =?us-ascii?Q?KdzVGO67MzQwTduFSvUi+0ipMtBU4JApkGlW5ZOJTvO2As5sY0BSgQAmvJZp?=
 =?us-ascii?Q?y87/KdUUhEeTdho+lAsgFQ6MjXiQuYIZ/ewkrZ5q33t9XEgZQgHifcwePYxi?=
 =?us-ascii?Q?FQUBPf8WEQMmNQT6VMk5+rC/fFmyXC8fP+J+l3gAYd1L5p8Lb0T+lKb7mmqM?=
 =?us-ascii?Q?iOCQjZy+buHWDjhQG20OCTm+5RmoP3zswoIRtN1N/izYHPNPgOuoUs2fEB+/?=
 =?us-ascii?Q?S+YJivZfJajgmFvsrJbDYNs763W62uN45pb8PviU4t9ne2BCsC42IRjFgvDz?=
 =?us-ascii?Q?q9UtGniAatnz3sCElSeATnHNV8JAjn7U+GbRZKyMdRVOtPlbXsP4m7JdbwG9?=
 =?us-ascii?Q?kpEo7Qtrf7iJSvkndLXeuKL1UnLiAqPWeOTlOE4VNVheto0Mzf4tsPeGFPWu?=
 =?us-ascii?Q?hyznOryHE6KAWn52MAyJb3pRg3idKJCLcZFRitGsuBDSBy7hYXFiGfHUNVbn?=
 =?us-ascii?Q?qL43YW0aUiMe0dADHe7QYyy9KyuEpNtlRJIuk5AeeIOq4T+Lo/Hdp3gOfd8T?=
 =?us-ascii?Q?JY/OPGhWKTIgdMlmmjS4KXvg5aJ71EpnSbp//Ys8v4vite6YFCBelQ+BSD3R?=
 =?us-ascii?Q?3oFs9MxpiQqDpXiETsTnZ8wpFmzvChXXppih2qtdtbt0yN38gte3GjSODmaX?=
 =?us-ascii?Q?7HpcxCVk/ZZQPJN46WHmiNXxbDBkrYP9ZMOHdOHP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a76fcdc-42af-448b-ec7f-08dc7c103393
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 16:40:20.5854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zs4121sGTa7V/u0Ux7MC0lDgY4lSM48pb2tG5MJH9rezpDb1lxGZMOvnbZAEQGTZ4z8yJ2EgkPgj5VOv6IzmMM5SS6LEROiqk+QulEBv1O0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6107
X-OriginatorOrg: intel.com

> > /home/mmarcini/rpmbuild/BUILDROOT/rdma-core-51.0-1.el8.x86_64/usr/shar
> > e/doc/rdma-core/tests/*.py
> >
> > Earlier in the build this is seen:
> > -- Found Python: /usr/bin/python3.9 (found version "3.9.16") found
> > components: Interpreter
> > -- Could NOT find cython (missing: CYTHON_EXECUTABLE
> > CYTHON_VERSION_STRING)
> >
> > The issue appears to have been introduced by:
> > 1462a8737 build: Fix cmake warning
> >
> > cmake appears to find the 3.9 python despite having:
> > -DPYTHON_EXECUTABLE:PATH=3D%{__python3}
>=20
> I looked at this briefly but didn't guess what the issue really was?
> Do you know more?
>=20
> Jason

I looks like the above commit changes the cmake to use a new >=3D 3.12 code=
 path:

  # FindPython looks preferably for Python3. If not found, version 2 is sea=
rched
  FIND_PACKAGE(Python COMPONENTS Interpreter REQUIRED)
  set(PYTHON_EXECUTABLE ${Python_EXECUTABLE})
  if (NOT NO_PYVERBS AND Python_VERSION_MAJOR EQUAL 3)
    FIND_PACKAGE(cython)
  endif()

There is an additional refinement from:
5dcc1f402 Improve python searching logic in buildscripts.

That patch does NOT fix the issue.

The rhel 8.10 cython requires the 3.6.8 Python, but the FIND_PACKAGE() for =
python
returns the python3.11 required by valgrind dependency resolution.

The issue happens on any system where the cython required interpreter is ol=
der than the most recent python.

This can be reproduced by loading a newer python and rebuilding the 51.0 rd=
ma-core from a git clone using either 51.0 or master.

An RPM based RHEL build can replace the existing PYTHON_EXECUABLE with Pyth=
on_EXECUTABLE.

The issue can also be fixed by adding a variable that can be passed on the =
command line with a compensating
fix in the CMakeLists.txt to pass use the EXACT python version required by =
cython.

Thanks to looking into this!
Mike

