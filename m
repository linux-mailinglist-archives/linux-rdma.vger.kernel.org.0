Return-Path: <linux-rdma+bounces-8535-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 152D9A5A05A
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 18:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59EEC1887E13
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 17:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B66F231A3B;
	Mon, 10 Mar 2025 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Je6O4b5y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADD917CA12;
	Mon, 10 Mar 2025 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628924; cv=fail; b=YZk9aAoUhILiD6G7PhuzAoHlcwGVTTb5uJ1SxsonSIgF0VD2J0Xxocs+Xt5+Vrmp6NXxCK2n4q3AFP6rnolTJyS2rRDpZ/zodqGaKUh5qyu+D3FKBWKbBrB5omx8YbSJ/+EmN2FQ9NCu2gmbqjGduQL6BWWf0VpdVUnNgXGRuZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628924; c=relaxed/simple;
	bh=HjPNICVxUqluv4ZNHENaydJLFlQH1yq7KZH0Zt+nHqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vb2inbfkubnk2lvfwLJlZx5JCG149bQUmuA71t9aRjkZfFDGiiziTbgnu6AOLTB3ENGXCU+XOknkFk1t9tYsg7zGaEp847EczEqj4vUnpsv1Tr4WZ7c/5paxLShBlukW3PZtVi6Fy06VB5mGjuqupXxHh/gIIevpeYuFhaE+OUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Je6O4b5y; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uj43M1Wf+A4wDy32kpeR3z0rK2depU85CXEpyY1IDDj+RyFuqfKpcGw7Rb4VPRcVuWcUxzny9stIvc4QyMc0wN0gMatXd/ReqT2ZAgwpVZjxwhTQ289yel+Fkke5nAzqE1hV6YTufrfL5buRZq2Wv2BMYrcxAoBYrNoNeOlvx1LgAxHx4+2U8yHa5+1drVPhwFvAAC/4ihF8dgwrisx7mFw+/tcULC4/T9szhxSuZXzbCzhJzesEeyiNNLT4g2cHlraOMH2tGzUWKyDDNF2etOIFq+KnUa327mTT9Wql7AgBkpCLcB3yvXL28ll1O7YMLG6XO6JlEBBUevqPaiWHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RN7VunZJOWtH+/cDw80CoP0QHNWfKJVF/lkpxo9h0bw=;
 b=PGo3bu/Ha3mfEBqgzoz1zAnsNT5rpwrEopiAudxEcMs0ZxibQlMcUmfKYrUa9LcdTqrzfua7IxbOO0P7p92nZoot3f4GoH01Kqd5ftl5umwZK9GmMnd5ttpUjV7NhDhZeznuws16bkcUVfib9dSDaw1ZRPt9X6CFUTsP9ojyjCrok/nt8bV2WhxIBThf8QCigW6YSr/cBYb5dQaW0Qz7Mn8WFiSWy9QWa/REJTS9FHraH7ikzZUhkQmgRboHLQNsbY6zpmNwCUb4qLhMPh1AaY9o4LSjlr4nOPcZpROyD+m439cN05iA7ZLYu4Q+/rQhRnXz5gk5vr0Z7i17LvtbYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RN7VunZJOWtH+/cDw80CoP0QHNWfKJVF/lkpxo9h0bw=;
 b=Je6O4b5yg6E03zjEqfJYgy/t31HqKAJ/yxVWxrv0I+mqxMRulxZ3gMsxUYh0JQcFrvY/+uO3G9AeN1FJRhh1wHHA47KZzf7oneQkVd6EvJIvb2xop6VKGHwrQccWl8zH/zstvJwddd2/tEwbiLEopULWyHqGkS1M+kn3SioDCElgfaCDfeZ9lKYnFZ7cVBi36VnLZ/a+MeVWuEDmojg8KZNj0wHlsR6dTtM9rQt+4YCiodFp3jbUBRuFlt9nL7vl9edkJaMQmcwMApcZx3bCIl+FfxoDCOI+DcwC9AEMMHvrJAi/ZSI9sN4W6iQ98PbC/5vC2c6wSOCTQy27GylNMQ==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by IA0PR12MB8303.namprd12.prod.outlook.com (2603:10b6:208:3de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 17:48:33 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%3]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 17:48:32 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>
