Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4747B3A300
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2019 04:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfFIC1c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Jun 2019 22:27:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55574 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbfFIC1b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 8 Jun 2019 22:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BCV8KXeM7o7hLjXiKVomBp2FcB1GvIsVqbEY0KYw+QY=; b=L5UpeoWjVZ6rFL4yLXAMquVwrh
        i2LwdsC1nI6rE5M7VrKjc/fHLVxxlE0dVfCgXxNYJ1PaePuZiUiofmv+XbGDHTaPB4vx6e4dSIiav
        5C6b5A5HoByzmezZaH/N5nntUfdjj4Egm2kUI9uEwABUw6AoGZG3Wcb85wcVTZMD0O2pxcckRISeW
        PTt+gSe/U6Cj3Avb4AOT+tCkV1Y2EB3px4FqR486KUC4w3GbqMrgBskuWLVKZlcYwMUa2VaG8MlJ1
        /iWpq0RpP7jgwpcEcC0eXYqvG/jMjSBm24Ao2jV02ZldhvQWukO9+o3lf9vbr9zSplD8AvI+NmrCa
        UBMMMMqw==;
Received: from 179.176.115.133.dynamic.adsl.gvt.net.br ([179.176.115.133] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZnYO-0001mr-18; Sun, 09 Jun 2019 02:27:28 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZnYL-0000J3-4X; Sat, 08 Jun 2019 23:27:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH v3 13/33] docs: infiniband: convert docs to ReST and rename to *.rst
Date:   Sat,  8 Jun 2019 23:27:03 -0300
Message-Id: <09036fdb89c4bec94cb92d25398c026afdb134e7.1560045490.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560045490.git.mchehab+samsung@kernel.org>
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The InfiniBand docs are plain text with no markups.
So, all we needed to do were to add the title markups and
some markup sequences in order to properly parse tables,
lists and literal blocks.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../{core_locking.txt => core_locking.rst}    |  64 ++++++-----
 Documentation/infiniband/index.rst            |  23 ++++
 .../infiniband/{ipoib.txt => ipoib.rst}       |  24 ++--
 .../infiniband/{opa_vnic.txt => opa_vnic.rst} | 108 +++++++++---------
 .../infiniband/{sysfs.txt => sysfs.rst}       |   4 +-
 .../{tag_matching.txt => tag_matching.rst}    |   5 +
 .../infiniband/{user_mad.txt => user_mad.rst} |  33 ++++--
 .../{user_verbs.txt => user_verbs.rst}        |  12 +-
 drivers/infiniband/core/user_mad.c            |   2 +-
 drivers/infiniband/ulp/ipoib/Kconfig          |   2 +-
 10 files changed, 174 insertions(+), 103 deletions(-)
 rename Documentation/infiniband/{core_locking.txt => core_locking.rst} (78%)
 create mode 100644 Documentation/infiniband/index.rst
 rename Documentation/infiniband/{ipoib.txt => ipoib.rst} (90%)
 rename Documentation/infiniband/{opa_vnic.txt => opa_vnic.rst} (63%)
 rename Documentation/infiniband/{sysfs.txt => sysfs.rst} (69%)
 rename Documentation/infiniband/{tag_matching.txt => tag_matching.rst} (98%)
 rename Documentation/infiniband/{user_mad.txt => user_mad.rst} (90%)
 rename Documentation/infiniband/{user_verbs.txt => user_verbs.rst} (93%)

diff --git a/Documentation/infiniband/core_locking.txt b/Documentation/infiniband/core_locking.rst
similarity index 78%
rename from Documentation/infiniband/core_locking.txt
rename to Documentation/infiniband/core_locking.rst
index 4b1f36b6ada0..f34669beb4fe 100644
--- a/Documentation/infiniband/core_locking.txt
+++ b/Documentation/infiniband/core_locking.rst
@@ -1,4 +1,6 @@
-INFINIBAND MIDLAYER LOCKING
+===========================
+InfiniBand Midlayer Locking
+===========================
 
   This guide is an attempt to make explicit the locking assumptions
   made by the InfiniBand midlayer.  It describes the requirements on
