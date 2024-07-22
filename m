Return-Path: <linux-rdma+bounces-3927-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D800938FE1
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 15:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D29C1C2109A
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 13:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF6F16D9A5;
	Mon, 22 Jul 2024 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ATKQFSmJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B37816A38B;
	Mon, 22 Jul 2024 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721654882; cv=fail; b=tkBFM7lQ1vKvUMxrXnpeT1MAqzGfYFEGKxHddlBdOWGdRyIxlnT3ak/POqecCBqbvn3ivI4xmvVhgr7NX+f34CTO81m4WJwuk86+Tj9mOd/g6+E/GtDTyIyFGlCpcKdM43a2EABCIaPGiClk/1SAecth+LKaWMSKFo6Ty83mWHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721654882; c=relaxed/simple;
	bh=sok3e9cEFaRaaZ7RjMngowmfW5meOxcgE2PrtgXA6nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jd0CrQdIt19J0iHe0+Ejye69OnVLonknYa98gk3jrS2t/d7bU/SyGfISHhNyITiDRsOiVpLtw7W30gYA/AFPswhx7X+OZ+Yl+K9J+sKJ07HLc+knTtsTnhsTRjkWr4s6f0HcCuRhcJ2ZuI57BpqFtAFIzFQ7oimMgJX5LbUw8qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ATKQFSmJ; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2f8LjjrwQeg56ogXXvGyQDJxOWMDE2Vz5u7wzzVvBpuzDnbnf8sza1fa0ufn1uTGCsURd15UlnBBwS1LKwkh2j78p9laaptrUSh4WgmVa+f1uOSVg1bTlchedtjY4qhHE0oOdFGealS5IZ2qHMuwlb7zuQsNWMWj5MW62UHAwsJFq5dcr4P+N12j65dLG5LJ65Qy29NjjEx+ffIefQduiXyOC/Qz4wgaEn6DyzPaeq2g4QJvP/A1VY95oyZ8ehKP1ZAntQfoiodlsrxnjJkehxfI8kMX8vE3IETGiUkeVlrb3Uhk5kELyV3Hs8eZcaSp+PltST9JctwCybhsMSVlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=255y7WfZ3uBL/hS3cOO0kBS3TOq9qy4jVDiYv/Sp/WA=;
 b=zFQelLxYG/+Ve7nbazh2ickr6U+xtnh61SFJDnZNSRsviEZTHC43vl05oVVlig5ZXH5rTEieQsiDuZ2xzBvzvXOXpvGpUrdlM6TweaP76hG0TPkFOX05kol1hXekhmaRjqDYuh9AMDdI0L7ky6PrMUrzezkSXTp+K6aczQLfqdCUM1/2COaMugQkTpZ4Hi1W/VOSNf1jlAzGEd+2olinHR9ACxqlDO3bEmkX2SRLCcLOnrr4Ro7YubUauip60YybON9DKo/KIBgj9vkOLS1UamHvitEInyR2o0m6HMyXVxh0a9lyo7+At95maVucWKrqy+EuYQhc8hA55j4k9oFwhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=255y7WfZ3uBL/hS3cOO0kBS3TOq9qy4jVDiYv/Sp/WA=;
 b=ATKQFSmJRmLyIffIzEn/JKQWm2sjPhdI2cE8IliNJ00TOHjOMDqRV2V2XF5zKn9uqH4vRa3OMAzMOD9ErjU5JveNUuQTaViQjpA2L/1JVj1xmzHoGokOZVoylvJFszFLPw0E12Q0LT9hJouEADNmgWjqgEEUjPmGNU++1OIDLP3eYrDomVv4NFQu5A/GCyMxl8Fg18z00tuc945f7QIkvOA/McGWC7DUus7/ZZXk5EZpt7K27xTlBqgxn9YtfX9FbfDcB3Z06adgW6YpVV3Tm7IEuspEup7fu/uVH5iSBJqN2wUUTPLdmLRdgJRsgXaAedpGPjEDMHcq5GxAa9/8xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Mon, 22 Jul
 2024 13:27:56 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 13:27:56 +0000
Date: Mon, 22 Jul 2024 10:27:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240722132754.GA3371438@nvidia.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <ZozUJepl9_gnKnlv@infradead.org>
 <668d92f68916f_102cc2947b@dwillia2-xfh.jf.intel.com.notmuch>
 <20240710130514.GQ107163@nvidia.com>
 <20240721185105.GC23783@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240721185105.GC23783@pendragon.ideasonboard.com>
