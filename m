Return-Path: <linux-rdma+bounces-19652-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLbOKfzY8GkLaQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19652-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 17:57:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D564885A9
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 17:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A74ED317D58A
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 14:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D53E3845BD;
	Tue, 28 Apr 2026 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VSlkWbR8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A63823AE62;
	Tue, 28 Apr 2026 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386952; cv=fail; b=ltNXjvyqPrhMvt9+vhYbHVDI9EU+iT4mEZ38oXE2Jr6LdcHCtmy1qBXTdbo65ZK6sxjX5OHFSpzETtx+h22lA5aB7iCZEnj7B8Ac5+KgKJO8n0X9E40JUDUglrzWlPLvGtd46AEPwCBEZtaPNPJOYbPpXD4utNQimNjgPHHkBq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386952; c=relaxed/simple;
	bh=fKiOVIvs/uNZdDCMajsPFRW/AUbzYVQOgh694Gce/FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YN2ZZSp+b9gbBUg9DJuVodaJI5w5Yff4WDwhtjRZNZ8Y6hJNRQiqL0aa/QUkm0UlqmxpS0frdkWgVcPNgPu2ePrQl6/ivcR6hpilL42rnykwwtq0XS7JGj8hIwZYEMlGikF7HUObj47BqYi1AtXTmJXL9xaHNkWInFZnTaaIXwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VSlkWbR8; arc=fail smtp.client-ip=52.101.62.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wI9i7m6JrVtBfMZg2zkwjtryYCETo5JTZrQ5CYpmCK0OFKX+lH6ZaNRtZoX3BqFK83lV6uFpYXTyFBuQgLN7Yr+hnSZI8FMlXMemdI+TIANqJDhpRBAaEzhfmn7vIoKDzE6e8L82PKNfKZHDtA2/HGmhyjYxMWQVG0CXBzLk7zCiKUzzUt6cT9N/G0JM8xi5ii/fsCvykDZOtgL5HC0ngCGUKVGjLMgfMJQKCcpA2wrRnTxDT05n96tlFtcjX1qDgR3iXek3+LTZLvS1OcdxDMG76guVj/eSsvyiNdwmDpRAs77OMipDZwMG10LyLs8s+X0cIY3SlQPfeR70kUJh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyrD3X4B4hv97Kx/sG11sv8qeurLGWc8wl2pGUESO14=;
 b=Rf8aj/f6UcYXNydETa3vtarkMPUAeTXoxNgfpKZAOK24MOO/oF9J0PZvPOyVzvMVlHQpYF2BFSgG/c7q4HUvyQOqZpDNe+cWL7zQIIUyqZa8f7LUReUSND1b7h/5SRQ27VuBtPFxBaaACmB1cfmvJ1Xb4FHLkhRlQ69T2jvXjXk0Sz8RX7uIXezytEp24rOwatrGHPGfxi7SreN91VfS0XhkMZmYtOxg8VM1HWg2tfZ6r88Ss9QEbsqOsckPCeegO8Z4G9xjJElLsvZpRo+nkZ2auN1ocgnlVjxvJJZhizg8Jo2YpVvxkh9PMz7NWt5wYgYHilGIJ9ra3Xa2zLgsbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyrD3X4B4hv97Kx/sG11sv8qeurLGWc8wl2pGUESO14=;
 b=VSlkWbR8i4DNG+Rc6lZOnY+dDHHbj+FM7cPiuPD4BmkiyaB1NK50r4+0Ju3imxmidwYqocre+OO+lftiWiaWWzGzacHxx55CnmUFKrLXNz8qPg3DPvD04MDALqR2Fi0ln+SEGK/N8sfenWUbn7dwS5Yw01nguWaX3yq9oUP1Wv/QIsVOjFMjYddr8AdXsF6lfOur2YQVuXvxjUzUSIMfOfBqbJ4dVDe1TOBe48wWi9iNB1NrC9sE/xEk6plm2mPx53oMXgssCKA1xWKU7ziibGqniBv+29yvo2uw1/lrZNrYDJyxRrzSMEgK+/b/NgJ9D/pZOugV5SehcDNDB+TiHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB8261.namprd12.prod.outlook.com (2603:10b6:208:3f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 14:35:41 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 14:35:41 +0000
Date: Tue, 28 Apr 2026 11:35:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Roland Dreier <roland@purestorage.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] IB/mlx4: Fix refcount leak in add_port() error path
Message-ID: <20260428143540.GA2647286@nvidia.com>
References: <20260413115949.2799399-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413115949.2799399-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: YT4PR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa95def-5ef3-4a77-bbb9-08dea5336c5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	f1cvnrarRFXQhWqoEsDto8mxc/Ckt2fSth/9D3HAWQGnl5vsnFeoIgYBv0TQFeLnvQ67psJ+IqAYM22qYlm4Vwz7HOxASjzUlDlMDzcCWTMLzb7+r9t0wUTt6sgubQJgKjAkCppPV0C6bLdYgk2D3pNfVtvzXsmJPQHqDJ/uXPk0/Doe2Om0kYBhm6INAfRny7DWB7CpZLA2mdbrlY9/0Rk1+VlRYWY1ou7g+ge9R9Nl83sq+INXpgqcDeU8UDvqH+G4rDCN8mgq5zLmbE2KLbx0U3/Sa4awWveXq6YdADF1dKieHw2QEmaMWUJzSPfU8DMWjMqq2zPj+vL7mxlQmbaaoIyvJzjyNYVyWsQHgFEC/kg1XJ1tQs/rjPhahpEnZurOSgkXhi1+ckuYW4ZaI+5DTSONz+bBAbgcrK1Op2oMcYnmXfQNTab7O0jvotSXBm42oX20ii07xP4ZzvYnocV9jlrKa2BxVE8qQu+kiCEjFqF/T1N3fFBqlGRs8W5wWUpdfvzBiQ09fm4p41VzVQozFBKODBdmeeTkc/uOG5n53UwrS8zBRtGy6jDte+wrHWWT5kbrhmM8CI1FVSAUexjzidvHmWQSWTWHzEcUNNywt3Wx85ZnJoEr9BiO9zVOhNW06vyve6eowz0cemWMTi43JI9vyyKx3YRYQqy9WwnUOu6XL1TD/FgvLnEbDDKPxYmpvvzZWc0DLDaN8wI6rIecw82yOqZA21HpmaU8MT0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tl5aC2xTdvlyHAyInNLg6NSFj5mdAXS7ET5rtHRGQatzIfDZ9/OJAqRCFbks?=
 =?us-ascii?Q?7yR5+akzaHAF3s9/1UetVEPwQ8WkgehzjP+AWLocCYZ/prDX7hKyGDTrS0zQ?=
 =?us-ascii?Q?idgWFB9Tv8gTyB2lSFxjpYVf3ZXZ5+MojDOgBksOk/9rmjpMfqgdLU0ljUHK?=
 =?us-ascii?Q?Z+gkQ9q2tpwxt4Cjq/ueUyCnFMx5SC5l0VPFt+gUsPx3hjdc/aNL5LRTeqxt?=
 =?us-ascii?Q?mOs/kWiEi095ImSLuRpkzDMChIF/iRLLIF0qjbrohe3+DOxk9KHglaPH8fIM?=
 =?us-ascii?Q?u9E9GefBlrnlRCGXLabWGarOW4KfZW6Ib2hlSqtUyc4JXiwGHRcluv923iOB?=
 =?us-ascii?Q?ypSWIE0O4Hhivb9gfXyRCw3jwLEXihZr776Il3fEIPcvzbRs/BNoFDe+Z5iL?=
 =?us-ascii?Q?LmlCLyE9ds3kbiGgU/t8Ll+q0qxvCEisgBqDT4bNm4LPf8ti3pMcla2DyQy9?=
 =?us-ascii?Q?xDG1uA6iHzMqETf8XN9VsN8lNkXir587azqQsH7LwWKZgx5uZU8Rkibx5U82?=
 =?us-ascii?Q?MWKrFZ32PRHfIx1Myg7TH/gN9FbF9XGaabllbAP1+M+twzL2uyI5nd2XjWiF?=
 =?us-ascii?Q?fPrWkRJFRrLiYO27brdb2VbJZlml5WFgEVs1v0iNi5Yb+NuTrlyMd6tfarf5?=
 =?us-ascii?Q?z26mA/S9ZLG1yYdiG1fnmy7PkTMPL9w/AcfqID3/f3pkZ7IcAu/F8IujHCKd?=
 =?us-ascii?Q?uaZvZmNU2mjLUrmludWd7YjYPRMZEAcjL29x7R/9uN6EVzXO5oKSSUOuFZ5J?=
 =?us-ascii?Q?/L+hMuSmX9+dLq95V14tNsasLdfqspJ+z6emV4BtVSMGK2BEMimtbQSa2G1E?=
 =?us-ascii?Q?772eR9K6y0Cot1q30KwLf22E/VCsh0aadk877b58D+tv/eNRN+iyR1hqSmmZ?=
 =?us-ascii?Q?kptXQ1BqQKJxlbnqMOrhaWLBzHdFKsvawAsVWPfmXeOwo+UrQVc7mhdc0Nyl?=
 =?us-ascii?Q?8f0g0saqJfJdVXNBl5RLPtzdwTzyIVOL/Y0XrJNsWF5GAMrnKCbe5lo33+tj?=
 =?us-ascii?Q?cXTU/hCv+hULwwN835K7OTGsQUeJWrCruaCZg9af8JE7pe+hqV3SXEq+OBmy?=
 =?us-ascii?Q?Y1ayg4Yo2EblgsoDErTiRCv0eUDXvo/VSicgn6MgD6Jh0BcQ/xmG43op1RYb?=
 =?us-ascii?Q?ZsdZeL14P8tVcCGhGdmUKdq2iTQpm3vrY8KBwDarmt/Y1zWGzAnttKDB07fk?=
 =?us-ascii?Q?Lbu2aaKhv81YbJ+j/S3zK2AELYJeFuBIonyrJV6f50bUr/XPXkh2uaHd96iE?=
 =?us-ascii?Q?C5TDlmY0ygVF3ubqLcaKGn+V7b+VH3sQySN+x/vasYphKWR1xgZ7JGv2TV4V?=
 =?us-ascii?Q?8w25tuUT9ROkzUe8eedxg7VHef/gsXRl6Y40RGUZVoSpmvLhLER1hbJL+5ah?=
 =?us-ascii?Q?CFI749kFSfX3SWLzbyiKXoqtu/XdTIzfsP0PgMCHg8Xq/ePSjQ0/mxn9ZAKf?=
 =?us-ascii?Q?3nnh+MPqqA0yUY7R+1xKKabacdpQgbNPHLDlPsvPDqcNyXKptwt0toN02Vka?=
 =?us-ascii?Q?cjoRK+3O2lEE2X93RXKlvlCTi3lqPD+8vzLm2uQWSS3+Yp0M9k8dOhiMzaNX?=
 =?us-ascii?Q?pttZU6O8gvkM+iGWN9kAXG/CnEUy7vyqoPp2qFUykZI8cHkymmsrDKqh8omh?=
 =?us-ascii?Q?dc7F7hIRIIbcZkjZOOWz0Dln8GB6sUkmPZDuKP7oqdWig7ElntYbAE1MotHc?=
 =?us-ascii?Q?msVT9f1P7yfJw1B+TRn4ljw4dwfWiLEPrE5z8V8o8VLcalvV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa95def-5ef3-4a77-bbb9-08dea5336c5e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 14:35:41.6161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GaRmh902mXCtJ802sEyx5zmpDWovFGmEMSsOCNePrAQfR9dIMTN64kA3d6wF1LSo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8261
X-Rspamd-Queue-Id: A0D564885A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19652-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim]

On Mon, Apr 13, 2026 at 07:59:48PM +0800, Guangshuo Li wrote:
> @@ -642,7 +642,7 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
>  				   kobject_get(dev->dev_ports_parent[slave]),
>  				   "%d", port_num);
>  	if (ret)
> -		goto err_alloc;
> +		goto err_kobj;
>  
>  	p->pkey_group.name  = "pkey_idx";
>  	p->pkey_group.attrs =
> @@ -689,6 +689,11 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
>  	kobject_put(dev->dev_ports_parent[slave]);
>  	kfree(p);
>  	return ret;
> +
> +err_kobj:
> +	kobject_put(&p->kobj);

Sashiko says this will crash because this was skipped:

	p->pkey_group.attrs =
		alloc_group_attrs(show_port_pkey,
				  is_eth ? NULL : store_port_pkey,
				  dev->dev->caps.pkey_table_len[port_num]);

Along with other problems.

Jason

