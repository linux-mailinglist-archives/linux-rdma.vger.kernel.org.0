Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBE5473E84
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Dec 2021 09:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhLNInx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Dec 2021 03:43:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21100 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229917AbhLNInx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Dec 2021 03:43:53 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BE7RiUO004117;
        Tue, 14 Dec 2021 08:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=I+/XlQDiKi2NSc9o/KvuXGHkY9wb02HHows+wJY8/10=;
 b=nlr/YlC8eFqrM+2P4MZh/GS7T05VTc538vzffI6huopmX8UuFw62mY+Sz8sh7o27uEd5
 mFeCyEJMGmUNudfK2WvlFCXZwIp8ibvt8v2pK1l7Ju3FyhrF3zXhhP8/aLjAbCRuWX7L
 QhArHnwFD9YOXYWrOYmL/YtmJRqZnItJJ6/qgxTMnYt4Q5p6aEC2UyyS1Bu/hCmZeMoz
 gEukMuXsC4GOeBE/IGRNgv/u4aTRvjFGd+X68Aaa2FsIYdJGpbfYzUPydkZmpvDZkx7I
 6ZI4rQ6z3u+jekh1OMgvdKkjrQrk2L98l91cv/axl/94XyZ9BoQLnwAcghKHOgBzGmey iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3py32ww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 08:43:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BE8fXAG156419;
        Tue, 14 Dec 2021 08:43:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by userp3030.oracle.com with ESMTP id 3cvh3wy14v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 08:43:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKYVseThqN3nifZYpvMCgholDmAeyomsePpqj5Rx7L6lA+3wEE5SH+PB4jSoL5Qu+db/4iPHYw65desh2jmzlbe4AKWxthjXCI+rXfQ6ti5CXm4RMToYTt3XXEwmF1NwGoQyZ3aJwYmFmO04pmv7uZW68XTPVDQwE8cYXNDIWaZ/8k1/vepWMj6K1KtdHzAgNLV/BeZlGIxZeI7nfbcSy3nYBq7rgSAek66yXUhzE7BmtcYTxvL47xnJipswgq0peuHJFgvu+StEFFoyRTGROrs/3Ms/Jr1i+Sja+7Tlbp8jO3ZBySHxfqA4Kvkq7tjCa42h6T9OufFEpSt+R3koJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+/XlQDiKi2NSc9o/KvuXGHkY9wb02HHows+wJY8/10=;
 b=O24UJATUPW9H20bMK03pqWOzTez7vTNbA8+Td54/FoYUJ7Lp5jecVUIdXVqwAbJ+VgggekevXyBJNdYWLIXXZpqYC+Vvej4YlyiTzvxecH5nOaFSn59G/bEVqAc68k9/8PtFf7TAFxM2T2ybYRih750AUpT/vM9L4UZSbzMo3ejIvYKY87NHgg/TzN+Ihghg5NCL1PcBf7n7HG599YlM0h8pFGiCjmcOTQ13nMIIrBlw8eeUxo/J6mQwGtQ9sHT97tmZafwmFnnU5xZ2UZb185awnhti5/4msv6rtw+YpuvFyAYeN/nh9y0PdLTkGNruVTSgeOGdsboXuX2RkI1KIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+/XlQDiKi2NSc9o/KvuXGHkY9wb02HHows+wJY8/10=;
 b=Hgtjm2tvpHg0jdZNuAFv6cCgF/nZFqPdAJmsnukR4UeVSeq81HohhAXFU3t7DDzyStmei6l1Zxcl15JLcw73fiz9fZ+lYj8enkK6Kj9tYjRDZz2euanI4j0LoYSvBN0vBbsyUMjYY3kSs9geqh19EVQuLer3kVBnS65qDg8anvo=
Received: from CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6)
 by MW5PR10MB5690.namprd10.prod.outlook.com (2603:10b6:303:19b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 08:43:39 +0000
Received: from CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::eca2:ec30:e72f:93ee]) by CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::eca2:ec30:e72f:93ee%7]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 08:43:39 +0000
From:   Devesh Sharma <devesh.s.sharma@oracle.com>
To:     "cgel.zte@gmail.com" <cgel.zte@gmail.com>
CC:     "chi.minghao@zte.com.cn" <chi.minghao@zte.com.cn>,
        "dennis.dalessandro@cornelisnetworks.com" 
        <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "selvin.xavier@broadcom.com" <selvin.xavier@broadcom.com>,
        "trix@redhat.com" <trix@redhat.com>
Subject: RE: [External] : [PATCH v3 ocrdma-next] drivers: ocrdma: remove
 unneeded variable
Thread-Topic: [External] : [PATCH v3 ocrdma-next] drivers: ocrdma: remove
 unneeded variable
Thread-Index: AQHX8MIm4z6/1SH+dEabF452Lr6MbawxqzZw
Date:   Tue, 14 Dec 2021 08:43:39 +0000
Message-ID: <CO6PR10MB5635347074DDA51CF2766B9DDD759@CO6PR10MB5635.namprd10.prod.outlook.com>
References: <CO6PR10MB5635FDF74CA549F662C33F4DDD759@CO6PR10MB5635.namprd10.prod.outlook.com>
 <20211214081054.438166-1-chi.minghao@zte.com.cn>
In-Reply-To: <20211214081054.438166-1-chi.minghao@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6caf5946-e04f-40ba-c6e7-08d9beddd39a
x-ms-traffictypediagnostic: MW5PR10MB5690:EE_
x-microsoft-antispam-prvs: <MW5PR10MB5690ED94F21DED3C3CDF6CC2DD759@MW5PR10MB5690.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:88;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XyHYcPH6G/ZYLaxMEQghqZCAAaFFV4e5bdPpmpjEZeDM2hdxEQ87Fi6bKGFvijpKOS/Biuyo05yuf0D7IeYQDPu1R30KZN+KebznTdWcvbChEmKjyTkdw0uezRPFWfeW4C0I/uPwizxC+VoJX0hquOC0ni5yo+2jtfMACki1DjBMIa2yVzV2sVkP4DFsQNmB2p5Z0btegDWofAKKglCa+vVKQfYrgTP2O5qvWagYnegV0cqhsjkZSiFYjEP/rmdfCkepErVXdPCb8o0WiWinZgGacLNqe19vN0eqbqbeoc4iWDB17p2EBhY5PP6iYJsEZanfUe61h+SJ4e/2tyjrnuEJ4XMZs4h3PtKKaTyUyJbf3j0jXHq3m19Sw3N2B6BsfciXYTEyw3zFuqThDmWQmX9St8NcAvOkPJRLnqO+/spPUVu1KteJpLWqAjlZ30qp+vAXUYlk7kWPjGViCOFSjpvRvw5WTEwRKxPUwqw8mtzaVCu+vqjMpxU0DY842BAUJyvPM1k/bqCY9QuGFqvyhTgvm0KrNgQVq5aJPeQ2/egbMrLitEArIxa0j7elP0cUVc9mlDXVE47b0dxZcTd6Q4qgrxgmY2m8smI8kka+nSJHEYdl6cj7dCbpANxUJnYejZaTMz33JwzIPVG8bP1KTHXRpWkPfR9HviwtbqeKVSjLOwKiHAtiJe34pGGkcSMSx+zO+5HIxqOwjsq4zGg6EA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5635.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(76116006)(66476007)(64756008)(66446008)(508600001)(66946007)(6506007)(7696005)(122000001)(71200400001)(9686003)(4326008)(38100700002)(55016003)(83380400001)(8936002)(6916009)(38070700005)(2906002)(26005)(52536014)(86362001)(186003)(8676002)(55236004)(5660300002)(53546011)(54906003)(7416002)(316002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0AHLbjCFkZ7PTOw0p9oWTjnY38wCnlci/W0Ht7+649vrfs9xcmoIqREp4QOY?=
 =?us-ascii?Q?3X7BDO3ood22Ul3VRUjw6s+A0iedCCb1ugTzFkqmybel1wGSdseSO+D8W1UN?=
 =?us-ascii?Q?w/I7nvw/JX3+bEI24NjinogBi8NuAtlvEhgckoQKB5rCtgEYWXgcTg7d+B8L?=
 =?us-ascii?Q?sgqUkOUfMv5q6peqM1PM03t37+2tbpAYtuU3h1tsDK+Dlv3UHVkkdrNSs1CK?=
 =?us-ascii?Q?sxk4neFJeGeRmwdUfwC74q7bOGpEOxof1vbgDH7J+lMLwauho13kH13iyyOu?=
 =?us-ascii?Q?oqAdgIzXMZ7kfvHVw6GvaMK+Ukd9+JE93oNcfwMAlO+3qHnPHLaD/PEOK1Ps?=
 =?us-ascii?Q?5JiBE/3IIngm6hMsC08JdspcKhn74Rskaq0S0xaj2icl9CdCwDq6VLv3b16n?=
 =?us-ascii?Q?pAsVt1eXwMgu4A4BrN3Www8AFaZ2DNC2l/NBs0Bvh5gT71ClmVwEfyCN95T7?=
 =?us-ascii?Q?ixyUclc3IiLes+c2nNCIU9bnZGzG9pRPdNybvwFTIyi0h5hDmfLdxF0pla3p?=
 =?us-ascii?Q?tDH684PCZ7cLAIdypauX+s0kE3pZ6Ab6i1GltRdH1UiB9k90H6Q4DI9gO3bx?=
 =?us-ascii?Q?91daIuTELfnPlh/Koga+lOHTq9Vrkw73O3vori1gXm6hiXQ4tPagKR+HzMo+?=
 =?us-ascii?Q?31hpm1kgwojvzEgTFcecBlrS3Aeaj3p3VIU1RZTtdelLdR+Lgqafh66ZpuDS?=
 =?us-ascii?Q?myIkcqyK7bNAAMaOSTLUr3v5DtO+cRfArxlcDabjN40ZeU/U8yjlH/exEfOD?=
 =?us-ascii?Q?MqPZ02xUYZNnyudl68BSWmDUZNeFD3ZJMnD0ToJO/wqIHCGiOS4KIY4oSkYR?=
 =?us-ascii?Q?nVMnaLXmjSrDcme0etc1N2MI6igXH/UxsvW3pLaQVcP74viAR9NoN3VkPzv/?=
 =?us-ascii?Q?4xxt3YfnXzEcjrqzc2DyiJ5pft/uYewTsLgKtc5Ml2U5c89ZgMyy3FH0TF2O?=
 =?us-ascii?Q?SZtgOnVs1ReQyN04u0B5KKNlcCvYYuKu+25BxRGcTIS3q7lNCDXt1sGugLxu?=
 =?us-ascii?Q?Syyx3gpX/IwxiM0efZClPpovv57HjwPTu9ibUKHzafy7v4uUeLaSki+cKhxd?=
 =?us-ascii?Q?pndwsPD/vVLAqN9RXt4ustTMqfv8wiSfc7raPFBdIHoKImfOPpWMmDJb5TUa?=
 =?us-ascii?Q?D1ldSG4szehYPxNwHtBRZXHoVURSuJDeDs3T3Y3piQIYy4Wiol3fwvlDRf2o?=
 =?us-ascii?Q?upZETiCFD0B1kj+40YYgvFuBHt2KZqCweyHbYzXtV4YIIZTFGrjqGMnBnGMr?=
 =?us-ascii?Q?5gSLbxYwYzKx7AfJ5Ix1o8uMj9J28UPZrswIwWUTRIQtPyiAPjfc0kPT6Jec?=
 =?us-ascii?Q?/4akrtbb63b0dbKeL05hLsv8Vo/Y/ZyOjD5GV9xQWZ2u0w70DH93W3W245a/?=
 =?us-ascii?Q?XGcGFyRIKe3wb8ZWdrj79mie1nURJ+oagL6QyCJgo+sWRclPGwQqpff8+09o?=
 =?us-ascii?Q?AQ5EKL0DHHgy+EpffE3gPmkoH2bChNZ+U5flcCmsK60LSkT13vu9cpIXVCDB?=
 =?us-ascii?Q?8K4n1a4TrA/EJWwBuLgFO4R4fuuaD4MxueB78K5YBND2dEo6g/bdmdnmxAxw?=
 =?us-ascii?Q?Ht8zrbOwaou+Rz4o6XIsShhPl4/dnlDpQccLk82AWcDroTpyyy/UpEgE8ehL?=
 =?us-ascii?Q?IedO9tlf9YHkbtTIn7dr4JoK07fZ8FHDsl87Et8eG6X/rFleVP+b/vPBZ/Tg?=
 =?us-ascii?Q?gdEuuA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5635.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6caf5946-e04f-40ba-c6e7-08d9beddd39a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 08:43:39.5139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UklT8Uo4+ntCJ6SAbpqM8X5mGAXgqpz7IQW5osnOXJhD9kLcijQDZYIaKOmyB1wt2BmOYePJp1SCe98JKRnEg8jaP3RpkhDdNxpIMIGEJjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5690
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112140049
X-Proofpoint-ORIG-GUID: xJ7Dh4Wi6R45MOjSoU12rW2OLwWsrMHW
X-Proofpoint-GUID: xJ7Dh4Wi6R45MOjSoU12rW2OLwWsrMHW
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: cgel.zte@gmail.com <cgel.zte@gmail.com>
> Sent: Tuesday, December 14, 2021 1:41 PM
> To: Devesh Sharma <devesh.s.sharma@oracle.com>
> Cc: cgel.zte@gmail.com; chi.minghao@zte.com.cn;
> dennis.dalessandro@cornelisnetworks.com; dledford@redhat.com;
> galpress@amazon.com; jgg@ziepe.ca; leon@kernel.org; linux-
> kernel@vger.kernel.org; linux-rdma@vger.kernel.org; mbloch@nvidia.com;
> selvin.xavier@broadcom.com; trix@redhat.com; zealci@zte.com.cm; Zeal
> Robot <zealci@zte.com.cn>
> Subject: [External] : [PATCH v3 ocrdma-next] drivers: ocrdma: remove
> unneeded variable
>=20
> From: Minghao Chi <chi.minghao@zte.com.cn>
>=20
> Return status directly from function called.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
> change since v2: [PATCHv2] drivers:ocrdma:remove unneeded variable
>              v3: [PATCH v3 ocrdma-next] drivers: ocrdma: remove unneeded

This should be:
[PATCH for-next v3]: RDMA/ocrdma: remove unneeded...

> variable  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 8 ++------
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

