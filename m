Return-Path: <linux-rdma+bounces-14127-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C071AC1C3BA
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 17:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C6B1A21021
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 16:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B2F26B0B7;
	Wed, 29 Oct 2025 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T3Ykp221"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011044.outbound.protection.outlook.com [40.93.194.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C97A33F39D;
	Wed, 29 Oct 2025 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756283; cv=fail; b=E2RoVi+Er19HvZ61aD0kX5ov5xUxsUa+FgXpXUix/00Zfdl25JqtsiE2MJUgpFHPPz3NNuu1RxHddvfSX2Z3SrXrJsxePx7XgPrTW+QPmks96ANM86lVz4n0YJuMoXP1e/LYnXeY9/fzyxqpkGoTajYQvuK6w35liyOOpWcaNGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756283; c=relaxed/simple;
	bh=9gh1MiokrD7aWYltPeuOb3HltBDFuEfRNFwBBGUKQwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L+KoK3/FEBsfuYmebhqivvXpAT5xE94cTvX44F0LEXRtuGr2dMiuaMIrE+Ge90627VCQURN+7em5yx/tVV34XyvvrWxeqg6sUQ0NP08hb15nLJaXFqkLXZjMzw3QC4/TjaBCWg/Y41wZYYMAIaU2Joc+SJYngqLjhRrZ2G85naQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T3Ykp221; arc=fail smtp.client-ip=40.93.194.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhVP4CVwKMW3b8O2BHzzz+BGKmGvcNLCowokNJ1qlN++GKrb/4hF9MEhsWJ0gFtkKFCfH8NtXCnmEgXrKtZ7QXHKkp3ceisBV32gmmPehEHnc3Oo1cGDTAMgv6Z7+5qKKBiWUB5sg9cjhPvyNYeW8rS+ut9FRPDYxbm4IL+/GW4CGtl7djqmsl21wzHeJoDTw1BrktuLKo/OS6Q1ovcsrCbzxJDsdQheCjjzHAkQSJebSZtaFwLs/i3tY9SD7dTFCkfvsW/Cb6WlEXhyofyFNfCS/kgaRS3zEpoYodffmoeqD3TAJrzsMhrqEVIcP+r790l9GlVHaxETZy933A5deQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpH4YCc/UuTNnC6Yk9WS3ZCIPCtDvcayo5dDXq9aeqw=;
 b=rfV9t524STjfg1PRyjQnLZuMwB7JvwkoVCwinyT2Mz4LT4yMnK8sYP6KCDkema8Er35i1zmcXgUwPKSnJT0Dn1VXm3g781+djxWCQZ/XjUN390QhNo3g3YWtZ/lKdGmdnUdJtiNPswNA2MMy4qOmKqmigssWMGLy/b19fq/ypsxf7LYIWjlU719lA/6u5L84/07mQ6veOI8JNtwe13msqXp6hSqcUfNuqJj8p2FhnZMB227W7JX8NkDgfptUoITgsVG34tSyP8QBNTP1De6wfmamiD9em+i7uqtrSI/cuDrXz7cL7hplCKCzbX1iJV0kG8GUJL4P+fZBRw9r0+mMgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpH4YCc/UuTNnC6Yk9WS3ZCIPCtDvcayo5dDXq9aeqw=;
 b=T3Ykp221TtG/FJGlzsrs/UsUg58Ji/STOSaOzqCtJX6MYrIMSXJGJtTqFcJOnQ4g1b8AuprUORLsp9Wb4Ckr62a21Z7SPr52hAtWRyLb3vAstnFH5+UUNDNF3NJWCj+XJlSPFreo35nhacgXluyjz45CSNye8J71+rzuEmNvSzUI3VQ+1HnaquTkbvRI4+11mFDIxyv7WKmurVM5LWDiXhKdU2PuzHuewbyT2w59raI2hSh8i6g3UWzn8Ck1+RzyvXmLIqcNolFlQfjdXpaB/gk3+CMzwDmftqtm8nfncrP/V5IBEkqdz/O57KbJd5ihg2I1KGbMOJN2P2al8RnheA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by DS2PR12MB9685.namprd12.prod.outlook.com (2603:10b6:8:27a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 16:44:35 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 16:44:35 +0000
Date: Wed, 29 Oct 2025 16:43:53 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net 1/3] net/mlx5e: SHAMPO, Fix header mapping for 64K
 pages
