Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3303B73F1
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 16:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhF2OMJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 10:12:09 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:18106 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229990AbhF2OMJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Jun 2021 10:12:09 -0400
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TE4GVE030868;
        Tue, 29 Jun 2021 14:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=f/jn4dmDhsCA+yOLdcDuIuSnO6KHOn3/T1fdXYqIsb0=;
 b=XS1DGhbQ0+FB9TLQ8oe0p3zAinyzb1fk0tgkf7OV4DbFQljOMo378ub6NM7BHTRs/EoP
 CTXKkCjj/CzHrZUSOxJ5oVUh9loHNiCETi0U+LSMk4dkYNpGHtz98v8aqnaEzuV/7oOZ
 EZr5NmrP3XYJLfbM7etBDkyabe+PqbMMTRdrCLS2qOz/tKFfrHGreVPsoDGQI4TXRsNp
 419JZuQGaKK7b6pRR1fgSAka13yYeWYF1kz+bpAdNYiWwIMshlCfkQGwP8d26DDeu0kq
 m6F+AqG34vCdeB1V+AAm4lwbTqKSWJhIZyPHFYeX3eebieo1ZxUJ4aY/H2gH0NaCrpMe YA== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 39fcnhmk27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 14:09:37 +0000
Received: from G1W8108.americas.hpqcorp.net (g1w8108.austin.hp.com [16.193.72.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id 5CF7591;
        Tue, 29 Jun 2021 14:09:36 +0000 (UTC)
Received: from G2W6309.americas.hpqcorp.net (2002:10c5:4033::10c5:4033) by
 G1W8108.americas.hpqcorp.net (2002:10c1:483c::10c1:483c) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Tue, 29 Jun 2021 14:09:36 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (15.241.52.10) by
 G2W6309.americas.hpqcorp.net (16.197.64.51) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18 via Frontend Transport; Tue, 29 Jun 2021 14:09:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/5md4qFPvW2sJZ4QBL6X3BjclHyhl/GebHQEE7zgGWC1b9PoXTHIDn3/ePY6QTD5dbvt3FGQsTm7b+2Cz89n/BxLG1ct+0dTSu/O1l7s4j9aYyEaW2zHrXemqEAyhccGJpcDkZyysgl1IGxbrt5BwIZwpGn0snlFSA1CWQ9aDdtFJs25fdD1SVswqN+C7u42a0UL7ka6Jzca7W+H8ArsZ4FkRy5JP6yNlYa20w/aBoUXVoS9rRNLII3c5ADX2mbpqVMGN/hBJMAPIWMCcDop1SZuwxlgydP2mjTf2eoSWqf2ejtQz9i+OT97KeoFSuWR0b1pCQtWEZ4eTaAFMYmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4d0aI9y4snMTHi4lUOV2TFUIy7XLxmVOwiK8yx9eNeY=;
 b=Rg8KhLTETgIJ57Risip7CeOeZUc30bnixf45dlaQdKe7Ixq0mQZVnRvixm8xBBvjC5QnxTQfNMMecvBdGNvq/wg3hNiAQ0NqAOV5G6RpKA4DMDcT8489uvfQ2XfczgZnDgguCtMHeB+UYAV8Rc+QOGqFPhjVhCcXh1LUdNMQ/3EF8iKPpLs+KiaPXH1JHskZrOHnqBEMxMTlSUPdcI/o0rHNWZsaVf7e3hG8dB0MEn2OZck0IV55hGAwU6mRApWNckeokAu6XrzmRHqHo/uqARQbbLKxrZszwr9Z1f0z+8imfaMl1UsWN22PWHP6iEDf+5ihfLqozmi+GsPV+tnLkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7512::16) by CS1PR8401MB0950.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Tue, 29 Jun
 2021 14:09:34 +0000
Received: from CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::749e:3648:439f:526e]) by CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::749e:3648:439f:526e%4]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 14:09:34 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Gal Pressman <galpress@amazon.com>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 1/2] Update kernel headers
Thread-Topic: [PATCH 1/2] Update kernel headers
Thread-Index: AQHXbGm/Ege/0eZoYEyF0iheG7uDh6sqiXQAgAAGAYCAAHgeIA==
Date:   Tue, 29 Jun 2021 14:09:34 +0000
Message-ID: <CS1PR8401MB10963BCE6A5C3D4D6EF00D01BC029@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
References: <20210628220535.10020-1-rpearsonhpe@gmail.com>
 <45f33f25-d75e-5905-a2ce-bd62573a9a5e@amazon.com> <YNrEi8G/n6YCl81O@unreal>