X-ClientProxiedBy: MN2PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:208:160::28) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA0PR12MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a5ac8a5-a2a3-43b6-3e86-08dcaa5218e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ERmL2XKUmbyS+zbDt1jSwm5HWgJWXhPH1MfZCWq25d4lNWkZMiIivOoM6UFv?=
 =?us-ascii?Q?2U5fjTJtW5umvzQFOn2YnQjkEjd+DMdH7gTtevALpZJK4QhSBUf1uYUmFJSD?=
 =?us-ascii?Q?L7QF5Sn9ZHzdnNS8/0cYp0Odu7T+lnjfLrtmeripWQ3br9e4M3jwLSTZS0Nd?=
 =?us-ascii?Q?P3FSVBh0rY/wEivjaEnBqdlMhgpinHY7kMLzpifNey20JLH5jIsBi5BEMZdH?=
 =?us-ascii?Q?Dg9HTz9/G9lVpp3Hzaok5fPG7aFAVBXBjwfv+t3BQF5cGasYqEPEqmj+ff3y?=
 =?us-ascii?Q?Ko0cTzOo3ezLEwwnYW7yN6WZ2dMYXvwV/9WIfZVp8t/YYCtGMkZkCsuhZO6R?=
 =?us-ascii?Q?z5ew+A0EmHSs/eJ3n4sGcvEMsygmTatNw7kseUB4DdrjaZzNvaKmZXeF5796?=
 =?us-ascii?Q?8UNf61NZJYSCukwnrGDcYg6l4DDW/TenNHOPOX0cURbZxbOXgCOoOjQkzlEr?=
 =?us-ascii?Q?/dKQeT7zJqNqrAdLua/7u6SM5V1cgoKj6vU9vilfwM9lOA0bCHYkdtbzY91U?=
 =?us-ascii?Q?xxOx2nOD++3QcFrhvn8KloVl2gU1CA4Ql0/0Qie1BKkPurFDe6Hq58mYjA2Z?=
 =?us-ascii?Q?3l7N7sibATEgrPbZK6uE77y63veHRXWDM6JOrKDgnBM+zm04sHxdH+dM16H7?=
 =?us-ascii?Q?Q6I71LtQ+D6vUpxZ0Dw/xiK37ctkpiuvHT1iGKIcLXuG9xqWuNuHuPDWUJMT?=
 =?us-ascii?Q?oPgtJMVIfQ07XZ21BWz89BYOmQk156YgwBC5z243P04tFcZ9O7riPzE/gUXZ?=
 =?us-ascii?Q?7+2jgaN4cBY1oW8AMtQ+6qSomBHxZFGpTldN87Epxw0ytXxxf3hZLxgeOhbJ?=
 =?us-ascii?Q?fqRPK0SThPDhNt74JeB7xOp5B/prdDOWfuKUxbpeOQhTFx46xYvtn9l4kSsh?=
 =?us-ascii?Q?/8sXICbtjoSTwP4fX8BLwMwWK5UcOsIsmXMuxsxtGN0XWH5dGCvbAWk4/dWq?=
 =?us-ascii?Q?zC8EWzr8+C+pZMury/HWk6aIQCAakHtKmivuOgJ9024uXiFjOU3BHbEWbc2H?=
 =?us-ascii?Q?LlsA6vod9RMjrm0+o9JmrmdOwsTrgzf8bbkyFDF7szcIdLdcNUWhv9X+UkIF?=
 =?us-ascii?Q?WLuiG5q9p2RrzwU+9S8Khhd48ZLOppgzcKeSbhoAVUmInYhBHVG+wfKNjFoo?=
 =?us-ascii?Q?DKqWimkSaDkqzY1GO5tQvZ1VOzTG1wAOXBg50G0tz8c39r51abZey/DiC36u?=
 =?us-ascii?Q?sLk7WzHPkGXAu+m5mHRRSHrHqlS2X9tPPhdZk4+l+1zny8Zk40CMAN09Bk1C?=
 =?us-ascii?Q?Ovcfnn76IOUf/6wnHAdrJTvY+YHK9WOE20Ig47NrfOj8NpjCW057cq6U9NeJ?=
 =?us-ascii?Q?fkqb0k+2PGS0usxI+v1fzQ0onE3qHWEHPv4DVovz7J+AUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oi5NSHq0EtV3kqLFNYOAejMInoaRsMQVYCQpC33xvj4NivOef51vFJQGangk?=
 =?us-ascii?Q?i3Ia7xrWpHY/FY0gsuVNl1zeV3O/KawSN0yaR1vEnM2On+wxYtFAaOB3uYFV?=
 =?us-ascii?Q?Ug9JtgwSGtdaV8YKxEIs/tjADC/DSVQPW7Zp/gC95kcRf7+1o35Cvw4gj4T0?=
 =?us-ascii?Q?LLDTrm6+EL0BESk32zV96OBfP+8WZpRIBpj2zCMYF4xtbAZEiO0mQCxiYdlB?=
 =?us-ascii?Q?9JRlgfioegPQbHG+UTqV0oSUx91wftN9JNDuUNKAyyv0KI0uWDvHlVpKhCCj?=
 =?us-ascii?Q?9wDCvfjg5nkUNWRGKJCPfENIKZrhLOaHzpWp0S4x3XRC5ZvbrdfV4402mNlx?=
 =?us-ascii?Q?n/en+n27BM+Ab0eykeEp65jCvGPOxEz50DzZJ3J768lCV0AkXNVBUoNle35U?=
 =?us-ascii?Q?ekNUfd+05CATLcxgtzfOBdcFonZhzK34QAg+Mh81Yh9egR2FQq7474rzTmKj?=
 =?us-ascii?Q?5TL0LNWtqBL7SrMbQRTZ66pPACZpIM8kw0ZMRq1kkt/CFXS8oHyKJtyWF/Ds?=
 =?us-ascii?Q?EZT30ZkGZBxXPwhG/plzcoVhkwc6UJPQ3EPCg5LbhO/9RFmRB3zCiG5QLWBw?=
 =?us-ascii?Q?uEJ0G54D/mQ7vGDJKc+zuGC5ezIaDrglFevWdjMfvWm0ItFBnQZTLktKSJ+z?=
 =?us-ascii?Q?Avoktkb/Nrx4rWNPOHpWuB8Msa9iDwZ/gFr8LUHntsgijGOfMWNnJpxamxVA?=
 =?us-ascii?Q?ZEj8LGlsIONOlm1JXyCyWUSdVq+ioCJCVJCE/Z4W0rCHp0zvhNVUYgFYw93d?=
 =?us-ascii?Q?/Zh8aAnPqrkqUvER+hOwfaZZgDn1+asyDSJ3W56v9JOa3CEM6vJ4pdZue1HQ?=
 =?us-ascii?Q?EFdlvte9dK9fRNRrh8fJBKz0kzFbEvbtBdVivTtFwV0abVki5FXy8uQetKgO?=
 =?us-ascii?Q?DArHdUIdQwvFL/2peVzQ0fQkGj1jxMByWyfSO0T+niyPQCfRGGib/Iu4ki/3?=
 =?us-ascii?Q?HhrlJqNgUUkFj50EUqml6BGUlr3qbYXxxcLAKuAVWxa27FtALvr3EHR78Cnc?=
 =?us-ascii?Q?r1OzvkBDsbZuPMgJ//mtJd2E2qgZkNqHTRcuRJUjxYJofvcvYAUGieyDswtd?=
 =?us-ascii?Q?NzZxrVovlEvXdfAQ4Qys6jANE1a58vafxvk0XRAUZXsD1yQZK9N9mg+o5P8+?=
 =?us-ascii?Q?wRsGvDz+YOYd0opixExUiwfXiYPZsIiWT3/TCuZ9G/YM/u0iwEutVr1TLpco?=
 =?us-ascii?Q?MI3ulPoi/L82cTnPFq9UMsY/tha6yGMQpT5XKJ1WC7PmxavGuPTUq9cU01n2?=
 =?us-ascii?Q?Lg8u0GX24jSNJD4emoBs2K5WPhUSGMfibgaDNXh0Yqg/TEG123sc0XXnAyfF?=
 =?us-ascii?Q?BzcHR/+AlW/036Pn9oukqNxKDvfmgA1Gp8seEJjII9ocHoWxaFH3Kf/jGUHi?=
 =?us-ascii?Q?cNco28iGq0cGPv41v6Un3REuC8XRAb+qeTsR+YY6inwKQPQ98FhD88XAlY5u?=
 =?us-ascii?Q?hHPt2mii5Hw/OnkorQHg6Wjd7CPlK72dLMhPrfIYdJM5T4OsACzf7zL85OX8?=
 =?us-ascii?Q?OVFyAqQXrCVuWsyT6QDdGqSv4HmiLpOn+l2oj9atsk7kw6JrllXwrjgNv3CC?=
 =?us-ascii?Q?NbNbRDglgVZZQOveQ3M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5ac8a5-a2a3-43b6-3e86-08dcaa5218e2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 13:27:56.2826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDaXRRi3hRb00kSFcx1PIP1/lUXiYlRO53i7+xyz5EC5P4zk46qbrBWj3zRKAUFr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7699

On Sun, Jul 21, 2024 at 09:51:05PM +0300, Laurent Pinchart wrote:

> That may be the case in the server world, and for protocols such as
> NVMe. My experience in the media world differs. I've seen too many
> horrors to list them all here, so I'll only mention one of the worst
> examples coming to my mind, of an (BSP) driver taking a physical address
> from unpriviledged userspace and giving it to a DMA engine without any
> filtering. I think this was mostly to be blamed on the developer not
> knowing better, there was no malicious intent.
> 
> In general, can we trust closed-source firmwares when they document the
> side effects of pass-through commands ? Again, I think the answer
> differs between different classes of devices, the security culture is
> not uniform across the whole IT industry.

That does make sense to me, and I certainly don't feel the same
comfort when looking at embedded or consumer HW that has a
historically much weaker security story.

Jason

