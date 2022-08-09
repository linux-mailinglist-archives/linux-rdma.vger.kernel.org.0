Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B8C58DA3D
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Aug 2022 16:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiHIOXH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Aug 2022 10:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237529AbiHIOXG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Aug 2022 10:23:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C54D12D28
        for <linux-rdma@vger.kernel.org>; Tue,  9 Aug 2022 07:23:01 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y13so22433193ejp.13
        for <linux-rdma@vger.kernel.org>; Tue, 09 Aug 2022 07:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=HdtdbIVLP/mWCKWpKyB5ijLsS3pXeMGlqa2IdNDjsd4=;
        b=LHRL++PKwGhnd8+4IFduzqKQVcxc3612ltc6nVWu90AQf8i+pxFU9dmCvWh9tUebLl
         VqbCKxM3aDlPxZ9PQge9aX2uz8jz4qtvi+MUs6IXk0UXsOAa97VipjmtyyKLGv3jkU/h
         yNRXwDWQL56vfXGy8SEXarieO/cCUdMztZvrt2ZpSSushy0Y+1qwEqzf2hCEvNrgWl8F
         0YnquJQ3y8jycZvHDlJTTsCrL1i6RfdjB0Fj8BrAE/xt2Bp1D9hRo4sd+qPdzGA94Q/q
         hN4uAX0Dmn3rpVgbTGeDpE5wLYXYo5Hbg5C11YvBSzUFRxeeKwEeNLjLVaq5jkdkY+7/
         o8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=HdtdbIVLP/mWCKWpKyB5ijLsS3pXeMGlqa2IdNDjsd4=;
        b=uMBOIszXMzHLD0OK2z9CJ2BB1fzYq/f0YRCFKs1zhLNyU2OlxjOYBNVPkUfX5scsmi
         T+Fq9wuxySP9QMlUa7Y55ecjnEqkEmck5GtBhSQxtuwtdFd0blah1LJ+asYhbn2YZo4R
         NRtDH+nf6jHDYMwcxD2duzq2Q4KLcKpjcvE9wTjHO66s6Q1W8yNAjukLyFIO+IbRFKQ+
         NWR9l1hC+tvt24fgjHIcweV9obaWRYDWGw01FFVhDpeEMncEWANVtYSYW2h5JhDneJCa
         Sb9A3qBJHXk7Ad7rH1YyQxH6D+G1tXwZeIV3XjZjzlRMGHRdiA8Zo9upvh6DegdNeCQu
         lO3Q==
X-Gm-Message-State: ACgBeo0VYP1W9pTaYOMVeCUxVhJbuxc9BjBJXPHf30r2HpUAsHbM8oin
        NHxlhSE6DvVxRYU/74YwKaxTh8EmqWqxcavcDDC2
X-Google-Smtp-Source: AA6agR6L7meYJnvvLqEtzwdkQ1Mp2Ju94d8MErrembHuOCsx3lUAYlN7RGKaJetvmpXOuTIOLscoQQDt7aEJ82Pwhig=
X-Received: by 2002:a17:906:ee8e:b0:730:4a24:f311 with SMTP id
 wt14-20020a170906ee8e00b007304a24f311mr17950393ejb.420.1660054979537; Tue, 09
 Aug 2022 07:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220511095900.343-1-xieyongji@bytedance.com> <CACGkMEuwcrWKndM0f+i6N5XK7Ekmvh4u9TUPJT=c9Y1bBm-==g@mail.gmail.com>
In-Reply-To: <CACGkMEuwcrWKndM0f+i6N5XK7Ekmvh4u9TUPJT=c9Y1bBm-==g@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 9 Aug 2022 22:22:48 +0800
Message-ID: <CACycT3sShxOR41Kk1znxC7Mpw73N0LAP66cC3-iqeS_jp8trvw@mail.gmail.com>
Subject: Re: [RFC v2] virtio-net: Add RoCE (RDMA over Converged Ethernet) support
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst <mst@redhat.com>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, yuval.shaia.ml@gmail.com,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        =?UTF-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>,
        zhoujielong@bytedance.com,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Virtio-Dev <virtio-dev@lists.oasis-open.org>,
        virtio-comment@lists.oasis-open.org,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 4, 2022 at 4:30 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, May 11, 2022 at 5:59 PM Xie Yongji <xieyongji@bytedance.com> wrot=
e:
> >
> > Hi all,
> >
>
> Not very familiar with ROCE, try to give some comments from general
> virtio level.
>

Thank you!

> > This RFC aims to introduce our recent work on enabling RoCE support
> > for virtio-net device.
>
> We need to clarify the version of ROCE, is it ROCEv2 or not?
>

Yes, it's RoCE v2.

> >
> > To support RoCE, three types of virtqueues including RDMA send virtqueu=
e,
> > RDMA receive virtqueue and RDMA completion virtqueue are introduced.
> > And control virtqueue is reused to support the RDMA control messages.
> >
> > Now we support some basic RDMA semantics such as send/receive
> > and read/write operation.
>
> It would be better to explain the advantages of this over the existing
> pvrdma approach. I guess one advantage is that using virtio makes it
> easier to connect to a userspace dataplane through vDPA/vhost-user?
>

Yes, this is one advantage. Another one is that we don't need a
physical RDMA-capable NIC.

> >
> > To test with our demo:
> >
> > 1. Build Guest kernel [1] with config INFINIBAND_VIRTIO_RDMA
> >
> > 2. Build QEMU [2] with config VHOST_USER_RDMA
> >
> > 3. Build rdma-core [3]
> >
> > 4. Build and install DPDK (NOTE that we only tested on DPDK 20.11.3)
> >
> > 5. Build vhost-user-rdma [4]
> >
> > 6. Run vhost-user-rdma with command:
> >     $ ./vhost-user-rdma --vdev 'net_tap0' --lcore '1-3' -- -s '/tmp/vho=
st-rdma0'
> >
> > 7. Run qemu with command:
> >     $ qemu-system-x86_64 -chardev socket,path=3D/tmp/vhost-rdma0,id=3Dv=
rdma \
> >       -device vhost-user-rdma-pci,page-per-vq,chardev=3Dvrdma ...
>
> It would be better to give some performance numbers (or even compare
> it with pvrdma).
>

OK, will do it in v3.

> >
> > [1] https://github.com/bytedance/linux/tree/virtio-net-roce
> > [2] https://github.com/bytedance/qemu/tree/vhost-user-rdma
> > [3] https://github.com/YongjiXie/rdma-core/tree/virtio-rdma
> > [4] https://github.com/YongjiXie/vhost-user-rdma
> >
> > We have already tested it with ibv_rc_pingpong, ibv_ud_pingpong and som=
e
> > others in rdma-core.
> >
> > TODO:
> >
>
> And we'd better consider the live migration support. Having a quick
> glance, it looks to me trapping the cvq is sufficient?
>

I'm not sure. Each QP has its own state machine, which may also
require save & restore.

> > 1. Add support for Base Memory Management Extensions
> >
> > 2. Add support for atomic operation
> >
> > 3. Add support for SRQ
> >
> > 4. Add support for virtqueue resize
>
> Note that this is already supported by the spec via virtqueue reset.
>

OK.

> >
> > 5. Add support for enabling/disabling virtqueue at runtime
>
> I guess virtqueue reset could help in this case.
>

