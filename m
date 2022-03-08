Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62184D18A1
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Mar 2022 14:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343728AbiCHNFd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Mar 2022 08:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244887AbiCHNFc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Mar 2022 08:05:32 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E78EDEEE
        for <linux-rdma@vger.kernel.org>; Tue,  8 Mar 2022 05:04:36 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id b67so3838747qkc.6
        for <linux-rdma@vger.kernel.org>; Tue, 08 Mar 2022 05:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LOa31aKl+IloG4QyuACY6pyu5n3FcEycsN1xfiC4+BI=;
        b=D0DHlj0zc8ULATdkTpPPqnff3HS7j/EhDuzmLZ8jDzJlbE2vj1+Pop8NiCTk3wGgvl
         8cj1E5VJJLrWw9c4UaEbG1nzrPbpfGAwg7EQl/UwmctuQC61toUWYMMIPrIGPLhzb+t+
         ZFiLzBwARhtQbprQOB8SrVRS9OwNUO/EBOEQ+vPISZWquP7rZ+RTBgt7c686nC9WZJhx
         B1Q1q92bJFb03nVbC818pDbdJqEmTmK8g4+1v0in+mOQgDNiA8MUZPtZ0CBvym2Nw3/L
         EpuE5nMI88H+IkiuRDPflIZMix+DbivQ6vCEEtFdLNK/J+ucjb9PG64jTLtlk2ZcjZMx
         seSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LOa31aKl+IloG4QyuACY6pyu5n3FcEycsN1xfiC4+BI=;
        b=phOsSa0G/xb/ADSsgw4Y0ev8NFzji2n8SvgjQNhcZsG9l+L0thUEfd8inoywcHTn/6
         djLe28+QFV7Zijde2wyFOBk+PK7CwJXkpNUVdFz6L0n1iQMzJjwmrIKZsZnMlyRHaFgK
         yhnZ46GB039vk9MugfF4vDATQNEJf2pWvpM3+k3GOKwPqG3nDsPKi3YKatwsoXaTsFYE
         WrLNLhONuGwY/6WByFnx5SN57mdPk1MgH4YgmDLzLOu5QADArZsisDiRsQ7psQVC93PP
         YUBhwn1hkry0zzk3pbugWqtWZJB4IG4WGpL9V8LMhB0HPY6r1w8NF1ZzDziIj84JgWuJ
         nqGA==
X-Gm-Message-State: AOAM533SaRF4I4bKWQqrKLS6PgcAhLePJd6/4RveoyeUXLak56PL2AHk
        ALR29VFuqRhEerD6RU0mYWrmB4m6CEoZWPcCbI6k/NQMJ0Q=
X-Google-Smtp-Source: ABdhPJyV3h0a63UZpmjsoKDHmoP2VG41Kar292nMMsht9plWOyrTkWm3P6i7+xhDbXDd24aUM3AWxnE0n9oH25v495U=
X-Received: by 2002:a05:620a:198c:b0:662:e740:8de3 with SMTP id
 bm12-20020a05620a198c00b00662e7408de3mr10069648qkb.684.1646744675375; Tue, 08
 Mar 2022 05:04:35 -0800 (PST)
MIME-Version: 1.0
References: <CAOrWFD8Kb3R0OZ8A04QF4fPdMM6Xa_-sze0tLHboAJnz3SLivw@mail.gmail.com>
 <b612cd5a-b3ad-c8fb-cb01-32aeafbb9e7a@nvidia.com> <CAOrWFD_6dwzfjRJg7fh20B8K7_vbw7xQ+Lg7cGsAPwcOcevyoQ@mail.gmail.com>
 <4e6e1640-92be-20a3-758a-9f069146de0d@nvidia.com>
In-Reply-To: <4e6e1640-92be-20a3-758a-9f069146de0d@nvidia.com>
From:   Sylvain Didelot <didelot.sylvain@gmail.com>
Date:   Tue, 8 Mar 2022 14:04:24 +0100
Message-ID: <CAOrWFD__FJHi4Ybq-osqHE3WiL97u-BUGy2j8uDpnqvbrjjwVQ@mail.gmail.com>
Subject: Re: [Question] Is address format "gid" supported by RDMACM with RoCE?
To:     Mark Zhang <markzhang@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks for your answers, Mark.

