Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B050222B80
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 21:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgGPTGE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jul 2020 15:06:04 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:23482 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728257AbgGPTGD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Jul 2020 15:06:03 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06GIuLZV022110;
        Thu, 16 Jul 2020 12:05:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=uUZPsmmvWNq0SveST3Ym2AKhYMtswuqaS4q94y1prIM=;
 b=yhoVv+JCefegGMjVcdQBOju2nj+mvhjWPq+k6eMCAQTzrUEx1gCn8+gMgL+AgE6+yYu1
 VRtx0hSd7MYke0hiEilrpX9T0TzJ+3i2gdy4hTgF9vzg+r+bbfPNDlO6ixVjeLnZAaRb
 oHgcL7rvYM4j5JTqH0NZjwov3LYNwXnB1c6Ea5UWp6FxL/M9OqFiZs37eimMFZcIyGYa
 oLVo0AkToUHbpLzbKuXiUrNiF4UcMQh06TTZPoMNTYndW8fs+Q7eDA3aVJsa3IV8kXnF
 wdvw3AUxevB5HWifgl6RiXHnrziyeD83RMuROxAh9cSKbAMvmWmwKvEKU2F/fiw9Qgoc SQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 32ap7v9w6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 12:05:59 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 16 Jul
 2020 12:05:57 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.54) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 16 Jul 2020 12:05:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geZS5ZqwDs9w4wf1q6DXXnGPoOKaGt+Qh+IIPt+iP/oD3PFqO2zgqPcMq595Wz6SZQnaiiZzwIHF4Pq2SuIcBF69Cf18f0b1wJoLtfeROyO8EtZIk9R1tq5GplNQySEVLJOa0BZ1trKW6NBaiSXFhMfcYLGMrubSv2q5EemllR8wpb6qso43uzow7KdZjtnkhHXjOox4yb6dodKvmMJt12v9kaVhgBtQBnNiM3AR/OyTPlPYZ4AK75eGo4sLWiVgpk3K6SjuYyrOS2DW712A6i0mzfKwp83eqXNJg8C6dGFgGrnj/gIClJcPnuO5ZRpxEN4eTPFi1bENtxlPUKUqzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUZPsmmvWNq0SveST3Ym2AKhYMtswuqaS4q94y1prIM=;
 b=UvKwfuLkjcwDRElJnx/QS33Y5AT0TNxHgB+4ohA52WBH74JLUNmotCbH56ygJAMMWKL+TE3xfmjVIf/u+xr3CWCEKsm9wEInO0QEobDoJzKrzus6trhFov0MsPvMCoBJQ0bNb3UzvuJE+A9oLfnyFq2VChrKcfUFTteiAvDRvy02QmyjYvCClamyA8KGNRyLbiR3u3Oa1s9wQ52dl8adWPYnCIteMtoS0NkM+Bsc3w2xC0qJrGkpDxptcEovnNsvzLHREbKQCeAKG2CyTPArAYPSiG1newE0opszHQbXNvjxY2ZNMjycpJUS+HCE6WiA5OIt8TulMRM8M5IVR8SgPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUZPsmmvWNq0SveST3Ym2AKhYMtswuqaS4q94y1prIM=;
 b=KWZ7CeDDQr1eu4BST5Dz6V6hUQsX/zpF6EU1Z+sCWaorz1HNv68/04bgsO8DRkgCEQ2f/VTkRRkLAVFyQ0jJUWvwgdHK6blfGYJgA20e+tdCQk4ttaj1Be9NCS3VsWuC8aaHoEngSIrP77mBSEFfgPaOyJ5q+60/LqBagSIxa3E=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (2603:10b6:208:163::15)
 by MN2PR18MB3608.namprd18.prod.outlook.com (2603:10b6:208:26f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 19:05:57 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::1849:3020:9782:8979]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::1849:3020:9782:8979%4]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 19:05:57 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        Ariel Elior <aelior@marvell.com>,
        Yuval Basson <ybason@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v3 rdma-next 2/2] RDMA/qedr: Add EDPM max size
 to alloc ucontext response
Thread-Topic: [EXT] Re: [PATCH v3 rdma-next 2/2] RDMA/qedr: Add EDPM max size
 to alloc ucontext response
Thread-Index: AQHWVCg0clmxjwo/n0KUKYS9RwmNz6kKf9GAgAAQojCAAA0mgIAAAbXg
Date:   Thu, 16 Jul 2020 19:05:57 +0000
Message-ID: <MN2PR18MB3182D6C993D6E5E697199A2EA17F0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20200707063100.3811-1-michal.kalderon@marvell.com>
 <20200707063100.3811-3-michal.kalderon@marvell.com>
 <20200716171055.GA2645531@nvidia.com>
 <MN2PR18MB31824C9F96D7F0D511D9B261A17F0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20200716185731.GD2021234@nvidia.com>
