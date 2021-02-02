Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164F130CADC
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Feb 2021 20:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237803AbhBBTDA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Feb 2021 14:03:00 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6432 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239093AbhBBTAz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Feb 2021 14:00:55 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6019a13f0001>; Tue, 02 Feb 2021 11:00:15 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Feb
 2021 19:00:12 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 2 Feb 2021 19:00:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dze1yPjCriDKsGixk5/BRtaEvbJlf2DlcM7LxqlHWXwz+9ekjkWrnwUx8MyGOZByaNc6/dilCCJ4w4SSfz8SH0Dpagw4f/0yO1CWZPHIDnOCUA0on5+q+CTwqMBTW0lASZIUd1iJ3tkeIIXki91bonI2AMbZ22g8w1qbAY/rrdwDkS3jw+xUkAftWJMJQiV7B3UUG9cW45GMi2fgGwmaic2SaCxOpfC33zVRxaa1Jjob9LQDjCqLyIsLfyDgMgXrky6ATZZHIVr5UEvrKD+s1jWGWVJZNOXmZztFW3+SRkzQz9jmy/8Jo9+salPy3cXw9d9vg2e7lrWq4VycQdY7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcBH9f61ZMvzc8AqjO5yVawn6TZuMgmSLv1yOcA5O/s=;
 b=UP2xAFeKMZsn9iGzt/OkyILxCMsonkOqFSRb+JqndDuPnUVCGQdJUx7FVTx4r9noayIav+JymZz3zdlSiY562kdObwco2GaxK2EwUn++BnKYBOF3N5sXI3f2R6y1oJLiXWC2ZpJyvMeODWhgY73M2t996x1NC+ofWFYfe171gjxa723Hw/9nPbyuAAacGYqiEQ76hOeXdshKW0FTs4AXy569cw82USLA7AJDHeKBefLcPOxJZM6d4LI7qI+UfA2yJer6keXf5e3nfSD/YwydUzWdmyP79LnNVwgTBbUqWEv5bLryfHs2UBx/jqQpPqi+8vfVZyLRjxO4a/w9DEmlYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BYAPR12MB3416.namprd12.prod.outlook.com (2603:10b6:a03:ac::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Tue, 2 Feb
 2021 19:00:11 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4%3]) with mapi id 15.20.3805.026; Tue, 2 Feb 2021
 19:00:11 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-next 05/10] RDMA/core: Introduce and use API to read
 port immutable data
Thread-Topic: [PATCH rdma-next 05/10] RDMA/core: Introduce and use API to read
 port immutable data
Thread-Index: AQHW9L01UOc+cxuk00aRHMnJqKNw26pFHWkAgAAFgICAABIVAIAACn4A
Date:   Tue, 2 Feb 2021 19:00:11 +0000
Message-ID: <BY5PR12MB4322E3F452BE145703B61F9BDCB59@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20210127150010.1876121-1-leon@kernel.org>
 <20210127150010.1876121-6-leon@kernel.org>
 <20210202165000.GA621786@nvidia.com>
 <BY5PR12MB432200DF13C2C7E2F62E947CDCB59@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20210202181424.GA639633@nvidia.com>
