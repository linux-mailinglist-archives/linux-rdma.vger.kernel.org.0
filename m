Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F827350D79
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 06:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhDAEJH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 00:09:07 -0400
Received: from mail-dm6nam10on2065.outbound.protection.outlook.com ([40.107.93.65]:59744
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229476AbhDAEIj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Apr 2021 00:08:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mrf+lLcm6mM6mboSFiZ8LuX8Enhp934N/O8KgNF2aBE5NIz2NkyMKBHWVAuuABCmDhjTO05VlvA58swNq1gA/HO3uhmbJ9Mgz5oGwPrNw3n9Zg9ol9uZGOWKpa7XkF3S6zJLH9AS63dnncFPhuwInu0VonYHUQL4OXYNnZJrhAx5/A7QHoaUaVNVIBHw1Yk8AjOTaP07auBPI1XB356mrPra+Bb5eWd+LmYeAvOFoPAmyJouqK7gBPHt+XffMjiuRabvu4ftzCbCSmoBCHt2Aa5V0mZPTjXAXsARmPWkN9rDbeO8ax++5w5YAd3EiS7nhw0out+CNjSL2/QVtclwJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkYw5P47j+aXMH4hjjPAYE+gqMHyl4TL4HGtBR2y+0E=;
 b=fAqUM9t1+g8dypJKvpOx3tmrHcEU8WuMkfN40sZsQ/rtbmrErweiyDOV6F+9FpQSjstSQMch4bzg+G/2qUoj5tdTq5MPBBDKWs8gRZPlgbmTOUP1QPT+2AnAekBN0VXr5NtmPdstIQ3ZDSgERt38SWswxY/+j1imVyQW7iyCPSeQf6kPegsYBcMqVDVPAuy/6/8Vlg+y/DmlW2sE77S9P4H8OeWqq4CUREoLuF1hZat7nvxjC9aYDdRt8b9qHrqcvwjx02jNoxs48FHJjBwK6sp6MVglg9DCxyM1Yu08dOxKW166MUoktdrCy6Px3+HeC7rBCW2FgQgVh/A3ry15Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkYw5P47j+aXMH4hjjPAYE+gqMHyl4TL4HGtBR2y+0E=;
 b=K069wp/VOWDxTw0O8hlMd0ebMdSznJ8T+MwDaBgOg6jDA+d35a/84qFTzshfRFLGO92bsW9j/G6LVehhDXOur7kjLHuV/cGWkTkvAi/dcf5zTIGpZFNJN6DBHaMEKafA6epxSMshh6cOSW3T2Hd4PAypEm2Nh4h8WGciZYiCzMxsfnKgOWgae95Q2ianesRaSUVIsd0WbFmxizHVIrntm6V3b/1NKWYdRbbgDS+46oRdiLlafwWoVI4EVMzKGx/KoccmHlNFmVnn7GmjdUmLsAWU7PNqFZWZY2zXVbOKr1E2qtyEOu0Nde/9H5Gq9zasDw8veQ/4cjcchC8+5X5l4g==
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BY5PR12MB4227.namprd12.prod.outlook.com (2603:10b6:a03:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 1 Apr
 2021 04:08:17 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::7cec:a7fa:db2e:3073]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::7cec:a7fa:db2e:3073%8]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 04:08:17 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Haakon Bugge <haakon.bugge@oracle.com>
CC:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Thread-Topic: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Thread-Index: AQHXIXfBOPltPxqzRUWWuvVXWh57HaqdMUWAgAC/pQCAABcXgIAAEDWAgAAErYCAAAU4AIAAAFYAgAAUwgCAACZI8IAAB/8AgAAA5QCAAAAwAIAAAckAgAABSQCAAKcPsA==
Date:   Thu, 1 Apr 2021 04:08:17 +0000
Message-ID: <BY5PR12MB432252F6A0FF1702E1937F89DC7B9@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <2A5F5B02-4745-4EC1-974A-DE089F9FBE2C@oracle.com>
 <20210331131525.GH1463678@nvidia.com>
 <111062EB-22A4-4AE3-A31B-498445D344A7@oracle.com>
 <20210331133518.GJ1463678@nvidia.com>
 <E76F07B9-F222-4D0E-889A-712502DE0376@oracle.com>
 <BY5PR12MB4322EB01D0A22E6806B6F195DC7C9@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20210331173514.GO1463678@nvidia.com>
 <2BA07D00-E144-4547-8F7F-77DB0C197706@oracle.com>
 <20210331173906.GP1463678@nvidia.com>
 <C55F49E9-900D-43F5-9430-E62249B801E4@oracle.com>
 <20210331175006.GQ1463678@nvidia.com>
In-Reply-To: <20210331175006.GQ1463678@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [136.185.184.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95ae137b-ecb7-4f0f-e5f7-08d8f4c3c78e
x-ms-traffictypediagnostic: BY5PR12MB4227:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB42279A41A2C5B4F801D7486DDC7B9@BY5PR12MB4227.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uweXulPb0WOQf+3sLznfTqnuW/lagatAf9Qt8HfYVQr4zaCVvemWli+IFFL/4gCztztruyzBe0/aEVx62IIXXGrgTLl77dqjsE/JRcv/rRbm7SmmKHbxFtySQUGKOd41ItSxTNuG7orIEiSDnmSZXF0sH0WcdgC9FNCJIZmFb7eHnT9JmA492MS7sapmzrV9ASHoRRn+RofsFRKDsjz3ZuE/eP8QnYK2L6czRx38B+q68/PhseUeIV+4LvgBR03xsnCcuSREZnBJuA64RVn2PrJ9BIWGpUjQw8wclxcaIl7oP82zmlzsswn6eOnvOXSq3/8oq/CK99wrIbHIpbefHhHEYMip9jmi2xVXWQK8DLQ1GOI/1QXQmYWikh4Rd5K9gZHLOSiOcLDY1laRcGxIuVmz9HcwArgNVR9tdJrhpq50zHXe9dPp9cvgWUSYmV+tKOreBxOU10X1YAQsilub0nFDC5yg4pFTSNIOZ6uOXbs+h/3zYdZN2/gFFJbxcb5junjR2WE6t+BMZLpweO613WxRzrY0EtAAuhP0NPFWwD1g+jBP+djSrEdXxUMZ0lGRw31JkqjaCr7wQJ7zG0fJSuxU2o5oBBljN4Ie0aE4zgRTtjYM4dia6RwXovk4pOa/7OFdbxsdTkiJcIhVMNWJSEKIt+zEMr97ysjgdavux+I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4322.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(8936002)(86362001)(478600001)(54906003)(33656002)(26005)(38100700001)(66556008)(66476007)(64756008)(66946007)(9686003)(66446008)(316002)(55016002)(7696005)(5660300002)(2906002)(4326008)(6506007)(52536014)(71200400001)(110136005)(76116006)(8676002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VoXQziBllHCRefuVPiQZi8FBiWULGq42pkwXkfThlzZfFP9VO5pCACpyrdVC?=
 =?us-ascii?Q?0QPrwHjQqAmvGZMCBStIWK3mMRuLJ8HEEPO6fxDqrhmBwoNtQnWy2WZNgczR?=
 =?us-ascii?Q?siPHVWaNUghrf41Y32ZqiNRUajYUrMqP1IZmeG7aNdxvxxN1VZWw4neEPwUL?=
 =?us-ascii?Q?8DpffXcGYMksleXszXmKjaxO6/o2x+OGWFO4jjJRmtVceoIwbJ56BcqsWyhi?=
 =?us-ascii?Q?YGVaK83ypRZ2DgS4neNMJLCFaM/X3p1OVqYr5RQwQCUpzk7GJEeSc35RpmwK?=
 =?us-ascii?Q?mwfRe2+bfUSaB+9PAJVw0AXKDT4y3y88BpxQv92T/FhijENk6B7UR1V2/9Aa?=
 =?us-ascii?Q?JYpKZvK5OFQfOnm7mtaBqVsvsWPckM1UW6w1fWr7x7e4hYWbwqgeqKkDAsWK?=
 =?us-ascii?Q?Zyjq1p8nq2ywm0EWENBUOuwlwTwrM7jXyrNnkOo4irbXrElU5ysrYDRh94Cl?=
 =?us-ascii?Q?nIiR5S8TL7gE/ntMfHHaUZTGjO2SKOQ5mQl4UL3D9bjEEJTPRiPhm6SvfQ6s?=
 =?us-ascii?Q?tniS/kQJhAWz5OV90w7o68gosfkJhv2aPjSQL7vJ4T3EWYOat9gOSZX9lOU8?=
 =?us-ascii?Q?oWRZPVTNGaj6nx/zhz6PCbQC3b1YBXVvzmd9WMoWvgIwCwGEaHcDE8ZFJ3fs?=
 =?us-ascii?Q?yrfqwfL9EBTnFPfttACk7Wiwqgkv0JCg0xuw2T9sjOFm7kBmaBou2w6BruLX?=
 =?us-ascii?Q?visMIaTcZUPPEL3PcnxNAvI29cmp9HUM82afHzmZPJbsLXXVn3n83Ngrk3qc?=
 =?us-ascii?Q?gs9XQH9kgYBB4Ema8I3WfYr2B+n1AmrWJwPIt6IjyCHEBqsmdsU8cmapfB2b?=
 =?us-ascii?Q?LmMpHs2iFVPOR1rqdyyGFrIMuyoXSrSrrwhpuN7Ex/dj6FxCkxIReam2MOD9?=
 =?us-ascii?Q?MlVyUjKI7WOSINQNl2VSDXdYBHG+k4hDuMRm11FZ0VMBKGQRtEG5coIYfDya?=
 =?us-ascii?Q?tegWiHDycGyfdpn92ioZ/f3n39SUhGW54cG6rgXrl74Ibd4JMZ4DxP7fWnSH?=
 =?us-ascii?Q?SJWMUWW42NH4Fj00IgMqE9L6NveDmMx6XouS4EhjJ+C0rlNKPJFteoJ7TqJF?=
 =?us-ascii?Q?0H7T42haDNugMZ+AannxQTS3VSw90t4SRUpo2RL33WeSaoRb2wh2SBNt0gAY?=
 =?us-ascii?Q?Z5CxeAEfDcix5gu3E1rmIB4IuT3Clf27188LyHqQkm4MeO2T9tddIh+W7yWR?=
 =?us-ascii?Q?9EPemxTA7s6/qaDnU9Oio5X+ppS1b2EIhhJ0TAKpuamOGgxxy87RLDnJlUEe?=
 =?us-ascii?Q?XDEO2oVUd1n07aPAcUAzEthK+eyTuxD1MoqYowhAV1Fx2N2SNtWZgbPS/OXJ?=
 =?us-ascii?Q?7sQw2c7vf5uE4Uz1SitTS6v/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ae137b-ecb7-4f0f-e5f7-08d8f4c3c78e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 04:08:17.5033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HXZmVxQIFAXBCZpbIVJIkuvWL6aluIpBOsWPKzp/CDUEjO/S97AioK48HvC3PqUOldApm3VgAJRSZplXRkBTGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4227
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, March 31, 2021 11:20 PM
>=20
> On Wed, Mar 31, 2021 at 05:45:30PM +0000, Haakon Bugge wrote:
>=20
> > True. Local ACK Timeout is part of CM REQ. But that makes
> > 2c1619edef61 ("IB/cma: Define option to set ack timeout and pack
> > tos_set") fuzzy, as it claims in the commentary: "The timeout will
> > affect the local side of the QP, it is not negotiated with remote side
> > ..."
>=20
> Hmm, is it intended to replace the CM provided local ack timeout on the
> responder side?
>=20
> It doesn't look like it copied into the MAD though, and the qp_attr->time=
out
> only looks like it is et for the IB_QPT_XRC_TGT case??
>
> Very confusing indeed. Parav?
It is copied in core/cm.c at CM_REQ_PRIMARY_LOCAL_ACK_TIMEOUT in cm_format_=
req() with consideration of primary path packet_life_time.
Primary path packet lifetime is filled from cm_id.timeout -> path_rec.packe=
t_life_time.

Comment says its not negotiated, because spec doesn't mandate to honor this=
 value on passive side.
And connection doesn't fail if passive side doesn't like. So it's not negot=
iated.
But it indicates what ack timeout (and retries) to expect for a connection =
when one looks at the connection trace in wireshark.
=20
