Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700541D1178
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 13:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgEMLgU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 07:36:20 -0400
Received: from p3plsmtpa09-04.prod.phx3.secureserver.net ([173.201.193.233]:37320
        "EHLO p3plsmtpa09-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726492AbgEMLgU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 May 2020 07:36:20 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 May 2020 07:36:20 EDT
Received: from [192.168.0.78] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id YpZMjTADkI72ZYpZNjSOya; Wed, 13 May 2020 04:29:01 -0700
X-CMAE-Analysis: v=2.3 cv=CPZUoijD c=1 sm=1 tr=0
 a=ugQcCzLIhEHbLaAUV45L0A==:117 a=ugQcCzLIhEHbLaAUV45L0A==:17
 a=IkcTkHD0fZMA:10 a=CbDCq_QkAAAA:8 a=4bPhzUQfME4wYwQ2_1cA:9 a=QEXdDO2ut3YA:10
 a=1qrBK16LubpBFNPVNq2M:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH] IB/iser: Remove support for FMR memory registration
To:     Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Israel Rukshin <israelr@mellanox.com>
Cc:     sagi@grimberg.me, jgg@mellanox.com, linux-rdma@vger.kernel.org,
        dledford@redhat.com, sergeygo@mellanox.com
References: <1589299739-16570-1-git-send-email-israelr@mellanox.com>
 <20200512171633.GO4814@unreal> <5b8b0b51-83e3-06c2-9b99-dec0862c0e5b@acm.org>
 <49391e02-803b-f705-b00e-e48efd278759@mellanox.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <a8066fdf-94f5-b033-e3d2-65698cf5932c@talpey.com>
Date:   Wed, 13 May 2020 07:29:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <49391e02-803b-f705-b00e-e48efd278759@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAhengb1lPnD0XUu+XFW2HPipPvaYQWA7nNjIAYwSpvYblQyOCtGll2YeEhm9I9zWwKzdV5/mnfg6Oez+8Hu6Vz6OwuAU2yupU4k+K46ocGIt4IQCYK+
 /+E0uapEC3l3F4ErloubGquuLs6Tk/zna7xqxbEWIUy+EVBRpeniJL1mVo0FxcGNAyk3N/lx6omI924lehjTB3EUdQDWI1PIk84UQWYgwkpgEBhGnmO4UUsX
 bAa8mhVRU0uJYzWjeQJ5mo2H90CcAJBHcmZbNhevWezmLUU6ecA70aU9RKGB2GwOsEmwGTp/h+6MQq5DJ4b57prOb6aHOpAU2RsLAQ1KbeXJ7mSBBjJassmD
 D/5Gky/iCgtXMYghlp0019Lx7oqizYXoU9C58uQl1gDDN4s3yh0=
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/13/2020 4:43 AM, Max Gurtovoy wrote:
> 
> On 5/12/2020 11:09 PM, Bart Van Assche wrote:
>> On 2020-05-12 10:16, Leon Romanovsky wrote:
>>> On Tue, May 12, 2020 at 07:08:59PM +0300, Israel Rukshin wrote:
>>>> FMR is not supported on most recent RDMA devices (that use fast memory
>>>> registration mechanism). Also, FMR was recently removed from NFS/RDMA
>>>> ULP.
>>>>
>>>> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
>>>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>>>> ---
>>>>   drivers/infiniband/ulp/iser/iscsi_iser.h     |  79 +----------
>>>>   drivers/infiniband/ulp/iser/iser_initiator.c |  19 ++-
>>>>   drivers/infiniband/ulp/iser/iser_memory.c    | 188 
>>>> ++-------------------------
>>>>   drivers/infiniband/ulp/iser/iser_verbs.c     | 126 +++---------------
>>>>   4 files changed, 40 insertions(+), 372 deletions(-)
>>> Can we do an extra step and remove FMR from srp too?
>> Which HCA's will be affected by removing FMR support? Or in other words,
>> when did (Mellanox) HCA's start supporting fast memory registration? I'm
>> asking this because there is a tradition in the Linux kernel not to
>> remove support for old hardware unless it is pretty sure that nobody is
>> using that hardware anymore.
> 
> ConnectX-3 and above supports fast memory registrations.

Which, to be clear, is FRWR, and different from FMR.

FMR is ancient and was a ConnectX-2 feature IIRC. It was basically
a proprietary firmware API implemented by directly stuffing commands
into the HCA. And as previously pointed out, insecure and fragile.

Honestly, I thought it was already removed!

Tom.
