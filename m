Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDEA3CBAA0
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jul 2021 18:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhGPQlm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Jul 2021 12:41:42 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:13552 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229578AbhGPQlm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Jul 2021 12:41:42 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16GGYNft022754;
        Fri, 16 Jul 2021 16:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=Qr9tdSm1jpbHoGKWlwqidBjWBSbkFIuaiJgJNHKrN0s=;
 b=L3XXnyJyylJEXi+s1BSgtXzH2pmkGJOQ7GSnDBvNLQanl+NtJEGVaLuP5WgqxnbYBSrm
 izSx8IUzQmwwG11N5vk5k3ppno/9+P27QlFJgPQ1hjxZrMwSwGdwoTIa1Vo4n4kE62F5
 AvzE0e8X54MEzjKIkzzZML1SB9/3haxQUd/TI9zGJlP74HnlMr3MpuD104HJtg5UGwul
 TXYlPK2eNVy3ksRL7cxfi+QZQHZoyIXytLo1kVITgmzn4WCbCxaACRRVbqcRFOy/AsZB
 5w3DCLr16BM/dnBIsugvy3QKu1USy07rkM+LS5ijyix1rv8EKwtaDModNZIWTyG/SBNs Cg== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 39tw6c7tt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 16:38:44 +0000
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3426.houston.hpe.com (Postfix) with ESMTPS id EA97266;
        Fri, 16 Jul 2021 16:38:43 +0000 (UTC)
Received: from G4W9334.americas.hpqcorp.net (16.208.32.120) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Fri, 16 Jul 2021 16:38:30 +0000
Received: from G9W9210.americas.hpqcorp.net (2002:10dc:429b::10dc:429b) by
 G4W9334.americas.hpqcorp.net (2002:10d0:2078::10d0:2078) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Fri, 16 Jul 2021 16:38:29 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (15.241.52.12) by
 G9W9210.americas.hpqcorp.net (16.220.66.155) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18 via Frontend Transport; Fri, 16 Jul 2021 16:38:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+Uo5B8IFU14nMvFniOH5lZcp2WpwxMfZSzk0smVKDjnw9D4FqCGrS8dP3u0JXs2mjIrG186j5bhhxEEUDPfeyZyTkT0tfmd/rE+Sb01jllH7O/gg4/iEDBcHetxPQ/IEtfVqk5K7QTVry9jke+7QoWWLAcLo62U/gqFx4i6lCD0D1jW/Xr4jIoPQ6N6qfnp50olkbmm/Cudy3PiNICKoRTGgrcd0BIbH2Nn46PY96QapX03/pRAxPjzLiswIkGUoU98XVWyQ3zBXfNe7zxdUy9jLd3amGqV59H+rKn5lRD31U3ma6bk8ixhNnMWqCJS8xJHCuhOQfiSdIu0HoVfcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qr9tdSm1jpbHoGKWlwqidBjWBSbkFIuaiJgJNHKrN0s=;
 b=LJNkfoSP5H9pbb4dk/IQJP9kZd//v1BsuRaLQ8zoGhAQSRw2MxS5DTUBEebLKGjdPtWq9Yc5jealxE1+tML7KMQCkpq+VB026sJZNOPLTmZkYQqSU//faxykItX+oHqfxRcX4su/+I0X6hzrnXQ+jlADzbgAqfuqJM1ADHmOugdY0DlbFJ5qlusHy/OT0KzF06aQtyjHK3GJil082EVboBoWO5RP1X68Dmxirage/bn8BekllB08x2x2ezLpoHcjg01jUcJkgp9X+Me3C7p08GFD/z6XYWC1ffAtEvo+MIrTt0y7boIkZT4Vq6FACjHHLTfZa4KzpR2wAr26MgYOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7512::16) by CS1PR8401MB0583.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7509::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Fri, 16 Jul
 2021 16:38:28 +0000
