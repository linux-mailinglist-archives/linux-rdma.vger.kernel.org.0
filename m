Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB6925AF46
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 17:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgIBPgM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 11:36:12 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:45398 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728564AbgIBPgI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Sep 2020 11:36:08 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 082FQIlg012826;
        Wed, 2 Sep 2020 08:36:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=u8sWNYOf92R/ku55NmoWtzGLTMxGatKHkhv58b7Xqj4=;
 b=HET4K1xn4SAJ7d+xV/ZH8qn5dvEsxT75EfBi2d+26wStac/7CrM3LU5M4SD8msgAwF10
 JMsUBVMHsNTw/CDIeHQZU5Fk1z1zQuxXicSlz5x7AB89l9RVAOmJ/telUTPOIPbiQm/N
 3HO/8HP27Juw7C0NzHnaQyA/YJ+kuraMJW+b0Qge8+XjCWQAuE1ACHnMZIs0MgsdqB9B
 38pWjNb9x247/u90ZNXRZ/GDuk9jar46gnQvJtJFWsuMqyJy5vAbhCJJH0Rr/6PxmhAG
 4wXRbhDBnLvAPpLodGfWRgMd0Yg2pu6QWoutw45LExhuWJboaiOmsIo7hR80ZYaUqr3C Tg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 337mcqfycp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 08:36:03 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Sep
 2020 08:36:02 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Sep
 2020 08:36:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 2 Sep 2020 08:36:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mip74yk1BeR6gy1zOtVOB82X0szTDfScPE21IC+276gyaxsedj8nIucTZkngoDqVMID4mIDzmiOsJKIjGwecQwe9xT2nGapXYApD7+fl8hg4SSuMnoERpKQBUAf0DmmqtC1vIBVSSRYUyskjl6ri0ZAts8MLSRLnh5igCyzmymDnQraAjZ6XVDTpVcbD1qXzmOdBOpgwnzQ95PrxGG60ugQQ9UFDA3gZrR6R3x+jxOCCdSwwjnw+Y43jUNBiRtqWBA0Vo5Oj+JoO/Xda4QSdbife1CB9dZa61QaAq0+1/a6nwyHVa7RgbvLA0p5gKlnxJyjhKPGYTwIuHrw0Mmg+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8sWNYOf92R/ku55NmoWtzGLTMxGatKHkhv58b7Xqj4=;
 b=ZLbFbymXsaINRzAwSf5slfR8Hsiup0enNX0T6MmOgdEunEX7UZabOjNDqjxj5DfOdeMV0MCTQRShgHfibYrXvQNTCkbH4+ACWDzqJM2SRi8JGEjZ/BRyxAvWH9vleHYazUGtdSSW7Uu7U0m1FsQDxl6wK4JnVbgh/jM8A70VKRoQPDxDjEJFN4opjUKmCswjzntKbVQprGQ4B4aXu1S5k440YkgHo2LQalk3NATO4xnIHgAYx2kc4IraVpx/x/9pXpDhC0l294mNLsw87dV0f+i/vh3fikQ3DodbCspltRKuCHmWWy6ZikrFWagINCZBt8xmYyBnNYRnFGCn7xRqlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8sWNYOf92R/ku55NmoWtzGLTMxGatKHkhv58b7Xqj4=;
 b=uzAO941yDzk4hG2t2I8EX9qSmf5Egc10BWKHGuSUMD+n3gdfosG/pLrH+00aA5kVW8u3KqeBAgzpAJOL9bPS/4LPK2WS+1YyDSsJrs9UP/fJGv/CN9RmDlOZgmdI4v1A+Qktc3tMynHfoRRsUFS6+jlTaLh84NslDUaJ77Ym1XM=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (2603:10b6:208:163::15)
 by BL0PR18MB2116.namprd18.prod.outlook.com (2603:10b6:207:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 15:36:00 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::649c:380b:2191:867c]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::649c:380b:2191:867c%5]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 15:36:00 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Ariel Elior <aelior@marvell.com>,
        "Doug Ledford" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] [PATCH 07/14] RDMA/qedr: Use rdma_umem_for_each_dma_block()
 instead of open-coding
Thread-Topic: [EXT] [PATCH 07/14] RDMA/qedr: Use
 rdma_umem_for_each_dma_block() instead of open-coding
