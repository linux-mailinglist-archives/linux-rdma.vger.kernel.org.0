Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C611DF5EF
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 21:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfJUTY6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 15:24:58 -0400
Received: from mail-eopbgr40046.outbound.protection.outlook.com ([40.107.4.46]:9499
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729406AbfJUTY6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 15:24:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfJ6wjHu7g425Q21cDn+cGxHfT5EuFjueq7gKzD7F2fzaDcW9DuvTl9TtZvE+xKYSwijELzbWzhqHP0dVeMlKzKDfN6hSEaoXthWiAE5MaETddI37Ybj8/EaL/b39O9s9UTM6hQFbE9xdvuHYrQdFhZ4Nx9SZ25NfdiTLLIgNv0JRLootQeRRoUcKVUUGQaknrVpN7xvajt9gFa7zUIoiMErau9TkfgXqQrjmjhcu377+AdyDD0D3Bi+uG5A+fSM/Rp44H7OB2pnREDhI21A9UZrmH+o0hGGcdSG6kuD4NrHe7g1yfA0sM0GAtwoZCTSNnERH7f0hdyV0fCCraF8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dhDTpAku16PKEX8QPygpkn/ME6Oi9YMZPMT/TaQauo=;
 b=GxnqFpLcoEONx91iTtrMK8N5/ltULyD8qscPxeMNv7+zc93YUoCAHzpKiFJZzkdCLxOx+AcJ/4YJQXAryhsqNJJC4yPY0a1uFYE82qJrjOLnC/YpkWYPK6K9SfTyHVpYON54dy/al+1qlTD9U2uYlFXZ9ModD8UDVGdFOlS8bOBH2ZqAh4HzGmUVLnvJrsEduR1R+gxdlJgoqbb+zWMQHzi0NzIrsCyzBwu5G57Zrw+WhRuPHltmjYWWv9GLA8ryYvbMvs+gQxDadzCIlezU+UfmaByRgPJGj4B2ihXFlThZxXYVe37wVBr4jFzfI5CoZ0R2ixZ4A5wAEK/gRallkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dhDTpAku16PKEX8QPygpkn/ME6Oi9YMZPMT/TaQauo=;
 b=gOHsp8Bw9gJpeplQWvLjcTwn11zwNNxnNNrfnnbbHmcDUbenZoid3kK0nyaCfucFf4Y6JvwOjOvi9QqnAP1bx4vEKuKnWJzoChKTWibUJUiot8VHF+pt3pp9c18E4uGZeqgJFEbWryKpSRZTN+7cJ5qFyxmTwShZVa3tjaOFuR8=
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com (52.135.129.16) by
 DB7PR05MB5659.eurprd05.prod.outlook.com (20.178.104.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Mon, 21 Oct 2019 19:24:54 +0000
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::18c2:3d9e:4f04:4043]) by DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::18c2:3d9e:4f04:4043%3]) with mapi id 15.20.2347.028; Mon, 21 Oct 2019
 19:24:54 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Jerome Glisse <jglisse@redhat.com>
CC:     Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH hmm 02/15] mm/mmu_notifier: add an interval tree notifier
Thread-Topic: [PATCH hmm 02/15] mm/mmu_notifier: add an interval tree notifier
Thread-Index: AQHVg4SuHCkuEaFxsk60wlfA7oiQWadldFEAgAAGi4CAAATrgIAAA5cA
Date:   Mon, 21 Oct 2019 19:24:53 +0000
Message-ID: <20191021192448.GK6285@mellanox.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-3-jgg@ziepe.ca> <20191021183056.GA3177@redhat.com>
 <20191021185421.GG6285@mellanox.com> <20191021191157.GA5208@redhat.com>
In-Reply-To: <20191021191157.GA5208@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0049.namprd02.prod.outlook.com
 (2603:10b6:207:3d::26) To DB7PR05MB4138.eurprd05.prod.outlook.com
 (2603:10a6:5:23::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04351a75-d219-4bc1-7c39-08d7565c5966
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB7PR05MB5659:
x-microsoft-antispam-prvs: <DB7PR05MB5659D6A6BC04F255885F9274CF690@DB7PR05MB5659.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(199004)(189003)(81166006)(3846002)(6116002)(6436002)(5660300002)(52116002)(229853002)(6246003)(256004)(14444005)(1076003)(6916009)(6486002)(99286004)(4326008)(86362001)(25786009)(6512007)(8676002)(8936002)(81156014)(7416002)(2616005)(7736002)(36756003)(305945005)(66066001)(54906003)(11346002)(386003)(71190400001)(316002)(71200400001)(14454004)(66946007)(66476007)(66556008)(64756008)(66446008)(33656002)(486006)(476003)(102836004)(26005)(2906002)(76176011)(478600001)(446003)(186003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB5659;H:DB7PR05MB4138.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uaW6dNXYv7f3Ty85RklRU7AQ9DISFCeTPUPObjm/eHP0KgJ9Wnx5A1Xir48dKXFwUS1rpcUMnUwf7IbAW0h1veKC7PvTf6TKFk1NUB+ctqzyQyqiviARQYhK73CGvjNnLrPb9OM8bzAfLvZ30osqKLlBvKNrjYWEqV5+rsU/Yd9saZkad70JWmq5m2CPkABL5/UJqqYd29y/m2GYOtvYuxc9xIryL4aDrvBvKr2tTtm8kNxUgSl8UGuaqzVwP3hoJxNaOrVGH/96MxQ9fEekO/YyglfwERt14UDx0iXFzPr6WrBnMiQszjNKFhvVYSBcGASexBAauvJeTGinow6SsqYmg8JzNtt7zspSXc5Qj7hbrZqXcPT8hv3b34HWa8JucVcjUJrvy0wUVc9r7kM4pdtdXhYDYVTtsjQCSvb2eNeqnGQ5dSelX/9AOadV3jGB
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0EDBBF2131C9044CB11AA3ED64A52B60@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04351a75-d219-4bc1-7c39-08d7565c5966
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 19:24:54.0488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sb3rhz5F375UQWwYODHTQPl9MFhe8HNVlx/hkgyRSMie0HtCOIpI0qlukbcHGu3V4ud7QdBEoTn05ZSsKuuFrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5659
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 21, 2019 at 03:11:57PM -0400, Jerome Glisse wrote:
> > Since that reader is not locked we need release semantics here to
> > ensure the unlocked reader sees a fully initinalized mmu_notifier_mm
> > structure when it observes the pointer.
>=20
> I thought the mm_take_all_locks() would have had a barrier and thus
> that you could not see mmu_notifier struct partialy initialized.=20

Not sure, usually a lock acquire doesn't have a store barrier?

Even if it did, we would still need some pairing read barrier..

> having the acquire/release as safety net does not hurt. Maybe add a
> comment about the struct initialization needing to be visible before
> pointer is set.

Is this clear?

         * release semantics on the initialization of the
         * mmu_notifier_mm's contents are provided for unlocked readers.
	 * acquire can only be used while holding the
         * mmgrab or mmget, and is safe because once created the
         * mmu_notififer_mm is not freed until the mm is destroyed.
         * Users holding the mmap_sem or one of the
	 * mm_take_all_locks() do not need to use acquire semantics.

It also helps explain why there is no locking around the other
readers, which has puzzled me in the past at least.

Jason
