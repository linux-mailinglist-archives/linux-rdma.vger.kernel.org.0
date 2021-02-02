Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE1630C90A
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Feb 2021 19:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbhBBSHy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Feb 2021 13:07:54 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2633 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbhBBSGf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Feb 2021 13:06:35 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601994810000>; Tue, 02 Feb 2021 10:05:53 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Feb
 2021 18:05:52 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Feb
 2021 18:05:50 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.58) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 2 Feb 2021 18:05:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DI4YD3BOe2xgpJPmoEOojgJxO37ikIA/xJ6BFckIfdTP430eUR6x3uZCvNRKAsf9vQd3lb+NB6qIVGwe2FjaHu+KwaBpONWcUC5v8eKXBG/BJYPQCLbi5382iNrpxFrq9R4kcT0DtDRMflR5bjL6ADT2zF84rbBftIWnnjeReLEHF7pl55FA8wcgg+jkkcQWNxvp4XMSC4XRHyVZiLVkGpeK/Z6VdTY8INt/qrFAWOAU1vtouEuq5vNfLdH+lkExiT78Ez1i7NIccRPNL9EvzQ3y0hhid8Ko4RgcW7gsuRiXl6aa2+Q3R6qsR5aPPsUVC8q0SrHt6ywxd9+OjP30rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkcilBugdo0HjidB5yEsAMCxZBqAHO+6ag04nYzTOSI=;
 b=P9O5rwMl/MtYISVPLr6+lTnP3tQb8tC94YjOi5btkmMIxeSzZKqVtWWml/zy7Vs9rzANrEHQbE1yn41CQ/FjUMUxjQnsVijj9e1mgFXR2tlSk6mz3UDayHVeC1n22qJ9VVuaCq92x59y4exH6GNXl0lXkGGbJvtbSW639AKeg95Dw2UASQ8qP8K1UJ3Xd4BHEjMOnJBfgtqLlt9kXxvbbb4gGx5j0zujNhni9ZEvVQMfpNvbvCRsCrqflGVKUg+zads20OrmucA0z/cxEm1fJgyQ0inUXPgITvLAfJBuaIBfxsZHmPx89xpuIKBDZ3dJRdBPeoO4NOweQPHblnuFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 18:05:48 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4%3]) with mapi id 15.20.3805.026; Tue, 2 Feb 2021
 18:05:48 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-next 05/10] RDMA/core: Introduce and use API to read
 port immutable data
Thread-Topic: [PATCH rdma-next 05/10] RDMA/core: Introduce and use API to read
 port immutable data
Thread-Index: AQHW9L01UOc+cxuk00aRHMnJqKNw26pFHWkAgAAFgIA=
Date:   Tue, 2 Feb 2021 18:05:48 +0000
Message-ID: <BY5PR12MB432200DF13C2C7E2F62E947CDCB59@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20210127150010.1876121-1-leon@kernel.org>
 <20210127150010.1876121-6-leon@kernel.org>
 <20210202165000.GA621786@nvidia.com>
