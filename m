Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC16212800A
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2019 16:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfLTPvs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Dec 2019 10:51:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37581 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfLTPvr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Dec 2019 10:51:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so9905595wru.4;
        Fri, 20 Dec 2019 07:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l4r0qBaJEyzcjQ/ym+Uz8wxY/VMNpPu2LR4Wny0Biz8=;
        b=fIFOzE+4SeC+zlZjj6LQtsFXW94nkUFl8HjeZ8HzvNlq9mUJNo2xBTmlK5aDtQN5Ke
         WeEhZCI2xnGvkfvwbC8IClg4r9ljydnNQyA+xInTxV35IAgjpIX/6dnRbYfvnEH8SKnn
         EtxKk4oUx6F4tuw/hmBaIjyVaDEE8Us08La2R9gsjZYdsgRDufMpj1zuvHQW6MHa7lyz
         VfmQ//drE+AIpdQCly0g7DSaET6B8lD1UivalWAIuPLgLIQm1K7LpnfRBsn/lJXirAhc
         dC4P7pM9gSwNcXfEF1AlHCjCyFvypaXf1o4I83vOUBYvB4W4qY+Krdg7QPBswyWFt4Ji
         tGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l4r0qBaJEyzcjQ/ym+Uz8wxY/VMNpPu2LR4Wny0Biz8=;
        b=mlcSqJWNb6W0BykksGWIUJfTSxEg7ysKpKCN8Q/l7yFbFF0bzjLvLQAj6+SerEA/C1
         VUfyCK0+9j9oA124vkjWjhTrvgoIub1XfSBJl3y64P4zHwnbecR0Las3Zmy+WsKG0Fsm
         fDBhxVNHhwUbeaeApN/bvKcwiI9IKwLcWJh1nIXFIoqIZRETflONi7eF+WkbzLJMbVDJ
         wD4JTLqv9nVMSeVYLj5FDf24D24gmsCsC6FiGMYHuifWPaWmE6M8Gqf+TwofTwkSZF6Z
         zd7z3WTdkRsD64AQ9X3yVTK21wFY4D4N67Pul3xa13qESwSOX6hhuNVkrep2/VXgY+6W
         KxEQ==
X-Gm-Message-State: APjAAAXiMERdUcuDYrNGnPn+qokiYuv+Rp2SI4RPZ70L6/mS/GPRK5hG
        fOBi4aeyGt59KDSX4et5ueTx6pln
X-Google-Smtp-Source: APXvYqy+iP1P0FwGP0KIi63YSRuS8xt9pSgXv24uoTZ0VUy713As3/yPvi9B2chZDXanAiQyYTinMg==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr15768916wrp.292.1576857104973;
        Fri, 20 Dec 2019 07:51:44 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4972:cc00:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id u14sm10372139wrm.51.2019.12.20.07.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:51:44 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH v5 24/25] rnbd: a bit of documentation
Date:   Fri, 20 Dec 2019 16:51:08 +0100
Message-Id: <20191220155109.8959-25-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220155109.8959-1-jinpuwang@gmail.com>
References: <20191220155109.8959-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

README with description of major sysfs entries, sysfs documentation
are moved to ABI dir as Bart suggested.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Cc: linux-kernel@vger.kernel.org
---
 Documentation/ABI/testing/sysfs-block-rnbd    |  51 ++++++++
 .../ABI/testing/sysfs-class-rnbd-client       | 117 ++++++++++++++++++
 .../ABI/testing/sysfs-class-rnbd-server       |  57 +++++++++
 drivers/block/rnbd/README                     |  80 ++++++++++++
 4 files changed, 305 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-block-rnbd
 create mode 100644 Documentation/ABI/testing/sysfs-class-rnbd-client
 create mode 100644 Documentation/ABI/testing/sysfs-class-rnbd-server
 create mode 100644 drivers/block/rnbd/README

