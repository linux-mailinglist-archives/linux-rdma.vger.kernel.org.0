Return-Path: <linux-rdma+bounces-21604-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CeONiUkHmoohgkAu9opvQ
	(envelope-from <linux-rdma+bounces-21604-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 02:30:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA31E6268E4
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 02:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24D2F300692B
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 00:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE877306D2A;
	Tue,  2 Jun 2026 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QM1C/9CM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013007.outbound.protection.outlook.com [40.93.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE4030676C
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2026 00:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780360211; cv=fail; b=s8ElVGY27vVOW8SrToJ2DLqpMQXdgoyxVKlPf7t1iYSKeMQPjAqjQ8sqzQFnzMpZsth8anzT79ovFu3DDsYqgc3K1o3HVjE+VH4+s55rKs2Ox1VCd4j5btYL7yaaqwNeGQaNsLaNryqEnDKmhT6Y7xpsdCtydT2cMTUJmrb7/fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780360211; c=relaxed/simple;
	bh=me1SiglsEe4hwHNKhsDJBAlsedIM4fng5w3yOvAWGto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hQsDQYvfebTe97RlED23cWHSrnZcmm2iyk02HrCNp1hahWxMZ2eRYEh1JJm4YZdPpFwJrjN+UG3KjBxDO/gIUmMYbTySuOMcSZD9f3bd9ckcSe/QL1NPnr+2V/TOYeoli4gKSWKuqB5Ygd4kKx4706ZIa6tow1XbA1+M0WtNzvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QM1C/9CM; arc=fail smtp.client-ip=40.93.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Egh4nataop2mTajpKPzoHjUCIu3ce9n+bGBmWmFXdggDxgYRUAoF8IEKP+yttQvk3L6S5tBnPLSycm1fsNZt8S3XvXbRTFGkk9ONlCHLpQzuuD3JIXUuZ5p8EMDrWqTGB7xZBmox/73vSRPQaXL3wevsvvuUzuBKne7u4wW1hhz99NZQBuxf+53CwmMpGUnNdXdv0cfeIlYTccPe+r3GI/JEhUwsX/t75X/VcXGwmTkwmtNw62Qo44tBxlgJA+sJHHsnMAMkToXEU4mteE2w48yOSwOKHjUbCrOiKZJMaw58iqtvJFRcZQ1RpEHTAbaNB7XpPd04A0zfuR35Uexaww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqptodOJQ7srGy53o8+oPxkG+FfDz8/5OtcwZa0Ki20=;
 b=F4M4bTJQ+EX05W1NflE/JNYIpL0fIxaq7HuO8hd7EDG7Mmt24bSvFk63kctfUZjNsASsrerQm5W+SXvHyyMOnWy+ce5UifQfSkAHaOV0oIifsGS/D0UOG02P1yloC6O5cAOG5Iv0t7fEKaHwGkjSiZPXf8ivJIXcSQyLWgsP3lVZZ+Nk9lhozz6NJWDXXNFNkKf8d3YuvjkqOhdbg45CzPWRCox7ksb/O2/zXtKr8l7nfhKKEnJFLQW0LhHskM0mU1yKYufy5hCa8nfYcTKfH91B5h2xj67jUObVtrlmSXl2ytBnGn5p3fvwmpriOI+a7K/T8VLiy3z1kX1Yh1A0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqptodOJQ7srGy53o8+oPxkG+FfDz8/5OtcwZa0Ki20=;
 b=QM1C/9CMLKTNYk+kQdC4iEzhLaiNHYoZ9lqQrSO6uiUDPtitnmFWsux5ycOtD4OTCVtmOudROcgoXtI3QtymxwAVYn+7QNnoB1r3t9FrjT2FhvTLZmlQrlb9Qz74tMyL73HZ6KhXGe6FE14teKzzwloSS0pFOVHwz1q6lZ5jK068+MoCF/BjKlgQJeAakgjfpppnw20Uqno2sKgkNwQXxxQN4CcoINjJ7vrFd4O5M8eIW4HcWndHiquYPWCOUt9eSzmewqbtQCr2D2d/DQ5mXWkutZnXWnXBMBH5Pd4WgywhlttcIc5NWOXTBM4AL1OQsNoyrBkF4+Yf1rtP3UmRjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 2 Jun 2026
 00:30:06 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 00:30:06 +0000
Date: Mon, 1 Jun 2026 21:30:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yonatan Nachum <ynachum@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, mrgolin@amazon.com,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev
Subject: Re: [PATCH for-rc] RDMA/efa: Validate SQ ring size against max LLQ
 size
Message-ID: <20260602003005.GA648279@nvidia.com>
References: <20260526081536.1203553-1-ynachum@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526081536.1203553-1-ynachum@amazon.com>
X-ClientProxiedBy: BN9PR03CA0405.namprd03.prod.outlook.com
 (2603:10b6:408:111::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 727e9b90-3b38-4099-3f62-08dec03e1843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iG/EQbVLWlCyGb18J7FX8F1xzzi/b5B4YVpfhauGB2gVq8OTfsvxGaYXcVR20r0oANWPNhrfoSjmM/KEt9P2/135P0euAMuaRC7PWvmgk8VJ9+Nb7BHSlqqtFS09ryK1Ln1L9SO6rzkaAtEQUKGVUOBRLqJ5F2FDTWg+ZPszJWQ2nyQYCFY26rTJNkUoUWFtG5HPpBytd/GqbumsStPzGk/YyditF9/sVAxctqRl5/a9EoPkjFk+41g7RCRuH3ThKwlVWAcH1P4bCMVKKUL8hN6Oja9IcISDFPVhYdlizbadIkE2b9UjndkzigAZY76GMDxcD+CWb2RwDB6wCF+S1+C/Xbu9qkhNdeV2tFh21NPJ/V+q88C3lgxlUXF96wAPdRrAM0NeEmcsQwFsBnMGZxQq0HNUdnvV2cddTMGy1mUKwuKfCMxUK6bciplyEJWL+GbUU6mxLeYa+PdEboSyUNQT8I1jvePnVFX1bvof4EdhVYSqijINjMgBfO2Szp29EAKYGvcaPIExcrEj+1K6WC9O0PtTvFYwe/5EHn5T5cJW1I32PneVrX19//pe9chbo3EVkUzXjNnxykUaXWbjpJjFqtWg/MMWf7HsyTjUvrYAnG/6GlTJAL9nMJq4g/0TODUUrJkCGyLNozg8DiREYK82OlGWOQiFji+rnu53EF4ojiMwGufo1dPDtE6P2/xl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OFEw9rPZFDTV6491/ACA/B4DPtU/2l0BgKmW820PQaYxfsemdqEvG9RFw0hU?=
 =?us-ascii?Q?/oBKoRCTflDO7a27mP6p7aOD6yWSmbVduxeIha/Xf/sJmQ1OQliOlTXY+e8q?=
 =?us-ascii?Q?6d/OeL0ikjnwvD16CphffG11ul3L46ZwnEEw9+Z3kgDcpNbT75OhvqbRHA8s?=
 =?us-ascii?Q?i08lzq6Mkmqx6yPio3Y3pqB7rXGetTwXjmX6vL1SewbyMRjybwxZszNehTwL?=
 =?us-ascii?Q?FSkWbDACeVO+mO498RreMCL57uDsn1HqjIW0gU/hG1hyFwBaH3Bg+9FiALs0?=
 =?us-ascii?Q?dXouKgltRH8ax7KiRT46y2+nsJEuNhzAHf6dq9L/G1vzCtu9+YCx3raKgYkN?=
 =?us-ascii?Q?O0twLJYuhLlmW3qj7n5vFwoPlecs5SCdeQ4CirLsZysslZVLUAIK+kPNc3YY?=
 =?us-ascii?Q?Q+vml7zv9aY9B559t3c+nHI8rWT+p6HXOfBmUircJZLijZRIzVkkCCRO2FnP?=
 =?us-ascii?Q?rE0ctpKlv5OdVFSnv8D0Gzxy9H4DxzMSyaS/dxNkkL5E9cfa8D5fiaRtaFGC?=
 =?us-ascii?Q?RKXz9WBFWxIQJJN6LacE9mMEA5xMYJ6gAsoINp/9aAmk23YTJHHFHXdVvVbC?=
 =?us-ascii?Q?rfqZU70fduhhDC4GTKhuOvq6VW9WFSsijpHq0LNJ9PlTAr6clxTvh5FUhPJW?=
 =?us-ascii?Q?TKuk0ItMIcQuXQBKoNfMz4BDkuUauxEvUuzUvHkOabr309slOey7If/HcwBP?=
 =?us-ascii?Q?UdvvOPhfFKts62+AMk21MxD2nZ3+a+Qpp/P13KdouGuTj+HooThG/Xi7sRSs?=
 =?us-ascii?Q?UqJcVQxbApsHdpzMEQ5C+1hVx3nDBtoYCcDDR9DyHTe+A/Z2CTaa0LWgxwlU?=
 =?us-ascii?Q?4d7R16mgAd/f6JhZM5nsrSd4hMRgNN0ty9Yi5BXj2gWcIbFuto5tnjPWgu3/?=
 =?us-ascii?Q?EqAn50mhhsB3mdJH4XseeaPLsD4wwuBlemZdJKCvbcdI2uuCTDVd5FJwSWFI?=
 =?us-ascii?Q?AxHAuYdIwHnoJya3ZP511E5mLCHnfAKcIWLKok0s0VQs89iJFqyWMhYCClwm?=
 =?us-ascii?Q?vYJ2gVMwRVKJawVLRGvP75FwT5aUuaOVEP9L+mryRU6Ta8ubnnWE67ZqY/ig?=
 =?us-ascii?Q?+GQFiZxD7e87cAlNPJ/6xaUXec/FJ3nIEw4KbZyLgn+vEWBOrCVEMCF2/uO7?=
 =?us-ascii?Q?C8vQiIU8Cy7J8CWjJD+WYeaiLi4csSE2N5hyOxbPOD2QpjQxt2K7gri3KnME?=
 =?us-ascii?Q?Bn69iRvnE62Svsr8X5/5rpr3fWgzJBwtSn2rbENj9fyTc/h1zuXaVJwCfitc?=
 =?us-ascii?Q?PBwXeX5yVpmwRv9wymxmu34Q+nK/X1Lox1hNz2XAjcG2x3S5syobjnKhmWr/?=
 =?us-ascii?Q?nbrb5TJCrbc8pnNc0X0UMRfL6ZeibgWdXgDA9lxQhMQjHyx7pZFiD87iAU/k?=
 =?us-ascii?Q?AFGgbbUpp/HbOM7sc75t+3tC7FNfosBv5Wycb6hY3lHZPLzDWs8axDYYOVZ5?=
 =?us-ascii?Q?+r90VQ2K37zDWxQT1QDaRwOMXWbEmQ0g0/TSdIawcPmR8RkG1Pp68m0z+Yac?=
 =?us-ascii?Q?3ncezd7eAuceojqIOxKCpj0bwCvbI5+LoUZlaGgCeJtb0TT+l960vPYijbpa?=
 =?us-ascii?Q?qUpW+uQafH3XsprMD9/op0OqH+6nHL0knrGAMqOm6VvU/Ju+hH70fqcvEzU/?=
 =?us-ascii?Q?ES7FiD3hcJKMGnQHsqL2EDU2ptTRwQgeu4V7e7o34thyvYd3m/Xc+Bf9HwbV?=
 =?us-ascii?Q?pQ0Vh+rTnNYGY0kqTUqJi8n5g0BgveP2FvlG34PrevPZ8hJB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727e9b90-3b38-4099-3f62-08dec03e1843
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 00:30:06.2267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOgrRXSMLiHXQcnqtkDjQ+hMSEo2LjkEymWlSo5RWnOsmscSyPswq+5jEySNmMny
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21604-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: DA31E6268E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 08:15:36AM +0000, Yonatan Nachum wrote:
> Validate the SQ ring size against the device's max LLQ size. This
> ensures that when using 128-byte WQEs, userspace cannot exceed the queue
> limits.
> 
> On create QP, userspace provides the SQ ring size (depth x WQE size)
> which is validated against the max LLQ size.
> 
> Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
> Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_verbs.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)

The Sashiko comments look like they are worth addressing

https://sashiko.dev/#/patchset/20260517175216.614494-1-ynachum%40amazon.com

Jason