Message-ID: <epa72y2pomluhhbeziycpnpcraiemt37xmjk34c4h5n7exgqhr@an2rnvzbjx2v>
References: <1761634039-999515-1-git-send-email-tariqt@nvidia.com>
 <1761634039-999515-2-git-send-email-tariqt@nvidia.com>
 <aQI39mMN-YADabUB@horms.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQI39mMN-YADabUB@horms.kernel.org>
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|DS2PR12MB9685:EE_
X-MS-Office365-Filtering-Correlation-Id: cf992644-7acf-4d97-4af6-08de170a714f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LFSrUxTDWX7FuPgOUyohx/uHdCPXRuwL3yrLebpgFfQll61kb9f5eLn5g2bm?=
 =?us-ascii?Q?h45bRnUtz1e3/htTQ/5hRFNVidPxGdnqi0hHT8meUDDXUKFL7wUGuWfJN5TG?=
 =?us-ascii?Q?WqsKcqugohxoICtKsAbwF9AZqPs91bPmr+K8PfxzdG4PV/uJ169O3HrGUWwh?=
 =?us-ascii?Q?n6LN4P20lLEDXAH5MObwK00wIhBipTCp4MdnbOeNigDIyWe80w1A9qtoOKvG?=
 =?us-ascii?Q?FxAUa5cKJf3oBdS+c4wbTzsJV4+Ytvy5+SaYhpv7l10twVMBmQi9mBFpga2z?=
 =?us-ascii?Q?PwyatI7a2qMBRERpNmym0vjqfqDS3lOYP/DqrbvJc4mHZ/SfRWVlZhN1lKAR?=
 =?us-ascii?Q?yU/CxMggC09vhyIlsoW29RrzYop9zkwfv/+5mSxstm05RlJ9XqSzyzvc7vE7?=
 =?us-ascii?Q?quli3z1I8ghY5FTASVxSNA46ktycMEEWQdqN2lOb5z6xcLxTJEq9fo+rfPLb?=
 =?us-ascii?Q?uuCNhvZr8tUD+AdUY6dETo0b2seg0cP6hC6RchmY4RLg+WBpyJ6sbbXzgjPB?=
 =?us-ascii?Q?eztLQXVAiwqlskS6hxBUwdAqcHGF6+sP5wO/9KXIid/yJj4RPjx03Vavu8Q1?=
 =?us-ascii?Q?eaiMQFqIpuzItHpEpSahprfx8VNfwTc00aSvIgc/RG6TYWudRfKPCGTmuEvS?=
 =?us-ascii?Q?7MP4v4JSJiqcFDdITHXndIr3+9TrAq8d2fCtirI+lY70gXF9ai6Hr0lryqMH?=
 =?us-ascii?Q?l8DoB+4DN6cHgeAJroOFptDO4e2sg3j5jpwYApT7u0m6/y6wsln91/daroJq?=
 =?us-ascii?Q?Vfr/0RJukyxMb5AvrDjCtpjCYXIjzPA0J1iouQYd1Bf7DsG5LF24+JPWGzGz?=
 =?us-ascii?Q?bKdugTdORI1EeqogPMj7ev/sLCgqM/0jhqMlDRkijlcH2QPi1IoL1U3fhWkx?=
 =?us-ascii?Q?MDlIdegf+6Tn5u1BmwnoCsYBTbXYflbOds9QEb87sMUzlussct7vvYZbd+dv?=
 =?us-ascii?Q?+ajaz60hBTiNxofyhLm/fWLc9UN2jhal8s3BstOHKCvO7fDMMds1DsKhJPk7?=
 =?us-ascii?Q?DrFbRFhR3GIZIuiouhDC6xwAT56OgQT87RgB2yVbdw05zEVliEG/FNrOSctm?=
 =?us-ascii?Q?rEc1KaelJGF8GJJKH1z2odmsCAFyVo1kC1L7IMMiElhq3BRsbPKEdDPcQc+w?=
 =?us-ascii?Q?TIqg15GfwD2qq+c1dH/+soUqr1pvdu/Df0cMrtY0IRB4plBV2ShLuYjCAflm?=
 =?us-ascii?Q?jij7h1pUp6LQI9KATk+or2aZ99aEh+7HyAeLn2GIR99scQm9gl0V5o5olwh0?=
 =?us-ascii?Q?ISD9Vqoc8gLFsBaVmsSYyjmpT49pdOIObblQ2AJ2p4G9zXGhd7jjDp9BrSCj?=
 =?us-ascii?Q?cGw7ioxEsk9LxiRBhaapVQXu+ib2lU0nmUzuACOTeo2aaAvc9ms5OxTJAFrz?=
 =?us-ascii?Q?EEvKzY3VBg43Nj92y89TGxfG9eTyb4jPm5afUetPXzQw05JIdOgh01GKrXBn?=
 =?us-ascii?Q?SxIW3PggBWFdu7ApDacps0Qh7UlIp5Wj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oS13sJOMwy1aQ1lGGVSpXvxjHWiFkOZNLGyKkgXABzR6msiv51gGv1Ht8vhw?=
 =?us-ascii?Q?qlROGBrKSNLZ60FgMwiaORDMGEpX2QJNIm6MUB6dN+/sqXqv+Rgclctq0aNE?=
 =?us-ascii?Q?jZsq+CeYc3m7RYQmkIdH1KTfwTIUumqCBJyV9oHXcdkJVUP74SLtoo6DEAYA?=
 =?us-ascii?Q?FWM+agIZOMoFZXnIDdRVf+Le6AR/gc19Ke6qq9Wyggm/5oF2iJpBtEke0ucC?=
 =?us-ascii?Q?YJ40w6TH9Cwl/ESU61tyf/yp5hB8UnRfJHlmuWPQ8a26s5ebvHXMBjzFZe+3?=
 =?us-ascii?Q?9HoYPg2TJ5xJzjTnyi/qohAm/ZdbEUZOhrPqK7wYQKiSb+w8IZPrzTTuiyvc?=
 =?us-ascii?Q?ORiNUSycljzxYLbSJlBOlq6/OSghhM5nruzg0zsNAIp4BI46xCeDbq5hiOaI?=
 =?us-ascii?Q?hHPzfdz6PPb3NF8C3AaPfsbakrxsHpZcMrRbOOOjmKJPNGqrOmOlyz3MdiEY?=
 =?us-ascii?Q?jmS2j2MfZqNnff2mWnA8rWkd5pygbaDhVwF/d0L6327AxEWvj2+l6n7Ls3DW?=
 =?us-ascii?Q?c69syN1ZEqSyf+3Cnch2Z8RKGvxsKpAIp4NyNAnEgq187D8+k4pbBGpCd+1h?=
 =?us-ascii?Q?JlvUUz+qjDgryAJBcFCBINAOQ+MBVbLGRZsNqHuztEF1f8GVKd4z8HQw9B5V?=
 =?us-ascii?Q?yTuzoT+g88RGnrJL3ZkZmgzjl2gy5cxa0nnyzRSqs9TZISmQ5EDnpsHJF5F4?=
 =?us-ascii?Q?3uS43qgR51/9F+LuZ3DsK5aGFn2eeWDDdZIJsb5CURm5Ew4c9XBwj1OUnN1P?=
 =?us-ascii?Q?70WxsjQT7Zk7yLaqw8r8+CDo8+C//Kb6bz8V9BputUujknM6miVS6AQCb9bC?=
 =?us-ascii?Q?1SEUHv2M+nnvHfAyZKJbDUYjs4LnnSxeNXdhpxLCCEJXR3nsZlz/FkCKTBHA?=
 =?us-ascii?Q?8xbqmVgKB/F4rZPWe+YMcM85dr4PNxabRFkLcPvi0kik9M2gVNDQ4uji83Cx?=
 =?us-ascii?Q?hCSi05t5DSl0yynYuiE+WVd3veLO9UhNRKKkcIAHcyu9dePsUqLmk0JRm2Fr?=
 =?us-ascii?Q?/F2zAG2pmGW4u6Dpm8dqlryLXuAVS2gg0/aYVtzJSQn6pnpdZgTjE+gb3Mv/?=
 =?us-ascii?Q?wjBt/dt/uj9E71Qp/FvAUJzUrgA/aq87qkh4/cqa2u2fhpoaYHyms/WngDC4?=
 =?us-ascii?Q?/X8lLd/PFz6H2TKwkCM7ND4U06apJAwstNaQxCbGOzi6SuH9NwifCHsTxEHT?=
 =?us-ascii?Q?+e+kkWfEOJlCQPk1jQkEjtwmKZQHYDBZ8vOIygNGy9zYQDs8M15P2iaY4hc/?=
 =?us-ascii?Q?Nap/rQQrQf8gd6cqi/71nyqstZWtBzvKnnBJ7yJuZPJWyLrBDJZgjBF8LUHk?=
 =?us-ascii?Q?ER7yHvCkAeIt+CAD67xjRx488ZyWw06+tLQVcHFFC+yJEij18ygJfsxyKOp5?=
 =?us-ascii?Q?U6MhRlkj9YZkc1/fZoeVMZZVePdD+UIvdSNRS9OGZfOiuLc/FteqzHyItVwc?=
 =?us-ascii?Q?hoPpV8FkUE/6Sa4t6pJVOCSRMeycJJ98UGQuIJEcucf09VHNUZ2j4E8ZVppV?=
 =?us-ascii?Q?BGK8FvchJDM1rhO+IJisMzODD/gYYTo81H8A6aHwA6ZuQlcdrWzVv8keN383?=
 =?us-ascii?Q?6sLePKCalJLZv9ZDelHpCegoEOn/qLleoqeiBW1P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf992644-7acf-4d97-4af6-08de170a714f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 16:44:35.3627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjpWHOrXyYJX2wxeXIiYxlYAWnlcDyn78Vhk4xe9wd+EZ+JCGQ//yfwwpIxJMSnMNZgxb3tknU1aIz391K5OOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9685

