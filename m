Return-Path: <linux-rdma+bounces-3619-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B949246F4
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jul 2024 20:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0231C24CD1
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jul 2024 18:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82CE1C2310;
	Tue,  2 Jul 2024 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="QFodUNUs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2135.outbound.protection.outlook.com [40.107.102.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3841C0075
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jul 2024 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719943503; cv=fail; b=tjWOqFZVsRBz+2+WuMO8JRc2GQoheStSgt0PyeD7YlarBzAz82bqdAH2OJaBcomOClGAKV/J7kN1wb1sXikErxdEdMGgpWVKtqAX52+Cf7Zxop5U7s8lKN2jc5OohTD3TojuO/sdEWO1GqTqcjqv5sF7YjoXgw4+xeC/1TBlFuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719943503; c=relaxed/simple;
	bh=1YPRX/vXAJFvp8qqYMeDJ4xXU3rtNzoEqf5M5TU4LZY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sEU9+GbDA4B/kUjI8EAt/hRyoO2gKVO1/DDPrUhE61LjJYe/4YnSB3VVj6bB7ABDrMh2aSazzyfp1YekdntChI/ohy1rASyYCzQgthy8u+Scru3G3mg24d6ElsBot18U99jVNyhe2IfnCnjsKWhEGvOmYZHjMaHmOPN0qnwzaTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=QFodUNUs; arc=fail smtp.client-ip=40.107.102.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOa6R3JSMFEsXUaOQjenLBEOuymRl1XRVZFQU/2/6UU+qlTNxJX7EUjwBlRrv/OFA0t8+QGtz3r5lOJDnwjGDek65H6hFBd6pyHntoS5oOFbFzaWKPR03OlKXWIRCxaPcvtIRD2OL9rfRJQ6oe82FlOSchwFlXTItjPIk5wI1iJ6YX+tkEtZc7Bfw0Sspr5ff9uej6TsHSgdUktSnYtftT/z1E/RPwbxM4GLm1Q2L15BBoCUdmOnTKF5jtAmZLM525pdSeVouV7p3Y3G94mHpkj59WRCvZeGat8WbS7TQJkeBSvklwGRzn6xqx/l4dnBFJwcgHuZuZoyRuWs7iQZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecYoeZC2wvfiOBKlnJ19JOwZKMMYLmy5YS/3cv2fEq0=;
 b=eHGLlecgtwuUzP48YkdUJGuio5zQv3KpfTHeR/4gWHVL6DlvtFlWBnA3dG5gDh+hKSSSw/8a1XGz29ScjJEchMyLK3SBVxw71DoT1epoSib1mzg0R4/cw+ZW3O03BejiNzaUklF/gcBh8wWeWKrlsp5MG8ryoclvEEQX4gGWk/yhPTT2jIdP+TkrbMQAclQAN9WGUCPk6SoDmx3TclsQCkveddhf/PLK426l3y/tiYHTYDLkKD5qNHz2OoSrpTp3XDR9An0tlw/hzG22N8ed6W9Aewq21BWU5lghZTwDrT6KWM9LroW+ybwZ7IhA4OYmwB/rZKlKvNBLEo5WCp+NdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecYoeZC2wvfiOBKlnJ19JOwZKMMYLmy5YS/3cv2fEq0=;
 b=QFodUNUsHq/o5uLiuiZIj8kx/LRzdwJJdOBVAUqrmPD0/lVJirwIHS50zcZclc3EGSO8ZWyIy9JK1uUiBzkxjbo/zDDY9A3c3Jm6rLKHQZOkLpC3/9Hzj4lKQehgN6QvtG++M5aSRZIfwk6ADpdg4MJ50ikprSwrTRvZ5z6eQ8GxpcCZfzzDEfwdLYtefQ1Zb4FutRWpO3gMGzT1YDVPLZWdtAavhsljpL3tfvK46DGaucLjvKDb8gFUxR7c5asN4va6a/ksRmGLeQZYC9cu0/dUGdbdW4fMnhEP19wxniPV84MFYXbHYxDhg3IhR5WqMKRJg7MoFFl1ujF4haCSdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SJ0PR01MB6158.prod.exchangelabs.com (2603:10b6:a03:2a0::15) by
 SN4PR01MB7519.prod.exchangelabs.com (2603:10b6:806:206::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.33; Tue, 2 Jul 2024 18:04:59 +0000
Received: from SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b]) by SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b%6]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 18:04:58 +0000
Message-ID: <aab722f3-f121-426d-bdd6-1fbf76d3ee79@cornelisnetworks.com>
Date: Tue, 2 Jul 2024 14:04:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next 2/2] RDMA/qib: Fix truncation compilation
 warnings in qib_verbs.c
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
References: <ab5222c414a01e9d2c5129ef26836aace9ee2aa5.1719837715.git.leon@kernel.org>
 <1fb6393fa2e0702fef995834c3c7db972bbc4d06.1719837715.git.leon@kernel.org>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <1fb6393fa2e0702fef995834c3c7db972bbc4d06.1719837715.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0006.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::19) To SJ0PR01MB6158.prod.exchangelabs.com
 (2603:10b6:a03:2a0::15)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6158:EE_|SN4PR01MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a923c79-f0b0-4371-22c3-08dc9ac17c79
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVlEOStGSTh4ei9zTDBLQzhsWUxvZUFzb2lVMHZsRVZJNi9Cc3Y5aG1HTm55?=
 =?utf-8?B?dVlMaEtGQytoR2VDaTVJeEY3ZDE2bFczaVJDVkk1ZTZqWkw1aEw2bWVaOU9n?=
 =?utf-8?B?NFJEQ1NlcTc3a1FodnRsUk03S2hEUmNDdEJZV3JRSzZJOXdvb2pSUTYyYVdx?=
 =?utf-8?B?Z3BwaFBGQjRTR0VsUmVsaElBNXZkMENDNGZxTHlldU45UVIya0NQQlVVaVVE?=
 =?utf-8?B?OXh6Nzc2QUNXaCtobG5SRzdGek5OMlhIdllCdUIycnMrNm9ubm14QTFybmZv?=
 =?utf-8?B?T2lWeHNRcnIzbUtnWENYRjh2TFlhdzRlL2xEMmRjSnFFbnpuU1dFMkFaOVhj?=
 =?utf-8?B?eE5mc0c0TEpaZFFRbGp5bkxJZ2FDa3hyVSt4Yi8zSzZTU3F2L1B1dWptcDAr?=
 =?utf-8?B?N1Erc0JvbUZTNlljZHZDSzZBOTVoS1VLWXhkWUtjM1dYQzVWZm83SkU2Zlhs?=
 =?utf-8?B?MDN0NFBXZUhlRFMyd0k3RFZHY0R3cjY4VFVPeG1xRFRZUjVFUFF2Y1NPRVZz?=
 =?utf-8?B?WjVISnhjTFlIY3dWRzlhR0xjbTE1OEdkL0E5YkwyVTVWK3ZiQk92Y0ZIUE5y?=
 =?utf-8?B?Q09iNXN6N3JobjhBS1l5SlB5YWR5MW9ZY050QkcvL01kRnhubjE1OXpFWDM0?=
 =?utf-8?B?S3Q2T1Z3V3VLNWM4aTE5UDB6cWpDckNMdTd4eVgxbE52S09nOEFEUFRpVVBh?=
 =?utf-8?B?TVRGa0JHZUhUazdUM3pLRklQTUxMR0xTWURXMDdRQWwrWWxtcHFva3hJN09H?=
 =?utf-8?B?TmNyVW0rcHhiZjlRUXBsQmw3N0VCZDhjcnRJaFVZRzYzNDV4ZStER2xFc2Vl?=
 =?utf-8?B?eEMrb0Y3TExkUWZuZkowYTRhSE1WTHZMK2dQNGU5Zmppb2VIUjJjd1NJRGFk?=
 =?utf-8?B?czNwNkJyZkQrclJlWEZIWTNYSEdQNEI2WHE3MVR4WFhvaHBsV29HL3ArQmtF?=
 =?utf-8?B?YzVxSmlWV3FueU1iR21Gd0lkbVNSU0NkTy82UnhvcllHTktDQWZUYW0rTmxS?=
 =?utf-8?B?cUxEaS9seVZQNHlJdlk2bFZGSUttQXdqcVRMRFVLRlFydy9oaTVtaHQ0VmVi?=
 =?utf-8?B?YlQyUEpIL3pyN0ttQy9DcDVLMXE1aXB4emhtQUJ6bGRJZFVrTnZETnVxYlN6?=
 =?utf-8?B?SmZaWlMrMkFPS1hVaVdCczJjMCtjRWdUREFwM1BtVzluUFJhSlVIN1hUZC9J?=
 =?utf-8?B?SXlxRGk5OGt5Vm9rbFdENENWdlo0YWV3YkxtVVY2YjNMajNvekZ1NGlINStQ?=
 =?utf-8?B?ZWI5dzVkVmNZQjE4NVhXN09UQm9MdlZrK0UxK3BraU5rV0plSHRaMzRJMDFO?=
 =?utf-8?B?MHNBV1FFcU1rSFhZaVhWeXEzUU16b2Y3QkFIYnZIMEtHRUJDdXBiT3l6c2Zv?=
 =?utf-8?B?REFEY24vb2ozYmZpdWs3VDNuVUxNQUVKMEJGeUpIaDMvNy9zSzdsWjNJRURC?=
 =?utf-8?B?MFZzL0NsdmFMM0tHWmR5LzErMzlCSmNlY2Zaemtia0VKUjVDd2tORTczb2Ni?=
 =?utf-8?B?ditzMHUwOExITkdiV0FhekdubDFISU85QnFjVWJRZ05FeC9sYmFqWHI2YkNx?=
 =?utf-8?B?SVVwM1U5NzFyRC9tYUdTWmhBMmJhdjR2d1RzMENCTHN0b2haV1d0ZWVLSWRw?=
 =?utf-8?B?WTVvT0dSMlJoQXdvVHRjY1RBY3dESE9RVXJrMkx6ZjN3aVhqL0NMSFNzNmFX?=
 =?utf-8?B?MmxnbVhFU1VIY2V4Mys4a01Wbis4KzIzWHZieHBvSmxucGVOY2pkNjBMbHZk?=
 =?utf-8?B?Wk5JNTFTcWZhbk1pSFZVcGZNQy9EWVFzdnB0WFYwbEFONEFlYXVHWTIvb3BH?=
 =?utf-8?B?VGMyb1NKWmFNd2hPMlZnQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6158.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2JKT0ViRFlwU25GYzdOZjZUNXZaNklIZzVzL2lob1B6cDBCTmlJWVdkYXhr?=
 =?utf-8?B?VXhjVVZadjllYm5CTXBLMXUxaXhHQzBSSEdKMDgvUG9mZTdON0VCSlNybzFy?=
 =?utf-8?B?bVR6RXhrQkwrZmdueXlkb3o3ZCtNUTc4VHh2U2gvUS9hUC9sQ0g2Qzd0OHFY?=
 =?utf-8?B?WkhseFRta21tZHp6T052SnliNzU3WS9iYVRqN3NZTnp5Vyt5NnRIYkhveGRU?=
 =?utf-8?B?bGF4dzUxRHNHT0dmazdQSmFSOWxucGJuNkNXUXpzdUo1Smh0V1FpQ2ZJd0sy?=
 =?utf-8?B?SEdJMmlSdnV3TG04U202OG5PenBheTNQRGhweG5GeTQrK3pseTZNYkRha1lh?=
 =?utf-8?B?S1JObEtVbnRrdCt6RHJvNlpDZTJ4ZkVwNlJudC9PWFRjTkhaUG5CaXlqSWVB?=
 =?utf-8?B?bE45WW9BSWZ4R0VtQ09BSTlXMThzZkQ1SEM3NkdRL3VqbTg3S29TM1VTclQw?=
 =?utf-8?B?b0JFa0VXcytKV2pzU010djdKOTlXTUlYUjZ3YzVzZ2hlZTdkcXNBcUxuWjdq?=
 =?utf-8?B?bHRvT2F1dkhBSC8vNlJKUHN0NGlVdTI2SmNzRjduaFNmajdzK1hqbVN0WVhx?=
 =?utf-8?B?c2V0M3AxL1NGRDdYNGx4R0dZVk52Y3BwdmNiVm1NdkhOeWpDM3ZyQUMvbTg0?=
 =?utf-8?B?bEZCV213dDBTUWJzc0Q4RjhPTmVBMExPVi9rSGloNlBneTFFM3ZBb0xQU2pO?=
 =?utf-8?B?Q0ZpVmdZZUU3ZmdWckl3b2d0VkNOWVE0d2tGTjFIOUtkTXdrd1ZpQk1iTlha?=
 =?utf-8?B?QU0zdU1LME9TRlRqQUx2ZWJKNzRucFVNblZCWG92dVo3YW1jOEE0QThWRW45?=
 =?utf-8?B?UFF4cThzWDc0SW9ndmtUVVNTNHorN3JwSGNKdE9WRUxlUXUwL0FsbEpHWmJP?=
 =?utf-8?B?UlRWbkk5SW5QOUFpK0dtQjlHcjlOYTFZTUprMVFKazBjWFMzY0lKdGFzOGNy?=
 =?utf-8?B?MHp4ZGVwMWltUnVPTXprd2tGczlqZVBMRlo0RFFWWXNoR09LVzdURkIrODVt?=
 =?utf-8?B?OUVoWWRuUVBxWnFyWnFVMFl1KzVSZHZmRzVhazlqYkNyU3kydTFBTk4yc2Jx?=
 =?utf-8?B?NXpRY29DZWxNdGFZaEwvdENOK3htbFdhRkY3dEkyT1NiWGt3SWpzU2JwRTM2?=
 =?utf-8?B?b1hITjJQSkxFTlNFWVBuR2tUUFZTWDdlOS9ZNkMzbjdEVHBCSm50UzBDNjh1?=
 =?utf-8?B?bUljemNHNDUvcFZJdk15aDM3VVU0aDNEUXIzbUlmZU5MZlh4blBLT0dmQ2Q1?=
 =?utf-8?B?aEZrQUgraUlKeWF3QUc2RGhjeTFMUUV1K2YrNGp4VVEwc3N4dTNIUWNxMXBU?=
 =?utf-8?B?bnJEOFgrR2FtTXQzN29PREZRTVVLaytCeC93VlJZTmhNblpObzFaT1VmNWt0?=
 =?utf-8?B?Qk9NNkNPSW9SVHU2Smw3SXlDSzFzMnFLdnE2Uk9DdmMyQlZTbG5icDhZMDVh?=
 =?utf-8?B?Nm8rb0hoRVFvQ3kwK05aSEs1aDdmODdaUjg3U1FKdFRHalVyQ00zN3BPZVhH?=
 =?utf-8?B?QzVBSThUN2hFanF1aGE3YWdmUUozM3NBNE4xSTNaTGordVNSb2hZSTFPUERC?=
 =?utf-8?B?cXVXRWNzZzZLR2NzL0RyU01nc1QrMUNTNE56eGtOTEMvdm92Y05NY0tFVUN6?=
 =?utf-8?B?alVRcGw2Y05ZNE5VMlA4L2l1bWd5WFpBN1hUNUE4WWZBbTBZQ1l0aDlRSllI?=
 =?utf-8?B?aHlvYmVPYUl2ZkRqUXdmYnZiLzRGRFdqK3F0MGdFS1JDa2syMkRROEllN0RN?=
 =?utf-8?B?YUFIdzZ1aE5WQWdBZDRySy9XUFU1cDBGd2tiRlhPK3p4NXhPdkpRZnVyY1ht?=
 =?utf-8?B?VitPS1hCVlRjN2c0eUZ4WDB6SEFkSnlmc0RQVHJQaE9xUllrRDJqeVpwZjBk?=
 =?utf-8?B?MUt0MU1VYkN5KzJyRlVqbHlJbmdLVUlhcGRYMVBaQWlsMXBRc3hBaXVQWDdG?=
 =?utf-8?B?dWNqZm8xVjYwT0NzTlFBNjA3dWpqMXRUY2w1ZE54T3NNTCt5SmRnVTNCUFda?=
 =?utf-8?B?dXlDejVhVCtYK2RzQVJ6azB2dU44MGxFVjgxWXBURGdXVHhVY3N4ZGkvbzlY?=
 =?utf-8?B?VlFud1o5Q1ljZGRkT1VkMEZ3YmZQZE1wWnVDZS91bUdQeCtNVVRQMEZpT0lz?=
 =?utf-8?B?c1R5c0FKSlIrMVdoK3hCRm5yZjJrR0lNYTVZaG9zMXB5MHNlYm1yQzFhc0V6?=
 =?utf-8?Q?pyG/1EyFDIUT5VkgUC+VxEQ=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a923c79-f0b0-4371-22c3-08dc9ac17c79
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6158.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 18:04:58.8903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQwg2ESu7LZXfSjtMg3WBYWZYDxExkNxZeS92MV94wLDM7IrFZzLe8eogqOFcQBg8mBn/hpHAVjRUrTQhEeSQ95H1EwBHAxGTLQpRHXaOB14BXYPHESGmNn57S2xH35x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7519

