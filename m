Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D06EEDCAE
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2019 11:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfKDKhl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Nov 2019 05:37:41 -0500
Received: from mail-eopbgr150084.outbound.protection.outlook.com ([40.107.15.84]:57608
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727607AbfKDKhl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 Nov 2019 05:37:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8hzf62OHq/aFpDpyhGmcbhunahITTB41kXNtwuY1IeE4SN7W1/AES6XpF519r7PAFFC4mgpzXZZ8U2pIsLgr+bJvarFrNp5zrjzsecQ8N+UnxpT8NIrwlIU7/xVECjbB0l6grHLfC0A2paAM3g44MqF6LE+DXqR5CpXz4GQ+8Y7OMT3FpLKQynRiaQgFAhVieRm6QmezbOQIzmvwC95jZy3M3UepIolls2AuCRnaILFpk/JfIGwkjPho/kjhiQ7951gxyBPrttz66U25b1p6F8tW1bcpgYbvKkD27x3mD9rXFWjbrxF55r1OOsRz0ogNbeHA3YnzhSXwW7GZ6LddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7UfGriFTAUpm6pFcszGpfsvPF8JRRSFehvliyo4i78=;
 b=T5GdW095+yw9al8JaK3U+0WiRsgIuYm3nbEzbIeKjhSg89yfQpuvaS2rEZNZVxtwYZWQ1zJaXlZ7f+2gWN3qKCGqFKcOmDx8dRgP21tgrWvXWg6MbRXjU96WWE7h8GC9UjucjrjPYOQJe/0ELiKtHUdbL87/j6eukyLaNzDixSTuV7Iu/XqiqadfiqEC+rOIbqJngriHp15UkB/l0ERbWePE7cEXUkdiQaFuJxcsblowxfZNgFOUekXNRmZBMcIAuEmnxJyzMUk71RSfoyOB5mB072LnGAHmUdNjx/bbRy4zoDXUyyKrFJcW0slu6vpQHUz9G5bKbr1atCiv0yhF8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7UfGriFTAUpm6pFcszGpfsvPF8JRRSFehvliyo4i78=;
 b=MZ9cf7pCdlKITQ3/VKWgBCbhv641QDeGqoGh7sRVNTlf8bZ4Jtc/Ku4mzKdGDPJy1W5D8QXYzQbgWftQied7Ij0xzV8ezq2B38jDzTWPrzkI+lykAk1QmEVoCP6H+FnXIrpcRy2bNEOQp3drvVwDTcADqH+fgvYqWQzOWRXdytc=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB6232.eurprd05.prod.outlook.com (20.178.86.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 10:37:25 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::505f:e3f8:3f87:e3ff%7]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 10:37:25 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Maxim Chicherin <maximc@mellanox.com>
Subject: [PATCH rdma-core 1/5] pyverbs: New CMID class
Thread-Topic: [PATCH rdma-core 1/5] pyverbs: New CMID class
Thread-Index: AQHVkvvZHP5KdRGueUG13fK/Rqs68Q==
Date:   Mon, 4 Nov 2019 10:37:25 +0000
Message-ID: <20191104103710.11196-2-noaos@mellanox.com>
References: <20191104103710.11196-1-noaos@mellanox.com>
In-Reply-To: <20191104103710.11196-1-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: AM4PR0701CA0039.eurprd07.prod.outlook.com
 (2603:10a6:200:42::49) To AM6PR05MB4968.eurprd05.prod.outlook.com
 (2603:10a6:20b:4::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.188.199.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a86264b-3d2c-446d-bd43-08d76112fba2
x-ms-traffictypediagnostic: AM6PR05MB6232:|AM6PR05MB6232:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB6232BCFD77F8DC37C198D9BBD97F0@AM6PR05MB6232.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(199004)(189003)(25786009)(8676002)(2501003)(66066001)(386003)(6506007)(71200400001)(71190400001)(99286004)(11346002)(6436002)(8936002)(2616005)(476003)(30864003)(107886003)(1076003)(5660300002)(50226002)(6636002)(316002)(6512007)(54906003)(81166006)(446003)(81156014)(110136005)(4326008)(14454004)(6116002)(186003)(3846002)(86362001)(256004)(36756003)(6486002)(14444005)(52116002)(486006)(478600001)(66446008)(64756008)(66556008)(66476007)(66946007)(76176011)(102836004)(305945005)(26005)(2906002)(7736002)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6232;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AXQ4ilHSR8FzBWNvYtrjLVJgoR0ZPaHmoYR7SC76uHr6MzetUgjmh9IkRKBIpNW4lqvjOnexScacEN3utQ+/oS5huModCM8asXc/x1Kv+6E5wWUGRM7SgWtFu835Vf+O4qenVloFgCLv2Oxfv9Kk9sPekHeZPbeB2FfX9pHMGrLLYLXBsCnPZn5JGizjtdko33E9OZw+F0aoiNFdmTKLtFhz3mrDED1tE2eHwWOlziOERcu/+TFNdB3eLG7lD3dhVR4UMinKlim62GvLEy7yjnk55+xVPOevoWnM6B41B0X2k97B62D8HiqPEYGiQJ0EO65d64s/Swge66YqHMPLTaFYJ4dsarc8SQD4NsXeGf3vBVF/hkb0KFrD6Voq1bPnRp7sVGeS6ilQaDxIrXKp2sI6WcoO732VLRyCB5BiVUoHlSIQHJe87q5gdYBRZTJJ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a86264b-3d2c-446d-bd43-08d76112fba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 10:37:25.8370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3yIHSXSixYn9oI+ExvDTL/TpuP5VAQJYzyhyu7cuqh8ppcSlVr9Cke2P79n48TlritsvzzCCeznY1WvCKn56uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6232
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maxim Chicherin <maximc@mellanox.com>

The CMID class represents rdma_cm_id, RDMA Connection Manager.
Currently only synchronous data path is supported. Support was added
to Context and PD classes to allow creation using rdmacm's API.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
---
 buildlib/pyverbs_functions.cmake |   2 +-
 pyverbs/CMakeLists.txt           |   2 +
 pyverbs/cm_enums.pyx             |   1 +
 pyverbs/cmid.pxd                 |  25 +++
 pyverbs/cmid.pyx                 | 285 +++++++++++++++++++++++++++++++
 pyverbs/device.pyx               |  15 +-
 pyverbs/librdmacm.pxd            | 106 ++++++++++++
 pyverbs/librdmacm_enums.pxd      |  32 ++++
 pyverbs/pd.pyx                   |  24 ++-
 9 files changed, 483 insertions(+), 9 deletions(-)
 create mode 120000 pyverbs/cm_enums.pyx
 create mode 100755 pyverbs/cmid.pxd
 create mode 100755 pyverbs/cmid.pyx
 create mode 100755 pyverbs/librdmacm.pxd
 create mode 100755 pyverbs/librdmacm_enums.pxd
 mode change 100644 =3D> 100755 pyverbs/pd.pyx

diff --git a/buildlib/pyverbs_functions.cmake b/buildlib/pyverbs_functions.=
cmake
index 4c255054fe94..a494ec16610b 100644
--- a/buildlib/pyverbs_functions.cmake
+++ b/buildlib/pyverbs_functions.cmake
@@ -25,7 +25,7 @@ function(rdma_cython_module PY_MODULE LINKER_FLAGS)
       COMPILE_FLAGS "${CMAKE_C_FLAGS} -fPIC -fno-strict-aliasing -Wno-unus=
ed-function -Wno-redundant-decls -Wno-shadow -Wno-cast-function-type -Wno-i=
mplicit-fallthrough -Wno-unknown-warning -Wno-unknown-warning-option ${NO_V=
AR_TRACKING_FLAGS}"
       LIBRARY_OUTPUT_DIRECTORY "${BUILD_PYTHON}/${PY_MODULE}"
       PREFIX "")
-    target_link_libraries(${SONAME} LINK_PRIVATE ${PYTHON_LIBRARIES} ibver=
bs ${LINKER_FLAGS})
+    target_link_libraries(${SONAME} LINK_PRIVATE ${PYTHON_LIBRARIES} ibver=
bs rdmacm ${LINKER_FLAGS})
     install(TARGETS ${SONAME}
       DESTINATION ${CMAKE_INSTALL_PYTHON_ARCH_LIB}/${PY_MODULE})
   endforeach()
diff --git a/pyverbs/CMakeLists.txt b/pyverbs/CMakeLists.txt
index 7bbb5fc841c0..de37025ce324 100755
--- a/pyverbs/CMakeLists.txt
+++ b/pyverbs/CMakeLists.txt
@@ -4,6 +4,8 @@
 rdma_cython_module(pyverbs ""
   addr.pyx
   base.pyx
+  cm_enums.pyx
+  cmid.pyx
   cq.pyx
   device.pyx
   enums.pyx
diff --git a/pyverbs/cm_enums.pyx b/pyverbs/cm_enums.pyx
new file mode 120000
index 000000000000..bdab2b585a1d
--- /dev/null
+++ b/pyverbs/cm_enums.pyx
@@ -0,0 +1 @@
+librdmacm_enums.pxd
\ No newline at end of file
diff --git a/pyverbs/cmid.pxd b/pyverbs/cmid.pxd
new file mode 100755
index 000000000000..56bc755daf42
--- /dev/null
+++ b/pyverbs/cmid.pxd
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2018, Mellanox Technologies. All rights reserved. See COPY=
ING file
+
+#cython: language_level=3D3
+
+from pyverbs.base cimport PyverbsObject, PyverbsCM
+from libc.string cimport memcpy, memset
+from libc.stdlib cimport free, malloc
+cimport pyverbs.librdmacm as cm
+
+
+cdef class CMID(PyverbsCM):
+    cdef cm.rdma_cm_id *id
+    cdef object ctx
+    cdef object pd
+    cpdef close(self)
+
+
+cdef class AddrInfo(PyverbsObject):
+    cdef cm.rdma_addrinfo *addr_info
+    cpdef close(self)
+
+
+cdef class ConnParam(PyverbsObject):
+    cdef cm.rdma_conn_param conn_param
\ No newline at end of file
diff --git a/pyverbs/cmid.pyx b/pyverbs/cmid.pyx
new file mode 100755
index 000000000000..c752feda8781
--- /dev/null
+++ b/pyverbs/cmid.pyx
@@ -0,0 +1,285 @@
+from pyverbs.pyverbs_error import PyverbsError
+from pyverbs.device cimport PortAttr, Context
+from pyverbs.qp cimport QPInitAttr, QPAttr
+from pyverbs.base import PyverbsRDMAErrno
+cimport pyverbs.libibverbs_enums as e
+cimport pyverbs.librdmacm_enums as ce
+cimport pyverbs.libibverbs as v
+cimport pyverbs.librdmacm as cm
+from pyverbs.pd cimport PD
+from pyverbs.mr cimport MR
+from pyverbs.cq cimport WC
+
+
+cdef class ConnParam(PyverbsObject):
+
+    def __cinit__(self, resources=3D1, depth=3D1, flow_control=3D0, retry=
=3D5,
+                  rnr_retry=3D5, srq=3D0, qp_num=3D0):
+        """
+        Initialize a ConnParam object over an underlying rdma_conn_param
+        C object which contains connection parameters. There are a few typ=
es of
+        port spaces in RDMACM: RDMA_PS_TCP, RDMA_PS_UDP, RDMA_PS_IB and
+        RDMA_PS_IPOIB. RDMA_PS_TCP resembles RC QP connection, which provi=
des
+        reliable, connection-oriented QP communication. This object applie=
s only
+        to RDMA_PS_TCP port space.
+        :param resources: Max outstanding RDMA read and atomic ops that lo=
cal
+                          side will accept from the remote side.
+        :param depth: Max outstanding RDMA read and atomic ops that local =
side
+                      will have to the remote side.
+        :param flow_control: Specifies if hardware flow control is availab=
le.
+        :param retry: Max number of times that a send, RDMA or atomic op f=
rom
+                      the remote peer should be retried.
+        :param rnr_retry: The maximum number of times that a send operatio=
n from
+                          the remote peer should be retried on a connectio=
n
+                          after receiving a receiver not ready (RNR) error=
.
+        :param srq: Specifies if the QP using shared receive queue, ignore=
d if
+                    the QP created by CMID.
+        :param qp_num: Specifies the QP number, ignored if the QP created =
by
+                       CMID.
+        :return: ConnParam object
+        """
+        memset(&self.conn_param, 0, sizeof(cm.rdma_conn_param))
+        self.conn_param.responder_resources =3D resources
+        self.conn_param.initiator_depth =3D depth
+        self.conn_param.flow_control =3D flow_control
+        self.conn_param.retry_count =3D retry
+        self.conn_param.rnr_retry_count =3D rnr_retry
+        self.conn_param.srq =3D srq
+        self.conn_param.qp_num =3D qp_num
+
+    def __str__(self):
+        print_format  =3D '{:<4}: {:<4}\n'
+        return '{}: {}\n'.format('Connection parameters', "") +\
+               print_format.format('responder resources', self.conn_param.=
responder_resources) +\
+               print_format.format('initiator depth', self.conn_param.init=
iator_depth) +\
+               print_format.format('flow control', self.conn_param.flow_co=
ntrol) +\
+               print_format.format('retry count', self.conn_param.retry_co=
unt) +\
+               print_format.format('rnr retry count', self.conn_param.rnr_=
retry_count) +\
+               print_format.format('srq', self.conn_param.srq) +\
+               print_format.format('qp number', self.conn_param.qp_num)
+
+
+cdef class AddrInfo(PyverbsObject):
+    def __cinit__(self, node=3DNone, service=3DNone, port_space=3D0, flags=
=3D0):
+        """
+        Initialize an AddrInfo object over an underlying rdma_addrinfo C o=
bject.
+        :param node: Name, dotted-decimal IPv4 or IPv6 hex address to reso=
lve.
+        :param service: The service name or port number of the address.
+        :param port_space: RDMA port space used (RDMA_PS_UDP or RDMA_PS_TC=
P).
+        :param flags: Hint flags which control the operation.
+        :return: An AddrInfo object which contains information needed to
+        establish communication.
+        """
+        cdef char* srvc =3D NULL
+        cdef char* address =3D NULL
+        cdef cm.rdma_addrinfo hints
+        cdef cm.rdma_addrinfo *hints_ptr =3D NULL
+
+        if node is not None:
+            node =3D node.encode('utf-8')
+            address =3D <char*>node
+        if service is not None:
+            service =3D service.encode('utf-8')
+            srvc =3D <char*>service
+        if port_space !=3D 0:
+            hints_ptr =3D &hints
+            memset(hints_ptr, 0, sizeof(cm.rdma_addrinfo))
+            hints.ai_port_space =3D port_space
+            hints.ai_flags =3D flags
+        ret =3D cm.rdma_getaddrinfo(address, srvc, hints_ptr, &self.addr_i=
nfo)
+        if ret !=3D 0:
+            raise PyverbsRDMAErrno('Failed to get Address Info')
+
+    def __dealloc__(self):
+        self.close()
+
+    cpdef close(self):
+        self.logger.debug('Closing AddrInfo')
+        if self.addr_info !=3D NULL:
+            cm.rdma_freeaddrinfo(self.addr_info)
+        self.addr_info =3D NULL
+
+
+cdef class CMID(PyverbsCM):
+
+    def __cinit__(self, object creator=3DNone, QPInitAttr qp_init_attr=3DN=
one,
+                  PD pd=3DNone):
+        """
+        Initialize a CMID object over an underlying rdma_cm_id C object.
+        This is the main RDMA CM object which provides most of the rdmacm =
API.
+        Currently only synchronous RDMA_PS_TCP communication supported.
+        :param creator: For synchronous communication we need AddrInfo obj=
ect in
+                        order to establish connection. We allow creator to=
 be
+                        None for inner usage, see get_request method.
+        :param pd: Optional parameter, a PD to be associated with this CMI=
D.
+        :param qp_init_attr: Optional initial QP attributes of CMID
+                             associated QP.
+        :return: CMID object for synchronous communication.
+        """
+        cdef v.ibv_qp_init_attr *init
+        cdef v.ibv_pd *in_pd =3D NULL
+        self.pd =3D None
+        self.ctx =3D None
+        if creator is None:
+            return
+        elif issubclass(type(creator), AddrInfo):
+            init =3D NULL if qp_init_attr is None else &qp_init_attr.attr
+            if pd is not None:
+                in_pd =3D pd.pd
+                self.pd =3D pd
+            ret =3D cm.rdma_create_ep(&self.id, (<AddrInfo>creator).addr_i=
nfo,
+                                    in_pd, init)
+            if ret !=3D 0:
+                raise PyverbsRDMAErrno('Failed to create CM ID')
+            if not (<AddrInfo>creator).addr_info.ai_flags & ce.RAI_PASSIVE=
:
+                self.ctx =3D Context(cmid=3Dself)
+                if self.pd is None:
+                    self.pd =3D PD(self)
+        else:
+            raise PyverbsRDMAErrno('Cannot create CM ID from {obj}'
+                                    .format(obj=3Dtype(creator)))
+
+    def __dealloc__(self):
+        self.close()
+
+    cpdef close(self):
+        self.logger.debug('Closing CMID')
+        if self.id !=3D NULL:
+            cm.rdma_destroy_ep(self.id)
+            if self.ctx:
+                (<Context>self.ctx).context =3D NULL
+            if self.pd:
+                (<PD>self.pd).pd =3D NULL
+            self.id =3D NULL
+
+    def get_request(self):
+        """
+        Retrieves the next pending connection request event. The call may =
only
+        be used on listening CMIDs operating synchronously. If the call is
+        successful, a new CMID representing the connection request will be
+        returned to the user. The new CMID will reference event informatio=
n
+        associated with the request until the user calls reject, accept, o=
r
+        close on the newly created identifier.
+        :return: New CMID representing the connection request.
+        """
+        to_conn =3D CMID()
+        ret =3D cm.rdma_get_request(self.id, &to_conn.id)
+        if ret !=3D 0:
+            raise PyverbsRDMAErrno('Failed to get request, no connection e=
stablished')
+        self.ctx =3D Context(cmid=3Dto_conn)
+        self.pd =3D PD(to_conn)
+        return to_conn
+
+    def reg_msgs(self, size):
+        """
+        Registers a memory region for sending or receiving messages or for
+        RDMA operations. The registered memory may then be posted to an CM=
ID
+        using post_send or post_recv methods.
+        :param size: The total length of the memory to register
+        :return: registered MR
+        """
+        return MR(self.pd, size, e.IBV_ACCESS_LOCAL_WRITE)
+
+    def listen(self, backlog=3D0):
+        """
+        Listen for incoming connection requests or datagram service lookup=
.
+        The listen is restricted to the locally bound source address.
+        :param backlog: The backlog of incoming connection requests
+        :return: None
+        """
+        ret =3D cm.rdma_listen(self.id, backlog)
+        if ret !=3D 0:
+            raise PyverbsRDMAErrno('Listen Failed')
+
+    def connect(self, ConnParam param=3DNone):
+        """
+        Initiates an active connection request to a remote destination.
+        :param param: Optional connection parameters
+        :return: None
+        """
+        cdef cm.rdma_conn_param *conn =3D &param.conn_param if param else =
NULL
+        ret =3D cm.rdma_connect(self.id, conn)
+        if ret !=3D 0:
+            raise PyverbsRDMAErrno('Failed to Connect')
+
+    def disconnect(self):
+        """
+        Disconnects a connection and transitions any associated QP to erro=
r
+        state.
+        :return: None
+        """
+        ret =3D cm.rdma_disconnect(self.id)
+        if ret !=3D 0:
+            raise PyverbsRDMAErrno('Failed to Disconnect')
+
+    def accept(self, ConnParam param=3DNone):
+        """
+        Is called from the listening side to accept a connection or datagr=
am
+        service lookup request.
+        :param param: Optional connection parameters
+        :return: None
+        """
+        cdef cm.rdma_conn_param *conn =3D &param.conn_param if param else =
NULL
+        ret =3D cm.rdma_accept(self.id, conn)
+        if ret !=3D 0:
+            raise PyverbsRDMAErrno('Failed to Accept Connection')
+
+    def post_recv(self, MR mr not None):
+        """
+        Posts a recv_wr via QP associated with CMID.
+        Context param of rdma_post_recv C function currently not supported=
.
+        :param mr: A valid MR object.
+        :return: None
+        """
+        ret =3D cm.rdma_post_recv(self.id, NULL, mr.buf, mr.mr.length, mr.=
mr)
+        if ret !=3D 0:
+            raise PyverbsRDMAErrno('Failed to Post Receive')
+
+    def post_send(self, MR mr not None, flags=3Dv.IBV_SEND_SIGNALED):
+        """
+        Posts a message via QP associated with CMID.
+        Context param of rdma_post_send C function currently not supported=
.
+        :param mr: A valid MR object which contains message to send.
+        :param flags: flags for send work request.
+        :return: None
+        """
+        ret =3D cm.rdma_post_send(self.id, NULL, mr.buf, mr.mr.length, mr.=
mr,
+                                flags)
+        if ret !=3D 0:
+            raise PyverbsRDMAErrno('Failed to Post Send')
+
+    def get_recv_comp(self):
+        """
+        Polls the receive CQ associated with CMID for a work completion.
+        :return: The retrieved WC or None if there is no completions
+        """
+        cdef v.ibv_wc wc
+        ret =3D cm.rdma_get_recv_comp(self.id, &wc)
+        if ret < 0:
+            raise PyverbsRDMAErrno('Failed to retrieve receive completion'=
)
+        elif ret =3D=3D 0:
+            return None
+        return WC(wr_id=3Dwc.wr_id, status=3Dwc.status, opcode=3Dwc.opcode=
,
+                  vendor_err=3Dwc.vendor_err, byte_len=3Dwc.byte_len,
+                  qp_num=3Dwc.qp_num, src_qp=3Dwc.src_qp,
+                  imm_data=3Dwc.imm_data, wc_flags=3Dwc.wc_flags,
+                  pkey_index=3Dwc.pkey_index, slid=3Dwc.slid, sl=3Dwc.sl,
+                  dlid_path_bits=3Dwc.dlid_path_bits)
+
+    def get_send_comp(self):
+        """
+        Polls the send CQ associated with CMID for a work completion.
+        :return: The retrieved WC or None if there is no completions
+        """
+        cdef v.ibv_wc wc
+        ret =3D cm.rdma_get_send_comp(self.id, &wc)
+        if ret < 0:
+            raise PyverbsRDMAErrno('Failed to retrieve send completion')
+        elif ret =3D=3D 0:
+            return None
+        return WC(wr_id=3Dwc.wr_id, status=3Dwc.status, opcode=3Dwc.opcode=
,
+                  vendor_err=3Dwc.vendor_err, byte_len=3Dwc.byte_len,
+                  qp_num=3Dwc.qp_num, src_qp=3Dwc.src_qp,
+                  imm_data=3Dwc.imm_data, wc_flags=3Dwc.wc_flags,
+                  pkey_index=3Dwc.pkey_index, slid=3Dwc.slid, sl=3Dwc.sl,
+                  dlid_path_bits=3Dwc.dlid_path_bits)
diff --git a/pyverbs/device.pyx b/pyverbs/device.pyx
index 58a2aca27fcc..c747822b3b32 100755
--- a/pyverbs/device.pyx
+++ b/pyverbs/device.pyx
@@ -14,6 +14,7 @@ from .pyverbs_error import PyverbsUserError
 from pyverbs.base import PyverbsRDMAErrno
 cimport pyverbs.libibverbs_enums as e
 cimport pyverbs.libibverbs as v
+from pyverbs.cmid cimport CMID
 from pyverbs.xrcd cimport XRCD
 from pyverbs.addr cimport GID
 from pyverbs.mr import DMMR
@@ -79,16 +80,22 @@ cdef class Context(PyverbsCM):
         Initializes a Context object. The function searches the IB devices=
 list
         for a device with the name provided by the user. If such a device =
is
         found, it is opened (unless provider attributes were given).
+        In case of cmid argument, CMID object already holds an ibv_context
+        initiated pointer, hence all we have to do is assign this pointer =
to
+        Context's object pointer.
         :param kwargs: Arguments:
             * *name* (str)
                The RDMA device's name
             * *attr* (object)
                Device-specific attributes, meaning that the device is to b=
e
                opened by the provider
+            * *cmid* (CMID)
+                A CMID object (represents rdma_cm_id struct)
         :return: None
         """
         cdef int count
         cdef v.ibv_device **dev_list
+        cdef CMID cmid
=20
         self.pds =3D weakref.WeakSet()
         self.dms =3D weakref.WeakSet()
@@ -99,7 +106,13 @@ cdef class Context(PyverbsCM):
=20
         dev_name =3D kwargs.get('name')
         provider_attr =3D kwargs.get('attr')
-        if dev_name is not None:
+        cmid =3D kwargs.get('cmid')
+
+        if cmid is not None:
+            self.context =3D cmid.id.verbs
+            cmid.ctx =3D self
+            return
+        elif dev_name is not None:
             self.name =3D dev_name
         else:
             raise PyverbsUserError('Device name must be provided')
diff --git a/pyverbs/librdmacm.pxd b/pyverbs/librdmacm.pxd
new file mode 100755
index 000000000000..935a4ae24e87
--- /dev/null
+++ b/pyverbs/librdmacm.pxd
@@ -0,0 +1,106 @@
+include 'libibverbs.pxd'
+include 'librdmacm_enums.pxd'
+from libc.stdint cimport uint8_t, uint32_t
+
+cdef extern from '<rdma/rdma_cma.h>':
+
+    cdef struct rdma_cm_id:
+        ibv_context         *verbs
+        rdma_event_channel  *channel
+        void                *context
+        ibv_qp              *qp
+        rdma_port_space     ps
+        uint8_t             port_num
+        rdma_cm_event       *event
+        ibv_comp_channel    *send_cq_channel
+        ibv_cq              *send_cq
+        ibv_comp_channel    *recv_cq_channel
+        ibv_cq              *recv_cq
+        ibv_srq             *srq
+        ibv_pd              *pd
+        ibv_qp_type         qp_type
+
+    cdef struct rdma_event_channel:
+        int fd
+
+    cdef struct rdma_conn_param:
+        const void *private_data
+        uint8_t     private_data_len
+        uint8_t     responder_resources
+        uint8_t     initiator_depth
+        uint8_t     flow_control
+        uint8_t     retry_count
+        uint8_t     rnr_retry_count
+        uint8_t     srq
+        uint32_t    qp_num
+
+    cdef struct rdma_ud_param:
+        const void  *private_data
+        uint8_t     private_data_len
+        ibv_ah_attr ah_attr
+        uint32_t    qp_num
+        uint32_t    qkey
+
+    cdef union param:
+        rdma_conn_param conn
+        rdma_ud_param   ud
+
+    cdef struct rdma_cm_event:
+        rdma_cm_id          *id
+        rdma_cm_id          *listen_id
+        rdma_cm_event_type  event
+        int                 status
+        param               param
+
+    cdef struct rdma_addrinfo:
+        int             ai_flags
+        int             ai_family
+        int             ai_qp_type
+        int             ai_port_space
+        int             ai_src_len
+        int             ai_dst_len
+        sockaddr        *ai_src_addr
+        sockaddr        *ai_dst_addr
+        char            *ai_src_canonname
+        char            *ai_dst_canonname
+        size_t          ai_route_len
+        void            *ai_route
+        size_t          ai_connect_len
+        void            *ai_connect
+        rdma_addrinfo   *ai_next
+
+# These non rdmacm structs defined in one of rdma_cma.h's included header =
files
+    cdef struct sockaddr:
+        unsigned short  sa_family
+        char            sa_data[14]
+
+    cdef struct in_addr:
+        uint32_t s_addr
+
+    cdef struct sockaddr_in:
+        short           sin_family
+        unsigned short  sin_port
+        in_addr         sin_addr
+        char            sin_zero[8]
+
+    int rdma_create_ep(rdma_cm_id **id, rdma_addrinfo *res,
+                       ibv_pd *pd, ibv_qp_init_attr *qp_init_attr)
+    void rdma_destroy_ep(rdma_cm_id *id)
+    int rdma_get_request(rdma_cm_id *listen, rdma_cm_id **id)
+    int rdma_connect(rdma_cm_id *id, rdma_conn_param *conn_param)
+    int rdma_disconnect(rdma_cm_id *id)
+    int rdma_listen(rdma_cm_id *id, int backlog)
+    int rdma_accept(rdma_cm_id *id, rdma_conn_param *conn_param)
+    int rdma_getaddrinfo(char *node, char *service, rdma_addrinfo *hints,
+                         rdma_addrinfo **res)
+    void rdma_freeaddrinfo(rdma_addrinfo *res)
+
+cdef extern from '<rdma/rdma_verbs.h>':
+    int rdma_post_recv(rdma_cm_id *id, void *context, void *addr,
+                       size_t length, ibv_mr *mr)
+    int rdma_post_send(rdma_cm_id *id, void *context, void *addr,
+                       size_t length, ibv_mr *mr, int flags)
+    int rdma_get_send_comp(rdma_cm_id *id, ibv_wc *wc)
+    int rdma_get_recv_comp(rdma_cm_id *id, ibv_wc *wc)
+    ibv_mr *rdma_reg_msgs(rdma_cm_id *id, void *addr, size_t length)
+    int rdma_dereg_mr(ibv_mr *mr)
diff --git a/pyverbs/librdmacm_enums.pxd b/pyverbs/librdmacm_enums.pxd
new file mode 100755
index 000000000000..22a3648fb4a6
--- /dev/null
+++ b/pyverbs/librdmacm_enums.pxd
@@ -0,0 +1,32 @@
+cdef extern from '<rdma/rdma_cma.h>':
+
+    cpdef enum rdma_cm_event_type:
+        RDMA_CM_EVENT_ADDR_RESOLVED
+        RDMA_CM_EVENT_ADDR_ERROR
+        RDMA_CM_EVENT_ROUTE_RESOLVED
+        RDMA_CM_EVENT_ROUTE_ERROR
+        RDMA_CM_EVENT_CONNECT_REQUEST
+        RDMA_CM_EVENT_CONNECT_RESPONSE
+        RDMA_CM_EVENT_CONNECT_ERROR
+        RDMA_CM_EVENT_UNREACHABLE
+        RDMA_CM_EVENT_REJECTED
+        RDMA_CM_EVENT_ESTABLISHED
+        RDMA_CM_EVENT_DISCONNECTED
+        RDMA_CM_EVENT_DEVICE_REMOVAL
+        RDMA_CM_EVENT_MULTICAST_JOIN
+        RDMA_CM_EVENT_MULTICAST_ERROR
+        RDMA_CM_EVENT_ADDR_CHANGE
+        RDMA_CM_EVENT_TIMEWAIT_EXIT
+
+    cpdef enum rdma_port_space:
+        RDMA_PS_IPOIB
+        RDMA_PS_TCP
+        RDMA_PS_UDP
+        RDMA_PS_IB
+
+    # Hint flags which control the operation.
+    cpdef enum:
+        RAI_PASSIVE
+        RAI_NUMERICHOST
+        RAI_NOROUTE
+        RAI_FAMILY
diff --git a/pyverbs/pd.pyx b/pyverbs/pd.pyx
old mode 100644
new mode 100755
index 46cbb36009ce..d6af58f25980
--- a/pyverbs/pd.pyx
+++ b/pyverbs/pd.pyx
@@ -2,9 +2,10 @@
 # Copyright (c) 2019, Mellanox Technologies. All rights reserved.
 import weakref
=20
-from pyverbs.pyverbs_error import PyverbsRDMAError, PyverbsError
+from pyverbs.pyverbs_error import PyverbsUserError, PyverbsError
 from pyverbs.base import PyverbsRDMAErrno
 from pyverbs.device cimport Context, DM
+from pyverbs.cmid cimport CMID
 from .mr cimport MR, MW, DMMR
 from pyverbs.srq cimport SRQ
 from pyverbs.addr cimport AH
@@ -15,18 +16,27 @@ cdef extern from 'errno.h':
=20
=20
 cdef class PD(PyverbsCM):
-    def __cinit__(self, Context context not None):
+    def __cinit__(self, object creator not None):
         """
         Initializes a PD object. A reference for the creating Context is k=
ept
         so that Python's GC will destroy the objects in the right order.
         :param context: The Context object creating the PD
         :return: The newly created PD on success
         """
-        self.pd =3D v.ibv_alloc_pd(<v.ibv_context*>context.context)
-        if self.pd =3D=3D NULL:
-            raise PyverbsRDMAErrno('Failed to allocate PD', errno)
-        self.ctx =3D context
-        context.add_ref(self)
+        if issubclass(type(creator), Context):
+            self.pd =3D v.ibv_alloc_pd((<Context>creator).context)
+            if self.pd =3D=3D NULL:
+                raise PyverbsRDMAErrno('Failed to allocate PD')
+            self.ctx =3D creator
+        elif issubclass(type(creator), CMID):
+            cmid =3D <CMID>creator
+            self.pd =3D cmid.id.pd
+            self.ctx =3D cmid.ctx
+            cmid.pd =3D self
+        else:
+            raise PyverbsUserError('Cannot create PD from {type}'
+                                    .format(type=3Dtype(creator)))
+        self.ctx.add_ref(self)
         self.logger.debug('PD: Allocated ibv_pd')
         self.srqs =3D weakref.WeakSet()
         self.mrs =3D weakref.WeakSet()
--=20
2.21.0

