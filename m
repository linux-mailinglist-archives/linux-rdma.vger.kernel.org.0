Return-Path: <linux-rdma+bounces-4079-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF8793FB4F
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 18:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4F11F2273D
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 16:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87D918C35B;
	Mon, 29 Jul 2024 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rVOo4FoQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA25A18C347;
	Mon, 29 Jul 2024 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270515; cv=fail; b=IJqOc9kcCVYiYY9g1wYgKrYdpu+RxVaz4fwEmPnaqaPcAegJ8xVNYhGFOkmQ6/J60eSxF3OrgPFK28PlRy8ShDZ0//1GplWFhAMeymLiWSHxwcYkn8BdsKHkaLoFeB0sda+iwc98q27d5wb5Sclc6Hv8Mm2j0wbJhBptKJdUPO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270515; c=relaxed/simple;
	bh=V84dLsOrxey8WOBxJMmgQ1ZiSMH+xZ3j0Ze1va5r2hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rw0fX6K9LTQ33UyiA47btYmGeSV2fM5yOS7M1qO3HG9vx2RR9e9hRJCymfIswtf3W3TcCV910PB4prHPXSGuL2NZQZsKaQLoJsSBSxvcCnNntmFYWI/8og/raH1of3gocHgl/XCu0jYNJ2fsmNCJu5TMMp8P3NsKH88spyS/fqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rVOo4FoQ; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBrGjy3DzAwJT/V0XrK+CsktqLPansIZlE5m4K04+ySbCywER/LQ39Q9ZcrOFB7WX5/WaWhwN0Yr+DlajhPNI/04x6g0Xo5ejRS6/ZASmW/ziL8qEt/y1Mz8k61s+yuNWROWzgpv95ozJ3wwAPokvTDv6R+y38hjtnWyW4MvGctgsStJVy6A29K/XJ/kXUc9NLa/lfSGkHRO2ChoVdRUj4DSrP/oT0zJCS5EkAhTeKM5SlEt9X2fxG7pR7sxg2mdkABPmDoANxEY1bB9qEAJEX5Kl6KMnItQVlA4rJE0pj3tU68f6ON/LiWMF0x8/VcAIwq9DThhXl4RtEPQ7S8xzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kcCIxXuEJw9ZKt/ExARkz9xFV146CAv+5sAcDA0mQQ=;
 b=PtPqDYaoif68R3K61DcFqYQ3sAO9dKk6nSNKxmV8N+3Ol88IE/dlPDl1kYCjHsp6whG4lLfiC7f0H4+6zDvzFVU1aOT5MD74tAJxVdPPMJ23ej8Eg3Gu4N2Z1wCa9Z378f0U86u9xqum/AT4Igey7BHrf3nV6XRjg6gAhKxUB9fAtovcBsiookcS2w2K+wNxJyJbK0J/RNjYeESA5dpAHRHPVLUqHEqrJ4HpcyFogQqTuaSrWzG2AO9sz9GZj/bvmPTXdp1GIwPrAnnW7aKVXndI0Z9K624NmCbi9/jW0BM2PLT/mOOBUGxKsCvAVC+wN4XgCKrAWCsYU11b7RonVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kcCIxXuEJw9ZKt/ExARkz9xFV146CAv+5sAcDA0mQQ=;
 b=rVOo4FoQyshDUU2eDcG57SFWqOTd8oS7F1uhWKTO4qA7sXgTpKfrboel1jdMZzgRmKuUDUtuxoNdEhIntnYyXwk++SYc9VAuMPKD5AEDwciFhZUhQYj4ZAeNNgVfKmbFwKheP2p9sL6IvbCrOkUdNnBOJ8qWws9zvE2H0J4GDmuA9ZkNQzkMV2fmAgkM54SA9uxqVUIThOnUt9N6h0Y+qlDA0eVUchcfIkfirkiYZSDNw9qAxWThSEYmbWWmbuyKWEVd/POOurjPpEerylF2FZ8+PMXAMfOi3ZbyW+b4Vb7cNgJQrtSZogHYN9NkgfZ9W2BhjStrTOVT0TSpo4HFPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.25; Mon, 29 Jul
 2024 16:28:20 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 16:28:20 +0000
