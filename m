Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18E23DAFB2
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 01:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhG2XIa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 19:08:30 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:50234 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229510AbhG2XIa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Jul 2021 19:08:30 -0400
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TN3O2d017246;
        Thu, 29 Jul 2021 23:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=vIvO2BdzazpSwGjHE71IxY1Mf/MtRq44mToz31dZTQ0=;
 b=e2Lc+5Dkcv0+jlyJcgzoB1qfjJHiIKDZTpZ6EXYrIlOHsKVscj5l4Fysfah2UExeBbr1
 UqK2bLBuzKLJuEc689uYcLVNV5dLPVY03nYj6qtxqqa3joTfeFsO+r1T76ugGnTowEPp
 62/eyRc2uCFh4AHghi1x6ADucbp3M2Ap3DpTbCj57ZczL+eXlikB5PBHCDcla9ogOIF5
 X7SkbZK1OArnk6NGZSLHjvA2z4ytR2YgGxWjeyi5FfquIoQz9k0ukMeroBskPGbM++VR
 RT06UK4KIQmA7WlCH4BtH2AYsUBsKcgmys1VW5eS9qwmrPuQ/opxW5qN+MbtNOxQX0+2 WA== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 3a3y8mb4kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 23:08:25 +0000
Received: from G9W8455.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.216.161.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id B74F532B;
        Thu, 29 Jul 2021 23:08:24 +0000 (UTC)
Received: from G9W8453.americas.hpqcorp.net (2002:10d8:a0d3::10d8:a0d3) by
 G9W8455.americas.hpqcorp.net (2002:10d8:a15e::10d8:a15e) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Thu, 29 Jul 2021 23:08:24 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (15.241.52.12) by
 G9W8453.americas.hpqcorp.net (16.216.160.211) with Microsoft SMTP Server
 (TLS) id 15.0.1497.18 via Frontend Transport; Thu, 29 Jul 2021 23:08:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJWplNFjg1WRmUke9HcJd1FlFjWiAcJwJs/TPFq1XflKZ9SBrczeCSfMyGmfqQrvtWpoU7qA9vciG6Z1CfiY7h+p5ojukjUiiPDyGW14ONgBdI0M2AhDP1oCE0QBLQHs9Rkg2Z8PCvsqm2QBgwRBEnFtL2AZDt23xz0XHdcqjnKqcVtNKs2SUEhDl7u9yxTp1cduTt7gZ3EMTkaZfwtifBfs5qku8skGoaAdY0zQfXD4PVUvsk2cgDsYpmU49puFtQ6sLg3qc0WLY7nVQYYd65gpkHcBELMZWqM6GFn/sS27Wf0CYa05aRES2G1DJw0fq91daZ0C3CnubeZxIBdPaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIvO2BdzazpSwGjHE71IxY1Mf/MtRq44mToz31dZTQ0=;
 b=LSRBgDwBLE6Nr5WBp5u9uG7pwOm7cHIOEUuTR+ntbSI8i+xsKyftDtHsK9MilclKuYROq26EDqUBFZlvgH3VDNoqrx0WIAVfgbNDnIARik82QtprdQNfcvZa3mMR5ynfMaus0jPQJ+YMD6x5lWyXwVb5w+JbCf/uKzf2cOH5HSbmrq0AOUTAKlLeetE2vn8dlY1Q5ZXmow+hbMSFxDkxD6U6eCnEOy1ZjLwagk6BEsiaUvvXEgpShIaxauxrTKB3UyJLw2y5gtXYKgM1ro7yIJjb/XwAKJEXp1bovkZcqMonbevntTRdmTE4axUEcnzisi6mnDbNEHjwVyUNWPU0nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DF4PR8401MB1081.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:760d::8) by DF4PR8401MB0409.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7608::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Thu, 29 Jul
 2021 23:08:23 +0000
Received: from DF4PR8401MB1081.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7564:d951:a760:59a6]) by DF4PR8401MB1081.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7564:d951:a760:59a6%12]) with mapi id 15.20.4373.022; Thu, 29 Jul
 2021 23:08:23 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Shoaib Rao <rao.shoaib@oracle.com>
