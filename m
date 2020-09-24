Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FB3276ACA
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Sep 2020 09:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgIXHbz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Sep 2020 03:31:55 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7048 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbgIXHbz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Sep 2020 03:31:55 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6c4b5d0000>; Thu, 24 Sep 2020 00:31:41 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Sep
 2020 07:31:32 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 24 Sep 2020 07:31:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeYwHe2ssk0+4rK0EL3aqWKlUfG7yzuZIUUaKYbFccajK+Dg/QCNa63jFjVyHWmsQVZQ2HNJrth6jh3uDZUheTfap+LATs11maUy4jSrSK2t0DyXi0e1WvrcTgmB+d4REy38oam5/OOKXGqh0/44CRaWYasi66xnUJHamtDRLj2FlP0X9Qo/3o+vVz82NlWqw4EQJTxcKDvsylmwxlZ1fbKCOaz211t7Pi0TSlYk6+N9W8NntI35YjJseuIPj2LlLqKACcd5Fe9C2jMDcNPTeYGgMPpF18loDCj9XBEdMIVepqrIxa4fQcOJY3uzvgzer64VTYj9EM0500LEv1wi4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUQgagQDVLVuGTCySlFoyi/TnhvSBeHNqYIMWDEiP+4=;
 b=li5YHJjMAG+ecIPh4J9ar85njpcpKi2FcCiojdF+KIiczdz04rOPe8cn8eXGM6mXi3d/bNeOsvKeXFAikNSCyBZiviYpe5q1N9Y7BzJF3Pyj8lUCg/2zWq3YMn6SNPimEmnA89z5RreZDAgS07yt4CUaS9KY1OdRSt9eUh+SVzCqnJLS8icwaVTHnkBGtQlE62iBNO35WMNR7Q6P/5eFhEWyXuSBmmmkSoPRwD762NxmI/H534MNQsR4iyFk2c3hnLPT/olUj67srwAK7LQcDCdLWhMoadCO5gIZnOdm2Pll/ZRgBh8Vgy0jLWz56lrDmer59MO7fAqK9cdtoufLGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 07:31:31 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105%6]) with mapi id 15.20.3412.022; Thu, 24 Sep 2020
 07:31:31 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Bernard Metzler <BMT@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        "Ariel Elior" <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        "Gal Pressman" <galpress@amazon.com>,
        Lijun Ou <oulijun@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        "Potnuri Bharat Teja" <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Yanjun Zhu <yanjunz@nvidia.com>
Subject: RE: [PATCH rdma-next] RDMA: Explicitly pass in the dma_device to
 ib_register_device
Thread-Topic: [PATCH rdma-next] RDMA: Explicitly pass in the dma_device to
 ib_register_device
Thread-Index: AQHWkLpHuI8sffLeIkGhgIqH2a/BE6l0W4QAgAAVV4CAAEUpgIAAIY0AgADe6ICAANjSAIAAvWGAgAAWZKA=
Date:   Thu, 24 Sep 2020 07:31:30 +0000
Message-ID: <BY5PR12MB43229FBAEEFF759074459DF9DC390@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20200922101429.GF1223944@unreal>
 <20200922082745.2149973-1-leon@kernel.org>
 <OFA7334E75.E0306A27-ON002585EB.003059A0-002585EB.0031440E@notes.na.collabserv.com>
 <OFE5279622.4F47648E-ON002585EB.004EEBC0-002585EB.004EEBDA@notes.na.collabserv.com>
 <20200922162206.GD3699@nvidia.com> <20200923053955.GB4809@infradead.org>
 <20200923183556.GB9475@nvidia.com> <20200924055345.GB22045@infradead.org>