diff --git a/Documentation/ABI/testing/sysfs-block-rnbd b/Documentation/ABI/testing/sysfs-block-rnbd
new file mode 100644
index 000000000000..dea84280291a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-block-rnbd
@@ -0,0 +1,51 @@
+What:		/sys/block/rnbd<N>/rnbd/unmap_device
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+To unmap a volume, "normal" or "force" has to be written to:
+  /sys/block/rnbd<N>/rnbd/unmap_device
+
+When "normal" is used, the operation will fail with EBUSY if any process
+is using the device.  When "force" is used, the device is also unmapped
+when device is in use.  All I/Os that are in progress will fail.
+
+Example:
+
+   # echo "normal" > /sys/block/rnbd0/rnbd/unmap_device
+
+What:		/sys/block/rnbd<N>/rnbd/state
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+The file contains the current state of the block device. The state file
+returns "open" when the device is successfully mapped from the server
+and accepting I/O requests. When the connection to the server gets
+disconnected in case of an error (e.g. link failure), the state file
+returns "closed" and all I/O requests submitted to it will fail with -EIO.
+
+What:		/sys/block/rnbd<N>/rnbd/session
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+RNBD uses RTRS session to transport the data between client and
+server.  The entry "session" contains the name of the session, that
+was used to establish the RTRS session.  It's the same name that
+was passed as server parameter to the map_device entry.
+
+What:		/sys/block/rnbd<N>/rnbd/mapping_path
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+Contains the path that was passed as "device_path" to the map_device
+operation.
+
+What:		/sys/block/rnbd<N>/rnbd/access_mode
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+Contains the device access mode: ro, rw or migration.
diff --git a/Documentation/ABI/testing/sysfs-class-rnbd-client b/Documentation/ABI/testing/sysfs-class-rnbd-client
new file mode 100644
index 000000000000..7466a6aa2641
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-rnbd-client
@@ -0,0 +1,117 @@
+What:		/sys/class/rnbd-client
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+Provide information about RNBD-client.
+All sysfs files that are not read-only provide the usage information on read:
+
+Example:
+  # cat /sys/class/rnbd-client/ctl/map_device
+
+  > Usage: echo "sessname=<name of the rtrs session> path=<[srcaddr,]dstaddr>
+  > [path=<[srcaddr,]dstaddr>] device_path=<full path on remote side>
+  > [access_mode=<ro|rw|migration>] > map_device
+  >
+  > addr ::= [ ip:<ipv4> | ip:<ipv6> | gid:<gid> ]
+
+What:		/sys/class/rnbd-client/ctl/map_device
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+Expected format is the following:
+
+    sessname=<name of the rtrs session>
+    path=<[srcaddr,]dstaddr> [path=<[srcaddr,]dstaddr> ...]
+    device_path=<full path on remote side>
+    [access_mode=<ro|rw|migration>]
+
+Where:
+
+sessname: accepts a string not bigger than 256 chars, which identifies
+          a given session on the client and on the server.
+          I.e. "clt_hostname-srv_hostname" could be a natural choice.
+
+path:     describes a connection between the client and the server by
+      specifying destination and, when required, the source address.
+      The addresses are to be provided in the following format:
+
+            ip:<IPv6>
+            ip:<IPv4>
+            gid:<GID>
+
+          for example:
+
+          path=ip:10.0.0.66
+                         The single addr is treated as the destination.
+                         The connection will be established to this
+                         server from any client IP address.
+
+          path=ip:10.0.0.66,ip:10.0.1.66
+                         First addr is the source address and the second
+                         is the destination.
+
+          If multiple "path=" options are specified multiple connection
+          will be established and data will be sent according to
+          the selected multipath policy (see RTRS mp_policy sysfs entry
+          description).
+
+device_path: Path to the block device on the server side. Path is specified
+         relative to the directory on server side configured in the
+         'dev_search_path' module parameter of the rnbd_server.
+         The rnbd_server prepends the <device_path> received from client
+         with <dev_search_path> and tries to open the
+         <dev_search_path>/<device_path> block device.  On success,
+         a /dev/rnbd<N> device file, a /sys/block/rnbd_client/rnbd<N>/
+         directory and an entry in /sys/class/rnbd-client/ctl/devices
+         will be created.
+
+         If 'dev_search_path' contains '%SESSNAME%', then each session can
+         have different devices namespace, e.g. server was configured with
+         the following parameter "dev_search_path=/run/rnbd-devs/%SESSNAME%",
+         client has this string "sessname=blya device_path=sda", then server
+         will try to open: /run/rnbd-devs/blya/sda.
+
+access_mode: the access_mode parameter specifies if the device is to be
+             mapped as "ro" read-only or "rw" read-write. The server allows
+             a device to be exported in rw mode only once. The "migration"
+             access mode has to be specified if a second mapping in read-write
+             mode is desired.
+
+             By default "rw" is used.
+
+Exit Codes:
+
+If the device is already mapped it will fail with EEXIST. If the input
+has an invalid format it will return EINVAL. If the device path cannot
+be found on the server, it will fail with ENOENT.
+
+Finding device file after mapping
+---------------------------------
+
+After mapping, the device file can be found by:
+ o  The symlink /sys/class/rnbd-client/ctl/devices/<device_id>
+    points to /sys/block/<dev-name>. The last part of the symlink destination
+    is the same as the device name.  By extracting the last part of the
+    path the path to the device /dev/<dev-name> can be build.
+
+ o /dev/block/$(cat /sys/class/rnbd-client/ctl/devices/<device_id>/dev)
+
+How to find the <device_id> of the device is described on the next
+section.
+
+What:		/sys/class/rnbd-client/ctl/devices/
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+For each device mapped on the client a new symbolic link is created as
+/sys/class/rnbd-client/ctl/devices/<device_id>, which points
+to the block device created by rnbd (/sys/block/rnbd<N>/).
+The <device_id> of each device is created as follows:
+
+- If the 'device_path' provided during mapping contains slashes ("/"),
+  they are replaced by exclamation mark ("!") and used as as the
+  <device_id>. Otherwise, the <device_id> will be the same as the
+  "device_path" provided.
diff --git a/Documentation/ABI/testing/sysfs-class-rnbd-server b/Documentation/ABI/testing/sysfs-class-rnbd-server
new file mode 100644
index 000000000000..1faa9faa8ca3
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-rnbd-server
@@ -0,0 +1,57 @@
+What:		/sys/class/rnbd-server
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:   provide information about RNBD-server.
+
+What:		/sys/class/rnbd-server/ctl/
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+When a client maps a device, a directory entry with the name of the
+block device is created under /sys/class/rnbd-server/ctl/devices/.
+
+What:		/sys/class/rnbd-server/ctl/devices/<device_name>/block_dev
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+Is a symlink to the sysfs entry of the exported device.
+
+Example:
+
+  block_dev -> ../../../../class/block/ram0
+
+What:		/sys/class/rnbd-server/ctl/devices/<device_name>/sessions/
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+For each client a particular device is exported to, following directory will be
+created:
+
+/sys/class/rnbd-server/ctl/devices/<device_name>/sessions/<session-name>/
+
+When the device is unmapped by that client, the directory will be removed.
+
+What: /sys/class/rnbd-server/ctl/devices/<device_name>/sessions/<session-name>/read_only
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+Contains '1' if device is mapped read-only, otherwise '0'.
+
+What: /sys/class/rnbd-server/ctl/devices/<device_name>/sessions/<session-name>/mapping_path
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+Contains the relative device path provided by the user during mapping.
+
+What: /sys/class/rnbd-server/ctl/devices/<device_name>/sessions/<session-name>/access_mode
+Date:		Jan 2020
+KernelVersion:	5.6
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:
+Contains the device access mode: ro, rw or migration.
diff --git a/drivers/block/rnbd/README b/drivers/block/rnbd/README
new file mode 100644
index 000000000000..2134d60ac3ae
--- /dev/null
+++ b/drivers/block/rnbd/README
@@ -0,0 +1,80 @@
+***************************************
+Infiniband Network Block Device (RNBD)
+***************************************
+
+Introduction
+------------
+
+RNBD (InfiniBand Network Block Device) is a pair of kernel modules
+(client and server) that allow for remote access of a block device on
+the server over RTRS protocol using the RDMA (InfiniBand, RoCE, iWarp)
+transport. After being mapped, the remote block devices can be accessed
+on the client side as local block devices.
+
+I/O is transferred between client and server by the RTRS transport
+modules. The administration of RNBD and RTRS modules is done via
+sysfs entries.
+
+Requirements
+------------
+
+  RTRS kernel modules
+
+Quick Start
+-----------
+
+Server side:
+  # modprobe rnbd_server
+
+Client side:
+  # modprobe rnbd_client
+  # echo "sessname=blya path=ip:10.50.100.66 device_path=/dev/ram0" > \
+            /sys/devices/virtual/rnbd-client/ctl/map_device
+
+  Where "sessname=" is a session name, a string to identify the session
+  on client and on server sides; "path=" is a destination IP address or
+  a pair of a source and a destination IPs, separated by comma.  Multiple
+  "path=" options can be specified in order to use multipath  (see RTRS
+  description for details); "device_path=" is the block device to be
+  mapped from the server side. After the session to the server machine is
+  established, the mapped device will appear on the client side under
+  /dev/rnbd<N>.
+
+
+RNBD-Server Module Parameters
+==============================
+
+dev_search_path
+---------------
+
+When a device is mapped from the client, the server generates the path
+to the block device on the server side by concatenating dev_search_path
+and the "device_path" that was specified in the map_device operation.
+
+The default dev_search_path is: "/".
+
+dev_search_path option can also contain %SESSNAME% in order to provide
+different deviec namespaces for different sessions.  See "device_path"
+option for details.
+
+==============================
+Protocol (rnbd/rnbd-proto.h)
+==============================
+
+1. Before mapping first device from a given server, client sends an
+RNBD_MSG_SESS_INFO to the server. Server responds with
+RNBD_MSG_SESS_INFO_RSP. Currently the messages only contain the protocol
+version for backward compatibility.
+
+2. Client requests to open a device by sending RNBD_MSG_OPEN message. This
+contains the path to the device and access mode (read-only or writable).
+Server responds to the message with RNBD_MSG_OPEN_RSP. This contains
+a 32 bit device id to be used for  IOs and device "geometry" related
+information: side, max_hw_sectors, etc.
+
+3. Client attaches RNBD_MSG_IO to each IO message send to a device. This
+message contains device id, provided by server in his rnbd_msg_open_rsp,
+sector to be accessed, read-write flags and bi_size.
+
+4. Client closes a device by sending RNBD_MSG_CLOSE which contains only the
+device id provided by the server.
-- 
2.17.1