On Wed, Oct 29, 2025 at 03:51:18PM +0000, Simon Horman wrote:
> On Tue, Oct 28, 2025 at 08:47:17AM +0200, Tariq Toukan wrote:
> > From: Dragos Tatulea <dtatulea@nvidia.com>
> > 
> > HW-GRO is broken on mlx5 for 64K page sizes. The patch in the fixes tag
> > didn't take into account larger page sizes when doing an align down
> > of max_ksm_entries. For 64K page size, max_ksm_entries is 0 which will skip
> > mapping header pages via WQE UMR. This breaks header-data split
> > and will result in the following syndrome:
> > 
> > mlx5_core 0000:00:08.0 eth2: Error cqe on cqn 0x4c9, ci 0x0, qn 0x1133, opcode 0xe, syndrome 0x4, vendor syndrome 0x32
> > 00000000: 00 00 00 00 04 4a 00 00 00 00 00 00 20 00 93 32
> > 00000010: 55 00 00 00 fb cc 00 00 00 00 00 00 07 18 00 00
> > 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 4a
> > 00000030: 00 00 3b c7 93 01 32 04 00 00 00 00 00 00 bf e0
> > mlx5_core 0000:00:08.0 eth2: ERR CQE on RQ: 0x1133
> > 
> > Furthermore, the function that fills in WQE UMRs for the headers
> > (mlx5e_build_shampo_hd_umr()) only supports mapping page sizes that
> > fit in a single UMR WQE.
> > 
> > This patch goes back to the old non-aligned max_ksm_entries value and it
> > changes mlx5e_build_shampo_hd_umr() to support mapping a large page over
> > multiple UMR WQEs.
> > 
> > This means that mlx5e_build_shampo_hd_umr() can now leave a page only
> > partially mapped. The caller, mlx5e_build_shampo_hd_umr(), ensures that
> 
> It's not particularly important, but I think the caller is
> mlx5e_alloc_rx_hd_mpwqe().
>
Right. Sorry. Will fix it.

> > there are enough UMR WQEs to cover complete pages by working on
> > ksm_entries that are multiples of MLX5E_SHAMPO_WQ_HEADER_PER_PAGE.
> > 
> > Fixes: 8a0ee54027b1 ("net/mlx5e: SHAMPO, Simplify UMR allocation for headers")
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> > ---
> >  .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 34 +++++++++----------
> >  1 file changed, 16 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > index 1c79adc51a04..77f7a1ca091d 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > @@ -679,25 +679,24 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
> >  	umr_wqe = mlx5_wq_cyc_get_wqe(&sq->wq, pi);
> >  	build_ksm_umr(sq, umr_wqe, shampo->mkey_be, index, ksm_entries);
> >  
> > -	WARN_ON_ONCE(ksm_entries & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1));
> > -	while (i < ksm_entries) {
> > -		struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
> > +	for ( ; i < ksm_entries; i++, index++) {
> 
> Also, if you have to respin for some reason, I would move the
> initialisation of i to 0 from it's declaration to the for loop.
> 
> ...
If Tariq respins, I will change it.

Thanks,
Dragos

