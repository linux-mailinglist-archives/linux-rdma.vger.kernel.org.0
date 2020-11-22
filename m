Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114B82BC911
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Nov 2020 21:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgKVUMY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Nov 2020 15:12:24 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:31560 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727366AbgKVUMW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 22 Nov 2020 15:12:22 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AMKCJ3S007579;
        Sun, 22 Nov 2020 12:12:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=MhoSPYw36XdWgNH/OaVgebsXZ3yb7RsJ0CGHdGSBhzU=;
 b=Iq3Wz60oLo4We9XcEeZJrvL34dTLGLkhQA8zwMzg10K8dgDxs2nwek+gDkUlzdCxOtmG
 5e4rp/bmC2SYM1kwXBtK2Q1DoRaycUqkzKkt9RYg+4l93dBJgNAwYx2OLHlbhyU62bfS
 wiMi5mh+x4SJHdrKn0akrDT0T5CE5A3ciyLLeGp5L68fcYkuOCzXQ0UgdX/0kMxyJSAD
 sC/cIktDZu6n7tx7lFYLHXPxz2gZEU9BoUUh7AaIpH4jLuB12vK71fBLGV1rggrY5Eyk
 3zNWNwfBS1g6lrW/d8zBdmSlfEF/8CTAfO+9K2KWLeMUJHP7gqKb711wdhO3qmgN/ryH 3A== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 34y14u3ek3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 22 Nov 2020 12:12:19 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 22 Nov
 2020 12:12:18 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.52) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Sun, 22 Nov 2020 12:12:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xo23cqSkfM/tUXSoCDklss0Q+Gt0i6TSvJBivlyDZp41P197Im5JYV+BRbweHa7E+jMEJFMZ3lJBe2tS9U7/rBAOrD7bwxf2PBq1t9RjvLts45S7n4el5SDocqUyoxwoNYPI55RbR5vtHTgTsHdZPqqr+Q2vhFxFKIOXUdIdeZoj9bEtgtodoAhHmT1jtQ3KUwA9YeH1WefcAYMn7pXaB81eQniHysVXMKg0oD/2byTrKf7AMasrl0j4V2LeujwcVWuY/O5iamYJClih67h/UBEUAvpCMs2twzNB32uLNg36JF9VyqHDWTp+w+XVQ5WYbzbPsWWXoqCRkuJHcY4DsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhoSPYw36XdWgNH/OaVgebsXZ3yb7RsJ0CGHdGSBhzU=;
 b=Dl1ZfCqavr86QpFekzzbfru7k0Pp/LR2p9sgpaAYHCiq6shDVQ//yAR8o2pH7cGQ6E1PA7G/pld8053RMgxFmtA6JiCG3Gz2Z8qr52Wv2FBaBTGV6qrYM95DTN5iFPt7j7zJit5W1/yriyQyVObVfRMXzChAeJ479xZcAun6F+yvzWMpZqKIrsSpXGyOzLgq3rUPAIHNPxMD3tJXIKsixy1P+0cEObGNvUgMbLY2JDLg6mhi0Uk4nOeFNFe2wPjL5kAli5NvtemC82lj/OUHCBI76Ssx4pJC0gSIStZ5rlj9j42NAg7wLhVXjmoJ7CrWqmho7nt5DLtgcZTqxMbE+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhoSPYw36XdWgNH/OaVgebsXZ3yb7RsJ0CGHdGSBhzU=;
 b=LR7mx6ithz/Y4i2iHeL5dTihNxCzp3lhgXUeYWqNCAFro6J3evpLdw6rWUhK/gFmxKLvUpKSqpT6Xdv2QJdRG2mealeZUyJzk1KPZ4pd9QCHsKNzM/Fe4wJcKR4ziq9IenlFGaObL9UPY8yWPvy7rclrkrV4nVM1OjpipTt71cs=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (2603:10b6:208:163::15)
 by BL0PR18MB2292.namprd18.prod.outlook.com (2603:10b6:207:45::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Sun, 22 Nov
 2020 20:12:15 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::ec13:dcaa:6533:c2fa]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::ec13:dcaa:6533:c2fa%4]) with mapi id 15.20.3589.020; Sun, 22 Nov 2020
 20:12:15 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [EXT] [PATCH 035/141] IB/qedr: Fix fall-through warnings for
 Clang
Thread-Topic: [EXT] [PATCH 035/141] IB/qedr: Fix fall-through warnings for
 Clang
