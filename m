Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B84EE78F1
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 20:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfJ1TIq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 15:08:46 -0400
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:25537
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727664AbfJ1TIq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Oct 2019 15:08:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+p7RDu6UKVzPBP8WMY9Rb5ZGPc2Dhg34prD5psK74Jq9Qo7/FHvK9erd9t70mw/KgM6mdWzewcvrfN32UCbGaaxRcj3gnkS6gc+Hm02PZ3YDXglVUslT3BLbyKVajeBfDH/GfHjNfCIIqCIVk53Xv1Va1ce61rR65mP2PBI/3b4KrFbCqlF7fvTpR8S96HiR3Tg5GPfcbyBrUtfKUSfhNP9SO4gIJcEjx8TNGJlQiPS8Es7TTtsOa3YDKdme8KUqqmdlcye7fZwY6TKKmhTe2aDzH5e+Or47MyzAbqsO0L/pSnaTFOcNNlTScq/Xu2TIqfO1/Gu0rrS3d9m1nBG1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AceR7SZO1DuVWj8JGnX7FqYUEzegP8CEpt/NyqtsMAU=;
 b=RnfcHy01yW0lvaHG4vM734USt11pxFr3YTk9mH1z016nrVTuydHVni9A4H0Rwg1DsgkGjijpPEDjPgPIu7phtmSMDPfIhtAXohz6avpqnfv7HJjPmBl8BSimqaR7/CA358CBLRxUK6SNXiTP5FRpAMXh/K9ILn3R5dlOhBee5hZYlYOwSki/X3t7N///9ZrBYEcG3SB4ti0IK8TUIlvKqQT/j5FGyjK2dlctFartBP72Di1obkB0CRBQJTJABCtuX/baQ8S0LqslaRDV4pm7XbDLWNqnlIu60w8lCy0KqAPJYBQSvNcCdsdX21kcfsZCV/yy8igjeFf+rlB5QUaU8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AceR7SZO1DuVWj8JGnX7FqYUEzegP8CEpt/NyqtsMAU=;
 b=Nacim+ByqpVoJg4+muAn8DjLSclfsF3c99fL3VKA4DUwmbIPwKYWGjx9ITEG1W9HE2xwsEKn/7I9/PvtU+3DtaNNjkK8Bze8CvLkRS7IygMea3ipSTJpkmVF8iBio6PYTZoTVrhdauKPsRgNb/mGZivRI3HOyKQbWGXSCPWrLOc=
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com (52.135.129.16) by
 DB7PR05MB4122.eurprd05.prod.outlook.com (52.134.110.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Mon, 28 Oct 2019 19:08:41 +0000
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::18c2:3d9e:4f04:4043]) by DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::18c2:3d9e:4f04:4043%3]) with mapi id 15.20.2387.021; Mon, 28 Oct 2019
 19:08:41 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Adit Ranadive <aditr@vmware.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bryan Tan <bryantan@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [PATCH v3 for-next] RDMA/vmw_pvrdma: Use resource ids from
 physical device if available
Thread-Topic: [PATCH v3 for-next] RDMA/vmw_pvrdma: Use resource ids from
 physical device if available
Thread-Index: AQHVjbuXeycPE9XXtU+zc/m6Wa7saqdwarqA
Date:   Mon, 28 Oct 2019 19:08:41 +0000
Message-ID: <20191028190835.GZ22766@mellanox.com>
References: <20191028181444.19448-1-aditr@vmware.com>
In-Reply-To: <20191028181444.19448-1-aditr@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR01CA0031.prod.exchangelabs.com (2603:10b6:208:71::44)
 To DB7PR05MB4138.eurprd05.prod.outlook.com (2603:10a6:5:23::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6a850a6a-a4c3-4615-7feb-08d75bda3ec9
x-ms-traffictypediagnostic: DB7PR05MB4122:
x-microsoft-antispam-prvs: <DB7PR05MB41223663BD6394346CE56DDECF660@DB7PR05MB4122.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(189003)(199004)(316002)(81156014)(8676002)(8936002)(25786009)(6436002)(86362001)(33656002)(305945005)(256004)(6512007)(7736002)(6246003)(6486002)(54906003)(64756008)(66556008)(6916009)(4326008)(478600001)(66066001)(229853002)(1076003)(4744005)(36756003)(52116002)(476003)(66946007)(66476007)(81166006)(6116002)(2906002)(3846002)(14454004)(186003)(71190400001)(71200400001)(5660300002)(446003)(386003)(102836004)(6506007)(2616005)(66446008)(99286004)(26005)(11346002)(486006)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4122;H:DB7PR05MB4138.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Atvn8JKuOfrDY139F9ITL8rG/uPg0TZHwbRzg/iIcfxOCWc5WmGmgGMbkQ0IFMaQwBpTY2l04wb2ffJKWd2iliEQ2VkuNmgFfvu1uhKTpwAR2nwddbtS96fKYBHstPI0cfJdpO5D0oM4lT2janCSrc21omgTmMhYUSaCEa/To7lZ9wpqPiLa7AX7Up8goXHzE5lC3ccXm9aMjz/Qwoy83nDw5XKxAMG/gHO7gY40xQZI2/x9FAb9GHnQaU0aK57EHlbjBBVJD7I3jkVJdZaBrv4KS/EXI1WLUX055+6VAALrKSseBIhBISBMo/LhjeEYAxh3BZSm4xd0NtrfXHrzYOtdMe2ga/Lxh4d8CBKri2hAdX+92tbJpiko108aaYdsDq5+EJROSxiQeZ8ub2ywjPSP0g05yS7NdTFDtD2IwJ0hGYHHe5w2NCEZtzcvDRsI
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DC18AF0B220A43489E8AEB0B0FDF4A5B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a850a6a-a4c3-4615-7feb-08d75bda3ec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 19:08:41.5302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nFRhQHwQ3whKJhS/ZktclbLsd06Z0ZTOetKbcxLZdHJJt/1y2cRWfUGkpGgA+Ts41Va/8qsmkOrMbk+fNOEiRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4122
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 28, 2019 at 06:14:52PM +0000, Adit Ranadive wrote:
> =20
> +	if (!qp->is_kernel) {
> +		if (udata->outlen >=3D sizeof(qp_resp)) {
> +			qp_resp.qpn =3D qp->ibqp.qp_num;
> +			qp_resp.qp_handle =3D qp->qp_handle;
> +
> +			if (ib_copy_to_udata(udata, &qp_resp,
> +					     min(udata->outlen,
> +						 sizeof(qp_resp)))) {
> +				dev_warn(&dev->pdev->dev,
> +					 "failed to copy back udata\n");
> +				__pvrdma_destroy_qp(dev, qp);
> +				return ERR_PTR(-EINVAL);
> +			}
> +		}
> +	}

This is just supposed to be like this:

+       if (udata) {
+               qp_resp.qpn =3D qp->ibqp.qp_num;
+               qp_resp.qp_handle =3D qp->qp_handle;
+
+               if (ib_copy_to_udata(udata, &qp_resp,
+                                    min(udata->outlen, sizeof(qp_resp)))) =
{
+                       dev_warn(&dev->pdev->dev,
+                                "failed to copy back udata\n");
+                       __pvrdma_destroy_qp(dev, qp);
+                       return ERR_PTR(-EINVAL);


I fixed it

Applied to for-next

Thanks,
Jason
