Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0894B65A2
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 09:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiBOIPT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 03:15:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiBOIPS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 03:15:18 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E5D6D4C5
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 00:15:03 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id w20so12514957plq.12
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 00:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QFG7HIg3hA31QUp+RE/ETvWFXivtKdFpOm7NUNPrQ9o=;
        b=gfV3yt3DqNdrAZuXHOnQMR3dEEUJ6kqqEAjEahbA1F47Yr6C2o0NDVMeSeXxrFS0Su
         FaNFdLb3DFKdR83Uodp6bt3rUNdQ32oZDgy+PYXr1zDPAS0aYcA0qvOrvRJNYEK13uNV
         1gaJfHPBA74O4Q7R3EEm2ELJpaOElHixWooN2KhQkwnyFydklRZ4U0rWJQj0kRdwdtM0
         /rjxvglJu/KZHahOLMM/gtZNmenAUwmvFf+z9SyBeov4xCsvyT0yLDla+mZnoniaAPRi
         2XsjBlHeJv8EpFEGRLglZC6WNux7/JXNbuGj+aCv0LuxTVlvdrwjZaM1USKyoeDk2awF
         REHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QFG7HIg3hA31QUp+RE/ETvWFXivtKdFpOm7NUNPrQ9o=;
        b=cobIkdM690DW7rC7tGDwq7/9E8dqtOqpOw1HNeILTUMVrqKPOHuRzmz3TzAAgqlvGy
         BxPWbuBkUug016PmPrcYUW3C4bXKp9jG6QKq2CqI7g20luTkvx8ATjtabkHFKu02/qb8
         r/uLyfYmfP/rtftozfuCzHHBnTt+yY0GHV0xWI47MQnYS5x9WoAZDbhbvG173iZPmU0R
         Iq+wd24dfQcA4ieNGfAi/fEHRJV36s+Yhps3y978FpsyxUuUpxrAnd96pHHy7II2ZAn8
         sAweoa9meec/V3vZbRHUkqAMbkSYWrwJ2HZJuSezzP+SiwY2PTnGn6+H8BSV3Zsqtxh/
         3e5g==
X-Gm-Message-State: AOAM532PrbnnRJjKEcNCAcA3oU8lfD40/bW+CCtL5xSDTEs9RCQnqcTo
        XSgnEoCsuGHedcS7WeJbGiGYE3qr/QcxNw==
X-Google-Smtp-Source: ABdhPJzHpEKV+WFPvmzxtpKGGFWHW4yxDFbrIl5qfkcIrO6ryqW56ss2zM0ecX4yz2n8DFOugfcfwg==
X-Received: by 2002:a17:902:c10d:: with SMTP id 13mr2863671pli.92.1644912903005;
        Tue, 15 Feb 2022 00:15:03 -0800 (PST)
Received: from C02FR1DUMD6V.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id u21sm1350398pfi.163.2022.02.15.00.14.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Feb 2022 00:15:02 -0800 (PST)
From:   Junji Wei <weijunji@bytedance.com>
To:     dledford@redhat.com, jgg@ziepe.ca, mst@redhat.com,
        jasowang@redhat.com, yuval.shaia.ml@gmail.com,
        marcel.apfelbaum@gmail.com, cohuck@redhat.com, hare@suse.de,
        virtio-dev@lists.oasis-open.org
Cc:     xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
        weijunji@bytedance.com, duanxiongchun@bytedance.com,
        zhoujielong@bytedance.com, zhangqianyu.sys@bytedance.com,
        linux-rdma@vger.kernel.org
Subject: [RFC] Virtio RDMA
Date:   Tue, 15 Feb 2022 16:13:53 +0800
Message-Id: <20220215081353.10351-1-weijunji@bytedance.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

This RFC aims to introduce our recent work on VirtIO-RDMA.

We have finished a draft of VirtIO-RDMA specification and a vhost-user
RDMA demo based on the spec.This demo can work with CM/Socket
and UD/RC QP now.

NOTE that this spec now only focuses on emulating a soft
RoCE (RDMA over Converged Ethernet) device with normal Network Interface
Card (without RDMA capability). So most Infiniband (IB) specific features
such as Subnet Manager (SM), Local Identifier (LID) and Automatic Path
Migration (APM) are not covered in this specification.

There are four parts of our work:

1. VirtIO-RDMA driver in linux kernel:
https://github.com/weijunji/linux/tree/virtio-rdma-patch

2. VirtIO-RDMA userspace provider in rdma-core:
https://github.com/weijunji/rdma-core/tree/virtio-rdma

3. VHost-User RDMA backend in QEMU:
https://github.com/weijunji/qemu/tree/vhost-user-rdma

4. VHost-User RDMA demo implements with DPDK:
https://github.com/weijunji/dpdk-rdma


To test with our demo:

1. Build Linux kernel with config INFINIBAND_VIRTIO_RDMA

2. Build QEMU with config VHOST_USER_RDMA

3. Build rdma-core and install it to VM image

4. Build and install DPDK(NOTE that we only tested on DPDK 20.11.3)

5. Build dpdk-rdma:
    $ cd dpdk-rdma
    $ meson build
    $ cd build
    $ ninja

6. Run dpdk-rdma:
    $ sudo ./dpdk-rdma --vdev 'net_vhost0,iface=/tmp/sock0,queues=1' \
      --vdev 'net_tap0' --lcore '1-3'
    $ sudo brctl addif virbr0 dtap0

7. Boot kernel with qemu with following args using libvirt:
<qemu:commandline>
    <qemu:arg value='-chardev'/>
    <qemu:arg value='socket,path=/tmp/sock0,id=vunet'/>
    <qemu:arg value='-netdev'/>
    <qemu:arg value='vhost-user,id=net1,chardev=vunet,vhostforce,queues=1'/>
    <qemu:arg value='-device'/>
    <qemu:arg value='virtio-net-pci,netdev=net1,bus=pci.0,multifunction=on,addr=0x2'/>
    <qemu:arg value='-chardev'/>
    <qemu:arg value='socket,path=/tmp/vhost-rdma0,id=vurdma'/>
    <qemu:arg value='-device'/>
    <qemu:arg value='vhost-user-rdma-pci,page-per-vq,disable-legacy=on,addr=2.1,chardev=vurdma'/>
</qemu:commandline>

NOTE that virtio-net-pci and vhost-user-rdma-pci MUST in same PCI addresss.

8. Add rxe device on libvirt's virbr0
    $ sudo rdma link add rxe0 type rxe netdev virbr0

9. Run test server in host:
    $ ib_write_bw -s 512 -d rxe0

10. Run test client in VM:
    $ ib_write_bw -s 512 <virbr0 IP>

We have already tested with ibv_rc_pingpong, ibv_ud_pingpong,
ib_write_bw, ib_send_bw, rping and some others in rdma-core.

TODO:

1. Add support for MW(Memory Window)

2. Add support for SRQ

3. Add support for resize of CQ&QP

4. Allocate VirtQueue on demand

5. Reset of VirtQueue

6. Increase size of VirtQueue for PCI transport

Please review, thanks!

Co-developed-by: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Junji Wei <weijunji@bytedance.com>
---
 conformance.tex |   38 +-
 content.tex     |    1 +
 virtio-rdma.tex | 1166 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1201 insertions(+), 4 deletions(-)
 create mode 100644 virtio-rdma.tex

