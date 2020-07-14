Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA7521EC73
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 11:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgGNJPL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 05:15:11 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:43484 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725833AbgGNJPI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Jul 2020 05:15:08 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06E9AOd6001939;
        Tue, 14 Jul 2020 02:15:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=kuxgregGc6S2EgVSPTZM48AZn8DnapjtpiNIAreKBsY=;
 b=EUbPDDnG6yDuypIcPQP6m/HE/aigV+fjM42bhIRnCKfmKnCgdSfBNl5Zc7g5GC0GfOOS
 ShvxSI1sWOKk9h+kY/Vms+DgzHJWmeux/JkJbaGrl2FvCvYtDbFUIk/9/zoMP5A41bqP
 qrKMEF3YBk1ciz3W7bs8kUexKcQ1nLGRUEkMTWc9OQ0AJ+CH/Nx40Bp3KyXYnlRU+r67
 QLxGhn1QjSydgePGpRjKKX2eduERuei/3s/AGqyLS3fQ7q7vq9UiTa1khAyfw3N+Ouoe
 npBDOpg6/NMLBJJtDRXDw/KU7fxiLNuW5Jh2MqN4Y8LmdYwdlpsmGYP4MvhDkOu2XaHT yA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 328mmhmtbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 14 Jul 2020 02:15:00 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 14 Jul
 2020 02:14:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 14 Jul 2020 02:14:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jrof/7NN3DrqQNlyMAEKLa9DeBATyydnVG404X289+RoFolH+pvNo8chrgWFz962hCmuJ/ELBpiZG/J9eU2rXhgMokcIPbRBursNpLWVmptDtkspdN4AokjD9cvGFTBGNXrr33kFAoLCBwk9z2wQJ3pZeH1vagvSRpQlVp/LsiWFqEfJk3tMrHGn9KiZFaN+qT4HklvS+b+MhPDUuY/1NZ1eQxwMruu1CWFe+OIIm7H2px72C/r0LNETKoXOXW18Ueo/XUOqBjW9m9/FfQ5Xl4a83qdY56UR0/c5wnQtV9Qj032KxiRZOa00+Ew1dq/+GvnnP/DbdU5qG4tqVf5/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuxgregGc6S2EgVSPTZM48AZn8DnapjtpiNIAreKBsY=;
 b=SVeypVhiPLOAq4tMhh80pDSgRcX/ON2yiUk/rxa41LiE2kl1JJPNcX6oxsKjyWsSVUL67RX2dnM2AfrmvVCdzVNobew1DdTtl+P1R6txeNM7lDoN/I72oyEXgsZ5j44Oj9fIa54/K1XJ6oschbF+xn4e2PZyanxNS6UFSu/jgx/FgBwVMwCwNZYzsMK2lW0ifkQb/LO11/YWklLw5KyHf71APOTEuVHa0vArElZlPwE57k/+zI1NelRcN+ViEIhAqhPz/8Fd9Ev/DECsNYpO/4IepEfNunTmKuIQ6KlZJlO/lAYPQGgULTTTd4AY05aSc69zMaBJZPASDCJu9nhNow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuxgregGc6S2EgVSPTZM48AZn8DnapjtpiNIAreKBsY=;
 b=VWs89qfIdHAwMZcG7ZdqGNms6APQQ/j2JTOKXzKxm+VV1ijdwYtFZcaey5fJGOCq1kiXrrPvQof8aUc3JTRRaAr9+7hO9jR2KgYFEOVOWw70wFbjkwJn85sNMWlHHfJjYVVn6NvXTqWart2P29WoK/IjqbAymyv72lANU+RYotQ=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (2603:10b6:208:163::15)
 by BL0PR18MB2337.namprd18.prod.outlook.com (2603:10b6:207:43::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 09:14:56 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::1849:3020:9782:8979]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::1849:3020:9782:8979%4]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 09:14:56 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Kamal Heib <kamalheib1@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: RE: [PATCH for-next 7/7] RDMA/qedr: Remove the query_pkey callback
Thread-Topic: [PATCH for-next 7/7] RDMA/qedr: Remove the query_pkey callback
Thread-Index: AQHWWbZcOokHrPbEoUyFgxZM+IgULakGyumQ
Date:   Tue, 14 Jul 2020 09:14:56 +0000
Message-ID: <MN2PR18MB318208805C9707AE29E55005A1610@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20200714081038.13131-1-kamalheib1@gmail.com>
 <20200714081038.13131-8-kamalheib1@gmail.com>
