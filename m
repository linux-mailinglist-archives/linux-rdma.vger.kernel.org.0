Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A55F48AB44
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jan 2022 11:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbiAKKVl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jan 2022 05:21:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23328 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233911AbiAKKVj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jan 2022 05:21:39 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B8cl2T018289;
        Tue, 11 Jan 2022 10:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pI0bO3k87SDCOucnO6DLZ6wg1fzQWehmR0xgME3yL3U=;
 b=gx+a53fuHYMqsey6yNSN+7aCO6ba2Ggw9jnltRzqLHkBqBI5P87TAyZNYoK3QCmgxLT+
 lOGusNJdM2NmxgzC1M958cF+hTrH4y4k6fSh0Lrhta6RLAm2q5RpOaN4cdfwC8v+pLO1
 9nwA7YGTuaEsNmPd0+taWluucl+U7FTsvmlgGY+ShRabO3Ci/yQ8ul9wlNsXNxsw1ypN
 klmHYFXN1hxIQdBQwlGWzX9qkSNP3sSG1H3uZgC8C+YZiVmc7qKYZbs7kgxI0n5opYDK
 lejLPFuToOV6nMHQlIIrG8KBaDA8kz0GmMddCpemvNPVqDvWBPmJ1xm9fEEn8RVOvJ0v rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgn74am6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 10:21:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BAA9DS061839;
        Tue, 11 Jan 2022 10:21:32 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by userp3030.oracle.com with ESMTP id 3deyqww15x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 10:21:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9s1TqXWHJzdMHg4sUSMdz8wva8dGcq9gMuLvEWbgXXKGXt9qSXJNCx1/PmC1icXsfqSEsZm+/zpDZO5fq/oNRfdVT40uZOL5jHh30HI6cV2JSgdZlrioV4UQPbzQzoRR0ChnTVpS7O4UI7QSagew8AJk5ousDCV+qBwMlywaD6oLwOWBPHRmIeotjZW9IWEeWC39oMaGAxqLqAgae9nIogwqqS4PWYWmLs4b2YWRp43OoLhDbDyfghk3CVp63SSWbw54bVMlC3q+I6w4xXys+71n9ucjBOtY9Zf/59gwcODMh6H+7uQQ18X9IG2QduoMWaupqxVv50eUuw+RCgEcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pI0bO3k87SDCOucnO6DLZ6wg1fzQWehmR0xgME3yL3U=;
 b=Vff4O5m5taSiINJco6h29WTjdvif0P3DU1a+kBUP7p0cr+O9xyfLXeaJfJjq2DSKvem6iXOeC838Y8+k4x3ywHTFFqYvHd1U0BEWP1vmtdNh+A3dfdk9wAtvRemvZ5IN3KfJSNnQMYocO3bSyUw347GIgaP6aBhPdpqE2sY2AKg+mL0KVeb3CGg3el57yhqC1vHSN0E63DNgs4Q6lgWqTGMB0KgXfxrAPTrscJrU8Ey0J1fbW/tlEW49vHVmiAxEGMbv9lOGQEzEpn/Pr0oVnN6jjAPYi2TGjykCtSVnPNjehFM6ExA7oEJI9IEGqxezLAWG5k3376qWviyjv+3Fhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI0bO3k87SDCOucnO6DLZ6wg1fzQWehmR0xgME3yL3U=;
 b=vw7Xg39UzK/4G859UDSHZ6PwmbNAQBgZmubxMYhrjArVECrKvuSeew+Z4ZYJhQCmE/inVoyKbffLH8wPIOIa3JlappevFPygFe3bCX4C8Ox2+ONtvYfioHkbf/1YNhSX+3T80O14Tnn6+s5Mm5GfJVyBVkLMgRJi5l++9q5WgrU=
