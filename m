Return-Path: <linux-rdma+bounces-3397-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0D2912487
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 13:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D041C250FF
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 11:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11FF174ECA;
	Fri, 21 Jun 2024 11:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="vO9HddIa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DABF2629D;
	Fri, 21 Jun 2024 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718970646; cv=fail; b=PiP/aemdi/JUcDRRKxn8vkNfd4GF+CbO2VaiRNXSny62hN9XVE5gi60JDDgL+50w4SaTLkCAw9NtQ4gztadHiqy5JyF1XA9eqP0jZ/iSvUEyvbWdgdNFO7xdOr+zSLnevIHJd0inISN8f7eP/N+vlwqFFqnTAu9cyihVGKq8xKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718970646; c=relaxed/simple;
	bh=+hrGSM0a96ZeHpiTr4FdT1qS9iKgwqu8dcbzu1X6aDY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QioXzfoBLRS3SYJUzfx+f6dJJ+XGXIrbYzYGmEQJ5Llvenqab6YSxaQwaTmWZzFUmhhsTKrRpEK6ynJjrVO1vSLtc6LwMZ2F2bQh6J/jYs0fRla08WT1Q0TkAXPxTuP9hzi06vCLXNLp1v43hmWyInBrGZ7hMCURclj76UD5kY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=vO9HddIa; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L9Lckn008794;
	Fri, 21 Jun 2024 04:50:03 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yw6t80cc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 04:50:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AciBvFwlgbeD1EBTtYjhLILcmqRGpD1qXS/IH3FzGGPStECegPzW9uYUa6KG1HlL1XYcYBlq/zonGbV/LE3xn2pEBiQJisTsGxiAw2Et7qegsfJt9ZyRVhwtevTFhe87gkNZU8aTUxgQc3OcCjp2adwOBqDiaCa+LOEfDaCPJJmyZ6AvlaNF+jhA6zlOvOqpOTVnbvcv73GAZzhqoQlZgqdWhorWk81MJTKKxRU10Npx8b3fXTUi0LvqMO0ub2V5V0A3I3mdrvW4H7WCEEYXEG3yG2d1eUaL7ck1Gg1FDyccFb79ebPnokHqfm4mmo/FXflGjEGSe9gx82xiNuO8Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAXS/yix+t4FbBgQcnF8+IFEQDPAOdeu2MFYHKquQ5s=;
 b=UV0lo3g6/MrQlwwjNx1w+pPVvMM1zwrQDRizIGpg9eYFlEgHEhN5TheezcQoGiYIQDbAn5nI/M/7ux1DNWdgaXc1JfpaZWUEIQazrRdh1lXVLahmlBzzTcq1rEDeUKDWnY+DTB0uvf39YrVcFPZc0GDXwk4dcvs7daLeyP+2zJ5pLYKtz9Q/Nl+y8T3HtQKP+tbdHmieR8HM4dne2QEUfL6LdhA2oUPHougio7VnQVf1aaMVesFpzU4u9NnJgr+1jKVMaP2uV1WB6szBzm6WnPhRS6qXfCNxsGuN1vuDm8HpuONkLhLj8XNQam/lj8wdxEgp5kyuh7g21Qr/RnuArw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAXS/yix+t4FbBgQcnF8+IFEQDPAOdeu2MFYHKquQ5s=;
 b=vO9HddIayHpazYbGIZylpMhKlw3wj7pqQaDVnFtmDkG3qj57iyCD2K1N89KMKM56lhE1LLnTg8oftjZJsdkCMQhqMVnGUBNNzRjh8LohuFPKNZRcrDoKTSTwt0RonGJwMUoDUUKSa4NJTnYoZQjox5Pce/kyH7VhzVezqRpMyAQ=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by DM8PR18MB4502.namprd18.prod.outlook.com (2603:10b6:8:3b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.21; Fri, 21 Jun 2024 11:50:00 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e%5]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 11:49:59 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Allen Pais <allen.lkml@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
