Return-Path: <linux-rdma+bounces-2006-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1172B8AD5AB
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Apr 2024 22:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D4E1F2139B
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Apr 2024 20:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD791553A3;
	Mon, 22 Apr 2024 20:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="saL+aBg8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C1C153BE4
	for <linux-rdma@vger.kernel.org>; Mon, 22 Apr 2024 20:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713816641; cv=fail; b=PGUBEcC5XJJk9xkQxZ3pd4IREWwgaWtQE3ekUzPMLiluEhUbDtG+GnUaminXNBjBEkegSQRCQYXEY5eWByfWnJydNqG827F837X42hmKm6K4c3S8gCxOTKdJd/I7MrqeVtuqMxHlaFmzgXlslrhmN1q7l+kH7yHJTUmotSqs7YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713816641; c=relaxed/simple;
	bh=m3EsFwoaPbzLHwNXthol/bpXkMxrWTdl6GCbPRf6lFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ua262VPvZ7/zxKs69VitxVwmtR01sgSpOzXPBqM8IX9GkWdFv+fvxWIn3xg7Ak6q0TsaGlTDQWRoCQPdhxB1w8WUzurhyqORxqrmoNbi+ASPTBT9jpN+FrWVKom4WbZ3rA73d2bnaa1KX6NkxGEFZp4qsFFAlzhFfW7pmwUxBJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=saL+aBg8; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmeUaV5Z+nTh3hXRQuJkhikhIfnH7pMbgPqmOmQme69KfhUf96p2cgIEBt2QFr8aIQpXDuNK1MuCy/7C098IMvvcrxSyeh9rcsqcgAZq1/sOVWkmpcBpobe6Y+HytEuvWgRCvFZlZvAKFOk2U0TeKR+G9N2q5YICAuq6zemmQLufGRBlLYQfE7iAntEo/gLP7dVDWipcgjbyisEmhXv/+uESQWoK+vMaslAjjrAM+md9D09GTNEGYvVsLJJ+AkJlH2FFEtSZfgQvD9U3Vjqlojw8G7gRie0O8snTXpx74lqJFSfeGhl26/zHeY58PT1fk61wLIpDBucWBVTI0DOhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGRRtRa6qrRhjFcvjsoAZn/mqTArsneukWMHu4bNUsg=;
 b=IMyrPGdUwwib1Iw5yW8xzH1b31FZCMZWz2X5WXkCZ35fFzwBdoCNeeRspuoq1OwC1R9krefRzBY0N3P0BDnAhhpLdrW5e084/6saByYYE+6zkLtdJA/u/u2bLZ8oY5y4Yiy4fBP56mED6zViJbnL5D6rGAJvhd4ZVa/tmfEumO58HvVQrP+jOD4bKTdNfkIRPeoamcJ1lisYyNEgkzqVdHf02jtv/1WVd5M1DcAHe/urjIuRvuno3Ax2bWgMs75NvrLqlw4TNIO+vtXfMxfApQkmt10iX6w2UtNE2hhp80Ei4Q4Zik51c2e+r4HFIbar25M/SAIQSdgvJP5+Oa0zag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGRRtRa6qrRhjFcvjsoAZn/mqTArsneukWMHu4bNUsg=;
 b=saL+aBg8rgMlIZJb7kJbVEiN26z4rh0CWy18eUTJHPl9E6l6u4X12TuJZBhWXCB70gd9H48xmtKn2fNzK7Sxv4YrMDcy+npd7iLq0N1BXTdkqvk36r43O2wfU7hqhJYP1cSnVraucRC43v/oNdsvzTYEZw8MSl7sMfCRqZ/tcr4zrxzqgIFh21vJO+9PQw7tOaHwL/IbuiL/99CSxmWCPg59NjSCvrxpFeg+BxWWb1hyQcHETxulfDbWz+k3fNHYt4FLV5jHcENPjkS9QX4Lig7o+Eixlv8NEaZheI405fPW6iucLZfXbhaCer+msZipcMca1HVz1DboazG5t+St3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 20:10:32 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 20:10:32 +0000
Date: Mon, 22 Apr 2024 17:10:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Bob Pearson <rpearsonhpe@gmail.com>
Cc: yanjun.zhu@linux.dev, leon@kernel.org, linux-rdma@vger.kernel.org,
	jhack@hpe.com
