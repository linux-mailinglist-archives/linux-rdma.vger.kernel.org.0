Return-Path: <linux-rdma+bounces-2202-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255698B930D
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 03:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54352829B4
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 01:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731EC12B87;
	Thu,  2 May 2024 01:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I4xzD8Fz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2C32F32;
	Thu,  2 May 2024 01:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714612558; cv=fail; b=ZAW80YSPCllCPbvEO1GqP9lJIDiMRLk1ZU84NZ1DuF6h88IVevbk2GmoItoBYp22yOdIyB1XCvfEXiqrK5ARKD9BVpOMdpIFHmaB+ZVCC4w1wE0BrDbOMvcEo0XciYhQTvXsbEMgeq0n5dS9O2TknGyre4XEq+J+L0h8z+evr00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714612558; c=relaxed/simple;
	bh=zZWEDxEVfahyhmX+oWav0SB11GgXU12KQxgEHsEKIAg=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=EjfBiWxhPMmexVpEbpoXxyM6rjgt5qmvxWVtlCx/VP5a3TNUOiTGtFPqRXJzkuU0qB8WkNRwMmUGxSBXdmuHTAiHh14+lHSgm5mxRDdv1cE0E83KtqJ7CzHGdimr745ZHRuBemr6Gh341MhBS++5QuwEcNpnPg6d7+w4hkexElk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I4xzD8Fz; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQPzOyU7EPoPadctxxFHP+Q8FgiVLMpMtZZ5Q78J70VbuX8OZP39cxPgi512Z+BfX2IBe9exRUhE0mRHCT11ItpG+gULLKirO/kGSZgxs/ULUAzI8EttIuzI8S1kj7kL6V83UyotsQM2mGkiNAcPVn84NwdzbtvSvy/qBfpNaB+bUipfaIfyj0eNgQj3yNgsYnR5Tf5ftXM9kfeWF2W25XdvqQ7WOQaXqUwI6t7EwWfgVzTG/088mXQ+Av+pffjrryS7LxDW1zCg5oXhgQHwEyCs9JcjEx333he7GkfjqSa7SIj5elbRk81m+e3Z7EGpaeL7xbxnnMAbargAvzrhQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Db46LSTcxXVrW0eWH2GLVHgDS6Tt7EHsI/0VtQ2UX0=;
 b=aklRFsqtg4Mvc2t8ictaN6P6hbW//fnyWFLOV/C1HIvhqEb+6nc/SzyCZTGkYGNPR7svbk+xMUFhbtzZDStCFhJ1q0oAiWVHg//7lkMlZjAh6RP7EfU/MdFFlvT6VRg2pxJVSTTj1VfjUH1y1JzMMS1FbfRdnUtECgMM4aWaWGuzSzxRnN3dRllB4LwnkQ3pEoJI1+popZ+oGmkd5D1cDlWywgfmZb+Eb2Eugg+osxLt5YzppNvB0qfgrHBM4wGRw+0WFngHUw3rItwetVRQKBiy6ZIqxdKpnmLkpjPMpOLPurJD6Q2Zpv+BAwM+pYoKDAf9jg/oF7/9ZRnrr+4lQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Db46LSTcxXVrW0eWH2GLVHgDS6Tt7EHsI/0VtQ2UX0=;
 b=I4xzD8Fzhsg9wdwqqZCFZWD4LP9ivDqg0t1QHAr05fAtt21edwoOsr3pwJl1E0KkNOIHtSOzC7AFx0+egPVPhWxtE9/AomlXokBmVWRf3cRRGhT9hei/obkzbkK1MABmRmMQiCzylfiUDFCTdElp2pTIQnLoYYX9pbttMZLzJExwn3bLSLKDtkAs9vqLsQ0VSOKZh1Gg2QT9skQGenznir3LqQY6Opeh+q+GJurkd5QkeGvvVinnbQC6IS13Uu83GpDid6FmqDY/OW0N6vQrubdIleb1HSX0416CQ2Pvx+mwdXdbCPZTwu4dRnwQeXcQQ41I+SzFf4DluaTH0qgqEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.35; Thu, 2 May 2024 01:15:53 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::80b6:af9b:3a9a:9309]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::80b6:af9b:3a9a:9309%7]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 01:15:51 +0000
