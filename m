Return-Path: <linux-rdma+bounces-1916-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA78B8A1D9B
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 20:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B0A1C24407
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 18:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3061EB1C5;
	Thu, 11 Apr 2024 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rOhrC8Tg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B541A38C9
	for <linux-rdma@vger.kernel.org>; Thu, 11 Apr 2024 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855744; cv=fail; b=OkjMkRR6rQ5V7hd7zXqfwvi+QVJFRdRqhWTKpxZdzRNoTij+4i4Nk0X6hccsBIW8HOhn2DpKDwc7iP3bDlz4+EBI9tVjhNnQFbG5ZvOT4ddJgp1E8CkbRvwLzkQifQYufW29T8uWWXecfCmCKOhVzjI84rZJqwSlg1CVjn91a50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855744; c=relaxed/simple;
	bh=1z2poBK2/w+nzf0VyMgBl3NR8f0sx+k8WvxYi4puZ0k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SYba007n/EIn+Z5H8b3Zu9CwqpIGX9FnGcVY66WbY+cdpMjqhc0zewUr4XgDHt1arRovHXWsx1/YrvlUh2rtFv0q8HTUcmjU/QHrHTNLHtRJAAriKXptbiH8QalyRVZ7lgALJXBc16QMVIlrVW4GC2tC+9yoRMd6MXlmlxh2rlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rOhrC8Tg; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knCvdgAZqcM3GUTE0W5CoPWW4Ui073ImogXOP1GQxfJAMgeQmTQB0M/PE9ZKqoND+p7KfQEgdvv7nZZXspc6+ep/jQB4hQyQurffj6Duu9TgNfpMu/Sb8DhmeBFThLBXYuL/BHl4wVO5VXJUxctMcWZBYPsdQf2ycCNjDZBj4LjPFN49UQSyS+Kp1xNLuFtxPK1mJaYMpYt7MGc/9GigeaxGI0x1AD5gfir27DlYxfyU6DJWCpZQVgIahCIhXKXnoOe/JxDsudCDZi7+aDBhWhDlOyw+901T7Ws8IQ6ph8Il6kTICJJ4o/GnzyHPYrigBeM1DNVEva59sbh62PHb1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFY40m8Ec/1OHPXeqiYEjhTPJXuQNVayTTvQNO9P3Os=;
 b=MN0QGBUhv7AeUhGSzEJWFojiOZ6QJDO6zVZjkQAIjwk2D8c4p28G6VWIYDtZOx7dWpmWlc23MtqMIU+VNlvjnWyN+9+BuooRbe2ZFYPTHJi8bE3a7wpDC9UPBCE5XKevvkrnSwNGyzitFJvF4dJLg1DpGit/9IUnbY1miTjiF05NOj2uFvx2bH+WW8lTxFpIk6as89W+rOQCRozAa4g+X4g/AXqVq7J9ss0JNGatsoqWsIAwpLZ6o4+E2akQ7jvpjJcQToQQGShw/v1Xfn6S9KuccCr0qbVdLy5Y30YzSYXOs/EvJ+jyqMfHrhVkhoJq8VVptPOW1IMHH5pA55IdRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFY40m8Ec/1OHPXeqiYEjhTPJXuQNVayTTvQNO9P3Os=;
 b=rOhrC8TgEomBUyJLuubc7Zw4grC10JSr8DJ+qfAbr9dGO8IkzRcQkuyzCPhFzDjb8ale2HAKT3NASKt60nrN/Iogylt0KW7Y9C0pQpjozomylmubnD6Yykno8KtcpjJBtnX3OoYCKpBkLHsI+h2I30okjMPy400FWN748VhruAubQbTd1IB80uVQI8ig5sA+zPwr6NaCphUXuoIkKgpSKUhXMTZ5uv7dphM+aW6Jw3YDviHjVexl5EYfg38xqOYa+mL7ChERHtlE1UTFmZgerZ9aSI48sUZIY1uNPYAfep5mXQhd9SN0Yk4zFoN8bJRMLfAg5iF+Sj54nQcH9Glrvw==