@@ -6,45 +8,47 @@ INFINIBAND MIDLAYER LOCKING
   protocols that use the midlayer.
 
 Sleeping and interrupt context
+==============================
 
   With the following exceptions, a low-level driver implementation of
   all of the methods in struct ib_device may sleep.  The exceptions
   are any methods from the list:
 
-    create_ah
-    modify_ah
-    query_ah
-    destroy_ah
-    post_send
-    post_recv
-    poll_cq
-    req_notify_cq
-    map_phys_fmr
+    - create_ah
+    - modify_ah
+    - query_ah
+    - destroy_ah
+    - post_send
+    - post_recv
+    - poll_cq
+    - req_notify_cq
+    - map_phys_fmr
 
   which may not sleep and must be callable from any context.
 
   The corresponding functions exported to upper level protocol
   consumers:
 
-    ib_create_ah
-    ib_modify_ah
-    ib_query_ah
-    ib_destroy_ah
-    ib_post_send
-    ib_post_recv
-    ib_req_notify_cq
-    ib_map_phys_fmr
+    - ib_create_ah
+    - ib_modify_ah
+    - ib_query_ah
+    - ib_destroy_ah
+    - ib_post_send
+    - ib_post_recv
+    - ib_req_notify_cq
+    - ib_map_phys_fmr
 
   are therefore safe to call from any context.
 
   In addition, the function
 
-    ib_dispatch_event
+    - ib_dispatch_event
 
   used by low-level drivers to dispatch asynchronous events through
   the midlayer is also safe to call from any context.
 
 Reentrancy
+----------
 
   All of the methods in struct ib_device exported by a low-level
   driver must be fully reentrant.  The low-level driver is required to
@@ -62,6 +66,7 @@ Reentrancy
   information between different calls of ib_poll_cq() is not defined.
 
 Callbacks
+---------
 
   A low-level driver must not perform a callback directly from the
   same callchain as an ib_device method call.  For example, it is not
@@ -74,18 +79,18 @@ Callbacks
   completion event handlers for the same CQ are not called
   simultaneously.  The driver must guarantee that only one CQ event
   handler for a given CQ is running at a time.  In other words, the
-  following situation is not allowed:
+  following situation is not allowed::
 
-        CPU1                                    CPU2
+          CPU1                                    CPU2
 
-  low-level driver ->
-    consumer CQ event callback:
-      /* ... */
-      ib_req_notify_cq(cq, ...);
-                                        low-level driver ->
-      /* ... */                           consumer CQ event callback:
-                                            /* ... */
-      return from CQ event handler
+    low-level driver ->
+      consumer CQ event callback:
+        /* ... */
+        ib_req_notify_cq(cq, ...);
+                                          low-level driver ->
+        /* ... */                           consumer CQ event callback:
+                                              /* ... */
+        return from CQ event handler
 
   The context in which completion event and asynchronous event
   callbacks run is not defined.  Depending on the low-level driver, it
@@ -93,6 +98,7 @@ Callbacks
   Upper level protocol consumers may not sleep in a callback.
 
 Hot-plug
+--------
 
   A low-level driver announces that a device is ready for use by
   consumers when it calls ib_register_device(), all initialization
