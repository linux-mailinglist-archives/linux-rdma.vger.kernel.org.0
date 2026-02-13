Return-Path: <linux-rdma+bounces-16869-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NvCLakcj2lQJAEAu9opvQ
	(envelope-from <linux-rdma+bounces-16869-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 13:44:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3182B1361E6
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 13:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24874301AF53
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 12:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCB3354AE7;
	Fri, 13 Feb 2026 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UzPcl6FL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202B334EEE1
	for <linux-rdma@vger.kernel.org>; Fri, 13 Feb 2026 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770986644; cv=fail; b=KcutXH5CirWZZg+i5A9i2/TLGkIIKmZoJ4wNBPXbE28W2GHtCd9N4PJMtjxo+qes2+UET1uo5zyyuV16EQO/Wa8uD0YvbEJBEfufNr9aTgCLdC96PaJt9tLqGcJbTN4WQxJhD9xiNnNkXArpK6+WIe5z/8yubs0/0w1mLxE/IlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770986644; c=relaxed/simple;
	bh=3ov8CytI9HRhBv4ZVIl565kTgHSZNCUg24vdsuJrLHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FTgyulCaC/3PhaXlw9vmjaP9+pRu4WE7riOg1vv/ObFyFuicTaYi6xorbiH9NU5XbuegFhMUwbSa+gcaSiwqAbYmVogM+X7mk5BVPdOCq7sKeiaUCtmpsVxzVaookjjgUACg+ZiAwnFW88gk+XWQ/mAD9a14JtKUG0oIUCHfdks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UzPcl6FL; arc=fail smtp.client-ip=40.107.208.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kls8rP9tF+nG/TvdMuKyDcm6hrHINvDE7A3Jb8LJnc9DkNCFArW7UwmLE5CHYTOdUZiaA7rM6D1WV4uvC5OicywLH2geVUg740kIzXo8j+kVpgqm+KDvU/ilF3eJ2/xu0ibSi9totWt1UwI97AcdEYWQhiOGIr2J2YeIb17JUYdU1P/Cj74LLcqSuyz0fFGn0q7v+uNWtWrSDpbxYFlzeK6XhixIunPKnBngfGpQ55iZ0D1+ElJwZoePiuWq0rhyKFWBDTBioDQS6XU6v0Iql10uo+tbfKlwFf9SRAs81ndZlWnpjvLSItHlQXBYWiIPNRF3Gt4CNWuas6qC1kzbtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwVEkWPlm3bAnrhtN7W/RwtPXgQjcgasvQPsvEVAc5o=;
 b=o+ez4SwAXTROel+cE9RICUuCYUcUc5IlVeCbgQErN+cd8xhUQckaTQZLDA0uudlI3RaGFtFSEWYt7Rkfu6/cSeEA2/KXjeknK1hv4qYyDq/RCKAH5RVnLWYBp31fdwfVlkEAFBtqDMb4pZkQ7siPwGwbU47nYBCYgmykODhRuN7/S1KJ6DwD+0bOrehHwFo4brJ0pF8V6em/2/OJ6aBsig1cD+NmRO/8rt58F+j7jflwnaXUHTWVOhAnZLFplOdvmcSCrs7pAxXdiGEkUk/QEdYUu9qnGbcKt/C/I2PvQNzfxIU2MbRVtbUfNhzeqCGjxoAzXJAaFTLeU4mI0YEdSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwVEkWPlm3bAnrhtN7W/RwtPXgQjcgasvQPsvEVAc5o=;
 b=UzPcl6FL6IaPlIgpt7ouDKCd+++iW9tYUgfzGljmlHE2UO9B29Flh1rk9JmqOYRCVpbHLbCnWbP+azPaXenk1WmDrU15aLrRFRO3Z35WWZqn4E9ZyuR7V8jthDQGIMAP46N7wL5tlVc/yzGg/Ftt4pCQRwmzJ3v4zdct30sjGwtbPQyEaJrqxjA6uGxh2pHxumLxMW4/6uKZYmZTXnRGLxEt9zz2cPqjjgTCiRIiVfkhqwlTp8eAkzjN+eMd6odcXM3OcspZLiEORdiC2rPl2u0yJkNXU3nvXNqJxiXpg6ay54f1MY98hIwrGnObu2k974udEXbYbrBKd8NdIDHdiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BN3PR12MB9572.namprd12.prod.outlook.com (2603:10b6:408:2ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Fri, 13 Feb
 2026 12:44:00 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.013; Fri, 13 Feb 2026
 12:44:00 +0000
Date: Fri, 13 Feb 2026 08:43:59 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 03/10] RDMA: Add ib_respond_udata()
Message-ID: <20260213124359.GD1218606@nvidia.com>
References: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <3-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <20260213101053.GJ12887@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213101053.GJ12887@unreal>
X-ClientProxiedBy: MN2PR20CA0043.namprd20.prod.outlook.com
 (2603:10b6:208:235::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BN3PR12MB9572:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7b1b66-a027-48eb-b3ac-08de6afd8f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XFxJMhfqCv88UHyPO8LvOOrW5+3a3/9Zu4h6pInBs2OH1ic4iiScTu3otLr0?=
 =?us-ascii?Q?SKtDCrqfosTmJWYT95ocXXQiw9OAYdYlrN5fHoUzHfGGCRf+zcICHh73dq7U?=
 =?us-ascii?Q?8xFHsogRMvxEykIUld0xRx54ElC7kTwztQW1SQR5IP1Iys9StTo2tqohKFDM?=
 =?us-ascii?Q?U74+0R9+7ykDycyTDXIaV79Ozeo2cZ+uR7pIyvoD2zJbjl421jbfnlgUhlUF?=
 =?us-ascii?Q?9una2kJ86EBb588Db0XgGC3vjzZ681KAnvf87detpSAugAWCiDJLYucsTPVs?=
 =?us-ascii?Q?eW/IiTiPddW/7lW0L1nnsfuNLdTSYwf5rJ6wCT8f3xW7aMnWe1evLq5czPtS?=
 =?us-ascii?Q?gj3Mh4IEvv2KHEn/evbpETIvBAEhfyF1zjJvb2xUmtaPWK2O8yXkD275WHQW?=
 =?us-ascii?Q?U6QnQTEbLpj1gaB3vamimlDOaQ7Wg2jVqxcNidli2cSrXRPMagwO1TxGCKBY?=
 =?us-ascii?Q?55HbfRGrjR63SR/Mryv1oHgrNXj/18OpAAuzyD/Se2khF+GzsI3oqhFXBUGr?=
 =?us-ascii?Q?bc3W/w5RqqiosZI/OrbuvRNVIANwUuYfY4mQDcxZlwo6883MxzyTMAdL0fbM?=
 =?us-ascii?Q?SBkcLl6NCt7t7qnvvktMqXFlADOs7yjws/IOSlh8JEfhmXoeRsmPtTsvIyDg?=
 =?us-ascii?Q?HuKqa9FKZwWQfxaU+GBTTNvD7atccbczGfp5r1nkW1+I1P+6mnjSbpJM9gxR?=
 =?us-ascii?Q?W+Az7pefTdfbHh2+UVciPxQhloxmwyBrFwEJc+2sg4hwbFG55h0DTX1Fg/DX?=
 =?us-ascii?Q?0cvfbJseRdwb8GqRckWkh48Gh1L1qIUY0HoeA+AvSNxexqGfQt7W0gnOHU2D?=
 =?us-ascii?Q?crk12LZp3JTcvcgjhSOU9NY9zWL6OpZXcYKpmJQPAfzLJ4dRynVb9mqYiCik?=
 =?us-ascii?Q?2/kIXiDc2HOXxTGSCXIQt+FjoQPRVCq/LU0jSp8seuzctVI7A5GmR/DSW8yc?=
 =?us-ascii?Q?1PcmAbn8uYkj8Ql8MM9Nmm5gPChx86tGu8080NNJz6YkqP7XTg9itT8UzJyX?=
 =?us-ascii?Q?vIPr1rMps35sSB55HZi+4p2GoLqvdC2ILcC7hHveIAU6Fr9pYWpxtlwsi5Wb?=
 =?us-ascii?Q?IYZnmIfEEMwnsutQOYptOIW/WEs+gPUbsaJ/g0OOvAWaV4Mr27SKXcwGL5if?=
 =?us-ascii?Q?4sCRgWU/oKMFiqGAMgEWGkMp1+zl1nWpe8mABn4wANDSRGNidUtSqNW/IRnq?=
 =?us-ascii?Q?E0sxizuZSgdgLGUR7VZAuu7pxxbRQUsMkon4dBHCTJkJsUWKvG3y8VHuFMJZ?=
 =?us-ascii?Q?Gnodw6EbiGZROM7lfpZK+UlJl05+ilgFCcE9KSAyWIeww5Rk6BalATf5uEEp?=
 =?us-ascii?Q?h+h6cbUaq6YKTYGSXOlbEUH2TrQhEXWQeXNURxz0KjO+7ONgWoGOlD767JGI?=
 =?us-ascii?Q?TZ2Vrs2JllY/L/cg4JKXHtJqGXWdZSfhMznLrag9W2+KNwrsxxvBmpUIXMqo?=
 =?us-ascii?Q?ayGBhR74IxxB1K7kcmFZIAxI1JsFXkDP58X7T39UMDbtbHMsT4x48JHfJWVJ?=
 =?us-ascii?Q?KhBFqqZ/Jh94upjnBvh2OiPXpS3ZhstrhZsoMRwwTnmqDlvNfQUZxIXDzFrt?=
 =?us-ascii?Q?4C3Jj3XFKolUwult6+c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X1MixGD8Ny8xkjr25Xskg/lz5+sBn+/uWWXaxVyabwRGluA20dR1oSsC/rn9?=
 =?us-ascii?Q?Lie4gW1TS90YzoWgS8meS1cg9YDHpvTY2Fdr5GRMaTyxepLH6Aujj4+Q+Ruv?=
 =?us-ascii?Q?/vO1HKvJvsCS6+JiHUOmuyXWed43qfT74uwdxM6GuDqLzbmmxCwTABNrxFJT?=
 =?us-ascii?Q?U0eiov2mg7u4ZmtPBdKqTSIO0S97G5/CE64q/s435k981bESMIV86MYSNPZn?=
 =?us-ascii?Q?XRHY80UIDCLIEMsy0DdGmywVMExL9i0QCQuLJWOGI1BMiSEA6J9y/lf0hros?=
 =?us-ascii?Q?o8YUTN/BbaUX3rZxU6YfC+i/Ti3H8ReV50yhYuf3MWzZkBGkQYzcod4oA6fW?=
 =?us-ascii?Q?1yCXAn+iXFb2F/xxIVnCqFAa77yA7PC0T4Y/PDFKHe41+OzysItpL9jUVkVx?=
 =?us-ascii?Q?UbcI43GNKXlhe5fWu7p7ZvwPLNW9mR1g3nLy8yYFwrk0PCX6wepuJaLNI4HL?=
 =?us-ascii?Q?Ikk2n2SlYaWCeNCQ8XCMyfelWFO4F/7TXihgoB+zuPIwsS1uWHnlx9acUDqJ?=
 =?us-ascii?Q?hkjdOuDkpSdIXZP56+viLc7MwIFqxwDoUfOkdqoU+JVQ6orYnZR/NvIj/Vhn?=
 =?us-ascii?Q?JJhQxR8oTqA6UVoiuiBKBDEz4JeIzKJAeSy84lLvDI0XLWG40h9eiebv5ZB1?=
 =?us-ascii?Q?9ZDSaYsdmb2ewfXE7pmS+aq+Xk2/c3HTQdOmAmb58+TcaPdVwlriEM9atU3n?=
 =?us-ascii?Q?4/VVSjK2QquOXhPtKUHmMR7PYd0EEy1c9vpcRvWQhzDXED1qzWEDumQJZsUd?=
 =?us-ascii?Q?f0TYzFHlFxC8sREkFWJhzkIN/RfwKJeNyrowCH8o/Hu8n0Jrh9uslnaAWW/q?=
 =?us-ascii?Q?dUYx8xaLQ3eGxItz+rjL86DnByrhjQ0J6myXMahLAxOf3TPMK6kgMFcXgmho?=
 =?us-ascii?Q?uE0+RjsDvWviO2y9be9qiSuriw9oKZn0hW6uMnvFvHov8BSJzX+oG/6v6bG+?=
 =?us-ascii?Q?lA9oAtNfrqkrR7JLfDQCwiQw+W71sVI4/D8HO0/cg03EEycijU6LxCEVtAe8?=
 =?us-ascii?Q?MhF4zVesiAOiz4jN2n+zKBr5XxeTxNAEymZEffw0sFX6ZPBtQwjO3VVjQxjN?=
 =?us-ascii?Q?kaqZrI3tm0WGl9iKGNvifwcsRsaADmDFZ9PJsSyXDKp7rkvRnOhnnEdEl6qE?=
 =?us-ascii?Q?BM+cs7g1ptCQbeC9JjSRuoIPEXreF2UVaiC2TVaWtIgqZBl6XEKeuhcuSM+C?=
 =?us-ascii?Q?tNI+qrZVYNpTJCJoKCzoic+Y9kLFSSUNeVfdLv/roJUOfDt3PzcJE9fsv95B?=
 =?us-ascii?Q?Nm/pB2VNcxtvuBvNA24jkIKtL6eByGBtcgFAPUnpr5sZ/8M/7103RJzy34hs?=
 =?us-ascii?Q?1HN1z0AWF2XtFoW2f9/c90lfik4Wu1Jzi8y1B0VBgNvgoXbMtCTo9cxYfKd4?=
 =?us-ascii?Q?Mb0jQ4/fMI+5YXJX7RqU1a7QXCGZuv0BWqkTBaafDXaWtX+chq+Qg8HBlbPS?=
 =?us-ascii?Q?d/OQSwviVH65GtsRK1qWFA58rF3OWmPZQIQN3QTUJH/Jaa4mCTddbv10rIXL?=
 =?us-ascii?Q?A268Sec3fwB6oY3vxNuiKGDU/0lt24OKGfD+eQ8h0BRHJ01626QNE0DQWeDI?=
 =?us-ascii?Q?aAaSPuZeg23ROt2jtQTjEuoULNu+wy58DBnDWiEAs0c5nFzVHkbYnsDufeYa?=
 =?us-ascii?Q?pmqyMKabJrltCZOf2TxpSN1w2tz1l34Q5ZTQKrjdfItg1thYGF5w4tuezuPK?=
 =?us-ascii?Q?qOb/V8TGZRgMcRhi48m8tX+LZzhbxTCYcuriBdMHELEN4IgXpn1xPCoh7ArY?=
 =?us-ascii?Q?pm8pz5LXJQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7b1b66-a027-48eb-b3ac-08de6afd8f80
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 12:44:00.1535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S53PZxIGAr/OFLTJToGXRcN8DReEpX/sTyRTIKyX6Szc2Lh9pjZ15i7NNRMD2M6/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9572
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16869-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3182B1361E6
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 12:10:53PM +0200, Leon Romanovsky wrote:
> > @@ -3177,6 +3177,38 @@ static inline int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
> >  		ret;                                                          \
> >  	})
> >  
> > +static inline int _ib_respond_udata(struct ib_udata *udata, const void *src,
> > +				   size_t len)
> > +{
> > +	size_t copy_len;
> > +
> > +	copy_len = min(len, udata->outlen);
> 
> Don't you need to check that udata->outlen is larger than zero?

As far as I can tell 0 works fine with copy_to_user()

Jason

