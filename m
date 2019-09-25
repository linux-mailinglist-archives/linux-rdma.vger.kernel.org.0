Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8883EBE579
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 21:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408507AbfIYTRC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 15:17:02 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:46546 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726136AbfIYTRC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Sep 2019 15:17:02 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8PJAU6R025467;
        Wed, 25 Sep 2019 12:16:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=+Hjolcidw9CHcwj4Q2pK6BHMg3yUGymlbfVrut28cWQ=;
 b=arfABYbbYd7dC4ZWvOMMamE0sJEKiHFsKbSR1YoT2M2HKjHWywhFKqssTE20QBOfksLr
 25PJNCINcZLjdKKyl6L6hGyf390Vx4xm3JpXtbOZKChrHo98tC0B3onZ1rhscLxSAAYL
 L0ExpYDst/s7cCcTNYsnxmXwlL9dHrZRnpbnwtGI8/ZOqdh9k3dxTfK5Tx4vhE3mXJG4
 cgmsega8ueIYrPaPw+J69OPbbWEUt/67WGW0wjZfl5N6gvn9f/V6RALs5mN6knmqj8zI
 ME+QO2GM3KPV5b6qeD+N8izs6IIG/5LdL75aFUtzd1eB2oQR7pDUNr/RhTMI+jT/58I3 OQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2v8e3601kj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 25 Sep 2019 12:16:46 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 25 Sep
 2019 12:16:27 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (104.47.41.55) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 25 Sep 2019 12:16:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9S7P2bGH2M7cDMnZIBydDuNqKnnqAW+pSV7FAGKQbslWUQTc1ZrxlTPTrUmlY0bGZJ8E+D0KwCU/cRyf4+z9EWLEGXFKwvsEZqeklCoh1v4kXdcLEgN8VC1rnBiiv0nftnDGu0Tz7Xfmtikst6swQN6c8oJTAwoKxlwxxVbpV6xuhKsW8z4zNUfhHgrFcJxhmxrQQsCFrVnbVdPasj4xxQCh59Vrf8AmYShBxqNrGu84jyiq9Of0gckFNynXZu6Lu3FV8PBxB/8nHc6/wfojRWpi2ZbXuhEtC3gfJafbEKKF/EmXI4zCtnWr/kO1ANtNRBqIyOXtZxm3cmu6Xoh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Hjolcidw9CHcwj4Q2pK6BHMg3yUGymlbfVrut28cWQ=;
 b=K2kWy16EvN/2FuggY+7E0trGuEdhrKrLqfRLSdVsY2Kpgoh8vt8FwKAe1Wznv0Dc18iDxNe0ALN+7SjyGbKx9mlpu5eq6oVuKjxrd9n0OUNMwaujZFIiy13p183ENpwCPrX+YvLsRgbTUjsf6nbK+UvnUk3Rx9W7but5VK9MMGaQp/ZNN+th6elBBLX5zFITo5FaciyG1tpklT4Fx5X5OY/hkX2AcajXsMXvh1E4qMXUP33iA8ri1dZFvpMKQnJZV2t6AerwWzc11N1fg5dDsJDU28u8B4x7HSxBz7lT8IvC38HJrigfEsE+yoEmMKw/EpT6qy5lujAis1CktRGazA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Hjolcidw9CHcwj4Q2pK6BHMg3yUGymlbfVrut28cWQ=;
 b=G4utyE2tyW9XnmpUHTe7lr4w129EVFENa4CPeJVDzJu8stOtf3v9VzOY403IHYg7xitLk6wfqn4CVuyQgQdYD6bRgluCb0J3DYtWCpr2WgUhleZdFR9w0FQg85C6UON9o+atcTo1b/6RpRYKhZkpqdr3G+arwRq+ZSTivRqu1WQ=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2574.namprd18.prod.outlook.com (20.179.80.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 25 Sep 2019 19:16:23 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8%7]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 19:16:23 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Gal Pressman <galpress@amazon.com>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v11 rdma-next 6/7] RDMA/qedr: Add doorbell
 overflow recovery support
Thread-Topic: [EXT] Re: [PATCH v11 rdma-next 6/7] RDMA/qedr: Add doorbell
 overflow recovery support
Thread-Index: AQHVb7eu6P3hyDpKHUmWhq7ahb1Rdqc0keGAgAg2/gA=
Date:   Wed, 25 Sep 2019 19:16:23 +0000
Message-ID: <MN2PR18MB3182FEF24664E620E357B83AA1870@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-7-michal.kalderon@marvell.com>
 <20190919180224.GE4132@ziepe.ca>
 <a0e19fb2-cd5c-4394-16d6-75ac856340b4@amazon.com>
 <20190920133817.GB7095@ziepe.ca>
