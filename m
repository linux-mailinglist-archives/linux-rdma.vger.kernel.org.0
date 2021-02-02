Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0763F30C4D8
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Feb 2021 17:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbhBBQEn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Feb 2021 11:04:43 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7748 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbhBBQCW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Feb 2021 11:02:22 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601977620001>; Tue, 02 Feb 2021 08:01:38 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Feb
 2021 16:01:35 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Feb
 2021 16:01:33 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.57) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 2 Feb 2021 16:01:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcxKJm9CTmR15Cw15NEyb2VdHhlBmLMy7RNqXbQ7Gm0bJrHkD685g+3Sh7ms0d/terASqBoe8qxvYv1Bpz1n2ABUf4I1kjhHPcTnaINa5rmTPTLfyUymLP+4TTP476CZL/nQI5tAGoWTSgr7egm1YdLKUzyMZriCwfn5nMJmCJZ5AQ0sljb5xIBnX9lKKnZ4g32lYk2vMBzdrkhyMmGBIg3lgRz2OB4C0Iq11F+Wgv878HELSAQLGLFmHc49kStIwKkrd4zdMToXWKjbxcuLt7x3wk7/pSZK6+dD2VNUFs7iYCPNsJcmZ4dH7lHou7TRafKwEMpcfgFi9W5J7b3wCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hp3CvRRUSqFTEtxGpsLdIo0o9LpSkYXoiXCTZh0PRDQ=;
 b=h2AG+ck2Xj24lUBSqkm88Sbg7Y7y6+Z5OgodfWdOO0WGvDfbbRufXTzm56YTgqHnw0iExBQR/gqV5SzK+MSJBRTnXP+2CqT4je6JLguwPZid5yKjgNyx/cbiWsnVyBQYU3CEpGcs5WcP9tAzXfo16wJM0uaPs4tGVayC0OpVMTMyfrVl/wjvf9NLPdlq6S5yM/8wyq1XwQAHU1gLmRLWNfZsTK5Hg3GkkIUifSDTLmOwM8cFi20DvGyg9bjuOQsV4qn3AQx0qr/8SmJEvZLu+fJdAF9npsBC+LGTRoO8EMKuK0xovFx0sLDESqdsO5PiPzmzlsHNSsZHdOqy9U3kdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BYAPR12MB2647.namprd12.prod.outlook.com (2603:10b6:a03:6f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Tue, 2 Feb
 2021 16:01:24 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4%3]) with mapi id 15.20.3805.026; Tue, 2 Feb 2021
 16:01:24 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Mark Bloch <mbloch@nvidia.com>
Subject: RE: [PATCH rdma-next 07/10] IB/mlx5: Return appropriate error code
 instead of ENOMEM
Thread-Topic: [PATCH rdma-next 07/10] IB/mlx5: Return appropriate error code
 instead of ENOMEM
Thread-Index: AQHW9L1HTU0PWGYQ6k+frOCaFaHCSqpFBJaAgAAKpNA=
Date:   Tue, 2 Feb 2021 16:01:24 +0000
Message-ID: <BY5PR12MB43220FA2D87A12FEBA246227DCB59@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20210127150010.1876121-1-leon@kernel.org>
 <20210127150010.1876121-8-leon@kernel.org>
 <20210202152109.GA617190@nvidia.com>
In-Reply-To: <20210202152109.GA617190@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.167.131.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df05f9c0-3124-4b01-fde1-08d8c793ca99
x-ms-traffictypediagnostic: BYAPR12MB2647:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB26478D140061CDC122CC8B30DCB59@BYAPR12MB2647.namprd12.prod.outlook.com>
x-header: ProcessedBy-CMR-outbound
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ObCp76zTDenCXzu7e4QLZbja+psaBx5+woA1XUyWJVVG4M9W7ZNzxrDckGvQbmW1GUxNXA0bXA0b1iA+JGAKQjgMk8k6L/+8gi+KdDe/AhtdOH459CbaJQ0ixyieUogqovSEJaqBSkgkAqC49z9tbxDHoBVFhy3hSjqMakMBmua4B5JISkPHWyyV6xRiwy/0/6qXptXucWK1sxz/jE093/13I/n8hhjsQLOnvUaO7gU1JrQB+alKO+SsDVr87Yve+X8ZhS162B+b8+u9XnQEro+ZZFXglpNwXlzkeKXnMeKLRxzDipdyhdvBstvN4uzrzpHf69KXtdYTlYeVZJbPDt86c2oxSeQ0pNLZ5zrs7mHeh8mbFt84Lhl7QfYkwClqUsaQJFjHXV4gAuuROipQPwyxyuUMvAmzdC8sIQ0EfRtu7S2upaYlKReg3zr2tY6ItPinQ400g7d6/naAj1iGNJiTulmk9F6KieSIqONLSTZO+4jnxZFvHoylQeGr6gNfWZK4LXmI1ltCLDGXlgd/pQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4322.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(33656002)(8676002)(110136005)(64756008)(316002)(86362001)(54906003)(186003)(6506007)(26005)(7696005)(66556008)(478600001)(83380400001)(55016002)(66446008)(5660300002)(4326008)(2906002)(52536014)(9686003)(107886003)(76116006)(71200400001)(66476007)(8936002)(66946007)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VnnNavFVq6h3XuRfiVqNWMKhV/Fs1Q3+p5ZWE1GncEEjFulMEd3P8l/i8Kzx?=
 =?us-ascii?Q?bI8SJV2z5lE2ef4FsWiMon8glUOejGmOpT8au3fnoIp27/uMIGkeSrUVeqmE?=
 =?us-ascii?Q?s5vdcOFCl06F0wb5HdUryFRzSxir08XXZf69cajvphxih81Szo2MMjsXIkIl?=
 =?us-ascii?Q?NjGQ19rbojBMTflHGHvrX0NNS6d/cQBd/LpgPLRUYtBsa1EXj3CTXgJVGJgn?=
 =?us-ascii?Q?ZE+RaB+0YBLhb0gJWYi66ZdgIFkNawVracTMlSTb2qoAGWLlNUudUl2DUEkK?=
 =?us-ascii?Q?9GnTQu+mI+Y7pAep/6rCd9/gZBOhNldqZcTDyY34FWrOhlmBvj7zIpZse2/9?=
 =?us-ascii?Q?UwuFDduAmapCSFMpn2/CtFZN7YWpBHXnRS0vdsccn5bKUZnxLrif8WuqPvjJ?=
 =?us-ascii?Q?bXNAswodTY7hdod8ERnf3fOfJYeve27b93UHxsReZ9pnkiR1hg8XBpn333gd?=
 =?us-ascii?Q?JWsr5vezr148dtDt/ZOzF7rYFubfYDDKczhFtF0shnwamwhzTHP+cjtLppD9?=
 =?us-ascii?Q?a6Nft4lPZhDdN9R0h5D4v01GTN7u/C81ZtFOJ+6qH5x1PyXcvjC7+frf3SDK?=
 =?us-ascii?Q?ic0r65luWP5N7Nl6pohpUP438jPkCMAqQ7/wEj5cvdMAd3WEP4nOg47LT6H1?=
 =?us-ascii?Q?i9g9BfXDyP6dC/Ttnec53OluU/VwEggDHPdxKNY2FL89HBT07E3ObSk5+1TE?=
 =?us-ascii?Q?i2R1uirqRSOAg6IfupJfxiMBok5HERyBlDSuKkBtpLXwHFWw54zB+Z7l4dKy?=
 =?us-ascii?Q?TY5DoLjByMzJcSKIcuRy0CaMTrktRg0E/5Y4uFNrIVMOGqTXrtTgPrGbWanJ?=
 =?us-ascii?Q?nSWu9ShhwVFmkym+AC38ru53LWo/pA0R5bcoJwpxfMk2q2ueuh1sREz6pnmm?=
 =?us-ascii?Q?gy0bb/OJ6q2q94d9qysSycRUhKv2x+fOHek+Oc73Tt3I2sabSGENzimLhW27?=
 =?us-ascii?Q?CrOQLrd0bftlIHDD/leEIZHKOLyG5uy6z8Oiyig5HIJHf3ghMZtUZMaZrVbE?=
 =?us-ascii?Q?BgXYgvACD9kApAhISlLBD5twGiSdSHQTJ0GtGJb/NPhWoLHXdDvc6aBkio8j?=
 =?us-ascii?Q?VgN3CiWb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df05f9c0-3124-4b01-fde1-08d8c793ca99
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 16:01:24.4790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qtvFpkc2M7PA8CS3++hnnB9goclVqobwCd4D+Jamq5xYsRbi4YXDuWJ8RRGUkIEQAPvidd2dOAKCZS2DOrxpxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2647
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612281698; bh=hp3CvRRUSqFTEtxGpsLdIo0o9LpSkYXoiXCTZh0PRDQ=;
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
        b=XWLTXFuStxxVT9a5/Yf8Mp87COe9temh9jL95N6pW2LlC/UsjVNJhMHDW1gD6dejY
         7pUcz5VpzFAoPJen16VRI2iyO5t+2M6V8S8KVb2OkrxufhBx1XcQ0QPydEZS1gCiW7
         k0AE9HMfUscAetyb/rO4JC0CxF+64wb0D4W9U2cODeDa0IvSYTeQmOJ7CG/AFYxuzY
         GcwtNguKcQAOGa7Zr33qFjw6LTMwAnI7CSkDZs3He5qdGFSGFElZlA+8j9iOFrymbc
         uv/Z6W1cc9+adoxOz8XJqRMAIEl+Vpf5gpCyDh8EFuNTxTYmWwDFNN74kngut7QwTE
         /BGY7UC5seuZg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, February 2, 2021 8:51 PM
> >
> >  	xa_lock(&imr->implicit_children);
> > -	/*
> > -	 * Once the store to either xarray completes any error unwind has to
> > -	 * use synchronize_srcu(). Avoid this with xa_reserve()
> > -	 */
>=20
> It is not wrong to remove this comment, but why is it in this patch?
>=20
> Jason

Hi Leon,
Can you please check your tree, how this hunk got merged in this patch?
In my internal gerrit submission, I do not have this hunk.
May be somehow it got here as part of Yishai's ODP srcu patches?

