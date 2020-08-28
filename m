Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522DD25623B
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Aug 2020 22:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgH1Usx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Aug 2020 16:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgH1Usv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Aug 2020 16:48:51 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD65C061264
        for <linux-rdma@vger.kernel.org>; Fri, 28 Aug 2020 13:48:51 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id j16so60164ooc.7
        for <linux-rdma@vger.kernel.org>; Fri, 28 Aug 2020 13:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JvL5NaWHZfMYOf9MtlaVDd2osfTd36Htl2Ik5AoPm+w=;
        b=iYqQb0cVlMQqlCEW03FwWSG8gT5UGZGTy4XinJ6F/A0qvilV40r/2ouAHNptcDQTxw
         HSHi7gMlBnzENI5KQXwZ8q00hOvmQVZc+ubu2LpvY2TDCjyOFaYWeazKXFB0w9IbgwjE
         A8sG4GAfG35VDj4VXGr4B1FfO1fCLw1t+uLwIElRYxBwIKRijx5xvgYwMP3nkyk16kBq
         GviraK+Yc4uKw8nEmeBo9vFDuLTl1LO/xiWUy5IMqEcJ12X95DRWuFEyzNEKPrIIpUO5
         F9tJgnbzrNfiaanXGYAFhMZJFHdpNEOT5//fBVHm1CJy2XFJUva+chTGQAw0gKfNAoCI
         We2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JvL5NaWHZfMYOf9MtlaVDd2osfTd36Htl2Ik5AoPm+w=;
        b=Q/oAyTrjgQL3g8q1z01com1ZYFIvQeGSm84Z5gkMdjVTOPAdy+w1MH63Qy8QCNxnWS
         hZ/4DPeENfSpmY3yyMZ8gh+5Ma19C5BZjxzAMzy8vs1Os08BYQGgEGwOf10QeN3Vsgxf
         /472eiZ5eNDRGPOsivM2geTOh6tBJ4NlmHvOGtEawutK/hjm+hzOwTT4whBLLadhgpfa
         aKsukVe1Wy2cnLrL13nnRYxMTpATCXHK7RgkVkDfCbxPbkfuyl/wFSkzMUOPxhGCxAFk
         fFTxlRPCP8uSu0PjW6xT/9Xx5kI7XdhQJQEwvxjDUh1F1C/SLHoRtxErqNmc7698rVT3
         2dJw==
X-Gm-Message-State: AOAM530+o/8Z0CymI1kVkRThgwdPDWlwU7mYteprJTTMkMMhqUAhu0EX
        imBblvsB/nbfbMiWAKTNSelrzEQaZcYunA==
X-Google-Smtp-Source: ABdhPJwNnZ4H7KBjYghmsvHOypRhB9Z6U0P6gjRcCQzOAhntLzBuw8ajhnrvZesygPxf33K6pkG0Fw==
X-Received: by 2002:a4a:9cd6:: with SMTP id d22mr341607ook.0.1598647729615;
        Fri, 28 Aug 2020 13:48:49 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:f026:647f:55bb:7c0f? ([2605:6000:8b03:f000:f026:647f:55bb:7c0f])
        by smtp.gmail.com with ESMTPSA id 40sm119435otj.76.2020.08.28.13.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 13:48:49 -0700 (PDT)
Subject: Re: pyverbs failures
To:     Jason Gunthorpe <jgg@nvidia.com>, Parav Pandit <parav@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
References: <0c4cef74-21bf-19b5-1523-6fffa450e764@gmail.com>
 <20200828184458.GS1152540@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <3c88c04f-e9ad-2d13-2fd0-59f9756dfaab@gmail.com>
Date:   Fri, 28 Aug 2020 15:48:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828184458.GS1152540@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/28/20 1:44 PM, Jason Gunthorpe wrote:
> On Fri, Aug 28, 2020 at 11:51:07AM -0500, Bob Pearson wrote:
> 
>> I have been trying to reduce the number of test failures in the
>> pyverbs tests for the rxe driver. There is one class of these errors
>> that seems to be potentially a design failure in rdma core. By
>> default each time a new RoCE device is registered the core sets up a
>> gid table in cache.c and populates the first gid entry with the
>> eui64 version of the IPV6 link local address. Later the other IP
>> addresses configured on each port are added as well. It is expected
>> that the default entry with sgid_index = 0 will function as a valid
>> source address. Five years ago this probably always worked but more
>> modern OSes have stopped using this address for privacy
>> reasons. Ubuntu 20.04 which is the one I am working on uses a pseudo
>> random address and not the MAC based one. Windows and IOS also
>> apparently no longer use this address. The result is that the
>> pyverbs test cases which use sgid_index = 0 in some cases, and use
>> random sgid_indices including 0 in others, fail. The most common
>> failure symptom is that when attempting to add a remote address to a
>> QP (INIT -> RTR) it is unable to contact the invalid address and it
>> times out.
> 
> The RoCEv1 GID is formed as you described above, is rxe triggering
> some RoCEv1 support that it can't handle?
> 
>> A better choice for the default GID for RoCEv2 devices may be to
>> just use the IPV6 address configured as the link local address for
>> the ndev. If they use the eui64 address the result will be the
>> same. At least some of these OSes claim that the link local address
>> is temporary, changing periodically. This would require tracking
>> IPV6.
> 
> Certainly RoCEv2 devices shouldn't have GIDs that are not matching
> their IP addresses. Otherwise it would malform a UDP header.
> 
> Maybe Parav remebers if there is some tricky reason why this is still
> being done?
> 
> Jason
> 
rxe does not support RoCEv1. If you look at the /sys/class/infiniband/<rxe_0>/ports/1/gid_attrs/types/0 (and all the rest as well) the type is RoCE v2. If you look at mlx5 devices they have two gids for each address one with RoCE v1 and one with RoCEv2, but they also get the 'bad' address. The code is straight forward and not sensitive to v1 or v2. It just builds the eui64 gid for gid_index = 0.
