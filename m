Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30EBE103B75
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2019 14:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbfKTNc1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Nov 2019 08:32:27 -0500
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:20959
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729366AbfKTNc0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Nov 2019 08:32:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqOQzUedUyRwz8ZA6c0NGgDC8QQZvijKMXm2ClkENQ2awa05vtq1T4FGFSUgYlZEybmB4lDrLrlVaV1wYn38EmniavBQ9NSUpoQITVdAJLhxfDJ5opGBv6RGpVx/xSFs3WtGd+fKZEECHZmQyxZoppZmCd703aIcwKPp5j6CjMGLwpi8ot62jTDvHCIg+EWqpY5W8THb5p/X0KBbsK2HSP7Z8E+kSggSdoaZv+e9dWYU+QyJG3m1CuhvML9AbQvBWdXLDbwFl5MVguHLqTQ8MUpQyHO1+VAsaGy1I6kgPyvuxmz0EJp/J0TrfYF992LKEE9vGOPm61QwctTrvIzcfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xh1DzTdgIAqpThhi8L545s9cHWKy+AxlqCsW9yfnGqw=;
 b=YJKiHDUk0YUGlnI0LumcqfsHZkJ2XLXDMsz9c23iHAwzL8KupzwHtjaVeB61T4blU2gUQH/7OVOBfuEV0166v2OUUbQ25+BctNeb6TkBSeW10CtjPPVXibQp0/vK8Eo6YjSvwMtWy1gk6cJ8Lj6aEnCbIdvh6G+5pdxIMYTwngbQ0zkiN68MsXEwXwE5hcIeG3zRTgxOZ4JJB21Ne8O6c6zx6tE2oFjLHGNh0NkDxRbhD88XwIKWs8lsTRL2Wsmb0QukhgIUGE9vIOvVZgKcMtjkT+NoyognDIJDQ1F4sVeIJ6c5vOASxBhYlIeNDBRo3q1dDbOk6t/LGWUe2QFLrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xh1DzTdgIAqpThhi8L545s9cHWKy+AxlqCsW9yfnGqw=;
 b=PGf/MdGfTAxk8dQ+Qa9HJ1EJDhg2wAu8BzDnReirN92/3ZId+tNKYu2kIUNmGvJ09C8ZR87e0IMJ/g4+wlwMbeN8S0xmBCnBpJoqUQl7T6dZWBokraewEr6IF8wOTGY5pJmNEZlAsgobkUN82FrGaa7DrN0ohavbCwlWoWoGE4M=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4109.eurprd05.prod.outlook.com (10.171.182.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Wed, 20 Nov 2019 13:32:22 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2474.015; Wed, 20 Nov 2019
 13:32:22 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc 0/3] Broadcom's roce dirver bug fixes
Thread-Topic: [PATCH for-rc 0/3] Broadcom's roce dirver bug fixes
Thread-Index: AQHVnvDlBrbxo1T5mkqjQ0RrgyeVG6eS49yAgACjIYCAAIj9gA==
Date:   Wed, 20 Nov 2019 13:32:22 +0000
Message-ID: <20191120133219.GB22466@mellanox.com>
References: <1574178531-15898-1-git-send-email-devesh.sharma@broadcom.com>
 <20191119193809.GG4967@mellanox.com>
 <CANjDDBg_xUZYirF=zuA7Yn8od4+qzvv3mwKrxRj7Sd3Xx7MX-w@mail.gmail.com>
In-Reply-To: <CANjDDBg_xUZYirF=zuA7Yn8od4+qzvv3mwKrxRj7Sd3Xx7MX-w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR19CA0019.namprd19.prod.outlook.com
 (2603:10b6:208:178::32) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 383ec564-1f7f-46cc-ac25-08d76dbe12b3
x-ms-traffictypediagnostic: VI1PR05MB4109:
x-microsoft-antispam-prvs: <VI1PR05MB4109E84C0D162EB189A98257CF4F0@VI1PR05MB4109.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:469;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(81156014)(446003)(478600001)(8936002)(81166006)(14454004)(86362001)(53546011)(6506007)(386003)(99286004)(8676002)(316002)(229853002)(64756008)(2906002)(33656002)(66556008)(66946007)(6246003)(66476007)(66446008)(3846002)(6116002)(4326008)(6436002)(6486002)(6512007)(305945005)(486006)(36756003)(7736002)(11346002)(2616005)(71200400001)(102836004)(6916009)(71190400001)(14444005)(256004)(476003)(54906003)(66066001)(52116002)(4744005)(26005)(186003)(1076003)(76176011)(5660300002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4109;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PtsQUF6nCs++Is+ERl33AphFMni9xPnxLfHmq6dYAd1bQAx0x898HhcAX5kOFsJOyEwKp7x0zgqcPvBoWiJi4E+iISY7UAcRr6/wFlZj52HL+K5Ek56e7udSWqi/dsry6qZQ3QWgX7wD5Zuf1wECNUcgpY5Li2aT7C3e7INtoycC/45Rpcxgb1xKgZVRsWiD2Neaw6KTAxkXhPkX6vr/C4hoOGADVC2+rfTXiXTdqOOXboHg13yqp20lteXspvxlrZeQJlKOqFgLqSkfY/xNVZSEtBg+k/XQ66de8Kho7b1rxKgUtjuko1hDcQxBcc2tBsaGXzXvuqrOZt/rtkaD4cAca6jOllvqbJoK6hNkSkbamVoTSDk5vhNMWaQqBIBsn8Udfh4u19R4Snpb8bHgLAe2dh6/nJ12GRuz77nWMhwLHto40xy5bp6JZjZFe2bS
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3FAB996CCCE7B41B9A3604D7E60231B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383ec564-1f7f-46cc-ac25-08d76dbe12b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 13:32:22.3971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6MiWLjXgPYiVUugXjXVMk3BN7QEwalbWzPD8yuYYG53mA9jwjE0zvVoYXwLkWJyEsCnZTv6bJBHgDGLTPQUykg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4109
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 20, 2019 at 10:52:01AM +0530, Devesh Sharma wrote:
> On Wed, Nov 20, 2019 at 1:08 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> >
> > On Tue, Nov 19, 2019 at 10:48:48AM -0500, Devesh Sharma wrote:
> > > This series contain 3 patches patch 1 and patch 2 are specific to
> > > Gen P5 devices. Patch 3 is a generic fix to silence few sparse
> > > warnings.
> >
> > These commit messages are not suitable for -rc, and a sparse warning
> > fix is rarely appropriate
> >
> > You need to describe what the user impact is of these bugs.
> >
> > -rc is done anyhow unless something urgent comes up.
> Got your point. Let's drop sparse fixes patch from this series.

Why? it can go to -next, like I said, there won't be another -rc

> For first patch the impact catastrophic as consumer wont be able to use t=
he
> cards as it won't be listed the dev_list.

Supporting a new card is a new feature, not -rc material

Jason
