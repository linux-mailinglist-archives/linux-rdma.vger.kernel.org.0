Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02C540CD5D
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 21:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhIOTpv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Sep 2021 15:45:51 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:37786 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229732AbhIOTpv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Sep 2021 15:45:51 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id 0A216B00277; Wed, 15 Sep 2021 21:44:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 094C8B0019F;
        Wed, 15 Sep 2021 21:44:30 +0200 (CEST)
Date:   Wed, 15 Sep 2021 21:44:30 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Leon Romanovsky <leon@kernel.org>
cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH][FIX] ROCE Multicast: Do not send IGMP leaves for sendonly
 Multicast groups
In-Reply-To: <YT8qM0IpIslXL4Ni@unreal>
Message-ID: <alpine.DEB.2.22.394.2109152141480.3690@gentwo.de>
References: <alpine.DEB.2.22.394.2109081340540.668072@gentwo.de> <YT8qM0IpIslXL4Ni@unreal>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 13 Sep 2021, Leon Romanovsky wrote:

> On Wed, Sep 08, 2021 at 01:43:28PM +0200, Christoph Lameter wrote:
> > ROCE uses IGMP for Multicast instead of the native Infiniband system where
> > joins are required in order to post messages on the Multicast group.
>
> According to the IBTA v1.5, there is no need to join multicast group to
> send messages.

This is ROCE where you do not need to do a join since its Ethernet
Multicast.

On Infiniband (which this patch is not dealing with) you can only send if
you join a multicast group by sending a join request with the MGID to the
SM. SM will reconfigure the IB switches so that your traffic can be routed
to the receivers of the multicast channel.

See the sendonly join description in the IBTA manuals.

>  10.5.2 MULTICAST WORK REQUESTS
>  10.5.2.1 IBA UNRELIABLE MULTICAST WORK REQUESTS
>   ...
>   A QP is not required to be attached to a Multicast Group
>   in order to initiate an IBA Unreliable Multicast Work Request.
>
> Did I look in wrong place?

Work request? Does that mean it send multicast?

