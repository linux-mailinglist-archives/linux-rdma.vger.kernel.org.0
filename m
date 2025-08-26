Return-Path: <linux-rdma+bounces-12937-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 029B8B36EE8
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 17:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF4257A8D1F
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 15:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F0C30BBAC;
	Tue, 26 Aug 2025 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pDyWTV4a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCBD31A552;
	Tue, 26 Aug 2025 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223490; cv=fail; b=Op/5wXKUT6fVH/6t6C1mvPR8j2SxvzHLe2feGeaK60A6qLGfVtFSABs3FdR3xKJn7k58ilPP82DOGUVROzP3PWX2Ki3LBHTH4lw1NYk2vRdk8KgN12NlFw+ygDuj/vKLrbp4cdprF8OnSjlFUHtyJSRGq39BG7AuiOP9YGFWrcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223490; c=relaxed/simple;
	bh=5jXU/rrzD7Vl+v1hd+cQNEckP8kwR3OA3hz5ufhk4C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dR4dshcaA/GSdvJlshK8bR9uHWLzrVDyBwkG7DAtoifZPnp+INPn3ZL8a+CwKPBieQ7egzp6Np6cZ3F9aqA/o6AiVuRxw7aGeS1qRDvkyc82IIPy9HjIIiVJHCPpqfI7W7d1+8p0JqNAEDJteCsBvF8XQzk6PwrK0QH6wAnhcB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pDyWTV4a; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hobbBPf60/x53xertsQjSRaD+5VP6A1O9akzvgTMy5QsmmvfJYi+/BVH1bkzpcVGzkL605Tj68nGotMJaW4yvnXhXs0cqrLDLNVsxYMSJ1ZDpqGSTCMa2GlP4oaR+7j6hOppJl9s3fzUG31n4MBWxspLXqLZQDI9+F5KWYm3LpGvEgZyDsqp2g2+c786g3Ha2HDmMNtzO6jI/7bcG0VQjUn77C3cHAlIUOTjRERVUajFE8zqB3EzfpnrxoCK+LB/KlBE7/xAkhdZU6WSkAdhGFnUwt1fWk2QgUcyfrXyN4P3LKv+TenlvP2sItG66bPJ5wKo5x0RI06+tDDAkY/gog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WhjpvQmiaJ6R12K7mn62R8nmoNEX9wdfL1HW4qHkLw=;
 b=mgmB7X8s/PLsCfkEDnpKh+B0UwHHm3gbrRST4J+l9d6WIc6Vr6dr+pOAencA7lurQcGo18+vwoYIO1OBN9nS3jNzXZ1skHpSWQUXA0JLoch6I68EyN0fmqP0OgsvYs35S31+6lMoVp/qtFiKj4tvzaZQUfyisdHCreshQiKtPUk/b2VzmFxf3xxdG8L7uLEfrPw22D6ccssXsVWw7NNudfZOCPSYLnsZ/n6o9lSvpVkf3C6IsUv28k8g3IaA2zhiFjMVoG4f/30OV/YWzzK/kXfR3m/71jo3cEebypJeS47IYuRxR1MLkmLJ8XBRqjxyj5KkwWLkEjq8mucAs4+qwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WhjpvQmiaJ6R12K7mn62R8nmoNEX9wdfL1HW4qHkLw=;
 b=pDyWTV4ak7qF1CLHPmh1azLwGsrCANtfuZXzejYhjIziebgbzgIAP723c9+hauXG4OO/Z4HbmXYNUhdKjcFQTZ/z1wZ/zFxVZcl2Wvhvmh24FZh74DevD/o5pl5Q6Bf/jsB+uGkxo5xEeBHuDHDG0urEP2s090wbnxArEO/3yIeLU/gA+2y7GiWpdwlFYEaRJrEG7rEVofZPj/S0yKl2HuxobdO9NxoZTsquo2IX+CsfTMCSkY18hcJQmVGDLt0O+8YGymKoUMQZqQZO6wp94cB1rE2i2TlYKBJGSOzHupfPvmzTZ6tYZanXTzPxAvNw0PjL2CuDUR4f8OmauYWplw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 26 Aug
 2025 15:51:26 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 15:51:25 +0000