diff --git a/conformance.tex b/conformance.tex
index 42f8537..d5a4b6a 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -32,8 +32,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance},
-\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance} or
-\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance}.
+\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance},
+\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance} or
+\ref{sec:Conformance / Driver Conformance / RDMA Driver Conformance}.
 
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
@@ -58,8 +59,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
 \ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance},
 \ref{sec:Conformance / Device Conformance / SCMI Device Conformance},
-\ref{sec:Conformance / Device Conformance / GPIO Device Conformance} or
-\ref{sec:Conformance / Device Conformance / PMEM Device Conformance}.
+\ref{sec:Conformance / Device Conformance / GPIO Device Conformance},
+\ref{sec:Conformance / Device Conformance / PMEM Device Conformance} or
+\ref{sec:Conformance / Device Conformance / RDMA Device Conformance}.
 
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
@@ -324,6 +326,20 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Device Types / PMEM Device / Device Initialization}
 \end{itemize}
 
+\conformance{\subsection}{RDMA Driver Conformance}\label{sec:Conformance / Driver Conformance / RDMA Driver Conformance}
+
+A RDMA driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / RDMA Device / Device configuration layout}
+\item \ref{drivernormative:Device Types / RDMA Device / Send/Receive Operation}
+\item \ref{drivernormative:Device Types / RDMA Device / Read Operation}
+\item \ref{drivernormative:Device Types / RDMA Device / Write Operation}
+\item \ref{drivernormative:Device Types / RDMA Device / Atomic Operation}
+\item \ref{drivernormative:Device Types / RDMA Device / Local Invalidate Operation}
+\item \ref{drivernormative:Device Types / RDMA Device / Fast Register Memory Region}
+\end{itemize}
+
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
 
 A device MUST conform to the following normative statements:
@@ -593,6 +609,20 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Device Types / PMEM Device / Device Operation / Virtqueue return}
 \end{itemize}
 
