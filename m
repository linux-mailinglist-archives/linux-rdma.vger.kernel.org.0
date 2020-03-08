Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBE817D12A
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2020 04:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgCHDsj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 7 Mar 2020 22:48:39 -0500
Received: from mail-bn8nam12on2132.outbound.protection.outlook.com ([40.107.237.132]:53217
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbgCHDsj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 7 Mar 2020 22:48:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V41n71Hv4qcWz30LMgNeuchDth7+p+D8HR/VHfzfdLQBSat1B9ntIYD/NWkOcBWfIXgL4SaiFTQfsryLNAgtNWh8R7KRDAN26FLZDh1BuaA1yvS8WojWlelESQvi8GRwHtXSbzN/qXY0IEUvpIgATisGL+R6ai0L+fU2lX03VXG8ogxCi38KgjHgWqHvgvNcvmnkzY6tfpkl98knwoAFGSvHv2+z+N7ayUqkKyE6wnrRiiUmh3ZCCyfiicWPuLCj+lQVMluemH0NUioukbwlk6QvL6YC4CIDQhTiJdK9yO6bussJNcLhLhyQIjmXYNPYAUR/CEksLySNJt0XzttXng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+R7MhL8OUPXEHOi2lyLN10SO23xHP+SWDRszHjhbtIk=;
 b=nvOmz3fUK/GnQ/lJ8m0I3O4b57xHnKhShqjzf6OexVQ4w4H9PfeWLxKnk0clEu1QZixhdBgMMMQcgJx7i2LVi8JWEZIRS+Ko5oPS4DLRqpJLcRO1aKnrdYY7UJS18Mq0dnomhYZks/kKjFSToOSnOkd+JmcdjoJ9EuQKto1BV3nDD+YV+NkkQgBzFecvitJ8jqiYlZglEhqwcFh8RGVZ6joUSIYUXY1nWcbBcYVq7p7EKHy6h84qKbYzktNQ2jFCxhccjH8sn6O7M/EhkE0AYF09YlgRVAKskb3+uOR/0itPzFHYivD5NxdCZhGDDLPZLtFmrBzLHnSkh3/Flo3bLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=northeastern.edu; dmarc=pass action=none
 header.from=northeastern.edu; dkim=pass header.d=northeastern.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=northeastern.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+R7MhL8OUPXEHOi2lyLN10SO23xHP+SWDRszHjhbtIk=;
 b=oksRtAavzBISeUXVJH7dnSGWLP7I+9BF6846RgE+qoSPFUDGK3vTzKU28ZOb85KHe2fBHiCA2bEAr2oSEHhx2EHcEdprLcm+cvaO+n/RDmW8gHEqSC0H5uSxo5VoD2dR3Cyz23xQDgerX2FdWK2sIuO5sdlASg+fScOFWF32kro=
Received: from BL0PR06MB4548.namprd06.prod.outlook.com (2603:10b6:208:56::26)
 by BL0PR06MB4563.namprd06.prod.outlook.com (2603:10b6:208:57::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Sun, 8 Mar
 2020 03:48:36 +0000
Received: from BL0PR06MB4548.namprd06.prod.outlook.com
 ([fe80::20f8:a2f2:5ebc:da2]) by BL0PR06MB4548.namprd06.prod.outlook.com
 ([fe80::20f8:a2f2:5ebc:da2%7]) with mapi id 15.20.2793.013; Sun, 8 Mar 2020
 03:48:36 +0000
From:   Changming Liu <liu.changm@northeastern.edu>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: [bug report]infiniband: integer overflow in ib_uverbs_post_send
Thread-Topic: [bug report]infiniband: integer overflow in ib_uverbs_post_send
Thread-Index: AdX0+lePgAXoHwV5TnijaTfk7FDCsw==
Date:   Sun, 8 Mar 2020 03:48:36 +0000
Message-ID: <BL0PR06MB4548B04CFD3A77B4DCCA74DFE5E10@BL0PR06MB4548.namprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=liu.changm@northeastern.edu; 
x-originating-ip: [155.33.132.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b923a5c-0661-4c74-aea5-08d7c31394fe
x-ms-traffictypediagnostic: BL0PR06MB4563:
x-microsoft-antispam-prvs: <BL0PR06MB456387494264F3B3A328E986E5E10@BL0PR06MB4563.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03361FCC43
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(189003)(199004)(7696005)(64756008)(66446008)(52536014)(6506007)(66556008)(53546011)(5660300002)(66946007)(786003)(316002)(66476007)(75432002)(55016002)(6916009)(9686003)(86362001)(2906002)(478600001)(186003)(71200400001)(33656002)(81156014)(8676002)(8936002)(81166006)(26005)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR06MB4563;H:BL0PR06MB4548.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: northeastern.edu does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iG9llv/QSFfaY6zoCAn6JdxYmddznGB17nAD2zRhrHq+9ziBZsYc2RNufy3Dbm0vjH2vpXvKSeI4bmeowx0fnD4d+as+1LND3cD4vzioXhDUfl8pEVNV77KlY5dgiSb4gUP9YgEkwyXrWtLr5afQgp7Iqgy7ac5DLAvWKOutoNuNQEwiJp69zX/cgl0P6wj3q2dsVHgwJsRiqW/GE1Nk3mJWBDQsEYoozGH5W1s4UIoH7l1xNZHiG7HYWsIYb2GPVLxWmtKDWcsypLyModVe/ZOziR3ny3UXXMBlwr+V9zd0R3Yoxemti6DitWHCv1DXRUvooObKyW57YpxDJ3S9iSfzBkUBvYNQDIyQ2TP5ZsNASDdrtTY1s40n3uoM4RjMUPOPGSUqDOW4dwABHk5PNp/6x/qdWGkkZb2V4CBibaWVC3PlExz3FzllKICAJdl2
x-ms-exchange-antispam-messagedata: wVXlE6lIdofiyh2PZw2gye2dNN5HAVQMICPbd21jFzfnouW1Wuk/Zmkhz1EqW+bSoXSwl7k8jDGUjkLMqC9Dqp4mzyUxbq7RF1RN39EZWmf7NO1pxPAOnUl9FLf6PK9cA6fDj/qdzPJFoV4lHcPCIQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: northeastern.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b923a5c-0661-4c74-aea5-08d7c31394fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2020 03:48:36.7238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a8eec281-aaa3-4dae-ac9b-9a398b9215e7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1iTFoFVem6zaoFX84B1iWMZMKI4h+0McOsz8+7RIqZfb6pC5fUsZ+gtOJOoEOdCr3KMwxJtSRC/iOu32n4QANG5FGfn23DwaC+G/tEKjls0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR06MB4563
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This email is sent because the previous one was rejected due to it was in h=
tml form.

From: Changming Liu=20
Sent: Friday, March 6, 2020 8:50 PM
To: dledford@redhat.com; jgg@mellanox.com
Cc: linux-rdma@vger.kernel.org; yaohway@gmail.com
Subject: [bug report]infiniband: integer overflow in ib_uverbs_post_send

Hi Doug and Jason:
Greetings, I'm a first year PhD student who is interested in the usage of U=
BSan in the linux kernel, and with some experiments I found that in
/drivers/infiniband/core/uverbs_cmd.c function ib_uverbs_post_send, there i=
s a unsigned integer overflow which might cause undesired behavior.

More specifically, the cmd structure, after the execution uverbs_request_st=
art, are filled with data from user space. Then two __u32 integers in this =
structure are multiplied together as shown as followed,

wqes =3D uverbs_request_next_ptr(&iter, cmd.wqe_size * cmd.wr_count);

Then the result of this multiplication is passed to the second parameter of=
 function uverbs_request_next_ptr which accepts a size_t type of integer wh=
ich is __u64.=20
The result of this multiplication is later checked at

if (iter->cur + len > iter->end)

And used as an offset in=20

iter->cur +=3D len;


The problem is, the result of this multiplication can wrap around. Although=
 it's lifted to __u64 in function uverbs_request_next_ptr, it will first wr=
ap around and then be lifted, as shown in the llvm IR:
  %wqe_size =3D getelementptr inbounds %struct.ib_uverbs_post_send, %struct=
.ib_uverbs_post_send* %cmd, i64 0, i32 4
  %9 =3D load i32, i32* %wqe_size, align 4, !tbaa !2404
  %wr_count =3D getelementptr inbounds %struct.ib_uverbs_post_send, %struct=
.ib_uverbs_post_send* %cmd, i64 0, i32 2
  %10 =3D load i32, i32* %wr_count, align 4, !tbaa !2406
  %11 =3D call { i32, i1 } @llvm.umul.with.overflow.i32(i32 %9, i32 %10), !=
nosanitize !29
  %12 =3D extractvalue { i32, i1 } %11, 0, !nosanitize !29
  %conv =3D zext i32 %12 to i64

So, the check at line 164 may pass due to the wrap around. And the overflow=
n result is later used in line 166. this issue exists in the latest linux k=
ernel i.e. linux-5.5.8 as well.
Due to the lack of knowledge of the interaction between this module and the=
 user space, and how serious the issue can be if the offset in line 166 is =
calculated wrong, I'm not able to assess if this is security-related proble=
m. I'd be more than happy to hear your valuable opinions and provide more i=
nformation if needed.

Looking forward to your response!

Best regards,
Changming Liu
