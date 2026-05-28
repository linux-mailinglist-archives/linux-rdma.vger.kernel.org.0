Return-Path: <linux-rdma+bounces-21412-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAZeN0HSF2ohRwgAu9opvQ
	(envelope-from <linux-rdma+bounces-21412-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 07:27:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F73B5ECCB9
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 07:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58C20315567A
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 05:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BBC318BA8;
	Thu, 28 May 2026 05:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fHJc0X0n";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OznyilgI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EEC3191BD;
	Thu, 28 May 2026 05:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945894; cv=fail; b=S0E0fmiOb6y05HvrdAMgvP+1kPpnv0IlGyfZ9om+2H7AUquRIhyS1B7XJeED4nvhraT3wpTKCgG04aziN+nEJBvbqWr4xInpb8YiVFDOKg3WmMziDUPRLKtozM0BgIZ1tJVlxSUlIXQjSpfaltoidIvlk+eVWNcv+lMCWJeMQ5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945894; c=relaxed/simple;
	bh=eL5PJkxuUc6tiddMLrekwUV4ltePqfcEN5bsrJP2u4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pWU3E2Nhuy7kHab0Qh0Vn5ChE97Yb0HHIvxcpTg1oIEzsjtCVKh7g4zxbu3kcz5gwJzWWwUXtEW52ou7qyTCdmuWCwi5tMSutJnzkN2iEI+L2XZz69u+gEQUjb4fmwqwLOGC6EhDqseZC87xr0z6/ILAk9FfJSKwMx63Fmy48Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fHJc0X0n; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=OznyilgI; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1779945892; x=1811481892;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eL5PJkxuUc6tiddMLrekwUV4ltePqfcEN5bsrJP2u4Q=;
  b=fHJc0X0n/6815Q2r65ZDgVNzFdOHqTqFyuGSzaRdw+Kx81PWUNcTzDqc
   CGkV1pzmDv9pdWgxk6rh74MaTHehQiiuT+BRs67bqQcihNQU6DQej3e5u
   Kl0j1j9rMRIFXRp8RYzvlC7dc2O/jiahjXaidRf0c8IrIM03MLutFhrp6
   6L4yvVuO5BcqQmQpf4KsvalLwhXkZnoEsQPbvZZkEczhFhN8zLNBDsAyB
   93nj/OUakNP2xb3PDVi/zQml6G2uUxQ3prFeg9f66TrJ9N9RzeHwrnqww
   yzlc7IYH8x6fEpftq/oO7ZKfxTdm/sl2g4RMcvR+MLeUgp75yrob2zLml
   w==;
X-CSE-ConnectionGUID: QFZvOGmCRKCgCUme13+weQ==
X-CSE-MsgGUID: 6dIGQfupQNCT7A0iLV48qQ==
X-IronPort-AV: E=Sophos;i="6.24,172,1774281600"; 
   d="scan'208,223";a="148774879"
Received: from mail-southcentralusazon11012045.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.45])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 May 2026 13:24:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZxgqCMjPtMhvQQCapsnuXY1KX0uO9REcl+joEW9sk/kp5gvghprkzJr71PvobuHyFt3yJn1MBxPM9GZEPJW48NTUQvG8ptpiwzIJUvBFSWRuPPPBnWhYmYS+sGiPoJ6K+wofCpnHcgbFLzvcHJjw4Ndd/IiLD7yiLTdo3Z3qmR+5vM8LnssTK5Bi2UsLQvmzgUkazcJC+GY++MfCKfsQ4agGchcBfyFomfb/ao8L4/jacool3TfKaJpVWF6aW8nP5diSPN//PPyDwPRVeyx+nK6sNhKSxBOewrDUrz+aHwI6Idjd3kcLA5cr5yWx+ydiKNZLyeimHtKsri3FoO+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w50wmbJNfajFh7v7IpjhMKhLxcaoKqhdIyxQvHOGdYU=;
 b=XY6qzelu9dI0iKREmhJb+r/AwaAstW9wQ9PfX7qdMOB/EFn4st+nz1La+nkyGmF3YJaXWYt+Sc5M8r2b48Da01+lr66FvotrnkW73gE6LM7UPDk7Yfa9Q2jSGGSen+96qyou074mXw7HFS2uD6IEf2JOQJm7KBeuC11Fg7x0ImfxQA1qAwLiL4VGcYD2uB4/jw5l3OiQAfsRkfl3NpUtToluK8Ax9OblVjMJmJBuLbf+ZVbPKXRRssNFfMQ9+M3qCRV+3sPYrvdN0vUOh7arFTTyFDCaBFoPDDvC3zbFePeHocwdXFN6jndJCpiI/ena2dKMkwlHJk53jyUFRDjLHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w50wmbJNfajFh7v7IpjhMKhLxcaoKqhdIyxQvHOGdYU=;
 b=OznyilgIOJSWqJF1PY6M+XuAawZZb1uYinup+P989JzlwOZP1rSImSwjf6UX5xDs9zbgbZsl177NbE33+VGSAMxZ0R+4fOmPQKJKdt5GHedGP6+Db+ud6e0DM7neRv0bTmSbWPZ0SRuHGR3gbK1uIbBGI0vAToO1k5Lp0Flx9PQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by DM6PR04MB6427.namprd04.prod.outlook.com
 (2603:10b6:5:1e8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 05:24:48 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 05:24:48 +0000
Date: Thu, 28 May 2026 14:24:42 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	nbd@other.debian.org, linux-rdma@vger.kernel.org
Subject: Re: blktests failures with v7.1-rc1 kernel
Message-ID: <ahfQFHuVx2G7OFLE@shinmob>
References: <afB5syZbUrppgsDQ@shinmob>
 <c4ddc101-184a-4e4f-82ca-c3123bce5e34@linux.ibm.com>
Content-Type: multipart/mixed; boundary="m7phjouketphzgld"
Content-Disposition: inline
In-Reply-To: <c4ddc101-184a-4e4f-82ca-c3123bce5e34@linux.ibm.com>
X-ClientProxiedBy: TYCP301CA0066.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::7) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|DM6PR04MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a07867-1fb3-4074-282e-08debc796f70
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|6049299003|366016|19092799006|1800799024|4053099003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	oeyBd39ms1NnkLA8cca5B+6CM435yS/lZFsBDAJI0ry74Smv/2W9nxbqwyI/T9uaQjCWEt56t6RRxn+IoPKufx4Epxo/3oxDVvRDmuZS0vK/XoBCzNgMjHAlKaoSbW7TC1lF9VBfFBPHXb5GCR2Bez2DwAtMjIiYKen57yFfByUqChuZwJ1uxAZ4de/q0bXCvlPxLTLJ3SMTt2VimdbPzYoDuuRErwR9fRSUssfzxBMvewgpCsxk9dQPWi/PYbYKVwCi9hWVARegRG15p+UxQYvwl4v5vic/zwrJMI33FZDWfgtVCga8Qnr84jQNLj7SMZGhzfcAGluSCKUNpJYAos5hlvMNzrlHVEv2rRHEPEb+OMCu85pGyHuuHzDMSlYCyLCGxo9vRA/i/EjAy+783RH1TIv9rC2KyGUiGhPg37QTXTDIduzACsfMAHfHHkLMk6kwAywibJEYmYg3vBiWWiqLXJE8wym9Wkui380KkuHGxnUxRDsauvLWzDDT5C1Gu97YKKHrVPMwttq4ZoifrCtZwGfutCqfTZtTdmN8EHzyo0eg9TdT0VelIuxprIvInUZJpLXGuhDkfx2NZMLs4x7yOHbyq2EYyRmpNpR7eTL1bFXcxFu74Wsno8jO8NEcIZ48cgp7+MKZK+HfI2fgIpYk6madKY/6y4BNlk1OsJEAYfvSMLgBuRllfou8VtCW73y3ZHdWRXIcOg9sb6rKhA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(6049299003)(366016)(19092799006)(1800799024)(4053099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/mnk9aU9pdxk1Mno3iJJGu6uUGcIm87vxVJgHUuH+q+/qDAUdkXYMbA0oO2T?=
 =?us-ascii?Q?4+0KNVqyKSucNhlIj09fuHNNp44OJAx4WrFGxlwhjTszneaePoLkW18tx1gY?=
 =?us-ascii?Q?mzy46qeovnWtT/ulF+MfhuMKTlGXOhoCOuTnLFelqeC6yaVVfBeyqt6Z7kmC?=
 =?us-ascii?Q?SfaRIhtFxWR9Cd0EuBNjqVJvOfHuuO/6NfOP+KfSyRbaCSgSiJv5J1mIk/yT?=
 =?us-ascii?Q?R4hcKIPwyQfLaTkwGn5Mv/qmy9m0UUM8a94+CUJzseYF7ZPbPuPX1R3JDPqV?=
 =?us-ascii?Q?gD38sg7psnyRef843MT9wtBKlV1fRCYzrbhsce7W0UW7MRbRKrqPAkL8KZXn?=
 =?us-ascii?Q?rOA9aENh1oiHuNBapDsYv7q9/fGwVzujonYps+qxK+rIk0wgfvhFPpcmSq8t?=
 =?us-ascii?Q?RcrI6mcP8uEwN6CDr3Z7njLulqhTRqPw3aU1seatHSZWuF8UWDFjtueeuemd?=
 =?us-ascii?Q?Z9Bvr7rjYqnVjcmBeyJr8mJBj2hb6b20LksV/6RBm7FSSHjzfE+iKmra+HXD?=
 =?us-ascii?Q?dOn+1ttRxDUWwyI8T0CwGbRHqMRRnWAXCX5a2FRno91vQqdtdMUU7h28/kML?=
 =?us-ascii?Q?xvNyeWd65L2ND3gc18rsl6GsMa6dwdFPFG9cBf7jmMLq/rO81X5esvgpNw6J?=
 =?us-ascii?Q?s+5Fy5M9Hh1+Lm/vth0zaA53WLI9Nui7gjEQPRSC8x/1QPxzwOzY8Vwp/y85?=
 =?us-ascii?Q?YiIohoDXn2/0cKZitgVJg/1UBgIbpc6N+7eWVE64EjOeBtMgtRlJ1ok00qcz?=
 =?us-ascii?Q?BftkPfD9AvXzHPE/mYzgx5Gdz/u1M6klQ/d+uZG/GwmK5tNAZD7h5h42OBW9?=
 =?us-ascii?Q?0aHr4cpFnQhYRxxDwbU8j5PCXxJU/cz0ZPlL+aYIkPWXN9cFSY221fasq/od?=
 =?us-ascii?Q?8aBrS1AdW6E1FhPeMV1nUXFMcKsQpCUKUE45olFfFjdrX+1lfVjsDHWAdNAC?=
 =?us-ascii?Q?IFUSeyOyj/CIM8Oj1dUFKjjiQsHZ5V6e410rUSTaYnkD2bR45yOAUQsauNZu?=
 =?us-ascii?Q?xQ8uxEcJf4IE4FNU5M53z5tnYIZBpJjWTQYJiX/dY6F3tc/LpYAJ9hVOeE6U?=
 =?us-ascii?Q?zh9fCrM5W1fUMgj/2aPFhZ2ccL6gVk4RJrA8VfL3zZ9xDpyIZ7+W/PCsX6y6?=
 =?us-ascii?Q?+OQbIOQx5COYVnjmLDBWdBkp19072GrtBtVZdLiGctjVlmRjlnQdZf5jZVNX?=
 =?us-ascii?Q?fsLGJnvKH/8RDbKoasCN7dDQwh8yLZogVzoUsXARrolW7VdqmAnIQ1F+hPXv?=
 =?us-ascii?Q?2U2unqXfOq0JlrGO0tWcZgSEeXj8FJDz3etzUM8MDvJ/0ych29ytbmYH+13+?=
 =?us-ascii?Q?0wZwI6vj+0C3Iw0zpjMCximVJ8FIxHkjgBbRYrrXaHhYhZL3aEbqjL/ncub7?=
 =?us-ascii?Q?SoOea2SckJplRhK2LsBYkyF51//iJXu3PQvWE9pbJvFoOuvcJZYqOHGamUP5?=
 =?us-ascii?Q?53Yobx3zOGwyj4r8qCDtDOZ8555l4XvNEJLVf/OpFEwS1CFr81LMC/p/I54Z?=
 =?us-ascii?Q?HtM36MpP3kMFRSEO1LRPTXxGwR3Zxx5LGrnqcwd9t0nDZTZTPZjCizV3n1o9?=
 =?us-ascii?Q?4N3NRkgevv3hdHsI5iFScBgF4Y9wgdxC8nr64XZk2H8bJKWu4+jZoLzuSmfO?=
 =?us-ascii?Q?a5RwTW2IGA3c2dk9EVta5uVoc9UHCPZPlj8fk9bqHLza467vCAgdsTvoSSo9?=
 =?us-ascii?Q?pTVRLN8W5nyKMZ69Qqk+eZnKPFyNHUXWH0jpsM7vPf8WC9sc/mMSHqVTBi+Y?=
 =?us-ascii?Q?ECg0qqR80hCVSQLVn1wHcteX1v2GlcY=3D?=
X-Exchange-RoutingPolicyChecked:
	BUTfEy1/0bEAFESMYV8puJ7vQDnn4+ngue1Gn8/860ZJi6ZNVPb6U7uZiUwUtqBpR/kwR6mfdH18w+a/GoY+7k2oG1GdsOdoNiahVcl8nFm2cBmU53L4HDqUhZmYWywd2A6X858OWkYCbK2Yw/Fzw4d/MuNk/0sl3HodFFXNvb77rHTdUaQCk9/+yuriQsAq9eFLCfaiVNS9gIEIE7Rg0UTwPGf2pWV7Use+U5u7gPoyshokFBM8NZYDANhHmYO6zsDwo0f6K4Wq5RYvrffVFiLQ3YvbcbB7SSickNaLOE2S+TjAqYrZzGuElxtqIC+GTRqk2USksVXmgoQP/R6Spg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0Qw+gqvJimnQtLJZLOJ1dL4E12wEWO0SHWmmOD4fFeZtJAo2u/CFTsS0ckcoEIDjygge4K12Zlxv3d24D/0iBHVuzvyUmMPoQUHiJzMXjlihQ0BjGAgzzSoxGVtkKcVaH8+pUMu08JC2mb+RYG5IJcrbl7b5oKzN82D+faDp2JTdNXZFuvO4Tys7niqITsUQVunzW8JT4EKkrz1oQLXe8fgIjyu9rU270O90EB3KzmpwMs4Hq/Umpb/kZogfWPsOKbDPsulA0YapQhHdWD1VuQcDR4zbM1kWSMsuSUcWzgy3NSXGijJrTYnbuUhtXVgglsHZ3b1eqL4lSr4twy/AkXhFu0zvC7hdV0aeuQuKBkhz1iLB1qcbc52LpN/1trKOiFyaNMIYqAuZVlHbaVqaAn36rXVjB6etpD1oPBVCmcjrt4236e+DBgtL1LjBKY4gt+FFwruUyGQxI77bhY1kwlmyDVOK4U6A1PEBf7fLh1JKb/FFyVs4AixffapUPGZBF4eDCeXUbvA5m6SGretwQVJ8ln72XVsDB7xL72xy6Jhgr0QSstN+vWBABEtRz3x1QmtDb+wqRLNYammBBm3p53HwnQ0KqAlVCqMXJ8posz9DTkvrtlav8tetaHOeyZGq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a07867-1fb3-4074-282e-08debc796f70
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:24:48.0753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trvnhsO7uFMRImywF0xl9xnahIRK7vO6hR/jPIo4m8qqAbwNB1cpuYFbXDAr9Gi2hO19h7wEGuU2nMLO6o5nNGxZsVWkyZL+1LM3ru7pp7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6427
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21412-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shinichiro.kawasaki@wdc.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sharedspace.onmicrosoft.com:dkim,wdc.com:email,wdc.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7F73B5ECCB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--m7phjouketphzgld
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On May 25, 2026 / 18:14, Nilay Shroff wrote:
> hi Shinichiro,
> 
> On 4/28/26 2:43 PM, Shin'ichiro Kawasaki wrote:
[...]
> > #1: nvme/005,063 (tcp transport)
> > 
> >      The test cases nvme/005 and 063 fail for tcp transport due to the lockdep
> >      WARN related to the three locks q->q_usage_counter, q->elevator_lock and
> >      set->srcu. The failure was reported first time for nvme/063 and v6.16-rc1
> >      kernel [2].
> > 
> >      Chaitanya provided a fix patch (thanks!), and it is queued for v7.1-rcX tags
> >      [3]. However, nvme/005 and 063 still fail even when I apply the fix patch to
> >      v7.1-rc1 kernel. The call traces of the lockdep WARN are different between
> >      "v7.1-rc1" kernel [4] and "v7.1-rc1+the fix patch" kernel [5]. I guess that
> >      there exist two lockdep problems with similar symptoms and patch [3] fixed
> >      one of them. I guess that still one problem is left.
> > 
> >      [2]https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
> >      [3]https://lore.kernel.org/all/20260413171628.6204-1-kch@nvidia.com/
> 
> 
> I looked into this lockdep warning, and it seems that Chaitanya's patch indeed fixes the
> original issue reported in [4]. However, the new warning reported in [5] appears to be a
> separate lockdep splat and, from what I can tell, likely a false positive. There are two
> reasons why I think so:
> 
> 1. The lockdep report suggests that thread #1 is sending data over a TCP socket while
>    another thread #2 is still in the process of establishing that same socket connection.
>    In practice, this should not be possible because request dispatch over the socket can
>    only happen after the connection setup has completed successfully.
> 
> 2. The warning also suggests that while thread #0 is deleting the gendisk and unregistering
>    the corresponding request queue, another thread #5 is concurrently attempting to change
>    the queue elevator. However, once gendisk deletion starts, elevator switching is already
>    inhibited for that queue (see disable_elv_switch()), so the reported locking scenario
>    should not be reachable in practice.
> 
> Based on the above, I suspect this is a lockdep false positive caused by dependency tracking
> across different queue/socket lifecycle phases. We may need to suppress lock dependency tracking
> in some of these paths to avoid the false warning.

Hi Nilay, thank you very much looking into this. It is good to know that
Chaitanya's patch fixed one problem, and the other problem looks like a false-
positive.

To confirm that "lockdep false positive caused by dependency tracking across
different queue/socket lifecycle phases", I created the patch attached. It
uses dynamic lockdep keys for the sockets of nvme-tcp controllers. With this
patch, the WARN at nvme/005 disappears! I think this indicates that your
suspect is correct. I will do some more testing and post the patch.

--m7phjouketphzgld
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-nvme-tcp-lockdep-use-dynamic-lockdep-keys.patch"

From 74ae2157712e872711663ebb6cedbb4b0fc8c92a Mon Sep 17 00:00:00 2001
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Date: Thu, 28 May 2026 13:52:48 +0900
Subject: [PATCH] nvme-tcp: lockdep: use dynamic lockdep keys

When NVMe-TCP controller setup and teardown are repeated with lockdep
enabled, lockdep reports false positives for the following locks:

  1) &q->elevator_lock        : IO scheduler change context
  2) &q->q_usage_counter(io)  : SCSI disk probe context
  3) fs_reclaim               : CPU hotplug bring-up context
  4) cpu_hotplug_lock         : socket establishment context
  5) sk_lock-AF_INET-NVME     : MQ sched dispatch context for the socket
  6) set->srcu                : NVMe controller delete context

