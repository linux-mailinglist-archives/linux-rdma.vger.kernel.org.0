Return-Path: <linux-rdma+bounces-4169-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA29944E3C
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 16:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5C8283D3E
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 14:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715811A57E4;
	Thu,  1 Aug 2024 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YtTMhPnr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1E216F0DF;
	Thu,  1 Aug 2024 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722523317; cv=fail; b=UW5ssc7vWvXQUC9imYSzoYNUma/VB1257WGv/wRgFmKQ9xU6zuNAGCoJLP87dvnklbdiwxPkdvARosxp9DZWdr9CbWfqI07yZQQe1nuMu4yetl4e9En6fv0nqCDCFh4HOc/zWTahXWzY4jxykpcKaws30U30n5Cgmxzd1lXZdRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722523317; c=relaxed/simple;
	bh=uxC429EKd5Gt/z3hgD0XwruWvhsSVGPRiDqbqlY96TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S+uCSrEsMBIz61YfOzmCy/zjEPn41Zu3+LYHozr3GGjYALZT7jL0YlY1Fx0VsrwlSOrprbdJ+KsGEwl5G//Eb4IvUbMEc1ucJW+6jBmi1RA2Dwj09KvjFxRoI66w+5s60CvkGwYrKiNbGIuNOboo9Un2JCgmUCzsvZ+TqEXeqec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YtTMhPnr; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTGuVRjhrZWA6IQASyB58ZmhS2rlsh1e57fKsDcUekRBOZETp5wMW0Lxmm+kn0V5lS26XDkOIqTtCTV++khWizKqZAagSfjQd9i5WXO0QnuE7YPP+TMjQEW5iutuEpZnWpG4lYll0ma3BF/8r+veZnfvgYa+R64aI8BzGLqoY2d3xs4rFLRzHd2KzuV3zE7hjQY6CzrnZfeAlmsIuVy7tGXuZhTYP5m7gT89vYz8nidsDHvpldDkq4d6OFTrUaFEnRaGiaLQSJlgOuiFWm5DyWoOJYgS/dLaM2JjA+ACd6jaexRozu7oiWtUWwkgQWYXnqaBcB+RqXxQ+K/v8FlFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxC429EKd5Gt/z3hgD0XwruWvhsSVGPRiDqbqlY96TA=;
 b=r2i+Dsc+MGTsyA/eMsAH5JlXe7grOMj2Be7v3iJ0Nkz4XrN/7x34rV9oewzkXXPfXGcWv1xicC/HRKLiBRn9gqvfqpbqN04YXAduRwDlO6gpJ2Jp/sowICjHUvffw75ECvL3ozb0g9BQpgniTT9mZUEorYYwj0BwezlYvzuWdUoW9UkinMWXJjNEWF2HDmlx5ENhDj81cO30qjT+s7PqObEEEVsR8ulil4xPToJDOXMm0PcKcY/nfPSXisGTlx6uB7WF7JMkR0gTLemUATYrgsOefqWq2OI7xzzSEkEPL2m2qR1PV/bm3x4XS3QvHOPX2VRIZn/NjxlxKQvkj3fFLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxC429EKd5Gt/z3hgD0XwruWvhsSVGPRiDqbqlY96TA=;
 b=YtTMhPnrZsPG7gniYGf5zpfJlurDx9LqiEZWYuflOPAJo4NITXPs+uBGMdCJuYHsAbrdoQpeLgMeStDd2FsH1lv8WtKiy20oQMtbduDqnjOesx+eBWsM6BOLJh4UkBwY+8HhsrnpwqHTMVkbNTt3wq/Pjz2kaogxiAOAZlVi6BeoXMpDKGLh4sec87fVbuNV3I8VFYcvOstXcHR4fIrAVQ8rl8sOKcAe8XhjDmoAsaWZSKPSRNkpQynS2V06i/saMrjvj4WGRPQSLKz3m7TSeg/Wa2hXikqwnkwH/gfuDRTOm00J4Lg/MtV1MAFcZ1nmDchZ6rb4NNp4km5Qns1Bxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SA1PR12MB8096.namprd12.prod.outlook.com (2603:10b6:806:326::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 14:41:51 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%4]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 14:41:50 +0000
Date: Thu, 1 Aug 2024 11:41:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240801144149.GO3371438@nvidia.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <20240726142731.GG28621@pendragon.ideasonboard.com>
 <66a43c48cb6cc_200582942d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240728111826.GA30973@pendragon.ideasonboard.com>
 <2024072802-amendable-unwatched-e656@gregkh>
 <2b4f6ef3fc8e9babf3398ed4a301c2e4964b9e4a.camel@HansenPartnership.com>
 <2024072909-stopwatch-quartet-b65c@gregkh>
 <206bf94bb2eb7ca701ffff0d9d45e27a8b8caed3.camel@HansenPartnership.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <206bf94bb2eb7ca701ffff0d9d45e27a8b8caed3.camel@HansenPartnership.com>