On 7/1/24 8:42 AM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Reduce nodename string size to fit IB_DEVICE_NODE_DESC_MAX.
> 
> drivers/infiniband/hw/qib/qib_verbs.c: In function ‘qib_register_ib_device’:
> drivers/infiniband/hw/qib/qib_verbs.c:1554:40: error: ‘%s’ directive output may be truncated writing up to 64 bytes into a region of size 43
> [-Werror=format-truncation=]
>  1554 |                  "Intel Infiniband HCA %s", init_utsname()->nodename);
>       |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/infiniband/hw/qib/qib_verbs.c:1553:9: note: ‘snprintf’ output between 22 and 86 bytes into a destination of size 64
>  1553 |         snprintf(ibdev->node_desc, sizeof(ibdev->node_desc),
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1554 |                  "Intel Infiniband HCA %s", init_utsname()->nodename);
>       |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/qib/qib_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/qib/qib_verbs.c b/drivers/infiniband/hw/qib/qib_verbs.c
> index 0080f0be72fe..5fcb41970ad9 100644
> --- a/drivers/infiniband/hw/qib/qib_verbs.c
> +++ b/drivers/infiniband/hw/qib/qib_verbs.c
> @@ -1551,7 +1551,7 @@ int qib_register_ib_device(struct qib_devdata *dd)
>  	ibdev->dev.parent = &dd->pcidev->dev;
>  
>  	snprintf(ibdev->node_desc, sizeof(ibdev->node_desc),
> -		 "Intel Infiniband HCA %s", init_utsname()->nodename);
> +		 "Intel Infiniband HCA %.42s", init_utsname()->nodename);
>  
>  	/*
>  	 * Fill in rvt info object.

Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

