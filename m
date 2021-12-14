Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D07473D53
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Dec 2021 07:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhLNGqD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Dec 2021 01:46:03 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:56504 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231145AbhLNGqB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Dec 2021 01:46:01 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BE2rFYi005512;
        Tue, 14 Dec 2021 06:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=bNBF8jW6JaV3iwjuxruG0Bk+pQtJ0e52Q91ANYRRcdw=;
 b=emPBdVRf1v6HefFVUbfd+/yu5wKNCn7rZDLWa3uLjKa1OT8FZq1Brq4+DfEYnmmSS+4o
 CbFbeoQRKRv0O2kXQlX05Len09vkBIvZsnkVpTC14TcpSwKDOkJS9nCZRBLANqHt5cDQ
 Eo3/Yi2WBMEVWLetv0pgK3V4jcaTs2Ap33e3WDdp+rMff8cXSpn2fUxMxIimF10GPSy9
 qQYOPQK6JKnplWq2SQn4Qnzt2aCzo8WF1egGdBPt83TgOqHk5dTw3XxcRUmMFptNlQXQ
 m7ajuzYxamALjH4pn1e+WrlA1tsBHpQA5UI+y39e+1Pt7sFFYPbHIx8ur1j9gWmIVl5j QA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx56u2hke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 06:45:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BE6f3gH134024;
        Tue, 14 Dec 2021 06:45:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by userp3020.oracle.com with ESMTP id 3cvnepeuub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 06:45:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kx8lkznzj2psyWpIQFmb4a1Hh4MhGrsHk423RGUBoARJ/0gmw+XuFlm2VJX1W/L5Yer2INL/Muj+KNyyg4knbyei068Zx7nqUBeB3qNPWgLqzfKKPNslE53eujLzMiHemFIc6D8wRG2avNy3YpzaOeKy3vxPCUCOGkL7jLHtoYeBEQpE+OqD990DcVOWiUL7lKN2t5DK/ozt1cmOaHhPKu6KP0Dr30KBucdgdiv1vfJoxoSe8AciwRb3And48NoSb7+PeqA6WK5eeZrsVaKerRTpNjo8exxoTl+9XWd7J2qZOSActwRMJle+LFR8o2uYb1NGG0g30rkyAF8GMhSMEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNBF8jW6JaV3iwjuxruG0Bk+pQtJ0e52Q91ANYRRcdw=;
 b=UTXhg6Ur+XyUNi8U0JPUPZn/v4F6VzBemUQAB3VamWtbUNHpuCJcNNoz+vURREx+isSfp/MrFn6lAR8HJP5F0MrQrPMmfRchC3SGiyzpoilPPYw5YThcrOPLEhw06vmRpAlliQIMrNlGgPmgd+Wuhu3Yo21PcqkPT9yeGP/lOosPjDChIbdYhz4eJf+pIExJNnTJ4Nb2mCbN6ds/kfGsvLUJcJaglaSILsOmzGGdz5IAyH4U8cgTEkJY/y679jIGMwI454F6Jynj/vqzUXSnDsf0zO50LcYnLGMp6PChjXRDcftOJhTfvsZftDr7GJcr6IEfKzkfdLo4H+W9bbGhSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNBF8jW6JaV3iwjuxruG0Bk+pQtJ0e52Q91ANYRRcdw=;
 b=CNo91qrWOGaV2/8ijniVZ54+s/2mJ4qezJOBsOOWXnPawa4xbzNO73S09RknrHIMm6WCRKZ8PO0eY88r6qAyZXueh7lVNoLU+v10gxFn/HYl8D4GbUcznNPo+VOhw2uGQjnlEZfZ0TZZtcU+FEwByN42p4qiAgAF3vb/wlY6Hog=
Received: from CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6)
 by MWHPR10MB1344.namprd10.prod.outlook.com (2603:10b6:300:21::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 06:45:41 +0000
Received: from CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::eca2:ec30:e72f:93ee]) by CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::eca2:ec30:e72f:93ee%7]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 06:45:41 +0000
From:   Devesh Sharma <devesh.s.sharma@oracle.com>
To:     "cgel.zte@gmail.com" <cgel.zte@gmail.com>,
        "trix@redhat.com" <trix@redhat.com>