CC:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
Thread-Topic: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
Thread-Index: AQHXfCiRQi0iyK/afU2lI65YdvMuDKtXDP2AgAAYBgCAAmx1AIAAAuUAgAAR+gCAAMJ9AIAABNcAgAA25jA=
Date:   Thu, 29 Jul 2021 23:08:23 +0000
Message-ID: <DF4PR8401MB1081385A8812159BA8E96A03BCEB9@DF4PR8401MB1081.NAMPRD84.PROD.OUTLOOK.COM>
References: <20210718225905.58728-1-Rao.Shoaib@oracle.com>
 <54817f70-e7e5-d145-badf-268ba7533110@oracle.com>
 <20210727174144.GE543798@ziepe.ca>
 <CAD=hENdOrfyq2buP269LQVhq+QkZ=hpA3jpbZH+CAFt=CGLV-w@mail.gmail.com>
 <6687ea04-c402-1b4e-dce0-386d29948ecc@oracle.com>
 <CAD=hENcTYfV1LT1=_e=eCNxdjr1Nmi+R3hH_CQn70MGRTKG7LA@mail.gmail.com>
 <eb24b781-396f-5bb9-89c7-3ca0f8b83849@oracle.com>
 <20210729195034.GF543798@ziepe.ca>
In-Reply-To: <20210729195034.GF543798@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=hpe.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 469dbce2-92ff-4469-f617-08d952e5c3bc
x-ms-traffictypediagnostic: DF4PR8401MB0409:
x-microsoft-antispam-prvs: <DF4PR8401MB040922C4A078F301460DD8FCBCEB9@DF4PR8401MB0409.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ddruPA/Wmt9pvKmHjJEhyKiVclqgSCU9beoX7oqyTyi033iE6QDqkAmqF+t2HdDSVlqlOUYS23R7IwHIP4igGjny5Vux/rKkzYKAop7+x+CCqhH0lTp0lDg+bQ9Zf5VILE55xVwsFck6/sfS2V0yDu+41FXjjWRAB5xQmN9gYrZZbj1+FI9eAkdoeZJOpQLu+7clK25eocfis2XraQYYeMqtci+Mot3SVAAkWdJHkNmTuB1T3cqrn9mZMVuLLtqGGNRADsgp2UM+d3GB+vGe6XHEam6/4X7BdX1W5SBRciCPifdiZk1XJGa35PLcHZgZaHi5e/gQT66Kd1k4frT55idKUV24fUg9SbQ8z+f3do3ZZwr8yQRPS+ctPtUrXg0U84ZvG6+Y2Nh2HadekGL/5B3Cxc7OldIs+1aY/5wdqikD295rHdVOylzm5nCASJmI9uwuyGudQfD9UB4LDoxkwt/E1XycYt9Z4DqqIFvz3qesMoQFYmtWykUTp43qUAf5idzAF/r7gM94wcJkQHhLSDl2nU46UwPqKGM0YEIscWafy4H+cqNUbBheJ1hZKDke4ix9aaZiEjPoKVe4M45Ucx+5DszoVytLxPAg2N2hydp4j9xhC9+nvxXXyDxMvPZNZ4Kk3bn2q3A87NWekdGMAOyNfczpffRXGo+t52kcRmHzM8Qkusgp6WJZDVyAplvvPqHipeFd7qQT/Z94A+nmMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DF4PR8401MB1081.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(366004)(396003)(376002)(86362001)(55236004)(53546011)(66446008)(66476007)(7696005)(478600001)(64756008)(26005)(66556008)(52536014)(71200400001)(186003)(83380400001)(122000001)(6506007)(4744005)(5660300002)(110136005)(66946007)(76116006)(55016002)(54906003)(2906002)(8676002)(316002)(38100700002)(38070700005)(33656002)(8936002)(9686003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0P15VwHxS08kHpk0sx4+qTxqFjk1XK48COPDi6uqBRJAbki9nX6W8tu+X1iH?=
 =?us-ascii?Q?4oxf1XFakerUvj5UiISjUtieFb6ZnmNROWGZ/N0g+tTf9O7kLY9O5fEBSxoh?=
 =?us-ascii?Q?lgCtgxvyiFhf3sjOqfg6Wg5vrIGiieVoXIKQ1aJhIEL2vWuSXAsLngtdunJ+?=
 =?us-ascii?Q?r9R9xMo2vMbUh3Y93Yuc6ITBWKg924VigpkFeYbXBaRJduaeoDhWi8T0HAnX?=
 =?us-ascii?Q?W9GoyS1WrVPe+SQB0AM6UHZJAlZ9VzCPUAO57W+bwfgR3SZAO75WOMLLsDBY?=
 =?us-ascii?Q?wDyV9Z96r5sc/mmpSRY7MiPL0EX1jxDRlvuFaUmns/8FcqjvkB3mwsg38k6H?=
 =?us-ascii?Q?Bigze75kwcTc9Y9p4j1z43MuJ3zeVVbuISJHFzgb2V/SZsTB+cXtvhvYJ6Zg?=
 =?us-ascii?Q?77Tpzch2ofbOyzxRHUM5pB0ItkGw8+0EdqLLKSF384LygyGAbrDNivBdfu+y?=
 =?us-ascii?Q?NaFpHc2poIq+x6BO/QuhM7d93weFO3ANsinRflehdAUlt1Rw8NEygBXKI1R8?=
 =?us-ascii?Q?Y43t4GYNixUSY+ugdv2jWGPo/Xge7xREarKds3oUn6+3nf2yCEMHsmScM2eb?=
 =?us-ascii?Q?9QOSMA1/7wkOZI//cF66obb/vO5YpdwCEQoO4uliOFepjo0nIBBp/Ztp4gat?=
 =?us-ascii?Q?S0SrvoQb358XmPYuUw7KjqB4Wjt5cG5/S99wumvaBL7Yn9x1xP3l4sYBwabK?=
 =?us-ascii?Q?aF1FHjRB//ZGYxIoueBk2oCvinb6dX39l5aU1SFmiOsxw8rfibL5fin4RNDl?=
 =?us-ascii?Q?veswdhrjMzX34ScqL/CDQguHm6g4dthzc0WWrc8PS0xmALMgNNB2TgI1Vezd?=
 =?us-ascii?Q?ibN5oqdB2lOpk6M8A+0Yu5cx7LPYVW8asDnHjjDu3G8g4bTTSK7x/Z+DplXB?=
 =?us-ascii?Q?6uD/PKFF5SYNxtlOEBlf4Kh+3Cs055/cKcGp1GxzfQ05zIbNqqj5obKzqKGe?=
 =?us-ascii?Q?NluoMYrbJQ743TKFP7sRYBziYsyqF/2Cbqm35Zb2DHWYUh/Nuc+fHf8X4TJv?=
 =?us-ascii?Q?G+CtYFnJW56hrhe3Xop6zaIL+3kHXkJpMzr8enrPlksIGsIT1OtzZkSOlmwl?=
 =?us-ascii?Q?T8JlBzMukYFHRuF4oILBxBD/H3nPI4W/OOho6yLyYUhm0MI/nOuLWy1TQ+Vt?=
 =?us-ascii?Q?XpZqqTJF/f2mdHgZ4x62okQktPExllTaY1Pq6V7C11l3ZkA/NcVWGAiQcxHz?=
 =?us-ascii?Q?bu8W5ZSuoLVbh/wdJZzTpZ3Wh3CSvUYh9EnYIg9QhunHMtANIUug+00nqG0o?=
 =?us-ascii?Q?ckbp3ngS1l7dqpz91fVAnC83oJsPxk/2FDLPEo0+lVpr+0NrwVGppLYKBC8L?=
 =?us-ascii?Q?JtL5DtUT98+38t9Nqo7t9XxI?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DF4PR8401MB1081.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 469dbce2-92ff-4469-f617-08d952e5c3bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2021 23:08:23.3165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MaQUn7iM2tpDoQB1/Fgg8ier2lpAx826FBWooZpSe2UgfS0qmgWuZEd2pqIQCIDNpf+fMOhzp2NfeiMNVls5gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB0409
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: gMDR4Z5ESkVOwWYnXviPOM7NYmWwxCm7
X-Proofpoint-GUID: gMDR4Z5ESkVOwWYnXviPOM7NYmWwxCm7
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_17:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2107290140
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I found another rxe bug (for SRQ) and sent three bug fixes in a set includi=
ng the one you mention. They should all be applied.

-----Original Message-----
From: Jason Gunthorpe <jgg@ziepe.ca>=20
Sent: Thursday, July 29, 2021 2:51 PM
To: Shoaib Rao <rao.shoaib@oracle.com>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>; RDMA mailing list <linux-rdma@vger.k=
ernel.org>
Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used v=
ia uverbs

On Thu, Jul 29, 2021 at 12:33:14PM -0700, Shoaib Rao wrote:

> Can we please accept my initial patch where I bumped up the values of=20
> a few parameters. We have extensively tested with those values. I will=20
> try to resolve CRC errors and panic and make changes to other tuneables l=
ater?

I think Bob posted something for the icrc issues already

Please try to work in a sane fashion, rxe shouldn't be left broken with so =
many people apparently interested in it??

Jason
