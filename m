Return-Path: <linux-rdma+bounces-8339-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 007F8A4EDE9
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 20:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E17D172A52
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 19:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BB2259CB0;
	Tue,  4 Mar 2025 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HYjel3U9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CAD23312E;
	Tue,  4 Mar 2025 19:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117959; cv=fail; b=ZC55aVkjg4lZjicEAjkl2WH47eOEhO4i/PZq8gSESKHu4w/U6ZN53brk39mbioNANih6l6lNZ3T0bBWdhzhHqJOTRwp9jxIjwqOM6EC6QSlLLUy8Xzrf9LiUXAfKLKVmsguEyZc6e+eNZM0fZmj3IeTiJbCWbeDOfhqstkV9Thg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117959; c=relaxed/simple;
	bh=eM7bFYROwnF6849ohv2lN1IhKgId/giiSto7m4ivEOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lOmpUfZrsPse4qDZqQs1hzZtsbE6asFpEgOjumzS91JLo4dhGyy26Qf6Cd3qwp1/S8ILBs9+UJKqGNEdVoHTjKA7+MF6bQHSbC14GgqEZv/XPgXy3fIFDsQM6/cvwmUtlqBYRhNqS4a/Ece2pr9jnE+thnD/Nubb4CgUkgqVDuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HYjel3U9; arc=fail smtp.client-ip=40.107.101.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpBEohqYdyxzmQblhIc3Ia9Xqot81uYGRLCwRDyfSAy4PDcvrhaCu2bfbU4gUmtFIqpzcku2XjSGW1Ge+BLBFZEaDXZgd05gRFXd3gaG/h9qdGl6WEEb4KjICqFsFn2KBG65sU/Hoc9nf6RLmA8wJCpTHLDEM53rRj1jvwnpBX+hD4rWUg2+G9BPS7F8Y6rbPB2DL61Up9+iJY5a7/l+7Yfn5WALIPLnayHaFXOLfv////7tNShAJMhPAll4nkhAjmb6UYj8m1MKADyg3ArusiVVqtUnoUG1CTM+EYFrHH0lc3ZDGqW4+Qcoh9ocHssVW/MEh6p0hAQL+KDFrLANDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUWEW0NXoNOiLriECWr1OFSiHCX0JiFLYBDMElWLWiU=;
 b=L7fW6wPaPFqPshsMKDpktNMA23y1TVdi+Q72oKiCIRly86aj53PtWFzcGaUejJzDL+6MszXxOeIKuoqkVgSut+vbvb5epoy55Inn8dAXDHTgFoh8fl+ksyD9jjdGVYax+xRmso67+G9CVVfE7NM3YR7ZMwrEsNnUu9Zv+X/UTte3cM1komfnXYw6PT8Y6ncI3Icxb5JgSn/en/+e+LldfSO8KcWj85tpa+4SuTFUNrSVT9oOCUG5OUXyHMwtbMRvrWj2hnl64X+lvaFmYBWv20yKvpBbJrxKESYI4ljveteGnAd9ky7Azi5qui7cqnde0odoK7FjPr8m5gxl2WkJNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUWEW0NXoNOiLriECWr1OFSiHCX0JiFLYBDMElWLWiU=;
 b=HYjel3U9jyQhb8EcCLxAY4NVk8YBzbd/xqKohh69yjMbh8YFpRUbGEeCMkWNtyVUIFlsmfP1FT2SecWpi0m2xSLFRBZ3MrInxCT6s7wv1lNk3eMHkvNb8N3GKHduiXdoqdubiuFFx8K8PpSpF6zb4OTvcLq1wLz9yPuiRApYw6npWkFVUOxMFzwZ5tKqqS48ITnOVVkfyJ2H1MlvgqGjunSleawIFS/GzU7OPS3MjndBnr+Ksre+jfsgvF3j/Sr1h0PqOO0F+otmjJKZP9SyOWSHdwwQUjFCONA5VoaiBMZcmJk/8KSmOpk/W97HdZaZ0LBZbYMtc9yKxWalF6Cakw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 19:52:35 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 19:52:34 +0000
Date: Tue, 4 Mar 2025 15:52:33 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
	dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
	dave.jiang@intel.com, dsahern@kernel.org,
	gregkh@linuxfoundation.org, hch@infradead.org, itayavr@nvidia.com,
	jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
	lbloch@nvidia.com, leonro@nvidia.com, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	saeedm@nvidia.com, brett.creeley@amd.com
