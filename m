Return-Path: <linux-rdma+bounces-1908-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F8B8A1BE4
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 19:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9EC283048
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 17:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D049213A24E;
	Thu, 11 Apr 2024 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="MLZD4NAW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2016F13A24C
	for <linux-rdma@vger.kernel.org>; Thu, 11 Apr 2024 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851499; cv=fail; b=Lqqa8gitp0wCtq0Bz3c8tZ/48yaflA2DYNE7hPPNly3DsvlJ3OUh5D4ShIIRmIW8SuuRNZWjR3fLpaNxIxdg/FUDpiIKLrhAJtN24Nvoyoa4/wsKnUFiWMHpyZdO5FcADHaPBg5+T8QdW2he1gY0W/Q+7Az97QGZalaEDTRox70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851499; c=relaxed/simple;
	bh=KX+yrCp8DOr5E41SDepzFlfk9xTMHPN1P5/RNyjMPs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TD7vgF1l1KaHG0vUgZB4LHnw9KBhZSi2rjt7BcSrd96pMYnn6ggRN1MXeWQ+OxKi9QfQ2I63PeN03xkmb0aP2BsWj5KJ3hQomv0f2IGQrJhJYz5SBNxGCWHBz7fZpiyVRnWBvH2p1WGBH/C9VhFnBBrOBMhaAKS+lxPsAgyddEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=MLZD4NAW; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101]) by mx-outbound19-216.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 11 Apr 2024 16:04:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDCRxYg14JO7TjGMf30UqsoSoESQRyvKmsS2k1IBT9ikOh5Ib4qFMKEScjO7yII+JuWSzmZwCDS3zpYjEAvwTqrSTh+DGzDZYDsGyWxKZoKczGharGpdCvggAlMZV99L13YjbB4UMZnEZ+gF/6VnUtlIl4VmEUsdssCz3LiaF0VR0/lwHQrI9q2SzaPWBb/8e/jPU4BGni0mbeO2J+Y4/24GBRfRuRgYGz90yDDzK8oq2IKeRdVY80ANNHQWTBHnESk6gPMF7N8YT2gRyWhJwTT9ME4yaFIAfESnYHx96fTJb9sZqDdDeIqPS2UyrQrtnZ0QgdtBrtzgsJxvi/C0cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ng7+rUQEb//show2QRy6vf9yG8AlTbNvkA6dszA/qJA=;
 b=JEncqodqB0o5PvS+aYh5R3HOjcBzJ7yk95Or/F4eh2liHh5A25NaD6kMM+icL+ke2Bc4IrGeyPgtPoDvm2KM0/Vj1qFi1rDPzEGuJnnz6WVzwmNsLuB9VF7/tGSl+oqLM/+pDVCwSzFkbkBUhSUsC0TE8UNyPB1pmi/gUm4DcZZadkoGl4pnQDjjJMJLjslocRfVUh99s9PwO4nrVwjkjq+hJL3iA/q/aYSpDG0rFii100dOkGYL1E9HrHI0ALAOkn35taF3sQTr+a++jKgvwePAlIFzx07LtguSvt/jkRyMKjESEtXrd0Jntd/YVe3m3+xUuS0YvdGCIo8n8/yguQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ng7+rUQEb//show2QRy6vf9yG8AlTbNvkA6dszA/qJA=;
 b=MLZD4NAWaSRqBCuAK7VXSmR9F8a83hibZKAXok8qtcbAGhnS6I5afJ2G39QCbBHOSCnDUELVN0sLyQW96adfFBth7/8QMN42E6HkJwQ9eW1vX4QufswndH+LBP9iEdmUtelvoGv4UcCGJhWd7ZLF7Oa8z6dGUnlfEDznMBs0AGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from SA1PR19MB5570.namprd19.prod.outlook.com (2603:10b6:806:236::11)
 by BY5PR19MB3812.namprd19.prod.outlook.com (2603:10b6:a03:225::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 16:04:25 +0000
Received: from SA1PR19MB5570.namprd19.prod.outlook.com
 ([fe80::956b:a5db:c859:cfa2]) by SA1PR19MB5570.namprd19.prod.outlook.com
 ([fe80::956b:a5db:c859:cfa2%7]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 16:04:25 +0000
Date: Thu, 11 Apr 2024 18:04:12 +0200
From: Etienne AUJAMES <eaujames@ddn.com>
To: Sean Hefty <shefty@nvidia.com>
Cc: "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
	Mark Zhang <markzhang@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"Gael.DELBARY@cea.fr" <Gael.DELBARY@cea.fr>,
	"guillaume.courrier@cea.fr" <guillaume.courrier@cea.fr>,
	Serguei Smirnov <ssmirnov@whamcloud.com>,
	Cyril Bordage <cbordage@whamcloud.com>
Subject: Re: [PATCH rdma-next] IB/cma: Define options to set CM timeouts and
 retries
Message-ID: <ZhgJ_F7DEV_IttN8@eaujamesDDN>
References: <ZgxeQbxfKXHkUlQG@eaujamesDDN>
 <SN7PR12MB68403240EAB2777CB5D8AB5FBD002@SN7PR12MB6840.namprd12.prod.outlook.com>
 <ZhU9n-f4Zvjs5NZn@eaujamesDDN>
 <SN7PR12MB68400AC8ADF1F34DE78140E4BD072@SN7PR12MB6840.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB68400AC8ADF1F34DE78140E4BD072@SN7PR12MB6840.namprd12.prod.outlook.com>
X-ClientProxiedBy: PA7P264CA0211.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374::7) To SA1PR19MB5570.namprd19.prod.outlook.com
 (2603:10b6:806:236::11)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR19MB5570:EE_|BY5PR19MB3812:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eadd32d-2ebc-4172-b8d1-08dc5a410f21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0BpvmWg1pNRe1uAL/Mwen8wvUDKIBcn6ypAjYTyz3KFkrwMEAGOAHJeyfcN62eUZT7d4h2XzBcQyG23HVIqkpXGgMNkzubRkuBmp7uzgEdQle05ir949zAAPfIIvJ+RAK9nOC3hs7HCZGg3CObWSkgV+8Lk9Iq23FB/QiM9oXCnPYHesC84hflqOCXVqsogVUMxnkjPier6F44HU/1L3spyE5JzIX6KIwzgeRsKGkoCxr4eXLW7H3lh0OMFRGGgFuXUJQVws3hCFe+r8PceFJ4MS/UaIWolt2ti9feDU0s48ktcEKlD58JG8As7VLC3y2M3LiXTJffz3Ozh4SLTZoQfHj4+Iw8/NkW8QQUyF1824FGaViVkO6dCY0edo3xVmlmDhjU3cyTgaxhuZKHClwLF1G0i/dYTYoPOwY3KQ9g4VDQJ6OAGGQirhhKFPyAa8cQZwKIK9+6PpxIVzbW7w7D/QloI9Rvs3OGyjbTmfWkWPWa46SU5rdwmnPTrzCDIO8srKEBLPGoRX5BSvTVIRCkoElT2j53+sCvPKX0TFSjvepOVkQOjHCEOmJ1SWj68EWOKO6cOFd7SmvVBCj3jA6O+FISRqjX4shbqHUncD1aA+yYMNBMO8PzBe+nzGmzDgsEw6vDo1J2lgj/dl2ixHYN4zZDTm1SHPazZ3JfulhXY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB5570.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pqKdyuZXFwYWoTrlz4gqukK9WldfOZmS4tYmztRfTFoAxq9IVGmaichaMKrk?=
 =?us-ascii?Q?IdHmGfvfwURaWM0U3zPgeuZPI4gDX6veeh5TgZyw+ogbfYLP6piTCPjdDEMi?=
 =?us-ascii?Q?r0V5MfVsIFLHKNQZNjVSVr9XnpBvQ/nohgKOVKfnomImS+uNd/uJR9HphfYv?=
 =?us-ascii?Q?oAyQV5s0b7+Cbnx/4PQfufa3KPDaypzzXSjrwi4zDcoPiYGaeXxbtpE2noaI?=
 =?us-ascii?Q?QSoHTDuZRQ/eWBTX2cGbqsneuP3XavLH6DLfNKfE9gDimwpnAFGZRSKeX4si?=
 =?us-ascii?Q?K1wtaGqz4DCRM4rOCTHASYa5UUYLbs/SWmJIlNvdXzuLljWnFhF+7kNUKL5L?=
 =?us-ascii?Q?CtDw/8/SwO3xTMYVXjOBM8qzpvAH3nsYC62//71fepcqMeH0HrIKYAxgYwi3?=
 =?us-ascii?Q?Op/WaaXd4z5Sj0QVN7Zvy7ZCCtGrXbAH9+iPgUIkXUaU64tsLkMOK1ocuSg6?=
 =?us-ascii?Q?cTWLNSpdeJ0r7GwbBq7L2t2tTp7WSFFXCsMAnhPN+He+GZOdiH5hxNiGknxg?=
 =?us-ascii?Q?bnhe8VKgIWMpQUHYDJSXYS6kw3yRGGmT7kYgQTPIOcz28HhFhbvvshecYchj?=
 =?us-ascii?Q?xzljABOa6vYyoEm1/FNxQmz0OyHHB5G4kMGWymJeFJ+Hb5JximbHWEg1UxAs?=
 =?us-ascii?Q?moYkK/mfg4O28Ml74afYvvFhb4HwRe4hAz7GFv4O9mFJGExVVF29+OeQCV9O?=
 =?us-ascii?Q?wu+oycbNxE8hdJFCo5Sex0m9zLaLBPZg6Ga0gn0eS6U14pmTzKZPV7N82bzx?=
 =?us-ascii?Q?cX1IAFWOsTIVgNA/MHZN9Z6/bbeiAxvcSbXTtjEkpQWFG6rGt/+lM8TYVnt2?=
 =?us-ascii?Q?ccbYngR6rxQqwRmBt4Vn2npluQ7eV2YQ59NEKvZrJOFfEVaMODR0yNyFaY8z?=
 =?us-ascii?Q?bNVegrjAanXDaS9SKWmuNNvMwUvQMNetekIBhS8MPnT//K78d2Fme3AakiIJ?=
 =?us-ascii?Q?RuVeYcI7xG9xmGq92O1IU0MWPcmBlqd2RxxrIrEqRoM86fBzmLzC3iGsPGMl?=
 =?us-ascii?Q?/7Q+1o1TKS3SqoYuqrxfcLYIycRe6DflLatfC4FBuHCqguJzZVP5VfMqt5De?=
 =?us-ascii?Q?6Mq4t01IqJ1AZeSGTwuQEJWxrgcRQOWe6BxKuj6THM6uoBB0gAiy2zzhGooa?=
 =?us-ascii?Q?gDYVAvHGLCIC3fJG8lNi4EaS4B9K64wjwvr+MQnXWB1s2O/skiNhFFj+pUap?=
 =?us-ascii?Q?KjNynhtbKeCH2OQFy8eDn8KQvLtd1mnbNQ6rngl7dn474ppa3Q8ncw+PslxW?=
 =?us-ascii?Q?6h5v0zM+np6VIy5wHTgxcBZ/25kJb+3sI4gcH2woX23ncgPuA2s2K/0nJU8r?=
 =?us-ascii?Q?cRkc29YRTru+xOV42EHadoGABm3JyKsil8yL406QDRXP4X88Qdmyfv+htjLQ?=
 =?us-ascii?Q?hKhfuGB7qavbEBt1mT2aGwlA13/+MPbY7aULKq1TGV8vrFhyvCQ/GoAEB6Pk?=
 =?us-ascii?Q?Eb8yB4Q73OUVpncaWj45y8jMNvOAH2OKkMgJF5eosvqCOsnf/PAjIVqUXCz9?=
 =?us-ascii?Q?DALchzxnNls7jQsevMuoMC82IpIevkIEibBKHAMUaOcNhOuonuu5hS2baWNR?=
 =?us-ascii?Q?TPsreh6tVCEuR7hxlhafKKz0DmliaYSR1m1UBqUv+NXHv9ozKNw8tkLXBeaz?=
 =?us-ascii?Q?NeZU5bCXBNEKW5zF8uT1SHH2Kgju6B9GNBxCZpx0czWt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PAMrCvCu9ZjeIGAyrDDo47oRRyMkl7CQxiAoeTbdC/RrI1f3BW76MC8bxpO6+wjFStGHcleVMszyL9ns6G9YJ41jKfRKfdgB9Rs2610nTIs9mX2BqxEuu0v+0vPn1yeThq1SYBG3WBWOHG9WeMtkP2exre5WGNVm7fvuqjuotyIlR4xj3w7AkYMN1Eml/o/YUtq1E06B0piRE1/AG0cA6REEZrqpnXdxpb7iDZcHWA9DjzXFifEjfmnozdOCfzI1Y0Z1AjmyqNCNIqMdTNURglmn0D/tp8czbd4AcPbQdWVqe6FoZO2k9hjTfzeVQ1FlISFsXX2D8npeOCrCYBD9XSE3ZOB2zv71JnQUSEvk3cp0m9gLMAq0EUdWWqmkfksIkn/ALswc632XlkKlA60Q+0FX4vQWp+e6R9VlPJQq10hRbjobqnCHgUQfEU68ZhRiHCVaOM3hI0ZZcgw4SOVNhC+wK3BtdwtzNGY2hv15gpkqKDbVx4hZyMIzEBo6E2Ix3/Z/0Rh3Txpocj5AW5UNYm1BSQKuLBQuaFhOdaMGRJoifAGQJ30sgzGt6Xl10kRIwzveqiMjVfANQ65oXv61yS/KWkON3Qsw3KckEJ7J2p1uku06vhydKkGKSC4shY5xKmWyHc2Rw17YFkIXWMqUzQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eadd32d-2ebc-4172-b8d1-08dc5a410f21
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB5570.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 16:04:25.5440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hp2LPGfRnm8V22qu+Io7p+QDtVo2h5HiwqPnI6Qn1Se/NMmtOL95n+segVOJiJr6/5dRvrx5YxIyaidznuhg5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3812
X-BESS-ID: 1712851474-105080-12701-15133-1
X-BESS-VER: 2019.1_20240408.2306
X-BESS-Apparent-Source-IP: 104.47.55.101
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbGJsZAVgZQ0MzQ2MgsNTElyS
	zNwDDNxNgw1dLYPDHVMCnFyNDYwiRJqTYWADGrKvFBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.255493 [from 
	cloudscan18-142.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

> A backoff timer can reduce retries.  I don't know how you decide
> what the initial backoff should be.  I was going with what seems to be the
> behavior with tcp.  Maybe the backoff adjusts based on IB vs RoCE.

Ok, I understand it now. So, with a retries of 5 and a initial timeout
of 18 (~1s), this would make:

connect_timeout = 1 + 2 + 4 + 8 + 16 + 32 = 63s
connect_timeout = initial * (2^(retries + 1) - 1)

> 
> > I don't think that most users needs to tune those parameters. But if
> > some use cases require a smaller connection timeout, this should be
> > available.
> > 
> > I agree that finding a common ground to adjust the defaults would be
> > better but this can be challenging and break non-common fabrics or use
> > cases.
> 
> IMO, if we can improve that out of the box experience, that would be ideal.
> I agree that there will always be situations where the kernel defaults are
> not optimal and either require changing them system wide, or possibly 
> per rdma_cm_id.
> 
> If we believe that switching to a backoff retry timer is a better direction
> or should be an option, does that change the approach for this patch?
> A retry count still makes sense, but the timeout is more complex.  On that
> note, I would specify a timeout in something straightforward, like milliseconds.

An exponential backoff timer seems to be a good solution to reduce
temporary contentions (when several node reconnect simultaneously).
But it makes the overall connection timeout more complex. That why
you don't want to expose the initial CM timeout to the user.

So, if I follow you here. You suggest to expose only a "connection
timeout in ms" to the user and determine a retries count with that.

For example, if an user defines a timeout of 50s (with an initial
timeout of 1s), we should configure 4 retries. But this would make an
effective timeout of 31s.

I don't like that idea because it hides what is actually done: 
A user will set a value in ms and he could have several seconds or
minutes of difference with what he expect.

So, I would prefer the kernel TCP way. They defined "tcp_retries2" to
configure the maximum number of retransmissions for an active connection.
The initial timeout value is not configurable (TCP_RTO_MIN). And the
retransmission timeout is between TCP_RTO_MIN (200ms) and TCP_RTO_MAX
(120s).

Etienne