Received: from SN7PR12MB6840.namprd12.prod.outlook.com (2603:10b6:806:264::14)
 by DS7PR12MB8083.namprd12.prod.outlook.com (2603:10b6:8:e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 17:15:39 +0000
Received: from SN7PR12MB6840.namprd12.prod.outlook.com
 ([fe80::c07d:14d:c611:903f]) by SN7PR12MB6840.namprd12.prod.outlook.com
 ([fe80::c07d:14d:c611:903f%4]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 17:15:39 +0000
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
Thread-Index: AQHahTm9kjRVWgKBFkKozoFiBcTBOLFehRsggAFuQoCAABHagIADRB8AgAAQi2A=
Date: Thu, 11 Apr 2024 17:15:39 +0000
Message-ID:
 <SN7PR12MB684079A72387EFED4117AA55BD052@SN7PR12MB6840.namprd12.prod.outlook.com>
References: <ZgxeQbxfKXHkUlQG@eaujamesDDN>
 <SN7PR12MB68403240EAB2777CB5D8AB5FBD002@SN7PR12MB6840.namprd12.prod.outlook.com>
 <ZhU9n-f4Zvjs5NZn@eaujamesDDN>
 <SN7PR12MB68400AC8ADF1F34DE78140E4BD072@SN7PR12MB6840.namprd12.prod.outlook.com>
 <ZhgJ_F7DEV_IttN8@eaujamesDDN>
In-Reply-To: <ZhgJ_F7DEV_IttN8@eaujamesDDN>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6840:EE_|DS7PR12MB8083:EE_
x-ms-office365-filtering-correlation-id: 48c43522-fadd-4429-992f-08dc5a4b02ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 B4w9NwR+SlUge0Yg4s+97dFe9OApTaiU2Z3bEhQdRPABsBzXf258Rr2nVApEy8IELM/RA3zychMVJ3uJJrv8Y0SvAYTw7kYQODMX7Qh8yQCyNxkNsdb+hjsqQrTuHtsg0d6D4rJnghuwI8K4rrE0GQVdZHi777LKSuh9BWGoSRok/6U1fyPdqdd1uHbdld1PaXwkZ0DSfTa7NdfJ+NJo5cjGUmJG9DWuL2wHBetizTJ3dChPz8wukXjRD7ucVzY75AVPudJ0IsvglwV02g2ieYQmB1Z0Bk0eeOBsHIeS4ypdHi3GeVHd4afZCuYe8Xo2LyZRMRfnGpAVqvmZ7slAat+m8SWAiAYJ+vRdqaZ+PuiB1U9T24RPwUNnPcHBEh09wh1KgSyo1YWcQb/Zv9SyQo9Q6/HcEpCZ3AjsYmB2i34mnLlyuiTwXxd0OwLy7lypOu4yEiK3SUoOpiva88VrTo0rQ3rWaWUMpT32EaG8M89ejIa8ItPSKK8byxBDTQDK+o3BSp404PWeeoIjqEf05nIMqTrR4kiZZCSBEuHAayVbp4/OHUBsHSGyIHghd7UGNFhirImya5BIYh6bGNezshmiHaQBZ1IgZ3XNPnAVQWUvM2r02hxwqQdFpSfDiurd/tOdcFzSuKGecKEoDP7UGW69VCXm+Bym0SCnrH8lvcgzlgCRDZx55VZSDr4XoYCGwqIYdXsQ2JdD1mRZEGrLhvF5+KFvdZo1l01nopBKaWE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6840.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Mmo426oIp9YDGU9DTG9mzUfF40d/1oi40ebNgMvamgKPFy4Le75Q9d45MCwd?=
 =?us-ascii?Q?BDFbyBJTeYzTRoWRYMBASFop9ikjMAkJvAiV8MZkmFNxaWV/UYl6TYW/oDTW?=
 =?us-ascii?Q?gx7qeCsyyyo/7tdQSWa/FiaF1280cB2wAFxtvVIOElDneKQ4cjY1NoZKM+tF?=
 =?us-ascii?Q?hSpFvxcvDiOjwATVR8n2bSNTS1b8IRbpbvxNski/wramN3mW6249QN6bfs4a?=
 =?us-ascii?Q?kpkypCg/drA8y4/QokTt2kKD40/HEbeG8fJXEZWYKFQHiGz/AC0dN2Zn3EaD?=
 =?us-ascii?Q?ReulSPAcKKBq/P2alxPA2y5L4pJZZRVnW39L3RgeBnptAmvdPIcyFoSulMzy?=
 =?us-ascii?Q?5T3KR910lxrLrbfEB7VTF94K1BMLep1p36Wf2ZRojCCzoP+BuiekI8F01jH/?=
 =?us-ascii?Q?y3oHu81OTj3WZJqW/ka66n6q/bkY7TI1MEYEP8nKvXKsnp5xS+vbrY79vuGO?=
 =?us-ascii?Q?Cc9MdGNCr0zgLF0wjm+PrY+bKmsVO/RqVKiyjf3T9XF8wf6uKMATTX1HrPEb?=
 =?us-ascii?Q?fkOuSSkV/3kOPHRH41+LpYAz7fIL/3BAV2ivK2HuSEZ52Xf1LCvyEOxuimXG?=
 =?us-ascii?Q?I/UeDfOLMT1mNx6XtI02GRuGFCefPt178Y2/UxtehfjI7oCdOIQz3sw6/nMN?=
 =?us-ascii?Q?zjTeTft/dHpc0LUKR262lOO4jN8nwLgZur4PzjTUVlaiolbWvEE2IunrEKzO?=
 =?us-ascii?Q?WcKddGdF2cpmKp//QY8YTHU3Mb0hI6ljK/jPbutc6AAG3iVHqC5FNRTdpvDI?=
 =?us-ascii?Q?56mQ34pmxopE8eESnVuUI6oxkDC7xGGurJqAhWtTjSjkJIrg62z6/mW5Ukfw?=
 =?us-ascii?Q?3oPYEnteMYePYJSlJFHx1wrihWcpuQDi7IP0SaKWiFOu6ouotxUGdTfIRWpb?=
 =?us-ascii?Q?v2rKGQNE09/XEHXr4rkDMCzyK+p0UkrWaGcEFoqUbtwV2yRXuzQsSv0JLcaP?=
 =?us-ascii?Q?4hCodtiiV7Q5j02YtwBWaTevEfJT+lfWKj47ICbmrF+LRwzZuPEFgfbNLxMG?=
 =?us-ascii?Q?OVeEJYj7nF72zg5DNKPOPwtMgwcIf5DsT0idwRnm0y/XeQOV1sJBGBztKmLh?=
 =?us-ascii?Q?hVbkJgGtg3B0s7vDeb5v82I1lRN4lAw4zH898Q/1gehudUsbZ5myknKexwjs?=
 =?us-ascii?Q?w4DwEvjnY6kMQLzvbfaogghrN9V7DJH0cWZiTqyNqEDq+sI9k+sf4k74j+To?=
 =?us-ascii?Q?TLY8CuWQfOA9eq6x7Htd+dP4ZJ9SkXuP7wOdMO8vYIYnUPx8Wbq+uEC4zuTF?=
 =?us-ascii?Q?GcfypVBHQW2BS1658vbzn6G6LasGxGGKyV1S4U5kA6cC0QhNSmBUyif9HASb?=
 =?us-ascii?Q?sb4qubcg2iftzzRS8lm5EZGL2SvrOI62z2EmxZrBt/dYHI8AuM5lYK68ZDii?=
 =?us-ascii?Q?Nr4vDNBtKtgRD4t9ejyru3pD0fX72hErdK2Kssp3k3a54+ajouAKKYP1AdUP?=
 =?us-ascii?Q?vfue3iFewxNBA9Uw5yyrBBdYQL2wKJBefSaO2sPTPRVRujgpdnhb90kBbRyg?=
 =?us-ascii?Q?HiFKaYhjvdDfcAFOw7GpGFYVYlJY1Me67Vq4ZzoNGcl+BeYUmZmLtS18n/j7?=
 =?us-ascii?Q?EQufOBP6s1QqcUiAORA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c43522-fadd-4429-992f-08dc5a4b02ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 17:15:39.4229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6f0eYmQ4g4O6od4N+4bwp7cUcXipyF69wqmpIF1zfR/7RXbgLvsLqwmeaDHDxeOJ2RmpR5Siayjnoi7ogwKpEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8083

> > A backoff timer can reduce retries.  I don't know how you decide what
> > the initial backoff should be.  I was going with what seems to be the
> > behavior with tcp.  Maybe the backoff adjusts based on IB vs RoCE.
>=20
> Ok, I understand it now. So, with a retries of 5 and a initial timeout of=
 18 (~1s),
> this would make:
>=20
> connect_timeout =3D 1 + 2 + 4 + 8 + 16 + 32 =3D 63s connect_timeout =3D i=
nitial *
> (2^(retries + 1) - 1)

Correct - plus random additional time added in to stagger bursts.

> > > I don't think that most users needs to tune those parameters. But if
> > > some use cases require a smaller connection timeout, this should be
> > > available.
> > >
> > > I agree that finding a common ground to adjust the defaults would be
> > > better but this can be challenging and break non-common fabrics or
> > > use cases.
> >
> > IMO, if we can improve that out of the box experience, that would be id=
eal.
> > I agree that there will always be situations where the kernel defaults
> > are not optimal and either require changing them system wide, or
> > possibly per rdma_cm_id.
> >
> > If we believe that switching to a backoff retry timer is a better
> > direction or should be an option, does that change the approach for thi=
s
> patch?
> > A retry count still makes sense, but the timeout is more complex.  On
> > that note, I would specify a timeout in something straightforward, like
> milliseconds.
>=20
> An exponential backoff timer seems to be a good solution to reduce tempor=
ary
> contentions (when several node reconnect simultaneously).
> But it makes the overall connection timeout more complex. That why you
> don't want to expose the initial CM timeout to the user.
>=20
> So, if I follow you here. You suggest to expose only a "connection timeou=
t in
> ms" to the user and determine a retries count with that.

Not quite.  I agree with you and wouldn't go this route.

I was saying *if* we expose a timeout value, that we use ms or seconds, not=
 Infiniband Bizarre Time.

The main point is to avoid exposing options that assume a linear retry time=
out.

> For example, if an user defines a timeout of 50s (with an initial timeout=
 of 1s),
> we should configure 4 retries. But this would make an effective timeout o=
f 31s.
>=20
> I don't like that idea because it hides what is actually done:
> A user will set a value in ms and he could have several seconds or minute=
s of
> difference with what he expect.
>=20
> So, I would prefer the kernel TCP way. They defined "tcp_retries2" to con=
figure
> the maximum number of retransmissions for an active connection.
> The initial timeout value is not configurable (TCP_RTO_MIN). And the
> retransmission timeout is between TCP_RTO_MIN (200ms) and
> TCP_RTO_MAX (120s).

I prefer the TCP way as well, including a way to configure the system min/m=
ax timeouts in case the defaults don't work in some environment.  Having a =
per rdma_cm_id option to change the number of retries seems reasonable.  Pe=
rsonally, I'd like it so that apps never need to touch it.  Trying to expos=
e a timeout value is more difficult if we switch to using backoff retry tim=
er.

- Sean

