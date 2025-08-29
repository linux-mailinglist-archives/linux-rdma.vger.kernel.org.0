Return-Path: <linux-rdma+bounces-13005-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C394AB3C423
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Aug 2025 23:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B18164E1561
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Aug 2025 21:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7975234572E;
	Fri, 29 Aug 2025 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nttE/Wp6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D97C1EEA49;
	Fri, 29 Aug 2025 21:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756501990; cv=fail; b=XecixsvhPzHnkfBI8ccoIwWPbAcr2Y/edPxq5iJRb9FsWJ/hgDnCe5CFr0wnhJ/Rm+6YaBdAgYC3zOjQgOELDf0z/+TBdVHrWszTIkN7UZxjKpRMYFe2qO8JuhAiImJwfYK5Z8kkdLCja+QsAp6cMg425djaZusN1vanm0U87Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756501990; c=relaxed/simple;
	bh=jPAeL3FU24AfceJ+ctQjAKJPWQ0WebPAsJKkD4b7Pfo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HAS/LwxRfR2awUEef+AMxX35LpErZ30kGRy2MSaD85TIRiMy+XE5lAapIPYDECcrcEzppf3zH3yx/BzVfJvYe5enpoDC1w/KaZO6xp+qI/cMn6hPp3F+yu8IMuFXhw68HIHsvLmpqEKYoXaRRvM043hOtzfnln8vhzAmmDUKiws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nttE/Wp6; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756501988; x=1788037988;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=jPAeL3FU24AfceJ+ctQjAKJPWQ0WebPAsJKkD4b7Pfo=;
  b=nttE/Wp69T22fUo3BZetPCESej4UboIJqd1ObxbMFei/J0U7ple+PewR
   Fw1GfWXH1jvDd4Kp3wdWnYy9Nx+adcwatR2HWP2fayla7eNHqmXk5bsyS
   HKYnkKeMvWY0h6jyKqUDqAyZ4slEUvwvHU9oOfIvQrQtbNgKUJ8kGMfEZ
   mUlLJetA21mByysDfnfshBjySJQZv8dr42xg7pQYr1XpXdg7HnFXY+soL
   JXA9y8lMiccDOzTlg4eCs9BFqj0P9YLcaWubiWD0sT6uoZYeqY9fL7Vh4
   h1hTzeiAVESR07h70DWjrZ82DEG3nMgt8eEimVpEs4lno1PAeLgQ+Fntc
   Q==;
X-CSE-ConnectionGUID: hQ8Ut5zwREiO9C1vErT8jw==
X-CSE-MsgGUID: UI2NtwBnQLqBI1/Tspx30g==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="58945184"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="asc'?scan'208";a="58945184"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:13:08 -0700
X-CSE-ConnectionGUID: yA/oCODbQE+6+HIQWYA48A==
X-CSE-MsgGUID: 10U23auBStCyw1FFaS4I1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="asc'?scan'208";a="194141283"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:13:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 14:13:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 14:13:06 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.78)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 14:13:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hH4Mz45etGt0wbEPBfpoMp+AfHmgD8ZSQR0irMr10N55okhbDtWKF6GZmNDA4RMAs2ovcemAh1jj/5gZFy+djODphKTr1K/GYSgXdzNDsZQOCMdfGY42cgBrfw1uULpF5h42KDa9BawO9RxJqcYDRHwGUK984H2W2yhntcpUpbLUiAwwlkvrdyZKoPHYwPa33rmRHIHapuYoBLCpuXGiyDSoNkzpgcKhg97eGsYcL+yY1GVcQxIbQta+ankly8D6Q+GPYgYSOwRdCHS4XwE7VGX40ZBEylsq1unvpmI8Qz9FhMYd0jAhyMMQXa5KTQgquk7GP7HdEnE6t/OClt15MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPAeL3FU24AfceJ+ctQjAKJPWQ0WebPAsJKkD4b7Pfo=;
 b=UPKsjelxBuJg+QG+xYUu2OVsQaDaPiQgpeZxDNP0SfAImkv4cLFv4kOn5Zp6RNJyOCNCjkD4lVPbXz+UPu7YmYTZf2V8hbIuz3wnye5OtiZElNe+DLmohwlPWB6pgiIaAKzO0ObUge5JudOBzFKwlaHT84oxO3HKKb/I/XaNWqRO+JHJnf/R/ciiclx1xIetwbWDeH3/MRr8YaLFuaqpMBWKhqd+b7h79G3Usp+ExC7X51K7a9HMTRjCmXwN0P3O0TB6Gc2ki9acuEWGUY3ReU6pIAhgzt9y8XXX14wJCDDIE3EGFei4iFmd0LtyeDQsO+RIrV1OTrW7ZiQqaZ9o5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM3PPFF3F4DC26A.namprd11.prod.outlook.com (2603:10b6:f:fc00::f62) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 29 Aug
 2025 21:12:55 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 21:12:54 +0000
