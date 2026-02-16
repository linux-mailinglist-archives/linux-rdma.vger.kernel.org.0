Return-Path: <linux-rdma+bounces-16925-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGAFMbQzk2lx2gEAu9opvQ
	(envelope-from <linux-rdma+bounces-16925-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 16:11:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD77145343
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 16:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 653383038D25
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 15:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140BF318B95;
	Mon, 16 Feb 2026 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d/19mU7z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010023.outbound.protection.outlook.com [52.101.193.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BFD3101A7;
	Mon, 16 Feb 2026 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254182; cv=fail; b=Odb7cLq+6tea6JdowR7cdlIy/Om1Oda3oLP2ggEqxBy1owWYswaT9i4j5E+FSFEV4mllwVqHY2sm4/OMIB9hq+N5sHnosDMy6TX6GvNGv1fPqdFJ7/vySFy+/bd+IqwRAtAo5Yt8K8C/XJrCIViXxWhJg5A1xVsXwYDbM7d2sdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254182; c=relaxed/simple;
	bh=Dk7dKA/sB1+VM2Pd6XWVnODOoAYJPXcd9mVL+gAKOtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E07dNBOuKgcy+Cr2fjYvC4G+oon7gLvV7AfjIqERowAzB5KnatXXe7Xg/J6vs+s+iSfuFHEKQU4HLOtT4IZ1EumY/8bzcvtM9TupZ0tI6SOeeOYjFh59D45B+64OQwu2o4lzwvA1NZQ1+omQLwNY0lmd7giAHS61jCK0aUgywT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d/19mU7z; arc=fail smtp.client-ip=52.101.193.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgX8i3bxfAlBpx8GVyjFpj5Dh5Ll6K1FiZb9xigZiGptupkwqtgbylYHVpeP8j/cDZ5gAWJ5BO23Z4Tp3/8umvPk/9U0s1JuDixOIvSPpkw6fhPuX/fGzcvVhtBjLH/Cb6SDA439xhL4Yv3NvDghoAX2RU8ZldIRZ7L30P8PmpDF8rc7FzckWFijRT4VbHfUI1wcuRen31opgIiRhV+naMUe49dLS52EBr3ek3PPAd3D6onb9/dIL0TXNK5yODzGlYi6ONmMZQVxWmC3AZwulPaHpeSESZM21bkKtdK+poRQoBpbVXRIOzjkY04RC1todBy1937ECSJNsed/oa3AMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJQGWe+52GWvHNE/C7uPWTwf6Mrui+bdTEv6LkD20fM=;
 b=tGBecd/LAxvNu0WJqw8RBn4q44rplPPU5Rt5fQCVrppQISiNdE1LYZPRKYraHogKOVOyBRIehRU7JT2Tb2ZOsAqx2xsk9Yk7RQVyngtrzWviHAmcog64A51dPCFnfDDAFHGMem3aTlkkFrQiAVLUPOWw05EWY2HRKj/Ev4JgYj22oNUbbQWl0wrZD9oZNfGvvePCFdgqahEAdpKslQrYmwcNUrdFHS+tVMhIAiDZUjqH2VjfsYpUjTGSszlKDDVzzv1W/Fn9sn2sOwcmeTy96CqkdMp+oR1jOdDNb7xc7XH9aSVvnHDBKe7ym6wPdjXZF5YQliGC+MdLlb4zuNTGNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJQGWe+52GWvHNE/C7uPWTwf6Mrui+bdTEv6LkD20fM=;
 b=d/19mU7z3SrKPiZ/XRrXW6oXedgToHUZEv6EdYYM2UpObC4EKm4el3ayV+GYhyio7xEkRxB4uu5q8OEZV3qHN8KHt5u1+CbUN+8YegPFDfnYRZRBhC7Y5tiP8QpBncc0yuqLhNBJU7FhUp/Wjs6SECahJRupdI+Bx3GZoJyCKnLAp+NNeYnQx1FME5VArjMqjgxqu5Xe6Le6CcdzeNDa6JSrJdzcN0oEziJSJdkxl4+GrhFNR98O7VveuXZQZVFfJpqrThz5Oozo7mZHCgY76z/8zmsxPl3oASoTKlIXE8brYhbXsqrW+csg7LWe9WQor1IJ+G+g0aw5xmMKvQ8WTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB8588.namprd12.prod.outlook.com (2603:10b6:208:44f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 15:02:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 15:02:53 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Gal Pressman <gal.pressman@linux.dev>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Michael Margolin <mrgolin@amazon.com>,
	Yossi Leybovich <sleybo@amazon.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Andrew Boyer <andrew.boyer@amd.com>,
	Gal Pressman <galpress@amazon.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	patches@lists.linux.dev,
	Roland Dreier <rolandd@cisco.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	stable@vger.kernel.org,
	Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH rc 4/4] RDMA/ionic: Fix kernel stack leak in ionic_create_cq()
Date: Mon, 16 Feb 2026 11:02:50 -0400
Message-ID: <4-v1-83e918d69e73+a9-rdma_udata_rc_jgg@nvidia.com>
In-Reply-To: <0-v1-83e918d69e73+a9-rdma_udata_rc_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: 70536687-5c8e-4294-b9ab-08de6d6c74c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1PAaW56ErGwjtQvOOpmqXqrvsKwQA2TyUY8qMfLa14JxgANNfIb5Whx4cI13?=
 =?us-ascii?Q?2YWgmrwss38sLOTUpQ5v1iQhoOUMf760T+I4raRp0arzzTlZ0SepLOp0lTCO?=
 =?us-ascii?Q?srbAM/MpG0Ad/EjmbOto+rClAdhEZgeJYF8A4LYUCXu+Ywqol9Esvj83Q++M?=
 =?us-ascii?Q?9wKN6qpxrFsiLVUHIWdogL+ZksNWMmjuojlyGYetyJOhXzEd93bBSx9AYelh?=
 =?us-ascii?Q?/WvmQFPrnMO22UqLfQMLRV/GgbFwsw113yO2SPBMu8yGFWtxB4AMwWlsrCO8?=
 =?us-ascii?Q?CBZcSdJ0C1q6SdGqZqb+Phf3eIHhkc2ewLAjLvqS2oBRy6CuzdyzFfzWXCYx?=
 =?us-ascii?Q?odIk5eh0GZGBRUQvmknlu/ICkudZibjVeq1nT357MjTTajEs/qWGknVytd0X?=
 =?us-ascii?Q?6a4Kci4qW91MUDQrrMHaMLmyVQJ2R8sGB1wEZyYW7/pr9dInB5hjOdzcob45?=
 =?us-ascii?Q?ysHoNDllgVUmmVV6wiEl7zKI0jV4uquIKdJxuqGumPGPUPquYdvV5So6hGk8?=
 =?us-ascii?Q?QRDVM7ZSV+4KD3ts16eFIfpOvMPJo64itnhWLoXjSz9HQexPGVZNsxTIMeFn?=
 =?us-ascii?Q?+sgMk2zXB1TvZnWYqK+bxIjurDMI1oQ1F+xClDrLC43IDm/Zimu7Z6j7Dwqa?=
 =?us-ascii?Q?DT4Gr2FK7JEqTToVpA+yis6VanedMgfpL7RBWVvFqgUNVo+LXGCk+FgbX1QG?=
 =?us-ascii?Q?SLYLMLPNIihjpb7E0VDJN4BJt/5Kth0lBArJlWzOD/n3fW3ToBic7BCDGj6A?=
 =?us-ascii?Q?8NcK8uz208yXHP+NUKNqbaBz31X14VM4JZs/ekH9W100HwXaGDY9cPWGxa64?=
 =?us-ascii?Q?nc220iwpunidAe4ytUNzBbHEA8YrCjJFLqLAgwK5zzug4Udob5BvMJj6sOQu?=
 =?us-ascii?Q?MX0IHUt0vUu75aAjDZS+QLn4cJzuSs0nO+RdkcKsaCvaFDuAJ7CkbkAFGIHH?=
 =?us-ascii?Q?meOUtoGODo0aihsYneOn4Ln3cJdWxIhml+OIzIB3ryPtuV9scStL7kleFFk4?=
 =?us-ascii?Q?BOBAuN1LY9tqIdOiY4EZ0ACu29/ft0YbjhNM4qvD8Hf5ti38oAApa4NfnB7T?=
 =?us-ascii?Q?Ta+T8VMgG80WvJn5cLo0i9p159Syxbq1Be8hnJ0WTouSeSzNfxkgyRKcv2xj?=
 =?us-ascii?Q?bhExESttRDumDt6Schm+yO+OxXNU55JjyzsXvFnVLU35jNRl1gnvRQWfel9i?=
 =?us-ascii?Q?qco3mDkPpfEu6FQhcRiuE/sGIyvfyBVsDXSUK2htM/BUvuvXjjKKg1B8TRjL?=
 =?us-ascii?Q?nWK9+RwQfee++8p37bzhzgelDDX1zhIjLt+OEouhgkrj+03GdO089C6nViS3?=
 =?us-ascii?Q?Urh8vPSfVyUM4ecfP8IkIK/wQvieWF8CIOnZoU9RxwiZVd7y2bJJBK39Xq8r?=
 =?us-ascii?Q?byLWOybpKwhGDqvoBl6WVVnSoGnyEcXLQJfUPEwAC86fGuvxxos1SICy1F28?=
 =?us-ascii?Q?pVxRMk+eay/o8ka4zmn4djIwyMyG7LNjVF1fQ1oLCgtxf8leGo3+KqPekKpf?=
 =?us-ascii?Q?pBxMmCttX4PRv+uwSyVJFunFeD8K72MIt7sl5/ZviYP47D/MqucbX6GpxJKT?=
 =?us-ascii?Q?TzHynYllfrJJ4GrNBHk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9EIlL8Of969mUjT4XePVRKPLEXG0Jq9754mByVI/h1d2+2SiGf0UybtyvHOt?=
 =?us-ascii?Q?9uZuVUKZqSc4cIpciyt3iSLMuFAhMwsXDjjeYql89+AsHbAWC2rPCGNOEx73?=
 =?us-ascii?Q?5GzeHG7c0PRmrlkUNaP5dvU4PBWmtcp6HL4KV/w73pa84kbpeORRYV7tlIV8?=
 =?us-ascii?Q?MrFwaAhBTMgjWAVC6vwuKgNxJOQUwmP0SoUCqoQUG7j74T0lOrKl45RZi7JL?=
 =?us-ascii?Q?ZJHfABp1cWTwzB0YnX8v1ZZRBNb/++0H47DTlj0OgA+eoyha6aviI95/YIST?=
 =?us-ascii?Q?MBExLrHJPJWwspT3GIfZWkC70kAkUEpC5lDwmeUF1ZybOtMD3/PTqQlSO6yG?=
 =?us-ascii?Q?Hz1ItlsUNJShRrLNBQ7p0Pww56y1xL8nE37Fcf4YKAcgg4geaxsQ/BKTdIpJ?=
 =?us-ascii?Q?6gidJArqKlqjowSPI8QujQGmRRk3gayDspkQCL3qeijbbefA2z2aWXxhqGKN?=
 =?us-ascii?Q?YFC+SK3aXkrpA/xhWB7SkOGVd2vWF3G710R0dUWPNlI9OpyesvH9/K0ecL8s?=
 =?us-ascii?Q?RXq1NeC6EtSgrgM4s6k08IvCXQKZlnvbM8BoDTFyCeqdEYIcco8g0Vs2CHrZ?=
 =?us-ascii?Q?2hVdOYSDxYYLdJor2TAKuCjUhKgHJtRjolOCVPgg2JqEpSw/iw9g9hGlEnqG?=
 =?us-ascii?Q?uHt2edq6mGNdbR31wZOxeKrmHNzPrQ26iwFvY5hw1fxfk2hviW4298g3/I4t?=
 =?us-ascii?Q?HQjqY/0TB1YEpC8FYYLjyBtRvRzOipeMQv4uIefhIZ6VKWudWHa/5+z+4t8j?=
 =?us-ascii?Q?/mO+sieRo2Yr2TkAh6zY+0pI4bSmOwyaEJYd1gFLmjdktsLENXkOdGrr41aA?=
 =?us-ascii?Q?sk7u9RSCtteLif03SUTH+Wa734CEjMN67eAEIxhQDnzRuqiGz2PFlYGdsdBc?=
 =?us-ascii?Q?V+SCwxNh22l1jfsabMEsbzid8Wg9IMJZ+XgtOK0hxhtoESVHVbQpcrEvA0OZ?=
 =?us-ascii?Q?QrfTLF/2wjDw/7etgoSyEDrjnJarpva4she17V1ybE7/LW5SxRfxTAGK2OTz?=
 =?us-ascii?Q?kPV8aqu/Q/ZGZ0ydt/kzzn/zVFEk04FNGDlpoWJCVtuntls1FKIDjzsp4YMN?=
 =?us-ascii?Q?Ccb38FMSWgH3GdS91maE9L3sJomUvwoNBUkMi2aHsm0uKmsZdlAPdL1AJDd7?=
 =?us-ascii?Q?HEhGdTTcRXwGbQnnPaWzQAqF6wCb7wK++TkqEirxDm2BH2UT+8F8rkKtuB5b?=
 =?us-ascii?Q?kOZ/4RAKJuH+A6Skr1ZrzdMMrjfgQdueKTXamUS3VwBEegtRof8HR6aF/Qpf?=
 =?us-ascii?Q?XmcvY2A/jTsgWohFHMjI9lxObw2JLaI4Ov6ZwPCb60e4WEjj05r4Iq2tdkbA?=
 =?us-ascii?Q?47vFU/SaeA6HiytZt5gey9fBZKf6ExXei+ZvNS7UkEJyNTyJyw62HfkTWn5d?=
 =?us-ascii?Q?za96kGLUcf2hEjs9sr2Dlyro2AAzR0+ePAQX6MnOMQILql/XJ2kIxqQN9Hx4?=
 =?us-ascii?Q?3jbL6qT8aJ+U/XRSiWpz+fZIRiqim8VlcmRQr4XPxzJaWReX0DhSFzGMjDbm?=
 =?us-ascii?Q?y5qIGA/TQ92fuKo8owsUaft16X1l8mUUFLmmZJhPRDq4sqJ/muYx8MDts6oU?=
 =?us-ascii?Q?BmzaWzo0KEt0XouyFfuucbzimmekYNXf7DgoM7gX+7ZVX0cHn29B1oB0IAaC?=
 =?us-ascii?Q?hm6FQrEqgPkSHpePn3NgRv3sWU9zPJSLiU/kq4xXYGOQhKId2K5DjO+iX3Nl?=
 =?us-ascii?Q?yXciIYUfl4ZWRTUctW6PTlaN4RcuQOa/QzraodlV+tX4/emT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70536687-5c8e-4294-b9ab-08de6d6c74c1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 15:02:51.9960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11+YltF7UY48OBQIG6Gz4pbXKWcpwKaRmbi8ua6rCSRcthWEGqiLD+22NYFI2xiY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8588
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-16925-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 6FD77145343
X-Rspamd-Action: no action

struct ionic_cq_resp resp {
    __u32 cqid[2];         // offset 0 - PARTIALLY SET (see below)
    __u8  udma_mask;       // offset 8 - SET (resp.udma_mask = vcq->udma_mask)
    __u8  rsvd[7];         // offset 9 - NEVER SET <- LEAK
};

rsvd[7]: 7 bytes of stack memory leaked unconditionally.

cqid[2]: The loop at line 1256 iterates over udma_idx but skips indices
where !(vcq->udma_mask & BIT(udma_idx)). The array has 2 entries but
udma_count could be 1, meaning cqid[1] might never be written via
ionic_create_cq_common(). If udma_mask only has bit 0 set, cqid[1] (4
bytes) is also leaked. So potentially 11 bytes leaked.

Cc: stable@vger.kernel.org
Fixes: e8521822c733 ("RDMA/ionic: Register device ops for control path")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/ionic/ionic_controlpath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index ea12d9b8e125fe..83573721af2c08 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -1218,7 +1218,7 @@ int ionic_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		rdma_udata_to_drv_context(udata, struct ionic_ctx, ibctx);
 	struct ionic_vcq *vcq = to_ionic_vcq(ibcq);
 	struct ionic_tbl_buf buf = {};
-	struct ionic_cq_resp resp;
+	struct ionic_cq_resp resp = {};
 	struct ionic_cq_req req;
 	int udma_idx = 0, rc;
 
-- 
2.43.0


