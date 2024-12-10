Return-Path: <linux-rdma+bounces-6399-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0319EBFA0
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 00:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4700D1883A96
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 23:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83E722C35B;
	Tue, 10 Dec 2024 23:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O4tVYpjH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FCF1EE7BE
	for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2024 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733874718; cv=fail; b=bBk/vylL8GkScRrbEpkA2NWuwMT8ryFDI/qEUXX5lDeMvi0xbP+ubJuET7lV5ZQSqjpmgOpEYOThNDjshmper9ssHecTnlmBDzwALHZTPZekK3Cc4hLhTLIHyf2JZhhCbMImNlKJ5K02COoQm/ruzNo/H8ZE0sXVKyTlfBMyH8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733874718; c=relaxed/simple;
	bh=TiOZ9uRhR7bbpGygem5IsroglLiL6gVrsy+OV3MTg+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ixCy8IiuLkmR9P8wCNnMQmrb8H6XKs9JBkYLoErcagdPAI8LOPHb4buGlnRuglNK41TDRY7c7m082AVKCeW7CEqZVCaBe+UYTDKBMsJz/X1YMAriJEpXT3uxmfRlpIFkvyPYtrc9oHMItL2EsitdeGxgqjNufsW3lagFbSeFUxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O4tVYpjH; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYllbOzWdQfRIqI7QCG9Z8nhxZbuPH2az8ZdPKSsK0SEQh7lv2KSAR36aPfMemU4fhmBWJg4vQd6dsdOyu/jUSFEFFDO3nnqkf+95/aVi75nMUzBtvy8P3srObWmNN0WnmHECgBzOKlYAtof54oG5wXGgQS6BffqGrWml1LTSwAK2qjaQl2iHFRBAn4EkDvW+QTtyanNJPArtLcGiZ4M3OFNQwG5SYkEWsVSGjZcQo8yrW9BTq2gSf3kNka0vC3vI8xtpdEeU6ufQpSGtztmvjcRjkJdYIqkKD9vWCzZGjD8OJICg+VsS0vfdAPFg08Wa9dvEEJwAqPNSn8M4ThNng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WQdEpUFpQDm3GXxFBKkFOBJ2TgL3vR+6Vqf/TsOmyw=;
 b=FVT61CLdadppShsC3OAaF60PVf9zahKidLdXPfa9zcfApEzlVUl9qLNFkdbc0M+ikbYjIYIYda0RO1m3sggHmXu7e32KNgbLpyGzMaRce1VNHNx8kPo8c8PWqmju6Qw8c6qi0dtdQKMxj24qo+HAEqDzYxYdK/Y7SxNqgmJ/S0tUakMr6DKOZviQELtIUS60JFKGaRTQQxoKvyXWphxnhL96+0MXklwN8YWyOVPuM227nNn3vhVppgKUQKmC1NZqNmwCr+VUvZ26W/khOdn7ue5C2mbL14eBidJTE2RcqpE7mZzUCJ0M5dCIiyLUVuY1v0eHwhUq/89nUJMGolEClg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WQdEpUFpQDm3GXxFBKkFOBJ2TgL3vR+6Vqf/TsOmyw=;
 b=O4tVYpjHy/EfNpCTvLqFiJ4xPtZx7Sds5wnsVqor1L1BzishBh9qZ9s97/Kc1bo9mDBoFtBkH05rilQ2Ln/BGpMFbWKOmjxGhf7B3gC3X5o0/wAkVthQ0mJSywTFVN0A1YUh+1qngmSqkRgWwhOPWzUSeYlHA4LOmym85DUokRwfesrRZNqc50oC4rq2Uut1kbx2cMMadGMmy44gjOnn2/7eTD8ct1WLRUQiuuodAF9qAyTScC5mDhGo4nngTsZyGump8YYmXKAB3d3w1QUEG1wFZTyclb4gsdPMlzm/woKhcTcb/X3SkjwqAxDo7OFtc8fQmimN05tWbYaiuj8Kjg==