The Nvidia documentation[1] states the following: "RoCE has two
addressing modes: MAC based GIDs, and IP address based GIDs."
Do you know which address family (AF_*) should be used to establish
connection with MAC based GIDs?
Is there an example or some documentation somewhere?

I can fix ucmatose myself, but I have no idea what's missing exactly.

[1]: https://docs.nvidia.com/networking/pages/viewpage.action?pageId=15046549

On Tue, Mar 8, 2022 at 1:43 PM Mark Zhang <markzhang@nvidia.com> wrote:
>
> On 3/8/2022 6:54 PM, Sylvain Didelot wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > Does it mean that RoCE always requires the network interface to have
> > an IP address as it cannot use the GID to establish connections?
> >
>
> I think it's just a ucmatose limitation..
>
> > On Tue, Mar 8, 2022 at 11:49 AM Mark Zhang <markzhang@nvidia.com> wrote:
> >>
> >> On 3/7/2022 9:57 PM, Sylvain Didelot wrote:
> >>> External email: Use caution opening links or attachments
> >>>
> >>>
> >>> Hi,
> >>>
> >>> I have configured one of my Mellanox network adapters for RoCE:
> >>> ---
> >>> CA 'roceP1p1s0f1'
> >>>       CA type: MT4123
> >>>       Number of ports: 1
> >>>       Firmware version: 20.32.1010
> >>>       Hardware version: 0
> >>>       Node GUID: 0xb8cef603002d1707
> >>>       System image GUID: 0xb8cef603002d1706
> >>>       Port 1:
> >>>           State: Active
> >>>           Physical state: LinkUp
> >>>           Rate: 100
> >>>           Base lid: 0
> >>>           LMC: 0
> >>>           SM lid: 0
> >>>           Capability mask: 0x00010000
> >>>           Port GUID: 0xbacef6fffe2d1707
> >>>           Link layer: Ethernet
> >>> ---
> >>>
> >>> The Infiniband stack was installed from the official Ubuntu repository
> >>> (20.04.4 LTS):
> >>> ---
> >>> $ apt search ibverbs
> >>> Sorting... Done
> >>> Full Text Search... Done
> >>> ibverbs-providers/focal,now 28.0-1ubuntu1 arm64 [installed]
> >>>     User space provider drivers for libibverbs
> >>>
> >>> ibverbs-utils/focal,now 28.0-1ubuntu1 arm64 [installed]
> >>>     Examples for the libibverbs library
> >>>
> >>> libibverbs-dev/focal,now 28.0-1ubuntu1 arm64 [installed]
> >>>     Development files for the libibverbs library
> >>>
> >>> libibverbs1/focal,now 28.0-1ubuntu1 arm64 [installed]
> >>>     Library for direct userspace use of RDMA (InfiniBand/iWARP)
> >>>
> >>> librdmacm-dev/focal,now 28.0-1ubuntu1 arm64 [installed]
> >>>     Development files for the librdmacm library
> >>>
> >>> librdmacm1/focal,now 28.0-1ubuntu1 arm64 [installed]
> >>>     Library for managing RDMA connections
> >>>
> >>> rdmacm-utils/focal,now 28.0-1ubuntu1 arm64 [installed]
> >>>     Examples for the librdmacm library
> >>> ---
> >>>
> >>> When I start the ucmatose server with the address format "gid", the
> >>> tool fails binding with the error "No such device"
> >>>
> >>> Here is an example of the output:
> >>> ---
> >>> $ cat /sys/class/infiniband/roceP1p1s0f1/ports/1/gids/0
> >>> fe80:0000:0000:0000:bace:f6ff:fe2d:1707
> >>>
> >>> $ ucmatose -b fe80:0000:0000:0000:bace:f6ff:fe2d:1707 -P ib -f gid
> >>> cmatose: starting server
> >>> cmatose: bind address failed: No such device
> >>> test complete
> >>> return status -1
> >>> ---
> >>>
> >>> Does rdmacm support connection establishment using GID with RoCE? Or
> >>> Is it a known limitation for RoCE?
> >>> FYI, the same experiment without RoCE (Link layer: Infiniband) works perfectly.
> >>>
> >>> Thanks for your help and your feedback.
> >>>
> >>> Sylvain Didelot
> >>
> >> I think ucmatose doesn't support RoCE when using "-f gid", as in this
> >> case ai_family is set to AF_IB.
>
