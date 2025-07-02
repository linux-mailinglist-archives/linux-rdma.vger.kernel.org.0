Return-Path: <linux-rdma+bounces-11844-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA06AF609C
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 19:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B853D4A368C
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 17:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A73730B9BA;
	Wed,  2 Jul 2025 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kgm+2EVx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B688223184F;
	Wed,  2 Jul 2025 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751479068; cv=fail; b=bHo/RdANBlyKzifiJbgQt7HyfgguE6QA7HyY1RCI9oZFflUh0PfKidn9qxNypD48nJmlOv3ucuhsHvx8CndIqptBY1S8JPCtMjRQ/t54Oo8mSdEf1eOQwI9ahWtYKC3X84nhVzTJhsE0zin9jCIOSvh6CwuvkPk2XptBg+S2Blk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751479068; c=relaxed/simple;
	bh=5SwKJYoj5gLIWmy3grbhvHXfanj63Y4LPjIX+GxdsRA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D/SKIU33SIkxG2xtrMzOP1UqZU119K44PE6hJvjlGRjavGkA7kiRUnL1Z76IZYUHTx//D/MHfmgl82iUKaKF0D68ifSNprjpynuj5B5pN03Q+Gt9d2OzpUJV4AIpG+mgqfe4C6vkw0HzcVVuWxMX5zvw1vMIg9+7vGIqLTbb6vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kgm+2EVx; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751479066; x=1783015066;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=5SwKJYoj5gLIWmy3grbhvHXfanj63Y4LPjIX+GxdsRA=;
  b=kgm+2EVxlSk/NLDhGdrutg41ZeuBemvYxLs7qS/9aoNHurfnMVz5Kkyu
   6F8E13/Lgm37rKALlleXo22Sqlr65qSOGw/W0RcnxftNAmPgYR17aOdLl
   OZzS3MC1QfsCetszrzVHXrzYSbgEX7FME4ubXtGsnFzYfnjCOJ4r0iobL
   XkG2XOhicN6lSfY2hKQYCX1Gy5yeIeBACP2WlPjtZvL5ANRZDEJC670QV
   VaPsdCVBDjHS+VXK9BeUgwSzJkGXkve/dE7ADjMAFDVx+gUdIPyKmJGiX
   Ye/vbdeHnEXWWKeYR12M9UJ7QexFADY4KZbl8FMDeutis7p0SEoREGnAu
   g==;
X-CSE-ConnectionGUID: 9zR8g46tTea38jruqeQ96g==
X-CSE-MsgGUID: 86HDmp/aQlSASg8GbZM1DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="76336887"
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="asc'?scan'208";a="76336887"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 10:57:46 -0700
X-CSE-ConnectionGUID: cbW8yDHpTI2klMlTnroMIw==
X-CSE-MsgGUID: r4D/GpySRo+27ZJgMNX/TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="asc'?scan'208";a="154707415"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 10:57:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 10:57:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 10:57:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.64)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 10:57:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+WVuGV86PCFyydRsGXXElp4NC6WjIVE6he/XayQMFzw4MKZdYwRaZs8xiBKrBGVTu+CPfp6vzlOtDvBiSn/LFwr4G2D8G4c60jjOu50ZVN8j37ZOICgXjMdOAulXaCMLxbur1t6jvK9YK7MgSps1ayZwClGCndiv3OvAKIw82uyJq7ynA15URb5ZXJspu86IQuPygYTmjGj9nXzMyaN4DRDsE9XgmVHfOwM0dN5xC11fyuaX7JxT9DkY6CeqlBv6BHiZ6UtZWNP8+/hUa9wV7McVZlntVDX2y4dlvyf6b60v/JMjuMdwlVUgK4gr9Jg0d8i71TOqe5uuhJ+Chdb4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SwKJYoj5gLIWmy3grbhvHXfanj63Y4LPjIX+GxdsRA=;
 b=RoESi7R07nRTv4ORYpnnOnUoVeJcfPGLADFAtwD33387+/im8W8mzUlHcqJCg1Th5xaxrYQ+vVYOywolKcZMHMfUYrdRwkQJ6HZ9mgNXBMX5R1XsbY0Us2K0jRXTpzKQ001DTonFP8AB89EBOuOQz91pmYeWNug/g+VDPItFttv7//576XLDmUt0DYp1Vkpn93a3Or399wAGjdwxL3JUyDbsY4/8FzMQek7y+YU19Y4HY0m1p+qHKOMT4x2YqWnKTgb17YNL7o1N9Ecq6wa9seHcvv5V1TjLNHonpBHBWDYI1U1d8ESSDDPi5aIEzgOfFMhDcacOmEHLu/HSm2TNog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA0PR11MB4590.namprd11.prod.outlook.com (2603:10b6:806:96::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 17:57:01 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 17:57:01 +0000