In-Reply-To: <YNrEi8G/n6YCl81O@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [2603:8081:140c:1a00:fc0e:8725:ec90:262f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 791ae723-1e2f-4eb6-c19b-08d93b078601
x-ms-traffictypediagnostic: CS1PR8401MB0950:
x-microsoft-antispam-prvs: <CS1PR8401MB09508CE08435384336A147CEBC029@CS1PR8401MB0950.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:224;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GYA6b4/QDmVxmL/00CDAsPebr+KhhZ1QCQi+OH4GGHik9ayxGnH61DDKKk1Zm6TCc0528C5FVLyjvkHCR+o0yDMONZXBunqaO9W2In3DNx5CB7JhJd6wS3kcx42ZHVWUh1rhcwKw/jWqF8FHzHK9Hg8/bueAG+Nr7fOEzC8JbzHT8bY8WpdSj/xLsQf6QeSw4HY+g9p1qjewyiGkYbRGSzfMD61rRVNYedOcCYpYvH/ockVi+8JVXgBsdC40qNqTgbht0FvdTJlW4vJEN36uOZpXB1drSE7xfrEeXkN4FOGWquIXjj3TffO/cK38MGqrZHgC7ycWezB4lC+k7QtKNLDWzXH7lA/KAaPqboKICq08bCGeYsSkSLsls135mTEQRrlTyFRIM/TMSBzcednHeAFeuZNmE73gkgAelfN5ah5gvDjTCAi8AIz7rZOYJ2Yefu6nXcVD+OfBk8aZfMDlvwoZKlsE7t7CpS+/lCvzi0UkX9c5Nx8b+8eiVvfuJcr5CwzYOKGNFhPjBmFU+i4uVZeW3TiwsLVuHBMkD6bEPzOJFTgImCMOHsyV6sNPBVDM+S+pfxTp05M4e5EFgKFdJV15iG/C5PEnxk6xjsSUNdg7OsrnQJ3CyO77cvhg3ekfHQM7uT5pIEr8wQBMof+8TGRgK49J/N15MkHg+SEaZhPY5zjOfFN9x9BrfdSlQfqrq9oJN7jz7h8eSoDPvUpM0tpMRe8PU4MIcrbBJZHequGIFzRupggx4LCXo4KGBpgGeq8YZMD2h1X/c8m+jCACug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(366004)(396003)(376002)(86362001)(8676002)(52536014)(186003)(64756008)(83380400001)(38100700002)(4326008)(53546011)(55016002)(5660300002)(66446008)(9686003)(66946007)(66476007)(66556008)(76116006)(6506007)(15650500001)(8936002)(7696005)(966005)(33656002)(2906002)(71200400001)(54906003)(110136005)(478600001)(316002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i5322sRNPW01T9fi5SC/jHPuIsmEgF5yoLYg3EvbosuRt8X6C/WSZVE275D0?=
 =?us-ascii?Q?xWiRVG/qhEvypzuVVgfwN0QPB6krCRfUp7op7UmugR6Y6PA7MPh10R2E1Y3J?=
 =?us-ascii?Q?G+yUmSqcN1sLqqJePIDoetj8GwOJRf3Ok//rwjGmxlNW0WrPsDxjaCLxKGPk?=
 =?us-ascii?Q?1fwG6ZZybGlFOavdGfS4oQFZPVy9pVTiNJXAwcLiSKnxiXbKYiaQyWdhEev9?=
 =?us-ascii?Q?/OO3WD3UO/KX84lgMBZrqIY2IInLjLwsVKI8WRlzYn00KibnIrAufH+W8z0L?=
 =?us-ascii?Q?jjdxb3GWQAVSwyYGaM8vPImIVefonYj/1X/q41cQ21Bfvza/eSvSi2UT/QUM?=
 =?us-ascii?Q?/st+z4nXGSEpPxjBkHYJMpkE1cFOpQgDGC7KbHUyKi5M7yrjRqYSfx2/QCoU?=
 =?us-ascii?Q?Wkz1wjn4LhUjpcVnkVf2NvL9BYtkJAURySlvanHNzESenS20Txkf5EZdv877?=
 =?us-ascii?Q?mHQGMgIyRkXKV4Zyno93//3fV+NZyUVwzy2HU58+Gn7VpIRfZWkJbBjwmAO9?=
 =?us-ascii?Q?cV9WewsnonP6GkJosVPP174UBmZ7IOmTS2rzYlcuvN1YHlEgHCt5HXnwm3+v?=
 =?us-ascii?Q?lK8rLTzO1P24RpJufZdjfKyAd4SEs/11aUIGOBBFoj62mybwW4k85oT3okTQ?=
 =?us-ascii?Q?qaINlJq7pFcW9m2r7fY36fgQSNa6dWhrcXj4uF5Nt8f4oTK+Xuk4AEt3I9xy?=
 =?us-ascii?Q?GlF7qbbMootdQjpyWaudVHAXpO388jrUyKc2OSIjMjEIvQt0HZgKnam6kTKd?=
 =?us-ascii?Q?KzRU9oh86DP4qP5SitP1Y0z8lBinL6vs34+wAQvQQwITWJ5lxwuhH3adTnPw?=
 =?us-ascii?Q?8vXjRxIMIP+sXUiWWzAAj3doLPpY9GXFSa6fBfFTZ27LGHenSan+o+GhR7lW?=
 =?us-ascii?Q?ukZXUL3ZqtDy/r5bDnQHZmqGa3yOpw5Hvmq9KA+eKDQLZnyLPODpgFnEVEwm?=
 =?us-ascii?Q?+euoG20NmMppLhKAXIEo/+0cwwqfBSllnwfOg7wBlAb+Xs4CHBFXw9EsBjSa?=
 =?us-ascii?Q?dEqTU0vo4Zq7ZJ1ME+LAUUsPD9uG4Mywn7GtwHeOf9BknUg8fHqN1owz8ifu?=
 =?us-ascii?Q?fQFoyj+EYJqGz/Gw85Nh76tMAXVNN1oRmy7s6KoXf3rvYMm9o4sBaehdxipn?=
 =?us-ascii?Q?CdMbwikBCFr49J4S2ZXIhCbowXxonCHdZJfOuk1hJvCU7eRagpBO31uAwG+d?=
 =?us-ascii?Q?L407s06s7yNHKrkTEBHFu8kdJNkXDF1kdx4OcMIsW18vMg0ufvt1ck7ucxQq?=
 =?us-ascii?Q?49A+hJ0bdEZMw5di1rziypvdWqiyTxWJ56HKQOBWSLVthmWARMrggb809CDZ?=
 =?us-ascii?Q?WSFWSHZ1TiMYtMYGLNaCSbdqLmNjVBzlXpptyWbYPs7HSu3meXywMS1VfitG?=
 =?us-ascii?Q?N80TpbbqezTjpkF9hNaO3WVTeaoi?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 791ae723-1e2f-4eb6-c19b-08d93b078601
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 14:09:34.7758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kCl0xwCGdJNVVA5L0VFgE+nF90jBFx9B4T5qX234iwz0yMKz1lQag+jWWIdbAEw34BFBADp8CvvB/dtFnhlUkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0950
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: xN8I8HOKBgkksWZF_lHF8oP2hmO4Ujz-
X-Proofpoint-ORIG-GUID: xN8I8HOKBgkksWZF_lHF8oP2hmO4Ujz-
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_06:2021-06-28,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106290095
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



-----Original Message-----
From: Leon Romanovsky <leon@kernel.org>=20
Sent: Tuesday, June 29, 2021 1:58 AM
To: Gal Pressman <galpress@amazon.com>
Cc: Bob Pearson <rpearsonhpe@gmail.com>; jgg@nvidia.com; zyjzyj2000@gmail.c=
om; linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/2] Update kernel headers

On Tue, Jun 29, 2021 at 09:36:50AM +0300, Gal Pressman wrote:
> On 29/06/2021 1:05, Bob Pearson wrote:
> > To commit ?? ("RDMA/rxe: Convert kernel UD post send to use ah_num").
> >=20
> > Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> > ---
> >  kernel-headers/rdma/rdma_user_rxe.h | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/kernel-headers/rdma/rdma_user_rxe.h=20
> > b/kernel-headers/rdma/rdma_user_rxe.h
> > index e283c222..e544832e 100644
> > --- a/kernel-headers/rdma/rdma_user_rxe.h
> > +++ b/kernel-headers/rdma/rdma_user_rxe.h
> > @@ -98,6 +98,8 @@ struct rxe_send_wr {
> >  			__u32	remote_qpn;
> >  			__u32	remote_qkey;
> >  			__u16	pkey_index;
> > +			__u16	reserved;
> > +			__u32	ah_num;
> >  		} ud;
> >  		struct {
> >  			__aligned_u64	addr;
> > @@ -148,7 +150,12 @@ struct rxe_dma_info {
> >=20=20
> >  struct rxe_send_wqe {
> >  	struct rxe_send_wr	wr;
> > -	struct rxe_av		av;
> > +	union {
> > +		struct rxe_av av;
> > +		struct {
> > +			__u32		reserved[0];
> > +		} ex;
> > +	};
> >  	__u32			status;
> >  	__u32			state;
> >  	__aligned_u64		iova;
> > @@ -168,6 +175,11 @@ struct rxe_recv_wqe {
> >  	struct rxe_dma_info	dma;
> >  };
> >=20=20
> > +struct rxe_create_ah_resp {
> > +	__u32 ah_num;
> > +	__u32 reserved;
> > +};
> > +
> >  struct rxe_create_cq_resp {
> >  	struct mminfo mi;
> >  };
> >=20
>=20
> I think the second patch didn't make it to the list.

I don't know how Bob sends his patches, but it is here https://lore.kernel.=
org/linux-rdma/20210628220303.9938-1-rpearsonhpe@gmail.com

Thanks

There seems to be some confusion here. I will resend.
I use git send-email but I may have mistyped something.

Bob