Subject: Re: [PATCH for-next v3 00/12] RDMA/rxe: Various fixes and cleanups
Message-ID: <20240422201030.GA310416@nvidia.com>
References: <20240329145513.35381-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329145513.35381-2-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR14CA0013.namprd14.prod.outlook.com
 (2603:10b6:208:23e::18) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ec55fb-8229-4c5a-9d5a-08dc63084355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GVG8IMp5QcjRuTRF3UVy5YnCPaIgFoblZ90VGpF6NKLylsVHLL0spzio916D?=
 =?us-ascii?Q?j/bINJOjYmT39XuUfoDS+PH+aRIK0Nz5Xnwt0/Lvxx3KZ3MZ5DodSP7xxF4t?=
 =?us-ascii?Q?7i+gqxYG9UkBoWli7AhZO6pQggaGvWiU3xapaGbytZ5WV90xKbU6ge07d6K+?=
 =?us-ascii?Q?nxvXDq6BJiL673Fqy94CLKHK9mNUnF2WS4GjINVNCQvQ7B/O6GbX/bYBY1dq?=
 =?us-ascii?Q?UaQGmNMNYdE56WwCFU+of7ENNSAYwAccZfqYSFWhSI7xxHnCQFyOVZWSoQxi?=
 =?us-ascii?Q?LC4lmStS9iSiYokFvzh5jp+Pc4XmY8gOMC1LqX2VcK95nYnDp7758w5LDz5x?=
 =?us-ascii?Q?+fZkRsWF6+BsTNSfASSBVef9We3TtrpjgV+Rrvt9zW/1OuPFWXrY1DadgO9s?=
 =?us-ascii?Q?V/8GLaAuZH/AqaswfmknX7Z8zqDS9WqX4rS+ra4oYGYCuJ21fi5RFrHwOr6S?=
 =?us-ascii?Q?kLQ6+/jVslgFYZ0ACuvRTpizJ7fdF0NOEr7l/XbRXy2aju4D/zUrvQ5pzfVR?=
 =?us-ascii?Q?xcN/v3AsWAaitQnb9RFiPBPDGLeAThroaOkdwIPAfE1WxA5UBB22XGf2RF5h?=
 =?us-ascii?Q?fV3gY5KAdIdmfATCgqF/5UK/J8YtoTj6PL0gxnieiFzR8Gh3wg944eUe6lXB?=
 =?us-ascii?Q?KpvzsfUhstEWZaIRPzczUHq2eZSuL9rsYHXlBRrx58I7ZkBSLubmJ8OKCaJo?=
 =?us-ascii?Q?YYsT9USbGrGEaqcwCQo6OAzVipdWOacBEosrp5U5Ko6EJh49tGkp8SewJV4o?=
 =?us-ascii?Q?5arofPNoM/vw+e2OO03ypC7DXlYhu8r0tb8lI91Q/JTuqRkAcIsJ2bIxq0F6?=
 =?us-ascii?Q?ZVXOiZJmDOuWZOGW63ctcEh4yth2daRaSLBpU05ldIxvgwel4paQKonSmRDB?=
 =?us-ascii?Q?T70ZwNGw4Zk3S4uxovK2YMXkunsw/mO/lEAvFhuHDEovV2HLArFtGLwMO44U?=
 =?us-ascii?Q?J+i2wnAndKIWc0rtHvjB4QSO4F2onte6lMGYH99XTYIQWJWh5qSMmCJahY6R?=
 =?us-ascii?Q?0x8S/4jSVXKgtZjDUuxeb+D3OBaB2eopx7wW15/4D2xsDNw7/MzJTrHoqO7U?=
 =?us-ascii?Q?DLu1iARiH3KrshV2NB/sKKqljppl68rrMcZGqnVoLQTyssFnsy/6oCgP5B7g?=
 =?us-ascii?Q?TjNTkKAVT1tpCz6WoHLd7i0uUAgFxrmwZ33ZM7X/ZHJZ6ozQJMhoQZvbwhsX?=
 =?us-ascii?Q?l+anTL9boy28XuEGZPKNfpQLGrw9JvS9ZKiQp8y4WXuyKJ5HYr8A9ys9JLTz?=
 =?us-ascii?Q?p9N/ZEQXsaztR/sSz96Vxqb09ZKgHIh8T/EoC0xObQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8aPThOTvJlBUJ5rPTbwdt6xsVQqXKzE1kwMgiW+WXpQ6ndVel8NvniYaV7pb?=
 =?us-ascii?Q?KOiINz7+TVhJwu84dp2ii5l00gc+v95qTwJoPc6L5u3eGug5w64DyxOBF3l7?=
 =?us-ascii?Q?yd+lB8CxZWITeIufxMNGrKJmkEyQmAaZCVVEVy6koxiy0EMFmOkbV8IA6/PZ?=
 =?us-ascii?Q?7Cz3pPKv4xzU+eS+g4q1Tt0ABNsLl8fhSPr9TWEhzBloeQIbOjmQMmCKFR8D?=
 =?us-ascii?Q?TM51LQMa2IK0JXP4mADe2ezDo4zthmDUrMq9E0c4RvKVfLiGY+3bL7bbC+ep?=
 =?us-ascii?Q?k6qo1JPwO6axoI9GwaSxk/fTYisSbJI11VBTNVpeMnCtUPymxEWpREUmMs40?=
 =?us-ascii?Q?VnqYiowclZrllDBn2Hyr9xLF34rquUCOLIV4z6GXkLKkC+tRnDDkCqWAr0uM?=
 =?us-ascii?Q?VmX8KE7PDvKCtMC+ptT/OAAXnIZdAgP1nr3u6VbZ+jglz6St4ogRNr0ujf8H?=
 =?us-ascii?Q?JNVIZl3DRZaDhiUMmuBqNgXxeGxg2vt539ljYAFb3LpBSJ7N51IzuH2O1csS?=
 =?us-ascii?Q?j8dD4R3ecCxhd6H8B+pD8ArSKXY+u899vcznrdmKUpnzv46gV8pKhiraQlRe?=
 =?us-ascii?Q?eyo4MOMhUgWHUJwNMwjYssimw+Y9vZfMGKack4giWkjCmMHNkcT4DdUytQhu?=
 =?us-ascii?Q?qaCeFoEy3RkP/akwMEssfA5sN21udE5LNtWY3wVHjhfMRBZmlIhZXnh+K1lx?=
 =?us-ascii?Q?K1obXCc35BpXSQMFyKmcHfVs70bsMlHwY8HJZJkghShjnYIrqGeJnAGGSKSX?=
 =?us-ascii?Q?Eg/xoeZtHXOBVJ0VMLVRgnZjbSm387KBikDbsXhFoaVeEdvyNdv6xdS/vshf?=
 =?us-ascii?Q?DrzrseeqPCQ9E1nqJgDrAIe0PP6JkOUUwWQ9hTPz7fzn1EbNHQnYbXsmx84H?=
 =?us-ascii?Q?nbUy2B1Abeub/q/UMIDEPyPY8dDw69CJITUpCuRMmVV7Zz2qu2FHB/xqTKHx?=
 =?us-ascii?Q?dQ1VJzDEwRe+DwJbq03Nl3l1K/iuVycR7suKYax5Zd8cRc3ALhCkdixOmTCn?=
 =?us-ascii?Q?KwCC1sx9C1uGn8/AIfx1K63VBiBscMeIRk6Yvn4/SN7q8T2LaV8ruUxalli0?=
 =?us-ascii?Q?/AvFXognbAW6h9LqKynvvh8HwjUZMBU9IdjDnlv6TQ2DDIsfr4/Wd4nh4qkV?=
 =?us-ascii?Q?eVQ7mmWaESEyqvf/Byrbe2QzUMjZcNVtWjNIiPLQuYbCnI0jTWgdXgEbknEC?=
 =?us-ascii?Q?Lc5LctfvGBTQj2ixCNLFwGiuxbwcWkX9zRIGDLKm7MsgIDg7LUXd9I8g7IgW?=
 =?us-ascii?Q?P0w8PPSX1hBTC25oWuwJGdoMVDEM8+rjmkI3h3EbIK/DfVyzvtgvOuCIbMaJ?=
 =?us-ascii?Q?W7H2swUgnunAciwZvaVIVMQJ74dKr+BT6Dy6XZsPyetXeyEQXpce3kulNImM?=
 =?us-ascii?Q?ufTgwLCqm7BegpByHR+oxXga4O1t9rmCkaugEJEyuDZ02oWaH1sOrSDVbAsb?=
 =?us-ascii?Q?/BCfk1M2kERe1ZdveHpp2tiVQ2GSe1t6xoJuNfre8kI/1phdzjaYGEquaCN3?=
 =?us-ascii?Q?+s3suYE+6JWnBMJ88Li/PYR+7mpTIMRi3j+GSS5l8pNjH9z9qUtF+Hq6wxE0?=
 =?us-ascii?Q?Q7uHApWOgrXDmltcFOKNadbOi6eDFiIuXh0zv4o/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ec55fb-8229-4c5a-9d5a-08dc63084355
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 20:10:32.2731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00usF9BS8MI0dr/OlPl1s7rGEontQJhNAPAArwrdHkcXaErA0563iosU36VIl0ID
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453