diff --git a/Documentation/infiniband/index.rst b/Documentation/infiniband/index.rst
new file mode 100644
index 000000000000..22eea64de722
--- /dev/null
+++ b/Documentation/infiniband/index.rst
@@ -0,0 +1,23 @@
+:orphan:
+
+==========
+InfiniBand
+==========
+
+.. toctree::
+   :maxdepth: 1
+
+   core_locking
+   ipoib
+   opa_vnic
+   sysfs
+   tag_matching
+   user_mad
+   user_verbs
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/infiniband/ipoib.txt b/Documentation/infiniband/ipoib.rst
similarity index 90%
rename from Documentation/infiniband/ipoib.txt
rename to Documentation/infiniband/ipoib.rst
index 47c1dd9818f2..0dd36154c0c9 100644
--- a/Documentation/infiniband/ipoib.txt
+++ b/Documentation/infiniband/ipoib.rst
@@ -1,4 +1,6 @@
-IP OVER INFINIBAND
+==================
+IP over InfiniBand
+==================
 
   The ib_ipoib driver is an implementation of the IP over InfiniBand
   protocol as specified by RFC 4391 and 4392, issued by the IETF ipoib
@@ -8,16 +10,17 @@ IP OVER INFINIBAND
   masqueraded to the kernel as ethernet interfaces).
 
 Partitions and P_Keys
+=====================
 
   When the IPoIB driver is loaded, it creates one interface for each
   port using the P_Key at index 0.  To create an interface with a
   different P_Key, write the desired P_Key into the main interface's
-  /sys/class/net/<intf name>/create_child file.  For example:
+  /sys/class/net/<intf name>/create_child file.  For example::
 
     echo 0x8001 > /sys/class/net/ib0/create_child
 
   This will create an interface named ib0.8001 with P_Key 0x8001.  To
-  remove a subinterface, use the "delete_child" file:
+  remove a subinterface, use the "delete_child" file::
 
     echo 0x8001 > /sys/class/net/ib0/delete_child
 
@@ -28,6 +31,7 @@ Partitions and P_Keys
   rtnl_link_ops, where children created using either way behave the same.
 
 Datagram vs Connected modes
+===========================
 
   The IPoIB driver supports two modes of operation: datagram and
   connected.  The mode is set and read through an interface's
@@ -51,6 +55,7 @@ Datagram vs Connected modes
   networking stack to use the smaller UD MTU for these neighbours.
 
 Stateless offloads
+==================
 
   If the IB HW supports IPoIB stateless offloads, IPoIB advertises
   TCP/IP checksum and/or Large Send (LSO) offloading capability to the
@@ -60,9 +65,10 @@ Stateless offloads
   on/off using ethtool calls.  Currently LRO is supported only for
   checksum offload capable devices.
 
-  Stateless offloads are supported only in datagram mode.  
+  Stateless offloads are supported only in datagram mode.
 
 Interrupt moderation
+====================
 
   If the underlying IB device supports CQ event moderation, one can
   use ethtool to set interrupt mitigation parameters and thus reduce
@@ -71,6 +77,7 @@ Interrupt moderation
   moderation is supported.
 
 Debugging Information
+=====================
 
   By compiling the IPoIB driver with CONFIG_INFINIBAND_IPOIB_DEBUG set
   to 'y', tracing messages are compiled into the driver.  They are
@@ -79,7 +86,7 @@ Debugging Information
   runtime through files in /sys/module/ib_ipoib/.
 
   CONFIG_INFINIBAND_IPOIB_DEBUG also enables files in the debugfs
-  virtual filesystem.  By mounting this filesystem, for example with
+  virtual filesystem.  By mounting this filesystem, for example with::
 
     mount -t debugfs none /sys/kernel/debug
 
@@ -96,10 +103,13 @@ Debugging Information
   performance, because it adds tests to the fast path.
 
 References
+==========
 
   Transmission of IP over InfiniBand (IPoIB) (RFC 4391)
-    http://ietf.org/rfc/rfc4391.txt 
+    http://ietf.org/rfc/rfc4391.txt
+
   IP over InfiniBand (IPoIB) Architecture (RFC 4392)
-    http://ietf.org/rfc/rfc4392.txt 
+    http://ietf.org/rfc/rfc4392.txt
+
   IP over InfiniBand: Connected Mode (RFC 4755)
     http://ietf.org/rfc/rfc4755.txt