Message-ID: <b6beb765-895a-4d6d-9447-ffc3fecbf5e4@intel.com>
Date: Wed, 2 Jul 2025 10:56:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH net-next 1/1] net/mlx5: Clean up only new IRQ glue
 on request_irq() failure
To: Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"shayd@nvidia.com" <shayd@nvidia.com>, "elic@nvidia.com" <elic@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anand Khoje
	<anand.a.khoje@oracle.com>, Manjunath Patil <manjunath.b.patil@oracle.com>,
	Rama Nichanamatlu <rama.nichanamatlu@oracle.com>, Rajesh Sivaramasubramaniom
	<rajesh.sivaramasubramaniom@oracle.com>, Rohit Sajan Kumar
	<rohit.sajan.kumar@oracle.com>, Qing Huang <qing.huang@oracle.com>, "Mark
 Bloch" <mbloch@nvidia.com>
References: <7cb171c4-3c36-42ea-bd6f-52dfe6bc5dab@oracle.com>
 <06e99d8d-a6de-4687-b109-0d1557ac2779@intel.com>
 <d1b697de-ea53-4634-9821-f403090d3e09@oracle.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <d1b697de-ea53-4634-9821-f403090d3e09@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------KVUdXLTVhoaP7eJ0mFdCsNPx"
X-ClientProxiedBy: MW2PR16CA0021.namprd16.prod.outlook.com (2603:10b6:907::34)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA0PR11MB4590:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5a3cd4-05f7-43df-4015-08ddb991d886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnFPMUJHbHA2R09BRGw0ZS9ESTFIeWRxeVZJMTlTalVPdThybExqVGo2L0o3?=
 =?utf-8?B?VklkejM4ckthb1ovZDVqeHgwR2RTb3JNbjhYRVJVZG44bmtpTXFudlppU0xu?=
 =?utf-8?B?dGwxMzZrNm1VbW1hMGVLWHVpTmpUTXcrc1ZVTjNsT1ZPSDVUMWhndnNadlQv?=
 =?utf-8?B?K1dtQ0xudzlCRUZFT09FcllSVWs1SmtlTW9YaEI1Tlo0WDdkVW1FUFpNSXhH?=
 =?utf-8?B?aWM1UU5pZEIxaUJkRkQ2Y1ZWNGlUM3BZN0VHRDhDMTBOd202MFo0eEwxL0VG?=
 =?utf-8?B?THFQTGRmQ01scmhXSGNvWHlGN01zTG40SkFsSkhQSXNSb0l4eG5Ycm1ZS3g0?=
 =?utf-8?B?amoyVWppNmkxVUNMVjZjOFRBWUJwUnNmSUVwaDFsWlI5SW04Z3hLOStpY3Fm?=
 =?utf-8?B?ZUMzK2VYZStVTm1ZaCtPbVZvTHd5TGFXOHA4TlZ1YlFkS0lVL1pDaGNLU3VS?=
 =?utf-8?B?UzdneXpZb2JweUhpT21ZdGVINTZNTDI3LzVvbGhmb2U1eEVONndMeWlCc3FH?=
 =?utf-8?B?dXZadUg3T1g5RlFmTGJBYnJGNzhJdDBVZjJJaGN6d2lLZE1IVVhTaGhnS0Ru?=
 =?utf-8?B?Tmw5S212T0Z6V2N6ODg4M3NUZTNMdFR3SGx4d1B2WjB2Znh0Ymt3SUU0S2Ur?=
 =?utf-8?B?Z3NkY0dJcys4L3FJd2REdGJEMVhnYjgxRUpnSHI2UVgxUzIzRkVEaGhJeEM3?=
 =?utf-8?B?cVJwMzdHQ3M4MFQzWDkxTXdieXRxLzFXY1BJd2dMSzByVDdrZHRlaXM5OUh2?=
 =?utf-8?B?SW5Jd0dMTTAxbkdpVkhSZWhMSzVpejRoYzNndERDSEVTVUFRRFFuOWFDQitE?=
 =?utf-8?B?eGxJeVdDSkI5eDZRQUlsRXAxLzZTR1lqa0F2dzc4ZlQ4N2tkTiswTFFRUUVz?=
 =?utf-8?B?RHljeFZpUm9td2VFODAzSVRyMHlwRTZScGNYU2dwcG1YT1JLUVZaMzVWNDgy?=
 =?utf-8?B?cjlrRnFzY2xnOVJ3TThVeXZ2cDRHejdJcnY2ZEtxS3FnTTcvRExkaE4xMVZG?=
 =?utf-8?B?SlVDY3E5cTVaMG5uQ25VT3prdDg4aTVlNzk5bXdERjJNTkNHTG8zc0F3ZHR1?=
 =?utf-8?B?V0lZblVqcHpZQkZDMndkcDBoUk1jYnRObU16ZXBzb0Fjam4yNzRlSVlOWTE5?=
 =?utf-8?B?Mm9wQWxKNEZmVVRTUld3cGR2THhaaloyWi8zbS8zU21oUEZSVEZONGZDK2E3?=
 =?utf-8?B?cVQvWWV4Ym52UHMzVnhCaEMyZHplTjgwaUk3M3VYZ21kYzdKS2JsNTMwSUk3?=
 =?utf-8?B?OVFDTkt5dmNUOEwvZUVzSFZVNUR0WWRwNHpNNnRGRm5qQlF5bVVRT2V2WHF4?=
 =?utf-8?B?MEc1M252RmllRjNsSUlwWEdVbHRHbU9KV2E4eTljLzVSUi9RM1doWXNabjZl?=
 =?utf-8?B?UkljQlUrWnZvakp0S09SbHNMYkVEY3puUlZ2a2VXblRzclJhcjdUeC9oV21s?=
 =?utf-8?B?YlFGZTBDQ01pNHhmN2d5NmhncVpYN2JDa0lkSkdRMTNxdFE1SjN5UEo5Wjhv?=
 =?utf-8?B?TCtTUXZUaWcvUENFeGxoU0QvWldPR0V2TFZVWDBmVmxOTXFRa1UrMFh3TFNy?=
 =?utf-8?B?ZUFhTVpNYi9mYmltQ2cwMkZVVjMvVnhOd3FGbHVacFc3b1pFM0lQdzhjbndM?=
 =?utf-8?B?ZU5OQW5kUS96aDhzMkpJdUxwdkdYVWVaNjhEL0hpcm05QnRyTW1uZnE3NDh3?=
 =?utf-8?B?ckhKcHE4Z1N2cW9VcmwvSU0yNzl2UVlFczljNm9CbVFXVGdwQVNDTXNYZnp6?=
 =?utf-8?B?ZEl0LzdXMjJaSWxmb0owdXhDQndJZkc0RU9yYW0rQ1BOTVlPRnNYdjhsMEds?=
 =?utf-8?B?UTVCWlBJanhRdXM3N0gwTm1OMEZRb3h1NlRTWlJ0UmRzbVJsTTczdGM1Y2Mv?=
 =?utf-8?B?eGpmMXh0cmNqTEtGZkorQVdTUkVVQlpOYXlBcVcrR0x5eGJkV0lUTzg5eEp1?=
 =?utf-8?Q?0GaD3VkRlvc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T29xS1MyTXI1UFFIK0t3dW5HTDFnZFUzU2EvWWJuNC9HbGNORkZVckxDcS8r?=
 =?utf-8?B?WDRpL0s3NmhEc0xhNnFnU3R5Ni9uMitBeGdIMFAvNkx4Mk42MXhTYWVjNnYx?=
 =?utf-8?B?ODR6eXJnOS9ReUQvVVhxa2p5d1RtQk5xd3BURlE2aDJVLzZpVUJGUitaQjBD?=
 =?utf-8?B?emEyMG5KWTQ2U0dWV1I0QW9HaTJIQzlTK0IwYnpCVUEvL1UzU2ZMN0NjWmds?=
 =?utf-8?B?QXBZMnd6dFFveGNQeWtnVDhlVzFCTXFUdGNJK05ZNHJWLzZFbFFsQmJHdlpi?=
 =?utf-8?B?ZVlPYUJ6bCtmUXg5RUdaRjVTaG1ya1Fsc25aTVRScG1FK0hvUGp3R1BYS2g4?=
 =?utf-8?B?OUM4K0twMWloMkpIREE3N3dNOTVlOXNkdHRUbzdZOE13S0dZWCsyYWlxb3Ey?=
 =?utf-8?B?TmtlbGoyVFBNNHJISWE0eDZUZ0lqSHpSVFBEUGI3TUNVVFhRWjkyeGV6M1Qv?=
 =?utf-8?B?bGdvWnRkczRocmdIMjBiSVhlNStZS0pmUFdXdlN0WTdaaUs1RitkMDA5bjJN?=
 =?utf-8?B?QkR2SSs2V0hBU0xJeGZDY045WVJKdmdSclN1VFA0dWJDY2FMMDJFSHYyeFZU?=
 =?utf-8?B?bVRRakM2QWJZVDhFQ3ZhVjNFU0NidWNRYTRIVnFrKytHUDEzRkhuRFdza2tm?=
 =?utf-8?B?bW1mbC9ISkxmMHY3VnRMeGt3YjRwN1l1aXNqUXpHQW9zSC9CWnkvRG0xNUlq?=
 =?utf-8?B?cnNRMjZTdVNhUVBJbzJaQW1uTkROZFVKRWROdjFoMFF1aFdBQUY1VnQrK0Rz?=
 =?utf-8?B?ZkUzTkhmOWpmM20zK3dkOWpCcVZ3V3I2OEZYTU1UKzBKeUtDTVFGWTREQmRV?=
 =?utf-8?B?MW5ZUWlDT2dpbVpnQ3YvT000UWxaeUlSUmJvajVESzUyRzdKLy9SaWVpdVk2?=
 =?utf-8?B?Rm9KUFVIYjh3UjdYNldpZ3lCMkVRSlA2c0F1Tlp3SWJ1eDZOTGJyYzJjSlF5?=
 =?utf-8?B?SnhZK1RDZVl6Tjk3UHM3RVRQTm9yeUxIVGRmUkhEczdFeFRmTjl4NkVsVkRG?=
 =?utf-8?B?bVBWZCtjV012bWVkakhTM0FFUVUzQ2VBZmxoMUVRb0o2MjcwWWFvQjU4YUd6?=
 =?utf-8?B?N2lGbW5ud0wyblpWaFllNGE2dk92ZjVZWGlHVDN5Vnd4a002MEhUakNFekpO?=
 =?utf-8?B?aElYSHBYblZQVUhTTURtTDE5c2h5RjU0Q3N0Y0FFc1pDOTVFMDBwZlFCL0tM?=
 =?utf-8?B?dkx2OUl4bWNRaCtSaTRLRVhGc3ZUL3FGYkZQVU05RklPdnZGK1JCRWRxaFln?=
 =?utf-8?B?MVYxWHA3aDRjclUyTnlhVUUvbEoxLytibWNra3MybUVkMWljUXZoeVZHYzhE?=
 =?utf-8?B?UkVTOGJCVkJabitNWXlJUTBnLzREcUI4UHdtTGJ5QmE4eUY4NGkxWlZ6OEdS?=
 =?utf-8?B?a2FBYm1aL3FrR2tPN3BQTkJUTzU1TXNQV1QzbnIwNnJhaG1YMmFvU1Z0SkIw?=
 =?utf-8?B?alJNVFBPOGZOM3VWU3krTjhmbGQ5V09XWFYxS2F3YlFwVVJSNmVLOVdvM0lM?=
 =?utf-8?B?VDBHUHVYYTZPT25aazlJNEoxdFlwNjBGYXN4NFVNYmRzeGEvelZQVTFJL25Q?=
 =?utf-8?B?dEN1QzNEZzZmSUo2MDgyR3ZzeEpuU3o2SDc1MlBtZ3NUcnRLUjdXUU02WUVO?=
 =?utf-8?B?dnBESG51RE9JWFpFNUR3dC9OanJRQlBNdWxnUm90VzdHbFJuU1JMay8xSENl?=
 =?utf-8?B?UDJvSXdLOFVXbm52L0ZRdzh1dlp5RHpPUFJBa3Y4UEhmRm5Pck9BUzZFbHdt?=
 =?utf-8?B?NXBjUmprQlFnd2xhck15QXFYNWF6VnZPL3d0dHhEQ1pTTTJ4U0QzQ3BoQ05j?=
 =?utf-8?B?UkxLanJvb1FvRzI3d0o1OW5VNWs5YUpqTTJZTWlpTGJ6RWF1NkpjbitvSWph?=
 =?utf-8?B?THUwYjhIL01wOFI0WWw2YXZua2Z1ZVFkR0wrUWh0SWNBa0hWaitvdEdyNG9P?=
 =?utf-8?B?dkcrbG5Jb1RYV1JMd3pCcURGVzUwbnJkRk9ERGpSRFFCM2ZEUmk1bDkxbGtF?=
 =?utf-8?B?QTZkVDRsZ0ZGa1k5aWVDeFJGc2hsakdRd08zOUg1VHFacVR0bDdrckNLWTVF?=
 =?utf-8?B?MFdQK2YwVzJtY3BXb0FLL3lkd3JJN0FJdHA2QnVJbUV6S1c1cytMZVFYMytj?=
 =?utf-8?B?S2xONDE5TUdOcUx3ZC96V2xwRzM3Mm1ORytRM0JPR1l0bndEaVJLUk93T2Ix?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5a3cd4-05f7-43df-4015-08ddb991d886
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 17:57:01.2409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txjxRvJenMo80VKclDe//lbvNDB5iJa68/9EeHN+xIiRmrpG7neHni1vMWd2BtnO6KwmNTX/0T4rTzIZH1CJv3UU89+quBZffFUikeXyjtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4590
X-OriginatorOrg: intel.com

