Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32908493BC4
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 15:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354927AbiASOM4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jan 2022 09:12:56 -0500
Received: from out2.migadu.com ([188.165.223.204]:47058 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354975AbiASOMz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Jan 2022 09:12:55 -0500
Message-ID: <d6551275-6d84-d117-dfa3-91956860ab05@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1642601574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lp0YiX4XAnR3JYOa2WileEvXJTtNolkFPU5QC6w/Asw=;
        b=c3WJIxpAbbjeNzberxhgL3y5hfOicLG44GTxpK++f+kTZ2KzaGBL0u1Mu94miAHWVveXLj
        3c29w+rQCdxyaMJLQZ6yggQGSMZR6j2xh6mKBYx3Muc1H4Du6Bmp+OImS6vFuEYTbL+VOC
        m9WqnBhB8c61cHjqnm5CPBfCtRG4xMI=
Date:   Wed, 19 Jan 2022 22:12:51 +0800
MIME-Version: 1.0
Subject: Re: rdma_rxe usage problem
To:     Alexander Kalentyev <comrad.karlovich@gmail.com>,
        linux-rdma@vger.kernel.org
References: <CABrV9Yt0HYenR_qk_QWFkvH4-0Ooeb61y+CyT3WVOnDiAmxjhA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <CABrV9Yt0HYenR_qk_QWFkvH4-0Ooeb61y+CyT3WVOnDiAmxjhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/1/19 19:42, Alexander Kalentyev 写道:
> I am trying to install and use soft RoCE for development purposes
> (right now on a localhost).
> I installed rdma-core on a MANJARO system from AUR.
> Then I did:
> 
> sudo modprobe rdma_rxe
> sudo rdma link add rxe0 type rxe netdev wlp60s0
> 
> then ibstat shows:
> CA 'rxe0'
>          CA type:
>          Number of ports: 1
>          Firmware version:
>          Hardware version:
>          Node GUID: 0x4a51c5fffef6e159
>          System image GUID: 0x4a51c5fffef6e159
>          Port 1:
>                  State: Active
>                  Physical state: LinkUp
>                  Rate: 2.5
>                  Base lid: 0
>                  LMC: 0
>                  SM lid: 0
>                  Capability mask: 0x00010000
>                  Port GUID: 0x4a51c5fffef6e159
>                  Link layer: Ethernet

Can rping work after you configured this test environment?

Zhu Yanjun

> 
> But launching any example I always get an error by call of: ibv_modify_qp
> with an attempt to modify QP state to RTR (for example by launching
> .ibv_rc_pingpong)
> The type of the error is EINVAL.
> I believe I miss something very obvious.