CC: "jes@trained-monkey.org" <jes@trained-monkey.org>,
        "kda@linux-powerpc.org"
	<kda@linux-powerpc.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "dougmill@linux.ibm.com" <dougmill@linux.ibm.com>,
        "npiggin@gmail.com"
	<npiggin@gmail.com>,
        "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>,
        "aneesh.kumar@kernel.org"
	<aneesh.kumar@kernel.org>,
        "naveen.n.rao@linux.ibm.com"
	<naveen.n.rao@linux.ibm.com>,
        "nnac123@linux.ibm.com"
	<nnac123@linux.ibm.com>,
        "tlfalcon@linux.ibm.com" <tlfalcon@linux.ibm.com>,
        "cooldavid@cooldavid.org" <cooldavid@cooldavid.org>,
        "marcin.s.wojtas@gmail.com" <marcin.s.wojtas@gmail.com>,
        Mirko Lindner
	<mlindner@marvell.com>,
        "stephen@networkplumber.org"
	<stephen@networkplumber.org>,
        "nbd@nbd.name" <nbd@nbd.name>,
        "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
        "Mark-MC.Lee@mediatek.com"
	<Mark-MC.Lee@mediatek.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>,
        "borisp@nvidia.com"
	<borisp@nvidia.com>,
        "bryan.whitehead@microchip.com"
	<bryan.whitehead@microchip.com>,
        "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>,
        "louis.peens@corigine.com"
	<louis.peens@corigine.com>,
        "richardcochran@gmail.com"
	<richardcochran@gmail.com>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-acenic@sunsite.dk"
	<linux-acenic@sunsite.dk>,
        "linux-net-drivers@amd.com"
	<linux-net-drivers@amd.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH 07/15] net: thunderx: Convert tasklet API to new bottom
 half workqueue mechanism
Thread-Topic: [PATCH 07/15] net: thunderx: Convert tasklet API to new bottom
 half workqueue mechanism
Thread-Index: AQHaw9ElFky/QDaYsEqfjZCDMkJdqw==
Date: Fri, 21 Jun 2024 11:49:59 +0000
Message-ID: 
 <BY3PR18MB47372A1FF66BD1FAA1A34EC8C6C92@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240621050525.3720069-1-allen.lkml@gmail.com>
 <20240621050525.3720069-8-allen.lkml@gmail.com>