In-Reply-To: <20210202181424.GA639633@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.167.131.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fb7c0a9-ad39-4e08-0851-08d8c7acc43b
x-ms-traffictypediagnostic: BYAPR12MB3416:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB34166C038B5542046072DCA4DCB59@BYAPR12MB3416.namprd12.prod.outlook.com>
x-header: ProcessedBy-CMR-outbound
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /K1DQNnquH7nm4UBXWzQytIkXYCY47BM2achXh08qdlIR72zPD7WBaNBuwtXBiAFTXGcMiHOE8D4iwHzOSXlOBcSdNVaa+GqBwAxVJRSjVp+uZrJWPNMIOcfjyaznj8WmlurIdzBkYSTV9gFyxr7Pc6/SZttR8GVjd+4VVJtqc0ssSh8A++O3NK7mSnUfa6f3wlthQLQTrQ6EvTf+5Slf9eUqRIJHKoI5RCiDIM7lLzeQREdtgY7xycA+9XELxTblYmq1UKiVa2kEWOulNJtdnKFZkXnSuiSHF6fjjzF2L+lUbpmIgWSusyZJYQGia3ofNjrPkMFf7dsPYuau6Q4Kysihg/8UzxV099PiSRLtHrXSduTf4PMZ01h7ym8m35gbvmVUr3R2+SiaDj2hXScMnd75k5BVQ2qFeXTynMxc5cJED+nOiQR1avuXEmVffuUCEwlaD878DL5dGwExXUqzk9pwggYwTVJA1LlYcZA97mUXGe30Ewutwu0CSOGVoOU62oXbo5F5q4AzvzarbrGcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4322.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(4326008)(478600001)(2906002)(71200400001)(26005)(6506007)(186003)(6636002)(86362001)(6862004)(55016002)(5660300002)(33656002)(316002)(52536014)(83380400001)(76116006)(54906003)(66446008)(66556008)(66946007)(66476007)(8676002)(7696005)(8936002)(9686003)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?x2WLKhX0MYl4vvovfq+vtRMJBppKf6lW2AVg0j8dEC2evB5GiwJdH2PmfZs/?=
 =?us-ascii?Q?dNmST1VYHIka18+dwCKoDSxIEdweVIUFjIRFIGzYH/qN6Yq050r88TbBgWrf?=
 =?us-ascii?Q?JSGalff30NKzdD17Qe/Ie7eDmcAaT2Eze+Ry7PWUWDLK8HQYjBZeU8vzhjqi?=
 =?us-ascii?Q?SzrLTSuqqqay01as0NEqWusHJf8M34FjHt/aOiS8PkLaf/2OHNEQ4TOnxM9b?=
 =?us-ascii?Q?wxgBAlT3qUqX8ZaiXM6dwODyItjrbxRetPHxbOrhDAuvzxLK2JRjw/v/AMJq?=
 =?us-ascii?Q?BizlMaDxIWsA1p7pmBtcQbrFXIU5zkoASIdvNYUrFbUdT0I1G/Hd1fOC/uQH?=
 =?us-ascii?Q?bgAs89aDMa3w57e7SelqR0WigPRAkpdeBy01BpC/zvxaLo7C0t3WMOTeYDQ0?=
 =?us-ascii?Q?qBHSyGufEPf7MizEFpBfV1NOXEhYX4p/a4++hLMe9OC6pTC8E+UCaNK19EuN?=
 =?us-ascii?Q?WH4Yyw9xG7PAEajVj1zBCFEa8c6DES0BgTHIJHS6c4uWiVERnjVeZUnX0r9k?=
 =?us-ascii?Q?SYn+JDvtWaHcCJGPph2OcPK3IoPb1gngCKr2D3ESedkosqGmnPT/gszm/2+h?=
 =?us-ascii?Q?JyIQBrlcT5E9A3BBHkF/PcW2F9sOb3htpa+XAVP1brzJ7LKQHNNyVS+XFMPp?=
 =?us-ascii?Q?U9knj42ZfZvWrXrGAIE9ymRTGForsNDy0qJ5wUujn8g067CCKT/m6llnMrVo?=
 =?us-ascii?Q?QRKQCuDC7NnP/rsom2ncY/P9rkwQS7suLdLO3TcLemoIg6p+WOqsJrWvEL3w?=
 =?us-ascii?Q?KM7sprC+dQKWhFV8sWj5kVvirfg0V3XKZpil26/kN8Xd7M9yg9kt6lNJoSHa?=
 =?us-ascii?Q?LhZXIuCdRp2zhlYxhNWS/AUtnAxPqsiqIGRcftR4jaY2KctnaPXzSZ0digZ4?=
 =?us-ascii?Q?YX9fbsnuiMwqQVOSYt0GQ+qRn77rtzKqMnHV+CETW8N9rrLhY0YB9Gy/ma8r?=
 =?us-ascii?Q?EYC4qhi/L0NkTCapk+KUF0g88QqVsJagz0NpDnmPNEf6bh1bhCIB9NTuq2wU?=
 =?us-ascii?Q?4LG73EYJv1EKPonXeIRjIqHbTQlDdjRP2QLvR7NCjzfE6o+R5ZZ+LxL7z1z2?=
 =?us-ascii?Q?7vrMKQ6F?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb7c0a9-ad39-4e08-0851-08d8c7acc43b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 19:00:11.2753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qgq1j0Iz4Uuz2MlX+BwxiG4isXdR/mSqo/vXSzzkKyRL1gYbPivZD6TAR57TaK5qZH1qNwidx+hPPZlzT0rP4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3416
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612292415; bh=rcBH9f61ZMvzc8AqjO5yVawn6TZuMgmSLv1yOcA5O/s=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
         In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
         x-microsoft-antispam-prvs:x-header:x-ms-oob-tlc-oobclassifiers:
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
        b=T4+BuKMlHVN/A2CcsVnYCRcxGyh5oJ7pE4xlvy0/LOQ8WIThpeNmx9Voe7PKEa8Zq
         gttQYCxV8DypzP+h0nOuuXiMn1FbuakDUDscf1DW/QOS6PxaCrp3KnWIq75efa+jgq
         TxDwBoj/u/wvcAJilwHU/XtRFI4CIjH+jWbmCOn2VEoa3kjVS3ywJGdfZ2T5rTED12
         odwflCaaWxYV2kAvUF4cVuHUB8nPrP2JpgEIVsZsVfCt1/G0ov2gQk4ZySL8pXwp1W
         MZvPXEA0bTI1K+84mGiYS/WQtAlZHkWRzrn4OBgsnXKS7+0OM6XDobDCIojukDQJ3g
         4X0Mi86N6qBCQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, February 2, 2021 11:44 PM
>=20
> On Tue, Feb 02, 2021 at 06:05:48PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Tuesday, February 2, 2021 10:20 PM
> > >
> > > On Wed, Jan 27, 2021 at 05:00:05PM +0200, Leon Romanovsky wrote:
> > > > + * ib_port_immutable_read() - Read rdma port's immutable data
> > > > + * @dev - IB device
> > > > + * @port - port number whose immutable data to read. It starts
> > > > + with
> > > index 1 and
> > > > + *         valid upto including rdma_end_port().
> > > > + */
> > > > +const struct ib_port_immutable*
> > > > +ib_port_immutable_read(struct ib_device *dev, unsigned int port) {
> > > > +	WARN_ON(!rdma_is_port_valid(dev, port));
> > > > +	return &dev->port_data[port].immutable; }
> > > > +EXPORT_SYMBOL(ib_port_immutable_read);
> > >
> > > Why add this function and only call it in one place?
> > >
> > A helper API from core helps
> > (a) to cut down mlx5 ib per port data structures and code around it
> > (b) it also avoids the need to maintain such driver internal data for
> > large port count (which is not done today)
> >
> I mean why not just access the pointer directly, is isn't in a private he=
ader or
> anything
Oh I see. Yes its accessible directly. An API just looked better to indicat=
e that its RO for drivers by doing const*.