--------------KVUdXLTVhoaP7eJ0mFdCsNPx
Content-Type: multipart/mixed; boundary="------------lW6cB0JT741a70LvGDJHwSAp";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>,
 "saeedm@nvidia.com" <saeedm@nvidia.com>, "leon@kernel.org"
 <leon@kernel.org>, "tariqt@nvidia.com" <tariqt@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "shayd@nvidia.com" <shayd@nvidia.com>,
 "elic@nvidia.com" <elic@nvidia.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Anand Khoje <anand.a.khoje@oracle.com>,
 Manjunath Patil <manjunath.b.patil@oracle.com>,
 Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
 Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
 Rohit Sajan Kumar <rohit.sajan.kumar@oracle.com>,
 Qing Huang <qing.huang@oracle.com>, Mark Bloch <mbloch@nvidia.com>
Message-ID: <b6beb765-895a-4d6d-9447-ffc3fecbf5e4@intel.com>
Subject: Re: [RESEND PATCH net-next 1/1] net/mlx5: Clean up only new IRQ glue
 on request_irq() failure
References: <7cb171c4-3c36-42ea-bd6f-52dfe6bc5dab@oracle.com>
 <06e99d8d-a6de-4687-b109-0d1557ac2779@intel.com>
 <d1b697de-ea53-4634-9821-f403090d3e09@oracle.com>
