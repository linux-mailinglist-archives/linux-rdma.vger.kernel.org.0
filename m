Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89B144AF7D
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Nov 2021 15:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbhKIOds (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Nov 2021 09:33:48 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13644 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238509AbhKIOdr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Nov 2021 09:33:47 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A9DUT7h017302;
        Tue, 9 Nov 2021 14:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GrwznZduVupbwxz95pBq4UhfKitGJHEV69qqsjGJ2TE=;
 b=oC73u3TzZS0Ydg82OXQQEoeSYg26Xqid68bfQs0XumM0yCghl0Vnn63oosKXIpYmdoTo
 pE2Slp27gAeSxoFmwq4kMeopcLjlAxdapwGBpwi1lF4DjrTITOOujmcXCDQMnJs59C25
 642UkLSYUhiWrSOGhgoQE6qRsk8ulRlupRflngbxaRtoWaYlAHE55RwOCrHk9wZ78u9p
 DWRJp90kG4nY4r+wFdMavVkceV3klNNCTR2I/Bg6j8r6FQyz88VJpM5cDI+ThGaTz1+C
 YFiEGb12uxOQaQfOVYIC9WDjGF/4HGcG9FKL9OyBB/a+WXGhwFLsPkwZ1ulP/Wh31MKO EQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6sbkaqs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 14:30:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A9EC3YL038447;
        Tue, 9 Nov 2021 14:30:54 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by aserp3030.oracle.com with ESMTP id 3c5fre0xng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 14:30:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/t3DIA0pzh4RHk/KGTE6Lix4x2U4xMlsJTAXQQZv5V2PnaFib2hkJCZ8wLP1Dy3UhDFp0+I8Lu4eV4LJdVwG2smOytYA2ADOnDyJNCfXCCz10iuMHFTIwVPDeO7RG0AwVK63k+HDTtCVgroF2i/4QINQ2bf+wueM8xUKkPeYG130uI2ywj39sDyBvwsoU8dpdt7R18AT1YPhpJqqY+ioKhNbYV4nIbU0zaODXXxFadol0sFj67OfvQPipMvuFw/BA9FYknkiN4h3dg+x0pY+g5jr2VdRD3CSVMZWrdrwesgfvloNX/v2+F8Kxzs0fzNXW1fsmVomRKi4LrxmJpk3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrwznZduVupbwxz95pBq4UhfKitGJHEV69qqsjGJ2TE=;
 b=Htr5xpmIbzM+FIaxwA++y7OeTWabkDC+P/w1nwuPTxVkPMXYjyiWcKyeJLIekOyHT4/HyKyD2GD6rkynYGNzWbf0XcKUMnx6q5a8ERMobJ8l1yPAOIVztHBgfJcSLpTNWbR1yNarNWqSh6nqcOfmVZ/UnCwo5sd0qB+x3fLUxfC4DnfFuSoae4ChubMGt7YqDFPQYnwlIWsbUL0o0zANUnM/xzwC8O3de8oSS4iL/wW05/ewBwstS6eWo+OS6DZ4gDJE3IUbvmr8j6TgHyVEbxrEpwOWdpsZy3hj+1P4gDC9+wpibI027kHfnI1KIZUQkda5wftkwlVFIn1Uf+ziTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrwznZduVupbwxz95pBq4UhfKitGJHEV69qqsjGJ2TE=;
 b=Cm7X71puKuSttFipQRpSn6zR+/M+kBtGi0+Elc/CjOZO16MH+jGyzrYOitEFjT+lnvDXGGg/sgnQg+WYlvWqxeBla1tGbihFxZGAXw/vx1aZsIXhVS/sk2qvtS2Cdz65HC9CREfYG3OB8m6bmXa4S2HoGKmZsF2399t5bzshCIg=
Received: from CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6)
 by MWHPR10MB1517.namprd10.prod.outlook.com (2603:10b6:300:23::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Tue, 9 Nov
 2021 14:30:52 +0000
Received: from CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::7d4a:284a:f0b8:1511]) by CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::7d4a:284a:f0b8:1511%9]) with mapi id 15.20.4669.013; Tue, 9 Nov 2021
 14:30:51 +0000
From:   Devesh Sharma <devesh.s.sharma@oracle.com>
To:     "cgel.zte@gmail.com" <cgel.zte@gmail.com>,
        "selvin.xavier@broadcom.com" <selvin.xavier@broadcom.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: RE: [PATCH] RDMA/bnxt_re: remove unneeded variable
