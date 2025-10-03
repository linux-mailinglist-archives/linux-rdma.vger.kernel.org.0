Return-Path: <linux-rdma+bounces-13768-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 602C1BB5A6A
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Oct 2025 02:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D12554E765E
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Oct 2025 00:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459794A23;
	Fri,  3 Oct 2025 00:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IN9q3qJX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E740334BA36;
	Fri,  3 Oct 2025 00:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759449776; cv=fail; b=K0eDsfdXkHzBTvYdKhOG5e0ea7HCUMzgvxLxKZNcU2Ov3z8aoLxjnHAr+Lhim94ui6IZKwHvN9yPxvsIBz+EZttvm01bEnQ2e0lGA9QUAdbG9sURdm6TyHJ0TwmFaNVkXeRsvnIwtYr3sFkS6OSJ0iCSvcXNopVIHKSDboc4Eu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759449776; c=relaxed/simple;
	bh=yUvMyXpcN2x5esdqCxDPl7QMMh1lUNBpQTxoxkeP4QI=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=LxIwxeSQgkuP1vnYcESfFqFzthoCPMZK4MgZB6Ntde1czH72ZrKUYgKg+FYLkyhISBGojJ6b3IjyQxsgcdYG3ByUBsdj79KdNzPVlsZ1ThOYvPNkxAlVvinVJSW2ey4PUILA8D4g1wAaP94Iq5A8WkbMmdTxIRtCS8pYCb/NlcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IN9q3qJX; arc=fail smtp.client-ip=40.107.209.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6Q+pglTdJbW2K+FdOBIr8f+83G24Vt/+yhfFygcTQyjg2LbW8luxjP7bPbEl0yeTfVu6rzLsESbLYUsbMftIr4JJFwpDtQ6do4De0qoZfUOR/lhxtyGvBwAOATqrHgVlBxv+TVRuKMExFgQLBSn0cCB4L/WbLExbKa1Vgpav0XpYHzIAW9+DCF/vQzvLQ1FgKB6z4FkWH6M90DtUTbll4GJMil2BIYrmtXoJzet2TX3fm1ddiaXOI2QalxLea1iUuoUm0o3fQyCW3031GHVOVVJjZZJQ2iontJtFrUc2s4rqWbcXVWT4o1pUaWSYC/8lpPeWNy21q4NIJgi3LmVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17YjPB7ZQniQ7bZ1EGKr0LxrPC0r75KCQHI68gn/734=;
 b=hBfPbz4ajVYodRrOOY+fBBMzM4qAt1vtAjnYI26gsRdmOck/H3eiYy1lN+L1UuGM3LYQbUmLlJ0bc04UKqxcNuaxNFHfCk1zOrywwY+6rXkycpqU53UG4v1NkhM411opK8qq6ckrPlhrUdP40yaEnqp4CJ7K/aB73hZo6pKbTbSmKLu1isp8u1csZduOFLJvAaOcxY+f3ZoO4G6Pz50ho6i5UheMnRX7yeisiDt68azgX+XGrIIxEJMbrrC9QBMB23/WG2riDV8OTrB7bXZHZ/alpjqVJ6mWgpC2zYM6RBFRhDtuSQzbd4Q5yjz5H7BnUj+Pxt+lXMT9LVPtLBkLvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17YjPB7ZQniQ7bZ1EGKr0LxrPC0r75KCQHI68gn/734=;
 b=IN9q3qJXfn0mbd9x6BbJR9AJcC+0lzpKuO1mSzWUd1SNgtEcGsJ/zqi0rcBelq7IxBoD7VGBBLiAraUyf+1CapHmTFK0t4dvESFmDO/Q8tHHWyyEdjeWg7khxVCwVEKYljns5z1DlWGsA8G2TrCRsRUY6PTe3DpA34izUUCIJYKGJ7VxYs/p96Et4HmERWkw93hUPMQ2W9Dflux6n8uvRUmYu+htQtjzdE9KEwTDTbQKZcLIQzXDb7Dpohi85iqTn5s/q1VyLVr7twVrG2XlwqePr17ZQZGQsorL+Y2IP5C7u1ZQMX6PlSG3QXspr4LhDPNh2j+7Kab4U9AttrlYNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DS7PR12MB9552.namprd12.prod.outlook.com (2603:10b6:8:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 00:02:47 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Fri, 3 Oct 2025
 00:02:47 +0000
Date: Thu, 2 Oct 2025 21:02:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20251003000244.GA3344797@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="or7qVo33IJNykfMn"
Content-Disposition: inline
X-ClientProxiedBy: BN9P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::33) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DS7PR12MB9552:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f9aec4-cdb9-4c98-3a4e-08de02102f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekZUNHE3SkxsNjJIbUdpUGVVaWg4ak5yNFBwMjN5aGlKNFpRZXk0Mm16RkNl?=
 =?utf-8?B?YXhQMG9YQlNqTXVTVmQ3UnZxa2RGVWUvWS9qVDgwaGZ0RHhEcTU5UWlRTDIr?=
 =?utf-8?B?UlhVbXF1K0VscW92RGJneTRtdEMyd1pjL0k4cm1NS2lGL0hIWmFranJSeElL?=
 =?utf-8?B?K3ZtUVVQMitNOFF0OUl0bys4YXpnWUR6VXUvK0RTNVlWMEVieER3RmhMS0Jo?=
 =?utf-8?B?dm5OMGVZcHh3YkdhZFlxYUtCVmtLT1VmUVZ5aXNlSFMzRTRIUXJqekRjd0Z0?=
 =?utf-8?B?dTUxSXR0UEV0QmlsZTJldGlINEY4VzQrenBJZitQalBtNk9Ma3Nib29uVlIy?=
 =?utf-8?B?UjZmQVRJQ2d0N0Q4dlJuSUMvcExQQVBUQzZPR0s2TURET1IvajFSZDkwUGRV?=
 =?utf-8?B?cVNZV3EyWUNwS3NWdHpqNFdSa0I2S1ZFTCtpL2Y2aEdYc3NhL05ZQlpUMThF?=
 =?utf-8?B?SStVUXVCcS9kWGtGMEZOTlM2VjBFM1ByWlVwRXZXUVZOQncyNXB0TDF6dXhq?=
 =?utf-8?B?Zno3bndESnJpV3RRYUk2WHN6dmYvYUZXazlOUXUzUFlBWFNycHFlWVlIYjRp?=
 =?utf-8?B?eGpsR0swSEs4MGtiNnUwSVV0ZGc5OE9taWpYUytFRE94TzFJUTJHL3BQUjNB?=
 =?utf-8?B?NGhLeS9ZM25sak90UWdUQjdTcFNhaDVJME9uUkpIeUp0bCtwRlUrUnN2U2ZG?=
 =?utf-8?B?RmVseXNJVk9PdCtoSXkxN0ZYZHZKZnF1Wnp6LzkzaHp3MHFqMk9PSmRPSnlO?=
 =?utf-8?B?eWQ2RE43aHhyaXFpMWMzZmdzaGc1Vm1xV2FINzRHc01Yc2tDK3dtcVkzdUl3?=
 =?utf-8?B?UHJUU2hOc2JiR0FQcXpJT2NtaURtNm44eTQ5dDFJa2lhV3lHRGdvVDhIUHBr?=
 =?utf-8?B?OTJKc2xWOUgwUHVCcmN6d3JxVlBCQ1VtZU95RFZkWDZXQjRaYVFEdFd5NXZ1?=
 =?utf-8?B?aFRSUEZjWnM4L1RPUStWOFlqbENwdWNLVmI5Qmg4MElENUdBb1Y1QWRpYzhD?=
 =?utf-8?B?V1M4Uitqd251anlnU1ovYVV0ZjczODlIb3k1UnB5c1BhbldIekRoS21xaUZ2?=
 =?utf-8?B?ZlFDUDl6SElDSVRiUEtZZFUxVkN3RVNORTJIcitwcWxCSUdOL0tWc1JvdkhT?=
 =?utf-8?B?UTFYTzdTMTcxUUJxQ05xYUF3aklmbXlGZzRUS3FZb0doTlkvQWtjOE9hRHdV?=
 =?utf-8?B?cHhMTW0vS1NRMW5ISFRsNU5nVHluUVQyMWd1UGEwUnFTdjB6UGlnZXpwQnFR?=
 =?utf-8?B?b0xjOHE1cUhydFZLTlJaMHFpZjlqK1B4RmhybDRpdnN0MW5LS1VFS3ZmYWdT?=
 =?utf-8?B?WkJ2cnBIdGZKWFVqY3ZUL2tEVU1aT0JOM1h0ejRXWUJ5Mmp6SmJOOVE3QWNV?=
 =?utf-8?B?ajRpMmVOcjVQcThhV2hTamZmbUtvbmpSM1pvWTNHZklxVDY3NFNhc0doMWZI?=
 =?utf-8?B?eVNsaHNTSDZYNFBvb00xakNBQUxUSkEzQ0QwL1o0T2Jna3ZWZlliRGl1SWhj?=
 =?utf-8?B?RlZhNG5NRDVSSSs4dTBxYUJqekJYdTNaWHZVNUxobTlab2xtS2hWbkdxTXQx?=
 =?utf-8?B?WjNpaWNjZzJxZUpuOCtWRGxFMTBKTzd5V1pKNXdYa0VQRkM1N25ucTRaV0I5?=
 =?utf-8?B?bFZTNlVUMGpRaVlXcjY0VGhUUHpvRCtFN3FGRjBZdTgxNG9jVlJJRVF2Ymtz?=
 =?utf-8?B?T0dEQVpGblFTTC96NWJORGtyMnpKNjMxY1JjaG0yOW9tNFUyWThwbUJydHhS?=
 =?utf-8?B?a1U2U2toeERqRENsK01yT3lFb091NXlwdldKQTJ4MTRBU2lFUDdvQXpHKzZU?=
 =?utf-8?B?dkdsZllvRXdBWjZUVXcrNmViR041TTIyazhOaGMxbTZMZkJoSlVDTHhWOE5F?=
 =?utf-8?B?ajBQNmc2enc0RkNLYldUd2VyWVpRb2xDMHFKMTFiaThhNllEMGlnTHpzTDVP?=
 =?utf-8?B?K1lIc3J1MkppZldHdjdncnR4aTVwVVhBK3FsNGhneWdMRS9wNEY0MHFGRjZh?=
 =?utf-8?B?MkJpcWVxenpBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXlWVzZIRTI1NmVQRUdDdGFaMHJXQWw1U0pFSHJEdkNJZnU0L2p2dzgvaUVV?=
 =?utf-8?B?VlNISWtJYU9XS1FIRkxjUHpSWjlQVXFlOTg1NmtoUDI3eWpSZ0RaK3paT0Ft?=
 =?utf-8?B?VGdJRTBXVVB0R3U1TFNDWmxEYWVlUmh0NktoUTZpMHI1Z3prd3NaNVVRV1FJ?=
 =?utf-8?B?QmQvZ0lWWFdhQ0FOSUpFTHZORDFrZy96cU5TN0JNbTVnRWlaUlNlRURPS0Iw?=
 =?utf-8?B?VkpWemFqSVY2TUlvcWMxWThEMHR3S3RuSFN5djhybjZhZTVqQWg4WjVBNEY3?=
 =?utf-8?B?S2EzbGJuZmJQQTNWN2NubVpFL1ZZQXdoVVNHb2l3aFp4U3VJbVlwZ2JNUXBF?=
 =?utf-8?B?Y3hUcHhyOE84YVFFNTZNUmZ1N2tKL2JMUER5b0lUcFBNajBwRDB6TmNyZm1U?=
 =?utf-8?B?MENRZVo3ZFZFbTVqN2x5TkJoTVlaRHM3K2ZQQld5SU9BTmlNdG04WktEeFZT?=
 =?utf-8?B?TDFtUWNxSjdCSUFUa0h6Vzk5bGNSQWlpWGp0TktISXRLcjM2YlVZTCtJNmM0?=
 =?utf-8?B?eVhmU2tZRE03aTJqRTU0eC96REtwM2FjWXBXU01tVk5qYThRbjNKVmQxNEZF?=
 =?utf-8?B?azRsdWNkUmhLU0lWL1QyWE9MdHpiSFpQVk9QaXB1NnRiWjJVYS9kUEVZOXo4?=
 =?utf-8?B?L0dybXJUUEFERTl4UFZpS1RjTFc2cnRob3VsMTBrczlZS2hHbDlTU0FVNGdl?=
 =?utf-8?B?NC9HTm9WU2lMOWF5dXlnMVZWQ2llRjJRblRoT0ZiUXFyK3J5aCsxR3hYYkRF?=
 =?utf-8?B?VnVERmZFTFh1T0o5QjBtNW9aTEN6Sm90bWx2L2RuNmJ1Q3Bxc3h6bGhHUXN1?=
 =?utf-8?B?SStjd3ZscXdUQXhRU0JpS0tmODRwenBhemR2M1EvV29rV2NxNUNzeGtUdDBF?=
 =?utf-8?B?aUdZYzIvL3JCOGkyWVBQSE1GS3RsTnEvK0s3WlIzakIrVGtteUE0UnRJY0Yw?=
 =?utf-8?B?WHJxcmk0V3VEckhVK0M4M0NpRVkxSDc2ODFEa042WjRTbDduRno3TkpuQk0v?=
 =?utf-8?B?VkZNYkpYYjQ0SThKYlR5djVpbXVZRk1wNGkzRStyUExPVXNqR0szQXlBNkJM?=
 =?utf-8?B?L3ZZcGRvVDFVaVJVUkUwU2NDNmQyWU1kZ3Zwc21UcERzNy81Z01YdWU3Z3Ru?=
 =?utf-8?B?eHkybDlGbEMzdlNWSmNpb05ERWs0c2x3S041NFNHTVFERnZubkYrOW1yTnpo?=
 =?utf-8?B?RnVrRzgrVTNuV2ZNZm5oYlkxNmYwSzR4MDZPU0FBS29ydDNmbVNpdk91MVFD?=
 =?utf-8?B?Z0FlNGN2aFV0eCtQM29Rci9xV21GSmRuZUh1Zmo4QUpGMEZUUWt5UWRZRTRG?=
 =?utf-8?B?cjdwb1h4TXY4UGtMNzhVZTh1aUZIRUx1ZnhSeWxubWY0UEtUUnVBWjNxTDJp?=
 =?utf-8?B?T1RBeEZScnY3QU1iaVE0Sk9TMmR5bGgzbFNjVWczS3N5cElYWW1xalNsanBi?=
 =?utf-8?B?MWVQNUpUdFR6U2lNbXQrbFk3YmFHejhtcUxUbENKYU03c3lRZ1Q3RGhHWUlR?=
 =?utf-8?B?OHZhZmU5UGxJWi8vWGtScDBUUERSQW5raThPTS9Bd0U4SS9hVkFRMmN2eTlE?=
 =?utf-8?B?WTNjdXVua1NsNE00a0EzSnlCMlBmTW1kT3RuOE1RRUt0UjVkVFl4L3dqc3l4?=
 =?utf-8?B?NjFvWGY1REFrMGtJTDA2dmZySzJnOHZabnlMTnJCUEgrTE1BSnAzQVVtZHcv?=
 =?utf-8?B?c0cyNzcxU2x4RG5nVnBRSGFFUTg4TVJJekM4UVh4MTZGMDZpb0ZVSlZiY3M1?=
 =?utf-8?B?SDJCbFZ1bmI3NjREM1FWTjhNVFg1ay95RHhhKzMyQ2ttYnRHLy9UN01nWC81?=
 =?utf-8?B?WE9tNE5NYXVvbFR6OHRGRU9WcjhOTEFxREduTG1HUVEwM09GQitibTNuWlNy?=
 =?utf-8?B?Rm0vRU81YTJyUTk4aVcyaE9naHo1OThTUGxsV3pJa0p6dnVtVFlCQ2lTQU0y?=
 =?utf-8?B?cjBYY2I3Y3o2enVmakxnb3pqVXBGS0NvTjNuek0wcHJUb1BKVElzaW00UkRQ?=
 =?utf-8?B?Z2tKRFJLUkV6aFFrZndyZnRvZVloUUttczVjVVZ2bFBjRUJyc21scEowRVFS?=
 =?utf-8?B?YWdHbGIrdEJvelpDc0ppbFdKVk1Da3JTdFA1ZG9KTit5NUpaZEIzcWtaem8v?=
 =?utf-8?Q?1Yoo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f9aec4-cdb9-4c98-3a4e-08de02102f32
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 00:02:47.0531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohcadDq7PW97XXXSoIlP3sPGcHKEnmB15BYt1zfFNIslC+iFeryenZJCb2g/4FLM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9552

