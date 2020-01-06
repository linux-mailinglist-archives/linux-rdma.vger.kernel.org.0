Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A118131443
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2020 16:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgAFPBb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jan 2020 10:01:31 -0500
Received: from mail-eopbgr30083.outbound.protection.outlook.com ([40.107.3.83]:13558
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726454AbgAFPBa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jan 2020 10:01:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZT/JYj1NpfkFPk1OBMCDfT6oq+keklaBVyOZHSRgF/rhqgasFnzTPf1t+c1mpJ8cILYRNVugQXi1KZu3VBJfe4d+bj79VKHyKxjG1DeTkXYZ6jwzJm4YVSXnVSFR2fd47YUJeiaQlg2uU3bdBl40061J5F43DGSSBtvZlzzKII3Wt/XS/VnwdbYiANfxKRGzPlXNhijolW9LD/o69CNbMFFgjt15EOdF0zDF8U41cWwJyP61nhEpGgZmWcIHX3HLxX0Jr4t06+5KLBWeABCo/gTHY2J6TmOeK1Rt/0LeeUWA8mGV/OyQulT8RJfFzetyAxCVNn2pK8wmOr35zF6rOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpPlhSItyv8lUBFXYX+9IBCeKAs0zbTBx2hyagEuvvI=;
 b=OC5D5BOaMuCGobSIlieQbwUkOWmXhySA69JMmm8mZbRF9R9tkIGtjrrFnXGg5h/9IHon15G45tP08AIuoMvbsmbRdlFi472U8V0Ryws20NT6Qt1+pmfUIqPewISY8dIw2QBWvysg930KiRFOAP/yDG4DWwx24ZSzKhWt6llv5gsyjhEzaWEaGSs5Y4jyerjgn+erCUAag+VxqWUonLbJJMZXAwQmU5qsXrLIIdSN+hleSf4loZaLWAyuseD6nJT0pG97HzyTqRy7zXLuu9fZnFWIfwWikJ6qFN/sMdJkSUDntzYKUJ4leTsufwK0CbUFCrGGzz3aiqaAPIJIv8WD7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpPlhSItyv8lUBFXYX+9IBCeKAs0zbTBx2hyagEuvvI=;
 b=CkIhB/a7k1fZQOYX+Pjr/LQPqTemqNx0JBRN737kGS+5k/E2ve0NvjPDRvIB7swowSterVRjTA652XfWpqujiIlRgS7RzLEmn2pbOJ8aEQkxDTadd29SjcDQdSqnWzO+SblTULmfjPHHMPKDK1h2TraolbaPULh9NQEES0mtAD0=
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com (10.175.21.136) by
 VI1PR0502MB2989.eurprd05.prod.outlook.com (10.175.21.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Mon, 6 Jan 2020 15:01:28 +0000
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427]) by VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427%5]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 15:01:28 +0000
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (94.188.199.18) by AM4PR07CA0007.eurprd07.prod.outlook.com (2603:10a6:205:1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.4 via Frontend Transport; Mon, 6 Jan 2020 15:01:26 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>,
        Edward Srouji <edwards@mellanox.com>
Subject: [PATCH rdma-core 1/2] pyverbs: Handle CQ events properly
Thread-Topic: [PATCH rdma-core 1/2] pyverbs: Handle CQ events properly
Thread-Index: AQHVxKIrIvPWdayUhEuA24hxQo/k8Q==
Date:   Mon, 6 Jan 2020 15:01:28 +0000
Message-ID: <20200106150115.14746-2-noaos@mellanox.com>
References: <20200106150115.14746-1-noaos@mellanox.com>
In-Reply-To: <20200106150115.14746-1-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: AM4PR07CA0007.eurprd07.prod.outlook.com
 (2603:10a6:205:1::20) To VI1PR0502MB3006.eurprd05.prod.outlook.com
 (2603:10a6:800:b2::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.188.199.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d7592b80-93de-4553-5e5f-08d792b94e4e
x-ms-traffictypediagnostic: VI1PR0502MB2989:|VI1PR0502MB2989:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB2989A5C0ADA7F2112CC7A3D9D93C0@VI1PR0502MB2989.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(52116002)(71200400001)(6486002)(2906002)(2616005)(956004)(1076003)(66556008)(64756008)(66946007)(66476007)(26005)(81166006)(6636002)(186003)(16526019)(81156014)(66446008)(86362001)(8676002)(6506007)(8936002)(316002)(110136005)(54906003)(6512007)(478600001)(4326008)(107886003)(36756003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB2989;H:VI1PR0502MB3006.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2QNgRVxM6Gy/6J+yQ5XzfOUEpm/NKkDMoEks8/mvAo2OmxZv534x8yuYJrJUErCuJmlJr1CHP7r8fCNGy6wUv9wDvatVv/K6loUJKG4Cbxq3UDkdiqzm68hPwsbLct9BkLogi5ccWKoyDeL8fD2tM83lcrOhhjdfKvP8yrJ0AcgPGu87P7KyPjEYgFnjoLeIWJ6X9shwHxiBQn/CxtovSs0mxnGnMjy85Y7yARN2Co9Y9/0G4FhKId5zsfHIpm6A+657ze0Ifeve4NJIIdVlZN0sid0InqrEHEEtRli6NE1tBZKqD1V0EEkaOZ+3EB2JhRqqM8ap3psjoViiqKbpxGi8KZ4VCbmjD98zhSSrQAXGKiNpPJm30VpNbkhkvOjCmDzXD/zSvWFl7UIz+aN44698RoaXYUfB8GE2fGLNE/KOJ7mHuU7autBJ8lTAd1jw
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7592b80-93de-4553-5e5f-08d792b94e4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 15:01:28.1186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HDZlM4FG4pfQD5FmHctzbttMp5FeJL9+CFa6iCSPd8gy7LItijz/K3dTVx0gOQLTqNyHoqYBoplqyrrWD00GVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2989
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When using events, the CQ has to ack all the retrieved events prior to
destruction. Since this call uses a mutex, the events are usually acked
together at the end of the datapath to avoid performance degradation.

In Python, each exception triggers a teardown of all pyverbs' resources,
including CQs (which may haven't acked their events yet). Exception can
be caused by something as trivial as a syntax error.

To avoid that, let CQ object keep track of the number of events waiting
to be acked. This number will be incremented by the completion channel
during get_cq_event() and decremented by the CQ during ack_events().
During close(), if there are still events waiting to be acked, the CQ
will ack them prior to its destruction.

Also add a reference from a CQ object to its completion channel object
to allow users to know if it is connected to one or not during poll.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Reviewed-by: Edward Srouji <edwards@mellanox.com>
---
 pyverbs/cq.pxd |  2 ++
 pyverbs/cq.pyx | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/pyverbs/cq.pxd b/pyverbs/cq.pxd
index 8eeb2e1fd0c2..9704b96f3ff7 100644
--- a/pyverbs/cq.pxd
+++ b/pyverbs/cq.pxd
@@ -20,6 +20,8 @@ cdef class CQ(PyverbsCM):
     cdef add_ref(self, obj)
     cdef object qps
     cdef object srqs
+    cdef object channel
+    cdef object num_events
=20
 cdef class CqInitAttrEx(PyverbsObject):
     cdef v.ibv_cq_init_attr_ex attr
diff --git a/pyverbs/cq.pyx b/pyverbs/cq.pyx
index dda47207507f..defb37646034 100755
--- a/pyverbs/cq.pyx
+++ b/pyverbs/cq.pyx
@@ -47,7 +47,7 @@ cdef class CompChannel(PyverbsCM):
     def get_cq_event(self, CQ expected_cq):
         """
         Waits for the next completion event in the completion event channe=
l
-        :param expected_cq: The CQ that got the event
+        :param expected_cq: The CQ that is expected to get the event
         :return: None
         """
         cdef v.ibv_cq *cq
@@ -58,6 +58,7 @@ cdef class CompChannel(PyverbsCM):
             raise PyverbsRDMAErrno('Failed to get CQ event')
         if cq !=3D expected_cq.cq:
             raise PyverbsRDMAErrno('Received event on an unexpected CQ')
+        expected_cq.num_events +=3D 1
=20
     cdef add_ref(self, obj):
         if isinstance(obj, CQ) or isinstance(obj, CQEX):
@@ -87,15 +88,18 @@ cdef class CQ(PyverbsCM):
             self.cq =3D v.ibv_create_cq(context.context, cqe, <void*>cq_co=
ntext,
                                       channel.cc, comp_vector)
             channel.add_ref(self)
+            self.channel =3D channel
         else:
             self.cq =3D v.ibv_create_cq(context.context, cqe, <void*>cq_co=
ntext,
                                       NULL, comp_vector)
+            self.channel =3D None
         if self.cq =3D=3D NULL:
             raise PyverbsRDMAErrno('Failed to create a CQ')
         self.context =3D context
         context.add_ref(self)
         self.qps =3D weakref.WeakSet()
         self.srqs =3D weakref.WeakSet()
+        self.num_events =3D 0
         self.logger.debug('Created a CQ')
=20
     cdef add_ref(self, obj):
@@ -112,12 +116,15 @@ cdef class CQ(PyverbsCM):
     cpdef close(self):
         self.logger.debug('Closing CQ')
         close_weakrefs([self.qps, self.srqs])
+        if self.num_events:
+            self.ack_events(self.num_events)
         if self.cq !=3D NULL:
             rc =3D v.ibv_destroy_cq(self.cq)
             if rc !=3D 0:
                 raise PyverbsRDMAErrno('Failed to close CQ')
             self.cq =3D NULL
             self.context =3D None
+            self.channel =3D None
=20
     def poll(self, num_entries=3D1):
         """
@@ -166,6 +173,7 @@ cdef class CQ(PyverbsCM):
         :return: None
         """
         v.ibv_ack_cq_events(self.cq, num_events)
+        self.num_events -=3D num_events
=20
     def __str__(self):
         print_format =3D '{:22}: {:<20}\n'
@@ -173,6 +181,10 @@ cdef class CQ(PyverbsCM):
                print_format.format('Handle', self.cq.handle) +\
                print_format.format('CQEs', self.cq.cqe)
=20
+    @property
+    def comp_channel(self):
+        return self.channel
+
=20
 cdef class CqInitAttrEx(PyverbsObject):
     def __init__(self, cqe =3D 100, CompChannel channel =3D None, comp_vec=
tor =3D 0,
--=20
2.21.0

