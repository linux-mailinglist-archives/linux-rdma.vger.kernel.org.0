Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCB40D8A79
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2019 10:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389734AbfJPIGC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Oct 2019 04:06:02 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:51714 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388733AbfJPIGB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Oct 2019 04:06:01 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9G84na3017788;
        Wed, 16 Oct 2019 01:05:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=g7Nd9C3LZv/WczYAlxR5wsDdyWhy9oTP/kUISq5cUl8=;
 b=NtyjwJLewp+/Gr6lmEqx94kfFTZBmyzc1w1fnaBuxZkwKlYEdK69c+3blP7XzAZXo4hC
 OEonQVgut/1ihFA2zDC7D8X1DkNjIqIfgphywbWENtHUYA3wL5a/kKVPZdJ3Z2Yvfkmc
 7JAtkwgE0iudBTJsMcF+JVUMB012XKhWkT46SC9PClX0Qcjj3RMVVEKnjp0M9EyEzw8O
 CYgcVsmnHYN05tdCTHzkoGgkaZk+Jo4hVXf+b+aFMnOyk+SIOznFFmH0K9Eaaq6QJQK1
 V1U7h4lUbf5UuhzM87zABn+XDphDlysNe/MsjAhHbZCmfGMbMhD9pABIcXdGgLnuFA1q uQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vkebp5k29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 01:05:52 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 16 Oct
 2019 01:05:50 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.53) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 16 Oct 2019 01:05:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiaEMlpjJq4C8dLs3uJBk5DaeepbAnTCPj3HS8cywE6P0SRiW7d9wWTsiRJjItPqqZLRgNXvV13e24Vrhi7SHr0PHWzurNzH/DRdDUZr3R4CdjiSzEzEsp0cHhuxqVypvur1gbaAjLPlANJ2JCr3IP/SSaQwdD6ehB62MbdhbKTHXZm5XWbygkexMYtOXRAGqVlzpGJJ3nYngdp+aJqIfHRPBB0AephJW+JLgaVPtsuAln5SmNRGSRv+T9Gy3/KriAtJwGEIUDqv8AT8h5ycpx83n4BUXhVRVNq9fQF5Bz4gxv2uClRjOxwlry41fiGlpcKF6fLR+cQBz8BI2yJz8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7Nd9C3LZv/WczYAlxR5wsDdyWhy9oTP/kUISq5cUl8=;
 b=Mr9tgTKdtHj6sl6nGL/JTTLNFvZ+nmHgsq1v1NOUDq1Bwz2qc9Bpnv5trHKXkqwWuLsEP1GNsGa3oinavhw7VbRM8xM9+3qG+aRFStSiKKNP7a3CRXnQJw2tCFGQSfK9s6NItbukALL20xK/T7s2laMh5gdBUKUgauZMN9c+yvgbYm98EML9HSzRqJhsPkPnZrvdmA6CKv25Rel7H1Z8EW8Aqx6fS6psenko5XwMQdfEqahVx1Nb8O5bsmNgJvIL6jvttojoSPCwzxU3KfCDM6nSBdOSU8/UvZoRuNTkdgGx3P0DDJJhXYFG/le9Vsuncu4XreLW2L2zMbRagmm2iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7Nd9C3LZv/WczYAlxR5wsDdyWhy9oTP/kUISq5cUl8=;
 b=kgjtnLLtk/cbfAVIRbYVAoJdw6K/qX414VEfe1L3BZ3MVk0xNwAKjdhr8d6szC0in4W8GZZpx6hUfVdnxs6VMXjDHC2psS2NtmsFPX394wSVKh4l2zk5avZZC2wzXu44p4u8Inctk2NDeaX0JIN5NZRAL1VM/IwzuIcOf+tVg3Q=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2575.namprd18.prod.outlook.com (20.179.82.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 16 Oct 2019 08:05:49 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::4c1d:fb1e:ea9c:6811%6]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 08:05:49 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Kamal Heib <kamalheib1@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Lijun Ou" <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: RE: [EXT] [PATCH for-next v2 1/4] RDMA/core: Fix return code when
 modify_port isn't supported
