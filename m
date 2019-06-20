Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C99E64D17F
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 17:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbfFTPEM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 11:04:12 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41123 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732078AbfFTPEM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jun 2019 11:04:12 -0400
Received: by mail-ed1-f68.google.com with SMTP id p15so5158226eds.8;
        Thu, 20 Jun 2019 08:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LzlCNDp64NuPlKfXhfEWCmJt9/T8xxDUmRy5t+RKNns=;
        b=K0kIXXspDHaZbCI8ZvGC1jbdrvch6vlLTNlQD+GcDu9gtcYefSge7BKhwlSfWeFtpz
         DBJieQemGSU29ZInA30MMxuaa+L0vjbowmksPYEdvv6kpGjThvLKHOBVypDkWoyxBGlk
         IllFA/aOajPncP1KS3zPA2zk3UiwvzRpiE4mym97zuTa3TgNbZbQWBJR5xjEl3i0/Rmn
         LtLb2y4UghgWIEVRFauRvI9dZ4MBmrUWSgii86z5pRe6GTH2sDph6VaS0Seb2mYtgvzv
         yTzEXUW8RGdCe32Y3zfuWwE7gLZBsdEuFo9IRolj4OrbCq9hakHNJ/yMK6PrPFXUQ/9H
         X+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LzlCNDp64NuPlKfXhfEWCmJt9/T8xxDUmRy5t+RKNns=;
        b=FnJmHLedyTIOEZ+vyGjke6R3Mb5RrLlgkChDpXMwNa4sO7U1naeG+MFymN2fdXcJDV
         u3pmsHJNFkWP1mKwpDZr+r99gprMLar81uV0SiEeZUwYSZGvhSsshXDfhaQ+p4PFbVgP
         fTmxoPMZOAlOP4VNnmaJONTJjyNRpGbLrdQCgqvC4ugyyo74rz9FX3UGDwNblFTyoin6
         kSmvQ3yz1BxxMtsRpoE60smmFADcKIEyZ0rBd5TIAEpYmKxqk+Ojg9aXB/okJsx4nWDz
         3tA4mDPza3f+DaHtvBUQWoWznuN/oR+018AcAPs798a5XhtWNGeE/+hP+a84TUs/sp5E
         Sv6A==
X-Gm-Message-State: APjAAAVwoufE1GetEu428goSo9qAfc0TCQb891UA+XbVDKEbBc4Xgx/S
        eV0JVq/Z/g0gIJevdk7wJOstygX2Jt8=
X-Google-Smtp-Source: APXvYqw6Bly4Ag92kFZcMTW+YALMYQOtay17bsXWKBzuh/7zcq7n4hutewvAWoJk6jmyQMjZPanMNw==
X-Received: by 2002:a17:906:4e57:: with SMTP id g23mr39230182ejw.52.1561043049561;
        Thu, 20 Jun 2019 08:04:09 -0700 (PDT)
Received: from jwang-Latitude-5491.pb.local ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id a20sm3855817ejj.21.2019.06.20.08.04.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 08:04:09 -0700 (PDT)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v4 24/25] ibnbd: a bit of documentation
Date:   Thu, 20 Jun 2019 17:03:36 +0200
Message-Id: <20190620150337.7847-25-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620150337.7847-1-jinpuwang@gmail.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Roman Pen <roman.penyaev@profitbricks.com>

README with description of major sysfs entries.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/ibnbd/README | 315 +++++++++++++++++++++++++++++++++++++
 1 file changed, 315 insertions(+)
 create mode 100644 drivers/block/ibnbd/README

