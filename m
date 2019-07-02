Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55DA95D736
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jul 2019 21:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfGBTx2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jul 2019 15:53:28 -0400
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]:56897
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726457AbfGBTx2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Jul 2019 15:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ux79kayW2/oD3UIytvFEMfepSZQDjLhXcIU5Az4AZnY=;
 b=TzITFv+4DyhvRhIxaLQQBj41KHoDH5qvHNYfiLEhRPXbOsbprQQ4S62EFM+WOzO4Ty2BHdG2weYdRAMWeNzIdjud2VGBYREm2sDpStENTFwTmDcEJS8fTFsNf4Tgt7XVX1aKfj6z7thdXDGP/zqmlDm5A8gAIgPWFw3AVWI8+LM=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3407.eurprd05.prod.outlook.com (10.170.238.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 19:53:23 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 19:53:23 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [RFC] mm/hmm: pass mmu_notifier_range to
 sync_cpu_device_pagetables
Thread-Topic: [RFC] mm/hmm: pass mmu_notifier_range to
 sync_cpu_device_pagetables
Thread-Index: AQHVHY87cnj6rYaF00uB6DOqwK5J5aa35HaA
Date:   Tue, 2 Jul 2019 19:53:23 +0000
Message-ID: <20190702195317.GT31718@mellanox.com>
References: <20190608001452.7922-1-rcampbell@nvidia.com>
In-Reply-To: <20190608001452.7922-1-rcampbell@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::21) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91a8010a-9074-49f6-5f3f-08d6ff26f0c7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3407;
x-ms-traffictypediagnostic: VI1PR05MB3407:
x-microsoft-antispam-prvs: <VI1PR05MB3407FA9099031BFAF148D2AACFF80@VI1PR05MB3407.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(5660300002)(64756008)(99286004)(186003)(4326008)(14444005)(6116002)(446003)(486006)(3846002)(11346002)(256004)(2616005)(476003)(66556008)(66446008)(66066001)(66946007)(86362001)(478600001)(73956011)(66476007)(25786009)(33656002)(81166006)(81156014)(8676002)(71200400001)(36756003)(316002)(8936002)(68736007)(1076003)(14454004)(76176011)(2906002)(6486002)(7416002)(4744005)(102836004)(6506007)(229853002)(386003)(6246003)(6512007)(6436002)(305945005)(7736002)(71190400001)(53936002)(26005)(54906003)(110136005)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3407;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zBxzoHUx6jbzlZVkFi+e9m2ovvrNdaF57cJAmrQAUvgjIc6VJWidnpqjL4pG/tkQmzUsCr7Mq9zVT7UzNR3O2N6Nv3Yf/MjW7a8oJzadNJSd4AUiEHBtZblxxiz5C/sRvynk8tL8tF1ZsHnezKa/o5OlHLwVbKgTMd7q39KsEwv4ydwePbs9Y8eKhKkFEy9N8YSK5zOzEYuQ3WPQwt90wpHla8W8GVTj49LdyWlW5e5GCY25ZluCcCc8SgyivlZOwZBnf8sVRvyEWcEgiEAgpf2EWgFtDcmcZFb9DTMRqowHqVXg6D5JHn9S7KkpJJC9YoL0SDrfVxhT4n8w3YnRqkOLzq4t90pVh07KsDZm0QPQV6v+/qm3NtjE3lcMLAsAm5TiWNJVSJXEL1Q/bsj04Xqw5jdAWprPdD2oBSedE+E=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9EEF795A80FA1D4D8BB871FDEA45923F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a8010a-9074-49f6-5f3f-08d6ff26f0c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 19:53:23.5960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3407
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 07, 2019 at 05:14:52PM -0700, Ralph Campbell wrote:
> HMM defines its own struct hmm_update which is passed to the
> sync_cpu_device_pagetables() callback function. This is
> sufficient when the only action is to invalidate. However,
> a device may want to know the reason for the invalidation and
> be able to see the new permissions on a range, update device access
> rights or range statistics. Since sync_cpu_device_pagetables()
> can be called from try_to_unmap(), the mmap_sem may not be held
> and find_vma() is not safe to be called.
> Pass the struct mmu_notifier_range to sync_cpu_device_pagetables()
> to allow the full invalidation information to be used.
>=20
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>=20
> I'm sending this out now since we are updating many of the HMM APIs
> and I think it will be useful.

This make so much sense, I'd like to apply this in hmm.git, is there
any objection?

Jason
