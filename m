Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F99D37593F
	for <lists+linux-rdma@lfdr.de>; Thu,  6 May 2021 19:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbhEFR1R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 13:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbhEFR1R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 13:27:17 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0233EC061574
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 10:26:18 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j10so8854108lfb.12
        for <linux-rdma@vger.kernel.org>; Thu, 06 May 2021 10:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ebvIFlQHcVQAJ6xuOuWoUspYsdOb57lOKNliEZ3X4zs=;
        b=e6J3Ds0haojr3IxEm4Qe4/3/T9dHhiPUyBHCcTra5+1tUd/buHkhbsfLek0pcMri4i
         b7Uedz3FRSFauJKUyIk/ZTXO30oJ2rRBIqDiwFyc+h+f8E4KMdRpEiGL//7d+eUJSqAx
         tV4GS4d+Jyfj5VIYh2nUeVxoCcBhNI1f+7UNdP4PqzO8fsHinJSDCMUmammanh8YZZTe
         XRdP8Pp6Vldd2NN9OL74i5gHtgdFs7aE1FmX4ZbcNtDtVehaS2XfoKJAVioTJ5STWMNP
         B2epitact/qY7RZpTU1wAvDYlPz/TeNPiiQY3NtdJm8uHNmMkWLn0SPkw/uR+zOwWYwt
         qcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ebvIFlQHcVQAJ6xuOuWoUspYsdOb57lOKNliEZ3X4zs=;
        b=cT3kJZ1YaLrUcnlr0cDwYUCQNaT5045eqZ+uZCoZO55Hc7Cob632VSijVqoMDH8mjP
         8BaN9+zhWfyg0VC/RUaLvUMYl8w+z4hWHAZWLaYkzkS3tkUwS3qrVlhUCMmgOJaGy5ii
         cNHgrd9k0HMRmKyJb7cvkQULePVJsegqH59LVDi0/cC9N0xGRXDHFcMUXfiZOsUVh7dP
         g+pgQwFLeTWj3mbJp7Ib08TfdWXoPZ4V0+iD8vrEPq9kqGEXXrcSna/GBCEBjkFwDube
         +ZakgHCevT6JmHF5Iw7udNtUlZNYI4/on3YTxiz+Cm9fAWpR1QzhsJ1O8FMWee/0Ud/+
         GjEQ==
X-Gm-Message-State: AOAM531LcevSYQhqqI4SBuYvkU8++uhRRf0icgbXuPVmqo85jkq6BNLs
        lzlwgxyznoR36ytuauSihwaMBsWYkRweQUSUhKRiamzRPT+Lrg==
X-Google-Smtp-Source: ABdhPJxOrJ7Kqw1qmyMYLvKsrMPDKUE7QSQys7v3kHHz85W4ihhwx0i63Lm76ANoOAXqme1XT2DavK2M3LL3vh8qVW4=
X-Received: by 2002:ac2:4106:: with SMTP id b6mr3638200lfi.27.1620321976263;
 Thu, 06 May 2021 10:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <CALmWCACoz8vG9=ofcKG6biFju1+OWkmTKkSWS3Ln5Hvx-LS_CQ@mail.gmail.com>
In-Reply-To: <CALmWCACoz8vG9=ofcKG6biFju1+OWkmTKkSWS3Ln5Hvx-LS_CQ@mail.gmail.com>
From:   Badalian Vyacheslav <slavon.net@gmail.com>
Date:   Thu, 6 May 2021 20:26:04 +0300
Message-ID: <CALmWCAAAxu0FVOrSwOJyc6v-pSERGRcvEh1a1ZYm0fHjcpY67Q@mail.gmail.com>
Subject: Re: MLX4 SRIOV mtu issue
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello all

Have connect X-3 with
probe_vf=0,0 num_vfs=16,16 port_type_array=2,1

If mtu=5 in partition IB interface can't start (NO CARRIER, Can't join
multicast, Error -22).
If change to mtu=4 all done but i use 4k mtu in all IB networks. How
to fix this?