In-Reply-To: <20210202165000.GA621786@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.167.131.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 088bc66b-f299-4483-9523-08d8c7a52b37
x-ms-traffictypediagnostic: BY5PR12MB4228:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4228E741E87F815B7A0FB86CDCB59@BY5PR12MB4228.namprd12.prod.outlook.com>
x-header: ProcessedBy-CMR-outbound
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W7zjjhe+apwWvZ8bY2gbHEUQK+G+oxQxMgSmy5DOL+T98nWXtbW5T81L5mPInTxig0Hch5EH0HQDwXOG2dfGXClaqU53iXVPcQ294k0+Mtn9XmlPX37e0riw6Cx2LU8GKBiXdYUEAD4LtNjOIMmfb10lLTMrUtV286BZFQK0pF7A2RoKgFhY9fecoAPb0JXE9Yh5w9n72JQsU6H2C3MIBwWuVmAcIglEJBhwnWGughFSKihUJTAjZew+zd9J+rONFs/AE0tDie1WPRMPsAOhKS5Caj6X5TlDSj7WwSFnmfBg2ES87pZ7NFb/oLJE+LjeqtiAgY9VydwmAhEclzUndkssBFm1jTfciDyptuaSrAbj26136Cs38s+hRzu4080306Y8loHh1YKoCbzsqtwhXpuwItVTdwB+w5jOdAxxoPMp+eKpb8UXE2LsU1rTgh6Br5XZiK6o2EZpRfdX0aQUb2UXp2aa49UglE1EstvGDPoHNAl9j8wGqLKRrMFlGHoXXsoAyn+zGsBYW1w3duK2zA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4322.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(52536014)(6506007)(26005)(8936002)(66556008)(7696005)(86362001)(4326008)(186003)(2906002)(5660300002)(64756008)(66476007)(71200400001)(8676002)(9686003)(66946007)(76116006)(110136005)(55016002)(33656002)(54906003)(4744005)(478600001)(316002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?93CgIxIyZKsbqcmBlRcePPKIN2Cn2v91SkhsUC1Z6+hdg6SToxMRaf4gdt5G?=
 =?us-ascii?Q?a0ktnYd5bdnlP6puWPjY6saj7rOeITslPk03ojgn4h4mt2sdwYrs/2BAPRXC?=
 =?us-ascii?Q?qx4IlcMDYJFftkTYs2vczCOwW1hBNkfA26FYwaQz7/NzeDGyAhSfZStpfg+t?=
 =?us-ascii?Q?AbbTHplZpAuBuJ/Ja4RFcGFlxw9h55LJ1mzQ8J/FOvWlDbSRAW9UIfDGUsJJ?=
 =?us-ascii?Q?wfO5C+HCrMUvQ7DaKfdvuZzncApdzJRka85ehT5p13jOCCumgNHPEnU2rbdA?=
 =?us-ascii?Q?U2gZMUSGquhRFFcLU+vWb6Np/w+17Aa7R2yQJzih1q1N59/XJvju2zAGUX2U?=
 =?us-ascii?Q?WtNhwaK+WCtckXMKYPIVd3ptbViKGjCc7EwRRmQ1WaGGA6UFXxrBDf7heOBz?=
 =?us-ascii?Q?pUKloUKqqwVfWDv1DLMa/S8JjOMYbP+nrj93LL9MGLriG2y/vy11KodqtS4M?=
 =?us-ascii?Q?OE0strIGa8dXc3wZkdslY8NHBik9VLDleXrDEkLl74//I12WYz0QVerACLkK?=
 =?us-ascii?Q?4BIjD2pLw78SY+IkWdeyUyRGjXFY3/eefcHnLVVNBfDQxo95T0wsQIcLJoM1?=
 =?us-ascii?Q?BhUnvPt22RgWPhBsOxSuiKgidc5T3qa6lPqR0Z5SriiBQmo+xUuCPeLCtkxK?=
 =?us-ascii?Q?fPfd50oB8CXiDYMA/j1YQyoib5F5oDvm1zLxLvdAkEIHS84ldk6EPTckxMNp?=
 =?us-ascii?Q?YPfT6wQiaU3bMZnMo7n4wWUxmIjt/7LJO84NkksHyLqoTHJhXzzirog14gMI?=
 =?us-ascii?Q?bWU4uaZbo7NuUN7CYGYyUfcda98YbRdj/tXzeyUCopZ7XL2uLDCXi4ye6GA5?=
 =?us-ascii?Q?J7ZFJR+YaBz0sz7nDtTl2g2XulsxcHIgUHiIGhOEde9JqY16V20NWPDxWSW8?=
 =?us-ascii?Q?7Z0SvXxhAmtxqFLZfRh4nHyYBDAht7ZT42M6Y4Uu56vh0HFJnXOMTfhU0+Dr?=
 =?us-ascii?Q?szkLFP27sIpFDiFgAR5iNMPOT7E9vGoX9byHQsu/RdTQvXhYL5VA/bm2haWS?=
 =?us-ascii?Q?HSrfenkjN7Cqi4Nzg3AuTfyvRFKFuml2pQoaXxZxiNcqR+/f6KLh7nrVLvCc?=
 =?us-ascii?Q?gOOynILS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088bc66b-f299-4483-9523-08d8c7a52b37
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 18:05:48.0643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7iQEqiUWRD4xUNJ5v0RV4N95RLQgOSSpJIZ1EdjDcaXekx/trHJkpHrRXMAbWEV0cUqsQu2GBUfU5sIlqLI6/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612289153; bh=GkcilBugdo0HjidB5yEsAMCxZBqAHO+6ag04nYzTOSI=;
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
        b=G9oS1AQZ45/PUXWAeHSDCdG+ytekH35nRJ7Elue69/iSNR0wXQpuXvGdMN72GSTs3
         QRc53KauDWfz9iEHO7mmYE0RaeiTFSmKhHIZ56ZKmnYDbOvqNHCSWdxkJ5+U2RRSyQ
         AadkwJcZPEfHygZCtaU3X4gQJqNQiy9Ptdrrq3Js0suicH3T/O1x18/fcJwfjj/NEf
         m+8rjYlxPDfPt1QDkiBRaBOga13deaZVbTDhi6d6YvxE2Pc3pDHXJXmyqMVbFOORS1
         S3twQEfb+bGuE6Xcbk/eMwooHBymQ2P4S9NjnewWVXo4ejAItFAUcylrbX32djugHt
         OnXgdho24awUw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, February 2, 2021 10:20 PM
>=20
> On Wed, Jan 27, 2021 at 05:00:05PM +0200, Leon Romanovsky wrote:
> > + * ib_port_immutable_read() - Read rdma port's immutable data
> > + * @dev - IB device
> > + * @port - port number whose immutable data to read. It starts with
> index 1 and
> > + *         valid upto including rdma_end_port().
> > + */
> > +const struct ib_port_immutable*
> > +ib_port_immutable_read(struct ib_device *dev, unsigned int port) {
> > +	WARN_ON(!rdma_is_port_valid(dev, port));
> > +	return &dev->port_data[port].immutable; }
> > +EXPORT_SYMBOL(ib_port_immutable_read);
>=20
> Why add this function and only call it in one place?
>=20
A helper API from core helps
(a) to cut down mlx5 ib per port data structures and code around it
(b) it also avoids the need to maintain such driver internal data for large=
 port count (which is not done today)

May be in future more drivers can use the same APIs.
