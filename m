Return-Path: <linux-rdma+bounces-8579-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E82ABA5BF0D
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 12:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B9518999FD
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 11:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892AC2343C1;
	Tue, 11 Mar 2025 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D7Cat2mb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4876D227E8F;
	Tue, 11 Mar 2025 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692734; cv=fail; b=SWt1bunJ+a2Xg6sA0nmGePKt8Z7pS8ckzFYQoUwtOPJnOppIQHJHwThKW/QPlEStS/uhwj2koOFrV1VxeD8og+3MhVYq1BxkOTiBPu8VHb8hSbVeFJ0Z0+DKznvLWJBqFL2Erp+WNjNsGa/WNYcsAqWtRJY3/Ue6u2a/rbKrWvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692734; c=relaxed/simple;
	bh=gJsARza6SeVPDS7IFQ5fzgOkYvKksUrlf4Jpyh99h9U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KM9aynTIhK2zc5zIgytAuFxv4JMxLMdimTC+9sIlbVLN0Qu6G4WFu1EaMzhNprHXg4KyFQ6cZqiLbKup/QFca2U5mVz1w0QJy+RFuTZcGf5mDTNsKzfNouGILW7DRUTTW5Swh6ZchiUg1iulz6ldLKKAKpOJUjGXfWhb0g/tXPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D7Cat2mb; arc=fail smtp.client-ip=40.107.101.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COo9KghzNP7Qs0y9jb4jI1BCjFlreaqPXVUMUs61P9NZikKGYeQ4JyNOecfFnidaMO7J/xgtk09lxz7otKd8RW32JCyNgCa8CePS+8iS7YJgJPFsmWX65gTQ72eNkQ6Mz4+sESqz+F7HgQJBV3WQMVmdGgkbg8ESYyvZoJbutEtAwKSZ1kGjSNcQpTGTTfZrkPSEMnHgTwUci9nRmayMsOV6j3bAPIvVV3cggp8w29UCXD1jVc8l1gYDuN9yoabUkQjEn4rUKxxdRHdHaioQraaGAk8GYqA+aVesnxC1d2oUuebZQ/AlCQdlho/1tBQvre69idJeHSUJX6Gg3e+NOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/mlfDi14UZRhllRluE4T6RY40kz8ePtxoTnAiL8Iv0=;
 b=jBd0fuFiLVRmkxkXuH135tzpB1RcBXCadx8t2a2h91Th+362IyckxxFKVLdUe8D4unyLoK/M8HowIHq9uG2di5fDbT3SoQgu6QX/jMi52qYxnzD7UIu8L9vLy7NV+4aH3AgLrPWVF3ph4Yth9uiH+AsQNs7HWASQ0AIpvGlyaNR7CcOC1xAauvIBaYfDo7zRp0ebvLrnLKQFK62Fjig82AAhUKbwT7w18jzPZAzA/c5VQqFRcCPfAgDS83ZKmm5YhyXaX/O9cNg3uJWvesKKe1r59E5ziBTtbIck6mf3y8v9hK2zdNjqvMyGrMB6oyuiRigLeYuwKO5KEE9TM/em5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/mlfDi14UZRhllRluE4T6RY40kz8ePtxoTnAiL8Iv0=;
 b=D7Cat2mbjAAczdjvwUlA92aEcHXoYDz7mDio0P5BiUy/DYjk3TLnKqIOzBIJaj7Pcer0ZwOnfN9I3W29uXQTIKtdU0vdln15wpR9KMx+gSLwXrsgZs3tIN609DEzFeGRYlfz5+KxlEqMZMFuHN0z3vZHVdLKQZxFeWWvQZjhPlsryJBIiPZaomZOmSOV7+Avp2ODwR4lrb+bFNR9cmKhJ9t17JRHr6Jhqb+1KHP8r6ViNFUXHtyf05CG2hHvAXFWyvanjAa74Q281gtbO6+mowqfXK4EhJZV5Gm1yNVDbVDuub2Z7rseAM88ATlo7f1nrXFobL0GVVWxslG7A9JsMg==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SA1PR12MB8843.namprd12.prod.outlook.com (2603:10b6:806:379::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 11:32:09 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%3]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 11:32:09 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>
Subject: RE: [PATCH] RDMA/uverbs: Fix CAP_NET_RAW check for flow create in
 user namespace
Thread-Topic: [PATCH] RDMA/uverbs: Fix CAP_NET_RAW check for flow create in
 user namespace
