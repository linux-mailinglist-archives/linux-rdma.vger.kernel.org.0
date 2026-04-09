Return-Path: <linux-rdma+bounces-19175-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC8PG//M12mrTAgAu9opvQ
	(envelope-from <linux-rdma+bounces-19175-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 17:59:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A283CD416
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 17:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCFD23141E05
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 15:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AA83E277D;
	Thu,  9 Apr 2026 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iiF1Q9jm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011044.outbound.protection.outlook.com [52.101.62.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250743E2773;
	Thu,  9 Apr 2026 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749897; cv=fail; b=DynP5rtN0Gr8APxM3TX34+xRsOROADvNeMH2h6UV2rdWQqwZRV4KILNNZWjp2VFykGAtuumYUODVjhh4WFVllXzlsTGGIBe8fPBPdiavZ93hO+2/9MlCQWDRi35YJEoRGi7PTOlBIsB/wwlw5WjuxBydeM2WI/Ywm5hvc+vPJRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749897; c=relaxed/simple;
	bh=YmCFp4d8kKIIqCPeuWSkuRwB994kC8XYlAdxsu8xPeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ce8evRNHJFIEdgvUHRNJLS59q2JpH/gGQkUFkIVvzv9N5cndKZiOUsUT5gr0z/5LH/X46p/rvRfeN8Qnn7auU5kOqiHfGvakB7WQBPiMdRPVrVeARvp/kUK7CxAM5QPvCwPuhT/wfuPRVlDMvwxMRYIrtZ0Tvp/Hy9Kx8MD19mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iiF1Q9jm; arc=fail smtp.client-ip=52.101.62.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7KUN2HmC7S62EUymCdI++gAVQl4jSJP0YtmHv9thRl3NPGOthUQ+lGoWUqb3wAMk70NJZd0urGRyrCHCt+aKCdJXWclNx1G2rhPdHE4fh2HH9XK+1WZRC4OLFx5wDmidfI5+cAvOTmQK5BJYszkfesSGnQn7r17XxQv9u2eMtpP1AECss6mkm7q9HQGOXp8ovIZnDx0X909VQdoN7ReOfocCzgb3UeahhDDLrgqqUuIl5x9ofRVyvR7TclQsIUsBzozj+10WQ6i2gh76Te1dPsyJBEZ4eBpxZS8hVhbcFJizl5qC6Acp4Np/WBimAi6taaEMa5HoaJn4TUGIwSHvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAkW+CmT8CGpzKNlVzfrvF1JWGbW7ySHBvP+ZIzcFPw=;
 b=CvPiodwr3H2wLQ4XBbijIgqlG+BirpVnJvNIJ64tmwkj2Y1OUNBrUz6lAUaLi55XznFJptxmnv11tJittR9wEDtns6Rhq+NkhbR5sfiLaMc8zsZ2znBPRUKd+48E//sK6v8egFq3SgauekeupWFVFmn1OBsGVMUKZtjfHOOXCVvL5OMQbEvOoSGGPikjB0pJKw1xrcqU7yzBK1q938Yhzfn5XrPs8GO0mD5Zw+F4IniteysTYF2uQucj5HNwxlQ5WW8vo0rvYWoPRA1C25x77r61YHIu0pJvhq9VfUms885v/yAzYux+umCuzN4dOjoUomSgXS++qYrKKak8Ns0C4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAkW+CmT8CGpzKNlVzfrvF1JWGbW7ySHBvP+ZIzcFPw=;
 b=iiF1Q9jmKUWqd8MAb8PQrcPrupZZxjmWwPBYIOHOtkebzc3m4RMN6N5ye+wNmssUOQyY+09TLWas9dMXWa+B5olbQLPDdiONR3CWHosto3eUWWOFe9m/aYZDkSN1T7u5tKuGg97aZhyZwasHw529CFDVI119yWVn/msOSEUF467cnmVr1EfLC+g9xVDOTa1w4Xq8JiBcGkgN2GufRn+kf/DwA7nf6a05/H3mG2OtNVTxVJWcZ7DahR70mfXUJQYQMIHKklQIOtRGZqkk2PRAwinHenPhYeAvSsFigr+LUY/ZdLnJgJ/WLdrRETYtEfcxAVfcgZa4TCVspyazeB97Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 15:51:27 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 15:51:27 +0000
Date: Thu, 9 Apr 2026 12:51:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kai Zen <kai.aizen.dev@gmail.com>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/ionic: bound node_desc sysfs read with %.64s
Message-ID: <20260409155125.GA2019081@nvidia.com>
References: <CALynFi7NAbhDCt1tdaDbf6TnLvAqbaHa6-Wqf6OkzREbA_PAfg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALynFi7NAbhDCt1tdaDbf6TnLvAqbaHa6-Wqf6OkzREbA_PAfg@mail.gmail.com>
X-ClientProxiedBy: MN2PR11CA0012.namprd11.prod.outlook.com
 (2603:10b6:208:23b::17) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: c260f829-149e-4f10-51c3-08de964fdbbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wr8kNzDFCZJ5k98qvsz188rYE5rU+Nm5TW3un0BLINpEX6yPyhtpRx1HOaijLFjpLqqTon2x5DVZQoLozSk+EORgAN9YP5Yqk3t4OFVv2oVbff59XSArElk6jJvlOVLWz95BohGJOMUOWOJsUkWnUU7xmgVsflUp79vjJmG/TWpZNzwF4j3MvDj0C9cSzdZWrpCDpjJylKfGfcP+MCDukc1LpjWymLdOsnuEAnABBS2HI9F9T5tJjpwRntKfT1zZbA0uWZVsMaBEvgud50BglKl2vbT0fSVgJA02WbnmUCyNzrigjcD0ZTFcLre7nHT+84iCdaoo4pjjAHh23K9cN6ZSbODagxBnZrvhs4O9GR7PvKLkFvydVAhsHHT6hZdzp6gO/hYz6gn6Qc32njIgpyb7Gn4FnOwsJ6Tb1tZcOX3PbUw2zxUYxxUAUiCzFRbH/0BaRAXSf8UxjuR1x8/AKX3lj6U4nSQulBBull6/kENMeMXGttZrNOCI70mwpx6J8EnnEPFbCAYFF7o5/60+P8HCz6+IrtvDgCRlygOd5uXauf+7y2jvx6+DwQ2FzMR9BEpquwKPphhSyYOj7X5HXXkC5004Z+FYS8Zp23DT9CzzvQk4NGY2a8KPdNU1VAr40sTS3qkEvtcjOCLdcZ4y59OT65qW628pfkgtWS873w4QJDnUM867LHlGbHaoJu/eD+MNLo+zU84X4r2cSlVFdY5mpPax/Cy7MyVqsd0uE18=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fz52T3/pF2Dic5YbcPplpxG4jMn3heGSCpHOBfDUZatjdmTXSkH/AumVtNNi?=
 =?us-ascii?Q?X07JqHGRawwkr/rqfro8srPmSfbmxvnkYUwA1cBunFaZog/pb5t/s93NtEc1?=
 =?us-ascii?Q?VwmdRIRHo6yUYMyxeGU/FZ0v3jfQsOpqUeWHzspZZ1B9Ia2Avlr8LCHL1aPO?=
 =?us-ascii?Q?1+wHNXNwG9FK7aBbXkjUAWkHbVvfd0cX2y+3ghrGO2mvtu+9VyUO5uRj1vtp?=
 =?us-ascii?Q?1MH2CepNcp3MfOhDxpSvhG6ATef/3Wo79I+TNBguRqbsUKi48KU3qO50MY0S?=
 =?us-ascii?Q?fo+/Wrj/ipPKIX+OOhF6wJDtL1puP0CV4l3x0XgDQqHioTSxS2L6+hrw98V7?=
 =?us-ascii?Q?e9EZs2oHbZYFUOcc3Xz/fsDjtLnF/d6+UJDgCLyaso7hbjsS8T+hA6st+L6h?=
 =?us-ascii?Q?1ZCZy2+sXG6ehWQ6oUfgm6BFYpIlCjTkRQ3WMAYpcjclMtw/PGkWE8bmytwy?=
 =?us-ascii?Q?5yJ+q6l4Jns/xZ/81anuDv5wbKKLqH8U+/a3o+s6JEqB9b3JfkZW1L0WC5nV?=
 =?us-ascii?Q?MgQ3xa6TVYwfzbKaOUkGhffP/n978rPa6DLE++oI7cqgFu3bh/HSrwy4z8MA?=
 =?us-ascii?Q?v0NeoGbcG6pkLBD4nAvitngQuFOxVNkdLLR1Vsc3sTr/BpaPM6eGzRaIQ/WY?=
 =?us-ascii?Q?hx01h40qdW0kHmPz/HokPVKWLaCHwXt1OPM5LkbuAJ5bsrS+ZTKFddxiQVkM?=
 =?us-ascii?Q?FFqh1JY9gcEQ2VeWDp+Owh7eb3F5SLiBGQqF7wpQIyIdx9Gj8MJzKLFZT+UU?=
 =?us-ascii?Q?VMGweWFiPjWdUUmWNIW9c1d2uj/utsDpJ0BS77QPfncad/b9FBXW9F7HMDCY?=
 =?us-ascii?Q?ZhzBlSEaLRvspWa0zKn5q29/xaP2D8VPnqDHcHs9lvMq7F87d5KXBiuTRnly?=
 =?us-ascii?Q?BbsLAaRczrlSzPA3EWmacTm8HgyiiCEAYQxBop60CvfBweAhnEVoI0B2b5jy?=
 =?us-ascii?Q?jxkp3HJz4/lT1bMMJK1lGcmIUxIQU67Xf/C+haI16isgYaPNt/HMkpv/PMZA?=
 =?us-ascii?Q?KAhHLsgZQbKxLlt52WhqOkA2axnqkRZDwcMdRQwkAY3mYUtTkI70trQ4sPL5?=
 =?us-ascii?Q?F3+Kx54OAWoN4K0RW97UTLMW3Pwtg4OyLrU+R5KBE3j5fJ6b4Dbhq2P8HwDC?=
 =?us-ascii?Q?jhwRRwIuGDOvLPV2Xh0S411IaXbtzseAT9XzAQzmfViKRXwdDCOLmr7e6VjX?=
 =?us-ascii?Q?7RMGg94UmpMkPIbGE3C83/dhmk7XZyKm2Sxa33a59UuOZ1rMLY2VGNg2W35e?=
 =?us-ascii?Q?w+rpLp5pk1Td5domzoIDen0d265fPomffgMcTFG0Qb+jNDplvQ9Gv+XXj22m?=
 =?us-ascii?Q?a4VMqAwdsFoSnDXmXPMjQ3ExxRzWZ+2ikTaWU02hV0qGiQOknlfiTkD+2ptt?=
 =?us-ascii?Q?R5ZMGNsE3Q8p5sgLW640aP+G04yYJMX2sFRRjEVhGwFy5EEevN8pAS4uVWKT?=
 =?us-ascii?Q?sWZjwJ47tW+Dx6REHgE/LsNa3CfTkqApwM8bSU74eocDHy2apBNwJ0YXSooS?=
 =?us-ascii?Q?0vfAVzyxy0WbBJfcWI7LvHkjVPhTmihwHehhTVlDARX6/4Dl16exRZPdcDov?=
 =?us-ascii?Q?H9afnL7PTuvg287AvaoZdWxxp+6J64JsxVT87DwBUh55x7wimcVlEaYW0Ep9?=
 =?us-ascii?Q?kBEzqsGVR7OxBs5HGzSNd7kK2tmb02J6tQCSUtPaQr/bEFHOTEzl3zfmFRlm?=
 =?us-ascii?Q?khT0yhHpCW8D33IYCma+0rHxzXb+138EmiKpKTFOl1u4KbmW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c260f829-149e-4f10-51c3-08de964fdbbd
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 15:51:26.8606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYih6M2b2WMpAHLWhe5Nth5i+0AabRUnMV74dN87e3sDvPdw0p71+o6jVi2DvSv+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19175-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: E4A283CD416
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 12:20:22PM +0300, Kai Zen wrote:
> node_desc[64] in struct ib_device is not guaranteed to be NUL-
> terminated. The core IB sysfs handler uses "%.64s" for exactly this
> reason (drivers/infiniband/core/sysfs.c:1307), since node_desc_store()
> performs a raw memcpy of up to IB_DEVICE_NODE_DESC_MAX bytes with no
> NUL termination:
> 
>   memcpy(desc.node_desc, buf, min_t(int, count, IB_DEVICE_NODE_DESC_MAX));
> 
> If exactly 64 bytes are written via the node_desc sysfs file, the
> array contains no NUL byte. The ionic hca_type_show() handler uses
> unbounded "%s" and will read past the end of node_desc into adjacent
> fields of struct ib_device until it encounters a NUL.
> 
> Match the core handler and bound the format specifier.
> 
> Verified against torvalds/linux.git master at bfe62a45.
> 
> Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>
> ---
>  drivers/infiniband/hw/ionic/ionic_ibdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Your diff is malformed but I fixed it up and added a Fixes tag.

Thanks,
Jason