Thread-Topic: [PATCH] RDMA/bnxt_re: remove unneeded variable
Thread-Index: AQHX1V3uQGvCmPbQekuFJjI46x9EWav7Qblg
Date:   Tue, 9 Nov 2021 14:30:51 +0000
Message-ID: <CO6PR10MB5635CFE03D6D57B6F0C66F08DD929@CO6PR10MB5635.namprd10.prod.outlook.com>
References: <20211109113227.132596-1-deng.changcheng@zte.com.cn>
In-Reply-To: <20211109113227.132596-1-deng.changcheng@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88367363-729d-4700-31f9-08d9a38d880c
x-ms-traffictypediagnostic: MWHPR10MB1517:
x-microsoft-antispam-prvs: <MWHPR10MB151700BD430DBDEA4ECFDA22DD929@MWHPR10MB1517.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5kA8jvsM8/gd/GUYWGyfOKLy+5tlA+dahSt7wIarTt2PqDE9dBCkSJcvNb+rFP6rOPcR4B4loXU+4LB3jbNDymH78njRYT0WOMdg0HD/izc442KK30MjkLKshb44ReZDd/3vqAe5yi2u6FwCZlO8NtyHMvYnGp+fTgi6w6XiyP+PMl3x62WzuAukPM+KAzbnODbGISVBSo/N/SpL5Akt+rGBOXGCIwcf84C/c9FflqBtOkxvrjFSEgDiKDuhkQ4ULbhrqaEWikWZqVzA9qvHk0YAT5iNX5k/O9Euy2ETEw+jtzvITPfBc8n01AJztm1sHQtfMPokdey3xxiJbv0X8h+wWkDRQErUx/skkcRSuikAgksUUSYQEptIPN0r3CH8aRFEpjLV2dNV/brLmKl7CpZKep0acbsRFsUp/HN4tGjfgiL/+GoOrv9IVlfEwKHeL6IWkpKYLCHjhqKE+aeqKNR46oUhQmgsR7CTqHQfddkVIDlBtip+dTbPdGVkoPBVClpKuYpbqnTWgU1yevSh6HYMmT6xpykQYuqmRkypxSzdF22sDb191IsHnX2dWvIroY5dU84dr5Tu9FsYpoPKknMcniC6FnW1ZKQLUWxk+9My4RZlzUdN5TBh/kgIn0jc7H16s51JTeocHyeGuAbU/b5s2N/IPGLyyG8GXgu285grx7LhybclGmeLc+Fo+n1c2dzGGgW476PPr0bv2wW8ug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5635.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(9686003)(110136005)(8936002)(86362001)(508600001)(53546011)(33656002)(71200400001)(52536014)(54906003)(316002)(186003)(38070700005)(122000001)(4326008)(7696005)(55016002)(5660300002)(38100700002)(83380400001)(66556008)(66446008)(66476007)(64756008)(6506007)(76116006)(8676002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TsTgxJ5Vey1kZvAcnPAu0VIiNswRSpaze3F0okuLwIln030YrwCmNgKZZZiO?=
 =?us-ascii?Q?DUIAzfYTC1yAplU5WXb0LurzIq/BcBqyULPRZWbh0atyjfJDOBzuRCnQE6rs?=
 =?us-ascii?Q?JZMdmjuEmBfE0Pw779JPRDEpwLtAtAVrZdD8Z4ao3QCn/A4qs+EEmMxyLEAe?=
 =?us-ascii?Q?8b3DP27UUcRkz4lgUFjjYWANICZ3C6A01SPGUU6nUZDL0HunI3HeM4IHNuJi?=
 =?us-ascii?Q?NnRQYSlkSFZjjGQ/Lr8Umfzrodezy/3OVrqZHI4Rgzgg/RdCoGXd0gh7PjHP?=
 =?us-ascii?Q?qwAKpFosGaH/xYO/PkwAqCOvmjW0ZXMHdMNng4cINBv+B7OWn56GCd8wgNrH?=
 =?us-ascii?Q?PSuLfRdlyvTvY9VJhrRPFoyRqCMkoL/IovnPBGncUZUcWx7tRioZFYoGxCc6?=
 =?us-ascii?Q?SYH7CplWRTW8PlXrVxNlR9EWVM0pIVcL6KgtAkneWe3Xa3TyceApFrato2DY?=
 =?us-ascii?Q?anWUwQ9M2MpOXqrU7eLjlrJwURVo4gxK0QR3YoWwRDBhKY/nu1FLuqYX3hm/?=
 =?us-ascii?Q?AXMvBy8+sjtygBEO7nyVqTj4MZiZHOCE7lPIPfBEBKxYtmMXayakZpscWUB5?=
 =?us-ascii?Q?KJZBXMivXfM3Zenp7Cfiz90crTI8tC5uAtvCapQgYZmNSKP5N51+ZZnOKh3Z?=
 =?us-ascii?Q?P8yjIXtK5iIXgRVHD6DhtDxKt6Y4aMx4hS1y4vvtZZtsf4mEjBdrUpeG3WSv?=
 =?us-ascii?Q?NBk9D2WQQrPu5SRGe1xJfjcUzi32be7i+v7kocAY/ZrvKeM36nVDEa3LK/Bu?=
 =?us-ascii?Q?tS8JXdsuqq++utEdiasmIlTpfJywWzvQKM/JblBtBt2D/RcxB9RoX3hOLi0v?=
 =?us-ascii?Q?68Wb6az1VuwC1D+1Rib0mXTzGk3DC4w9BW/D2U8oYCuFz4XO3AVTw3UChL+H?=
 =?us-ascii?Q?ht2335zUhA2XsobDok3jPy4kjZqoFFkaoX7uxemUrSJ5/2vlxNmpO5ns5RtH?=
 =?us-ascii?Q?WjA4kLIpVUYacUiOb6uFEZV9qboTTOthKFQov3u7suDzEwNoW1vvNPzfvAFd?=
 =?us-ascii?Q?+XXlLxiKnEVv7OuPfLNT878RW+FhtKZ/wdHclb+iK61QXFQKPHc4m5xkk+su?=
 =?us-ascii?Q?jxO5lE0bKJFWhOQbcs8uJrfKTiGfSNyxcve92oEtkJRgeniPHfzQ5YmYyXbu?=
 =?us-ascii?Q?lP1jP6nnWag9L5cq+eve3PhgDqAJlkVMvb4IDwTyCI8qnQ9hThRxIDHTiXbI?=
 =?us-ascii?Q?DC5PwkN314awiSiQ0/aD/SNwuUR/qxLV7H+rWnn3ELOzmKhCAYm/UsvR78/U?=
 =?us-ascii?Q?vMGTD0oU5DHuYEQaNB/KKUyF5bNiMTooqToiD8HeeWfmBUSnA/bxIfvX6by4?=
 =?us-ascii?Q?+O9zFJ0c0RF5URLyVrjySs6EJYj1g5XF/oI6k2OfGHql4FPHpqAfydvCIIaY?=
 =?us-ascii?Q?NLQcWleEGW1cnfv6PCdazWDOCNuXSg0AEcQRu0TMys5Law1BUqTop6Irc1/R?=
 =?us-ascii?Q?dYgcesOZ7B/Pf+rgyxLxEvQylrxHsN4rwqjTY+8Svlev6xhoWiYWRvjJ4yig?=
 =?us-ascii?Q?cK6DlRhbcdsujgtdYNcFlNsNXUmEpwYmgKy12D9byDQI7VagxvesQAUlwvLc?=
 =?us-ascii?Q?pLG16wDu4jDQd6jM0MIipd7tK0+JYZRWsOl1jb1S5B+JQP599bbjqDRQJQ8S?=
 =?us-ascii?Q?8G/DcDwra4ug7vJzsUBoX0ZZt3oEgk3QUy0l67I3arIV+dm7CAPnM+d4Cb7y?=
 =?us-ascii?Q?FVasjjW94kzZQQF20ez9xYsJXHc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5635.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88367363-729d-4700-31f9-08d9a38d880c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 14:30:51.6508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fIduamcEh0pH7+Dm+mTh+3TWgua1FYI0rtUMq4fMh0PG5jGGRBBDX8/xe2Is69mrk+Uh21q7DHFdO2GwI9SPK2dKw5uAxYrc3CWozSZADok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1517
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10162 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090086
X-Proofpoint-GUID: 0UANIhlGGlgZetQRh9bFiOuMX1OxxSUh
X-Proofpoint-ORIG-GUID: 0UANIhlGGlgZetQRh9bFiOuMX1OxxSUh
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: cgel.zte@gmail.com <cgel.zte@gmail.com>
> Sent: 09 November 2021 17:02
> To: selvin.xavier@broadcom.com
> Cc: dledford@redhat.com; jgg@ziepe.ca; linux-rdma@vger.kernel.org; linux-
> kernel@vger.kernel.org; Changcheng Deng
> <deng.changcheng@zte.com.cn>; Zeal Robot <zealci@zte.com.cn>
> Subject: [PATCH] RDMA/bnxt_re: remove unneeded variable
>=20
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>=20
> Fix the following coccicheck review:
> ./drivers/infiniband/hw/bnxt_re/main.c: 896: 5-7: Unneeded variable
>=20
> Remove unneeded variable used to store return value.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>  drivers/infiniband/hw/bnxt_re/main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c
> b/drivers/infiniband/hw/bnxt_re/main.c
> index 4fa3b14b2613..2ce0e75f7b2d 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -894,7 +894,6 @@ static int bnxt_re_srqn_handler(struct bnxt_qplib_nq
> *nq,
>  	struct bnxt_re_srq *srq =3D container_of(handle, struct bnxt_re_srq,
>  					       qplib_srq);
>  	struct ib_event ib_event;
> -	int rc =3D 0;
>=20
>  	ib_event.device =3D &srq->rdev->ibdev;
>  	ib_event.element.srq =3D &srq->ib_srq;
> @@ -908,7 +907,7 @@ static int bnxt_re_srqn_handler(struct bnxt_qplib_nq
> *nq,
>  		(*srq->ib_srq.event_handler)(&ib_event,
>  					     srq->ib_srq.srq_context);
>  	}
> -	return rc;
> +	return 0;
>  }
>=20
>  static int bnxt_re_cqn_handler(struct bnxt_qplib_nq *nq,

Looks good to me
Reviewed-By: Devesh Sharma <devesh.s.sharma@oracle.com>
> --
> 2.25.1

