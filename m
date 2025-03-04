Return-Path: <linux-rdma+bounces-8333-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E99A4EAA8
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 19:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6A88E7C3F
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 17:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488AF28040F;
	Tue,  4 Mar 2025 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mrvCQky7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8548928040B;
	Tue,  4 Mar 2025 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109061; cv=fail; b=aktsbqUwhX8nxWhsNL2Zoh8VEAb5Ig2aAyi8g+1NpJyk9NnVAEiQ1rkcNcb2X9dc5g8dyCzfM7kkGBxvDYmJ8c+ZdTP7CqV7wv6+pdQNZ70YcGVAthuaSkaHWtniNq9di/JEjfYiuH5Wmdqe2LHUvNdPiYcHER16oD2nSYtsnWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109061; c=relaxed/simple;
	bh=nws9f7w1UQETEasNV0pcUKtW94MH6JvFiJqiZTyMiH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GL03EJxeWfSK6qWu2CZefrkDYxy0OndEoFThMCF8KR/5No3aRkvND04NOyWgtSuRDEV78NSm5vbEBnN0ajtfjNzNWI43lg0l32Uow89vbPQvoDSDllBeg6t/21ZgzTtpXipR/RWgOiETGo+xJBgNkSebtHv8vg4vcpOJnRnPkVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mrvCQky7; arc=fail smtp.client-ip=40.107.96.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSBy1IqztnTmt57LXdC89fSJv5mIKJB4j2arDtYuDvLoEXvNPxeiTk/EiwTYV2GC4AvkoeWcdxr5CeHEokERdk9Vcs7WNETH5/k1kRFCmL5SztbeIwz8XkFs33RE9Ydf6R7ZidfLTsJ74xZGOeRrsqxoEjaHUuKt7IVph6mFytkqvwesWsVhqa8cSzMVSKXmOzzQ9BePfZ4JCjQCHxea/KtuyqLM8iKnTLoLWu8RayV9nuoWSVbn/pSobCCbVrmMlBv+tlgb7Sa5mPFLI5riaNBXEtdDduecYDPAavDD8z+2MYIzeyf+B+u5MRUDkb011MtpI4khzEWs2FN48+AyBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqwcrAVeuZWSsTTbOyO2l4835KGCDpN4IKGpOFkzjgA=;
 b=BLt7stb3lsdh/o92rW/Qv6mJfIQkkslQYI+sYn18GPwfzEwhoiEGdu0SYISsAAB5iq5eZ4Tcs7KZaJxkqZrvOIi3HhEvrci8Hlpipu+oqrxzr1t0mWL4LLSuC/Fji14S3YRPZ7UHjj4hC+glqtKrbasiLDjxyjJonAru5YB11xbeBipjjNyl0/yLTSj3LFUXtx1d2JMFluNmREfYTF+bKG1OlOtBFwpBKYqFk9kEM12p2qxvlKXdUsMUvwUsPmyjIDOtmabtTra39VrxmUQ/yyEB+loBSfRjt+5zpQymlGVZYZdCSRqPcERehO0m1agKFO80Sl9aYBuIHKBUBJPDOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqwcrAVeuZWSsTTbOyO2l4835KGCDpN4IKGpOFkzjgA=;
 b=mrvCQky7cZZjFuw2gZRggH/dKGxh6kwykYUgLKlX8dSz9XW+s1Qh6h0Dfff26BVau+bTsVTo9S2PrupXqVXjH2Qwc5WHvJLGd2zUPueXZMTAuXQV81zB7TVXKO/r12Vbh8lxin/0RqZNIy07zanzXnvWkBV7CY9U3W6rBY7ovn5LgZ4NhAv2wgoOTYKlh6wx0aDBKl1TJn+ZPr726RlOeFjlprAEDF+bUeTX0F2Rd+zrJaExPBiMgjnJk/0qR2jyQF5iAt1x8ApKDkdknRPvINwVBbG507wIF/goPc+TvpXtoxaL9mCP99Mu7ACS79NQ3RDXEU4m5Frfl9KPXeVJvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 17:24:13 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 17:24:13 +0000