Date: Mon, 29 Jul 2024 13:28:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 5/8] fwctl: FWCTL_RPC to execute a Remote Procedure
 Call to device firmware
Message-ID: <20240729162818.GC3625856@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <5-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <20240726163009.00005d1c@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726163009.00005d1c@Huawei.com>
X-ClientProxiedBy: BL1PR13CA0102.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::17) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: b82fc2ac-6aee-4138-d68b-08dcafeb754d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G5gMUjsUJzgazmtsDYgf2CgRYSRdwFuOJUU1r4Wb/L8+8/pqfHl4pGOjsyWT?=
 =?us-ascii?Q?Mx7YeX/U9fRJ50gVv8xxUv+8FdtOjx79jtcay/GMTWwFoKvCf6XsHGOn1HJ9?=
 =?us-ascii?Q?Uqf6xjM/T09iBweWP3BS8LoSNGp0MoGnDiMDDlDCvRozBa8GCkrjJCk3XSLJ?=
 =?us-ascii?Q?QwkwM7BlLBABXaC5G9o1XcGvcxUSlcrnYb2/tgVo/IIEWiiI+YyUDRjPN6ll?=
 =?us-ascii?Q?cRztJC//lasBiJznMSi1iam3vdYwmR+RTtxCSAXWs4oVotvdz29rrVf99Jxo?=
 =?us-ascii?Q?YT7hygQTor2vSe/4UkSuF32ad6xYFjXJNQSPfBtTpgmBORIRNUI71pa08KMR?=
 =?us-ascii?Q?GPcRfjzm2UVMAQ82mpf8dJBwp+fH+bilyae+f1cnVOsefoFHUatSypwwmRb+?=
 =?us-ascii?Q?ib8Noc7TeyScrx59wOj0ZaoJKnBHp0DziAhHtc4PFhG4pNdqrQvlPADn8vwG?=
 =?us-ascii?Q?fWRq+b8G8hQab1nzDnN+szKSINcaAtPU3YzXSo8/qezfmJdn65xtAVZnBGYl?=
 =?us-ascii?Q?/bJ1BFaUOHP/ZY3c/CQ/9ReFKybN+InK4nI51POm5aM7GuggJKKs8RLGNdCy?=
 =?us-ascii?Q?oIo0XJA3usQBTGBqvQAfEh5kxx+xU7MhMX2TDpVcH2HDpxATcDi70jw9rvKn?=
 =?us-ascii?Q?qxnNsBFqXU0AjrZEsLN3dx/cvGu37rUsn9QQnfYUvnrkWuZJYtDoSixtZpM4?=
 =?us-ascii?Q?K0JGZvKd+GlwjCgklBsYMR4T6gTe5H8zSWN0LSXaT2y0X0yn4Sa8Tokp+6C6?=
 =?us-ascii?Q?ZyYVRxTFGhlTuFiS8Zf4SFNObOMF/qvz4qLuv692jtZyTAlpSaih+mQt8NYh?=
 =?us-ascii?Q?F7Zt7kfvAP0v/mjZgBL4qMmyTG3zOGzZr14accYC8gJPSGjFI4rEdx03zmDy?=
 =?us-ascii?Q?qMjO/IgJ2C4XfJboakOkIh4pAaBwG0m0edUu5hq5cAYSGIVR/ucA6qUCQ5+J?=
 =?us-ascii?Q?pCS+GiC6WuCEu6x0wzOyatbK7R3tGWur+/sVFmbGQPEdqxxJPdX1F0rR1t1U?=
 =?us-ascii?Q?AX25yb1JFURkIi36fmeJReUq6a7+/bJomIdx+hv1cti0r0jf7l4wxT1ZJc2i?=
 =?us-ascii?Q?WmPGSI9G5y/jpHvxgMlXuXo3KiVkyi/brx7wSO4iYbXIlGU9gZysQCRZYSPA?=
 =?us-ascii?Q?OFmTWMN1+Vrc/SXQEw9SlWmFSrWJwFOT+aawNfpqrNnVXXx9pPYvt/K3L+Cl?=
 =?us-ascii?Q?Moz0FpxhJcO3s+PaULGV0boaJ8ea6P+EfefUXuoHisaivoF0KecJ4bwKX5Ii?=
 =?us-ascii?Q?hQh6J0jdu/JoXW58nj2n+nJ8LKS2pi7N+AekRE1LLJnll2lODW8ER3+cIonx?=
 =?us-ascii?Q?415cF7vgpDzbBfiQChig3qO7gIMH7CF7bkeN9rY3dOz7Dw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iVrVBv9hwSxg7nF+YGAhbS7MNyEnWod580Mnj18jLDAgbp6kY0ex83/uPd+Q?=
 =?us-ascii?Q?Bt/ObsgdLN36nOurIWK/AAMdQSjpItdpJgBe7DfTbUzH2xXGrxDrCmpRWVe+?=
 =?us-ascii?Q?7LjKqfVAjAEVvI8pEC0atKJBVB0KALih7HEPtJfc3X9WrUfmxt0UjJSppFwJ?=
 =?us-ascii?Q?O9+zI1HtgY5tJsxCP+xDpIa7Pa8VbTav48ay/4Vy8qSCB6kDlKjJ1bHEMAzX?=
 =?us-ascii?Q?v87TpO/OgYUn1V5DwYzAOY0s7CGaYoxU4Bicr1SCxIQpI4SxZSak+hKjrEbU?=
 =?us-ascii?Q?iQYbEwL2GhoZO/lovDfrl3JNA2qR+P2ggVCJQl9hF/rh+gi/oN0DlKXZJeIN?=
 =?us-ascii?Q?uOiEAzqb0+/IJHBb21ZsmNtG0MAdxkvT2ExZnmjanWWCGbUTzm/KE3qsUOTt?=
 =?us-ascii?Q?hN9GXhlhs/Pl5C3e29L6HPmX/kj4mYIrNj6irBOKc3CjC2tkXv6FsLQrKyVX?=
 =?us-ascii?Q?Z5PM3xZ3eP9Oq1PMjO08yfGevORw47ISGxP2uPWY0FG+yAwCbazrsEv2SG23?=
 =?us-ascii?Q?6iXY6/Esj8L47QNcMdKFgoDvWAsjzngZhgywVrQXWr3fljmQnUNHaDRyAHK4?=
 =?us-ascii?Q?/hVfZPdrB3cBIK2P6pE6oqGkzgjfAfjfLDSc/Enus/imKdQ1WUC/ash7QnaS?=
 =?us-ascii?Q?mTaNOLJumyrikINA2NelPbTrl+S3zlT7XVYz/oSZqAIZe+298+jbbkaqk9u3?=
 =?us-ascii?Q?2orCjJ9E0o0jjPlAk6BT9u6QnmZxCAslm6mg57FE2kkYakEJqFuTUTFpDx13?=
 =?us-ascii?Q?U1RI1Qi795hc3aP7SXpT8Szq9pJJQvPBp/w9gLcJfoctpfdHjOgkSIdsPFwe?=
 =?us-ascii?Q?VUVqMDjpejsD7hLIxpxmNBvz9il6bebnrEve/Jlmu9ItKIpWQg2K4y1qHx03?=
 =?us-ascii?Q?ZH5AvM6501ir+RqkX8dvntWSOULuRvnnDwOolWO81HiujP/94co0lXpY4X04?=
 =?us-ascii?Q?gm+T8J0MwSzkIAoRPyRvimmZiTPmboIaTEOdM6NuYONwu2e/JhoMd2DLf6AM?=
 =?us-ascii?Q?rq3hYgORMLNXY8hH3DjJmvvqPaiMaM0PCD8LxEIhHZhhBCsDU0VWDg5STBzC?=
 =?us-ascii?Q?/Qgm08aF+3FLEd0/dEJwukNeAK8oOhhFbHVhHKuwxtQv8CHNzzfPMz5e/WsD?=
 =?us-ascii?Q?W6c0q1nwY5hAgFhTtfSVEpSjEiMQVXNPosFJwEuG/C72y5K9BEcgp2M5yJd0?=
 =?us-ascii?Q?5xsQfPIEUhtjAXQ1mb2BeTtV+DTKSwk6HNUHMDvYYZVKoS+vi8AnZ3C4wb7W?=
 =?us-ascii?Q?bmye3yPBK93pvb/aFccGlaLXCvwFfDH/2wk6Ur0/BorsUGawHvsR9bq2/cBf?=
 =?us-ascii?Q?MLKaZitKM/Vndb+cZhFIh+K9Yo2WoVjrVur8nAu2tYmet4DtyZFGHNUPQ62F?=
 =?us-ascii?Q?Ie7ICIFM6zVNiJlZtH/0HINHtU3vlA1UlMpWDPeJ+wnVWzBSIvbpQh9iavzx?=
 =?us-ascii?Q?8GKgQD2VwgA9ZEjwPcHypaxezy8oWIO3H3wse3PkwKx5083keg4s52WpzPL5?=
 =?us-ascii?Q?uquRV799HAMxrZYXzvXsOVFXQIhmcLFvUkQI5qEkRQqc6wZAcLOCidf7z+hA?=
 =?us-ascii?Q?EvLhUAPfQFVDgpm+P1p522fiCS+k/XvhUQ+8bAbD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82fc2ac-6aee-4138-d68b-08dcafeb754d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 16:28:20.2126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tm2UdASxqdkl4C8f+SxCrJiKAWbSGvZwMLiooxUr/nqtnBtMSiO4Ef8FHDg5jz3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785

