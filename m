Return-Path: <linux-rdma+bounces-7678-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 079AAA326BD
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 14:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87168169BD6
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 13:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C5820E309;
	Wed, 12 Feb 2025 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fkvpz7Ag"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F9120E30F;
	Wed, 12 Feb 2025 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739366030; cv=fail; b=KmEutK2xkCa2xgUjqaXHpn1HBMTjGvQ4oNEiS55DmsvLGiqoVOGwXX5Fv5pJCNhGQJ7uBgoqGuLk2iWcv3RT/9NZ3lCLMTNRGJL2auzWGKR1+SKjkWdeFdLx3tj6fw5ucBIW/eoiXMbrE4grvipXbV/W+rxCBciVv1fMZzD2Lek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739366030; c=relaxed/simple;
	bh=1PXqknboHaSSuQJfNJN2geQxSiZQj7/Rjq2b+ZV/bEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o6HQYXIJrK33iOoz/SnOa4+/Aj1hEnYNRLxbM5lIrBvSQpUUiuHXMKgr4dsALRXCkoBM74lj57eqqTl4ONNnJ6cGcEu0rjFk3tUzter7DrHwqVwweh4pZ3Puinzj6bhl5YYiIs9kx4WZDpVF+cLREvfWfrthWS3deSFgap2HVH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fkvpz7Ag; arc=fail smtp.client-ip=40.107.101.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ba+eEGlNKTCldm99XeeudkGsoX19cNd4/CqCDrZ6wLtvSZ4/ql6HCNOcWpoxfxduKak8ekcPoTGtahUzUtco1u6YFj6OTrM1CM31FtotbCjriONGtf0HfvuuTT45Y+zF+uFhoUoPbiGOIYwwFWeOQQ5M3+Rv5s1OiAIjEB1qkk8Y3bkWUfembPXa++WQY2E2IEA5Txv+TiRcxc/T1GP32ZbafszoRqdiYPr+OgcrJZCbf8p5Gid/GQcGNjYQ4LRRzp6tTMvwHQATkS8pdWhd5UNKulsxsWkXf4hXubGLlloUYqqIvR4Cj6M1EgiQJwv5jqy5XwXOpNWknTmS3mpbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+U9doUJ1lLTIWpJuCg1yvI4eXv8iPGMljwd6VTGdWM=;
 b=pL2wIj3SWhRqLGlJ5hRqMIlQj5GYb00RxtGmj+lFNXNWRU1DsN0qmOVhWCG2VZLGkA0dlZEQYLMxzKR6KquBSmV5S9g3kR1DwsFoe1qsdjHbPHui1Cso3EnD2e9sH5asd7o2WBEuID8fJdXD31QfcKYK8XgusooCu8fvX90t8FgJkN3VxZSRZ9Orld8QRXDnpVvQTZGb0rKrooE+X3JjF3KCXYsOCNwhjxdkVaigJdgTKbmUqyOo8C+RLNftsxzz5G2HfoipJmcH8kZzIUnsLReP8u2MoA1+vrX6WC7gww8lQZpu0FMXMHdzOpevlo4iv8y3o5rn6Ek5LnkRwKfhFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+U9doUJ1lLTIWpJuCg1yvI4eXv8iPGMljwd6VTGdWM=;
 b=Fkvpz7AgpK35rgdFJnMOCdZnzv7sUNyrPh4si9Lke9HSlOfIuQ7n1yAtqq46HLvnzudkoWn28BXdb7j1/R7EJdeuMzvULyiy0HXVj5O1uFWWTIDDe8l6Uk1ZCd9T0QgNBS54o9YjCPX+bicfkhgLH86LY2PJh8/A7qgzasQiOS2mlPeO3Ez2AFTc8t7+2PpnlFpnOq9HO882+557QfzIbfMLUQHQmIV+vVLh7WWTAeQnjcM7KSOiQoPRbu9PGF27tsurG9jOHzDNk71aukRDM0OdZHLQDzEqNw6arSvFDIQQydkhWiYP/V2w0UvBpGGDh4TSaAaEYXW0Th4GafJYwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by PH7PR12MB6933.namprd12.prod.outlook.com (2603:10b6:510:1b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 13:13:46 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 13:13:46 +0000
Date: Wed, 12 Feb 2025 09:13:44 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Shannon Nelson <shannon.nelson@amd.com>, andrew.gospodarek@broadcom.com,
	aron.silverton@oracle.com, dan.j.williams@intel.com,
	daniel.vetter@ffwll.ch, dave.jiang@intel.com, dsahern@kernel.org,
	gospo@broadcom.com, hch@infradead.org, itayavr@nvidia.com,
	jiri@nvidia.com, kuba@kernel.org, lbloch@nvidia.com,
	leonro@nvidia.com, saeedm@nvidia.com, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	brett.creeley@amd.com
Subject: Re: [RFC PATCH fwctl 5/5] pds_fwctl: add Documentation entries
Message-ID: <20250212131344.GS3754072@nvidia.com>
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <20250211234854.52277-6-shannon.nelson@amd.com>
 <20250212125149.00004980@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212125149.00004980@huawei.com>
X-ClientProxiedBy: BL1PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::12) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|PH7PR12MB6933:EE_
X-MS-Office365-Filtering-Correlation-Id: d720a703-0d35-440b-6f5a-08dd4b6714e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aP4i7ygSUp92e7p8vqr+1pCdXRRr9x70OJUIwyId4oTucdIcny8PHbVUiyzG?=
 =?us-ascii?Q?vBPgnwFwpz5uKcbQlPbHJsZMDb+/by0oBJAVTvxLvNgKBSD+mcd2Iqu1xLSz?=
 =?us-ascii?Q?lUzT1vFe7Pmd0z5TW3TIAus9k9bN+8Q0BdWCuIl8apmka3BzoJe8SuRyUdn8?=
 =?us-ascii?Q?eYMdWI9wS475T5ql1+7tyWm1rOqBU6TPjCaa/TEtUWa0jX2QrmOdWX3md6Ob?=
 =?us-ascii?Q?grkuBh2SZiyvJg37ScNirObnW9FUkJYpqujSV1fgm+qP/YDnDBRfFq+/3yRc?=
 =?us-ascii?Q?Wvww0SHaMUvRGmeO7Uu2+rfLJjCVoffge6KXOkT7GaNC8wKTJMDRPih/XGYt?=
 =?us-ascii?Q?zCidHPhKNfGXItV2HJkM+2kjwCX89aIyl5gg6t4qModWAQssazG3w/xbu2vJ?=
 =?us-ascii?Q?yrChJnC9+fZJ6vk+DXA1PrQEwfsL64kV6NoK4RuwFliH6R8UW050W0f+1KrF?=
 =?us-ascii?Q?Ai+EmTZlSyzn+4br7xp8uxBQ6GmPWpiMueqM2WIAqC10d6Po5vB9BzKCQImU?=
 =?us-ascii?Q?uObz3yyqo64ODiFjVugr05zDsvC+takxIG0Iez+ewndUUuCJ5dBIo7/3ycAc?=
 =?us-ascii?Q?NfVRpWdsLPPN1uLycNIOvY+m2tIQY10MCnWcFMTtJz3Uz9NYKCpryctMYhVx?=
 =?us-ascii?Q?21OeHLIbBSs1RoUjAQ1yvUFsjhQGt7xgQ6oBjMJRnqEUbxAF9G30P0nBbOGK?=
 =?us-ascii?Q?a5NgDJYi25SZnEk6ZLhmpcwOV89s82iTUlHZV5VA6UwcfWfiUa8ORl7XxorI?=
 =?us-ascii?Q?6TeRnJdj36QpV3hTeUa9cvLyTPkxEzH9utpBu59u5Zw7sBfwO1czFjQ/24+P?=
 =?us-ascii?Q?Wu+dI5sgHfGA75ARIKEX56O2ZPENKw2l0wTzwY/ZaiX1w92HFCenilLQYMIJ?=
 =?us-ascii?Q?u/rFsy/lsQZjB+Ri+Kf4UxkLBZ3cvT97t5NnNIYWYt+h5MNlw8PSJ3k6Uf6Q?=
 =?us-ascii?Q?HxqvQNJTofScVUDV3hiaWNFVuNzgF2PNWu614xeAm+Ds8uDQ97r8E35unmzH?=
 =?us-ascii?Q?2WYwbcZ/vSjRJQuLZzroz+6O7fH57dAIef8LlmV2Eb5XpVVSCJBvHlAIB+SJ?=
 =?us-ascii?Q?PopmjDaHw9jktP+wQLFCZ85COigBngk1HX8ki94OI2wa0YRkj4t6JvkaEpmf?=
 =?us-ascii?Q?c1h4qh7r9LMJ+ysHy8/j1eFuG0ZxHktffPDYtEdPdCkgbkLAwNGXZcZvDoz3?=
 =?us-ascii?Q?n4gnNGfrzxtY9chSbiWpYlsTrbneo1Vab2+4Vpnr9tGzcBwFQzMUMJFi0dtS?=
 =?us-ascii?Q?PYAS9AwlEr9UVcs/FtwTdX6WjT79cHIIzhhROkt/t7Vi1B1JPRyyblVyLctu?=
 =?us-ascii?Q?3WCfvmyGQpWg69PXLtXYdF8F5zUBnDKP1LDzbdA4L8QAp9mThXE6E34u5I12?=
 =?us-ascii?Q?U2Ix7q7i8LusQlBet/+l14c8fOp+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NroDaCV3dyKF98bhHiBISSr0uqqBRls/2WJNcL7dET6G+g3Bw3KwiSGbV2qO?=
 =?us-ascii?Q?5BTfY/WpCzz3+71pGRTGnVh9Vru/12xr8ShxJzPuLK/wuEZ7gLV6x+z8zaLH?=
 =?us-ascii?Q?3LzBfoCIOmJuzA4+tW9ZDGTsG1z7EyYVbwkuft5/npBDYVAC4ygemCmzqrb0?=
 =?us-ascii?Q?myC7GcdMP1PLv5Jp/SYskcycKO/CFZG5eW0KNms9baUIF8gFD/cRonssw+85?=
 =?us-ascii?Q?WFaMmhbiOYdh6valw7UzyzmJDdW7Z6treJdGs08yWn1sPwpgEAw5kHs6WSm1?=
 =?us-ascii?Q?tenx2fnqgtXcVZ4jzw0EuhBVDhbeOAH57BvIbqHV7a8gtNrLBjmA4WcMjVcS?=
 =?us-ascii?Q?yIq9RMlNzxvEePvaTO0SDdUiNFT/BuFslv0fwDKPQC/1K3JlS3dnGYmddKls?=
 =?us-ascii?Q?JMoxFFh/JoKCh1NN3FNROHUDG2sQL6lG8ky34AJMqGacKuQdgjw8fM6kt3M+?=
 =?us-ascii?Q?anxN3Gnn5kxMvTu9qom7n/BQTxZb9C+YacXgTrot0+GyBAAO9pcy++KFfsSU?=
 =?us-ascii?Q?uCUynbNqXooXwb+eJNiz+cB2ACvLoliWi3Ghhh8LnnnpOQ3zJMgSZf6xt+ED?=
 =?us-ascii?Q?HgduqbzhTwuYq7D6hFaqiwNKFUqhgfpC1J7q5goPGAC9deWU8Q9S9fEbf0tc?=
 =?us-ascii?Q?aHHGa1pnZ+UAgq04vU8koY5lTsPtIN5+3juT44kh7zLo8PcA+DJeHu5fcHhn?=
 =?us-ascii?Q?sE2sdfQEOI30F+aPuoP/1JwWSN1Bwkpt5inlJcPbxBqusJfs+38AgXH6hVQZ?=
 =?us-ascii?Q?vLfhWxm6d/+iKauFuL4t3Eu+yJYNKJGiyLi70w35mOT8/CAnrJ5BKzLqhj6N?=
 =?us-ascii?Q?wBhZQ7951ecOqE3TjVKn7Nu5mL/PSeVp47UjIOlKLmXlZWtFDV3Gj588F6eo?=
 =?us-ascii?Q?e5QSn1ygfWJI1Cr6R9xJH30SGC0smHxYxlhIaU5N3uAYwpYytlbTUgB8p9vE?=
 =?us-ascii?Q?pbcJZzk5/X+hgRUNJhF/+AsM2pBLGwFyN7upH/5npJ614r2uTj9auSAqz0Zp?=
 =?us-ascii?Q?tuKHx2IAfEN51+s0WUc1sIgYiTneGeurPUPxTqA44UiznDJ7UXcAWzBMNdqR?=
 =?us-ascii?Q?8Nv0fOzVBD2Q7ybX8tXmkiFcdOMGHfem4qE6Ra9RxCj23UgAW07N23NDIVTG?=
 =?us-ascii?Q?3cXWtYiVVH+xFVqD4arcoe1CjTfHx+uMibOQbX6jhRdzJUUVnzN15Xay7aAS?=
 =?us-ascii?Q?HEkmx2R0EJWA4q8WXHrnRBKvqSm6go+TYhaGbAxR5dKXPAAfGkgWYclqsgzW?=
 =?us-ascii?Q?9OgOtn6+AL+HwuGPPEKPYtPUBh4+ciV+iQTcvwoR/g2b9XK3LNvhjA3+pUL0?=
 =?us-ascii?Q?JfctZ/oYNfOTrspAohC6c/cW/SNqLL0bl/3WAZP0tva0wumIz/Oe39HOqTu4?=
 =?us-ascii?Q?FBiEF8cq3PY/tqYDoxHpStAYHZqzksu1nETfCzk+mIP2SW2D6epEfMZxZKdn?=
 =?us-ascii?Q?RAnlUVF0gXz/QomrT4C1FM/naAqOYElgq3KvZpB7P7WGdM2cHKuQNZEYjGJy?=
 =?us-ascii?Q?+MgC1L9qGx++TuT4DcttFGPm4Nl2czw6WGQkxdMFgVVKVvmk1XZQWAykIg2Q?=
 =?us-ascii?Q?JnhSoBSlIboHWl9l6dU2nF1c+jM24GjZ43lZw4cy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d720a703-0d35-440b-6f5a-08dd4b6714e3
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 13:13:46.2364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LubaE1UL3cY2GjsSpsx/M8GipN/gET+khtbyrcb5htwxTcLlQsgHXgHlwdgGz/Eb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6933

On Wed, Feb 12, 2025 at 12:51:49PM +0000, Jonathan Cameron wrote:
> > +The PDS Core device makes an fwctl service available through an
> > +auxiliary_device named pds_core.fwctl.N.  The pds_fwctl driver binds
> > +to this device and registers itself with the fwctl bus.  The resulting
> > +userspace interface is used by an application that is a part of the
> > +AMD/Pensando software package for the Distributed Service Card (DSC).
> 
> Jason, where did we get to on the question of a central open repo etc?

I it is something I would like to do and support, but I haven't seen
any proposal what it would look like just yet. Right now people seem
to be porting their existing tools rather than building new stuff from
scratch.

I have some thoughts around provisioning but that's all.

Jason