Thread-Index: AQHWgMIjpy44HnG6jkqC41uhwO9HWalVe88g
Date:   Wed, 2 Sep 2020 15:36:00 +0000
Message-ID: <MN2PR18MB3182083A47A868B1FB781F44A12F0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <7-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
In-Reply-To: <7-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [46.116.57.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99419982-e56e-468b-8366-08d84f55e512
x-ms-traffictypediagnostic: BL0PR18MB2116:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR18MB2116410AE4DD9B284B97255EA12F0@BL0PR18MB2116.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ca8vjZTQO0pmX75Lu7oizu/4CgwEWdLkCw+nLWotn/H8IO6kfwSQs1fcIJHoo8gbd9nQYklBrx/mWrk/d+/nT5r5e/7hCH4DeIbvsM7f2g9umfc5ygx0y7p6uNFo4TAlvipnD2uYSNLTaTQ+ko57Uqs/rNF3bcQP44kUv8FAzMDg19Ke+k7PUO/ljl2dG/paww6auNVFEMxnhds9BL7ttJehhuN3u/m92TpcBR/d+4kaGjG80mUooJCJ2rjIG71Oix5ydY3Q9CBrfxEWXLstHrzDnjJadBzckv0l9bJGJqrxYhTDnQ7dccHCNbUs2ha2HyfpJwvPTm9vAxQQ+XPg7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB3182.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39850400004)(9686003)(110136005)(76116006)(66446008)(64756008)(71200400001)(2906002)(33656002)(55016002)(66946007)(66556008)(316002)(86362001)(8936002)(66476007)(478600001)(7696005)(83380400001)(8676002)(52536014)(6506007)(26005)(186003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: QRuOdMIyAbivD3GlCTvbnTbuxRGjQnR8gAflJF1E7OCM9nwUU9+cX1j1TKw8HPeUKsKdAvnfJrTGhyKiyIr+4XQ68BneY0uDl9Bia5+UBZGsKnPdt6NsK2HiXgRzjP7Z1TMx/kQZK/WbxO3+8BWDwW9NEld0f+8MQQMYaSvovnmLAB1b5afF4t4+Te7fhcCVGP4/+kL9SKVbtSZ8fZh797olhcajUjbjbBcwODx1jdIk6WfypksoDO2ABmnlXYv8d0+iXkHPNYEzbBHHwe9oObaVcyhOv8bhBXVQKfp25HJpTBMS803YO782KK0SjqYJyN6R6qh1ah/mpH/hcpX8V1wLVDEpdiCmRu9lodQqVoGLYyq5kL0oFbIbeL7OlDDmUMrKPJAK9yzrYqM0P2k0scq6BGrTRPXfqdaYmB5AAS9oIyNTmrzVPy9dV2SNqby8vZw+iDrqa4fKefIFPDZsSBcL3lA6de3agRdaLqgWDeWKhDiAqixxNe4GCui4tLuhkyJRjcTp3wToSJyCKo4sH0FE+5zRG/HASPctMGaCoYgyT3tThEW+u67B119HQd+a74VqC8VKKup9n15+2rK0LO3k6FCzxxkvVXlxpYr9g1lHF8xSXb+UcB78y49S4oqAlMtNVIIqJgvgC4u7J0iE8g==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB3182.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99419982-e56e-468b-8366-08d84f55e512
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 15:36:00.4876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H/7MB/AELLE/ZtHiShiKMUcYI3g8XRuCy1X8d7+Y513WRetCI/s/c5pXvMdwo2d5OWksw6h6BAzbPz/NaF9DLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR18MB2116
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_09:2020-09-02,2020-09-02 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, September 2, 2020 3:44 AM
> This loop is splitting the DMA SGL into pg_shift sized pages, use the cor=
e code
> for this directly.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 41 ++++++++++++------------------
>  1 file changed, 16 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/qedr/verbs.c
> b/drivers/infiniband/hw/qedr/verbs.c
> index b49bef94637e50..cbb49168d9f7ed 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -600,11 +600,9 @@ static void qedr_populate_pbls(struct qedr_dev
> *dev, struct ib_umem *umem,
>  			       struct qedr_pbl_info *pbl_info, u32 pg_shift)  {
>  	int pbe_cnt, total_num_pbes =3D 0;
> -	u32 fw_pg_cnt, fw_pg_per_umem_pg;
>  	struct qedr_pbl *pbl_tbl;
> -	struct sg_dma_page_iter sg_iter;
> +	struct ib_block_iter biter;
>  	struct regpair *pbe;
> -	u64 pg_addr;
>=20
>  	if (!pbl_info->num_pbes)
>  		return;
> @@ -625,32 +623,25 @@ static void qedr_populate_pbls(struct qedr_dev
> *dev, struct ib_umem *umem,
>=20
>  	pbe_cnt =3D 0;
>=20
> -	fw_pg_per_umem_pg =3D BIT(PAGE_SHIFT - pg_shift);
> +	rdma_umem_for_each_dma_block (umem, &biter, BIT(pg_shift)) {
> +		u64 pg_addr =3D rdma_block_iter_dma_address(&biter);
>=20
> -	for_each_sg_dma_page (umem->sg_head.sgl, &sg_iter, umem-
> >nmap, 0) {
> -		pg_addr =3D sg_page_iter_dma_address(&sg_iter);
> -		for (fw_pg_cnt =3D 0; fw_pg_cnt < fw_pg_per_umem_pg;) {
> -			pbe->lo =3D cpu_to_le32(pg_addr);
> -			pbe->hi =3D cpu_to_le32(upper_32_bits(pg_addr));
> +		pbe->lo =3D cpu_to_le32(pg_addr);
> +		pbe->hi =3D cpu_to_le32(upper_32_bits(pg_addr));
>=20
> -			pg_addr +=3D BIT(pg_shift);
> -			pbe_cnt++;
> -			total_num_pbes++;
> -			pbe++;
> +		pbe_cnt++;
> +		total_num_pbes++;
> +		pbe++;
>=20
> -			if (total_num_pbes =3D=3D pbl_info->num_pbes)
> -				return;
> +		if (total_num_pbes =3D=3D pbl_info->num_pbes)
> +			return;
>=20
> -			/* If the given pbl is full storing the pbes,
> -			 * move to next pbl.
> -			 */
> -			if (pbe_cnt =3D=3D (pbl_info->pbl_size / sizeof(u64))) {
> -				pbl_tbl++;
> -				pbe =3D (struct regpair *)pbl_tbl->va;
> -				pbe_cnt =3D 0;
> -			}
> -
> -			fw_pg_cnt++;
> +		/* If the given pbl is full storing the pbes, move to next pbl.
> +		 */
> +		if (pbe_cnt =3D=3D (pbl_info->pbl_size / sizeof(u64))) {
> +			pbl_tbl++;
> +			pbe =3D (struct regpair *)pbl_tbl->va;
> +			pbe_cnt =3D 0;
>  		}
>  	}
>  }
> --
> 2.28.0

Thanks,=A0 looks good!

Acked-by: Michal Kalderon=A0<michal.kalderon@marvell.com>