+\conformance{\subsection}{RDMA Device Conformance}\label{sec:Conformance / Device Conformance / RDMA Device Conformance}
+
+A RDMA device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / RDMA Device / Device configuration layout}
+\item \ref{devicenormative:Device Types / RDMA Device / Send/Receive Operation}
+\item \ref{devicenormative:Device Types / RDMA Device / Read Operation}
+\item \ref{devicenormative:Device Types / RDMA Device / Write Operation}
+\item \ref{devicenormative:Device Types / RDMA Device / Atomic Operation}
+\item \ref{devicenormative:Device Types / RDMA Device / Local Invalidate Operation}
+\item \ref{devicenormative:Device Types / RDMA Device / Fast Register Memory Region}
+\end{itemize}
+
 \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
 non-transitional, see \ref{intro:Legacy
diff --git a/content.tex b/content.tex
index 32de668..cfc41c3 100644
--- a/content.tex
+++ b/content.tex
@@ -6754,6 +6754,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
 \input{virtio-scmi.tex}
 \input{virtio-gpio.tex}
 \input{virtio-pmem.tex}
+\input{virtio-rdma.tex}
 
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
diff --git a/virtio-rdma.tex b/virtio-rdma.tex
new file mode 100644
index 0000000..9b0a0e6
--- /dev/null
+++ b/virtio-rdma.tex
@@ -0,0 +1,1166 @@
+\section{RDMA Device}\label{sec:Device Types / RDMA Device}
+
+The virtio-rdma device is a virtual Remote Direct Memory Access (RDMA)
+enabled Host Channel Adapter (HCA). It has a single control queue and multiple
+types of data queues including Completion Queue (CQ), Send Queue (SQ) and
+Receive Queue (RQ). The send and receive queues are collectively called Queue
+Pair (QP) since they are always created in pairs. The entry placed in the send
+queue and receive queue is called Work Queue Element (WQE). A WQE in send queue
+contains a pointer to buffer that has to be sent to client.
+Whereas, a WQE placed in receive queue contains a pointer to a
+buffer that will hold the incoming message. Once a transaction is completed, a
+Completion Queue Element (CQE) will be placed in the completion queue to notify
+the completion.
+
+Now this specification only focuses on emulating a soft
+RoCE (RDMA over Converged Ethernet) device with normal Network Interface
+Card (without RDMA capability). So most Infiniband (IB) specific features such
+as Subnet Manager (SM), Local Identifier (LID) and Automatic Path
+Migration (APM) are not covered in this specification.
+
+\subsection{Device ID}\label{sec:Device Types / RDMA Device / Device ID}
+  42
+
+\subsection{Virtqueues}\label{sec:Device Types / RDMA Device / Virtqueues}
+\begin{description}
+\item[0] control
+\item[1] cq1
+\item[\ldots] 
+\item[N] cqN
+\item[N+1] sq1
+\item[N+2] rq1
+\item[\ldots] 
+\item[N+2M-1] sqM
+\item[N+2M] rqM
+\end{description}
+
+N = max_cq, M = max_qp.
+
+\subsection{Feature bits}\label{sec:Device Types / RDMA Device / Feature bits}
+
+There are currently no feature bits defined for this device.
+
+\subsection{Device configuration layout}\label{sec:Device Types / RDMA Device / Device configuration layout}
+
+Below HCA capabilities are currently defined for the device_cap_flags field:
+
+\begin{lstlisting}
+enum ib_device_cap_flags {
+    /* Support Bad P_Key Counter */
+    IB_DEVICE_BAD_PKEY_CNTR = (1 << 1),
+    /* Support Q_Key violation counter */
+    IB_DEVICE_BAD_QKEY_CNTR = (1 << 2),
+    /* Support changing the QP's primary port number */
+    IB_DEVICE_CHANGE_PHY_PORT = (1 << 5),
+    /* Support enforcements of the port number of Address Handle (UD QP) */
+    IB_DEVICE_UD_AV_PORT_ENFORCE = (1 << 6),
+    /* Support system image GUID */
+    IB_DEVICE_SYS_IMAGE_GUID = (1 << 11),
+    /* Support RNR-NAK generation for RC QPs */
+    IB_DEVICE_RC_RNR_NAK_GEN = (1 << 12),
+    /*
+    * Support the IB "base memory management extension"
+    * which includes support for fast registrations (IB_WR_REG_MR,
+    * IB_WR_LOCAL_INV and IB_WR_SEND_WITH_INV verbs).
+    */
+    IB_DEVICE_MEM_MGT_EXTENSIONS = (1 << 21),
+    /* Support blocking multicast loopback */
+    IB_DEVICE_BLOCK_MULTICAST_LOOPBACK = (1 << 22),
+    /* support sg list mapping */
+    IB_DEVICE_SG_GAPS_REG = (1 << 32),
+};
+\end{lstlisting}
+
+Three atomic capabilities are currently defined for the atomic_cap field:
+
+\begin{lstlisting}
+enum {
+    /* Atomic operations are not supported at all */
+    VIRTIO_IB_ATOMIC_NONE,
+    /* Atomicity is guaranteed between QPs on this device only */
+    VIRTIO_IB_ATOMIC_HCA,
+    /*
+    * Atomicity is guaranteed between this device and any other
+    * component, such as CPUs and other devices
+    */
+    VIRTIO_IB_ATOMIC_GLOB
+};
+\end{lstlisting}
+
+RDMA device configuration uses the following layout structure,
+all of the following configuration fields currently defined are driver-read-only:
+
+\begin{lstlisting}
+struct virtio_rdma_config {
+    /* Number of port */
+    le32 phys_port_cnt;
+    /* System image GUID (in network byte order) */
+    le64 sys_image_guid;
+    /* Vendor ID, per IEEE */
+    le32 vendor_id;
+    /* Vendor supplied part ID */
+    le32 vendor_part_id;
+    /* Hardware version */
+    le32 hw_ver;
+    /* Largest contiguous block that can be registered */
+    le64 max_mr_size;
+    /* Supported memory shift sizes */
+    le64 page_size_cap;
+    /* Maximum number of supported QPs */
+    le32 max_qp;
+    /* Maximum number of outstanding WR on any work queue */
+    le32 max_qp_wr;
+    /* HCA capabilities mask, enum ib_device_cap_flags */
+    le64 device_cap_flags;
+    /* Maximum number of s/g per WR for SQ for non RDMA Read operations */
+    le32 max_send_sge;
+    /* Maximum number of s/g per WR for RQ for non RDMA Read operations */
+    le32 max_recv_sge; 
+    /* Maximum number of s/g per WR for RDMA Read operations */
+    le32 max_sge_rd; 
+    /* Maximum number of supported CQs */
+    le32 max_cq;
+    /* Maximum number of CQE capacity per CQ */
+    le32 max_cqe;
+    /* Maximum number of supported MRs */
+    le32 max_mr;
+    /* Maximum number of supported PDs */
+    le32 max_pd;
+    /* Maximum number of RDMA Read & Atomic operations that can be outstanding per QP */
+    le32 max_qp_rd_atom;
+    /* Maximum number of resources used for RDMA Read & Atomic operations by this HCA as the Target */
+    le32 max_res_rd_atom;
+    /* Maximum depth per QP for initiation of RDMA Read & Atomic operations */
+    le32 max_qp_init_rd_atom;
+    /* Atomic operations support level, enum ib_atomic_cap */
+    u8 atomic_cap;
+    /* Maximum number of supported MWs */
+    le32 max_mw;
+    /* Maximum number of supported multicast groups */
+    le32 max_mcast_grp;
+    /* Maximum number of QPs per multicast group which can be attached */
+    le32 max_mcast_qp_attach;
+    /* Maximum number of QPs which can be attached to multicast groups */
+    le32 max_total_mcast_qp_attach;
+    /* Maximum number of supported address handles */
+    le32 max_ah;
+    /* Maximum number page list length for fast registration operation */
+    le32 max_fast_reg_page_list_len;
+    /* Maximum number page list length for PI (protection information) fast registration operation */
+    le32 max_pi_fast_reg_page_list_len;
+    /* Maximum number of partitions */
+    le16 max_pkeys;
+    /* Local CA ack delay */
+    u8 local_ca_ack_delay;
+    /* Reserved for future */
+    le64 reserved[64];
+};
+\end{lstlisting}
+
+\devicenormative{\subsubsection}{Device configuration layout}{Device Types / RDMA Device / Device configuration layout}
+
+\begin{itemize*}
+\item The device MUST set max_cq to between 1 and 16384 inclusive.
+\item The device MUST set max_qp to between 1 and 16384 inclusive.
+\end{itemize*}
+
+\drivernormative{\subsubsection}{Device configuration layout}{Device Types / RDMA Device / Device configuration layout}
+
+\begin{itemize*}
+\item The driver MUST NOT write to config.
+\end{itemize*}
+
+\subsection{Device Initialization}\label{sec:Device Types / RDMA Device / Device Initialization}
+
+A driver would perform a typical initialization routine like so:
+
+\begin{itemize*}
+\item Identify and initialize the control virtqueue
+\item Identify the completion virtqueues, up to max_cq.
+\item Identify the receive and send virtqueues, up to max_qp of each kind.
+\item Bind a virtio-net device
+\end{itemize*}
+
+\subsection{Device Operation: controlq}\label{sec:Device Types / RDMA Device / controlq Operation}
+
+The control virtqueue is used for control path opeartion. Requests have the following format:
+
+\begin{lstlisting}
+struct virtio_rdma_ctrl_req {
+    /* Device-readable part */
+    u8 command;
+    u8 command-specific-request-data[];
+    
+    /* Device-writable part */
+    u8 response;
+    u8 command-specific-response-data[];
+};
+\end{lstlisting}
+
+Command identifies the request data and response data.
+
+The following commands are defined:
+
+\begin{lstlisting}
+enum {
+    VIRTIO_CMD_QUERY_PORT = 1,
+    VIRTIO_CMD_CREATE_CQ,
+    VIRTIO_CMD_DESTROY_CQ,
+    VIRTIO_CMD_CREATE_PD,
+    VIRTIO_CMD_DESTROY_PD,
+    VIRTIO_CMD_GET_DMA_MR,
+    VIRTIO_CMD_CREATE_MR,
+    VIRTIO_CMD_MAP_MR_SG,
+    VIRTIO_CMD_REG_USER_MR,
+    VIRTIO_CMD_DEREG_MR,
+    VIRTIO_CMD_CREATE_QP,
+    VIRTIO_CMD_MODIFY_QP,
+    VIRTIO_CMD_QUERY_QP,
+    VIRTIO_CMD_DESTROY_QP,
+    VIRTIO_CMD_QUERY_PKEY,
+    VIRTIO_CMD_ADD_GID,
+    VIRTIO_CMD_DEL_GID,
+    VIRTIO_CMD_REQ_NOTIFY_CQ,
+};
+\end{lstlisting}
+
+\subsubsection{controlq Operation: Query Port}\label{sec:Device Types / RDMA Device / controlq Operation / Query Port}
+
+Query the attributes of a port. The command equals to VIRTIO_CMD_QUERY_PORT.
+The request data is struct cmd_query_port; the response data is struct resp_query_port.
+
+\begin{lstlisting}
+struct cmd_query_port {
+    /* port number */
+    u8 port;
+};
+
+enum ib_port_capability_mask_bits {
+    /* This port supports CM (Connection Management) */
+    IB_PORT_CM_SUP = 1 << 16,
+}
+
+enum ib_port_state {
+    IB_PORT_NOP = 0,
+    IB_PORT_DOWN = 1,
+    IB_PORT_INIT = 2,
+    IB_PORT_ARMED = 3,
+    IB_PORT_ACTIVE = 4,
+    IB_PORT_ACTIVE_DEFER = 5
+};
+
+enum ib_port_phys_state {
+    IB_PORT_PHYS_STATE_SLEEP = 1,
+    IB_PORT_PHYS_STATE_POLLING = 2,
+    IB_PORT_PHYS_STATE_DISABLED = 3,
+    IB_PORT_PHYS_STATE_PORT_CONFIGURATION_TRAINING = 4,
+    IB_PORT_PHYS_STATE_LINK_UP = 5,
+    IB_PORT_PHYS_STATE_LINK_ERROR_RECOVERY = 6,
+    IB_PORT_PHYS_STATE_PHY_TEST = 7,
+};
+
+enum ib_mtu {
+    IB_MTU_256 = 1,
+    IB_MTU_512 = 2,
+    IB_MTU_1024 = 3,
+    IB_MTU_2048 = 4,
+    IB_MTU_4096 = 5
+};
+
+enum ib_port_speed {
+    IB_SPEED_SDR = 1,
+    IB_SPEED_DDR = 2,
+    IB_SPEED_QDR = 4,
+    IB_SPEED_FDR10 = 8,
+    IB_SPEED_FDR = 16,
+    IB_SPEED_EDR = 32,
+    IB_SPEED_HDR = 64,
+    IB_SPEED_NDR = 128,
+};
+
+enum ib_port_width {
+    IB_WIDTH_1X = 1,
+    IB_WIDTH_2X = 16,
+    IB_WIDTH_4X = 2,
+    IB_WIDTH_8X = 4,
+    IB_WIDTH_12X = 8
+};
+
+struct rsp_query_port {
+    /* Logical port state, enum ib_port_state */
+    u8 state;
+    /* Max MTU supported by port, enum ib_mtu */
+    u8 max_mtu;
+    /* Actual MTU, enum ib_mtu */
+    u8 active_mtu;
+    /* Physical MTU */
+    le32 phys_mtu;
+    /* Length of source GID table */
+    le32 gid_tbl_len;
+    /* Port CapabilityMask, enum ib_port_capability_mask_bits */
+    le32 port_cap_flags;
+    /* Maximum message size */
+    le32 max_msg_sz;
+    /* Bad P_Key counter */
+    le32 bad_pkey_cntr;
+    /* Q_Key violation counter */
+    le32 qkey_viol_cntr;
+    /* Length of partition table */
+    le16 pkey_tbl_len;
+    /* Currently active link width, enum ib_port_width */
+    u8 active_width;
+    /* Currently active link speed, enum ib_port_speed */
+    le16 active_speed;
+    /* Physical port state, enum ib_port_phys_state */
+    u8 phys_state;
+    /* Reserved for future */
+    le32 reserved[32];
+};
+\end{lstlisting}
+
+\subsubsection{controlq Operation: Create CQ}\label{sec:Device Types / RDMA Device / controlq Operation / Create CQ}
+
+Create a Completion Queue (CQ). The command equals to VIRTIO_CMD_CREATE_CQ.
+Request data is struct cmd_create_cq; response data is struct rsp_create_cq.
+
+The device SHOULD return the index of one available completion virtqueue.
+
+The driver MUST initialize the completion virtqueue.
+
+The driver MUST fill the completion virtqueue with buffers.
+
+\begin{lstlisting}
+struct cmd_create_cq {
+    /* Size of CQ */
+    le32 cqe;
+};
+
+struct rsp_create_cq {
+    /* Created CQ handle */
+    le32 cqn;
+};
+\end{lstlisting}
+
+\subsubsection{controlq Operation: Destroy CQ}\label{sec:Device Types / RDMA Device / controlq Operation / Destroy CQ}
+
+Destroy a Completion Queue (CQ). The command equals to VIRTIO_CMD_DESTROY_CQ.
+Request data is struct cmd_destroy_cq; no response data.
+
+The driver MUST reset the virtqueue after destroying the CQ.
+
+\begin{lstlisting}
+struct cmd_destroy_cq {
+    /* The handle of CQ need to be destroyed */
+    le32 cqn;
+};
+\end{lstlisting}
+
+\subsubsection{controlq Operation: Create PD}\label{sec:Device Types / RDMA Device / controlq Operation / Create PD}
+
+Create a Protection Domain (PD). The command equals to VIRTIO_CMD_CREATE_PD.
+No request data; response data is struct rsp_create_pd.
+
+\begin{lstlisting}
+struct rsp_create_pd {
+    /* Created PD handle */
+    le32 pdn;
+};
+\end{lstlisting}
+
+\subsubsection{controlq Operation: Destroy PD}\label{sec:Device Types / RDMA Device / controlq Operation / Destroy PD}
+
+Destroy a Protection Domain (PD). The command equals to VIRTIO_CMD_DESTROY_PD.
+Request data is struct cmd_destroy_qp; no response data.
+
+\begin{lstlisting}
+struct cmd_destroy_pd {
+    /* The handle of PD needs to be destroyed */
+    le32 pdn;
+};
+\end{lstlisting}
+
+\subsubsection{controlq Operation: Get DMA MR}\label{sec:Device Types / RDMA Device / controlq Operation / Get DMA MR}
+
+Get a DMA Memory Region (MR). The command equals to VIRTIO_CMD_GET_DMA_MR.
+Request data is struct cmd_get_dma_mr, response data is struct rsp_get_dma_mr.
+
+\begin{lstlisting}
+enum ib_access_flags {
+    IB_ACCESS_LOCAL_WRITE = 1 << 0,
+    IB_ACCESS_REMOTE_WRITE = 1 << 1,
+    IB_ACCESS_REMOTE_READ = 1 << 2,
+    IB_ACCESS_REMOTE_ATOMIC = 1 << 3,
+    IB_ACCESS_MW_BIND = 1 << 4,
+    IB_ACCESS_ZERO_BASED = 1 << 5,
+    IB_ACCESS_ON_DEMAND = 1 << 6,
+    IB_ACCESS_HUGETLB = 1 << 7,
+    IB_ACCESS_RELAXED_ORDERING = 1 << 20,
+};
+
+struct cmd_get_dma_mr {
+    /* The handle of PD which the MR associated with */
+    le32 pdn;
+    /* MR's protection attributes, enum ib_access_flags */
+    le32 access_flags;
+};
+
+struct rsp_get_dma_mr {
+    /* Created MR handle */
+    le32 mrn;
+    /* MR's local access key */
+    le32 lkey;
+    /* MR's remote access key */
+    le32 rkey;
+};
+\end{lstlisting}
+
+\subsubsection{controlq Operation: Create MR}\label{sec:Device Types / RDMA Device / controlq Operation / Create MR}
+
+Create a Memory Region (MR) associated with one PD. The command equals to VIRTIO_CMD_CREATE_MR.
+Request data is struct cmd_create_mr, response data is struct rsp_create_mr.
+
+Driver MUST NOT use this command if IB_DEVICE_MEM_MGT_EXTENSIONS is not set.
+
+\begin{lstlisting}
+struct cmd_create_mr {
+    /* The handle of PD which the MR associated with */
+    le32 pdn;
+    /* MR's protection attributes, enum ib_access_flags */
+    le32 access_flags;
+    /* Maximum number of scatter list */
+    le32 max_num_sg;
+};
+
+struct rsp_create_mr {
+    /* Created MR handle */
+    le32 mrn;
+    /* MR's local access key */
+    le32 lkey;
+    /* MR's remote access key */
+    le32 rkey;
+};
+\end{lstlisting}
+
+\subsubsection{controlq Operation: Map MR s/g}\label{sec:Device Types / RDMA Device / controlq Operation / Map MR s/g}
+
+Map scatter list to one MR. The command equals to VIRTIO_CMD_MAP_MR_SG.
+Request data is struct cmd_map_mr_sg, response data is struct rsp_map_mr_sg.
+pages is the address of the page table of mapped pages, length of array MUST be
+equal to npages.
+
+Driver MUST NOT use this command if IB_DEVICE_MEM_MGT_EXTENSIONS is not set.
+
+\begin{lstlisting}
+struct cmd_map_mr_sg {
+    /* The handle of MR */
+    le32 mrn;
+    /* Num pages need to map */
+    le32 npages;
+    /* Start address of MR */
+    le64 start;
+    /* Length of MR */
+    le64 length;
+    /* Page table's DMA address */
+    le64 pages;
+};
+
+struct rsp_map_mr_sg {
+    /* Num pages has been mapped */
+    le32 npages;
+};
+\end{lstlisting}
+
+\subsubsection{controlq Operation: Register User MR}\label{sec:Device Types / RDMA Device / controlq Operation / Register User MR}
+
+Register a user Memory Region (MR) associated with one PD. The command equals to VIRTIO_CMD_REG_USER_MR.
+Request data is struct cmd_reg_user_mr, response data is struct rsp_reg_user_mr.
+pages is the address of the page table of mapped pages, size of array MUST be
+equal to npages.
+
+\begin{lstlisting}
+struct cmd_reg_user_mr {
+    /* The handle of PD which the MR associated with */
+    le32 pdn;
+    /* MR's protection attributes, enum ib_access_flags */
+    le32 access_flags;
+    /* Start address of MR */
+    le64 start;
+    /* Length of MR */
+    le64 length;
+    /* IOVA of MR */
+    le64 virt_addr;
+    /* page table's DMA address */
+    le64 pages;
+    /* Num pages in page table */
+    le32 npages;
+};
+
+struct rsp_reg_user_mr {
+    /* MR handle */
+    le32 mrn;
+    /* MR's local access key */
+    le32 lkey;
+    /* MR's remote access key */
+    le32 rkey;
+};
+\end{lstlisting}
+
+\subsubsection{controlq Operation: Deregister MR}\label{sec:Device Types / RDMA Device / controlq Operation / Deregister MR}
+
+Deregister a Memory Region (MR). The command equals to VIRTIO_CMD_DEREG_MR.
+Request data is struct cmd_dereg_mr, no response data.
+
+\begin{lstlisting}
+struct cmd_dereg_mr {
+    /* The handle of MR needs to be destroyed */
+    le32 mrn;
+};
+\end{lstlisting}
+
+\subsubsection{controlq Operation: Create QP}\label{sec:Device Types / RDMA Device / controlq Operation / Create QP}
+
+Create a Queue Pair(QP). The command equals to VIRTIO_CMD_CREATE_QP.
+Request data is struct cmd_create_qp, response data is rsp_create_qp.
+
+The device MUST assign paired send queue and receive queue.
+
+The driver MUST initialize the send queue and receive queue.
+
+\begin{lstlisting}
+enum ib_qp_type {
+    IB_QPT_SMI,
+    IB_QPT_GSI,
+    IB_QPT_RC,
+    IB_QPT_UC,
+    IB_QPT_UD,
+};
+
+enum ib_sig_type {
+    IB_SIGNAL_ALL_WR,
+    IB_SIGNAL_REQ_WR
+};
+
+struct cmd_create_qp {
+    /* The handle of PD which the QP associated with */
+    le32 pdn;
+    /* QP's type, enum ib_qp_type */
+    u8 qp_type;
+    /* SQ's signal type, enum ib_sig_type */
+    u8 sq_sig_type;
+    /* Requested max number of outstanding WRs in the SQ */
+    le32 max_send_wr;
+    /* Requested max number of scatter/gather (s/g) elements in a WR in the SQ */
+    le32 max_send_sge;
+    /* CQ which the SQ associated with */
+    le32 send_cqn;
+    /* Requested max number of outstanding WRs in the RQ */
+    le32 max_recv_wr;
+    /* Requested max number of s/g elements in a WR in the RQ */
+    le32 max_recv_sge;
+    /* CQ which the RQ associated with */
+    le32 recv_cqn;
+    /* Requested max number of data (bytes) that can be posted inline to the SQ, otherwise 0 */
+    le32 max_inline_data;
+    /* Reserved for future */
+    le32 reserved[8];
+};
+
+struct rsp_create_qp {
+    /* Created QP handle */
+    le32 qpn;
+};
+\end{lstlisting}
+
+\subsubsection{controlq Operation: Modify QP}\label{sec:Device Types / RDMA Device / controlq Operation / Modify QP}
+
+Modify the attributes of a Queue Pair (QP). The command equals to VIRTIO_CMD_MODIFY_QP.
+Request data is struct cmd_modify_qp, no response data.
+The argument attr_mask specifies the QP attributes to be modified.
+
+\begin{lstlisting}
+enum ib_qp_state {
+    IB_QPS_RESET,
+    IB_QPS_INIT,
+    IB_QPS_RTR,
+    IB_QPS_RTS,
+    IB_QPS_SQD,
+    IB_QPS_SQE,
+    IB_QPS_ERR
+};
+
+enum ib_mig_state {
+    IB_MIG_MIGRATED,
+    IB_MIG_REARM,
+    IB_MIG_ARMED
+};
+
+union ib_gid {
+    u8 raw[16];
+    struct {
+        le64 subnet_prefix;
+        le64 interface_id;
+    } global;
+};
+
+struct virtio_rdma_global_route {
+    /* Destination GID or MGID */
+    union ib_gid dgid;
+    /* Flow label */
+    le32 flow_label;
+    /* Source GID index */
+    u8 sgid_index;
+    /* Hop limit */
+    u8 hop_limit;
+    /* Traffic class */
+    u8 traffic_class;
+};
+
+struct roce_ah_attr {
+    u8 dmac[ETH_ALEN];
+};
+
+enum ib_ah_flags {
+    IB_AH_GRH = 1
+};
+
+struct virtio_rdma_ah_attr {
+    /* Global Routing Header (GRH) attributes */
+    struct virtio_rdma_global_route grh;
+    /* Service Level */
+    u8 sl;
+    /* Maximum static rate */
+    u8 static_rate;
+    /* Physical port number */
+    u8 port_num;
+    /* enum ib_ah_flags */
+    u8 ah_flags;
+    /* RoCE address handle attribute */
+    struct roce_ah_attr roce;
+};
+
+struct virtio_rdma_qp_cap {
+    /* Requested max number of outstanding WRs in the SQ */
+    le32 max_send_wr;
+    /* Requested max number of outstanding WRs in the RQ */
+    le32 max_recv_wr;
+    /* Requested max number of scatter/gather (s/g) elements in a WR in the SQ */
+    le32 max_send_sge;
+    /* Requested max number of s/g elements in a WR in the RQ */
+    le32 max_recv_sge;
+    /* Requested max number of data (bytes) that can be posted inline to the SQ, otherwise 0 */
+    le32 max_inline_data;
+};
+
+struct virtio_rdma_qp_attr {
+    /* Move the QP to this state, enum ib_qp_state */
+    u8 qp_state;
+    /* Assume this is the current QP state, enum ib_qp_state */
+    u8 cur_qp_state;
+    /* Path MTU (valid only for RC/UC QPs), enum ib_mtu */
+    u8 path_mtu;
+    /* Path migration state (valid if HCA supports APM), enum ib_mig_state */
+    u8 path_mig_state;
+    /* Q_Key for the QP (valid only for UD QPs) */
+    le32 qkey;
+    /* PSN for receive queue (valid only for RC/UC QPs) */
+    le32 rq_psn;
+    /* PSN for send queue */
+    le32 sq_psn;
+    /* Destination QP number (valid only for RC/UC QPs) */
+    le32 dest_qp_num;
+    /* Mask of enabled remote access operations (valid only for RC/UC QPs), enum ib_access_flags */
+    le32 qp_access_flags;
+    /* Primary P_Key index */
+    le16 pkey_index;
+    /* Alternate P_Key index */
+    le16 alt_pkey_index;
+    /* Enable SQD.drained async notification (Valid only if qp_state is SQD) */
+    u8 en_sqd_async_notify;
+    /* Is the QP draining? Irrelevant for VIRTIO_CMD_MODIFY_QP */
+    u8 sq_draining;
+    /* Number of outstanding RDMA reads & atomic operations on the destination QP (valid only for RC QPs) */
+    u8 max_rd_atomic;
+    /* Number of responder resources for handling incoming RDMA reads & atomic operations (valid only for RC QPs) */
+    u8 max_dest_rd_atomic;
+    /* Minimum RNR NAK timer (valid only for RC QPs) */
+    u8 min_rnr_timer;
+    /* Primary port number */
+    u8 port_num;
+    /* Local ack timeout for primary path (valid only for RC QPs) */
+    u8 timeout;
+    /* Retry count (valid only for RC QPs) */
+    u8 retry_cnt;
+    /* RNR retry (valid only for RC QPs) */
+    u8 rnr_retry;
+    /* Alternate port number */
+    u8 alt_port_num;
+    /* Local ack timeout for alternate path (valid only for RC QPs) */
+    u8 alt_timeout;
+    /* Rate limit in kbps for packet pacing */
+    le32 rate_limit;
+    /* QP capabilities */
+    struct virtio_rdma_qp_cap cap;
+    /* Primary path address vector (valid only for RC/UC QPs) */
+    struct virtio_rdma_ah_attr ah_attr;
+    /* Alternate path address vector (valid only for RC/UC QPs) */
+    struct virtio_rdma_ah_attr alt_ah_attr;
+};
+
+enum ib_qp_attr_mask {
+    IB_QP_STATE = (1 << 0),
+    IB_QP_CUR_STATE = (1 << 1),
+    IB_QP_EN_SQD_ASYNC_NOTIFY = (1 << 2),
+    IB_QP_ACCESS_FLAGS = (1 << 3),
+    IB_QP_PKEY_INDEX = (1 << 4),
+    IB_QP_PORT = (1 << 5),
+    IB_QP_QKEY = (1 << 6),
+    IB_QP_AV = (1 << 7),
+    IB_QP_PATH_MTU = (1 << 8),
+    IB_QP_TIMEOUT = (1 << 9),
+    IB_QP_RETRY_CNT = (1 << 10),
+    IB_QP_RNR_RETRY = (1 << 11),
+    IB_QP_RQ_PSN = (1 << 12),
+    IB_QP_MAX_QP_RD_ATOMIC = (1 << 13),
+    IB_QP_ALT_PATH = (1 << 14),
+    IB_QP_MIN_RNR_TIMER = (1 << 15),
+    IB_QP_SQ_PSN = (1 << 16),
+    IB_QP_MAX_DEST_RD_ATOMIC = (1 << 17),
+    IB_QP_PATH_MIG_STATE = (1 << 18),
+    IB_QP_CAP = (1 << 19),
+    IB_QP_DEST_QPN = (1 << 20),
+    IB_QP_RESERVED1 = (1 << 21),
+    IB_QP_RESERVED2 = (1 << 22),
+    IB_QP_RESERVED3 = (1 << 23),
+    IB_QP_RESERVED4 = (1 << 24),
+    IB_QP_RATE_LIMIT = (1 << 25),
+};
+
+struct cmd_modify_qp {
+    /* The handle of QP needs to be modified */
+    le32 qpn;
+    /* The mask of attributes need to be modified, enum ib_qp_attr_mask */
+    le32 attr_mask;
+    /* Attributes need to be modified to */
+    struct virtio_rdma_qp_attr attrs;
+};
+\end{lstlisting}
+
+\subsubsection{controlq Operation: Query QP}\label{sec:Device Types / RDMA Device / controlq Operation / Query QP}
+
+Query the attributes of a Queue Pair (QP). The command equals to VIRTIO_CMD_QUERY_QP.
+Request data is struct cmd_query_qp, response data is struct rsp_query_qp.
+The argument attr_mask specifies the QP attributes to be queried.
+
+\begin{lstlisting}
+struct cmd_query_qp {
+    /* The handle of QP needs to be queried */
+    le32 qpn;
+    /* The mask of attributes need to be queried, enum ib_qp_attr_mask */
+    le32 attr_mask;
+};
+
+struct rsp_query_qp {
+    /* QP's attributes */
+    struct virtio_rdma_qp_attr attr;
+};
+\end{lstlisting}
+
+\subsubsection{controlq Operation: Destroy QP}\label{sec:Device Types / RDMA Device / controlq Operation / Destroy QP}
+
+Destroy a Queue Pair (QP). The command equals to VIRTIO_CMD_DESTROY_QP.
+Request data is struct cmd_destroy_qp, no response data.
+
+The driver MUST reset the virtqueue after destroying the QP.
+
+\begin{lstlisting}
+struct cmd_destroy_qp {
+    /* The handle of QP needs to be destroyed */
+    le32 qpn;
+};
+\end{lstlisting}
+
+\subsubsection{controlq Operation: Query Pkey}\label{sec:Device Types / RDMA Device / controlq Operation / Query Pkey}
+
+Query P_Key value of one port. The command equals to VIRTIO_CMD_QUERY_PKEY.
+Request data is struct cmd_query_pkey; response data is struct rsp_query_pkey.
+
+\begin{lstlisting}
+struct cmd_query_pkey {
+    /* Port to be queried */
+    le32 port;
+    /* Index of pkey */
+    le16 index;
+};
+
+struct rsp_query_pkey {
+    /* Value of pkey */
+    le16 pkey;
+};
+\end{lstlisting}
+
+\subsubsection{controlq Operation: Add GID}\label{sec:Device Types / RDMA Device / controlq Operation / Add GID}
+
+Add a Global Identifier (GID) to one port. The command equals to VIRTIO_CMD_ADD_GID.
+Request data is struct cmd_add_gid; no response data.
+
+\begin{lstlisting}
+struct cmd_add_gid {
+    /* Gid needs to be added */
+    u8 gid[16];
+    /* Type of gid */
+    le32 gid_type;
+    /* Index of gid */
+    le16 index;
+    /* The number of port */
+    le32 port_num;
+};
+\end{lstlisting}
+
+\subsubsection{controlq Operation: Delete GID}\label{sec:Device Types / RDMA Device / controlq Operation / Delete GID}
+
+Delete a Global Identifier (GID) from one port. The command equals to VIRTIO_CMD_DEL_GID.
+Request data is struct cmd_del_gid; no response data.
+
+\begin{lstlisting}
+struct cmd_del_gid {
+    /* Index of gid */
+    le16 index;
+    /* Port needs to be deleted from */
+    le32 port;
+};
+\end{lstlisting}
+
+\subsubsection{controlq Operation: Request Notify CQ}\label{sec:Device Types / RDMA Device / controlq Operation / Request Notify CQ}
+
+Request a Completion Notification on a Completion Queue (CQ).
+The command equals to VIRTIO_CMD_REQ_NOTIFY_CQ.
+Request data is struct cmd_req_notify; no response data.
+
+\begin{lstlisting}
+struct cmd_req_notify {
+    /* The handle of requested CQ */
+    le32 cqn;
+#define VIRTIO_RDMA_NOTIFY_SOLICITED (1 << 0)
+#define VIRTIO_RDMA_NOTIFY_NEXT_COMPLETION (1 << 1)
+    /* Notify flags */
+    le32 flags;
+};
+\end{lstlisting}
+
+\subsection{Device Operation: Send Queue Operation}\label{sec:Device Types / RDMA Device / Send Queue Operation}
+
+The send queue contains elements that describe the data to be transmitted.
+
+Requests (device-readable) have the following format:
+
+\begin{lstlisting}
+enum ib_wr_opcode {
+    IB_WR_RDMA_WRITE = 0,
+    IB_WR_RDMA_WRITE_WITH_IMM = 1,
+    IB_WR_SEND = 2,
+    IB_WR_SEND_WITH_IMM = 3,
+    IB_WR_RDMA_READ = 4,
+    IB_WR_ATOMIC_CMP_AND_SWP = 5,
+    IB_WR_ATOMIC_FETCH_AND_ADD = 6,
+    IB_WR_LOCAL_INV = 7,
+    IB_WR_SEND_WITH_INV = 9,
+    IB_WR_RDMA_READ_WITH_INV = 11,
+    /* This is kernel only and can not be issued by userspace */
+    IB_WR_REG_MR = 0x20,
+};
+
+enum ib_send_flags {
+    IB_SEND_FENCE = 1,
+    IB_SEND_SIGNALED = (1 << 1),
+    IB_SEND_SOLICITED = (1 << 2),
+    IB_SEND_INLINE = (1 << 3),
+    IB_SEND_IP_CSUM  = (1 << 4),
+};
+
+struct virtio_rdma_sq_req {
+    struct cmd_post_send {
+        /* Length of sg_list */
+        le32 num_sge;
+        /* Flags of the WR properties */
+        enum ib_send_flags send_flags;
+        /* Work request opcode */
+        enum ib_wr_opcode opcode;
+        /* User defined work request ID */
+        le64 wr_id;
+
+        union {
+            /* Immediate data (in network byte order) to send */
+            le32 imm_data;
+            /* Remote rkey to invalidate */
+            le32 invalidate_rkey;
+        } ex;
+        
+        union {
+            struct {
+                /* Start address of remote memory buffer */
+                le64 remote_addr;
+                /* Key of the remote Memory Region */
+                le32 rkey;
+            } rdma;
+            struct {
+                /* Start address of remote memory buffer */
+                le64 remote_addr;
+                /* Compare operand */
+                le64 compare_add;
+                /* Swap operand */
+                le64 swap;
+                /* Key of the remote Memory Region */
+                le32 rkey;
+            } atomic;
+            struct {
+                    /* QP number of the destination QP */
+                le32 remote_qpn;
+                /* Q_Key number of the destination QP */
+                le32 remote_qkey;
+                struct virtio_rdma_av {
+                    /* Port of AV */
+                    le32 port;
+                    /* PD number of AV */
+                    le32 pdn;
+                    /* Service Level, Traffic Class, FLow Label */
+                    le32 sl_tclass_flowlabel;
+                    /* destination GID */
+                    u8 dgid[16];
+                    /* Index of gid */
+                    u8 gid_index;
+                    /* Rate limit */
+                    u8 static_rate;
+                    /* Hop limit of packet */
+                    u8 hop_limit;
+                    /* Destination mac */
+                    u8 dmac[6];
+                    /* Reserved */
+                    u8 reserved[6];
+                } av;
+            } ud;
+            struct {
+                /* MR handle */
+                le32 mrn;
+                /* Key of MR */
+                le32 key;
+                /* Protection attributes of MR */
+                le32 access;
+            } reg;
+        } wr;
+    } cmd;
+    struct sge {
+        /* Start address of the local memory buffer */
+        le64 addr;
+        /* Memory buffer length */
+        le32 length;
+        /* Memory's local access key */
+        le32 lkey;
+    } sg_list[];
+};
+\end{lstlisting}
+
+The length of sg_list MUST equal to cmd.num_sge.
+
+\subsection{Device Operation: Receive Queue Operation}\label{sec:Device Types / RDMA Device / Receive Queue Operation}
+
+The receive queue contains elements that describe where to place incoming data.
+
+Requests have the following format:
+
+\begin{lstlisting}
+struct virtio_rdma_rq_req {
+    struct cmd_post_recv {
+        /* Length of sg_list */
+        le32 num_sge;
+        /* User defined work request ID */
+        le64 wr_id;
+    } cmd;
+    struct sge {
+        /* Start address of the local memory buffer */
+        le64 addr;
+        /* Memory buffer length */
+        le32 length;
+        /* Memory's local access key */
+        le32 lkey;
+    } sg_list[];
+};
+\end{lstlisting}
+
+The length of sg_list MUST equal to cmd.num_sge.
+
+\subsection{Device Operation: Complete Queue Operation}\label{sec:Device Types / RDMA Device / Complete Queue Operation}
+
+The completion queue is used to notify the completion of requests in send queue
+or receive queue.
+
+Requests (device-writable) have the following format:
+
+\begin{lstlisting}
+enum ib_wc_status {
+    IB_WC_SUCCESS,
+    IB_WC_LOC_LEN_ERR,
+    IB_WC_LOC_QP_OP_ERR,
+    IB_WC_LOC_EEC_OP_ERR,
+    IB_WC_LOC_PROT_ERR,
+    IB_WC_WR_FLUSH_ERR,
+    IB_WC_MW_BIND_ERR,
+    IB_WC_BAD_RESP_ERR,
+    IB_WC_LOC_ACCESS_ERR,
+    IB_WC_REM_INV_REQ_ERR,
+    IB_WC_REM_ACCESS_ERR,
+    IB_WC_REM_OP_ERR,
+    IB_WC_RETRY_EXC_ERR,
+    IB_WC_RNR_RETRY_EXC_ERR,
+    IB_WC_LOC_RDD_VIOL_ERR,
+    IB_WC_REM_INV_RD_REQ_ERR,
+    IB_WC_REM_ABORT_ERR,
+    IB_WC_INV_EECN_ERR,
+    IB_WC_INV_EEC_STATE_ERR,
+    IB_WC_FATAL_ERR,
+    IB_WC_RESP_TIMEOUT_ERR,
+    IB_WC_GENERAL_ERR
+};
+
+struct virtio_rdma_cq_req {
+    /* User defined work request ID */
+    le64 wr_id;
+    /* Work completion status, enum ib_wc_status */
+    u8 status;
+    /* Work request opcode, enum ib_wr_opcode */
+    u8 opcode;
+    /* Vendor error */
+    le32 vendor_err;
+    /* Number of bytes transferred */
+    le32 byte_len;
+    union {
+        /* Immediate data (in network byte order) to send */
+        le32 imm_data;
+        /* Remote rkey to invalidate */
+        le32 invalidate_rkey;
+    }ex;
+    /* Local QP number of completed WR */
+    le32 qp_num;
+    /* Source QP number (remote QP number) of completed WR (valid only for UD QPs) */
+    le32 src_qp;
+    /* Work completion flag */
+    le32 wc_flags;
+    /* Index of P_KEY */
+    le16 pkey_index;
+    /* Service Level */
+    u8 sl;
+    /* Port number */
+    u8 port_num;
+};
+\end{lstlisting}
+
+\subsection{Device Operation: Send/Receive Operation}\label{sec:Device Types / RDMA Device / Send/Receive Operation}
+
+\drivernormative{\subsubsection}{Device Operation: Send/Receive Operation}{Device Types / RDMA Device / Send/Receive Operation}
+
+For sender, the driver MUST fill in and add a WQE as one output descriptor to
+the send queue. WQE's sg_list field MUST be used to describe the data buffer to
+send and opcode field MUST be set to IB_WR_SEND or IB_WR_SEND_WITH_IMM.
+If request is post from UD QP, wr.ud field MUST be set, otherwise wr field
+SHOULD not be used.
+
+For receiver, the driver MUST fill in and add a WQE as one output descriptor to
+the receive queue. WQE's sg_list field MUST be used to describe the data buffer
+to receive.
+
+\devicenormative{\subsubsection}{Device Operation: Send/Receive Operation}{Device Types / RDMA Device / Send/Receive Operation}
+
+For sender, device MUST fetch a WQE from send queue, validate the lkey field in
+sg_list, assemble packet from the memory buffer described by sg_list and send it
+out. For UD QP, a CQE SHOULD be generated on completion queue after packet is
+sent. For RC QP, a CQE SHOULD be generated after an ACK is received.
+
+For receiver, device MUST fetch a WQE from recv queue, validate the lkey field
+in sg_list, fill packet into the memory buffer described by sg_list, generate
+a CQE on completion queue.
+
+\subsection{Device Operation: Read Operation}\label{sec:Device Types / RDMA Device / Read Operation}
+
+\drivernormative{\subsubsection}{Device Operation: Read Operation}{Device Types / RDMA Device / Read Operation}
+
+For sender, the driver MUST fill in and add a WQE as one output descriptor to
+the send queue. WQE's opcode field MUST be set to IB_WR_READ or
+IB_WR_READ_WITH_INV, wr.rdma field MUST be set.
+
+\devicenormative{\subsubsection}{Device Operation: Read Operation}{Device Types / RDMA Device / Read Operation}
+
+For sender, device MUST fetch a WQE from send queue, validate the lkey in
+sg_list, assemble packet and send it out.
+
+For receiver, device MUST validate the rkey, assemble packet from the memory
+buffer specified by remote_addr and send it out.
+
+For sender, when receiving a response packet, device MUST fill packet into the
+memory buffer described by sg_list, generate a CQE on completion queue.
+
+\subsection{Device Operation: Write Operation}\label{sec:Device Types / RDMA Device / Write Operation}
+
+\drivernormative{\subsubsection}{Device Operation: Write Operation}{Device Types / RDMA Device / Write Operation}
+
+For sender, driver MUST fill in and add a WQE as one output descriptor to the
+send queue. WQE's  opcode field MUST be set to IB_WR_WRITE or
+IB_WR_WRITE_WITH_IMM, wr.rdma field MUST be set.
+
+\devicenormative{\subsubsection}{Device Operation: Write Operation}{Device Types / RDMA Device / Write Operation}
+
+For sender, device MUST validate the lkey in sg_list, assemble packet from the
+memory buffer described by sg_list and send it out.
+
+For receiver, device MUST validate the rkey and fill the packet into the memory
+buffer specified by remote_addr.
+
+\subsection{Device Operation: Atomic Operation}\label{sec:Device Types / RDMA Device / Atomic Operation}
+
+\drivernormative{\subsubsection}{Device Operation: Atomic Operation}{Device Types / RDMA Device / Atomic Operation}
+
+For sender, MUST fill in and add a WQE as one output descriptor to the send
+queue. WQE's  opcode field MUST be set to IB_WR_ATOMIC_CMP_AND_SWP or
+IB_WR_ATOMIC_FETCH_AND_ADD, wr.atomic field MUST be set.
+
+\devicenormative{\subsubsection}{Device Operation: Atomic Operation}{Device Types / RDMA Device / Atomic Operation}
+
+For sender, device MUST fetch a WQE from send queue, validate the lkey in
+sg_list, assemble packet and send it out.
+
+For receiver, device MUST validate the rkey, perform the atomic opeartion in
+remote_addr, assemble response packet and send it out.
+
+For sender, when receiving a response packet,  device MUST fill packet into the
+memory buffer described by sg_list, generate a CQE on completion queue.
+
+\subsection{Device Operation: Local Invalidate Operation}\label{sec:Device Types / RDMA Device / Local Invalidate Operation}
+
+\drivernormative{\subsubsection}{Device Operation: Local Invalidate Operation}{Device Types / RDMA Device / Local Invalidate Operation}
+
+Driver MUST NOT support this operation if IB_DEVICE_MEM_MGT_EXTENSIONS is not set.
+
+Driver MUST fill in and add a WQE as one output descriptor to the send queue.
+WQE's opcode field MUST be set to IB_WR_LOCAL_INV, IB_WR_SEND_WITH_INV or
+IB_WR_RDMA_READ_WITH_INV, ex.invalidate_rkey MUST be set.
+
+\devicenormative{\subsubsection}{Device Operation: Local Invalidate Operation}{Device Types / RDMA Device / Local Invalidate Operation}
+
+Device MUST return error if IB_DEVICE_MEM_MGT_EXTENSIONS is not set.
+Device MUST invalidate the Memory Region (MR) with the invalidate_rkey and 
+generate a CQE on completion queue.
+
+\subsection{Device Operation: Fast Register Memory Region}\label{sec:Device Types / RDMA Device / Fast Register Memory Region}
+
+\drivernormative{\subsubsection}{Device Operation: Fast Register Memory Region}{Device Types / RDMA Device / Fast Register Memory Region}
+
+Driver MUST NOT support this operation if IB_DEVICE_MEM_MGT_EXTENSIONS is not set.
+
+Driver MUST fill in and add a WQE as one output descriptor to the send queue.
+WQE's opcode field MUST be set to IB_WR_REG_MR, wr.reg field MUST be set.
+
+\devicenormative{\subsubsection}{Device Operation: Fast Register Memory Region}{Device Types / RDMA Device / Fast Register Memory Region}
+
+Device MUST return error if IB_DEVICE_MEM_MGT_EXTENSIONS is not set.
+
+Device MUST validate the Memory Region (MR) with the handle: mrn and generate a
+CQE on completion queue. The MR SHOULD have been created by VIRTIO_CMD_CREATE_MR
+before.
-- 
2.33.0

