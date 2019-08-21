Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6F5B9801C
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 18:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfHUQa1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 12:30:27 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:10840 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729228AbfHUQa0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 12:30:26 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7LGUF1e002689;
        Wed, 21 Aug 2019 09:30:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=wsHfNJP08P22MjXQSTXV4gl0taXfKJVeIqcy23rfHPs=;
 b=mPxXotSbEgkIxzh+xVAN0hMh+mh7IgW/GoY8RAG9QLhhjK3fH79cTuUAAnIPdyWQtCTC
 fIE/MtR8ilPQqEZMz/HIhsIIZeBOrxlkdo5Fgqdxu89z+olAj0bvyRp2D3TSHF9BskC8
 L2YTnpXy/IFyVAdLVKtTIrJ4UQONhreNayRAjN4/rahWG/3ZyDG/e60KJs/syWlIdW0S
 F64KHyVTR5W7VNdXRiYEZmbvOQJe0pE1iQ3O5XCXlFb38MYpLBIj3lafl6bzlhnJN3N3
 OFLTs4R+76fXEwiXFBjBY+pRMgAnjhiYllSwTP59OVECwhIMq9bhXtTyMmOhAdwNVAsl 9g== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2ugu7fk6y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 09:30:23 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 21 Aug
 2019 09:30:22 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.51) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 21 Aug 2019 09:30:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itaH2ZidNWx6Csjzbq3X0On+eVVV8fG4QSSoWIBFcEnd7zHAYXyq76bW4wVEPN34sKJSmIr6I+o0ZGL7lO0jzVIcy9SPvpuOu31urUzphuX+Pxkzn3/WVATE0Ld+YdCtasrcC4AIzemwp7DIEdglWofz6y8DSf2CD6L2qS5bam9IrB/Nt5PLw2eVvlN8T92Odr0U8DcT7b/tuMmuNk/huotaUTT9IRqpaf+rrvj8LGnEQGjYGiqQWB4/96FLjWIXIMeK3DJq/NF6F9m9y8J8dfJYmlwwKxIl+37Y9vRbi6uJ0wv8/EgimoTWdUJsXDuYqMdJXap0+3JCSQVLu+vTZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsHfNJP08P22MjXQSTXV4gl0taXfKJVeIqcy23rfHPs=;
 b=cGG5O0UMu9WMik1CsG+thYuxzy+eXdfdOc7F4MeoTWilU8X8R8V3I3MfDdE26smVNwzWT933NV05KOxiXpulWPleakeDMJPt9SvQIe7KdJPnHwWUK0SU8Bsv/DC0jfAo8EGUdDlY9GYQsyJ/vD8TEpNf7/qQ2lntUDrLAQCxQQH7x6oVCdpyYe/phBqWWo6k+mtBtqeZFQGbRJfQt8TVEUIoM0LF7ktZCs2em0Km3KH3s2qEtCCgdecybae3nIFUCtfmVd4TJuDSD2THznW737lXM4tBZKlsQ2REaftZ87jb0l1NKYtWDzzX0cfPgCYj6dcIk3QmPhi5NjRwdWoPRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsHfNJP08P22MjXQSTXV4gl0taXfKJVeIqcy23rfHPs=;
 b=tcBYlif1jdREDYNvhujTX02jjMwnAydTZ2k2Ss99TENDNKgY52/0azGCabMlPgsF9owOSx/XRseO8X/1ki7+x4063D6/9DquMbr6JxHeFqPv3z3Js5hiT321VSvaqJKjPhAlJBkrJlEILzR7MC7ztAZG4HH7MMKzU5tba/g6WlM=