In-Reply-To: <20200716185731.GD2021234@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [46.116.41.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acfd408b-da06-4ed1-4d10-08d829bb456e
x-ms-traffictypediagnostic: MN2PR18MB3608:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3608501C7469D4F1B6529E18A17F0@MN2PR18MB3608.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RNTrctllsYi0R5LV7sVdUEW0BpKrFPls+8BUrHa96d4Fr4RCMc3LR5zjL9w4ZL5O0feFdopM0d24BX3+nDt/J5Vk87IpdQBltFIJ+fywobyS9OFpe7LrTPgEuueO1ZpSZ/DGIo37VDuXz/CLxCUMUfwjKvwg29zB4sMe+71ZkO84EQJTwvkwDYYRM1IToOHLzQMuVHvgQAEUM2hSjowgr4mvy5oeQTFTr/WVzIaRLaLUo+O/PqMvXqniupcaFTt7V26UC3Va9u2j38ip0mSmk5/Wu2Cq+WqqCoqLwSV62Ytm4BdbTzfkraY8zRcZNt3dZGA7XW1xlKMNca0kQOf8RA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB3182.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(478600001)(66476007)(33656002)(83380400001)(76116006)(5660300002)(64756008)(6506007)(66556008)(66446008)(66946007)(54906003)(316002)(52536014)(55016002)(26005)(7696005)(9686003)(2906002)(86362001)(71200400001)(4326008)(8936002)(6916009)(8676002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: SxbVtynS3Wbm1okPTUXbD43UvkAuskmy2KUwd/orovMAEuT3ZCD13MCYmBhavbYtBSgRqPaaYJZIDDbEnchDPEgSDRj/nOsQiNv5hg0rVIJkUBBRU5o9ityXCQyWbYE4tpnzQCDPbuNyT8CbYqAo4EaPKRA08cTsny5/BK4h4ok2MzRZDQaPw4aFEaYwJlpm1i5KyP9InB7eQ5DG9pKfzsuO5m8kFyXwXg26VNJq4P5KEdElFVnrtv5nSZPsWPX6oqNaL6CCE6b5onfompNcp2WovGBvR/vwcjx7uJS77r+lii3ii/A6R/uWnb71hs+ZQQnwvZLSwwEfxJGzGICmZsfKuldYkQCd2MmSiNtXMVcn1dYqIIXQRFMDD2kKk7ZSEoYaRbutd8mmQ5FU8Mj3nYE1cE9avIi6KOkGvHdFmN/x11yKvT7iIKTqOLEss7QJpA+PTQFx1x659mtO25fmTjnQfrFB3+gdTNO2bUgmWuI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB3182.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acfd408b-da06-4ed1-4d10-08d829bb456e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 19:05:57.2425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hj/MDLETFmNeiLUOxM6nyw2OlZZb5who4DqqaRpm0JhMqEP8xSnMZjy1vjrev/HA+Y+MrLiTNwEJtqstOeXfAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3608
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_08:2020-07-16,2020-07-16 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, July 16, 2020 9:58 PM
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Thu, Jul 16, 2020 at 06:17:29PM +0000, Michal Kalderon wrote:
> > > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > > owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
> > >
> > > On Tue, Jul 07, 2020 at 09:31:00AM +0300, Michal Kalderon wrote:
> > > > User space should receive the maximum edpm size from kernel
> > > > driver, similar to other edpm/ldpm related limits.
> > > > Add an additional parameter to the alloc_ucontext_resp structure
> > > > for the edpm maximum size.
> > > >
> > > > In addition, pass an indication from user-space to kernel (and not
> > > > just kernel to user) that the DPM sizes are supported.
> > > >
> > > > This is for supporting backward-forward compatibility between
> > > > driver and lib for everything related to DPM transaction and limit =
sizes.
> > > >
> > > > This should have been part of commit mentioned in Fixes tag.
> > > > Fixes: 93a3d05f9d68 ("RDMA/qedr: Add kernel capability flags for
> > > > dpm enabled mode")
> > > > Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
> > > > Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
> > > > drivers/infiniband/hw/qedr/verbs.c | 9 ++++++---
> > > >  include/uapi/rdma/qedr-abi.h       | 6 +++++-
> > > >  2 files changed, 11 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/hw/qedr/verbs.c
> > > > b/drivers/infiniband/hw/qedr/verbs.c
> > > > index fbb0c66c7f2c..cfe4cd637f1c 100644
> > > > +++ b/drivers/infiniband/hw/qedr/verbs.c
> > > > @@ -320,9 +320,12 @@ int qedr_alloc_ucontext(struct ib_ucontext
> > > > *uctx,
> > > struct ib_udata *udata)
> > > >  				  QEDR_DPM_TYPE_ROCE_LEGACY |
> > > >  				  QEDR_DPM_TYPE_ROCE_EDPM_MODE;
> > > >
> > > > -	uresp.dpm_flags |=3D QEDR_DPM_SIZES_SET;
> > > > -	uresp.ldpm_limit_size =3D QEDR_LDPM_MAX_SIZE;
> > > > -	uresp.edpm_trans_size =3D QEDR_EDPM_TRANS_SIZE;
> > > > +	if (ureq.context_flags & QEDR_SUPPORT_DPM_SIZES) {
> > >
> > > Why does this need an input flag just to set some outputs?
> > >
> > > The usual truncate on not enough size should take care of it, right?
> > At this point it just sets some output, but for future related changes
> > around these sizes there will also be fw related configurations, we
> > will need to know whether the lib supports accepting different sizes
> > or not. This is for forward compatibility between libqedr and driver.
>=20
> I would be happier to see this flag introduced when it actually had a pur=
pose,
> as I really don't like the pattern of conditionally filling uresp, but OK=
. Please
> delete this if when you make use of it the flag properly.
Sure, thanks.

>=20
> Jason
