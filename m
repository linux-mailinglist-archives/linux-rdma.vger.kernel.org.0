Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B26248C482
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jan 2022 14:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353407AbiALNNg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jan 2022 08:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353454AbiALNMo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jan 2022 08:12:44 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741A2C06175E
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jan 2022 05:12:44 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c19so2913059qtx.3
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jan 2022 05:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5AixT1u0DFbgGLsjAIQY4As80hr22iv0pFnHw3t2ouQ=;
        b=JylVxGEZ9RahFuhQ8+qXMf8FutoJor3hOfEsgDMD/zv3tehovHJrGRL8YIBIafsYYU
         3NchQ5Fgw7oxSfJ48AP8uOFExtARK+8zlGW5kjK3u9cOgslXRQknHd7Us5O7n92fYVhQ
         /8x3JAFFIPssT7+VQPYIQPFkmxoE7Uc1Qbb7O2kUPkbQ/wYW/jNQz7IV/UHG1H2beYLy
         BS7DXJhSeOJk6QCAnR4zbJg3wCp0YcuGeJHwfzFx6qAQq9h7fmkmERWdYbP9pezNhOA7
         Lm7K75wkuBhryjbhxultvi+RAaVT5Idq9M2C8FpqbyIKbYFLfRLmlbIVkDJ6UDA1M9SR
         Y+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5AixT1u0DFbgGLsjAIQY4As80hr22iv0pFnHw3t2ouQ=;
        b=aw8I0Iqb9zRGsswAtVEezx3phpR0A/Fp6oPdTe8kypI4keEM+pcY0ItJCtoN+jqab0
         aewkZbKSgM1tdpBk5AwOnk0ZENrhQ8+zE3cOTGdrq4x7xLUd2fMoGXgG7F6L53nweQZ5
         W3QhJ/bUfA8HiXRrT9G46sa6/xqHJnQI7uz+8OpofBCYDMbE9z88wRgWnaTg0nDAokJQ
         fpmYjJqi91WTlVQ58F2/uVNwGcxeBf5UKjsm0Fmy3AN1Auci3qugnGCeJGEdj7wGjUDK
         oGkaG1Ct5xxNjZbnNL8b1MtycMY+E2mUYuQS7xpNjnceQGKk6rJTe4Jw6L8PvyfAgsny
         rBdg==
X-Gm-Message-State: AOAM531Zln1eXKuxlo78GmIMxQjl/fVjjBFFp2OmzIqbyouoA1X69+W9
        +IHO9G93gZ5bUs91NOURpE3VGw==
X-Google-Smtp-Source: ABdhPJw9AM5y2mHvX9TMDhFjQIFE16cy7sHvlQa1GsGTg8oO4XKLig5keQ9bfGyvel/eu0AdnKHDig==
X-Received: by 2002:ac8:5cc1:: with SMTP id s1mr7611444qta.220.1641993163618;
        Wed, 12 Jan 2022 05:12:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id h1sm8567920qta.54.2022.01.12.05.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 05:12:42 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n7dQg-00F1pc-Bb; Wed, 12 Jan 2022 09:12:42 -0400
Date:   Wed, 12 Jan 2022 09:12:42 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Message-ID: <20220112131242.GL6467@ziepe.ca>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
 <20220106002804.GS6467@ziepe.ca>
 <347eb51d-6b0c-75fb-e27f-6bf4969125fe@fujitsu.com>
 <20220106173346.GU6467@ziepe.ca>
 <daa77a81-a518-0ba1-650c-faaaef33c1ea@fujitsu.com>
 <20220110143419.GF6467@ziepe.ca>
 <56234596-cb7d-bdb2-fcfd-f1fe0f25c3e3@fujitsu.com>
 <20220111204826.GK6467@ziepe.ca>
 <f980d32d-85b7-87b5-750f-aaa728d811c8@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f980d32d-85b7-87b5-750f-aaa728d811c8@fujitsu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 12, 2022 at 09:50:38AM +0000, lizhijian@fujitsu.com wrote:
> 
> 
> On 12/01/2022 04:48, Jason Gunthorpe wrote:
> > On Tue, Jan 11, 2022 at 05:34:36AM +0000, lizhijian@fujitsu.com wrote:
> >
> >> Yes, that's true. that's because only pmem has ability to persist data.
> >> So do you mean we don't need to prevent user to create/register a persistent
> >> access flag to a non-pmem MR? it would be a bit confusing if so.
> > Since these extensions seem to have a mode that is unrelated to
> > persistent memory,
> I can only agree with part of them, since the extensions also say that:
> 
> oA19-1: Responder shall successfully respond on FLUSH operation only
> after providing the placement guarantees, as specified in the packet, of
> preceding memory updates (for example: RDMA WRITE, Atomics and
> ATOMIC WRITE) towards the memory region.
> 
> it mentions *shall successfully respond on FLUSH operation only
> after providing the placement guarantees*. If users request a
> persistent placement to a non-pmem MR without errors,  from view
> of the users, they will think of their request had been *successfully responded*
> that doesn't reflect the true(data was persisted).

The "placement guarentees" should obviously be variable depending on
the type of memory being targeted.

> Further more, If we have a checking during the new MR creating/registering,
> user who registers this MR can know if the target MR supports persistent access flag.
> Then they can tell this information to the request side so that request side can
> request a valid placement type later. that is similar behavior with current librpma.

Then you can't use ATOMIC_WRITE with non-nvdimm memory, which is
nonsense

Jason