Subject: Re: [PATCH v2 5/6] pds_fwctl: add rpc and query support
Message-ID: <20250304195233.GU133783@nvidia.com>
References: <20250301013554.49511-1-shannon.nelson@amd.com>
 <20250301013554.49511-6-shannon.nelson@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250301013554.49511-6-shannon.nelson@amd.com>
X-ClientProxiedBy: BL6PEPF00013E05.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:4) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 62353ed8-2c5e-4f2d-a13d-08dd5b561b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cXsO/FnnIkvCzNV4WUWFz7HG0Z6fVYoR/eg1jXOgOwUKtVhNBUnQ4km6P6au?=
 =?us-ascii?Q?JYikwqOSWYLB6tmKofJ2ed0X0UnLvrxOrUlrzpOGKZ1i8GyIxPrzaDmZKtw/?=
 =?us-ascii?Q?3vMzEk/o1heuJ0SpWLpD/1ZQrP0kG+01ZpdDt4MvWufsLpbC8Fdwyki2aag6?=
 =?us-ascii?Q?ocj85lkQUJpvKNNich9hvF5wWxv7pPQxKDX35UD4hg8fiUQEIOQi3vJT15wY?=
 =?us-ascii?Q?Armx2X8uggAOjlAVbpeL1le3FZWPijEKU9rFmZmVADxBpPzgwGjtsi0BJn47?=
 =?us-ascii?Q?WStDJrRH5s3pwhmqAIH56L302XzM/+hmq8InZZ5sKmWkouyp2t4bpLtvIDVu?=
 =?us-ascii?Q?LQtYcio21nWtaWqYJcGrlvtlrzr58WNGeFr6PPxkLZvYHE0y/VnLRm563GRB?=
 =?us-ascii?Q?k9S2FaA3AhHKKkJcmTVvqr+C4awPY6xIhP5rQMcyvOv4kDkTVoSFb7npMdgJ?=
 =?us-ascii?Q?ZMkfGDYHexwZRMq9FyeV6KWvi7Rym5D2ACSiItomX2ICl+DFUIy3hudKRjeu?=
 =?us-ascii?Q?KBtCPQviQpM7sTvFkjkKvFodtrwK5VXESbPvTDmyDbn7T1oiy7d3NlPZf7Cr?=
 =?us-ascii?Q?Cdg9GSE7Hczlp2vT96ilQPQ9crBMrbV7DbcbnDuS6bHymFP6fzXks+mfzEsY?=
 =?us-ascii?Q?FfA/c0QKVs3F6ARFLZ3jMT/55hB8NSoSQNcER6icUz0vtZXIFtaqd2fcDnUq?=
 =?us-ascii?Q?sY9gvQ5c4Nhus6SkI6usWoavHQ3VOsKuTewedu14OaAljdNTYbFYCAxvSNiv?=
 =?us-ascii?Q?CfkY5gsc6V5uEPPMaZXy43BbNfqSMS3TYxZgRhzNgQagWWVU5FY+cZ0AeHb1?=
 =?us-ascii?Q?IWp+e+8dCgKE3MrhWl+fCiM9EJia12oEw9Ay/5VQmDpuafTa5irGTWti7ce5?=
 =?us-ascii?Q?WIMD7APmrloQu1eAAmlH/kzp44TpqFXbB7idKRqWl+2Ef4vV5CTKFeUxrN/X?=
 =?us-ascii?Q?HJ20j+tA66KwP9RySEoFBhYyyhgp2P2AXOfTnT+xfUBUINeN0OkWJnUsH158?=
 =?us-ascii?Q?0beTJCJcqU2SclFC76NPXXjTbYbejNbr6BwTElIcxQkFCR5wsNaKDC5RWzDR?=
 =?us-ascii?Q?pG7zPIDiOJx7op1MpZ9qClH/yZXczyw3H9UgK5KJMPBezAg2TH8eNFbk2CWs?=
 =?us-ascii?Q?hr/CNEl7md2Y82MQVuOEqgyqCdqop446zz4mYmbRk+QZsypOX2bw+xnrYep7?=
 =?us-ascii?Q?hi+BYLK86N3W77jKcT0tlvB6ShXEdrsVvjn0BaLgslF1muGZ5g00ybULEHUq?=
 =?us-ascii?Q?F0hkPYgrYQAWi2T1OjqaHZ5T4KkFUNWuYUwRFVEJzpccIReUpYOmZEibC4wi?=
 =?us-ascii?Q?tMChgL7zjtp2ep1HE90gdHBMmW6KT83I6LuF2Xpy4b2zzDdiOYnqOWJuj8rg?=
 =?us-ascii?Q?//cXgx2LbqIYf3d+5bGWfpL3XmYP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4sreEJUXyX70jhyROSh+bwWGDQUdIcDAzS2EU4X2WzGhOIZ1xTcrM+8uV+j5?=
 =?us-ascii?Q?pte/EuIAvtzTsbF0vDscXbduSuPHEyQK5R5tNg2pGqx1Ya78k9gY9FQHFApe?=
 =?us-ascii?Q?oANy872eL9O0+EP221D8+PWuwNq/fGlJq+61UeaOnlc9etJX/Uil8IYddxup?=
 =?us-ascii?Q?Q/DKv+dFq+ux4Vlhd6TJ+zpWMlom1GZyKYgkalYk/K3QwC5xHYo7w97ryDoT?=
 =?us-ascii?Q?CN2AeL6nRRn+W6E4lQFeRNmc14zvuv6qClhjUHQBZYrSgIYS8NwdqDo+HIkZ?=
 =?us-ascii?Q?/bOLNaRPuJjqV402OHqydBBBavgsscTJ1BbraQhIibkPJx0msGoE/wy7sZKm?=
 =?us-ascii?Q?FsxCwNNuYeEuTeFWiFfJnstjFap9cxtA7+Gtk4RyXDq4t0OkDc7f7FO83iL5?=
 =?us-ascii?Q?hP2pdZByhuRk0QwrT0F4HjVN4i1aamMdp9+YubHXjRN+n54jkoyfDZbqG9Xx?=
 =?us-ascii?Q?ZDL/6dOyqSDiFlUBSCkk6QbrOZOGkfHvfjJZWW0q/CO1GLY4i/dhJo1R9/fB?=
 =?us-ascii?Q?ET3qOb/AIrrW+QRiTAcaLmGWFg1Qjud8zLadMYIiTh1FQM9TffJV3XTUDVAr?=
 =?us-ascii?Q?yMFHW17+TDwJSUOJUCY8xUaK3CgKG9nprEZM4MtfigJmUBv/tABYGR0a2Grq?=
 =?us-ascii?Q?0viU3dUH2eoJ4CdPKMkrmROhC6HvhmqVJTEivvSYC1yfBpd8iMWc8qgXuN74?=
 =?us-ascii?Q?JcRolRRRFBNpf4jemCeb2gzdrcKpdvUhZiK+EeOvZnempt7IKET/V8eWOfHD?=
 =?us-ascii?Q?4PIpncJ8hT0tQpsMWcKqHqMySdycLyMV3Ns2TNj5IdpUN87mfO5pbG7uijaL?=
 =?us-ascii?Q?+vGcAJxThNzEen7H7H0/87L3EKDttSetuZPn9MVNVPpJ1g0J8nBiajBUy6oZ?=
 =?us-ascii?Q?cgsgAmE5ULlDh1eeLU2LOVkqpo8sQ4mRWT2h6JNyu3Gos2uqZuhWlqyIfDJb?=
 =?us-ascii?Q?LZt0FdDgiR01CMMSykS2McMu8SEkr5+J7Wa8C3oRlsJwMUQLz2RYtLQ8kLFB?=
 =?us-ascii?Q?+lui4UKW/awerR96BY8HIhQns/tFJXFRze2cUA83yxIpm1tjwbpYWSZySOoE?=
 =?us-ascii?Q?T6VLax0uPnReSI6vuK1rKIUfKgaB50RpcTUc3vj6qm557PB4L/CDvgnN8Eey?=
 =?us-ascii?Q?iNhKY07p/1iYZRcX72bMEMKYOz1HLgoqEo8tiO+C/e5XeYGcokBl7GwLRAO4?=
 =?us-ascii?Q?1XtTtwD1okYLrQdKTY3aD8r7uMD4M8lWQsGbyXNJq8Fsl0ksUE9c6pyEp7Be?=
 =?us-ascii?Q?JQ4oJHNr6/EFznD4wf/lN7chtiF+iHdeqKc+xfEJeSa8513IJO1aXH9U2TLg?=
 =?us-ascii?Q?QWOZhe29IXPA/t3itRMHhVmW/DEtYEb7vBIxpWYoUGSBBSKtatnmimYQK2AM?=
 =?us-ascii?Q?LTxWQ5cMrhITdP+r3zeJ0t8usCqZPy1wLmm3Vwtdh6dICke/k/X3maVKV13X?=
 =?us-ascii?Q?/IN3DRc7uIO/mIpuj0Y4Z8+sMNwyqAfDu3iuz01vqif4rZxNs8YnEgHZ+qc/?=
 =?us-ascii?Q?YrOYlMQLkSNwyWIMZNu4BJKh4IysXTQP1VQS7JShDfVnWcpevUxcQK+WEH90?=
 =?us-ascii?Q?xCbMqTY9ZWU2zESXFcuBuMalLPuZM5XyA2RoLcF8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62353ed8-2c5e-4f2d-a13d-08dd5b561b5c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 19:52:34.3670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rk0PVecG85CZRbhZLV/sZ0jTzA/Qg3EA1Xj+XM6iVnSurkkLF0T//trRHRrcd6B+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7331

