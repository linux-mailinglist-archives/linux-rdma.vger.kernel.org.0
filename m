Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A222BF2FC
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 14:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfIZM3L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Sep 2019 08:29:11 -0400
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:25602
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbfIZM3L (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Sep 2019 08:29:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZgq87tNnqVm/BOV73qPhx6Qypis7d5nJTqHSopPQg1FaV/dlvlPOuCnrGggNpiUx6Jcd67ZYW7gBWOAg2pswyYbG4ZEayyW4h1i6rj3oLcOkaDvyDBkzNJbx+XQqGAlm7A2Reqcz+SHYhdFCOfL69aAx5OAUtODwBUG+zG+DSMwHJKip62HbW8Vz2cl3yC6xA1689GHGDhe2xsPQnTZ4SURj5bRFR/Ng3g05GxHH4SdHFYfrn8SDOyzFFWzywKZq6vVwswZnkHJU3IIdc53rro4j2fzwOtKLqB9A8g+6oC/Aw9uk+euhA/iHMxWUcfop6OBjuiTFEkgJZLL/8unkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7ekPjlNQbQgQYRvpulYNixM3uBLWWAb1kMhM2Ha2mc=;
 b=CQFlTQCtBecwYTtAFd2JSb0p7o1SG7seAX+wRMD7+8wEtcrfLhnL2bIbjBcel97FwdRwmFxI/s/687LBlSYD5+EtNokeVa7HaVSlNc72KCv3v89QTBhsP491Fci2nJEtGeBKHWuJgE0bkP8foxes9nSHYh+SJZbn4kUsoXo8dCuGy2twp/IMDzablHRoo1xTLRAVEvkICBvFnY/xtxl18s3cyufMvObeiEH6j6RP5DAZgzyHZ9xXgr5r/c6Z6QZFuJuyCFKEZwJyUbzfHr5wU6Wf0xvtryeIkjIjJ+PZIhorzsKDI6mNLw3PVrj97FOB1Pc65sNCBCNH4h6hQBUzeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7ekPjlNQbQgQYRvpulYNixM3uBLWWAb1kMhM2Ha2mc=;
 b=hBmabResKEzhTvxzsMxDrLHIGGszmBG/k624abjX3mm5Gz1qeoySuIrBQQMhat7zPUhaIMHd7ljxiBQ+cTL5GrLVJo2626LHSfFF6ZqZcCttdfLMX7Vaa1/t0se0tXSU+9HCma0FG5+2A5G0h8Dapl69ToghTqSdpByWNLi+w8w=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3220.eurprd05.prod.outlook.com (10.171.188.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Thu, 26 Sep 2019 12:29:07 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::fc3d:2978:f9ac:b721]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::fc3d:2978:f9ac:b721%3]) with mapi id 15.20.2284.023; Thu, 26 Sep 2019
 12:29:07 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core] kernel-boot: Tighten check if device is virtual
Thread-Topic: [PATCH rdma-core] kernel-boot: Tighten check if device is
 virtual
Thread-Index: AQHVdE7LAGXIjACNK0+Rc7oOXfaY1ac941kA
Date:   Thu, 26 Sep 2019 12:29:07 +0000
Message-ID: <20190926122904.GX14368@unreal>
References: <20190926094253.31145-1-leon@kernel.org>
In-Reply-To: <20190926094253.31145-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: GV0P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::27) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.137.89.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b860bcc1-ae80-4028-5a52-08d7427d2049
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM4PR05MB3220;
x-ms-traffictypediagnostic: AM4PR05MB3220:|AM4PR05MB3220:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR05MB32208DF3E6274677EA0CB098B0860@AM4PR05MB3220.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(366004)(39860400002)(376002)(136003)(346002)(396003)(189003)(199004)(7736002)(305945005)(4326008)(81166006)(1076003)(486006)(2906002)(66476007)(66556008)(66446008)(476003)(316002)(99286004)(8936002)(110136005)(6486002)(81156014)(86362001)(186003)(6506007)(52116002)(26005)(8676002)(102836004)(33656002)(64756008)(66946007)(446003)(5660300002)(76176011)(11346002)(6636002)(386003)(6436002)(33716001)(14454004)(4744005)(9686003)(6512007)(71200400001)(25786009)(229853002)(3846002)(71190400001)(66066001)(5024004)(478600001)(256004)(6116002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3220;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lT4gz3twU6aqBsM/CRmPFw/koFIxcT5K6NanJjeLy1IziColEWAHI4iC5jiWGJuQxyhJADhg62ukRucmklLQz6/cp0SY8BEC34lJwULwzxLevuQVhv1a3FyUkPUcmybH4qcaVXXO0386z5TT+886R1dD8IwO9kHO6V/CZPJbIB/R0Fl7NrWedQddvEBvkL6D1wBneB52qU/RzsTVfWy0liJuu7FhE0w0MLpABDi9y222c1wHabi3lpN2yufcVNlJ8oDMc4sz3Wyd0VD7WKs4Ap1daQnymWdgRRZ4a8OpBIlKSdIbrg+XqOiS6M3uK/gaxxqi59+wVVKZ/ofNU6Y1B6b8v4IYpfqJ8P1vrBif5wNSje+6eLOB3HWQaGkC35Zr749C3OTCOal/seOfdz93ROn+VBXi3nMwfyjPV4k6lqQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <95C54BCB4A991E42BA7C991141A2D496@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b860bcc1-ae80-4028-5a52-08d7427d2049
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 12:29:07.7617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWtfJXntDAVEW9qxl5xQopMf34H2Zb20cZnWrdOx5ZRZNkt7MzAvnSH3BaDZfc3PupmakbKDN0YFT+ueVG8aqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3220
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 26, 2019 at 12:42:53PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>
> Virtual devices like SIW or RXE don't set FW version because
> they don't have one, use that fact to rely on having empty
> fw_ver file to sense such virtual devices.
>
> Such change is needed to ensure that virtual devices which are
> attached to real hardware won't be renamed, because during
> device attachment, user already supplied desired name.
>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  kernel-boot/rdma_rename.c | 39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)

I have slightly better variant of this patch, but want to get feedback
on the concept before reposting.

Thanks
