Return-Path: <linux-rdma+bounces-9796-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F493A9CAE1
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 15:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4103E1BC44AD
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 13:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0131F233737;
	Fri, 25 Apr 2025 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oWQtztkK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C74A42069;
	Fri, 25 Apr 2025 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745589252; cv=fail; b=CDYTelbRRwRcbnQlH/VCzbI+hyp3XSRUCZ0CBxUyQTf03FbDGxORNZya8l1xfgx1facBs7zK5SOrsBE9Bf+v046JOYKb0x8hI/3xfGAeK03La4+ig6/gaKCbKQkyEbudwKVAwkGl5xwEYbMa6ov+wVXBiGWe9qx3bIQ3q+IyELM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745589252; c=relaxed/simple;
	bh=KwOgzi9Bu7S2lZ1Aluvyhj8PjfxdCKQ+2hvHVpGiDJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T30LBbgFvj9RXDbGVu1ms1XE4N61jXuGsy4S7KGCrTfFvv6nsvpt8TPY3b5dfv4niVqH0bFeTBrz8x/Yw5//0zVodUtPm/wPWV2rPyENzdIbYF/O07RMPDAaG+jmyUmMts+Ghl79AiUmlHXQaiGsZBumr94CGyCG78XQWOQA3o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oWQtztkK; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsuolqIYKdSZOjMM3PNQ21uW51EjQ9V5wRQHRx98/dHKfduKO4NTmCbgyBO4UKl2NnmA4d/s393RBIRntEC9XGlKc6dra50q/grihmOnYYukY4XWs+GWa7QexxHQeFS2yx5txBAtAHlmjr7D0cs4Hwsg8W84qmVZSa1CkDvdD3bf3gdE3rp/SLOUuIfC5p82QvUpYrxAZy+Za+g6P8dPqcaSiQF9YIWYZo94L4aBuBF6reBRW1SUJRtPReWHGXUKhTQw/SXaR2BA4C7VtSwt0ycCCff2CLhcpip3SVC0BtNlBSnEQZHmsfZAegiHiEQ8oDxK1wrzNhRMvqtM9XFPMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwOgzi9Bu7S2lZ1Aluvyhj8PjfxdCKQ+2hvHVpGiDJA=;
 b=PMPCyzz2OaYQq/Wktm8vb8ufWOevs2XiI3AYmLxe1S5fF88CVMiCUqgPVfLXzDQJzorFX/yYAgaPpxQwv6B1MKe21ACJyqOW882YUh7xW+BXqLFSZdExWzznjX/xnjP2p/UydKfSJfpewJzjDYMPAX6Gp1q2FnnRmqSdFgwwx8Np2k5MbUFOLwYnrqiyzdXtOyjrcT9iSl+GFBhe9Ah5iFsEN+LtMv+mUAR1jHSojK/H4nWQrB+EjoSWmODoYaWCplS8FJjqf1mAsOYIID6obO4MQIbUA89jFMFOJaHOOUyZzOA1QKCjFemcyn5d8NRKE2fzpco/fKrAouwPMUfGNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwOgzi9Bu7S2lZ1Aluvyhj8PjfxdCKQ+2hvHVpGiDJA=;
 b=oWQtztkKR6EyAKp6GjpzXs/TgGD1r0TpFLP1MuBX/ByRUakJOo4Vdtp7SW+UIyXhAI1qdRMk34ohPp9QXNCckXO6BcbLBvlmsaFogWoldv6boY6u9RhezxEn4mgPOUJ5rh7YN9yf0uD0NW0CGKMHynPzUH4diy4JPM51tQyAO87dd8U8071Z9cHFW3s5SLjZInyFjDx5xtDnCXzwpvpdi/kAA6v2kw2/UeV73mI4S7iNrBkTPgKAy6AXMW4itDtADJdA95Tx2EwmchfikeJcCUnu9XlWvXIlLdfDPaeeQOtsS+sRSBZC0GaW8xnoytdXWYndSjQUuYRauvw4u4n5PA==
