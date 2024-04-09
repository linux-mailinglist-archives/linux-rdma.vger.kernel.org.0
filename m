Return-Path: <linux-rdma+bounces-1874-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 635F189DD1F
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 16:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869FB1C22E2B
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 14:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96311311B9;
	Tue,  9 Apr 2024 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cfGTeGbZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2103.outbound.protection.outlook.com [40.107.96.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D025745BEA
	for <linux-rdma@vger.kernel.org>; Tue,  9 Apr 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673856; cv=fail; b=BNxoRGoubVt5tErEY8X6LVAi5cJ6Tu5GW2WxtPUSvEN5pM4QxjhbtR2Nt3Z0e/nQk9NfHElUuorswuZT/hM13ORJgDwBmN560tGiWCwQ/ZQzkpM175LXIvl30ABc7b1uuWB54TE1l512D3FgihmdKoc/pxqKLa1bQ8p3pAEhPSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673856; c=relaxed/simple;
	bh=B6ip3vqyyLYHBnLNqP9UHgTxshWUVls7RRE7CGjqu64=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S5UB1IqAOYMV5Lnk4b6u7ebN1aincV1SjhqR1TdlELY5m31lLvbLzv6C6+d503Et0Mqy8nx3P+0FbuJXcOuDUALTQjjkwfi3wLsWGbRuuMchM8faPRR5y/9T8m8aQbJ+ub56/1UHoKcm/e4+MgmmDEFN8agGRsS9Cwa2SpPs9IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cfGTeGbZ; arc=fail smtp.client-ip=40.107.96.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6brcrzpTcLJJ62zyJCuklyMEmsF1HlXzh+b1q1OgDLzO1sYCpk1bY3aPhY8dXZKhy6wOvRLSFG0IXgvkFhrUtjkXcZGaXFJzptEUHUBWIHKQn2QkIH8k7ScW2CiUes+f8WdYMxCThQNOgo+aIoOgr4GvNnjiLUkIBu7PGYIu+NFhQBnneVWPJVj0N8RnukhPd0Lsr1YokK3O5BSodhIdxXPbvv3oHgVe44Ftpzb43W+uNcVkm8QJam/D1/QWn+f3Q9h5k7jjFeeiMUxDPDqH63x/e9jO6FyIM4vFAEpf6WkMARQ3Se9dh1hiLCw/00Cu6xNlgPf5ZMS0ZYOx4IVBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mwwtlR/EavT5OYBEfYZWtIzLwFoB9EzqvIkj0bU03E=;
 b=bY7k8Wjw5xrSM0RAZuugBXZtyh7/bW5w4+PFPjqEL6gPHU/yVSgN0kwY2EbOd1YFV+ePxuXm0+Az9hkX1+AUfHyX4e0K8qqnjPj6fdm6/Dv65/EZvlxls1BRCsdBoCNPwnyVRPcex9pf80C76ox0X1Vcxenkl4TAipogUxOj0f4EX0h3tKfkQQXHhQ+UcmrbFKpiSBmR7vC+9vbcigei1SGPx5i16yby045xdlbkuWPJxGIZlDnHmsP3pDY2w8ruCdSpntoyKtsqaJlAdX4CNKTOOUBUPw+ozMf2cJMN2iEJ6Oe3ajzR87WXuOyxIcr1gBkJoQUVKzhFgKTW66afow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mwwtlR/EavT5OYBEfYZWtIzLwFoB9EzqvIkj0bU03E=;
 b=cfGTeGbZGGjvSP40SEd2dGtEjOtJb7BH4fji0t20RKGVFjMLtBqIRCMQIKq0OfXnGgCT3BLMfgHx3NLdmAgxuky/zGooMVlNeHyN+iFVSznXMXCtGR7g8w2QKVphzw9EdjPd4THsxZGLCxHZPjK2KlDcfm+sQRM8q0xRY2Rq65ryMQRGwHk39a7P5JsXan8pFgbyTvVgpsYyNqTw68kODEaNzO5SO2n0iGpnUonk7SrlFnpgX+CElsEbRHErPbFTHQ+4DtTCNmj/PnPA4Z7fJoW8CbIobUk1mfY9z/uSPQ7bzzliRJSa+EvSKvNjpMVlgMsGwPIKqKAKW5c++bKARQ==
Received: from SN7PR12MB6840.namprd12.prod.outlook.com (2603:10b6:806:264::14)
 by MW6PR12MB8959.namprd12.prod.outlook.com (2603:10b6:303:23c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Tue, 9 Apr
 2024 14:44:11 +0000
Received: from SN7PR12MB6840.namprd12.prod.outlook.com
 ([fe80::774:249f:3cef:6b5]) by SN7PR12MB6840.namprd12.prod.outlook.com
 ([fe80::774:249f:3cef:6b5%4]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 14:44:11 +0000
From: Sean Hefty <shefty@nvidia.com>
To: Etienne AUJAMES <eaujames@ddn.com>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>, Mark
 Zhang <markzhang@nvidia.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "Gael.DELBARY@cea.fr" <Gael.DELBARY@cea.fr>,
	"guillaume.courrier@cea.fr" <guillaume.courrier@cea.fr>, Serguei Smirnov
	<ssmirnov@whamcloud.com>, Cyril Bordage <cbordage@whamcloud.com>
Subject: RE: [PATCH rdma-next] IB/cma: Define options to set CM timeouts and
 retries
Thread-Topic: [PATCH rdma-next] IB/cma: Define options to set CM timeouts and
 retries
Thread-Index: AQHahTm9kjRVWgKBFkKozoFiBcTBOLFehRsggAFuQoCAABHagA==
Date: Tue, 9 Apr 2024 14:44:11 +0000
Message-ID:
 <SN7PR12MB68400AC8ADF1F34DE78140E4BD072@SN7PR12MB6840.namprd12.prod.outlook.com>
References: <ZgxeQbxfKXHkUlQG@eaujamesDDN>
 <SN7PR12MB68403240EAB2777CB5D8AB5FBD002@SN7PR12MB6840.namprd12.prod.outlook.com>
 <ZhU9n-f4Zvjs5NZn@eaujamesDDN>
In-Reply-To: <ZhU9n-f4Zvjs5NZn@eaujamesDDN>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6840:EE_|MW6PR12MB8959:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nsHUVWtJLlNF3u9ET35JP/Sl0hEIHh2ui5VtKwtjkQkLVw3wxqnP4AB0f+5lOnkIQn4WUj3L31hby/ZKFic6F36ccVdGg719m5di+l+eM6mlMnRjed0BsvgqYIT5NYylvqBWF7julwuqJHihXiRh/3mEY+XrdrSh6goM8egCT7cmewG3er18J644DdFLP78tLS6H5wyCCijlu2WnHPsicrErYgALt+fmJWDxXhOoqqKw6E18VF6jXRmzQVPZagvMmb6dKPazFJc/lYtsTMwKnNz6h9F1XDGs0PocXPmPSnKwOyyC/ufhZdIDeX/Dz7KZDoVWym5ect+kWziaVxSvaaa03rQv6pDvLDKfP4Zgng1s0LWMn4WcfnvIjimdhEp80v7qDVl8VSTqlYuti2Ke2LOwKMMgcDYGU+DRKH4F6KQkh3wKVC0VrPds7gkmFQQJVzLviXLZdRLgceJ3XX38Ea2Em/85yiCDvyEfasiahrYXpRg7Q7vUyFX6L4avQworYvnuMRhxo9qTp3b6G/NFJ7UGOgmG8n7NcTvioSu2Q0rlUWJEJsnE4Ue51I8F/apMsqL8SspiDU736ydys8wVPprWVRu+e5/APzdHMSSMVMoukZk87z3uJtccV82/gsKEBgY9jBfhmfiBvHk+UCeVMSSCbx0GcCVJy0DfkRezZ/Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6840.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?opw7SATRdEfqDCYXRcV2enL76T3EFaBpRjZs6HMs1Z2nvOWqYw1sL6iSiGJv?=
 =?us-ascii?Q?xxgz5FnBYgQXJT0Kw4EgzbFUyCxorBzvMzaHY5Unlps3NQapSLRNn/5HmD4n?=
 =?us-ascii?Q?WyuI++QSHMQPVHkuD02BBGVYZF60ZXRqLC5qxoIpCMnR7fbhJabX8dJzTjrR?=
 =?us-ascii?Q?5Y5jRtSX/fRMZ/srNyfZScqXqVaFepyxFlxyuUlwzo7UjlM7GQ02yoMi4nHt?=
 =?us-ascii?Q?8mVzb9aSxjZWPCGBh2umTUTjrb02sx643HU+u8MyWJ3CfD4UQRfzTLLe4lN1?=
 =?us-ascii?Q?+4z1DW5Ug5PRotgxADXxuLO5OwHD7Ir393bfc5jdLTGQ1USsXVlOqnWK5LsX?=
 =?us-ascii?Q?2xubI9pAojfnSvfLDKimUUSdl6IoBluMyNWQ7aK+dONlDAu7nF6OBt0kD43E?=
 =?us-ascii?Q?gPElXr+J4+SnfYHY0QAg6rq9kMJ7wr6d3dMB6FORpCFh78iobEXZHuREQLT3?=
 =?us-ascii?Q?IQfjrACEQ5pxwgm2EHqzuONM4vnMWf3VJzTHR/xCqV0U21ZnOyFt4uLTU2YP?=
 =?us-ascii?Q?FLRoGkxslJPVxg3DZ3KWjz9olaqd8kzbyg1jWj3Rmvcl24mSWSNIl7EAlcot?=
 =?us-ascii?Q?nNpk/1gAMp1WIWg3qgg6WHabm2hfjwl1jOPXfaWwt/armUBq8XvKA/4IUuLJ?=
 =?us-ascii?Q?YYdNUTuJdwuJaEQ/XZYdI2LQ/0teY3HfT0+zy2kgRBwa47ky1zKKG559J14n?=
 =?us-ascii?Q?rSYZuW1xg7SJxE8IcSMTGiu8oFaTQTqVUVyTs5MItIWVlcJbZJNAsdmjJuKj?=
 =?us-ascii?Q?m5J2a6Xu0UO/PZ5rYTm0t/4KGiJ0wfJSYiyHXch1sV51aUBk1AosZmOX/YWg?=
 =?us-ascii?Q?zZ4Qp/7qfO7Vj6EfX663c10QbWSXcbo2fKMJHHZUViFMhMaVQm7o4LlYqiUM?=
 =?us-ascii?Q?XEZkGrLHw4rG1ldUgVcw4g9cFmwfjJTQtgj3pGQCPZzWOnqVM4UiHRsSRfdc?=
 =?us-ascii?Q?/06Mjly6FgZJfL4jbEA6eXAwV1/y1hGGtpZltpnzqxOWB3kndQCYmM0sOBZF?=
 =?us-ascii?Q?80nPFLU+L05WmyRk7xZ368thA4B96mAodEsjeKpBRTR+qJt5abuFckKjyzxp?=
 =?us-ascii?Q?xHK5KUeO87xP0MUGWhzpVPXjrkwZQkwhnjy0kOTmfRL5J8+rsA0hmHJT5gys?=
 =?us-ascii?Q?aJDTIcwiRyZnsTNOrbZxm45ZVbqaWVqEdnRd/qyrIXmptWMt10JyEgVMLGRC?=
 =?us-ascii?Q?bu7JJ+TcWl8T31PCioR/xcC1WIG1CyGba0r9NJyXP6G9O5G2o0IC5m60c13w?=
 =?us-ascii?Q?j2/xhDgUfwkBZwcuSeYNsIG8TG4P1Y/gbFJKKQulFVTvfP7d1H7vuAj87Rb3?=
 =?us-ascii?Q?BWItyNL8xTIloohHzMlPl6n9epHsc1Nip1gMUZJD6ANc5OLG8mxtEpEUATz5?=
 =?us-ascii?Q?LOuZhrnKTX18079EGtUVS49MWkKjV7VmtbopqwZBl1aL8nC4aC1jDOklrus+?=
 =?us-ascii?Q?P5sIln378tXDW+DsAnS2AvlmKUuQ8wPTq55JmP/yw+dbYDnFOnggeDELwg1l?=
 =?us-ascii?Q?96D+e7hONljTPY2fUamGlzn9cwCWaNdVQ6RQyYK5fy5GANbwL8She9Ll7GET?=
 =?us-ascii?Q?CoTm2X1RoJLNaEgCwak=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5527f9f-1654-4586-9935-08dc58a38509
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 14:44:11.4383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cMS2TQ8VYKJ5q/vhEjHNuZfMGbyrQtcvMqRxmzzvET7c+/a5smnEoRS1zjQ3bT/JLsCnzMmN+YrL5lHo8pgBhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8959

> > I was thinking of aligning closer with the behavior of the TCP stack, p=
lus a
> couple other adjustments.
> >
> > a. Reduce the hard-coded CM retries from 15 down to 6.
> 15 retries is the maximum (the field size is 4 bits). According to the
> documentation that I read, there is no minimum retries required. So I
> don't know why this is statically defined to 15. Maybe this is related
> to hardware interoperability/compatibility.

15 is the max defined by the IB spec.  With a linear retry timeout, setting=
 this
to the max can make sense.  But if we switched to using a backoff timer, I =
believe
we can get by with a smaller value.

> > b. Reduce the hard-coded CM response timeout from 20 (4s) to 18 (1s).
> The NVIDIA MOFED set the CM timeout to 22 (17s) instead of 20. This
> makes an overall connection timeout of 5 min for an unreachable node.
>=20
> Some patches seem to argue that 20 is too short:
> https://lore.kernel.org/lkml/20190217170909.1178575-1-
> haakon.bugge@oracle.com/

A backoff timer can reduce retries.  I don't know how you decide
what the initial backoff should be.  I was going with what seems to be the
behavior with tcp.  Maybe the backoff adjusts based on IB vs RoCE.

In any case, a 5-minute timeout seems unfriendly.

> > c. Switch CM MADs to use exponential backoff timeouts (1s, 2s, 4s, 8s, =
etc. +
> random variation)
> > d. Selectively send MRA responses -- only in response to a REQ
> > e. Finally, add tunables to the above options for recovery purposes.
> >
> > Most of the issues are common to RoCE and IB.  Changes a, b, & c are ba=
sed
> on my system's TCP defaults, but my goal was to get timeouts down to abou=
t
> 1 minute.  Change d should help address problem 2.
> Please notes here, that we don't hit this timeout issue on Infiniband
> network with an unreachable node.
> Infiniband have a SM, rdma_resolve_route() fails before rdma_connect()
> for an unreachable node. The SM returns an empty "path record".

I guess this depends on when the node goes down and how quickly the SM
can identify it.  But this does suggest that having separate defaults for I=
B vs
RoCE may be necessary.

> Maybe there are some other ways to mitigate that RoCE issue.
> For example, when I troubleshooted this issue, I saw that the RoCE HCA
> received ICMP "Destination unreachable" packets for the CM requests. So,
> maybe we could listen to those messages and abort the connection process.

Hmm.. I wonder what it would take to do this.

> > If the expectation is that most users will want to change the timeout/r=
etry,
> which I think would be the case, then adjusting the defaults may avoid th=
e
> overhead of setting them on every cm_id.  The ability to set the values a=
s
> proposed can substitute for change e, but may require users update their
> librdamcm.
>=20
> Our particular use case is the Lustre RoCE/Infiniband module with a
> RocE network.
> Lustre relies on "pings" to monitor nodes/services/routes, this is use
> for example for High Availability or the selections of Lustre network
> routes.
> For Lustre FS, a timeout superior to 1 min is not acceptable to detect
> an unreachable node.
>=20
> More information can be found here:
> https://jira.whamcloud.com/browse/LU-17480
>=20
> I don't think that most users needs to tune those parameters. But if
> some use cases require a smaller connection timeout, this should be
> available.
>=20
> I agree that finding a common ground to adjust the defaults would be
> better but this can be challenging and break non-common fabrics or use
> cases.

IMO, if we can improve that out of the box experience, that would be ideal.
I agree that there will always be situations where the kernel defaults are
not optimal and either require changing them system wide, or possibly=20
per rdma_cm_id.

If we believe that switching to a backoff retry timer is a better direction
or should be an option, does that change the approach for this patch?
A retry count still makes sense, but the timeout is more complex.  On that
note, I would specify a timeout in something straightforward, like millisec=
onds.

- Sean

