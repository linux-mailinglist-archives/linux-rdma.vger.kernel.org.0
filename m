Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D25C1B6ABD
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 03:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgDXBSE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 21:18:04 -0400
Received: from mail-eopbgr00055.outbound.protection.outlook.com ([40.107.0.55]:36823
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727063AbgDXBSE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 21:18:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fF8cllWJmiMtXxZyIEjJt8NxM94KCns6IstlGberFlxKc19Th9nhyJVfS/QlUYTFRU3yhkj06hATdp3rRTlLniItBxYzpP2llq24aKSN5yMt8LovLDW/rHMPIH0PiSU/f20QLrTbH/eVeLFqh78n7EJRx+5s60KHJoLbG+99i2cpf4bcO89oPaQ49Qq2I8Zj3SwaSE5sd5CnJQ2KW1VE+u3tCeJH0kFGZQyUOMsv+rVopUwwsIWO/bBPhJ/FtjuM+Ng2zA8xiDmM/lR+NY9jrp4uJep7YLQsERDp02HNvmSnAKSZYSKuTN2JujEYUux2+b8mYPfZMF5FXozD9WZaLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4qYH8rmO5kMFF9/lxLBbdWe1+49HoWOazS3y1+phKk=;
 b=kNgPqy7QOmms07OPPvVzPy2JayBkHVKJMsTXTvRgDrp6vVngprmP+m5+rCPkWzNkm/mrOE6LRYVRZsYXdy97hcdivVVn78Z3aO2cO2UmJPGZRDtPKHNoXzfKzNCUy3kFx2wwx0rqLDVe0I368beNfFx8xp40G9f44+g/Kp+BsQxIMMYu6SNb6lrWDbxIEU1WokbMDP0HdJk1x6KmIW8L/XA8JHpu47UNkNaA4OzpKRIOZ32K8CFO5DrioAjJUBSP6D090jC5ZW0uKbe9XM1e3aHKedJXkzukFCOav5+8ugL3nsH/sP3oweZt5X8hl9V6s26E8GMlkCiXoJ+c8/3/Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4qYH8rmO5kMFF9/lxLBbdWe1+49HoWOazS3y1+phKk=;
 b=FKDkjOvCIZAOrAPhUe0eEbywaLcpXrEiSuxx2uY7tfJCNiIn41/Uspp5ZJvrQKRbh584+ulIM3tzTczgCH3VTuLrhx6uEH3P906e/lDwfBvNrPQuuyP5rKbMvfKIn6YvUywVR0T1UKKpqL2x+CmcxPT1UcTBwf9bkvl64evrkdw=
Received: from AM6PR05MB5014.eurprd05.prod.outlook.com (2603:10a6:20b:4::13)
 by AM6PR05MB5537.eurprd05.prod.outlook.com (2603:10a6:20b:30::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 24 Apr
 2020 01:18:00 +0000
Received: from AM6PR05MB5014.eurprd05.prod.outlook.com
 ([fe80::fdcf:854a:cffb:1ac3]) by AM6PR05MB5014.eurprd05.prod.outlook.com
 ([fe80::fdcf:854a:cffb:1ac3%7]) with mapi id 15.20.2921.030; Fri, 24 Apr 2020
 01:18:00 +0000
From:   Yanjun Zhu <yanjunz@mellanox.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] RDMA/rxe: check for error
Thread-Topic: [PATCH] RDMA/rxe: check for error
Thread-Index: AQHWGVy13PkgHRNx8kiMNYeLb1O0RKiHeXoQ
Date:   Fri, 24 Apr 2020 01:17:59 +0000
Message-ID: <AM6PR05MB5014AED9AF55149641D2E7FFD8D00@AM6PR05MB5014.eurprd05.prod.outlook.com>
References: <20200423104813.20484-1-sudipm.mukherjee@gmail.com>
In-Reply-To: <20200423104813.20484-1-sudipm.mukherjee@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yanjunz@mellanox.com; 
x-originating-ip: [118.201.220.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 375bc872-d738-4f32-b5e9-08d7e7ed541b
x-ms-traffictypediagnostic: AM6PR05MB5537:
x-microsoft-antispam-prvs: <AM6PR05MB553793FF999FA635CF039C13D8D00@AM6PR05MB5537.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB5014.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(2906002)(81156014)(316002)(52536014)(26005)(66446008)(64756008)(66476007)(66556008)(53546011)(6506007)(7696005)(33656002)(55016002)(9686003)(66946007)(110136005)(186003)(76116006)(86362001)(54906003)(4326008)(5660300002)(8676002)(8936002)(71200400001)(478600001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fDL84t3H/QtwVTIcHosydBXjn60urCrP3bCLWwmLo+uZbhbD2QYSt3pSw/X21trau8Ow+hiHWKTkcW06MYThIUdnSem11KbZ2dYdSDa/nkkPUiCQAKoXbSMmydtGlkFiLlHVtrS77vRlWYBFOkK7AhzWHM4djU+fYF6ULHLhrNSBOwgDhok7YtGOLlrR+VbGh412chkjPSi6an9sSrq/VUWkskWHw6q07XkpZGIpoJGhxB9orzI6Ezha4p3BrfmA2G7d8nMeQnioyFo3InaC/sFR4HiynRUtRK+UA4IrGxlZ1OutooDevWWTY+a8y66wrLZfnmbXROCBFI8M4/nEs1uhD+e9TSaFbsVT/PPMPzrLHu475YDWa6Pjyy8C8ow0ioKBdmg2cLMrlKRnQPgfCvoq5yq2vKvARCVmiN9ljQv+AjUy7TfAiMIHPb2C2aNT
x-ms-exchange-antispam-messagedata: n4ElyU08rkNXd6XEXf5V6pG9e3BhnVduStv8xd+lrtPO54qD/z+CByO+As4vOi99VEJsgRRw9FAs0FLPZN8WnPiv8wRm0GhYboyxhgqV0/os5VmQGJZMfEo9OhYbq0R20HsDvAEiTkv5+S76/4181g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 375bc872-d738-4f32-b5e9-08d7e7ed541b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 01:17:59.9692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5WRzNggIvhaeTafisgjQkccW2P34ZWZ9HrNQyI1Ku5rZZ4UX1sWSga6eTcxxP49g0Z5wse5nGn4bv34TvYtjKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5537
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks,
Reviewed-by: Zhu Yanjun <yanjunz@mellanox.com>

-----Original Message-----
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>=20
Sent: Thursday, April 23, 2020 6:48 PM
To: Yanjun Zhu <yanjunz@mellanox.com>; Doug Ledford <dledford@redhat.com>; =
Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org; Sudip Mukherj=
ee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] RDMA/rxe: check for error

rxe_create_mmap_info() returns either NULL or an error value in ERR_PTR and=
 we only checked for NULL after return. We should be using IS_ERR_OR_NULL t=
o check for both.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/=
rxe/rxe_queue.c
index ff92704de32f..ef438ce4fcfa 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.c
+++ b/drivers/infiniband/sw/rxe/rxe_queue.c
@@ -45,7 +45,7 @@ int do_mmap_info(struct rxe_dev *rxe, struct mminfo __use=
r *outbuf,
=20
 	if (outbuf) {
 		ip =3D rxe_create_mmap_info(rxe, buf_size, udata, buf);
-		if (!ip)
+		if (IS_ERR_OR_NULL(ip))
 			goto err1;
=20
 		err =3D copy_to_user(outbuf, &ip->info, sizeof(ip->info));
--
2.11.0