In-Reply-To: <20200714081038.13131-8-kamalheib1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [46.116.41.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbe0d18b-3f75-4f64-17a0-08d827d6606d
x-ms-traffictypediagnostic: BL0PR18MB2337:
x-microsoft-antispam-prvs: <BL0PR18MB23379229B4A8EED35B11D0D6A1610@BL0PR18MB2337.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: voOTzvWmugwhMfSJ9iSqYqAB9reKLlu85IDKevIFC+srbyFDmLFnBamjNNonNeJeQo23mJVN0p8GE2hHH44dntn5v4HNn4nj0T9zt6cGd02RgOCUClT4OBiA7y0VkP6qHuUdyvbW/wQL3S3vVCY9zblNSQLQB3qAh9DIYHaBXZSUnbriyNpizbJX1ctuw++RarJHXbdzRrAhSUIWfpxKYh6dKWfn41eydsWWd4Ja2OnIquWCpNmu9o+Sm3m55pZUrc7jLzYZ8NQOogBvJ4WJnIhFH4uqPxi7jXCFNzHL7IKdYzi8D/wGVI0eyEBLc//Styy+XdyRs9JhsfiGQHHt6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB3182.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(6506007)(76116006)(83380400001)(66946007)(66476007)(71200400001)(2906002)(66446008)(64756008)(66556008)(33656002)(9686003)(186003)(4326008)(26005)(54906003)(110136005)(8936002)(316002)(7696005)(5660300002)(478600001)(55016002)(8676002)(86362001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: toaThxB5CBx8OgCmDUupeRAYkjv5tdZ801TQ6pf9UEhHFC5v17Z/br0WQSVO8xG2tzUia5aqPxY+xyAQaky/oc0GfOGXMB2or0q26M5nOjZKKkbPzJpq1BacrgCNApri/YExqSgdSkUNL9WHgw/0oK5jRUBseRIzpT9XcJvWj4gAud6ajsNZ3kWGjrr5xs5bW975j568AuuosOmSzkdSoZHLCm4Nzd9BdGDEUgnO6azjQbwDqORGQlkXHWoM+TJInvGbjQLEK1P0ehH8XjsFndcUxtVLXYsO1h+zlDwoI6gi/OHoCgpf7caUWlAJHLv+SQiCmH56/XAGWYpQgNGUtTUdgIU1lUChgLPhZr6+RU3FTctHl3HOOBU4bwpbY4lwN/0hpDFlP/hc853ue8C7tHdQZw9Oqa0Sl8hWppGEdQsixC2dmCmGMZYRm4XF0NCxvXB8uUu4KVuWe57zPo4cFXSrrtfx9lTissXrVhcap50=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB3182.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe0d18b-3f75-4f64-17a0-08d827d6606d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 09:14:56.6782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fvPy+b3yX4VwdmxyGziUu7N072FW2TVJjJ2Qly6ypM0pRJiqc0sZY0dk2LUWFzki6gjc0guf1ZaeLS+haMYGag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR18MB2337
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-14_02:2020-07-13,2020-07-14 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Kamal Heib
>=20
> Now that the query_pkey() isn't mandatory by the RDMA core for iwarp
> providers, this callback can be removed from the common ops and moved to
> the RoCE only ops within the qedr driver.
>=20
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/qedr/main.c  | 3 +--
> drivers/infiniband/hw/qedr/verbs.c | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/qedr/main.c
> b/drivers/infiniband/hw/qedr/main.c
> index ccaedfd53e49..c9eeed25c662 100644
> --- a/drivers/infiniband/hw/qedr/main.c
> +++ b/drivers/infiniband/hw/qedr/main.c
> @@ -110,7 +110,6 @@ static int qedr_iw_port_immutable(struct ib_device
> *ibdev, u8 port_num,
>  	if (err)
>  		return err;
>=20
> -	immutable->pkey_tbl_len =3D 1;
>  	immutable->gid_tbl_len =3D 1;
>  	immutable->core_cap_flags =3D RDMA_CORE_PORT_IWARP;
>  	immutable->max_mad_size =3D 0;
> @@ -179,6 +178,7 @@ static int qedr_iw_register_device(struct qedr_dev
> *dev)
>=20
>  static const struct ib_device_ops qedr_roce_dev_ops =3D {
>  	.get_port_immutable =3D qedr_roce_port_immutable,
> +	.query_pkey =3D qedr_query_pkey,
>  };
>=20
>  static void qedr_roce_register_device(struct qedr_dev *dev) @@ -221,7
> +221,6 @@ static const struct ib_device_ops qedr_dev_ops =3D {
>  	.post_srq_recv =3D qedr_post_srq_recv,
>  	.process_mad =3D qedr_process_mad,
>  	.query_device =3D qedr_query_device,
> -	.query_pkey =3D qedr_query_pkey,
>  	.query_port =3D qedr_query_port,
>  	.query_qp =3D qedr_query_qp,
>  	.query_srq =3D qedr_query_srq,
> diff --git a/drivers/infiniband/hw/qedr/verbs.c
> b/drivers/infiniband/hw/qedr/verbs.c
> index 3d7d5617818f..63eb935a1596 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -239,7 +239,6 @@ int qedr_query_port(struct ib_device *ibdev, u8 port,
> struct ib_port_attr *attr)
>  	attr->ip_gids =3D true;
>  	if (rdma_protocol_iwarp(&dev->ibdev, 1)) {
>  		attr->gid_tbl_len =3D 1;
> -		attr->pkey_tbl_len =3D 1;
>  	} else {
>  		attr->gid_tbl_len =3D QEDR_MAX_SGID;
>  		attr->pkey_tbl_len =3D QEDR_ROCE_PKEY_TABLE_LEN;
> --
> 2.25.4

Thanks,=A0

Acked-by: Michal Kalderon=A0<michal.kalderon@marvell.com>