Subject: RE: [PATCH] RDMA/uverbs: Fix CAP_NET_RAW check for flow create in
 user namespace
Thread-Topic: [PATCH] RDMA/uverbs: Fix CAP_NET_RAW check for flow create in
 user namespace
Thread-Index: AQHbkFTRRtO5IbAuVkaPsNDNMM816LNskpaagAANjsA=
Date: Mon, 10 Mar 2025 17:48:32 +0000
Message-ID:
 <CY8PR12MB71959E6A56DACD7D1DC72AC8DCD62@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250308180602.129663-1-parav@nvidia.com>
 <87ecz4q27k.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87ecz4q27k.fsf@email.froward.int.ebiederm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|IA0PR12MB8303:EE_
x-ms-office365-filtering-correlation-id: 5efd80ad-1c17-4354-193b-08dd5ffbc689
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lCLM8D0c5oYgOVra6ZUU0zwDfK9gARxIvuqCQhbI31SIx4P7giOYPt40IdSU?=
 =?us-ascii?Q?J8/LnoIh4XL2p4q4SakU5Xw7hUZg15o6Q2ffsGr0MwLq4IsFCHGq+xFdiDmt?=
 =?us-ascii?Q?FaDxxgxay+1/mx2HypRy7Ki/FxZZh3S1/YQ5IgmFoHv3mlhzGKTvnRmdhKwu?=
 =?us-ascii?Q?cjceq+wEurVLyaK2kyRxB3/X57569E3wxOdD+PkgW+NPB16FIVF67n8UEGtD?=
 =?us-ascii?Q?ptW+yzckhtVIWm6jwISymaXWAMkyN8eGa9um2bXuX8fMYboE1CIdBYs5zpiT?=
 =?us-ascii?Q?RawtlSNFV3u/11HClezsO/b86IebIuRDcJHy/GlsO4ht/xFGzlwiwFZGAOIe?=
 =?us-ascii?Q?yhUgnSmpWXGu1msG+iF+ELRa7b194h2Wlq2McIK3VC7Cfs8xYwITZCCr59WN?=
 =?us-ascii?Q?H+yW6qKsVShTs4iyPH8S7mng3yPQTMrt3yhumGQUU1/tFh5Ni+GPw2Q35ezf?=
 =?us-ascii?Q?mliI2ZZMXKrTir6gPRrLDG0sVD5zdO1l7VLwoOzCyGirw8D5rx8GJpOz+ENf?=
 =?us-ascii?Q?ANcMb7mIDyL5BBybH5wxOqMQEnZPyetL9wuZ5Cft8BCqbpl1rychbVTvBBlJ?=
 =?us-ascii?Q?9JqM7HZT5TN9HPETC2Rg1PJJVS7nrNsFHExnfgLG+HlbEGwFNFPrjeW+YInr?=
 =?us-ascii?Q?v82c4qrZjYMzfpeBBHNMWwG5WnQ+WgobL5u+ZPD+YdaGX/g5T29MgqVc1WcV?=
 =?us-ascii?Q?gHuIhpXA3inHWSJxM9k6IGTx8OXH3wj9Vhpj/7IcHWhqRGQu7p6TbPj5rmju?=
 =?us-ascii?Q?WU6uNDMnagKfwZb1x82DAR+jxRXT7TajhKciSDegvwG4eA/99Fh156duhIZH?=
 =?us-ascii?Q?oSeWxz18XffK/xH1eMlg7IT2j29EZX2O66bK1ceWHTX6EAG5hpS5wxAsCZi4?=
 =?us-ascii?Q?88BKvaOVMGFPuUzkxrGb3acjlFVxpCgnMpLb6HK9Ci/oywIjWZlhZt9pTglK?=
 =?us-ascii?Q?3RzZxyWcTNIuHLlqH8jmfc5Icw/9OWob4KccECynsMDsPyd6OZHXimA/xwJX?=
 =?us-ascii?Q?Dz++9FfINTvvPAfe2WH5QCVSWZAOqilq07EoolR7R3apwWSDZrz7aQdaF+os?=
 =?us-ascii?Q?XDcQ/nScZ07hoHiOLe/U3I1FaHbVjh9QiDHysvvn8j6QTkWMpgInhNnvpqJY?=
 =?us-ascii?Q?SqEq2SQwiHqjen6rTKFPzccNrpz1So5lrLoo555ggh3RPq5OO1ZZnUMPzz1d?=
 =?us-ascii?Q?Ik3sPHxiH8M3w53cJtuTvB8+dPXNg9D1eB3XPsocXC66ZVbwoPnLQXZitR4x?=
 =?us-ascii?Q?MTbduKW6JVAt8bAn+id6t8koM58pBdjT5fn+2ltLo6VvvJIOuS7VYB3BZixY?=
 =?us-ascii?Q?n/CSpKqj7nTosloTYPw3Mh77hioPRz/N4kz6B8/I/kMxX4bjxdiANrDtNxQt?=
 =?us-ascii?Q?fJNr0YdIcMxEUxgFXaQLtjQw87f+xiPCu4XB09fiQH3Mnh6vmOi7Lm+9YrDZ?=
 =?us-ascii?Q?AwPJ4F51uhTrH1DaMGJqhTQKjwSh+bwu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ExADhq5U5sSKYNCBmFYAYC6Ehf7Ov4Lb4zGVmy6zBmQw/6sV6TWUMgyhD2v/?=
 =?us-ascii?Q?kGEnTuaTRTkZVIejmVH4o8mx1ofyRXR/DBPyZH9OZuDh9IBTQW/I5o1w73xL?=
 =?us-ascii?Q?c9ODJUYF/dPkB7xFd8kM5WK9t9N0VE44yM5GdVmV6WBMYAYvUK4SSGQqn78m?=
 =?us-ascii?Q?+7KCysMwD+e90agPHy/9ifOkM9CcPp5zJrdhpGwU90gYvebgN6aq8P5dzjv+?=
 =?us-ascii?Q?wB4BG6ykJIYbZlRBg1RXkTkVgwLZvVApzN4w1X4+IrBqyIaT8+yskym1FKRr?=
 =?us-ascii?Q?pEVxlj1NlTTxlecfhjxZk4cgr8EByXdRmGADw/6zBQYAn+dpIUAT0uLb/YZI?=
 =?us-ascii?Q?XY+tNC9rdAel+ap9bmTnrIZUYnAnJfxfbleEMpH7RyT4ERF8lHKDj4Twp2Wl?=
 =?us-ascii?Q?v3CmtB/Awpa99o1mva65MRm/cmLC7qyymtuQylE+yDFW+nKTAJk0wrVdj9Jm?=
 =?us-ascii?Q?OfVVwBudLT5q8fwl2IIBifrFJ9Wr+pZZB9mvIA8JHhJ8kfDEjy9mcd/SAKSp?=
 =?us-ascii?Q?FS4FrgY2jliIaOP/7gKZL/c0gGOXO2jFaxGTw48F+wROzPw/itjOM1mFNpR+?=
 =?us-ascii?Q?fdHz8JAfhQ/WLDp1Po9RVJGGsWYa1+0oOWks1SPUjisniie4eXkf/6Rk3pTb?=
 =?us-ascii?Q?F9/9/qdo9CPjwzcb2B7vxlHeXiOC2HxCjBtD9IM3U5nPrmp3gBXFeAX8/6w8?=
 =?us-ascii?Q?uBtJaY0GjtpODRc187gGFnddnobQe8FEVYhkAkhR4kbF7JEcOfNQ0t09BCGP?=
 =?us-ascii?Q?A5IeQnB8iPA8TXy/76ZrmUOgYWY7IrfmfgqDw/+W2/aY87iCSFfaKqw0OR0z?=
 =?us-ascii?Q?aFO3ZB0StK+8JvOfIGYKRweIVK9suqEjxA4ZxDfbuNIMgUtIQd6gLjJsdh/6?=
 =?us-ascii?Q?QziXbO9cEnURakMeZ/gFM2RLLLf3cEqHS4NIH8pOJ24ejrObx2s+x1xbEyjb?=
 =?us-ascii?Q?SAwvIMp3lOlI+GObyjX3TNZ2EFZBDbtDg/XqOKDlqSywRSxRlE2JAESlpDq+?=
 =?us-ascii?Q?E7AiokRBocOlpgK2ubxvC+mjAS1cLn0TXWhVe4lwNAqObzB9gFPY8HsMv4sR?=
 =?us-ascii?Q?wngvf2liv84P4Np9DdkyyGF3HAkJ9kGfw1YoDUf4j1IvEJBLKBrxhDYW6V56?=
 =?us-ascii?Q?5fTPaPns8FteMcLun7CebcjzNqGkGZysN+ipWhyicvr/KkOH7bErHL0og+6q?=
 =?us-ascii?Q?4vHerwj2eFtbCOT34GK2bN+ENm9knNOibFJcOW+7JiaEX2EWw+5NYpAy+qfR?=
 =?us-ascii?Q?thHdIbC0S7NpulcYxY74qhNX652Q7+4QjSWgUpYuaSaCPZSCRJZbVNfANAzh?=
 =?us-ascii?Q?60n/wgl0VFo/q3pwbuESkh1LXT9kyZp3CX9ExriMSHkrCDy5wyUfnQ12Y9XM?=
 =?us-ascii?Q?5DY3CjW9nYa6Z73QbrICmNE59cgc/LpBXdT1bqTsRKW1DMFAd12D/1agP6Ql?=
 =?us-ascii?Q?Kba1bVxZfjU2H/QuYqLgIXQdk7mutkVQKXOo/C2YfxvypWf9Z1Kay7JgE/gI?=
 =?us-ascii?Q?H5oBndQAESt1hv9KcHddR4SLcwmtjO6oOHd8Fl4x4Z/rYNFE/gW8kwj9mgRt?=
 =?us-ascii?Q?m5ig7wn4Z1td7QICj8Hn+NqmR2p0i6MsM0mriEWmowQn4ZzXvcUukuBMKa4h?=
 =?us-ascii?Q?6lJwxiba3z2uTCl4p7EM1dc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efd80ad-1c17-4354-193b-08dd5ffbc689
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 17:48:32.8300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6P35jtFeTlGKgKCI/aBG4viodwTI173pisg2aZVL1TIUvTQDg3UbExITpGkEC0XY8CQ2P51FgXPcWEdplvR6ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8303


