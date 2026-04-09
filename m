Return-Path: <linux-rdma+bounces-19174-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBQyEoDH12kjTAgAu9opvQ
	(envelope-from <linux-rdma+bounces-19174-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 17:36:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2613CCCC1
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 17:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2FC4308FCBE
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 15:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BEA3E0245;
	Thu,  9 Apr 2026 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gw/K4a5I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011036.outbound.protection.outlook.com [40.93.194.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6C83B52F7;
	Thu,  9 Apr 2026 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748531; cv=fail; b=EecgC5YpWkpS84BnwjU4XKWcEfgWT5QO+MNFNpQ5Lzefn4aqU6qymEDUJVwvppsZePfIUQMU+S13+MW08yfN7tyF4eK69veXlDaaNfp+ww9vEPJ+5WUMyWck7K+n3sBydRbv+B5hgW58b2iyn+baaItFBMqdm63Rr3pnEbDhZGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748531; c=relaxed/simple;
	bh=UxGc7/Et2zFNmUtEnL8a1ZCr3R+h+DOD8+Ooaj8K7rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jyW4S1JKSJVILt0TUerdnqNakHLPvwikgqtAoCCWIBxSeoc9vF3FF2qIqtoIYKBQUp8K6MnKZxJz7ULPBxpxhNslKhwzBaMyjU+iJEwrppF3raMPYckuOnK7D5uxGm4VyF1gMN3sSmexT+YfoGVsAmoQr6MvlC6obrtdepAr3cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gw/K4a5I; arc=fail smtp.client-ip=40.93.194.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o07T+2K0EGZEt6SQeHiBW/d8BCIUZVrXoT+P6ygF7+TxxuZKM4NYiWDDwW1JUvIiAHbl0b4/50PzJDzISOXtGLrUn4bvUUZrDFc2+TdgdBLiO467rDgCs0stVDefznO/yL3qMpshDTBM+a6P6RVz+frzuWd7nVOKnR/43mZHulOiBv3bG8YejXWpOaPQxABlWcceg+50DrOu3QBUzxvohtCQ8hOau2Fq5tVFE2A34vDgSr/qFeeUo/xRTDvbweUGsADCv0G58oM6OBXsXIYM/2RZHL+GFhdFv7KwydU4pfblLA5WWZLe3wiX4H8oWxEaY5iA9H6WTHI7TtDm4dQnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waVaMmRHU91k3f4xrfjNcixNxZOaCTE2oJz+12Ahe0U=;
 b=iz/Nl3e5FkVzgMt5E7O1CSFlv9w4b1rwvAhfLWafIMXRJqtFnszRuVEeUXSdMSP7gIOLwJWwmWBEx3pwb3lWfNHfDbZ5mbPhNTX5eQjMdbhi1743CtEj2ReOsWRX+vZby/KWCfzWNjSa6hjThpl0SlDQkdcXECC46vHj9C81aXSfrJifbmxVWXroadjW2a5OS3f53iueJdonvAo5+GVL2ha0sxeNMZQiQ73b3aoAeTP367Y721AA1wjVIFITXhgkAJKnUMp9Us/FYXjCOed1HlfPphP5fRe4e1hB/Y/3LZYjFEaFgXqx4K33Dm0luMUMibEq5wiI5NEyOgA1Tc3pKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waVaMmRHU91k3f4xrfjNcixNxZOaCTE2oJz+12Ahe0U=;
 b=gw/K4a5I/1+CCKO953AQOKDCRJ45yUIXdlhc6AUL5wPZSkN5E4osVflbcywJ20tEXn23B1KT4GWz2pHsUaUEEExT9nZytm83UqEKeYwfAA+OFg0/Tw5cnuFGcXNokfFjwvTpVKN7ABkPuGlYdwD3G1lKkG8R4I7F1CmEDoaDUTSh+YdtfnFOurreSYHm52OM0OUYUpFZClSxTCKe2Gp2V/zP0go/ujO1Q0AJ4VWgW0JkXKE2hz86Ekwr9hMtUav/B3kN4pKvcGXJXRmc+Ny0yU6VoZp22rxT1J83ZmyWHp2cIvKI6TpNhoSBkMa/B6kwcjoRmGh1p1IRY/7GJ1suMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Thu, 9 Apr
 2026 15:28:46 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 15:28:45 +0000
Date: Thu, 9 Apr 2026 12:28:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen Zhao <chezhao@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH rdma-next] IB/core: Fix zero dmac race in neighbor
 resolution
Message-ID: <20260409152844.GA1995590@nvidia.com>
References: <20260405-fix-dmac-race-v1-1-cfa1ec2ce54a@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405-fix-dmac-race-v1-1-cfa1ec2ce54a@nvidia.com>
X-ClientProxiedBy: YT4P288CA0034.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::20) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: a6166ba9-331c-41a2-2902-08de964cb05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	A1j4001tKV/3+hXZ4k79gWDLNNmmmTAlFCErEYaUnWb3W2gQhZkwwy3r7Ubn2Bt1Ky/lBz7sWcGVHrIPy+cZ7Iz68S4Cz+zGtFTymcyD5y3uZ8kT+XSjeq0FhJ2XR3fvVPW29mt1gmGhQsYn3vm3ceOfbUIG9aHKImG+tf14bRt5dKBFiBLUX4UchKEG1A+KMTzfR1HzVVnM502z9Nnc2gVANF3Hpz3NiChTGCd/6tM/TXzOTErA4TJwg0shVq2c2irzx+qKL9o0hvdQCgTczB7o0BsHRDhG5LoWWV3a6nOEaht7YcIedoD1to9dZLnV4MppWS0Y0n2ZoYapHUrrDTn81g37/oXlMfZWCbqy4mTVjIVX6eQLtZFRN/Ycz7NIqtK/wf6nM1gCpGavVjK1Y8bHxBBpLyFSQFGCNJ2v+StK4jgof4DhWHmcXGtmymM3MHXg6dag+WbeHluSTYV/OG7eQe4BSGWAqgTUV3ssOS+aOfCqFOJ3aawyw2b5doE3rIs2imsvkGAH1r3nvgqURCzVv3oU2VWSQ08HM7SCYOu1CT6wJr5K8tWjrcTNiH5BwNSD9gDCd5JqeoLrgX8RlNoafL7kp0KemVxOGEI7qbX0GHUYW61cymlhu6q0lJDBvghceSP8mdE3lUOQ4P7LObmfVgNtNfDQClCQgtQZ4+Le54uSuRt7Aa8psAiCaT1eVxx4VIWaugXTVYSi4eacuEdfP4bVqf3MD42NUKPMtPg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?imojIy2DLrkXi2uyYNDN344MsRqYhJYqHPcURwYAS649lrNDbcsnZbFaqBs/?=
 =?us-ascii?Q?HKRdB9Iy2iqP7b0BmGs3hHFn/+V75/IUqes0t9Ql4tomY1FDUZzmFvC64aNg?=
 =?us-ascii?Q?ZejFVJ1rrLWn5Gk7s6/jeKiiruxM5iIhuk/huP5IQg+H7fwBE2TR7rFbTIG7?=
 =?us-ascii?Q?T47AQxwKlylSkI1J52imUNAba63u7U3v5z1hXF+bd4Tk2PLeMe+HD1EGqtHj?=
 =?us-ascii?Q?boMi3VRs9OFwg5CvuN5dPeHKm1goHTs39lb9myjh+x1NloUYoykw8IewaHmF?=
 =?us-ascii?Q?bwNaKZC2BGaU0KDOJcAY6x3Z4/5naOCx5KTOblnY++cFcaSHoPlY41GW5/XH?=
 =?us-ascii?Q?JrSn6hkagjHqnWdREYqSmVvyXSiJoRTlMg8PFbOAUvd0EI9zUX5lQk4D+NjN?=
 =?us-ascii?Q?fq5FRIInyNfkrKkDlOX9HbDjOdQ2601tDkCDDIvp8g2wKmgYPML3dM4Jgxn3?=
 =?us-ascii?Q?hWOymX9Lyf0sj7Jqt9LxOGa/DNxoN3filjwXa4Kwl55LsW6rQb+VAmIZ98+U?=
 =?us-ascii?Q?W14WhDG17jEg2T5CdmWQ3JoMilQa8rCFtCjQ2YGAH3a6ukYwB6iBDjJAxNtV?=
 =?us-ascii?Q?1YHOXQ6YXY9r5bhonULWbXP8URci6JA9cVhaYa8Gsd6msC1mmIXMA3sQ+tkP?=
 =?us-ascii?Q?0674HTmSwQvAMvi8+b/F8+J6c329ZFHuR8UQRV5SPlKm/tZukr9dKPpGWWle?=
 =?us-ascii?Q?G6Pp/qP9abVD24Q8Fca+rYwvwf5fYjhoeJkHcQkmAcIWvMKOiikneUCybozL?=
 =?us-ascii?Q?WXeSIS1l/MSkFrRtdCFNgwFQkcYJLOQcM+lP4a305Af9DdBYuXvN/mBYYfcf?=
 =?us-ascii?Q?iCRqIB/t1KPrtjTd/A0WsJz88ks+vu6zL1UHzdHqXuIqU1+v1wWaVXvEnLt+?=
 =?us-ascii?Q?I5FrdCNTz2bkSkuEcXRVxwVy0HuY47TpB249NKjoP5DDRv2787zoqwqzEi49?=
 =?us-ascii?Q?bh3Yqicrnvjg7HxFc0Pi93GlRiM935fQ6bKC2aGVhnIJjUTaMQz6TqFnS6od?=
 =?us-ascii?Q?NCD8qni/dKvfPmD4+Wbm1y0sdZ4seSQOgPIVHQKn34+9NwqJ//DEXw5cIoQb?=
 =?us-ascii?Q?m5UyBS/tGek9Qzy5NCfknlxeY0r7EbSzg78euJJe+8JB66ddtQs38D0qTW3f?=
 =?us-ascii?Q?bkuJ5uorWIF3Ny8f47gChVb8USkZt7K0lHDv35IqP/fsW1ZQNLnHnkdQa/cs?=
 =?us-ascii?Q?QTtFpHIFcRAUXqZo+NnDjzhjPp2sKb0keptMVZgEHI4+uG5OnATL4Q5E53Qh?=
 =?us-ascii?Q?60oX0u64QKdaMFiDUI+0v/4jr1F5XHOugc4Op/HT95uyqEIZ4Tz3yAuYTLgw?=
 =?us-ascii?Q?JRwpd54UoalWngRwvnI6etcrFRARYlHc/GtAoS/OXzMkm9G1+edz7bCSqCa2?=
 =?us-ascii?Q?H5tqVXOndGYKzBrYOK51WP6MNJ4//mSrK5dFmFGdcXY+6lw52qLiiO+05F+/?=
 =?us-ascii?Q?zLCn/UOGa+Z+7GraAFAxUyLGpVtpw890wFoDkrmxMqBDD/2wrnLtyFlUoViT?=
 =?us-ascii?Q?e+J5iI0an4H4ilYLSpwui/XfblKv4C2zDbaXLeiyYJl5WIQk59dqF/1CWFWN?=
 =?us-ascii?Q?jEa0KzK8HIVPaxl1azwfwqKp/b9GHJAGtj1rGmR/1730Y+mQNKWNt81aM6Rl?=
 =?us-ascii?Q?GGj5lvCYYl9uUXFnUubyRuX9KpxG5S5AlaaF/ZOxweQVB9jDXAYcFWVrSPpX?=
 =?us-ascii?Q?8FwzxjFkwbKc7s+REAr+oAezmC/1mFff2ReFEvwN/tu7CNIU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6166ba9-331c-41a2-2902-08de964cb05d
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 15:28:45.6074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SgTSjjK5DvjIi3aD7fcFVQZ8RonqWiNd+hIPF8ty6QMFjJP0R3iZ5TgClmPLQb1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19174-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E2613CCCC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 05, 2026 at 06:44:55PM +0300, Leon Romanovsky wrote:
> From: Chen Zhao <chezhao@nvidia.com>
> 
> dst_fetch_ha() checks nud_state without holding the neighbor lock, then
> copies ha under the seqlock. A race in __neigh_update() where nud_state
> is set to NUD_REACHABLE before ha is written allows dst_fetch_ha() to
> read a zero MAC address while the seqlock reports no concurrent writer.
> 
> netevent_callback amplifies this by waking ALL pending addr_req workers
> when ANY neighbor becomes NUD_VALID. At scale (N peers resolving ARP
> concurrently), the hit probability scales as N^2, making it near-certain
> for large RDMA workloads.
> 
> N(A): neigh_update(A)                   W(A): addr_resolve(A)
>  |                                       [sleep]
>  | write_lock_bh(&A->lock)               |
>  | A->nud_state = NUD_REACHABLE          |
>  | // A->ha is still 0                   |
>  |                                       [woken by netevent_cb() of
>  |                                         another neighbour]
>  |                                       | dst_fetch_ha(A)
>  |                                       |   A->nud_state & NUD_VALID
>  |                                       |   read_seqbegin(&A->ha_lock)
>  |                                       |   snapshot = A->ha  /* 0 */
>  |                                       |   read_seqretry(&A->ha_lock)
>  |                                       |   return snapshot
>  | seqlock(&A->ha_lock)
>  | A->ha = mac_A     /* too late */
>  | sequnlock(&A->ha_lock)
>  | write_unlock_bh(&A->lock)
> 
> The incorrect/zero mac is read and programmed in the device QP while it
> was not yet updated. This causes silent packet loss and eventual
> RETRY_EXC_ERR.
> 
> Fix by holding the neighbor read lock across the nud_state check and
> ha copy in dst_fetch_ha(), ensuring it synchronizes with
> __neigh_update() which is updating while holding the write lock.
> 
> Fixes: 92ebb6a0a13a ("IB/cm: Remove now useless rcu_lock in dst_fetch_ha")
> Signed-off-by: Chen Zhao <chezhao@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Strictly speaking the commit in Fixes doesn't look like the one which
> caused the race, but it is most relevant one to put.
> ---
>  drivers/infiniband/core/addr.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to for-next

Thanks,
Jason