Date: Tue, 26 Aug 2025 12:51:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, leon@kernel.org,
	andrew+netdev@lunn.ch, sln@onemain.com, allen.hubbe@amd.com,
	nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andrew Boyer <andrew.boyer@amd.com>
Subject: Re: [PATCH v5 11/14] RDMA/ionic: Register device ops for datapath
Message-ID: <20250826155124.GA2134666@nvidia.com>
References: <20250814053900.1452408-1-abhijit.gangurde@amd.com>
 <20250814053900.1452408-12-abhijit.gangurde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814053900.1452408-12-abhijit.gangurde@amd.com>
X-ClientProxiedBy: SA0PR11CA0105.namprd11.prod.outlook.com
 (2603:10b6:806:d1::20) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|CH2PR12MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: 41bf396a-b107-4866-06f0-08dde4b869c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2kraajjBlt9KmFRgz4495dZNPpygyJv079O2t2hVAUET+GwqgpCaaJi6NUpq?=
 =?us-ascii?Q?2bZ9r++xBV+CB+LnVfnxjQsoT+9RMHllQN1woYoY8hcexI8A72GH4+I5t6bh?=
 =?us-ascii?Q?83uycJL7dc/AX04eHUBPNR0r89J68HzAtggo2AT/31PUoe8mFBr49HKz0K+v?=
 =?us-ascii?Q?MUW7rzpObC+r6lBg65eAS5FpPfbZ1R8CU2Xrv6EhGw+6eYHKbVG0oM8fNt3k?=
 =?us-ascii?Q?MtptPHSusPsUZWYD7kTHCx7W72oIxOviNiuo/eVFxy+aZ+hpAp3wb3iQrnLE?=
 =?us-ascii?Q?Py/8ZjLMcB6WUG/29O+SoYwMjAie1GDn1Z56lDNz91ttgQXE85JEABwhj4fk?=
 =?us-ascii?Q?pwD4goD7UEIKkp0zQ7QyavocrabCd3thc3hfHlyErDFerMubAbQxZqoesNWz?=
 =?us-ascii?Q?yv6srXJmcCfkTaeQTjG2rdyjf3YjLXQLvU4kYMrvCI2kaifRazRpRHqS8CpK?=
 =?us-ascii?Q?9vcRleInHwbb8LxSWLOh16wK/mCRaBh5FI7PqIrv6B/ixlwKy1UK7VinHKWI?=
 =?us-ascii?Q?OzKDmdxjqCUkZ0O4aJ5DqYQYj6AN7R7rA/uPsDUAOTTXz1Sk8Msoppo0Yj9q?=
 =?us-ascii?Q?gmNxK3cubTPZyLuke3I4/0aTwBj/LP5l+e+JHWIAzRBL0qSaOWqOAf8bRM3E?=
 =?us-ascii?Q?honvlv/nsk12TJUlTRP+GR1llOe8PYWCQUxqmfrkxINW3OtxYmgt6kyACsAc?=
 =?us-ascii?Q?3iDiysWO69XxC5vDDT+5iVfh725HzAEarLKl7Hivyic8HeiGtmnwoLlWDSBf?=
 =?us-ascii?Q?wH5+TVcE7u1BkeBLtwY3MfGpWK+Psbo9hNB/bV+9MrkfZTRHJ+MZn5CprrvE?=
 =?us-ascii?Q?o7Z88kc3xKTgwzxUjj7BBVFCbIbKRY2B/UyQU/0eqDVJ9lW0IwLM1o63Zci4?=
 =?us-ascii?Q?ZKUWFKdY0i1cZQK0/NHgxdsve/tAablzPw0c7P1e5F9HOLIaTi3vQftGTXAZ?=
 =?us-ascii?Q?gAi+9bpUFvezK8lg2rXhbNm7mNU83E19A69CXrFCsEXZi52BYOOyd/JzS9Nm?=
 =?us-ascii?Q?8j60OIm2X0e+COgkjajbv+/nWDzx8kzyW2qo90aoGSixUh8eURpaEBANVJB1?=
 =?us-ascii?Q?nRzjPEYEeWs1RQut7+zCGZ+3UMGsT3vyXGfWXdqTc61TjMWYObTuoTLjgasa?=
 =?us-ascii?Q?BEzscndnz9AugoNQPey1/1U6r+h1UMYqZGVDOEW6qMP2lbHhIvFLJNgNgQ56?=
 =?us-ascii?Q?6Mu9pAUws5PK3o0ZHQ9bOomu88Y9kzrzlZ/hsCi4H3QcztXPird5bWOxlkUq?=
 =?us-ascii?Q?4UUk/UoctGqAokN3FY7fC7sMFaFhMg53FtJgUTKHo1wh+7S90lCIfEMVhUeT?=
 =?us-ascii?Q?eg07qSjKC8xEtYD5fZ5FDoSINxY5B18ovUgiiNF5XuYVmfZxKNFwre3aCEZE?=
 =?us-ascii?Q?FwCLtlVhwdDczxoFcwlfUETCUKsnK4e1K5+U/je4OH/cHeApqU4OGg807oWY?=
 =?us-ascii?Q?zLscwptcxcE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vl1Wg4zk3PIuThu1FHFjB3uJDUMvL77nHqiTouK9gwG8kn/+FkaO1HnCQq1E?=
 =?us-ascii?Q?snif5JFIXGdzLfAhJrHga4v5yR8KImPVVX3kqP2/OnTpyY2ADOpDz3tRGKfI?=
 =?us-ascii?Q?WjemogO38aLYN7PkYFK5/6QmpdZUn9BGGQw1s3tVvxa5qnAhFRaxaLgjPeUX?=
 =?us-ascii?Q?4SwAc18Rwbo/+op5SvYeLSTHTFVkmQkjaoAY3GisnO8F41aaDJwr4pd/wCxu?=
 =?us-ascii?Q?MN/x67gNM+JDGd+Fm4aq/+Kcr1yqJTc2JqflHaNRZldSendtcdMwb5LC31HE?=
 =?us-ascii?Q?SeXlbJdTdNr3G9XHRBcn92MPCK6YYAb/nzNyklGDQMRAJexS3LFlApCnXo7/?=
 =?us-ascii?Q?6itTgkb5Sso+GJcc6KZcOUVE3vxLFIfQgMugSGABqYE/Pp8TKn5M0agcEGup?=
 =?us-ascii?Q?vR3lkUD8FCHQufRJ44g7Uc0Y560laByA7LSvJb0vuVIhK1ytDufj2rkVwORu?=
 =?us-ascii?Q?98JdZQVvzpe3bHtq888Uu2gwXDHUhcJ91qDnpXvWpeEt193fp66zufD/qXK7?=
 =?us-ascii?Q?7miSm+0GuWHojC9ULPOat5blN3TawDTvfwg1s0xtW4d4pWS1tmVv97lywwod?=
 =?us-ascii?Q?tM/6Pv53LMqfRmzMNz0vTtgxRIk7j7ylvLq4hMn0YL8l6T2Fgm/9h5ZEDeFW?=
 =?us-ascii?Q?OqwJ+zQLYGqNBLoD7nbC4PrmJZUXmaqsVaXRRxq7bYA3ji+Vzgj4twBkiNoL?=
 =?us-ascii?Q?ulHppktkBYdnhqRWmhqKD+vNG1Tfnt8rO9YWbO8/m7RXHGnt+j42IEAeZD1h?=
 =?us-ascii?Q?ExVLriT+mkqOeEKyYVkdh0rvmdujPZigf3pyZxI1kRM7lqUoA7BjteZja0O9?=
 =?us-ascii?Q?0Mnuf2sgYd5F+wa006CGpAXNb19lTDNuvHYyvQmeW3Yrhhsa5wVUX1iDIZ5D?=
 =?us-ascii?Q?4lX9MIP501o87LJApJMy4TNOFqXkmtkWZ7z7MX1lp1XUh7TRxQ1spwzzPhHW?=
 =?us-ascii?Q?rP1kM12p5Q+m5ZSvIAXE9krtMCsv3Z9xOVEHqT0k0byAdpKxqRMyW7q2yFyO?=
 =?us-ascii?Q?BPHgToRoBzwNczXlubt+4GopO3YlaNrO4XCB2QshXPYju1K7G/li6pSayGVT?=
 =?us-ascii?Q?vdsPCQ6/6BTDyy32oFo5jaa6XdLv1UkrZ5xpH8LVraMxvYcqX9FS3s4OhwU+?=
 =?us-ascii?Q?oW5l6btps5xs/8c+rdLC1dqwmKpW1WjCgj3DzKkZ6ptKWxNCsLu9+gqovC7f?=
 =?us-ascii?Q?UzYOEBMCGd1Vtnqe2Z/R4h9NPmAxu/hgFj9MKPJEisGTUK7CoCqQqydc5eNg?=
 =?us-ascii?Q?8pt38M/gJFYA0vCJt/J8VbRoWrY/Onsn0Y6KRwJrvM91aJaVgAIPpIpnRkwB?=
 =?us-ascii?Q?rFnwav7QxwEx//9WOhDrFJYaG16Zj68lFYSyyNMIGPGTUsKkaUORrlmB02Sj?=
 =?us-ascii?Q?tOMap2NGdIOh1bcHC2ClsDeDf1rRgGKX5ulkAojBkPL4SUTKAYR6qnXKFx5g?=
 =?us-ascii?Q?Bxc9hIktV7QbJ6Uocq8xmMMPZi/+TZtUFXdfOVowsUdPmjLOrQQfviEl6kHy?=
 =?us-ascii?Q?fp9JHMyeM1ahfpPL/we7zj4NEAd/4NVuM77kEatrFfXyAnQeDLO8k77YnP84?=
 =?us-ascii?Q?94NDbSGG6zMoR01H9F6iLAM3E4m/xUuykjKeshX8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bf396a-b107-4866-06f0-08dde4b869c0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 15:51:25.8509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+37ISo6aniIGAaGLTmwAQ27btfAm+mtOTzCl3lCW0TiYB6uyjmCfJJ5XPz4iZ6q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135

