Return-Path: <linux-rdma+bounces-2051-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC0F8B06EF
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 12:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BEFB1F21DD4
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 10:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599F81591EE;
	Wed, 24 Apr 2024 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="xEyyAgaP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65E11E898
	for <linux-rdma@vger.kernel.org>; Wed, 24 Apr 2024 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953230; cv=fail; b=EwNVIQBFHibU0f4Q1dxtgryrW3tUXN265LkyBmzoKOYbhqqmAyJGGK/lQ1/TWsW4g+Fmpnb2cmJuzl9CjLWPnNPGFUZA6NdZSKZ2SO2IBQZlxck06AVmjKvcNA2cDWfUxltWjcKnZZv2n4qxUFaWBa5ZmC18eInxE7xoHgGkzMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953230; c=relaxed/simple;
	bh=BJ/JbwfelBWcDAqLQGVjKzff+rbIFAULhafesVu3FxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=afatPkkooHrFLrHJ8ZjnabN9P8WpgN2RbC3MZxcOi8aYlXMjriNMwrNQpTSfeNF7dxMeVxelI46gdlXhd/3Bz85vwYZx2gzzHd1Le0z3lZ8fGk1nMiBugtuqHPYwG++mofv+t3MwGrJuOz+LHAGh2mdOeI90JQk4M7nQowlQbTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=xEyyAgaP; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168]) by mx-outbound44-94.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 24 Apr 2024 10:07:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaFUDbnFkXxwYcmdwc6FIdm2NVXpLWKyL6XyvDSziJvpeCV37fkoBISMb4eHKOVyBmOQr5Zpr+OTEJFMecOQPVsnUHDuuetMXceGKOBzskdvMv+XHNZ/3JnO/JeVJprpnemcpYKuoIDbO8lRpWb41XvgI8cBIz1N6YmCkgofhu9TJSnnZoX6smgce1SVtqGdYTzBrLGHzH2Q4p7YkUVP5ipkvK2VFunqggiiqZcQJsLaicxBfscwd1PPKCySCTFdZHXbH3Y5hdWzy7c5IBcQx9cWN6j1Oe6+3g0efSqjBdt+pEs/wOqSgKGJkRPABT2wZp2h03YlkBjt0P6hWxQjYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8sgo6rFPXJU/Ov5xd3P4pEkP23YWAw/53FBtAhbwHE=;
 b=VM10BhgfXM7FM/emhK9ycpjGC3Z8yk7y/DA+DnuDslaFxniQqB4XYcxQSzjOtwgtMJxRKTqPpBgE+ZpRT355b2flnAjQbjmpZXJCnYKTiNfsxJcQOJ5mLQk5bcN8+fjgQkatxD9g7Gy7crXbyRZ0aUrtIJ6EZHtsihZcjUeesDr55EGcnQaSyrEKVyQscq8i42suDkTwssvoupz92c9mI946OZmJd1mF22e72xwYhP+oHmjCTZz4sFPhwjDnt0WocPzF6Jtcytx6BQhWkxRwIMplsdX0toNSy1X2WLa1lXkFRlpRoZ4otgYXM0rJ6ouVN+pxwFkvRcUgtRQUv4CneQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8sgo6rFPXJU/Ov5xd3P4pEkP23YWAw/53FBtAhbwHE=;
 b=xEyyAgaPR3CjOU/0ebxioII3fbgTXrOiaT556biIdej6dUxXpUL8x961cjYYpVKNGej6qEd/JsBlokwQwly77JOd29sk57KTNgo7+KzGtsxtbYGW7rBeRkJGtQZxoZfvtHJmV4lMPM7tCn3kn303cQm9w1lY2BKflvs6WxFtK8w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from SA1PR19MB5570.namprd19.prod.outlook.com (2603:10b6:806:236::11)
 by MW4PR19MB6770.namprd19.prod.outlook.com (2603:10b6:303:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:32:39 +0000
Received: from SA1PR19MB5570.namprd19.prod.outlook.com
 ([fe80::956b:a5db:c859:cfa2]) by SA1PR19MB5570.namprd19.prod.outlook.com
 ([fe80::956b:a5db:c859:cfa2%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 08:32:39 +0000
Date: Wed, 24 Apr 2024 10:32:33 +0200
From: Etienne AUJAMES <eaujames@ddn.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: jgg@ziepe.ca, leon@kernel.org, markzhang@nvidia.com, shefty@nvidia.com,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"Gael.DELBARY@cea.fr" <Gael.DELBARY@cea.fr>,
	"guillaume.courrier@cea.fr" <guillaume.courrier@cea.fr>,
	Serguei Smirnov <ssmirnov@whamcloud.com>,
	Cyril Bordage <cbordage@whamcloud.com>
Subject: Re: [PATCH rdma-next v2] IB/cma: Define option to set max CM retries
Message-ID: <ZijDoVqOo9b6mgK7@eaujamesDDN>
References: <Zh_IGG3chXtjK3Nu@eaujamesDDN>
 <700c19e8-ae4f-42f0-a604-9e33a9a94dd3@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <700c19e8-ae4f-42f0-a604-9e33a9a94dd3@linux.dev>
X-ClientProxiedBy: LO4P123CA0153.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::14) To SA1PR19MB5570.namprd19.prod.outlook.com
 (2603:10b6:806:236::11)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR19MB5570:EE_|MW4PR19MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: 161cd3b0-daa1-40ed-fc32-08dc643919e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MRr27TT/BOXf8d2KTTGAw2T84Ys994suQOp3KYb/n7KEVoEFCttdidySkrXu?=
 =?us-ascii?Q?q+rlC5I26RpjDJFVps/qccdTjaP+Lp+Xd78qfDhpydvJiAx3hmrFTu3KMU6O?=
 =?us-ascii?Q?//rrrIpULLhNboWHlX3vme5C+bO1Nbta3qXZH1UwoyKZlN78ehoZZpUD/BO1?=
 =?us-ascii?Q?aThAEre338JqgEQ8EST4uXvIJIEThIb1SLDxsZilWsjbKWsW1JH+X7gSKqHp?=
 =?us-ascii?Q?Q7Q8lrGBKvmxwZLLMOylABihtied3HlDL63yDTHeHNITWpdDV8uEw6Glz8dt?=
 =?us-ascii?Q?jW23WXY/gmBnEyyxlSGI3eboUt7WkmgYvkqdGz6hUXz7xNstWxhtUvceXpoQ?=
 =?us-ascii?Q?ZlXvW4DbYzegxlzVi8oNoO5g8MouqFaQyih5ok6e2rGFYqQ6HlfG8/KFcEDU?=
 =?us-ascii?Q?YQOE3Wn3WCZl+obJ1HY4LLkU1smg8VA2r55oYXJLKKUTQ7lpUFao+BdG9k1O?=
 =?us-ascii?Q?y5Du/F1N4vOrfiWeEGyiEZg5Ub8j5IV5zhRQG1SiKFA7wZUzJ4pCnDtHfg+w?=
 =?us-ascii?Q?ejy6BDk2crlYBf4Iy/2Uq5skF1+m/ptxFJYDvi+fHV7SYat7VDCgr/3exxHt?=
 =?us-ascii?Q?dat08vnrS16UGPZZGTbdKEC2K5JOn5pB//qO1/GaNxClNcy9Gkl9KBkEV6T+?=
 =?us-ascii?Q?AmGxj8+cP5jQnMnPDX+Ho4jl1U+TaKlwO53C+JjTzOOAZCO4dWtAy6DOJXQn?=
 =?us-ascii?Q?WVfaIICD0fLs7YlnZIMzLntJftBHcz6inN959K9tUXcPO4xCCk2mFgc4Rf3b?=
 =?us-ascii?Q?YQojLOwhIY2rUklt5p09iyB7bB+hGCZ3QY+DeiEmAvP42issawWS7bQwEv9r?=
 =?us-ascii?Q?0IgS4deAp9h64YT3W99i3HzRSUoMNUmeHDZHkFVGYy9y1O9wbdeDpTTt+q3Q?=
 =?us-ascii?Q?fiCVMWrxUkEh4SUhp3YWYj/hu+C5GE/9aVVjqRyDigNceg0nr4D+Nx12KkEb?=
 =?us-ascii?Q?H1Pf+M6aoCOAI2c5TauTLAGun9m04Dp9YUgQnfp9I7auG0VNIeBrcCQUv/GP?=
 =?us-ascii?Q?fwzCvpo1n8NdI0XArIKye4maNaynVSfilvJ8bM9WZ+tEKufVdMKevzw2i57y?=
 =?us-ascii?Q?Hf4DEOOS8iZlsSkFBD6/mkjvs++jj+RtkTAZFKSSndHOQNisRqBnCxjHXQ/V?=
 =?us-ascii?Q?XBy9Un/mGMN7K4NLMDfmmqMUXV/wia6R++68DBfqKe6oUJOQCT4Pg0M5cJY7?=
 =?us-ascii?Q?C9Gjpb9+nwpeXEjzwxMsuXVoKxLQ5Stbo0V1Oc+w7FIBDrI5im3Nr1gWA68X?=
 =?us-ascii?Q?vQNxnM+CkJmb2mAOUhylj3vK0pbOp89z7TTFtSBCSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB5570.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uh8Ji6Y3jiYKUzqsUqEvN2a/eFMMAm+jietrXbQ2CjThQKp/8vUL6+Y1MT6p?=
 =?us-ascii?Q?bPCM8P+fMe1dCeqrC8x76kgETSB96BrS7iJu5PQSB5V/T8Wvb7zoiHcOiePx?=
 =?us-ascii?Q?7/W0bNGHhWeIbKIZma0Z4zX0/zB3Y5JSXBd7qIxErn9ijah7E8SOiLvUtv5m?=
 =?us-ascii?Q?Hj2H1dBJEUgYfOuwIJm2PqRIslOQfD5Nicq43LpMsiDlGxDxHFyaGr+gC0Y7?=
 =?us-ascii?Q?iHjAQYP2NXQ3Lj8bZU489Ba/Zlrtu8/bkozE55PNtJsvMZSP76lVn8alCIWu?=
 =?us-ascii?Q?X5VdFYR3rJDGma3qOe93dHzgCLrTwRVuV99gdCknesxGJcCXkQjATUBdjcQ8?=
 =?us-ascii?Q?/sSfK3LoK1kVo8y5iWfQlX4Lgl4nVnBFIRhv4zpA0TfM96h/IpVB8Gw2vR4a?=
 =?us-ascii?Q?sT6dapgFECEu8J2HpCylxFV/NXCXesyl2BOb14BXItrTKkhbMppMow+nSrIG?=
 =?us-ascii?Q?sb4Ew4z/+6CtZqS8tqzyTfRAYSqX0srOlx/fAf7Qn+9iwjheSy3IkU7yOHfQ?=
 =?us-ascii?Q?5qa2HAFzG1SjYKnPhlLYK9WafJBL8KsNSv7IledYqV0dyYWnof51amlzfCSW?=
 =?us-ascii?Q?JvNjkXFSk1xA4RCit39bINEyLhxiTCIbR6zarumHU6MrpIQqQU5+1nxt7neJ?=
 =?us-ascii?Q?FrpRwTExMIUfwMvzh0RWRHakun3FfdyVP22hF69BtsnxeFPC8SxTF3S7UwXx?=
 =?us-ascii?Q?fFC14RaHYP8PKIaM1BGfl2DQiElo6mbLJH5LzpRaN9N06AE4GaSly9hFb+yB?=
 =?us-ascii?Q?yN6tckFjPB9+rLLtm6gufeTru8hJVd659N2+fg5YDsFFaQBhJqRVdbY9CaP3?=
 =?us-ascii?Q?Fsk2MhkCAWqINT+S7ZZ/8vQxvOQRpUMpXQfrwQUnVRha02TVZ7oowARO1rbY?=
 =?us-ascii?Q?24AyCyZaBIJFlVUdnHPGcHl68bhhQH7/bLuwi5SKbmE25jnxG4iAqfZlScZH?=
 =?us-ascii?Q?Vk+XmRcOCsGKnT7706GWsw2zqtQyCwSu3h4keeq2OypcYtVzo6cdI8GvaXT6?=
 =?us-ascii?Q?AiSRrKMvYB1fK46SKLLpT5oRrWGTIvEEpa1yNx/7rddQlhGB23ZJAavKAYU+?=
 =?us-ascii?Q?VFhVKLAP8AKjXzdvrAwNY+jYprQIr9bov/KHLp7RjMG9H6h8tIEBR7qXGtiZ?=
 =?us-ascii?Q?BDeWUFZFOMMNzuDwkkwrApisFbLGUSCrb8n5RDvTWOzWHW8b72xnTNd0FHOO?=
 =?us-ascii?Q?9Xi0kpJm/EtzuKnWfmtip8FXJ+jFSksnoKc17FTHgn8A5pM4Zs2ElySfV7Dz?=
 =?us-ascii?Q?RAbf+prvIYzUej4/vxCT+PvKBpcBxofWrWe7nw31CyWaNNY3tFSZYY8NhNM0?=
 =?us-ascii?Q?bej8d+Irj8UHwC3EkC6sf7Ip+qUTFmcudrrhBK7KJkocTVkTRov8ZDm6q9Tb?=
 =?us-ascii?Q?sSjQFPGc8tmc6wi6GJxw0UWpA4FN1BzRp2cpFjZ0/918j8HJaZE7WFub6Amy?=
 =?us-ascii?Q?+mjBoIwoV+MwuNj5FB4Dh9HN1eN92MfOEu6cLMuPmiCIhrm4RiE3y4z8Jh8B?=
 =?us-ascii?Q?IHcZ+82kwfVrcHcYRBl6LIySVKbCoBOcTnhCguHcCLg7r8NGlPOJuOPhzNlx?=
 =?us-ascii?Q?6wARVH0PDEsI9gPlYSYqd86b/c9kE7c6s6b4l3cw5Vyg/2pHovu0ZYPOy1FO?=
 =?us-ascii?Q?ZYZ0nEW92km0qjHu3m9rzpk3xQevQFCo4nYAn2LVzDcw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lR+ffdsuA1NzqB7yyxqW/SFBomD2Gr59l4+if7cLbzDnx18m0nbRAP1/ZVrCcRHxSiPgjkuC9D7jXJdQbTjqo3ADE0xV33wvGxkX4zehHnPk+YgP4yWL9XZwRARIvhvNFN4ZtlCzMLLBzid8PZJcaQ8Cs5oAIbJsTW4IhCnEpn8wEk2shCv83vDCNN3DrhGOdBW7OW9MdJHRRv5HS+kRTPZ+FXySflEEfYl6aJImFfzLyl6QGfSZTbzVt5z5d+Q/bzD82IRA6+xLp8VglBj9FQWvlWvmH6rei0EeKYXS8kmLNYi0AInVrVkR7fDVSecUaAP01iMI4dOiyl7D3aM4C0LyJG8pMkEZYz7aegmmGJBs6lLUaw9dWPoIanQ3Fd8x/Sdy2PshF/6t2i2TcyR3lu4Mb8gDcnhIObtydJK3G+mWHDZXzpdbLg/FW0TJQKz1JDubYa23Slo6HKyKtcSzB6UuNQGjVL9AxYRgQfLFBPbrZWhI4kOrRIbY8u3a55qzNVpxZlFkAZGNdfEDanOlkcX+b+lcnmG7puF88jqlGTEYgoOtlemEjNeERks5KF67862780mbibY+etmxbAa1c8uE57OtgB7ZcbwdSVo0ytif+wWHBSgOkrrT3W6xuVpnyK14nAyfWLjmyWfvryvIMg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 161cd3b0-daa1-40ed-fc32-08dc643919e2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB5570.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:32:39.1208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9jEuNLoQOHXs64PTaVogLJPZ+czrbnCrQsJX74GwwFC6+X2PU8JpyDB6FJ+UtKv1ExcLnSbjTLKuYCF6YHtlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB6770
X-OriginatorOrg: ddn.com
X-BESS-ID: 1713953220-111358-29929-11845-1
X-BESS-VER: 2019.1_20240412.2127
X-BESS-Apparent-Source-IP: 104.47.55.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmbGxkBGBlDMMNEkNdHSxNjM1C
	DVzMTA1CDRxDQxxdTI0jzJINHC3FypNhYAoxvhf0AAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.255786 [from 
	cloudscan15-40.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

> > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > index 1e2cd7c8716e..b6a73c7307ea 100644
> > --- a/drivers/infiniband/core/cma.c
> > +++ b/drivers/infiniband/core/cma.c
> > @@ -1002,6 +1002,7 @@ __rdma_create_id(struct net *net, rdma_cm_event_handler event_handler,
> >   	id_priv->tos_set = false;
> >   	id_priv->timeout_set = false;
> >   	id_priv->min_rnr_timer_set = false;
> > +	id_priv->max_cm_retries = false;
> 
> max_cm_retries is u8 type. Not sure if it is good to set it as false.
> 
> Zhu Yanjun
> 

Yes, my bad. Here, this should be max_cm_retries_set and not
max_cm_retries.

Etienne