Received: from PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7)
 by SJ2PR12MB7800.namprd12.prod.outlook.com (2603:10b6:a03:4c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 13:54:07 +0000
Received: from PH8PR12MB7208.namprd12.prod.outlook.com
 ([fe80::1664:178c:a93e:8c42]) by PH8PR12MB7208.namprd12.prod.outlook.com
 ([fe80::1664:178c:a93e:8c42%3]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 13:54:07 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, "Serge E. Hallyn"
	<serge@hallyn.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>
Subject: RE: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Topic: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Index:
 AQHbk9YLoK1pT4atn0WpWWxcsGvDt7N3vsYAgACIALCAAIEngIAAkUBrgAAxToCAGipgUIAZ+iMAgACAGGCAACPuAIAAA3qQgABFyACAAUU9AIAAB8qAgAAxbYCAAAUbgIABS0ZQgAAqToCAABIpe4AAAEUAgAAOzYCAAQq5sIAAXSeAgAF369CAAA4KAIAABCOg
Date: Fri, 25 Apr 2025 13:54:07 +0000
Message-ID:
 <PH8PR12MB720834D2635090B376790F30DC842@PH8PR12MB7208.namprd12.prod.outlook.com>
References: <20250422161127.GO823903@nvidia.com>
 <20250422162943.GA589534@mail.hallyn.com>
 <CY8PR12MB71955B492640B228145DB9CFDCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250423144649.GA1743270@nvidia.com>
 <87msc6khn7.fsf@email.froward.int.ebiederm.org>
 <CY8PR12MB71955CC99FD7D12E3774BA54DCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250423164545.GM1648741@nvidia.com>
 <CY8PR12MB7195D5ED46D8E920A5281393DC852@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250424141347.GS1648741@nvidia.com>
 <CY8PR12MB7195F2A210D670E07EC14DE9DC842@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250425132930.GB1804142@nvidia.com>
In-Reply-To: <20250425132930.GB1804142@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7208:EE_|SJ2PR12MB7800:EE_
x-ms-office365-filtering-correlation-id: f5e8b13c-c624-420b-bfaa-08dd8400a5cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RFbeXPNkhrTpn9Ii/2CRgxBvIc42haBhwfNvU6XeLb5zZGvOfTiHP5TtKqlM?=
 =?us-ascii?Q?sDVg8T29ij3UD0boQ3DLiXVxoj/7l7H59EAu78Me+S4n+4UtwQMx6KM/W/BM?=
 =?us-ascii?Q?yS3qdohUlM776YTtDY+0vLvECi6WHK04r5HeY2smjJ8/kOmMbpqtXFCzrpKd?=
 =?us-ascii?Q?7/7UeCV3s7LpBl2NXM5j+FznXQh0KhCPHX3mvEGAYtUFA1PlZuLBx5AH/hkE?=
 =?us-ascii?Q?HKrmGuMXG+WQhn2dlGc8ybpq4ppEXzFxd/gKXDephDGDybNwF15RSP9pfwBb?=
 =?us-ascii?Q?ktleB5xA/827fRq2bAFhwpgh3duWpkMsO5yVZlEoAfZhcUNsedUXJ8O4nKDw?=
 =?us-ascii?Q?4+9B+/TpZwyEbmh7yqsDpgm1Z95ZtarC1BaJVWL15ZNYNxgP+xVeuW6chpMi?=
 =?us-ascii?Q?dtweZql7HdOh+e7jFwxmMoYCMWBXkXoPSrczUZs3YMS8ePel9TCkD2K+qmbY?=
 =?us-ascii?Q?Qh3IA4N7JQMDo85hFQt3xwGcJbGYjlD0uqPvhyBQseUw6Jkd9GXIbZE86id4?=
 =?us-ascii?Q?EaSAa6XpuwzkPGT69XoSJjrTK0muue64uHZyvExy1wNunm5+tphG1WNymdbO?=
 =?us-ascii?Q?WVEcNNPSa87s3c0tYwBcBr8LU1DHzXOBwC//nlMRoS8Rs7xG2Cuw979yLgNP?=
 =?us-ascii?Q?qT2ViBi1HoJqED6hAhXDeenuLLWHQw3mSdQz7Ug0M249Q/2gR1EODTNM8jim?=
 =?us-ascii?Q?S76o2oC1p0NjCYsQG5/hBfNjmCqdv7hYDKyzoO1s6606bOFwzYOj1xy6H+u+?=
 =?us-ascii?Q?WZq46MuYVKdBivT2P6r1T+roUYw+DbAOVRSLPbebFFwXl83CVMKqyKlDS5jX?=
 =?us-ascii?Q?BoxrKtwMSlINEKUUE0Hwm5F3HDr/G3S8gvZd248f6bNfor6zlj4NJ9qWEimn?=
 =?us-ascii?Q?qdBpxHU80w2h5mYjMseMvwLY/PTZy9HfXrZKwh3wLJtUMfoU8htlj1G6VOtH?=
 =?us-ascii?Q?opOuKAeNdEIvF9zcd0WVyj3E6daLE3Qeto04iNP/vGMiNbJCxbtF6uqeFhIp?=
 =?us-ascii?Q?rBxlEG/0nEyBB+dfwvG9zTuu1vosV1LWJ3LCM+q0wx2Fb2rvkm2ytwRhfTgR?=
 =?us-ascii?Q?6XxUf3iS6tUlvTHweg+7XwbbDfAb9frcHigkBbRIbtv+hdYmpBekvNAezUKJ?=
 =?us-ascii?Q?FX345fkHNTn0QirRblCpYe4fviJk68A+ZQ7BwSUhq9AYuBRdIo3PdB4nSxCR?=
 =?us-ascii?Q?Vi4VWRT8fxPt5gtv07tIeUED9lGAMhOja70SyTbc/wu0NHVDDxaEFD6dmXZf?=
 =?us-ascii?Q?cVZ8/8ccBiqA38GW4SN+Z3mHIvwe4uSBsybQhLylQNEjACFVe3eh6/ZyylcF?=
 =?us-ascii?Q?iwDvbOk9yM4/VvkXpBtAIchTHp6E1w7d77+Lf7mFW0D71nJrF8jvy/Jd+4A4?=
 =?us-ascii?Q?bsER3pSvNzT8h45zoQlJKCT3EmmtmNR55f1vN9PEciBJ1yqowQM46RrmvKT7?=
 =?us-ascii?Q?soGoY7mhoXbz5DqOQvsgDewG8Ku/BueR/U/vnn0EEWt01VOefriA4w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7208.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yRbMoKV12pVM7Y3ae0E/iKT1vxLjkAUorgKOyhrXpQFg9t8S16roznCnA2eW?=
 =?us-ascii?Q?iFiOx5Y9cGuWQc5WN7Jgnl3CrERjKyxpsvvOaOGm8/n2h+EqrjeFwzK4dBV+?=
 =?us-ascii?Q?xUVwcx9ZUvha99GC03TAqtcvEC8gEcxatqDYqJajE3Sx0q78o1RFNQTIVw94?=
 =?us-ascii?Q?x1GerJMitelu+/5WoApe4wm9s80WrASclmflVu4WdXzqYWg2BkrkZpFdyJHR?=
 =?us-ascii?Q?a9VNyyRutwi4GR+d8UNi+uAKVJNmXMSBF7NwvvUPPitmoi3kE7o5ypS82j/L?=
 =?us-ascii?Q?yBRIFihfuaJM5sm/b+jTFtg0e8s2ShZq2edk/RJ8lkJhOd24KlB9ElDrdQmq?=
 =?us-ascii?Q?/j3GuvRVepuWCiLqk8/43eOYkTZgJXJl5AYMK1TwduHYOjj9moGfmVaGWHeu?=
 =?us-ascii?Q?FRAx3t9n735GBYfv4nBJlCBVdnFwJJ1YikCpjhi46LWCREZxP0HPQ0qsBJ1G?=
 =?us-ascii?Q?PDOLhM2+m7B3dNGxWgNl2s9e5/h73JQ9yxDqA2HvcS9bRs3YuqGDVDfLwpt9?=
 =?us-ascii?Q?TwqzYIlOvy1yJQZNqWvMU9z8w+PwD4Zfx66NwJpq2xIpjg5mKTkdkUh9U5MR?=
 =?us-ascii?Q?SdBguifWpDVv6XJNRjiCfVlBpK3E0tMM1i9GrTLIpESXQf9dVyj3mpZIHWnz?=
 =?us-ascii?Q?MUwButAyuF0qvRbgJLeZEU0jUPtfueaq54zVy+Bb84dOYWgdvPJW25MhNXOZ?=
 =?us-ascii?Q?2+BoBQbTQeMWntyh1QCLYjUk8w+4vmIPQUyY5qaYi35p9QU3v2CxYwBvvxP2?=
 =?us-ascii?Q?h8kSXiR7hHu4+gHhSPSWD+NYf4//Bntb9swQ/TICsZACgRna86MNiVzTE7rd?=
 =?us-ascii?Q?f/o0syJAAd+vA/AaTKg+FZVJS5jwdYwTJgbCrLd7LHAj8Ng54HCoahu//ILm?=
 =?us-ascii?Q?Ps5se/q+Yzwtvy4sRjZln/jMD0AmEWnTwuDr71Uccq8xUTYioaK3Zb6qPY5y?=
 =?us-ascii?Q?tATgPnnpFxJe9TaOe7SI5r7Oh/njsLNiFiawqtdfylBgrcffEJc4MSrRJYlD?=
 =?us-ascii?Q?sDo7tSMy8YIys28uwtrlMOy+K8AKRoWzLfyo5ptOusTPjAxfcX+2soC1vpw7?=
 =?us-ascii?Q?o2VWXkyA13lfPKNRJHyVFatWd8As9emrmwhs8uVibkDMZUxomZhly9FWQK/T?=
 =?us-ascii?Q?1eKbv+zdfhevQPPFOmBUzu5/GJvNWyIQKtM4hMMpA7G6uFb0BTdeLdtIb2FQ?=
 =?us-ascii?Q?EmznojmMJBqDEYxGIzVmSTeA15fj9xibU1VI34lM4PVCiSlYT5mZo2iP7tt9?=
 =?us-ascii?Q?x6wyY7i8jGRkJ/MegxYRtQH+ReHrkEknIXmHfyQyLibDEb8LlP2HP9aP2Zga?=
 =?us-ascii?Q?jVdoCEoLm5daAzSpJpVGxToXRH5CcmKILh4FfxPceTQJZUtI+JL7Q3n+f/ha?=
 =?us-ascii?Q?npBGqg/iG+udiI4LFDJah9Au/PyfVqQuoX5byO+hxKZ0h0NATm94/bWJfamD?=
 =?us-ascii?Q?iS+GsnT3sDrnzhlI2LR5ErKE1GKgOOddppymc9NERUJteTxIIKe49KryQP27?=
 =?us-ascii?Q?WxsTuT4lQ3pA8Sv02gvQQ8RGf7Sc2o8P2lkLgO9dNEPr4+LFwKp+doUrvZBa?=
 =?us-ascii?Q?b3B0sn1w6iEghBJLcbo=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e8b13c-c624-420b-bfaa-08dd8400a5cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 13:54:07.2426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 46vPzZuqMVY9eji3KyymSLmkpqUXpBzyXSHoxecOev7DAFDjW9SP14CiKmLbl1jyXpkOWsqQYYLQwRCGbTIhhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7800


> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, April 25, 2025 7:00 PM
>=20
> On Fri, Apr 25, 2025 at 01:14:35PM +0000, Parav Pandit wrote:
>=20
> > 1. In uobject creation syscall, I will add the check current->nsproxy->=
net-
> >user_ns capability using ns_capable().
> > And we don't hold any reference for user ns.
>=20
> This is the thing that makes my head ache.. Is that really the right way =
to get
> the user_ns of current?=20

> Is it possible that current has multiple user_ns's?=20
I don't think so.

> We
> are picking nsproxy because ib_dev has a net namespace affiliation?
>=20
Yes.

After ruling out file's user ns, I believe there are two user ns.

1. current_user_ns()=20
2. current->nsproxy->net->user_ns.

In most cases #1 and #2 should be same to my knowledge.

When/if user wants to do have nested user ns, and don't want to create a ne=
w net ns, #2 can be of use.
For example,
a. Process1 starts in user_ns_1 which created net_ns_1
b. rdma device is in net_ns_1
c. Process1 unshare and moves to user_ns_2.
d. For some reason user_ns_2 does not have the cap.

By current UTS and other namespace semantics, since rdma device belongs to =
net ns, net ns's creator user ns to be considered.

I am unsure if doing #1 breaks any existing model.
I like to get Eric/Serge's view also, if we should consider #1 or #2.