Date: Tue, 4 Mar 2025 13:24:12 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Shannon Nelson <shannon.nelson@amd.com>, andrew.gospodarek@broadcom.com,
	aron.silverton@oracle.com, dan.j.williams@intel.com,
	daniel.vetter@ffwll.ch, dave.jiang@intel.com, dsahern@kernel.org,
	gregkh@linuxfoundation.org, hch@infradead.org, itayavr@nvidia.com,
	jiri@nvidia.com, kuba@kernel.org, lbloch@nvidia.com,
	leonro@nvidia.com, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	saeedm@nvidia.com, brett.creeley@amd.com
Subject: Re: [PATCH v2 5/6] pds_fwctl: add rpc and query support
Message-ID: <20250304172412.GO133783@nvidia.com>
References: <20250301013554.49511-1-shannon.nelson@amd.com>
 <20250301013554.49511-6-shannon.nelson@amd.com>
 <20250304170808.0000451d@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304170808.0000451d@huawei.com>
X-ClientProxiedBy: BL1PR13CA0063.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d92f0b-01b0-4ba2-aaa8-08dd5b4161fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XqJhteSCq1zwonOKwSdrA2jnE8EyfG9uz37RjjIDSPy5KdPin2KL2++2x6gb?=
 =?us-ascii?Q?zr4YkjYTwgDAYpt7vPLDRlcKn3hwTRDKsbz3eLoPQ58Vxn/63doMyK0Z4tpN?=
 =?us-ascii?Q?tLcGa2DEcrQm7ToYkiIFIKAL6j+z6ehwbuFFfF/2vwo46RPHa9LDhz8FByQi?=
 =?us-ascii?Q?wQ/BDq3XaP8TPdTzns9YCkHa9GlQzCgpc+DJTgHCGTS69zTOci03itNkrHUz?=
 =?us-ascii?Q?lQqQqF1Kfl+B9Ns+zGZ2XPOywl0I+Fb9Uw5CSJRydwkFSUxCCUuJ4V3my+VN?=
 =?us-ascii?Q?N9FMtey0RM4dEpFVr8Lg4fZBwBBjXzKu98P3mgZJFqasOrDJj1PozuWEZlNZ?=
 =?us-ascii?Q?Wz7pBBR5LxXXz+0fOA5aWVRi01KVcFNTlG8NSw114hZszCd0/n+Eu76PeaWH?=
 =?us-ascii?Q?43fha0bK8vc8DYeiPfZwkT57oN5ukCUcCAaJz5oq84AP05YMIl4FCZebfrYj?=
 =?us-ascii?Q?Cna4wOrrHcZn90G/PeXhXDYVWuEHV9aFOXF2MpE76iXu4QOhDZoZK5eqd6uv?=
 =?us-ascii?Q?2wI9NNlJngQA7RRfeCUHRljST+Mm4cPvxb7j2klDeO6knj9lx4/OXjgdFJ+G?=
 =?us-ascii?Q?N4FXrXUW0afBvJE46Am3xR7tuA6Uxs7Uk6BXMIY5qXMyF4/JB0tDWBdsm7+P?=
 =?us-ascii?Q?618b2nuAOgKXXIEvIstmbBB7C3yX7epu58sZUnrcGTwVQteZuA2Wzf9Xhbmz?=
 =?us-ascii?Q?Nu+ICzhZc7z4l5h2GeVtHNu3S79fK1yj4RdaXmxVZe6LZXyA7tZjK6BS9idD?=
 =?us-ascii?Q?ruz5KRvULG4dyGpEKHwyRssv47B1UTRs94QyLeO2pp8sW7hH3LY5KbxhxlTj?=
 =?us-ascii?Q?avD5rztQnPkGl0BzequY41EMee7vyttJAMqLpa8bheYX0f7g2WqVnA8bZ9Wk?=
 =?us-ascii?Q?iCylsdxFQd6sT3m7s1cdc/scOd3PZ/eSFMGT2F+yom+gEcrZqUZInjMVzXrH?=
 =?us-ascii?Q?ObelxIoQxJ7pHip8wdsmE6l1Un3P5h9Do/6T/rqxarsolkcMtF2mmZ2gA/Km?=
 =?us-ascii?Q?4HVbMv18Z5BxnjF/XK+7kU03/13ADv2o0dZTGyaejFk9o9QSsOaMR9DXpzeL?=
 =?us-ascii?Q?y8PM8dZFze81Jthli8e5ggR8JNE55Fmg6K+RlEYP/NQqu7W8YWjYr1V4ef46?=
 =?us-ascii?Q?0kE2/CIRwnkb8m81CLtosEK9xoIoA/JtJN2cyZUrLzMkmtpP6ouP2WJFJdM5?=
 =?us-ascii?Q?3UKFOAa7SSUFp7xUTilQTQ0N8+hpzfcM32o0AXz4SF60di5eWAucVx9BSmVy?=
 =?us-ascii?Q?1rKEybm7jj/XNru4zn1LoaWmDM4LEhOJoGau+OJPgghCGmgnQqwtwClyQMQR?=
 =?us-ascii?Q?eHiSpLs1JPfWHPpLH5VQ8RiuHMmw/LmSSaI5sCyJtgwGCWv5+g0QsH7zxBsN?=
 =?us-ascii?Q?9HWCC2523pzyxBruw3oXp166Ri1K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b5gVO1HE8Hgtgp+oXOprg4BbAkQxie93mDPQRhbAxyM24h4Qu9RzMdQvMnQz?=
 =?us-ascii?Q?qndcSZ1rrs/s2OsWTyH7ciA8f3bkEsrWc4SmdFx//oiDVtbemUGt0Vxmbz24?=
 =?us-ascii?Q?1zCObde5oKgYdeWe4rrIZh6t5txONACV57BNjT0IGbIK9ObHoathlwS4dtg+?=
 =?us-ascii?Q?cgLc4uarsdkefT4poPBStvCo8G3D6dxp3Gue8BPCJHz6FSiPgZAQovWwWdG9?=
 =?us-ascii?Q?RG0I0svz3KFDQ5xGaeX/X3bJg8Q0ns5p4+YEZLbp17wkXbGlKRfcPvtDLLW6?=
 =?us-ascii?Q?hAnKqBcFvoMfCexf3mUBetnYNAdx7Uaq1MPUT5URpVzAMzWSVY7+N3uioiKE?=
 =?us-ascii?Q?txKLGjVCj37QGwms/lefm/kXW8sID8UMwavA/yXlUxhhciDa2SRXkaub5uAY?=
 =?us-ascii?Q?P4FXsUBrdmaTjPjqrrl2d7e8sWdH3OssG+k794yjQ/zCi+bC87QEoQwOltYe?=
 =?us-ascii?Q?vNG4zFi4d1PijPcLbycaZRjopmVrl/SYT9AdPpK7aV38Pr8DirINGBfOnZKB?=
 =?us-ascii?Q?ZdqBHrMZgh/xuZz3x4NCiKKsbv+EF0i3lLMFynLcPdYjC6u1QwQp84bkhXHI?=
 =?us-ascii?Q?AMjT1yDz3HaeKwzz+4QLyaLIDKHshOKuzmB/ZbnGHiPneY6StSUQO//MVgoZ?=
 =?us-ascii?Q?nrEmFbvkovwXlR4by3vzLm93pkjG50RqFMVxXr4Ly+mDKdnjx2bvnOr39u5Q?=
 =?us-ascii?Q?ViS03sWm4KI60dH+szveA/LFLCaQOpefGleDIw5AoE5ZqDtzeTv+s5ChcF1P?=
 =?us-ascii?Q?PXTsBR1Z5Q68CDfC0CQzpLo7i9E2/kI7ZMd6km7/Y+uPbBqee+pL6Fe4Aqbh?=
 =?us-ascii?Q?s28l3qcwFQ/iaj1rbrOK3Yjs1YuKMtjePdlFQ6F0bSTAOnidnc6rQRAAy8SB?=
 =?us-ascii?Q?UJH/0QpUw+Udtr63qj/cMO0p57/YaUml4+zA2NejuRyYMjAVkQsKmld8wuPc?=
 =?us-ascii?Q?uE02GzYeLe3SbG1OqpRlyFUfKRT/oEXoj7bvCih0RyIraAUcztLlo0mGNw6B?=
 =?us-ascii?Q?Of0DLUyssf2U4uxI2w3F2domUoPV3uXBjj6dZW90MsqFOrlRNenCTqhDZcOj?=
 =?us-ascii?Q?PXEJ2VWKcFCE97hqFGekxTHNeqCIxQC3OgA4qsGiQ1Nx+oCcYs5+trDqQiWd?=
 =?us-ascii?Q?TXbycogJkAVEhuvSLAJgHAUmfXxHgUZrPPz8+SjssKHq2o+JIAoNXuKxziyl?=
 =?us-ascii?Q?LnqOwVcFijISAMsexGkvyvcEfa2p+FGoR7l9JrN/LL2xNXRpZ1LxIXljj9qI?=
 =?us-ascii?Q?f7CyS97mntMnjmca3klPVnHN0NN0vPkLMOBV4XSnha1tV2ro5JpezvrF1g/7?=
 =?us-ascii?Q?G5hKj2AHF+cGvbrTt9bE82qgnr43WbQBwnFV/mG1byDli4uSNkwKZ5qXxfg2?=
 =?us-ascii?Q?lCu2WveHi+QTG7+dJsT1A32Q72Zfi779fPlwWNLf50XtCfUjnNzChue17BHJ?=
 =?us-ascii?Q?dkE92Cm8r2vL2RDay50gMiVJINL8BmYVdlIiIml3OSa5Sdbi9j1Q6vk8+H0p?=
 =?us-ascii?Q?wGfjYqIn2ljvJNeFgJoP1IUSMRpZD8oB/2RiCKMNd4eDnMrNiN0IzWspxX5U?=
 =?us-ascii?Q?MVvd9jb60+N30edgWyfJAIk0MgBRLsf6sM54soIu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d92f0b-01b0-4ba2-aaa8-08dd5b4161fb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 17:24:13.2963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6v2Cf4o+lsopgHXyjRZQ0FebVeo3IgBdao0qeEFfxxyDl+BakgVTv4bt3jgDe539
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907

