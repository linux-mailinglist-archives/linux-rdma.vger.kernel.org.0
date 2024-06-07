Return-Path: <linux-rdma+bounces-2997-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB8190086D
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 17:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687571C20958
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 15:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25B6199EB9;
	Fri,  7 Jun 2024 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R0MjQyeA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9CD1991DB;
	Fri,  7 Jun 2024 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773297; cv=fail; b=oJeZoVNs6MA+zecdx1KbzpkRI1+mF60qn9vKbqYCaqQCVaE7WAPEsJKDsjn1OVifTHNd0a/Swe1fvsouwar3fy7J8DWRnstvvH8TBS8OHRbHSPoYyjCEcYZWIAuC3NpVQDVqqRyMGedGxbR0vCjWJXh/XIR7vlJx4tnayEESr60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773297; c=relaxed/simple;
	bh=hj6Fyypx/uVZNu3NHd3nU5qkqAI/V9mLrtGdaOaptEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cB0K5BWzgEW+4QmKqJ/zwAItv+rBnVRsCtn3ImMQTUzcPqs6Jg5ImNCa/B4piVgKmZlUxxzznhfuNEQ9V2WaNxMvB6lQPqWoft+PE1QNjlz3LbuKuiOqujrVC9fLYp9kPHDDz/X9BGoRqffPzRk+I1v2ywYLznKjYZ4Al83YAWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R0MjQyeA; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiGWeH5GlOs+IPqBHPypP3I8F+6OCHawppxYC9N+A59SaA1V68/S/Rt10NBw9n4x4LaIHRBKEQslzGUuuR+P4j6Pm1I5poBNC2eLx6pCSeBQBZK+0Q+oq38ibfTFKBkokc7Fhp3ah0vjNh3CjLegKbDBYm29N4qQ+hdJymJD9rw3bXgGLRIxYkMqX0Z/aKgSOigmIMhNHA90KQiHHAgDy/tlNp2Ob1wL0S9ZnePaj7MZ4JJZdpxatUJ97uY4u5xVoOByqA4Ni7tIxQ2l8rGGReuR250n+KkEmSgtuCxbawKWkrOP6ikGpnn4DKDlFZXAnSrEI/OHFKERtQnfesjdOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsTy4KBOo4iQAUBWaR33r0vB+6gAYP/QKA6ERlfo8Vo=;
 b=k/YXSlKf2PXUeTvqWuYMQO1xWGx3Dn0yOq8Mb0hP8dmcc75Z9262Y/r1rizPPJD5ikB5hZwMlMRrZynSOgLehUY14mag3nZ/t0QrB0MDgYqayfMsF78gaqEj7l1g9bIe337MTHYQ1bhTuTkm4z8xRApFrYkbFTzqZ9LnXFjO3aG84CXNRFkzRhwMAKGSgShQJz76pY27xK8yWDnVyaXG+gZCz9RFKjIs4Z8Ss7OVwQ9jJFjak3e/4q4yetzBZiktCX1JcCuo6idSHQ8eunPdCkq1+30gBwr1rARNDPiEo69ibULMym5CJFI/bJP6IlCSgoe76gbB1pJ7EA2L1I1lqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsTy4KBOo4iQAUBWaR33r0vB+6gAYP/QKA6ERlfo8Vo=;
 b=R0MjQyeAEequIziUPZ/f13KpM98FwKhL7jyEEeCPa+SnHR3GX5FBFUsV+ZaidCEPTBlBBP4++UCdSxciIlSSRWE14fhJXrmblOi+3lGKp4X3qfXEADe2Ov6qFLLWXW57TlOrV18S5C/KdoXatBI4q9jRcygAK4w0GSQR2lhbZh5MZ5OI2HBKkUtRmXs2dPU53nlX8MZQVK3I24VP4i5eLqbE2AvG79JIjBzeSlQ+GpN97f7HJhCqzPcQ17xugJ/Os6LhtXIPAtUau7aQTyu867N4hksrMSNdmVg+ueoOfLr2LFT+lzt+mvh/bF7vq8Fw7YRjcme1OV8tVNYOdvFboQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA1PR12MB7566.namprd12.prod.outlook.com (2603:10b6:208:42e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 15:14:52 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 15:14:52 +0000
Date: Fri, 7 Jun 2024 12:14:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Ahern <dsahern@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <20240607151451.GL19897@nvidia.com>
References: <20240604070451.79cfb280@kernel.org>
 <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240605135911.GT19897@nvidia.com>
 <d97144db-424f-4efd-bf10-513a0b895eca@kernel.org>
 <20240606071811.34767cce@kernel.org>
 <20240606144818.GC19897@nvidia.com>
 <20240606080557.00f3163e@kernel.org>
 <4724e6a1-2da1-4275-8807-b7fe6cd9b6c1@kernel.org>
 <ZmKtUkeKiQMUvWhi@nanopsycho.orion>
 <887d1cb7-e9e9-4b12-aebb-651addc6b01c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <887d1cb7-e9e9-4b12-aebb-651addc6b01c@kernel.org>
X-ClientProxiedBy: MN2PR19CA0042.namprd19.prod.outlook.com
 (2603:10b6:208:19b::19) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA1PR12MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: 3207f7a9-f489-4f22-e483-08dc870494ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iPFyBIOKrt3RUMQqlb1MihMSGD4D84VLgg8mlys2h6/jAsid3jtvdFdjdmw1?=
 =?us-ascii?Q?2a/mEeDxBdaqw1CW1ZoZSxpeXmsxPm1zn7B5rdFOLgH5zh+e21Y9BnSd3Qku?=
 =?us-ascii?Q?PO4yZ8MgCdZoB1vxGcXH39JAqG5I+v+2KzybDlU/gRazdAAcacsZUrVc/JdJ?=
 =?us-ascii?Q?+K3X5JOmql2vXGTAEY5gnoA0QOPRRV5r/j8z7AITf593RC+fG0KAt4/7+QVf?=
 =?us-ascii?Q?MygI6e/yjh3irpf91LaxlNntdR6xYo5slgXKTwT0RUM71adAYLifrjbdPfkX?=
 =?us-ascii?Q?WoZjqnIVyHYc831khCnMcLCmj+gB33Zi6/iW4s7/UwitcNK96LC6t1zqeHaG?=
 =?us-ascii?Q?PDJze8aUlLX6J/hpZQHM4KUhoXFAPqqInAGmyAzIS+8HiwgRrxLY+ci0vEfs?=
 =?us-ascii?Q?5kIvwTyqw17QvnW+N7ZmfmIcxyWgJ3zf+SeO8zqZvw9dPaRra0OSbR9mdzWX?=
 =?us-ascii?Q?jFJWoZQ0++kzD3pKYwNncAq0iEzvDDQ6SPFtpUnphMXeSzA37aA+30e67qRR?=
 =?us-ascii?Q?eu6PqMYZnCb0HtWJ1AjOGytCXlDfGGubdQK5RIU/3N8HXD89If8+VeWRaMwF?=
 =?us-ascii?Q?wzCNXSlz2dv4BzM8cVJYD2sRFkH7cJxxWUucRB4BSjfLQ4N7ygo4KN2WgHoh?=
 =?us-ascii?Q?F0TUIdd7a9Y3BqEwA3+g3aA751JnWHYyMKIUn2042j8rtUsuzBytjd0HhIM8?=
 =?us-ascii?Q?PqMjI2aL1tYW8fBWCqUxh5f+L3Ex8xYMIIhCaToee4rQ9NT9a3pVZL/NjvUR?=
 =?us-ascii?Q?hK2pab9YxI3C2Zb7C4mk08ficH2Fvh0Ss6RXcDzmYUoBgFFunbTt3MazAnQZ?=
 =?us-ascii?Q?uotMRH7V/q7fyrJ3+fJlKmNfr5z6ALzAnWDspeW4m7IQj2+hDixNkZ87d+5d?=
 =?us-ascii?Q?+nUvqUMRPd6gjw/xI0t6FLaXERT+W/ZGMJftspDpE74UyFSIEzmnsNszz/Wn?=
 =?us-ascii?Q?IDLHsj1+qEu0R0oK+ZNls9tuwmR2BJJda3b5xDaBiETO7KVX1dL5GJ8HWydT?=
 =?us-ascii?Q?zE+cNslm90dBiYHxCcFe+kIBQkRy4/WrLGxPV5rP7MKz0bOFn8MbOMlDQpx8?=
 =?us-ascii?Q?h7TXxz6RtAlX1yXcX0cv4CVHRpzaOSX862z0it/sSHVq6urrOB6FhSmtS2q3?=
 =?us-ascii?Q?IfZHfbLiepxCpnL4wEu0xcHmeVdDyf1btOEb7oJI1BDTkBJpFXX3SAdIDJYQ?=
 =?us-ascii?Q?656zKhQSieD0amOOyaXaseRF3uLYDDfRqa6Hu1UZYeJC/eEsQ4wOOn6GaEjl?=
 =?us-ascii?Q?KFjLhtUhNJVfiHDmZ0lr0+UmzrlqKjseEl3UYhZf54+yLqkOV6HESRgSJm02?=
 =?us-ascii?Q?W7cGvwx48j1Etwpf/CDRw4aj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uoy56lueV8Fs8683rLAmYmD2zZGV9Ljd3cmKRJZRIihsRD16F9s3OS5kUG/I?=
 =?us-ascii?Q?yvO1hChAnZFLuwyCmsT9Saue6geES9VhspZBwJfV/qm6yglispS7U+OXLQDM?=
 =?us-ascii?Q?pZ4ajHVuy1lmmH456zv7h9w+LzooBoWExVUR8QgKjm0hTZiMWD2++ntEmNJz?=
 =?us-ascii?Q?NhdR5D7YL+bwVopkABi8WiDnRqh+YxLzNLRgG34DEmU9lQJgMVK5kr86rx1M?=
 =?us-ascii?Q?CkmBN0OPIe3xSW6V9H6G9gtIH9xVteSWh4KdmqgyxIO/ERq2GdPOehLNeVXT?=
 =?us-ascii?Q?5RqRtuciPot7ZINtNNj5xiCqlC05jpNorjmcbbx2InXjzBc3MebkJEoNCyng?=
 =?us-ascii?Q?aO+jdUTWOx83PkWQmpI/WF6GN7V4GWTxf+cbvV6NVhgld8cRzl3D5IeLF8Z8?=
 =?us-ascii?Q?vUPTPTMu1tbCHsek6zbeAewzN8x37Py8C9mfYaJtDWy+HvoNETSXyw7/zByd?=
 =?us-ascii?Q?168u31BQ13yS3md4/nP5QDK7Y6mneLA1MLpIg1AL+rqIzBv7AbHdPG5HtJFW?=
 =?us-ascii?Q?uvNZkXqFlZ/ky8er5CTW9M41Jo5FOZ4Sk5FA+s38Sge/gr5uVdgUVDtBXe63?=
 =?us-ascii?Q?Vy8UXuWFMKs+yHVoNCCR82onzFFJE1K/JiJevgWxhFHuEzvWTYXi27tRXXfH?=
 =?us-ascii?Q?d446KH2wwBFkpQtRLIuTHC6CljGO07Z1kdG7m2zdzQ3cYe+wTsPXgMxQ29BY?=
 =?us-ascii?Q?SlZ11emlVjnbdUwIUOAEhni45+1m1JHTEVw6wIQ1JWga5b7VgRYqybLIikmE?=
 =?us-ascii?Q?dG775oLN4Q/JDYIRItMTUV00e+eun8hj3k6PHeLXGTO97zRhzf2UJKY7Z71X?=
 =?us-ascii?Q?rDVkLRFodac6LTW5h1OtIQehSJtEMEW/+nWlYn6O06FI1jIQDrIGiiNZrXV1?=
 =?us-ascii?Q?oCCDFAmPr1vAUgGyk+0yJPeUwAGPFHOyGhvvY/UKe4uDV7WbiaGGUekhduQf?=
 =?us-ascii?Q?nd4bPZs9VVaq1yiwMNOB1a5mvExDPJrlavJLor7YpQWRljsJiodKfyA2F27y?=
 =?us-ascii?Q?OK2Cy3yiwHCZ+wSgHPz3EuF7mFW/DAKALPB8jpa9CQy7k1Vvav6Yjvyi4Bol?=
 =?us-ascii?Q?DsHo7E73fIzLlqLDIUkf+OdQTTzqeeMJBSILdR4ELa3+ClVrgfzf/NCZbmOW?=
 =?us-ascii?Q?O80x59SG+R+kCLLAMjcowStG4VmtnnuVRYdX05DrMibdHjPT8GDYX9jAiElr?=
 =?us-ascii?Q?1RXT7SU7lGESC8EhDy54PI3gISDYDb7XDuelF8MrRXDdW0BlLqrMgDI4V1d5?=
 =?us-ascii?Q?prxQDCndLE4eKk9WW6bqgzuwuVtWrJQAvqXGJfoJyVyDtAKYWiEsZYClWkIz?=
 =?us-ascii?Q?0vRFkf5ErMrLI7gCxyKSOgwTpDltkRY2Cv50Aa2HHpXVW1bc1RfXSFe0M3et?=
 =?us-ascii?Q?S5NJj9pxEGtkXahOlWPwHgVcmr+Y4Ap8oxLLZmzp/loCFU5ajBKcd2F3TQAB?=
 =?us-ascii?Q?IaPuFTf/PC0hjY6Uzs3LItucdoUgembRlXjA2PxOukKHvwy/B9PkS5B6dqVa?=
 =?us-ascii?Q?2cPqtLxvr2+hiynZx38VSDKMlSlNa4gJOHn3c+hhlyo6F+4FFSCKTLm96V4+?=
 =?us-ascii?Q?5BpIK521+0lkdUF+x7thsl0C2GWBk/pADOiT14DZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3207f7a9-f489-4f22-e483-08dc870494ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 15:14:52.5136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IIS+4eFPwZFWrJ3NSfyqwOyeYlWuiAFYXG3B3z7jstGPk0XsAsxn6srVQ1YpOKRZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7566

On Fri, Jun 07, 2024 at 08:50:17AM -0600, David Ahern wrote:

> Mellanox offers both with the Spectrum line and should have a pretty
> good understanding of how many customers deploy with the SDK vs
> switchdev. Why is that? 

We offer lots of options with mlx5 switching too, and switchdev is not
being selected by customers principally for performance reasons, in my
view.

The OVS space wants to operate the switch much like a firewall and
this creates a high rate of database updates and exception
packets. DPDK can operate all the same offload HW from userspace and
avoid all the system call and other kernel overhead. It is much more
purpose built to what OVS wants to do. In the >50Gbps space this
matters a lot and overall DPDK performance notably wins over switchdev
for many OVS workloads - even though the high speed path is
near-identical.

In this role DPDK is effectively a switch SDK, an open source one at
least.

Sadly I'm seeing signs that proprietary OVS focused SDKs (think
various P4 offerings and others) are out competing open DPDK on
merit :(

For whatever reason the market for switching is not strongly motivated
toward open SDKs, and the available open solutions are struggling a
bit to compete.

But to repeat again, fwctl is not for dataplane, it is not for
implementing a switch SDK (go use RDMA if you want to do that). I will
write here a commitment to accept patches blocking such usages if
drivers try to abuse the purpose of the subsystem.

Jason

