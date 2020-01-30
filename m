Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8162114DC16
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2020 14:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgA3NiC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jan 2020 08:38:02 -0500
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]:17730
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727228AbgA3NiC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Jan 2020 08:38:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cceoRywM5vYYTePqbDBaeyt6jehAN1cFVEOBFYcaiV6GlofKmPDkQkXitXxNWBO5ooXLAtMG9Z8mETndrlF1ozXWq7BNYcb+JHH3WkRh3UA7POsLXqixC0qqiwZthsFDuve18ExGqc6ATefojUvQZljZC+ihV4Yy7JX0slNbJcltwbtWJ/1OuYgJGm3QrtiAsh+4gTESw9spU8TyRRAKpbt3KsvtFQQhBWuVdSTQ5Wp0fpzk4hoaf+XZI9T03NrFnlbMXhFg1vL+0n6rjb+Sde5q4EDi5FTqWatTPtu97HNlkPyF7z9szdNVsl402TUe4Qpal03n8tgJZPaXmqP6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zv5WI/j7tahiWToZTf1jvqizSscXaYxo8ZLilxsj0yA=;
 b=nNU3+AR8BNlWjm0N51S+ac/uz059NMhroXX+l94yw+9KeQxJ327pW5tfyrr7dmwzBbNlDzIXf1vYT/q+unnEto/eQOQNKXiJn7L93m9xrMIdQiAs9TozTGydtr/keUWHZw8kIyVMU7PbjxE9JB9ceuIWl3MqPbiHwT+z3aDszr6ykE3m91hC+KSRzUQO100gwAHVDq/j6Mt5QB7w2Fqrcrg1PjVREhXZcb/NM+2cToG0icSwqAgec1x0wXIV+STG/owdd9o4uB1OAl3ei7ZICyiJgGFB1deu4CS9pGy9saz9KGF6wwTz5D9ats8E5wpgfQ4ecMhBsJtVo/g439v+Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zv5WI/j7tahiWToZTf1jvqizSscXaYxo8ZLilxsj0yA=;
 b=YkN88P4WedNNLdYJ6hzXXhDcBttLb9gN0G91xo6195kCDh6lbNbO0mN7VwXAQGwqj9dz0Ar4dVFsm4I/Km6bILAZt+vlmXY6BVGMLLSUfRRZ1S4aTw8g7BTpuutk3BPeK+mxIcwWrdlL75pWdJsK+fegiR81cMgZ9Qd92OSFdbw=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0SPR01MB0085.eurprd05.prod.outlook.com (10.186.191.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Thu, 30 Jan 2020 13:37:58 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::445c:4a14:1020:2346]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::445c:4a14:1020:2346%7]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 13:37:58 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: RE: [PATCH for-next 1/7] RDMA/bnxt_re: Refactor queue pair creation
 code
Thread-Topic: [PATCH for-next 1/7] RDMA/bnxt_re: Refactor queue pair creation
 code
Thread-Index: AQHV0nqJgloWrcIIhEyENi/xgAmxcqgDP4+A
Date:   Thu, 30 Jan 2020 13:37:58 +0000
Message-ID: <AM0PR05MB48669BE3D4E5939ABFCADA1FD1040@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-2-git-send-email-devesh.sharma@broadcom.com>
In-Reply-To: <1579845165-18002-2-git-send-email-devesh.sharma@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [106.51.31.117]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c81c1fe5-9413-48bb-6729-08d7a5899eae
x-ms-traffictypediagnostic: AM0SPR01MB0085:|AM0SPR01MB0085:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0SPR01MB0085138F3F6032A06752D39CD1040@AM0SPR01MB0085.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02981BE340
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(4744005)(186003)(26005)(6506007)(55236004)(54906003)(316002)(110136005)(33656002)(7696005)(76116006)(64756008)(66556008)(66476007)(66946007)(66446008)(71200400001)(55016002)(9686003)(478600001)(4326008)(86362001)(8676002)(52536014)(81166006)(8936002)(81156014)(2906002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0SPR01MB0085;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pZVSzwnK1OcPBKkFtiZ2VeO7cpHHLax8yi46ufacal/4VXJ6+Pk2sL9WPksjuX2nFFj24+GtHBFJ1ir082vQGhH3tMGW6NfEr5Zr1+SW2Kxv/0JGbYHH5i7CEyLvq9WLYWLiQTO2SzC6M+Fh+f2pbcw7GtkqvdOajviOwQ1+LrlIQdArIkbBNS21VsKvT/ikEfWkW7l9I2iTdvUl+ovEBezyn6XJtRLlnGwh+2Fjt/Z3VezUMxlGjWJKeA4pr5TQECKsVPlk8B8Ed2Xjkuhyb76g1rm2WcGK548OM685RPfxOPBaRCyoPEixlBsC1SKyYld5xqP4gsFaSnnX+cXRSEcbkgcvktPP+zC0MBIqqD1gqSXbTVzSdPq8T4kHRKnYYlBmBcNyzuraUt2Lk9h+x4uh8UbjMiCHslE1pcltTFuOtkh3OrSZvWiksj95xst0
x-ms-exchange-antispam-messagedata: TmWX8yurzFRKpgnG8Yz5Mu96kqFipyOzN/gZ84OnFMshCa+DDsfTD7rZpaFAk8j3hxCX1QqtVQacoLFnsmBB8GRuzwbCPCvF8pVn3JQzl2BAyx+DygvO1vVBsgTKgfcfKUqtpNKVaAS0nX09xVSbYA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81c1fe5-9413-48bb-6729-08d7a5899eae
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2020 13:37:58.6327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QvKaVf35nMysGGpeP5PlJ5Vgx2N/7+00LjoYe0K74kiDvC7MHWZPB8OZ9WhH22XJUVgjvgNm19edl7h/7Z9RZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0SPR01MB0085
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Devesh Sharma


>  drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  13 +-
> drivers/infiniband/hw/bnxt_re/ib_verbs.c | 635 ++++++++++++++++++++------=
---

[..]
> +
> +	/* remove from active qp list */
> +	mutex_lock(&rdev->qp_lock);
> +	list_del(&gsi_sqp->list);
> +	atomic_dec(&rdev->qp_count);

Atomic inc/dec/read should not be protected using qp_lock mutex.
Please take it outside the critical section in new refactor code and in old=
 one.

> +	mutex_unlock(&rdev->qp_lock);