Thread-Index: AQHbkFTRRtO5IbAuVkaPsNDNMM816LNskpaagAANjsCAAA+cfIABIOEw
Date: Tue, 11 Mar 2025 11:32:09 +0000
Message-ID:
 <CY8PR12MB7195D5ED694088E24159575ADCD12@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250308180602.129663-1-parav@nvidia.com>
	<87ecz4q27k.fsf@email.froward.int.ebiederm.org>
	<CY8PR12MB71959E6A56DACD7D1DC72AC8DCD62@CY8PR12MB7195.namprd12.prod.outlook.com>
 <87msdsoism.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87msdsoism.fsf@email.froward.int.ebiederm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SA1PR12MB8843:EE_
x-ms-office365-filtering-correlation-id: c9e2bfe4-6b1c-46f2-ebc4-08dd60905c0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2t9QiOawCCsnpjG5H3PeGd7mzZQfaOGfJjVF0jFZUwXOWz7VcxBBCZ7UVcBt?=
 =?us-ascii?Q?MfFtUbOo7wK3/jYJrtdFV5m9Z02tb7Aw7HWBcYzs04fwNlFnRgCH+Kdh+8Aw?=
 =?us-ascii?Q?YJ6kpsY/TCcNWVvVBYOwdNyp9xjHgUde3EwXWk53QU0Hfg/seYih0tFB1f8U?=
 =?us-ascii?Q?j0/Fq/RBdvvJH2GJCA3mObbaZXMu8tzAAWgsnqXVHSetnaPA/0ffufb1AYRC?=
 =?us-ascii?Q?K+Wq6WaN2D5CFpES6/k1n+uCZAovowBjOrtFudLiNd0l32w2dQWFVUDNi80T?=
 =?us-ascii?Q?BakV3VqgUYXUkZNZX/RhvlhP+uneUaDOR/jjVgIZRmU7u4Pe2ZSQDJMdo1rB?=
 =?us-ascii?Q?2B50wojzZ18bOngRr3qG3NjxrHA8kTVGXSeJMJrcnzXXJWerRwPSOkfltcwr?=
 =?us-ascii?Q?/4Y9nMmN0s2h5vpfshsU8ss9AT912YCc5ClBethfjQVmAgvXRXApLICMwL3F?=
 =?us-ascii?Q?DPjxTo0JW3N7eoVxcGDboPWw5iNvMtyswkVjHcby2Gv/Bna0Z5+tBwZdhD6f?=
 =?us-ascii?Q?/nuLqkAlXmG4Mp2RrDfXNPbdXcLJzaaLqO8ZA2NLegziDFm/IyB78tTaWY95?=
 =?us-ascii?Q?lPo4q0Gzg7xqpJVsEzXq+gRReI+cf3GInUjlv2UkzFWrJp2gxFbl1LhvFBFM?=
 =?us-ascii?Q?Eq6QoiFMIXI13TWTHVOBg9AQSsYze39Mu/gZL1Bd3Z4dgyOqDVPtwTi4IgOf?=
 =?us-ascii?Q?hRqad4r2V8ZR+Jh+tHZlT1Dh91DKqWF1oJL3Q+G8S/+D5TE0NYoJRY1U3raZ?=
 =?us-ascii?Q?cWGbxqZ+Iogtoh0+1Rtpj5NfMoukzQ5Esr5Zlwb3/rr4fl2W5JyEy44yY9c+?=
 =?us-ascii?Q?St3gOxFaO4Bt5A0tkibAPPMkEc2HSku2d/4ZGZi5NeCPJ8FV8B3BzJkx4MTw?=
 =?us-ascii?Q?d4FXtIdNaLwaVR+oXg5wRzRnuk9Gr3Gq8s10K20AEzHQOV9jBFjEkRHliVDS?=
 =?us-ascii?Q?ILM3SQoknHU8CIhd+7PIYlDpD5S0KxHVlqHQRSATUsRdfvWbGwj78AeJuUJO?=
 =?us-ascii?Q?XXuZu20jca0lOhn9CA5eqsRfYxHKZVWIr64TQfOPxDP3xK3w5GiWGEp6Teve?=
 =?us-ascii?Q?N+lywSHIFg8pvMLhzMjABQ97ACnBymFXsS/yC/yzY4pufKbi7H5uyNW9KJf1?=
 =?us-ascii?Q?G8qaxMxRKsXFGsgQXfyKuNM+DCXwme757aAHv4u16H59lHUqEnL74giNN1b1?=
 =?us-ascii?Q?xQpuwZE0NV+nuAH4WJB8KFQqgf/7KDjAulFtTmM14rBienu8ZEbaRTdJxdBi?=
 =?us-ascii?Q?bmsQpiLpO3BnKpu2ZjJmmttOBXwtXhXy3xE/W+pUbFDAumdl8YIGT+7QzhFY?=
 =?us-ascii?Q?0jn3zemg/u0cYwGMG/KMWpZx4AqyWP+YAIOu2v48TeHylBzUXbh/1Dr8HO2Y?=
 =?us-ascii?Q?UrNyNRUdjSV00lkifZSEneIFm3sCP9/k7UtbLpWOOIkjYwDb2vydj5gBdXd5?=
 =?us-ascii?Q?7iYvzTmKExR4GGnahrPNnrc160bgFN5Y?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wWKrS9txsFnq+K75MOzcwA7yWtz6WMCCI3vAmNS2msL3Y7kH34ZZrLWEy26A?=
 =?us-ascii?Q?OCK5fj0wFhFok1FiUb5psKFU84+GA1nLCS/AhHgaf4158OryUSshxO0JWwIF?=
 =?us-ascii?Q?f8xPPBGf6wtWfc8sXkOAwyndTv/uhUgplW8h1cymC7rvmGvZ1s8AcssTXQ7H?=
 =?us-ascii?Q?SoX4NtQYKivjA89uYdXtM6zAOB9FwNcWINWp7Nr+cjSSyAOILqiBGu6K6o+D?=
 =?us-ascii?Q?8FRRWvwndgYQ/ZrGuPfEDM81MynHLkaQuvpajeIQ0JWLSdnrA3PHCi7T8Fg+?=
 =?us-ascii?Q?e77dRSzQbSfkW1NUSdT3r3+fBPm9ZKxhPF02C69HGtCIJwy14ABPHfZjAlK8?=
 =?us-ascii?Q?PB9HVoC13svNuUhjSGXDQWxIM8NgnymCwEshgYlWBWgwApQ9jlkF+I0a0Ir4?=
 =?us-ascii?Q?MvfkvJT49/OdiPLA4X88QyL4L0bzXSS5I4X+G4yfzpeqaG0vqToLMBx1gLx2?=
 =?us-ascii?Q?IcPVttMpFGjBeUhTKLAALdJoN4JCdP/geruRjVr4oF+7y3qdJL2LEziWX6Bo?=
 =?us-ascii?Q?2SENjFo6t4Is8NfsbcDoWPcIKkeHyossougnBQGUkAbArqqQXJMvUU6cr7Ms?=
 =?us-ascii?Q?zuQrwaQ7gzVILWiuuxh/4L7EHxj5Ro8KTUqW3g+zupTdzgjtRb4XtLxlkHr8?=
 =?us-ascii?Q?rqGGxuVFpgcZdqmPYD3aHAAAhMK5y7jKkkxiwf70dZGjJCAH6ocmPsIrA80G?=
 =?us-ascii?Q?a8Tf+ZNajDIiQl3kmxC9Gtd96w8FkZ4wSlJAFdmfJ0xUZvfgzTDIZNpS0DEy?=
 =?us-ascii?Q?4gCkbfrVnc9d31U/BStfo3jRCjbzHBluzsqiNkkmfHUuDMpkNxdNLLBO6HZU?=
 =?us-ascii?Q?L4yqseFmX+Hcrh6eL0ryPPfkLUIVpagZjLTbH9/zdrRAFryc6KnDtiYiXYlZ?=
 =?us-ascii?Q?/LcQAientR2Kbl/26/ze8lU7zEc8IWXXBsbtmSvi/p58bCoq83LYPmIeMFZu?=
 =?us-ascii?Q?VKK4Oa+Wg2vlu1supczkr1WJoddn6IejXSh6jjSKCRSJn1UQ/7RMXrx+3GtQ?=
 =?us-ascii?Q?Ai/4BSOBMCg13JXvMD8g0QlcbdZSbS9RDpoZRyr5a18d/4xLNWHOhtZj/j89?=
 =?us-ascii?Q?uTwopAFbDOPZo+zsnMOatR6C+dpI/u4d8RTPbUEsC/Le3GUO0JP6Oo0Stk5j?=
 =?us-ascii?Q?YNafOTMtiaJTD2CTeLte+7SHl5to0Msaasm3aZHVhoFblT+FeEzgJuUQH9Ub?=
 =?us-ascii?Q?YgeuOTCuvTcl31lRvkDjhg2HeyHemT1a3u8fBxEAxqkdvrbuTinZgO8YCzRL?=
 =?us-ascii?Q?QdHYno9K1oU7Ht4Jg1QZvRmjCUJ11vbMCxnfqJex4usBjSLAnAQE1/Udw8hI?=
 =?us-ascii?Q?jlFNp+w04pIkPg+KuZfKBM+K2uKnxV3dtw2DYvMbEDiuyiyc74G4V2f0eJoB?=
 =?us-ascii?Q?4YjU+FhEm6Y8cw0iM38oqiNhRBt4HjWVkvtMKQvKDK8djbfZvlduRlh3YiHJ?=
 =?us-ascii?Q?uql+KyXYsnVXP9eDEPVK/pxCel3vZ0tPRftDwScRA2hryKlDRVn28dfqp1Vt?=
 =?us-ascii?Q?s95DKI14rpE95u6xVyP53mnqlgBTpCSF5r9A5qMPEFU1dtxpk256aSSe0HK2?=
 =?us-ascii?Q?DRTC7ShSkQrtUUfMg0o=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e2bfe4-6b1c-46f2-ebc4-08dd60905c0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 11:32:09.2171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4YPxyyel2K3JwvvDMFhDq2Tguld5J1euByRoRJ1p0v8bHOHJsB4+0tIYcph8718HMN77O28N3k4ZLYfRLJs4nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8843