We might need to do some extension since we want to free the resources
when disabling the queue.

> >
> > Please review, thanks!
> >
> > V1 to V2:
> > - Rework the implementation via extending virtio-net instead of
> >   introducing a new device type [Jason]
> > - Add address handle support
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > Co-developed-by: Wei Junji <weijunji@bytedance.com>
> > Signed-off-by: Wei Junji <weijunji@bytedance.com>
> > ---
> >  content.tex | 858 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
> >  1 file changed, 854 insertions(+), 4 deletions(-)
>
> I wonder if there's some open-source ROCE transport device API that we
> can re-use then we can just behave like a transport layer instead of
> inventing new commands.
>

That's would be better. But I didn't find one.

> >
> > diff --git a/content.tex b/content.tex
> > index 7508dd1..646d82a 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -3008,7 +3008,10 @@ \section{Network Device}\label{sec:Device Types =
/ Network Device}
> >  placed in one virtqueue for receiving packets, and outgoing
> >  packets are enqueued into another for transmission in that order.
> >  A third command queue is used to control advanced filtering
> > -features.
> > +features. And if RoCE (RDMA over Converged Ethernet) capability
> > +is enabled, the virtio network device can also support transmitting
> > +and receiving RDMA message through RDMA send virtqueue, RDMA receive
> > +virtqueue and RDMA completion virtqueue.
> >
> >  \subsection{Device ID}\label{sec:Device Types / Network Device / Devic=
e ID}
> >
> > @@ -3023,13 +3026,24 @@ \subsection{Virtqueues}\label{sec:Device Types =
/ Network Device / Virtqueues}
> >  \item[2(N-1)] receiveqN
> >  \item[2(N-1)+1] transmitqN
> >  \item[2N] controlq
> > +\item[2N+1] rdma_completeq1
> > +\item[\ldots]
> > +\item[2N+M] rdma_completeqM
> > +\item[2N+M+1] rdma_transmitq1
> > +\item[2N+M+2] rdma_receiveq1
> > +\item[\ldots]
> > +\item[2N+M+2L-1] rdma_transmitqL
> > +\item[2N+M+2L] rdma_receiveqL
> >  \end{description}
> >
> >   N=3D1 if neither VIRTIO_NET_F_MQ nor VIRTIO_NET_F_RSS are negotiated,=
 otherwise N is set by