CC:     "chi.minghao@zte.com.cn" <chi.minghao@zte.com.cn>,
        "dennis.dalessandro@cornelisnetworks.com" 
        <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "selvin.xavier@broadcom.com" <selvin.xavier@broadcom.com>,
        "zealci@zte.com.cm" <zealci@zte.com.cm>
Subject: RE: [PATCHv2] drivers:ocrdma:remove unneeded variable
Thread-Topic: [PATCHv2] drivers:ocrdma:remove unneeded variable
Thread-Index: AQHX7WXfNRh1/dahMkqikmYyd/QPxqwxkVAQ
Date:   Tue, 14 Dec 2021 06:45:41 +0000
Message-ID: <CO6PR10MB5635FDF74CA549F662C33F4DDD759@CO6PR10MB5635.namprd10.prod.outlook.com>
References: <260ff018-bf5b-07da-6988-c65c04f5bcb5@redhat.com>
 <20211210013247.423430-1-chi.minghao@zte.com.cn>
In-Reply-To: <20211210013247.423430-1-chi.minghao@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fffb9e3-521f-4227-4379-08d9becd5896
x-ms-traffictypediagnostic: MWHPR10MB1344:EE_
x-microsoft-antispam-prvs: <MWHPR10MB1344402A0F2B7820C739CE93DD759@MWHPR10MB1344.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:40;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SoOjMKNg+N0pL24JxdBos8n22cbZJj+C74JmrVTUwmxC9GQG0RvMNbhuj/w0xDzYk3hihzzJZQpy5ieBcZJ8HtLjHw11tJMgd2ocJU+11SrHfWQXKMi5EIA9x8nlJVfDLojO8OWENb2VCwzpZFotfUdib5gcuhZswaTJRSnstDQjqFNIB13QcJHdbk/kXNC64O6TOs26wGx5FR68iQZD35+G0DFxd//2AVGE278H4fBuPMdLTbtSkuPAreF/r70Qcaj0SdJixeBm2pxKK+waG/OqRNjegCT0tr/2zvstzCz07Rlp8OVX5PtepAMU/FLQnkkHZq7BlKytTWa610UvRcdX00sZLzNgzMkUNdRjKIuWAYs9+AtX2lw9hvLvxr6ZpkBIlDOPW9IMf4NNgineT7hn32daY94d65noHQH2hKzhj5Y8GfDfC8gH9m6ylWFOJP6otJnpnhWdhAaEtNQCPYTfMXXnSVpMFN8Zbl3+TDYU8afmIBgRf2vD9+8DVS3xD7SesdU/nY/o8XNL69T3CftRsP3hI9hEipwHf2qyAB9p7liWjjfxDhnjnqZjHV+SGaQ0ADOyzmY3HfslL8CoLVoDnd/DPVbaLmhI6U1Lnc1alKgzDjKkgRk/IMQUlc85KCkcgSO7Wv6J8Z8ojzCOO6tth6BN/cE2f+FkPlNZ8TqAgiCKtHtyudhC7XOkDnCV2nh7fz4ubXEg4zUg0FaDX6ridKnWh7jwSCj+PmPBd2JlmXOKfQXYeGb5wI2RPA7d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5635.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(508600001)(5660300002)(76116006)(9686003)(66556008)(66946007)(122000001)(86362001)(26005)(66446008)(64756008)(33656002)(2906002)(38070700005)(66476007)(7696005)(110136005)(38100700002)(52536014)(6506007)(55236004)(53546011)(71200400001)(7416002)(316002)(8676002)(55016003)(186003)(54906003)(83380400001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sKNtgYk+wJqEwAXomVT2w56OMb6/bK9iNGfBZUbyKS7jHcUypJ7gDNNnic6C?=
 =?us-ascii?Q?eoHEKAwLsMMlo53DjAvSmyxy8kRoMWYadz0Z6MFmL9koe8iCOA9izeFur8fM?=
 =?us-ascii?Q?a+go0YeTqO0DFEjEu5zlosjnal0Hs22URBcgv7fzfyjFfM+CnR6F389fZ2VN?=
 =?us-ascii?Q?gvw9uxJ9T+lCAYtiNmoN2bcFwHt4KjuLtzSC1newpIiYw2zqkVBx0uZ+E8oz?=
 =?us-ascii?Q?4KheLp/jTN8s+gF4M2lgoRkuVYOuaDmZr7uh1nEdzTzNYNs/VqaMQ+nUk848?=
 =?us-ascii?Q?YHqA1QiEGQI/D3Pn1bqddP56Zh80K5wZjXt1KRhJDJDshTuoTDvNTXy2oArR?=
 =?us-ascii?Q?TIj8uz2IsRWuGTIEHCexHC0O/RInwKRd7xPP5s7DOPEnHiqz4q1ESdcEIMEw?=
 =?us-ascii?Q?zVARVrPjuk7rH1LkeMTdrW4jloyqh4izFxiq5g5glK+s7FTEb47xFuK4mvLL?=
 =?us-ascii?Q?GQTphPC5pD7fetE7h59BaApOEK4wvvsZZMoff3JmIqFyg+x+7wsbQrTfplvW?=
 =?us-ascii?Q?Yjb+danC6T+mnbLSJHxzaJafTEzvI4xEyxAZFeqw1wAUYWVpIKUwGFGffWJG?=
 =?us-ascii?Q?JkkyCf0lzOdKopKPorqlVNpGbTk0ZNhOxTWWVSzWmDHmHhA7RcFxI7Jp/rl1?=
 =?us-ascii?Q?de9ZHAdvbAvFke8ngeWjbU3FXJScBUB4IS8qQWVFw8ejjWgiOqRjiD1nCQ+e?=
 =?us-ascii?Q?MBnerl7TjvwyiMjiuV6sKppoxnuhrXAfY3Tkkl4kr4Y5G9Oj5w1Zqz9jzz5E?=
 =?us-ascii?Q?/o2pEEyGz0Po4hWkJCSs3Iw5hd9qbF2BM/xCJ6abutWA2EXCFPsvNtKTeHP8?=
 =?us-ascii?Q?DXtJDFCuagDHbazPg/0A/bhFRfBLbN0UYcF1iUIay8hhvCYNlCcsNVi1Ne/H?=
 =?us-ascii?Q?U/0vc9jKge2IpwI86rtRdesUU70lNCXTt1X1c1h9Lb3Wc8iMpp0XnHuagl2P?=
 =?us-ascii?Q?qYLyX2xR//2z98t39UUzBDs8KrGNAEWnLLb4YVTJ02esQPeqpf9RZWkdVwF5?=
 =?us-ascii?Q?SJFDltlV/gfxcjj2KK+hHrtFpcgKsoMH3a0RxLQ0nXEHHEciuYfxCJY2PB8H?=
 =?us-ascii?Q?NAkrKHNQnO5+gFqdl372xBoOSpg6AdxxgIgpbNUQxRsxQ9qkK7N7PIKNus8R?=
 =?us-ascii?Q?33ooAxKN5mF4rlqQth6Js1b5tsINZGZHtjrhpkb3Kn3mN7mBgfAWXIdcz8dK?=
 =?us-ascii?Q?meEiVm6eC6Hz7nzzkkgsjaH/JRfihHd1ckW0h/PV9lcbr/VmLxcdZEXqptzn?=
 =?us-ascii?Q?kQaMeuiMhBOGAA99UcrLXBejNRbLAokt0tnubRcK/9BxTlhP65lDYepRQuO7?=
 =?us-ascii?Q?G+OucYg7UDa+c6VBQgV7vIe7XYtbe1sVrol13jHvz+X+ueYyolyDtWzCV01P?=
 =?us-ascii?Q?uwCh8GV2pOlz3UTQ5Px/PaG6dEYGkXrS5KWXHXaZ70vBBvFRBQz0vs2ymgj0?=
 =?us-ascii?Q?mv+B45jYzVIG0PcM5I6A8wkD8xxknwl4oJcahiTKPOhyRN41p8D6GOsQbLR0?=
 =?us-ascii?Q?gqdepGYI0R6rZlK1Psym1zlL5REXtiK6BfKdIJv0SqBEAOaXd84LohtTmmkx?=
 =?us-ascii?Q?igf0WTJO1Pa5CmOakE5hvju1Cy9It2kclZKHxr4XYwdhN7wmAL9fdySggwJu?=
 =?us-ascii?Q?vjHDZU+jBltyHBa+YpC5S57u29X5JwdJVGkcEB30dUICuxd80TvvEt3YhX4Z?=
 =?us-ascii?Q?hsnyBA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5635.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fffb9e3-521f-4227-4379-08d9becd5896
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 06:45:41.2585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6E5WpRQHKfZlTNteNPvD71bLh68lXkbd+58ct8bmvfZDUCTHdbDXogT4U2iu2MNtZlGckuu+Jt5sNvGmwDSIvHx7KLqiFWVw9f9jNl77FwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1344
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140037
X-Proofpoint-ORIG-GUID: _SPjrmfW1juEpvvE2xCeAnc-tD9aZuRH
X-Proofpoint-GUID: _SPjrmfW1juEpvvE2xCeAnc-tD9aZuRH
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: cgel.zte@gmail.com <cgel.zte@gmail.com>
> Sent: Friday, December 10, 2021 7:03 AM
> To: trix@redhat.com
> Cc: cgel.zte@gmail.com; chi.minghao@zte.com.cn;
> dennis.dalessandro@cornelisnetworks.com; dledford@redhat.com;
> galpress@amazon.com; jgg@ziepe.ca; leon@kernel.org; linux-
> kernel@vger.kernel.org; linux-rdma@vger.kernel.org; mbloch@nvidia.com;
> selvin.xavier@broadcom.com; zealci@zte.com.cm
> Subject: [PATCHv2] drivers:ocrdma:remove unneeded variable
Change the format of subject line as per the guidelines
>=20
> From: Minghao Chi <chi.minghao@zte.com.cn>
>=20
> Return status directly from function called.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cm>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> index 735123d0e9ec..3bfbf4ec040d 100644
> --- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> +++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> @@ -1844,12 +1844,10 @@ int ocrdma_modify_srq(struct ib_srq *ibsrq,
>=20
>  int ocrdma_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *srq_attr)=
  {
> -	int status;
>  	struct ocrdma_srq *srq;
>=20
>  	srq =3D get_ocrdma_srq(ibsrq);
> -	status =3D ocrdma_mbx_query_srq(srq, srq_attr);
> -	return status;
> +	return ocrdma_mbx_query_srq(srq, srq_attr);
>  }
>=20
>  int ocrdma_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata) @@ =
-
> 1960,7 +1958,6 @@ static int ocrdma_build_inline_sges(struct ocrdma_qp
> *qp,  static int ocrdma_build_send(struct ocrdma_qp *qp, struct
> ocrdma_hdr_wqe *hdr,
>  			     const struct ib_send_wr *wr)
>  {
> -	int status;
>  	struct ocrdma_sge *sge;
>  	u32 wqe_size =3D sizeof(*hdr);
>=20
> @@ -1972,8 +1969,7 @@ static int ocrdma_build_send(struct ocrdma_qp
> *qp, struct ocrdma_hdr_wqe *hdr,
>  		sge =3D (struct ocrdma_sge *)(hdr + 1);
>  	}
>=20
> -	status =3D ocrdma_build_inline_sges(qp, hdr, sge, wr, wqe_size);
> -	return status;
> +	return ocrdma_build_inline_sges(qp, hdr, sge, wr, wqe_size);
>  }
>=20
>  static int ocrdma_build_write(struct ocrdma_qp *qp, struct
> ocrdma_hdr_wqe *hdr,
> --
> 2.25.1

