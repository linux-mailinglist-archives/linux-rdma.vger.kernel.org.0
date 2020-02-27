Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32EE4171B51
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 15:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgB0OBV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 09:01:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732905AbgB0OBT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 09:01:19 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ADF620578;
        Thu, 27 Feb 2020 14:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812079;
        bh=n3I35yElf1J5MhF/uEIaFVI3u8WY37KG3XXa6UfWeIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s0MICNR2DUQwtDpVSk8t90VV3mqkQaBNAW/H36F3fkrPBOy94E8da2QpWfncpeXZP
         K7uYPPVBcPBaxlgk15J31K3++Q0kOCQmqaMa2iyXfALtJMmcgTVpU1706Rs2ucun0u
         kXb3pEqjpbZ0SsT4EIK1LHpdFAVst/dX+XkCbbRw=
Date:   Thu, 27 Feb 2020 16:01:16 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     bugzilla-daemon@bugzilla.kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [Bug 206687] New: If IB link comes up, oops in
 port_pkey_list_insert triggered with "NULL pointer derefence"
Message-ID: <20200227140116.GN12414@unreal>
References: <bug-206687-11804@https.bugzilla.kernel.org/>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-206687-11804@https.bugzilla.kernel.org/>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 27, 2020 at 10:57:34AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=206687
>
>             Bug ID: 206687
>            Summary: If IB link comes up, oops in port_pkey_list_insert
>                     triggered with "NULL pointer derefence"
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: v5.4.21 ongoing
>           Hardware: x86-64
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: high
>           Priority: P1
>          Component: Infiniband/RDMA
>           Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
>           Reporter: hjl@simulated-universe.de
>         Regression: No
>
> I am running a Fedora home server for testing purpose and using QLA7322
> Infinband adapters to connect my workstation.
>
> Since the upgrade to Fedora 31, that comes with a v5.5.5 kernel, the system
> crashes as the network manager tries to configure the IPoIB interface.
>
> I checked the last installed fedora 30 kernel and all went fine.
> Next I used the vanilla-kernels v5.4.19, v5.4.20 and v5.4.21 and tracked the
> problem down to the v5.4.21
>

this should fix the failure.
https://lore.kernel.org/linux-rdma/20200227112708.93023-1-leon@kernel.org

Thanks
