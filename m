Return-Path: <linux-rdma+bounces-16870-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6E06F4ofj2kwJQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16870-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 13:56:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ABF1362B1
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 13:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C5223016EE4
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 12:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C04835F8C3;
	Fri, 13 Feb 2026 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rza8jW12"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01AD35F8A4
	for <linux-rdma@vger.kernel.org>; Fri, 13 Feb 2026 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770987398; cv=fail; b=hfP0RRJ4eZUHvZm4dCZq3v+IU+UVkatkcNcMJpcQW2tmBZUyy1pHfr49H9csSf2g0YFFPtpyff7oXAJhLOfUMuRo8mM9qEc1g5IzJ0Wh+C/Tw86C+IX1zeViO5/VfE62H9vFRygdJ98gmUuU/IBbXJJA+ihq81UAFMxEo1/yn5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770987398; c=relaxed/simple;
	bh=A3s3g09O84BtLMOoACp3VmzbAGj/yfoWpVtj6R6qBJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c8huvHbgYykGiEw8E4LAo56tHYl3nOxQYcHN2HLqLhim9nWrctGb2i4oQcfvHLssD4w6KLCW5CZvt1IVvTcmCIXyWjrVo+xCEaSh/izVv+1ajGMkcC7EILdOYA+p7uhgg6dT5MuPf5FyyWZT0IBtPYSvaUhHgQ3IrJYMziTrNGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rza8jW12; arc=fail smtp.client-ip=52.101.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOHZ8viUaUC0rfXqcJCw1Dd8uyCD7iTOuvB3vGCyt949VpFNFnCq/OG1yvML3tlsFyLfDziJkSr7yupqUp5wgHfLwy248ssOjXxSOIe7KG2c8X4LoJDyeS8Z0+8KnfJGZwKFo0g45RzWpujOc2aZ1yGAtmr7u/tQroWalv3Dnh7BiFk3o/ItbWpytIT7FxrrKkMMU6YdQOQA1Tc5lFfo35VvrLsKt/JaC717mH+1/U0ZWYWcX0a8XVoqaWqqMAuBU7HxjC8XjCWGYYx96ynvLBIrBjHIFWELVgxffxghGGl0U7+7pLRxog+lI30lxi5hzEb7afd09GCewmQ0JsPGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPJSCjozEh1l4/PVhy+d9on6xqGwYGGRSUpfABNEO2E=;
 b=HtcZ9AHlvi9w6xtwXnLhs40svvcVbbf7002zOALnrncsOEbYiG/SiFsO6edi3XxjcWGitPDcPp32U2hpuhAFMZEdGjCbqKgHT7xdhxoL+XbdTMOGIuRH4Za/6w6kTjgTzz3S6GKI0hONb3qcA9n6+q1dSFCBSsMnVsdnbfiZUKtvIiWh6SYLSf+UVCqqbHaV13v8ies2PGltwPxe8KpCwvb7AzqLEw6COIbXJaxefJ+TOlEBZ0V8I4fUlvcBhWQYqc1xiFyhF5iwXLWfam8+Ne+TUpLsRuxTWjVCDQS06zeLUct5/lRGQt5oovteUeGFsMQBnKsXkBOvH5SHLNH51A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPJSCjozEh1l4/PVhy+d9on6xqGwYGGRSUpfABNEO2E=;
 b=Rza8jW12G7nb760x9QiPSMRsQL8N4bJZ0A7PQU7T6UpYYBLJleELYT0DI6fgGVrEeCFUHOcS5gS/kMeJfziS7JgqsgH0xvALVr4lJsVnXmy9PFHB1bi66kzdfB3DLiYPMvpFaQSLpLQ77K35h/MSQYOHyfmFUiK5EI87wGFBMLsfRN0fyzOd9Iqe/GVJ6Xzww5adQY8LqH+RkIkA7LuDfdZV9NmY/ZEkN+bI7cJJoqmpYEBM8r/64CDjGYj2K955PH6m0TyCt+7CiFJnoIuOP3piPUtqMF5yBGK1a2p7e96+dLt5T5KygQAVorOA8ibc1MqObTMYBtHD09wloE90Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB7011.namprd12.prod.outlook.com (2603:10b6:510:21c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 12:56:33 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.013; Fri, 13 Feb 2026
 12:56:33 +0000
Date: Fri, 13 Feb 2026 08:56:32 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 04/10] RDMA: Add ib_is_udata_in_empty()
Message-ID: <20260213125632.GE1218606@nvidia.com>
References: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <4-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <20260213102240.GK12887@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213102240.GK12887@unreal>
X-ClientProxiedBy: BLAPR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:36e::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: e17d8405-88d6-4ae8-d41d-08de6aff5065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AGHd4IjAhHZ7TGjJm9OWUT/qfRLbv6VlOUiaXrh/sXDk8LjgO3uG8LOzerJY?=
 =?us-ascii?Q?m2XT//tIZBL3xMHhqQQhoACz4A/xlZdRTaLRWJBpT1GV/79DWdY93klDDdco?=
 =?us-ascii?Q?CTMY51RE7yVWzcA1SmA8Dd7cUzGyygJt+dOF2mAj0vKiHP0JKtQ1bL4qFHb9?=
 =?us-ascii?Q?nqdS2w7r0pSahur2x5ix9S3IiIYow7z5Ldh3Z6q2p5AzjEBAoPcDTyfEYZGA?=
 =?us-ascii?Q?x6KcvX+jZz4GpKaXncJpe0GrrdvZjvYByKi1BOC3EesWwdKNG6u57pWsCHOQ?=
 =?us-ascii?Q?A1WnXfUhAPSJXK07RZ0PPuw6cs1Y1qt2mqFhswx0YZtU1TSoznIuDed5tPRc?=
 =?us-ascii?Q?kKTrMsUDP9FB+1dPmnzJAF0MjzymlBvMWamKbEErBQFLQWu/lRJP2Hsd3B+R?=
 =?us-ascii?Q?k18l/hKJauMwRq3tZuUWj+6fEsNWDrOmRq7GDHQICe/qzaXb89tmhQCvWYV/?=
 =?us-ascii?Q?6QW+ohSLNYKSEiZ02E2KLAGf4XS0RkfoQmjy8fiICXTWAuLHzE+Llc2vKsWQ?=
 =?us-ascii?Q?tBalciUkPziViKwdvZztOlhvvJpipt/qwII7TZt+Y6cSl8BuRgr/2iv6NlhZ?=
 =?us-ascii?Q?69kwYBnQUy7Iu4FbvW9S4VS6sh6rhuIsWuJirKt7YOT33KIxldon7nLoiIW3?=
 =?us-ascii?Q?XePDq7SSpH22rAAR4ykByfGs/jj2qR++e8Y9FhZn1qrNIrHIKbyBztlMQK91?=
 =?us-ascii?Q?BqcvCoWY/Xw0to5gstrLxmAJHFL4YNdAx792siWZ4r9Hf5R9DxDfEz4hJOXp?=
 =?us-ascii?Q?yD0BOXuz7vczfhfqg0HnfjY5ZpPsUINUsdGmW/8M0prgL4MoqzN9F9YdvTBq?=
 =?us-ascii?Q?2eIyCSsND1hOsIK+KkULt7DrTs+UsaTwaM+Rk1he06P75QZSEMYNghHW6eIF?=
 =?us-ascii?Q?D7j91racJGiccLyiWQTkJDib8FsUEfxVxIqKSJYBq5z0TYGOA6a5W6NZOEAu?=
 =?us-ascii?Q?GqVVkKfNLEDX23yeqkN2iCt89N1tszvGNQEAeBiVCj15GQnB1RSFnLdaR9cd?=
 =?us-ascii?Q?z1P8Pqe0vOIBctGeL24JSBj9vVjfkWFzTgheyYMtrWHXPpMJEJnmyrX9NfII?=
 =?us-ascii?Q?Dmqvu8gERBO+TW+bTxHNi2cpjGq/HrOFe4MgjCbrSBTzepICqE/hXmGJVhmr?=
 =?us-ascii?Q?0wNLLCJv7Kdmzj4Kp1BiW1zpOSC9p2vC12IuI56Wi7VKrPGA85CqQF79YOV2?=
 =?us-ascii?Q?XExsbrtl1BR7vrmrtEjkii2adquDXTHDuhTXYCCKZ1wuSQ4E8nICaewgrx4v?=
 =?us-ascii?Q?ldt4eKlrpjW1yQ1aLiICPbS3NihfmIuVOyG3LVtF9d9Kceh0vwyf+X7JE7ka?=
 =?us-ascii?Q?4QbbZJfxrbZc4PC4WYWbFw72vjF44Kld6o/dGmH1BOvL+LA2khrqA7MZPgq+?=
 =?us-ascii?Q?AUGammagmeI2//nGdygNpfmr9KYNYCssiRFpVmiK9uZQyeUYhVxq5bHSrS9g?=
 =?us-ascii?Q?wY8mrlvTFe5ylnkoTUkAmBZiwAty2MM+xULGJGLB5m77UgykH2CS9cAjQ++X?=
 =?us-ascii?Q?qOIjJbFVm1AM73v9MFeazqz0BLDekh9wER8mAokMOOy8GnmdBwaQr7gWDD/C?=
 =?us-ascii?Q?oKQgSzF0dQ8xdOAYdCY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mYnzY4I9DHT7MhVa87TlTMMir2eyicPupnSepTLcFz7+yRGtcAcZR7cm4+2v?=
 =?us-ascii?Q?S6CT4jhQNNCHfvKa05qOJmEFoSGMSWKb7jTPLt4N1Lb5FYAl/xjteiZ5VHo7?=
 =?us-ascii?Q?z1rJSbrkTY4TQmir3n9utfqoEyaXESXXY0r35cCMSDsdV4PlBlgRN4ipBD83?=
 =?us-ascii?Q?Bm+73kEalTiTdLtmGlCfz2vDrqvTL2UJAISI8fhr0lVcwe3H0nncCuX8KMpE?=
 =?us-ascii?Q?lQDbUmEehk9jrCSeP5Av9Xg9AJxFHXven63JlRaZptnWupt31F8GdsmcyeZH?=
 =?us-ascii?Q?fePFARIQWYxinFpFzKYGKwBGkXkdDLPtEPbZ5ZieAY6PKmb31RZv/o+3Litu?=
 =?us-ascii?Q?dx0tVvR0klNMvA4eek5Wh0z9bi7SDspoppDZ0KpPWQa+3vJpINq/Co78XMPt?=
 =?us-ascii?Q?mnJnthwN+R2cJcxYYPCzvKFDmYdxmgFPtBQ4QXmH4Lo+nkiIRV4j8cNdPSVX?=
 =?us-ascii?Q?EqLiwhsgGe4bCr0Jz7+klADyXDnRuIxtBWZ1KxoefJ3S9rZ8abSt+l126yFA?=
 =?us-ascii?Q?EkUl9KQo8DKN9sTWnoNjwVV1lyZV36EdqfnnhNmRLA+9ekAmlqnzdL9GBFrB?=
 =?us-ascii?Q?tDt0GBQ7gkE8bge1XSaIhq1HF0IxJsflfxPCuEEonBPnWiPtuhAE5x7N/meF?=
 =?us-ascii?Q?jIaTwl4baUg7d5I8W/6ER991fLWzkHpocFe01o8sIBV3ajflcUXbn89sDDA+?=
 =?us-ascii?Q?3Rj8eW/s1tPJYO+66qtN057CcDUuaP01Xgy7R8wVnZlfmWgpGzGgfY28jmLy?=
 =?us-ascii?Q?QGKhlDLoJtUD1lAXfarkdy8ohT5L8TIVjdVGDfGTkkFiwUm3cwO/VY40xZLJ?=
 =?us-ascii?Q?2xQbP5GreFIe+Kz6yFVn8gV5oViBUM303KimbwzLyk3SCON1t1MtVzb36yiH?=
 =?us-ascii?Q?8Di4q8rCPiW9jDU896Q5AoGkLsfZx/Brgfke+Q68wjjwqMPeQeytuhsMNPv8?=
 =?us-ascii?Q?oTeyyuQk/6hf1/bahjgSU0xQDhPfVLzV/xyRarPwDaAzfQZ/chF2UOrjPvej?=
 =?us-ascii?Q?qSKPTwiDiOARgmAoiHUmqDgYYKYa69mdqOTzzlc8nYInspSOLAd8njaAKFla?=
 =?us-ascii?Q?3Xps3e1VcmDIhnJgYReuA4Ve71uXu7/cnx++CVjtZATfzyyubpkN5bKs6Rjd?=
 =?us-ascii?Q?QXpPB+A8RrxRt4dezJd3ZKkEr0XDMhO23iCk9aKWJYzm9d+j4PK+bR4fDnF6?=
 =?us-ascii?Q?6GrJgfJU46u/9r5Xji/exr73EL0vJXnlQURJniyXul0wwPcwxoRehbpIxgCl?=
 =?us-ascii?Q?WWVVJv3JubjlJpltk9jNxv5vF+C8n1yv9Cp3Lw9L9oc1KlzhJ9YBbpsFJ6lF?=
 =?us-ascii?Q?lLhmK4DmGX4QYtimMprdUC5Vhfkvg1mYunUSnQ+5HYRfF12UxCMZ9aGl0jtK?=
 =?us-ascii?Q?uYcabLmss/d0z2hVhAmr2WT94XRRmvzRD5JZJybfLjjRDF6uzZBdk8RJ1JRx?=
 =?us-ascii?Q?X/Og8RF3Tm2CnRhB1WlPTD3zhl3ksBLlcJ4XOLN24fEQvNVAVqN2kxDGmkgt?=
 =?us-ascii?Q?fTYqida+OqpbA8lfW3cTc49wvVJPsKVPgmO6IHG3ImP6jFb0Yp6EwWgdBp2R?=
 =?us-ascii?Q?pEgP7sRwNoquVvEnqeH9DZDYlfvw0p1wzcSBP0vGhes3FYeVpX0q6dbG0dyM?=
 =?us-ascii?Q?fL04Gis/YQfU3SdYbD+qNOGSZs1hOWWQRYScZVUTKovzpkSYsknZNXXGIxFc?=
 =?us-ascii?Q?HNYDrNvJzGmUD3+/wl/luzwcALltXY20g7hMKBDDoZ2qfx4FgjReRP7uHaoS?=
 =?us-ascii?Q?DXbU1eDNMw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17d8405-88d6-4ae8-d41d-08de6aff5065
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 12:56:33.2998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DD3upkJ9cE6Al0mS8ZFQCNI7CCYyOzF85M8X4XpUTeZIasxoN15dt6F1x5WtSxT6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7011
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16870-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: E4ABF1362B1
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 12:22:40PM +0200, Leon Romanovsky wrote:
> On Thu, Feb 05, 2026 at 09:45:38PM -0400, Jason Gunthorpe wrote:
> > If the driver doesn't yet support any request driver data it should check
> > that it is all zeroed. This is a common pattern, add a helper to do this.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  include/rdma/ib_verbs.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> > index c0dd82a77e7a13..973d9ec6875e63 100644
> > --- a/include/rdma/ib_verbs.h
> > +++ b/include/rdma/ib_verbs.h
> > @@ -3119,6 +3119,20 @@ static inline bool ib_is_udata_cleared(struct ib_udata *udata,
> >  	return ib_is_buffer_cleared(udata->inbuf + offset, len);
> >  }
> >  
> > +/**
> > + * ib_is_udata_in_empty - Check if the udata is empty
> > + * @udata: The system calls ib_udata struct
> > + *
> > + * This should be used if the driver does not currently define a driver data
> > + * struct.
> > + */
> > +static inline bool ib_is_udata_in_empty(struct ib_udata *udata)
> > +{
> > +	if (udata && udata->inlen != 0)
> > +		return ib_is_buffer_cleared(udata->inbuf, udata->inlen);
> 
> The number of existing callers of ib_is_buffer_cleared() and very
> similar ib_is_udata_cleared() check caused me to think that udata->inlen
> != 0 needs to be checked in ib_is_buffer_cleared().

There is probably something that could be slightly improved here, but
I'm going to leave it for another day.

It should also be using check_zeroed_user() not what it has there..

After my next series there are only two remaining callers of
ib_is_buffer_cleared() and two of ib_is_udata_cleared().

Jason

