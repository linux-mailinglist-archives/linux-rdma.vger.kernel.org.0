Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC87848AFCA
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jan 2022 15:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242459AbiAKOmd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jan 2022 09:42:33 -0500
Received: from out0.migadu.com ([94.23.1.103]:11073 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242427AbiAKOmc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jan 2022 09:42:32 -0500
Message-ID: <9e75da26-1339-36d4-1e30-83046b53e138@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1641912143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9nq/yyQ+7hnMK8LGvU02G0WvU78Pv+znnsJIno5jM8=;
        b=EGm4c+4f9dpHStKH3Uf5Y+wtctYh08FotNWKckDNtNu0teBebhQdPimCWUY32tFBj0JaDX
        /BBCYObSn8tHEAXt3vvAyfzvjO/DbZ6y+WJAaVrc9vVVRSCmD+othzgzutkr8Da5T1h/tK
        PI3g7u6soXf3bo5Dy68tORPmLqW1bJE=
Date:   Tue, 11 Jan 2022 22:42:12 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Check the last packet by RXE_END_MASK
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "david.marchand@6wind.com" <david.marchand@6wind.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
References: <20211229034438.1854908-1-yangx.jy@fujitsu.com>
 <20220106004005.GA2913243@nvidia.com>
 <2e708b1d-10d3-51ba-5da9-b05121e2cd89@linux.dev>
 <61DBC15E.5000402@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <61DBC15E.5000402@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/1/10 13:17, yangx.jy@fujitsu.com 写道:
> On 2022/1/7 19:49, Yanjun Zhu wrote:
>> It seems that it does not mean to check the last packet. It means that
>> it receives a MSN response.
> Hi Yanjun,
>
> Checking the last packet is a way to indicate that responder has
> completed an entire request(including multiple packets) and then
> increases a msn.

Hi, Xiao

What does the msn mean?

Thanks a lot.

Zhu Yanjun

>
> Best Regards,
> Xiao Yang