> From: Eric W. Biederman <ebiederm@xmission.com>
> Sent: Monday, March 10, 2025 9:59 PM
>=20
> Parav Pandit <parav@nvidia.com> writes:
>=20
> > A process running in a non-init user namespace possesses the
> > CAP_NET_RAW capability. However, the patch cited in the fixes tag
> > checks the capability in the default init user namespace.
> > Because of this, when the process was started by Podman in a
> > non-default user namespace, the flow creation failed.
>=20
> This change isn't a bug fix.  This change is a relaxation of permissions =
and it
> would be very good if this change description described why it is in fact=
 safe.
As you explained below, it is not safe enough. :)
I will improve the change description to reflect as I follow your good sugg=
estions below.

>=20
> Many parts of the kernel are not safe for arbitrary users
> to use.   In those cases an ordinary capable like you found
> is used.
>=20
Understood now.

> > Fix this issue by checking the CAP_NET_RAW networking capability in
> > the owner user namespace that created the network namespace.
> >
> > This change is similar to the following cited patches.
> >
> > commit 5e1fccc0bfac ("net: Allow userns root control of the core of
> > the network stack.") commit 52e804c6dfaa ("net: Allow userns root to
> > control ipv4") commit 59cd7377660a ("net: openvswitch: allow conntrack
> > in non-initial user namespace") commit 0a3deb11858a ("fs: Allow
> > listmount() in foreign mount namespace") commit dd7cb142f467 ("fs:
> > relax permissions for listmount()")
>=20
> It is different in that hardware is involved.  There is a fair amount of =
kernel
> bypass allowed by design in infiniband so this may indeed be safe to allo=
w
> any user on the system to do.  Still for someone who isn't intimate with
> infiniband this isn't clear.
>=20
> > Fixes: c938a616aadb ("IB/core: Add raw packet QP type")
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> >
> > ---
> > I would like to have feedback from the LSM experts to make sure this
> > fix is correct. Given the widespread usage of the capable() call, it
> > makes me wonder if the patch right.
> >
> > Secondly, I wasn't able to determine which primary namespace (such as
> > mount or IPC, etc.) to consider for the CAP_IPC_LOCK capability.
> > (not directly related to this patch, but as concept)
>=20
> I took a quick look and it appears that no one figures any of the
> CAP_IPC_LOCK capability checks are safe for anyone except the global root
> user.
>=20
> Allowing an arbitrary user to lock all of memory seems to defeat all of t=
he
> safeguards that are in place to limiting memory locking.
>=20
> It looks like RLIMIT_MEMLOCK has been updated to be per user namespace
> (with hierachical limits), so I expect the most reasonable thing to do is=
 to