On Thu, Aug 14, 2025 at 11:08:57AM +0530, Abhijit Gangurde wrote:
> +static int ionic_poll_vcq_cq(struct ionic_ibdev *dev,
> +			     struct ionic_cq *cq,
> +			     int nwc, struct ib_wc *wc)
> +{
> +	struct ionic_qp *qp, *qp_next;
> +	struct ionic_v1_cqe *cqe;
> +	int rc = 0, npolled = 0;
> +	unsigned long irqflags;
> +	u32 qtf, qid;
> +	bool peek;
> +	u8 type;
> +
> +	if (nwc < 1)
> +		return 0;
> +
> +	spin_lock_irqsave(&cq->lock, irqflags);
> +
> +	/* poll already indicated work completions for send queue */
> +	list_for_each_entry_safe(qp, qp_next, &cq->poll_sq, cq_poll_sq) {
> +		if (npolled == nwc)
> +			goto out;
> +
> +		spin_lock(&qp->sq_lock);
> +		rc = ionic_poll_send_many(dev, cq, qp, wc + npolled,
> +					  nwc - npolled);
> +		spin_unlock(&qp->sq_lock);
> +
> +		if (rc > 0)
> +			npolled += rc;
> +
> +		if (npolled < nwc)
> +			list_del_init(&qp->cq_poll_sq);
> +	}
> +
> +	/* poll for more work completions */
> +	while (likely(ionic_next_cqe(dev, cq, &cqe))) {
> +		if (npolled == nwc)
> +			goto out;
> +
> +		qtf = ionic_v1_cqe_qtf(cqe);
> +		qid = ionic_v1_cqe_qtf_qid(qtf);
> +		type = ionic_v1_cqe_qtf_type(qtf);
> +
> +		qp = xa_load(&dev->qp_tbl, qid);

Why is this safe? Should have a comment explaining it or add the
missing locking.

Jason