--or7qVo33IJNykfMn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Much larger pull request this time. We got a new Pensando ionic
driver, a new Gen 3 HW support for Intel irdma, and lots of small
bnxt_re improvements. Plus the usual little driver fixes all over.

There are two or three more new drivers on the list so I expect a few
more larger merge windows going forward.

The merge conflict is resolved as Stephen did:
 https://lore.kernel.org/r/20250911122330.14834c0a@canb.auug.org.au

Keep bnxt_re_free_gid_ctx() and move it ahead of
bnxt_re_get_stats_ctx(), bnxt added their new functions to the same
spot in the rc and next branches.

The tag for-linus-merged with my merge resolution to v6.17 is also
available to pull.

Thanks,
Jason

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to e6d736bd08902ba53460df1b62ee4218bbd17d9b:

  RDMA/ionic: Fix memory leak of admin q_wr (2025-09-26 13:12:56 -0300)

----------------------------------------------------------------
RDMA v6.18 merge window pull request

A new Pensando ionic driver, a new Gen 3 HW support for Intel irdma,
and lots of small bnxt_re improvements.

- Small bug fixes and improves to hfi1, efa, mlx5, erdma, rdmarvt, siw

- Allow userspace access to IB service records through the rdmacm

- Optimize dma mapping for erdma

