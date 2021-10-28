Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8A243E439
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Oct 2021 16:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhJ1Ova (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Oct 2021 10:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhJ1OvY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Oct 2021 10:51:24 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE98C061767
        for <linux-rdma@vger.kernel.org>; Thu, 28 Oct 2021 07:48:57 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id s19so11123752ljj.11
        for <linux-rdma@vger.kernel.org>; Thu, 28 Oct 2021 07:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=bQYOKWP1C7Rd4HcGekbbE4bThlPYrIF1N8BjxdF9KQc=;
        b=ftNfZ7CqT6i/brHYoL9DweGDPyRZfdLEvywvA/Ok+K5n1dgZeq1WlGM69BpPBM4wE4
         k72EG5KGIj7VyJcVV6D3ZYNBAyj6sV7C8kKLhVCc83SWfSxnAQrrmjtw/cs6EDMucH2a
         kSmOltHtVQF0ApLEcgUQ+qxZmF+fD6NcMGyg0t+ga+/S+hraeixzAOvebkdBHknUVC0q
         Wua6j8BcplO0BFDyaLt/yZgAra0YrEit0JcNXD0tmNM0WmdzIbNx5JjZUKycEI+hIcwO
         J3kMsU2UBBy4seKugAhYUKWTo7O50Jmt86PMlrGKKpIZGpUhRM8zjbNdJ8Gbq2cxBEoM
         s1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bQYOKWP1C7Rd4HcGekbbE4bThlPYrIF1N8BjxdF9KQc=;
        b=elMDDLp8uZXRWMZqKkUg8AAxAMh48SqsT53tN6Pwm6QOLZ1BqDhrBmY0XlbRmlz0/V
         X9ZpShuHNdEbIBBoS3GNeHgGRMGqi74aAIPqzYPk8yy6rcWyEF8fq8z8ZVyUIKKODYlv
         GWlsOY9Kff6hFiGza8gLLURRanJJhEQBahgmdefpLYwkqWRpxs4ZcEsqE/R7V0iS3vbe
         6+X6L8gV2x7v4k1lZ5EoIs6dIMSy1g/KjsUsAGMVNDIGcQPpyYmeEepSuiZMNvyUvSdP
         6gByi9nTm0E725bzMtnROAWzd1s0aZhdF5NAnbnQzbMnq3lfrMEx3B5SUyxn1IFzPMB1
         VNTQ==
X-Gm-Message-State: AOAM531jpRvmV1xj9TcMCnA2XmsSXi/zybeDkGiSwj4RWbrPqemnv02b
        u36mww1pvumh0/4/RATEzBs1i3ivHM83ocvKhO9NwphD5kfB4w==
X-Google-Smtp-Source: ABdhPJz9tUwstdMSnZiZZq6p9+Xe8MkBMUSlLz1PDSkjsSIJZrXi7U/CvpmuyjHqc5NHIjxKdzCtlcP/XumlyYYBlpA=
X-Received: by 2002:a05:651c:10b1:: with SMTP id k17mr5156634ljn.243.1635432535117;
 Thu, 28 Oct 2021 07:48:55 -0700 (PDT)
MIME-Version: 1.0
From:   Venkata Ramana Boinipelli <venkataramana.boinipelli@ionos.com>
Date:   Thu, 28 Oct 2021 16:48:44 +0200
Message-ID: <CAKxXbW5KX=SGg0Bj5qBOF3LoH1wjFz=EPX3JNrc0O6wGgWjr1g@mail.gmail.com>
Subject: Opensm crash 3.3.21
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Dear Developers

We are  experiencing opensm (V 3.3.21 ) crash from time to time on
debian hosts, our developers suspect that it's something at lash
algorithm, Please can you advise a fix here.

Also we are using m_key Protection feature ,

short info from crash report

Signal: 11
SourcePackage: opensm
Stacktrace:
 #0 0x00005636f04835a9 in get_next_switch (p_lash=0x1, link=<optimized
out>, sw=0) at osm_ucast_lash.c:337
 No locals.
 #1 generate_cdg_for_sp (p_lash=p_lash@entry=0x5636f0eef0b0,
sw=sw@entry=0, dest_switch=dest_switch@entry=1, lane=lane@entry=0) a
t osm_ucast_lash.c:337
        num_switches = 13
        switches = 0x7f501c2a7d20
        cdg_vertex_matrix = 0x7f501c2d0e00
        next_switch = <optimized out>
        output_link = <optimized out>
        j = <optimized out>
        exists = <optimized out>
        v = <optimized out>
        prev = 0x0

 #2 0x00005636f0484aa8 in lash_core (p_lash=<optimized out>) at
osm_ucast_lash.c:842
        lanes_needed = 1
        k = <optimized out>
        dest_switch = 1
        output_link = <optimized out>
        cycle_found2 = <optimized out>
        num_switches = <optimized out>
        switches = <optimized out>
        output_link2 = <optimized out>

attached is a crash dump and opensm conf for your reference.


Please advise here with a possible solution, help much appreciated.


Thank you in advance

Best Regards
Ram Boinipelli