Message-ID: <9c4be80b-86f7-49cb-94b3-72f004c4cf72@intel.com>
Date: Fri, 29 Aug 2025 14:12:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 rdma-next 01/10] bnxt_en: Enhance stats context
 reservation logic
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, <leon@kernel.org>,
	<jgg@ziepe.ca>
CC: <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<andrew.gospodarek@broadcom.com>, <selvin.xavier@broadcom.com>,
	<michael.chan@broadcom.com>, Saravanan Vajravel
	<saravanan.vajravel@broadcom.com>, Somnath Kotur
	<somnath.kotur@broadcom.com>, Kashyap Desai <kashyap.desai@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>
References: <20250826062522.1036432-1-kalesh-anakkur.purayil@broadcom.com>
 <20250826062522.1036432-2-kalesh-anakkur.purayil@broadcom.com>
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
In-Reply-To: <20250826062522.1036432-2-kalesh-anakkur.purayil@broadcom.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------m5UkgtfjTVyBaJA0dpALwsrZ"
X-ClientProxiedBy: MW4PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:303:b6::31) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM3PPFF3F4DC26A:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b70c636-8b93-430c-3a46-08dde740d228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVRSR3Y3ZS9vQkt5azZKQ053cjJYSTV5RlZhV0VLVWlTbEJKRm9DUE1CanJv?=
 =?utf-8?B?YTVxazRoQ0RGSWFvTXJBN0tjRmpuaTNjSEp4SkVzb0lXOFlKMDJXblNSamI0?=
 =?utf-8?B?eGh2WUpyK1R2NlBORXFUS1dBMkZ5NXBlYlJicWI3OUlCSWREVklUakVBU1BL?=
 =?utf-8?B?TVIrSUU0aHBvdVQ1cy84MzVVcnNxTGZqUFhZcHczblYra0xBSXU5L0QrODhV?=
 =?utf-8?B?aGpoSWk2b1F2VjRHenVxcWRMREtWSXZnYzJmb2xWZEJiQW1lWElDRWFtTXgw?=
 =?utf-8?B?SmQ5aXh0bTkyem5zdzlROGcrYmwvd2xRd0duUml4cmhwVjNSWXBaREJTNHYy?=
 =?utf-8?B?RFRSam9yK29oOElSZytVZVA5c1JXMldqaWdWVUZvQWdmZ2hPMldNV1M1bUor?=
 =?utf-8?B?cENhZ1lWYXd5M3IxS2tTOWhMM25RWnJQMXBUU2EzTkNkQ0pCQytkZ2dqWGRK?=
 =?utf-8?B?S3BETmVUbnh4cVFIREliQi84SUxrcy9xUnBYTERwRTRiYTRabWtMamkvdFRi?=
 =?utf-8?B?Qkcyc2VBa2FremxXVXdhMjRiS3ppWFVmeGZnWUVLZ3owUHd2TWY0YWg0NFl0?=
 =?utf-8?B?ZDcwLzI2cVY0U0RCdFJkTWdFVXlpUDFVWGx2UjdtQmt4T3FadlprYkttbXBC?=
 =?utf-8?B?MTI1RFVQTHh2OTloeE83a25EVVZzaDExZzJDZWdxam55bGV5UExZWG4zNTBS?=
 =?utf-8?B?OEFPM1NYcDYwVHhmSlRMWVJVbGV0amd0TGVMQXpxd3lUWDY1aTUzaEc1Y2Rl?=
 =?utf-8?B?OWx5VlhtbUhialZVY01QOEM4VUI3T1N0dzhHTUxqaUhaK1hldDhyMStrQmNm?=
 =?utf-8?B?M3hISlQxU1VyQlVzSmVXQVZKK2NVRTBlL0FaOXNBK21kK3hkdUV0eTBUV2RL?=
 =?utf-8?B?RkxuQnU2c1NTZVFOVnNUUTFldnJlRGFvL1czL0ZLMm1oRUJQb1VqRk5iNmZt?=
 =?utf-8?B?UHRHSWIvZ0hOOFlobHVxcFNKVlRBdU95Qlo5UUQ4KzV6UWRDS0l6QktBSnFo?=
 =?utf-8?B?WEszTlJyYTBaaVB2T3ZmV0ZXR3BRNFhSTWtZdjdWUExjTjFrQTZGamxITHd6?=
 =?utf-8?B?L2czOHN0WStmRHNFZlJNVFdlMW1xVXNnb0VKbkpDRmhJU1pEZm1GS28xNGU2?=
 =?utf-8?B?NTN3OExWVnpNbjFVM1ZnZkVHZnlxd29pRWJyR3IvZ21iYkx0a0x5aHo0WUxu?=
 =?utf-8?B?b3dEblEwbW95SHdHaVVINUkrVlRDbTBjYXNLTStmQUdHY3RhMFZYd3ZnMml4?=
 =?utf-8?B?Ui94Skgyb250MHMwZDVydkRjRmsyczJnY21kWUF5RHRERnpFNTNQc2NFYjlv?=
 =?utf-8?B?ZWR1UjRXaGFxbXU0eGtRdlR3THJNd082WnQwMHdRT0ZvbXpJSDRJRU9JKzJZ?=
 =?utf-8?B?Qk81dTQrOXhORkdjaDRrR1dnaTB1bXk5UGJvVm1ZV2lZcWw2WTVCczg3czR4?=
 =?utf-8?B?RFY1V3JxbHdmTFRRR3libFZkaHRtdmtlZTY0NnljTTBFaVkxYlRZUy9DNFlQ?=
 =?utf-8?B?QUFBeVA1VU9iQVdRZlZsd0hzMHIzS0xiUVoza3dWWmxhV3R0RElvOTR2M0lr?=
 =?utf-8?B?b1o1eEx2djBTSExCbkxMK0NrdGM0RThsUTJIVUw3UDZ4Mi9kb1ZxSUZYVGI3?=
 =?utf-8?B?bFBnSU9iQ2prVnRjbWZwUmpaQXlhcndEOC9MMmMySlZEeTVCR1BucGlFUnRl?=
 =?utf-8?B?Z2hocmRkWWU3blpnblIxbGkraE9OU1I2TVJSNzNET3o3NEI2R0ZRcWZPblQv?=
 =?utf-8?B?dDNqdlNGWEo2Zk1lNTNuOEcwK0Z3UVVDRXFDbHNqVXBvSjhwZC9BMWpjMW14?=
 =?utf-8?B?bytIR1l5QW8zRWdNY3hGRUtOelk1cVhjQ3NpSGxWTHl5V3pLOEh2bjl5eG55?=
 =?utf-8?B?a2NNdnB3RGlzZi9HVmJESys4WTQrMHlvM05nb3h2TGMwS3pVUXU5bFJkSFdy?=
 =?utf-8?Q?Rc2moA3SSFs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnJLNDRVaDlkaHFaY3lYNENCS1Z0ajBIOFJYZk5QYW5iUjdFNlg5a1h3MTFK?=
 =?utf-8?B?b092ckI4ZVpNZzdOaS9HbVFVdmhkeGo2K05KUlc5dWZsRGRrUlJ5UGVZbFFv?=
 =?utf-8?B?V3JMZnhGRngxeU9QTk1kQ3V6UzB5WldPRCtPKzRjWVd1U1orZWs0UTlWbmhK?=
 =?utf-8?B?ZU9KUWxTSHdiSUEvSWZRZHhSUTVrMFRqalVMUDlxSHFDNm41Q1Rtd1VqdHVm?=
 =?utf-8?B?WDlxSUE1UzNOUzR6d3VCcTJ0OGVQYVNyM1E2Q3JNMGRGYmJjMkxMR0hYRUNp?=
 =?utf-8?B?OHJIdUFZZUVDWlBIellMTitLeXRzNVlnYXJhUEF1YWN6ZkdoREQzTElYWE5t?=
 =?utf-8?B?ZkRXSG9qWlBQdkE5aUsrRVhxbjJXUjI0TTZ6Q0FLUWhjR3FrbWd1SnBaYjRR?=
 =?utf-8?B?SFdzakN3Z1Y5QjNVM3dFb0ZNODJCdGgzem8rMTZHdVVJVkpmRWFwVzBBVi91?=
 =?utf-8?B?eW85eVA4eGxaWmNpVVRKQTBjUnZDSnVSRmRpSlM2d0tSNldVUmhGdm9MeU1F?=
 =?utf-8?B?SDJVL1JJU0ltUTF6YTRxWkdXcXhZdTU1clRhaG94SjZrbE9vdzF2eEhWYUxD?=
 =?utf-8?B?UmsxM1JEOE5mYk5kNzU4TnFaMWhoSTFFZXRnZWRDUlB2YnpyZ3p3dTJ1NmdP?=
 =?utf-8?B?UFFVa21rYUQ4NkhWbkRLRkNlTitXbVBNVFl2QUc1ZTFhNURjY0hiUG4zK1FJ?=
 =?utf-8?B?MFcybkF5bUo0aDd0aURKRTZ1UFl6YUtQbkY1RXQ2U1F1b3ZNTVhNRmt1Um1h?=
 =?utf-8?B?TkhYTXhDMTI3OEJMVVpxZTR3bWo3OEZCb09weWY0ZkVqc2xaaUdxU2V4d24y?=
 =?utf-8?B?RUFxTmNOOWZMb1Z3bUlOc2FEcUVsNkh0RGNhNVlDOXJPdGcxM1Fyajd2ays2?=
 =?utf-8?B?dGRLM1h2bkQwUGhMd1plU2pvdnBmamJNL20rZ0kydUlVcEkxckJQVlpjb1FH?=
 =?utf-8?B?UVlGekJYOE8vT3dHVEs4NmEwS09BVmF3eXZjTWtiNjlwdEwrOTh2RGY4Mkpk?=
 =?utf-8?B?SmFJQXQybU01QUN6MSsrQ1NxZERqMFNZMzZBbnJTeUVnRE1Ca3lCYmt0NmNr?=
 =?utf-8?B?dkJpdlIvZmx1YW5Hd2R3ZnUreUtRWGpUbmpRcys5RVNZOXFTa1FpOXpZMURH?=
 =?utf-8?B?aFJkUjB3TVFuSkJzMC95d0djcUxVZDd0amhCbWJJYTJpQ2dqOWRyUGE2NjZx?=
 =?utf-8?B?aURCUkMzQUNMQkEzdWl1WFluTW5obENGenphbitEMHZuV2RnN3FlOGtaek1h?=
 =?utf-8?B?Rk5XdzNRT2FaNEVLQU9MZ0dMem1qeDRkTTI4OEZPbVFjUjBkYXE2UDdORTdq?=
 =?utf-8?B?NlVFdzhkR1FMS1ZpL0RXaHZaaThaZVE4SHdEUU85TFFFS3REQVdzbU0zY21y?=
 =?utf-8?B?TElNQWxCNUdmbkhzVTRudURjck1RV2R2eWk0U0R3WUREbGdWZEJGQUI0eG5G?=
 =?utf-8?B?b2pGb2NuZUlKRHFlN1NXelhNRTFBakptbXJ1dWoyR1p4V1ZXSFR2cFpMZ2Y0?=
 =?utf-8?B?QWlJb3UxNXF0T21HOEhWaTNqVW4xWWJpK2xUTEt0M29yL1B3RG5TMDdDbVRG?=
 =?utf-8?B?UWtnZFZybnB2U2tESi91RGJvTi9KQURKOUVjSDl4K2ZGRTcvUzhDanhLS3hu?=
 =?utf-8?B?N3kwNS84Y2Z1V05xajhOdWtKRWVJZlJKUUFvNnZ0VlQzemUrZFdnOXFxWkFX?=
 =?utf-8?B?ZDdPV0E1YklCeTljQSswWS9KMG0rNFZzcU8wWkxFYUhoV2xOZmFxMW5VWXNx?=
 =?utf-8?B?ZEZsTGNUSFRsNEFuRDNHaWVOejJ5R0dadzZPN08vb0kwd21KemQwbm40WVNF?=
 =?utf-8?B?MkFtakZHK3ZPRVVleXc2TFdjcVBpSHdzNDQ1elVnamcyRURKMTlyMXp3V2RK?=
 =?utf-8?B?U2p0RzEwS2JxNXJXTFFETFhrY1RrSFhwUVFFZnl3Q2lnajM2QjBlY3EvSzdt?=
 =?utf-8?B?VEdaQ2dkcEZMUkdCSml5cWErT0psb0VHU0hocDFMRUsyMHNETTVxT1ZlR2o5?=
 =?utf-8?B?dXJzUTJVV1dNc2VFeWFRa0VneWcwRWErR2RSeFNVeWN6Z2tsa2dZZUo3QlVr?=
 =?utf-8?B?U09WSW5aL05RNTc1ZzdtOHIraldydllBTXJWOXhQalk5WTBBUENFUzlORCtH?=
 =?utf-8?B?SlRVM003MjdsTXJxTDdWMk8yQzAvekpKY09ONEZNV2ZqcjhaY0djM1dDbEw3?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b70c636-8b93-430c-3a46-08dde740d228
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 21:12:54.9133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ik5AsbLXfBPPDh8/Q+geE2MRNEI/EbHUkvpjW4Ip7g1m6P54U3YOX/m1d8mJKctv9BENCtB4bEXPMqNxGQ50i9itfUZRds3uLuazgrQgXSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFF3F4DC26A
X-OriginatorOrg: intel.com