- Fix shutdown of the GSI QP in mana

- Support relaxed ordering MR and fix a corruption bug with mlx5 DMA Data
  Direct

- Many improvement to bnxt_re:
   * Debugging features and counters
   * Improve performance of some commands
   * Change flow_label reporting in completions
   * Mirror vnic
   * RDMA flow support

- New RDMA driver for Pensando Ethernet devices: ionic

- Gen 3 hardware support for the Intel irdma driver

- Fix rdma routing resolution with VRFs

----------------------------------------------------------------
Abhijit Gangurde (17):
      net: ionic: Create an auxiliary device for rdma driver
      net: ionic: Update LIF identity with additional RDMA capabilities
      net: ionic: Export the APIs from net driver to support device commands
      net: ionic: Provide RDMA reset support for the RDMA driver
      net: ionic: Provide interrupt allocation support for the RDMA driver
      net: ionic: Provide doorbell and CMB region information
      RDMA: Add IONIC to rdma_driver_id definition
      RDMA/ionic: Register auxiliary module for ionic ethernet adapter
      RDMA/ionic: Create device queues to support admin operations
      RDMA/ionic: Register device ops for control path
      RDMA/ionic: Register device ops for datapath
      RDMA/ionic: Register device ops for miscellaneous functionality
      RDMA/ionic: Implement device stats ops
      RDMA/ionic: Add Makefile/Kconfig to kernel build environment
      RDMA/ionic: Fix build failure on SPARC due to xchg() operand size
      RDMA/ionic: Use ether_addr_copy instead of memcpy
      RDMA/ionic: Fix memory leak of admin q_wr

