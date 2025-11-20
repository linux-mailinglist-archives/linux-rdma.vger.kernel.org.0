Return-Path: <linux-rdma+bounces-14663-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6262CC76180
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 20:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 5DCA2241F9
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 19:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5EB2F49E3;
	Thu, 20 Nov 2025 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WKJylXLn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32E328A1F1;
	Thu, 20 Nov 2025 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667313; cv=fail; b=kClkUe7i8vUnF2s36kEz7ZCfG8ClkMwDOCNy7utWzinSo4AsIt3FifQyYPvgDHUbPzjTo0QKJCfdpAqreUrwCqPJAn4iz7KmbCtJvNX4I/vJUmsTyCx92+otsaN9E4wJzn8RbTzjCyC9IsU98rOtiX0INc951PkQSdCK7z9Nfxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667313; c=relaxed/simple;
	bh=fxv4UFQxaya8eED5qf/5QYkFnCBoGrWwelOQVN2mCig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eYctmp2r+Fv23xR/1tVKQshRvJrexQk/3efhfyu0hcs/EcC2GK6APY+CB+XLjXTa64aWjl0KD2KYm+RsdBmyDqWHITB6RER5qBEubAGnsmla0nY7+EavRIjT6aaXYiOX7yQ/nEqiuHLGwuioY4A8jLQP8pZ8KpreHwayLsXqv8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WKJylXLn; arc=fail smtp.client-ip=52.101.62.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAckgwmKUavnbpd9Ov4Nlf/9doM07qPfwL/f+ykXeetdCsoDY6/kQOSKFcFDt7xcl9AY/BO9dYGoXlyS6xL8A9Kq40cYAWjldrklS3Vx8jVxI5nyVKt/NlxHPrikAFjSyi5gEt1uzSyBj+93EVdv4oXi1gyc54WrtCEkvx5tg2W5bnWbbibhEfeGE7k1dDQWexgYixyFY6KG3hcYC+LbbHPj8fTfJVuGNytyJqutMylnLfmih53/tyFUlRQwSxVUF8P3P6mzOCwePEIVtu+YIFAiIoYXpIWqx36S+Nbk9tJkA6gIBzrhDe1sgYM0e+EdBFWLoftv7BTFIxYY3YejCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoSFg/+cdhWL8R6PU/GjVinOgjIqpvV94TFUTOBeUqQ=;
 b=KMb4wYA49c1wKHCFHVNTOu6lKCkxf/ecNaJKlKpsCP2mkES5w+ztvh641UF5qfMnYaUT496mA0Ppp0kWMmktl4/WpTw9vFrJ+mYTYaa0UtV/f8GU2GIksloSdoxl6K1uTxc49SX6Tn1rhHrn0nt6qX70Ath5XexgON6zxBiYLaoqoXHFeCb7zp8iXdFbGR5LfJ44E4PYB5s8YIeVds4IbKHFhMT3KB4bHa8Yi5wOmVTyjPSduP9pBZD99myA4lD5Z491nT1s7lr8qotcJP2C+f7bTnL8re8LE217N5fpQMcXkOSpNOBOeYmaJV8HkmJxhhpTSG0HWZaSifcvxMqMTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoSFg/+cdhWL8R6PU/GjVinOgjIqpvV94TFUTOBeUqQ=;
 b=WKJylXLnj0axWrtrNdE8RQyW0/q9oI2BH+M6gSFviXK7ci6+GhXCMgAYjikD8Tuhv9oN8f9Fsj8zvfJZPP4qIRkoX3TQ7p6gjy+ekHUmvb8yO3raB+yBYeaHzk3GkPnbyobucUpWswSVET+cb2CUcnK87hop+2vhHwKxE1TjEdhdQNO9x7nfr+DhkiDjJzUDbY9xZiv1Bb92MSwTQFMr+zS+BTR+bXnnQu3HboAryvf7m1Y/J/PQHidXikGqlZxtEcZCm4nPW+mlNIELf4tpsZwOniVyU1I/6uVnKpA8dL8ijtMToEqHsAy/fprJyjdP9jf5OW1TxVfuzPDz514mMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 19:35:07 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 19:35:07 +0000