On Tue, Mar 04, 2025 at 05:08:08PM +0800, Jonathan Cameron wrote:
> > +	dev_err(dev, "Invalid operation %d for endpoint %d\n", rpc->in.op, rpc->in.ep);
> 
> Perhaps a little noisy as I think userspace can trigger this easily.  dev_dbg()
> might be better.  -EINVAL should be all userspace needs under most circumstances.

Yes, please remove or degrade to dbg all the prints that userspace
could trigger.

> > +	if (rpc->in.len > 0) {
> > +		in_payload = kzalloc(rpc->in.len, GFP_KERNEL);
> > +		if (!in_payload) {
> > +			dev_err(dev, "Failed to allocate in_payload\n");

kzalloc is already super noisy if it fails

> > +			out = ERR_PTR(-ENOMEM);
> > +			goto done;
> > +		}
> > +
> > +		if (copy_from_user(in_payload, u64_to_user_ptr(rpc->in.payload),
> > +				   rpc->in.len)) {
> > +			dev_err(dev, "Failed to copy in_payload from user\n");
> > +			out = ERR_PTR(-EFAULT);
> > +			goto done;
> > +		}
> > +
> > +		in_payload_dma_addr = dma_map_single(dev->parent, in_payload,
> > +						     rpc->in.len, DMA_TO_DEVICE);
> > +		err = dma_mapping_error(dev->parent, in_payload_dma_addr);
> > +		if (err) {
> > +			dev_err(dev, "Failed to map in_payload\n");
> > +			in_payload_dma_addr = 0;

etc

> > +	err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
> > +	if (err) {
> > +		dev_err(dev, "%s: ep %d op %x req_pa %llx req_sz %d req_sg %d resp_pa %llx resp_sz %d resp_sg %d err %d\n",
> > +			__func__, rpc->in.ep, rpc->in.op,
> > +			cmd.fwctl_rpc.req_pa, cmd.fwctl_rpc.req_sz, cmd.fwctl_rpc.req_sg_elems,
> > +			cmd.fwctl_rpc.resp_pa, cmd.fwctl_rpc.resp_sz, cmd.fwctl_rpc.resp_sg_elems,
> > +			err);

Triggerable by a malformed RPC?

> > +		out = ERR_PTR(err);
> > +		goto done;
> > +	}
> > +
> > +	dynamic_hex_dump("out ", DUMP_PREFIX_OFFSET, 16, 1, out_payload, rpc->out.len, true);
> > +
> > +	if (copy_to_user(u64_to_user_ptr(rpc->out.payload), out_payload, rpc->out.len)) {
> > +		dev_err(dev, "Failed to copy out_payload to user\n");

Triggerable by a malformed user provided pointer

Jason