> From: Eric W. Biederman <ebiederm@xmission.com>
> Sent: Monday, March 10, 2025 11:44 PM
>=20
> Parav Pandit <parav@nvidia.com> writes:
>=20
> >> From: Eric W. Biederman <ebiederm@xmission.com>
> >> Sent: Monday, March 10, 2025 9:59 PM
> >>
> >> Parav Pandit <parav@nvidia.com> writes:
> >>
> >> > A process running in a non-init user namespace possesses the
> >> > CAP_NET_RAW capability. However, the patch cited in the fixes tag
> >> > checks the capability in the default init user namespace.
> >> > Because of this, when the process was started by Podman in a
> >> > non-default user namespace, the flow creation failed.
> >>
> >> This change isn't a bug fix.  This change is a relaxation of
> >> permissions and it would be very good if this change description descr=
ibed
> why it is in fact safe.
> > As you explained below, it is not safe enough. :) I will improve the
> > change description to reflect as I follow your good suggestions below.
> >
> >>
> >> Many parts of the kernel are not safe for arbitrary users
> >> to use.   In those cases an ordinary capable like you found
> >> is used.
> >>
> > Understood now.
> >
> >> > Fix this issue by checking the CAP_NET_RAW networking capability in
> >> > the owner user namespace that created the network namespace.
> >> >
> >> > This change is similar to the following cited patches.
> >> >
> >> > commit 5e1fccc0bfac ("net: Allow userns root control of the core of
> >> > the network stack.") commit 52e804c6dfaa ("net: Allow userns root
> >> > to control ipv4") commit 59cd7377660a ("net: openvswitch: allow
> >> > conntrack in non-initial user namespace") commit 0a3deb11858a ("fs:
> >> > Allow
> >> > listmount() in foreign mount namespace") commit dd7cb142f467 ("fs:
> >> > relax permissions for listmount()")
> >>
> >> It is different in that hardware is involved.  There is a fair amount
> >> of kernel bypass allowed by design in infiniband so this may indeed
> >> be safe to allow any user on the system to do.  Still for someone who
> >> isn't intimate with infiniband this isn't clear.
> >>
> >> > Fixes: c938a616aadb ("IB/core: Add raw packet QP type")
> >> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> >> >
> >> > ---
> >> > I would like to have feedback from the LSM experts to make sure
> >> > this fix is correct. Given the widespread usage of the capable()
> >> > call, it makes me wonder if the patch right.
> >> >
> >> > Secondly, I wasn't able to determine which primary namespace (such
> >> > as mount or IPC, etc.) to consider for the CAP_IPC_LOCK capability.
> >> > (not directly related to this patch, but as concept)
> >>
> >> I took a quick look and it appears that no one figures any of the
> >> CAP_IPC_LOCK capability checks are safe for anyone except the global
> >> root user.
> >>
> >> Allowing an arbitrary user to lock all of memory seems to defeat all
> >> of the safeguards that are in place to limiting memory locking.
> >>
> >> It looks like RLIMIT_MEMLOCK has been updated to be per user
> >> namespace (with hierachical limits), so I expect the most reasonable
> >> thing to do is to simply ensure the process that creates the user
> >> namespace has a large enough RLIMIT_MEMLOCK when the user
> namespace is created.
> > Ok, but if infiniband code does capable(), it is going to check the lim=
it
> outside of the user namespace, and the call will still fails.
> > Isn't it?
>=20
> It depends on how the check is implemented.  My point is that
> RLIMIT_MEMLOCK has all of the knobs you might need to do something.
>=20
> I don't know if the checks you are concerned about allow using
> RLIMIT_MEMLOCK.  Given that some of them require having root in the initi=
al
> user namespace they might make a lot of assumptions.
>=20
> But rlimits are related to but separate from capabilities.
>
Ok. I will take this task separately.
=20
> > May be the users in non init user ns must run their infiniband applicat=
ion
> without pinning the memory.
> > Aka ODP in infiniband world.
>=20
> That sounds right.  I don't remember enough about infiniband to say for
> certain.
>=20
> Basically anything that uses ns_capable should be treated as something an=
y
> user can do, and so you need to watch out for hostile users.
>=20
Got it.

