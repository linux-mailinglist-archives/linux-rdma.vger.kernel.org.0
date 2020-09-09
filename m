Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98326263424
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 19:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbgIIROo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Sep 2020 13:14:44 -0400
Received: from mail-bn8nam12on2105.outbound.protection.outlook.com ([40.107.237.105]:12865
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730201AbgIIP3H (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Sep 2020 11:29:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9MH3oNhlZ9ls1R9VJs0QMyffdResM02JKqmiRWnMl47rO7AzitJXBsffTvMNuuj5gdmHXkYnwtMhh26K2YseoGKPUn5xJBl8TdGD1T3O1/C4mYnrAtTZe6Jt4Ro2AqT2wxVZgbnepwTIhbtPfgL6PiFapyNKsznQnXs//XSHj7o1Jw5lsgx9OhXDwOG2APbJhHqxIe1jToKENi01P74LnGSVFkIp2NWJfIIf+jYTAv8GPNJc3ew2TD3nbu2B6yqqy004Sx3j5G+lf/m9wAHw77CtKtsuhD1AUz18snptLB4G+0vqvhPrLTKw03Og0cwtVhhGiNe0ujo5WkCYgsudQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWKhIKdt/sNSj6n+/gcPfB5hebExkceJpbIDzBgig48=;
 b=h118os+kEjdOAkOQtj5xrNUozbI/6zH4g541GrEOtM1VeWvke0/++yeA/AAcVQIX8ZCIKfXwIuH37NG88EfmusZsdY7yErk53/4T6+xq2JRqTfx/ExVK8PYqKlTnbV9cPY0vRqxduIyLjsvqqnzUZgQmH7M3wkz4kMJV2RoqjeKfCcJH4wqzwWhF84a3XcukCZVYEA5/zvm8PurW2wgb7qY7qobtArTIzlox1mxOkZ8dEyNqGb9p7UecECHZ4uzBHotrLHJptx0WOeNO/Cmdcg+wZbpQzB5L2SKr6TfMWeXdqU+2AL1utDqL+xfH6jlrpCV/QdPGFoNYwBFVKMrVXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chelsious.onmicrosoft.com; s=selector2-chelsious-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWKhIKdt/sNSj6n+/gcPfB5hebExkceJpbIDzBgig48=;
 b=wZv4BVcXDxbvfaTPrbnfHXslTHsIp559JBu1/f+UoVIKIy+NAQz/ugHKQv28ufubcOP1oNIYHF/SbrvaoaDnCEL00l71Vk/8zdFDxDkF1dj1ughFNoCvxwYsVzgJKfAE2otJ+zjQCmAPIwXuHzcFzU7Jr70MV8NoAFXvksNTkxw=
Received: from CY4PR1201MB0232.namprd12.prod.outlook.com
 (2603:10b6:910:21::21) by CY4PR12MB1175.namprd12.prod.outlook.com
 (2603:10b6:903:3d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 15:28:44 +0000
Received: from CY4PR1201MB0232.namprd12.prod.outlook.com
 ([fe80::f969:46ca:793:4300]) by CY4PR1201MB0232.namprd12.prod.outlook.com
 ([fe80::f969:46ca:793:4300%6]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 15:28:44 +0000
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     Potnuri Bharat Teja <bharat@chelsio.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] RDMA/iw_cxgb4: disable delayed ack by default
Thread-Topic: [PATCH] RDMA/iw_cxgb4: disable delayed ack by default
Thread-Index: AQHWhq/HJkpDy+3//UGG2qQaNwmNy6lgbiqA
Date:   Wed, 9 Sep 2020 15:28:44 +0000
Message-ID: <CY4PR1201MB02327F3093F7DD29E08CCF32CE260@CY4PR1201MB0232.namprd12.prod.outlook.com>
References: <20200909134726.10348-1-bharat@chelsio.com>
In-Reply-To: <20200909134726.10348-1-bharat@chelsio.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chelsio.com; dkim=none (message not signed)
 header.d=none;chelsio.com; dmarc=none action=none header.from=chelsio.com;
x-originating-ip: [157.48.36.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef6bfa35-2b2a-4e4f-2e9b-08d854d509cc
x-ms-traffictypediagnostic: CY4PR12MB1175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB117563637385EAD06D9C45B9CE260@CY4PR12MB1175.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IF/cV4ps6ykqxl0+gbAU0FmtpPnSlX4e4fg2ADLTjcDdNrFSOI3UQcBexB8X+VR79kvg834r6Y0CVuOHi+jVbTy7muLKWzSFpzfoIO/L+UzNeqoqsEbSqWunMMkRZ/7c55MbQVBXPp3TFJGYgRQuTR+zc0/X5RPBHFX6/vaKSSVpQ1ufDWeDsWURl1wJ/N7Ez18OzrVmGRqsGR/vFlJ9NW06WBvJi1beCbN8fYICW6IS3Pq8TagXvA06JAG0OLy6mzAywV4ad2MwRES6/npvj+5vCGAcllafLFLtXLpuZGP4RMgh+DAQ5d1E6kZEjByY3eVZXYEDrToXnREVmIlfBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0232.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(39830400003)(396003)(366004)(7696005)(55016002)(86362001)(316002)(83380400001)(71200400001)(478600001)(9686003)(52536014)(5660300002)(8936002)(8676002)(33656002)(2906002)(66476007)(66556008)(53546011)(6506007)(64756008)(4326008)(26005)(66446008)(76116006)(110136005)(66946007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: TKwUoXOBr8ge7ZhnEYDTDUOzCz1c0o+PSk0X1ZhdV1QxLNlDY9M6AjTxycZWf7Zqa0u3Zel7WBUYw9vw7tAGPtAykmv+OC1G5sQkOVHaMFRP9aDVM1le0VOAQVp9rYFjKwhqkCN+WtUCWrTMe1YOpVAeHJ2CqHOYdhXBwV+ngLSu7+69w/GcfqfJ24XRgyGw/30I9XiWxIdzf3948MwcVudmE/+7A4bNCcOzexYwSPm7Q2qUluDca2WH8i2+91HdTj/IbIddK1Shc4yxN++hKhg2pGjbpEJv0wpmj/G3R4e12ZAmSt8rQwME+4Alpswubf5a/aFkhMsH8KjjT7busin2hl0mrmrrlTEekGKXJgEIu3ZxESuXmZWdgXceTuZ7LEuHKJb6HvBG7Uw+aTKgOd4Z0H6q9Cfi2Qd24uIwYWvbN35TyaQ9hrfIBa8vbEpLKIain0VPhCuwY7W/yfVcmGd4/sOirLSzH10NRTTqfjZzNlQ3lWCasnvMx6C4sFIDOlW+kThZHMvBv0Gt225ruhTimqmuFc8ZD3Z7BanzBn5l7wDgag/5zl5Kgp53qkdLQJXBfIEEhWY1rm5mC4gCZFCB6ZBUviwLFM+6UUKAcpmGlMZTLy2GWVuAWKXMA4ZXKx+auyhMzQ0qB3M8OQszzA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0232.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6bfa35-2b2a-4e4f-2e9b-08d854d509cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 15:28:44.1119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1MTFaVXJxtoabYq5wg3uCopKUB3HpUIelTIsRdXVhxOBrE40xq3P4EGGu3AV/+r3CSP8blI9Gw+DsY4/rnFFSCVhH0eOceO33KsfN/VUYeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1175
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Missed rdma-next subject prefix. Resending.

-----Original Message-----
From: Potnuri Bharat Teja <bharat@chelsio.com>=20
Sent: Wednesday, September 9, 2020 7:17 PM
To: jgg@ziepe.ca; dledford@redhat.com
Cc: linux-rdma@vger.kernel.org; Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH] RDMA/iw_cxgb4: disable delayed ack by default

Receive side delayed ack mode is needed only for certain area networks/ con=
nections. Therefore disable it by default.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/infiniband/hw/cxgb4/cm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4=
/cm.c
index 1f288c73ccfc..8769e7aa097f 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -77,9 +77,9 @@ static int enable_ecn;  module_param(enable_ecn, int, 064=
4);  MODULE_PARM_DESC(enable_ecn, "Enable ECN (default=3D0/disabled)");
=20
-static int dack_mode =3D 1;
+static int dack_mode;
 module_param(dack_mode, int, 0644);
-MODULE_PARM_DESC(dack_mode, "Delayed ack mode (default=3D1)");
+MODULE_PARM_DESC(dack_mode, "Delayed ack mode (default=3D0)");
=20
 uint c4iw_max_read_depth =3D 32;
 module_param(c4iw_max_read_depth, int, 0644);
--
2.24.0
