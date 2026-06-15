Return-Path: <linux-rdma+bounces-22237-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P6+FB3AAMGpXLgUAu9opvQ
	(envelope-from <linux-rdma+bounces-22237-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 15:38:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B4855686CC9
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 15:38:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=C2qKROck;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22237-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22237-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0755B300A4AF
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 13:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57783E557F;
	Mon, 15 Jun 2026 13:38:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012018.outbound.protection.outlook.com [52.101.53.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402AF1494A8;
	Mon, 15 Jun 2026 13:38:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781530733; cv=fail; b=kDyGqoM40H3sGTCnYWgRqcAgvheWXmE4xVpd32BKMIjNv1PqPmAt4hSF5iiJuT7sUJOkCld6R9QQh+SHv3LKDllxe3K5FB7ZZ7n8ddc8D0nApgcZ2cVPE/9360QC3+lsX3QYFk1qHPHlA6MAu/lXjkhzOYEuIh8ZRZ+FmkxaoUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781530733; c=relaxed/simple;
	bh=J8GtTM4qG5pfjQsJA+zwhkw8GKqXGExrLPcAquK8wjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NfpgxcRYfmgcJvqAuSqQi32XxaIImiBeXO8fOfoUEopuD4Iqz9R9cXFFJWd1clI0EB4F/9WAC5ICXo2PRl6CGpU66tXv3W1xa4uN0gCppRT8qxJdJ9MQQuZZxtVzdznnetXO0xDXUEdisVxafSiKsXI13Gf0ZNAFvvgJbcIoZXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C2qKROck; arc=fail smtp.client-ip=52.101.53.18
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yM05GJ7mpJzqSPE4nYeB9IlKbdZX7oZ6GTZvGr0yAAkNhPS9/pMuF6rtsDXK1qv7SnuT+b/CEThbW+EFNMX0NThXSa15EClEXdBg//2TlNfy6E9avjgqOx7YguSmOSBP0B4q+TuxrKpx1ztrkLrDg/Oonc/w5qBeJdwjs5LvZj+2onm1RnP1v9q6hoa53Jtrc1m5c5QKNzWzY3cJwFWQp4UwKQAaFUr6Sx9yizf/tzvwqCgle6SRHoPUR4bOHjAXAjb60NF4f1BCR+xwe3ZrZ3v1OnLlvN01/f9KYsComaLv47RWpwiRjcKY0Cgrid9e6SOhSyoGi6GAfiBfwDSPxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OL+rqxAUmbgsjB0cnluLciPS+Os5hO3JXjGEZEQwUjU=;
 b=qOaLCPz85C0Cb9TDeBmy416piNclavje8HDrdqCzg+d8bCo7M/T1EqXGR4x2A6NbsPIxCaQNKB3Lgfhumqbtk+hcDl2N2cMV18kF8hkIoKEAEe4pBpzbVN2L9VQmhLvyRQPd9lrFDG00ERz4Tbb/nlAwhgGxz008fNOhyhEzUcBzsj8BKN93nxtikVbaqObSUm8DCIeJYvc+rFBDgnx8D8p8kuNM3nHG+Z8u/mCzP88M282NLVKABoAYUY2cNDXMuGLjZztf9uujjyEZuR8PSCUERgq7tb/L05VwjtUph5G6/+lnRRnZaKLm3OoMwu/MOYIJfYTebFDVwXJZl++WGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OL+rqxAUmbgsjB0cnluLciPS+Os5hO3JXjGEZEQwUjU=;
 b=C2qKROckhxoggwJJHz8YZGw+H0je44VWlrNvl/79EitU77ApiuoQiIAi6e9ZYxGJgyRHK0TyVuztZI9+3AtJhEs3sCLZFr6YTI82u1BroBltVQyDxd1H7MLet9jLFHU1zljfDbmXaDlybz4KUKgfVyYqPjPr/TDgsWvOcwdClQyBej3W1WTM/PN3J2vG+c2mHxhv9hoEra95KsXjQJvG7EaEbJBU6YRiwckTcRlvzAfUYpxRz5jtdf/lTmR7TyTe3+AFX6RIqSd3O8prFtRsJIHGUy9scHXG7dTxyQ6gjF+h00QL08iYFaLQOCDHtAu5ewNw2kre9X1y/Owh+X0TNA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7802.namprd12.prod.outlook.com (2603:10b6:8:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Mon, 15 Jun
 2026 13:38:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 13:38:48 +0000
Date: Mon, 15 Jun 2026 10:38:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Edward Srouji <edwards@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Or Gerlitz <ogerlitz@mellanox.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Roland Dreier <roland@purestorage.com>,
	Eli Cohen <eli@mellanox.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Maher Sanalla <msanalla@nvidia.com>
Subject: Re: [PATCH rdma-next 2/2] RDMA/mlx5: Fix integer overflow of user QP
 buffer size
Message-ID: <20260615133846.GK1962447@nvidia.com>
References: <20260611-maher-sec-fixes-v1-0-cd8eb2542869@nvidia.com>
 <20260611-maher-sec-fixes-v1-2-cd8eb2542869@nvidia.com>
 <20260611191723.GA1516987@nvidia.com>
 <dce83cca-79c3-44fe-ac05-0eeeeaa60890@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dce83cca-79c3-44fe-ac05-0eeeeaa60890@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0279.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: d2991a9e-1c5f-4f03-5079-08decae36d7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|6133799003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	0Q8LidnvzzlnwDLR9KvcWeucPhWtwLVxUNAHp2UcAgCI860ektSt88hHADoRKynvFZoSB0yXFqZxfiI8aPElR5vpJAOVWctwYpFeb5BGydAfkBw7K5vuKzT52HH/L3fFJln8qRuGHQEW75oZIN5J5GTPjGQ28nXSXINpZvTVMNv9E/zM+ZDXpt+KuyWr1zGyOUH4EImp+3ryv90O2O9+shl/ipN2vAwai2MJO3/wJ7NargTvrzzGfhjwBjTXagfVR6gK/qBUmnfzm2erDz+fAbZwOoJOmAzMRCM4uG1Q+iwTe4qszJ3U2m6MvOAyKv9imWbm5gZEJoIpZlhRfAMrbnW7Gs/gBFEuv7u88GhjSoRk60KN7+FzqNjFcHEPzhPiZWiQmkLIQF7/g3LSKgEatwwjN2qDubF0YX89qrl7xECkxTbwFPO8UvN2mw38BiYmNLd3WZllZ/1uSR9tFfujDpEKL0sk+0KaTEM9XQGZrXhiU2v2ICGP8C8jbtLtAEhHZo9dNIA6mwgwXbs5TMuj0oQFtaim2Uu3WqxrS5j60JkPCWkjMVrW+TBANACMXqtHtaNH/rQBU2bdpKMqWKgR4CRFwPM4ragHwwVLVkjo7M2Rsq3T26AscFh6V3wMWCmnsJr4xdjXUxVzitrRN98NCBCCX5UPWvL4tJNpUgdvX9Znf1Q+n+r5/C3LY1NQnOww
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(6133799003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XtjHKRVxLI16DXvOgoQXK0hejIeGGwn+mLzWZg8DP4JBK7ufyKdcnfKd7tFI?=
 =?us-ascii?Q?Lwj8m1hq3mAxWKDN6E04lGEMUeabmIiY3gayQkm0yJu89A2IqagSlnvST/jO?=
 =?us-ascii?Q?LIKaDSrMc0y6LVQDUM5rDvVP7LHtFPVgU/WJaYdnzbEG2yUbkjA36/T8ZK1C?=
 =?us-ascii?Q?CNmul3+VVjkY4/goCZnWSZthf8IvD7x1tEn70VWUq0AaCUPGoNPmxzDT+uk1?=
 =?us-ascii?Q?r3/mO6sM/zYQrGAevBjPNoCpVRezKZ6MVUlQqmZYz6CvqMiwBZ4wPWwWF8hm?=
 =?us-ascii?Q?YxiG3ZDD6fHQ20CXcDbEaBJBiMo4zDx03ZIg/etf+CUjO7hXe97H7Pi4uhzA?=
 =?us-ascii?Q?vYjAYefZDNAPqZ11vQRQT8amRtgBYin7h3xlVBSexmHmkn6AKWjHlgu84ZYq?=
 =?us-ascii?Q?XA2IVwCU2EX4xXnmqAiWhLV2zS5kNrD5Z5CUOzGe5+nsoV3MMIQTTqihIgmv?=
 =?us-ascii?Q?uTFiBMCGnEZu/NhhlwfDnW/M2xHS+aKM4UKGLRhI89NPUtJJ+kaT1RDuCzk/?=
 =?us-ascii?Q?SvxCfEEk1nGdRlIu5Q+uhjG0JylBxuVKHr/SEHrSBnaJxctUekPFOz4wPJIn?=
 =?us-ascii?Q?GzdS11lflYMyvYy6C6S7fm/75NrBxG7boNesb+Xs3p40T+6IcmHHzmeDO18G?=
 =?us-ascii?Q?LDit5z2rw/p327O1Ywu+gwujlhJ7t0anm1q3Yg6vrHr00hGy7wuLJDWiZNQC?=
 =?us-ascii?Q?iyHevr7bBPkF8UnSTS53N/AGvWDvV+zJY6o+hK3nEqXtlpX4qGmdfbiss5zs?=
 =?us-ascii?Q?tpWOSkNk6tyGG5/+5SL/36QsyFIXknII/fJ/8EaAoQNgSQrvwyfmP+gfxE0R?=
 =?us-ascii?Q?ivKjlYgGLXzNyzFyuavEEr84clntpN1on2C+XboFLwSuhm+FWveCsY5Yqv4q?=
 =?us-ascii?Q?h6qowsVKRryjNcku20/Lk+5i97Y3WR6+DgVpSrCRDx34V8a768CSet7Q1wRg?=
 =?us-ascii?Q?xyl+AiXbi4mAGKNswEswd4U2vCP3Ei1hkTGJxaaUmrVGiZ4jhgTRXFCHQgqw?=
 =?us-ascii?Q?dG8zUGhQat+PHJ3OoPrVGW5Ri1jP9kE8o2sPjK8RspIJXkEYk0d/9kZLaxPE?=
 =?us-ascii?Q?BhYu5vs1oRwApu6BE+L6jUqRPpp406o5sBNQvXp7eCcwKm0RQw06fG8TS43a?=
 =?us-ascii?Q?w9prTvTAV4whlC+b1tGE6ZLNSj691edtYggONi8W2soMwe3a1yJUaWxUl2rd?=
 =?us-ascii?Q?wOHaT7GWSDaFGoTjyKkFzbhfmmIe6L5Gf9WW3gcGvPdv3ae73EyuLOjcsAvW?=
 =?us-ascii?Q?tctK1X1KcHzoUoz8HQqsDYXIwY2Ut65lq5Gut0Z1IWh8bhiuWwZIABzq6gJT?=
 =?us-ascii?Q?regRyyVRDwnHyjShPX/BI08D/Xw2F44gO8lt5CZ/aiR2CztDIzQBiIfQQokZ?=
 =?us-ascii?Q?tCTbNDb6+1WhwxGwFDbBey8hIttpXo+c4Ybv8Opv1ZKf8+H1/LoC8HkC3OQY?=
 =?us-ascii?Q?bqJv7LWQvr7tl+9qHY4GpIN8hmAB0tn9fK/Dt4UeDfTS8gECl1XqaaW+0epy?=
 =?us-ascii?Q?gnsFg0F8cJQ5gv8x0+yRUC2LLwsH57HZo+0UY/7ygTeZAQ5q2RlAG0WD60vu?=
 =?us-ascii?Q?n7GriVIbQj99GqemRvsMcPu+N9YEY6YJeVOALRIzH3bDjURDTeXgwcMRRqe+?=
 =?us-ascii?Q?H+hBnP+4siJCgm/WZZq20jw0iC1vuIDfZMCi8Tviie7bFVJrr9v5/V4KdBlO?=
 =?us-ascii?Q?c5+9xuHEl1VpZ7xzFOBtCi6SqK/azI2brqMosymLcAszLIuh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2991a9e-1c5f-4f03-5079-08decae36d7f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 13:38:47.9701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1rYhliHFBDnTV/29d5fbTpjD37CC5H8Ay1pZIncxiiCrLthW3KVU0UK75HKfGZZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7802
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22237-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edwards@nvidia.com,m:leon@kernel.org,m:ogerlitz@mellanox.com,m:jackm@dev.mellanox.co.il,m:roland@purestorage.com,m:eli@mellanox.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:msanalla@nvidia.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4855686CC9

On Sun, Jun 14, 2026 at 02:23:00PM +0300, Edward Srouji wrote:
> 
> 
> On 6/11/2026 10:17 PM, Jason Gunthorpe wrote:
> > On Thu, Jun 11, 2026 at 03:50:43PM +0300, Edward Srouji wrote:
> > > @@ -664,11 +666,36 @@ static int set_user_buf_size(struct mlx5_ib_dev *dev,
> > >   	if (attr->qp_type == IB_QPT_RAW_PACKET ||
> > >   	    qp->flags & IB_QP_CREATE_SOURCE_QPN) {
> > > -		base->ubuffer.buf_size = qp->rq.wqe_cnt << qp->rq.wqe_shift;
> > > -		qp->raw_packet_qp.sq.ubuffer.buf_size = qp->sq.wqe_cnt << 6;
> > > +		if (check_shl_overflow(qp->rq.wqe_cnt, qp->rq.wqe_shift,
> > > +				       &base->ubuffer.buf_size)) {
> > > +			mlx5_ib_warn(dev, "rq buf size overflow: wqe_cnt %d wqe_shift %d\n",
> > > +				     qp->rq.wqe_cnt, qp->rq.wqe_shift);
> > > +			return -EINVAL;
> > 
> > No prints triggerable by uapi.
> > 
> Right, will drop them.
> Note that set_user_buf_size() already has a pre-existing mlx5_ib_warn()
> prints, which is equally uapi-triggerable.
> Should we clean that up in a separate patch? Should we drop such prints
> entirely? or convert them to mlx5_ib_dbg()?

Yes clean them up, up to you if you want dbg versions

Jason