Received: from PH0PR12MB5483.namprd12.prod.outlook.com (2603:10b6:510:ee::22)
 by SJ2PR12MB7893.namprd12.prod.outlook.com (2603:10b6:a03:4cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Tue, 10 Dec
 2024 23:51:53 +0000
Received: from PH0PR12MB5483.namprd12.prod.outlook.com
 ([fe80::9782:b4ea:efdd:2cb0]) by PH0PR12MB5483.namprd12.prod.outlook.com
 ([fe80::9782:b4ea:efdd:2cb0%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 23:51:53 +0000
From: Or Har-Toov <ohartoov@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>
Subject: RE: [PATCH rdma-next 2/3] IB/mad: Remove unnecessary done list by
 utilizing MAD states
Thread-Topic: [PATCH rdma-next 2/3] IB/mad: Remove unnecessary done list by
 utilizing MAD states
Thread-Index: AQHbRYqjd2PniK7xn0Cor3PxAgX8prLf4H8AgABPDbA=
Date: Tue, 10 Dec 2024 23:51:53 +0000
Message-ID:
 <PH0PR12MB548387B973249D15A819BAB9BE3D2@PH0PR12MB5483.namprd12.prod.outlook.com>
References: <cover.1733233636.git.leonro@nvidia.com>
 <8f746ee2eac86138b1051908b95a21fdff24af6c.1733233636.git.leonro@nvidia.com>
 <20241210190034.GK2347147@nvidia.com>
In-Reply-To: <20241210190034.GK2347147@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5483:EE_|SJ2PR12MB7893:EE_
x-ms-office365-filtering-correlation-id: b122740f-03fd-42d4-0d58-08dd19759f66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?H7QfVxaYdTfgGIZEkzyWe4Ek/bNmoFL6jIVfLtJ3QtY/uHI31j9Zs9u38q?=
 =?iso-8859-1?Q?2E8/Nf1mg4Zcqe6vmsNi3hfXVtiDg3xkfPq+QEVrBtTu84sal79zl4Qh1T?=
 =?iso-8859-1?Q?ITPH4GdxGKPNZ99uNQi4QV4Ac/rzaU6qSdLUIV8IhUsxk5G8f/xc0RaORG?=
 =?iso-8859-1?Q?FMwtGGa17fyOgcTFCZ7h/KrnupL+tQm2beodYkDKGdWKBGd1cHkiMpfTAh?=
 =?iso-8859-1?Q?fB+GTAgKqRI2KYdpQhmKHWV/gWrnu8xIL+qbSXF1VlhkvhmHcAPrsYIfj6?=
 =?iso-8859-1?Q?uq4hPDW7TkhYfG/RzemvOxeAyfIfJ4UHgehOgpjv3TAEWh0Fc8XDrIFNbZ?=
 =?iso-8859-1?Q?oqW4/EUzrSvntLZVzOZ77cvtdDI2fdJ3jQJ5L0z4YdptUhO3AxfrAPUfbx?=
 =?iso-8859-1?Q?fiXby+Brq23macn3AKomtlxuPFX/9ugmH/WrENiOqI/2RW7mWIgjtdD0zr?=
 =?iso-8859-1?Q?hFP2DT7ykg1Ux0BF/cCZVlYGpFhETxpgxHPHBZmpgTUevw4jl99kczNxnE?=
 =?iso-8859-1?Q?rWd7eIZA6G075XEZ3NgMFhBMrvLAi6n8hA+2ldbvvxyKSvkgj4fF+pPkxf?=
 =?iso-8859-1?Q?BaGVle/Z39cfrNqVjYIslwAyJlm4LTDYGR3oCyK/CQGX3Dq3f2h0aEJnLk?=
 =?iso-8859-1?Q?3oNDv2U8RQvgkcARLHuFLMQrUi6RwnKGu8pwkAyWdZUmsLKJYE2k2NH1pt?=
 =?iso-8859-1?Q?+2XVmwt+Jqi9YFXTjxgpXmDIlT+U5JXreuszM+6KraUYGKdyfKUYnbk96b?=
 =?iso-8859-1?Q?nkW1b/ThJ91fymR/bBwJMqZcqR924KQQTiyKe78RoSUoQGOYk5eyfAD2I4?=
 =?iso-8859-1?Q?ZxkrUIuZ/hWXBrLHwzivuNnXtFBod2KXp/H6pNxOqvY6sgGtmI18yY/P6G?=
 =?iso-8859-1?Q?V44lgLQ5RJCSKjF/WFk7aMzPIfCHEU0vKmmvDahjpGzdUcubZN8emVgQGf?=
 =?iso-8859-1?Q?3piA02rR1bgnljtt3Cz0v0KJ1rRYK/ku/+v/82vBOrldx9WQp/VuGrP9Wk?=
 =?iso-8859-1?Q?z/QlKLw0R2m5jQmOhaSW/p+hg1oYXBsEC82fLDYiNeBJ8DyMtmOy8CtHpz?=
 =?iso-8859-1?Q?kGWAkuXeyDC9h4mNAQypxNT5QrNUWBGUDlKBKoeR2DXCqRg9v+tiAzEwXs?=
 =?iso-8859-1?Q?YRvNxCJ4cMLt3PuhRMTTTXxegLhHYUvLtWzPvPGSaTxoGhHtaiwlFVdC76?=
 =?iso-8859-1?Q?bnpve4i29e/ENvbEBWLbD2yFzoo/WHigr6ro954+/Qk2MiHXFg/bLNbcD9?=
 =?iso-8859-1?Q?dO4nw8iz8jWtRYa2ksGNDvTSWTsrVetPoxrEdxMI3D38Az3cyDzGihy5Px?=
 =?iso-8859-1?Q?ohHltu54E4rG48UzmPSju7XlBIicYqGJe8wcXNEb11oM0p1a0jKA0rwVHa?=
 =?iso-8859-1?Q?jy2JVU9Vr46VZ+MmcL+bdP7zJweoWA4rF6ZKSH+oN4HuRf4j7QJd9HzsYO?=
 =?iso-8859-1?Q?5ujzb0d2oicPmJcsJQ6oaR7LARpz5HCTjmbqnw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5483.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7r4KeO37abGmAXXdL/FXF1/9ydD1HIjUkDguvWn4mgJ9O/qfHyzfUGUh4P?=
 =?iso-8859-1?Q?cuQS0zZnJpci5SufwP2Rg79+5dniffuSKt9wQdHPELWtSA7OSsMHdftyUg?=
 =?iso-8859-1?Q?A5E2OvoM1KTFfsFgcJ8eaDOEc6ggglxUeQcQwScBrFmwOgWrVr5tCXa8Hu?=
 =?iso-8859-1?Q?NdMKWjaCJc/yKaFelcxP3wxQlV1bTAiS36ILtG0lx8J7Tkli/rLFnN9t59?=
 =?iso-8859-1?Q?fXMqlH24ER1vI4MbEU/Yop1voFQaLKJ7YHV2fZUjzJIcEg4aSOpS59qT01?=
 =?iso-8859-1?Q?xHTuM1wUOYn9r/pV7/X2GwrA91EVmyi6VwHIsTIJI8hsecl4udq3ByCTUy?=
 =?iso-8859-1?Q?NrI7zYLwU9SP7hqqNRarFKQCUNVeJcKP3v64UQMMbZi4suFoxVJ4hl6mKX?=
 =?iso-8859-1?Q?E8QVhNsLxZqXbqNsGLtBn63uVabgv3LOvSgqtvQtuAUc8GzSJVAFduNJ5O?=
 =?iso-8859-1?Q?Xwq+rbQyOeop4Npgih9Fp3oi4ltYXep12xwjJ0eS+Bew1V0Mo8VNOY/Z/8?=
 =?iso-8859-1?Q?o6mUuoKpoCjfKyPlSs6X3lM/pkmpnKnOGaCwgHZSE518COd7Ywo77Cmfft?=
 =?iso-8859-1?Q?LNM8sND8UWLWt+BY9TeEpUBbEGe8gMT4WD8rH/JBo/FZcFu9w6rNY7d+da?=
 =?iso-8859-1?Q?tB2EiRzh9LkHqB85Zk2IBuj4ZUEShk2eFScvP4OyDBsVnfBMQO76Dw2zJu?=
 =?iso-8859-1?Q?UpQnjDFbMUydpuuIwWAAf3YMnNuQHXVZDxrCy10BGBHOPbIlyJ/g8BZSfj?=
 =?iso-8859-1?Q?/obG7ADsgZNsi9OoxgbudyqbiHVJe1x070FOH04otCPvR6D3s49riryncj?=
 =?iso-8859-1?Q?U7ORtoglNw07zT2nFSe4G2o8AihMGozfJZYdI7pXeyGwsFU+wiSrykBU77?=
 =?iso-8859-1?Q?xAhNR0IhR1RfdJ/RyrJpK8G8j8JXTPlmAGOn5RgLBi7YqoTZRbb9KXLz6S?=
 =?iso-8859-1?Q?NsDuNIodfMoN5TtR59zK2YBREr+82/zhuovi5JnSaD5G8ydgZr1SJjRyyv?=
 =?iso-8859-1?Q?b/fwaEAM3U8vq8JbrTsV27PR+7+bKcla+jcsBm7gbnJsiADpJ+io5Hp/aq?=
 =?iso-8859-1?Q?uf3nV9Xs5272O7RVYlLl45bOjXo9J39VtZVIvT1hczk1HKDuTo+93YlN8+?=
 =?iso-8859-1?Q?Nf2+oSooSjyMhYdqzp0xcqohlUZ0GGtqtdrsryg7nezxv0Z0U9HF5pkw+t?=
 =?iso-8859-1?Q?wFwHyaDEhplFrWdZtSbAg7lAVAXcAqLN4xmhkRuatfeWgGI2UCag9rOKdl?=
 =?iso-8859-1?Q?zyGWpVnKZYXi2bx0gljwD0OzQdw2LvhZqaXUeNtD0a08lXqq4nxiXQ0XI+?=
 =?iso-8859-1?Q?QJ/wr+PqHpsgXDVJUEFY0D9ZUzv6+U1rl7JkAguVi47MhpViOM7/V3nWO5?=
 =?iso-8859-1?Q?OxppzQKtTbQNRQyN9iaTwFXDIk4sOf5vezljdAVYBVlXmt0BBDXY5ivV4L?=
 =?iso-8859-1?Q?/WuJjZK2WB//QnkcFQqjjuXeBmmhYUPXvL1DnaXtwnsoo4e5Crl3vzc82G?=
 =?iso-8859-1?Q?p0wvdqwBQBVvz18/cyxJW9xeNCv7C3X1Nf0s40j+0ZRn7+hv0+LWPuhS9Z?=
 =?iso-8859-1?Q?+l9uhWca/l9Fd4F46sznpEADYl5v0GdQ95Fv+DQ2Dj3/IFmxoqYSZ6C6g/?=
 =?iso-8859-1?Q?cEJqZckN+wZc4ZsMq8WI44HALsBNTy6Cp5?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5483.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b122740f-03fd-42d4-0d58-08dd19759f66
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 23:51:53.2034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Bqb+4GirXfiTLWF+ydhS3QuvUSrm5iz/5AA3YgccUnirij2p4PorKa6rzCcGERzg0m85nhb26CLAql1bSgNUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7893

From: Jason Gunthorpe <jgg@nvidia.com> =0A=
Sent: Tuesday, 10 December 2024 21:01=0A=
To: Leon Romanovsky <leon@kernel.org>=0A=
Cc: Or Har-Toov <ohartoov@nvidia.com>; linux-rdma@vger.kernel.org; Maher Sa=
nalla <msanalla@nvidia.com>=0A=
Subject: Re: [PATCH rdma-next 2/3] IB/mad: Remove unnecessary done list by =
utilizing MAD states=0A=
=0A=
On Tue, Dec 03, 2024 at 03:52:22PM +0200, Leon Romanovsky wrote:=0A=
> From: Or Har-Toov <ohartoov@nvidia.com>=0A=
> =0A=
> Remove the done list, which has become unnecessary with the =0A=
> introduction of the `state` parameter.=0A=
> =0A=
> Previously, the done list was used to ensure that MADs removed from =0A=
> the wait list would still be in some list, preventing failures in the =0A=
> call to `list_del` in `ib_mad_complete_send_wr`.=0A=
=0A=
Yuk, that is a terrible reason for this. list_del_init() would solve that p=
roblem.=0A=
=0A=
> @@ -1772,13 +1771,11 @@ ib_find_send_mad(const struct =0A=
> ib_mad_agent_private *mad_agent_priv,  void ib_mark_mad_done(struct =0A=
> ib_mad_send_wr_private *mad_send_wr)  {=0A=
>  	mad_send_wr->timeout =3D 0;=0A=
> -	if (mad_send_wr->state =3D=3D IB_MAD_STATE_WAIT_RESP) {=0A=
> +	list_del(&mad_send_wr->agent_list);=0A=
=0A=
This is doing more than the commit message says, we are now changing the or=
der for when the mad is in the list, here you are removing it as soon as it=
 becomes done, or semi-done instead of letting=0A=
ib_mad_complete_send_wr() always remove it.=0A=
=0A=
I couldn't find a reason it is not OK, but I think it should be in the comm=
it message.=0A=
=0A=
>  static void ib_mad_complete_recv(struct ib_mad_agent_private =0A=
> *mad_agent_priv, @@ -2249,7 +2246,9 @@ void ib_mad_complete_send_wr(struc=
t ib_mad_send_wr_private *mad_send_wr,=0A=
>  	}=0A=
>  =0A=
>  	/* Remove send from MAD agent and notify client of completion */=0A=
> -	list_del(&mad_send_wr->agent_list);=0A=
> +	if (mad_send_wr->state =3D=3D IB_MAD_STATE_SEND_START)=0A=
> +		list_del(&mad_send_wr->agent_list);=0A=
> +=0A=
=0A=
This extra if is confusing now.. There are two callers to ib_mad_complete_s=
end_wr(), the receive path did ib_mark_mad_done() first so state should be =
DONE or EARLY_RESP and the list_del was done already.=0A=
=0A=
The other one is send completion which should have state be SEND_START=0A=
*and* we hit an error making the send, then we remove it from the list?=0A=
=0A=
Again I think this needs to go further and stop using ->status as part of t=
he FSM too.=0A=
=0A=
Trying again, maybe like this:=0A=
=0A=
	spin_lock_irqsave(&mad_agent_priv->lock, flags);=0A=
	if (ib_mad_kernel_rmpp_agent(&mad_agent_priv->agent)) {=0A=
		ret =3D ib_process_rmpp_send_wc(mad_send_wr, mad_send_wc);=0A=
		if (ret =3D=3D IB_RMPP_RESULT_CONSUMED)=0A=
			goto done;=0A=
	} else=0A=
		ret =3D IB_RMPP_RESULT_UNHANDLED;=0A=
=0A=
	if (mad_send_wr->state =3D=3D IB_MAD_STATE_SEND_START) {=0A=
		if (mad_send_wc->status !=3D IB_WC_SUCCESS &&=0A=
		    mad_send_wr->timeout) {=0A=
			wait_for_response(mad_send_wr);=0A=
			goto done;=0A=
		    }=0A=
		/* Otherwise error posting send */=0A=
		list_del(&mad_send_wr->agent_list);=0A=
	}=0A=
=0A=
	WARN_ON(mad_send_wr->state !=3D IB_MAD_STATE_EARLY_RESP &&=0A=
		mad_send_wr->state !=3D IB_MAD_STATE_DONE);=0A=
=0A=
	mad_send_wr->state =3D IB_MAD_STATE_DONE;=0A=
	mad_send_wr->status =3D mad_send_wc->status;=0A=
	adjust_timeout(mad_agent_priv);=0A=
	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);=0A=
=0A=
=0A=
Though that might require changing cancel_mad too, as in the other message,=
 I think with the FSM cancel_mad should put the state to DONE and leave the=
 status alone.=0A=
=0A=
>>OH: Wouldn't it be better to remove the status from the wr entirely and a=
dd a state of "canceled"? We can't just put the state to be DONE in cancel_=
mad cause we need to know to set the wc status to FLUSH_ERR=0A=
=0A=
This status fiddling is probably another patch.=0A=
=0A=
Jason=0A=

