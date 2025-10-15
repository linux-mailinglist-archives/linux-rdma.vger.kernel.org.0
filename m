Return-Path: <linux-rdma+bounces-13872-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4DCBDE7EB
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 14:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552E43C6BC3
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 12:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8216B1A23A5;
	Wed, 15 Oct 2025 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dEYx8EDP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012054.outbound.protection.outlook.com [52.103.2.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D87FEEDE;
	Wed, 15 Oct 2025 12:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531802; cv=fail; b=slyJmuZOQkCzlw9ke1rqOCqSPJ+ZPNUHJcjXcMKY6bJyKXFcmWSkPDIGK8Vn7r3hkH/vSjd4LQ5AO9VezICAmOZqzvKAD65Pz75CD+deRGCjEPEa1GZykx3ZwC3tSa/mEN70qrEfCFgOgkR482SC4P+8l4MIOG8TsLLBRXl+Rgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531802; c=relaxed/simple;
	bh=8bn+NSw7GKgzYM3HdY6FVdN7noZOV8Qj6ogdRR1wjOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=acseRciCUBcxh3v0UEmwQ39wyLFv5qCLMuL6maO3W/9d3kKeAKlMgUDqTKvWy8zfmiX+105T/qUOMfU4DiCpu3Uf3kjKYeM20rs6c8GPl/dY9jYGAnQTK367Xxi3twD1LP248+Wf34roI4VDLTTJFwIkdO32OdhxG5uaNfi+uBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dEYx8EDP; arc=fail smtp.client-ip=52.103.2.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5lucw70MB+kpOpG2VrpoizRCUU00kidRriVb+7VcnN8Tj92/j8/XvnQm2dDEkLAVRPKhqpfbKt2ciclhcq5PKfuvNaXMj6/lgJBGhQ/aZnj7TQWvny/x4He/AmdTObTppztvKL5sMqg89ngrgHvscK8lRxerE1Tk6Kj7b3ul28Vywd74/9uv2QKIxJkJ7E07dlsPcYRySsQMSvPf9RVqPonm84tZMa8KNbDGaWIXQZ/x+BnPxx5O4Qg1XVDefAzFPmrHVeXsYmOZ1uhbC6lDc/+K1hfWufB2c/arKeqsIIUpTLu1L2hVuT1OKFzN5/X3kOwO4asTFZ/IeZdUo8inQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqUcZH8TW+8lW4Oh8fGjPsP7rbLhUwcD0AWsON4dxSo=;
 b=CbybDZOGGkuWmcsEYpC9wdoCkKQEvq0GhDlCb5nfoKM+xDEgMzV7VFAd5DNoBz65m8MkoVbECFZmPbrGS8OgLJbhXzkDLbo2jbECR7l2ac7WmL4c67m0c6wLkwArJESnLXUHtM90o2F5j/yEXkEt6r1cqEe+110RFkmnbdLIg6QHahp/bi03XsGcQHg7LrShfia7Xbv+tdejXNrF32rCL7bFJnaNMbq+eB8BUgt6dYnT+RczK0Kpmi14CRV8j6WHQek89PbG/TaQsN8YHD4SmBKsu+3gYQfD0hMXIQwwCFQB5Og7zu4Quy4nuH7JA21VKkH47+MrhGbrCQQu+zD06w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqUcZH8TW+8lW4Oh8fGjPsP7rbLhUwcD0AWsON4dxSo=;
 b=dEYx8EDPjIwtLc9MrGGRYMIL7GeaGHKxldo1wPpwLnb0w4URErk947Lwnn6zbv9pD4QCqfY8ebsxbZ47VVrxKAwUYODOZ4xlRQERwJsYYmyDKc0MaqmGvOgoHvSL4Cs/zGt9bM1IxXnfLo2CGFj+r0y6FPKE4QuQiOhUwh0nTuM8s4JQNExFh397ztx5u38wO0jetVuSI40ZHVvdF8ALn4+AVbVTrWrA8FIMfX7uroJ+h/kH3vwcvSmUTa5pDryPMT1amkam+RR7MgNkMIS1yVe94fEsp04W0CvkBhuJTS2Tr25REOc1fNb/e2Ue1SDu9NxEpJF3Wu0nH2Yzaam1jg==
Received: from MN6PR16MB5450.namprd16.prod.outlook.com (2603:10b6:208:476::18)
 by LV8PR16MB6032.namprd16.prod.outlook.com (2603:10b6:408:1ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 12:36:37 +0000
Received: from MN6PR16MB5450.namprd16.prod.outlook.com
 ([fe80::3dfc:2c47:c615:2d68]) by MN6PR16MB5450.namprd16.prod.outlook.com
 ([fe80::3dfc:2c47:c615:2d68%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 12:36:37 +0000
From: Mingrui Cui <mingruic@outlook.com>
To: jacob.e.keller@intel.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	dtatulea@nvidia.com,
	edumazet@google.com,
	kuba@kernel.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	mbloch@nvidia.com,
	mingruic@outlook.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com
Subject: Re: [PATCH net v2] net/mlx5e: Make DEFAULT_FRAG_SIZE relative to page size
Date: Wed, 15 Oct 2025 20:32:55 +0800
Message-ID:
 <MN6PR16MB545089E086BF99087773B76EB7E8A@MN6PR16MB5450.namprd16.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <324e376c-8f66-4ae4-af2d-eea7e5a8e498@intel.com>
References: <324e376c-8f66-4ae4-af2d-eea7e5a8e498@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To MN6PR16MB5450.namprd16.prod.outlook.com
 (2603:10b6:208:476::18)
X-Microsoft-Original-Message-ID: <20251015123255.15156-1-mingruic@outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR16MB5450:EE_|LV8PR16MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a72a91a-cfbc-4b0a-e589-08de0be77b1e
X-MS-Exchange-SLBlob-MailProps:
	YfhX3sd/0TVWrg+fxRScxfg9v9HXnUFl1pVDTAvjfLspHx/j4tgns8ZHePwzibS5NJrvI1uRSbSQW5nQ3qTP4FbeAu5i1uIb1EPcEDVNbowHJAW9u3IMD66W4g3no0x3B30+TY3d/bvmpwm1L+hmPkTNyijp7kTyfwxEiDA4Aaw/datoOl4943qV2SeTcub6Kwcp/PRpwZeCONTaNfsyy6XHjm08GRUwKZKHez3fYu4wGrHTeieJam9z0rqu2I2RIEjxKn4n5+85OmwpN01uLAACecU8yB38lzpJXrrHyyHlmoAVlPSXa3GlLCodF6laPaFkB+oMH8tqLTm+Zo140sJ4zpcFwB5LLar3kdz7zYPzb0/gqyaokFma214HuqME9ZwXk8HqexJs0bGXfsW31+JBz1BKHO8FA1sXqnXMQQD6hOoANMLN3UxlZiWkz3R444iPmjpTRf1PWrW3/EejHQsvo8apDZgssR3HHX6CNyPbM7svtW0ci0nt9TE2rPdC4c3dD4WItLaAq3d5r63HKw555ESLg49OZ2hnh3kqRV4XVEx/wtto8pzX/+QzV9CqdOf3j+kgyErt+G10nFKSqvuQYO7sdIuJg0Den/yyR2X1TG5WSh+7i/ZERnq3UytBLQFJ24N94iRfKLFnttthiXtMTIBH7LqKmQkFDhm0kGfbf+wCQl9uvz3+uLCShO84gx8MA4NbS4d0ca4q1jsExxheYbPlb6dds8QsXP5jJb8mSJtJPQRbtc0OmqhQUZWzCljzk5wQZriUFMIWfScrPbM/mUxt3qX+/4fH+2Y0LFo=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|15080799012|5072599009|23021999003|461199028|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5XWyG15xZqDJlSJSo9oN8VkfesL+RhwZf5MzCuEp2ZZaEVPy2x5aWQQBBAsv?=
 =?us-ascii?Q?9PY2Sb4mD0sIVIccJAqPQHyBKHL5mhM2z8a+1BxrepNIss1z8TUuFN1SioJa?=
 =?us-ascii?Q?xoYk8OMX3Y8+jTb74J7EILG17CKD6QtuCbdl1tC1X2CQANTIDIR1NQD5/DhZ?=
 =?us-ascii?Q?9t9U0Nj/Ev+ui/LUGksxdv+zB3uvo5dt3NprdvpgcjyMJiTjNTbEWPFyzqE9?=
 =?us-ascii?Q?1BJnRDdVXRwxkOEA2Iww0meRbHr+wxhzHVjWgMLn+ZUvO0QsIFWr/6H8q2oN?=
 =?us-ascii?Q?l1eXg0B1BPO/BcwGfOKfRn17C8bJA4P9sEgmyRFAwtJKSvWEcgdGM/vBHXB6?=
 =?us-ascii?Q?6T6+GMuXAodRGS3Psg+uzAvK0rSvmw/yOODpb++iu/xmL3KUijj+FxcdkDIz?=
 =?us-ascii?Q?dhGIJBZEM5me6+0d90oHyO1bIIGlMBlAsUfYaRqZ8nbo+HuEFmzwFZFAsqyx?=
 =?us-ascii?Q?7GSUi0wfFfE8v8jauA73dwswnw7WRiYh78XPW9SmVFJhvtcbBuYD9N7ijmkc?=
 =?us-ascii?Q?GGdtU219kq0ISs3KwKoGnM9ix9/vZnj2rK67rrzsr4Nrs2MZ+SDlNmTgPbTK?=
 =?us-ascii?Q?D4pRFFx/zhPfSp9QdROsk74No0URSGm29R6AVX5dn5Boa6Tilqj+vVuG3lGf?=
 =?us-ascii?Q?MBhefmojlilx3QxLgaNwH1yrrGlxehDWmrBbmzySvWDz7ycjzX2wmpGGudij?=
 =?us-ascii?Q?Y1t5ANeecv0LlaGQQDv+7iozntG1wIS9LDgxv9b9iDqPVH6eahGndZWV8cM2?=
 =?us-ascii?Q?/Zn3NGAq9ROond4In7C2DYrO/GxQZffB196jDZL5NqhJNlkmcGOCBI23Efx/?=
 =?us-ascii?Q?UW4gnrloTJXAyKCf8n0kZGSvu14ahLY0yj+kcjpYELGM+mnmZS1A3z1uSYoj?=
 =?us-ascii?Q?6SDrXXlxx7FBXL0bo5xWD8fNJO+bbPjZLL9Ka/U53TAGB3Zh9vmiIZG/Bo4p?=
 =?us-ascii?Q?V5dYS4Z3EzHOypUh7Eo6624QxfUT0DNXtYHMgr3Qu2QlDp1gT0I2V/a1Go6U?=
 =?us-ascii?Q?91Bouj1ZtBh1mQjPOubnxOHU03k612HCVJGRrxQd7ByjrkvF2ho1F1ae+6NG?=
 =?us-ascii?Q?MQ1aaflADnjSrlZNjeme3A5oOoecZceHy3bTMKJRQTBYyNa6an/ibFwPpJn3?=
 =?us-ascii?Q?ubKNLX+aBPf3d6Avbel5dpkD20Zsta10d86NG+EUszE7zsno2+KwpXQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?822cVHbNz1eNbd7XYngXa3E4d3Ff47MN9Hm4QaqVEj66BV98T7TewdfJpWJq?=
 =?us-ascii?Q?D2FhYFQH4v1KbZM65e17XjRxuCAFBoiGrigEm7QqzT0bLR9/aVC/TK+93Stl?=
 =?us-ascii?Q?I6vS1ARwoiBlHb+GyNCtbph0/vpLMRtAUPgREg5czqY0DyDDnw4sPsAJ9SqP?=
 =?us-ascii?Q?NxunuB/K0zX3dvyMTHq5eKTNh+oZwhbtm/a6/R3RUUxwEZ7dAcP+e6/HSfHX?=
 =?us-ascii?Q?HEgeVjjrozWAvISXBH5fSdrbNLq4uTE2hiyuOOPgn7THkPRe4uz86VWfJfvs?=
 =?us-ascii?Q?9CmlhYaUZLNRHlhr2ulA7g+mwPHfzFhA/MYo1jvqCY3jhv3nAQmbWtszQpQq?=
 =?us-ascii?Q?uMxrIWTKIBsT/bmsmjpTz//GlkU+ANt5090en1zfIE3STgo/CGg8NyXHP4+j?=
 =?us-ascii?Q?jbD2rFqcmmRusPD24PtRX7F79x1kp0xcp0DGR32SVnBr9ng1jqJPrMDw3GVj?=
 =?us-ascii?Q?UlLcqhxxrIljeh9ScOgb1zcHeghVF8As2Z9WHnB1XGOs1wXu0jOSRCEr3IRw?=
 =?us-ascii?Q?efjV/fyTpdCxHacI0APq6rs3ChTwKGXTxHdqmBjoGxVQfXEDwWnRtX74dCiV?=
 =?us-ascii?Q?UqqiH5e6Y1QotfWpnfgAMD3FNGzln1Be1ruZiyhiBSBrq2EdAqbQ+0swSJ9N?=
 =?us-ascii?Q?p3P/RdhXB5II77ct5yrEaiMQO7jy3W7xJkS7QdV6BlNmizAE4ldMuTd/WjgC?=
 =?us-ascii?Q?3sAV3Be2qSo5HVXu5A0cXXwMNwpLg0r9Svr9nv8QJ/otiKnQ5QgNxpy3sPc3?=
 =?us-ascii?Q?sWdMSpfq4GZfql/kw1SbWwn5WYDJR+LqszTfQQtR0LQMwLj0Oe1yn0ftBo4f?=
 =?us-ascii?Q?27G6zglZEeh/vK3Sk341aoVzSaTUJIZewR2VGkhiMvQGvYQbR1e8YHd3jYtl?=
 =?us-ascii?Q?QM+wi5tPh7RxjiSdtgJjjL/IAlSQPcrmFFnkiRq3DZUd+PKd13yDt269mMun?=
 =?us-ascii?Q?nZCx9NhoRWpWOg3pcEtIWGDcFAeP6kLoV1RhTfWiPGRKvAuydcP874bDsQ0q?=
 =?us-ascii?Q?QRq5TcaVkRTFyU9f1EHcTQkD8qHp7zgaJAcITok0ryUFo6l6xBfgqmqH09uw?=
 =?us-ascii?Q?S4iJSUC/Wjm+7cSfg/3LR9uv0A7V1eJ4xRvAbMCwehltqu18cvwnbGjoeaE9?=
 =?us-ascii?Q?n0xAXzUK8qNrf7F47/Lz3j95JZuki2I+c745ge2+hsgjNGWbkz5ec6PxjwmV?=
 =?us-ascii?Q?dNJ52gWjBczP87A8kjkczKTkKsagqEOr92th2cMdMT+1m6vlM8mMu3Yu511e?=
 =?us-ascii?Q?IQKYeScpSH0cFRV0vvwl+qDaSbfYuBcmNB9xICNduVHmHlBgJ3es6t0KwK4P?=
 =?us-ascii?Q?AtcptZdEXDspyaQf/BUhlhXh1GlI2s1kaQTjRr83zFRFDw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a72a91a-cfbc-4b0a-e589-08de0be77b1e
X-MS-Exchange-CrossTenant-AuthSource: MN6PR16MB5450.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 12:36:36.9395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR16MB6032

That's all the effects of changing DEFAULT_FRAG_SIZE. DEFAULT_FRAG_SIZE is only
used as the initial value for frag_size_max. It is primarily used to calculate
frag_size and frag_stride in arr of mlx5e_rq_frags_info, representing the actual
data size and the size used for page allocation, respectively. In
mlx5e_init_frags_partition(), an mlx5e_wqe_frag_info is allocated for each
fragment according to its frag_stride, which determines the layout of fragments
on a page.

> >  static int mlx5e_build_rq_frags_info(struct mlx5_core_dev *mdev,
> >  				     struct mlx5e_params *params,
> > @@ -756,18 +756,13 @@ static int mlx5e_build_rq_frags_info(struct mlx5_=
> core_dev *mdev,
> >  		/* No WQE can start in the middle of a page. */
> >  		info->wqe_index_mask =3D 0;
> >  	} else {
> > -		/* PAGE_SIZEs starting from 8192 don't use 2K-sized fragments,
> > -		 * because there would be more than MLX5E_MAX_RX_FRAGS of them.
> > -		 */
> > -		WARN_ON(PAGE_SIZE !=3D 2 * DEFAULT_FRAG_SIZE);
> > -
> 
> So previously we would warn, but now we just fix the DEFAULT_FRAG_SIZE
> so this warning is redundant.. Ok.
> 
> >  		/* Odd number of fragments allows to pack the last fragment of
> >  		 * the previous WQE and the first fragment of the next WQE into
> >  		 * the same page.
> > -		 * As long as DEFAULT_FRAG_SIZE is 2048, and MLX5E_MAX_RX_FRAGS
> > -		 * is 4, the last fragment can be bigger than the rest only if
> > -		 * it's the fourth one, so WQEs consisting of 3 fragments will
> > -		 * always share a page.
> > +		 * As long as DEFAULT_FRAG_SIZE is (PAGE_SIZE / 2), and
> > +		 * MLX5E_MAX_RX_FRAGS is 4, the last fragment can be bigger than
> > +		 * the rest only if it's the fourth one, so WQEs consisting of 3
> > +		 * fragments will always share a page.
> >  		 * When a page is shared, WQE bulk size is 2, otherwise just 1.
> >  		 */
> >  		info->wqe_index_mask =3D info->num_frags % 2;
> 
> Would it be possible to fix the other logic so that it works for a
> DEFAULT_FRAG_SIZE of 2k on 8K pages? I guess if there's no negative to
> increasing the frag size then this fix makes sense since it is simple.

To maintain 2K DEFAULT_FRAG_SIZE on 8K pages, one of two alternatives would be
necessary: either find a method to calculate the occurrence period of
page-aligned WQEs for the current MTU to replace wqe_index_mask, or use a more
complex logic to manage fragment allocation and release on shared pages to avoid
conflicts. This would make the page allocation logic for 8K pages significantly
different from the 4K page case. Therefore, I believe directly modifying
DEFAULT_FRAG_SIZE is a cleaner solution.

Please note that frag_size_max is not fixed at 2048. If the current MTU exceeds
the maximum size that 2K fragments can store, frag_size_max will be set to
PAGE_SIZE. Therefore, changing DEFAULT_FRAG_SIZE to PAGE_SIZE/2 should
theoretically be safe. The only downside is a potential for slightly more wasted
space when filling a page.

> I guess the noted fixed commit limits to 4 fragments, but it make some
> assumptions that were wrong for 8K pages?

That's right. Specifically, on 4KB pages, once a small fragment and a 2K
fragment are placed, there is no room for another 2K fragment. This results in
the predictable page-sharing pattern for 3-fragment WQEs that breaks on larger
page sizes.