diff --git a/Documentation/infiniband/opa_vnic.txt b/Documentation/infiniband/opa_vnic.rst
similarity index 63%
rename from Documentation/infiniband/opa_vnic.txt
rename to Documentation/infiniband/opa_vnic.rst
index 282e17be798a..2f888d9ffec0 100644
--- a/Documentation/infiniband/opa_vnic.txt
+++ b/Documentation/infiniband/opa_vnic.rst
@@ -1,3 +1,7 @@
+=================================================================
+Intel Omni-Path (OPA) Virtual Network Interface Controller (VNIC)
+=================================================================
+
 Intel Omni-Path (OPA) Virtual Network Interface Controller (VNIC) feature
 supports Ethernet functionality over Omni-Path fabric by encapsulating
 the Ethernet packets between HFI nodes.
@@ -17,70 +21,72 @@ an independent Ethernet network. The configuration is performed by an
 Ethernet Manager (EM) which is part of the trusted Fabric Manager (FM)
 application. HFI nodes can have multiple VNICs each connected to a
 different virtual Ethernet switch. The below diagram presents a case
-of two virtual Ethernet switches with two HFI nodes.
+of two virtual Ethernet switches with two HFI nodes::
 
-                             +-------------------+
-                             |      Subnet/      |
-                             |     Ethernet      |
-                             |      Manager      |
-                             +-------------------+
-                                /          /
-                              /           /
-                            /            /
-                          /             /
-+-----------------------------+  +------------------------------+
-|  Virtual Ethernet Switch    |  |  Virtual Ethernet Switch     |
-|  +---------+    +---------+ |  | +---------+    +---------+   |
-|  | VPORT   |    |  VPORT  | |  | |  VPORT  |    |  VPORT  |   |
-+--+---------+----+---------+-+  +-+---------+----+---------+---+
-         |                 \        /                 |
-         |                   \    /                   |
-         |                     \/                     |
-         |                    /  \                    |
-         |                  /      \                  |
-     +-----------+------------+  +-----------+------------+
-     |   VNIC    |    VNIC    |  |    VNIC   |    VNIC    |
-     +-----------+------------+  +-----------+------------+
-     |          HFI           |  |          HFI           |
-     +------------------------+  +------------------------+
+                               +-------------------+
+                               |      Subnet/      |
+                               |     Ethernet      |
+                               |      Manager      |
+                               +-------------------+
+                                  /          /
+                                /           /
+                              /            /
+                            /             /
+  +-----------------------------+  +------------------------------+
+  |  Virtual Ethernet Switch    |  |  Virtual Ethernet Switch     |
+  |  +---------+    +---------+ |  | +---------+    +---------+   |
+  |  | VPORT   |    |  VPORT  | |  | |  VPORT  |    |  VPORT  |   |
+  +--+---------+----+---------+-+  +-+---------+----+---------+---+
+           |                 \        /                 |
+           |                   \    /                   |
+           |                     \/                     |
+           |                    /  \                    |
+           |                  /      \                  |
+       +-----------+------------+  +-----------+------------+
+       |   VNIC    |    VNIC    |  |    VNIC   |    VNIC    |
+       +-----------+------------+  +-----------+------------+
+       |          HFI           |  |          HFI           |
+       +------------------------+  +------------------------+
 
 
 The Omni-Path encapsulated Ethernet packet format is as described below.
 
-Bits          Field
-------------------------------------
+==================== ================================
+Bits                 Field
+==================== ================================
 Quad Word 0:
-0-19      SLID (lower 20 bits)
-20-30     Length (in Quad Words)
-31        BECN bit
-32-51     DLID (lower 20 bits)
-52-56     SC (Service Class)
-57-59     RC (Routing Control)
-60        FECN bit
-61-62     L2 (=10, 16B format)
-63        LT (=1, Link Transfer Head Flit)
+0-19                 SLID (lower 20 bits)
+20-30                Length (in Quad Words)
+31                   BECN bit
+32-51                DLID (lower 20 bits)
+52-56                SC (Service Class)
+57-59                RC (Routing Control)
+60                   FECN bit
+61-62                L2 (=10, 16B format)
+63                   LT (=1, Link Transfer Head Flit)
 
 Quad Word 1:
