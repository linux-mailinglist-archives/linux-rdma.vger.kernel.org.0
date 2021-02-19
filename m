Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A27A31FB6F
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Feb 2021 15:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhBSOzg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Feb 2021 09:55:36 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53566 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhBSOzf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Feb 2021 09:55:35 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JEsiFx050634;
        Fri, 19 Feb 2021 14:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=8XHacea5/eucD1IcGTN/l2kPhomAYv9cfRFki87qpjY=;
 b=Vij1pOT/OYcpIEoZb5VkiuoLj+fd1UsvUKOBZKSefwbkjwK7SbeCYlCCiOztlzidyDGI
 0DvkMPS5iAy8ye5QCxTFwrxzcyBB3kGdwN//XQv9dGBghYj3bIsQlPZRRQQxieRUVEkN
 JlytpuXbeKb1jTwxQXsEW5bEaoLEo4abee7SHASWn1Yt97Hp9g1chHaX11fDGYoHPpqs
 kzKLtrMrBnIDCP12P07GPUwZm/5mblHr4yYkmsxwVH2AciWaIOTiIz41FfTL2UJO6Ch8
 z8ahlLdpXjTeLMArna9rYhkeKLG1U95s+O2unDZY/t699oUGhifumOPxZ8Xv/+/J/1yw pQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36p7dnsnp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 14:54:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JEnnKQ186660;
        Fri, 19 Feb 2021 14:54:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 36prhvquvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 14:54:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXGTbZtpIY6FgaLxZhGmEKO2sKo7L1ah8dCOkuoHyeBOUabrO6aRgi48hYSOS9UmOQ76W2a5/Il3aCbrKebM5BzS9VdUQjznmPVVLnZxpa4Io55MANA15c+l9bldC7x7nzniAiJS7PbhCboxb0I5l1cTX/F3C06RY8UficLPC7mazmnCcR4P5Tgw7pFDYW1WyQStVSvf5xgiuA4XTGlyY1s57Jto+aPlrR5a0IgHiMIv6+xJeAe88aGQPQuPacBpnhoovcfAc63cHhO3b4sYuAbQaepYEgsAzcroJxT6VUzEsUXM9ubjeCUMLysin7rpbJZMvaXX/xWC6RnbkMIfcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XHacea5/eucD1IcGTN/l2kPhomAYv9cfRFki87qpjY=;
 b=aTrGeVZlaf/UcNFa3PPgnD42nS9qJGKe+TXlgTLL/iqoDqK6PPT0viGJqZdRKv5viuxcl7HPV8ftYKOYR79SC+79sqgKPnyvgQLOl8fgZ9GdeXexyuRuP8EEaPSBH2VcGbfr3CnDBOVh7c8xO5RD7eCBtj4LiGdR4tROqz5a/pEfuHsUjOkK+86Oh0JLMN/8xVgKpQwfxeT5BuC2NKo7CV+Se4TNExerrAhlGgfcv2rQjS+zHs7MEh1+Bpq+92NqZaXgTqPv8gS3x2gG4wvxmqH6jmIUg5bUI7mOtJdKzyRJDISLhz039s5hD/UvUcWIEViHehaVUnM1KSN6g4CCRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XHacea5/eucD1IcGTN/l2kPhomAYv9cfRFki87qpjY=;
 b=FYLzN+afyW/lfeUmH4hetFUgr9QgyV2uXT8pGex6CFKGOz1XiVVGWot73CJRS5LE4RoeMJuxhlRFv0xLh/032uNGjPmiKxmFkw1qyvze0Q92xsracqI4RYw0x6ZVT+7Y2m1klQDnwvtRpRCxa08hFY1aG0O7vOl6AjYN5zU7Y5o=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4162.namprd10.prod.outlook.com (2603:10b6:a03:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 19 Feb
 2021 14:54:44 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3846.043; Fri, 19 Feb 2021
 14:54:44 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
CC:     Tom Talpey <tom@talpey.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: Re: directing soft iWARP traffic through a secure tunnel
Thread-Topic: directing soft iWARP traffic through a secure tunnel
Thread-Index: AQHXBs8oc9gabRL9o0m1pbwsh/mUdg==
Date:   Fri, 19 Feb 2021 14:54:43 +0000
Message-ID: <287F954B-04DC-4EEA-B810-2BCFF9F8C15D@oracle.com>
References: <bf7a73c3-ba50-a836-8e01-87c4183f003e@talpey.com>
 <20210216180946.GV4718@ziepe.ca>
 <61EFD7EA-FA16-4AA1-B92F-0B0D4CC697AB@oracle.com>
 <OFA2194C43.CE483827-ON0025867E.004018CA-0025867E.004470FA@notes.na.collabserv.com>
 <OF3B04E71D.E72E1A4D-ON00258681.004164EA-00258681.00480051@notes.na.collabserv.com>
 <20210219135728.GD2643399@ziepe.ca>
 <OF54DF919C.5715D846-ON00258681.004F4160-00258681.00500D35@notes.na.collabserv.com>
In-Reply-To: <OF54DF919C.5715D846-ON00258681.004F4160-00258681.00500D35@notes.na.collabserv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: zurich.ibm.com; dkim=none (message not signed)
 header.d=none;zurich.ibm.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57ffb693-44a4-45ea-599b-08d8d4e64b24
x-ms-traffictypediagnostic: BY5PR10MB4162:
x-microsoft-antispam-prvs: <BY5PR10MB4162E96838FBE8DCDFA9166D93849@BY5PR10MB4162.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l3PzWQRT3ESKpppXoZmAnTQGus8MQ12QMwtJr0PZjguIcV01zMQ6n2rlAShyLr2WgRiPM7OcgUmb/Bqug74QQZVk/BZduApUA+ZBZiCblwU0w3mXAIz3Yot/tWcbwsGg7UFdnnEs20zE/45epOhuQdxoeP+VLDzsloywCBLImI6aD5hNWvuFrD84WvKpBkAuBVuuuu+Nj8DME4EB6NbT1PpuzvszG2A1aj3j13mI5HB1fm5qxQCSH5ApgQFdCvu12FLF1lyjcAuFQuMf4iDZojXvp+Au+m1rsBOmRcwToB/Lxbrv41LtRzYRShf3N/1sg3rSkpzHE2xBWFUn0Im95ePLVH5xJ/4o9UepliYB3aPOccB7rLA1vSPaYEXgYnjthuDMJok92JiyFohYpZtAR/wpxQgnWofI4MwKXnkAEhSZ1IdzweVNi3gkl7o9V0Npu9r8d5aEgJem4Gj/Fv0thrV+6SBJKCG+VEUUBbz25k53SIi4eJu/0HHArCsoYcvZhsH/r7k+sdkAloyLA7LhdGfugFQDUkpBLIdJSUQoS6lz0asZaz/6fwceOBIykX0pTvsmkXmZ00VWNbB6KcgTAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(396003)(376002)(39860400002)(66446008)(8936002)(33656002)(66556008)(26005)(44832011)(4326008)(478600001)(86362001)(6486002)(91956017)(2616005)(54906003)(6512007)(64756008)(36756003)(186003)(6506007)(66946007)(83380400001)(2906002)(8676002)(71200400001)(6916009)(66476007)(76116006)(5660300002)(316002)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ViBzmjd5eDezHx8s3tI0AkC8TCxUxOM3IIowdFVxeGEAOenJKJ1Gp1cS0U9x?=
 =?us-ascii?Q?vbwkoN2ZVlad1hgdK0s1K8ZLPrVHjPnjKFDGdRm++jcK7YNegAxATJp20UzB?=
 =?us-ascii?Q?DWp+gI7kbih6hpYV4T5LgZlSAISdfo6+lAPLC2Cpmi/gdwN+Di3sofYd+do3?=
 =?us-ascii?Q?ivL1Z4OwkCXKNrWhhw6e5Vs8PqZpHLuNgBKdlch+5kBhE/qOKuitphjzU8Ec?=
 =?us-ascii?Q?hrl65T2//d/50vEfppz21+woEjDL5HlChhjOll+JNkNgwXH8+f6HJ5rfsSq4?=
 =?us-ascii?Q?cDFz50YoM/mhsanRzvkOMTT9Fbctxz/nQF+Kjrf/dyxnbb2D3mOY/7i4yUkI?=
 =?us-ascii?Q?Tk5ax1rrxBfvKtH6/HGKezjoNVN168TLLdlAhiTA4EDHCOlWZ24g+QB3yUQr?=
 =?us-ascii?Q?A0PB5RsqICgKYta/1fwy1o5hhRlwmJb/pf1Sb2Oi7RQOQuEilkBiPTkc3QSO?=
 =?us-ascii?Q?39hI18jW/fFkLBRaE5b/pzCtumsedqoRnBGP+pnUzBBhjf087o3nQu4dpzEH?=
 =?us-ascii?Q?HpkoD/yEHkVtG5426X5ylr3UvT2BcFfbSbBlf7dU2AOqc0AVBbfsFEzi9uD4?=
 =?us-ascii?Q?VRmJFZ8wLPMR2QE6nkpzEfNjJhIpcBDL2PKkkKyLnBv3TkzVSzX897R1773g?=
 =?us-ascii?Q?TdUF+Vom/tXukBtgAS2ZkWcMWEgKVd7zN1Py56ya3NA5IP1ff6mzyOk1fIY6?=
 =?us-ascii?Q?/ABtrwy+FxDko107sqow/Lb5AV5eBLAenIdaItVsqTWN29meB/OR7RFegoJz?=
 =?us-ascii?Q?EGIRKYoMiHpKcOyv4R0lX+Lsij4jR+xzSZ/f8r71izw/LRjGfsJeza7LkDOo?=
 =?us-ascii?Q?1ET3D2TkBYCMwG5hfffcRz514uKQmCzEv34GhUz9XJd8nizPn+jXdLrYfBGX?=
 =?us-ascii?Q?4WIUvjis/4IV9X4CqCsBtZ1XM45LRoveLpUXEwckqvT8dUdNhoehxyDXtkk1?=
 =?us-ascii?Q?Ri2QA4O7DX3XBI3XjUdYpiKqbdgu032xY1pbO7nnsX2eWsPdeCp5MDV5XVsy?=
 =?us-ascii?Q?sB2uqBWbsp3OU47FrEg5HfqPPjapVbEiZYpS1/u1z+olwhKr1vFoc8d1rcxF?=
 =?us-ascii?Q?Ga6um6iw1j8gHC9ZM1//q6BDDUNmguZdLmynUwMaPf7lsY/E/htdUYjmckw0?=
 =?us-ascii?Q?eC+7vtYaf31h65zXnc1BflEWRGwV8TW8f799QH/BT6etBElNWJt6siGMyca2?=
 =?us-ascii?Q?B5MCc8lBM7UsLjCno6Kygb+bsa0Hd7ojnAvWa6WErrnZzy2sRTsWCdzROz7I?=
 =?us-ascii?Q?Gza8M/lFhztnEHn8MeCzkC9TvE3+IyvT2bqRy1ZWwUloO01vCKdWgfqlpuwV?=
 =?us-ascii?Q?6Oo+FPM3AE5k3WVhIxksGyeZ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B60475EF8E966B4AA28D60BBBEABAC7F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ffb693-44a4-45ea-599b-08d8d4e64b24
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2021 14:54:43.9860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uJ4Yke9o9TsNN+kgV/yEFq1Bny08ZliRv6WSO4aBV5O29EPZpj3l0/CI6d3okOkHqR28Qs/2krljIJ8vU9RH6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4162
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190120
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190121
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Feb 19, 2021, at 9:34 AM, Bernard Metzler <BMT@zurich.ibm.com> wrote:
>=20
> -----"Tom Talpey" <tom@talpey.com> wrote: -----
>=20
>> To: "Jason Gunthorpe" <jgg@ziepe.ca>, "Bernard Metzler"
>> <BMT@zurich.ibm.com>
>> From: "Tom Talpey" <tom@talpey.com>
>> Date: 02/19/2021 03:15PM
>> Cc: "Chuck Lever" <chuck.lever@oracle.com>, "linux-rdma"
>> <linux-rdma@vger.kernel.org>, "Benjamin Coddington"
>> <bcodding@redhat.com>
>> Subject: [EXTERNAL] Re: directing soft iWARP traffic through a secure
>> tunnel
>>=20
>> On 2/19/2021 8:57 AM, Jason Gunthorpe wrote:
>>> On Fri, Feb 19, 2021 at 01:06:26PM +0000, Bernard Metzler wrote:
>>>=20
>>>> Actually, all this GID and GUID and friends for iWARP
>>>> CM looks more like squeezing things into InfiniBand terms,
>>>> where we could just rely on plain ARP and IP
>>>> (ARP resolve interface, see if there is an RDMA device
>>>> bound to, done)... or do I miss something?
>>>=20
>>> I don't know how iWarp cM works very well, it would not be
>> surprising
>>> if the gid table code has gained general rocee behaviors that are
>> not
>>> applicable to iwarp modes.
>>=20
>> iWarp doesn't really need a CM, it is capable of peer-to-peer without
>> any need to assign connection and queuepair ID's. The CM
>> infrastructure
>> basically just implements a state machine to allow upper layers to
>> have
>> a consistent connection API.
>=20
> Well hardware iWarp need someone to organize taking away ports
> from kernel TCP which are bound to RNIC's.
>=20
>>=20
>> I'm with Bernard here, forcing iWarp to use CM is a fairly unnatural
>> act. Assigning a GID/GUID is unnecessary from a protocol perspective.
>>=20
>>=20
>>> With Steve gone I don't think there is really anyone left that even
>>> really knows how the iWarp stuff works??
>>>=20
>=20
> Cleaning up the iWarp path of it might be a complex undertaking.
> I don't think going down that path solves the issue soon enough
> for NFS/RDMA folks.

We have a temporary solution for the upcoming event. There will
be more such events in the future.


> But I will spend some time trying to wrap
> my head around it...
>=20
> Best,
> Bernard.

--
Chuck Lever



