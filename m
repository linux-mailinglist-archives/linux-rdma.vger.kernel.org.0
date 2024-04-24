Return-Path: <linux-rdma+bounces-2050-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7438B0615
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 11:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C02C1F21A5F
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 09:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD7D158D98;
	Wed, 24 Apr 2024 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="UPMElDRE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149FA1EF1A
	for <linux-rdma@vger.kernel.org>; Wed, 24 Apr 2024 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713951137; cv=fail; b=at9FhxbX/BtnKPXkk6T78Fe28D5Hj7x+I/DcORQUDtlltIQgjforhMXd5T0aQmH8k3sVUgoOQSzQ9mTojCVPknWe90hme/1qSfH1+0h+A3eR+xBEAxVukAoVk20m007V3w5jxN/WKpETLpHwyfFGr7xVwOOiFbma7gS0JEpZDBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713951137; c=relaxed/simple;
	bh=ZrkCH6CYq+7RX/jwPptaTCK2NfxQZyfh9IGKApn64pk=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=KxfAOhTFWZ6OYH9oEObnjl/HyGbtnxWSEHwcBQeRoIuFpLSNKiRdx8qiXlhF81f4QtF4EIC06mzLF2njENF+6ako79/Gz1N0YOBNAfkq0qwAHwChnnVQM3hckR3/eJb4tSuuiUBrmPqrdSbk4b+XwtTvUYW53Z6ke9PPmrbkKjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=UPMElDRE; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100]) by mx-outbound44-94.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 24 Apr 2024 09:32:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3I53Zhb6jY1qv5kLh8yO4fuwBDHJBFj/qwPjnpoiWb/xwpQ6tc4Kr4BCr6rwSYjAG3I+drA4Q7mL3Yza8NNMLYgrQKEQux4KVxvSv0kh3fbvbk/fZNXNdHaLTpzctmmq7Gy8T0+Q3IexsLSDrbI+krunh1kABeFIU9kjGWxfE7x84D6Z3VR79mxdJJ8VmddIG4ZQj1aBVLqvRsjzjim7HwPUsqXUU3r2POpvG4aYtBbBwn5Z2YZpGuMk/XXcB81pJnFhXRv9QHmWD/DxCUcXE7Z3CRUyYaBm4pc/9wygibadJB1iX9i8wXKpOtw3b/zFm4jy988LqbN1XfQQCu4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpFnojMUoF6p0+kScDX262w83m0YVh0Vg6b2nfsm964=;
 b=av9hbOsmERYg6DrEuCCD6DVfSs+DNNWJ/QUbJ7GEvx/lznU5kZ7kdhc+HDiw1fie4FjJvaVDfr3tItc/i+dGM/HkndNFZ2ijz8sEaUHZEe5rJlPQ6E6hg7xZY7ZwpAwZTXDgwzh01OU/tIVHyCQTP1fC6kTVYHpox08eogQ7QYuQOKdfzfiinR1WZVC4P+11BckAf5t7VV2kaZ6Fz+cO88x+t4s/e1fCRyyahcpJflZk8lOfdLJGn+A87/igihKMGpNbZ+fQ/l4W1VDq1T355SkXH2LSlPy9v3aNHzz93/IICpfj1ySALeH3lOIaY3U7R9KEINt15SaNhvnVD9a6Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpFnojMUoF6p0+kScDX262w83m0YVh0Vg6b2nfsm964=;
 b=UPMElDRE5+iYFnWA1FT/cBqO+NMpQJh5lWFy4JIhXugdrZhVspclXKMnjdwYJXEAXPGz6pahx5bOymQ0HA7sGsuYlZkNkStneTNjtVB4u1psA7rQdnEe0uHZwmwNzBdGFuc/bMQ48y/fH9qeblcJ8bjv+66WxXdlVsM8KsSo2XE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from SA1PR19MB5570.namprd19.prod.outlook.com (2603:10b6:806:236::11)
 by MN0PR19MB5921.namprd19.prod.outlook.com (2603:10b6:208:37c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 09:16:43 +0000
Received: from SA1PR19MB5570.namprd19.prod.outlook.com
 ([fe80::956b:a5db:c859:cfa2]) by SA1PR19MB5570.namprd19.prod.outlook.com
 ([fe80::956b:a5db:c859:cfa2%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 09:16:43 +0000
Date: Wed, 24 Apr 2024 11:16:37 +0200
From: Etienne AUJAMES <eaujames@ddn.com>
To: jgg@ziepe.ca, leon@kernel.org, markzhang@nvidia.com, shefty@nvidia.com
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"Gael.DELBARY@cea.fr" <Gael.DELBARY@cea.fr>,
	"guillaume.courrier@cea.fr" <guillaume.courrier@cea.fr>,
	Serguei Smirnov <ssmirnov@whamcloud.com>,
	Cyril Bordage <cbordage@whamcloud.com>
Subject: [PATCH rdma-next v3] IB/cma: Define option to set max CM retries
Message-ID: <ZijN9UGAM48tDXMo@eaujamesDDN>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: PA7P264CA0442.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37d::23) To SA1PR19MB5570.namprd19.prod.outlook.com
 (2603:10b6:806:236::11)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR19MB5570:EE_|MN0PR19MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c8f88e7-17b4-40d2-712b-08dc643f4217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p8XbKlBAtbVU5qQtFcwkwHpNkw/g5FosCHo4MVkvKXUke9r5Boe8//5eitZR?=
 =?us-ascii?Q?/dlVbvW3DOiJeA2IxdSOdjpx184l7BtOFCW9Lekun9YVT9Sa9HUKYpzzsJa8?=
 =?us-ascii?Q?Zk28IaXIx7DlDCGyB6vfLPx3V/9uU+nnKjwppYF0pLo34nGh6j4jbAa+ufzz?=
 =?us-ascii?Q?RCmbb5+kx0OhwipQBIavpGIxqqUQx5Y5Ayo8lxtEBPqcwv3VUPkfnbsVsKh2?=
 =?us-ascii?Q?AZSDGPhGbAtMVUhbjgny6K/pbYJqc3BqLeDjZcaGAqfwImiPn71+4sGHqeO4?=
 =?us-ascii?Q?isrmwpMzHfiSicJLDj6/ZxRMrzIOxf6F+69hbxBnozCZIicd2fPW4Yz+2Xpp?=
 =?us-ascii?Q?R9kGaBioO7U9dcBrnulLJXVIjbun/XAUNs+LXTT2X9iijvN6QHOL7hng6N5l?=
 =?us-ascii?Q?wyDbocPl53k4uqJAMTP79CN8MasvGOUEf04KUwkavZSxg7LLjreuc++HmHIa?=
 =?us-ascii?Q?FMJi3LaZMGBTPiIsng+FRcUgCZuEKlCxR43I09Nx5ba6FDt60HS4h1wzU8Db?=
 =?us-ascii?Q?kDBmuAMREHhU7aCPyyoYgKvLZqTMHdB0XcTv9qjg76TgNlxI0Tdwl6bLiVze?=
 =?us-ascii?Q?XDDbh24NICtJwQHdl+w1zmHqZui92fEalUQI8mUpkV33MIXTZcEVyPwaCTud?=
 =?us-ascii?Q?bN2Og7GJ+Oj+osGVxY/7lrnXe2F2CqJ7kOVi68NObIUD2iYERSb1FXiUeQvW?=
 =?us-ascii?Q?AvbOoDpviPt1Dp00LiHOhPVs+LM5xFJDIFA63cmV/SFtYG5TwcNEA8EGXDLx?=
 =?us-ascii?Q?zdzOvIkltux/teUV6WUr7DJbKw3YtHZJQ/KMtjw9N2PXMzvL4m1xSYUuRw0B?=
 =?us-ascii?Q?ItbIt5CKZNPpR4ow+LSxmqVxaNzrNdq+FMmsv/Q5DbWYqCEO5YsxEntfB9JY?=
 =?us-ascii?Q?A0+OKILZBtbEHRPMBVk635YPVHz5q2CsoJv8+RlyRm1CWOsoVl8L8LYpF/g3?=
 =?us-ascii?Q?hS+YUrnQ2AwLuVhbzGpkghpxiVnXWZWNrGOsROCTx8vlD9PLnsAnIkeJ/e7X?=
 =?us-ascii?Q?IUppGHY7LgYZfdwISVJS1QlJ1+YtjknoIpOQ/GibXMxx9mEpg+Zvsftxe4bU?=
 =?us-ascii?Q?gBrpLzq7FjZaJ1HmV6vfBLVxthublRntXfRL01cT70BfBmfNLfT8F+gZs9Fd?=
 =?us-ascii?Q?Y6Dz659jkoVF4atrnkK1A3pcqGAaJWDfCVwk/PezIiJNXUl2EbxMgB3foULk?=
 =?us-ascii?Q?BvesL8k9nyiKAapzguetSY5CCb4YD9U6H6ab6XoZOJWRJqvfSZ7Plk29fMZe?=
 =?us-ascii?Q?f7Bm/UjEbB09gScBNp1eGsfby6zEGYul3asabzi9Kw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB5570.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oM91t+GYl9dUvPPtM6FuaSle9dlXoK8XPOhb/GFzSt0w6lxtCdSfGDf+86yG?=
 =?us-ascii?Q?b0MvHK9ENvXtFXH1C8VAGLEpdpSTjPgDSuCcfBRr5qUSPdoCwvvqOaFTlwh2?=
 =?us-ascii?Q?g4X3ErDPaYDWClbqpNhdGylk8ph9PQ48OEwfSToBSC7VjHcktEhj/EN/l24l?=
 =?us-ascii?Q?0bk7wrN5QURo06NROnJmRxm+spcXLmtcfk8sGTtr27qTLBj/0qHAp47ih55j?=
 =?us-ascii?Q?VQKK+YvQBYIFb50XxVh3oXhMMdIcIed6CVO76w/sNZ83Y/Pn9P7EyXmqMlfv?=
 =?us-ascii?Q?wGULbKO+tYrnHfMXwN33lpBZbCkWmA2cc7Y7B7NwRRSGtQAKE37KNJiP6UnS?=
 =?us-ascii?Q?BG3V9/sAQ5V521GTnECg4QewwJE7S+9YNEpLgUNkgp7+cKUFwa1G24DUKeQ8?=
 =?us-ascii?Q?IVh+peuQYxASEz6mEqulpD2mJHYxxUZGAvWUd+KzjDWm8JhmBBNr4RakMd6o?=
 =?us-ascii?Q?e20IU9CbFULHVFX1KdI2fs+htralXbiN7ckQD+qe9L544lQ+tPiMYnzx41nQ?=
 =?us-ascii?Q?wNXYxflf4Rp/PDdJpHAvilWjRJ6MDX/FKhsV/c+68rAwNgwWQLb6BnVlJjTz?=
 =?us-ascii?Q?oSLu/ul6+q1WwPBX5L9w2cPc9TpCzcfpB3U+0LNfFYJGhbm4RkKiz0sGGAi+?=
 =?us-ascii?Q?zctU/ATh0J1kYKTDTlF4m3i5Hhxt94JGVsp2FrcdUhL0BcsqHMeYh/9W78AA?=
 =?us-ascii?Q?GCqlOc2rBNznyL1Ew7/2oXiOUqmo/FGlmgjdMzUl7qmiMBR4Kr8CXmOjotgg?=
 =?us-ascii?Q?W+UGdPW7BcrD3DPnrKgFnpTlUcmnU6U9oUFam/Vlm6AhyT36gqi8T0cpRn3N?=
 =?us-ascii?Q?T1XSNCbaV49Hupi+uzg1joqOXBC9q6RD6A38M3tSsH0mfd3NwXZ3vrbfgulN?=
 =?us-ascii?Q?m2H1BpAiD65n+z7dA3fPtX02lCBYqcTXcSoI8BXagTRLw4ijIaM38E5rKlO5?=
 =?us-ascii?Q?Tkg5eWvHeepNKc/IDRYoBazA/vADsznAH0uZP9r/zrjHs9ftULkMCbBKkgcP?=
 =?us-ascii?Q?M9S6kmEhVdbA//bag03lJpa6p2CCiXL+QavRfRoZvPPbZy9n/VDq0YRdYX0v?=
 =?us-ascii?Q?0pBFozZjlAKcDeycfFS+Sk6VJTyt+PjkHfMjOPUZylY11Gr67MEqPBsReJHq?=
 =?us-ascii?Q?03AjDEpyde6jTM9dJqiiYOMf/4a3u2sUMQFZTUedtkWrQNkp6gTsy1IkxrxE?=
 =?us-ascii?Q?BTrc+U9dw/xHOt8RvGPvuPib2pOU0cBA/6K/sBw+5VeeFgnkf2g0fxsbw6jY?=
 =?us-ascii?Q?RUHNprNykaMSiZuNaaleQdIptBxUaqeFFUjdtXv9aXSfzIId3oEFQhPTuFRl?=
 =?us-ascii?Q?n5L2cSTwkYMG34ILH2fVc6/ROG/AF7pf/XOoYmBImuKH4iyaUr5AupQabyh/?=
 =?us-ascii?Q?L4a9fNgMoEZcz9tj4QNI8UaSnaAmshnkO5n2/3xhntDZ4DqvInBHsbMJ8d36?=
 =?us-ascii?Q?Y54zMTcnOofKbipHS7E7+rcxHEpc/7cHBYKbEF9xyXBmO4W3gWCVzlPoSFvU?=
 =?us-ascii?Q?RqYOk4OIdNNTKNwxKCSwe77fh1HZQATxJFFnvuD/feoYDnbrixoC2TKdD/AK?=
 =?us-ascii?Q?47nj3pLjVQw14CmvAINKm1FlTTKpz3aqb3atX18a+xD6vZRRhI8rHF/h9dH/?=
 =?us-ascii?Q?uMmLBMNfZOKVtDGTOWX+XHmaXuCemUKeBL5p+TLjjOxj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0tm1WaV7gRrOke2Qt04YyReHfuBZu+9DjPs/nXCuRxKl/j9TTVtVkLoSDJbMMh8wgHVuhaWrgWaF2m+rnTw67Fv22wda871nLMeB3e1cHpFpIc60zjF9Y5vFU1KM2CdcMMrGHpNiiz9f6BjiHYzqZwDR3qERWiOfjSD4XkLmVPZRcpoQeBfm7ICgOPOIgsSDkMaS5NbmUyPil9yozcjay0/RJEAjqadzoGJIBKjS8pkIOCWOmJ4BMmcymxo+geX+eQtvoWO2mWroMK9xFchD6fBTis5w2hvcY5B+98GBHUbrwZOq8Ojt65zhURtWEsE8J8F5Mr6Y5m509yxuu7loiJYmROah2ZlDImpPENaGjQRSZGiKagmE6ap1Uhs7u80eHw9v1NwjUUwLZRH7JiyfChsIkte40m5r0T4IST/Jf1PJ337j5sRGZH9WmGMouiRIk3bfxFQZ0/OesA9MZEAqLq2/+anNvVXMKn/ANFjUtvI/9HvB3Z00uv4uLgj8lR+FcR25VNL1vSu2ZoyGojm8cRPWjxn2tvu1qhkyL+NKzB88BEkc3QwI+TMU6BXkb7P4g75iBZUioNqP1PlEgoYcrKJYE48+aDVbWuFbtwm+l5llfgwrPj2LWvJgVDnAZ2pg1wL9FQYX6U7uVUWNWT4+qg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8f88e7-17b4-40d2-712b-08dc643f4217
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB5570.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 09:16:43.6294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1/8hayrA4KmhKRJQELDnlwzganO8jdmV+lAzu4/Xbam5q5BGhuny8HDwKWRAWvuaL16xP3f/UeeWDUrtTpn5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB5921
X-OriginatorOrg: ddn.com
X-BESS-ID: 1713951121-111358-8457-19136-1
X-BESS-VER: 2019.1_20240412.2127
X-BESS-Apparent-Source-IP: 104.47.58.100
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqamhpZAVgZQ0DApzcIk0dAgKd
	XIPMnCyNLcItUi2TzZwsDY3NTMMNVcqTYWAGn9HpJBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.255786 [from 
	cloudscan15-34.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Define new options in 'rdma_set_option' to override default CM retries
("Max CM retries").

This option can be useful for RoCE networks (no SM) to decrease the
overall connection timeout with an unreachable node.

With a default of 15 retries, the CM can take several minutes to
return an UNREACHABLE event.

With Infiniband, the SM returns an empty path record for an
unreachable node (error returned in rdma_resolve_route()). So, the
application will not send the connection requests.

Signed-off-by: Etienne AUJAMES <eaujames@ddn.com>
---
 drivers/infiniband/core/cma.c      | 36 ++++++++++++++++++++++++++++--
 drivers/infiniband/core/cma_priv.h |  1 +
 drivers/infiniband/core/ucma.c     |  7 ++++++
 include/rdma/rdma_cm.h             |  3 +++
 include/uapi/rdma/rdma_user_cm.h   |  3 ++-
 5 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 1e2cd7c8716e..58990d262a82 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1002,6 +1002,7 @@ __rdma_create_id(struct net *net, rdma_cm_event_handler event_handler,
 	id_priv->tos_set = false;
 	id_priv->timeout_set = false;
 	id_priv->min_rnr_timer_set = false;
+	id_priv->max_cm_retries = CMA_MAX_CM_RETRIES;
 	id_priv->gid_type = IB_GID_TYPE_IB;
 	spin_lock_init(&id_priv->lock);
 	mutex_init(&id_priv->qp_mutex);
@@ -2845,6 +2846,37 @@ int rdma_set_min_rnr_timer(struct rdma_cm_id *id, u8 min_rnr_timer)
 }
 EXPORT_SYMBOL(rdma_set_min_rnr_timer);
 
+/**
+ * rdma_set_cm_retries() - Configure CM retries to establish an active
+ *                         connection.
+ * @id: Connection identifier to connect.
+ * @max_cm_retries: 4-bit value defined as "Max CM Retries" REQ field
+ *		    (Table 99 "REQ Message Contents" in the IBTA specification).
+ *
+ * This function should be called before rdma_connect() on active side.
+ * The value will determine the maximum number of times the CM should
+ * resend a connection request or reply (REQ/REP) before giving up (UNREACHABLE
+ * event).
+ *
+ * Return: 0 for success
+ */
+int rdma_set_cm_retries(struct rdma_cm_id *id, u8 max_cm_retries)
+{
+	struct rdma_id_private *id_priv;
+
+	/* It is a 4-bit value */
+	if (max_cm_retries & 0xf0)
+		return -EINVAL;
+
+	id_priv = container_of(id, struct rdma_id_private, id);
+	mutex_lock(&id_priv->qp_mutex);
+	id_priv->max_cm_retries = max_cm_retries;
+	mutex_unlock(&id_priv->qp_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL(rdma_set_cm_retries);
+
 static int route_set_path_rec_inbound(struct cma_work *work,
 				      struct sa_path_rec *path_rec)
 {
@@ -4296,7 +4328,7 @@ static int cma_resolve_ib_udp(struct rdma_id_private *id_priv,
 	req.sgid_attr = id_priv->id.route.addr.dev_addr.sgid_attr;
 	req.service_id = rdma_get_service_id(&id_priv->id, cma_dst_addr(id_priv));
 	req.timeout_ms = 1 << (CMA_CM_RESPONSE_TIMEOUT - 8);
-	req.max_cm_retries = CMA_MAX_CM_RETRIES;
+	req.max_cm_retries = id_priv->max_cm_retries;
 
 	trace_cm_send_sidr_req(id_priv);
 	ret = ib_send_cm_sidr_req(id_priv->cm_id.ib, &req);
@@ -4370,7 +4402,7 @@ static int cma_connect_ib(struct rdma_id_private *id_priv,
 	req.rnr_retry_count = min_t(u8, 7, conn_param->rnr_retry_count);
 	req.remote_cm_response_timeout = CMA_CM_RESPONSE_TIMEOUT;
 	req.local_cm_response_timeout = CMA_CM_RESPONSE_TIMEOUT;
-	req.max_cm_retries = CMA_MAX_CM_RETRIES;
+	req.max_cm_retries = id_priv->max_cm_retries;
 	req.srq = id_priv->srq ? 1 : 0;
 	req.ece.vendor_id = id_priv->ece.vendor_id;
 	req.ece.attr_mod = id_priv->ece.attr_mod;
diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core/cma_priv.h
index b7354c94cf1b..56c945c9cf2f 100644
--- a/drivers/infiniband/core/cma_priv.h
+++ b/drivers/infiniband/core/cma_priv.h
@@ -99,6 +99,7 @@ struct rdma_id_private {
 	u8			afonly;
 	u8			timeout;
 	u8			min_rnr_timer;
+	u8			max_cm_retries;
 	u8 used_resolve_ip;
 	enum ib_gid_type	gid_type;
 
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 5f5ad8faf86e..27c165de7eff 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1284,6 +1284,13 @@ static int ucma_set_option_id(struct ucma_context *ctx, int optname,
 		}
 		ret = rdma_set_ack_timeout(ctx->cm_id, *((u8 *)optval));
 		break;
+	case RDMA_OPTION_ID_CM_RETRIES:
+		if (optlen != sizeof(u8)) {
+			ret = -EINVAL;
+			break;
+		}
+		ret = rdma_set_cm_retries(ctx->cm_id, *((u8 *)optval));
+		break;
 	default:
 		ret = -ENOSYS;
 	}
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index 8a8ab2f793ab..1d7404e2d81e 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -344,6 +344,9 @@ int rdma_set_afonly(struct rdma_cm_id *id, int afonly);
 int rdma_set_ack_timeout(struct rdma_cm_id *id, u8 timeout);
 
 int rdma_set_min_rnr_timer(struct rdma_cm_id *id, u8 min_rnr_timer);
+
+int rdma_set_cm_retries(struct rdma_cm_id *id, u8 max_cm_retries);
+
  /**
  * rdma_get_service_id - Return the IB service ID for a specified address.
  * @id: Communication identifier associated with the address.
diff --git a/include/uapi/rdma/rdma_user_cm.h b/include/uapi/rdma/rdma_user_cm.h
index 7cea03581f79..f00eb05006b0 100644
--- a/include/uapi/rdma/rdma_user_cm.h
+++ b/include/uapi/rdma/rdma_user_cm.h
@@ -313,7 +313,8 @@ enum {
 	RDMA_OPTION_ID_TOS	 = 0,
 	RDMA_OPTION_ID_REUSEADDR = 1,
 	RDMA_OPTION_ID_AFONLY	 = 2,
-	RDMA_OPTION_ID_ACK_TIMEOUT = 3
+	RDMA_OPTION_ID_ACK_TIMEOUT = 3,
+	RDMA_OPTION_ID_CM_RETRIES = 4,
 };
 
 enum {
-- 
2.39.3


