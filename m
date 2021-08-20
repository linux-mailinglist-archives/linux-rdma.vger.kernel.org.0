Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAE93F283A
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 10:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhHTITX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Aug 2021 04:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhHTITX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Aug 2021 04:19:23 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062EFC061575
        for <linux-rdma@vger.kernel.org>; Fri, 20 Aug 2021 01:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Date:Message-ID:From:Cc:To;
        bh=9IAoHeckOfIOha7q9HqUcRYkSqUZ1nRcC4lKyJtQTW0=; b=FP38ff2qnCsQ4QJY8LlFkU6qoE
        Um/m2H93zw7ZVG1S98RxdNDyzB27pbpGW6aTM+oXnEoMAUGLTq7lX2GZZpssiV0GJm+8D4aSazGz9
        yN7kU/NYiDaVGM4s1k8zSDqBHQf4+ZFKFjDQnu9L16UvPyn7y6+DHkvleCc09WSQ+5cm+2+H0c5lW
        ik3P+J0FPCspCFe25bY8MBAoN2aLgUiUsVf4uh0Do3ogcZx1eBQuDhwzjBM+3Scu7Hm4V01PaY6rC
        xHwTRgleajLT1Xv7UPB9yz4ToC3dr5cW1+SFrmxFoc4V/uJ4NVEeaZy4gw1G79RHhz+QDSTBc8Jq/
        3t5DCQROJNHoFNAnxF7FBjiRmOqzSSyOOyZmeHFzuQAMet982waajHnv7YaDus7aLOMJdH/kcWYjC
        TU0ROQOm4xohg0GWuNd0wuEAUjT3iy62aD57k4tZehrQHj82jXf9l+59x485oE2jsTPEgNLP6Xke8
        D8YBOZ1vaw8wZwkyWJnxZixK;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1mGzjc-002CcR-2t; Fri, 20 Aug 2021 08:18:40 +0000
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Linux RDMA <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Cc:     kaike.wan@intel.com
References: <04bdb0a7-4161-6ace-26d0-c3498327d28c@cornelisnetworks.com>
From:   Stefan Metzmacher <metze@samba.org>
Subject: Re: [RFC] bulk zero copy transport
Message-ID: <c40e7056-e903-623c-8413-67f5d63246e7@samba.org>
Date:   Fri, 20 Aug 2021 10:18:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <04bdb0a7-4161-6ace-26d0-c3498327d28c@cornelisnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Dennis,

just as a wild idea, would be an option to use the SMB-Direct [1] protocol defined here?

It basically provides a stream/packet like transport based on IB_WR_SEND[_WITH_INV]
and in addition it allows direct memory transfers with IB_WR_RDMA_READ or IB_WR_RDMA_WRITE.

It's called SMB-Direct as it's currently used as a transport for the SMB3 protocol,
but it could also be used as transport for other things.

Over the last years I've been working on a PF_SMBDIRECT socket driver [2]
as a hobby project in order to support it for Samba. It's not yet production ready
and has known memory leaks, but the basics already work. The api [3] is based on
sendmsg/recvmsg with using MSG_OOB with msg->msg_control for direct memory transfers.
I'll actually use it with IORING_OP_SENDMSG and IORING_OP_RECVMSG, which allow msg->msg_control
starting 5.12 kernels.

metze

[1] https://winprotocoldoc.blob.core.windows.net/productionwindowsarchives/MS-SMBD/%5bMS-SMBD%5d.pdf
[2] https://git.samba.org/?p=metze/linux/smbdirect.git;a=summary
[3] https://git.samba.org/?p=metze/linux/smbdirect.git;a=blob;f=smbdirect.h;hb=refs/heads/smbdirect-work-in-progress


Am 19.08.21 um 21:09 schrieb Dennis Dalessandro:

> Just wanted to float an idea we are thinking about. It builds on the basic idea
> of what Intel submitted as their RV module [1]. This however does things a bit
> differently and is really all about bulk zero-copy using the kernel. It is a new
> ULP.
> 
> The major differences are that there will be no new cdev needed. We will make
> use of the existing HFI1 cdev where an FD is needed. We also propose to make use
> of IO-Uring (hence needing FD) to get requests into the kernel. The idea will be
> to not share Uverbs objects with the kernel. The kernel will maintain
> ownership of the qp, pd, mr, cq, etc.
> 
> Connections we envision to be maintained by the kernel using RDMA CM. Similar in
> fashion to how RDS or IPoIB works. This of course means an RC QP which allows
> our TID RDMA feature to work under the hood.
> 
> We have looked into RDS and RTRS and both seem to be the wrong interface. RDS
> provides a lot of what we are looking for but it seems to be a bit overkill and
> has higher overhead than we hope to achieve. Performance results show it to be
> less performant than direct to verbs.
> 
> After reviewing the RV submission, I don't think there is any reason to try to
> revamp that submission. It seems to be very tightly tied to PSM3 whereas this is
> meant to be more generic.
> 
> At this point we are interested in what questions you would have or opinions. We
> would like to get some feedback early in the process. As we develop the code
> we'll continue to post, similar to how we did rdmavt and welcome anyone that
> wants to collaborate.
> 
> [1] https://lore.kernel.org/linux-rdma/20210319125635.34492-1-kaike.wan@intel.com/
> 
> -Denny
> 