On Fri, Mar 29, 2024 at 09:55:02AM -0500, Bob Pearson wrote:
> This series of patches is the result of high scale testing on a large
> HPC system with a large attached Lustre file system. Several errors
> were found which had not been previously seen at smaller scales. In
> this case up to 1600 QPs on 1024 compute nodes attached to about 100
> flash storage nodes. Each patch has it's own description.
> 
> v3
> 	Fixed an error in "Don't call rxe_requester from rxe_completer"
> 	Moved run_requester_again from a global to rxe_req_info.again.
> 	The control parameter has to be local to each qp.
> v2
> 	Minor edits to some of the commit messages.
> 	Added a missing change to "Don't schedule rxe_completer...".
> 	Added a missing change to "Git rid of pkt resend on err".
> 	Added one additional commit.
> 
> Bob Pearson (12):
>   RDMA/rxe: Fix seg fault in rxe_comp_queue_pkt
>   RDMA/rxe: Allow good work requests to be executed
>   RDMA/rxe: Remove redundant scheduling of rxe_completer
>   RDMA/rxe: Merge request and complete tasks
>   RDMA/rxe: Remove save/rollback_state in rxe_requester
>   RDMA/rxe: Don't schedule rxe_completer from rxe_requester
>   RDMA/rxe: Don't call rxe_requester from rxe_completer
>   RDMA/rxe: Don't call direct between tasks
>   RDMA/rxe: Fix incorrect rxe_put in error path
>   RDMA/rxe: Make rxe_loopback match rxe_send behavior
>   RDMA/rxe: Get rid of pkt resend on err
>   RDMA/rxe: Let destroy qp succeed with stuck packet

Applied to for-next, thanks

Jason

