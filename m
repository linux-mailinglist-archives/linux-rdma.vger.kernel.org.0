Return-Path: <linux-rdma+bounces-3242-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E998D90BBC5
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 22:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5E91F23035
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 20:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC0A18FC93;
	Mon, 17 Jun 2024 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nfR/7Wr1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87EF18FDCF
	for <linux-rdma@vger.kernel.org>; Mon, 17 Jun 2024 20:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655010; cv=fail; b=impZCmzSLfeuv6yUGKXDkWCvKOvgh5whewNrBMbGLKd/kkiKm53W7gVe1hFMpGlNb5W2zUhsaKpX45MuIn0bYNw4AFlbACxJ2XEKtQdEGFfWX7ZOxzFATIMwmlirAT/VMG/UvD3U6Rc6HfKIDdgRQkstWYwtWz0yMBBqpTTyx00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655010; c=relaxed/simple;
	bh=F2HeMU9pY/ccdvYJmONTyC8IIGZRwHGu3OIlKan/F9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dWth+qB6GgbcGMqhCMzMCxbFOD4Bcza+tBkM08fXl20H68W2MZRbTyU17qJmT4zqBrQGPVNbx0UkbP5WbooYzhTnfUMNHroMRD9wEPqnuJJ6kedfU0CRewanWH/bzjUpRCohHp+90x7gCenJwaxkIJ6b2bJJSxnX78Hkfg2oKHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nfR/7Wr1; arc=fail smtp.client-ip=40.107.96.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f65NFf8D+5lpNRZd0yQq4OpOXaWfipUhNV2y/vs9oNR+A1gCZ2FRwJQNXkTE8fCozLF5rw025zMa8G8b72k3yxAhLi6kwhHRnQ5NlGEuPyee8HBhLfyRmMm9Xgmw4f1fYUfANrR/UWzvA+eo2vuIkI0kS3iIXaR00WZjEeEQqGu+oh/MuNjo05wiommpuvZtgj4v5zchTNy7P8xTcCLDURzKlt5t1rpu+yN94BhNvaNi5ncM6qNuKR9jg8QFUDmv8XDLWWlBKERo7O3AqaUkZbiehU3RCW8ZkMObU2idufmGI5i4oiBRexksqr5vbIy48MXqzcwS4wV5uBWmDIuHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ef2qePhuqWxT+Rw5O722vvthIBpUuJvno3EZIaAfl8A=;
 b=c+R9rrVla7AgzD2QdB7CovZikqWM1y+mlofhBVr2Zf5xVm3PJM1wqm4tJhp6d3M6N8ZfpuU+zOtNRtkRQ12A0kWUQZIbZNPx23UPfPma5bxjJ/hAKWhP5xmj4P4pgubO61CH4r0QYiXAWlD8bHMqABIbAV5qtg+95PAjP7EdWEwz33scfZ+16rVk3ahXjZzAroWxDYGLP4vVV9Tbnq8kEARLp8lbiugWqbiRcjnHUa8nGJ2PmASy0RrQo5t7G7J2MOhORDR4OhL7tiOqrzCmCt1xmToubee/Zs1jksnI8fi0VcSfpxn0FYNlOVx28utcZ8rw4jmrbu3zTXMi1yAXJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ef2qePhuqWxT+Rw5O722vvthIBpUuJvno3EZIaAfl8A=;
 b=nfR/7Wr10kU1pOdAXEzHYRaU3AuNO/h2b5d4jMud+d7154Jid9BPL9vDIBHOmCfUcvvDlhh/9YJCnK71oQYYJkzlZognTMK/UzLLdcXQySXbhiTAoRjpS+eyhQb0ClUvhRBQ9gaTQ2LZZKopaX5431/i2TpYKe8lfS8HPcUIobY+yzedl77tWTf4qxXWm45vBsWRpyFcIbLsRfQM66Y6KTKXaHrjOypWM/IiS5Vic+WWKMZAO6wcpdhHdlAagkRZ7Q2MoWof29rkEu6JtqNPPYW15JmL1f3IpFis9Be+RCRt9rE8FhxHvpSmrmgeEpIq3gSZ/ezyv0tWPXdZuDqZaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MW4PR12MB7215.namprd12.prod.outlook.com (2603:10b6:303:228::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Mon, 17 Jun
 2024 20:10:04 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 20:10:04 +0000
Date: Mon, 17 Jun 2024 17:10:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Akiva Goldberger <agoldberger@nvidia.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>, linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA: Pass entire uverbs attr bundle to
 create cq function
Message-ID: <20240617201003.GM19897@nvidia.com>
References: <cover.1718554263.git.leon@kernel.org>
 <7d0deae3798c9314ea41f4eb7a211d1b8b05a7fd.1718554263.git.leon@kernel.org>
 <20240617134409.GK19897@nvidia.com>
 <20240617154947.GA4025@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617154947.GA4025@unreal>
X-ClientProxiedBy: BL1PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::10) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MW4PR12MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dfcef3b-87e5-4403-a670-08dc8f0979fc
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V71zyAj9TND6anxCPUQmceXUqBP6pcKp/3+NP8ShSEUMF5si0mw8QYbiVXW0?=
 =?us-ascii?Q?b17NG1F7W1UnsClIToXYo+C7tpG/hlItSBvERRjwZ78hfgtjkwy8uaf6zuCt?=
 =?us-ascii?Q?wiisoX/6DuLasf/x4UAtaiQq5z6/FhY9wNESBWDnLwg3mb/sESoRf3eq7Xx2?=
 =?us-ascii?Q?MfIP1ff05a8TrYwSom5/E25oy4xd5Ob+elup8vrIfXLxpM1lAH676LSqhcPS?=
 =?us-ascii?Q?SWTuL9iM3vPAxua6Ce4QGIoH83pvP5Ftjzcy1jmtsy9M4/oZY4kzA8Sno+Hc?=
 =?us-ascii?Q?NDx5o6r5X3zdj27s9D6m7DgXVLjUgWIlVaOYchkg/sKaomhX8CfvIKCmMzJO?=
 =?us-ascii?Q?YLfJudFWn0mCfa5k1rzMs6nZ5fHiRBahWTUJ+LVBK/oUPvQdzZJG+7xR3I/F?=
 =?us-ascii?Q?bOffx9w5CPPr8SAMNeqQ3oyCX9iaq0ZBCLo2nIJtyaQlGzZU/GmdsKNHM1Ek?=
 =?us-ascii?Q?lPcqtJyAnFlZXG+3lf1YSpP09vEwnWMSxLacz5NRGDEfJmxogwbUOS2bnrEJ?=
 =?us-ascii?Q?qBIYTelqZbVO70B0xJ7xbOOG++i+B7W99E4FauZeRzVf751qS+Zr+KadMLpz?=
 =?us-ascii?Q?mkZOXkcBXjLuql92mvt22pcZyLtlo5sOb0HPl2o08ddPHJ7l1eVJT9coY96e?=
 =?us-ascii?Q?2D6S64M/KvQ2hh3PvLw/PJMSMY5GpuJrXDv1BAr6/Q+YzIA/oA+s9sw1nToQ?=
 =?us-ascii?Q?PGu797ZWUqSxxWNrr7I/e8C8IeJZR19FQfA7+lO3VIeyo2bkZE6vkjZONe4d?=
 =?us-ascii?Q?Q06k2c6tfyvOfy9wIWA8h7diyAeeskH4owFTXDH05jCBJzXZS5xDKjEdxeSN?=
 =?us-ascii?Q?wvmJYw3tKL+akHuGozHEENsxooEI3CN4+//moVk8jGQANIqQLpzAYO33fBHu?=
 =?us-ascii?Q?tGNGIBJQU09zriimJrYiVa8X6G+Qxt3HPc58rLaLsAW3E9l79FBZkRqYzEkN?=
 =?us-ascii?Q?vJhKz2/LSVyUaaXd9j6ErYfVXv8g21kT67FWtPaRjnLNhxB+aO4x/pxr+Rcj?=
 =?us-ascii?Q?XBfxqoY2Wkcw7QgOie9Uc3MveBK2alPISWbgfOz1q45CbHfnfLnGuLAxfcr1?=
 =?us-ascii?Q?ISkCveOMFmnDh40oTx0KTl4Wq0xR8+OgFR7U7Tdonpn3Q3XIcunEKNBOIGwz?=
 =?us-ascii?Q?aTu/BQQJtb5DCiDD/0wUepflCHWlOI0j3sPNONKCqX1fDMD761RGgcI6IB4D?=
 =?us-ascii?Q?+EX53SN6iYM/xx5S5wCZ6pMgQ9c9yyVun/qNJTAj2ntUEC0KfsF7g5QLl8QR?=
 =?us-ascii?Q?seAUJY1SnG/wGL7HU1GrEo4sWXawsI8YpgOQwZ00f35/Ym4vbgqhi8LaI+2m?=
 =?us-ascii?Q?Gjw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?11mwaoyATdrMmz0XTJl7TAywEcAwrWT1YLqrLZ7Cn+XYRwXniAejnF2rR5fl?=
 =?us-ascii?Q?S6D+/VSkw8pzU7WcvAlapZhYLi6Z+EWp4Y96osQGZg1vTMan/NoOoDkFBxRC?=
 =?us-ascii?Q?GNGaAokK0xiQH+J4NmYfl/YsLK6HCaMeioCquxwDiEK7hTKPLqEhB2VIjuhY?=
 =?us-ascii?Q?y7gPPLM/3PSDAotO9ocqsGrOI8Go5PqrjCAOzGg8OWdRts4gBkTxp/GjuEeC?=
 =?us-ascii?Q?jA6cEMEWZqWhqKz0dYq/LmXJL8AMEwkbHKQ2J0EgJeLvLtUmMEa736v9UPl0?=
 =?us-ascii?Q?sqleOBkXekORV8pd0G/9oSDO5JQP077Q8GvMtNp5wJwhPcp8GMETt2RXCV6D?=
 =?us-ascii?Q?+dBmWdQibQz95eyJVB7/Ss9mEZP4txClzX6UNJx1Nx5Setq+sUzgXLkwFScZ?=
 =?us-ascii?Q?JGq76wZdFwiYTAignssxqgWDFn+wsum7ZEfd0zLqhTpK9WGd4GqFm1Ic4cwq?=
 =?us-ascii?Q?t4CQqT5ZXM2NEXjx5W3Zzs9b154dIRHK93HWd2Ln63BZm3+t84mz2ygWkdTl?=
 =?us-ascii?Q?g0KULoZdx4cfpSyQdglN3e6AOpBCdBsbSJNbc/kGauLLkDIFnKOJgjKGslI9?=
 =?us-ascii?Q?F/gg/kIYWsqrh9WmOryJV6Rd2F5Wnet+pBi7mFT/2NZB64biBZlBBZAh9NnC?=
 =?us-ascii?Q?Va/Tyq9IR4ou4NscH1xQVJe36T6VB5EKI8c6d5zk4s5T5u9SkVwp9di+bDhV?=
 =?us-ascii?Q?FAYV9IZ6r+MTBLfmvS1cTqB7vnDHJNkqEPy8AQFRt0KVivQDjFN8I0f0XZE5?=
 =?us-ascii?Q?W8NQ3HarBzO0lbvKTtQcxdJPW95InvXm49cjWs56cfpiqTiGX8hXwlu2y98y?=
 =?us-ascii?Q?iKEG2pW3GfPJ9otf3pvUa789y0/0PiYXEYgx3wUYf0nfzGfaRK9Zd8oRzpwG?=
 =?us-ascii?Q?b5YjLblfQn0I4Ukpbh6zCV/80Fp407i5Yh3xmIdfcpAwiNgs3pMc6zpocFQN?=
 =?us-ascii?Q?QxYpQlKFTe4ey8xngguyQ315vwrEHY8P9WAVaW88sH6OA78qc4JO9CwWO8Z3?=
 =?us-ascii?Q?VBgmsJBUlPwGGEyDEjotECPrU5KrTPr9i6bWEVH2a87GSUuo8ib7FSk9AS4C?=
 =?us-ascii?Q?Xj7+hdHTUr3R2fJmQ8xOVdy1wzO5n+CG4RsSmZrKvDLZ6KuNZ/I/QdkOvhgD?=
 =?us-ascii?Q?wppnaWK09VUZDzQJ7NrwWa1Rpnj12FYDGG6hwKB1O38I4Hf4AOqmHXDrh4Ku?=
 =?us-ascii?Q?BmuAGV0EA6jK3Zf/VK8I6gabvrsCXgAi40Ow7ZSh+6s7zb9MQwFLHN1inFkl?=
 =?us-ascii?Q?QAES7DVP2AbIOB16w9UkH/M1+V6UUWNql3tAsywhHPjpB0R7DNZekF1g60pK?=
 =?us-ascii?Q?wPdX5KrCBSFri1OxTGM0I32Y11qetGvhDPYPQjkil7EiHoX/uSnfcGIzIoXW?=
 =?us-ascii?Q?+q+1APPM+jQjQPediEMeenvlLnn4BzH22BFiu2Vur4Lz2pw2V4mbqQSHRxCD?=
 =?us-ascii?Q?TemP3YnA8tLaADvhdHWJiC/WO4VQ5ncrJR1qQzevnZ4egefxebxZYY5Xdpxa?=
 =?us-ascii?Q?7gJzcZ0TVBFzD4X9ZXxYoRezTGhQIBEdiXuK3jy+17G5bMsNqXJxxbm+6saj?=
 =?us-ascii?Q?DTstMQVWJE7/oqyILXu/SGBLpKgJsc04xmM2Pafh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfcef3b-87e5-4403-a670-08dc8f0979fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:10:04.6094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQNhSrWUkwL7Gk9dFV0UWnEEp+v7Wopzbg6ux3qhpAJIFcdBWNwr4TgfP9JNr4lm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7215

On Mon, Jun 17, 2024 at 06:49:47PM +0300, Leon Romanovsky wrote:
> On Mon, Jun 17, 2024 at 10:44:09AM -0300, Jason Gunthorpe wrote:
> > On Sun, Jun 16, 2024 at 07:15:57PM +0300, Leon Romanovsky wrote:
> > 
> > > @@ -63,6 +63,7 @@ enum uverbs_default_objects {
> > >  enum {
> > >  	UVERBS_ATTR_UHW_IN = UVERBS_UDATA_DRIVER_DATA_FLAG,
> > >  	UVERBS_ATTR_UHW_OUT,
> > > +	UVERBS_ATTR_UHW_DRIVER_DATA,
> > 
> > The start of the driver's attributes is not a "UHW", the UHW is only
> > the old structs.
> 
> I asked from Akiva to keep existing naming convention UVERBS_ATTR_UHW_XXX
> to emphasize the namespace and the position of this attribute as
> relevant for existing UHW calls.

Well, calling it DRIVER_DATA and UHW is very confusing when it is
really the start of the indexing for drivers that use UHW.

A better name is needed

Jason

