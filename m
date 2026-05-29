Return-Path: <linux-rdma+bounces-21532-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBGnE7MgGmoH1wgAu9opvQ
	(envelope-from <linux-rdma+bounces-21532-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2026 01:26:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD0F609B9A
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2026 01:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82E51301CFDA
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 23:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05DE3B4E98;
	Fri, 29 May 2026 23:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bNA12nSd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010027.outbound.protection.outlook.com [40.93.198.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C7A327C18
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 23:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780097198; cv=fail; b=mhPm4ocHD0BKp8mc2ZJkUM4Qiu/G0ZL/PWrk9687W1ozCDxJXjLQ5ffAZ4JMOs8ygEj2LSszqwttf7IIPX83FRP5upc1Z9LD1IjtaoSu2KJmr45GnI7p49KHnCPoXH2sv2Bi3qg/KArcX8G7PIUE999ofJkoGLDQ6BqQKImjXGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780097198; c=relaxed/simple;
	bh=pk8yRJmF40QJBVXOpCoCmwOjmf8RO0iqW6DNDt+aOp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uV53QGA/4qNnJg1dOk0mXTPxPmM4yeAzCTRdq34zHIkL9GOSAFzeA6+1iA42M1CS0x5AsMym5/F+vmXHx8I5tBVXUdttZFCtJS38v5O+9uQ6WjyAonxOrgHzS2BACmGdBjyXRZozhTWkDXSdUguvHeB8bplP26QzCRhahKaAo5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bNA12nSd; arc=fail smtp.client-ip=40.93.198.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHmfPsEk45wdUhmwqHuTcnb27xKTJWTxxVCGYkwRwN90TTibDQ4Yd6djLI7+PZdFhI1HCyo2RLxSEY+srRLjkMJdQ9Cl2BRlrH3PIm+hU3ISb2gPX+tx2mQlMHuFfDNowPeRA68UCg2i5J4qmnqgQsb6pbEIl2Dxl9o0YZ0JB1phrwrqjmVjtobZiEOPMmgwFDtdXFhd3khzNoBVdEXkxRWQvazqedH2MWlZVQF2bgpGb1ACd9KtO1WoE/PBFEO6LktCMZpvk3QVNQa2mCDpcPGrMjN69+IRIe/Sm1DUekkRpqoW4LCl0YgNyXSWXkMmC7pIB3f5LFyBTDfFyrAZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcXU+z+UAHdzDDZYLsE9BU28vlFEq/IdRjFDlvwjmfg=;
 b=gZDI1arwtBV4YPEKOPxD1Mb5/2y3UEmHm5SBB7wIcSbHRF2GXaZ2tnhWWFAMH2OlldZlrcK0tzRPPz8bij198kpY1hZYAQzjm6/QIhTH9CFOU/lZWU0EH0drLRkYLtOvVRjhtm83VVip2KaGVo7IffDSLfkyGHr+7MffjtL2PriQQPNgDPqQuMWNp6WakEaVa5Vfc+qABd2MOX0DPjs329mQCrNX2zwtAVNgshNo+Zsex2nXYdTxsBCRAcbxCAtfDaensxhVaTyc/YVODCEGAVIativTZdIrR6rfUiJo3JiX1BIyv4H/g7AqYQZ7zmxGd1EzVUWUaCcMgT8FvOLrQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcXU+z+UAHdzDDZYLsE9BU28vlFEq/IdRjFDlvwjmfg=;
 b=bNA12nSdXpwCJU3LP1Y7xo9Rjm+7+g57VyVlugcVNbB1T97cLZ04kiGxSpmtLM7QzMszeGbqYnSmsjM9pOB69LBQbL6bh5JRaejl2HkrxqGgXah+4eITK7Lojfuvp03MU+UwaGkTHKLJbwqGXtf/eNWcP5N5WP+fAJBnSxnB/AaquBI2chUY3Q0IxZOFhdWge0z6CdWFhhsvglVNalfchU5AwFmNbuCXoAb7ZxS7g8quX/kkgDIoXK1oVXoVeIXcXx6uI1p78FsMjfSDQpq4rIJMXqVxWMx5JCchiQEN4lGh9pTPoQ5ndXIbc819g2JtP2yKn1cTjvXzzr9dulg2mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 23:26:32 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 23:26:32 +0000
Date: Fri, 29 May 2026 20:26:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com,
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com,
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com,
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com,
	ynachum@amazon.com, huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com, jmoroni@google.com
Subject: Re: [PATCH rdma-next v9 00/16] RDMA: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <20260529232631.GA214722@nvidia.com>
References: <20260529134312.2836341-1-jiri@resnulli.us>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529134312.2836341-1-jiri@resnulli.us>
X-ClientProxiedBy: BN9PR03CA0743.namprd03.prod.outlook.com
 (2603:10b6:408:110::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 1efc8f1b-e66b-4f18-177a-08debdd9b7f7
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	GpVtVEDEHVh7iBp/1eW4AHveDERc9dSAKA0NVueeKjOpD4O4yz76uAwRZHEAcGtxr3wg44Lu9jqScGmthscn4NM4e6g1BjmaMck5Gre8CRvONOR7FHKYHzCYUFDBoR3LPSNF4ARG9gR3TDCgOmDpbauPI7XYvMkQNr+q3HuEB9gwD8TIfEsZXaEk5Ey4pt9Vw1iuNVKN5WqIbU+3wRJCll0JCguZm/+TfhPuc76iIO2DPXkvXS68H/Ew6EDC+srw8kJ2iJ5d97oQK9f+3ni5TE+084zz4l4q7kBNAUfrX3vwPihXPQnp1xy9SClIeBMLkQGD0zsWb9GM6NjP8vRhH3P/ACcgScNjvpnf8PJSXI2HLKtkeyiOJ2/bkGBkLEVPNGvlvWViBoReulV7D1LbgF+qLFYByJqp9Sc7AQaZ1u3Qdb3KkIXTBuDhORjNKn2w5g9VSrEW1VEF8XruiOxE1v/rW7kAO42KyLO2pvJcPQx7EpG/+4J2OfCOurc43PRMXUZ8YV9cIhMEE6BRMakPWfRei5h9B2xpp2X1OFITfQlSMcbxQOiTz7RmC8KKo6hL/xVXvIQGRMJUaaqnjt01jXnfR9sdzHlIJ3BKeDMK9q+OWVVyQXsVSsD3S/P4LmJOTcf2EvTWPp4Vzb0yxRIhZHgNhioV3OKEi+IYCDpvZzQq0NijI3M9Z5EsCBAhYJwg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(11063799006)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k+vBwLOajG2G7NdwA018TzCRoiS6GuV2U4vEhPyDJjcl00OxtWsIe7qH3JDT?=
 =?us-ascii?Q?HwAQMV2lPB+4y0C3VLsLmF/vAdUH3aQODEAHxNEwkrIGkwD3LgtTGBnZEZ2L?=
 =?us-ascii?Q?tuuRdFcBwiv+Fiejj/dpsc45KgoyHnV7MZx0Sy1obvsVu6AFrnxWU/wFUadv?=
 =?us-ascii?Q?Juqz5MdGWB6rdXqB0yxkxkBac5WJkJOCFdjoBqMeZ2S4X+hSNeiglm8TwkGH?=
 =?us-ascii?Q?SpCCU5oeUPInu1oYh0gm/ilH4XxhtAk548pQtKUpkeDJIk/3H9YFY1swZTjA?=
 =?us-ascii?Q?vn8/+wPHYHT7NOcNqGeV5vMc16IphEMtaM+kf3T0fAzbq3mgO6/yJa3rc54S?=
 =?us-ascii?Q?2ug0yJ3Rv1+q16y2fr6STG7Ll+6JIwXgPy6APj364Pp8HyuOoZvi4WMwSuTc?=
 =?us-ascii?Q?qqmQuPNWG4YJ9TkctV2LcnKvUOMdx8agMHhsF0ci3JSGnFPqjH3PIz9T6WXf?=
 =?us-ascii?Q?HMGLNAvmsknmFwnp3EyUc3318mGu0BxBGRIxPyR8OkRhCDIDdYoQa7HQ1NIe?=
 =?us-ascii?Q?VTnbLR1PHwoqOP+sPVhdLIsBHBsKHMMwXrTV1V1SYdXXbwcMSatFEzewE4R3?=
 =?us-ascii?Q?kh5gHIQXFzOuOmuvpPMRcU4jm1XkX5LKhOQJB2Yd0B4CiT1bOt1aCIUrnqS6?=
 =?us-ascii?Q?cw/mODzd8qiRZ0DQBBPZ2PhVwMwqujDYddM2nfMjswlt5V21iX2Ju0EW0kWN?=
 =?us-ascii?Q?xDL9xCRhDku6EBAIKM9xG5qmJO+t2r7tu2EkhE/j9I7grgNhTABoidVXq3Ul?=
 =?us-ascii?Q?ngaokAX6WfBXCoq+RFduRJ4LxO7iu4QF2BZpfhE4UbSDiNA8p+6fzt8murmf?=
 =?us-ascii?Q?yt6V3f3tU/vXjEKqHVIkyJ0MA2FWEUXaVwGF5obC5hPKy8xEHis0zVYSj6k8?=
 =?us-ascii?Q?hjqByie4V65piei2cWNjLtme/VdoNfiLdYA7ib+aJSmztAUsivXnI510BhVC?=
 =?us-ascii?Q?VQm8UgVYcS0zJkSrfix08Xn+cnyc1HWukATG95R58f9qehwmghhpjZZYGxmr?=
 =?us-ascii?Q?mZM5fcGLKYhIz2stDLFip1U5v24T3rHGr1GDoM5IGX/JhykTfyQJtvw5OE/I?=
 =?us-ascii?Q?w4B+Emh+jDPY/gaw7CE9UtNeAOB9bnaD1RoST6cGjUTqAkvPDE7/LLJNVkM4?=
 =?us-ascii?Q?Tm6SLKnMs9plOVkd9gdNim1WHEFGSOz399UU0ByMIE3IBc3sex3iNQzMGJoT?=
 =?us-ascii?Q?qYJcIslbAPonTVzHV07YRrQp3sJILv4Y+1d8x95IGK21dTWytvc1G3ChZWAC?=
 =?us-ascii?Q?fHq5PUl65ncqswZ+n3jFJ1jCEXo21WYbaoTkDFKOugnEgyw2i+IRL9KkoRIB?=
 =?us-ascii?Q?6mv2KNNP+JnNQrt2Hr541AyIOFhlKdnGEQbMBuJnFTlUfNLIsNguW5qP/hBs?=
 =?us-ascii?Q?UnsxomHwc0/5mL5NB7hN4duclCTar0SK9Vx0tp5pgvUPIxHa7cx8KLd62a5V?=
 =?us-ascii?Q?ooZ43zAgmxyFXQB4wIHHtDrHWy3zRdJPM0/b9tOBNmQFzUNrt/klX+cNqSXn?=
 =?us-ascii?Q?dsh03B3lheA1ZCsb7a6iCwJok3U5QDz18Vl33lw0fekfnDTkg2Z2QcqP1lgv?=
 =?us-ascii?Q?kBwulx+KphG6K9Sx/Uz8zvJZ929EeySPoOF7sXmF3zM5ytQrZqA72FKj+Q0O?=
 =?us-ascii?Q?szo+hOSBmMg+1sBURYhV2LknbSzWEl5YcK45F4opx5H9YBcBUe70PWlOP5U+?=
 =?us-ascii?Q?ycypdkbl0K3V5os8wKuEvOZbOW1h3i7dgzPMCErkJsSJ9R9O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efc8f1b-e66b-4f18-177a-08debdd9b7f7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 23:26:32.7247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qo1oZs+fNhv4ivFZ1MnQz495UGxL/fkXjE3DDVo7HqnsYXaI5Xujd/2DhqQWH1hS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21532-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: BBD0F609B9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 03:42:56PM +0200, Jiri Pirko wrote:
> Jiri Pirko (16):
>   RDMA/umem: Rename ib_umem_get() to ib_umem_get_va()
>   RDMA/umem: Split ib_umem_get_va() into a thin wrapper around
>     __ib_umem_get_va()
>   RDMA/core: Introduce generic buffer descriptor infrastructure for umem
>   RDMA/umem: Route ib_umem_get_va() through ib_umem_get_attr_or_va()
>   RDMA/uverbs: Push out CQ buffer umem processing into a helper
>   RDMA/uverbs: Add CQ buffer UMEM attribute and driver helpers
>   RDMA/efa: Use ib_umem_get_cq_buf() for user CQ buffer
>   RDMA/mlx5: Use ib_umem_get_cq_buf_or_va() for user CQ buffer
>   RDMA/bnxt_re: Use ib_umem_get_cq_buf_or_va() for user CQ buffer
>   RDMA/mlx4: Use ib_umem_get_cq_buf() for user CQ buffer
>   RDMA/uverbs: Remove legacy umem field from struct ib_cq
>   RDMA/uverbs: Use UMEM attributes for QP creation
>   RDMA/mlx5: Use UMEM attributes for QP buffers in create_qp
>   RDMA/umem: Add ib_umem_is_contiguous() stub for
>     !CONFIG_INFINIBAND_USER_MEM
>   RDMA/mlx5: Use UMEM attribute for CQ doorbell record
>   RDMA/mlx5: Use UMEM attribute for QP doorbell record

Applied to for-next

Thanks
Jason

