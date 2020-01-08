Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C05151344F2
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 15:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgAHO0x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 09:26:53 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:42440 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgAHO0x (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 09:26:53 -0500
Received: by mail-wr1-f53.google.com with SMTP id q6so3556029wro.9
        for <linux-rdma@vger.kernel.org>; Wed, 08 Jan 2020 06:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=4WvNDw3/eniKf7oIGCh7BVc0gldEt5FmFrJIHu98lwM=;
        b=ESPHMa6RgZcSh5nWsowz7rM/rQVEqxuI9RDaQXwWqfQZmxjQP9TDl6HCY2pzKTF5Tc
         JeBtev/4ZBxKc+S/VFuL1ZZrNuvXILnvm8sT11RV9cIF9zHzxKcsWRbaVApodf5tAHc8
         sQrkxZjlYPzm2dzVP30ZseXU5saD2Wqtl9ueA7zBpixIHLzTF2NBxHAJNvL1ZFZqDhuM
         xFoZBByETTZSkUVWwSx/RLXqvIGlJzb6qjh9lSVlcw+r5aw0Mfr8b/NLvHbsARhbMEnw
         JHlL3Yfe3NCP344DieyR4b/35cOrgqSkte95i/lsHWgNy4nhg/ULmHtiEEJWAuD7OOFy
         hDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4WvNDw3/eniKf7oIGCh7BVc0gldEt5FmFrJIHu98lwM=;
        b=epPqqTAMe9QyugRLWiQst98WuwcDXaALU81Hmjx2TnIkXX3Z9djmGuoHkpVcg2sj99
         N+hZGOXzZuk8Unn9dQ1P5GN/mHiZrKU8se88csZihdkEdA+98GH++Jfara+kwDFdistC
         STx8eLhg2srFoy3hSj6uPEFe37lcGe6+U8Rcpe9RSLNqZXZfh/O0NsZlN7PdOzvTP6DU
         JaRF4+/zuNPfzMUgabr0hI9RE23G4MOVOGYHMry0st2rynO/vo5O+NfUi7/5qnIQoFrR
         bi5+rImIvvkqp7pPv6M0AbOuCJ+auZfQy0W3Nzuc6fKoxnFzgiAf3IaKEtlRQRVssPB0
         1h9Q==
X-Gm-Message-State: APjAAAXrgPXyJUTX5h/Dtx+Eodpji2BvFuwrVce9nNDHWXFTyr7i00G3
        4gF2LRCWW5cDw1B1zL0y0/F/l5bK3FXwJDOWNY2f4ugI
X-Google-Smtp-Source: APXvYqxfPmUhNEcf7Jc4h1L923SB3DNAo4vRLxgO6CtLVULh9/QV2Bd8y3GNpl+WgsaFNV0h08sU6CLaDyAipfwXy4c=
X-Received: by 2002:adf:eb51:: with SMTP id u17mr4921883wrn.29.1578493610247;
 Wed, 08 Jan 2020 06:26:50 -0800 (PST)
MIME-Version: 1.0
From:   Alex Rosenbaum <rosenbaumalex@gmail.com>
Date:   Wed, 8 Jan 2020 16:26:39 +0200
Message-ID: <CAFgAxU8ArpoL9fMpJY5v-UZS5AMXom+TJ8HS57XeEOsCFFov8Q@mail.gmail.com>
Subject: [RFC v2] RoCE v2.0 Entropy - IPv6 Flow Label and UDP Source Port
To:     RDMA mailing list <linux-rdma@vger.kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        "Alex @ Mellanox" <alexr@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Mark Zhang <markz@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A combination of the flow_label field in the IPv6 header and UDP source port
field in RoCE v2.0 are used to identify a group of packets that must be
delivered in order by the network, end-to-end.
These fields are used to create entropy for network routers (ECMP), load
balancers and 802.3ad link aggregation switching that are not aware of RoCE IB
headers.

The flow_label field is defined by a 20 bit hash value. CM based connections
will use a hash function definition based on the service type (QP Type) and
Service ID (SID). Where CM services are not used, the 20 bit hash will be
according to the source and destination QPN values.
Drivers will derive the RoCE v2.0 UDP src_port from the flow_label result.

UDP source port selection must adhere IANA port allocation ranges. Thus we will
be using IANA recommendation for Ephemeral port range of: 49152-65535, or in
hex: 0xC000-0xFFFF.

The below calculations take into account the importance of producing a symmetric
hash result so we can support symmetric hash calculation of network elements.

Hash Calculation for RDMA IP CM Service
=======================================
For RDMA IP CM Services, based on QP1 iMAD usage and connected RC QPs using the
RDMA IP CM Service ID, the flow label will be calculated according to IBTA CM
REQ private data info and Service ID.

Flow label hash function calculations definition will be defined as:
Extract the following fields from the CM IP REQ:
  CM_REQ.ServiceID.DstPort [2 Bytes]
  CM_REQ.PrivateData.SrcPort [2 Bytes]
  u32 hash = DstPort * SrcPort;
  hash ^= (hash >> 16);
  hash ^= (hash >> 8);
  AH_ATTR.GRH.flow_label = hash AND IB_GRH_FLOWLABEL_MASK;

  #define IB_GRH_FLOWLABEL_MASK  0x000FFFFF

Result of the above hash will be kept in the CM's route path record connection
context and will be used all across its vitality for all preceding CM messages
on both ends of the connection (including REP, REJ, DREQ, DREP, ..).
Once connection is established, the corresponding Connected RC QPs, on both
ends of the connection, will update their context with the calculated RDMA IP
CM Service based flow_label and UDP src_port values at the Connect phase of
the active side and Accept phase of the passive side of the connection.

CM will provide to the calculated value of the flow_label hash (20 bit) result
in the 'uint32_t flow_label' field of 'struct ibv_global_route' in 'struct
ibv_ah_attr'.
The 'struct ibv_ah_attr' is passed by the CM to the provider library when
modifying a connected QP's (e.g.: RC) state by calling 'ibv_modify_qp(qp,
ah_attr, attr_mask |= IBV_QP_AV)' or when create a AH for working with
datagram QP's (e.g.: UD) by calling ibv_create_ah(ah_attr).

Hash Calculation for non-RDMA CM Service ID
===========================================
For non CM QP's, the application can define the flow_label value in the
'struct ibv_ah_attr' when modifying the connected QP's (e.g.: RC) or creating
a AH for the datagram QP's (e.g.: UD).

If the provided flow_label value is zero, not set by the application (e.g.:
legacy cases), then verbs providers should use the src.QP[24bit] and
dst.QP[24bit] as input arguments for flow_label calculation.
As QPN's are an array of 3 bytes, the multiplication will result in 6 bytes
value. We'll define a flow_label value as:
  DstQPn [3 Bytes]
  SrcQPn [3 Bytes]
  u64 hash = DstQPn * SrcQPn;
  hash ^= (hash >> 20);
  hash ^= (hash >> 40);
  AH_ATTR.GRH.flow_label = hash AND IB_GRH_FLOWLABEL_MASK;

Hash Calculation for UDP src_port
=================================
Providers supporting RoCEv2 will use the 'flow_label' value as input to
calculate the RoCEv2 UDP src_port, which will be used in the QP context or the
AH context.

UDP src_port calculations from flow label:
[while considering the 14 bits UDP port range according to IANA recommendation]
  AH_ATTR.GRH.flow_label [20 bits]
  u32 fl_low  = fl & 0x03FFF;
  u32 fl_high = fl & 0xFC000;
  u16 udp_sport = fl_low XOR (fl_high >> 14);
  RoCE.UDP.src_port = udp_sport OR IB_ROCE_UDP_ENCAP_VALID_PORT

  #define IB_ROCE_UDP_ENCAP_VALID_PORT 0xC000

This is a v2 follow-up on "[RFC] RoCE v2.0 UDP Source Port Entropy" [1]

[1] https://www.spinics.net/lists/linux-rdma/msg73735.html

Signed-off-by: Alex Rosenbaum <alexr@mellanox.com>