-0-7       L4 type (=0x78 ETHERNET)
-8-11      SLID[23:20]
-12-15     DLID[23:20]
-16-31     PKEY
-32-47     Entropy
-48-63     Reserved
+0-7                  L4 type (=0x78 ETHERNET)
+8-11                 SLID[23:20]
+12-15                DLID[23:20]
+16-31                PKEY
+32-47                Entropy
+48-63                Reserved
 
 Quad Word 2:
-0-15      Reserved
-16-31     L4 header
-32-63     Ethernet Packet
+0-15                 Reserved
+16-31                L4 header
+32-63                Ethernet Packet
 
 Quad Words 3 to N-1:
-0-63      Ethernet packet (pad extended)
+0-63                 Ethernet packet (pad extended)
 
 Quad Word N (last):
-0-23      Ethernet packet (pad extended)
-24-55     ICRC
-56-61     Tail
-62-63     LT (=01, Link Transfer Tail Flit)
+0-23                 Ethernet packet (pad extended)
+24-55                ICRC
+56-61                Tail
+62-63                LT (=01, Link Transfer Tail Flit)
+==================== ================================
 
 Ethernet packet is padded on the transmit side to ensure that the VNIC OPA
 packet is quad word aligned. The 'Tail' field contains the number of bytes
@@ -123,7 +129,7 @@ operation. It also handles the encapsulation of Ethernet packets with an
 Omni-Path header in the transmit path. For each VNIC interface, the
 information required for encapsulation is configured by the EM via VEMA MAD
 interface. It also passes any control information to the HW dependent driver
-by invoking the RDMA netdev control operations.
+by invoking the RDMA netdev control operations::
 
         +-------------------+ +----------------------+
         |                   | |       Linux          |
diff --git a/Documentation/infiniband/sysfs.txt b/Documentation/infiniband/sysfs.rst
similarity index 69%
rename from Documentation/infiniband/sysfs.txt
rename to Documentation/infiniband/sysfs.rst
index 9fab5062f84b..f0abd6fa48f4 100644
--- a/Documentation/infiniband/sysfs.txt
+++ b/Documentation/infiniband/sysfs.rst
@@ -1,4 +1,6 @@
-SYSFS FILES
+===========
+Sysfs files
+===========
 
 The sysfs interface has moved to
 Documentation/ABI/stable/sysfs-class-infiniband.
diff --git a/Documentation/infiniband/tag_matching.txt b/Documentation/infiniband/tag_matching.rst
similarity index 98%
rename from Documentation/infiniband/tag_matching.txt
rename to Documentation/infiniband/tag_matching.rst
index d2a3bf819226..ef56ea585f92 100644
--- a/Documentation/infiniband/tag_matching.txt
+++ b/Documentation/infiniband/tag_matching.rst
@@ -1,12 +1,16 @@
+==================
 Tag matching logic
+==================
 
 The MPI standard defines a set of rules, known as tag-matching, for matching
 source send operations to destination receives.  The following parameters must
 match the following source and destination parameters:
+
 *	Communicator
 *	User tag - wild card may be specified by the receiver
 *	Source rank – wild car may be specified by the receiver
 *	Destination rank – wild
+
 The ordering rules require that when more than one pair of send and receive
 message envelopes may match, the pair that includes the earliest posted-send
 and the earliest posted-receive is the pair that must be used to satisfy the
@@ -35,6 +39,7 @@ the header to initiate an RDMA READ operation directly to the matching buffer.
 A fin message needs to be received in order for the buffer to be reused.
 
 Tag matching implementation
+===========================
 
 There are two types of matching objects used, the posted receive list and the
 unexpected message list. The application posts receive buffers through calls