In-Reply-To: <20200924055345.GB22045@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [49.207.209.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62b21588-b7e8-480a-36c9-08d8605bdb50
x-ms-traffictypediagnostic: BY5PR12MB4066:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4066FC4BCF3435649C5E732ADC390@BY5PR12MB4066.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tnYN60kj+M3d+oYeD4NXEIj40FJbb94doeY372Kh7dKWz+ZZiBxv63RTGZa79Y3TR/vvwnL35iFyMatHT7Z+ZD6MYJuCJvxfJegfeWxBozerbBqImyV8oejV1XIPFpGQhfAcUWAL/QaSC/TD9lRapsYq5UHsLKmxMPJP4xZ5wTr0byN3pSO6x4kC2c+fZS6qpkFjjZcrAC2kGpcRtgJpBtHv/6OI7Qo9jplM+dmsixPgJl+YEzw3/uA5klFVOFvC1Mfj4YhB7VtQdNMhRAfveLoJQRrqvYfzhIkci4Yg7RCV5weccQrf9PzL733FGT7bTxSutPxCZtxdJcFP+LyK1B3uAs3A1gMu8bA9uOMbsMPoAq+HvZp6a5Emr+1ON1QL5zHjItmgYB36WywTK3rm7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4322.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(52536014)(76116006)(478600001)(186003)(26005)(966005)(66476007)(107886003)(64756008)(8936002)(66946007)(66556008)(2906002)(6636002)(66446008)(55016002)(4326008)(55236004)(71200400001)(6506007)(8676002)(9686003)(83380400001)(7696005)(86362001)(54906003)(110136005)(7416002)(316002)(5660300002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 0umQ0oE9bmS9ZuOdnzAvexeugXe1IYsKjW6eIIof89U2YOBWONB17CJbN0lX/eMbDmH97XMIyC02GwR/uce0+/RfqubYG1usy/Gvpn7zDsn8CRRVvw+zFAI6uIckBAKjESoA/pwOxAt/MxA6oqzy52eu85crwRXG/XFwj+ThS92fvZLzNQBD12e8hdeCb0gLqC7mtc9Hs/2ueh1gqs3bPgPb5fr9R9HzgFMFwkX1aLYUmk50uotsIoMAgERxIV60feIclWOJ93ZY3CwkODm+CzRYsLtXrZOS2Hot8eG/3YZ+1IRtCyhTtNQPnzPfZix1gk447eU2r51xSWq3XHWYk1Jkyf4jspGXBke0cdZnwvUix4rN6A3I2Kez5QH/LdqjUnT/0oF04+XBMabccO63cubSpiXBo9PXz8VcHJjCDdjmiXsE2EAvt1LG9ZZx8CfS1ZHEWJs8mpRuMVlEZGiKTkQj22B6pOS9uD2x4TXK0nxivxbnMbDmU3ObEoLjWBUsHQlKfA7gLPPNR+C8qCy1wEXRkTr3MTO0A85OCt5Hx4/tpq0NW12Mcrp8BmmazVBdQYwPeqR/JBCLTQytnF/fOkn93QCYVyE/z5ca0iE5rMBVwepA4frqUq0+asuT/Jw43Sgs6TiDQ/gFX1IiVskK3Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b21588-b7e8-480a-36c9-08d8605bdb50
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 07:31:30.4987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t1ws6W/YL1eMTYPL95yMd0ByanfW7EdXOXP43A2MfHrDl5SlCEKNJurXgKOH+V+OiKq9TS7G2IcfbmX2JGrJzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600932701; bh=KUQgagQDVLVuGTCySlFoyi/TnhvSBeHNqYIMWDEiP+4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
         In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-forefront-antispam-report:
         x-ms-exchange-antispam-messagedata:Content-Type:
         Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=QYzgy1Jjmphmi39I9gKShlEG21D3urBb5tcT16yiXbm9IBtkQyUS5G/nt7gW8Tsj9
         IEDLtkSb6LUTNem8SvTRcmYB9zELXRVpSOl6DotrhqnuZ5k3XNIN6Yawp/nKzv+Jgc
         Su7wizhrLE/aWBl0HgJc3YUwGh+gzChZtWi1KN801Ij1OefTA1IjqzSDj20NOzt8JD
         hmqZeigjG7INSTFyFGDrHP3pVtz2O8cvb/jLhjiujTtFTyc4nWCwyOLb8FW1H579V4
         78Q7EgcVjmuKRWloBt1kIKR/Iqw9zxWEKhQ5F4vVfcepWAoLW+JMKBI8xgyaxpL8Gu
         LU5XNs2/mraHQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Christoph,

> From: Christoph Hellwig <hch@infradead.org>
> Sent: Thursday, September 24, 2020 11:24 AM
>=20
> On Wed, Sep 23, 2020 at 03:35:56PM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 23, 2020 at 06:39:55AM +0100, Christoph Hellwig wrote:
> > > > I wonder if dma_virt_ops ignores the masking.. Still seems best to
> > > > set it consistently when using dma_virt_ops.
> > >
> > > dma_virt_ops doesn't look at the mask.  But in retrospective
> > > dma_virt_ops has been a really bad idea.  I'd much rather move the
> > > handling of non-physical devices back into the RDMA core in the long
> > > run.
> >
> > Doesn't that mean we need to put all the ugly IB DMA ops wrappers back
> > though?
>=20
> All the wrappers still exists, and as far a I can tell are used by the co=
re and
> ULPs properly.
>=20
> > Why was dma_virt_ops such a bad idea?
>=20
> Because it isn't DMA, and not we need crappy workarounds like the one in
> the PCIe P2P code.  It also enforces the same size for dma_addr_t and a
> pointer, which is not true in various cases.  More importantly it forces =
a very
> strange design in the IB APIs (actually it seems the other way around - t=
he
> weird IB Verbs APIs forced this decision, but it cements it in).  For exa=
mple
> most modern Mellanox cards can include immediate data in the command
> capsule (sorry NVMe terms, I'm pretty sure you guys use something else)
> that is just copied into the BAR using MMIO.  But the IB API design still=
 forces
> the ULP to dma map it, which is idiotic.

For 64 B nvme command & for 16 nvme cqe, IB_SEND_INLINE flag can be used wh=
ile posting send WR.
Here the data is inline in the WQE at ib_sge as VA.

This inline data doesn't require dma mapping.
It is memcpyied to MMIO area and in the SQ ring (for differed access).

Code is located at drivers/infiniband/hw/mlx5/wr.c -> set_data_inl_seg()

To make use of it, ib_create_qp(qp_init_attr->cap.max_inline_data =3D 64) s=
hould be set.

However little more plumbing is needed across vendors for nvme ULP to consu=
me in proper way.
For example,
drivers/infiniband/hw/i40iw/i40iw_verbs.c trims the inline data to its inte=
rnal limit of 48, while ULP might have asked for 64 during QP creation time=
.
Post_send() will fail later when command is posted, which is obviously not =
expected.

In another example ConnectX3 mlx4 driver doesn't support it.
A while back I posted the patch [1] for ConnectX3 to avoid kernel crash and=
 to support IB_SEND_INLINE.

[1] https://patchwork.kernel.org/patch/9619537/#20240807