Received: from CH2PR18MB3175.namprd18.prod.outlook.com (52.132.244.149) by
 CH2PR18MB3256.namprd18.prod.outlook.com (52.132.245.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 16:30:17 +0000
Received: from CH2PR18MB3175.namprd18.prod.outlook.com
 ([fe80::810a:1cbb:1b73:72d5]) by CH2PR18MB3175.namprd18.prod.outlook.com
 ([fe80::810a:1cbb:1b73:72d5%7]) with mapi id 15.20.2178.018; Wed, 21 Aug 2019
 16:30:17 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>
Subject: RE: [PATCH v7 rdma-next 1/7] RDMA/core: Move core content from
 ib_uverbs to ib_core
Thread-Topic: [PATCH v7 rdma-next 1/7] RDMA/core: Move core content from
 ib_uverbs to ib_core
Thread-Index: AQHVV1GwGCRn/XfymEKuSvdhB7Bdf6cD/yqAgACNMfCAAUAfYA==
Date:   Wed, 21 Aug 2019 16:30:17 +0000
Message-ID: <CH2PR18MB3175A5D4C1B980694CBFE308A1AA0@CH2PR18MB3175.namprd18.prod.outlook.com>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <20190820121847.25871-2-michal.kalderon@marvell.com>
 <20190820125803.GB29246@ziepe.ca>
 <MN2PR18MB3182CAADFAD352E8FD4A2169A1AB0@MN2PR18MB3182.namprd18.prod.outlook.com>
In-Reply-To: <MN2PR18MB3182CAADFAD352E8FD4A2169A1AB0@MN2PR18MB3182.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.203.130.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dd17ae2-0368-488e-4f4d-08d72654da5d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CH2PR18MB3256;
x-ms-traffictypediagnostic: CH2PR18MB3256:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR18MB3256D34011C9A6F17F563C33A1AA0@CH2PR18MB3256.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(199004)(189003)(6116002)(64756008)(76116006)(14454004)(66066001)(45080400002)(102836004)(6246003)(478600001)(81156014)(6916009)(8676002)(81166006)(53936002)(305945005)(3846002)(316002)(86362001)(476003)(5660300002)(4744005)(52536014)(66476007)(66556008)(66446008)(71200400001)(6506007)(54906003)(99286004)(446003)(2906002)(76176011)(8936002)(486006)(186003)(11346002)(26005)(74316002)(7736002)(9686003)(14444005)(107886003)(6436002)(25786009)(229853002)(55016002)(256004)(71190400001)(4326008)(33656002)(66946007)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR18MB3256;H:CH2PR18MB3175.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aJI/XIcoUCgTOds1+FolZosa95SfFxUAHsVDYr5NUKBQuCoHLtkmaMt0+qFpEzMd/BxRgN9YsuW28uhnFPumbSMeNUrhCQkjcfWyqyI3gijMWha8y8fbUQPN41sEXYS2wxiRmIcXAeyTMlJWKFmvTnHey1aerOo5f1HZwzxEPhK5QZU6sgpkZ84kGouidx4qS1XdNUK3HnInEDdKlqR3jtnw82O15YT5+O/iDNth1XsWdAVgdulNstuwc1bRRlNZKp9bF4xBW7stQBJk4JHlx+E8joSw6rp1WhLCogSderfRCa3RGIBsS9rOWbTBDSTfVWbQGiA8KYR2j+zWVopg51coL1z7WLIlMoJYg8ymFICOpVLswGsccgCd4wXGyoD/fXNUjU877tFNTqqLUYddCfZbhNBDt2i7tRPurh79KiM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd17ae2-0368-488e-4f4d-08d72654da5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 16:30:17.7831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w7I5ahPTVlPz6OCWgUemQ7ys5ahhxgCbM3oNrW3h7J9cM0dw4BTv0wHXFwO7Ay+AVQZlukmJ1ACAZ/DXsyrRjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3256
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-21_05:2019-08-19,2019-08-21 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Michal Kalderon
>=20
> > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
> >
> > On Tue, Aug 20, 2019 at 03:18:41PM +0300, Michal Kalderon wrote:
> > > Move functionality that is called by the driver, which is related to
> > > umap, to a new file that will be linked in ib_core.
> > > This is a first step in later enabling ib_uverbs to be optional.
> > > vm_ops is now initialized in ib_uverbs_mmap instead of priv_init to
> > > +
> > > +	mutex_lock(&ufile->umap_lock);
> > > +	list_add(&priv->list, &ufile->umaps);
> > > +	mutex_unlock(&ufile->umap_lock);
> > > +}
> > > +EXPORT_SYMBOL(rdma_umap_priv_init);
> >
> > Does rdma_umap_open need to set ops too, or does the VM initialize it
> > already?
> Will double check
Verified this, the vm initialize already sets it, there's no need to set it=
 again.=20

> >
> > Jason
