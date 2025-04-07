Return-Path: <linux-rdma+bounces-9206-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F20A7EA38
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 20:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB40442A79
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 18:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9672925D90C;
	Mon,  7 Apr 2025 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B7boxor5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA72325D8EF;
	Mon,  7 Apr 2025 18:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049578; cv=fail; b=tr2/fEFguiZPDUFGNOnPAHkHvzG8YWiulKYXzv9jfi5fzBsQwq9hEbAKORQLTEgq02v7VVAWYC3l+a/PbHJzV3ylI4W58v2j7f5N8MKp/aTJvt71tp5NK2qrbg+NrvUl/UqqAleIHIW/wFP3TZ17PdccMHBq35jrqODefpeQJdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049578; c=relaxed/simple;
	bh=DSnEoEpU212Kmi0L01o29mSANnWqAjQVFhJUl4PQ4CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nnUXKpmwJy5/phtha4kMbXoE4KfNZd4xRLAKvqnJFLMSuYRHhcNJm34q/GMGjyDHIZtXiDeRq8L9nD356j+9aIhTFJ9jDkFLQ0RsQrPde0g6NlHyOIvsjiYyiC3Ju/LgRSfgp13V5IQ6YDiTmZr2hmZOJu1NnOPqXLOmANqNdLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B7boxor5; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zD6CTjdfabNuPygbNMsjPJR/w6n74+T3hYu4oyqgFB7M8IT1xOResTvVAHCXHRKaky9E3bQZ4JhEv4/BRTZrkgVty5mFP3c2Q0JOCAuILX0chLYV4pHndL9CBxR4l8MiDfw9dvtSYhiYh6NvcxoBaSTTfekzm8pG3/qgJq7D8esGsu3l5kbk6Xsz1Q/d/K4+S+biEmVNj4AAfP+nM7CmX9Rv6r1eyGYi846I6iyBp2I5OyxKypcpjx9tz2MxhzqA/zUN+RHxCw93N6FzNW+V3v9fnpxp/Uzn9JaN/wJfHsk44bLEM1wc1m7x3FvdaHPa4LWYYrEMeFWKokvVSfjwqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOx7PVz5YhhcJgd01przvgFzKoqMePPD5Io7oTR3KtA=;
 b=IPWJssBbea7UlwPhIuQjPe9asdIp02EhAdGy7ISHF5HdfmGcZVnC0qXpQqk16zFIWdSeSnPqZ0wE+6OwrDD63BKBkhVJJyZ4kSqli7TgS5boxpI1kDA7zQBPg71ioVCHQ5LyEjq0ehGHtOaGKdBJXgGALESqhr4KXtLIEtH3PuSUL29Uo5QclZjS9lYMOYGePS/6aDtQ+4MzYntKnN1W/CbYgpWxdG/4/tJ+a4UAEoiS2fpI6YeZgWjYOb2z/iITjAejgSSpwxbqjuCUaazmO579irSDQa7uZK27a9RW1YqHNLfAbM/Wkv5sQcw8jqamHzO138HrL1tcCk3jQUi0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOx7PVz5YhhcJgd01przvgFzKoqMePPD5Io7oTR3KtA=;
 b=B7boxor59h969cgExo0KzQxN+fORBvdp2PkAQf5ohVCQHQNx47se4PifrnkEbCr97acM/7++MeWOh3plsta8f0cyTut8KRqSjCGcHLVXWq3pfEekFEpjHVHIGxIeGl0HqFY/WjYViIzTMZIOmSHCe3Xc4M6tnYCIABcHXwQJcQelKUZ7OhW2xWvwGBi31lB4A08OEvC//8o/VBkP952eMjUoDtizdI7nWn6s3u2zQAlJdkkmnpW1XTXWpKnFYYVoeOnB/HbttwvB8yD92HgHD008UyO/t+B+BvHLORchq8ao7uPjLBZebAEnPSkIA23ouA9UTnIOEcfgvnfixZ95DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 18:12:53 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 18:12:53 +0000
Date: Mon, 7 Apr 2025 15:12:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: shao.mingyin@zte.com.cn
Cc: leon@kernel.org, li.haoran7@zte.com.cn, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, agoldberger@nvidia.com, cmeiohas@nvidia.com,
	msanalla@nvidia.com, dan.carpenter@linaro.org, mrgolin@amazon.com,
	phaddad@nvidia.com, ynachum@amazon.com, mgurtovoy@nvidia.com,
	yang.yang29@zte.com.cn, xu.xin16@zte.com.cn, ye.xingchen@zte.com.cn