This is a false positive because lockdep confuses lock 4) (socket
establishment) with lock 5) (socket in use) for different socket
instances. The locks belong to different sockets, but lockdep treats
them as the same due to shared static lockdep keys.

Fix this by using dynamically allocated lockdep keys per socket instance
instead of static keys nvme_tcp_sk_key[] and nvme_tcp_slock_key[]. Add
nvme_tcp_sk_key and nvme_tcp_slock_key fields to struct nvme_tcp_queue
and pass them to sock_lock_init_class_and_name() for proper lockdep
tracking. Move nvme_tcp_reclassify_socket() after struct nvme_tcp_queue
definition to avoid "too early" reference compiler errors.

Suggested-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/host/tcp.c | 88 +++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 39 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 15d36d6a728e..51d496f414a1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -56,44 +56,6 @@ MODULE_PARM_DESC(tls_handshake_timeout,
 
 static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-/* lockdep can detect a circular dependency of the form
- *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
- * because dependencies are tracked for both nvme-tcp and user contexts. Using
- * a separate class prevents lockdep from conflating nvme-tcp socket use with
- * user-space socket API use.
- */
-static struct lock_class_key nvme_tcp_sk_key[2];
-static struct lock_class_key nvme_tcp_slock_key[2];
-
-static void nvme_tcp_reclassify_socket(struct socket *sock)
-{
-	struct sock *sk = sock->sk;
-
-	if (WARN_ON_ONCE(!sock_allow_reclassification(sk)))
-		return;
-
-	switch (sk->sk_family) {
-	case AF_INET:
-		sock_lock_init_class_and_name(sk, "slock-AF_INET-NVME",
-					      &nvme_tcp_slock_key[0],
-					      "sk_lock-AF_INET-NVME",
-					      &nvme_tcp_sk_key[0]);
-		break;
-	case AF_INET6:
-		sock_lock_init_class_and_name(sk, "slock-AF_INET6-NVME",
-					      &nvme_tcp_slock_key[1],
-					      "sk_lock-AF_INET6-NVME",
-					      &nvme_tcp_sk_key[1]);
-		break;
-	default:
-		WARN_ON_ONCE(1);
-	}
-}
-#else
-static void nvme_tcp_reclassify_socket(struct socket *sock) { }
-#endif
-
 enum nvme_tcp_send_state {
 	NVME_TCP_SEND_CMD_PDU = 0,
 	NVME_TCP_SEND_H2C_PDU,
@@ -180,6 +142,11 @@ struct nvme_tcp_queue {
 	void (*state_change)(struct sock *);
 	void (*data_ready)(struct sock *);
 	void (*write_space)(struct sock *);
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lock_class_key nvme_tcp_sk_key;
+	struct lock_class_key nvme_tcp_slock_key;
+#endif
 };
 
 struct nvme_tcp_ctrl {
@@ -207,6 +174,44 @@ static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
 static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+/* lockdep can detect a circular dependency of the form
+ *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
+ * because dependencies are tracked for both nvme-tcp and user contexts. Using
+ * a separate class prevents lockdep from conflating nvme-tcp socket use with
+ * user-space socket API use.
+ */
+static void nvme_tcp_reclassify_socket(struct nvme_tcp_queue *queue)
+{
+	struct sock *sk = queue->sock->sk;
+
+	lockdep_register_key(&queue->nvme_tcp_sk_key);
+	lockdep_register_key(&queue->nvme_tcp_slock_key);
+
+	if (WARN_ON_ONCE(!sock_allow_reclassification(sk)))
+		return;
+
+	switch (sk->sk_family) {
+	case AF_INET:
+		sock_lock_init_class_and_name(sk, "slock-AF_INET-NVME",
+					      &queue->nvme_tcp_slock_key,
+					      "sk_lock-AF_INET-NVME",
+					      &queue->nvme_tcp_sk_key);
+		break;
+	case AF_INET6:
+		sock_lock_init_class_and_name(sk, "slock-AF_INET6-NVME",
+					      &queue->nvme_tcp_slock_key,
+					      "sk_lock-AF_INET6-NVME",
+					      &queue->nvme_tcp_sk_key);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+}
+#else
+static void nvme_tcp_reclassify_socket(struct nvme_tcp_queue *queue) { }
+#endif
+
 static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
 {
 	return container_of(ctrl, struct nvme_tcp_ctrl, ctrl);
@@ -1468,6 +1473,11 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	kfree(queue->pdu);
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
+	lockdep_unregister_key(&queue->nvme_tcp_slock_key);
+#endif
 }
 
 static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
@@ -1813,7 +1823,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	}
 
 	sk_net_refcnt_upgrade(queue->sock->sk);
-	nvme_tcp_reclassify_socket(queue->sock);
+	nvme_tcp_reclassify_socket(queue);
 
 	/* Single syn retry */
 	tcp_sock_set_syncnt(queue->sock->sk, 1);
-- 
2.54.0


--m7phjouketphzgld--