Abhishek Mohapatra (1):
      RDMA/bnxt_re: Report udp source port for flow_label in bnxt_re_query_=
qp

Alok Tiwari (2):
      RDMA/bnxt_re: Fix incorrect errno used in function comments
      RDMA/bnxt_re: improve clarity in ALLOC_PAGE handler

Anantha Prabhu (3):
      RDMA/bnxt_re: Update sysfs entries with appropriate data
      RDMA/bnxt_re: Add debugfs info entry for device and resource informat=
ion
      RDMA/bnxt_re: Remove non-statistics counters from hw_counters

Bernard Metzler (1):
      RDMA/siw: Always report immediate post SQ errors

Boshi Yu (1):
      RDMA/erdma: Use dma_map_page to map scatter MTT buffer

Chenna Arnoori (1):
      RDMA/bnxt_re: RoCE Driver Dynamic Debug for HWRM's

Christopher Bednarz (1):
      RDMA/irdma: Discover and set up GEN3 hardware register layout

Damodharam Ammepalli (1):
      RDMA/bnxt_re: Optimize bnxt_qplib_get_dev_attr function

Dan Carpenter (1):
      RDMA/irdma: Fix positive vs negative error codes in irdma_post_send()

Edward Srouji (1):
      RDMA/mlx5: Fix page size bitmap calculation for KSM mode

