Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5023D44F74E
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Nov 2021 10:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhKNJMH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Nov 2021 04:12:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhKNJME (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 14 Nov 2021 04:12:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D349D60E9B;
        Sun, 14 Nov 2021 09:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636880948;
        bh=wQEp2OUWa67xvGp7dtVFumAFHt/CVrkYIHs9eS/yl2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsoRgQCdKakUcZWLNEtELEOYtJuT5drwFGB0tHDJKshMPks0RDGFRSMhibdiQOwRY
         SAvhEGFBDmPMO486ILesqPO57eLQ+/tAneV/gMAkHZvcPfIKtmVWzILo/8S3UVRDk2
         TXBEntLQ2DNuJI4U7ykSoQeJdS2HaWBV1z4QOn6lqTWBJIqoT2+X2q1h/8jdcfK7US
         E8F3ixiGxjiXzBW2z0LTKwhWt36TJI+MwMJcQFZmszpTCyM5JAMqYIuJgfMVxPJtT5
         cimnFonAvtwHVfaXLltA9YeNnLLgtKqeyOExfuiITeXyODd5I4cMpQVU2STZDz+CRT
         1Bh/vVJG8RS3w==
Date:   Sun, 14 Nov 2021 11:09:04 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Lameter <cl@vmi485042.contaboserver.net>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        rpearson@gmail.com, Doug Ledford <dledford@redhat.com>
Subject: Re: [RFC] RDMA bridge for ROCE and Infiniband
Message-ID: <YZDSMCSmixPdS8hf@unreal>
References: <alpine.DEB.2.22.394.2111121300290.380553@vmi485042.contaboserver.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2111121300290.380553@vmi485042.contaboserver.net>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 12, 2021 at 01:04:13PM +0100, Christoph Lameter wrote:
> We have a larger Infiniband deployment and want to gradually move servers
> to a new fabric that is using RDMA over Ethernet using ROCE. The IB
> Fabric is mission critical and complex due to the need to have various
> ways to prevent failover with one of them being a secondary IB fabric.
> 
> It is not possible resourcewise to simply rebuild the system using ROCE
> and then switch over.
> 
> Both Fabrics use RDMA and we need some way for nodes on each cluster to
> communicate with each other. We do not really need memory to memory
> transfers. What we use from the RDMA
> stack is basically messaging and multicast. So the really
> core services of the RDMA stack are not needed. Also UD/UDP is sufficient,
> the other protocols may not be necessary to support.
> 
> Any ideas on how to do this would be appreciated. I have not found anything
> that could help us here, so we are interested in creating a new piece of
> Open Source RDMA software that allows the briding of native IB traffic to ROCE.
> 
> 
> Basic Design
> ------------
> Lets say we have a single system that functions as a *bridge* and has one
> interface going to Infiniband and one going to Ethernet with ROCE.
> 
> In our use case we do not need any "true" RDMA in the sense of memory to
> memory transfers. We only need UDP and UD messsaging and support for
> multicast.
> 
> In order to simplify the multicast aspects, the bridge will simply
> subscribe to the multicast groups of interest when the bridge software
> starts up.
> 
> PROXYARP for regular IP / IPoIB traffic
> --------------------------------------
> It is possible to do proxyarp on both sides of a Linux system that is
> connected both to Infiniband and ROCE. And thus this can already be seen
> as a single IP subnet from the Kernel stack perspective and communication
> is not a problem for non RDMA traffic.
> 
> PROXYARP means that the MAC address of the bridge is used for all IPoIB
> addresses on the IB side of the bridge. Similar the GID of the bridge is
> used in all IPoIB Packets on the IB side of the bridge that come from the
> ROCE side.
> 
> The kernel already removes and adds IPoIB and IP headers as needed. So
> this works for regular IP traffic but not for native IB / RDMA packets.
> IP traffic is only used for non performance critical aspects of
> our application and so the performance on this level is not a concern.
> 
> Each of the host in the bridge IP subnet has 3 addresses: An IPv4
> address, a MAC address and a GID.
> 
> 
> RDMA Packets (Native IB and ROCE)
> =================================
> ROCE v2 packets are basically IB packets with another header on top so
> the simplistic idealistic version of how this is going to
> work is by stripping and adding the UDP ROCE v2 headers to the IB packet.
> 
> ROCE packets
> ------------
> UDP roce packets send to the IP addresses on the ROCE side have the MAC
> address of the bridge. So these already contain the IP address for the
> other side that can be used to lookup the GID in order to convert the
> packet and forward it to the Infiniband node.
> 
> UD packets
> ----------
> Routing capabilities are limited on the Infiniband side but one could
> construct a way to map GIDs for the hosts on the ROCE side to the LID
> of the bridge by using the ACM daemon.
> 
> There will be complications regards to RDMA_CM support and the details
> of mapping characteristics between packets but hopefully this will
> be fairly manageable.
> 
> Multicast packets
> -----------------
> 
> Multicast packets can be converted easily since there is a direct
> mapping possible between the MAC address used for a Multicast group and
> the MGID in the Infiniband fabric. Otherwise this process is similar
> to UD/UDP traffic.
> 
> 
> Implementation
> ==============
> 
> There are basically three ways to implement this:
> 
> A) As add on to the RDMA stack in the Linux Kernel
> B) As a user space process that operates on RAW sockets and receives traffic
>    filtered by the NIC or by the kernel to process. It wouild use the same
>    raw sockets to send these packets to the other side.
> C) In firmware / logic of the NIC. This is out of reach of us here
>    I think.
> 
> 
> Inbound from ROCE
> -----------------
> This can be done like in the RXE driver. Simply listening to the UDP port
> for ROCE will get us the traffic we need to operate on.
> 
> Outbound to ROCE
> ----------------
> A Ethernet RAW socket will allow us to create arbitrary datagrams as needed.
> This has been widely done before in numerous settings and code is already
> open sources that does stuff like this. So this is fairly straightforward.
> 
> Inbound from Infiniband
> -----------------------
> The challenge here is to isolate the traffic that is destined for the bridge
> itself from traffic that needs to be forwarded. One way would be to force
> the inclusion of a Global Header in each packet so that the GID can be
> matched. When the GID does not match the bridge then the traffic would be
> forwarded to the code which could then do the necessary packet conversion.
> 
> I do not know of any way that something like this has been done before.
> Potentially this means working with flow steering and dealing with firmware
> issues in the NIC.
> 
> Outbound to Infiniband
> ----------------------
> I saw in a recent changelog for the Mellanox NICs that the ability has
> been added to send raw IB datagrams. If that can be used to construct
> a packet that is coming from one of the GIDs associated with the ROCE IP
> addresses then this will work.
> 
> Otherwise we need to have some way to set the GID for outbound packets
> to make this work.
> 
> The logic needed on Infiniband is similar to that required for an
> Infiniband router.
> 
> 
> 
> 
> The biggest risk here seems to be the Infiniband side of things. Is there
> a way to create a filter for the traffic we need?
> 
> Any tips and suggestions on how to approach this problem would be appreciated.

Mellanox has Skyway product, which is IB to ETH gateway.
https://www.nvidia.com/en-us/networking/infiniband/skyway/

I imagine that it can be extended to perform IB to RoCE too,
because it uses steering to perform IB to ETH translation.

Thanks

> 
> 
> Christoph Lameter, 12. November 2021
> 
