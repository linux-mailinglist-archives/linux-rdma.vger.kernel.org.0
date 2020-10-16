Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E0C290CAF
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 22:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393583AbgJPUUw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 16:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393560AbgJPUUw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Oct 2020 16:20:52 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459A8C061755
        for <linux-rdma@vger.kernel.org>; Fri, 16 Oct 2020 13:20:52 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x62so3826586oix.11
        for <linux-rdma@vger.kernel.org>; Fri, 16 Oct 2020 13:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=DpDBHaCnPE9iNi1wuO/SnuI4HgFGy+3pXYI6vhxKx68=;
        b=ndZxeceXhtJCmyD6y75AVz7CWrIIAabtOLvBAorzvdrcl20G8atPjJ4Ic9FpfEmj25
         2kRegQR0l0Ir+hzVlUK/TCF13KWBqLfMPv5/ygZx+kEywIG9MSSNccapzVyKaL6eJBcf
         7IA3TUl+57ULsubD3f3FHlbUtt+PPj0izLPHE/iwWu0Uoi9IThOa8/xZopPvA23M31MM
         8k0lDtBlAmLYzRXkIBV6ahnD1qJxfz3VM89Hid4+Kv7MSbNNP4g37S07uT8XlIsmlsGF
         s0l5dwRlVjJoZCs6WHW5J6gh3UUxxMFkkukR2Bmis5DDRYka7rjW92f55nolVfj1q22w
         jQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=DpDBHaCnPE9iNi1wuO/SnuI4HgFGy+3pXYI6vhxKx68=;
        b=n1+wuQ55WYN27JE+RFhYA5IRQ0rnou3jMzz83jKRiRa9IRiID55kHAbQJhJL6ZiTsy
         irZUQdg8T57nCK+MySZkSkUc8/9RygZj8c4tpl5WDp67GFVxueXttXFgQvG6I5C92nma
         JefIG6EZWLvoB7wP1UVf6AuExBiGW0QaAplpTEzEp2ti7scJalWjgiCqRyrGqk9PaAoh
         uqB2wUbOLMcIG0Eb1o+kGnHLuK9xHzqKJt6T03ldkn2cJaC9th1bgTSmOnPR4F5ayPEZ
         AoipApfsymRsX6jWVmiWpWDrkLJU40KNPl3dO6AW28I9uAGO35BcqN7TkGM7X3sMYUkV
         wtaA==
X-Gm-Message-State: AOAM531JnWV6bBELSj7VJSSxab3R3qYAYgGk0PjvfAIJCg2tZseVHTdQ
        uuzrwsCoCzYMALbRWG8ojQAM8wbDuog=
X-Google-Smtp-Source: ABdhPJxOKfKSxu0UP9ax3eTubhPMgWbP6Xaw4duTfpKE7eE999uB+BcpVnOPpjW+xf8CVW9UIBUIug==
X-Received: by 2002:aca:ea42:: with SMTP id i63mr3555798oih.130.1602879651495;
        Fri, 16 Oct 2020 13:20:51 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:3929:4284:f7ac:4bbd? (2603-8081-140c-1a00-3929-4284-f7ac-4bbd.res6.spectrum.com. [2603:8081:140c:1a00:3929:4284:f7ac:4bbd])
        by smtp.gmail.com with ESMTPSA id x65sm1419019ooa.40.2020.10.16.13.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 13:20:51 -0700 (PDT)
To:     Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: Move the definitions for rxe_av.network_type to uAPI
Message-ID: <96dfe365-bd38-4022-8019-e337f168af47@gmail.com>
Date:   Fri, 16 Oct 2020 15:20:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Jason,

Your recent commit:

	commit e0d696d201dd5d31813787d9b61a42fc459eee89
	Author: Jason Gunthorpe <jgg@ziepe.ca>
	Date:   Thu Oct 15 20:42:18 2020 -0300

	RDMA/rxe: Move the definitions for rxe_av.network_type to uAPI

has some problems and so far I am having trouble making it work sensibly.

What you have done is to make the network_type field in rxe_av be private,
(i.e. RXE_NETWORK_TYPE_XXX instead of RDMA_NETWORK_XXX). You then defined these
private enums in rdma_uverbs_rxe.h. The problem is that there are more than one
source of AVs those:

	passed in user space send WQEs for UD traffic
	passed from kernel ULPs for UD traffic
	stored in the primary AV in QPs

The AVs created in the kernel get set by calling rdma_gid_attr_network_type()
which returns RDMA_NETWORK_XXX not RXE_NETWORK_TYPE_XXX. This can be fixed by
again making them the same, which you didn't do, but that means they really aren't
private. Or, we can explicitly translate between them in the AV init code.

No rush but I still think the right answer is to let user space only have to deal
with AHs and not AVs.

There was also a confusion between V6 and V4. I will submit a small patch that
fixes that and makes the enums the same again which is more efficient than transocding
them.

Bob