References: <20240501003117.257735-1-jhubbard@nvidia.com>
 <ZjHO04Rb75TIlmkA@infradead.org> <20240501121032.GA941030@nvidia.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>, John Hubbard
 <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Mike Marciniszyn <mike.marciniszyn@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Artemy Kovalyov <artemyko@nvidia.com>,
 Michael Guralnik <michaelgur@nvidia.com>, Pak Markthub
 <pmarkthub@nvidia.com>
Subject: Re: [RFC] RDMA/umem: pin_user_pages*() can temporarily fail due to
 migration glitches
Date: Thu, 02 May 2024 11:05:46 +1000
In-reply-to: <20240501121032.GA941030@nvidia.com>
Message-ID: <87r0el3tfi.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0064.ausprd01.prod.outlook.com
 (2603:10c6:10:2::28) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DM6PR12MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df38e2a-4635-4470-580d-08dc6a45682e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1ZS+AJT6Q7Fdqt424Rd3dEJkMdQx+BqeGiawWU9FGozZnV2k1otCGOSHsrvb?=
 =?us-ascii?Q?2pRFndGCF8kygFD3KJ8YYuRCQ70c9h/n83SZWd7i64Z1k5v9HFkRbmiAh+PA?=
 =?us-ascii?Q?xzXbCes7fW9v47kfAKp34vEO+G63BKB2qCmLjWEeZUJhsu3RCYEA1yYBA4JD?=
 =?us-ascii?Q?7k2ckV/caZnTV3+F65srkiO5TL9SaJt/aYm7RReoDpPrg8xY8AOi6Hx4mrKV?=
 =?us-ascii?Q?pvGt1wZeQ/j/XAf3+Tcx/7BvbsFWhdq2BpSWJOTf/2FvAeCLAxtOePb/lNPn?=
 =?us-ascii?Q?04dY8Kr3/6A3HaUruIk0ayEwGjydvpjLcjSbkelS+QA0BD8O7+xpgFuBMjPh?=
 =?us-ascii?Q?kZUKY98H2m5yjzv2Q7zpbH+ZD3Xhu+w+ukBpKljF/Ym1uxwk39WaakrytBxi?=
 =?us-ascii?Q?nWP7pTuU27hD3RQQyrA/Ax9X2emjQlDYhPCtkC0pWR2LHp/PpFpSgcSThZcQ?=
 =?us-ascii?Q?pq5lrGjMcZ6q3XUNKN/K4PLfnZeuoUugZ37rb5eRnQhp305o3Fiw/rOTY9hh?=
 =?us-ascii?Q?G9YpUTHJPB2XCVoIfxV8YwRDeuSe39bKDzQfkWXXN95LM0Ntoo1LV/yJ8xMw?=
 =?us-ascii?Q?P6fhfDBJihMuCyZjvrcpX5/CxRBZ7yiVzL4D81q7pcjLeLOvAYOASL7hpAK6?=
 =?us-ascii?Q?jykw8n4fDDX1ZcvvIiTHVIk0KGswhoBdzZdYu7RL6xW5G0mvzHydI+H2Jo6F?=
 =?us-ascii?Q?fkoK2QzS9XlvACjBO0jEcLSb9YLDj4O7+Ch4/LnxRGuNp5NPzHGM7KABP+yn?=
 =?us-ascii?Q?KgeMTmwpicrYfA029T3cZ/eaHQPJWCuW6xuOMLG4U0L/at9c7mY8Zr+A8zdS?=
 =?us-ascii?Q?5jyY43jRB/CEmnyRsjrOJuq8kaLE35Q+dL/oUELIZAfFQ9qfeyQlIR4vkJyE?=
 =?us-ascii?Q?zEbzeDMjlxxS6z8rvKEOvHzZFOE+xYPvuzqPPYMGhvKKDn/KgcWE2mMbCUvV?=
 =?us-ascii?Q?LJcI+1LQvRbNvSaUU44ZptUEly3hJoQuXFreDqo2UxRvRRJnPqemmNA4YXUA?=
 =?us-ascii?Q?Xr6DGRYZcHRSrFKKaSFIfUiAn2VWtkPObOuNvorW7pX4A2rNuGLmFl0BCKo0?=
 =?us-ascii?Q?ZrRXF/OwhLT/Lrli6ngVcFZg1xtlQOBPP6U6V4J2nmvOOf9PRH6dKq+2jW8l?=
 =?us-ascii?Q?TW8LuBeGAiSUwt0NFGBeLAy4C6h5V//6gLXsopaTZhY00Oo8wE6Z2XPyW4g7?=
 =?us-ascii?Q?BEVXG3gaGzN/gUUhJeA1QSDusR6bTHdsvsOdS9QX20bkv30WCeIyqDmlFmAg?=
 =?us-ascii?Q?tymTsOtR8IqH1leWQK+XNRVQ921tlvYp8oYysBWMkA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tL5SS4eKB9Vlduc7yw0nsBG4eLx5U6e/mdh+8Ut+9qR69uvG05K2hRweXfGF?=
 =?us-ascii?Q?7sK3GDzJHeBaQM8PU7F/gdcMShKvIgDCX1ZGHldaOeHLvUI4sTNoovYiAIcL?=
 =?us-ascii?Q?a0jvjObcfpYTuPnefupUaTlEMZwQ1voMl3RUg/mvhetzYKM7qs+pUy9S7lEE?=
 =?us-ascii?Q?tn+y9wMqSzBNTwA+lcVabn6EQRUn1sl0MRx+czreBxoVhVOIU66ZItKsR0lC?=
 =?us-ascii?Q?GhVjvRm7WH/YnNbzLK/vfcV2vxdBasBNI6aGYvIz0hMzWSJ+AvmbhjnWF8zg?=
 =?us-ascii?Q?uTziuMfVxPHRwWLbSuR3wAX/nfONLWjss6z+t+dvgm552w2MlYekKD7KW2pc?=
 =?us-ascii?Q?lEGd4SgUec8+qe79R+OTxxPGq163x9e2NKjqpN5DAT6v7R9WVjqyKvdJinWt?=
 =?us-ascii?Q?ImNUl8tBsDoB11qAjWLhYLlD8I186nUnzcuC8MQ3YXzUU+Zl1fjlOla0O+40?=
 =?us-ascii?Q?rcfdHKJhsFtV6v+iBjSRl+de8Hq/jHRK2TAsga0NGzpnuwhRqkBav39GdUMY?=
 =?us-ascii?Q?2aOxphAF8bxmZOGuRE0tpI26ilJPn8tqDOiVe4/TZARZHYF8uN8tFvNrW+Um?=
 =?us-ascii?Q?RBn/LT4G3KKgHUm/1Eh1zoScLlHSHHxZbKnMuE5x1qAx/wNyJYIFEH5RkbUn?=
 =?us-ascii?Q?P4yRNNHJRy/8Ht72Buy0tdeFdaJDetdhj/bqFCBrYRFRw5K2XJ/DxeLbJRvE?=
 =?us-ascii?Q?hegsAouhHZftMeQAaJVkCrgqmq7iaW6lyl4MnYzGMFdvGVfavZUV0pdqe7A7?=
 =?us-ascii?Q?VEkNCfFP0ZU91SrRJ2TOVRSEgCOMLJpkEzicFruzB4DoFuQQSJnFXwtmfSWI?=
 =?us-ascii?Q?0+vZD8v0iFXU5CAc+uTLRJKnNqL7CmLnFbEIl26cEV6nD9aq/ic0RgQaJoaV?=
 =?us-ascii?Q?ZLvjYtO0aBKu10Rbz9p1n+6FTsvKlApeRVnJhIgqEU7MD/JBpuNTx8L+fXrY?=
 =?us-ascii?Q?qvZK1LWGl1+22apJGhJM36GzWP9xVdxO2YHrE97iYM3SKjh2iDywaSSm3UZo?=
 =?us-ascii?Q?mIwnPIaRCyxjnRnf5qnI/v0HnqKfq8MPnP/y6mdEJIdHpzO4YBS4LtJ4w+q6?=
 =?us-ascii?Q?aQwy0uL43FKXp7uDbbfybERCEmMr+FfCPnOk9WFGC0B21Mo4ciAFFS9MSeV6?=
 =?us-ascii?Q?68LMV/WMZ9wpZ645gli63+IOBPr9sLznehK2TWv6WPKILeftImLDqNk26vaD?=
 =?us-ascii?Q?iMLpZLbvTSb1rsPa7fr2UxVHKGSBlRX6A/SmCJzIJIUTXY6uj7W9aGo6uCjQ?=
 =?us-ascii?Q?LiwjMZa28W06C49lOQXA0wWAXnoyI3vTo6S44E0KK5svYMOYqvzcaNEBWS8x?=
 =?us-ascii?Q?2zOUcUA/6975qsQZ6Xus0c6QBJzhOn9kPg9x2mPizBn6PlVoOAYeQVbnKd76?=
 =?us-ascii?Q?w3ZWSOC+ImAMD3kyN80QJ2slpD1s6xzfbU1d5BkgGmPWioUYQl+hMDBLY30O?=
 =?us-ascii?Q?M37JPIIEovs/bP4SImu/8wGWH4t5cZA041IXJ58rz+oVL22eLB/1Gkw+adgp?=
 =?us-ascii?Q?oxx/kf+FlMlyoshSn3X7MDpFMS76yda8PYlRWI5SU0bW3rAtO1FGlAEdi0nV?=
 =?us-ascii?Q?cw5UlS91AjwXwR/nLn0Qr9tzPDgC2LntV7X9lHo3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df38e2a-4635-4470-580d-08dc6a45682e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 01:15:51.4285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jr/A8ATBP+mu5jt56wJOpPsR3ABGeLXJTshxeabHMVDoyxGo93KqRhwU5Rec19m6Wtu5yTqrMVj8MKQWfynO5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436


