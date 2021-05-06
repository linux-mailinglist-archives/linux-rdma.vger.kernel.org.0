Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4B2375D62
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhEFX1j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhEFX1h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:27:37 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1397C061761
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:26:38 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a36so9211856ljq.8
        for <linux-rdma@vger.kernel.org>; Thu, 06 May 2021 16:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Xp9dYjhe/Vcf/1U9K6J7f8gATNxIqHK6R23defdkMSM=;
        b=CMqSvW/TVolV1UzwC+ubVuZuHGlvmz2sBEOTinx8ew6GoJMoO+GK7ZKgyX7Jj/7XuP
         Y6zFS7Yf+jBTMbSvSebkGMfYvxnzirfIWThF138zxVeum0dGGlmtXSvXNDpCy+sRFgoz
         z3WXLyFi0jbP7O1NVdZ2RozrN/l3Taf+GOjiLtpNhg/QlHaS/jusBc9liGQSHjJskiSH
         0e1Ah33KMJH43DAeMXhBHZe3iSmlestTBWjoAemUqpq4JZCrWJiu2hVOkAbnURVziuqu
         2ka8DBaA5mnnQ6wsr8Urw9LaobNxcnYJ6KdTgf6/tT7RAeOvqhlfPjnQonxotr/tlut4
         I67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Xp9dYjhe/Vcf/1U9K6J7f8gATNxIqHK6R23defdkMSM=;
        b=LK2Lb+CFQSrA2yEA0ukQ3jCQNpkUJlauROX5dyGH7nENESzhH28aocro0qN+TpYzU5
         vJP/jEVZCoxATtM3fhuRyG/D4S8r8mgMIVx+5p/KwubMVecg0ElmLqxM2HOxC0e3WVlJ
         Q6Rm/Po4+sZ6xG8sSL6efaCN8EokoT696m1U1bNFM9wboK/lltmlAzmE13nH18egjpY/
         sfIIq3WdRCRXO5BliylemMnhqcP/uFpGTGZU7gvm0evVG1q2pwqzxgHF5pf/OA5llkl0
         eOVJ5sw7Kdz9ovzV83dZBrwz8ceP9YghQJNSWYTaQASS4lfa+pxpEEztAdJXz/r+Q0b4
         Alkw==
X-Gm-Message-State: AOAM530Ei8QfcdWf3o6TU2y2mtVjX/eKyAnzQIFoMW5EAfPxcTvSdl9w
        QDWW9P48BlpHCbUYAGUT7iJThxqXMnQE+HfyzmR46SHXwI8=
X-Google-Smtp-Source: ABdhPJzuHQCGXg7G39NBm/WzYGyV/YT6Is8KhJxwydTe0/zBr8GBtfEIiuN0PuUChHrCSugrIj+XGeSAS9GfEPrsXtA=
X-Received: by 2002:a2e:2245:: with SMTP id i66mr5342744lji.118.1620343597100;
 Thu, 06 May 2021 16:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <CALmWCACoz8vG9=ofcKG6biFju1+OWkmTKkSWS3Ln5Hvx-LS_CQ@mail.gmail.com>
 <CALmWCAAAxu0FVOrSwOJyc6v-pSERGRcvEh1a1ZYm0fHjcpY67Q@mail.gmail.com>
In-Reply-To: <CALmWCAAAxu0FVOrSwOJyc6v-pSERGRcvEh1a1ZYm0fHjcpY67Q@mail.gmail.com>
From:   Badalian Vyacheslav <slavon.net@gmail.com>
Date:   Fri, 7 May 2021 02:26:25 +0300
Message-ID: <CALmWCACBskRhbQU0pYMBB6fxB4x5=_mVcyUMjFPdHOELq9rWNQ@mail.gmail.com>
Subject: Re: MLX4 SRIOV mtu issue
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Sorry.
Host info -
Centos 8 Stream. Last updates. Kernel ML 5.12.1. Use kernel.org mlx4
driver (don't use Mellanox modules). rdma-core 32.0-4

=D1=87=D1=82, 6 =D0=BC=D0=B0=D1=8F 2021 =D0=B3. =D0=B2 20:26, Badalian Vyac=
heslav <slavon.net@gmail.com>:
>
> Hello all
>
> Have connect X-3 with
> probe_vf=3D0,0 num_vfs=3D16,16 port_type_array=3D2,1
>
> If mtu=3D5 in partition IB interface can't start (NO CARRIER, Can't join
> multicast, Error -22).
> If change to mtu=3D4 all done but i use 4k mtu in all IB networks. How
> to fix this?
