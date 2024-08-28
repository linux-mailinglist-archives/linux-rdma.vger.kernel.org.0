Return-Path: <linux-rdma+bounces-4616-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549B8962652
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 13:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85CBBB21157
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 11:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E9216D321;
	Wed, 28 Aug 2024 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="Hh0yj6T+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021079.outbound.protection.outlook.com [52.101.57.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1889615B12F;
	Wed, 28 Aug 2024 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724845781; cv=fail; b=Tlz58CoQ8lswVyiMf2udBEorquclqsl03JKUEWucaG2rDASdDn6mnMVEPUaGdk7q9ymvjSo6UKPhIe/4lVzAaLTDE2c/SXCPJFRaAem1yS2YB1L3iFOat/3PkEeT60K5Prn5ApJaDW9E/SkMLCffSWhwe6ZiYdq8LEb2MUtEBGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724845781; c=relaxed/simple;
	bh=qvZFdlHrG8Nz9U6evdjQEfpHoKmZoW48ie7UriIsH+s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U6+MWP5R2+YMtffJq1mQqFxp/34RdpoarPKPPgMrn8iQZiaKeCBJGPlY6frv+3QZOUQANR+zMZVEbnhhquUCWiaSG2wQvHXyqs/EL9eQGgGwSe59AtakvEyEWCp1KbLwIXuNFzxlaUnk92gRBttiIbE5P6gk/KTRHih3+BGLY7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=Hh0yj6T+; arc=fail smtp.client-ip=52.101.57.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gn4kl5WEIvkJaC93GVezZkF9FEVwdM8fziTFVOE5sY07jsXdujq7l+VjzLBs5ExGv8KuTk3FQqih1W21oyRbbr4lKKBs3M5mtDwDAuHdrsibvG3lEioEIXOTSEx6wwvoCUkgZgsu4O9WCEjsEzSeAwP8o41n5V0UE9G1Am8jeef0oZhXoSEtemffWae2g+xTkM9bD70YgNG0K9iljP3LT+C3V5BD19XUUuz/HzIIir34p4zcItHROfxDpSHmz+i8pp3l6lhdIVo0Z16naQ/iNBm4V+7NbRf3gIM2kfex+XanMcIBvdexMD4yVq09aiiI3FFkKCMGnWZZwfYOoQ/5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvZFdlHrG8Nz9U6evdjQEfpHoKmZoW48ie7UriIsH+s=;
 b=fyfTIdCOpZwfPaZQ1Gqi3CzSigLP0002Dh2eisy2txqayTlEj3cyXJ7y+K5ehcecxU5GMZc00iThnf6ShmlyAiy8Jq0O84ulnCyvy7Tm7PzkKy/J9ejOqMsev78aqTtmcPpEFK8cHuneN8eUfxNcq1Wk26PhgLFZhi+KLBif763U4M1gwGE3CzqJZNlbQ3zZP4a2zRxg7h9XMXLv/E7fyuDLZF21de6Iq+pOW49/GBPABx8TMT1MnFB7U/njKnDxo5QvWAQW0/XKRufECc1HOHlnRMHVdAI7RTUuO9PuVx9eUWpoHoHHJv0U8PELr4H8rOJpR9mBmOcp/2TY914SKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvZFdlHrG8Nz9U6evdjQEfpHoKmZoW48ie7UriIsH+s=;
 b=Hh0yj6T+rCasZ2CWSbwRDDkx2z8dvNiUo+3CO+4YirYhewFDPCttmNs6omja8k7/UgCKunh1zRx5nZfZaAXNE94huO5zA/NNFGGBovdxb/n3v7XOChy5HP8w51IzLxyL/+iGEiyO+ZKbUY1+a2RQWiw5xLqOczsDyomso2fJaJFG25rO5rnsdlp0PPHjRes2OhQ5SxK7ccTueIeb9V1Tx/rOaJBXmQ94LpNP26QhagIW0Q3wQe4UuVTeGEAPZ3Y0ITHP4QWyBM9NFc0FVDly62fhdoxVA2YvFRJ2SaHuQrVgBYl5AKrsr1niMcP56PI/P0h0fZWKzzvTjbueirj/GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 IA3PR01MB8694.prod.exchangelabs.com (2603:10b6:208:537::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.26; Wed, 28 Aug 2024 11:49:36 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 11:49:35 +0000
Message-ID: <0f6e27d3-8942-492e-86e8-730c00a5aa37@cornelisnetworks.com>
Date: Wed, 28 Aug 2024 06:49:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Using RPMSG to communicate between host and guest drivers
To: Jason Gunthorpe <jgg@ziepe.ca>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: linux-remoteproc@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 OFED mailing list <linux-rdma@vger.kernel.org>
References: <133c1301-dd19-4cce-82dc-3e8ee145c594@cornelisnetworks.com>
 <842aef7f-d6e1-490a-97b9-163287ddfe2d@cornelisnetworks.com>
 <20240826234530.GK3468552@ziepe.ca>
Content-Language: en-US
From: Doug Miller <doug.miller@cornelisnetworks.com>
In-Reply-To: <20240826234530.GK3468552@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CP5P284CA0236.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:22e::6) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|IA3PR01MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d169d75-1d6e-4107-fdf0-08dcc7577cf9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTVLRjZQbi9ick9LNWJPcTVjcEd6ZzhoN2NNQ0JKWmlOemVpWEJlUkZwMHEy?=
 =?utf-8?B?NVhadGdrbmR0cUFWZ1VKS2gxdEUxUWd2UnZYSkZEMkZZZ2pmTi9PWUhoalQv?=
 =?utf-8?B?K1VBKzVuZ1E2UXFSMmVBb08vMG93cEdUSnR5b0VDMy9UbUJFSTJzc05ucUd5?=
 =?utf-8?B?YllOL1FLU3BqSUdkRkpmMXpDR0E0UlM1OVBPYXFFVnpZTHRyMlR5L1ZWOFZz?=
 =?utf-8?B?Y3B5NGNDZzF1aXFaRWNEbklQaCtFY0NHR1dJMWhhNmlMK20rT1RDTy9kYVlh?=
 =?utf-8?B?dThQcm1HNlJ5Vy9RcGFYR2YwUlBOR3VWMUpKRCtITnhHUTFTS0N0NFZMdzFz?=
 =?utf-8?B?RFFTZDl4SjI4R3hMdHpGOElEZE44M3kyTGVNbis4ZjEwT3VFMzhYL2VzcmIv?=
 =?utf-8?B?UDc0SFZDRVVNL0ZLNGxBMjdDRERFVDAzTTVxRlNqQ2MyS1IweWM2a0d2YnYw?=
 =?utf-8?B?Q2xRTEk4RGdTRlV2U2ZOVTZPSlFYRGo0cjZHbTRwUWlnbWFra0RFYWJsSVI5?=
 =?utf-8?B?UHRnZ0dqOXl4SXZmVmwvRjExUUFhdlMyTW91dW5DRncvNHk1MzBaQkJhU1dx?=
 =?utf-8?B?Zzk0L1BVbzlKQ1B2S003Rkxia1I3Uk90YVIxVTVkNTBIazZRTzMyaC83WlV3?=
 =?utf-8?B?ZjdlYmwxQ3MyZmxrYnlTQ3lwN3FTSFlGUERldlA5NUVPdno4MGNiQVp6ZzRn?=
 =?utf-8?B?bGcyZ0hlMUg3NjZiRzF4cnZuR2FncTBvT2lGbmJHZzNlRzJ4WWR1bDRTc3c5?=
 =?utf-8?B?aDdmRlRhRStzZTMzUkFRNmZtWVVGS01yc1Q5NjU4ZFZPdkx6ZmNVVlMwa2Nk?=
 =?utf-8?B?MzNQWGQzbzhpNHUwQ0Nsa29rSitXMkRJL1B0VC9FWVMzQklxR3dIUFE3Q1Rx?=
 =?utf-8?B?dnZWSHlJT3QrZmFZeFN6WmYrRmhjTlFmTzVyNEM4bWUwdjhpZTlLY1o5Zi83?=
 =?utf-8?B?a1ZIRDljbElaaTJqMmc0ZmltRHNWeC9VRlY3alh4YjZWSjloajhCSTIzY25H?=
 =?utf-8?B?amx2UUFnSnRGSWNsZjFRc1NkZ1BPbkd0MjhGWDlIVlF6NldqZkdhTjYya0hF?=
 =?utf-8?B?WUExWEN4NkZjZ1dIUEZkL1liOVRaeURPV0NadUc1MWxlTjJyOThtRFQ0eUsx?=
 =?utf-8?B?YlZibUNnaHFSK3RBeHlWQXVLcEhjaXVwSkpWSDNQU0FkWVkyNWxBQzdrSkJK?=
 =?utf-8?B?S3J2cWl1dEVpVXV6RklnbVdQMG5vNUpNNkl0bDlROHcvWnBqdC96L05zLzhr?=
 =?utf-8?B?amYrREZxRzkxRWU2Zm14a3RIWmc0R2h5ZDUzWUlQRkR3VWpTYUh2anB3Y3Rq?=
 =?utf-8?B?MmYvdGU4alFqZkJlNTNVTVg0TmFENUZSQlMvOVFsUVBJeVRkenpNNEJCRHRS?=
 =?utf-8?B?bWt2ckFaTjNKQzZEbFJTeTNEbkZlMk9ZV2Y5TTNqcDF1bk4vbGw3YldFTU1m?=
 =?utf-8?B?cDlZVDNwa00ya2luL3NWRS9RbEdpQjJrMk9tYlYxSndWS1R2MzllQWRKTjBx?=
 =?utf-8?B?ZWUvT3VuTDF0TmdYMnFzOWhmTkVFSUFWNzVnOWJiZmVwM1ZhOCtNM0J4MnZ6?=
 =?utf-8?B?dFdXMHFWTndJUVE1eVgwZjNMbEdMTVc3QkZubmxEMk5KUCtCdHNoaWtWNkhl?=
 =?utf-8?B?T2ZYRjVFUjZ5YjRXM0d6cGZTTTRHRnF4R3RQbFFId00xUFJ5UGs5TjEzUk5Q?=
 =?utf-8?B?eE1wRExwMEd0QnVab0ZGMjF4U0QyZXVUaEFNTzhJSXU2MnVMbExLRWhtMlNw?=
 =?utf-8?B?cEsvMFF5WU5veW45c0tQU3NRMW43bmxUZHdFUHM3ZGFtdXgrcG5VcHg5QTZ2?=
 =?utf-8?B?TnF0b3pNbFFiWngwaG1RUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anIwQWwvc25QdE1acitvZWRRby9XSDNWNS9BLzNMOS8zdzhDOE5lcitkR0pj?=
 =?utf-8?B?djdLemFaeVZJTzVWbTZnTGJHb3JxeWl6RlFMbHFCYkRFSUpMOUZGN1lqbHlt?=
 =?utf-8?B?UWFzRzRZdzF4bnk2MmpEOE01WnV5RTdTZ1hVSVV2dGhBOFkxQ01iM0pvVWhJ?=
 =?utf-8?B?bGxLQkkySEFHQlRSNzhJZHVmYUpnbU8wbDBUa0xaOHpJUlhBYmpMeVZZdDNt?=
 =?utf-8?B?Rmp6YllPcFVTY2ZOVXN6UUNnQWN4bmgwWlRPSVBtclBqUkpueHdTR0N2Ni85?=
 =?utf-8?B?NjUvSDl3ZWQ1a1YvUmdGTXJFZ3JTMm50b01PV3JhVUtEbWM5Ym1tVUVhYmlW?=
 =?utf-8?B?SUR3MnJPNjlSa2pOK3VueHFrczgwQUsvVHZ6cE8vTXRnVXFlVzFKZmFTOGkv?=
 =?utf-8?B?SnFERU5mMUtzSGV3aTdZcXhUV1Q1b3c2QU1ac2UxS2g3VW9UWGlrejVKNkFT?=
 =?utf-8?B?Qk42N3JZZnZwMzBJVVdienBoMGpVRW1pOUMwdUJZSXJkYmdKWllldVNIOVlS?=
 =?utf-8?B?VlJCNnRtSThQZDVRMzdwWW5rTTJQU0xqa1RjckVtM3RrUTM2bXdENEJhS1Y1?=
 =?utf-8?B?eEVyc1JsOC84SHlvNm5BcERUeFRpa05EVWxJVE10TnY3RmZNcFRnb0ViTlVj?=
 =?utf-8?B?R25EenROSnN2U1BYQUViWmhHeStoTU5Pd1lUanpDa2YyK2hXbUt0ZXloeXpE?=
 =?utf-8?B?eFVRSGRhcjNVK3lFeTJEMWFucXdVNU1ZbGtZV2N0YXFRNzhmU0I5RExlc0FU?=
 =?utf-8?B?MjRTa0Y5cS9MMXN5aVFHMks4bGtBQXk5aUsvUUJ5ZDByZlVxSG9mSzdMUlVH?=
 =?utf-8?B?Qnd0QlhoY1BmSXY2ZjllNWNMSHVLRy81WUpVVldRWngvOGd0bHNKU0daM0lt?=
 =?utf-8?B?TVJ5dC9ZSGsrQVBLVXNEblo2djI2RXpQUkYzQXRJdHVQeWFwdEJMaDZoSUZq?=
 =?utf-8?B?R0swakFYMWJieTVTVGR6Y3hiQXF2WmJJNWpkbi85VkEwUXFQVlU4TDdUbVVv?=
 =?utf-8?B?ZTFDWE1udGhqV1VYbWJWWDloQkdWaHBtNmMzZGFqUkU2VnYyTVJUTXBNYVN6?=
 =?utf-8?B?Ylg5TEdOdXhLUVlvWEM1NVh2R2NNUUJydlh3clZWZTY4dFpMam83eVVVYjQ4?=
 =?utf-8?B?K0s0L1dzSk5pVWw4Y0EwbjErc2M3Yk5VVC9HVmZPTkRqQyszcUJrMzdoWkVH?=
 =?utf-8?B?cGhBUGhnTkNjZjhHR0xFR0IwWWxuVm11aXMzdzU4djdjR1dnQjlLaEJveFIw?=
 =?utf-8?B?V09CRzVvWlFQTkR4c3ZKT3U2U3dUa0lIbjEyWDBRNmkxR25QaVRZZWczUG4y?=
 =?utf-8?B?R0dMS28zdnUwNlFZTkdyTDRtcExpa3RJbWNidmpuVmplK3NrWWx0bXdNRUI2?=
 =?utf-8?B?VGV5ZDV1U0dJb3lVWHVWQ0pLcmh0NFZ0V0JFaTVzL1ZyNTZOVWdKdi96UFQ3?=
 =?utf-8?B?TUdtQ2tHQmwrdWRjUTNiWGpYVHpHK21iNVdmU0ZBcHNDdGNwNjJxTWlNNFRX?=
 =?utf-8?B?aDJmTzRsUG15MGFSVnVFTVptQUt6MGhXWDdWeUlsZjRDNlVVTTNETkVCNDRL?=
 =?utf-8?B?SnI3d08ydnU3dU00WHpjbEQ3Rzd5OTVSMTN5cWM5VnI0eFBXem95Sm5EMmk4?=
 =?utf-8?B?OFVpM3JXSkhRcUtSdlNrN1VVT3F1bi84emI3QXFrWm5HVysxckhvalBXMDAw?=
 =?utf-8?B?U2diSXZFQWo1Tkt2Q25LbTI2TFl5OEhVaUlhYUxCTkthOXE2aXJneEVZUmVY?=
 =?utf-8?B?dVlvYkM4OGM5ZElOb1pCcGZmeVlUM0NhNGYvRVhFTGk3R1h5TzNOQU1qOEVa?=
 =?utf-8?B?dmszNVNUZnBMZGdCTWlMVWl1WmYxUlhMTVVsUzlRY2pLY0lMR1h1a3hsNHVr?=
 =?utf-8?B?SDdIZkxFUTVBbXE1bFdXM2tlM1JCQUFrSFhKUHVkRGJTK2loU1BvM1FXMGp0?=
 =?utf-8?B?RE8yT2JacHlONkRKb0FLZWszWTdVUElaOVhSbUc5TTVHaERJUTlveTZiUkJu?=
 =?utf-8?B?bmx6UmFmWTNZclF0STB6Q3BNTFpGQUN5UlhHbXd0ajVPVnRLbGNBdzRuMFRa?=
 =?utf-8?B?MUxDTGRRbTAxcVI4YUpYTm1iVkQwL1NSSjQxZWJhSzFGVTU1S2xKV0JFUzdw?=
 =?utf-8?B?KytPMitWaXRxTjUwbkJaeXh1UW9nTk1RVFVCQmVFY2pXeExITGRsL2g1RUNv?=
 =?utf-8?Q?Ny6LrgEyqfRqhG7S+O00PhY=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d169d75-1d6e-4107-fdf0-08dcc7577cf9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 11:49:35.5348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gz/1AUNdItMRMgmI9ztXlZkPOTcKFpjNlIRfnXGH9yhv4r2E+rhgaIFqtSsX4pcT0CrHhQgUePWWHcYboNifpRfx23q/2OE3Rf2j5fHS8CH1OzXZwy9Pr26nuELIUG1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR01MB8694

