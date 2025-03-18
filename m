Return-Path: <linux-rdma+bounces-8782-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1781A673EB
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 13:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5BA3BCE4D
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 12:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3690020C01E;
	Tue, 18 Mar 2025 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="arUBpB7t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C15C2E0;
	Tue, 18 Mar 2025 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301033; cv=fail; b=EPIwQ2xjCeE9h/lm7pOCyRnpH//5dK9FJIUpiURPaQ/CwmUBxCUq8zxRVay8KQbWTUDlM7h+t1wD4ROiNeuQ5c3i8FUfzKVud089/o2rn0wZs6Am+0z4yvFc3tnBGTgq1HW/I1oJ6LGWOjCWGV3GkaHYad6oSfZLNoL2RbI0fU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301033; c=relaxed/simple;
	bh=r/sKXA4dOmRdVFJsGvb/aU15kWD3i1kpZJM45eFcGvM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q2Nxv5XLlJocFxiWDQV27Lx0NppJFyEHrRyKzbdfbHowD7XNRrHDYuN79ynbJxE55p4rGI2qoqPlVAeH2r66t1VtrRm460eOuvTp8cfkYB7uXjaXKi1UX7VMCeKI+MHOD6khZEuhaIYwgOvZj1CGXcawTzLopRwzgHe2kU+Ss98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=arUBpB7t; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tefpg9w+OCdS5UuhPcWSQT1s3gZc8W0InyN9/h929TMpPKaI7Zu7IYNzmuobSCxfBju4dltohhlsTvFqxBP59JJvQV+lU2tGr59UpOfvyAMJYzxevaqtj6aWN5/JvslkgaZ85C0PUidmeqz3+IE1ITGaz2qU8TFmOlEO12tSjzRMigYiTXA35W9LNYFu4UCzjxQ/8A/txyySDom2PZ6Sl7a0aaVWw6usX7Jwk1nuv/BJBnf5GP2SOdeq+NIWDu+KWszWpQodBFmyeuR0Vjw4nw+yTgrx1z1POfCw3bS3jHRsBNfCbxvvVakVIhSM3h5qhFL+UsDd49COyQtPWjYU9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/sKXA4dOmRdVFJsGvb/aU15kWD3i1kpZJM45eFcGvM=;
 b=iE+r8FcTdDayV8Q5AAGSt2/aLk7I3xYG8Ei5oFdvORvH8yqnho3duhggrVoqiqCXNwH0rBzqf/5CqEzRNfiwZMG9QvF6r8F7GgiRjZ3bByDv59PxZ0hL6/GgyV6IOBYY7lx0wA6wliGbGp7VJjIA5Q4tjSNuOivH3Rear+w3iuofbEweEUbCY6dkBBdGGMLvpEVzUHP9j857+Afew2j7eSfsDphh9ZHO1uB/xVWFd8MskqfbwPcqruh6t7mYdpuKDOjkLtxFCdMDInYl6PtP6lhSzQ2Xy8RQ/8dPDRo3sac24pxrBj4QVGPvSsfgpnQWTfYYWjmyaOHY2DqfVaQpAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/sKXA4dOmRdVFJsGvb/aU15kWD3i1kpZJM45eFcGvM=;
 b=arUBpB7tE+SGodPhzes+hoGL3Gv4foYdnkqMaX87x33ABPEp7PpvCsfGniGbxE7GcCOoN2Hcet7MkBzHfItzMD9Wom0QY4QsZ8WtjnMr17pCZAqFJBJNwsBwCmGSI4/TVGOVFx6k6Jl+Al74TKd0A+RyiqsYv2+kfPAjaUiLuFpBqYQv07zy54lIGSmPTjTncwsTjMuwFMxup7aFjQ3VJMB27lfs0pOG1J37IoNoBa6U0KyuJpQYgRrf7a85RQNQlLdZ+jvyawVSae/gXXgNxMLDgjxwLI6vlR0D4zyJCwxU7JuunLD6AD5QAAUyPrb4LBts7GJrU+9vyY6pLmhPqQ==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DM4PR12MB6061.namprd12.prod.outlook.com (2603:10b6:8:b3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Tue, 18 Mar 2025 12:30:18 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%3]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 12:30:18 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "ebiederm@xmission.com"
	<ebiederm@xmission.com>, "serge@hallyn.com" <serge@hallyn.com>, Leon
 Romanovsky <leonro@nvidia.com>