> >> > ---
> >> >  drivers/infiniband/core/uverbs_cmd.c | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/drivers/infiniband/core/uverbs_cmd.c
> >> > b/drivers/infiniband/core/uverbs_cmd.c
> >> > index 5ad14c39d48c..8d6615f390f5 100644
> >> > --- a/drivers/infiniband/core/uverbs_cmd.c
> >> > +++ b/drivers/infiniband/core/uverbs_cmd.c
> >> > @@ -3198,7 +3198,7 @@ static int ib_uverbs_ex_create_flow(struct
> >> uverbs_attr_bundle *attrs)
> >> >  	if (cmd.comp_mask)
> >> >  		return -EINVAL;
> >> >
> >> > -	if (!capable(CAP_NET_RAW))
> >> > +	if (!ns_capable(current->nsproxy->net_ns->user_ns, CAP_NET_RAW))
> >> >  		return -EPERM;
> >>
> >> Looking at the code in drivers/infiniband/core/uverbs_cmd.c
> >> I don't think original capable call is actually correct.
> >>
> >> The problem is that infiniband runs commands through a file descriptor=
.
> >> Which means that anyone who can open the file descriptor and then
> >> obtain a program that will work like a suid cat can bypass the
> >> current permission check.
> >>
> >> Before we relax any checks that test needs to be:
> >> file_ns_capable(file, &init_user_ns, CAP_NET_RAW);
> >>
> >
> >> Similarly the network namespace you are talking about in those
> >> infiniband commands really needs to be derived from the file
> >> descriptor instead of current.
> >>
> > This now start making sense to me.
> > When the file descriptor is open, I need to record the net ns and use i=
t for
> rest of the life cycle of the process (even if unshare(CLONE_NEWNET) is
> called) after opening the file.
>=20
> For the rest of the life cycle of the file descriptor.  Don't forget that=
 file