On 8/26/2024 6:45 PM, Jason Gunthorpe wrote:
> On Mon, Aug 26, 2024 at 12:27:02PM -0400, Dennis Dalessandro wrote:
>> On 7/31/24 4:02 PM, Doug Miller wrote:
>>> I am working on SR-IOV support for a new adapter which has shared
>>> resources between the PF and VFs and requires an out-of-band (outside
>>> the adapter) communication mechanism to manage those resources. I have
>>> been looking at RPMSG as a mechanism to communicate between the driver
>>> on a guest (VM) and the driver on the host OS (which "owns" the
>>> resources). It appears to me that virtio is intended for communication
>>> between guests and host, and RPMSG over virtio is what I want to use.
>>>
>>> Can anyone confirm that RPMSG is capable of doing what we need? If so,
>>> I'll need some help figuring out how to use that from kernel device
>>> drivers (I've not been able to find any examples of doing the
>>> service/device side). If not, is there some other facility that is
>>> better suited?
>> Hi Bjorn and Mathieu, any advice here for Doug? Adding linux-rdma folks =
as that
>> is where this will eventually target.
> Typically in cases like this you'd paravirtualize some of the VF
> before sticking it in the VM so that there is a tidy channel between
> the VF driver and the VMM to do whatever this coordination is. There
> are many examples, but it is hard to see if you don't know the device
> architectures in detail.
Can you give more detail on how this paravirtualization is accomplished?
Or point to an example? It seems to me that rpmsg would be a cleaner
solution, at least until I can see how paravirtualization is implemented
for comparison.
>
> If you stick it in seperate virtio PCI device you'll have hard
> problems co-ordinating the two drivers.
>
> Jason


External recipient