Faisal Latif (2):
      RDMA/irdma: Add SRQ support
      RDMA/irdma: Add Atomic Operations support

Fushuai Wang (1):
      IB/hfi1: Use for_each_online_cpu() instead of for_each_cpu()

Gui-Dong Han (1):
      RDMA/rxe: Fix race in do_task() when draining

H=C3=A5kon Bugge (1):
      RDMA/cm: Rate limit destroy CM ID timeout error message

Jacob Moroni (1):
      RDMA/irdma: Remove unused struct irdma_cq fields

Kalesh AP (5):
      RDMA/bnxt_re: Delete always true SGID table check
      RDMA/bnxt_re: Enhance a log message when bnxt_re_register_netdev fails
      RDMA/bnxt_re: Refactor hw context memory allocation
      RDMA/bnxt_re: Refactor stats context memory allocation
      RDMA/bnxt_re: Remove unnecessary condition checks

Kashyap Desai (1):
      RDMA/bnxt_re: Show srq_limit in fill_res_srq_entry hook

Konstantin Taranov (1):
      RDMA/mana_ib: Drain send wrs of GSI QP

Krzysztof Czurylo (2):
      RDMA/irdma: Add GEN3 CQP support with deferred completions
      RDMA/irdma: Add GEN3 HW statistics support