Thread-Topic: [EXT] [PATCH for-next v2 1/4] RDMA/core: Fix return code when
 modify_port isn't supported
Thread-Index: AQHVg/KNP07l2qZtYkyT1zxeSAMyuqdc6CCA
Date:   Wed, 16 Oct 2019 08:05:49 +0000
Message-ID: <MN2PR18MB31825843C5DFA493069485D2A1920@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20191016072234.28442-1-kamalheib1@gmail.com>
 <20191016072234.28442-2-kamalheib1@gmail.com>
In-Reply-To: <20191016072234.28442-2-kamalheib1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30c00d4b-d509-494b-0e3e-08d7520fa830
x-ms-traffictypediagnostic: MN2PR18MB2575:
x-microsoft-antispam-prvs: <MN2PR18MB257535A930CA34F3231E6607A1920@MN2PR18MB2575.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(189003)(199004)(76116006)(2906002)(478600001)(66446008)(66556008)(5660300002)(66476007)(74316002)(14454004)(54906003)(110136005)(64756008)(25786009)(7736002)(52536014)(305945005)(66946007)(6116002)(3846002)(33656002)(2501003)(14444005)(229853002)(102836004)(6506007)(7696005)(11346002)(446003)(186003)(6436002)(76176011)(99286004)(86362001)(256004)(486006)(81166006)(81156014)(476003)(6246003)(8676002)(66066001)(4326008)(8936002)(316002)(71200400001)(71190400001)(26005)(9686003)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2575;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pfmuuXJveqFIKTGNVZU1UYXLLmALCVqcZ1f5zYbNPqesi0shKRi2Zk377sOVX4G/6g7XKnQDvEuc0yLXh4Vj79CUY04HUpPjT0qeY+/itoVVbAG2OEG/oQ07QKJLJeUOMS522PZp71PMC6h12VOhHo883/P8Jv3kvSQ8BMlD99de7N/YpeRf5X5w+WKA/SjJAxpmMjK6AV6tD5GnFAh3iyasqpnKib55VV2vAL/7Q4NbsWELbjnNYX6fYLWo6k2Dutz+UULp95fdKL8by0VIMkIzn+SHDE+6Rz4xAVm0UOcpGdvojkK4bBz++R+mtmfKuvpI8r25CEP2d0UkfaOJHPle0tud9ROhktO5GQXGuvr7OMzuApyWwwV1b2vTUQL3BQfGREHAi4x3JepiZhFIHHpUhOV4AVAmZ9syBx5qc/k=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c00d4b-d509-494b-0e3e-08d7520fa830
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 08:05:49.4024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gBVA380ArqLk6IX8YGW+RSOmWfGxJwMEaOG1fkBq97rzNO7/hUosd60cnzTxjuWJOcBL45aZjbTCJJhAYawb3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2575
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_03:2019-10-15,2019-10-16 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Kamal Heib <kamalheib1@gmail.com>
> Sent: Wednesday, October 16, 2019 10:23 AM
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> The proper return code is "-EOPNOTSUPP" when modify_port callback is not
> supported.
>=20
> Fixes: 61e0962d5221 ("IB: Avoid ib_modify_port() failure for RoCE devices=
")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/core/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/core/device.c
> b/drivers/infiniband/core/device.c
> index a667636f74bf..98a01caf7850 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2397,7 +2397,7 @@ int ib_modify_port(struct ib_device *device,
>  					     port_modify_mask,
>  					     port_modify);
>  	else
> -		rc =3D rdma_protocol_roce(device, port_num) ? 0 : -ENOSYS;
> +		rc =3D rdma_protocol_roce(device, port_num) ? 0 : -
> EOPNOTSUPP;

This is a bit confusing, looks like for RoCE it's ok not to have a callback=
 but for the=20
The other protocols it's required. For iWARP for example there also isn't a=
 modify-port.
Is there any other protocol except ib that this is relevant to ?=20
If not perhaps modify rdma_protocol_roce(..)? to rdma_protocol_ib(...)? -EO=
PNOTSUPP : 0?



>  	return rc;
>  }
>  EXPORT_SYMBOL(ib_modify_port);
> --
> 2.20.1

