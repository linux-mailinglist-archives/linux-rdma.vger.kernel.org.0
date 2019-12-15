Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8430F11FA98
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Dec 2019 19:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfLOSzJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Dec 2019 13:55:09 -0500
Received: from mail-eopbgr50056.outbound.protection.outlook.com ([40.107.5.56]:18567
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726219AbfLOSzJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 15 Dec 2019 13:55:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHOX937v8CSTUMdEptYPG89h8ZluEfXhEtwPgJ5ZMOAy3flfwQogt95PYoxw6wQQN0NSXyCfO79OBt4gGl8y5AVQUAgJOBOTfm6me6v/qJ1slWSL2KS+U3UvmDlNgwKD/3p+CXbsRFE2fZxC5CTfjG7yv83+3XtYVB7OHFtJz8F9k35PddNapb821tpR3y/ZG2L0evrHRWLw2lxg1ar8n7KVXnuommOerBEQCXt6XiXdfAGjzUMB7mtvRA7xBeke+5vA5vUTuNsvNCu7+WGrey8hPavciZV5eQShcr9VbW88ToRilvziOmYQhxV01RmTm1llEDphBBvhOijOeCFFyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/M/EXavw3gSI10r2slrUnYZB0lQtspVx6dsvh/uJDE=;
 b=BTGflVH41Ge3Vw8OGnZzfagRzKb/A4ujvR2ojW+0wvXMmu6zetfLDMuMT6k2CFJxYcQ3uP+GW6UHDH5PvNEZXUsJWkVDUrw6nTbGbJECTPgfflOzMshlVcHTFkaX1FyLaGul/v4q2kw7gZVdn5kO3GvHZfS1GnbwrRRlxAt3Zc75n6jnS6EvPRxp59by+VW4njPXgZyRZ7K4gSuce2WMkGBJ8HbkOmEJGqg3oFUE32NS7ri3MXUwtjAjGap5FFAmNimDwhFPSbp9xPsgB4RdYvZ+5X7D2lniR5lScKtVsznyZWSZsuqISG6G5gJMB4nCUWTFTAlAigRlwTwyf1/sRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/M/EXavw3gSI10r2slrUnYZB0lQtspVx6dsvh/uJDE=;
 b=Ls67Ybx/TJIzuw1SZZiCNwidmX1HZvajSbTpGoJu6LMWSSmm4rpCVYR7kI4mWt79ZzEcR5qEoQ2orRpNqgGgPhI04Yrzv8D3YKsOzj2w7vC3rfEvL2LlAJkN647MhTpJXMW4OVgRsW6ITwlO14Mc4YvWPUwkGmdr7CmqE/F1qkU=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3204.eurprd05.prod.outlook.com (10.171.186.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Sun, 15 Dec 2019 18:55:05 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e5c3:58e:7e9:d398]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e5c3:58e:7e9:d398%7]) with mapi id 15.20.2538.017; Sun, 15 Dec 2019
 18:55:05 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Ariel Levkovich <lariel@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-rc 2/2] IB/mlx5: Fix device memory flows
Thread-Topic: [PATCH rdma-rc 2/2] IB/mlx5: Fix device memory flows
Thread-Index: AQHVsNNPQtlOwkoNwEy8CNbUEyEWTqe2WR+AgAAB5QCAALKPgIAD0G+A
Date:   Sun, 15 Dec 2019 18:55:04 +0000
Message-ID: <20191215081537.GD67461@unreal>
References: <20191212100237.330654-1-leon@kernel.org>
 <20191212100237.330654-3-leon@kernel.org> <20191212111457.GV67461@unreal>
 <20191212112144.GW67461@unreal>
 <2e16247d69f4c2ab924b67ae85757184f6bcc741.camel@redhat.com>
In-Reply-To: <2e16247d69f4c2ab924b67ae85757184f6bcc741.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR05CA0093.eurprd05.prod.outlook.com
 (2603:10a6:207:1::19) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2a00:a040:183:2d:5ee0:c5ff:fe5a:b5a9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e57a767-d829-4c84-7886-08d781904c10
x-ms-traffictypediagnostic: AM4PR05MB3204:|AM4PR05MB3204:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR05MB32048B2626DFC42066CFEF80B0560@AM4PR05MB3204.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02524402D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(189003)(199004)(316002)(478600001)(6916009)(86362001)(4326008)(107886003)(4744005)(33656002)(4001150100001)(66946007)(54906003)(1076003)(66446008)(186003)(81156014)(81166006)(33716001)(8936002)(8676002)(5660300002)(64756008)(66556008)(66476007)(6486002)(2906002)(71200400001)(6506007)(6512007)(9686003)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3204;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GlnAN4OpEqDdgfdGe6n4DmPbIayCIS7/W7orDlrHO75dEZmpUBwPuO1lPV01ePLCTz1gtCZ4JlR1RPNy99YAVE91kNevG0/wE9KzTYrKvGFWmiH0SFwP+AAiP+BpDGmGexcGiecqOX+Uq3xMdasWUW/cuoZ9XG/mLvthImH3eeFP9A5S5yP+V4BB+ALlUNwMPJggxhWyg0ISpTBAj2z9Ckz3hYWAq+zzjZTaLK4ZzWD/x6/DSGgEFUWFiB0ZzjQ29//U6jyEwDu1KiAa4QX4W5iNhresmb41owMNTUkSJSmvQ1XUFGLH3cEjOR9matgm1ymQ5ojOsiwEHI2bHElOlW8YmTbUN35ZG0hMRIWg8shMCkZ04Ou3X8YSNFvPsLSFtQSjfxZX4B6Ec7js714a2uxSwKjrjKHIRSA6QGVBR4+pjpcfF0suQWRaVL+GJ3sM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <857744C40FFD654D86E64CC3E7D67D3E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e57a767-d829-4c84-7886-08d781904c10
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2019 18:55:04.9864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +PH+OBIDE2x28RDRi9GaSuoeiWv5FyM8OgIse9Ne+STjUwNhGNY6gr25VcSgwW9m+Y5LSUMEm2SFP8Xfs23iJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3204
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 12, 2019 at 05:00:49PM -0500, Doug Ledford wrote:
> On Thu, 2019-12-12 at 11:21 +0000, Leon Romanovsky wrote:
> > > > @@ -2288,8 +2332,9 @@ static int handle_alloc_dm_memic(struct
> > > > ib_ucontext *ctx,
> > > >   {
> > > >      struct mlx5_dm *dm_db =3D &to_mdev(ctx->device)->dm;
> > > >      u64 start_offset;
> > > > -   u32 page_idx;
> > > > +   u16 page_idx =3D 0;
> > >
> > > This hunk is not needed.
> >
> > To be clear, I wanted to say this about "=3D 0" part. The change of the
> > type is still needed.
> >
> > Thanks
>
> I fixed it up when I took the two patches.  Applied to for-rc, thanks.

Thanks a lot.

>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD


