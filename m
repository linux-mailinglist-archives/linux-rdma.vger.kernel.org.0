Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0046474134
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Dec 2021 12:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhLNLMY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Dec 2021 06:12:24 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36238 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233411AbhLNLMS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Dec 2021 06:12:18 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BEAu9sc005512;
        Tue, 14 Dec 2021 11:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Kg0hOyl7c1s0R91NekvtH8McFslgWKQO3XUBZVTotNM=;
 b=P23BlJDseuAq94pDaY5LjBu+GfNjUR4115oak84+VEK0ljDy/O/NsMHYxp5pWV4TK5g6
 Bs80/GMABSrnVqtfay8k2g76qnJCuiiiiwGNVkgpr0ezVwlcVguHSY15mjhV1UQ2b9BT
 tPpOT3jEwr3VRGIUXSSR8DgCAsgT5kdRyFHL3Mn9405oV9aNUhN0Pz8nxSZ1HqXFPoN7
 iAwsb9WroMDEI8nWxCpmaVPvEfWww6Y/hqCPlwgh4GpeSxTPtwAZU9ZgemDBhQLKBJoS
 X9FOrugr1aGULYqGArN0yBaqgcDIdXXDPb2pfUk7wf7K3hiT6I0e+XxBZTu+hz/yqPzk 0g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx56u35pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 11:12:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BEBAVrJ137957;
        Tue, 14 Dec 2021 11:12:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by aserp3020.oracle.com with ESMTP id 3cxmra466h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 11:12:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfLBU/ow/CqDTV7TiVr/YfBWkj1dnJRogyt9hfFQy67U5iOY9Kbo3hcE/hszo6apEU6KQSzjIm9ZRnnm1YsQFCK1zv8OaWE6mdw9V4aIm6PtNnYXLiCAiOa7eS/VAbSVwRkE5YcAW1kPWlN/2tkwyPXYbv5XfDf6Pepkt1Jg/3aJ9kmxtozfa05+KS6xXpvoZ1giMehLqgGGVOjh/DiM0DsHZdvEe46YLCizQMOqSMD7/B4WeqTVc0Ggg1xhh5CPdu0vjFsfOx/eQObpXM4sdP0n49OUj65rMkWwazHKCteLmW3L8XaEBmRlxlStnOy1B57EPas7hHKOn4wAoCo9xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kg0hOyl7c1s0R91NekvtH8McFslgWKQO3XUBZVTotNM=;
 b=ZfyKATtEUj6iexeJlHHuQCBTB+R7SII207kAWEt5TWCp9E172VLAAc3XzmUyWbpcMFrENgDrf+emO5Yz7RQ8QDeZRQAEyaaCt19r4+GE6ClEQuo23DV4rcARJbaE9Zyp9Dvuwmp4Ti5EVYne6d1qGUbek/pcRpZNLf5Y1C2hnh5EpvW8hyxgxkVv2ioRhrTyRpwuYTTzbgkjSt3XumXkFj1sygvZ/F8NNG7HefbXvYh3Z/0VRoAhfwXZNCVEU/lDbNWYjj8HLmhrQH4LVHs6K3J3Q0CJaYNeIE+/GseCyaPz4HZNmr8D+EKQt/CFeUcvjr69HQqiF2BWqg8xlc6RWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kg0hOyl7c1s0R91NekvtH8McFslgWKQO3XUBZVTotNM=;
 b=srGfa7yVhN64CEPksLp1KN2zdPc+tDwCC23SMt7ZujS0QAYiCqyuhK+akP52yRCLFUuZDomutA7CXXqtrY3tOpugzq3+YCrYN4aPSnNpdQDOsrN+AL4j+ScMqbqVQ98SblS/v1vsJWHQ/1eXtNfplCYFdMEaeuYvA2QzOYPayCA=
Received: from CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6)
 by MW4PR10MB5704.namprd10.prod.outlook.com (2603:10b6:303:18e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 11:12:03 +0000
Received: from CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::eca2:ec30:e72f:93ee]) by CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::eca2:ec30:e72f:93ee%7]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 11:12:03 +0000
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
        "trix@redhat.com" <trix@redhat.com>, Zeal Robot <zealci@zte.com.cn>
Subject: RE: [External] : [PATCH for-next v4] RDMA/ocrdma: remove unneeded
 variable
Thread-Topic: [External] : [PATCH for-next v4] RDMA/ocrdma: remove unneeded
 variable
Thread-Index: AQHX8Mxg1ediA6aZk0uh7pRJmhh2C6wx1POg
Date:   Tue, 14 Dec 2021 11:12:03 +0000
Message-ID: <CO6PR10MB56356BCAD2F2A3B6E9445F5FDD759@CO6PR10MB5635.namprd10.prod.outlook.com>
References: <CO6PR10MB5635347074DDA51CF2766B9DDD759@CO6PR10MB5635.namprd10.prod.outlook.com>
 <20211214092339.438350-1-chi.minghao@zte.com.cn>