> simply ensure the process that creates the user namespace has a large
> enough RLIMIT_MEMLOCK when the user namespace is created.
Ok, but if infiniband code does capable(), it is going to check the limit o=
utside of the user namespace, and the call will still fails.
Isn't it?
May be the users in non init user ns must run their infiniband application =
without pinning the memory.
Aka ODP in infiniband world.

>=20
> > ---
> >  drivers/infiniband/core/uverbs_cmd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/core/uverbs_cmd.c
> > b/drivers/infiniband/core/uverbs_cmd.c
> > index 5ad14c39d48c..8d6615f390f5 100644
> > --- a/drivers/infiniband/core/uverbs_cmd.c
> > +++ b/drivers/infiniband/core/uverbs_cmd.c
> > @@ -3198,7 +3198,7 @@ static int ib_uverbs_ex_create_flow(struct
> uverbs_attr_bundle *attrs)
> >  	if (cmd.comp_mask)
> >  		return -EINVAL;
> >
> > -	if (!capable(CAP_NET_RAW))
> > +	if (!ns_capable(current->nsproxy->net_ns->user_ns, CAP_NET_RAW))
> >  		return -EPERM;
>=20
> Looking at the code in drivers/infiniband/core/uverbs_cmd.c
> I don't think original capable call is actually correct.
>=20
> The problem is that infiniband runs commands through a file descriptor.
> Which means that anyone who can open the file descriptor and then obtain =
a
> program that will work like a suid cat can bypass the current permission
> check.
>=20
> Before we relax any checks that test needs to be:
> file_ns_capable(file, &init_user_ns, CAP_NET_RAW);
>=20

