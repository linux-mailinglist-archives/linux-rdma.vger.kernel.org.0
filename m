Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8478B2F9EA8
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 12:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390954AbhARLrm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 06:47:42 -0500
Received: from mail-bn7nam10on2052.outbound.protection.outlook.com ([40.107.92.52]:62361
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389325AbhARLrW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 Jan 2021 06:47:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5VX+Zliwak4cYYmPLHJV9qGw3aBVzkvyTxBAvYsfwbgRGpclUxjMIIjNTVqTFuX+5nNIa+vbf8j0lC/mxfTJkFfD3h/FhYH6a/o+ZMpgpnbVQ46IAhSTo1/XBkthVd/VyCXonkKWAwqZhbY+n5/MWi/qDkiOwwYKprBByS+YqUVymI0axw04CperCBgtoTfUk5kvC8V/JwKLi1n9bQ/7doB+eBP0y0Z4f7H11JhwgjpS3a8+VAZk5zMQrsJDlDGHHF3tkU5IptXtdDdiRMjlD9xck8xRZw5k5y2uIPujfmj2PI3HZTU95hR5Vc/1fU54wut2au0/Q4NKHJao78RlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H806aZZpex1JXu2T1EdMhfZpQJP/vlLfmR5IDXue+aQ=;
 b=aUD039hBie9ItX9iX+L8KWj/wAWdWtojhj7IEAlzGXQyxKgYsa2BBVgeRqLQSlOAwpkCM6zVPGXuItjINHFc8dmq2rYP0BGKWIEcHg6k6uxdURffIBa6LKRlCSSL+n3LuRB1E7KjK46dKFGhxJdVQuqA08V70r6ExDnuPP7aUgkOvd8+BO1+eunhvZm0eNkfLmcY3uTpacLfiyGofPcDO0SOAUXUdOD5a5HOVUZAt2jUss4SGz7HSygFKKROczspb4G+Bo6+NzWe+W2NSy+EcuFiEO1+7aG5IkAyhtoJw+y0r5c0xYUXPo1NnMfVYCAv5c1QCHuzbZu4GDWUnC5jFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H806aZZpex1JXu2T1EdMhfZpQJP/vlLfmR5IDXue+aQ=;
 b=KT+aVVbENWnzM0tWlJBM/OAn+C7nRAWxF0F8Fp7XS/PQsDScbf8yNxwmQsxpz019Xzr4Nlb0HTFcKhwhzhR6kQ6aas27Li58t5S5Fa8O3b6erfPlLoVSdXC1PKwn23ikZjQL8PwVbzy1twC1TXg3v/lyQZmyiNJnSQDqF3pFbEI=
Received: from BL0PR05MB5010.namprd05.prod.outlook.com (2603:10b6:208:36::17)
 by BL0PR05MB4946.namprd05.prod.outlook.com (2603:10b6:208:8c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.2; Mon, 18 Jan
 2021 11:46:28 +0000
Received: from BL0PR05MB5010.namprd05.prod.outlook.com
 ([fe80::b5a6:c2f0:f5fd:1fce]) by BL0PR05MB5010.namprd05.prod.outlook.com
 ([fe80::b5a6:c2f0:f5fd:1fce%6]) with mapi id 15.20.3784.006; Mon, 18 Jan 2021
 11:46:28 +0000
From:   Bryan Tan <bryantan@vmware.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: RE: [PATCH for-rc] RDMA/vmw_pvrdma: Fix network_hdr_type reported in
 WC
Thread-Topic: [PATCH for-rc] RDMA/vmw_pvrdma: Fix network_hdr_type reported in
 WC
Thread-Index: AQHW6oFSgRSBXw4ME0q8w/xESfn7YKonXxSAgADB0RCAAIQbgIAEo9Yw
Date:   Mon, 18 Jan 2021 11:46:28 +0000
Message-ID: <BL0PR05MB50108203905E205C6B4D2682B2A49@BL0PR05MB5010.namprd05.prod.outlook.com>
References: <1610634408-31356-1-git-send-email-bryantan@vmware.com>
 <20210114172359.GC316809@nvidia.com>
 <BL0PR05MB501015BAF25CADD722F5A9FCB2A79@BL0PR05MB5010.namprd05.prod.outlook.com>
 <20210115125031.GY4147@nvidia.com>
In-Reply-To: <20210115125031.GY4147@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffed4d48-2a8f-490d-bc98-08d8bba6b137
x-ms-traffictypediagnostic: BL0PR05MB4946:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR05MB4946601E6DE417938D52A40CB2A40@BL0PR05MB4946.namprd05.prod.outlook.com>
x-vmwhitelist: True
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g8scDzWd8Iyh5LydXPyLKjINyyb0X7OqKew1QSc7cZbd7sqcgHmdgjpaujK+HwXB7EGVlXPgfjoCkTzqdj/j0emBpUKUJ1HIGlUX11jp+WtRpnvr63HWD+8pmOIwLOHhomrEo/x94dUgH1At+Xn5iyANdTK0A8cMUinFRdtLkDsuQy5xoabK/mrILT8MbSCs3Dzqyp8vG6FXYFmoPcaoK3AdcJ+1ozV4/t6JIMUu4vTaZziePkph2sYcjcEeq7TKk6ZpFOGN/6WAsIeiw5z6Y3sF1ov+jHMGytd0Up2CMWTsn/Ew0OnNp4qN8YfGEA6y59DYrGsW/hwKtwop3tacC7im2lltuS+lbIQdwu4qoWP2uNZMSlWl2Y/eBKBRye3y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5010.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(4326008)(55016002)(107886003)(7696005)(478600001)(54906003)(5660300002)(86362001)(8936002)(6916009)(316002)(66556008)(52536014)(66446008)(6506007)(8676002)(66476007)(64756008)(2906002)(71200400001)(33656002)(76116006)(26005)(66946007)(186003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?1e0wIX/f3KyagXGU+/Azo/EKlh0dZ46QFrd9sqKxDStLrwtT2wJtnY9jdJ?=
 =?iso-8859-1?Q?Ka2403ScsKMPDuR21uojSxgzhUPCJvofGYcITWq9mmBh0fIeC2AdLVGI34?=
 =?iso-8859-1?Q?b5mIFXEFfGE0OV8aVhK2XkX3oPBdutm9KWd+pUugyWZa0Qq4Kr7+YD9C/+?=
 =?iso-8859-1?Q?kZ50TX4vy6Q6J+Lxx7IY6qeCcx4XSqYqT/xhSKW94bc0x1JumBQRUtX/sJ?=
 =?iso-8859-1?Q?3VA6TQHEyeGc37SRyXY6ZzoFOSn6V8wX2r9vOh2S3hMVKOmj/CEXecnsOc?=
 =?iso-8859-1?Q?Fo3lFZsk8TWo1nLdSc3LVXk3N0wiXWn2dxQTiFH88QT8H8TKfRkDVeeg0u?=
 =?iso-8859-1?Q?Qkot0gaIMobbEyOO+jUISI+rEnUncKYbNMd+tIkMK50K+LgPdhe6/91qaV?=
 =?iso-8859-1?Q?brdPmh6NKhrhbBuafL5AVu6ohvUcvp2EriVLLGGAlurnBlPRJbnMMCLsPh?=
 =?iso-8859-1?Q?I7uKH/kiKU2u/yA30SoNYZFUfTWHLzlOMGQv7jtedpNXvx16IVxUXqMb7u?=
 =?iso-8859-1?Q?cnemLzJzmU3EOiPOzhd2h00L+G9jHbZSQoYuq7kbny3rnJ0CfJMkdxImGu?=
 =?iso-8859-1?Q?oc23mKHgjB2PgUZLWr9vkTxJd4Hfv15+yocQD0Cfo6qk6Foi/dqFmsBtfN?=
 =?iso-8859-1?Q?2IxRoaLQihdwAzhwnr1x0cyyM1eGO/6bmkDZPwoJ6McW8gwYWWSFrz9D+d?=
 =?iso-8859-1?Q?H8OSPidxtrWLgs227RdPbc54uugV14wkqKH2I6Z+5n2j1U8prDCMqDBJ7A?=
 =?iso-8859-1?Q?nMo4ozLRVd81thlOQaiseejkB2daeYjPwtr0WM7egbT26gYDaS2cozb0p+?=
 =?iso-8859-1?Q?w2V5gsGdZrl7ebROePC12t4SfxqrfLLzDIXIC56gllr1Vu9Wuu7JAz/M2l?=
 =?iso-8859-1?Q?LSN3ryIuFo1XlqeO3yGyn2XkF5SHApc1DYTN1kDFqZmjFybYxnw59ertuR?=
 =?iso-8859-1?Q?lFQX3L0j6Ar2vh1LijVHl9HM69aCPBuh5+HtDkmJrqEvvuwU3Yn1QVu2w0?=
 =?iso-8859-1?Q?8H5Bjc33fRk7OOiE8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5010.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffed4d48-2a8f-490d-bc98-08d8bba6b137
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 11:46:28.4690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqLnVVjnAuZK9gxDJCY7eO6yWb/sSZCuSEw88SCjOFdVTocCpKu2bNZcj1YSAv7avHiQ73tYXXZAfz0yOfwDrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB4946
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>
Sent: Friday, January 15, 2021 8:51 PM
> On Fri, Jan 15, 2021 at 04:58:58AM +0000, Bryan Tan wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Friday, January 15, 2021 1:24 AM
> > > On Thu, Jan 14, 2021 at 06:26:48AM -0800, Bryan Tan wrote:
> > > > The PVRDMA device defines network_hdr_type according to an old
> > > > definition of the rdma_network_type enum that has since changed,
> > > > resulting in the wrong rdma_network_type being reported. Fix this b=
y
> > > > explicitly defining the enum used by the PVRDMA device and adding a
> > > > function to convert the pvrdma_network_type to rdma_network_type en=
um.
> > >
> > > How come I can't find anything reading this in rdma-core?
> > >
> > > $ ~/oss/rdma-core#git grep network_hdr_type
> > > kernel-headers/rdma/vmw_pvrdma-abi.h:=A0__u8 network_hdr_type;
> > >
> > > ??
> >
> > network_hdr_type isn't exposed in the userspace WC ibv_wc.
>=20
> So this is "HW" API then?
> <snip>
> Well, the struct that holds the value is in a uapi header, so the
> definition should be too. If you are defining HW data in uapi then may
> as well define all of it.

Yes, the pvrdma_cqe struct is populated by the HW. Both the driver and
the userspace library use this struct to populate the corresponding WCs.
That makes sense, let me move them into the uapi header. Apologies if
this is answered somewhere, couldn't find any info--am I responsible for
updating the header in rdma-core then?

Bryan