On Fri, Feb 28, 2025 at 05:35:53PM -0800, Shannon Nelson wrote:

> +	/* reject unsupported and/or out of scope commands */
> +	op_entry = (struct pds_fwctl_query_data_operation *)ep_info->operations->entries;
> +	for (i = 0; i < ep_info->operations->num_entries; i++) {
> +		if (PDS_FWCTL_RPC_OPCODE_CMP(rpc->in.op, op_entry[i].id)) {
> +			if (scope < op_entry[i].scope)
> +				return -EPERM;
> +			return 0;

Oh I see, you are doing the scope like CXL with a "command intent's
report". That is a good idea.

> +	if (rpc->in.len > 0) {
> +		in_payload = kzalloc(rpc->in.len, GFP_KERNEL);
> +		if (!in_payload) {
> +			dev_err(dev, "Failed to allocate in_payload\n");
> +			out = ERR_PTR(-ENOMEM);
> +			goto done;
> +		}
> +
> +		if (copy_from_user(in_payload, u64_to_user_ptr(rpc->in.payload),
> +				   rpc->in.len)) {
> +			dev_err(dev, "Failed to copy in_payload from user\n");
> +			out = ERR_PTR(-EFAULT);
> +			goto done;
> +		}

This wasn't really the intention to have a payload pointer inside the
existing payload pointer, is it the same issue as CXL where you wanted
a header?

I see your FW API also can't take a scatterlist, so it makes sense it
needs to be linearized like this.

I don't think it makes a difference to have the indirection or not, it
would be a bunch of stuff to keep the header seperate from the payload
and then still also end up with memcpy in the driver, so leave it.

> +#define PDS_FWCTL_RPC_OPCODE_CMD_SHIFT	0
> +#define PDS_FWCTL_RPC_OPCODE_CMD_MASK	GENMASK(15, PDS_FWCTL_RPC_OPCODE_CMD_SHIFT)
> +#define PDS_FWCTL_RPC_OPCODE_VER_SHIFT	16
> +#define PDS_FWCTL_RPC_OPCODE_VER_MASK	GENMASK(23, PDS_FWCTL_RPC_OPCODE_VER_SHIFT)
> +
> +#define PDS_FWCTL_RPC_OPCODE_GET_CMD(op)	\
> +	(((op) & PDS_FWCTL_RPC_OPCODE_CMD_MASK) >> PDS_FWCTL_RPC_OPCODE_CMD_SHIFT)

Isn't that FIELD_GET?

> +struct fwctl_rpc_pds {
> +	struct {
> +		__u32 op;
> +		__u32 ep;
> +		__u32 rsvd;
> +		__u32 len;
> +		__u64 payload;
> +	} in;
> +	struct {
> +		__u32 retval;
> +		__u32 rsvd[2];
> +		__u32 len;
> +		__u64 payload;
> +	} out;
> +};

Use __aligned_u64 in the uapi headers

Jason