In-Reply-To: <20190920133817.GB7095@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [109.66.1.192]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3284ac83-eff9-4a82-5f1c-08d741ecdafb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2574;
x-ms-traffictypediagnostic: MN2PR18MB2574:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2574C6660EC525EED6D7AEBBA1870@MN2PR18MB2574.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(99286004)(6116002)(8676002)(3846002)(305945005)(76116006)(74316002)(76176011)(2906002)(5660300002)(14454004)(54906003)(7736002)(316002)(52536014)(110136005)(71190400001)(7696005)(81156014)(81166006)(256004)(66946007)(71200400001)(66446008)(64756008)(66556008)(66476007)(446003)(102836004)(8936002)(11346002)(4326008)(186003)(86362001)(66066001)(6436002)(476003)(6506007)(55016002)(26005)(33656002)(9686003)(53546011)(229853002)(486006)(6246003)(478600001)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2574;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VqncgktMY03He3AJOEN1EiTukVO9kS6gkIgHGoP6blTKZN/jHBERTHHkUFJxzY+3cTAlJwwLqkUGix+LvZyFbo/K+wcY3R7/pVJfFX6TKiUBiYHqtiKXt/USF3sr0st6MF/oQRY8/YMBvHmBzDHFhcFX8lwUk46F/7mQ5TNqaKFe77EUFFRB6cUDV1hrsGZMROpESpYnr75oI+vquU8zSo2g+w+gRUB+wtiCBH8aZQpg7A64hYwpJeAVSnczSgyczGNafaVBiuspSjEpJOUvkqO8sSYe9P8mmtvAr02/tzLSJhklnXzw8gOQYC0NV2NmiQuWVORZevEdqPN/Qb2Fg/5MCAxj/SkxlHLyCCjbZ4+WpUXIFkSlaqZdRBBuXFKOz6WKtdsvAtCf2yABn4js23rHFvvsdS8TFTb9C35/8vE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3284ac83-eff9-4a82-5f1c-08d741ecdafb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 19:16:23.6319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AMxVbuSEMBU8Jav56CrtOkrMLsvvfkvEIomtzYzOACniYW74bjGqQLQS/rxupgLEkF5/HgLqzDT2ophXideAyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2574
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-25_08:2019-09-25,2019-09-25 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Friday, September 20, 2019 4:38 PM
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Fri, Sep 20, 2019 at 04:30:52PM +0300, Gal Pressman wrote:
> > On 19/09/2019 21:02, Jason Gunthorpe wrote:
> > > On Thu, Sep 05, 2019 at 01:01:16PM +0300, Michal Kalderon wrote:
> > >
> > >> @@ -347,6 +360,9 @@ void qedr_mmap_free(struct
> rdma_user_mmap_entry
> > >> *rdma_entry)  {
> > >>  	struct qedr_user_mmap_entry *entry =3D
> > >> get_qedr_mmap_entry(rdma_entry);
> > >>
> > >> +	if (entry->mmap_flag =3D=3D QEDR_USER_MMAP_PHYS_PAGE)
> > >> +		free_page((unsigned long)phys_to_virt(entry->address));
> > >> +
> > >
> > > While it isn't wrong it do it this way, we don't need this
> > > mmap_free() stuff for normal CPU pages. Those are refcounted and
> > > qedr can simply call free_page() during the teardown of the uobject
> > > that is using the this page. This is what other drivers already do.
> >
> > This is pretty much what EFA does as well.  When we allocate pages for
> > the user (CQ for example), we DMA map them and later on mmap them to
> > the user. We expect those pages to remain until the entry is freed,
> > how can we call free_page, who is holding a refcount on those except
> > for the driver?
>=20
> free_page is kind of a lie, it is more like put_page (see __free_pages). =
I think
> the difference is that it assumes the page came from alloc_page and skips
> some generic stuff when freeing it.
>=20
> When the driver does vm_insert_page the vma holds another refcount and
> the refcount does not go to zero until that page drops out of the vma (ie=
 at
> the same time mmap_free above is called).
>=20
> Then __put_page will do the free_unref_page(), etc.
>=20
> So for CPU pages it is fine to not use mmap_free so long as vm_insert_pag=
e
> is used
Jason, by adding the kref to the rdma_user_mmap_entry  we sort of disable t=
he=20
option of being sure the entry is removed from the mmap xarray when it is r=
emoved
by the driver (this will only decrease the refcnt).
If we call free_page during the uobject teardown, we can't be sure
the entry is removed from the mmap_xa, this could lead to us having an entr=
y in the mmap_xa
that points to an invalid page.=20

Perhaps we could define the entry as being ref-counted or not based on the =
type of address, but
the original design was to keep this information opaque to the rdma_user_mm=
ap_entry.=20
We can also assume that for CPU pages the flow that increases the refcnt wo=
n't be called
(mmap_io) but this feels like bad practice.=20

How should I handle this?
Thanks,

>=20
> Jason