Date: Thu, 20 Nov 2025 15:35:06 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Benvenuti <benve@cisco.com>,
	Heiko Stuebner <heiko@sntech.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>, Leon Romanovsky <leon@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
	"linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Chen-Yu Tsai <wens@csie.org>, Will Deacon <will@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v2 2/3] iommu/amd: Don't call report_iommu_fault()
Message-ID: <20251120193506.GE153257@nvidia.com>
References: <0-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
 <2-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
 <BN9PR11MB5276EFE7D236FF918A79263C8CC9A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20251118185831.GQ10864@nvidia.com>
 <BN9PR11MB5276858062B57F944A7EBE778CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276858062B57F944A7EBE778CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN0PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:208:52d::20) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|PH8PR12MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: baa35911-d47a-4707-c126-08de286be935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nWfVVmjPBQnhtbB6B/8UD/dRsRV1Q7lvt30NGz+jMpzGT3OUxd4gJQns+FR3?=
 =?us-ascii?Q?TWms/7U44Dce27HbG7aZ7MXDcWVxS9CwSBZ7OwfcedcyBzfoHIKVDc5mCOuS?=
 =?us-ascii?Q?ZxpKZ1g9kOyWMh8tnBJql5+Rgh+e2IO9g/ROn+tXSZONmBy3Aci90HoEvF0j?=
 =?us-ascii?Q?4HAXIpueaY/+MCqHffNxykAMZwpcYRLcDIkvjCpzeYHS09rn3k/EY2Wz9nYm?=
 =?us-ascii?Q?PlIxYQyQyQKFwmFHJDedqsiqJbqGx7+BuhOlQu4VsQjWlVv72y/a3RS1cxNd?=
 =?us-ascii?Q?Q+WAusCQY5rYcjhyQMIL7s/9Y0z31C2a6k9zqDNDqmtTh9se/WlwhRJlSNFj?=
 =?us-ascii?Q?8vTb/m9/vFzzaOXlRiZyXKmn0pDGRx9jsZv04CfNosRZ+wBQYSjwSHbRVks7?=
 =?us-ascii?Q?js90sgdBtX1Jh4lS5yWdog53BodY6+IXNBitZXfpnTlsCWvnz8Tf55p6P2JE?=
 =?us-ascii?Q?+2t9qiqet2iwDrZNJ1/LSOhQQKwl0BY4DPEmp+uLPSzZ3PkrKDDh5NhzeKzo?=
 =?us-ascii?Q?vaJFn4yK43avacQBjLbyef4cKhG/TO1mmba0XP93Vvmb0E3SzayKMxamZ7Uv?=
 =?us-ascii?Q?jgkL9IPHzLILIxVwgNQTJpGL0W0FYX4uTMdOOPLLKp4XPx2l2orMGonqmB0h?=
 =?us-ascii?Q?wsU8Zx4ayhtjFk557lXovFiu3jz8A3D6jGhgToTUE9PahbYeaFXWyJhZRm60?=
 =?us-ascii?Q?rvpDev2/e6KhwmjVmq9aZyavgfxCeAeKtgnDzz+5sPdPqL10oaDRPvAF/ras?=
 =?us-ascii?Q?CAsRJS4+dGxW6aEv/tGzD/7VGMW223m4lew8cJQUIYFLbpO2ePCP1NDJp1fT?=
 =?us-ascii?Q?ykDo6xNwLFGoyazd63mTIYV1MCOzzGhV0ZFL74c6YpwnfuzyMWi+LjtY18vy?=
 =?us-ascii?Q?aQOPqPOgkdpJfTusKQ7H31DVOTEBgGVZnr0LpMS5jYnl2/2vg9+OPEfDAr5p?=
 =?us-ascii?Q?PWJ1Rq9UzKH6/DIX3HiW5Oqj2X523CfcUJcHJJCtD9kyclq42j5WHVUXKaay?=
 =?us-ascii?Q?zzDjFH137mpkRVnmHoMmNAsi6QqDasAt7HTYtYnuys9IAVAGFQb5XSxr4v1s?=
 =?us-ascii?Q?8JqsrMzlwzrMBkcSsbuZ7gsFGi3ofDQ3ZvOJe/qmoQnM+pH047kBlERugbdB?=
 =?us-ascii?Q?Wc2xr31JvgZTL8SGnbueoI7Rkl4hS+8uRMp0i3ESxcgx157Z18UKhBz1YVDt?=
 =?us-ascii?Q?LvZJR2AFnjNZ3luni+GhlQnS322Nrle2+aKAjA7QRQSX4fO3Nw3Eo9isxygE?=
 =?us-ascii?Q?u0el4x9aPz9P61n+i8bPvMrTSdijWzbK2M26foV0BlLASrPVx5jTZE0/38DA?=
 =?us-ascii?Q?VRyGGJJ2OL+cyWOw8mKdC5tcAT/trztqa/2INJbyX9yKlYvqsEzFJdVqgPy/?=
 =?us-ascii?Q?BlxVPl+u2oWYsMqy8q8kWjqKgR+c4Dh44+jnMEVhCp31R7GRLk5NwKRXXf8e?=
 =?us-ascii?Q?KJSnO9R8PWc85W7GfnEkleMxrrOIwnNN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eETI5NCIAypCBjYlm2fvUA1PFkAQdu1lzgAroJPYz4F/fdCccU5QDgkeVxBq?=
 =?us-ascii?Q?axgUOyLj1ueC0b5jD+nGy087xfNjUsWvQ7Wu2vUD0Xq/Ec1IO6nSOqye20IL?=
 =?us-ascii?Q?krJlpB5LHuqEmTuUjaOHqy5agKpOFtVlY1BDNRpmcXsjZ6zUY23yn48rdqEV?=
 =?us-ascii?Q?4LMbr4wo+y2nXyXSCEJozTlprv7EaenEC1cp84uwhBJcHDO4glN45weX3/ha?=
 =?us-ascii?Q?aGwdqpQrYSS9yT2W5TKCxDCM4F4Tm7A/Am9yhq8yhCmDwWABPI//oFWOre6Q?=
 =?us-ascii?Q?9/qWf4/2tSF8vhL5CpiJ3iQl7qk/pZrNNapHR4/52r+w05kdf5W/vfJWqOBh?=
 =?us-ascii?Q?DUtA0xQvSTMXixocGZmDxo3x8u5/xaJ5ArE4RHc5OnymR4uuyGJ/nO8L/Akm?=
 =?us-ascii?Q?UyzMhblhMq8eoNOhkpAjsWyG4K9+s6PQXeBdpjp02XouqE0+U/cVfk3UHcqu?=
 =?us-ascii?Q?DS3Z3E34v+4xlMy6UecG2ETjajHeZbc14drlAIfymOZboLZhHAPkqkOMqThx?=
 =?us-ascii?Q?SkI2j93y8FlE8+hfoikApNfZboxvbCsc/9x4qGC+sqQpeG+lsELe8yEBW9kw?=
 =?us-ascii?Q?Ay2KWE3pq9+LtrY3+SqjYF+hkOKLd9KCBjnO+WObul7DXKyneX2AKPn7n8pr?=
 =?us-ascii?Q?9lUHwT7Fit6A9Vt/Ur9ktF72289qjTlA/9URgDkW+tBbdyZkeus9vUMVR9Lj?=
 =?us-ascii?Q?ZEWB9uO5/GShOBnrrl4U4HU5MzjdWFhbJTHKGBhyeB7m3C51KNZi6W4DM4FM?=
 =?us-ascii?Q?HSSi2KqV5RIBZZrUuKKIDExaBQTxw7NhROL7UuLIfq3fTbKkZAt2TnOaj9Bs?=
 =?us-ascii?Q?w/COYyTbbgzwF6vif4+nXFJEiJOKHJ1o2nWJDZbg43QD3kVM29sWXW9uQtrm?=
 =?us-ascii?Q?oeUFxcvtOm6lCV8IOf1bt83rBkH+PhWywAiW5uVmcoL4ZlxPppq5RZD/Fd9k?=
 =?us-ascii?Q?P28EmN/Tj/+FNdasobzqSN2Z8b06YQoJUqVV1/0TPU4eE3JM0tZI0K5qX8Op?=
 =?us-ascii?Q?eYrPiSSh1oekfV9NWOt7Yceyu1qIwQUXpWunxXeZ9xHxR+CnBpzpONcIvlmH?=
 =?us-ascii?Q?EZq6X64Uxp0RsUcuzp4IPz0iDGpWXqidS/PicLXeFdcAgmpLDSO8y9p11QFg?=
 =?us-ascii?Q?jPbCNWpH6tdfMmvGW9aKP1KCBPt2OqHnd0c2TXgyF2NQ+rd1+hm6tO0Wo8TS?=
 =?us-ascii?Q?a/fWbJtvsxI7CM64obM8E2aUdx6mCUydgpmf3hLO5IAQ6lP+cRRRdOcusBSs?=
 =?us-ascii?Q?D/6Gc8F6MmURSiEXWiWfG9tCCpdERqXxS13qAJp1Fi+KRg9N+f8pai83V+ky?=
 =?us-ascii?Q?njmO3nrRpi5CAQGqMXwCEFxY+qcl+fRI1zNGd2ZTYjrI1NFfzRGFM7JJQh/3?=
 =?us-ascii?Q?dNRwOuWCYJHaS+9FUV6h0FiMMMagzPm7KNYb2X6Q2iNQDvB3++q0RUW6Bm6Y?=
 =?us-ascii?Q?CCMnpRselkJ3v03Lgv65qEHi/cj2j8O+O5CTr7CGfiIxoFJxeRD9G21ObDZg?=
 =?us-ascii?Q?DWLnRWZ2I/33BdNKYtEbbNhi0EZaUbt5Z3TLyjAKIP5fcRdqs0maDYveZSyy?=
 =?us-ascii?Q?JPzBcSZyn7zY8o4dGeI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa35911-d47a-4707-c126-08de286be935
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 19:35:07.6059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMdFOlYE4hDdzVANgDJytyHB2cINRkM62oOqyJGcN82qvIc9PCcIk9zNm6OpUDuG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6770

