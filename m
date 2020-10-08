Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536C4287C13
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 21:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgJHTHa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 15:07:30 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:63556 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgJHTH3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Oct 2020 15:07:29 -0400
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7f636f0001>; Fri, 09 Oct 2020 03:07:27 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Oct
 2020 19:07:27 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 8 Oct 2020 19:07:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPbCeBcI9Gb2Lf1rSV9FWN1Vtcqh6FiI4rdvc3RMyCdIRRJWD+vME4DbTr8GnI4nAQlTa4/myVd9qkRG/ISrWr05nW9UfhkfCoI/XpSudmWXJnNW7pFshwCoi6LW4EEoZVlM2WlyQUc8aJMB4Qs879EcEUDojjFrNeTdwFsrXL9YUiKA3sn+iIJTgY5GU1we+nywpybxsplH+prFgscPSnHsdeI7tNwf7bw3R0ns0m/9EBju/9x9/j7QCDA/VCoFJZJJ3nKeosDCf72b/CZncTS9YqfOQ2To79uUryFPZTIynqFZDn4alHXhSsCr7XcpzSFQ+yAkVh8oFoTmMV8OLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1Upcj3GMZhsS4m2LdFu3Un/zW3kIc0HudX/DBzy1Fg=;
 b=kAatviEe6uymXC35g0QVKa7utzuVTFysecbATZ6CuYFigzaExyeCdbHUx+KLn1rAuX/N2cUuowF+Upw+9FOhKA6OMsy2MP00MrDjHaCbUQwoDP8dZqN474tZx+Uf30JSmiEmmiBlJZLvsUsBEXWbuOKr6VnRMgsKTe0nGu0aZMUs6X2mZTVYjhOf5K+SVzBCngMLfoa4+wT4v1Tm/WiRVdmK1wTFyRLMqGMeaIzjYJRSFxQ74ZeaN21YpuW2HPDml343jjO9uh+V46wMlB51kU9tK2DmOKBrC6ICth/Z7I8rQBXaOZ2C+TDqS/xq9CueTVyYbl8wqTPSIjKqjdpnoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Thu, 8 Oct
 2020 19:07:11 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.046; Thu, 8 Oct 2020
 19:07:11 +0000
Date:   Thu, 8 Oct 2020 16:07:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Leon Romanovsky <leon@kernel.org>,
        Edward Srouji <edwards@mellanox.com>
Subject: Re: py verbs tests
Message-ID: <20201008190708.GF4734@nvidia.com>
References: <1c6511ba-e92e-c285-e00d-f2dba04a6747@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1c6511ba-e92e-c285-e00d-f2dba04a6747@gmail.com>
X-ClientProxiedBy: MN2PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:208:1a0::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend Transport; Thu, 8 Oct 2020 19:07:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kQbFs-001aHM-T4; Thu, 08 Oct 2020 16:07:08 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602184047; bh=rpQu7eUlyL1WOxgR3vV81wRUi2ZPYKY51+73pgRjiEY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Gq3bS0nMT+vb+SBDqiiVSC29ho/z5XhlDJaysiiItu2X9NATXwug4aA9+QhCXhTW0
         9QzgArZJ+c9hWm4P0UfaR2u6csVi8uJ78E/P/8/xPjX30q8JZt2eHp/aPDaneqsZxL
         pD4xWmEh/83QyPuNqgy2PDTRX/2Or57zQ75XL4J8SzwmANGJhC5ZZVr1/kq3wPQfbm
         L+60oYbSWfvkuA7BysR4pQVegtzLxXz/o0ONoPSAHo//dTBTzc/utBI0+Xz/zJ9lkV
         dxk6MJT6T6A+bSQxw3S2Oyvc7XfF5poJg0XOOQVjgOvwV8erCvHkOxbZgwiTe0wGTZ
         2dBhl9vX++2fg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 02, 2020 at 04:34:22PM -0500, Bob Pearson wrote:
> I am currently trying to figure out why one of the pyverbs tests is faili=
ng.
>=20
> I added a check implementing C9-205 (p 419) of the IBA spec. I requires t=
hat a responder receiving a packet longer
> than the receive buffer or the PMTU shall be silently dropped. I.e. a cla=
ss D error.
>=20
>     C9-205: Before executing the request, the responder shall validate th=
e
>     Packet Length field of the LRH and the PadCnt of the BTH as described
>     in 9.8.3.2.2: Responder - Length Validation.
>     The following characteristics shall be validated:
>     =E2=80=A2 The Length fields shall be checked to confirm that there is=
 sufficient
>     space available in the receive buffer specified by the receive WQE.
>     =E2=80=A2 The packet payload length must be between zero and PMTU byt=
es
>     inclusive in size.
>     If a packet is detected with an invalid length, the request shall be =
an invalid
>     request and it shall be silently dropped by the responder as specifie=
d in
>     Section 9.9.3 Responder Side Behavior on page 435. The responder then
>     waits for a new request packet.
>=20
> tests/test_cq_events.py passes PATH_MTU =3D 1024 in the modify QPs verb f=
or RC and XRC but not UD.
> This should be a required parameter as part of the primary destination ad=
dress but is not getting
> set for UD. The test then proceeds to send a 1024 byte payload to the des=
tination and for UD hangs
> waiting for the completion.
>=20
> I don't want to mess with these tests because I am a poor python coder. I=
s there some reason why it is
> OK to not set the PMTU for UD QPs?

Edward is the person to ask about the tests..

It seems like you are right and it should be set for UD too, if it is
not set what is the default?

Jason