Received: from CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::3c60:8157:8f9e:be3e]) by CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::3c60:8157:8f9e:be3e%10]) with mapi id 15.20.4308.027; Fri, 16 Jul
 2021 16:38:28 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v2 4/9] RDMA/rxe: Move ICRC generation to a subroutine
Thread-Topic: [PATCH v2 4/9] RDMA/rxe: Move ICRC generation to a subroutine
Thread-Index: AQHXcuTRAz2hSRh8xkCLdSKIULfNJKtF0OmAgAAC/gCAAAWxAIAAAi4Q
Date:   Fri, 16 Jul 2021 16:38:28 +0000
Message-ID: <CS1PR8401MB1096ECD020D2D7667F463D51BC119@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
References: <20210707040040.15434-1-rpearsonhpe@gmail.com>
 <20210707040040.15434-5-rpearsonhpe@gmail.com>
 <20210716155759.GB759856@nvidia.com>
 <6a07ad6e-5167-9d71-e22b-94efb9b64401@gmail.com>
 <20210716162904.GL543781@nvidia.com>
In-Reply-To: <20210716162904.GL543781@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=hpe.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f78fa7e7-9fef-441e-41fa-08d948782402
x-ms-traffictypediagnostic: CS1PR8401MB0583:
x-microsoft-antispam-prvs: <CS1PR8401MB05836DC42A07E285A62CB56EBC119@CS1PR8401MB0583.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FC/3MIshj7QJqWcmEaYzt7YgkZvxUkiWvAMOqWyL6jY78LUMMl8+Vm1ntBnKM48cEDPSQ4zb4Ap90jOJxe/O2W2wDXtAqxRI8+7hyiuY/ro4rltvPMLIycV45lQoe7mjQlH8MkG0qzuzE8od+7b2uOVmJ+StN+bPFjlzQ7h4u1KIr1jprjP+cqd+tOIoqtUQOP9hHNcXD1JCzlRL8uto6DUkjTLv96LvmoTPFCGU1m4Kiewq1b2cyS6S2oK/Jys9mNLoAqLKBDaBO7oSGLLkYTCDpLG1/mkuYCC/AXcFsyVdCPbH0GF8r9iTHlI/ACKY5uW9UR410FKroMmm3Ss82ejBEyvhqJvh1FbY7OqcHaOrDA+aCzDBxzbqGMaTbJ0dmwAtZ2cZimRE2PE14ZtU+JuLR7w4EfkSKQIFSgdHjKA4o5Kq+McVw4WPryoCWsjfarnQgdjdvdqmWQ6XCQob/QPuWzWyzPRPAK8zIA7vMRe6kED7D7eyAFaVzuBBWWgkayLFmT9o3+pYRIuG/qQdpvp2i3toKjd08hYRb60NBaV4B8XJ6SHqKj7vwAb5u2NmVSzOU9W+N7nAMJ2g6kJyuZH92J7WLk4ObKRXovvJ8e4+sQKk4cIuRdk+MvA1gFH+LKJ6wlaxSCG1TmgTcMjQBTMgxBYZcopZraccLaxRtttEhY0TqOFAHGarOC+L4nv2JkVvrSm0T2wSOHhcBhSXDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39860400002)(346002)(136003)(64756008)(478600001)(316002)(110136005)(71200400001)(86362001)(66556008)(186003)(54906003)(66446008)(66946007)(83380400001)(66476007)(76116006)(2906002)(4326008)(9686003)(5660300002)(6506007)(38100700002)(55016002)(122000001)(7696005)(53546011)(52536014)(33656002)(8936002)(8676002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n9XMaC0BnWoqhLDbusvPDWxQ3iaCsEZFHdOT7w4bXBb76XrCV0k166eTSipF?=
 =?us-ascii?Q?h+uz2HpzVtjiLC4+QM4NRs/bntJdIthov6MnlZPPlIMzqtjwrSyas+pp9HJV?=
 =?us-ascii?Q?l/BpZMAcl9W1uIdX/GzQcEa/9nd7pjzdWwYpATHm5j6kJ1aG/+vEpZfUq6Hq?=
 =?us-ascii?Q?wJJTVogCEDs2lfi+Zzz60JTqCHHaopuUDPBu1ke7nMX5We99ZevxecAokgvx?=
 =?us-ascii?Q?3JgKlK7IbU2VSK66T0ONXfg7F/3q/sw+fPNfQYoCjkZMs9c5caFcOcR87I7U?=
 =?us-ascii?Q?MQU6M3sjoTSutN7uGQe+3M6a/i6PLdQizq6MA0uSO61MvOZxx5JzLZIH31+1?=
 =?us-ascii?Q?V5bVIi2Ja3st4Gk9UPM92hVr//QD4sH/yLm0nY/SJ0psixPQ4FEii0bF79ff?=
 =?us-ascii?Q?PMAOVoyItgahlUuuQ4w5/Lt6hWL4+F+yjVDlQgekyKBiRa3oHfLPsrONACiO?=
 =?us-ascii?Q?uApiny2ePe8/AzVCYeQMrv6GiliPVIuZQXCGRWoRlZ5HGyr6UdZfx/+XTXiO?=
 =?us-ascii?Q?2bT//e8W+5pxi9DjLvk7DLGAwGLx50QZxGpUnNV4BEnLYU2BWjMZkmNyarte?=
 =?us-ascii?Q?M5TMZF9Le08zz9vb5NPmtj2TNuXpC+Z3N6nKnW7Gsn+sKLNkMEcdSB/TQNd8?=
 =?us-ascii?Q?7Gt9lyYS3HHltq6ev1z6nY8qXndRaU9mnmKJn0q5SweCjHvWMrYHdCJNmlfu?=
 =?us-ascii?Q?BUNECEN1akWuyU6np7i3Ctn2+S5H1VwknsgMNUBfVn40YgQc5sdTFAb3UBoX?=
 =?us-ascii?Q?rPC1/JsIEGg7KVsfXcuBskinc6o9iKn58kSdjXRizWAoDAp5EvfIfC5uhXVm?=
 =?us-ascii?Q?DzHtNyb6sUo8hC54qK/eXGttGi1zNA6NK+vkPExLfQIroZj2o0Xq6kAXVzjI?=
 =?us-ascii?Q?ayhuehT+LRl2dsHEMlG3MlIvblYVgWGnwr09NthgCLhfZI/VGQgiTWMPW8vm?=
 =?us-ascii?Q?5fCD8byO1KltoxeSRlQZQ1FZOwksyBfFwAFku0iAhFbaNfJ7ZFJ1lxMlDC3M?=
 =?us-ascii?Q?7PqYQ3kg8jbjMGHTuaCJd2sCfR006juxxina5dhKj4b1+DL3K7aPzyKReqQO?=
 =?us-ascii?Q?+WVZJnTo+nvW/qj0NTWwNGQbX28YB7tLgaNTlfVVtWhNshpMFoHM74QpzY0o?=
 =?us-ascii?Q?rZgJ/DFDgQiDcazCtwtK5zlfDkQrwDIg4fk/T9cVrNQh7xhveOlRD0lSeq5u?=
 =?us-ascii?Q?a0DR8NG8qMti8GYMriCwfSjUlBK+FuQj0bWRF7rcD0RheTUtRBUoM8QTKYpW?=
 =?us-ascii?Q?VTkHZAGdHwp6D6K7J/mSjGOn65bGm2MtGUef+/wu/IFXImQdeIRrj1gEb12a?=
 =?us-ascii?Q?d45wXYjQk9aqc7zavPokesoCmu/4DPIFJ4+OA7OuBpSArTVCg5IOheaNpjcU?=
 =?us-ascii?Q?z0GzsQYRXhVrWct/97vpys5+ZZqs?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f78fa7e7-9fef-441e-41fa-08d948782402
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 16:38:28.4250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CYRkt2O9lAzSb0N67+bA7M/KeQ9fXPLGvjDVYwz4G0Fr5NxnAIuEUvFfj9K0jWvasbX0p9Wz6owofkiKHdt16w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0583
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: QQInIYzBx2wx3HUrq3i2u1_8gjKIsePA
X-Proofpoint-GUID: QQInIYzBx2wx3HUrq3i2u1_8gjKIsePA
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-16_06:2021-07-16,2021-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107160101
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I know. If you look at <Linux>/lib/crc32.c, I'm the current author, but it =
is now replaced by the crypto engines.
It was a nightmare if I recall. -- Bob

-----Original Message-----
From: Jason Gunthorpe <jgg@nvidia.com>=20
Sent: Friday, July 16, 2021 11:29 AM
To: Bob Pearson <rpearsonhpe@gmail.com>
Cc: zyjzyj2000@gmail.com; linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 4/9] RDMA/rxe: Move ICRC generation to a subroutine