Jason Gunthorpe <jgg@nvidia.com> writes:

> On Tue, Apr 30, 2024 at 10:10:43PM -0700, Christoph Hellwig wrote:
>> > +		pinned = -ENOMEM;
>> > +		int attempts = 0;
>> > +		/*
>> > +		 * pin_user_pages_fast() can return -EAGAIN, due to falling back
>> > +		 * to gup-slow and then failing to migrate pages out of
>> > +		 * ZONE_MOVABLE due to a transient elevated page refcount.
>> > +		 *
>> > +		 * One retry is enough to avoid this problem, so far, but let's
>> > +		 * use a slightly higher retry count just in case even larger
>> > +		 * systems have a longer-lasting transient refcount problem.
>> > +		 *
>> > +		 */
>> > +		static const int MAX_ATTEMPTS = 3;
>> > +
>> > +		while (pinned == -EAGAIN && attempts < MAX_ATTEMPTS) {
>> > +			pinned = pin_user_pages_fast(cur_base,
>> > +						     min_t(unsigned long,
>> > +							npages, PAGE_SIZE /
>> > +							sizeof(struct page *)),
>> > +						     gup_flags, page_list);
>> >  			ret = pinned;
>> > -			goto umem_release;
>> > +			attempts++;
>> > +
>> > +			if (pinned == -EAGAIN)
>> > +				continue;
>> >  		}
>> > +		if (pinned < 0)
>> > +			goto umem_release;
>> 
>> This doesn't make sense.  IFF a blind retry is all that is needed it
>> should be done in the core functionality.  I fear it's not that easy,
>> though.
>
> +1
>
> This migration retry weirdness is a GUP issue, it needs to be solved
> in the mm not exposed to every pin_user_pages caller.
>
> If it turns out ZONE_MOVEABLE pages can't actually be reliably moved
> then it is pretty broken..

I wonder if we should remove the arbitrary retry limit in
migrate_pages() entirely for ZONE_MOVEABLE pages and just loop until
they migrate? By definition there should only be transient references on
these pages so why do we need to limit the number of retries in the
first place?

 - Alistair

> Jason