Leon Romanovsky (1):
      RDMA: Use %pe format specifier for error pointers

Mark Zhang (5):
      RDMA/sa_query: Add RMPP support for SA queries
      RDMA/sa_query: Support IB service records resolution
      RDMA/cma: Support IB service record resolution
      RDMA/ucma: Support query resolved service records
      RDMA/ucma: Support write an event into a CM

Michael Margolin (1):
      RDMA/efa: Extend admin timeout error print

Mustafa Ismail (3):
      RDMA/irdma: Refactor GEN2 auxiliary driver
      RDMA/irdma: Add GEN3 core driver support
      RDMA/irdma: Introduce GEN3 vPort driver support

Or Har-Toov (1):
      RDMA/mlx5: Better estimate max_qp_wr to reflect WQE count

Parav Pandit (3):
      RDMA/core: Squash a single user static function
      RDMA/core: Resolve MAC of next-hop device without ARP support
      RDMA/core: Use route entry flag to decide on loopback traffic

Patrisious Haddad (1):
      RDMA/mlx5: Fix vport loopback forcing for MPV device

Qianfeng Rong (2):
      RDMA/erdma: Use vcalloc() instead of vzalloc()
      RDMA/rdmavt: Use int type to store negative error codes

Saravanan Vajravel (7):
      bnxt_en: Enhance stats context reservation logic
      RDMA/bnxt_re: Add data structures for RoCE mirror support
      RDMA/bnxt_re: Add support for unique GID
      RDMA/bnxt_re: Add support for mirror vnic
      RDMA/bnxt_re: Add support for flow create/destroy
      RDMA/bnxt_re: Initialize fw with roce_mirror support
      RDMA/bnxt_re: Use firmware provided message timeout value

Shiraz Saleem (7):
      RDMA/mana_ib: Extend modify QP
      RDMA/irdma: Add GEN3 support for AEQ and CEQ
      RDMA/irdma: Add GEN3 virtual QP1 support
      RDMA/irdma: Extend QP context programming for GEN3
      RDMA/irdma: Support 64-byte CQEs and GEN3 CQE opcode decoding
      RDMA/irdma: Restrict Memory Window and CQE Timestamping to GEN3
      RDMA/irdma: Extend CQE Error and Flush Handling for GEN3 Devices

Shravya KN (1):
      RDMA/bnxt_re: Avoid GID level QoS update from the driver

Tatyana Nikolova (1):
      RDMA/irdma: Update Kconfig

Thorsten Blum (1):
      RDMA/bnxt_re: Call strscpy() with correct size argument

Vasuthevan Maheswaran (1):
      RDMA/bnxt_re: RoCE related hardware counters update

Vinoth Kumar Chandra Mohan (1):
      RDMA/irdma: Add support for V2 HMC resource management scheme

Vlad Dumitrescu (2):
      IB/ipoib: Ignore L3 master device
      IB/sa: Fix sa_local_svc_timeout_ms read race

Xichao Zhao (1):
      RDMA/core: fix "truely"->"truly"