> Similarly the network namespace you are talking about in those infiniband
> commands really needs to be derived from the file descriptor instead of
> current.
>=20
This now start making sense to me.
When the file descriptor is open, I need to record the net ns and use it fo=
r rest of the life cycle of the process (even if unshare(CLONE_NEWNET) is c=
alled) after opening the file.

Something like how sk_alloc() does sock_net_set(sk, net);

Do I understand you correctly?

> Those kinds of bugs seem very easy to find in the infiniband code so I ha=
ve a
> hunch that the infiniband code needs some tender loving care before it is=
 safe
> for unprivileged users to be able to do anything with it.
>=20
Well, started to improve now...

> In particular there was a whole lot of bug fixes and other work done to t=
he
> mount namespace and in the networking stack before allowing unprivileged
> users to use it.
>=20
> In the ip part of the networking stack CAP_NET_RAW allows all kinds of th=
ings
> but when it is limited to only a single networking stack (one the user ha=
d to
> create) it becomes safe.  I don't remember enough about infiniband to saf=
e if
> those parts guarded with CAP_NET_RAW are safe in that way.
>=20
Its restrictive use here as well in infiniband too for CAP_NET_RAW.

> Eric
>=20
>=20
> >
> >  	if (cmd.flow_attr.flags >=3D IB_FLOW_ATTR_FLAGS_RESERVED)

