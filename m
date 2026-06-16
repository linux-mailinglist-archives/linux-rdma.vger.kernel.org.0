Return-Path: <linux-rdma+bounces-22278-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yx4CNa1mMWoVigUAu9opvQ
	(envelope-from <linux-rdma+bounces-22278-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 17:07:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBE6690C43
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 17:07:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=cCtzrveK;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22278-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22278-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8477131C5FFA
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 15:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A26E3AA1BA;
	Tue, 16 Jun 2026 15:04:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012027.outbound.protection.outlook.com [52.101.53.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC21636E46F
	for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2026 15:04:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622257; cv=fail; b=LnRkZFMTNJpuHwVosja/Tl6k9MSCXbKFOnrznNr4qv6MwKqUgC4wriAaRblXlT34OMIVlOPoPjOtN1A092Bvbla8qYlUbRsK63Ro2SRN16COMtg/CyH3wHWPZwYlo4SAxiEe94BsHfgE5u+hdtfqbEP6XHWHq/Nhg5fcWfjrWc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622257; c=relaxed/simple;
	bh=DuPZjPHxPZyhJmZb3Li4tepOiNixJP07jrg4IH88Fcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BvWq8gx+IhEMI/NpryRJ2fYDFDTnoVQB8fyMomiC3PUWJKX6mfmzbzAJ4/CrP9GUOs6gNzSvbgwH/63qNKawpFlX6/G9YfjYQCuR2H02VnpdWIIflA8f0VPKqwrKOyM5n7bVdK1K5+dSvtX9FzsoM2QOxbH/ZsBCF3pF6foAvCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cCtzrveK; arc=fail smtp.client-ip=52.101.53.27
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CC9zGsKxOFjTftqh0KMGecuVjuZrgUoSbwMhSv+vLrM58zDKUlFvR0LIyf2JG4LxVvyJ5tTvvX1P/F/hXA722eE9FVNftvp0woLbmrNq8EdiPOB7gj5/zIHCpqwjcvXn84Es5zgG7UG5Klwrm8Q0n4/+0d2oqrhOmMdzAYOdmSma/08oPhunUP2ItDN0OuGLHKKvjhj2pr4jbw1d197+ODsc6df5+EfP9HGaXpwOry7GlbDO5nZF8S4Wf/WqCiG9pO/CPtZ7bS704+2k/wR1rdeeA3DFFkQiejpSWBnIyFKD4CO1WKgW/YIyQkaL0gRAIA5MhrOfJMYZtcGz+THiSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3ZQIxs7Upi6RzFtWBRG0m833aMU8Bd/66sc8MBY75s=;
 b=Wm8cAKafKk8uoVsoOfmzz8AFTfdP3bRIcybTcHqlJKJ4mO9AS89Y7h44n1oYtdwwnk7DT90ahGYY3PtJl7fDGb641pWK9JL2TVHA3E7P3ta5QKnC6v3vOkc/tOu89DDBFjKXx1Uye20kUJQCzjDggIINDCP2diz5GS6Qp2JRbhl4Qhk0rUqeddMP/CP1cr8odWGxkovQQ5U3znRkGSYU4axDlCv39hqK7s8XuAiKRXfSTCrNVVp+UzycN1mT7GvGWeFx/ENTcoaLuE/aYAEFRUIBTS8S9cck4swc+yw8GWiJooygzyjF6ds6k5QDjc+vPjnVC7DG8+4BFyhkROPhJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3ZQIxs7Upi6RzFtWBRG0m833aMU8Bd/66sc8MBY75s=;
 b=cCtzrveKz04MjUQbiEoNlVCJBSsIQu5Kd+HETHs9LbLw11n1UjAThCcRMpXyL6k8Jv2W/e8NLav1Jh5fbERgLKr/1fBtNFHHICiFq0dfNiSLkL+JcN5bS30BUlz3XVclNTJvB11HpHH21YiA9N3wjKevtKzAsnF2WyvfHB0+S0jI8bJ6vg+CI5wxF8tX56X3YtPqTtt14stE1yiauZWlKbdcXjA+m57fVt9I5thzFUqoLkHF4oiyy4QLeFGxXOjQR852gvhvsaA0zhWRzhOMbW3mW8C9kYTK7zj6Pfaw1GPi2ikAJLsasFKi+5fjIZXMqYR3G85xq0FBoltk/JfDAg==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH1PR12MB9671.namprd12.prod.outlook.com (2603:10b6:610:2b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Tue, 16 Jun
 2026 15:04:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 15:04:08 +0000
Date: Tue, 16 Jun 2026 12:04:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com
Subject: Re: [PATCH rdma-rc v2 04/15] RDMA/bnxt_re: Avoid any race while
 handling the hash list of CQ
Message-ID: <20260616150407.GA3885854@nvidia.com>
References: <20260615224751.232802-1-selvin.xavier@broadcom.com>
 <20260615224751.232802-5-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615224751.232802-5-selvin.xavier@broadcom.com>
X-ClientProxiedBy: BN9PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:408:fc::30) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH1PR12MB9671:EE_
X-MS-Office365-Filtering-Correlation-Id: 83666d16-831a-4716-44aa-08decbb88430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|4143699003|18002099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	DcgVG1EnbZBX9DRXPcgaQX57hbvqqDVZiuVfmGBjCLBcbVpC1olGCgLJsOXLgxq5T+pDJQ7Ju3OUyU1bfyim0ZNs7Eto5+25fD05Z0GXEA7MHAIGUCrhDFdYsTF1iSWdX6he26gGTdWgJ9gvQd9/6KumIwWnDxesr3vzXeSdXIm1LO3o1ADQSkpzK7mCXfkQTaBSZQlAt42kMTUKTHEm9D+830sS29F2HQWL3laualIj4W5afVTumTLDlSYHq0me85US3ksgdCGzlABD4qh2Uw4+RV7pQdo+kx27qW9nxMawHMHj8srU1BipY/HjeYGyW1dL6S6gujs+eJm2OTAHCNMqdGP5j3Z3/nTQHHlAWuqtVRYtupeXa5FpeW4Q4Qr8PH5Cbkinh50aEt0698sTlv/vGEcq5+2ATb1W6yPmwUTh4BWcedhf5znu0JIMYnCJsGIkONbTM9C1clZaXnZQMaRTVWZqjkdC/huhtnyL0GP/nl4YQ3dfTK18a9JvBCPh7l0BGZO9CXFdq8ecbGD4egnOMPcRsLZVRiilkPGkR37RaJgUp2WtoRAPO/XcXF28jZr9ZdSAeDNvnT1fEo2BM+XZytu7gS7QFQh5PaocR1eF8FZ6TZb8gMZA/uLwELQXfsqGle6D6fUkKU+YpUWKRtBorCe4B0Kgp/vUwRmtah8OdZ4RT9rof6t7BxBEfhWo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(4143699003)(18002099003)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F6N6vhf42FbwUmdY3mqm8KQQGJjE8FZBr2wq7scZvG1EVLn3OEct/0kr1oZm?=
 =?us-ascii?Q?J1fK1KRnlTTP/LNtThMYc3EcgQ+4Zep/4iasF5cZNWT3Rqyr7lNlL8STS58M?=
 =?us-ascii?Q?soNZRGGmQ08gUOQ1TU6Iq58+X2Amm6tNEDVZqy0RlWuXDAW+nhVjEUgj9BLu?=
 =?us-ascii?Q?kAzQskyJQAvf2oI531L1hrsWZUio5UBpiwUBf+edTw0OyslZjFZDRO1ELqTU?=
 =?us-ascii?Q?k5Ulzxc9Xr1riKa0ZH+MGZdkCO/E0cf01QRYD/vmppCuLdcSa0k7wcGkJsCJ?=
 =?us-ascii?Q?VZ0JKg7vGdPJsRwnegIH1qw0/aDkc2QSnW6OSn2JT9r1kAVuf7sfU5Dogi5a?=
 =?us-ascii?Q?r/xnw8tav81EGgZZwMhkfK/fQK1BgTEDsBcqDJIaImAQ4SIDyljWFf3ETk2Y?=
 =?us-ascii?Q?qiDnMYFfuEU64C4JQs3e4IWYB1suXUwwSMBvbgKIXn2SsO9LfzaIYPBFFe5/?=
 =?us-ascii?Q?13hBig48u9FhvACsqVUjLet8mqKoZdqxbCyeoBKBXmi2LqbMuiFwyb5S98fr?=
 =?us-ascii?Q?aMcw4wMRqw3Bq5EgOyXprhFSos/iDcrmWgOLsiPgNn9ouMz1VdF+BM9j7DsJ?=
 =?us-ascii?Q?S17zOzTdlWNmQwEPK5Y2HU5kMeMIClvjO9zr7WeBMSul0DtipGMXt1BUJoKt?=
 =?us-ascii?Q?QBZoPzOEqaiJayVa0fdXkqe+MKWRq/RHloTdcKuXNEwGf0kruG3BbwNR1Qut?=
 =?us-ascii?Q?mvkLxKeoTJIeBbxwY//guVSNPM3Tq/B2n/fPS0P2c63T+4cMdoZhJWbqXpHo?=
 =?us-ascii?Q?GYVVjZS4SP+6+vNOX/XmDlh7FdAcndaf3TlqBREOYlA2RBn/PRiWzojR7NzI?=
 =?us-ascii?Q?fxLBWan+ovUgyNwCYlJZzxiIzjIDQEK9XPw3aGQb7vEWz0rVPfTwut+rDFOL?=
 =?us-ascii?Q?bgM0XFK6v3IB9PflwfRYmy0YTDDSqbnDj3Oy7mrYNCexqErU5rRsmlE955BV?=
 =?us-ascii?Q?baREeFQUGA9NhqmfX01OToHg22zjoKjNVBPy6xQJzAYVKX8X97gfKz6agc7e?=
 =?us-ascii?Q?aYKgJiQOI29kghI+usDXMIAPWJDaN7grJ8qo+JDc2ls06d+fS2BpcFIuZwOT?=
 =?us-ascii?Q?1eglD4n4ZAWKtuemAV/c2hklYnp82Kp1O7b6CDfVePP2q+zZBGFyL91OBj8B?=
 =?us-ascii?Q?RC3oOfG+3+VjNMF/IEusl9CONer/QoqPSJZqI8JoD6ZP+raJp3afLyyJZhpX?=
 =?us-ascii?Q?uovrnAxLekdqp8cX+Rv1TALIFdGeB+TVQGiQwImWUBXGF02aOCvcOQqOUaTk?=
 =?us-ascii?Q?dCo0UPd5t0JfChsNRYAoMh0jkSank9si7sd5XxD1Y0nUG/0f1uKHNnXtCDt1?=
 =?us-ascii?Q?AsAmwNMeIsjVmMuQFyZBYYzNqSDmEDkTXtq10RdF1SfAeXiOazQPLhnnMSti?=
 =?us-ascii?Q?l6N5f3BlZdufMH8pmhGP499hC4UhwGuzOiTgvwQMrySuIhnaE1ylSUW0L764?=
 =?us-ascii?Q?8/DhqWzy+DRqH/vi8AvThL2jrZ17QjcSGfx8OtWJgxL0UsPaW+kBllKZHF3L?=
 =?us-ascii?Q?iatggy0hg4es72K8leThbEoNBj2ZzLe3tSLP37yjDGeHpLm6BXaMRbARBwBY?=
 =?us-ascii?Q?yogO4ETSTyl3T/HQ6l4528mWLypVooEHWgN1p83KVgc0YXaCvRIXhlBJcwVW?=
 =?us-ascii?Q?jkboHacTGbnE0fd/Rhp5YgMKr+vmecXR0EgyTUOZfA1XwIYflFGyZmZN95jY?=
 =?us-ascii?Q?fTV0TTqytp21ZJuG80/FyNzZqeKTFzaWqx2mhqy8SwhgAtYo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83666d16-831a-4716-44aa-08decbb88430
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 15:04:08.8078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: si5rx7kKZmobAVDfOcNvURQvMW7TH/9hAlzGLnX1NmOVm7SnR0n+g15USOLhLVnH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9671
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22278-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:selvin.xavier@broadcom.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BBE6690C43

On Mon, Jun 15, 2026 at 03:47:40PM -0700, Selvin Xavier wrote:
> Add/Delete to/from hash list needs to be synchronized with the traversing
> of the hash list. Add a mutex for this synchronization. Also add a
> reference for the CQ to avoid any usage of the CQ structures after the
> CQ is freed.

Arg, this is messed up like this because the driver didn't implement
the uapi properly:

> @@ -252,6 +255,7 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
>  			return -EINVAL;
>  
>  		addr = (u64)cq->uctx_cq_page;
> +		bnxt_re_put_cq(cq);
>  		break;

Passing in uobj's through anything but the normal UVERBS_ATTR_IDR is
completely wrong.

And now the security model is messed up because the broken
bnxt_re_search_for_cq() doesn't respect the uctx boundaries and the
userspace can pass in any cq belonging to any process for this
operation. That's illegal.

I said the same thing on the dbr patches and they were fixed to use

+       uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_ALLOC_DBR_HANDLE);

Which is the correct way to reach into other objects and prevents
all of these bugs.

Fixing this by adding more mess to the driver isn't right, you need to
rely on the uobject system to do this. Once you find the driver object
you'll need to call some new uobject function to validate and lock it
properly using object locking. Do not add new refcounts and
completions.

Jason