On Tue, Nov 18, 2025 at 11:58:39PM +0000, Tian, Kevin wrote:
> > > > -
> > > > -			if (!report_iommu_fault(&dev_data->domain-
> > > > >domain,
> > > > -						&pdev->dev, address,
> > > > -						IS_WRITE_REQUEST(flags) ?
> > > > -
> > > > 	IOMMU_FAULT_WRITE :
> > > > -
> > > > 	IOMMU_FAULT_READ))
> > > > -				goto out;
> > > >  		}
> > > >
> > > >  		if (__ratelimit(&dev_data->rs)) {
> > >
> > > Remove amd_iommu_report_page_fault() too?
> > 
> > I don't understand this remark?
> > 
> > amd_iommu_report_page_fault() generates the dmesg logging on iommu
> > faults?
> 
> sorry I meant generating the dmesg logging same as other error
> types in iommu_print_event(). No need for a separate function.

Okay, that does make sense, but this driver is kinda broken because it
is using 

	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id, PCI_BUS_NUM(devid),
					   devid & 0xff);
	if (pdev)
		dev_data = dev_iommu_priv_get(&pdev->dev);

Which is UAF racy on dev_data.

Fixing that is troublesome..

Really all the fault handling here needs some attention, all the
events that have BDFs should all print the same, using a pci print or
using raw BDFs. Translation fault shouldn't be special..

Too big for this series, so I'll leave it..

Thanks,
Jason



