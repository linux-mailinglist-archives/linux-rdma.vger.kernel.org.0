Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A670E0A1C
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 19:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbfJVRJX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 13:09:23 -0400
Received: from mail-eopbgr30046.outbound.protection.outlook.com ([40.107.3.46]:49086
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730701AbfJVRJX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Oct 2019 13:09:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvLcFL7t0zD2GgHb+NKtG0fTdgHwn0AI59/0mzgkaoAQeoebR0r2pJgetqGLrh7opgA03/46ZAanOVtKTZkE0W3+2C8BKUQH12B8Z+8+AWsPNwCEHxzbERkTFRBHpbiFn1JJiNTWBI6fix4G2ky9CbJpnEH0XfoA0Q6Q70TE4ooQq6qRiytkrZPAivCmBPxrVUw9iDNT3P+vai+dBsbDL4RqAHcpXkXs+Wt3Uog4UAbMGfPMcY4zplMMTvdFnPawa2C607Ua8qjPyPU3XnU75meldmwVoxeFH9OxGX9NIpy/Ef7DrftlzxpCBBQjMbdJn26aJFVoImPhlRpCWKE/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80dU3RQN2bmXaYhttvIKpAOWsikzhbGrgm8lrn5NWAs=;
 b=Nth2oInKI7GZr3mRzn1ranHubHT5eSgLJQ1wXOjrh/mrrQNvz9V5J38ZAzX4/qQcVaJB/U4GiQAD4RafKyYEFmtZISl1cBrssk7gCzGY4CYTs+PrxJMvQ9qYXC036vyQtI+/3vdT/DU60rTHT4RnEGde9MbfpSAD7xluHeHoBasddY1H7D53Dg79TxCzbOUCYK4xIKkc4QD4h3wTnjFjm1A3F7qCpw77R0iuKS3rhICzMqXYPOBGGZ+eKQmV2lcR3r03J3VlGFLMCIDA/u0oQULnMbFpeliQ6GMOuCoWbAQuGIIK94VaFBVetzWMUgyQSBfd65pRYibO1SkrI309Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80dU3RQN2bmXaYhttvIKpAOWsikzhbGrgm8lrn5NWAs=;
 b=sJ980dynn9OHseghRUo31mwlSGHGwd4zCeW639IY3Cuns9fcVrRDl15CUn//8FY7Xs10/nxpIEFu6yMZ1cT7lBV7w7Y0Cv+74vmBQQWbKppAIAbbQbdLMZgNZXwoRDI2Cw5Z09XUnVh46qW0ckGqeFlPlFV6e6Z/oD8bBvW2Hhc=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4221.eurprd05.prod.outlook.com (52.133.13.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 22 Oct 2019 17:09:19 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0%7]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 17:09:19 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Jerome Glisse <jglisse@redhat.com>
CC:     Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 2/3] mm/hmm: allow snapshot of the special zero page
Thread-Topic: [PATCH v2 2/3] mm/hmm: allow snapshot of the special zero page
Thread-Index: AQHVg5noYFRN6Uol1kOCsSoXbSSn1KdleVOAgAAi3oCAAGI6gIAAzpcAgAAh44CAAADFAA==
Date:   Tue, 22 Oct 2019 17:09:19 +0000
Message-ID: <20191022170916.GL22766@mellanox.com>
References: <20191015204814.30099-1-rcampbell@nvidia.com>
 <20191015204814.30099-3-rcampbell@nvidia.com>
 <20191021184927.GG3177@redhat.com>
 <95fa45cf-a2ce-fab8-588d-8d806124aef3@nvidia.com>
 <20191022024549.GA4347@redhat.com> <20191022150514.GH22766@mellanox.com>
 <20191022170631.GA4805@redhat.com>
In-Reply-To: <20191022170631.GA4805@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0113.namprd02.prod.outlook.com
 (2603:10b6:208:35::18) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd213a93-3cb9-40c7-eccf-08d757129398
x-ms-traffictypediagnostic: VI1PR05MB4221:
x-microsoft-antispam-prvs: <VI1PR05MB42214C5FA54E2C5D7234FCF1CF680@VI1PR05MB4221.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(199004)(189003)(6246003)(476003)(102836004)(2616005)(5660300002)(2906002)(446003)(6486002)(25786009)(26005)(4326008)(1076003)(6436002)(11346002)(6916009)(229853002)(6512007)(186003)(36756003)(486006)(66066001)(66446008)(64756008)(66556008)(66476007)(256004)(81166006)(71190400001)(99286004)(54906003)(305945005)(3846002)(66946007)(71200400001)(52116002)(76176011)(86362001)(14454004)(316002)(7736002)(6506007)(386003)(478600001)(33656002)(8936002)(8676002)(81156014)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4221;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UHzFgqtFVY2AvL7QwWCyu6SYGIeD55/2Xl0rgz7KzTP2qjMczIwa84rqiGpOZbSsdhoCbktRa117ItRuMdIGMvt9/QwoOUPfy2MUBQRGOKdk63w3DKQ1f2CEDMy4qrRt6giE/hBNIuMEIrzDGZE6ltVSHNHwnHYPlknZHfua6TLTkQCfQF2IZrPLtubbO+P2ykAMPRfXuwTE6/tPDTN63Bfa0nvRZEhQ8LJHX08xdjnDtWOQB6R9Bd8ygk9YzLjv7k4E5Jh4NootqFuJATHNSCHXnOZSozGcNiFDaJjIg4Ro0JSteEYmNdbVPYiYgKygBQiIaVjTCjw9P1DV9AFJ/+hMfNfzN0Tjrm9voDox9/IXbEQaWv/4EbuDRV5rvmE2WSo+XR0F5zKsCqZaY4h/giM20JzDs80PA7V/aeNhsdI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0B8B87066FF37141B680B6F7191434E1@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd213a93-3cb9-40c7-eccf-08d757129398
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 17:09:19.5444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OaqtpSmwPekKCPXAAB5K5q6lQCSQlMv8MpbBONX+Nu82Q1tHoHMusCoqw/itujwn4efqxZEjq97uXjMC5iiAnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4221
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 22, 2019 at 01:06:31PM -0400, Jerome Glisse wrote:

> > > That is fine, the device driver should not do anything with it ie
> > > if the device driver wanted to write then the write fault test
> > > would return true and it would fault.
> > >=20
> > > Note that driver should not dereference the struct page.
> >=20
> > Can this thing be dma mapped for read?
> >=20
>=20
> Yes it can, the zero page is just a regular page (AFAIK on all
> architecture). So device can dma map it for read only, there is
> no reason to treat it any differently.
>=20
> The HMM_PTE_SPECIAL is only (as documented in the header) for
> pte insert with insert_pfn or insert_page ie pte inserted in
> vma with MIXED or PFNMAP flag. While HMM catch those vma early
> on and backof it can still race with some driver setting the vma
> flag and installing special pte afterward hence why special pte
> goes through this special path.
>=20
> The zero page being a special pte is just an exception ie it
> is the only special pte allowed in vma that do not have MIXED or
> PFNMAP flag set.

Just to be clear then, the correct behavior is to return the zero page
pfn as a HMM_PFN_VALID and the driver should treat it the same as any
memory page and dma map it?

Smart drivers can test somehow for pfn =3D=3D zero_page and optimize?

Jason