In-Reply-To: <20211214092339.438350-1-chi.minghao@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 068cf700-3d5a-468f-f9ff-08d9bef28ed7
x-ms-traffictypediagnostic: MW4PR10MB5704:EE_
x-microsoft-antispam-prvs: <MW4PR10MB570487B1F2C5B42630F788B8DD759@MW4PR10MB5704.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:22;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t08lamIWRD32PBhyHtuKvq5zrFHGuHjpzFUaCpJFBp/UZG+e7dg4/3q6IWrOYghfhXZQFU47pMBYNNaguRio0gNidVCWJiJxCM4BBGFMMvSBFhX9BbGjE2AOBWnLS4TIpT2rhYssX9nBml39mKxaybJpVUdhpGXySWJ4Z4sxhvOLOOUZejzdhVnQ5uYYyGAATEoTW7inVpJif0MyXx/mBi+sr2Ng/PRAFTa12pwp0IOC1vULTtrra//nfWts6cORZVn+/6ZXwkdyIEvn9uUHQO3QPC3/7T/oRXoFfPxUoAhHrWn9fv/h7xgZbYLwJ7IxtsQNjByMSs4ZnmyY1Acwq200yyHjHodERWsx1OFSUKFzzl9zWCSycWPnBYYVfSqyvukso4/SHcgX+fUcbzdbdNJYwFHE63+GSZ34GcXpC77qrsa0Sy1vBu9RhxHD4TQ2XBoZ0GqgUjkZq0pdhSp8T06Rb2BPVA0ZFLmJEl97QXzdQJwP6b3EgXTHzwQuyHGfJcbjfYfW8wXa2Bh7hz5VMptiP6fkJOwMdsGNOneYOvFBdtDZBmDXdnmxXdry95t/jh/gfMocyAQ1GQtfA7ACsBF64gfS/A3ttLtCw5NDYeFxzKmehsmUct6gal2r02c8cuiLA0phvvOfhT1fbFSN2YTgPyQyT2UVaf1mR2i+xMIaqstaQ5C2rF2ud+tTsi1vq/NGGzhIjlHTdDV/7OL9LQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5635.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(508600001)(53546011)(122000001)(5660300002)(54906003)(55236004)(6506007)(7696005)(316002)(38070700005)(86362001)(4326008)(26005)(6916009)(55016003)(186003)(9686003)(71200400001)(2906002)(66556008)(8676002)(66946007)(64756008)(66446008)(33656002)(66476007)(76116006)(83380400001)(8936002)(7416002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+gN+7f5ZS0JBU2m5cNbplR4W/AhWjRHBJsZqRDsQL2n4mYrwrDYXV0AaLVDJ?=
 =?us-ascii?Q?0Ev78dzc8ArOOmcSSeuql2jVZlzCV/OwMv0IKtaKwFO9e+nINhOwfRSf4uWm?=
 =?us-ascii?Q?0+muvC/l7qBfk+qARYUZKyQolLiqzeMP2gkSJrWVHSAC2VwPeR8LO0hYjjPa?=
 =?us-ascii?Q?I0DFx7xQIDpi8zF9MpkllevMY71OJr+P2AfkejQMipil1rYmnGpKmzJ+Xgnx?=
 =?us-ascii?Q?2dk3l+iQ2kRkPwGSce9xe9UShjFHmlLBdbICNrB45RO4+kdbvk3ocfx2V7U8?=
 =?us-ascii?Q?JDbYjCIVd1Khp2yGaYVhqVQqukSoSwuxWdQqQ1noWPh5m7OUkiXBKy6Sw9hO?=
 =?us-ascii?Q?IxM4Gl0LtMWCDJ4Yydt5VC72t5pFDNiTMA6VaNyNf8y+gtjKVTEjO3PR6etX?=
 =?us-ascii?Q?sJ+FxvqqYDFrN1EXxL5MC2m9deAPlJ98QkJi7Y52EwGGJFv5jDD5+40NgwjI?=
 =?us-ascii?Q?eB9XjF4TWgM3w95Bj/c7h6/OqjOuyiBng8oopnTb9SxL6WFsJxFB9dakMuky?=
 =?us-ascii?Q?XYMMXHH/fvKtADqceZCWtxKSdn09J2+UX2oie3YDKd3AIDb7aa4IAL+dIhit?=
 =?us-ascii?Q?+KxPHXut3jcAhzv6UNAKdTEGk9ddThhkDOmrx/NZb8WK6MQyQCQ9XE1eA70p?=
 =?us-ascii?Q?12H2eonV4Ef67L9q39oYg3HDAU8XPAXlo+61MoJ26+hx/47mVCFvF209hrnA?=
 =?us-ascii?Q?dz6SZ6xi0rDNUE2CghusNLmW626rDSdXFkzsr5uUa2dS24ASl1Z4lPM9a+Gx?=
 =?us-ascii?Q?pt9P5asVgIuXNwpPlZBAF/mrf9lVYaSxTE2OoErfd0u9wG2+kBWgiFV9VcLe?=
 =?us-ascii?Q?9DVq33iwJlJ8vk7WS+d1gs12FrDxY2R8hsGLUt89evQY5qtgSdzaYK5K9ee5?=
 =?us-ascii?Q?vge3IiQXGT3x2TBLMXXpaWdV3yjTJmQKra+6A3joHfXD9adbvMzGQtgmZr9t?=
 =?us-ascii?Q?sbg/7d2upFZ/UdY9pikX1IF1b96x5sHtrTiZK9P3WSFpYxqeViUgUsjQjcsA?=
 =?us-ascii?Q?pbpStAM6wj+mOOhRE62yL3RWver7dCK9yvVjNKJte4abPUb5EN51r1zSwx+8?=
 =?us-ascii?Q?dKkb7ku2DoUrsO+wcv1/YeSZ2dGCfrnNk7ge/aNPa13FCwjIEnUU0uAjWVeW?=
 =?us-ascii?Q?MQ3WGedJ0Srq9WgHa2Za1OIOjOnNgu0LCQqoYf9xhQzC1LF78A3bPljrJb37?=
 =?us-ascii?Q?HAXkFHFYuOBUfsn6n7e1jwP4NfH9TxqX8QYbnr7WyxCort5f0WasEGylOgjW?=
 =?us-ascii?Q?J3LvRJEINiIfVtBAAlV4EIk+9p6Kg55lsBpyqUXKkg+iiblQ9xnbCr7xFP+l?=
 =?us-ascii?Q?GxaXZk8vVispX3WG9/0OKvbtXLL3swusm9oqs0wVIU3K372ryZLqdlsew4cH?=
 =?us-ascii?Q?LRF5rO0mJmbRY3Y9XPaDsz7PUQsgTDz3jLW3ChBaiWmVI6AN/ohG5G5f5i1p?=
 =?us-ascii?Q?pnHbp0fQmOl79Lj6bTIQJmM/X/u0DkgEb/jeozwNCZXUnGezzk06FoSSItDX?=
 =?us-ascii?Q?L4UoKwocUBB+v0pBe5qmhAiUyPjz6+rHyhlLED++bao2XhceGn3ypFPOr/Ks?=
 =?us-ascii?Q?++eWXGHZnpp9JHyMxpWsrvMTh0PD6huKvFrN4nzfr8tZ6wLTuZfKo8Dj6kko?=
 =?us-ascii?Q?5t3ldDG0vn/JkT10IhGlpt7/hiBHkOS7xsDCykM6vwsmAkv2ThAyNcM9AC5q?=
 =?us-ascii?Q?BFXzQQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5635.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 068cf700-3d5a-468f-f9ff-08d9bef28ed7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 11:12:03.6133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h64nldbG/a037UOH9TDSYWyvuBr+tnQIkjab4nWGrAc1qy0WWwQ+GPjnntogk1nJ7wNXyoLBwY536b0NJHVqdsF7v0XLtDWVFMXVfBbtpgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5704
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112140065
X-Proofpoint-ORIG-GUID: -spkKZt7ciUKaFnBt1DYXMf18S9cPU83
X-Proofpoint-GUID: -spkKZt7ciUKaFnBt1DYXMf18S9cPU83
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: cgel.zte@gmail.com <cgel.zte@gmail.com>
> Sent: Tuesday, December 14, 2021 2:54 PM
> To: Devesh Sharma <devesh.s.sharma@oracle.com>
> Cc: cgel.zte@gmail.com; chi.minghao@zte.com.cn;
> dennis.dalessandro@cornelisnetworks.com; dledford@redhat.com;
> jgg@ziepe.ca; leon@kernel.org; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org; mbloch@nvidia.com; selvin.xavier@broadcom.com;
> trix@redhat.com; Zeal Robot <zealci@zte.com.cn>
> Subject: [External] : [PATCH for-next v4] RDMA/ocrdma: remove unneeded
> variable
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
> variable
>              v4: [PATCH for-next v4] RDMA/ocrdma: remove unneeded variabl=
e
> Thanks!
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
>  int ocrdma_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr
> *srq_attr)
>  {
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
LGTM
Reviewed-by: Devesh Sharma <devesh.s.sharma@oracle.com>
> --
> 2.25.1

