Return-Path: <linux-rdma+bounces-4588-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 139AF960F82
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 17:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F291F21E29
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 15:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBB81C9DF7;
	Tue, 27 Aug 2024 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dldTFqdy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116221CDA0E;
	Tue, 27 Aug 2024 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770724; cv=fail; b=l5rIQbdvNfbyR8OfVniFajXhd0Qo/O+M8ehhKP05+A1DGt0YaH0BCsUv5yl01QgqjKJhAIWydH9tYhn4A9r9tW9mwuBrYYFFy21gjCbXx7z2Cjv2ktaIL49FJCWLaY2Raq5GbV+puFbzkLv1Xv3Ls/R14lbfw2iKFE8GZVtI7hA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770724; c=relaxed/simple;
	bh=pu0MrpSVzBZ+deT6JOOuWJ8yXxDIf8qwXlq6TS0KKvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=euPryx6hV4S0ZUXnRnHOtAK5v55hwYze4aDTXlcGM6OAAy/hdE7oLGP73dgwFpu3UOBw3RpBz1scMqWarE6AtjZH4a5esbIG+096Qocw5ywkg7LObBgbgk3aEueuk/siB4IqC/V4KH7JkRPLaqGKxyN5QrTeSfTRBIBwdw7xypo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dldTFqdy; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5gjMaqqQ6snKiqprnrDTVb2Q3a4iCLuk65wQq+nQFtZ+5H5sM5DrzZJhOyFFcbC2HB42AWZ0HJqU2e+cgKjKXNGgKMK6cskuC4XUCQb9a1pVIBZLxzRoW58gWN9jzmpJ/7iGib0dowTSk4lszSUnOh/FDYGXoM1Tu/b57jinUk00l0xCfEjGThaygwACDJ1pBnXCQ/usjlnjdXDcstQBasb/O7wqa0bBIfoMyjI7S+Jl0Clu+mTAuDvtY6WmuICCfIdaPapHgdtTnAoDtJBZEd/bnhRdrZmh2iFPoc9ADhM6Zt8yc2sAayjtpwc69fzR6KIsLxOpM5thtbNYZH8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pu0MrpSVzBZ+deT6JOOuWJ8yXxDIf8qwXlq6TS0KKvI=;
 b=O+Xsgy/eSagICT7wJ5uZjcQaFQJUVuRebLZ/kDjbPikjio0fO1fUYgebsWylEOfSIfYMc0iFu7x2yJAzJMJYj7AJ8sqkc1+3nTKJP2ghh1vUN/yrkIUZrE2avBP5DeWkJiG9ztoZlz6E1ekFR774v4T4I/NT6P9CyJlsRK+fIdB/O25T/g2uDgVPBy7JHDmrJlCMjYhFRvoyWphhJf4bt834V+PVwxPH1MXANh1DIGEuqE+D6UMhFctlHXcthCYR0BkKnptKPKbLeed9g88LGcPZZjKG6P6GjMEZybs9+9zYb7VotHEyKZyCIoCKh0A5LzT+kNO6YFm3gQK9yslnmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pu0MrpSVzBZ+deT6JOOuWJ8yXxDIf8qwXlq6TS0KKvI=;
 b=dldTFqdyHV7XPh0eTnuakvLzNtJcmCmJ0Qk7ysH928bWZZC69DyJALr7Tmf92q9NpNDVS7lXWzwmMWtnts1VJRYr4utFjECTMet9v2vsN45yXvcJmWYi9pghuNApMZaQerOQKymL6EJHnHx+Uyu1ucru++oxdkosI6Y0pC8l2l922Lo4DuzUnNPXQqJYjNT07era2u4K2gFRxHQ3lar4XlABup0EFXEc6qaVRcpuIGn2sgdpnHHtKXRgclg/XbnLP+TyhXplK0E5JdafMA2fwPgUwBsyLlTh85yPAwRqgUiSuEf/335LHf3WwTVXcCbpXlHfsVX/I4PUSFm0jh8V2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 14:58:39 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 14:58:39 +0000
Date: Tue, 27 Aug 2024 11:58:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH v3 06/10] fwctl: Add documentation
Message-ID: <20240827145838.GB335450@nvidia.com>
References: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
 <6-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
 <20240823153513.00000499@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823153513.00000499@Huawei.com>
