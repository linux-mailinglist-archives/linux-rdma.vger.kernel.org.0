Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B079642843D
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Oct 2021 02:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhJKAJM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Oct 2021 20:09:12 -0400
Received: from out2.migadu.com ([188.165.223.204]:16994 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232748AbhJKAJL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 10 Oct 2021 20:09:11 -0400
Subject: Re: [PATCH 0/4] Do some cleanups
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1633910831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cn0T4NSraoEVStbLu7Zzyrp3JaRhKcuHq7srHQXHUy0=;
        b=OBR0uuC8Td0ZxFZjtLDYtkM3/9SFH8dPIMQallyN4pphplnn5JlVthtt+8z8LDPXtCSDrF
        nupSoFfYfFjlUZETzzeQ68NCZrw2X+GxWzPBEjokLHGVM1r7QiIUerskw+FU/yd55doYxd
        t7XhVbXGmOldfwcao7Kou3p7gYCAi6U=
To:     yanjun.zhu@linux.dev, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, leonro@nvidia.com
References: <20211010004110.3842-1-yanjun.zhu@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
Message-ID: <e26c6478-c425-ee5f-ac43-29d7b5123bcc@linux.dev>
Date:   Mon, 11 Oct 2021 08:07:04 +0800
MIME-Version: 1.0
In-Reply-To: <20211010004110.3842-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yanjun.zhu@linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ping

ÔÚ 2021/10/10 8:41, yanjun.zhu@linux.dev Ð´µÀ:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Some functions are not used. So these functions are removed.
> 
> Zhu Yanjun (4):
>    RDMA/irdma: compat the uk.c file
>    RDMA/irdma: compat the ctrl.c
>    RDMA/irdma: compat the utils.c file
>    RDMA/irdma: compat the file
> 
>   drivers/infiniband/hw/irdma/ctrl.c   | 38 -------------------
>   drivers/infiniband/hw/irdma/osdep.h  |  1 -
>   drivers/infiniband/hw/irdma/protos.h |  2 -
>   drivers/infiniband/hw/irdma/type.h   |  2 +-
>   drivers/infiniband/hw/irdma/uk.c     | 57 ----------------------------
>   drivers/infiniband/hw/irdma/user.h   |  4 +-
>   drivers/infiniband/hw/irdma/utils.c  | 45 ----------------------
>   7 files changed, 2 insertions(+), 147 deletions(-)
> 