Subject: Re: [PATCH =?utf-8?B?MC8zXcKgQ29udmVy?= =?utf-8?Q?t?= to use
 ERR_CAST()
Message-ID: <20250407181252.GA1763135@nvidia.com>
References: <20250401210730615ULucEmQClX13Q7svZwHsD@zte.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401210730615ULucEmQClX13Q7svZwHsD@zte.com.cn>
X-ClientProxiedBy: BN9PR03CA0963.namprd03.prod.outlook.com
 (2603:10b6:408:109::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4cfeb8-a514-430f-4369-08dd75ffd092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uqSN3g9dGwDCOIL6hc86QytTaLMGP54QtFl2Xi3AFmvyEK4cdg8n11tRqGVY?=
 =?us-ascii?Q?eNCRqmQPifUytnjzj3/Y9if0EIo6irlxf2Wo0sHku4H8FBhTDb2pcdGT3z2Q?=
 =?us-ascii?Q?wy3i+bT5Uvf+5jx+aNSMlB7VrStOYinUj8U/vNvJ29RC7c1aTtfeOZJwBfRI?=
 =?us-ascii?Q?uz6sEGnSeknPYZTLC0ylxSF38g9aehSOPFJqPU2t+pKOPV6Ukz9godKV9dM6?=
 =?us-ascii?Q?thu4Vt3cywLDFls1Fld9XwpeVw3pf8/IOItO85pBKEJtdRuUX8G0d4CFWldO?=
 =?us-ascii?Q?1GttrZ9uXeQQUrKto2EMgjQ3YwUTQuB8eZDRiszsWVLItKUAIsllPyGs97Bq?=
 =?us-ascii?Q?p82viD6QeFzEDiRaYcxd9/GHVb2bVvBTUpLAZ5ZVG6JtylJ3s/Lwt4E0ZXXo?=
 =?us-ascii?Q?TOdhFnTKz0tNISoRGXP4bRtexO73s1MG092gMKBsjnqi+7ZNa5x9zryz+Nka?=
 =?us-ascii?Q?jZxaVWPjcMXv8vQlIzfyoHy6kvCttoybNAqbBRm1WIpPlVGI5vXq9cf8Nt9q?=
 =?us-ascii?Q?FlMsXvFsZ3wWI+gN674lZKoUtz8VjZrdBdpQdDffE5r4rOvKE3BMgZRh4j/C?=
 =?us-ascii?Q?hP71DSabD+hZ/WHblqUb6APTq1irxItp4a0h8kkl3jxmRtaXvNq95RUsxjuY?=
 =?us-ascii?Q?1mAXEqZXS/ENetp2O8XBufDkGZnqwSyJBlh2olzYzP2NoHJ40DEIp9VI3OAx?=
 =?us-ascii?Q?tMvLZzE4NUw987Sl/T9oSyba8hERFTANc90Lvnwa+5Zc3QQV6lK7TrGRSzIK?=
 =?us-ascii?Q?h77BjWG1NcHUowBvCJZnEAZmx4qGJzRSwuhVEaTwKYxbQHGjO3Rf5DcvsZkv?=
 =?us-ascii?Q?vfxprQE14iiyEvmSkfJYzR9aVkh7SznCtpM6lQ4osd+cPIkXMgMOGuNsKFUu?=
 =?us-ascii?Q?DDD6o0ckOw3DCifjgPxFUKzdbJrqPqm/iGCiZHUqjJJN2lVrz3sLB0mv2mXK?=
 =?us-ascii?Q?OTiC/D1ZVJIbKqkuruqldbQeLaPQfpQk1g72VPurHUrCzu4G75SBFvX487zN?=
 =?us-ascii?Q?VWVRVc/stB5wl4RnZP/hcIahCE+GbViRswsRQKnpLvJ7nAVGPd88Dfn+cUOz?=
 =?us-ascii?Q?ATDoV1vQuDQi+yLIxtxGz70HvT0htOchLQmgg+412nT++m891Z7H4mXoxcTk?=
 =?us-ascii?Q?nOS4t/4iG8FMRiR27MG81dv/hvQ7axxNFZcXaqNXQogt3Nn8hDZUZLwVYdJz?=
 =?us-ascii?Q?hecOa2eLW2g6qkfdW/SpWNtXHtdX9xdOKxarbJFtl+rH6vBsmGAr4ohcPXSt?=
 =?us-ascii?Q?Y8hlmYRH7d+C71zLafbO9RVR9TW7fghXeuu/KebTGKjuzrwUVGbmBS6WXCz+?=
 =?us-ascii?Q?uK0WKXuzOVbwVpp98n291N97Vy8+HptLwbvb2rdWK+60unHuCPE5ZbesjV9z?=
 =?us-ascii?Q?j6hQfqu0Ob96/Rq6cZf9ZjFJOOof?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xvM5AcqartIgWF0IrFE35iRCrSACKd3q8iV/S1Btnl2yeZm+0X4WoPoizbOZ?=
 =?us-ascii?Q?SgmEcH8fS4Ub1MyDwmHr5hN0V5qLk0UTilX+tJ9yHrEGyAbVbwc6U8brOAOk?=
 =?us-ascii?Q?LLhtOFFIFw32QgYCTRweQeLhv3ca8BPg4rqtyu0WnVUw4pzo9/z+WOh8o6mj?=
 =?us-ascii?Q?W3ffsPZPY7o1I/eqWFgb7w1FqeJXpGx/sVXVo2pgybcUxpX242B8H5VCtC6k?=
 =?us-ascii?Q?Rz1WYruLLAMjvdgoVy0EU3XioTmofyl8+ncPeWmJxJ1p6uNko21UCv0DHuWb?=
 =?us-ascii?Q?f6Z6AkMLaKUrZqsU9VXdGz5QlPIpJcBVUC7PqIQ2GJvpC/YLPy2OrwqRWzDX?=
 =?us-ascii?Q?MHsQSQ238rlrURVhPfofu4Sv+L65CrDehYm9J0PxsYvG2lxPqN7xkO4TmsVl?=
 =?us-ascii?Q?G3ulndt76Dqb2Db+qCNbLoByT5pyrAU/B1BUypLurXIQpuoVt//OOg1hLeau?=
 =?us-ascii?Q?lbVq+rSC8zuGyAVVbtcKi0KMXJvrqzs1eltaONTcaIBL67TiDk0Q9ldOOUaB?=
 =?us-ascii?Q?g8d4rHmxZvHfEb/zqEuX+ShsrA1D3fMqRJKSLGlPh0PNKISm+udkRwKNokIm?=
 =?us-ascii?Q?kLVhr32N7wrfBi/Ha3inpcwe30v6XwvvD0VutWov7pzx5FAuQstdOA9sfXBf?=
 =?us-ascii?Q?R+LmUMaBE4Kjbdp9xKPuN+Dvd8uKImAgHvX0AltVFEyfpKR1Q7cxcd34/ds7?=
 =?us-ascii?Q?arYG82cliQO4MlG+HB6wNr07bV5RaBsb+BNm6gsyXVODXxohHkqO/9/Mi2ke?=
 =?us-ascii?Q?K9tpXPRz+NiznRB0rpmBT44XzPlL7m54DAp0mWsSt5TJ4lvqPbmzIWkdLRWw?=
 =?us-ascii?Q?wIrSi6pc92xPrLQ3YWFYxowrOmGxU1UuTh7aLHsXIC0z1QvHpamqvbUY6h0Q?=
 =?us-ascii?Q?HzuLQJSwFnTymfO48Nc6oNFI/BKIiWUymVjwf/0q0eK1kOKRtpXbyyx9qp42?=
 =?us-ascii?Q?x76iz1F02Tt2Cejy+yVTMQqPDIZjYPG4r1cRWtVArcrZa7TCiwKTPOL3fIar?=
 =?us-ascii?Q?XjElbKRMhLSO+c0dkA6hh0cdUpIa3eC21K1cfgEEsQ4UcmFSbs5vQaLIqUYi?=
 =?us-ascii?Q?dhTaNuVC/KihCVlyJ/coehqh6V8Gt0yJORFXlpxKRCDuoozW3F+XQ5g0gNax?=
 =?us-ascii?Q?4wLhruexL6kHVzQ3lFoxkGLcwVdV8gqW9cBmhm1gH8ZxIT/DvIf+ViwIC5r7?=
 =?us-ascii?Q?2YuV6qJLaZNP8xQTBOTJUHunXo6e87yPWdzh/NCLbJpee/J91IBTLkxuo5+J?=
 =?us-ascii?Q?1mLgKb9QCCwqMlmF3flsyBpadrgO4le5kGmRLV9hBp2CynzHgtFHiKN5qiZb?=
 =?us-ascii?Q?9lvLl6ui568Zfb0FXf+IAcphov9bceawM9DA8RMRBWAgbEdk3Ge0W24REs/g?=
 =?us-ascii?Q?e1r1D0xi/9PC4K/bOcqOZgME5SSDXSdbk5n0bdaOKYot4dzGjpNI4pc8hzfl?=
 =?us-ascii?Q?lWypWaYrGqt/0nywp6dZiICrElLm/hC3M72QrTu+U2F7XOsABVQoyvrqnvcW?=
 =?us-ascii?Q?D5g82ceZnSinoGlwt0bpFED2rok4zm6foais0C651YcYRXcjdVPgxDA0Bc5F?=
 =?us-ascii?Q?LSuJ9vtAWk8v9S0lg8HFRQNT3pJy1Km+ltW/yrv8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4cfeb8-a514-430f-4369-08dd75ffd092
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 18:12:53.5788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9vZ6Iir1GUBktvT4B96a3Y/YyDEEyFfgtbGRpTnhygJ9H9GluhgGxYs7k+WUZcK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033

On Tue, Apr 01, 2025 at 09:07:30PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Li Haoran <li.haoran7@zte.com.cn>
> 
> As opposed to open-code, using the ERR_CAST macro clearly indicates that
> this is a pointer to an error value and a type conversion was performed.
> 
> Li Haoran (3):
>   RDMA/core: Convert to use ERR_CAST()
>   RDMA/uverbs: Convert to use ERR_CAST()
>   RDMA/core: Convert to use ERR_CAST()
> 
>  drivers/infiniband/core/mad_rmpp.c   | 2 +-
>  drivers/infiniband/core/uverbs_cmd.c | 2 +-
>  drivers/infiniband/core/verbs.c      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason

