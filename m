Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB6337AF2A
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 21:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhEKTQV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 15:16:21 -0400
Received: from mail-mw2nam08on2120.outbound.protection.outlook.com ([40.107.101.120]:51840
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231454AbhEKTQV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 15:16:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWwnV2rvIn1YRfDcsXPgc/SamKI6z1eDmuaFJRxU5W8ZQLphTF3Gl3o/MX0cBQUB3zC2QsgNixcYpCz1V2UU/TOtm30Be6BQKKfrzmVYGc2bztFtzwFqyPoI3xq+j2X2BkLsSyiEWC/+faflxdcoQ4gX9hkoZPzXrMHr4WSIFUhaL8j42uwbe1jF6mzeRKMT4P/xeq6L0qEF4u3t5kiauuHGPR25ykzqvlQsSbMEJgqZff20Wcn1T66oXwf+f5f93aPqLbfZhLUwVBJmg92nDs09DWkKCXGQdnZiZLWh4Uo18bPr/l0NOj3xFHwOTlr3ClmzzBLRZcCHHJW7k0s8fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08jqDY940hwffB+DY6lE3W5UMvjr5uO/NR547GLuunI=;
 b=gwOYL32FcFmgvDidqyGhUIPRyweJKHClqG/BzFB9ST6/NOIIt8zSk4v4TZ/8y0JoKuLuUojBYbHY6SCzR8UxmENfZx077cmz7Zm4cuFZlHKx7QZ6BhxGBNFyc0wd4EFe90RQ0NIZBuS3jBlDIwQECY+pEvlIPtYrrc80j02DuNJOrnbu8JzpS5qmc+9y96CwRN42+Ig/R0KW6gZK1f4XwyQpmPiOm/PvQYM5jBngIYGSywxOSh2pHjsQXd8p6jmrEN96DGOZwjopOGT5iluLtl7Vo6nlLcyw5DsWnGaz4OJLbiOnFyHxo2zt80URIFK4uWFaYUwn/6zXoXsO9jHS3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08jqDY940hwffB+DY6lE3W5UMvjr5uO/NR547GLuunI=;
 b=JLN+8lz0+IoYDycg1bvxBO/1bs8w7IwQ8xA7IJ4TZVvpDQcn6qcKnOahUTL8KWuXwkKYjCjyRCZAxx3ZKSb+c0+iel2Oe6n2Wt4dSi1VYOqzYd07etK8RN5p/rKAf0S5i6imjsYg8rGbLqu1W4ASHmgzvqgqQpStYLMFLeGkqsDBxm6M/yQRU7FJbi5qfHd9GL/0ICKlgCML7+U4c1+5l6sIQbD/6KXTgDY4wJcy9OiDn+uEV4R8k8qAxemJomXjycdwPfrypqNhJvUMcj0roI+K/ijCavb4zItRO835RqEgR8AGJX+LdPmBiYA8UvUJGiOSt+UaFd117bNUvP9eHQ==
Received: from BYAPR01MB3816.prod.exchangelabs.com (2603:10b6:a02:88::20) by
 BY5PR01MB5649.prod.exchangelabs.com (2603:10b6:a03:1a4::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25; Tue, 11 May 2021 19:15:10 +0000
Received: from BYAPR01MB3816.prod.exchangelabs.com
 ([fe80::d145:208f:691f:1ba4]) by BYAPR01MB3816.prod.exchangelabs.com
 ([fe80::d145:208f:691f:1ba4%6]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 19:15:10 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Haakon Bugge <haakon.bugge@oracle.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Thread-Topic: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Thread-Index: AQHXRlGKOHE6QFLZoEWMq90D8Um/dareHOYAgAAabACAAG80IA==
Date:   Tue, 11 May 2021 19:15:09 +0000
Message-ID: <BYAPR01MB3816D1F9DC81BBB1FA5DF293F2539@BYAPR01MB3816.prod.exchangelabs.com>
References: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
 <F62CF3D3-E605-4CBA-B171-5BB98594C658@oracle.com> <YJp50nw6JD3ptVDp@unreal>
In-Reply-To: <YJp50nw6JD3ptVDp@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-originating-ip: [70.15.25.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07123bbe-f825-4009-50a7-08d914b11865
x-ms-traffictypediagnostic: BY5PR01MB5649:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR01MB5649EBB3948A5B4A58A65CF6F2539@BY5PR01MB5649.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qCSdHOZWwRv3WmgZu7aIQJPDZG/uBX9isjg3+hu1xjpvnuaUDW1QLqUIWgfqwp4M2szBYQUTJDnSs0pdYSvmYTivD9QGm9yMo2MF1kFpD1icLQXyW6Q4LYzLkKXnEREih0SUch1AHCZolqx9u5AD+b1S9gAa7ziLjXAzRf2YPOIWqkWhslrqpqY81GKqtoYLHk8txwxxINqV/zemhPuoTScWFs4L1oOCtz5T+PFQjfSDMyNDG9vpqTZtA83kAB2tzma+WZ3ltQbtPJo52f5hLd+vkhTZ9sLqhC6AKvDFyhffmKvPaUg8Go8E4j41rwHk0UE8lxq5Q/DsqKQ1PO6szk8Mdg6G8bA5/E8rBfW+L5cgkf4fRf0LvuvkI3mbnDM7409yT90fhf1aQzzswaHypughPqm2YlraA5Hz+74ykk4/9cepzKW7+dssq9oxMMRtrbfOJaDVfUOAIg1glDgVF/a3BFWd6XewUOphg3a9M9j2DFxlksN8Z2/VfxQY8XmL51/BDAt6ce3x3Q1EqsvMyekyJ/iucX1JhvISDTRgRDXV9ZzXNYsmdxzA5P5uXMcvwHhyDxhSOQ7OaYIhZaqi5dZASLHtCARjyrrcJ8tMWwU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB3816.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39840400004)(346002)(396003)(376002)(366004)(8676002)(54906003)(110136005)(55016002)(316002)(9686003)(478600001)(186003)(4744005)(2906002)(4326008)(52536014)(6506007)(7696005)(8936002)(26005)(5660300002)(76116006)(122000001)(38100700002)(86362001)(33656002)(64756008)(71200400001)(66446008)(66556008)(66946007)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yw0irdRry1WFLqxmvIiZSG3glNZ69W0zUgZ7IW4xNte3Jf/h0fca0ves7URA?=
 =?us-ascii?Q?3j01TdMcw2exkv1J927GoyA3Tb2xjFXbtrQU3IBkGmwxMrHJmYGN3dED8e7V?=
 =?us-ascii?Q?wEeI/8IXAU1k52iRTZlemtYVbcR45Veu6hdmdVHOaS2lkITTdtIBFeco0MUP?=
 =?us-ascii?Q?5YbKKXdH0ax6FlvpA75kPEqgFCRlgjQ90Q/vTYfmei2JzVa7lsJ9d4CPBXW5?=
 =?us-ascii?Q?Ci3fcagB6VhkSrYT7tZ/BM5ehsqLbgMRE7kaYw9eixQ09BNVWZXer0s+w0Tb?=
 =?us-ascii?Q?kgcbbqhLkWAkC0uIEKuLLZpexxj7puZhy4Qr5XGA/y7CMh5ty4Xu+gQV6rIf?=
 =?us-ascii?Q?azv23vlhI65Lm7rN49h04088oEoUAo1lI0yS/6DUkjC7DELA1z7zByq7ePlR?=
 =?us-ascii?Q?jSddAXBWDBJ/g4WuXdFneUJYi6LaqmWrYo0mL3e/Ah7G9Qe0EMmy1F+lW2wk?=
 =?us-ascii?Q?GQLbgvbpZT5GkUQRamEJ+3Rxt8b+loavAEU85omTe4e8tTjEFfjth321/X8Z?=
 =?us-ascii?Q?65hOz0c+85v/CvNqmN83yHg5Z4WV6J4UunapzFJ+A4gS5eZrSxwK/9VVQWmR?=
 =?us-ascii?Q?Ew3UmLO0INBXSU2dZG9tY9PpMyQMmv2uUE6dWowd7srBmp6oLkEas36FGTqm?=
 =?us-ascii?Q?oQ1ZgaLMd70eHsf+cQoGvglErHDMB8gSYaEs+32telyYYUA3vy0CtqoMZpqY?=
 =?us-ascii?Q?esI5B8XUT9qVMVEKWWGMFJ+xxhURK5ZlTeHLJTMtyeLICxHM7UfD3MZYcxaK?=
 =?us-ascii?Q?qqGy32qoLvv9P/2oi0O0WTYPUSUua1VwV9O77cZ0RhxO/5kal0EGHoRcsvpX?=
 =?us-ascii?Q?abHcnN4V+g7XfgEunTcThSCXFH4elP+8xmPwXIWl00U2a9jMnhrppXoIyT32?=
 =?us-ascii?Q?M+uJw0e/O3RuHwXvtfFzIsqiOede7yvTWBzOjwhWVzbSNMLI6o4oVYlhJG+P?=
 =?us-ascii?Q?BKVrXy2OHB4LOqki2UM7iCyNmBUwwj/vqfmc2T8NH9EL6nRdMabDjc2kvFFY?=
 =?us-ascii?Q?adV9Wr24603Mfdyz0j8Zfbj+iG7BzJYAtkl09TlV5/Lb7NXhFhxmzvfsktvc?=
 =?us-ascii?Q?laKMt+BGyvtYRXiTjsVMMkloc/nTT0HK3BmG4fePI5ELPiGC2wQDGdcukymx?=
 =?us-ascii?Q?R/i5jP0wT5SyC9nGCLZBidVH0KBVmNpyKVzm8Ww9ifi2uGNdbgaLRSahS9Vb?=
 =?us-ascii?Q?xLGRZvKY3mI8c0gnZKeVYy9KTJQWzja76CQt2DQzh8hIAG524ZquDeH/HRpC?=
 =?us-ascii?Q?spMDo21m4PN9eoV+djmoSQzaQuCGawEbBjySk1u+JmJ8HyNnNK2tqemX44au?=
 =?us-ascii?Q?Egw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB3816.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07123bbe-f825-4009-50a7-08d914b11865
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 19:15:09.7057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0qW32sDGl46Wp4YbP4p7DEROsvQX94nf6vVza+SaenKQQs1bqr2kWFimIgMwJLytYW8wTMtWwtNkpfQTfuyMc+m8LYocbDg2fXqd5qeLN/h0A73P4K9idZ1CIMvlh6KZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR01MB5649
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> >
> > Why not kzalloc_node() here?

I agree here.

Other allocations that have been promoted to the core have lost the node at=
tribute in the allocation.

For the rdmavt based drivers and especially with the QP, there are performa=
nce implications.

I have no issue moving the allocation, as long as the node centric allocati=
on is preserved.

I will test the patch to make sure there is nothing else lurking.

Mike
=20