diff --git a/Documentation/infiniband/user_mad.txt b/Documentation/infiniband/user_mad.rst
similarity index 90%
rename from Documentation/infiniband/user_mad.txt
rename to Documentation/infiniband/user_mad.rst
index 7aca13a54a3a..d88abfc0e370 100644
--- a/Documentation/infiniband/user_mad.txt
+++ b/Documentation/infiniband/user_mad.rst
@@ -1,6 +1,9 @@
-USERSPACE MAD ACCESS
+====================
+Userspace MAD access
+====================
 
 Device files
+============
 
   Each port of each InfiniBand device has a "umad" device and an
   "issm" device attached.  For example, a two-port HCA will have two
@@ -8,12 +11,13 @@ Device files
   device of each type (for switch port 0).
 
 Creating MAD agents
+===================
 
   A MAD agent can be created by filling in a struct ib_user_mad_reg_req
   and then calling the IB_USER_MAD_REGISTER_AGENT ioctl on a file
   descriptor for the appropriate device file.  If the registration
   request succeeds, a 32-bit id will be returned in the structure.
-  For example:
+  For example::
 
 	struct ib_user_mad_reg_req req = { /* ... */ };
 	ret = ioctl(fd, IB_USER_MAD_REGISTER_AGENT, (char *) &req);
@@ -26,12 +30,14 @@ Creating MAD agents
   ioctl.  Also, all agents registered through a file descriptor will
   be unregistered when the descriptor is closed.
 
-  2014 -- a new registration ioctl is now provided which allows additional
+  2014
+       a new registration ioctl is now provided which allows additional
        fields to be provided during registration.
        Users of this registration call are implicitly setting the use of
        pkey_index (see below).
 
 Receiving MADs
+==============
 
   MADs are received using read().  The receive side now supports
   RMPP. The buffer passed to read() must be at least one
@@ -41,7 +47,8 @@ Receiving MADs
   MAD (RMPP), the errno is set to ENOSPC and the length of the
   buffer needed is set in mad.length.
 
-  Example for normal MAD (non RMPP) reads:
+  Example for normal MAD (non RMPP) reads::
+
 	struct ib_user_mad *mad;
 	mad = malloc(sizeof *mad + 256);
 	ret = read(fd, mad, sizeof *mad + 256);
@@ -50,7 +57,8 @@ Receiving MADs
 		free(mad);
 	}
 
-  Example for RMPP reads:
+  Example for RMPP reads::
+
 	struct ib_user_mad *mad;
 	mad = malloc(sizeof *mad + 256);
 	ret = read(fd, mad, sizeof *mad + 256);
@@ -76,11 +84,12 @@ Receiving MADs
   poll()/select() may be used to wait until a MAD can be read.
 
 Sending MADs
+============
 
   MADs are sent using write().  The agent ID for sending should be
   filled into the id field of the MAD, the destination LID should be
   filled into the lid field, and so on.  The send side does support
-  RMPP so arbitrary length MAD can be sent. For example:
+  RMPP so arbitrary length MAD can be sent. For example::
 
 	struct ib_user_mad *mad;
 
@@ -97,6 +106,7 @@ Sending MADs
 		perror("write");
 
 Transaction IDs