--------------m5UkgtfjTVyBaJA0dpALwsrZ
Content-Type: multipart/mixed; boundary="------------nBxvQsMJbK9Dr4AG9w1531id";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, leon@kernel.org,
 jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
 michael.chan@broadcom.com,
 Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Kashyap Desai <kashyap.desai@broadcom.com>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <9c4be80b-86f7-49cb-94b3-72f004c4cf72@intel.com>
Subject: Re: [PATCH V2 rdma-next 01/10] bnxt_en: Enhance stats context
 reservation logic
References: <20250826062522.1036432-1-kalesh-anakkur.purayil@broadcom.com>
 <20250826062522.1036432-2-kalesh-anakkur.purayil@broadcom.com>
In-Reply-To: <20250826062522.1036432-2-kalesh-anakkur.purayil@broadcom.com>

--------------nBxvQsMJbK9Dr4AG9w1531id
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/25/2025 11:25 PM, Kalesh AP wrote:
> From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
>=20
> When the firmware advertises that the device is capable of supporting
> port mirroring on RoCE device, reserve one additional stat_ctx.
> To support port mirroring feature, RDMA driver allocates one stat_ctx
> for exclusive use in RawEth QP.
>=20
> Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------nBxvQsMJbK9Dr4AG9w1531id--

--------------m5UkgtfjTVyBaJA0dpALwsrZ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaLIX1AUDAAAAAAAKCRBqll0+bw8o6BJF
AQCOjb5JXgYpKQ7VN/cUGp0LIeSRlQz8q3wqx2Zc7qChTQEA6pVa+bE99RDuOynt0x/HfZjLNPmq
ucVbWkerRoBbVAA=
=lNaL
-----END PGP SIGNATURE-----

--------------m5UkgtfjTVyBaJA0dpALwsrZ--