On Fri, Jul 16, 2021 at 11:08:42AM -0500, Bob Pearson wrote:
> On 7/16/21 10:57 AM, Jason Gunthorpe wrote:
> > On Tue, Jul 06, 2021 at 11:00:36PM -0500, Bob Pearson wrote:
> >=20
> >> +/* rxe_icrc_generate- compute ICRC for a packet. */ void=20
> >> +rxe_icrc_generate(struct sk_buff *skb, struct rxe_pkt_info *pkt) {
> >> +	__be32 *icrcp;
> >> +	u32 icrc;
> >> +
> >> +	icrcp =3D (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
> >> +	icrc =3D rxe_icrc_hdr(pkt, skb);
> >> +	icrc =3D rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
> >> +				payload_size(pkt) + bth_pad(pkt));
> >> +	*icrcp =3D (__force __be32)~icrc;
> >> +}
> >=20
> > Same comment here, the u32 icrc should be a  __be32 because that is=20
> > what rxe_crc32 returns, no force
> >=20
> > Jason
> >=20
>=20
> I agree. The last patch in the series tries to make sense of the byte ord=
er.
> Here I was trying to take baby steps and just move the code without chang=
ing anything.
> It makes the thing easier for Zhu to review because no logic changed just=
 where the code is.
> However as you point out it doesn't really make sense on the face of=20
> it. There isn't any really good resolution because both the hardware=20
> and software versions of the crc32 calculation are clearly labeled __le b=
ut they are stuffed into the ICRC which is clearly identified as __be.
> The problem is that it works i.e. interoperates with ConnectX. I would=20
> love a conversation with one of the IBA architects to resolve this.