Yishai Hadas (1):
      RDMA/mlx5: Enable Data-Direct with Relaxed Ordering

 .../networking/device_drivers/ethernet/index.rst   |    1 +
 .../device_drivers/ethernet/pensando/ionic.rst     |   10 +
 .../ethernet/pensando/ionic_rdma.rst               |   52 +
 MAINTAINERS                                        |    9 +
 drivers/infiniband/Kconfig                         |    1 +
 drivers/infiniband/core/addr.c                     |   83 +-
 drivers/infiniband/core/agent.c                    |    3 +-
 drivers/infiniband/core/cm.c                       |    4 +-
 drivers/infiniband/core/cma.c                      |  136 +-
 drivers/infiniband/core/cma_priv.h                 |    4 +-
 drivers/infiniband/core/device.c                   |    2 +-
 drivers/infiniband/core/sa_query.c                 |  283 ++-
 drivers/infiniband/core/ucma.c                     |  120 +-
 drivers/infiniband/hw/Makefile                     |    1 +
 drivers/infiniband/hw/bnxt_re/bnxt_re.h            |   19 +-
 drivers/infiniband/hw/bnxt_re/debugfs.c            |   37 +
 drivers/infiniband/hw/bnxt_re/hw_counters.c        |  109 +-
 drivers/infiniband/hw/bnxt_re/hw_counters.h        |   26 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |  156 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h           |   10 +
 drivers/infiniband/hw/bnxt_re/main.c               |  378 +--
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |   13 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h           |    2 +
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |   10 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h         |    1 +
 drivers/infiniband/hw/bnxt_re/qplib_res.c          |   38 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h          |   21 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |   98 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h           |    6 +-
 drivers/infiniband/hw/bnxt_re/roce_hsi.h           |   44 +-
 drivers/infiniband/hw/cxgb4/device.c               |    5 +-
 drivers/infiniband/hw/efa/efa_com.c                |   18 +-
 drivers/infiniband/hw/efa/efa_verbs.c              |    6 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c          |  110 +-
 drivers/infiniband/hw/erdma/erdma_verbs.h          |    4 +-
 drivers/infiniband/hw/hfi1/device.c                |    4 +-
 drivers/infiniband/hw/hfi1/sdma.c                  |    2 +-
 drivers/infiniband/hw/hfi1/user_sdma.c             |    4 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c            |    8 +-
 drivers/infiniband/hw/ionic/Kconfig                |   15 +
 drivers/infiniband/hw/ionic/Makefile               |    9 +
 drivers/infiniband/hw/ionic/ionic_admin.c          | 1229 +++++++++
 drivers/infiniband/hw/ionic/ionic_controlpath.c    | 2679 ++++++++++++++++=