> > - \field{max_virtqueue_pairs}.
> > + \field{max_virtqueue_pairs}. M is set by \field{max_rdma_cqs} and L i=
s set by
> > + \field{max_rdma_qps}.
> >
> >   controlq only exists if VIRTIO_NET_F_CTRL_VQ set.
> >
> > + rdma_completeq, rdma_transmitq and rdma_receiveq only exist if VIRTIO=
_NET_F_ROCE set
> > +
> >  \subsection{Feature bits}\label{sec:Device Types / Network Device / Fe=
ature bits}
> >
> >  \begin{description}
> > @@ -3084,6 +3098,9 @@ \subsection{Feature bits}\label{sec:Device Types =
/ Network Device / Feature bits
> >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
> >      channel.
> >
> > +\item[VIRTIO_NET_F_ROCE(55)] Device supports RoCE (RDMA over Converged=
 Ethernet)
> > +    capability.
> > +
> >  \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets. Unli=
ke UFO
> >   (fragmenting the packet) the USO splits large UDP packet
> >   to several segments when each of these smaller packets has UDP header=
.
> > @@ -3129,6 +3146,7 @@ \subsubsection{Feature bit requirements}\label{se=
c:Device Types / Network Device
> >  \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
> > +\item[VIRTIO_NET_F_ROCE] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_=
NET_F_HOST_TSO6.
> >  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \end{description}
> > @@ -3190,6 +3208,8 @@ \subsection{Device configuration layout}\label{se=
c:Device Types / Network Device
> >          u8 rss_max_key_size;
> >          le16 rss_max_indirection_table_length;
> >          le32 supported_hash_types;
> > +        le32 max_rdma_qps;
> > +        le32 max_rdma_cps;
> >  };
> >  \end{lstlisting}
> >  The following field, \field{rss_max_key_size} only exists if VIRTIO_NE=
T_F_RSS or VIRTIO_NET_F_HASH_REPORT is set.
> > @@ -3204,11 +3224,23 @@ \subsection{Device configuration layout}\label{=
sec:Device Types / Network Device
> >  Field \field{supported_hash_types} contains the bitmask of supported h=
ash types.
> >  See \ref{sec:Device Types / Network Device / Device Operation / Proces=
sing of Incoming Packets / Hash calculation for incoming packets / Supporte=
d/enabled hash types} for details of supported hash types.
> >
> > +Field \field{max_rdma_qps} only exists if VIRTIO_NET_F_ROCE is set.
> > +It specifies the maximum number of queue pairs (send virtqueue and rec=
eive virtqueue) for RoCE usage.
> > +
> > +Field \field{max_rdma_cqs} only exists if VIRTIO_NET_F_ROCE is set.
> > +It specifies the maximum number of completion virtqueue for RoCE usage=
.
> > +
> >  \devicenormative{\subsubsection}{Device configuration layout}{Device T=
ypes / Network Device / Device configuration layout}
> >
> >  The device MUST set \field{max_virtqueue_pairs} to between 1 and 0x800=
0 inclusive,
> >  if it offers VIRTIO_NET_F_MQ.
> >
> > +The device MUST set \field{max_rdma_qps} to between 1 an 16384 inclusi=
ve,
> > +if it offers VIRTIO_NET_F_ROCE.
>
> I wonder why 16384 is chosen here?
>

Since the max queue number is limited to 65536 and we have three types
of queue, the queue number should be less than 65536 / 3. We choose
65536 / 4 here.

> > +
> > +The device MUST set \field{max_rdma_cqs} to between 1 an 16384 inclusi=
ve,
> > +if it offers VIRTIO_NET_F_ROCE.
> > +
> >  The device MUST set \field{mtu} to between 68 and 65535 inclusive,
> >  if it offers VIRTIO_NET_F_MTU.
> >
> > @@ -3306,6 +3338,12 @@ \subsection{Device Initialization}\label{sec:Dev=
ice Types / Network Device / Dev
> >  \item If the VIRTIO_NET_F_CTRL_VQ feature bit is negotiated,
> >    identify the control virtqueue.
> >
> > +\item If the VIRTIO_NET_F_ROCE feature bit is negotiated,
> > +  identify the the RDMA completion virtqueues, up to max_rdma_cqs.
> > +
> > +\item If the VIRTIO_NET_F_ROCE feature bit is negotiated,
> > +  identify the the RDMA send and receive virtqueues, up to max_rdma_qp=
s.
> > +
> >  \item Fill the receive queues with buffers: see \ref{sec:Device Types =
/ Network Device / Device Operation / Setting Up Receive Buffers}.
> >
> >  \item Even with VIRTIO_NET_F_MQ, only receiveq1, transmitq1 and
> > @@ -4007,6 +4045,7 @@ \subsubsection{Control Virtqueue}\label{sec:Devic=
e Types / Network Device / Devi
> >          u8 command;
> >          u8 command-specific-data[];
> >          u8 ack;
> > +        u8 ack-specific-data[];
> >  };
> >
> >  /* ack values */
> > @@ -4015,8 +4054,8 @@ \subsubsection{Control Virtqueue}\label{sec:Devic=
e Types / Network Device / Devi
> >  \end{lstlisting}
> >
> >  The \field{class}, \field{command} and command-specific-data are set b=
y the
> > -driver, and the device sets the \field{ack} byte. There is little it c=
an
> > -do except issue a diagnostic if \field{ack} is not
> > +driver, and the device sets the \field{ack} byte and ack-specific-data=
. There
> > +is little it can do except issue a diagnostic if \field{ack} is not
> >  VIRTIO_NET_OK.
> >
> >  \paragraph{Packet Receive Filtering}\label{sec:Device Types / Network =
Device / Device Operation / Control Virtqueue / Packet Receive Filtering}
> > @@ -4463,6 +4502,534 @@ \subsubsection{Control Virtqueue}\label{sec:Dev=
ice Types / Network Device / Devi
> >  according to the native endian of the guest rather than
> >  (necessarily when not using the legacy interface) little-endian.
> >
> > +\paragraph{RoCE Configuration}\label{sec:Device Types / Network Device=
 / Device Operation / Control Virtqueue / RoCE Configuration}
> > +
> > +If the driver negotiates the VIRTIO_NET_F_ROCE feature bit (depends on=
 VIRTIO_NET_F_CTRL_VQ),
> > +it can send control commands for RoCE usage. The following commands ar=
e defined now:
> > +
> > +\begin{lstlisting}
> > +#define VIRTIO_NET_CTRL_ROCE    6
> > + #define VIRTIO_NET_CTRL_ROCE_QUERY_DEVICE      0
> > + #define VIRTIO_NET_CTRL_ROCE_QUERY_PORT        1
> > + #define VIRTIO_NET_CTRL_ROCE_CREATE_CQ         2
> > + #define VIRTIO_NET_CTRL_ROCE_DESTROY_CQ        3
> > + #define VIRTIO_NET_CTRL_ROCE_CREATE_PD         4
> > + #define VIRTIO_NET_CTRL_ROCE_DESTROY_PD        5
> > + #define VIRTIO_NET_CTRL_ROCE_GET_DMA_MR        6
> > + #define VIRTIO_NET_CTRL_ROCE_REG_USER_MR       7
> > + #define VIRTIO_NET_CTRL_ROCE_DEREG_MR          8
> > + #define VIRTIO_NET_CTRL_ROCE_CREATE_QP         9
> > + #define VIRTIO_NET_CTRL_ROCE_MODIFY_QP         10
> > + #define VIRTIO_NET_CTRL_ROCE_QUERY_QP          11
> > + #define VIRTIO_NET_CTRL_ROCE_DESTROY_QP        12
> > + #define VIRTIO_NET_CTRL_ROCE_CREATE_AH         13
> > + #define VIRTIO_NET_CTRL_ROCE_DESTROY_AH        14
> > + #define VIRTIO_NET_CTRL_ROCE_ADD_GID           15
> > + #define VIRTIO_NET_CTRL_ROCE_DEL_GID           16
> > + #define VIRTIO_NET_CTRL_ROCE_REQ_NOTIFY_CQ     17
> > +\end{lstlisting}
> > +
> > +\begin{description}
> > +\item[VIRTIO_NET_CTRL_ROCE_QUERY_DEVICE] Query the attributes of devic=
e.
> > +  No command-specific-data;
> > +  the ack-specific-data is \field{struct virtio_rdma_ack_query_device}=
.
> > +
> > +\begin{lstlisting}
> > +struct virtio_rdma_ack_query_device {
> > +#define VIRTIO_IB_DEVICE_RC_RNR_NAK_GEN    (1 << 0)
>
> What's the meaning of this capability?
>

It indicates whether the device supports RNR-NAK generation for RC
QPs. I will add some comments.

> > +        /* Capabilities mask */
> > +        le64 device_cap_flags;
>
> Will this introduce a migration compatibility issue? E.g src and dst
> have the same features but different capabilities.
>

Should this be controlled by hypervisor since all capabilities is
emulated by software.

> > +        /* Largest contiguous block that can be registered */
> > +        le64 max_mr_size;
> > +        /* Supported memory shift sizes */
> > +        le64 page_size_cap;
> > +        /* Hardware version */
> > +        le32 hw_ver;
>
> What did "hardware version" mean? Is this something that is defined in
> the IB spec?
>

Yes, it's defined in IB spec.

> > +        /* Maximum number of outstanding Work Requests (WR) on Send Qu=
eue (SQ) and Receive Queue (RQ) */
> > +        le32 max_qp_wr;
>
> Is this implied in the virtqueue size? If not, why?
>

Yes. Will remove it.

> > +        /* Maximum number of scatter/gather (s/g) elements per WR for =
SQ for non RDMA Read operations */
> > +        le32 max_send_sge;
> > +        /* Maximum number of s/g elements per WR for RQ for non RDMA R=
ead operations */
> > +        le32 max_recv_sge;
> > +        /* Maximum number of s/g per WR for RDMA Read operations */
> > +        le32 max_sge_rd;
> > +        /* Maximum size of Completion Queue (CQ) */
> > +        le32 max_cqe;
>
> Need to specify the reason why we can't use the virtqueue size for the
> completion queue.
>

I think we can. Will remove it

> > +        /* Maximum number of Memory Regions (MR) */
> > +        le32 max_mr;
> > +        /* Maximum number of Protection Domains (PD) */
> > +        le32 max_pd;
> > +        /* Maximum number of RDMA Read perations that can be outstandi=
ng per Queue Pair (QP) */
>
> I guess you mean "operations" here.
>

Yes.

> > +        le32 max_qp_rd_atom;
> > +        /* Maximum depth per QP for initiation of RDMA Read operations=
 */
>
> The member has an "atom" suffix, does it mean "atomic read" or other?
>

It means the atomic operation which is unsupported now. I think we
need to remove it.

> > +        le32 max_qp_init_rd_atom;
> > +        /* Maximum number of Address Handles (AH) */
> > +        le32 max_ah;
> > +        /* Local CA ack delay */
> > +        u8 local_ca_ack_delay;
> > +        /* Padding */
> > +        u8 padding[3];
> > +        /* Reserved for future */
> > +        le32 reserved[14];
> > +};
> > +\end{lstlisting}
> > +
> > +\item[VIRTIO_NET_CTRL_ROCE_QUERY_PORT] Query the attributes of port.
> > +  No command-specific-data;
> > +  the ack-specific-data is \field{struct virtio_rdma_ack_query_port}.
> > +
> > +\begin{lstlisting}
> > +struct virtio_rdma_ack_query_port {
> > +        /* Length of source Global Identifier (GID) table */
> > +        le32 gid_tbl_len;
> > +        /* Maximum message size */
> > +        le32 max_msg_sz;
>
> I guess this is for both read/write/send/receive? And is 4GB
> sufficient for the future?
>

Now this follows the definition in linux kernel and IB Spec. If we
need to extend it in future, we can add a new field max_msg_sz64?

> > +        /* Reserved for future */
> > +        le32 reserved[6];
> > +};
> > +\end{lstlisting}
> > +
> > +\item[VIRTIO_NET_CTRL_ROCE_CREATE_CQ] Create a Completion Queue (CQ).
> > +  The command-specific-data is \field{struct virtio_rdma_cmd_create_cq=
};
> > +  the ack-specific-data is \field{struct virtio_rdma_ack_create_cq}.
> > +
> > +\begin{lstlisting}
> > +struct virtio_rdma_cmd_create_cq {
> > +        /* Size of CQ */
> > +        le32 cqe;
> > +};
> > +
> > +struct virtio_rdma_ack_create_cq {
> > +        /* The index of CQ */
> > +        le32 cqn;
> > +};
> > +\end{lstlisting}
> > +
> > +\item[VIRTIO_NET_CTRL_ROCE_DESTROY_CQ] Destroy a Completion Queue.
> > +  The command-specific-data is \field{struct virtio_rdma_cmd_destroy_c=
q};
> > +  no ack-specific-data.
> > +
> > +\begin{lstlisting}
> > +struct virtio_rdma_cmd_destroy_cq {
> > +        /* The index of CQ */
> > +        le32 cqn;
> > +};
> > +\end{lstlisting}
> > +
> > +\item[VIRTIO_NET_CTRL_ROCE_CREATE_PD] Create a Protection Domain (PD).
> > +  No command-specific-data;
> > +  the ack-specific-data is \field{struct virtio_rdma_ack_create_pd}.
> > +
> > +\begin{lstlisting}
> > +struct virtio_rdma_ack_create_pd {
> > +        /* The handle of PD */
> > +        le32 pdn;
> > +};
> > +\end{lstlisting}
>
> Can this command always succeed? I meant is there a limit of the total
> number of PDs that a single ROCE device can support?
>

Yes, we have max_pd field in structure virtio_rdma_ack_query_device.

> > +
> > +\item[VIRTIO_NET_CTRL_ROCE_DESTORY_PD] Destroy a Protection Domain.
> > +  The command-specific-data is \field{virtio_rdma_cmd_destroy_pd};
> > +  no ack-specific-data.
> > +
> > +\begin{lstlisting}
> > +struct virtio_rdma_cmd_destroy_pd {
> > +        /* The handle of PD */
> > +        le32 pdn;
> > +};
> > +\end{lstlisting}
> > +
> > +\item[VIRTIO_NET_CTRL_ROCE_GET_DMA_MR] Get the DMA Memory Region (MR).
> > +  associated with one protection domain.
>
> I wonder what's the difference between VIRTIO_NET_CTRL_ROCE_GET_DMA_MR
> and USR_MR. Can we unify them?
>

We should pass some address for USER_MR. I think we can unify them if we wa=
nt.

> > +  The command-specific-data is \field{virtio_rdma_cmd_get_dma_mr};
> > +  the ack-specific-data is \field{virtio_rdma_ack_get_dma_mr}.
> > +
> > +\begin{lstlisting}
> > +enum virtio_ib_access_flags {
> > +        VIRTIO_IB_ACCESS_LOCAL_WRITE =3D (1 << 0),
>
> Is LOCAL_READ implied to work always?
>

Yes, the LOCAL_READ is always supported.

> > +        VIRTIO_IB_ACCESS_REMOTE_WRITE =3D (1 << 1),
> > +        VIRTIO_IB_ACCESS_REMOTE_READ =3D (1 << 2),
> > +};
> > +
> > +struct virtio_rdma_cmd_get_dma_mr {
> > +        /* The handle of PD which the MR associated with */
> > +        le32 pdn;
> > +        /* MR's protection attributes, enum virtio_ib_access_flags */
> > +        le32 access_flags;
> > +};
> > +
> > +struct virtio_rdma_ack_get_dma_mr {
> > +        /* The handle of MR */
> > +        le32 mrn;
> > +        /* MR's local access key */
> > +        le32 lkey;
> > +        /* MR's remote access key */
> > +        le32 rkey;
> > +};
> > +\end{lstlisting}
> > +
> > +\item[VIRTIO_NET_CTRL_ROCE_REG_USER_MR] Register a user Memory Region
> > +  associated with one Protection Domain.
> > +  The command-specific-data is \field{virtio_rdma_cmd_reg_user_mr};
> > +  the ack-specific-data is \field{virtio_rdma_ack_reg_user_mr}.
> > +
> > +\begin{lstlisting}
> > +struct virtio_rdma_cmd_reg_user_mr {
> > +        /* The handle of PD which the MR associated with */
> > +        le32 pdn;
> > +        /* MR's protection attributes, enum virtio_ib_access_flags */
> > +        le32 access_flags;
> > +        /* Starting virtual address of MR */
> > +        le64 virt_addr;
>
> I guess this is actually the I/O virtual address and the device is in
> charge of translate it to the page arrays below?
>

Yes, this address is specified by userspace, which can be a virtual
address or not.

> > +        /* Length of MR */
> > +        le64 length;
> > +        /* Size of the below page array */
> > +        le32 npages;
> > +        /* Padding */
> > +        le32 padding;
> > +        /* Array to store physical address of each page in MR */
> > +        le64 pages[];
>
> How do device know the size of a page?
>

We have npages field in this struture.

> > +};
>
> I believe this command can fail, we need to describe the error conditions=
.
>

OK.

> > +
> > +struct virtio_rdma_ack_reg_user_mr {
> > +        /* The handle of MR */
> > +        le32 mrn;
> > +        /* MR's local access key */
> > +        le32 lkey;
> > +        /* MR's remote access key */
> > +        le32 rkey;
> > +};
> > +\end{lstlisting}
> > +
> > +\item[VIRTIO_NET_CTRL_ROCE_DEREG_MR] De-register a Memory Region.
> > +  The command-specific-data is \field{virtio_rdma_cmd_dereg_mr};
> > +  no ack-specific-data.
> > +
> > +\begin{lstlisting}
> > +struct virtio_rdma_cmd_dereg_mr {
> > +        /* The handle of MR */
> > +        le32 mrn;
> > +};
> > +\end{lstlisting}
> > +
> > +\item[VIRTIO_NET_CTRL_ROCE_CREATE_QP] Create a Queue Pair (Send Queue =
and Receive Queue).
> > +  The command-specific-data is \field{virtio_rdma_cmd_create_qp};
> > +  the ack-specific-data is \field{virtio_rdma_ack_create_qp}.
> > +
> > +\begin{lstlisting}
> > +struct virtio_rdma_qp_cap {
> > +        /* Maximum number of outstanding WRs in SQ */
> > +        le32 max_send_wr;
> > +        /* Maximum number of outstanding WRs in RQ */
> > +        le32 max_recv_wr;
> > +        /* Maximum number of s/g elements per WR in SQ */
> > +        le32 max_send_sge;
> > +        /* Maximum number of s/g elements per WR in RQ */
> > +        le32 max_recv_sge;
> > +        /* Maximum number of data (bytes) that can be posted inline to=
 SQ */
> > +        le32 max_inline_data;
> > +        /* Padding */
> > +        le32 padding;
> > +};
> > +
> > +struct virtio_rdma_cmd_create_qp {
> > +        /* The handle of PD which the QP associated with */
> > +        le32 pdn;
> > +#define VIRTIO_IB_QPT_SMI    0
> > +#define VIRTIO_IB_QPT_GSI    1
> > +#define VIRTIO_IB_QPT_RC     2
> > +#define VIRTIO_IB_QPT_UC     3
> > +#define VIRTIO_IB_QPT_UD     4
> > +        /* QP's type */
> > +        u8 qp_type;
> > +        /* If set, each WR submitted to the SQ generates a completion =
entry */
> > +        u8 sq_sig_all;
> > +        /* Padding */
> > +        u8 padding[2];
> > +        /* The index of CQ which the SQ associated with */
> > +        le32 send_cqn;
> > +        /* The index of CQ which the RQ associated with */
> > +        le32 recv_cqn;
> > +        /* QP's capabilities */
> > +        struct virtio_rdma_qp_cap cap;
> > +        /* Reserved for future */
> > +        le32 reserved[4];
> > +};
> > +
> > +struct virtio_rdma_ack_create_qp {
> > +        /* The index of QP */
> > +        le32 qpn;
> > +};
> > +\end{lstlisting}
> > +
> > +\item[VIRTIO_NET_CTRL_ROCE_MODIFY_QP] Modify the attributes of a Queue=
 Pair.
> > +  The command-specific-data is \field{virtio_rdma_cmd_modify_qp};
> > +  no ack-specific-data.
> > +
> > +\begin{lstlisting}
> > +struct virtio_rdma_global_route {
> > +        /* Destination GID or MGID */
> > +        u8 dgid[16];
> > +        /* Flow label */
> > +        le32 flow_label;
> > +        /* Source GID index */
> > +        u8 sgid_index;
> > +        /* Hop limit */
> > +        u8 hop_limit;
> > +        /* Traffic class */
> > +        u8 traffic_class;
> > +        /* Padding */
> > +        u8 padding;
> > +};
> > +
> > +struct virtio_rdma_ah_attr {
> > +        /* Global Routing Header (GRH) attributes */
> > +        virtio_rdma_global_route grh;
> > +        /* Destination MAC address */
> > +        u8 dmac[6];
> > +        /* Reserved for future */
> > +        u8 reserved[10];
> > +};
> > +
> > +enum virtio_ib_qp_attr_mask {
> > +        VIRTIO_IB_QP_STATE =3D (1 << 0),
> > +        VIRTIO_IB_QP_CUR_STATE =3D (1 << 1),
> > +        VIRTIO_IB_QP_ACCESS_FLAGS =3D (1 << 2),
> > +        VIRTIO_IB_QP_QKEY =3D (1 << 3),
> > +        VIRTIO_IB_QP_AV =3D (1 << 4),
> > +        VIRTIO_IB_QP_PATH_MTU =3D (1 << 5),
> > +        VIRTIO_IB_QP_TIMEOUT =3D (1 << 6),
> > +        VIRTIO_IB_QP_RETRY_CNT =3D (1 << 7),
> > +        VIRTIO_IB_QP_RNR_RETRY =3D (1 << 8),
> > +        VIRTIO_IB_QP_RQ_PSN =3D (1 << 9),
> > +        VIRTIO_IB_QP_MAX_QP_RD_ATOMIC =3D (1 << 10),
> > +        VIRTIO_IB_QP_MIN_RNR_TIMER =3D (1 << 11),
> > +        VIRTIO_IB_QP_SQ_PSN =3D (1 << 12),
> > +        VIRTIO_IB_QP_MAX_DEST_RD_ATOMIC =3D (1 << 13),
> > +        VIRTIO_IB_QP_CAP =3D (1 << 14),
> > +        VIRTIO_IB_QP_DEST_QPN =3D (1 << 15),
> > +        VIRTIO_IB_QP_RATE_LIMIT =3D (1 << 16),
> > +};
>
> Do we need to explain the above error codes? Or it's simply a map from IB=
 spec?
>

Yes, it's defined in IB spec. But we can add some comments for them too.

> > +
> > +enum virtio_ib_qp_state {
> > +        VIRTIO_IB_QPS_RESET,
> > +        VIRTIO_IB_QPS_INIT,
> > +        VIRTIO_IB_QPS_RTR,
> > +        VIRTIO_IB_QPS_RTS,
> > +        VIRTIO_IB_QPS_SQD,
> > +        VIRTIO_IB_QPS_SQE,
> > +        VIRTIO_IB_QPS_ERR
> > +};
> > +
> > +enum virtio_ib_mtu {
> > +        VIRTIO_IB_MTU_256 =3D 1,
> > +        VIRTIO_IB_MTU_512 =3D 2,
> > +        VIRTIO_IB_MTU_1024 =3D 3,
> > +        VIRTIO_IB_MTU_2048 =3D 4,
> > +        VIRTIO_IB_MTU_4096 =3D 5
> > +};
> > +
> > +struct virtio_rdma_cmd_modify_qp {
> > +        /* The index of QP */
> > +        le32 qpn;
> > +        /* The mask of attributes needs to be modified, enum virtio_ib=
_qp_attr_mask */
> > +        le32 attr_mask;
> > +        /* Move the QP to this state, enum virtio_ib_qp_state */
> > +        u8 qp_state;
> > +        /* Current QP state, enum virtio_ib_qp_state */
> > +        u8 cur_qp_state;
> > +        /* Path MTU (valid only for RC/UC QPs), enum virtio_ib_mtu */
> > +        u8 path_mtu;
> > +        /* Number of outstanding RDMA Read operations on destination Q=
P (valid only for RC QPs) */
> > +        u8 max_rd_atomic;
> > +        /* Number of responder resources for handling incoming RDMA Re=
ad operations (valid only for RC QPs) */
> > +        u8 max_dest_rd_atomic;
> > +        /* Minimum RNR (Receiver Not Ready) NAK timer (valid only for =
RC QPs) */
> > +        u8 min_rnr_timer;
> > +        /* Local ack timeout (valid only for RC QPs) */
> > +        u8 timeout;
> > +        /* Retry count (valid only for RC QPs) */
> > +        u8 retry_cnt;
> > +        /* RNR retry (valid only for RC QPs) */
> > +        u8 rnr_retry;
> > +        /* Padding */
> > +        u8 padding[7];
> > +        /* Q_Key for the QP (valid only for UD QPs) */
> > +        le32 qkey;
> > +        /* PSN for RQ (valid only for RC/UC QPs) */
> > +        le32 rq_psn;
> > +        /* PSN for SQ */
> > +        le32 sq_psn;
> > +        /* Destination QP number (valid only for RC/UC QPs) */
> > +        le32 dest_qp_num;
> > +        /* Mask of enabled remote access operations (valid only for RC=
/UC QPs), enum virtio_ib_access_flags */
> > +        le32 qp_access_flags;
> > +        /* Rate limit in kbps for packet pacing */
> > +        le32 rate_limit;
> > +        /* QP capabilities */
> > +        struct virtio_rdma_qp_cap cap;
> > +        /* Address Vector (valid only for RC/UC QPs) */
> > +        struct virtio_rdma_ah_attr ah_attr;
> > +        /* Reserved for future */
> > +        le32 reserved[4];
> > +};
> > +\end{lstlisting}
> > +
> > +\item[VIRTIO_NET_CTRL_ROCE_QUERY_QP] Query the attributes of a Queue P=
air.
> > +  The command-specific-data is \field{virtio_rdma_cmd_query_qp};
> > +  the ack-specific-data is \field{virtio_rdma_ack_query_qp}.
> > +
> > +\begin{lstlisting}
> > +struct virtio_rdma_cmd_query_qp {
> > +       /* The index of QP */
> > +        le32 qpn;
> > +        /* The mask of attributes need to be queried, enum virtio_ib_q=
p_attr_mask */
> > +        le32 attr_mask;
> > +};
> > +
> > +struct virtio_rdma_ack_query_qp {
>
> Any chance to unify this with virtio_rdma_cmd_modify_qp?
>

It would be a little confusing since some states is only used by modify_qp.

> > +        /* Move the QP to this state, enum virtio_ib_qp_state */
> > +        u8 qp_state;
> > +        /* Path MTU (valid only for RC/UC QPs), enum virtio_ib_mtu */
> > +        u8 path_mtu;
> > +        /* Is the SQ draining */
> > +        u8 sq_draining;
> > +        /* Number of outstanding RDMA read operations on destination Q=
P (valid only for RC QPs) */
> > +        u8 max_rd_atomic;
> > +        /* Number of responder resources for handling incoming RDMA re=
ad operations (valid only for RC QPs) */
> > +        u8 max_dest_rd_atomic;
> > +        /* Minimum RNR NAK timer (valid only for RC QPs) */
> > +        u8 min_rnr_timer;
> > +        /* Local ack timeout (valid only for RC QPs) */
> > +        u8 timeout;
> > +        /* Retry count (valid only for RC QPs) */
> > +        u8 retry_cnt;
> > +        /* RNR retry (valid only for RC QPs) */
> > +        u8 rnr_retry;
> > +        /* Padding */
> > +        u8 padding[7];
> > +        /* Q_Key for the QP (valid only for UD QPs) */
> > +        le32 qkey;
> > +        /* PSN for RQ (valid only for RC/UC QPs) */
> > +        le32 rq_psn;
> > +        /* PSN for SQ */
> > +        le32 sq_psn;
> > +        /* Destination QP number (valid only for RC/UC QPs) */
> > +        le32 dest_qp_num;
> > +        /* Mask of enabled remote access operations (valid only for RC=
/UC QPs), enum virtio_ib_access_flags */
> > +        le32 qp_access_flags;
> > +        /* Rate limit in kbps for packet pacing */
> > +        le32 rate_limit;
> > +        /* QP capabilities */
> > +        struct virtio_rdma_qp_cap cap;
> > +        /* Address Vector (valid only for RC/UC QPs) */
> > +        struct virtio_rdma_ah_attr ah_attr;
> > +        /* Reserved for future */
> > +        le32 reserved[4];
> > +};
> > +\end{lstlisting}
> > +
> > +\item[VIRTIO_NET_CTRL_ROCE_DESTROY_QP] Destroy a Queue Pair.
> > +  The command-specific-data is \field{virtio_rdma_cmd_destroy_qp};
> > +  no ack-specific-data.
>
> What happen to the pending requests? Will the device wait for the
> completion or not?
>

It should be discarded according to IB spec.

> > +
> > +\begin{lstlisting}
> > +struct virtio_rdma_cmd_destroy_qp {
> > +        /* The index of QP */
> > +        le32 qpn;
> > +};
> > +\end{lstlisting}
> > +
> > +\item[VIRTIO_NET_CTRL_ROCE_CREATE_AH] Create a Address Handle (AH).
> > +  The command-specific-data is \field{virtio_rdma_cmd_create_ah};
> > +  the ack-specific-data is \field{virtio_rdma_ack_create_ah}.
> > +
> > +\begin{lstlisting}
> > +struct virtio_rdma_cmd_create_ah {
> > +        /* The handle of PD which the AH associated with */
> > +        le32 pdn;
> > +        /* Padding */
> > +        le32 padding;
> > +        /* Address Vector */
> > +        struct virtio_rdma_ah_attr ah_attr;
> > +};
> > +
> > +struct virtio_rdma_ack_create_ah {
> > +        /* The address handle */
> > +        le32 ah;
> > +};
> > +\end{lstlisting}
> > +
> > +\item[VIRTIO_NET_CTRL_ROCE_DESTROY_AH] Destroy a Address Handle.
> > +  The command-specific-data is \field{virtio_rdma_cmd_destroy_ah};
> > +  no ack-specific-data.
> > +
> > +\begin{lstlisting}
> > +struct virtio_rdma_cmd_destroy_ah {
> > +        /* The handle of PD which the AH associated with */
> > +        le32 pdn;
> > +        /* The address handle */
> > +        le32 ah;
> > +};
> > +\end{lstlisting}
> > +
> > +\item[VIRTIO_NET_CTRL_ROCE_ADD_GID] Add a Global Identifier (GID).
> > +  The command-specific-data is \field{virtio_rdma_cmd_add_gid};
> > +  no ack-specific-data.
> > +
> > +\begin{lstlisting}
> > +struct virtio_rdma_cmd_add_gid {
> > +        /* Index of GID */
> > +        le16 index;
> > +        /* Padding */
> > +        le16 padding[3];
> > +        /* GID to be added */
> > +        u8 gid[16];
> > +};
> > +\end{lstlisting}
> > +
> > +\item[VIRTIO_NET_CTRL_ROCE_DEL_GID] Delete a Global Identifier.
> > +  The command-specific-data is \field{virtio_rdma_cmd_del_gid};
> > +  no ack-specific-data.
> > +
> > +\begin{lstlisting}
> > +struct virtio_rdma_cmd_del_gid {
> > +        /* Index of GID */
> > +        le16 index;
> > +};
> > +\end{lstlisting}
> > +
> > +\item[VIRTIO_NET_CTRL_ROCE_REQ_NOTIFY_CQ] Request a completion notific=
ation
> > +  on a Completion Queue.
> > +  The command-specific-data is \field{virtio_rdma_cmd_req_notify};
> > +  no ack-specific-data.
> > +
> > +\begin{lstlisting}
> > +struct virtio_rdma_cmd_req_notify {
> > +        /* The index of CQ */
> > +        le32 cqn;
> > +#define VIRTIO_IB_NOTIFY_SOLICITED (1 << 0)
> > +#define VIRTIO_IB_NOTIFY_NEXT_COMPLETION (1 << 1)
>
> Need to describe the differences on those two flags.
>

OK.

> > +        /* Notify flags */
> > +        le32 flags;
> > +};
> > +\end{lstlisting}
> > +
> > +\end{description}
> > +
> > +\drivernormative{\subparagraph}{RoCE Configuration}{Device Types / Net=
work Device / Device Operation / Control Virtqueue / RoCE Configuration}
> > +
> > +A driver MUST initialize the completion virtqueue and fill it with
> > +enough entries after command VIRTIO_NET_CTRL_ROCE_CREATE_CQ is
> > +successfully executed.
> > +
> > +A driver MUST reset the completion virtqueue after
>
> How to do the reset? Do you mean driver need to reset the indices?
>

Yes, something like avail_idx, used_idx.

> > +command VIRTIO_NET_CTRL_ROCE_DESTROY_CQ is successfully executed.
> > +
> > +A driver MUST initialize the send virtqueue and receive virtqueue afte=
r
> > +command VIRTIO_NET_CTRL_ROCE_CREATE_QP is successfully executed.
> > +
> > +A driver MUST reset the send virtqueue and receive virtqueue after
> > +command VIRTIO_NET_CTRL_ROCE_DESTROY_QP is successfully executed.
> >
> >  \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Devic=
e
> >  Types / Network Device / Legacy Interface: Framing Requirements}
> > @@ -4496,6 +5063,289 @@ \subsubsection{Legacy Interface: Framing Requir=
ements}\label{sec:Device
> >  See \ref{sec:Basic
> >  Facilities of a Virtio Device / Virtqueues / Message Framing}.
> >
> > +\subsubsection{RoCE Support}\label{sec:Device Types / Network Device /=
 Device Operation / RoCE Support}
> > +
> > +RDMA over Converged Ethernet (RoCE) is a network protocol that allows
> > +remote direct memory access (RDMA) over an Ethernet network. To suppor=
t
> > +RoCE (if VIRTIO_NET_F_ROCE is negotiated), in addtion to the control
> > +virtqueue support mentioned in \ref{sec:Device Types / Network Device =
/
> > +Device Operation / Control Virtqueue / RoCE Configuration}, multiple
> > +types of virtqueues including send virtqueue, receive virtqueue and
> > +completion virtqueue are introduced.
> > +
> > +The send virtqueue contains elements that describe the data to be
> > +transmitted.
> > +
> > +Requests (device-readable) have the following format:
> > +
> > +\begin{lstlisting}
> > +enum virtio_ib_wr_opcode {
> > +        VIRTIO_IB_WR_RDMA_WRITE,
> > +        VIRTIO_IB_WR_RDMA_WRITE_WITH_IMM,
> > +        VIRTIO_IB_WR_SEND,
> > +        VIRTIO_IB_WR_SEND_WITH_IMM,
> > +        VIRTIO_IB_WR_RDMA_READ,
> > +};
> > +
> > +struct virtio_rdma_sge {
> > +        le64 addr;
> > +        le32 length;
> > +        le32 lkey;
> > +};
> > +
> > +struct virtio_rdma_sq_req {
> > +        /* User defined WR ID */
> > +        le64 wr_id;
> > +        /* WR opcode, enum virtio_ib_wr_opcode */
> > +        u8 opcode;
> > +#define VIRTIO_IB_SEND_FENCE        (1 << 0)
> > +#define VIRTIO_IB_SEND_SIGNALED     (1 << 1)
> > +#define VIRTIO_IB_SEND_SOLICITED    (1 << 2)
> > +#define VIRTIO_IB_SEND_INLINE       (1 << 3)
> > +        /* Flags of the WR properties */
> > +        u8 send_flags;
> > +        /* Padding */
> > +        le16 padding;
> > +        /* Immediate data (in network byte order) to send */
> > +        le32 imm_data;
> > +        union {
> > +                struct {
> > +                        /* Start address of remote memory buffer */
> > +                        le64 remote_addr;
> > +                        /* Key of the remote MR */
> > +                        le32 rkey;
> > +                } rdma;
> > +                struct {
> > +                        /* Index of the destination QP */
> > +                        le32 remote_qpn;
> > +                        /* Q_Key of the destination QP */
> > +                        le32 remote_qkey;
> > +                        /* Address Handle */
> > +                        le32 ah;
> > +                } ud;
> > +                /* Reserved for future */
> > +                le64 reserved[4];
> > +        };
> > +        /* Inline data */
> > +        u8 inline_data[512];
> > +        union {
> > +                /* Length of sg_list */
> > +                le32 num_sge;
> > +                /* Length of inline data */
> > +                le16 inline_len;
> > +        };
> > +        /* Reserved for future */
> > +        le32 reserved2[3];
> > +       /* Scatter/gather list */
> > +        struct virtio_rdma_sge sg_list[];
> > +};
> > +\end{lstlisting}
> > +
> > +The receive virtqueue contains elements that describe where to place i=
ncoming data.
> > +
> > +Requests (device-readable) have the following format:
> > +
> > +\begin{lstlisting}
> > +struct virtio_rdma_rq_req {
> > +        /* User defined WR ID */
> > +        le64 wr_id;
> > +        /* Length of sg_list */
> > +        le32 num_sge;
> > +        /* Reserved for future */
> > +        le32 reserved[3];
> > +        /* Scatter/gather list */
> > +        struct virtio_rdma_sge sg_list[];
> > +};
> > +\end{lstlisting}
> > +
> > +The completion virtqueue is used to notify the completion of requests =
in
> > +send virtqueue or receive virtqueue.
> > +
> > +Requests (device-writable) have the following format:
> > +
> > +\begin{lstlisting}
> > +enum virtio_ib_wc_opcode {
> > +        VIRTIO_IB_WC_SEND,
> > +        VIRTIO_IB_WC_RDMA_WRITE,
> > +        VIRTIO_IB_WC_RDMA_READ,
> > +        VIRTIO_IB_WC_RECV,
> > +        VIRTIO_IB_WC_RECV_RDMA_WITH_IMM,
> > +};
> > +
> > +enum virtio_ib_wc_status {
> > +        /* Operation completed successfully */
> > +        VIRTIO_IB_WC_SUCCESS,
> > +        /* Local Length Error */
> > +        VIRTIO_IB_WC_LOC_LEN_ERR,
> > +        /* Local QP Operation Error */
> > +        VIRTIO_IB_WC_LOC_QP_OP_ERR,
> > +        /* Local Protection Error */
> > +        VIRTIO_IB_WC_LOC_PROT_ERR,
> > +        /* Work Request Flushed Error */
> > +        VIRTIO_IB_WC_WR_FLUSH_ERR,
> > +        /* Bad Response Error */
> > +        VIRTIO_IB_WC_BAD_RESP_ERR,
> > +        /* Local Access Error */
> > +        VIRTIO_IB_WC_LOC_ACCESS_ERR,
> > +        /* Remote Invalid Request Error */
> > +        VIRTIO_IB_WC_REM_INV_REQ_ERR,
> > +        /* Remote Access Error */
> > +        VIRTIO_IB_WC_REM_ACCESS_ERR,
> > +        /* Remote Operation Error */
> > +        VIRTIO_IB_WC_REM_OP_ERR,
> > +        /* Transport Retry Counter Exceeded */
> > +        VIRTIO_IB_WC_RETRY_EXC_ERR,
> > +        /* RNR Retry Counter Exceeded */
> > +        VIRTIO_IB_WC_RNR_RETRY_EXC_ERR,
> > +        /* Remote Aborted Error */
> > +        VIRTIO_IB_WC_REM_ABORT_ERR,
> > +        /* Fatal Error */
> > +        VIRTIO_IB_WC_FATAL_ERR,
> > +        /* Response Timeout Error */
> > +        VIRTIO_IB_WC_RESP_TIMEOUT_ERR,
> > +        /* General Error */
> > +        VIRTIO_IB_WC_GENERAL_ERR
> > +};
> > +
> > +struct virtio_rdma_cq_req {
> > +        /* User defined WR ID */
> > +        le64 wr_id;
> > +        /* Work completion status, enum virtio_ib_wc_status */
> > +        u8 status;
> > +        /* WR opcode, enum virtio_ib_wc_opcode */
> > +        u8 opcode;
> > +        /* Padding */
> > +        le16 padding;
> > +        /* Vendor error */
> > +        le32 vendor_err;
> > +        /* Number of bytes transferred */
> > +        le32 byte_len;
> > +        /* Immediate data (in network byte order) to send */
> > +        le32 imm_data;
> > +        /* Local QP number of completed WR */
> > +        le32 qp_num;
> > +        /* Source QP number (remote QP number) of completed WR (valid =
only for UD QPs) */
> > +        le32 src_qp;
> > +#define VIRTIO_IB_WC_GRH         (1 << 0)
> > +#define VIRTIO_IB_WC_WITH_IMM    (1 << 1)
> > +        /* Work completion flag */
> > +        le32 wc_flags;
> > +        /* Reserved for future */
> > +        le32 reserved[3];
> > +};
> > +\end{lstlisting}
> > +
> > +\paragraph{Send Operation}\label{sec:Device Types / Network Device / D=
evice Operation / RoCE Support / Send Operation}
> > +
> > +The send operation allows us to send data to a remote QP=E2=80=99s Rec=
eive Queue.
> > +The receiver MUST have previously posted a receive buffer to receive t=
he data.
>
> "MUST" keyword must belong to the normative section.
>

OK.

> > +
> > +To do a send operation, a request with \field{opcode} set to
> > +VIRTIO_IB_WR_SEND or VIRTIO_IB_WR_SEND_WITH_IMM MUST be posted to the =
Send
> > +Queue as one output descriptor and the device is notified of the new e=
ntry.
> > +
> > +\drivernormative{\subparagraph}{Send Operation}{Device Types / Network=
 Device / Device Operation / RoCE Support / Send Operation}
> > +
> > +If VIRTIO_IB_SEND_INLINE is set in \field{send_flags}, the driver MUST=
 fill
> > +send buffer into \field{inline_data} field and set \field{inline_len} =
to the
> > +length of the buffer. Otherwise, the driver MUST fill \field{sg_list} =
to
> > +describe the buffer.
> > +
> > +\devicenormative{\subparagraph}{Send Operation}{Device Types / Network=
 Device / Device Operation / RoCE Support / Send Operation}
> > +
> > +If \field{opcode} is not set to VIRTIO_IB_WR_SEND_WITH_IMM, the device=
 MUST
> > +ignore \field{imm_data}.
> > +
> > +If the QP type is UD, the device MUST validate \field{ud.ah}.
> > +
> > +If VIRTIO_IB_SEND_INLINE is not set in \field{send_flags}, the device =
MUST
> > +validate the \field{addr}, \field{length} and \field{lkey} in \field{s=
g_list}.
> > +
> > +\paragraph{Receive Operation}\label{sec:Device Types / Network Device =
/ Device Operation / RoCE Support / Receive Operation}
> > +
> > +The receive operation allows us to receive data from remote QP.
> > +It's the corresponding operation to a send operation.
> > +
> > +To do a receive operation, a request MUST be posted to the Receive
> > +Queue as one output descriptor and the device is notified of the new e=
ntry.
> > +
>
> I think we probably need to be more verbose as what has been done for
> virtio-net.
>
> That is, describe what need to be filled in virtio_rdma_rq_req in
> details. (And do this for other operation as well)
>

OK.

>
> > +\drivernormative{\subparagraph}{Receive Operation}{Device Types / Netw=
ork Device / Device Operation / RoCE Support / Receive Operation}
> > +
> > +The driver MUST fill \field{sg_list} to describe the receive buffer.
> > +
> > +\devicenormative{\subparagraph}{Receive Operation}{Device Types / Netw=
ork Device / Device Operation / RoCE Support / Receive Operation}
> > +
> > +The device MUST validate the \field{addr}, \field{length} and \field{l=
key}
> > +in \field{sg_list}.
> > +
> > +\paragraph{Write Operation}\label{sec:Device Types / Network Device / =
Device Operation / RoCE Support / Write Operation}
> > +
> > +The write operation allows us to write data to the local memory buffer
> > +in remote side with no notification. The remote side wouldn't be aware
> > +that this operation being done.
> > +
> > +To do a write operation, a request with \field{opcode} set to
> > +VIRTIO_IB_WR_RDMA_WRITE or VIRTIO_IB_WR_RDMA_WRITE_WITH_IMM MUST be
> > +posted to the Send Queue as one output descriptor and the device is
> > +notified of the new entry.
> > +
> > +\drivernormative{\subparagraph}{Write Operation}{Device Types / Networ=
k Device / Device Operation / RoCE Support / Write Operation}
> > +
> > +The driver MUST fill \field{sg_list} to describe the write buffer.
>
> So sg is a must even if the driver want to use imm?
>

Looks like not. I will fix it.

> > +
> > +The driver MUST fill \field{rdma.remote_addr} and \field{rdma.rkey} to
> > +identify the remote buffer.
> > +
> > +\devicenormative{\subparagraph}{Write Operation}{Device Types / Networ=
k Device / Device Operation / RoCE Support / Write Operation}
> > +
> > +If \field{opcode} is not set to VIRTIO_IB_WR_RDMA_WRITE_WITH_IMM, the =
device
> > +MUST ignore \field{imm_data}.
> > +
> > +The device MUST validate the \field{addr}, \field{length} and \field{l=
key}
> > +in \field{sg_list}.
> > +
> > +\paragraph{Read Operation}\label{sec:Device Types / Network Device / D=
evice Operation / RoCE Support / Read Operation}
> > +
> > +The read operation allows us to read data from the local memory buffer
> > +in remote side with no notification. The remote side wouldn't be aware
> > +that this operation being done.
> > +
> > +To do a read operation, a request with \field{opcode} set to
> > +VIRTIO_IB_WR_RDMA_READ MUST be posted to the Send Queue as one output
> > +descriptor and the device is notified of the new entry.
> > +
> > +\drivernormative{\subparagraph}{Read Operation}{Device Types / Network=
 Device / Device Operation / RoCE Support / Read Operation}
> > +
> > +The driver MUST fill \field{sg_list} to describe the read buffer.
> > +
> > +The driver MUST fill \field{rdma.remote_addr} and \field{rdma.rkey} to
> > +identify the remote buffer.
> > +
> > +\devicenormative{\subparagraph}{Read Operation}{Device Types / Network=
 Device / Device Operation / RoCE Support / Read Operation}
> > +
> > +The device MUST validate the \field{addr}, \field{length} and \field{l=
key}
> > +in \field{sg_list}.
> > +
> > +\paragraph{Completion Notification}\label{sec:Device Types / Network D=
evice / Device Operation / RoCE Support / Completion Notification}
> > +
> > +After above operation is completed, a completion notification MUST
> > +be triggered by the device.
>
> For "completion notification", do you mean the virtqueue notification
> of cq or the making the buffer than contains cqe used?
>

Both? Making the buffer that contains cqe used and notify the virtqueue.

> > To achieve that, the device MUST consume
> > +an entry of the Completion Queue associated with the Send Queue/Receiv=
e
> > +Queue which the operation belongs to.
> > +
> > +\drivernormative{\subparagraph}{Completion Notification}{Device Types =
/ Network Device / Device Operation / RoCE Support / Completion Notificatio=
n}
> > +
> > +The driver MUST fill the Completion Queue with enough entries previous=
ly.
>
> What do you mean by "previously"? What happens if there's no sufficient c=
qe?
>

We need to fill the Completion Queue in advance. Otherwise, the driver
would not get completion notification after some operation is
completed.

Thanks,
Yongji