In-Reply-To: <20240621050525.3720069-8-allen.lkml@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|DM8PR18MB4502:EE_
x-ms-office365-filtering-correlation-id: 3f19aa88-762c-4586-55e6-08dc91e84799
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|376011|1800799021|7416011|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?PMZXRM+f4BXanVlz0YgMwXkf5PsvCbyN9w9rZhy7/A/CPbMdD2Ej9pmHmHwl?=
 =?us-ascii?Q?qu/NQV/5JYncdNy7MAe5AfH7c/ngiFSt/EDmsFodfTKfABCv28FrbSotdtrE?=
 =?us-ascii?Q?38jIx0mcJwVDpLewRkcNB+CjXzfLTO4uAJtjtHL/Ptw3n6Sy6newdRUxSoiT?=
 =?us-ascii?Q?F2bjSRvKKHGIFxEbb5DxPDeEY7gkGcFKubT5kypdTVCVLP0HFkglPBPPE6ni?=
 =?us-ascii?Q?C5Wy1kQuwFBv/7EdWclD6uALCfzzo2JX7Ci/CVAcsilGrJU46wLSEU+R4Q4f?=
 =?us-ascii?Q?BI5r8Pa7mB09CXARGmkT+fyaw9GM2PEepEtZAD/MOgIFsdvE7/ygYl3msJra?=
 =?us-ascii?Q?uXVfJk0XnQQJR4YwexNurtJ8OVtimjn4y9IEyQbCXIRxulhiZFVkSIJJksPV?=
 =?us-ascii?Q?B8r5pDb4K+bf8KfcLC7M/Ekfbbg7gSoTxilO/G0AKxU4FrbsZBCnliAv7HMY?=
 =?us-ascii?Q?/XRNr7sxJrbxefrTiSnSA+KG8Zxl5ab6AFhRvo0R/qbjc4qJdiVSOhNxaQ8j?=
 =?us-ascii?Q?Q6FCgi4Sn8HBLLDQkPPXIf+8nlplCJe2uigo3j84cC0qlJe3qXZ70b6j1qAN?=
 =?us-ascii?Q?IcLwnSbEdZDxWcemhGgSHbPy/ff8FhsrWaok5CWgIqQnOHE7i+zrOzW7QRou?=
 =?us-ascii?Q?c3JHT2j/2WBhyQQCLJP8j9bddAtZX5q6UAWMfDSir5JIIojyCIKiRof4YKaC?=
 =?us-ascii?Q?2B01vnbU8R3/OymoJ4E2nCCv1lmjqXIyOCvi4MB52k4YyK9eLRH+5scDeaF4?=
 =?us-ascii?Q?LsX97pqqsAXc/hYSLokRDQ3gFy51DFeBKyHQFtsWuLf5UzCRHov2mnX6tXe2?=
 =?us-ascii?Q?Cte+qXqJpWj72y/eiR4ejwmzbby/7IWwfJjnjyWj3VW+9p6Ynax90jnYCc6p?=
 =?us-ascii?Q?PB8ehs/W8dkZ+9KqtnEA9bQDCYlr5k7aeqx3Hd/PyVfDJJ64rtwNVBT9wQrh?=
 =?us-ascii?Q?VAA3q2YKaNL6PapDP3JWEOAageNQzXt2Ql1wQ0U/35lHF0OOauYadsfhmQEt?=
 =?us-ascii?Q?9NjRlCsDk38UGf2rRaNHxWy1KdVsqxvDAfbwNoCoW3MWrOq/f5WkV4X8gPrM?=
 =?us-ascii?Q?okSHwH04eqYDemuMeqzn5QmQcsPqCCJOB6H87Vd6OlcOgUzl0ko0Z1vsm+QC?=
 =?us-ascii?Q?h6TYmHIwcAC/C5uGWyuE5LWcarHcDU0JtkbDGjui33XMPRGRX5TiO8J7xnEO?=
 =?us-ascii?Q?yVC0MJWu0Cxg4e4GGoce7VahkpkuT8Goi5jSG7NvKQUrGHSr0D6ssfCwsg2n?=
 =?us-ascii?Q?qU75j0Xd9tIBvK/Y/HLVmNTah2mMIbOZH3+IUYbBfqQNRaQcfFKTHrlC29UL?=
 =?us-ascii?Q?uUGRiAcrmlUiuwIbBewGrYStIEfjbGw4Z/gVeMCdJwgCAouKbxNrvOve/dcX?=
 =?us-ascii?Q?9Rjcdvg=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(7416011)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?qiz7HF2T2MaGJdq30wpE7UpwbcuY9b/74tpGzT3kn/Bh9ECuIZSaYyz+264y?=
 =?us-ascii?Q?ouXXN57RGtrFJF7cM2zWaNew04usDVhdeW36q5f5xMjR6aIJ8AP8Nsc0X1pr?=
 =?us-ascii?Q?Qm/qoIIZ6zVAAuOIf3huCAlrb6G43/e1kwjGJPf3/lf/0/Oz//MU7kfh5b43?=
 =?us-ascii?Q?0MaFQB8QBYkiAKqUuAFrgNQGLYDm+uDDFbmg4X4rS1l6Ne2Q7QysfJMGZQ5+?=
 =?us-ascii?Q?m6wPEEixzQFS4pcSI3qSB07wVHUsji7oA8eVLpPoUVoo0A87KJKeBLmjmDm9?=
 =?us-ascii?Q?RY0p3Lr4ctNRMcnjw7sj4ZU0v9jGN/rRCqvyw6oNmM4rz+QjGcWu7QCLo2yH?=
 =?us-ascii?Q?RE1CWnmcRIlwG7t+IntuqHeJtczCLm3Rn2etahMFutfSHBDGDpmr42+vpy8L?=
 =?us-ascii?Q?HTCSZ0qlbneDl4u1P/YwEg2N3T1Pj77VlRRDmXRjK8cNFGDzvzRu3gjq5HrU?=
 =?us-ascii?Q?KJbW5sg0QUJ03mDfX6aQvJET+Mbuy0E4T9129RReaXy5Fpe2YOyEzg50rJrw?=
 =?us-ascii?Q?ihYpB8R/2gH0R+q131mvcBMZg7FQZRXveH9ll0MGwSoxSvsoUkQIG4PFfuEG?=
 =?us-ascii?Q?8cpZE3OtMK5bJDOOBBZOjdNDtxy6RVf2ZCLOBCfsnBvGbp+piizONHSm82g7?=
 =?us-ascii?Q?ZYEav6sZh+fymJZQl0wlH6/jvcVTt8Ki111sUtL/rb9c6n+QCQY4A+8MaPjy?=
 =?us-ascii?Q?bHYLc7vOtfBtTpOcfd72yrk7tgs1ie3NSjoA5nScRBvE9RnqUVbdIIZx+tfA?=
 =?us-ascii?Q?pHIgohH7IS1wODobPc1LrQkpMoOpRod7jRqWUf3sEatIimsq0SAU6i0WvUk0?=
 =?us-ascii?Q?eUrVFTXnrECWwOxRJx3QsM0C9ubrBrmtnmtw41/w7fBePG/Zqu7X9W2p110Q?=
 =?us-ascii?Q?dUJ/HK5sP5wQw6OgIOUKx3WhE1fRU7GKcb/r9AD835hADDbWyp33tnpGFabu?=
 =?us-ascii?Q?XptSvmEoevzBgPCbk0tNiJU91hje6KTyBsoAQMxTROaw5X6cc/o5kEjGq998?=
 =?us-ascii?Q?WpUoyOfZPwlU2sjPbp5tkvEHHKmQGak9nk/Jjt+eWq1hyjU+J+BgsBW7GT7A?=
 =?us-ascii?Q?NeqyxJkkrdSDNLBjaL4Mh67CL7bjkrS+OyYnIMcyyVgvAkwKSdjRZ7x6mzhV?=
 =?us-ascii?Q?pzrrO4xB+zNWEc2T4hoGwm3p+b1B/+CNqj1SeifElo2NojLbQyhfG8WUr8qo?=
 =?us-ascii?Q?zj6Pkwhuyvcf5n1+4xo7QMz6HZK2oE8M0cuohNXBrHYKDRS+vx9m2f6h4yx6?=
 =?us-ascii?Q?fBorLB/cWBnU416tt1HJpfr837MncoDNoALC2TuhtolsYfxq75Tm3aT+J6ht?=
 =?us-ascii?Q?Cgml8gpJE/k3lcD+h6QBjbfYV6oHArb64ys/61Z4vZPOXPeS1NRY7tr4VpU/?=
 =?us-ascii?Q?EeZ1bzJu90vGBTbTtD8geHBdr+OjqIyWnj1wEdymPdekWrKPbkXX2kh8JSo1?=
 =?us-ascii?Q?qi22o7qDYFbeb1GYFzVrNDLJZSGwHRjzFInnXTFYptpxxqTMF0yncCFlc+7Q?=
 =?us-ascii?Q?ZufPxHu9u/JAac/BjUknHnSspabUmHWetVtJHSbTtJWvI+mFUcwLiPc39K5K?=
 =?us-ascii?Q?ccfoBK+Ow+CE4WfZB+dg4G6GE0pjwBgsrO8g+lD5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f19aa88-762c-4586-55e6-08dc91e84799
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 11:49:59.8859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gvwaSeewnROOn/Vyzp/KGKGwabjnBSrFLTtWznpw2PIaJevHMzYEKNrinMH1dGQxr/dh3NuUoTM9IEbWJ+zMKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4502
X-Proofpoint-GUID: j3MJrJFbCz5Pai39EQARFQ4oSNj6ob0c
X-Proofpoint-ORIG-GUID: j3MJrJFbCz5Pai39EQARFQ4oSNj6ob0c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-21_01,2024-05-17_01

>Migrate tasklet APIs to the new bottom half workqueue mechanism. It replac=
es all
>occurrences of tasklet usage with the appropriate workqueue APIs throughou=
t the
>cavium/thunderx driver. This transition ensures compatibility with the lat=
est design
>and enhances performance.
>
>Signed-off-by: Allen Pais <allen.lkml@gmail.com>
>---
> drivers/net/ethernet/cavium/thunder/nic.h     |  5 ++--
> .../net/ethernet/cavium/thunder/nicvf_main.c  | 24 +++++++++----------
> .../ethernet/cavium/thunder/nicvf_queues.c    |  4 ++--
> .../ethernet/cavium/thunder/nicvf_queues.h    |  2 +-
> 4 files changed, 18 insertions(+), 17 deletions(-)
>

LGTM
Reviewed-by: Sunil Goutham <sgoutham@marvell.com>