> descriptors can be passed between processes.
>
Right. We have seen increasing use of this in rdma applications in recent y=
ears.
=20
> > Something like how sk_alloc() does sock_net_set(sk, net);
> >
> > Do I understand you correctly?
>=20
> Yes.
>=20
> But first.  The permission checks need to be fixed to use the cred cached=
 on
> the file descriptor.  So that the permission checks are not against the c=
urrent
> process, but are against the process that opened the file descriptor.
>=20
I am fixing this in the v1.
Was trying to find the subsequent patch after the fix on what things to tak=
e care of.

> Otherwise a non-privileged process can open the file descriptor and trick
> another process with more permissions to write the values it wants to hav=
e
> written to the file descriptor.  Usually that is accomplished by tricking=
 some
> privileged application to write to stderr (that is passed from the attack=
er).
>=20
> Most of the time you can fix things like that using file_ns_capable.
> Other times you encounter a userspace program that breaks and something
> else needs to happen.
>=20
> >> Those kinds of bugs seem very easy to find in the infiniband code so
> >> I have a hunch that the infiniband code needs some tender loving care
> >> before it is safe for unprivileged users to be able to do anything wit=
h it.
> >>
> > Well, started to improve now...
>=20
> No fault if you haven't lots of code that only root could use no one take=
s
> seriously with respect to security issues, so it tends to be buggy.  I ha=
ve
> cleaned up a lot of code over the years before I have relaxed the permiss=
ions.
>
Great feedback, thank you Eric for the direction.
I will roll v1 for the fix you suggested and utilize that same infrastructu=
re to honor the non-default user ns.
=20
> Eric

