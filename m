Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E1348A6B7
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jan 2022 05:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347487AbiAKEMN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jan 2022 23:12:13 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:17274 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232236AbiAKEMM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jan 2022 23:12:12 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B3T9iB030508;
        Tue, 11 Jan 2022 04:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wu+n7pYp2rN/ihm1rYSpk+6pMAwHDMZD7sHUEcdGu3I=;
 b=bgnoDKwZmgaQ1Nr+NpgoD7IP+VdBfhA1tiKrhChdxlkZ646tetviOSyYThDMBckx/oA1
 DoIljYahM0o1dVnmRDVOXAD64weR5h+gKHrkL1DNeTXP5TY1hsicNv4Ojm9g0LhKxpUt
 yJvP+b6nHQ38z8Y9eKuiJRMoO/vPQ4Nmq7TuYAt4mtDW1gOSe8Y7LhKTaS3KgQmey/UY
 +zaJQdpaW7Du/kzUspfO81BCCJMcfVl9MwhWLcx+cNz1uzbbKN2l4o4gM6+0EaQhxEPD
 OLbqIK8fdSa6jxs10wyVkmF7H50LJWzsu87vW0N1z7uR01FrzVq4DLXmk1gLHMC1EARq Dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgkhx23yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 04:12:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B46QPm106921;
        Tue, 11 Jan 2022 04:12:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3030.oracle.com with ESMTP id 3df0ndgn7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 04:12:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LO/JdwPbwqsZtV3QZeiYfGJ9lzIDB4dqTnlP2gtmcDKWx/T5M0SeasbGtQ5sVZb0jQSsOg4Cnfo6xADPpFRlXq8dLTwHi8f7ayJaekZJkfeOEPlFmmXIfYJqd9oSbtIcFWcIEZm4PDe8vbACZWUqF9Ks2jgbzMOjCqUEL60YsLWriV+PI6U4h6xAO3cNldv8r1mM4s0N5PU/UqLnlOxWicQReZql1UGqvjZZqBHbviZOfPzF8tnMSiyRyZarchq4SYl094F6Mg/JVoCSkGDlB5ONx/ymNQEUtwXhVA6re8lpdGLJ/JKIturYQpIH4dR/xAcnOtx0D3iqTzlr6trFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wu+n7pYp2rN/ihm1rYSpk+6pMAwHDMZD7sHUEcdGu3I=;
 b=GSHbkR1s4KG6lITUkjZC+PDNwxY7Z1V02mcUsI5An3+gK0A6m8miEPNRRK7Mxcwf0FvNIZ8czrAVuJEpVx/2itjdjlslrEhJ4VA5RakUW6sGZa++XBG5+iYUXw2LVnaXC7ZM24CpKbCc2f/A7u3ldw64Fj8QPG9/3pt5twczzJeyIqkHI65iBJKEtPS4zqnZPmIe63el///a/TRSdw/qxXId6n3yphsadDy/53GE6WyLJJ7AWzkc+9hgTxOa45SbGzLF2qs7oM9VrKZYlgK1SoGbU54I21lSTdamfuiBGRzAPjufWP1gYb/OGPPEUqOHz6omzKLb06eSTtEGszZZKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wu+n7pYp2rN/ihm1rYSpk+6pMAwHDMZD7sHUEcdGu3I=;
 b=NJQM/IkiZ2XbHczpUPsAfuThW8R2l6PE3mg8GL/BXk+10VGGz7SXYGifnS5t4Vt8m39HbtKlKHFotdowvWc+O5JW7psfSMxtgbGSdTC7yEhR4SdKoV/3zCBk5A/zfVWEw3iabTW0qoP3n9tbe27QvIJTzMtySBf+XbfTxr/QUGg=