Received: from CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6)
 by MWHPR10MB1632.namprd10.prod.outlook.com (2603:10b6:301:8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 10:21:30 +0000
Received: from CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::758e:2fa4:e3a9:c736]) by CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::758e:2fa4:e3a9:c736%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 10:21:30 +0000
From:   Devesh Sharma <devesh.s.sharma@oracle.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
CC:     "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-core RESEND] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Thread-Topic: [PATCH rdma-core RESEND] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Thread-Index: AQHYBpJyCosYg0mqVk6OM5SGl6uQhKxdNPxwgABUFgCAABNwsA==
Date:   Tue, 11 Jan 2022 10:21:29 +0000
Message-ID: <CO6PR10MB5635A2B575EB279CB07330F2DD519@CO6PR10MB5635.namprd10.prod.outlook.com>
References: <20220111022404.2375531-1-yangx.jy@fujitsu.com>
 <CO6PR10MB56356364CD8AA266B4ADC2E1DD519@CO6PR10MB5635.namprd10.prod.outlook.com>
 <61DD4990.7060908@fujitsu.com>
In-Reply-To: <61DD4990.7060908@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eda55020-3c5c-4349-676c-08d9d4ec2228
x-ms-traffictypediagnostic: MWHPR10MB1632:EE_
x-microsoft-antispam-prvs: <MWHPR10MB1632E775C36BE75F07EE7683DD519@MWHPR10MB1632.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:337;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: umzGi3vyNsNq1kYsXPGMU62XerMaFeabYKrcPxsM+VelyvmjIT+H3OcVlS9xlLTNigbYYbjmtPDoQszAdmlFn8jFSeEpqsVt4kDt2ptyOaSZoK59EjrpBpGF7XRptiUXp2U6wvWSe/DN9vlV2VyiAT4wXuQ8NsDT+un11UmkvvU/Byh+1yK+nuomWrUNEEk0FIBOEOENzl2FHcHpPjnlItW+fBOjSbwz8sP8NbNmAOqdKYwU8bmSaVDEoSqm8biviAviXuJLVPtkxkwi4Htu0GZAMFZxU1qjFmJ3Z8Sb2tTpQfoGpRYH9botliUHJpWFhRn2UFxrwYOwihR+nr1z5yUiunajCI7fCCSmANtaveN4SFf5Xi8eudhd24fOunt/X5tSdOR8Fp7nTrIpjJ2PuxdQJa3GxnKyYtxszQb+6ya6aegR1FJoU0vGFct7DhWoPGVyxUlXubTEW+dFGtuOyxOFWiEd8T/Ku/qBb16T6JrGdw3HVkfwfVgMWJqX6+TqV4S9zPZspfjCxpNJl1WWT7QOTO/kCoXW4A/0f+usmbs3bO5feO65VcSYNsanrZDMG8fqk+83ttGBAZWavubStyFHyJxjPV+R8yifnZcU3cSZVBUdgrP1KOZRn/vunHS8eqoBEcuImLKNhrDMO7jG13XRJCWQNmGPCU4/3Cs7AoKyhZgR4END5hUoxms4jLWD4Rbc99Z7Z/cFHw09yrqm6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5635.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(54906003)(316002)(508600001)(122000001)(76116006)(9686003)(4326008)(55016003)(33656002)(86362001)(83380400001)(38070700005)(52536014)(5660300002)(6916009)(8676002)(7696005)(6506007)(53546011)(55236004)(66556008)(66476007)(186003)(64756008)(2906002)(38100700002)(8936002)(66446008)(71200400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/aqUCOB6GoBvgej4XH/q+aPLGvoAi9BS2jXJXFI3Ip1AraEK8nsw9+5vyxHC?=
 =?us-ascii?Q?gRjtkWJhgAxlwEBm23wIRFX0d65r5wgAp9OzFbeXOt0paHK/2Yz0Zuk/psMD?=
 =?us-ascii?Q?fpcj/RjJ4J35sJBKywpJbIm8DftJWI9F2kowfiqpXIL0pVvVBkCAiaUcNtDU?=
 =?us-ascii?Q?sbctQT64wREV7zkELKIqI8o7uwsxra3BHqDMy2JTJ9EDVDE5gJvZ29vIQX6I?=
 =?us-ascii?Q?H6orqN3e8WmyCamWkAd8I6JBkVHf2UxfP1v/bPrTJH8ryqpmLp+oxcA8mL5s?=
 =?us-ascii?Q?S/elUszaUyLmHl3I7ONSrq2EI4VZ1n2nN31TveccmH0h7m6Jtzyi9OMgX+41?=
 =?us-ascii?Q?duIpMvg5aNHlrqBhNTRbNZU/j2ascybcZbM5kInZLLTtPEDHyda1j9eWLHIQ?=
 =?us-ascii?Q?Snve/ADLzSV7zMh/kXIATV3r5eVEVTa5KDdZs1lXQj1KTMejTVtt4Z2UY0G/?=
 =?us-ascii?Q?ir24gVml3HKQT5wfPebeqWrPEIRdqf0ZWdEBTIsSAbDrY5n8igCBB80DhDc8?=
 =?us-ascii?Q?mxSA18xGnwsIdHIK+s1+uZABV62h9/wYoX1kehOJlg46VEO1d4K6MaDCCeZq?=
 =?us-ascii?Q?Z/gOUJQlZ/yphXoIOK6l9HuHeuQosRqZPaPsEpvBfJ1AhdA4b5kphOb+kfNH?=
 =?us-ascii?Q?2qYSbDWVhYgZkBNQbkIhFtVkSD67O1k7KU9iH6aNMXbhm4sOBvNVMrp+TtRB?=
 =?us-ascii?Q?2vJjIue4z9KlciR06dUGpfWQyhvFQYiXb1LzJWhpsHaby5vY7/w7Dogb9PN3?=
 =?us-ascii?Q?IbBIPM2fQRPYT7DOzOs9at6vmqkbNisN7XJQUTe3FN2cvZgubr0g0jRijudi?=
 =?us-ascii?Q?8m1spQxxVBIbZ1JvRmXlkOVnn0IwVFpgpS6qyUTy6GMKa+m97Ge62r1RVk8s?=
 =?us-ascii?Q?vzJactaX6e5FFjQJbjg6qGea3bhzkk8V1DN7Pw8ZOqjZMninmXKA0CDaa37I?=
 =?us-ascii?Q?3s5b8emJHUV3e8wWh3NdGdZSomp63IH3qgxEx369UtVnhm8FQsdQUOGcmdyH?=
 =?us-ascii?Q?Qv78CiKIwMyNm57OK33YpjSygDuNUMEKPf9tmnjOF+YvIhpKaT4ZwNbSEn50?=
 =?us-ascii?Q?/aLQ6vUSD4H8sSjOy1VAEaS2ixHY36CQXUXoeFcA65OVyxYbKr3gIu9mgUwS?=
 =?us-ascii?Q?tPccZjBAqtIzIPVV0Xzn6VeTwKJQwrEi2WWT0MuP1Svz8HQIxsuIqUi9RI/A?=
 =?us-ascii?Q?55ndsG2HJoAMvKakiHa3u1vfrqI5pLrF2TT0o2PRonNDsS2zQUrZ2bDMJ9UV?=
 =?us-ascii?Q?T9/yRDyP57vr/PtLlSM3e/GE6cxD4kFik424xDdvyMvKUekFro+rNzJedut8?=
 =?us-ascii?Q?wzgGBbAizpDHVPDEOQvGPyXVrR78Y/VznAelGwWVwQTXvlDhJZVt9AfUtwTU?=
 =?us-ascii?Q?+Wt92QG90XrJMQGbL5IeN4WFVjtKL6G8vdV0jb8sW9sunzRVBJFzg5zXdoYb?=
 =?us-ascii?Q?+ZjZHbd7bIIb9GUsPmQKlrE8Y1WR0AcndFBWQ9hPwGS2hSov172eBXO9afwp?=
 =?us-ascii?Q?KJWm/fe9Ctfr28iXTtmQ2yyr+IJ6vOHVlnxWwmRTvqUjRLEhAfHXwgJSM9G1?=
 =?us-ascii?Q?YmWCuhe8TE4yqIKVTBZGsTFWAEwMOJN0IqCA/c/SnxVyEhG5k8chag2MDZOG?=
 =?us-ascii?Q?DCrVabHxI+JccxU7iJyGV5rk97oiLv4E7ZFNpGTpZDy1uA0Va0yf+iqUx8YW?=
 =?us-ascii?Q?0d6XKQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5635.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda55020-3c5c-4349-676c-08d9d4ec2228
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 10:21:29.9298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 64SytjrteA0d2CdnCQ+fy3SBhtrosMRThcJt9rGoJIL7fDYUBJrWrshFRK5lQ7eDH4AVouTsI/MawSNMlLUXQIw21xfreKlWoYi9mZrybhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1632
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110060
X-Proofpoint-ORIG-GUID: s0IB5zqlCaXF5c1q5EwFMX5PGqwi5ImH
X-Proofpoint-GUID: s0IB5zqlCaXF5c1q5EwFMX5PGqwi5ImH
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: yangx.jy@fujitsu.com <yangx.jy@fujitsu.com>
> Sent: Tuesday, January 11, 2022 2:41 PM
> To: Devesh Sharma <devesh.s.sharma@oracle.com>
> Cc: rpearsonhpe@gmail.com; leon@kernel.org; linux-rdma@vger.kernel.org
> Subject: [External] : Re: [PATCH rdma-core RESEND] providers/rxe: Replace
> '%' with '&' in check_qp_queue_full()
>=20
> On 2022/1/11 12:12, Devesh Sharma wrote:
> >
> >> -----Original Message-----
> >> From: Xiao Yang<yangx.jy@fujitsu.com>
> >> Sent: Tuesday, January 11, 2022 7:54 AM
> >> To: rpearsonhpe@gmail.com; leon@kernel.org
> >> Cc: linux-rdma@vger.kernel.org; Xiao Yang<yangx.jy@fujitsu.com>
> >> Subject: [PATCH rdma-core RESEND] providers/rxe: Replace '%' with '&'
> >> in
> >> check_qp_queue_full()
> >>
> >> The expression "cons =3D=3D ((qp->cur_index + 1) % q->index_mask)"
> >> mistakenly assumes the queue is full when the number of entires is
> >> equal to "maximum
> >> - 1"
> >> (maximum is correct).
> >>
> >> For example:
> >> If cons and qp->cur_index are 0 and q->index_mask is 1,
> >> check_qp_queue_full() reports ENOSPC.
> >>
> >> Fixes: 1a894ca10105 ("Providers/rxe: Implement ibv_create_qp_ex
> >> verb")
> >> Signed-off-by: Xiao Yang<yangx.jy@fujitsu.com>
> >> ---
> >>   providers/rxe/rxe_queue.h | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/providers/rxe/rxe_queue.h b/providers/rxe/rxe_queue.h
> >> index 6de8140c..708e76ac 100644
> >> --- a/providers/rxe/rxe_queue.h
> >> +++ b/providers/rxe/rxe_queue.h
> >> @@ -205,7 +205,7 @@ static inline int check_qp_queue_full(struct
> >> rxe_qp
> >> *qp)
> >>   	if (qp->err)
> >>   		goto err;
> >>
> >> -	if (cons =3D=3D ((qp->cur_index + 1) % q->index_mask))
> >> +	if (cons =3D=3D ((qp->cur_index + 1)&  q->index_mask))
> > Are you sure that index_mask would always be aligned with 2^X?
> Hi Deves,
>=20
> I think it is.  index_mask is alwasy set to 2^X -1 in kernel:

Cool looks good, other than comments from Leon.
Reviewed-By: Devesh Sharma <devesh.s.sharma@oracle.com>

> ----------------------------------------------------------------
> struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe, int *num_elem,
>                          unsigned int elem_size, enum queue_type type) {
>      ...
>      num_slots =3D *num_elem + 1;
>      num_slots =3D roundup_pow_of_two(num_slots);
>      q->index_mask =3D num_slots - 1;
>      ...
> }
> ----------------------------------------------------------------
>=20
> Best Regards,
> Xiao Yang
> >>   		qp->err =3D ENOSPC;
> >>   err:
> >>   	return qp->err;
> >> --
> >> 2.25.1
> >>
> >>
