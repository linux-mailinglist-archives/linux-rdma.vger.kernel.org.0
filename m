Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D546E37AF79
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 21:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhEKTlG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 15:41:06 -0400
Received: from mail-bn8nam08on2108.outbound.protection.outlook.com ([40.107.100.108]:52744
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232052AbhEKTlF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 15:41:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kta4zqi7RPivk1g3AGq4xhYLx62n0pANjWeWKqJn+vg3JLyVHRXwmv0GXOxElsiWkMsQF2Ds3+cgJw7kTcmRNrh1XdBeER3Raz3loWCPybZq1m/egHie4Hu7+1qLfffbZPupwTi6HL+Bi7ay/Qj69atkKymBiqFziSTDbSNR7ZDMpf2MzkowVqOfTO6myU0xE/Zrx5F3dojErQVxHV34zqJ/XyTevJ/RYrWCwuGQL0YDs1P474vxBiTP7ZGAzlsvw9pefR9WHPJzdUQjZUiffDDpUMOIaAMKXGpGlJJpBdE2Xim0GVogWE1tHKNanI+CFjpgfgfLdY5UIzyIbds/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhLL7lOTEXLC8n+Q/PYZ516cm3ZdZj2OnLsz6Ue75zM=;
 b=lDhN/g9s+6lOqVhaI4riNHX5l+lI6lOd/wEUmJV7BtNkyBaESlqPLKUyqmldfut3exGgEOIkjJ9+7d6hik76i3j44/DKY8/IFkpGTPd0XM4L/WBH54X+D0DSHtF1GmVzSsE1xDYs9n3isjY0hcvHuCJUYVTCOGWXWnmWNKtf8YdRlIcjDnOT4wXMCh0vJFHFKWCN7a/wjZXOboXh2gf9CFjGhbv2po9RNWT0UQfnT8i0NLdkmJHC1Lj4j//BqpWCOXef+GlEQvP3ZmMks48/yF6dr1wxkvGV3vrjWfqZt/a/eSDAVjx+DhQbERwqDCweKPhOmAbwSn4RAuThfEXsSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhLL7lOTEXLC8n+Q/PYZ516cm3ZdZj2OnLsz6Ue75zM=;
 b=Bpt2NFr+tYDDJ/M14bP5CAwtRPNFFsyUTeWO6BfJt1vRo818Y4aPtFpRRgyX2/aQyp3ezalCFkY2RnEQaR4ApfhgZVuNnRInV2/nDdJHP/IB61L7rpAoa59EADWbm+037HSLDKTyNHcBcu5KTu+BZ4O3JzvXvpB2vBY7/1odJ+IdU+6sCVbuafW1ezrKo4vS9BufuCOFcgHJfjD+9Y3PZ2yQ5o7QIPX9cfgfkGH5sIq2617d0tWdnAg9tlhJxkEAsYKHsjeeej9OAuyYjreu0EamhCbfwFCTvvuntegayVk3PSzVT0b3PtTgTJMob2IToJ2KbjvbQetBagRZn3UiSg==
Received: from BYAPR01MB3816.prod.exchangelabs.com (2603:10b6:a02:88::20) by
 BY5PR01MB5650.prod.exchangelabs.com (2603:10b6:a03:1ae::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25; Tue, 11 May 2021 19:39:54 +0000
Received: from BYAPR01MB3816.prod.exchangelabs.com
 ([fe80::d145:208f:691f:1ba4]) by BYAPR01MB3816.prod.exchangelabs.com
 ([fe80::d145:208f:691f:1ba4%6]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 19:39:54 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Haakon Bugge <haakon.bugge@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Thread-Topic: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Thread-Index: AQHXRlGKOHE6QFLZoEWMq90D8Um/dareHOYAgAAabACAAG80IIAABEcAgAAC8OA=
Date:   Tue, 11 May 2021 19:39:54 +0000
Message-ID: <BYAPR01MB381679B112EAD6B9B7379DB2F2539@BYAPR01MB3816.prod.exchangelabs.com>
References: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
 <F62CF3D3-E605-4CBA-B171-5BB98594C658@oracle.com> <YJp50nw6JD3ptVDp@unreal>
 <BYAPR01MB3816D1F9DC81BBB1FA5DF293F2539@BYAPR01MB3816.prod.exchangelabs.com>
 <YJrasoIGHQCq7QBD@unreal>
In-Reply-To: <YJrasoIGHQCq7QBD@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-originating-ip: [70.15.25.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b94fba9-839e-4d86-3a57-08d914b48d53
x-ms-traffictypediagnostic: BY5PR01MB5650:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR01MB5650927D130205A9DBDA38C9F2539@BY5PR01MB5650.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HLk0D3vs5lq09DjqZ6e9uuC14Eex5uGbwmf2dEWBAXo97vGOGRKFxF/8sDep6VzUbayVAiPUSJyOSbMtd3WnMqj4ZofuWakCTKUzEal/adoCJH47FLV+Ctv3EHgjazzTY2rnSkduJ1Yyxe+9HjviJ03j7Ak3OUIuZPvAIfSexPhA0KG+KwTKAqObZlc9XAbBm1JTuigkkzOY3LZIDQQ0kkDeSsqaz6ShZMSX8xA9SbFQe821ZdShJG2rZMsH+Ito3LFWsGgjalcImsrFM5Vr4c0OqdciT+8hstZof7xK352Gyoo7nzJyU94A7HMHupk/2adhFiBcfJPIygYszhYlZbMNWBNeiJDRnTRA/8AbmJsaEg/ESCfuh0WQMETWrVD61INPPCpZw83Le9/tPNAJ/jHH7no2up2K6Lszw1qtp2/28dxWPH0l4VGoFFJFq6cvGFICLec667dcQxyvBAtk3kPxZ5g3YNkpTvPP/AZ1tZe1nKHd9f2r+QPPfGy1gc3O3xhcI61vHkZCfZr9fmh+I2iMwXMMPTFCEugUknfNiiZqm6/YbHOb+gCD3t1vekEULoZ6sOhq1EvhFThzwl2SDaT8LCEqBJxYlLo1IMLYjRw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB3816.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39830400003)(366004)(136003)(6916009)(5660300002)(54906003)(122000001)(316002)(38100700002)(52536014)(26005)(66946007)(71200400001)(64756008)(66476007)(66556008)(33656002)(8676002)(7696005)(66446008)(2906002)(76116006)(86362001)(4744005)(55016002)(9686003)(478600001)(186003)(6506007)(8936002)(4326008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?eGYyx6PG3g0OvDZXLmI5wgPhdaFUE2FdFNj8w4OLEnNfPWRAnA3h1EM4ZHID?=
 =?us-ascii?Q?fCdu2Ew+XIIU09VNioGKV25v3d9g1bJfkZ5cyuZnm8y7wMpu1y4jDsZm4lQk?=
 =?us-ascii?Q?0YdhpSAcd7T/BtB5z+42V8swn+Ao/JZKS+YK8tcMFGVFZy0xV/6iXAKpC4uX?=
 =?us-ascii?Q?vLU4wf84mqM8PLlhxXDYIc1wQPOyO2L1ujPTQGb+3y2dH+6dgiFv68psxSmZ?=
 =?us-ascii?Q?M2uO3sgBdy0uy4EnKjZLkW8OAe1B8Re84nwsFABRoarwe+atDkTS9nyOF1AB?=
 =?us-ascii?Q?M8hMPr3Vqh8hqfWuAnb3y7mzdutPQ1gRjDwXj5V/E9gk6unWpEWC13lq3/i/?=
 =?us-ascii?Q?g1BBC0AYaidZOhfVZxxloP8hNjGdiWEPa4Q4vVz/pHsjAHwbWl8mchQPVlKU?=
 =?us-ascii?Q?jj1d5BQ/zwThPKR07ERNasJ2zwiL9lDN2uHOgV4kT6bAixjvhtMzwUvV96n0?=
 =?us-ascii?Q?PcJv2AOWLQwlotypIBPI//k1pzqT5d6DQhmhiV9894x4NIglZSDcHz76IGqX?=
 =?us-ascii?Q?mhKuB9Kx8iO7DkuXMfVd0TAb7gpDOgJ2/WrNlyJLXnP6Y7Lv5+7harb08lGB?=
 =?us-ascii?Q?K8+zP2Au/vOFYT0kQO/Xz+UF2DcN384iupRrkMPXOp6CiLNK1g4HumUpeCLI?=
 =?us-ascii?Q?9ydrZq9Zd1KvuzIy9xbHKp50bjpFsgxcZOsj6+AAs1DIeXHu1FseAeb8F8An?=
 =?us-ascii?Q?CDFufBuKJ9z/fWxRAdkdl/50mE+XHa5Z/E6ArEqavTjg4qBMtzDTCHXk1HL4?=
 =?us-ascii?Q?i536uiPOOSt2PWTCEADlfNeid7OPhSIZi1lo5LsydMxgumKwcmPOQzI+6MZr?=
 =?us-ascii?Q?vepeac3YjsfBdVEt1R7mdn/IrdZiL+4wb8LG5N8nw6ZZEdWfEiIsIQYtOLlA?=
 =?us-ascii?Q?rFiSfTMCJkqv/rMIuO+hMww5tVG6rKz8sT56gS29Wv+CI/SH8/RfrN24v1s3?=
 =?us-ascii?Q?PIvziPIf7Pq1PiRRWEk/NJqKpQIGjDg0HIZPyF1sGHq7PZMbFbV6BHGgLqlG?=
 =?us-ascii?Q?sfz2KOvtY1ObAehQ/c7YwecOJm+0jUkbIM2NhfQrh9Kmn9YmjKveobzZWb5r?=
 =?us-ascii?Q?R99iuvQIh8lZS4qMC9lSQmT7rBPlJHYfJ0pD7L+1P0ew5Tdi/y5A49TYq2uB?=
 =?us-ascii?Q?f2h7L+Emb52d+Z6Y/ReTAfu7tOAo6n/BL7p/hfGIfyrj7vtzHL26Mv+va8Au?=
 =?us-ascii?Q?dqdiBL7rXrrcZlYo/0wBCMNaOPlxcsO6B0uCPtVIA3mlYAcvDwrpHkFE1Spb?=
 =?us-ascii?Q?6eIwXMqF9RdW39PF7elk0yqRuP6hgr4rCKDZSvzzfrZTd1U5+jcHgadEaYcx?=
 =?us-ascii?Q?j4Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB3816.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b94fba9-839e-4d86-3a57-08d914b48d53
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 19:39:54.4887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gSnxTGNBqud+e08frYxd8O5KWaK0HhkDGRA185n+I1jtfpvjX2p1Lbsl6IrUTIRUEQcyRyrls8TgETX9smDH6lQQdjsa4jFStuLa72IrrMeQFKdjZHQmigXMKrP+E3Id
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR01MB5650
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>=20
> On Tue, May 11, 2021 at 07:15:09PM +0000, Marciniszyn, Mike wrote:
> > > >
> > > > Why not kzalloc_node() here?
> >
> > I agree here.
> >
> > Other allocations that have been promoted to the core have lost the nod=
e
> attribute in the allocation.
>=20
> Did you notice any performance degradation?
>=20

For the QP, we most certainly will.

In any case, the promotion should address not losing the node.

The allocation gets the ib_device, and it would seem to hard to add method =
of determining the node.

Mike