diff --git a/drivers/block/ibnbd/README b/drivers/block/ibnbd/README
new file mode 100644
index 000000000000..ce9293c290b9
--- /dev/null
+++ b/drivers/block/ibnbd/README
@@ -0,0 +1,315 @@
+***************************************
+Infiniband Network Block Device (IBNBD)
+***************************************
+
+Introduction
+------------
+
+IBNBD (InfiniBand Network Block Device) is a pair of kernel modules
+(client and server) that allow for remote access of a block device on
+the server over IBTRS protocol using the RDMA (InfiniBand, RoCE, iWarp)
+transport. After being mapped, the remote block devices can be accessed
+on the client side as local block devices.
+
+I/O is transferred between client and server by the IBTRS transport
+modules. The administration of IBNBD and IBTRS modules is done via
+sysfs entries.
+
+Requirements
+------------
+
+  IBTRS kernel modules
+
+Quick Start
+-----------
+
+Server side:
+  # modprobe ibnbd_server
+
+Client side:
+  # modprobe ibnbd_client
+  # echo "sessname=blya path=ip:10.50.100.66 device_path=/dev/ram0" > \
+            /sys/devices/virtual/ibnbd-client/ctl/map_device
+
+  Where "sessname=" is a session name, a string to identify the session
+  on client and on server sides; "path=" is a destination IP address or
+  a pair of a source and a destination IPs, separated by comma.  Multiple
+  "path=" options can be specified in order to use multipath  (see IBTRS
+  description for details); "device_path=" is the block device to be
+  mapped from the server side. After the session to the server machine is
+  established, the mapped device will appear on the client side under
+  /dev/ibnbd<N>.
+
+
+======================
+Client Sysfs Interface
+======================
+
+All sysfs files that are not read-only provide the usage information on read:
+
+Example:
+  # cat /sys/devices/virtual/ibnbd-client/ctl/map_device
+
+  > Usage: echo "sessname=<name of the ibtrs session> path=<[srcaddr,]dstaddr>
+  > [path=<[srcaddr,]dstaddr>] device_path=<full path on remote side>
+  > [access_mode=<ro|rw|migration>]
+  > [io_mode=<fileio|blockio>]" > map_device
+  >
+  > addr ::= [ ip:<ipv4> | ip:<ipv6> | gid:<gid> ]
+
+Entries under /sys/devices/virtual/ibnbd-client/ctl/
+=======================================
+
+map_device (RW)
+---------------
+
+Expected format is the following:
+
+    sessname=<name of the ibtrs session>
+    path=<[srcaddr,]dstaddr> [path=<[srcaddr,]dstaddr> ...]
+    device_path=<full path on remote side>
+    [access_mode=<ro|rw|migration>]
+    [io_mode=<fileio|blockio>]
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
+          the selected multipath policy (see IBTRS mp_policy sysfs entry
+          description).
+
+device_path: Path to the block device on the server side. Path is specified
+         relative to the directory on server side configured in the
+         'dev_search_path' module parameter of the ibnbd_server.
+         The ibnbd_server prepends the <device_path> received from client
+         with <dev_search_path> and tries to open the
+         <dev_search_path>/<device_path> block device.  On success,
+         a /dev/ibnbd<N> device file, a /sys/block/ibnbd_client/ibnbd<N>/
+         directory and an entry in /sys/devices/virtual/ibnbd-client/ctl/devices
+         will be created.
+
+         If 'dev_search_path' contains '%SESSNAME%', then each session can
+         have different devices namespace, e.g. server was configured with
+         the following parameter "dev_search_path=/run/ibnbd-devs/%SESSNAME%",
+         client has this string "sessname=blya device_path=sda", then server
+         will try to open: /run/ibnbd-devs/blya/sda.
+
+access_mode: the access_mode parameter specifies if the device is to be
+             mapped as "ro" read-only or "rw" read-write. The server allows
+             a device to be exported in rw mode only once. The "migration"
+             access mode has to be specified if a second mapping in read-write
+             mode is desired.
+
+             By default "rw" is used.
+
+io_mode:  the io_mode parameter specifies if the device on the server
+          will be opened as block device "blockio" or as file "fileio".
+          When the device is opened as file, the VFS page cache is used
+          for read I/O operations, write I/O operations bypass the page
+          cache and go directly to disk (except meta updates, like file
+          access time).
+
+          By default "blockio" mode is used.
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
+ o  The symlink /sys/devices/virtual/ibnbd-client/ctl/devices/<device_id>
+    points to /sys/block/<dev-name>. The last part of the symlink destination
+    is the same as the device name.  By extracting the last part of the
+    path the path to the device /dev/<dev-name> can be build.
+
+ o /dev/block/$(cat /sys/devices/virtual/ibnbd-client/ctl/devices/<device_id>/dev)
+
+How to find the <device_id> of the device is described on the next
+section.
+
+Entries under /sys/devices/virtual/ibnbd-client/ctl/devices/
+============================================================
+
+For each device mapped on the client a new symbolic link is created as
+/sys/devices/virtual/ibnbd-client/ctl/devices/<device_id>, which points
+to the block device created by ibnbd (/sys/block/ibnbd<N>/).
+The <device_id> of each device is created as follows:
+
+- If the 'device_path' provided during mapping contains slashes ("/"),
+  they are replaced by exclamation mark ("!") and used as as the
+  <device_id>. Otherwise, the <device_id> will be the same as the
+  "device_path" provided.
+
+Entries under /sys/block/ibnbd<N>/ibnbd_client/
+===============================================
+
+unmap_device (RW)
+-----------------
+
+To unmap a volume, "normal" or "force" has to be written to:
+  /sys/block/ibnbd<N>/ibnbd_client/unmap_device
+
+When "normal" is used, the operation will fail with EBUSY if any process
+is using the device.  When "force" is used, the device is also unmapped
+when device is in use.  All I/Os that are in progress will fail.
+
+Example:
+
+   # echo "normal" > /sys/block/ibnbd0/ibnbd/unmap_device
+
+state (RO)
+----------
+
+The file contains the current state of the block device. The state file
+returns "open" when the device is successfully mapped from the server
+and accepting I/O requests. When the connection to the server gets
+disconnected in case of an error (e.g. link failure), the state file
+returns "closed" and all I/O requests submitted to it will fail with -EIO.
+
+session (RO)
+------------
+
+IBNBD uses IBTRS session to transport the data between client and
+server.  The entry "session" contains the name of the session, that
+was used to establish the IBTRS session.  It's the same name that
+was passed as server parameter to the map_device entry.
+
+mapping_path (RO)
+-----------------
+
+Contains the path that was passed as "device_path" to the map_device
+operation.
+
+io_mode (RO)
+------------
+
+Contains the way device is accessed: blockio or fileio
+
+access_mode (RO)
+----------------
+
+Contains the device access mode: ro, rw or migration.
+
+======================
+Server Sysfs Interface
+======================
+
+Entries under /sys/devices/virtual/ibnbd-server/ctl/
+====================================================
+
+When a client maps a device, a directory entry with the name of the
+block device is created under /sys/devices/virtual/ibnbd-server/ctl/devices/.
+
+Entries under /sys/devices/virtual/ibnbd-server/ctl/devices/<device_name>/
+==========================================================================
+
+block_dev (link)
+---------------
+
+Is a symlink to the sysfs entry of the exported device.
+
+Example:
+
+  block_dev -> ../../../../devices/virtual/block/ram0
+
+io_mode (RO)
+-----------
+
+Contains the way device is accessed: blockio or fileio
+
+Entries under /sys/devices/virtual/ibnbd-server/ctl/devices/<device_name>/sessions/
+===================================================================================
+
+For each client a particular device is exported to, following directory will be
+created:
+
+/sys/devices/virtual/ibnbd-server/ctl/devices/<device_name>/sessions/<session-name>/
+
+When the device is unmapped by that client, the directory will be removed.
+
+Entries under /sys/devices/virtual/ibnbd-server/ctl/devices/<device_name>/sessions/<session-name>
+=================================================================================================
+
+read_only (RO)
+--------------
+
+Contains '1' if device is mapped read-only, otherwise '0'.
+
+mapping_path (RO)
+-----------------
+
+Contains the relative device path provided by the user during mapping.
+
+access_mode (RO)
+-----------------
+
+Contains the device access mode: ro, rw or migration.
+
+
+==============================
+IBNBD-Server Module Parameters
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
+Protocol (ibnbd/ibnbd-proto.h)
+==============================
+
+1. Before mapping first device from a given server, client sends an
+IBNBD_MSG_SESS_INFO to the server. Server responds with
+IBNBD_MSG_SESS_INFO_RSP. Currently the messages only contain the protocol
+version for backward compatibility.
+
+2. Client requests to open a device by sending IBNBD_MSG_OPEN message. This
+contains the path to the device, access mode (read-only or writable), and
+io_mode which specifies if the device should be opened as block device or
+using file io. Server responds to the message with IBNBD_MSG_OPEN_RSP. This
+contains a 32 bit device id to be used for  IOs and device "geometry" related
+information: side, max_hw_sectors, etc.
+
+3. Client attaches IBNBD_MSG_IO to each IO message send to a device. This
+message contains device id, provided by server in his ibnbd_msg_open_rsp,
+sector to be accessed, read-write flags and bi_size.
+
+4. Client closes a device by sending IBNBD_MSG_CLOSE which contains only the
+device id provided by the server.
+
-- 
2.17.1