X-ClientProxiedBy: MN2PR15CA0054.namprd15.prod.outlook.com
 (2603:10b6:208:237::23) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SA1PR12MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b38317f-6c67-4805-4820-08dcb2381428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eUKF4C6bdRDQI0Oma2j4yM4Mrl+2QsD1abqIND1s/yfMRoIRFzmqwuGiwmsO?=
 =?us-ascii?Q?2c6H++EUT/BPpS7t5Y/X6RZaVEm9TRo07LC+Q5ctL7dECQOLjO0vZbFlzerJ?=
 =?us-ascii?Q?RQ+mKaHFrhOIfBfT7vzPfk1J47AVQyvCRHZTMYFP8GHnXGpVf2IoO1qTGf6D?=
 =?us-ascii?Q?eZcS3hZL6rduqhm4vtrbJG37kFB39nFuFpGw1cr3P5V8cKxWOH6P0elQky0C?=
 =?us-ascii?Q?qEfSoosteKeLbBB4wIHXOPNE0Z/4TmR1PMymrxIucuI8IExgxE7SUqL+OYU+?=
 =?us-ascii?Q?50afzrVzgdQKfKrnAm+mQ0xTB3khlyDjUGtiBX0lFIvd8oTjll58YRxbFdEf?=
 =?us-ascii?Q?S5KEHL1IVUxfpC6JcH+P2cXsnZ5f2ITNQ/0ZCXo32oh5u2AKRgOXkAXZwVtx?=
 =?us-ascii?Q?CDJNjGc6Fg0PgYdPnyOpEKck1KISxPeIx4GYbegbFw/hxLlGx1JjI/SVmKbC?=
 =?us-ascii?Q?PMaTc1FFo8PW6EOssrynGLy+tbOJxfRy0WjXuJN0ot03yF8LQmYGXwcxLm6k?=
 =?us-ascii?Q?WXp+Pe5WJ5byJqiQ56mV9rAUb7SGE6j2Z1ZF+HqKvkgZ0sYqcw7eBVOBvL1t?=
 =?us-ascii?Q?i7WYUQTqoOzdPc03NRlZ93TJSz6eVpZ4+ae2US2XwcB6kuSbylHxdXRhbIsA?=
 =?us-ascii?Q?qv9bd4LrCYx+G6L1EW4KcN4lTEzyk/9lGBKHcsNZMmRWmXWrS6Oq88xgP7Rb?=
 =?us-ascii?Q?SIUJRB51NdqG3R1r0BMyPnE2nQn57Ul9KccnY7c+UTj8FkqCAxKKXpP+dB3X?=
 =?us-ascii?Q?te7i8IZajSu2URY/pwEin0/6rjGh/ukrqmbNHoIXG6p1vUBjmaF1LRNTrKEv?=
 =?us-ascii?Q?ZXw9C7ULYMbQy0R5jX+jXvYwLWN06vcHQw5O3qEbE+YcLZT8ivW2ctqaWDr5?=
 =?us-ascii?Q?inlSr0RQJLwC8ASz7Fu67x3ym9HOdWIM5V89bXnX+NWk8+EGb8VMfZFcTcb3?=
 =?us-ascii?Q?SiI6dUlbqvNEdAfDmdRS79QNo9y2hGsIXVKC2W8i4urlyCKioPuaDvhF/hdi?=
 =?us-ascii?Q?MEDHCNWnQZqI3v2ukQnoh25veBQLXIDLroMFNavDf57If3/HCsdsZWrspEIu?=
 =?us-ascii?Q?2uaCYDCb4IE59tx/3sk/vuNp4AA+3u0WveLfjh5A6HcTwdtSd+xeRZVNQH7S?=
 =?us-ascii?Q?O2IJcRrl2SbOhTXa+EPA2rdCJwk238ZRjmclV/GODsgaQHLjphqEqqQUe/SS?=
 =?us-ascii?Q?ObdLzwE/rnR4QRQlEPdnpAgEjYp1Z03MGoNq1ubHw1d8Wb8/nbT9LSXDblk0?=
 =?us-ascii?Q?DwuaojV5ID3S/4JLzkaIP61s4CwrHvvZA/JCS/AxQo+55SnlGznL412nBtcF?=
 =?us-ascii?Q?zDKDJeDZdoZzIBe60lTzU/sy40mYd3907g79n4Y3nrryMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HkdxrOAuexbRBHeOaM6pfPwii9aOnWWRCwIIdJuexFYtguuQyLoClVGhtWOc?=
 =?us-ascii?Q?0CAvksaJCohkYSweZhyV0wyUbe9zEDyaT6ULUyUpnfJpNRRyxX59Xnw2Kf/u?=
 =?us-ascii?Q?zLe+DeaGnLN6wJ0zYN0GmSCtStSQ3eFOF02OqIZoq5O4qZaXMdCRu4LtJVjV?=
 =?us-ascii?Q?DKagUaLnLc53oYYJgPq/7kBC9hxrTKXb5qeXdMIIzTQo10TZLd7sLS9v1Pt9?=
 =?us-ascii?Q?MpxEVqRYwYDku4Vg0y0VOdSCKLiU3vJRag2RXPnq3ssZ39uTOxa3E+0jZBQk?=
 =?us-ascii?Q?Pj5mPcFUeNE0CnidPKYkVIwgXlI8QX5kn+6GASM5mtNLKD1oYLfbFtpvpCY8?=
 =?us-ascii?Q?RcQpnfAhj42IXdAMZnfWaaIhiPZe7PO5OzdmPopwDNP4lH8qTB0l/0STJhjy?=
 =?us-ascii?Q?jeKmbKhuRLkmaKowzC+BN2KW+SX5yq/5gPhOm0zuErKbievDzgoO3jU1ViiJ?=
 =?us-ascii?Q?DlRiaMHuzy/hR8wGla7+BpQRn2755WHxn5hWp4Rdk17lij4FqObPpt6kU6KJ?=
 =?us-ascii?Q?w8xbhXe9e1GkCuMg4MXdUZhbshn949i/lXnJBHALWTOM+rsyX7lJw2/0GdDw?=
 =?us-ascii?Q?d8b5PCRJA/iNPkM7pu7xBZBV/Nfi/AzsLFRywAUxdczLw3CmEmXYaPrupQCt?=
 =?us-ascii?Q?CMSD5o1L1XOH6Q4iomvySlH1GYS6nTz821j9tWaW58SXB+zJ4n9604FZVGfD?=
 =?us-ascii?Q?+E1CmRKY7d0iqV6r4w8KMUMrxeOCjSKJn9DJyLfXw1K9Tz6FTQtcUtxqjyXO?=
 =?us-ascii?Q?C9X594nXpQpYG/y1R44yuMA7ZRbdH4bKm5nSinl1IKyMhVvqrou9K2UC2cGB?=
 =?us-ascii?Q?e8LEsJoLwjHmkWgH/ImUgcUixrOSpWcZajkSDRui4PLpcPCRhZYuAv9spb+s?=
 =?us-ascii?Q?Wrv38Pgrl8mlQ6VOEiO1MnLrzQkjmwJ4csMQFiy9bMSpgUF6ra2m5GP/sF3g?=
 =?us-ascii?Q?6F9oxRF3RlWKpdwBVXDOMrRbM98Qenp6Mxc6EfGsRQkaZ83VF95fZ0ac1OtQ?=
 =?us-ascii?Q?Utvf8UFFkOt4Jk7eGQCTjSAaQXx8zkUvBMLH3CpFIN7v9VeyTCcTbb7ednq6?=
 =?us-ascii?Q?IQuhIreizN8SD90iT79WVVm0P83otqyQTPUjC1caMiLwlJL+crh2DvqQGXm6?=
 =?us-ascii?Q?aQaXBlt5O3628AEDFuPhhNFUtI7lA1nGSG3mcQHWD1EghfLOT5Qx+FhVYMor?=
 =?us-ascii?Q?fATEtNye1dWASVwKppyT5rfb999zWtrrdM+iIK25N1dxyxod0dqvbwf0W9aR?=
 =?us-ascii?Q?RKhclV8vqears7xuILh7+e4nPZGXMzW7nfbQhhFA/FyN/hDbBDBBip+2PZCf?=
 =?us-ascii?Q?4gIODGd+dxKLzlDWn2kUJUEigYxoDqMGIFXw13X4vogI9gBpOouD7a7Thb7I?=
 =?us-ascii?Q?XcsG2Jo7RizzAX35dpMwppx3f5pJEBG0fxUnktwy6JfUY5i0MggatTTmduHM?=
 =?us-ascii?Q?wYtlmtzG5zrVaVw3aN7bX8Z9duzipttAwofTOsKfwgnmeLrqNH7gB1bK0Ept?=
 =?us-ascii?Q?YVgBdTnzuMIuD9XsHHcrCqWZExplyHbdltyxzDKecPJftynwFQ1J9LPyubaF?=
 =?us-ascii?Q?49+Cyf7v0br+n2CYxn6FHOvU8IQlZ4e31wi2p0d5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b38317f-6c67-4805-4820-08dcb2381428
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 14:41:50.7046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPEc8S9TGYWHyu8V5oI9K8v4SkEoARDOkjpqyfrPC08b62cZTwwM7q5n4DZvDcFg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8096

On Wed, Jul 31, 2024 at 08:33:36AM -0400, James Bottomley wrote:

> For the specific issue of discussing fwctl, the Plumbers session would
> be better because it can likely gather all interested parties.

Keep in mind fwctl is already at the end of a long journey of
conference discussions and talks spanning 3 years back now. It now
represents the generalized consensus between multiple driver
maintainers for at least one side of the debate.

There was also a fwctl presentation at netdev conf a few weeks ago.

In as far as the cross-subsystem NAK, I don't expect more discussion
to result in any change to people's opinions. RDMA side will continue
to want access to the shared device FW, and netdev side will continue
to want to deny access to the shared device FW.

Jason