CRC's are complicated. There are 2 ways to feed the bits into the LSFR (lef=
t or right) and at least 4 ways to represent the output.

Depending on how you design the LSFR and the algorithm you inherently get o=
ne of the combinations.

Since rxe is using crc_le, and works, it is somehow setup that the input bi=
ts are in the right order but the output is reversed. So

  cpu_to_be32(byteswap(crc_le()))

Looks like the right equation.

On LE two byteswaps cancel and you an get away with naked casting. On BE it=
 looks like a swap will be missing?

SHASH adds an additional cpu_to_le32() hidden inside the crypto code. That =
would make the expected sequence this:

  cpu_to_be32(byteswap(le32_to_cpu(cpu_to_le32(crc_le32())))

Now things look better. It is confusing because the bytes output by the SHA=
SH are called "LE", and for some versions of the crc32 they may be, however=
 for IBTA this memory is in what we'd call BE layout. So just casting the m=
emory image above to BE is always fine.

The above will generate 0 swaps on LE and 1 swap on BE, vs no swaps on BE f=
or the naked crc32_le() call.

Most likely this confusion is a defect in the design of the CRC that is bei=
ng papered over by swaps.

You'd have to get out a qemu running a be PPC/ARM to check it out properly,=
 but looks to me like the shash is working, the naked crc32_le is missing a=
 swap, and loading the initial non-zero/non-FF constants is missing a swap.

Jason
