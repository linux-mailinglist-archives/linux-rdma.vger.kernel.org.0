Return-Path: <linux-rdma+bounces-7985-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBB3A3FDAF
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 18:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BCA4424BBB
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 17:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D902250BE0;
	Fri, 21 Feb 2025 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D382hqUA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26E62500D0;
	Fri, 21 Feb 2025 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159833; cv=fail; b=nKbquf7uaQTBpwn+D++NV1kBrtxBxBCiLKNNgvWn4MFr15RcwYyHqmInwpQwS0jw2szGwJ3me+Jn3LzTD6VUHvZayX4TeZEYtn2jb+DTbZw6vNJuO+GWaheUUqCuULQFu5Kg4ITYnA+sxAJsI9ZQXXy/ovnpvY9BMCnIc8XDtR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159833; c=relaxed/simple;
	bh=hcdmV/Iuh0YoiWxiJABm2ov7TIICk6oe0aujahaEvgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fJTzlIwWhwZVmOJD22+JzPsRWdlpHOrEnosSjX1VeEMb3C2s0rQCZAIwIKSCDD8oyXLscplMJ8l1SNfYZjTJ7EZvn/OphkqOGeJ/RlGJjSllmjlrG6fdvkPvMbGotzHOpVa8QSqHu/nSu1h8Hr3dV6eS0LIYOnYgX+ZLNGq39kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D382hqUA; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgOSlp2Wp6Dflh4Fj7ZZRBvHbpxdyZM64SPUOiIUFdzKZiYN4UN1eEl9SGpfRW0xxmtayt3PRSwVn1v25/+oYNahVQiji/BlDNuu3fCZUDsR2qlg64LJ8PLtAmcRLvcimLbIV83/pWJTQVAFXzah+4+10lhu8mzFqxIPWov4UqOJSiIxbjRoLYxK6g1GtVmcygQBakuoo+80Dgz5Kw44b99uXz11rfWRX3oLUowYYIDPIV4kscwrDfMfgnxofbZWfH3UgZE8jh28jTgscbXqapbKyloAk/ZmfZ6qF0MCgBsAMptF0UP9IxT15BtlD3cPHvzOPdwTHjVSDiFwI7Zkfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZd7EJQDU9AMSpSGQeOzM6al4ZWpE0ExisWnTh6GCJM=;
 b=FWXu45UEGQ5M5kpnWdAgDfsU0ayYVW372ZQ5+a7hqKanT2Gt5pS4PuuFOu3jlnrOFdzAcWXoe2jV31Uqb3U2sIepW2AmS8Pc8VA0uYqPfB9raXB/Chg6SIMoL+Tfr8etunH0BrprDUkFmJ6m2Lnaf+bEgghpXPOJdU6MA73Ghl1cAhZuIjB1mt5sIT2EE4Cp1EW/z84EdcsI7UIwVHPA8ULM/I8GQIYdY3WdflAi5ip58cwYKowq7UfdwvgGY8Odu7geTaJ5s8hD8QFEPot/+uPML44nS7HXxjFAfspIYIH8RkIzUJBm3a2Hs3duLQot90Z/Vt/zRFn45vDDKJc1/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZd7EJQDU9AMSpSGQeOzM6al4ZWpE0ExisWnTh6GCJM=;
 b=D382hqUAy1abMwomIsWBtfSvlYb6Gydt/6DYkiy0leZFCKKZdiihEqXu67+/I0SJdupzQoBYbaP3O08LRdihg5UUdtLNrW1dP3RDU4yIv29EPlSDeTJgJjJoAWBzwKCe9sGLTpGkwQLvvXiKkImS+qvrUaPh+CBvrOTkGa4YKUn7ujf68XLa0ow+ydp0t2/KLLgGucHmSiIWhdSdbHq88r8okHYY+sMgJ16QI5ALN12WY6XTjVir14droCTR/MD1Ez1/ACA35r66u33qJU9/lNz4GZra0OkyjGiSNFh3GYsSRDQ8hzG6aig5nxVHIma2rPWzpJPP4ha8kuDxbOKvRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV2PR12MB5920.namprd12.prod.outlook.com (2603:10b6:408:172::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Fri, 21 Feb
 2025 17:43:49 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 17:43:48 +0000
Date: Fri, 21 Feb 2025 13:43:47 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Parav Pandit <parav@mellanox.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Maher Sanalla <msanalla@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/core: fix a NULL-pointer dereference in
 hw_stat_device_show()
Message-ID: <20250221174347.GA314593@nvidia.com>
References: <20250221020555.4090014-1-roman.gushchin@linux.dev>
 <CY8PR12MB71958C150D7604EAD4463F4ADCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7gARTF0mpbOj7gN@google.com>
 <CY8PR12MB7195F3ACB8CFA05C4B8D26D3DCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195F3ACB8CFA05C4B8D26D3DCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
X-ClientProxiedBy: BL0PR02CA0066.namprd02.prod.outlook.com
 (2603:10b6:207:3d::43) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV2PR12MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a1383a8-a1d8-493d-41c9-08dd529f4be7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VZLEenv3rmx7whEr67la+VAJrrghVqweuymPj5kR14plU9sa0PaWb56z7aq4?=
 =?us-ascii?Q?/nvnQLFQAzxF/goV+TMqu2V6+k1FVD5o3aCHoV5XZuTd1AdRt7FdhoKkL0ZL?=
 =?us-ascii?Q?NfDkgJM7OvNcG/BMP8DAJ4GQtD2w1vCP54jZYcgtZmHFwytJnrUJv6R8XbqC?=
 =?us-ascii?Q?3Tw9Hs582txqkzp7nnX8q1PTs33wvDB5DwaawFO7ATbdjt5Cc+4Fgda/AGTt?=
 =?us-ascii?Q?tMD3qGitLHJpT1j3CP56k96Mw7nBZ5PvjNNzSDc46Uyiggs2srOJwPDN1n0a?=
 =?us-ascii?Q?wcNllFVG1Siel/+yspfFS3jMqgrp/HtS/oEuWmpNVYQEL2VP2gc/+pywgesb?=
 =?us-ascii?Q?EFLfVlgT1/tAKZWULO2R/sNmd8Qy4QnCXt26Ublh+hPvwT29d8yQ4jjhAwH3?=
 =?us-ascii?Q?CMIlJUdAkfkGEs85Re2QkUe6UqtDa6YMZjqK+cPh11IZ6faBqm36FCjmX3dw?=
 =?us-ascii?Q?BLf8vjRB8f4BLyqC4rIruEOedAVsq/5aj5qshSega/zBm3bFC61rDKsIe8Qi?=
 =?us-ascii?Q?7IuDiTe4wijoHzOIsumyDcPJX0/H3N8QzmF5jAWiqbRLZC/I8Mr/9C0jupZ+?=
 =?us-ascii?Q?uWMOTZd2c1rAgnU1Rbvl812Y6pUu7e8wQexSYogXjDBXez4/O2nZgwW4mHT7?=
 =?us-ascii?Q?TBgjpPHhxVozNdYNeifClWY+7ACtkJhBc8M4/Dj3GagKhSAkNCyI5Hazwv9a?=
 =?us-ascii?Q?ZqWqGVkAVCMq3UnFbYEqcw5OJmwDB9aGSspG9IQLeztVAzf8HjAZ9i+pYrMW?=
 =?us-ascii?Q?g0/pubB2idkJTmmgwN2eiV0RA0G/T0Sx9rvPb4FL3FCuMsje3uCD/WLGQL/f?=
 =?us-ascii?Q?XiOW/NJvSexmJm8BSrKbo7EXO/XxtH2Mn3TL8eqsnkY/RBqAnyoptjVi6PWl?=
 =?us-ascii?Q?AG74QjbC2swk2grpDnRvNypWZC6OfL1bnhdF4SNr1vN3KXXWS68cD3Jwnh5D?=
 =?us-ascii?Q?eJxzRNV6Q4uiyIifMQ1B7ONkWIvondFjhSu4JXUfxqFCSG9I4ELTvoKyNxoz?=
 =?us-ascii?Q?EY5sf1Zf/jQVyFQvUeP2kdf3RpTPlaBx6y4fxUoxC+HyrNtsl5UJX3XJfPz5?=
 =?us-ascii?Q?sQRXAg0SoQnP4P0VlUnGF+ssVMhM8UIhZidqPIDXqNmV7lmC1k19pg/3hSjL?=
 =?us-ascii?Q?EaBR6ZeEii1x7TBkrueI4zskhYey1qCSkY4v4lS3MLvGWIDku6fKdVCVlLMZ?=
 =?us-ascii?Q?VCTcRh3abV4dtM+qQZAV0/M6HSUh/emsbNR+4NZAfFw/2h/2+lSeILAlyBsP?=
 =?us-ascii?Q?LJlemsCci02ZgEJHvntBkNu3PhUnvyEWO+e3qro/wpq8DEbzy8+FqtVbIQKD?=
 =?us-ascii?Q?A6tlIEb8tamsiC/IzBCR6FzqEk/XHPKx9BGzeQVu8Pxo6P1G+Q6U/rm5Ipiy?=
 =?us-ascii?Q?2Z1R140wRp2f8Exqvc5Tqn/v8sNJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WEKWipkh/qeaiOA4NS7GChY1W814PXbezQxbAhCGuGeeD4Ca95lei26w1Cwf?=
 =?us-ascii?Q?Okso5qtQfIMdWvPbgRqib8bK2TqgphZFkai13VSLh7+TTbMcxoZKmWHo2d9+?=
 =?us-ascii?Q?/krafp+IiNoOK7iBAGGt+2xdimfuBEByveGTavn4CDf4tmNd97h8/CYKN60N?=
 =?us-ascii?Q?wxF5h+RSGqXbhAMdvfv0U7DhAlBpIzaCFu+xL+oorHb6RK5C5z18NbVwNXQc?=
 =?us-ascii?Q?sl74VUQnwqLtTFC5Ie3iBVJG0dQYMN67V4U8slo3l7xGWLy+ExRD+CPevxlk?=
 =?us-ascii?Q?/s9dlvJdzkPk8iJhU8eaRPzUYRkMJ5zxZQnSy56Yee/cAIXwbcbMdvvycb6W?=
 =?us-ascii?Q?GVgNQuzvJXdpmpOnGh8OTrYlmbH5Hw7CGi/Njn/2MKxuY+WA2nXD/OLp+ZjG?=
 =?us-ascii?Q?VrKaULp89S07hvVjvKwQ1lkg2lk+MBVkVERthQK5ZdGVDZnZGVhqTB+hG4vM?=
 =?us-ascii?Q?doO3yLrIzU6dorsVevgf1Cz2DHYiTw+7cv78X9hUtlYiASA5IR+O11JkjZ88?=
 =?us-ascii?Q?60REbLhkZOOUeyl8oK/hc6ffLfVSixss53r+SpOeKkrjxyvnUnm8G8gauA71?=
 =?us-ascii?Q?73uu3zIb6rMGyEp1EFk8ntdhlrdd2UJt6JX+xBX5baHJFC5JT4ErjhB+U2GC?=
 =?us-ascii?Q?dEyc8SfHLp4UtSUn1KXQ0vv733JtadGudSrLq4IXa68FQK3sPcuBz+qACIsJ?=
 =?us-ascii?Q?DchMfMQ1q8vR2CFjSKPj1gCQugmMbG5YqL+DSWDTAzqKww+DbMcsf6I8ENsJ?=
 =?us-ascii?Q?9EvzC1ioWd3HEVe0XiDEVxlZl0oct64PbPoq5Agvr6arJ4rjjor/yhgiQrfx?=
 =?us-ascii?Q?0t1HLHMk3E7r9QaqmYWuI+b1IvfW0YhsiKvQ4X/7qPax61xACESX7lDPw399?=
 =?us-ascii?Q?B+fGRBe6KRMuimmHRE36RkvuOv80Dk0loPJmp1SEVrjaDWHVsCm4yhPAi62U?=
 =?us-ascii?Q?LmM5KG2QX8oQcDkOwE5xPtN0D6t17tpWCS/Xcg2gc78gGy9px46VsYUj1/zO?=
 =?us-ascii?Q?xnbSm0BwZpZc251rR73uPCgjJFm3u0neGOFdjEVcAEa7HT/hZtBSX5iEhITY?=
 =?us-ascii?Q?jtm0U1a+S/rW7zbeKryu+V8mePv4EsFZRjtCrI7o5lFX5HN3T+Yv1Ozm0k95?=
 =?us-ascii?Q?VfuF7ykVhIQzAOtJCKuYbAINFp8J/SS1BMvEscrW7h85nq9lQQbWCaudS3gQ?=
 =?us-ascii?Q?eHxIV5TgyzFY0+ISNVmYaER0LCTCfNKUt1MRHlHRZjSB1flLco0eJzFC6sFm?=
 =?us-ascii?Q?qaE50ThzbrC904//1pS6TbibNNOCD0q5NiFW41+oOTJYaUyvRrHs7TBIBFUH?=
 =?us-ascii?Q?5XP+ZrksWte4f78uZpq8DyPsCZekVxeFceVmLV1gpMDfc/wAIhUqItkJ8tQb?=
 =?us-ascii?Q?EchzUO0bRwJwKBkoS9HRDE5IFL/4KmJWFM/FQddmdoRE9qYutmu42kRftPNh?=
 =?us-ascii?Q?LIXfTNzw722acNASCpxLmbNdy/RxlRlTCT+pjscUqteRnij2P/csd2BWbrV/?=
 =?us-ascii?Q?pSgKLogRLJs47k9F5kGHwy0qMJo6Gp5b6+QWy5OwzikDt/drBny3cJfnILhD?=
 =?us-ascii?Q?3oVcEiGoyilpNVkHOes=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1383a8-a1d8-493d-41c9-08dd529f4be7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 17:43:48.6311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWRHLO0qAjcoxWh821zQdu5gANTCKdbyOC67jPod4xMEfFV9+3U/OnemVq+mJJkL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5920

On Fri, Feb 21, 2025 at 04:34:25AM +0000, Parav Pandit wrote:

> I just tried reproducing now on 6.12+ kernel manually.
> It appears impossible to reach flow to me as intended in the commit
> I listed.

It looks to me like this:

static void rdma_init_coredev(struct ib_core_device *coredev,
			      struct ib_device *dev, struct net *net)
{
	coredev->dev.groups = dev->groups;
                   ^^^^^^^^^^^^^^^^^^^^^

Copies the sysfs groups from the normal ib_dev which includes the hw_*
stuff to the per-NS device?

Everything in that groups list must use rdma_device_to_ibdev()

int ib_setup_device_attrs(struct ib_device *ibdev)
{
[..]
		attr->attr.show = hw_stat_device_show;
		attr->show = show_hw_stats;
		data->group.attrs[pos] = &attr->attr.attr;
[..]
			ibdev->groups[i] = &data->group;

Which means the sysfs reported here is in that list?

Maybe this was misses when the sysfs was shut off?

Jason