X-ClientProxiedBy: MN2PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:208:239::28) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b842fb3-0895-4b49-4d7a-08dcc6a8bc62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SfB3pgNEGpT2zwDA3/evL8Vak4B8hQ1Me+4XXNjwYnVQlpUB/1jPGAg3+mBN?=
 =?us-ascii?Q?DMDeCvw3m7XEKRcMU+qdYue6o6+XMOC83HOhLXwuyjcsvWYiez78TeO+Zitv?=
 =?us-ascii?Q?yfmw7NnWq4ANa8ZnO505E1I/5wZi/lJlIK30BK6GO6vmdeewnfjbnVPA+2Iw?=
 =?us-ascii?Q?Ls+iHGE7O4/WdAouNLXE04fG2DfwmJLDNdFYncvihKgEetrN/idDGYOFlRJX?=
 =?us-ascii?Q?B8DpaYF81C6DlBv1WmxydnfkNWEKL/UzpBHZ0ugUXeHRaIsbhNBPGAXev8CQ?=
 =?us-ascii?Q?4sxjgcAuatTTB5T5heCSR2jmlgsvhTRAHJ98gZ/Py8CLUOhfutK4U83KifN4?=
 =?us-ascii?Q?dx96aCLihcEjxXkCwvXBtJOZgJQERZHfFbXWy28LFieOj4SbTKXp7jQSa8CG?=
 =?us-ascii?Q?IwZ1nGcqdxGiS5OytW67M295GmSgT7swf9rB7B+i3aPOci9vYwa98XVF9n04?=
 =?us-ascii?Q?qgMkPfTdyBzJ8UPV81RQ3vVUq9sA1uLs5bpuLIju75KO2fMtHqUdTjktjWkB?=
 =?us-ascii?Q?UFplXGHMxPmlHwoXbmzuYeTrwzBytI5A+ikhiwl63GR4p5lHd+gJolVI27wm?=
 =?us-ascii?Q?1+LivrPUtsM9MhOf+EU7xHTwFd4aJj11NG1QwDIsqMuYiEjatxYQ6sE3uLM9?=
 =?us-ascii?Q?5PvdKz8YL3LMlY4Wb6FEDTlUzacdh8GQ0BW/587BCGQ8zzt9+QRv/sTvrfaC?=
 =?us-ascii?Q?rJHnhIL5EUUQJO8FpGAKEWeJaF+w/PHhi8z9Oamr6evrF+BN6pjti8sE7sHs?=
 =?us-ascii?Q?HVTag2f6vZAgyM31hddUBmX/YWNmZ27tJMx/ojqBMnu3zpqihANJgjZxVjNV?=
 =?us-ascii?Q?loq6iNeEvzESl6CuN2fDZgFMEu5t7baTdnaEWomPlSu20i7EKXWB9X3GxJRd?=
 =?us-ascii?Q?nr4qHV+ntV8N5zZF8m7QhPZIrW8GCSOW2+g7cqIVLwy3atf+di7HzmGZR73P?=
 =?us-ascii?Q?jzdBscPhEfJzIm2GB2qT8TfEEfK+WX//qhMRouTuz+hFjSH03InBnL5+ed9V?=
 =?us-ascii?Q?OHpjDeQ3IAXQ2TYYUZyXVZDYQcPS6+NM9dea+XC5T0+v2yta0VwcrfbqapDq?=
 =?us-ascii?Q?Hb3fVXcXuiOMalfEggiw7Su4ltfv7VzehY6HfoDC1nUFu22dGNuUBLSSeLRd?=
 =?us-ascii?Q?wUyIovbVe9Sa4gfZW1sGzXWCi93sIIe8ZDVEoLEBdHdrGyABwq3+OJJrKQtf?=
 =?us-ascii?Q?QWOUZGRZiq5soKtEZ88PFon1/oliuqJJV6zqceREZC7i+pzJ5nu6W4N4xYK+?=
 =?us-ascii?Q?8YobAy3VFkNtuLx3goQB2xMmhqwhTp2vJgMqG8Gzdv5uEuC/9D/aM6e4/ttH?=
 =?us-ascii?Q?dnsDRg/lNqFyCV0Y2ygnGeeQJfdM1N3nDFEvj28hyPcBMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gair+h9Ndcb0fYtOADVg4taIO87rSTIb7S6px9wPNXG1Jsuvix4qVyprIS7r?=
 =?us-ascii?Q?K+GoRcqy5YpjOd2dckPl6fb4qKJya32Kc3JUNRXCB4NqFeLSXK3/zZWEfKjE?=
 =?us-ascii?Q?gBEA0UCqDbloY1R2KgMZY4A+D1Z3CIrE8vwLvGaXNntRYj5fz71eEH78PK6z?=
 =?us-ascii?Q?zSmGZbZCBTEYZI5qreGMlHfdGmQBSMJN+QRhT3eje7Wv0KE7jCOI55xrfsfo?=
 =?us-ascii?Q?kuv6jkavfLGmlgp6Sk2iYT81eGdQISvc0qMfBgYEgIAN8tdvGkU9oAo4qK3z?=
 =?us-ascii?Q?myxdQp7mvRSnGUkhzmfoHm5NIdOj7JOteh7S8r6/NnrkXCrRG4IXau2oVaNn?=
 =?us-ascii?Q?pB5A6GF88dEBOIsCrsj67ML4qyzYm0fPCkhPwKtl+uPd8kWk7467UOPj8rPD?=
 =?us-ascii?Q?dr20rrQ6Tsd+M80mLIp+2Ebuf9+LN3Kmdr2vQnqUNHrkpUEfp6u1mj/dUCR4?=
 =?us-ascii?Q?n550eEZtAcy5A/OR0TOVvcdfreuuH7SFnIcHEqBRly2dY769VGXJKlcl5uLI?=
 =?us-ascii?Q?QX+XH76Z5s85XHOfKXUwUyx6PSBA7xLFcRQSXZ7z1ouZlvw9gBwWtsNER8NX?=
 =?us-ascii?Q?v5C5adgbwLJw6jiFP9NCpwxP3BmSYt2+P/8CpiYj7WgywKd+KoRwyjiIszlT?=
 =?us-ascii?Q?kEvN4jvdhmfXPKOAkhz5tT5lqYA413e1G94KuhSh68a2fXqtS9EbJhpsRltW?=
 =?us-ascii?Q?ZLxPzBXjehGDVLmzXqdtQ4mOSLWi8cUMAiX7j9IoFHBecehb8XnlvUfIOc7W?=
 =?us-ascii?Q?jHzzVMnr/aDJyfyef2U/5w0eAdMjISA3/3prWPS7KuokT6+Ux+eYkKAdVU65?=
 =?us-ascii?Q?cPn6Wt8ImpEBezdICrVPpuOU9Yhk5TYZSjUqdebYxDiK3/Jni+zjLH+/TQLu?=
 =?us-ascii?Q?F+2YUIfN6qP9cEDgzjzflainnDfVhNiTt0rWFS0Ed959nKuE2UTz+xeWmdvD?=
 =?us-ascii?Q?T5fjVLahbLbcrBInpBXHWhgq80I1ud19ci5kmtHoHlF99ACKdME9A3eCfr8U?=
 =?us-ascii?Q?1i/eC5COUPj0rkGshWac61jrrgx/OSu7MsNgRLcv/oRZJNkt3QaLgNS3m96O?=
 =?us-ascii?Q?CruarAAhl56Gooxaz8dPqhh2aEYgM+RU8v6o+G8d2YOm9UGxdenaBgqQaL+s?=
 =?us-ascii?Q?pPOl7lcHygeNdsxwNn7g5wxtcdB5/3/7QoStiIttYY4eGnYxcWugjYgPG9yf?=
 =?us-ascii?Q?9m3FEmSrNhZhv9hV0Wd/ZvMuEq8qAI4uFHS8/PG3zRAvge1d6eH0f9jEPeMS?=
 =?us-ascii?Q?87V3OUY2pR9fuh5aCrXKLGjDIIFtcP6Ol0DYE+nhDY1CDHiujZqX6oSx6Lvz?=
 =?us-ascii?Q?OKO2pNyVlPeGJA1gpjfN+mL41kk7vrgMBJ52B1J9vmuCuEerFF+RM26Ui45m?=
 =?us-ascii?Q?TmiZLhlS11+EhmBrM9vyU3qStTw2f4Q6oIuU4VDFyrFcsoG6Ig697oMkhels?=
 =?us-ascii?Q?t0kRukz0nsrp5GkzIiS1Z3XGijHr9pvokoUgSSOPsIMMpxAX9J6uaq7briFn?=
 =?us-ascii?Q?cH14e6SOm6Z6XOsFtDYuh1bXlmh2Fewozwmatoztl0FI3diU8yynDx51NUGv?=
 =?us-ascii?Q?vdwskm8QzRK5KOCJrPq97g8C+5gqr/wEvOCu0dBr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b842fb3-0895-4b49-4d7a-08dcc6a8bc62
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 14:58:39.8469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9v9DQYZTqyUUOiW7ifaUa0j7a6Oaxs3eYdPyH/+yWptsU3+1Iqybl0KSLbRLHpld
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622

On Fri, Aug 23, 2024 at 03:35:13PM +0100, Jonathan Cameron wrote:

> > +Modern devices contain extensive amounts of FW, and in many cases, are largely
> > +software-defined pieces of hardware. The evolution of this approach is largely a
> > +reaction to Moore's Law where a chip tape out is now highly expensive, and the
> > +chip design is extremely large. Replacing fixed HW logic with a flexible and
> > +tightly coupled FW/HW combination is an effective risk mitigation against chip
> > +respin. Problems in the HW design can be counteracted in device FW. This is
> > +especially true for devices which present a stable and backwards compatible
> > +interface to the operating system driver (such as NVMe).
> > +
> > +The FW layer in devices has grown to incredible sizes and devices frequently
> incredible size
> (tricky to get the plurals right in this sentence, but currently its a mixture)

Okay I trust your english!

Thanks,
Jason