Thread-Index: AQHWv2sCM6Hcq0b+bkOyw93+E3dG1KnUmJcA
Date:   Sun, 22 Nov 2020 20:12:15 +0000
Message-ID: <MN2PR18MB3182F593C7A23B42A3961208A1FD0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <8d7cf00ec3a4b27a895534e02077c2c9ed8a5f8e.1605896059.git.gustavoars@kernel.org>
In-Reply-To: <8d7cf00ec3a4b27a895534e02077c2c9ed8a5f8e.1605896059.git.gustavoars@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [212.199.69.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa151712-2468-45dd-ec83-08d88f22e7c2
x-ms-traffictypediagnostic: BL0PR18MB2292:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR18MB2292355DBC9F79A2C3ACEB63A1FD0@BL0PR18MB2292.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1tEOq19RfUBWx/98EcZgDhXcIJHTvUBvzThTltyz0R11SRARaelhTzd9Dr9XvveZSUaBC2znIXu7e3u+5yfwJ00d4nlQ0lKO44EZujYsXE5IVCpb2ZftbS8cFnwu6paDUwwx+/mS+XufbqzNuMRhwyun3bnVlAjNn/MJMHq4HSOn5p6d/wJ63mrTUCYnF2atjMXF8eWB21qwGA6gJ3OwZbK9X60CmQGutmVH5C7Z2X/cBhpkwyuU5VkmEDBtJPDY7M7SpcV/fgrCqLJZ++9UF6Jgw1RjW9Zv/VC6vw+psKrFFuccBN709Rvg/X+pI+3qH9nOxERPhX5XlEC4/HRhCiHF3yey2UJZ7hbkU5GhgNRf2eANiu+H55Xz3VeJfBJK2E8lG6tLU31fSVzOc/sQ1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB3182.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(8676002)(4326008)(71200400001)(9686003)(33656002)(83380400001)(55016002)(19627235002)(966005)(76116006)(54906003)(66476007)(7696005)(6506007)(5660300002)(8936002)(316002)(52536014)(66556008)(26005)(66946007)(86362001)(66446008)(110136005)(2906002)(186003)(64756008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: dpffGNa63oKCZY1R2kVqUQEGRzWObQO47LVsmK4JIsSPT5nB45yrJOw/6iYR+5CesBLtv/Oqi4RM4wnZ9q3iC7giql5GpBczkIeuDscY8p6obKOrPT+eKwUrchtksaSZdtSEBraD7WPUQbfNqRbq3u9BzIixja3C9PBJ21MmSowR6E7O+9wCQwZl8+W0qhI3gYCqZlKU65ohwFoNAULmXFIPw0Q8AHpbaMEVHcOnHzOrts1cBOUpoZoNTBdpcsfsk2JXEucMs3bSeKxoAh3mOlHitZvJ6iNMuhj5SzhIVR0vSn3/KliVJbpZFAIC5ZPwvftoB2sdb7l4RcefPgDjYA6T1qDQ+q/zOauM3sD+CK/vhnyXC51l77zNzo0YpmDnPQm+S2tLm/ls4NL4HVftF5toItCvbRyVR2nPUFH71PGsyMBrZRon4NVJMXUCXpSTQR1yJgBbgAoN5EEr7oR+5zKRPDVt/knTkxzTKWBlDx4uWr9vCqYVemywUj6cypGIszZWBfsUBzQ48EoRZB+Tq7e92cMDl+/aBlKb+PRYcOoIy7bAX8XFBKZtxnC1wrBUpl+tQfl/Xkmb7rpdBBf+sQr5aAR5BYwEKwRUvlk+EUidPbUzbNypfPaiUw8of9U+5vNnVqyKcnLuriNiA6+qPXrsy8Fi+UT3+kA9+QXAqeYpD0zwCEi6c2GW6yhEnmuL010d0Juhh0FJa73udd937SXW6mSmYBPKQ31LywW/GwMlV7DywY493TPGqRCpTgeuw/dASq7B8sINsiuB8ZxgaLRYlsymZJme7INaQFmSZMRJ2cFA3weh2HRYA81mmRL7IOjbJM7jjc4BNmPOLnYcDkfaW9bJzl55LG2iLFL5kaHj3E/iPRcSqwQkEGoJjU4gUHbPiXxxg6o4WCe5Rbj7TQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB3182.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa151712-2468-45dd-ec83-08d88f22e7c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2020 20:12:15.1327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1rV4yaTKOm6YmsMOvD3lVMrYwwvGu1p08CLusv2nou8yGW2kUEHncYaAj3WX5BbkhEStkS5BKZimKLv8V1GYCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR18MB2292
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-22_13:2020-11-20,2020-11-22 signatures=0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Gustavo A. R. Silva <gustavoars@kernel.org>
> Sent: Friday, November 20, 2020 8:29 PM
>=20
> ----------------------------------------------------------------------
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning =
by
> explicitly adding a break statement instead of just letting the code fall
> through to the next case.
>=20
> Link: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__github.com_KSPP_linux_issues_115&d=3DDwIBAg&c=3DnKjWec2b6R0mOyP
> az7xtfQ&r=3D5_8rRZTDuAS-6X-cGRU9Fo4yjCnkS1t7T3-
> gjL4FQng&m=3DZJjyam8OGRTmM8iCzOSDOL7dMn31Pmw3aA-
> QOVDY8eg&s=3D4rQYW1K3xAzeRV7SRkrvaivRWz2WwEuuk0ZnjnDTA1w&e=3D
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/infiniband/hw/qedr/main.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/infiniband/hw/qedr/main.c
> b/drivers/infiniband/hw/qedr/main.c
> index 967641662b24..10707b451ab8 100644
> --- a/drivers/infiniband/hw/qedr/main.c
> +++ b/drivers/infiniband/hw/qedr/main.c
> @@ -796,6 +796,7 @@ static void qedr_affiliated_event(void *context, u8
> e_code, void *fw_handle)
>  		}
>  		xa_unlock_irqrestore(&dev->srqs, flags);
>  		DP_NOTICE(dev, "SRQ event %d on handle %p\n", e_code,
> srq);
> +		break;
>  	default:
>  		break;
>  	}
> --
> 2.27.0

Thanks,=A0

Acked-by: Michal Kalderon=A0<michal.kalderon@marvell.com>