On Fri, Jul 26, 2024 at 04:30:09PM +0100, Jonathan Cameron wrote:
> > @@ -8,16 +8,20 @@
> >  #include <linux/slab.h>
> >  #include <linux/container_of.h>
> >  #include <linux/fs.h>
> > +#include <linux/sizes.h>
> >  
> >  #include <uapi/fwctl/fwctl.h>
> >  
> >  enum {
> >  	FWCTL_MAX_DEVICES = 256,
> > +	MAX_RPC_LEN = SZ_2M,
> >  };
> 
> In what way is that usefully handled as an enum?
> I'd just use #defines

I generally am not so keen on defines for constants.. There is some
advantage with clangd and gdb, for instance. Enum is the only other
option even though it is a bit of abuse to use it like this.

> >  DEFINE_FREE(kfree_errptr, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T));
> > +DEFINE_FREE(kvfree_errptr, void *, if (!IS_ERR_OR_NULL(_T)) kvfree(_T));
> kvfree define free already defined as this since 6.9

Ok
 
> > +	void *inbuf __free(kvfree) =
> > +		kvzalloc(cmd->in_len, GFP_KERNEL | GFP_KERNEL_ACCOUNT);
> 
> As before
> #define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)
> so don't need both.

Yep
 
> > +	if (outbuf == inbuf) {
> > +		/* The driver can re-use inbuf as outbuf */
> > +		inbuf = NULL;
> I wish no_free_ptr() didn't have __must_check. Can do something ugly
> like
> 		outbuf = no_free_ptr(inbuf);
> probably but maybe just setting it NULL is simpler.

Yeah NULL seems clearer, the outbuf assignment is a bit too odd, IMHO

> > +	/**
> > +	 * @FWCTL_RPC_DEBUG_READ_ONLY: Read only access to debug information
> > +	 *
> > +	 * Readable debug information. Debug information is compatible with
> > +	 * kernel lockdown, and does not disclose any sensitive information. For
> > +	 * instance exposing any encryption secrets from this information is
> > +	 * forbidden.
> > +	 */
> > +	FWCTL_RPC_DEBUG_READ_ONLY = 1,
> > +	/**
> > +	 * @FWCTL_RPC_DEBUG_WRITE: Writable access to lockdown compatible debug information
> 
> Write access
> probably rather than writeable.

Sure

Thanks,
Jason