Subject: RE: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Topic: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Index: AQHbk9YLoK1pT4atn0WpWWxcsGvDt7N3vsYAgACIALCAAIEngIAADyfw
Date: Tue, 18 Mar 2025 12:30:18 +0000
Message-ID:
 <CY8PR12MB71958550549E3F0F016952B2DCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250313050832.113030-1-parav@nvidia.com>
 <20250317193148.GU9311@nvidia.com>
 <CY8PR12MB7195C6D8CCE062CFD9D0174CDCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250318112049.GC9311@nvidia.com>
In-Reply-To: <20250318112049.GC9311@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DM4PR12MB6061:EE_
x-ms-office365-filtering-correlation-id: 28b140e0-5801-47e8-a9e6-08dd6618a4b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?POA5YVaDa0gDGVxCuyGlYAsSpAL2XaT5CgYhigCKdP2PMOVmi+ZMej0DxeTy?=
 =?us-ascii?Q?qj6iPhv024fRD1YfGNndZJwboAk8IDVZkUqYIneIt8Ovb+q26T2jmK2yfNt3?=
 =?us-ascii?Q?/zKCDNKzlSwbaGtrrrynvsxkw5YiQCbrftzTO1lUf96TgnFcaiFaraF40D1Z?=
 =?us-ascii?Q?c34g4L0Rg5at2qJgj6NFYuwMy9yFMLi35OWfamdD1RM+4y/OwAyDo7RnQ+ux?=
 =?us-ascii?Q?o3UvGMSfVnDbV6MkDqXwfYI2asp0wZEOvny6qDudwjphlDgapfBxX+S8oZ1S?=
 =?us-ascii?Q?TfZtDx3LtgUMpdOKQlqjvicfoR1y2oUU1oMo6R561E4BQAMoJYBpXHoLATaJ?=
 =?us-ascii?Q?p1CBMIrrJGsXlQ67HWnf+zspuenFv4LsNJURnSFs/ySf3A9VtGyYJC+TTREe?=
 =?us-ascii?Q?OPfwTYfRRMy3tG3bk0L6We9TUoazUWzPd889vAKf+cQWI/err3ETXWmvU/ac?=
 =?us-ascii?Q?Ym4mZhs6mcO5DZkm9pC2cihDDC1X35tr3cIb/i/YSzXtBAKNB1PnDiSeOLoG?=
 =?us-ascii?Q?+y7dXfKeeJOps/QNZZMTkwt+VF8eLK7hkA+Hky/N1NiD7/elanLPAsQMpOIs?=
 =?us-ascii?Q?d0VlwmugJBFuKNi9+xAQBTMhaQjBNXu5XsIfW8O9JRw81+udEPxZLvd82VOQ?=
 =?us-ascii?Q?gJ4EnFPgoRd8OWzI1zV1q2NbmShS0DpJsT/9zDonwscEbp97j+c7MaCupGH7?=
 =?us-ascii?Q?Sd8/rav6jnlAiY11acC+A/Vy/yYi4K76NV38jsNOuywoFWPGCHBECmKbnV0K?=
 =?us-ascii?Q?YVgp4eq0q1PLvcPowNNP3y5IJvLO5sNP+ZJewd1xG5XVQW1O8Qy3r8+Hwoc0?=
 =?us-ascii?Q?/r+RfKTZJ0tG/xqVNlo5+Fqoeux5AN2iS280DvOI7Ac1xvO+3TGhxQoqm1E8?=
 =?us-ascii?Q?2gDQKyVRJ0SROEpign6vdZPJdD9FOd8rMJAw6d/Ec193u9kKoHso7BTbn4TW?=
 =?us-ascii?Q?dbXUTS5DyVrxBApoFbO374hkLA11DZ6wAmbd5KCYCfzTOqD0s9XnR7gtVF34?=
 =?us-ascii?Q?uSdcXNoF9R5a3yWHHY0qLM6HyueDFjdGlwGSqsggNjljnfSclm22/XI8UkQ8?=
 =?us-ascii?Q?E2N/a3lL2srPcSTlhDx5IvRmAMqaDO075JVC4WIp8zX2+zn3E8twp8PFhhxx?=
 =?us-ascii?Q?oo2rXiWWx79o9XfTHX6gJUeC0KxWMR1SZ0a9AVDy78fay46ptda+PwIoGgr7?=
 =?us-ascii?Q?pBAveZbpJpJ3SST1jFBDdwW7ujhDaGezV/bxlErjn0fwFEsIeC8lW4pJq8Vd?=
 =?us-ascii?Q?Ee0uZFcTsu56OmWstdamqJQkuN+edivrH2zbTGBIJ8O60CNg4PZ4CuDcwkFI?=
 =?us-ascii?Q?Qtwg4D9XwvLGZ/pDqYoUSZ7BX5ZqNP0Hw1t5SNos4fzPwZAl1n95FXA232DS?=
 =?us-ascii?Q?Yzm2LgGktgXlU+0mhDUKQJY3ERkG2FHTho0mZDJopisjs1DD7EXHiz7hXrTr?=
 =?us-ascii?Q?J1F0xYd87Mz8asLI0kbjobN4l4/lflCY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DsfdGbgNrJZwKDh5V2Bk62leveRFVLUQ0Bzy6MCKuYRDIic7LIMdJzT/c3j9?=
 =?us-ascii?Q?ZWeUy/SGqC0lHQB5lxcAr5LPYtj3RAWSlGRDa33p1NX9HudNRHC4vJsdvfeq?=
 =?us-ascii?Q?t0XYvajWyfsaR1q5aPbeL8yPt5oI03/3IR9RC2oASuyNcHFy+8yczQeK+2Oq?=
 =?us-ascii?Q?lUn1nJERj9GMRxz+UzHK6vB5C5rvHy85bLa45Tl0xlY9bblB+JNM48J1VdUg?=
 =?us-ascii?Q?+JYluqtMF7KMBqLr75IBWwhBLa2j1Y0RzS6tEYq2ZveWXYHp6/kif7aa0QwI?=
 =?us-ascii?Q?oV3REwDGSqQuEkpRZWkwu2Vnv9BIlGUo1o3wTZnuP3CuW0/7t93ZXFk4ESXR?=
 =?us-ascii?Q?1dbD/awDZrtIrx7uFmdP3jl50ROgPcS+P0nF4eMUGjLJHrc/AH4cieKFDAYZ?=
 =?us-ascii?Q?po5OB24CxMHAa9vKBuI50g8z1299PH1J3mOhhc0NsZfuhnBflgF3X4tQon/S?=
 =?us-ascii?Q?leNEJeuZTWkDqzZW2eGiImftiR/uR84Q7T9kWqqwsXfOxoifRMD1xR+jASzW?=
 =?us-ascii?Q?l08B7OxLWXoGERasI+ArvE5IWbr4y/s8FFtf0LOalg12XmADlK9xo1ojCD3g?=
 =?us-ascii?Q?2asscM5emlbbT3F4LUaMEXg63ywdEUMKkwbksXpzwLUZ9gfyvuNivtWMfVGX?=
 =?us-ascii?Q?eMphLzKYEiy/LyHL2zLVNCL1QHkt5s0aPrzpl0IGd4mge1BTqhmLTTqPv3fJ?=
 =?us-ascii?Q?x+V4vpBLkTkTPS1c/mugmCDLmKsOiQeHmZ9DF/u7ae1fn+72hyWn2BJ0ejrX?=
 =?us-ascii?Q?Ivtner739AdBhMEMNO8KrBvq4VrRoXFbl4srjYWJLCEz7eBqI6EOTVP5v2q3?=
 =?us-ascii?Q?SVbBxoklRdpvuAnSHqACTzwbgNN+CasMBCJxvOrm0sodmbGX4fVqs6aan2hH?=
 =?us-ascii?Q?hoMvHGE/Yf31jZI0+BqRdOIsR8DJkFua+oHa0/E8SpAJO0QwgNQPLB3NXc2c?=
 =?us-ascii?Q?Q9zZf7Cbrla/L1U30f62344qYt/Rj/eoAQ+IM0mV0yljr4hEazvmkaWwgJef?=
 =?us-ascii?Q?5cI8816+MDLkFPcQiGGMcpL3G4c2mw51rr7x6sdqaXsSo/paJSb8h0MFjhMH?=
 =?us-ascii?Q?GBeKAdFxpgokJ6VhaxIzcG5skqfGnhZPkFT+4F5LiG57n3P6iOB3PBVkk8Xv?=
 =?us-ascii?Q?WZw8Kxvt9/LZiFzdmFAnuMYTAOLilUa47lhuKVNGMuAGDQJ9TA40VA7pFKfv?=
 =?us-ascii?Q?cia6yTaBkplUAm6SvXjGBFsJCtviQXlzhUCYLg+heT8ftGvYgEh4IOZtQ3px?=
 =?us-ascii?Q?/ZZ0jPaJ+SqA3CiU6wrnVpbeZ7FBPH/1tcalbuqcbJUjDm3Qzcv6kh/dkUMW?=
 =?us-ascii?Q?ARccBEbIlH+HZoYiM/VIeEAx7pWuXGsKnS4jb9M4bwI484ZtGY+Vr7vnYNFz?=
 =?us-ascii?Q?icRDYCNhZhffBBz5pWyNxWGUf0Myk1sLmnkgyP1+gI+wa/kD0w0Pw4kffZbb?=
 =?us-ascii?Q?a5NfWMYAsiqCZHmUAXiHuGyTUJjAG2NSd/5R2vJr1XmIPp2ClfohaQz+FiDi?=
 =?us-ascii?Q?ur/d5ByI3Gg4QQ8uIqM+/PAB9j3/ch8YKDG0Ag+lvc+4fWVLNOGHtMVmDPgd?=
 =?us-ascii?Q?sy+g0rQVi0WP1SPt3gILP/Zik8AUHqSH/r++p42jY1Vagc9u1PtASnEoWIO2?=
 =?us-ascii?Q?j3+XoOj0ZXkvsCNyUhF7Bc0iCdFp5c4qPa+Az0CLUk+i?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b140e0-5801-47e8-a9e6-08dd6618a4b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 12:30:18.4370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RlJ1y8mDAf/pQi8FJO5la/yMYcq1cS0k+XoXEHNkX7MvzSU48mqUSTTqmKFw3A+tbsfE7nt3tuF63nov2GR6oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6061



> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 18, 2025 4:51 PM
>=20
> On Tue, Mar 18, 2025 at 03:43:07AM +0000, Parav Pandit wrote:
>=20
> > > I would say no, that is not our model in RDMA. The process that
> > > opens the file is irrelevant. We only check the current system call
> > > context for capability, much like any other systemcall.
> > >
> > Eric explained the motivation [1] and [2] for this fix is:
> > A lesser privilege process A opens the fd (currently caps are not
> > checked), passes the fd to a higher privilege process B.
>=20
> > And somehow let process B pass the needed capabilities check for
> > resource creation, after which process A continue to use the resource
> > without capability.
>=20
> Yes, I'd say that is fine within our model, and may even be desirable in =
some
> cases.
>
Is this subsystem specific?
I was thinking it is generic enough to all configurations done through ioct=
l().
For example, I don't see any difference between [1] and rdma.

[1] https://github.com/torvalds/linux/blob/76b6905c11fd3c6dc4562aefc3e8c442=
9fefae1e/block/ioctl.c#L441
=20
> We don't use a file descriptor linked security model, it is always secure=
d based
> on the individual ioctl system call. The file descriptor is just a way to=
 route the
> system calls.
If I understood right, Eric suggests to improve this model by file level ad=
ditional checks.

>=20
> The "setuid cat" risk is interesting, but we are supposed to be preventin=
g that
> by using ioctl, no 'cat' program is going to randomly execute ioctls on s=
tdout.
>=20
> You would not say that if process B creates a CAP_NET_RAW socket FD and
> passes it to process A without CAP_NET_RAW then A should not be able to
> use the FD.
Well, process B is higher privilege which shared the socket FD.

This is what I was asking in this patch to Eric above, should we have the m=
in() check of both the process?

Or may be sharing the fd is somewhat special case, and generically it shoul=
d be check when sharing the fd itself?

Each has tradeoffs; would like to understand what is the current generic mo=
del that we can adopt in rdma subsystem too.

>=20
> The same principle holds here too, the object handles scoped inside the F=
D
> should have the same kind of security properties as a normal FD would.
>=20
> Jason

