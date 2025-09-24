Return-Path: <linux-rdma+bounces-13633-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 573E9B9B57F
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 20:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DDEF188433E
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 18:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E4731CA6A;
	Wed, 24 Sep 2025 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XVKBjUNQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A1A32C33B;
	Wed, 24 Sep 2025 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737276; cv=fail; b=slgCXI846R4SysOpUZbMn9KQIlQ09F/jIVJFxaW55ichDlnddjLPZovdNE1qa8GPoNcsEFuXe0HCf+Jn3GJ7nO/0pnpKAaxnfgtESOpQxMFJiVYjU+j4p1dge/PjPHjQfuzUgLJ94EKJo8nlbLshGjJ6NgH0JHuqjxVf6MS1KAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737276; c=relaxed/simple;
	bh=VpIsf9kTOkjwNOkIuzAhsnH8+PKy23Q6e9foJ/Ot4OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fTobwcXHgDu8HM9F+6BuPFLywSnuHJ5ysCPnM3abJlotmdUatRRJ++q3OFLGskdqTt2IJU9aTqwDr5AJRieK6XC1i3Rq1ssZ7faxugTv1JyrrVZxXvBTmvPLpOitYR6wz5lHfnBYcYvGWH97bxISxXXBdZIsmvzLkrMhCUky5IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XVKBjUNQ; arc=fail smtp.client-ip=52.101.62.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iaq6+MCqQzaoEblHrJj5BIT5hfQa/a1ZEaBkaU/6/5iKcyM/+FGq7lWzBQ7u9C4HQMZgm662XHfhnYNCFhiRGY+7obTKVjiIvIs17XuwTnohtr1IyzGrExs8XgqoCUhCp6a3B6fuInoeKQ6aHwl72ae8eaz4txNxsaseA3qwyOD4OUo8sBVD5i+WHvewHIV7OksvIVC1zgWhw4hgXhLBR0yEQT2OhrTA0Eu05rdg4SF6pwkENDdkOGzGQOHgpBNMs3HDM2PezDbz5IP/7v/ua+d6TZMkKlgn1FJjugwm8+KbZi089+wJhHjCyX65qEI5dsc9d+GKyYjItf6iJ7Gqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlDnrHdrT0T7HWCsgXm6OxGBukJp35cxrONHbhmlyzk=;
 b=m32cDCwKPB6W2gyhiZI01BxiMqNVGcdprPHdZSB4fD1f0HjrljfDzz8l8tRW4FaVi1WJN8o0IGt9sz3U6VOPdBk2BxjbhCp6JNSh3GYUI215eOUa3XMrunm5jrMAHprJaZVd1qCVK0L1gk3nQyIeJcTqTwqYNamEyBM88UksJACORECqBMwb1xH54LPx78DOH3xKQDnP+Stkv80qFbA5h+ZhJDzKRWJnAdT8/mgjZkcJAVGqBUkuQEBNoyeVz0cTpG0VZV0ECKf5rcYx9Ia8GjlBqJQiSyRGNTcJ1Xglz6hf8+9RY7dVc/GVMSt+jEJ+nbu59YVjaBoyP1FawT0riQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlDnrHdrT0T7HWCsgXm6OxGBukJp35cxrONHbhmlyzk=;
 b=XVKBjUNQpK9RdJvEuxs4ShBzESH5O5urmyIlFXbO88GZ/QJe/oQOuZlieeU5PZpSCdu4WS37NDrvc9PDe4kgxxBL0iPMmzM6DOvQqjgjJ3uVZTgn0GEkMmgophHlr/PTqfiTf9TP/vSRNiZqAsT/gi7n3ENOv+oKQwKBPYJMipKytSXty6Wt8Xg9JUTxuAuwMY523xXw0jq5/Pg3Bks5ta1Pb28G87eW5ZBrELUPNdSME3E+4YSRLbrunfBa47MfVahirNlzr2nbqchfAyS6a8CIbN9H1j2LUUEDLc4VZr8+2ex10BTDcGo5S4BL7+5Tz1vYPNMIIpA8nry9BKywuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14)
 by CH3PR12MB7569.namprd12.prod.outlook.com (2603:10b6:610:146::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 18:07:50 +0000
Received: from MN0PR12MB5836.namprd12.prod.outlook.com
 ([fe80::5274:105c:deaa:17cd]) by MN0PR12MB5836.namprd12.prod.outlook.com
 ([fe80::5274:105c:deaa:17cd%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 18:07:49 +0000
Date: Wed, 24 Sep 2025 20:07:43 +0200
From: Vlad Dogaru <vdogaru@nvidia.com>
To: Simon Horman <horms@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: Re: [PATCH net-next 1/7] net/mlx5: HWS, Generalize complex matchers
Message-ID: <aNQzb1VPhkAdEdd7@nvidia.com>
References: <1758531671-819655-1-git-send-email-tariqt@nvidia.com>
 <1758531671-819655-2-git-send-email-tariqt@nvidia.com>
 <20250924161727.GM836419@horms.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924161727.GM836419@horms.kernel.org>
X-ClientProxiedBy: FR0P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::18) To MN0PR12MB5836.namprd12.prod.outlook.com
 (2603:10b6:208:37b::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5836:EE_|CH3PR12MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 753b12ba-4821-48b3-9149-08ddfb954587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hseQWBsBXIegC72ubvGiwaN+IxvJ3AU7Ke4pKjhs6hkR96Yu8afmi/nwOGUA?=
 =?us-ascii?Q?UgyNOoVSaakS0+0h9DWPbbZV2pJSYfltqGPR8Hqs/+PAxj2GCdRjcc1inu6J?=
 =?us-ascii?Q?Fi8wqFgGHjEJBNbcHp3GmKFgtsD/VHAG5xoy3Y0E6uXTv2oqqj8h6i4ey64v?=
 =?us-ascii?Q?EH/GVlMK3tjPuOsjkLmL7s0mJGJALyUwXBmSgjFUWf3hwJXD5ra9YPyGB8KW?=
 =?us-ascii?Q?P3J0IaYVSue+KT/b8LYRiCzO/baVVXy1vaBZX0PxNm4FU4QVwY9l5i8EdiYO?=
 =?us-ascii?Q?56R1O+sc+j04shs+7/VJ00A0GObukp3g7UHMSRAQBMFahTdTopwbZJuHkefb?=
 =?us-ascii?Q?RVDNEY8ySpGP9jveJGmN2dwH9WsClSe58C6WYif2GkUzoCDwvhsfChX5x7J0?=
 =?us-ascii?Q?MCktSR+8vdEkK8D37SdGFzi08zTv2rg8dIxwpIPAFomoBDJBs403hAYicgXv?=
 =?us-ascii?Q?4FZAsUHIxDa/KELqcwJYoC6Gn7jSd6V84jNb7ydH6cMbYLnl/FMNGYiJjaDp?=
 =?us-ascii?Q?PRRybEoyruuflFH45eYKVSFVQGMjQ/wauq8ZwsVLEyBHevcTd9aUfqUBbZtS?=
 =?us-ascii?Q?BC2l4LkEHdKkBM9wYFZ7+RP/fnVt++QvHxj7pD9EXQ4bx6fUUlBhUX9z9d5I?=
 =?us-ascii?Q?l0qfmbJasV/JMfMulxmuuNNrhg+TURWdp8Pet/gh1x5yKqxMh0Eq6wnnZfxT?=
 =?us-ascii?Q?m8WBE+bK6219oxoSEWL1h6DUsjXLf3CBpg6lz3lWMfJ7FFFBx5mE+/q33qGq?=
 =?us-ascii?Q?kh/Z7wLpj8snBwngdjhfQ5LlnlaJDYWKPPufdc6ewnpJcdbqAcXNbmdk6DCV?=
 =?us-ascii?Q?LrubFR9gaMYg928SF5Ie2BT5xHsmweeMri5Z6gcVe6tsePO1+maCODf7702Y?=
 =?us-ascii?Q?03Vqi4ymH23aYkcwBDRBJPn/WwX8dISXB6rIJNdl1zjeSy5NR2BxCd1YOwm5?=
 =?us-ascii?Q?WEZlQixCoMUKQ1yfP+sg9g8YscvQp3mavRNHknx0bNpJF042FcgwlzZ6bK7q?=
 =?us-ascii?Q?vEwiemuQasdp3dP4IilfMXpdFiJjOMbudMn51kPvGaoX5tQll53dN1ZQRAzB?=
 =?us-ascii?Q?jcwBarTHxkdrdKeL8FTiyHdywVg9tAtB2fo8lcbrIx28qhTk5ZBsXtyBcXng?=
 =?us-ascii?Q?y4wxvldE7cHAmV0uf98TywddjMAyWxSHelXm0JMqFRVlyvpXsXqfh6oIDszc?=
 =?us-ascii?Q?ngxiOig6dMy7Ni0es9K5TJhwOffOyTOp3xqp1lZLo+ioiNeb8UGlCVemh/ou?=
 =?us-ascii?Q?NldHlGBE0+WWa9fm8i7tBpdPUoxUMT5F0DJxBEqlTgl9sMSp2cX67Q7AgJDd?=
 =?us-ascii?Q?V4eOunuPLAIPc/fb+PqVvIlQj+BJi9JcwvYz0f9CG6YTPF6SdxZ6q4KIk8Ux?=
 =?us-ascii?Q?ldD6KVuzUVQ7hbqAhRB21fEwmR/5FagbhWZK6ArhrlwA9Pww8pSHjyp9GEmB?=
 =?us-ascii?Q?9YqZRPYQvTo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5836.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mnRAT01DJt7DSgUe/JxzPpTjTHt2LQabEolnouxMvPa8/9gBaaBWRRwq2PPl?=
 =?us-ascii?Q?n1j56zXy1SYlnBVIBpXfFtvPSJYmHBxlEthmw13AdbxL6OWdbUilv0aAUdPp?=
 =?us-ascii?Q?LaDVc52aehmpx7qf1mIQY6+5wa7vvNY2Jhc69jWZ729GGn0nnRN3GlcX+Zq1?=
 =?us-ascii?Q?JnKbISNxY9QAsoflliXYZDkPtPkGyRGN2kq9Yt+t2O09hQfF/H9dx3Yvz0Cv?=
 =?us-ascii?Q?rxfPnbQmo0P4ngmte6AYBlocFz8Zf9aLL08PveOBFGjmEUDrw5bF1TZrqeUk?=
 =?us-ascii?Q?ppnrQX2R8N6BD+hzt8lbfgTnWn8AozXKL+qhjWTzRm8dWC9n88J98mEV9ppL?=
 =?us-ascii?Q?NX/t/+P+LlyEvKp0f6grr7mCi4wtaamlntBhbFkDYr4DezGWYuXLf+ECIsRJ?=
 =?us-ascii?Q?LnlMd8oNJ5Io+bkK9LAeaUmqh1/NQm98UhGb7AgM8JqFd7oPWclLTARGijzc?=
 =?us-ascii?Q?d3OigTsIy92Jy8ZwWYrEBIA8J0NEEm/oKLULV7rItp+nzNU9qFfiwWxj9Tq2?=
 =?us-ascii?Q?IWfM11UElsWM1QrrFvFno4SOjQVwQQZ2pkZy6eT1l9KF94Dv78m6aRAnH99q?=
 =?us-ascii?Q?n9A4CALzmAXbnd+ySeM91RTfAIVH2+j679Lup5fIxJMKGNDvlCSzd9TTL9oy?=
 =?us-ascii?Q?yk2zH8KUKYi1Inu/i+NFPvXzaWriNvnis+pdaWd4Dfs/tbeX0eRRdW2CLt0h?=
 =?us-ascii?Q?PBA9RCgNgexcozQsmg35aBzVUeY8O3dI3M3ysnOt5rQGvKsWGvMRt1YyZya/?=
 =?us-ascii?Q?XnqlPp6ThNVC9KOZP06wEa2l4F/3GWIonYN82pmf1EEFjpRexpsU7AkOf2dF?=
 =?us-ascii?Q?2CYNTVnuC/+U+Ey3WsFsymimKiAmiK7SDwEcqf/ioxIkVBDXLd5kVk0RPLir?=
 =?us-ascii?Q?BA30UDX6KGQtG7y1ephTQTDQnZUbcut25KdEGqYCHXbNyfmv/jhE1GjKZCn0?=
 =?us-ascii?Q?5Tb7MsXwH5CLwIUqHpn7ItaaVu9wVodPMeMa6g3ZjA0WbSKZcgxwfFUrrR8j?=
 =?us-ascii?Q?89Ds1EfQx0zsrclbqSg+GV80IWvafl7OPhfETFyMXS92qH4wB4mqwwfpsTip?=
 =?us-ascii?Q?p6o0ZiG4uUFN1wzKacTQn2IZIGxgP0maeT2VK/6e2IYxkLBcvrisKCg30gqf?=
 =?us-ascii?Q?Ftet1PD6EY1L5us89vuuNMJRF0TNkUTQEn6vRjegtyxmHbs0f90SEUrJ1Wx1?=
 =?us-ascii?Q?KJO458jHvi9+gZR21vOEhSk3Fr1QhsuUCpMGPNJ5+roZmJwPPy9tTojTNmIE?=
 =?us-ascii?Q?RyS/ydg5/jToX70sNGAl7Ke8yHvWej3Wn41LuNSDiO8vcuT8Q7dM7kqvZr0r?=
 =?us-ascii?Q?reh66hol3GZIgEVSv2M0mnPWAPpR98QlmQl8+luONOl2gUfqn7zNYTZeNg+O?=
 =?us-ascii?Q?meqLmGkqw7pvJdA6D+Uv+MMe/W6P9+1qQlP6t2gznblc0Ag8DERJ+tjQ6knP?=
 =?us-ascii?Q?g3rpmvXuZHzWcA8QrbTj4UVpL7nyTVSR8VCQpK5xlK7nX67K7CuYBMtSY5ke?=
 =?us-ascii?Q?AG6pswkNxBp/r6hFM1pCa1NGoGUSzNBIS7l5T3uZ/ApUg1n/c/ODB2dC0H3P?=
 =?us-ascii?Q?S0ND7J8Y6TmBNqCTOheJP3QjGHXHxazmhrQZk2j7V/vYmObCIDMtKBoQiCDy?=
 =?us-ascii?Q?U/7zkKVFQL0Cc4P4SM/ec4JRGC8vwZggaDr3htVTkta+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 753b12ba-4821-48b3-9149-08ddfb954587
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5836.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 18:07:49.3003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Drqdh2UNvS3lR0QEerHs6oq89CAEJFlb4dyd1RpSBxiVX22G5FsAhd2mFVlxrJPJKvIXHR62tSvwzwFWxRe2Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7569

On Wed, Sep 24, 2025 at 05:17:27PM +0100, Simon Horman wrote:
> On Mon, Sep 22, 2025 at 12:01:05PM +0300, Tariq Toukan wrote:
> > From: Vlad Dogaru <vdogaru@nvidia.com>
> 
> ...
> 
> > +static int hws_complex_subrule_create(struct mlx5hws_bwc_matcher *cmatcher,
> > +				      struct mlx5hws_bwc_rule *subrule,
> > +				      u32 *match_params, u32 flow_source,
> > +				      int bwc_queue_idx, int subm_idx,
> > +				      struct mlx5hws_rule_action *actions,
> > +				      u32 *chain_id)
> >  {
> 
> ...
> 
> > +	ret = mlx5hws_bwc_rule_create_simple(subrule, match_params, actions,
> > +					     flow_source, bwc_queue_idx);
> > +	if (ret) {
> > +		goto put_subrule_data;
> > +		goto unlock;
> 
> Hi Tariq and Vlad,
> 
> I guess it's a simple editing artifact.
> But it seems that the line above is dead code.
> 
> Flagged by Smatch.

Hi Simon,

Thanks for the heads up, will fix in v2.

Cheers,
Vlad