+===============
 
   Users of the umad devices can use the lower 32 bits of the
   transaction ID field (that is, the least significant half of the
@@ -105,6 +115,7 @@ Transaction IDs
   the kernel and will be overwritten before a MAD is sent.
 
 P_Key Index Handling
+====================
 
   The old ib_umad interface did not allow setting the P_Key index for
   MADs that are sent and did not provide a way for obtaining the P_Key
@@ -119,6 +130,7 @@ P_Key Index Handling
   default, and the IB_USER_MAD_ENABLE_PKEY ioctl will be removed.
 
 Setting IsSM Capability Bit
+===========================
 
   To set the IsSM capability bit for a port, simply open the
   corresponding issm device file.  If the IsSM bit is already set,
@@ -129,25 +141,26 @@ Setting IsSM Capability Bit
   the issm file.
 
 /dev files
+==========
 
   To create the appropriate character device files automatically with
-  udev, a rule like
+  udev, a rule like::
 
     KERNEL=="umad*", NAME="infiniband/%k"
     KERNEL=="issm*", NAME="infiniband/%k"
 
-  can be used.  This will create device nodes named
+  can be used.  This will create device nodes named::
 
     /dev/infiniband/umad0
     /dev/infiniband/issm0
 
   for the first port, and so on.  The InfiniBand device and port
-  associated with these devices can be determined from the files
+  associated with these devices can be determined from the files::
 
     /sys/class/infiniband_mad/umad0/ibdev
     /sys/class/infiniband_mad/umad0/port
 
-  and
+  and::
 
     /sys/class/infiniband_mad/issm0/ibdev
     /sys/class/infiniband_mad/issm0/port
diff --git a/Documentation/infiniband/user_verbs.txt b/Documentation/infiniband/user_verbs.rst
similarity index 93%
rename from Documentation/infiniband/user_verbs.txt
rename to Documentation/infiniband/user_verbs.rst
index 47ebf2f80b2b..8ddc4b1cfef2 100644
--- a/Documentation/infiniband/user_verbs.txt
+++ b/Documentation/infiniband/user_verbs.rst
@@ -1,4 +1,6 @@
-USERSPACE VERBS ACCESS
+======================
+Userspace verbs access
+======================
 
   The ib_uverbs module, built by enabling CONFIG_INFINIBAND_USER_VERBS,
   enables direct userspace access to IB hardware via "verbs," as
@@ -13,6 +15,7 @@ USERSPACE VERBS ACCESS
   libmthca userspace driver be installed.
 
 User-kernel communication
+=========================
 
   Userspace communicates with the kernel for slow path, resource
   management operations via the /dev/infiniband/uverbsN character
@@ -28,6 +31,7 @@ User-kernel communication
   system call.
 
 Resource management
+===================
 
   Since creation and destruction of all IB resources is done by
   commands passed through a file descriptor, the kernel can keep track
@@ -41,6 +45,7 @@ Resource management
   prevent one process from touching another process's resources.
 
 Memory pinning
+==============
 
   Direct userspace I/O requires that memory regions that are potential
   I/O targets be kept resident at the same physical address.  The
@@ -54,13 +59,14 @@ Memory pinning
   number of pages pinned by a process.
 
 /dev files
+==========
 
   To create the appropriate character device files automatically with
-  udev, a rule like
+  udev, a rule like::
 
     KERNEL=="uverbs*", NAME="infiniband/%k"
 
-  can be used.  This will create device nodes named
+  can be used.  This will create device nodes named::
 
     /dev/infiniband/uverbs0
 
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 671f07ba1fad..5ecd370e018b 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -744,7 +744,7 @@ static int ib_umad_reg_agent(struct ib_umad_file *file, void __user *arg,
 				"process %s did not enable P_Key index support.\n",
 				current->comm);
 			dev_warn(&file->port->dev,
-				"   Documentation/infiniband/user_mad.txt has info on the new ABI.\n");
+				"   Documentation/infiniband/user_mad.rst has info on the new ABI.\n");
 		}
 	}
 
diff --git a/drivers/infiniband/ulp/ipoib/Kconfig b/drivers/infiniband/ulp/ipoib/Kconfig
index 4760ce465d89..7af68604af77 100644
--- a/drivers/infiniband/ulp/ipoib/Kconfig
+++ b/drivers/infiniband/ulp/ipoib/Kconfig
@@ -7,7 +7,7 @@ config INFINIBAND_IPOIB
 	  transports IP packets over InfiniBand so you can use your IB
 	  device as a fancy NIC.
 
-	  See Documentation/infiniband/ipoib.txt for more information
+	  See Documentation/infiniband/ipoib.rst for more information
 
 config INFINIBAND_IPOIB_CM
 	bool "IP-over-InfiniBand Connected Mode support"
-- 
2.21.0