Received: from CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6)
 by MWHPR10MB1806.namprd10.prod.outlook.com (2603:10b6:300:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 04:12:05 +0000
Received: from CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::758e:2fa4:e3a9:c736]) by CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::758e:2fa4:e3a9:c736%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 04:12:05 +0000
From:   Devesh Sharma <devesh.s.sharma@oracle.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-core RESEND] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Thread-Topic: [PATCH rdma-core RESEND] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Thread-Index: AQHYBpJyCosYg0mqVk6OM5SGl6uQhKxdNPxw
Date:   Tue, 11 Jan 2022 04:12:05 +0000
Message-ID: <CO6PR10MB56356364CD8AA266B4ADC2E1DD519@CO6PR10MB5635.namprd10.prod.outlook.com>
References: <20220111022404.2375531-1-yangx.jy@fujitsu.com>
In-Reply-To: <20220111022404.2375531-1-yangx.jy@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ae27504-eb4b-4379-fa58-08d9d4b886e6
x-ms-traffictypediagnostic: MWHPR10MB1806:EE_
x-microsoft-antispam-prvs: <MWHPR10MB1806D509A680D686A3904C40DD519@MWHPR10MB1806.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2JkAtH5koB2NvRz/Be4siUGy/vAm7Fb7eylTrRT/6uvyFV7bvkiIY5Lhle5Bgeultp1wAP+yJuO3fkaS0kImdCUu6osc8ZgcuHEwhPdXKhUL2oLozSgjMIIyMwiEm2YTghnWGw6AYKR1h8kb30sqfzHHiv7HQvsIkhglBTJuZh8e4JCeQw76HlD9VvzGZ8prwK10ewEwzERfjXCNHAlUulqW8MBvZNNEeg9l0w6dws1IwqzB13b9mEsxXlC7MQqsAIG88s+ykFsFbUUqc0viOTnipf3WLW6sUXAfVgHuG4chjxt37R+nBjYA98Gn7Ix+BxBIOO6dVrLj9BN6XxGBV+JkYrAp6BxxFwBdtq4PF/LulGu5y6Cr+SN0vO3yQTg/y34wei4ByZAowl2TzTcXKuVlmp58tk0KHBRe6R5ATiqtyGsBhEGTwrV8orp4qKYl/oHJBbzHsu50ei0CF7OIXHH1KArOomPThE9OZnUhsV87OrJ8rMF4tWPavq1KxsA5vpFzUBKOTfhzddsfPNbMmgxgxG3zzLj0S+VpEde7/RMRpmBXWUwRcZ7ek/C7Pz7DLXQHPdhndKd9vntZIQvnxPMcj8mWylphGdQlNNbL1RcXAgY16hpBh64YB0UwWZKHuIqpLCTIQzgY00miuD7zNEOIWgmhWUP80BZPF6EGXgdyaSVLhq9ujv7ZOPDcYop0Gb53J0WzZxO1XB+6iVCZVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5635.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(64756008)(66446008)(66556008)(66476007)(6506007)(38070700005)(38100700002)(508600001)(55016003)(4326008)(9686003)(122000001)(7696005)(76116006)(316002)(86362001)(71200400001)(8676002)(52536014)(5660300002)(83380400001)(186003)(2906002)(66946007)(8936002)(110136005)(26005)(33656002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oeLHg+JFx0y7rhqjtWWvwbNt7/bbSeor8ZdSsGcC1Ru1ebkcNANod+/bAEHH?=
 =?us-ascii?Q?/WbEv5zUqbqLOEdm3fpmSX5Dty9hY1n73ttyomWW8QCIUo5cpoLdmaGH7a/2?=
 =?us-ascii?Q?mfMCUxJWkmx9NCZ6Q9A/iDuhEiJ7ZCtd81Zie8uaK+dy3kkR97iMJywRHD2s?=
 =?us-ascii?Q?xvCia02vLDdWQpaI3Obvwj16fSJ4L6xD6SQgkEfYQYXffLTXCw79X/sfJqGN?=
 =?us-ascii?Q?nb6ie5z8uxZWhHAO5uLETmAf5ivnxqQ5Uh0T55ji2nOS5iWakU6Tf07pzUiq?=
 =?us-ascii?Q?g+9G6OYrnnwY5l3CSMw+l1lJFTjAdW0J719vTDitqbi1y0Rj9P75KIyyh4zH?=
 =?us-ascii?Q?1RQPgg1yxlCViaMp+cdnkUF8jOvDReQwEg3F/zh+t3dXrygCFPqkzuvNMwOT?=
 =?us-ascii?Q?MkjMUT4asmb13IAD9z9EVVXxJet42wQMHoX2uPyEovPmQmv7Y3kSoCTSBV3J?=
 =?us-ascii?Q?uzCHWGGped0k9x/UVhnmdpAZMrLZJ96BatCKwfV/G/X//MibAaCW6OCVneMG?=
 =?us-ascii?Q?H1qzKmA4iCA7A5lEUGNnp1LmvIcGFkeKcClP21lZOdcj6ngalhCDWLfor6D9?=
 =?us-ascii?Q?JPLcG0XtqdDNV0kO1Ti8hYHSD+N7Oon0TPACCCD9xsSkO58lOYHoLNL3iw33?=
 =?us-ascii?Q?g3kGD8vndIXsKCOKiLPtilF5YH8Id53oWjpy3EzAupbUExzU3BGT2DsIaizI?=
 =?us-ascii?Q?nz7k0ZBarFN/qJLIIEjOFq2Z85pXUU8aza6yF9pQ96MGbIkgC9l01xtxhvkK?=
 =?us-ascii?Q?OX0Npsn5Dm5snmgcisagpNBcJhJoRJME+XqOavhsBDj159ylQm8cs81zaAH8?=
 =?us-ascii?Q?Jx7E/3OU3/atcDWSmV5yIBwCxGDiuVtEdJP/txc0ta5sFLIAiGUR7oq5JkNR?=
 =?us-ascii?Q?cB950fMtCCG4PQ9ObN28ds6W+mBIvQKu0u+PwuzfUrz4BMT5XS3tPgjSLh55?=
 =?us-ascii?Q?/EjO2M65dGXYrApPTcuSoIWM8n/2PTzQWXXE+eAK2YQ1zlfBSJa6ZpQH+gkm?=
 =?us-ascii?Q?uWVANytqTLItrX8+uw/oOIFqf7nQjKC5ms26NcXbe9GO1TZTqSg8/CaXk1FC?=
 =?us-ascii?Q?E6FbA5nOl1ipZA3Ps/ptuSdgXZWk6+0nokBkTnQ2d9b6I6YubMxrj4uSuCNZ?=
 =?us-ascii?Q?tmtZEsP3TlXOrLIHqHIMUowh4YkBPLb5hAhl1mPmWa9Kc6aXjUC0/Sx3VNuN?=
 =?us-ascii?Q?df0yUgqQrWs42p0cExLCGicZOQ9/G9X9CpkBsuoJ9JXN+cMdJjHO/kNgw59S?=
 =?us-ascii?Q?NZqDndey/ZP95xVcJ8sLMTMrJDEua2v0NS04Aczvc9XlXiAe+ueG6WZFu3pb?=
 =?us-ascii?Q?qvhxm9mm5yjwl0IVw/yIWcM8jZYmfsZDvTkWcdJUKDBDuPgVtL3jXG3oMYCG?=
 =?us-ascii?Q?gSyUXlJCAA1I5HfIGZZqcMhkryP8SoXGnG+CdHk4L/VFlTtQ2sZE/GV+8xLk?=
 =?us-ascii?Q?3KFcc5jQps9ZblAhMAUm4HElDzm4ORbL6E2UB8AoCh/cW1E8BvUduG4KAhEu?=
 =?us-ascii?Q?aGC2sGDM7+6hS9nXJ66orzBI0Nqflaibg0Ig9H/wweY7Cg4OZo3le6xAtb80?=
 =?us-ascii?Q?WwRaXPICE/xdEVGFvRNuPtcu2Zn2miP173hCxGSYhpkoI6vuW3nxTaF+9BZL?=
 =?us-ascii?Q?bl0EF84fqPSRt2+jtqWcoylkzYcclb8nOot/W2xHvn3Mho1rAaXoqaFNoUWT?=
 =?us-ascii?Q?Z+inPQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5635.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae27504-eb4b-4379-fa58-08d9d4b886e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 04:12:05.0741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YKp0XdlylVXJ55qxthOtCteAaI+VlSxVZokktqza+SAa7se/ZQhZJNlCPCSKwIPZyFbY/Wjsmdp2UaAMZgwkM7uXWTMK8awIJLyLyKvHSwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1806
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110016
X-Proofpoint-GUID: C3sYZHvsk3aF9IR3fZrAaEDPf-an5g6q
X-Proofpoint-ORIG-GUID: C3sYZHvsk3aF9IR3fZrAaEDPf-an5g6q
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Xiao Yang <yangx.jy@fujitsu.com>
> Sent: Tuesday, January 11, 2022 7:54 AM
> To: rpearsonhpe@gmail.com; leon@kernel.org
> Cc: linux-rdma@vger.kernel.org; Xiao Yang <yangx.jy@fujitsu.com>
> Subject: [PATCH rdma-core RESEND] providers/rxe: Replace '%' with '&' in
> check_qp_queue_full()
>=20
> The expression "cons =3D=3D ((qp->cur_index + 1) % q->index_mask)" mistak=
enly
> assumes the queue is full when the number of entires is equal to "maximum
> - 1"
> (maximum is correct).
>=20
> For example:
> If cons and qp->cur_index are 0 and q->index_mask is 1,
> check_qp_queue_full() reports ENOSPC.
>=20
> Fixes: 1a894ca10105 ("Providers/rxe: Implement ibv_create_qp_ex verb")
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  providers/rxe/rxe_queue.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/providers/rxe/rxe_queue.h b/providers/rxe/rxe_queue.h index
> 6de8140c..708e76ac 100644
> --- a/providers/rxe/rxe_queue.h
> +++ b/providers/rxe/rxe_queue.h
> @@ -205,7 +205,7 @@ static inline int check_qp_queue_full(struct rxe_qp
> *qp)
>  	if (qp->err)
>  		goto err;
>=20
> -	if (cons =3D=3D ((qp->cur_index + 1) % q->index_mask))
> +	if (cons =3D=3D ((qp->cur_index + 1) & q->index_mask))
Are you sure that index_mask would always be aligned with 2^X?
>  		qp->err =3D ENOSPC;
>  err:
>  	return qp->err;
> --
> 2.25.1
>=20
>=20