In-Reply-To: <d1b697de-ea53-4634-9821-f403090d3e09@oracle.com>

--------------lW6cB0JT741a70LvGDJHwSAp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/1/2025 10:07 PM, Mohith Kumar Thummaluru wrote:
>=20
> On 02/07/25 2:21 am, Jacob Keller wrote:
>>
>> On 6/25/2025 10:32 PM, Mohith Kumar Thummaluru wrote:
>>> The mlx5_irq_alloc() function can inadvertently free the entire rmap
>>> and end up in a crash[1] when the other threads tries to access this,=

>>> when request_irq() fails due to exhausted IRQ vectors. This commit
>>> modifies the cleanup to remove only the specific IRQ mapping that was=

>>> just added.
>>>
>>> This prevents removal of other valid mappings and ensures precise
>>> cleanup of the failed IRQ allocation's associated glue object.
>>>
>>> Note: This error is observed when both fwctl and rds configs are enab=
led.
>>>
>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>=20
> Thanks for the review, Jacob!
>=20
> Based on Mark Bloch's input, I=E2=80=99ve sent out another patch target=
ing the=20
> net tree. You can find it here:
> https://lore.kernel.org/netdev/1eda4785-6e3e-4660-ac04-62e474133d71@ora=
cle.com/
>=20
> Regards,
> Mohith Kumar Thummaluru
>=20

Thanks. Yea I missed it while scrolling my inbox and thought this was
the latest.

--------------lW6cB0JT741a70LvGDJHwSAp--

--------------KVUdXLTVhoaP7eJ0mFdCsNPx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaGVy6wUDAAAAAAAKCRBqll0+bw8o6Izq
AQDrYd1vigXIiG2+rC+YojbffSWf9YCnDzPEC58yqHihtgEA99856STm18dUKaMsUvoaU+BqZ5MG
5Z1c+Nt3SubapwQ=
=usuw
-----END PGP SIGNATURE-----

--------------KVUdXLTVhoaP7eJ0mFdCsNPx--