++++
 drivers/infiniband/hw/ionic/ionic_datapath.c       | 1399 ++++++++++
 drivers/infiniband/hw/ionic/ionic_fw.h             | 1029 ++++++++
 drivers/infiniband/hw/ionic/ionic_hw_stats.c       |  484 ++++
 drivers/infiniband/hw/ionic/ionic_ibdev.c          |  440 ++++
 drivers/infiniband/hw/ionic/ionic_ibdev.h          |  517 ++++
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c        |  111 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h        |   66 +
 drivers/infiniband/hw/ionic/ionic_pgtbl.c          |  143 ++
 drivers/infiniband/hw/ionic/ionic_queue.c          |   52 +
 drivers/infiniband/hw/ionic/ionic_queue.h          |  234 ++
 drivers/infiniband/hw/ionic/ionic_res.h            |  154 ++
 drivers/infiniband/hw/irdma/Kconfig                |    7 +-
 drivers/infiniband/hw/irdma/Makefile               |    4 +
 drivers/infiniband/hw/irdma/ctrl.c                 | 1468 ++++++++++-
 drivers/infiniband/hw/irdma/defs.h                 |  264 +-
 drivers/infiniband/hw/irdma/hmc.c                  |   18 +-
 drivers/infiniband/hw/irdma/hmc.h                  |   19 +-
 drivers/infiniband/hw/irdma/hw.c                   |  363 +--
 drivers/infiniband/hw/irdma/i40iw_hw.c             |    2 +
 drivers/infiniband/hw/irdma/i40iw_hw.h             |    2 +
 drivers/infiniband/hw/irdma/i40iw_if.c             |    3 +
 drivers/infiniband/hw/irdma/icrdma_hw.c            |    3 +
 drivers/infiniband/hw/irdma/icrdma_hw.h            |    5 +-
 drivers/infiniband/hw/irdma/icrdma_if.c            |  343 +++
 drivers/infiniband/hw/irdma/ig3rdma_hw.c           |  170 ++
 drivers/infiniband/hw/irdma/ig3rdma_hw.h           |   32 +
 drivers/infiniband/hw/irdma/ig3rdma_if.c           |  232 ++
 drivers/infiniband/hw/irdma/irdma.h                |   22 +-
 drivers/infiniband/hw/irdma/main.c                 |  371 +--
 drivers/infiniband/hw/irdma/main.h                 |   35 +-
 drivers/infiniband/hw/irdma/pble.c                 |   20 +-
 drivers/infiniband/hw/irdma/protos.h               |    1 +
 drivers/infiniband/hw/irdma/puda.h                 |    4 +-
 drivers/infiniband/hw/irdma/type.h                 |  221 +-
 drivers/infiniband/hw/irdma/uda_d.h                |    5 +-
 drivers/infiniband/hw/irdma/uk.c                   |  303 ++-
 drivers/infiniband/hw/irdma/user.h                 |  267 +-
 drivers/infiniband/hw/irdma/utils.c                |  112 +-
 drivers/infiniband/hw/irdma/verbs.c                |  834 +++++-
 drivers/infiniband/hw/irdma/verbs.h                |   50 +-
 drivers/infiniband/hw/irdma/virtchnl.c             |  618 +++++
 drivers/infiniband/hw/irdma/virtchnl.h             |  176 ++
 drivers/infiniband/hw/mana/cq.c                    |   26 +
 drivers/infiniband/hw/mana/device.c                |    3 +
 drivers/infiniband/hw/mana/main.c                  |    5 +-
 drivers/infiniband/hw/mana/mana_ib.h               |   14 +-
 drivers/infiniband/hw/mana/mr.c                    |    6 +-
 drivers/infiniband/hw/mana/qp.c                    |    9 +
 drivers/infiniband/hw/mlx4/mad.c                   |    8 +-
 drivers/infiniband/hw/mlx4/qp.c                    |    3 +-
 drivers/infiniband/hw/mlx5/data_direct.c           |    2 +-
 drivers/infiniband/hw/mlx5/gsi.c                   |   15 +-
 drivers/infiniband/hw/mlx5/main.c                  |  113 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |    7 +
 drivers/infiniband/hw/mlx5/mr.c                    |   11 +-
 drivers/infiniband/hw/mlx5/umr.c                   |    6 +-
 drivers/infiniband/sw/rdmavt/qp.c                  |   13 +-
 drivers/infiniband/sw/rxe/rxe_task.c               |    8 +-
 drivers/infiniband/sw/siw/siw_verbs.c              |   25 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |   21 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |   16 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |    8 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |    3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |    6 +
 drivers/net/ethernet/pensando/Kconfig              |    1 +
 drivers/net/ethernet/pensando/ionic/Makefile       |    2 +-
 drivers/net/ethernet/pensando/ionic/ionic.h        |    7 -
 drivers/net/ethernet/pensando/ionic/ionic_api.h    |  131 +
 drivers/net/ethernet/pensando/ionic/ionic_aux.c    |  102 +
 drivers/net/ethernet/pensando/ionic/ionic_aux.h    |   10 +
 .../net/ethernet/pensando/ionic/ionic_bus_pci.c    |    7 +
 drivers/net/ethernet/pensando/ionic/ionic_dev.c    |  270 +-
 drivers/net/ethernet/pensando/ionic/ionic_dev.h    |   28 +-
 drivers/net/ethernet/pensando/ionic/ionic_if.h     |  118 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |   47 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.h    |    3 +
 drivers/net/ethernet/pensando/ionic/ionic_main.c   |    4 +-
 include/rdma/ib_mad.h                              |    1 +
 include/rdma/ib_sa.h                               |   37 +
 include/rdma/rdma_cm.h                             |   21 +-
 include/uapi/rdma/ib_user_ioctl_verbs.h            |    1 +
 include/uapi/rdma/ib_user_sa.h                     |   14 +
 include/uapi/rdma/ionic-abi.h                      |  115 +
 include/uapi/rdma/irdma-abi.h                      |   16 +-
 include/uapi/rdma/rdma_user_cm.h                   |   42 +-
 128 files changed, 16190 insertions(+), 1488 deletions(-)
(diffstat from tag for-linus-merged)

--or7qVo33IJNykfMn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCaN8SowAKCRCFwuHvBreF
YW2nAQC2/N9J5IssG5SlzzHCdgiOnb+uHRyu6dAzvZUtuYkx8AD/QZPCMfNLQF4f
aStaWgbUZmnrkRkvkXFBqfWStBJJMgg=
=DFr0
-----END PGP SIGNATURE-----

--or7qVo33IJNykfMn--

