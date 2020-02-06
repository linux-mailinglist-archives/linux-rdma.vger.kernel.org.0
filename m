Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7223154611
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2020 15:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgBFOZ5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Feb 2020 09:25:57 -0500
Received: from p3plsmtpa09-08.prod.phx3.secureserver.net ([173.201.193.237]:60661
        "EHLO p3plsmtpa09-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727511AbgBFOZ5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Feb 2020 09:25:57 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Feb 2020 09:25:57 EST
Received: from [192.168.0.78] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id zhzKiiFlj56i1zhzKikepk; Thu, 06 Feb 2020 07:18:39 -0700
Subject: Re: [RFC v2] RoCE v2.0 Entropy - IPv6 Flow Label and UDP Source Port
To:     Alex Rosenbaum <rosenbaumalex@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        "Alex @ Mellanox" <alexr@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Mark Zhang <markz@mellanox.com>
References: <CAFgAxU8ArpoL9fMpJY5v-UZS5AMXom+TJ8HS57XeEOsCFFov8Q@mail.gmail.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <63a56c06-57bf-6e31-6ca8-043f9d3b72f3@talpey.com>
Date:   Thu, 6 Feb 2020 09:18:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAFgAxU8ArpoL9fMpJY5v-UZS5AMXom+TJ8HS57XeEOsCFFov8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJ3l1tx8vMUtXPXGxjpiDRXTt64zrv1tEeXCG5KXbc4UG/yjEXvJNrPzQsdBgs5r/JKQQSUbD52fJitcP998iqLjNQrFy/n6yTW10jVUTxaShts+29Oq
 zHzS8Xd1JS0xx0NxF7+udEOJ86I+VahtkMO+Xlp5WsuKo01opJXwAXL5jxPYkqlwKhxi8xsuPejrK+JZWSPQ0WyblfVIEBdwP9gr0bP26G2W1CpfAa2DpJYf
 PgGv994HSYsVn4DucICYFGSyFlBvypSTgm01sXRCouNWzUJcg8Kqzu/D8ljE0fdX+QVIOXKSnn+IO1RmQ9e+U7EGTTYAkImy3q7fgYX7UDfDPs1JJKt0avbw
 XkXBPhisw2f6N7jB4l7cF4X8RBUzOherYEjm4KjTaCTo0me9Nkoax1CHV5T+Fa6PRbT3iZMu
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/8/2020 9:26 AM, Alex Rosenbaum wrote:
> A combination of the flow_label field in the IPv6 header and UDP source port
> field in RoCE v2.0 are used to identify a group of packets that must be
> delivered in order by the network, end-to-end.
> These fields are used to create entropy for network routers (ECMP), load
> balancers and 802.3ad link aggregation switching that are not aware of RoCE IB
> headers.
> 
> The flow_label field is defined by a 20 bit hash value. CM based connections
> will use a hash function definition based on the service type (QP Type) and
> Service ID (SID). Where CM services are not used, the 20 bit hash will be
> according to the source and destination QPN values.
> Drivers will derive the RoCE v2.0 UDP src_port from the flow_label result.
> 
> UDP source port selection must adhere IANA port allocation ranges. Thus we will
> be using IANA recommendation for Ephemeral port range of: 49152-65535, or in
> hex: 0xC000-0xFFFF.
> 
> The below calculations take into account the importance of producing a symmetric
> hash result so we can support symmetric hash calculation of network elements.
> 
> Hash Calculation for RDMA IP CM Service
> =======================================
> For RDMA IP CM Services, based on QP1 iMAD usage and connected RC QPs using the
> RDMA IP CM Service ID, the flow label will be calculated according to IBTA CM
> REQ private data info and Service ID.
> 
> Flow label hash function calculations definition will be defined as:
> Extract the following fields from the CM IP REQ:
>    CM_REQ.ServiceID.DstPort [2 Bytes]
>    CM_REQ.PrivateData.SrcPort [2 Bytes]
>    u32 hash = DstPort * SrcPort;
>    hash ^= (hash >> 16);
>    hash ^= (hash >> 8);
>    AH_ATTR.GRH.flow_label = hash AND IB_GRH_FLOWLABEL_MASK;
> 
>    #define IB_GRH_FLOWLABEL_MASK  0x000FFFFF

Sorry it took me a while to respond to this, and thanks for looking
into it since my comments on the previous proposal. I have a concern
with an aspect of this one.

The RoCEv2 destination port is a fixed value, 4791. Therefore the
term

	u32 hash = DstPort * SrcPort;

adds no entropy beyond the value of SrcPort.

In turn, the subsequent

	hash ^= (hash >> 16);
	hash ^= (hash >> 8);

are re-mashing the bits with one another, again, adding no entropy.

Can you describe how, mathematically, this is not different from simply
using the SrcPort field, and if so, how it contributes to the entropy
differentiation of the incoming streams?

Tom.

> Result of the above hash will be kept in the CM's route path record connection
> context and will be used all across its vitality for all preceding CM messages
> on both ends of the connection (including REP, REJ, DREQ, DREP, ..).
> Once connection is established, the corresponding Connected RC QPs, on both
> ends of the connection, will update their context with the calculated RDMA IP
> CM Service based flow_label and UDP src_port values at the Connect phase of
> the active side and Accept phase of the passive side of the connection.
> 
> CM will provide to the calculated value of the flow_label hash (20 bit) result
> in the 'uint32_t flow_label' field of 'struct ibv_global_route' in 'struct
> ibv_ah_attr'.
> The 'struct ibv_ah_attr' is passed by the CM to the provider library when
> modifying a connected QP's (e.g.: RC) state by calling 'ibv_modify_qp(qp,
> ah_attr, attr_mask |= IBV_QP_AV)' or when create a AH for working with
> datagram QP's (e.g.: UD) by calling ibv_create_ah(ah_attr).
> 
> Hash Calculation for non-RDMA CM Service ID
> ===========================================
> For non CM QP's, the application can define the flow_label value in the
> 'struct ibv_ah_attr' when modifying the connected QP's (e.g.: RC) or creating
> a AH for the datagram QP's (e.g.: UD).
> 
> If the provided flow_label value is zero, not set by the application (e.g.:
> legacy cases), then verbs providers should use the src.QP[24bit] and
> dst.QP[24bit] as input arguments for flow_label calculation.
> As QPN's are an array of 3 bytes, the multiplication will result in 6 bytes
> value. We'll define a flow_label value as:
>    DstQPn [3 Bytes]
>    SrcQPn [3 Bytes]
>    u64 hash = DstQPn * SrcQPn;
>    hash ^= (hash >> 20);
>    hash ^= (hash >> 40);
>    AH_ATTR.GRH.flow_label = hash AND IB_GRH_FLOWLABEL_MASK;
> 
> Hash Calculation for UDP src_port
> =================================
> Providers supporting RoCEv2 will use the 'flow_label' value as input to
> calculate the RoCEv2 UDP src_port, which will be used in the QP context or the
> AH context.
> 
> UDP src_port calculations from flow label:
> [while considering the 14 bits UDP port range according to IANA recommendation]
>    AH_ATTR.GRH.flow_label [20 bits]
>    u32 fl_low  = fl & 0x03FFF;
>    u32 fl_high = fl & 0xFC000;
>    u16 udp_sport = fl_low XOR (fl_high >> 14);
>    RoCE.UDP.src_port = udp_sport OR IB_ROCE_UDP_ENCAP_VALID_PORT
> 
>    #define IB_ROCE_UDP_ENCAP_VALID_PORT 0xC000
> 
> This is a v2 follow-up on "[RFC] RoCE v2.0 UDP Source Port Entropy" [1]
> 
> [1] https://www.spinics.net/lists/linux-rdma/msg73735.html
> 
> Signed-off-by: Alex Rosenbaum <alexr@mellanox.com>
> 
> 
