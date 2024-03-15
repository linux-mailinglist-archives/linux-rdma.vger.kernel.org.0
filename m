Return-Path: <linux-rdma+bounces-1452-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8114887D0F9
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Mar 2024 17:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6480280CBD
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Mar 2024 16:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E1D44C87;
	Fri, 15 Mar 2024 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="Za7B2LZo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2109.outbound.protection.outlook.com [40.107.101.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B540BED;
	Fri, 15 Mar 2024 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710519146; cv=fail; b=bh9/b9IRkN6RL/HzFD6wd05xtw4TuaoeI757SOMFDPTArl3O2sfoTTxY19T0hlULblGUuMD9TIq0KTC/AnXph5fn1IeSvKUBo6rgG++LS0dFv8zP+A+Ysl6swrYpJQvnwJbKqD/dYpMALn6CTBS9fbR+DfFSjz+iU48eUBeeh/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710519146; c=relaxed/simple;
	bh=9RM58ykHVRPhGjXN+aymwn7WOs3IYMjkTq9hzi2QYxg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=od8M8+CalSi4zO7XIA2CkAwmrJzJdq3EQnrCdRS3bOQs8pBuIitLUjMiIvSnL4/ovqt3ykKUQiUeiVz2fGJk8xK3lt8t9pK8jXCSmFi6rRqotqG82L0CtO+hp1coV7BoX4HO1r5bYPS0+x2mssXhDsjt2nmXpewp4oGYeEPHrK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=Za7B2LZo; arc=fail smtp.client-ip=40.107.101.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGkt2GHIHCBBpV6jLMuWvoo8HeJm/78sf267kjGBBZPjeEiBW+hVBhUGMg75EaTG+0vfrMqQvUrkJUJJtQF7WSuWWwnNxOgJz0TYAnofWRJVKuSveqzdJXyAcMkxiUF8ukqpt4ZDhgrzS6QjBZaYhP9dg595L+1w3JRbXiXSbVtNNu7Hm/rtp/Ci3QpVxZkmFxCpOEYTB9HkbLkpYfs/u7O1AfYrbXJd61SUTGO9pfvTd8/Ufxm+Z039/UPB9wyqNXf/t7kxvamKY4iofhrp1EAg8sG+IMcOVzJMsWFwWHn9eqarmJDUS7W+ke18LTo8Jju5+v/QsA1yN/mnipokhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLMJP83Lde2N6V1/LiKnsHziB+lp7/oEMjiN8jekdno=;
 b=JlVBxXMvGTIgA1PYZ3/WIAYpdH6abzH5AJM1g3mt191wcCepV0mknuW8U/LyKUS+LOV3pqSDthVefwBXQNA57SRoaR+NkYVO8Pfe6UE0xcTN+xe4yLYcqVDI61FjVvO8EVpVRVa4tSDjRKkteEhPO7OkHm53yAIxc8SsBl/cB60YI1TJQ2hA7ihl8IKGsORSoVqTIeOepNsqUcGUq/jOI58ilBhB0x9RjU7JHhSkHcC7pQnsMnx6U/NsE+NYGcVowuzN0aI0irjj0XwCWETUf3amDL27V3nwoRUXlf6nsx2XmMBjXbEYmba2uNgnVV+A/Xq4DYT/lPKSom/Bxb4VgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLMJP83Lde2N6V1/LiKnsHziB+lp7/oEMjiN8jekdno=;
 b=Za7B2LZohnVGCcgSojO7OEB8tWkCmz74xii5GfVqkvqsg1pFzU+q1TxoNsg2gJbmaKrL/AFeReyBQ5xoFnTPPpKABQN8SuNG9VP653P2s9QYvmKxfd9pWUUk/1XEOofZJSU0+dCVDtR9VZsK9GSW29QcPpWn4BUuyq4MYC0XW+r8H9m6trv+HOjYBr4aeBAWQ8dPkM2+hIK8pNBF/ndZ+b/5WFMFcNy3N87DJf/Ub+qqodA4Vff1Zlyz9b6+wevr6w4bKUqQ8r/eeTUhe+OC6l2jgToWWLShPmSJ1b6rirrpyKmgusjahsNyRIW2VNkijFbDVDtZzH0zpHzMt1y5bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4817.prod.exchangelabs.com (2603:10b6:208:7c::31) by
 CYYPR01MB8565.prod.exchangelabs.com (2603:10b6:930:c8::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.22; Fri, 15 Mar 2024 16:12:17 +0000
Received: from BL0PR01MB4817.prod.exchangelabs.com
 ([fe80::b62f:89e4:967b:47ff]) by BL0PR01MB4817.prod.exchangelabs.com
 ([fe80::b62f:89e4:967b:47ff%6]) with mapi id 15.20.7316.039; Fri, 15 Mar 2024
 16:12:17 +0000
Message-ID: <b4cf355e-8310-422c-8ff8-9e96d7efc9e5@cornelisnetworks.com>
Date: Fri, 15 Mar 2024 12:12:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] IB/hfi1: allocate dummy net_device dynamically
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>
Cc: kuba@kernel.org, keescook@chromium.org,
 "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240313103311.2926567-1-leitao@debian.org>
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20240313103311.2926567-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:335::10) To BL0PR01MB4817.prod.exchangelabs.com
 (2603:10b6:208:7c::31)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4817:EE_|CYYPR01MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a06105-ca50-42ba-0329-08dc450aaf0a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yHmBu1dGSmHrAeM1y8uY2EdmPwlnBocC9i1Af0sDd3ndh4GkpVOJ2x9BZNnE+fWtcJ7vH+PVBTOLHlJyUeUY41Kv9fiGKL85cOfHuc5ms/hpJkn+q2iz98YuoLIWlCOexec4N/A7T4J+LvM68ooW929FdqYMt7sRNptd/DnerOZ1IwA4g4tigWvKlhPib1fTGhaMoTfx1JLpycKBRDNrQqIO11KSvqrQz2qk2ZbkHTkgNBRTH5R9wFMvO4oAxINo7d3wtFOQSsAkFMKLInV3ID6us8MrwXtoywfAif80lU1faPg+WuYiJNdRgDxgYH6EibmOqic2T1Mwwr2+iSvtGk8D4Rgij41dCI5qf5kcp5fYxskeZNpuaExm+oeA2zIKoR+0AhnM3Im4idfF+4xRl+cElnGWyxSPS+AKKmhKxCGwHP7z3pPRQWbK0aGZIvf8yphPthXz0h26ONCtZ2DAJgjRrdZqInzGNiC7xflAuBwrXIEQt49oBFmvmMsYzNoQ3nbP5Olt16QfQVP/3W3dG3NlPzboPksOBn7oW/tkDCfUV1ZBr8YW1FL8VKZ3B/rtErWnN/LoEjoGJS4U6A3O0jO5twlPi2hgXdVEeIihtNzr1jiIsLLj5zUS2Nz1IUTeg5vMonm5BI3a+R7nInMq4a+ih332oVENiuiMQKSQb7Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4817.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGZlaTJ5bm9FWlN5QmFkNDdXYTZlUVg2NVMycEJ1OTRlWWU1TzVzTS82QzlE?=
 =?utf-8?B?QlEvNDFMRDdTcWVMVlVjeTlLdG9odDRiSE14TE43bUJKaXp3L0xjbHdSWUlv?=
 =?utf-8?B?emUrWEh6T2RzaWlxVDRuemI0S0JXdlpKQmpVdTdvTjJpaUR4K3k1alRPRWRP?=
 =?utf-8?B?Tlg5NDV3NlUvb2w0TzFHeXVlZHJDb1RWV1pzd2xPeDJaQkNtVkxNMGs0U2Vm?=
 =?utf-8?B?M3JqOS9HNjd5N08rTWh2ckh2dnErY04wNk1BdllTanJWSkI4Rm5CZC9WRDlh?=
 =?utf-8?B?YjloZHNVbVRxVVBTOW1kZUtCQ0h5WE5ZRzlPdUpKRTFYYjJ0SC84U1pZTmNx?=
 =?utf-8?B?L0RpVnRSWUJXOWp4Y1U0L1drU1JqSkdWNVdQSnF5Q3Q5Y1FBM2M5a3BiaVJB?=
 =?utf-8?B?TVJnb3I3N3BxSFVSaUFOYmZsckVSU3lIWUI4VzJNeHhYS3BXMHNmdXZKa3JB?=
 =?utf-8?B?SXlaOU1CRnFWTXkyY0xIUTNVREpZOFdCVmJvQ2IzREoyQkh0MU9NYzZlbk00?=
 =?utf-8?B?UVNwZHZxbTZEOWFVNDBreitTTU9RVEo4NUZYSXQ3ck5NWFIvelpYK2pEeXBF?=
 =?utf-8?B?Z0FFRU5tbVUyaDZVbnRwdXJQcWhiVENyK3VQNFpDdm5CeTgvTHNVbnBqSC93?=
 =?utf-8?B?STFPb1lsb0ExdXRBN0szMW94bzRCNkU3c081cU5BQit0TFZIWkc3SU1XdWdG?=
 =?utf-8?B?dDA3NFZBWXlKZjNQVTVhY0h1ZmlhVE5xbzdteXlBdE9EN2xwUFljYXhXRTFk?=
 =?utf-8?B?TjVzMEFWOWlRVnIyUlNmZ2ZsY2sxeGFsbmV6Ti8vVFE1RUxIL0JCUVFvY0FW?=
 =?utf-8?B?cktkWFVHb1NwenQ4OVM3TGQ3OTJOZW1hN09oZlhDNERJclBwSDV5aUFoQmlt?=
 =?utf-8?B?eklTaFh3RXJpbnNhM0xxZXJSd2VsUTRQSHVOVFBNTE94ZHVRMTRzYmZBK2FP?=
 =?utf-8?B?MHRkS3BDdmlGcmtVZkhHQTkyQ2cwbDc3VXlVQW80bEc1YVNub0oxUStYZGVN?=
 =?utf-8?B?RFMvbHVZNC8rYWNPUDBOYy8wU3pkcVhDRmJiblprdzIwV0FqQmpmZEh3VnR2?=
 =?utf-8?B?NitVUHVGUHpJeWhzKzhjSjBZbEsvODVOelB0RXJmR1VXMjVpUVpGakd0aTRB?=
 =?utf-8?B?Wk5rakZMQmdUUkNZRElHanNwSHp2NENNcjF0bE5zRUkxaHZJRzFvdEcwTDN5?=
 =?utf-8?B?K0V2REw2YVFYcDZqL0RXMlo1OGlYYVV6bUJRTkZmaDVHbnByeHh2TlVqdW11?=
 =?utf-8?B?QS9qU2owR25vc0YxV3l4b2l5UEJmdGlvaUFCeUtzNnZVRlpVQ0tTbkZFTjE0?=
 =?utf-8?B?cFhMcmNuTllkUmQ0cWw3WFpjbklWc2xFN2NYdk9DZndXUVIvSHRnckczRjFr?=
 =?utf-8?B?OUNZYkR0dHBmbVZSaUVkYmkxbVZlUlhMMkxrcHpiVXBaYzZTckliRm9adVlG?=
 =?utf-8?B?Y1JyREh0K0lzRzc4S2VzMzdRNlhSNmUvemFzOVZsemk5QjUxK3dkN2EvMHl4?=
 =?utf-8?B?SGlWNE9FeHU5NGdBTk0rSTdVTkZqc3RCaEl3anpVUW51TUVXdTgybjFXbTll?=
 =?utf-8?B?OUhUcit4c0NuelNDVjIvR3VQWHV6bitUbktaZjRRZDBmZnhHOFZCc1JsdjJ1?=
 =?utf-8?B?QWowL0NvMG16a0hLbWJ2M0F6anBxU0o5UGVoczNxUjhacGt0SVZNb0JXU3Nj?=
 =?utf-8?B?cmdkU2dHRU5OZjZiWHNTdzFwY0lqa1BWd09keDViT3FWemRrNjBLNktNUjNI?=
 =?utf-8?B?QkhobXZDNWxFY04vaXJIMTBtQ3UyNVoyY3VHMlBBc2VxN04vcU1rTmVrdGhh?=
 =?utf-8?B?cm1vNXBzOWtXZ0hjSkdsS2l3enlsTlBjVS9JdG82NXo0VjUxalBxUHYxbzRq?=
 =?utf-8?B?WXpJREpCVU5na1FlZDN3b0tuSTBIR3VCMjJLT2N6cDU0ZjQybDRBK05zd1pZ?=
 =?utf-8?B?cjNST1JleVpPM1VFME5iYk9RUUZXTXRtWVN1MDlwYlN0Ty9KUDFOcDhJSkZH?=
 =?utf-8?B?VmZpUU9MQkl2bTYyZkRIMGJlbDBsUUlrRVBJODRjcTU3LzlOU1kyeXFrMDZV?=
 =?utf-8?B?MzVWcW1aQzNBd2V0Z2hYRG1VVlcyNVl2b1hxOW5NNEdPU0VFTnlibS9qUkZO?=
 =?utf-8?B?VkJaS2NlK3grNnlYVGlsTXRUUDFWWUlVcWdFVENuZjVpS3RsZzNzQ0VlVHMw?=
 =?utf-8?Q?L8kb4sdItGPCGuhtWFGCRY0=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a06105-ca50-42ba-0329-08dc450aaf0a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4817.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 16:12:17.0449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Hc0TYWIcoBpuU14JaJl4dQFd7rvC5iMsqvkm/AvgMBbqPxqcYIuGmL01PRf3AIcItr8/bdzoQx3MmdXU3sUpLSPZCueUHkBWypD+fostAqubCWEXblphOBGEVvkmiiO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8565

On 3/13/24 6:33 AM, Breno Leitao wrote:
> struct net_device shouldn't be embedded into any structure, instead,
> the owner should use the priv space to embed their state into net_device.
> 
> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_device from struct hfi1_netdev_rx by converting it
> into a pointer. Then use the leverage alloc_netdev() to allocate the
> net_device object at hfi1_alloc_rx().
> 
> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> ----
> PS: this diff needs d160c66cda0ac8614 ("net: Do not return value from
> init_dummy_netdev()") in order to apply and build cleanly.
> ---
> Changelog:
> 
> v2:
> 	* Free struct hfi1_netdev_rx allocation if alloc_netdev() fails
> 	* Pass zero as the private size for alloc_netdev().
> 	* Remove wrong reference for iwl in the comments
> ---

Very lightly tested, but interface came up and I could send traffic. Code seems
OK too.

I'd prefer to at least remove the first sentence of the commit message. It makes
it sound like hfi1 was doing something incorrectly when it was using the
interface as it was designed. Instead it should read more like this is an
enhancement.


Regardless, we can call this one acked.


Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

